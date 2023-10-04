Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2ABC7B8CE0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245164AbjJDS7I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245141AbjJDS5O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:57:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9521419A0;
        Wed,  4 Oct 2023 11:55:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BAAC433C9;
        Wed,  4 Oct 2023 18:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445701;
        bh=pqa40rTt8rF9QxOQy5tzuN4wusDcUHt9LX9OlvRILZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KjK3bPaNQza0AJ9shfnVYLa+KoGvGcGntwREq0i74ILqop4xBxR+fljBXYI7i6f4z
         kHp9cwLgZlN00D9BYEXFpbJPQ4xGcQxPH2GHiTUol0RcSHTY0VZsbrawoJJ/iAmiap
         VLp9gV2S4AXTjokJ45h+JM7ftJHR8aR5HlxddQ/SB6hwhSRLkVw4asefnJ2DfSCmX3
         et91YGW3H2SClI5HkKLGS4csMnAUtpCZL+BKyDFNK9yOHPDiXCScvue61tpa/c+yEv
         HEh5fHcdk43jwHKK/NReGtstrFINfhy1UQ0w40UH5jBa0gK86YwNKccVjVmZMgj7lS
         ENm7U6PAHiJCg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 62/89] pstore: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:47 -0400
Message-ID: <20231004185347.80880-60-jlayton@kernel.org>
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

