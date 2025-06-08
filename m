Return-Path: <linux-fsdevel+bounces-50946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0D5AD159C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 01:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93753188B7B4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 23:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D87025E449;
	Sun,  8 Jun 2025 23:10:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223CC204F73;
	Sun,  8 Jun 2025 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749424214; cv=none; b=Tod7PjKnpofcZOdlJg+wKjLvkW4CeDsMKtBQhHkl7oGYnFKf5xhSsxVfQl5lIVo9pVOCgf+YniwSNAyVPnRjB/zS9J6KkMyisKGa0SnirhBZrLcR6bbZKQGjZ3cKuh7/BSuPBO7xvbHd938CFGCa4Au3eEY0Dh2XszGJ6+oLtX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749424214; c=relaxed/simple;
	bh=ObvnvO3+t12hpNayz3l7yHkc7YCHVilu1hZ99j0WSs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYrQw/IiqY145xppo+Fjjva7t61RrvlrUZ1hwx2c+TQJReY8+DYo1+MCRwsTZa+oC330HxltOW8YCDCArHimDwj4lzKZyt7UcjdTzg1dqkUzQYeqRuSeKpxwbJgNd1tMNfBu+aOL6d/CHUE+32XCVHYD8Zg8pP7iDCxOIiHnraQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uOP9Q-005vf1-O1;
	Sun, 08 Jun 2025 23:10:04 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	David Howells <dhowells@redhat.com>,
	Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Carlos Maiolino <cem@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	coda@cs.cmu.edu,
	codalist@coda.cs.cmu.edu,
	linux-nfs@vger.kernel.org,
	netfs@lists.linux.dev,
	ecryptfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] exportfs: use lookup_one_unlocked()
Date: Mon,  9 Jun 2025 09:09:36 +1000
Message-ID: <20250608230952.20539-5-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608230952.20539-1-neil@brown.name>
References: <20250608230952.20539-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rather than locking the directory and using lookup_one(), just use
lookup_one_unlocked().  This keeps locking code centralised.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/exportfs/expfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index cdefea17986a..d3e55de4a2a2 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -549,15 +549,13 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
 			goto err_result;
 		}
 
-		inode_lock(target_dir->d_inode);
-		nresult = lookup_one(mnt_idmap(mnt), &QSTR(nbuf), target_dir);
+		nresult = lookup_one_unlocked(mnt_idmap(mnt), &QSTR(nbuf), target_dir);
 		if (!IS_ERR(nresult)) {
 			if (unlikely(nresult->d_inode != result->d_inode)) {
 				dput(nresult);
 				nresult = ERR_PTR(-ESTALE);
 			}
 		}
-		inode_unlock(target_dir->d_inode);
 		/*
 		 * At this point we are done with the parent, but it's pinned
 		 * by the child dentry anyway.
-- 
2.49.0


