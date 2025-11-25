Return-Path: <linux-fsdevel+bounces-69755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF507C8459C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 11:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37C734E8B95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 10:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01BC2EE617;
	Tue, 25 Nov 2025 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kKD59vLY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ChQ7Wm6u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2F423E358;
	Tue, 25 Nov 2025 10:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764065036; cv=fail; b=VZ+wAynTYH5OmKxB9xcW9SFIWFBiaIf9U9akXdHaDBW9mhfiHIZt7y+5CQGwvOmc8cjpTGQEcorkPl2ZNCnqXBslWGo9Y24aC3BoPGayORdOkelC6oIEdFRGiXYGSLsxQ/HiHYM93G/5SHfihT5X9UKuE3A8rNzz05MQKDQXeag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764065036; c=relaxed/simple;
	bh=jqEhQPR2OJ6so7woi0A65/YfCl0yi/A5b6S7e7o2DBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RjLRBCifaSHMOvjbJGeGUNDNPLWKkdDVHq6bCKnDX9kVK+zgOWW0yoH1Jla01FgGZUPrvbGFYlJA3JYEL4xVh5OmaZgDx65S5hto9unWrdTIbPAMt2QQNmFzTyYFdVUrjVNBi7vAHGgWYwBGvwnGT4esgm33FWYKbzp1VFR6Tqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kKD59vLY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ChQ7Wm6u; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP9dbdQ2388594;
	Tue, 25 Nov 2025 10:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gQg+Q5Fvne5QnCfJpnFClJIVYpMAkM8IpzhG4G5x4Rg=; b=
	kKD59vLYSmSYjc3ORNvEn9XaO2MsfkwQJqYelcjCdqZCsBOkgB51M0hhXZDBvRZC
	AfnXxYeiDEXZK5LjjnZclA2lmepBhPeuMaLbwk5U8LjC+7HhkhMHakHtVqLNdbNw
	fm0PiVFsUmrEu2hCTSlWcv+D2amqjzQALcIKHCqftoMBTm9YTDIXGmADClIcUN4Z
	HUsKgCeG3Zr7oZJzQ9NRIAVb3pzM59Y602oOrZ4N02eEYaVSSaG0PjaIqN6ZqVtz
	EvT0AvlnamrENS4bYn9Dq6bLmoNuIPdyi7VAM3rG6TDEpFJ/6X0cUsEaPMTH/vd2
	9DgUAZ0c2k+BXfEEX5Lz4g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak7yhm7uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 10:01:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AP9tKNL022443;
	Tue, 25 Nov 2025 10:01:18 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mk9r4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 10:01:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIWcyz7gJD360snygYESBfn8cLVCK9r8QxPRC8DB6JxVvDGwtbpBSeS3PeKk/d6bPPgR4SZFu7mOPVLZJamqezx40cG7tUQ/1weUUdenIFLDkhOJrHWQoCmY3vUZBlDtcqNy82IqAte7XXx56oL+cfjiEpt9OKdG5W5NIMgLmRdM5MuyWqqWqTN5dFl1iPM5ClE7XRE8jVPPrPdAJZymi+nC09L/lVcdFecpngpakQBQdMOQNf2xwliakR+ios0oUBAcrNXNMysnLl2kSrA8CEsKAnvwmaXqeTMqtC2anPV3kTu+ftxRnvZKM/IAnFp7SsOvILllorYAVz+5GH6bYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQg+Q5Fvne5QnCfJpnFClJIVYpMAkM8IpzhG4G5x4Rg=;
 b=Re6Ve9bUruQIvjqXghDBl+LFZKYn2GNcfKpC4XZum/K1nQ+FVvBbPTXe2Nmji5guGtLMIXrzVWsc1NO855uqmHBTYLYOKK+EzJ6YZg2jgGMZ5bW6A1iHKWczb1AJzkyDj22sv7Q/RYtfYfjFDUuchp+fxKrCbBnbyVWejHevvl4z+JNYkkn6lngyHuoMt8Is9mEyePropuFdG3gR47jm7Zs3dneGz1r6DY+HC30kzjT6TXtwaH4AIa+KxuBVFEV83BA4EyHaTDOpuh0ufG5ib1+Cg77hmqVlbrtAp/zONgx4fYnok0m/wqCSgCd7Z9IX3OdWJYKBR8Ml1Y2R4wE2cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQg+Q5Fvne5QnCfJpnFClJIVYpMAkM8IpzhG4G5x4Rg=;
 b=ChQ7Wm6uN49DhyqsiNaDeRdtXGUv01Bh0dohp2dacxWiaT/zRR+SmLDmRAi4YAZPFrM8a31ow0nmonDK6EhJQVPYIELxJIaV5SCU9D00h1qoTNPJLnJ4G+Uj8a2vWBOUuaAIDyqaTD/CWSsztQsPT18tKluvvwVGjxZQXLVC+sc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV8PR10MB7798.namprd10.prod.outlook.com (2603:10b6:408:1f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 10:01:13 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 10:01:12 +0000
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
Subject: [PATCH v3 2/4] mm: simplify and rename mm flags function for clarity
Date: Tue, 25 Nov 2025 10:01:00 +0000
Message-ID: <8f0bc556e1b90eca8ea5eba41f8d5d3f9cd7c98a.1764064557.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1764064556.git.lorenzo.stoakes@oracle.com>
References: <cover.1764064556.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0027.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV8PR10MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: d6bc2331-174e-495c-2a2c-08de2c099069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Or71jeNVJ9Kc1Z56Jb077c6ATnET4ncNdl/lw6cDnzeak0bOj4dZz/G2aVE6?=
 =?us-ascii?Q?ti2DnLPMCb88fj4Id/cNhGQuruWmc9JEhRAb4Wr5j2zcjBhHYmBg2lhVXq2l?=
 =?us-ascii?Q?V94gIwmDbDlJ/lnnDwMwLpNkA3llzXbkH2NSJdh7fHhzjf5ACRFFUycBOyOp?=
 =?us-ascii?Q?JUUGtjup5DPqluGpNU/keq/tqSdqwV/e8j6Osrd4325AnVQ9Dp67gZIr9HX1?=
 =?us-ascii?Q?LBY/0chaCNMNmYj9mXyMxOr+07dh7jI19oNrTBrPxRJ1RuSQ2NA2+Fud48Pe?=
 =?us-ascii?Q?BWeS6zWAvQi+Hq29tffQjED+5GjD1gJ4NXr1SzBXsvWUYIIP9SB75RKEXpbq?=
 =?us-ascii?Q?bud6/LeP6VSjxfXwTtbs/vMEkVkRVEVRyc+nW7Mad9b79wNQ7qfYd6APak2T?=
 =?us-ascii?Q?EmA1q2k5z72282ZpxsbgcnhOH0EIjpwCSXo2UJgYFPPfyzOimNdPuzpW76X8?=
 =?us-ascii?Q?nl7acYwmekg2nd7nPAif4xzM3PwGzy1CG1jbRtXpr5i6nB7Fc/ZSQSq1pwJL?=
 =?us-ascii?Q?N23X8YW0tmvguH17ucNOWR9f0SkgGGxpBtvEwrZQ/JtMHWrfZq9/k284LSMT?=
 =?us-ascii?Q?KxHRcbsZ5/qOZXXShXj6SNBt476ZZWy12XgkI4ZzOmrUO0ZIaBAkKhRz2fGx?=
 =?us-ascii?Q?w2F83GrSuPVO908/9OEV9xbWLfRlDEnhER0bTzuvRNagbhPl6p4kLQmB1UCo?=
 =?us-ascii?Q?pbaK3kIoSvx1lInFmc/g42FepIvzLpt2FvdJhJzJTkp8NI5sGaHepjTopyJf?=
 =?us-ascii?Q?FNiyYmU978YunK7CSJ47VzR5LTRrRCNAKgDaeJFuLYxFwyojqWBntV2g2ECr?=
 =?us-ascii?Q?vZ2+oso0tQsrM06mgrhDzzGv7N0H9IWmYoj/uQcHU+F3R1VTKLumsQ+ERkhE?=
 =?us-ascii?Q?B27epqpuqrLtQmeEb0UgFEpJSI1Aloy6XAaNoQWx4bb1DyjYFtFygI9Pn6iU?=
 =?us-ascii?Q?hMBEsz2DYhM0+SCDEvZ+aAck0oYhz1yon4a3iBPYciLbQnqZhnTsfppNdjBi?=
 =?us-ascii?Q?2H1KrH9Qq5IYJwkFT2i6guJwmvl/j+0lXDDWLcm6nIXTa/hpQTAnbXoP0jkE?=
 =?us-ascii?Q?GzAdXwmfEHsUIRns6ySpqwYwGCWYyI2TO/Ln93fD30ZK5vcQzN/88YsOGvTT?=
 =?us-ascii?Q?aLHdIJ+6nl6xZXRXnO/Uo+0/Bpn6cFilvBBXAJXDVuyIUM9RmfnVHE+eJNWR?=
 =?us-ascii?Q?tf9djvM8//7I26JskqertKt/kIjsKnpM39on4QFwVYIn3zZkZiWCLABHfhTS?=
 =?us-ascii?Q?C56FbFruHTfPi5LcGO32TJV7kz2R6Zn+Hw+Bj2+Fd+gIOgSq5bQDNWC2rnzG?=
 =?us-ascii?Q?pSstNjN1amZeDev7f7MQ+9LrPlMiC0wgNkcjy0rmnN2oyH9wu/DoJ/PhMt1J?=
 =?us-ascii?Q?+ShalfeuuyIGWANVj7/rRWHnJMq+u1fOZJd57IDPRrZXFId9+/BKCiRZOpA4?=
 =?us-ascii?Q?XgY8l3PZVM82uhVmmN0z9GqHeynLBEUL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h/V8//XONHzTSN/guvJI7NVru/sOkVMEGJXpxKaFlVPxXU3cpeYAg77VBCF9?=
 =?us-ascii?Q?BTAGXLHs0OHmBLk7T41x/sHtT+Npq8ooS6WN3omEjxhveRBEPjntE7l8Qks8?=
 =?us-ascii?Q?j8tGVyzCOmHYcZVls3kLcC8nyM+Dy65hDbnPZP8lxvDSFOQplq6ki0/uBoRs?=
 =?us-ascii?Q?el/s2cNDKnTJSyNhAY/yOY1iv2dp1OOWykPfrmY2AOSv4C/S0qBAL+cyp59x?=
 =?us-ascii?Q?ROmBAPynDyQvCMwWZuiDtSUbqUXkNd+rpHLbbAXeCuygL1u4sa+zEWW3Jl+1?=
 =?us-ascii?Q?Dr5idz3I+14TfKwFEmudXxsVaqKV3DVjNaLLYDoBCFdiLziJCPNbGiWGy9C8?=
 =?us-ascii?Q?iomEn2TxldZIKbXPuMckEW/KJgp/GpydjcigpwCIVcjys8fz78I3W/DmLdZs?=
 =?us-ascii?Q?UaBYdkZ3ZkZsmGBeVgwGp1QiEBzFPQmH31CRr+fDnbwcI5OIthrySZVQDiP8?=
 =?us-ascii?Q?i1l4c94cUMwv++1B5Ar+EIDE0RFEfulUYFi/zu1ZsuDYYic+n5LNDQegakPT?=
 =?us-ascii?Q?wJ81Xse24XJWVueznSnGN5gECQCsRSCXA67JAAN0uJ06XaC21uJPtkoGrrfz?=
 =?us-ascii?Q?df923CzQahEfTjc89g3JabvBGO6F4dAZiEMAHssoZmb+kPeKfeVulD11QQn+?=
 =?us-ascii?Q?Aqjy1AWc9yivFOiEBhoELH44JjCRS9uNvy0suc4O55xmuU9gs5WCTMUv+q2k?=
 =?us-ascii?Q?YEdKIUy3zVG5afUccSoWpiO/0wnhaLwVMD1pOaT6W6AGezcJDHDk56fCNXle?=
 =?us-ascii?Q?+8api0NlaiGIpvsGPoovcZStMkhj1Z2ROLoRDVWITP98vX+Knw6jensHgOYf?=
 =?us-ascii?Q?DBEaBEGAm6ohUVEWwZUw0CnxuEzh2RcDY1VcjaL5oj37dYDE22qu2OMqpFo3?=
 =?us-ascii?Q?6KKZTncEab2ntT0Sfpo+P/SFH/CrjYjKAfjQO2kTOCsYu2kE2L9ycSI844Hz?=
 =?us-ascii?Q?cJMTOVB3b8bXiS4qn95WRpjmmQ5lq8VGRBkhBWoXpujJ32slnLCmPk/6gX8b?=
 =?us-ascii?Q?8DtV6Qr0gL2CeRNzKFINFJhqg6xw83kzBTwuigMvG3oTi06375YnBSjgIgn+?=
 =?us-ascii?Q?6OiyN14SzXUamE2XRH5vBUdRTpewHUY7xzg8e90F5ti9M9zOjcq/YDdKu921?=
 =?us-ascii?Q?pfFd8c0FoYmoXqf43re+RkEFa88HTM+yN8+nNwFKX3VAvd6VnGcSS2mf1bkB?=
 =?us-ascii?Q?bWrY0vMlLIAdMa2L8hH2ew9ocK44N+hsiQ8YaWYuFHpwcWugyD0VDDpde95R?=
 =?us-ascii?Q?eYA/qZt5aSGu/e1WGBriWqeYTLgOFy/iC8vysXrSH9JBZycHPsnC05ODIQoN?=
 =?us-ascii?Q?3HpsEkzZ3laZJP2stzQ9y1z7tmqrnuVj4tMhp3fsMfGkCdYV+TJEWFPZCVWI?=
 =?us-ascii?Q?RsynQqxfRnid2BOhE/7Xu9c7I2Tal1kQV3bgXvaF06yJP7rLl5dZ9Xm0ru+1?=
 =?us-ascii?Q?VJEtsnhpvp3VAiQXWc7ejQ67wn2pVlqSraN8iy801L9HXTpTkrWkGtfUwM8W?=
 =?us-ascii?Q?k4lZ1v5681BDcPQXTP4otX0CbMiXniW+cNjkP74cgXTM+2U0kU6DQuG1bHdO?=
 =?us-ascii?Q?kZUkZ2bdQGsHLNp2jpRnOdCsnJOu7IUyn08tu3OeuKo/akU5o1t3DOGKMeWD?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aOJfAT907Fm0Ik+E5nx36j8rUzEwqeloyLZAReIpcQCXvpI+zDU64u3hasfTv8aHljXuD/GPSgpyoeQLYQFcNh7ZSw3Pqiq8ePXUvbT3ugvcILUPIQS4esAOf52tsHtjqoEYGubGnIVpxHVrHcNrbfW8AbNz50U4V2nltvsgF75ALtYOL9pOvRiaTTIyVZyK9/bvmCHRS+gFMTvVLQDh4xq+TlDepw5gIFWq2R+E3fgenui106Ns8nY6VdpD+fJGOmC+5k9JyTTuUFAi3dPwR2QCsCGwcLEB3LzaqrMPPPxZ79Jhj3cZWg3j9jyP1Mf3F0NzwUSOZLlVx7r826hyPbtz35IuQYFtPFrq+TfYPVM0VGnLDCzFMlT6svQR6nJcIPwCukp04WI+7x1Q1HeF56OYUShcO1d6zHJUxqEzWsfTv/E8R/i5XRNxMLePSw2rzWOL/+Y8WBW7W1KUN0Jpaw4/mDxojdQFI24r/SVsvca8ZgfujZFKZYuX4mRjQ2BYmqVzCNmzxj6TiENZHVHziTYlbaUhMLCCuKLq33eVbhAgB78mRfJGsMl9zZPtVWAhIjHXk/osYGFPUX+avGqN/2ZVDUKu70hRzZJ1eR1Wblk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6bc2331-174e-495c-2a2c-08de2c099069
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 10:01:12.4088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YV82yaWQkSWF5Vl0n5+DdB1AvRchd/CX6G7EPB21wgtEgearhViV9GlpjmEkwXu2nHKxbMg3+bLtYwCJR5L0cVjPHg1ClKZYzzFbar4XN4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7798
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511250081
X-Authority-Analysis: v=2.4 cv=L6AQguT8 c=1 sm=1 tr=0 ts=69257e6f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=IW01juKAgdGzpw-y0VQA:9 cc=ntf awl=host:13642
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA4MSBTYWx0ZWRfX4cqychHABRGk
 PubsVf2XNGqNtrDJOvMK9kIzlETeylsEIbyObpYb7VHhhIrcpM2cFKEmKHbUX7ccTwOHCLkrP/O
 wH7zpDi+57Cz09d5lbjokNxmb+CLvDOUdaqrCQiwaXm0tO0+UHffYb0SHGxwYiwWz3jsV5BwEg3
 NyGR5Bvx5SbPbt04dPGEArqHYAzqsxBY372mHZyd78sSX/vLikSSP42Ntmhvon+wsMWi80X2sND
 yJblOszRb4Jp2jlGIR5AKqSKPCB9/ZmZws1V7+4YixiHHnbJQLG8oLvsoNvPLPwhpTzwAlBV5np
 J6WyUiPPCem/IucavsPuP2hxqGpilfJsnz4QsXmhQOTx0RazxGh6IB2/bxCC+5QAvgaVZNUKzCB
 Vdw9pkKDz5pk65zOt0N76Hgai8QCsTJnoR/FvLlE5gWM9yLHpoE=
X-Proofpoint-ORIG-GUID: Dwh2buC7y7VieltIx7f9oleXwmNgdG4F
X-Proofpoint-GUID: Dwh2buC7y7VieltIx7f9oleXwmNgdG4F

The __mm_flags_set_word() function is slightly ambiguous - we use 'set' to
refer to setting individual bits (such as in mm_flags_set()) but here we
use it to refer to overwriting the value altogether.

Rename it to __mm_flags_overwrite_word() to eliminate this ambiguity.

We additionally simplify the functions, eliminating unnecessary
bitmap_xxx() operations (the compiler would have optimised these out but
it's worth being as clear as we can be here).

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm_types.h | 14 +++++---------
 kernel/fork.c            |  4 ++--
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 4f66a3206a63..3550672e0f9e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1314,15 +1314,13 @@ struct mm_struct {
 	unsigned long cpu_bitmap[];
 };
 
-/* Set the first system word of mm flags, non-atomically. */
-static inline void __mm_flags_set_word(struct mm_struct *mm, unsigned long value)
+/* Copy value to the first system word of mm flags, non-atomically. */
+static inline void __mm_flags_overwrite_word(struct mm_struct *mm, unsigned long value)
 {
-	unsigned long *bitmap = ACCESS_PRIVATE(&mm->flags, __mm_flags);
-
-	bitmap_copy(bitmap, &value, BITS_PER_LONG);
+	*ACCESS_PRIVATE(&mm->flags, __mm_flags) = value;
 }
 
-/* Obtain a read-only view of the bitmap. */
+/* Obtain a read-only view of the mm flags bitmap. */
 static inline const unsigned long *__mm_flags_get_bitmap(const struct mm_struct *mm)
 {
 	return (const unsigned long *)ACCESS_PRIVATE(&mm->flags, __mm_flags);
@@ -1331,9 +1329,7 @@ static inline const unsigned long *__mm_flags_get_bitmap(const struct mm_struct
 /* Read the first system word of mm flags, non-atomically. */
 static inline unsigned long __mm_flags_get_word(const struct mm_struct *mm)
 {
-	const unsigned long *bitmap = __mm_flags_get_bitmap(mm);
-
-	return bitmap_read(bitmap, 0, BITS_PER_LONG);
+	return *__mm_flags_get_bitmap(mm);
 }
 
 /*
diff --git a/kernel/fork.c b/kernel/fork.c
index dd0bb5fe4305..5e3309a2332c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1061,10 +1061,10 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	if (current->mm) {
 		unsigned long flags = __mm_flags_get_word(current->mm);
 
-		__mm_flags_set_word(mm, mmf_init_legacy_flags(flags));
+		__mm_flags_overwrite_word(mm, mmf_init_legacy_flags(flags));
 		mm->def_flags = current->mm->def_flags & VM_INIT_DEF_MASK;
 	} else {
-		__mm_flags_set_word(mm, default_dump_filter);
+		__mm_flags_overwrite_word(mm, default_dump_filter);
 		mm->def_flags = 0;
 	}
 
-- 
2.51.2


