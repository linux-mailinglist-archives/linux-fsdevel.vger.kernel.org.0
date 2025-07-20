Return-Path: <linux-fsdevel+bounces-55537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA1DB0B832
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 22:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C78F87A91BE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 20:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD792264AC;
	Sun, 20 Jul 2025 20:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qyk3beSc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D8C1EB5F8;
	Sun, 20 Jul 2025 20:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753045080; cv=none; b=mncatETmWZJFHFMqfPcDJR52K0yiMxD+baQF1FS20X14o+KdIqKa8BnLUSns51JwKLAOm31c4SquxhMliz6tO3ZyXGsVzj+fDTGSGD0LacrBHmuh2abz/T/ok56g8df2wBq06RbNR4ADqeod8yaXcbwAIGBCM1mXn37ou+uT3jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753045080; c=relaxed/simple;
	bh=cglrMTNOlymVdsRgClIXmkOFe9RyxcrirA8koj9oolY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=loUb/Jdsk8jNcbMD3/n0+tQPml73XlldqHx53rwxSsaAUO1Cgmijl0QuW4qaWhMjXFjQvdMV4Q461HXWcORwZTrlgIOPaKvy4ZzE3LfpdjkjOV2px3KVUez09e9DGxDUYXqaLlqR0CScUqew2F73tS5DK1puWhIUSLu8Q0AQ0qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qyk3beSc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KHe8gl015475;
	Sun, 20 Jul 2025 20:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=2sWADe1dXy0hBSs6QJsMutuT038sEmKP64tXiwMPX
	Ro=; b=qyk3beScbCapiqGtxTCwbyHXczP1ZqfZRDOIutVjWISo0ZXfE1tw5RQ9U
	GMDFYffNCh1DtSjlG/0FNJs4zAUx1sBvPSM1o3X8a+F8SG8DLbKkz3GlCF+QEILc
	9FdBN3nchUJo3HKglP0AQq4MISB2XXJalKRqVbeQbkQhlxkG5XcI/WawmMOe2835
	GjZTBz78+puHqK6Bs8wblA5ZrDsykMhT3CAr8KmynmWtLRxZuDDzYks9YzpCPL4p
	hAWdKy89ZmBN939z8RXE2W4YLaeXtmwI/5GCRU2LYgRboqGPIQZpM7CYjgUw1mao
	rAPC2bz6Kx9kdb+HIg5ktXOS97/Rw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805uqngmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 20:57:40 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56KKvd8h004450;
	Sun, 20 Jul 2025 20:57:39 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805uqngmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 20:57:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56KGpapa005445;
	Sun, 20 Jul 2025 20:57:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 480tvqjeju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 20:57:38 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56KKvbb938994204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 20:57:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 292D520043;
	Sun, 20 Jul 2025 20:57:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D84F020040;
	Sun, 20 Jul 2025 20:57:34 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.16.241])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 20 Jul 2025 20:57:34 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        linux-kernel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [RFC v4 0/7] ext4: Add extsize support
Date: Mon, 21 Jul 2025 02:27:26 +0530
Message-ID: <cover.1753044253.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cnUZ-b88tUJELTxcqGwO3-RMQXp5erO7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE5OCBTYWx0ZWRfXxU8/qxKcsHvB
 ZxyxfUOqkQ/KkxG5+HZy/vXi+3Uen42+GSEYfPUAPHGzHRm7Skl4uNPrEodyDEeEStZdEHaU1WH
 jlsN5ysHZrIiisUQVEvcJx37ut8CcGR3xJconzpgkwvsuNCEnzFReAuCC4XNNOv/Wq3RfWR/ZYH
 Vxcqqn4gFrzwd03SEznh02/07c1rLyTsoK8FNzHsMRDCnZ3bfV2HVkXNVoA0u60bLfhyt4UhqC5
 QAo/LHOB7zbhm/wnWfvIVQ3LuE6zKfg0gCaww+ARqcZE2yAg+4nIAjFi3YGgeo+YyrMQ11DE19k
 +1x5fk2mCmt9GauqYYmaiTx6XCCpXwT6Cx940Ns2JEEq5ReIlC/efaldKgYTSdVD2GeHVmlcEeO
 AR1r+5Nu7JODRunvGAwKJD5by7nJgX6hhWN3S0T4hLeN7DxUPAi8i8F9ssGsDPWNhUTkxrv3
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=687d5844 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=qLmxhxPPVih0f9aMkoIA:9
X-Proofpoint-GUID: Zk5eZjwC0kt3Y6sJhqSGHRZakc3pB02x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507200198

This is the v4 for adding extsize support in ext4. extsize is primarily
being implemented as a building block to eventually support multiblock
atomic writes in ext4 without having to reformat the filesystem with
bigalloc. The long term goal behind implementing extsize is two fold:

1. We eventually want to give users a way to perform atomic writes
without needing a FS reformat to bigalloc.
  - this can be achieved via configurations like extsize + software
    fallback or extsize + forcealign. (More about forcealign can be
    found in previous RFC [1])

2. We want to implement a software atomic write fallback for ext4 (just
like XFS) and at the same time we want to give users the choice of
whether they want only HW accelerated (fast) atomic writes or are they
okay with falling back to software emulation (slow). Wanting to opt out
of SW fallback was also a point raised by some attendees in LSFMM.
  a) For users wanting guaranteed HW atomic writes, we want to implement
  extsize + forcealign. This ensures atomic writes are always HW
  accelerated however the write is bound to fail if the allocator can't
  guarantee HW acceleration for any reason (eg no aligned blocks
  available).

  b) For users which prefer software fallback rather than failing the
  write, we want to implement extsize + software fallback. extsize
  ensures we try to get aligned blocks for HW accelerated atomic writes
  on best effort basis, and SW fallback ensures we don't fail the write
  in case HW atomic writes are not possible. This is inline with how XFS
  has implemented multi block atomic writes.

The above approach helps ext4 provide more choice to the user about how
they want to perform the write based on what is more suitable for their
workload.

Both the approaches need extsize as a building block for the solutions
hence we are pushing the extsize changes separately and once community
is happy with these we can work on the next steps.

changes in v4 :
- removed forcealign patches so we can independently review extsize and
  then build on that later
- refactored previous implementation of ext4_map_query/create_blocks to
  use EXT4_EX_QUERY_FILTER
- removed some extra warn ons that were expected to hit in certain cases

[1] RFC v3: https://lore.kernel.org/linux-ext4/cover.1742800203.git.ojaswin@linux.ibm.com/

Testing: I've tested with xfstests auto and don't see any regressions.
Also tested with internal extsize related tests that I plan to upstream
soon.

Ojaswin Mujoo (7):
  ext4: add aligned allocation hint in mballoc
  ext4: allow inode preallocation for aligned alloc
  ext4: support for extsize hint using FS_IOC_FS(GET/SET)XATTR
  ext4: pass lblk and len explicitly to ext4_split_extent*()
  ext4: add extsize hint support
  ext4: make extsize work with EOF allocations
  ext4: add ext4_map_blocks_extsize() wrapper to handle overwrites

 fs/ext4/ext4.h              |  15 +-
 fs/ext4/ext4_jbd2.h         |  15 ++
 fs/ext4/extents.c           | 229 ++++++++++++++---
 fs/ext4/inode.c             | 485 ++++++++++++++++++++++++++++++++----
 fs/ext4/ioctl.c             | 122 +++++++++
 fs/ext4/mballoc.c           | 123 +++++++--
 fs/ext4/super.c             |   1 +
 include/trace/events/ext4.h |   1 +
 8 files changed, 881 insertions(+), 110 deletions(-)

-- 
2.49.0


