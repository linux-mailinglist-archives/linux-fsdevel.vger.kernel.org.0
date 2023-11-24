Return-Path: <linux-fsdevel+bounces-3621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E67107F6C12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07EC2817C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 06:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E055699;
	Fri, 24 Nov 2023 06:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="sD1p9PD3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D84D1BC1;
	Thu, 23 Nov 2023 22:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=F0l0LXuyYl3aQh13MYbOCPyTzEacmOUDtDuVZ649mGc=; b=sD1p9PD3jyjTCPHJWtPqnZMA0T
	HR9Bpn1XwnzdXDuf+Xux0SSutmhXjL89W81Q6BnH/bKLnZNmdJBlkSCWMz5q6C8LlMALjI/YRfuTn
	CzFod6rHTGuR/yvtjiswaZlnqzeoQC+tol32ywHs+eRThG0UzTetm6ekwJndC1krNdmNtTBS7i9No
	OK7dp98CvRYvGPbQ7z2MEqnlhDxYGzHpjtZ1PbkewNdwAG0KNoGDag/XVvMJ6KjVa63Xqiasr93jZ
	qvKZlsDYOHh7/5vzziUwSnZIB9vKg7877E4jBw+r7efOkzFpbYUMo2QLXKDlyMCv+JJCq2Lv1mUVj
	2mm+607A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6PKv-002Q0U-0N;
	Fri, 24 Nov 2023 06:06:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/20] get rid of __dget()
Date: Fri, 24 Nov 2023 06:06:28 +0000
Message-Id: <20231124060644.576611-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124060644.576611-1-viro@zeniv.linux.org.uk>
References: <20231124060553.GA575483@ZenIV>
 <20231124060644.576611-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

fold into the sole remaining caller

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index c82ae731df9a..b8f1b54a1492 100644
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


