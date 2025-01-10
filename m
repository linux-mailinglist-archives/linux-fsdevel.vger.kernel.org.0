Return-Path: <linux-fsdevel+bounces-38826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C25A087C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 07:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CC5A188C696
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 06:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41DF20D51D;
	Fri, 10 Jan 2025 06:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QKr+00fB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FA020D519;
	Fri, 10 Jan 2025 06:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736488986; cv=fail; b=A4bbn10D+8U23R1u3RtK4njf41HYd3AQbTG1M3ZGoWZyO79lc73vZwtgGRkdzkEmi2OhUtwvXx1xUwRgLPhKsDMyKtvwonF7WVEe6hytWXfDjSomy7VqTjda6CASoeKjm3oEBi1QZdxS1yYFaWqpg6hGbfa5CQJ+EMeDrgdTJ6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736488986; c=relaxed/simple;
	bh=loy8fPKit/qXe324VBogY6o/wKeTCAS31/8tkMWBmTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qYl/g4BbsVCVEAQNLSlZgv6Alxsypl5tWYCkEf9dlP6Qfp5NXLM4wdRTvuA0rhzH2afK19nDD3ii0+mx95blKOcoUNOPYimuT8kroH02VhAhGdoIs0pYmBVIzDnt1xwr2wUsA7WfANCcXNXkxW/fHm23PhcfywT0R0ALg+Gxwmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QKr+00fB; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcCFUIQfTmGAs2iJFzuF8OhJltqNIruYM15wbS+XzYtcB1Ziz/CKQUBrGnJs0vH19fKmzBIVmU5MH+DfYtzvsB9nqiKOU0NeYYyh7SjXhkXT1bQt7AwUTn6lkKC1QeZm2LSy8BDhrzcUY3QW5mijrKC9ua0GZwO6ZEmpNVTtA/SPhcOb8IJGtv2uHLtsLhznEhpMFyyk9BsK4dqG1f2yRGQ3JWC5ykSz28zEZADHoEN2jjtPIt0z+6SxC0soZPJwvLK2s6yZM9MXFHhtCMPnFeYkDxt7i4E62+eZcqEZ4zW01taszeoLWqSMKC1oh5/jsADCTzibM869RcAaqxUdvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjp6m1j2W9OFBUPeqNP0AlhzXfJRFG5q0VazBoZoLDo=;
 b=OoEfWt7qnzdrsso9pqMotrrpUWFGFQ4qXwRRIeQdRjaSbE6tvInhN4c4AGgOIE75AsETpGFHWPLGg1FhdehHEUO6uG2I6bvvq0t+G29+EgvcZLPz3vpICzwWlsHS7NQLfRmj+TdKU06nsSXrPuUcDy18d57th6L108pug6qPs0plz//ode9O3jOFSdo7++Pl35o5aVoC/bwaKqSRwIFnkT/KFNUhbWomUV1cwfM4u94LlNVE3Ru72rcb6vwmVNkFUZ2+PdJ7jmlRfosEKfBpMrCIoizUQFjOs2w/AmvR9WndFT8hBTcUhJxXWgI+1VTFyl5iSWd/cE+Eo86Bkk/o1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjp6m1j2W9OFBUPeqNP0AlhzXfJRFG5q0VazBoZoLDo=;
 b=QKr+00fBefzYTJp7tq5iChuIrlzvuqh52P6AqX/dqLUUnBG8GsL8urZwTIOj9LRMhyc92vbRp/RAznKicirLxd6+k/DXAVYK40RMNeN15vzkCm4fDpnNuRiyvrRjHazdFuHRZG8TdDPg/XyxA5w2JYu5VX8KzwybR5oa/e5OLU31Ax5ipBzpx4gPBHXll5XdhftLhG1Tij0A1Va8sAuLY3ZUXWsTeJEw/WeYQMPcKbAUtsiju+j01R9lLFE1LfDCC4P3v/kZizC52d7mhc2sYtrbY9r1WadKpFflxuBqTj3KLngdxaPOo+561eiDe3e6M0CCXtYTftgkOiTUMY85cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SA0PR12MB7002.namprd12.prod.outlook.com (2603:10b6:806:2c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 06:03:03 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 06:03:03 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: alison.schofield@intel.com,
	Alistair Popple <apopple@nvidia.com>,
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
Subject: [PATCH v6 20/26] mm/mlock: Skip ZONE_DEVICE PMDs during mlock
Date: Fri, 10 Jan 2025 17:00:48 +1100
Message-ID: <e08dfe5ec6a654e8cb48f9203d7406326368f5a6.1736488799.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0110.ausprd01.prod.outlook.com
 (2603:10c6:10:246::8) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SA0PR12MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: afa4d788-8ee3-44f5-be5b-08dd313c71b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uS5EiES9d3/74tjwqgbjPXKb1tMMWwLoBPx5/VZ2LB6BO77fx5M2QYCfMBnX?=
 =?us-ascii?Q?IjHqxhbf7wR7N0AbftIrElhTp3N2jkjPk6SsLisHctmf2FhBu1+uzmK5QBqo?=
 =?us-ascii?Q?Cfelx9+dIK4hTDSgAsLHhVl0LxiH/OIaGVLNr5B8dcJH/hrhyEziPk2YexWE?=
 =?us-ascii?Q?QKjMaNBP1ffxAQIpS5tb/3/fi7COtGdAHKyhy6sTsF9yPAgBhmss2hx/PuOm?=
 =?us-ascii?Q?ccvN7uwYRNufTQfu1bR1/mkI8eLsjTbBSk/iMxUaUbbHj7xKLndl76EAZG8m?=
 =?us-ascii?Q?nR4+7I1SknlaUQb1sirJ4cLpaK1yNe35LybpZ2KzyPKdTiHHh9476pRkQrbQ?=
 =?us-ascii?Q?dcsZ/oIoJoTQZLrEHT4xsSUcmq4lamEcxS2fvGICQ8d4yXoFkJZsbt7PcUOV?=
 =?us-ascii?Q?u6HVGu7vRSErBVL0YwrDc6P1O2KUTftK4xmQlJ3LQpkceCr7PGqdkGwV6GAZ?=
 =?us-ascii?Q?6OWnTikwlqC3lfm42iYyQlpEFwMsSjMUOgoFDkisV3lB8GG6Qk1ADDaWEJ5f?=
 =?us-ascii?Q?1vJ686uyqD1Q+IZpQjpQKjhYaQ5NGIoEWAknWR+10Mtsn6t/+dCV7cr8fS1i?=
 =?us-ascii?Q?oXgSc6pSphAm3BOL4IZt7+sQFaDhRuMzMiWn6wk73MHii2buVTynuMFJtdlW?=
 =?us-ascii?Q?0uHlt7t8dG45p5WfPmfFuuvW/B/qZHRbn8qEBbgh1XQ31Ln5oTu2qArPwe21?=
 =?us-ascii?Q?v+HybiaRQ80/9bdINbf1cQ4vK3/EthyNjG/Hv/CYXxpwZclsCOfZTSpjr2HC?=
 =?us-ascii?Q?+xrBMp/2Q9M1LXT27s/Ah2o1/sWoJrVAmUD2z4Rdglof1ldapP15xUi+imaC?=
 =?us-ascii?Q?7Cmm900VNN5H1zMpw44ou9WmCrXfmLpBw9vRcoFFO41eg4ux5kK5cjHxYhNr?=
 =?us-ascii?Q?jMvslcT3U4kAmQDTXtwxefO7rx9/3Ybdskk8us0nYbmZyPC6Dd4tnQWGxtwg?=
 =?us-ascii?Q?I3PCSOdZS5/jirdv/dk69vZaqbxsIfJqWpLZhp4Dl6vSLVTFCm+xkk2YspPm?=
 =?us-ascii?Q?aC8ldguKIsRuILwcW8K5VaEny/XUcCHkJk0SVw6Fu2/qpZu+l2nHceTwfCiA?=
 =?us-ascii?Q?1IBoqZjMG3bnxMT3jSUPzXp48yDn2MbYPJ84x/OOP9wyKk5CW1SNld/ob4jR?=
 =?us-ascii?Q?IFfJ8GxZ26VbX3uUM2E3KpCkT8KEZ91v2HL1nC98iAHFMRhHVe7D7s0kxUpi?=
 =?us-ascii?Q?HrAuPjVhFqg8GkFXVmnQY/kvDmZ2EuiPaz1+JJwvjIbJuo9J63gaSdTcNHGJ?=
 =?us-ascii?Q?Io3IAqbKq0vR7UO5MpacuOTEyfqiU7hgS+w8DWtN3XoL6h8h6sFRr3xoMRBV?=
 =?us-ascii?Q?dgPHcSZFFdcIkSm+B8n1WquSTYTW3yEqSZqZcOnUormw0pqpF/cdAsdqnWKR?=
 =?us-ascii?Q?2BotABY4Cnui2qd3nuz2iXcd5Tvd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zotEBBB1qWzkwUK1zoCTCFMKSCY4UHptMeSuxjBNSOLVA0kLB5N9EuVvSEnc?=
 =?us-ascii?Q?znjazl++TFXmfUUNkiDhRwjJvatZ+GiZqZzoqdhy2HcGo+iqqSQtGpL+1dDC?=
 =?us-ascii?Q?kHJdK5Csaw4W6M3SiXCTETB4tejQBa+Cww87wCi3E/PzNMv6YIhjTZtY5clT?=
 =?us-ascii?Q?RA7kGmD4hr96kvxh+rdUl458exMavsudjz/8On4bM8AxT1shCqbq6NJTcmp7?=
 =?us-ascii?Q?GEiOgWwHNt+o03WoIUlrTIB0w7mHMcvsrxn6PLQq8FitI2fHJ6q+1KIMRD/Y?=
 =?us-ascii?Q?PS6raJ6igqz7PG9QOxJ0xa588i52YJTmUvkSBAPx1ljg+SxF8WL5jUvG2RlR?=
 =?us-ascii?Q?1+ZPys0LwTrOgR7WM85lxNCORMHuW8lfKPJbkUS30tGLVzQuDcC2EaGOALbP?=
 =?us-ascii?Q?M7EuPk6QSMUW7t/jVPGrrCYYE6aWjePcYQ1dKxHAgLGspr6FtCBaB2Av5Ldq?=
 =?us-ascii?Q?rAVAPuHiNDYjsDwbjxPCwg0Lm+hxqbvd6p4Mo//NYTDe2ZJzThzBSfogy6ye?=
 =?us-ascii?Q?7q5sDhj0Fz6V/wg06jhBoqhp6ysN5RoPk5Uv6flimKHqYVLfm7XcbHWtRwp9?=
 =?us-ascii?Q?4CMzQ8GNKG9ieRsFAaFpnxmMRZPi8wGgMsAYnAGhAMWQPLJD0PqShcNmd+Qp?=
 =?us-ascii?Q?12GwG9IRICMqqgVeUFngypWJ8JEBQI/5W+4o1PrXmx+Qqm4t9ZU6PG5aYzGc?=
 =?us-ascii?Q?qfIdEGv290bvG0SBNI3LmX1ettX/hvIgHgicfYFW7BWaBrO19u8EKQ8SV1XP?=
 =?us-ascii?Q?++Z9YuzeJfi9v/2s8OwqMbN8APRoE5B72mSkWzigk+o+SMMHcldxRiSHoCZf?=
 =?us-ascii?Q?q4QuKj8Z0tpeggSJ/H70I4pxhzNNJor1J/l0DpDJCMaDxXVrDdafitQ7NHSX?=
 =?us-ascii?Q?QmBH8InrdcTQFABk15aSjb8pYoxRxrI32j3kBgqCBahwlGsk/7DEQs20e+rM?=
 =?us-ascii?Q?vG5dEHt1f4ieDcP/AcsjTO8ZpLCbT1bO2SQjjJWKHh/44G1z97zZMBHGiHnX?=
 =?us-ascii?Q?jRZd4v5V9OFjCITQHI3h/g3FTVInRUOF243SP9gONEKgiCjFmYUHDOOX1JWy?=
 =?us-ascii?Q?t5lG6e5NFcCyewu1c+8hOCXzfBCXVPiUJ2+JOOpuooFxxk2oUe+huj1PdZPh?=
 =?us-ascii?Q?MyVQIbOzoANQzspSmdJ0P/Gt1Rr2C/eRoU7ZHqewjsMXfcx00zKC5o7hR6A1?=
 =?us-ascii?Q?W2Z0TuEbMrpqO3pC8w9wA8U5vL8UeWSyc1k5896G7plMYfQ3nfkhxXBWYkV5?=
 =?us-ascii?Q?2ArAFZnP1V6a6rpPfxG8GaQpsEFDC40Pckmj/7SWtkrZvTJvE0hsCVFG6vuV?=
 =?us-ascii?Q?TGu9vzAvW7lXY+IDIEIgBimoWTiWVmVEs7qVZo9p7Vso/RMFyIiQfNxROCiZ?=
 =?us-ascii?Q?2PRu8WchXRu9mbzQmO7U7SG04GC0Z5z1Uv6mTYBMX7mAMEufXv14uwHrvDNU?=
 =?us-ascii?Q?k12qjkRNSYekcthtHY4Ibwkd/Y8TU8EXabdIAeDGWlF3yHTtGOmSiD3hLeKp?=
 =?us-ascii?Q?mCRQy1bLuw/lQWMWplvzpv9bEec9UCeBw88R1uQzE/MRpIc17x68dp/DLHdu?=
 =?us-ascii?Q?CT5AHyB6F4GCXSNX+/0IOjhf4gTuCdfq7CEiSXsk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa4d788-8ee3-44f5-be5b-08dd313c71b8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 06:03:03.3250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LG6biLSqoKt4cLY4S8ShavfRhAIL0kQr11bOyLlTWefO8Fvz0a9jMErzwprAX/nSk8i6i2DEdBT13HF4Rat2Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7002

At present mlock skips ptes mapping ZONE_DEVICE pages. A future change
to remove pmd_devmap will allow pmd_trans_huge_lock() to return
ZONE_DEVICE folios so make sure we continue to skip those.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/mlock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mlock.c b/mm/mlock.c
index cde076f..3cb72b5 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -368,6 +368,8 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 		if (is_huge_zero_pmd(*pmd))
 			goto out;
 		folio = pmd_folio(*pmd);
+		if (folio_is_zone_device(folio))
+			goto out;
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_folio(folio);
 		else
-- 
git-series 0.9.1

