Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F80772F5F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 21:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjHGTlW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 15:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjHGTlU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:41:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BB5199B;
        Mon,  7 Aug 2023 12:40:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14483621C6;
        Mon,  7 Aug 2023 19:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190D6C433CB;
        Mon,  7 Aug 2023 19:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691437152;
        bh=FjK4CXRYiETGn7OzM9We0k7POLcZSDg/Zv0Z2hVxi0I=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Ho/bKlx1W7NVzVpTF8gn0UewKv0nHppAuc8rdt0EpJYDtixyqx9Pm88/s99GjJrGi
         VyWirQXhlLAHTHZVHTzlGto3MlaV9AC0IS4d6ITtkzLyremJTCyhuBghtZLgXI+wFI
         BWGm+mORoGztRukCVECswMBc3DvEXZDbVqOKZXPaUiWJUmCkRudhYLBAFuaGRz0svy
         C36sqbKO7RSDcSDE/CGOWo0cEGgTtCDEY05Q94XhMpgiKRb5sItIEiDQCoyYVBZcIf
         Wa4V9O81hy5cBvQhbAwM4fAHf3aZVD4FS2Awad7m8GiNGAzXgq+KA8NdanYEf8qWKH
         93tAXs2YealYw==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Mon, 07 Aug 2023 15:38:35 -0400
Subject: [PATCH v7 04/13] btrfs: have it use inode_update_timestamps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mgctime-v7-4-d1dec143a704@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1015; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=FjK4CXRYiETGn7OzM9We0k7POLcZSDg/Zv0Z2hVxi0I=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk0Ug9ionAyEQ00FE2RysKd05kyYmr3Uo7M3P+S
 fZsake1O9WJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZNFIPQAKCRAADmhBGVaC
 FSb/D/46K68INm7LKy6yCb3jkxB2bvd3492M0QuN7zYTdZH4x4RyMrHVer1FcL+lgqeruzzWSEv
 f1jPsb2uT+va62GuDI/zejA857D6P77Pxxt62BL6PnF8w9wZfjNo2RBhUJFbcYvEl7WV0QxsBOz
 eVhLOFWlIfBl7qnRoQcQ1EXt/gqm3vncmzxpOhadSWSyAjf3Uyf3ySH1I8zBuzQ6i19jmqQ0RvT
 bb3mEN/W/iBYc3G76Eud3bo16w9EvoB9nxjRlcTuuZvFPC7ModhHKFVftanzKrqnN++LssBxJTt
 qCOGvNDD4XQsoYkNqWK/GeE2dbwuRgBPiPB4T/mRNQGXzoSkgEejZgIlG9UhkKivUvI8mAD1Fvf
 EsZs1aXtF60wPVfCdR9EzkWR98DlT7wHqFko2/J5x3ayqhk5/Hd7Dxd9+3KOUjobqgsNV6z/0hu
 iEa0QiZI9t2vkWtpHGQNGJWoW5i6lWMNl2ugTM4Ph4rAECf19PhJ6QMCL6sLB1t/Yg+5Y9QCkZa
 u6JThQBEJCg3b3v0vqUh9tAePT84Au/SSSO41CUtR4p6gYotqAK/13vCIRlgBGFlSFirEva3rSu
 O4r5y/T/dIV3T3tPLC2QfaJLzkymk/JC3a+VkmmiF/LAO2Y1vQ5KE1bfV2hX76K1OaxCpRxc3+Z
 GjdlHLhrXMsZpbw==
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

In later patches, we're going to drop the "now" argument from the
update_time operation. Have btrfs_update_time use the new
inode_update_timestamps helper to fetch a new timestamp and update it
properly.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/btrfs/inode.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 29a20f828dda..d52e7d64570a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6068,14 +6068,7 @@ static int btrfs_update_time(struct inode *inode, struct timespec64 *now,
 	if (btrfs_root_readonly(root))
 		return -EROFS;
 
-	if (flags & S_VERSION)
-		dirty |= inode_maybe_inc_iversion(inode, dirty);
-	if (flags & S_CTIME)
-		inode_set_ctime_to_ts(inode, *now);
-	if (flags & S_MTIME)
-		inode->i_mtime = *now;
-	if (flags & S_ATIME)
-		inode->i_atime = *now;
+	dirty = inode_update_timestamps(inode, flags);
 	return dirty ? btrfs_dirty_inode(BTRFS_I(inode)) : 0;
 }
 

-- 
2.41.0

