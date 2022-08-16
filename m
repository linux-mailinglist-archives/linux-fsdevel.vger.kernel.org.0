Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F335595D4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 15:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbiHPN2O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 09:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbiHPN2J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:28:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B87286F1;
        Tue, 16 Aug 2022 06:28:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 873A4B81A21;
        Tue, 16 Aug 2022 13:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B01C433D6;
        Tue, 16 Aug 2022 13:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660656485;
        bh=WDIrsbOP3njOorYL2sAcnE2hJpRqVDbN3dfL/42j+/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HVXEtDS1FUczDN+l+uPOQ1A17CtM836+UL6FweXJxLsSedwHBKlj49XpUpCWqsffD
         5phGdeY4c97Pf107QATwIK3IAbBlnnvOyU0Bzes6Ts0IreSlWbuymrDYkKIYQM8iLM
         1KhhhQolM4UlbnnaU9TiGSE3Yy4HJ2cuPozOffK9jlL27eHpi3N7VtS1BPt/EhyXY7
         FI6fI/eytYM/dF/7YlWuXi0SGlEIP7ZxZCuG3lU6h57CZ8VLBUT8WudXyFR0SDtuDJ
         DcGE3z1LTKj0kZcnrII9XtSk/TdEHcUfjpnn6eWXupKXwV0V8fFUBJ4LmGf6k0XI30
         OHRZ87O9E/pgg==
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH 4/4] ceph: fill in the change attribute in statx requests
Date:   Tue, 16 Aug 2022 09:27:59 -0400
Message-Id: <20220816132759.43248-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220816132759.43248-1-jlayton@kernel.org>
References: <20220816132759.43248-1-jlayton@kernel.org>
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
be valid, return it in the chgattr field.

Reviewed-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/inode.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 42351d7a0dd6..171a32d623d2 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2415,10 +2415,10 @@ static int statx_to_caps(u32 want, umode_t mode)
 {
 	int mask = 0;
 
-	if (want & (STATX_MODE|STATX_UID|STATX_GID|STATX_CTIME|STATX_BTIME))
+	if (want & (STATX_MODE|STATX_UID|STATX_GID|STATX_CTIME|STATX_BTIME|STATX_CHANGE_ATTR))
 		mask |= CEPH_CAP_AUTH_SHARED;
 
-	if (want & (STATX_NLINK|STATX_CTIME)) {
+	if (want & (STATX_NLINK|STATX_CTIME|STATX_CHANGE_ATTR)) {
 		/*
 		 * The link count for directories depends on inode->i_subdirs,
 		 * and that is only updated when Fs caps are held.
@@ -2429,11 +2429,10 @@ static int statx_to_caps(u32 want, umode_t mode)
 			mask |= CEPH_CAP_LINK_SHARED;
 	}
 
-	if (want & (STATX_ATIME|STATX_MTIME|STATX_CTIME|STATX_SIZE|
-		    STATX_BLOCKS))
+	if (want & (STATX_ATIME|STATX_MTIME|STATX_CTIME|STATX_SIZE|STATX_BLOCKS|STATX_CHANGE_ATTR))
 		mask |= CEPH_CAP_FILE_SHARED;
 
-	if (want & (STATX_CTIME))
+	if (want & (STATX_CTIME|STATX_CHANGE_ATTR))
 		mask |= CEPH_CAP_XATTR_SHARED;
 
 	return mask;
@@ -2475,6 +2474,11 @@ int ceph_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		valid_mask |= STATX_BTIME;
 	}
 
+	if (request_mask & STATX_CHANGE_ATTR) {
+		stat->change_attr = inode_peek_iversion_raw(inode);
+		valid_mask |= STATX_CHANGE_ATTR;
+	}
+
 	if (ceph_snap(inode) == CEPH_NOSNAP)
 		stat->dev = inode->i_sb->s_dev;
 	else
-- 
2.37.2

