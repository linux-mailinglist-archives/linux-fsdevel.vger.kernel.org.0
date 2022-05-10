Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0763521197
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 11:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239407AbiEJKDD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 06:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239421AbiEJKDC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 06:03:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91DB1A15D7
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 May 2022 02:59:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12E8161575
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 May 2022 09:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11963C385C6;
        Tue, 10 May 2022 09:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652176743;
        bh=+5zeoLDFy6kKFAfl77TzuNhSp5RKE5cy4P1htfopLAQ=;
        h=From:To:Cc:Subject:Date:From;
        b=bx87JjMRJ8hvim3e+4krvK7gVF5rzp6AKv+GQZpv6/aZy4RxiFQE3udoRbPwDURib
         K5kz2oJsoAaoM8/xy2y7AO6tg924RFInDfM1+sGR9jqwFh1UpqyulXBGzUf0iBExvX
         XHfDEUg74IQCdo+iH1VrAurd2S801/lMnUG4VqIsrKpAhsSJe3/QphFXGQoxhnAxAv
         mZKJ5a3Gr4XxXRikzKrXhj3/L5XGp58FSu4GEEJTwufwzuntLWBIasIAgjzVgdU5Tt
         B59daqcDtnDppAALVqxvDhk8eMfj29Wex6fzwK+y2GaobbOXS6thIbz283IvYxu2oL
         7n9hMO6bIYHcQ==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Seth Forshee <seth.forshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] fs: hold writers when changing mount's idmapping
Date:   Tue, 10 May 2022 11:58:40 +0200
Message-Id: <20220510095840.152264-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2773; i=brauner@kernel.org; h=from:subject; bh=eMIRfwg/PEG5hY5n5yhy3yOgRxuB/sh3fQ0bEWik6yY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRVmSudN1RunfWczfH9TqmJQg2iKfeLVsyc3/84qD5z7uEi b7NtHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMxCmf4Hx7oEr7ldkTiZT2u5gzLFN 3cmVxb9223cO2zyj3h/Cokn+F/qOPZTVOVex3C7I9ON5RjF6kuM5hTWiG9J3169JIq79McAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Hold writers when changing a mount's idmapping to make it more robust.

The vfs layer takes care to retrieve the idmapping of a mount once
ensuring that the idmapping used for vfs permission checking is
identical to the idmapping passed down to the filesystem.

For ioctl codepaths the filesystem itself is responsible for taking the
idmapping into account if they need to. While all filesystems with
FS_ALLOW_IDMAP raised take the same precautions as the vfs we should
enforce it explicitly by making sure there are no active writers on the
relevant mount while changing the idmapping.

This is similar to turning a mount ro with the difference that in
contrast to turning a mount ro changing the idmapping can only ever be
done once while a mount can transition between ro and rw as much as it
wants.

This is a minor user-visible change. But it is extremely unlikely to
matter. The caller must've created a detached mount via OPEN_TREE_CLONE
and then handed that O_PATH fd to another process or thread which then
must've gotten a writable fd for that mount and started creating files
in there while the caller is still changing mount properties. While not
impossible it will be an extremely rare corner-case and should in
general be considered a bug in the application. Consider making a mount
MOUNT_ATTR_NOEXEC or MOUNT_ATTR_NODEV while allowing someone else to
perform lookups or exec'ing in parallel by handing them a copy of the
OPEN_TREE_CLONE fd or another fd beneath that mount.

Cc: Seth Forshee <seth.forshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
This needs to be accompanied by a change to xfstests in order to verify
that this new behavior works fine. I will send that out shortly. Current
xfstests pass with the patch for xfstests and the kernel patch applied.
---
 fs/namespace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index afe2b64b14f1..41461f55c039 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4026,8 +4026,9 @@ static int can_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
 static inline bool mnt_allow_writers(const struct mount_kattr *kattr,
 				     const struct mount *mnt)
 {
-	return !(kattr->attr_set & MNT_READONLY) ||
-	       (mnt->mnt.mnt_flags & MNT_READONLY);
+	return (!(kattr->attr_set & MNT_READONLY) ||
+		(mnt->mnt.mnt_flags & MNT_READONLY)) &&
+	       !kattr->mnt_userns;
 }
 
 static int mount_setattr_prepare(struct mount_kattr *kattr, struct mount *mnt)

base-commit: af2d861d4cd2a4da5137f795ee3509e6f944a25b
-- 
2.34.1

