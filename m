Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784C97317D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 13:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344651AbjFOLsg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 07:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344650AbjFOLsR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:48:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146263AB3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 04:44:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 81AD21FD98;
        Thu, 15 Jun 2023 11:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686829360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=BhmOHdzCSP0SmFgbVGFENLVTi6XXcBWQemYl+LFq0yg=;
        b=MKHhtP3c/hU85uay9PFn7TrMv1XVJCcgrftd+bJr2tweWuN2u3xMEKMPPv53uDwMmRs7nx
        Qxrb9lhU/thOyUYsg6ubga9v5sDH35IHRmd0ari4Gn28dKBikVzvpWOUvMkv2lZ5vs+2rt
        2av9bOLBe5GsWQweblgCus4aUH2z4S4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686829360;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=BhmOHdzCSP0SmFgbVGFENLVTi6XXcBWQemYl+LFq0yg=;
        b=6PYHRCLYYUY/8UA22JCk0YL5r/nC9jX7vFFSW3e4oEj2dCBRIXwSYZxqzXfMDMu0zoAaV7
        0oYcN9T66RiPewBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7200A13467;
        Thu, 15 Jun 2023 11:42:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PHjMGzD5imSgGgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 15 Jun 2023 11:42:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 06B61A0755; Thu, 15 Jun 2023 13:42:40 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        Ted Tso <tytso@mit.edu>, David Howells <dhowells@redhat.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] fs: Protect reconfiguration of sb read-write from racing writes
Date:   Thu, 15 Jun 2023 13:38:48 +0200
Message-Id: <20230615113848.8439-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2238; i=jack@suse.cz; h=from:subject; bh=DdnHqbpGLaTgLfSfSjjCW6u8t+xpOjAnel8v+b0m7+M=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkivgyyFJ65tW1X7UGKUHxojWL2a6yYVjAsfhxrSom pmVN/5uJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZIr4MgAKCRCcnaoHP2RA2e1+B/ 4jMLicAZkP2nH16jbYt7igOR3FQRQ1c+5UqHCc+2Hx7TL0pxPXL1Ank5eGZLcNwmexWEQDhauXJRgS lduXCjC9JyMoQv3BkQJiq2crAj6xxOgUZ5VuOH9zp/i8l7re6jYLBfg2X3qnLprLznvz1yg64gJ4+Y nfLG6fXQqdAQZ7TbipUqiA71hHw8b1jVKw1i5b2ARJ+lNArUFKhcVrNJeJZwHijqABozKfOEaXzgXV lZaL8TE4eC2WZTduYTglXjZ1gAEvSv9spdC6Uf+VJvVJtjp3vNmRAZ3DcmRZjk+uM7nIiBvG2dT0T4 RyUB3vEfXRbgKXEtCZTC9FgXtUZQaK
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
---
 fs/super.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 34afe411cf2b..6cd64961aa07 100644
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
2.35.3

