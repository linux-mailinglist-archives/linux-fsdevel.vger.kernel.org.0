Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5D815CE0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 23:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgBMWYA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 17:24:00 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:35034 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgBMWYA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 17:24:00 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2Mti-00CGBO-G2; Thu, 13 Feb 2020 22:23:50 +0000
Date:   Thu, 13 Feb 2020 22:23:50 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Subject: Re: [PATCH v8 07/11] proc: flush task dcache entries from all procfs
 instances
Message-ID: <20200213222350.GU23230@ZenIV.linux.org.uk>
References: <20200212200335.GO23230@ZenIV.linux.org.uk>
 <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
 <20200212203833.GQ23230@ZenIV.linux.org.uk>
 <20200212204124.GR23230@ZenIV.linux.org.uk>
 <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
 <87lfp7h422.fsf@x220.int.ebiederm.org>
 <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
 <87pnejf6fz.fsf@x220.int.ebiederm.org>
 <20200213055527.GS23230@ZenIV.linux.org.uk>
 <CAHk-=wgQnNHYxV7-SyRP=g9vTHyNAK9g1juLLB=eho4=DHVZEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgQnNHYxV7-SyRP=g9vTHyNAK9g1juLLB=eho4=DHVZEQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 13, 2020 at 01:30:11PM -0800, Linus Torvalds wrote:
> On Wed, Feb 12, 2020 at 9:55 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > What I don't understand is the insistence on getting those dentries
> > via dcache lookups.
> 
> I don't think that's an "insistence", it's more of a "historical
> behavior" together with "several changes over the years to deal with
> dentry-level cleanups and updates".
> 
> > _IF_ we are willing to live with cacheline
> > contention (on ->d_lock of root dentry, if nothing else), why not
> > do the following:
> >         * put all dentries of such directories ([0-9]* and [0-9]*/task/*)
> > into a list anchored in task_struct; have non-counting reference to
> > task_struct stored in them (might simplify part of get_proc_task() users,
> 
> Hmm.
> 
> Right now I don't think we actually create any dentries at all for the
> short-lived process case.
> 
> Wouldn't your suggestion make fork/exit rather worse?
> 
> Or would you create the dentries dynamically still at lookup time, and
> then attach them to the process at that point?
> 
> What list would you use for the dentry chaining? Would you play games
> with the dentry hashing, and "hash" them off the process, and never
> hit in the lookup cache?

I'd been thinking of ->d_fsdata pointing to a structure with list_head
and a (non-counting) task_struct pointer for those guys.  Allocated
on lookup, of course (as well as readdir ;-/) and put on the list
at the same time.

IOW, for short-lived process we simply have an empty (h)list anchored
in task_struct and that's it.
