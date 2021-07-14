Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BDC3C874E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 17:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239554AbhGNP2I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 11:28:08 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:15086 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232360AbhGNP2H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 11:28:07 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16EFCahk005438;
        Wed, 14 Jul 2021 08:24:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=proofpoint20171006;
 bh=rnRa+zzcqSAVtebc4GjglmaYFvtp9qihG/ZcpG6t9e4=;
 b=THNcssCkdzlyCekhqpMxE2iSTqAQZqBplyxkob2YJwrrzk6/yqwzvl8D/pn/6dXKadES
 JnB85jA+30/Q89MpLXEiBLbwNhVcs566+/aXHtedp/WU8ZelqoQWD60o4VqF0S1j28fl
 Yvb4ddF14zzPND1uhALCeJyPxkjjJ7Yerb4xErluBQQlHcj42Gv4KZ8IjoLlGb3ZVsdb
 2dhoqz8j0T1TMDS8ifLQwulyeYuJVj/n9raTxsMk5ZXhsv2W4TKLOD0rsj7Zt3UFDS7F
 IWuUwaPr+u0PXFzXZonRMXNC0BHXroUNYPGrNSgGkNYHguhLKhcEq5q/6zDwu6Pv4pks hA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by mx0b-002c1b01.pphosted.com with ESMTP id 39sff5j4sq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jul 2021 08:24:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYbNBcn92sNlVQFu+y6w27EGH9Zjo5glHMRF/WwzTbFOlgPdvXqmJGOEaPZPvfY73V/LxxFTFU4l40YrwPYuSQGm50Zoq520gJ51TnF7Lx5jZNdYaRR0aegOtJIzcquE3NY0rQHwBva7kWEN/dyEMXb3szAacqisQAmM89fug6uVEAhdd1TqwtOqwBQQfu0etPjYwEoETeLKD2+57Dm16Tkb595hYQEF3aff+R7H9ApN6VZE9Dmn9NvLPXmj///+XCbSIifFgNLbnYfeM47DE+75bJn/Wz+uuGC7y0QKrMZ9UtE9+pPAi1Ro1DFIRUwZaQcJG0s4zeUmIM3yXtiAWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnRa+zzcqSAVtebc4GjglmaYFvtp9qihG/ZcpG6t9e4=;
 b=dLqKNHioRZYWzJYFsPTbS/HHuVjmZq5m5fzHZMCo9kJRAjVxgPnL1qkkytHCsxzHIUvtraytP9qTsKbDA1HmQkMa32af8hJduS5603ebGe2j0gfj2HQhdDCUUJYWoVagcWONSLGNN6YwatrNeHPFl3te3n+4f8stVMr7wThOQwc8qoM6QEV+cJtKeHGKkmZcU5ZwE8OnjoFFVbEitbPYsKTYPQgaHnPtuoGnIvVMzzvk4tDAw4czf896QOSAmeiamEWHbh5ltfT41pxhc4OIspoOC6YIYvD53Uf5f9V+mY1Eh54D6ENAesqe9GnQR+OpKbtYKj7ydL3B+zIM0hrHng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nutanix.com;
Received: from DM6PR02MB5578.namprd02.prod.outlook.com (2603:10b6:5:79::13) by
 DM5PR02MB2217.namprd02.prod.outlook.com (2603:10b6:3:52::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.27; Wed, 14 Jul 2021 15:24:45 +0000
Received: from DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::159:22bc:800a:52b8]) by DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::159:22bc:800a:52b8%6]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 15:24:44 +0000
From:   Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
To:     akpm@linux-foundation.org, peterx@redhat.com,
        catalin.marinas@arm.com, peterz@infradead.org,
        chinwen.chang@mediatek.com, linmiaohe@huawei.com, jannh@google.com,
        apopple@nvidia.com, christian.brauner@ubuntu.com,
        ebiederm@xmission.com, adobriyan@gmail.com,
        songmuchun@bytedance.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     ivan.teterevkov@nutanix.com, florian.schmidt@nutanix.com,
        carl.waldspurger@nutanix.com,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
Subject: [RFC PATCH 0/1] pagemap: report swap location for shared pages
Date:   Wed, 14 Jul 2021 15:24:25 +0000
Message-Id: <20210714152426.216217-1-tiberiu.georgescu@nutanix.com>
X-Mailer: git-send-email 2.32.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::23) To DM6PR02MB5578.namprd02.prod.outlook.com
 (2603:10b6:5:79::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tiberiu-georgescu.ubvm.nutanix.com (192.146.154.243) by SJ0PR03CA0018.namprd03.prod.outlook.com (2603:10b6:a03:33a::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 15:24:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cd99124-24b8-487c-d742-08d946db8210
X-MS-TrafficTypeDiagnostic: DM5PR02MB2217:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR02MB2217EE696D5DE4BB13030DCBE6139@DM5PR02MB2217.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KKNwTy60VqZmepg1TgKmWMBTfFYYqPS+Y99hPww8lUKaXHcEdFrXYK57IF4iZtjlHBdfCs/wOSeSem52IekPlVHsYqnFv/MQGMGWjrKfRo3hMefRRvIp6i2jjMAc/7iirW+Wq/I+Qdch6FCuqubOSRP/bMf/4CKfTm2O9ZNM2q5fcLEdIn07yi0EEpN02YtkK4EK9rUPySXBfKWNxlCtIPIGpwd5E6gsVbr9IPYnIrYrMyBjPiDub/bOeGTBDjVDR5mgOR3CIabQnPAO0cqO+VjCg4xq0h+N83NcNtRphW1KOj4YbYR3TlRyztI160k3+I9C5hdAI1wbKNbF6mQm4uN7TGQkLNH9bqE6niKuEUaKxAVmZXLEP8AVsr/l5ZHTdKxaYJ9VJbrHhYAVCYpmvsM7eOB0oK+u8pefkBdSk6YYZP4twbVIPXmxJLG3Y++MEH9tdmlTXWVVj0ojJd+1C9iIj3ihZtdb8oMP3et7a/5q2Je04nFm+gdyu3yLhrzwYofutYawrOsvzSAQ7XZE2AmmZ7iFAsY754nBKO8yf9rB9dYJb0vUMXBRLyLqT6M8f+yFnSlV/3RWcjBWPw2i/0Jk/y0MMKkojIiuhw2ErlV5UcpfJhgYllfhBjoaYJ67QC/f+N1j4V70Zf35q9k1eszl3DmymW64qrd3ItWmJup18BsqYUfdSyC853g7pHFE18GCmUhmUbGOSt0ey6ZydQlxM83J92urAsukVa3lGDY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5578.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(396003)(39860400002)(366004)(5660300002)(478600001)(921005)(38100700002)(8676002)(52116002)(83380400001)(8936002)(6666004)(36756003)(44832011)(7696005)(4326008)(86362001)(107886003)(956004)(26005)(2616005)(2906002)(1076003)(7416002)(66946007)(66476007)(316002)(186003)(66556008)(6486002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yWJeiD/tD5DP5X0VHj/VvCbJN7PKn9Imtob5IcSRnZigjFEYiQQ+CqLlaLIL?=
 =?us-ascii?Q?xamuwVCe59bGN8jwG3iw63mXjPfhphzycIM+xKRzEy9yGzVXdBQAt4+o81oE?=
 =?us-ascii?Q?EhG/ueedPg2aWoq1R10XWU5sRi6BZWNz3DmJfNgERDbHPOuzrvnUsdl7+JWr?=
 =?us-ascii?Q?m74pzFlyC10WJkk0n8BBoLHYkf75fHzj+LSO7rDVNFctMLNqVr8+4XSGs4jD?=
 =?us-ascii?Q?76OtCJrJphWngJkHF9YN9DAZ3TTxJPSLpemDooYFqnzQY5h+ztshz5Rbw7mT?=
 =?us-ascii?Q?oQ1QxN+DMP2IJQxXKe+nr1PuyGdCFwzO4IZPM+zGmdlcNr0mgrtjsq91jtrV?=
 =?us-ascii?Q?FkdzQCnhiyPLO2BmqrsDY2Scbbfv6YkwvuYMSh9i1FQDRazpy5VQELJxnc5Z?=
 =?us-ascii?Q?qHl5V0XnzkCUYx8PWj2eWJOhzl/UkvckJwoK39dqZRB1rIWPsC0IjYx4MPL9?=
 =?us-ascii?Q?jo9WYeLXUn4IxiafXYj7tE9D4DLqb4FpaS72EEGiZ5CinD2NIOyX3dpORiHw?=
 =?us-ascii?Q?I4ahrcKQzP83O71YYrm8dL1j6ob0b5NRQfLivE9NIVywb5euu+TVHQy/Pkrw?=
 =?us-ascii?Q?JA3s5Dwt1+BcJ1Mdq/AJ0d0FvSKTLlcYILzyGh+zyVNvqkTuURiAAGOMPSd7?=
 =?us-ascii?Q?ZG3dv/AMl1+O6Z9ho2ulvKhve746NnzpYRkbLB9z0Klb+ahkB2cixIH4Wfpb?=
 =?us-ascii?Q?eTSKVy8bJ1KeTf/9ex/XGWdO9WTUqBCys5wLt22ljkZ2o9BLL/Oq7GrIYoaO?=
 =?us-ascii?Q?qZ5ulUV1Jb/CaD5Vlyz81EqKmgmJu8Mq+GETSY2utGQceK4BfYtCf0AtHgUP?=
 =?us-ascii?Q?mYcxarISAqjp08mLNm/j9Cz6BbFyiJ4jFEuDa7IsWWTmvl+4udy3QIDIHPXF?=
 =?us-ascii?Q?OjUVXlk/ZXdpjj1CcQu/80/XKfchq3TcZq19JAauMCVlV7iTVls5nxH6aasi?=
 =?us-ascii?Q?DQJxcPL+BJFzWHP2+C5EOCK7fLO7YyWDY0ngW/QmoyypkYBnolxHpHW0h75y?=
 =?us-ascii?Q?K583A6k/Ni/rARjqdxdTVHhHZSEmd+hHwuxdyjlEczddMr9p4L93o6JuwF3t?=
 =?us-ascii?Q?/j7eP3vo1A77JbduCRON0V6N3MNr2HRjJS7hfplulglNC1r5lSdFlY7wqFH7?=
 =?us-ascii?Q?4vbAChlw4LY/85uElq4Ik3m+XlBXsOENvD5Rfc69bUn8XM8YHZGL6/ClP62e?=
 =?us-ascii?Q?/GuyUelhZX09CzqtzedOJ9BogTSvlvtBd6ywjxWqqievHpKtr4KLrccMrE39?=
 =?us-ascii?Q?s4MOc3+F3SAcfOtkR6t2L2fCMS2dpXpV+knN7VujHvCFAOXyWvPN9cfQpHIv?=
 =?us-ascii?Q?iYI/+r0i1fg0dcQg71fD1Zen?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd99124-24b8-487c-d742-08d946db8210
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5578.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 15:24:44.5428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8jCJ8EA715MSc671UddhXoniPhtP7foUz9lTf72xHroruqdASJSlrweg7k5nDT50a7klXbIiFspJBEEo5kEMZHyH9qw4YGJ2oLZc+QHTm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2217
X-Proofpoint-ORIG-GUID: 94x4coDNL-x6qtC1JquUxKr5IZPJYZrf
X-Proofpoint-GUID: 94x4coDNL-x6qtC1JquUxKr5IZPJYZrf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-14_08:2021-07-14,2021-07-14 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a page allocated using the MAP_SHARED flag is swapped out, its pagemap
entry is cleared. In many cases, there is no difference between swapped-out
shared pages and newly allocated, non-dirty pages in the pagemap interface.

Example pagemap-test code (Tested on Kernel Version 5.14-rc1):

	#define NPAGES (256)
	/* map 1MiB shared memory */
	size_t pagesize = getpagesize();
	char *p = mmap(NULL, pagesize * NPAGES, PROT_READ | PROT_WRITE,
			   MAP_ANONYMOUS | MAP_SHARED, -1, 0);
	/* Dirty new pages. */
	for (i = 0; i < PAGES; i++)
		p[i * pagesize] = i;

Run the above program in a small cgroup, which allows swapping:

	/* Initialise cgroup & run a program */
	$ echo 512K > foo/memory.limit_in_bytes
	$ echo 60 > foo/memory.swappiness
	$ cgexec -g memory:foo ./pagemap-test

Check the pagemap report. This is an example of the current expected output:

	$ dd if=/proc/$PID/pagemap ibs=8 skip=$(($VADDR / $PAGESIZE)) count=$COUNT | hexdump -C
	00000000  00 00 00 00 00 00 80 00  00 00 00 00 00 00 80 00  |................|
	*
	00000710  e1 6b 06 00 00 00 80 a1  9e eb 06 00 00 00 80 a1  |.k..............|
	00000720  6b ee 06 00 00 00 80 a1  a5 a4 05 00 00 00 80 a1  |k...............|
	00000730  5c bf 06 00 00 00 80 a1  90 b6 06 00 00 00 80 a1  |\...............|

The first pagemap entries are reported as zeroes, indicating the pages have
never been allocated while they have actually been swapped out. It is
possible for bit 55 (PTE is Soft-Dirty) to be set on all pages of the
shared VMA, indicating some access to the page, but nothing else (frame
location, presence in swap or otherwise).

This patch addresses the behaviour and modifies pte_to_pagemap_entry() to
make use of the XArray associated with the virtual memory area struct
passed as an argument. The XArray contains the location of virtual pages in
the page cache, swap cache or on disk. If they are on either of the caches,
then the original implementation still works. If not, then the missing
information will be retrieved from the XArray.

The root cause of the missing functionality is that the PTE for the page
itself is cleared when a swap out occurs on a shared page.  Please take a
look at the proposed patch. I would appreciate it if you could verify a
couple of points:

1. Why do swappable and non-syncable shared pages have their PTEs cleared
   when they are swapped out ? Why does the behaviour differ so much
   between MAP_SHARED and MAP_PRIVATE pages? What are the origins of the
   approach?

2. PM_SOFT_DIRTY and PM_UFFD_WP are two flags that seem to get lost once
   the shared page is swapped out. Is there any other way to retrieve
   their value in the proposed patch, other than ensuring these flags are
   set, when necessary, in the PTE?

Kind regards,
Tibi

Tiberiu Georgescu (1):
  pagemap: report swap location for shared pages

 fs/proc/task_mmu.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

-- 
2.32.0

