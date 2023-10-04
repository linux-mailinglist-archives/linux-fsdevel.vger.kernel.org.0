Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A097B8BA1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244983AbjJDSzh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244889AbjJDSzN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:55:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C8E1703;
        Wed,  4 Oct 2023 11:54:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53314C433CA;
        Wed,  4 Oct 2023 18:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445676;
        bh=wyvNElsQFY/wD3VfgQOB/p8jSKpTCN3KRbRtfrvrqrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZWi31j1jUlgmDJkHPPyOFkz0C/QfZm5d49XioZxpJyhP8DyIOttETytNY39PK56W5
         IuD3/BaYV68xTWkyv1GzhxiqtqQIR0q0Uz6NUGhmS6uAWx6d3aSmKhnAinEDw9se9u
         DyG/Eecn1IPpkAkJcPdA80ZrxQWID5H9A3omWWXFXi9KxJq0Aec4BBg41YB+8UZsgF
         o+/mCrLuEZ+33CrEGfZnaRjeyBde09bW87tvr8+Vul5mLEE4IGZuYVCiPXJ3vQQb4J
         qaWGhTshUsAAutavZ980pdGkNSOjnci6gt/dG/0Nn4CMcPqu7XJWm9gDCWNjG/X0PB
         fG0ZHVUaGTxLw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-um@lists.infradead.org
Subject: [PATCH v2 43/89] hostfs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:28 -0400
Message-ID: <20231004185347.80880-41-jlayton@kernel.org>
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

