Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28910752DAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 01:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjGMXDl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 19:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbjGMXCe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 19:02:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365C430E9;
        Thu, 13 Jul 2023 16:02:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5F0761B86;
        Thu, 13 Jul 2023 23:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2C8C433BD;
        Thu, 13 Jul 2023 23:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689289319;
        bh=t187d4hlj7Hd2B853hoiIPlXJE4vBx7O1lkOZGTYDW8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=BS7k3xvm0kV8VQrl/+Nc8umWhgO+pb9JT0LHiIqUglobFvawLeTwqlzQHpVKTDZvB
         uzCvx/VSEkD7rBjIYWrgFJPCVeqzpiWP8yPt0omTj30LLcay2tknCTfGbRYu6T8MHO
         XUKoIaSo5n/Bd8IGVTxHqLGvMrjMe0fw+PscScTZ4jWUdNZ+2byzzdy+o175llL7m5
         o50SLzukRXrSYzl6VaWT8ZrHwmm4KFENLB31WgFlIK5T2Pi03WKPiptSSMpQZPxFLm
         ct6V/7uDGKKjKZCyDiQclhCznfyT/lEVKO0vqyqaIX9NPJI1Mx1EUf0gKBJYoL63GW
         31d2FfqFHu4Cw==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Thu, 13 Jul 2023 19:00:57 -0400
Subject: [PATCH v5 8/8] btrfs: convert to multigrain timestamps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-mgctime-v5-8-9eb795d2ae37@kernel.org>
References: <20230713-mgctime-v5-0-9eb795d2ae37@kernel.org>
In-Reply-To: <20230713-mgctime-v5-0-9eb795d2ae37@kernel.org>
To:     Eric Van Hensbergen <ericvh@kernel.org>,
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
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
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
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Hans de Goede <hdegoede@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, v9fs@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-nfs@vger.kernel.org,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        devel@lists.orangefs.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-mtd@lists.infradead.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2706; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=t187d4hlj7Hd2B853hoiIPlXJE4vBx7O1lkOZGTYDW8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBksIIv0d3fY46+2hyVZzGgFlf73uVo9uOX8lOx6
 K4UVJ9Da6yJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZLCCLwAKCRAADmhBGVaC
 FbztD/4uZXXSyTwCnSezUKeydXdyB1DOo4czPXF+iJ085mANTre9b4XbUvuEDf9bQijKjYvAiIF
 T6aBATLxstNxy4RGAHDXtSLWG232Ink6G1PNMhMC9R96FpJsuPjmMk8NUBog9j/mjyhM2PlaAMX
 tX5JL88Tb2gI1FbBxP6pQJCDRkYxbfydZ/FGNzZuAcvlJMt3BH7bGga81LPIjr5UOfLB+GnI8oe
 i5BFOw+r7A+Xu+KDGowTNXor3TGmR763yaM7A/mcig5Jp20jEJIXDGO1tVgSdAP0LebIstIif+9
 kiMe/3MWPnPs0eVd+mEtYR53HfccdkA9ShOKV+Jx7qg5v2TSojDh7bRQBVb22NQZGRPBlgv2560
 X83w+MU7yhsMU1MCxv2Whg6ooLLErWX5Zp68rM1FJYdQ/3YbvfDj6sg+4Aa3PF5ifwLM33BLCLr
 pXwEOeLySTL3OWSfSzMqbNqkSShHhPhxZs+ZtZsqAM1fTRTO3svFqI7T/IFjBt7NKwvQJKyhtIJ
 syGts3Gf66X08k1+2iwyGMuP2FA8o0TGMTCwUBXZtxQhhH4KlMpwsdFurHxhcT/j4CtVbSAH4Uc
 fB3KEuG+QiBPD89OSHahxCRhPa+vWgmHHVnmaRK/PJC6un6LOOBM1as6ikNxs/Lc9yixCPrHMNq
 /XZRVwDe3wtNV8A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

