Return-Path: <linux-fsdevel+bounces-73291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED25FD148E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 18:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED5C9303370A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 17:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3071E3815F5;
	Mon, 12 Jan 2026 17:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cooTinHb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D8A3612F8;
	Mon, 12 Jan 2026 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240017; cv=none; b=G6Fv8+E4BymLybmOq2Y0C9NBhzscuCLkEVnXMPn3WoB1pzDUvTiI+NieTF7f1xq1qY6OheAHs/vM64nMXbyMikgRgFQjJyg7JFGduvTJV/iZsOENpAJldEllV9T3h4jL55Exy5b1rGlnrpA1o5dCffHpUYnlP++lhtq7v5ToZdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240017; c=relaxed/simple;
	bh=Hnozn2sdgRnA1HMevRa1Ee51oWOT/FX5helgZbvUUkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gsdu/0kclqFKu4xNkN+exMTfIw41/cNw4+xcXrN7JRFqm8UWk1V3BulOsnFw6gxHJbsgVMt2ld0SAoxWRWTLo73ZHODjhnO7wP27fUSRJuAPAn8BgYFya4ZL9uj1FtF2AH57FgP6wvkGby4UXUuDBdEKEHh2RJtxkJAWzGQD/OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cooTinHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A8DC2BC86;
	Mon, 12 Jan 2026 17:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768240017;
	bh=Hnozn2sdgRnA1HMevRa1Ee51oWOT/FX5helgZbvUUkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cooTinHbxWXarz9+KKRqJTJHeempyiqEr7dgTG7ICeqILB1L8ta73AgD8r1FJX3My
	 0uU3yq1Sjl7lMJLniF569jzDeGTCMry+zDzMKrjoAZArtAwzuhMdsTjZ7i4Sma/B5M
	 r9lv13Et4CTRKMQeeIPQ7V8N2lWIjaxCEvRM+sB5eRCCnw5Fduh7V1R2hc4MDCP1Kn
	 d8Y/8j0P1atfbaRMRuROKx/Jai/5NLBdgxt+IuRqP9YZ7wL4aYRJbc6JSx0jywXGFc
	 wbgpvWtFPuZ5STOHPOFbmGkubVXS7dNbDw27N3ZBAZaeYtjEVo92DPwAylHp2JwxZj
	 IadzAWUrRfZ2Q==
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
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 08/16] xfs: Report case sensitivity in fileattr_get
Date: Mon, 12 Jan 2026 12:46:21 -0500
Message-ID: <20260112174629.3729358-9-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112174629.3729358-1-cel@kernel.org>
References: <20260112174629.3729358-1-cel@kernel.org>
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/xfs/xfs_ioctl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 59eaad774371..97314fcb7732 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -516,6 +516,13 @@ xfs_fileattr_get(
 	xfs_fill_fsxattr(ip, XFS_DATA_FORK, fa);
 	xfs_iunlock(ip, XFS_ILOCK_SHARED);
 
+	/*
+	 * XFS is case-sensitive by default, but can be formatted with
+	 * ASCII case-insensitive mode enabled.
+	 */
+	fa->case_insensitive = xfs_has_asciici(ip->i_mount);
+	fa->case_preserving = true;
+
 	return 0;
 }
 
-- 
2.52.0


