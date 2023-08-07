Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37476772F63
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 21:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjHGTlX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 15:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjHGTlU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:41:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061791999;
        Mon,  7 Aug 2023 12:40:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66942621C9;
        Mon,  7 Aug 2023 19:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BFCC433AB;
        Mon,  7 Aug 2023 19:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691437165;
        bh=GbRbPLOxHLvc3DeuudVIv0R96Xl/KQh1gZUkLNJwaqw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=jyfZZJ6oAnWrzwy6uxMcn981Ztsf8ekdYSTK5OjKoObb52LSWGYUyPDA4kmPqGF1x
         XgdC141GcDjigpVsye6Z2fRW99llsFTyP+IfOKPAc68VweV9PIYC/Q0X43vg8N2M+z
         Az61OjrrYIpqnlx5X/KD2MOToWd0+i939PUFYXt+NeipL/xlWufku7jraVtnp1aZIa
         HYs+6Di3+mpLU5YwTykDK9WTNQJgdVzsmUOkrVgLqaLNB3qJ9kSvdPg+4laJyCR7YJ
         tK4OeZHA9mQJuWModJc5QFspncoFCluv2eVgDmWS58HE9PCjeO01QWlyOyDs3rvs2t
         9FLqopEpWQzeQ==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Mon, 07 Aug 2023 15:38:37 -0400
Subject: [PATCH v7 06/13] ubifs: have ubifs_update_time use
 inode_update_timestamps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mgctime-v7-6-d1dec143a704@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=996; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=GbRbPLOxHLvc3DeuudVIv0R96Xl/KQh1gZUkLNJwaqw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk0Ug9wCd8uHf1JTgjFwTpewg5ScLm1k4tTu02Y
 EC0/mG6MoaJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZNFIPQAKCRAADmhBGVaC
 Fct1EACdouI5B+JSe5rResZvzr2jp0vI9jztehgsnHaGwZpffA5C0T8Yg38sCZ7YdqkMrSalPu3
 w5M7Xcnqdsh4N6Piv9FyxKwRSFhd6L5ltVRVHih3Qrw4CyeqQSC7cF/EoGpJa9WWyMiMRBCPwXS
 SU4LxtVbYmpo45fMxJtALEzmwSMTQIvU1bzpRV4xXlicR54RmnWjkO1z9jdwOxQ6twX9yCYJWhy
 +3XrcrBrTeCS8Z8HreMQGrXDkWsGpGOLe30hRm2zRRGLDwDg58GheX7tI3FJuoWyyPSnXy3GZc3
 IA0WXjumJsnEmtP0TTId+6zh00veQZd5f1GR1l36s9K0aaYaoM1mZs2JdqnG9u0fTI7XR41ftea
 t8+T7wkMIFECd37uaZbjycDqk1RHCXJ9ICgFsL1nEAdkbZL+3Amxg7YLPni5Idxrzm1T01riCL8
 urj0TVjv0LL8Cu70DTcMmlGNYW6HA78KZAiTzBDyB1/8z1iYpiO1fv++ontB2RmfNWnf88B+/uB
 dUK97a5CoO8W1Sg3FRMI1RzkPuF6rcuqwIopnsbtQLtxWCgvC+TTGMRmkaMSjYLODUCN/px7EYj
 1m1keuzLArUPtUidWiCLHEoBgRNimTN+hBNrZNS9Ycr9H0FD7wiIc3WUf0F2tZ/Zb1UbnIJDvl2
 CuiXxVzCtmQDRgA==
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

In later patches, we're going to drop the "now" parameter from the
update_time operation. Prepare ubifs for this, by having it use the new
inode_update_timestamps helper.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ubifs/file.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index df9086b19cd0..2d0178922e19 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1397,15 +1397,9 @@ int ubifs_update_time(struct inode *inode, struct timespec64 *time,
 		return err;
 
 	mutex_lock(&ui->ui_mutex);
-	if (flags & S_ATIME)
-		inode->i_atime = *time;
-	if (flags & S_CTIME)
-		inode_set_ctime_to_ts(inode, *time);
-	if (flags & S_MTIME)
-		inode->i_mtime = *time;
-
-	release = ui->dirty;
+	inode_update_timestamps(inode, flags);
 	__mark_inode_dirty(inode, I_DIRTY_SYNC);
+	release = ui->dirty;
 	mutex_unlock(&ui->ui_mutex);
 	if (release)
 		ubifs_release_budget(c, &req);

-- 
2.41.0

