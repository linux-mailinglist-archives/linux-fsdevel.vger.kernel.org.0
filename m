Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8175C172A3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 22:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbgB0VeA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 16:34:00 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43810 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgB0VeA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:34:00 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01RLMpsU030108;
        Thu, 27 Feb 2020 21:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=SK3ORLcKLc32g22nLM5e6u2awazlkXAzyNrheC/M/BA=;
 b=lT5SdL84B4X3pWTeDR0nkPy5ugvzX8hus7R1OMp/2Bm/Crus2nfbx5DOs7IezcH/6IwS
 tR4fTgOPDF+iSnaBoY/c6d4P8Zxi79tNQFR6tQj6fPEkfMNyawQkHimbRgbnwYWG3yDL
 +MiHLGI1/TLX/rEaOi67VKHg4yy2RGVfZjQChzjkzHBMYFsRvelgVUF7DaUdCwMCUQew
 wz+Fb8NpAnu2n1MZtEUTQc+1aJ5NB903eA/f+XI83aU4UjKjhHz+BBw4HZAv+HfmzDHE
 r/lTWG6tFZlmooZawAY3GAttgzNVqj/RGhpchG5H9ry9N3SeI1vPL3rgZFLgmfzHhD4L pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2ydct3ds5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 21:33:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01RLIIK4052026;
        Thu, 27 Feb 2020 21:33:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2ydcs6bw07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 21:33:58 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01RLXvef008864;
        Thu, 27 Feb 2020 21:33:58 GMT
Received: from localhost (/10.145.179.117)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Feb 2020 13:33:57 -0800
Subject: [PATCH 3/3] ext4: allow online filesystem uuid queries
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Date:   Thu, 27 Feb 2020 13:33:54 -0800
Message-ID: <158283923456.904118.14244827054399587376.stgit@magnolia>
In-Reply-To: <158283921562.904118.13877489081184026686.stgit@magnolia>
References: <158283921562.904118.13877489081184026686.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=1 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=1 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270142
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Wire up the new ioctls to get and set the ext4 filesystem uuid.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/ext4/ioctl.c |  132 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)


diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index a0ec750018dd..c8d556c93cc7 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -813,6 +813,132 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
 	return error;
 }
 
+static int ext4_ioc_getfsuuid(struct super_block *sb,
+			      struct ioc_fsuuid __user *user_fu)
+{
+	struct ioc_fsuuid fu;
+	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
+
+	BUILD_BUG_ON(sizeof(es->s_uuid) != sizeof(uuid_t));
+
+	if (copy_from_user(&fu, user_fu, sizeof(fu)))
+		return -EFAULT;
+
+	if (fu.fu_reserved || fu.fu_reserved1 || fu.fu_flags)
+		return -EINVAL;
+
+	if (fu.fu_length == 0) {
+		fu.fu_length = sizeof(es->s_uuid);
+		goto out;
+	}
+
+	if (fu.fu_length < sizeof(es->s_uuid))
+		return -EINVAL;
+
+	if (copy_to_user(user_fu + 1, es->s_uuid, sizeof(es->s_uuid)))
+		return -EFAULT;
+	fu.fu_length = sizeof(es->s_uuid);
+
+out:
+	if (copy_to_user(user_fu, &fu, sizeof(fu)))
+		return -EFAULT;
+	return 0;
+}
+
+static int ext4_ioc_setfsuuid(struct file *filp, struct super_block *sb,
+			      struct ioc_fsuuid __user *user_fu)
+{
+	struct ioc_fsuuid fu;
+	uuid_t new_uuid;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	handle_t *handle;
+	int err, err2;
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
+	err = mnt_want_write_file(filp);
+	if (err)
+		return err;
+
+	handle = ext4_journal_start_sb(sb, EXT4_HT_RESIZE, 1);
+	if (IS_ERR(handle)) {
+		err = PTR_ERR(handle);
+		goto out_drop_write;
+	}
+	err = ext4_journal_get_write_access(handle, sbi->s_sbh);
+	if (err)
+		goto out_cancel_trans;
+
+	/*
+	 * Older ext4 filesystems with the group descriptor checksum feature
+	 * but not the general metadata checksum features require all group
+	 * descriptors to be rewritten to change the UUID.  We can't do that
+	 * here, so just bail out.
+	 */
+	if (ext4_has_feature_gdt_csum(sb) && !ext4_has_metadata_csum(sb)) {
+		err = -EOPNOTSUPP;
+		goto out_cancel_trans;
+	}
+
+	/*
+	 * Prior to the addition of metadata checksumming, the uuid was only
+	 * used in the superblock, so for those filesystems, all we need to do
+	 * here is update the incore uuid and write the super to disk.
+	 *
+	 * On a metadata_csum filesystem, every metadata object has a checksum
+	 * that is seeded with the checksum of the uuid that was set at
+	 * mkfs time.  The seed value can be stored in the ondisk superblock
+	 * or computed at mount time, depending on feature flags.
+	 *
+	 * If the csum_seed feature is not set, we need to turn on the
+	 * csum_seed feature.  If userspace did not set FORCE_INCOMPAT we have
+	 * to bail out.  Otherwise, copy the incore checksum seed to the ondisk
+	 * superblock, set the csum_seed feature bit, and then we can update
+	 * the incore uuid.
+	 */
+	if ((ext4_has_metadata_csum(sb) || ext4_has_feature_ea_inode(sb)) &&
+	    !ext4_has_feature_csum_seed(sb) &&
+	    memcmp(&new_uuid, sbi->s_es->s_uuid, sizeof(sbi->s_es->s_uuid))) {
+		if (!(fu.fu_flags & FS_IOC_SETFSUUID_FORCE_INCOMPAT)) {
+			err = -EOPNOTSUPP;
+			goto out_cancel_trans;
+		}
+		sbi->s_es->s_checksum_seed = cpu_to_le32(sbi->s_csum_seed);
+		ext4_set_feature_csum_seed(sb);
+	}
+	memcpy(sbi->s_es->s_uuid, &new_uuid, sizeof(uuid_t));
+
+	err = ext4_handle_dirty_super(handle, sb);
+	if (err)
+		goto out_cancel_trans;
+
+	/* Update incore state. */
+	uuid_copy(&sb->s_uuid, &new_uuid);
+	invalidate_bdev(sb->s_bdev);
+
+out_cancel_trans:
+	err2 = ext4_journal_stop(handle);
+	if (!err)
+		err = err2;
+out_drop_write:
+	mnt_drop_write_file(filp);
+	return err;
+}
+
 long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -1304,6 +1430,12 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			return -EOPNOTSUPP;
 		return fsverity_ioctl_measure(filp, (void __user *)arg);
 
+	case FS_IOC_GETFSUUID:
+		return ext4_ioc_getfsuuid(sb, (struct ioc_fsuuid __user *)arg);
+	case FS_IOC_SETFSUUID:
+		return ext4_ioc_setfsuuid(filp, sb,
+					  (struct ioc_fsuuid __user *)arg);
+
 	default:
 		return -ENOTTY;
 	}

