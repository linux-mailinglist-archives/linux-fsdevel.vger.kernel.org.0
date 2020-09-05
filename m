Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B183825E91A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Sep 2020 18:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgIEQrN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Sep 2020 12:47:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37628 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgIEQrL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Sep 2020 12:47:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 085GjQh4025137;
        Sat, 5 Sep 2020 16:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=kyDXhauH7sz7EyCkCw5JPloouhqpGchEOI8FSeyqsoY=;
 b=SVS7dWGWZawIFcz0WQXMhEX0hT8kiKvEvaDwOdSTCmMaLvaTZUT+E9VowVq96+gvoHIh
 BMXi1YUvWGudV6Eri7hp9WCz+9jMxN4tSVYUj4Pch2NTjyGPxMbcHGIA9hFP4Tn8VAjA
 3hzdJyoBDsGGrI762ioLFxzxw7d1DHrFeoigbSqS3jBpBM2TezKGiICsFjg+spfWEUQG
 ZSSTEtN8lLQr6AA6IwFTPQz6RAnPugMoe+4EKSWMNlbsBcg6hpGKzli7C9ftVT7eBhot
 VVxdyWnB/owvi5Wr1/gdPx36SX7mFrxHHKmY2Mex/MEmgfwOr+HzK66NRSIMY01BcZEg jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 33c23qhkj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 05 Sep 2020 16:47:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 085GiruY073951;
        Sat, 5 Sep 2020 16:47:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 33c2g0t51b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Sep 2020 16:47:06 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 085Gl43Z000797;
        Sat, 5 Sep 2020 16:47:04 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 05 Sep 2020 09:47:04 -0700
Date:   Sat, 5 Sep 2020 09:47:03 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: [PATCH v2] quota: widen timestamps for the fs_disk_quota structure
Message-ID: <20200905164703.GC7955@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9735 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009050163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9735 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=1 spamscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009050163
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Soon, XFS will support quota grace period expiration timestamps beyond
the year 2038, widen the timestamp fields to handle the extra time bits.
Internally, XFS now stores unsigned 34-bit quantities, so the extra 8
bits here should work fine.  (Note that XFS is the only user of this
structure.)

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
v2: use __s8 for timestamp extension
---
 fs/quota/quota.c               |   43 +++++++++++++++++++++++++++++++++++-----
 include/uapi/linux/dqblk_xfs.h |   11 +++++++++-
 2 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 5444d3c4d93f..eefac57c52fd 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -481,6 +481,14 @@ static inline u64 quota_btobb(u64 bytes)
 	return (bytes + (1 << XFS_BB_SHIFT) - 1) >> XFS_BB_SHIFT;
 }
 
+static inline s64 copy_from_xfs_dqblk_ts(const struct fs_disk_quota *d,
+		__s32 timer, __s8 timer_hi)
+{
+	if (d->d_fieldmask & FS_DQ_BIGTIME)
+		return (u32)timer | (s64)timer_hi << 32;
+	return timer;
+}
+
 static void copy_from_xfs_dqblk(struct qc_dqblk *dst, struct fs_disk_quota *src)
 {
 	dst->d_spc_hardlimit = quota_bbtob(src->d_blk_hardlimit);
@@ -489,14 +497,18 @@ static void copy_from_xfs_dqblk(struct qc_dqblk *dst, struct fs_disk_quota *src)
 	dst->d_ino_softlimit = src->d_ino_softlimit;
 	dst->d_space = quota_bbtob(src->d_bcount);
 	dst->d_ino_count = src->d_icount;
-	dst->d_ino_timer = src->d_itimer;
-	dst->d_spc_timer = src->d_btimer;
+	dst->d_ino_timer = copy_from_xfs_dqblk_ts(src, src->d_itimer,
+						  src->d_itimer_hi);
+	dst->d_spc_timer = copy_from_xfs_dqblk_ts(src, src->d_btimer,
+						  src->d_btimer_hi);
 	dst->d_ino_warns = src->d_iwarns;
 	dst->d_spc_warns = src->d_bwarns;
 	dst->d_rt_spc_hardlimit = quota_bbtob(src->d_rtb_hardlimit);
 	dst->d_rt_spc_softlimit = quota_bbtob(src->d_rtb_softlimit);
 	dst->d_rt_space = quota_bbtob(src->d_rtbcount);
 	dst->d_rt_spc_timer = src->d_rtbtimer;
+	dst->d_rt_spc_timer = copy_from_xfs_dqblk_ts(src, src->d_rtbtimer,
+						     src->d_rtbtimer_hi);
 	dst->d_rt_spc_warns = src->d_rtbwarns;
 	dst->d_fieldmask = 0;
 	if (src->d_fieldmask & FS_DQ_ISOFT)
@@ -588,10 +600,28 @@ static int quota_setxquota(struct super_block *sb, int type, qid_t id,
 	return sb->s_qcop->set_dqblk(sb, qid, &qdq);
 }
 
+static inline void copy_to_xfs_dqblk_ts(const struct fs_disk_quota *d,
+		__s32 *timer_lo, __s8 *timer_hi, s64 timer)
+{
+	*timer_lo = timer;
+	if (d->d_fieldmask & FS_DQ_BIGTIME)
+		*timer_hi = timer >> 32;
+	else
+		*timer_hi = 0;
+}
+
+static inline bool want_bigtime(s64 timer)
+{
+	return timer > S32_MAX || timer < S32_MIN;
+}
+
 static void copy_to_xfs_dqblk(struct fs_disk_quota *dst, struct qc_dqblk *src,
 			      int type, qid_t id)
 {
 	memset(dst, 0, sizeof(*dst));
+	if (want_bigtime(src->d_ino_timer) || want_bigtime(src->d_spc_timer) ||
+	    want_bigtime(src->d_rt_spc_timer))
+		dst->d_fieldmask |= FS_DQ_BIGTIME;
 	dst->d_version = FS_DQUOT_VERSION;
 	dst->d_id = id;
 	if (type == USRQUOTA)
@@ -606,14 +636,17 @@ static void copy_to_xfs_dqblk(struct fs_disk_quota *dst, struct qc_dqblk *src,
 	dst->d_ino_softlimit = src->d_ino_softlimit;
 	dst->d_bcount = quota_btobb(src->d_space);
 	dst->d_icount = src->d_ino_count;
-	dst->d_itimer = src->d_ino_timer;
-	dst->d_btimer = src->d_spc_timer;
+	copy_to_xfs_dqblk_ts(dst, &dst->d_itimer, &dst->d_itimer_hi,
+			     src->d_ino_timer);
+	copy_to_xfs_dqblk_ts(dst, &dst->d_btimer, &dst->d_btimer_hi,
+			     src->d_spc_timer);
 	dst->d_iwarns = src->d_ino_warns;
 	dst->d_bwarns = src->d_spc_warns;
 	dst->d_rtb_hardlimit = quota_btobb(src->d_rt_spc_hardlimit);
 	dst->d_rtb_softlimit = quota_btobb(src->d_rt_spc_softlimit);
 	dst->d_rtbcount = quota_btobb(src->d_rt_space);
-	dst->d_rtbtimer = src->d_rt_spc_timer;
+	copy_to_xfs_dqblk_ts(dst, &dst->d_rtbtimer, &dst->d_rtbtimer_hi,
+			     src->d_rt_spc_timer);
 	dst->d_rtbwarns = src->d_rt_spc_warns;
 }
 
diff --git a/include/uapi/linux/dqblk_xfs.h b/include/uapi/linux/dqblk_xfs.h
index 03d890b80ebc..16d73f54376d 100644
--- a/include/uapi/linux/dqblk_xfs.h
+++ b/include/uapi/linux/dqblk_xfs.h
@@ -66,7 +66,10 @@ typedef struct fs_disk_quota {
 	__s32		d_btimer;	/* similar to above; for disk blocks */
 	__u16	  	d_iwarns;       /* # warnings issued wrt num inodes */
 	__u16	  	d_bwarns;       /* # warnings issued wrt disk blocks */
-	__s32		d_padding2;	/* padding2 - for future use */
+	__s8		d_itimer_hi;	/* upper 8 bits of timer values */
+	__s8		d_btimer_hi;
+	__s8		d_rtbtimer_hi;
+	__s8		d_padding2;	/* padding2 - for future use */
 	__u64		d_rtb_hardlimit;/* absolute limit on realtime blks */
 	__u64		d_rtb_softlimit;/* preferred limit on RT disk blks */
 	__u64		d_rtbcount;	/* # realtime blocks owned */
@@ -121,6 +124,12 @@ typedef struct fs_disk_quota {
 #define FS_DQ_RTBCOUNT		(1<<14)
 #define FS_DQ_ACCT_MASK		(FS_DQ_BCOUNT | FS_DQ_ICOUNT | FS_DQ_RTBCOUNT)
 
+/*
+ * Quota expiration timestamps are 40-bit signed integers, with the upper 8
+ * bits encoded in the _hi fields.
+ */
+#define FS_DQ_BIGTIME		(1<<15)
+
 /*
  * Various flags related to quotactl(2).
  */
