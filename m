Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCD12F8F7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 13:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfKLMO0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 07:14:26 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:47811 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfKLMOZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 07:14:25 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MC2k1-1icS7r06bV-00CSuG; Tue, 12 Nov 2019 13:09:14 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, y2038@lists.linaro.org, arnd@arndb.de,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Allison Collins <allison.henderson@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: [RFC 5/5] xfs: use 40-bit quota time limits
Date:   Tue, 12 Nov 2019 13:09:10 +0100
Message-Id: <20191112120910.1977003-6-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191112120910.1977003-1-arnd@arndb.de>
References: <20191112120910.1977003-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hu0HrsjmYlfJ6EP6ptEvp1wV1xTOhYiKly+Dc17guK11m5kYtyu
 xcv/ANpysFvUepXwpu416Pz+/3IGIrwYEQsyEuvM14Dkzg8orjSI0OigYK+4aY78cUH6fXm
 nld9QiO2TT94SBvu0MbVTPhaC24l2M/lJzohYWB94/qaQ0uKJt4Dql/mG1l57gll/2bHGux
 QXKsKgNMIwgxm1mcHsCxw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SS0vxOeiBd0=:sdmopsX+oksDbAwhFelJj9
 r3LwlGFBUlPpSqsyEROlJWXBiU5hp6Olt7ZaXQ0EzjOhiTLqYZSGNdNFR6AKTp9bzr9zkgQeU
 EbZ8Ph773jYpKIgq6pI1HPAdPAMPWNcfBYLezig8IGUps6SzKZo64MvGI/KCYs8gCj10cvVkX
 UTN0QLtatMArvoMbSo+k+D2DSa0u4tw6ptM91RBRirX4WdL0T3RU4FWnOfwxJkb6KBUCBONbv
 zBgCrjRz3Rnz8JBzx5rCuyx93oUWAf0mZz6ZvQe2noj8VMHaLKJyUkjsKJymuBAPmTKWrPC47
 W3w4noWuEvXJxYUE9dt97Zwa6QAL6qyQRlPwq8V33l+bFmTdZ/W6d5T3CL40339ht4ODrFJTV
 P5RyWlL1TVXzlm/MA0o62BGsAfE+2jmMpe3K9OzNf7u46sXQb/8JbJktLdbCrWubk3ZpXLeKc
 OJ7a0WxPRwdcL9K+mOsHXX3A+w5OyhTreBNK0RlbOhjQM6Tw3nZM5V0OTWl3icW3DBQCA7hmE
 NvcbwjnbzIveUkmHtmLhJZU/pBh8A1xlYcbGBlj6W4evYLpZvn8xEv8/wherAc3RAAubwuefD
 MsrBnzT00KVq3y4lZdZM+xyyPKyJ1aBwQVvKR7CxHiH/8THuc+Bfv5FT0AscLwymChwLTgag9
 +X+oVVlJnyU8EWK3Qkwdm+jqoyPAhbqJAGnxdF3ZAtRvRaz6xDGuRF0DVik+p9H9HKNvk1Sls
 KUhmSZJs6KxD9tjc9MW6yfC9Fl9f/ic0t8gE5kTE6phz5+AgNk4hQEFCAugLLH8Eg1EvQjshE
 uDdbV5jjpuyzrkAinDggqeRpirUIuh6L9f5rOFNr1DoYEbhA0gHOpt6LEJnMhuLeliCd7oIoW
 sy/Nd5eDNCG8SEjtIKkA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The quota handling in xfs is based around an in-memory representation
of time_t, which overflows in year 2038 on 32-bit architectures, and an
on-disk representation of __be32, which overflows in year 2106 based
on interpreting the values as unsigned.

Extend both to allow for much longer times: the in-memory representation
should just use time64_t and the on-disk representation has to live with
the spare bits in struct xfs_disk_dquot. As there is an unused 32-bit
field, and three time limits in it, allocating 8 bits per timeout
seems appropriate.

Note: the quotactl() syscall is not affected by this, it has its
own struct fs_disk_quota that may need a similar conversion.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/xfs/libxfs/xfs_dquot_buf.c |  6 +++---
 fs/xfs/libxfs/xfs_format.h    |  5 ++++-
 fs/xfs/xfs_dquot.c            | 29 ++++++++++++++++++++---------
 fs/xfs/xfs_qm.c               | 18 ++++++++++++------
 fs/xfs/xfs_qm.h               |  6 +++---
 fs/xfs/xfs_qm_syscalls.c      | 16 +++++++++++-----
 fs/xfs/xfs_quotaops.c         |  6 +++---
 fs/xfs/xfs_trans_dquot.c      | 17 +++++++++++------
 8 files changed, 67 insertions(+), 36 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_dquot_buf.c b/fs/xfs/libxfs/xfs_dquot_buf.c
index e8bd688a4073..ee59c539f9ab 100644
--- a/fs/xfs/libxfs/xfs_dquot_buf.c
+++ b/fs/xfs/libxfs/xfs_dquot_buf.c
@@ -75,17 +75,17 @@ xfs_dquot_verify(
 
 	if (ddq->d_blk_softlimit &&
 	    be64_to_cpu(ddq->d_bcount) > be64_to_cpu(ddq->d_blk_softlimit) &&
-	    !ddq->d_btimer)
+	    !ddq->d_btimer && !ddq->d_btimer_high)
 		return __this_address;
 
 	if (ddq->d_ino_softlimit &&
 	    be64_to_cpu(ddq->d_icount) > be64_to_cpu(ddq->d_ino_softlimit) &&
-	    !ddq->d_itimer)
+	    !ddq->d_itimer && !ddq->d_itimer_high)
 		return __this_address;
 
 	if (ddq->d_rtb_softlimit &&
 	    be64_to_cpu(ddq->d_rtbcount) > be64_to_cpu(ddq->d_rtb_softlimit) &&
-	    !ddq->d_rtbtimer)
+	    !ddq->d_rtbtimer && !ddq->d_rtbtimer_high)
 		return __this_address;
 
 	return NULL;
diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index dc8d160775fb..83bd5166c0ee 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -1168,7 +1168,10 @@ typedef struct	xfs_disk_dquot {
 	__be32		d_btimer;	/* similar to above; for disk blocks */
 	__be16		d_iwarns;	/* warnings issued wrt num inodes */
 	__be16		d_bwarns;	/* warnings issued wrt disk blocks */
-	__be32		d_pad0;		/* 64 bit align */
+	__u8		d_itimer_high;	/* upper bits of d_itimer */
+	__u8		d_btimer_high;	/* upper bits of d_btimer */
+	__u8		d_rtbtimer_high;/* upper bits of d_rtbtimer */
+	__u8		d_pad0;		/* 64 bit align */
 	__be64		d_rtb_hardlimit;/* absolute limit on realtime blks */
 	__be64		d_rtb_softlimit;/* preferred limit on RT disk blks */
 	__be64		d_rtbcount;	/* realtime blocks owned */
diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index aeb95e7391c1..15b5a339f6df 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -116,6 +116,8 @@ xfs_qm_adjust_dqtimers(
 	xfs_mount_t		*mp,
 	xfs_disk_dquot_t	*d)
 {
+	time64_t timer;
+
 	ASSERT(d->d_id);
 
 #ifdef DEBUG
@@ -130,15 +132,17 @@ xfs_qm_adjust_dqtimers(
 		       be64_to_cpu(d->d_rtb_hardlimit));
 #endif
 
-	if (!d->d_btimer) {
+	if (!d->d_btimer && !d->d_btimer_high) {
 		if ((d->d_blk_softlimit &&
 		     (be64_to_cpu(d->d_bcount) >
 		      be64_to_cpu(d->d_blk_softlimit))) ||
 		    (d->d_blk_hardlimit &&
 		     (be64_to_cpu(d->d_bcount) >
 		      be64_to_cpu(d->d_blk_hardlimit)))) {
-			d->d_btimer = cpu_to_be32(get_seconds() +
-					mp->m_quotainfo->qi_btimelimit);
+			timer = ktime_get_real_seconds() +
+				mp->m_quotainfo->qi_btimelimit;
+			d->d_btimer = cpu_to_be32(lower_32_bits(timer));
+			d->d_btimer_high = (u8)upper_32_bits(timer);
 		} else {
 			d->d_bwarns = 0;
 		}
@@ -150,18 +154,21 @@ xfs_qm_adjust_dqtimers(
 		    (be64_to_cpu(d->d_bcount) <=
 		     be64_to_cpu(d->d_blk_hardlimit)))) {
 			d->d_btimer = 0;
+			d->d_btimer_high = 0;
 		}
 	}
 
-	if (!d->d_itimer) {
+	if (!d->d_itimer && !d->d_itimer_high) {
 		if ((d->d_ino_softlimit &&
 		     (be64_to_cpu(d->d_icount) >
 		      be64_to_cpu(d->d_ino_softlimit))) ||
 		    (d->d_ino_hardlimit &&
 		     (be64_to_cpu(d->d_icount) >
 		      be64_to_cpu(d->d_ino_hardlimit)))) {
-			d->d_itimer = cpu_to_be32(get_seconds() +
-					mp->m_quotainfo->qi_itimelimit);
+			timer = ktime_get_real_seconds() +
+				mp->m_quotainfo->qi_itimelimit;
+			d->d_itimer = cpu_to_be32(lower_32_bits(timer));
+			d->d_itimer_high = (u8)upper_32_bits(timer);
 		} else {
 			d->d_iwarns = 0;
 		}
@@ -173,18 +180,21 @@ xfs_qm_adjust_dqtimers(
 		     (be64_to_cpu(d->d_icount) <=
 		      be64_to_cpu(d->d_ino_hardlimit)))) {
 			d->d_itimer = 0;
+			d->d_itimer_high = 0;
 		}
 	}
 
-	if (!d->d_rtbtimer) {
+	if (!d->d_rtbtimer && !d->d_rtbtimer_high) {
 		if ((d->d_rtb_softlimit &&
 		     (be64_to_cpu(d->d_rtbcount) >
 		      be64_to_cpu(d->d_rtb_softlimit))) ||
 		    (d->d_rtb_hardlimit &&
 		     (be64_to_cpu(d->d_rtbcount) >
 		      be64_to_cpu(d->d_rtb_hardlimit)))) {
-			d->d_rtbtimer = cpu_to_be32(get_seconds() +
-					mp->m_quotainfo->qi_rtbtimelimit);
+			timer = ktime_get_real_seconds() +
+				mp->m_quotainfo->qi_rtbtimelimit;
+			d->d_rtbtimer = cpu_to_be32(lower_32_bits(timer));
+			d->d_rtbtimer_high = (u8)upper_32_bits(timer);
 		} else {
 			d->d_rtbwarns = 0;
 		}
@@ -196,6 +206,7 @@ xfs_qm_adjust_dqtimers(
 		     (be64_to_cpu(d->d_rtbcount) <=
 		      be64_to_cpu(d->d_rtb_hardlimit)))) {
 			d->d_rtbtimer = 0;
+			d->d_rtbtimer_high = 0;
 		}
 	}
 }
diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index ecd8ce152ab1..afd0384850f9 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -613,12 +613,15 @@ xfs_qm_init_timelimits(
 	 * a user or group before he or she can not perform any
 	 * more writing. If it is zero, a default is used.
 	 */
-	if (ddqp->d_btimer)
-		qinf->qi_btimelimit = be32_to_cpu(ddqp->d_btimer);
-	if (ddqp->d_itimer)
-		qinf->qi_itimelimit = be32_to_cpu(ddqp->d_itimer);
-	if (ddqp->d_rtbtimer)
-		qinf->qi_rtbtimelimit = be32_to_cpu(ddqp->d_rtbtimer);
+	if (ddqp->d_btimer || ddqp->d_btimer_high)
+		qinf->qi_btimelimit = be32_to_cpu(ddqp->d_btimer) +
+					((u64)ddqp->d_btimer_high << 32);
+	if (ddqp->d_itimer || ddqp->d_itimer_high)
+		qinf->qi_itimelimit = be32_to_cpu(ddqp->d_itimer) +
+					((u64)ddqp->d_itimer_high << 32);
+	if (ddqp->d_rtbtimer || ddqp->d_rtbtimer_high)
+		qinf->qi_rtbtimelimit = be32_to_cpu(ddqp->d_rtbtimer) +
+					((u64)ddqp->d_rtbtimer_high << 32);
 	if (ddqp->d_bwarns)
 		qinf->qi_bwarnlimit = be16_to_cpu(ddqp->d_bwarns);
 	if (ddqp->d_iwarns)
@@ -867,8 +870,11 @@ xfs_qm_reset_dqcounts(
 		ddq->d_icount = 0;
 		ddq->d_rtbcount = 0;
 		ddq->d_btimer = 0;
+		ddq->d_btimer_high = 0;
 		ddq->d_itimer = 0;
+		ddq->d_itimer_high = 0;
 		ddq->d_rtbtimer = 0;
+		ddq->d_rtbtimer_high = 0;
 		ddq->d_bwarns = 0;
 		ddq->d_iwarns = 0;
 		ddq->d_rtbwarns = 0;
diff --git a/fs/xfs/xfs_qm.h b/fs/xfs/xfs_qm.h
index b41b75089548..4742686d522e 100644
--- a/fs/xfs/xfs_qm.h
+++ b/fs/xfs/xfs_qm.h
@@ -64,9 +64,9 @@ typedef struct xfs_quotainfo {
 	struct xfs_inode	*qi_pquotaip;	/* project quota inode */
 	struct list_lru	 qi_lru;
 	int		 qi_dquots;
-	time_t		 qi_btimelimit;	 /* limit for blks timer */
-	time_t		 qi_itimelimit;	 /* limit for inodes timer */
-	time_t		 qi_rtbtimelimit;/* limit for rt blks timer */
+	time64_t	 qi_btimelimit;	 /* limit for blks timer */
+	time64_t	 qi_itimelimit;	 /* limit for inodes timer */
+	time64_t	 qi_rtbtimelimit;/* limit for rt blks timer */
 	xfs_qwarncnt_t	 qi_bwarnlimit;	 /* limit for blks warnings */
 	xfs_qwarncnt_t	 qi_iwarnlimit;	 /* limit for inodes warnings */
 	xfs_qwarncnt_t	 qi_rtbwarnlimit;/* limit for rt blks warnings */
diff --git a/fs/xfs/xfs_qm_syscalls.c b/fs/xfs/xfs_qm_syscalls.c
index da7ad0383037..8d7d075d7779 100644
--- a/fs/xfs/xfs_qm_syscalls.c
+++ b/fs/xfs/xfs_qm_syscalls.c
@@ -500,15 +500,18 @@ xfs_qm_scall_setqlim(
 		 */
 		if (newlim->d_fieldmask & QC_SPC_TIMER) {
 			q->qi_btimelimit = newlim->d_spc_timer;
-			ddq->d_btimer = cpu_to_be32(newlim->d_spc_timer);
+			ddq->d_btimer = cpu_to_be32(lower_32_bits(newlim->d_spc_timer));
+			ddq->d_btimer_high = (u8)upper_32_bits(newlim->d_spc_timer);
 		}
 		if (newlim->d_fieldmask & QC_INO_TIMER) {
 			q->qi_itimelimit = newlim->d_ino_timer;
-			ddq->d_itimer = cpu_to_be32(newlim->d_ino_timer);
+			ddq->d_itimer = cpu_to_be32(lower_32_bits(newlim->d_ino_timer));
+			ddq->d_itimer_high = (u8)upper_32_bits(newlim->d_ino_timer);
 		}
 		if (newlim->d_fieldmask & QC_RT_SPC_TIMER) {
 			q->qi_rtbtimelimit = newlim->d_rt_spc_timer;
 			ddq->d_rtbtimer = cpu_to_be32(newlim->d_rt_spc_timer);
+			ddq->d_rtbtimer_high = (u8)upper_32_bits(newlim->d_rt_spc_timer);
 		}
 		if (newlim->d_fieldmask & QC_SPC_WARNS)
 			q->qi_bwarnlimit = newlim->d_spc_warns;
@@ -623,8 +626,10 @@ xfs_qm_scall_getquota_fill_qc(
 	dst->d_ino_softlimit = be64_to_cpu(dqp->q_core.d_ino_softlimit);
 	dst->d_space = XFS_FSB_TO_B(mp, dqp->q_res_bcount);
 	dst->d_ino_count = dqp->q_res_icount;
-	dst->d_spc_timer = be32_to_cpu(dqp->q_core.d_btimer);
-	dst->d_ino_timer = be32_to_cpu(dqp->q_core.d_itimer);
+	dst->d_spc_timer = be32_to_cpu(dqp->q_core.d_btimer) +
+			   ((u64)dqp->q_core.d_btimer_high << 32);
+	dst->d_ino_timer = be32_to_cpu(dqp->q_core.d_itimer) +
+			   ((u64)dqp->q_core.d_itimer_high << 32);
 	dst->d_ino_warns = be16_to_cpu(dqp->q_core.d_iwarns);
 	dst->d_spc_warns = be16_to_cpu(dqp->q_core.d_bwarns);
 	dst->d_rt_spc_hardlimit =
@@ -632,7 +637,8 @@ xfs_qm_scall_getquota_fill_qc(
 	dst->d_rt_spc_softlimit =
 		XFS_FSB_TO_B(mp, be64_to_cpu(dqp->q_core.d_rtb_softlimit));
 	dst->d_rt_space = XFS_FSB_TO_B(mp, dqp->q_res_rtbcount);
-	dst->d_rt_spc_timer = be32_to_cpu(dqp->q_core.d_rtbtimer);
+	dst->d_rt_spc_timer = be32_to_cpu(dqp->q_core.d_rtbtimer) +
+			   ((u64)dqp->q_core.d_rtbtimer_high << 32);
 	dst->d_rt_spc_warns = be16_to_cpu(dqp->q_core.d_rtbwarns);
 
 	/*
diff --git a/fs/xfs/xfs_quotaops.c b/fs/xfs/xfs_quotaops.c
index cd6c7210a373..96c3818b27ad 100644
--- a/fs/xfs/xfs_quotaops.c
+++ b/fs/xfs/xfs_quotaops.c
@@ -37,9 +37,9 @@ xfs_qm_fill_state(
 	tstate->flags |= QCI_SYSFILE;
 	tstate->blocks = ip->i_d.di_nblocks;
 	tstate->nextents = ip->i_d.di_nextents;
-	tstate->spc_timelimit = q->qi_btimelimit;
-	tstate->ino_timelimit = q->qi_itimelimit;
-	tstate->rt_spc_timelimit = q->qi_rtbtimelimit;
+	tstate->spc_timelimit = (u32)q->qi_btimelimit;
+	tstate->ino_timelimit = (u32)q->qi_itimelimit;
+	tstate->rt_spc_timelimit = (u32)q->qi_rtbtimelimit;
 	tstate->spc_warnlimit = q->qi_bwarnlimit;
 	tstate->ino_warnlimit = q->qi_iwarnlimit;
 	tstate->rt_spc_warnlimit = q->qi_rtbwarnlimit;
diff --git a/fs/xfs/xfs_trans_dquot.c b/fs/xfs/xfs_trans_dquot.c
index 16457465833b..6efca54e0edb 100644
--- a/fs/xfs/xfs_trans_dquot.c
+++ b/fs/xfs/xfs_trans_dquot.c
@@ -580,7 +580,7 @@ xfs_trans_dqresv(
 {
 	xfs_qcnt_t	hardlimit;
 	xfs_qcnt_t	softlimit;
-	time_t		timer;
+	time64_t	timer;
 	xfs_qwarncnt_t	warns;
 	xfs_qwarncnt_t	warnlimit;
 	xfs_qcnt_t	total_count;
@@ -600,7 +600,8 @@ xfs_trans_dqresv(
 		softlimit = be64_to_cpu(dqp->q_core.d_blk_softlimit);
 		if (!softlimit)
 			softlimit = defq->bsoftlimit;
-		timer = be32_to_cpu(dqp->q_core.d_btimer);
+		timer = be32_to_cpu(dqp->q_core.d_btimer) +
+			((u64)dqp->q_core.d_btimer_high << 32);
 		warns = be16_to_cpu(dqp->q_core.d_bwarns);
 		warnlimit = dqp->q_mount->m_quotainfo->qi_bwarnlimit;
 		resbcountp = &dqp->q_res_bcount;
@@ -612,7 +613,8 @@ xfs_trans_dqresv(
 		softlimit = be64_to_cpu(dqp->q_core.d_rtb_softlimit);
 		if (!softlimit)
 			softlimit = defq->rtbsoftlimit;
-		timer = be32_to_cpu(dqp->q_core.d_rtbtimer);
+		timer = be32_to_cpu(dqp->q_core.d_rtbtimer) +
+			((u64)dqp->q_core.d_rtbtimer_high << 32);
 		warns = be16_to_cpu(dqp->q_core.d_rtbwarns);
 		warnlimit = dqp->q_mount->m_quotainfo->qi_rtbwarnlimit;
 		resbcountp = &dqp->q_res_rtbcount;
@@ -635,7 +637,8 @@ xfs_trans_dqresv(
 				goto error_return;
 			}
 			if (softlimit && total_count > softlimit) {
-				if ((timer != 0 && get_seconds() > timer) ||
+				if ((timer != 0 &&
+				     ktime_get_real_seconds() > timer) ||
 				    (warns != 0 && warns >= warnlimit)) {
 					xfs_quota_warn(mp, dqp,
 						       QUOTA_NL_BSOFTLONGWARN);
@@ -647,7 +650,8 @@ xfs_trans_dqresv(
 		}
 		if (ninos > 0) {
 			total_count = be64_to_cpu(dqp->q_core.d_icount) + ninos;
-			timer = be32_to_cpu(dqp->q_core.d_itimer);
+			timer = be32_to_cpu(dqp->q_core.d_itimer) +
+				((u64)dqp->q_core.d_itimer_high << 32);
 			warns = be16_to_cpu(dqp->q_core.d_iwarns);
 			warnlimit = dqp->q_mount->m_quotainfo->qi_iwarnlimit;
 			hardlimit = be64_to_cpu(dqp->q_core.d_ino_hardlimit);
@@ -662,7 +666,8 @@ xfs_trans_dqresv(
 				goto error_return;
 			}
 			if (softlimit && total_count > softlimit) {
-				if  ((timer != 0 && get_seconds() > timer) ||
+				if  ((timer != 0 &&
+				      ktime_get_real_seconds() > timer) ||
 				     (warns != 0 && warns >= warnlimit)) {
 					xfs_quota_warn(mp, dqp,
 						       QUOTA_NL_ISOFTLONGWARN);
-- 
2.20.0

