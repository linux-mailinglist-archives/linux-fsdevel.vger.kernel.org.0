Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3121748CBB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjGETD3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbjGETDU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:03:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805581989;
        Wed,  5 Jul 2023 12:03:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EBAF616EC;
        Wed,  5 Jul 2023 19:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5B1C433C8;
        Wed,  5 Jul 2023 19:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583797;
        bh=+uSvE3e5ye7FfXdRduYnM950dEjKVs4JL0lbLQl6+aA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nHRmfAFCK2CDsQX39XN80sxMtmLR2cyM9QdVxuZU+mNJtHJNTpkluf86dZUHb3oZm
         VREay/ivmBMjXnBEdj8RlyVihmjXYqcSE0DACGVRSkme/DOPZ4DVpsRHhFX+65f7/R
         MCx/3+lO10b8UrW30Wh++8L6I7bMXq3ON8vL+YcHkgSn2M9qEOGbH+t7YIc1H89A7n
         41VwFuVjYESB3h80f7qBU6V9upZw+mr7gpbmI/Ofon98PaNR899XsdTdvwtmCu9e9u
         yAuCc2hZXFo5eG/TQgJ6eIetyxWH0SB8/Rw3nPincepwzoHaHJXc1Se4CiBma6fsuB
         T/CaTPyej1ctg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
Subject: [PATCH v2 05/92] apparmor: update ctime whenever the mtime changes on an inode
Date:   Wed,  5 Jul 2023 15:00:32 -0400
Message-ID: <20230705190309.579783-5-jlayton@kernel.org>
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

In general, when updating the mtime on an inode, one must also update
the ctime. Add the missing ctime updates.

Acked-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 security/apparmor/apparmorfs.c    |  7 +++++--
 security/apparmor/policy_unpack.c | 11 +++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 8e634fde35a5..3d0d370d6ffd 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -1554,8 +1554,11 @@ void __aafs_profile_migrate_dents(struct aa_profile *old,
 
 	for (i = 0; i < AAFS_PROF_SIZEOF; i++) {
 		new->dents[i] = old->dents[i];
-		if (new->dents[i])
-			new->dents[i]->d_inode->i_mtime = current_time(new->dents[i]->d_inode);
+		if (new->dents[i]) {
+			struct inode *inode = d_inode(new->dents[i]);
+
+			inode->i_mtime = inode->i_ctime = current_time(inode);
+		}
 		old->dents[i] = NULL;
 	}
 }
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 694fb7a09962..ed180722a833 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -86,10 +86,13 @@ void __aa_loaddata_update(struct aa_loaddata *data, long revision)
 
 	data->revision = revision;
 	if ((data->dents[AAFS_LOADDATA_REVISION])) {
-		d_inode(data->dents[AAFS_LOADDATA_DIR])->i_mtime =
-			current_time(d_inode(data->dents[AAFS_LOADDATA_DIR]));
-		d_inode(data->dents[AAFS_LOADDATA_REVISION])->i_mtime =
-			current_time(d_inode(data->dents[AAFS_LOADDATA_REVISION]));
+		struct inode *inode;
+
+		inode = d_inode(data->dents[AAFS_LOADDATA_DIR]);
+		inode->i_mtime = inode->i_ctime = current_time(inode);
+
+		inode = d_inode(data->dents[AAFS_LOADDATA_REVISION]);
+		inode->i_mtime = inode->i_ctime = current_time(inode);
 	}
 }
 
-- 
2.41.0

