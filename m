Return-Path: <linux-fsdevel+bounces-1696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622177DDC84
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 07:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D5F9281A97
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 06:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1832E63CD;
	Wed,  1 Nov 2023 06:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="o8vLs/i+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AF14C7B
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 06:21:14 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54955FC
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 23:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VlJsWlAclT+yLzchi4E3P/hJdL5zj/z1kNqnZqk4gRw=; b=o8vLs/i+QS4XbPSxqik+8Q4V9t
	Pm3LtgCWSZ1FLgnAFIASMwogU4Osc9khn1PT5uuwgsNLjvEYLlj2Uvl3IbSZqQHUqEmCkAWSMTXtK
	lMjCcC5SWrWGWH7lGNTZ4SqXvASsrlJuugjfMgcjUj+bCDO+9pFdT+49ztQ6FjoP9CiiLMHfphVGP
	6orQm1ZBx+7fHP5laRl4xiGUp5ZY6pCcO56AIMlntOo6JNs/4OoxZeiYBNI/kEWooyCT15h6SmyNm
	Yw6kG5fTlJ3IVnfZon2BvbOqRIIL4ofXyF4TdmMS5E5viTepUANt8rduIxZeEktSR66FAEaSG3eYB
	qhqKoQHw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qy4bA-008pb4-2g;
	Wed, 01 Nov 2023 06:21:04 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/15] fast_dput(): new rules for refcount
Date: Wed,  1 Nov 2023 06:20:52 +0000
Message-Id: <20231101062104.2104951-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231101062104.2104951-1-viro@zeniv.linux.org.uk>
References: <20231031061226.GC1957730@ZenIV>
 <20231101062104.2104951-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Currently the "need caller to do more work" path in fast_dput()
has refcount decremented, then, with ->d_lock held and
refcount verified to have reached 0 fast_dput() forcibly resets
the refcount to 1.

Move that resetting refcount to 1 into the callers; later in
the series it will be massaged out of existence.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index ddc534b39c22..4108312f2426 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -847,13 +847,6 @@ static inline bool fast_dput(struct dentry *dentry)
 		spin_unlock(&dentry->d_lock);
 		return true;
 	}
-
-	/*
-	 * Re-get the reference we optimistically dropped. We hold the
-	 * lock, and we just tested that it was zero, so we can just
-	 * set it to 1.
-	 */
-	dentry->d_lockref.count = 1;
 	return false;
 }
 
@@ -896,6 +889,7 @@ void dput(struct dentry *dentry)
 		}
 
 		/* Slow case: now with the dentry lock held */
+		dentry->d_lockref.count = 1;
 		rcu_read_unlock();
 
 		if (likely(retain_dentry(dentry))) {
@@ -930,6 +924,7 @@ void dput_to_list(struct dentry *dentry, struct list_head *list)
 		return;
 	}
 	rcu_read_unlock();
+	dentry->d_lockref.count = 1;
 	if (!retain_dentry(dentry))
 		__dput_to_list(dentry, list);
 	spin_unlock(&dentry->d_lock);
-- 
2.39.2


