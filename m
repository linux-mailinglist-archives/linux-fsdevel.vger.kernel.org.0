Return-Path: <linux-fsdevel+bounces-32085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205999A0641
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 11:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50979B22EFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 09:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBF9206945;
	Wed, 16 Oct 2024 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bEr/f1qm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KIimvKAc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD45E199944;
	Wed, 16 Oct 2024 09:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072693; cv=fail; b=uSgrY5iz719cX/zo/1TRMaxiNL6M/NQ9qvPDsTak3E4Dq9+RXE1QRfDJm9xQnsXD1lvKIBw9tGaTb3Hjg9VFbjg6iYlwTvVaFeQwCxlaNp5Nc+h3k1yFp1kuKT4zXDyLhz7wS3ekyPD5FKJEiKqwOKmteTSNrn0mzRTr7E3Xd/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072693; c=relaxed/simple;
	bh=inViALwaT9+Jo/FOro2Q2rKOBCnidXcZsU+mV63qtU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S+CxhxoiwfuPHSaR15TbIrHAS9yjENuCVezvKS5N9QwlwLxWSO+oHMt89D/yIqAwMSSRiVR95JA29/7/up8YBKiWqXoBrofejh5rquoBrioPy/WYL7hDg/cMKEPNH+98szE/XtBA54xoNpMdZlTDjfdX6E4g2diLKrAY9VTmF1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bEr/f1qm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KIimvKAc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G9td2G010074;
	Wed, 16 Oct 2024 09:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=aqr2aE44ucsBDkBV9E
	BvNMUB8c3LJr6IcsWTiQsSnVg=; b=bEr/f1qmbTRvyfs6N4Vo3nbNwficlwzLwI
	Yvh78+R5b9eW6x5fpKmH5+lxP3C+hxSi19TQHCLMm7+skaiLt2VGy3bFTwVenE8M
	vbPIaTcyR/ugLya/aMquJJ27jDFxGWpnH4gJkT5m4FCH1P+s8Py991HpYU6JJ4cO
	NqRuIGfKLaIh9L+UtgiNL6nQ+Pl5qbjuUiaP9PAPmnGiKBMdnlt1q/eo26C6mnqy
	GLZYQQTwHsxfKBM0U+NCqmCt9Bg6caV1/W8xUkka4dIbvXVtHDy7LfQgPrDoQJf9
	GzddYetvUhvCZqIA4sRS2huEhKmdL076lkZFziuBFeeQXH6eumvg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hntbd8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 09:57:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49G82HGI026283;
	Wed, 16 Oct 2024 09:46:49 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj8m0q8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 09:46:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vh1mvIEuppY4dRzVBpF5JNu+bugux9mk5rGBsj9vchjOE3PfEePwk6QbWN9PmFuZEvvKVid/RK8l/Y8UjeaVsqXxOSY8NucZxReCsY2BtO80Znbg2rT1Y+65Frf+tDDvlmsPRxwAZJRgaLvITxd8f3GZX+MXVqH91vTtEFY0mZe+Wy6Nniaefj7+xjq0nI1ppCTdIKHn4jCipxA3LPtf79usWMoFDQEI92siCAgNGb0b8A2JluEiGbW7B2EurrK1f/Vr9NbzNAK04J37+bWxOpqNFj51/KQqCVh3lD+y6AB5NnYmpvyiZchTvfTlhMjOFMfk1k8CZwWA7i44qat9pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqr2aE44ucsBDkBV9EBvNMUB8c3LJr6IcsWTiQsSnVg=;
 b=g4GFRJR8FgpNjivKPXsLy5nqFO0h9LNPt5P9nUMCPycHMgc07QimHYajlBXObUPJwKeK330SKuW1LlAX4fR68Y+2VxByRUL1opgboY0nYX7gU02bygCfrZV6dMRmKJY/MecE9zFmFg8LdGtEVAcp5AnBrnxH5cC1LB071uCHDz0GosrMwviZURZn7DFq/LKY40pSkRMeLtjC/2ajfuU+m2hx9remrd0+VGyHaa1u1LmROIwUUFWVEMmWq+hRM1QiHSlpeqzwSnYPuJGr7Fcs2gd931Y8Ot0ybkC/vY4SsmtHEo+Xxv4X7gL7Ci9TUdPCAoKF7cv8tCeuigpbfVWaQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqr2aE44ucsBDkBV9EBvNMUB8c3LJr6IcsWTiQsSnVg=;
 b=KIimvKAc9NlzORCNChHo99zuLn+ii66GBT1JTORi+zUzl+yZv5u1Sdt7q6pioq7+Vi158TjDv4P/BFnJGdGD4hlrCiIMXxyeTmEkdz4SI/ql3ivHMUaqX7GnfbVqPR1fpjWIJKriez/pkkMPv7vmeLrLS7p2FMQBAsvXaQFvwUo=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA1PR10MB5822.namprd10.prod.outlook.com (2603:10b6:806:231::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Wed, 16 Oct
 2024 09:46:46 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 09:46:46 +0000
Date: Wed, 16 Oct 2024 10:46:42 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v2 1/3] pidfd: extend pidfd_get_pid() and de-duplicate
 pid lookup
Message-ID: <20624722-7c75-45f0-924b-e887b88e8aef@lucifer.local>
References: <8e7edaf2f648fb01a71def749f17f76c0502dee1.1728643714.git.lorenzo.stoakes@oracle.com>
 <202410161634.abca3854-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202410161634.abca3854-lkp@intel.com>
X-ClientProxiedBy: LO4P265CA0082.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::15) To PH0PR10MB5611.namprd10.prod.outlook.com
 (2603:10b6:510:f9::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA1PR10MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fa23595-3862-4edb-f1d9-08dcedc7728a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RWeXW28Vgmb1QfS6z2JLw+WY6Shpei8usYr+EZGfFoZeneqj5G9rx22SQTcM?=
 =?us-ascii?Q?YFcx/q2UDHayLj92Z2GisimVUhyItmfqnNRf89d+e5fTEnGM/Nlb8ElV+68h?=
 =?us-ascii?Q?T/IOt00+KWzTXNVpNNHeudWhAorlHN+jglbfkh61fzO76p+wSp7FILfO3BX1?=
 =?us-ascii?Q?feoBlc2Bffuj/7BOpKkT73gREyK9Ygu9fwwbDdX8WCl76PP6PHlS/MMPx48R?=
 =?us-ascii?Q?nQ3/DEnhOAi2Q+n94OQNcBwcnT4tfp1GJZJG98dOoPLTx/AWfLqdrvdtkil2?=
 =?us-ascii?Q?T2m6gRjBFFOLoRYnVOt5x87Nk3W14rm8TX8QlXaGbSNyDyiLVMLo50uVr6z7?=
 =?us-ascii?Q?9aZX/2j/8ZDs21hgXwrMmCfm5LEJYBDJc5KQS3BkRSm5Oga33wMGUxVts5zF?=
 =?us-ascii?Q?zqAxNPJU/SxqR6RWW/UbF2KZRgS+n53Ch+C9nxf7cD45dMwGzLrYLidoYTNU?=
 =?us-ascii?Q?/u7hw76GJgw9g8ST+4moRtNZwHb7yjv+0d4DGzRg/E55go2l7ViwHdHzyWGW?=
 =?us-ascii?Q?HM2r5WvbNJ6XIn7UWzke6Tqujhmfu1Y1mmaW4Pr4UbJoxsipXz1dX5dRHM0L?=
 =?us-ascii?Q?v6LBrgIwRKoTG0WsQbcbnTsB/fuRv0jFZ+TZoEeXaz6MC8LwsiB8DhKbYNyc?=
 =?us-ascii?Q?yRG93e38JZVcEg9DIxQug4OwZ6/iLGXVHLcJ4tm1NV7eoxw7aUWlQTwbJoLk?=
 =?us-ascii?Q?nCaBxqWBN6zo9TEiYHFvpvtYVp/3T98Q98PtDrrPp7BPxAqau1H0uHEIdOo7?=
 =?us-ascii?Q?TICRp0+ix1pbRgemwm9HR2+D8SMIDGztXzEQgLjgvAwchsIHhOhxdybPV0U2?=
 =?us-ascii?Q?EO8cGUfP9do8bO7vxJs8vuXcdlXCVPEvqLz2+YkSHET4nyK6Hh3zzHXlOnyZ?=
 =?us-ascii?Q?OMVqEi3ziGPdedLz3CCOZQCy6vgUw67hHX4Bkl2zS1snL6Wz1+3S/lMLX8BB?=
 =?us-ascii?Q?ssh0XvEs8NhsrsOmodNdWLAJOKQlMYzCW2Ab11X1qu4V+gmKB8EdrConlQNp?=
 =?us-ascii?Q?ohH4v1Vennu/fokRqX1C610iKZPDDfdInoDCnNVNBqGhzdweuZPJpInp3Dpi?=
 =?us-ascii?Q?gz+MFeA9exnRfthZRM5K5alE/ySJNxH9l8awNYS4xXliocNyIyurQv7tbMoE?=
 =?us-ascii?Q?Eyv8yzlL2JFot1WaLRGgGUFD+2UvQ6vvqN6pNjixIwQUqxYHsnIAszzmTmZY?=
 =?us-ascii?Q?yTK0BIumM5HdHWSokrLXqJ+WSF3TnpTISu9B4XMY9wMbJ1eZ6lQKDC5jFHw?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n6aZjV1Ocw7LwqKQxUpnkxhWHtUQdtWSirU9uSYDOz7+PlTKtor6HsOdljVE?=
 =?us-ascii?Q?4dM5N7TlzGw/hHuqaX5T0hdPrPu0z2GqmiU2pfV74kaQsl5zo3L9/cAuZF9h?=
 =?us-ascii?Q?HlGb3OxymaPZTH68xRzThW+OSj9gisM0Cbk4slXYNT7DhKzIkx/+QrWjZ/LA?=
 =?us-ascii?Q?o+Od4DMLXoOqoRoJ+NtLCqaNVblRSLCy3x6VVeaktG3AsTXRPJhL+F3PnjDO?=
 =?us-ascii?Q?N0grCHpJwzQq0MRJ3AnyIhfS4u+5ECigxQQO/kiudP2Aa1nehIJ2lhtjXE0E?=
 =?us-ascii?Q?wqN+AinUMzADiVXfyHNCvTLV9mgvFIZmgoALZ7eBz95oHwCn876DubJnEIqm?=
 =?us-ascii?Q?tVUzt1edALeHpcQOuGeohqqWwchhQq/m6CPNRLs7KC1T9zW8tLKg5qBLAgdw?=
 =?us-ascii?Q?JgAPOILZC8FluNrj30m+kVRqUBm8N9neXpf4Jo5XivwNM+iyhNfAyRiFeb6G?=
 =?us-ascii?Q?euCjo4BOor8Vc2QsRVxMqVM3nmfxVM7eYfFFZvEyXTL3HTzblOfBn481YS0R?=
 =?us-ascii?Q?QN0ei/5X5zv/TSF3wHDFG2oXubcgRsN4jjB65wpqQZf8AvvuSF8qhCfcyQW1?=
 =?us-ascii?Q?P67+LII4M87lncjU0MnyMMcD/BIHeYGK9Apd7gZ7IBH/2ZL/reblsHl+Iff0?=
 =?us-ascii?Q?Ad1QVWpIdzOFBQhTblE4gbU4I0LzI4iQVpAVE4ACM3rp0T8aY+jpQ8jXzEzc?=
 =?us-ascii?Q?IVutd5K7ROvtq+UDnwJNKy8TVDJ4jkHhnmCGZI75sLHDDgALsqbU0xQZ5H5+?=
 =?us-ascii?Q?bDOovBWEnKGgqAQ05yxtkbeykIZN22Szo0BG5Zt7EAbnrjp907qLmuYw99n7?=
 =?us-ascii?Q?AWxCAML2JXOF2EXvGhs51kz4FfeMs50FQkdAzVFEZ/5ycqqZA0CveLAZkIPd?=
 =?us-ascii?Q?7p/VP89A9LsnAg1kj+64BwDaElXH/YCi3JbRGF1kBHkBrALWuPcSoKvWKqtW?=
 =?us-ascii?Q?LLV5ycQM1X80zlZJyo3z56MBunIGLa5ULTm5gVZWUxyJM7Lp/ztxDWk8Icf2?=
 =?us-ascii?Q?zUFpb7q5GWVjeglGCEy8Khx/f0DgkscuJxUE2eLfThYPHYqcZR1MVsBmgrFU?=
 =?us-ascii?Q?f7vTDhEtgGQj8/+817PfyscOxrjFMS/Y+5pBWVRfJWaxydo7NyWjqRMxlM9V?=
 =?us-ascii?Q?+/EmP7zGP8HrgaZfuKd8beVpbfKlg0dYiRmkQPjdp+8dVnFPb5XY96kL2DfU?=
 =?us-ascii?Q?yKEGLp5TSvV0nsJoe8Xn3q5V8N2bw3xLUDDy+TPNtKYaIGGjrox7fZDPxxVk?=
 =?us-ascii?Q?hxCyFu9pX3oNErNSASnO8B+b6Sn2+me0OAUpNhy+GiAupOQ0pClgkajrLqN3?=
 =?us-ascii?Q?s6JRSoVQ+JKIDT/XhYUPCbmgu4iJ+4yhTVmoho7WEAtBuPMtDSaizU4jGlmy?=
 =?us-ascii?Q?339wTsY8xnH5pIJfRjMdxmkpm4BN6cNr1owvUbvKwEHpdwzzu8mdyDT9QsoQ?=
 =?us-ascii?Q?S7VmrXuTSOyhRgg4FBUGChE5V1OGe8QE3tMRsEH+n2s/wV51icIr1yC9z2qq?=
 =?us-ascii?Q?Rm/U75AjZHp2J1qdLTofAROfv89AHrO8uWrOH9iI+kGgfwf3V5AwrpmDHJiP?=
 =?us-ascii?Q?yuIKeGpOWy2E3KoPifP3VyZMcfNCaXBi0GOdBdOPFxV3Qi1JZEOtsE5CPeiH?=
 =?us-ascii?Q?7bNAlQNAduCGyLER4zb3V1FHhg7EKqetR6Ho4OdTpSV6nTSBuMTd39JaoVW0?=
 =?us-ascii?Q?yzCnzA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TtH/y4nINIXsUHrXkD1PsnsKeJBR1RrGTRXIYR+GTkn7+7H6wh1g+yabu5+9gYrwzcA5/vs4xdUCa3QZ5RIbJwubR5NtIiwOXYkZjp8LhcB7J67q/5C1az7jGe7DNZqcKbIg2u7ZVAsuv/szM6nEz1H3pN4ACRjPSD8JLJA9FnQl1dFCBieOji28X4l1GlBeZ4cV24vvCumWW0puV9eQ9dAKIaP8n3RbocH0IWUBtnB4zqvGVG0yHLQGThnquZ/Fcl629ryfbHfSxGueQjPSTw1pcogDxd4UfmOtyezEgvnC33Bwu8EvrZ0gGvK2eSMpV6QpCvA86/EtZEHasg/803cke2rkwvhq5Ore49W2bAyv6Cw3VNnxabguem7jD7bASkB5sZMMMFPGcSu0yC9pqXBE9bbbP+OjTLNm4mLutu9TWl4N7ZSo8UH7Y76Yq0pGdSsQxZ39vgDqt1ehkWEZg3okognHA7YsjigPhtdMA883Pi8WBdHq2WpofK7CZmyhbuIsH1xq+/zyaoXMj4HiUXmuKx6642z7f7xgiTzMYa1vGVcykL5Lc10vOgWFVcfbyXJVXKafSHb2QiRf+lTbEE/4Wro73iK22StVgCk4N50=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa23595-3862-4edb-f1d9-08dcedc7728a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5611.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 09:46:46.1179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ddz1DQ6d7S+hfbEyFb/U71olnnGhkwfX2m2UGGkK//Uk/pGhNu+c4glpou4qw04qfo0IKZR4kLtwLbmiglUxgpC2rmo33RF2mggMjsaLvWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_07,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160062
X-Proofpoint-ORIG-GUID: PPRTgZ3exv8vnU8Ajt914zpVp31SMeKt
X-Proofpoint-GUID: PPRTgZ3exv8vnU8Ajt914zpVp31SMeKt

On Wed, Oct 16, 2024 at 04:50:56PM +0800, kernel test robot wrote:
>
>
> Hello,
>
> kernel test robot noticed "BUG:unable_to_handle_page_fault_for_address" on:

Thanks, see below for analysis.

>
> commit: e65dbb5c9051a4da2305787fd558e1d60de2275a ("[PATCH v2 1/3] pidfd: extend pidfd_get_pid() and de-duplicate pid lookup")
> url: https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/pidfd-extend-pidfd_get_pid-and-de-duplicate-pid-lookup/20241011-191241
> base: https://git.kernel.org/cgit/linux/kernel/git/shuah/linux-kselftest.git next
> patch link: https://lore.kernel.org/all/8e7edaf2f648fb01a71def749f17f76c0502dee1.1728643714.git.lorenzo.stoakes@oracle.com/
> patch subject: [PATCH v2 1/3] pidfd: extend pidfd_get_pid() and de-duplicate pid lookup
>
> in testcase: trinity
> version: trinity-i386-abe9de86-1_20230429
> with following parameters:
>
> 	runtime: 600s
>
>
>
> config: x86_64-randconfig-072-20241015
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202410161634.abca3854-lkp@intel.com
>
>
> [  416.054386][ T1959] BUG: unable to handle page fault for address: ffffffff8fed9474
> [  416.055651][ T1959] #PF: supervisor write access in kernel mode
> [  416.056550][ T1959] #PF: error_code(0x0003) - permissions violation
> [  416.057502][ T1959] PGD 3e90f5067 P4D 3e90f5067 PUD 3e90f6063 PMD 3e50001a1
> [  416.058587][ T1959] Oops: Oops: 0003 [#1] PREEMPT SMP KASAN
> [  416.059414][ T1959] CPU: 1 UID: 65534 PID: 1959 Comm: trinity-c3 Not tainted 6.12.0-rc1-00004-ge65dbb5c9051 #1 d7a38916ac9252f968706afc2c77f70fbdabe689
> [  416.061328][ T1959] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 416.062850][ T1959] RIP: 0010:fput (arch/x86/include/asm/atomic64_64.h:61 include/linux/atomic/atomic-arch-fallback.h:4404 include/linux/atomic/atomic-long.h:1571 include/linux/atomic/atomic-instrumented.h:4540 fs/file_table.c:482)
> [ 416.063578][ T1959] Code: ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 55 48 89 e5 41 55 41 54 53 48 89 fb be 08 00 00 00 e8 96 c6 f7 ff <f0> 48 ff 0b 0f 85 dd 00 00 00 65 4c 8b 25 04 ff 0e 70 4c 8d 6b 48
> All code
> ========
>    0:	ff                   	(bad)
>    1:	ff 66 66             	jmp    *0x66(%rsi)
>    4:	2e 0f 1f 84 00 00 00 	cs nopl 0x0(%rax,%rax,1)
>    b:	00 00
>    d:	0f 1f 00             	nopl   (%rax)
>   10:	f3 0f 1e fa          	endbr64
>   14:	55                   	push   %rbp
>   15:	48 89 e5             	mov    %rsp,%rbp
>   18:	41 55                	push   %r13
>   1a:	41 54                	push   %r12
>   1c:	53                   	push   %rbx
>   1d:	48 89 fb             	mov    %rdi,%rbx
>   20:	be 08 00 00 00       	mov    $0x8,%esi
>   25:	e8 96 c6 f7 ff       	call   0xfffffffffff7c6c0
>   2a:*	f0 48 ff 0b          	lock decq (%rbx)		<-- trapping instruction

OK so this looks like the fput() invoking atomic_long_dec_and_test() on an
invalid &file->f_count.

It looks like 0xffffffff8fed9474 in RBX is the file...

And that's because I'm not setting f in
SYSCALL_DEFINE4(pidfd_send_signal, ...) at:

	pidfd_to_pid_proc(pidfd, &f_flags, &f);

On error and yet then jump to

err:
	fdput(f);
	return ret;

Which is trying to fdput() (thus fput()) the f, ugh.

OK I will fix this + respin, thanks for the report!

[snip]

