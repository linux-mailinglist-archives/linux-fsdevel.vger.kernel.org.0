Return-Path: <linux-fsdevel+bounces-40281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E51A21814
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 08:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B8767A2842
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 07:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCEE197A7F;
	Wed, 29 Jan 2025 07:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DTK1w3FK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E11195980;
	Wed, 29 Jan 2025 07:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738135554; cv=none; b=T+vsfBG31YzGtZtA8OxZDbAIZe3NWyE3uUHb14rcmz7pDbs9Osc1FAgjJ5QRXLw2c9qRrXl6F47SHqU13n6STY2mukKWCG4uWKFPC+aZIonEypj5VxRiBblJldSrL+6QeMp1mMWaSRev5D7B9WXIpTuZqi5D2GwuTXaYEzUeF0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738135554; c=relaxed/simple;
	bh=4JBF85Zs9KaxqNCFNgY/rPgQFpwcL3Ebz5n/QO89MiE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sqYKbptQovCJKiPhIW5STUQIBTd0RiCm9WydLhRSy3IKZIbK430nv1Ok102IL3NJ6mZimtgiP7LKkizECXbGUzoB7KLtaYztzN3z7w2FQpdKrj2o02sgjAoMCPhtU+8nve/4+IKqJRSzh478cI20JD/kvffp3NJXpcD4IrNba+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DTK1w3FK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T182xM004391;
	Wed, 29 Jan 2025 07:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=NIDXbg18OyHP1gFKi5SUPDUnZ2WN
	oeOS0qgz/HD55Vk=; b=DTK1w3FKtRyhWQWGX3RFfDyLb6ak63NZsp1EUpSYZ5La
	+auUqFeMYQYzHm6VtzE0HsdPkt3tDkm5nYb8RRoBFqx77LVqI0yBOh8ZwDYiFqq0
	640Ku5GT0R3TLISEDqEZs4rRVNsP5LHTEU0f1OFtA3Jq3lRlpQRgysqd97Ut0tzP
	qj+UOkuwE+tSxR0rWB7f/f3PsZ/12QTx1FF+HbnsKFQVu0SyCawptqwSzeE8BENl
	I5Qq0eU4MoYP/6StFc2daU9IYX8gV+MWUHlQIIOwp4th+Ev1CxjDqmiHjJj9UXya
	+IP+QDcM+8qR3pz67hoMSPXKrhxzw4kM6gWxIL4nRw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fad9h77w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 07:25:36 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50T7Pasn032314;
	Wed, 29 Jan 2025 07:25:36 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fad9h77t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 07:25:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50T3eJ0C003929;
	Wed, 29 Jan 2025 07:25:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44da9sfn3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 07:25:35 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50T7PXdl28836382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 07:25:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61A7E20147;
	Wed, 29 Jan 2025 07:06:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B403720142;
	Wed, 29 Jan 2025 07:06:19 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.249])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Jan 2025 07:06:19 +0000 (GMT)
Date: Wed, 29 Jan 2025 12:36:17 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>, djwong@kernel.org,
        dchinner@redhat.com, hch@lst.de, ritesh.list@gmail.com, jack@suse.cz,
        tytso@mit.edu, linux-ext4@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] extsize and forcealign design in filesystems for
 atomic writes
Message-ID: <Z5nTaQgLGdD6hSvL@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gBDvXuIxcj5RtuTo3-b1whqsV7cso6al
X-Proofpoint-ORIG-GUID: pEIdI2Jweu3_2AWmB1jJv_qXQLHHZPmK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290056

Greetings,

I would like to submit a proposal to discuss the design of extsize and
forcealign and various open questions around it.

 ** Background **

Modern NVMe/SCSI disks with atomic write capabilities can allow writes to a
multi-KB range on disk to go atomically. This feature has a wide variety of use
cases especially for databases like mysql and postgres that can leverage atomic
writes to gain significant performance. However, in order to enable atomic
writes on Linux, the underlying disk may have some size and alignment
constraints that the upper layers like filesystems should follow. extsize with
forcealign is one of the ways filesystems can make sure the IO submitted to the
disk adheres to the atomic writes constraints.

extsize is a hint to the FS to allocate extents at a certian logical alignment
and size. forcealign builds on this by forcing the allocator to enforce the
alignment guarantees for physical blocks as well, which is essential for atomic
writes.

 ** Points of discussion **

Extsize hints feature is already supported by XFS [1] with forcealign still
under development and discussion [2]. After taking a look at ext4's multi-block
allocator design, supporting extsize with forcealign can be done in ext4 as
well. There is a RFC proposed which adds support for extsize hints feature in
ext4 [3]. However there are some caveats and deviations from XFS design. With
these in mind, I would like to propose LSFMM topic on:

 * exact semantics of extsize w/ forcealign which can bring a consistent
   interface among ext4 and xfs and possibly any other FS that plans to
   implement them in the future.

 * Documenting how forcealign with extsize should behave with various FS
   operations like fallocate, truncate, punch hole, insert/collapse range etc 

 * Implementing extsize with delayed allocation and the challenges there.

 * Discussing tooling support of forcealign like how are we planning to maintain
   block alignment gurantees during fsck, resize and other times where we might
   need to move blocks around?

 * Documenting any areas where FSes might differ in their implementations of the
   same. Example, ext4 doesn't plan to support non power of 2 extsizes whereas
   XFS has support for that.

Hopefully this discussion will be relevant in defining consistent semantics for
extsize hints and forcealign which might as well come useful for other FS
developers too.

Thoughts and suggestions are welcome.

References:
[1] https://man7.org/linux/man-pages/man2/ioctl_xfs_fsgetxattr.2.html
[2] https://lore.kernel.org/linux-xfs/20240813163638.3751939-1-john.g.garry@oracle.com/
[3] https://lore.kernel.org/linux-ext4/cover.1733901374.git.ojaswin@linux.ibm.com/

Regards,
ojaswin

