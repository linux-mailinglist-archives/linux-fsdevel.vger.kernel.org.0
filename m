Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55177B8B57
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244403AbjJDSwp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244290AbjJDSwn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:52:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5020AD;
        Wed,  4 Oct 2023 11:52:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595D0C433C7;
        Wed,  4 Oct 2023 18:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445558;
        bh=AuiZB/7uB4CHbwpVaR4tfn4wAgkza1/YpzIo5Foeud0=;
        h=From:To:Cc:Subject:Date:From;
        b=KTQOzUChrpg+Z0EAPGR8AruwPNLutqOD//NSnAvvth8GSx0cF37vTHIa1kn8pBEap
         CYCEzu+xUbfqSXTKhLzm194LHPOsCHdfPucaxUh3YsdQF5IT/WegZ0Qyl+ewr//1vC
         /daLD8vdiBRwYo5mdVl8W/u+WDb4Rf/GA3sF1WUVvA+ROKAEqgeFBwt995jfGJkwnd
         bZ7xQj55eTB5JOGQwUoBKyq27+Mv+G7mtdaULwpl3MC+y+DeTTxEVZJKzoTyB+A2rz
         cSgj8BMhRVNB+D2FYLBc1jsaSFKjQNTuxo16oRqwigPVjwe86Omd0hkOnhsOF92J53
         mF+huBvz7lhAw==
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
Subject: [PATCH v2 00/89] fs: new accessor methods for inode atime and mtime
Date:   Wed,  4 Oct 2023 14:52:21 -0400
Message-ID: <20231004185221.80802-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
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

v2:
- bugfix in mtime handling
- incorporate _sec and _nsec accessor functions (Chuck Lever)
- move i_generation to plug hole after changing timestamps (Amir Goldstein)

While working on the multigrain timestamp changes, Linus suggested
adding some similar wrappers for accessing the atime and mtime that we
have for the ctime. With that, we could then move to using discrete
integers instead of struct timespec64 in struct inode and shrink it.

This patch implements this. Linus suggested using macros for the new
accessors, but the existing ctime wrappers were static inlines and since
there are only 3 different timestamps, I didn't see that trying to
fiddle with macros would gain us anything (other than less verbosity in
fs.h).

The second to last patch makes the conversion to discrete integers,
which shaves 8 bytes off of struct inode on my x86_64 kernel. The last
patch reshuffles things a little to keep the i_lock in the same
cacheline as the fields it protects.

About 75% of this conversion was done with coccinelle, with the rest
done by hand.

I think we probably ought to try to get everything but the last two
patches into v6.7 (though we could consider those too if we're feeling
lucky).

Jeff Layton (89):
  fs: new accessor methods for atime and mtime
  fs: convert core infrastructure to new timestamp accessors
  spufs: convert to new timestamp accessors
  hypfs: convert to new timestamp accessors
  android: convert to new timestamp accessors
  char: convert to new timestamp accessors
  qib: convert to new timestamp accessors
  ibmasm: convert to new timestamp accessors
  misc: convert to new timestamp accessors
  x86: convert to new timestamp accessors
  tty: convert to new timestamp accessors
  function: convert to new timestamp accessors
  legacy: convert to new timestamp accessors
  usb: convert to new timestamp accessors
  9p: convert to new timestamp accessors
  adfs: convert to new timestamp accessors
  affs: convert to new timestamp accessors
  afs: convert to new timestamp accessors
  autofs: convert to new timestamp accessors
  bcachefs: convert to new timestamp accessors
  befs: convert to new timestamp accessors
  bfs: convert to new timestamp accessors
  btrfs: convert to new timestamp accessors
  ceph: convert to new timestamp accessors
  coda: convert to new timestamp accessors
  configfs: convert to new timestamp accessors
  cramfs: convert to new timestamp accessors
  debugfs: convert to new timestamp accessors
  devpts: convert to new timestamp accessors
  efivarfs: convert to new timestamp accessors
  efs: convert to new timestamp accessors
  erofs: convert to new timestamp accessors
  exfat: convert to new timestamp accessors
  ext2: convert to new timestamp accessors
  ext4: convert to new timestamp accessors
  f2fs: convert to new timestamp accessors
  fat: convert to new timestamp accessors
  freevxfs: convert to new timestamp accessors
  fuse: convert to new timestamp accessors
  gfs2: convert to new timestamp accessors
  hfs: convert to new timestamp accessors
  hfsplus: convert to new timestamp accessors
  hostfs: convert to new timestamp accessors
  hpfs: convert to new timestamp accessors
  hugetlbfs: convert to new timestamp accessors
  isofs: convert to new timestamp accessors
  jffs2: convert to new timestamp accessors
  jfs: convert to new timestamp accessors
  kernfs: convert to new timestamp accessors
  minix: convert to new timestamp accessors
  nfs: convert to new timestamp accessors
  nfsd: convert to new timestamp accessors
  nilfs2: convert to new timestamp accessors
  ntfs: convert to new timestamp accessors
  ntfs3: convert to new timestamp accessors
  ocfs2: convert to new timestamp accessors
  omfs: convert to new timestamp accessors
  openpromfs: convert to new timestamp accessors
  orangefs: convert to new timestamp accessors
  overlayfs: convert to new timestamp accessors
  proc: convert to new timestamp accessors
  pstore: convert to new timestamp accessors
  qnx4: convert to new timestamp accessors
  qnx6: convert to new timestamp accessors
  ramfs: convert to new timestamp accessors
  reiserfs: convert to new timestamp accessors
  romfs: convert to new timestamp accessors
  client: convert to new timestamp accessors
  server: convert to new timestamp accessors
  squashfs: convert to new timestamp accessors
  sysv: convert to new timestamp accessors
  tracefs: convert to new timestamp accessors
  ubifs: convert to new timestamp accessors
  udf: convert to new timestamp accessors
  ufs: convert to new timestamp accessors
  vboxsf: convert to new timestamp accessors
  xfs: convert to new timestamp accessors
  zonefs: convert to new timestamp accessors
  linux: convert to new timestamp accessors
  ipc: convert to new timestamp accessors
  bpf: convert to new timestamp accessors
  mm: convert to new timestamp accessors
  sunrpc: convert to new timestamp accessors
  apparmor: convert to new timestamp accessors
  selinux: convert to new timestamp accessors
  security: convert to new timestamp accessors
  fs: rename inode i_atime and i_mtime fields
  fs: switch timespec64 fields in inode to discrete integers
  fs: move i_generation into new hole created after timestamp conversion

 arch/powerpc/platforms/cell/spufs/inode.c |   2 +-
 arch/s390/hypfs/inode.c                   |   4 +-
 drivers/android/binderfs.c                |   8 +-
 drivers/char/sonypi.c                     |   2 +-
 drivers/infiniband/hw/qib/qib_fs.c        |   4 +-
 drivers/misc/ibmasm/ibmasmfs.c            |   2 +-
 drivers/misc/ibmvmc.c                     |   2 +-
 drivers/platform/x86/sony-laptop.c        |   2 +-
 drivers/tty/tty_io.c                      |  10 +-
 drivers/usb/core/devio.c                  |  26 +++--
 drivers/usb/gadget/function/f_fs.c        |   4 +-
 drivers/usb/gadget/legacy/inode.c         |   2 +-
 fs/9p/vfs_inode.c                         |   6 +-
 fs/9p/vfs_inode_dotl.c                    |  16 +--
 fs/adfs/inode.c                           |  13 ++-
 fs/affs/amigaffs.c                        |   4 +-
 fs/affs/inode.c                           |  17 ++-
 fs/afs/dynroot.c                          |   2 +-
 fs/afs/inode.c                            |   8 +-
 fs/afs/write.c                            |   2 +-
 fs/attr.c                                 |   4 +-
 fs/autofs/inode.c                         |   2 +-
 fs/autofs/root.c                          |   6 +-
 fs/bad_inode.c                            |   2 +-
 fs/bcachefs/fs.c                          |  12 +--
 fs/befs/linuxvfs.c                        |  10 +-
 fs/bfs/dir.c                              |   9 +-
 fs/bfs/inode.c                            |  12 +--
 fs/binfmt_misc.c                          |   2 +-
 fs/btrfs/delayed-inode.c                  |  20 ++--
 fs/btrfs/file.c                           |  18 ++--
 fs/btrfs/inode.c                          |  43 ++++----
 fs/btrfs/reflink.c                        |   2 +-
 fs/btrfs/transaction.c                    |   3 +-
 fs/btrfs/tree-log.c                       |  12 +--
 fs/ceph/addr.c                            |  10 +-
 fs/ceph/caps.c                            |   4 +-
 fs/ceph/file.c                            |   2 +-
 fs/ceph/inode.c                           |  64 ++++++------
 fs/ceph/mds_client.c                      |   8 +-
 fs/ceph/snap.c                            |   4 +-
 fs/coda/coda_linux.c                      |   6 +-
 fs/coda/dir.c                             |   2 +-
 fs/coda/file.c                            |   2 +-
 fs/configfs/inode.c                       |   8 +-
 fs/cramfs/inode.c                         |   4 +-
 fs/debugfs/inode.c                        |   2 +-
 fs/devpts/inode.c                         |   6 +-
 fs/efivarfs/file.c                        |   2 +-
 fs/efivarfs/inode.c                       |   2 +-
 fs/efs/inode.c                            |   5 +-
 fs/erofs/inode.c                          |   3 +-
 fs/exfat/exfat_fs.h                       |   1 +
 fs/exfat/file.c                           |   7 +-
 fs/exfat/inode.c                          |  31 +++---
 fs/exfat/misc.c                           |   8 ++
 fs/exfat/namei.c                          |  31 +++---
 fs/exfat/super.c                          |   4 +-
 fs/ext2/dir.c                             |   6 +-
 fs/ext2/ialloc.c                          |   2 +-
 fs/ext2/inode.c                           |  13 ++-
 fs/ext2/super.c                           |   2 +-
 fs/ext4/ext4.h                            |  20 +++-
 fs/ext4/extents.c                         |  11 +-
 fs/ext4/ialloc.c                          |   4 +-
 fs/ext4/inline.c                          |   4 +-
 fs/ext4/inode.c                           |  19 ++--
 fs/ext4/ioctl.c                           |  13 ++-
 fs/ext4/namei.c                           |  10 +-
 fs/ext4/super.c                           |   2 +-
 fs/ext4/xattr.c                           |   8 +-
 fs/f2fs/dir.c                             |   6 +-
 fs/f2fs/f2fs.h                            |  10 +-
 fs/f2fs/file.c                            |  14 +--
 fs/f2fs/inline.c                          |   2 +-
 fs/f2fs/inode.c                           |  24 ++---
 fs/f2fs/namei.c                           |   4 +-
 fs/f2fs/recovery.c                        |   8 +-
 fs/f2fs/super.c                           |   2 +-
 fs/fat/inode.c                            |  25 +++--
 fs/fat/misc.c                             |   6 +-
 fs/freevxfs/vxfs_inode.c                  |   6 +-
 fs/fuse/control.c                         |   2 +-
 fs/fuse/dir.c                             |  10 +-
 fs/fuse/inode.c                           |  29 +++---
 fs/fuse/readdir.c                         |   6 +-
 fs/gfs2/bmap.c                            |  10 +-
 fs/gfs2/dir.c                             |  10 +-
 fs/gfs2/glops.c                           |  11 +-
 fs/gfs2/inode.c                           |   7 +-
 fs/gfs2/quota.c                           |   2 +-
 fs/gfs2/super.c                           |  12 +--
 fs/hfs/catalog.c                          |   8 +-
 fs/hfs/inode.c                            |  16 +--
 fs/hfs/sysdep.c                           |  10 +-
 fs/hfsplus/catalog.c                      |   8 +-
 fs/hfsplus/inode.c                        |  22 ++--
 fs/hostfs/hostfs_kern.c                   |  12 ++-
 fs/hpfs/dir.c                             |  12 ++-
 fs/hpfs/inode.c                           |  16 +--
 fs/hpfs/namei.c                           |  22 ++--
 fs/hpfs/super.c                           |  10 +-
 fs/hugetlbfs/inode.c                      |  10 +-
 fs/inode.c                                |  35 ++++---
 fs/isofs/inode.c                          |   4 +-
 fs/isofs/rock.c                           |  18 ++--
 fs/jffs2/dir.c                            |  35 ++++---
 fs/jffs2/file.c                           |   4 +-
 fs/jffs2/fs.c                             |  20 ++--
 fs/jffs2/os-linux.h                       |   4 +-
 fs/jfs/inode.c                            |   2 +-
 fs/jfs/jfs_imap.c                         |  20 ++--
 fs/jfs/jfs_inode.c                        |   4 +-
 fs/jfs/namei.c                            |  20 ++--
 fs/jfs/super.c                            |   2 +-
 fs/kernfs/inode.c                         |   6 +-
 fs/libfs.c                                |  41 ++++++--
 fs/minix/bitmap.c                         |   2 +-
 fs/minix/dir.c                            |   6 +-
 fs/minix/inode.c                          |  17 ++-
 fs/minix/itree_common.c                   |   2 +-
 fs/nfs/callback_proc.c                    |   2 +-
 fs/nfs/fscache.h                          |   4 +-
 fs/nfs/inode.c                            |  30 +++---
 fs/nfsd/blocklayout.c                     |   3 +-
 fs/nfsd/nfs3proc.c                        |   4 +-
 fs/nfsd/nfs4proc.c                        |   8 +-
 fs/nfsd/nfsctl.c                          |   2 +-
 fs/nfsd/vfs.c                             |   2 +-
 fs/nilfs2/dir.c                           |   6 +-
 fs/nilfs2/inode.c                         |  20 ++--
 fs/nsfs.c                                 |   2 +-
 fs/ntfs/inode.c                           |  25 ++---
 fs/ntfs/mft.c                             |   2 +-
 fs/ntfs3/file.c                           |   6 +-
 fs/ntfs3/frecord.c                        |  11 +-
 fs/ntfs3/inode.c                          |  25 +++--
 fs/ntfs3/namei.c                          |   4 +-
 fs/ocfs2/acl.c                            |   4 +-
 fs/ocfs2/alloc.c                          |   6 +-
 fs/ocfs2/aops.c                           |   6 +-
 fs/ocfs2/dir.c                            |   9 +-
 fs/ocfs2/dlmfs/dlmfs.c                    |   4 +-
 fs/ocfs2/dlmglue.c                        |  29 +++---
 fs/ocfs2/file.c                           |  30 +++---
 fs/ocfs2/inode.c                          |  28 ++---
 fs/ocfs2/move_extents.c                   |   4 +-
 fs/ocfs2/namei.c                          |  16 +--
 fs/ocfs2/refcounttree.c                   |  12 +--
 fs/ocfs2/xattr.c                          |   4 +-
 fs/omfs/inode.c                           |  12 +--
 fs/openpromfs/inode.c                     |   4 +-
 fs/orangefs/orangefs-utils.c              |  16 +--
 fs/overlayfs/file.c                       |   9 +-
 fs/overlayfs/inode.c                      |   3 +-
 fs/overlayfs/util.c                       |   4 +-
 fs/pipe.c                                 |   2 +-
 fs/proc/base.c                            |   2 +-
 fs/proc/inode.c                           |   2 +-
 fs/proc/proc_sysctl.c                     |   2 +-
 fs/proc/self.c                            |   2 +-
 fs/proc/thread_self.c                     |   2 +-
 fs/pstore/inode.c                         |   5 +-
 fs/qnx4/inode.c                           |   6 +-
 fs/qnx6/inode.c                           |   6 +-
 fs/ramfs/inode.c                          |   7 +-
 fs/reiserfs/inode.c                       |  26 ++---
 fs/reiserfs/namei.c                       |   8 +-
 fs/reiserfs/stree.c                       |   5 +-
 fs/reiserfs/super.c                       |   2 +-
 fs/romfs/super.c                          |   3 +-
 fs/smb/client/file.c                      |  18 ++--
 fs/smb/client/fscache.h                   |   6 +-
 fs/smb/client/inode.c                     |  17 ++-
 fs/smb/client/smb2ops.c                   |   6 +-
 fs/smb/server/smb2pdu.c                   |   8 +-
 fs/squashfs/inode.c                       |   6 +-
 fs/stack.c                                |   4 +-
 fs/stat.c                                 |   4 +-
 fs/sysv/dir.c                             |   6 +-
 fs/sysv/ialloc.c                          |   2 +-
 fs/sysv/inode.c                           |  12 +--
 fs/sysv/itree.c                           |   2 +-
 fs/tracefs/inode.c                        |   2 +-
 fs/ubifs/debug.c                          |  12 +--
 fs/ubifs/dir.c                            |  23 +++--
 fs/ubifs/file.c                           |  16 +--
 fs/ubifs/journal.c                        |  12 +--
 fs/ubifs/super.c                          |   8 +-
 fs/udf/ialloc.c                           |   4 +-
 fs/udf/inode.c                            |  38 ++++---
 fs/udf/namei.c                            |  16 +--
 fs/ufs/dir.c                              |   6 +-
 fs/ufs/ialloc.c                           |   2 +-
 fs/ufs/inode.c                            |  42 ++++----
 fs/vboxsf/utils.c                         |  15 +--
 fs/xfs/libxfs/xfs_inode_buf.c             |  10 +-
 fs/xfs/libxfs/xfs_rtbitmap.c              |   6 +-
 fs/xfs/libxfs/xfs_trans_inode.c           |   2 +-
 fs/xfs/xfs_bmap_util.c                    |   7 +-
 fs/xfs/xfs_inode.c                        |   4 +-
 fs/xfs/xfs_inode_item.c                   |   4 +-
 fs/xfs/xfs_iops.c                         |   8 +-
 fs/xfs/xfs_itable.c                       |  12 +--
 fs/xfs/xfs_rtalloc.c                      |  30 +++---
 fs/zonefs/super.c                         |  10 +-
 include/linux/fs.h                        | 120 +++++++++++++++++-----
 include/linux/fs_stack.h                  |   6 +-
 ipc/mqueue.c                              |  19 ++--
 kernel/bpf/inode.c                        |   5 +-
 mm/shmem.c                                |  20 ++--
 net/sunrpc/rpc_pipe.c                     |   2 +-
 security/apparmor/apparmorfs.c            |   7 +-
 security/apparmor/policy_unpack.c         |   4 +-
 security/inode.c                          |   2 +-
 security/selinux/selinuxfs.c              |   2 +-
 216 files changed, 1220 insertions(+), 1000 deletions(-)

-- 
2.41.0

