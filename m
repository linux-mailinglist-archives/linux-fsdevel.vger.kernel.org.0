Return-Path: <linux-fsdevel+bounces-15487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E3888F3B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 01:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 377D7B23E66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 00:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764B4E545;
	Thu, 28 Mar 2024 00:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aUSpFIIL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t41sn4Ts"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF4E36B;
	Thu, 28 Mar 2024 00:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711585856; cv=fail; b=ZqpJMwICkxpvHYeUbjXn3DAPGNwtMMJ+kiTzxf3EHWzwFXGtdGSZ7I/5plEhC+OA1RRVF7egKEuf3ysLrChtVQSZMr2ecDov82bfE3kVT0Mmwu/jDK0RWNR9b7vQyqYq47LbrxcbvboBxqo6+Z9F88KT1soDOcgdwPvqcvnY04A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711585856; c=relaxed/simple;
	bh=f61HXr82irnE0fckiptEqBIGXEs8SQkgio8UIkWhFSg=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=g8svW+/fjZg3Hjx74zfdIqWazJEOLrrr2pAEJwyfE7mQhP8O3u0+Xrvqog3CWKOcaE/YSb76Xl2P1LjpmBcXXnoGbQR75jtXcMsFXcVEGRCR529dA1/EqGRU/JuDaGkphI38e0xBDggpdRZWzQ7tMh3GPOrOa6gGdkDtSjYhz8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aUSpFIIL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t41sn4Ts; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42RK9LhI027654;
	Thu, 28 Mar 2024 00:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=s1OVMsX1aIVoqf0AaLjVJ16sukhksUL9lfx0yODmVHQ=;
 b=aUSpFIILm++mariVJxxNrWL8Hz+QbawBg7ymSO9+EHRQk6A4Xr3+gvOPeqtbD2W0rCdN
 BMfIxU/8ZVQMDAUFBX2I4AMXSoApLlRG/fLzQpVW0L5xu6WVDrFl81LBRCev79ycIE1g
 oOxGxusjWXDDXSs5Zgy5tP2uJqC8PrDAx1dxWarZdM0eQK9cD/PjG6agOdGlFwTtqEGV
 FhMvkEEWTrX/LZLNVFRfgkCo0LoE2RW3zvbmLcsl7V1+I2xcTXk/XsnKxPp61afUy1JQ
 DYn1lQAlmCo6/ymaqaSWdHHUxXMY9jW5Mb2oRuoQqCfGSxh5Fxdsw1L2sedkXYj5Jlfd yg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x2s9gy4wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 00:30:36 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42RMYNEk018241;
	Thu, 28 Mar 2024 00:30:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh9gu5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 00:30:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvCb8SsZLuVj0/j2J7sdB9CbnGjdvhMUHqgCqlOgRSyKN77ciI2AZyS4GT8Yu7x7MysaXiMXHDpnPaoST9VjNg34K8GwXGslNuhK+mknFXpyqNAwj2cL3kZnfWTWSE54wYCRjgJJQZnIoCibLlFTelKGQA/pKNdNxilhW8gIAmDzD7NWS6OhGYzunczrD6AIsSDJlsH+AwY/N73kqglwzxW6miflG2+TESXJshdZAIB65ZbveH7b2RnHSPNo3xTaGlkbkaEZgEcOl42owryN9Fr13HXUjNb2SmWdh4UrY6xSWwr6v7Wc9f6CsCux9cPzCpKy6o2LlxzZIrDrF/n40w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1OVMsX1aIVoqf0AaLjVJ16sukhksUL9lfx0yODmVHQ=;
 b=CxV1j809i1Xly4c6pfheT/ePDh+uMl9teR53kgMqWz+IO+5sD2mMop+3fikxUgxsfgCuV9kDV0SMzR5NT1EzuEa/TLsJrEtO9NlbJA5uxip5kF3lhi7/dWg8KDcTDW4CUwMfzGM8sqwioWHhDsjR8+N3QKDfWZFDh0Nmybw04AITgMmxq7ozXhpvPBjL5CpEX6WmGhzmnk7P1HyvPsnukyF+xzWT3MLCmx19jOOnnQqsFa3ejWmU84lF5U7wnUxT1ZAxqVSsdV9LsEQ+6SyqSsKe51deyCWwv5rawvH8Uv/TaramMSoPA84E5tDB//rnukCpmbjqix8R6R5OTftfqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1OVMsX1aIVoqf0AaLjVJ16sukhksUL9lfx0yODmVHQ=;
 b=t41sn4Ts9qHfDEeiIQ91CmIkCconAK9YUsR+N/xt8nD/4Jv+N8AvA7WStOYNTOfPd5dAgfAGFlJTtE/a8wN0iTaZTy9wdR5V7mmkihUjJCKZae0CgqOeucVydOB2Sb3aQivapUdq1Wsb5eqfx5pLd0xtaojY391uQMznR4JX9eQ=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 00:30:33 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 00:30:33 +0000
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        "axboe@kernel.dk"
 <axboe@kernel.dk>, josef@toxicpanda.com,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        Linux FS Devel
 <linux-fsdevel@vger.kernel.org>,
        lsf-pc@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [Lsf-pc] [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC]
 Meta/Integrity/PI improvements
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <c196e634-7081-9d90-620c-002d3ff15dfc@samsung.com> (Kanchan
	Joshi's message of "Wed, 27 Mar 2024 19:15:56 +0530")
Organization: Oracle Corporation
Message-ID: <yq1sf0b4359.fsf@ca-mkp.ca.oracle.com>
References: <CGME20240222193304epcas5p318426c5267ee520e6b5710164c533b7d@epcas5p3.samsung.com>
	<aca1e970-9785-5ff4-807b-9f892af71741@samsung.com>
	<yq14jdu7t2u.fsf@ca-mkp.ca.oracle.com>
	<c196e634-7081-9d90-620c-002d3ff15dfc@samsung.com>
Date: Wed, 27 Mar 2024 20:30:31 -0400
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0013.namprd18.prod.outlook.com
 (2603:10b6:208:23c::18) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_
X-MS-Office365-Filtering-Correlation-Id: cd4b91e6-44d2-40f2-4a7f-08dc4ebe47d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HziVymxPdBSnBfmNdfVP5Y1Ek1iUPPVtDE89TkPl1VPND7QhsXTrUCNbdmh5/z6y4X9THw0+8rW4us052fAr5D1X70FaIGy3h7u/fk92zXswyh9TkLMQKak+DziEnhm3fRsvpFWA0QYoLFa7kDrnV2VkcD2UahCprihtcv93swrxWYTV8+tj7AyZTV0F7abBiMrm6WZzeaIByffACxfaH035pvdelm7YlsjC+5uogsgG4b6sb2G8u5qbLYTh9bQr/b9EccsDCyooyBUoJr7bNVpBqGkb6jilimu4AA9Dlpoi1vM864sI/WmlZI6GltU/volCf1bWtX/jLZ8/vURJZ8viWRbIFUalB0TpwIqHEPna0apC9H50lioZHzv5Ia0ZxBkdZ2yd3itPSlr5JoeqD+W7MQyk4FNV46ya4K+nn+L5cWDTLKbam1M/o2jEHZ7ZRN+2Xo4VVsVogsoOIBlparuKqIToibayRjyytpJ24FqEN7hSqNgfhFxFKkiM9Lo7tKFI/WXb2D5F/+4eWJr26WXsxhEhvFHTYFzurw2SCFKF5M902Ka/R+cioL/RX9d1fvCaLwBFCFl8ANgMR8ABxkyanvsQr2YaBbtxrxDEXKl30ZvFsTiIibfSeedsxHtoJ+NaPH6vW8KJd4gnp1yvBw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FSAVVJ+fMqzfDzWuWuAajysstPjMoqa+D7Y0FX6JU1ugInp7UMFwoHO42PQm?=
 =?us-ascii?Q?MdsijucezCys3BcjiP1J+w5pZoVN7FU1LMOog/R1PmmkXStWbwdwCT2463DX?=
 =?us-ascii?Q?oklAjcFxnkI1dVpPJoDz+JPLEZ1JA5o9UFOAYzdUgsyMB8IV4tya+gYtW2mi?=
 =?us-ascii?Q?OTWqopEhYyyrxnpSQhBpbYaxYQ1fAoqggY0dNEN1fjA53cH+onyNH23JxVbG?=
 =?us-ascii?Q?DCIkREL7lZxb6XtGDkBMP6eVa2DrB0aPm9TW3X+Fd6h9MaeElC3Il3PpBUPP?=
 =?us-ascii?Q?jtfpvM+hk+xP+9rybwhQ9V9OP4byuxScJXFbopEs2jrtjB8XQRf3VJCHsuMJ?=
 =?us-ascii?Q?D2c8BlDrFc9iZJi3a8ndOFLjCGxqNlp6c5yoUIbDKzDXzZ1PGHr047MhOwv/?=
 =?us-ascii?Q?4a4em7chu4BweMmUPXmJclMqbviVmTUTRTLiHwsYv/FZ/bOQK3PjKgTIujcs?=
 =?us-ascii?Q?DTcq89CxkBsefeYISwaNIk7sdwrxCif1fY47KLbSbDb5+KfjGUJkqkyR+ja/?=
 =?us-ascii?Q?RKZgjysdM4hUOQiLhQ0JvjE8vmd11/RKZ4BC3Dvv5+MeCaORXG2w/Er6HFV+?=
 =?us-ascii?Q?62ZZ1TFD+kvx0TL9AJgbQpQtiUcd4Z5jLW8K6WsAY28982YLMXl0PjJdmfMp?=
 =?us-ascii?Q?+ACXXHr6ZrNXlqcOveusgW6zZgpdxNEcAtQotvx6aMyqUTQu2aAZj538SJHI?=
 =?us-ascii?Q?VKcMzM6Ey/V5IPK+tFE5tCpLFq/52mWD4r10KkyazdLSypzl98BETTLuI8ak?=
 =?us-ascii?Q?WbK1X9g73y53O0KxRyY+SeWZxCEI6jA6Tlsy6cOlyQRe96WsIvYbJ67JhaRa?=
 =?us-ascii?Q?ftKwumwJV+UlyLjCEum/aopRf5/KLOAe4s7GafsGgAXYGQJc1FTXtr0YWeDn?=
 =?us-ascii?Q?cpI4agvNXNQ/oucx6o2h6EoIU0DretfeGKO5ZW4XjQ4KvpayLQOJ/xti4ykc?=
 =?us-ascii?Q?BChuszSd4pHWf9gRvXt2Lo+Yemn6X6AS/BT+z9xA0/eQR+XmQXMD5kLWNEor?=
 =?us-ascii?Q?bltVTNCwHoCQ2PsiHMmlFFzvuBhcSMvHvr0MDWF9YH/y12BZaFCSTYdDo2V9?=
 =?us-ascii?Q?aitHadS1i4zO94wQXLAleMn/ehqyvVKOTbCuEsKoSXzqKM6FSbZU6Jd4Xopo?=
 =?us-ascii?Q?l+/HCW8we94UwQSu2HWjk1qnfwSr1Xwhp1rjf2C6nqb/bRC/pnTc8HouY/mE?=
 =?us-ascii?Q?gFLf+1aSa3wxG640964VQj+s/XEOwOinOFhFnld0KY6NmcnQTxINOosuBSYd?=
 =?us-ascii?Q?cQtTQrkEETa8RJSodOrfevNiRWdHE6XmFuo8aPuWgW7To19OyguRco3b/I0z?=
 =?us-ascii?Q?13ZXjRPlgK+oewO5iC8O+z7ILH8EnPsdJEmDVCLJZOvaduwQw2TUFla0Q16/?=
 =?us-ascii?Q?CTLnw3Wrq6kH5zmSs4Liuj+4qa5hcXMCaDf6VBWX4QM/HcVCq6ksMgS698ef?=
 =?us-ascii?Q?oEJekp/a/54kQP8tFGfgzyqWwbVtaAZDnCyPBBx8Uy3izy8CbXynsCrNlhYE?=
 =?us-ascii?Q?i83DSQPVckGxIxSGVjB/iQIsJ6Jxx68LR4RC0rXCSspaOseKOg3hXetZMcSg?=
 =?us-ascii?Q?KgV2EMhAx1lPJD6QYYzL2jAYe/0P/K0pXLR4GZL0JpwkvU0ak684aSkbu2gH?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	51224q4zeKClvfWXmSgAs++igdscPRI8qIRQkYjIT22D/RYGFAFQEWgiOTglCX8UdRCmLGq8z7gk5R2kg2Z8E5WfgL9cj62ljP6zIEk48flmznGHg/sSc9mPL7zHMSqFSWB9NZiAXwYaYjdIAj/RTDxoN8P/AXQWq2DSPGGDHhEpzVZ5VIG6aGXEgPXTpti+0UoAF//eVZoLsoggvdUEX1ZhxU462QTAqGwiy21lc6fCqir7A00igINV1ElxgLtP+n0WX04XIUudnDAdSp4CCZmkAneQeKSuWDOlEGKmut3Ge/sxA+EE/wAd+M6tdfNwYUCFS9+prQ8N+BcqLY4IXhduAzsCrUsOCPgLpYnJEJOGt3ECvu6Knxdx0yNYPDmF0SegV32NMVsBD5bEH7ZIo1tZ44LzD6ofUBlwYcyuXfPc9183NDX/eulzjvdcCAdBDNkVQCr+X0rI2GoViW7sMMK23YNcfU3gk9R+C1rn5NBT2sIW4TQjIda1Nguc5HGRFnspQJc3hKro3bKUiklzikwQRHeSSsk5ZKR6n+FqXVsEAZtSQ0cdngHOAXvwXIwBJKdkwlJEDxy9z7ZNJkydcgHYYmRppLv5lnRIguJubAU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4b91e6-44d2-40f2-4a7f-08dc4ebe47d2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 00:30:33.6478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHxu8D0jrXNUHeiapZ3NKsp6B/2M58YQ2zRG3pkqwNHY/3kXPkSlgr5bsIbtv8G2NrqDrA32KE9757N5CfR3Is6s1drL6xMSCJGXNi+Yy9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4759
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_19,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=984 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403280000
X-Proofpoint-GUID: XAcYJ4H_Hs0PT7Ag8EJhumRRcmzuw707
X-Proofpoint-ORIG-GUID: XAcYJ4H_Hs0PT7Ag8EJhumRRcmzuw707


Hi Kanchan!

> Not sure how far it is from the requirements you may have. Feedback
> will help. Perhaps the interface needs the ability to tell what kind
> of checks (guard, apptag, reftag) are desired. Doable, but that will
> require the introduction of three new RWF_* flags.

I'm working on getting my test tooling working with your series. But
yes, I'll definitely need a way to set the bip flags.

> Right. This can work for the case when host does not need to pass the
> buffer (meta-size is equal to pi-size). But when meta-size is greater
> than pi-size, the meta-buffer needs to be allocated. Some changes are
> required so that Block-integrity does that allocation, without having
> to do read_verify/write_generate.

Not sure I follow. Do you want the non-PI metadata to be passed in from
userland but the kernel or controller to generate the PI?

-- 
Martin K. Petersen	Oracle Linux Engineering

