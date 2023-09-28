Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB29B7B19F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjI1LHy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjI1LF4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:05:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9B510C4;
        Thu, 28 Sep 2023 04:05:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F72EC433C8;
        Thu, 28 Sep 2023 11:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899102;
        bh=SmTKj23nuBjnbVRWTNodKzI7DTaJuxdAze07oBOhrrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L5QgKS9W7u596mXt8KF2kGCF40fQKt3AAdokcCeWA/jCXHC6cCL3EiH0HTC6hpVNh
         jg/9vxbojQzwyPjMI+uWdIktjRu5n4c9p4vp3127MYw2QK/BxQrQFzOjqgr8+eOLyP
         qDmXAX8zaxb22aHsML8eUME9AI49KprABJli7zFNSYyM6kQyEMUiYJ2LQDxxRbFzBd
         GUUs3SaFGffhXSR05lYBiXnt1RX1Ub0tcCi6Gr/RANngVZhKHaYJxbT1rNiq/zO5L2
         thx2c6ofSj2cpUam7Eckec2ZknPAVVU7bKgpxcvifXGifxRY1xgkkkMWB3be1PtxRC
         CDo8DKQZwTJxg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-um@lists.infradead.org
Subject: [PATCH 42/87] fs/hostfs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:51 -0400
Message-ID: <20230928110413.33032-41-jlayton@kernel.org>
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
 fs/hostfs/hostfs_kern.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index dc5a5cea5fae..ea87f24c6c3f 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -513,10 +513,14 @@ static int hostfs_inode_update(struct inode *ino, const struct hostfs_stat *st)
 	set_nlink(ino, st->nlink);
 	i_uid_write(ino, st->uid);
 	i_gid_write(ino, st->gid);
-	ino->i_atime =
-		(struct timespec64){ st->atime.tv_sec, st->atime.tv_nsec };
-	ino->i_mtime =
-		(struct timespec64){ st->mtime.tv_sec, st->mtime.tv_nsec };
+	inode_set_atime_to_ts(ino, (struct timespec64){
+			st->atime.tv_sec,
+			st->atime.tv_nsec,
+		});
+	inode_set_mtime_to_ts(ino, (struct timespec64){
+			st->mtime.tv_sec,
+			st->mtime.tv_nsec,
+		});
 	inode_set_ctime(ino, st->ctime.tv_sec, st->ctime.tv_nsec);
 	ino->i_size = st->size;
 	ino->i_blocks = st->blocks;
-- 
2.41.0

