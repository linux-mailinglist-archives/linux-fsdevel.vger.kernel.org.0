Return-Path: <linux-fsdevel+bounces-59994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A740FB4076A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 16:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73625666A2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 14:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2544A3128D6;
	Tue,  2 Sep 2025 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aS955bW1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2867286409
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824123; cv=none; b=Zo4CoxaLaBf8SoPsugdxRh22XwVajPAKufs1WCDaD+ZB8PzTHXQqTOTCoDb/YAOHN3qMyaFTKJiPYfR6wXUii3fiRd6PQCZ7n0g3dfosX0ie93sv6nZ058SN7N/U3GttcjNeWT2kZsEdAcgdYOGGFNU7MRoty65NK0iGIFdWwW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824123; c=relaxed/simple;
	bh=zX91HXmyOgzUJXSIs4tbYCtG/EJfFp0nngH232fUkDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVgGtfNiP02N/GnTgczSg4fuyiR4LyxRwwGgAnAoWKAfFfMn9TXqhUpd8bifEIYTGieYo9YiBewXegx3rhOVeSBszr2kmRXBiRyZtIElrvvpt7aQG4FMzPn0KTo6f+Z+wW4RkTaQ8+CBDnde7aS/3gzTh4P1q7n/JoYAbUCUsyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aS955bW1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756824116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFSqJluOv6H8sdtqhLht5Do87S1VArlDtrsS2zlKOsk=;
	b=aS955bW1UgrXqteSyhMIBJFjcWNr8Mxs16VCCDt3mexJk2WNq/X7XspqMRCaVnd0DyWk2u
	UvZR9AOZGLiggLuFFOfDFktfoTQvrCkyYyy5rjnzELQliidtOrmDfCLN8BBBsdfkAb4XbK
	6JNjwcAP7EfHECByTPrHwyt7InzWpxg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-SY-vWmNSNVCK-6Fc6DtMJg-1; Tue, 02 Sep 2025 10:41:54 -0400
X-MC-Unique: SY-vWmNSNVCK-6Fc6DtMJg-1
X-Mimecast-MFC-AGG-ID: SY-vWmNSNVCK-6Fc6DtMJg_1756824113
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b0419770d19so227630966b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Sep 2025 07:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756824113; x=1757428913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFSqJluOv6H8sdtqhLht5Do87S1VArlDtrsS2zlKOsk=;
        b=v0/SfINYx9RJaLU8k0eyCYiHeIiavMWaAQqZ2W8ZZiKL3oIRHRScfPY6XDjz38TcJE
         bmQ1HWuNWiyiY88Uabq1y6/0FrKKa4f1IvdHT/9TEMKTFsL2npYITPMeKOl1rBXoP+2H
         +y7mzEWtb5nXbvWmsjigK32vUwpiU45SpaYjMkaHInz0nj2r2CL7nJM/mBs1R18T0qNa
         gnvLjQejX6+L1kkGJ6VVaweRVO+stspJQZ2Haw2T4pvwZDNQiXG2lKLgPylvNSE0Evdr
         uAW3ZQ2/fuvWgVMrm3dPWl2GMZms2NmPveRog8qSHMmMwQNNQn1d8D7IOs6z/F3hYGkh
         O0GA==
X-Gm-Message-State: AOJu0YzZCm1nZAxh59XAQLrKsKGnyQFZ9xy5Qp3/yCMc7+mhqaSx6s/b
	BJaRLUO8pMxopVoxe8SEz6GzQuHHvaeguo/BmHuwCY6FMFmAfCm74mGSarSpc6vvRaPu9sEG4xZ
	WWO0x/2YA+dXHtzDhJaCJDyjbX0yCk/qJ/Z56Xl6BNfuS4N9D0JBM+ZA4JshwpRumxCR5+0QAFn
	jnb/fPqqPw8rGDF/W4h1OwI9tMiLLr9VZhK2A2wrUcvbuX3UQq4yrEsQ==
X-Gm-Gg: ASbGncvmZGjnvUhPd6vi/9VuBxMtCpbHyct6AUIZEHKK4ZZaZoz7UJVyQz6VH0PA8n0
	805d8/ioZRXmN6PRdNlB1WwPjoBRTLv4yg7AHQ4lY89c1o/cgja7vQvdrRt3Hc7ICh+157iaKA4
	OsDGeph04/EKTYq0xeCs/k8WrgE7/M6pL7VKlGCq0fyyDiUJ/RuUhk1UO2SSZpkh9StQunBIkUA
	pflu4As+bt6Hcg3zyB2rO8Bl5t4ouFos9oFsvmKvu7dcWwenfDGhzcnhAwi0DbUCmDN0lfemSbP
	+Wuc3gDDo/nbxQJyvNpJht/Oou5cwjC3H5YxIXLhgfb1pD2AnRHGjkNexmd7nd9MJnebvl13JgW
	Lf1wHQDSRnKflw/fiURI2M34=
X-Received: by 2002:a17:907:6d08:b0:afe:8c69:4c3a with SMTP id a640c23a62f3a-b01d9743c4dmr1086362866b.37.1756824112722;
        Tue, 02 Sep 2025 07:41:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQiAbme8EJYAoCntbB1M0/m/x5Lr7fhFiIidEeLFciVhcRnqBmf+Z6mTL3WLEMBBsDYQ0xTQ==
X-Received: by 2002:a17:907:6d08:b0:afe:8c69:4c3a with SMTP id a640c23a62f3a-b01d9743c4dmr1086359566b.37.1756824112160;
        Tue, 02 Sep 2025 07:41:52 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (188-142-155-210.pool.digikabel.hu. [188.142.155.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c77f9sm9704514a12.8.2025.09.02.07.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:41:51 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Jim Harris <jiharris@nvidia.com>
Subject: [PATCH 4/4] fuse: add prune notification
Date: Tue,  2 Sep 2025 16:41:46 +0200
Message-ID: <20250902144148.716383-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250902144148.716383-1-mszeredi@redhat.com>
References: <20250902144148.716383-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some fuse servers need to prune their caches, which can only be done if the
kernel's own dentry/inode caches are pruned first to avoid dangling
references.

Add FUSE_NOTIFY_PRUNE, which takes an array of node ID's to try and get rid
of.  Inodes with active references are skipped.

A similar functionality is already provided by FUSE_NOTIFY_INVAL_ENTRY with
the FUSE_EXPIRE_ONLY flag.  Differences in the interface are

FUSE_NOTIFY_INVAL_ENTRY:

  - can only prune one dentry

  - dentry is determined by parent ID and name

  - if inode has multiple aliases (cached hard links), then they would have
    to be invalidated individually to be able to get rid of the inode

FUSE_NOTIFY_PRUNE:

  - can prune multiple inodes

  - inodes determined by their node ID

  - aliases are taken care of automatically

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c             | 39 +++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h          |  6 ++++++
 fs/fuse/inode.c           | 11 +++++++++++
 include/uapi/linux/fuse.h |  8 ++++++++
 4 files changed, 64 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 1258acee9704..4229b38546bb 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2034,6 +2034,42 @@ static int fuse_notify_inc_epoch(struct fuse_conn *fc)
 	return 0;
 }
 
+static int fuse_notify_prune(struct fuse_conn *fc, unsigned int size,
+			     struct fuse_copy_state *cs)
+{
+	struct fuse_notify_prune_out outarg;
+	const unsigned int batch = 512;
+	u64 *nodeids __free(kfree) = kmalloc(sizeof(u64) * batch, GFP_KERNEL);
+	unsigned int num, i;
+	int err;
+
+	if (!nodeids)
+		return -ENOMEM;
+
+	if (size < sizeof(outarg))
+		return -EINVAL;
+
+	err = fuse_copy_one(cs, &outarg, sizeof(outarg));
+	if (err)
+		return err;
+
+	if (size - sizeof(outarg) != outarg.count * sizeof(u64))
+		return -EINVAL;
+
+	for (; outarg.count; outarg.count -= num) {
+		num = min(batch, outarg.count);
+		err = fuse_copy_one(cs, nodeids, num * sizeof(u64));
+		if (err)
+			return err;
+
+		scoped_guard(rwsem_read, &fc->killsb) {
+			for (i = 0; i < num; i++)
+				fuse_try_prune_one_inode(fc, nodeids[i]);
+		}
+	}
+	return 0;
+}
+
 static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
 		       unsigned int size, struct fuse_copy_state *cs)
 {
@@ -2065,6 +2101,9 @@ static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
 	case FUSE_NOTIFY_INC_EPOCH:
 		return fuse_notify_inc_epoch(fc);
 
+	case FUSE_NOTIFY_PRUNE:
+		return fuse_notify_prune(fc, size, cs);
+
 	default:
 		return -EINVAL;
 	}
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 233c6111f768..fb6604120b53 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1413,6 +1413,12 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
 int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
 			     u64 child_nodeid, struct qstr *name, u32 flags);
 
+/*
+ * Try to prune this inode.  If neither the inode itself nor dentries associated
+ * with this inode have any external reference, then the inode can be freed.
+ */
+void fuse_try_prune_one_inode(struct fuse_conn *fc, u64 nodeid);
+
 int fuse_do_open(struct fuse_mount *fm, u64 nodeid, struct file *file,
 		 bool isdir);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 5b7897bf7e45..a4d361b34d06 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -585,6 +585,17 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
 	return 0;
 }
 
+void fuse_try_prune_one_inode(struct fuse_conn *fc, u64 nodeid)
+{
+	struct inode *inode;
+
+	inode = fuse_ilookup(fc, nodeid,  NULL);
+	if (!inode)
+		return;
+	d_prune_aliases(inode);
+	iput(inode);
+}
+
 bool fuse_lock_inode(struct inode *inode)
 {
 	bool locked = false;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 30bf0846547f..c13e1f9a2f12 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -239,6 +239,7 @@
  *  7.45
  *  - add FUSE_COPY_FILE_RANGE_64
  *  - add struct fuse_copy_file_range_out
+ *  - add FUSE_NOTIFY_PRUNE
  */
 
 #ifndef _LINUX_FUSE_H
@@ -680,6 +681,7 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_DELETE = 6,
 	FUSE_NOTIFY_RESEND = 7,
 	FUSE_NOTIFY_INC_EPOCH = 8,
+	FUSE_NOTIFY_PRUNE = 9,
 };
 
 /* The read buffer is required to be at least 8k, but may be much larger */
@@ -1118,6 +1120,12 @@ struct fuse_notify_retrieve_in {
 	uint64_t	dummy4;
 };
 
+struct fuse_notify_prune_out {
+	uint32_t	count;
+	uint32_t	padding;
+	uint64_t	spare;
+};
+
 struct fuse_backing_map {
 	int32_t		fd;
 	uint32_t	flags;
-- 
2.49.0


