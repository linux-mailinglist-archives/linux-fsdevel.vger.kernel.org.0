Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B53768C447
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Feb 2023 18:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjBFRL1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 12:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjBFRL0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:11:26 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFD224116;
        Mon,  6 Feb 2023 09:11:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 52D8433AE4;
        Mon,  6 Feb 2023 17:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675703482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=JiosyFUMFz7kRTlgHlsP43ogSkUkcL2PJV6W1GvZl3E=;
        b=h/huH4B2x/yJGg2HFg/LXedjRuFs8CL7GGl8IYft4tEbopr3YFqn7NYQ7ql0K0q/XwktmS
        IR6lqr0fL1s5ISOfl3N9AQBwEyeg1KYUDGbpp6foFxkS/gqj5q676kyw7XksHMjqmMMACT
        LX1VkXWK6iVYk3TenEyeln0RUXiAhIM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3017B138E8;
        Mon,  6 Feb 2023 17:11:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jAN6Cro04WMTJwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 06 Feb 2023 17:11:22 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Petr Pavlu <petr.pavlu@suse.com>
Subject: [RFC PATCH] vfs: Delay root FS switch after UMH completion
Date:   Mon,  6 Feb 2023 18:10:32 +0100
Message-Id: <20230206171032.12801-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We want to make sure no UMHs started with an old root survive into the
world with the new root (they may fail when it is not expected).
Therefore, insert a wait for existing UMHs termination (this assumes UMH
runtime is finite).

A motivation are asynchronous module loads that start in initrd and they
may be (un)intentionally terminated by a userspace cleanup during rootfs
transition.

This is also inspired by an ancient problem [1].

This is just a rough idea, only superficially tested, no broader context
(VFS locking et al) is considered.

[1] https://kernelnewbies.org/KernelProjects/usermode-helper-enhancements#Filesystem_suspend

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---

I'm not amused by this patch. I'm sending it to get some NAck reasons
(besides indefinite UMH lifetime) and get it off my head. Thanks.

 fs/namespace.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index ab467ee58341..48cb658ae10c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2931,6 +2931,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 	struct mount *old;
 	struct mount *parent;
 	struct mountpoint *mp, *old_mp;
+	struct path ns_root;
 	int err;
 	bool attached;
 
@@ -2985,6 +2986,14 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 		if (p == old)
 			goto out;
 
+	ns_root.mnt = &current->nsproxy->mnt_ns->root->mnt;
+	ns_root.dentry = ns_root.mnt->mnt_root;
+	path_get(&ns_root);
+	/* See argument in pivot_root() */
+	if (path_equal(new_path, &ns_root))
+		usermodehelper_disable();
+
+
 	err = attach_recursive_mnt(old, real_mount(new_path->mnt), mp,
 				   attached);
 	if (err)
@@ -2996,6 +3005,9 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 	if (attached)
 		put_mountpoint(old_mp);
 out:
+	if (path_equal(new_path, &ns_root))
+		usermodehelper_enable();
+
 	unlock_mount(mp);
 	if (!err) {
 		if (attached)
@@ -3997,6 +4009,8 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 		goto out2;
 
 	get_fs_root(current->fs, &root);
+	/* UMHs started from old root should finish before we switch root under */
+	usermodehelper_disable(); // XXX error handling
 	old_mp = lock_mount(&old);
 	error = PTR_ERR(old_mp);
 	if (IS_ERR(old_mp))
@@ -4058,6 +4072,7 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	error = 0;
 out4:
 	unlock_mount(old_mp);
+	usermodehelper_enable();
 	if (!error)
 		mntput_no_expire(ex_parent);
 out3:
-- 
2.39.1

