Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D024083F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 07:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbhIMFqO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 01:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhIMFqN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:46:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E82EC061574;
        Sun, 12 Sep 2021 22:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Ead5soR/lTgjqzqfyJo+0XLeX5YYtl6XszNEzk7rFcc=; b=rrFWlG4Td8osfc6LGxB41SYepr
        I+FpY/FuvfTFd0PmS1ErhC+iCp84e1gZ9ha5MztwtIeju6eVHf70fACStB5hTvoLc+FnfrDOTFjyj
        KXFUOW1zsmm0NtvtfR2y9fdPvSkzrqh/jFLII6uuRQlsntOmytgBGNCJkh7QMG0HreUO8mPJVjnBG
        4Ajo+2CLcaF0wN2UGnhio2eNXixRPbzh2SqXZBhJAE2lFLjzL/RPhQs4/uquHW+G2H9teBsNcafa0
        LS8MQG4uQxklnoy21LqZdi2lJqcJ+q8exgpehEEAEsalZLWu7EYQlg6I2JiMi4rFKFbius205B4bB
        uOVZn+xA==;
Received: from 089144214237.atnat0023.highway.a1.net ([89.144.214.237] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPek1-00DCX1-SD; Mon, 13 Sep 2021 05:43:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] kernfs: remove kernfs_create_file and kernfs_create_file_ns
Date:   Mon, 13 Sep 2021 07:41:10 +0200
Message-Id: <20210913054121.616001-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913054121.616001-1-hch@lst.de>
References: <20210913054121.616001-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All callers actually use __kernfs_create_file.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/kernfs.h | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 1093abf7c28cc..cecfeedb7361d 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -568,30 +568,6 @@ kernfs_create_dir(struct kernfs_node *parent, const char *name, umode_t mode,
 				    priv, NULL);
 }
 
-static inline struct kernfs_node *
-kernfs_create_file_ns(struct kernfs_node *parent, const char *name,
-		      umode_t mode, kuid_t uid, kgid_t gid,
-		      loff_t size, const struct kernfs_ops *ops,
-		      void *priv, const void *ns)
-{
-	struct lock_class_key *key = NULL;
-
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	key = (struct lock_class_key *)&ops->lockdep_key;
-#endif
-	return __kernfs_create_file(parent, name, mode, uid, gid,
-				    size, ops, priv, ns, key);
-}
-
-static inline struct kernfs_node *
-kernfs_create_file(struct kernfs_node *parent, const char *name, umode_t mode,
-		   loff_t size, const struct kernfs_ops *ops, void *priv)
-{
-	return kernfs_create_file_ns(parent, name, mode,
-				     GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
-				     size, ops, priv, NULL);
-}
-
 static inline int kernfs_remove_by_name(struct kernfs_node *parent,
 					const char *name)
 {
-- 
2.30.2

