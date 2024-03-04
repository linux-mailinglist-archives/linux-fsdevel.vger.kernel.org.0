Return-Path: <linux-fsdevel+bounces-13523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A12870A3C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 20:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E01F3B24DE1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C532D7A139;
	Mon,  4 Mar 2024 19:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZZaGBKF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ED678B68
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579540; cv=none; b=f/YyZLWKkQLci5RvBF4P6tonP3bAd5mC0H1zkj0YS2NjkvsWzbyZZvjhgMeIZ+Ags24emLW/N+v6vDQzuoscBZ/yUK3H/6CWfCrJMiM2CCsCFjeD8oqVnRViHyzCZ4UStX1Ey/iZieddolrS4yOtRAPiznqWw6TE4iSue/D58Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579540; c=relaxed/simple;
	bh=FCFL12PX1xMc1fw1YNErW36hkFF8KlDO7hGlj6HYSk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlBhB0XYDm4hEVKB4Lo72oSeEnqHJzF1PMi5TzpM2Xwvk3ogP2IIPcpzWzWcGUnio8oSuUJ3RK+pzIljjRlydpbuiiUIWhYMRq5D8rRPLSO51lceZSQSNKEh6Wj3feIg1xyoCgTpZpVxnM4LuhWQe8CgO+44jyxkmuLpiV6Pa5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZZaGBKF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709579537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8EVmqubOm/naTi4DXPm1SKDmPkXIqlx/6rFI/v4VRk=;
	b=fZZaGBKFbMp3iBS3Omk9/bMMu+aqmKm7yFwKIGFUWY0EyVF+ZgE4rH+4AOJdlzygSTF002
	5w914kd5awlVrzzXarXnjyNpskXRJDOuXnDSbSWWCrZnUhUZBnSSW1SYUpSW7O5eDTHLr1
	jID0xvcSz9B3PM0HufnEIw39kNfiUPo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-_XRxDhY3OXiGgNy_FXcg2Q-1; Mon, 04 Mar 2024 14:12:15 -0500
X-MC-Unique: _XRxDhY3OXiGgNy_FXcg2Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a451f02918aso112941466b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 11:12:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579534; x=1710184334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8EVmqubOm/naTi4DXPm1SKDmPkXIqlx/6rFI/v4VRk=;
        b=XHE/t8wS1Vl2ldPRkc7U0ho1S8j4mZ9lIQZ3Z0AjLNX2nG7+0lcGzLgBiFHrDCi155
         x8+mOEXouX02Kfj7W1l9dZKwbgyasxPJplS/WnREq3bkjhSa9Cx1C8nWnxPSDsZDhB7a
         KdPluY8hIbamRPfUz+YWHOafGfumZ5aE34yA/ck967iDkcuDSYcbJMU22rUWUJoJBlqY
         6Bo8KACIeKjOgZHn1Hs0llghVXTKWMjYOX+iNizi2bt2DKPWpNVKBqxE9E1zUkUcZVpj
         gdWMhRieC3i4DQPLhSRdx/lXJrcHHKA1s9o9ywZV1wqgDLf8R6hyqX/8Vi6z2wkwda4V
         r22Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpqK/OS80FY2q+9dwhhLHa3zRJVuPxDVkds8ZZDPrqm9rmfEVG0GgrPzj2YVgXjEa7wHmhBYtwJBmbCdNBNhN7IQDf+FGa71vAXXlF2g==
X-Gm-Message-State: AOJu0Yyrhzp6AlBtts9vfiOwV5cWoTtryJuNfHgSa67RhgAHlYcaoscq
	TNVaJlE7m3w3xgFwEc2bU9KP0vP9K2ZcOf2OoylvnDC+M2Tdj3ngREtvSfP72t3jLfLykmbbztP
	9PtxiNDoOZi8xf/cB9F+VEQ1Yt9nMf/v0lOsUdwLu0yDDKW9EV7Y4UnqxtBR8MQ==
X-Received: by 2002:a17:906:7118:b0:a45:5a30:a3f2 with SMTP id x24-20020a170906711800b00a455a30a3f2mr2153537ejj.52.1709579533948;
        Mon, 04 Mar 2024 11:12:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFX1Q/wZ7CJ2r1e6hCCc+VyjZB/tTtQIwfCNV3D27NByDQoWJl1zA3SfjsT0YkL8gJSlbibig==
X-Received: by 2002:a17:906:7118:b0:a45:5a30:a3f2 with SMTP id x24-20020a170906711800b00a455a30a3f2mr2153513ejj.52.1709579533307;
        Mon, 04 Mar 2024 11:12:13 -0800 (PST)
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709064a4b00b00a44a04aa3cfsm3783319ejv.225.2024.03.04.11.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:12:12 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Allison Henderson <allison.henderson@oracle.com>,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v5 03/24] xfs: define parent pointer ondisk extended attribute format
Date: Mon,  4 Mar 2024 20:10:26 +0100
Message-ID: <20240304191046.157464-5-aalbersh@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240304191046.157464-2-aalbersh@redhat.com>
References: <20240304191046.157464-2-aalbersh@redhat.com>
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
index 5434d4d5b551..67e8c33c4e82 100644
--- a/fs/xfs/libxfs/xfs_da_format.h
+++ b/fs/xfs/libxfs/xfs_da_format.h
@@ -878,4 +878,24 @@ static inline unsigned int xfs_dir2_dirblock_bytes(struct xfs_sb *sbp)
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


