Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4B415AB48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 15:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgBLOt0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 09:49:26 -0500
Received: from monster.unsafe.ru ([5.9.28.80]:46690 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbgBLOt0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:49:26 -0500
Received: from comp-core-i7-2640m-0182e6 (nat-pool-brq-t.redhat.com [213.175.37.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.unsafe.ru (Postfix) with ESMTPSA id AFA2DC61AB0;
        Wed, 12 Feb 2020 14:49:22 +0000 (UTC)
Date:   Wed, 12 Feb 2020 15:49:21 +0100
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
        Solar Designer <solar@openwall.com>
Subject: Re: [PATCH v8 07/11] proc: flush task dcache entries from all procfs
 instances
Message-ID: <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
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
        Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
References: <20200210150519.538333-1-gladkov.alexey@gmail.com>
 <20200210150519.538333-8-gladkov.alexey@gmail.com>
 <87v9odlxbr.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9odlxbr.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 10, 2020 at 07:36:08PM -0600, Eric W. Biederman wrote:
> Alexey Gladkov <gladkov.alexey@gmail.com> writes:
> 
> > This allows to flush dcache entries of a task on multiple procfs mounts
> > per pid namespace.
> >
> > The RCU lock is used because the number of reads at the task exit time
> > is much larger than the number of procfs mounts.
> 
> A couple of quick comments.
> 
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Signed-off-by: Djalal Harouni <tixxdz@gmail.com>
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
> > ---
> >  fs/proc/base.c                | 20 +++++++++++++++-----
> >  fs/proc/root.c                | 27 ++++++++++++++++++++++++++-
> >  include/linux/pid_namespace.h |  2 ++
> >  include/linux/proc_fs.h       |  2 ++
> >  4 files changed, 45 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index 4ccb280a3e79..24b7c620ded3 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -3133,7 +3133,7 @@ static const struct inode_operations proc_tgid_base_inode_operations = {
> >  	.permission	= proc_pid_permission,
> >  };
> >  
> > -static void proc_flush_task_mnt(struct vfsmount *mnt, pid_t pid, pid_t tgid)
> > +static void proc_flush_task_mnt_root(struct dentry *mnt_root, pid_t pid, pid_t tgid)
> Perhaps just rename things like:
> > +static void proc_flush_task_root(struct dentry *root, pid_t pid, pid_t tgid)
> >  {
> 
> I don't think the mnt_ prefix conveys any information, and it certainly
> makes everything longer and more cumbersome.
> 
> >  	struct dentry *dentry, *leader, *dir;
> >  	char buf[10 + 1];
> > @@ -3142,7 +3142,7 @@ static void proc_flush_task_mnt(struct vfsmount *mnt, pid_t pid, pid_t tgid)
> >  	name.name = buf;
> >  	name.len = snprintf(buf, sizeof(buf), "%u", pid);
> >  	/* no ->d_hash() rejects on procfs */
> > -	dentry = d_hash_and_lookup(mnt->mnt_root, &name);
> > +	dentry = d_hash_and_lookup(mnt_root, &name);
> >  	if (dentry) {
> >  		d_invalidate(dentry);
> >  		dput(dentry);
> > @@ -3153,7 +3153,7 @@ static void proc_flush_task_mnt(struct vfsmount *mnt, pid_t pid, pid_t tgid)
> >  
> >  	name.name = buf;
> >  	name.len = snprintf(buf, sizeof(buf), "%u", tgid);
> > -	leader = d_hash_and_lookup(mnt->mnt_root, &name);
> > +	leader = d_hash_and_lookup(mnt_root, &name);
> >  	if (!leader)
> >  		goto out;
> >  
> > @@ -3208,14 +3208,24 @@ void proc_flush_task(struct task_struct *task)
> >  	int i;
> >  	struct pid *pid, *tgid;
> >  	struct upid *upid;
> > +	struct dentry *mnt_root;
> > +	struct proc_fs_info *fs_info;
> >  
> >  	pid = task_pid(task);
> >  	tgid = task_tgid(task);
> >  
> >  	for (i = 0; i <= pid->level; i++) {
> >  		upid = &pid->numbers[i];
> > -		proc_flush_task_mnt(upid->ns->proc_mnt, upid->nr,
> > -					tgid->numbers[i].nr);
> > +
> > +		rcu_read_lock();
> > +		list_for_each_entry_rcu(fs_info, &upid->ns->proc_mounts, pidns_entry) {
> > +			mnt_root = fs_info->m_super->s_root;
> > +			proc_flush_task_mnt_root(mnt_root, upid->nr, tgid->numbers[i].nr);
> > +		}
> > +		rcu_read_unlock();
> > +
> > +		mnt_root = upid->ns->proc_mnt->mnt_root;
> > +		proc_flush_task_mnt_root(mnt_root, upid->nr, tgid->numbers[i].nr);
> 
> I don't think this following of proc_mnt is needed.  It certainly
> shouldn't be.  The loop through all of the super blocks should be
> enough.

Yes, thanks!

> Once this change goes through.  UML can be given it's own dedicated
> proc_mnt for the initial pid namespace, and proc_mnt can be removed
> entirely.

After you deleted the old sysctl syscall we could probably do it.

> Unless something has changed recently UML is the only other user of
> pid_ns->proc_mnt.  That proc_mnt really only exists to make the loop in
> proc_flush_task easy to write.

Now I think, is there any way to get rid of proc_mounts or even
proc_flush_task somehow.

> It also probably makes sense to take the rcu_read_lock() over
> that entire for loop.

Al Viro pointed out to me that I cannot use rcu locks here :(

-- 
Rgrds, legion

