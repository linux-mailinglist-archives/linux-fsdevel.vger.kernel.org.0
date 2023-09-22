Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7ED07AB702
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 19:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbjIVRPL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 13:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbjIVRPA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:15:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC17199;
        Fri, 22 Sep 2023 10:14:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48015C433CC;
        Fri, 22 Sep 2023 17:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695402893;
        bh=fUxZuWZUND6whtfSXS6cbk4dZFYYjP9h1aQMSYrQkf8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=rBTSD5KCp99SdJZqsG3zOYy+AdArnEo24hL2QnlNNWA+rKd1uSMkLvysYgASAy8nk
         0bbFIkNgBgvgbU6sAOFtzG8gk4ZsxaREY53V7g3eHNwfXbEq1lkcdapAwrdViQaT/k
         VybJ+BJ43c6IBag3RVLgPWv06U40KwYdJ8Ioud2e5unfr+FUyD7mIJHHgIwXPqxgVf
         y+SwAq2s6t5VVWHcNNkUPRjfi7Gapjlq2PvqQpUprYxExjc72PfhZ6Bh9cP7axAQj4
         HmyUf2kpRcyIMpzHzmKDgWaHMPnzUidPabG+MyH68FApeyLyLjaO3IXolT7e8BpPLH
         PN3yx8F2/QmyQ==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Fri, 22 Sep 2023 13:14:42 -0400
Subject: [PATCH v8 3/5] fs: have setattr_copy handle multigrain timestamps
 appropriately
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230922-ctime-v8-3-45f0c236ede1@kernel.org>
References: <20230922-ctime-v8-0-45f0c236ede1@kernel.org>
In-Reply-To: <20230922-ctime-v8-0-45f0c236ede1@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3299; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=fUxZuWZUND6whtfSXS6cbk4dZFYYjP9h1aQMSYrQkf8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlDcuGMi53UoH/W19WSq89zn8S9TZbYu1oTRu0z
 xom55+Yu6WJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZQ3LhgAKCRAADmhBGVaC
 FandEACrYrCK4mEHxIf2BJs2N6vjBIybMKu/4Io+i4XF+mOOk6726NojyEhKuk2vcXIZDgoSvko
 4sKNNH5HJsvVR4C/pSNdKBjr9POUoEZoVvbpAVLy2iu2ejCm9nZwOl2xLwDOHmVWpuGOaEC99N8
 slbJjXsc6mQhW4YtY8aiyIe2vWAUJiApGFxe76Xq4LVXwpvlLE59HrPesc8OTs9DlWw1gGcJgBI
 aGZ5e552ciqXH6M3W0TigkkwuRC/pE4PgFzY4IceN8aQ751zXiaRcePJlCTd8vw48smmMTyIduB
 7R0BBtYMOIFAIQLtYFAAzTOA1FXJEm9Z0fj5jaoxBcZKF1dn3wxU5v3JpQzPYlIwiW6Ew2/vE2Y
 ItlRJO5Cp9KTKFfB/bQQ/DGUJ1QIk9HjeA3wfhGKAJXOajJuBnt0uoMmUn5DMDSweylV3tiMO83
 xA84OiIS3hYeTXK1raunHowGVvoXZAK7H+ozYd9dMdvcMfJKrPBUy9YYl5z7l/hYT+OAZUvOkNc
 VWGpdW7tpulAckFRkllgmsfnvbNszaNeWX483WFWsz6X6Zfv6zQe+mX8S8T9UE4XqE6ZYjDhYKn
 tE/ezJ+p8Zn6pmB2fWYo7O0PYpLLmzwY9kcFm3H2MawZtSwNtcpY1I8f1CBDtMzSw3qgeoYiOhq
 kKQ6H5ktDrpyWUQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The setattr codepath is still using coarse-grained timestamps, even on
multigrain filesystems. To fix this, we need to fetch the timestamp for
ctime updates later, at the point where the assignment occurs in
setattr_copy.

On a multigrain inode, ignore the ia_ctime in the attrs, and always
update the ctime to the current clock value. Update the atime and mtime
with the same value (if needed) unless they are being set to other
specific values, a'la utimes().

Note that we don't want to do this universally however, as some
filesystems (e.g. most networked fs) want to do an explicit update
elsewhere before updating the local inode.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/attr.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index a8ae5f6d9b16..8ba330e6a582 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -275,6 +275,42 @@ int inode_newsize_ok(const struct inode *inode, loff_t offset)
 }
 EXPORT_SYMBOL(inode_newsize_ok);
 
+/**
+ * setattr_copy_mgtime - update timestamps for mgtime inodes
+ * @inode: inode timestamps to be updated
+ * @attr: attrs for the update
+ *
+ * With multigrain timestamps, we need to take more care to prevent races
+ * when updating the ctime. Always update the ctime to the very latest
+ * using the standard mechanism, and use that to populate the atime and
+ * mtime appropriately (unless we're setting those to specific values).
+ */
+static void setattr_copy_mgtime(struct inode *inode, const struct iattr *attr)
+{
+	unsigned int ia_valid = attr->ia_valid;
+	struct timespec64 now;
+
+	/*
+	 * If the ctime isn't being updated then nothing else should be
+	 * either.
+	 */
+	if (!(ia_valid & ATTR_CTIME)) {
+		WARN_ON_ONCE(ia_valid & (ATTR_ATIME|ATTR_MTIME));
+		return;
+	}
+
+	now = inode_set_ctime_current(inode);
+	if (ia_valid & ATTR_ATIME_SET)
+		inode->i_atime = attr->ia_atime;
+	else if (ia_valid & ATTR_ATIME)
+		inode->i_atime = now;
+
+	if (ia_valid & ATTR_MTIME_SET)
+		inode->i_mtime = attr->ia_mtime;
+	else if (ia_valid & ATTR_MTIME)
+		inode->i_mtime = now;
+}
+
 /**
  * setattr_copy - copy simple metadata updates into the generic inode
  * @idmap:	idmap of the mount the inode was found from
@@ -307,12 +343,6 @@ void setattr_copy(struct mnt_idmap *idmap, struct inode *inode,
 
 	i_uid_update(idmap, attr, inode);
 	i_gid_update(idmap, attr, inode);
-	if (ia_valid & ATTR_ATIME)
-		inode->i_atime = attr->ia_atime;
-	if (ia_valid & ATTR_MTIME)
-		inode->i_mtime = attr->ia_mtime;
-	if (ia_valid & ATTR_CTIME)
-		inode_set_ctime_to_ts(inode, attr->ia_ctime);
 	if (ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
 		if (!in_group_or_capable(idmap, inode,
@@ -320,6 +350,16 @@ void setattr_copy(struct mnt_idmap *idmap, struct inode *inode,
 			mode &= ~S_ISGID;
 		inode->i_mode = mode;
 	}
+
+	if (is_mgtime(inode))
+		return setattr_copy_mgtime(inode, attr);
+
+	if (ia_valid & ATTR_ATIME)
+		inode->i_atime = attr->ia_atime;
+	if (ia_valid & ATTR_MTIME)
+		inode->i_mtime = attr->ia_mtime;
+	if (ia_valid & ATTR_CTIME)
+		inode_set_ctime_to_ts(inode, attr->ia_ctime);
 }
 EXPORT_SYMBOL(setattr_copy);
 

-- 
2.41.0

