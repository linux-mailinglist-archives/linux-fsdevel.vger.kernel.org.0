Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F13981757C7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 10:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgCBJ5U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 04:57:20 -0500
Received: from mx04.melco.co.jp ([192.218.140.144]:56378 "EHLO
        mx04.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbgCBJ5U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:57:20 -0500
Received: from mr04.melco.co.jp (mr04 [133.141.98.166])
        by mx04.melco.co.jp (Postfix) with ESMTP id 85D453A398E;
        Mon,  2 Mar 2020 18:57:18 +0900 (JST)
Received: from mr04.melco.co.jp (unknown [127.0.0.1])
        by mr04.imss (Postfix) with ESMTP id 48WFtQ3R5hzRk9s;
        Mon,  2 Mar 2020 18:57:18 +0900 (JST)
Received: from mf03_second.melco.co.jp (unknown [192.168.20.183])
        by mr04.melco.co.jp (Postfix) with ESMTP id 48WFtQ36lTzRk9l;
        Mon,  2 Mar 2020 18:57:18 +0900 (JST)
Received: from mf03.melco.co.jp (unknown [133.141.98.183])
        by mf03_second.melco.co.jp (Postfix) with ESMTP id 48WFtQ2js7zRkFV;
        Mon,  2 Mar 2020 18:57:18 +0900 (JST)
Received: from tux532.tad.melco.co.jp (unknown [133.141.243.226])
        by mf03.melco.co.jp (Postfix) with ESMTP id 48WFtQ2CcFzRk86;
        Mon,  2 Mar 2020 18:57:18 +0900 (JST)
Received:  from tux532.tad.melco.co.jp
        by tux532.tad.melco.co.jp (unknown) with ESMTP id 0229vINH027655;
        Mon, 2 Mar 2020 18:57:18 +0900
Received: from tux390.tad.melco.co.jp (tux390.tad.melco.co.jp [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 1D34317E075;
        Mon,  2 Mar 2020 18:57:18 +0900 (JST)
Received: from tux554.tad.melco.co.jp (tadpost1.tad.melco.co.jp [10.168.7.223])
        by tux390.tad.melco.co.jp (Postfix) with ESMTP id 07A3617E073;
        Mon,  2 Mar 2020 18:57:18 +0900 (JST)
Received: from tux554.tad.melco.co.jp
        by tux554.tad.melco.co.jp (unknown) with ESMTP id 0229vH0s007040;
        Mon, 2 Mar 2020 18:57:17 +0900
From:   Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp
Cc:     Mori.Takahiro@ab.MitsubishiElectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: exfat: clean up d_entry rebuilding.
Date:   Mon,  2 Mar 2020 18:57:15 +0900
Message-Id: <20200302095716.64155-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Clean up d_entry rebuilding in exfat_rename_file() and move_file().

-Replace memcpy of d_entry with structure copy.
-Change to use the value already stored in fid.

Signed-off-by: Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
---
 drivers/staging/exfat/exfat_core.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index ceaea1ba1a83..374a4fe183f5 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -2285,12 +2285,10 @@ s32 exfat_rename_file(struct inode *inode, struct chain_t *p_dir, s32 oldentry,
 			return -ENOENT;
 		}
 
-		memcpy((void *)epnew, (void *)epold, DENTRY_SIZE);
-		if (exfat_get_entry_type(epnew) == TYPE_FILE) {
-			exfat_set_entry_attr(epnew,
-					     exfat_get_entry_attr(epnew) |
-					     ATTR_ARCHIVE);
+		*epnew = *epold;
+		if (fid->type == TYPE_FILE) {
 			fid->attr |= ATTR_ARCHIVE;
+			exfat_set_entry_attr(epnew, fid->attr);
 		}
 		exfat_buf_modify(sb, sector_new);
 		exfat_buf_unlock(sb, sector_old);
@@ -2306,7 +2304,7 @@ s32 exfat_rename_file(struct inode *inode, struct chain_t *p_dir, s32 oldentry,
 			return -ENOENT;
 		}
 
-		memcpy((void *)epnew, (void *)epold, DENTRY_SIZE);
+		*epnew = *epold;
 		exfat_buf_modify(sb, sector_new);
 		exfat_buf_unlock(sb, sector_old);
 
@@ -2319,11 +2317,9 @@ s32 exfat_rename_file(struct inode *inode, struct chain_t *p_dir, s32 oldentry,
 				       num_old_entries);
 		fid->entry = newentry;
 	} else {
-		if (exfat_get_entry_type(epold) == TYPE_FILE) {
-			exfat_set_entry_attr(epold,
-					     exfat_get_entry_attr(epold) |
-					     ATTR_ARCHIVE);
+		if (fid->type == TYPE_FILE) {
 			fid->attr |= ATTR_ARCHIVE;
+			exfat_set_entry_attr(epold, fid->attr);
 		}
 		exfat_buf_modify(sb, sector_old);
 		exfat_buf_unlock(sb, sector_old);
@@ -2387,11 +2383,10 @@ s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
 		return -ENOENT;
 	}
 
-	memcpy((void *)epnew, (void *)epmov, DENTRY_SIZE);
-	if (exfat_get_entry_type(epnew) == TYPE_FILE) {
-		exfat_set_entry_attr(epnew, exfat_get_entry_attr(epnew) |
-				     ATTR_ARCHIVE);
+	*epnew = *epmov;
+	if (fid->type == TYPE_FILE) {
 		fid->attr |= ATTR_ARCHIVE;
+		exfat_set_entry_attr(epnew, fid->attr);
 	}
 	exfat_buf_modify(sb, sector_new);
 	exfat_buf_unlock(sb, sector_mov);
@@ -2406,7 +2401,7 @@ s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
 		return -ENOENT;
 	}
 
-	memcpy((void *)epnew, (void *)epmov, DENTRY_SIZE);
+	*epnew = *epmov;
 	exfat_buf_modify(sb, sector_new);
 	exfat_buf_unlock(sb, sector_mov);
 
-- 
2.25.1

