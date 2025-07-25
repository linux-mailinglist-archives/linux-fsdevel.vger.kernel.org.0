Return-Path: <linux-fsdevel+bounces-56013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 257DFB11A1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 10:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C3D1C84093
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 08:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0352BF3D7;
	Fri, 25 Jul 2025 08:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GWFADk9A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fZx5VnPY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EF92940D;
	Fri, 25 Jul 2025 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753432806; cv=fail; b=FmZuHql9/OfYmXzh0b3aLaec2UPv8rHtdDNXrYuP+x9/Vj0cq3oiKE134f9PzRtG/ACtZG0u2SelCODuvdpeB/acz9BHvPIhxC0SFQ3IbbhZ2wSDhdu3P33jTpz1irE3BdYHzE9bBYLmu+21HlqGRbEiHX5Y8tgSUiGeBS17V0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753432806; c=relaxed/simple;
	bh=svXtg4RVe6n/b8uwf21yt4J0BR1fz46qYJ5ht08usdc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p+2v/5nkx8U1Q0ezoFJ37U3IVMNeeTcTpzOLXd1JOIjfnVDzMO9fu8SYGshFE03k1gxfYalx4W6W8XVdEQWoOM7OirauEqIEkZsGjQu5KlvUSFqpy71Vyn8i5J1xjqSIXmqbeiNS52uf2zFmI/lowCqM9IGYcw76Oya1FB39Omw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GWFADk9A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fZx5VnPY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P7fsDO013058;
	Fri, 25 Jul 2025 08:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yl/GzKv3wB0Vay/+v8X/lJhCv+k8U/rJy5kl5NbkxhI=; b=
	GWFADk9A33Mg7iHOxvAQFbN/4oc7haL/dN474a6NL6fSvI8a9ZEECaRCU91N+UGd
	VbJ9q7bZRBYxPH/iLq+OkHaOFrhDe/PuetFX6Oyg8Uu74rLtMXl5HN1BOLEGeRqK
	KguvYlVxHbGTm3nvQF8Pz7j64XpnX47SJBaNwIpAG/eRMxXtw1bqBVrVAauzWUIc
	dzFSXl79blOPyZsI106lLRocbd4RBlH6X9va5o7iQLFmMSu/4sIXR3LVOKakwcKC
	zOU1varapC+hDhc/XX/2CNBQMkkT5vf3b+EcqZbTWAP5jVPaaqZCJp3R6Z6y4Dek
	NWvzw8Wh/un1nhBZNNgPEg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w3wgn8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 08:39:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56P6mioH005752;
	Fri, 25 Jul 2025 08:39:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801tctrjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 08:39:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiizXnR7RtcGUxY9NCQFxclDSVFl1CMhYNFOlIe/XxGKBRfOB5oO5lTT/UJQvhoPlHXm5tlr7csbK2V3LIWzkd43vwq7pRZzeqVIrnhl/sWRZYRAjoxIUDwgV0QB2XJ06HuUD/82GProOmXpK54k31+lF3NC6j1e8T38wu+Yy8TKlGLWorvpCjIcfBBL+SsoYEtHENQG3FVIKv/QghWNKRD34maDbq7M5G0cA8tqj8V1J8EJSfqsEISml5zUluK3YVPn5Tk3HSqhWXB437Gg1H7fq9VjQTXJmYueQZOl0B2bsV4vwbDYOASuoZHEqiYYBwbcJjNHeksmyyJWzoXMoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yl/GzKv3wB0Vay/+v8X/lJhCv+k8U/rJy5kl5NbkxhI=;
 b=NJYEiR48nWwDp81EboCK1j+2T51EALSV1Ogb+DljIrZNFAr5j99li4kYamm4EeHbI7o9zGJbj/4y+uGnZEPp21c54JS4y1jQBoa4cSN2Mlipy4S5txNFMaM4hVCXSgBpbeWg0CgFXm3AHLY3E+jgOfinq0BBPeyikL1w8l8g+MHVWZpxQV+vis5g41MX0y4I9OjGCWpTOJCKNHZyKLiOApXJXwx4QZNS8ne8Vasq+9ZlTYjVmrA/g+gARJhpVfUWoo2EDeHQUSYQt9hGw4bw0HBT/2cqhcSATFgis394tyabAC2cVAbko8R8h3pWn6BSlXPYgYR+u0tWOgD30uOyEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yl/GzKv3wB0Vay/+v8X/lJhCv+k8U/rJy5kl5NbkxhI=;
 b=fZx5VnPYk81KNqZZYRcXj6nRYpOkyYcUESlgK4SpRder9QJMKRvq8Tis+QFh4rUCRdrLMjEXmRubaqWTH2dIEargr0vEdG8c65xss/xhGet5xl3kNOrnWLeS7AJlzPYAXvLb5KRmExGJNIb+TOXxExWHXO/9KRK5SNrOjrno4a0=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CY8PR10MB6801.namprd10.prod.outlook.com (2603:10b6:930:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 08:39:45 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 08:39:45 +0000
Message-ID: <331e38eb-e8b3-4ae4-9c74-81c79d6ce3a7@oracle.com>
Date: Fri, 25 Jul 2025 09:39:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] xfs: reject max_atomic_write mount option for no
 reflink
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: hch@lst.de, cem@kernel.org, dan.j.williams@intel.com, willy@infradead.org,
        jack@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250724081215.3943871-1-john.g.garry@oracle.com>
 <20250724081215.3943871-4-john.g.garry@oracle.com>
 <20250724163206.GN2672029@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250724163206.GN2672029@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0338.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::14) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CY8PR10MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: 81830f3e-eb2c-4891-987e-08ddcb56cea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlh2ZC92M0NPeWlxMnRYcmVyUTZIN1Y1Y3hIWGF3QnpiYVNoaDN0QXBISmVJ?=
 =?utf-8?B?VmoxYmp3cEszT2cybHZMWHpXTXJ6emdmQmdXTGp4RnlMNzFBRGxLbjdKdHh1?=
 =?utf-8?B?TTNhVldZdVlrdUJlKzVVNzBURGR0eWYrZHI2L0tBc1NTbzVKZDhRSnBmKy9K?=
 =?utf-8?B?MUJEQ2VtU1E2dlVlcGJuSktlaXN0MjlHMjBmK1JCY1BpTk0yMDEwT1k0S3k1?=
 =?utf-8?B?aU16NThKNk5BUVdMS0s1VWw4Rk1IWlRheDMwQkt1eW5TY09KT21KWE9BSzdx?=
 =?utf-8?B?bVFRQjF3azdrZWtSd0tXV0ZOVjlvelByZ0xYdEdUYng1d3AxaDd5bzRZcEdG?=
 =?utf-8?B?eUpsaHRJRjZlOUViUCtzU2sxMDZ5WDFwNzFwVmFSUUZSYVUwd2kwTTFxVE9Y?=
 =?utf-8?B?VCtnSFN1dnBWeFhOVTcvNS90NXVnT29vN0J0SnU2WGhOTmMvdVRDRHNmWDN6?=
 =?utf-8?B?RFM2M0MyNXJHNHRzMEU2WkxyRjlIb24yNEdZZzlTZmt3U1RUYU5wcnFMbFhX?=
 =?utf-8?B?d0JQclBYY3dVcXRxcGd0NTM3ZEpaVDJsOXF2UXl2eFZJSzhacHFWbitOWEJi?=
 =?utf-8?B?WTdKaWszTUtkV2tTVEkrMUxCSHkxaU5JWEx1S1AwU3RSR2VrZTJtSXFHQU53?=
 =?utf-8?B?UUhqWjlXbkYxVEFBWDFRdWxlZldRa0pPWXZLQnhnWmFsb0FQZEdBb3ROQ0p1?=
 =?utf-8?B?Qnh3dTJMT3BIOHJjekhpVFk5aDZibDYyVGZ0S3lSTWtHVi8vajJFcm5aT1NB?=
 =?utf-8?B?ZkhpQUlOd2JLWjRJQTdiU0JVOGl4ZEpVcWJMZHNlRXJxa3ZIOE1McFRrSWE1?=
 =?utf-8?B?YnJjYnBWRVI5amgwZy9NYytTejlvbG9aSmdGSkova3htdEJ4TlpEU0IvS3Fy?=
 =?utf-8?B?bVBYK2RTWDlrUFJPTHFCR1EwZHh6Mll0bExWQWtsVmlycDcyRFN1dXlwQmFQ?=
 =?utf-8?B?NnF6MGdKUmprV0x1YTM2NnBXc0xnTWdwQUlVSDFPMzk1QkM1TVNrQnhHTXNu?=
 =?utf-8?B?aDBibk9KQVZ6ZVdIeTdiZkFkRjF4ZHdWb1FlK2Nib3pKSjVmT1pkSzRlcGRL?=
 =?utf-8?B?Z2hRRXFXdVVCOWw5b0VNWFc5bjZxaEZmWEZ4bVdrYmtEYy95Sk4xaENhaVdN?=
 =?utf-8?B?Z1R4ZXprWU01QW1seTJtZnIrNTVjSWU0RFIrUWZNdFJGLzR4ZUVNZVcvandi?=
 =?utf-8?B?QmpETThMMmVKZlN5OTcvZlR0L0ZkcTdMYktjN1l5bUpsMmt1WjZHUkE2Nytr?=
 =?utf-8?B?RUM3aHdPNnVCVzBJMWtlVENjbDF0UXp3ajFMdW8yU1ZWL0VwdzJZWGx2WXNB?=
 =?utf-8?B?UnQyRnZ3RlhBay9yUzcyZkpWSGZrTEtXUldoSFRpdFdEUGhDcVo3MHpBTGt4?=
 =?utf-8?B?MEFzOVE1WWNhMitmRWo5U3F5NnBGWjJ1TWxKSlpnRC9KUENoZlcxeFVyV1Zo?=
 =?utf-8?B?b1ZnSlpVSHJvVCtPUzkrbUNVVmNDMFVLRnBQdXRZbjhFam9reTUvNjZ0S2tS?=
 =?utf-8?B?WGN2QSsxM0hnc1F3Q0RUMXRhRDJkQk15SWRTSFdhT1IzSVp5UVFzNkRQNXZV?=
 =?utf-8?B?R1BiN1pEWW9sbUI5NjFlN3FFRWIwZHJJbWNDcWFFdWZ0bEl5Smw5dlhucVdj?=
 =?utf-8?B?UFpCc2pRSzF1eVR4dGJweHd0UnZIRXJPWDUwTGNtRjlsYkxFZW9lblBZLzR3?=
 =?utf-8?B?NTZNK1FmUHVIUWgvaElNV1FJR3BsZ3duWVZLTDF4bk1QZGpFT1hVVU1xRXVv?=
 =?utf-8?B?M3lEOXM3c0VBMGEwTGZEQWNFcnE3WWZ4MmVXZ0o3Q3kyQWwvVjRDVWIrZFpp?=
 =?utf-8?B?RjYyS0RRTVhZYTRVZXJjTTdNS2VUK3d4YkZodTF0Uks1OXBaT3VFeFpTaFRM?=
 =?utf-8?B?UW9yeTlQZzJoT215TUlTRU5SSFpMS01QNldSaU9ib0xmZnczYk9ibzRydCs0?=
 =?utf-8?Q?BzSwuDqs9gM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlVZV0pmdVNIa1k4Q1VEeGoyNmt2SjliTE9qLzVBZGdiVkdiaUpGRjFuUDVa?=
 =?utf-8?B?cjlqcDV1dG1wNFhTcGFJeDJEOGk3WEdTNFZKRHMxUnpPOTF6aVlTYkxHM2pN?=
 =?utf-8?B?MXBJaXhWUUJabUloV0t4UEYvZHAwNmx0Wlh1OVZrRUdtUGlNSWhIcnlsdkFO?=
 =?utf-8?B?TXZHS0VZak83b0UzQkNlRjBOWVZucWpFTUw5OW5RV2NUU2JVR0JkMjhxbkhH?=
 =?utf-8?B?bkhITzd1cnNrK0NmSVQ0ZkJlZlRoNTRaRVFQZDA1ODhoRmZCbWdhSmNXaGNR?=
 =?utf-8?B?TU9ZNnNVRlloRGpBYjQ3TUpSbUhzK2ZvZnRsL2xjSmo3QytmcWtnZjhXNTB5?=
 =?utf-8?B?Q3IyMWFBT0FSeDNFdGwva2tpVUZtcDJJN2FubHMwZXBQS3pKZHl1VmdOd0k4?=
 =?utf-8?B?NHhQMy90MGRTQTJ6ZjlmMktzRkZ2OFErSGcxNW43bzdRSXdBckU0WkVuRlZv?=
 =?utf-8?B?NUh6UG8xa3pQUExFY21VazFyUkRlYzhXc0N1Q2pWa3psT1pMVUs1R2p4UVJQ?=
 =?utf-8?B?YWlzZDNvM2ZrTEtQcmlmSXEyTWF2eE1KRTBCcGtsNHZpdHlNNlc0QnhEYlc1?=
 =?utf-8?B?YXRDaVJsd2cvSGQyNjFYZzd1MDhvV1FWalFVMzV3L3BuSDZPNHVTSFZXUS9s?=
 =?utf-8?B?aGsrRUMxVGQyZE14dXh2T2c5Y1dWZ1BjSFZVajM2ZXNYUjM1NTZHQnhJbi8z?=
 =?utf-8?B?SGhsWkczVmp1RFN3VHFrRDVqOGN0NVJTWHA3c1dSQ2ZCSnJ5Nzlxc0dQOEZB?=
 =?utf-8?B?MFRTQlBDMENQZHlma1V1djgvTkFBWG1pUTQ5ZFJzdWtmS2pQdkJKSkFaQXhE?=
 =?utf-8?B?VGRkNk9CV3cvMGpEek5ZZVVxajhLTjdNeXY5UEZEQ2NuU3BjQmVFakRIV2Nx?=
 =?utf-8?B?aUs2VTZFWm9PUzZCNzJGZHd5a29iM2dmMjVwalY0MXpnQ25EOHhJazR0aDVT?=
 =?utf-8?B?cGhUeGxaTUhjUXZHanhaS05GdGtreXVUY0YxbldYbEV4V3hvcXdBT0hsWGNL?=
 =?utf-8?B?dkZzNVNvZEcxMmUxTGdTWkVwMXQwbmNjNnBQeEhLaWxNSnp4ODk3dTU2Z3RZ?=
 =?utf-8?B?SzdyWDR5ZjlEbkF6bDJScHQwZnVBeGt6dCsrYnJBY1pvQ1J2UkhEMDR3K3di?=
 =?utf-8?B?eDMzSEFDZ2JRNlJhWmlwT2QwTWJGRmtNeDZxYmFZd2t6bTZ2MG4xcmk2N3Z1?=
 =?utf-8?B?bk43VmV3MTR2UGVuN0F1SjBnK3paaXIyTng0UEtWYlFVQ3B6bThEa1V3a2s3?=
 =?utf-8?B?bVhSejZKL043MHFVR1Fuazk4RUFqaGNuelE0OG5ETkthdVNwQ09OQWw1dVpY?=
 =?utf-8?B?d1J2SmF2WjQyLzZSMXdCai9BaGZTRW0zNGRaTVBrOEhGdHFPcElMSFQyTmRi?=
 =?utf-8?B?U3l1UXpPWkl6YWQ1ZXpER3hzcUJPL2s1MGo4amZ4YXd0eWx2YlZsN2pjU2ZQ?=
 =?utf-8?B?VzdFU3lqTEs0QUgvcU00MkRSWi9RNTBib2lzNlhzQURWaHd4VVhiOS9rTDJY?=
 =?utf-8?B?eUUvcXBiRmR2eE94bitoNDNBbkpCWjg5UEdXZVFRV3VFMnhrVkp3aSs3VUVL?=
 =?utf-8?B?ZnN1ZlFQeXArREdpWW1UUVFqMVU4bTNDV2FhTGVObmlSell2NEFNNVhrU3dM?=
 =?utf-8?B?Y2hiRjc1cDBtY2xJNGhxS2hBYi9SMmpjWk5aQTNkQmJiMlI4NG5BcTlVU0Zv?=
 =?utf-8?B?azBWSE9RVzFyRlZYWlAycFlmTk1wVGJ0WHhPNnpFRGo3SWxZdUZEbFdidGdR?=
 =?utf-8?B?S29HVk1BRUFPQ0Ixd3Y5aVlXdEVxUFZ6am9UUzFOUFo5WjVEY1c0WFZjVC9y?=
 =?utf-8?B?WXh1aWo0dlNvMmdsMHg3dmlNV05jbENiYmNNV0lUaTFIZ1oreUV5UzdlbGlB?=
 =?utf-8?B?eE9LWXVMSWpUYktCL1ZVZGRoWFZTend3Zm0vVFF5RHV4MmlGeDBJaU1MMURC?=
 =?utf-8?B?L2RoTGRzL0ttM1R0dlRhbENIQW1yV3NweE9UbGFtWERXcVRXTEhEcTBZeHhZ?=
 =?utf-8?B?Wkc3eUNlLzdJTG14QWJoQis4Nmt4eWtBbzBid0t4MWxNMVNUeENtZkd1bmdu?=
 =?utf-8?B?SXpVeVRieTJXeit0VjJ1TUpjQVcxalVEM0RWOHhFV1dueU9iN3RvWWpBd2VW?=
 =?utf-8?Q?SvoLU9fq4Vr5Kg0qCwSAmJhaW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A2/A1n95hyv6p6StiwX/LcndYV7nTwIt9eb5NInlesnH0+udJtrCVD9UYj94abRqJwksu0Sqq31gEzjUqIg8SAguYDDw41LazgOVcfGfCuS+2W1n7u3WJjspcm0UtncqiNRr0bEHVGscqe4ZZPLn5x1FO/WJ/06fw3BQJiSaBiUh1CS3AEO1j/ciNIyHQhWMPuH7CT4oqCJya3d6JqWy6Cd1Zq7dfd/OQi1k0HHu7sfX3TH+OBUjVIKG5eNr48i8yQBqZOtGfA31U8uQTwQydQbvYw84NKvHqAKmgtJ2N/DHk0wS7LRz5coqysHpOmpLEb7+QxdzPIPd51z9mmn+EnRlwzAyaFom8HlZIE7nx97qsRaP17LgB3CbAt0X5Tg3vlF3fPddKPd3GPCtm8g7cyJIqhu+sXXvIdA8h1CgRBRge6U/9SgNOf07MOL0T6LTGzwWH+aEkHkvWaICYHXCvkpC+Z/jIM7Ci7L8ovxjhNEWlZ5EDpi6xJda6MxbrjQFXotA3qQB0ageq3TdI3np2ZjboimwPb5AO0Yiq+3C/CqH8LdMfeirA4fdGAumnBOJSx7T/ccD/dxvCEvXRSqBGNL/L3B8hWVBp9MRCMdrnWk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81830f3e-eb2c-4891-987e-08ddcb56cea3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 08:39:45.3954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xg1Z1H4xqxD1fDX5cPwxHCohuamcq8PMgaCKi6GXk9DSna6FyVPHtj7y6l1YzX8cr0yJAb+1Rd8p1zRgemDn/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6801
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507250073
X-Proofpoint-ORIG-GUID: KLQoHtPstjGGyeQwnZlv-CalCJHTrMiV
X-Proofpoint-GUID: KLQoHtPstjGGyeQwnZlv-CalCJHTrMiV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA3MiBTYWx0ZWRfXzI7n9/0JcNOK
 VUafLsGtYK3iKY1DG6LBeE0/yNELxRfUBmGFgmodYldmxnusNZl5cSuI+oUq08LCSoxfHLaGtKh
 nQQ4NbKlR+QG5Cf16KsEyAQzm57JZJruziqTMlkxeOa41PivJO62KWoKZNgSqGB0ET6I3zmPKrO
 00kSEAOzQLFyVL1a7TcubJ4qT4jkwERCV5RF//FEiI3Zga/mrv/vL95tCupD+K0q3MvcZ7VZZuT
 agnq39X8InoqYvKyX0qHwNsaAxcUO8sbbzVKblOrhyz1JfaxyzOh7s/Yq0EvhvnW9rIQtVJZuln
 FED+9oLILxGPlN0S+vSKu07SgIOhHrM37/I4FzjZZCpnyrRTTD4wdDvHFIpVVTkO+l/55XdcwD0
 vqozET+Su5Q/GVqSLBzWst0yoWcdBGs43GneLYdzb7Bsi9jP0xZowppVPVilB4yGA8rAXW/W
X-Authority-Analysis: v=2.4 cv=Jt7xrN4C c=1 sm=1 tr=0 ts=688342d5 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=LPKFrM2VyBfhBsVnjY8A:9 a=QEXdDO2ut3YA:10

On 24/07/2025 17:32, Darrick J. Wong wrote:
> On Thu, Jul 24, 2025 at 08:12:15AM +0000, John Garry wrote:
>> If the FS has no reflink, then atomic writes greater than 1x block are not
>> supported. As such, for no reflink it is pointless to accept setting
>> max_atomic_write when it cannot be supported, so reject max_atomic_write
>> mount option in this case.
>>
>> It could be still possible to accept max_atomic_write option of size 1x
>> block if HW atomics are supported, so check for this specifically.
>>
>> Fixes: 4528b9052731 ("xfs: allow sysadmins to specify a maximum atomic write limit at mount time")
>> Signed-off-by: John Garry<john.g.garry@oracle.com>
> /me wonders if "mkfs: allow users to configure the desired maximum
> atomic write size" needs a similar filter?
> 

Yeah, probably. But I am wondering if we should always require reflink 
for setting that max atomic mkfs option, and not have a special case of 
HW atomics available for 1x blocksize atomic writes.

> Reviewed-by: "Darrick J. Wong"<djwong@kernel.org>

cheers

