Return-Path: <linux-fsdevel+bounces-15492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE5888F498
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 02:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCA111C259B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 01:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E2A1C680;
	Thu, 28 Mar 2024 01:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="UTb7fC9/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D116F1BDEB;
	Thu, 28 Mar 2024 01:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589407; cv=none; b=UzBKBObN1UOPzpxJxl8Knh37V0Mxpz7BJmLQkBteUBDZyPGz5W9faNAGLRkC5mhsGvzp8Jq2+CbT1V70pPPdRZE6so2z2ruBxPfJXD2K0EHolh3rQvoW1HI9iT97HLkJYou+HLaszLdz70NLe5kfLgToPVB9nL9I6OKicQ8Cc6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589407; c=relaxed/simple;
	bh=ZI0HOHIWEniz5lMljnVOpSWfT7uBeww4dYxJIYf81m0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBEYtyTcPVvZl9Cqe9OHrvFFK10QPl7LOZYF7dqmYueUshhmPWaFOAqS+glj8nF8+u3H7YEVcue/Ib1aQv6JHPE/7RnWRRXGLq0n3IP1dSuP2W3uQGOo6z/up6xCLmjjkSylUYkl9Kjulg2XI4eIEmUMzup9uWf0GpL+NIwoQdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=UTb7fC9/; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 0ED10827CB;
	Wed, 27 Mar 2024 21:29:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1711589399; bh=ZI0HOHIWEniz5lMljnVOpSWfT7uBeww4dYxJIYf81m0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UTb7fC9/qvo5rNWgjr7i9kFeY8KXIMHzpFIxg6RNs0viBX1qBY4Vdj0lznE/+78Dv
	 sFNZ04aXo9qFvyGC6ntlgTQgCugxFCmETVEhzodBhCUrnx/xrXE0hTLtN+aDvjdaXF
	 jsDvLrncPt0jD4/ow0gjWxaZiP20k1J7Sbiqw6jVq0LaolmSBiPDU21AGxwQHsFGFF
	 Uvootk8xPVeDijpz1/Mc7mryUdlF4NfkMtvU6IPor4UqAZ4cdUiOJXCFpzHCxKiq8u
	 /RB4zQy2iKa95tU1GxE6m4+pcVC9cE/A2Wd4G6Z/yzncdMQhZ/rm+urZWj/BcQvxmF
	 ziU7NQUUQ+3Fg==
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To: Jonathan Corbet <corbet@lwn.net>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	linux-doc@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 3/5] fs: fiemap: add new COMPRESSED extent state
Date: Wed, 27 Mar 2024 21:22:21 -0400
Message-ID: <b739af8d4a3ba0bc5f21d7a3da529656d585c048.1711588701.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1711588701.git.sweettea-kernel@dorminy.me>
References: <cover.1711588701.git.sweettea-kernel@dorminy.me>
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
index 1ecd46608ded..5d5a8fedc953 100644
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


