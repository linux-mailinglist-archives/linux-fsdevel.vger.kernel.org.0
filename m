Return-Path: <linux-fsdevel+bounces-68504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02880C5D826
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 15:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727CA421D1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 14:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F003731AF2D;
	Fri, 14 Nov 2025 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DnwPZGHU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bO83uRH5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A680623EA9D;
	Fri, 14 Nov 2025 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763129588; cv=fail; b=Tt4vVd4UL/XPxeTB7kz14Pw/VW2Jy8tgAE52Er4aIWJyx4IdO6CK/WCXI6ADn965dX1u0xjBOLCHjT8uxpNpEhddHFVlC9c1A0Hx6vvQ84wBhIaxGPndg5Q8uhbHPilSIVkMifO3gC7XkgSASNEs5S/xv8VH1M2tsQiAwhlD0DA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763129588; c=relaxed/simple;
	bh=R8cmZpTp19JX79uylDAlsgHGnfIyG9GrQrH0lPFA5YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D3J9o+JphkdzmDZCgwPDxWHDonkuIec9KqOeft6WjuQansV3iFUCUXiR9DCrpYpvF9TEmw2iIxRjD1RWtssgtlmqfJG7NHzPJU7ZgQDJbT52zt2CdhXXBVlPQ9S6dEvERecp5w1R8fWKh1noRU5emez9PFCFC2LV6S0rOF6cO4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DnwPZGHU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bO83uRH5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AECu97W008823;
	Fri, 14 Nov 2025 14:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3WFEU+gPgKLq2JFIBkQtdHjeMWNZJv49ZBbGwiXBD6o=; b=
	DnwPZGHUCYh4BdoDVrfRbWPY7MO4Hyq8p3X9KMuKsby0qmtb1UbrlyvGDV/4lWSM
	PrVO0vm1H4Io1OXlnQ+FZcZtJkPa4BTFVb3blMuwv7LwQopnINUF/Ohnc+H4s7Mu
	yQg0Kmxr+F+IPUzFnDpWYCVegLHUM66pCwudrEfG/+hvb1HRG1BrrR2pgt0b1/i4
	1S3h8Cax5+JgOXbi8dgiUpJaX9Q+xUprQwwHLbylpPLupVlwX//rPsHpuQ1tPlLN
	syu1mre2j3eC5neW1o53lNiNEjK3GBmz1qL2l9XZcev9B2OmCE6XLiNQZa1G4488
	S/WtfvRR7L/cOFGU4efHpQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4adr8v17vv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 14:11:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AEE97tQ027689;
	Fri, 14 Nov 2025 14:11:37 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011063.outbound.protection.outlook.com [40.93.194.63])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vahnn6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 14:11:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggQaFbYDbg6RubE5LPdqDVM9ss5xgOKtzsf0FRFkm0Zj7of43pRbE/kWlGB7wOqy5BghuuMLzPLWwrAKYiyHqbwUGe5RnQ2ie18K29qLzfVvPIuzilNpKrEh09forjv8uxTdmK84yBVeNzg1wrLkJaRkhpxUjtzF3OYLmMyo4lEmarnAfmOEsWBoJo/jEgfdK40ro8a89LK34y7CmB9jLXNL64OiFqpsFZuZnHxkZwREOZzWEM+8ZOO3ZwU+z3egwMoBHKXqiwGeyGcj9VKjQEDX8LUewU9G2/6+xhejmi35DdUA5wfQTFaIEDlZ+MUBjanQpMbyZqL7v8dyAVIrFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WFEU+gPgKLq2JFIBkQtdHjeMWNZJv49ZBbGwiXBD6o=;
 b=knWqqh0icKjSaCZ+lAef0nLhY9EhnGVsbcTzknx1V91tElKRQm3XOJfN4AjbSiBF7f1I6DZL98u1JMjQaJ08CRxYxcZ5+Rt1Te2vwvHMj18Ly/8I8aVVdTsQ87FyaePaaKOH2ZYGr9+WXNPHEWV2IkeuFSCrk3cxdfcWQocpN/AkfenxCsoRXwmjU1s+SPFoeDnJ2KpsDrjgZbB+Mw4lz+yQWhliPxqAaGzK3s4jCRmXqKduMaRnzUtqToebEyIeWJQqlPuzPxMY0H2TaJ3xJUnF3ZBruSCERq/+66t35ddfZxKNXh3Df8w1wgCtBZ1FwZ83c5C3l5CcMf4z91sCEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WFEU+gPgKLq2JFIBkQtdHjeMWNZJv49ZBbGwiXBD6o=;
 b=bO83uRH52oxAu00c/mA1PNPBdgDdSNKZa6Fr4Ss4RHXjnYxrKhcJtrE0s7KjhE8l3ms3gWSyMN4E35sVzgaNvvVpN2qzT9kOP631Y8qLLGttJMiUJuhRpjMIWZohXyNRUYB5XG00VHu6Qa9ziZOT0wPYo0Jo4InTdc7vxUPetVo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB997571.namprd10.prod.outlook.com (2603:10b6:510:383::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 14:11:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 14:11:33 +0000
Date: Fri, 14 Nov 2025 14:11:31 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Peter Xu <peterx@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Kees Cook <kees@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        David Rientjes <rientjes@google.com>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
        rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/4] mm: declare VMA flags by bit
Message-ID: <7d63aa31-e77e-4b60-9edb-aeef17849388@lucifer.local>
References: <cover.1763126447.git.lorenzo.stoakes@oracle.com>
 <6289d60b6731ea7a111c87c87fb8486881151c25.1763126447.git.lorenzo.stoakes@oracle.com>
 <aRcztRaDVyiDO7aH@google.com>
 <e98d913e-71bc-4b58-95ec-8ae054c43120@lucifer.local>
 <CAH5fLghqBxnXv_3uir6hD7=J-Xs=i8B-B7++7J2vCMwZ-5+wyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLghqBxnXv_3uir6hD7=J-Xs=i8B-B7++7J2vCMwZ-5+wyA@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0310.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB997571:EE_
X-MS-Office365-Filtering-Correlation-Id: 29466994-39f7-4362-6384-08de2387b753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDBUSHMrTUlOc05aVnRCbThwb29mUTBZQjBTZUFXd2VuaG9ZK2Rxc0s5SC9J?=
 =?utf-8?B?QWZraFNFNlhYUk5XZ003UitGNmdMekt0bTB4RXNLaGlBV2kwbEF6Q3BSWGRK?=
 =?utf-8?B?ZXZLbE9ydkl4ZTR6aGxuQTNkbjFlQTRDN2lRN2d2MnhqVTRwWHV3SmZPODhm?=
 =?utf-8?B?YVppV3BVYVJZVDhaRlI1UlpQZUUyMk9DUCs5b2NBYUpmV3VoTWdIZWZOaXdP?=
 =?utf-8?B?QSt5VVZyWjd5QzhKS2U4aDk3NXFWM1RzdlVsdHlvWU4xalA1SFNRZGppM1Ez?=
 =?utf-8?B?eTlWTEhOaHFxN0xBdHhwVTVuUUNkMjRaeVp4REhXUi9rdXorbGVYdk5BWU0w?=
 =?utf-8?B?S1JVU0x2aWNyUitsekkvOHdrbG5DS2VkaUgwTEk2V3JYYXNPYitxNVVKYmxO?=
 =?utf-8?B?U2lPNFN3ZHBJVGNHMkhBdXB1K2NWTjVpWnU0YURyQzhJZU5PL0pFUmRGRzNP?=
 =?utf-8?B?Ky9hVU9XU2VKU01TSEhHaGUwamJoTHZEUWNtQjl2Z3g4QldiZU03RkZyNVVs?=
 =?utf-8?B?NUJTUXMrcDNvTlJqL2ZTbk9YNTFMTXlEZXRqUlMvZGhOOU5PZG9Xd1d5Rkk1?=
 =?utf-8?B?QnZZMmhQZWp1MEw3V3N2ajNGYWprMEVzUllLYlNkUk15eHFscnVJUHpZaVp3?=
 =?utf-8?B?dzJQMjlZUDBuSjMyL2tCcDhPWWZvNmlibVpHRDRXVGxrWlFmREZRRWhSWEFY?=
 =?utf-8?B?UnkvdkNmMWQ3UVVkaVp3dUpoaGM1QURVZDVad2Ixb09ZNkcxSHdLWTRnYXFK?=
 =?utf-8?B?Uk9vN2g5NU1DcU1uM3R0WE5qR0E1WlU1S0ZZcUx4RmxtYnQ2aE5UdSs4eFl3?=
 =?utf-8?B?dFlOT1pyaTNKaU82UmRzMm53elhZai9ZR0dZNUczMVA3QU01Szl0LzFDUktB?=
 =?utf-8?B?S01OQWZKVTZoMmNwbkpOdTNQNFZlNjVtMC93Ukl5TklnQXpqNk5lMG9EdG9F?=
 =?utf-8?B?RGhXZlFTY1FBb0x6SHp2eE43MXkvN1VHL3IyTHovRE1Qd3hsUUtKVWhxbW9m?=
 =?utf-8?B?ZU91WlZQK0xDanJwZm9wMVo2N09rL2ZjbnArQzdHeGt2bmF3aTBjZlcxSWF1?=
 =?utf-8?B?ejIvbC9MOW1QSWlFZC9uRnVYUVYwMDJzdHlLdEZPeUgralhQQU5TdnJTbHV5?=
 =?utf-8?B?Y1k2SnlJNERhbW5wN1owSFRKd2JIYnFSWTZzNWJZM1dGMFl3SytsSXJscjdi?=
 =?utf-8?B?YWIxWDNNc3k4WGV2cGZVUzRmQTkzOTRabEQ3c1M0WVloV1hEREpNMjg5ZkZ5?=
 =?utf-8?B?VnIyd3hrNUFQL2F0b2pOM3R4TzNpMDdTT09UUEVyTHg4Q2pwM2VIUTRBMzNF?=
 =?utf-8?B?RUsxVFNIajZZKzBJUGtGYlJDZ1dmU3k4ZXlROUkramZsSzl0Vkt3dEtFL1h6?=
 =?utf-8?B?bzlKL2RCS2w1QVNaTnNESE11L3AreWtPYXZxS250aUhzK1c3ZEpqbWR4amND?=
 =?utf-8?B?T3M1ZFZhOFhBWmtmVEpnbEN4SDZnK0FvYm91dWFhYzJqYUhjZFVsSVVwRG1w?=
 =?utf-8?B?TWJWR1RMVkxHdFJqZUp0cmh0dHlvMGloKzB6eUpHTmROTUVqNU9Xa29WM1Bu?=
 =?utf-8?B?R2l1czYrYWJNVXNiWjREdXZIeHpRbDBEdnphelQ5citZN2RRQ3ovd1BMRFFy?=
 =?utf-8?B?VlJyUi9BS0F2eTZBak5oRVlHRXc1a2FwRWdnNGxuU3Y1Z1QxdExKOUhLZWZS?=
 =?utf-8?B?VCs0a28yVlNkeFYvZTM1dUkxS0QwUkZNWGJlWCtnbVh4dk5LTG9EQm1lcmR5?=
 =?utf-8?B?TmpxejRvOEdQMFpJMVNucXU3bkpmc2M5cmJla3BtTzd5TkVoY0lzb3Zma3RO?=
 =?utf-8?B?RGZGTW5peVpwdEVocCt2djNlSmQwVUlPYkNobjM0V09EeE5aU0x6R2prVjZr?=
 =?utf-8?B?dk5Ea0Jxc1BIZ3Q3Qk8yUUtsL1hnbHEzcWFJajRSNDdBSHkwVFJpTysrKzky?=
 =?utf-8?Q?7YKNMSiTjjw+BM9TJyZjGd3sYm1cVVBx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmxyaEhhR0hneXFpQzRVdXpFV1BYdG42SXp0V2cycERIT0k0UjRmUnRmekti?=
 =?utf-8?B?TWRwMmNBcHoxNHpFSjFxMzVibk41MXhPTlljUnF4a0R6VjdETzhiSXJGb0lr?=
 =?utf-8?B?VEJxcFBSSnJzaERkU1VxVUlVVkE1aEd4N2tyNjVLY0ZYMDJkNm1tckozZnYw?=
 =?utf-8?B?U1AxRXhmazBlaDBpcWN6ZCtwWE53ZU1uaHd3SEt1a1daZEkzQVk4dEwwc0pO?=
 =?utf-8?B?MFJZd1g3eFhVRzZmWVJFYUZBTlgraklCUng4cEZHbWlRais5OS9qM2pZcXh1?=
 =?utf-8?B?a3lxTFM4UGVSU1VjczNpUmtHamc1L0V2NWwwZS9HcVE4SUtUMkZxT0pTcGNi?=
 =?utf-8?B?eFYxSE1QTUtqYm9vSENWb0tPN1pqanlPZDlRRFU2eU01V2dLLzFvU1RsSjlO?=
 =?utf-8?B?NURLU3F2TnhBbmprZGdDS2ZqSUgwQ0JlWWhNcTdJZjB6UHM0QmFsckZ5Nkwr?=
 =?utf-8?B?RW4wOGNnRk9EYUtnL2tuZk5sRU12cjJpT2p6ZFZzSU5aSnpsbERKOE9TMVFN?=
 =?utf-8?B?emxZYUF4Nm9PUHBZdkwrYjBKZGxCU2liTXZPMlduVUFQWlhaS21FanhGTUJF?=
 =?utf-8?B?eENaL3dJZ0FJVFRhMnlLK2d0U2RIYjgwRnpEUHBaeGZUcXhHWTdBSHVMakF4?=
 =?utf-8?B?b0ZRVDA0ODBERWVMNUJ6dXQ3UWRuS3JJN28xS01rak4yZXlMNkl2L3ZhaFo2?=
 =?utf-8?B?TG1UcEFxTDIwWFlWZjZiYm90cVFGQTBib1VKY2NhSXYyRThWUlZBaXZ2cWZp?=
 =?utf-8?B?KzR4bFhQVmp1Z1BHMDBFL0Z5RllBNVYwT2dXRXlqamQrQzVZcjlWM0tRdmpm?=
 =?utf-8?B?MHQ4dVFlYTcxcHgyRTZFcmp5Sm1LdFc5UHJzaFFKd1duUUVlejN1bHRCMnpC?=
 =?utf-8?B?RDhYa2docytKUFhTN2tKNWlPdTRqdHJXM0JjaEFHbGYvRjM4SWoxVEpibzly?=
 =?utf-8?B?aitsUTY2dDM3MHlrUStVOXFpa2FXNFROQVdpMVlTWHlpN2U2OFlXQnE4bWZF?=
 =?utf-8?B?aUo3TkNoV1F1RFhvNzdKbjI1Z2hZcG9hbmFyVUFIZ3gxMjI2Z1Z0SDVrWVNI?=
 =?utf-8?B?K0U4UnI4dXZLUE1mN3J5MnhEMW9VTnRzeU51ZGNIcVhlUDlvK3R0WE11Nkl1?=
 =?utf-8?B?cWU3T2NVbFU4dVlzN3ovT3lMOGZjWXVmVUJId0hWYzVkMDlReVljRXE5dUc1?=
 =?utf-8?B?Y2EvcHVFd1J5NEU4VlNTRkxINjBkNWhDQ29hUmtZM3FHLzhVbU4rcitRcHVD?=
 =?utf-8?B?UE0vTGZybzQrMkQzRW5SRDhqWkZsYjJwZWlXdUFNemNpNXpsTGpac0pZQTBw?=
 =?utf-8?B?TVVUbFlGTithU1JnTHpwTGVlK3ZGNUVkUVFCVVZrS3BOeFM0akdOOURyQXkz?=
 =?utf-8?B?MVhzOFErOVhSaGZ2VDcvY3NnTWdndGFZcUR5RHJjV1orSDMvTnViKy8wQmR0?=
 =?utf-8?B?Nlk1ODhIVHdRT25tN3lFWjFndmZXdGFnSUFWdXNVeDYyclV1YjczcHdWcWJR?=
 =?utf-8?B?WHE3MXNrYVlnYVBxOVVDcnE0NnpOa3hRWFpPZElCcnc1ZzJydGhUMk5RVm1k?=
 =?utf-8?B?b1lSMWNFeWZiZGdteFdiQXZyeFJTcVRmZ3Y1aENTY0todEQ1TEJTZ01lWitM?=
 =?utf-8?B?QUZBam1ub3lvbzcycnNBRlpmbVdRNDkwaXJlS0E0U2NKa0tSQ3JIOVFKWFB3?=
 =?utf-8?B?Z2J2NTNGNXRTWHFXb3dqUzJKbllsOVpRcGc1SzdCN1BrK2VJNEZwc0VNOFBE?=
 =?utf-8?B?N0lXc0xCcXZuMnVkVzArWmJNSEJxT3RhTUxFdWtEUTV6UDdWZGlVUnBqL05m?=
 =?utf-8?B?MmljR3hHWTdJUlBIOTRIOWhFTVpNQmp6MFlCYi9nN3pxdHhaSU9jWUNybGFE?=
 =?utf-8?B?WHZkQ3JYVEdWY1N3L1kydUk0YTBabldPWXRLNVhNRHdqYlM5am40WUdxaS96?=
 =?utf-8?B?MFBac2ZBYW11UXp4enJ6Z25yMGNsd1pHazY5R0FJNXNiT0FTcUlXb1p4aWRo?=
 =?utf-8?B?K2tEMDdzemVqV29ldVdvYTBXS28rZUVhbFpxRUU2QXRERkpaZElIdUt3ZHFk?=
 =?utf-8?B?SGRYZkdlUHdyL3A3c1d0Tlk5NjlraWR3T2pxUW9GRzhKRHVVZHcyaGhGaTVH?=
 =?utf-8?B?L2lEWkVhT1VvMzFBMzltVzNYV1RaQzF0ck1SbG1hOVNWZW9OQktqQ1JzOGJG?=
 =?utf-8?B?Ymc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eNHGrA259JvRwBbGO6Zm6C3u15er4pzHFKOSIX++oRXJ1jXcy7Sd4UqoLYGgw6YT8EzGI5lwjTkeMeQKUJcOaCYNUgStJTeyjQ4RZzVETSaM4xLCiUn3XlI5eQbdmL+WsETIcmRU8StLogoESEFNEezWUxLE1KShiAQeB6vBm6TpwyTZJT8TDsoAO/kT8IJsi5Fqzo0E2NduZbTm+tBSAkYlJ4rFIH7Y/AYJ8mEtvdrKEslWK3FmSh6nhfIpfUAuT/rS6ScQ+8SKZoqQfzgSZxuuLRhbQ8LycENr6C/atzdSD92LJge6hh6fH46YAioEX5YGgF1ysfbvu2YPxPJWoet31+N24YPbfii4wYtlFFn+FAocCp0vlyJN5OQUtOHq8vL5B/Ondv6nu57oWmXrz1++luDA7MuGphTpx6FwHRwkGqmhSsM8FfPSuK5IxrAMLae5drKkNvOjsl6tettJO+BiztcKNKFhOl2E++TgbdsfEN4ZLIzvQcnXKdXmasFTNbUh13oGPacmQpBMbLPrNnlQ1BnOq5tD2czIjGzeX6KwyNUAJwi40PNQTDsjqo1s5vU71GTgvyIxIQM0FrvR8WIgJMJe6zU9w7NmF8vWTDU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29466994-39f7-4362-6384-08de2387b753
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 14:11:33.7393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OW16DDx+d1YqHEWEL3g0ichAOqjGiossAOVD1y4WUdLIIDEBbcd0Jpdm1ndMt+tSbMDpFBOh/GYU3zHvE9SioPRjEZtqRxxpwL71yx+T3UI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997571
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511140113
X-Authority-Analysis: v=2.4 cv=YP6SCBGx c=1 sm=1 tr=0 ts=6917389a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=nQpJLllCoZmCm1rUGssA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13643
X-Proofpoint-ORIG-GUID: MpVQt6WLNX8upbmJKYFGS5JXO4W2Ry-r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OCBTYWx0ZWRfX2V4pMapAAqNx
 lFQgRy8uhCzt6NrmKRWsCGzUr3z45blAJ/WG0Y0EPzJ0VlX1YTVE4x3lh1Fc+liGSw0oiEQ5Jz2
 3QL4flVbqGsFZpe9UDX+gtgB4IWkSIksnhRbOrN2p+m0nx44d3r88RBPUJWkx0mh53xI88vLDEs
 qFqirdvWDAOI+k2XnfJEK7P0tE/0eShgqNVgUYSw5vd2IeDw7B4Uf6Ogsiw85rgEg8qaF1GunOG
 6hZE7wp/OvNkhI3ehs2csn4DfOxpMFNeFmySDm3AsMKcQp2M9+qzKnujCLrEFl0f79CCaWVMujP
 cOagcKmMn8WB5NwoyDuBPJYOPBq5Nktm9IwqNvnMefVpQH3ACjYuM8wGZ7DHNnqQqlMMbTFZ3Y4
 AwD12mejJzLB95n0WARRQfgja2QDrfBHsGAQ07eL8SbKxClh+6I=
X-Proofpoint-GUID: MpVQt6WLNX8upbmJKYFGS5JXO4W2Ry-r

On Fri, Nov 14, 2025 at 03:08:21PM +0100, Alice Ryhl wrote:
> On Fri, Nov 14, 2025 at 3:02 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Fri, Nov 14, 2025 at 01:50:45PM +0000, Alice Ryhl wrote:
> > > On Fri, Nov 14, 2025 at 01:26:08PM +0000, Lorenzo Stoakes wrote:
> > > > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> > > > index 2e43c66635a2..4c327db01ca0 100644
> > > > --- a/rust/bindings/bindings_helper.h
> > > > +++ b/rust/bindings/bindings_helper.h
> > > > @@ -108,7 +108,32 @@ const xa_mark_t RUST_CONST_HELPER_XA_PRESENT = XA_PRESENT;
> > > >
> > > >  const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC = XA_FLAGS_ALLOC;
> > > >  const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC1 = XA_FLAGS_ALLOC1;
> > > > +
> > > >  const vm_flags_t RUST_CONST_HELPER_VM_MERGEABLE = VM_MERGEABLE;
> > > > +const vm_flags_t RUST_CONST_HELPER_VM_READ = VM_READ;
> > > > +const vm_flags_t RUST_CONST_HELPER_VM_WRITE = VM_WRITE;
> > > > +const vm_flags_t RUST_CONST_HELPER_VM_EXEC = VM_EXEC;
> > > > +const vm_flags_t RUST_CONST_HELPER_VM_SHARED = VM_SHARED;
> > > > +const vm_flags_t RUST_CONST_HELPER_VM_MAYREAD = VM_MAYREAD;
> > > > +const vm_flags_t RUST_CONST_HELPER_VM_MAYWRITE = VM_MAYWRITE;
> > > > +const vm_flags_t RUST_CONST_HELPER_VM_MAYEXEC = VM_MAYEXEC;
> > > > +const vm_flags_t RUST_CONST_HELPER_VM_MAYSHARE = VM_MAYEXEC;
> > > > +const vm_flags_t RUST_CONST_HELPER_VM_PFNMAP = VM_PFNMAP;
> > > > +const vm_flags_t RUST_CONST_HELPER_VM_IO = VM_IO;
> > > > +const vm_flags_t RUST_CONST_HELPER_VM_DONTCOPY = VM_DONTCOPY;
> > > > +const vm_flags_t RUST_CONST_HELPER_VM_DONTEXPAND = VM_DONTEXPAND;
> > > > +const vm_flags_t RUST_CONST_HELPER_VM_LOCKONFAULT = VM_LOCKONFAULT;
> > > > +const vm_flags_t RUST_CONST_HELPER_VM_ACCOUNT = VM_ACCOUNT;
> > > > +const vm_flags_t RUST_CONST_HELPER_VM_NORESERVE = VM_NORESERVE;
> > > > +const vm_flags_t RUST_CONST_HELPER_VM_HUGETLB = VM_HUGETLB;
> > > > +const vm_flags_t RUST_CONST_HELPER_VM_SYNC = VM_SYNC;
> > > > +const vm_flags_t RUST_CONST_HELPER_VM_ARCH_1 = VM_ARCH_1;
> > > > +const vm_flags_t RUST_CONST_HELPER_VM_WIPEONFORK = VM_WIPEONFORK;
> > > > +const vm_flags_t RUST_CONST_HELPER_VM_DONTDUMP = VM_DONTDUMP;
> > > > +const vm_flags_t RUST_CONST_HELPER_VM_SOFTDIRTY = VM_SOFTDIRTY;
> > > > +const vm_flags_t RUST_CONST_HELPER_VM_MIXEDMAP = VM_MIXEDMAP;
> > > > +const vm_flags_t RUST_CONST_HELPER_VM_HUGEPAGE = VM_HUGEPAGE;
> > > > +const vm_flags_t RUST_CONST_HELPER_VM_NOHUGEPAGE = VM_NOHUGEPAGE;
> > >
> > > I got this error:
> > >
> > > error[E0428]: the name `VM_SOFTDIRTY` is defined multiple times
> > >       --> rust/bindings/bindings_generated.rs:115967:1
> > >        |
> > > 13440  | pub const VM_SOFTDIRTY: u32 = 0;
> > >        | -------------------------------- previous definition of the value `VM_SOFTDIRTY` here
> > > ...
> > > 115967 | pub const VM_SOFTDIRTY: vm_flags_t = 0;
> > >        | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ `VM_SOFTDIRTY` redefined here
> > >        |
> > >        = note: `VM_SOFTDIRTY` must be defined only once in the value namespace of this module
> > >
> >
> > That's odd, obviously I build tested this and didn't get the same error.
> >
> > Be good to know what config options to enable for testing for rust. I repro'd
> > the previously reported issues, and new ones since I'm now declaring these
> > values consistently using BIT().
> >
> > But in my build locally, no errors with LLVM=1 and CONFIG_RUST=y.
>
> I got this error because my config defines VM_SOFTDIRTY as VM_NONE,
> which bindgen can resolve to zero. You probably have a config where
> it's defined using a function-like macro, so bindgen did not generate
> a duplicate for you.

Ugh yeah of course, damn.

>
> > > Please add the constants in rust/bindgen_parameters next to
> > > ARCH_KMALLOC_MINALIGN to avoid this error. This ensures that only the
> > > version from bindings_helper.h is generated.
> >
> > As in
> >
> > --block-list-item <VM_blah> for every flag?
>
> Yes.

OK will send a fixpatch, better to add them all to be safe.

Bit ugly but we can fix this up later when I add in the actual accessor
helpers.

>
> Alice
>

Thanks, Lorenzo

