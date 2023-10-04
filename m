Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000917B8CB5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244453AbjJDTIL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 15:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245383AbjJDTHk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:07:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E3619AA;
        Wed,  4 Oct 2023 11:55:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17672C433C7;
        Wed,  4 Oct 2023 18:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445712;
        bh=XBmNDeJ7i675C+Gqvs30b2zycqgu44WCEf/N/NZrkg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ppAyk+Eg4X3oYeDh4VbHhyxo0RFdxGDi/En92Iktn7jh7p9zGA8ldu+i7QC2Xhr8y
         WrrMZgT4v+Mp2CNEcfRScrnNbpa18rPgQNGpVDosO7/R4lKeqFuvusHsYysTePlMow
         rtga7EjrMXOlVLruaWgXs0kYFQndnHjxd/ta17NZBykqSWWMBO7pDFN483vTM8EKtr
         Pr75rUcR44L/9FHe7HA0vUM+SDuyud6DM7Xn6rJbJInJuA1mEh+DHnG1Ct0iKo9ge/
         HMZsp5iyhMeTHF1M7ZsfzW4SG9ovmua1ezR8QFlVYMcqpicCX3e91u+z9OGu3WkSDH
         OD7BUldhfXz/Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 72/89] tracefs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:57 -0400
Message-ID: <20231004185347.80880-70-jlayton@kernel.org>
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

