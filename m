Return-Path: <linux-fsdevel+bounces-11144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212D1851A5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 18:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD35D285AF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B633E464;
	Mon, 12 Feb 2024 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e7bWp9aI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7DA3D55D
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757198; cv=none; b=hEzEUrVThBW4kNfvfxSyZZV4gwHEKRJYWcaZlvb/Q/6Yho2j6cMBPHODmIT9HfSGTohXwtF0CHGOFAp7eZpX6apWMp8oFCW4mevVcAzeT0wlt5VGCade0w5C5yubIr5yeHmOV+XYVOfeVq/3cidUIcoV4zEWplzwmc72QoZTzQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757198; c=relaxed/simple;
	bh=iGCn00rEq7PG+afvZlZGmDPn+zqmaqJVYlT49tydKx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qGeKjt4VIqYfbv7LKRA/bBOn43GT+yL2/LBmWpSIYYn7I/FJ8SQeENjYy8k9zZHyT9Vx3vJXaO0k1QPwJEi9dfdYWoEjEuJJFSPagTz6Bxj/qw77v+TTcllHjbcTFtT8TOc+QeIk1++NLxvKShvbcFxWOKnLbDip1z5Ppy6jekk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e7bWp9aI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707757195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oBcesGNJ85C40O8Wbwe4Jalf+KuBJVBEen9IDHFprmk=;
	b=e7bWp9aIrLFYJKpRrPcHgst4fLfT3P7gaO+ZMT64XU7DmriSVHBMYCb32S/RHjJFoIXniO
	Q1nz60DUpGc9B5tphLgL1TL87JfnSoC/EnNm5Cc9IVC0d0muVM3qPrW6zTN5zqJnLS1DuL
	qXyKKbunkx49rPx+M+69VDGNSGvIDMo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-c66Af9tjPa6EWtn-gsqgsQ-1; Mon, 12 Feb 2024 11:59:53 -0500
X-MC-Unique: c66Af9tjPa6EWtn-gsqgsQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-560d965f599so1886285a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 08:59:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757193; x=1708361993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBcesGNJ85C40O8Wbwe4Jalf+KuBJVBEen9IDHFprmk=;
        b=jlbkL5+nwwgBrGjowFaDvGbUg/7UXlJFtjZp8yL5SYzLicilbcmkrF2QUsGA7IsKkg
         iYaif0uNTD28PGWtE8sIjcUpUQqqmz9SS6rOIPJlSQ13KHUsdUsgdhL29+d4XixexrRn
         zq/RqjRDrz0xh6qzl1jEvbZhpdSjVleiLyvdQ1QwzJV2hJ4rs8xH2B6RWrgZyhksa0fZ
         CO7i1N2+Et4svJHr3u9Tm0GFs00LbCAvCR9O1QraGSevb2CMcgYA7ypeI8/9TtKrYEVO
         RWVps6KYj6l64DXzZykczfGGY6pRk9H2afgqtcRn2jBWjiJlH1is18b64KjkPq6KbwJJ
         gmGA==
X-Forwarded-Encrypted: i=1; AJvYcCXr85e80g6DxVyVQi666CaccIUH+mkyydNwsrSUmAF+zOCdhd+xEbd9WYP7rVT5xD1X5Rlil4lGSNXGT/os3uXeuwtZIPTa8kd7PLkAcA==
X-Gm-Message-State: AOJu0Yw8NC8D5KDa6fKHXAGWEOUkUPNctdQSvBqYC6aLdg730Fh4WY+4
	FeRmFh49BcsG0T/PmHDKBTd2PMYVgU3V1maru1O0KZojNoHHpmmnlsWFT9k4CeuzcYFuBnZ57FP
	PM5+MG9FyiF4NethYDD2Hb47w4kJ8Ieh/dF9eyP9UX+sFtJYNYOfugEbn9rHL8A==
X-Received: by 2002:aa7:d38c:0:b0:55f:8c38:36a9 with SMTP id x12-20020aa7d38c000000b0055f8c3836a9mr5424650edq.42.1707757192752;
        Mon, 12 Feb 2024 08:59:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuAQY974HjwvfUXd9S/s2x7iBcid/UjzWaSIP6F1pOXoRVZe6HEND0f94MhpBhdqSR92/o6g==
X-Received: by 2002:aa7:d38c:0:b0:55f:8c38:36a9 with SMTP id x12-20020aa7d38c000000b0055f8c3836a9mr5424640edq.42.1707757192557;
        Mon, 12 Feb 2024 08:59:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUGdzvN1PlvyWuInXAHyDTNZDbZ3DXfxNsW3DTnGhPYQmdNWEbiWbsvxSno4SsYIW0Gcc8LWGDwRbTSQjOvUTlNaq3J5lBwDWuoz3D61CyakzhU+/Ztf5vms14kBfBl/qVaSH9L8ZAthUJf82RYURpX4L4q69P/l+ZSHjyspsgs02K9geKDabKzvF1PUu2mwvnnBAFZcgcXNEYnNv6JM0AnWcmeZWP24ZAuM994uoKNEWHfrsbobAzZthWH4rHt
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id 14-20020a0564021f4e00b0056176e95a88sm2620261edz.32.2024.02.12.08.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 08:59:52 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Allison Henderson <allison.henderson@oracle.com>,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v4 03/25] xfs: define parent pointer ondisk extended attribute format
Date: Mon, 12 Feb 2024 17:58:00 +0100
Message-Id: <20240212165821.1901300-4-aalbersh@redhat.com>
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

From: Allison Henderson <allison.henderson@oracle.com>

We need to define the parent pointer attribute format before we start
adding support for it into all the code that needs to use it. The EA
format we will use encodes the following information:

        name={parent inode #, parent inode generation, dirent namehash}
        value={dirent name}

The inode/gen gives all the information we need to reliably identify the
parent without requiring child->parent lock ordering, and allows
userspace to do pathname component level reconstruction without the
kernel ever needing to verify the parent itself as part of ioctl calls.
Storing the dirent name hash in the key reduces hash collisions if a
file is hardlinked multiple times in the same directory.

By using the NVLOOKUP mode in the extended attribute code to match
parent pointers using both the xattr name and value, we can identify the
exact parent pointer EA we need to modify/remove in rename/unlink
operations without searching the entire EA space.

By storing the dirent name, we have enough information to be able to
validate and reconstruct damaged directory trees.  Earlier iterations of
this patchset encoded the directory offset in the parent pointer key,
but this format required repair to keep that in sync across directory
rebuilds, which is unnecessary complexity.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: replace diroffset with the namehash in the pptr key]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_da_format.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
index 18e8c7d44ab8..e5eacfe75021 100644
--- a/fs/xfs/libxfs/xfs_da_format.h
+++ b/fs/xfs/libxfs/xfs_da_format.h
@@ -867,4 +867,24 @@ static inline unsigned int xfs_dir2_dirblock_bytes(struct xfs_sb *sbp)
 xfs_failaddr_t xfs_da3_blkinfo_verify(struct xfs_buf *bp,
 				      struct xfs_da3_blkinfo *hdr3);
 
+/*
+ * Parent pointer attribute format definition
+ *
+ * The xattr name encodes the parent inode number, generation and the crc32c
+ * hash of the dirent name.
+ *
+ * The xattr value contains the dirent name.
+ */
+struct xfs_parent_name_rec {
+	__be64	p_ino;
+	__be32	p_gen;
+	__be32	p_namehash;
+};
+
+/*
+ * Maximum size of the dirent name that can be stored in a parent pointer.
+ * This matches the maximum dirent name length.
+ */
+#define XFS_PARENT_DIRENT_NAME_MAX_SIZE		(MAXNAMELEN - 1)
+
 #endif /* __XFS_DA_FORMAT_H__ */
-- 
2.42.0


