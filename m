Return-Path: <linux-fsdevel+bounces-58453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D19BDB2E9D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90EDBA08547
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CE01E7C23;
	Thu, 21 Aug 2025 00:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acmgzmEL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B009C190685
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737738; cv=none; b=TWns6SMB+lwj0KyySFor6NKlaJG+J3FRi6tTXidrYhRCTX6Ehj7vA5RQlKpCUHpdj4XGVuOgzeGkM1mCimGTAEwnULDed2NYEBPDYF2Cf66fqnx0f4kbuvlWUvqJru5FAZK8Le6ELoWLh8SC2j6E8WlgfUrm25UuBc+V7NoMIFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737738; c=relaxed/simple;
	bh=qFrAYlZhVp9vp3B7mPyIRcggoFjxksAGryflMQKgIFI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jsn3ExVR4fx58PggAOxLEtjVtLInckZJLNuicYJdWTm/8k4SC8T6HHVUBLTa8SOq7H1wDw8NZc7bF6Hp99IZz+S7QWC6oV8DBe3Omxzyq0XkuWtIFqsQUMSD/yUvYYUOok7i2Rtmli+WuRoaBE5AQavCi2ZFLen50Ifjk3B1Rvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acmgzmEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BC8C4CEE7;
	Thu, 21 Aug 2025 00:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737738;
	bh=qFrAYlZhVp9vp3B7mPyIRcggoFjxksAGryflMQKgIFI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=acmgzmELeUtqrWjMOKnMlCyRoa4XvfaGp++AimjU8TEalnZOfSMfyDAMCkhQlGs6R
	 wbLEmbnqt2Y9yryalS0cLsq3jtVbNn5w8ETgqKq/dvgg2F5MhTEt/cmLhyz/yQSLPc
	 2GjcsbeQ+K/vthMc2sgJJXjv83iXI+Y8elUUXyw8+GB0/972ftYBZPEzrG4HM7sXGD
	 AKH+A7ikI4RpQFgL3aeEy9DCOU9ojgvuHVOHCsHC/C7Vjo3tr5NBPAaaCuy+asz1l6
	 e8a3ymgmD3M+rY/lmg1g/ds+KA2/mICX+vrvGjFo2fe+0GEAgbiW7bpl6khHO7bW5J
	 j5d8kSHzEveog==
Date: Wed, 20 Aug 2025 17:55:37 -0700
Subject: [PATCH 12/23] fuse: implement large folios for iomap pagecache files
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573709375.17510.10859593872676063736.stgit@frogsfrogsfrogs>
In-Reply-To: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
References: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
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
index 6aa9269b504713..92cc85b5b8a8b5 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -1386,6 +1386,7 @@ static const struct address_space_operations fuse_iomap_aops = {
 static inline void fuse_inode_set_iomap(struct inode *inode)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	unsigned int min_order = 0;
 
 	ASSERT(fuse_has_iomap(inode));
 
@@ -1400,6 +1401,11 @@ static inline void fuse_inode_set_iomap(struct inode *inode)
 	INIT_WORK(&fi->ioend_work, fuse_iomap_end_io);
 	INIT_LIST_HEAD(&fi->ioend_list);
 	spin_lock_init(&fi->ioend_lock);
+
+	if (inode->i_blkbits > PAGE_SHIFT)
+		min_order = inode->i_blkbits - PAGE_SHIFT;
+
+	mapping_set_folio_min_order(inode->i_mapping, min_order);
 	set_bit(FUSE_I_IOMAP, &fi->state);
 }
 


