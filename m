Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86AC748C43
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 20:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjGES6g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 14:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjGES6e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 14:58:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C6D171E;
        Wed,  5 Jul 2023 11:58:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 479C1616D1;
        Wed,  5 Jul 2023 18:58:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6490C433C8;
        Wed,  5 Jul 2023 18:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583511;
        bh=0xs97Nw0Ki/BD4oxBMJBIFiVob4TDeDS1tgBnhC1Tm4=;
        h=From:To:Subject:Date:From;
        b=Uf/i/U8ZSa4UcQ1jcgnZqB1kMqkl9AeT9d45BD18S54++HyiDp/ty3RcWB0879l8q
         F3Mu2mZpY2FBiRl2GspXfDaUssMvohbXgspdwZ9ynN+CuV9I6vDCyg+6dptCTbUeMc
         y4nGOo3W/kSJKnEGr+CYvDsz8VL18/XkkpvTVpsDCHkwzTTbg1YrAhGkvN7lAvoJFd
         u6jrgitdiwWye6WeH/hmaiqI3t9mX/fUSPjhiBafWPUl0h3dzbDobolXC02s8N4EG0
         70T0KjO3GrNXgIWOscb8tzgSE3dkCSlH6aRHRKkPuZFD+yV/SVNnAYHFdu/E18SnrC
         QEr0CaP+ES7iQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     jk@ozlabs.org, arnd@arndb.de, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
        cmllamas@google.com, surenb@google.com,
        dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        leon@kernel.org, bwarrum@linux.ibm.com, rituagar@linux.ibm.com,
        ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
        linux_oss@crudebyte.com, dsterba@suse.com, dhowells@redhat.com,
        marc.dionne@auristor.com, viro@zeniv.linux.org.uk,
        raven@themaw.net, luisbg@kernel.org, salah.triki@gmail.com,
        aivazian.tigran@gmail.com, ebiederm@xmission.com,
        keescook@chromium.org, clm@fb.com, josef@toxicpanda.com,
        xiubli@redhat.com, idryomov@gmail.com, jlayton@kernel.org,
        jaharkes@cs.cmu.edu, coda@cs.cmu.edu, jlbec@evilplan.org,
        hch@lst.de, nico@fluxnic.net, rafael@kernel.org, code@tyhicks.com,
        ardb@kernel.org, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com,
        linkinjeon@kernel.org, sj1557.seo@samsung.com, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        hirofumi@mail.parknet.co.jp, miklos@szeredi.hu,
        rpeterso@redhat.com, agruenba@redhat.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        mikulas@artax.karlin.mff.cuni.cz, mike.kravetz@oracle.com,
        muchun.song@linux.dev, dwmw2@infradead.org, shaggy@kernel.org,
        tj@kernel.org, trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com, neilb@suse.de, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com, konishi.ryusuke@gmail.com,
        anton@tuxera.com, almaz.alexandrovich@paragon-software.com,
        mark@fasheh.com, joseph.qi@linux.alibaba.com, me@bobcopeland.com,
        hubcap@omnibond.com, martin@omnibond.com, amir73il@gmail.com,
        mcgrof@kernel.org, yzaikin@google.com, tony.luck@intel.com,
        gpiccoli@igalia.com, al@alarsen.net, sfrench@samba.org,
        pc@manguebit.com, lsahlber@redhat.com, sprasad@microsoft.com,
        senozhatsky@chromium.org, phillip@squashfs.org.uk,
        rostedt@goodmis.org, mhiramat@kernel.org, dushistov@mail.ru,
        hdegoede@redhat.com, djwong@kernel.org, dlemoal@kernel.org,
        naohiro.aota@wdc.com, jth@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, hughd@google.com, akpm@linux-foundation.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, john.johansen@canonical.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        jgross@suse.com, stern@rowland.harvard.edu, lrh2000@pku.edu.cn,
        sebastian.reichel@collabora.com, wsa+renesas@sang-engineering.com,
        quic_ugoswami@quicinc.com, quic_linyyuan@quicinc.com,
        john@keeping.me.uk, error27@gmail.com, quic_uaggarwa@quicinc.com,
        hayama@lineo.co.jp, jomajm@gmail.com, axboe@kernel.dk,
        dhavale@google.com, dchinner@redhat.com, hannes@cmpxchg.org,
        zhangpeng362@huawei.com, slava@dubeyko.com, gargaditya08@live.com,
        penguin-kernel@I-love.SAKURA.ne.jp, yifeliu@cs.stonybrook.edu,
        madkar@cs.stonybrook.edu, ezk@cs.stonybrook.edu,
        yuzhe@nfschina.com, willy@infradead.org, okanatov@gmail.com,
        jeffxu@chromium.org, linux@treblig.org, mirimmad17@gmail.com,
        yijiangshan@kylinos.cn, yang.yang29@zte.com.cn,
        xu.xin16@zte.com.cn, chengzhihao1@huawei.com, shr@devkernel.io,
        Liam.Howlett@Oracle.com, adobriyan@gmail.com,
        chi.minghao@zte.com.cn, roberto.sassu@huawei.com,
        linuszeng@tencent.com, bvanassche@acm.org, zohar@linux.ibm.com,
        yi.zhang@huawei.com, trix@redhat.com, fmdefrancesco@gmail.com,
        ebiggers@google.com, princekumarmaurya06@gmail.com,
        chenzhongjin@huawei.com, riel@surriel.com,
        shaozhengchao@huawei.com, jingyuwang_vip@163.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-usb@vger.kernel.org, v9fs@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        autofs@vger.kernel.org, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-um@lists.infradead.org,
        linux-mtd@lists.infradead.org,
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
Subject: [PATCH v2 00/89] fs: new accessors for inode->i_ctime
Date:   Wed,  5 Jul 2023 14:58:09 -0400
Message-ID: <20230705185812.579118-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

v2:
- prepend patches to add missing ctime updates
- add simple_rename_timestamp helper function
- rename ctime accessor functions as inode_get_ctime/inode_set_ctime_*
- drop individual inode_ctime_set_{sec,nsec} helpers

I've been working on a patchset to change how the inode->i_ctime is
accessed in order to give us conditional, high-res timestamps for the
ctime and mtime. struct timespec64 has unused bits in it that we can use
to implement this. In order to do that however, we need to wrap all
accesses of inode->i_ctime to ensure that bits used as flags are
appropriately handled.

The patchset starts with reposts of some missing ctime updates that I
spotted in the tree. It then adds a new helper function for updating the
timestamp after a successful rename, and new ctime accessor
infrastructure.

The bulk of the patchset is individual conversions of different
subsysteme to use the new infrastructure. Finally, the patchset renames
the i_ctime field to __i_ctime to help ensure that I didn't miss
anything.

This should apply cleanly to linux-next as of this morning.

Most of this conversion was done via 5 different coccinelle scripts, run
in succession, with a large swath of by-hand conversions to clean up the
remainder.

The coccinelle scripts that were used are below:

::::::::::::::
cocci/ctime1.cocci
::::::::::::::
// convert as much to use inode_set_ctime_current as possible
@@
identifier timei;
struct inode *inode;
expression E1, E2;
@@
(
- inode->i_ctime = E1 = E2 = current_time(timei)
+ E1 = E2 = inode_set_ctime_current(inode)
|
- inode->i_ctime = E1 = current_time(timei)
+ E1 = inode_set_ctime_current(inode)
|
- E1 = inode->i_ctime = current_time(timei)
+ E1 = inode_set_ctime_current(inode)
|
- inode->i_ctime = current_time(timei)
+ inode_set_ctime_current(inode)
)

@@
struct inode *inode;
expression E1, E2, E3;
@@
(
- E1 = current_time(inode)
+ E1 = inode_set_ctime_current(inode)
|
- E1 = current_time(E3)
+ E1 = inode_set_ctime_current(inode)
)
...
(
- inode->i_ctime = E1;
|
- E2 = inode->i_ctime = E1;
+ E2 = E1;
)
::::::::::::::
cocci/ctime2.cocci
::::::::::::::
// get the places that set individual timespec64 fields
@@
struct inode *inode;
expression val, val2;
@@
- inode->i_ctime.tv_sec = val
+ inode_set_ctime(inode, val, val2)
...
- inode->i_ctime.tv_nsec = val2;

// get places that just set the tv_sec
@@
struct inode *inode;
expression sec, E1, E2, E3;
@@
(
- E3 = inode->i_ctime.tv_sec = sec
+ E3 = inode_set_ctime(inode, sec, 0).tv_sec
|
- inode->i_ctime.tv_sec = sec
+ inode_set_ctime(inode, sec, 0)
)
<...
(
- inode->i_ctime.tv_nsec = 0;
|
- E1 = inode->i_ctime.tv_nsec = 0
+ E1 = 0
|
- inode->i_ctime.tv_nsec = E1 = 0
+ E1 = 0
|
- inode->i_ctime.tv_nsec = E1 = E2 = 0
+ E1 = E2 = 0
)
...>

::::::::::::::
cocci/ctime3.cocci
::::::::::::::
// convert places that set i_ctime to a timespec64 directly
@@
struct inode *inode;
expression ts, E1, E2;
@@
(
- inode->i_ctime = E1 = E2 = ts
+ E1 = E2 = inode_set_ctime_to_ts(inode, ts)
|
- inode->i_ctime = E1 = ts
+ E1 = inode_set_ctime_to_ts(inode, ts)
|
- inode->i_ctime = ts
+ inode_set_ctime_to_ts(inode, ts)
)
::::::::::::::
cocci/ctime4.cocci
::::::::::::::
// catch places that set the i_ctime in an inode embedded in another structure
@@
expression E1, E2, E3;
@@
(
- E3.i_ctime = E1 = E2 = current_time(&E3)
+ E1 = E2 = inode_set_ctime_current(&E3)
|
- E3.i_ctime = E1 = current_time(&E3)
+ E1 = inode_set_ctime_current(&E3)
|
- E1 = E3.i_ctime = current_time(&E3)
+ E1 = inode_set_ctime_current(&E3)
|
- E3.i_ctime = current_time(&E3)
+ inode_set_ctime_current(&E3)
)
::::::::::::::
cocci/ctime5.cocci
::::::::::::::
// convert the remaining i_ctime accesses
@@
struct inode *inode;
@@
- inode->i_ctime
+ inode_get_ctime(inode)


Jeff Layton (92):
  ibmvmc: update ctime in conjunction with mtime on write
  bfs: update ctime in addition to mtime when adding entries
  efivarfs: update ctime when mtime changes on a write
  exfat: ensure that ctime is updated whenever the mtime is
  apparmor: update ctime whenever the mtime changes on an inode
  cifs: update the ctime on a partial page write
  fs: add ctime accessors infrastructure
  fs: new helper: simple_rename_timestamp
  btrfs: convert to simple_rename_timestamp
  ubifs: convert to simple_rename_timestamp
  shmem: convert to simple_rename_timestamp
  exfat: convert to simple_rename_timestamp
  ntfs3: convert to simple_rename_timestamp
  reiserfs: convert to simple_rename_timestamp
  spufs: convert to ctime accessor functions
  s390: convert to ctime accessor functions
  binderfs: convert to ctime accessor functions
  infiniband: convert to ctime accessor functions
  ibm: convert to ctime accessor functions
  usb: convert to ctime accessor functions
  9p: convert to ctime accessor functions
  adfs: convert to ctime accessor functions
  affs: convert to ctime accessor functions
  afs: convert to ctime accessor functions
  fs: convert to ctime accessor functions
  autofs: convert to ctime accessor functions
  befs: convert to ctime accessor functions
  bfs: convert to ctime accessor functions
  btrfs: convert to ctime accessor functions
  ceph: convert to ctime accessor functions
  coda: convert to ctime accessor functions
  configfs: convert to ctime accessor functions
  cramfs: convert to ctime accessor functions
  debugfs: convert to ctime accessor functions
  devpts: convert to ctime accessor functions
  ecryptfs: convert to ctime accessor functions
  efivarfs: convert to ctime accessor functions
  efs: convert to ctime accessor functions
  erofs: convert to ctime accessor functions
  exfat: convert to ctime accessor functions
  ext2: convert to ctime accessor functions
  ext4: convert to ctime accessor functions
  f2fs: convert to ctime accessor functions
  fat: convert to ctime accessor functions
  freevxfs: convert to ctime accessor functions
  fuse: convert to ctime accessor functions
  gfs2: convert to ctime accessor functions
  hfs: convert to ctime accessor functions
  hfsplus: convert to ctime accessor functions
  hostfs: convert to ctime accessor functions
  hpfs: convert to ctime accessor functions
  hugetlbfs: convert to ctime accessor functions
  isofs: convert to ctime accessor functions
  jffs2: convert to ctime accessor functions
  jfs: convert to ctime accessor functions
  kernfs: convert to ctime accessor functions
  nfs: convert to ctime accessor functions
  nfsd: convert to ctime accessor functions
  nilfs2: convert to ctime accessor functions
  ntfs: convert to ctime accessor functions
  ntfs3: convert to ctime accessor functions
  ocfs2: convert to ctime accessor functions
  omfs: convert to ctime accessor functions
  openpromfs: convert to ctime accessor functions
  orangefs: convert to ctime accessor functions
  overlayfs: convert to ctime accessor functions
  procfs: convert to ctime accessor functions
  pstore: convert to ctime accessor functions
  qnx4: convert to ctime accessor functions
  qnx6: convert to ctime accessor functions
  ramfs: convert to ctime accessor functions
  reiserfs: convert to ctime accessor functions
  romfs: convert to ctime accessor functions
  smb: convert to ctime accessor functions
  squashfs: convert to ctime accessor functions
  sysv: convert to ctime accessor functions
  tracefs: convert to ctime accessor functions
  ubifs: convert to ctime accessor functions
  udf: convert to ctime accessor functions
  ufs: convert to ctime accessor functions
  vboxsf: convert to ctime accessor functions
  xfs: convert to ctime accessor functions
  zonefs: convert to ctime accessor functions
  linux: convert to ctime accessor functions
  mqueue: convert to ctime accessor functions
  bpf: convert to ctime accessor functions
  shmem: convert to ctime accessor functions
  sunrpc: convert to ctime accessor functions
  apparmor: convert to ctime accessor functions
  security: convert to ctime accessor functions
  selinux: convert to ctime accessor functions
  fs: rename i_ctime field to __i_ctime

 arch/powerpc/platforms/cell/spufs/inode.c |  2 +-
 arch/s390/hypfs/inode.c                   |  4 +-
 drivers/android/binderfs.c                |  8 ++--
 drivers/infiniband/hw/qib/qib_fs.c        |  3 +-
 drivers/misc/ibmasm/ibmasmfs.c            |  2 +-
 drivers/misc/ibmvmc.c                     |  2 +-
 drivers/usb/core/devio.c                  | 16 +++----
 drivers/usb/gadget/function/f_fs.c        |  3 +-
 drivers/usb/gadget/legacy/inode.c         |  3 +-
 fs/9p/vfs_inode.c                         |  4 +-
 fs/9p/vfs_inode_dotl.c                    |  8 ++--
 fs/adfs/inode.c                           |  4 +-
 fs/affs/amigaffs.c                        |  6 +--
 fs/affs/inode.c                           | 16 +++----
 fs/afs/dynroot.c                          |  2 +-
 fs/afs/inode.c                            |  6 +--
 fs/attr.c                                 |  2 +-
 fs/autofs/inode.c                         |  2 +-
 fs/autofs/root.c                          |  6 +--
 fs/bad_inode.c                            |  3 +-
 fs/befs/linuxvfs.c                        |  2 +-
 fs/bfs/dir.c                              | 16 +++----
 fs/bfs/inode.c                            |  5 +--
 fs/binfmt_misc.c                          |  3 +-
 fs/btrfs/delayed-inode.c                  |  8 ++--
 fs/btrfs/file.c                           | 21 ++++-----
 fs/btrfs/inode.c                          | 54 ++++++++--------------
 fs/btrfs/ioctl.c                          |  2 +-
 fs/btrfs/reflink.c                        |  3 +-
 fs/btrfs/transaction.c                    |  3 +-
 fs/btrfs/tree-log.c                       |  4 +-
 fs/btrfs/xattr.c                          |  4 +-
 fs/ceph/acl.c                             |  2 +-
 fs/ceph/caps.c                            |  2 +-
 fs/ceph/inode.c                           | 17 ++++---
 fs/ceph/snap.c                            |  2 +-
 fs/ceph/xattr.c                           |  2 +-
 fs/coda/coda_linux.c                      |  3 +-
 fs/coda/dir.c                             |  2 +-
 fs/coda/file.c                            |  2 +-
 fs/coda/inode.c                           |  2 +-
 fs/configfs/inode.c                       |  7 ++-
 fs/cramfs/inode.c                         |  3 +-
 fs/debugfs/inode.c                        |  3 +-
 fs/devpts/inode.c                         |  6 +--
 fs/ecryptfs/inode.c                       |  2 +-
 fs/efivarfs/file.c                        |  2 +-
 fs/efivarfs/inode.c                       |  2 +-
 fs/efs/inode.c                            |  4 +-
 fs/erofs/inode.c                          | 15 +++----
 fs/exfat/file.c                           |  4 +-
 fs/exfat/inode.c                          |  6 +--
 fs/exfat/namei.c                          | 26 +++++------
 fs/exfat/super.c                          |  3 +-
 fs/ext2/acl.c                             |  2 +-
 fs/ext2/dir.c                             |  6 +--
 fs/ext2/ialloc.c                          |  2 +-
 fs/ext2/inode.c                           | 10 ++---
 fs/ext2/ioctl.c                           |  4 +-
 fs/ext2/namei.c                           |  8 ++--
 fs/ext2/super.c                           |  2 +-
 fs/ext2/xattr.c                           |  2 +-
 fs/ext4/acl.c                             |  2 +-
 fs/ext4/ext4.h                            | 21 +++++++++
 fs/ext4/extents.c                         | 12 ++---
 fs/ext4/ialloc.c                          |  2 +-
 fs/ext4/inline.c                          |  4 +-
 fs/ext4/inode.c                           | 16 +++----
 fs/ext4/ioctl.c                           |  9 ++--
 fs/ext4/namei.c                           | 26 +++++------
 fs/ext4/super.c                           |  2 +-
 fs/ext4/xattr.c                           |  6 +--
 fs/f2fs/dir.c                             |  8 ++--
 fs/f2fs/f2fs.h                            |  4 +-
 fs/f2fs/file.c                            | 20 ++++-----
 fs/f2fs/inline.c                          |  2 +-
 fs/f2fs/inode.c                           | 10 ++---
 fs/f2fs/namei.c                           | 12 ++---
 fs/f2fs/recovery.c                        |  4 +-
 fs/f2fs/super.c                           |  2 +-
 fs/f2fs/xattr.c                           |  2 +-
 fs/fat/inode.c                            |  7 +--
 fs/fat/misc.c                             |  3 +-
 fs/freevxfs/vxfs_inode.c                  |  3 +-
 fs/fuse/control.c                         |  2 +-
 fs/fuse/dir.c                             |  8 ++--
 fs/fuse/inode.c                           | 16 +++----
 fs/gfs2/acl.c                             |  2 +-
 fs/gfs2/bmap.c                            | 11 +++--
 fs/gfs2/dir.c                             | 15 ++++---
 fs/gfs2/file.c                            |  2 +-
 fs/gfs2/glops.c                           |  4 +-
 fs/gfs2/inode.c                           |  8 ++--
 fs/gfs2/super.c                           |  4 +-
 fs/gfs2/xattr.c                           |  8 ++--
 fs/hfs/catalog.c                          |  8 ++--
 fs/hfs/dir.c                              |  2 +-
 fs/hfs/inode.c                            | 13 +++---
 fs/hfs/sysdep.c                           |  4 +-
 fs/hfsplus/catalog.c                      |  8 ++--
 fs/hfsplus/dir.c                          |  6 +--
 fs/hfsplus/inode.c                        | 16 ++++---
 fs/hostfs/hostfs_kern.c                   |  3 +-
 fs/hpfs/dir.c                             |  8 ++--
 fs/hpfs/inode.c                           |  6 +--
 fs/hpfs/namei.c                           | 26 ++++++-----
 fs/hpfs/super.c                           |  5 ++-
 fs/hugetlbfs/inode.c                      | 12 ++---
 fs/inode.c                                | 26 +++++++++--
 fs/isofs/inode.c                          |  8 ++--
 fs/isofs/rock.c                           | 16 +++----
 fs/jffs2/dir.c                            | 24 ++++++----
 fs/jffs2/file.c                           |  3 +-
 fs/jffs2/fs.c                             | 10 ++---
 fs/jffs2/os-linux.h                       |  2 +-
 fs/jfs/acl.c                              |  2 +-
 fs/jfs/inode.c                            |  2 +-
 fs/jfs/ioctl.c                            |  2 +-
 fs/jfs/jfs_imap.c                         |  8 ++--
 fs/jfs/jfs_inode.c                        |  4 +-
 fs/jfs/namei.c                            | 24 +++++-----
 fs/jfs/super.c                            |  2 +-
 fs/jfs/xattr.c                            |  2 +-
 fs/kernfs/inode.c                         |  5 +--
 fs/libfs.c                                | 55 +++++++++++++++--------
 fs/minix/bitmap.c                         |  2 +-
 fs/minix/dir.c                            |  6 +--
 fs/minix/inode.c                          | 10 ++---
 fs/minix/itree_common.c                   |  4 +-
 fs/minix/namei.c                          |  6 +--
 fs/nfs/callback_proc.c                    |  2 +-
 fs/nfs/fscache.h                          |  4 +-
 fs/nfs/inode.c                            | 20 ++++-----
 fs/nfsd/nfsctl.c                          |  2 +-
 fs/nfsd/vfs.c                             |  2 +-
 fs/nilfs2/dir.c                           |  6 +--
 fs/nilfs2/inode.c                         | 12 ++---
 fs/nilfs2/ioctl.c                         |  2 +-
 fs/nilfs2/namei.c                         |  8 ++--
 fs/nsfs.c                                 |  2 +-
 fs/ntfs/inode.c                           | 15 ++++---
 fs/ntfs/mft.c                             |  3 +-
 fs/ntfs3/file.c                           |  6 +--
 fs/ntfs3/frecord.c                        |  3 +-
 fs/ntfs3/inode.c                          | 14 +++---
 fs/ntfs3/namei.c                          | 11 ++---
 fs/ntfs3/xattr.c                          |  4 +-
 fs/ocfs2/acl.c                            |  6 +--
 fs/ocfs2/alloc.c                          |  6 +--
 fs/ocfs2/aops.c                           |  2 +-
 fs/ocfs2/dir.c                            |  8 ++--
 fs/ocfs2/dlmfs/dlmfs.c                    |  4 +-
 fs/ocfs2/dlmglue.c                        |  7 ++-
 fs/ocfs2/file.c                           | 16 ++++---
 fs/ocfs2/inode.c                          | 12 ++---
 fs/ocfs2/move_extents.c                   |  6 +--
 fs/ocfs2/namei.c                          | 21 ++++-----
 fs/ocfs2/refcounttree.c                   | 14 +++---
 fs/ocfs2/xattr.c                          |  6 +--
 fs/omfs/dir.c                             |  4 +-
 fs/omfs/inode.c                           |  9 ++--
 fs/openpromfs/inode.c                     |  5 +--
 fs/orangefs/namei.c                       |  2 +-
 fs/orangefs/orangefs-utils.c              |  6 +--
 fs/overlayfs/file.c                       |  7 ++-
 fs/overlayfs/util.c                       |  2 +-
 fs/pipe.c                                 |  2 +-
 fs/posix_acl.c                            |  2 +-
 fs/proc/base.c                            |  2 +-
 fs/proc/inode.c                           |  2 +-
 fs/proc/proc_sysctl.c                     |  2 +-
 fs/proc/self.c                            |  2 +-
 fs/proc/thread_self.c                     |  2 +-
 fs/pstore/inode.c                         |  4 +-
 fs/qnx4/inode.c                           |  3 +-
 fs/qnx6/inode.c                           |  3 +-
 fs/ramfs/inode.c                          |  6 +--
 fs/reiserfs/inode.c                       | 12 +++--
 fs/reiserfs/ioctl.c                       |  4 +-
 fs/reiserfs/namei.c                       | 18 +++-----
 fs/reiserfs/stree.c                       |  4 +-
 fs/reiserfs/super.c                       |  2 +-
 fs/reiserfs/xattr.c                       |  5 ++-
 fs/reiserfs/xattr_acl.c                   |  2 +-
 fs/romfs/super.c                          |  4 +-
 fs/smb/client/file.c                      |  4 +-
 fs/smb/client/fscache.h                   |  5 ++-
 fs/smb/client/inode.c                     | 14 +++---
 fs/smb/client/smb2ops.c                   |  3 +-
 fs/smb/server/smb2pdu.c                   |  8 ++--
 fs/squashfs/inode.c                       |  2 +-
 fs/stack.c                                |  2 +-
 fs/stat.c                                 |  2 +-
 fs/sysv/dir.c                             |  6 +--
 fs/sysv/ialloc.c                          |  2 +-
 fs/sysv/inode.c                           |  5 +--
 fs/sysv/itree.c                           |  4 +-
 fs/sysv/namei.c                           |  6 +--
 fs/tracefs/inode.c                        |  2 +-
 fs/ubifs/debug.c                          |  4 +-
 fs/ubifs/dir.c                            | 39 ++++++----------
 fs/ubifs/file.c                           | 16 ++++---
 fs/ubifs/ioctl.c                          |  2 +-
 fs/ubifs/journal.c                        |  4 +-
 fs/ubifs/super.c                          |  4 +-
 fs/ubifs/xattr.c                          |  6 +--
 fs/udf/ialloc.c                           |  2 +-
 fs/udf/inode.c                            | 17 ++++---
 fs/udf/namei.c                            | 24 +++++-----
 fs/ufs/dir.c                              |  6 +--
 fs/ufs/ialloc.c                           |  2 +-
 fs/ufs/inode.c                            | 23 +++++-----
 fs/ufs/namei.c                            |  8 ++--
 fs/vboxsf/utils.c                         |  4 +-
 fs/xfs/libxfs/xfs_inode_buf.c             |  5 ++-
 fs/xfs/libxfs/xfs_trans_inode.c           |  2 +-
 fs/xfs/xfs_acl.c                          |  2 +-
 fs/xfs/xfs_bmap_util.c                    |  6 ++-
 fs/xfs/xfs_inode.c                        |  3 +-
 fs/xfs/xfs_inode_item.c                   |  2 +-
 fs/xfs/xfs_iops.c                         |  4 +-
 fs/xfs/xfs_itable.c                       |  4 +-
 fs/zonefs/super.c                         |  8 ++--
 include/linux/fs.h                        | 49 +++++++++++++++++++-
 include/linux/fs_stack.h                  |  2 +-
 ipc/mqueue.c                              | 23 +++++-----
 kernel/bpf/inode.c                        |  6 +--
 mm/shmem.c                                | 26 +++++------
 net/sunrpc/rpc_pipe.c                     |  2 +-
 security/apparmor/apparmorfs.c            | 11 +++--
 security/apparmor/policy_unpack.c         | 11 +++--
 security/inode.c                          |  2 +-
 security/selinux/selinuxfs.c              |  2 +-
 233 files changed, 901 insertions(+), 812 deletions(-)

-- 
2.41.0

