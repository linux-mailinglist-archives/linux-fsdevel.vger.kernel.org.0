Return-Path: <linux-fsdevel+bounces-69817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC81AC861A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 18:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C41363B45A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 17:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC79232FA19;
	Tue, 25 Nov 2025 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="RHTRwS3T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2C532A3D4
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 16:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089972; cv=none; b=KVyIa2t04ndgmQ4qzvju6uvOldI0SxntmGVu0TxA7QoIFgj9kp+abrtJzz5vTS5BCaRYYLYU/7BeCOvH8UOdTQFXpitbq///TZwz0RwfNM297HP/uR8LAgnlbSv1j/XKzIcJ7GlzxCdc4AGrVw9v0wiqjCxa2OFmhxne2ZvRF0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089972; c=relaxed/simple;
	bh=v9x1l0vuGtuabHoTMFaYXgKBzUw5ntyOjf/K0GgYcpQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAjhTgoqipkljjT8q8I7n9suVacZX/Oef6yBTTByz/9ezEBCjO1bRANvLIL+Rxl6yp8ByuYgyqJe3ZWMOYeZw2Htc6+Q/qCrZiPkk2x3odNouVAVVZSe5ZSD1vh4PcJxzoxVp21a0ZBgWxKgOhcBoIG5JuD069Ii3ZsupqZuqW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=RHTRwS3T; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-78aa642f306so24805167b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 08:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764089969; x=1764694769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLwSseklhA0qKOMy2cW44bpZPsfi2vW7qm+LuafppIg=;
        b=RHTRwS3TjRxpHzWC/9ffzr7awvtTYzVC/0U1YqseCVowNj/dj8nGzpSJqTycG4IaDq
         GCr2a+udzcuwCfRBPYazhM8QKRikvGRtZy7XRFieZ9jwTFgeVgjKLeXugMN9gELR9iRr
         kNNO/I3ne61l9VgD8XNgtlbPxJzCuFeoxLmEnQ8Vm6XqTzGEROQxbsZc8uRrCY4jpncj
         z3Wc3PEAWLGPVwFype8cqGHkYRfjBN4up/Hb1Qcr7FhLYTYQV61bIicobWa0QRPp7HJd
         rOlixgWvqOB6AROT4kxNDrLH4Yz6SAbesWFUMwdhZUAHcyQwa9WyBlYI6O9Ao03k7Vds
         Yoeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764089969; x=1764694769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rLwSseklhA0qKOMy2cW44bpZPsfi2vW7qm+LuafppIg=;
        b=PQIGEFyQJ+oiJXViun+ZdDZZQu4gSjibY/6+dXaize7HeQB8K/5EnrLWaGCIu+E1Uw
         1frbbjQLYxhBiOxaAtYErfRHGKr5R3Jv3NVOuLMbBaQgXhwu/MkkY+m2y4GYhc0yKKhy
         pYxFnM90vxwFZ8eT13mC6tc+V//LFdaP3TMhwJl3s1XGOA6v0nWRA6z6hve/89t4IkrT
         pFXI5alMhimpF4yGA0BVbiu81gyD/sPrzRv451mxjJLwR9qRAf3QxdMy3YlkbYyjc4Xf
         FcdCIee8U5RaHl4Gs9PUrhGBKhuLi5PRXwLdJWbmd/ZLCjEIS+FZu/De7w/lvKKHNfTd
         o0fg==
X-Forwarded-Encrypted: i=1; AJvYcCXQgKLX89RknWbOLcQNjt2tUVbDQeB62D4KyUfCIEIrss62Yynoe+1MLrTarIAlqexWOLKhIt9KFtcOyX39@vger.kernel.org
X-Gm-Message-State: AOJu0YwctEL9K3NW4UuqGOQKG3XgVZpO6hVbYKg8rQmes0IjUAHk4V64
	exjd3sK8fpwntI3le5fpwUl4daWgpype4hmX+nqDMPhpng1m35NFVf8pyrspkQQlLf4=
X-Gm-Gg: ASbGncvOr93B1J1KNsJ7V8zG/gwNTeCqgZgqeMrPhFUxHwSZzmgbwweMyVWEFDLRijR
	6dH9nrgqzJcjzSLbelWoobEuNshFb7yrtYUC285fXANtxN8kyS6XiFfoL/BJgGaKo24RvH2nd7+
	3W/qm6IWWQAwYh2HVLtcfgUNpf3cWHTMvz7dvOhpvUXZh7qsiaM7tTiDPuYRcAFWSaPrQ4SZBYq
	JbhziUfN1qLnJKWLpJJ3K4N3k2btUq3Qr7GohHn62U2Ge5i+qFRHA+8qdVqrV8+LNYt7sskJLhr
	NG3XH88T8SY6T2s+nAHxJYAGefRIYKTnkvPSMU+bhFmbxZ9Ys9uG1xgOX5ILXrdM00yFwboELmv
	2URWcFrvvd0A5hGQJNJh10UCXD4l60qRsY/6hcHzWfcFogIEJNMxJwkJ/QpcWl5HnmgqIn7q9M9
	z3jxOMnJ2DNvci2GFexUzw0t7gsX/KgRlFoS+KmNzTbDkHptPTM+56Lrlap44rFcHxSMBJEIUjv
	Bc=
X-Google-Smtp-Source: AGHT+IHyOGiEIWn7K/FqPN8HAm8rR5ND4rL8A082/WWeW+u5rZ2m5KAWzpxwpgtD4aV75ucYKtS3TQ==
X-Received: by 2002:a05:690c:4b08:b0:788:1086:8834 with SMTP id 00721157ae682-78ab6d811b4mr30671357b3.12.1764089968779;
        Tue, 25 Nov 2025 08:59:28 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a798a5518sm57284357b3.14.2025.11.25.08.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:59:28 -0800 (PST)
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
Subject: [PATCH v8 11/18] mm: shmem: allow freezing inode mapping
Date: Tue, 25 Nov 2025 11:58:41 -0500
Message-ID: <20251125165850.3389713-12-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
In-Reply-To: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
References: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pratyush Yadav <ptyadav@amazon.de>

To prepare a shmem inode for live update, its index -> folio mappings
must be serialized. Once the mappings are serialized, they cannot change
since it would cause the serialized data to become inconsistent. This
can be done by pinning the folios to avoid migration, and by making sure
no folios can be added to or removed from the inode.

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
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/shmem_fs.h | 17 +++++++++++++++++
 mm/shmem.c               | 11 +++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 650874b400b5..d34a64eafe60 100644
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
+static inline void shmem_freeze(struct inode *inode, bool freeze)
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
index 1d5036dec08a..786573479360 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1297,6 +1297,8 @@ static int shmem_setattr(struct mnt_idmap *idmap,
 			return -EPERM;
 
 		if (newsize != oldsize) {
+			if (info->flags & SHMEM_F_MAPPING_FROZEN)
+				return -EPERM;
 			error = shmem_reacct_size(SHMEM_I(inode)->flags,
 					oldsize, newsize);
 			if (error)
@@ -3289,6 +3291,10 @@ shmem_write_begin(const struct kiocb *iocb, struct address_space *mapping,
 			return -EPERM;
 	}
 
+	if (unlikely((info->flags & SHMEM_F_MAPPING_FROZEN) &&
+		     pos + len > inode->i_size))
+		return -EPERM;
+
 	ret = shmem_get_folio(inode, index, pos + len, &folio, SGP_WRITE);
 	if (ret)
 		return ret;
@@ -3662,6 +3668,11 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 
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
2.52.0.460.gd25c4c69ec-goog


