Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B08748CF9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbjGETF2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbjGETEp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:04:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45142680;
        Wed,  5 Jul 2023 12:03:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21C72616D1;
        Wed,  5 Jul 2023 19:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C835BC433C8;
        Wed,  5 Jul 2023 19:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583824;
        bh=1B+MgxeTUKiB+Aq5PTxF0CcPr9pCEwQhTlsh6cqIOdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WmsTGikntTcs585octjgzEvGQ4NF2m05+liXMeHd7YWRLAsj/EWPPr668pReigKWX
         YZyp7UuLDK1/AYXJys666MxyTRACmx9TiSa3YjyQxI7oZq3/F79aQAXMpLWf6hg/18
         I39raBK11jzCp//l9SZkPsDG+MsxNCWKnPPxtZsKMnAzkX/c2u3LteYNoACxQ8Mz3S
         isJq20UqJE/y9hy4OF8kHrFteHDj9iSackwnExM8HFDUGyUNkDoPF4eWIxd1NSh5dZ
         x8BDNmCqWOiHg+E7wPfo5+vWyKXFk9RnhXbqJGYfZOAlSap34gnK1KczLmSr4ObFom
         YZxuY9ITV40Vg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-afs@lists.infradead.org
Subject: [PATCH v2 24/92] afs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:00:49 -0400
Message-ID: <20230705190309.579783-22-jlayton@kernel.org>
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

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/afs/dynroot.c | 2 +-
 fs/afs/inode.c   | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index d7d9402ff718..95bcbd7654d1 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -88,7 +88,7 @@ struct inode *afs_iget_pseudo_dir(struct super_block *sb, bool root)
 	set_nlink(inode, 2);
 	inode->i_uid		= GLOBAL_ROOT_UID;
 	inode->i_gid		= GLOBAL_ROOT_GID;
-	inode->i_ctime = inode->i_atime = inode->i_mtime = current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
 	inode->i_blocks		= 0;
 	inode->i_generation	= 0;
 
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 866bab860a88..6b636f43f548 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -90,7 +90,7 @@ static int afs_inode_init_from_status(struct afs_operation *op,
 	vnode->status = *status;
 
 	t = status->mtime_client;
-	inode->i_ctime = t;
+	inode_set_ctime_to_ts(inode, t);
 	inode->i_mtime = t;
 	inode->i_atime = t;
 	inode->i_flags |= S_NOATIME;
@@ -206,7 +206,7 @@ static void afs_apply_status(struct afs_operation *op,
 	t = status->mtime_client;
 	inode->i_mtime = t;
 	if (vp->update_ctime)
-		inode->i_ctime = op->ctime;
+		inode_set_ctime_to_ts(inode, op->ctime);
 
 	if (vnode->status.data_version != status->data_version)
 		data_changed = true;
@@ -252,7 +252,7 @@ static void afs_apply_status(struct afs_operation *op,
 		vnode->netfs.remote_i_size = status->size;
 		if (change_size) {
 			afs_set_i_size(vnode, status->size);
-			inode->i_ctime = t;
+			inode_set_ctime_to_ts(inode, t);
 			inode->i_atime = t;
 		}
 	}
-- 
2.41.0

