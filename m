Return-Path: <linux-fsdevel+bounces-11142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 448EB851A57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 18:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7D21F244E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012323D972;
	Mon, 12 Feb 2024 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AvnKSH0O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900923D560
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757196; cv=none; b=Ufm0eggQX3TmUUwfd50Y6Da9nNz0aqvDTOTe61msiEzqVl6iM2LPC91k/Of4lhyr8ZGpg1tf4gcV4pVpLFeQkjaORF7npC7Sm0w3m+b2TENZYR7/7hleRO9oZnjyCNydcv18o75ZiVqjfSgvn1Iwil0Ha2SxnpLUvV94tAMt4eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757196; c=relaxed/simple;
	bh=grAu43Eie92E+XOQ7d04C6cdM5uR0Ox/AK1rLCL9Nso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q7+OKLEzAjelb8ourgbOXe4hpF0HftHLpyphpm4vi5G+S3sEj+2vPwkkxzkMa2f8KJXOUzoy5DcXpTENHsKvW4rGwrIYj6G6HgeGyW+cA+cBKT9F0kit7mO3+wLP7HOw5SU/2AqPBCqpUCQCrIIH5zfV1ELEyAjgullhtmrCbbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AvnKSH0O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707757193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qXH4oA7cWAgzu2mxLxXFHd34t/bbMKvcNeTx3/w9/Kc=;
	b=AvnKSH0OREyC5LKGLWcTU+tBkaCZQxdVTi8BD5GAmFv7x63WKH5wHbBjcP/mTwsPsnq3rN
	SuGu/wsAZNZ3rFxvc0mU33uU1/+kCSvmOL87nH3hQs+OPc2SMYBAUUlX2lbx37TburxvJz
	Cv0wXEqbcHZEj54JazIxVg97M4zNVuE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-aH-5MCfuPfGkxphcimzSPA-1; Mon, 12 Feb 2024 11:59:52 -0500
X-MC-Unique: aH-5MCfuPfGkxphcimzSPA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5611e1da4c6so2258296a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 08:59:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757191; x=1708361991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXH4oA7cWAgzu2mxLxXFHd34t/bbMKvcNeTx3/w9/Kc=;
        b=XmBv7Jmwlyf3YzGJDTAfEluEQPhPY0TzKYVTWsl+PEKvTI91N7XjrKMV9It7BqIG0P
         cL676v/SzhdQrBQXmm1foZJRVxQpi3KqhqpgfFWZ1NErqvdsKbhDJGjDZx6nv0aPRQYe
         crKt2B0alvWpjUfmWfFDryd4G0qboK4ne8tFUOFzN8AyB/o+NVBelRfXW/9QPDyDP7a6
         233Wr0k2DgX2WVmL62PSee3S3+9zE5H7FxEYSUbj3h2BYF6s+HpOEZVNAvRnIfEAOuyr
         G3V8UJI8eTyxu1Ht9J40L53wJzms/Jhb65yjZIFQwVjRSWHhTt7y5NGgHHItm2U279vt
         kUfg==
X-Forwarded-Encrypted: i=1; AJvYcCWaDbkQRMFVrdwc/Ro/oErq+BhaG6AJHUkk3eyKOA8UAkP9J3OTTw//UeSUI4VpaTSyHSFodDn1WtQ1ClIcIHHaDD5YdS74yO3iu2p6zg==
X-Gm-Message-State: AOJu0YwXI8WNPZ8Y25XFJ4Xuzm2O4WNQo5YmjTXf4etmFpZIuaKsYLae
	uS51TGaCAzAxrQzbdVpfViJr13GjQpWUyFTgbH0b8yV+C5QpgtMUe1w/15Ait2CPC5XzGSzGMaj
	MJOLwzvzpR5mMT3TFvRigB081WKEFYa2bGNQGnMgUtGRi3Ulj6kSxEdPUbPw9UAn03JZQDg==
X-Received: by 2002:aa7:d7d4:0:b0:560:f198:2487 with SMTP id e20-20020aa7d7d4000000b00560f1982487mr5725041eds.25.1707757190727;
        Mon, 12 Feb 2024 08:59:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLTFCgjo7kG8sCDmOGPNpbHgDlSUUvJl8h+Af/sj+QMHQFJDSJruZtXYf+qgH+oOeYv5g8Jg==
X-Received: by 2002:aa7:d7d4:0:b0:560:f198:2487 with SMTP id e20-20020aa7d7d4000000b00560f1982487mr5725032eds.25.1707757190528;
        Mon, 12 Feb 2024 08:59:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUfEo4gBfEtirxv7HSr/88kXx7viNjV4HuFhlzUNIiY6IyNW2AWYmZVS4vQmlg90MWz21goBMarPo6dXNa+9eqUrYrm+vCO3BlCUvfdJ6ynwFiac43yD1m01qUPoWkHG1jp/r9sPnS4/ER4K+0uXiJmHEn0AzD/xStG3C/M/vXIdJWHySWWcXmngt8x2D0+veb4zPn8QcxNwCDm59PtK4BSAsixgL9l2cON1i6+AKvcLXm8nxCWUt+4Glmj41+v
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id 14-20020a0564021f4e00b0056176e95a88sm2620261edz.32.2024.02.12.08.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 08:59:50 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>,
	Eric Biggers <ebiggers@google.com>
Subject: [PATCH v4 01/25] fsverity: remove hash page spin lock
Date: Mon, 12 Feb 2024 17:57:58 +0100
Message-Id: <20240212165821.1901300-2-aalbersh@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240212165821.1901300-1-aalbersh@redhat.com>
References: <20240212165821.1901300-1-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The spin lock is not necessary here as it can be replaced with
memory barrier which should be better performance-wise.

When Merkle tree block size differs from page size, in
is_hash_block_verified() two things are modified during check - a
bitmap and PG_checked flag of the page.

Each bit in the bitmap represent verification status of the Merkle
tree blocks. PG_checked flag tells if page was just re-instantiated
or was in pagecache. Both of this states are shared between
verification threads. Page which was re-instantiated can not have
already verified blocks (bit set in bitmap).

The spin lock was used to allow only one thread to modify both of
these states and keep order of operations. The only requirement here
is that PG_Checked is set strictly after bitmap is updated.
This way other threads which see that PG_Checked=1 (page cached)
knows that bitmap is up-to-date. Otherwise, if PG_Checked is set
before bitmap is cleared, other threads can see bit=1 and therefore
will not perform verification of that Merkle tree block.

However, there's still the case when one thread is setting a bit in
verify_data_block() and other thread is clearing it in
is_hash_block_verified(). This can happen if two threads get to
!PageChecked branch and one of the threads is rescheduled before
resetting the bitmap. This is fine as at worst blocks are
re-verified in each thread.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/verity/fsverity_private.h |  1 -
 fs/verity/open.c             |  1 -
 fs/verity/verify.c           | 48 ++++++++++++++++++------------------
 3 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index a6a6b2749241..b3506f56e180 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -69,7 +69,6 @@ struct fsverity_info {
 	u8 file_digest[FS_VERITY_MAX_DIGEST_SIZE];
 	const struct inode *inode;
 	unsigned long *hash_block_verified;
-	spinlock_t hash_page_init_lock;
 };
 
 #define FS_VERITY_MAX_SIGNATURE_SIZE	(FS_VERITY_MAX_DESCRIPTOR_SIZE - \
diff --git a/fs/verity/open.c b/fs/verity/open.c
index 6c31a871b84b..fdeb95eca3af 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -239,7 +239,6 @@ struct fsverity_info *fsverity_create_info(const struct inode *inode,
 			err = -ENOMEM;
 			goto fail;
 		}
-		spin_lock_init(&vi->hash_page_init_lock);
 	}
 
 	return vi;
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 904ccd7e8e16..4fcad0825a12 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -19,7 +19,6 @@ static struct workqueue_struct *fsverity_read_workqueue;
 static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
 				   unsigned long hblock_idx)
 {
-	bool verified;
 	unsigned int blocks_per_page;
 	unsigned int i;
 
@@ -43,12 +42,20 @@ static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
 	 * re-instantiated from the backing storage are re-verified.  To do
 	 * this, we use PG_checked again, but now it doesn't really mean
 	 * "checked".  Instead, now it just serves as an indicator for whether
-	 * the hash page is newly instantiated or not.
+	 * the hash page is newly instantiated or not.  If the page is new, as
+	 * indicated by PG_checked=0, we clear the bitmap bits for the page's
+	 * blocks since they are untrustworthy, then set PG_checked=1.
+	 * Otherwise we return the bitmap bit for the requested block.
 	 *
-	 * The first thread that sees PG_checked=0 must clear the corresponding
-	 * bitmap bits, then set PG_checked=1.  This requires a spinlock.  To
-	 * avoid having to take this spinlock in the common case of
-	 * PG_checked=1, we start with an opportunistic lockless read.
+	 * Multiple threads may execute this code concurrently on the same page.
+	 * This is safe because we use memory barriers to ensure that if a
+	 * thread sees PG_checked=1, then it also sees the associated bitmap
+	 * clearing to have occurred.  Also, all writes and their corresponding
+	 * reads are atomic, and all writes are safe to repeat in the event that
+	 * multiple threads get into the PG_checked=0 section.  (Clearing a
+	 * bitmap bit again at worst causes a hash block to be verified
+	 * redundantly.  That event should be very rare, so it's not worth using
+	 * a lock to avoid.  Setting PG_checked again has no effect.)
 	 */
 	if (PageChecked(hpage)) {
 		/*
@@ -58,24 +65,17 @@ static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
 		smp_rmb();
 		return test_bit(hblock_idx, vi->hash_block_verified);
 	}
-	spin_lock(&vi->hash_page_init_lock);
-	if (PageChecked(hpage)) {
-		verified = test_bit(hblock_idx, vi->hash_block_verified);
-	} else {
-		blocks_per_page = vi->tree_params.blocks_per_page;
-		hblock_idx = round_down(hblock_idx, blocks_per_page);
-		for (i = 0; i < blocks_per_page; i++)
-			clear_bit(hblock_idx + i, vi->hash_block_verified);
-		/*
-		 * A write memory barrier is needed here to give RELEASE
-		 * semantics to the below SetPageChecked() operation.
-		 */
-		smp_wmb();
-		SetPageChecked(hpage);
-		verified = false;
-	}
-	spin_unlock(&vi->hash_page_init_lock);
-	return verified;
+	blocks_per_page = vi->tree_params.blocks_per_page;
+	hblock_idx = round_down(hblock_idx, blocks_per_page);
+	for (i = 0; i < blocks_per_page; i++)
+		clear_bit(hblock_idx + i, vi->hash_block_verified);
+	/*
+	 * A write memory barrier is needed here to give RELEASE semantics to
+	 * the below SetPageChecked() operation.
+	 */
+	smp_wmb();
+	SetPageChecked(hpage);
+	return false;
 }
 
 /*
-- 
2.42.0


