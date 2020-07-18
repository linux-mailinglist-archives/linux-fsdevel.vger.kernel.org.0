Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4155F224782
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jul 2020 02:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgGRAmH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 20:42:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbgGRAmG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 20:42:06 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD49D20759;
        Sat, 18 Jul 2020 00:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595032925;
        bh=/1rAyGat83oAOmSiVA4ydtrSEo9zRVg0c/t7EMZcIdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mYkgYxgsdHKRmYVlDNK7pvJCEBRS4vRnhBqjKnDGtLjQk30LQEQWZJCD8s9yM5Esv
         M9VvPkwzkpKFOrMvijTiC8zAoh3Ok2Vxw+p48pqoMqtpoZjjA08VMVA9asI9PWIifY
         Ng/zeSG53TWDmhHOlmf4UGxQDo6XblTQIPoN/FPg=
Date:   Fri, 17 Jul 2020 17:42:03 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] fs/direct-io: fix one-time init of ->s_dio_done_wq
Message-ID: <20200718004203.GA2183@sol.localdomain>
References: <20200717050510.95832-1-ebiggers@kernel.org>
 <20200718001536.GB2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718001536.GB2005@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dave,

On Sat, Jul 18, 2020 at 10:15:36AM +1000, Dave Chinner wrote:
> On Thu, Jul 16, 2020 at 10:05:10PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Correctly implement the "one-time" init pattern for ->s_dio_done_wq.
> > This fixes the following issues:
> > 
> > - The LKMM doesn't guarantee that the workqueue will be seen initialized
> >   before being used, if another CPU allocated it.  With regards to
> >   specific CPU architectures, this is true on at least Alpha, but it may
> >   be true on other architectures too if the internal implementation of
> >   workqueues causes use of the workqueue to involve a control
> >   dependency.  (There doesn't appear to be a control dependency
> >   currently, but it's hard to tell and it could change in the future.)
> > 
> > - The preliminary checks for sb->s_dio_done_wq are a data race, since
> >   they do a plain load of a concurrently modified variable.  According
> >   to the C standard, this undefined behavior.  In practice, the kernel
> >   does sometimes makes assumptions about data races might be okay in
> >   practice, but these rules are undocumented and not uniformly agreed
> >   upon, so it's best to avoid cases where they might come into play.
> > 
> > Following the guidance for one-time init I've proposed at
> > https://lkml.kernel.org/r/20200717044427.68747-1-ebiggers@kernel.org,
> > replace it with the simplest implementation that is guaranteed to be
> > correct while still achieving the following properties:
> > 
> >     - Doesn't make direct I/O users contend on a mutex in the fast path.
> > 
> >     - Doesn't allocate the workqueue when it will never be used.
> > 
> > Fixes: 7b7a8665edd8 ("direct-io: Implement generic deferred AIO completions")
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> > 
> > v2: new implementation using smp_load_acquire() + smp_store_release()
> >     and a mutex.
> 
> A mutex?
> 
> That's over-engineered premature optimisation - the allocation path
> is a slow path that will only ever be hit only on the first few
> direct IOs if an app manages to synchronise it's first ever
> concurrent DIOs to different files perfectly. There is zero need to
> "optimise" the code like this.

You're completely misunderstanding the point of this change.  The mutex version
is actually simpler and easier to get right than the cmpxchg() version (which
what I'm replacing) -- see the tools/memory-model/Documentation/ patch I've
proposed which explains this.  In fact the existing use of cmpxchg() is wrong,
since cmpxchg() doesn't guarantee an ACQUIRE barrier on failure.

> 
> I've already suggested that we get rid of this whole dynamic
> initialisation code out of the direct IO path altogether for good
> reason: all of this goes away and we don't have to care about
> optimising it for performance at all.
> 
> We have two options as I see it: always allocate the workqueue on
> direct IO capable filesytsems in their ->fill_super() method, or
> allocate it on the first open(O_DIRECT) where we check if O_DIRECT
> is supported by the filesystem.
> 
> i.e. do_dentry_open() does this:
> 
>         /* NB: we're sure to have correct a_ops only after f_op->open */
>         if (f->f_flags & O_DIRECT) {
>                 if (!f->f_mapping->a_ops || !f->f_mapping->a_ops->direct_IO)
>                         return -EINVAL;
>         }
> 
> Allocate the work queue there, and we don't need to care about how
> fast or slow setting up the workqueue is and so there is zero need
> to optimise it for speed.

You also suggested about 4 other different things, so I don't know which one you
actually want.  Now you're still suggesting multiple different things.

Not having to add filesystem-specific code to nearly every filesystem and not
allocating the workqueue when it won't be used are desirable properties to have,
and I think worth using one-time-init for.

Multiple threads can execute do_dentry_open() concurrently on the same
filesystem, so we'd still have to use one-time init for that.  Is your proposal
to do that and use the implementation where the mutex is unconditionally taken?

- Eric
