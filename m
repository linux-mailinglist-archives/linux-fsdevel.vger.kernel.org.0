Return-Path: <linux-fsdevel+bounces-10515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF95784BE85
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 21:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800E21F25D55
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 20:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E371B7E4;
	Tue,  6 Feb 2024 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OhqAo2ny"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885C217BB9
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 20:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707250753; cv=none; b=PP2dbiBrMxHglqAX5OLY+GInH27a3CMRH5QJ+52jVFDFNT/mZLfCSH01f9zyLjEgZTcEc/Ldh+pq9IRR2/yXpX58qaY+7zBLoVg6QKyRsKYduGj22A3GRrJ9TsIKeigsvnnGsrXx8M31MWsG+s8IbkR9BbgEpYna7iwJD13Uyyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707250753; c=relaxed/simple;
	bh=n3McJjJh/WLCQm3zWRum7CJcJhpjLROkO/Uv6o5ddcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOrvNkme+/GuRytXWglxwMuoWyQdWELkkZ94VffVn8iHMaVVaL9aec8HVvpnOFfnLVNqD9LknZvanDOKKFY0xfOW6+W0GfHGJ38/OfWM2tJPXR3iS8VY/w3mcFUtQ0Dfveb+3t3R8Tt0rgU0/zUTc/6XhiYsUDNiDKOo6cE5s9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OhqAo2ny; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707250749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNJ5lQuPym878v0er8vpFPNJuyo1lBu3+aim1D8jyPw=;
	b=OhqAo2nyn+QVkXwlDoLVABeH4M1vXv0DMDYC6gNSNbDYa5Rd5PtFfzkmSkyMfI8nk8/BK5
	TM0nhld+LO/gbU7Str1jdj+3e7cCMVMy8aBV8ig2dfLFKrtgcjW4moH2uS4NIvuoJkMftz
	Q7wFSn7haiI7X3b8Mklge47WtX3EAqI=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-unionfs@vger.kernel.org
Subject: [PATCH v2 2/7] overlayfs: Convert to super_set_uuid()
Date: Tue,  6 Feb 2024 15:18:50 -0500
Message-ID: <20240206201858.952303-3-kent.overstreet@linux.dev>
In-Reply-To: <20240206201858.952303-1-kent.overstreet@linux.dev>
References: <20240206201858.952303-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We don't want to be settingc sb->s_uuid directly anymore, as there's a
length field that also has to be set, and this conversion was not
completely trivial.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org
---
 fs/overlayfs/util.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 0217094c23ea..f1f0ee9a9dff 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -760,13 +760,14 @@ bool ovl_init_uuid_xattr(struct super_block *sb, struct ovl_fs *ofs,
 			 const struct path *upperpath)
 {
 	bool set = false;
+	uuid_t uuid;
 	int res;
 
 	/* Try to load existing persistent uuid */
-	res = ovl_path_getxattr(ofs, upperpath, OVL_XATTR_UUID, sb->s_uuid.b,
+	res = ovl_path_getxattr(ofs, upperpath, OVL_XATTR_UUID, uuid.b,
 				UUID_SIZE);
 	if (res == UUID_SIZE)
-		return true;
+		goto success;
 
 	if (res != -ENODATA)
 		goto fail;
@@ -794,14 +795,14 @@ bool ovl_init_uuid_xattr(struct super_block *sb, struct ovl_fs *ofs,
 	}
 
 	/* Generate overlay instance uuid */
-	uuid_gen(&sb->s_uuid);
+	uuid_gen(&uuid);
 
 	/* Try to store persistent uuid */
 	set = true;
-	res = ovl_setxattr(ofs, upperpath->dentry, OVL_XATTR_UUID, sb->s_uuid.b,
+	res = ovl_setxattr(ofs, upperpath->dentry, OVL_XATTR_UUID, uuid.b,
 			   UUID_SIZE);
 	if (res == 0)
-		return true;
+		goto success;
 
 fail:
 	memset(sb->s_uuid.b, 0, UUID_SIZE);
@@ -809,6 +810,9 @@ bool ovl_init_uuid_xattr(struct super_block *sb, struct ovl_fs *ofs,
 	pr_warn("failed to %s uuid (%pd2, err=%i); falling back to uuid=null.\n",
 		set ? "set" : "get", upperpath->dentry, res);
 	return false;
+success:
+	super_set_uuid(sb, uuid.b, sizeof(uuid));
+	return true;
 }
 
 bool ovl_path_check_dir_xattr(struct ovl_fs *ofs, const struct path *path,
-- 
2.43.0


