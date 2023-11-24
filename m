Return-Path: <linux-fsdevel+bounces-3598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF3A7F6BE7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C541C20AB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 06:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3AB4C8C;
	Fri, 24 Nov 2023 06:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bzl/4PNt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03554D71;
	Thu, 23 Nov 2023 22:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=t2zwzPnF/uf/2oUVGi0n4GR0yi2cLzOWPO2ZTLid9cY=; b=bzl/4PNtx7A7UmHIJuWGbYesMX
	3YBns84+Z3wUeS19etV4FUGGskdaoSPZZ35wqX46z7gSRPDYGO09ETLKALzHsMUpqgLREz9q0zQAe
	08WzGcqFC7Bi49RK/90zKSBklXfKYhGySNc+hKFExGVBZsrUs7s7izI6Vx+kZsSWNygX4FXQjNjNV
	vZZRweGyBQIBWerpNK4ZPB/B9VGGWObgYRhBcuhAax6GJ0tWuYJl+0TEWJ6uCI6d8b4JKlHvG7Czz
	+oj0fsYCrvfQ/CbVELuI3K5rNQoGe8TU4fdy36JTMIo7YLRuP7p//WL91yRdqbr+nP0QBvbH5ClMg
	Au1GWXRw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6PIc-002Ptf-25;
	Fri, 24 Nov 2023 06:04:22 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/21] coda_flag_children(): cope with dentries turning negative
Date: Fri, 24 Nov 2023 06:04:03 +0000
Message-Id: <20231124060422.576198-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124060422.576198-1-viro@zeniv.linux.org.uk>
References: <20231124060200.GR38156@ZenIV>
 <20231124060422.576198-1-viro@zeniv.linux.org.uk>
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

Reviewed-by: Christian Brauner <brauner@kernel.org>
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


