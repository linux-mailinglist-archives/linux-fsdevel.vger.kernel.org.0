Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334DA5B247D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 19:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiIHRZc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 13:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiIHRZJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:25:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B33EEE09;
        Thu,  8 Sep 2022 10:25:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFC7FB821DB;
        Thu,  8 Sep 2022 17:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFFFC433D7;
        Thu,  8 Sep 2022 17:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662657903;
        bh=/YNPcN4rxFONundBtrDqmkeT83g0yGiQLxW6cbtCzZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PoXh84IJy2h+PNMrM5x9Knf84XPB0xhoBe5WwW1p0waOAbkwhaFzWLuk+tV8dFiKq
         /mHeSchZSF+vFafsXNnXHc64od8sRT1goGnykUFJPq+lshswdYAqzSwyxvAhhwUjCl
         avqBhRiL908xOsnuPDU5cXkFMZM4niUktu1g37OtvrTJPYXsmQ9IbDfD00XZCXCN2S
         mgHxHvJT3mA3+gbtwRFfhf6hnhnsdOmuX9nK1SnS+xRFKe/RgWDK2UBhuJAHQO3AAf
         gzkYcaSkRlckHLWt+ahQAj7l1jq62SyeQmQbjpUvLfDPyt29PBj3IPAlVmI7GSglg6
         B8DOBxLBiHlAQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH v5 5/8] nfs: report the inode version in getattr if requested
Date:   Thu,  8 Sep 2022 13:24:45 -0400
Message-Id: <20220908172448.208585-6-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220908172448.208585-1-jlayton@kernel.org>
References: <20220908172448.208585-1-jlayton@kernel.org>
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

Allow NFS to report the i_version in getattr requests. Since the cost to
fetch it is relatively cheap, do it unconditionally and just set the
flag if it looks like it's valid.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index bea7c005119c..88c732a5c821 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -830,6 +830,8 @@ static u32 nfs_get_valid_attrmask(struct inode *inode)
 		reply_mask |= STATX_UID | STATX_GID;
 	if (!(cache_validity & NFS_INO_INVALID_BLOCKS))
 		reply_mask |= STATX_BLOCKS;
+	if (!(cache_validity & NFS_INO_INVALID_CHANGE))
+		reply_mask |= STATX_INO_VERSION;
 	return reply_mask;
 }
 
@@ -848,7 +850,7 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 
 	request_mask &= STATX_TYPE | STATX_MODE | STATX_NLINK | STATX_UID |
 			STATX_GID | STATX_ATIME | STATX_MTIME | STATX_CTIME |
-			STATX_INO | STATX_SIZE | STATX_BLOCKS;
+			STATX_INO | STATX_SIZE | STATX_BLOCKS | STATX_INO_VERSION;
 
 	if ((query_flags & AT_STATX_DONT_SYNC) && !force_sync) {
 		if (readdirplus_enabled)
@@ -877,7 +879,7 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	/* Is the user requesting attributes that might need revalidation? */
 	if (!(request_mask & (STATX_MODE|STATX_NLINK|STATX_ATIME|STATX_CTIME|
 					STATX_MTIME|STATX_UID|STATX_GID|
-					STATX_SIZE|STATX_BLOCKS)))
+					STATX_SIZE|STATX_BLOCKS|STATX_INO_VERSION)))
 		goto out_no_revalidate;
 
 	/* Check whether the cached attributes are stale */
@@ -915,6 +917,7 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 
 	generic_fillattr(&init_user_ns, inode, stat);
 	stat->ino = nfs_compat_user_ino64(NFS_FILEID(inode));
+	stat->ino_version = inode_peek_iversion_raw(inode);
 	if (S_ISDIR(inode->i_mode))
 		stat->blksize = NFS_SERVER(inode)->dtsize;
 out:
-- 
2.37.3

