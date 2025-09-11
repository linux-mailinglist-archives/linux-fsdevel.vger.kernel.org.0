Return-Path: <linux-fsdevel+bounces-60882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CB1B527FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 07:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8885568786E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 05:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F72247298;
	Thu, 11 Sep 2025 05:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UGaZJ8SP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3847620E011;
	Thu, 11 Sep 2025 05:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757567138; cv=none; b=HqkVDjSAmL9AkhEKMn1qCqfn7BS8YV1zreCgmC+R6iJfsW2qx3RqRVZt3UWYrBB3YVaMeolixUUvAiry/YTSNwZBBm4QSTWvbcK5xH+tnTG7UbPqCbavn6FzyPuQ3ORuRjI/6TS8EnUm4cJ6VQhtQfEPYL0lU2faA/SPJAdarQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757567138; c=relaxed/simple;
	bh=b5ZBvERkdH8vOTJItzGJp82769lofyAvB24do6v6itc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHxNWEgKyUgrb1jEbrl9o4HPiHbIsk6bEgRvQsR1Tk4u6lBUUpZAWCuqs2oFRD3XK7cbf4+ZY6QQME7HbHqo2WMFKeeQNiMyN7sgt2FnHrTS6g0IqYbIiK12NAeyRILXQh0vlSXbGcu49Cp4CbDcy9wJO2JX4JFY8q2Ul2OIH0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UGaZJ8SP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=X5NYexs5to7ku/98y4PbCRGAJ6PlJUakVx43z5KXmHg=; b=UGaZJ8SPUqSPuoaCuHEufKKzTg
	EhLOxLHB82pylneJRCwmfmGKUFoaJxlSAGWdSfKrhfIGABKGeJsLh6KTmnLnvu2msyzi8Z9Qy/q9K
	vv7FESq0ERew6BttOGGFXd8VVo43ZSfqxGr6sO3M+pMqQBctCBODfds2b9sEpo3+3cRbtHmkBtZdX
	bFy+wfaMufVvawztVX966rQn6VRd/Y8v/5X2UXsMGimcCk2YJTnIEr8s0eR0MFM27XBwCHV3MS3cS
	e14ZOSypQdyL7Ojmuoqy966rKsRkLZHER+SibpayRqdbIwvleRu/jjf8e/6xr2HJCglUIiLWwOlEQ
	xfvN1uMQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwZV0-0000000D4kL-3UPh;
	Thu, 11 Sep 2025 05:05:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	neil@brown.name,
	linux-security-module@vger.kernel.org,
	dhowells@redhat.com,
	linkinjeon@kernel.org
Subject: [PATCH 3/6] afs_edit_dir_{add,remove}(): constify qstr argument
Date: Thu, 11 Sep 2025 06:05:31 +0100
Message-ID: <20250911050534.3116491-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250911050534.3116491-1-viro@zeniv.linux.org.uk>
References: <20250911050149.GW31600@ZenIV>
 <20250911050534.3116491-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Nothing outside of fs/dcache.c has any business modifying
dentry names; passing &dentry->d_name as an argument should
have that argument declared as a const pointer.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/afs/dir_edit.c | 4 ++--
 fs/afs/internal.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index 60a549f1d9c5..60b0f70f63a3 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -239,7 +239,7 @@ static void afs_edit_init_block(union afs_xdr_dir_block *meta,
  * The caller must hold the inode locked.
  */
 void afs_edit_dir_add(struct afs_vnode *vnode,
-		      struct qstr *name, struct afs_fid *new_fid,
+		      const struct qstr *name, struct afs_fid *new_fid,
 		      enum afs_edit_dir_reason why)
 {
 	union afs_xdr_dir_block *meta, *block;
@@ -391,7 +391,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
  * The caller must hold the inode locked.
  */
 void afs_edit_dir_remove(struct afs_vnode *vnode,
-			 struct qstr *name, enum afs_edit_dir_reason why)
+			 const struct qstr *name, enum afs_edit_dir_reason why)
 {
 	union afs_xdr_dir_block *meta, *block, *pblock;
 	union afs_xdr_dirent *de, *pde;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 1124ea4000cb..db14882d367b 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1097,9 +1097,9 @@ int afs_single_writepages(struct address_space *mapping,
 /*
  * dir_edit.c
  */
-extern void afs_edit_dir_add(struct afs_vnode *, struct qstr *, struct afs_fid *,
+extern void afs_edit_dir_add(struct afs_vnode *, const struct qstr *, struct afs_fid *,
 			     enum afs_edit_dir_reason);
-extern void afs_edit_dir_remove(struct afs_vnode *, struct qstr *, enum afs_edit_dir_reason);
+extern void afs_edit_dir_remove(struct afs_vnode *, const struct qstr *, enum afs_edit_dir_reason);
 void afs_edit_dir_update_dotdot(struct afs_vnode *vnode, struct afs_vnode *new_dvnode,
 				enum afs_edit_dir_reason why);
 void afs_mkdir_init_dir(struct afs_vnode *dvnode, struct afs_vnode *parent_vnode);
-- 
2.47.2


