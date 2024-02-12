Return-Path: <linux-fsdevel+bounces-11159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870D4851A7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 18:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4B91C22363
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA423FB3F;
	Mon, 12 Feb 2024 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsypX54G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1413FB28
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 17:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757222; cv=none; b=BIeDm1xH+uAQ7DzEMD+9Xo4Qec+gBvF5Dp0qBUUbDljhUeJevkuUNeKC9XKsvlt6Jk+k7Y0gFqJxycQ7BPGJagwvZhaAse44BUyZ+K2HeUTgjMvp3q0oCPEigpIGlq7tfYvDuqlo57hWk637GHim1qVBqV0EH+5nx4FCzwBPysA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757222; c=relaxed/simple;
	bh=5efDprULe6taPXbMIbssh9R9ZTvpV1+LRg5VBOs1ncI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j17FlvqsHnjsxrLQY25IyuBXfjRzfNkRc6lcyMO2wi6He2iyx5ib+zU0yV9pF7+BunhPjE/MZFk2v4lOs3zXQ3xBgg+KrfZfvqI/kX0u/2uLi7P/CEnEuwCMtsKpgf536JWcK291w/u1/eduC60MOjqGlNMUCBuKoX6lxXy4b4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GsypX54G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707757219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JU0n6o39Qx9ylv78PJjsl41s62AUUJ55j4stQvjouKk=;
	b=GsypX54GdYjGBg3A453Kjl/694EmIaLYSc7I9nV1mhNPeLr7fzPk9PQJ2ZZz6PX6ldJ543
	5/DLEX5GBr4koyJdR8SYIrHQK6PHhF2fSyHXxPTGOH/zzcQ1sAIGySM4eCi83YhkjzhHdt
	6JGtHqpj27cGoyk9THlYrdJDedNiqXM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501--Vpqgs4lMti-Uq1XINW7jg-1; Mon, 12 Feb 2024 12:00:17 -0500
X-MC-Unique: -Vpqgs4lMti-Uq1XINW7jg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d0c647f8ddso36267511fa.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 09:00:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757216; x=1708362016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JU0n6o39Qx9ylv78PJjsl41s62AUUJ55j4stQvjouKk=;
        b=VYgyz/0WUikbOQR7kKjKV3jUkgGy8FJvuau1oiEv7H0BGbFsGy9zqJP+9KTAZMqRvv
         NOLCArp5mrompDmD5YDrqUOaa0Qyi6CCq94zTcplgUhjcxyngJGKuiQth5vvK6l85qCH
         gaK7nZ+KUTQN4Sa29mFkRk+fQkHgiXmqSoOkYJkAvCYVf3nmwf2LMTWfeAmDBXkBHkng
         IVg5yK5bB8gSamyrmaMM2zuUoU/hWHisJwc7UtOLGyHGpyQM8/yAtlMc4s4+c0yJHbty
         OilvK6oGQMLMZWbqQnZK/nzzcBnMMy/f9VC0NH3vhP1ExXQgumuNc5S67QWjvFAj8DC8
         qZfA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ/M5NnHTbvEHe3ExbPalQ4DrhzxcHrzURzlVlUpCH2w/UVhvlzLR+E7ozGeH5x/cZXbSCID4io7whc+FG7e9XYF2dWrkKbI3hVSWxGw==
X-Gm-Message-State: AOJu0YxHrepjBKfYPG/q0H1qOAktnS+k076Z6t54ytleLiybG7lT5jBf
	J/iSszLFO2xpzlF+0QPqK6dS/n3QfxOp2yLAQSo7lMoFYgA5ioOXy+akJJrXfMLhQycvuyp9NH8
	/R8vwrRlcORIw5w2pf+m9ImFJtAmWOuXuev/dtLwmHNaxqUA5ZbgiHDcdzIy1Aw==
X-Received: by 2002:a2e:a586:0:b0:2d0:b758:93a5 with SMTP id m6-20020a2ea586000000b002d0b75893a5mr5900122ljp.18.1707757216122;
        Mon, 12 Feb 2024 09:00:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWfgm/7xQWafBoXVO5m9B2+ecerqMNgmsVK2YVSO0I9LtMY6feCLDnkZOBYsU2n0tsoz4y0g==
X-Received: by 2002:a2e:a586:0:b0:2d0:b758:93a5 with SMTP id m6-20020a2ea586000000b002d0b75893a5mr5900112ljp.18.1707757215872;
        Mon, 12 Feb 2024 09:00:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVn/DPoAemeqvTkQ5zPfLy0hfJFjk4TKK9KhFtVG/UOJ0tl9rOXnZCBL8KZ35eC5xFC6HRbtaADDRpp9DzBfnmNOnXh/NJJ2tH4savAB+mNHahiaMS1HqsVSp99kIhOulubeOW05Q8flG8Rj8GTfbLcvB7+d6vIzEk3qyIoCg29wS/er+jC/w7fwJlPStbzeOShAmMTlvX7WCihOqzG7zVA6CevqmamhlIf
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id 14-20020a0564021f4e00b0056176e95a88sm2620261edz.32.2024.02.12.09.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 09:00:14 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v4 18/25] xfs: add inode on-disk VERITY flag
Date: Mon, 12 Feb 2024 17:58:15 +0100
Message-Id: <20240212165821.1901300-19-aalbersh@redhat.com>
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

Add flag to mark inodes which have fs-verity enabled on them (i.e.
descriptor exist and tree is built).

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/libxfs/xfs_format.h | 4 +++-
 fs/xfs/xfs_inode.c         | 2 ++
 fs/xfs/xfs_iops.c          | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index e36718c93539..ea78b595aa97 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -1086,16 +1086,18 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
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
index 1fd94958aa97..6289a0c49780 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -629,6 +629,8 @@ xfs_ip2xflags(
 			flags |= FS_XFLAG_DAX;
 		if (ip->i_diflags2 & XFS_DIFLAG2_COWEXTSIZE)
 			flags |= FS_XFLAG_COWEXTSIZE;
+		if (ip->i_diflags2 & XFS_DIFLAG2_VERITY)
+			flags |= FS_XFLAG_VERITY;
 	}
 
 	if (xfs_inode_has_attr_fork(ip))
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index a0d77f5f512e..8972274b8bc0 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1242,6 +1242,8 @@ xfs_diflags_to_iflags(
 		flags |= S_NOATIME;
 	if (init && xfs_inode_should_enable_dax(ip))
 		flags |= S_DAX;
+	if (xflags & FS_XFLAG_VERITY)
+		flags |= S_VERITY;
 
 	/*
 	 * S_DAX can only be set during inode initialization and is never set by
-- 
2.42.0


