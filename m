Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBBE7B19B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjI1LFf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbjI1LEg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:04:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F58412A;
        Thu, 28 Sep 2023 04:04:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9624BC433C9;
        Thu, 28 Sep 2023 11:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899075;
        bh=FSkoPS2wpHGRikf2wCbjVJa2Td2hPo0FwgxsJtrzOEE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Us0gigFIQ2FJf81+51xlE+Hw5y2wuAJCaWZ9qjjdfANYud1X1ohoIg+f3NH/qEjWk
         R0PvjRv7r+HVePgBUPuLELsHHdlQxCO/kE/o33nDcjHld3K3wlkjRvF9/tFXuAYd1Q
         sbg9IAEGdsc7bWHg5k9ruxBBbYKGPzPzxt2Z7F0UxmZ/vJlWK0LvUFL6uRlfA5Pr7Q
         dnhf8mn5vzLrPuuYen46rMYzak0NkyADGM4jcOBNCUeE0o6nyTAGRlni/AROnDDCPz
         ABwjYILEYSJvt7irGkZ1li7y2Py7xxKofBNqs1y0Z6gI7kN0rtNk4mTKIDbA+2CPyz
         S7LvbGo9noW4A==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 20/87] fs/befs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:29 -0400
Message-ID: <20230928110413.33032-19-jlayton@kernel.org>
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

