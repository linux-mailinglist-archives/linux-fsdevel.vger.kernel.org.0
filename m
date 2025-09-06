Return-Path: <linux-fsdevel+bounces-60428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3417B46A8F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3DAA565716
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 09:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D1D2C3277;
	Sat,  6 Sep 2025 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZxoKiPWB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA48E298CD5
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149903; cv=none; b=a5AwmmekxD9i5YX51Fr7R8+xsGS0kpVy/6dDXFNuNsnP9sPjvRdG6IeRbafBKpsQgHyUaa+qmnMpRKPkv2Lw0E3pqx/3INyvVqhiWJLREn7pyTJRGyI/bu2RhYtn7jhBc3uJpvmXCfRLJX9pxcYsMK41Zi0ILBKuJn9+ewAQcjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149903; c=relaxed/simple;
	bh=Xg8P7dK37WgiYCC62pE5tGrv9QhvgjkiJy29YSKB7nI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vgt3BNik1tg9eeaLUJ932U3Kkfoz6PpqfwbgKkgVqnc8lhfia+UiNzRuF4KvgM0/XOzKwHUEfFKxG9PvJE4hjnfRj7UuhGhtapD1nvA84kmACL3hIcGzB85X2StvWIFV4DXVeil+Wto/A47/PPWwiqHkZ0R1ZOApQReWcManNkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZxoKiPWB; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=iT7HWSYMQGzjOnCsCBKJ+NIvYOLdxiQSlaWPwYJOnXI=; b=ZxoKiPWBaBsu0oM41k6MWgn8CS
	iGy7YoxzggtAb1o8ZTIQxsQpt0JAbIQv3GFshEquOpFEAxrJN4msna2Ygjb2vaMF5dDfhwpd42SCU
	qJ6larJBwV+LKjCG8XLy+fXJN4QHt1m2fZNjPQUXTqbV4kwdfNbAXJ0vdbBRy+LdDP0Fms7XboUHW
	4Xu8wtIh1/MVwty3p2/dyo9vwS96eQbkP2Cex1bXm5V5X8dAwwEsAPyT0vu/oWfmv+CsFEexaNpPD
	1zsJyxRCTOJAxMyFQCVsromr9C5ei2t51Q04Q25cLJQ+ZyMWfOn3Oqo8pb6qxWy2BBtg5qf8BWpSM
	3OP2KY+A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuoxQ-00000000Otf-03cF;
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
Subject: [PATCH 14/21] ovl_ensure_verity_loaded(): constify datapath argument
Date: Sat,  6 Sep 2025 10:11:30 +0100
Message-ID: <20250906091137.95554-14-viro@zeniv.linux.org.uk>
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
index bb0d7ded8e76..53a8ba572a0f 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -563,7 +563,7 @@ int ovl_set_metacopy_xattr(struct ovl_fs *ofs, struct dentry *d,
 			   struct ovl_metacopy *metacopy);
 bool ovl_is_metacopy_dentry(struct dentry *dentry);
 char *ovl_get_redirect_xattr(struct ovl_fs *ofs, const struct path *path, int padding);
-int ovl_ensure_verity_loaded(struct path *path);
+int ovl_ensure_verity_loaded(const struct path *path);
 int ovl_validate_verity(struct ovl_fs *ofs,
 			struct path *metapath,
 			struct path *datapath);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 41033bac96cb..35eb8ee6c9e2 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1381,7 +1381,7 @@ char *ovl_get_redirect_xattr(struct ovl_fs *ofs, const struct path *path, int pa
 }
 
 /* Call with mounter creds as it may open the file */
-int ovl_ensure_verity_loaded(struct path *datapath)
+int ovl_ensure_verity_loaded(const struct path *datapath)
 {
 	struct inode *inode = d_inode(datapath->dentry);
 	struct file *filp;
-- 
2.47.2


