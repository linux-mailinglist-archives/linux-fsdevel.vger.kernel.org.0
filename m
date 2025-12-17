Return-Path: <linux-fsdevel+bounces-71586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5F5CC9CDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 00:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C387E3036C9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 23:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8672ED843;
	Wed, 17 Dec 2025 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dADVea3+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011017.outbound.protection.outlook.com [40.93.194.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F1288AD;
	Wed, 17 Dec 2025 23:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766014255; cv=fail; b=Q4HOSzd7M/GdmvNIqe84fW9IGy/FEo57qCCFK9U78tbynsepspEUSMFGw2G/7C8EyZ0U3PdHmP4vH2GtSCR6xs+1a1cYiqtShd6V9dl/BfRlK2bU0H9WF7okarJxhqIDVA/XYqiG+JiwgKwgF2ZMUf5C0SQf6LNoGqWhfahaNVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766014255; c=relaxed/simple;
	bh=pMZd/d7Fv+pkxlh2B6LEQGxYUZxqkWImHsN6t1mGbNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F8nM0smM0swkFNIlIIcgOPohyvg9y3la0nl694kmpuPm9ONTEMw3SYTbhLZBMXQMJzoUZR0nc8fih8MT47WL5M3Ci/lvy5ZE8ChyiEfOPoK9SP+XXkte8TCZqWdcBsoqKqLDzGzGprOHhjCAcZlITO9MtPg9ynwXmvweerAh7QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dADVea3+; arc=fail smtp.client-ip=40.93.194.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=at6OSkj6ZCROkOspCQQH0zNg15rQI/420uBdINk+ETLu4cKsRcr+eqZtaAGUxdf1OqK6Hn1cg2xlGKkxK+fGNuNbDSA/PXwsAQWYFdNoviaYyCwfXrYRZAwCzIwYlqzaLVr9zEgyG5GIiAkY1FPdTye9QGDl7uPapioqKfIKsWZn9KzSCk7POkKG06sGKPFmrphRmosO0VJ/Vw3Q/w9Wv9IkLN1/Eo73m1QjKY64qjHPM6n1QxnSQF7oW0LJ9Zim7+vWa3SXi7SvCAYdik1/Xoniek1v6htBavAhodEv8CCkDSij/R8PuHEZiKukFwgkqwLgdXe1NAjGZYS0ugLbyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmrssDKL/R+xaRje9k1RYObSvrlsAncqFdq0/E4otS4=;
 b=wYwapTsbqlXZRVHIRXYYkFqPHn5ZNrya4CMtyaMUsA278VWqQwIPx8G+lLfjg81nK9eOMzQ7m+qcl8Q/eej/iN+wqWKdvYwF2cX/XotYP/LomU9DCzAwy8XZnTa4DAdfRJgmIAgIok+2wQPnH6UL0bHBxRRlwheIMWxLnm/9/qdhmegkHQHo5qfWIlXTjosn52iNqJM5/u/MPwSKBLQ259vQCeiLfF1ex6gBTWpFH9Cf0L4kzXhi2R8ovdy64jUkiEwo9CInj4m4FxR9/6ue8XMYtqDXzfHdbI4YMxsGL1RAmuJU9ROw3rOp4qT8At6NKKGVMe/mPMa/gPN3pwRcbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmrssDKL/R+xaRje9k1RYObSvrlsAncqFdq0/E4otS4=;
 b=dADVea3+2MbYKMfteoD2Ad1derZIJRjlR4zdgTkKnA28jID8rgF1c3Mx/xn//43OG30RRmMLv2mwSiKT8BglMFhm33qrAZ5fT2aTFfpPWya2eEIzUp161er3kB9uDfLohaBPD4xgHlnI8z5VuQ5Hgj7B4AZmD7CkXy3J3635t0Srdm18h7mijU9IcuP/FbuBnZSa3B2uXGXM42duIktfHa4mSr8HVmYSNfKk7pLumCEEx4IgkWUTCg+n3dbGQKUhqhSVXr0nPr3rWKBUdq+6NgcJIAw4B/1+2SY+8jnHI9HXioR42Z45utXY1bIY1B2TeoSUMR3er7A2xCtcvasN5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SN7PR12MB8130.namprd12.prod.outlook.com (2603:10b6:806:32e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 22:58:07 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 22:58:07 +0000
Date: Thu, 18 Dec 2025 09:58:02 +1100
From: Alistair Popple <apopple@nvidia.com>
To: John Groves <John@groves.net>
Cc: David Hildenbrand <david@kernel.org>, 
	Oscar Salvador <osalvador@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	John Groves <jgroves@micron.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Gregory Price <gourry@gourry.net>, 
	Balbir Singh <bsingharora@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [PATCH] mm/memremap: fix spurious large folio warning for FS-DAX
Message-ID: <74npmrpzagba2bbye7kmwwoguafbpvnkxarprp3txy4wmu6gxp@japia7ysaisi>
References: <20251217211310.98772-1-john@groves.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217211310.98772-1-john@groves.net>
X-ClientProxiedBy: SYYP282CA0009.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::19) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SN7PR12MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: 640c6d32-bf37-4d39-2a78-08de3dbfbe3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hOV+DBeoYdZjimdbgLqxkh0SQrtiZMWxItK13ybIFBpYkQQPIulLVOioXOeH?=
 =?us-ascii?Q?5TZYsPmxVV8vd+xR+spkGnJ/+Yo3N07oPfaOWtTVgDBNguXrlXlftAI3MPU3?=
 =?us-ascii?Q?EU/ZdNljEXFHCVPfewKYB8twiSCLDL8gq/M6tDxkGuqHlD/52T8MGm7w01cU?=
 =?us-ascii?Q?GFHsU7dcABQ6HgnLLX4m17vAXeJeskUn/woXkjbsOyAKAnE9X3evvX8IZQmC?=
 =?us-ascii?Q?1UHawyqzNzY9FF6Ela2DJRPbl1xaWLR3Hni4kkixM3VI4CqhClCsb8j/YCxt?=
 =?us-ascii?Q?gnkK5g+8TabeproH5+UCuunf/bawPoHA7LPb0+UP3NYd9oU3ELQQWdzabHPb?=
 =?us-ascii?Q?JgrctFXizft/fzYQW/ZMdDj71pTyknhfIsT+RowGrEBKBOFvO9M7IxbEY8nc?=
 =?us-ascii?Q?RgFN3ZfN9Sb9e03rEqqwRgjX8FtU60ovqqDgKckkOytqP9NXweZeha2CdM04?=
 =?us-ascii?Q?3+8+MqRxSF5ekR8/y856UwIPe4QeaTD18s7/rOOZpfRG9BHNxV7/NVjMm/Tc?=
 =?us-ascii?Q?SsMiywThEi7hnH2YdCT0VvqeM5v2EVOgqIzp2L7GneYfVrJ+am0QpGNL38Tu?=
 =?us-ascii?Q?nqeTONsSZzfLk9NTdyZtySlIvqj60quwzaQz/ZjKD2QTSID5IDgaFGvsZNmP?=
 =?us-ascii?Q?zE4zo6C7CIsxcJh4cA+dG0/jVzTDdw5sk594kfz8+sxhO0sepRhaCb8flC/c?=
 =?us-ascii?Q?Uyd/HwsQZ+YgegdFJvmcZTIlLnOQ3xPGakpTQzTeCEjYkkkr0t5kRDEkLyO/?=
 =?us-ascii?Q?FH8vYQxKGF+zwlaPmOhiQzD2PpX18aKPVAtI/I8ZhWnduDIjoLGDoXj/FhZR?=
 =?us-ascii?Q?wFDerc2j7+xCcPaG6U+LIKPKNxe2DsVhITfbo7OCKvwbNEKk80Ifz4fT0PHZ?=
 =?us-ascii?Q?q5+uIT8d1Me3ZybHpCSJLD6hbgm4r3e33jLJZjsG+20GRrk70bR8x9RkjIHN?=
 =?us-ascii?Q?xLVJDvpbcjQIdpFXtiv3Q+DPwCffHiq0OLJbuRdKmffn9Xd+/G0wgEe/NTTv?=
 =?us-ascii?Q?N3I10xXBWk3lJEw/9c63afEpWfvPK07YQMIT3e+VMVR50TTNu7mqKP/tgeTy?=
 =?us-ascii?Q?T8F3666vxpDwYH7f49zWh3CwacyZ893LbbrB180jNEsaCPytKRP7VIXrP5nx?=
 =?us-ascii?Q?bisCZ/cxpAsVLeLxl4Mz7a+/JQ2TvDpBzFX7HR56F4BXyY4Frc13M7m0al2R?=
 =?us-ascii?Q?b6Y0g6p5fcmbPuZTDcGykHEIko3WKlvQplqLCjrE/tEmQeYd8BMUYJ5at0vS?=
 =?us-ascii?Q?C559k0BW6k/eRPDQPs5nzt5u+AdFvWzVawy+HvdfcuW9RoR63qR4Fa4pTeUW?=
 =?us-ascii?Q?Wgdk1KKmYtA1LOqyD1Z2Jh090WzsYDJgyOxUpX/WLMWpDudtBPb+R4xL15iR?=
 =?us-ascii?Q?idt0ziHtoSR3SWWKIlamVgEsXvkq9juWgjDGDB21xILElHyFx3lqVormWmpU?=
 =?us-ascii?Q?jZlQ7IWBQHiZudfgnBaekezzSAYbr1+B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lq3XOqdhhIxOWn+Ds3kEpqTuBmqocUYXnq2GLr9vsQNLr0EfZa/jhrQt2uCa?=
 =?us-ascii?Q?JQq+uWSXsmNQJzqY3MdVZ1deGgad8WKuEby4uj0l7JfZg9dVk6F01mIDDf8/?=
 =?us-ascii?Q?aG949DmMExRInYZqEvgJfDkMZ1VAZCRWYfP3WDbjgJG25MVw2Mn3ynsbeIfc?=
 =?us-ascii?Q?kNhdKCgRrMZsWh0PJE+0yPFn3QwI5jU7kBY3qIvTax5vZxgGxoARb4MMUNaX?=
 =?us-ascii?Q?6Sflr2VIaHcl1BbCIIXbvd4KMXNTli2UOZoRN8YFpKAn4cCHisElfhwE/F/I?=
 =?us-ascii?Q?zUiWV+F1iQxiEIl8e9pHZKCzvUrJPcIWtqQ6aX05wu+LjPdFKk0i8t0VfJHk?=
 =?us-ascii?Q?fZa44v/3aR5dSjFNgHfS3QfSDf4AjRDdwPbig3rgLonrwgdDmF6dPn9roeZP?=
 =?us-ascii?Q?5JOoQm3sB5d36q/gkAAJPXEnR1+pfw+R8nto2mAzUmQZUYIsNX8ZHtD87tUp?=
 =?us-ascii?Q?jBg466L+7WKhbfrQIDYvx5P/QFiyH8HDCNpWRqn2u2a/U7Vl13IlJqdvCilr?=
 =?us-ascii?Q?dugtJhbzF+H0K9ia7gcH0jSLffbRluztq6ImcWxncRab5sqOG/cQ65Hc4+LH?=
 =?us-ascii?Q?rwxuceqX+b5TYKnlgCX8vheXbPMiutGnEW7BSdGWi8me2AE7Y6Xs3FnGUpKx?=
 =?us-ascii?Q?ET5UoXNXQU/Lxcb2b4aPQCkDXcbEWxKzBrZ9++X3spiff0FUIjzd63ybrA6h?=
 =?us-ascii?Q?ffNrmRACPL1yV3f1Qq/6jkU7CICTULK8QfUVDj8GQTMy22ywD/e2nrVTj6bq?=
 =?us-ascii?Q?1aS4plfBKAP0u0GejA9gqU4avnAk2FZC6jFi2TDtjJDXm5vUfUiNnPhLCInw?=
 =?us-ascii?Q?LGj0AMMkvMZ7el0hUm7zJgjP26I5/m+qHLFP+Ess1T1ABT4M+DKDO/dtQ3Gr?=
 =?us-ascii?Q?6xllRVPkElV9ydfTB2cQ7XBH3wMZ9s83T/XtATOc98ti6ou8DqLA1zPpsFVr?=
 =?us-ascii?Q?4RJ709CXwc9uhRvj7WSpKgDssIYvqjo4UcKfNfklQ4H+fSKMU5y7MfxEkbVQ?=
 =?us-ascii?Q?/gcYbzT8O+83YNKo4Y0Gt87Tw6pyYY4u3Gq9z939z3g7ypYcxvonWOP27GPN?=
 =?us-ascii?Q?W8D9UqlUReRQBeOA7+wvkV+91VrgbBxuInBtrOeZQ2gjpy1qIqLfjTmZh0+p?=
 =?us-ascii?Q?kmA97KjwlJdAE5YYuAuKavrz20AZ4l3kLqnPxksIT/Wgw4m0fFcXp674Vtkv?=
 =?us-ascii?Q?FZEEqGldyJeWSFQnXw03aQw1wfhf9JYo1MV5OhLsJiBFUbt6Z8/CUeHThGkX?=
 =?us-ascii?Q?NOizvVYUaUU5ee/bJ0GF4Q3zaKWLZV3WCGNSYeyhhkNJUEUg+x7KwWGO/vvC?=
 =?us-ascii?Q?ojZkCI5d/3rLMchX/qVIH4weGbGPAciltf9sTi2CnU1u9Uosbg4fQ7+51jjb?=
 =?us-ascii?Q?7aDo/34iZrpDK8cXiYCVUDJpEn2jEJ304lL/NEKUuLkxBNi236WrB+b1q3Wi?=
 =?us-ascii?Q?+VuMeUhSnI6zcEga8x75aYqe5OtJ/Se97WjuBBrLhCLWnw935UcwUq4kchkZ?=
 =?us-ascii?Q?WJwd1Q37Lea9YAXBgATuETsJGrGJeJV2NoAjKjSczHFrATOQC4tbLEaWHsIQ?=
 =?us-ascii?Q?x6an7o9HS/8yYbtZonQ1j4CeZCoCpa1tbLHGeHet?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 640c6d32-bf37-4d39-2a78-08de3dbfbe3c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 22:58:07.5778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PeZmXMNShQWRUuq4r3CsmH2XsgFtBm86MYcEewbxuqKdkSnT8b6OqlidNzF2Zf+SX8HSIGyj8rEPth03RbOH0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8130

On 2025-12-18 at 08:13 +1100, John Groves <John@Groves.net> wrote...
> From: John Groves <John@Groves.net>
> 
> This patch addresses a warning that I discovered while working on famfs,
> which is an fs-dax file system that virtually always does PMD faults
> (next famfs patch series coming after the holidays).
> 
> However, XFS also does PMD faults in fs-dax mode, and it also triggers
> the warning. It takes some effort to get XFS to do a PMD fault, but
> instructions to reproduce it are below.
> 
> The VM_WARN_ON_ONCE(folio_test_large(folio)) check in
> free_zone_device_folio() incorrectly triggers for MEMORY_DEVICE_FS_DAX
> when PMD (2MB) mappings are used.
> 
> FS-DAX legitimately creates large file-backed folios when handling PMD
> faults. This is a core feature of FS-DAX that provides significant
> performance benefits by mapping 2MB regions directly to persistent
> memory. When these mappings are unmapped, the large folios are freed
> through free_zone_device_folio(), which triggers the spurious warning.

Yep, and I'm pretty sure devdax can also create large folios so we might need
a similar fix there. In fact looking at old vs. new code it seems we only ever
used to have this warning for anon folios, which I think could only ever be true
for DEVICE_PRIVATE or DEVICE_COHERENT folios.

So I suspect the proper fix is to just remove the warning entirely now that they
also support compound sizes.

> The warning was introduced by commit that added support for large zone
> device private folios. However, that commit did not account for FS-DAX
> file-backed folios, which have always supported large (PMD-sized)
> mappings.

Right, one of the nice side-effects (other than delaying fam-fs, sorry! :-/) of
fixing the refcounting was that these started looking like normal large folios.

> The check distinguishes between anonymous folios (which clear
> AnonExclusive flags for each sub-page) and file-backed folios. For
> file-backed folios, it assumes large folios are unexpected - but this
> assumption is incorrect for FS-DAX.
> 
> The fix is to exempt MEMORY_DEVICE_FS_DAX from the large folio warning,
> allowing FS-DAX to continue using PMD mappings without triggering false
> warnings.

As this is a fix you will want a "Fixes:" tag.

> Signed-off-by: John Groves <john@groves.net>
> ---
> === How to reproduce ===
> 
> A reproducer is available at:
> 
>     git clone https://github.com/jagalactic/dax-pmd-test.git
>     cd xfs-dax-test
>     make
>     sudo make test
> 
> This will set up XFS on pmem with 2MB stripe alignment and run a test
> that triggers the warning.
> 
> Alternatively, follow the manual steps below.
> 
> Prerequisites:
>   - Linux kernel with FS-DAX support and CONFIG_DEBUG_VM=y
>   - A pmem device (real or emulated)
>   - An fsdax namespace configured via ndctl as /dev/pmem0
> 
> Manual steps:
> 
> 1. Create an fsdax namespace (if not already present):
>    # ndctl create-namespace -m fsdax -e namespace0.0
> 
> 2. Create XFS with 2MB stripe alignment:
>    # mkfs.xfs -f -d su=2m,sw=1 /dev/pmem0
>    # mount -o dax /dev/pmem0 /mnt/pmem
> 
> 3. Compile and run the reproducer:
>    # gcc -Wall -O2 -o dax_pmd_test dax_pmd_test.c
>    # ./dax_pmd_test /mnt/pmem/testfile
> 
> 4. Check dmesg for the warning:
>    WARNING: mm/memremap.c:431 at free_zone_device_folio+0x.../0x...
> 
> Note: The 2MB stripe alignment (-d su=2m,sw=1) is critical. XFS normally
> allocates blocks at arbitrary offsets, causing PMD faults to fall back
> to PTE faults. The stripe alignment forces 2MB-aligned allocations,
> allowing PMD faults to succeed and exposing this bug.

Thanks for the detailed repro instructions. Not always neccessary but definitely
nice to have.

> === Proposed fix ===
> 
> mm/memremap.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 4c2e0d68eb27..af37c3b4e39b 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -428,7 +428,12 @@ void free_zone_device_folio(struct folio *folio)
>  		for (i = 0; i < nr; i++)
>  			__ClearPageAnonExclusive(folio_page(folio, i));
>  	} else {
> -		VM_WARN_ON_ONCE(folio_test_large(folio));
> +		/*
> +		 * FS_DAX legitimately uses large file-mapped folios for
> +		 * PMD mappings, so only warn for other device types.
> +		 */
> +		VM_WARN_ON_ONCE(pgmap->type != MEMORY_DEVICE_FS_DAX &&
> +				folio_test_large(folio));
>  	}
>  
>  	/*
> 
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> -- 
> 2.49.0
> 

