Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1233D25D0EC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 07:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgIDFjj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 01:39:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47428 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgIDFji (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 01:39:38 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0845YOBP190917;
        Fri, 4 Sep 2020 05:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=PYsmwBTOHx2pxVAHWEvKR4UXw2kGeTrQr9HNJO/W1FA=;
 b=AHI+e2/Zw2UNkoer0YANiTmY/IOzThkrDIyZjJm3WCKyLCdp+h2NwxqoET0Srl47ooeu
 ntAogPMQttr1QsuWLFZC1arqKpSNhhLetPwZRhaDrh7oqlKm3lJDyhZAnn1rS74MqT1R
 sFs+Oa7VnLreO6X2oeK5CZgePVU8/TOOcWI8myTaGueXP8t8OHE7LN2VWNEzcv/IbR9i
 F6FrDU/GYaGC5Oil6ue+N59eSvyGY2gJ2TPSyeLj8P1Lid1VIPVPepGWn+dU+8q9Wrfx
 k8WqlyHamXUDJW1pBYkmkaLB9dknYFmuzL5D9FhRBf6NWgni+s8XVma0wxzn7gDv1tyO /A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 337eymmgfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 05:39:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0845ZoJT096836;
        Fri, 4 Sep 2020 05:39:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 33b7v1xcyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 05:39:33 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0845dWt4030182;
        Fri, 4 Sep 2020 05:39:32 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Sep 2020 22:39:32 -0700
Date:   Thu, 3 Sep 2020 22:39:31 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: [PATCH] quota: widen timestamps for the fs_disk_quota structure
Message-ID: <20200904053931.GB6096@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9733 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=1 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040052
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9733 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040052
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Widen the timestamp fields in struct fs_disk_quota to handle quota grace
expiration times beyond 2038.  Since the only filesystem that's going to
use this (XFS) only supports unsigned 34-bit quantities, adding an extra
5 bits here should work fine.  We can rev the structure again in 350
years.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/quota/quota.c               |   40 +++++++++++++++++++++++++++++++++++++---
 include/uapi/linux/dqblk_xfs.h |   13 +++++++++++--
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 5444d3c4d93f..efa14d9ee06f 100644
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
@@ -588,10 +600,27 @@ static int quota_setxquota(struct super_block *sb, int type, qid_t id,
 	return sb->s_qcop->set_dqblk(sb, qid, &qdq);
 }
 
+static inline __s8 copy_to_xfs_dqblk_ts(const struct fs_disk_quota *d,
+		__s32 *timer_lo, s64 timer)
+{
+	*timer_lo = timer;
+	if (d->d_fieldmask & FS_DQ_BIGTIME)
+		return timer >> 32;
+	return 0;
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
@@ -606,6 +635,10 @@ static void copy_to_xfs_dqblk(struct fs_disk_quota *dst, struct qc_dqblk *src,
 	dst->d_ino_softlimit = src->d_ino_softlimit;
 	dst->d_bcount = quota_btobb(src->d_space);
 	dst->d_icount = src->d_ino_count;
+	dst->d_itimer_hi = copy_to_xfs_dqblk_ts(dst, &dst->d_itimer,
+						src->d_ino_timer);
+	dst->d_btimer_hi = copy_to_xfs_dqblk_ts(dst, &dst->d_btimer,
+						src->d_spc_timer);
 	dst->d_itimer = src->d_ino_timer;
 	dst->d_btimer = src->d_spc_timer;
 	dst->d_iwarns = src->d_ino_warns;
@@ -613,7 +646,8 @@ static void copy_to_xfs_dqblk(struct fs_disk_quota *dst, struct qc_dqblk *src,
 	dst->d_rtb_hardlimit = quota_btobb(src->d_rt_spc_hardlimit);
 	dst->d_rtb_softlimit = quota_btobb(src->d_rt_spc_softlimit);
 	dst->d_rtbcount = quota_btobb(src->d_rt_space);
-	dst->d_rtbtimer = src->d_rt_spc_timer;
+	dst->d_rtbtimer_hi = copy_to_xfs_dqblk_ts(dst, &dst->d_rtbtimer,
+						  src->d_rt_spc_timer);
 	dst->d_rtbwarns = src->d_rt_spc_warns;
 }
 
diff --git a/include/uapi/linux/dqblk_xfs.h b/include/uapi/linux/dqblk_xfs.h
index 03d890b80ebc..a684f64d9cc0 100644
--- a/include/uapi/linux/dqblk_xfs.h
+++ b/include/uapi/linux/dqblk_xfs.h
@@ -71,8 +71,11 @@ typedef struct fs_disk_quota {
 	__u64		d_rtb_softlimit;/* preferred limit on RT disk blks */
 	__u64		d_rtbcount;	/* # realtime blocks owned */
 	__s32		d_rtbtimer;	/* similar to above; for RT disk blks */
-	__u16	  	d_rtbwarns;     /* # warnings issued wrt RT disk blks */
-	__s16		d_padding3;	/* padding3 - for future use */	
+	__u16		d_rtbwarns;     /* # warnings issued wrt RT disk blks */
+	__s8		d_itimer_hi:5;	/* upper 5 bits of timers */
+	__s8		d_btimer_hi:5;
+	__s8		d_rtbtimer_hi:5;
+	__u8		d_padding3:1;	/* padding3 - for future use */
 	char		d_padding4[8];	/* yet more padding */
 } fs_disk_quota_t;
 
@@ -121,6 +124,12 @@ typedef struct fs_disk_quota {
 #define FS_DQ_RTBCOUNT		(1<<14)
 #define FS_DQ_ACCT_MASK		(FS_DQ_BCOUNT | FS_DQ_ICOUNT | FS_DQ_RTBCOUNT)
 
+/*
+ * Quota expiration timestamps are 37-bit signed integers, with the upper 5
+ * bits encoded in the _hi fields.
+ */
+#define FS_DQ_BIGTIME		(1<<15)
+
 /*
  * Various flags related to quotactl(2).
  */
