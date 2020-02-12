Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 637F615B1F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 21:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgBLUik (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 15:38:40 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:43838 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgBLUik (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:38:40 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1ymH-00BamE-5t; Wed, 12 Feb 2020 20:38:33 +0000
Date:   Wed, 12 Feb 2020 20:38:33 +0000
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
Message-ID: <20200212203833.GQ23230@ZenIV.linux.org.uk>
References: <20200210150519.538333-1-gladkov.alexey@gmail.com>
 <20200210150519.538333-8-gladkov.alexey@gmail.com>
 <87v9odlxbr.fsf@x220.int.ebiederm.org>
 <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6>
 <87tv3vkg1a.fsf@x220.int.ebiederm.org>
 <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
 <87v9obipk9.fsf@x220.int.ebiederm.org>
 <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
 <20200212200335.GO23230@ZenIV.linux.org.uk>
 <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 12:35:04PM -0800, Linus Torvalds wrote:
> On Wed, Feb 12, 2020 at 12:03 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > What's to prevent racing with fs shutdown while you are doing the second part?
> 
> I was thinking that only the proc_flush_task() code would do this.
> 
> And that holds a ref to the vfsmount through upid->ns.
> 
> So I wasn't suggesting doing this in general - just splitting up the
> implementation of d_invalidate() so that proc_flush_task_mnt() could
> delay the complex part to after having traversed the RCU-protected
> list.
> 
> But hey - I missed this part of the problem originally, so maybe I'm
> just missing something else this time. Wouldn't be the first time.

Wait, I thought the whole point of that had been to allow multiple
procfs instances for the same userns?  Confused...
