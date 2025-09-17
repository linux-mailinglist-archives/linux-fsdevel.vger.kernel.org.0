Return-Path: <linux-fsdevel+bounces-61896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CC5B7CFBA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D955836C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 09:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20453346A0E;
	Wed, 17 Sep 2025 09:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="pdE3oOvi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013064.outbound.protection.outlook.com [52.101.127.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1A41F4701;
	Wed, 17 Sep 2025 09:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758102369; cv=fail; b=G2f+oSrw4kyfEQS6aPP0D/1KlbS1wnZvLlcaRON/Xvyx3o9DFVsH1n2FwYidSD8YVurF1AyEC1BqupOQdT29e+MWLYNrc619kyXxgiiuyGWfw6E7km0YSe1IXSwHdHSEWw+e+BrmsxgNx/IONC3VVbmDO5jVjX0wLFIVghv1ZeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758102369; c=relaxed/simple;
	bh=K36cyTW6PwLKw4pjwosXCjSC0KQc2ZktazSVPRup5do=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HFCjzghspRB8vY6QldP1nUZHVscR7UMemk76GhxITm8yGevnQ8qrt01kbgmnJ1WRc2gG8+w+/iDQPvgwJbNbBhdqKcNaZfw3W1KK65N89+Yg/RMG/hxBPTCq1L9HTfYJ2cJtDbySShNLCT7+HxDiCK1riEOvP0cHDYYo+5vaTy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=pdE3oOvi; arc=fail smtp.client-ip=52.101.127.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eexx3WFXLif+ep+RJ2K2a2Qj2VQytmbugXJkakbPxItXpsaMOJCZnA5u5gCH0EZFvQXloHrfWYjhPQnAwuuHB0J9sG6KQgtzt3rBg8GJ8G9+5vIgbE8cw5aw+8wAhYuN1fyIMByookP3cdTrJz+xoJceS2uf3uw23NqbdJ4i4x7i8vQgIzSHq3w5aI8PyZRzFG1GLIkioNzrNNNVbLEMQd4HJe+8rMjhrDGVk7sBzi32wT5CCHn+kNm3cnrvgzn5nr8kAr5+7bvip0F/rffB4eTqr2EMEE6+64ZmIzBYntCZ9E1Uz8HlxF5ZedFwyb7EL01vBh7XU5UvsQiq8UEyMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jn4QX8ke10iA+NARvkVYIvqMWcIAl5zOZH0y0u7E35k=;
 b=ZiDF0gf6UhIUIxKYxMpdQjVHTpZgdPAFfDiRWI8a4c2FoYEG8fPvy4oYvdod4LEcCM01yJRsLk8nbQn0BchbjlhjTI+WcLFbfLmB78huuYQ+YUUrshZVmHjeJUY2BDzEUpt63F3Fc+hL1eEeSw2YuCyHKArTPAWX4CYX4/EzxXxycloR/LsZ7Fww5jpIr5WTGQ/L4HbwszQ7vL+qtQ4RTly/uySh0uOAIDp6rjMjWpuAzLaXg4Aob5i+CGaWidzbckuCtPd933iqi6HfOKKWEn+/bDqYCPzUKM70JOunzzHIWyasJxRtmu6mNNLrqV/mYEPBhrX5nfs33YZ+gNar7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jn4QX8ke10iA+NARvkVYIvqMWcIAl5zOZH0y0u7E35k=;
 b=pdE3oOviA0Bf6aN5UcvSulfW1hooEdJ0PhmkPnaClFsd4E+af51bbJvE56MAuXWjEdz5NMI42+x2pnwkpijyR7+O0fpkfARkfn7G4uBBenanpm9SnGJnR4a/fHd8G1Pj7+4NMS8qT2s1WjwVasGtB88Fql8bk1TQFpSzywjK7Ap0IML9AgIipcQij3hBI3UazIpcnfqu5s9CWzCSwza+2aWswMWdtjtVLESRNBCvQN6+VDjgCLkLj1zrjs2QwIUXLtQfTRWMkchyY8l6BTRvuDyVGnurDLvmjPrm5CJixRo38riyH2qAOa5XCEKnyhwVL2caVl4U+uEGdrIrUjOGvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by PS1PPF97BB1365E.apcprd06.prod.outlook.com (2603:1096:308::25e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Wed, 17 Sep
 2025 09:45:59 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 09:45:59 +0000
Message-ID: <d31a3880-dc7c-4224-b248-085941431abc@vivo.com>
Date: Wed, 17 Sep 2025 17:45:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v0] mm/vmscan: Add readahead LRU to improve readahead
 file page reclamation efficiency
To: Yuanchu Xie <yuanchu@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Wei Xu <weixugc@google.com>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Qi Zheng <zhengqi.arch@bytedance.com>, Shakeel Butt
 <shakeel.butt@linux.dev>, Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Yosry Ahmed <yosry.ahmed@linux.dev>, Nico Pache <npache@redhat.com>,
 Harry Yoo <harry.yoo@oracle.com>, Yu Zhao <yuzhao@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Usama Arif <usamaarif642@gmail.com>, Chen Yu <yu.c.chen@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Nhat Pham <nphamcs@gmail.com>, Hao Jia <jiahao1@lixiang.com>,
 "Kirill A. Shutemov" <kas@kernel.org>, Barry Song <baohua@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Petr Mladek <pmladek@suse.com>, Jaewon Kim <jaewon31.kim@samsung.com>,
 "open list:PROC FILESYSTEM" <linux-kernel@vger.kernel.org>,
 "open list:PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
 "open list:MEMORY MANAGEMENT - MGLRU (MULTI-GEN LRU)" <linux-mm@kvack.org>,
 "open list:TRACING" <linux-trace-kernel@vger.kernel.org>
References: <20250916072226.220426-1-liulei.rjpt@vivo.com>
 <CAJj2-QHy3rTSPpE5uyu4gW9dWe1E5Q28P_N-VX2Uo+xBFauxdw@mail.gmail.com>
From: Lei Liu <liulei.rjpt@vivo.com>
In-Reply-To: <CAJj2-QHy3rTSPpE5uyu4gW9dWe1E5Q28P_N-VX2Uo+xBFauxdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|PS1PPF97BB1365E:EE_
X-MS-Office365-Filtering-Correlation-Id: cb0e5ca9-e6f7-4572-735c-08ddf5cf0192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|42112799006|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bk9tclZFWTZSR3NORTVDSVc4QmxBNk9qb3c3MjZJTWxTb1dPM0lBUTh6cUxJ?=
 =?utf-8?B?bEwxbEJYcm80WURVaWRJLzRjK05TeGhVZ0xTZGJ1c0Q1b2VqbFdObDJxMmpX?=
 =?utf-8?B?QVBmSHpVWCtRdmNLYnovSmxKc1dHdXlQOUdqeVdwSGsyc052U2FEUGNhOVYz?=
 =?utf-8?B?QnBSdUZqSmozQlk5VzlrYityWVZFVEE2MjBBa215Z1RaUHFRcis4NmRUVDls?=
 =?utf-8?B?TXhzUEwybGkydEZpRWcyYVBPQjFVaFVPNUNrdm9CKzN1b0FHYnFiWTlLS0ZW?=
 =?utf-8?B?cDREMC9wWlhjQnE0WWxFOTNLRUhDamVjdk9jVHVXeFZZV3N4Y2JlOS85S1lS?=
 =?utf-8?B?MzRWdXp1SDkxMTVjU01OT1dBaktVeVVZZGxBVnVGUlVUa281eHdDb0JXYUtZ?=
 =?utf-8?B?Q2k0K3d4a1paMXpBUUpWZ3ZJOVo0dStnaEhUK3dPZFBCQ3pzUm1YM0tNcVRr?=
 =?utf-8?B?ZUtaOVluNVFScXZTbXFNV0dmZm9oN0t0WU9tOVc1L21wMVhHSWJxVzh3NWY4?=
 =?utf-8?B?SWtzS1pYK1FoWGVzUVRkVWtpRndON1VXMzY4RksxYWVFTmZlWE1pYUVuc0lQ?=
 =?utf-8?B?T2x1Q2J5amJYcm9NRDFKdmNGK3k4d2pxTHBqSUxZbUgwZHFKcUJOT2NiWll2?=
 =?utf-8?B?YmFpWEx2RmxjMkJtT3Yrekp2bG5ybFhXMGNraUxhM041STBQZE9ZTTQ1VTBJ?=
 =?utf-8?B?MzFsZmh3aGVhT3llZmM0blNkTlUvTlhKVnhSb2RFSkFCWjVCdFhXdkN5akRj?=
 =?utf-8?B?SFFSaG1kYlRPRURFUFowbnE1K3kybHlvZHBZcDF4K0RyYUdJL1U1WmJsSlhC?=
 =?utf-8?B?NTNCMDVzOGVzeWs2VG5pdU90TllLd1hjT2RqcTFoY1VSbkdBd3h0RWU0eUY1?=
 =?utf-8?B?OFVIRjcxMENaY1FLbEpsaDhYMCtaUHNnMnE4OFRoRFlHNERFRmVndWd6Q0tC?=
 =?utf-8?B?QUNNQjBWdXdjRVRGNlZFMnRIclZGcDkyZjRQMS85Zkk5bXI0Q2pjTWM0eE04?=
 =?utf-8?B?SnF4amZBejZzMGdPaTNPRENzdTc1azU4SVVIVTRGTHo4MjlJTjZ0Nk9SWDZl?=
 =?utf-8?B?MXVtVER2QnFhemZRdEJTemhHcEpCVDNxU3plaXVNSEVwNHM1VUxhd0hLUGVa?=
 =?utf-8?B?dWlSL1Ria1FIcjZ1QjRQbEZKc3Z3ZS9wczhLOXd0V3hlc3dtcGV5ekJHaWFh?=
 =?utf-8?B?cUdOdDdPaTFhS3hjVkZxa1FWb2NEdVZIemVkU2tyMDRWVEpueUEzL1Arb04x?=
 =?utf-8?B?UWd0MWErUHRBaEFQN1ovQkpqUXJLMTRPYXFLaDRSVlZLNzVjWWZDTkIwdFhm?=
 =?utf-8?B?TUpKUmtCTkNsM0xuc1ZldTlYUEVYMzU0OGczTzRxODZQalBlTzBabVFONjJy?=
 =?utf-8?B?bjkrWDQ0UGplZWkxbjdockRxMTc3eHB2MUErbnBKVFFsUm9WR2NrNlFaUlY1?=
 =?utf-8?B?MDY0N2FsNDZhbnhMQ2MzaGJ2WDhYUm02T0tzaExpd25Fby9jRVQ0dDJrU3BQ?=
 =?utf-8?B?bCt5dDdUQWYyNXp5QktoY3RXbGZ0eis1UUlBQkVaU05NSFRZK25JdG41YVhS?=
 =?utf-8?B?RDRpOC9WdHhYZ2xlUXAzbWxHK3EwWUpWY0JUek9mRG5ZZDNid3d0aWJQS29Y?=
 =?utf-8?B?RVZRSUZuTlkzK09NV0hMWFpxRWRlTWdJQlFtY1JNUFl4MTVkK2YrWVhjUUph?=
 =?utf-8?B?Unl5aWdwUVdLUThndHdMNHMvem04R3g4cXNncWkxRVJNbk1XQ0FKK3RMS0Jr?=
 =?utf-8?B?NC95ZTdjdVVuME51NFlkeWNVYkxTN1VWT29hZDNrUUFKMGFERktqL213R1Yx?=
 =?utf-8?Q?Lt5CAcS17bmYMZXP4KTGQmeVVyqYTwDPdOdJg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(42112799006)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXM4U0NIVlN5Ry80NHNDUnZQQm9DdXEvVFIveXFRV2EzYkU0dmlhZnhKUGd2?=
 =?utf-8?B?WFdYcTNiS0hhUWFJNm1FbUV5NW5GTHR6bGFqR1lVOG9tZ1pUWVBQUll6S20y?=
 =?utf-8?B?WXd1aURRWXJhcUQ4UCsyQnN3ekc0Z2JGSUdBV0xsZ2duT2RjVzE3cnBHOS9R?=
 =?utf-8?B?NjQrdTFnUDVuNEVKVEJhZFdhUHNFalliYkJ2dUZNYXV1ZEt6a1FBZDZqUHhK?=
 =?utf-8?B?SThOL2VqWHI0UGM4KzBWSmhvR0YvVkZvdnJXUFdyUTB5WHNzaDh6VlZMcTYw?=
 =?utf-8?B?NFlDZmhid2pOSWsvS1hEZXBHb2o0NThDRS9KbmhzWE1uRy9wRFdUK1FrMVVr?=
 =?utf-8?B?RHk3UmVYQXlnSHRBaUd6YWFuY09lK2Rqc0F2RTgzbTRYVXRTLzY0a3QvQm82?=
 =?utf-8?B?K2hLd0lxc3M5WW56ZTFRTVlKOU52Sk5XMzZGQTFwdTZlVjRWaEdrQzc4NTRQ?=
 =?utf-8?B?N1RDRDBLY1dHS3NlMktYMitIZno4L09SdEhKOFArVExGaXRjSytvQmNnL04x?=
 =?utf-8?B?VnQvT0F6MW44V3hMUnNTRVRVZlZld2J5WVZmZTZTQ3Q5c0tBempiUTJwZits?=
 =?utf-8?B?M1JDbVcxT1dXclRwRTJqN2tBTXJCck9lZmZvbUwzMjNXMHRld3ZBNUMrZ1Z5?=
 =?utf-8?B?MUZGU3dzVVBNS3pOcGZQRXJEdWZIeS8zc01wQlAxUmsrVTgzRW1kTFl0R1pS?=
 =?utf-8?B?Sk50TTJvRDFibWtaZ2ZSNjd0TnZyenJHek5kc3dUdHJlMHJjbERTWlFrQ3lM?=
 =?utf-8?B?UjBhelBmbjVXQ1VCUFc2eWNiUWVla2pJbmJFRHFPWEoyTkZFZEY2YkUxYlVw?=
 =?utf-8?B?cFN2cUcyMWlORGhnQnlDOEZzcHFraWdFRWtKZVg5T2p2V0hjTGsrRm1jTzZG?=
 =?utf-8?B?c0NzeDUzL2kwdENvWDdmbS9zUEduNU85WWsxM0hrV0t0eUQ5WFNBQ0k5RldW?=
 =?utf-8?B?ZFlzR2xwM2VNcm1GTjdFY3dUZ1Z6eXR3a01DZTFsU1FaRWJSa0RyNkJHTkd4?=
 =?utf-8?B?MnZOaERzcXk2NGs4UkJEODdWcG9QNWs0eEZTc0dPOHM1c1hPWmhONXZtREZt?=
 =?utf-8?B?Y1g2T0t0dmZmTFNTNlgxb1N0YlR1WjNIRlhOR29uaHdrV3lpOGI4dU0rZjNZ?=
 =?utf-8?B?bmZBVWtYUjZUcnA5OVZDUFJoYUtKRUQwUUg1Vmc1RFp2WVFkdk9pQSsyRy82?=
 =?utf-8?B?VENzL0RlZHZTSmV4T1pDYTBsWnNEdURiQlRQdWJQZG5Fc2h1WEg4NGhNK1Fh?=
 =?utf-8?B?alozYmdvNEdGUXhQenNIWGVWVHJUN1JwZ2E0eGRmUXcvYWNjLzh1MnpBOXln?=
 =?utf-8?B?eXI0V0F6QU1KWnh3U1BxVEJiODVjamhNbGlObkdDUExEMkNwVWtaMWtvL1JS?=
 =?utf-8?B?RjJEN1d6ZzhybC9OdHBSOFQ2eTRIT0kzTGhYeTF4bW92b1h4MEZzRmlvRDhQ?=
 =?utf-8?B?NDVvNnlkbUdyaUxWVzRqaENEalRrekRkQWpDNzBoUjEwVGlDanQ1c1JtNDNn?=
 =?utf-8?B?cXFvbEZMbW9kdXM1M0l0RVV1Z2w1ckl2cEFxcmFkTHhleG1Tb0RVb2RaaGh4?=
 =?utf-8?B?WXVLZllGYzlPMGRyenpDWUVaVk1MQ0FaVVdybUU1QThnUExaVnBVOWQvTlFJ?=
 =?utf-8?B?QllUQmEyYkpnRS9SK2cvU1NHRDVycmdlMy92Nk1reGIyTGtvc1FhU1dKcDJP?=
 =?utf-8?B?cVdIY1pWaTJvNWpNNHRYUlFNSnNhMm5PcktNc1d5UDN5WHV5U3lPTlFhMHAv?=
 =?utf-8?B?N05LR2dGRlpabUtFYzhFVUM1bUs4UitlZEtSYXV5TWRTOVV3QlFqM0RHc2t2?=
 =?utf-8?B?QzJnUFdxaCtuZk1uZmJhSGloWGMvTHZKKzZTbGxoT25BYldKeE8ybmRHNmg1?=
 =?utf-8?B?VEN5VFQwNWRFaUNCTkplcTZ4ZVhWUmlPUGtQZTQ4R3FsN0RIT0NlS3FMeHl0?=
 =?utf-8?B?c2ZTMDdpckw4ODdYR0x3Z2JoSlNHYTlSUFE0WGxqUTA4eHJ4bndWWGNhNzZC?=
 =?utf-8?B?b0Z4bzNUQlREdEdPSllycjZSaTc0MEJCdTdrR05QbXUwZFRrbEduS210eGsy?=
 =?utf-8?B?T2svVjFoS255VXJyMm95YXlBNFhEb3E3OENqaVMwSXFIMDNzakpGcnkvcGRn?=
 =?utf-8?Q?/sicCINg1z+8twRExpxB1aKZb?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0e5ca9-e6f7-4572-735c-08ddf5cf0192
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 09:45:59.3011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuvpdBUDMG3OTTWlgjfEppFntXnJ3nQj+5yoJvec1t/Wjp01WYAHCEmyopnS7RbBAtkjYBxO3z1tiz5CSG4tDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF97BB1365E


On 2025/9/17 0:33, Yuanchu Xie wrote:
> On Tue, Sep 16, 2025 at 2:22 AM Lei Liu <liulei.rjpt@vivo.com> wrote:
>> ...
>>
>> 2. Solution Proposal
>> Introduce a Readahead LRU to track pages brought in via readahead. During
>> memory reclamation, prioritize scanning this LRU to reclaim pages that
>> have not been accessed recently. For pages in the Readahead LRU that are
>> accessed, move them back to the inactive_file LRU to await subsequent
>> reclamation.
> I'm unsure this is the right solution though, given all users would
> have this readahead LRU on and we don't have performance numbers
> besides application startup here.
> My impression is that readahead behavior is highly dependent on the
> hardware, the workload, and the desired behavior, so making the
> readahead{-adjacent} behavior more amenable to tuning seems like the
> right direction.
>
> Maybe relevant discussions: https://lwn.net/Articles/897786/
>
> I only skimmed the code but noticed a few things:
>
>> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
>> index a458f1e112fd..4f3f031134fd 100644
>> --- a/fs/proc/meminfo.c
>> +++ b/fs/proc/meminfo.c
>> @@ -71,6 +71,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>>          show_val_kb(m, "Inactive(anon): ", pages[LRU_INACTIVE_ANON]);
>>          show_val_kb(m, "Active(file):   ", pages[LRU_ACTIVE_FILE]);
>>          show_val_kb(m, "Inactive(file): ", pages[LRU_INACTIVE_FILE]);
>> +       show_val_kb(m, "ReadAhead(file):",
> I notice both readahead and read ahead in this patch. Stick to the
> conventional one (readahead).
>
>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> index 8d3fa3a91ce4..57dac828aa4f 100644
>> --- a/include/linux/page-flags.h
>> +++ b/include/linux/page-flags.h
>> @@ -127,6 +127,7 @@ enum pageflags {
>>   #ifdef CONFIG_ARCH_USES_PG_ARCH_3
>>          PG_arch_3,
>>   #endif
>> +       PG_readahead_lru,
> More pageflags...
>
> b/include/trace/events/mmflags.h
>> index aa441f593e9a..2dbc1701e838 100644
>> --- a/include/trace/events/mmflags.h
>> +++ b/include/trace/events/mmflags.h
>> @@ -159,7 +159,8 @@ TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
>>          DEF_PAGEFLAG_NAME(reclaim),                                     \
>>          DEF_PAGEFLAG_NAME(swapbacked),                                  \
>>          DEF_PAGEFLAG_NAME(unevictable),                                 \
>> -       DEF_PAGEFLAG_NAME(dropbehind)                                   \
>> +       DEF_PAGEFLAG_NAME(dropbehind),                                  \
>> +       DEF_PAGEFLAG_NAME(readahead_lru)                                \
>>   IF_HAVE_PG_MLOCK(mlocked)                                              \
>>   IF_HAVE_PG_HWPOISON(hwpoison)                                          \
>>   IF_HAVE_PG_IDLE(idle)                                                  \
>> @@ -309,6 +310,7 @@ IF_HAVE_VM_DROPPABLE(VM_DROPPABLE,  "droppable"     )               \
>>                  EM (LRU_ACTIVE_ANON, "active_anon") \
>>                  EM (LRU_INACTIVE_FILE, "inactive_file") \
>>                  EM (LRU_ACTIVE_FILE, "active_file") \
>> +               EM(LRU_READ_AHEAD_FILE, "readahead_file") \
> Likewise, inconsistent naming.
>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 9e5ef39ce73a..0feab4d89d47 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -760,6 +760,8 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
>>                  folio_set_workingset(newfolio);
>>          if (folio_test_checked(folio))
>>                  folio_set_checked(newfolio);
>> +       if (folio_test_readahead_lru(folio))
>> +               folio_set_readahead_lru(folio);
> newfolio
Understood—I'll revise accordingly.
>
>>   /*
>> @@ -5800,6 +5837,87 @@ static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *
>>
>>   #endif /* CONFIG_LRU_GEN */
>>
>> +static unsigned long shrink_read_ahead_list(unsigned long nr_to_scan,
>> +                                           unsigned long nr_to_reclaim,
>> +                                           struct lruvec *lruvec,
>> +                                           struct scan_control *sc)
>> +{
>> +       LIST_HEAD(l_hold);
>> +       LIST_HEAD(l_reclaim);
>> +       LIST_HEAD(l_inactive);
>> +       unsigned long nr_scanned = 0;
>> +       unsigned long nr_taken = 0;
>> +       unsigned long nr_reclaimed = 0;
>> +       unsigned long vm_flags;
>> +       enum vm_event_item item;
>> +       struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>> +       struct reclaim_stat stat = { 0 };
>> +
>> +       lru_add_drain();
>> +
>> +       spin_lock_irq(&lruvec->lru_lock);
>> +       nr_taken = isolate_lru_folios(nr_to_scan, lruvec, &l_hold, &nr_scanned,
>> +                                     sc, LRU_READ_AHEAD_FILE);
>> +
>> +       __count_vm_events(PGSCAN_READAHEAD_FILE, nr_scanned);
>> +       __mod_node_page_state(pgdat, NR_ISOLATED_FILE, nr_taken);
>> +       item = PGSCAN_KSWAPD + reclaimer_offset(sc);
>> +       if (!cgroup_reclaim(sc))
>> +               __count_vm_events(item, nr_scanned);
>> +       count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
>> +       __count_vm_events(PGSCAN_FILE, nr_scanned);
>> +       spin_unlock_irq(&lruvec->lru_lock);
>> +
>> +       if (nr_taken == 0)
>> +               return 0;
>> +
>> +       while (!list_empty(&l_hold)) {
>> +               struct folio *folio;
>> +
>> +               cond_resched();
>> +               folio = lru_to_folio(&l_hold);
>> +               list_del(&folio->lru);
>> +               folio_clear_readahead_lru(folio);
>> +
>> +               if (folio_referenced(folio, 0, sc->target_mem_cgroup, &vm_flags)) {
>> +                       list_add(&folio->lru, &l_inactive);
>> +                       continue;
>> +               }
>> +               folio_clear_active(folio);
>> +               list_add(&folio->lru, &l_reclaim);
>> +       }
>> +
>> +       nr_reclaimed = shrink_folio_list(&l_reclaim, pgdat, sc, &stat, true,
>> +                                        lruvec_memcg(lruvec));
>> +
>> +       list_splice(&l_reclaim, &l_inactive);
>> +
>> +       spin_lock_irq(&lruvec->lru_lock);
>> +       move_folios_to_lru(lruvec, &l_inactive);
>> +       __mod_node_page_state(pgdat, NR_ISOLATED_FILE, -nr_taken);
>> +
>> +       __count_vm_events(PGSTEAL_READAHEAD_FILE, nr_reclaimed);
>> +       item = PGSTEAL_KSWAPD + reclaimer_offset(sc);
>> +       if (!cgroup_reclaim(sc))
>> +               __count_vm_events(item, nr_reclaimed);
>> +       count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
>> +       __count_vm_events(PGSTEAL_FILE, nr_reclaimed);
>> +       spin_unlock_irq(&lruvec->lru_lock);
> I see the idea is that readahead pages should be scanned before the
> rest of inactive file. I wonder if this is achievable without adding
> another LRU.
>
>
> Thanks,
> Yuanchu

Hi， Yuanchu

Thank you for your valuable feedback!

1.We initially considered keeping readahead pages in the system's 
existing inactive/active LRUs without adding a dedicated LRU. However, 
this approach may lead to inefficient reclamation of readahead pages.

Reason: When scanning the inactive LRU, processing readahead pages can 
be frequently interrupted by non-readahead pages (e.g., shared/accessed 
pages). The reference checks for these non-readahead pages incur 
significant overhead, slowing down the scanning and reclamation of 
readahead pages.
Thus, isolating readahead pages in a readahead LRU allows more targeted 
reclamation, significantly accelerating scanning and recycling efficiency.

2.That said, this solution does raise valid concerns. As you rightly 
pointed out, enabling this LRU globally may not align with all users' 
needs since not every scenario requires it.

3.For now, this remains a preliminary solution. The primary goal of this 
RFC is to highlight the issue of excessive readahead overhead and gather 
community insights for better alternatives.

We are actively exploring solutions without adding a new LRU for future 
iterations.

Best regards,
Lei Liu


