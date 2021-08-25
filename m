Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2ED3F6FDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Aug 2021 08:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239085AbhHYGwx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Aug 2021 02:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238276AbhHYGwx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Aug 2021 02:52:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202C8C061757;
        Tue, 24 Aug 2021 23:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=KD/Y2l6cTgPnJZCLH93pVyuBhTXpqU5Szg82ODa63NE=; b=vKtJm3dYRIhiic4dGCjlu+1T0f
        ekBkSkvmFu/l5pBLKAcV1Nq7fm1rwHOUrrjlLB/FUOVN+kXQWETSo1KyP10QK2/KzKY7FxL4gtKgV
        I+bM7GIctFvPrCBs9YMvViKv1U+3npH3J/ZuOu9bM1XLW/jZkHwUeUrz3yL28hs4fUxVzTUHDuxOa
        5p29tq9OlILlh5gxxY4eYdWV4W/7eUEKazPUFQqaLTTK9qhPbd7bgj3Y6vQPvi82uPAia6WwyJzrU
        18dnS8iDPs9wSPWxy53qHOmB8f2AcP4fP4QzjqVNFlcuBbRD7rzbwrl5geCGo5IYzfamWO21HifEW
        en98Occw==;
Received: from [2001:4bb8:193:fd10:ce54:74a1:df3f:e6a9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mImkO-00Bzcx-8e; Wed, 25 Aug 2021 06:51:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Joel Becker <jlbec@evilplan.org>
Cc:     Sishuai Gong <sishuai@purdue.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/4] configfs: simplify the configfs_dirent_is_ready
Date:   Wed, 25 Aug 2021 08:49:04 +0200
Message-Id: <20210825064906.1694233-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210825064906.1694233-1-hch@lst.de>
References: <20210825064906.1694233-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Return the error directly instead of using a goto.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/configfs/dir.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index cf08bbde55f3..5d58569f0eea 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -467,9 +467,8 @@ static struct dentry * configfs_lookup(struct inode *dir,
 	 * not complete their initialization, since the dentries of the
 	 * attributes won't be instantiated.
 	 */
-	err = -ENOENT;
 	if (!configfs_dirent_is_ready(parent_sd))
-		goto out;
+		return ERR_PTR(-ENOENT);
 
 	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
 		if (sd->s_type & CONFIGFS_NOT_PINNED) {
@@ -493,7 +492,6 @@ static struct dentry * configfs_lookup(struct inode *dir,
 		return NULL;
 	}
 
-out:
 	return ERR_PTR(err);
 }
 
-- 
2.30.2

