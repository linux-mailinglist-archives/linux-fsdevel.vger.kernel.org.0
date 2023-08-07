Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B41772F8B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 21:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjHGTmN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 15:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjHGTla (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:41:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAFF1FD0;
        Mon,  7 Aug 2023 12:40:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBAA0621BE;
        Mon,  7 Aug 2023 19:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F53C0760F;
        Mon,  7 Aug 2023 19:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691437159;
        bh=w/lSN0ukwva6epMNoVXoGECLFjjw4G/9PpuKUglAlXI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=n+ZsTu28M3VdcwnYvSVxoPse+qwGyO+HkVh5pC077q8BEHXzpiyNNUgAHQPYiFJIS
         j6ZKghZfFnGATLTZj4oxP2NYEGEO7AiSUifGgRP68IlVHDXaWCgn54hYIL0JpmM0p+
         CqLzra1OclcPSOt/Hnsh2xZ1sDfSGHbAsCwHm3aTfTxLNmvkLgEmlZKZJ5/0AUuD+R
         Eqm6CVVkz6y/GuBriAK4Wwi5djQ8NvbLaSPToikNPLCl3fBhu8w7JrnSDO0z49QTWe
         mdzgssplnSDCZhdVt8pPDznGidgkZHlZ4hD7/wgE/28c355BGbe+y20j1GWIEszM3w
         vHVLY1B9cMgXw==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Mon, 07 Aug 2023 15:38:36 -0400
Subject: [PATCH v7 05/13] fat: make fat_update_time get its own timestamp
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mgctime-v7-5-d1dec143a704@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1355; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=w/lSN0ukwva6epMNoVXoGECLFjjw4G/9PpuKUglAlXI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk0Ug9pI0NrLPqkw/IVc72gm+1CKA4xq0qrZy8b
 uVUq7nnyrmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZNFIPQAKCRAADmhBGVaC
 Fa9OEACCVBv40jfSNekICILFILSv3kfMvSgBhgjGx95YgjXppdwzEyLLlwpSVrSsRV+cftyGpIm
 fAE/yx7Tg45YQHPEAIjZsXv7bmnKzSjeE6SBYRlzajEuRP5jYccKnpHBkFgt3Bm6CzwTXKsc+wP
 P+Os6/rMfvLYhgIRrsw2TynaKTK+KCmkPhLl2MY80nE/IJJDuKyc12CA3WObaND9DMiDvrpFrVy
 +EpTXRHLFTVw9XhkfotB2MTddGG22XE2bX61v2EY7jVHsLfvCexOUHqHERkOMf7sNYTYBNGbQWj
 GDOTlMmoFkepJxCRNTmBrGPvaEWotzG/J/olLjLSwazaPHviKqV6+YswMlUDwNSkpe3Vj9wVLz4
 2q00zgOWKIlzdWwn+HfMColQvMyebLbvGGAipQSNWb31zah3OmKeUULR8PVuszN88ZNHeezNxXA
 hvZpmJoX1eJLN7m8v8Ed43X/VhazgHgNvOCNu7abZkmYVfTwgI40o7Bd9RLXq+64YqOP+YK+z3Q
 Zq+YbwZYcxNUuUpn+Cgp7YHZUbEsahymP2YrmwqP4Xob7knCd5llIT+NhSveXB+ZQWC6fDyX7Ch
 VbhvDGsvPZ+SUd/2o3PDvfQrzxcr0zoGj7FQvhSljVPTCnHDYuqdBgwJjRAwav0+7Gr4YtL69lE
 MReVPilZbhz9ThA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In later patches, we're going to drop the "now" parameter from the
update_time operation. Fix fat_update_time to fetch its own timestamp.
It turns out that this is easily done by just passing a NULL timestamp
pointer to fat_update_time.

Also, it may be that things have changed by the time we get to calling
fat_update_time after checking inode_needs_update_time. Ensure that we
attempt the i_version bump if any of the S_* flags besides S_ATIME are
set.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fat/misc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index 67006ea08db6..8cab87145d63 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -347,14 +347,14 @@ int fat_update_time(struct inode *inode, struct timespec64 *now, int flags)
 		return 0;
 
 	if (flags & (S_ATIME | S_CTIME | S_MTIME)) {
-		fat_truncate_time(inode, now, flags);
+		fat_truncate_time(inode, NULL, flags);
 		if (inode->i_sb->s_flags & SB_LAZYTIME)
 			dirty_flags |= I_DIRTY_TIME;
 		else
 			dirty_flags |= I_DIRTY_SYNC;
 	}
 
-	if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
+	if ((flags & (S_VERSION|S_CTIME|S_MTIME)) && inode_maybe_inc_iversion(inode, false))
 		dirty_flags |= I_DIRTY_SYNC;
 
 	__mark_inode_dirty(inode, dirty_flags);

-- 
2.41.0

