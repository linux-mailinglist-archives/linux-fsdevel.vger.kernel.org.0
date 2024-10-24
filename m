Return-Path: <linux-fsdevel+bounces-32693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B898A9ADC3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 08:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDE01C21489
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 06:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F093318991B;
	Thu, 24 Oct 2024 06:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jq3+AdkO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1982FC52;
	Thu, 24 Oct 2024 06:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729751592; cv=none; b=D6CJbV/PIl7qHJzx0DO2Xul0pEALZq725SxbkahqtaVgC/g6zEzE7vxUIML8ihfRw0VVCmHdzmHnKL8oyRFPMRaXMNGWB822eYjVsgpfdPfNH447nS34TtqEcmGMXW6L9uLAD3p3EPEFoWPFC/NWJIfTSVvQhXCBZPKLtGsrSVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729751592; c=relaxed/simple;
	bh=g5BKeBl1fYSpE6hgYA/MuWtq4GXll+inrgRs8ExCMFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h4znzd0rhNICc98p1W+NsTa2NnJpjnU1QzFVMXwa4tyZ8bkV7/84zfuxMC23xhq2676oh5qVUP+Z9RoJrfh+JJQXrINthooayJ6dTg4k8epZIn34hKjbrPaNEQEHQ36Zh4tMqnR9pxQbvXtYITGYdXKvhpF6eU1QmFdn5iUfmIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jq3+AdkO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49O6R317002214;
	Thu, 24 Oct 2024 06:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=482XagPPVCklbTt8RqSP9WJZbqS86S
	SpwoPOKwUlyPQ=; b=Jq3+AdkOyDx+0Wt2VbNzYC3FYBO4eOUCXRVDhf/3qexyN3
	LxHwjRDepPCTfmkwAXzGhz3Uh1jsAVqW8YsSbNr3BQ1/8NmkVSOWA6zABqPaYFsp
	CXVV5lI2lr3TVnDl7X8UzUqDRJnnyVDc4UUmlgILzhuaDe3hYCUPyLRxbf67gGKr
	X1jE7aK38wK7sy2sSGoyqtPY1d3e27zEn54iLm+gTGkDkiHulbGrlRzwB39Z9LF5
	CWZqqT9Fv2HduU/wk0lt3hiZrJz6CndgDDeM/Dkg5wM3e3Ce9ZEUOAPB/QPtOLum
	JiRN8ifVdrKz3nXCe/2xDtpEqXL5rYVKXJk7pxsg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42fgyur0km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 06:32:51 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49O6Wpsw013344;
	Thu, 24 Oct 2024 06:32:51 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42fgyur0kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 06:32:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49O2eTV6014576;
	Thu, 24 Oct 2024 06:32:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emk7xxpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 06:32:49 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49O6Wlt746399800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 06:32:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3967220075;
	Thu, 24 Oct 2024 06:32:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB68E2009D;
	Thu, 24 Oct 2024 06:32:19 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.39.28.236])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 24 Oct 2024 06:32:19 +0000 (GMT)
Date: Thu, 24 Oct 2024 12:02:17 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com
Subject: Re: [PATCH v10 0/8] block atomic writes for xfs
Message-ID: <Zxnp8bma2KrMDg5m@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20241019125113.369994-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019125113.369994-1-john.g.garry@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -C_Y495T55YdD6ljY8lFeT07BDz5t8m8
X-Proofpoint-GUID: nrqya7HiUTaRC1copajZRVkNdhnRb4MA
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410240047

On Sat, Oct 19, 2024 at 12:51:05PM +0000, John Garry wrote:
> This series expands atomic write support to filesystems, specifically
> XFS.
> 
> Initially we will only support writing exactly 1x FS block atomically.
> 
> Since we can now have FS block size > PAGE_SIZE for XFS, we can write
> atomically 4K+ blocks on x86.
> 
> No special per-inode flag is required for enabling writing 1x F block.
> In future, to support writing more than one FS block atomically, a new FS
> XFLAG flag may then introduced - like FS_XFLAG_BIG_ATOMICWRITES. This
> would depend on a feature like forcealign.
> 
> So if we format the FS for 16K FS block size:
> mkfs.xfs -b size=16384 /dev/sda
> 
> The statx reports atomic write unit min/max = FS block size:
> $xfs_io -c statx filename
> ...
> stat.stx_atomic_write_unit_min = 16384
> stat.stx_atomic_write_unit_max = 16384
> stat.stx_atomic_write_segments_max = 1
> ...
> 
> Baseline is 77bfe1b11ea0 (tag: xfs-6.12-fixes-3, xfs/xfs-6.12-fixesC,
> xfs/for-next) xfs: fix a typo
> 
> Patches for this series can be found at:
> https://github.com/johnpgarry/linux/tree/atomic-writes-v6.12-fs-v10
> 
> Changes since v9:
> - iomap doc fix (Darrick)
> - Add RB tags from Christoph and Darrick (Thanks!)
> 
> Changes since v8:
> - Add bdev atomic write unit helpers (Christoph)
> - Add comment on FS block size limit (Christoph)
> - Stylistic improvements (Christoph)
> - Add RB tags from Christoph (thanks!)
> 
> Changes since v7:
> - Drop FS_XFLAG_ATOMICWRITES
> - Reorder block/fs patches and add fixes tags (Christoph)
> - Add RB tag from Christoph (Thanks!)
> - Rebase
> 
> John Garry (8):
>   block/fs: Pass an iocb to generic_atomic_write_valid()
>   fs/block: Check for IOCB_DIRECT in generic_atomic_write_valid()
>   block: Add bdev atomic write limits helpers
>   fs: Export generic_atomic_write_valid()
>   fs: iomap: Atomic write support
>   xfs: Support atomic write for statx
>   xfs: Validate atomic writes
>   xfs: Support setting FMODE_CAN_ATOMIC_WRITE
> 
>  .../filesystems/iomap/operations.rst          | 12 ++++++
>  block/fops.c                                  | 22 ++++++-----
>  fs/iomap/direct-io.c                          | 38 +++++++++++++++++--
>  fs/iomap/trace.h                              |  3 +-
>  fs/read_write.c                               | 16 +++++---
>  fs/xfs/xfs_buf.c                              |  7 ++++
>  fs/xfs/xfs_buf.h                              |  4 ++
>  fs/xfs/xfs_file.c                             | 16 ++++++++
>  fs/xfs/xfs_inode.h                            | 15 ++++++++
>  fs/xfs/xfs_iops.c                             | 22 +++++++++++
>  include/linux/blkdev.h                        | 16 ++++++++
>  include/linux/fs.h                            |  2 +-
>  include/linux/iomap.h                         |  1 +
>  13 files changed, 152 insertions(+), 22 deletions(-)
> 
> -- 

Hi John,

I've tested the whole patchset on powerpc (64k pagesize) with 4k, 16k
and 64k blocksizes and it passes the tests. My tests basically check
following scenarios:

Statx behavior:
#   1.1 bs > unit_max
#   1.2 bs < unit_max
#   1.3 bs == unit_max
#   1.4 dev deosn't support

pwrite tests:
#   3.1 len < fsmin
#   3.2 len > fsmax
#   3.3 write not naturally aligned
#   3.4 Atomic write abiding to all rule

For the whole patchset, feel free to add:

Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com> 	 #On ppc64

Thanks,
Ojaswin

> 2.31.1
> 

