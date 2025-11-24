Return-Path: <linux-fsdevel+bounces-69667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3D3C8090D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 13:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9CEC14E8ED3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 12:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF4F30101A;
	Mon, 24 Nov 2025 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hf5w+V2q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y//TFdoB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EF22BE05B;
	Mon, 24 Nov 2025 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763988293; cv=fail; b=uOVSicdPpfMZeHCF3W2X/KdUQnxAYcnf/zW9JstBTfwAfajsGigRsYuFi3fHQLrJq6yHXRAxIMSyvp8FlTHEWm6YZoQa3mY/d9cAPMaE4L3dD2MK1sBKC6gIWwR6BAGfxqbghhXJU4p96bdVsUrFvXSjm8NrmHrwBcGZWum57ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763988293; c=relaxed/simple;
	bh=ZpFR+ORycW7yULq0p/aAv8/F8JjTVHUbxUxM2VAybI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rOhMhpKZ1TbzjPndNoux9toWxcQ918wShI5ARdr7RfSu3lD5/8eEA85spvx3Crnp7eNKUzmTSzZRH7los2GhVPcYN5wLVMnwxFi5a16C7zXJNGFXiKhbH6Pk6rVONGJxeyney2U/jVRm+H6pxHhNLWyIUodxAvtajpTirVv3zNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hf5w+V2q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y//TFdoB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AOCVDgD1078643;
	Mon, 24 Nov 2025 12:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=jdZKhJh8o/Z3mJ1Ft2
	yTlpGoLgWX0xjhzOLiG57OtLA=; b=hf5w+V2qPVecSf/yJ/iN2gP1jLwoTUiRpu
	06bhFAH7G/I3Etg1JiMYGN/UyTkIQA7FYQ8W8bR0JNtDSHN0S1BHFri0qjlxZzuT
	07Uv8rvYyyqYNwy6AKjPhzN2YPGkJi8fTjoUZr4Q75ne3w7hrMm10uy4YdIbVkdJ
	1iqjywrP8OuC5o5ZEGzeNlQmu7p96IUgN3otiwXiD/5U9npA5YvSJkgSlqraEo0U
	zGDXK9uk4bxlJMzikqjO/b8oqafJ77510WNGPLGanKVjDD2hZlIPRhNnKLAzwwrG
	9JNte3jWrbppVn/5WPtAIXtD/pEBr8W1Wu8lSkCwDuCH8C4yC8fA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8dd9xwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 12:43:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AOAwkoo022139;
	Mon, 24 Nov 2025 12:43:27 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011034.outbound.protection.outlook.com [52.101.62.34])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mbtfud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 12:43:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phQJf4fYwjVo4Ojd9hToUbOiVqMwOe4mdcclBth5cCClhTw0rItfjsfLTkYwrPQ8rabm71yP4T3ifffSVSNZLtpaFNO33Jq0sWzvfd31hY0PBtr3bnIk80aB8kFQsFGKvyl+7Q3+tpj2Tfl1xBIcvP+SfKO0y4X0rmimJj40HuaO1PmbFp/mdBznLzFgWL9MA3lrKxMp1pNV7xYiAM6V2cBVAHCzWyjw5YfhtkyEN/v/AZWli5EqLXwZgYB8xZlf/FXrYiJ8JgoO38zkEPRfISpReX/JjhtO7Zlqr5MPZdi6JMhtJNHRg4ghU8L5VfFUXAyhUaJpLuQfxdnFT2mY4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdZKhJh8o/Z3mJ1Ft2yTlpGoLgWX0xjhzOLiG57OtLA=;
 b=xxjughtmo9TzmpH/crJKajLfBSv9RWoCIXSrjDKLDIpcn1lapKw1mjHh3W9zldrOmALocogIixwDMPkGeApIPScK5TxXktZr0/Z2A1gFTIUQsuFk/G1szXlA9WPC0YgkzhRk0MeFJ44l8e0k88KNyIk3ufYr+x9PxX/nWEQ1TBoFDyk4dVOq9uFZamBt9q29RPUhREQno/AavkhfufaW6rkz4ZNlkUfkOhyJOJ52onogk5GBpAHUu8jt40qnC+n4jal7WiIu/7/5LiNExo78Z5Ab6bB4oGDwdSwLbLypLdwhlontDAvkct7OGm4ta2+RsTQlct/cKOZypYha8nzK+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdZKhJh8o/Z3mJ1Ft2yTlpGoLgWX0xjhzOLiG57OtLA=;
 b=y//TFdoBeITxz1/OE/JRAyu6ZXuYhrzoJzXVTv0iQlSuL0x91LIaZeJpOG8/gaXJ6SiW1OFHy+lK9Ovxjdkrh1WMmrCV1YDeSIMq7rEl2bxSAhZGU5pdh7ZHSKjgEDpinn1R/RqJ1JpMyrJ9M2VzR3Uu/JzcxS5Zlh1X3BrQOVE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB6855.namprd10.prod.outlook.com (2603:10b6:208:424::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 12:43:22 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 12:43:20 +0000
Date: Mon, 24 Nov 2025 12:43:18 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
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
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 3/4] tools/testing/vma: eliminate dependency on
 vma->__vm_flags
Message-ID: <09c2d927-6d34-4e72-a593-4a3f2b739a60@lucifer.local>
References: <cover.1763126447.git.lorenzo.stoakes@oracle.com>
 <fb709773edcaf13d7a2c4cede046e454b4e88b1e.1763126447.git.lorenzo.stoakes@oracle.com>
 <4aff8bf7-d367-4ba3-90ad-13eef7a063fa@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aff8bf7-d367-4ba3-90ad-13eef7a063fa@lucifer.local>
X-ClientProxiedBy: LO4P123CA0552.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ec38604-f439-40d5-fd79-08de2b570c45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oY7XMXK/CFzXBatGfFfwBr4wU58IjKIka4ymKvCnAtt8j8HortYCkGT1F+kn?=
 =?us-ascii?Q?+G4RSUr/TtYsqthgXBuOsIyWrKK4YHYGjNaYYZc8PU/oMer9/p/++HkJFzjH?=
 =?us-ascii?Q?YEyzciNzcihJL9qC1jax0BNIyNxGxXnySuLleDWR5lv6CWGYinjKoK4fIA60?=
 =?us-ascii?Q?2DO/HeXrMwB1rimYErXsTtteGL3bOcV+3gDB1rQnMTAiVLM14GomCqjmmiKw?=
 =?us-ascii?Q?dJtOirK+cxgutk30FVpWXDsAekwBHpnP7E6T8wYSjCNaS8iqRLCffBmFpMTx?=
 =?us-ascii?Q?X2wLRWH/sJJpVJQCHNo8cx4Zdyk6OpQJN7YkCKAZwlqxTKIKUPavZ5cWIWnc?=
 =?us-ascii?Q?AqDnACibWWXvxOH9mCayLNZC4IbbVNoqoqreX0i10Hcz9NEWe2twdn0XgLGN?=
 =?us-ascii?Q?JcYUaxw9in4N3LkuBqIHJBnv5XjBVGC0tvdM2BgNoffKMxg2QuxL87gJJkMn?=
 =?us-ascii?Q?G/HqLWJoMNFAGZmLjHeR7waqaz1lYLk5uwWEr68I9wyJHqggUtlMAwCWF+gM?=
 =?us-ascii?Q?5qq6gjt2oVwTaLjPCnk0yB+l4csxmsznSfDIOJMFjAWWkBhZwasQltXVo3Jg?=
 =?us-ascii?Q?WZYGSJhYo3HUd1YPwhLAb/7g4JVUXhIl/eNGhQ4dwOmpdfYUYzjlf81Uz9M0?=
 =?us-ascii?Q?plxe+HZKZzhVwsGdQUVxS9wrk6bwSXrSkaQn3k9L73MtbPE/S50J10kHzvtH?=
 =?us-ascii?Q?EqYZ5kRhZZTuVHiBt5yvHvHWqA0mUbBj7wH9nV3G3Kfc53KsUg07UpiTyZgt?=
 =?us-ascii?Q?/98R4V+nBcFJJZbhBWAvCiBC3iJ+sQkDHi+1rnSv1Wlacoa8BmzB2n5XNhEj?=
 =?us-ascii?Q?dGPNG+8Xssi+CfXz7yZttSI7SteD3950GETBThGarl70/8LMf+HwZyuh5k58?=
 =?us-ascii?Q?rjyqAAJ7ADklvX3DgkDI+vfaIA2iVkW1rCDFGSy2W0DJIyhVRtQCyr7WaQMu?=
 =?us-ascii?Q?LXd/Zbwsp2mggORsznQxgXQ/2liOfyAUrHDIt8QbsJwCWapbwSw5Di1feRlr?=
 =?us-ascii?Q?4xAl6h0OpqWSLuvuXxblyjtzPOH12hiPt+VPTOAn1aMQFW68m2KAAewdV8RY?=
 =?us-ascii?Q?oEuDMrQ3YF9jZgIkTaRjdRVZpSB/85EL0AdlItswOkxtHTcV8foaYNus5H7w?=
 =?us-ascii?Q?3nDUS2WuetJxf7zj06MPW4xTsaWOWK6zkHQxt2X3GxL8tq0rFbYn1ujkES22?=
 =?us-ascii?Q?fNyafnN3Wi9fDE8f7tbpj0ZNWGfufsq3BArMWr7K9wYzZ6udkwfcEHztypaG?=
 =?us-ascii?Q?VBHF0R25lUVXVRFeRGbVp/QoB6IbHEf1zD/vM9k5M4wpPbtYDRFb4Oj6RcUX?=
 =?us-ascii?Q?ox8OTfLB97JItolIACF1ltiWq1UvukkzReA9kutGgBaS4gg8x+JT7+oth9Tz?=
 =?us-ascii?Q?hioTtxRAxDf4kX+/kim9UvSG0WO/grWaRvqWqv94LmU5Vgj7VUoC6pEmk9yf?=
 =?us-ascii?Q?U4I3FS4rk3Lhj8fWRBcJU6D1w00Kvk4i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hdqz2/UtisjY42gjEVB/bWgFOkLbE5xI/1OwfpN/ALlzliGJsnxiSFb5msdf?=
 =?us-ascii?Q?zTlLlkrCzTQIkMTqDP2V3Zw3l/BdAl25HqJDzPQJCKND5UIeAepnrhYvs8zd?=
 =?us-ascii?Q?iWnxvqECL9K7Wxk21w3Fky940UZE/4oKT/4YY+q0LbutoHDa/AQw3aUzwVZ9?=
 =?us-ascii?Q?Oq7R1e7g1VOT5ZObWMYe43xiaHTeGhwvBsWoBAhLFgYaGIMQHypJIvmwLUPO?=
 =?us-ascii?Q?ovjIJyH8fAGzK/LTun2G2tAz3bCT9Uwfl+NGLA4GojwvW+g4NJCS7JZ5IPEm?=
 =?us-ascii?Q?LkKx6KAr8JXDgGXNA8ZpYRQqCoGPtwu3894Q6oZY+7GhKgyyF8urXfjywJgx?=
 =?us-ascii?Q?OyNNhihPtT9Dgr7heywk6n0Xm03enlT380cnVqL0I3tUhdElQsByjzR9hsoa?=
 =?us-ascii?Q?PL31BpEUHZOABp/8v/Pz7jA0iBNukNePqX34sCZzhxAMbiKDyfUdWkaTFKq8?=
 =?us-ascii?Q?KtMmpXuHAodXOWuad8H/rAO2XES9dchaQ0ycBYUflAMDqRsIRWQpC9WGslpS?=
 =?us-ascii?Q?uNQthq4XkgonwdmAT6rCRx4yN8nAiZUIpuIRkOqz6i54KPZ5EoWHCOD7jjg7?=
 =?us-ascii?Q?/OZ9zmX7JJo4/Geys/FLPql9s5ddUv2eVJM+bNQ94+qcVav2nUSQn0qx7F4r?=
 =?us-ascii?Q?Atcok5gxu8VpXoC9jCBjJV7vmbDXJQob+pHkd/9WWIdyfUcXLqtzuWfnd9+J?=
 =?us-ascii?Q?+23wlErR65mfIbsSJTxizj9xdxlSvR7nTitSc19i4xPvFEubTcSjLitZKPfH?=
 =?us-ascii?Q?0HDYwQgLx0+6r6n+EYNxqq1Pw3jF7eH/G/OL0voTjGBnUyYql2HJ8COWkJQw?=
 =?us-ascii?Q?Mx2r3BNWMJ/GD3FDqdduU753GncGS0vDiNESnSL6HjsCkilwNea+lCzE1FFw?=
 =?us-ascii?Q?k2+2x8b9JWF+aRmRKuGPeOhiH0hfCY8ivQOuJtZ8SpCcStOe7Oa4XZsjWaP1?=
 =?us-ascii?Q?Xh1iGtth/9U77/+pWJ087HPf693D/v4Xo1oz/blCxhDg7duJUlXTIzDcEbM4?=
 =?us-ascii?Q?8M8fl/N+6UToF2s1PHhcI6HOoaBw8eA+2e7HI7stp7kzX80BKDr+ZDMta3j3?=
 =?us-ascii?Q?CHMjPkInVBVwxYLQlsywllmnWNppEIyH3lKPylPDED5JSyVqahZz4yd4CTGR?=
 =?us-ascii?Q?2LIfq+7tUC9EYozzCV43Gke+i8CmXktlCRUxw9E5s4oCF2b5TMH13PL9HcBQ?=
 =?us-ascii?Q?nWKQwabJ9+ypE0znPJCEXFPu+pOnZRuDkpL9F20k69JhGhE7ux847Eg6Hoy0?=
 =?us-ascii?Q?9Z7vEzOpgRCfcfBkmShN0XJK3ULWJEjr/bCTnbQw2ZO4rzE4Il6V62x9++tZ?=
 =?us-ascii?Q?GncA7+JgBn+Ge2f8p84ktMXgZjPbWfD1g2kGrtT5UBFK2JSq2uMVb3fPjzLB?=
 =?us-ascii?Q?HFzX1YApzn6jXUf6RCy/9/iuvnIwm3j3Wd8g6bYHE7fMS09L1a5uwtGIlpch?=
 =?us-ascii?Q?waM0ldrles0mx+1F5Hf2S1pBaBGM5vpeeaBUaQXsd+S4SrcmbWysVUOCsB+L?=
 =?us-ascii?Q?1MNltIvaZ0cozsN/zo+kMN1WOFscPoVsfvhENmwfn6Z+nd1zQcQP2UyyNPaD?=
 =?us-ascii?Q?yFgzzmBbQiNm7TOH1e/+wWHCYqlja+ANPZcuPx3W673O9caDjoKpkd/nGLRs?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cioHX7erE1FGLmj/pc0M1iw+WcyBKZpaZYKSdplcpPY5s0jh8ocDSDS6VL4mf9eNyA9oBzwz/clPYDLE/TSR4uiK47J8oyys0M+ktcIDiIqMvhuJjc3s8Eo1tKVaw0hmzLTVTc7j9pBZ3N98i3qM/6pmpSN4ZMP0UejuIdSbON91J9/KC1Lz6RYCvcqflN5AAFhcnIocmOw8ZoHH6wQuDje1CVoRSEpd1iqM+ZbQMaLi6zvRSpveYH4hKPvlrqogoA9Zk8WO+sSaQbRG2zpXy9qVDOXnCIBHmtHc96oXztTRkV5w3BeA9MXl64RzyQtmuO2V63dPbB65KAUMSQ+SUwBmdJuR1qIUuQcS0oLgKxEOlF5EcANFD3iiKZFQi/HhmTORxhQXBHp8651RjLtVBYogc56p7rEoS/rEJwY/3QF+2EzP/uBd4FQnUNlTZnwP5GT4WzR9z10/+bA3bm2FxGKAwjKXjVQ8gEPoknMiyk5ETgoa1jMK5hP3WaPcXboGuvBs9UkMq9xqMekkekFH9aEkSWEgCKHryXIgyDFUZfnCZt1/Xe2zJ1AJ3BcDgdMAogC0Rt0UffGknKve77F2M4gstoP2KyPJnkX1/GI3zEk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec38604-f439-40d5-fd79-08de2b570c45
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 12:43:20.3263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1dk+joXqKelvOfd8vWGtNaxrp+VgqRo2J8FrwArqNLsYjkd9UIiZiNpzkUHFvi1CYidd5Qje6FLJ4QNfwFXxJZSThnD8CqAA+3bhtUMrOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6855
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_05,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511240112
X-Proofpoint-GUID: zhqswuIFDSjTG_6bl3YHiaE4aG5iEpe9
X-Authority-Analysis: v=2.4 cv=ObqVzxTY c=1 sm=1 tr=0 ts=692452ef b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=P9Ru0Q-n_PehIEPSeYkA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12098
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDExMiBTYWx0ZWRfX2qZRZAM0dFVB
 y+Pvx3W5AuoMua8CmDQnLC8J1KzROHC8s8Tx+wez3WUJ23FJitSPPv1iN9nX7begD6/XojixmTi
 4WnkPlJbYUEbvTX+b06HglDyS3qq/4xX4waY30YBkZaBwk/ONS2s+HUdATw65THywqk/m+VaOYj
 Et9YUKenUzP4xXfehTbSuS+TdnA5yrxzM1NqQ4x85RQ8GJX5Cm33im0TPNPG/DAgkcNIzdVuZg7
 D/ulsNOa8LrHTGLraAtmx6brQNjv+aL+HTIbEgCram77dGsXB0VVyC7PM0tyPHeEhULPzsCPSKk
 BxfkRSaYCDfTZA7agFLamBMIHs2B/JzyOPdjA1MDp9iyha/ioKXFmGqCg86VNw3vgvi4QQgPAoL
 /M2SKHVNcMu7SXTAql4Zy1BP1wI+92YejS1Y1TyghIPKXLoc6HU=
X-Proofpoint-ORIG-GUID: zhqswuIFDSjTG_6bl3YHiaE4aG5iEpe9

Hi Andrew,

It seems that the ordering of things has messed us up a bit here!

So this patch (3/4) currently introduces an issue where vm_flags_reset() is
missing from the VMA userland tests.

Then 4/4, now with the vma_internal.h fixes in place, puts vm_flags_reset()
back in place (this was my mistake in the series originally!).

But then this fix-patch, now applied as the latest patch from me in mm-new,
breaks the tests again by duplicating this function :)

So, I'm not sure if too late for rebases - if not, then just squash this
into 3/4.

If it is - then just drop this patch altogether and we'll live with this
being broken for a single commit!

Cheers, Lorenzo

On Fri, Nov 21, 2025 at 05:28:15PM +0000, Lorenzo Stoakes wrote:
> Hi Andrew,
>
> Some small silly issue here, for some reason I seemed to have vm_flags_reset()
> available from the VMA tests when I tested but err, that doesn't seem to be the
> case at all.
>
> Again I realise this is in mm-stable so this might be fiddly so we might have to
> live with minor bisect pain :(
>
> Cheers, Lorenzo
>
> ----8<----
> From afe5af105e7d64e39a4280c7fc8b34ad67cf0db0 Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Fri, 21 Nov 2025 17:25:18 +0000
> Subject: [PATCH] tools/testing/vma: add missing stub
>
> The vm_flags_reset() function is not available in the userland VMA tests,
> so add a stub which const-casts vma->vm_flags and avoids the upcoming
> removal of the vma->__vm_flags field.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  tools/testing/vma/vma_internal.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 37fd479d49ce..f90a9b3c1880 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -1760,4 +1760,11 @@ static inline int do_munmap(struct mm_struct *, unsigned long, size_t,
>  	return 0;
>  }
>
> +static inline void vm_flags_reset(struct vm_area_struct *vma, vm_flags_t flags)
> +{
> +	vm_flags_t *dst = (vm_flags_t *)(&vma->vm_flags);
> +
> +	*dst = flags;
> +}
> +
>  #endif	/* __MM_VMA_INTERNAL_H */
> --
> 2.51.2

