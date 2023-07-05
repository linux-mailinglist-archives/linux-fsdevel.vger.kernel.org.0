Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56170748D17
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbjGETGp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbjGETFv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:05:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355161BD5;
        Wed,  5 Jul 2023 12:04:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDC02616F0;
        Wed,  5 Jul 2023 19:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB1EC433C7;
        Wed,  5 Jul 2023 19:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583840;
        bh=Yj3Hja39coL+y8AGiASW+H0zrb4hw9veEJV3lRuQS5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OZdARDRyu9HbK/4xlHu8SAsr9eP5a3ntrvWZg7JjqlkrGjPE61KU+o5xrpt0LTFs2
         eaQKPHbnCvFZd4g7qru7U8YXCnny1r/rYg3pYmPcqPDpaoYyCO4mtAeG4rbb/nhUJV
         1UiJdf3nVkkrbawqi8CpDeOo+g1PxdYjnMhpiMD1uyMKzyt7I9N9uNVoDCJNdFC7kw
         vtHid1+P0gTzfyB7gNbwhz93I2jsEAfb7QVI1shoPeDvQ5zIdUF4LET7zGoL+0C41I
         YUGQ/YUyljDueIkvTRlNOZODRNMkZA0Z3s64YbOjGsHQpcyv7M+HFpPR4fcirsfvCf
         nqACRgw72eAIQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 32/92] configfs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:00:57 -0400
Message-ID: <20230705190309.579783-30-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
 fs/configfs/inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
index 1c15edbe70ff..fbdcb3582926 100644
--- a/fs/configfs/inode.c
+++ b/fs/configfs/inode.c
@@ -88,8 +88,7 @@ int configfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 static inline void set_default_inode_attr(struct inode * inode, umode_t mode)
 {
 	inode->i_mode = mode;
-	inode->i_atime = inode->i_mtime =
-		inode->i_ctime = current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
 }
 
 static inline void set_inode_attr(struct inode * inode, struct iattr * iattr)
@@ -99,7 +98,7 @@ static inline void set_inode_attr(struct inode * inode, struct iattr * iattr)
 	inode->i_gid = iattr->ia_gid;
 	inode->i_atime = iattr->ia_atime;
 	inode->i_mtime = iattr->ia_mtime;
-	inode->i_ctime = iattr->ia_ctime;
+	inode_set_ctime_to_ts(inode, iattr->ia_ctime);
 }
 
 struct inode *configfs_new_inode(umode_t mode, struct configfs_dirent *sd,
@@ -172,7 +171,7 @@ struct inode *configfs_create(struct dentry *dentry, umode_t mode)
 		return ERR_PTR(-ENOMEM);
 
 	p_inode = d_inode(dentry->d_parent);
-	p_inode->i_mtime = p_inode->i_ctime = current_time(p_inode);
+	p_inode->i_mtime = inode_set_ctime_current(p_inode);
 	configfs_set_inode_lock_class(sd, inode);
 	return inode;
 }
-- 
2.41.0

