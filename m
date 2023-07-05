Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8579C748D31
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbjGETHp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbjGETGn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:06:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FBF268E;
        Wed,  5 Jul 2023 12:04:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33B93616CC;
        Wed,  5 Jul 2023 19:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04F3C433C8;
        Wed,  5 Jul 2023 19:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583845;
        bh=uqLX2ipX4NvFoAzT/nc+anY78MkZU06KJM9/1GObuX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T8Af0tVezKUyyFTwpB8fkopaRFlqfs2/J01smC29vC9jnk2VzXjb/HOSDVs8+S1I1
         H18bhrBxnL8Wqy+8f2QLVxKzTWbRDu/kG8UFoUbGO6quVb2IkVZn4Ew3/hKKv7OBny
         3lYhc4BJan6Hq2SNN+Y6Ujxo0+8KxDKiQM3kgH1SQGSLuMUuxWlw3bPNxtCW/2nXln
         quQVcNEPodabzxhyNpS/7zo+pTDzjaD/xAK5cAXo2atP9rH8E7nJNRB+J821QGtfnJ
         Th6itlpuhTUQvs0he1LvgkZ8ofyTlPaArpcaoFn+hKwMCOPfn4pWHg9S+fTZC5Un/m
         FC5l3PNic5jhw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Tyler Hicks <code@tyhicks.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ecryptfs@vger.kernel.org
Subject: [PATCH v2 36/92] ecryptfs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:01 -0400
Message-ID: <20230705190309.579783-34-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In later patches, we're going to change how the inode's ctime field is
used. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ecryptfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 83274915ba6d..b491bb239c8f 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -148,7 +148,7 @@ static int ecryptfs_do_unlink(struct inode *dir, struct dentry *dentry,
 	}
 	fsstack_copy_attr_times(dir, lower_dir);
 	set_nlink(inode, ecryptfs_inode_to_lower(inode)->i_nlink);
-	inode->i_ctime = dir->i_ctime;
+	inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
 out_unlock:
 	dput(lower_dentry);
 	inode_unlock(lower_dir);
-- 
2.41.0

