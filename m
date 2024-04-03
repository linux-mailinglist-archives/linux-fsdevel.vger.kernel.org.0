Return-Path: <linux-fsdevel+bounces-15985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC1889668B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 09:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56EF51C24BC7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 07:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6126E74E0C;
	Wed,  3 Apr 2024 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="k9adrlje"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAEF73196;
	Wed,  3 Apr 2024 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129602; cv=none; b=GrB/GBvko3XkOnvjIaeSBdQDvKzwWqyQHUkkygkAs24shNuleAJw8KwNGkybZ4ctLclX4YbEmWsvLFoJJNiYhT6fxgi0k69azLRT2mBQdh5paNU/fJoM+t/dr8CslRiN26bxMfkkFaiEEYrP4C1FNPWhmtHCT4bARqK6Zv5uIuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129602; c=relaxed/simple;
	bh=HBGmAcZ8dQDWLxuQ2gZciGzNPLnws2Iv6wSJvdOp678=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/A3NA+m2X9domVtMoKqiyyrOECQ0d5KcrZrT5WJ85K8OLZC7uAnMbaFegtS1r1sZe/oCEBjozLbP4Rc/3OHRPaFmkoe3ZITvSkrdnSGUia0x4wHVNNtJBQUXtk9+6aAmiw3TqRGRigLN3zm0k4ul3OG3ZL4a/ReyG0+TIm8j58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=k9adrlje; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 80DCC8083D;
	Wed,  3 Apr 2024 03:33:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1712129601; bh=HBGmAcZ8dQDWLxuQ2gZciGzNPLnws2Iv6wSJvdOp678=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=k9adrljeAgmXUEVqR9T38q7UBFhQ7lETYpMXjsStM0XMGS4eG1T8+pjHdefOZtd+9
	 b9sbXDAHqGTeEotki3koqBZ7FT1290d4WlsagN6Z1Jb5RTuog38L7ZzYucpSa1d0f4
	 HrhO5RZg8NIYkyjWEsqcLAnOgMmn4utEi4pAOKEYrQOYjdJh36IxT86WJh3JG4pp1O
	 xCkF4oXlZ89mQ1Ia6EZPk/hwSHK3lgiNW/6Wm5o0rgE/z8dTkDN+l20XOjvG16oIUL
	 bA6z8ZMduHhDyDTpqq0FP2+pz2Eq0VSIBWGUHJdJGV+Y0h8M0aDKiiMOSTHKAOpxIl
	 RTUMic1gQE7cQ==
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
Subject: [PATCH v3 07/13] ext4: fiemap: return correct extent physical length
Date: Wed,  3 Apr 2024 03:22:48 -0400
Message-ID: <20935230b7513031ac497e3afe8446650d20fb1e.1712126039.git.sweettea-kernel@dorminy.me>
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
 fs/ext4/extents.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 2adade3c202a..4874f757e1bd 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2194,7 +2194,7 @@ static int ext4_fill_es_cache_info(struct inode *inode,
 
 	while (block <= end) {
 		next = 0;
-		flags = 0;
+		flags = FIEMAP_EXTENT_HAS_PHYS_LEN;
 		if (!ext4_es_lookup_extent(inode, block, &next, &es))
 			break;
 		if (ext4_es_is_unwritten(&es))
-- 
2.43.0


