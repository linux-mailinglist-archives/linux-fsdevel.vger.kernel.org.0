Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223CD6B849B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Mar 2023 23:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjCMWPB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Mar 2023 18:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjCMWPB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Mar 2023 18:15:01 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FA566D30;
        Mon, 13 Mar 2023 15:14:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DF4A2CE1155;
        Mon, 13 Mar 2023 22:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CB8C433EF;
        Mon, 13 Mar 2023 22:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678745696;
        bh=xsrnPqp48cSYbDpR2xQdPUoe1QfIQR1l2DoWMI93/3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h5so0pJORZZ/pyCGqikZCM/k9xAq/zJJlrDv0NetzjaqtDW3DGQTi38Nmek69gk3B
         SPIcrEnK2oRkHpO6Qd0b6LkLnRtTEj9DeJvcvX/7bmk6K9oulFdO+G3a5jmH/JRAEr
         xTB8HRmedl7Q5S/oURdm0YmZxXFKS0Fidow+86BnHZT0Kvux8LK3wIBiY1wgkp0vM7
         V2zwPwY/vVh2y3iGL1qodiZj+yOXKhhaE8wuIHKAcPb/MCSepWC9zNC5H0wonxWqJQ
         vLGic1rsLhxBGol4s7L+2ye7fjjVxoAi78yiFGdmXf0suk4+OmXFgMIILeUnzyQDJO
         SGtoPLUCHKh/A==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 2/3] fscrypt: improve fscrypt_destroy_keyring() documentation
Date:   Mon, 13 Mar 2023 15:12:30 -0700
Message-Id: <20230313221231.272498-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313221231.272498-1-ebiggers@kernel.org>
References: <20230313221231.272498-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Document that it must be called after all potentially-encrypted inodes
have been evicted.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/keyring.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index 78086f8dbda52..bb15709ac9a40 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -207,10 +207,11 @@ static int allocate_filesystem_keyring(struct super_block *sb)
  * Release all encryption keys that have been added to the filesystem, along
  * with the keyring that contains them.
  *
- * This is called at unmount time.  The filesystem's underlying block device(s)
- * are still available at this time; this is important because after user file
- * accesses have been allowed, this function may need to evict keys from the
- * keyslots of an inline crypto engine, which requires the block device(s).
+ * This is called at unmount time, after all potentially-encrypted inodes have
+ * been evicted.  The filesystem's underlying block device(s) are still
+ * available at this time; this is important because after user file accesses
+ * have been allowed, this function may need to evict keys from the keyslots of
+ * an inline crypto engine, which requires the block device(s).
  */
 void fscrypt_destroy_keyring(struct super_block *sb)
 {
@@ -227,12 +228,12 @@ void fscrypt_destroy_keyring(struct super_block *sb)
 
 		hlist_for_each_entry_safe(mk, tmp, bucket, mk_node) {
 			/*
-			 * Since all inodes were already evicted, every key
-			 * remaining in the keyring should have an empty inode
-			 * list, and should only still be in the keyring due to
-			 * the single active ref associated with ->mk_secret.
-			 * There should be no structural refs beyond the one
-			 * associated with the active ref.
+			 * Since all potentially-encrypted inodes were already
+			 * evicted, every key remaining in the keyring should
+			 * have an empty inode list, and should only still be in
+			 * the keyring due to the single active ref associated
+			 * with ->mk_secret.  There should be no structural refs
+			 * beyond the one associated with the active ref.
 			 */
 			WARN_ON(refcount_read(&mk->mk_active_refs) != 1);
 			WARN_ON(refcount_read(&mk->mk_struct_refs) != 1);
-- 
2.39.2

