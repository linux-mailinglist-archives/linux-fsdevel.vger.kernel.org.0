Return-Path: <linux-fsdevel+bounces-68584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB32C60D74
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 00:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0DC7A353FEA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 23:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85914299AB5;
	Sat, 15 Nov 2025 23:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="abUQnKFp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EBB29ACD7
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 23:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763249687; cv=none; b=SP4+R5EqJhMjvC7sQvcr/JIGPvy3fRuBaUE7Cf4ZcErcb8oXgdVNLxoV4vZqp+B3s5+hettUWFR+BBFQp7+d6BCcunlScDDy2LFualR6xafSpg/y3KsSKRKHW/yqSxmv3U/83Ov4BUZdKHnc7zQisG9TWuA2PyYMELErH+eTK2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763249687; c=relaxed/simple;
	bh=h2vjGzbBg4AU2ifY5ek+1jbDzqzMBe5yccYCDtitHbo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bh16/l9HO7gK+/5VxIs/htyKcTAC9M4Vi/gbWM4K5NMwJOAFrqfQQOtSVWQ7B1IBjdvRQLbhNxf1N4aMp1dEC/DhI8OKvZFGhwjhERKmBIDVnvrpfytZ+Gymo/mwrEIkJcmJJWVtvrVYmKri+rwauO6qqE9rFG9BncHaTqFSOvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=abUQnKFp; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63e1e1bf882so2603278d50.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 15:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763249684; x=1763854484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjp2i+yn5YhJt0E9Cm6hXiIeiW1VzlvDXGR3nMqDfIY=;
        b=abUQnKFpmpaAioTjEc5MaZxSqpGfaR0hBJjJPKmL7grHOerbjdMmY/E/rnBdz4Zhp+
         4f4MzmBxe2yXt3/aZ8GGFg3PoDEr0EK9xI2QfWEyy5kxcZO6eokfC88/6rrn3r0elnUl
         6rmp6vVwi3S5b7+HYnCUfC35j+v8fLarRvPWy/tys6dv+Vit9G/k0UpS4BI0rn469xk2
         efuYF2WtmLWf1gnPhZzveTFPrdjrOG92+HC59YwQe98cWvLIgZ7GRWxqkv1RKmlNyG/7
         T07zhjiovMSPdvCvYYZYNQRa3zmMRuValDIePY9NCniS5ueEd+/NrWk8XrfQ3w1ykU0B
         i/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763249684; x=1763854484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rjp2i+yn5YhJt0E9Cm6hXiIeiW1VzlvDXGR3nMqDfIY=;
        b=wOfNe2gkdbOPIEzlejvMahS3O8nihfZR3DTb5EOVmRPRrKMEIyFPIzIhdgk0lf0lN5
         kQgQ8KtZOeIZ+BvuJDjIj8NsTfFIfI0hz+nNJxyR9w/dmENAbSaHjg+wSHrHbr//HDtA
         NLjIsCAiC9jMjfxR99eOHN9pbjwka/OJSvNalvka4r2ngS+qemdQ5rFjfVcVZ1bWSoni
         d33azHoOLSaQPbcc91payyt4oiyITv4kdY/uqJGgb93krnbNNVBAIv/947H0xEGOuUFt
         7/zFy1NReO6HuiNzyDXKVLgq2zi4CdO1GSkg584ccxIRA1g1mYOXz1k5+oLs1dR+cMHa
         MJ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNKdMIVAJrVOId1uLSZyvjV6d7wowYiZaFVZabQOwRbV/CM/JydxLDbWpQMiXaWRzXrdofCPYqVOygY17+@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi/8/OlgihTN8ZMY2ZQ4eIxQbvucvUf5THIRakhyFPdoMDRkq7
	87iZcHwvNdaiAWxerqu4uSsu48MgMN2Te0fLVd/hQiD6sUUzw0E0We/CacQNe2ygidg=
X-Gm-Gg: ASbGncttaHLXggVKmnbtbLXcE0ajylI01UJ7c79elPGiPzxVvVxnjWFtbMe8QXyVjDa
	dyETxne552cr3hlpwBZB6XCDmOL3jqpJCyK3RNCT8hEnRRpL1nBWufDi4vSiDWjMfjmN5ckextE
	hhA8k0EzTvPfLbQ4iON7VtW4qQZJoMLdeV4uqg4uEMeB1vg/+1uyqkHExhdUDfWUBnUeeBWJMtA
	vX7Nex/mf7vr6HpKA6uqfAQctLIadlRSJYKoclB8KqiC6ZQK8kY6BlYSwYGUkF1x2xqNJfUptql
	J/Ai1xOhMfZC7WnKDbo816v66K8QmRpH64sxTwUslQ/i0IH03hRxfvv0t5TIa09RFDS8Kahagjb
	6dWE12Cd81tS11zYeXCnK6nqA/QC39ehX1DeAtTOagN1ttbuE8CR2Sxgo75AFVm2ulPlnZUHiBO
	PpHkuYtXp+Ns+z+8oOlbljUNN5vzDq52sBCQKrCTcL3MjEUUMuMGf1R6r4fV1TgHZKhMWLYcA0a
	XREoZ4=
X-Google-Smtp-Source: AGHT+IEqQqw8FjtFSAai2c9iP1dDJFDaXC1XcmhVkOppI5F0MwDFeehYvZcQ8y1up6QBmlqTCYD2LA==
X-Received: by 2002:a05:690c:7408:b0:787:d456:2e62 with SMTP id 00721157ae682-78929ed2da6mr132263187b3.33.1763249683921;
        Sat, 15 Nov 2025 15:34:43 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7882218774esm28462007b3.57.2025.11.15.15.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 15:34:43 -0800 (PST)
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
Subject: [PATCH v6 12/20] mm: shmem: allow freezing inode mapping
Date: Sat, 15 Nov 2025 18:33:58 -0500
Message-ID: <20251115233409.768044-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251115233409.768044-1-pasha.tatashin@soleen.com>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
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
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
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
index 1d5036dec08a..05c3db840257 100644
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
 
@@ -3289,6 +3290,10 @@ shmem_write_begin(const struct kiocb *iocb, struct address_space *mapping,
 			return -EPERM;
 	}
 
+	if (unlikely((info->flags & SHMEM_F_MAPPING_FROZEN) &&
+		     pos + len > inode->i_size))
+		return -EPERM;
+
 	ret = shmem_get_folio(inode, index, pos + len, &folio, SGP_WRITE);
 	if (ret)
 		return ret;
@@ -3662,6 +3667,11 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 
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
2.52.0.rc1.455.g30608eb744-goog


