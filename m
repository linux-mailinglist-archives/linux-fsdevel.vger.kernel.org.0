Return-Path: <linux-fsdevel+bounces-55329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64370B09815
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407A74A1244
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF81E267AF2;
	Thu, 17 Jul 2025 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXRZS9Gk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED232641C3
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795015; cv=none; b=Jh/oi3roTA9CVRSHyudphNzrCkRiLJaY0sHqEdmk10LOPNtAnzNS9kvvjgHCxNbR0HZJOcAN5R5IrxEZTJBkfOKAZuN9ZseTuwVh953x2RNOLKsI12gwEZIwTBOhhFakXzyeVNWjoFg4XuUYZoPspKLGqjdNVj3Dd3WPw+eZ6+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795015; c=relaxed/simple;
	bh=b48SZB56jpGKbExqxV7JgNMLqTHireBGWIw6oVtNnuw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNTkGS/S/5/Wyd3gDAdNpaMRCRatT8QlxIAgBmLJk4/aV21a+TgkSzfMf0teoMxtbZgVyPqP8LtUq2LSLXJzmQwll9LljirlLT/MP3kV8ARCHfQt0LwO4+NitBWw+Mdq16/YrZi7SLci5DxOyuL+aquOZeobt/xpYOxBMoCV4Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXRZS9Gk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26247C4CEE3;
	Thu, 17 Jul 2025 23:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795015;
	bh=b48SZB56jpGKbExqxV7JgNMLqTHireBGWIw6oVtNnuw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=XXRZS9GkvIf48cdZk6UBu2c/TbyOhiLp0/DHvUqEhp7QcuzP5T/rqC+XBJvE2qDlZ
	 wEdJ2LMMiUoL593W5nx+MJ/xGHlO5MBOEMGJWoKwIPk+sCdXxC9A2zkmMDdt9g8687
	 lLhe6SmcK6PCdQEV/3E3nfTJwYjgLdww8fA8Mua8VhP2fPlrpCQ9jDx4b4+04Uj7In
	 AeiNimYzxqH4m97GQS8irSiq0kfh+4N+pllnEL+tSLg9SUbn2uMzcFAdVJqB3pHcBX
	 zcQ8PW/YuRVVYnF1Yr7gN6UlPUHopaTwMHBmcG1YeLC++yCi6s9zQbCzrCNrMB3pSB
	 dn1pPKDAqy0Iw==
Date: Thu, 17 Jul 2025 16:30:14 -0700
Subject: [PATCH 08/13] fuse: implement large folios for iomap pagecache files
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279450110.711291.14599010683719379286.stgit@frogsfrogsfrogs>
In-Reply-To: <175279449855.711291.17231562727952977187.stgit@frogsfrogsfrogs>
References: <175279449855.711291.17231562727952977187.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Use large folios when we're using iomap.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/file_iomap.c |    6 ++++++
 1 file changed, 6 insertions(+)


diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 112cbb6cabb015..0983eabe58ffef 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -1339,6 +1339,7 @@ static const struct address_space_operations fuse_iomap_aops = {
 static inline void fuse_iomap_set_fileio(struct inode *inode)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	unsigned int min_order = 0;
 
 	ASSERT(get_fuse_conn_c(inode)->iomap_fileio);
 
@@ -1353,6 +1354,11 @@ static inline void fuse_iomap_set_fileio(struct inode *inode)
 	INIT_WORK(&fi->ioend_work, fuse_iomap_end_io);
 	INIT_LIST_HEAD(&fi->ioend_list);
 	spin_lock_init(&fi->ioend_lock);
+
+	if (inode->i_blkbits > PAGE_SHIFT)
+		min_order = inode->i_blkbits - PAGE_SHIFT;
+
+	mapping_set_folio_min_order(inode->i_mapping, min_order);
 	set_bit(FUSE_I_IOMAP_FILEIO, &fi->state);
 }
 


