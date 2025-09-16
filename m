Return-Path: <linux-fsdevel+bounces-61700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D37B58F10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 09:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B589E480351
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 07:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C9C281508;
	Tue, 16 Sep 2025 07:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="WGlr9aMP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013014.outbound.protection.outlook.com [40.107.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450592BAF9;
	Tue, 16 Sep 2025 07:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758007372; cv=fail; b=cti0nCs5mIWHr6YUwhDzIMV0OJcfCjFD8Mdf1NUDG/p5BlP9CxBkY5kWxtKKChZ/zCDLPg1cv7nc1V6NWL6C3nxUlm0RwmCqpMX289uesrZdzmNQBQhOZlTCgB6DJc0BzcsOrP/eM8qNRMtWnORN1biTLwL3wyDxna5Tk8Vx12E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758007372; c=relaxed/simple;
	bh=NsYWwsXmS7hkih4S6yZc9gl4UG/zCakRTBBOHhzj1sM=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qmLX/Lv9nzbnx3pg9oADlbSI5s2UEulC5WBmkIL/ScQhI7hufLTzx02oi4hBfXvLmzcf85ZeT2k56XnoyaVC0iyUYKI33rqtg+ypMHThCEyPMX3ibPhjcy+9AwOhnuJhEC420Y6qiKHpowmxjGq/LuaQqf4awu0fXq7Y24xGH9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=WGlr9aMP; arc=fail smtp.client-ip=40.107.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VeoDkfiKriL5efurwrX2h23m8hiv+OX5ub8mwM7QVgSMNeZui72thEhPvUxkSXtElRcqldUF6LJ3+agM/jrwn14+/dsviUrS4KP/qot5quGYE1PUqFa2a/KRtjAuEqy1Dbxcmgti761sH6Rfd9GylbMKbH1sCr6U7U/C+odkqoyEEZXZVXjCqr8uyU5sPjNFrah5tigvf2mQ6afbYP8u5i7Jd2+/tqGDbrVcmiu9IlTo0HUQxuMmm1xStbXTKW0Z9WegAN6E50O3p0RSpyl8/vOzciL9kO97KcMwC2GRkmPWNbSA9GE4AAjgh7BMUsz0FHUy6CoR5YDnKwU7W+NKOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3QbpBC1GKKJW+7Vc4UGIg18Psix4wrRZr1mW8/btKo=;
 b=Y8JqnzClb8aMCyFTvSnp1MITvfXkCMVMGW7ptU7P9u8JK1hz3uBAaidobWozYNMFkSMy72muKSyMXXK5EUSE3ZspjHkgrHmW7QMzUr6rSDLiAl+3KzLys1MN7UgsuF4rUpghO+PaS0Cdag7/XETGjgSSti0AliNhNpBlKDPNIMsEma4r+EORix4X2IYPilJRtV9Ob6mVzJZr86ZO9X1nTbN+4Z/7KG9cxgmJcDRJp6quqizRZkd2UeC/30asUeqRQcZDIiNlGc01K4/EYllNXArjX5usva8YQI1+h/CwR5LPFWnCf3Ay1Bdn9cKgYfE2v/enjLM65JsE6jr+/W1ZYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3QbpBC1GKKJW+7Vc4UGIg18Psix4wrRZr1mW8/btKo=;
 b=WGlr9aMP5t5yW68shHkkVeYokLeVnB4pTS0OKozkJTwSNqgggCamf4GoEaLvyMYcP40jvsTcAwwaqaiOhxjLpsqjJuRFG7GE4tsKtzrh11vvnVABhcaC/ujs7+W1cgQcIBlTHC8XZPJ7FVktyapOdFJAGQDVSpjizW8i0ZMkqEFG8XBhNwdQ4Ivgv/LiL8k0L2Du82hZL5jjDW0l7PYr3upDi3An08M6uaKyPhkCIXryWeDnu7SuNGe6pkvLyM5j4EZYWAKvZf9e1QpYJxfBWe9PSgZpUBB+r6AsGaiHswxbP5mLI9WE36ir9bAYrBNAveFRqwhsQwKJlgNHdTYPOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by TYQPR06MB8118.apcprd06.prod.outlook.com (2603:1096:405:2f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 07:22:45 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 07:22:44 +0000
From: Lei Liu <liulei.rjpt@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lei Liu <liulei.rjpt@vivo.com>,
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nico Pache <npache@redhat.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Yu Zhao <yuzhao@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Usama Arif <usamaarif642@gmail.com>,
	Chen Yu <yu.c.chen@intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Hao Jia <jiahao1@lixiang.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Petr Mladek <pmladek@suse.com>,
	Jaewon Kim <jaewon31.kim@samsung.com>,
	linux-kernel@vger.kernel.org (open list:PROC FILESYSTEM),
	linux-fsdevel@vger.kernel.org (open list:PROC FILESYSTEM),
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT - MGLRU (MULTI-GEN LRU)),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: [RFC PATCH v0] mm/vmscan: Add readahead LRU to improve readahead file page reclamation efficiency
Date: Tue, 16 Sep 2025 15:22:16 +0800
Message-Id: <20250916072226.220426-1-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0028.jpnprd01.prod.outlook.com
 (2603:1096:405:1::16) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|TYQPR06MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d81fa4-2509-4044-78ff-08ddf4f1d456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|42112799006|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ql3LuGNwYyNR3egJ5Ki6Ap5wvTSTEbiXP7w7tjoEZBHGY7wcxP0zj3FGkfmi?=
 =?us-ascii?Q?E094vjztemwBIxg+uRQy99vD8XjljBUNGKEmR/buq88cKZwfui0WnCYz4YIw?=
 =?us-ascii?Q?4a/eJfm8N7/878ZdiGSpr17gzu1APSM3fytZbpChlPYoKcR8Mv0UcFYJqnlu?=
 =?us-ascii?Q?s/EIzbLj5HjnFOF3gMJ+JAsJRPsLxRzIC+WL7bkmjLzLjHBZ6iWO1Z7I08B0?=
 =?us-ascii?Q?Ow7xw4l9BIf1tKTm1+G4Hizb2jfbhtwaTRpc+uYHAmD8t5n5Z4wprAKBb3DH?=
 =?us-ascii?Q?BH4Wax+2MyjMESnmRGXEVRRrqRl8qsfcZByO1KECw7n38Z00cbBOLBbxzTrd?=
 =?us-ascii?Q?gFhkDbNaqcPsYXFJfj8fr/6OtTRf3RK4H0EYINI8ny92K9FE2br/fp8VlRg0?=
 =?us-ascii?Q?1Bwi/PDY4TZPSIdGqpP0oKh7v1bz25MByvin0bnzaG7yNZaVgcSFaGr6d8dM?=
 =?us-ascii?Q?DPreoW6nqsE8FDoG6SSgnIKH9Gb8vjBxvkiZGMV/8zqDtESsm9v13YOUeQyQ?=
 =?us-ascii?Q?VOIIPPpSEzrNDczsh0IBf5cFzJajwFyCbo14o7IYRYvA9Ea/epJS9XUZDF+p?=
 =?us-ascii?Q?rYzpkdscEwE8ySiX/Tccge/x6fjKqSnyNnCM8MtG2Dzn5/WHnA6yDVCY0iiO?=
 =?us-ascii?Q?9U70MnB/aJ4qSlVvkqYZs0nD8Qv1v4lg4JU0lfnqlvcBGmfDabdrjJQiBsCA?=
 =?us-ascii?Q?NqsgxNhkdmGONCu/knXO3LXj5OKVLHDLnQoe46DTzyrK5Mk8fBkVYOQijZjq?=
 =?us-ascii?Q?X0XDxudv2o0RbZaIcG3cQyj2tjnljG2Ptds4UBP69tWVV8qQEyNi14WYnK6e?=
 =?us-ascii?Q?v0P4p9YntOUF1amiCCuQsOdG4NtVZCjXkJ5CDLcL1uHYmj6ADcmTm8gAx3yA?=
 =?us-ascii?Q?d1Ui9In4gPHI2qsys64lRep+ZioGyZRhLlq9qksx9WswuIV5b5Nyzh7CyzdQ?=
 =?us-ascii?Q?LbWv3yZnLSeL6NSE6LnKMrumiHIi12PH5+eaBTdhllSI7F75qmRrXqcof7Fw?=
 =?us-ascii?Q?x528ERATCsw3CG+ZXOfP0yQHlE+lQo2deRrNfmC2lteo65+Ojy2q/XQgUhve?=
 =?us-ascii?Q?NPPX+IRg6OVBneVHNMYM/sHVl5dayvqBplyRm7Vl+lWN9r+j+jUGd8dE8gQs?=
 =?us-ascii?Q?AmAJ4BN4c2hmwYITwxTj0tNA2Uey+V8WFuCkWeCMoX7tdjMJdn2ooebTXJns?=
 =?us-ascii?Q?g8YgWPmJrTX0A4J4b/nRKTwsXvVj5wd6iU+dnWDWSSphb4VU64BOkLeC2oe0?=
 =?us-ascii?Q?jBHjgBdFyYFI3Hb0NAgHKGJgby744MyIky8a0vr5H+u73eCQA3Oh7dC6hmM6?=
 =?us-ascii?Q?SjhVZTN4sODV7hLrqBOUlstRtFXixuKga+K0LKCBMBGjv7XCG9zIJZvJfmMv?=
 =?us-ascii?Q?4phB3wWvml/vF8BDFiFL8IVc3Osu/ZSjDiXgJY7EmRP2lwK+s7h9nKRMgra7?=
 =?us-ascii?Q?VUJPyFhZsfUooXWhB27Q2sI4NQPmLxVkaVaUKLrkTS2Ig0mWPdwVOZ212oB+?=
 =?us-ascii?Q?wqLfGjV0ltWF370=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(42112799006)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BsON+6hqAzAfYp1K2ZbbqWbYGqAI7fV7+sky4BZiFDoOt8/Fw+WINjsSuhZ0?=
 =?us-ascii?Q?vMshRTkZMoqKAueLTBoPLKgioMJUtHJNvlx00BXbjZZ3+Wd1h+oCqv0luZSh?=
 =?us-ascii?Q?/HrNHU1Ujx4HpoXj834g9AWaN0PWeRcgrrfzk8TSQkXRVYPwuyAErsPosQWf?=
 =?us-ascii?Q?3+o9IQJfOVxYgkugDjdKLtqhsw9bKLeToJ8SloqkQ4M8D7LoqfD7XoXAqVB/?=
 =?us-ascii?Q?dXK0sUCNxJZ7kvZNvlgRv8jX27T7SAUr1jyySw+2s1vRUlbSYO54wDLgfiNx?=
 =?us-ascii?Q?q/SvRa8Ccnc2TeVguQoknV3uh9BsAOfQNzb5QlY0yZReUCr+Wl6VP0YSnSBy?=
 =?us-ascii?Q?CKNxyaxK+ZSo2UYwWMpx+xIX4vrEDYnW2ttG4z/MDIkCadAeFyWI7Hs4VERc?=
 =?us-ascii?Q?yGp/l/4OeaSN/ThikMnu1kfqqlNwnOszFH2ZN4j9eoNK8HAD5aZrrrbWzAlv?=
 =?us-ascii?Q?x2A4Uh6QTtnkVoMKxjmuYlVKAaWxDGrjuDwFqVMRSgmOhae/z1tjkCW2mMc7?=
 =?us-ascii?Q?OBMv1Ekhtfl1dhC/v/N6lcDsADT+r8dASirNWPtnwXjXK5syZL08Qq3gqX4r?=
 =?us-ascii?Q?c6iP69kGO8LhsgDLqfb2zOUa9Zfq5cKEDQrqKJ/jpSJYDFxu6CyprrBrtEX8?=
 =?us-ascii?Q?xoehC/YXPnKKN8SSP88qkViThY4z7bEbtXr8acN55/2eWbnt0+EQ5rVhB2LR?=
 =?us-ascii?Q?YKr2855PLB9D4S6CelAfjnaJhkAmZmHVpawplPsigKIAvgj0QKzV/MUNL6sQ?=
 =?us-ascii?Q?phGEqC97SOkytO8awubwqdx6OYTcBkdjdlQCvhSuMlQ+XMuft1tr7HXDYnbe?=
 =?us-ascii?Q?61W7Qo6y3lRyBrKxnxyZ6M+B4D+RofrNsEBucplk4f0jU8FVIspIuTJkscWP?=
 =?us-ascii?Q?h4o1vDq+tOjrWxTzkLpN9WluFKyhf4twRT15fkeozp8hJ+/R1yDno0NSS73w?=
 =?us-ascii?Q?w9Jb9anbXTA3mhcAI3RERUrnSxsKtadv6+BpZS2ZRwQQAJk65TZ8bYxfEA/7?=
 =?us-ascii?Q?axWsK/hYmMMz38o/XahB63vOtzs6oMoUi5DF9di/CgUUjFAaOtaAq/HEfFNm?=
 =?us-ascii?Q?6JO9lC6yLCj308NFvoQLC99vQ23vNbIVWGACM2/1pPRoVo9vEWpeUoGhE93a?=
 =?us-ascii?Q?fdxH38sg0vE5ML1YeJQfuFBb//r8qeIoRu9ggHLKhcW6pcWaHfOwpQm32zte?=
 =?us-ascii?Q?4k41B41U6KpDj2E8SccdZeSJZYXij/6DNih5sOGQlF48EXNjh6P9JNWqZ6Yu?=
 =?us-ascii?Q?UaTfExxTGSIf3HbTXLwuocilLacDL5FwyjgBfmxE+6uXrt4cH5ivRHWpzG2v?=
 =?us-ascii?Q?rCoZXXSCnL8eML+0CEtkSz9clUdyBJ+K3YcdSVn7tJP5Jt48EEz+LtL+a9LG?=
 =?us-ascii?Q?MHAp4i6OBud0LIvsaKXsh/CE0qSECJCfqW6SnEuUHFhFd+BpeCBpmQVpv+KG?=
 =?us-ascii?Q?XYY1+UBVVuAukcbpeGj6ku+jInEBGmgl0+ItNMaB6xbi1NKBz9AHjtKCn1H7?=
 =?us-ascii?Q?02KfIlHegx9Oc8sBEeA/eAvjXYb2Qc4PoIw+LK+tOjarwXlT2zaY4mbJHIAe?=
 =?us-ascii?Q?nbJ+B/8zX8z9jPqmNCmjAZCdefxIC/t/OtMWiKwu?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d81fa4-2509-4044-78ff-08ddf4f1d456
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 07:22:44.6331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0vsmdThEtltil3uuhyY8KIS+IQH7N9i75lw4olh5Ng++bNi+6n3Ypl+yxro9p5TR8DOgsBNsjkarDqqtRm0ZTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR06MB8118

1. Problem Background
In Android systems, a significant challenge arises during application 
startup when a large number of private application files are read.
Approximately 90% of these file pages are loaded into memory via readahead.
However, about 85% of these pre-read pages are reclaimed without ever being
accessed, which means only around 15% of the pre-read pages are effectively
utilized. This results in wasted memory, as unaccessed file pages consume
valuable memory space, leading to memory thrashing and unnecessary I/O 
reads.
 
2. Solution Proposal
Introduce a Readahead LRU to track pages brought in via readahead. During
memory reclamation, prioritize scanning this LRU to reclaim pages that
have not been accessed recently. For pages in the Readahead LRU that are
accessed, move them back to the inactive_file LRU to await subsequent
reclamation.
 
3. Benefits Data
In tests involving the cold start of 30 applications:
  Memory Reclamation Efficiency: The slowpath process saw a reduction of
  over 30%.
 
4. Current Issues
The refault metric for file pages has significantly degraded, increasing
by about 100%. This is primarily because pages are reclaimed too quickly,
without sufficient aging.
 
5. Next Steps
When calculating reclamation propensity, adjust the intensity of
reclamation from the Readahead LRU. This ensures aging and reclamation
efficiency while allowing adequate aging time.

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
---
 fs/proc/meminfo.c              |   1 +
 include/linux/mm_inline.h      |   3 +
 include/linux/mmzone.h         |   3 +
 include/linux/page-flags.h     |   5 ++
 include/linux/vm_event_item.h  |   2 +
 include/trace/events/mmflags.h |   4 +-
 include/trace/events/vmscan.h  |  35 +++++++++
 mm/migrate.c                   |   2 +
 mm/readahead.c                 |   9 +++
 mm/show_mem.c                  |   3 +-
 mm/vmscan.c                    | 132 +++++++++++++++++++++++++++++++++
 mm/vmstat.c                    |   4 +
 12 files changed, 201 insertions(+), 2 deletions(-)

diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index a458f1e112fd..4f3f031134fd 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -71,6 +71,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "Inactive(anon): ", pages[LRU_INACTIVE_ANON]);
 	show_val_kb(m, "Active(file):   ", pages[LRU_ACTIVE_FILE]);
 	show_val_kb(m, "Inactive(file): ", pages[LRU_INACTIVE_FILE]);
+	show_val_kb(m, "ReadAhead(file):", pages[LRU_READ_AHEAD_FILE]);
 	show_val_kb(m, "Unevictable:    ", pages[LRU_UNEVICTABLE]);
 	show_val_kb(m, "Mlocked:        ", global_zone_page_state(NR_MLOCK));
 
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 89b518ff097e..dcfd5cd5350b 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -93,6 +93,9 @@ static __always_inline enum lru_list folio_lru_list(struct folio *folio)
 	if (folio_test_unevictable(folio))
 		return LRU_UNEVICTABLE;
 
+	if (folio_test_readahead_lru(folio))
+		return LRU_READ_AHEAD_FILE;
+
 	lru = folio_is_file_lru(folio) ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON;
 	if (folio_test_active(folio))
 		lru += LRU_ACTIVE;
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 0c5da9141983..69c336465b0c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -165,6 +165,7 @@ enum zone_stat_item {
 	NR_ZONE_ACTIVE_ANON,
 	NR_ZONE_INACTIVE_FILE,
 	NR_ZONE_ACTIVE_FILE,
+	NR_ZONE_READAHEAD_FILE,
 	NR_ZONE_UNEVICTABLE,
 	NR_ZONE_WRITE_PENDING,	/* Count of dirty, writeback and unstable pages */
 	NR_MLOCK,		/* mlock()ed pages found and moved off LRU */
@@ -184,6 +185,7 @@ enum node_stat_item {
 	NR_ACTIVE_ANON,		/*  "     "     "   "       "         */
 	NR_INACTIVE_FILE,	/*  "     "     "   "       "         */
 	NR_ACTIVE_FILE,		/*  "     "     "   "       "         */
+	NR_READAHEAD_FILE,	/*  "     "     "   "       "         */
 	NR_UNEVICTABLE,		/*  "     "     "   "       "         */
 	NR_SLAB_RECLAIMABLE_B,
 	NR_SLAB_UNRECLAIMABLE_B,
@@ -303,6 +305,7 @@ enum lru_list {
 	LRU_ACTIVE_ANON = LRU_BASE + LRU_ACTIVE,
 	LRU_INACTIVE_FILE = LRU_BASE + LRU_FILE,
 	LRU_ACTIVE_FILE = LRU_BASE + LRU_FILE + LRU_ACTIVE,
+	LRU_READ_AHEAD_FILE,
 	LRU_UNEVICTABLE,
 	NR_LRU_LISTS
 };
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 8d3fa3a91ce4..57dac828aa4f 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -127,6 +127,7 @@ enum pageflags {
 #ifdef CONFIG_ARCH_USES_PG_ARCH_3
 	PG_arch_3,
 #endif
+	PG_readahead_lru,
 	__NR_PAGEFLAGS,
 
 	PG_readahead = PG_reclaim,
@@ -564,6 +565,10 @@ PAGEFLAG(Workingset, workingset, PF_HEAD)
 	TESTCLEARFLAG(Workingset, workingset, PF_HEAD)
 PAGEFLAG(Checked, checked, PF_NO_COMPOUND)	   /* Used by some filesystems */
 
+PAGEFLAG(Readahead_lru, readahead_lru, PF_HEAD)
+	__CLEARPAGEFLAG(Readahead_lru, readahead_lru, PF_HEAD)
+	TESTCLEARFLAG(Readahead_lru, readahead_lru, PF_HEAD)
+
 /* Xen */
 PAGEFLAG(Pinned, pinned, PF_NO_COMPOUND)
 	TESTSCFLAG(Pinned, pinned, PF_NO_COMPOUND)
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 9e15a088ba38..7fc1b83e0aeb 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -49,8 +49,10 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		PGSCAN_DIRECT_THROTTLE,
 		PGSCAN_ANON,
 		PGSCAN_FILE,
+		PGSCAN_READAHEAD_FILE,
 		PGSTEAL_ANON,
 		PGSTEAL_FILE,
+		PGSTEAL_READAHEAD_FILE,
 #ifdef CONFIG_NUMA
 		PGSCAN_ZONE_RECLAIM_SUCCESS,
 		PGSCAN_ZONE_RECLAIM_FAILED,
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index aa441f593e9a..2dbc1701e838 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -159,7 +159,8 @@ TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
 	DEF_PAGEFLAG_NAME(reclaim),					\
 	DEF_PAGEFLAG_NAME(swapbacked),					\
 	DEF_PAGEFLAG_NAME(unevictable),					\
-	DEF_PAGEFLAG_NAME(dropbehind)					\
+	DEF_PAGEFLAG_NAME(dropbehind),					\
+	DEF_PAGEFLAG_NAME(readahead_lru)				\
 IF_HAVE_PG_MLOCK(mlocked)						\
 IF_HAVE_PG_HWPOISON(hwpoison)						\
 IF_HAVE_PG_IDLE(idle)							\
@@ -309,6 +310,7 @@ IF_HAVE_VM_DROPPABLE(VM_DROPPABLE,	"droppable"	)		\
 		EM (LRU_ACTIVE_ANON, "active_anon") \
 		EM (LRU_INACTIVE_FILE, "inactive_file") \
 		EM (LRU_ACTIVE_FILE, "active_file") \
+		EM(LRU_READ_AHEAD_FILE, "readahead_file") \
 		EMe(LRU_UNEVICTABLE, "unevictable")
 
 /*
diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index 490958fa10de..ef1ff37ae64d 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -391,6 +391,41 @@ TRACE_EVENT(mm_vmscan_reclaim_pages,
 		__entry->nr_ref_keep, __entry->nr_unmap_fail)
 );
 
+TRACE_EVENT(mm_vmscan_lru_shrink_readahead,
+
+	TP_PROTO(int nid, unsigned long nr_to_scan,
+		unsigned long nr_to_reclaim, unsigned long nr_scanned,
+		unsigned long nr_taken, unsigned long nr_reclaimed),
+
+	TP_ARGS(nid, nr_to_scan, nr_to_reclaim, nr_scanned, nr_taken, nr_reclaimed),
+
+	TP_STRUCT__entry(
+		__field(int, nid)
+		__field(unsigned long, nr_to_scan)
+		__field(unsigned long, nr_to_reclaim)
+		__field(unsigned long, nr_scanned)
+		__field(unsigned long, nr_taken)
+		__field(unsigned long, nr_reclaimed)
+	),
+
+	TP_fast_assign(
+		__entry->nid = nid;
+		__entry->nr_to_scan = nr_to_scan;
+		__entry->nr_to_reclaim = nr_to_reclaim;
+		__entry->nr_scanned = nr_scanned;
+		__entry->nr_taken = nr_taken;
+		__entry->nr_reclaimed = nr_reclaimed;
+	),
+
+	TP_printk("nid=%d nr_to_scan=%ld nr_to_reclaim=%ld nr_scanned=%ld nr_taken=%ld nr_reclaimed=%ld",
+		__entry->nid,
+		__entry->nr_to_scan,
+		__entry->nr_to_reclaim,
+		__entry->nr_scanned,
+		__entry->nr_taken,
+		__entry->nr_reclaimed)
+);
+
 TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
 
 	TP_PROTO(int nid,
diff --git a/mm/migrate.c b/mm/migrate.c
index 9e5ef39ce73a..0feab4d89d47 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -760,6 +760,8 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 		folio_set_workingset(newfolio);
 	if (folio_test_checked(folio))
 		folio_set_checked(newfolio);
+	if (folio_test_readahead_lru(folio))
+		folio_set_readahead_lru(folio);
 	/*
 	 * PG_anon_exclusive (-> PG_mappedtodisk) is always migrated via
 	 * migration entries. We can still have PG_anon_exclusive set on an
diff --git a/mm/readahead.c b/mm/readahead.c
index 406756d34309..b428dcbed27c 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -272,6 +272,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 		if (!folio)
 			break;
 
+		folio_set_readahead_lru(folio);
+
 		ret = filemap_add_folio(mapping, folio, index + i, gfp_mask);
 		if (ret < 0) {
 			folio_put(folio);
@@ -445,6 +447,9 @@ static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
 	mark = round_down(mark, 1UL << order);
 	if (index == mark)
 		folio_set_readahead(folio);
+
+	folio_set_readahead_lru(folio);
+
 	err = filemap_add_folio(ractl->mapping, folio, index, gfp);
 	if (err) {
 		folio_put(folio);
@@ -781,6 +786,8 @@ void readahead_expand(struct readahead_control *ractl,
 		if (!folio)
 			return;
 
+		folio_set_readahead_lru(folio);
+
 		index = mapping_align_index(mapping, index);
 		if (filemap_add_folio(mapping, folio, index, gfp_mask) < 0) {
 			folio_put(folio);
@@ -810,6 +817,8 @@ void readahead_expand(struct readahead_control *ractl,
 		if (!folio)
 			return;
 
+		folio_set_readahead_lru(folio);
+
 		index = mapping_align_index(mapping, index);
 		if (filemap_add_folio(mapping, folio, index, gfp_mask) < 0) {
 			folio_put(folio);
diff --git a/mm/show_mem.c b/mm/show_mem.c
index 41999e94a56d..f0df7531d12a 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -52,7 +52,8 @@ long si_mem_available(void)
 	 * cache, or the low watermark worth of cache, needs to stay.
 	 */
 	pagecache = global_node_page_state(NR_ACTIVE_FILE) +
-		global_node_page_state(NR_INACTIVE_FILE);
+		global_node_page_state(NR_INACTIVE_FILE) +
+		global_node_page_state(NR_READAHEAD_FILE);
 	pagecache -= min(pagecache / 2, wmark_low);
 	available += pagecache;
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index a48aec8bfd92..be547166d6dc 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -201,6 +201,9 @@ struct scan_control {
  */
 int vm_swappiness = 60;
 
+static const unsigned long read_ahead_age_threshold = 240 << (20 - PAGE_SHIFT); // Example threshold
+static const unsigned long read_ahead_weight = 5; // Lower weight for read ahead
+
 #ifdef CONFIG_MEMCG
 
 /* Returns true for reclaim through cgroup limits or cgroup interfaces. */
@@ -2666,6 +2669,40 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 
 		nr[lru] = scan;
 	}
+
+	unsigned long read_ahead_size =
+		lruvec_lru_size(lruvec, LRU_READ_AHEAD_FILE, sc->reclaim_idx);
+	unsigned long nr_inactive_file = nr[LRU_INACTIVE_FILE];
+
+	if (scan_balance == SCAN_FILE) {
+		if (read_ahead_size > read_ahead_age_threshold ||
+		    nr_inactive_file < read_ahead_size) {
+			nr[LRU_READ_AHEAD_FILE] =
+				(unsigned long)(read_ahead_size *
+						read_ahead_weight / 100);
+		} else {
+			nr[LRU_READ_AHEAD_FILE] = 0;
+		}
+	} else if (scan_balance == SCAN_FRACT) {
+		if (read_ahead_size > read_ahead_age_threshold ||
+		    nr_inactive_file < read_ahead_size) {
+			read_ahead_size =
+				mem_cgroup_online(memcg) ?
+					div64_u64(read_ahead_size * fraction[1],
+						  denominator) :
+					DIV64_U64_ROUND_UP(read_ahead_size *
+							   fraction[1],
+							   denominator);
+			nr[LRU_READ_AHEAD_FILE] =
+				(unsigned long)(read_ahead_size *
+						read_ahead_weight / 100);
+		} else {
+			nr[LRU_READ_AHEAD_FILE] = 0;
+		}
+
+	} else {
+		nr[LRU_READ_AHEAD_FILE] = 0;
+	}
 }
 
 /*
@@ -5800,6 +5837,87 @@ static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *
 
 #endif /* CONFIG_LRU_GEN */
 
+static unsigned long shrink_read_ahead_list(unsigned long nr_to_scan,
+					    unsigned long nr_to_reclaim,
+					    struct lruvec *lruvec,
+					    struct scan_control *sc)
+{
+	LIST_HEAD(l_hold);
+	LIST_HEAD(l_reclaim);
+	LIST_HEAD(l_inactive);
+	unsigned long nr_scanned = 0;
+	unsigned long nr_taken = 0;
+	unsigned long nr_reclaimed = 0;
+	unsigned long vm_flags;
+	enum vm_event_item item;
+	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
+	struct reclaim_stat stat = { 0 };
+
+	lru_add_drain();
+
+	spin_lock_irq(&lruvec->lru_lock);
+	nr_taken = isolate_lru_folios(nr_to_scan, lruvec, &l_hold, &nr_scanned,
+				      sc, LRU_READ_AHEAD_FILE);
+
+	__count_vm_events(PGSCAN_READAHEAD_FILE, nr_scanned);
+	__mod_node_page_state(pgdat, NR_ISOLATED_FILE, nr_taken);
+	item = PGSCAN_KSWAPD + reclaimer_offset(sc);
+	if (!cgroup_reclaim(sc))
+		__count_vm_events(item, nr_scanned);
+	count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
+	__count_vm_events(PGSCAN_FILE, nr_scanned);
+	spin_unlock_irq(&lruvec->lru_lock);
+
+	if (nr_taken == 0)
+		return 0;
+
+	while (!list_empty(&l_hold)) {
+		struct folio *folio;
+
+		cond_resched();
+		folio = lru_to_folio(&l_hold);
+		list_del(&folio->lru);
+		folio_clear_readahead_lru(folio);
+
+		if (folio_referenced(folio, 0, sc->target_mem_cgroup, &vm_flags)) {
+			list_add(&folio->lru, &l_inactive);
+			continue;
+		}
+		folio_clear_active(folio);
+		list_add(&folio->lru, &l_reclaim);
+	}
+
+	nr_reclaimed = shrink_folio_list(&l_reclaim, pgdat, sc, &stat, true,
+					 lruvec_memcg(lruvec));
+
+	list_splice(&l_reclaim, &l_inactive);
+
+	spin_lock_irq(&lruvec->lru_lock);
+	move_folios_to_lru(lruvec, &l_inactive);
+	__mod_node_page_state(pgdat, NR_ISOLATED_FILE, -nr_taken);
+
+	__count_vm_events(PGSTEAL_READAHEAD_FILE, nr_reclaimed);
+	item = PGSTEAL_KSWAPD + reclaimer_offset(sc);
+	if (!cgroup_reclaim(sc))
+		__count_vm_events(item, nr_reclaimed);
+	count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
+	__count_vm_events(PGSTEAL_FILE, nr_reclaimed);
+	spin_unlock_irq(&lruvec->lru_lock);
+
+	sc->nr.dirty += stat.nr_dirty;
+	sc->nr.congested += stat.nr_congested;
+	sc->nr.unqueued_dirty += stat.nr_unqueued_dirty;
+	sc->nr.writeback += stat.nr_writeback;
+	sc->nr.immediate += stat.nr_immediate;
+	sc->nr.taken += nr_taken;
+	sc->nr.file_taken += nr_taken;
+
+	trace_mm_vmscan_lru_shrink_readahead(pgdat->node_id, nr_to_scan,
+					     nr_to_reclaim, nr_scanned,
+					     nr_taken, nr_reclaimed);
+	return nr_reclaimed;
+}
+
 static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 {
 	unsigned long nr[NR_LRU_LISTS];
@@ -5836,6 +5954,19 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 				sc->priority == DEF_PRIORITY);
 
 	blk_start_plug(&plug);
+
+	while (nr[LRU_READ_AHEAD_FILE] > 0) {
+		nr_to_scan = min(nr[LRU_READ_AHEAD_FILE], SWAP_CLUSTER_MAX);
+		nr[LRU_READ_AHEAD_FILE] -= nr_to_scan;
+
+		nr_reclaimed += shrink_read_ahead_list(nr_to_scan,
+						       nr_to_reclaim,
+						       lruvec, sc);
+
+		if (nr_reclaimed >= nr_to_reclaim)
+			goto out;
+	}
+
 	while (nr[LRU_INACTIVE_ANON] || nr[LRU_ACTIVE_FILE] ||
 					nr[LRU_INACTIVE_FILE]) {
 		unsigned long nr_anon, nr_file, percentage;
@@ -5905,6 +6036,7 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 		nr[lru] = targets[lru] * (100 - percentage) / 100;
 		nr[lru] -= min(nr[lru], nr_scanned);
 	}
+out:
 	blk_finish_plug(&plug);
 	sc->nr_reclaimed += nr_reclaimed;
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 71cd1ceba191..fda968e489e5 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1203,6 +1203,7 @@ const char * const vmstat_text[] = {
 	[I(NR_ZONE_ACTIVE_ANON)]		= "nr_zone_active_anon",
 	[I(NR_ZONE_INACTIVE_FILE)]		= "nr_zone_inactive_file",
 	[I(NR_ZONE_ACTIVE_FILE)]		= "nr_zone_active_file",
+	[I(NR_ZONE_READAHEAD_FILE)]		= "nr_zone_readahead_file",
 	[I(NR_ZONE_UNEVICTABLE)]		= "nr_zone_unevictable",
 	[I(NR_ZONE_WRITE_PENDING)]		= "nr_zone_write_pending",
 	[I(NR_MLOCK)]				= "nr_mlock",
@@ -1233,6 +1234,7 @@ const char * const vmstat_text[] = {
 	[I(NR_ACTIVE_ANON)]			= "nr_active_anon",
 	[I(NR_INACTIVE_FILE)]			= "nr_inactive_file",
 	[I(NR_ACTIVE_FILE)]			= "nr_active_file",
+	[I(NR_READAHEAD_FILE)]			= "nr_readahead_file",
 	[I(NR_UNEVICTABLE)]			= "nr_unevictable",
 	[I(NR_SLAB_RECLAIMABLE_B)]		= "nr_slab_reclaimable",
 	[I(NR_SLAB_UNRECLAIMABLE_B)]		= "nr_slab_unreclaimable",
@@ -1339,8 +1341,10 @@ const char * const vmstat_text[] = {
 	[I(PGSCAN_DIRECT_THROTTLE)]		= "pgscan_direct_throttle",
 	[I(PGSCAN_ANON)]			= "pgscan_anon",
 	[I(PGSCAN_FILE)]			= "pgscan_file",
+	[I(PGSCAN_READAHEAD_FILE)]		= "pgscan_readahead_file",
 	[I(PGSTEAL_ANON)]			= "pgsteal_anon",
 	[I(PGSTEAL_FILE)]			= "pgsteal_file",
+	[I(PGSTEAL_READAHEAD_FILE)]		= "pgsteal_readahead_file",
 
 #ifdef CONFIG_NUMA
 	[I(PGSCAN_ZONE_RECLAIM_SUCCESS)]	= "zone_reclaim_success",
-- 
2.34.1


