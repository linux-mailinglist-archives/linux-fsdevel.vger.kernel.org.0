Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AEA408400
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 07:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbhIMFtI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 01:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbhIMFtH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:49:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764D4C061574;
        Sun, 12 Sep 2021 22:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=GBo5Rz+WJXS0VW8m3fPXrsQLeRaC3/dTvflymAX4JWU=; b=MztTY+PAdeihgiwb7bWszYZcpx
        UvuQSQySzGxh6Iwkq0KI7oGGaZdmrljC2x77LIWGoh4z4wP5hIklvwzptVsfJ19uGuFQ5nMAZ/swn
        cxT49bGlIRjl5c9eaegBB+xR1CAChlBQXdb8OcEEvacFYtsZS2rs7BBKz45GNx3nQxI6s1wqqyRSX
        3mjiIBLIOup5Om6fdAwAx+nvkbLK0SWAU1r+Oel1QluM3El8+TSSPH6tdEGSW5itCWoZQHc6+jLhG
        qeAQ5t7+9jMFdUNTN7P6ddMlwEvmB4VuebzQxar8Oqk0xAPCCpq/G2JtvWEpAZzSZb91kDMtOrGrn
        drIc8eBA==;
Received: from 089144214237.atnat0023.highway.a1.net ([89.144.214.237] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPen2-00DChO-Tp; Mon, 13 Sep 2021 05:46:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] sysfs: refactor sysfs_add_file_mode_ns
Date:   Mon, 13 Sep 2021 07:41:13 +0200
Message-Id: <20210913054121.616001-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913054121.616001-1-hch@lst.de>
References: <20210913054121.616001-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Regroup the code so that preallocated attributes and normal attributes are
handled in clearly separate blocks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/sysfs/file.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index f737bd61f71bf..74a2a8021c8bb 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -261,7 +261,7 @@ int sysfs_add_file_mode_ns(struct kernfs_node *parent,
 	struct kobject *kobj = parent->priv;
 	const struct sysfs_ops *sysfs_ops = kobj->ktype->sysfs_ops;
 	struct lock_class_key *key = NULL;
-	const struct kernfs_ops *ops;
+	const struct kernfs_ops *ops = NULL;
 	struct kernfs_node *kn;
 
 	/* every kobject with an attribute needs a ktype assigned */
@@ -270,22 +270,23 @@ int sysfs_add_file_mode_ns(struct kernfs_node *parent,
 			kobject_name(kobj)))
 		return -EINVAL;
 
-	if (sysfs_ops->show && sysfs_ops->store) {
-		if (mode & SYSFS_PREALLOC)
+	if (mode & SYSFS_PREALLOC) {
+		if (sysfs_ops->show && sysfs_ops->store)
 			ops = &sysfs_prealloc_kfops_rw;
-		else
-			ops = &sysfs_file_kfops_rw;
-	} else if (sysfs_ops->show) {
-		if (mode & SYSFS_PREALLOC)
+		else if (sysfs_ops->show)
 			ops = &sysfs_prealloc_kfops_ro;
-		else
-			ops = &sysfs_file_kfops_ro;
-	} else if (sysfs_ops->store) {
-		if (mode & SYSFS_PREALLOC)
+		else if (sysfs_ops->store)
 			ops = &sysfs_prealloc_kfops_wo;
-		else
+	} else {
+		if (sysfs_ops->show && sysfs_ops->store)
+			ops = &sysfs_file_kfops_rw;
+		else if (sysfs_ops->show)
+			ops = &sysfs_file_kfops_ro;
+		else if (sysfs_ops->store)
 			ops = &sysfs_file_kfops_wo;
-	} else
+	}
+
+	if (!ops)
 		ops = &sysfs_file_kfops_empty;
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-- 
2.30.2

