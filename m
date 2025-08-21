Return-Path: <linux-fsdevel+bounces-58649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 287F7B3064E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD08E3A8FA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67CA3128B2;
	Thu, 21 Aug 2025 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="zESJVNbk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB49B38B64C
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807636; cv=none; b=m9M+tKT6Bm6xkJ7VVtsgAOEL8qDEkASD0zIU+wqRxysf8Y9AsaaYk622O2Ke1EdJhGqJlWnrLpBujzieL5g4gDKMxZZFiRpgH2xGz0Jc7bb9JcugbCgZ1C+WOjI0RtZccr9/nXUUuAA4dElUhaf45T4EFc24MepSLClHf+O5MLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807636; c=relaxed/simple;
	bh=2lSccGeZgoSX9aVaaFdQWb29wL+DUPO/GAFShbd8K+M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhK/PlZ3VbomMQpKYJgmykZaHOsvJkElACBf015JvqqpOACU8O9n9UqO00Vs3Gyv7drTadfweJ+stT3uWy2a0WFdC5AZQfs4Zncz5Z+RAB3YrZIscj0JRWaaIlN5OBUl6xb/azobEtvUoP+nfHT4bLXGnbWiocp+DzsIVJT2hOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=zESJVNbk; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d6059fb47so11950767b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807633; x=1756412433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t6l/bS5zsFklKVceeWUebv0jSoLqiCtfylVlw96dX9A=;
        b=zESJVNbk2y3O8iYx0gwy3rxb0boWcrpPCTc0SvkjoX3yy0ZAxhHS+NsTE0PKR1mKLv
         zDiDSPUnjyQs5E0n+3TfR+Fi7C+NXtBkaC0C7FBHu2PYmOEtCDlDnh6s4bc9c2uLiLa1
         rhFEr7QAe8a0NVjWAkpzMwHH3dEsDFuFHzggAwUrt7gHL/UpsWgJfG+9VugQ8F0FE8Cc
         tDCF0ZLPtG69sqH4bmxy21FyDKet/4cS4qvxKAqvW+35Rwv44JENm61kC2QUQZdf0X+w
         knms9jQilY/lsOosNJYrueNdZwvGgE/LFUH6X8Q/BuFehfEAwoBrG+VA9FCBjCzvntDV
         MEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807633; x=1756412433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6l/bS5zsFklKVceeWUebv0jSoLqiCtfylVlw96dX9A=;
        b=msAmk9juV7HyQr4Ar1ZAlCxg+G7Yac/GixzFFU4Gebf+TCedzmgwMBN87j5LCHABBG
         qgs8pxElg7/PwlKJPFs3HdzeJ+vCMTtpA91UleKJIFikdSLhvN3rQLdXn7D1ZsSZFiUe
         +EFha0Hhkf344MB3oD1LQC2NPuOD2kcmd+P/9g267krjR04GkWqOc4UbjFm7JLi29ExH
         sUWuqLs7yNUREbND1vWE1pTFPvvZBTQlVmUcoVYqLy23HWGRVqOI+22z8+bFzAfP+J6+
         WDat4FwyCTxLp1eQKpI+NYkSK2FCWI6rYPyhP5d9GywTERbBIH7hJOLn3k+ohgkwS5IV
         AKnw==
X-Gm-Message-State: AOJu0YxZ+3TOUVEdYT9NBvtKcXGMbQun4s21VpQS3c6+m0fmGzczpq/M
	SoxwOZ7qZescYZNkvhxr+fQaUgAoVqZ/OA78qYjLa/bM4qm7V69wbld3R6PyJ6piP/Jd9dHQ1wl
	9XEHzZ1TJBQ==
X-Gm-Gg: ASbGncvwaSGmECMHrx1jyOLNQ2wlB5ARmW1zKbwDfNszr3NMJNDfuAK4u9nHlSRLzQg
	hEYWoIhHnzrOw8owgk5aMLD0B0bhSknj4MelxgQQzKY4DPQ7mbS4jJSGBNds8i+xIlEpntMgkgN
	9AmmJxlS8aa0sbVjPbGTxXB3huWtlLIFgS6sp/I3I1/AcayGkH+l7+MMY2HBW7ZBmyOU0Vqwl2z
	bZTbpgREHi+wApyp/KfPkD1RJzVfAVSS3XwHh2zaAMeNec2e8jMjOLaAUYsGOq6j8xpQvRpFFui
	T0g1h82W/XaguKtwdwoxR2weXmSnbYWkV7zRrUy+HNYid5j/7ILMtxX82etg9pVWc1K44H7RyUb
	ZidYKVppgnmUkvo9/gR8mSCNtPk+RThYIIVUBJZKbsgy3jbo/IEsHDBDZjN7m0gZjaxCGdg==
X-Google-Smtp-Source: AGHT+IENgnB2uo7YbHtB+DxWNcnBLhyOt4jJNvfUugyviv21T/VvDjUt9O60NwAaV2wQMgUkTBA/BA==
X-Received: by 2002:a05:690c:48c8:b0:71f:b944:ff9 with SMTP id 00721157ae682-71fdc43915bmr7196657b3.44.1755807633295;
        Thu, 21 Aug 2025 13:20:33 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5f52c8b347csm50443d50.6.2025.08.21.13.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:32 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 12/50] fs: rework iput logic
Date: Thu, 21 Aug 2025 16:18:23 -0400
Message-ID: <51eb4b2eef8ee1f7bb4f0974b048dc85452d182d.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, if we are the last iput, and we have the I_DIRTY_TIME bit
set, we will grab a reference on the inode again and then mark it dirty
and then redo the put.  This is to make sure we delay the time update
for as long as possible.

We can rework this logic to simply dec i_count if it is not 1, and if it
is do the time update while still holding the i_count reference.

Then we can replace the atomic_dec_and_lock with locking the ->i_lock
and doing atomic_dec_and_test, since we did the atomic_add_unless above.

This is preparation for no longer allowing 0 i_count inodes to exist.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 16acad5583fc..814c03f5dbb1 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1928,22 +1928,23 @@ void iput(struct inode *inode)
 	if (!inode)
 		return;
 	BUG_ON(inode->i_state & I_CLEAR);
-retry:
-	if (atomic_dec_and_lock(&inode->i_count, &inode->i_lock)) {
-		if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
-			/*
-			 * Increment i_count directly as we still have our
-			 * i_obj_count reference still. This is temporary and
-			 * will go away in a future patch.
-			 */
-			atomic_inc(&inode->i_count);
-			spin_unlock(&inode->i_lock);
-			trace_writeback_lazytime_iput(inode);
-			mark_inode_dirty_sync(inode);
-			goto retry;
-		}
-		iput_final(inode);
+
+	if (atomic_add_unless(&inode->i_count, -1, 1)) {
+		iobj_put(inode);
+		return;
 	}
+
+	if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
+		trace_writeback_lazytime_iput(inode);
+		mark_inode_dirty_sync(inode);
+	}
+
+	spin_lock(&inode->i_lock);
+	if (atomic_dec_and_test(&inode->i_count))
+		iput_final(inode);
+	else
+		spin_unlock(&inode->i_lock);
+
 	iobj_put(inode);
 }
 EXPORT_SYMBOL(iput);
-- 
2.49.0


