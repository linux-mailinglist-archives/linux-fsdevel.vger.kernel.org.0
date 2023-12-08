Return-Path: <linux-fsdevel+bounces-5291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D378480994E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 03:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553BC1F21256
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 02:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE8E1FBB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 02:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="upMbnbma"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88602D53;
	Thu,  7 Dec 2023 18:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702001694; x=1733537694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2DQNxZoCWXgQHkECfkmIZuwp1VgG4QwAhzeLosHQfC0=;
  b=upMbnbmac6YH/Mu5ppfkVzXRPvmvLPrqixCaS4tX1XYHNNmV+sPVDV/3
   SALeXlJsvEaMH0Dw1Ppxi3ZSnZScjfnQOVXIwMkd9y/NT9I/MGPzIpP8y
   /UQW8a2dKpzTu/2avZn9sDoyTWxzYO4hsGuF+zrMKndVmwLw36mMV5GCJ
   o=;
X-IronPort-AV: E=Sophos;i="6.04,259,1695686400"; 
   d="scan'208";a="258256878"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 02:14:54 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com (Postfix) with ESMTPS id D2B9740DB0;
	Fri,  8 Dec 2023 02:14:52 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:2061]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.119:2525] with esmtp (Farcaster)
 id 61a032c1-4b6b-46d7-b7aa-20e73beb4355; Fri, 8 Dec 2023 02:14:52 +0000 (UTC)
X-Farcaster-Flow-ID: 61a032c1-4b6b-46d7-b7aa-20e73beb4355
Received: from EX19D010UWA004.ant.amazon.com (10.13.138.204) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 8 Dec 2023 02:14:49 +0000
Received: from u0acfa43c8cad58.ant.amazon.com (10.106.101.36) by
 EX19D010UWA004.ant.amazon.com (10.13.138.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 8 Dec 2023 02:14:48 +0000
From: Munehisa Kamata <kamatam@amazon.com>
To: <paul@paul-moore.com>
CC: <adobriyan@gmail.com>, <akpm@linux-foundation.org>,
	<casey@schaufler-ca.com>, <kamatam@amazon.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: Fw: [PATCH] proc: Update inode upon changing task security attribute
Date: Thu, 7 Dec 2023 18:14:33 -0800
Message-ID: <20231208021433.1662438-1-kamatam@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHC9VhSyaFE7-u470TrnHP7o2hT8600zC+Od=M0KkrP46j7-Qw@mail.gmail.com>
References: <CAHC9VhSyaFE7-u470TrnHP7o2hT8600zC+Od=M0KkrP46j7-Qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
 EX19D010UWA004.ant.amazon.com (10.13.138.204)

On Tue, 2023-12-05 14:21:51 -0800, Paul Moore wrote:
>
> On Fri, Dec 1, 2023 at 4:00 PM Munehisa Kamata <kamatam@amazon.com> wrote:
> > On Fri, 2023-12-01 09:30:00 +0000, Alexey Dobriyan wrote:
> > > On Wed, Nov 29, 2023 at 05:11:22PM -0800, Andrew Morton wrote:
> > > >
> > > > fyi...
> > > >
> > > > (yuk!)
> > > >
> > > > Begin forwarded message:
> > > > Date: Thu, 30 Nov 2023 00:37:04 +0000
> > > > From: Munehisa Kamata <kamatam@amazon.com>
> > > > Subject: [PATCH] proc: Update inode upon changing task security attribute
> > > >
> > > > I'm not clear whether VFS is a better (or worse) place[1] to fix the
> > > > problem described below and would like to hear opinion.
> > > >
> > > > If the /proc/[pid] directory is bind-mounted on a system with Smack
> > > > enabled, and if the task updates its current security attribute, the task
> > > > may lose access to files in its own /proc/[pid] through the mountpoint.
> > > >
> > > >  $ sudo capsh --drop=cap_mac_override --
> > > >  # mkdir -p dir
> > > >  # mount --bind /proc/$$ dir
> > > >  # echo AAA > /proc/$$/task/current         # assuming built-in echo
> > > >  # cat /proc/$$/task/current                        # revalidate
> > > >  AAA
> > > >  # echo BBB > dir/attr/current
> > > >  # cat dir/attr/current
> > > >  cat: dir/attr/current: Permission denied
> > > >  # ls dir/
> > > >  ls: cannot access dir/: Permission denied
> > > >  # cat /proc/$$/attr/current                        # revalidate
> > > >  BBB
> > > >  # cat dir/attr/current
> > > >  BBB
> > > >  # echo CCC > /proc/$$/attr/current
> > > >  # cat dir/attr/current
> > > >  cat: dir/attr/current: Permission denied
> > > >
> > > > This happens because path lookup doesn't revalidate the dentry of the
> > > > /proc/[pid] when traversing the filesystem boundary, so the inode security
> > > > blob of the /proc/[pid] doesn't get updated with the new task security
> > > > attribute. Then, this may lead security modules to deny an access to the
> > > > directory. Looking at the code[2] and the /proc/pid/attr/current entry in
> > > > proc man page, seems like the same could happen with SELinux. Though, I
> > > > didn't find relevant reports.
> > > >
> > > > The steps above are quite artificial. I actually encountered such an
> > > > unexpected denial of access with an in-house application sandbox
> > > > framework; each app has its own dedicated filesystem tree where the
> > > > process's /proc/[pid] is bind-mounted to and the app enters into via
> > > > chroot.
> > > >
> > > > With this patch, writing to /proc/[pid]/attr/current (and its per-security
> > > > module variant) updates the inode security blob of /proc/[pid] or
> > > > /proc/[pid]/task/[tid] (when pid != tid) with the new attribute.
> > > >
> > > > [1] https://lkml.kernel.org/linux-fsdevel/4A2D15AF.8090000@sun.com/
> > > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/security/selinux/hooks.c#n4220
> > > >
> > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
> > > > ---
> > > >  fs/proc/base.c | 23 ++++++++++++++++++++---
> > > >  1 file changed, 20 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > > > index dd31e3b6bf77..bdb7bea53475 100644
> > > > --- a/fs/proc/base.c
> > > > +++ b/fs/proc/base.c
> > > > @@ -2741,6 +2741,7 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
> > > >  {
> > > >     struct inode * inode = file_inode(file);
> > > >     struct task_struct *task;
> > > > +   const char *name = file->f_path.dentry->d_name.name;
> > > >     void *page;
> > > >     int rv;
> > > >
> > > > @@ -2784,10 +2785,26 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
> > > >     if (rv < 0)
> > > >             goto out_free;
> > > >
> > > > -   rv = security_setprocattr(PROC_I(inode)->op.lsm,
> > > > -                             file->f_path.dentry->d_name.name, page,
> > > > -                             count);
> > > > +   rv = security_setprocattr(PROC_I(inode)->op.lsm, name, page, count);
> > > >     mutex_unlock(&current->signal->cred_guard_mutex);
> > > > +
> > > > +   /*
> > > > +    *  Update the inode security blob in advance if the task's security
> > > > +    *  attribute was updated
> > > > +    */
> > > > +   if (rv > 0 && !strcmp(name, "current")) {
> > > > +           struct pid *pid;
> > > > +           struct proc_inode *cur, *ei;
> > > > +
> > > > +           rcu_read_lock();
> > > > +           pid = get_task_pid(current, PIDTYPE_PID);
> > > > +           hlist_for_each_entry(cur, &pid->inodes, sibling_inodes)
> > > > +                   ei = cur;
> > >
> > > Should this "break;"? Why is only the last inode in the list updated?
> > > Should it be the first? All of them?
> >
> > If it picks up the first node, it may end up updating /proc/[pid]/task/[tid]
> > rather than /proc/[pid] (when pid == tid) and the task may be denied access
> > to its own /proc/[pid] afterward.
> >
> > I think updating all of them won't hurt. But, as long as /proc/[pid] is
> > accessible, the rest of the inodes should be updated upon path lookup via
> > revalidation as usual.
> >
> > When pid != tid, it only updates /proc/[pid]/task/[tid] and the thread may
> > lose an access to /proc/[pid], but I think it's okay as it's a matter of
> > security policy enforced by security modules. Casey, do you have any
> > comments here?
> >
> > > > +           put_pid(pid);
> > > > +           pid_update_inode(current, &ei->vfs_inode);
> > > > +           rcu_read_unlock();
> > > > +   }
> 
> I think my thoughts are neatly summarized by Andrew's "yuk!" comment
> at the top.  However, before we go too much further on this, can we
> get clarification that Casey was able to reproduce this on a stock
> upstream kernel?  Last I read in the other thread Casey wasn't seeing
> this problem on Linux v6.5.
> 
> However, for the moment I'm going to assume this is a real problem, is
> there some reason why the existing pid_revalidate() code is not being
> called in the bind mount case?  From what I can see in the original
> problem report, the path walk seems to work okay when the file is
> accessed directly from /proc, but fails when done on the bind mount.
> Is there some problem with revalidating dentrys on bind mounts?

Hi Paul,

https://lkml.kernel.org/linux-fsdevel/20090608201745.GO8633@ZenIV.linux.org.uk/

After reading this thread, I have doubt about solving this in VFS.
Honestly, however, I'm not sure if it's entirely relevant today.

I think this behavior itself is not specific to bind mounts. Though,
/proc/[pid] files are a bit special since its inode security blob has to be
updated whenever the task's security attribute changed and it requries
revalidation.

I also considered .d_weak_revalidate, but it only helps when the final
component of the path is the mountpoint on path lookup; a task will need to
explicitly access the mountpoint once before accessing the files under the
directory... I don't think it's a solution.


Thanks,
Munehisa

> -- 
> paul-moore.com
> 

