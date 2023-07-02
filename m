Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDBF74506B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jul 2023 21:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjGBTiV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jul 2023 15:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjGBTiU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:38:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D78A7;
        Sun,  2 Jul 2023 12:38:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91C3360C75;
        Sun,  2 Jul 2023 19:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CBAC433C8;
        Sun,  2 Jul 2023 19:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326699;
        bh=TSX3Rrl6WtObg7OskbwOx637gCEJc8c5D/jlEoi634U=;
        h=From:To:Cc:Subject:Date:From;
        b=OwVIhBk+q+1GWFJHF9vIgKWQ/pRSD6cHUvKOkxUXOH7ZvfOZmjAb9gZ3KCM4fHhTZ
         KA0FTucUo4v66al0S2OCYy3EtIPp3MzDCdJGRvDogMoHc0J90LugGCU/010GGfvdKY
         vWPSHeDC2bWMLPBAHBEjFGSO+A3okhHEPM9pEWwnqJvWaN655fVqh7lLWet2Wly65K
         dfqYcQNM1i+GMALnokH1pr2m6eI/0XC2W2/RngK97gkL7HXS8qA4deNafOhF9mW+WD
         jWjASiRIw9BwkzCjdOK10qWYIbZYztuOBbd2wmRmlsGS+EEM/EMJwbI1HE1N42OK/T
         gk/TD+FAKVK0g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Sasha Levin <sashal@kernel.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 01/16] vfs: Replace all non-returning strlcpy with strscpy
Date:   Sun,  2 Jul 2023 15:38:00 -0400
Message-Id: <20230702193815.1775684-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Azeem Shaikh <azeemshaikh38@gmail.com>

[ Upstream commit c642256b91770e201519d037a91f255a617a4602 ]

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Message-Id: <20230510221119.3508930-1-azeemshaikh38@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/char_dev.c | 2 +-
 fs/super.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index 13deb45f1ec65..950b6919fb872 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -150,7 +150,7 @@ __register_chrdev_region(unsigned int major, unsigned int baseminor,
 	cd->major = major;
 	cd->baseminor = baseminor;
 	cd->minorct = minorct;
-	strlcpy(cd->name, name, sizeof(cd->name));
+	strscpy(cd->name, name, sizeof(cd->name));
 
 	if (!prev) {
 		cd->next = curr;
diff --git a/fs/super.c b/fs/super.c
index 04bc62ab7dfea..09668ddfbbd55 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -595,7 +595,7 @@ struct super_block *sget_fc(struct fs_context *fc,
 	fc->s_fs_info = NULL;
 	s->s_type = fc->fs_type;
 	s->s_iflags |= fc->s_iflags;
-	strlcpy(s->s_id, s->s_type->name, sizeof(s->s_id));
+	strscpy(s->s_id, s->s_type->name, sizeof(s->s_id));
 	list_add_tail(&s->s_list, &super_blocks);
 	hlist_add_head(&s->s_instances, &s->s_type->fs_supers);
 	spin_unlock(&sb_lock);
@@ -674,7 +674,7 @@ struct super_block *sget(struct file_system_type *type,
 		return ERR_PTR(err);
 	}
 	s->s_type = type;
-	strlcpy(s->s_id, type->name, sizeof(s->s_id));
+	strscpy(s->s_id, type->name, sizeof(s->s_id));
 	list_add_tail(&s->s_list, &super_blocks);
 	hlist_add_head(&s->s_instances, &type->fs_supers);
 	spin_unlock(&sb_lock);
-- 
2.39.2

