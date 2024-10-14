Return-Path: <linux-fsdevel+bounces-31851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AA099C1E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 09:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629372819C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 07:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A03C14D452;
	Mon, 14 Oct 2024 07:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nShLYgG6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C2D148FF3;
	Mon, 14 Oct 2024 07:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892022; cv=fail; b=afyAK8b6B+N/1Ld8c1WWe0LZrKkny3mX5e+3dvidvyh0tdU+KABuEvZuRmnUkDLQ8kFUt6LGK58NxuQwDfE1VnGxCPRQC7fS0KyhR18MwkL3juiLJyOgiw4Fwav/qWs0qSYhDGpPFFkIiz1zw9BsWFdrcgMaYFVs80V2Vy+cC5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892022; c=relaxed/simple;
	bh=NmCvruAVE/PiTTOUuNYwaW1yd5V8DfKZv4kDdWwUqCM=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=cx/ESWuhSsGYmSa8J/v59TK61SmZHP1qpCSm97KK0ccXt9c6tSEH6cgn5pm1wK6K7I99U/TurJzgCFZgxteyHuWGaE+QWLhWQnyE+BiOS1Yk7YjaP6s0LqZsO0rvVH027n9D1PBdE1v/Beb3mIYpNggLJvUrh3GB2DqoEOUo5bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nShLYgG6; arc=fail smtp.client-ip=40.107.96.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWz+/nIdJHQwHzWzeFrkzNve7fFYjrT2P9I0mxvaurgYFUV3rwXFQDOSnOpqQXwkKg5eQggp84wjJXBfyu8Iah1ZpG+xwe2SxPA3mUiL+RcDW6uQieuXlHuDfAOqP4RPcaW2gc072/ANedGIkwKRLEiFhvOEkPpjhJyXZy18FBgmW0cSo1r+Y9VnZ4nKPlnUezbtUbIAy1KCOBB3TikIuxmNsNPNDYZoP7hxLHFEL1luC9Ae8dnxX0h7y41eZRg4swNT8DHS0eW2BIyIuOKnYlku+arslphqlh7npOaGNtKiAs2iaQKw3PgfWzt3xHpttIcfeHQHVFUVxAu8d2jIAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fG428I2IEAHjeIBi4w4pYsub/aNR1xBe4gWd9nPAWYw=;
 b=oP7xZ3NIdhi4TBzBQ2hgfaGLxRNtWQMnPfbXgINGL4ykWILZXkQm3QwzswlwfoUg3ST7bfpWhp/XIjs9vGXwdeJwdeYWAFApsjWC/djOokbr3vDjiVbfeOVsNAUXAIx6vq/8BR/59XiZsiL6uz6umgxPhGQ0ufPUTmY5msS3lDaUtDIX4/Bxp8Nq9ENG5W/ip7xDtGyjH13g9Fx8KJotxYupF2hY928qH6vAs+/9iLGLSvf8sas/gKco+Dqz6KoCpq43OwPF1RHXhQqG1vQEttlnVwkbF2ardE0YV6pUHht3ospUDMNV1skt9eYPr9JKp2h5/T8FkStd/QFtGoemMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG428I2IEAHjeIBi4w4pYsub/aNR1xBe4gWd9nPAWYw=;
 b=nShLYgG6QcH3h+DXw2skGXcINEVaE10KsfwDcBXq5l0cswcAaqlRWtMR5qVGfTGsFLxjBLEAMhoD5jYCqWbW8Mjiyz0potcm1QCfg1Sy7ODvjtrcl3tjtwPe0Xe/KoheGrzK8A2FEpRDmRKiHtELQRfIul7QJrX9aSUd4Alygx+mo4azMCpPef63qxtHRnB1CAbgTx2TKybuSYREAHjsQu8g2Yavhk5Zg1w2oBIOkqivFy0t5eHeQlod4ZojlKXJG+YKNuAxlbB+CVCUpbosQ/CgMSlvEV8PSWOdYZpL2TMSFRHTflmBp3nn2wxuoZ1ZY8ZSoFhAEZyFYv3yeaDfxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SN7PR12MB6838.namprd12.prod.outlook.com (2603:10b6:806:266::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 07:46:55 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 07:46:55 +0000
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
 <64f1664980bed3da01b771afdfc4056825b61277.1725941415.git-series.apopple@nvidia.com>
 <66f65ba5be661_964f229415@dwillia2-xfh.jf.intel.com.notmuch>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-mm@kvack.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
 logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca,
 catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
 npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com,
 willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
 linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 david@fromorbit.com
Subject: Re: [PATCH 09/12] mm: Update vm_normal_page() callers to accept FS
 DAX pages
Date: Mon, 14 Oct 2024 18:16:15 +1100
In-reply-to: <66f65ba5be661_964f229415@dwillia2-xfh.jf.intel.com.notmuch>
Message-ID: <87y12rm8id.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0188.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:249::25) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SN7PR12MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eb60bc8-70ed-417f-984e-08dcec245f70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ov/MQa110yAAxbSjJsIxOvE9JvCEhcF/AT4n5LK/IKC19eY+/CVchSNt5RV0?=
 =?us-ascii?Q?Wl9zTcpgtPwHhj2u81ZyZYbo0mcCj3ECvEIg5mGqj3bykOCXfpBzZfJEeNyc?=
 =?us-ascii?Q?y2jbTjt7fwez5K8zT2wsQvXTvrhAH1PasvAVx+Yp60rDkbHGYZjEdM/ZU0qK?=
 =?us-ascii?Q?tSyuxMON4j4lwmuPcF/dqeB/ugjrPXgbOhrw7PfhRiXe0ZC+mBNyTl77tqPJ?=
 =?us-ascii?Q?orLFmKtNQKoCLX76w3KE9IMRgQqTZNfzWgfCUX0PQHp6YUsBB+WxjJnVtif9?=
 =?us-ascii?Q?qKzNFTG2gSPS/OywXw7pSaMYNOazMSIsKRzGpZgBlHedK2WnyW4jfZJBAWps?=
 =?us-ascii?Q?yEDMDfLHa1T5kxs0x5lS0SxjepcYFNpM+0pJNfnzCUwz95ZMQEuBFjUeR3We?=
 =?us-ascii?Q?195Irdz2tsKE5bWE9Ml1LXlqmZeElJg6pKu3RurzmN13x9WRyVxbIeOA14NG?=
 =?us-ascii?Q?S9P5kEKSErI2XJOKbipbpoJrdTR484hvDMIQRhndLMFCq8mkLVo0cs4AoiLU?=
 =?us-ascii?Q?eLrUvi/fYwNl2XN65PGOCn54KAQjnGrPp3RyQQ6IxIYET7SbdYsUyRxsk9rR?=
 =?us-ascii?Q?LVJp9gFV9uwznQnmhoXcedU4A2ZbQNgoMASRG0FTpirjirLgXaiY7jkMeGmy?=
 =?us-ascii?Q?P+3SubtKn43MOBc3uHCj7E0kuVL3smT3Oum69Xmr+HKypNQHHzIf/UTyp0mA?=
 =?us-ascii?Q?mHS98vqnzEkzlyr6/UYOa37disSusZN9IvniDN3qWaTioIPEK5do4pT8fT9h?=
 =?us-ascii?Q?nikJbU1qBWlHXB5YdjCKcpCcTT5h9+2EcGBqkM7Md9wZ+tAfo31a1S4MZzvQ?=
 =?us-ascii?Q?FWKIHviHHFeaZVbYZNiBamZEc3dLS9CoPNHfyw5AU/XRA4ZVeFz8U1Z4sivH?=
 =?us-ascii?Q?fXhHX6FGu560g1Yr+0HB/VONOwcN77JpmgoOVkLadKOlClC4IIDP8su/KVEG?=
 =?us-ascii?Q?ehoKFHg0L8ZQwt6h1PPpf+W9aa78mgfFwRX+TEF4x09C+M9PZOePZA4vveUH?=
 =?us-ascii?Q?NWnCnVsBTV8a/59waRcZ6WftKAHoYHSYNe/bUPFalazRnNC53qVJCOd/lWp9?=
 =?us-ascii?Q?PCAARMGqNpdMH75lASWiTR/2BguMeLuo+Pk0aD6tJ1RzCNEDzrNEXu3omeGh?=
 =?us-ascii?Q?zLLFFxXFcBnx+aw9nErarqPmb3OdrWvLiL5wHGlV4xOMKxZlDS5VBdXXCjYq?=
 =?us-ascii?Q?ZjtlMDhr8qI0cynejSziY1PHguUjmFArGL9rStwritlbS87QaP4jg9o07NIt?=
 =?us-ascii?Q?ceurCiVir5+3N3VDkjhaWlmTVtI6voBOAu0PR9bEjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gKxYob0HCFwdeU2sQXDKVBCEbMHOJjua/GZr+Qk6UsHVToBGTdpTrsxOZPLT?=
 =?us-ascii?Q?AjlHPGUeaR9qt0wz0TVKoh16Uk+UPgQvX7leXbrto0qBP39xWoKKWgxDPuEX?=
 =?us-ascii?Q?uZ0DB+ZdBhNbxSnBWc10s1OZoMSOmINum2vwNy94cIySRUzFi5CUQvI+K7pf?=
 =?us-ascii?Q?jSA08Rc/4Mn11twMlYGMniGThhRYPuP/5z1f0H4KZczXb26xz0jASL+xemui?=
 =?us-ascii?Q?vbsxyHopVUQ/OsrQ4+C8zPCDTUElQsJGtjA/c/66g5xid3/pTeqbsDKqhINy?=
 =?us-ascii?Q?411Me8arV4oC6czG2QSDNbhyBuP4LXr44Alve+ELsjtzyBYLoghrsYCgBa+n?=
 =?us-ascii?Q?1pv2YGFkrFfGQg66djHiWlESs0g2M+Q/MJ+qsl1+kauuhEqxme+AvZVvlCXQ?=
 =?us-ascii?Q?vfo4ltRkN3MhOzWn/+d9XiZK8/NyNE+UeeMJeM7tcFEvBWc5VPfECiE1q8np?=
 =?us-ascii?Q?0yX+s709FuJiXhGRSpFm+SadYWAlh/BbE6WyZeyXpaNxsNJkR4WUpz2tAbxj?=
 =?us-ascii?Q?RgKsmdJ9PW2zhOSO8zVGY9iTEASwcyOqxksQCF2fD+/Sxk+JwmkdwUJziy5I?=
 =?us-ascii?Q?yi4qGU5dDE7W46iSMeiVolxqthqcxc2telDteLVBDSCTRxRiZhPEb/+2nzI3?=
 =?us-ascii?Q?vtlwC9F5NJp3MUSEKaNDsvZWrnJu3wmi9vP8IoPznYkh5pNjholmUKRLSuI3?=
 =?us-ascii?Q?ntWNHowTb3gVMOMecfxWIwKpdISQN6tWtVYKItp6T1t6CL0uetdUgCRsNzry?=
 =?us-ascii?Q?f+I43ff+lmHK1B003p9L/+XSVuHIxnYruoZq8khLdpMGPI8eEIL22Z3BaSE6?=
 =?us-ascii?Q?aibQfLbzmjvi4Z27H8KEe6tnStGU2qJhziawAjxKtah7Y0kfD17FlmCPpJCK?=
 =?us-ascii?Q?RD2pSu8NGd9zj8tMJyES2jSV5DISQh6O120EeYaZKkcZUXKONCRCdo5vugy5?=
 =?us-ascii?Q?K7DQ/d4XkKaCI+bTLyDDFg0a79rhek4VNcFquvuW16lXKswovdpaU0DxEwhq?=
 =?us-ascii?Q?eb4/k4bHXGEBLYcMN1YS1C+HsKwyRxnbxD9a3lHKwlSSf/efPWmJHvV0tGw3?=
 =?us-ascii?Q?ez5iYiDUDRqJ2LNXIpl/XJq06xIkyNRvUm4kJS6ZCR3ixhfCmAEBK9imwS+L?=
 =?us-ascii?Q?yS2/6/byTB1afgWoTBbSJMtqwrN3ZY5ffNguXq5r8p7AfdOjMm4RUNTwY8uH?=
 =?us-ascii?Q?429yMlAbfrfFjG/SHjpYmL7AjrfxdzHQhR67i1CXNGH1SK4RoOeiejttYs2C?=
 =?us-ascii?Q?VZfdEfzIN5ON2Zwum52ArNuc1j1kac6x2lqgnLu98f476AnRCPSKvwNaimQx?=
 =?us-ascii?Q?MjnLtqFFeaHTV2Kevtpg72Ghi367v5iPQc7bMfteAaGeup5sGpulg4tcTE+p?=
 =?us-ascii?Q?mzvnDsErT10PS/6j66fF3XGvn0bcIW5UsykX/b/5sfFGPKpl+zNomwwm9l40?=
 =?us-ascii?Q?IsZIMSF/rr4id11wASwKKPvfu1LS3X/nIQZyS/uMbfKlksdN/IgRQv/Wkj7b?=
 =?us-ascii?Q?9Bi6zhKm9udGBmr+XMdzVEFbLmz876NTkr2CRji/dOA1VeCdY6+sS4UJtWxw?=
 =?us-ascii?Q?n8O1Ddn6oZh5oVKzRTZdxsvrh8U+r1lwfJyZJSOT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb60bc8-70ed-417f-984e-08dcec245f70
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 07:46:55.0375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSb+pDjmX6fDAwnQdPfY4UUrgxspuAvbwRm/dHo4iGXniNcyYtJ5WoasH1xAvEnQmilcL/uUrkMg8ilN2HtEPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6838


Dan Williams <dan.j.williams@intel.com> writes:

> Alistair Popple wrote:
>> Currently if a PTE points to a FS DAX page vm_normal_page() will
>> return NULL as these have their own special refcounting scheme. A
>> future change will allow FS DAX pages to be refcounted the same as any
>> other normal page.
>> 
>> Therefore vm_normal_page() will start returning FS DAX pages. To avoid
>> any change in behaviour callers that don't expect FS DAX pages will
>> need to explicitly check for this. As vm_normal_page() can already
>> return ZONE_DEVICE pages most callers already include a check for any
>> ZONE_DEVICE page.
>> 
>> However some callers don't, so add explicit checks where required.
>
> I would expect justification for each of these conversions, and
> hopefully with fsdax returning fully formed folios there is less need to
> sprinkle these checks around.
>
> At a minimum I think this patch needs to be broken up by file touched.

Good idea.

>> Signed-off-by: Alistair Popple <apopple@nvidia.com>
>> ---
>>  arch/x86/mm/pat/memtype.c |  4 +++-
>>  fs/proc/task_mmu.c        | 16 ++++++++++++----
>>  mm/memcontrol-v1.c        |  2 +-
>>  3 files changed, 16 insertions(+), 6 deletions(-)
>> 
>> diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
>> index 1fa0bf6..eb84593 100644
>> --- a/arch/x86/mm/pat/memtype.c
>> +++ b/arch/x86/mm/pat/memtype.c
>> @@ -951,6 +951,7 @@ static void free_pfn_range(u64 paddr, unsigned long size)
>>  static int follow_phys(struct vm_area_struct *vma, unsigned long *prot,
>>  		resource_size_t *phys)
>>  {
>> +	struct folio *folio;
>>  	pte_t *ptep, pte;
>>  	spinlock_t *ptl;
>>  
>> @@ -960,7 +961,8 @@ static int follow_phys(struct vm_area_struct *vma, unsigned long *prot,
>>  	pte = ptep_get(ptep);
>>  
>>  	/* Never return PFNs of anon folios in COW mappings. */
>> -	if (vm_normal_folio(vma, vma->vm_start, pte)) {
>> +	folio = vm_normal_folio(vma, vma->vm_start, pte);
>> +	if (folio || (folio && !folio_is_device_dax(folio))) {
>
> ...for example, I do not immediately see why follow_phys() would need to
> be careful with fsdax pages?

The intent was to maintain the original behaviour as much as
possible, partly to reduce the chance of unintended bugs/consequences
and partly to maintain my sanity by not having to dig too deeply into
all the callers.

I see I got this a little bit wrong though - it only filters FSDAX pages
and not device DAX (my intent was to filter both).

> ...but I do see why copy_page_range() (which calls follow_phys() through
> track_pfn_copy()) might care. It just turns out that vma_needs_copy(),
> afaics, bypasses dax MAP_SHARED mappings.
>
> So this touch of memtype.c looks like it can be dropped.

Ok. Although it feels safer to leave it (along with a check for device
DAX). Someone can always remove it in future if they really do want DAX
pages but this is all x86 specific so will take your guidance here.

>>  		pte_unmap_unlock(ptep, ptl);
>>  		return -EINVAL;
>>  	}
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index 5f171ad..456b010 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -816,6 +816,8 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
>>  
>>  	if (pte_present(ptent)) {
>>  		page = vm_normal_page(vma, addr, ptent);
>> +		if (page && is_device_dax_page(page))
>> +			page = NULL;
>>  		young = pte_young(ptent);
>>  		dirty = pte_dirty(ptent);
>>  		present = true;
>> @@ -864,6 +866,8 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
>>  
>>  	if (pmd_present(*pmd)) {
>>  		page = vm_normal_page_pmd(vma, addr, *pmd);
>> +		if (page && is_device_dax_page(page))
>> +			page = NULL;
>>  		present = true;
>>  	} else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))) {
>>  		swp_entry_t entry = pmd_to_swp_entry(*pmd);
>
> The above can be replaced with a catch like
>
>    if (folio_test_device(folio))
> 	return;
>
> ...in smaps_account() since ZONE_DEVICE pages are not suitable to
> account as they do not reflect any memory pressure on the system memory
> pool.

Sounds good.

>> @@ -1385,7 +1389,7 @@ static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr,
>>  	if (likely(!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags)))
>>  		return false;
>>  	folio = vm_normal_folio(vma, addr, pte);
>> -	if (!folio)
>> +	if (!folio || folio_is_device_dax(folio))
>>  		return false;
>>  	return folio_maybe_dma_pinned(folio);
>
> The whole point of ZONE_DEVICE is to account for DMA so I see no reason
> for pte_is_pinned() to special case dax. The caller of pte_is_pinned()
> is doing it for soft_dirty reasons, and I believe soft_dirty is already
> disabled for vma_is_dax(). I assume MEMORY_DEVICE_PRIVATE also does not
> support soft-dirty, so I expect all ZONE_DEVICE already opt-out of this.

Actually soft-dirty is theoretically supported on DEVICE_PRIVATE pages
in the sense that the soft-dirty bits are copied around. Whether or not
it actually works is a different question though, I've certainly never
tried it.

Again, was just trying to maintain previous behaviour but can drop this
check.

>>  }
>> @@ -1710,6 +1714,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
>>  			frame = pte_pfn(pte);
>>  		flags |= PM_PRESENT;
>>  		page = vm_normal_page(vma, addr, pte);
>> +		if (page && is_device_dax_page(page))
>> +			page = NULL;
>>  		if (pte_soft_dirty(pte))
>>  			flags |= PM_SOFT_DIRTY;
>>  		if (pte_uffd_wp(pte))
>> @@ -2096,7 +2102,8 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
>>  
>>  		if (p->masks_of_interest & PAGE_IS_FILE) {
>>  			page = vm_normal_page(vma, addr, pte);
>> -			if (page && !PageAnon(page))
>> +			if (page && !PageAnon(page) &&
>> +			    !is_device_dax_page(page))
>>  				categories |= PAGE_IS_FILE;
>>  		}
>>  
>> @@ -2158,7 +2165,8 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
>>  
>>  		if (p->masks_of_interest & PAGE_IS_FILE) {
>>  			page = vm_normal_page_pmd(vma, addr, pmd);
>> -			if (page && !PageAnon(page))
>> +			if (page && !PageAnon(page) &&
>> +			    !is_device_dax_page(page))
>>  				categories |= PAGE_IS_FILE;
>>  		}
>>  
>> @@ -2919,7 +2927,7 @@ static struct page *can_gather_numa_stats_pmd(pmd_t pmd,
>>  		return NULL;
>>  
>>  	page = vm_normal_page_pmd(vma, addr, pmd);
>> -	if (!page)
>> +	if (!page || is_device_dax_page(page))
>>  		return NULL;
>
> I am not immediately seeing a reason to block pagemap_read() from
> interrogating dax-backed virtual mappings. I think these protections can
> be dropped.

Ok.

>>  
>>  	if (PageReserved(page))
>> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
>> index b37c0d8..e16053c 100644
>> --- a/mm/memcontrol-v1.c
>> +++ b/mm/memcontrol-v1.c
>> @@ -667,7 +667,7 @@ static struct page *mc_handle_present_pte(struct vm_area_struct *vma,
>>  {
>>  	struct page *page = vm_normal_page(vma, addr, ptent);
>>  
>> -	if (!page)
>> +	if (!page || is_device_dax_page(page))
>>  		return NULL;
>>  	if (PageAnon(page)) {
>>  		if (!(mc.flags & MOVE_ANON))
>
> I think this better handled with something like this to disable all
> memcg accounting for ZONE_DEVICE pages:

Ok, thanks for the review.

> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index b37c0d870816..cfc43e8c59fe 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -940,8 +940,7 @@ static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
>                  */
>                 if (folio_memcg(folio) == mc.from) {
>                         ret = MC_TARGET_PAGE;
> -                       if (folio_is_device_private(folio) ||
> -                           folio_is_device_coherent(folio))
> +                       if (folio_is_device(folio))
>                                 ret = MC_TARGET_DEVICE;
>                         if (target)
>                                 target->folio = folio;


