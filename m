Return-Path: <linux-fsdevel+bounces-49250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D660AB9B85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 13:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F2B4A3A37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 11:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE26238C2D;
	Fri, 16 May 2025 11:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="luRskR5+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63B823717C;
	Fri, 16 May 2025 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747396464; cv=none; b=LTdoEYB/ldCbLuvdX7eBCtNgbEca/u7/GndxUGgroeaHbbptqBDHYpM5/4WNWjtBbSinzwfaJL7QkHQaSwpsn55F2axyQkdTkviVTYKDlJ/PMHFjyG3CpitVfVc1ZWrnlidqvcwtWiDd4idkl6aq0afcaOhish9DwrNes+eCDK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747396464; c=relaxed/simple;
	bh=VQ6+IzUXPtSXJ7MvaMeMG/hgwkLwoOJ9f3tsS37r89U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0qKZcZhlLaKFtXpkHajDpxPaoedYrlmNz0GAGGxBTuzKmDTYgb8XS8WyzxIBkWtChlQMOivV9JWDV1BwPMQhC8kOvvb7hnUyHsTgJgrgvow1ZbTd68ipiK/SRnT/+ZQnsL7PNnuBdxKi2ibOEb7sqg8mnZ8vH61Z61Dykku4c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=luRskR5+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G8pTYa006932;
	Fri, 16 May 2025 11:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=FTermYtXh6EcmiiT9maNkBo3w1aFhP
	gkjeQZH6rWQzk=; b=luRskR5+AcnPsdR5dzIn4/xvqa0hu9eRgAK1J5P8N/2jR7
	4RAWH69+k5jddXbQDz9A7QqzFQ8Vb+8w13yofI8xQknsMnWBfXerk/4C0AD69zuF
	YHVG47P+pIbbbZlMsz+e2t48id/fTz2UHfCCtH0SZCgbK/yJO2CUssobFfJhLEAj
	c027P+WiB31XxqGEX/x+PlIZjoZQE63ervmi98tyIc78OYk4NWOb4bBpayeevei0
	FOytAyDo6MpHC5NP6xTMxI/p3l+l7SzWY5cU0NEKsoTZRynOjxH3ju6fxqkkmOF6
	5TiyCSZSK/etInjANs89qqw39tycPUM8sGsyxRZA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46p27hgrjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 11:48:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54GAElME015353;
	Fri, 16 May 2025 11:48:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfq79w0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 11:48:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54GBmoOE49414400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 11:48:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 487852004E;
	Fri, 16 May 2025 11:48:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6360F20040;
	Fri, 16 May 2025 11:48:47 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.217.123])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 16 May 2025 11:48:47 +0000 (GMT)
Date: Fri, 16 May 2025 17:18:43 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 0/8] ext4: enable large folio for regular files
Message-ID: <aCcmGyse9prx-D7S@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: G5VUGTmVbjHV1S4TsDbBZktW7GKGPK3U
X-Authority-Analysis: v=2.4 cv=e+wGSbp/ c=1 sm=1 tr=0 ts=68272625 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=AiHppB-aAAAA:8 a=i0EeH86SAAAA:8 a=KEs3vZIQV0YlmfogclgA:9
 a=CjuIK1q_8ugA:10 a=l2o5i1_H8WVCs5eH1y1M:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDExMSBTYWx0ZWRfXxUdKcXFFQEiZ A1Mp/Dl/NJEZjgs75Qel51k+29GlkB1g/one0Bjt+Uu3eB8aSSC6gY26eMLOQbxH/ntbgMqtSyB U+VkD7DgHAHYS/2kSHU4yGyDpqyjVWH8d9t7g/x40xXsvD8Vlk+VMjGYcqXEEMPQ8gywOhVQOAp
 Wtk8LJlRPVlA/wutGDs5ve9+B3ySHD1I37LvZne5YoA7+HexYSkj0yrJux7rjLrA1TxmSExjodM /5WwUVQkQra75KYsEOFqeUEd/+qDffthWmDKJWrAJ8D6J85HvVoo/VMJAJVY4kAVWUo7diFIIBF qxTIU7ckjetCLEF55C+XwCHUmIr4mfQ2V77P5JiGKxDmYc/eDxmbaxM7tuNEW5KlXOFZJbhBiiT
 0ZDEEVG1kexWykdqhLMzp+6ZZlLHDCei0rApQbDhKncISiqKkGjTDkvG5I/M+Lp+Fg73hJ6b
X-Proofpoint-ORIG-GUID: G5VUGTmVbjHV1S4TsDbBZktW7GKGPK3U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_05,2025-05-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 impostorscore=0
 clxscore=1011 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160111

On Mon, May 12, 2025 at 02:33:11PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Changes since v1:
>  - Rebase codes on 6.15-rc6.
>  - Drop the modifications in block_read_full_folio() which has supported
>    by commit b72e591f74de ("fs/buffer: remove batching from async
>    read").
>  - Fine-tuning patch 6 without modifying the logic.
> 
> v1: https://lore.kernel.org/linux-ext4/20241125114419.903270-1-yi.zhang@huaweicloud.com/
> 
> Original Description:
> 
> Since almost all of the code paths in ext4 have already been converted
> to use folios, there isn't much additional work required to support
> large folios. This series completes the remaining work and enables large
> folios for regular files on ext4, with the exception of fsverity,
> fscrypt, and data=journal mode.
> 
> Unlike my other series[1], which enables large folios by converting the
> buffered I/O path from the classic buffer_head to iomap, this solution
> is based on the original buffer_head, it primarily modifies the block
> offset and length calculations within a single folio in the buffer
> write, buffer read, zero range, writeback, and move extents paths to
> support large folios, doesn't do further code refactoring and
> optimization.
> 
> This series have passed kvm-xfstests in auto mode several times, every
> thing looks fine, any comments are welcome.
> 
> About performance:
> 
> I used the same test script from my iomap series (need to drop the mount
> opts parameter MOUNT_OPT) [2], run fio tests on the same machine with
> Intel Xeon Gold 6240 CPU with 400GB system ram, 200GB ramdisk and 4TB
> nvme ssd disk. Both compared with the base and the IOMAP + large folio
> changes.
> 
>  == buffer read ==
> 
>                 base          iomap+large folio base+large folio
>  type     bs    IOPS  BW(M/s) IOPS  BW(M/s)     IOPS   BW(M/s)
>  ----------------------------------------------------------------
>  hole     4K  | 576k  2253  | 762k  2975(+32%) | 747k  2918(+29%)
>  hole     64K | 48.7k 3043  | 77.8k 4860(+60%) | 76.3k 4767(+57%)
>  hole     1M  | 2960  2960  | 4942  4942(+67%) | 4737  4738(+60%)
>  ramdisk  4K  | 443k  1732  | 530k  2069(+19%) | 494k  1930(+11%)
>  ramdisk  64K | 34.5k 2156  | 45.6k 2850(+32%) | 41.3k 2584(+20%)
>  ramdisk  1M  | 2093  2093  | 2841  2841(+36%) | 2585  2586(+24%)
>  nvme     4K  | 339k  1323  | 364k  1425(+8%)  | 344k  1341(+1%)
>  nvme     64K | 23.6k 1471  | 25.2k 1574(+7%)  | 25.4k 1586(+8%)
>  nvme     1M  | 2012  2012  | 2153  2153(+7%)  | 2122  2122(+5%)
> 
> 
>  == buffer write ==
> 
>  O: Overwrite; S: Sync; W: Writeback
> 
>                      base         iomap+large folio    base+large folio
>  type    O S W bs    IOPS  BW     IOPS  BW(M/s)        IOPS  BW(M/s)
>  ----------------------------------------------------------------------
>  cache   N N N 4K  | 417k  1631 | 440k  1719 (+5%)   | 423k  1655 (+2%)
>  cache   N N N 64K | 33.4k 2088 | 81.5k 5092 (+144%) | 59.1k 3690 (+77%)
>  cache   N N N 1M  | 2143  2143 | 5716  5716 (+167%) | 3901  3901 (+82%)
>  cache   Y N N 4K  | 449k  1755 | 469k  1834 (+5%)   | 452k  1767 (+1%)
>  cache   Y N N 64K | 36.6k 2290 | 82.3k 5142 (+125%) | 67.2k 4200 (+83%)
>  cache   Y N N 1M  | 2352  2352 | 5577  5577 (+137%  | 4275  4276 (+82%)
>  ramdisk N N Y 4K  | 365k  1424 | 354k  1384 (-3%)   | 372k  1449 (+2%)
>  ramdisk N N Y 64K | 31.2k 1950 | 74.2k 4640 (+138%) | 56.4k 3528 (+81%)
>  ramdisk N N Y 1M  | 1968  1968 | 5201  5201 (+164%) | 3814  3814 (+94%)
>  ramdisk N Y N 4K  | 9984  39   | 12.9k 51   (+29%)  | 9871  39   (-1%)
>  ramdisk N Y N 64K | 5936  371  | 8960  560  (+51%)  | 6320  395  (+6%)
>  ramdisk N Y N 1M  | 1050  1050 | 1835  1835 (+75%)  | 1656  1657 (+58%)
>  ramdisk Y N Y 4K  | 411k  1609 | 443k  1731 (+8%)   | 441k  1723 (+7%)
>  ramdisk Y N Y 64K | 34.1k 2134 | 77.5k 4844 (+127%) | 66.4k 4151 (+95%)
>  ramdisk Y N Y 1M  | 2248  2248 | 5372  5372 (+139%) | 4209  4210 (+87%)
>  ramdisk Y Y N 4K  | 182k  711  | 186k  730  (+3%)   | 182k  711  (0%)
>  ramdisk Y Y N 64K | 18.7k 1170 | 34.7k 2171 (+86%)  | 31.5k 1969 (+68%)
>  ramdisk Y Y N 1M  | 1229  1229 | 2269  2269 (+85%)  | 1943  1944 (+58%)
>  nvme    N N Y 4K  | 373k  1458 | 387k  1512 (+4%)   | 399k  1559 (+7%)
>  nvme    N N Y 64K | 29.2k 1827 | 70.9k 4431 (+143%) | 54.3k 3390 (+86%)
>  nvme    N N Y 1M  | 1835  1835 | 4919  4919 (+168%) | 3658  3658 (+99%)
>  nvme    N Y N 4K  | 11.7k 46   | 11.7k 46   (0%)    | 11.5k 45   (-1%)
>  nvme    N Y N 64K | 6453  403  | 8661  541  (+34%)  | 7520  470  (+17%)
>  nvme    N Y N 1M  | 649   649  | 1351  1351 (+108%) | 885   886  (+37%)
>  nvme    Y N Y 4K  | 372k  1456 | 433k  1693 (+16%)  | 419k  1637 (+12%)
>  nvme    Y N Y 64K | 33.0k 2064 | 74.7k 4669 (+126%) | 64.1k 4010 (+94%)
>  nvme    Y N Y 1M  | 2131  2131 | 5273  5273 (+147%) | 4259  4260 (+100%)
>  nvme    Y Y N 4K  | 56.7k 222  | 56.4k 220  (-1%)   | 59.4k 232  (+5%)
>  nvme    Y Y N 64K | 13.4k 840  | 19.4k 1214 (+45%)  | 18.5k 1156 (+38%)
>  nvme    Y Y N 1M  | 714   714  | 1504  1504 (+111%) | 1319  1320 (+85%)
> 
> [1] https://lore.kernel.org/linux-ext4/20241022111059.2566137-1-yi.zhang@huaweicloud.com/
> [2] https://lore.kernel.org/linux-ext4/3c01efe6-007a-4422-ad79-0bad3af281b1@huaweicloud.com/
> 
> Thanks,
> Yi.
> 
> Zhang Yi (8):
>   ext4: make ext4_mpage_readpages() support large folios
>   ext4: make regular file's buffered write path support large folios
>   ext4: make __ext4_block_zero_page_range() support large folio
>   ext4/jbd2: convert jbd2_journal_blocks_per_page() to support large
>     folio
>   ext4: correct the journal credits calculations of allocating blocks
>   ext4: make the writeback path support large folios
>   ext4: make online defragmentation support large folios
>   ext4: enable large folio for regular file
> 
>  fs/ext4/ext4.h        |  1 +
>  fs/ext4/ext4_jbd2.c   |  3 +-
>  fs/ext4/ext4_jbd2.h   |  4 +--
>  fs/ext4/extents.c     |  5 +--
>  fs/ext4/ialloc.c      |  3 ++
>  fs/ext4/inode.c       | 72 ++++++++++++++++++++++++++++++-------------
>  fs/ext4/move_extent.c | 11 +++----
>  fs/ext4/readpage.c    | 28 ++++++++++-------
>  fs/jbd2/journal.c     |  7 +++--
>  include/linux/jbd2.h  |  2 +-
>  10 files changed, 88 insertions(+), 48 deletions(-)
> 
> -- 
> 2.46.1

Hi Zhang,

I'm currently testing the patches with 4k block size and 64k pagesize on
power and noticed that ext4/046 is hitting a bug on:

[  188.351668][ T1320] NIP [c0000000006f15a4] block_read_full_folio+0x444/0x450
[  188.351782][ T1320] LR [c0000000006f15a0] block_read_full_folio+0x440/0x450
[  188.351868][ T1320] --- interrupt: 700
[  188.351919][ T1320] [c0000000058176e0] [c0000000007d7564] ext4_mpage_readpages+0x204/0x910
[  188.352027][ T1320] [c0000000058177e0] [c0000000007a55d4] ext4_readahead+0x44/0x60
[  188.352119][ T1320] [c000000005817800] [c00000000052bd80] read_pages+0xa0/0x3d0
[  188.352216][ T1320] [c0000000058178a0] [c00000000052cb84] page_cache_ra_order+0x2c4/0x560
[  188.352312][ T1320] [c000000005817990] [c000000000514614] filemap_readahead.isra.0+0x74/0xe0
[  188.352427][ T1320] [c000000005817a00] [c000000000519fe8] filemap_get_pages+0x548/0x9d0
[  188.352529][ T1320] [c000000005817af0] [c00000000051a59c] filemap_read+0x12c/0x520
[  188.352624][ T1320] [c000000005817cc0] [c000000000793ae8] ext4_file_read_iter+0x78/0x320
[  188.352724][ T1320] [c000000005817d10] [c000000000673e54] vfs_read+0x314/0x3d0
[  188.352813][ T1320] [c000000005817dc0] [c000000000674ad8] ksys_read+0x88/0x150
[  188.352905][ T1320] [c000000005817e10] [c00000000002fff4] system_call_exception+0x114/0x300
[  188.353019][ T1320] [c000000005817e50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec

which is:

int block_read_full_folio(struct folio *folio, get_block_t *get_block)
{
	...
	/* This is needed for ext4. */
	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
		limit = inode->i_sb->s_maxbytes;

	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);    <-------------

	head = folio_create_buffers(folio, inode, 0);
	blocksize = head->b_size;

This seems like it got mistakenly left out. Wihtout this line I'm not
hitting the BUG, however it's strange that none the x86 testing caught
this. I can only replicate this on 4k blocksize on 64k page size power
pc architecture. I'll spend some time to understand why it is not
getting hit on x86 with 1k bs. (maybe ext4_mpage_readpages() is not
falling to block_read_full_folio that easily.)

I'll continue testing with the line removed.

Thanks,
Ojaswin


