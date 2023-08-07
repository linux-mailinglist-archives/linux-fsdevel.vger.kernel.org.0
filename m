Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36BA772F98
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 21:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjHGTmf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 15:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjHGTmM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:42:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5491BF2;
        Mon,  7 Aug 2023 12:41:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F8C161E99;
        Mon,  7 Aug 2023 19:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49771C433CA;
        Mon,  7 Aug 2023 19:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691437212;
        bh=lN6s1sXYpzZ9zzv+tSr/8W/OSaIgZC0r+RsL44K+ZH4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=BXYIfqRhJmmhTr7H/Icv+LIuWhDZCq/Fa1QRxA+FYLQy2wVZqeWUxx42Zy1D2KHG6
         N9f651EMax2NVBCBn5bV355x82CMFZzIF9NFtZTNMQuMc8PPjNdqhP5807woRO0S1L
         unL76YzDYl/Jyxr64UYrZRgboyNg8b5R6XBWSW1cdvBy4sSpnihqb6O64V71kQqQA0
         rv2AZehRSWUVQSsQ/ncedHudpMEP+YOTSmdYEkchMRZKS5w/cIAc4xSsjQJ5LVg6BR
         hz+4C4ymLLgsYLwW8lN7mhC6Rb7gMPMFCCxK63a6AC2kUKL3pzc6gmqk1xu3OLbPLv
         3oiS19af0OHPQ==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Mon, 07 Aug 2023 15:38:44 -0400
Subject: [PATCH v7 13/13] btrfs: convert to multigrain timestamps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mgctime-v7-13-d1dec143a704@kernel.org>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
In-Reply-To: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Tyler Hicks <code@tyhicks.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Hans de Goede <hdegoede@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-mtd@lists.infradead.org, linux-mm@kvack.org,
        linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2749; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=lN6s1sXYpzZ9zzv+tSr/8W/OSaIgZC0r+RsL44K+ZH4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk0Ug+oJ8Ypfkd3hBsHRXz54oWzrHgL8wg9atAa
 a6AaAYOQe+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZNFIPgAKCRAADmhBGVaC
 FQzzD/9PH4jzuGOTNBwrlcwrXYpmsGoZmIYR7R9NcCgR/m849MEjiNCDcWP1i1bDX/e8eYMeeJz
 nwC8Yx2MVO1bdnRBgCa+FIqSkV0mceQ3qPA/qobLKnjwb9FcXrfPuXm5WqewuobxvEz7f1xeSoT
 SF2L+MCnFCanG2OucqJ0gsSHFEcd6Zv7Zwr67KsR4fLn49cnSZy19D0iluSsIZqNMKCDC8aibR/
 I8YkhXhbP8+E2AF2CzKv/l68U9VSS4wlrH+kKLn1Ekubzye9qYsMJRP6/E1x18Ycv4Lj0ISvnfV
 q3HI7BIVYj/34CUEhwOrlSErM56MnkTDJW1F7sDLx5+uhGDdw7I5wEUkTSRIp0xwhn0FKjQn+FQ
 BaHqVH1bEYlB6ppBWLQv+R0DeNzxWZjZDJijMFcQNaowYQ1YKNU+BOXRBjkVQpTjqOs7OTZCx4v
 kElqk78njNIJTjfhDC27It2facIRGRq29s+WWxI9RvaWaVjxaEnnGV/J9qBNT0VADJgAK+uiGMU
 l/WfpwpXbaJFg003gNz9+L5VruoQhn+o0rtkuiJU8+b/qkEKKX5afyqNzac7/COFOu3Hn2w26v+
 k3AFETgjkMG2IEhpt4fz2wV2VsKNkreROGaaH0HJ3+XVcu3mQRVb1A4LUl/3AWJLqwsAEi9gj+Y
 5SJevE3lM1tE7aQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Enable multigrain timestamps, which should ensure that there is an
apparent change to the timestamp whenever it has been written after
being actively observed via getattr.

Beyond enabling the FS_MGTIME flag, this patch eliminates
update_time_for_write, which goes to great pains to avoid in-memory
stores. Just have it overwrite the timestamps unconditionally.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Acked-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/file.c  | 24 ++++--------------------
 fs/btrfs/super.c |  5 +++--
 2 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index d7a9ece7a40b..b9e75c9f95ac 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1106,25 +1106,6 @@ void btrfs_check_nocow_unlock(struct btrfs_inode *inode)
 	btrfs_drew_write_unlock(&inode->root->snapshot_lock);
 }
 
-static void update_time_for_write(struct inode *inode)
-{
-	struct timespec64 now, ctime;
-
-	if (IS_NOCMTIME(inode))
-		return;
-
-	now = current_time(inode);
-	if (!timespec64_equal(&inode->i_mtime, &now))
-		inode->i_mtime = now;
-
-	ctime = inode_get_ctime(inode);
-	if (!timespec64_equal(&ctime, &now))
-		inode_set_ctime_to_ts(inode, now);
-
-	if (IS_I_VERSION(inode))
-		inode_inc_iversion(inode);
-}
-
 static int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from,
 			     size_t count)
 {
@@ -1156,7 +1137,10 @@ static int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from,
 	 * need to start yet another transaction to update the inode as we will
 	 * update the inode when we finish writing whatever data we write.
 	 */
-	update_time_for_write(inode);
+	if (!IS_NOCMTIME(inode)) {
+		inode->i_mtime = inode_set_ctime_current(inode);
+		inode_inc_iversion(inode);
+	}
 
 	start_pos = round_down(pos, fs_info->sectorsize);
 	oldsize = i_size_read(inode);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f1dd172d8d5b..8eda51b095c9 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2144,7 +2144,7 @@ static struct file_system_type btrfs_fs_type = {
 	.name		= "btrfs",
 	.mount		= btrfs_mount,
 	.kill_sb	= btrfs_kill_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_MGTIME,
 };
 
 static struct file_system_type btrfs_root_fs_type = {
@@ -2152,7 +2152,8 @@ static struct file_system_type btrfs_root_fs_type = {
 	.name		= "btrfs",
 	.mount		= btrfs_mount_root,
 	.kill_sb	= btrfs_kill_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_ALLOW_IDMAP,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA |
+			  FS_ALLOW_IDMAP | FS_MGTIME,
 };
 
 MODULE_ALIAS_FS("btrfs");

-- 
2.41.0

