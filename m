Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E1259AF6F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 20:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiHTSNM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 14:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiHTSNA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:13:00 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1234D3FA3C
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Aug 2022 11:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
        Cc:Content-Type:Content-ID:Content-Description;
        bh=NLg9UVGBznmF4980Y7eEsVF/DmEu0JD82psvq/EDnC0=; b=rP0CVh6h7nhQzkV/AErUIhWar/
        LzlHbNgoxYB5WaGFgbyLIV1jeYIvEdywL0BQP46xqhA5g74fJw0uQ2M8Ri2fIk3zwMcdte3Ps6zBS
        tYjla41VOk40LUsBAvcvhIpBYXlVKN+M9KVmTgaJxwSZ5/WPkXKmsr8z0bvJzVsNHDyrd84fFh1N7
        02wB/2mCREYeTFMdZSlpn2r06X/jHkUfYEEe4P+smtvTtSyyfceTlveL7Im27C3Ka7fQrEDa52cHQ
        mkb6/VIw9QfOpsTQPwP24DvDvVjklOJVJw0Mk1XbBMXeSs20o5kAl7C5yT1Y3GYU2vG94MPNeX83E
        ZDANRReA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPSxt-006RW6-Lz
        for linux-fsdevel@vger.kernel.org;
        Sat, 20 Aug 2022 18:12:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/11] spufs: constify path
Date:   Sat, 20 Aug 2022 19:12:55 +0100
Message-Id: <20220820181256.1535714-9-viro@zeniv.linux.org.uk>
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
 arch/powerpc/platforms/cell/spufs/inode.c | 6 +++---
 arch/powerpc/platforms/cell/spufs/spufs.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 320008528edd..dbcfe361831a 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -275,7 +275,7 @@ spufs_mkdir(struct inode *dir, struct dentry *dentry, unsigned int flags,
 	return ret;
 }
 
-static int spufs_context_open(struct path *path)
+static int spufs_context_open(const struct path *path)
 {
 	int ret;
 	struct file *filp;
@@ -491,7 +491,7 @@ spufs_mkgang(struct inode *dir, struct dentry *dentry, umode_t mode)
 	return ret;
 }
 
-static int spufs_gang_open(struct path *path)
+static int spufs_gang_open(const struct path *path)
 {
 	int ret;
 	struct file *filp;
@@ -536,7 +536,7 @@ static int spufs_create_gang(struct inode *inode,
 
 static struct file_system_type spufs_type;
 
-long spufs_create(struct path *path, struct dentry *dentry,
+long spufs_create(const struct path *path, struct dentry *dentry,
 		unsigned int flags, umode_t mode, struct file *filp)
 {
 	struct inode *dir = d_inode(path->dentry);
diff --git a/arch/powerpc/platforms/cell/spufs/spufs.h b/arch/powerpc/platforms/cell/spufs/spufs.h
index 23c6799cfa5a..af048b6dd30a 100644
--- a/arch/powerpc/platforms/cell/spufs/spufs.h
+++ b/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -232,7 +232,7 @@ extern const struct spufs_tree_descr spufs_dir_debug_contents[];
 extern struct spufs_calls spufs_calls;
 struct coredump_params;
 long spufs_run_spu(struct spu_context *ctx, u32 *npc, u32 *status);
-long spufs_create(struct path *nd, struct dentry *dentry, unsigned int flags,
+long spufs_create(const struct path *nd, struct dentry *dentry, unsigned int flags,
 			umode_t mode, struct file *filp);
 /* ELF coredump callbacks for writing SPU ELF notes */
 extern int spufs_coredump_extra_notes_size(void);
-- 
2.30.2

