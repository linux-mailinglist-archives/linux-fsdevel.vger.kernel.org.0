Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BFB6F4EF2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 05:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjECDCg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 23:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjECDC1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 23:02:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D211FCA;
        Tue,  2 May 2023 20:02:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD8DF629E8;
        Wed,  3 May 2023 03:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C5FC433EF;
        Wed,  3 May 2023 03:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683082945;
        bh=OIa3Yrwutj4nG9FkVMG15jbwNuAfFxaviWTyPfQyerA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ewoNCwc4XtlIP18WiMNL71ScMT9wh7zxzhDROF962yLpKEY1U8JLT8ee1W9rViFVt
         LN9y0UGQXof6l/KKgE9k0BWhn91DH7yc2/9bH3OQ0Q0xaQsin8S/T26FQigOEV0sIU
         FITsQJxoeIayn7hdCh9slAG9NXloWWtxi5Z9qCcABXGP4Zz85cZSQsh5lHtaupGzf8
         kEORQjtQUbJepMUR4k19Rx8wTkVW5fWdNW5mjMRxPb14S/4/c8/cv0Gq/ad7PyEQZW
         ZHuBVMUswY/K9OrPNvOdSXry0MX//Da2VFu30NAym5npFEMpLtQnjmH+0FSF+mx7nN
         glpupYBJaBuxg==
Subject: [PATCH 2/4] vfs: allow exclusive freezing of filesystems
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, mcgrof@kernel.org,
        ruansy.fnst@fujitsu.com, linux-fsdevel@vger.kernel.org
Date:   Tue, 02 May 2023 20:02:24 -0700
Message-ID: <168308294459.734377.8750093648043068346.stgit@frogsfrogsfrogs>
In-Reply-To: <168308293319.734377.10454919162350827812.stgit@frogsfrogsfrogs>
References: <168308293319.734377.10454919162350827812.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/super.c         |   33 +++++++++++++++++++++++++++++++++
 include/linux/fs.h |    2 ++
 2 files changed, 35 insertions(+)


diff --git a/fs/super.c b/fs/super.c
index 01891f9e6d5e..46abd21f94ac 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1762,6 +1762,24 @@ int freeze_super(struct super_block *sb)
 }
 EXPORT_SYMBOL(freeze_super);
 
+/**
+ * freeze_super_excl - lock the filesystem exclusively and force it into a
+ * consistent state.
+ * @sb: the super to lock
+ * @cookie: magic cookie to associate with this freeze so that only the caller
+ * can thaw the filesystem
+ *
+ * Syncs the super to make sure the filesystem is consistent and calls the fs's
+ * freeze_fs.  Subsequent calls to this without first thawing the fs will
+ * return -EBUSY.  The filesystem must not already be frozen, and can only be
+ * thawed by passing the same cookie to thaw_super_excl.
+ */
+int freeze_super_excl(struct super_block *sb, unsigned long cookie)
+{
+	return __freeze_super(sb, cookie);
+}
+EXPORT_SYMBOL(freeze_super_excl);
+
 static int thaw_super_locked(struct super_block *sb, unsigned long cookie)
 {
 	int error;
@@ -1813,6 +1831,21 @@ int thaw_super(struct super_block *sb)
 }
 EXPORT_SYMBOL(thaw_super);
 
+/**
+ * thaw_super_excl -- unfreeze filesystem
+ * @sb: the super to thaw
+ * @cookie: magic cookie passed to freeze_super_excl
+ *
+ * Releases an exclusive freeze on a filesystem and marks it writeable again
+ * after freeze_super().
+ */
+int thaw_super_excl(struct super_block *sb, unsigned long cookie)
+{
+	down_write(&sb->s_umount);
+	return thaw_super_locked(sb, cookie);
+}
+EXPORT_SYMBOL(thaw_super_excl);
+
 /*
  * Create workqueue for deferred direct IO completions. We allocate the
  * workqueue when it's first needed. This avoids creating workqueue for
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 800772361b1e..3a65bcc45f67 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2272,6 +2272,8 @@ extern int user_statfs(const char __user *, struct kstatfs *);
 extern int fd_statfs(int, struct kstatfs *);
 extern int freeze_super(struct super_block *super);
 extern int thaw_super(struct super_block *super);
+extern int freeze_super_excl(struct super_block *super, unsigned long cookie);
+extern int thaw_super_excl(struct super_block *super, unsigned long cookie);
 extern __printf(2, 3)
 int super_setup_bdi_name(struct super_block *sb, char *fmt, ...);
 extern int super_setup_bdi(struct super_block *sb);

