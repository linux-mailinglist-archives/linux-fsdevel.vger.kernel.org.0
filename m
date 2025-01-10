Return-Path: <linux-fsdevel+bounces-38790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C12FA0859C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 03:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D773A965D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 02:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27317207A35;
	Fri, 10 Jan 2025 02:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gku9RaIM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3AC1E32C5;
	Fri, 10 Jan 2025 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736476989; cv=none; b=HeXBQVy2AKcVYOsDGcn7MxkNFkv3Qb2JIaXPsjs2qRcggQ2LXGcefzAMaioeB6Yf5lhjzMOQU3RhRGFjxmqRw3fy34qv1i0yf2CCoWCTELmubD84F5zUg4JFYAa4GOpMkB2loivcFapTNAWADRvD82L/ttJ2Ci86RN3Cmb1dYSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736476989; c=relaxed/simple;
	bh=jmK/wW2YLHbJxfn8fI7IJgelVSspe4ngR4kICJ2MuNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Px/BiElAIwPPNhgbg2mC4phSVr0ISdFdq9UqGG9IcxaTfhxiWwjcEkIjMXNaZc+L0JnRCDpGfCiQpZnluDHhPfQyX0B/JWSmVJDJ85hvdjq+lY/3UofaRXT/Y2UbP66M/lF4760wFLo4yWtwUehJYSR345ok1/eNbeQYGQVIOpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gku9RaIM; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ufJMBHMAmpmiY/Djp1CabwveoHb3CZ40EXQ3u044p9E=; b=gku9RaIM8hF3vKgcAgtxM1RevQ
	umaV11Uj9ryjQmoTcybMVn1d/hl6JCzmWG8MVnIhR3Kqsea5EdrVCLnSNp8FP/j6GXbxDjS7vP/EW
	PkLb6CI4xx41sBE99ezmcwjFEDHRmtH1hRbTzgXpofjfNx+bNjrdcTxU9KBKVAL+EJVH22mjyA+QE
	flqJFwfvHGesUn3KuVnvHA0rv7WhTP9DSJnyMkTr3vWELq+zE04T0flIRNtyVVsZHOmNQglJVAqcF
	9mJu7pEBSvh8VZrS/sc/gVBLAnxoHn7Xnpk1dxbRDDiCNIaTv++gYAgX5OTbqqoPzrJNZk0XMugQz
	n7oGyPew==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tW4zJ-0000000HRcS-0IMr;
	Fri, 10 Jan 2025 02:43:05 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: agruenba@redhat.com,
	amir73il@gmail.com,
	brauner@kernel.org,
	ceph-devel@vger.kernel.org,
	dhowells@redhat.com,
	hubcap@omnibond.com,
	jack@suse.cz,
	krisman@kernel.org,
	linux-nfs@vger.kernel.org,
	miklos@szeredi.hu,
	torvalds@linux-foundation.org
Subject: [PATCH 14/20] fuse_dentry_revalidate(): use stable parent inode and name passed by caller
Date: Fri, 10 Jan 2025 02:42:57 +0000
Message-ID: <20250110024303.4157645-14-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
References: <20250110023854.GS1977892@ZenIV>
 <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

No need to mess with dget_parent() for the former; for the latter we really should
not rely upon ->d_name.name remaining stable - it's a real-life UAF.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/fuse/dir.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d9e9f26917eb..7e93a8470c36 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -196,7 +196,6 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
 				  struct dentry *entry, unsigned int flags)
 {
 	struct inode *inode;
-	struct dentry *parent;
 	struct fuse_mount *fm;
 	struct fuse_inode *fi;
 	int ret;
@@ -228,11 +227,9 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
 
 		attr_version = fuse_get_attr_version(fm->fc);
 
-		parent = dget_parent(entry);
-		fuse_lookup_init(fm->fc, &args, get_node_id(d_inode(parent)),
-				 &entry->d_name, &outarg);
+		fuse_lookup_init(fm->fc, &args, get_node_id(dir),
+				 name, &outarg);
 		ret = fuse_simple_request(fm, &args);
-		dput(parent);
 		/* Zero nodeid is same as -ENOENT */
 		if (!ret && !outarg.nodeid)
 			ret = -ENOENT;
@@ -266,9 +263,7 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
 			if (test_bit(FUSE_I_INIT_RDPLUS, &fi->state))
 				return -ECHILD;
 		} else if (test_and_clear_bit(FUSE_I_INIT_RDPLUS, &fi->state)) {
-			parent = dget_parent(entry);
-			fuse_advise_use_readdirplus(d_inode(parent));
-			dput(parent);
+			fuse_advise_use_readdirplus(dir);
 		}
 	}
 	ret = 1;
-- 
2.39.5


