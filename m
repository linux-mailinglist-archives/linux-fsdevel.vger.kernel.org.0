Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C3474507C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jul 2023 21:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjGBTip (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jul 2023 15:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjGBTil (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:38:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF81D10D4;
        Sun,  2 Jul 2023 12:38:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CD2B60CF7;
        Sun,  2 Jul 2023 19:38:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3333C433CB;
        Sun,  2 Jul 2023 19:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326710;
        bh=X5Kfi6rRh+ut+1/4jM3DiLRKlHqNY0U7ZxZrCTV4GdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YyxT5OYHjPBwoLsCvrV/vcQzIrVbm87cUhALW/s/EL7We3IHoT9p7/cFW1WF2Crx9
         ki2ioksg3EJHfnydk+BTEhZD3ZTuDx6jJBQbxafCvh0NQRzqil54xnQrdzOkqEHvwx
         KpSFgfWsNcPnJIV0uNbTnHM3c7lHQZUhWC+0t7Q8t5xHGBiDpQtiRTZuaASoLWZDuF
         qt1zzdoI6SghTYlthyAztUwdAEg04yU7DpJcK5M1lABUmcRzJt9sucfy7QkbPqUg6r
         /6Bctn9hU/RyPCYzr+rgwjptx85dTP7MeWp81ZEfOggS9Qxh4LTSI5jmzxl1MGPpyN
         Gsm+d0Pp8L7Pw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        Sasha Levin <sashal@kernel.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 07/16] fs: Protect reconfiguration of sb read-write from racing writes
Date:   Sun,  2 Jul 2023 15:38:06 -0400
Message-Id: <20230702193815.1775684-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702193815.1775684-1-sashal@kernel.org>
References: <20230702193815.1775684-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.1
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

From: Jan Kara <jack@suse.cz>

[ Upstream commit c541dce86c537714b6761a79a969c1623dfa222b ]

The reconfigure / remount code takes a lot of effort to protect
filesystem's reconfiguration code from racing writes on remounting
read-only. However during remounting read-only filesystem to read-write
mode userspace writes can start immediately once we clear SB_RDONLY
flag. This is inconvenient for example for ext4 because we need to do
some writes to the filesystem (such as preparation of quota files)
before we can take userspace writes so we are clearing SB_RDONLY flag
before we are fully ready to accept userpace writes and syzbot has found
a way to exploit this [1]. Also as far as I'm reading the code
the filesystem remount code was protected from racing writes in the
legacy mount path by the mount's MNT_READONLY flag so this is relatively
new problem. It is actually fairly easy to protect remount read-write
from racing writes using sb->s_readonly_remount flag so let's just do
that instead of having to workaround these races in the filesystem code.

[1] https://lore.kernel.org/all/00000000000006a0df05f6667499@google.com/T/

Signed-off-by: Jan Kara <jack@suse.cz>
Message-Id: <20230615113848.8439-1-jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/super.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 09668ddfbbd55..860d7a4b14c7c 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -903,6 +903,7 @@ int reconfigure_super(struct fs_context *fc)
 	struct super_block *sb = fc->root->d_sb;
 	int retval;
 	bool remount_ro = false;
+	bool remount_rw = false;
 	bool force = fc->sb_flags & SB_FORCE;
 
 	if (fc->sb_flags_mask & ~MS_RMT_MASK)
@@ -920,7 +921,7 @@ int reconfigure_super(struct fs_context *fc)
 		    bdev_read_only(sb->s_bdev))
 			return -EACCES;
 #endif
-
+		remount_rw = !(fc->sb_flags & SB_RDONLY) && sb_rdonly(sb);
 		remount_ro = (fc->sb_flags & SB_RDONLY) && !sb_rdonly(sb);
 	}
 
@@ -950,6 +951,14 @@ int reconfigure_super(struct fs_context *fc)
 			if (retval)
 				return retval;
 		}
+	} else if (remount_rw) {
+		/*
+		 * We set s_readonly_remount here to protect filesystem's
+		 * reconfigure code from writes from userspace until
+		 * reconfigure finishes.
+		 */
+		sb->s_readonly_remount = 1;
+		smp_wmb();
 	}
 
 	if (fc->ops->reconfigure) {
-- 
2.39.2

