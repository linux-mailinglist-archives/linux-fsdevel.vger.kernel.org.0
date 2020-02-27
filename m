Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78910172A3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 22:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbgB0Vdx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 16:33:53 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46278 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgB0Vdx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:33:53 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01RLNiV1195538;
        Thu, 27 Feb 2020 21:33:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=LeO4b8BoftObGHpnYTNWh7068zE+UmbEf+8MLdUVGD0=;
 b=VBej/J64cPznzvVHCCsWh5ITHaJT/SInk3NmtcKQCdlUqJPIwgrLrhqasYJhJO0RxsG/
 i86GoTvCeYri/nh0OMZ3gSyMF+33e8S4mMovVvy6G7U4ZyCdeoh6HeO8bX79lAei58Gu
 jFYnupuS150vpQn2vD+cyN3Yaw/KhgmxCTBwyvjDJZJqItLZa2vJJFDMfIwDNgGSijXz
 3KCn3YdY3YKeAmn9GslHYyIrC7S/e2luliormvxu+1ow2pF7Uaafkg8w0W+rGhh17DKb
 uPS5AeLn3KZ4Tb1gXq8fiWN9OM9NK0wlKjO+RnyiGR/y1vgfs71u7aQNwloDMZjeTxO8 eA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2ydcsnnt6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 21:33:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01RLGiBM015387;
        Thu, 27 Feb 2020 21:33:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2ydcsde6u8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 21:33:50 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01RLXnUP008806;
        Thu, 27 Feb 2020 21:33:49 GMT
Received: from localhost (/10.145.179.117)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Feb 2020 13:33:48 -0800
Subject: [PATCH 2/3] xfs: allow online filesystem uuid queries
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Date:   Thu, 27 Feb 2020 13:33:48 -0800
Message-ID: <158283922839.904118.7827625132603295868.stgit@magnolia>
In-Reply-To: <158283921562.904118.13877489081184026686.stgit@magnolia>
References: <158283921562.904118.13877489081184026686.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=3 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 suspectscore=3 impostorscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270142
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Wire up the new ioctls to get and set xfs filesystem uuids.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_ioctl.c |  141 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_mount.c |   30 +++++++++--
 fs/xfs/xfs_mount.h |    3 +
 3 files changed, 169 insertions(+), 5 deletions(-)


diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index b4f5851e2ca5..66bd96d900cf 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1960,6 +1960,142 @@ xfs_fs_eofblocks_from_user(
 	return 0;
 }
 
+static inline int
+xfs_ioc_getfsuuid(
+	struct xfs_mount		*mp,
+	struct ioc_fsuuid __user	*user_fu)
+{
+	struct ioc_fsuuid		fu;
+
+	if (copy_from_user(&fu, user_fu, sizeof(fu)))
+		return -EFAULT;
+
+	if (fu.fu_reserved || fu.fu_reserved1 || fu.fu_flags)
+		return -EINVAL;
+
+	if (fu.fu_length == 0) {
+		fu.fu_length = sizeof(uuid_t);
+		goto out;
+	}
+
+	if (fu.fu_length < sizeof(uuid_t))
+		return -EINVAL;
+
+	if (copy_to_user(user_fu + 1, &mp->m_super->s_uuid, sizeof(uuid_t)))
+		return -EFAULT;
+	fu.fu_length = sizeof(uuid_t);
+
+out:
+	if (copy_to_user(user_fu, &fu, sizeof(fu)))
+		return -EFAULT;
+	return 0;
+}
+
+static inline int
+xfs_ioc_setfsuuid(
+	struct file			*filp,
+	struct xfs_mount		*mp,
+	struct ioc_fsuuid __user	*user_fu)
+{
+	struct ioc_fsuuid		fu;
+	uuid_t				old_uuid;
+	uuid_t				new_uuid;
+	uuid_t				*forget_uuid = NULL;
+	int				error;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (copy_from_user(&fu, user_fu, sizeof(fu)))
+		return -EFAULT;
+
+	if (fu.fu_reserved || fu.fu_reserved1 ||
+	    (fu.fu_flags & ~FS_IOC_SETFSUUID_ALL) ||
+	    fu.fu_length != sizeof(uuid_t))
+		return -EINVAL;
+
+	if (copy_from_user(&new_uuid, user_fu + 1, sizeof(uuid_t)))
+		return -EFAULT;
+	if (uuid_is_null(&new_uuid))
+		return -EINVAL;
+
+	error = mnt_want_write_file(filp);
+	if (error)
+		return error;
+
+	/* Save a slot in the uuid table, if desired. */
+	if (!(mp->m_flags & XFS_MOUNT_NOUUID)) {
+		error = xfs_uuid_remember(&new_uuid);
+		if (error)
+			goto out_drop_write;
+		forget_uuid = &new_uuid;
+	}
+
+	spin_lock(&mp->m_sb_lock);
+	uuid_copy(&old_uuid, &mp->m_sb.sb_uuid);
+
+	/*
+	 * Before v5, the uuid was only set in the superblock, so all we need
+	 * to do here is update the incore sb and write that out to disk.
+	 *
+	 * On a v5 filesystem, every metadata object has a uuid stamped into
+	 * the header.  The particular uuid used is either sb_uuid or
+	 * sb_meta_uuid, depending on whether the meta_uuid feature is set.
+	 *
+	 * If the meta_uuid feature is set and the new uuid matches the
+	 * meta_uuid, then we'll deactivate the feature and set sb_uuid to the
+	 * new uuid.
+	 *
+	 * If the meta_uuid feature is not set, the new uuid does not match the
+	 * existing sb_uuid, we need to turn on the meta_uuid feature.  If
+	 * userspace did not set FORCE_INCOMPAT we have to bail out.
+	 * Otherwise, copy sb_uuid to sb_meta_uuid, set the meta_uuid feature
+	 * bit, and set sb_uuid to the new uuid.
+	 */
+	if (xfs_sb_version_hasmetauuid(&mp->m_sb) &&
+	    uuid_equal(&new_uuid, &mp->m_sb.sb_meta_uuid)) {
+		mp->m_sb.sb_features_incompat &= ~XFS_SB_FEAT_INCOMPAT_META_UUID;
+	} else if (xfs_sb_version_hascrc(&mp->m_sb) &&
+		   !xfs_sb_version_hasmetauuid(&mp->m_sb) &&
+		   !uuid_equal(&new_uuid, &mp->m_sb.sb_uuid)) {
+		if (!(fu.fu_flags & FS_IOC_SETFSUUID_FORCE_INCOMPAT)) {
+			spin_unlock(&mp->m_sb_lock);
+			error = -EOPNOTSUPP;
+			goto out_drop_uuid;
+		}
+		uuid_copy(&mp->m_sb.sb_meta_uuid, &mp->m_sb.sb_uuid);
+		mp->m_sb.sb_features_incompat |= XFS_SB_FEAT_INCOMPAT_META_UUID;
+	}
+	uuid_copy(&mp->m_sb.sb_uuid, &new_uuid);
+	spin_unlock(&mp->m_sb_lock);
+
+	error = xfs_sync_sb_buf(mp);
+	if (error)
+		goto out_drop_uuid;
+
+	/* Update incore state and prepare to drop the old uuid. */
+	uuid_copy(&mp->m_super->s_uuid, &new_uuid);
+	if (!(mp->m_flags & XFS_MOUNT_NOUUID))
+		forget_uuid = &old_uuid;
+
+	/*
+	 * Update the secondary supers, being aware that growfs also updates
+	 * backup supers so we need to lock against that.
+	 */
+	mutex_lock(&mp->m_growlock);
+	error = xfs_update_secondary_sbs(mp);
+	mutex_unlock(&mp->m_growlock);
+
+	invalidate_bdev(mp->m_ddev_targp->bt_bdev);
+
+out_drop_uuid:
+	if (forget_uuid)
+		xfs_uuid_forget(forget_uuid);
+out_drop_write:
+	mnt_drop_write_file(filp);
+	return error;
+}
+
 /*
  * Note: some of the ioctl's return positive numbers as a
  * byte count indicating success, such as readlink_by_handle.
@@ -2246,6 +2382,11 @@ xfs_file_ioctl(
 		return xfs_icache_free_eofblocks(mp, &keofb);
 	}
 
+	case FS_IOC_GETFSUUID:
+		return xfs_ioc_getfsuuid(mp, arg);
+	case FS_IOC_SETFSUUID:
+		return xfs_ioc_setfsuuid(filp, mp, arg);
+
 	default:
 		return -ENOTTY;
 	}
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index e097cece492f..8acd9cffcf50 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -58,7 +58,7 @@ xfs_uuid_mount(
 	struct xfs_mount	*mp)
 {
 	uuid_t			*uuid = &mp->m_sb.sb_uuid;
-	int			hole, i;
+	int			error;
 
 	/* Publish UUID in struct super_block */
 	uuid_copy(&mp->m_super->s_uuid, uuid);
@@ -71,6 +71,21 @@ xfs_uuid_mount(
 		return -EINVAL;
 	}
 
+	error = xfs_uuid_remember(uuid);
+	if (!error)
+		return 0;
+
+	xfs_warn(mp, "Filesystem has duplicate UUID %pU - can't mount", uuid);
+	return error;
+}
+
+int
+xfs_uuid_remember(
+	const uuid_t	*uuid)
+{
+	int		hole;
+	int		i;
+
 	mutex_lock(&xfs_uuid_table_mutex);
 	for (i = 0, hole = -1; i < xfs_uuid_table_size; i++) {
 		if (uuid_is_null(&xfs_uuid_table[i])) {
@@ -94,7 +109,6 @@ xfs_uuid_mount(
 
  out_duplicate:
 	mutex_unlock(&xfs_uuid_table_mutex);
-	xfs_warn(mp, "Filesystem has duplicate UUID %pU - can't mount", uuid);
 	return -EINVAL;
 }
 
@@ -102,12 +116,18 @@ STATIC void
 xfs_uuid_unmount(
 	struct xfs_mount	*mp)
 {
-	uuid_t			*uuid = &mp->m_sb.sb_uuid;
-	int			i;
-
 	if (mp->m_flags & XFS_MOUNT_NOUUID)
 		return;
 
+	xfs_uuid_forget(&mp->m_sb.sb_uuid);
+}
+
+void
+xfs_uuid_forget(
+	const uuid_t		*uuid)
+{
+	int			i;
+
 	mutex_lock(&xfs_uuid_table_mutex);
 	for (i = 0; i < xfs_uuid_table_size; i++) {
 		if (uuid_is_null(&xfs_uuid_table[i]))
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 95ee6b898d3d..df6a7a703fe1 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -448,4 +448,7 @@ void xfs_force_summary_recalc(struct xfs_mount *mp);
 void xfs_mod_delalloc(struct xfs_mount *mp, int64_t delta);
 unsigned int xfs_guess_metadata_threads(struct xfs_mount *mp);
 
+int xfs_uuid_remember(const uuid_t *uuid);
+void xfs_uuid_forget(const uuid_t *uuid);
+
 #endif	/* __XFS_MOUNT_H__ */

