Return-Path: <linux-fsdevel+bounces-31846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A20DE99C0EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 09:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2335F1F22C3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 07:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5149A1494B3;
	Mon, 14 Oct 2024 07:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qR5rRikI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E1413D243;
	Mon, 14 Oct 2024 07:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728890145; cv=fail; b=Rx8bVP0u4MyBDBsO+wXHfF9juuoHws/aQFafdeUe6eSp6bqgi9FxanGkJKYNZdAWG8Sm4fNGqqjy2wa4tLHuUYgf5FOYRS+wBXwlPSmo4ezLnAZqVCQcRL6nnSQRTF8BeiCsTUMQuo1YO4VLJFIpaR44fS7/ULROf/yEkqBolu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728890145; c=relaxed/simple;
	bh=hV2eJ3D/TvOLX9WCP+DPpAuGsGXhr9+gLjGBB0S+Q1Y=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=r4sJEhy22Bt45yMO6yv87N3OtOPgroUt0XjI4Lho2UB2J9+zVGJxieQt1UwHuhqlnFMhxkjMC3/XdguhsNC5PInhIJleHGCKx95RKMIWPZXq2ab9yz4x753SG0dVq8VfQoi209X2IX/Lemf0vnW2R1KkFJByZoER4xU+rtv4xMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qR5rRikI; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHmbG8mv60B1KC5Q58+8H5RANS+b3eUFgyuJf5ryuF0ov9UnjPSA+cJpiFr1oAg6UOFxKIqhwVbCr3AFhURHMss0epx5bJmZR2c84RbJH4RtsAr36UJ5uHo1d9deFTaphF9v7krdvlcgY8B0Jt89WaaDTgFI68E07sfGWlDrP8tMrkRex/ZFfGFANuAMODIgRDmbPxOFwnkx5gG9qVy8mZnCXtWcdX7rvkZOQ8Bdezks0b/svp0XO1wYFLEjT0cYg0xSycxkt4Oe2SnwrTXKHxaI8YdQLVa0yOzHdXpgP7ENKrGxBdP0kww5CzY5Lijd+7dwfzokLl0KdAF1BJCLOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WP2Pdqp936nwkCncnDeztBmzfwUkOvtEyKa0j+8/7qU=;
 b=rcI1V0Fo+l6dz8KnCm4QWpJ6rbt9d5wFUBQ5w8c85LYMwVw0KRk+d+N3ySkMjWIBeGzooxKEYGCv2sH411Eq623t3CvbqvIwD4pirmTZtcymz3UNDNR0IDPf2JLt9FJcPAmWBi9I2MUzVlhKxsXHM/V6GhnGh9G8ranYbjryGbqp4VT84QOQ501Kd/7Z0E6o4DBvwDaiXIK13Ue7BKbOGH9bjOeUi3tD/mkxwdPVjmzoh5gNjx1r1Dj+Xl9weeURdkLFL4T4AjPCajX694sVlSv/oood6EUyDg1lsB7bzmvwIjf4xfHkOzqqzMFPdTUqvImKID99GluZqKSXSnmZlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WP2Pdqp936nwkCncnDeztBmzfwUkOvtEyKa0j+8/7qU=;
 b=qR5rRikIooXxjtH1rXtNRDBvVjWza5iIiQMZPhslncMnvMAqvgt0nGvBz2fY6WXEN6IotblsAeq2p9gqdwLf8BI+SgznNNLfxtvI7pxaa8A1PFJIKm0Zo7o9grG7gv4r3FyDjvQGfR6Ip8AzdA0XuneAUVRTwX4qEd3NGUrwFazjqy8e5TupbH3xBbxv7i8sro7Ukj8F+KgOgzUq2TX2wa1rvVPASKLxWT18WT47y6qUfjiMIvAszEjL8fXZ9BVktoX1LYNebKzvWez52wwuvdX8h2MXI2C4qw9Ge+E0ACQ4kZGwH/yIJiD4G0hTN4sxRpeL3K+CilghoMYCqNmipQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH8PR12MB6818.namprd12.prod.outlook.com (2603:10b6:510:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Mon, 14 Oct
 2024 07:15:40 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 07:15:40 +0000
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
 <4511465a4f8429f45e2ac70d2e65dc5e1df1eb47.1725941415.git-series.apopple@nvidia.com>
 <ZvalJ9O/SV9Riiws@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: dan.j.williams@intel.com, linux-mm@kvack.org, vishal.l.verma@intel.com,
 dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
 jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org,
 mpe@ellerman.id.au, npiggin@gmail.com, dave.hansen@linux.intel.com,
 ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org,
 tytso@mit.edu, linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 david@fromorbit.com
Subject: Re: [PATCH 11/12] mm: Remove pXX_devmap callers
Date: Mon, 14 Oct 2024 18:14:30 +1100
In-reply-to: <ZvalJ9O/SV9Riiws@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Message-ID: <8734kznoiw.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0071.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:203::7) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH8PR12MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: eacb8066-7137-4794-e972-08dcec200284
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jdZX8bLsnYZ9ZoE9OCJbz/3MHXrKrj2+F5eBa+ePSkePzKplBLCmhcwM+JLZ?=
 =?us-ascii?Q?vuF1pKpVSEx6Ld1sqeyA9SRS9NQjZK/JOvJRjaVIvXovTcfcfeXGGD1A7c0y?=
 =?us-ascii?Q?mq2GM+gAPKhX2KHtaCNoJT1Iabplfwl5VTJgeGvLCi1uIN/q6WhG4Yr8H0Q1?=
 =?us-ascii?Q?cMSxp1rCGxi1WLHc9Mz1PpZ6J8Gk/HJvlJv0zeQNJysCE5T5U2JdLufkSUXs?=
 =?us-ascii?Q?20xxvOdrw0VVetgS8/sAdMCLfb4fZA2szLcZ1ycpOEXRE72B/cgk0KZVVvyr?=
 =?us-ascii?Q?aRjvXpkD5T1MRHZjKKtUxMnVGUK2XoK/8WXVH6S1TNVr44ugwZKMearFK2bX?=
 =?us-ascii?Q?zaGoYftyudJapUTQykYZJFCi7P2h9BeqCnsmhc7h2Va82kprmW2GKWvKbRNG?=
 =?us-ascii?Q?FZMQpzu8765dKS2AKrigcXreCmeKbZGitcl6+1dqQOLlgw6idqR13A1V8Gie?=
 =?us-ascii?Q?XrvVxIvKJIJncw3XR85um9yTb0FoYiKF0ff/n2rJjt+pS61uFWxA4wzCjzew?=
 =?us-ascii?Q?e3dlgVkdrAbxhZ21sOm8XAP2QOnvTVdypH/gbabupf5Evb84k11ZvsnatRd1?=
 =?us-ascii?Q?UMjhVjYG88gY/twVb90+NH8qBCsJpsHKkDW5juzLW4HBmquJvZHDuwfy/DZX?=
 =?us-ascii?Q?fS6FRIujQzui3fmBFoG/mKbd2Dkc2WdaUn08Rz39HOzk9lFDkkx7k3Fao4+x?=
 =?us-ascii?Q?hszKTgbwkUpE/P6p8CESB/uin/duiP5Qg4CFfrSd1sLdF/EQ5d0X0W0+736j?=
 =?us-ascii?Q?us3U0f+tRT3OKo4SrPNB/d45yEI62mu3PL0r8KJIlPOippjpU3QMd21LkS00?=
 =?us-ascii?Q?0or8ZGqcTTRkkICgLNmCfPRDWyFcUqD1+NOLoCNSdEG3ykYnrrwI2zoXxTe1?=
 =?us-ascii?Q?EUSlDpTC8uomE7ZkFlXW6gtoEWnXEZVwCtFN1LQpd1TWj2pima4oJEY8kO75?=
 =?us-ascii?Q?ml9kVPwxe5EAN+fG8Es/uYoVG9fXwFJYfEwOw9eCmlLdus+28DV0PoSNPhsX?=
 =?us-ascii?Q?O65i1KPHhdlbccCrkXSplNVic8w4WTeNl/R43Wz3aC1ONMhNPbR1iQ1Pjumj?=
 =?us-ascii?Q?ZDBAq3dz+9WYKH8U0IAnpwewX/4SE1/PeJr9G/Ka2EyptMjeprSJ7S4Na27J?=
 =?us-ascii?Q?2FSu+XqQY+28UdQR4v8ZH8EF2wFc/EebjlNuNVU0lKM2nCStxpsXiBby76Q6?=
 =?us-ascii?Q?qJHCYxHeeMhq/9Wm1RuK1J50QTBk+t1Ey6fX1dPks6HMblFmJd0zaBdKRlMa?=
 =?us-ascii?Q?eXFHeCwoj4bQREnl0YnDhvK4H+DxD46gxlXuDDrwOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V7rJ/4PW4JcHBftRz7MPARTW/ILPIm0QQwb5WugdW9LwwYxsfuIrS68ERdiL?=
 =?us-ascii?Q?Fq4IyPd9Wz0NZbxeopMR8g3ekoyaAKY9QyzEsNrfI2siTICY+4tBKLPg7s16?=
 =?us-ascii?Q?Yy+tKs6dAhdZYjd/oE5rSdjikoIJ2SLu2gtijjpf8ykKJjiOISXMltEo5UWu?=
 =?us-ascii?Q?uqsHynlg27oFeBmhXADps9hLoGkPbq/xlYF+wecpFV5ueCWdvrxfw+PHxYYa?=
 =?us-ascii?Q?xi1KquuJmjhAU+YPhYmsJlFcVlLU75vrLuK3neYh8eVNvbO26VN8+1fIG94w?=
 =?us-ascii?Q?qAxr8cOwef3/U42DZZh11BSEfK2MPSYaXicBPKsOHVe4rgrfr5kDNrO60Z48?=
 =?us-ascii?Q?49WRa7ZDb797Y1xotRNdiOmW1bp2wIJaX+Vrl3iGgH9gaCvRuGKcPJgMAAeQ?=
 =?us-ascii?Q?zkpagMZ3xT5ciBrB7iMxWDdBRfKaGvawoxb3qKRORHbc1FtfKxXVAcsZVuWA?=
 =?us-ascii?Q?v5qnq9kmhDpPRDNmCLi+IBoR6JWYt6lxJVMN9J7AW2JC7H4WACAwsneoJchP?=
 =?us-ascii?Q?Ns4IJ5NLl4SNap+Cnw33LtjBSWmSWyD3p/CRB040m0GBjXSt9s4iek4h9OdP?=
 =?us-ascii?Q?KFNTIajGeGSaBwDfvPqQoDpD5ZOqixPjpxw0OrcxaAiJfcfw1/hINeA2WKul?=
 =?us-ascii?Q?C0pZH5Ci0CwAL8Bm8cGnguBljzKg3wr/tmpgaKra1jCl4HtZ4GUOb3iL5gB5?=
 =?us-ascii?Q?1U2f6g2talvrCVQoeb8Wk/bK9uVMEE0tZAVu2R2qAGycg2DTFfrUpohjxNwm?=
 =?us-ascii?Q?DJTtI5xkAjA6/C5roYXzJTBPGJlfSvsftRTlcVjsg2KgtWnlAw4/1Ws+r3ue?=
 =?us-ascii?Q?mPiA9bhgXn67XfRlTBOBqoFwf7GdPDPQ4y9WWKEQnlLLwGOHWpLl+8dD4orC?=
 =?us-ascii?Q?rec+Xcam0eWmuIudPoW/EtdcPLJECgxje16u5Oc0ucKWlPfO+P2zcrMGHmKT?=
 =?us-ascii?Q?HmoWgefegz/BnwyiDEbnPdP5M0oG8UkbNAVjSVv1BUbFiayQrlN8xdV3fgip?=
 =?us-ascii?Q?phT5sthJKhJRYunM/c1XQmFFYycqskG2St3gqe3xE+rd3TbJMsA7yDwFxhlv?=
 =?us-ascii?Q?Ji+Rh2meKnkupSX6kHE7G0IwdwhT0ZbIbJ330k2DE6b0K8jAEaIWWUPRsC8L?=
 =?us-ascii?Q?r0CAnbLI1nt5UktFdn6OL1Xj+j7yXecbMM9W3MCzpvM4h5b/ghLvJXZp5i3d?=
 =?us-ascii?Q?e9fX5Ei6ddQfOoIu2/WhFXqPJKvritMauj2405ppOy7fK0h7W1Ihf80gGZQZ?=
 =?us-ascii?Q?/EVL8wH5KBrwWMRoTKpAYC5paHPrwYMxagT8Y1m2UVZuBTKzjJXCOp/DqJrY?=
 =?us-ascii?Q?yQy8a9itHrRM0YJlTXYqlnhKE3dt7rtGOsmfyNnx5wlzGVxgMTE2NQt48lka?=
 =?us-ascii?Q?eUmKh/Hr8LD4G7Vko1h+DtcS3DWuq+HB4+Ji2cPEb3IEhIQ75gDD4e23WI9x?=
 =?us-ascii?Q?lPNY0cs+7PlcgdzoncXeOKpXj53pWRKDWhX0mGVmERrE3OOgVtm95OQn+xWG?=
 =?us-ascii?Q?T5fad0NDksbEs7ggMLl78PXRgzMQLmrQ7Ljdy1KNw8Vqb8z1O7ko41RxOeQB?=
 =?us-ascii?Q?V8cul3GTom9Im3u3wDeKgHAKz5XxnmsyAtl/r2hb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eacb8066-7137-4794-e972-08dcec200284
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 07:15:40.6487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 337xgTj6slc8EJzfvFyJb9aE0PdsohRCj818dpWblbHHxo2Inido0Vdy9rG+5vMK2KA01ZJNGF0SGNvr/R/MNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6818


Alexander Gordeev <agordeev@linux.ibm.com> writes:

> On Tue, Sep 10, 2024 at 02:14:36PM +1000, Alistair Popple wrote:
>
> Hi Alistair,
>
>> diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
>> index 5a4a753..4537a29 100644
>> --- a/arch/powerpc/mm/book3s64/pgtable.c
>> +++ b/arch/powerpc/mm/book3s64/pgtable.c
>> @@ -193,7 +192,7 @@ pmd_t pmdp_huge_get_and_clear_full(struct vm_area_struct *vma,
>>  	pmd_t pmd;
>>  	VM_BUG_ON(addr & ~HPAGE_PMD_MASK);
>>  	VM_BUG_ON((pmd_present(*pmdp) && !pmd_trans_huge(*pmdp) &&
>> -		   !pmd_devmap(*pmdp)) || !pmd_present(*pmdp));
>> +		   || !pmd_present(*pmdp));
>
> That looks broken.

Thanks! Clearly I better go reinstall that PPC cross-compiler...

>>  	pmd = pmdp_huge_get_and_clear(vma->vm_mm, addr, pmdp);
>>  	/*
>>  	 * if it not a fullmm flush, then we can possibly end up converting
>
> Thanks!


