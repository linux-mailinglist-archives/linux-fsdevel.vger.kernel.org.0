Return-Path: <linux-fsdevel+bounces-11156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06468851A74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 18:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E071C223F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2483D994;
	Mon, 12 Feb 2024 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+PBHLwH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C073D97F
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757217; cv=none; b=F9CUL39IitYEYpir/KisBN/+XY1FbAmYckl+SSwRA8/RlsoCIDBqihpD3N/Z0gfsKpzg/aPgNdDxz1g6yzF7OvWpHCPpGYScuqtPoK4j4OPUHY9bldldfLHCdCZoiOcPQatc9WRs8wVeQk226uNZodcqSfjqKEw7OgpoWKeBLZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757217; c=relaxed/simple;
	bh=1ibjZZPlzIICrNjR9KHrVV/6aFSEbEoifUAOegz0qp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DvRUJTJycoFgZsdygqJDNWGIIOgL5M0ZwOk02QKtXGQKiRfABxHTS3D/GyCsqxAz20asOgK0VtM90SuBd3sFHI7XQ77FXeDZJAggcs57pxnjhUpBWdmBZZ3LfYkpMNmUZAgVyVeRa7eK3jo/mZ+PSzaJhCTv/gbB8BQtkRQ1Gg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c+PBHLwH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707757214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QJ4tEZc1B7qqsV4bfz01n/jViHsnzIbXDrJkDK06xlg=;
	b=c+PBHLwH35vSfC3fDH/3Ec4QIRA14xac9xHhqag/x7ZPHBrhK9l2V3h/7Q8EzG8cNtgO+9
	LGzeafBRLxgQdKWMQ7uBNebr5hcDN+2uYEeC5xVbqSSxvlgtOf8icWN/Ig9cCywc4kDTGO
	oh2wc6rBss7oyWLejP4NYNv4XrMIxQU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-XLxDuzfFN6uJydkCFFfiYQ-1; Mon, 12 Feb 2024 12:00:13 -0500
X-MC-Unique: XLxDuzfFN6uJydkCFFfiYQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-558b84a7eeeso2182762a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 09:00:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757212; x=1708362012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJ4tEZc1B7qqsV4bfz01n/jViHsnzIbXDrJkDK06xlg=;
        b=aEld1Ay9j+CF0JkGTdERJ2++cKAGVm4sI29KmNvSfbkoSdwnr9o3vr7eVhfg0i6Cys
         95zflKlQYkZL8+SFtRPYBX6380b1U5cFiGionbbIBvKYuZICxLrfX6eIJKh+jQ5hZOhh
         waAWMvhIlPsBfJwp4iQGEPVrU4TDZPQZ2fKBeGqRLkM/CfEr8etgDjf3orK9Xla/GWJa
         BbUmSm7pgp8gg825wWDlOvg2XPhjozgK6vqCQJjGzyXe+KfuSQMCNeqCt1yfLu3kjJsL
         qwKjG9mVHZFK7kQURW3FqwTeLsGha2NeGhChIYE/fh2aqXV34znc6Pflx0PvIs7f7hQS
         Apow==
X-Forwarded-Encrypted: i=1; AJvYcCV2QZxDxDq/O+5bk+DWKT3L2JY52KQAPq6bQG1scvs2qxwrnAHvw4yg5WAb3M4y5xDm9DUTiE6REAiEwU6trb9URPH6K07k7424Wk9Jfw==
X-Gm-Message-State: AOJu0Yy1c/9VZc2BYtpxmt6wtrrP7boiBEMiSzt+mUWZR/BLPW8yFpPZ
	Lr8Ds/ki269XjxvZiEtGj3zk+oX4QUwxX61Cv7lmID19gO8dWTOS3iiWbZBdNxIdKrz/d3bdxwd
	ohUMG5x14o1i79tJWRtagCHZA9x0Oons/EOkqdWvefmd9lFsunWivmBJN416K7A==
X-Received: by 2002:aa7:d5c2:0:b0:560:cae:53f7 with SMTP id d2-20020aa7d5c2000000b005600cae53f7mr5267847eds.35.1707757212259;
        Mon, 12 Feb 2024 09:00:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtHWiUhFcZMOEIL20WFxm6YxAN9efCZM6AXt/SbYB3/Uod4FAFOPMud3uNt5aY1GfxgzC8Ng==
X-Received: by 2002:aa7:d5c2:0:b0:560:cae:53f7 with SMTP id d2-20020aa7d5c2000000b005600cae53f7mr5267750eds.35.1707757210095;
        Mon, 12 Feb 2024 09:00:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWZwL63Q7TybuygEI8oPrsklBEsbINljyc7dI1P9zh0zKm43UvLoPSz6Voa45VYmbbg9YyikPKZfW1nu3FIqydRr0jb/4S0VGz0iq3/zOCRgrbmzCCg2NY6dWVJja1Nq09J5b1kg2Awn8IKxk7CIOK6rX+0feKGuxDpmCrjQuywbkD11kx4rVgurB6kBl5DVX1uIVvXSwajZcJHbIum+00H8Vm9jiAh1Uoj
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id 14-20020a0564021f4e00b0056176e95a88sm2620261edz.32.2024.02.12.09.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 09:00:09 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v4 15/25] xfs: make xfs_buf_get() to take XBF_* flags
Date: Mon, 12 Feb 2024 17:58:12 +0100
Message-Id: <20240212165821.1901300-16-aalbersh@redhat.com>
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

Allow passing XBF_* buffer flags from xfs_buf_get(). This will allow
fs-verity to specify flag for increased buffer size.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/libxfs/xfs_attr_remote.c | 2 +-
 fs/xfs/libxfs/xfs_sb.c          | 2 +-
 fs/xfs/xfs_buf.h                | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_attr_remote.c b/fs/xfs/libxfs/xfs_attr_remote.c
index 72908e0e1c86..5762135dc2a6 100644
--- a/fs/xfs/libxfs/xfs_attr_remote.c
+++ b/fs/xfs/libxfs/xfs_attr_remote.c
@@ -521,7 +521,7 @@ xfs_attr_rmtval_set_value(
 		dblkno = XFS_FSB_TO_DADDR(mp, map.br_startblock),
 		dblkcnt = XFS_FSB_TO_BB(mp, map.br_blockcount);
 
-		error = xfs_buf_get(mp->m_ddev_targp, dblkno, dblkcnt, &bp);
+		error = xfs_buf_get(mp->m_ddev_targp, dblkno, dblkcnt, 0, &bp);
 		if (error)
 			return error;
 		bp->b_ops = &xfs_attr3_rmt_buf_ops;
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index 5bb6e2bd6dee..f08108c9a297 100644
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
index 8f418f726592..80566ee444f8 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -245,11 +245,12 @@ xfs_buf_get(
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


