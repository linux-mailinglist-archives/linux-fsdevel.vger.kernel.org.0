Return-Path: <linux-fsdevel+bounces-57641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B28B24123
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 08:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 249A73A6A6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 06:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C957A2C08A8;
	Wed, 13 Aug 2025 06:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IEuDShlG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cZDpcA7l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21881F099C;
	Wed, 13 Aug 2025 06:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755065228; cv=fail; b=hH9PTxbjTdX9NF/mCKwKIGCRbeRR9Ffvlw++NrydZipxOZO7XDE/ZIpR2KZOcWXJNAQZlHMZbBvPL8APuJb07Xk4LCIAzldGnGjWBqYg4Kf1GifSHSZ/AcfYcaXNRgX4YKbZIY0WSAEjWtBDtabuCjXNIFxe9AuhcSJ08MOJ9OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755065228; c=relaxed/simple;
	bh=XozO5/Td7nKs9xH2Azr/7Ci1bep1sXP/zW1t0gNgMWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qk3vzpfOso6RshhdCSl+QrRjRX8i62dH0mtDzj+P1oHiDgknWea9H8IMLwD/a1U03oskr+kh6OWGl54Eb/oQC7dzhf+nsIZpbugIl3BlxXcFV55IftRGQkfRbTAT5dCWRqzpg1mHm2838h4fhk0Z1SZwuTb2HTPPn9dik/6SwgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IEuDShlG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cZDpcA7l; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D5txEF015673;
	Wed, 13 Aug 2025 06:06:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=XozO5/Td7nKs9xH2Az
	r/7Ci1bep1sXP/zW1t0gNgMWc=; b=IEuDShlGe0jLjVAqZpAF3aB2k02BICE9cy
	Xi/SfMYS6niXmfgDo/LWeKUPYhCL1JrAw+UMihaByXLLKdJlrUxk27xyaOlICxjr
	akBGaR0Euss1kDDh5g+hpytyV4UBe+5VeGaapeK155qwuNdUIsNt7YAGGrCJA2xb
	NY8KT8DwbaNBlYbeZKkAbng9bMO331uD4rH/csbOm+BO8LvDVj6468ru7VIFgn1B
	TnTGq98prKuEPbi89pfXaMt+NOQI1+3JPPR54kVDlbtN+qQzaH/AtIBcNuKgHfr9
	ey4tTG6fw+aOeHVlGmeLsxbFSjKO55Ty3JHcjXy4oJ+H/BAVAFGg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw44xgy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 06:06:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57D5sgO2030111;
	Wed, 13 Aug 2025 06:06:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsaxhr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 06:06:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sH45Pq6p62S3Y2J34tM0mSXMI5nrmU5LP1uejhZl+V08Lm0jZKljZ4yt0AFqmpMg1L7WzslzgODPevVSmHABrUJzurO8/RYC7ALkrznRKaSu2D66HqEe9YRCKw8eN2VCbxS9LG4rxUTAKnFZLGz6JbCGBduFiP7iaTmoqG7fAGZWokH1yZLPeMJg/Nb0ndR1lFz5I8QJjK2jPkywfl2wqN3oa9cNnuehRj3X68ATTwK9hRVFzajyU4ozE/imdZSi/Vy5FOXlFB3NnSUJBm/HevYGSKNiiDpo1N5+LALuBaQLdBK3u8XFAhfglSU8bW5V3h2A2QveiA4A8g9rTonhDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XozO5/Td7nKs9xH2Azr/7Ci1bep1sXP/zW1t0gNgMWc=;
 b=FwF9Sfchf68+7hd4F2sqMCvN6tuoVGOAdkTTvNUCth4ndvJybU8+4pXjykBlpN/1GEpUQfdxKYPU6ElOT9mnf4c7ZaKS9BCyTa42K1zZHTuVdQQ9mN8XP/Vp4LUAdMxU7DkAbC+EwUGtxcyHQaxHS71CcmTY2+AWNpM1zKdZqTiOdGPNlFmtFpcRUVtKNhQPSGKGJZkxm56NL5Ba6TDKjNKb5X1wFiray+P6FZQffP+2sfAInDvDdfkB7TXHpV9UUFn+R2550tXY/n3zAT6cU5gxOPXZXs8SLMiYXPEneAkeH3fJGSWnZxV9PhrhWvLCwkJRW+YbePwtqY6QkpnA9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XozO5/Td7nKs9xH2Azr/7Ci1bep1sXP/zW1t0gNgMWc=;
 b=cZDpcA7lmDjp5iebl+qRbuTgMA1iPQTKbv1qdtG56MmsBYpROBLWQMJDQydN/0rZ3XQKhVWw9PidL4FpckVngSRz64PkuuirIA82OxekexkTvHXAOGfIZEYbo1Y8ky+BUFSkdn5APmBqJCwDiA/64bQxpzHAv5QuMKvd9fy4+YE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6642.namprd10.prod.outlook.com (2603:10b6:806:2ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Wed, 13 Aug
 2025 06:06:04 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 06:06:04 +0000
Date: Wed, 13 Aug 2025 07:06:01 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
        rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, baohua@kernel.org, shakeel.butt@linux.dev,
        riel@surriel.com, ziy@nvidia.com, laoar.shao@gmail.com,
        dev.jain@arm.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
        Liam.Howlett@oracle.com, ryan.roberts@arm.com, vbabka@suse.cz,
        jannh@google.com, Arnd Bergmann <arnd@arndb.de>, sj@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v3 0/6] prctl: extend PR_SET_THP_DISABLE to only provide
 THPs when advised
Message-ID: <0f8b7e64-d08b-44d6-8a1b-2b4b8d64cbe6@lucifer.local>
References: <20250804154317.1648084-1-usamaarif642@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804154317.1648084-1-usamaarif642@gmail.com>
X-ClientProxiedBy: AM0PR07CA0013.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::26) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: fbdcc177-76b7-49f3-1f9a-08ddda2f7c7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9KcOxDAoBa/Oz/bZcA1MCiUmaJZ6TLxKcj9Ja5uRKZ9LQ7ko0nwXB56sj/8a?=
 =?us-ascii?Q?3ExMdlqq+5eNqq8yDxb18OKg8i24NjU+aL+pmJs3CsmM7B0r/Zi9GqiSPlV9?=
 =?us-ascii?Q?kyHCwOeDKe+s3rzP0jaU7fN6MLOj5C2H3X51ScneqvoKj9H8QHskP+ZuoC53?=
 =?us-ascii?Q?6wcflhB0R9RV8B9a91FItFDP+53G3dj0yNwsTYMfyX7/Ay7NjailiNiZuIO8?=
 =?us-ascii?Q?iFIUaS2N33Qc7qvCutAw1a+bB2UXceXNdmaEdHEeM26L9KYGw4UMmhNJim6M?=
 =?us-ascii?Q?CsoYM1QQXlQ6D8Aa6Kbk5BGDbqzYh6/liMUdFZ5sPMhGQuTRR57UuWk9KwyL?=
 =?us-ascii?Q?8eD47Gju+9hCVsEml+um3PwJ5wyglTnbrhF3tE6Gv4/ql+R3zPj1L1VukV4M?=
 =?us-ascii?Q?syQpOQDa7S0U+IlCh7oMUYmNCeitL88QSe4CpXS4F1oLzf3lVu/xZDy1+y2I?=
 =?us-ascii?Q?JPMh0ioRGas8UH3jBe0HdnwapMvJZlSWwVIujegxRZYf9Sq86Af/Pnmnfiy/?=
 =?us-ascii?Q?jPMp3zyIf2R6JfnLo4ezXeEt7tP0IDM0c6s1jnkNUFAD4GybVfTtOhwOYicd?=
 =?us-ascii?Q?SjR3MyBQdRjRkpcvFi7s4RNiPGXhsylpNcqNTskWw3NwTVXaLCaJVmmzhqGi?=
 =?us-ascii?Q?0UxU7WWr+r7d72vRlCC0w01iCyOW1+JsK7Ur7URHr7R8KWKpqVZ+B+Tg23ai?=
 =?us-ascii?Q?phLeCw4iXMxMiyfTFLjWAYUX8i4igR/AfRilobPkVFkV+GP+h4MYXiun4YU0?=
 =?us-ascii?Q?h11KeNS0vaIMj8z1s9dZbqA/vYQIwKJ8RhMebu685jr6dBesSOP2li4sSxtG?=
 =?us-ascii?Q?mt3XTsSuqAA304x+gs1xIsr//zGRLMYj+qn3lZnNBX0YVk84QEThnPC1Jd1I?=
 =?us-ascii?Q?ulGYuenKZlU7LEp8uO/9qZZsEgR6w9cl7Q3ovfXDnPI/I81xkEo5KklWY/ty?=
 =?us-ascii?Q?AdH+HA1eqgZDkwQlonW2AbUt8PMAV0yfl8xek9kZEle69vxK3O1gSWgfjE6c?=
 =?us-ascii?Q?UD7zXFRTfOrKpxbTfn+6q68XItsqkViveHxq9Z+/cS/THEYifrJ4Iw4hFikz?=
 =?us-ascii?Q?jM4Av9LJECwb9t4JrHPMLBbisA3YvnDMp8WVFvvtK64dQcW81Q4Gi9Aw1tAM?=
 =?us-ascii?Q?tdLjEakfrVzsDLNeeMN0v/D01wV4n2SW0o4hNgMWOAffLrbLPClyt8zrDMah?=
 =?us-ascii?Q?A+im+O1vlgkQWXIuYcvlDPZUBihwWDyq1A9t6zNXfuwgMpXmq70MJKxu2nOO?=
 =?us-ascii?Q?ibGlln4WaPp2XnDFi6da750m+s0DvmEeA6UN0p4vIs9F83blXdCV0RVLP085?=
 =?us-ascii?Q?9kMhBWTRI4G/M7e9ftoAOOkmMirBu/M+EU5TJdBtMa9ogwIMKc3kLxIPPwWK?=
 =?us-ascii?Q?ZjQP5jf32B0FtiWLlUADJJK5LcVeYtOTmy7WxERjhgLSXUeHVWsG7Yquzrc/?=
 =?us-ascii?Q?VnnsWODYaPQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AeWlrl1wKWyq8qBZPqIDPsYd4EuKAR2w/SOU7KqLp0jSFnQOvH0zvtTXRCsU?=
 =?us-ascii?Q?kbZBD0g8k8WCLuCB/1JLuK0wp02bxVitls3DNkKi9/JajCEMNJ/wxPhGkhU9?=
 =?us-ascii?Q?7RWR9KPpMLFtLWDL/ip9+iyoswWNLG+2/MJIFT1Jti0RC2Azgl6xolU8Q9ny?=
 =?us-ascii?Q?U3s1XhHqtWEHkfnmGcRhKAYJw1mGoxoIfNwDRsluK1T1F1g3j90T7Adeycb6?=
 =?us-ascii?Q?UuyiIX8hZ305pFkh3f2jMikgR1UiLkVQ7h8+l+ru3yGwnsfyf9ea3kslHate?=
 =?us-ascii?Q?08O04VWmayFLPk6k3O+OYtF8FqgZj4xhvn/pMWtNlNR67oC2LhOAhvifhmx0?=
 =?us-ascii?Q?3yxtu9s+ZC3wk4uJ44sZhMNg1Uq57kS/cfvbFKt+SSYK4ktur+BHkpIsGSxL?=
 =?us-ascii?Q?pwwzPUd5luTi2dgc4liP++55stLR1vP0Ce77Y4KXkpK3fv2Ew6x9XqhYZqky?=
 =?us-ascii?Q?dwaRkU3L0uDEHFAI4tzvg4XUEx/kHJzzsuEU9/WHygmOJ5cmZlnKlCe0RRN7?=
 =?us-ascii?Q?Vl2g08lFqfHI1vc8ykrcWTEL5TmV6mfQr6CSRpFLOA8PPQvK3cn8dJ6S+qWT?=
 =?us-ascii?Q?QIFWJZWsCAYQ4DRm2nIzlvqP8do3yCpFd9Ewx9EdGuXoBofjCMtupCNxkick?=
 =?us-ascii?Q?io8J6ZdpWuFio7LR8BGKNehKzr9zXDEizOK6xGqeeWTUswdFQA1QNDZ7Nxok?=
 =?us-ascii?Q?3zMaJyotvuOJxTeuB5qa5WRgW8RLfNKpCBMTfwCThx5iGHOegrOMDuyMs2c6?=
 =?us-ascii?Q?Kq0XqUT3ncTAhOgog1QYqOMdD6U9K3B46vcYu7I6vS+UD3tZmizGsY8ZKqFz?=
 =?us-ascii?Q?2LdvXquoV9XXavsw2l4ftrXAxrzBVh+3GRhQCjtP9aOxJeS++uq7cuEhFkYs?=
 =?us-ascii?Q?vDeLEIV+QfdXxCkBRq1t76rY62VU/9qB9F47yavuXWKLRHEOvEF6fJgYWNDC?=
 =?us-ascii?Q?l+CqVUSZ/arqHc7HTd5/ZlrY0aXitewzA/fC2eIjU1brFJj9kihV3dTBglKU?=
 =?us-ascii?Q?1gjih3UFTVi6SwWCfvO1pSL/4tZzDRj5TaazYAegNAFcjlQqlCfSzodusifu?=
 =?us-ascii?Q?QLWu6BsfGeSLnGW9Mbeq0PgTtY3eZEg3EYyvYMIS16Pz920zp/PFIVKuJioa?=
 =?us-ascii?Q?bMwgoPMoGP3e6e/nbXZ5uljIfSU9kaJ2LW9gNngDHAgBp1Xy5C3nY4S/mkny?=
 =?us-ascii?Q?uTrJPfGtL33tOZ5tTQvOR3z63qc0ArkXRtSxpa0vf9bYWYUvGy5XnaqopVa4?=
 =?us-ascii?Q?L7siqsEvnuk9HEj+2IhvXOa9TJZQctsUcE2u46MjKpgeXrj7F9c6ojlFheIZ?=
 =?us-ascii?Q?9gVjKCZfKhXyP/Bxc4NzNNik5h8lBJZle+13DGTmCIANyFZ4/JpNTM3xZoh4?=
 =?us-ascii?Q?3xiMiea0G/d5N4wl36V0rsi+SO7EVizM8yFCiPnF4c4oV7301TiJ0mDphwzO?=
 =?us-ascii?Q?emVwVGtkBcEa1grWaTHu8od6/BrgCChTfTpQ8h4nhewQTQ+71u8Mm9zG+7sH?=
 =?us-ascii?Q?8K696zTALHiw+1ue/5dsKNHFyHtTAvEQ+ueg0pvsJBfYo85HSSzrdml849JF?=
 =?us-ascii?Q?Uv5LcG5BYSvsc7MfxBO030TsLV6wSiWw72huMxACUPoz60wEAS5WBQOfxsnV?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QiykNjTTR9flVzsGKMbtKHsEsCfCL3sQX5Ouk9zq+zA/0LQj+nducwPbcQDsU9lGo7WhWx7hTzBM/2wAgG0zetRbFFYBxOBn5Qu6b4NvBN/XXsSq9kfou5qmVSD7CZcM5/7g2HpF5VkVabUm8i3kfonuWw4CSyCJV1oxNw0TYjBStb7qJkzyWYeplGlZT3oze3FSmExbMs9nw8Um3p9aZdxNTknMeNx0ytPlFN75Q2yeHfllsH30/Lrtd2ZMZW04L9JSrEdCRDG6cMN3GWCqOMjfH9E2j3yDptvUUf4Ab+76Tmyyl6X8zqb9cRUjojsbFIAqWj22qKftZ5gjQa/3HNVBFKSAhGASnks7y3p6U3f+IbCJJZeVcAGHzJS8va6KSdRpUWh6XbTtOTMQxaKINURrkLN25nhrn4sae6oKFBZMJjhtAcSkizhkq6Xq2rsS58IJQBnPLN02k56acFMrDyvde+sZC+8tGB9eI7zDwVhbS/Pefc+sdg93FgFXrM2MxfxibxzISMuk/vMaV0AyT6m8jQtfEwSutBcxBtRLbbeLR1ssmIdjgxdIrDxlw6axBzAKhl8F6JtMBiSxzwzbD2F+D1h5Gp0ZgzrzFQdhJR0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbdcc177-76b7-49f3-1f9a-08ddda2f7c7c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 06:06:04.4279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBjo7L+/Vxt0vhkUAVRQQFIJ9UXt/d6kAkSl3phOeWhcq/ZD+W+6TZ1F0XY4tzThx1PJpBLCpg5eBr6ZrpHtOw2/otQKW4zuMAV5bWypzAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=814 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508130057
X-Proofpoint-ORIG-GUID: 5izKkXSSe3OQd-AcIDJ5Z4c6QSP3sRKS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA1OCBTYWx0ZWRfX2H6s0ynwLqki
 4iiPW4p2MnOkJL6Ysqz0MSceFsFXOaM+Lp4RBj9NGFHGMwQi+i80bBMbndZkxuYr86wuNBndtA4
 7FGlqOARrFGNQc3ZbDd02n60I8629/19Af1AWhm5oKEE7iU/AK+TaDKiD/ImVQcy3HridKeDikj
 QR9PYzOpAwJi1iHAzTjyUOvhMlxVICa68g4Zo3kVqkK0M3CwT5lPjpG7sTRDTUUzx3OQHU34BZO
 HigD5NFdvXjAmvaAS9VRYI7cbEsK+e8meiyNgG60sINxiaCWWxvCsujvSvZbG0gzK4N0hTTLcyO
 b1n8PWhN+DWc0Oc1s0dNOYYomBWGEdQz6l/cyaT+39hcFr4P5XkRHPPlibSYGTWqArGkScmwJLT
 hdc6yzTlDIMCLDOoNOvstsH4SED6E1IosA8gJgCeHmTLc0MLeuUaLwWiYR9Lq9kWgjOhEr7+
X-Authority-Analysis: v=2.4 cv=X9FSKHTe c=1 sm=1 tr=0 ts=689c2b50 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=9MWn6bUuaF_eMk0hTXwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 5izKkXSSe3OQd-AcIDJ5Z4c6QSP3sRKS

Usama - did we plan another respin here? I ask as not in mm-new.

Also heads up, my mm flags series will break this one, so if you're
respinning, please make sure to use the mm flag helpers described in [0].

It's really simple, you just do:

mm_flags_test(MMF_xxx, mm) instead of test_bit(MMF_xxx, &mm->flags)
mm_flags_set(MMF_xxx, mm) instead of set_bit(MMF_xxx, &mm->flags)
mm_flags_clear(MMF_xxx, mm) instead of clear_bit(MMF_xxx, &mm->flags)

So should be very quick to fixup.

Sorry about that, but should be super simple to sort out.

Cheers, Lorenzo

[0]: https://lore.kernel.org/linux-mm/cover.1755012943.git.lorenzo.stoakes@oracle.com/

