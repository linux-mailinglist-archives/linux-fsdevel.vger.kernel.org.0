Return-Path: <linux-fsdevel+bounces-47864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAD0AA6433
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 21:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280714A5612
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 19:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C1022578C;
	Thu,  1 May 2025 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="2inv52Tw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169522288C0
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 May 2025 19:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746128596; cv=none; b=mQk0K+xsCmfewfc+mPDvPLYTWZwVvr4PI3Y9q7T+gO8YGozn/4E/Adt5iY7FFJBtHqpPKft+B4PrsQC2RNPGiJXuHhX9qYzy6bnQZhBEZQs8WhBM27yPHtsqbqmurSiTx697RhbuDVuPozSX2/IGj4ciRkz/ZmoB1oAa47TiHd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746128596; c=relaxed/simple;
	bh=Qlw96zmMGwb4MvpdHK1mBI13urZDXQDO3zR6AcSYDUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XoHEjZfH81Y90zfwaH+RmXgkslX+tnNIq1QipzLS6BMdb0OuPX5qPFKrrSIgTf1zCJ2QLYjB9yIuY0rL2cptDkKf+utuXmyoJgyzyj7jpLwQ/q/51HlqoE3/CdpetYS04JVPmD2nSv8wsh2P+k4yRXyh1QEEZhdQvZ++vQ4OXGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=2inv52Tw; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso1925167b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 May 2025 12:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1746128592; x=1746733392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKuOTjRzfAtrB6DFEozUKn3GSt0zQlk92+VKe5OQ3fY=;
        b=2inv52TwLjfQ4OOyUCTFq8D+/V6k2xdov/IcYTKMgrebdBLUi66GpWn/4QPdZj5+pq
         sk0oExMr1jxhje5m4Gp69DMMrQe1c3I+REEiQ4hcZm8PVwT/t2huZdbnwK201ImHWYGy
         vjGd3rS86o3MCiEkP8L0e7zHSyjbbsmfDDYzFq6VR0zzqCDbTMuDlc0RehOqPW2xAnlb
         LkHYC5cH6qkHC3tcflB3soCUzZgAFT2NHPH7PSyrq0G9FnqmeJ37OapyjNrb145bVFn/
         yI0I04xD8uNStNzy95uevmAfyUWOEhosH/c9cY13BqcF2plZ+Oqcn+RpI1gEelOcLCK3
         C7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746128592; x=1746733392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKuOTjRzfAtrB6DFEozUKn3GSt0zQlk92+VKe5OQ3fY=;
        b=sR1OuKO1JFwCXDcKKy5fuU0Wkx0jzy1z8qJHOUhQMh7Fq4Pc0vP5TwDf7jHC1uD/2Q
         dswJXFeBN7tyhtujR+yFN8vvjtfX6+CRzmJXIqXz1H4wwgfCEUy9KdmAvFdtx+ZGBm1J
         7FY72Q2gt8+8Diuy2VKz6+IANYQIiU8Q95iTXN+Y7qj4veO7bcgqWbcUqr06BsqE+CP+
         fN4FIfO+Lz5r6hq548nJ3xHLX4FNG5jJuMuzBDa+Hz0MZpBwMssEPP0m+w/OzcUc18fJ
         2HkeBxJry268uTG8+0rB/zSeLqmLP70Ipcnujni4UZYRCLDc+GieVEjf2iDU2gKezmOY
         W6GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEYV1kWOFXViCdr0l1ilXy9FSLds2LFFbly1jRQjkX/UlCKtz9EPRvpkPPexvntJhqifNwSe6Rss4jJU34@vger.kernel.org
X-Gm-Message-State: AOJu0Yw95/Der9Ri49a6pyf3snNhcKpGlaAJ4YSUfr1ajX6qo0zsgbqA
	QRZ5wDOSp0OTY17sYGAs1alX6eZ2ib2PyJbxYW0aCnMigtwKEErYCV/UTLkGELE=
X-Gm-Gg: ASbGncs4DGbWdkcQgnQz3+HRxs/afpG96qwHCiRM6ChtpDcZQXsAX0xB/pO0o5c6pYF
	fnXBN7FQ6IXjwzXTYJVMagXnU6KOVMxk1l3VwoLOqHHYkWNIfKyOv42dkqKk6xm97KxMbTUqpDG
	zWFKmTmGO4gaCrdCoVmefnBZ8styqfiTudTXdrMX1KGLxraWceBVycZqhDWY4Hcda/9oV4ZpRWm
	ZuXHAhMJ5duX5arOf48kBAcSaUj524d6zx9mDWFJH9hOyIYm3f1zfsiB8ngPjBHTyDKmHmBN2l2
	7rcvG332Q9CZ5vrE6i3XeOi2ENkDzlYuxwgm5eqKfMqa73juSyPnzfgrEw==
X-Google-Smtp-Source: AGHT+IFBY/vwQtnJX3EGSQ5xn9qNCaUXSy6ba87sY+Hksmpz96KowjcefUgUVPK4XtggQ5M3GXExxg==
X-Received: by 2002:a05:6a00:f0c:b0:736:3c2b:c38e with SMTP id d2e1a72fcca58-74058a42afcmr311937b3a.13.1746128592273;
        Thu, 01 May 2025 12:43:12 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:7a9:d9dd:47b7:3886])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058dc45basm50882b3a.69.2025.05.01.12.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 12:43:11 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [RFC PATCH 2/2] ceph: exchange BUG_ON on WARN_ON in ceph_readdir()
Date: Thu,  1 May 2025 12:42:48 -0700
Message-ID: <20250501194248.660959-3-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501194248.660959-1-slava@dubeyko.com>
References: <20250501194248.660959-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

This patch leaves BUG_ON() for debug case and
introduces WARN_ON() for release case in ceph_readdir()
logic. If dfi->readdir_cache_idx somehow is invalid,
then we will have BUG_ON() in debug build but
release build will issue WARN_ON() instead.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 fs/ceph/Kconfig | 13 +++++++++++++
 fs/ceph/dir.c   | 21 ++++++++++++++++++---
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/Kconfig b/fs/ceph/Kconfig
index 3e7def3d31c1..dba85d202a14 100644
--- a/fs/ceph/Kconfig
+++ b/fs/ceph/Kconfig
@@ -50,3 +50,16 @@ config CEPH_FS_SECURITY_LABEL
 
 	  If you are not using a security module that requires using
 	  extended attributes for file security labels, say N.
+
+config CEPH_FS_DEBUG
+	bool "Ceph client debugging"
+	depends on CEPH_FS
+	default n
+	help
+	  If you say Y here, this option enables additional pre-condition
+	  and post-condition checks in functions. Also it could enable
+	  BUG_ON() instead of returning the error code. This option could
+	  save more messages in system log and execute additional computation.
+
+	  If you are going to debug the code, then chose Y here.
+	  If unsure, say N.
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index acecc16f2b99..c88326e2ddbf 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -614,13 +614,28 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		spin_lock(&ci->i_ceph_lock);
 		if (dfi->dir_ordered_count ==
 				atomic64_read(&ci->i_ordered_count)) {
+			bool is_invalid;
+			size_t size;
+
 			doutc(cl, " marking %p %llx.%llx complete and ordered\n",
 			      inode, ceph_vinop(inode));
 			/* use i_size to track number of entries in
 			 * readdir cache */
-			BUG_ON(dfi->readdir_cache_idx < 0);
-			i_size_write(inode, dfi->readdir_cache_idx *
-				     sizeof(struct dentry*));
+
+			is_invalid =
+				is_cache_idx_invalid(dfi->readdir_cache_idx);
+
+#ifdef CONFIG_CEPH_FS_DEBUG
+			BUG_ON(is_invalid);
+#else
+			WARN_ON(is_invalid);
+#endif /* CONFIG_CEPH_FS_DEBUG */
+
+			if (!is_invalid) {
+				size = dfi->readdir_cache_idx;
+				size *= sizeof(struct dentry*);
+				i_size_write(inode, size);
+			}
 		} else {
 			doutc(cl, " marking %llx.%llx complete\n",
 			      ceph_vinop(inode));
-- 
2.48.0


