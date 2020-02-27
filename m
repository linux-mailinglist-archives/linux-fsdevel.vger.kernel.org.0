Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC80172A38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 22:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbgB0Vdq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 16:33:46 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:44690 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgB0Vdq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:33:46 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01RLO7EN160078;
        Thu, 27 Feb 2020 21:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=gG8N/ZZ/oNWL1TJdw/TGNSOtJpIZs1TYnGMlRyZuD54=;
 b=e5Umj30jJwT8YSMsEOYZ5DpzAr6BhvFscrgileqANDABJSnmwaoC15xYYaKp07S3ZqXr
 rjvUO3tN4L3VnUpotuomMQf2MsW1GTlqP2uvq2kevRocwfovHMDotsD6qC7OdKxqxdNa
 mH4kLBL+tANNhlzL9x4W+eFcFRuTGz0KSsmBD0tWzl40QUzuQTV2BnE13KmI615V7U/O
 vsVNv3678hcrs99Kimypi6z1RaOJKtlsIv9Ij9N+Rg31b9uQ5Rd9R18xQfR4YljdpsS8
 BOH/b21otjky4gLcAq0yCtk9nKC40BwnnV+ksB25g0yPgGQJjbJ0GuNm2T4k5r5JVdiI 9w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2yehxrsbfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 21:33:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01RLGLgW050238;
        Thu, 27 Feb 2020 21:33:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2ydcsauv4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 21:33:44 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01RLXhgH008676;
        Thu, 27 Feb 2020 21:33:43 GMT
Received: from localhost (/10.145.179.117)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Feb 2020 13:33:42 -0800
Subject: [PATCH 1/3] vfs: create ioctls to query and set the filesystem uuids
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Date:   Thu, 27 Feb 2020 13:33:41 -0800
Message-ID: <158283922171.904118.10312419179350062263.stgit@magnolia>
In-Reply-To: <158283921562.904118.13877489081184026686.stgit@magnolia>
References: <158283921562.904118.13877489081184026686.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=1 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 suspectscore=1 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270142
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Define a pair of ioctls to get and set the filesystem uuid.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/libxfs/xfs_fs.h  |    2 ++
 include/uapi/linux/fs.h |   28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 558a396c74b3..c968eaf56ec3 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -814,6 +814,8 @@ struct xfs_scrub_metadata {
 #define XFS_IOC_FSGEOMETRY	     _IOR ('X', 126, struct xfs_fsop_geom)
 #define XFS_IOC_BULKSTAT	     _IOR ('X', 127, struct xfs_bulkstat_req)
 #define XFS_IOC_INUMBERS	     _IOR ('X', 128, struct xfs_inumbers_req)
+/*	FS_IOC_GETFSUUID ----------- uses 129 */
+/*	FS_IOC_SETFSUUID ----------- uses 130 */
 /*	XFS_IOC_GETFSUUID ---------- deprecated 140	 */
 
 
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 379a612f8f1d..a5423d540ecd 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -142,6 +142,32 @@ struct fsxattr {
 #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
 #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
 
+/* Get and set filesystem UUID. */
+struct ioc_fsuuid {
+	uint32_t	fu_flags;
+	uint16_t	fu_length;
+	uint16_t	fu_reserved;
+	uint64_t	fu_reserved1;
+};
+
+/*
+ * Set the UUID even if that would require setting of an incompat or rocompat
+ * feature flag.  This will make the filesystem unmountable on older kernels.
+ */
+#define FS_IOC_SETFSUUID_FORCE_INCOMPAT	(1 << 0)
+
+#define FS_IOC_SETFSUUID_ALL	(FS_IOC_SETFSUUID_FORCE_INCOMPAT)
+
+static inline size_t ioc_fsuuid_sizeof(size_t payload_len)
+{
+	return sizeof(struct ioc_fsuuid) + payload_len;
+}
+
+static inline char *ioc_fsuuid_payload(struct ioc_fsuuid *fu)
+{
+	return (char *)(fu + 1);
+}
+
 /* the read-only stuff doesn't really belong here, but any other place is
    probably as bad and I don't want to create yet another include file. */
 
@@ -214,6 +240,8 @@ struct fsxattr {
 #define FS_IOC_FSSETXATTR		_IOW('X', 32, struct fsxattr)
 #define FS_IOC_GETFSLABEL		_IOR(0x94, 49, char[FSLABEL_MAX])
 #define FS_IOC_SETFSLABEL		_IOW(0x94, 50, char[FSLABEL_MAX])
+#define FS_IOC_GETFSUUID		_IOR('X', 129, struct ioc_fsuuid)
+#define FS_IOC_SETFSUUID		_IOW('X', 130, struct ioc_fsuuid)
 
 /*
  * Inode flags (FS_IOC_GETFLAGS / FS_IOC_SETFLAGS)

