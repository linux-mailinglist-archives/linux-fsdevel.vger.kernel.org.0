Return-Path: <linux-fsdevel+bounces-73249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7ADD135AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 15:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CACF4304538E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9EE2BE057;
	Mon, 12 Jan 2026 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBz3Z4gs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="htjNlzb5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172982701CB
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229446; cv=none; b=HaqSF9D/p6JY78mDXzOAs/3hNM1NhpeSCc6xUPOekrga9KJG2ThYWOaytHRc/94IWi4KNvEpNx5H834sUiRUTUC2NaQUzQiKDouwOk+LIRph4pp6O4HcT1FFQv71eDmXTGCMph7UBE1uDCzd3U1XuTgRYoM8kn6hGEs1d38uiGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229446; c=relaxed/simple;
	bh=+9KMgGt3/7caMsee+Z5WvgdzDLlVEyt0+rlirmS1zuc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLdR68QdqOGRcOg0F1B884KOZf8Ce+kSXn8uUZyiH3RG5sSzJEOdaMBhWxuybvzfrixGtGd2jSvauBT05qkQIxwoDWng+wWRI1eynzlEWUNv2f8zF+uf16RHXUUI92YVABBqaUCDL/E7IwWYzwpIthYGzXNGhGX9i7y+AKAD6yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GBz3Z4gs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=htjNlzb5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768229444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wg9iw92qCFC8ETA0UphY+p99eAf356mavdt9eRroIQw=;
	b=GBz3Z4gsS0jkFT6nOWL8waN4loe2d1T/OfdnzLjDcRisr8dzsGgVQqkPFz5itCah57w0Bw
	TdZiiz9ebxV0ICwN7FmNhDRieimsysqk0Qv+Bt3cBMRlF4FHLQLUGvP5UzDApxx46P2i8+
	W9d28rCIPalv2HxObL4lJGX4RozeYQs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-qqOBAW2yNHivLqmuydximA-1; Mon, 12 Jan 2026 09:50:41 -0500
X-MC-Unique: qqOBAW2yNHivLqmuydximA-1
X-Mimecast-MFC-AGG-ID: qqOBAW2yNHivLqmuydximA_1768229441
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-64d18dbff2aso7952375a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 06:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768229441; x=1768834241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wg9iw92qCFC8ETA0UphY+p99eAf356mavdt9eRroIQw=;
        b=htjNlzb5OVygVjE0lQh7sUH7nnx/M+MQFbMB7An7SV+rKQDic95OClPPgjiaPCWIvA
         sSjPF0ddEZvqxGXvDZ1TAIyeu7wxQzjQmvVVhdWHDbFUzfL+XHXI4B3ly7kknadEGTK6
         JXWjePw+3H4Rg5XA9MK+S0ioy2Qs4FJYjBi4py3oHH5KfhxHQA6XH1N23rtd9DS7Na62
         h9q9MWDKeF02ys2HvzK1Shu/650YAoLxqoWHR82CjGRINYXXiyyhaLuR1lBiFXjC0+gm
         T14aBvbgqN/NRJxJaoaPrGEJHj8rrBKUiq9x2FUu2HuRR9PyI/lWWTQ6+YK6bNA3wVrZ
         sNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229441; x=1768834241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wg9iw92qCFC8ETA0UphY+p99eAf356mavdt9eRroIQw=;
        b=Gnp69E26Qkf5wipFKxuMWHmPba46w1h+53cZcQZ7taRVus8qcFKJIPuMPtI/wE3m5o
         poI6woH2tRvMrHelF8c+25Bflk0NVz4K99he03iZBuQxTXrjLiE4XXJYyMOTFfR4T6ai
         RBw1v7wErvf+RrpNeL1v+WGg/GB1mJoJYV/48ch5wnG0exvqI/Lcxm3WsZ0V/ES1nSoa
         PAMJ6OOG0Jfro1CMzVAPtfocTd0uHTUi5eBf2vH7CrSDgReHv9xWUOoRFBUDEwfE34/H
         vnfWM5kv75ZAKKEBrABFS4YUF667LY0uClqMuIhbeGluSDVCvUIa+aRZTCqRnq1XvO79
         25eA==
X-Forwarded-Encrypted: i=1; AJvYcCUXvSHyrCXMMeKbSq4liEHXob7WsLJlszGiLwNQcjpG3pZVlwFL9Y9qduE8ne4kWZLMCnhq5JBM2mUEVqQ6@vger.kernel.org
X-Gm-Message-State: AOJu0YxCYm987S+jCoDQJ6g5pZHr0ggYj+3Cpznx7gvtPXZUNQ4y2r+V
	4ey1zFiLUrrhJ6+dWi5sNU4GXRp7Tz1yFJkdaZGgDrfKr/8X4VziEYrPO8+RmWU6f4q/y94FqW2
	sppIMyCY0PKQjmLv9QRvxYda80DKGwUKxXh+cC0acPRZn91uETwYhN4b52wQYcNm5Fw==
X-Gm-Gg: AY/fxX61XVbnMnWkW5EB0CAjKsT4crhHqZdYMyvQNFlXnyjQZsDjMDX2N53PwaSKcdf
	vPz/LxDIuH++UdxtiQdD430xObzO28nG0p9xMT48BQRK4xF9fy9VBIYlrt5d5D4KU5uXESAxcIP
	20yjNt0C/BvPRbTYguRsh2gMKPismf2XDX97l0J8CUEP+06giOtB8YU2KbczfRxPSr1BDqt3j3i
	jzPCEaJxDNjnERG/fleAda66dDz4ZYfMRsZCjzIZE0mtsu9/OnWy70Tfko1FBmYf0MuDNT9yuaa
	aW3iMH8i3zmplzCJicTwezjta537/GisFQ30iIwQZcjPEFp2e6tSJAzZ+23ZaYOESABzRcMB1iQ
	=
X-Received: by 2002:a17:907:98d:b0:b77:1a42:d5c0 with SMTP id a640c23a62f3a-b844538b3e4mr1950905766b.43.1768229440637;
        Mon, 12 Jan 2026 06:50:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGH2I2rt33a1ynUI4l9WFzFWdhTqQCngUGOXshJjWZ4QNCMhR7ys+oc7vCzG5OqUt6Hb6NJoQ==
X-Received: by 2002:a17:907:98d:b0:b77:1a42:d5c0 with SMTP id a640c23a62f3a-b844538b3e4mr1950903866b.43.1768229440164;
        Mon, 12 Jan 2026 06:50:40 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86fc303d7esm712764766b.2.2026.01.12.06.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:50:39 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 12 Jan 2026 15:50:39 +0100
To: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	aalbersh@redhat.com, djwong@kernel.org
Cc: djwong@kernel.org, david@fromorbit.com, hch@lst.de
Subject: [PATCH v2 7/22] xfs: add inode on-disk VERITY flag
Message-ID: <2hvx4mnwgcdhzcaoyvi37cn4b5wct6zvsz3cswkjrkrrdh3ngl@udq26gd3dd4h>
References: <cover.1768229271.patch-series@thinky>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768229271.patch-series@thinky>

Add flag to mark inodes which have fs-verity enabled on them (i.e.
descriptor exist and tree is built).

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_format.h     | 7 ++++++-
 fs/xfs/libxfs/xfs_inode_buf.c  | 8 ++++++++
 fs/xfs/libxfs/xfs_inode_util.c | 2 ++
 fs/xfs/xfs_iops.c              | 2 ++
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 64c2acd1cf..d67b404964 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -1231,16 +1231,21 @@
  */
 #define XFS_DIFLAG2_METADATA_BIT	5
 
+/* inodes sealed with fs-verity */
+#define XFS_DIFLAG2_VERITY_BIT		6
+
 #define XFS_DIFLAG2_DAX		(1ULL << XFS_DIFLAG2_DAX_BIT)
 #define XFS_DIFLAG2_REFLINK	(1ULL << XFS_DIFLAG2_REFLINK_BIT)
 #define XFS_DIFLAG2_COWEXTSIZE	(1ULL << XFS_DIFLAG2_COWEXTSIZE_BIT)
 #define XFS_DIFLAG2_BIGTIME	(1ULL << XFS_DIFLAG2_BIGTIME_BIT)
 #define XFS_DIFLAG2_NREXT64	(1ULL << XFS_DIFLAG2_NREXT64_BIT)
 #define XFS_DIFLAG2_METADATA	(1ULL << XFS_DIFLAG2_METADATA_BIT)
+#define XFS_DIFLAG2_VERITY	(1ULL << XFS_DIFLAG2_VERITY_BIT)
 
 #define XFS_DIFLAG2_ANY \
 	(XFS_DIFLAG2_DAX | XFS_DIFLAG2_REFLINK | XFS_DIFLAG2_COWEXTSIZE | \
-	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_METADATA)
+	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_METADATA | \
+	 XFS_DIFLAG2_VERITY)
 
 static inline bool xfs_dinode_has_bigtime(const struct xfs_dinode *dip)
 {
diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
index b1812b2c3c..c4fff7a34c 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.c
+++ b/fs/xfs/libxfs/xfs_inode_buf.c
@@ -756,6 +756,14 @@
 	    !xfs_has_rtreflink(mp))
 		return __this_address;
 
+	/* only regular files can have fsverity */
+	if (flags2 & XFS_DIFLAG2_VERITY) {
+		if (!xfs_has_verity(mp))
+			return __this_address;
+		if ((mode & S_IFMT) != S_IFREG)
+			return __this_address;
+	}
+
 	if (xfs_has_zoned(mp) &&
 	    dip->di_metatype == cpu_to_be16(XFS_METAFILE_RTRMAP)) {
 		if (be32_to_cpu(dip->di_used_blocks) > mp->m_sb.sb_rgextents)
diff --git a/fs/xfs/libxfs/xfs_inode_util.c b/fs/xfs/libxfs/xfs_inode_util.c
index 309ce6dd55..aaf51207b2 100644
--- a/fs/xfs/libxfs/xfs_inode_util.c
+++ b/fs/xfs/libxfs/xfs_inode_util.c
@@ -126,6 +126,8 @@
 			flags |= FS_XFLAG_DAX;
 		if (ip->i_diflags2 & XFS_DIFLAG2_COWEXTSIZE)
 			flags |= FS_XFLAG_COWEXTSIZE;
+		if (ip->i_diflags2 & XFS_DIFLAG2_VERITY)
+			flags |= FS_XFLAG_VERITY;
 	}
 
 	if (xfs_inode_has_attr_fork(ip))
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index ad94fbf550..6b8e4e87ab 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1394,6 +1394,8 @@
 		flags |= S_NOATIME;
 	if (init && xfs_inode_should_enable_dax(ip))
 		flags |= S_DAX;
+	if (xflags & FS_XFLAG_VERITY)
+		flags |= S_VERITY;
 
 	/*
 	 * S_DAX can only be set during inode initialization and is never set by

-- 
- Andrey


