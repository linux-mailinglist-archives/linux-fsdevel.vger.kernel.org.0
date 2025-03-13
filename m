Return-Path: <linux-fsdevel+bounces-43948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AAFA604D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108CD1890812
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 22:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D6E1F8BA4;
	Thu, 13 Mar 2025 22:53:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B50F1F585F;
	Thu, 13 Mar 2025 22:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741906439; cv=none; b=jz0x3mpksoFHOXPgs8eiIUjm4xhBYaQ1jKFZ1iv0DdwRMVZasW+gQKN5L++PXqyKBxJ1Y4MchrRXJcCgFGgLz5AjD+K4qua4vyIThcoRck5YFT/0mFPd2PsjEilgNs1QpQualCUSE9cyZyd6XciPfKr2FfpvVKHEDhB3S8R8TcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741906439; c=relaxed/simple;
	bh=/ie6fpq0FXgm9kqxwUTNFnggiB1jw1uZU5XBs5Clzoo=;
	h=Content-Type:MIME-Version:From:To:Subject:Date:Message-id; b=LzaHOWdcgA1AHT2qdMRK/5FhGS3NcQvFTHpiYE5KGF+VEMsC05piY9xyZ5KLFeq2tRUd8q982LYEsd6ctFY7yJC4jj0ee446TNZQOikKyjBgnqRsTSTELm+bd7t/jOl+gNxbf5yP+SUoQfKstZCvn01cgK/Mlu2TebWJapHD6Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1tsr3V-00DymL-Fj;
	Thu, 13 Mar 2025 22:29:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org
Subject: [PATCH] exportfs: remove locking around ->get_parent() call.
Date: Fri, 14 Mar 2025 09:29:33 +1100
Message-id: <174190497326.9342.9313518146512158587@noble.neil.brown.name>


The locking around the ->get_parent() call brings no value.
We are locking a child which is only used to find an inode and thence the
parent inode number.  All further activity involves the parent inode
which may have several children so locking one child cannot protect the
parent in any useful way.

The filesystem must already ensure that only one 'struct inode' exists
for a given inode, and will call d_obtain_alias() which contains the
required locking to ensure only one dentry will be attached to that
inode.

So remove the unnecessary locking.

Signed-off-by: NeilBrown <neil@brown.name>
---

I've been reviewing locking in directories and this stood out has
unnecessary.  It isn't harmful, but it doesn't bring any value.
NeilBrown


 fs/exportfs/expfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 0c899cfba578..b5845c4846b8 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -126,10 +126,8 @@ static struct dentry *reconnect_one(struct vfsmount *mnt,
 	int err;
 
 	parent = ERR_PTR(-EACCES);
-	inode_lock(dentry->d_inode);
 	if (mnt->mnt_sb->s_export_op->get_parent)
 		parent = mnt->mnt_sb->s_export_op->get_parent(dentry);
-	inode_unlock(dentry->d_inode);
 
 	if (IS_ERR(parent)) {
 		dprintk("get_parent of %lu failed, err %ld\n",
-- 
2.48.1


