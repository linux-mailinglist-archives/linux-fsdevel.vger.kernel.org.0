Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A363F6FD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Aug 2021 08:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239030AbhHYGwD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Aug 2021 02:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238276AbhHYGwC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Aug 2021 02:52:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB6BC061757;
        Tue, 24 Aug 2021 23:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Xgcc93fALZjStOpXyGyFVuh26GCmgHjM5rA7NYirgHw=; b=AmXpTJ8f0x6phT2OIDmygUmAND
        /HAimYCbZwTFWCkVQCjSPdsqPaExkCmnSvVWl6bqrblQS0sUJyk+hDOg1XWSoUPVQykcIVIQx9pSp
        g43kcRxN/FGBsJQ7CfsSD2mJnK/CKSTvST7P5ISsWHQYpJLDJKJzSkL6ymtbhCHoqazwm7pArcPWe
        7f0rkZvrZppDoNLfTYlAkiUtdLBRsN8DrdnzOlMh7tXcazSETnjksQF+EhG1TGJHzywqDbt2yjr6Q
        ut6if0mDeMrDerSTNgoBWq45TjGTfApoyvAt2G98psUIuSZaXzz+sqHLtrWjTcmWPtSa+IJpa0leG
        JTct9eSA==;
Received: from [2001:4bb8:193:fd10:ce54:74a1:df3f:e6a9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mImjN-00Bzaq-Om; Wed, 25 Aug 2021 06:50:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Joel Becker <jlbec@evilplan.org>
Cc:     Sishuai Gong <sishuai@purdue.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] configfs: return -ENAMETOOLONG earlier in configfs_lookup
Date:   Wed, 25 Aug 2021 08:49:03 +0200
Message-Id: <20210825064906.1694233-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210825064906.1694233-1-hch@lst.de>
References: <20210825064906.1694233-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just like most other file systems: get the simple checks out of the
way first.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/configfs/dir.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index ac5e0c0e9181..cf08bbde55f3 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -456,6 +456,9 @@ static struct dentry * configfs_lookup(struct inode *dir,
 	int found = 0;
 	int err;
 
+	if (dentry->d_name.len > NAME_MAX)
+		return ERR_PTR(-ENAMETOOLONG);
+
 	/*
 	 * Fake invisibility if dir belongs to a group/default groups hierarchy
 	 * being attached
@@ -486,8 +489,6 @@ static struct dentry * configfs_lookup(struct inode *dir,
 		 * If it doesn't exist and it isn't a NOT_PINNED item,
 		 * it must be negative.
 		 */
-		if (dentry->d_name.len > NAME_MAX)
-			return ERR_PTR(-ENAMETOOLONG);
 		d_add(dentry, NULL);
 		return NULL;
 	}
-- 
2.30.2

