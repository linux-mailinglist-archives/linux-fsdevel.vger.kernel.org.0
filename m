Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75577B8C08
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244855AbjJDSy4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244682AbjJDSyj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD29A10C1;
        Wed,  4 Oct 2023 11:54:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A5FC433C9;
        Wed,  4 Oct 2023 18:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445649;
        bh=VkAfakFbY6ou3c5RDJgTwIvdzPUdIonMnNTFVcvTr1M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Hy5MtmzKQjrJyQih03qiOmAzQIiVH8DW64l0nVh70slcGif6PG7Ug71JsbGxnFIik
         xtTdcAFC/LGP8VBQGH/PsgGNWnOlwQhl3I2fcWDc6YTQxInbopfyMj995+dah3RyuD
         8ltfqUlBFHNfQiWTiDrMs3zQBzpqdD/H52Sn8KTjEWUWtRupTawcOymrStA+hEc/ua
         yo3RWbzy+AaXjBRTblSCEc7uCO4Ia6VMDmYwzhDGh5hHvY+J0g4HLpiQgwYVVdEgDL
         eAOlAoOUqCxiXr3QDNo1Xpo/yZKsXj5hUBftSPdg72AaTXCU1cEBZHdpSiHx3uWia0
         4LwYX08UDZPiw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 21/89] befs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:06 -0400
Message-ID: <20231004185347.80880-19-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004185347.80880-1-jlayton@kernel.org>
References: <20231004185221.80802-1-jlayton@kernel.org>
 <20231004185347.80880-1-jlayton@kernel.org>
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

Convert to using the new inode timestamp accessor functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/befs/linuxvfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 9a16a51fbb88..9acdec56f626 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -360,11 +360,11 @@ static struct inode *befs_iget(struct super_block *sb, unsigned long ino)
 	 * for indexing purposes. (PFD, page 54)
 	 */
 
-	inode->i_mtime.tv_sec =
-	    fs64_to_cpu(sb, raw_inode->last_modified_time) >> 16;
-	inode->i_mtime.tv_nsec = 0;   /* lower 16 bits are not a time */
-	inode_set_ctime_to_ts(inode, inode->i_mtime);
-	inode->i_atime = inode->i_mtime;
+	inode_set_mtime(inode,
+			fs64_to_cpu(sb, raw_inode->last_modified_time) >> 16,
+			0);/* lower 16 bits are not a time */
+	inode_set_ctime_to_ts(inode, inode_get_mtime(inode));
+	inode_set_atime_to_ts(inode, inode_get_mtime(inode));
 
 	befs_ino->i_inode_num = fsrun_to_cpu(sb, raw_inode->inode_num);
 	befs_ino->i_parent = fsrun_to_cpu(sb, raw_inode->parent);
-- 
2.41.0

