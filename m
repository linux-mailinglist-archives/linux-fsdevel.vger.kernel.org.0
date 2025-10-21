Return-Path: <linux-fsdevel+bounces-64848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C63BF5D17
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9D24821C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 10:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F970354AEB;
	Tue, 21 Oct 2025 10:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lqVTJzji"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2C332C95A
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043001; cv=none; b=B9K1/jPlElhZv84a8YqXSmUzfd32Ufjo2wNlWOT8NV2KGpLnaSjnelOFbxhNVCRHkDyJQUJv9u3D6PZKvo5rCzMGitaucqKHocy+53z6E1z68iHKZ5RMMS3wwW6WBd6+OWtCdDiSAW7pnXd+uXWjN/xWckM8pvsi7p1+SoNbzaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043001; c=relaxed/simple;
	bh=DNpYwAp+f4lJCVNX+9JaWzhgieBbwXspIdN+eczHcCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=tcOey4FIILEuY24Zxp2ggVGa1i2HjoQntoNVMW0s7xS5kXiyEpd8JfuaJPz37dGto53kjzHEMxu83GcsKH+rBShLwK1ficeleIGAq6TaXnYXS6gFd09HBTvq0j9jRc+vkTqwdtcpji91/6XCXKeo3+tLytlQirbC0bqwCfsT6tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lqVTJzji; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20251021103631epoutp0177be8e42176410e7f8d52cc801191200~we0Uz8Vqh1326013260epoutp01g
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 10:36:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20251021103631epoutp0177be8e42176410e7f8d52cc801191200~we0Uz8Vqh1326013260epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1761042991;
	bh=HsQCI8iew+pHyZGlqcgByv/CbFDTHT7k4bxRlb4DRbo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=lqVTJzjiViwLvtPEinPu/Xjuq/K9X0k8qNsAWIo0X0IBiUFYLsSClONg3/gM5D7eB
	 UvdqM5ywKtjfZfUzKdqaaOkEXaKVNl85+7TelDN5CE+TOP+mioideD3b04/1hfy+mg
	 KW7BTGGy19cfbK0DtBSrmoropHMgbDFIea4xhdDU=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20251021103630epcas5p435dae0ee9578598211e7066cedc621c2~we0TrEpWD0288102881epcas5p47;
	Tue, 21 Oct 2025 10:36:30 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.89]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4crTHK1zMHz6B9m7; Tue, 21 Oct
	2025 10:36:29 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20251021103628epcas5p1b7baecd88baf9cf66127e17613f268e4~we0RnAWVC2779827798epcas5p1e;
	Tue, 21 Oct 2025 10:36:28 +0000 (GMT)
Received: from [107.111.86.57] (unknown [107.111.86.57]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251021103622epsmtip11f8ba67056c7c576fea39dc357410495~we0M5IZcp2042120421epsmtip1P;
	Tue, 21 Oct 2025 10:36:22 +0000 (GMT)
Message-ID: <6fe26b74-beb9-4a6a-93af-86edcbde7b68@samsung.com>
Date: Tue, 21 Oct 2025 16:06:22 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] Parallelizing filesystem writeback
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com, amir73il@gmail.com,
	axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com, djwong@kernel.org,
	dave@stgolabs.net, wangyufei@vivo.com,
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, anuj20.g@samsung.com, vishak.g@samsung.com,
	joshi.k@samsung.com
From: Kundan Kumar <kundan.kumar@samsung.com>
In-Reply-To: <aPa7xozr7YbZX0W4@dread.disaster.area>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251021103628epcas5p1b7baecd88baf9cf66127e17613f268e4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251014120958epcas5p267c3c9f9dbe6ffc53c25755327de89f9
References: <CGME20251014120958epcas5p267c3c9f9dbe6ffc53c25755327de89f9@epcas5p2.samsung.com>
	<20251014120845.2361-1-kundan.kumar@samsung.com>
	<aPa7xozr7YbZX0W4@dread.disaster.area>

On 10/21/2025 4:16 AM, Dave Chinner wrote:

Thanks Dave for the detailed feedback.

> On Tue, Oct 14, 2025 at 05:38:29PM +0530, Kundan Kumar wrote:
>> Number of writeback contexts
>> ============================
>> We've implemented two interfaces to manage the number of writeback
>> contexts:
>> 1) Sysfs Interface: As suggested by Christoph, we've added a sysfs
>>     interface to allow users to adjust the number of writeback contexts
>>     dynamically.
>> 2) Filesystem Superblock Interface: We've also introduced a filesystem
>>     superblock interface to retrieve the filesystem-specific number of
>>     writeback contexts. For XFS, this count is set equal to the
>>     allocation group count. When mounting a filesystem, we automatically
>>     increase the number of writeback threads to match this count.
> 
> This is dangerous. What happens when we mount a filesystem with
> millions of AGs?
> 

Good point. How about adding an upper bound e.g. limiting the number
of writeback contexts to something like nr_cpus * k and mapping AGs
dynamically to that bounded pool.

> 
>> Resolving the Issue with Multiple Writebacks
>> ============================================
>> For XFS, affining inodes to writeback threads resulted in a decline
>> in IOPS for certain devices. The issue was caused by AG lock contention
>> in xfs_end_io, where multiple writeback threads competed for the same
>> AG lock.
>> To address this, we now affine writeback threads to the allocation
>> group, resolving the contention issue. In best case allocation happens
>> from the same AG where inode metadata resides, avoiding lock contention.
> 
> Not necessarily. The allocator can (and will) select different AGs
> for an inode as the file grows and the AGs run low on space. Once
> they select a different AG for an inode, they don't tend to return
> to the original AG because allocation targets are based on
> contiguous allocation w.r.t. existing adjacent extents, not the AG
> the inode is located in.
> 

The tests were conducted under ideal conditions, where the Allocation
Groups (AGs) had sufficient space. The design for affining writeback
threads to AGs is based on the assumption that allocations typically
occur within the same AG, unless it's low on space. To predict the AG
from which the allocation will happen, additional logic would be
required. This enhancement can be considered for a future phase, with
the get_inode_wb_ctx() function being the suitable location for
implementation.

> Indeed, if a user selects the inode32 mount option, there is
> absolutely no relationship between the AG the inode is located in
> and the AG it's data extents are allocated in. In these cases,
> using the inode resident AG is guaranteed to end up with a random
> mix of target AGs for the inodes queued in that AG.  Worse yet,
> there may only be one AG that can have inodes allocated in it, so
> all the writeback contexts for the other hundreds of AGs in the
> filesystem go completely unused...
> 
For inode32 mounts, does it make sense to restricting to single-threaded
writeback, or you have other thoughts for same ?

>> Similar IOPS decline was observed with other filesystems under different
>> workloads. To avoid similar issues, we have decided to limit
>> parallelism to XFS only. Other filesystems can introduce parallelism
>> and distribute inodes as per their geometry.
> 
> I suspect that the issues with XFS lock contention are related to
> the fragmentation behaviour observed (see below) massively
> increasing the frequency of allocation work for a given amount of
> data being written rather than increasing writeback concurrency...
> 
>>
>> IOPS and throughput
>> ===================
>> With the affinity to allocation group we see significant improvement in
>> XFS when we write to multiple files in different directories(AGs).
>>
>> Performance gains:
>>    A) Workload 12 files each of 1G in 12 directories(AGs) - numjobs = 12
>>      - NVMe device BM1743 SSD
> 
> So, 80-100k random 4kB write IOPS, ~2GB/s write bandwidth.
> 
>>          Base XFS                : 243 MiB/s
>>          Parallel Writeback XFS  : 759 MiB/s  (+212%)
> 
> As such, the baseline result doesn't feel right - it doesn't match
> my experience with concurrent sequential buffered write workloads on
> SSDs. My expectation is that they'd get close to device bandwidth or
> run out of copy-in CPU at somewhere over 3GB/s.
> 
> So what are you actually doing to get these numbers? What is the
> benchmark (CLI and conf files details, please!), what is the
> mkfs.xfs output, and how many CPUs/RAM do you have on the machines
> you are testing?  i.e. please document them sufficiently so that
> other people can verify your results.
> 

All tests were done with random writes. I am sharing complete test
script and config details.

mkfs output
===========
meta-data=/dev/nvme2n1           isize=512    agcount=128, 
agsize=117188604 blks
          =                       sectsz=4096  attr=2, projid32bit=1
          =                       crc=1        finobt=1, sparse=1, rmapbt=1
          =                       reflink=1    bigtime=1 inobtcount=1 
nrext64=1
          =                       exchange=0   metadir=0
data     =                       bsize=4096   blocks=15000141312, imaxpct=1
          =                       sunit=4      swidth=32 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1, parent=0
log      =internal log           bsize=4096   blocks=521728, version=2
          =                       sectsz=4096  sunit=1 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
          =                       rgcount=0    rgsize=0 extents
          =                       zoned=0      start=0 reserved=0

Script to issue the IO
======================
mkfs.xfs -f /dev/nvme2n1
mount /dev/nvme2n1 /mnt

sync
echo 3 > /proc/sys/vm/drop_caches

for i in {1..12}; do
         mkdir -p /mnt/dir$i
done

fio job_nvme.fio

umount /mnt
echo 3 > /proc/sys/vm/drop_caches
sync

File job_nvme.fio
=================
[global]
bs=4k
iodepth=32
rw=randwrite
ioengine=io_uring
nrfiles=12
numjobs=1                # Each job writes to a different file
size=12g
direct=0                 # Buffered I/O to trigger writeback
group_reporting=1
create_on_open=1
name=test

[job1]
directory=/mnt/dir1

[job2]
directory=/mnt/dir2

...
...

[job12]
directory=/mnt/dir12

Number of CPUs = 128
System RAM = 128G

> Also, what is the raw device performance and how close to that are
> we getting through the filesystem?
>

Raw IO performance BM1743 SSD
fio -iodepth=32 --rw=randwrite -direct=1 -ioengine=io_uring -bs=4K 
-numjobs=1 -size=100G -group_reporting -filename=/dev/nvme2n1 
-name=direct_test
write: IOPS=117k, BW=457MiB/s (479MB/s)(100GiB/224303msec)

Raw IO performance PM9A3 SSD
write: IOPS=546k, BW=2132MiB/s (2235MB/s)(100GiB/48036msec)

>>      - NVMe device PM9A3 SSD
> 
> 130-180k random 4kB write IOPS, ~4GB/s write bandwidth. So roughly
> double the physical throughput of the BM1743, and ....
> 
>>          Base XFS                : 368 MiB/s
>>          Parallel Writeback XFS  : 1634 MiB/s  (+344%)
> 
> .... it gets roughly double the physical throughput of the BM1743.
> 

BM1743 is a large IU device with a 16K IU size, which is not optimized
for my 4K IO operations, resulting in lower throughput. In contrast,
PM9A3 is a faster device that handles IO operations more efficiently.

> This doesn't feel like a writeback concurrency limited workload -
> this feels more like a device IOPS and IO depth limited workload.
> 
>>    B) Workload 6 files each of 20G in 6 directories(AGs)  - numjobs = 6
>>      - NVMe device BM1743 SSD
>>          Base XFS                : 305 MiB/s
>>          Parallel Writeback XFS  : 706 MiB/s  (+131%)
>>
>>      - NVMe device PM9A3 SSD
>>          Base XFS                : 315 MiB/s
>>          Parallel Writeback XFS  : 990 MiB/s  (+214%)
>>
>> Filesystem fragmentation
>> ========================
>> We also see that there is no increase in filesystem fragmentation
>> Number of extents per file:
> 
> Are these from running the workload on a freshly made (i.e. just run
> mkfs.xfs, mount and run benchmark) filesystem, or do you reuse the
> same fs for all tests?

I create a new file system for each test run.

> 
>>    A) Workload 6 files each 1G in single directory(AG)   - numjobs = 1
>>          Base XFS                : 17
>>          Parallel Writeback XFS  : 17
> 
> Yup, this implies a sequential write workload....
> 

This is random IO. As the workload is small the extents merge more.

>>    B) Workload 12 files each of 1G to 12 directories(AGs)- numjobs = 12
>>          Base XFS                : 166593
>>          Parallel Writeback XFS  : 161554
> 
> which implies 144 files, and so over 1000 extents per file. Which
> means about 1MB per extent and is way, way worse than it should be
> for sequential write workloads.
> 

Previous results of fragmentation were taken with randwrite. I took
fresh data for sequential IO and here are the results.
number of extents reduces a lot for seq IO:
   A) Workload 6 files each 1G in single directory(AG)   - numjobs = 1
         Base XFS                : 1
         Parallel Writeback XFS  : 1

   B) Workload 12 files each of 1G to 12 directories(AGs)- numjobs = 12
         Base XFS                : 4
         Parallel Writeback XFS  : 3

   C) Workload 6 files each of 20G to 6 directories(AGs) - numjobs = 6
         Base XFS                : 4
         Parallel Writeback XFS  : 4

>>
>>    C) Workload 6 files each of 20G to 6 directories(AGs) - numjobs = 6
>>          Base XFS                : 3173716
>>          Parallel Writeback XFS  : 3364984
> 
> 36 files, 720GB and 3.3m extents, which is about 100k extents per
> file for an average extent size of 200kB. That would explain why it
> performed roughly the same on both devices - they both have similar
> random 128kB write IO performance...
> 
> But that fragmentation pattern is bad and shouldn't be occurring fro
> sequential writes. Speculative EOF preallocation should be almost
> entirely preventing this sort of fragmentation for concurrent
> sequential write IO and so we should be seeing extent sizes of at
> least hundreds of MBs for these file sizes.
> 
> i.e. this feels to me like you test is triggering some underlying
> delayed allocation defeat mechanism that is causing physical
> writeback IO sizes to collapse. This turns what should be a
> bandwitdh limited workload running at full device bandwidth into an
> IOPS and IO depth limited workload.
> 
> In adding writeback concurrency to this situation, it enables
> writeback to drive deeper IO queues and so extract more small IO
> performance from the device, thereby showing better performance for
> the wrokload. The issue is that baseline writeback performance is
> way below where I think it should be for the given IO workload (IIUC
> the workload being run, hence questions about benchmarks, filesystem
> configs and test hardware).
> 

I have tried to share config, benchmarking script and data,
if you feel some details are missing please let me know.

> Hence while I certainly agree that writeback concurrency is
> definitely needed, I think that the results you are getting here are
> a result of some other issue that writeback concurrency is
> mitigating. The underlying fragmentation issue needs to be
> understood (and probably solved) before we can draw any conclusions
> about the performance gains that concurrent writeback actually
> provides on these workloads and devices...
> 

In these tests we've observed that fragmentation remains consistent 
across sequential and random IO workloads. Your feedback on this would 
be valuable.


