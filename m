Return-Path: <linux-fsdevel+bounces-64121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE0ABD948D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 14:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B52CD500AE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 12:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FCC31197F;
	Tue, 14 Oct 2025 12:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XE/sU7vV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8E5312819
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443887; cv=none; b=knYJdRnlmiXflUs03D0OjY3gVeqDPY9Jd+vUtSwCVt/AE8f2+Orw/DFEojxfP/nk6uUDsj96mR4o3HhsOgBmzcRJ0VDMI6Hcrvaa2L3ih5ms0MP+K7RvocXmCEwtSPIw0sIL5Fv88twb/xFimavaK2EA1Yd5I7VHxBfK6xghSr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443887; c=relaxed/simple;
	bh=jgMV6UggKwFsBrAbTcGz69DSEwAk8LpHu4jY6zQq8Mg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=qO57Nt44NpBvM92IHAMyxPWuVAFfdOlACZu4X/5h5Mtic5GuWvPnMGsRo9aAFwzAkhmyiMIuXqcj+s9PTN283qd1M28lN4+EORCik8W1h48lYanyaw1qM261yQSB7axaKFvPwAnnDLQa3z4dGZmptOjb+JaQ4HCTwSlfGfmZRfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XE/sU7vV; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20251014121120epoutp016c89820140c15b506b95903892c67d0e~uWmG3Vb1O1133811338epoutp01o
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 12:11:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20251014121120epoutp016c89820140c15b506b95903892c67d0e~uWmG3Vb1O1133811338epoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760443880;
	bh=61qDs/uNLNIIdKnnYQdqSL+IPjVsVRa8wMEMFzbI1Ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XE/sU7vVXE/e7MnP7E7r0AmM0u0xHWNb0WuN2b/dUX9/kpXzsXJmeIxfhY+/Ey9jP
	 cFgzwX4SMWh/mvWFDEFlps9TZ+TGhqvUXvUIkeflj27ofVsdAoY5dhzLdy5cNAElfS
	 gHxIpSt4QFXj7OwCKUo0FtsoDs2jDAzA8y40Ny5s=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20251014121119epcas5p37555d2e9cbae9ba706e6102f72c13305~uWmGQctVW1718117181epcas5p3b;
	Tue, 14 Oct 2025 12:11:19 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.93]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4cmCjy2l8sz6B9m6; Tue, 14 Oct
	2025 12:11:18 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20251014121117epcas5p3f095fc3e8c279700c7256e07cd780c5f~uWmEts7qX1002310023epcas5p3P;
	Tue, 14 Oct 2025 12:11:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251014121113epsmtip19fc785cad0e58b227dd7ca61b631f1b3~uWmApRSVh1306813068epsmtip1l;
	Tue, 14 Oct 2025 12:11:13 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	djwong@kernel.org, dave@stgolabs.net, wangyufei@vivo.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, kundan.kumar@samsung.com, anuj20.g@samsung.com,
	vishak.g@samsung.com, joshi.k@samsung.com
Subject: [PATCH v2 12/16] nfs: add support in nfs to handle multiple
 writeback contexts
Date: Tue, 14 Oct 2025 17:38:41 +0530
Message-Id: <20251014120845.2361-13-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251014120845.2361-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251014121117epcas5p3f095fc3e8c279700c7256e07cd780c5f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251014121117epcas5p3f095fc3e8c279700c7256e07cd780c5f
References: <20251014120845.2361-1-kundan.kumar@samsung.com>
	<CGME20251014121117epcas5p3f095fc3e8c279700c7256e07cd780c5f@epcas5p3.samsung.com>

Fetch writeback context to which an inode is affined. Use it to perform
writeback related operations.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/nfs/internal.h | 3 +--
 fs/nfs/write.c    | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 5b3c84104b5b..99eb6a5d5d01 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -857,8 +857,7 @@ static inline void nfs_folio_mark_unstable(struct folio *folio,
 		 * writeback is happening on the server now.
 		 */
 		node_stat_mod_folio(folio, NR_WRITEBACK, nr);
-		wb_stat_mod(&inode_to_bdi(inode)->wb_ctx[0]->wb,
-			    WB_WRITEBACK, nr);
+		bdi_wb_stat_mod(inode, nr);
 		__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
 	}
 }
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 4317b93bc2af..0fe6ae84c4a2 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -868,8 +868,7 @@ static void nfs_folio_clear_commit(struct folio *folio)
 		struct inode *inode = folio->mapping->host;
 
 		node_stat_mod_folio(folio, NR_WRITEBACK, -nr);
-		wb_stat_mod(&inode_to_bdi(inode)->wb_ctx[0]->wb,
-			    WB_WRITEBACK, -nr);
+		bdi_wb_stat_mod(inode, -nr);
 	}
 }
 
-- 
2.25.1


