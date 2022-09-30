Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337715F0A59
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 13:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiI3L1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 07:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbiI3L03 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:26:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0743F18B09;
        Fri, 30 Sep 2022 04:18:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DC85B827BA;
        Fri, 30 Sep 2022 11:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7186AC433B5;
        Fri, 30 Sep 2022 11:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664536735;
        bh=xnrewwvldKIjoeh5ebiZu+onJb8qn6gj1nIuV6NIss8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NcCbX8EemXumNyb6KT05tfi/yNz/uFtXUTZvXGxbnSuQ2ZLVjG52bwXYXh5fpucLL
         Axp4jUtiz64IRjTVjSGPMpgOGwmu8wvMssoRLFOIpJI522UPlfZVlcKmzveia0MsA0
         QXEv6KjqFhnOQUm7yvMwpovx4fomvggXw6gH6kOyDiUirhpwVhUyKpaIclmtmJt7RQ
         kx5xoyorCoq1DbAdE8t5XYdq8PRHdXV81SrEz057Yr0UW5CY0v+c4HHNpWyI2ju5z3
         XlPgr7T1s3XlyK0ebZK7J8b1c6Sx0BGR1KCu1Fdmob2dvqZZYmgMwUW2ECkfNDyAWo
         +oq2fJMT+cU2w==
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
Subject: [PATCH v6 5/9] ceph: report the inode version in getattr if requested
Date:   Fri, 30 Sep 2022 07:18:36 -0400
Message-Id: <20220930111840.10695-6-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220930111840.10695-1-jlayton@kernel.org>
References: <20220930111840.10695-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When getattr requests the STX_VERSION, request the full gamut of caps
(similarly to how ctime is handled). When the change attribute seems to
be valid, return it in the ino_version field and set the flag in the
reply mask. Also, unconditionally enable STATX_ATTR_VERSION_MONOTONIC.

Reviewed-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/inode.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 42351d7a0dd6..bcab855bf1ae 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2415,10 +2415,10 @@ static int statx_to_caps(u32 want, umode_t mode)
 {
 	int mask = 0;
 
-	if (want & (STATX_MODE|STATX_UID|STATX_GID|STATX_CTIME|STATX_BTIME))
+	if (want & (STATX_MODE|STATX_UID|STATX_GID|STATX_CTIME|STATX_BTIME|STATX_VERSION))
 		mask |= CEPH_CAP_AUTH_SHARED;
 
-	if (want & (STATX_NLINK|STATX_CTIME)) {
+	if (want & (STATX_NLINK|STATX_CTIME|STATX_VERSION)) {
 		/*
 		 * The link count for directories depends on inode->i_subdirs,
 		 * and that is only updated when Fs caps are held.
@@ -2429,11 +2429,10 @@ static int statx_to_caps(u32 want, umode_t mode)
 			mask |= CEPH_CAP_LINK_SHARED;
 	}
 
-	if (want & (STATX_ATIME|STATX_MTIME|STATX_CTIME|STATX_SIZE|
-		    STATX_BLOCKS))
+	if (want & (STATX_ATIME|STATX_MTIME|STATX_CTIME|STATX_SIZE|STATX_BLOCKS|STATX_VERSION))
 		mask |= CEPH_CAP_FILE_SHARED;
 
-	if (want & (STATX_CTIME))
+	if (want & (STATX_CTIME|STATX_VERSION))
 		mask |= CEPH_CAP_XATTR_SHARED;
 
 	return mask;
@@ -2475,6 +2474,11 @@ int ceph_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		valid_mask |= STATX_BTIME;
 	}
 
+	if (request_mask & STATX_VERSION) {
+		stat->version = inode_peek_iversion_raw(inode);
+		valid_mask |= STATX_VERSION;
+	}
+
 	if (ceph_snap(inode) == CEPH_NOSNAP)
 		stat->dev = inode->i_sb->s_dev;
 	else
@@ -2498,6 +2502,8 @@ int ceph_getattr(struct user_namespace *mnt_userns, const struct path *path,
 			stat->nlink = 1 + 1 + ci->i_subdirs;
 	}
 
+	stat->attributes_mask |= STATX_ATTR_VERSION_MONOTONIC;
+	stat->attributes |= STATX_ATTR_VERSION_MONOTONIC;
 	stat->result_mask = request_mask & valid_mask;
 	return err;
 }
-- 
2.37.3

