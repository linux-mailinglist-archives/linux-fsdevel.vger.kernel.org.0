Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECFA7B19C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjI1LF6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbjI1LEt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:04:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695A3CD9;
        Thu, 28 Sep 2023 04:04:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7B7C43391;
        Thu, 28 Sep 2023 11:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899087;
        bh=xLy8ovC/T/DJkHAEAuHt2zyXkBkARonBG5h9l4hgO0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B+LiYngFvmRQJSi8FMS9rA/4kkZ1X9bA5G4LPi7q6jnThxNY8Xq3HC/urRnR2qAiL
         JHvqriASpJ1H91QoeNbEM1ZaFMQrMunUWdE8MjbtWxamzNeIEE7R8r6HXliwW0NNQB
         UnQnoyL/b+fRkjeOgV+wOfJKUjXEx+hTD+PXptAQZ5K8x0BFGrs7qurgsxz3yvmMVt
         GgI2twG3wZUmigYXw/dIaoMnUMGbzqs2ow49shRLU0dwXY56zd3s4XZvC9E/n/hUX5
         ifNrA//wb4zsSWj5I6RHkHjqGp/0RRxK0LUdieb4g0/XR8KimcqW4rQPfj5lqKs2fv
         5FaZa0ddIgoBQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Subject: [PATCH 31/87] fs/erofs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:40 -0400
Message-ID: <20230928110413.33032-30-jlayton@kernel.org>
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
 fs/erofs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index edc8ec7581b8..b8ad05b4509d 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -175,7 +175,8 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 		vi->chunkbits = sb->s_blocksize_bits +
 			(vi->chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
 	}
-	inode->i_mtime = inode->i_atime = inode_get_ctime(inode);
+	inode_set_mtime_to_ts(inode,
+			      inode_set_atime_to_ts(inode, inode_get_ctime(inode)));
 
 	inode->i_flags &= ~S_DAX;
 	if (test_opt(&sbi->opt, DAX_ALWAYS) && S_ISREG(inode->i_mode) &&
-- 
2.41.0

