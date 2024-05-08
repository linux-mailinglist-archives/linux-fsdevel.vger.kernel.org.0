Return-Path: <linux-fsdevel+bounces-19019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6848BF67D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 08:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A23C282F66
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 06:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDBC286AF;
	Wed,  8 May 2024 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="oGHYv6U6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6EE20DCC
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 06:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150696; cv=none; b=rhKQcy35MFoqDr0UoTzmuZoQdVldStWTWgfUaCMJtVcDjvsAZEElV6qGm017hJya4CJpr/nTcxgY+GlhGZfMZwiw5HVIa3vSw0Ym9upki6a1RJ8mxwTWultUB4NBFmbgEEcNPkDayKPKYSNzLHx3Cc799GgCdZmpvfbQQuzO49E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150696; c=relaxed/simple;
	bh=/h36RYX9H7UzEpObT7/zcugmyF8Tvl3gAHEalYfm82g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ew8Z9BdQIb3/FDOzFdlqNSMb638quX2SZXVmFzj/3a2QS8CMuXhMwsFQQLHyB7nsf6KdkVyZm682cdi2a9eC6GOQLgCtSMJSSJWdsSKwTfFda4Hjl9e8w2Fc9HG9pTKonWm0ex5/B4cs0ZnMt/FIGur5Zf4U9o7NiCBC0YfDGmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=oGHYv6U6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/bhnDOF+COU09efZTjJ/Cnhv3+dsZPNYBO+m2Fd8mKU=; b=oGHYv6U6i4l4wEg5Q1LPWw2AYV
	tT7Oo1dt+OD7gktluYbYYMf1KduDlDsMvCbopauJcy/zufx6i6Dkgn441B9oHHYS3AgCTeOw/6qqI
	BdbZd2vF8LRPzZyBeuJaH0q1BiccMY9blQPg04h/pOhjkm2RSgVsNC3gZP4vbjMmZ9kRQMOe+9dX0
	kO8xEWN+SJJ+jbbZlgOWG5dFNDa8Hq9ZzjuMbLL6GN9A10alON21J8J/DNUXnFgc5KT4Eed38rKEs
	YC9EAVwJL/ZbbiMztbqGtR0UavcdEBO8mhnkjNQgxHPsw9ESoFBhnf3SG3T1cN6VALqrLa8Pojslg
	Hb9QYzgQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s4b2r-00Fvzh-1F;
	Wed, 08 May 2024 06:44:53 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk,
	brauner@kernel.org,
	hch@lst.de
Subject: [PATCHES part 2 06/10] gfs2: more obvious initializations of mapping->host
Date: Wed,  8 May 2024 07:44:48 +0100
Message-Id: <20240508064452.3797817-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240508064452.3797817-1-viro@zeniv.linux.org.uk>
References: <20240508063522.GO2118490@ZenIV>
 <20240508064452.3797817-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

what's going on is copying the ->host of bdev's address_space

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/r/20240411145346.2516848-4-viro@zeniv.linux.org.uk
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/gfs2/glock.c      | 2 +-
 fs/gfs2/ops_fstype.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 34540f9d011c..1ebcf6c90f2b 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1227,7 +1227,7 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
 	mapping = gfs2_glock2aspace(gl);
 	if (mapping) {
                 mapping->a_ops = &gfs2_meta_aops;
-		mapping->host = s->s_bdev->bd_inode;
+		mapping->host = s->s_bdev->bd_mapping->host;
 		mapping->flags = 0;
 		mapping_set_gfp_mask(mapping, GFP_NOFS);
 		mapping->i_private_data = NULL;
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 572d58e86296..fcf7dfd14f52 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -114,7 +114,7 @@ static struct gfs2_sbd *init_sbd(struct super_block *sb)
 
 	address_space_init_once(mapping);
 	mapping->a_ops = &gfs2_rgrp_aops;
-	mapping->host = sb->s_bdev->bd_inode;
+	mapping->host = sb->s_bdev->bd_mapping->host;
 	mapping->flags = 0;
 	mapping_set_gfp_mask(mapping, GFP_NOFS);
 	mapping->i_private_data = NULL;
-- 
2.39.2


