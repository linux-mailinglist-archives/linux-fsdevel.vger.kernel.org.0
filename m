Return-Path: <linux-fsdevel+bounces-39236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B751DA11A61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 08:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9F711665F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 07:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0AA2309BA;
	Wed, 15 Jan 2025 07:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UR77WKYp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F0122F846;
	Wed, 15 Jan 2025 07:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736924767; cv=fail; b=lyimz5NLTEzQS0HAODnrUapRtXWyCbpn7E3O394QRWWWPUAhi8/9Va0lMplYjp1o4606ekplcCRO/3EUynkcyVuXfXtCbElfSm64bUXrcdFQz1Y9CMV+vgpj+IQJbWYQMxSGmJrqYuDPcaxLYefRaTknFRhfryyYRDKY3UzWpK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736924767; c=relaxed/simple;
	bh=OS9fjnZnEOJyhZm0llLDzowUr7hLVRhFYoSoUSNP7FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FXuyKxtn01oElwJwnl3IMKJ9P2OzDcfQSfbTQ+Mv3pHN3dYHxgm8nRsRGlcP5lNI+K/kjuCcc7kJMmOprinarNvdIax4MvwJw/tV0lzvMDPoAnGjSu70ohtTTehGE9x4lQLW//8hrWIKzBNHcdaq7r74zsplSDQw2g2Em3oCSyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UR77WKYp; arc=fail smtp.client-ip=40.107.96.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AubGugbblEkSg7Mk87r96djliE3s2pclniYIcRSNiUwVOqG74xTodjLVCXh3pasRnwKMx/+UAiAGVKyOKGrRvexT3TBkStXdgu9VS8FS4VV9KPSllyplD2/7KKX2DOz0SW9/Fvg5vRsgMi7mgCib/dVpJw9Lx14jUkk5XF0SaXIdmA3bbAhjFtLC633qGy5OCTI3ZGR1KNPPncPu7SH+OPTXs6APE1Vd0GKpOr4FPM1Cqmpqb666XYHAAWDmoec/mdThyAoiUC3ZajiJ2612aVlIQympsNPjl7w8XaRHzu6HdjD6FOtcZwCiltpxZCeFgTy0iFN2Aq2Lxw8NsTn6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+0bA2XWiKp9sYZutxw2FAC/cbYOb62rWnwvMXHhBPE=;
 b=KLWjynGS8uib/pRr7Ozk6G6e7l1E8iJncjEjmWRrN7PqUuW+tSIuiouV/lZoWFW9EzeWg+BoYmMCADGqYWiB05QlOsRFbbBZ/vVqvIjGrfgFTxVrdJWT0KJSFbjuiLPxxBalQKGVU9bD5JA5HjSw48Gu8t1sV+iJV6HGGfplguyXFDhpNaUbHIccaQ8i3KjoIMHzlHn0Yol0FYYQhSlm/c3+GS8xuKlfPF2xnKhIg9TmNQM0S/7hKlZAzXgwQcwD783XImrH7z1oTsu/wn3EIFWLbrlnjElUDFyI0TNb/5c5HONlxyBQ6lhGYz9rqxoNF9C67jqRPAGICN48yBugag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+0bA2XWiKp9sYZutxw2FAC/cbYOb62rWnwvMXHhBPE=;
 b=UR77WKYp9qHbYnqVi0in8dZ1aSGE0StlDVSc5UKTk80yst3Rxu7py6c3fBE7zBJJmY5P/phVnTPuUdqpkM0+6kAofYRdXOcZgJ1CKlyk8NLIDsNhKOMYstwKYHWGq9LqsXfsNv7h4byMCVIVkYWtpZtb5y8kAcKvxQVWSM35yJ5j+QzJP+rtxYS5vfUGSYvVNYzRLSLIjeMAnQ/CN2B2g0y0uW3t2KmDbSJ7rHQLIA/nOF4AW6VVsopMJT0lsRh1aJDCrMF4TUu6n9xSGsdc8ya3ZdhJ6aeM4V1LXfk34RuUo5e1C3KtypN5Y1DDsGloxA97WWUKrpn1B1f268MV5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.12; Wed, 15 Jan 2025 07:06:01 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 07:06:01 +0000
Date: Wed, 15 Jan 2025 18:05:56 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, alison.schofield@intel.com, lina@asahilina.net, 
	zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com, 
	dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, 
	jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au, 
	npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com, 
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, 
	peterx@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, loongarch@lists.linux.dev
Subject: Re: [PATCH v6 16/26] huge_memory: Add vmf_insert_folio_pmd()
Message-ID: <yl437hg47vr7a7hc467eqag2imceyj5xnnf4hju2f27rvxo4ib@hb27ob6jhq3q>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <02216c30a733ecc84951f9aeb1130cef7497125d.1736488799.git-series.apopple@nvidia.com>
 <31919e6c-0cec-4e3a-a0c6-a80be53d6ccc@redhat.com>
 <67869d3878ee0_20fa294ae@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67869d3878ee0_20fa294ae@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SYBPR01CA0011.ausprd01.prod.outlook.com (2603:10c6:10::23)
 To DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DS0PR12MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb12653-b702-4b2c-e66b-08dd35331196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+DFrh+YCMhomvkMfHXEI8+C+CGHN7pVQO2VToTf8AY1oFKeBcZYVTAaYSDeB?=
 =?us-ascii?Q?39P1a5Hp+W9nbBbh3EsKB4TEi2RWKcu5SCQnj0+FHTtDa7k+5YkNYgosV/9f?=
 =?us-ascii?Q?UFYcQkaZ7t9EgJGqI4lR/hkj7mxAtEphfjXnouRipNeg74U/fh5bFNtL2Nd9?=
 =?us-ascii?Q?oO466zF1voaBxqgfQxQ8g8HHkFB4LOn6h0QsBgY0iSXVuljB+kLDe7eyzULx?=
 =?us-ascii?Q?sABkB62YM23n2GogWdQDzIUI2MFMaVs4Reu9ieVKlIehrAfkxjMfrPVudEuV?=
 =?us-ascii?Q?Dzfi2lwiOriIJQJRBn8OATaJ5Yrj+EBqKNeck4WB3iu9cOIQep33FP8MZJqX?=
 =?us-ascii?Q?Ggdeo+rf1cq5I27rRZLd/mtK401LKIQo+1m5mvpgfk+t2WTBDKG6MFadrMj+?=
 =?us-ascii?Q?MwXefB/8DXW5Mz0i8LOOocksE+vw6eZHtVcUy4xefl0mp6aoVuyuSC9rA7ZT?=
 =?us-ascii?Q?+93zoQwNatGE0Z2UljKsCqFbNJAmOkqV3MTEc4ZDxY+CC3eduQ/8VmCVyTmj?=
 =?us-ascii?Q?hCT/+NTd9V0Ymjis8O/Ojsa3OwgudsHrldqFlQWOFO/zxxmpGd8h+kn/AL0b?=
 =?us-ascii?Q?UUEfEXUTFUc6jy+Sa7HFLZ8uqubz1MDdv9kdcvTn/l/tt4dwAFR6cMKRdajn?=
 =?us-ascii?Q?mi/1f1/guv6s2fE+TE3n+4ZZc1rfY57YNu5K7JJauEQW2y5lPQFr4PM/YQ7W?=
 =?us-ascii?Q?xqbhuK2Z7exgd4wWdtJ+cBriR/d4B7Zw/mH63JyuYJ5dWalzTkg74wqA0rNo?=
 =?us-ascii?Q?CDrHmaQuKAq4BNVPahLmgPyqNsf4TF0KhSduwo1QkE3NElcpyxapOJTeH6mm?=
 =?us-ascii?Q?0FXkF1gFYmUwR4uwCYzM90t1P+8lxlcuLOf6fi6iYoKbWr+H29PuGPIrV6ty?=
 =?us-ascii?Q?mVuVnN93G7Eia6UTYEaekS/OBWZLrsUq6ftLrNHvuDvieCM+V8Vqt0AvsJmL?=
 =?us-ascii?Q?414nVdxRHJXLdwHZhh1VeQiaWE9wHBc05zAGhINw3d97TWTOfXEYPkNqiYn6?=
 =?us-ascii?Q?QMiLedeqaAdvXGAXFUC4oPN0T1jr/RfjBcMVWwcLBRXuHEPWY/k0hxHck4oD?=
 =?us-ascii?Q?eqTMhlS4oC1NqT6Y0J3Y7QiSJV9EWy6LsFpANfi9cRxByKSFfR7ykGKuu3K/?=
 =?us-ascii?Q?Dps0q1NKRl0H18b/hpvmhyjGGfPgwBoQUQCndsYi0OE5IuxypVvNpuQaOaLa?=
 =?us-ascii?Q?xe0nbhJ85pTIsgr2lysVK9Z5qFLKrptzR8RJGNJvQ+XiuR91swp+OFo5OaSP?=
 =?us-ascii?Q?TAA4uJ6+tcAt9+WVMj2CQr0xbYopd0qSbgkxb1LbReFXrezrc5d3Qeeci1Eo?=
 =?us-ascii?Q?ZOoqf2SwubBJkLis95okWVBzwGHpSqZkDBoOlZAdvTrEefg+iJH4AffipXMy?=
 =?us-ascii?Q?P4SQdkI3dYls+kh+bIBco4mlQ8vu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?drg3aIzq82w6cBNLlwUmsdU9CnALO4Ha8PTgzeb5GAOfZjVOrnDPSlGZjOLi?=
 =?us-ascii?Q?rSyWrlUe2O31Tlunq4oTuUy6unOruuFCG08r1GKATSLwG/2nRw1LoMDz/42t?=
 =?us-ascii?Q?OWRxL8Uhsa2J7pbe/ybGjHeyuMa7TGfRh5RyrDfMjBDTLispXVBY0O844i5l?=
 =?us-ascii?Q?Zx2zlz1kXaQu9fNU4NgfSxwfnmcb5iI9Mq++0bX/LuVmAGMWQmqYZUmDmoAO?=
 =?us-ascii?Q?pVOZ8XRow8+tiWYYOQRD2mXlBnwq2sgpNYvuRinRb9Kz7ep+gf3x5eIKoUnL?=
 =?us-ascii?Q?XgACazXee8YM1F9BCDKO4RDJv7JHsBNRFbuxoMRMPn/Aqc9lyGtvzUixv/Ah?=
 =?us-ascii?Q?0NEp2NV2XbH3Jq1+/ZYnznYny77nW3AdNrgkFQPuU0wz2UWYPFXniq7HI/cj?=
 =?us-ascii?Q?xxqswBNSNdfJsvi048NCRH5xhST3BT+JuW+NzmVA1bi3guBj7TMAeJjscu+s?=
 =?us-ascii?Q?P/nARBLJDMezP3lEGVxYLqTVXfQTr/Zkyp8CJZsIaE0vsv7qQZqyoJx3bh4X?=
 =?us-ascii?Q?HQKre23vQodIcs55TAgArVUuQz0uLbXTmpKsEhvlO+FO1DF6fg5adpl0roTK?=
 =?us-ascii?Q?q1OYdmVWjt5rwUsGfi06JuGpY4y91YwnRbogk9XJ6DRcMVaPLDng1vuyBqhW?=
 =?us-ascii?Q?tkwfW1yZDFQHhjEYSmQqFWaO9702+1Oz3tvwDjYLlwOFAZm5AD8rsl9maXnU?=
 =?us-ascii?Q?nwy+vUTJ0eLGulCro33AqMmL0jonugp5ze95PAdnG7ANjOYKRXwIcJ0968U4?=
 =?us-ascii?Q?5LTyOQLTHf6qzSdibVQnbZx7lpJMlqD9ieHSiUYvgW+JeGtHJcAHaUlyJB3Z?=
 =?us-ascii?Q?VT3HwmuP75V+44z5WygOb58WoqI/g7aOUYEFDnExFFzHLq+YK/mY3ElCZTMd?=
 =?us-ascii?Q?VU/dnlTAARvsUqEfYzeNWgjarmRMHpP30DmlwusWeGHf0dvCdH5TqlmCZwgb?=
 =?us-ascii?Q?JNoL+oYnCuIdUvn0VdOLDkO7Wc2UddS74gvfPaCAcii+cwisCE3S27XMr7uA?=
 =?us-ascii?Q?0gfH/VsO1ebHWitswjg1n079KHTvlExvXeXT8XYNYgEJvYtGZUFaOfeR6S7r?=
 =?us-ascii?Q?r9t+MDbEg+lzoiqzbLh9PPA5FLmzSB1ZATqShLsu5d4mIbC8lyE6UmHdj2yt?=
 =?us-ascii?Q?G09xM3i56NIuRpjymJDXpsIiMUD5hm1mUgmff59pFaE0RT/rQ82qJ4fRB25p?=
 =?us-ascii?Q?UQSd3dUj06lxNAFiXxigl4THV4X8ljLMRZkQpKnvAbMr/RU//bryGW8R6zQp?=
 =?us-ascii?Q?FMR1LSd66DcAAniet/WN8VaeV7NIbYRPaEZo5les8rbxki9gQ3CqGWhKNY1t?=
 =?us-ascii?Q?3Gkwp5FHa0D1OUv9WUhGw/rzeWa04SUtVcmvi95VoUCRB7watAICxY91Ua5E?=
 =?us-ascii?Q?NuNdy1m35947uuJNG0W6/iRtQTBcD0W+zXHQkXp1RmMyiJ9zjDt45n9ut9TF?=
 =?us-ascii?Q?gFuQ4NEVNmjtWB0TLF6SLby2qhmLucrsa+IgQDSjupuHRq1QY82kqhLVAveR?=
 =?us-ascii?Q?VIJ6RXl5Y+IeHs8xFa4SpaJsSp8gQSVqCI5tM7Sk0nLubRORJ+m35YnyQsPv?=
 =?us-ascii?Q?ao5MlIj9Jh0Q5l03vVYo4YfVdH6eFVQTM4EQjXpz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb12653-b702-4b2c-e66b-08dd35331196
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 07:06:01.4204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4E35UH4X901Vv0tsrSBcKqlsLM1+ENfhv6voYTadHnkUTOpJAwPvaSPnY9YM5zh2l0U6SC2R9LRGymgjhY6htg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534

On Tue, Jan 14, 2025 at 09:22:00AM -0800, Dan Williams wrote:
> David Hildenbrand wrote:
> > > +vm_fault_t vmf_insert_folio_pmd(struct vm_fault *vmf, struct folio *folio, bool write)
> > > +{
> > > +	struct vm_area_struct *vma = vmf->vma;
> > > +	unsigned long addr = vmf->address & PMD_MASK;
> > > +	struct mm_struct *mm = vma->vm_mm;
> > > +	spinlock_t *ptl;
> > > +	pgtable_t pgtable = NULL;
> > > +
> > > +	if (addr < vma->vm_start || addr >= vma->vm_end)
> > > +		return VM_FAULT_SIGBUS;
> > > +
> > > +	if (WARN_ON_ONCE(folio_order(folio) != PMD_ORDER))
> > > +		return VM_FAULT_SIGBUS;
> > > +
> > > +	if (arch_needs_pgtable_deposit()) {
> > > +		pgtable = pte_alloc_one(vma->vm_mm);
> > > +		if (!pgtable)
> > > +			return VM_FAULT_OOM;
> > > +	}
> > 
> > This is interesting and nasty at the same time (only to make ppc64 boo3s 
> > with has tables happy). But it seems to be the right thing to do.
> > 
> > > +
> > > +	ptl = pmd_lock(mm, vmf->pmd);
> > > +	if (pmd_none(*vmf->pmd)) {
> > > +		folio_get(folio);
> > > +		folio_add_file_rmap_pmd(folio, &folio->page, vma);
> > > +		add_mm_counter(mm, mm_counter_file(folio), HPAGE_PMD_NR);
> > > +	}
> > > +	insert_pfn_pmd(vma, addr, vmf->pmd, pfn_to_pfn_t(folio_pfn(folio)),
> > > +		       vma->vm_page_prot, write, pgtable);
> > > +	spin_unlock(ptl);
> > > +	if (pgtable)
> > > +		pte_free(mm, pgtable);
> > 
> > Ehm, are you unconditionally freeing the pgtable, even if consumed by 
> > insert_pfn_pmd() ?
> > 
> > Note that setting pgtable to NULL in insert_pfn_pmd() when consumed will 
> > not be visible here.
> > 
> > You'd have to pass a pointer to the ... pointer (&pgtable).
> > 
> > ... unless I am missing something, staring at the diff.
> 
> In fact I glazed over the fact that this has been commented on before
> and assumed it was fixed:
> 
> http://lore.kernel.org/66f61ce4da80_964f2294fb@dwillia2-xfh.jf.intel.com.notmuch
> 
> So, yes, insert_pfn_pmd needs to take &pgtable to report back if the
> allocation got consumed.
> 
> Good catch.

Yes, thanks Dave and Dan and apologies for missing that originally. Looking
at the thread I suspect I went down the rabbit hole of trying to implement
vmf_insert_folio() and when that wasn't possible forgot to come back and fix
this up. I have added a return code to insert_pfn_pmd() to indicate whether
or not the pgtable was consumed. I have also added a comment in the commit log
explaining why a vmf_insert_folio() isn't useful.

 - Alistair

