Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706237B198B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjI1LEp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjI1LET (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:04:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A50ACE6;
        Thu, 28 Sep 2023 04:04:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09596C433D9;
        Thu, 28 Sep 2023 11:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899057;
        bh=U6qTldvG3fnDRI2mBCZNMHraM10PPaH0RriqZeKhZ6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m7yc9zRc/odRQoso3YxHFM+NP/EUIFaS0rMXd3b2VBxPHAcmvyIcGYNB+9jyU5vAR
         tSY/B+A/l8NBBUmla4ygqg/8Hqj2TgzSv7S0uDHLTWtmJ1U+WYNTi+W8Rnds0zE64o
         Z+ttMm/1ejLfeOUEfEeRB7Q7j5FA4ez/S65LspZtw6811mfKd0+SaDkER9iLdgRb42
         mU9uzo6A8ABC+t9bWsEndtwI0Ocpp+k58mAcGbM18r4ak9HDXOJ7Y29+QEauZbjia6
         mwT/NqlaIfBrNZRf3PqwteQay0XIUSG/4ftoYIpb2LHrtRQoAVPRGdj9dXFfZcMwGS
         oeJcCnAHeellw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [PATCH 04/87] arch/s390/hypfs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:13 -0400
Message-ID: <20230928110413.33032-3-jlayton@kernel.org>
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
 arch/s390/hypfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index ada83149932f..858beaf4a8cb 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -53,7 +53,7 @@ static void hypfs_update_update(struct super_block *sb)
 	struct inode *inode = d_inode(sb_info->update_file);
 
 	sb_info->last_update = ktime_get_seconds();
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 }
 
 /* directory tree removal functions */
@@ -101,7 +101,7 @@ static struct inode *hypfs_make_inode(struct super_block *sb, umode_t mode)
 		ret->i_mode = mode;
 		ret->i_uid = hypfs_info->uid;
 		ret->i_gid = hypfs_info->gid;
-		ret->i_atime = ret->i_mtime = inode_set_ctime_current(ret);
+		simple_inode_init_ts(ret);
 		if (S_ISDIR(mode))
 			set_nlink(ret, 2);
 	}
-- 
2.41.0

