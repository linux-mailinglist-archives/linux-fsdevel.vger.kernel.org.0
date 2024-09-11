Return-Path: <linux-fsdevel+bounces-29077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FB6974DC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 11:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B038A287588
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 09:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A125B15FA92;
	Wed, 11 Sep 2024 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iQRyTpFb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5F42F860;
	Wed, 11 Sep 2024 09:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045285; cv=none; b=ARPM4RvPZ3JtH78Wjl/hD/Cz2ekSNTFB1omHDCA6tjolFPCmR+EtlbzBYASKoZV5jKqYhrApGs93gzRbCtQP+f3wFs9ux+XOyRtGumGDmL4VyAgdy1FMxVfj0eCM9ARPL2AbE2Qq4JkDeQ1a+i2Yu/Tv5taO1D7Dt0qMjUg2DlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045285; c=relaxed/simple;
	bh=8U4nzlDt3fb2W0lu/4l7h89KUqLnjh2lrZLNCvowtK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=leJf6ZXEMfZmdtHVT6lFKmZGRAbzVLYrNwr82PJe2wDWUFSe/IR39xn6a+G0T9pyibBGtRZHtoXEYFnE3dSZrJSsJXjVDAdEeeoav0AKzgfULp/Vky4az3IOLT33L1vVzQS+dKR1b6UvUduDAul2quea6HCdcwYcSulZB6BQfG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iQRyTpFb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48B2nBHo021934;
	Wed, 11 Sep 2024 09:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=itsQ5wy0XLC6kc9VmUV4h/EWz6
	9oHiKVaVc71aEnsCQ=; b=iQRyTpFbV/uvUHPD9/eLSBDV/8RxyzL0T7Qf5g3qFS
	JrEeDWuPlWh2HEb1W1GbJzbztUtEYvQsJDxgLpu5OaMBmOVfbeyB0ygieaOH+HlE
	yXrUqz9Sy3X9pmy6A63RgyoNtogim5Hp5hzKTjzhxvoQOIpIDSK0p9nphy9pEJZ1
	Ms6rBeaR4YcFWDFqk/2VtgeNUkyxn3OVVZwX04x7Mk9mNaOEIBYkv6ESt1sIbDYd
	/Spy7dKbI/otnalonpMLNkFlRx4Hq4Z0uilD9gFTXfQ1zK4ERJ6eHr77rS4Vc7VC
	xQqKiiG7wEhe39ScvQUNn8p59iePyG10slnRioDAtW4w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gejamm3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 09:01:16 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48B90ECh028525;
	Wed, 11 Sep 2024 09:01:15 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gejamm33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 09:01:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48B7TTct032109;
	Wed, 11 Sep 2024 09:01:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h2nmr8he-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 09:01:14 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48B91CZv55706016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 09:01:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 367AA20049;
	Wed, 11 Sep 2024 09:01:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8560720040;
	Wed, 11 Sep 2024 09:01:10 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.82])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Sep 2024 09:01:10 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>, dchinner@redhat.com
Subject: [RFC 0/5] ext4: Implement support for extsize hints
Date: Wed, 11 Sep 2024 14:31:04 +0530
Message-ID: <cover.1726034272.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wXBK5w84s3az57uTwavH7HwPYdiW7nJg
X-Proofpoint-GUID: bXp_s9v9rqdSX8zaWrVywtb0ltgHOj98
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=622 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409110064

This patchset implements extsize hint feature for ext4. Posting this RFC to get
some early review comments on the design and implementation bits. This feature
is similar to what we have in XFS too with some differences.

extsize on ext4 is a hint to mballoc (multi-block allocator) and extent
handling layer to do aligned allocations. We use allocation criteria 0
(CR_POWER2_ALIGNED) for doing aligned power-of-2 allocations. With extsize hint
we try to align the logical start (m_lblk) and length(m_len) of the allocation
to be extsize aligned. CR_POWER2_ALIGNED criteria in mballoc automatically make
sure that we get the aligned physical start (m_pblk) as well. So in this way
extsize can make sure that lblk, len and pblk all are aligned for the allocated
extent w.r.t extsize.

Note that extsize feature is just a hinting mechanism to ext4 multi-block
allocator. That means that if we are unable to get an aligned allocation for
some reason, than we drop this flag and continue with unaligned allocation to
serve the request. However when we will add atomic/untorn writes support, then
we will enforce the aligned allocation and can return -ENOSPC if aligned
allocation was not successful.

Comparison with XFS extsize feature -
=====================================
1. extsize in XFS is a hint for aligning only the logical start and the lengh
   of the allocation v/s extsize on ext4 make sure the physical start of the
   extent gets aligned as well.

2. eof allocation on XFS trims the blocks allocated beyond eof with extsize
   hint. That means on XFS for eof allocations (with extsize hint) only logical
   start gets aligned. However extsize hint in ext4 for eof allocation is not
   supported in this version of the series.

3. XFS allows extsize to be set on file with no extents but delayed data.
   However, ext4 don't allow that for simplicity. The user is expected to set
   it on a file before changing it's i_size.

4. XFS allows non-power-of-2 values for extsize but ext4 does not, since we
   primarily would like to support atomic writes with extsize.

5. In ext4 we chose to store the extsize value in SYSTEM_XATTR rather than an
   inode field as it was simple and most flexible, since there might be more
   features like atomic/untorn writes coming in future.

6. In buffered-io path XFS switches to non-delalloc allocations for extsize hint.
   The same has been kept for EXT4 as well.

Some TODOs:
===========
1. EOF allocations support can be added and can be kept similar to XFS.

Rest of the design details can be found in the individual commit messages.

Thoughts and suggestions are welcome!

Ojaswin Mujoo (5):
  ext4: add aligned allocation hint in mballoc
  ext4: allow inode preallocation for aligned alloc
  ext4: Support for extsize hint using FS_IOC_FS(GET/SET)XATTR
  ext4: pass lblk and len explicitly to ext4_split_extent*()
  ext4: Add extsize hint support

 fs/ext4/ext4.h              |  12 +-
 fs/ext4/ext4_jbd2.h         |  15 ++
 fs/ext4/extents.c           | 224 ++++++++++++++----
 fs/ext4/inode.c             | 442 +++++++++++++++++++++++++++++++++---
 fs/ext4/ioctl.c             | 119 ++++++++++
 fs/ext4/mballoc.c           | 126 ++++++++--
 fs/ext4/super.c             |   1 +
 include/trace/events/ext4.h |   2 +
 8 files changed, 841 insertions(+), 100 deletions(-)

-- 
2.43.5


