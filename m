Return-Path: <linux-fsdevel+bounces-4615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E067801670
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD277B20D1D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43107619C9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tmtPZpbg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E421012A;
	Fri,  1 Dec 2023 12:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701464392; x=1733000392;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nCap8NwzKwphCukdUu1OlpulweBp55bEAVvRfRiRsUE=;
  b=tmtPZpbga/5zaP3+9H5UXuW+ZTP9KA1zU96y38I/GzFHM2fSVXrAEr0v
   p+Ma59GZclHXwgWsIfVbNczLHzytH3aejuQBFsgx8MzuR1X1Dd14r9dVE
   S2hVMubfV6KuIaTkUQs0X8bxVuUdyDe9d2rzIhDBvMh6myJ6J+J4+XmK3
   Q=;
X-IronPort-AV: E=Sophos;i="6.04,242,1695686400"; 
   d="scan'208";a="688425735"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-af372327.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 20:59:51 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2a-m6i4x-af372327.us-west-2.amazon.com (Postfix) with ESMTPS id 1601560A61;
	Fri,  1 Dec 2023 20:59:51 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:56175]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.133:2525] with esmtp (Farcaster)
 id 98e2ec98-9b24-410c-804e-0c935446c316; Fri, 1 Dec 2023 20:59:50 +0000 (UTC)
X-Farcaster-Flow-ID: 98e2ec98-9b24-410c-804e-0c935446c316
Received: from EX19D010UWA004.ant.amazon.com (10.13.138.204) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 1 Dec 2023 20:59:50 +0000
Received: from dev-dsk-kamatam-2b-b66a5860.us-west-2.amazon.com (10.169.6.191)
 by EX19D010UWA004.ant.amazon.com (10.13.138.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 1 Dec 2023 20:59:50 +0000
From: Munehisa Kamata <kamatam@amazon.com>
To: <adobriyan@gmail.com>, <casey@schaufler-ca.com>
CC: <akpm@linux-foundation.org>, <kamatam@amazon.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: Fw: [PATCH] proc: Update inode upon changing task security attribute
Date: Fri, 1 Dec 2023 20:59:40 +0000
Message-ID: <20231201205940.23095-1-kamatam@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <5f8b18b0-0744-4cf5-9ec5-b0bb0451dd18@p183>
References: <5f8b18b0-0744-4cf5-9ec5-b0bb0451dd18@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB004.ant.amazon.com (10.13.139.164) To
 EX19D010UWA004.ant.amazon.com (10.13.138.204)


Hi Alexey,

On Fri, 2023-12-01 09:30:00 +0000, Alexey Dobriyan wrote:
>
> On Wed, Nov 29, 2023 at 05:11:22PM -0800, Andrew Morton wrote:
> > 
> > fyi...
> > 
> > (yuk!)
> > 
> > 
> > 
> > Begin forwarded message:
> > 
> > Date: Thu, 30 Nov 2023 00:37:04 +0000
> > From: Munehisa Kamata <kamatam@amazon.com>
> > To: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
> > Cc: <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>, "Munehisa Kamata" <kamatam@amazon.com>
> > Subject: [PATCH] proc: Update inode upon changing task security attribute
> > 
> > 
> > I'm not clear whether VFS is a better (or worse) place[1] to fix the
> > problem described below and would like to hear opinion.
> > 
> > If the /proc/[pid] directory is bind-mounted on a system with Smack
> > enabled, and if the task updates its current security attribute, the task
> > may lose access to files in its own /proc/[pid] through the mountpoint.
> > 
> >  $ sudo capsh --drop=cap_mac_override --
> >  # mkdir -p dir
> >  # mount --bind /proc/$$ dir
> >  # echo AAA > /proc/$$/task/current		# assuming built-in echo
> >  # cat /proc/$$/task/current			# revalidate
> >  AAA
> >  # echo BBB > dir/attr/current
> >  # cat dir/attr/current
> >  cat: dir/attr/current: Permission denied
> >  # ls dir/
> >  ls: cannot access dir/: Permission denied
> >  # cat /proc/$$/attr/current			# revalidate
> >  BBB
> >  # cat dir/attr/current
> >  BBB
> >  # echo CCC > /proc/$$/attr/current
> >  # cat dir/attr/current
> >  cat: dir/attr/current: Permission denied
> > 
> > This happens because path lookup doesn't revalidate the dentry of the
> > /proc/[pid] when traversing the filesystem boundary, so the inode security
> > blob of the /proc/[pid] doesn't get updated with the new task security
> > attribute. Then, this may lead security modules to deny an access to the
> > directory. Looking at the code[2] and the /proc/pid/attr/current entry in
> > proc man page, seems like the same could happen with SELinux. Though, I
> > didn't find relevant reports.
> > 
> > The steps above are quite artificial. I actually encountered such an
> > unexpected denial of access with an in-house application sandbox
> > framework; each app has its own dedicated filesystem tree where the
> > process's /proc/[pid] is bind-mounted to and the app enters into via
> > chroot.
> > 
> > With this patch, writing to /proc/[pid]/attr/current (and its per-security
> > module variant) updates the inode security blob of /proc/[pid] or
> > /proc/[pid]/task/[tid] (when pid != tid) with the new attribute.
> > 
> > [1] https://lkml.kernel.org/linux-fsdevel/4A2D15AF.8090000@sun.com/
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/security/selinux/hooks.c#n4220
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
> > ---
> >  fs/proc/base.c | 23 ++++++++++++++++++++---
> >  1 file changed, 20 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index dd31e3b6bf77..bdb7bea53475 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -2741,6 +2741,7 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
> >  {
> >  	struct inode * inode = file_inode(file);
> >  	struct task_struct *task;
> > +	const char *name = file->f_path.dentry->d_name.name;
> >  	void *page;
> >  	int rv;
> >  
> > @@ -2784,10 +2785,26 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
> >  	if (rv < 0)
> >  		goto out_free;
> >  
> > -	rv = security_setprocattr(PROC_I(inode)->op.lsm,
> > -				  file->f_path.dentry->d_name.name, page,
> > -				  count);
> > +	rv = security_setprocattr(PROC_I(inode)->op.lsm, name, page, count);
> >  	mutex_unlock(&current->signal->cred_guard_mutex);
> > +
> > +	/*
> > +	 *  Update the inode security blob in advance if the task's security
> > +	 *  attribute was updated
> > +	 */
> > +	if (rv > 0 && !strcmp(name, "current")) {
> > +		struct pid *pid;
> > +		struct proc_inode *cur, *ei;
> > +
> > +		rcu_read_lock();
> > +		pid = get_task_pid(current, PIDTYPE_PID);
> > +		hlist_for_each_entry(cur, &pid->inodes, sibling_inodes)
> > +			ei = cur;
> 
> Should this "break;"? Why is only the last inode in the list updated?
> Should it be the first? All of them?

If it picks up the first node, it may end up updating /proc/[pid]/task/[tid]
rather than /proc/[pid] (when pid == tid) and the task may be denied access
to its own /proc/[pid] afterward.

I think updating all of them won't hurt. But, as long as /proc/[pid] is
accessible, the rest of the inodes should be updated upon path lookup via
revalidation as usual.

When pid != tid, it only updates /proc/[pid]/task/[tid] and the thread may
lose an access to /proc/[pid], but I think it's okay as it's a matter of
security policy enforced by security modules. Casey, do you have any
comments here?  


Regards,
Munehisa

 
> > +		put_pid(pid);
> > +		pid_update_inode(current, &ei->vfs_inode);
> > +		rcu_read_unlock();
> > +	}
> 

