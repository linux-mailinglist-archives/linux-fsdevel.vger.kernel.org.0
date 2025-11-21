Return-Path: <linux-fsdevel+bounces-69461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 810A8C7B823
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 20:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CADAA4E9BEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FBC2FDC3D;
	Fri, 21 Nov 2025 19:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="igb4X1S9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Sb50AymK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40232868A6;
	Fri, 21 Nov 2025 19:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763753250; cv=fail; b=nd563F16E/z4ERBR5AvVBIMd4Hl6glwvqkLy7J/5gLdewGgw67cROG0IZ4KK2KN58ooyc5eozrKlHvOw33CU6cgusAGN8NQ1r4S4HG9+MXeO+FagBIzdmL6uSTVCBpHhxnX5B8/yQGUsrXe23PTprNr5+I6c0UO2hyE/u8lDR2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763753250; c=relaxed/simple;
	bh=SyUIK287Y/GxVDRszmWh4NnGh4I17+NXvxgYXAKi/Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PZBYwppHhmfjzg3e0aMFb6n9QW+TbCz9N6hrigI4jcNInaBhd0RJoh2mFjazfyxOaKe5pK1Rlysef2qwRUChCPky/jpRPoA1Ojpk6zvmJ0KnlMGgg5mJo16kDalFEW1qiQbocM/lkPM1gMgk3ufbsA81RBsq4zibqtmM5EWBqnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=igb4X1S9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Sb50AymK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALEgwoH022813;
	Fri, 21 Nov 2025 19:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=SyUIK287Y/GxVDRszm
	Wh4NnGh4I17+NXvxgYXAKi/Wg=; b=igb4X1S9zLJC1ZiQHcI8gS2CRA6jDREetb
	L00jARAXljaeBK8AfqEBrBFyps8NwCu3tXGzoT1Od/zXNptztjCqVc6FfaXg2yat
	liE5dfDBTKfrTCz/u9YK4fwR3l/pGRDNASr+bDxOoM13M5714vqk1yNs2pEwKadw
	Tz4F7FGVSEw5LxROIs7274xbzYyk1QhBEg5K1VQaMS7vBWgBqR9BKKFA37m4xpjD
	ls+T2ItVuYiGAvjxlJk7M/0joGU8HxNKQRU85WaCfaYEbBBfZYTMbrdN2VWEejWS
	sT6mugL630m8D2CuqTbIRH4e9L5Lxqr9vmpq36dJXICAyxKtZFsQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbbmn0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 19:26:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALHeNQW039836;
	Fri, 21 Nov 2025 19:26:12 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012031.outbound.protection.outlook.com [40.93.195.31])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyrc14t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 19:26:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OK0+ItzFy3qeYzG3HxlpT3A+KfSLFjKn7yil2E58DBUXact05ZH/7UyPM4RB/Wg7Sw1cJJNqiRL55HoZfNnwkEmGoky6isr3Ewi/zWfL6lJmeb7r2poh4Oxo2Z1sfV+M5ZgmuMunkYZig9MYvG8hmpOP9ilVv2nCY93eiH3uokeXMv9/5dAWlUpeAFPVV7fTAgBCjbU+6NUow9NwYT7vbn7VT9pioxxi/plwT1F/Z8e+NyEv955lDh7M80CwIjHF9lv3n124ghd/HkSr8XJhaIPmTEeIsV7OVo7LwM3Pij6gNKObph9+gybQs7+sndQNnf+KWMhn1R7rE89gprq3Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyUIK287Y/GxVDRszmWh4NnGh4I17+NXvxgYXAKi/Wg=;
 b=pMCA6pWvf00HCVA+AifUfaEakJa9bB5gljLpzSgr3dSEHU8mso3Jmn9fsfPv3sR9Ik3aY1jIgiR3mg2apbdkJT4x+/qt5oMKwWtaPCY/p/GJqHCh6YAlxbnSiuklPqZzVjuXVo7eQs+T6kiPggT+Phqc2EW7i1C4WrYCbTGW3hDx/EwLobPOrrvII7m+mVySsl8pvCkjUN6NTw56nu1yLxzQRxXHXV5pYuTN5hWN8NRY7BeSCQ5DFoD2ESMWa9zk8NXzKt0Iuhql5aO0iglUM6Z51odHeX0TVym44KvTK+HfwX1pEF1H9q7RYylD5YRaQDy0e7nknxz6k0s6iANiYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SyUIK287Y/GxVDRszmWh4NnGh4I17+NXvxgYXAKi/Wg=;
 b=Sb50AymK/BbIUYb8ioSU42Z+LeI8l29hwxA2JNcIuQzZsC3pRpnC6WksRuGK5Ekp4XB25pUclrPTTmdxgWzxCZLfX1w+4JMkJoeLlBI1wbdZS4t+fk/x6ZcQ+/CGvDHnbIhiWnx4SRpMkwcDMe2YhQ1Cei7bLWP9kuusQYl+ybQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4541.namprd10.prod.outlook.com (2603:10b6:a03:2db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.12; Fri, 21 Nov
 2025 19:26:06 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 19:26:06 +0000
Date: Fri, 21 Nov 2025 19:26:02 +0000
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
Subject: Re: [PATCH v2 4/4] mm: introduce VMA flags bitmap type
Message-ID: <15817b81-c36c-42b1-9a8c-b394805a3a5e@lucifer.local>
References: <cover.1763126447.git.lorenzo.stoakes@oracle.com>
 <195625e7d1a8ff9156cb9bb294eb128b6a4e9294.1763126447.git.lorenzo.stoakes@oracle.com>
 <c82d75d1-5795-4401-92f8-58df6ac8dbd3@lucifer.local>
 <20251121105131.1dea1fbd744587b433390116@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121105131.1dea1fbd744587b433390116@linux-foundation.org>
X-ClientProxiedBy: LO4P123CA0007.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4541:EE_
X-MS-Office365-Filtering-Correlation-Id: af5f290e-1c32-48df-5996-08de2933d13c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lmM8JAUHSjs0bmJ5diQf901SRtPyO85FRxwsAFnCRvoBUtUOwS68lYI2+5rv?=
 =?us-ascii?Q?79L6nLNYsDP5iAoEnUdSqpbev0l6lULQ9g0683Aj1mNSt25orK058jcvTt+O?=
 =?us-ascii?Q?Y2YUbddv6F27mkQd+F1HBofgAxJwX1CyKy1OYqZIjYQQxljTdohua/0V2bkG?=
 =?us-ascii?Q?PzngruJjUW1AoFbfM/X61ibubE6ib6Wu8KeanvwLnbEmKudpnNb/X6scHxcw?=
 =?us-ascii?Q?/CLrKskh1rl6rpFn5UAXCKq4zcv8TqYbceij2lbhw5CiPhZmqpFvzQbrkRsL?=
 =?us-ascii?Q?VuySxEy6dzujEo4H+/TGBEjS58xuMA73eTC1CQhl0suLXZ4ZXKkMH/9kYezV?=
 =?us-ascii?Q?Mvd0sz4ykx2sI23m44G0jVTznZDhoh9iWlzvixVROyrOVcc7y9pww11I4MzC?=
 =?us-ascii?Q?D4ABOZopfBFFpmZ9l1f2md22smD8IjDpr+qMlfUA5t7jmgp+SLa8um0WEpQC?=
 =?us-ascii?Q?nDA0wMBuUE2moONzzOBEf9NWr6krvPXxU0fwEO3hpztzsZvUJHDE8HCPG9RF?=
 =?us-ascii?Q?bh0QNNw6M92QFJV/Sp7P3eC24xOOlurRXpDKdyGgpHOscRaE1gqA5h+JAi1A?=
 =?us-ascii?Q?xgyRjKx+pSN9l3J/9T8NMLVJob0ubkAbBpXo4C/SI4B62Ye3yDUDRQpkY0hs?=
 =?us-ascii?Q?ABvxI8LHR7OToTjoy08oYbmqChxE5cfORBmx2y90tN/3N59zgkqZ2LSwN07h?=
 =?us-ascii?Q?qTFYDbsYFgecMT+rWVkGh/Od+SIgeNKftmGiXRA7bCOs8fyajWVd8nHWb589?=
 =?us-ascii?Q?uLRA6tab9crmT6wM8zp+rlRYV1+nePr1+2bjbbICGo8vItEEz9O+INwOi3vA?=
 =?us-ascii?Q?xCoMoMlFFW/wVJ4+fNSmsAbwV6TofdMpExRVeNsc/w4M3iegiWUQhBlgg1tI?=
 =?us-ascii?Q?yAm1GVaG6b8XHh4cPikPh8efQ/rS3iVnGXp8biJWaR3yAgXj8l1Ut7Cg79Gj?=
 =?us-ascii?Q?Qp7oHrP/9eOW7yTLTObA6kDS6Utmx/q34mDUrsFcOG3j5FdFqXtcQFrH5U2D?=
 =?us-ascii?Q?7Cmg6dYqhAtDgELpbx3XGmsLyNk1t6FoK+VPRbWjyg3rd/dh+zxFKIQabpo2?=
 =?us-ascii?Q?RVqNo9/Ud+RvesTxc7Yc6BCg4wZA/YA1EQYw8qeK295To82DoFPEMyiwXxU9?=
 =?us-ascii?Q?uqLJsf7NlfaLsX7oDtgM1INWyMdvBnFlWCAMPbI1akriBpwuN6fVsf50F+Im?=
 =?us-ascii?Q?DPw26oDGAVzzpENwO/iidZvfGKfiqnniM+VSQgAAvO5xqRkjGFIOuNB5wqjf?=
 =?us-ascii?Q?Yzd7dMBGZBbnY2rOr/MTJry+EQOKCcBvsZeXajoPelkXisvQa1MeVdPzIbyu?=
 =?us-ascii?Q?dLq63nhIN8/xKb3SvyZy67IHAP1lejOD8Czi54zD2PsT89QT6BskEiGawRgL?=
 =?us-ascii?Q?gk+ADDhPfNZLM9q0uxKjAEFW/CIWQxSAeZjQQ5knrUb65qUB/xb11aAHt1/W?=
 =?us-ascii?Q?6jiM7v+H1NGhN+xLwJgFv3Wg9lBC2CeN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/kBy/V7VN7n2LSTF/mpwtq6La6H/fx5LHX01/UQuGOWYKjNjWNIolxWJ27h/?=
 =?us-ascii?Q?Tr8+cDRqK6BMxc1DPiTcZiVtHd5bW1IISYFP+7ji+9vpGUsK7S0mZJjq4ccm?=
 =?us-ascii?Q?gm5CJascZ1kC3so3p5rFCd926klUGPH9ixdQR1e4XJ9v6sjLTKw8DteP8bVn?=
 =?us-ascii?Q?p5b1r0s//89duU0itstTHNXyzQFMnqaolWNdtI8ksBcScOkZpG1TswPp+wnN?=
 =?us-ascii?Q?QoEPfDLSbDT3K+aBr0fSmTGhHN4Uw/eMN3XQ2aV+mUukEP97lvoRz5FWC4se?=
 =?us-ascii?Q?krhJ8iKxj2GHPQ8Q48NnbyMvnHe8NFzx1qeLF7h0jnCN//wo9QWOH72ItK3D?=
 =?us-ascii?Q?lWPpCqICzyAqxEDEDa+kllO1YvFMyDY6zTWiI5MJheGBOKNeq64d8/U7Fzeg?=
 =?us-ascii?Q?yO1qCHCDBYR6g6GKUkdk/ZzMj+r+jlNsmxXXx5qGPGleox7ih56eNKGwYMAU?=
 =?us-ascii?Q?/okiJXeqn5swqWDZ6zMT3LoQtM2+24/j/uP0+OfKilUWyCo0wzRMSeMrxyMc?=
 =?us-ascii?Q?B4lDZbqR9Ar5G059KHLwpqbsExenW28kPsHgE9tvmqcPLLyg3zOzPahhnEdE?=
 =?us-ascii?Q?RjrNxP7D4r7qum6MA0f3fTTnOiVY/Jxjn240eBFsYspbfAV9IsBHA6geZxB8?=
 =?us-ascii?Q?A7jdy1i+gnDzMs7EgY+so5gwuxTEklNAp88g9fgGdgd66bZcfaz8mQiLlqoR?=
 =?us-ascii?Q?nRTLIKKQyUjwumeG6A+e7nJE2+ES/0L1t4Vckq7EKIeSEgYHczKHyqxs6DQp?=
 =?us-ascii?Q?L950EiPL+EXu3oS98tbyMN8kQgL29/q9lCcS9JKGYeqVCCFv21uvk1dDm2Pk?=
 =?us-ascii?Q?XTjugLlEfkrW/yLbYQJ4OBrqMSX9zpZEnxy/6vc0kQl0kdLHgMPdnQ0Fhxvc?=
 =?us-ascii?Q?XB5uzOKNVQ03wJ5MjO67yxYEgPU7ivsiha59CwVW1ebkYh7ZsxkGKfilpUE0?=
 =?us-ascii?Q?LTA9Chs5xwOgJZj1Vupn8VU8xE196PVARSr89d7FODCVg7T/Qhwt4GeYwg+u?=
 =?us-ascii?Q?M2btFE2io4WhridTZg+rkIs3rIeIQDOMdoBpkz7fvrnRtrI3afi8J8Z1WyS2?=
 =?us-ascii?Q?dSPraJjgcvhDQaPAY/E7sT7Cw4Hl9sllpx5cownxCHUoZW5W6kgpbToYVyWa?=
 =?us-ascii?Q?lo0C8Jyk0dXn5Q9PNv7L94osIsrGzPESDJFQV5cLhf0b3tKhbxvTKdmppQaq?=
 =?us-ascii?Q?AGWM/tipNOvWnizxuXM5xXqe8FqGi3VQGzLVXHBKJ38m3ZiuUBFxsnFu4aH4?=
 =?us-ascii?Q?VnCyjk4VXtyDTg0123dx2r93GImBuGGJL4xj6eT+InoxDXtTZhOM62J5uryI?=
 =?us-ascii?Q?wYaAzbbEYtthPHr5Ldz1v5d+9WuByfj1qSY6/ojCj3HDWBSf2D/KJbdI0YbA?=
 =?us-ascii?Q?mcbVxUHqTJHrLbVP4rYNYS3g/Xoa8X7D85oNxY8B+RoDvsJPpvbp+hg+BQts?=
 =?us-ascii?Q?SJMAqNVKwC7H19oL9fzFCYpyeYlGWMQ6GGQv9hBMCdyVjJXC63C+RIGAZXLi?=
 =?us-ascii?Q?skXAddAdCzYzPiDTsFCaoQofpe2NyQjHnLQBSPrlG/lu22AKtD65bCv0sHwt?=
 =?us-ascii?Q?gpHxxo5VhHmY4nJD6NiqliTNQXkvuv6VL3BmA479KmAHW1dx1vjTpUuhAxH1?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IgPQFcXtTcCgzBwG8nd16MrAMpLDXY3Kw1yOMi5Gf/XZ0QFbAYPpwviV3+280DyJI1e+tKeZ2tjVZOnytxlNcobGqQ2O3wdxjtrhcj4bHMepjotx/VBjPN1D5Q2JzCW/n8kYOkuKwU4wpF3f3LBQb4k1rCWWqjaHsNrBsDTy6ADvYu1RJnXCJ3UkWYRt0yaUQf6fqR7hUti5To4p/+r9XU6Sdb4CBf57J8WbHUu8+RfEntfvYm6/Z8Gop8GjmZrryitJ8ZBPIBH6yCgJyV5RLTu9DJwyDgkepXQMksoP2AoiX3ZtlrUehNC5aiDshbxX2ySh8O38Vpe2P2pFHpTDrKfIygSMIte1yaVhXZ63BEuMEOiwrpnfcc2+AdlOZ8nN6QpdctXpjEngQAiT8cCI6qAdZ3A9/yTuypC0eGRJ+fDFn3MlfR01ypBISKCuEs+Yz/GUN5AYBi877Q+pTAK4FmDkskz2B9xaGTs3R2PxOHhYcoOqoO/sDEHusFSXu3YNrhWioUx8kNB2EH+/yTR7smPdPTlOGpMVJGUymVs4G9SRKTZfen3L2f1ZXvL82cAXV/J/TkNMcCXuwz3dJTr3kt8HEbe7j2w0kk2bOFTaXGA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5f290e-1c32-48df-5996-08de2933d13c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 19:26:06.4370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCB6iBKHVkw5SEAsRTifhZ0V7kXAuYOdJQIk0h9ronkYFUie2S4x4QsusrzMKSwYUpXZ1YZ2IOh/kK7IizTcj6G1UnkMaf2uBVoDw8xNR5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4541
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_05,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511210147
X-Authority-Analysis: v=2.4 cv=BoqQAIX5 c=1 sm=1 tr=0 ts=6920bcd5 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=_x31dzYN4GugQ5JSwxYA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12099
X-Proofpoint-ORIG-GUID: 8d7RJpT6QU2_4ysfeTWTTNGTEnr-YDJ0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX+0j2UN2q7K5q
 RlGkas3gvQEmmTzeDWVDkw0t0OQSoprpsgCuC3r304JQKviUBERLUUowVaHQaNAoI7MnEPP2oYk
 0QEptnhGLzrYxSZhMuso0HVXu/TQhGD7QMXu/MQ3T3ekhdYY/NFFu6ZKQGvB8zmcylXQ3VrWeAw
 Je1h+pivMrW5TZ+TWx+aKTQ17/7zk9gbzCnFdKOX1Fkbro4qIE2qQObsUy9b4p0l1CBrpG0HWpC
 ob0BbYNmiKVzCqknKhcfCZEPUGPTEWmyxAZXEkLZK4I7UKNjv/Q7HIrjdGzBPB/XYFD5vL4ZP+G
 xJVJGvwxqfbYElYAs+L5BNhgVl7wZIR+Qts8r9d1xTsBVrQISUS1ZQydFxIjHExBH50pyEsjIn5
 u5cxG24XMmVBA31qaTjfTM+oDcK/qWGxEoaN7lzBEKFCLFqty4c=
X-Proofpoint-GUID: 8d7RJpT6QU2_4ysfeTWTTNGTEnr-YDJ0

On Fri, Nov 21, 2025 at 10:51:31AM -0800, Andrew Morton wrote:
> On Fri, 21 Nov 2025 17:44:43 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > As Vlastimil noticed, something has gone fairly horribly wrong here in the
> > actual commit [0] vs. the patch here for tools/testing/vma/vma_internal.h.
> >
> > We should only have the delta shown here, let me know if I need to help with a
> > conflict resolution! :)
>
> OK, thanks, easy fix.

Perfect, thanks! :)

Cheers, Lorenzo

