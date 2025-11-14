Return-Path: <linux-fsdevel+bounces-68499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DFBC5D744
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 14:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE163ADCC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 13:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4074E31AF2D;
	Fri, 14 Nov 2025 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p1irbOEh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z9NczmV2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F412A23EA8C;
	Fri, 14 Nov 2025 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763128705; cv=fail; b=SZ2Mh2LGHtPBgenRGMK+9bRN1YhPC1rQG4yXFpf2p5/PrISVYAHRT5xEQvA6/2hxEaBjTwEA2+oN1GeYuiAt/9bgRLuzvBCEidd1KVx4GvEXQOqMfggfUTu9l/ldv+5k3cAI55l/JS7/RVF3L1QFXlVnU6xaGwh9g+iaIeAxceI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763128705; c=relaxed/simple;
	bh=m2M8EVmVcsnspvlT7KcPF7a/HaTaFSVYtcZmXua0y5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tevAcLB0UY8Cslv7rKO9S4sk+qkbckTzDDz9U9WKziMFxz4pZHIw+N1INgRLiXsH4ElwGQLwGCXMV3fhYR8SlWyEZy2ZMjFmjThFtVrJe9Uqrqqpt0/8OIM569q40ETlMQ5r4i9ifzgXEyE1ROQ7/EGQkTVW0xYen8+1cOwtmTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p1irbOEh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z9NczmV2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AECuMjN009348;
	Fri, 14 Nov 2025 13:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=SUMKclVBzx2EOjepMV
	2sCiOsBxSJuoBarCMKssAsb7I=; b=p1irbOEhyTmgmh6SocQ/3mf1Gx3gUo/NgU
	BItfVzk23QeN9qiAs3sO1WniOVBh8BnZvpJgr9eliZ1mOKdFQDkhKGs8dBh+ED0Q
	w217asY1iIeWsQ1Q/Jl0rD6TDHWGWROoogWaDNxPR+J0ZA7eOIp3kYVkfCVd6Lv7
	JKHaJnyWQthcrjk7H15sitF+A+zrhiMGWxLUTd5Ch2x6memey7Hqn9pYZfeVeWOb
	ILxA4++CYJ8AJHJXzYXTLrqMFB5NUWc5ob6aKoa/PbT9OGwILCe/KseBuZebfiGw
	YHfdtVhdDZuYY9k631VZu9XJUqnu7MPD9s4LCMyxLgVUuhcfcypg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4adr8v172e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 13:55:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AEBmPmd027830;
	Fri, 14 Nov 2025 13:55:55 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vahn3k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 13:55:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rr3q+rHd2eNTYotjWH8gVrxlL5311ADu7mRTpTd7q40nCQJHJ8kLxlVwXVvuUXxfNT03xJtqhOdKFi8RnIuhJ1OhrN6es3aVpC+4J1FZhNvONd7T7ENV5LS0v2M8Xn/17OQcpTUL3Q/qEqZxidIxVHf/c9XOTAqBTN2VApVlYt3IPsdJrn1gU+GWc8eupXVSFjD/rHH3WikGBbtBeqKDYtUJL7O8Hbsdhf4YDC7OHYw0svN6G8HHbWMvsEZ9bJcWuweY7dRBh4NBPICwj4asuLFBVuzJAZ8bst0OXcSuv5otWj4oP+/LSgTkrGb+NdDSGNgBiToUUXmxZzm/3Y08PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUMKclVBzx2EOjepMV2sCiOsBxSJuoBarCMKssAsb7I=;
 b=BSasAoR20BIhGLRhmFb1ThSQbMzMY312/TRZUM4x+oCHN6o3xOdjxD598m6/SWSdVEcB5ZEsJaYZ9qKX2Iu7ZPOXD4LK1yEXl6JC48AmBcCu1Zei5G7nPlovz4BD8nNx5o2C/8RB5z4Yi5BR2U8gmV6Xsa6+fZJ6VT+KekGGp7dP2yiBWQr+oTjxA5sGTkftdL9qIgbEb7OF+afjZzeZgGB7JxJLMUafvlANqAag3I5BHqtxONJJRF3jt4VpDFWsV5foAF48lHoYhWc5vGOcQJ8vC0a8surufjJaFfb1639xe99pBVIthG6KdWNRX2YsfaRlCKvQmWXGMOSyIibXYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUMKclVBzx2EOjepMV2sCiOsBxSJuoBarCMKssAsb7I=;
 b=z9NczmV2vS82yJtk0RMd86NebnNBKQjEQmHPioUxZthE3aijWhVZ+T3Kh9ra+vLYWAAO6S9LwRTWSRyxwOIqX1MlAvsm9KmWKgdZe6IioDS6sBTy8S8M7EodU+UYcr1OuIMbmGTVc4pqEUd5qVeQ0YVda0GdU6C716867XeFh3o=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6594.namprd10.prod.outlook.com (2603:10b6:806:2aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 13:55:51 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 13:55:51 +0000
Date: Fri, 14 Nov 2025 13:55:48 +0000
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
Message-ID: <e98d913e-71bc-4b58-95ec-8ae054c43120@lucifer.local>
References: <cover.1763126447.git.lorenzo.stoakes@oracle.com>
 <6289d60b6731ea7a111c87c87fb8486881151c25.1763126447.git.lorenzo.stoakes@oracle.com>
 <aRcztRaDVyiDO7aH@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRcztRaDVyiDO7aH@google.com>
X-ClientProxiedBy: LO4P123CA0326.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ec35a40-9529-466f-b37e-08de23858575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AdigMA8AMn4890S8j904qz+v8b5gLpFJZoMp83HmlKj5YfbSjljYQ9w54c/5?=
 =?us-ascii?Q?ZQpTk8iLzi3E5w56wsBa6EkNXv/kGdJtmg8OPVao2Al3eFPkCbIChWmSkTh8?=
 =?us-ascii?Q?4XL5cLczQkky9bPPHp0lOJyTB2dTk/hkH7G7mQEU5xlg8O124+xO6fNGh2Pu?=
 =?us-ascii?Q?pGz0DqtD3zY8qjyy+O4a2qA8V/4h7Ytvg43lC7o6OGIMj2Er13HelHoOh7D4?=
 =?us-ascii?Q?v7x3NyrqtW3AKWpdGMky1y9JHjkKzdwBzTBdt8yNKib4FsL+rCqOcJatHBsE?=
 =?us-ascii?Q?VRdJ01aMKHGVSHp8kKiEwkJB57iQpb0KBxYS2jY49hRKXBt5E0xtKtvtdbOb?=
 =?us-ascii?Q?JwA7aH429MAFcnTDr0F4VNZMvf5Los4qYcpW87LGWroPW6KF3kgBXYg1nqoY?=
 =?us-ascii?Q?VrcJzTL/BpC0CCxRsjqyPy/ee+xHHzpLDDRfJwwXQRuCLKvyNj67Ltwa091M?=
 =?us-ascii?Q?Z9rAdr/0rdNGU18yTZsSWf1g0ijrf7xXG/R3+N+oAd850jCtekQHq7Ijo3uh?=
 =?us-ascii?Q?HnyUkM7SmqRJzZVi+RuwR1g2pBcKGZhGNlGPa0G1AxFgJq2qRPC7LQYoAOZy?=
 =?us-ascii?Q?ZLNexOkYpAekpMXyq6upO+lLW4mTjhKb8W02RBjmRv25dDBoi0kk6YH09wKt?=
 =?us-ascii?Q?jwSkd6DVNbOE88uk3XXve/sRyPPDUu2l51t2mfz0ybcFSJ8ogNmU/G4or5Gq?=
 =?us-ascii?Q?TXlnqSpMSQwxsJW0xvdfnjpg9lLinMPnB0/rJ/Vw1jguU1TllbYy4G0rWGjf?=
 =?us-ascii?Q?36B7+rYU5KQMMqwwf0O+SLnODgiRs3XvxL7vAQWqz0vGlp8A9VR3IYIPCrug?=
 =?us-ascii?Q?brqQdvTsBt9yQo7xjPSiJJ7U+cb97YRJI27CyDLj9W6JJ7gOasNS/tEc1cOm?=
 =?us-ascii?Q?tZhA2QdSeLroRGxamI3t/wKUef18AhPT1D4agzxeEo2g8Ole/X6X/9b78BEm?=
 =?us-ascii?Q?58U5ud3jDeA846+HbG8ND7T9W6PcF5/eAtm4DSFTowpGIhlMzu40xNr8Jm4u?=
 =?us-ascii?Q?fKSdU5lGh7Wh9Wwipv4mlseuCCVL1Xk6X+MFB/IEgK+6k3waflPhkkFW9uNM?=
 =?us-ascii?Q?7LFmiZ7EbyBlNrN/QqADUzePemPQwmWhdF/6t5ZXCJykzAy5qtUystVIbOPU?=
 =?us-ascii?Q?l/wuqdFjYxId6jbp6fA7tFlnVrHSwyVi4Q7Z62APRz6Bmfwpah2oFetHavic?=
 =?us-ascii?Q?vcR36MwC4BipkYvxjF9kTv17U5lL6HYv/MHUqYTrEcV6FcGjPFDJwQy2rb59?=
 =?us-ascii?Q?R2SnPlQSnnJnGT1TQIXoObDdiLZTQIh01UA3i9XQJqh2U7rfRl7j1bTkFgdZ?=
 =?us-ascii?Q?R7EZFl/C0OY0p8up4zlrN4hO/lokbZh8UyVyzfxN33cfUG1EeqoO5ecnCD/L?=
 =?us-ascii?Q?Wsp8lmGWpzkHlXt6EL1ZJOj7aPneLqJw/wYHaqWMWV27h8Zzr5+/wVMcN6b7?=
 =?us-ascii?Q?2m4E0yvTLL9c3xxms67wUSs/DqCFnJ0y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p+M093dWDJcwos180ZupREIXlrvScta9aWlWXxl3aKJYFOeAAGW6FdF3tamP?=
 =?us-ascii?Q?5ZfsBmK7YZFTwbF8dYa2NoO/gEYxa/MG6hffid+NcxY3wWoDcwJZMXB0N+z3?=
 =?us-ascii?Q?EiHGh0g8GvzG1v1nBMoaHzPKWHAbhjFtBJ0VW9xn4Lv3HuqdKw4GY1Ff5jv2?=
 =?us-ascii?Q?bhYZBRtFlgMeDKPwewdXEbJEvdgjXr/CergoM2sJud+DKkSTPnvNobwZWyy7?=
 =?us-ascii?Q?FNb/b83RpLByBQMzHE4OT0+jSefUNtjSpA/pewhucGhFOERAk+QzlT+AEgd0?=
 =?us-ascii?Q?CwweXqqxNfUasjaKRzaTd9WAWrnwKwZIJ0zAHMz26vKivGuImvcWkFBdn3ud?=
 =?us-ascii?Q?psYM9h5frLE5SV3Ghoq0A5hB3UwJZjCIMKrO2/WFBIa6sChcKVEFfMtIULyi?=
 =?us-ascii?Q?opel/VN2xUr4KP8ndviEjPyTJ4C2BMHMyeAETidLKSQ4VCpG3xtE9uHnamWQ?=
 =?us-ascii?Q?0AoAOAsP+x5wbZRmog/aTBe349RnbAXFbob3c/f1tUUUVGg2TfVo5K0pdk0p?=
 =?us-ascii?Q?EuTgc0KcpLM4XB6PF37aDmL0i2SrJVygly4ECi0Msi0sMxFn7OGcRmBzImF8?=
 =?us-ascii?Q?1KUTfNjc6SaQhbfLRjs6Wj5aZ+JgbcS3+vXVSMI7CmWqWlbRN8DpmBFv85VJ?=
 =?us-ascii?Q?2TlK6UqIFDZE/KxJKFmEUXfAYS1OEi7xCZHrnCy450Xnz+1FHCwzf/NmPIJc?=
 =?us-ascii?Q?HaiAZkUKMpNBbMazHUIMluN3ZTX2sLHpnX7DixKUQzTlfMzNTB/kTm/P7ggI?=
 =?us-ascii?Q?Y4NoJo3N16Bg6L1tUUW4B8Gne+k6tXPAfLK7Itb5ZUlwxGjMBRhFihfm+J06?=
 =?us-ascii?Q?4mJv8Xo7pCyUlUoNwr6kGs/JC564eUj1iR4Cfv99yzJ5jL0u5DeGa3mHaozs?=
 =?us-ascii?Q?VIkk4TLyVtxjohlJbOD+CMSe1jTQoWHk3FPacpcBgQ4aM6DYAIXl3u3kTk2p?=
 =?us-ascii?Q?T9JjkikVzO407jgwbSzVQBW9R+ECEg8thtql6GCnhviyjToC3umT32SA+dLW?=
 =?us-ascii?Q?EpnQMrKt8BikBVWPA9v4j1wTcA6NlhCfIGlz8+cvYn/sYDXm2u57aAizkQ83?=
 =?us-ascii?Q?in0q3Obt1EWsGqsUX1QCPttZrW7eAeOcyTFWArXzV7o4mm8Bygs1G9/82sy9?=
 =?us-ascii?Q?4M0+LS52EAHQwxu3EfHC52/+izbqPTDLF0dfRVSVxoJyJIgAsFlOtSWmM+fy?=
 =?us-ascii?Q?c3MQuNhUrmIYadiRzHbJO1BktPyyHUCyVHDfDEhDnWsIwX+E97K/7eghybJl?=
 =?us-ascii?Q?ZmFwsZuqyb70h3nqjBw0KAz0Gpw8MPzq19CRnSC3aF0kFUYvp/SVeW3PPl3h?=
 =?us-ascii?Q?2P5xH5reTZ5Mzd6Y+W5VPc4ECzqq0zyLyzxqndGf9SUMAfDu/NJ1ZfNwcVDt?=
 =?us-ascii?Q?X4/BBPhciiqegC/upecsX4BOFvuCrT+QjTQjsbSHNMaSlv5aDxVYqgjrBqGf?=
 =?us-ascii?Q?ZSL2aMJdCcqW+7JJHrqiUYxe6CZvCGQ8mi9Oho5jhbrbh0kiVXhkGkmzOqS8?=
 =?us-ascii?Q?kxqCYDdQdlQ3o5usI+cuUrsW/s3KTtnB29RAlL1rgXFd6PicSzyzEKqrg2Xi?=
 =?us-ascii?Q?8dKi6NOM5oG7sHJjB71yasWlg1SVyFNoM9GWgvTooUIsMEZzyU7cbaq9tXFE?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	krUlk5SOaHYE2J5VTDkL0N182ZQJYfnsAKL6IKQ/aJM/xqCWK2L3FFIkDyqc2b7qSuPJV8gKTBOP3UtQzCzktCYQYgVY8tiN61DmFeVFcOdQqc0sm7xltztBU2OkE2x8C4RRwMw5s1Gdbe8CWsrTyIOf+sTidpHj+GRqbrDgcBqSx3gDhnO+waVohO9HqeebvWI4ZhWApEQZxt9DjpQ0rGnkhmtO0EHu2QLhk8DGX0kpCfyPLzmHIl82zV8hj+zLLlTs8pDgCqu3blf6rB5pyor3QNgTmG2ZHthV0sePkJrlMAvXGhwA0XUgmM/uXCXvLuiomew5KmuKmKXcQ0Nh+grWBj9DY8lWGL+LdWJfrECX3OLICdR4SS+phVHpGMjXe+xzf9A7nVw6w81wYmKK5gRGVY0wiXvygUIzUREZ3QgF4GScio1pEHjs2ijvM+kVTqsZJ2FJReljbHDQrVQkg/VopLLFOxeoMBWBJ4lqskF7ix3yoPAFMuHyK8uYNqlZG6pR2FWhJNnBJvJiUlp+xqNqCNqhd0p5+6Md8k2Jc9JWxDhRybbr9idbBj4MgD9oI2y9/3YKN8xAuG/19lCqSdGBumjovA/WJBskwVbMCgA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec35a40-9529-466f-b37e-08de23858575
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 13:55:51.2075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oIwU7S4UrU2gl2vzoLK7vdgVAi6cuPr42ZlH13tEk2X84qt+ZMCoTk3prsVHVa20EONRrfK2PtgN4YnPzCVGgTC9EbGe5ygbL57wF97P0kQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6594
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511140111
X-Authority-Analysis: v=2.4 cv=YP6SCBGx c=1 sm=1 tr=0 ts=691734eb b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=LCONacxMZmM5ZyJIYTgA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13643
X-Proofpoint-ORIG-GUID: mtF9EFMoVsT8cdqbeEUGaRVXIL-OWEuI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OCBTYWx0ZWRfX+OeQe3iebGpO
 NlskpcPpVvj99gNmlbP/2E5gfxyVmLdwiQOINVIlzDG2G12SOwaDbYcQQxAc7uwmnlzhA0ympdB
 eqxBhq1unxwtfbolh+Ylnu8qPs0/SwLQ1gxVPsUAk+gBkZJqKDvc7TNTdGLrzwqBAolSTux9pKf
 zoCfJBGBq1Xs/5R4STE7jQoN126IVrlilpRFd5JdNbMG8pUBmj+6etfdG/3uh4y6psBz4/ZQs7W
 ZMAPsFJfjrZ+0gtvZSuyRzkPceKm1LRO2E+NBXBv22f10+aR5G4ReMO64eYO3hY05FOBf4/QM1g
 +wk4pg1WeYUmgtCqbjDH27X7RGtaIqiq20O8pVY9erpansGQLoPmXnGIPsTJlkAwt9kSeT6hph5
 k1Wzc4nMMEkf7yYwEYo+eQyqyKs5f3PkuBrqazEELADD2Xdd6A8=
X-Proofpoint-GUID: mtF9EFMoVsT8cdqbeEUGaRVXIL-OWEuI

On Fri, Nov 14, 2025 at 01:50:45PM +0000, Alice Ryhl wrote:
> On Fri, Nov 14, 2025 at 01:26:08PM +0000, Lorenzo Stoakes wrote:
> > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> > index 2e43c66635a2..4c327db01ca0 100644
> > --- a/rust/bindings/bindings_helper.h
> > +++ b/rust/bindings/bindings_helper.h
> > @@ -108,7 +108,32 @@ const xa_mark_t RUST_CONST_HELPER_XA_PRESENT = XA_PRESENT;
> >
> >  const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC = XA_FLAGS_ALLOC;
> >  const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC1 = XA_FLAGS_ALLOC1;
> > +
> >  const vm_flags_t RUST_CONST_HELPER_VM_MERGEABLE = VM_MERGEABLE;
> > +const vm_flags_t RUST_CONST_HELPER_VM_READ = VM_READ;
> > +const vm_flags_t RUST_CONST_HELPER_VM_WRITE = VM_WRITE;
> > +const vm_flags_t RUST_CONST_HELPER_VM_EXEC = VM_EXEC;
> > +const vm_flags_t RUST_CONST_HELPER_VM_SHARED = VM_SHARED;
> > +const vm_flags_t RUST_CONST_HELPER_VM_MAYREAD = VM_MAYREAD;
> > +const vm_flags_t RUST_CONST_HELPER_VM_MAYWRITE = VM_MAYWRITE;
> > +const vm_flags_t RUST_CONST_HELPER_VM_MAYEXEC = VM_MAYEXEC;
> > +const vm_flags_t RUST_CONST_HELPER_VM_MAYSHARE = VM_MAYEXEC;
> > +const vm_flags_t RUST_CONST_HELPER_VM_PFNMAP = VM_PFNMAP;
> > +const vm_flags_t RUST_CONST_HELPER_VM_IO = VM_IO;
> > +const vm_flags_t RUST_CONST_HELPER_VM_DONTCOPY = VM_DONTCOPY;
> > +const vm_flags_t RUST_CONST_HELPER_VM_DONTEXPAND = VM_DONTEXPAND;
> > +const vm_flags_t RUST_CONST_HELPER_VM_LOCKONFAULT = VM_LOCKONFAULT;
> > +const vm_flags_t RUST_CONST_HELPER_VM_ACCOUNT = VM_ACCOUNT;
> > +const vm_flags_t RUST_CONST_HELPER_VM_NORESERVE = VM_NORESERVE;
> > +const vm_flags_t RUST_CONST_HELPER_VM_HUGETLB = VM_HUGETLB;
> > +const vm_flags_t RUST_CONST_HELPER_VM_SYNC = VM_SYNC;
> > +const vm_flags_t RUST_CONST_HELPER_VM_ARCH_1 = VM_ARCH_1;
> > +const vm_flags_t RUST_CONST_HELPER_VM_WIPEONFORK = VM_WIPEONFORK;
> > +const vm_flags_t RUST_CONST_HELPER_VM_DONTDUMP = VM_DONTDUMP;
> > +const vm_flags_t RUST_CONST_HELPER_VM_SOFTDIRTY = VM_SOFTDIRTY;
> > +const vm_flags_t RUST_CONST_HELPER_VM_MIXEDMAP = VM_MIXEDMAP;
> > +const vm_flags_t RUST_CONST_HELPER_VM_HUGEPAGE = VM_HUGEPAGE;
> > +const vm_flags_t RUST_CONST_HELPER_VM_NOHUGEPAGE = VM_NOHUGEPAGE;
>
> I got this error:
>
> error[E0428]: the name `VM_SOFTDIRTY` is defined multiple times
>       --> rust/bindings/bindings_generated.rs:115967:1
>        |
> 13440  | pub const VM_SOFTDIRTY: u32 = 0;
>        | -------------------------------- previous definition of the value `VM_SOFTDIRTY` here
> ...
> 115967 | pub const VM_SOFTDIRTY: vm_flags_t = 0;
>        | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ `VM_SOFTDIRTY` redefined here
>        |
>        = note: `VM_SOFTDIRTY` must be defined only once in the value namespace of this module
>

That's odd, obviously I build tested this and didn't get the same error.

Be good to know what config options to enable for testing for rust. I repro'd
the previously reported issues, and new ones since I'm now declaring these
values consistently using BIT().

But in my build locally, no errors with LLVM=1 and CONFIG_RUST=y.

> Please add the constants in rust/bindgen_parameters next to
> ARCH_KMALLOC_MINALIGN to avoid this error. This ensures that only the
> version from bindings_helper.h is generated.

As in

--block-list-item <VM_blah> for every flag?

>
> Alice

Thanks, Lorenzo

