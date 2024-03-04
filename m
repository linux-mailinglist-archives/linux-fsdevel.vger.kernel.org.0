Return-Path: <linux-fsdevel+bounces-13538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAB1870A58
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 20:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386EB281537
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFBA7CF37;
	Mon,  4 Mar 2024 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMPB+RBk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8DB7D07F
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579552; cv=none; b=T8DCoRfJjX+M8NLa/M+1jTNl+iWNeMMQlTC7qOPYzu/mDiPxP7mwhpf06yBZESSOWEqayK673WE/nIbKAQaGsRMmEY+EUmzoCbywadWS/KszeuTUvseop5xEZENdNG8MmWM4t7j164vtmxZRxwnXCSAIsfS69aWVR5XjrV4jltU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579552; c=relaxed/simple;
	bh=iCYfKJ0kFYzgtrazzboyA1nOY5OMP0Y0MHu/TR1n9Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRtBQi1O6KebduWGxWHJR/M/8KrktYKkkqqUJSZNilqAoW09tXBjPmH/AOW5jCvetQuhREczFavxCZn1BCIJqVC8wY0CRCQorciM/riS+V9M7nD0b/VMV6iBtIySMwXe9BO5QdSd7llKr7vPjxcvKgTep/zJ9FYUvUNfDS3WEgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jMPB+RBk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709579549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XIjyGj3ThYRh+HmmhdifsZuAaDeDolxvDOaonPSFEQw=;
	b=jMPB+RBkFTJor/JHBJ2WtvdyvFUFpC6Ux8ltuq03iUEVkgivYWzDiv5pHDBdC9HhhsddN0
	qV8G3/s/Vrmk4XPv6Hy/OMPIGbX7u5TSl9RFtZhuTmQyxYlJhkGkg7Bp81QyugJV+VaQA7
	1atjUih46wFqhduY4aCWN2RwNQntqhQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-EnNaJWs7M22Ocsq_QKHOAg-1; Mon, 04 Mar 2024 14:12:28 -0500
X-MC-Unique: EnNaJWs7M22Ocsq_QKHOAg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5133f0f1b9bso1694270e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 11:12:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579546; x=1710184346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIjyGj3ThYRh+HmmhdifsZuAaDeDolxvDOaonPSFEQw=;
        b=ntCBqJUVkuMF+Rto7wZnEnDSG0jZqYGg9Xa7HKxb+3QXUpx7sho3f9u/8wAPgxemUG
         FiYTtkTDoI4YRGltzjGFT4pn/xG0bEc0mI3/fOOO+fAB59ziCG6bdKJXlpdiDz35IKgC
         /0GO9iaXVGN7Nud6sFfcWrT7d3aY4A8bdirs3tzUJaQkwiv0aWHFGBSpb4QMwz3sltvp
         khMO2RdIC769P7uXYmWmwNNVPcsR64R75igLMzjZUlYUt+YeqQwJ14NuOEzjR9jtkbzG
         QfoqaQFRqZCJVDxDwLGI2g9tvMwUlVQ14NPq0YYFYsOPKST7hF5hIbuhJ8LomyoVT+ax
         gZfw==
X-Forwarded-Encrypted: i=1; AJvYcCV117a6f1PnIpZVEGDeZzhqS071ToQR1lTVQufdUMw2tnIJZ2wX+JPfMnT7p8gDShOC+LTNip+19fy5k0+z2FTRN7RN6EY0CQMonOWz0g==
X-Gm-Message-State: AOJu0YxgSHC0iTyJQCVwZJLf1ruioRS/6ISom0RP0lOx4JDP2zv8fF4C
	H/4zmRGRDmMFgUqvBoNGNkyTI3D8ddWijzVy/uaOnpqLGAIWwfOMmw6947hRdJrfjnv1colQMW0
	aQ/oOM6VW8CRdqX+2WKNwgQF2vGARzvBDrT/NtFiQG/gfDvNm7Z+ef44L7kne+g==
X-Received: by 2002:ac2:55bc:0:b0:512:bb33:2eab with SMTP id y28-20020ac255bc000000b00512bb332eabmr6263983lfg.58.1709579546702;
        Mon, 04 Mar 2024 11:12:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsWhH2n6f8sGCcVRKP+Ql2DOsPvlPsXH0xMAYeWcoI/5BOIZnj57KeeBn8GBeEsExnNwHY0A==
X-Received: by 2002:ac2:55bc:0:b0:512:bb33:2eab with SMTP id y28-20020ac255bc000000b00512bb332eabmr6263977lfg.58.1709579546458;
        Mon, 04 Mar 2024 11:12:26 -0800 (PST)
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709064a4b00b00a44a04aa3cfsm3783319ejv.225.2024.03.04.11.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:12:25 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v5 17/24] xfs: add inode on-disk VERITY flag
Date: Mon,  4 Mar 2024 20:10:40 +0100
Message-ID: <20240304191046.157464-19-aalbersh@redhat.com>
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

Add flag to mark inodes which have fs-verity enabled on them (i.e.
descriptor exist and tree is built).

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/libxfs/xfs_format.h | 4 +++-
 fs/xfs/xfs_inode.c         | 2 ++
 fs/xfs/xfs_iops.c          | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 93d280eb8451..3ce2902101bc 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -1085,16 +1085,18 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
 #define XFS_DIFLAG2_COWEXTSIZE_BIT   2  /* copy on write extent size hint */
 #define XFS_DIFLAG2_BIGTIME_BIT	3	/* big timestamps */
 #define XFS_DIFLAG2_NREXT64_BIT 4	/* large extent counters */
+#define XFS_DIFLAG2_VERITY_BIT	5	/* inode sealed by fsverity */
 
 #define XFS_DIFLAG2_DAX		(1 << XFS_DIFLAG2_DAX_BIT)
 #define XFS_DIFLAG2_REFLINK     (1 << XFS_DIFLAG2_REFLINK_BIT)
 #define XFS_DIFLAG2_COWEXTSIZE  (1 << XFS_DIFLAG2_COWEXTSIZE_BIT)
 #define XFS_DIFLAG2_BIGTIME	(1 << XFS_DIFLAG2_BIGTIME_BIT)
 #define XFS_DIFLAG2_NREXT64	(1 << XFS_DIFLAG2_NREXT64_BIT)
+#define XFS_DIFLAG2_VERITY	(1 << XFS_DIFLAG2_VERITY_BIT)
 
 #define XFS_DIFLAG2_ANY \
 	(XFS_DIFLAG2_DAX | XFS_DIFLAG2_REFLINK | XFS_DIFLAG2_COWEXTSIZE | \
-	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64)
+	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_VERITY)
 
 static inline bool xfs_dinode_has_bigtime(const struct xfs_dinode *dip)
 {
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index ea48774f6b76..59446e9e1719 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -607,6 +607,8 @@ xfs_ip2xflags(
 			flags |= FS_XFLAG_DAX;
 		if (ip->i_diflags2 & XFS_DIFLAG2_COWEXTSIZE)
 			flags |= FS_XFLAG_COWEXTSIZE;
+		if (ip->i_diflags2 & XFS_DIFLAG2_VERITY)
+			flags |= FS_XFLAG_VERITY;
 	}
 
 	if (xfs_inode_has_attr_fork(ip))
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 66f8c47642e8..0e5cdb82b231 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1241,6 +1241,8 @@ xfs_diflags_to_iflags(
 		flags |= S_NOATIME;
 	if (init && xfs_inode_should_enable_dax(ip))
 		flags |= S_DAX;
+	if (xflags & FS_XFLAG_VERITY)
+		flags |= S_VERITY;
 
 	/*
 	 * S_DAX can only be set during inode initialization and is never set by
-- 
2.42.0


