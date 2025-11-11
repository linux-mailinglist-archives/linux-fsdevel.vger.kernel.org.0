Return-Path: <linux-fsdevel+bounces-67857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E4FC4C1DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 08:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1C104E1DD0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 07:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B202B32ABC7;
	Tue, 11 Nov 2025 07:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="otE5DTKK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lOyDYiTD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1850741C69;
	Tue, 11 Nov 2025 07:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762846361; cv=fail; b=OVgvYAbDwoNsy5N2+CJ5kVF/pnWLQowHO8TMlxGrEGlB54vSxn0eztn4lCVGATFE90FF2c6sL5+nm4GHzVROSI8XTkbMhX6YSUl8u1HSQAb0ZGAhVxzPub3VD1BbTEBoutW/pzeZclxPOu0G2jx48DeEHu/g1SipIPliScrFjXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762846361; c=relaxed/simple;
	bh=42dAZT7y7+XmWQ7Irb1uFrGqvfncgmlO+MkoefJ53QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IBQfWn3EUqJCc/niU7IwtNvP2BHVLRjyepY05MkXAVve6oBmJb/qD4Z3ga46mEYFgmDw5dEDpCW4gjXpKVfc+ivWkEK1R0lInKZubw2ohx2cfbCjbTQgNyTOUTuV0a7a1vTweT/jdMnYH32ijdoK3fL9IJ7BKFxzNQMFKLR9/zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=otE5DTKK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lOyDYiTD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB7RxsL011339;
	Tue, 11 Nov 2025 07:31:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=aHR9abzKRryvCTD2VkfYLswZVKcwYyC8hxN0ugfAs0g=; b=
	otE5DTKKVoWjmYkGoAESfOyfA6vSSrVm3ox40We03I3yduHShq7mqp9n2vEVUQ5Q
	z/NxxtzkMCKt0R6d4zKWFdEZY51+zQlhDuYi/G9ALV9Cxdlkflqg+KwiTTNQig8/
	s0SNLCNc3q8ODRdpoXqyxIgqGgTmGFH8rgsIoa67SluuhfItqJh8c175W+m8xibr
	jmUXAYVunzZKvAkyCukipq5YpFPp8uRZPX3rVTp2aCgOjEqYNdDDVA/4HqiTxr7e
	aNknlBNyN8rTXFBpRyG1BD7uBS5efpLBDZfKHbbUhz5e6/wmYOdZb1E31xoRJwnA
	t2TMthuSzxyyiHCqRJYzCw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abrpb8qj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 07:31:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB5C3bC039983;
	Tue, 11 Nov 2025 07:31:32 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010034.outbound.protection.outlook.com [52.101.61.34])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va967nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 07:31:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9VV4CDScqrwTaEYSMBLSGGhZAjrbYsLDgRpmoC1iq8BA89FklwSG06ie4MtS5zeA0KP6akdXEX2Pxwc/oy1uXvhVa8oiD6sCn0V7bUFsB4K0Kogv2Knfxg0VYgxiuyGOgZa3tgjvLuTtbDXfOP1dI+qwOPvtw2jzp9Qm0no6fHPP1Qk++uJXdwjnxYZYPhYpHtPjtxpW0ThCMFol75GDJsYKDrOtFugkpGBVv1qpTsi9ObSM2y/+9GQQG60gJZsMBJnomhHZNZ28eTrwyxPtplMLgIqeFMUioR53V961MfOnAnKJBiTW/GIZzXe6/XhnyZ2Ge9zQ+z1gW8zOgCGhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHR9abzKRryvCTD2VkfYLswZVKcwYyC8hxN0ugfAs0g=;
 b=cObX05eOv79InISHIDKHeMB5t/2zVqCJw/EmUjQbv3HKmA/kYLb6rS+IoXzs9W49IuyeNOyfE+G/1AaHrM3qHHtjnQ+Ij5bTG29ufEzdbQYrgGwBySJCXHhcajGpR0w/WrVZi8SQwKuofaJ0yYkahP+H0lHJVns70bmM6FuAItH+wjuVaEWe0Am8zUO6NXYSQ3+xXOicvfJra6zkCnqzKDAEfsOoLY3hSeHYG8Abt0AXZ8jKhhHfzaXKi1uBMVLZIAAa3+JEubITp+EEsFjw6QUXXrPFsJs/pD9CrAwq30VGYZDwOCeLtNT3t5V/m+qaOwj3CYFFptFo7DYZ5vFn/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHR9abzKRryvCTD2VkfYLswZVKcwYyC8hxN0ugfAs0g=;
 b=lOyDYiTDQL2qyQJlNyxBHMuhZsvMbWlMpzeaIRVA+w8Sf4voSzkBJy1SKd3vr56htHyEPVN4ms4rxGhoYvcNf7hfC1dz+vJsmVcbzdMLpmkv0k0MpdBCEag45+3MjyY823VZogmsyape2Wm62YwEMSjq/pn+tpqJc/+Mh4/iIR4=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DM3PR10MB7947.namprd10.prod.outlook.com (2603:10b6:0:40::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 07:31:28 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 07:31:28 +0000
Date: Tue, 11 Nov 2025 07:31:25 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v3 02/16] mm: introduce leaf entry type and use to
 simplify leaf entry logic
Message-ID: <a2063bd3-8030-4c80-a361-c84274b5db99@lucifer.local>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
 <c879383aac77d96a03e4d38f7daba893cd35fc76.1762812360.git.lorenzo.stoakes@oracle.com>
 <3E8190A4-5B17-4A36-9025-F7E4FF1127AB@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E8190A4-5B17-4A36-9025-F7E4FF1127AB@nvidia.com>
X-ClientProxiedBy: LO2P265CA0264.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::36) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DM3PR10MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: 779d13b1-c3f1-43da-e67d-08de20f45386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWxRMFF3WVFqem1yekhPdVA2T2JaK3BtbFRUdVRlQm5kNFhpUkFaSHg5WlpS?=
 =?utf-8?B?NzhIS0NmZmRmOHU5dHBMV3gxSHozVmR0dDJzcjdhRTdiRmNZNjZON09neUpv?=
 =?utf-8?B?NDlZSVMwSlVtcS9lOU45dE4yWVVJZnVmK2d6SGdqalB2T0l4L1RTbFBMNWpr?=
 =?utf-8?B?WHpodmMyVk11bFFKV3A5Z2NnQUNsc3RCRGdRYkxoVHZtbDBFM0xVQXJRUS9l?=
 =?utf-8?B?NEVBcUpna1hWSkkyWTNhZ0FQQ3BUbmtGekkreWZucks0Q2lwNml4elZrdE1p?=
 =?utf-8?B?ajA2SzJieStPWTg2ZFZpRzZBY0RSbkJSbVlGZDZHNVU1Qnh6VjlSV2o3ODJB?=
 =?utf-8?B?aVlJWmRSY0tJNjZRMjZxM1Vzb3ZrTFI5OXYyaWNhYTdkUlJxK2xUeGw2QnNR?=
 =?utf-8?B?ajNLWnNtODdaRGkwa0dSWXpWM00rWWpZUFdWaU42NzRJWmE1T2ZQSlM0djBs?=
 =?utf-8?B?NEdJaWE1Q242NHJzSXNNWGRYaU4zdjJEYVNGM2lKOStyZEZTekdJOUpPd2Nv?=
 =?utf-8?B?QU9aTkJydnpya3ZLYW9GWlpCYjJWdFZaM1ozSnNyem54OVhXS1pHaW5ac3JR?=
 =?utf-8?B?Tm9VSUVWMVU0R2pySnpSNW5GcER5Nk5scXJIb0kyZjdyVmRwYk53YWxUUFc4?=
 =?utf-8?B?bXZHVlZMSHlWZTZwbitjL0NnRmU2RGtQamJncGdhZVpPaENaT1NYb2N6L2pP?=
 =?utf-8?B?cFR1eGNyaGxwREtWaDdHYXZpTGR3em1tOW8zaHBOQnZnZzExd2ZsM1dJN1JG?=
 =?utf-8?B?SEZ3S1RocGxteHl4eHJjRmNNNEcyRFZMZW01bFdjd2dnQndJd3ZHMWlCNk9a?=
 =?utf-8?B?WDg0OFF5bjgzZ2NVUk1EK0tHZndUSU5MTDJMUEQvWkF1NVA5VHpwSVg1VXNW?=
 =?utf-8?B?cnV2bmZXZFd3MVVXY2xLVTFDTUliR0gzNk9va0piS0N2VnZTOVdDdHpraWZl?=
 =?utf-8?B?bWpGYkNVcitaL3YrdERrYS9POWdxbkxSK2lrVFZmNjcwRGFoVGJxNHB4U2RN?=
 =?utf-8?B?ald3TXRtbVZidXpsOXBmNHFDS0NhNFByWC96NTRCMHovN3JYU2hjWWtPS0VJ?=
 =?utf-8?B?T3pqeEIydExYQ3c0Z2U3S01WcHo0UTdTUlNLMlZOdHdZNnR5UXhuV0hvbnRs?=
 =?utf-8?B?L0FmV2s2L3oxczg2bS9mK1dLaEpjZjhiWlFGci9CbktubXZuMXFDNkZsWFBO?=
 =?utf-8?B?Q29wQnMrR0JWcFp1NURkalZDZW5aTkxUWTZxbE9KaEZ1YXRhN2NvT3BRT1lq?=
 =?utf-8?B?QnNiZ2NxSXIxcDZueU9SYzBJUWppQlFmbUtxaW1SWE11VTRJcDV4aGtROU5N?=
 =?utf-8?B?eGZYUlhJUDRiTkZNQUwrdlllQlpsS2tFL2JYVm8xNUcyeUFHUVZFbmxXUlFR?=
 =?utf-8?B?RlU2MFhqU0JSM0xsNzFsalc5Ym1WUlBFZXVidEVHMHNjR0Z6UzBlWkJvdHg1?=
 =?utf-8?B?citFd2JlNm40Y25tTlpQcGI1bFNpQk5XN1haeDBhbmpsNWhnL1Q5MHZ2czVu?=
 =?utf-8?B?VWdIVVA0YkR1UlE5ZVU4ODVHdnlXWVpFUkZmNm9pUEx1ajBoNVppSlNvcGIr?=
 =?utf-8?B?TlZkRXd4cUtLbFU3VmI0dXhwWmp2R1VtR0sweE5RK1VsaDcyaUdoazQreGlq?=
 =?utf-8?B?NXRvc0xkOG96VE02Um9leHZUbDMvNjA4QXpUNHV5ZlhXRTdmM0dXMlBpdEVF?=
 =?utf-8?B?QlptNHcwbEQvZkpBRFFPYXp1NWI4VVFEVHI5VloxSlJUQWdJZnM5SGsreHBz?=
 =?utf-8?B?aFNJSUlYT1g5OStSbzlEQWE5NjJEbmpodEFuVzl5NWR1Ui9CVXF2UkZCOGdr?=
 =?utf-8?B?R0s1ajJGUFFuOGExd294Ny9jVEV4RnY1VTl5U2QyaTdWQWpwUGM2d0hDeU54?=
 =?utf-8?B?bmdZSDkrbnVNOUVEV1pDT0Y4cjlZNmc1bnNneGZsc1NuZHk3Z0xlZkQwSm5U?=
 =?utf-8?Q?DJhk41TlX4A7hJcS8t8ueLGEr78jl9eM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGxxVldpWVNPRmZ4a0JkakFDekpZZWdPdmVpaTJGa01hd2VGNWZ1eERyYTU5?=
 =?utf-8?B?KzBSc29kd1g5bXNMaktCbXpjRmF2SEVsazl0cmVzYlhmWURESkl1c1FpemFu?=
 =?utf-8?B?cU9QT3hKSXZmSGE2cTZaM2dWb1dreG90MmhHc3hwYnlxTkdyTWxzblk3T1hj?=
 =?utf-8?B?SThpWExrMWFFV1lzZElIN2VscCs5VTVhRFMvOVpNZjJuQWRPQW1jQ0JxUG9v?=
 =?utf-8?B?NGRod2FXOThKVy96TjJNNzBQOWdvaWoxQW92QXlDVWVkcTJNRUlRdXpndktQ?=
 =?utf-8?B?cVJ4dE1kTElZQUNENU9ZVmRYY24wcm9Wa29BQW9CTUtLL3o0Q2JocUwzbkYv?=
 =?utf-8?B?Q2tzMHd6bTV5VWtRYzZ3Zmp1bGV4azh5THNqUFdmOXBVREpPMHBoWWlraU5p?=
 =?utf-8?B?TWVpb2ZyUGJKR3owMEo4MURWd3ZDby9IT3RxL044bnRUT1N4SkIxcjFDWEEy?=
 =?utf-8?B?SURsOVBpaHRXSmw1TnRGY0JDTG9lQTNTaWcvcTlseVhLWVRqaXhxWXA2MllF?=
 =?utf-8?B?QzhBNUlQMFJveDRlajFWTk1QLzZpMVBteUExUkhQaXVacmM1MVFab1M2UU16?=
 =?utf-8?B?dHZ1WXgrdGVLaGpsNVRFMFFicDROMTdhNm5qLzIza21XdUp0WWxvYjhQSitF?=
 =?utf-8?B?VlNKWVF2Sy83OUNOQW5qVk9KWE4zdytNYmtwNXRsdVhRbWJMNmJMYmJEeHJO?=
 =?utf-8?B?VGpqbWdUZHVxNno5eDdqa3hqS1RkZDdnOHpNTlF3NkswYzFGdnpNM1RTb3Qz?=
 =?utf-8?B?eEJ1bXpEcGRUTGRJVlZsTjF2SGw4RXJ1OHNGYTBnQkhoV0RXNHYwTlpQZk84?=
 =?utf-8?B?NHNQMGtJVTU1YWxJVjFjUzdDT0Q4R3hUTStNa050ZzNTTTFqNlNlQTh1bktk?=
 =?utf-8?B?ZGNVbmRoMDRqWi9EVkVOYm1vaFI2T3pjaFpvQ1hkOGh3SkxCanpHR21Kc2pS?=
 =?utf-8?B?YTJmcC93VTB1U0puQnFmdnBBRkhLZ2N4QXJ6cExFcG9peFU3TWxTcSs4emJT?=
 =?utf-8?B?RWQ1NnEzUlVBZ0kzR0ZWV0N4bDNZeENSUFFHQXhPMUR2bzd4ODlwS0lJQ2JJ?=
 =?utf-8?B?VS9aSGhqSFFoNWpNV21kV3V2ejZTTCt2Q2FpNkRIUFc3YU9OZkxIVzZXcmdu?=
 =?utf-8?B?ZlQ1ZVBuSlJnZTltOStaU1Z6RnlGOFExSDJhMHIyRks1SjEyN3VjbTVoKzJQ?=
 =?utf-8?B?MU1sakZlazdNQkxkd0V2ZEN0RURVL01lSTZJckVvVGNIWkdURHEwNDdaMzVM?=
 =?utf-8?B?OXh6Q1dOY0owdEozeVc1WDAya2FndU9jOU5FVVI0RndPYk9xNDEybFUxTWxm?=
 =?utf-8?B?TWcveEZLMTl6SnBFWW5KQUxtckhOcnhNN0xER2lnZmd0bHhRNmpGZUF6Y1hw?=
 =?utf-8?B?eVdXdHdPR3ZPSGRGcDk2NWVvdm5ZeTFFTkxLQXV5QkcxeWxCbFhEWkNhYzA4?=
 =?utf-8?B?VWlhWUY3Zy8zaDZGNkl1OW9NSzlTWEtJL2VLUXdWT1lIYVJHMDV4M25yWXZH?=
 =?utf-8?B?dXNFbGRlMEdkYkw1bzdBSFp6MlBhMzVEL3hXYml4clo1MHdoWTd3Vm9GQ2c4?=
 =?utf-8?B?VnEvblI1eDhnSjc3YzFNU3lZV1c5bDV1cys2Q3BtZlN6bUpMSFhrSkdOd2ZC?=
 =?utf-8?B?QTR0dFd4OEFrcGVlaVgrYkxpcFBmOUZjZE5tRmFhc0tJRk10UzQyMDloa3Rh?=
 =?utf-8?B?VDVqelhuRDFYWHhNblRuNVRXOHdqUEdzSVdqaUtqVDlMdkVma3FPZjRBOEhk?=
 =?utf-8?B?NFBtdzhCWFM4QmNHMUNLZThaQll3QVNDQWJJQ3JKdW1nK1hSVGZrRkdlcDUv?=
 =?utf-8?B?dW83ZndIeEZBeW5yYU9hNjNCNitrcGg1bHFSZGxWc2g4TUtRYitPQm1sRGJu?=
 =?utf-8?B?UEdCZEl5eTZRM2pYM1F6eE12eEYyV3hZSXM4V1MrZ0tHd2xwRkhySnZ2NTJy?=
 =?utf-8?B?VGltYmJwSlNwSXlTZHFPbEpqRmE4S0ZiQW5xN2dKRzhGdHhldnNuK2ZSMFRZ?=
 =?utf-8?B?emp4UXNVWU1TMVJCSS8zZ2xITmo5LzZ2aHBXV01GT1lMaUQxRWlma05XVnlu?=
 =?utf-8?B?WWFiS2V1M1BndjkwUDUrL0hYeDFUOVl0cmNZTk40aEd2WjVZbWo3dGtWUDZF?=
 =?utf-8?B?dUluczE4NG5KRy9zVUhZQTJKZTVFYnIraFBUMU9CR2xGWUV6M2ZGYWh6YUhn?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oFhjCVgwHz0IIHaQP+f1+uvOyc8ed1Lv5mVP/yHBF1RAoAVqP07pmGkPPs0AfShHWiU9+z0ZeGNGDW0ipB2c5KY/VBNpL+Bhp9mGtRrkMbLB5GZkL+Sm0RktiN3AVE1X2kj4FUnqf++jcENOM5cKntHQjQV9gNeo/xhjJrIUdYBFNXAP1G6wWjLiSJFAIBMyzXZh3amUWxAFm2w1+wi7iBi72gTG7f9Pqf4O9DJAIyF8tQhhvx9nFObJHhL4wD4dlQSeCNxjCDDcPQh2nOk5ZaeEajdp0b7k9n8vpUTqxM/NZGLOiw2ClUIjrKbt5fQU4cPsVzlw6RwjbZIe69QaaC3V8RqqgApnZ5NK5xz8DiY6DxvFf4j34u0WM6z+OPmcdNxvSwtht+dS9sHLrFnQGUMWYBwjAdY5YJVLEgBXi9bUf4B0L+IdqVjrLzDsT+1C9askLZJEipia1lXUMLxK8/XjweQ5PDx6l1OmTAEdqxLYiYzI14hJaXRcjJ3/VDV/BN+jBcNHW8A2zVGROxlEFhM1Ev4HHSmXPDvB2tg3KdMrRFgtnhyNQUp+1G9BgFEv1gUPzv+rP192u0rmOLCIUDlMSIiG0zRhfSdMWNjxIbk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779d13b1-c3f1-43da-e67d-08de20f45386
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 07:31:28.0851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pyGj+DhqJwRLDjZRD+1npjTqn2HgaJtklo6lzC6q8x4jQVIxlmmER+wnrDjLRi+vYOVxgprCpgsY5CkOsEyMirYwnCpQPlDc1OoJl4xkCoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7947
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511110057
X-Proofpoint-GUID: 0aIaCc5ROwqAPSiTBafI57zybAlh5_0D
X-Proofpoint-ORIG-GUID: 0aIaCc5ROwqAPSiTBafI57zybAlh5_0D
X-Authority-Analysis: v=2.4 cv=FqEIPmrq c=1 sm=1 tr=0 ts=6912e655 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=sBcB2_ExJjnV7F4PYI0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE4OSBTYWx0ZWRfXzz/FAA4Z3exO
 nyPJ8ZEptEwnrILU0Ulf5GgKfN82p0ccchM8O90g6UUtzE9H/TEUuJ2oKtmC1gEIRJI2oaTG8fM
 JuLEH7lzGnZu/11iE/E83+Z/P7IUFBR52moJTw/xmH4z3SH9qtJu829fRWeTfW7DZX2G34nxOkp
 eCNRJNddq1X/pvWIs4lIUlVCQUB5vYU5K1frw+YfZHw5sjDP3a04Bie27/NA6k3D9IHHXfXxnqx
 OEeHRFWn/CrHYo/rZKErvrMSfeWeknB5rfJn2NuzmfyMymdZYdLIxSNePWcixYyFgU0lRySUM/O
 wpWm5tMOD0q+RERSIiZhWnVAErc0rzoI2rowDb89Z2az00y/XIe5XBwGXsD7j0drhBtJMFmwc4e
 +q2fOn7fDk9hTVz7n7Vam8XpBQSqyA==

On Mon, Nov 10, 2025 at 10:56:33PM -0500, Zi Yan wrote:
> On 10 Nov 2025, at 17:21, Lorenzo Stoakes wrote:
>
> > The kernel maintains leaf page table entries which contain either:
> >
> > - Nothing ('none' entries)
> > - Present entries (that is stuff the hardware can navigate without fault)
> > - Everything else that will cause a fault which the kernel handles
> >
> > In the 'everything else' group we include swap entries, but we also include
> > a number of other things such as migration entries, device private entries
> > and marker entries.
> >
> > Unfortunately this 'everything else' group expresses everything through
> > a swp_entry_t type, and these entries are referred to swap entries even
> > though they may well not contain a... swap entry.
> >
> > This is compounded by the rather mind-boggling concept of a non-swap swap
> > entry (checked via non_swap_entry()) and the means by which we twist and
> > turn to satisfy this.
> >
> > This patch lays the foundation for reducing this confusion.
> >
> > We refer to 'everything else' as a 'software-define leaf entry' or
> > 'softleaf'. for short And in fact we scoop up the 'none' entries into this
> > concept also so we are left with:
> >
> > - Present entries.
> > - Softleaf entries (which may be empty).
> >
> > This allows for radical simplification across the board - one can simply
> > convert any leaf page table entry to a leaf entry via softleaf_from_pte().
> >
> > If the entry is present, we return an empty leaf entry, so it is assumed
> > the caller is aware that they must differentiate between the two categories
> > of page table entries, checking for the former via pte_present().
> >
> > As a result, we can eliminate a number of places where we would otherwise
> > need to use predicates to see if we can proceed with leaf page table entry
> > conversion and instead just go ahead and do it unconditionally.
> >
> > We do so where we can, adjusting surrounding logic as necessary to
> > integrate the new softleaf_t logic as far as seems reasonable at this
> > stage.
> >
> > We typedef swp_entry_t to softleaf_t for the time being until the
> > conversion can be complete, meaning everything remains compatible
> > regardless of which type is used. We will eventually remove swp_entry_t
> > when the conversion is complete.
> >
> > We introduce a new header file to keep things clear - leafops.h - this
> > imports swapops.h so can direct replace swapops imports without issue, and
> > we do so in all the files that require it.
> >
> > Additionally, add new leafops.h file to core mm maintainers entry.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  MAINTAINERS                   |   1 +
> >  fs/proc/task_mmu.c            |  26 +--
> >  fs/userfaultfd.c              |   6 +-
> >  include/linux/leafops.h       | 387 ++++++++++++++++++++++++++++++++++
> >  include/linux/mm_inline.h     |   6 +-
> >  include/linux/mm_types.h      |  25 +++
> >  include/linux/swapops.h       |  28 ---
> >  include/linux/userfaultfd_k.h |  51 +----
> >  mm/hmm.c                      |   2 +-
> >  mm/hugetlb.c                  |  37 ++--
> >  mm/madvise.c                  |  16 +-
> >  mm/memory.c                   |  41 ++--
> >  mm/mincore.c                  |   6 +-
> >  mm/mprotect.c                 |   6 +-
> >  mm/mremap.c                   |   4 +-
> >  mm/page_vma_mapped.c          |  11 +-
> >  mm/shmem.c                    |   7 +-
> >  mm/userfaultfd.c              |   6 +-
> >  18 files changed, 502 insertions(+), 164 deletions(-)
> >  create mode 100644 include/linux/leafops.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2628431dcdfe..314910a70bbf 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16257,6 +16257,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> >  F:	include/linux/gfp.h
> >  F:	include/linux/gfp_types.h
> >  F:	include/linux/highmem.h
> > +F:	include/linux/leafops.h
> >  F:	include/linux/memory.h
> >  F:	include/linux/mm.h
> >  F:	include/linux/mm_*.h
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index fc35a0543f01..24d26b49d870 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -14,7 +14,7 @@
> >  #include <linux/rmap.h>
> >  #include <linux/swap.h>
> >  #include <linux/sched/mm.h>
> > -#include <linux/swapops.h>
> > +#include <linux/leafops.h>
> >  #include <linux/mmu_notifier.h>
> >  #include <linux/page_idle.h>
> >  #include <linux/shmem_fs.h>
> > @@ -1230,11 +1230,11 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
> >  	if (pte_present(ptent)) {
> >  		folio = page_folio(pte_page(ptent));
> >  		present = true;
> > -	} else if (is_swap_pte(ptent)) {
> > -		swp_entry_t swpent = pte_to_swp_entry(ptent);
> > +	} else {
> > +		const softleaf_t entry = softleaf_from_pte(ptent);
> >
> > -		if (is_pfn_swap_entry(swpent))
> > -			folio = pfn_swap_entry_folio(swpent);
> > +		if (softleaf_has_pfn(entry))
> > +			folio = softleaf_to_folio(entry);
> >  	}
> >
> >  	if (folio) {
>
> <snip>
>
> >
> > @@ -2330,18 +2330,18 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
> >  		if (pte_soft_dirty(pte))
> >  			categories |= PAGE_IS_SOFT_DIRTY;
> >  	} else if (is_swap_pte(pte)) {
>
> This should be just “else” like smaps_hugetlb_range()’s change, right?

This is code this patch doesn't touch? :) It's not my fault...

Actually in a follow-up patch I do exactly this, taking advantage of the fact
that we handle none entries automatically in softleaf_from_pte().

But it's onne step at a time here to make it easier to review/life easier on
bisect in case there's any mistakes.

>
> > -		swp_entry_t swp;
> > +		softleaf_t entry;
> >
> >  		categories |= PAGE_IS_SWAPPED;
> >  		if (!pte_swp_uffd_wp_any(pte))
> >  			categories |= PAGE_IS_WRITTEN;
> >
> > -		swp = pte_to_swp_entry(pte);
> > -		if (is_guard_swp_entry(swp))
> > +		entry = softleaf_from_pte(pte);
> > +		if (softleaf_is_guard_marker(entry))
> >  			categories |= PAGE_IS_GUARD;
> >  		else if ((p->masks_of_interest & PAGE_IS_FILE) &&
> > -			 is_pfn_swap_entry(swp) &&
> > -			 !folio_test_anon(pfn_swap_entry_folio(swp)))
> > +			 softleaf_has_pfn(entry) &&
> > +			 !folio_test_anon(softleaf_to_folio(entry)))
> >  			categories |= PAGE_IS_FILE;
> >
> >  		if (pte_swp_soft_dirty(pte))
>
> <snip>
>
> > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> > index 137ce27ff68c..be20468fb5a9 100644
> > --- a/mm/page_vma_mapped.c
> > +++ b/mm/page_vma_mapped.c
> > @@ -3,7 +3,7 @@
> >  #include <linux/rmap.h>
> >  #include <linux/hugetlb.h>
> >  #include <linux/swap.h>
> > -#include <linux/swapops.h>
> > +#include <linux/leafops.h>
> >
> >  #include "internal.h"
> >
> > @@ -107,15 +107,12 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
> >  	pte_t ptent = ptep_get(pvmw->pte);
> >
> >  	if (pvmw->flags & PVMW_MIGRATION) {
> > -		swp_entry_t entry;
> > -		if (!is_swap_pte(ptent))
> > -			return false;
> > -		entry = pte_to_swp_entry(ptent);
> > +		const softleaf_t entry = softleaf_from_pte(ptent);
>
> We do not need is_swap_pte() check here because softleaf_from_pte()
> does the check. Just trying to reason the code with myself here.

Right, see the next patch :) I'm laying the groundwork for us to be able to do
that.

>
> >
> > -		if (!is_migration_entry(entry))
> > +		if (!softleaf_is_migration(entry))
> >  			return false;
> >
> > -		pfn = swp_offset_pfn(entry);
> > +		pfn = softleaf_to_pfn(entry);
> >  	} else if (is_swap_pte(ptent)) {
> >  		swp_entry_t entry;
> >
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 6580f3cd24bb..395ca58ac4a5 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -66,7 +66,7 @@ static struct vfsmount *shm_mnt __ro_after_init;
> >  #include <linux/falloc.h>
> >  #include <linux/splice.h>
> >  #include <linux/security.h>
> > -#include <linux/swapops.h>
> > +#include <linux/leafops.h>
> >  #include <linux/mempolicy.h>
> >  #include <linux/namei.h>
> >  #include <linux/ctype.h>
> > @@ -2286,7 +2286,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
> >  	struct address_space *mapping = inode->i_mapping;
> >  	struct mm_struct *fault_mm = vma ? vma->vm_mm : NULL;
> >  	struct shmem_inode_info *info = SHMEM_I(inode);
> > -	swp_entry_t swap, index_entry;
> > +	swp_entry_t swap;
> > +	softleaf_t index_entry;
> >  	struct swap_info_struct *si;
> >  	struct folio *folio = NULL;
> >  	bool skip_swapcache = false;
> > @@ -2298,7 +2299,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
> >  	swap = index_entry;
> >  	*foliop = NULL;
> >
> > -	if (is_poisoned_swp_entry(index_entry))
> > +	if (softleaf_is_poison_marker(index_entry))
> >  		return -EIO;
> >
> >  	si = get_swap_device(index_entry);
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index cc4ce205bbec..055ec1050776 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -10,7 +10,7 @@
> >  #include <linux/pagemap.h>
> >  #include <linux/rmap.h>
> >  #include <linux/swap.h>
> > -#include <linux/swapops.h>
> > +#include <linux/leafops.h>
> >  #include <linux/userfaultfd_k.h>
> >  #include <linux/mmu_notifier.h>
> >  #include <linux/hugetlb.h>
> > @@ -208,7 +208,7 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
> >  	 * MISSING|WP registered, we firstly wr-protect a none pte which has no
> >  	 * page cache page backing it, then access the page.
> >  	 */
> > -	if (!pte_none(dst_ptep) && !is_uffd_pte_marker(dst_ptep))
> > +	if (!pte_none(dst_ptep) && !pte_is_uffd_marker(dst_ptep))
> >  		goto out_unlock;
> >
> >  	if (page_in_cache) {
> > @@ -590,7 +590,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
> >  		if (!uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE)) {
> >  			const pte_t ptep = huge_ptep_get(dst_mm, dst_addr, dst_pte);
> >
> > -			if (!huge_pte_none(ptep) && !is_uffd_pte_marker(ptep)) {
> > +			if (!huge_pte_none(ptep) && !pte_is_uffd_marker(ptep)) {
> >  				err = -EEXIST;
> >  				hugetlb_vma_unlock_read(dst_vma);
> >  				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>
> The rest of the code looks good to me. I will check it again once
> you fix the commit log and comments. Thank you for working on this.

As I said before I'm not respinning this entire series to change every single
reference to present/none to include one or several paragraphs about how we
hacked in protnone and other such things.

If I have to respin the series, I'll add a reference in the commit log.

I beleive the only pertinent comment is:

+ * If referencing another page table or a data page then the page table entry is
+ * pertinent to hardware - that is it tells the hardware how to decode the page
+ * table entry.

From the softleaf_t kdoc.

I think this is fine as-is - protnone entries or _PAGE_PSE-only PMD entries
_are_ pertinent to the hardware fault handler, literally every bit except for
the present bit are set ready for the hardware to decode, telling it how to
decode the leaf entry.

Rather than adding additional confusion by citing this stuff and probably
whatever awful architecture-specific stuff lurks in the arch/ directory I think
we are fine as-is.

Again we decided as a community to hack this stuff in so we as a community have
to live with it like a guy who puts a chimney on his car :)

(mm has many such chimneys on a car that only Homer Simpson would be proud of)

>
> Best Regards,
> Yan, Zi

Cheers, Lorenzo

