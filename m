Return-Path: <linux-fsdevel+bounces-42882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B606CA4AADE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 13:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742F31896001
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 12:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B7E1DE3C0;
	Sat,  1 Mar 2025 12:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhNK5VMM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7BA23F37D
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Mar 2025 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740830790; cv=none; b=B5uq6T86xKl5z5XHM0SxQxeTyVtkih+E4/7yybg4E0qGuSQdKNtzJGKQQpd2pLNGh/ob14jXnfiIyf1H+uTP6zV74SeC1F0H3rbXBWzGUAVIKE8mfR+XSaS0Uk40RxlbQKvusQwDpfJkZveUjPDLWSNBvExeGTAAzZ64tjYccSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740830790; c=relaxed/simple;
	bh=ws1j9ytenM624OjJV8Pctf/WdyBpYfhecWcq/Ar2PzE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H8Z8R53cM7dViy6+GWd5xJ2gBMaoVepjMlSR4wFa1o5Bxts842bU0xTLtQXmXjErUvzTtr6gsVwmiopx+W0CdUbjCyOG9xSa6tnMF2tq5s6wHfQ3KPqYoGdyHU/AyXDjE9ePVNJQbHauULgqydDeqdxXtk5IPCUbBh5pe71kzPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhNK5VMM; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f488f3161so1778224f8f.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Mar 2025 04:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740830787; x=1741435587; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VWhntrUquze1leZAPdNLHKNSZh6KZ6By81qZsQvHnwg=;
        b=FhNK5VMMW3vUW8shQsmpDTbJfDO8bMhqp1gFykz5G50nhNR/n7bKW27G6KCGShZXMc
         dTsdQ5Uc6dF586uTRkpxeQXrBMUTgWzVMPnlOB26UF0VnzCB8aFGBYr3sc05hDGFXrD/
         Fs3By83bMMaZPeQafGuOpEz4UzLt5f5757QS3vCnZO5n9MltPW61N+Y37x+Zre1bJf/v
         HeXHUKsFmt3wEd9sy14ymIVMF9Sf0dvlaxxxJ1q3m2ODWtNIL6Fxa0GG04oPAiOIGJal
         alHUiNMHcqDBJCIYEnSEi263F+KC4L0mLQPVBLHIAOjbzDCtQLVfAvtlgX73G3APWLpC
         X+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740830787; x=1741435587;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VWhntrUquze1leZAPdNLHKNSZh6KZ6By81qZsQvHnwg=;
        b=p801i0ELsuQNAQLRIFYK36uO3ORbtBbvjlqVK+RtDuH5noAxRMiAgMFqIU9tcZ4sg5
         eCIOZWFlRkvsr+He86H1eC9KVKHY53b1/fOVLzROaXFdzYHe9dM+O8lX0S9SKLYkJD27
         EoAB1C8MnmsxoEo8pdTaQk40lr0TVig+kj7e6C7dubbrJAy6olEYF8yoofYqR+FfDW8T
         q7QYKdK9AwourX1JFjuRqEmuuaV8tUPHzdG2PIpxoVjMQCil9UWQ/x2VZS7tYgjpw/Kg
         Io8BMLHqF8B/0rVi1dh0e8G8WsTuujQ7uNoHr3bZv+tz7dL42Prm/dgoolrU+7Dse+rH
         KkeQ==
X-Gm-Message-State: AOJu0YwT+8mhQ62ib8VDMGGMKcvRwOyC167FIfIsMpI8/Snu71JMxW2K
	JtxXMTB3SGHUtGvBUtxiSiUbq9w82i2V76aIJrOebvp0/pSbgK8=
X-Gm-Gg: ASbGncubd9DB9mxzKAkS80Du4D2GFERAVzz2dXkKKdqFseqB16xC7WBCc7SyvnhHLkb
	Z9ru+tZ+zyvvV+q8pN7n6NPm06GFcn9OtjL3pacibXennJfmKxz+q6HmoHZ3b2qZvwTRTPM0uEg
	jfUhMg6GpWG36lku/Pd/1P6nfWLn3sMHLs/TPxOqBi15HmRpC2naOh83YRchbfdma36g+38lBEC
	S19F2e/92BxzVNdLHgjBjWGuv+9gKnkHYHCzqS1CKlpEvO2n1Q6cg1J2zMPdrqE1vCKtG8fuecb
	ThLkdeRWo8mb+aZkEv2A+h9QOAOQuqN/Hdif0s7JuHX634heGpshSpYDIeuvADV20gf7PqMhqlf
	K2a3Euzrvm2JJBw==
X-Google-Smtp-Source: AGHT+IH9frZl8nxLqzUHLjKsTJ0x4WaLg9FtnIwlrwxjgoJyl7bJipJkxojYMejnML9kR8lDMJr27g==
X-Received: by 2002:a05:6000:156d:b0:38d:d701:419c with SMTP id ffacd0b85a97d-390eca07090mr5854130f8f.41.1740830787043;
        Sat, 01 Mar 2025 04:06:27 -0800 (PST)
Received: from p183 (dynamic-vpdn-brest-46-53-133-113.brest.telecom.by. [46.53.133.113])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e48445c5sm8119850f8f.78.2025.03.01.04.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 04:06:26 -0800 (PST)
Date: Sat, 1 Mar 2025 15:06:24 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	"David S. Miller" <davem@davemloft.net>,
	Ye Bin <yebin10@huawei.com>
Subject: [PATCH v2] proc: fix UAF in proc_get_inode()
Message-ID: <3d25ded0-1739-447e-812b-e34da7990dcf@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

From: Ye Bin <yebin10@huawei.com>

Fix race between rmmod and /proc/XXX's inode instantiation.

The bug is that pde->proc_ops don't belong to /proc, it belongs
to a module, therefore dereferencing it after /proc entry has been
registered is a bug unless use_pde/unuse_pde() pair has been used.

use_pde/unuse_pde can be avoided (2 atomic ops!) because pde->proc_ops
never changes so information necessary for inode instantiation can be
saved _before_ proc_register() in PDE itself and used later,
avoiding pde->proc_ops->... dereference.

      rmmod                         lookup
sys_delete_module
                         proc_lookup_de
			   pde_get(de);
			   proc_get_inode(dir->i_sb, de);
  mod->exit()
    proc_remove
      remove_proc_subtree
       proc_entry_rundown(de);
  free_module(mod);

                               if (S_ISREG(inode->i_mode))
	                         if (de->proc_ops->proc_read_iter)
                           --> As module is already freed, will trigger UAF

BUG: unable to handle page fault for address: fffffbfff80a702b
PGD 817fc4067 P4D 817fc4067 PUD 817fc0067 PMD 102ef4067 PTE 0
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 26 UID: 0 PID: 2667 Comm: ls Tainted: G
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
RIP: 0010:proc_get_inode+0x302/0x6e0
RSP: 0018:ffff88811c837998 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: ffffffffc0538140 RCX: 0000000000000007
RDX: 1ffffffff80a702b RSI: 0000000000000001 RDI: ffffffffc0538158
RBP: ffff8881299a6000 R08: 0000000067bbe1e5 R09: 1ffff11023906f20
R10: ffffffffb560ca07 R11: ffffffffb2b43a58 R12: ffff888105bb78f0
R13: ffff888100518048 R14: ffff8881299a6004 R15: 0000000000000001
FS:  00007f95b9686840(0000) GS:ffff8883af100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff80a702b CR3: 0000000117dd2000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 proc_lookup_de+0x11f/0x2e0
 __lookup_slow+0x188/0x350
 walk_component+0x2ab/0x4f0
 path_lookupat+0x120/0x660
 filename_lookup+0x1ce/0x560
 vfs_statx+0xac/0x150
 __do_sys_newstat+0x96/0x110
 do_syscall_64+0x5f/0x170
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Note:
don't do 2 atomic ops on the common path as original patch did
	--adobriyan

Fixes: 778f3dd5a13c ("Fix procfs compat_ioctl regression")
Signed-off-by: Ye Bin <yebin10@huawei.com>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/generic.c       |   10 +++++++++-
 fs/proc/inode.c         |    6 +++---
 fs/proc/internal.h      |   14 ++++++++++++++
 include/linux/proc_fs.h |    7 +++++--
 4 files changed, 31 insertions(+), 6 deletions(-)

--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -559,10 +559,16 @@ struct proc_dir_entry *proc_create_reg(const char *name, umode_t mode,
 	return p;
 }
 
-static inline void pde_set_flags(struct proc_dir_entry *pde)
+static void pde_set_flags(struct proc_dir_entry *pde)
 {
 	if (pde->proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
 		pde->flags |= PROC_ENTRY_PERMANENT;
+	if (pde->proc_ops->proc_read_iter)
+		pde->flags |= PROC_ENTRY_proc_read_iter;
+#ifdef CONFIG_COMPAT
+	if (pde->proc_ops->proc_compat_ioctl)
+		pde->flags |= PROC_ENTRY_proc_compat_ioctl;
+#endif
 }
 
 struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
@@ -626,6 +632,7 @@ struct proc_dir_entry *proc_create_seq_private(const char *name, umode_t mode,
 	p->proc_ops = &proc_seq_ops;
 	p->seq_ops = ops;
 	p->state_size = state_size;
+	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_seq_private);
@@ -656,6 +663,7 @@ struct proc_dir_entry *proc_create_single_data(const char *name, umode_t mode,
 		return NULL;
 	p->proc_ops = &proc_single_ops;
 	p->single_show = show;
+	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_single_data);
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -656,13 +656,13 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
 
 	if (S_ISREG(inode->i_mode)) {
 		inode->i_op = de->proc_iops;
-		if (de->proc_ops->proc_read_iter)
+		if (pde_has_proc_read_iter(de))
 			inode->i_fop = &proc_iter_file_ops;
 		else
 			inode->i_fop = &proc_reg_file_ops;
 #ifdef CONFIG_COMPAT
-		if (de->proc_ops->proc_compat_ioctl) {
-			if (de->proc_ops->proc_read_iter)
+		if (pde_has_proc_compat_ioctl(de)) {
+			if (pde_has_proc_read_iter(de))
 				inode->i_fop = &proc_iter_file_ops_compat;
 			else
 				inode->i_fop = &proc_reg_file_ops_compat;
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -85,6 +85,20 @@ static inline void pde_make_permanent(struct proc_dir_entry *pde)
 	pde->flags |= PROC_ENTRY_PERMANENT;
 }
 
+static inline bool pde_has_proc_read_iter(const struct proc_dir_entry *pde)
+{
+	return pde->flags & PROC_ENTRY_proc_read_iter;
+}
+
+static inline bool pde_has_proc_compat_ioctl(const struct proc_dir_entry *pde)
+{
+#ifdef CONFIG_COMPAT
+	return pde->flags & PROC_ENTRY_proc_compat_ioctl;
+#else
+	return false;
+#endif
+}
+
 extern struct kmem_cache *proc_dir_entry_cache;
 void pde_free(struct proc_dir_entry *pde);
 
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -20,10 +20,13 @@ enum {
 	 * If in doubt, ignore this flag.
 	 */
 #ifdef MODULE
-	PROC_ENTRY_PERMANENT = 0U,
+	PROC_ENTRY_PERMANENT		= 0U,
 #else
-	PROC_ENTRY_PERMANENT = 1U << 0,
+	PROC_ENTRY_PERMANENT		= 1U << 0,
 #endif
+
+	PROC_ENTRY_proc_read_iter	= 1U << 1,
+	PROC_ENTRY_proc_compat_ioctl	= 1U << 2,
 };
 
 struct proc_ops {

