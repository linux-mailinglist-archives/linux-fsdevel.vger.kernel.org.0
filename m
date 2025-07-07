Return-Path: <linux-fsdevel+bounces-54158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89836AFBA5B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 20:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342E91AA7720
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 18:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2789263F41;
	Mon,  7 Jul 2025 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gLU2csgG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5F8261586;
	Mon,  7 Jul 2025 18:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751911600; cv=fail; b=Sz/w02SlsIvILMdfaqbV8TkbF4Uvp4PSuF16XRAEM0IdpEH5y+C12AE+jzK1ZMOY6Z2Y53CZ7/w9Jbgbo2joEMIOSaNHhrnqjtKbDkeYBQiFRfIQMxtbGcvwojFfrM0vMT32hxbejFREu3hNZlMA3FzJpTE+E+MwkRz8IP/wVwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751911600; c=relaxed/simple;
	bh=T49v6Wodb0ZYWWwT2oPBrMee5Cq1RuP62qT2RyLmtW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CZuJtjqwU4LzbV9hyfoGQChbU34AWUKHc01lauC5F+MNZH5yLq5xfL77vZ3g9KjMhbTw41jKxomoGCnEYFEwDTn6xC7eNmIZpPhOcZd8yxi7gavBpE+UaUOpN92l4VYrA8fEstCkgkmleQ9a97PGxACo+OKzDXDqeAZUsqVpaOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gLU2csgG; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yxhIvA3TlXEloH0fZ+E6CiSpzP809F3Pw5wg/nlGGDVeGh7Cg9lziHkAI/6KGgMi/uJ2lLOBpk+LlyLkw9csT0X2vfAFOCjVJmu8WcU2V4+z1Vxrm1mPySYIAaSnWU7kM18m5MypnO9/r4SkMGXTb8KnfEDvGCndLJbOKNTDRLHGSeANf+Az5f+MIAAVvkcu91ec6Q60rIy8M340heqpcEPKDSLY9d5ETzFvlnY7cKT3mgGClTAoi0MR4ciYkUP3mcAFEBzvuluncDbEy7tHFGwzvIoE6nM4w1g0YSp7qJlroB/tU6s3NQLc7yGfiEgR6H+emDeJEdKdulb2ssvUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T49v6Wodb0ZYWWwT2oPBrMee5Cq1RuP62qT2RyLmtW8=;
 b=Ioe1ft2nvu8vXwccaobTTbwYuBDspG1n7lFQ5Q0zt1TRqV/iM8NSRFzEpf+L8YntLIPfB5MyYevB625Hcf5bG3d2yv0seVUpKNVz42iqfOd3TaBb18ufgh/yezNB22/ZXWEAA7aWHIpDloqCCZIzOUmDumPqEzbO+isS3Z7MNEMigjRGsXhQhxkN5DdCQA+BwvF8TIJOMT8AEsnCLYi1oamuE+anjrH0SBySwwtOZg1hGpwk9vwyaKRXFDIoamqMIhIrYoVF2Lqr+n9Rrz4n6x2BecORdUXwQgXYyk/L0HqUifChdaaP8W+6tXjHu3qGxYtz3h9art9DRebVTaPUvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T49v6Wodb0ZYWWwT2oPBrMee5Cq1RuP62qT2RyLmtW8=;
 b=gLU2csgGyUnaxeGkNHKenbwtZ0CmOTz8e0eQZfcuzq4PkSedYH+n4ttpxizwB5DkiXFUjnra4Fbcq8RFNjBqGhGnBGQa82HriwtUM9JW8gIK6KyXr7yQC+r0KtsdveVDqREUmhTrC+d9te0xSj8OPTAqbzYU0OCqskX9LVnsh20ZPmplN1XQfIcmIYyFSLazvrfwRYniPNStl3KGeGqy8x9JGHF3euPx4JMOHLBeqLMmQ8QFPZjSOIB4YQ2lHtM3/q9QXIo1NFJ7rnvHPvIQlRSMlcKbHVkaLAVcn5xybIiP50WQKwewY81pUjatFFosYvbULtPXFIJgLzgfQEZ5dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS2PR12MB9662.namprd12.prod.outlook.com (2603:10b6:8:27d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.22; Mon, 7 Jul 2025 18:06:33 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 18:06:33 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 willy@infradead.org, linux-mm@kvack.org, x86@kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 0/5] add static PMD zero page support
Date: Mon, 07 Jul 2025 14:06:22 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <F8FE3338-F0E9-4C1B-96A3-393624A6E904@nvidia.com>
In-Reply-To: <20250707142319.319642-1-kernel@pankajraghav.com>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
Content-Type: text/plain
X-ClientProxiedBy: BL0PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:208:91::28) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS2PR12MB9662:EE_
X-MS-Office365-Filtering-Correlation-Id: 20812098-a1ee-44b6-ac70-08ddbd8101c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mbqcks+3QDN/acjWD7gbx6Iq9lZtz0yK7A34ZBHQKCnBa/1MUu3BgcHGCrXt?=
 =?us-ascii?Q?9xnrg9WyaFveIl+YmVL0MruOO0+nzRu4m6Gf7a6u7OfC2i6oPnq67SJ6yuJk?=
 =?us-ascii?Q?faGskZhCJIgwPuR/DQKib2wN17h5q3QMWPzZxity/RNq3RVS25to7C+8TgiM?=
 =?us-ascii?Q?qFa2QhA1vwLfoz0La+wprcwmfo/THVHYGmRjGyPjxWSnIuIJ+LwYsjjxqxD+?=
 =?us-ascii?Q?/YJIn1KMfE21YRf9Hd6nP56VFyoRtf63HKHf7NiP7U9MHGEdTSW66oI1xala?=
 =?us-ascii?Q?83jdLjvrdabvjiKWLCI7r5aBaJ4oxuOFr2hRW38BrMye6YJ1zB51lDHpO1gM?=
 =?us-ascii?Q?Hut46qxd1sv2+PLWWR1DkTS6ulFkQXbmU1STfSGncNVyL8/BCgAnFlgJ6b/5?=
 =?us-ascii?Q?WcftX9JwkiHT4jR/Xl5xKtOqhGjlb9zwJfQGzXX42ko05buVvXG56LHcRIIR?=
 =?us-ascii?Q?g1cKViUC2juJLlo+DMsYXu6Qi4qs0dlD0G75RQq1fmDDhmePYeQ/FznsU68f?=
 =?us-ascii?Q?DXVidg4fCElGZ2s84c/sTt+f3NvyZNPc4R/+xX826wa6VhByNaZtviyEvzL8?=
 =?us-ascii?Q?RuZVLUQVACQgnD19uUJbWI0wNnSIv9SJQfpD2IGwMz1V9qfb0AxO+zPa834T?=
 =?us-ascii?Q?58h0s4yp/sFCY4/4DXsOkOV+tmeniqQ3SoSeCKkT5gTpyGK3QV7z+4X//P6g?=
 =?us-ascii?Q?tVpw3L5eiN+1DygzNuqeXpT/awff0AownEwMrx1fGZks+6R4mh2N6QlHMPeM?=
 =?us-ascii?Q?RNhd0jR4PwrDr0daV4KsgJ8Zfdaeo7Dxh8Fz9WJnlaSoJnnuFV2Ge+z0QMMD?=
 =?us-ascii?Q?DF+cWEn85fcS78BFDd5n0reEq0mNzMQk6Wn4sxCNMJpS0An5GwpJTQVUUrxE?=
 =?us-ascii?Q?XZfTsw5K1RS0qrFhn6VKWbOi6YRPtNDt24KpG/rvtI+9tH8Pa8NxKX6dvjNc?=
 =?us-ascii?Q?A4ryYTxjWm/rTVdnFwLhVkG/H+l/OHO21qPGyhHgLvWsTvny7cPMkvxu+daA?=
 =?us-ascii?Q?EGioAkcIbjtYCVL57JjVVJPET5YJpxGlJITCeQNeOqnX+zoNdZRjNqKVR/DK?=
 =?us-ascii?Q?gATle/3N6c+lxRZrJxC4A54DbCRO0gS7m/BlXRv54aNZWICu8r77TqrwdXPx?=
 =?us-ascii?Q?K4Q9t3VEMK8N6XtC/Ir1om54yxVbZs19ohXpnQJReNDqWsLUIW4opN493yaz?=
 =?us-ascii?Q?RnG0zKrGPWjf7W/64EjWPu6MKMAtB6yL8JhUoM1QReUqrYfbAjRdw/7ras3w?=
 =?us-ascii?Q?N/XccuZ346EkSSvcvRliOfcZTSGwXRYxPpppcwto8g2Tte6gEKf7j19zUhst?=
 =?us-ascii?Q?Egel3qIMAFUz4q7ihFtSfxp+z/lw1ODjhZYr4TzzEDZcU9d3UziySHy/ICR5?=
 =?us-ascii?Q?Fz8Tn4vU1afK4/EwWpm0qm/5VaTZCC2rIMw2jEKWolLUHuoTDqxHpts5ZerB?=
 =?us-ascii?Q?1ht5o/5b5Fc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mqh8crd4iEwwPtLl1lcLFEGaeuxG3cOxTSucYfL9fcfiQbt+Oj/eccaPnhjl?=
 =?us-ascii?Q?HBOkolxPovqUP1lSXlHZybkEONIXCLx9lu1+iX8leBQ9U+mx6L+Qnc/FK8qX?=
 =?us-ascii?Q?9Rm5cYFss7P0b2nLh3t9zkMMgMIaSxZ9URvH3b+DZi92AkXdNsqYMIoc+T6i?=
 =?us-ascii?Q?4J+s0PD/qmlwd7rbnT63E0gVyFw+Akjvm8B1Ly7wyCm3+VOPo7PgSFtW5Xof?=
 =?us-ascii?Q?PAe2Gx0OQtO7qXfPTxRR5gmPLKRul3J3qp7uxUfAtOHcOfR6w73bf/SBfTve?=
 =?us-ascii?Q?95XQfxFF/LpGJCM9ATEphRIemcMeINZ3n2Q+zmqGWOcjMWlPufSmgtiKJ4p+?=
 =?us-ascii?Q?UTwdls6eJlHgV5ikQIjWgrg3cTmBUowhyBFAWuFAijIfBfDf8XsOMaLwL8gm?=
 =?us-ascii?Q?n9sCJ+XK6+6WYr259w8WlZb6fEwg8WQHixDG3kniGQhVtXW7iaUTXClDMPpc?=
 =?us-ascii?Q?E128wHR7lbXYu+mKO/BEkIv5SERGD71rAQVh9QL1wYwHHZVTTStZwp6/hhsp?=
 =?us-ascii?Q?+/FmaKfQdH/FA2SVXXJRvSFNyeIwUaTLDLTibxszgZTWKOxXhrb4NzQSyNFR?=
 =?us-ascii?Q?PbuwUndbq4EiyIT1j/KkFeX48tALbnKhFWD3sprz/XFwEZCFC4IdAM/1E7sO?=
 =?us-ascii?Q?PuSCy3W9HkkQwZiVTFXLEAHXmNh6mNMoXsn55Qxs4vau/HOOEriCUbBn9pto?=
 =?us-ascii?Q?RD0wmStgzW6C/gFkf0hsaKqvHFVwyrpLVhIIZ6sKfcSDeWQWaHlltrloYzlO?=
 =?us-ascii?Q?OTmzxTYNuKQiIO62mRI3480pB2wVZ/flDPi71Zg/tW1LU9JLxb7if/Is032e?=
 =?us-ascii?Q?znIiv7scEt465sgptexCgbmm8SWKi37cLtaz4K7JZ2xzOQ3VGOlf4nxzHluH?=
 =?us-ascii?Q?JdckTeG9WhtOwSj3INRIX4WCJJRAZSYKXO8rNbM9GAQEHbgWWgPbrUvCxCCk?=
 =?us-ascii?Q?JCsFcrNu3SDm2Vb7rPpZVJyDv7cmSsQgKAM6xcdxfB6aJc1oU8QCVlnlt8m1?=
 =?us-ascii?Q?AmrtzkWvaFi+5gTxSBd+RywhyeXW/O7A+R4QRd22jjdel2AIOs7gIP0FoS4K?=
 =?us-ascii?Q?cMgrHIcUW/y27IhXRZlFT8yqjtJW+7t5WSWS+c2inl6ECETs/J43GQNDgaSg?=
 =?us-ascii?Q?wUXL7I250OxXY6BaOSyzHaui8P+qGfuRutk2SHCfzLd6pSMuAEV+TrDCGHUS?=
 =?us-ascii?Q?IXodvI2du9Am7vYMuu/jmN6QQPy0hDB7BfJtIqDEOF8bnDcEWwv7/nOGzv1U?=
 =?us-ascii?Q?LLOVal89dOoOauTrLe4lZA7wcvOEVl+CGr5xvi/1BSvmXunRLNLV0Y1SdKYQ?=
 =?us-ascii?Q?SZlEJfpuinSPM7EO4yONRdifM3MpiAQZ0qJoD+KNgq+tCtEzQadMalflkFtI?=
 =?us-ascii?Q?u0tlstmMZfF1C6yaaVm2mwMRokJtNrVZVSipIfsqVl/x1eUvuG3Ny0qauxvJ?=
 =?us-ascii?Q?agi2vPqt3h9PfyTZZdV9+Uo/cVZk+KEnXlk3rA2vLmdP2LU4boJagiCFH0to?=
 =?us-ascii?Q?iILBA3s6MIWZTaNDCKlpVtjOy9GmG2W/YTHFat27+2O7UmA6y2CAatFJ6JYE?=
 =?us-ascii?Q?onvAfL2hDj0+MzH+pAmiSn7Fhu/qDfROVLtthd5N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20812098-a1ee-44b6-ac70-08ddbd8101c2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 18:06:33.6655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUS2MkOlNaRUTSVpLqEfjukM9ATPCDb62rMJ35MrxXSWbPL0+ApYlIc3deALTRN0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9662

On 7 Jul 2025, at 10:23, Pankaj Raghav (Samsung) wrote:

> From: Pankaj Raghav <p.raghav@samsung.com>
>
> There are many places in the kernel where we need to zeroout larger
> chunks but the maximum segment we can zeroout at a time by ZERO_PAGE
> is limited by PAGE_SIZE.
>
> This concern was raised during the review of adding Large Block Size support
> to XFS[1][2].
>
> This is especially annoying in block devices and filesystems where we
> attach multiple ZERO_PAGEs to the bio in different bvecs. With multipage
> bvec support in block layer, it is much more efficient to send out
> larger zero pages as a part of a single bvec.
>
> Some examples of places in the kernel where this could be useful:
> - blkdev_issue_zero_pages()
> - iomap_dio_zero()
> - vmalloc.c:zero_iter()
> - rxperf_process_call()
> - fscrypt_zeroout_range_inline_crypt()
> - bch2_checksum_update()
> ...
>
> We already have huge_zero_folio that is allocated on demand, and it will be
> deallocated by the shrinker if there are no users of it left.
>
> At moment, huge_zero_folio infrastructure refcount is tied to the process
> lifetime that created it. This might not work for bio layer as the completions
> can be async and the process that created the huge_zero_folio might no
> longer be alive.
>
> Add a config option STATIC_PMD_ZERO_PAGE that will always allocate
> the huge_zero_folio via memblock, and it will never be freed.

Do the above users want a PMD sized zero page or a 2MB zero page?
Because on systems with non 4KB base page size, e.g., ARM64 with 64KB
base page, PMD size is different. ARM64 with 64KB base page has
512MB PMD sized pages. Having STATIC_PMD_ZERO_PAGE means losing
half GB memory. I am not sure if it is acceptable.

Best Regards,
Yan, Zi

