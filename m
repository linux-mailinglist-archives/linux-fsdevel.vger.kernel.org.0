Return-Path: <linux-fsdevel+bounces-16185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2E6899CA4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 14:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1954A284FC4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 12:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A345816DEA6;
	Fri,  5 Apr 2024 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TKDOJxOE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FEE16D9AC;
	Fri,  5 Apr 2024 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712319251; cv=none; b=m3BKTt7iwfxmiAZgEYrgMtj7hlIqmKFoDnVCXUgt9stjcruqLmC+gWNzsXu5JtRHfYhnPuG6dmcnZ8+xpb6GWZ84LCU4/2JKW802brbSvRIqk65AMbx5d1ie+VMchaFRInpVCH4KzP9LNo9brRcYNmz+8xck/TT2sMHpD/xqN+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712319251; c=relaxed/simple;
	bh=3qqbmy6OIcOoO07cO28FmCqjE206p+74Pkl9CCe0L8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qqm5Wn9ew1LlNKUEVyBKNbAjpx1olkG/T7JvXZhPIGtc4GH7L/a+9PRlBHVNptIU2JF8UnRHOVmwh7JXWAFWi/uz0eWf9TxsGzqGvuUyJW17BT6kIee6fMuH3Qr6aHWBSPliC+Y0F15Mp38hXFnESpD6R6TdNHXIW5c/NXBgTE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TKDOJxOE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712319248;
	bh=3qqbmy6OIcOoO07cO28FmCqjE206p+74Pkl9CCe0L8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TKDOJxOER7MirF21hVhlJQygRmK3/cJqX67xIv56OiHAy+8ouFLN8Y6MoZIeZQr5U
	 gKEX2b9K15sZy9+GBZ5VAAd6GKpxvEtgt1iY8IO47IB2Gze+5MDekZvgpveB2GyG6x
	 LNGantlVyvkzvkODN1PXwCuEDdlHax/3eCJLn5OT2wVHpWe16Af4a9/Pjgistv+my2
	 L99lBBpVAW/4p4xOhSqzNSEuA9P9vS/m2fnRgFtI5a8OBNhBOQPz8DCeITHkwotFTs
	 TUOc9wHNQNQY7H1FvAo3RaxedEuZxNziGZH5t4GHqnaZMGt2KjAK7ynt+aT8NiIv1O
	 3evyYq2Hw6Q9w==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 289F53782134;
	Fri,  5 Apr 2024 12:14:07 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	eugen.hristev@collabora.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	krisman@suse.de,
	ebiggers@kernel.org,
	Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v16 6/9] ext4: Log error when lookup of encoded dentry fails
Date: Fri,  5 Apr 2024 15:13:29 +0300
Message-Id: <20240405121332.689228-7-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405121332.689228-1-eugen.hristev@collabora.com>
References: <20240405121332.689228-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gabriel Krisman Bertazi <krisman@collabora.com>

If the volume is in strict mode, ext4_ci_compare can report a broken
encoding name.  This will not trigger on a bad lookup, which is caught
earlier, only if the actual disk name is bad.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 fs/ext4/namei.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 2d0ee232fbe7..3268cf45d9db 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1477,6 +1477,9 @@ static bool ext4_match(struct inode *parent,
 			 * only case where it happens is on a disk
 			 * corruption or ENOMEM.
 			 */
+			if (ret == -EINVAL)
+				EXT4_ERROR_INODE(parent,
+					"Directory contains filename that is invalid UTF-8");
 			return false;
 		}
 		return ret;
-- 
2.34.1


