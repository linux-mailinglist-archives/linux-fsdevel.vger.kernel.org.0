Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A32D31A35F5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 16:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbgDIOdI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 10:33:08 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:45052 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbgDIOdI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 10:33:08 -0400
Received: from comp-core-i7-2640m-0182e6 (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 9128E209C3;
        Thu,  9 Apr 2020 14:32:56 +0000 (UTC)
Date:   Thu, 9 Apr 2020 16:32:51 +0200
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v10 8/9] proc: use human-readable values for hidehid
Message-ID: <20200409143251.pqoprbjnetoup5vw@comp-core-i7-2640m-0182e6>
References: <20200327172331.418878-1-gladkov.alexey@gmail.com>
 <20200327172331.418878-9-gladkov.alexey@gmail.com>
 <87d08pkh4u.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d08pkh4u.fsf@x220.int.ebiederm.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Thu, 09 Apr 2020 14:33:06 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 02, 2020 at 11:05:21AM -0500, Eric W. Biederman wrote:
> Alexey Gladkov <gladkov.alexey@gmail.com> writes:
> 
> > The hidepid parameter values are becoming more and more and it becomes
> > difficult to remember what each new magic number means.
> 
> In principle I like this change.  In practice I think you have just
> broken ABI compatiblity with the new mount ABI.
> 
> In particular the following line seems broken.
> 
> > diff --git a/fs/proc/root.c b/fs/proc/root.c
> > index dbcd96f07c7a..ba782d6e6197 100644
> > --- a/fs/proc/root.c
> > +++ b/fs/proc/root.c
> > @@ -45,7 +45,7 @@ enum proc_param {
> >  
> >  static const struct fs_parameter_spec proc_fs_parameters[] = {
> >  	fsparam_u32("gid",	Opt_gid),
> > -	fsparam_u32("hidepid",	Opt_hidepid),
> > +	fsparam_string("hidepid",	Opt_hidepid),
> >  	fsparam_string("subset",	Opt_subset),
> >  	{}
> >  };
> 
> As I read fs_parser.c fs_param_is_u32 handles string inputs and turns them
> into numbers, and it handles binary numbers.

Yes, you can use: fsconfig(fsfd, FSCONFIG_SET_BINARY, ...); but in this
case the type of parameter will be fs_value_is_blob [1]. This kind of
parameters is handled by fs_param_is_blob(). The fs_param_is_u32 can
handle only parametes with fs_value_is_string type [2].

Am I missing something?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/fsopen.c#n405
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/fs_parser.c#n215

> However fs_param_is_string
> appears to only handle strings.  It appears to have not capacity to turn
> raw binary numbers into strings.
> 
> So I think we probably need to fix fs_param_is_string to raw binary
> numbers before we can safely make this change to fs/proc/root.c
> 
> David am I reading the fs_parser.c code correctly?  If I am are you ok
> with a change like the above?
> 
> Eric
> 

-- 
Rgrds, legion

