Return-Path: <linux-fsdevel+bounces-26652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD9A95AA70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AAFC282299
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7008F183CCA;
	Thu, 22 Aug 2024 01:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZsvylOy9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB89F17E00B;
	Thu, 22 Aug 2024 01:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289943; cv=none; b=eRFP9aooJS7Ucn1LwnNnHoKLNFvNIR1kRBR/mdHkwT+SAUXV5BTqAaHBHuLBpD0c99og/BS33BdqEYnPh8HOe1YMd5VwVMIUGfEj1/KAtFwUzk720G1BfmSgDylHZvbP/NADe0vpnHkA0AqxSPIsYoBubyNKszgjy6JnL9pfp+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289943; c=relaxed/simple;
	bh=6M6TuV11ei06FPTwgbqeUwJE2rETFxiK6ef+nSipYcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AIoaVipViUrnSEzU9fDDSjlBQ8BNY8Tvm/lLI1u4vcXxygXGPJ8zun4AyUY7tkqu9r6IjDpB/33ychW7kgFlELzOutwhjneti/sTViQs7yqcHfpQNaoDAeu6YUmvnqtIgLClzShHo2OhZNd4wapxCLc4AsJwwcro+fopVxNRu9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZsvylOy9; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724289942; x=1755825942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6M6TuV11ei06FPTwgbqeUwJE2rETFxiK6ef+nSipYcE=;
  b=ZsvylOy9ZXfW0ABbxMSWfoJaM0n1p8MUQ2IkrnjxCtUF5Ejn4ayTYdn7
   EpRF1CmkvaOaLEs/ZGKZPFQRdiQv4VpQhyLFeCjT1iEOmaZ1lMfyDG2VU
   zENG20WjW16ckiBtJMOuMsKkfbLCug5uzCsMOAbhRBxxo6Dz3TjFaq0QQ
   5N3NCMSpqtwJqv9LFoyF+ejXAZFJota6KzGGIMueMHB6XywymjdyiIH+S
   FgDzMgFO2DHajhRkVRgRb/1WKAEJMhqijpW4/M5R0kfkTusqpj2pJ0M3f
   No1DBEVDiVG76txAgST8xkwwqzZwuBWQHu6HsgcfTIPOso2w17tZFw9H9
   A==;
X-CSE-ConnectionGUID: YgtJp8MqQoaxb+nvZYkX6g==
X-CSE-MsgGUID: Wxj7DTMESLSX5n5FFGmaNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="25574775"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="25574775"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:25:33 -0700
X-CSE-ConnectionGUID: 7ywRWZ4aRvGJIYpPDiRPew==
X-CSE-MsgGUID: ZK6B9VHvTPyXJoI+FElMlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="61811060"
Received: from unknown (HELO vcostago-mobl3.jf.intel.com) ([10.241.225.92])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:25:32 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: brauner@kernel.org,
	amir73il@gmail.com,
	hu1.chen@intel.com
Cc: miklos@szeredi.hu,
	malini.bhandaru@intel.com,
	tim.c.chen@intel.com,
	mikko.ylinen@intel.com,
	lizhen.you@intel.com,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH v2 13/16] overlayfs/readdir: Convert to cred_guard()
Date: Wed, 21 Aug 2024 18:25:20 -0700
Message-ID: <20240822012523.141846-14-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822012523.141846-1-vinicius.gomes@intel.com>
References: <20240822012523.141846-1-vinicius.gomes@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the override_creds_light()/revert_creds_light() pairs of
operations with cred_guard()/cred_scoped_guard().

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 fs/overlayfs/readdir.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index c8bf681f5cf0..41e01fe3ae4a 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -273,9 +273,8 @@ static int ovl_check_whiteouts(const struct path *path, struct ovl_readdir_data
 	int err;
 	struct ovl_cache_entry *p;
 	struct dentry *dentry, *dir = path->dentry;
-	const struct cred *old_cred;
 
-	old_cred = ovl_override_creds_light(rdd->dentry->d_sb);
+	cred_guard(ovl_creds(rdd->dentry->d_sb));
 
 	err = down_write_killable(&dir->d_inode->i_rwsem);
 	if (!err) {
@@ -290,7 +289,6 @@ static int ovl_check_whiteouts(const struct path *path, struct ovl_readdir_data
 		}
 		inode_unlock(dir->d_inode);
 	}
-	revert_creds_light(old_cred);
 
 	return err;
 }
@@ -753,10 +751,9 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 	struct dentry *dentry = file->f_path.dentry;
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct ovl_cache_entry *p;
-	const struct cred *old_cred;
 	int err;
 
-	old_cred = ovl_override_creds_light(dentry->d_sb);
+	cred_guard(ovl_creds(dentry->d_sb));
 	if (!ctx->pos)
 		ovl_dir_reset(file);
 
@@ -808,7 +805,6 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 	}
 	err = 0;
 out:
-	revert_creds_light(old_cred);
 	return err;
 }
 
@@ -856,11 +852,9 @@ static struct file *ovl_dir_open_realfile(const struct file *file,
 					  const struct path *realpath)
 {
 	struct file *res;
-	const struct cred *old_cred;
 
-	old_cred = ovl_override_creds_light(file_inode(file)->i_sb);
+	cred_guard(ovl_creds(file_inode(file)->i_sb));
 	res = ovl_path_open(realpath, O_RDONLY | (file->f_flags & O_LARGEFILE));
-	revert_creds_light(old_cred);
 
 	return res;
 }
@@ -983,11 +977,9 @@ int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
 	int err;
 	struct ovl_cache_entry *p, *n;
 	struct rb_root root = RB_ROOT;
-	const struct cred *old_cred;
 
-	old_cred = ovl_override_creds_light(dentry->d_sb);
+	cred_guard(ovl_creds(dentry->d_sb));
 	err = ovl_dir_read_merged(dentry, list, &root);
-	revert_creds_light(old_cred);
 	if (err)
 		return err;
 
-- 
2.46.0


