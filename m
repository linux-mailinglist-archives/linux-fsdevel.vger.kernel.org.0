Return-Path: <linux-fsdevel+bounces-15494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6052888F49E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 02:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91EBF1C2AE71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 01:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D822B9C0;
	Thu, 28 Mar 2024 01:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="cdrXApSI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53126208C4;
	Thu, 28 Mar 2024 01:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589409; cv=none; b=StEWewBroyVMKkEKEDuJQOFdd1espX8XSnSWX3QD5xsZkBuPCAbxc22+hFUn+xLbpplQh0oRh+1u6UcMP1lHcoQ3yB5NvB13MAo38Qh7Yxa0Niq1LjjPo/QYfcBwBVQGgUxuiXj5ZB8GCpP4ezsGl8rwDyRpjPL4eYQQmNbtaQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589409; c=relaxed/simple;
	bh=loT+Qbkfl5McJxnyU7woeHPNNkRvQzofj0KPUTRi5UY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqFCw3E5Kmuq32khG83SZ0G6mhbKI4K3xUmp+83coxaRaLytmkeghjkqAMWSQrQSvv0NTNAr7z/aCuPPP1QDde/WqrtQP7lOKb56XUc1MU3ZAlrRSW4poz0TubL4d2+dyq3jL1QyZ9fs7IuRK+cttqaPO+XIz3pMsPKb+p3rqAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=cdrXApSI; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id D7D7E827CC;
	Wed, 27 Mar 2024 21:29:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1711589400; bh=loT+Qbkfl5McJxnyU7woeHPNNkRvQzofj0KPUTRi5UY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cdrXApSI+PHaSsqg3GVj9yKXoA4pUvPWDtMbx2f3rUZcY6n1bGie9rOkwwn2IfaVl
	 ZmwL8Doe87QIA64Oql3bw9YrvD8C6qhkacGBfhaoM2e0nk8SEZD3LVhegSMYA0qPLt
	 F0tITSX+tkLA6FX4kIr/7ewdgTik3A9D516o1AmCePYx5V6+BMIGjjrZtaLxdVCd4L
	 srQlDeCeG/Tyt1HBQBEkC3E+HP8zsOcCUYhMBazufY7eRPs26i5XW+BP+s+UbIzkm9
	 HiPLzwgT9gQ+2IBt7QBKJKoh4uzVnL7Nzxlaan/P/kd7etJ08wKFpN/3stNLaIJF2T
	 /3gHW9HWuzp5g==
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
Subject: [PATCH v2 4/5] btrfs: fiemap: emit new COMPRESSED fiemap state.
Date: Wed, 27 Mar 2024 21:22:22 -0400
Message-ID: <6910f7a6f5f27383ebeda4ffd6467a986b2a5c5e.1711588701.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1711588701.git.sweettea-kernel@dorminy.me>
References: <cover.1711588701.git.sweettea-kernel@dorminy.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that fiemap has a compressed state flag, emit it on compressed
extents.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/extent_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8503ee8ef897..30fcbb9393fe 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2656,7 +2656,7 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 			if (range_end <= cache_end)
 				return 0;
 
-			if (!(flags & (FIEMAP_EXTENT_ENCODED | FIEMAP_EXTENT_DELALLOC)))
+			if (!(flags & (FIEMAP_EXTENT_DATA_COMPRESSED | FIEMAP_EXTENT_DELALLOC)))
 				phys += cache_end - offset;
 
 			offset = cache_end;
@@ -3186,7 +3186,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		}
 
 		if (compression != BTRFS_COMPRESS_NONE)
-			flags |= FIEMAP_EXTENT_ENCODED;
+			flags |= FIEMAP_EXTENT_DATA_COMPRESSED;
 
 		if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
 			flags |= FIEMAP_EXTENT_DATA_INLINE;
-- 
2.43.0


