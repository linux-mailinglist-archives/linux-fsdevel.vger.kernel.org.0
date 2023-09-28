Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE0E7B1965
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjI1LEI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjI1LD7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:03:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0989DCDC;
        Thu, 28 Sep 2023 04:03:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF2CC433CD;
        Thu, 28 Sep 2023 11:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899012;
        bh=2HU082C0O+wshN8razE9iX9Rxehg6mRJCvsU5n9rFmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cgJqBVdgRTRGPcB9AYO9nuxbQNU/aRFlsoq2/9IfdhTUxto7jaIgTs2iK3Hh6VNmI
         PQNGXum64iBmE5gmxTB5fzhsNqjzKt2sLpABU1iY4QR3sLG/3TAi2tRkz3bK5NdR2Q
         5J/x2S1ciuMIVP8CxOGFxyla+hxGROy5UoKNIuzR78QFdYK0UlmPcZ7xnSW65TY0z1
         d09jqnFZdRWx08/ZfFzae3DcpVgwGYgcj94ylvD+5VeIqKKaZOw2/kkGfhLURz1SoJ
         LecijjrtKtsZor5I1BxBnr+8zBdASh0oRnrtfNreKI0opyGPJWi1hjF5WHyNrggNrR
         Xz99F3TmopI2w==
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
        Eric Paris <eparis@parisplace.org>
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
        selinux@vger.kernel.org
Subject: [PATCH 01/87] fs: new accessor methods for atime and mtime
Date:   Thu, 28 Sep 2023 07:03:00 -0400
Message-ID: <20230928110300.32891-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928110300.32891-1-jlayton@kernel.org>
References: <20230928110300.32891-1-jlayton@kernel.org>
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

Recently, we converted the ctime accesses in the kernel to use new
accessor functions. Linus recently pointed out though that if we add
accessors for the atime and mtime, then that would allow us to
seamlessly change how these timestamps are stored in the inode.

Add new accessor functions for the atime and mtime that mirror the
accessors for the ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/libfs.c         | 13 +++++++++++++
 include/linux/fs.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 37f2d34ee090..f5cdc7f7f5b5 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1912,3 +1912,16 @@ ssize_t direct_write_fallback(struct kiocb *iocb, struct iov_iter *iter,
 	return direct_written + buffered_written;
 }
 EXPORT_SYMBOL_GPL(direct_write_fallback);
+
+/**
+ * simple_inode_init_ts - initialize the timestamps for a new inode
+ * @inode: inode to be initialized
+ *
+ * When a new inode is created, most filesystems set the timestamps to the
+ * current time. Add a helper to do this.
+ */
+struct timespec64 simple_inode_init_ts(struct inode *inode);
+{
+	return inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+}
+EXPORT_SYMBOL(simple_inode_init_ts);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b528f063e8ff..12d247b82aa0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1553,6 +1553,48 @@ static inline struct timespec64 inode_set_ctime(struct inode *inode,
 	return inode_set_ctime_to_ts(inode, ts);
 }
 
+static inline struct timespec64 inode_get_atime(const struct inode *inode)
+{
+	return inode->i_atime;
+}
+
+static inline struct timespec64 inode_set_atime_to_ts(struct inode *inode,
+						      struct timespec64 ts)
+{
+	inode->i_atime = ts;
+	return ts;
+}
+
+static inline struct timespec64 inode_set_atime(struct inode *inode,
+						time64_t sec, long nsec)
+{
+	struct timespec64 ts = { .tv_sec  = sec,
+				 .tv_nsec = nsec };
+	return inode_set_atime_to_ts(inode, ts);
+}
+
+static inline struct timespec64 inode_get_mtime(const struct inode *inode)
+{
+	return inode->i_mtime;
+}
+
+static inline struct timespec64 inode_set_mtime_to_ts(struct inode *inode,
+						      struct timespec64 ts)
+{
+	inode->i_mtime = ts;
+	return ts;
+}
+
+static inline struct timespec64 inode_set_mtime(struct inode *inode,
+						time64_t sec, long nsec)
+{
+	struct timespec64 ts = { .tv_sec  = sec,
+				 .tv_nsec = nsec };
+	return inode_set_mtime_to_ts(inode, ts);
+}
+
+struct timespec64 simple_inode_init_ts(struct inode *inode);
+
 /*
  * Snapshotting support.
  */
-- 
2.41.0

