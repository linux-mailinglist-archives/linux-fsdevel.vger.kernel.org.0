Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B651C7B19A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjI1LFI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjI1LEd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:04:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36E910C6;
        Thu, 28 Sep 2023 04:04:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF61C43391;
        Thu, 28 Sep 2023 11:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899067;
        bh=BjT5FOHm+eazmJSyqelvN0UNyLg8HYUUwJ3M3CdqJxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tBRF09ysU7N2igynCW093NVQflZFAh+gsZ3yeIMONpafyrjtuB5FRDk0jdIGxfBy/
         bzy5MZTW/WBmqP7cJIpKOZQwqFtJdpQowwjd/RlVj1j3zhhVpALHNhkrzhqHdkMGdG
         C83PebiDEHuEZq/fRlMdeC2xe4NR9YAK/CwxVzsnK3U9H1fDLO7rCo4BPEBjBVuqJG
         2jguEeIc4dODzqxPPUeOcrVr+DXAYxZSAm0FYGckqnVyrLnXrMZTRWJaGo1AN3Kctv
         A/Gg9A0rI7Ep6Oy/e0uxDaWgq/n64BeUoobMJTKZ0NK91j8mK7dFNgr5meU5JaZaHe
         SQp25SpvR3yWA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH 13/87] drivers/usb/gadget/function: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:22 -0400
Message-ID: <20230928110413.33032-12-jlayton@kernel.org>
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
 drivers/usb/gadget/function/f_fs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 6e9ef35a43a7..ec26df0306f2 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1383,8 +1383,8 @@ ffs_sb_make_inode(struct super_block *sb, void *data,
 		inode->i_mode    = perms->mode;
 		inode->i_uid     = perms->uid;
 		inode->i_gid     = perms->gid;
-		inode->i_atime   = ts;
-		inode->i_mtime   = ts;
+		inode_set_atime_to_ts(inode, ts);
+		inode_set_mtime_to_ts(inode, ts);
 		inode->i_private = data;
 		if (fops)
 			inode->i_fop = fops;
-- 
2.41.0

