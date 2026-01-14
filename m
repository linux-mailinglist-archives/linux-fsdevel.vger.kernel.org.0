Return-Path: <linux-fsdevel+bounces-73739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8436AD1F7A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 152EA3074286
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E30F392C4D;
	Wed, 14 Jan 2026 14:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTHCGKF9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EC12DECDF;
	Wed, 14 Jan 2026 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400964; cv=none; b=F05P1NWec8f0P+kZkl3kIQu5qTEehwBUCKsIYqu2zS7rll0To99+wAlkN88HSePGBt2inmDE4KBMHTBKMxW9F6vOT0b4XRl7M7z7E7oAzJqqQLscPS2+CznRk722RzwLWCTMbkyWq2jCkGpxtEIKUMUaGflZCB5gKab7yQwPjnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400964; c=relaxed/simple;
	bh=a4XIY9jP7DHeDPNkP9IdkH0ovCnkdRclS4Bjo7NcH8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0k76BIRh6qzdUGM91oSjDGGMkf+RgNtoHtJCgRqSEjMNF1uDiX23Wboy47Wh5bzG4iToXr2ajTb/Ara64In7einZvHWlK4pLy3FexmNgWoOadiiuo7BDiF+p/7Q4zNvJaVFuvE5uH5cYfOOQ+QunAkTFA+gxDL0i0qPZaGcklQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTHCGKF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE446C16AAE;
	Wed, 14 Jan 2026 14:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768400964;
	bh=a4XIY9jP7DHeDPNkP9IdkH0ovCnkdRclS4Bjo7NcH8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qTHCGKF9yeARZQmE1ZqRCeP5MmjvZ5sRY0tGJnIVmEWqFyWXgoJBAWcWzyop5WBB2
	 ZKqzBRi/x5pLGgOc09aSTy3aWIg1nYfuAxNRtPKoOnbLz/5f+ZGKaGOy+8oC2yJHJH
	 TReKEPRfj7SghmfbTemEzCKLsdmCAH92kp9qWH2XamHhH0VLyICT1m7KPHfY7KrCTf
	 RMCvsBxfHyU6fvKOF5zsonVKTu7iSGc5SYuWkEvQd4aDUyGakoBp61NeaLcYow69PX
	 UylU/jxqN0XKtHjGzYRWWzSF0NlI0/XxIOazsl/2cXExIf6SXkD6jvktRYeG7gBHF+
	 hGmOt8auD3A3Q==
From: Chuck Lever <cel@kernel.org>
To: vira@web.codeaurora.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: <linux-fsdevel@vger.kernel.org>,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	<linux-nfs@vger.kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	hirofumi@mail.parknet.co.jp,
	linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com,
	almaz.alexandrovich@paragon-software.com,
	slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	cem@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	trondmy@kernel.org,
	anna@kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	hansg@kernel.org,
	senozhatsky@chromium.org,
	Chuck Lever <chuck.lever@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v4 08/16] xfs: Report case sensitivity in fileattr_get
Date: Wed, 14 Jan 2026 09:28:51 -0500
Message-ID: <20260114142900.3945054-9-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114142900.3945054-1-cel@kernel.org>
References: <20260114142900.3945054-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Upper layers such as NFSD need to query whether a filesystem is
case-sensitive. Populate the case_insensitive and case_preserving
fields in xfs_fileattr_get(). XFS always preserves case. XFS is
case-sensitive by default, but supports ASCII case-insensitive
lookups when formatted with the ASCIICI feature flag.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/xfs/xfs_ioctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 59eaad774371..e8061fe109e9 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -516,6 +516,12 @@ xfs_fileattr_get(
 	xfs_fill_fsxattr(ip, XFS_DATA_FORK, fa);
 	xfs_iunlock(ip, XFS_ILOCK_SHARED);
 
+	/*
+	 * XFS preserves case (the default). It is case-sensitive by
+	 * default, but can be formatted with ASCII case-insensitive
+	 * mode enabled.
+	 */
+	fa->case_insensitive = xfs_has_asciici(ip->i_mount);
 	return 0;
 }
 
-- 
2.52.0


