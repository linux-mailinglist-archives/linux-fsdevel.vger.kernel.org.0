Return-Path: <linux-fsdevel+bounces-2476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B24DF7E63B8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 07:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E377B1C209D0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 06:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C9A101ED;
	Thu,  9 Nov 2023 06:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fmdzLxwX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53430D308
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 06:20:59 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74365A4
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 22:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=K8pn4j7PhfDk0ZZ9suKzepKbvr/qzVgdalV7y/0pxco=; b=fmdzLxwXuGIsPkMMXcJ8qc7YxC
	BVVH9HoyGE9vkvy5tk8fs3X8JnU1NwpVKrn0JMRhrumevsbNIeF/2wI4JmqLErjglz1PtsiUnqLuN
	peIx+MuyVLHhXViJxArMqZ6S/vz9yqDvg2MTOiMKonu6aYHIfHgbeYtBPY0BgbmdaTe0Yq40SmZqn
	3jtoRVP18QhRXIeHizoGMkh43ECm0ZiihyV53Muu+G4d4LFSMsaqWoLOHRKbmo4uHE1HCzvRVGoZn
	0FU/4c8JtOGJwpYgZ1t5eeuqAC3DWJl9qCh6MiYKpe1lRNhCAoZu4lCtMqBHAQncZSfL3A/BZgtjK
	WIoDpqSg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0yPR-00DLjP-0P;
	Thu, 09 Nov 2023 06:20:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 06/22] get rid of __dget()
Date: Thu,  9 Nov 2023 06:20:40 +0000
Message-Id: <20231109062056.3181775-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

fold into the sole remaining caller

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 56af55f2b7d9..1476f2d6e9ea 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -948,11 +948,6 @@ static inline void __dget_dlock(struct dentry *dentry)
 	dentry->d_lockref.count++;
 }
 
-static inline void __dget(struct dentry *dentry)
-{
-	lockref_get(&dentry->d_lockref);
-}
-
 struct dentry *dget_parent(struct dentry *dentry)
 {
 	int gotref;
@@ -1002,7 +997,7 @@ static struct dentry * __d_find_any_alias(struct inode *inode)
 	if (hlist_empty(&inode->i_dentry))
 		return NULL;
 	alias = hlist_entry(inode->i_dentry.first, struct dentry, d_u.d_alias);
-	__dget(alias);
+	lockref_get(&alias->d_lockref);
 	return alias;
 }
 
-- 
2.39.2


