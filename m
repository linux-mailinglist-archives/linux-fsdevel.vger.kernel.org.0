Return-Path: <linux-fsdevel+bounces-4316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BFC7FE850
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 05:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1826F1F20ED2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 04:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C9E1DFEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 04:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TiebifzN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181DA1A6;
	Wed, 29 Nov 2023 19:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701313659; x=1732849659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F6MENshfkaH8bmU45se60CAkvuaOjjKOiHZKlEZ6xHA=;
  b=TiebifzNmzCNm81Um+msamPug8i5DyN9+i+W/0Dn7BMgrFu9imAX4XpY
   BE+KmhVSBn8KZ+qMLA8dhW2zf9EJNGlgM3Ll/D4KF/jOK9a6ly/o9GVvZ
   UNuGkly2tqMTx6/dMNpPAeF4SFyvXUgfcO9WpyuOofDvj4TIfqXH8ZNkf
   0=;
X-IronPort-AV: E=Sophos;i="6.04,237,1695686400"; 
   d="scan'208";a="687984968"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-245b69b1.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 03:07:38 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1e-m6i4x-245b69b1.us-east-1.amazon.com (Postfix) with ESMTPS id 1B2C6340019;
	Thu, 30 Nov 2023 03:07:35 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:3462]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.6:2525] with esmtp (Farcaster)
 id 8beb2ad2-7780-40d5-9629-ec295a44c9fe; Thu, 30 Nov 2023 03:07:34 +0000 (UTC)
X-Farcaster-Flow-ID: 8beb2ad2-7780-40d5-9629-ec295a44c9fe
Received: from EX19D010UWA004.ant.amazon.com (10.13.138.204) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 30 Nov 2023 03:07:34 +0000
Received: from u0acfa43c8cad58.ant.amazon.com (10.106.101.41) by
 EX19D010UWA004.ant.amazon.com (10.13.138.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 30 Nov 2023 03:07:34 +0000
From: Munehisa Kamata <kamatam@amazon.com>
To: <casey@schaufler-ca.com>
CC: <akpm@linux-foundation.org>, <kamatam@amazon.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] proc: Update inode upon changing task security attribute
Date: Wed, 29 Nov 2023 19:07:21 -0800
Message-ID: <20231130030721.780557-1-kamatam@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6f02ce82-3697-4e76-aae6-13440e1bfbad@schaufler-ca.com>
References: <6f02ce82-3697-4e76-aae6-13440e1bfbad@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC004.ant.amazon.com (10.13.139.229) To
 EX19D010UWA004.ant.amazon.com (10.13.138.204)

Hi Casey,

On Wed, 2023-11-29 18:28:55 -0800, Casey Schaufler wrote:
>
> On 11/29/2023 4:37 PM, Munehisa Kamata wrote:
> > I'm not clear whether VFS is a better (or worse) place[1] to fix the
> > problem described below and would like to hear opinion.
> 
> Please To: or at least Cc: me on all Smack related issues.

Will do that next.

> >
> > If the /proc/[pid] directory is bind-mounted on a system with Smack
> > enabled, and if the task updates its current security attribute, the task
> > may lose access to files in its own /proc/[pid] through the mountpoint.
> >
> >  $ sudo capsh --drop=cap_mac_override --
> >  # mkdir -p dir
> >  # mount --bind /proc/$$ dir
> >  # echo AAA > /proc/$$/task/current		# assuming built-in echo
> 
> I don't see "current" in /proc/$$/task. Did you mean /proc/$$/attr?

Ahh, yes, I meant /proc/$$/attr/current. Sorry about that...

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
> > +		put_pid(pid);
> > +		pid_update_inode(current, &ei->vfs_inode);
> > +		rcu_read_unlock();
> > +	}
> > +
> >  out_free:
> >  	kfree(page);
> >  out:
> 

