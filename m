Return-Path: <linux-fsdevel+bounces-55159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2765CB07644
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 14:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 857847BC8D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 12:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10B02EE98E;
	Wed, 16 Jul 2025 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxggHGh2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001E6170826
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670404; cv=none; b=BchvyM+1GdmxstY8NQl1HTZIrCS6DitFVGoY8ljYw0vfak7qHND+QFDahaxX1frpMmwNZUSyz22PTB5yc9Y5sGIo3bmANHvBgbjHRvD8taj/LYcXlfKMLeGMWn2xfaJwHCQaDHDNQgLPZBMbWJRJijVsQU6jHqJYBfjKPuIN8Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670404; c=relaxed/simple;
	bh=BsvDFx4+49Q6o8Rcl2e2Zm0DICrtLa745KWw+KwB71Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YzJ5l07WvrZfZD6mj/RGgUaLpUhaZLGNiwiqMuf6ka3Jh3QJIM6LxrBvqJfyavhesNctm549ZNyhKHuNXJfToVtcsg1U2PVS5nbUH6RvStB5fqvLGA/pMF2nXw7/4XU8KgSV1u8WTmZZZnpsrN861SDwyYQjPO6lKZbojxZSuuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxggHGh2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234fcadde3eso81160665ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 05:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752670402; x=1753275202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7v9UE+axtIC5Ks9HZIoSS5uMQmJVO7tEdSxldK/Fals=;
        b=CxggHGh2kOUszwVRoxn1Eqx4BcediZlEnpH5DTzd2XAS16A0DceEGXXLy3RLniTGE0
         EU+2PdpJjSVDL4e7vbcnYHft9PeVJHrWA576GwF0Itl6hbbIXFmKiHGu9Ht+NX1N4uYu
         SQ96BaigpTU33QLI8JvMfy3I2n2BTlvAHnwwntlI7kzFXHASjk3wP2QpvnGEiEiIhnU5
         FxZtUcVTp2XwFQg5MHZMN+4s2L39w9UDByBeCN00dTMoFB/C82JYJQuHRjDZY4bEDp0e
         gAetnyBg9LLc8hT+xSWFAx1nQhMt43v6NMbS/9Pu8mgVxEGfhuJQKIa8MNnxO8dZglKT
         mQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752670402; x=1753275202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7v9UE+axtIC5Ks9HZIoSS5uMQmJVO7tEdSxldK/Fals=;
        b=Bzk3ukVMIb1G2RLWn7cmw55UBqRR93r6BPmb0+EW3EEI1dKJtgcY2LWUAvxIFPKG4O
         g5RINTxrPOcN2yWtdDooSevidsfrbuHEAIV5YYAYm2FlpI2vxw+sMVrarF2cvlfCwOF4
         CfCeYm3LNn8dJluoMNCZsvehKKHKnmDmwv3+sLlpqiBavaoa4hSsUEjnnFGIV5z0lScv
         5GJvcljvE6J/bf8suhCwFWK31aA2mQuPQK1X98p5n3omidJpYzrkIGNbsoS+RuG6CmZE
         H/6bbI3JV/yfBxYWTPsoPT2wDcdULXzuifpGMxhk2p6Z6a+nK9jW6LBT97UUTHjr9akW
         87ig==
X-Gm-Message-State: AOJu0YxrW4abl6h1mNxrBkOXeAWt4HWQr7OvDf9s8MEfp9SbtanuVwUv
	B5BYMznVC6k6uaVcTtFQElvPdGjc1A4G3DFPvbB3/vJx+z+hj12Vsumw20LDLJD34+E=
X-Gm-Gg: ASbGnct0BgP4KSaAzHSuVbkmvFszk8R+eHN6uLhDrGcr4YywSBirFYSbQf09bo9iTD8
	bb9pk0DJladUNDjc4fj061pEbCbz1z43c/q8b+DY1CIwHJXLekvUGjIAIMvyIRVu/oHYFjCYpic
	yKbo3JHd9c46QTqe0z5otl/KuB28gK0aV3jqsMAetNfpvcqSO2qa+4ZgAj3yZODgfQOXnA/wr5p
	jbAAzxPRo03WyAKmT11ibisKW68RpPOgmwJK1v8hX0Q7YawdAAtOuRn3T1El8gnPDUXlsuA6sVT
	RB2k49dixYM6ioBSeeQJA6QlNZ0XsjY/tRYGSsSqDv0VqWVG5oKG2p2gjQ==
X-Google-Smtp-Source: AGHT+IG4VEsOgQ19D/t5/CHEYswZcvXVrOobtjd7JvfqYIoSSS0fDTmSWPchwP2jDboExqhM/Z7OTg==
X-Received: by 2002:a17:902:dac9:b0:23d:dd63:2cd9 with SMTP id d9443c01a7336-23e25780c52mr48893915ad.46.1752670402323;
        Wed, 16 Jul 2025 05:53:22 -0700 (PDT)
Received: from localhost ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f287c19sm1461443a91.31.2025.07.16.05.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:53:22 -0700 (PDT)
From: Alex <alex.fcyrx@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org,
	paulmck@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Alex <alex.fcyrx@gmail.com>
Subject: [PATCH] fs: Remove obsolete logic in i_size_read/write
Date: Wed, 16 Jul 2025 20:53:04 +0800
Message-ID: <20250716125304.1189790-1-alex.fcyrx@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logic is used to protect load/store tearing on 32 bit platforms,
for example, after i_size_read returned, there is no guarantee that
inode->size won't be changed. Therefore, READ/WRITE_ONCE suffice, which
is already implied by smp_load_acquire/smp_store_release.

Signed-off-by: Alex <alex.fcyrx@gmail.com>
---
 include/linux/fs.h | 41 -----------------------------------------
 1 file changed, 41 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4ec77da65f14..7f743881e20d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -952,39 +952,10 @@ void filemap_invalidate_lock_two(struct address_space *mapping1,
 void filemap_invalidate_unlock_two(struct address_space *mapping1,
 				   struct address_space *mapping2);
 
-
-/*
- * NOTE: in a 32bit arch with a preemptable kernel and
- * an UP compile the i_size_read/write must be atomic
- * with respect to the local cpu (unlike with preempt disabled),
- * but they don't need to be atomic with respect to other cpus like in
- * true SMP (so they need either to either locally disable irq around
- * the read or for example on x86 they can be still implemented as a
- * cmpxchg8b without the need of the lock prefix). For SMP compiles
- * and 64bit archs it makes no difference if preempt is enabled or not.
- */
 static inline loff_t i_size_read(const struct inode *inode)
 {
-#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
-	loff_t i_size;
-	unsigned int seq;
-
-	do {
-		seq = read_seqcount_begin(&inode->i_size_seqcount);
-		i_size = inode->i_size;
-	} while (read_seqcount_retry(&inode->i_size_seqcount, seq));
-	return i_size;
-#elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPTION)
-	loff_t i_size;
-
-	preempt_disable();
-	i_size = inode->i_size;
-	preempt_enable();
-	return i_size;
-#else
 	/* Pairs with smp_store_release() in i_size_write() */
 	return smp_load_acquire(&inode->i_size);
-#endif
 }
 
 /*
@@ -994,24 +965,12 @@ static inline loff_t i_size_read(const struct inode *inode)
  */
 static inline void i_size_write(struct inode *inode, loff_t i_size)
 {
-#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
-	preempt_disable();
-	write_seqcount_begin(&inode->i_size_seqcount);
-	inode->i_size = i_size;
-	write_seqcount_end(&inode->i_size_seqcount);
-	preempt_enable();
-#elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPTION)
-	preempt_disable();
-	inode->i_size = i_size;
-	preempt_enable();
-#else
 	/*
 	 * Pairs with smp_load_acquire() in i_size_read() to ensure
 	 * changes related to inode size (such as page contents) are
 	 * visible before we see the changed inode size.
 	 */
 	smp_store_release(&inode->i_size, i_size);
-#endif
 }
 
 static inline unsigned iminor(const struct inode *inode)
-- 
2.48.1


