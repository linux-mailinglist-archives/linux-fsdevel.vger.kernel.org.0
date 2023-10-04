Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E687B8D3A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245258AbjJDS71 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244976AbjJDS5i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:57:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D258B1BCA;
        Wed,  4 Oct 2023 11:55:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04E8C433C8;
        Wed,  4 Oct 2023 18:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445706;
        bh=cYZfH8J20PFiLPgQtnzXidDq8KjSTBwLQM10SWUOyDc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qb5DWzuV+Yl+U5i4O4AmUUPGTtX3PVCwHHJ0ZsJMlSb2jRzt/5ftMWWnHnawPiUxf
         m/JOkoQ/ElFbyi38QpXwo5bKDZ4sKET3/xO9mydJGs97TUjiZ3j8jgzoANQj6Pe5+F
         zOInfraFWC1C+Vf8Su/e7GPDTaOQFYaM7GPP9+OV1eCokyYW68iQfeQ9znZP94fNtu
         tpA6x5rcgX8+ILIGAHBFqF08ABgd489h5Ppjii12q9xTC/s5/k+rMoS3GRA3DNPUve
         fUxw0wzSzQ8s+llzdXnlJXFolH5nunFeMvgfLuit7ETtrMziCiYrlmsoW2ZzQ++/Ff
         50oAonuXfFlrQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 67/89] romfs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:52 -0400
Message-ID: <20231004185347.80880-65-jlayton@kernel.org>
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
 fs/romfs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index b1bdfbc211c3..545ad44f96b8 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -322,7 +322,8 @@ static struct inode *romfs_iget(struct super_block *sb, unsigned long pos)
 
 	set_nlink(i, 1);		/* Hard to decide.. */
 	i->i_size = be32_to_cpu(ri.size);
-	i->i_mtime = i->i_atime = inode_set_ctime(i, 0, 0);
+	inode_set_mtime_to_ts(i,
+			      inode_set_atime_to_ts(i, inode_set_ctime(i, 0, 0)));
 
 	/* set up mode and ops */
 	mode = romfs_modemap[nextfh & ROMFH_TYPE];
-- 
2.41.0

