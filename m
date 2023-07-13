Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B95752D91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 01:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjGMXCo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 19:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbjGMXCR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 19:02:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E69359E;
        Thu, 13 Jul 2023 16:01:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F0B161A8D;
        Thu, 13 Jul 2023 23:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1B3C611A0;
        Thu, 13 Jul 2023 23:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689289300;
        bh=aa5qbguHFcu6OOlBUAepw2+xHt44QiNWyfL22OUBSqs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=BikyFRuCdOODbIqFMPk9kNKNlEo0dYJ6zt4FyqFTbTjpdmiUktdW71dJkcCNhfnr6
         IH8wNPwLcwjFwqbPM9ABFfIZZoaAAjZWuXcaDgVP/9O9ow8exs0ur2EO1mxw06CUVs
         OIVi6P2uBcHxFX31zL/bkUGRt7Vk6GxZq50OE6iR5Xkgc+XbbqUbUANDiMMWaLTCgU
         9YSpAieiO+VbSduJMVGrLCDzqj6M76cg/ERleiQQWLvjl1lRNaDYvlOMtASHc3hRxY
         3zxwROtQCWYj4ZhKhLitrJ1WKe8G5IuDdn4pkmXKWnP8iuqxCuy46i0Jj0SbW9jVX2
         AHP5DZp2LCIgA==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Thu, 13 Jul 2023 19:00:54 -0400
Subject: [PATCH v5 5/8] xfs: XFS_ICHGTIME_CREATE is unused
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-mgctime-v5-5-9eb795d2ae37@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1284; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=aa5qbguHFcu6OOlBUAepw2+xHt44QiNWyfL22OUBSqs=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBksIIuYLDaeyv+0bFKxMDi4TCGl7qNqh97QkbqR
 7MnTf0XpqqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZLCCLgAKCRAADmhBGVaC
 FdKeD/90gpS8fulOOgQezr1N2uNArvD5brmGxA6b7tTzZSvcpOejwinrQKvQhs+PxBZDriYQCQh
 OwxNuTnA93R76ZkHT+sLOHGoGBQ6UBAtkzGtxH9v1fgcuhwappw6969ZTeRpLIIWBZ0MFdVDXTe
 YFcM04RAjErJxaPi7Kt5ULpq1V7YIjHa0dovLbQ7frkm24o+WlVOqKpXRct7ZQqa2k6bkGFkhed
 NZPwy8zsD4D/ZthBftUASAETJsO1x4cs1v02gmv4U6YR4J39mE20H8TT+918pwwZU/VSIOj1M8H
 Oirc7oG/xtEnVFeE6nGc9DoXtvpO3IUf1FdW5mKKcKqLzZoKXfj3gk1gLXOX0mdQ2JHPZcGc49+
 LHI8cuBfrkN/yVk5aVMC/t0fyaM1xcR+wuz2sQL3b3ax5gG8hx3oSg5INanDl7BDUq7lbtQYpHC
 44+w5XUDYxIFpjAozvDGpAzbAsZNp/fmKeaNAFZ0DPSY2csmopw1l3HzeL2s29LE29J+DbWrN4Q
 dQtkbmyLS83Mo3Rus7OEOTowcfLEdmVZ4nlYwkUBpsAbUeo3Gpzvy+DYU8t8ma/Kb96NS7sEx81
 5WULDzoq4LwO4MreHRa/DvZr0oyyhT5qcmZWNWLeSdaA0x6eEh2hzaWN9VBX+UNVXANgJRn57fJ
 LrcnCGwsCj+PM0g==
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

Nothing ever sets this flag, which makes sense since the create time is
set at inode instantiation and is never changed. Remove it and the
handling of it in xfs_trans_ichgtime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/xfs/libxfs/xfs_shared.h      | 2 --
 fs/xfs/libxfs/xfs_trans_inode.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_shared.h b/fs/xfs/libxfs/xfs_shared.h
index c4381388c0c1..8989fff21723 100644
--- a/fs/xfs/libxfs/xfs_shared.h
+++ b/fs/xfs/libxfs/xfs_shared.h
@@ -126,8 +126,6 @@ void	xfs_log_get_max_trans_res(struct xfs_mount *mp,
  */
 #define	XFS_ICHGTIME_MOD	0x1	/* data fork modification timestamp */
 #define	XFS_ICHGTIME_CHG	0x2	/* inode field change timestamp */
-#define	XFS_ICHGTIME_CREATE	0x4	/* inode create timestamp */
-
 
 /*
  * Symlink decoding/encoding functions
diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
index 6b2296ff248a..0c9df8df6d4a 100644
--- a/fs/xfs/libxfs/xfs_trans_inode.c
+++ b/fs/xfs/libxfs/xfs_trans_inode.c
@@ -68,8 +68,6 @@ xfs_trans_ichgtime(
 		inode->i_mtime = tv;
 	if (flags & XFS_ICHGTIME_CHG)
 		inode_set_ctime_to_ts(inode, tv);
-	if (flags & XFS_ICHGTIME_CREATE)
-		ip->i_crtime = tv;
 }
 
 /*

-- 
2.41.0

