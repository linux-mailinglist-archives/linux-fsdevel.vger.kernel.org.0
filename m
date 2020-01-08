Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2DB133F63
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 11:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgAHKhq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 05:37:46 -0500
Received: from monster.unsafe.ru ([5.9.28.80]:59224 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbgAHKhq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 05:37:46 -0500
Received: from comp-core-i7-2640m-0182e6 (nat-pool-brq-t.redhat.com [213.175.37.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.unsafe.ru (Postfix) with ESMTPSA id 64226C61AB0;
        Wed,  8 Jan 2020 10:37:42 +0000 (UTC)
Date:   Wed, 8 Jan 2020 11:37:41 +0100
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Subject: Re: [PATCH v6 00/10] proc: modernize proc to support multiple
 private instances
Message-ID: <20200108103617.sowveextdxz5hkme@comp-core-i7-2640m-0182e6>
Mail-Followup-To: Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
References: <20191225125151.1950142-1-gladkov.alexey@gmail.com>
 <20200106151514.GA382@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106151514.GA382@avx2>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 06, 2020 at 06:15:14PM +0300, Alexey Dobriyan wrote:
> >  	hidepid=	Set /proc/<pid>/ access mode.
> >  	gid=		Set the group authorized to learn processes information.
> > +	pidonly=	Show only task related subset of procfs.
> 
> I'd rather have
> 
> 	mount -t proc -o set=pid

This is a great idea.

> so that is can be naturally extended to 
> 
> 	mount -t proc -o set=pid,sysctl,misc
>
> > +static int proc_dir_open(struct inode *inode, struct file *file)
> > +{
> > +	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
> > +
> > +	if (proc_fs_pidonly(fs_info) == PROC_PIDONLY_ON)
> > +		return -ENOENT;
> > +
> > +	return 0;
> > +}
> > +
> >  /*
> >   * These are the generic /proc directory operations. They
> >   * use the in-memory "struct proc_dir_entry" tree to parse
> > @@ -338,6 +357,7 @@ static const struct file_operations proc_dir_operations = {
> >  	.llseek			= generic_file_llseek,
> >  	.read			= generic_read_dir,
> >  	.iterate_shared		= proc_readdir,
> > +	.open			= proc_dir_open,
> 
> This should not be necessary: if lookup and readdir filters work
> then ->open can't happen.

Yes you are right.

> > --- a/include/linux/proc_fs.h
> > +++ b/include/linux/proc_fs.h
> > +/* definitions for hide_pid field */
> > +enum {
> > +	HIDEPID_OFF	  = 0,
> > +	HIDEPID_NO_ACCESS = 1,
> > +	HIDEPID_INVISIBLE = 2,
> > +	HIDEPID_NOT_PTRACABLE = 3, /* Limit pids to only ptracable pids */
> > +};
> 
> These should live in uapi/ as they _are_ user interface to mount().

OK.

What do you think, maybe it's better to make these values a mask ?

I mean:

#define HIDEPID_OFF 0
#define HIDEPID_NO_ACCESS 1
#define HIDEPID_INVISIBLE 2
#define HIDEPID_NOT_PTRACABLE 4

In this case, if in the future there appear values that can be combined,
then there will be no need to make additional parameters.

-- 
Rgrds, legion

