Return-Path: <linux-fsdevel+bounces-4511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DAC7FFCE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 21:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFCAD1F20F64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 20:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7315A0E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 20:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="X1wHebd8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFAE1728;
	Thu, 30 Nov 2023 12:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701376570; x=1732912570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tk+NDDLXM7kV6TCa9iEfOG4vF8ZvXW993HLA3J5d/pc=;
  b=X1wHebd8I+YCQhyhKMuZqkLZF6kv7RwP+VhUUvxWUFOtqB8LtAQhG8td
   dUOtDasF+JRcyRaY+0w7y0RYAmrOw3x4aDTLPqAYyWBQigbfp6EvwwwYt
   qGMCIx2Z7QcK+QKudIn3PjdZ0J1rcU+9+EUAjdHsKOOnSSmLoUNXLhlEd
   I=;
X-IronPort-AV: E=Sophos;i="6.04,239,1695686400"; 
   d="scan'208";a="47539071"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-189d700f.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 20:36:09 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2b-m6i4x-189d700f.us-west-2.amazon.com (Postfix) with ESMTPS id 3C65340D92;
	Thu, 30 Nov 2023 20:36:08 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:49497]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.8:2525] with esmtp (Farcaster)
 id 6e059244-8dc8-43cc-bdca-f92ba1db21bb; Thu, 30 Nov 2023 20:36:08 +0000 (UTC)
X-Farcaster-Flow-ID: 6e059244-8dc8-43cc-bdca-f92ba1db21bb
Received: from EX19D010UWA004.ant.amazon.com (10.13.138.204) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 30 Nov 2023 20:36:08 +0000
Received: from dev-dsk-kamatam-2b-b66a5860.us-west-2.amazon.com (10.169.6.191)
 by EX19D010UWA004.ant.amazon.com (10.13.138.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 30 Nov 2023 20:36:08 +0000
From: Munehisa Kamata <kamatam@amazon.com>
To: <casey@schaufler-ca.com>
CC: <akpm@linux-foundation.org>, <kamatam@amazon.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] proc: Update inode upon changing task security attribute
Date: Thu, 30 Nov 2023 20:35:49 +0000
Message-ID: <20231130203549.5549-1-kamatam@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <41edd3ad-10cf-41bd-b44a-e72bdd0837a3@schaufler-ca.com>
References: <41edd3ad-10cf-41bd-b44a-e72bdd0837a3@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB001.ant.amazon.com (10.13.139.148) To
 EX19D010UWA004.ant.amazon.com (10.13.138.204)

On Thu, 2023-11-30 18:00:13 +0000, Casey Schaufler wrote:
>
> On 11/29/2023 7:07 PM, Munehisa Kamata wrote:
> > Hi Casey,
> >
> > On Wed, 2023-11-29 18:28:55 -0800, Casey Schaufler wrote:
> >> On 11/29/2023 4:37 PM, Munehisa Kamata wrote:
> >>> I'm not clear whether VFS is a better (or worse) place[1] to fix the
> >>> problem described below and would like to hear opinion.
> >> Please To: or at least Cc: me on all Smack related issues.
> > Will do that next.
> >
> >>> If the /proc/[pid] directory is bind-mounted on a system with Smack
> >>> enabled, and if the task updates its current security attribute, the task
> >>> may lose access to files in its own /proc/[pid] through the mountpoint.
> >>>
> >>>  $ sudo capsh --drop=cap_mac_override --
> >>>  # mkdir -p dir
> >>>  # mount --bind /proc/$$ dir
> >>>  # echo AAA > /proc/$$/task/current		# assuming built-in echo
> >> I don't see "current" in /proc/$$/task. Did you mean /proc/$$/attr?
> > Ahh, yes, I meant /proc/$$/attr/current. Sorry about that...
> >
> >>>  # cat /proc/$$/task/current			# revalidate
> >>>  AAA
> >>>  # echo BBB > dir/attr/current
> >>>  # cat dir/attr/current
> >>>  cat: dir/attr/current: Permission denied
> >>>  # ls dir/
> >>>  ls: cannot access dir/: Permission denied
> 
> I don't see this behavior. What kernel version are you using?
> I have a 6.5 kernel.

I verified the behavior with 6.7-rc3. 

Here is more "raw" log from my machine:

 [ec2-user@ip-10-0-32-198 ~]$ uname -r
 6.7.0-rc3-proc-fix+
 [ec2-user@ip-10-0-32-198 ~]$ sudo capsh --drop=cap_mac_override --
 [root@ip-10-0-32-198 ec2-user]# mount --bind /proc/$$ dir
 [root@ip-10-0-32-198 ec2-user]# echo AAA > /proc/$$/attr/current
 [root@ip-10-0-32-198 ec2-user]# cat /proc/$$/attr/current; echo
 AAA
 [root@ip-10-0-32-198 ec2-user]# echo BBB > dir/attr/current
 [root@ip-10-0-32-198 ec2-user]# cat dir/attr/current
 cat: dir/attr/current: Permission denied

If something frequently scans /proc, such as ps, top or whatever, on your
machine, the inode may get updated quickly (i.e. revalidated during path
lookup) and then you may only have a short window to observe the behavior. 

> >>>  # cat /proc/$$/attr/current			# revalidate
> >>>  BBB
> >>>  # cat dir/attr/current
> >>>  BBB
> >>>  # echo CCC > /proc/$$/attr/current
> >>>  # cat dir/attr/current
> >>>  cat: dir/attr/current: Permission denied
> >>>
> >>> This happens because path lookup doesn't revalidate the dentry of the
> >>> /proc/[pid] when traversing the filesystem boundary, so the inode security
> >>> blob of the /proc/[pid] doesn't get updated with the new task security
> >>> attribute. Then, this may lead security modules to deny an access to the
> >>> directory. Looking at the code[2] and the /proc/pid/attr/current entry in
> >>> proc man page, seems like the same could happen with SELinux. Though, I
> >>> didn't find relevant reports.
> >>>
> >>> The steps above are quite artificial. I actually encountered such an
> >>> unexpected denial of access with an in-house application sandbox
> >>> framework; each app has its own dedicated filesystem tree where the
> >>> process's /proc/[pid] is bind-mounted to and the app enters into via
> >>> chroot.
> >>>
> >>> With this patch, writing to /proc/[pid]/attr/current (and its per-security
> >>> module variant) updates the inode security blob of /proc/[pid] or
> >>> /proc/[pid]/task/[tid] (when pid != tid) with the new attribute.
> >>>
> >>> [1] https://lkml.kernel.org/linux-fsdevel/4A2D15AF.8090000@sun.com/
> >>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/security/selinux/hooks.c#n4220
> >>>
> >>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >>> Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
> >>> ---
> >>>  fs/proc/base.c | 23 ++++++++++++++++++++---
> >>>  1 file changed, 20 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/fs/proc/base.c b/fs/proc/base.c
> >>> index dd31e3b6bf77..bdb7bea53475 100644
> >>> --- a/fs/proc/base.c
> >>> +++ b/fs/proc/base.c
> >>> @@ -2741,6 +2741,7 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
> >>>  {
> >>>  	struct inode * inode = file_inode(file);
> >>>  	struct task_struct *task;
> >>> +	const char *name = file->f_path.dentry->d_name.name;
> >>>  	void *page;
> >>>  	int rv;
> >>>  
> >>> @@ -2784,10 +2785,26 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
> >>>  	if (rv < 0)
> >>>  		goto out_free;
> >>>  
> >>> -	rv = security_setprocattr(PROC_I(inode)->op.lsm,
> >>> -				  file->f_path.dentry->d_name.name, page,
> >>> -				  count);
> >>> +	rv = security_setprocattr(PROC_I(inode)->op.lsm, name, page, count);
> >>>  	mutex_unlock(&current->signal->cred_guard_mutex);
> >>> +
> >>> +	/*
> >>> +	 *  Update the inode security blob in advance if the task's security
> >>> +	 *  attribute was updated
> >>> +	 */
> >>> +	if (rv > 0 && !strcmp(name, "current")) {
> >>> +		struct pid *pid;
> >>> +		struct proc_inode *cur, *ei;
> >>> +
> >>> +		rcu_read_lock();
> >>> +		pid = get_task_pid(current, PIDTYPE_PID);
> >>> +		hlist_for_each_entry(cur, &pid->inodes, sibling_inodes)
> >>> +			ei = cur;
> >>> +		put_pid(pid);
> >>> +		pid_update_inode(current, &ei->vfs_inode);
> >>> +		rcu_read_unlock();
> >>> +	}
> >>> +
> >>>  out_free:
> >>>  	kfree(page);
> >>>  out:
> 

