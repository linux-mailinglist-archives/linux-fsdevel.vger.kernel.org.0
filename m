Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABFE78E5AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 07:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244841AbjHaFcO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 01:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242275AbjHaFcL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 01:32:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CDCEA;
        Wed, 30 Aug 2023 22:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6ZUj32/PTbxNw9fN09aB0Fs8C0WjT/MBpy99lMcm6/0=; b=yzV37OHPCzxMFnuDnoUqS8QumA
        IxO19XW/q9voEFo2pX/TJRlTe1RS7UDaJlgVDTOum4afo1MSJsv3mekBxlrJFbXWCLriUPXAz3WmD
        4+2h5ESKDySXMClmV4CxwdsBLoR/dLuJUBwd6jajvhJMHsKfNnXbMwQ/ZTB4Hs5w0iiEyHhIycN2p
        cAcLzJQ4gGWA9ozx/8grn8SBUZgaDkHRGpld51okHyqMQ8pDBHsiTVMj/fhGhl8ogBh7Xbq20y7O+
        BAL4mObaJr/d7M/2VORadnQMcLitFKkkbtEq6ShqF0m1GymAo9OPsMiiRYrm/cVBPaDo2TItw6mTa
        VqY+IBPA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qbaHk-00EglC-1e;
        Thu, 31 Aug 2023 05:32:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
Subject: [PATCH 1/4] ramfs: free sb->s_fs_info after shutting down the super block
Date:   Thu, 31 Aug 2023 07:31:54 +0200
Message-Id: <20230831053157.256319-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230831053157.256319-1-hch@lst.de>
References: <20230831053157.256319-1-hch@lst.de>
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

sb->s_fs_info can only be safely freed after generic_shutdown_super was
called and all access to the super_block has stopped.

Thus only free the private data after calling kill_litter_super, which
calls generic_shutdown_super internally.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ramfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 18e8387cab4148..0f37ecbae59dad 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -280,8 +280,8 @@ int ramfs_init_fs_context(struct fs_context *fc)
 
 void ramfs_kill_sb(struct super_block *sb)
 {
-	kfree(sb->s_fs_info);
 	kill_litter_super(sb);
+	kfree(sb->s_fs_info);
 }
 
 static struct file_system_type ramfs_fs_type = {
-- 
2.39.2

