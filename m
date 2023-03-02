Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED1C6A7A7F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 05:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjCBEc0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 23:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjCBEcS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 23:32:18 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180BD497C0;
        Wed,  1 Mar 2023 20:32:17 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321MxWam017246;
        Thu, 2 Mar 2023 04:32:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=CeyDZipp/ufRAN71ci8Y49vLa1a0i3SMVyGK2lSK0xQ=;
 b=ST2BkCT8EqSF97vNtkMj4OrC94JMxoFTvwAR92V+krhCMGEcCRsBCvn5ogB9dqNki+ND
 3mjBmLoUE6OF8FiA157r9P4d7U/QFrBetT3dAIdPXcKlpf6nRO97mwcoMK8w/sD2om8b
 JmGjDJk3WTHcXZSAIlKux0IhSy2/83vjEmdRnpj2H59FOBG8eFm9PkpktJ1++1rahB32
 c0CFjQXKTu78QDZ+73FApi+/KwwUpTksXsH89pnn5ctVQ+vVEnz8gwqM/8H/9jrkOs/G
 eWuXJ3RkuYWXyCMoN+Z+s39uXB5K/TKI/J0j/kMvahalROdVjg9zg6nt6s9U8WauDGgv +A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nybaktnay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 04:32:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3222fxje031538;
        Thu, 2 Mar 2023 04:32:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sga7es-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 04:32:12 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3224W8eU012677;
        Thu, 2 Mar 2023 04:32:11 GMT
Received: from localhost.localdomain (dhcp-10-191-129-161.vpn.oracle.com [10.191.129.161])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ny8sga7bn-2;
        Thu, 02 Mar 2023 04:32:11 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        joe.jin@oracle.com
Subject: [PATCH 1/3] kernfs: Introduce separate rwsem to protect inode attributes.
Date:   Thu,  2 Mar 2023 15:32:01 +1100
Message-Id: <20230302043203.1695051-2-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230302043203.1695051-1-imran.f.khan@oracle.com>
References: <20230302043203.1695051-1-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_01,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=942 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020035
X-Proofpoint-GUID: rHqLv8DG_iUjbOFWAUYW5VWRjCPFIX0M
X-Proofpoint-ORIG-GUID: rHqLv8DG_iUjbOFWAUYW5VWRjCPFIX0M
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Right now a global per-fs rwsem (kernfs_rwsem) synchronizes multiple
kernfs operations. On a large system with few hundred CPUs and few
hundred applications simultaneoulsy trying to access sysfs, this
results in multiple sys_open(s) contending on kernfs_rwsem via
kernfs_iop_permission and kernfs_dop_revalidate.

For example on a system with 384 cores, if I run 200 instances of an
application which is mostly executing the following loop:

  for (int loop = 0; loop <100 ; loop++)
  {
    for (int port_num = 1; port_num < 2; port_num++)
    {
      for (int gid_index = 0; gid_index < 254; gid_index++ )
      {
        char ret_buf[64], ret_buf_lo[64];
        char gid_file_path[1024];

        int      ret_len;
        int      ret_fd;
        ssize_t  ret_rd;

        ub4  i, saved_errno;

        memset(ret_buf, 0, sizeof(ret_buf));
        memset(gid_file_path, 0, sizeof(gid_file_path));

        ret_len = snprintf(gid_file_path, sizeof(gid_file_path),
                           "/sys/class/infiniband/%s/ports/%d/gids/%d",
                           dev_name,
                           port_num,
                           gid_index);

        ret_fd = open(gid_file_path, O_RDONLY | O_CLOEXEC);
        if (ret_fd < 0)
        {
          printf("Failed to open %s\n", gid_file_path);
          continue;
        }

        /* Read the GID */
        ret_rd = read(ret_fd, ret_buf, 40);

        if (ret_rd == -1)
        {
          printf("Failed to read from file %s, errno: %u\n",
                 gid_file_path, saved_errno);

          continue;
        }

        close(ret_fd);
      }
    }

I see contention around kernfs_rwsem as follows:

path_openat
|
|----link_path_walk.part.0.constprop.0
|      |
|      |--49.92%--inode_permission
|      |          |
|      |           --48.69%--kernfs_iop_permission
|      |                     |
|      |                     |--18.16%--down_read
|      |                     |
|      |                     |--15.38%--up_read
|      |                     |
|      |                      --14.58%--_raw_spin_lock
|      |                                |
|      |                                 -----
|      |
|      |--29.08%--walk_component
|      |          |
|      |           --29.02%--lookup_fast
|      |                     |
|      |                     |--24.26%--kernfs_dop_revalidate
|      |                     |          |
|      |                     |          |--14.97%--down_read
|      |                     |          |
|      |                     |           --9.01%--up_read
|      |                     |
|      |                      --4.74%--__d_lookup
|      |                                |
|      |                                 --4.64%--_raw_spin_lock
|      |                                           |
|      |                                            ----

Having a separate per-fs rwsem to protect kernfs inode attributes,
will avoid the above mentioned contention and result in better
performance as can bee seen below:

path_openat
|
|----link_path_walk.part.0.constprop.0
|     |
|     |
|     |--27.06%--inode_permission
|     |          |
|     |           --25.84%--kernfs_iop_permission
|     |                     |
|     |                     |--9.29%--up_read
|     |                     |
|     |                     |--8.19%--down_read
|     |                     |
|     |                      --7.89%--_raw_spin_lock
|     |                                |
|     |                                 ----
|     |
|     |--22.42%--walk_component
|     |          |
|     |           --22.36%--lookup_fast
|     |                     |
|     |                     |--16.07%--__d_lookup
|     |                     |          |
|     |                     |           --16.01%--_raw_spin_lock
|     |                     |                     |
|     |                     |                      ----
|     |                     |
|     |                      --6.28%--kernfs_dop_revalidate
|     |                                |
|     |                                |--3.76%--down_read
|     |                                |
|     |                                 --2.26%--up_read

As can be seen from the above data the overhead due to both
kerfs_iop_permission and kernfs_dop_revalidate have gone down and
this also reduces overall run time of the earlier mentioned loop.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/dir.c             |  7 +++++++
 fs/kernfs/inode.c           | 16 ++++++++--------
 fs/kernfs/kernfs-internal.h |  1 +
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index ef00b5fe8ceea..953b2717c60e6 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -770,12 +770,15 @@ int kernfs_add_one(struct kernfs_node *kn)
 		goto out_unlock;
 
 	/* Update timestamps on the parent */
+	down_write(&root->kernfs_iattr_rwsem);
+
 	ps_iattr = parent->iattr;
 	if (ps_iattr) {
 		ktime_get_real_ts64(&ps_iattr->ia_ctime);
 		ps_iattr->ia_mtime = ps_iattr->ia_ctime;
 	}
 
+	up_write(&root->kernfs_iattr_rwsem);
 	up_write(&root->kernfs_rwsem);
 
 	/*
@@ -940,6 +943,7 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 
 	idr_init(&root->ino_idr);
 	init_rwsem(&root->kernfs_rwsem);
+	init_rwsem(&root->kernfs_iattr_rwsem);
 	INIT_LIST_HEAD(&root->supers);
 
 	/*
@@ -1462,11 +1466,14 @@ static void __kernfs_remove(struct kernfs_node *kn)
 				pos->parent ? pos->parent->iattr : NULL;
 
 			/* update timestamps on the parent */
+			down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
+
 			if (ps_iattr) {
 				ktime_get_real_ts64(&ps_iattr->ia_ctime);
 				ps_iattr->ia_mtime = ps_iattr->ia_ctime;
 			}
 
+			up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 			kernfs_put(pos);
 		}
 
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 30494dcb0df34..b22b74d1a1150 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -101,9 +101,9 @@ int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 	int ret;
 	struct kernfs_root *root = kernfs_root(kn);
 
-	down_write(&root->kernfs_rwsem);
+	down_write(&root->kernfs_iattr_rwsem);
 	ret = __kernfs_setattr(kn, iattr);
-	up_write(&root->kernfs_rwsem);
+	up_write(&root->kernfs_iattr_rwsem);
 	return ret;
 }
 
@@ -119,7 +119,7 @@ int kernfs_iop_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		return -EINVAL;
 
 	root = kernfs_root(kn);
-	down_write(&root->kernfs_rwsem);
+	down_write(&root->kernfs_iattr_rwsem);
 	error = setattr_prepare(&nop_mnt_idmap, dentry, iattr);
 	if (error)
 		goto out;
@@ -132,7 +132,7 @@ int kernfs_iop_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	setattr_copy(&nop_mnt_idmap, inode, iattr);
 
 out:
-	up_write(&root->kernfs_rwsem);
+	up_write(&root->kernfs_iattr_rwsem);
 	return error;
 }
 
@@ -189,10 +189,10 @@ int kernfs_iop_getattr(struct mnt_idmap *idmap,
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_root *root = kernfs_root(kn);
 
-	down_read(&root->kernfs_rwsem);
+	down_read(&root->kernfs_iattr_rwsem);
 	kernfs_refresh_inode(kn, inode);
 	generic_fillattr(&nop_mnt_idmap, inode, stat);
-	up_read(&root->kernfs_rwsem);
+	up_read(&root->kernfs_iattr_rwsem);
 
 	return 0;
 }
@@ -285,10 +285,10 @@ int kernfs_iop_permission(struct mnt_idmap *idmap,
 	kn = inode->i_private;
 	root = kernfs_root(kn);
 
-	down_read(&root->kernfs_rwsem);
+	down_read(&root->kernfs_iattr_rwsem);
 	kernfs_refresh_inode(kn, inode);
 	ret = generic_permission(&nop_mnt_idmap, inode, mask);
-	up_read(&root->kernfs_rwsem);
+	up_read(&root->kernfs_iattr_rwsem);
 
 	return ret;
 }
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 236c3a6113f1e..3297093c920de 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -47,6 +47,7 @@ struct kernfs_root {
 
 	wait_queue_head_t	deactivate_waitq;
 	struct rw_semaphore	kernfs_rwsem;
+	struct rw_semaphore	kernfs_iattr_rwsem;
 };
 
 /* +1 to avoid triggering overflow warning when negating it */
-- 
2.34.1

