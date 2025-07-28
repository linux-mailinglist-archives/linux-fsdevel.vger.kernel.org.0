Return-Path: <linux-fsdevel+bounces-56180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8560B14333
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 22:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32EDF18C2E6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 20:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EC027990A;
	Mon, 28 Jul 2025 20:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCnNEe+r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF15283C82
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 20:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734709; cv=none; b=HHYS93Whk2b7ZcAAvTnlLywCZi1c/ZH6PpLybx49rPoV+9mp/xh9zKOrYcS1b4Kf7DLgynaz+qHroqfnzhpAA6kdc69yY2u9ggIeogIO4unzVOMbzSMEES8Bug2c4aRArUC883s7Fq4z4R8Zqz/KOcrWtKGjQ07VILcMhrMXEpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734709; c=relaxed/simple;
	bh=/8FV6hjFXk9tXnrlF+LLnPL2OibfvcJxbhHakp+Isp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=odcaPLYffsknRZkkJLwcWtLKDzrW7VZwSNjDLn3zSjMISWZMuXxNCnCSVDFFTXCKXFtB0cgQuGAEwDvXvukYYLLRlUInU2HKU6F6cECOyv+V0rlNzmDFcB9f7CatYsu/CXzBreQL4jiZ5HiV80LJTbcwYdDRQ6OjXyGZ7hMOlWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FCnNEe+r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753734706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iTEwlcryTWjiYSKb+4cWiSP+ImzW4MMUyLahr8IIMPc=;
	b=FCnNEe+rAnxatgWECA9NpAZLy3GQjciPAag8Wmafvrz/BQ10Je9xFi1+qabWbwW+mJ92pd
	I4yYj8LCJl+VxODVVuFAUw01nXtk8OBvvLfToC6Xq6Od0bAVOJMW141k5jD59DcEF/oSo+
	3ZK7XNPhUDzJa2YGAzldYDJKFPCZYOA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-yxkdKcPaPiuytLRSmZm0xQ-1; Mon, 28 Jul 2025 16:31:44 -0400
X-MC-Unique: yxkdKcPaPiuytLRSmZm0xQ-1
X-Mimecast-MFC-AGG-ID: yxkdKcPaPiuytLRSmZm0xQ_1753734703
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ae70ebad856so341995766b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 13:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734702; x=1754339502;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTEwlcryTWjiYSKb+4cWiSP+ImzW4MMUyLahr8IIMPc=;
        b=XO/D4l4mM8f5KA6fW84WsM0wpL6+82cfxSn/Ra8//tT7OJShXKcFCug2dnmTzbh/mw
         7CaNlR9OuK1qM2NGp9RYowsbNAtOgY1NE7xKLK5eYX2JNydoLJCVSKfxfoMK/kkv0hn1
         JVFENQNOwAIf92ykHrQBoS+KqEzmffAoNO4cPkMldaFq0eY2BxF70Fb53eHhDdoV37nv
         PTumAHBzT23//t+VO+OpfYluOD6pW6BHU/qhuIGfnRc64r3NNiBjkSKal18Iuj6ixyx4
         4FZuHBAls89QrZnEpR/P7E4TU/wHUkzjdD9cTJIS81zjG/tGghRBvFRyJWBdkQ2QJiaS
         hzvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDRLfeRvzGPW3WU1zq3zUJrW/FnJg1tb5JHKvsHuUP5dkPRx9QfTamia6SzXp99XsrNxLnmkmNlpsjBza/@vger.kernel.org
X-Gm-Message-State: AOJu0YwEsBuij4GHlbFyKYjpdFXAWs3D2KAwfPhFoc1jfbm+ROWsolJo
	2SvFnezIeh3KJccoYdNTIKBDD++gfWuhaUwjF9z83ynE+OzbB74uKzim1LNlKa5JdNIKhZJ8i7Y
	qN9GYVzPNdssQsaDgF2aR014L5WJBjxyeLR4UOy4St3pnjZ7uwrbffCkCGfLz5tcsWg==
X-Gm-Gg: ASbGncuohmrZ/A9s7Moiixds+jx0aTuNfrAL6JqDKxVhMtZgOHouX3WzjRfqJQ5IaJu
	VaTf+LjggYUr4kdqiM3BBxhV3kZX933PCh3UiJjxU22VN47fR4HBkS9PJyD+yPzBrVdt1txvP6L
	3bkGW/xodTfwLeQZ0eh/lLXr3VO0PhK4PbEcV1vZBMkAOtFVfviz/6orCQgw9qDaHJ1llp/Keuj
	HcCCWsu0YiUyJdqzMsBULYiEl6hTXw3R6uo/9wCrBgAm2NAf0tJoqzuzZg8crdgAJuY3I10nmqp
	AVymEQWcmOuLaoTcygoU2fsV/658Y7ifBlmbfdmdX+6leg==
X-Received: by 2002:a17:907:96a2:b0:ae3:f16e:4863 with SMTP id a640c23a62f3a-af61c2aeb94mr1524796966b.1.1753734701942;
        Mon, 28 Jul 2025 13:31:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5VIH8vcQ4VRlYF7NYaQzj/8o6q0uoPWsXMjZWX1gZSbURojOYQjFjabZ0tjc3eckDaZjC1A==
X-Received: by 2002:a17:907:96a2:b0:ae3:f16e:4863 with SMTP id a640c23a62f3a-af61c2aeb94mr1524793966b.1.1753734701479;
        Mon, 28 Jul 2025 13:31:41 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615226558d3sm2730656a12.45.2025.07.28.13.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:31:41 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 28 Jul 2025 22:30:25 +0200
Subject: [PATCH RFC 21/29] xfs: add writeback and iomap reading of Merkel
 tree pages
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-fsverity-v1-21-9e5443af0e34@kernel.org>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
In-Reply-To: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
To: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org, 
 ebiggers@kernel.org, hch@lst.de
Cc: Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2737; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=/8FV6hjFXk9tXnrlF+LLnPL2OibfvcJxbhHakp+Isp4=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtrvSax6bXDiukJxzvK714XPtr7cKB2Vcn9F7qnlD
 WHqnM/Slk7qKGVhEONikBVTZFknrTU1qUgq/4hBjTzMHFYmkCEMXJwCMJF3RQz/s5fwPdD9wrY3
 pfWIa+Kx9U+ruR6/k589M1h8Q8y3DLb9KYwMn2v3Ty3Zc7y4q/X2oj96QVLnnPeceCJt4CEiL1Q
 a0mnCBAC//kpc
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

In the writeback path use unbound write interface, meaning that inode
size is not updated and none of the file size checks are applied.

In read path let iomap know that data is stored beyond EOF via flag.
This leads to skipping of post EOF zeroing.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_aops.c  | 21 ++++++++++++++-------
 fs/xfs/xfs_iomap.c |  9 +++++++--
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 63151feb9c3f..02e2c04b36c1 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -22,6 +22,7 @@
 #include "xfs_icache.h"
 #include "xfs_zone_alloc.h"
 #include "xfs_rtgroup.h"
+#include "xfs_fsverity.h"
 
 struct xfs_writepage_ctx {
 	struct iomap_writepage_ctx ctx;
@@ -628,10 +629,12 @@ static const struct iomap_writeback_ops xfs_zoned_writeback_ops = {
 
 STATIC int
 xfs_vm_writepages(
-	struct address_space	*mapping,
-	struct writeback_control *wbc)
+	struct address_space		*mapping,
+	struct writeback_control	*wbc)
 {
-	struct xfs_inode	*ip = XFS_I(mapping->host);
+	struct xfs_inode		*ip = XFS_I(mapping->host);
+	struct xfs_writepage_ctx	wpc = { };
+
 
 	xfs_iflags_clear(ip, XFS_ITRUNCATED);
 
@@ -644,12 +647,16 @@ xfs_vm_writepages(
 		if (xc.open_zone)
 			xfs_open_zone_put(xc.open_zone);
 		return error;
-	} else {
-		struct xfs_writepage_ctx	wpc = { };
+	}
 
-		return iomap_writepages(mapping, wbc, &wpc.ctx,
-				&xfs_writeback_ops);
+	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION)) {
+		wbc->range_start = XFS_FSVERITY_MTREE_OFFSET;
+		wbc->range_end = LLONG_MAX;
+		return iomap_writepages_unbound(mapping, wbc, &wpc.ctx,
+						&xfs_writeback_ops);
 	}
+
+	return iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_ops);
 }
 
 STATIC int
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 00ec1a738b39..c8725508165c 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -2031,6 +2031,7 @@ xfs_read_iomap_begin(
 	bool			shared = false;
 	unsigned int		lockmode = XFS_ILOCK_SHARED;
 	u64			seq;
+	int			iomap_flags;
 
 	ASSERT(!(flags & (IOMAP_WRITE | IOMAP_ZERO)));
 
@@ -2050,8 +2051,12 @@ xfs_read_iomap_begin(
 	if (error)
 		return error;
 	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags,
-				 shared ? IOMAP_F_SHARED : 0, seq);
+	iomap_flags = shared ? IOMAP_F_SHARED : 0;
+
+	if (fsverity_active(inode) && offset >= XFS_FSVERITY_MTREE_OFFSET)
+		iomap_flags |= IOMAP_F_BEYOND_EOF;
+
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, iomap_flags, seq);
 }
 
 const struct iomap_ops xfs_read_iomap_ops = {

-- 
2.50.0


