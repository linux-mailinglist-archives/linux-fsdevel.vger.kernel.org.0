Return-Path: <linux-fsdevel+bounces-13534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B39870A52
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 20:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373EB1F2301A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5394E7D077;
	Mon,  4 Mar 2024 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/bQ12il"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0600D7BB14
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579549; cv=none; b=TdoP1i26NqYQezSl0fFlc9E7UT4d8hLGearja3XkIKyphtZtkEUdCLEnc0y8bMkcP12Q45f3WhTrL3ONIDPngA+jRWjSp/84vcnMaydjtxiZgF1fQi1DmbOZLU6rW6SnbKvZhkqIYYph56R5AX3MZcKf1UH7ANG92Ny6S+yUunc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579549; c=relaxed/simple;
	bh=R4yx8qPBsT6oFy9V3t0TmLDLaTl9LfPwUZGazsRbRmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URQCtNHqe3DpF8H6A/80QyZqrbsXF3ijIT7rsKbu5NBUYkl2X303yShHv4j/Gkn2WEKg5429MlLcMjUHjoIagriTsL5xDc1SVNw7yUvxKxjY18HesYfbGoMwurKZF/DdmAfnu2W7VNS4pgAQlXJ5J8DDfth1dGr+XlDgtPoI9k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/bQ12il; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709579547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/DVvRiqyNvnHobA7Dl65jX1eWvv52XzmYNOVCQE0Ls=;
	b=N/bQ12ilBKb86e+qKed/AEaCwBTdMghKXW7knmGzBABE/baNl6OnL+pfQ/8F26qHyLak9S
	rjXdHoh2lHS9T+tjIjnwQ75an4VDgqFD134hrSApRX9p+Revv6+eP1hSyFcWPK67SB0dea
	dn4I4APRMCQEa08Fd50lZC/UrDm8h38=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-fhVKot-bPBybFjyBmiAdRg-1; Mon, 04 Mar 2024 14:12:25 -0500
X-MC-Unique: fhVKot-bPBybFjyBmiAdRg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5131eb8137aso4045192e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 11:12:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579544; x=1710184344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/DVvRiqyNvnHobA7Dl65jX1eWvv52XzmYNOVCQE0Ls=;
        b=roVKkO/7hj5J41GMLWmfBZ9e8qUGLblJtKGRL1HJoy2cGQ8xSGBp8R6/03mt4FPJ61
         lYO8rymAvDSAO6GJGHgSFC/ws1aPAaXIqsZ1HsdhRFVt644atPkS5WkYexGrWZCuslzq
         0nenAJGhc4eSRuGJhg8Es1NqEE3aNwV+MpOVNSoo+9fJuv6dlA+SeEsocw5GRIFzg/qg
         bR0b+0f2dJaNEKGtDDdPOFnJH4VKpAzgdtYqgnTEBTuAC0yDPHXHEdHKwrMk+BRFEO0P
         0guooYSC01vSBWZO55+5UyrNHB9DotjOXvkXNpn9Q5XIYXSrY7+nXDd8B2UkHpCcGr/u
         6W0w==
X-Forwarded-Encrypted: i=1; AJvYcCXrgU4atG65jQwIYalkL/QqhBrD1z5JR060aVAIbL9jClZB+0AAluLjORb5AXxhH1nBcBCt15qSn3MzkpPzVjcb++1j1BeJWdF7rUHkJw==
X-Gm-Message-State: AOJu0YwpsP8pjeVJOPp5ezs8An16hBfa2ldQrnPvDZGf5PW/W+NGxMBu
	7fOV7/e0ddQW0w6mKmhon3LzxVSpAlLLXGV4z77BVRDgf9zk96UFuIn6a1As6H9atZkdArz9SLA
	+FB/gft8bphWvn6gwVEvDbAHfDj79O0KkOdx8TUjZ2m0VhzsxC7tTSJ7TG9Gm1A==
X-Received: by 2002:a05:6512:118d:b0:513:40eb:b422 with SMTP id g13-20020a056512118d00b0051340ebb422mr4082415lfr.34.1709579544290;
        Mon, 04 Mar 2024 11:12:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBr8j2SGz5TnSfldxisRXVuJY3n+1hKwwCgX1qbv2Q/ubk3JHEqnyRHDsd0ZjF4pdMmuBcCA==
X-Received: by 2002:a05:6512:118d:b0:513:40eb:b422 with SMTP id g13-20020a056512118d00b0051340ebb422mr4082391lfr.34.1709579543671;
        Mon, 04 Mar 2024 11:12:23 -0800 (PST)
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709064a4b00b00a44a04aa3cfsm3783319ejv.225.2024.03.04.11.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:12:23 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v5 14/24] xfs: make xfs_buf_get() to take XBF_* flags
Date: Mon,  4 Mar 2024 20:10:37 +0100
Message-ID: <20240304191046.157464-16-aalbersh@redhat.com>
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

Allow passing XBF_* buffer flags from xfs_buf_get(). This will allow
fs-verity to specify flag for increased buffer size.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/libxfs/xfs_attr_remote.c | 2 +-
 fs/xfs/libxfs/xfs_btree_mem.c   | 2 +-
 fs/xfs/libxfs/xfs_sb.c          | 2 +-
 fs/xfs/xfs_buf.h                | 3 ++-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_attr_remote.c b/fs/xfs/libxfs/xfs_attr_remote.c
index 4b44866479dc..f15350e99d66 100644
--- a/fs/xfs/libxfs/xfs_attr_remote.c
+++ b/fs/xfs/libxfs/xfs_attr_remote.c
@@ -526,7 +526,7 @@ xfs_attr_rmtval_set_value(
 		dblkno = XFS_FSB_TO_DADDR(mp, map.br_startblock),
 		dblkcnt = XFS_FSB_TO_BB(mp, map.br_blockcount);
 
-		error = xfs_buf_get(mp->m_ddev_targp, dblkno, dblkcnt, &bp);
+		error = xfs_buf_get(mp->m_ddev_targp, dblkno, dblkcnt, 0, &bp);
 		if (error)
 			return error;
 		bp->b_ops = &xfs_attr3_rmt_buf_ops;
diff --git a/fs/xfs/libxfs/xfs_btree_mem.c b/fs/xfs/libxfs/xfs_btree_mem.c
index 036061fe32cc..07df43decce7 100644
--- a/fs/xfs/libxfs/xfs_btree_mem.c
+++ b/fs/xfs/libxfs/xfs_btree_mem.c
@@ -92,7 +92,7 @@ xfbtree_init_leaf_block(
 	xfbno_t				bno = xfbt->highest_bno++;
 	int				error;
 
-	error = xfs_buf_get(xfbt->target, xfbno_to_daddr(bno), XFBNO_BBSIZE,
+	error = xfs_buf_get(xfbt->target, xfbno_to_daddr(bno), XFBNO_BBSIZE, 0,
 			&bp);
 	if (error)
 		return error;
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index d991eec05436..a25949843d8d 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -1100,7 +1100,7 @@ xfs_update_secondary_sbs(
 
 		error = xfs_buf_get(mp->m_ddev_targp,
 				 XFS_AG_DADDR(mp, pag->pag_agno, XFS_SB_DADDR),
-				 XFS_FSS_TO_BB(mp, 1), &bp);
+				 XFS_FSS_TO_BB(mp, 1), 0, &bp);
 		/*
 		 * If we get an error reading or writing alternate superblocks,
 		 * continue.  xfs_repair chooses the "best" superblock based
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index 2a73918193ba..b5c58287c663 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -257,11 +257,12 @@ xfs_buf_get(
 	struct xfs_buftarg	*target,
 	xfs_daddr_t		blkno,
 	size_t			numblks,
+	xfs_buf_flags_t		flags,
 	struct xfs_buf		**bpp)
 {
 	DEFINE_SINGLE_BUF_MAP(map, blkno, numblks);
 
-	return xfs_buf_get_map(target, &map, 1, 0, bpp);
+	return xfs_buf_get_map(target, &map, 1, flags, bpp);
 }
 
 static inline int
-- 
2.42.0


