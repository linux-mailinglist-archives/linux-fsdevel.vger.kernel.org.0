Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E495B0321
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 13:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbiIGLd7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 07:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiIGLdh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:33:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA10B6D3B;
        Wed,  7 Sep 2022 04:33:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A5366187D;
        Wed,  7 Sep 2022 11:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A775C4347C;
        Wed,  7 Sep 2022 11:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662550415;
        bh=bADt1iW34YbhBu0nCRLgIJOflnIt9uISyZ+7TvMIyC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LIHpAJkbrDAVtPfHWfF4I7zF2vabNDa5VrfuVkaXm8jSr1TXUmi5JMMK82FS6JNbE
         t3hJ5xiaYPXg6i29gLuGo6NtwTy0OQznk7/4YWxsUtA6/fqfQopX1SfJ1rv5ABYlvk
         ZmXNLySTVMcIX6YjV6wgjm1VNaGpIb2u94deAfag9SZVsyBzbksFTdXCCBJB1Pz7Lj
         3Xe2KDEQwJKi9NfeerWlkmb+5SkHy5xeKSjfcD+hm6sbS+NfNNJhp9dNdop1wLehL8
         E7Ph4hYbZZ1zWxVAqLwpGpx5szLoT9CLkuodddgZF84WqyigcF2pxuyFBtv80uMjqH
         4xKGMepbha3Qg==
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com
Cc:     linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v4 6/6] ceph: fill in the change attribute in statx requests
Date:   Wed,  7 Sep 2022 07:33:18 -0400
Message-Id: <20220907113318.21810-7-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220907113318.21810-1-jlayton@kernel.org>
References: <20220907113318.21810-1-jlayton@kernel.org>
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

When statx requests the change attribute, request the full gamut of caps
(similarly to how ctime is handled). When the change attribute seems to
be valid, return it in the ino_version field.

Reviewed-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/inode.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 42351d7a0dd6..ccc926a7dcb0 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2415,10 +2415,10 @@ static int statx_to_caps(u32 want, umode_t mode)
 {
 	int mask = 0;
 
-	if (want & (STATX_MODE|STATX_UID|STATX_GID|STATX_CTIME|STATX_BTIME))
+	if (want & (STATX_MODE|STATX_UID|STATX_GID|STATX_CTIME|STATX_BTIME|STATX_INO_VERSION))
 		mask |= CEPH_CAP_AUTH_SHARED;
 
-	if (want & (STATX_NLINK|STATX_CTIME)) {
+	if (want & (STATX_NLINK|STATX_CTIME|STATX_INO_VERSION)) {
 		/*
 		 * The link count for directories depends on inode->i_subdirs,
 		 * and that is only updated when Fs caps are held.
@@ -2429,11 +2429,10 @@ static int statx_to_caps(u32 want, umode_t mode)
 			mask |= CEPH_CAP_LINK_SHARED;
 	}
 
-	if (want & (STATX_ATIME|STATX_MTIME|STATX_CTIME|STATX_SIZE|
-		    STATX_BLOCKS))
+	if (want & (STATX_ATIME|STATX_MTIME|STATX_CTIME|STATX_SIZE|STATX_BLOCKS|STATX_INO_VERSION))
 		mask |= CEPH_CAP_FILE_SHARED;
 
-	if (want & (STATX_CTIME))
+	if (want & (STATX_CTIME|STATX_INO_VERSION))
 		mask |= CEPH_CAP_XATTR_SHARED;
 
 	return mask;
@@ -2475,6 +2474,11 @@ int ceph_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		valid_mask |= STATX_BTIME;
 	}
 
+	if (request_mask & STATX_INO_VERSION) {
+		stat->ino_version = inode_peek_iversion_raw(inode);
+		valid_mask |= STATX_INO_VERSION;
+	}
+
 	if (ceph_snap(inode) == CEPH_NOSNAP)
 		stat->dev = inode->i_sb->s_dev;
 	else
-- 
2.37.3

