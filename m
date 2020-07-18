Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD850224769
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jul 2020 02:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgGRAPm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 20:15:42 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:41721 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728087AbgGRAPm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 20:15:42 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id 97E77D5AC94;
        Sat, 18 Jul 2020 10:15:38 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jwaVs-0001di-2p; Sat, 18 Jul 2020 10:15:36 +1000
Date:   Sat, 18 Jul 2020 10:15:36 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] fs/direct-io: fix one-time init of ->s_dio_done_wq
Message-ID: <20200718001536.GB2005@dread.disaster.area>
References: <20200717050510.95832-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717050510.95832-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QKgWuTDL c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=kj9zAlcOel0A:10 a=_RQrkK6FrEwA:10 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=T5U9q6-3o76AgGMSUHEA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 10:05:10PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Correctly implement the "one-time" init pattern for ->s_dio_done_wq.
> This fixes the following issues:
> 
> - The LKMM doesn't guarantee that the workqueue will be seen initialized
>   before being used, if another CPU allocated it.  With regards to
>   specific CPU architectures, this is true on at least Alpha, but it may
>   be true on other architectures too if the internal implementation of
>   workqueues causes use of the workqueue to involve a control
>   dependency.  (There doesn't appear to be a control dependency
>   currently, but it's hard to tell and it could change in the future.)
> 
> - The preliminary checks for sb->s_dio_done_wq are a data race, since
>   they do a plain load of a concurrently modified variable.  According
>   to the C standard, this undefined behavior.  In practice, the kernel
>   does sometimes makes assumptions about data races might be okay in
>   practice, but these rules are undocumented and not uniformly agreed
>   upon, so it's best to avoid cases where they might come into play.
> 
> Following the guidance for one-time init I've proposed at
> https://lkml.kernel.org/r/20200717044427.68747-1-ebiggers@kernel.org,
> replace it with the simplest implementation that is guaranteed to be
> correct while still achieving the following properties:
> 
>     - Doesn't make direct I/O users contend on a mutex in the fast path.
> 
>     - Doesn't allocate the workqueue when it will never be used.
> 
> Fixes: 7b7a8665edd8 ("direct-io: Implement generic deferred AIO completions")
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> 
> v2: new implementation using smp_load_acquire() + smp_store_release()
>     and a mutex.

A mutex?

That's over-engineered premature optimisation - the allocation path
is a slow path that will only ever be hit only on the first few
direct IOs if an app manages to synchronise it's first ever
concurrent DIOs to different files perfectly. There is zero need to
"optimise" the code like this.

I've already suggested that we get rid of this whole dynamic
initialisation code out of the direct IO path altogether for good
reason: all of this goes away and we don't have to care about
optimising it for performance at all.

We have two options as I see it: always allocate the workqueue on
direct IO capable filesytsems in their ->fill_super() method, or
allocate it on the first open(O_DIRECT) where we check if O_DIRECT
is supported by the filesystem.

i.e. do_dentry_open() does this:

        /* NB: we're sure to have correct a_ops only after f_op->open */
        if (f->f_flags & O_DIRECT) {
                if (!f->f_mapping->a_ops || !f->f_mapping->a_ops->direct_IO)
                        return -EINVAL;
        }

Allocate the work queue there, and we don't need to care about how
fast or slow setting up the workqueue is and so there is zero need
to optimise it for speed.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
