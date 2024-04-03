Return-Path: <linux-fsdevel+bounces-15989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3C589669F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 09:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9C81C25707
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 07:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F6E83A18;
	Wed,  3 Apr 2024 07:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="XAboOI1g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D24839E1;
	Wed,  3 Apr 2024 07:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129622; cv=none; b=tJycywj2ewbGgualgewBQoz8qcJwQNA6JM7QyGQH/ih0dWrFeSj4WlrphZvN7uoPJBVvT4lytlBCiiW9/vEj3ACQcGUkTZxAXtpANxSoZnANMsirkXp2DG0CmsbiSnIERuJAkyMK8tIS2p+qD6gKwc4mBTTK7catlvmOAUorVxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129622; c=relaxed/simple;
	bh=SgpqdEQktNmIE/si/SsUXivp3OLO9RykBmr/owEiMwk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hw9tBf6Kc3CCsShXEAa/jfToCXroZTFCJ1rASlmsGY3nMeRsKugIzbdCSS5BaG9O+oVS17ZY4SmOzHphZcRZZWZCPObqIhl/qFBKYmnHDV0qvwtWHRFvVV5m2Qvo1qShm/znzWqQQZAckHiUnjvacyIBnzaOb3V2G2PKkIA0wLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=XAboOI1g; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id CBFF38083F;
	Wed,  3 Apr 2024 03:33:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1712129620; bh=SgpqdEQktNmIE/si/SsUXivp3OLO9RykBmr/owEiMwk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XAboOI1gOEYEeFHrK1IrQoakMcUXsIMd5sSfqTDBehMhEAI8iLj2M4cvGuZWOnlea
	 sptYc4MV8Ozdb9aTADpJGN+8wTnZ7a4nquwTvUU7Fg8MmCD8svm0CoyTyh7cz/SBD+
	 ZMFxSNY4lqBJ9+dz+mPFPmrNmB+z57J2Ezal//nHLbJPn2kpBB/DeRdnynt73/ONre
	 w1nx6Q9inAxG9UN8ga9ww6DJNwFqfSLAGdGXdXScTmCspAGRxQd722JIdIuqf41v1U
	 vpPKduXjNxy+o5h6VMKoOcFf5LJdNmM7bXsHLaUDtdElsmkXjDqye/eAoNu2dZVkZX
	 f6UzUKP6VJHVQ==
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
Subject: [PATCH v3 11/13] bcachefs: fiemap: return correct extent physical length
Date: Wed,  3 Apr 2024 03:22:52 -0400
Message-ID: <b9b795987a485afa0fdb8f0decc09405691d9320.1712126039.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1712126039.git.sweettea-kernel@dorminy.me>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/bcachefs/fs.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index f830578a9cd1..d2793bae842d 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -913,15 +913,17 @@ static int bch2_fill_extent(struct bch_fs *c,
 			flags |= FIEMAP_EXTENT_SHARED;
 
 		bkey_for_each_ptr_decode(k.k, ptrs, p, entry) {
-			int flags2 = 0;
+			int flags2 = FIEMAP_EXTENT_HAS_PHYS_LEN;
+			u64 phys_len = k.k->size << 9;
 			u64 offset = p.ptr.offset;
 
 			if (p.ptr.unwritten)
 				flags2 |= FIEMAP_EXTENT_UNWRITTEN;
 
-			if (p.crc.compression_type)
+			if (p.crc.compression_type) {
 				flags2 |= FIEMAP_EXTENT_ENCODED;
-			else
+				phys_len = p.crc.compressed_size << 9;
+			} else
 				offset += p.crc.offset;
 
 			if ((offset & (block_sectors(c) - 1)) ||
@@ -931,7 +933,7 @@ static int bch2_fill_extent(struct bch_fs *c,
 			ret = fiemap_fill_next_extent(info,
 						bkey_start_offset(k.k) << 9,
 						offset << 9,
-						k.k->size << 9, 0,
+						k.k->size << 9, phys_len,
 						flags|flags2);
 			if (ret)
 				return ret;
@@ -941,14 +943,18 @@ static int bch2_fill_extent(struct bch_fs *c,
 	} else if (bkey_extent_is_inline_data(k.k)) {
 		return fiemap_fill_next_extent(info,
 					       bkey_start_offset(k.k) << 9,
-					       0, k.k->size << 9, 0,
+					       0, k.k->size << 9,
+					       bkey_inline_data_bytes(k.k),
 					       flags|
+					       FIEMAP_EXTENT_HAS_PHYS_LEN|
 					       FIEMAP_EXTENT_DATA_INLINE);
 	} else if (k.k->type == KEY_TYPE_reservation) {
 		return fiemap_fill_next_extent(info,
 					       bkey_start_offset(k.k) << 9,
-					       0, k.k->size << 9, 0,
+					       0, k.k->size << 9,
+					       k.k->size << 9,
 					       flags|
+					       FIEMAP_EXTENT_HAS_PHYS_LEN|
 					       FIEMAP_EXTENT_DELALLOC|
 					       FIEMAP_EXTENT_UNWRITTEN);
 	} else {
-- 
2.43.0


