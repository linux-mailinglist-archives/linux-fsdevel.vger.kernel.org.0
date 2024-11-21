Return-Path: <linux-fsdevel+bounces-35442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6612A9D4CFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 13:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E8C1B25462
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 12:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0639B1D6DDA;
	Thu, 21 Nov 2024 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qlgchR0O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CA71D0F66;
	Thu, 21 Nov 2024 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732192751; cv=none; b=VyZ0OI2Jga34r1LI7rECiI3m2OB5mwh+qS3kdO0V+l0qwBGOe5DqaHAZGuwI+5KqxnBnQASDcpsHL/mwHYwzHuV+p1t9MCx4ivifbvI05BHI8aGrSXsLXAyNhO2dN7V8/jb5q/uoWW6lwdN+Siwgb2kYGPZO0nofh3G63+SJMcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732192751; c=relaxed/simple;
	bh=8xjSf05nAdp1JvAMlz7MNeWjj2n5t2Son3K7+3hln0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VbEixjD8m7dDq5fo14r2IOdBjkpaIut13bKAV5oitvz/0zNXcstHTr7Qa0CizS6m1w3rmN9BB2fI1ShxqQ2qCkmCC01DTUouRqAKhm4NsbZj3ZHD+DDHiP+DpS1iFNs81uDAZuBOzgoJaVuzZG49gv1/91Ta4D0aPcTsG9Z/X4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qlgchR0O; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALCLv4q023046;
	Thu, 21 Nov 2024 12:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=O/ECh6stuvVYPaBsgU8koXpxoWSOynA5FZ31Yt+3r
	hY=; b=qlgchR0Oulx29wr686zG/hPsPbUNgtMJKCQRPRW7htW7/6BTYmuXaw4/p
	6A5lj5JG9TQ9j5AhlxpnpsTiW43J38jghAUDwekCZKux4OC1o13irr5xNjpNCyKT
	lipn08+fHaApPMxSvxrqhJfV2zPEXI++EpDiUjZ9LvlRVQui+LGGutU7p9qNZNTB
	NTw5eFPYofsqcCD5GpqviCtBJH41H+ZgYCf26TRSdeMaDFZkHhV4xJwuMxRaW0Zi
	VhcL5iVq4yOxLXNSZZdifbhCD6bLn42ROZe+TO2AaabE6HCASd+VSSNpPbYVPr1u
	AKVXYAWCkJ0EoOQxokvb0xlkDt7iA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xgttjw21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 12:39:00 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4ALCd03h002516;
	Thu, 21 Nov 2024 12:39:00 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xgttjw1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 12:39:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL61x15011994;
	Thu, 21 Nov 2024 12:38:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42y7xjrmht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 12:38:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ALCcvM852363570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 12:38:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A735120043;
	Thu, 21 Nov 2024 12:38:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 673AA20040;
	Thu, 21 Nov 2024 12:38:56 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.82])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Nov 2024 12:38:56 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
Subject: [PATCH v2 0/2] Fix generic/390 failure due to quota release after freeze
Date: Thu, 21 Nov 2024 18:08:53 +0530
Message-ID: <20241121123855.645335-1-ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ekGEkwAqD5J-C8GnDljUCh-laGIg3mLt
X-Proofpoint-ORIG-GUID: Y5RU1JJ2By94QuBbpyYMtUw-i_LC8tYI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411210098

Changes since v1:

 * Patch 1: Move flush_delayed_work() to start of function
 * Patch 2: Guard ext4_release_dquot against freeze

Regarding patch 2, as per my understanding of the journalling code,
right now ext4_release_dquot() can only be called from the
quota_realease_work workqueue and hence ideally should never have a
journal open but to future-proof it we make sure the journal is not
opened when calling sb_start_inwrite().

** Original Cover **

Recently we noticed generic/390 failing on powerpc systems. This test
basically does a freeze-unfreeze loop in parallel with fsstress on the
FS to detect any races in the code paths.

We noticed that the test started failing due to kernel WARN_ONs because
quota_release_work workqueue started executing while the FS was frozen
which led to creating new transactions in ext4_release_quota. 

Most of the details are in the bug however I'd just like to add that
I'm completely new to quota code so the patch, although fixing the
issue, might be not be logically the right thing to do. So reviews and
suggestions are welcome. 

Also, I can only replicate this race on one of my machines reliably and
does not appear on others.  I've tested with with fstests -g quota and
don't see any new failures.

Ojaswin Mujoo (2):
  quota: flush quota_release_work upon quota writeback
  ext4: protect ext4_release_dquot against freezing

 fs/ext4/super.c  | 17 +++++++++++++++++
 fs/quota/dquot.c |  2 ++
 2 files changed, 19 insertions(+)

-- 
2.43.5


