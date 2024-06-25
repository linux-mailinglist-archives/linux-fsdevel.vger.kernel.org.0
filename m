Return-Path: <linux-fsdevel+bounces-22420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25572916F99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 19:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A79BEB238BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 17:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9341E178388;
	Tue, 25 Jun 2024 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WR+eFt43"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD2D17625A;
	Tue, 25 Jun 2024 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337920; cv=none; b=RQAdGaHkWaOIQBpxCb65dLkab1E8E38U4ZICHeK/dHNW8rC/SVRaL1xfkVlwq9FJYdq4mwpqkBtrytgK2KOyYU56O+ZXW8xAufLvcCZHRWXdbVy8Kpa6LeiRCIoA0YdxzfheExC/q3kSxWwP8p50sXouBd3U8i9qHQvmgI9/UFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337920; c=relaxed/simple;
	bh=0N6oi+IPZkFTrTjrVcOct5hcISqKXBe6Vj00I9I8xXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=se3ZK2rISng9QhAWP4jOF9+aB0upwzLPSJnYevDk1seZqSX7Dqdg9pu2VdSU7ROcm10EC9p0pD5TMelvRZYzS2xf2fYoUg69paKCb+T8LQndas2atEV4B2YBB4raCA9Sv4sCX0mlMmgXTtbyfgrfJWByVOvf3gKGPOaPPPZVig0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WR+eFt43; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Nf/UT31G65IHAm5muheJVAnRfI2lc+8tohMZlZDO228=; b=WR+eFt43iANCOFqh0HqkxDPb1l
	l3GZgLfI2QRocCj0rRqNojtcNDRu8Cm+NP+RaWbO8sfwCAj4H/38t07U2Qht+SWunti0sElbHo+YA
	bPED0+DiyZb/5gFNLUg7fc4h1TEw2hWWUT89E7sRFUwx5RWuoYO1tDW/vWF+tKh1aABSlInnYXy2I
	3oWhDI/OoOt22N8iZCKYJYuCd/2bb5b+GD+WA2nJE3YSKRwUti+wnhIw4Fyn+vvD9BE9LHRQ4wrjy
	MYiTw0B+xqq/5i5/gP4+dL3pywB33gDGSU9mGX0FLIl9Ryv7P7mgzVb2JaNdP8IrNyCUHNNHMsFZE
	J28yfeYw==;
Received: from 179-125-70-190-dinamico.pombonet.net.br ([179.125.70.190] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sMAKe-007Oa3-K7; Tue, 25 Jun 2024 19:51:53 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-fsdevel@vger.kernel.org
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-kernel@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>,
	dlunev@chromium.org,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH v2 1/2] fat: ignore . and .. subdirs and always add links to dirs
Date: Tue, 25 Jun 2024 14:51:32 -0300
Message-Id: <20240625175133.922758-2-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625175133.922758-1-cascardo@igalia.com>
References: <20240625175133.922758-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tools used for creating images for the Lego Mindstrom EV3 are not
adding '.' and '..' entry in the 'Projects' directory.

Without this fix, the kernel can not fill the inode structure for
'Projects' directory.

See https://github.com/microsoft/pxt-ev3/issues/980
And https://github.com/microsoft/uf2-linux/issues/6

When counting the number of subdirs, ignore . and .. subdirs and add two
when setting the initial link count for directories. This way, the number
of links is always correctly accounted for.

With this fix applied, we can mount an image with such empty directories,
access them, create subdirectories and remove them.

This also prevents corrupting such filesystems as when the inodes would be
put, since no links were accounted for, all of its clusters would be marked
as free.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Gwendal Grignou <gwendal@chromium.org>
Link: https://lore.kernel.org/all/20220204062232.3410036-1-gwendal@chromium.org/
Cc: dlunev@chromium.org
---
 fs/fat/dir.c   | 4 +++-
 fs/fat/inode.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index acbec5bdd521..4e4a359a1ea3 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -949,7 +949,9 @@ int fat_subdirs(struct inode *dir)
 	bh = NULL;
 	cpos = 0;
 	while (fat_get_short_entry(dir, &cpos, &bh, &de) >= 0) {
-		if (de->attr & ATTR_DIR)
+		if (de->attr & ATTR_DIR &&
+		    strncmp(de->name, MSDOS_DOT   , MSDOS_NAME) &&
+		    strncmp(de->name, MSDOS_DOTDOT, MSDOS_NAME))
 			count++;
 	}
 	brelse(bh);
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index d9e6fbb6f246..234c244d1252 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -534,7 +534,7 @@ int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 			return error;
 		MSDOS_I(inode)->mmu_private = inode->i_size;
 
-		set_nlink(inode, fat_subdirs(inode));
+		set_nlink(inode, fat_subdirs(inode)+2);
 
 		error = fat_validate_dir(inode);
 		if (error < 0)
-- 
2.34.1


