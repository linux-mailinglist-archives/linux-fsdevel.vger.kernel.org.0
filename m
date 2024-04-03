Return-Path: <linux-fsdevel+bounces-15991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD918966A8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 09:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 099691C22D20
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 07:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09EE86251;
	Wed,  3 Apr 2024 07:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="sDsi6DwW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91BC84A4E;
	Wed,  3 Apr 2024 07:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129625; cv=none; b=fnpUwUAZjLh2f4qcysFQtAsTl+rrxnVxsLe2+S+qocAQM100ITJnoznOt1RkpoShp8ZvA7nSRMr5o5p2ujXF0lpBhOPi9TyoE81EjjaJOS2l8dEmkrydeYzrhcdGHlu7jUJVFkkdC+Ku+0d72cP7hRjJ073cy5wsfrj4vUSs6u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129625; c=relaxed/simple;
	bh=Yn1zFOsTbXIkMwMfnGhDkiIuwvzgn3xDfiaec4KzrE4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFnN5moD2X2KJ6KWgK9GKLIUQtocFnzScLjJoY+QVO9s/IkEUQnPVYt2dChKMvKHtaIUJbju0MRHygN/Z1iGcNVW4SIni4Vhpve/mMEN2y+uciyvHTwlp8tdHHPvsazQvh6dgiBClx2FK6PxCUySUvPaUgkoG6PI6who/Mt7fro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=sDsi6DwW; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 2C4BD809CF;
	Wed,  3 Apr 2024 03:33:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1712129623; bh=Yn1zFOsTbXIkMwMfnGhDkiIuwvzgn3xDfiaec4KzrE4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sDsi6DwW7MGDTQ5P/PQD0Ea0WGP4MIUzVgMSpVt6+MLu6GooeRA15R0TNohgh6qiL
	 gbBK43U0gy8PnlGmzx5AVqVZKXPV2FapzHQ+oZPLgDBg8vwg4O10OxkgIWX5xngwfS
	 PH2OvUg5EIy5Q30YenZnXA3NlcNTx0gX57l5+aw+qpCar+CfK/i0FS+xCo+A9QqgN4
	 6P+NdsGSBq4lgIOk6OA7brNJULtIuyL3MvLZhdqTZi4EiuscId9aGny9zekTgpcN+q
	 HHBbpXQKtnX9bDxNcRm1osXmflca6Y1t/MYnIvBMaK6dyDUapKLFgLTXR2osI5KMTX
	 neuFRfY2pFLuQ==
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
Subject: [PATCH v3 13/13] bcachefs: fiemap: emit new COMPRESSED state
Date: Wed,  3 Apr 2024 03:22:54 -0400
Message-ID: <943938ff75580b210eebf6c885659dd95f029486.1712126039.git.sweettea-kernel@dorminy.me>
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
 fs/bcachefs/fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index d2793bae842d..54f613f977b4 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -921,7 +921,7 @@ static int bch2_fill_extent(struct bch_fs *c,
 				flags2 |= FIEMAP_EXTENT_UNWRITTEN;
 
 			if (p.crc.compression_type) {
-				flags2 |= FIEMAP_EXTENT_ENCODED;
+				flags2 |= FIEMAP_EXTENT_DATA_COMPRESSED;
 				phys_len = p.crc.compressed_size << 9;
 			} else
 				offset += p.crc.offset;
-- 
2.43.0


