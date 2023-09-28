Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAD77B19BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjI1LFm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjI1LEp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:04:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9081BF;
        Thu, 28 Sep 2023 04:04:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076DEC433C8;
        Thu, 28 Sep 2023 11:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899082;
        bh=HiIKHh5EcW/iS72FPhqe/DHHFDkon2IkVvSanOATOiU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=m4E24nlcsoUVf3iXi3sNHBBkxoN5T5YrnZm9acWarGGWm0NqFknQHcE37lDrpXATf
         dVapd/Mu1gNACYrTYBPTtLxfANwQ1c953/lWmA85n8KnOr6mcQk07SiT/nliArch6e
         YRyJvdz5tWja1IunIUcGDzt7oIiefCDmfljgyunhH6JvjkeCvtsgt7cmGlCcvpov7u
         BvRPRSmMvsZr9Ih0bKoev3o1OQcgS5vV8nkjlu8BOCZ9j/56bqLKRCfjfmaFm7kXJG
         3Klbm+EI65J2J16Tg3oOSy0O6a2SI49BWTDnqbsqJXlmzMxbTVCe/SYpOKQvTa1HDC
         RBzotlpNnbbAA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 26/87] fs/cramfs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:35 -0400
Message-ID: <20230928110413.33032-25-jlayton@kernel.org>
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
 fs/cramfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 5ee7d7bbb361..9168b2ec9497 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -133,8 +133,8 @@ static struct inode *get_cramfs_inode(struct super_block *sb,
 	}
 
 	/* Struct copy intentional */
-	inode->i_mtime = inode->i_atime = inode_set_ctime_to_ts(inode,
-								zerotime);
+	inode_set_mtime_to_ts(inode,
+			      inode_set_atime_to_ts(inode, inode_set_ctime_to_ts(inode, zerotime)));
 	/* inode->i_nlink is left 1 - arguably wrong for directories,
 	   but it's the best we can do without reading the directory
 	   contents.  1 yields the right result in GNU find, even
-- 
2.41.0

