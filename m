Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BB3797789
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 18:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237494AbjIGQ1D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 12:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjIGQ0C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:26:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3EF3AAD;
        Thu,  7 Sep 2023 09:21:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE78C32775;
        Thu,  7 Sep 2023 13:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694094849;
        bh=EIpNSgNgC6LNjnAD//F7CyvaVZ/tPj26U/cNJ/JhfpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tSr9CwoOVN61H0+dopAxtJ1Zg4QF//neTXKzZHc0IRNVVq5Lo9X+TNU7rEo3ABg+B
         kW5xMjwYKAs01eBuhsi/0v+lz8qJwlr/1JzrwRQkKqi5lrvT8SifyeODtZ7VpE0Ib4
         25qn28FDHXw6R2HkcngROF6gokwRLmnxicmbZCo4rjr0p2L/U/XVbCUtvt4iG3Tbke
         XiUhGzAeJVSjJ6VfIJTo5T3f7Vl0qBxlDp/1Cmo4lI3ueO5Ferfa2DFBQkaHNbau5o
         aIpqeIKGio8HsskAe/LbMe5oueC8iQhrI64agLHo5e85uxXnjdE5K5tZGfgPE79poi
         LzwccPKAQyLow==
Date:   Thu, 7 Sep 2023 15:54:04 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 13/13] ntfs3: free the sbi in ->kill_sb
Message-ID: <20230907-lektion-organismus-f223e15828d9@brauner>
References: <20230809220545.1308228-1-hch@lst.de>
 <20230809220545.1308228-14-hch@lst.de>
 <56f72849-178a-4cb7-b2e1-b7fc6695a6ef@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qhjgiapx27p2h6ha"
Content-Disposition: inline
In-Reply-To: <56f72849-178a-4cb7-b2e1-b7fc6695a6ef@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--qhjgiapx27p2h6ha
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Thu, Sep 07, 2023 at 06:05:40AM -0700, Guenter Roeck wrote:
> On Wed, Aug 09, 2023 at 03:05:45PM -0700, Christoph Hellwig wrote:
> > As a rule of thumb everything allocated to the fs_context and moved into
> > the super_block should be freed by ->kill_sb so that the teardown
> > handling doesn't need to be duplicated between the fill_super error
> > path and put_super.  Implement an ntfs3-specific kill_sb method to do
> > that.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Christian Brauner <brauner@kernel.org>
> 
> This patch results in:

The appended patch should fix this. Are you able to test it?
I will as well.

--qhjgiapx27p2h6ha
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-ntfs3-put-inodes-in-ntfs3_put_super.patch"

From 55d5075cd668eda6a08aaf6569cbc556db8a952b Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 7 Sep 2023 15:52:28 +0200
Subject: [PATCH] ntfs3: put inodes in ntfs3_put_super()

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ntfs3/super.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 5fffddea554f..4c73afd935e7 100644
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
+static noinline void ntfs3_free_sbi(struct ntfs_sb_info *sbi)
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
-- 
2.34.1


--qhjgiapx27p2h6ha--
