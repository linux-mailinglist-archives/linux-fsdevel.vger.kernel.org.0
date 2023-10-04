Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5084F7B8B8E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244760AbjJDSyl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244703AbjJDSy3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53C719AF;
        Wed,  4 Oct 2023 11:53:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91AB5C433C9;
        Wed,  4 Oct 2023 18:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445631;
        bh=HdzDDIAOL0gyCSOGAQpME4U8jFKk2Teg8J7WHsz4110=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S0rD3xt5/twMo5w2l6u/b9eeLMHekUDAQLI4UDIld+vM0pW+5jjCXGPZuvR5rWnFe
         3n8hVDKA7Tg+eu5X5KYGVCRpV9nUWHRfHJSKmv5Lp4Fn7LulDHX7egs9NX7CDGgGuB
         Gdptz0wYuxHjFCp6gRkR3jRc2fbNf44s83X7h4R72N7qED4gYb5F7h4qlQLts04pG5
         /detTTOnXPt3mfgt6AKSHW2QvMUjkMOdGLoAf2zcunl49eIsrDpHqcbKvAw5+VX87W
         hc7TgiCu2DJTD0HNhI7DD5jdWo4FieZu47KDPErL37hNpKzS8031iAQcpqcM1RIGTs
         C8qIbcH1F5GTw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [PATCH v2 04/89] hypfs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:51:49 -0400
Message-ID: <20231004185347.80880-2-jlayton@kernel.org>
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

