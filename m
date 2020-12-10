Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1448B2D53A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 07:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgLJGOx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 01:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733119AbgLJGN5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 01:13:57 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98174C061793;
        Wed,  9 Dec 2020 22:13:17 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knFCK-000FrK-9B; Thu, 10 Dec 2020 06:13:04 +0000
Date:   Thu, 10 Dec 2020 06:13:04 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jann@thejh.net>
Subject: Re: [PATCH] files: rcu free files_struct
Message-ID: <20201210061304.GS3579531@ZenIV.linux.org.uk>
References: <20201120231441.29911-15-ebiederm@xmission.com>
 <20201207232900.GD4115853@ZenIV.linux.org.uk>
 <877dprvs8e.fsf@x220.int.ebiederm.org>
 <20201209040731.GK3579531@ZenIV.linux.org.uk>
 <877dprtxly.fsf@x220.int.ebiederm.org>
 <20201209142359.GN3579531@ZenIV.linux.org.uk>
 <87o8j2svnt.fsf_-_@x220.int.ebiederm.org>
 <CAHk-=wiUMHBHmmDS3_Xqh1wfGFyd_rdDmpZzk0cODoj1i7_VOA@mail.gmail.com>
 <20201209195033.GP3579531@ZenIV.linux.org.uk>
 <87sg8er7gp.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sg8er7gp.fsf@x220.int.ebiederm.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 09, 2020 at 03:32:38PM -0600, Eric W. Biederman wrote:
> Al Viro <viro@zeniv.linux.org.uk> writes:
> 
> > On Wed, Dec 09, 2020 at 11:13:38AM -0800, Linus Torvalds wrote:
> >> On Wed, Dec 9, 2020 at 10:05 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >> >
> >> > -                               struct file * file = xchg(&fdt->fd[i], NULL);
> >> > +                               struct file * file = fdt->fd[i];
> >> >                                 if (file) {
> >> > +                                       rcu_assign_pointer(fdt->fd[i], NULL);
> >> 
> >> This makes me nervous. Why did we use to do that xchg() there? That
> >> has atomicity guarantees that now are gone.
> >> 
> >> Now, this whole thing should be called for just the last ref of the fd
> >> table, so presumably that atomicity was never needed in the first
> >> place. But the fact that we did that very expensive xchg() then makes
> >> me go "there's some reason for it".
> >> 
> >> Is this xchg() just bogus historical leftover? It kind of looks that
> >> way. But maybe that change should be done separately?
> >
> > I'm still not convinced that exposing close_files() to parallel
> > 3rd-party accesses is safe in all cases, so this patch still needs
> > more analysis.
> 
> That is fine.  I just wanted to post the latest version so we could
> continue the discussion.  Especially with comments etc.

It's probably safe.  I've spent today digging through the mess in
fs/notify and kernel/bpf, and while I'm disgusted with both, at
that point I believe that close_files() exposure is not going to
create problems with either.  And xchg() in there _is_ useless.

Said that, BPF "file iterator" stuff is potentially very unpleasant -
it allows to pin a struct file found in any process' descriptor table
indefinitely long.  Temporary struct file references grabbed by procfs
code, while unfortunate, are at least short-lived; with this stuff sky's
the limit.

I'm not happy about having that available, especially if it's a user-visible
primitive we can't withdraw at zero notice ;-/

What are the users of that thing and is there any chance to replace it
with something saner?  IOW, what *is* realistically called for each
struct file by the users of that iterator?
