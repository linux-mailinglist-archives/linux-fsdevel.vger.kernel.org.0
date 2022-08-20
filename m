Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E17659AF6B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 20:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiHTSNK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 14:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiHTSNA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:13:00 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63EF40BCD
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Aug 2022 11:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
        Cc:Content-Type:Content-ID:Content-Description;
        bh=57bohfMjI+JVDHrAtuIJnC/06bjrgHYmEcEeHZKAWaQ=; b=l20wjLTyKXuO0vBNV1C7v39ZRY
        ut7aayAS/1EJUGMecGbSqSVghupwig3yDK8+4oqST3T4Yz291/tTFClouXuiZPVrOjjJDGtESDOdV
        HhR9Qh4ON/DvQEtyvJt8AJMnQlQ/MAIe30T2jtsGSzxfn9PAsTbnyvMPZjbfs2IF8YULAkZUL5DJu
        9ysDQpMmsst6rahf9gCJEJOLsNr/u3pmIFu/VcUlWkBM1ppczMN8TdQrxtuuAQeVsXDzad/OL/qLr
        QiUODX1/lYqqP0FH24jbdm2lISL1RfcEwD3D0xlV2AiqqaVpuJJicaHPOz2YWbK+9+h5gNH/U3FAb
        XqkO0pIA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPSxt-006RW3-Hn
        for linux-fsdevel@vger.kernel.org;
        Sat, 20 Aug 2022 18:12:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/11] nd_jump_link(): constify path
Date:   Sat, 20 Aug 2022 19:12:54 +0100
Message-Id: <20220820181256.1535714-8-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220820181256.1535714-1-viro@zeniv.linux.org.uk>
References: <YwEjnoTgi7K6iijN@ZenIV>
 <20220820181256.1535714-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c            | 2 +-
 include/linux/namei.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 6a5ab1a6f01b..8533087e5dac 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -986,7 +986,7 @@ static int nd_jump_root(struct nameidata *nd)
  * Helper to directly jump to a known parsed path from ->get_link,
  * caller must have taken a reference to path beforehand.
  */
-int nd_jump_link(struct path *path)
+int nd_jump_link(const struct path *path)
 {
 	int error = -ELOOP;
 	struct nameidata *nd = current->nameidata;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index caeb08a98536..00fee52df842 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -83,7 +83,7 @@ extern int follow_up(struct path *);
 extern struct dentry *lock_rename(struct dentry *, struct dentry *);
 extern void unlock_rename(struct dentry *, struct dentry *);
 
-extern int __must_check nd_jump_link(struct path *path);
+extern int __must_check nd_jump_link(const struct path *path);
 
 static inline void nd_terminate_link(void *name, size_t len, size_t maxlen)
 {
-- 
2.30.2

