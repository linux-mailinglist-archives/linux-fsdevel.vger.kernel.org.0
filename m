Return-Path: <linux-fsdevel+bounces-54571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9236CB00F8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 01:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCCCF562A64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 23:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625D52D3A8A;
	Thu, 10 Jul 2025 23:21:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF252C376B;
	Thu, 10 Jul 2025 23:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189693; cv=none; b=ZMJsPM/ool+8Afw/7SbPyE+OoF7QB27wm4cL/LnBqgQNfASoxZntmHZNInwI9k/cj1gKx32tXPhVsTrsv06mLo3mmfTccQzb+Dbyj8CkN3sQ2gn6mtaBxBRLFGK/7dxZvNY1qIeyLTuQQ/uofdxhJplNiwYPySHi+0mJzJZEfhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189693; c=relaxed/simple;
	bh=Jg+1K49fVGdw2qf5ft0GXoLFodLfWMhLVl8OQfhDvOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpBvUJlCw79K7y00LnVsnDmtJEwxlD7O2Eb+691hTxsaWH75KsQp9KlEv5GmZ/2VvzGI2M/kfemUmb/EuLr1tiC0AZ9iy30r1OZP7IeHs/keq83lhzhL7HgEdzAtoKooCXITdJILmlN5fdD8t1wiw+i2AkuDBDha8tWqbqZPfig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ua0Zt-001XGa-Rn;
	Thu, 10 Jul 2025 23:21:23 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/20] ovl: narrow locking in ovl_cleanup_index()
Date: Fri, 11 Jul 2025 09:03:40 +1000
Message-ID: <20250710232109.3014537-11-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250710232109.3014537-1-neil@brown.name>
References: <20250710232109.3014537-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ovl_cleanup_index() takes a lock on the directory and then does a lookup
and possibly one of two different cleanups.
This patch narrows the locking to use the _unlocked() versions of the
lookup and one cleanup, and just takes the lock for the other cleanup.

A subsequent patch will take the lock into the cleanup.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/util.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 9ce9fe62ef28..7369193b11ec 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1107,21 +1107,20 @@ static void ovl_cleanup_index(struct dentry *dentry)
 		goto out;
 	}
 
-	inode_lock_nested(dir, I_MUTEX_PARENT);
-	index = ovl_lookup_upper(ofs, name.name, indexdir, name.len);
+	index = ovl_lookup_upper_unlocked(ofs, name.name, indexdir, name.len);
 	err = PTR_ERR(index);
 	if (IS_ERR(index)) {
 		index = NULL;
 	} else if (ovl_index_all(dentry->d_sb)) {
 		/* Whiteout orphan index to block future open by handle */
+		inode_lock_nested(dir, I_MUTEX_PARENT);
 		err = ovl_cleanup_and_whiteout(OVL_FS(dentry->d_sb),
 					       indexdir, index);
+		inode_unlock(dir);
 	} else {
 		/* Cleanup orphan index entries */
-		err = ovl_cleanup(ofs, dir, index);
+		err = ovl_cleanup_unlocked(ofs, indexdir, index);
 	}
-
-	inode_unlock(dir);
 	if (err)
 		goto fail;
 
-- 
2.49.0


