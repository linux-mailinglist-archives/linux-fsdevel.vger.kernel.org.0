Return-Path: <linux-fsdevel+bounces-15981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D76889667B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 09:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF06285C45
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 07:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F1F6CDBE;
	Wed,  3 Apr 2024 07:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="I+GHyyn2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06E46CDB4;
	Wed,  3 Apr 2024 07:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129592; cv=none; b=H5oSFhah6DgCHLlAypDGky7mbpAEQi2ydgmyW8mNgMtmXqy9+x8ch4csN4UhCSY8NgXeU7WzK4hjAfX9ndlJHyR7WkmHh95nxBvruPFeNNaZxw6Hv9CL8qHxUe7VC83l+Ox2ozYVsRcPY5vDWzeliGDzWa2fxAEa2k4sDx8L3gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129592; c=relaxed/simple;
	bh=5jSs8nU917GCzbrVP0KXLbUutJOMwr3M87eATF8xiYE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LP4KM6czLJQlTLY9G1ufy+ezGD4RwsvAWv8VpiLzUzEDHa9LBAvl1tFapDbedqmpYBTZMpJEVYWIQWtlZ0AFpo4JbvUorH4NK2cCW+NWb+IaLexoSaTlowTFe9nXUnUpCIbbTsNRwqSTZiCrr5IzTBwk7FSd/xpOY+HXaa051Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=I+GHyyn2; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 41FCF807B2;
	Wed,  3 Apr 2024 03:33:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1712129590; bh=5jSs8nU917GCzbrVP0KXLbUutJOMwr3M87eATF8xiYE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=I+GHyyn2AqhIMgJR35EkQswgG3miJcGyEJxwzXEC6xVoLDp2OlwyCosaNuuCkBCB9
	 e3mF+1V+JntbUuBhT+zndD8j1+FQqYM+m18PAE0UkxIGavLc/UHnvJgLZlPhY3HvRU
	 dAB1kd2oBY1IVAYOFyco0jcQzCh32wCqvmI1yUvKFEjAsgvRdtJEggWdai9Jldcnqz
	 ZrXXRiSB4ad5DztioJsAP3FkLablHBamn3DBFU9p+4wWhQQJptJQTzZ4KPwbj+Bogf
	 R+1oWcA8RUDRvVc2MjugMnBE1zMK/gXCQTxbPRZqZkrJjkesi+ktRnElXyFYmnL7+R
	 VHl1Slf2emloA==
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To: Jonathan Corbet <corbet@lwn.net>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 03/13] fs: fiemap: add new COMPRESSED extent state
Date: Wed,  3 Apr 2024 03:22:44 -0400
Message-ID: <2befe2c13065bdf3ca74cb8b701727940310fd2a.1712126039.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1712126039.git.sweettea-kernel@dorminy.me>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This goes closely with the new physical length field in struct
fiemap_extent, as when physical length is not equal to logical length
the reason is frequently compression.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 Documentation/filesystems/fiemap.rst | 4 ++++
 fs/ioctl.c                           | 3 ++-
 include/uapi/linux/fiemap.h          | 2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/fiemap.rst b/Documentation/filesystems/fiemap.rst
index c060bb83f5d8..16bd7faba5e0 100644
--- a/Documentation/filesystems/fiemap.rst
+++ b/Documentation/filesystems/fiemap.rst
@@ -162,6 +162,10 @@ FIEMAP_EXTENT_DATA_ENCRYPTED
   This will also set FIEMAP_EXTENT_ENCODED
   The data in this extent has been encrypted by the file system.
 
+FIEMAP_EXTENT_DATA_COMPRESSED
+  This will also set FIEMAP_EXTENT_ENCODED
+  The data in this extent is compressed by the file system.
+
 FIEMAP_EXTENT_NOT_ALIGNED
   Extent offsets and length are not guaranteed to be block aligned.
 
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 1830baca532b..b47e2da7ec17 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -126,7 +126,8 @@ int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
 		return 1;
 
 #define SET_UNKNOWN_FLAGS	(FIEMAP_EXTENT_DELALLOC)
-#define SET_NO_UNMOUNTED_IO_FLAGS	(FIEMAP_EXTENT_DATA_ENCRYPTED)
+#define SET_NO_UNMOUNTED_IO_FLAGS	(FIEMAP_EXTENT_DATA_ENCRYPTED|\
+					 FIEMAP_EXTENT_DATA_COMPRESSED)
 #define SET_NOT_ALIGNED_FLAGS	(FIEMAP_EXTENT_DATA_TAIL|FIEMAP_EXTENT_DATA_INLINE)
 
 	if (flags & SET_UNKNOWN_FLAGS)
diff --git a/include/uapi/linux/fiemap.h b/include/uapi/linux/fiemap.h
index 3079159b8e94..ea97e33ddbb3 100644
--- a/include/uapi/linux/fiemap.h
+++ b/include/uapi/linux/fiemap.h
@@ -67,6 +67,8 @@ struct fiemap {
 						    * Sets EXTENT_UNKNOWN. */
 #define FIEMAP_EXTENT_ENCODED		0x00000008 /* Data can not be read
 						    * while fs is unmounted */
+#define FIEMAP_EXTENT_DATA_COMPRESSED	0x00000040 /* Data is compressed by fs.
+						    * Sets EXTENT_ENCODED. */
 #define FIEMAP_EXTENT_DATA_ENCRYPTED	0x00000080 /* Data is encrypted by fs.
 						    * Sets EXTENT_NO_BYPASS. */
 #define FIEMAP_EXTENT_NOT_ALIGNED	0x00000100 /* Extent offsets may not be
-- 
2.43.0


