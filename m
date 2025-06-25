Return-Path: <linux-fsdevel+bounces-53023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D0BAE9287
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 01:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E05A6E04FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 23:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A113093D8;
	Wed, 25 Jun 2025 23:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="vv80tNiS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABED306DD5
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 23:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893571; cv=none; b=grvGqTCHt8x6O/ExCJgDpm6L5fgAnwMle9A5OH4Iany7U6sV+J5VpHHk1VIlmd1d3RizdEJkeYvJ9FVNnly1dGz3f2MroIaUHXBlNIphwYXRI4LbdexgT91lrrdfWKnHpd2CuAZSNfmqaODubxd9A6SbEGNttg4N79uH2LHv9jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893571; c=relaxed/simple;
	bh=Mhpgqk+r0SEE0pBbkdly7K40a+AgWRc9ZIiXP1/YEMY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gv6bFBaEN7fquRmL5l3XPDEbDVdHQ1Gohzm95F7i1Vt1rG2SlYS8rCoZHw/kwL1cDdTOHxKwNbpCo+i1FNESk6O9Qi5/oujX2scJGZm7Q8CnO8zNzk+c3tSLHfx/VRsTuo8i3FqvXEjTyHpgS7ujMJcuOhyc69tn92gXGrOYbS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=vv80tNiS; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e812fc35985so335621276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 16:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1750893569; x=1751498369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=98Jyj99BUXTmYd7+cithe+PSs3lV4fLVI7wtqO1MqXk=;
        b=vv80tNiSYye3mwxbHr1kO/yXpqP54HIUz8vmfdCkwK9fFUrTH5uB0LPHEJuYpnP+ux
         oIsraVe9QgB2MCxKuxLwKOOnwzO2LmEFMm3NaeH8wBQjIw4oc+M3TGBlnP+fBgAmOpjj
         C1aBDe1dGG2pHu6u65BvPGcb9w/lGoqpjwgrvXHlgxIBU38PIUD7gYIcCgiFEnlkbZeO
         2l5y7PX8gYxiJXUcY8k/x+/pzx219Y49rjXt/pxqqvWVnEKHbfq6QkB2vQxIb9+n5Gdn
         xeeSOxwWnKQ8SRbGU8FoGa8Vlnivy0a84VIm7ExTh1ScOuHX54YdY6GwAh5875rFL3og
         5HUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750893569; x=1751498369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98Jyj99BUXTmYd7+cithe+PSs3lV4fLVI7wtqO1MqXk=;
        b=PNxezUT7fJpWEjPXAZD+0qZMT3U8xD0JJvr08ZcuMuDhYJKE6p6TaCakVT7Bi9mi3m
         ICqpyAGMf8lxsV+gk3k8JxmLB3tAKcCB88FTsuRLsvypztL8dP0wDeqNq7K27H0oVKOW
         pO/T7vRX+TmEQBhLHh9MphMR0sVpQgv2TOjTvFUZR36xiOarLtx720acbbMjffWzafDj
         dUtGZHF3nNTlTcuorSRdXWAoDB09ItDa3EbW4EbSmOzdoPURlNbxs04w93jq+dnFkkVO
         7Wk0ad1FxBIwePX+5u9Ey1OLq+gkXhDyVO9X1iVe4XSPEhMmu1VD7aI+rakYlLd/Mpyo
         B6OA==
X-Forwarded-Encrypted: i=1; AJvYcCXyAMLZul8vvPpGrKOSUBa6Qiur6wLz1niNXgyWkVMR1iSNZvPPvh5/oPVCcOTQhwemfxD/t/275at6Z7Ka@vger.kernel.org
X-Gm-Message-State: AOJu0YyzcQrFw3NzS8F9IrSTF74tX1kfA3tX9jdTgFbMcFaOy6SvGuhq
	u8uQTu7AxkhsyBPXpzl8Nzpcf2cYvuthiy9no8qEp9ngE69ZeyPDFykBAPs6BNKn5eA=
X-Gm-Gg: ASbGncssEbMYIJiv2bbdNVZtTQyuhORtfz1OLX2z7MSswUNZlji8y12AE7/HjEd7Vrm
	iGkHnt/qZGnO1MsKDtFQAUseXcYPDnVyB83tvDoZkn+sQgrzRKtUgRwyAzTUYfvItO9urt5fGuH
	No4lda/SoG1PtVqBXSrT54RDmGQjkXDkEysEfMNpg8+LJsFUFli7UN7rbKkavlgDrNwnUNDwsW5
	MIo7lO7e6Jyb0VXv4gFulYu98G5Zj8d/l02lqb2F4kK/hQkLoeCrvMzZHVnLAG0e6NPIiLoKg7K
	xA9kiXxucIikc8YhJOebE7AgQ+JnI96YDp6fTZu2IqwA837YdNBSHpz1vv/SkmQ368uf7FavgIj
	7Q5bRL9RkaKo6DNnZ0hD9LdbXwuCk2So+qfq+RblAO8H+stL7S4wt3p9BtfnCK5Q=
X-Google-Smtp-Source: AGHT+IF8jNEFtQnuXkjTXZtOG0o687rs+JjV2eGPA9YX8TPfu5/LIAkdaGG0i8hzaFHLmFqpeuhnQw==
X-Received: by 2002:a05:6902:e12:b0:e7d:ca07:ae7d with SMTP id 3f1490d57ef6-e86017c3da5mr6432810276.33.1750893568719;
        Wed, 25 Jun 2025 16:19:28 -0700 (PDT)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac5c538sm3942684276.33.2025.06.25.16.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:19:28 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
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
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 26/32] mm: shmem: allow freezing inode mapping
Date: Wed, 25 Jun 2025 23:18:13 +0000
Message-ID: <20250625231838.1897085-27-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
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
index 578a5f3d1935..1dd2aad0986b 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -22,6 +22,14 @@
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
@@ -183,6 +191,15 @@ static inline bool shmem_file(struct file *file)
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
index 953d89f62882..bd54300be9df 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1297,7 +1297,8 @@ static int shmem_setattr(struct mnt_idmap *idmap,
 		loff_t newsize = attr->ia_size;
 
 		/* protected by i_rwsem */
-		if ((newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
+		if ((info->flags & SHMEM_F_MAPPING_FROZEN) ||
+		    (newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
 		    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
 			return -EPERM;
 
@@ -3291,6 +3292,10 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
 			return -EPERM;
 	}
 
+	if (unlikely((info->flags & SHMEM_F_MAPPING_FROZEN) &&
+		     pos + len > inode->i_size))
+		return -EPERM;
+
 	ret = shmem_get_folio(inode, index, pos + len, &folio, SGP_WRITE);
 	if (ret)
 		return ret;
@@ -3664,6 +3669,11 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 
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
2.50.0.727.gbf7dc18ff4-goog


