Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C147B8BDA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244865AbjJDSy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244610AbjJDSyj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACD7194;
        Wed,  4 Oct 2023 11:54:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152C2C433C7;
        Wed,  4 Oct 2023 18:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445648;
        bh=VZeO+KnP0i1FeqM9/WQ8dV1qUSykp6CVzxV5q5AtMB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rVuNjVHqLVXKtCF8V9QISykbfPweeRDvwbMinu2ovVQpxwapBwWpIIFVteeAe+3a6
         cYfLkTUg0JDy4TYKZyztkUThmAzhVVE/+eMuArnkQtfSaPubU1d17ue6S/4hdWSpva
         DALvVd4hOeNdSE+ilgZhxCatPXs9Vmlxqvzu1ljONuqNaaJOvHTYnYhNlR8e6itx6e
         oAYI+b0dDP20O3wjsR+/Wa6WYgRHxsTLNcincm1a9xHHTBmQJJIzM0tI2isko7M3ji
         ouZ3iEV+i4GGc4QLw3fCVFbpbo/YQXSPdLvkvBolQXN+RRPTthOjkiiDvs5Um3oKdz
         Y7D2D1TqKrsCg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org
Subject: [PATCH v2 20/89] bcachefs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:05 -0400
Message-ID: <20231004185347.80880-18-jlayton@kernel.org>
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
 fs/bcachefs/fs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 09137a20449b..1fbaad27d07b 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -66,9 +66,9 @@ void bch2_inode_update_after_write(struct btree_trans *trans,
 	inode->v.i_mode	= bi->bi_mode;
 
 	if (fields & ATTR_ATIME)
-		inode->v.i_atime = bch2_time_to_timespec(c, bi->bi_atime);
+		inode_set_atime_to_ts(&inode->v, bch2_time_to_timespec(c, bi->bi_atime));
 	if (fields & ATTR_MTIME)
-		inode->v.i_mtime = bch2_time_to_timespec(c, bi->bi_mtime);
+		inode_set_mtime_to_ts(&inode->v, bch2_time_to_timespec(c, bi->bi_mtime));
 	if (fields & ATTR_CTIME)
 		inode_set_ctime_to_ts(&inode->v, bch2_time_to_timespec(c, bi->bi_ctime));
 
@@ -753,8 +753,8 @@ static int bch2_getattr(struct mnt_idmap *idmap,
 	stat->gid	= inode->v.i_gid;
 	stat->rdev	= inode->v.i_rdev;
 	stat->size	= i_size_read(&inode->v);
-	stat->atime	= inode->v.i_atime;
-	stat->mtime	= inode->v.i_mtime;
+	stat->atime	= inode_get_atime(&inode->v);
+	stat->mtime	= inode_get_mtime(&inode->v);
 	stat->ctime	= inode_get_ctime(&inode->v);
 	stat->blksize	= block_bytes(c);
 	stat->blocks	= inode->v.i_blocks;
@@ -1418,8 +1418,8 @@ static int inode_update_times_fn(struct btree_trans *trans,
 {
 	struct bch_fs *c = inode->v.i_sb->s_fs_info;
 
-	bi->bi_atime	= timespec_to_bch2_time(c, inode->v.i_atime);
-	bi->bi_mtime	= timespec_to_bch2_time(c, inode->v.i_mtime);
+	bi->bi_atime	= timespec_to_bch2_time(c, inode_get_atime(&inode->v));
+	bi->bi_mtime	= timespec_to_bch2_time(c, inode_get_mtime(&inode->v));
 	bi->bi_ctime	= timespec_to_bch2_time(c, inode_get_ctime(&inode->v));
 
 	return 0;
-- 
2.41.0

