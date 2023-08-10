Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DE8777CB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 17:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbjHJPvV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 11:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjHJPvU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:51:20 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B81F1AA;
        Thu, 10 Aug 2023 08:51:20 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8CD7567373; Thu, 10 Aug 2023 17:51:16 +0200 (CEST)
Date:   Thu, 10 Aug 2023 17:51:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 01/13] xfs: reformat the xfs_fs_free prototype
Message-ID: <20230810155116.GC28000@lst.de>
References: <20230809220545.1308228-1-hch@lst.de> <20230809220545.1308228-2-hch@lst.de> <20230810-unmerklich-grandios-281ae311e396@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810-unmerklich-grandios-281ae311e396@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I think the btrfs hunk (below) in "fs: use the super_block as holder when
mounting file systems" needs to be dropped, as we dropped the prep patch
that allows to use the sb as a holder for now.  I'll add it to my resend
of the btrfs conversion.

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f1dd172d8d5bd7..d58ace4c1d2962 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -69,8 +69,6 @@ static const struct super_operations btrfs_super_ops;
  * requested by subvol=/path. That way the callchain is straightforward and we
  * don't have to play tricks with the mount options and recursive calls to
  * btrfs_mount.
- *
- * The new btrfs_root_fs_type also servers as a tag for the bdev_holder.
  */
 static struct file_system_type btrfs_fs_type;
 static struct file_system_type btrfs_root_fs_type;
@@ -1515,7 +1513,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
 		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s", fs_type->name,
 					s->s_id);
-		btrfs_sb(s)->bdev_holder = fs_type;
+		fs_info->bdev_holder = s;
 		error = btrfs_fill_super(s, fs_devices, data);
 	}
 	if (!error)
