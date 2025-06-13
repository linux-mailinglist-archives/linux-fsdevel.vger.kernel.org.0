Return-Path: <linux-fsdevel+bounces-51628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A960AD97B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 23:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9000B3AFD5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 21:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA4628EA53;
	Fri, 13 Jun 2025 21:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSd7yuZp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83FA28D85C;
	Fri, 13 Jun 2025 21:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749851462; cv=none; b=m89cfp1bHZNyz5CdQBF+ZKEADkqyj4/NdkZRQZrERFsQB7bo+9L9YcEvGQD0NdRiAQxYJ88/Md/nIf54r2EyO9A1WDBobI13d8yCz9JI1vCJraP3WRJAG74bYISlcJFdkTGfeFkd05sctlNHMBEGLvL3CgbfRBLA0/DyUSIOJks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749851462; c=relaxed/simple;
	bh=y39CDejpwvn1Nb5NEtxiuEiAVZU2wOXourSmtOwHxpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnvFf7SxtQ6qjQFUlxnCEYJi4d5DbLWUR4ucZtIkt/ODwFvz5dEdD+aaQczLHN5EIrQ+RtELtwpvbw6wwVqBzlo2KxAeRUruWr48cfeJd7YkD9L9+OwtZ866p5Ub0QeKJMVF/JYZg3z8AZvVP3ZtTig0a/VPP0fAZkDjyhowql4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSd7yuZp; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3134c67a173so2997579a91.1;
        Fri, 13 Jun 2025 14:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749851460; x=1750456260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3J02SYzzdPdvAt9I2LGbJhPBdjirbvH0WAA9b3Qulcs=;
        b=mSd7yuZp6PizH43hhMvLlUvfUMR3qlqT71QO7oJ+QIkfpGSM6sW7H2L1PZSQjHcrp0
         3W44L/k9gCBLWPHWNAQnqm3yXx6Txj6p5KduURHAuOSp544W2XnB3LWBirqK4ZIWEAfJ
         eO+ilxQ3xOPR3pcZgLiKtkbeSX8RYAUr8EmXzIEoqsgljEVWTPmV2aSLO5wFBNxH9hqO
         I7nLmc1CZAngry/QoWydJFy91kaxGpfJJfpTj7Q7peqEtsGHRkU3Gw5WAomTA+cZ+Ako
         PZChbZnw7wZga88cb2h3oefjoV5ADimP6B5Qrjhj+65s1u2Ksb/kuVPzoEB+JMHWynpl
         nWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749851460; x=1750456260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3J02SYzzdPdvAt9I2LGbJhPBdjirbvH0WAA9b3Qulcs=;
        b=E9VqKxYbxvNk4FzBvXnrcY6PknEgpC8QrL1rBKH9cdvLr/sPcqNWJIgF+dS1hDgopu
         ZLSbnYm3k8c9I/0B8pvt+KKWzWP0rxe1XwklMy8GtwsdzZZma7qlxNWxjdtfpnyIzpHL
         8tyrgF6sS7xRqEc9MUeEPRa9F3GsmBq3bAJbW/mK6RB5uNsC9IfOuAOkVrdxyybfC5WE
         0S7NSXi3amSREhes3feJ2sqUv3ajSdEB+IbL3ALfagLmL8X2keobmUV+L0BQ5Hvxq5OH
         0pocy6xJsjdT/M83NF5JN3pSWrrO+SaSIKuwoa57Vtxn6wWaAF40p2DqfpqVv5tLCHWY
         swcw==
X-Forwarded-Encrypted: i=1; AJvYcCUN8OBHBWxHl05ozx2xJqz7YKWcCVrBTZGpB62bC2k5rSA0WoJhRUinL6CQgmGIAAtAoSKnYlj8ETI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNcXcEqGl5ySj8WX1/YbX2/giRQhlc9qfMIhIP7b5+T9TLdrcw
	bb8DSuo2S2a1beGiXeXLLRIAfHyBD2VuXbr9/7nEtRuxKYf+8BMLgm6xXjBNng==
X-Gm-Gg: ASbGncvYXqYZLgTW2Mco1nyr+jZAgF/mmCvLW1iiGbPLRbuJFKksEmz9OVcT12K7AR5
	7zugMZ6F0oNPZ0Nzke8Q/RhpSKzBwyZY95FMwayre/GjM9t+7veNXpslnwHTnkAXgAUizEspydj
	I4iJH048bBQEMrEMWVusRwAt83gtUAvtOQbQHyg5elviXgkpgpLiurIIaMw9jRqqyPskdKpamZM
	KkHpqmM0VMIi0kVw2AcfKuacYi+ZqLo3egt8y5HaJst4SdBhKveMC1+4iuij5phOb+JapnbatAG
	GcVv5dBHX7kDdEpDso3oPY7luJQfmkJMKFdv6PuhRjbWG/A+hh/Kto3XT7eOu+64jAc=
X-Google-Smtp-Source: AGHT+IFOsxXZXfxMOYEkfK2Ft1fniNNvxEuUIiJbsG1HD/NxxLRTSHo0XSY2J8Srg56KLA5QBuiZAw==
X-Received: by 2002:a17:90b:3e84:b0:313:1e60:584e with SMTP id 98e67ed59e1d1-313f1c03129mr1702548a91.9.1749851459728;
        Fri, 13 Jun 2025 14:50:59 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1b59ed4sm3906958a91.39.2025.06.13.14.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 14:50:59 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	anuj1072538@gmail.com,
	miklos@szeredi.hu,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 08/16] iomap: add read_folio_sync() handler for buffered writes
Date: Fri, 13 Jun 2025 14:46:33 -0700
Message-ID: <20250613214642.2903225-9-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250613214642.2903225-1-joannelkoong@gmail.com>
References: <20250613214642.2903225-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a read_folio_sync() handler for buffered writes that filesystems
may pass in if they wish to provide a custom handler for synchronously
reading in the contents of a folio.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 .../filesystems/iomap/operations.rst          |  7 +++++++
 fs/iomap/buffered-io.c                        | 19 ++++++++++++++++---
 include/linux/iomap.h                         | 11 +++++++++++
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index 3b628e370d88..9f0e8a46cc8c 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -72,6 +72,9 @@ default behaviors of iomap:
      void (*put_folio)(struct inode *inode, loff_t pos, unsigned copied,
                        struct folio *folio);
      bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
+     int (*read_folio_sync)(loff_t block_start, struct folio *folio,
+                            size_t off, size_t len,
+                            const struct iomap *iomap, void *private);
  };
 
 iomap calls these functions:
@@ -102,6 +105,10 @@ iomap calls these functions:
     <https://lore.kernel.org/all/20221123055812.747923-8-david@fromorbit.com/>`_
     to allocate, install, and lock that folio.
 
+  - ``read_folio_sync``: Called to synchronously read in the range that will
+    be written to. If this function is not provided, iomap will default to
+    submitting a bio read request.
+
     For the pagecache, races can happen if writeback doesn't take
     ``i_rwsem`` or ``invalidate_lock`` and updates mapping information.
     Races can also happen if the filesystem allows concurrent writes.
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 882e55a1d75c..7063a1132694 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -581,10 +581,23 @@ iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
 					 pos + len - 1);
 }
 
+static int iomap_read_folio_sync(const struct iomap_iter *iter,
+		loff_t block_start, struct folio *folio, size_t poff,
+		size_t plen)
+{
+	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
+	const struct iomap *srcmap = iomap_iter_srcmap(iter);
+
+	if (folio_ops && folio_ops->read_folio_sync)
+		return folio_ops->read_folio_sync(block_start, folio, poff,
+					plen, srcmap, iter->private);
+
+	return iomap_bio_read_folio_sync(block_start, folio, poff, plen, srcmap);
+}
+
 static int __iomap_write_begin(const struct iomap_iter *iter, size_t len,
 		struct folio *folio)
 {
-	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	struct iomap_folio_state *ifs;
 	loff_t pos = iter->pos;
 	loff_t block_size = i_blocksize(iter->inode);
@@ -633,8 +646,8 @@ static int __iomap_write_begin(const struct iomap_iter *iter, size_t len,
 			if (iter->flags & IOMAP_NOWAIT)
 				return -EAGAIN;
 
-			status = iomap_bio_read_folio_sync(block_start, folio,
-					poff, plen, srcmap);
+			status = iomap_read_folio_sync(iter, block_start, folio,
+					poff, plen);
 			if (status)
 				return status;
 		}
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 522644d62f30..51cf3e863caf 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -174,6 +174,17 @@ struct iomap_folio_ops {
 	 * locked by the iomap code.
 	 */
 	bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
+
+	/*
+	 * Optional if the filesystem wishes to provide a custom handler for
+	 * reading in the contents of a folio, otherwise iomap will default to
+	 * submitting a bio read request.
+	 *
+	 * The read must be done synchronously.
+	 */
+	int (*read_folio_sync)(loff_t block_start, struct folio *folio,
+			size_t off, size_t len, const struct iomap *iomap,
+			void *private);
 };
 
 /*
-- 
2.47.1


