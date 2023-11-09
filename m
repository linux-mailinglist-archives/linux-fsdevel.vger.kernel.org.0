Return-Path: <linux-fsdevel+bounces-2471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5177E63B3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 07:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B70A1C20831
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 06:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23A3DDBF;
	Thu,  9 Nov 2023 06:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QuSktSDN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8062D2E5
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 06:20:58 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E3326AF
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 22:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Rm89adE/IWmDu4t0PfcRUSn6EmnV0P6FUJX93O3jV1U=; b=QuSktSDNnGBJ4VwdhG07PxRezu
	GPJaCGYa4TLTOR+k97K2dKDC/bFPrB0jtiYebWWXpu/vIxcSmMW+fUjPnEcVH+Eo+JpGQQhZTuWAJ
	yyB8iUVAk2lIqpgSGAbwoD6ewiIP+iiK4cjZEn0VIwneHK/b7oCR27EqjvkxeHVxutfJQxc3LoCJl
	6VztF3Kcw+9sXfBPVCQlkYrvJxRnvAOb6I/GdSVAdHtO1YiryKKVaU+N0S72H8KYiod/Rzwmo0G96
	JkXD9o5kfRys+n4PIq4FXLSuNpWbRsZ3PYK2lgh9WPiU5mc3HgPNa0wqlgziTtu1gVAHEBOCI4Md9
	5PqORTHQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0yPQ-00DLjA-1w;
	Thu, 09 Nov 2023 06:20:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 03/22] coda_flag_children(): cope with dentries turning negative
Date: Thu,  9 Nov 2023 06:20:37 +0000
Message-Id: <20231109062056.3181775-3-viro@zeniv.linux.org.uk>
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

->d_lock on parent does not stabilize ->d_inode of child.
We don't do much with that inode in there, but we need
at least to avoid struct inode getting freed under us...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/coda/cache.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/coda/cache.c b/fs/coda/cache.c
index 3b8c4513118f..bfbc03c6b632 100644
--- a/fs/coda/cache.c
+++ b/fs/coda/cache.c
@@ -92,13 +92,16 @@ static void coda_flag_children(struct dentry *parent, int flag)
 {
 	struct dentry *de;
 
+	rcu_read_lock();
 	spin_lock(&parent->d_lock);
 	list_for_each_entry(de, &parent->d_subdirs, d_child) {
+		struct inode *inode = d_inode_rcu(de);
 		/* don't know what to do with negative dentries */
-		if (d_inode(de) ) 
-			coda_flag_inode(d_inode(de), flag);
+		if (inode)
+			coda_flag_inode(inode, flag);
 	}
 	spin_unlock(&parent->d_lock);
+	rcu_read_unlock();
 	return; 
 }
 
-- 
2.39.2


