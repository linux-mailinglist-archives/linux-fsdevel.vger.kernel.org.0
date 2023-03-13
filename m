Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D946A6B78D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Mar 2023 14:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCMNZz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Mar 2023 09:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjCMNZw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:25:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164DD26CEA;
        Mon, 13 Mar 2023 06:25:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1D11B80DFC;
        Mon, 13 Mar 2023 13:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7000BC4339C;
        Mon, 13 Mar 2023 13:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678713948;
        bh=k2LYFFGMZwKGlMXyjsfyVXpfREqFKoaTC649uhWuyFA=;
        h=From:Date:Subject:To:Cc:From;
        b=YnZXf/Nfq6e0MA5aFIVdAplX5MmTxwm+XdPAi0on/KYWlCKKgHM9C7okvNOYLTQ2D
         CUd7mcAL9rMI0Pu6nCppUAWDDXq/2r0F6XA9TT+VUtZ/JvUM4G6CDRqRlfH4e6HHdQ
         lALYXg+VY3D6XVMdKrZR0De8Davmab/ZrJ85K9Ul/yZFlym3sR0EpN6qKZknOKKiwO
         Y9HZGReptoagmTWZ2illQaNnKgbWS4fT+SVZH0ODL2byfOJEulfgZrBDW3JghYc5sU
         xcRYx0kcG/9BkXBVTjX28zYD08/kdnk2RdD43s9KSIjl/EdwcfFYwHeaxzp7GbXS2w
         qHIq0bFt3Eryw==
From:   Christian Brauner <brauner@kernel.org>
Date:   Mon, 13 Mar 2023 14:25:34 +0100
Subject: [PATCH] nfs: use vfs setgid helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230313-fs-nfs-setgid-v1-1-5b1fa599f186@kernel.org>
X-B4-Tracking: v=1; b=H4sIAE0kD2QC/x2NSwqEQAwFryJZT6A/KuhVhlmkNWoWtkMiIoh3n
 3YWb1E8irrAWIUN+uoC5UNMtlzAvyoYFsozo4yFIbgQXfQRJ8NcZrzPMmLbdLV35F0KDRQnkTE
 mpTwsj7WS7azP8VWe5PyH3p/7/gFOIfpaeAAAAA==
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>
X-Mailer: b4 0.13-dev-2eb1a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1599; i=brauner@kernel.org;
 h=from:subject:message-id; bh=k2LYFFGMZwKGlMXyjsfyVXpfREqFKoaTC649uhWuyFA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTwq0T1zOab1VwXZ3/s/TGunzn5++0Wnub8uZ3Zv4KPJebu
 e8HajlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl82cfIcPeQhMpD0YVLfm9Syi3Z4y
 Fs2r7LWuKF8YH65v8GpS/vijAy7GZQXFo+KSk7idtSTOR0/bvUGu/HfKqvDjQlHzxUtTWcDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We've aligned setgid behavior over multiple kernel releases. The details
can be found in the following two merge messages:
cf619f891971 ("Merge tag 'fs.ovl.setgid.v6.2')
426b4ca2d6a5 ("Merge tag 'fs.setgid.v6.0')
Consistent setgid stripping behavior is now encapsulated in the
setattr_should_drop_sgid() helper which is used by all filesystems that
strip setgid bits outside of vfs proper. Switch nfs to rely on this
helper as well. Without this patch the setgid stripping tests in
xfstests will fail.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/nfs/inode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 222a28320e1c..5001086500b3 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -42,6 +42,7 @@
 #include <linux/uaccess.h>
 #include <linux/iversion.h>
 
+#include "../internal.h"
 #include "nfs4_fs.h"
 #include "callback.h"
 #include "delegation.h"
@@ -717,9 +718,7 @@ void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr,
 		if ((attr->ia_valid & ATTR_KILL_SUID) != 0 &&
 		    inode->i_mode & S_ISUID)
 			inode->i_mode &= ~S_ISUID;
-		if ((attr->ia_valid & ATTR_KILL_SGID) != 0 &&
-		    (inode->i_mode & (S_ISGID | S_IXGRP)) ==
-		     (S_ISGID | S_IXGRP))
+		if (setattr_should_drop_sgid(&nop_mnt_idmap, inode))
 			inode->i_mode &= ~S_ISGID;
 		if ((attr->ia_valid & ATTR_MODE) != 0) {
 			int mode = attr->ia_mode & S_IALLUGO;

---
base-commit: eeac8ede17557680855031c6f305ece2378af326
change-id: 20230313-fs-nfs-setgid-659410a10b25

