Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A9B1B64EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 22:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgDWUCT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 16:02:19 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:47380 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgDWUCS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 16:02:18 -0400
Received: from comp-core-i7-2640m-0182e6 (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 3A8DC20459;
        Thu, 23 Apr 2020 20:01:42 +0000 (UTC)
Date:   Thu, 23 Apr 2020 22:01:36 +0200
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
Subject: Re: [PATCH v13 2/7] proc: allow to mount many instances of proc in
 one pid namespace
Message-ID: <20200423200136.zrjzv6d6zghnvvrx@comp-core-i7-2640m-0182e6>
References: <20200419141057.621356-3-gladkov.alexey@gmail.com>
 <20200423112858.95820-1-gladkov.alexey@gmail.com>
 <87lfmmz9bs.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfmmz9bs.fsf@x220.int.ebiederm.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Thu, 23 Apr 2020 20:02:13 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 23, 2020 at 07:16:07AM -0500, Eric W. Biederman wrote:
> 
> I took a quick look and there is at least one other use in security/tomoyo/realpath.c:
> 
> static char *tomoyo_get_local_path(struct dentry *dentry, char * const buffer,
> 				   const int buflen)
> {
> 	struct super_block *sb = dentry->d_sb;
> 	char *pos = tomoyo_get_dentry_path(dentry, buffer, buflen);
> 
> 	if (IS_ERR(pos))
> 		return pos;
> 	/* Convert from $PID to self if $PID is current thread. */
> 	if (sb->s_magic == PROC_SUPER_MAGIC && *pos == '/') {
> 		char *ep;
> 		const pid_t pid = (pid_t) simple_strtoul(pos + 1, &ep, 10);
> 
> 		if (*ep == '/' && pid && pid ==
> 		    task_tgid_nr_ns(current, sb->s_fs_info)) {
> 			pos = ep - 5;
> 			if (pos < buffer)
> 				goto out;
> 			memmove(pos, "/self", 5);
> 		}
> 		goto prepend_filesystem_name;
> 	}

Ooops. I missed this one. I thought I found all such cases.

> Can you make the fixes to locks.c and tomoyo a couple of standalone
> fixes that should be inserted before your patch?

Sure.

> On the odd chance there is a typo they will bisect better, as well
> as just keeping this patch and it's description from expanding in size.
> So that things are small enough for people to really look at and review.
> 
> The fix itself looks fine.
> 
> Thank you,
> Eric
> 
> 
> Alexey Gladkov <gladkov.alexey@gmail.com> writes:
> 
> > Fixed getting proc_pidns in the lock_get_status() and locks_show() directly from
> > the superblock, which caused a crash:
> >
> > === arm64 ===
> > [12140.366814] LTP: starting proc01 (proc01 -m 128)
> > [12149.580943] ==================================================================
> > [12149.589521] BUG: KASAN: out-of-bounds in pid_nr_ns+0x2c/0x90 pid_nr_ns at kernel/pid.c:456
> > [12149.595939] Read of size 4 at addr 1bff000bfa8c0388 by task = proc01/50298
> > [12149.603392] Pointer tag: [1b], memory tag: [fe]
> >
> > [12149.610906] CPU: 69 PID: 50298 Comm: proc01 Tainted: G L 5.7.0-rc2-next-20200422 #6
> > [12149.620585] Hardware name: HPE Apollo 70 /C01_APACHE_MB , BIOS L50_5.13_1.11 06/18/2019
> > [12149.631074] Call trace:
> > [12149.634304]  dump_backtrace+0x0/0x22c
> > [12149.638745]  show_stack+0x28/0x34
> > [12149.642839]  dump_stack+0x104/0x194
> > [12149.647110]  print_address_description+0x70/0x3a4
> > [12149.652576]  __kasan_report+0x188/0x238
> > [12149.657169]  kasan_report+0x3c/0x58
> > [12149.661430]  check_memory_region+0x98/0xa0
> > [12149.666303]  __hwasan_load4_noabort+0x18/0x20
> > [12149.671431]  pid_nr_ns+0x2c/0x90
> > [12149.675446]  locks_translate_pid+0xf4/0x1a0
> > [12149.680382]  locks_show+0x68/0x110
> > [12149.684536]  seq_read+0x380/0x930
> > [12149.688604]  pde_read+0x5c/0x78
> > [12149.692498]  proc_reg_read+0x74/0xc0
> > [12149.696813]  __vfs_read+0x84/0x1d0
> > [12149.700939]  vfs_read+0xec/0x124
> > [12149.704889]  ksys_read+0xb0/0x120
> > [12149.708927]  __arm64_sys_read+0x54/0x88
> > [12149.713485]  do_el0_svc+0x128/0x1dc
> > [12149.717697]  el0_sync_handler+0x150/0x250
> > [12149.722428]  el0_sync+0x164/0x180
> >
> > [12149.728672] Allocated by task 1:
> > [12149.732624]  __kasan_kmalloc+0x124/0x188
> > [12149.737269]  kasan_kmalloc+0x10/0x18
> > [12149.741568]  kmem_cache_alloc_trace+0x2e4/0x3d4
> > [12149.746820]  proc_fill_super+0x48/0x1fc
> > [12149.751377]  vfs_get_super+0xcc/0x170
> > [12149.755760]  get_tree_nodev+0x28/0x34
> > [12149.760143]  proc_get_tree+0x24/0x30
> > [12149.764439]  vfs_get_tree+0x54/0x158
> > [12149.768736]  do_mount+0x80c/0xaf0
> > [12149.772774]  __arm64_sys_mount+0xe0/0x18c
> > [12149.777504]  do_el0_svc+0x128/0x1dc
> > [12149.781715]  el0_sync_handler+0x150/0x250
> > [12149.786445]  el0_sync+0x164/0x180
> 
> > diff --git a/fs/locks.c b/fs/locks.c
> > index b8a31c1c4fff..399c5dbb72c4 100644
> > --- a/fs/locks.c
> > +++ b/fs/locks.c
> > @@ -2823,7 +2823,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
> >  {
> >  	struct inode *inode = NULL;
> >  	unsigned int fl_pid;
> > -	struct pid_namespace *proc_pidns = file_inode(f->file)->i_sb->s_fs_info;
> > +	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file));
> >  
> >  	fl_pid = locks_translate_pid(fl, proc_pidns);
> >  	/*
> > @@ -2901,7 +2901,7 @@ static int locks_show(struct seq_file *f, void *v)
> >  {
> >  	struct locks_iterator *iter = f->private;
> >  	struct file_lock *fl, *bfl;
> > -	struct pid_namespace *proc_pidns = file_inode(f->file)->i_sb->s_fs_info;
> > +	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file));
> >  
> >  	fl = hlist_entry(v, struct file_lock, fl_link);
> >  
> 
> Eric
> 

-- 
Rgrds, legion

