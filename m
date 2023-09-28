Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5A87B1A25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjI1LJj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjI1LI5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:08:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33021FFA;
        Thu, 28 Sep 2023 04:05:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA6DC433C7;
        Thu, 28 Sep 2023 11:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899126;
        bh=Ss7nLMp7jLyE6miSYsprdXK+tzY89Wa3eXUpvyW77Ug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GB2bi8+hguQ/MH1kAXUuU1IWliWyqT+gj6ORqRdaqWx//xKgrh1/giZmmtA0PgxlV
         rCEHfaQ13m8Us+1ADvEN2ugG/nb4keyAFRhGOm8yKDERmEeTsYGpKW0iWqBcVYtpzx
         krqs7C229KDYWJBITkNxFK6MQepOt2qb1WwCSbwl5WuLVo2d2dBUoC3xqX+7WG+pyz
         H8jUEK3UgzBkIVDoCUuUYqpNu6hqefcY/Uztmbu/pzphpYJtazLsEiWG5IOvsND2rX
         YglEz/g6FYTpmXddC01mx+F9+X+DITp17pceumXx3RkrGO17iP3ezLmJMG5F2SBnCM
         NhjlPxSnCmeRg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 61/87] fs/pstore: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:03:10 -0400
Message-ID: <20230928110413.33032-60-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928110413.33032-1-jlayton@kernel.org>
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/pstore/inode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 585360706b33..d41c20d1b5e8 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -223,7 +223,7 @@ static struct inode *pstore_get_inode(struct super_block *sb)
 	struct inode *inode = new_inode(sb);
 	if (inode) {
 		inode->i_ino = get_next_ino();
-		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+		simple_inode_init_ts(inode);
 	}
 	return inode;
 }
@@ -390,7 +390,8 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 	inode->i_private = private;
 
 	if (record->time.tv_sec)
-		inode->i_mtime = inode_set_ctime_to_ts(inode, record->time);
+		inode_set_mtime_to_ts(inode,
+				      inode_set_ctime_to_ts(inode, record->time));
 
 	d_add(dentry, inode);
 
-- 
2.41.0

