Return-Path: <linux-fsdevel+bounces-34970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DCE9CF40C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 19:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68CB28432B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 18:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157BE1E1327;
	Fri, 15 Nov 2024 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pDfMLM0U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BA21D90A9;
	Fri, 15 Nov 2024 18:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731695701; cv=none; b=FFpv+LHEG/ihdNGI6yyevM0ZnKV6xs4HfVTQ3vq/pbtHRABRijDW2BjIAT8DREZ3UClbR+R40StfOycK5Ezd6rv631pwDsfmvsUD6LdijNmduL2EtaGvoyDsenjabAO2Kda22m4lmBQj2A5G27hnWv09ZK9FRjhVubnXVdphbJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731695701; c=relaxed/simple;
	bh=ETOEBlYgg8wvp7pcY0zJLthy2u0xPje7eTXvjas1+CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eU4wiLEsdVdCCIPj+v9+U9U/tBtKajMlx+pQ3j8yqyOY7HvTiqmuP9/iBgWcaBnqPtRhNuF0xK5ryFpE4DU0ZhuKx4ERdmhWu4Exk7qwjuRrmSxonCH3UT27PMPzUFfbVED6H1euUNbJhoSxIe8jzo7CrD91P0F48dGxslXm1zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pDfMLM0U; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAYZow017776;
	Fri, 15 Nov 2024 18:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NaeFuVtQRAMp3kAyb
	jgMnmZ+sl1fDOpwrkd5a9/fNAY=; b=pDfMLM0UlPjxmWLqG19nUoakRVmnkkRYw
	AaBQ2+YjisjSroxXofB2Wl0yR0/ejXMALkq3l3Ar00yIQLNdu3UU7rK65X0EmxFu
	/nSwN4/QOwspNmM6i+Zwkg6uLXB2IAgf1yFDR8TiOecVyMv8fZVlcEOZQQyealhy
	3ox0MRqPwICUGL1CqulDJPnd9H7CNLMQL9juy3kCOUWgq+nSyRnf987NLx8wB0Uy
	uFhm02DPpVskWh2CJzbbecfauGWHrNaSE3AUc+28nJR1234mq3AzYHOugcc6XeIf
	wNULfOmRLzcldk3SSdMAFBDSeR4EU+gOrBTd+yFId7HBAHBChi40A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wuvc4qks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 18:34:57 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AFIMvkd030647;
	Fri, 15 Nov 2024 18:34:57 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wuvc4qkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 18:34:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFI6wKw008404;
	Fri, 15 Nov 2024 18:34:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tjf0n16e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 18:34:56 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AFIYsFo34996766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 18:34:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50CA020049;
	Fri, 15 Nov 2024 18:34:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17C6820040;
	Fri, 15 Nov 2024 18:34:53 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.39.26.153])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Nov 2024 18:34:52 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Disha Goel <disgoel@linux.ibm.com>
Subject: [PATCH 1/1] quota: flush quota_release_work upon quota writeback
Date: Sat, 16 Nov 2024 00:04:49 +0530
Message-ID: <20241115183449.2058590-2-ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241115183449.2058590-1-ojaswin@linux.ibm.com>
References: <20241115183449.2058590-1-ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OGK1j3jFeTWJRtq5fz84nehSHAD5gw0t
X-Proofpoint-ORIG-GUID: cPJ17xvV2fMqpskO2lE0T64ZWs9tKOSp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=942 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150156

One of the paths quota writeback is called from is:

freeze_super()
  sync_filesystem()
    ext4_sync_fs()
      dquot_writeback_dquots()

Since we currently don't always flush the quota_release_work queue in
this path, we can end up with the following race:

 1. dquot are added to releasing_dquots list during regular operations.
 2. FS freeze starts, however, this does not flush the quota_release_work queue.
 3. Freeze completes.
 4. Kernel eventually tries to flush the workqueue while FS is frozen which
    hits a WARN_ON since transaction gets started during frozen state:

  ext4_journal_check_start+0x28/0x110 [ext4] (unreliable)
  __ext4_journal_start_sb+0x64/0x1c0 [ext4]
  ext4_release_dquot+0x90/0x1d0 [ext4]
  quota_release_workfn+0x43c/0x4d0

Which is the following line:

  WARN_ON(sb->s_writers.frozen == SB_FREEZE_COMPLETE);

Which ultimately results in generic/390 failing due to dmesg
noise. This was detected on powerpc machine 15 cores.

To avoid this, make sure to flush the workqueue during
dquot_writeback_dquots() so we dont have any pending workitems after
freeze.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/quota/dquot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 3dd8d6f27725..2782cfc8c302 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -729,6 +729,8 @@ int dquot_writeback_dquots(struct super_block *sb, int type)
 			sb->dq_op->write_info(sb, cnt);
 	dqstats_inc(DQST_SYNCS);
 
+	flush_delayed_work(&quota_release_work);
+
 	return ret;
 }
 EXPORT_SYMBOL(dquot_writeback_dquots);
-- 
2.43.5


