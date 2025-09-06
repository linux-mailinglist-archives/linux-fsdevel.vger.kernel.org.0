Return-Path: <linux-fsdevel+bounces-60429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A59B46A9D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 741B97BD03B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 09:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EC12D0615;
	Sat,  6 Sep 2025 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ut5X6Um8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F90298CDC
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149903; cv=none; b=nr1yRzLmtsNSklsphWbO6OD4iavIpXrp0KxcnlTzY9Dhs0X6vLA/u+6rNnt2cae+zBkONhHFzwglWWSVykLE7wMgYWlfgKwG+tU1PFfHZPdf9YZNhyLrcLgpb17nLEEehmj19wBtmA2VCuNbIxv4nn1Z7qqOOnxPBLuIqZNn5vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149903; c=relaxed/simple;
	bh=ae5rVz6Ey/9TAcTVv8dkuf/pnwkWRqr7eHu+JBMmOhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVEBSZy3DE0VLQc0KmKfacjKjR/EQAiUZRFMQwtqTow8DXA3jNXuGICoOGP6dtiXytqvVxpq6tg8/aqI7LzRN+UKPSlLNDB1TRrWVhJfj1HkQHs8ormUplQh4oFA5fcrZoWgnpOyjh8ZYLY3mVargGpMbCUZSEJGwzl5viu/DKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ut5X6Um8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=oJ0PFfTXUZUMByKR87Z8MGMYEIlUrklxUev4/5vpQZU=; b=Ut5X6Um8DJK2H9onnsGAtZoxfl
	WiclaIpWO/m1rfr9GLTM+8+PF0frZHSWZ/gfsYy5T/twe3jRjebu7XyukaFQIeG7QJf7HU+0PHJ5U
	3Rl60ZC4b3QHFhpTcXUE5A+5fJA17W81CcC0SZXAB/CJCqKNXTFRRrRG0g60p+ifnC4OqIkfZ41SX
	t3BUoA6DxEogjaS/U8ypWPWQawMSJydkdWaT266MzvqZOycVPsUK0Ovwd4boDIT/0jXxCR8+EbUd8
	ScWRL2eMCtPbDhbaFeZgsHgdMhoHU3s6kN9DZKA3poutOA5hEqfmvxDWo+3sFj1YbDH06vMJjVmkZ
	sbA7FI1Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuoxQ-00000000Otj-0RLZ;
	Sat, 06 Sep 2025 09:11:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org,
	amir73il@gmail.com,
	chuck.lever@oracle.com,
	linkinjeon@kernel.org,
	john@apparmor.net
Subject: [PATCH 15/21] ovl_validate_verity(): constify {meta,data}path arguments
Date: Sat,  6 Sep 2025 10:11:31 +0100
Message-ID: <20250906091137.95554-15-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250906091137.95554-1-viro@zeniv.linux.org.uk>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/overlayfs/overlayfs.h | 4 ++--
 fs/overlayfs/util.c      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 53a8ba572a0f..79cebf2a59d3 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -565,8 +565,8 @@ bool ovl_is_metacopy_dentry(struct dentry *dentry);
 char *ovl_get_redirect_xattr(struct ovl_fs *ofs, const struct path *path, int padding);
 int ovl_ensure_verity_loaded(const struct path *path);
 int ovl_validate_verity(struct ovl_fs *ofs,
-			struct path *metapath,
-			struct path *datapath);
+			const struct path *metapath,
+			const struct path *datapath);
 int ovl_get_verity_digest(struct ovl_fs *ofs, struct path *src,
 			  struct ovl_metacopy *metacopy);
 int ovl_sync_status(struct ovl_fs *ofs);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 35eb8ee6c9e2..b3264644edc4 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1401,8 +1401,8 @@ int ovl_ensure_verity_loaded(const struct path *datapath)
 }
 
 int ovl_validate_verity(struct ovl_fs *ofs,
-			struct path *metapath,
-			struct path *datapath)
+			const struct path *metapath,
+			const struct path *datapath)
 {
 	struct ovl_metacopy metacopy_data;
 	u8 actual_digest[FS_VERITY_MAX_DIGEST_SIZE];
-- 
2.47.2


