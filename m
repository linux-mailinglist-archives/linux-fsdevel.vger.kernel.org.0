Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4376D7704B4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 17:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjHDPbC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 11:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjHDPal (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:30:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3D95BB0;
        Fri,  4 Aug 2023 08:29:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 846AE62079;
        Fri,  4 Aug 2023 15:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA49C433C8;
        Fri,  4 Aug 2023 15:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691162981;
        bh=JPc6NMHEB3VXB/775tb2f0hYBmv/DaHjC65CSQgtHQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VaTqflnJs54tfZJx79VVCbcK7jilZVmVgCVBjXlT7Kg1CzpTDLZnlB35NYQryuccI
         SkmGIfS0RLoKo7nFaXp1zpwUqv0KnZ8gI8lVDqZCk8dSEIZbtFWt2VWYBdk53Aue57
         jiRfL1qdYGpGl4tB4UI5tjE40PFrXS7j+nd3I65dZC3aRgIHMhv8OAZaY52dtJEW1e
         Mb0noRod3DB/raSds5GvY+p7/dEQH6wZKWgvrQDLbPjEzOFiZQkY8lT0GE5Vc43DN0
         s91Hd3RqtUrukrtnfZFXwY1lPirGn/v++WZV8IkmZ9QKxEwBr9YhUoOHOJVoyMmMfm
         sgoJSbosTcB3w==
Date:   Fri, 4 Aug 2023 17:29:37 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     syzbot <syzbot+2faac0423fdc9692822b@syzkaller.appspotmail.com>,
        jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in
 test_bdev_super_fc
Message-ID: <20230804-auferlegen-esstisch-fdf67276d18c@brauner>
References: <00000000000058d58e06020c1cab@google.com>
 <20230804101408.GA23274@lst.de>
 <20230804-abstieg-behilflich-eda2ce9c2c0f@brauner>
 <20230804140201.GA27600@lst.de>
 <20230804-allheilmittel-teleobjektiv-a0351a653d31@brauner>
 <20230804144343.GA28230@lst.de>
 <20230804-kurvigen-uninteressant-09d451db7458@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230804-kurvigen-uninteressant-09d451db7458@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 04, 2023 at 04:49:23PM +0200, Christian Brauner wrote:
> On Fri, Aug 04, 2023 at 04:43:43PM +0200, Christoph Hellwig wrote:
> > On Fri, Aug 04, 2023 at 04:36:49PM +0200, Christian Brauner wrote:
> > > FFS
> > 
> > Good spot, this explains the missing dropping of s_umount.
> > 
> > But I don't think it's doing the right thing for MTD mount romfs,
> > we'll need something like this:
> 
> I'll fold a fix into Jan's patch.

Folding:

diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index c59b230d55b4..2b9f3e3c052a 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -583,16 +583,20 @@ static int romfs_init_fs_context(struct fs_context *fc)
  */
 static void romfs_kill_sb(struct super_block *sb)
 {
+	generic_shutdown_super(sb);
+
 #ifdef CONFIG_ROMFS_ON_MTD
 	if (sb->s_mtd) {
-		kill_mtd_super(sb);
-		return;
+		put_mtd_device(sb->s_mtd);
+		sb->s_mtd = NULL;
 	}
 #endif
 #ifdef CONFIG_ROMFS_ON_BLOCK
 	if (sb->s_bdev) {
-		kill_block_super(sb);
-		return;
+		sb->s_bdev->bd_super = NULL;
+		sync_blockdev(sb->s_bdev);
+		blkdev_put(sb->s_bdev, sb->s_type);
 	}
 #endif
 }
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 27c6597aa1be..0b6cc8a03b54 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -485,12 +485,17 @@ static void cramfs_kill_sb(struct super_block *sb)
 {
        struct cramfs_sb_info *sbi = CRAMFS_SB(sb);

+       generic_shutdown_super(sb);
+
        if (IS_ENABLED(CONFIG_CRAMFS_MTD) && sb->s_mtd) {
                if (sbi && sbi->mtd_point_size)
                        mtd_unpoint(sb->s_mtd, 0, sbi->mtd_point_size);
-               kill_mtd_super(sb);
+               put_mtd_device(sb->s_mtd);
+               sb->s_mtd = NULL;
        } else if (IS_ENABLED(CONFIG_CRAMFS_BLOCKDEV) && sb->s_bdev) {
-               kill_block_super(sb);
+               sb->s_bdev->bd_super = NULL;
+               sync_blockdev(sb->s_bdev);
+               blkdev_put(sb->s_bdev, sb->s_type);
        }
        kfree(sbi);
 }


