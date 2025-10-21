Return-Path: <linux-fsdevel+bounces-64972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0D0BF7C3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 18:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B738A4277D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 16:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407EB344CEA;
	Tue, 21 Oct 2025 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8Cj7KOD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB35344CE8
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065113; cv=none; b=m3WSEtq1C1t/EjeYwcsNSwaZTjydozuySisiM776AyyggJx4tMLWrZBHPy07hd/ug8O85he/RKT/l5iF4c4Ml6qfvy5ADXz0tVpCfeSPVep60s9Ri7Pq5o68lbmL1tPGdi+DWX9TCiRAEFFUd+Bn/J69DFGaUUNUGiljqgwpkVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065113; c=relaxed/simple;
	bh=eQ4GjtiSXAIRSMoYoK+G3LdPmiHWuTL5XvX4Mkc010Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSi9e+Pmu7LtxODURN0nLH5rkIvC3YSzthANSd7ZHBLL2Ewgm74WTXuh5pIVz7LKYk7jzUS2feWP2hKFdJNoE/ASyBmsooFwo3LPc/TPwljhfVkI1gx0HlkRa4B3sALc9QkrL2PGSJOUF8QAG34vpufjcsIJWsdbZXRru10/GXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8Cj7KOD; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b6271ea3a6fso3861791a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 09:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761065111; x=1761669911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IiZu1jFl2RkLPjuCraefHKH2pFV09G6EDqKYnFZ7Ck=;
        b=F8Cj7KODBnk5AIMGgNPV9gt0SyOGRUctE6pCtUDGUQi3tlkBvyuclByu+dOACRVVwP
         4/IaTBbArhRiEHiNVv8JLsLEkb6EYwKdKnCXPB/g0ST59+NzEwxy0UTOkKFPjVGiefNp
         aEvLt+9ct1Zh3UN0uV24Llza8Dme6OdCPsfeNN7VVkS6/oIArUlxEbVWP1niMEy3w+6p
         33KfFHOwEY8G5k6YRzODjw4gubajgeHHT5v1m8tA6f1NVFu8MABNEZt5PV9gCccGGkPi
         Z/DgFuIKQMNsRBgaSsOuMxxZJdzoWAijqQKsQrKL8gXNgJGsh3aUTIIorypCpoYZy57q
         +uXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761065111; x=1761669911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8IiZu1jFl2RkLPjuCraefHKH2pFV09G6EDqKYnFZ7Ck=;
        b=IfFtxjsaeNYzXNH8v11xbX2VfGmdPyt4F+4Wpl+osgc1ZPVBVg6GIQVpWZ50vUWfbx
         RDxE3umt+vkJiVxjwDAKt1YbcIA2sBz6CKSuMICvg/5yBd/kyS+xZ+6HyRNAHfRCKeNi
         xjcFbalguRS47JJvvvsxgNUNQl0qWOggH7krAuYI5/lm1qGylE80sQecS5z80TqTGKrg
         VxjJFoeGp72t02z99si3FkmTeHVldHA2JSQwqUFnLivhR1WK6WGWi0Os7hp1Mk8CrKDm
         cZvvpJGvTOQq31+MCQgN6iaT0uRCFmJISncx99yCMsPJONK8IKhx9ukARKy4meYdYLNV
         h7Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVndEcsZ+hvPwKnYluK10Fy7JoxHFzbk9M2f1etO8DldN66YqVM3ngiSas2maDAsltV2hZeHOfkl7bpLGqA@vger.kernel.org
X-Gm-Message-State: AOJu0YxJcKcnJdQUOTBXA2MBCnY5PDPEgXQLvzwjYxeubvZDSun3Hh3L
	O5Q0xEljDNscSEcIZMnOGq3xh1ESiAX80L87QGdqdIYHZk8D+qmwG9ff
X-Gm-Gg: ASbGncsAR+igj7zWl2jXM72jDql8NAJX9igx36Xz5pp4FThEr43wsmKLtCRoD5vYBus
	wx2xbjSGjULZtzMy8q/B+R0DkfYWWa7JAkB2T8YbZ5P7+BZqkDdxhLD2BD4JIrf3LgGQ7S0NiiK
	QRtj/cByvixR7BZR8+7oqIIVYa1VMzMTqesZMowDVg7HctNsRNT+Nm+FFOFIvZJ9w4Qd99bmVbI
	kJmjZQLabvoC6tRDbMOo1sQyLwBBK26/efwgMJPBOeLKf9hjBMwFUBliAzj0awRzF4asaL8VYiA
	XqcdGsMR6dOjA6A5BqgDvHVhR1kwqUab56khXHXZ4At75UZWoj0WJwJ0HQpOvxZUg6vSAsUpSie
	GjLv95EA905cOQg4TkWyMxks/ZVknsqBPY/UAIQwa1/YW2dFAJ7IbGawMBTqT7Dcgso1S/6QVdt
	ZYl0mPW5U3uv/flKTBhhBkMbfO8w==
X-Google-Smtp-Source: AGHT+IHymyMQOE8ay9D0mwzN2xOy94bD50D3U+EksID4ceclh+68sYu4uL0XCHrcl2kMam0Pq7/8eQ==
X-Received: by 2002:a17:903:15c7:b0:24a:fab6:d15a with SMTP id d9443c01a7336-290c9cbc91emr209324995ad.20.1761065111040;
        Tue, 21 Oct 2025 09:45:11 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471da2f9sm114178665ad.62.2025.10.21.09.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 09:45:10 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 2/8] docs: document iomap writeback's iomap_finish_folio_write() requirement
Date: Tue, 21 Oct 2025 09:43:46 -0700
Message-ID: <20251021164353.3854086-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251021164353.3854086-1-joannelkoong@gmail.com>
References: <20251021164353.3854086-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document that iomap_finish_folio_write() must be called after writeback
on the range completes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/filesystems/iomap/operations.rst | 3 +++
 include/linux/iomap.h                          | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index c88205132039..4d30723be7fa 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -361,6 +361,9 @@ The fields are as follows:
     delalloc reservations to avoid having delalloc reservations for
     clean pagecache.
     This function must be supplied by the filesystem.
+    If this succeeds, iomap_finish_folio_write() must be called once writeback
+    completes for the range, regardless of whether the writeback succeeded or
+    failed.
 
   - ``writeback_submit``: Submit the previous built writeback context.
     Block based file systems should use the iomap_ioend_writeback_submit
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 65d123114883..d1a1e993cfe7 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -435,6 +435,10 @@ struct iomap_writeback_ops {
 	 * An existing mapping from a previous call to this method can be reused
 	 * by the file system if it is still valid.
 	 *
+	 * If this succeeds, iomap_finish_folio_write() must be called once
+	 * writeback completes for the range, regardless of whether the
+	 * writeback succeeded or failed.
+	 *
 	 * Returns the number of bytes processed or a negative errno.
 	 */
 	ssize_t (*writeback_range)(struct iomap_writepage_ctx *wpc,
-- 
2.47.3


