Return-Path: <linux-fsdevel+bounces-41922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E659A391C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CBA7188BD8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 04:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440A51D8DE1;
	Tue, 18 Feb 2025 03:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bUSwpuUJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE87D1B0430;
	Tue, 18 Feb 2025 03:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739851016; cv=fail; b=suFn/qIMlfBmR3ZROoSReP+BnKN+F6yt9FwBlXpLxQXwoFPpVYKI7P7PHpRQjxMvQGgsL2KT4s0CBHSXfaTLHOIk184Pt2h+MsfDkB4Bh24DLr9TsPiYxU6t6FKOIVQi4sDqXs3Y9Th7ep+NV8LTUjuNN4Kg0eo06TJz/NM26gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739851016; c=relaxed/simple;
	bh=P/QQbn4mRCiYCkUUlrSYmHK3j3m73UFXSWrT3MHQtEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HQyk07y6VXsK0P7vcQXk9cw9ab58hJE29S+yDIEyVEsQopLFgxnVBAWCTSIJMVwj4l5uwKDqAq4aNs85cPu+c8gRZ62AsxHB4OH8fYV4AEODTojUggfH7Hm5Ww44HAKSkHMO1j9c78uJ1FLNcOD7NuZWUj6pOcF2pJHwrK72z8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bUSwpuUJ; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYfCw61xd+qJiKENOn3UCbhbdahW6JYJgUfKgd7HSQvmz5p84bSr1nOEqcOhh4vLXF21lsoE9x7oImsV9zdJkH+NXX6sCqJdrVcCeEy/dqno/HTZaDgvbpUzvY12CzMaELFcJ/w5/hsZG5alCIAZUOwgQuTx+XRQ5KcyS0WtzCCGv53LwTypgwjacUXdR0qp3xODG3r/dcDVzlZJdKOSxc5KBptRJLkQ37C3jlRzpOihyk82Dmgnv02nxSYmXlYGguEnIss0t8zNkqPl0LLx7SNFy96Zbg04Xzvf6DacvIGvZxOvT0Dss3QJfT6NNsFN4uBxF0LPV6IBBUFI+cEztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNPEvAsPe8G2yTsS4zF2Ou6m25axDDKUOssAOYWV7/4=;
 b=wdoG7cBgBhOIepuwoB1/vgUa0X5MEKx7MUfyt+q1McduxHAVppRccBUBTXLHyWArCyUXSGksR8tw0xAJ3L9vWMADq6Wm/CCxajw6kQKqIzM1Wjk7VhVoJpFShx6xI845zRomr0wlcoFoQZHjSsbmLOGLpJteWllbvk0S6IwOkE1CnZjyyQvJXrilthe0jQ8yttklV44PQ8Z8WAkc8X3osbMdFQH1RYYfNlZgsF9ChTdbgfwsopa5YxIeuvWlkzRKLb/Lr8hrtOQXv7RYycgklZ3AmvZVDhyXvIdenig9SsqK3y3kKFrgwj8jyMhBd9Xlq13+khmvebMbk+M369uhYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNPEvAsPe8G2yTsS4zF2Ou6m25axDDKUOssAOYWV7/4=;
 b=bUSwpuUJ9FXLYygKXmN3oThkkKzlOmBOmMdpk0Mel/pyys+xzcZVamMl3Ncu5axUcfn2IyWdSLHld5zb4z+6HiBQIShVGg476aXk3iE/Kq6hjIjtTV9epfdznsr3/Gn0Th4xBh1cSS5jO3THNG2cgYM2RrBnYKeto+0C1adWcjtj3W/qoFS5Pz6ag3lqdwuaJ7lEJuBUtBxP35hhgv1TzaI1syFBN3uRZJ8hvbEkwYbetee8z1PehRNW1vp0KK9VaVQLG7Yg02EjH1UKqp+tPbpFPv2N0TYyunT+Ywu071QSXoEb3rLkZGS8aTixZRi7w5sgwX3Y6AvLfeoOdwgOOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 03:56:52 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 03:56:52 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	Alison Schofield <alison.schofield@intel.com>,
	lina@asahilina.net,
	zhang.lyra@gmail.com,
	gerald.schaefer@linux.ibm.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	jack@suse.cz,
	jgg@ziepe.ca,
	catalin.marinas@arm.com,
	will@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	ira.weiny@intel.com,
	willy@infradead.org,
	djwong@kernel.org,
	tytso@mit.edu,
	linmiaohe@huawei.com,
	david@redhat.com,
	peterx@redhat.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	david@fromorbit.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	loongarch@lists.linux.dev
Subject: [PATCH v8 12/20] mm/memory: Enhance insert_page_into_pte_locked() to create writable mappings
Date: Tue, 18 Feb 2025 14:55:28 +1100
Message-ID: <ee748e555fb0dc190994a0fd59a57b9c43a17dc9.1739850794.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
References: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0069.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:203::13) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: f3bc44ad-ed74-4b5f-5dff-08dd4fd04733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rJ3ImbYysslXd9HxMj76e/txIa3I7pSrc6zoHhJlmfKu8d8PolAAq5ss8l0z?=
 =?us-ascii?Q?TK/GXRmKvdiqmbRwvCwIjtraZcYm2Y4lCHRpr3M3P+h9SWTGHweqwhILAxEe?=
 =?us-ascii?Q?EWqfMIzglJUzeedvLilgxgrwiRoicOYR509p7eg4GraIDaH7kkp9h4k5+a/8?=
 =?us-ascii?Q?X7SHcyUadMc5ihG9F7Y+rRctHKepvSA6/sJWYT7QH4UssTYM16neJiGahzrR?=
 =?us-ascii?Q?nLOUBdz/TU3lal3Cqw52m7pLIWCi5bFtb+7yHcX10HLN3pRH9TYVmkTnVcjw?=
 =?us-ascii?Q?32WIeS3hX7rIWpFlOyzyF37JpIxSeEUCFa0rhvoxsHncXU8x6kpm+2eqWUkx?=
 =?us-ascii?Q?cObJIhaLuoZmfUszYu8dc/odDDoDXK3VAgLQpWakoj6Ruuv+AK4HHFA9ZfCJ?=
 =?us-ascii?Q?BlLRNwbFEAUjR33tlhMxf7cuFpfpbXdsgBrSa+Ad9+lICXcIzWOxv9B3xO2G?=
 =?us-ascii?Q?64iU7YfCC5sz753U+fRz5NFtxLJo65KF6r8hNUF394SQj73YZgucL/eu7Ka1?=
 =?us-ascii?Q?szZt7cEv4kdrfxxxEL4OnqyPDOk+sGzeMPIQ0fdZzBme5zufeD+CE6JLOOyp?=
 =?us-ascii?Q?OZW4TjYRxQkV4NQ78KG3IU78TDrwT87suw5TvZ/WGcENgBLnQc4qbliaLBcw?=
 =?us-ascii?Q?Mh0Y8Goerazt30rsZA5wMO4YlbXba0p3OvQjiMnFL+YV6V2meqJ/CekaJxyc?=
 =?us-ascii?Q?oYkXxKHNX2R/ktjyme4EBgEppwjTLFA3WxdubCQwqq/w3a7RYqD8jP+kBoI7?=
 =?us-ascii?Q?rBTZmkk6uR/jhdtWG0QXnLdWZ76ilYrNo0rG47kMFgYhS7mzLbrcOJq9SUOZ?=
 =?us-ascii?Q?qy9UKiY34YgKJdj405pttjzJZk6wcpPKdVbazE5hU64Wn9uv8y5sjxpzKghM?=
 =?us-ascii?Q?6p+3ZASX/Qce4mnFlCiCnKPtP1gac32ao/vhbkcvn1GCJXik2vDfW8fp+4BR?=
 =?us-ascii?Q?knHnYl4jWNQpZ4Fmi2KEAndsQyV7k1k8zTj8t7c+horeiVOEwTk49+vNgj1q?=
 =?us-ascii?Q?Qwj8Ahk/PRI2EAv591l2wujIdIQwgUV8x4gS0EhAHDQDn8VjUJI/oSbacAOR?=
 =?us-ascii?Q?yf6vXxVSRBaETHx3ubU+mm8Uassi49uyBAlyY8UB7xOgsIqw54SEBttW85bw?=
 =?us-ascii?Q?wLNIFkTAgupCe2whTCOD4R526U/VcJ3bZS0m/Xl7wfOGrXcxPg09vtq5L3Pw?=
 =?us-ascii?Q?kY0mOn1tMGn78wlCaLIuCHDhEli15glm+qT5Wbx4Qr2t1ITxvXLNVtj7OvpG?=
 =?us-ascii?Q?s39rmyPYhZ5Wo3M20wO8LLn9igQiLPZu++0mqFYwhu5qhr5zUOEXKFboevKH?=
 =?us-ascii?Q?jTC0ddgD3xIQ85mNgqJSkl63VAi8GKaX/5OckmZzrOhclTk2xnVXodr7Jbif?=
 =?us-ascii?Q?GfKEfBvuI5R2cJIqqexR6U6S6njJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lnSzF5AfJ0Lhe1w2EWsCybFKAZZTXxqdTQkvzJioFlXKo87AFLK4B39e2NPa?=
 =?us-ascii?Q?wBfkK1hA4o4rcj/pjlmvkVfuKiZ6TAsDzhXza2pMBWK5gpMngufdTJ7Dj2xB?=
 =?us-ascii?Q?VOBDabIIYTo+trObKgqNpUUD4/DgK/SJJqpxGUAQu6Ur7t+jtWhCi11hzLGF?=
 =?us-ascii?Q?rxKUCB0G9ns6vKbxl4slxtGTpcgHcaEXFvWiw3wqV5oKj1FylLkw06Eoljo0?=
 =?us-ascii?Q?Cj1CwltRKrQFJ54gu3m5vgZLb9u8njBNv7Ja70hWw0JK7NVrSxuOz0mzQHFn?=
 =?us-ascii?Q?E8mrKSfb5MnkwIaz3UrpOF+ABi3cejHmljYHkHWwsS02yILgfOo5PK/Pm5jj?=
 =?us-ascii?Q?79Mykna1Q7UrBuc+3YjGTlM3mh2OcAE/X+1TK2jbHg5rkuInn4CN7nk7w4rE?=
 =?us-ascii?Q?ooCt9Lpy8Na5V96qkooTlFz96Qp9ZFxpxyLGtEn4JMSQ8D0DwtUxUEJIdd6j?=
 =?us-ascii?Q?+x9hmWdpRZ4+s/DBk6ncaH78az2PNGd5SH1GXm6KeXSPC6ZFmgT+L/dVdpVG?=
 =?us-ascii?Q?fjoeqN1ToP5yZwnQW8OFAoCJRjRZCd26TcVYaLVuaxll/IUcik7wV7qtad3f?=
 =?us-ascii?Q?lWjTcxj3UewvSYB8BlKmLNrggK34X/2OnUBwgUTRTEntB8uOcx9ZHZcV8Rjz?=
 =?us-ascii?Q?clLPCFG466P50qXIJUhDE/RE9aKe3Rwz43ifLXXocsltNkIf4lQWz+D2p5NW?=
 =?us-ascii?Q?rCmftZ6mRtE5v5VG23WYpj6epZoHmGxWXvAG2p0f3IsS/C/nYdirdWoPXwk1?=
 =?us-ascii?Q?b8UVBNujUwsPABUei5t/eoLS4i2yK/rF+EEqpmV2Y3w99caw8Rmpm6gBWdao?=
 =?us-ascii?Q?SE7Yc4NJ6qHIODKMVH6QmP9QxTUcE+P2rs4PjvWnr6DteopfOBUpcY9G6bg4?=
 =?us-ascii?Q?K/c6oFChALz1cMVsuTHN+MxYEgewD2Gc0pTcNExBcyRnR454EnLaT3kIi+/S?=
 =?us-ascii?Q?c4afMHc1Pq4mkq0vjpYlNSFBTmtkjaMhYXJPk4EaPQixGzPZDa9E1n3UzbSb?=
 =?us-ascii?Q?dBZBhah3RtZxC6EeGehHDwy5j62aPuTsawvbkJ0Wl18ZNiUfxDc8vLLMVD8u?=
 =?us-ascii?Q?7uTv5jZ5N1yk7xotkzadBbofUCpteJLPd0ZFeWh9+d7KcbZBdfObqY6ZajBc?=
 =?us-ascii?Q?a9mMSxEEsL/uljCf/0yF7t8XoWiOowzMRrjGc5fDFx/5cK88T4TW4cve0JAP?=
 =?us-ascii?Q?S1Swx42TnxSmm+5rQ7YXzjFsEvSvOOCf+2Up7Cv51IZy/7hNXrzFGCyKk3iG?=
 =?us-ascii?Q?cyIEK+GsDXzXO1XIjvYAOqFHqmrshvPuJd4j9jhriXtk6Q6+PCsDbMtJig/a?=
 =?us-ascii?Q?coV2eakjee/rwsT3YV1LIpPzfGxo/SK2Wv60GfmF6u6VIdHIxubBKna9TZKj?=
 =?us-ascii?Q?UnzaZruH5m43p6svyKNNJ6qztEpyBbfpHdFoMbzdkyWz4pd0UoYa8ZuRFgI8?=
 =?us-ascii?Q?8nDIhP6vo+tsfCK3yQOQ2E0Py4mzaNOyY83N3pII69YWxgpu8piKl+6PGpzC?=
 =?us-ascii?Q?CRxx4lVM6mD1l67Seepvhj+Tz1Hrt52tMCIp3DiQptLukzvpfW4n7+OUZRD4?=
 =?us-ascii?Q?DoB38vqxXXAYLHWX3pjJTmAJBmFliogcbiBmKv28?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3bc44ad-ed74-4b5f-5dff-08dd4fd04733
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 03:56:52.6265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ql/tmcaoeAwlY1ViqPDqSRvtTGCHk0jIizKZ60Tb7KtSdTv+yko7qiRFaq2bPAww4wKbIkKz80l9e/dU0ofkSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593

In preparation for using insert_page() for DAX, enhance
insert_page_into_pte_locked() to handle establishing writable
mappings.  Recall that DAX returns VM_FAULT_NOPAGE after installing a
PTE which bypasses the typical set_pte_range() in finish_fault.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: David Hildenbrand <david@redhat.com>

---

Changes for v7:
 - Drop entry and reuse pteval as suggested by David.

Changes for v5:
 - Minor comment/formatting fixes suggested by David Hildenbrand

Changes since v2:
 - New patch split out from "mm/memory: Add dax_insert_pfn"
---
 mm/memory.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 905ed2f..becfaf4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2126,19 +2126,39 @@ static int validate_page_before_insert(struct vm_area_struct *vma,
 }
 
 static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
-			unsigned long addr, struct page *page, pgprot_t prot)
+				unsigned long addr, struct page *page,
+				pgprot_t prot, bool mkwrite)
 {
 	struct folio *folio = page_folio(page);
-	pte_t pteval;
+	pte_t pteval = ptep_get(pte);
+
+	if (!pte_none(pteval)) {
+		if (!mkwrite)
+			return -EBUSY;
+
+		/* see insert_pfn(). */
+		if (pte_pfn(pteval) != page_to_pfn(page)) {
+			WARN_ON_ONCE(!is_zero_pfn(pte_pfn(pteval)));
+			return -EFAULT;
+		}
+		pteval = maybe_mkwrite(pteval, vma);
+		pteval = pte_mkyoung(pteval);
+		if (ptep_set_access_flags(vma, addr, pte, pteval, 1))
+			update_mmu_cache(vma, addr, pte);
+		return 0;
+	}
 
-	if (!pte_none(ptep_get(pte)))
-		return -EBUSY;
 	/* Ok, finally just insert the thing.. */
 	pteval = mk_pte(page, prot);
 	if (unlikely(is_zero_folio(folio))) {
 		pteval = pte_mkspecial(pteval);
 	} else {
 		folio_get(folio);
+		pteval = mk_pte(page, prot);
+		if (mkwrite) {
+			pteval = pte_mkyoung(pteval);
+			pteval = maybe_mkwrite(pte_mkdirty(pteval), vma);
+		}
 		inc_mm_counter(vma->vm_mm, mm_counter_file(folio));
 		folio_add_file_rmap_pte(folio, page, vma);
 	}
@@ -2147,7 +2167,7 @@ static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
 }
 
 static int insert_page(struct vm_area_struct *vma, unsigned long addr,
-			struct page *page, pgprot_t prot)
+			struct page *page, pgprot_t prot, bool mkwrite)
 {
 	int retval;
 	pte_t *pte;
@@ -2160,7 +2180,8 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
 	pte = get_locked_pte(vma->vm_mm, addr, &ptl);
 	if (!pte)
 		goto out;
-	retval = insert_page_into_pte_locked(vma, pte, addr, page, prot);
+	retval = insert_page_into_pte_locked(vma, pte, addr, page, prot,
+					mkwrite);
 	pte_unmap_unlock(pte, ptl);
 out:
 	return retval;
@@ -2174,7 +2195,7 @@ static int insert_page_in_batch_locked(struct vm_area_struct *vma, pte_t *pte,
 	err = validate_page_before_insert(vma, page);
 	if (err)
 		return err;
-	return insert_page_into_pte_locked(vma, pte, addr, page, prot);
+	return insert_page_into_pte_locked(vma, pte, addr, page, prot, false);
 }
 
 /* insert_pages() amortizes the cost of spinlock operations
@@ -2310,7 +2331,7 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
 		BUG_ON(vma->vm_flags & VM_PFNMAP);
 		vm_flags_set(vma, VM_MIXEDMAP);
 	}
-	return insert_page(vma, addr, page, vma->vm_page_prot);
+	return insert_page(vma, addr, page, vma->vm_page_prot, false);
 }
 EXPORT_SYMBOL(vm_insert_page);
 
@@ -2590,7 +2611,7 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 		 * result in pfn_t_has_page() == false.
 		 */
 		page = pfn_to_page(pfn_t_to_pfn(pfn));
-		err = insert_page(vma, addr, page, pgprot);
+		err = insert_page(vma, addr, page, pgprot, mkwrite);
 	} else {
 		return insert_pfn(vma, addr, pfn, pgprot, mkwrite);
 	}
-- 
git-series 0.9.1

