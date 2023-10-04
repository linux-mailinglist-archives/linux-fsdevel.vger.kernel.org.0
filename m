Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FB97B8C74
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245325AbjJDTA7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 15:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244954AbjJDS7H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:59:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834D41FCE;
        Wed,  4 Oct 2023 11:55:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD016C433D9;
        Wed,  4 Oct 2023 18:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445721;
        bh=nmBe8zw5Ozk9SsspeSTfoPTE0dqkpP5EVJV/pwQVTiE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RBPj3XaFy+HwqFSflFtf5YtrJJVo8X1ACXxsgvFrdKXMqPtoSLFYkdVUHtJaqlusA
         qDi2W48u0a1FGdiLEJ+H+DFD8htQ7bo1EJz/L/to0iCkmAsehZZSTeQ0AJDvvXVnHd
         0ovJ/va685FW4d+kK18tNDfz26SQDz62ba/VXxeZj924DLlz8bYjVB7Sq677PZmfLx
         a4TNg5esgu54s8aLm+3tpfiOcJH9RTarmO1RPqVbue7jZ49Phd8lSowGO0DqLCUvVs
         +ug3tJ1ADfh86rbO+d0Z2bLQgOXdHyNmYChQp3eXfzdCc6iBYyuVyGdC+YwD+yPYgq
         +ACSyE9eD558g==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 79/89] linux: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:53:04 -0400
Message-ID: <20231004185347.80880-77-jlayton@kernel.org>
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
 include/linux/fs_stack.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs_stack.h b/include/linux/fs_stack.h
index 010d39d0dc1c..2b1f74b24070 100644
--- a/include/linux/fs_stack.h
+++ b/include/linux/fs_stack.h
@@ -16,14 +16,14 @@ extern void fsstack_copy_inode_size(struct inode *dst, struct inode *src);
 static inline void fsstack_copy_attr_atime(struct inode *dest,
 					   const struct inode *src)
 {
-	dest->i_atime = src->i_atime;
+	inode_set_atime_to_ts(dest, inode_get_atime(src));
 }
 
 static inline void fsstack_copy_attr_times(struct inode *dest,
 					   const struct inode *src)
 {
-	dest->i_atime = src->i_atime;
-	dest->i_mtime = src->i_mtime;
+	inode_set_atime_to_ts(dest, inode_get_atime(src));
+	inode_set_mtime_to_ts(dest, inode_get_mtime(src));
 	inode_set_ctime_to_ts(dest, inode_get_ctime(src));
 }
 
-- 
2.41.0

