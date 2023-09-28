Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13317B19BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjI1LFp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjI1LEq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:04:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5CBCC5;
        Thu, 28 Sep 2023 04:04:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF72C433C7;
        Thu, 28 Sep 2023 11:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899083;
        bh=J5LLSTFm1D1vFFNx5ZBt8xQQCcwQ5onLAqAizpMXWR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sprPS/eJlqGW94D18GotZfCdrkwyf9fKp2FHDS0LNbulwRIOP3NPW18QPk1v8i/rt
         cvQniSz4oIxJi//zB5mafYKpnEF2ZaEV/jdxSZrzGQOWRg6m5I3ou5hu0hZepyzJR9
         KbVM1atjUBE4iDwOg47uUsYGgpCbKlCHMOKQwPpJMmKsdxEOvc1FCl7i037iobGK/+
         4t+gGeRezDxaUXx2wybj27+utW+C65J9tur8pcCARhp2QXHMr/WPhPv7pSMRQPX6oS
         b8jR2CJEd2VigZaZYLUGdK14k6ts/dwt6PAcwzf8sSVyTReM86PgcyBNpkwuoDBum6
         HYLVZbNYtoNyg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 27/87] fs/debugfs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:36 -0400
Message-ID: <20230928110413.33032-26-jlayton@kernel.org>
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
 fs/debugfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 83e57e9f9fa0..5d41765e0c77 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -72,7 +72,7 @@ static struct inode *debugfs_get_inode(struct super_block *sb)
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

