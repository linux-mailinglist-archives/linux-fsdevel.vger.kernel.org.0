Return-Path: <linux-fsdevel+bounces-60432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56656B46A92
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311DB1890BAB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 09:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756BF2D0C61;
	Sat,  6 Sep 2025 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pxyfAjRQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAC029AAFD
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 09:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149903; cv=none; b=pNK+sXlDp4KfEylPpY6gnXYU5Gs5KmIQJFbwW+boqLuY3cYw+Nph6f/u4WyHAlrvN6fObyav5NvUD64gEUPORKxaV0mOgJRMRXwFtmXj4eRtnXNKOFcTwhXJzPKpjHjfwswgKQLBwE7XnXRFOsZV3w1QxgF+yleOebLWLeAFtqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149903; c=relaxed/simple;
	bh=NMLUmS8YD7tPgoeWabF/r8CVJ5dQ0lNtDF/DyGMJdaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUPkaNUER4wwDOECa3U5QQKg2S/AXoM1SqsINdaTGacwYNMpB967EcIVhuxPEiogm8LE1RgM/53w4a8KBwUeHtyqOEhK29dAjxWNfnnumoUSjaoTGPwddFYxYglSdv+ClQQF5Y5mdTDMU+jzbSpepImqKgsLQdWtOvz7TN2pl5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pxyfAjRQ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=jc3XBgYmTNV3nV0JLJAYIxOH5LakTpuzvkrpXfOphaA=; b=pxyfAjRQsgIg9jyEZjYfxVBHcS
	V37cZrp/mMpJMIi3oMGIsUqP39Bsaj65NPhFASYaK6fLPhh/tyy8eFsT4pxG/SUXboBbMQYanvj9V
	E8DGsEFH26/jhNvj0AYq0UC39kxwtS1ZFmrEHCHYt+S271yuYbR3pBip+bXyX+nkj2HqsW3QfSqQe
	u2xuMf4WVTh+oMkl6aW5ouS1eaWCYNLdA4BpkfQACwKUqyzIkz/AgmrBnKGpbN4Q8o7WyOmxASkuO
	gLt1LX76xr8BND3vE3KDVkwe50U96EXgPrDjHeTuCn9BM0gzAvtmJfX0bLe0zp992NwL3u3vrEonS
	WmAy2Weg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuoxQ-00000000OuC-216j;
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
Subject: [PATCH 16/21] ovl_get_verity_digest(): constify path argument
Date: Sat,  6 Sep 2025 10:11:32 +0100
Message-ID: <20250906091137.95554-16-viro@zeniv.linux.org.uk>
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
 fs/overlayfs/overlayfs.h | 2 +-
 fs/overlayfs/util.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 79cebf2a59d3..e3a74922d9e4 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -567,7 +567,7 @@ int ovl_ensure_verity_loaded(const struct path *path);
 int ovl_validate_verity(struct ovl_fs *ofs,
 			const struct path *metapath,
 			const struct path *datapath);
-int ovl_get_verity_digest(struct ovl_fs *ofs, struct path *src,
+int ovl_get_verity_digest(struct ovl_fs *ofs, const struct path *src,
 			  struct ovl_metacopy *metacopy);
 int ovl_sync_status(struct ovl_fs *ofs);
 
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index b3264644edc4..14f1c2a98f17 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1455,7 +1455,7 @@ int ovl_validate_verity(struct ovl_fs *ofs,
 	return 0;
 }
 
-int ovl_get_verity_digest(struct ovl_fs *ofs, struct path *src,
+int ovl_get_verity_digest(struct ovl_fs *ofs, const struct path *src,
 			  struct ovl_metacopy *metacopy)
 {
 	int err, digest_size;
-- 
2.47.2


