Return-Path: <linux-fsdevel+bounces-58535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 009C1B2EA60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E561CC1B2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4734A1F463B;
	Thu, 21 Aug 2025 01:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwfvTZZd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A105536CE02;
	Thu, 21 Aug 2025 01:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739021; cv=none; b=ENWnOo1N1SfD+6ObcZU3O1hrJoPRfDubs9t39f+y0kIvbAPaZJ11ryTvq+K+eRCf75LCBkg4SrVkroTfxSrbsEeJpjBJEUu4FPJGlgdtn+seSKJwWmUyi6hh0xqnHpX32PUWuYCeSPvFGXKO8Px7jyVLjTXPmWjRHMaFIh2/NgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739021; c=relaxed/simple;
	bh=E8Sm40z6iBcV8l5Y6pP+DDMx+i2+VaEJSm7PlGQ4J2o=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYbmXwG3vt+8Lx54Mv+xf96gLprkfstiHNbiHpKo2EbrThKIUyLkWzPss2eqRWC+q4acixxd+C//BnDUhunTEXsPaz/iiNYKQcZLgr/vZYnT4XFL94YIdXkUVd6svZbh/iEgnOm5ObEU71p3dl1tZ/TrlmaCi9rwHdZpiYO2U2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwfvTZZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D92C4CEEB;
	Thu, 21 Aug 2025 01:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755739021;
	bh=E8Sm40z6iBcV8l5Y6pP+DDMx+i2+VaEJSm7PlGQ4J2o=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jwfvTZZdt3ciidXjJM+5KTNEDdhW6fpiL/NO8UJUcKlC6nXQH+DOckrwfR7zxC6gz
	 0D9yQIwu10vaLorgmcIQxW/oCS1UJYUCkioc10w8MWRko1V1O0tPd9bi0i9dfNSPRy
	 RY4La2EQlA4RR+YtJporK5t+gGgkKbarjj/48jsroT8vP3mJh5K5M/opD+TaXsO5dp
	 A+6dtFlmaf4+hTonj/VnYidJl54AACengiRQDaOQ+683cI/iPAQnS6VJF3GSnvWHBQ
	 dD3hcf34/uN8TkOAO4mfeFt1ZVa7fmC4zxxVvhl5zRVLEI5eBQq6fS+Exa0yZmEZsY
	 cdKLp+M1PPd4g==
Date: Wed, 20 Aug 2025 18:17:00 -0700
Subject: [PATCH 05/19] fuse2fs: implement directio file reads
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573713820.21970.2115069375852971152.stgit@frogsfrogsfrogs>
In-Reply-To: <175573713645.21970.9783397720493472605.stgit@frogsfrogsfrogs>
References: <175573713645.21970.9783397720493472605.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Implement file reads via iomap.  Currently only directio is supported.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   14 +++++++++++++-
 misc/fuse4fs.c |   14 +++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 8bf0fbcff093a7..1dda9c45cb5089 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -5359,7 +5359,19 @@ static int fuse2fs_iomap_begin_read(struct fuse2fs *ff, ext2_ino_t ino,
 				    uint64_t count, uint32_t opflags,
 				    struct fuse_file_iomap *read)
 {
-	return -ENOSYS;
+	if (!(opflags & FUSE_IOMAP_OP_DIRECT))
+		return -ENOSYS;
+
+	/* fall back to slow path for inline data reads */
+	if (inode->i_flags & EXT4_INLINE_DATA_FL)
+		return -ENOSYS;
+
+	if (inode->i_flags & EXT4_EXTENTS_FL)
+		return fuse2fs_iomap_begin_extent(ff, ino, inode, pos, count,
+						  opflags, read);
+
+	return fuse2fs_iomap_begin_indirect(ff, ino, inode, pos, count,
+					    opflags, read);
 }
 
 static int fuse2fs_iomap_begin_write(struct fuse2fs *ff, ext2_ino_t ino,
diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index 5debaf892b2113..2aa7ab646592e9 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -5767,7 +5767,19 @@ static int fuse4fs_iomap_begin_read(struct fuse4fs *ff, ext2_ino_t ino,
 				    uint64_t count, uint32_t opflags,
 				    struct fuse_file_iomap *read)
 {
-	return -ENOSYS;
+	if (!(opflags & FUSE_IOMAP_OP_DIRECT))
+		return -ENOSYS;
+
+	/* fall back to slow path for inline data reads */
+	if (inode->i_flags & EXT4_INLINE_DATA_FL)
+		return -ENOSYS;
+
+	if (inode->i_flags & EXT4_EXTENTS_FL)
+		return fuse4fs_iomap_begin_extent(ff, ino, inode, pos, count,
+						  opflags, read);
+
+	return fuse4fs_iomap_begin_indirect(ff, ino, inode, pos, count,
+					    opflags, read);
 }
 
 static int fuse4fs_iomap_begin_write(struct fuse4fs *ff, ext2_ino_t ino,


