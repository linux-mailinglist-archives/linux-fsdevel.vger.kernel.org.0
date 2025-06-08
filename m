Return-Path: <linux-fsdevel+bounces-50943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0B0AD1585
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 01:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C6963AA777
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 23:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3B625D1FC;
	Sun,  8 Jun 2025 23:10:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2242620ADEE;
	Sun,  8 Jun 2025 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749424212; cv=none; b=Byh7ZMa2TzJIB+vI2DJxj0ymp/caVFHHNSNEhLsHbgegaKzxr9qccuSlP789jeN8pkxIojLbuEnfNF9xqFMrcypwaL4yC2hRS77S+SjYaL48fVKSBB7qZyJkN543YYUoLpmqYpzL4zE0xZayr4B5rsdYS2ycl/dKMqlUjD2VEvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749424212; c=relaxed/simple;
	bh=nYuk6jE4ZVNIYydUqLS4Mqn8tWDzVCXZkSneP/JlYX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIYGuXJP7jszk6/pes4zNAwom2MgUqZzxW+u344e2vABXWchVixO0mF/gyoRJ2+1VflXXbwERH6+aqdRlkEjhFLU6BZxa4+l8VpvNGZ45GkbFDiDg2P0mFG0yDZYiL3TvN8rgdvUgh0F3O53dbj3UDfN/knGKMRQjtc/Q+49Xs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uOP9Q-005veu-3M;
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
Subject: [PATCH 3/5] coda: use iterate_dir() in coda_readdir()
Date: Mon,  9 Jun 2025 09:09:35 +1000
Message-ID: <20250608230952.20539-4-neil@brown.name>
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

The code in coda_readdir() is nearly identical to iterate_dir().
Differences are:
 - iterate_dir() is killable
 - iterate_dir() adds permission checking and accessing notifications

I believe these are not harmful for coda so it is best to use
iterate_dir() directly.  This will allow locking changes without
touching the code in coda.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/coda/dir.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index ab69d8f0cec2..ca9990017265 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -429,17 +429,9 @@ static int coda_readdir(struct file *coda_file, struct dir_context *ctx)
 	cfi = coda_ftoc(coda_file);
 	host_file = cfi->cfi_container;
 
-	if (host_file->f_op->iterate_shared) {
-		struct inode *host_inode = file_inode(host_file);
-		ret = -ENOENT;
-		if (!IS_DEADDIR(host_inode)) {
-			inode_lock_shared(host_inode);
-			ret = host_file->f_op->iterate_shared(host_file, ctx);
-			file_accessed(host_file);
-			inode_unlock_shared(host_inode);
-		}
+	ret = iterate_dir(host_file, ctx);
+	if (ret != -ENOTDIR)
 		return ret;
-	}
 	/* Venus: we must read Venus dirents from a file */
 	return coda_venus_readdir(coda_file, ctx);
 }
-- 
2.49.0


