Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C830917FE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 18:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfHRQ7V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 12:59:21 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35499 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfHRQ7V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 12:59:21 -0400
Received: by mail-pl1-f193.google.com with SMTP id gn20so4636905plb.2;
        Sun, 18 Aug 2019 09:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RwcmEOVaCgQn5YcIaNY6CXwWg6zDdmkpmJl5vmh1uGs=;
        b=HiJA0cs9nJZycVEklhF1ydMiEZlqYlRZ+rT3ZYhNjaom6QdwblnzQmdsqBjEZlDKMp
         jvcGaD8ig89nNQdTGe9GeJ5iFMo7AEN6bsYz2SyhceKvOz7NLf8T+g8wmTJdIYNBHCnk
         mqxSQ23qxF8fXRSxUZ0GNEzU976EBiFSVLHIFTB7kHKYVwaxjHouhX9bcoWk26Hy1rg6
         wa6ahr1JhJ39nrboMSrYmJPMJSj2dD+/CMcTQBkhDHlKdSN8HDIVcxto7SezHoUSooyb
         QXns2+TyCciABnoGJd/w5iL3xBZcmKb98RjlIRImw/72ezzY/hsvU9/c+eh37GhZ+4vQ
         xS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RwcmEOVaCgQn5YcIaNY6CXwWg6zDdmkpmJl5vmh1uGs=;
        b=WUamprUPjgH4GaQTMDNZfRT7MiOlRdczFmkBmMGmJCvmNLaKbJdsqZpFDvhdfi5WKH
         Y1vKE7H4fz8Ri+jCFGbwJp3DKd3ta5QDrm72AUSt/qiZ12SLZ4rbbtImWBqlYJUvI4Bb
         MX/2Qgm4AflLJM7E8BFVjIpnect2vw3CsNEt36XdYKTMLcLB4ERaRm460BwL4EYeQ5n9
         v8CYAP+E0IT7Rdy7t/dBZlNO1kvYLYB13d324GjURHlu5pktGFWV9yQuJCzUE0Qys/xj
         NsphRMM/LDCEJPSHMUXCFoeQWgTlC4NhsKSs65L4hNOrugzSy3aazXiW6/qIjKaBz2+5
         pDVQ==
X-Gm-Message-State: APjAAAU6kWRpHauujBiPWSvWMI6Knuir3ROCkv5RHg3jgfoUPxUYCMsV
        XJHYYz2bpbji7a1jIF+nvfw=
X-Google-Smtp-Source: APXvYqxiQNguzmCRctY+lvOzTTOdGzSMQGETwprj26Ooqm/lMPEtm/pNLPzDafLGwlxjn+XuprqyZA==
X-Received: by 2002:a17:902:f095:: with SMTP id go21mr18588927plb.216.1566147559767;
        Sun, 18 Aug 2019 09:59:19 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id b136sm15732831pfb.73.2019.08.18.09.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 09:59:19 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        arnd@arndb.de, adilger.kernel@dilger.ca, adrian.hunter@intel.com,
        aivazian.tigran@gmail.com, al@alarsen.net,
        anna.schumaker@netapp.com, anton@enomsg.org,
        asmadeus@codewreck.org, ccross@android.com,
        ceph-devel@vger.kernel.org, coda@cs.cmu.edu,
        codalist@coda.cs.cmu.edu, darrick.wong@oracle.com,
        dedekind1@gmail.com, devel@lists.orangefs.org, dsterba@suse.com,
        dushistov@mail.ru, dwmw2@infradead.org, ericvh@gmail.com,
        gregkh@linuxfoundation.org, hch@infradead.org, hch@lst.de,
        hirofumi@mail.parknet.co.jp, hubcap@omnibond.com,
        idryomov@gmail.com, jack@suse.com, jaegeuk@kernel.org,
        jaharkes@cs.cmu.edu, jfs-discussion@lists.sourceforge.net,
        jlbec@evilplan.org, keescook@chromium.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-karma-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        lucho@ionkov.net, luisbg@kernel.org, martin@omnibond.com,
        me@bobcopeland.com, mikulas@artax.karlin.mff.cuni.cz,
        nico@fluxnic.net, phillip@squashfs.org.uk,
        reiserfs-devel@vger.kernel.org, richard@nod.at, sage@redhat.com,
        salah.triki@gmail.com, sfrench@samba.org, shaggy@kernel.org,
        tj@kernel.org, tony.luck@intel.com,
        trond.myklebust@hammerspace.com, tytso@mit.edu,
        v9fs-developer@lists.sourceforge.net, yuchao0@huawei.com,
        zyan@redhat.com
Subject: [PATCH v8 00/20] vfs: Add support for timestamp limits
Date:   Sun, 18 Aug 2019 09:57:57 -0700
Message-Id: <20190818165817.32634-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The series is an update and a more complete version of the
previously posted series at
https://lore.kernel.org/linux-fsdevel/20180122020426.2988-1-deepa.kernel@gmail.com/

Thanks to Arnd Bergmann for doing a few preliminary reviews.
They helped me fix a few issues I had overlooked.

The limits (sometimes granularity also) for the filesystems updated here are according to the
following table:

File system   Time type                      Start year Expiration year Granularity
cramfs        fixed                          0          0
romfs         fixed                          0          0
pstore        ascii seconds (27 digit ascii) S64_MIN    S64_MAX         1
coda          INT64                          S64_MIN    S64_MAX         1
omfs          64-bit milliseconds            0          U64_MAX/ 1000   NSEC_PER_MSEC
befs          unsigned 48-bit seconds        0          0xffffffffffff  alloc_super
bfs           unsigned 32-bit seconds        0          U32_MAX         alloc_super
efs           unsigned 32-bit seconds        0          U32_MAX         alloc_super
ext2          signed 32-bit seconds          S32_MIN    S32_MAX         alloc_super
ext3          signed 32-bit seconds          S32_MIN    S32_MAX         alloc_super
ext4 (old)    signed 32-bit seconds          S32_MIN    S32_MAX         alloc_super
ext4 (extra)  34-bit seconds, 30-bit ns      S32_MIN    0x37fffffff	1
freevxfs      u32 secs/usecs                 0          U32_MAX         alloc_super
jffs2         unsigned 32-bit seconds        0          U32_MAX         alloc_super
jfs           unsigned 32-bit seconds/ns     0          U32_MAX         1
minix         unsigned 32-bit seconds        0          U32_MAX         alloc_super
orangefs      u64 seconds                    0          U64_MAX         alloc_super
qnx4          unsigned 32-bit seconds        0          U32_MAX         alloc_super
qnx6          unsigned 32-bit seconds        0          U32_MAX         alloc_super
reiserfs      unsigned 32-bit seconds        0          U32_MAX         alloc_super
squashfs      unsigned 32-bit seconds        0          U32_MAX         alloc_super
ufs1          signed 32-bit seconds          S32_MIN    S32_MAX         NSEC_PER_SEC
ufs2          signed 64-bit seconds/u32 ns   S64_MIN    S64_MAX         1
xfs           signed 32-bit seconds/ns       S32_MIN    S32_MAX         1
ceph          unsigned 32-bit second/ns      0          U32_MAX         1000
sysv          unsigned 32-bit seconds        0          U32_MAX         alloc_super
affs          u32 day, min, ticks            1978       u32_max days    NSEC_PER_SEC
nfsv2         unsigned 32-bit seconds/ns     0          U32_MAX         1
nfsv3         unsigned 32-bit seconds/ns     0          U32_MAX         1000
nfsv4         u64 seconds/u32 ns             S64_MIN    S64_MAX         1000
isofs         u8 year since 1900 (fixable)   1900       2155            alloc_super
hpfs          unsigned 32-bit seconds        1970       2106            alloc_super
fat           7-bit years, 2s resolution     1980       2107
cifs (smb)    7-bit years                    1980       2107
cifs (modern) 64-bit 100ns since 1601        1601       30828
adfs          40-bit cs since 1900           1900       2248
9p (9P2000)   unsigned 32-bit seconds        1970       2106
9p (9P2000.L) signed 64-bit seconds, ns      1970       S64_MAX

Granularity column filled in by the alloc_super() in the above table indicates that
the granularity is NSEC_PER_SEC.
Note that anything not mentioned above still has the default limits
S64_MIN..S64_MAX.

The patches in the series are as structured below:
1. Add vfs support to maintain the limits per filesystem.
2. Add a new timestamp_truncate() api for clamping timestamps
   according to the filesystem limits.
3. Add a warning for mount syscall to indicate the impending
   expiry of timestamps.
4. Modify utimes to clamp the timestamps.
5. Fill in limits for filesystems.

A test for checking file system timestamp limits has been posted
at https://www.spinics.net/lists/fstests/msg12262.html

Changes since v7:
* Dropped fat modifications from timespec_truncate patch
* Leverage timestamp_truncate function in utimes
* Added a fix for pstore ramoops timestamps
* Added ext4 warning for inodes without room for extended timestamps.
* Made mount warning more human readable
Changes since v6:
* No change in mount behavior because of expiry of timestamps.
* Included limits for more filesystems.
Changes since v5:
* Dropped y2038-specific changes
Changes since v4:
* Added documentation for boot param
Changes since v3:
* Remove redundant initializations in libfs.c
* Change early_param to __setup similar to other root mount options.
* Fix documentation warning
Changes since v2:
* Introduce early boot param override for checks.
* Drop afs patch for timestamp limits.
Changes since v1:
* return EROFS on mount errors
* fix mtime copy/paste error in utimes

Deepa Dinamani (20):
  vfs: Add file timestamp range support
  vfs: Add timestamp_truncate() api
  timestamp_truncate: Replace users of timespec64_trunc
  mount: Add mount warning for impending timestamp expiry
  utimes: Clamp the timestamps before update
  fs: Fill in max and min timestamps in superblock
  9p: Fill min and max timestamps in sb
  adfs: Fill in max and min timestamps in sb
  ext4: Initialize timestamps limits
  fs: nfs: Initialize filesystem timestamp ranges
  fs: cifs: Initialize filesystem timestamp ranges
  fs: fat: Initialize filesystem timestamp ranges
  fs: affs: Initialize filesystem timestamp ranges
  fs: sysv: Initialize filesystem timestamp ranges
  fs: ceph: Initialize filesystem timestamp ranges
  fs: orangefs: Initialize filesystem timestamp ranges
  fs: hpfs: Initialize filesystem timestamp ranges
  fs: omfs: Initialize filesystem timestamp ranges
  pstore: fs superblock limits
  isofs: Initialize filesystem timestamp ranges

 fs/9p/vfs_super.c        |  6 +++++-
 fs/adfs/adfs.h           | 13 +++++++++++++
 fs/adfs/inode.c          |  8 ++------
 fs/adfs/super.c          |  2 ++
 fs/affs/amigaffs.c       |  2 +-
 fs/affs/amigaffs.h       |  3 +++
 fs/affs/inode.c          |  4 ++--
 fs/affs/super.c          |  4 ++++
 fs/attr.c                | 21 ++++++++++++---------
 fs/befs/linuxvfs.c       |  2 ++
 fs/bfs/inode.c           |  2 ++
 fs/ceph/super.c          |  2 ++
 fs/cifs/cifsfs.c         | 22 ++++++++++++++++++++++
 fs/cifs/netmisc.c        | 14 +++++++-------
 fs/coda/inode.c          |  3 +++
 fs/configfs/inode.c      | 12 ++++++------
 fs/cramfs/inode.c        |  2 ++
 fs/efs/super.c           |  2 ++
 fs/ext2/super.c          |  2 ++
 fs/ext4/ext4.h           | 10 +++++++++-
 fs/ext4/super.c          | 17 +++++++++++++++--
 fs/f2fs/file.c           | 21 ++++++++++++---------
 fs/fat/inode.c           | 12 ++++++++++++
 fs/freevxfs/vxfs_super.c |  2 ++
 fs/hpfs/hpfs_fn.h        |  6 ++----
 fs/hpfs/super.c          |  2 ++
 fs/inode.c               | 33 ++++++++++++++++++++++++++++++++-
 fs/isofs/inode.c         |  7 +++++++
 fs/jffs2/fs.c            |  3 +++
 fs/jfs/super.c           |  2 ++
 fs/kernfs/inode.c        |  7 +++----
 fs/minix/inode.c         |  2 ++
 fs/namespace.c           | 33 ++++++++++++++++++++++++++++++++-
 fs/nfs/super.c           | 20 +++++++++++++++++++-
 fs/ntfs/inode.c          | 21 ++++++++++++---------
 fs/omfs/inode.c          |  4 ++++
 fs/orangefs/super.c      |  2 ++
 fs/pstore/ram.c          |  2 ++
 fs/qnx4/inode.c          |  2 ++
 fs/qnx6/inode.c          |  2 ++
 fs/reiserfs/super.c      |  3 +++
 fs/romfs/super.c         |  2 ++
 fs/squashfs/super.c      |  2 ++
 fs/super.c               |  2 ++
 fs/sysv/super.c          |  5 ++++-
 fs/ubifs/file.c          | 21 ++++++++++++---------
 fs/ufs/super.c           |  7 +++++++
 fs/utimes.c              |  6 ++----
 fs/xfs/xfs_super.c       |  2 ++
 include/linux/fs.h       |  5 +++++
 include/linux/time64.h   |  2 ++
 51 files changed, 315 insertions(+), 78 deletions(-)

-- 
2.17.1

Cc: adilger.kernel@dilger.ca
Cc: adrian.hunter@intel.com
Cc: aivazian.tigran@gmail.com
Cc: al@alarsen.net
Cc: anna.schumaker@netapp.com
Cc: anton@enomsg.org
Cc: asmadeus@codewreck.org
Cc: ccross@android.com
Cc: ceph-devel@vger.kernel.org
Cc: coda@cs.cmu.edu
Cc: codalist@coda.cs.cmu.edu
Cc: darrick.wong@oracle.com
Cc: dedekind1@gmail.com
Cc: devel@lists.orangefs.org
Cc: dsterba@suse.com
Cc: dushistov@mail.ru
Cc: dwmw2@infradead.org
Cc: ericvh@gmail.com
Cc: gregkh@linuxfoundation.org
Cc: hch@infradead.org
Cc: hch@lst.de
Cc: hirofumi@mail.parknet.co.jp
Cc: hubcap@omnibond.com
Cc: idryomov@gmail.com
Cc: jack@suse.com
Cc: jaegeuk@kernel.org
Cc: jaharkes@cs.cmu.edu
Cc: jfs-discussion@lists.sourceforge.net
Cc: jlbec@evilplan.org
Cc: keescook@chromium.org
Cc: linux-cifs@vger.kernel.org
Cc: linux-ext4@vger.kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net
Cc: linux-karma-devel@lists.sourceforge.net
Cc: linux-mtd@lists.infradead.org
Cc: linux-nfs@vger.kernel.org
Cc: linux-ntfs-dev@lists.sourceforge.net
Cc: linux-xfs@vger.kernel.org
Cc: lucho@ionkov.net
Cc: luisbg@kernel.org
Cc: martin@omnibond.com
Cc: me@bobcopeland.com
Cc: mikulas@artax.karlin.mff.cuni.cz
Cc: nico@fluxnic.net
Cc: phillip@squashfs.org.uk
Cc: reiserfs-devel@vger.kernel.org
Cc: richard@nod.at
Cc: sage@redhat.com
Cc: salah.triki@gmail.com
Cc: sfrench@samba.org
Cc: shaggy@kernel.org
Cc: tj@kernel.org
Cc: tony.luck@intel.com
Cc: trond.myklebust@hammerspace.com
Cc: tytso@mit.edu
Cc: v9fs-developer@lists.sourceforge.net
Cc: yuchao0@huawei.com
Cc: zyan@redhat.com
