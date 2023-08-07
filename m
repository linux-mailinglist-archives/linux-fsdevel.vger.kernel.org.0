Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DDB772F73
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 21:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjHGTld (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 15:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjHGTl2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:41:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06ACF1BEA;
        Mon,  7 Aug 2023 12:40:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22C10621D5;
        Mon,  7 Aug 2023 19:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E95C433AD;
        Mon,  7 Aug 2023 19:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691437172;
        bh=BbICkmDBBgSwVYXS6EZd0IrAvg6Sna2OcPY/ygsvt9A=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=To4OoZRwZMZhtMOzlC110JtHszU7IBQi+eF0kpdySXfLmiqOD0w0yv+SVbm9/RWPW
         6+qTqh7chbUbK1cB7KNEd7CzthwW3pvOWmnzVy/F0HEB3bKBfYzPz5sGkAwAvIzz7B
         YtwY/TdyqI39hIdIUyKejqo7jet75+X94OKSM2cIBBFpshpVckDv04dsV4FjoR+Ij/
         fqREz9gj2E4mhd6RDJ+zkFdH3IjF/iknH4D7DA/h2OV3jG1JxbM50o3qRbPjdQhIsi
         51mY/jMlCA/D65p0sDAVkB5bJM4sjLRSG+kwLJ+3ZKphnRpcdJjMaGhbgcd3Cr2dgG
         7x5nw+HV/Yhbw==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Mon, 07 Aug 2023 15:38:38 -0400
Subject: [PATCH v7 07/13] xfs: have xfs_vn_update_time gets its own
 timestamp
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mgctime-v7-7-d1dec143a704@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1281; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=BbICkmDBBgSwVYXS6EZd0IrAvg6Sna2OcPY/ygsvt9A=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk0Ug+aVcwKVBDp9E8rOPtssDQbh7IcGxvS0rwI
 c1S2hBt9TuJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZNFIPgAKCRAADmhBGVaC
 FSPAEACPlCK3EgTnJat9G2lrCllZiR9HeXocxcWOoiDdqnOhA+LCdHCG7FPdv/tU6u5WnxoUH7B
 ARY5BR/8sjxizcFksE2rWBMWCvo/lCt3fEvv/TumLj+HamcwMPPGMuPB/bHhgM4O53ozb4mxyXc
 lBk42qVLhXQ3MpJKcdrAWqVbo5LnY8ffNoMTI9BljHoAWIZZA/FjxrWUD10PTuyI/p95JNSIDCB
 6MjkGDIc9Aa41sfJVYJIe8fYFiGCsBhIgJwOYv44zu1wI4AJx5ZynU4UbweZHqkp2dc8U17oDEG
 8MZvUycGi4MbEufJuFsQMH4rn7w9ETKsguIBXgoT/zt3aRI/dhj4ZBfQcMCgJXkbBEqz0K2cQx9
 tUWV8oyU96vyxSzufIbhSczkroS2v5Uk9TpTq21U2Q3/lLA0Kh02dmR+sN5DgRGjgs8PcsIyumE
 D+5GYVvwgcyhHgdLN2ZLUDDOYzxGk0zl8gn1BuXb0iVHMlEjajc701wdqK191Yz1E8OOA8mx5Gz
 /ZWTo657yfwR4rLHHNlU2jA2S3EjuD9deqANKCDsth+oSL7VOVcmdG+vA7CwskS2JFW3KISHb/o
 EVZxdxxPBB7VOEROYbHIE4wJsXavHzD/Z9/+n6qkWcPntfHcdKgrVLfDRkHmM7z3U4pO5Pssc3p
 xOm62tN6CQuYYsQ==
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

In later patches we're going to drop the "now" parameter from the
update_time operation. Prepare XFS for this by reworking how it fetches
timestamps and sets them in the inode. Ensure that we update the ctime
even if only S_MTIME is set.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/xfs/xfs_iops.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 731f45391baa..72d18e7840f5 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1037,6 +1037,7 @@ xfs_vn_update_time(
 	int			log_flags = XFS_ILOG_TIMESTAMP;
 	struct xfs_trans	*tp;
 	int			error;
+	struct timespec64	now = current_time(inode);
 
 	trace_xfs_update_time(ip);
 
@@ -1056,12 +1057,15 @@ xfs_vn_update_time(
 		return error;
 
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
-	if (flags & S_CTIME)
-		inode_set_ctime_to_ts(inode, *now);
+	if (flags & (S_CTIME|S_MTIME))
+		now = inode_set_ctime_current(inode);
+	else
+		now = current_time(inode);
+
 	if (flags & S_MTIME)
-		inode->i_mtime = *now;
+		inode->i_mtime = now;
 	if (flags & S_ATIME)
-		inode->i_atime = *now;
+		inode->i_atime = now;
 
 	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);
 	xfs_trans_log_inode(tp, ip, log_flags);

-- 
2.41.0

