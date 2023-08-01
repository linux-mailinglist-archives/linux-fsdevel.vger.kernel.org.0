Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3518776B989
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 18:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjHAQSF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 12:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjHAQSE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:18:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C534FB0
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 09:18:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63B23615E1
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 16:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A4AC43391;
        Tue,  1 Aug 2023 16:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690906680;
        bh=xBoGWntMNrsXQJEn+mV8Hxn5c2XYNGctn4xoDLNhtd8=;
        h=From:Date:Subject:To:Cc:From;
        b=Cvp+HNOTvEkzNScbaY04KtHMEqKitncIzEBZAfOVJWYY3OTAJLSE0QRlHfq+hbkSh
         NB7Cg6+IviN1pl1tMFsNRz/FHHC5i1MMF5TGJrYTHqTfEGCWN2zVLz3YZtjeHpQM2t
         A1CJx74Q65pjuu1QhSTYFxO/XsFOzwaozNnnYqAK87Hmtzhca8tKpYRV48mFTZwhW5
         gleqx+9eh8s5osI3TMnQjIzh8/LxskK4vIPH+V1oGknnHNLEgXKp9TnSWxzGivnjNp
         ry/YSTx+ZzrWUXxmuw5Y1C8TtndIU4jBKgmgE0U/RTGjFq+Rs+Ba0Ac7mLEsg3qwcG
         47SlKkpT8oDuQ==
From:   Christian Brauner <brauner@kernel.org>
Date:   Tue, 01 Aug 2023 18:17:04 +0200
Subject: [PATCH] tmpfs: verify {g,u}id mount options correctly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230801-vfs-fs_context-uidgid-v1-1-daf46a050bbf@kernel.org>
X-B4-Tracking: v=1; b=H4sIAP8vyWQC/x3MTQrCMBBA4auUWTslqfQHryIi6WTSzsJUMjEUS
 u9udPkt3jtAOQkr3JoDEhdR2WKFvTRAq4sLo/hq6Ex3NZOxWIJi0CdtMfOe8SN+EY/j2A80eZo
 tGajtO3GQ/f+9P6pnp4xzcpHW3+3lNHNqy9D2mMjCeX4BXBbVIYkAAAA=
To:     Seth Forshee <sforshee@kernel.org>, Hugh Dickins <hughd@google.com>
Cc:     Seth Jenkins <sethjenkins@google.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=3336; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xBoGWntMNrsXQJEn+mV8Hxn5c2XYNGctn4xoDLNhtd8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaScNDBTefniV71tes6s2p3XLr0tk7Jf9OpvIb9rE+OynueK
 3tHLO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZy+wojQ0M0X/yOjNqaB5uiX7rVzD
 vQJ3S6bnP6jcIZYTv9GSwMyhgZZoh/XRN/QaBKvTXsgbPm8a0RU/QnFzwMDDz76tpWQ1MnVgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A while ago we received the following report:

"The other outstanding issue I noticed comes from the fact that
fsconfig syscalls may occur in a different userns than that which
called fsopen. That means that resolving the uid/gid via
current_user_ns() can save a kuid that isn't mapped in the associated
namespace when the filesystem is finally mounted. This means that it
is possible for an unprivileged user to create files owned by any
group in a tmpfs mount (since we can set the SUID bit on the tmpfs
directory), or a tmpfs that is owned by any user, including the root
group/user."

The contract for {g,u}id mount options and {g,u}id values in general set
from userspace has always been that they are translated according to the
caller's idmapping. In so far, tmpfs has been doing the correct thing.
But since tmpfs is mountable in unprivileged contexts it is also
necessary to verify that the resulting {k,g}uid is representable in the
namespace of the superblock to avoid such bugs as above.

The new mount api's cross-namespace delegation abilities are already
widely used. After having talked to a bunch of userspace this is the
most faithful solution with minimal regression risks. I know of one
users - systemd - that makes use of the new mount api in this way and
they don't set unresolable {g,u}ids. So the regression risk is minimal.

Link: https://lore.kernel.org/lkml/CALxfFW4BXhEwxR0Q5LSkg-8Vb4r2MONKCcUCVioehXQKr35eHg@mail.gmail.com
Fixes: f32356261d44 ("vfs: Convert ramfs, shmem, tmpfs, devtmpfs, rootfs to use the new mount API")
Reported-by: Seth Jenkins <sethjenkins@google.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---

---
 mm/shmem.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 2f2e0e618072..1c0b2dafafe5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3636,6 +3636,8 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 	unsigned long long size;
 	char *rest;
 	int opt;
+	kuid_t kuid;
+	kgid_t kgid;
 
 	opt = fs_parse(fc, shmem_fs_parameters, param, &result);
 	if (opt < 0)
@@ -3671,14 +3673,32 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 		ctx->mode = result.uint_32 & 07777;
 		break;
 	case Opt_uid:
-		ctx->uid = make_kuid(current_user_ns(), result.uint_32);
-		if (!uid_valid(ctx->uid))
+		kuid = make_kuid(current_user_ns(), result.uint_32);
+		if (!uid_valid(kuid))
 			goto bad_value;
+
+		/*
+		 * The requested uid must be representable in the
+		 * filesystem's idmapping.
+		 */
+		if (!kuid_has_mapping(fc->user_ns, kuid))
+			goto bad_value;
+
+		ctx->uid = kuid;
 		break;
 	case Opt_gid:
-		ctx->gid = make_kgid(current_user_ns(), result.uint_32);
-		if (!gid_valid(ctx->gid))
+		kgid = make_kgid(current_user_ns(), result.uint_32);
+		if (!gid_valid(kgid))
 			goto bad_value;
+
+		/*
+		 * The requested gid must be representable in the
+		 * filesystem's idmapping.
+		 */
+		if (!kgid_has_mapping(fc->user_ns, kgid))
+			goto bad_value;
+
+		ctx->gid = kgid;
 		break;
 	case Opt_huge:
 		ctx->huge = result.uint_32;

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230801-vfs-fs_context-uidgid-7756c8dcb1c0

