Return-Path: <linux-fsdevel+bounces-77413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI3RFhTjlGmjIgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 22:52:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C000C1511A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 22:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E41E6308AB17
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 21:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D2E2FCC04;
	Tue, 17 Feb 2026 21:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/Ai+S96"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE42C2F5A36;
	Tue, 17 Feb 2026 21:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771364889; cv=none; b=qsYUazmHaX4rTs3WeefUmX3miNRNLSKQtoCwvaPFWCwCqDY1awViPPyMuVTdqTbV6pPsZ/xUyY4TQg7xCDX9GwM0mkwqaRR1ZuQVFl0zUT8rqLi68oq7zr6lEKJK2nLt2kVI6dw4NNlv9ZEmnEJVwxINk61tw0jXUtRad5o+ckI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771364889; c=relaxed/simple;
	bh=fYGZPGOvWWHJ29HyCpYpZWY5Spu1N7gwM+/38CEuEEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6By33NpL3LSSSUCU4RhdNkLGweIHYpG6lMZeynACxdcv6XAXtT3tRspX98Q5m+RWLchm/KQhOmEB1MgY8niF3+R6zEfcX7m/SDqWXuMQs1ceXYPI1uELpEDYkcDZFH2xmzfgPl0gkJTrl6zcyUOnG/xvUwwUBq2TLE71Uoc0fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/Ai+S96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEA7C2BC87;
	Tue, 17 Feb 2026 21:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771364888;
	bh=fYGZPGOvWWHJ29HyCpYpZWY5Spu1N7gwM+/38CEuEEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S/Ai+S96uG/Gfz7HATywK5Hdnt8vlyZtWhDrlsWq4+HHhqloU2FqnQCAUunQ+j2+S
	 CDkoGtknNKSJ9d7s0NeTIWe1e52obwCxwbH7zpZ+yKOspWldxxhnElIJDNkXxvKWov
	 XYuXCW1yVlmz2jI2JL0FOF6EYG4ieCR7GpxwWJU+XbE5n6tQvUEibFHmHgxySgNUPT
	 HkjR5pf3qNY/RNRescro07eKCGuHm2wqmybZ2Mz2dDVIFTfZ4dhIP5PU4aVMzh/+xu
	 W1azjC78aQfLp7Dp57Alvp0WlZ7Pk5Pp7qQx8VlUKR8uNTgdWVRSVm6CzOjjpYQ+uD
	 Axwj1rjBey6Aw==
From: Chuck Lever <cel@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-api@vger.kernel.org,
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
Subject: [PATCH v8 09/17] xfs: Report case sensitivity in fileattr_get
Date: Tue, 17 Feb 2026 16:47:33 -0500
Message-ID: <20260217214741.1928576-10-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217214741.1928576-1-cel@kernel.org>
References: <20260217214741.1928576-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77413-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C000C1511A2
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Upper layers such as NFSD need to query whether a filesystem is
case-sensitive. Report case sensitivity via the FS_XFLAG_CASEFOLD
flag in xfs_fileattr_get(). XFS always preserves case. XFS is
case-sensitive by default, but supports ASCII case-insensitive
lookups when formatted with the ASCIICI feature flag.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/xfs/xfs_ioctl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 369555275140..41c6b4cd8ac2 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -518,6 +518,13 @@ xfs_fileattr_get(
 	xfs_fill_fsxattr(ip, XFS_DATA_FORK, fa);
 	xfs_iunlock(ip, XFS_ILOCK_SHARED);
 
+	/*
+	 * FS_XFLAG_CASEFOLD indicates case-insensitive lookups with
+	 * case preservation. This matches ASCIICI behavior: lookups
+	 * fold ASCII case while filenames remain stored verbatim.
+	 */
+	if (xfs_has_asciici(ip->i_mount))
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
 	return 0;
 }
 
-- 
2.53.0


