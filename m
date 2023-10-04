Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001BF7B8BFB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244652AbjJDSzV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244694AbjJDSyq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F3B12A;
        Wed,  4 Oct 2023 11:54:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB20DC433CC;
        Wed,  4 Oct 2023 18:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445662;
        bh=NKCGSIQYRSxC2JawkYr7/YEsyOK3p0HchI8AY3G83h0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SYXkeAxA6GIsUxWdFXlhz0b1EoS94hY6W+5ZE496QCIGR6BNog3PmkPhDJUR+hf0F
         j94xjhCefWxR0P6uPlC/k3Dl2Tf/q4/w9SCwaLsjcO4KSdIuDi+f5MREUd9HpfyqN9
         qfTlqAupj6ao/VhswuFB8CVLXK9n4XTZJEphvPMq+0SjUf481wKGqONpaozmOTHz1F
         Zy5OpfvyMzcIwNvid3b9NbGYc0dfw1p97dDsxv9ZPr4QPACKm9TjV2aPM+i6gGwLUP
         1rYokv2LmDEv2qKfpNT1m7awfHwGPlaxpHCG2jVDxDzQvYe99QiwMJDIG/ujR7a91w
         XgxekVcEqySnA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 32/89] erofs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:17 -0400
Message-ID: <20231004185347.80880-30-jlayton@kernel.org>
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

