Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415D6797732
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 18:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239176AbjIGQWb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 12:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241763AbjIGQVx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:21:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687737EF9
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Sep 2023 09:19:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8589BC433D9;
        Thu,  7 Sep 2023 16:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694102660;
        bh=2iWWIs9Cw3cd+C0R7DZ44Oi4EPcWtnpbV9JxkNhh8Fs=;
        h=From:Date:Subject:To:Cc:From;
        b=DlSYC4ewgDf1qEwgUpJ0EYq8s+OMPU3KzmgbN0GlN/K5JlAWlid9TfojYZj3gdQ9q
         FZ9c2XVn14+08zlNe3PQUFsSy7dQmVyCJav6GPjRFk8eA7XHZRG/lwe64dRwFgrWHS
         pELg2a4s8CMGyKlNt4G3G19CcGPFdvNe6FEl4DP8uSs6uptPfFhmvmKos8O7Qt9d3b
         W+5LH2JSG5vWxcsINE7LP9GuYQwKh8ycRAVn7xq0lw3js4XlAZZrQ34+yAlbFbDY4L
         XmUD9utBHXgIm1a69/B41F0xZp5dHEQ9ocgH2GdYS2x5FtLBQhYeeKrJCumkESOXaZ
         VYMN1FAcmUsxg==
From:   Christian Brauner <brauner@kernel.org>
Date:   Thu, 07 Sep 2023 18:03:40 +0200
Subject: [PATCH] ntfs3: drop inode references in ntfs_put_super()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230907-vfs-ntfs3-kill_sb-v1-1-ef4397dd941d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFv0+WQC/x3M0QqCQBCF4VeRuW5gW7OoV4mIHZ3NIdtkRiQQ3
 92xy4/D+RcwVmGDW7WA8iwm3+I4Hipo+1RejNK5IYZYh2u44JwNy5StxrcMw9MIm0h0zo3v3Qn
 8Nypn+f2b94ebkjGSptL2e+mTbGKFdd0ASVV4KHwAAAA=
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@lst.de>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, ntfs3@lists.linux.dev,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=openpgp-sha256; l=2735; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2iWWIs9Cw3cd+C0R7DZ44Oi4EPcWtnpbV9JxkNhh8Fs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT8/NK0Qe4hfwn/nc8Juq27NL14YsvXTZrZxvBLMvuibEl7
 1PvfHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO58IXhr2h9snHeqrPXF/gJLoguaJ
 eP+OBuqaseYnVF2n27gkBULsMf/kmxJXpr3zUbPNTxSmLdP7/SusTkwNybqdM2PpoQW36HBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Recently we moved most cleanup from ntfs_put_super() into
ntfs3_kill_sb() as part of a bigger cleanup. This accidently also moved
dropping inode references stashed in ntfs3's sb->s_fs_info from
@sb->put_super() to @sb->kill_sb(). But generic_shutdown_super()
verifies that there are no busy inodes past sb->put_super(). Fix this
and disentangle dropping inode references from freeing @sb->s_fs_info.

Fixes: a4f64a300a29 ("ntfs3: free the sbi in ->kill_sb") # mainline only
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Hey Linus,

Would you mind applying this patch directly? It's a simple fix for an
ntfs3 bug that was introduced by some refactoring we did in mainline
only. Guenter reported it and both he and I verified that this patch
fixes the issue. I can also resend it as a PR tomorrow if you prefer.

Thanks!
Christian
---
 fs/ntfs3/super.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 5fffddea554f..cfec5e0c7f66 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -571,12 +571,8 @@ static void init_once(void *foo)
 /*
  * Noinline to reduce binary size.
  */
-static noinline void ntfs3_free_sbi(struct ntfs_sb_info *sbi)
+static noinline void ntfs3_put_sbi(struct ntfs_sb_info *sbi)
 {
-	kfree(sbi->new_rec);
-	kvfree(ntfs_put_shared(sbi->upcase));
-	kfree(sbi->def_table);
-
 	wnd_close(&sbi->mft.bitmap);
 	wnd_close(&sbi->used.bitmap);
 
@@ -601,6 +597,13 @@ static noinline void ntfs3_free_sbi(struct ntfs_sb_info *sbi)
 	indx_clear(&sbi->security.index_sdh);
 	indx_clear(&sbi->reparse.index_r);
 	indx_clear(&sbi->objid.index_o);
+}
+
+static void ntfs3_free_sbi(struct ntfs_sb_info *sbi)
+{
+	kfree(sbi->new_rec);
+	kvfree(ntfs_put_shared(sbi->upcase));
+	kfree(sbi->def_table);
 	kfree(sbi->compress.lznt);
 #ifdef CONFIG_NTFS3_LZX_XPRESS
 	xpress_free_decompressor(sbi->compress.xpress);
@@ -625,6 +628,7 @@ static void ntfs_put_super(struct super_block *sb)
 
 	/* Mark rw ntfs as clear, if possible. */
 	ntfs_set_state(sbi, NTFS_DIRTY_CLEAR);
+	ntfs3_put_sbi(sbi);
 }
 
 static int ntfs_statfs(struct dentry *dentry, struct kstatfs *buf)
@@ -1644,8 +1648,10 @@ static void ntfs_fs_free(struct fs_context *fc)
 	struct ntfs_mount_options *opts = fc->fs_private;
 	struct ntfs_sb_info *sbi = fc->s_fs_info;
 
-	if (sbi)
+	if (sbi) {
+		ntfs3_put_sbi(sbi);
 		ntfs3_free_sbi(sbi);
+	}
 
 	if (opts)
 		put_mount_options(opts);

---
base-commit: 7ba2090ca64ea1aa435744884124387db1fac70f
change-id: 20230907-vfs-ntfs3-kill_sb-52bb6f5230d4

