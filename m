Return-Path: <linux-fsdevel+bounces-39369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E853BA1327C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 06:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9203A69DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 05:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D746519E7ED;
	Thu, 16 Jan 2025 05:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="R4RZYYZO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFB4156F41;
	Thu, 16 Jan 2025 05:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737005003; cv=none; b=BeZpPjuR7n023OXzPrPA+EesEdrENa5jHTT4WIeJtACrCgJprwfQ3ZeMiwQPZXkwqn+AlMTXUM8A+E/810OtVjz59R6pwLMU37J8ABfIo69h7ydhdWIxsefZzNe9fFOaGjkRlezIcNon89LMlfNbiiMVHHFSjhisyM5N3x5x0UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737005003; c=relaxed/simple;
	bh=jmK/wW2YLHbJxfn8fI7IJgelVSspe4ngR4kICJ2MuNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyEvBQwl9G6B7ce2GGzzcvLsv4iLOs/rQh4uI2ICqnAH4YTqx4vFPiCEwQw7pupEy1phfQ9xMqNHvvlAn9fyDo2N9W/9A5AicrAJimwLlIDxfuDrIX53PjFXMq2WaTNZLnH7uIg/GaGt4/soR0cWVOxBS5p86fCWTY1+1z7yqRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=R4RZYYZO; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ufJMBHMAmpmiY/Djp1CabwveoHb3CZ40EXQ3u044p9E=; b=R4RZYYZO8YFr4oB1qYkIu9GLuR
	s7QtP/ZBpEJQTaslRY+WMinSYhQEuKPT/v0kJFBTuKkmngariOQ6IeJROYgdxVtahUfsmdGimuTAG
	xrAw7dL8OKuCBBAgcr7cMlvu+hrdaAabHB4RlmQ+mcq8//G91ci1SYmsNd2AGT/mCxkFqsiY1a2g2
	SbI7X8yh4761xpk1IYHuTDSu+j8Z3md9LcTofTkzA86n3pkdTJNwogAQuyU7lFAkdyC/9hiKD2c4t
	zBUSxNK7nuM3v4FkVyuesuvDTmpkfLhwDlDvVDAoiXr5NZl4SHCf3NwaMkPut0sZU2WM7NIj7jTbR
	HnUjij+Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYILf-000000022I0-2D2t;
	Thu, 16 Jan 2025 05:23:19 +0000
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
Subject: [PATCH v2 14/20] fuse_dentry_revalidate(): use stable parent inode and name passed by caller
Date: Thu, 16 Jan 2025 05:23:11 +0000
Message-ID: <20250116052317.485356-14-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116052317.485356-1-viro@zeniv.linux.org.uk>
References: <20250116052103.GF1977892@ZenIV>
 <20250116052317.485356-1-viro@zeniv.linux.org.uk>
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


