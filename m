Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DB87B1A3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjI1LKg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjI1LJi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:09:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690CC26B3;
        Thu, 28 Sep 2023 04:05:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72987C433C8;
        Thu, 28 Sep 2023 11:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899138;
        bh=zDn/Ij6TBtWvdCEvJTtOwehmMOvptapRgeuVaso0uSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ijFzJW4cuQ9fvepQ4QbAqhY1xHi6FqUvrxv+2eCHi3q0Aey0DW/VtkRgLjR7RFLlm
         6g5j2UNO5bHQ0X0IlPdoFEZG6QEjFdvHs332J2wWEx7BPFM0QHhY0fMLO1MF9hLHal
         sNmFtjcM1PWglRslerRWQHMrAKUYe4hK++c1uwrmmSxu+kzIIGBOZB/cchtyk4QUTr
         y5pchHnyq21q/6/2TPLBnB5JWm75TRVCX50ZDLKTwYPtJPAhFnLUdf0lIC+mlfUD13
         QcUec2b3lIpXTPHDSbnlioAZuQ9UI/OT83TkwubLCNKTKgZfFN1vvGMVxxKHRgDh2T
         EjoRzndctc5PA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-trace-kernel@vger.kernel.org
Subject: [PATCH 71/87] fs/tracefs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:03:20 -0400
Message-ID: <20230928110413.33032-70-jlayton@kernel.org>
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
 fs/tracefs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 891653ba9cf3..429603d865a9 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -152,7 +152,7 @@ struct inode *tracefs_get_inode(struct super_block *sb)
 	struct inode *inode = new_inode(sb);
 	if (inode) {
 		inode->i_ino = get_next_ino();
-		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+		simple_inode_init_ts(inode);
 	}
 	return inode;
 }
-- 
2.41.0

