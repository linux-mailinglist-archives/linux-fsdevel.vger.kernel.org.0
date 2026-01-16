Return-Path: <linux-fsdevel+bounces-74140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45584D32EDF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83BE230D2D9A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 14:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02324395D80;
	Fri, 16 Jan 2026 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eT+fSCfj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B60F288C25;
	Fri, 16 Jan 2026 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574800; cv=none; b=Qq60gQimFynJzFg3zz7dhHUO7AeDl0dFFg6I0L9L8t8lNhcQd3+eh3UCtYyZbls+1Ju1q+J7TrOp4qULRVkw3NhY4PYHgtv8jFO7Bvi0SW4EkFvqWZUz/8w5Uf/8aJ4zuK/ER7MnUX2pzgGoAvrpLzTjhnN6K570HAA191+lObk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574800; c=relaxed/simple;
	bh=a4XIY9jP7DHeDPNkP9IdkH0ovCnkdRclS4Bjo7NcH8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otSquW6HBNHBQE3tv7KYgLRZAAu6kf5jc2VJ3T8rosLkgbwndG+xchAZDnXAdy7SBf2srJpgYB7S/g/hpnutLFz7U4+a4avKPJ9zl2zVaRECpEvp+4HAqVdnKUuJGoRMqXuqnmNndZUjCXwsvilznI6pKd4mSaGcTmYQnuhbZng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eT+fSCfj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE203C16AAE;
	Fri, 16 Jan 2026 14:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768574800;
	bh=a4XIY9jP7DHeDPNkP9IdkH0ovCnkdRclS4Bjo7NcH8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eT+fSCfj1ONJ1dIX3U7fmwABY2CJrjeydjvyUxh/+krcxfK3DP3hLu7v4lruSEWve
	 tXmbsOxrEMAn7k25tvFhwYAX+ocpVH2Gs6+Vl+uTakkhtGdhm7nAl0Fc5pAdkQVars
	 4HmgVErySSYlDtf/ih07CUMI4++aEfA/FpAWuJ3B+IyuWq+DyOK5/ENvCEG8BnwgY/
	 GjLPNvNQTJQsbjbb4IPvrLM/KeOXIYaUhq6otMhdrLKmK07KAqlE7/MXneAEpYRofD
	 ZZVlKuq2aJXeSSNxZ0ZndOErH7EULcGRDSu4ex0LnzoIqsuUHX9rt12Z9VPjLfX97H
	 UDyo1lXtRDWVA==
From: Chuck Lever <cel@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
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
Subject: [PATCH v5 08/16] xfs: Report case sensitivity in fileattr_get
Date: Fri, 16 Jan 2026 09:46:07 -0500
Message-ID: <20260116144616.2098618-9-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116144616.2098618-1-cel@kernel.org>
References: <20260116144616.2098618-1-cel@kernel.org>
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


