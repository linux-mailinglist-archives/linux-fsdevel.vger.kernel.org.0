Return-Path: <linux-fsdevel+bounces-57597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFCDB23C90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 01:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABCC35686F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 23:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C682E5437;
	Tue, 12 Aug 2025 23:53:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5862F0661;
	Tue, 12 Aug 2025 23:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755042784; cv=none; b=SuBPxSoFFvFes6+CvtewIjBJhuDdmmZJJrEYzmyZBRTMkz5+0H+4vNkcPuOGBx6Pe4GwED4+iO7KGnzQelimhJYNHCATWQSqYLd+lMYhVyEGNHoXHQeVCwPsm6FDjZiAacJk+5URAY48h6dmeY/n+M9gqG5K3kJTFWNetTE58m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755042784; c=relaxed/simple;
	bh=oJDs9cs0PMUxO+Y7vEWjvv4x8YaRwIGuciOUq8hARic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZHpjCJy8s7veVfYkgTQLAj9QMFqP6MA0nfKjAgBsyaKGA9pXGaMM9z1R6n+aLEVvzH9r7Q4zx88Oft/t07RowXyb2wzRDV3Lwd8YIAKV8FzMPHrPFAUOcRZPwyQPbJY3WnseruAE8jt1C2dKgf+oX/bTEJp9NQsMgAw8ohOPWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ulynI-005Y1u-W6;
	Tue, 12 Aug 2025 23:52:42 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org,
	netfs@lists.linux.dev,
	ceph-devel@vger.kernel.org,
	ecryptfs@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] VFS: discard err2 in filename_create()
Date: Tue, 12 Aug 2025 12:25:04 +1000
Message-ID: <20250812235228.3072318-2-neil@brown.name>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250812235228.3072318-1-neil@brown.name>
References: <20250812235228.3072318-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During the time when "err2" holds a value, "error" does not hold any
meaningful value.  So there is no need for two different err variables.
This patch discards "err2" and uses "error' throughout.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index cd43ff89fbaa..62c1e2268942 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4114,7 +4114,6 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	unsigned int reval_flag = lookup_flags & LOOKUP_REVAL;
 	unsigned int create_flags = LOOKUP_CREATE | LOOKUP_EXCL;
 	int type;
-	int err2;
 	int error;
 
 	error = filename_parentat(dfd, name, reval_flag, path, &last, &type);
@@ -4129,7 +4128,7 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 		goto out;
 
 	/* don't fail immediately if it's r/o, at least try to report other errors */
-	err2 = mnt_want_write(path->mnt);
+	error = mnt_want_write(path->mnt);
 	/*
 	 * Do the final lookup.  Suppress 'create' if there is a trailing
 	 * '/', and a directory wasn't requested.
@@ -4142,17 +4141,16 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	if (IS_ERR(dentry))
 		goto unlock;
 
-	if (unlikely(err2)) {
-		error = err2;
+	if (unlikely(error))
 		goto fail;
-	}
+
 	return dentry;
 fail:
 	dput(dentry);
 	dentry = ERR_PTR(error);
 unlock:
 	inode_unlock(path->dentry->d_inode);
-	if (!err2)
+	if (!error)
 		mnt_drop_write(path->mnt);
 out:
 	path_put(path);
-- 
2.50.0.107.gf914562f5916.dirty


