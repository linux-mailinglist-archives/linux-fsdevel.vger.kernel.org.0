Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B6067A2D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 20:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjAXTbB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 14:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbjAXTam (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:30:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FE04FC2F;
        Tue, 24 Jan 2023 11:30:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2F986132C;
        Tue, 24 Jan 2023 19:30:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A27BC4339B;
        Tue, 24 Jan 2023 19:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674588640;
        bh=y7TnA7J0bGJKQopid+2sZ8/sHJQssWmUB40hQY869rI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JVWSIx6/3INbU6AtztsOljxziOJUoSR5DURuKFUcNrTU4sP3ZjO13RXV7nAruF7LX
         WyJUHmPFoS3h8VYYZKFsYJG9HjVtHm/TTifR/dcTDPUA1do6DrtWi6TEdA3a3ow+4N
         4ABmzPNnHjl54RBsPw2vAUPDuqadmmq/Y234u6tLHYEJh2hGfGYftfnKQ2ior3TKl6
         qrBX8u3LsjS/JTMquS1l0cJO1T0ERZEXAT6ey93f4IMkRwtTuVDIbPDWwBZ9vniJrg
         jdqT/8b1FUpdO6hGCoDYuzG1FGU1DzGmp3Y6L4hWuoI175ck+/aioalMrankTeOQxK
         Lglxt3ALE4/9A==
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
Subject: [PATCH v8 RESEND 5/8] ceph: report the inode version in getattr if requested
Date:   Tue, 24 Jan 2023 14:30:22 -0500
Message-Id: <20230124193025.185781-6-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230124193025.185781-1-jlayton@kernel.org>
References: <20230124193025.185781-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When getattr requests the STX_CHANGE_COOKIE, request the full gamut of
caps (similarly to how ctime is handled). When the change attribute
seems to be valid, return it in the change_cookie field and set the flag
in the reply mask. Also, unconditionally enable
STATX_ATTR_CHANGE_MONOTONIC.

Reviewed-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/inode.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 23d05ec87fcc..e22e631cb115 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2417,10 +2417,10 @@ static int statx_to_caps(u32 want, umode_t mode)
 {
 	int mask = 0;
 
-	if (want & (STATX_MODE|STATX_UID|STATX_GID|STATX_CTIME|STATX_BTIME))
+	if (want & (STATX_MODE|STATX_UID|STATX_GID|STATX_CTIME|STATX_BTIME|STATX_CHANGE_COOKIE))
 		mask |= CEPH_CAP_AUTH_SHARED;
 
-	if (want & (STATX_NLINK|STATX_CTIME)) {
+	if (want & (STATX_NLINK|STATX_CTIME|STATX_CHANGE_COOKIE)) {
 		/*
 		 * The link count for directories depends on inode->i_subdirs,
 		 * and that is only updated when Fs caps are held.
@@ -2431,11 +2431,10 @@ static int statx_to_caps(u32 want, umode_t mode)
 			mask |= CEPH_CAP_LINK_SHARED;
 	}
 
-	if (want & (STATX_ATIME|STATX_MTIME|STATX_CTIME|STATX_SIZE|
-		    STATX_BLOCKS))
+	if (want & (STATX_ATIME|STATX_MTIME|STATX_CTIME|STATX_SIZE|STATX_BLOCKS|STATX_CHANGE_COOKIE))
 		mask |= CEPH_CAP_FILE_SHARED;
 
-	if (want & (STATX_CTIME))
+	if (want & (STATX_CTIME|STATX_CHANGE_COOKIE))
 		mask |= CEPH_CAP_XATTR_SHARED;
 
 	return mask;
@@ -2478,6 +2477,11 @@ int ceph_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		valid_mask |= STATX_BTIME;
 	}
 
+	if (request_mask & STATX_CHANGE_COOKIE) {
+		stat->change_cookie = inode_peek_iversion_raw(inode);
+		valid_mask |= STATX_CHANGE_COOKIE;
+	}
+
 	if (ceph_snap(inode) == CEPH_NOSNAP)
 		stat->dev = sb->s_dev;
 	else
@@ -2519,6 +2523,8 @@ int ceph_getattr(struct user_namespace *mnt_userns, const struct path *path,
 			stat->nlink = 1 + 1 + ci->i_subdirs;
 	}
 
+	stat->attributes_mask |= STATX_ATTR_CHANGE_MONOTONIC;
+	stat->attributes |= STATX_ATTR_CHANGE_MONOTONIC;
 	stat->result_mask = request_mask & valid_mask;
 	return err;
 }
-- 
2.39.1

