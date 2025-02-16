Return-Path: <linux-fsdevel+bounces-41789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA6EA375EA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 17:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6094D7A2D22
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 16:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3591D19D8BC;
	Sun, 16 Feb 2025 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTcz0maW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8333F1EB2A;
	Sun, 16 Feb 2025 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739724139; cv=none; b=dwFrJ42gXTEPOc5widIdTpoblSYD8HK+NcMaZmZpV6Zh2DDvlrzdcox+63IQIrpQt1R/7o9+sdGDvLtkYfpHw7+HkL1fchyHsJ400IhpXLXPBP9wReaRKo9YMpLJ0sa7BcyifV3T01AD9Ah/60uBokBVt9W0HO3PPQqCR/4aYzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739724139; c=relaxed/simple;
	bh=5hnPF+bgOORINojs0uGlAFdWczPtX8nHtq7D6DocPNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nxfthe3u1HNnWkaPbkSedqAFrKOx7TRXjDfSxzlsDnhE3TCjK+dZvhQRo02YMg/qoHHVKHntgW9gtlDQQZTYHZFRO9jqCVNsarvSSF4PIAzoVGBFe1ybd+0A37SFmC5wUfAX3JmtFogb008VQJRSdObWQZA3SbHNSra+zGgUvyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTcz0maW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7FFC4CEE4;
	Sun, 16 Feb 2025 16:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739724138;
	bh=5hnPF+bgOORINojs0uGlAFdWczPtX8nHtq7D6DocPNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MTcz0maWsdhmg3AJNIGRxpTATB9dR2/+o0onL8Vhkr6ODd7inNBTejcchP4XBh5vp
	 J+f89A0Oob2jT/Wj3dS2WWMXtDH54mji72Om/Cv1Pswxl31DTW8a2CrpxTonb5Gh9R
	 zhgavxGoujJkPJYwJHYkcaO7fwCakg2c4wLfq9XaVuoGqMWNC3M8s54twRwt5EhV/l
	 wBoov0RBekvhC7mP1AWJwE94/SbX5kTIjMFEs3dRv9xTFzjszj89EgdQnQRDHYcNAj
	 ATR46WIEHeagviEbuQvRdjlDg8D4a8xHhJwL5BFuvtwGnLZwzVUyQubYLyiGV0PyY1
	 Njw2wK2ZRKxGA==
Received: by pali.im (Postfix)
	id CE943A7F; Sun, 16 Feb 2025 17:42:05 +0100 (CET)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/4] fs: Add FS_XFLAG_COMPRESSED & FS_XFLAG_ENCRYPTED for FS_IOC_FS[GS]ETXATTR API
Date: Sun, 16 Feb 2025 17:40:26 +0100
Message-Id: <20250216164029.20673-2-pali@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250216164029.20673-1-pali@kernel.org>
References: <20250216164029.20673-1-pali@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This allows to get or set FS_COMPR_FL and FS_ENCRYPT_FL bits via FS_IOC_FSGETXATTR/FS_IOC_FSSETXATTR API.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/ioctl.c               | 8 ++++++++
 include/linux/fileattr.h | 4 ++--
 include/uapi/linux/fs.h  | 2 ++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 638a36be31c1..9f3609b50779 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -480,6 +480,10 @@ void fileattr_fill_xflags(struct fileattr *fa, u32 xflags)
 		fa->flags |= FS_DAX_FL;
 	if (fa->fsx_xflags & FS_XFLAG_PROJINHERIT)
 		fa->flags |= FS_PROJINHERIT_FL;
+	if (fa->fsx_xflags & FS_XFLAG_COMPRESSED)
+		fa->flags |= FS_COMPR_FL;
+	if (fa->fsx_xflags & FS_XFLAG_ENCRYPTED)
+		fa->flags |= FS_ENCRYPT_FL;
 }
 EXPORT_SYMBOL(fileattr_fill_xflags);
 
@@ -496,6 +500,8 @@ void fileattr_fill_flags(struct fileattr *fa, u32 flags)
 	memset(fa, 0, sizeof(*fa));
 	fa->flags_valid = true;
 	fa->flags = flags;
+	if (fa->flags & FS_COMPR_FL)
+		fa->fsx_xflags |= FS_XFLAG_COMPRESSED;
 	if (fa->flags & FS_SYNC_FL)
 		fa->fsx_xflags |= FS_XFLAG_SYNC;
 	if (fa->flags & FS_IMMUTABLE_FL)
@@ -506,6 +512,8 @@ void fileattr_fill_flags(struct fileattr *fa, u32 flags)
 		fa->fsx_xflags |= FS_XFLAG_NODUMP;
 	if (fa->flags & FS_NOATIME_FL)
 		fa->fsx_xflags |= FS_XFLAG_NOATIME;
+	if (fa->flags & FS_ENCRYPT_FL)
+		fa->fsx_xflags |= FS_XFLAG_ENCRYPTED;
 	if (fa->flags & FS_DAX_FL)
 		fa->fsx_xflags |= FS_XFLAG_DAX;
 	if (fa->flags & FS_PROJINHERIT_FL)
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index 47c05a9851d0..c297e6151703 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -7,12 +7,12 @@
 #define FS_COMMON_FL \
 	(FS_SYNC_FL | FS_IMMUTABLE_FL | FS_APPEND_FL | \
 	 FS_NODUMP_FL |	FS_NOATIME_FL | FS_DAX_FL | \
-	 FS_PROJINHERIT_FL)
+	 FS_PROJINHERIT_FL | FS_COMPR_FL | FS_ENCRYPT_FL)
 
 #define FS_XFLAG_COMMON \
 	(FS_XFLAG_SYNC | FS_XFLAG_IMMUTABLE | FS_XFLAG_APPEND | \
 	 FS_XFLAG_NODUMP | FS_XFLAG_NOATIME | FS_XFLAG_DAX | \
-	 FS_XFLAG_PROJINHERIT)
+	 FS_XFLAG_PROJINHERIT | FS_XFLAG_COMPRESSED | FS_XFLAG_ENCRYPTED)
 
 /*
  * Merged interface for miscellaneous file attributes.  'flags' originates from
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 2bbe00cf1248..367bc5289c47 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -167,6 +167,8 @@ struct fsxattr {
 #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
 #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
 #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
+#define FS_XFLAG_COMPRESSED	0x00020000	/* compressed file */
+#define FS_XFLAG_ENCRYPTED	0x00040000	/* encrypted file */
 #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
 
 /* the read-only stuff doesn't really belong here, but any other place is
-- 
2.20.1


