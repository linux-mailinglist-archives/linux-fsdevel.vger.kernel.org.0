Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB81748CB0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbjGETDT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbjGETDR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:03:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F7C198D;
        Wed,  5 Jul 2023 12:03:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE7CD616CB;
        Wed,  5 Jul 2023 19:03:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745EFC433C7;
        Wed,  5 Jul 2023 19:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583791;
        bh=wRIPLE3X7SYZpESEXOLs3yn+7zQ1CKcV/+ZcwAoq978=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FTpannEKxF9FGAXqisIULH/0wrvQYdzHRZ7wioY4D/6BRm1At1RMDBI9nCtFVC1tG
         ob+ED//wty7dcQ3OMD1HQhRJipfA+/FvAA6M28L0kfISCXzGvVF/l9x6xA7vzhadRB
         V0htXWbgmNLzWkAKRGLBiRvjF6B1Kflj2KBTIjpD9zfWJzD8em5bFYPPdpqBSp5jEK
         +fE6bGti3cPOeIwU1oYVj4T6e92p8EVTt2IOAFx2tNbVpTBWT5rBLFRWNIAe9mS2j+
         3S85FBxdlFtI26S8B1l8DLl2CXJKg67qcaNAU6LIlaeKIb/Gs+5LvecQTxBW0sITap
         zVcAWLDXGBlmw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Brad Warrum <bwarrum@linux.ibm.com>,
        Ritu Agarwal <rituagar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/92] ibmvmc: update ctime in conjunction with mtime on write
Date:   Wed,  5 Jul 2023 15:00:28 -0400
Message-ID: <20230705190309.579783-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705185755.579053-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

POSIX says:

"Upon successful completion, where nbyte is greater than 0, write()
 shall mark for update the last data modification and last file status
 change timestamps of the file..."

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 drivers/misc/ibmvmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/ibmvmc.c b/drivers/misc/ibmvmc.c
index cbaf6d35e854..d7c7f0305257 100644
--- a/drivers/misc/ibmvmc.c
+++ b/drivers/misc/ibmvmc.c
@@ -1124,7 +1124,7 @@ static ssize_t ibmvmc_write(struct file *file, const char *buffer,
 		goto out;
 
 	inode = file_inode(file);
-	inode->i_mtime = current_time(inode);
+	inode->i_mtime = inode->i_ctime = current_time(inode);
 	mark_inode_dirty(inode);
 
 	dev_dbg(adapter->dev, "write: file = 0x%lx, count = 0x%lx\n",
-- 
2.41.0

