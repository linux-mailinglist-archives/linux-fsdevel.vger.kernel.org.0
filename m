Return-Path: <linux-fsdevel+bounces-14871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2C1880D98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 09:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49EB5281E2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 08:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEC9405EC;
	Wed, 20 Mar 2024 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IkkfhwIe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B063FBAC;
	Wed, 20 Mar 2024 08:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710924411; cv=none; b=pixk0gyg4KWj3FV1jp5/7KmeK3/L67LPMoppDnaloxUe3lqr/eZsiYR9kL7KjRiEWsza3NgBtedlsAPcCG+WqzqzxiKf4zvfPDuAFyQVPztjoysjYtKedfGrE7DKX/SaCLL7Abaftfm0SjG68eDx7wzknVH/noPsGj2Oqy4UBiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710924411; c=relaxed/simple;
	bh=3qqbmy6OIcOoO07cO28FmCqjE206p+74Pkl9CCe0L8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KjJhseK9G54z+G/cAfg5wJNiTSP2yVIOcT8R+C1lV1jSXoWhq5T9Fa3vU990D+WB3IDf8fIUDtYuKxamu3b0Ur2DwUow3lot7XTqhUNa2IHfgHVJwyvMLUqf917wgQd91smG9WQJJZDatKHwID7hKqfUs9xQXbIl/tDiczw7jL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IkkfhwIe; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710924408;
	bh=3qqbmy6OIcOoO07cO28FmCqjE206p+74Pkl9CCe0L8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IkkfhwIeSaNG/P79So6eYu9Puo24dBKVe3t707OodSS65lR0wEVnqdVXdj0oRRKfD
	 gLoVSBT8nKKqBAEH/o5ps7vhhgU9p5wxWroVsA37UgN9QRCoYnljzimLhUfEY7AYUw
	 PO9HQw8PjKRwNCqXA5gsYz25lmTIMzr9Z79mTJnGSbA5ntynZxuQgSzcRc/Vdug8B1
	 8mEHMQafqWZUXdtOGKl890JB2nG3bCd23x33g7jkf4WInrU7HTo2qed8F3WAOE4KvC
	 eLKmS6TMfGKGaoTP2huPQ4nXHZpQl3GabtT4oGHpSWNrgEBPU/MvbFFMRP3Qs6YM9Y
	 5uKCOejh6xHFA==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 90BED37813C4;
	Wed, 20 Mar 2024 08:46:45 +0000 (UTC)
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
	Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v14 6/9] ext4: Log error when lookup of encoded dentry fails
Date: Wed, 20 Mar 2024 10:46:19 +0200
Message-Id: <20240320084622.46643-7-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320084622.46643-1-eugen.hristev@collabora.com>
References: <20240320084622.46643-1-eugen.hristev@collabora.com>
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


