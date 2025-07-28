Return-Path: <linux-fsdevel+bounces-56179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDD9B1432E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 22:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9700C163A21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 20:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70054283FD0;
	Mon, 28 Jul 2025 20:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MF5VS5C8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4326E279358
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 20:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734707; cv=none; b=Soen60+veZAxg+GbPKMFK2P+r1xGhVG4oe70+EX8nWqLk6TN51b4XhYXurrSlmi4yQb4cO2wfQ7i6B8o74J+92vW+y5MvufBfMKGidII9uiW+Bqws9zh3PBU3CZ6dFdv/6TJgevi4r8STw4adLIHteoqmq9VCB3f5nw7/4oqlwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734707; c=relaxed/simple;
	bh=hehlWCL4DnH1hXGZwMMuYJcNu8D2DJbAccQcjormcfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MhvEZuOftZPL92Fo0TZ+CthSsS74OxJO4S9IrYCpBkSbmE3nMabTISHXDw0RV3sBR2MmNO0+MK/vj615DoOL6UHqw6qtp3DDvhDZYT8MemfV0TboHEO3DMoTv1pXejGthUMhSLbqkvknLZ/eaocGgjZ7+pfWDWJy6MVxQa8e38o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MF5VS5C8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753734705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F+cTONg/x1WR5SJCmcwZqVY3Un6rgLMjRuTOy/YQqvw=;
	b=MF5VS5C8P88qroqmMOIwhMN6VIhj65MfEUOWJJAu+AF2xatdrdXKfvq/iSkI90QHapx2Sq
	PI2PlU6Z/ie2UrajdUOo2f01rElpS5LhpkJu/+ZpXuMTnh1217wDi/CNWE1OTPhSypesLe
	5kDg+8NKfev+OAfN/IB414q1y2zm4Dk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-vxMl3CbgP-mbvscgZF3hBQ-1; Mon, 28 Jul 2025 16:31:43 -0400
X-MC-Unique: vxMl3CbgP-mbvscgZF3hBQ-1
X-Mimecast-MFC-AGG-ID: vxMl3CbgP-mbvscgZF3hBQ_1753734701
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ae0cd07eeb2so428607566b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 13:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734701; x=1754339501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+cTONg/x1WR5SJCmcwZqVY3Un6rgLMjRuTOy/YQqvw=;
        b=QtEaYOY2/1N6BRRTFboLIjWL9dn9G8QN18Eokheq+/Ni3NpN/EO6YVALhfmfJw4Cj4
         LiJKnZl6hm33r0JJiOzqjvdmIYPP4XOz3n9dbL+/i9aWH9inpW5FyPnLxnL/5/sWKHVJ
         pkbDpJ9joX7kpWH8GI5OLvkHz+bcBjrAs8L2yeJmtmFXJgM1o0RpkOhgi8xdfpCKEp/V
         KabSJYXDAEUwej1yKsvU7InvuY+qtsiragCWKZuabnImhEbqveuFapNRuJwXN4GCT/Rx
         WXWJjQVmbLiXSPNUYkqMH8m2S3ydIcYCxr75HUx9dgMVolqhQWvM+4y5JmoLNEtKrRND
         WbsA==
X-Forwarded-Encrypted: i=1; AJvYcCWymasc1CEPFh2PUNfdl59uOmtg6adLglrQp/53kv5k2l8AtUzSspaPQYWyZVUIFiJ0a+deLtqQUz/BPZgQ@vger.kernel.org
X-Gm-Message-State: AOJu0YybqpPaj4L101jPoXMQ6AQDsIv1RdT7U/WyCvke3iha2HX83/Fo
	f847OjyD4tp+U65PFVw3xKO72vqUBeCCeJW0eJj1FzswIlZRTAVRGoSyPM+ZFHgDkWK4ua6ksS4
	mESCS9ZdjvgrdIZtFDFKrVI5aDGPY5WgupDakQKNtZqutGaBuXFI9KIxXD+KCgD3qNw==
X-Gm-Gg: ASbGncuC1E2XvKgLiMnd+MEIxsvpb62Mp7qr/0+Xi4/kMlfC/GI7Az0E/jvT7hibS0b
	InDh2/GS2LhyFCJUst5YeIbPGzr3N+/OhLWoKaKtpmTxEG30jUckly4IffrObwdXloRU0WMWlOJ
	samkR702FV6GW/1u2Yfh3MeI9fD1Bg4luVIhQteAdRz4brhzQcNapZPwrnGNnxNNVJLOqCFXixD
	Wnn4oDLbkfV3Fq/1s0suJVHhODWBcJNpuTgsw99qv8jdBdlADtkwmXzfLxJYBwm8BCpWguZYlrR
	c+RxX8atI54rCHkbDTstgHt6nW4NfONNqGweYfKfBlDxPw==
X-Received: by 2002:a17:907:960c:b0:ae3:5212:c906 with SMTP id a640c23a62f3a-af616d05693mr1403398866b.10.1753734701188;
        Mon, 28 Jul 2025 13:31:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQMx6515Qysg+2ceeonp9KrxJ6j3Yt04QTkOPLGdwZHs5oma63j7vjBI22ZBCvngDmor2gpA==
X-Received: by 2002:a17:907:960c:b0:ae3:5212:c906 with SMTP id a640c23a62f3a-af616d05693mr1403396666b.10.1753734700735;
        Mon, 28 Jul 2025 13:31:40 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615226558d3sm2730656a12.45.2025.07.28.13.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:31:40 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 28 Jul 2025 22:30:24 +0200
Subject: [PATCH RFC 20/29] xfs: disable preallocations for fsverity Merkle
 tree writes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-fsverity-v1-20-9e5443af0e34@kernel.org>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
In-Reply-To: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
To: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org, 
 ebiggers@kernel.org, hch@lst.de
Cc: Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2007; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=hehlWCL4DnH1hXGZwMMuYJcNu8D2DJbAccQcjormcfo=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtrvSYQcst7EMZH/uvLO7Xneqfu2v2znSnPLyz+vu
 8LS2CpfeFlHKQuDGBeDrJgiyzppralJRVL5Rwxq5GHmsDKBDGHg4hSAiUxoZfif3iN7yNq+8uiX
 2UEiKrUTV5qcU+PM8A6z0eeZ1vVy+wZWhv9Oj7IedRWtyLef8+6qxeZJD09vsNvmKiv9J+9z3Rt
 RCQVGAHVsRks=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

While writing Merkle tree, file is read-only and there's no further
writes except Merkle tree building. The file is truncated beforehand to
remove any preallocated extents.

The Merkle tree is the only data XFS will write. As we don't want XFS to
truncate file after we done writing, let's also skip truncation on
fsverity files. Therefore, we also need to disable preallocations while
writing merkle tree as we don't want any unused extents past the tree.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_iomap.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index ff05e6b1b0bb..00ec1a738b39 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -32,6 +32,8 @@
 #include "xfs_rtbitmap.h"
 #include "xfs_icache.h"
 #include "xfs_zone_alloc.h"
+#include "xfs_fsverity.h"
+#include <linux/fsverity.h>
 
 #define XFS_ALLOC_ALIGN(mp, off) \
 	(((off) >> mp->m_allocsize_log) << mp->m_allocsize_log)
@@ -1849,7 +1851,9 @@ xfs_buffered_write_iomap_begin(
 		 * Determine the initial size of the preallocation.
 		 * We clean up any extra preallocation when the file is closed.
 		 */
-		if (xfs_has_allocsize(mp))
+		if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
+			prealloc_blocks = 0;
+		else if (xfs_has_allocsize(mp))
 			prealloc_blocks = mp->m_allocsize_blocks;
 		else if (allocfork == XFS_DATA_FORK)
 			prealloc_blocks = xfs_iomap_prealloc_size(ip, allocfork,
@@ -1976,6 +1980,13 @@ xfs_buffered_write_iomap_end(
 	if (flags & IOMAP_FAULT)
 		return 0;
 
+	/*
+	 * While writing Merkle tree to disk we would not have any other
+	 * delayed allocations
+	 */
+	if (xfs_iflags_test(XFS_I(inode), XFS_VERITY_CONSTRUCTION))
+		return 0;
+
 	/* Nothing to do if we've written the entire delalloc extent */
 	start_byte = iomap_last_written_block(inode, offset, written);
 	end_byte = round_up(offset + length, i_blocksize(inode));

-- 
2.50.0


