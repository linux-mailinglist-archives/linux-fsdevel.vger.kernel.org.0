Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25F677035C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 16:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjHDOnt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 10:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjHDOns (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:43:48 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A35D49C1;
        Fri,  4 Aug 2023 07:43:46 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7757C68AA6; Fri,  4 Aug 2023 16:43:43 +0200 (CEST)
Date:   Fri, 4 Aug 2023 16:43:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        syzbot <syzbot+2faac0423fdc9692822b@syzkaller.appspotmail.com>,
        jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in
 test_bdev_super_fc
Message-ID: <20230804144343.GA28230@lst.de>
References: <00000000000058d58e06020c1cab@google.com> <20230804101408.GA23274@lst.de> <20230804-abstieg-behilflich-eda2ce9c2c0f@brauner> <20230804140201.GA27600@lst.de> <20230804-allheilmittel-teleobjektiv-a0351a653d31@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804-allheilmittel-teleobjektiv-a0351a653d31@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 04, 2023 at 04:36:49PM +0200, Christian Brauner wrote:
> FFS

Good spot, this explains the missing dropping of s_umount.

But I don't think it's doing the right thing for MTD mount romfs,
we'll need something like this:

diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index c59b230d55b435..4510a38861cfbe 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -583,16 +583,19 @@ static int romfs_init_fs_context(struct fs_context *fc)
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
