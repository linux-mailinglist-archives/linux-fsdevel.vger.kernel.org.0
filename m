Return-Path: <linux-fsdevel+bounces-26436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CDD9594A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 08:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464EC1C211FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 06:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CE116F907;
	Wed, 21 Aug 2024 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="noDIEbrv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7839516D4D4;
	Wed, 21 Aug 2024 06:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724221887; cv=none; b=j4OBcIcrzLLGcGZMDZ63Eq9gwSPBsR1RdB9qL+7WKpxODaVqocVbtPQqF5CEjqEo6KsfdJ1U/lKJHxvwizkHmlI05h74X+ypxiJPhDTNNWJiOwmCt4Z2TMxdpsiv/d1XNpy5/s56sFbO0JRpadtia7hn9txTRbknSwz8CrhcQXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724221887; c=relaxed/simple;
	bh=NfsUmb0FFYcRiilsybc0zMaPYMckdg0NKbGXwdEKHHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eze2tyLsB91zN/ZdPZPc4IWoAuKlrpsoJ8mtnNOnAgIeEtweqe9ILhC1ispp1sULDdNl1OW7zB0s/GLcelq0p1n+bQx1W9/kPRtD2SVZK+oioWwk/tbyJvy2/kcXTmG3cpQpZISCrHeQxuEOstFX9qP2NIizeUz/Y5JIuHtl3o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=noDIEbrv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vU0kWYfABuwka6VI88n56wkqORAR2MTSaeAFqfvEHnk=; b=noDIEbrvvTw4R++XbxthpATnxl
	EXjr986vUsYuEAjjZ/thH4MtkURZ01AguH+75Bb6p97TGIgItZck5ftrV3c/NozK3clvvcN6kYEzb
	AS3qFaTLgNp+fD5Ni65DR9oSogkF8t4femjwxYO9TEl+CGcnjqcrhNLypx4bbs7A4YPuZuplCrTS0
	x7FhvHcLOq3BMXx+v+4PzsPjbFUhzGSXQHZP57LtShCof67GT40nOoJmaeoIvpuo0CIn1wzqz69O7
	gY/eqAeaV7x/uKbUoLDuOw8LqcjlFE7i6UnG2K9hfHde9l+rFKPbV2fqpr2Ol4HNHG3jdLYKVl9ME
	tr1vWfcw==;
Received: from 2a02-8389-2341-5b80-94d5-b2c4-989b-ff6e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:94d5:b2c4:989b:ff6e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgesO-00000007iTc-0I37;
	Wed, 21 Aug 2024 06:31:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"Theodore Ts'o" <tytso@mit.edu>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 5/6] xfs: move the xfs_is_always_cow_inode check into xfs_alloc_file_space
Date: Wed, 21 Aug 2024 08:30:31 +0200
Message-ID: <20240821063108.650126-6-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821063108.650126-1-hch@lst.de>
References: <20240821063108.650126-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Move the xfs_is_always_cow_inode check from the caller into
xfs_alloc_file_space to prepare for refactoring of xfs_file_fallocate.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_bmap_util.c | 3 +++
 fs/xfs/xfs_file.c      | 8 +++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 187a0dbda24fc4..e9fdebaa40ea59 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -653,6 +653,9 @@ xfs_alloc_file_space(
 	xfs_bmbt_irec_t		imaps[1], *imapp;
 	int			error;
 
+	if (xfs_is_always_cow_inode(ip))
+		return 0;
+
 	trace_xfs_alloc_file_space(ip);
 
 	if (xfs_is_shutdown(mp))
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 5b9e49da06013c..489bc1b173c268 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -987,11 +987,9 @@ xfs_file_fallocate(
 			}
 		}
 
-		if (!xfs_is_always_cow_inode(ip)) {
-			error = xfs_alloc_file_space(ip, offset, len);
-			if (error)
-				goto out_unlock;
-		}
+		error = xfs_alloc_file_space(ip, offset, len);
+		if (error)
+			goto out_unlock;
 	}
 
 	/* Change file size if needed */
-- 
2.43.0


