Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE0C24CCF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 06:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgHUEpu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 00:45:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29468 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725908AbgHUEpt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 00:45:49 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07L4YIj8171262;
        Fri, 21 Aug 2020 00:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding : message-id; s=pp1;
 bh=0ZFBYPwt7oIVi0zmqeJRyIDzSpcn6H+lTuSgoG9Orfs=;
 b=Tm4paieNOb5oiMkvHPHyiSTyuTM949sfziNbtoqEj5RCydHx+d+nQ1EMl8iqi7FTKfSd
 3n4QHe/w9GgiLkgfO0WLh1QUoKgwfSLV+jgdXAGBedEMs+XAv3v2RgKE06+mtGFFwLKI
 i8N0twuDUzMeOQu7eTkoOR1Z1jm3DdvgC/qRBWSzR7b+5XiUxhYYBVhVzKTKQJmNmhpk
 cwWChONIcvbiZ6c25PNiMHb2hdRSr0o3916V08dHrl6FIZoWSutgw2RonaeIMAdiKVCN
 DrR7hN0gDd9ih5fuohQAmOr36AGyYISH6HRU50wCJJyDV9xpeYOvTrdG15OMTsZFqIqe Vw== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3326d7sgxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Aug 2020 00:45:40 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07L4iVsM014671;
        Fri, 21 Aug 2020 04:45:37 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3304c92dmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Aug 2020 04:45:37 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07L4jZWN32243982
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Aug 2020 04:45:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1ADA9A405B;
        Fri, 21 Aug 2020 04:45:35 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBFD1A405F;
        Fri, 21 Aug 2020 04:45:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.217])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Aug 2020 04:45:33 +0000 (GMT)
Subject: Re: [PATCH] iomap: Fix the write_count in iomap_add_to_ioend().
To:     Dave Chinner <david@fromorbit.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc:     hch@infradead.org, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org
References: <20200819102841.481461-1-anju@linux.vnet.ibm.com>
 <20200820231140.GE7941@dread.disaster.area>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Fri, 21 Aug 2020 10:15:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200820231140.GE7941@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200821044533.BBFD1A405F@d06av23.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_03:2020-08-19,2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 clxscore=1015 adultscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210037
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Dave,

Thanks for reviewing this.

On 8/21/20 4:41 AM, Dave Chinner wrote:
> On Wed, Aug 19, 2020 at 03:58:41PM +0530, Anju T Sudhakar wrote:
>> From: Ritesh Harjani <riteshh@linux.ibm.com>
>>
>> __bio_try_merge_page() may return same_page = 1 and merged = 0.
>> This could happen when bio->bi_iter.bi_size + len > UINT_MAX.
> 
> Ummm, silly question, but exactly how are we getting a bio that
> large in ->writepages getting built? Even with 64kB pages, that's a
> bio with 2^16 pages attached to it. We shouldn't be building single
> bios in writeback that large - what storage hardware is allowing
> such huge bios to be built? (i.e. can you dump all the values in
> /sys/block/<dev>/queue/* for that device for us?)

Please correct me here, but as I see, bio has only these two limits
which it checks for adding page to bio. It doesn't check for limits
of /sys/block/<dev>/queue/* no? I guess then it could be checked
by block layer below b4 submitting the bio?

113 static inline bool bio_full(struct bio *bio, unsigned len)
114 {
115         if (bio->bi_vcnt >= bio->bi_max_vecs)
116                 return true;
117
118         if (bio->bi_iter.bi_size > UINT_MAX - len)
119                 return true;
120
121         return false;
122 }


This issue was first observed while running a fio run on a system with
huge memory. But then here is an easy way we figured out to trigger the
issue almost everytime with loop device on my VM setup. I have provided
all the details on this below.

<cmds to trigger it fairly quickly>
===================================
echo 99999999 > /proc/sys/vm/dirtytime_expire_seconds
echo 99999999 > /proc/sys/vm/dirty_expire_centisecs
echo 90  > /proc/sys/vm/dirty_rati0
echo 90  > /proc/sys/vm/dirty_background_ratio
echo 0  > /proc/sys/vm/dirty_writeback_centisecs

sudo perf probe -s ~/host_shared/src/linux/ -a '__bio_try_merge_page:10 
bio page page->index bio->bi_iter.bi_size len same_page[0]'

sudo perf record -e probe:__bio_try_merge_page_L10 -a --filter 'bi_size 
 > 0xff000000' sudo fio --rw=write --bs=1M --numjobs=1 
--name=/mnt/testfile --size=24G --ioengine=libaio


# on running this 2nd time it gets hit everytime on my setup

sudo perf record -e probe:__bio_try_merge_page_L10 -a --filter 'bi_size 
 > 0xff000000' sudo fio --rw=write --bs=1M --numjobs=1 
--name=/mnt/testfile --size=24G --ioengine=libaio


Perf o/p from above filter causing overflow
===========================================
<...>
              fio 25194 [029] 70471.559084: 
probe:__bio_try_merge_page_L10: (c000000000aa054c) 
bio=0xc0000013d49a4b80 page=0xc00c000004029d80 index=0x10a9d 
bi_size=0xffff8000 len=0x1000 same_page=0x1
              fio 25194 [029] 70471.559087: 
probe:__bio_try_merge_page_L10: (c000000000aa054c) 
bio=0xc0000013d49a4b80 page=0xc00c000004029d80 index=0x10a9d 
bi_size=0xffff9000 len=0x1000 same_page=0x1
              fio 25194 [029] 70471.559090: 
probe:__bio_try_merge_page_L10: (c000000000aa054c) 
bio=0xc0000013d49a4b80 page=0xc00c000004029d80 index=0x10a9d 
bi_size=0xffffa000 len=0x1000 same_page=0x1
              fio 25194 [029] 70471.559093: 
probe:__bio_try_merge_page_L10: (c000000000aa054c) 
bio=0xc0000013d49a4b80 page=0xc00c000004029d80 index=0x10a9d 
bi_size=0xffffb000 len=0x1000 same_page=0x1
              fio 25194 [029] 70471.559095: 
probe:__bio_try_merge_page_L10: (c000000000aa054c) 
bio=0xc0000013d49a4b80 page=0xc00c000004029d80 index=0x10a9d 
bi_size=0xffffc000 len=0x1000 same_page=0x1
              fio 25194 [029] 70471.559098: 
probe:__bio_try_merge_page_L10: (c000000000aa054c) 
bio=0xc0000013d49a4b80 page=0xc00c000004029d80 index=0x10a9d 
bi_size=0xffffd000 len=0x1000 same_page=0x1
              fio 25194 [029] 70471.559101: 
probe:__bio_try_merge_page_L10: (c000000000aa054c) 
bio=0xc0000013d49a4b80 page=0xc00c000004029d80 index=0x10a9d 
bi_size=0xffffe000 len=0x1000 same_page=0x1
              fio 25194 [029] 70471.559104: 
probe:__bio_try_merge_page_L10: (c000000000aa054c) 
bio=0xc0000013d49a4b80 page=0xc00c000004029d80 index=0x10a9d 
bi_size=0xfffff000 len=0x1000 same_page=0x1

^^^^^^ (this could cause an overflow)

loop dev
=========
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE    DIO LOG-SEC
/dev/loop1         0      0         0  0 /mnt1/filefs   0     512


mount o/p
=========
/dev/loop1 on /mnt type xfs 
(rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)


/sys/block/<dev>/queue/*
========================

setup:/run/perf$ cat /sys/block/loop1/queue/max_segments
128
setup:/run/perf$ cat /sys/block/loop1/queue/max_segment_size
65536
setup:/run/perf$ cat /sys/block/loop1/queue/max_hw_sectors_kb
1280
setup:/run/perf$ cat /sys/block/loop1/queue/logical_block_size
512
setup:/run/perf$ cat /sys/block/loop1/queue/max_sectors_kb
1280
setup:/run/perf$ cat /sys/block/loop1/queue/hw_sector_size
512
setup:/run/perf$ cat /sys/block/loop1/queue/discard_max_bytes
4294966784
setup:/run/perf$ cat /sys/block/loop1/queue/discard_max_hw_bytes
4294966784
setup:/run/perf$ cat /sys/block/loop1/queue/discard_zeroes_data
0
setup:/run/perf$ cat /sys/block/loop1/queue/discard_granularity
4096
setup:/run/perf$ cat /sys/block/loop1/queue/chunk_sectors
0
setup:/run/perf$ cat /sys/block/loop1/queue/max_discard_segments
1
setup:/run/perf$ cat /sys/block/loop1/queue/read_ahead_kb
128
setup:/run/perf$ cat /sys/block/loop1/queue/rotational
1
setup:/run/perf$ cat /sys/block/loop1/queue/physical_block_size
512
setup:/run/perf$ cat /sys/block/loop1/queue/write_same_max_bytes
0
setup:/run/perf$ cat /sys/block/loop1/queue/write_zeroes_max_bytes
4294966784
