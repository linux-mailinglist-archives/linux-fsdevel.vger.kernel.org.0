Return-Path: <linux-fsdevel+bounces-22604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF9091A04D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 09:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7E4BB23F11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 07:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209344EB37;
	Thu, 27 Jun 2024 07:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wpxa5Cp9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F704D8A3;
	Thu, 27 Jun 2024 07:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719472772; cv=fail; b=A/tXssupOq6d8QDz2a1/WLWDxqSi/W1Is0cldABC6WoWwFhYHeP1MqRfvvLmKhEqioEugbEG0HNId+JbnbJ6bJOgMep6EIrcfoi8dx+0smnZxSLjwns05LWAKY89yrAj2tVippEekkHkooRVxcEXxpAwDEZwGvdaxwVemSf9TvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719472772; c=relaxed/simple;
	bh=So5HGmoha1cmaGEyyrwK3oGoD9RAccEIwLGiJUHwFv8=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=tKvcqig+ju5LYSMQx7jJVxh460g7a6n3PMgLOWRSyU5FnFydUgwuuFduUzTyTTo/2Phn3epBrAf0tIXhPPuCfh9pHoO3QIkn4x3shSpFtHBMwaWR7FyX8X/DPimCwhy0rvPZqzgaS8hV3ZjjiJ0U5Vewyf/PKQmw7u6Alte4RUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wpxa5Cp9; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnKP4plbDngdsvxhoZsO/yWRogbM465GxSgV28Rd65myiaMLgpWs1S5LxmA3fVzv0Ah5Wc1mn5EJo+bWPRpJTzju/GZxDpdeJOa6kFmNvEpVHwNppAw3gJdCw8IS6Agt52LAfTmKRO9UfCOEsys+d1cgl7twYHen33F6DSNeAwTTX573QN5B+/7Ro2LQlUYQb1yf+ENsz5V97j46ETOmB4oO4nNONLUx6XuU9j6Xslm9unbFtsoy3Q7/FbMnz0DSwZGeV35euxieNTll1nx5xQwFc0/Gti0eepIdD9yUuBjgKdF/yhdTj/FKfo8jlBJN6sbjpiLYSm8QYYKdLwjqWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYsZH2nmxZOUyxSymZSCTUzrvEFbsMZANxYMqle02k8=;
 b=O9qZ7PbiJQGpVHP1WXvr9WlSe9Gj2LFq0x/gZHgN1Jxuve5QiiAhSe5PlPmWP7X2pa2TBGL1MDRVC4GuTxdqi387fWKP1PQ/fcxaChQDa3I9N5tKBHXjHSk7O1MfHrkGGULn9IGzKkqj0Rw9XtTOXxjBh52jb8qA/MshvkU+oAOC6Pbm2fmZSqj9iSZupKDdvfQ2juQOV/st2fIq9P0dyg98TBEpyfinnjgOP+kmOo55AIbkwq2PnGPkB6l38j1CCOG30iG5Y1Ya5crBh/5btEZ50CCu1pNc2ZNmfap3ExtZelO2bzNFeChmB0U0Yz3xhEt0qFVNt2S6fwP7KCmJsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYsZH2nmxZOUyxSymZSCTUzrvEFbsMZANxYMqle02k8=;
 b=Wpxa5Cp9+9ns9uIlQRLxahK+8IM322HS82cOpSmhMGadDh4mIk6SYM5hji6NTLk+SinyOgc12ajJNDVs6/SDFOKy+Q8hWMKqIVO9y5eLTJTWiKXL4rXxVLzv0L22BF4Biraza4OyyGH38bNGGC74lRJssmOM24ufnGoOgFeLA8a1KCgm6B13FSv1ATMNA+s5wl4rj6xrXUtAL8n7pIuMkJ9gg8ZWUXqHoaw3F4F7LdTdVNoG4Om0jBYDgT7NVi/VXMfkAdxsPPB69WQ2JQ4PKVC4oHHOW1GMaQ8P9r4/vzI6O6duX9FCAcgEYKaSzz2HkawV/1m2S2sRHykFvZznnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 27 Jun
 2024 07:19:26 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 07:19:24 +0000
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
 <667d0da3572c_5be92947f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
 bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
 will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org,
 djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, david@redhat.com,
 peterx@redhat.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com
Subject: Re: [PATCH 00/13] fs/dax: Fix FS DAX page reference counts
Date: Thu, 27 Jun 2024 17:15:28 +1000
In-reply-to: <667d0da3572c_5be92947f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Message-ID: <87a5j67szs.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0123.ausprd01.prod.outlook.com
 (2603:10c6:10:1b8::8) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ0PR12MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: b2bc0bcb-648b-4661-1b93-08dc9679790e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GMcZN4/W8334FljVAvaAJHUSYV0kpNMoFF5ek+Vi9KnxDoL65UTETz4wdNqp?=
 =?us-ascii?Q?Vz4PGdGQAg0+U+7xYUcNHU1kfyBAY17i5YtWN92pzoetVW9Z821prAqwX6P1?=
 =?us-ascii?Q?pKgePlIBR7y3jgB0jgMe3PSUo7GmAUWOcZX4WOvGFs9LLkqZl+YCELyRM8z0?=
 =?us-ascii?Q?3XCaB6NMSSjIrjeJUthfAXBeu8jYjjx8RhEQrcqCn420ilTK84jgSknaf04P?=
 =?us-ascii?Q?ZF+kA9cnLNprlyCYvLcI0Y5uIhDYf1V92SEV4O1nQCwz+6W1cJb/t0wNAmX3?=
 =?us-ascii?Q?Wy9ZT0vWLGkdVLq/Eq1zGLplPaIq9SygCNQPsQ1zVYZugnv+Y/twzPyHTUte?=
 =?us-ascii?Q?FVzn6atOWB9GH1Az5JSY0QBk+eoHbgZ2IMrngz4hzdkwk3NJkWWS1+6D0dRe?=
 =?us-ascii?Q?HxyZ0o41JIPoK5vNgnCd5GhkjOHs6L0LTDkbBJryPZr9LLT/+g5j+dCEaO56?=
 =?us-ascii?Q?0LlTW71u7Z4i803ZdX5lbpP8vBfkovgJzgLmHawbe/EJXKJTMR2NHTwNm2ce?=
 =?us-ascii?Q?9KSHAvEJRFsZiGJmlZOZlLBjHD29PfEcTUwozqnuIWr87ZeVshMogFaBldob?=
 =?us-ascii?Q?NObTIXyj3I8iBSz5m2oCaTPH4UJz767uNFxn5Q1OwtRqVO9nPeIjTd1nHqse?=
 =?us-ascii?Q?KekEEVEtO4rxdpVdWcKiNUISw2eaePqYNX6Phr9zxapXpYhqtbpMlkB98iZB?=
 =?us-ascii?Q?CmPoVh5maNzaX3Pk/ZP2Ct27JoHg9I0tk3yZ40s+DeI6EHXQrHErQo/QbvG6?=
 =?us-ascii?Q?CBtosMPrBgXtybs90oq3x8treVeVogoDhIF7MZLfBXSG4haKdcsxq2fX6upj?=
 =?us-ascii?Q?10wKWNBCmy3YQ5uOu26gtLfbIpFMgZPmFUxK5+TM6tymeIVQpcxYlFByWGOw?=
 =?us-ascii?Q?foTlEcJslUWiEhoiHQ9YE4wl15o30wf2lrZ65J1d4xxE2TolhCQCjzCQTq3k?=
 =?us-ascii?Q?MnP56BiAsVKxfaDrNQRGVnIJyAW4l34j68+bsSsKUuzi639tNqvXzihY2LHF?=
 =?us-ascii?Q?4EPn9V17PSweeKXmPmXlnYB5PvD+wsttPlA9SEOHqhCn4aTX8od/56lJd1w1?=
 =?us-ascii?Q?7k3nUkev0/ieZywKoBQ0Eps05urSZ7mu+7It8SxbOjHHHgRucaUTKtyOMNio?=
 =?us-ascii?Q?WnAI8Wet5RhoGhsiqgKg/VsRkUZ3ULHPH/h1M1ubTsQpEXFOBSHPEOUCNxOm?=
 =?us-ascii?Q?d7EjUIMrRjtmioXNTHAKxs9XJksiAlVgzomrSaskYaUvDxqc+MgLeHO8GnaP?=
 =?us-ascii?Q?ez304Dely1JXv06AdaKI0hkZ46S7oR98X82IPu+JbeZpV9mkLnd2KaVCOBex?=
 =?us-ascii?Q?vqoTcIbA7p1yrVEDWOFsdsCfFxaq55jMVF6qSWRyIsz+JKZZhuLL/ZygBarp?=
 =?us-ascii?Q?texhIik=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jDVQPrxCCNzLs8vERgXp1UmNqr2ankeIiN054PA2udRUDcSgUjm5zc9z9act?=
 =?us-ascii?Q?C/TDLMUGFsuIVjdwipXEp58aHCYQoVvzpgrO//kBsP42I78/DIBKWgGik4SD?=
 =?us-ascii?Q?zH/48ZMbGL/PijwkkMEJRdHihC3FXNUZJC9kp5qP7GuQDHom+7u4Pn8ukv0M?=
 =?us-ascii?Q?1EJtHTAHvz6p7+80xTGBgbrlYrNUzoXE6wXZZGLjbQtforTBolimVecU13kw?=
 =?us-ascii?Q?FKqvdqUMllQGIxahihNLNhfgm3FxTVny4iNq3YQeSV4Z1kk0lvFE6dv84xip?=
 =?us-ascii?Q?Y/qJ48xkzuuuIsMl1bFDhyyrenPnsfWGw37WNBrgBoPbIY/AQOtl+AWQxTUy?=
 =?us-ascii?Q?K6J24WTI5IxzZV06wVClmPma7gWH8E3XUIppsZsH99xZ+G/PRVcoiF13zzEK?=
 =?us-ascii?Q?00lUIeINMv0y3tLVDqsQ/LMMjz0XS5+zlZ86T2QkVKwpMpkvXGTy3OZ5HDcf?=
 =?us-ascii?Q?NKvJkB0vHV8a4WwBF919HW7cqQnS/Z1qzWFp6w9PHNfkLfhpor4mRPJyHr2o?=
 =?us-ascii?Q?wdHuZDTd4eVXqTQs95MquLJCPFsNMtkG3wkBwj0nL8Y9+rg7Yt/F+nlNKx1N?=
 =?us-ascii?Q?e5lhzzrW8a/LSRndagiO9vWxQCg0Ax6CLen+WoZxI2yfsQffDVSf5mH3F7tw?=
 =?us-ascii?Q?urNnsUOfKIYTRB3SBbVjHl1qdlAwbgFNrNX70tuFSTRJS7GqqYAVUyH3DSBx?=
 =?us-ascii?Q?cgR//xgVGerJkIQzW/9ePjsTXJyiW5Ekuy4H9JT9M7fGVTQ2XlEdqpGYcZDy?=
 =?us-ascii?Q?3rbH3+DxZGS4YDaRNeAA0W0YWhzcNRVWm6aDQpQeZccTzCFwDkkLRCPchIrU?=
 =?us-ascii?Q?i28ScmkWj9IciGMMZsESeL/fMG8DGlNY6T4cPK0Yjm3o8XW0hz13eoHNxBKT?=
 =?us-ascii?Q?uKYoxtlKme+UOOQBLeAQ+vyMsULligZcGENZwZeWqDeVYzzRVoZPlgd9XD8m?=
 =?us-ascii?Q?8ZR43ydCWkKXnw3qRdVLgvZbnxij3QCMoQwnvk4DKnKjka5B3aLsv8HUG4QB?=
 =?us-ascii?Q?Kqb8kSEE8NRL8PenBE2tmNzVBokKxJmPS6jRIfmUZY7uNc9k2tmLtajyScmJ?=
 =?us-ascii?Q?8KCDvwzCIA3S9mucETTs70wCjMJrtHdI6Yu90WH9rxA/gu4Otme/Z4Gyu7Je?=
 =?us-ascii?Q?T+O/O0g7eHwp4wzYQitzmFYSqUxY6XVXIHwd6hivx9oF8ykwZLcGhC+ok/Ik?=
 =?us-ascii?Q?973u3aGTTXYk532wFH1hETZByyoCICdOwqGToeCAuPfIAj439HPANo/kJL97?=
 =?us-ascii?Q?JlSNBsMR9/V8yT3PL8TYeEDA3aOWQZipq/1d/lU27sFr15pDQaELmOZWKfDM?=
 =?us-ascii?Q?pnu0xFU1QHujxlQ6/XeOf1fOUsEbdyABro8Ac8XMPZrEPBJTRSWsvx3bsYdP?=
 =?us-ascii?Q?Ka+4xun8v6DxlOA0D6tUz9Is5z95Ra78oGevXwPyOZyULOeM9dIjLZXJBu9j?=
 =?us-ascii?Q?XAd3xHooD0XMZOt8S1CvBZ/Uwm9U+BEYo967+ZyswhAe72d8RMra/J7K4bIP?=
 =?us-ascii?Q?Opz1XKaCxxM2wZfP31BbCdcWU5FepbA/2+R8f6jjp6dI6msaP+hQ0LsYVptw?=
 =?us-ascii?Q?EZxyaR9ERAKNIlKVmMWlXgDvuX7M7cvhkEkmly/V?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bc0bcb-648b-4661-1b93-08dc9679790e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 07:19:24.7506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXEjKk8xC7qsaqcPmHDn6U9E5GtzFnh2I8+FQJE3DE6BriKjMqLV7sQqHVD/fAgcZwIXAXioig0Uz7Vd9iB8Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6685


Dan Williams <dan.j.williams@intel.com> writes:

> Alistair Popple wrote:
>> FS DAX pages have always maintained their own page reference counts
>> without following the normal rules for page reference counting. In
>> particular pages are considered free when the refcount hits one rather
>> than zero and refcounts are not added when mapping the page.
>> 
>> Tracking this requires special PTE bits (PTE_DEVMAP) and a secondary
>> mechanism for allowing GUP to hold references on the page (see
>> get_dev_pagemap). However there doesn't seem to be any reason why FS
>> DAX pages need their own reference counting scheme.
>> 
>> By treating the refcounts on these pages the same way as normal pages
>> we can remove a lot of special checks. In particular pXd_trans_huge()
>> becomes the same as pXd_leaf(), although I haven't made that change
>> here. It also frees up a valuable SW define PTE bit on architectures
>> that have devmap PTE bits defined.
>> 
>> It also almost certainly allows further clean-up of the devmap managed
>> functions, but I have left that as a future improvment.
>> 
>> This is an update to the original RFC rebased onto v6.10-rc5. Unlike
>> the original RFC it passes the same number of ndctl test suite
>> (https://github.com/pmem/ndctl) tests as my current development
>> environment does without these patches.
>
> Are you seeing the 'mmap.sh' test fail even without these patches?

No. But I also don't see it failing with these patches :)

For reference this is what I see on my test machine with or without:

[1/70] Generating version.h with a custom command
 1/13 ndctl:dax / daxdev-errors.sh          SKIP             0.06s   exit status 77
 2/13 ndctl:dax / multi-dax.sh              SKIP             0.05s   exit status 77
 3/13 ndctl:dax / sub-section.sh            SKIP             0.14s   exit status 77
 4/13 ndctl:dax / dax-dev                   OK               0.02s
 5/13 ndctl:dax / dax-ext4.sh               OK              12.97s
 6/13 ndctl:dax / dax-xfs.sh                OK              12.44s
 7/13 ndctl:dax / device-dax                OK              13.40s
 8/13 ndctl:dax / revoke-devmem             FAIL             0.31s   (exit status 250 or signal 122 SIGinvalid)
>>> TEST_PATH=/home/apopple/ndctl/build/test LD_LIBRARY_PATH=/home/apopple/ndctl/build/cxl/lib:/home/apopple/ndctl/build/daxctl/lib:/home/apopple/ndctl/build/ndctl/lib NDCTL=/home/apopple/ndctl/build/ndctl/ndctl MALLOC_PERTURB_=227 DATA_PATH=/home/apopple/ndctl/test DAXCTL=/home/apopple/ndctl/build/daxctl/daxctl /home/apopple/ndctl/build/test/revoke_devmem

 9/13 ndctl:dax / device-dax-fio.sh         OK              32.43s
10/13 ndctl:dax / daxctl-devices.sh         SKIP             0.07s   exit status 77
11/13 ndctl:dax / daxctl-create.sh          SKIP             0.04s   exit status 77
12/13 ndctl:dax / dm.sh                     FAIL             0.08s   exit status 1
>>> MALLOC_PERTURB_=209 TEST_PATH=/home/apopple/ndctl/build/test LD_LIBRARY_PATH=/home/apopple/ndctl/build/cxl/lib:/home/apopple/ndctl/build/daxctl/lib:/home/apopple/ndctl/build/ndctl/lib NDCTL=/home/apopple/ndctl/build/ndctl/ndctl DATA_PATH=/home/apopple/ndctl/test DAXCTL=/home/apopple/ndctl/build/daxctl/daxctl /home/apopple/ndctl/test/dm.sh

13/13 ndctl:dax / mmap.sh                   OK             107.57s

Ok:                 6   
Expected Fail:      0   
Fail:               2   
Unexpected Pass:    0   
Skipped:            5   
Timeout:            0   

I have been using QEMU for my testing. Maybe I missed some condition in
the unmap path though so will take another look.

> I see this with the patches, will try without in the morning.
>
>  EXT4-fs (pmem0): unmounting filesystem 26ea1463-343a-464f-9f16-91cb176dbdc7.
>  XFS (pmem0): Mounting V5 Filesystem 554953fd-c9f4-460f-bc37-f43979986b68
>  XFS (pmem0): Ending clean mount
>  Oops: general protection fault, probably for non-canonical address 0xdead000000000518: 00
> T SMP PTI
>  CPU: 15 PID: 1295 Comm: mmap Tainted: G           OE    N 6.10.0-rc5+ #261
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20240524-3.fc40 05/24/2024
>  RIP: 0010:folio_mark_dirty+0x25/0x60
>  Code: 90 90 90 90 90 0f 1f 44 00 00 53 48 89 fb e8 22 18 02 00 48 85 c0 74 26 48 89 c7 48
> 0 02 00 74 05 f0 80 63 02 fd <48> 8b 87 18 01 00 00 48 89 de 5b 48 8b 40 18 e9 77 90 c0 00
>  RSP: 0018:ffffb073022f7b08 EFLAGS: 00010246
>  RAX: 004ffff800002000 RBX: ffffd0d005000300 RCX: 0400000000000040
>  RDX: 0000000000000000 RSI: 00007f4006200000 RDI: dead000000000400
>  RBP: 0000000000000000 R08: ffff9a4b04504a30 R09: 000fffffffffffff
>  R10: ffffd0d005000300 R11: 0000000000000000 R12: 00007f4006200000
>  R13: ffff9a4b7c96c000 R14: ffff9a4b7daba440 R15: ffffb073022f7cb0
>  FS:  00007f4046351740(0000) GS:ffff9a4d77780000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007f40461ff000 CR3: 000000027aea6000 CR4: 00000000000006f0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   <TASK>
>   ? __die_body.cold+0x19/0x26
>   ? die_addr+0x38/0x60
>   ? exc_general_protection+0x143/0x420
>   ? asm_exc_general_protection+0x22/0x30
>   ? folio_mark_dirty+0x25/0x60
>   ? folio_mark_dirty+0xe/0x60
>   unmap_page_range+0xea5/0x1550
>   unmap_vmas+0xf8/0x1e0
>   unmap_region.constprop.0+0xd7/0x150
>   ? lock_is_held_type+0xd5/0x130
>   do_vmi_align_munmap.isra.0+0x3f4/0x580
>   ? mas_walk+0x101/0x1b0
>   __vm_munmap+0xa6/0x170
>   __x64_sys_munmap+0x17/0x20
>   do_syscall_64+0x75/0x190
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> $ faddr2line vmlinux folio_mark_dirty+0x25
> folio_mark_dirty+0x25/0x58:
> folio_mark_dirty at mm/page-writeback.c:2860


