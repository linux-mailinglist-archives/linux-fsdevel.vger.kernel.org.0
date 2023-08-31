Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B090C78E5A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 07:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242925AbjHaF3z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 01:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjHaF3z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 01:29:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E1FE0;
        Wed, 30 Aug 2023 22:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=jy2QIfkb1SiUcs2Z5SbQvY3u75WHmQMCBX/FVC1yq+Y=; b=KawAmdeS5BFUEXFdjkgNXn+OnP
        udAk/rzRY8Kz8MbGIbsUXbYMOCqav6KpIi9H1Fu0fnwuZks97oppH0mESjlU8JZHIlw9zpdxkQXlY
        tYNyKCCnbQYE9/eXK+PeP9Ye8QBQvCmFsnwhAZ+j7vVWqmxYNUeBQs59YSPS6WsOkE2WZ/82/97tQ
        Bh5NU7SE2hum5p79Q+PTaG5v6gJtAKIA7xhargxxjYefYzXBFvGqfvdMTZOlt4pbnnDpxriQKLLUd
        U7oVZcoxIRamhMT0nPnUHY57uFpnACIo4DIGrS9+yacJbA1eC0K/atmOXYM9/WTexQ2DHL5itSnGn
        CCr6snkA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qbaFW-00EgfY-03;
        Thu, 31 Aug 2023 05:29:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     brauner@kernel.org
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org, jack@suse.cz,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] NFS: switch back to using kill_anon_super
Date:   Thu, 31 Aug 2023 07:29:40 +0200
Message-Id: <20230831052940.256193-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NFS switch to open coding kill_anon_super in 7b14a213890a
("nfs: don't call bdi_unregister") to avoid the extra bdi_unregister
call.  At that point bdi_destroy was called in nfs_free_server and
thus it required a later freeing of the anon dev_t.  But since
0db10944a76b ("nfs: Convert to separately allocated bdi") the bdi has
been free implicitly by the sb destruction, so this isn't needed
anymore.

By not open coding kill_anon_super, nfs now inherits the fix in
dc3216b14160 ("super: ensure valid info"), and we remove the only
open coded version of kill_anon_super.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/super.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 2284f749d89246..0d6473cb00cb3e 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1339,15 +1339,13 @@ int nfs_get_tree_common(struct fs_context *fc)
 void nfs_kill_super(struct super_block *s)
 {
 	struct nfs_server *server = NFS_SB(s);
-	dev_t dev = s->s_dev;
 
 	nfs_sysfs_move_sb_to_server(server);
-	generic_shutdown_super(s);
+	kill_anon_super(s);
 
 	nfs_fscache_release_super_cookie(s);
 
 	nfs_free_server(server);
-	free_anon_bdev(dev);
 }
 EXPORT_SYMBOL_GPL(nfs_kill_super);
 
-- 
2.39.2

