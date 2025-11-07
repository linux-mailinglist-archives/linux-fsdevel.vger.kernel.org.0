Return-Path: <linux-fsdevel+bounces-67490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2AAC41B28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 22:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A826634858F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 21:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C603446BC;
	Fri,  7 Nov 2025 21:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="kxI9holv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE5434320C
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 21:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549562; cv=none; b=ebGW13zNUd07LC2LtAh8CG/rq8laEIiu+JbyZYI2GqumaKJqchJw/ybDn3bFBGJzavkUxtCreJM7tbkPQha2EiiOuZACPtp/KhmnQ4JRYd1wxmbRZKnFRD/L6S/ToZLyWoHJSiz4ZxfjJYzI+lLIj+4YPZGtUZWMAelDLJgQA2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549562; c=relaxed/simple;
	bh=UdO7PQgJIrKwVS+KHl4+e5iRRpO/7jhlAMj+9Y3xYzM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngheTueqEDzw+T0gkASRY3Lo0KBGWgHDEueFldf0xv+G3IMFCrtfYGjRJW7q4dPtA/ZzzPGoE/i3OepIsYpCZkPleRyk0Ae1PBQrgD+hk6dQdUaFHvUAsfPuezseKYGyrIAbjYj8SiuuqKf/ysjB4F5J3AAYpFIKSPmzQgtiFhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=kxI9holv; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7866375e943so10895417b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 13:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762549559; x=1763154359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pBi03kAb5JgjRparbbJCSt/bY+/4eC+JKPe6vY7ZjAQ=;
        b=kxI9holv6YqqZ+dIFBnm35F14UXP51jTNA2oeXQFA//v2Y6vplFOnq8gXoLNFUFE3q
         P2xSmDfMQW79Y2bDB4yxvBj5Q48HiYinsHdLuZA6phrojcg1xO7UUUpm/GeKGN++Hp6h
         q0Qtin/mGe5xgFBsyVjgNdbf4vUV3uUZ3i7mE84JEuAFPiGDkY7aHCWNTA8nJjqHMPbC
         XBiry75+QC8RMyTFwxI5FisZvGprfQWH1Nkhjgv7x+/xsFHB+FXTVQhA6gt3nsE7a4Am
         c4tjSJu867NQf6Jci3lsfEfNgOlAllyyZxYbBBUhwaraen14jT2fbtALvO9EJm9yps7m
         BPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762549559; x=1763154359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pBi03kAb5JgjRparbbJCSt/bY+/4eC+JKPe6vY7ZjAQ=;
        b=pu9r6jdfljG1m/TuU+9EPVfYd9C9PQGxCD5nB7Qytl585vrItKfkqWDCxLZiDeNCES
         ZGh9YK78euHU/E3WiMEJmX3jy8dlrYLaAT34MUDudCX1LDeShUq65SuPTcri5lgaN3Pg
         FXv/II7TtwNG0YHYqpIRU5/lyAfwKvuu0nSY5spFysGfynDyifR+5x9Zyfi2Kg+ZIVkD
         9u3p/AlLdlRFrzD+0OLtt5YrTFWvsim+j2whv6Ij3PBFo6dmfoCgW5u3lf1JTbKI7ywh
         Gtn6zUAdJWsYo0Q3xyvnSL8yYtyuM6G0N13f5HdoC14GyAb0JBWWpy8pFcytjRDSn6LU
         qtfg==
X-Forwarded-Encrypted: i=1; AJvYcCXn7yMFdpv/sepZi2F4fR1+u/SwUt9uDdamd9SkU5ugL93tNYVqlXe/M2JljeJhLDgWnIKA1eTlhowkhfj0@vger.kernel.org
X-Gm-Message-State: AOJu0YxHxjuas1OoaIVgtK5VxRbWCl/dnKUJibkvPtE+sSTo6vAKVSCe
	mNc2omNa35uuo6cu0q06rHUMrxOwNkKRGa0a4liLWLg1v6w2G7qImSxsL+H/hp58PMI=
X-Gm-Gg: ASbGncvPpNhuNKaRrABMndj8YZcPGkFJdheEih7TxRvo0dkSVVdxr0JMlnYyH62f/B+
	ImRpeb5qzN7/5ZGclcuU2CfzNdlh9cyX4SjJZLybMvVCXpOEAkZfc1vP7n83InHMlr3VgIIAVuV
	mf1l/cvQk0m8pXfAY5RA9fJS8I3tiKyDJiQuKZ6k70W0bIL9d2UoXa6aLITriW7yukSL+P6Lm1u
	gwjh/b29gokoMW24B4XetUeeHx7DJ+3GvqkJri0K0hjXSeX0Wi1nIU8xB4L1qXi/Ot5LtNQ6noA
	NDmAVDz63kCXKWQnXmp9gf4kxTNRs2WEtpEio1s9yHjiiH31scCSeTG88x+WvupbfRibm6pHAuF
	OucdnEzVwrEmVUOCnyXUSW9bupr0wLKzz0yHE5Oy/fVYubQ0g6wfNAbD/cDolsKir9JPRQCgd3h
	b0MOGoU1bj8J3tE1m7Cwnx2AhL7HuVtfRpN5pKbbjHimMcwL6Yi9atrIXp8U057VZanLU9Ow/BN
	w==
X-Google-Smtp-Source: AGHT+IF+XOrK+gByf7DQ1+IWSR7ui8MkgfcgK6h+y28DPkokKVkVXPGBOJn/sPaYBxN5KAaR0pxqSw==
X-Received: by 2002:a05:690c:760a:b0:787:cde8:b3d5 with SMTP id 00721157ae682-787d543da03mr6084207b3.52.1762549559282;
        Fri, 07 Nov 2025 13:05:59 -0800 (PST)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d68754d3sm990817b3.26.2025.11.07.13.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 13:05:58 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org
Subject: [PATCH v5 14/22] mm: shmem: allow freezing inode mapping
Date: Fri,  7 Nov 2025 16:03:12 -0500
Message-ID: <20251107210526.257742-15-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251107210526.257742-1-pasha.tatashin@soleen.com>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pratyush Yadav <ptyadav@amazon.de>

To prepare a shmem inode for live update via the Live Update
Orchestrator (LUO), its index -> folio mappings must be serialized. Once
the mappings are serialized, they cannot change since it would cause the
serialized data to become inconsistent. This can be done by pinning the
folios to avoid migration, and by making sure no folios can be added to
or removed from the inode.

While mechanisms to pin folios already exist, the only way to stop
folios being added or removed are the grow and shrink file seals. But
file seals come with their own semantics, one of which is that they
can't be removed. This doesn't work with liveupdate since it can be
cancelled or error out, which would need the seals to be removed and the
file's normal functionality to be restored.

Introduce SHMEM_F_MAPPING_FROZEN to indicate this instead. It is
internal to shmem and is not directly exposed to userspace. It functions
similar to F_SEAL_GROW | F_SEAL_SHRINK, but additionally disallows hole
punching, and can be removed.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
Signed-off-by: Pasha Tatashin <pahsa.tatashin@soleen.com>
---
 include/linux/shmem_fs.h | 17 +++++++++++++++++
 mm/shmem.c               | 12 +++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 710b1dd681bf..08f497673b06 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -24,6 +24,14 @@ struct swap_iocb;
 #define SHMEM_F_NORESERVE	BIT(0)
 /* Disallow swapping. */
 #define SHMEM_F_LOCKED		BIT(1)
+/*
+ * Disallow growing, shrinking, or hole punching in the inode. Combined with
+ * folio pinning, makes sure the inode's mapping stays fixed.
+ *
+ * In some ways similar to F_SEAL_GROW | F_SEAL_SHRINK, but can be removed and
+ * isn't directly visible to userspace.
+ */
+#define SHMEM_F_MAPPING_FROZEN	BIT(2)
 
 struct shmem_inode_info {
 	spinlock_t		lock;
@@ -187,6 +195,15 @@ static inline bool shmem_file(struct file *file)
 	return shmem_mapping(file->f_mapping);
 }
 
+/* Must be called with inode lock taken exclusive. */
+static inline void shmem_i_mapping_freeze(struct inode *inode, bool freeze)
+{
+	if (freeze)
+		SHMEM_I(inode)->flags |= SHMEM_F_MAPPING_FROZEN;
+	else
+		SHMEM_I(inode)->flags &= ~SHMEM_F_MAPPING_FROZEN;
+}
+
 /*
  * If fallocate(FALLOC_FL_KEEP_SIZE) has been used, there may be pages
  * beyond i_size's notion of EOF, which fallocate has committed to reserving:
diff --git a/mm/shmem.c b/mm/shmem.c
index 19be8c575647..2e3cb0424a1f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1321,7 +1321,8 @@ static int shmem_setattr(struct mnt_idmap *idmap,
 		loff_t newsize = attr->ia_size;
 
 		/* protected by i_rwsem */
-		if ((newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
+		if ((info->flags & SHMEM_F_MAPPING_FROZEN) ||
+		    (newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
 		    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
 			return -EPERM;
 
@@ -3319,6 +3320,10 @@ shmem_write_begin(const struct kiocb *iocb, struct address_space *mapping,
 			return -EPERM;
 	}
 
+	if (unlikely((info->flags & SHMEM_F_MAPPING_FROZEN) &&
+		     pos + len > inode->i_size))
+		return -EPERM;
+
 	ret = shmem_get_folio(inode, index, pos + len, &folio, SGP_WRITE);
 	if (ret)
 		return ret;
@@ -3692,6 +3697,11 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 
 	inode_lock(inode);
 
+	if (info->flags & SHMEM_F_MAPPING_FROZEN) {
+		error = -EPERM;
+		goto out;
+	}
+
 	if (mode & FALLOC_FL_PUNCH_HOLE) {
 		struct address_space *mapping = file->f_mapping;
 		loff_t unmap_start = round_up(offset, PAGE_SIZE);
-- 
2.51.2.1041.gc1ab5b90ca-goog


