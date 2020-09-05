Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2594325E924
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Sep 2020 18:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgIEQue (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Sep 2020 12:50:34 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34150 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgIEQud (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Sep 2020 12:50:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 085GoTLd027853;
        Sat, 5 Sep 2020 16:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=2ZWHryTH9QAutu83+/PR+DrmK2KdiYbmvl4pc44S1yc=;
 b=BweMD4L8oK8GG8IMajT3kg6UI98LXjWJQsJz+6HhgRLCCSyjVHYCpKJ2xY09CSAWuXr4
 4CqHKrIQcDeqF7b5fJASZteNIhZNrMwXyqv3OLtiw/7W2Ezj+5c52/4dFMJdoW1w+vpV
 1LnO/ss2bZDR9DipCABV+X+N6hyDyJc+lB6mO/YRXTJWWyA6G16k5NtxpZ57SiRrVU48
 gYK5GfjupzMmstqQ6pBhelAfwtUE3YWa5qTR0WheAPVvk9Dr/aEM5eu+S9CYQiWFhj0h
 RB0sGxIikmTHBEATBnIhO1+BXsEeay113pqwnhtRfwtQiavHa2X11wRrqhtK7E7btWrb bw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 33c2mkhhac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 05 Sep 2020 16:50:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 085GjHWk005816;
        Sat, 5 Sep 2020 16:50:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 33c20hx3ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Sep 2020 16:50:28 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 085GoRwV026001;
        Sat, 5 Sep 2020 16:50:27 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 05 Sep 2020 09:50:27 -0700
Date:   Sat, 5 Sep 2020 09:50:26 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: [PATCH] quotatools: support grace period expirations past y2038 in
 userspace
Message-ID: <20200905165026.GD7955@magnolia>
References: <20200905164703.GC7955@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905164703.GC7955@magnolia>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9735 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=1
 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009050163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9735 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 suspectscore=1 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009050164
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Add the ability to interpret the larger quota grace period expiration
timestamps that the kernel can export via struct xfs_kern_dqblk.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 quotaio_xfs.c |   33 +++++++++++++++++++++++++++++----
 quotaio_xfs.h |   11 ++++++++++-
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/quotaio_xfs.c b/quotaio_xfs.c
index 3333bb1..9854ec2 100644
--- a/quotaio_xfs.c
+++ b/quotaio_xfs.c
@@ -42,6 +42,29 @@ scan_dquots:	xfs_scan_dquots,
 report:		xfs_report
 };
 
+static inline time_t xfs_kern2utildqblk_ts(const struct xfs_kern_dqblk *k,
+		__s32 timer, __s8 timer_hi)
+{
+	if (k->d_fieldmask & FS_DQ_BIGTIME)
+		return (__u32)timer | (__s64)timer_hi << 32;
+	return timer;
+}
+
+static inline void xfs_util2kerndqblk_ts(const struct xfs_kern_dqblk *k,
+		__s32 *timer_lo, __s8 *timer_hi, time_t timer)
+{
+	*timer_lo = timer;
+	if (k->d_fieldmask & FS_DQ_BIGTIME)
+		*timer_hi = timer >> 32;
+	else
+		*timer_hi = 0;
+}
+
+static inline int want_bigtime(time_t timer)
+{
+	return timer > INT32_MAX || timer < INT32_MIN;
+}
+
 /*
  *	Convert XFS kernel quota format to utility format
  */
@@ -53,8 +76,8 @@ static inline void xfs_kern2utildqblk(struct util_dqblk *u, struct xfs_kern_dqbl
 	u->dqb_bsoftlimit = k->d_blk_softlimit >> 1;
 	u->dqb_curinodes = k->d_icount;
 	u->dqb_curspace = ((qsize_t)k->d_bcount) << 9;
-	u->dqb_itime = k->d_itimer;
-	u->dqb_btime = k->d_btimer;
+	u->dqb_itime = xfs_kern2utildqblk_ts(k, k->d_itimer, k->d_itimer_hi);
+	u->dqb_btime = xfs_kern2utildqblk_ts(k, k->d_btimer, k->d_btimer_hi);
 }
 
 /*
@@ -69,8 +92,10 @@ static inline void xfs_util2kerndqblk(struct xfs_kern_dqblk *k, struct util_dqbl
 	k->d_blk_softlimit = u->dqb_bsoftlimit << 1;
 	k->d_icount = u->dqb_curinodes;
 	k->d_bcount = u->dqb_curspace >> 9;
-	k->d_itimer = u->dqb_itime;
-	k->d_btimer = u->dqb_btime;
+	if (want_bigtime(u->dqb_itime) || want_bigtime(u->dqb_btime))
+		k->d_fieldmask |= FS_DQ_BIGTIME;
+	xfs_util2kerndqblk_ts(k, &k->d_itimer, &k->d_itimer_hi, u->dqb_itime);
+	xfs_util2kerndqblk_ts(k, &k->d_btimer, &k->d_btimer_hi, u->dqb_btime);
 }
 
 /*
diff --git a/quotaio_xfs.h b/quotaio_xfs.h
index be7f86f..e0c2a62 100644
--- a/quotaio_xfs.h
+++ b/quotaio_xfs.h
@@ -72,7 +72,10 @@ typedef struct fs_disk_quota {
 	__s32 d_btimer;		/* similar to above; for disk blocks */
 	__u16 d_iwarns;		/* # warnings issued wrt num inodes */
 	__u16 d_bwarns;		/* # warnings issued wrt disk blocks */
-	__s32 d_padding2;	/* padding2 - for future use */
+	__s8 d_itimer_hi;	/* upper 8 bits of timer values */
+	__s8 d_btimer_hi;
+	__s8 d_rtbtimer_hi;
+	__s8 d_padding2;	/* padding2 - for future use */
 	__u64 d_rtb_hardlimit;	/* absolute limit on realtime blks */
 	__u64 d_rtb_softlimit;	/* preferred limit on RT disk blks */
 	__u64 d_rtbcount;	/* # realtime blocks owned */
@@ -114,6 +117,12 @@ typedef struct fs_disk_quota {
 #define FS_DQ_RTBCOUNT          (1<<14)
 #define FS_DQ_ACCT_MASK         (FS_DQ_BCOUNT | FS_DQ_ICOUNT | FS_DQ_RTBCOUNT)
 
+/*
+ * Quota expiration timestamps are 40-bit signed integers, with the upper 8
+ * bits encoded in the _hi fields.
+ */
+#define FS_DQ_BIGTIME		(1<<15)
+
 /*
  * Various flags related to quotactl(2).  Only relevant to XFS filesystems.
  */
