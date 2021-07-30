Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0B43DBCDF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 18:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhG3QJn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 12:09:43 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:23560 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229505AbhG3QJl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 12:09:41 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16UG7lYT008151;
        Fri, 30 Jul 2021 09:09:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=proofpoint20171006;
 bh=R0c5tJzFC/nkIMBaVuzzCIBURmKJgc8mL8Nw6FOWuKc=;
 b=1f18W8suEcGXmu7gPhtZS29r4eOS54UCCWxn4RzjKlpK34ud1NbROZx3GW/32HXTo/pp
 pbqvN3F33RzeoqsAD3+bpQcKt4F0dnIzyFQs9/8N4wBmR3aenJDG5j1yjrhLt3dKbRAS
 wlBQrl47laiJPxiIILrKbNr1MeX8/dLkNKhhTvv0GCzSCGW+WOcd/UW6QzCkKEhW+zss
 uVx6Z2VivDE+92DxKLhpAjFru9t+7L5YEeXj7Y2G5kXT9iugpIX5KtNkYApKyAZ6uZzw
 FGyBg9E5iXsUh+uod0KB+UR3Rc9hlXtl8iTbAt7B9rYWvIAGXdM4n7tqRmvWpEoM8LXt kw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0a-002c1b01.pphosted.com with ESMTP id 3a4a6m191j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jul 2021 09:09:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqlGuTqGCm9q/q3Yih5B8RlgMY+oK2PhqhlYrLIWGoPNL0031y1QMBGtnIdnYPH29LVJKbtPO8j+du3jXhjy+0u9Xo3tK7MLXkT9JvdxAwljiRJhGLfWvwSlsLt5hAAN2Qm8R2ouwR0pxKZCb0VcSh8T1YMcEQ2qnmGHMM8xBWPDIFDQ3aeC2YN50hb1wZebOLZ/oOr96sMP8AcqcDpnD1o4lrzEhqlXP9JsahD9y09OFNWn1JTYSylgqoFH2APqMM1OVKiJTQHpDTwnaF9YlyiQGSBfAu59Ye33/vtUMTLxZjCBrXgFq+R4O7r9dWHIyjJ+/zPZA2Sp4G8lvEjJCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0c5tJzFC/nkIMBaVuzzCIBURmKJgc8mL8Nw6FOWuKc=;
 b=P/PGX0e6Or12b9bfNMNZNavTXlNDDhj3k2LuzAEy82xne4AQqJS5S14AU/dwSLB6fJIZeokRjrtpPaUTbzBFyz97N3JoIDIYSO25CJLdKH2K5r74wH5TJxk8qB34yVzpGZPxWKWlF8E4zRy2vwUIlvltv5mpbFv9H5vvjQwdEzKP/7DL0/QoVXLG1zgci3imMUyahaVfmGmO0aYVFeBCCIajwhdiH7h7IEuDtqktfcswJgVvfnM9ZUV3uzDCNXEyU+NCu0alKEIqlGf4VEglKaq3kfNFqrrKru0zjcbO3aDmJiZwLA/ZF8XNSwzX/mP52DmVBaNvmkh1HsGFpH7WLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nutanix.com;
Received: from DM6PR02MB5578.namprd02.prod.outlook.com (2603:10b6:5:79::13) by
 DM8PR02MB8262.namprd02.prod.outlook.com (2603:10b6:8:9::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Fri, 30 Jul 2021 16:09:03 +0000
Received: from DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::159:22bc:800a:52b8]) by DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::159:22bc:800a:52b8%6]) with mapi id 15.20.4373.022; Fri, 30 Jul 2021
 16:09:03 +0000
From:   Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        peterx@redhat.com, david@redhat.com, christian.brauner@ubuntu.com,
        ebiederm@xmission.com, adobriyan@gmail.com,
        songmuchun@bytedance.com, axboe@kernel.dk,
        vincenzo.frascino@arm.com, catalin.marinas@arm.com,
        peterz@infradead.org, chinwen.chang@mediatek.com,
        linmiaohe@huawei.com, jannh@google.com, apopple@nvidia.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     ivan.teterevkov@nutanix.com, florian.schmidt@nutanix.com,
        carl.waldspurger@nutanix.com, jonathan.davies@nutanix.com,
        Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>
Subject: [PATCH 0/1] pagemap: swap location for shared pages
Date:   Fri, 30 Jul 2021 16:08:25 +0000
Message-Id: <20210730160826.63785-1-tiberiu.georgescu@nutanix.com>
X-Mailer: git-send-email 2.32.0.380.geb27b338a3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0069.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::14) To DM6PR02MB5578.namprd02.prod.outlook.com
 (2603:10b6:5:79::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tiberiu-georgescu.ubvm.nutanix.com (192.146.154.243) by SJ0PR13CA0069.namprd13.prod.outlook.com (2603:10b6:a03:2c4::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.10 via Frontend Transport; Fri, 30 Jul 2021 16:09:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e44b748-c7e2-4ccb-6522-08d95374598f
X-MS-TrafficTypeDiagnostic: DM8PR02MB8262:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR02MB8262B2B22EB65BA930E92064E6EC9@DM8PR02MB8262.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q1Cd356h/ywnHON/etrAfeTgjo46oywy5rRI4FOrckQmzlWHoIicFFQ+oW7P32eI6EFY/wxezMBso2eidS/7WZyxab/BP1tAkHwuY3Wq3hm8zvD8dtI22c+SYJ/7wkRZd5Nvri/zDtpNPrQTXz/NNASuw54jreVHfbarPoJw/08ASzGbrBHBWyefTgSX2AJwzIFWl+xgxMkMsE5TlQ0HMl2camfSvXP0F3uYhTeN4xNgLK/dNkAd9Dvc8Ot1HZEmgQ8O24treYXgFpbhdvyDJInoI0SVT1ymNz7JBd4gSQ/cSiSnbVQcW7FJePpv1BwKtRmpidmu0yRWoZ9qn+zr/00WY9qrTF7Dh+pIeNJxirdGH4t42WTGciukrZNks0ZlC195mmmPBfYRxOeO+UStMaG8ZQff4mVQaDwMN9VyYLcQs9VjBf+7pe8/Zo3UmkD5zSb5B/kbP0ebkbCWpCK8O64/4detAqaj15iyalJvhjxTaEs9VHutQUMH7PK3osTXTtKA/vtZ1xMIrCOcFor2Hr92hu5uHuzstDerovuVz0YI1j+1dvbZ5//xfXywjug/niBiyDq+CCLinrpTvwDI5wf2qiWZZqY9Ige9wTRPWyX0P23xAsFuj7nIRiWDFtCEbYSOGaDkE91EfoxD4Qo7n/61QxxIzEWEgNHVS1ExyKDUTu1XidVW4Fzxs7/ASeJGb3uiXOOssQt8mR+hewUM+PKGxmIE48vy1tUCXpDJKkCxdT//tHAqHrB5dZwCeXFD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5578.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(136003)(39860400002)(366004)(8936002)(6486002)(26005)(66946007)(8676002)(66476007)(316002)(19627235002)(2616005)(956004)(1076003)(2906002)(66556008)(107886003)(6666004)(86362001)(921005)(5660300002)(4326008)(36756003)(52116002)(186003)(38350700002)(478600001)(7696005)(38100700002)(83380400001)(7416002)(505234006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7CGiGXcph0wA6odoUaSF7+a07Fg0tNm2f7V9V1AYBIVZlQAsmxaKXgS/PjFo?=
 =?us-ascii?Q?afVpRaVDPLrxyuUyr0h9xQx/0wS6fifDJYjR40XulHJg2XEFydCIPelQEcnZ?=
 =?us-ascii?Q?V2yDhG3X6jo7qv1EXmZBulUm+QOTv4q4gJdfpI3PhqpSjbwOasDy3DBJIigm?=
 =?us-ascii?Q?IvCxYocvIEwdjXHprwEG0VeiG3UtyjfZrlnM8J2N+2SG68UsD+IXbDZvHmHE?=
 =?us-ascii?Q?116irlBTHa1SsSN6HywP6AxeypM+0AkLJJw/vFgzEySPiLI5efJSARVbEh28?=
 =?us-ascii?Q?JkVctCKbtK5Akrr+yxgixY5UuqxquJBs5CCDGlSh5UncI85YOpBV1X7HOQOK?=
 =?us-ascii?Q?RVpOzuH1fFhRBEzMBChhmGb6tV1ACtzoV90/tkb0QoTaW8e02QPgyvp5Kfce?=
 =?us-ascii?Q?8qmBvzbj4Z89MQN1cpklCq5eyHg0WF/8fcuP2RF4E1vLZjP90QDMqDfhv0Gy?=
 =?us-ascii?Q?MGAUCXGTRMf17x4NFuwDLZMsq6s+dqDdqTGr5+4LkZXBYsigSQbtaf19/d83?=
 =?us-ascii?Q?j7FpYwyOXgVcsDf7aVknrFGJ/k7RGpu+rJgRTKdpRT4U4fYR+VsbkaEkwZOw?=
 =?us-ascii?Q?MoMDCy5Qe7cau0/PUSC6tstQ0mzmOgJWeHoOjJj3DsaTfmhWOzUzpIgJKL+U?=
 =?us-ascii?Q?ZMhBJyOG62+mGb/6bBX8KXJXleORLAwciLV/oyu8d3CT/KAAsd3o5KHY5ZxF?=
 =?us-ascii?Q?3o+HSldZG+rDVYf7DaR6hBcybtjBX9N4jZjjmP55NCqyiVI5P7pVPuZz5G7o?=
 =?us-ascii?Q?uOIFD8ti3wFPcRlhwm6ZiomCfwiRQMQAKPH6ySvMZNBLx+pzgLbdNN9kwao6?=
 =?us-ascii?Q?9EA6KJoEg14qur+KSSib5oILrHYpioIOwjU4KiNhCq9ZZZYFKMGgVXltHUOR?=
 =?us-ascii?Q?DTa8rMN8kwRMP8loaSgts/9V3/ogszCDfhoyu/S4/WOIBp5opUgo/ZkUCKWu?=
 =?us-ascii?Q?tKjsZmPelY/M2jtgkuIjq7wqtRriumhDWaSUJRnkBLOneiH2jFCsImgJzpJ2?=
 =?us-ascii?Q?jOFzb+yqRhQmgM8fsXmuuXNdKXUo25FOOYF0qPUJfJE/A9TTaZfLVkz5nXGx?=
 =?us-ascii?Q?Txwiwe9cTClKhiIUyM2VyGdBpvAQpPZQdauKKzmJbjgv+4xxEDlQAyr7uN/C?=
 =?us-ascii?Q?kOSKJ6E3PVLBwDBfyp7Xy0CfwmoJsA82BDS18cbaJMolC1b2N1kbdx+y8ilY?=
 =?us-ascii?Q?1bYIJ3mSWQi4tD8e3AVwE1OJRVW8wQJA6iPeB2CdugfbuAGgJESKyg+8zcN1?=
 =?us-ascii?Q?7FVB+1gAlBHIp1djMQ45bc56WPQBvnuFkaXFEMSHXowT6+w3ff6cxgyrKv6k?=
 =?us-ascii?Q?VoP5cj1aF8jU37ANxnkTHZdR?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e44b748-c7e2-4ccb-6522-08d95374598f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5578.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 16:09:03.5086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDPHrRry4LSTUIfH+6U8NqKbqqA8/jt7ghgYvnDPHnbdNZhFP3Cdv12FDrEPf9kRpiI30X6xGMi3mGi0EyWbvvBxtjaY54mac+PbNu2up4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8262
X-Proofpoint-ORIG-GUID: 6qv6qTuBkyFboDWKV_8VJENbbKHmCYn5
X-Proofpoint-GUID: 6qv6qTuBkyFboDWKV_8VJENbbKHmCYn5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-30_11:2021-07-30,2021-07-30 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch follows up on a previous RFC:
20210714152426.216217-1-tiberiu.georgescu@nutanix.com

When a page allocated using the MAP_SHARED flag is swapped out, its pagemap
entry is cleared. In many cases, there is no difference between swapped-out
shared pages and newly allocated, non-dirty pages in the pagemap interface.

Example pagemap-test code (Tested on Kernel Version 5.14-rc3):
    #define NPAGES (256)
    /* map 1MiB shared memory */
    size_t pagesize = getpagesize();
    char *p = mmap(NULL, pagesize * NPAGES, PROT_READ | PROT_WRITE,
    		   MAP_ANONYMOUS | MAP_SHARED, -1, 0);
    /* Dirty new pages. */
    for (i = 0; i < PAGES; i++)
    	p[i * pagesize] = i;

Run the above program in a small cgroup, which causes swapping:
    /* Initialise cgroup & run a program */
    $ echo 512K > foo/memory.limit_in_bytes
    $ echo 60 > foo/memory.swappiness
    $ cgexec -g memory:foo ./pagemap-test

Check the pagemap report. Example of the current expected output:
    $ dd if=/proc/$PID/pagemap ibs=8 skip=$(($VADDR / $PAGESIZE)) count=$COUNT | hexdump -C
    00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
    *
    00000710  e1 6b 06 00 00 00 00 a1  9e eb 06 00 00 00 00 a1  |.k..............|
    00000720  6b ee 06 00 00 00 00 a1  a5 a4 05 00 00 00 00 a1  |k...............|
    00000730  5c bf 06 00 00 00 00 a1  90 b6 06 00 00 00 00 a1  |\...............|

The first pagemap entries are reported as zeroes, indicating the pages have
never been allocated while they have actually been swapped out.

This patch addresses the behaviour and modifies pte_to_pagemap_entry() to
make use of the XArray associated with the virtual memory area struct
passed as an argument. The XArray contains the location of virtual pages in
the page cache, swap cache or on disk. If they are in either of the caches,
then the original implementation still works. If not, then the missing
information will be retrieved from the XArray.

Performance
============
I measured the performance of the patch on a single socket Xeon E5-2620
machine, with 128GiB of RAM and 128GiB of swap storage. These were the
steps taken:

  1. Run example pagemap-test code on a cgroup
    a. Set up cgroup with limit_in_bytes=4GiB and swappiness=60;
    b. allocate 16GiB (about 4 million pages);
    c. dirty 0,50 or 100% of pages;
    d. do this for both private and shared memory.
  2. Run `dd if=<PAGEMAP> ibs=8 skip=$(($VADDR / $PAGESIZE)) count=4194304`
     for each possible configuration above
    a.  3 times for warm up;
    b. 10 times to measure performance.
       Use `time` or another performance measuring tool.

Results (averaged over 10 iterations):
               +--------+------------+------------+
               | dirty% |  pre patch | post patch |
               +--------+------------+------------+
 private|anon  |     0% |      8.15s |      8.40s |
               |    50% |     11.83s |     12.19s |
               |   100% |     12.37s |     12.20s |
               +--------+------------+------------+
  shared|anon  |     0% |      8.17s |      8.18s |
               |    50% | (*) 10.43s |     37.43s |
               |   100% | (*) 10.20s |     38.59s |
               +--------+------------+------------+

(*): reminder that pre-patch produces incorrect pagemap entries for swapped
     out pages.

From run to run the above results are stable (mostly <1% stderr).

The amount of time it takes for a full read of the pagemap depends on the
granularity used by dd to read the pagemap file. Even though the access is
sequential, the script only reads 8 bytes at a time, running pagemap_read()
COUNT times (one time for each page in a 16GiB area).

To reduce overhead, we can use batching for large amounts of sequential
access. We can make dd read multiple page entries at a time,
allowing the kernel to make optimisations and yield more throughput.

Performance in real time (seconds) of
`dd if=<PAGEMAP> ibs=8*$BATCH skip=$(($VADDR / $PAGESIZE / $BATCH))
count=$((4194304 / $BATCH))`:
+---------------------------------+ +---------------------------------+
|     Shared, Anon, 50% dirty     | |     Shared, Anon, 100% dirty    |
+-------+------------+------------+ +-------+------------+------------+
| Batch |  Pre-patch | Post-patch | | Batch |  Pre-patch | Post-patch |
+-------+------------+------------+ +-------+------------+------------+
|     1 | (*) 10.43s |     37.43s | |     1 | (*) 10.20s |     38.59s |
|     2 | (*)  5.25s |     18.77s | |     2 | (*)  5.15s |     19.37s |
|     4 | (*)  2.63s |      9.42s | |     4 | (*)  2.63s |      9.74s |
|     8 | (*)  1.38s |      4.80s | |     8 | (*)  1.35s |      4.94s |
|    16 | (*)  0.73s |      2.46s | |    16 | (*)  0.72s |      2.54s |
|    32 | (*)  0.40s |      1.31s | |    32 | (*)  0.41s |      1.34s |
|    64 | (*)  0.25s |      0.72s | |    64 | (*)  0.24s |      0.74s |
|   128 | (*)  0.16s |      0.43s | |   128 | (*)  0.16s |      0.44s |
|   256 | (*)  0.12s |      0.28s | |   256 | (*)  0.12s |      0.29s |
|   512 | (*)  0.10s |      0.21s | |   512 | (*)  0.10s |      0.22s |
|  1024 | (*)  0.10s |      0.20s | |  1024 | (*)  0.10s |      0.21s |
+-------+------------+------------+ +-------+------------+------------+

To conclude, in order to make the most of the underlying mechanisms of
pagemap and xarray, one should be using batching to achieve better
performance.

Future Work
============

Note: there are PTE flags which currently do not survive the swap out when
the page is shmem: SOFT_DIRTY and UFFD_WP.

A solution for saving the state of the UFFD_WP flag has been proposed by
Peter Xu in the patch linked below. The concept and mechanism proposed
could be extended to include the SOFT_DIRTY bit as well:
20210715201422.211004-1-peterx@redhat.com
Our patches are mostly orthogonal.

Kind regards,
Tibi

Tiberiu A Georgescu (1):
  pagemap: report swap location for shared pages

 fs/proc/task_mmu.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

-- 
2.32.0.380.geb27b338a3

