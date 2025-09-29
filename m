Return-Path: <linux-fsdevel+bounces-62978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615DABA7B8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 03:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A6103BE7D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 01:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9670729D295;
	Mon, 29 Sep 2025 01:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="XVMFzDf5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB6328541F
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 01:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107889; cv=none; b=i4C9qgBLb0anwjYX4CtxK1YPhwY+u929x2VoIELJ0+QOfBuzzGNmFCu3aDniG1LzUV4iz8p6HcnFH3PquWbr14jf5thrqQyXV8aRRwfxxUdP1NGCYXeTMG5CSW8GLjnw5ECnODr5hP8gLVztSH8VkP3bKU/AeCgPosx0NWIJ2CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107889; c=relaxed/simple;
	bh=wKkOsRSYJa3vc4lYOd4d9l8kUjqRigmITBj/yOFEkIE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdqMqgW9w4cUC4/RLAi9NU+klaRuPRvvO8Fi2t0foXUgdhumjNFcTK27qNngDT6CUUneLLu/7H6Ch4z0/AFf9+ErNdZBDZpVMd1y5HWeg4BKAUMj9yfrl0tmrGu65Hn2e1KSVYDmsm2LU9XXxWZolvVrdRfM2LhwqpDFBRTOICk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=XVMFzDf5; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-855733c47baso596238185a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 18:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759107885; x=1759712685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5jod2izHbVl6GoMuI25PsEFlFJNITXcz8AeEB8I3yk=;
        b=XVMFzDf55KpUL/PhJzfKCV3iKDZ5TJ0eWvCFG0YemrtrljsavxwxjoXxLTYJVeXaJ/
         godOw6SVBFUcXrgXwopBV1k5CagHO2hm+JLDxxkR+ykmzomjXOiRbvstKUCC56FTOa/U
         Rv7ojf+Ib0S/8DZNajvbPdZ5GKtFFT/Jep+Zkx1PcxUQhkRkmZ9dXS6uDgASRYm04V0N
         GAmUNrBuTrbLvzfxKWffm0+sqsVW1swJCFW6SxLiS29UEc/HhrGcsyjFo7pgAsCuvfft
         SpjsZ53vGFfxC97OzW9hC7vWMtpFUCIXPox2NMQSn5cH75eeizoMDwm4oOsm5jjOvYpY
         /X/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107885; x=1759712685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5jod2izHbVl6GoMuI25PsEFlFJNITXcz8AeEB8I3yk=;
        b=EyYBhBt0fHnSsRtUbmtH0qudzKqfq16Ol8Z1wue2vATBpVGkvkYyDtc/yRplXAymYk
         OZt5hiZpA0EoiFVq2e4iwTCGCdPA+EyhybDzgha+WeSWNbh5a5T1S0+d38oNCcvKgz+m
         akiVoaccanL/92G5lg7pdh1TVTsKF8MMEJCFipfRTF1cfyjBivpmC69pIzjYnZTFYneB
         QiqdrPwiUhR+uu0rCWMSTIDA70BsEL001swNZUS68y8kNlWYnIop9Ida9I7ix5VPc4xF
         G48lm3ReQnCkTlOvK6MRDt7VeB0ITcUHNiOs5kfweZtIEIv7ALpfUIE3U28sfoEnGsd4
         kENg==
X-Forwarded-Encrypted: i=1; AJvYcCVmbEtJkCKKdyzAjKouVD6LBJcJJh+76P1agv3bOd7hkfYY+Hh0iiRpqbZLvO7Zvo48mEJ+7510wI55QUNM@vger.kernel.org
X-Gm-Message-State: AOJu0YyhKjAyYzxl6faHLgUvNKddXfUU/5IEDVZVmT2BOTe8f2/Qp0RP
	UbAjOy9mDXUr89DzcEikynVboghUTOlLB0O7BWSxo21jdXa+n5fhD0U/Ck+7+29r834=
X-Gm-Gg: ASbGnctRUnEcsxXx8DALSqyGTnZG8fyQR2iNJTd/UmzOGD398rliKKXC4M4TdBJ4pCD
	Ee25vXdSX+TfoLgHr4gC2yRQUcQf1wxQvncPqCM35nFy6EML73NpVlwVWXbamYgTfM/NI/rUOGE
	zinyEhhkXPZGAqEJ2F+a8PwxdzqvpKbJ+Vsg3iCTwEHK6Wa0Jv2PgV3BZzY/MMcPpWfZOJ79pM0
	/2mye0XHgGD69VMmS+DZbjJYsaWAgMJ5kIhmeMN0Pkp78qjeMDkSTq1Xt/ZILADtMQXiVuc74yH
	Hs05QmWuiP6NCDiUtG/MtlwUOQk6VvtLKoVD3J2UMEqxsL0IbGIgCr3a73tOdevElZ7QQDwgOoc
	L2JN3TQbMoHUigUViXHORbegxmfl00I+ewz47SCyGbjsfD3jaGSunxU2TOu4U8TWWhSdfPoANdy
	W/wsDplFc=
X-Google-Smtp-Source: AGHT+IHcWK3+r2DO1mFFWuWSG7txN7iCjmZaeFDLs8Xu4WrTbTEg8yxHdhQIyiKJ1YNZRSeC44Oztw==
X-Received: by 2002:a05:620a:618b:b0:85c:809:3f10 with SMTP id af79cd13be357-85c080943d0mr1326429385a.26.1759107884637;
        Sun, 28 Sep 2025 18:04:44 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0c0fbe63sm64561521cf.23.2025.09.28.18.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 18:04:44 -0700 (PDT)
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
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org,
	steven.sistare@oracle.com
Subject: [PATCH v4 22/30] mm: shmem: allow freezing inode mapping
Date: Mon, 29 Sep 2025 01:03:13 +0000
Message-ID: <20250929010321.3462457-23-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
In-Reply-To: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
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
index 650874b400b5..a9f5db472a39 100644
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
@@ -186,6 +194,15 @@ static inline bool shmem_file(struct file *file)
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
index ce3b912f62da..bd7d9afe5a27 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1292,7 +1292,8 @@ static int shmem_setattr(struct mnt_idmap *idmap,
 		loff_t newsize = attr->ia_size;
 
 		/* protected by i_rwsem */
-		if ((newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
+		if ((info->flags & SHMEM_F_MAPPING_FROZEN) ||
+		    (newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
 		    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
 			return -EPERM;
 
@@ -3287,6 +3288,10 @@ shmem_write_begin(const struct kiocb *iocb, struct address_space *mapping,
 			return -EPERM;
 	}
 
+	if (unlikely((info->flags & SHMEM_F_MAPPING_FROZEN) &&
+		     pos + len > inode->i_size))
+		return -EPERM;
+
 	ret = shmem_get_folio(inode, index, pos + len, &folio, SGP_WRITE);
 	if (ret)
 		return ret;
@@ -3660,6 +3665,11 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 
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
2.51.0.536.g15c5d4f767-goog


