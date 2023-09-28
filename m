Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387117B293F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 02:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjI2ADN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 20:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjI2ADJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 20:03:09 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19BA19F;
        Thu, 28 Sep 2023 17:03:03 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SNOptA027537;
        Fri, 29 Sep 2023 00:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XbchtNjg3jAthLempdgdsoeQqcoBIQkyP+obKOpR1ps=;
 b=JW766xEtu2sKivUq33EZE/Y5h10B5Ftl0i00RWlxtUoDHVKVqIrStrW7ncN2YaqnghZM
 +AMXEG6WNYE6hhyy80zhscjJtdBu1oghrpAk15rt0d5P1fnSuvi7mUAxANFx6FgtMFsv
 LTXaOK1o/o3nGhROmp8fH3rGfNMzooR2xx86aEohwaZXMDKnHerBDFMDH6RtH7Vt2tRV
 mSLRn+pl6LKdmkQid7wVGlVExZxMf1x4AFIRiEOVh3VIPsO0e8bMzfgAtBraGvBjdXCL
 w96tWQpi/rREvTVh67Oc1CE3OhCLCk5DSTl8nhV5malfuEKLvpeeYHGiL/yyUBcTYCG+ aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdk4ygp5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 00:02:53 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38SNgTRw010277;
        Fri, 29 Sep 2023 00:02:53 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdk4ygp13-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 00:02:53 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38SKgrg0030489;
        Thu, 28 Sep 2023 22:03:20 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tad227n3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 22:03:20 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38SM3JiD65667554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 22:03:19 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49F875806A;
        Thu, 28 Sep 2023 22:03:19 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B4545805A;
        Thu, 28 Sep 2023 22:03:18 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 28 Sep 2023 22:03:18 +0000 (GMT)
Message-ID: <28997978-0b41-9bf3-8f62-ce422425f672@linux.ibm.com>
Date:   Thu, 28 Sep 2023 18:03:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [syzbot] [integrity] [overlayfs] general protection fault in
 d_path
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        syzbot <syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com>,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com
References: <000000000000259bd8060596e33f@google.com>
 <bed99e92-cb7c-868d-94f3-ddf53e2b262a@linux.ibm.com>
 <8a65f5eb-2b59-9903-c6b8-84971f8765ae@linux.ibm.com>
 <ab7df5e93b5493de5fa379ccab48859fe953d7ae.camel@kernel.org>
 <b16550ac-f589-c5d7-e139-d585e8771cfd@linux.ibm.com>
 <00dbd1e7-dfc8-86bc-536f-264a929ebb35@linux.ibm.com>
 <94b4686a-fee8-c545-2692-b25285b9a152@schaufler-ca.com>
 <d59d40426c388789c195d94e7e72048ef45fec5e.camel@kernel.org>
 <7caa3aa06cc2d7f8d075306b92b259dab3e9bc21.camel@linux.ibm.com>
 <20230921-gedanken-salzwasser-40d25b921162@brauner>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230921-gedanken-salzwasser-40d25b921162@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iw48y-4Zrw09uILJMNmK4oIioI3KFgqA
X-Proofpoint-GUID: vDYi7BGxzK9ucC4KqAKu1lkvGKVx5aZ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_22,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015 malwarescore=0
 mlxscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280202
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 9/21/23 07:48, Christian Brauner wrote:
>
> Imho, this is all very wild but I'm not judging.
>
> Two solutions imho:
> (1) teach stacking filesystems like overlayfs and ecryptfs to use
>      vfs_getattr_nosec() in their ->getattr() implementation when they
>      are themselves called via vfs_getattr_nosec(). This will fix this by
>      not triggering another LSM hook.

This somewhat lengthy patch I think would be a solution for (1). I don't 
think the Fixes tag is correct but IMO it should propagate farther back, 
if possible.


 From 01467f6e879c4cd757abb4d79cb18bf11150bed8 Mon Sep 17 00:00:00 2001
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Thu, 28 Sep 2023 14:42:39 -0400
Subject: [PATCH] fs: Enable GETATTR_NOSEC parameter for getattr interface
  function

When vfs_getattr_nosec() calls a filesystem's getattr interface function
then the 'nosec' should propagate into this function so that
vfs_getattr_nosec() can again be called from the filesystem's gettattr
rather than vfs_getattr(). The latter would add unnecessary security
checks that the initial vfs_getattr_nosec() call wanted to avoid.
Therefore, introduce the getattr flag GETATTR_NOSEC and allow to pass
with the new getattr_flags parameter to the getattr interface function.
In overlayfs and ecryptfs use this flag to determine which one of the
two functions to call.

In a recent code change introduced to IMA vfs_getattr_nosec() ended up
calling vfs_getattr() in overlayfs, which in turn called
security_inode_getattr() on an exiting process that did not have
current->fs set anymore, which then caused a kernel NULL pointer
dereference. With this change the call to security_inode_getattr() can
be avoided, thus avoiding the NULL pointer dereference.

Reported-by: syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com
Fixes: db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version")
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

---

simple_getattr has been adjusted and all files returned by the following
grep have been adjusted as well.

  grep -rEI "^[[:space:]]+\.getattr" ./ | \
    grep -v simple_getattr  | \
    cut -d ":" -f1 | sort | uniq
---
  fs/9p/vfs_inode.c             |  3 ++-
  fs/9p/vfs_inode_dotl.c        |  3 ++-
  fs/afs/inode.c                |  3 ++-
  fs/afs/internal.h             |  2 +-
  fs/bad_inode.c                |  3 ++-
  fs/btrfs/inode.c              |  3 ++-
  fs/ceph/inode.c               |  9 ++++++---
  fs/ceph/super.h               |  3 ++-
  fs/coda/coda_linux.h          |  2 +-
  fs/coda/inode.c               |  3 ++-
  fs/ecryptfs/inode.c           | 14 ++++++++++----
  fs/erofs/inode.c              |  2 +-
  fs/erofs/internal.h           |  2 +-
  fs/exfat/exfat_fs.h           |  2 +-
  fs/exfat/file.c               |  2 +-
  fs/ext2/ext2.h                |  2 +-
  fs/ext2/inode.c               |  3 ++-
  fs/ext4/ext4.h                |  6 ++++--
  fs/ext4/inode.c               |  9 ++++++---
  fs/ext4/symlink.c             |  6 ++++--
  fs/f2fs/f2fs.h                |  3 ++-
  fs/f2fs/file.c                |  3 ++-
  fs/f2fs/namei.c               |  6 ++++--
  fs/fat/fat.h                  |  3 ++-
  fs/fat/file.c                 |  3 ++-
  fs/fuse/dir.c                 |  3 ++-
  fs/gfs2/inode.c               |  4 +++-
  fs/hfsplus/hfsplus_fs.h       |  2 +-
  fs/hfsplus/inode.c            |  2 +-
  fs/kernfs/inode.c             |  3 ++-
  fs/kernfs/kernfs-internal.h   |  3 ++-
  fs/libfs.c                    |  5 +++--
  fs/minix/inode.c              |  3 ++-
  fs/minix/minix.h              |  3 ++-
  fs/nfs/inode.c                |  3 ++-
  fs/nfs/namespace.c            |  5 +++--
  fs/ntfs3/file.c               |  3 ++-
  fs/ntfs3/ntfs_fs.h            |  3 ++-
  fs/ocfs2/file.c               |  3 ++-
  fs/ocfs2/file.h               |  3 ++-
  fs/orangefs/inode.c           |  3 ++-
  fs/orangefs/orangefs-kernel.h |  3 ++-
  fs/overlayfs/inode.c          |  8 ++++++--
  fs/overlayfs/overlayfs.h      |  3 ++-
  fs/proc/base.c                |  6 ++++--
  fs/proc/fd.c                  |  3 ++-
  fs/proc/generic.c             |  3 ++-
  fs/proc/internal.h            |  3 ++-
  fs/proc/proc_net.c            |  3 ++-
  fs/proc/proc_sysctl.c         |  3 ++-
  fs/proc/root.c                |  3 ++-
  fs/smb/client/cifsfs.h        |  3 ++-
  fs/smb/client/inode.c         |  3 ++-
  fs/stat.c                     |  3 ++-
  fs/sysv/itree.c               |  3 ++-
  fs/sysv/sysv.h                |  2 +-
  fs/ubifs/dir.c                |  3 ++-
  fs/ubifs/file.c               |  6 ++++--
  fs/ubifs/ubifs.h              |  3 ++-
  fs/udf/symlink.c              |  3 ++-
  fs/vboxsf/utils.c             |  3 ++-
  fs/vboxsf/vfsmod.h            |  2 +-
  fs/xfs/xfs_iops.c             |  3 ++-
  include/linux/fs.h            | 10 ++++++++--
  include/linux/nfs_fs.h        |  2 +-
  mm/shmem.c                    |  3 ++-
  66 files changed, 159 insertions(+), 82 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 0d28ecf668d0..9c5a7e653bb1 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -1000,7 +1000,8 @@ v9fs_vfs_rename(struct mnt_idmap *idmap, struct 
inode *old_dir,

  static int
  v9fs_vfs_getattr(struct mnt_idmap *idmap, const struct path *path,
-         struct kstat *stat, u32 request_mask, unsigned int flags)
+         struct kstat *stat, u32 request_mask, unsigned int flags,
+         unsigned int getattr_flags)
  {
      struct dentry *dentry = path->dentry;
      struct inode *inode = d_inode(dentry);
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 1312f68965ac..e4238ee243bf 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -439,7 +439,8 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
  static int
  v9fs_vfs_getattr_dotl(struct mnt_idmap *idmap,
                const struct path *path, struct kstat *stat,
-              u32 request_mask, unsigned int flags)
+              u32 request_mask, unsigned int flags,
+              unsigned int getattr_flags)
  {
      struct dentry *dentry = path->dentry;
      struct v9fs_session_info *v9ses;
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 1c794a1896aa..8763e6126a8c 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -750,7 +750,8 @@ int afs_validate(struct afs_vnode *vnode, struct key 
*key)
   * read the attributes of an inode
   */
  int afs_getattr(struct mnt_idmap *idmap, const struct path *path,
-        struct kstat *stat, u32 request_mask, unsigned int query_flags)
+        struct kstat *stat, u32 request_mask, unsigned int query_flags,
+        unsigned int getattr_flags)
  {
      struct inode *inode = d_inode(path->dentry);
      struct afs_vnode *vnode = AFS_FS_I(inode);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index da73b97e19a9..b8dfb6232086 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1175,7 +1175,7 @@ extern bool afs_check_validity(struct afs_vnode *);
  extern int afs_validate(struct afs_vnode *, struct key *);
  bool afs_pagecache_valid(struct afs_vnode *);
  extern int afs_getattr(struct mnt_idmap *idmap, const struct path *,
-               struct kstat *, u32, unsigned int);
+               struct kstat *, u32, unsigned int, unsigned int);
  extern int afs_setattr(struct mnt_idmap *idmap, struct dentry *, 
struct iattr *);
  extern void afs_evict_inode(struct inode *);
  extern int afs_drop_inode(struct inode *);
diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 83f9566c973b..22219161382d 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -97,7 +97,8 @@ static int bad_inode_permission(struct mnt_idmap *idmap,

  static int bad_inode_getattr(struct mnt_idmap *idmap,
                   const struct path *path, struct kstat *stat,
-                 u32 request_mask, unsigned int query_flags)
+                 u32 request_mask, unsigned int query_flags,
+                 unsigned int getattr_flags)
  {
      return -EIO;
  }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7814b9d654ce..bc9fbaa42b93 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8624,7 +8624,8 @@ int __init btrfs_init_cachep(void)

  static int btrfs_getattr(struct mnt_idmap *idmap,
               const struct path *path, struct kstat *stat,
-             u32 request_mask, unsigned int flags)
+             u32 request_mask, unsigned int flags,
+             unsigned int getattr_flags)
  {
      u64 delalloc_bytes;
      u64 inode_bytes;
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 800ab7920513..a798f0a7238f 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2255,11 +2255,13 @@ static const char 
*ceph_encrypted_get_link(struct dentry *dentry,
  static int ceph_encrypted_symlink_getattr(struct mnt_idmap *idmap,
                        const struct path *path,
                        struct kstat *stat, u32 request_mask,
-                      unsigned int query_flags)
+                      unsigned int query_flags,
+                      unsigned int getattr_flags)
  {
      int ret;

-    ret = ceph_getattr(idmap, path, stat, request_mask, query_flags);
+    ret = ceph_getattr(idmap, path, stat, request_mask, query_flags,
+               getattr_flags);
      if (ret)
          return ret;
      return fscrypt_symlink_getattr(path, stat);
@@ -2960,7 +2962,8 @@ static int statx_to_caps(u32 want, umode_t mode)
   * then we can avoid talking to the MDS at all.
   */
  int ceph_getattr(struct mnt_idmap *idmap, const struct path *path,
-         struct kstat *stat, u32 request_mask, unsigned int flags)
+         struct kstat *stat, u32 request_mask, unsigned int flags,
+         unsigned int getattr_flags)
  {
      struct inode *inode = d_inode(path->dentry);
      struct super_block *sb = inode->i_sb;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 51c7f2b14f6f..f472cefd21bd 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1100,7 +1100,8 @@ extern int ceph_setattr(struct mnt_idmap *idmap,
              struct dentry *dentry, struct iattr *attr);
  extern int ceph_getattr(struct mnt_idmap *idmap,
              const struct path *path, struct kstat *stat,
-            u32 request_mask, unsigned int flags);
+            u32 request_mask, unsigned int flags,
+            unsigned int getattr_flags);
  void ceph_inode_shutdown(struct inode *inode);

  static inline bool ceph_inode_is_shutdown(struct inode *inode)
diff --git a/fs/coda/coda_linux.h b/fs/coda/coda_linux.h
index dd6277d87afb..ec6e30cbb35f 100644
--- a/fs/coda/coda_linux.h
+++ b/fs/coda/coda_linux.h
@@ -50,7 +50,7 @@ int coda_permission(struct mnt_idmap *idmap, struct 
inode *inode,
              int mask);
  int coda_revalidate_inode(struct inode *);
  int coda_getattr(struct mnt_idmap *, const struct path *, struct kstat *,
-         u32, unsigned int);
+         u32, unsigned int, unsigned int);
  int coda_setattr(struct mnt_idmap *, struct dentry *, struct iattr *);

  /* this file:  helpers */
diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index 0c7c2528791e..52465963c455 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -252,7 +252,8 @@ static void coda_evict_inode(struct inode *inode)
  }

  int coda_getattr(struct mnt_idmap *idmap, const struct path *path,
-         struct kstat *stat, u32 request_mask, unsigned int flags)
+         struct kstat *stat, u32 request_mask, unsigned int flags,
+         unsigned int getattr_flags)
  {
      int err = coda_revalidate_inode(d_inode(path->dentry));
      if (!err)
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 992d9c7e64ae..31173a4534d2 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -974,7 +974,8 @@ static int ecryptfs_setattr(struct mnt_idmap *idmap,

  static int ecryptfs_getattr_link(struct mnt_idmap *idmap,
                   const struct path *path, struct kstat *stat,
-                 u32 request_mask, unsigned int flags)
+                 u32 request_mask, unsigned int flags,
+                 unsigned int getattr_flags)
  {
      struct dentry *dentry = path->dentry;
      struct ecryptfs_mount_crypt_stat *mount_crypt_stat;
@@ -1000,14 +1001,19 @@ static int ecryptfs_getattr_link(struct 
mnt_idmap *idmap,

  static int ecryptfs_getattr(struct mnt_idmap *idmap,
                  const struct path *path, struct kstat *stat,
-                u32 request_mask, unsigned int flags)
+                u32 request_mask, unsigned int flags,
+                unsigned int getattr_flags)
  {
      struct dentry *dentry = path->dentry;
      struct kstat lower_stat;
      int rc;

-    rc = vfs_getattr(ecryptfs_dentry_to_lower_path(dentry), &lower_stat,
-             request_mask, flags);
+    if (getattr_flags & GETATTR_NOSEC)
+        rc = vfs_getattr_nosec(ecryptfs_dentry_to_lower_path(dentry),
+                       &lower_stat, request_mask, flags);
+    else
+        rc = vfs_getattr(ecryptfs_dentry_to_lower_path(dentry),
+                 &lower_stat, request_mask, flags);
      if (!rc) {
          fsstack_copy_attr_all(d_inode(dentry),
                        ecryptfs_inode_to_lower(d_inode(dentry)));
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index edc8ec7581b8..f9ac4c001c17 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -358,7 +358,7 @@ struct inode *erofs_iget(struct super_block *sb, 
erofs_nid_t nid)

  int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
            struct kstat *stat, u32 request_mask,
-          unsigned int query_flags)
+          unsigned int query_flags, unsigned int getattr_flags)
  {
      struct inode *const inode = d_inode(path->dentry);

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4ff88d0dd980..16fbb39d670f 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -422,7 +422,7 @@ int erofs_map_blocks(struct inode *inode, struct 
erofs_map_blocks *map);
  struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid);
  int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
            struct kstat *stat, u32 request_mask,
-          unsigned int query_flags);
+          unsigned int query_flags, unsigned int getattr_flags);
  int erofs_namei(struct inode *dir, const struct qstr *name,
          erofs_nid_t *nid, unsigned int *d_type);

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index f55498e5c23d..5e86c62de12f 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -454,7 +454,7 @@ int exfat_setattr(struct mnt_idmap *idmap, struct 
dentry *dentry,
            struct iattr *attr);
  int exfat_getattr(struct mnt_idmap *idmap, const struct path *path,
            struct kstat *stat, unsigned int request_mask,
-          unsigned int query_flags);
+          unsigned int query_flags, unsigned int getattr_flags);
  int exfat_file_fsync(struct file *file, loff_t start, loff_t end, int 
datasync);
  long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
  long exfat_compat_ioctl(struct file *filp, unsigned int cmd,
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 32395ef686a2..06cb318bfa0a 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -227,7 +227,7 @@ void exfat_truncate(struct inode *inode)

  int exfat_getattr(struct mnt_idmap *idmap, const struct path *path,
            struct kstat *stat, unsigned int request_mask,
-          unsigned int query_flags)
+          unsigned int query_flags, unsigned int getattr_flags)
  {
      struct inode *inode = d_backing_inode(path->dentry);
      struct exfat_inode_info *ei = EXFAT_I(inode);
diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 7fdd685c384d..a2b460786d21 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -748,7 +748,7 @@ void ext2_write_failed(struct address_space 
*mapping, loff_t to);
  extern int ext2_get_block(struct inode *, sector_t, struct buffer_head 
*, int);
  extern int ext2_setattr (struct mnt_idmap *, struct dentry *, struct 
iattr *);
  extern int ext2_getattr (struct mnt_idmap *, const struct path *,
-             struct kstat *, u32, unsigned int);
+             struct kstat *, u32, unsigned int, unsigned int);
  extern void ext2_set_inode_flags(struct inode *inode);
  extern int ext2_fiemap(struct inode *inode, struct fiemap_extent_info 
*fieinfo,
                 u64 start, u64 len);
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 314b415ee518..153738e254ac 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1611,7 +1611,8 @@ int ext2_write_inode(struct inode *inode, struct 
writeback_control *wbc)
  }

  int ext2_getattr(struct mnt_idmap *idmap, const struct path *path,
-         struct kstat *stat, u32 request_mask, unsigned int query_flags)
+         struct kstat *stat, u32 request_mask, unsigned int query_flags,
+         unsigned int getattr_flags)
  {
      struct inode *inode = d_inode(path->dentry);
      struct ext2_inode_info *ei = EXT2_I(inode);
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9418359b1d9d..90b1e08bd89a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2977,11 +2977,13 @@ extern int  ext4_setattr(struct mnt_idmap *, 
struct dentry *,
               struct iattr *);
  extern u32  ext4_dio_alignment(struct inode *inode);
  extern int  ext4_getattr(struct mnt_idmap *, const struct path *,
-             struct kstat *, u32, unsigned int);
+             struct kstat *, u32, unsigned int,
+             unsigned int);
  extern void ext4_evict_inode(struct inode *);
  extern void ext4_clear_inode(struct inode *);
  extern int  ext4_file_getattr(struct mnt_idmap *, const struct path *,
-                  struct kstat *, u32, unsigned int);
+                  struct kstat *, u32, unsigned int,
+                  unsigned int);
  extern void ext4_dirty_inode(struct inode *, int);
  extern int ext4_change_inode_journal_flag(struct inode *, int);
  extern int ext4_get_inode_loc(struct inode *, struct ext4_iloc *);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4ce35f1c8b0a..ede71d313519 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5515,7 +5515,8 @@ u32 ext4_dio_alignment(struct inode *inode)
  }

  int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
-         struct kstat *stat, u32 request_mask, unsigned int query_flags)
+         struct kstat *stat, u32 request_mask, unsigned int query_flags,
+         unsigned int getattr_flags)
  {
      struct inode *inode = d_inode(path->dentry);
      struct ext4_inode *raw_inode;
@@ -5577,12 +5578,14 @@ int ext4_getattr(struct mnt_idmap *idmap, const 
struct path *path,

  int ext4_file_getattr(struct mnt_idmap *idmap,
                const struct path *path, struct kstat *stat,
-              u32 request_mask, unsigned int query_flags)
+              u32 request_mask, unsigned int query_flags,
+              unsigned int getattr_flags)
  {
      struct inode *inode = d_inode(path->dentry);
      u64 delalloc_blocks;

-    ext4_getattr(idmap, path, stat, request_mask, query_flags);
+    ext4_getattr(idmap, path, stat, request_mask, query_flags,
+             getattr_flags);

      /*
       * If there is inline data in the inode, the inode will normally not
diff --git a/fs/ext4/symlink.c b/fs/ext4/symlink.c
index 75bf1f88843c..abc30ebb2be2 100644
--- a/fs/ext4/symlink.c
+++ b/fs/ext4/symlink.c
@@ -58,9 +58,11 @@ static const char *ext4_encrypted_get_link(struct 
dentry *dentry,
  static int ext4_encrypted_symlink_getattr(struct mnt_idmap *idmap,
                        const struct path *path,
                        struct kstat *stat, u32 request_mask,
-                      unsigned int query_flags)
+                      unsigned int query_flags,
+                      unsigned int getattr_flags)
  {
-    ext4_getattr(idmap, path, stat, request_mask, query_flags);
+    ext4_getattr(idmap, path, stat, request_mask, query_flags,
+             getattr_flags);

      return fscrypt_symlink_getattr(path, stat);
  }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6d688e42d89c..0a8436cd2f5f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3477,7 +3477,8 @@ int f2fs_do_truncate_blocks(struct inode *inode, 
u64 from, bool lock);
  int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock);
  int f2fs_truncate(struct inode *inode);
  int f2fs_getattr(struct mnt_idmap *idmap, const struct path *path,
-         struct kstat *stat, u32 request_mask, unsigned int flags);
+         struct kstat *stat, u32 request_mask, unsigned int flags,
+         unsigned int getattr_flags);
  int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
           struct iattr *attr);
  int f2fs_truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t 
pg_end);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ca5904129b16..e05bdd318aef 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -832,7 +832,8 @@ static bool f2fs_force_buffered_io(struct inode 
*inode, int rw)
  }

  int f2fs_getattr(struct mnt_idmap *idmap, const struct path *path,
-         struct kstat *stat, u32 request_mask, unsigned int query_flags)
+         struct kstat *stat, u32 request_mask, unsigned int query_flags,
+         unsigned int getattr_flags)
  {
      struct inode *inode = d_inode(path->dentry);
      struct f2fs_inode_info *fi = F2FS_I(inode);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 193b22a2d6bf..cfdcdeb2c0b0 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1356,9 +1356,11 @@ static const char *f2fs_encrypted_get_link(struct 
dentry *dentry,
  static int f2fs_encrypted_symlink_getattr(struct mnt_idmap *idmap,
                        const struct path *path,
                        struct kstat *stat, u32 request_mask,
-                      unsigned int query_flags)
+                      unsigned int query_flags,
+                      unsigned int getattr_flags)
  {
-    f2fs_getattr(idmap, path, stat, request_mask, query_flags);
+    f2fs_getattr(idmap, path, stat, request_mask, query_flags,
+             getattr_flags);

      return fscrypt_symlink_getattr(path, stat);
  }
diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 66cf4778cf3b..74b57f2e1c36 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -403,7 +403,8 @@ extern int fat_setattr(struct mnt_idmap *idmap, 
struct dentry *dentry,
  extern void fat_truncate_blocks(struct inode *inode, loff_t offset);
  extern int fat_getattr(struct mnt_idmap *idmap,
                 const struct path *path, struct kstat *stat,
-               u32 request_mask, unsigned int flags);
+               u32 request_mask, unsigned int flags,
+               unsigned int getattr_flags);
  extern int fat_file_fsync(struct file *file, loff_t start, loff_t end,
                int datasync);

diff --git a/fs/fat/file.c b/fs/fat/file.c
index e887e9ab7472..2177784f54a2 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -396,7 +396,8 @@ void fat_truncate_blocks(struct inode *inode, loff_t 
offset)
  }

  int fat_getattr(struct mnt_idmap *idmap, const struct path *path,
-        struct kstat *stat, u32 request_mask, unsigned int flags)
+        struct kstat *stat, u32 request_mask, unsigned int flags,
+        unsigned int getattr_flags)
  {
      struct inode *inode = d_inode(path->dentry);
      struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d707e6987da9..3531d4239635 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2069,7 +2069,8 @@ static int fuse_setattr(struct mnt_idmap *idmap, 
struct dentry *entry,

  static int fuse_getattr(struct mnt_idmap *idmap,
              const struct path *path, struct kstat *stat,
-            u32 request_mask, unsigned int flags)
+            u32 request_mask, unsigned int flags,
+            unsigned int getattr_flags)
  {
      struct inode *inode = d_inode(path->dentry);
      struct fuse_conn *fc = get_fuse_conn(inode);
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 0eac04507904..50383ec30573 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -2038,6 +2038,7 @@ static int gfs2_setattr(struct mnt_idmap *idmap,
   * @stat: The inode's stats
   * @request_mask: Mask of STATX_xxx flags indicating the caller's 
interests
   * @flags: AT_STATX_xxx setting
+ * @getattr_flags: GETATTR_xxx
   *
   * This may be called from the VFS directly, or from within GFS2 with the
   * inode locked, so we look to see if the glock is already locked and only
@@ -2050,7 +2051,8 @@ static int gfs2_setattr(struct mnt_idmap *idmap,

  static int gfs2_getattr(struct mnt_idmap *idmap,
              const struct path *path, struct kstat *stat,
-            u32 request_mask, unsigned int flags)
+            u32 request_mask, unsigned int flags,
+            unsigned int getattr_flags)
  {
      struct inode *inode = d_inode(path->dentry);
      struct gfs2_inode *ip = GFS2_I(inode);
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 7ededcb720c1..3da3a79c9742 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -483,7 +483,7 @@ int hfsplus_cat_read_inode(struct inode *inode, 
struct hfs_find_data *fd);
  int hfsplus_cat_write_inode(struct inode *inode);
  int hfsplus_getattr(struct mnt_idmap *idmap, const struct path *path,
              struct kstat *stat, u32 request_mask,
-            unsigned int query_flags);
+            unsigned int query_flags, unsigned int getattr_flags);
  int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
                 int datasync);
  int hfsplus_fileattr_get(struct dentry *dentry, struct fileattr *fa);
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index c65c8c4b03dd..afa7e8ee8cb2 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -278,7 +278,7 @@ static int hfsplus_setattr(struct mnt_idmap *idmap,

  int hfsplus_getattr(struct mnt_idmap *idmap, const struct path *path,
              struct kstat *stat, u32 request_mask,
-            unsigned int query_flags)
+            unsigned int query_flags, unsigned int getattr_flags)
  {
      struct inode *inode = d_inode(path->dentry);
      struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 922719a343a7..92af4b394274 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -182,7 +182,8 @@ static void kernfs_refresh_inode(struct kernfs_node 
*kn, struct inode *inode)

  int kernfs_iop_getattr(struct mnt_idmap *idmap,
                 const struct path *path, struct kstat *stat,
-               u32 request_mask, unsigned int query_flags)
+               u32 request_mask, unsigned int query_flags,
+               unsigned int getattr_flags)
  {
      struct inode *inode = d_inode(path->dentry);
      struct kernfs_node *kn = inode->i_private;
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index a9b854cdfdb5..ccf74e08105c 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -135,7 +135,8 @@ int kernfs_iop_setattr(struct mnt_idmap *idmap, 
struct dentry *dentry,
                 struct iattr *iattr);
  int kernfs_iop_getattr(struct mnt_idmap *idmap,
                 const struct path *path, struct kstat *stat,
-               u32 request_mask, unsigned int query_flags);
+               u32 request_mask, unsigned int query_flags,
+               unsigned int getattr_flags);
  ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t 
size);
  int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr);

diff --git a/fs/libfs.c b/fs/libfs.c
index 37f2d34ee090..757d24b8f4be 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -30,7 +30,7 @@

  int simple_getattr(struct mnt_idmap *idmap, const struct path *path,
             struct kstat *stat, u32 request_mask,
-           unsigned int query_flags)
+           unsigned int query_flags, unsigned int getattr_flags)
  {
      struct inode *inode = d_inode(path->dentry);
      generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
@@ -1579,7 +1579,8 @@ static struct dentry *empty_dir_lookup(struct 
inode *dir, struct dentry *dentry,

  static int empty_dir_getattr(struct mnt_idmap *idmap,
                   const struct path *path, struct kstat *stat,
-                 u32 request_mask, unsigned int query_flags)
+                 u32 request_mask, unsigned int query_flags,
+                 unsigned int getattr_flags)
  {
      struct inode *inode = d_inode(path->dentry);
      generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index df575473c1cc..74ae2c33f5a5 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -651,7 +651,8 @@ static int minix_write_inode(struct inode *inode, 
struct writeback_control *wbc)
  }

  int minix_getattr(struct mnt_idmap *idmap, const struct path *path,
-          struct kstat *stat, u32 request_mask, unsigned int flags)
+          struct kstat *stat, u32 request_mask, unsigned int flags,
+          unsigned int getattr_flags)
  {
      struct super_block *sb = path->dentry->d_sb;
      struct inode *inode = d_inode(path->dentry);
diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index d493507c064f..6ac55d3b649c 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -52,7 +52,8 @@ extern int minix_new_block(struct inode * inode);
  extern void minix_free_block(struct inode *inode, unsigned long block);
  extern unsigned long minix_count_free_blocks(struct super_block *sb);
  extern int minix_getattr(struct mnt_idmap *, const struct path *,
-             struct kstat *, u32, unsigned int);
+             struct kstat *, u32, unsigned int,
+             unsigned int);
  extern int minix_prepare_chunk(struct page *page, loff_t pos, unsigned 
len);

  extern void V1_minix_truncate(struct inode *);
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index e21c073158e5..c5cad2515b37 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -831,7 +831,8 @@ static u32 nfs_get_valid_attrmask(struct inode *inode)
  }

  int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
-        struct kstat *stat, u32 request_mask, unsigned int query_flags)
+        struct kstat *stat, u32 request_mask, unsigned int query_flags,
+        unsigned int getattr_flags)
  {
      struct inode *inode = d_inode(path->dentry);
      struct nfs_server *server = NFS_SERVER(inode);
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index e7494cdd957e..d4c3622ff4ed 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -210,11 +210,12 @@ struct vfsmount *nfs_d_automount(struct path *path)
  static int
  nfs_namespace_getattr(struct mnt_idmap *idmap,
                const struct path *path, struct kstat *stat,
-              u32 request_mask, unsigned int query_flags)
+              u32 request_mask, unsigned int query_flags,
+              unsigned int getattr_flags)
  {
      if (NFS_FH(d_inode(path->dentry))->size != 0)
          return nfs_getattr(idmap, path, stat, request_mask,
-                   query_flags);
+                   query_flags, getattr_flags);
      generic_fillattr(&nop_mnt_idmap, request_mask, d_inode(path->dentry),
               stat);
      return 0;
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 962f12ce6c0a..729ca3c09958 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -72,7 +72,8 @@ static long ntfs_compat_ioctl(struct file *filp, u32 
cmd, unsigned long arg)
   * ntfs_getattr - inode_operations::getattr
   */
  int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
-         struct kstat *stat, u32 request_mask, u32 flags)
+         struct kstat *stat, u32 request_mask, u32 flags,
+         unsigned int getattr_flags)
  {
      struct inode *inode = d_inode(path->dentry);
      struct ntfs_inode *ni = ntfs_i(inode);
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 629403ede6e5..3c83352883f2 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -492,7 +492,8 @@ extern const struct file_operations ntfs_dir_operations;

  /* Globals from file.c */
  int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
-         struct kstat *stat, u32 request_mask, u32 flags);
+         struct kstat *stat, u32 request_mask, u32 flags,
+         unsigned int getattr_flags);
  int ntfs3_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
            struct iattr *attr);
  void ntfs_sparse_cluster(struct inode *inode, struct page *page0, CLST 
vcn,
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index c45596c25c66..7e367cd801d3 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1300,7 +1300,8 @@ int ocfs2_setattr(struct mnt_idmap *idmap, struct 
dentry *dentry,
  }

  int ocfs2_getattr(struct mnt_idmap *idmap, const struct path *path,
-          struct kstat *stat, u32 request_mask, unsigned int flags)
+          struct kstat *stat, u32 request_mask, unsigned int flags,
+          unsigned int getattr_flags)
  {
      struct inode *inode = d_inode(path->dentry);
      struct super_block *sb = path->dentry->d_sb;
diff --git a/fs/ocfs2/file.h b/fs/ocfs2/file.h
index 8e53e4ac1120..2dbf4edd94da 100644
--- a/fs/ocfs2/file.h
+++ b/fs/ocfs2/file.h
@@ -52,7 +52,8 @@ int ocfs2_zero_extend(struct inode *inode, struct 
buffer_head *di_bh,
  int ocfs2_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
            struct iattr *attr);
  int ocfs2_getattr(struct mnt_idmap *idmap, const struct path *path,
-          struct kstat *stat, u32 request_mask, unsigned int flags);
+          struct kstat *stat, u32 request_mask, unsigned int flags,
+          unsigned int getattr_flags);
  int ocfs2_permission(struct mnt_idmap *idmap,
               struct inode *inode,
               int mask);
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 085912268442..f7c2c318d392 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -859,7 +859,8 @@ int orangefs_setattr(struct mnt_idmap *idmap, struct 
dentry *dentry,
   * Obtain attributes of an object given a dentry
   */
  int orangefs_getattr(struct mnt_idmap *idmap, const struct path *path,
-             struct kstat *stat, u32 request_mask, unsigned int flags)
+             struct kstat *stat, u32 request_mask, unsigned int flags,
+             unsigned int getattr_flags)
  {
      int ret;
      struct inode *inode = path->dentry->d_inode;
diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index b711654ca18a..f0682b51e5e0 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -365,7 +365,8 @@ int __orangefs_setattr_mode(struct dentry *dentry, 
struct iattr *iattr);
  int orangefs_setattr(struct mnt_idmap *, struct dentry *, struct iattr *);

  int orangefs_getattr(struct mnt_idmap *idmap, const struct path *path,
-             struct kstat *stat, u32 request_mask, unsigned int flags);
+             struct kstat *stat, u32 request_mask, unsigned int flags,
+             unsigned int getattr_flags);

  int orangefs_permission(struct mnt_idmap *idmap,
              struct inode *inode, int mask);
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 83ef66644c21..8c0f3e125d09 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -155,7 +155,8 @@ static void ovl_map_dev_ino(struct dentry *dentry, 
struct kstat *stat, int fsid)
  }

  int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
-        struct kstat *stat, u32 request_mask, unsigned int flags)
+        struct kstat *stat, u32 request_mask, unsigned int flags,
+        unsigned int getattr_flags)
  {
      struct dentry *dentry = path->dentry;
      enum ovl_path_type type;
@@ -171,7 +172,10 @@ int ovl_getattr(struct mnt_idmap *idmap, const 
struct path *path,

      type = ovl_path_real(dentry, &realpath);
      old_cred = ovl_override_creds(dentry->d_sb);
-    err = vfs_getattr(&realpath, stat, request_mask, flags);
+    if (getattr_flags & GETATTR_NOSEC)
+        err = vfs_getattr_nosec(&realpath, stat, request_mask, flags);
+    else
+        err = vfs_getattr(&realpath, stat, request_mask, flags);
      if (err)
          goto out;

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 9817b2dcb132..6f91bfb1bbbd 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -687,7 +687,8 @@ unsigned int ovl_get_nlink(struct ovl_fs *ofs, 
struct dentry *lowerdentry,
  int ovl_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
          struct iattr *attr);
  int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
-        struct kstat *stat, u32 request_mask, unsigned int flags);
+        struct kstat *stat, u32 request_mask, unsigned int flags,
+        unsigned int getattr_flags);
  int ovl_permission(struct mnt_idmap *idmap, struct inode *inode,
             int mask);
  int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const 
char *name,
diff --git a/fs/proc/base.c b/fs/proc/base.c
index ffd54617c354..3e733cd17fba 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1960,7 +1960,8 @@ static struct inode 
*proc_pid_make_base_inode(struct super_block *sb,
  }

  int pid_getattr(struct mnt_idmap *idmap, const struct path *path,
-        struct kstat *stat, u32 request_mask, unsigned int query_flags)
+        struct kstat *stat, u32 request_mask, unsigned int query_flags,
+        unsigned int getattr_flags)
  {
      struct inode *inode = d_inode(path->dentry);
      struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
@@ -3896,7 +3897,8 @@ static int proc_task_readdir(struct file *file, 
struct dir_context *ctx)

  static int proc_task_getattr(struct mnt_idmap *idmap,
                   const struct path *path, struct kstat *stat,
-                 u32 request_mask, unsigned int query_flags)
+                 u32 request_mask, unsigned int query_flags,
+                 unsigned int getattr_flags)
  {
      struct inode *inode = d_inode(path->dentry);
      struct task_struct *p = get_proc_task(inode);
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 6276b3938842..1ea9eea9953d 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -347,7 +347,8 @@ int proc_fd_permission(struct mnt_idmap *idmap,

  static int proc_fd_getattr(struct mnt_idmap *idmap,
              const struct path *path, struct kstat *stat,
-            u32 request_mask, unsigned int query_flags)
+            u32 request_mask, unsigned int query_flags,
+            unsigned int getattr_flags)
  {
      struct inode *inode = d_inode(path->dentry);
      int rv = 0;
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 775ce0bcf08c..4acb07536329 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -135,7 +135,8 @@ static int proc_notify_change(struct mnt_idmap *idmap,

  static int proc_getattr(struct mnt_idmap *idmap,
              const struct path *path, struct kstat *stat,
-            u32 request_mask, unsigned int query_flags)
+            u32 request_mask, unsigned int query_flags,
+            unsigned int getattr_flags)
  {
      struct inode *inode = d_inode(path->dentry);
      struct proc_dir_entry *de = PDE(inode);
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 9a8f32f21ff5..c3bc8eee4771 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -163,7 +163,8 @@ extern int proc_pid_statm(struct seq_file *, struct 
pid_namespace *,
   */
  extern const struct dentry_operations pid_dentry_operations;
  extern int pid_getattr(struct mnt_idmap *, const struct path *,
-               struct kstat *, u32, unsigned int);
+               struct kstat *, u32, unsigned int,
+               unsigned int);
  extern int proc_setattr(struct mnt_idmap *, struct dentry *,
              struct iattr *);
  extern void proc_pid_evict_inode(struct proc_inode *);
diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index 2ba31b6d68c0..e76019d1fe3b 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -301,7 +301,8 @@ static struct dentry *proc_tgid_net_lookup(struct 
inode *dir,

  static int proc_tgid_net_getattr(struct mnt_idmap *idmap,
                   const struct path *path, struct kstat *stat,
-                 u32 request_mask, unsigned int query_flags)
+                 u32 request_mask, unsigned int query_flags,
+                 unsigned int getattr_flags)
  {
      struct inode *inode = d_inode(path->dentry);
      struct net *net;
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index c88854df0b62..3dc86f02f64e 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -842,7 +842,8 @@ static int proc_sys_setattr(struct mnt_idmap *idmap,

  static int proc_sys_getattr(struct mnt_idmap *idmap,
                  const struct path *path, struct kstat *stat,
-                u32 request_mask, unsigned int query_flags)
+                u32 request_mask, unsigned int query_flags,
+                unsigned int getattr_flags)
  {
      struct inode *inode = d_inode(path->dentry);
      struct ctl_table_header *head = grab_header(inode);
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 9191248f2dac..ab9113fc119d 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -312,7 +312,8 @@ void __init proc_root_init(void)

  static int proc_root_getattr(struct mnt_idmap *idmap,
                   const struct path *path, struct kstat *stat,
-                 u32 request_mask, unsigned int query_flags)
+                 u32 request_mask, unsigned int query_flags,
+                 unsigned int getattr_flags)
  {
      generic_fillattr(&nop_mnt_idmap, request_mask, d_inode(path->dentry),
               stat);
diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
index 41daebd220ff..453a3bd7ba65 100644
--- a/fs/smb/client/cifsfs.h
+++ b/fs/smb/client/cifsfs.h
@@ -73,7 +73,8 @@ extern int cifs_invalidate_mapping(struct inode *inode);
  extern int cifs_revalidate_mapping(struct inode *inode);
  extern int cifs_zap_mapping(struct inode *inode);
  extern int cifs_getattr(struct mnt_idmap *, const struct path *,
-            struct kstat *, u32, unsigned int);
+            struct kstat *, u32, unsigned int,
+            unsigned int);
  extern int cifs_setattr(struct mnt_idmap *, struct dentry *,
              struct iattr *);
  extern int cifs_fiemap(struct inode *, struct fiemap_extent_info *, 
u64 start,
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index d7c302442c1e..1aa1bd0c85fd 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -2570,7 +2570,8 @@ int cifs_revalidate_dentry(struct dentry *dentry)
  }

  int cifs_getattr(struct mnt_idmap *idmap, const struct path *path,
-         struct kstat *stat, u32 request_mask, unsigned int flags)
+         struct kstat *stat, u32 request_mask, unsigned int flags,
+         unsigned int getattr_flags)
  {
      struct dentry *dentry = path->dentry;
      struct cifs_sb_info *cifs_sb = CIFS_SB(dentry->d_sb);
diff --git a/fs/stat.c b/fs/stat.c
index d43a5cc1bfa4..fc4f6c0a91a8 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -133,7 +133,8 @@ int vfs_getattr_nosec(const struct path *path, 
struct kstat *stat,
      idmap = mnt_idmap(path->mnt);
      if (inode->i_op->getattr)
          return inode->i_op->getattr(idmap, path, stat,
-                        request_mask, query_flags);
+                        request_mask, query_flags,
+                        GETATTR_NOSEC);

      generic_fillattr(idmap, request_mask, inode, stat);
      return 0;
diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index edb94e55de8e..3ff96577f0db 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -446,7 +446,8 @@ static unsigned sysv_nblocks(struct super_block *s, 
loff_t size)
  }

  int sysv_getattr(struct mnt_idmap *idmap, const struct path *path,
-         struct kstat *stat, u32 request_mask, unsigned int flags)
+         struct kstat *stat, u32 request_mask, unsigned int flags,
+         unsigned int getattr_flags)
  {
      struct super_block *s = path->dentry->d_sb;
      generic_fillattr(&nop_mnt_idmap, request_mask, d_inode(path->dentry),
diff --git a/fs/sysv/sysv.h b/fs/sysv/sysv.h
index e3f988b469ee..1e6e1e2faad4 100644
--- a/fs/sysv/sysv.h
+++ b/fs/sysv/sysv.h
@@ -142,7 +142,7 @@ extern int sysv_write_inode(struct inode *, struct 
writeback_control *wbc);
  extern int sysv_sync_inode(struct inode *);
  extern void sysv_set_inode(struct inode *, dev_t);
  extern int sysv_getattr(struct mnt_idmap *, const struct path *,
-            struct kstat *, u32, unsigned int);
+            struct kstat *, u32, unsigned int, unsigned int);
  extern int sysv_init_icache(void);
  extern void sysv_destroy_icache(void);

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 2f48c58d47cd..30fe9f64292c 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1632,7 +1632,8 @@ static int ubifs_rename(struct mnt_idmap *idmap,
  }

  int ubifs_getattr(struct mnt_idmap *idmap, const struct path *path,
-          struct kstat *stat, u32 request_mask, unsigned int flags)
+          struct kstat *stat, u32 request_mask, unsigned int flags,
+          unsigned int getattr_flags)
  {
      loff_t size;
      struct inode *inode = d_inode(path->dentry);
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index e5382f0b2587..ef0dda82adfc 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1622,9 +1622,11 @@ static const char *ubifs_get_link(struct dentry 
*dentry,

  static int ubifs_symlink_getattr(struct mnt_idmap *idmap,
                   const struct path *path, struct kstat *stat,
-                 u32 request_mask, unsigned int query_flags)
+                 u32 request_mask, unsigned int query_flags,
+                 unsigned int getattr_flags)
  {
-    ubifs_getattr(idmap, path, stat, request_mask, query_flags);
+    ubifs_getattr(idmap, path, stat, request_mask, query_flags,
+              getattr_flags);

      if (IS_ENCRYPTED(d_inode(path->dentry)))
          return fscrypt_symlink_getattr(path, stat);
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index ebb3ad6b5e7e..bf1429096176 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -2033,7 +2033,8 @@ int ubifs_update_time(struct inode *inode, int flags);
  struct inode *ubifs_new_inode(struct ubifs_info *c, struct inode *dir,
                    umode_t mode, bool is_xattr);
  int ubifs_getattr(struct mnt_idmap *idmap, const struct path *path,
-          struct kstat *stat, u32 request_mask, unsigned int flags);
+          struct kstat *stat, u32 request_mask, unsigned int flags,
+          unsigned int getattr_flags);
  int ubifs_check_dir_empty(struct inode *dir);

  /* xattr.c */
diff --git a/fs/udf/symlink.c b/fs/udf/symlink.c
index f7eaf7b14594..743f5f59e94c 100644
--- a/fs/udf/symlink.c
+++ b/fs/udf/symlink.c
@@ -143,7 +143,8 @@ static int udf_symlink_filler(struct file *file, 
struct folio *folio)

  static int udf_symlink_getattr(struct mnt_idmap *idmap,
                     const struct path *path, struct kstat *stat,
-                   u32 request_mask, unsigned int flags)
+                   u32 request_mask, unsigned int flags,
+                   unsigned int getattr_flags)
  {
      struct dentry *dentry = path->dentry;
      struct inode *inode = d_backing_inode(dentry);
diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
index 83f20dd15522..8bbc31c99ede 100644
--- a/fs/vboxsf/utils.c
+++ b/fs/vboxsf/utils.c
@@ -232,7 +232,8 @@ int vboxsf_inode_revalidate(struct dentry *dentry)
  }

  int vboxsf_getattr(struct mnt_idmap *idmap, const struct path *path,
-           struct kstat *kstat, u32 request_mask, unsigned int flags)
+           struct kstat *kstat, u32 request_mask, unsigned int flags,
+           unsigned int getattr_flags)
  {
      int err;
      struct dentry *dentry = path->dentry;
diff --git a/fs/vboxsf/vfsmod.h b/fs/vboxsf/vfsmod.h
index 05973eb89d52..8ec1edc0cbe6 100644
--- a/fs/vboxsf/vfsmod.h
+++ b/fs/vboxsf/vfsmod.h
@@ -99,7 +99,7 @@ int vboxsf_stat_dentry(struct dentry *dentry, struct 
shfl_fsobjinfo *info);
  int vboxsf_inode_revalidate(struct dentry *dentry);
  int vboxsf_getattr(struct mnt_idmap *idmap, const struct path *path,
             struct kstat *kstat, u32 request_mask,
-           unsigned int query_flags);
+           unsigned int query_flags, unsigned int getattr_flags);
  int vboxsf_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
             struct iattr *iattr);
  struct shfl_string *vboxsf_path_from_dentry(struct vboxsf_sbi *sbi,
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 1c1e6171209d..d70ab9d791a9 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -552,7 +552,8 @@ xfs_vn_getattr(
      const struct path    *path,
      struct kstat        *stat,
      u32            request_mask,
-    unsigned int        query_flags)
+    unsigned int        query_flags,
+    unsigned int        getattr_flags)
  {
      struct inode        *inode = d_inode(path->dentry);
      struct xfs_inode    *ip = XFS_I(inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b528f063e8ff..f2ec5a48e5dc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1924,7 +1924,7 @@ struct inode_operations {
              struct inode *, struct dentry *, unsigned int);
      int (*setattr) (struct mnt_idmap *, struct dentry *, struct iattr *);
      int (*getattr) (struct mnt_idmap *, const struct path *,
-            struct kstat *, u32, unsigned int);
+            struct kstat *, u32, unsigned int, unsigned int);
      ssize_t (*listxattr) (struct dentry *, char *, size_t);
      int (*fiemap)(struct inode *, struct fiemap_extent_info *, u64 start,
                u64 len);
@@ -2098,6 +2098,11 @@ static inline bool sb_rdonly(const struct 
super_block *sb) { return sb->s_flags
  #define IS_WHITEOUT(inode)    (S_ISCHR(inode->i_mode) && \
                   (inode)->i_rdev == WHITEOUT_DEV)

+/*
+ * getattr flags
+ */
+#define GETATTR_NOSEC    (1 << 0)
+
  static inline bool HAS_UNMAPPED_ID(struct mnt_idmap *idmap,
                     struct inode *inode)
  {
@@ -3066,7 +3071,8 @@ extern int dcache_readdir(struct file *, struct 
dir_context *);
  extern int simple_setattr(struct mnt_idmap *, struct dentry *,
                struct iattr *);
  extern int simple_getattr(struct mnt_idmap *, const struct path *,
-              struct kstat *, u32, unsigned int);
+              struct kstat *, u32, unsigned int,
+              unsigned int);
  extern int simple_statfs(struct dentry *, struct kstatfs *);
  extern int simple_open(struct inode *inode, struct file *file);
  extern int simple_link(struct dentry *, struct inode *, struct dentry *);
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 279262057a92..f6cecdbe11ca 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -421,7 +421,7 @@ extern int nfs_post_op_update_inode(struct inode 
*inode, struct nfs_fattr *fattr
  extern int nfs_post_op_update_inode_force_wcc(struct inode *inode, 
struct nfs_fattr *fattr);
  extern int nfs_post_op_update_inode_force_wcc_locked(struct inode 
*inode, struct nfs_fattr *fattr);
  extern int nfs_getattr(struct mnt_idmap *, const struct path *,
-               struct kstat *, u32, unsigned int);
+               struct kstat *, u32, unsigned int, unsigned int);
  extern void nfs_access_add_cache(struct inode *, struct 
nfs_access_entry *, const struct cred *);
  extern void nfs_access_set_mask(struct nfs_access_entry *, u32);
  extern int nfs_permission(struct mnt_idmap *, struct inode *, int);
diff --git a/mm/shmem.c b/mm/shmem.c
index 69595d341882..ff43a0d248bb 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1119,7 +1119,8 @@ EXPORT_SYMBOL_GPL(shmem_truncate_range);

  static int shmem_getattr(struct mnt_idmap *idmap,
               const struct path *path, struct kstat *stat,
-             u32 request_mask, unsigned int query_flags)
+             u32 request_mask, unsigned int query_flags,
+             unsigned int getattr_flags)
  {
      struct inode *inode = path->dentry->d_inode;
      struct shmem_inode_info *info = SHMEM_I(inode);
-- 
2.40.1

