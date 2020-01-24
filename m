Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2BAF1485BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 14:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389247AbgAXNN7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 08:13:59 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57767 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387445AbgAXNN7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 08:13:59 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iuym5-0003aK-Rc; Fri, 24 Jan 2020 14:13:25 +0100
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iuym5-0006ZS-4g; Fri, 24 Jan 2020 14:13:25 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 7/8] ubifs: export get_znode
Date:   Fri, 24 Jan 2020 14:13:22 +0100
Message-Id: <20200124131323.23885-8-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124131323.23885-1-s.hauer@pengutronix.de>
References: <20200124131323.23885-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

get_znode will be needed by upcoming UBIFS quota support. Rename it to
ubifs_get_znode and export it.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/tnc.c   | 32 ++++++++++++++++----------------
 fs/ubifs/ubifs.h |  2 ++
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/fs/ubifs/tnc.c b/fs/ubifs/tnc.c
index e8e7b0e9532e..188fa036e655 100644
--- a/fs/ubifs/tnc.c
+++ b/fs/ubifs/tnc.c
@@ -571,15 +571,15 @@ static int matches_name(struct ubifs_info *c, struct ubifs_zbranch *zbr,
 }
 
 /**
- * get_znode - get a TNC znode that may not be loaded yet.
+ * ubifs_get_znode - get a TNC znode that may not be loaded yet.
  * @c: UBIFS file-system description object
  * @znode: parent znode
  * @n: znode branch slot number
  *
  * This function returns the znode or a negative error code.
  */
-static struct ubifs_znode *get_znode(struct ubifs_info *c,
-				     struct ubifs_znode *znode, int n)
+struct ubifs_znode *ubifs_get_znode(struct ubifs_info *c,
+				    struct ubifs_znode *znode, int n)
 {
 	struct ubifs_zbranch *zbr;
 
@@ -619,11 +619,11 @@ static int tnc_next(struct ubifs_info *c, struct ubifs_znode **zn, int *n)
 		nn = znode->iip + 1;
 		znode = zp;
 		if (nn < znode->child_cnt) {
-			znode = get_znode(c, znode, nn);
+			znode = ubifs_get_znode(c, znode, nn);
 			if (IS_ERR(znode))
 				return PTR_ERR(znode);
 			while (znode->level != 0) {
-				znode = get_znode(c, znode, 0);
+				znode = ubifs_get_znode(c, znode, 0);
 				if (IS_ERR(znode))
 					return PTR_ERR(znode);
 			}
@@ -663,12 +663,12 @@ static int tnc_prev(struct ubifs_info *c, struct ubifs_znode **zn, int *n)
 		nn = znode->iip - 1;
 		znode = zp;
 		if (nn >= 0) {
-			znode = get_znode(c, znode, nn);
+			znode = ubifs_get_znode(c, znode, nn);
 			if (IS_ERR(znode))
 				return PTR_ERR(znode);
 			while (znode->level != 0) {
 				nn = znode->child_cnt - 1;
-				znode = get_znode(c, znode, nn);
+				znode = ubifs_get_znode(c, znode, nn);
 				if (IS_ERR(znode))
 					return PTR_ERR(znode);
 			}
@@ -2572,7 +2572,7 @@ static int tnc_delete(struct ubifs_info *c, struct ubifs_znode *znode, int n)
 		while (znode->child_cnt == 1 && znode->level != 0) {
 			zp = znode;
 			zbr = &znode->zbranch[0];
-			znode = get_znode(c, znode, 0);
+			znode = ubifs_get_znode(c, znode, 0);
 			if (IS_ERR(znode))
 				return PTR_ERR(znode);
 			znode = dirty_cow_znode(c, zbr);
@@ -3096,12 +3096,12 @@ static struct ubifs_znode *left_znode(struct ubifs_info *c,
 			return NULL;
 		if (n >= 0) {
 			/* Now go down the rightmost branch to 'level' */
-			znode = get_znode(c, znode, n);
+			znode = ubifs_get_znode(c, znode, n);
 			if (IS_ERR(znode))
 				return znode;
 			while (znode->level != level) {
 				n = znode->child_cnt - 1;
-				znode = get_znode(c, znode, n);
+				znode = ubifs_get_znode(c, znode, n);
 				if (IS_ERR(znode))
 					return znode;
 			}
@@ -3133,11 +3133,11 @@ static struct ubifs_znode *right_znode(struct ubifs_info *c,
 			return NULL;
 		if (n < znode->child_cnt) {
 			/* Now go down the leftmost branch to 'level' */
-			znode = get_znode(c, znode, n);
+			znode = ubifs_get_znode(c, znode, n);
 			if (IS_ERR(znode))
 				return znode;
 			while (znode->level != level) {
-				znode = get_znode(c, znode, 0);
+				znode = ubifs_get_znode(c, znode, 0);
 				if (IS_ERR(znode))
 					return znode;
 			}
@@ -3222,13 +3222,13 @@ static struct ubifs_znode *lookup_znode(struct ubifs_info *c,
 		}
 		if (znode->level == level + 1)
 			break;
-		znode = get_znode(c, znode, n);
+		znode = ubifs_get_znode(c, znode, n);
 		if (IS_ERR(znode))
 			return znode;
 	}
 	/* Check if the child is the one we are looking for */
 	if (znode->zbranch[n].lnum == lnum && znode->zbranch[n].offs == offs)
-		return get_znode(c, znode, n);
+		return ubifs_get_znode(c, znode, n);
 	/* If the key is unique, there is nowhere else to look */
 	if (!is_hash_key(c, key))
 		return NULL;
@@ -3254,7 +3254,7 @@ static struct ubifs_znode *lookup_znode(struct ubifs_info *c,
 		/* Check it */
 		if (znode->zbranch[n].lnum == lnum &&
 		    znode->zbranch[n].offs == offs)
-			return get_znode(c, znode, n);
+			return ubifs_get_znode(c, znode, n);
 		/* Stop if the key is less than the one we are looking for */
 		if (keys_cmp(c, &znode->zbranch[n].key, key) < 0)
 			break;
@@ -3276,7 +3276,7 @@ static struct ubifs_znode *lookup_znode(struct ubifs_info *c,
 		/* Check it */
 		if (znode->zbranch[n].lnum == lnum &&
 		    znode->zbranch[n].offs == offs)
-			return get_znode(c, znode, n);
+			return ubifs_get_znode(c, znode, n);
 		/* Stop if the key is greater than the one we are looking for */
 		if (keys_cmp(c, &znode->zbranch[n].key, key) > 0)
 			break;
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 16e140420f35..66c7ed0dc610 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -1819,6 +1819,8 @@ int ubifs_find_dirty_idx_leb(struct ubifs_info *c);
 int ubifs_save_dirty_idx_lnums(struct ubifs_info *c);
 
 /* tnc.c */
+struct ubifs_znode *ubifs_get_znode(struct ubifs_info *c,
+				    struct ubifs_znode *znode, int n);
 int ubifs_lookup_level0(struct ubifs_info *c, const union ubifs_key *key,
 			struct ubifs_znode **zn, int *n);
 int ubifs_tnc_lookup_nm(struct ubifs_info *c, const union ubifs_key *key,
-- 
2.25.0

