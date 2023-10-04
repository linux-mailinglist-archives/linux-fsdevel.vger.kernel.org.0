Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D045C7B8BC7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245006AbjJDSzw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244854AbjJDSyz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2770B10F2;
        Wed,  4 Oct 2023 11:54:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D425C433C8;
        Wed,  4 Oct 2023 18:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445670;
        bh=laqdLQX++bYwL/9FLlbUOBix7eTg/7aYzaxDd38931k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=o05mbaN0ZygPTpYgW1P7ybdN5amDbA8QO3l3HrUscPXYdmWLBn0vBmB7C+rxkJPfY
         l73lr5JqnGt3J+lErTPnyABVq8htzrJpZDnPLKka6x2+RMt3zUvOH4Qw5VLOw2mYbS
         P8fV+eyPGoih4Ny6rC14zoUL/BnS5VVu1KqOV6PCWKNry8qYM2wacI4Eq+n1Xp6Ex1
         8TTANAUcQLXlQqzF4Hei1CbQUXJU1t64S4cQN3U24O/bCzlJga/KCdKd9woJW3KCBK
         M/9yAtx+dQAOYPplLYZV6zdVB2cuC/UuTlg0D4zWORyr4hhIZiz9mntiHIwEoAMwLQ
         g4/KQramMs3Lw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 38/89] freevxfs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:23 -0400
Message-ID: <20231004185347.80880-36-jlayton@kernel.org>
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
 fs/freevxfs/vxfs_inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/freevxfs/vxfs_inode.c b/fs/freevxfs/vxfs_inode.c
index ac5d43b164b5..20600e9ea202 100644
--- a/fs/freevxfs/vxfs_inode.c
+++ b/fs/freevxfs/vxfs_inode.c
@@ -109,11 +109,9 @@ static inline void dip2vip_cpy(struct vxfs_sb_info *sbi,
 	set_nlink(inode, vip->vii_nlink);
 	inode->i_size = vip->vii_size;
 
-	inode->i_atime.tv_sec = vip->vii_atime;
+	inode_set_atime(inode, vip->vii_atime, 0);
 	inode_set_ctime(inode, vip->vii_ctime, 0);
-	inode->i_mtime.tv_sec = vip->vii_mtime;
-	inode->i_atime.tv_nsec = 0;
-	inode->i_mtime.tv_nsec = 0;
+	inode_set_mtime(inode, vip->vii_mtime, 0);
 
 	inode->i_blocks = vip->vii_blocks;
 	inode->i_generation = vip->vii_gen;
-- 
2.41.0

