Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200AB7B32B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 14:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjI2MkE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 08:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjI2MkC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:40:02 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF1BB7;
        Fri, 29 Sep 2023 05:39:59 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TCKj9e007376;
        Fri, 29 Sep 2023 12:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=b8liECuubWj23+OOyOhbTwvv0iXmphxxC6jfRERxOyA=;
 b=F8g/4G9AOZpeGwOBWd4+f+yzQ65ErTl0ClzPJuztCPhjo2HsK5g2PqfKfOqfSfwgL9dY
 kkj8X8y3mMbdG6W4yoc38V6JypymwC0L99UHfQ11JIihcIh2R8xSDRDliibEs2c4JK2b
 kAxgyd2TwRnqqZPFmRk8+tMm1Qn52omK01K1uvFaRHES20gDtRUnbi6hJVETjCVU6Nco
 ppdiO7oUfMfAiNpPLh24teeHizHEIbOoBArbS7MRdp3fkWneDl75xilJWI+B9kMwGGIj
 jpIgpkLCioFZR52GlwqEWXCYTd67P3V4fIgoxeTE2YoP0+usZw7akPMlTFQRwJFBrWQz bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdxgp8m14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 12:39:52 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38TCKs0W007821;
        Fri, 29 Sep 2023 12:39:51 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdxgp8m0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 12:39:51 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38TBLBeJ008427;
        Fri, 29 Sep 2023 12:39:50 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3taabtcyrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 12:39:50 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38TCdnPS32244270
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 12:39:50 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF10F58056;
        Fri, 29 Sep 2023 12:39:49 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F14A05803F;
        Fri, 29 Sep 2023 12:39:48 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 29 Sep 2023 12:39:48 +0000 (GMT)
Message-ID: <99294acf-7275-8f4d-a129-d5df208b7b2a@linux.ibm.com>
Date:   Fri, 29 Sep 2023 08:39:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [syzbot] [integrity] [overlayfs] general protection fault in
 d_path
Content-Language: en-US
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jeff Layton <jlayton@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        syzbot <syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
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
 <28997978-0b41-9bf3-8f62-ce422425f672@linux.ibm.com>
 <CAOQ4uxie6xT5mmCcCwYtnEvra37eSeFftXfxaTULfdJnk1VcXQ@mail.gmail.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAOQ4uxie6xT5mmCcCwYtnEvra37eSeFftXfxaTULfdJnk1VcXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1vfEUxnPLtm5xmJC0Mcipygy0Q5pxN75
X-Proofpoint-ORIG-GUID: up8I5SbR5DxVm9z6dZkBxWV6pb7_qm87
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_10,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290107
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 9/29/23 00:25, Amir Goldstein wrote:
> On Fri, Sep 29, 2023 at 3:02 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>> On 9/21/23 07:48, Christian Brauner wrote:
>>> Imho, this is all very wild but I'm not judging.
>>>
>>> Two solutions imho:
>>> (1) teach stacking filesystems like overlayfs and ecryptfs to use
>>>       vfs_getattr_nosec() in their ->getattr() implementation when they
>>>       are themselves called via vfs_getattr_nosec(). This will fix this by
>>>       not triggering another LSM hook.
>>
>> You can avoid all this churn.
>> Just use the existing query_flags arg.
>> Nothing outside the AT_STATX_SYNC_TYPE query_flags is
>> passed into filesystems from userspace.
>>
>> Mast out AT_STATX_SYNC_TYPE in vfs_getattr()
>> And allow kernel internal request_flags in vfs_getattr_nosec()
Hm, I thought that vfs_getattr_nosec needs to pass AT_GETATTR_NOSEC into 
->getattr().
>>
>> The AT_ flag namespace is already a challenge, but mixing user
>> flags and kernel-only flags in vfs interfaces has been done before.
>>
>> ...


That's what I wanted to avoid since now all filesystems' getattr() may 
have the AT_GETATTR_NOSEC mixed into the query_flags.

Anyway, here's what I currently have:

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 992d9c7e64ae..f7b5b1843dcc 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -998,16 +998,28 @@ static int ecryptfs_getattr_link(struct mnt_idmap 
*idmap,
         return rc;
  }

+static int ecryptfs_do_getattr(bool nosec, const struct path *path,
+                              struct kstat *stat, u32 request_mask,
+                              unsigned int flags)
+{
+       if (nosec)
+               return vfs_getattr_nosec(path, stat, request_mask, flags);
+       return vfs_getattr(path, stat, request_mask, flags);
+}
+
  static int ecryptfs_getattr(struct mnt_idmap *idmap,
                             const struct path *path, struct kstat *stat,
                             u32 request_mask, unsigned int flags)
  {
         struct dentry *dentry = path->dentry;
         struct kstat lower_stat;
+       bool nosec = flags & AT_GETATTR_NOSEC;
         int rc;

-       rc = vfs_getattr(ecryptfs_dentry_to_lower_path(dentry), &lower_stat,
-                        request_mask, flags);
+       flags &= ~AT_INTERNAL_MASK;
+
+       rc = ecryptfs_do_getattr(nosec, 
ecryptfs_dentry_to_lower_path(dentry),
+                                &lower_stat, request_mask, flags);
         if (!rc) {
                 fsstack_copy_attr_all(d_inode(dentry),
ecryptfs_inode_to_lower(d_inode(dentry)));
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 83ef66644c21..ec4ceb5b4ebf 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -166,12 +166,15 @@ int ovl_getattr(struct mnt_idmap *idmap, const 
struct path *path,
         int fsid = 0;
         int err;
         bool metacopy_blocks = false;
+       bool nosec = flags & AT_GETATTR_NOSEC;
+
+       flags &= ~AT_INTERNAL_MASK;

         metacopy_blocks = ovl_is_metacopy_dentry(dentry);

         type = ovl_path_real(dentry, &realpath);
         old_cred = ovl_override_creds(dentry->d_sb);
-       err = vfs_getattr(&realpath, stat, request_mask, flags);
+       err = ovl_do_getattr(nosec, &realpath, stat, request_mask, flags);
         if (err)
                 goto out;

@@ -196,8 +199,8 @@ int ovl_getattr(struct mnt_idmap *idmap, const 
struct path *path,
                                         (!is_dir ? STATX_NLINK : 0);

                         ovl_path_lower(dentry, &realpath);
-                       err = vfs_getattr(&realpath, &lowerstat,
-                                         lowermask, flags);
+                       err = ovl_do_getattr(nosec, &realpath, &lowerstat,
+                                            lowermask, flags);
                         if (err)
                                 goto out;

@@ -249,8 +252,9 @@ int ovl_getattr(struct mnt_idmap *idmap, const 
struct path *path,

                         ovl_path_lowerdata(dentry, &realpath);
                         if (realpath.dentry) {
-                               err = vfs_getattr(&realpath, &lowerdatastat,
-                                                 lowermask, flags);
+                               err = ovl_do_getattr(nosec, &realpath,
+ &lowerdatastat, lowermask,
+                                                    flags);
                                 if (err)
                                         goto out;
                         } else {
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 9817b2dcb132..cbee3ff3bab7 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -397,6 +397,15 @@ static inline bool ovl_open_flags_need_copy_up(int 
flags)
         return ((OPEN_FMODE(flags) & FMODE_WRITE) || (flags & O_TRUNC));
  }

+static inline int ovl_do_getattr(bool nosec, const struct path *path,
+                                struct kstat *stat, u32 request_mask,
+                                unsigned int flags)
+{
+       if (nosec)
+               return vfs_getattr_nosec(path, stat, request_mask, flags);
+       return vfs_getattr(path, stat, request_mask, flags);
+}
+
  /* util.c */
  int ovl_want_write(struct dentry *dentry);
  void ovl_drop_write(struct dentry *dentry);
diff --git a/fs/stat.c b/fs/stat.c
index d43a5cc1bfa4..3250e427e1aa 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -133,7 +133,8 @@ int vfs_getattr_nosec(const struct path *path, 
struct kstat *stat,
         idmap = mnt_idmap(path->mnt);
         if (inode->i_op->getattr)
                 return inode->i_op->getattr(idmap, path, stat,
-                                           request_mask, query_flags);
+                                           request_mask,
+                                           query_flags | AT_GETATTR_NOSEC);

         generic_fillattr(idmap, request_mask, inode, stat);
         return 0;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b528f063e8ff..9069d6a301f0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2027,6 +2027,12 @@ struct super_operations {
         void (*shutdown)(struct super_block *sb);
  };

+/*
+ * Internal query flags. See fcntl.h AT_xxx flags for the rest.
+ */
+#define AT_GETATTR_NOSEC               0x80000000
+#define AT_INTERNAL_MASK               0x80000000
+
  /*
   * Inode flags - they have no relation to superblock flags now
   */



