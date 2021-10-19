Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5023433C20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 18:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhJSQaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 12:30:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230303AbhJSQaK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:30:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8665F60E76;
        Tue, 19 Oct 2021 16:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634660877;
        bh=XHtnJfTwL6/h1BFPKaBjvuaUguAOsJAj5Dx+LCH1lRE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=S/U4uMcRpPeWcQLH66NTWPM7Zj5SOWHEg+2TIqsD4gyS0j/mXsiWAYSg5EopBT9HS
         2gVxwlu1BduaFlZkOGU7AD0tn0U+5aZoi6P8nLqELWoQKSeiFZvAZI5jP6Qei+Tkru
         NW7omcg5TJzFGJaDJ9UJQXgSrI0bTdOUsc3WKlowXeEg1osNcoy8sZnhgXQ3COq/hL
         YXYkW/GeiOL/yruPp27uUww3SALQ8m28lOCFczt+EmR13T9fsGNq7dVE4BxODqsjIO
         FvOmgPa8lqNxO0WZaQYK27exQMSfCGwnbPu4JPszsiTNmGFv1VgKoUi+RneksPAwd9
         WgSjFmB+jd+JQ==
Message-ID: <c6d2e1a8691a49afbbc280bb74a05b9b110b7f27.camel@kernel.org>
Subject: Re: [PATCH v3 18/23] fs: remove a comment pointing to the removed
 mandatory-locking file
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Oct 2021 12:27:55 -0400
In-Reply-To: <20211019161651.GD15063@fieldses.org>
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
         <887de3a1ecadda3dbfe0adf9df9070f0afa9406c.1634630486.git.mchehab+huawei@kernel.org>
         <f352a2e4b50a8678a8ddef5177702ecf9040490f.camel@kernel.org>
         <20211019141427.GA15063@fieldses.org>
         <e7bdcf0b279989e51c2c333e89acf3e1d476eff0.camel@kernel.org>
         <20211019161651.GD15063@fieldses.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-10-19 at 12:16 -0400, J. Bruce Fields wrote:
> On Tue, Oct 19, 2021 at 11:46:51AM -0400, Jeff Layton wrote:
> > IDK...Do we want to "erase history" selectively like that?
> 
> Seems like pretty spotty history anyway, so I don't think it's a
> problem, but...
> 
> > Maybe we should just get rid of the whole pile of "changelog" comments
> > in fs/locks.c? They aren't terribly useful these days anyhow.
> 
> ...  that'd be fine with me.
> 
> I didn't mainly because I thought it'd be good to read through it and
> see if there's anything that should be salvaged.
> 
> Reading through it now:
> 
> The last few paragraphs (under "Locking conflicts and dependencies" were
> added more recently by Neil and are still useful.
> 
> I'd be OK losing the rest.
> 
> It might still be good to have some basic introduction; maybe something
> like this?:
> 
> --b.
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index 3d6fb4ae847b..b54813eae44f 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2,117 +2,11 @@
>  /*
>   *  linux/fs/locks.c
>   *
> - *  Provide support for fcntl()'s F_GETLK, F_SETLK, and F_SETLKW calls.
> - *  Doug Evans (dje@spiff.uucp), August 07, 1992
> + * We implement four types of file locks: BSD locks, posix locks, open
> + * file description locks, and leases.  For details about BSD locks,
> + * see the flock(2) man page; for details about the other three, see
> + * fcntl(2).
>   *
> - *  Deadlock detection added.
> - *  FIXME: one thing isn't handled yet:
> - *	- mandatory locks (requires lots of changes elsewhere)
> - *  Kelly Carmichael (kelly@[142.24.8.65]), September 17, 1994.
> - *
> - *  Miscellaneous edits, and a total rewrite of posix_lock_file() code.
> - *  Kai Petzke (wpp@marie.physik.tu-berlin.de), 1994
> - *
> - *  Converted file_lock_table to a linked list from an array, which eliminates
> - *  the limits on how many active file locks are open.
> - *  Chad Page (pageone@netcom.com), November 27, 1994
> - *
> - *  Removed dependency on file descriptors. dup()'ed file descriptors now
> - *  get the same locks as the original file descriptors, and a close() on
> - *  any file descriptor removes ALL the locks on the file for the current
> - *  process. Since locks still depend on the process id, locks are inherited
> - *  after an exec() but not after a fork(). This agrees with POSIX, and both
> - *  BSD and SVR4 practice.
> - *  Andy Walker (andy@lysaker.kvaerner.no), February 14, 1995
> - *
> - *  Scrapped free list which is redundant now that we allocate locks
> - *  dynamically with kmalloc()/kfree().
> - *  Andy Walker (andy@lysaker.kvaerner.no), February 21, 1995
> - *
> - *  Implemented two lock personalities - FL_FLOCK and FL_POSIX.
> - *
> - *  FL_POSIX locks are created with calls to fcntl() and lockf() through the
> - *  fcntl() system call. They have the semantics described above.
> - *
> - *  FL_FLOCK locks are created with calls to flock(), through the flock()
> - *  system call, which is new. Old C libraries implement flock() via fcntl()
> - *  and will continue to use the old, broken implementation.
> - *
> - *  FL_FLOCK locks follow the 4.4 BSD flock() semantics. They are associated
> - *  with a file pointer (filp). As a result they can be shared by a parent
> - *  process and its children after a fork(). They are removed when the last
> - *  file descriptor referring to the file pointer is closed (unless explicitly
> - *  unlocked).
> - *
> - *  FL_FLOCK locks never deadlock, an existing lock is always removed before
> - *  upgrading from shared to exclusive (or vice versa). When this happens
> - *  any processes blocked by the current lock are woken up and allowed to
> - *  run before the new lock is applied.
> - *  Andy Walker (andy@lysaker.kvaerner.no), June 09, 1995
> - *
> - *  Removed some race conditions in flock_lock_file(), marked other possible
> - *  races. Just grep for FIXME to see them.
> - *  Dmitry Gorodchanin (pgmdsg@ibi.com), February 09, 1996.
> - *
> - *  Addressed Dmitry's concerns. Deadlock checking no longer recursive.
> - *  Lock allocation changed to GFP_ATOMIC as we can't afford to sleep
> - *  once we've checked for blocking and deadlocking.
> - *  Andy Walker (andy@lysaker.kvaerner.no), April 03, 1996.
> - *
> - *  Initial implementation of mandatory locks. SunOS turned out to be
> - *  a rotten model, so I implemented the "obvious" semantics.
> - *  See 'Documentation/filesystems/mandatory-locking.rst' for details.
> - *  Andy Walker (andy@lysaker.kvaerner.no), April 06, 1996.
> - *
> - *  Don't allow mandatory locks on mmap()'ed files. Added simple functions to
> - *  check if a file has mandatory locks, used by mmap(), open() and creat() to
> - *  see if system call should be rejected. Ref. HP-UX/SunOS/Solaris Reference
> - *  Manual, Section 2.
> - *  Andy Walker (andy@lysaker.kvaerner.no), April 09, 1996.
> - *
> - *  Tidied up block list handling. Added '/proc/locks' interface.
> - *  Andy Walker (andy@lysaker.kvaerner.no), April 24, 1996.
> - *
> - *  Fixed deadlock condition for pathological code that mixes calls to
> - *  flock() and fcntl().
> - *  Andy Walker (andy@lysaker.kvaerner.no), April 29, 1996.
> - *
> - *  Allow only one type of locking scheme (FL_POSIX or FL_FLOCK) to be in use
> - *  for a given file at a time. Changed the CONFIG_LOCK_MANDATORY scheme to
> - *  guarantee sensible behaviour in the case where file system modules might
> - *  be compiled with different options than the kernel itself.
> - *  Andy Walker (andy@lysaker.kvaerner.no), May 15, 1996.
> - *
> - *  Added a couple of missing wake_up() calls. Thanks to Thomas Meckel
> - *  (Thomas.Meckel@mni.fh-giessen.de) for spotting this.
> - *  Andy Walker (andy@lysaker.kvaerner.no), May 15, 1996.
> - *
> - *  Changed FL_POSIX locks to use the block list in the same way as FL_FLOCK
> - *  locks. Changed process synchronisation to avoid dereferencing locks that
> - *  have already been freed.
> - *  Andy Walker (andy@lysaker.kvaerner.no), Sep 21, 1996.
> - *
> - *  Made the block list a circular list to minimise searching in the list.
> - *  Andy Walker (andy@lysaker.kvaerner.no), Sep 25, 1996.
> - *
> - *  Made mandatory locking a mount option. Default is not to allow mandatory
> - *  locking.
> - *  Andy Walker (andy@lysaker.kvaerner.no), Oct 04, 1996.
> - *
> - *  Some adaptations for NFS support.
> - *  Olaf Kirch (okir@monad.swb.de), Dec 1996,
> - *
> - *  Fixed /proc/locks interface so that we can't overrun the buffer we are handed.
> - *  Andy Walker (andy@lysaker.kvaerner.no), May 12, 1997.
> - *
> - *  Use slab allocator instead of kmalloc/kfree.
> - *  Use generic list implementation from <linux/list.h>.
> - *  Sped up posix_locks_deadlock by only considering blocked locks.
> - *  Matthew Wilcox <willy@debian.org>, March, 2000.
> - *
> - *  Leases and LOCK_MAND
> - *  Matthew Wilcox <willy@debian.org>, June, 2000.
> - *  Stephen Rothwell <sfr@canb.auug.org.au>, June, 2000.
>   *
>   * Locking conflicts and dependencies:
>   * If multiple threads attempt to lock the same byte (or flock the same file)

Yeah, I think that looks great. Send it with a changelog and I'll pull
it into the branch I have feeding into -next.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

