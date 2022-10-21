Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A356077C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 15:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiJUNG7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 09:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiJUNGX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:06:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5784F26B4BE;
        Fri, 21 Oct 2022 06:06:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DE8D61E9D;
        Fri, 21 Oct 2022 13:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044E4C433D6;
        Fri, 21 Oct 2022 13:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666357576;
        bh=XTCQklTYch506fsKvxW5ImA5FCnKyk22+LeCOXARq2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sOHJ0lyDnodI/pMdW/riO8Mlc7c3TXOUu3cVbHVd0S3sDMkrwQL3useK0XlgQZlSz
         O0wVWgujInzFgk7f2U+CS93aXxC9Ut4leanCI4L9eyimSUvz/BOrPpxbJ34njq1PJq
         +jjzkL/YehSxS2O/hgAG0+e+x0uPY/EPCwAme6V1t8tG/L6LtoREMaRXtw59nOYDnz
         xB6wzbZ62nsMC04zkIlU2EnGtMUQWguL7aBZt8sxvD+L4IfT93F8RkTd8OrpXEEZcY
         o2e4qO1gm2ecMPUFdp7NQVspCgHEl+eypbf9GaKDBTr6G7zmrTR73aLKp7mTazsJ7R
         XQH/Jr8JywX0A==
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
Subject: [PATCH v8 5/8] ceph: report the inode version in getattr if requested
Date:   Fri, 21 Oct 2022 09:05:59 -0400
Message-Id: <20221021130602.99099-6-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221021130602.99099-1-jlayton@kernel.org>
References: <20221021130602.99099-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 4af5e55abc15..0e2e6ca399a9 100644
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
2.37.3

