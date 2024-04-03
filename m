Return-Path: <linux-fsdevel+bounces-15982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0290389667F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 09:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340F01C23FC3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 07:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF516F534;
	Wed,  3 Apr 2024 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="QEytHR5M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336F96EB41;
	Wed,  3 Apr 2024 07:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129594; cv=none; b=BIQLx6Hs5tINHjcRs2yxSkx8mguJ2mC9Zo4pL3rGfGjBjej6WMhxlnBOQqOkrdSvXFiDOBGgPZWnAP+FFOMDcQXQMhXqFir5VmpXGRwN9IE+cmnhCfCV1z5mZCLOiuFCtbGIcm3u4uRaUOhRdxpulGJZhxkXQt/tvt/99uVdSpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129594; c=relaxed/simple;
	bh=GM61hCA7kvAHqNWRBNMS7+3u4Ivx/tDJO9J885fhLWo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NolqJK+z/6n00HXR0U+NTI7sRJFxgjR0EZ4OSbPmC0Cvf2i/daxwG/LG0UZ535W1tEQE0X34+2G33p5GxyuDEQSk8AC5htRi5K2zkOAwj+mKkvkt43HRlsuRhIt1ppgf+4P3T67O6YlmsRk6tKB9VDLZYdmABsj5PBTh1M3YjT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=QEytHR5M; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id EFBB2807E8;
	Wed,  3 Apr 2024 03:33:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1712129592; bh=GM61hCA7kvAHqNWRBNMS7+3u4Ivx/tDJO9J885fhLWo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QEytHR5MrDl3eno9gSXLyQB780SiYAwX/SZdkiJabaBXvfAUR2a/I55tLnkfL+CpI
	 LnJTjdaz247j/qKvYwDUu7CxYvVbE8cVGMf0WclMBiAvAT10XgKz3HSg1Ml/SaYXQa
	 rg2PstwGLpZAeUn5EpHRZFRcrevxmhyfmtSUhkJtQUFuxI0LSJpShGx9d+xVczDG3M
	 x8y3lzEBsciaVn1VquDjmkqOHeXLmOzuRycxl5c2xZombu1LEM3DPEHr6zhFU2SLrO
	 ClzRjg6qvWGUqMZ4Ods46LlfFVGV113DU5DLef8bULDeQuG84gvVvSjV6FppbEL/WO
	 qyopps01ElZSg==
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
Subject: [PATCH v3 04/13] btrfs: fiemap: emit new COMPRESSED state.
Date: Wed,  3 Apr 2024 03:22:45 -0400
Message-ID: <ed3a3c3edbf01b728c20c0718d227ebb79611f47.1712126039.git.sweettea-kernel@dorminy.me>
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
 fs/btrfs/extent_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9e421d99fd5c..e9df670ef7d2 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2706,7 +2706,7 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 			if (range_end <= cache_end)
 				return 0;
 
-			if (!(flags & (FIEMAP_EXTENT_ENCODED | FIEMAP_EXTENT_DELALLOC)))
+			if (!(flags & (FIEMAP_EXTENT_DATA_COMPRESSED | FIEMAP_EXTENT_DELALLOC)))
 				phys += cache_end - offset;
 
 			offset = cache_end;
@@ -3236,7 +3236,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		}
 
 		if (compression != BTRFS_COMPRESS_NONE)
-			flags |= FIEMAP_EXTENT_ENCODED;
+			flags |= FIEMAP_EXTENT_DATA_COMPRESSED;
 
 		if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
 			flags |= FIEMAP_EXTENT_DATA_INLINE;
-- 
2.43.0


