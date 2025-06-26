Return-Path: <linux-fsdevel+bounces-53085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEA5AE9E0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 15:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EBBB7AE8D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 12:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448832E5404;
	Thu, 26 Jun 2025 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WO50tawx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ED41D5CD7;
	Thu, 26 Jun 2025 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750942867; cv=none; b=sQSSd4qcfAVqfl8e+ABC89PPn2GKXuaXpcC8LwWhlR2R4u+e6OMyqS2aC4jvrGtaam5kuDPQg3RlNYwMhg9Lc/95Ljb9xNa7PYn09GmFtpVM5x57AYiSfKE+RbAreg6/VW0zS+eZ/W1Nudx7IACuS6ajOKVKSRr77hQBvTNCv14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750942867; c=relaxed/simple;
	bh=p4+eXCQGMR9TWXBMv8y3A7wqhzvhbL3bNYb1Q71TM/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fv0Ez3t4C2NEDGDyyNCcXEftdEJJZHZsPBIgvyQuaQbm3JDGaeFFd+uncQcPZLDbH42NzCs3iX9+8SGVy8L2pVs/eFY1RYW+12C/pasox8AxRhOBKHeB748UxEIC/k1nq1s+bEehQKj3FVwLr8XdfUpZosA9m4z/6YJokKFG7mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WO50tawx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01354C4CEEB;
	Thu, 26 Jun 2025 13:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750942867;
	bh=p4+eXCQGMR9TWXBMv8y3A7wqhzvhbL3bNYb1Q71TM/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WO50tawxIGQ06se51mzA9l/QQLICo0jdAR6OV4L11SY3W4xXWwfSSjdssiglQgbwL
	 eZZxS3EsXxw3Shq08+OWHJBAqPCxx4iDeXMnLOeOwgseINi66n6UYrtKJD3cnqcinU
	 XgbkmNLMcWrJcSyvMCP4xverSA2HWJXEtXdCmmAbsg2xm2W9BwPO7lgUOBMEsGHN0Y
	 UHgSgVTsddG+9qGcLdQM1QtAt1OFtvIntbZCDjT6sJxPYgvGEbNnD9h1l0Lpv/Xvm8
	 MZ0tjnfrsEJ0+jb/3LwnUrfV+nSYUtJ43Irz9/Y0A59IxrAOkQSMOe/jD1jjkBp9ZX
	 pvbC+xSrgVbuw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org,  jasonmiu@google.com,  graf@amazon.com,
  changyuanl@google.com,  rppt@kernel.org,  dmatlack@google.com,
  rientjes@google.com,  corbet@lwn.net,  rdunlap@infradead.org,
  ilpo.jarvinen@linux.intel.com,  kanie@linux.alibaba.com,
  ojeda@kernel.org,  aliceryhl@google.com,  masahiroy@kernel.org,
  akpm@linux-foundation.org,  tj@kernel.org,  yoann.congal@smile.fr,
  mmaurer@google.com,  roman.gushchin@linux.dev,  chenridong@huawei.com,
  axboe@kernel.dk,  mark.rutland@arm.com,  jannh@google.com,
  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
  dan.j.williams@intel.com,  david@redhat.com,  joel.granados@kernel.org,
  rostedt@goodmis.org,  anna.schumaker@oracle.com,  song@kernel.org,
  zhangguopeng@kylinos.cn,  linux@weissschuh.net,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-mm@kvack.org,  gregkh@linuxfoundation.org,  tglx@linutronix.de,
  mingo@redhat.com,  bp@alien8.de,  dave.hansen@linux.intel.com,
  x86@kernel.org,  hpa@zytor.com,  rafael@kernel.org,  dakr@kernel.org,
  bartosz.golaszewski@linaro.org,  cw00.choi@samsung.com,
  myungjoo.ham@samsung.com,  yesanishhere@gmail.com,
  Jonathan.Cameron@huawei.com,  quic_zijuhu@quicinc.com,
  aleksander.lobakin@intel.com,  ira.weiny@intel.com,
  andriy.shevchenko@linux.intel.com,  leon@kernel.org,  lukas@wunner.de,
  bhelgaas@google.com,  wagi@kernel.org,  djeffery@redhat.com,
  stuart.w.hayes@gmail.com,  lennart@poettering.net,  brauner@kernel.org,
  linux-api@vger.kernel.org,  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 25/32] mm: shmem: use SHMEM_F_* flags instead of VM_*
 flags
In-Reply-To: <20250625231838.1897085-26-pasha.tatashin@soleen.com>
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
	<20250625231838.1897085-26-pasha.tatashin@soleen.com>
Date: Thu, 26 Jun 2025 15:00:57 +0200
Message-ID: <mafs01pr6u06u.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi all,

On Wed, Jun 25 2025, Pasha Tatashin wrote:

> From: Pratyush Yadav <ptyadav@amazon.de>
>
> shmem_inode_info::flags can have the VM flags VM_NORESERVE and
> VM_LOCKED. These are used to suppress pre-accounting or to lock the
> pages in the inode respectively. Using the VM flags directly makes it
> difficult to add shmem-specific flags that are unrelated to VM behavior
> since one would need to find a VM flag not used by shmem and re-purpose
> it.
>
> Introduce SHMEM_F_NORESERVE and SHMEM_F_LOCKED which represent the same
> information, but their bits are independent of the VM flags. Callers can
> still pass VM_NORESERVE to shmem_get_inode(), but it gets transformed to
> the shmem-specific flag internally.
>
> No functional changes intended.

I was reading through this patch again and just realized that I missed a
spot. __shmem_file_setup() passes VM flags to shmem_{un,}acct_size(),
even though it now expects SHMEM_F flag. Below fixup patch should fix
that.

--- 8< ---
From d027524e390de15af1c6d9310bf6bea0194be79f Mon Sep 17 00:00:00 2001
From: Pratyush Yadav <ptyadav@amazon.de>
Date: Thu, 26 Jun 2025 14:50:27 +0200
Subject: [PATCH] fixup! mm: shmem: use SHMEM_F_* flags instead of VM_* flags

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
---
 mm/shmem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 6b13eb40e7dc2..83ae446f779ef 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5809,8 +5809,10 @@ static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
 /* common code */
 
 static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
-			loff_t size, unsigned long flags, unsigned int i_flags)
+			loff_t size, unsigned long vm_flags,
+			unsigned int i_flags)
 {
+	unsigned long flags = (vm_flags & VM_NORESERVE) ? SHMEM_F_NORESERVE : 0;
 	struct inode *inode;
 	struct file *res;
 
@@ -5827,7 +5829,7 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
 		return ERR_PTR(-ENOMEM);
 
 	inode = shmem_get_inode(&nop_mnt_idmap, mnt->mnt_sb, NULL,
-				S_IFREG | S_IRWXUGO, 0, flags);
+				S_IFREG | S_IRWXUGO, 0, vm_flags);
 	if (IS_ERR(inode)) {
 		shmem_unacct_size(flags, size);
 		return ERR_CAST(inode);
-- 
Regards,
Pratyush Yadav

