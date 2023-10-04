Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B70D7B8B9B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244768AbjJDSyE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244662AbjJDSxX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:53:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD55EAD;
        Wed,  4 Oct 2023 11:53:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991D0C4AF5D;
        Wed,  4 Oct 2023 18:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445590;
        bh=D6ZmjuGzwm6T+vyily+kDIFcQOdKBE4hFTbZ/ePB+AU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=itt8PzKJ3oWcrWlkMnCNvO4V6JTvOPUcLklZdoWmgvE5EApLHzHWrmToC24YZNaD5
         IXhfNXxqslFjk2IDoML0tgHmxZeVSse9inCpsSBFQSfTlM1ZaWIaW/14Rx1EGjZsGv
         ntPIZbb8JIR5CnQGLAz3U+Yl+EqlRJ7alNTo2vhAqP1qPDfCkGnYm9uO4hbjfLGGYe
         YEvpoo+MWSAaL6IHDgaS7acBet/4WUTpUf2h/c5f8fTK/EJTvBZGCYjPEshuHePoR6
         5qJESbj+fdqCM8yjNUYu0BZ+4eFYl4Bgrydaw45QVSAj3T6mpEPEYoifAe1zFkZy7d
         wEjqNw+7VtILg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, Jeremy Kerr <jk@ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Mattia Dongili <malattia@linux.it>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Brad Warrum <bwarrum@linux.ibm.com>,
        Ritu Agarwal <rituagar@linux.ibm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Ian Kent <raven@themaw.net>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        Nicolas Pitre <nico@fluxnic.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>, Jan Kara <jack@suse.cz>,
        David Woodhouse <dwmw2@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>, Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Bob Copeland <me@bobcopeland.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Anders Larsen <al@alarsen.net>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, v9fs@lists.linux.dev,
        linux-afs@lists.infradead.org, autofs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, linux-efi@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, gfs2@lists.linux.dev,
        linux-um@lists.infradead.org, linux-mtd@lists.infradead.org,
        jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-unionfs@vger.kernel.org, linux-hardening@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org,
        linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-bcachefs@vger.kernel.org
Subject: [PATCH v2 02/89] fs: convert core infrastructure to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:38 -0400
Message-ID: <20231004185239.80830-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004185239.80830-1-jlayton@kernel.org>
References: <20231004185221.80802-1-jlayton@kernel.org>
 <20231004185239.80830-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert the core vfs code to use the new timestamp accessor functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/attr.c        |  4 ++--
 fs/bad_inode.c   |  2 +-
 fs/binfmt_misc.c |  2 +-
 fs/inode.c       | 35 +++++++++++++++++++++--------------
 fs/nsfs.c        |  2 +-
 fs/pipe.c        |  2 +-
 fs/stack.c       |  4 ++--
 fs/stat.c        |  4 ++--
 8 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index a8ae5f6d9b16..bdf5deb06ea9 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -308,9 +308,9 @@ void setattr_copy(struct mnt_idmap *idmap, struct inode *inode,
 	i_uid_update(idmap, attr, inode);
 	i_gid_update(idmap, attr, inode);
 	if (ia_valid & ATTR_ATIME)
-		inode->i_atime = attr->ia_atime;
+		inode_set_atime_to_ts(inode, attr->ia_atime);
 	if (ia_valid & ATTR_MTIME)
-		inode->i_mtime = attr->ia_mtime;
+		inode_set_mtime_to_ts(inode, attr->ia_mtime);
 	if (ia_valid & ATTR_CTIME)
 		inode_set_ctime_to_ts(inode, attr->ia_ctime);
 	if (ia_valid & ATTR_MODE) {
diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 83f9566c973b..316d88da2ce1 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -208,7 +208,7 @@ void make_bad_inode(struct inode *inode)
 	remove_inode_hash(inode);
 
 	inode->i_mode = S_IFREG;
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	inode->i_op = &bad_inode_ops;	
 	inode->i_opflags &= ~IOP_XATTR;
 	inode->i_fop = &bad_file_ops;	
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index e0108d17b085..5d2be9b0a0a5 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -547,7 +547,7 @@ static struct inode *bm_get_inode(struct super_block *sb, int mode)
 	if (inode) {
 		inode->i_ino = get_next_ino();
 		inode->i_mode = mode;
-		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+		simple_inode_init_ts(inode);
 	}
 	return inode;
 }
diff --git a/fs/inode.c b/fs/inode.c
index 3bb6193f436c..4f8984b97df0 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1837,27 +1837,29 @@ EXPORT_SYMBOL(bmap);
 static int relatime_need_update(struct vfsmount *mnt, struct inode *inode,
 			     struct timespec64 now)
 {
-	struct timespec64 ctime;
+	struct timespec64 atime, mtime, ctime;
 
 	if (!(mnt->mnt_flags & MNT_RELATIME))
 		return 1;
 	/*
 	 * Is mtime younger than or equal to atime? If yes, update atime:
 	 */
-	if (timespec64_compare(&inode->i_mtime, &inode->i_atime) >= 0)
+	atime = inode_get_atime(inode);
+	mtime = inode_get_mtime(inode);
+	if (timespec64_compare(&mtime, &atime) >= 0)
 		return 1;
 	/*
 	 * Is ctime younger than or equal to atime? If yes, update atime:
 	 */
 	ctime = inode_get_ctime(inode);
-	if (timespec64_compare(&ctime, &inode->i_atime) >= 0)
+	if (timespec64_compare(&ctime, &atime) >= 0)
 		return 1;
 
 	/*
 	 * Is the previous atime value older than a day? If yes,
 	 * update atime:
 	 */
-	if ((long)(now.tv_sec - inode->i_atime.tv_sec) >= 24*60*60)
+	if ((long)(now.tv_sec - atime.tv_sec) >= 24*60*60)
 		return 1;
 	/*
 	 * Good, we can skip the atime update:
@@ -1888,12 +1890,13 @@ int inode_update_timestamps(struct inode *inode, int flags)
 
 	if (flags & (S_MTIME|S_CTIME|S_VERSION)) {
 		struct timespec64 ctime = inode_get_ctime(inode);
+		struct timespec64 mtime = inode_get_mtime(inode);
 
 		now = inode_set_ctime_current(inode);
 		if (!timespec64_equal(&now, &ctime))
 			updated |= S_CTIME;
-		if (!timespec64_equal(&now, &inode->i_mtime)) {
-			inode->i_mtime = now;
+		if (!timespec64_equal(&now, &mtime)) {
+			inode_set_mtime_to_ts(inode, now);
 			updated |= S_MTIME;
 		}
 		if (IS_I_VERSION(inode) && inode_maybe_inc_iversion(inode, updated))
@@ -1903,8 +1906,10 @@ int inode_update_timestamps(struct inode *inode, int flags)
 	}
 
 	if (flags & S_ATIME) {
-		if (!timespec64_equal(&now, &inode->i_atime)) {
-			inode->i_atime = now;
+		struct timespec64 atime = inode_get_atime(inode);
+
+		if (!timespec64_equal(&now, &atime)) {
+			inode_set_atime_to_ts(inode, now);
 			updated |= S_ATIME;
 		}
 	}
@@ -1963,7 +1968,7 @@ EXPORT_SYMBOL(inode_update_time);
 bool atime_needs_update(const struct path *path, struct inode *inode)
 {
 	struct vfsmount *mnt = path->mnt;
-	struct timespec64 now;
+	struct timespec64 now, atime;
 
 	if (inode->i_flags & S_NOATIME)
 		return false;
@@ -1989,7 +1994,8 @@ bool atime_needs_update(const struct path *path, struct inode *inode)
 	if (!relatime_need_update(mnt, inode, now))
 		return false;
 
-	if (timespec64_equal(&inode->i_atime, &now))
+	atime = inode_get_atime(inode);
+	if (timespec64_equal(&atime, &now))
 		return false;
 
 	return true;
@@ -2106,17 +2112,18 @@ static int inode_needs_update_time(struct inode *inode)
 {
 	int sync_it = 0;
 	struct timespec64 now = current_time(inode);
-	struct timespec64 ctime;
+	struct timespec64 ts;
 
 	/* First try to exhaust all avenues to not sync */
 	if (IS_NOCMTIME(inode))
 		return 0;
 
-	if (!timespec64_equal(&inode->i_mtime, &now))
+	ts = inode_get_mtime(inode);
+	if (!timespec64_equal(&ts, &now))
 		sync_it = S_MTIME;
 
-	ctime = inode_get_ctime(inode);
-	if (!timespec64_equal(&ctime, &now))
+	ts = inode_get_ctime(inode);
+	if (!timespec64_equal(&ts, &now))
 		sync_it |= S_CTIME;
 
 	if (IS_I_VERSION(inode) && inode_iversion_need_inc(inode))
diff --git a/fs/nsfs.c b/fs/nsfs.c
index 647a22433bd8..9a4b228d42fa 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -84,7 +84,7 @@ static int __ns_get_path(struct path *path, struct ns_common *ns)
 		return -ENOMEM;
 	}
 	inode->i_ino = ns->inum;
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	inode->i_flags |= S_IMMUTABLE;
 	inode->i_mode = S_IFREG | S_IRUGO;
 	inode->i_fop = &ns_file_operations;
diff --git a/fs/pipe.c b/fs/pipe.c
index 485e3be8903c..8916c455a469 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -908,7 +908,7 @@ static struct inode * get_pipe_inode(void)
 	inode->i_mode = S_IFIFO | S_IRUSR | S_IWUSR;
 	inode->i_uid = current_fsuid();
 	inode->i_gid = current_fsgid();
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 
 	return inode;
 
diff --git a/fs/stack.c b/fs/stack.c
index b5e01bdb5f5f..f18920119944 100644
--- a/fs/stack.c
+++ b/fs/stack.c
@@ -66,8 +66,8 @@ void fsstack_copy_attr_all(struct inode *dest, const struct inode *src)
 	dest->i_uid = src->i_uid;
 	dest->i_gid = src->i_gid;
 	dest->i_rdev = src->i_rdev;
-	dest->i_atime = src->i_atime;
-	dest->i_mtime = src->i_mtime;
+	inode_set_atime_to_ts(dest, inode_get_atime(src));
+	inode_set_mtime_to_ts(dest, inode_get_mtime(src));
 	inode_set_ctime_to_ts(dest, inode_get_ctime(src));
 	dest->i_blkbits = src->i_blkbits;
 	dest->i_flags = src->i_flags;
diff --git a/fs/stat.c b/fs/stat.c
index d43a5cc1bfa4..24bb0209e459 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -57,8 +57,8 @@ void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
 	stat->gid = vfsgid_into_kgid(vfsgid);
 	stat->rdev = inode->i_rdev;
 	stat->size = i_size_read(inode);
-	stat->atime = inode->i_atime;
-	stat->mtime = inode->i_mtime;
+	stat->atime = inode_get_atime(inode);
+	stat->mtime = inode_get_mtime(inode);
 	stat->ctime = inode_get_ctime(inode);
 	stat->blksize = i_blocksize(inode);
 	stat->blocks = inode->i_blocks;
-- 
2.41.0

