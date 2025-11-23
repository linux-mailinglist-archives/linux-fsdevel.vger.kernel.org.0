Return-Path: <linux-fsdevel+bounces-69585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95141C7E893
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 23:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 876234E1107
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 22:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C1819DF8D;
	Sun, 23 Nov 2025 22:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExMtn78q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556F727FD6E
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 22:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763938309; cv=none; b=KoGxnDeeIova64O4qTXm2RGId2FNO3xSAVYFeeX0ng8ixyY3ZdFAOOedF5DJoD2pYdBSirV4WOQ3kot7guzarS+OJxm3dsxs2KOZufRdwy0pAwUZABvv38zW5maBCOM/V9+u1+PYnRjMB++yUWAYwr/7TclTVm6mtK5KV1l4pH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763938309; c=relaxed/simple;
	bh=2QAhGEFKNmLFH3rV8w4M1xXti7VQ8PITqhdQLrQ5sfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrOs1m5yTAUvjtWynYbTxpcycXj7u/MoOoHY5uTBycxMbE8kpnH+qVdXxG9C0Yk3fJjIFGHqoEI2URvNDdVVI52XLlUVfxswDq7VECsvlwCId6uwEo67a0rkWQjYqiL2hqjrri68n2n3OrFNHHbtSBTzKvUswIMygBVSlQAMEGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExMtn78q; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b31c610fcso3194228f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 14:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763938306; x=1764543106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6fykkTkHS7qppZkkxaQlxQiAfIqxjHL5zv+seY74S0=;
        b=ExMtn78q7qR6pIUKU/7VGEUjfVV6bk4JomIs0V7n3OZ75PBi4JcasAliBmf1wTvoyx
         b92OsjRkMwvIJuHVXeRbVuryPNFAwkzKf4EGn7EO8szNtfK1k5krVOdZmS8No32ZESGv
         ImPPNTwX7bmkJ1IhqUNvIU76EZji1bIfOQtq1ljfyidK+oNXUJ7XWwa6MNxvVFiP8HHs
         B48v9HxDqE527c99oqmHROtvLt21uqMQkqSXO9ArUQjRm7NuOAtbNBiuF1oPNo1YAURf
         n7K4uaIjeMzrer6TJnVDiPQbQLbmf5Oe9zgZDmAiVIE3QFQMktiqlGywBqIateN1ldED
         3Ohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763938306; x=1764543106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g6fykkTkHS7qppZkkxaQlxQiAfIqxjHL5zv+seY74S0=;
        b=mAn4S5zqNOPIHsI0nBHeALAAgrga7Hl7yrlNBZm0CJl4jF0X2qoK1KazVNcx+naBPb
         v48LakBYqRQqh1+32/+UxyWWI0fYPj8tp8QP5FsfbK9LZ+BXdTy25CHUHUrIcUyNvw/J
         aHpy7zZsLbptt4V7O4DdxBaJ8nybzXS+diYC1pQt6oG782362KtbCU5oQDimpXUtucjW
         ItTYJVgYqMm6xzUdG2V9xiBwI9jFh11HZpsA47bA3AKA0w7FN+8UOXlVzlPJ+4+CfHrd
         lO8MGAgi6560juMI808fjr9CoGHVLJkcRFsmN40kGH6+PEjiB02FcL0hO0YN3QlQbUnh
         itSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhbtIPMNQ+J/1X68lsFs+ab8fhQK3HkfkYt1zF7rpjgFQQ6K9sMnQlpykh0KBYnfSa0wGzykpw+gozbtye@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1x0C6hdWZaeo2fWO5ZD3v2kCVTdChIZH02rPdxKYVbCvGG8ql
	K4Xek+RXPbsOp41m0HH6QS92X9cksHLtwewjlgd3vYKgE13idQnOdryf
X-Gm-Gg: ASbGnctVX4ymTh8ty8BQJ485nM3BNARTLjZ8yFTd8OhdTJp9Oi6hZPSEWWziU4cPgt3
	AdwEvnJR6iZr7PJTKOO2YenhEpsX8l+0rWsJ2VpJFWmvJsEdr7UL07URHZ/y6Ma3QT1vMg8YURy
	EYo/O+a8fatroF4YzT/puZHY1NFslF1GrSUFXFX+XvsWS+YhiqH/EmAyMWv6rTs1wUlcZ8UHSi5
	NIMmo4K9OCPE3peeX2hTDhwI6BKaSCJ5QVKd0SrABb1bCgyLrwu/CcuETQ8Ko0BJ8TTBz6dq9n6
	khk9+ExHeROtyzU6VZIUR1watX5PH7WN2U0ykcY1+YzMmmMZll8XTR7zb5AAwXiZ53xTEB3ns8F
	c/v7FO4xNm/AsKDaJTfbMN4clHLEmrrb78ZfucHijk6kDhhulrBSmDw7sGEFGne+nF6ngciZcmc
	CCk1flR9VLpN2cMw==
X-Google-Smtp-Source: AGHT+IG6zETWdv1uNEXL1H7qlBK8rzCntcx0G5cI2YCnUx99f9VimwWWKVBIKAVqjQPLH9huSPPJwA==
X-Received: by 2002:a05:6000:1448:b0:429:d3e9:65b with SMTP id ffacd0b85a97d-42cc1d23c3emr9659226f8f.59.1763938305625;
        Sun, 23 Nov 2025 14:51:45 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9190sm24849064f8f.33.2025.11.23.14.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 14:51:44 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Vishal Verma <vishal1.verma@intel.com>,
	tushar.gohad@intel.com,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: [RFC v2 03/11] block: move around bio flagging helpers
Date: Sun, 23 Nov 2025 22:51:23 +0000
Message-ID: <6cb3193d3249ab5ca54e8aecbfc24086db09b753.1763725387.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763725387.git.asml.silence@gmail.com>
References: <cover.1763725387.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'll need bio_flagged() earlier in bio.h in the next patch, move it
together with all related helpers, and mark the bio_flagged()'s bio
argument as const.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/bio.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index ad2d57908c1c..c75a9b3672aa 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -46,6 +46,21 @@ static inline unsigned int bio_max_segs(unsigned int nr_segs)
 #define bio_data_dir(bio) \
 	(op_is_write(bio_op(bio)) ? WRITE : READ)
 
+static inline bool bio_flagged(const struct bio *bio, unsigned int bit)
+{
+	return bio->bi_flags & (1U << bit);
+}
+
+static inline void bio_set_flag(struct bio *bio, unsigned int bit)
+{
+	bio->bi_flags |= (1U << bit);
+}
+
+static inline void bio_clear_flag(struct bio *bio, unsigned int bit)
+{
+	bio->bi_flags &= ~(1U << bit);
+}
+
 /*
  * Check whether this bio carries any data or not. A NULL bio is allowed.
  */
@@ -225,21 +240,6 @@ static inline void bio_cnt_set(struct bio *bio, unsigned int count)
 	atomic_set(&bio->__bi_cnt, count);
 }
 
-static inline bool bio_flagged(struct bio *bio, unsigned int bit)
-{
-	return bio->bi_flags & (1U << bit);
-}
-
-static inline void bio_set_flag(struct bio *bio, unsigned int bit)
-{
-	bio->bi_flags |= (1U << bit);
-}
-
-static inline void bio_clear_flag(struct bio *bio, unsigned int bit)
-{
-	bio->bi_flags &= ~(1U << bit);
-}
-
 static inline struct bio_vec *bio_first_bvec_all(struct bio *bio)
 {
 	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
-- 
2.52.0


