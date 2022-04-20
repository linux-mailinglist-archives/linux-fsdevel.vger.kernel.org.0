Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3757E50891C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 15:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378924AbiDTNWZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 09:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiDTNWZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:22:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4732B42A21
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Apr 2022 06:19:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D757A61A5C
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Apr 2022 13:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4049C385A0;
        Wed, 20 Apr 2022 13:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650460778;
        bh=2Gik4DS55Z+cbDrVP23ItBsIuakEIek64YbpMrdW0Q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o1euhhDLJdy7gJZHPAwk6bCGIdL8x4O1BqhZ2YuBx+5CSz6M9Ot4W4sEGfCZWG3uV
         V05QF62OtWRMxcKqu9KW9M3+X2d/cxwdUoVvoC9cNWurx+WncG4lgh7zBh1qVmb/AF
         gfwG8Ct6TA0yLA/Le7xJSFVoIMvEnoKNhaIlXSl4F38f55mlSipke0/7fGFNLPIPsy
         xMC4Y9lCXg/EXFuziMm8Y/Q3lRRyrJoZ6EepGLNFoCaakMIzwx2Ga0bFIfLffCqjal
         cdcwJ4tXFzDAZkVLbObyoaDZLtMF77XPKbqx1XwngvD0eoEsly9YzeeLHMyP4ZDEGs
         5VqyBkg7zDUZg==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Hillf Danton <hdanton@sina.com>, fweisbec@gmail.com,
        mingo@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de,
        syzbot+10a16d1c43580983f6a2@syzkaller.appspotmail.com,
        syzbot+306090cfa3294f0bbfb3@syzkaller.appspotmail.com
Subject: [PATCH] fs: unset MNT_WRITE_HOLD on failure
Date:   Wed, 20 Apr 2022 15:19:25 +0200
Message-Id: <20220420131925.2464685-1-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <00000000000080e10e05dd043247@google.com>
References: 
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2864; h=from:subject; bh=2Gik4DS55Z+cbDrVP23ItBsIuakEIek64YbpMrdW0Q4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQlcARwT2e4X51VfYandqH/3xPZq3Tfu/Ll319aMFMhZqnV l7UFHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOxCmL4n/lqhl/sw06pyvuJp9bUPQ 21fb90zaZ/LkodjLtP3PjZP5Phn5nV1i6rjPK1UowrX7nVRx2IeFvx2MCIt/yaZvGbXuUYDgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After mnt_hold_writers() has been called we will always have set MNT_WRITE_HOLD
and consequently we always need to pair mnt_hold_writers() with
mnt_unhold_writers(). After the recent cleanup in [1] where Al switched from a
do-while to a for loop the cleanup currently fails to unset MNT_WRITE_HOLD for
the first mount that was changed. Fix this and make sure that the first mount
will be cleaned up and add some comments to make it more obvious.

Reported-by: syzbot+10a16d1c43580983f6a2@syzkaller.appspotmail.com
Reported-by: syzbot+306090cfa3294f0bbfb3@syzkaller.appspotmail.com
Fixes: e257039f0fc7 ("mount_setattr(): clean the control flow and calling conventions") [1]
Link: https://lore.kernel.org/lkml/0000000000007cc21d05dd0432b8@google.com
Link: https://lore.kernel.org/lkml/00000000000080e10e05dd043247@google.com
Cc: Hillf Danton <hdanton@sina.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
This should fix the syzbot issue. This is only relevant for making a
mount or mount tree read-only:
1. successul recursive read-only mount tree change:
   Cleanup loop isn't executed.
2. failed recursive read-only mount tree change:
   m will point to the mount we failed to handle. The cleanup loop will
   run until p == m and then terminate.
3. successful single read-only mount change:
   Cleanup loop won't be executed.
4. failed single read-only mount change:
   m will point to mnt and the cleanup loop will terminate if p == m.
I don't think there's any other weird corner cases since we now that
MNT_WRITE_HOLD can only have been set by us as it requires
lock_mount_hash() which we hold. So unconditionally unsetting it is
fine. But please make sure to take a close look at the changed loop.
---
 fs/namespace.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a0a36bfa3aa0..afe2b64b14f1 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4058,10 +4058,22 @@ static int mount_setattr_prepare(struct mount_kattr *kattr, struct mount *mnt)
 	if (err) {
 		struct mount *p;
 
-		for (p = mnt; p != m; p = next_mnt(p, mnt)) {
+		/*
+		 * If we had to call mnt_hold_writers() MNT_WRITE_HOLD will
+		 * be set in @mnt_flags. The loop unsets MNT_WRITE_HOLD for all
+		 * mounts and needs to take care to include the first mount.
+		 */
+		for (p = mnt; p; p = next_mnt(p, mnt)) {
 			/* If we had to hold writers unblock them. */
 			if (p->mnt.mnt_flags & MNT_WRITE_HOLD)
 				mnt_unhold_writers(p);
+
+			/*
+			 * We're done once the first mount we changed got
+			 * MNT_WRITE_HOLD unset.
+			 */
+			if (p == m)
+				break;
 		}
 	}
 	return err;

base-commit: b2d229d4ddb17db541098b83524d901257e93845
-- 
2.32.0

