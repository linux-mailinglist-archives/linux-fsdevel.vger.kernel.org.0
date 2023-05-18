Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5363708053
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 13:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjERLtW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 07:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjERLs0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 07:48:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64D01FF7;
        Thu, 18 May 2023 04:48:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DAFE61B20;
        Thu, 18 May 2023 11:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48507C433A8;
        Thu, 18 May 2023 11:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684410487;
        bh=kquwxLu1RihR3+XLA7F476KPp9MVAZdnWUNISapvPR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bzkIxbhDHURav3gjTbQ2xFZrLyGJSG3Hn9dS+SsLaBnRDDKBLvLERckzR526obwYW
         lvXvMK+Y2sH7weoCTR0SukIJ2OvUY3CI0eOdclclvgDj72X+zOY63Q1hrRGfWK2LP8
         /t1DNOWaVGkaw36xyXe+sbetbfybu6C0m9TJvGHp6CBQLRrPHNGG5JM3sOp6DvxWZy
         SYax8PXtJ+sObAy4nFE0sXQrPOF84NN6/5SMCv89EUxLnC0OPfj6a4X8OnPVNcGta2
         76mu7+on+K28VJdnqfF/QI1nAzBiR/LWfq6xVgGEb9QEPjDQdB18JUg5KlahtUxFP4
         RDVUQQzgybvTw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Neil Brown <neilb@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore T'so <tytso@mit.edu>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH v4 8/9] ext4: convert to multigrain timestamps
Date:   Thu, 18 May 2023 07:47:41 -0400
Message-Id: <20230518114742.128950-9-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518114742.128950-1-jlayton@kernel.org>
References: <20230518114742.128950-1-jlayton@kernel.org>
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ext4/inode.c | 17 +++++++++++++++--
 fs/ext4/super.c |  2 +-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e0bbcf7a07b5..37840aeb7ff9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4235,6 +4235,19 @@ static int ext4_inode_blocks_set(struct ext4_inode *raw_inode,
 	return 0;
 }
 
+static void ext4_inode_set_ctime(struct inode *inode, struct ext4_inode *raw_inode)
+{
+	struct timespec64 ctime = ctime_peek(inode);
+
+	if (EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), i_ctime_extra)) {
+		raw_inode->i_ctime = cpu_to_le32(ctime.tv_sec);
+		raw_inode->i_ctime_extra = ext4_encode_extra_time(&ctime);
+	} else {
+		raw_inode->i_ctime = cpu_to_le32(clamp_t(int32_t,
+					ctime.tv_sec, S32_MIN, S32_MAX));
+	}
+}
+
 static int ext4_fill_raw_inode(struct inode *inode, struct ext4_inode *raw_inode)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
@@ -4275,7 +4288,7 @@ static int ext4_fill_raw_inode(struct inode *inode, struct ext4_inode *raw_inode
 	}
 	raw_inode->i_links_count = cpu_to_le16(inode->i_nlink);
 
-	EXT4_INODE_SET_XTIME(i_ctime, inode, raw_inode);
+	ext4_inode_set_ctime(inode, raw_inode);
 	EXT4_INODE_SET_XTIME(i_mtime, inode, raw_inode);
 	EXT4_INODE_SET_XTIME(i_atime, inode, raw_inode);
 	EXT4_EINODE_SET_XTIME(i_crtime, ei, raw_inode);
@@ -4983,7 +4996,7 @@ static void __ext4_update_other_inode_time(struct super_block *sb,
 		spin_unlock(&inode->i_lock);
 
 		spin_lock(&ei->i_raw_lock);
-		EXT4_INODE_SET_XTIME(i_ctime, inode, raw_inode);
+		ext4_inode_set_ctime(inode, raw_inode);
 		EXT4_INODE_SET_XTIME(i_mtime, inode, raw_inode);
 		EXT4_INODE_SET_XTIME(i_atime, inode, raw_inode);
 		ext4_inode_csum_set(inode, raw_inode, ei);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9680fe753e59..4de4977dcb21 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -7258,7 +7258,7 @@ static struct file_system_type ext4_fs_type = {
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
 	.kill_sb		= kill_block_super,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MULTIGRAIN_TS,
 };
 MODULE_ALIAS_FS("ext4");
 
-- 
2.40.1

