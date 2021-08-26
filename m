Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624683F8C72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 18:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243039AbhHZQuo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 12:50:44 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:49153 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232711AbhHZQuj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 12:50:39 -0400
Received: from [192.168.0.175] (ip5f5aecf9.dynamic.kabel-deutschland.de [95.90.236.249])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7EA6661E30B9F;
        Thu, 26 Aug 2021 18:49:48 +0200 (CEST)
Subject: Re: Minimum inode cache size? (was: Slow file operations on file
 server with 30 TB hardware RAID and 100 TB software RAID)
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     it+linux-xfs@molgen.mpg.de, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
References: <dcc07afa-08c3-d2d3-7900-75adb290a1bc@molgen.mpg.de>
 <3e380495-5f85-3226-f0cf-4452e2b77ccb@molgen.mpg.de>
 <58e701f4-6af1-d47a-7b3e-5cadf9e27296@molgen.mpg.de>
From:   Donald Buczek <buczek@molgen.mpg.de>
Message-ID: <878157e2-b065-aaee-f26b-5c87e9ddc2d6@molgen.mpg.de>
Date:   Thu, 26 Aug 2021 18:49:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <58e701f4-6af1-d47a-7b3e-5cadf9e27296@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26.08.21 12:41, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Am 20.08.21 um 16:39 schrieb Paul Menzel:
> 
>> Am 20.08.21 um 16:31 schrieb Paul Menzel:
>>
>>> Short problem statement: Sometimes changing into a directory on a file server wit 30 TB hardware RAID and 100 TB software RAID both formatted with XFS takes several seconds.
>>>
>>>
>>> On a Dell PowerEdge T630 with two Xeon CPU E5-2603 v4 @ 1.70GHz and 96 GB RAM a 30 TB hardware RAID is served by the hardware RAID controller and a 100 TB MDRAID software RAID connected to a Microchip 1100-8e both formatted using XFS. Currently, Linux 5.4.39 runs on it.
>>>
>>> ```
>>> $ more /proc/version
>>> Linux version 5.4.39.mx64.334 (root@lol.molgen.mpg.de) (gcc version 7.5.0 (GCC)) #1 SMP Thu May 7 14:27:50 CEST 2020
>>> $ dmesg | grep megar
>>> [   10.322823] megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 00:01:03 EST 2006)
>>> [   10.331910] megaraid: 2.20.5.1 (Release Date: Thu Nov 16 15:32:35 EST 2006)
>>> [   10.345055] megaraid_sas 0000:03:00.0: BAR:0x1  BAR's base_addr(phys):0x0000000092100000  mapped virt_addr:0x0000000059ea5995
>>> [   10.345057] megaraid_sas 0000:03:00.0: FW now in Ready state
>>> [   10.351868] megaraid_sas 0000:03:00.0: 63 bit DMA mask and 32 bit consistent mask
>>> [   10.361655] megaraid_sas 0000:03:00.0: firmware supports msix    : (96)
>>> [   10.369433] megaraid_sas 0000:03:00.0: requested/available msix 13/13
>>> [   10.377113] megaraid_sas 0000:03:00.0: current msix/online cpus    : (13/12)
>>> [   10.385190] megaraid_sas 0000:03:00.0: RDPQ mode    : (disabled)
>>> [   10.392092] megaraid_sas 0000:03:00.0: Current firmware supports maximum commands: 928     LDIO threshold: 0
>>> [   10.403895] megaraid_sas 0000:03:00.0: Configured max firmware commands: 927
>>> [   10.416840] megaraid_sas 0000:03:00.0: Performance mode :Latency
>>> [   10.424029] megaraid_sas 0000:03:00.0: FW supports sync cache    : No
>>> [   10.431417] megaraid_sas 0000:03:00.0: megasas_disable_intr_fusion is called outbound_intr_mask:0x40000009
>>> [   10.486158] megaraid_sas 0000:03:00.0: FW provided supportMaxExtLDs: 1    max_lds: 64
>>> [   10.495502] megaraid_sas 0000:03:00.0: controller type    : MR(2048MB)
>>> [   10.502988] megaraid_sas 0000:03:00.0: Online Controller Reset(OCR)    : Enabled
>>> [   10.511445] megaraid_sas 0000:03:00.0: Secure JBOD support    : No
>>> [   10.518543] megaraid_sas 0000:03:00.0: NVMe passthru support    : No
>>> [   10.525834] megaraid_sas 0000:03:00.0: FW provided TM TaskAbort/Reset timeout: 0 secs/0 secs
>>> [   10.536251] megaraid_sas 0000:03:00.0: JBOD sequence map support    : No
>>> [   10.543931] megaraid_sas 0000:03:00.0: PCI Lane Margining support    : No
>>> [   10.574406] megaraid_sas 0000:03:00.0: megasas_enable_intr_fusion is called outbound_intr_mask:0x40000000
>>> [   10.585995] megaraid_sas 0000:03:00.0: INIT adapter done
>>> [   10.592409] megaraid_sas 0000:03:00.0: JBOD sequence map is disabled megasas_setup_jbod_map 5660
>>> [   10.603273] megaraid_sas 0000:03:00.0: pci id        : (0x1000)/(0x005d)/(0x1028)/(0x1f42)
>>> [   10.612815] megaraid_sas 0000:03:00.0: unevenspan support    : yes
>>> [   10.619919] megaraid_sas 0000:03:00.0: firmware crash dump    : no
>>> [   10.627013] megaraid_sas 0000:03:00.0: JBOD sequence map    : disabled
>>> $ dmesg | grep 1100-8e
>>> [   25.853170] smartpqi 0000:84:00.0: added 11:2:0:0 0000000000000000 RAID              Adaptec  1100-8e
>>> [   25.867069] scsi 11:2:0:0: RAID              Adaptec  1100-8e  2.93 PQ: 0 ANSI: 5
>>> $ xfs_info /dev/sdc
>>> meta-data=/dev/sdc               isize=512    agcount=28, agsize=268435455 blks
>>>           =                       sectsz=512   attr=2, projid32bit=1
>>>           =                       crc=1        finobt=1, sparse=0, rmapbt=0
>>>           =                       reflink=0
>>> data     =                       bsize=4096   blocks=7323648000, imaxpct=5
>>>           =                       sunit=0      swidth=0 blks
>>> naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
>>> log      =internal log           bsize=4096   blocks=521728, version=2
>>>           =                       sectsz=512   sunit=0 blks, lazy-count=1
>>> realtime =none                   extsz=4096   blocks=0, rtextents=0
>>> $ xfs_info /dev/md0
>>> meta-data=/dev/md0               isize=512    agcount=102, agsize=268435328 blks
>>>           =                       sectsz=4096  attr=2, projid32bit=1
>>>           =                       crc=1        finobt=1, sparse=0, rmapbt=0
>>>           =                       reflink=0
>>> data     =                       bsize=4096   blocks=27348633088, imaxpct=1
>>>           =                       sunit=128    swidth=1792 blks
>>> naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
>>> log      =internal log           bsize=4096   blocks=521728, version=2
>>>           =                       sectsz=4096  sunit=1 blks, lazy-count=1
>>> realtime =none                   extsz=4096   blocks=0, rtextents=0
>>> $ df -i /dev/sdc
>>> Filesystem         Inodes   IUsed      IFree IUse% Mounted on
>>> /dev/sdc       2929459200 4985849 2924473351    1% /home/pmenzel
>>> $ df -i /dev/md0
>>> Filesystem         Inodes   IUsed      IFree IUse% Mounted on
>>> /dev/md0       2187890624 5331603 2182559021    1% /jbod/M8015
>>> ```
>>>
>>> After not using a directory for a while (over 24 hours), changing into it (locally) takes over five seconds or doing some git operations. For example the Linux kernel source git tree located in my home directory. (My shell has some git integration showing the branch name in the prompt (`/usr/share/git-contrib/completion/git-prompt.sh`.) Once in that directory, everything reacts instantly again. When waiting the Linux pressure stall information (PSI) shows IO resource contention.
>>>
>>> Before:
>>>
>>>      $ grep -R . /proc/pressure/
>>>      /proc/pressure/io:some avg10=0.40 avg60=0.10 avg300=0.10 total=48330841502
>>>      /proc/pressure/io:full avg10=0.40 avg60=0.10 avg300=0.10 total=48067233340
>>>      /proc/pressure/cpu:some avg10=0.00 avg60=0.00 avg300=0.00 total=755842910
>>>      /proc/pressure/memory:some avg10=0.00 avg60=0.00 avg300=0.00 total=2530206336
>>>      /proc/pressure/memory:full avg10=0.00 avg60=0.00 avg300=0.00 total=2318140732
>>>
>>> During `git log stable/linux-5.10.y`:
>>>
>>>      $ grep -R . /proc/pressure/
>>>      /proc/pressure/io:some avg10=26.20 avg60=9.72 avg300=2.37 total=48337351849
>>>      /proc/pressure/io:full avg10=26.20 avg60=9.72 avg300=2.37 total=48073742033
>>>      /proc/pressure/cpu:some avg10=0.00 avg60=0.00 avg300=0.00 total=755843898
>>>      /proc/pressure/memory:some avg10=0.00 avg60=0.00 avg300=0.00 total=2530209046
>>>      /proc/pressure/memory:full avg10=0.00 avg60=0.00 avg300=0.00 total=2318143440
>>>
>>> The current explanation is, that over night several maintenance scripts like backup/mirroring and accounting scripts are run, which touch all files on the devices. Additionally sometimes other users run cluster jobs with millions of files on the software RAID. Such things invalidate the inode cache, and “my” are thrown out. When I use it afterward it’s slow in the beginning. There is still free memory during these times according to `top`.
>>
>>      $ free -h
>>                    total        used        free      shared  buff/cache available
>>      Mem:            94G        8.3G        5.3G        2.3M         80G       83G
>>      Swap:            0B          0B          0B
>>
>>> Does that sound reasonable with ten million inodes? Is that easily verifiable?
>>
>> If an inode consume 512 bytes with ten million inodes, that would be around 500 MB, which should easily fit into the cache, so it does not need to be invalidated?
> 
> Something is wrong with that calculation, and the cache size is much bigger.
> 
> Looking into `/proc/slabinfo` and XFS’ runtime/internal statistics [1], it turns out that the inode cache is likely the problem.
> 
> XFS’ internal stats show that only one third of the inodes requests are answered from cache.
> 
>      $ grep ^ig /sys/fs/xfs/stats/stats
>      ig 1791207386 647353522 20111 1143854223 394 1142080045 10683174
> 
> During the problematic time, the SLAB size is around 4 GB and, according to slabinfo, the inode cache only has around 200.000 (sometimes even as low as 50.000).
> 
>      $ sudo grep inode /proc/slabinfo
>      nfs_inode_cache       16     24   1064    3    1 : tunables   24 12    8 : slabdata      8      8      0
>      rpc_inode_cache       94    138    640    6    1 : tunables   54 27    8 : slabdata     23     23      0
>      mqueue_inode_cache      1      4    896    4    1 : tunables   54  27    8 : slabdata      1      1      0
>      xfs_inode         1693683 1722284    960    4    1 : tunables   54   27    8 : slabdata 430571 430571      0
>      ext2_inode_cache       0      0    768    5    1 : tunables   54 27    8 : slabdata      0      0      0
>      reiser_inode_cache      0      0    760    5    1 : tunables   54  27    8 : slabdata      0      0      0
>      hugetlbfs_inode_cache      2     12    608    6    1 : tunables 54   27    8 : slabdata      2      2      0
>      sock_inode_cache     346    670    768    5    1 : tunables   54 27    8 : slabdata    134    134      0
>      proc_inode_cache     121    288    656    6    1 : tunables   54 27    8 : slabdata     48     48      0
>      shmem_inode_cache   2249   2827    696   11    2 : tunables   54 27    8 : slabdata    257    257      0
>      inode_cache       209098 209482    584    7    1 : tunables   54 27    8 : slabdata  29926  29926      0
> 
> (What is the difference between `xfs_inode` and `inode_cache`?)
> 
> Then going through all the files with `find -ls`, the inode cache grows to four to five million and the SLAB size grows to around 8 GB. Over night it shrinks back to the numbers above and the page cache grows back.

Maybe this demonstrates what is is probably happening:

==============================
#! /usr/bin/bash

cd /amd/claptrap/1/tmp

if [ ! -d many-files ]; then
     mkdir -p many-files
     for i in $(seq -w 5); do
         mkdir many-files/$i
         for j in $(seq -w 1000); do
             mkdir -p many-files/$i/$j
             for k in $(seq -w 1000); do
                 touch many-files/$i/$j/$k
             done
         done
     done
fi

test -e big-file.dat || fallocate -l $((600*1024*1024*1024)) big-file.dat

echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null

echo "# Start:"
grep -E "^(MemTotal|MemFree|Cached|Active\(file\)|Inactive\(file\)|Slab):" /proc/meminfo
sudo grep xfs_inode /proc/slabinfo

find many-files -ls > /dev/null

echo "# After walking many files :"
grep -E "^(MemTotal|MemFree|Cached|Active\(file\)|Inactive\(file\)|Slab):" /proc/meminfo
sudo grep xfs_inode /proc/slabinfo

cat big-file.dat > /dev/null
echo "# After reading big file:"
grep -E "^(MemTotal|MemFree|Cached|Active\(file\)|Inactive\(file\)|Slab):" /proc/meminfo
sudo grep xfs_inode /proc/slabinfo
==============================

Output:

# Start:
MemTotal:       98634372 kB
MemFree:        97586092 kB
Cached:           115184 kB
Active(file):     100992 kB
Inactive(file):     8984 kB
Slab:             334300 kB
xfs_inode           1329   2272    960    4    1 : tunables   54   27    8 : slabdata    568    568    333
# After walking many files :
MemTotal:       98634372 kB
MemFree:        88795708 kB
Cached:           138024 kB
Active(file):     106740 kB
Inactive(file):    28176 kB
Slab:            6445960 kB
xfs_inode         5006003 5006008    960    4    1 : tunables   54   27    8 : slabdata 1251502 1251502      0
# After reading big file:
MemTotal:       98634372 kB
MemFree:          495240 kB
Cached:         95767564 kB
Active(file):     109404 kB
Inactive(file): 95655164 kB
Slab:            1693884 kB
xfs_inode          67714  68324    960    4    1 : tunables   54   27    8 : slabdata  17081  17081    243

So reading just one single file, which is bigger then the memory of the system, reads the file data through the page cache and shrinks the slabs by the way and the valuable vfs cache is lost. Instead, the memory is filled with the tail of the big file, which wasn't even helpful if the file was read again.

> In the discussions [2], adji`vfs_cache_pressure` is recommended, but – besides setting it to 0 – it only seems to delay the shrinking of the cache. (As it’s an integer 1 is the lowest non-zero (positive) number, which would delay it by a factor of 100.
> 
> Is there a way to specify the minimum numbers of entries in the inode cache, or a minimum SLAB size up to that the caches should not be decreased?
Or limit the page cache.

There was an attempt to make that possible [1], but it looks like it didn't get anywhere.

[1]: https://lwn.net/Articles/602424/

Best

   Donald

> Kind regards,
> 
> Paul
> 
> 
> [1]: https://xfs.org/index.php/Runtime_Stats#ig
> [2]: https://linux-xfs.oss.sgi.narkive.com/qa0AYeBS/improving-xfs-file-system-inode-performance
>       "Improving XFS file system inode performance" from 2010
