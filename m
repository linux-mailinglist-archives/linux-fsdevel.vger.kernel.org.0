Return-Path: <linux-fsdevel+bounces-22621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A8391A625
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 14:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD94E1F2124B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 12:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFBB14F136;
	Thu, 27 Jun 2024 12:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cZ87delw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rjJrCUEQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C660149E1D;
	Thu, 27 Jun 2024 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719489970; cv=fail; b=LElVyv/Zel70VhArCEugrI3w0VAON4ahoVDH7BxbAWksYCnQE/PPxSf6cNMbk9YF4tgISzQ8IHvoX0YGQPCG6IVrclonuYgWnuswWp6j/MR+KNAGWu0ew8B9BHYlh/uMZnmKN7f9JhXQAWk14vWgrKyhMuf5/tvD5f7vfivkdwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719489970; c=relaxed/simple;
	bh=pDZ0FpESAC6h53aFTrbZJFYo/WnPkicWcRe2gEkkCMM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lUxaB6y8jIXJPNowIvXjGJicNv5/ZRu6s/ZD1o9SGR3CJ/WWTwFtAE6fAtLoDFaTkpq+L2IPL6t7fAnQqkafjdvJA1rxEPJNHK5qLrtmpRNlbGKaELcxvY58raQ5UmcEU4+8eHGL5pcCyINGqCA4BUwPuaEt5T1vDtGAaT2i+0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cZ87delw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rjJrCUEQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R7tSBs009932;
	Thu, 27 Jun 2024 12:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=d6tZEQzo2x4wzI5/XCHNcWIZmw2uevqDZhfZgEKTstA=; b=
	cZ87delwvMOBgCopZmtS8+QT5AvyBDtrVF7c6LTK3xFasTgTkjmA/I4Hau5hrSO6
	+2uUkHjqnAEcsPuC/Ptj+MWfGnBnxeNSKuN1eQLsTbNmVXKSy/0kUnwIHSp+8+XY
	xB6bj7nymIUE+keRWssfVRFwQcIP6t10mxljBrTMpcEA0S6tRsUDkGm/lXBYj93w
	BEtq1alzF6h5nPqKL5wIGzQcajcUp9snCgIkbQwbPeIIC6NSUVQvSjtNLD/bcPhe
	2qN0iwIRYFIs0m26JOOodYF9ZF+4uKMbY8w6qnDPMZWM95ceAQnZdTUmrOTQX+qF
	biSl+GF828pacovKOVmmqg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnd2nw4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 12:05:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45RBuAQ1017844;
	Thu, 27 Jun 2024 12:05:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2a897t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 12:05:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=du3yJIKaoOo1BYVggMNUypgP1Mhk+b8OJj7A1ruktvS8THpWUQf3jux3xqLkM/xb9KiSXIrU75tpkuZ+fSwH5BSFzaV7/6EUCUw0xUH1HlxkgQ+CJKvaTJuGW8wI3hJ9p9P8zD16n3JuurR4czzSxnPwrPrO1bWuvj2B61He7+mE5q/8Re2VbPX6i7yocur9UliaNSBY4rU1BqlkojyvO4MqnGb6nD36+vlDT1AdpwPUDYrcrqGYEvVfW6V86Dy0auRM2X7gdviYG5TyYm1a6ZdM7m4jAWHTuFLvFoEu6aE0vugAdbjEB2tGtCuU9EoDutuIljq9C8n05Ns+E0l7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6tZEQzo2x4wzI5/XCHNcWIZmw2uevqDZhfZgEKTstA=;
 b=ZlKuQIvc8oz/Ws2WBdPh3v+Gs9TrCHQYf1bOagkvaQmqI2VW056ttU/dhAqQgDgAGUKIDadwiIes54Z+OxKVhO5f/py/EUxBwJpNBr95gRn3zdaTtiwj+nb1oW3eBsO+8ZEVJ3Wfp+O4Q/tAbG0828XzIiiKCitUzaAatrMnRGVVkDDa8uUOjA6PCNsLXOO/SnLSlwVZI/RJTMBBnS0IXS+qmdF7X6c7p9v6TAB4cmyUmdeQcEfWkPRHw98e9If9GzmHCQ13kOQU52GDG7SJZjJ1LD+8VaeZkiJDKx3LhZuGdqD2ys2bZTeM+LhlyHEUu+fIAKXcKCiKMmX+sp4GyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6tZEQzo2x4wzI5/XCHNcWIZmw2uevqDZhfZgEKTstA=;
 b=rjJrCUEQawUGyj/cAVIVDCrzkHgu8KExJh9rbr56t3Vs5QlKAe593gTCJdle2YzybO+Y1Ui5Qo6mkT51Ky01oL4NKyQD1PviL1VdrMAqE7Ut/FzUdxkB+JZvFIz1+gHgUeQjLIwM8CANAglMVc1L4pYzESPdxGBUKufYhzNs5pw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4521.namprd10.prod.outlook.com (2603:10b6:806:117::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 12:05:42 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 12:05:42 +0000
Message-ID: <4332d711-81e4-43ba-9cf9-cd4db9701499@oracle.com>
Date: Thu, 27 Jun 2024 13:05:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] statx.2: Document STATX_SUBVOL
To: alx@kernel.org
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ebiggers@kernel.org, kent.overstreet@linux.dev
References: <20240620130017.2686511-1-john.g.garry@oracle.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240620130017.2686511-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0102.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4521:EE_
X-MS-Office365-Filtering-Correlation-Id: be1d7ff2-005b-4ced-12f6-08dc96a17795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?R2JOZkhuRXZ4ZzV6QTE3S0ZwUnhnYlRkTlB3bHg0UnZMaFFMVi93cnhDYzQv?=
 =?utf-8?B?VHBGVk9XYmtmSmU4WW95MFRtNU5SckVBY3BkTXJCQmVuUjRMbkp2L01xd3l2?=
 =?utf-8?B?ME80dEMwYU9Ja3dZQ1lONFNrcEVlOWpFMVFqSi82djBMRmIxRitkSVpnUmN0?=
 =?utf-8?B?NDI1M09sUi85bGJCOWFRVTVPdnJjWFN1Z0l5Y3N4SmkxOFlXKy9jZDhQYUR3?=
 =?utf-8?B?bDQ2SkN0YW1RM1o2bW1iaElkOEhnNUZhbEJRSHZBWmEyU1V0R1lJMnJ0ekw4?=
 =?utf-8?B?QU1kYkdBRmw2S3hETnhLWmpZNGpQc1R1MmxLa2JQRk4rQkhNTG4rcGxvMmxz?=
 =?utf-8?B?VDFBMkhocG0vOXhwV29CYXc4R29sUTBKYWNXZmpDclBFU1hPZzNqSk56Y0w2?=
 =?utf-8?B?V0RtQ2lDOVdtV0xwZDJPTHpPWlZjUjRaYXBYQjZqRDBhbzhXN042dFh2NVJ3?=
 =?utf-8?B?ekJHSGRWcnBTQmZOS29vaXhURHlJT3QwNG42RExIWGVIbnZZM3RNMm9rZnVD?=
 =?utf-8?B?b2E3NXhWVUVvOWZUajhLYnZ1WUpSbTh3UGZxU0grRnFCckFTSmNuQjIxQ0gr?=
 =?utf-8?B?QXVpRi8vNkJMUkJ0alhsM0drMGJkdFQ4L3djdUZRR3JqY3VzaEo1VmFiWEJu?=
 =?utf-8?B?ejBoYkNLUnJiL09ZQXpZbDJDUVVoVUFzNlZZWGtneStnS2YrMyt5dVVxcmta?=
 =?utf-8?B?N0Z4L05nS2NKb3RqUnhLa1dFRitTL2lqN0ZvTVE5WGpWT3VqUm4vVzRtYlR2?=
 =?utf-8?B?Z2dOaUdoSmRQWm9CZ0RIVS9FN3Z5YXNyNXV2MHpzYm9rMTlWOXdTY3pVblgw?=
 =?utf-8?B?UnVrcXQ5UUlNOXpzekFHbmVWL3hhR0sxSjhIWHFZU2Z2U0VpMHBtV3A3Vzk2?=
 =?utf-8?B?Vjh3ZjA1K3B1RzB4WkdDN2JsYjR1b3JrUWw3N0p1RXovQmlkTUFyRXc2Q3pw?=
 =?utf-8?B?ZVJTL1ZVNFM1K1lkNnhZUEYwNENMNmZGRU5YY1hQMUJZYzYxd3JnaVhSV1dh?=
 =?utf-8?B?TkEzdDM5ak1lbVhqdTV6L0hmQWZ1S2RrTnBDaUQwM1NQQk1VRWlvYThVQmx4?=
 =?utf-8?B?TFRxc0RsWEVMSXFWZDZ4b1JSRTZHZkR1TGFsUzRUSnloZ0NWNng1WVJ3dURB?=
 =?utf-8?B?T1gvNkVvU2VVaEI0S1pITkg1Y2NwSG1tc3ZTZFN3cW1FdS9iREo5NnA3bmQv?=
 =?utf-8?B?c05hQzdLTldyMjhCNkRRRXpyeDF5ZDcrNVNENUhUOXRWdGlFMWtZNFpKQlFN?=
 =?utf-8?B?eS9ETE5VUEJ6NElRMForam5XMC9RUjI1UUdpeTJhOTh3cWZqNVVidjJCc0Fq?=
 =?utf-8?B?azcwRFlNZzdqQ0hYOFROeGFpaFlnMEc0OWs0VGJFc0RBUk9wYXdiakJOK2dl?=
 =?utf-8?B?T3Vrdk11dGYwUlAvNHY5MVJRbmdhQWVFKzZMVlFQVlh3VktpbTVudEd6QWtj?=
 =?utf-8?B?dmZtK3dEVmFocGt3aXliZWExSzlZRWNGVWRQWU9PRFJteGtUNDg2M21mSnp6?=
 =?utf-8?B?Wllra2lBNlgxMFExZ1MyUWo0UHdndHJWNnVhc2xsYStTbTQ5V0RlSXFld3kz?=
 =?utf-8?B?OTg5czJIdkNUMzhZMVJwdHg5U0RIWmF4ekRZakVlSnhhQ3k1ZWJQaEwwYllN?=
 =?utf-8?B?VWZ2djdkbUQ3YnlTS25TR3RYcWVEUTlNcjE1UmV6bWdDV21rVVhhc2k2WHl1?=
 =?utf-8?B?b3A2c3B5K0V4ekQrTG51STRXOGZvTW1ZRnpHRkdvLy9venpkZEYrbG1SamZP?=
 =?utf-8?Q?NhpMPu9L7umrSQIZVA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YWtHNElHckZFUEVIWlhMSmJCN2tma3dGVDVwdmwrUlJITDJkZkptUDByU3gx?=
 =?utf-8?B?TmtUYUVpRlRUNUxuSFM1TEZwMitqSlBYVnJVSzhXZXZCMHEvQTBkYVllSS9v?=
 =?utf-8?B?WHVWbEovcDdpT2NUM0l1ZXo4NzR2WWEwRzUxaUkzVW00Z1Vma2s0bDRzOW51?=
 =?utf-8?B?V3hHUm4zY3JHejY0YmprQVFKeWNGYS9CMldxWTBhbitPQ1pKU04zQm5XOVZF?=
 =?utf-8?B?dFo0UkYrOWJNNWJRVWE2ekJuN3VtYi8xblpITkNNUUFNc2UrbURKUzArOWRW?=
 =?utf-8?B?b2pyNGtiZThROW5xRGU3SkdmekFkajM2SFA5TmNLcFJ2NlRtZE4zd2JZNGxU?=
 =?utf-8?B?Wm5hbk1kSytwWnN5d2tVaFJBYlY3VU9yWVBKR3k5ZGxZOWhDQVZHMjl1NDVa?=
 =?utf-8?B?U2hzWTByYm1RTHNtampBUnNlWnhlcFVmdmRlVEk0R2kxdlZYeFN0WFBqTmgy?=
 =?utf-8?B?TE1XWGdVNE5FVTQybGE3Nld4dExrTTJ1ZS9Nb3ZtYlhJQjFhS0VGUm01UkRH?=
 =?utf-8?B?R1NtZkRCMTBoRG9SY0tOcHgvUmM2UzFhMTB3bGFHeXQ4VituTTJLVWVJVlRo?=
 =?utf-8?B?NGFiQnBGVlE4TDFJT3FKOU01QU1TK2lxZm5Yb1NvbDBvRllJekYySnR4anFK?=
 =?utf-8?B?aFBSWnhZUHlBV1hQVU9xeFZoQ2RFVkhTbWlNNzh4aVorK0lQc3pscDZ0RHpZ?=
 =?utf-8?B?VE5yeFZaVVB4TVJMUXYrSGJIdkpVaU0yN3VLSi9Pa3Z2UWpybzBFR2o5Uy9n?=
 =?utf-8?B?K2FDZHpKL29Ia1pLbHB0VXZYNVB5YlMzeHJLVis2azhCVm9RL0ZSaWxJYTZG?=
 =?utf-8?B?eHIxemlKaWpIcFdnVnBqQzIrc3Bub2E0ZnJMQmN4RTVacUx2eUN3ajNrdzQ4?=
 =?utf-8?B?dVNINTB0dTBFeG9TUDRrR09QRVkxbHExMnRtWGxnSjJRVlFhTU9xQitsU3Ni?=
 =?utf-8?B?Rk8rYXB3SHBPc3k4Tzg0QnErdzF4S1ZzWlZUazlHWEI1Z210dkNoNG5DSnNo?=
 =?utf-8?B?TVoxSVRzVEY4NUQveWlGMERUODZjR0puNmFvYnFtUGRxeklMbmxDR09wOXNv?=
 =?utf-8?B?a3FGTzNoZW53bytDZjNNeE5xMWUvbll3VFk0YktocGozdUhuQmlLSG9jNmZP?=
 =?utf-8?B?Sy9KWXFtdzhxMVpFZnpXNUdlQndCK0xMNTBIS0tOOVpKaGcxMVRlTDlEVlRR?=
 =?utf-8?B?M1NVV0JDRzdaV0ZjUmluSFhsVjFQYzIvNWJ6QzJDRnpyazB4N0dvdlYwOHVS?=
 =?utf-8?B?V2FvUWxLc2xwK3YxaE5DUFkyckd5UUlacmFwSk1SckYydnRjMkJpVGlHdE1J?=
 =?utf-8?B?Mk9Jc3M2aEFRR3lkQW90L0pIbExXMWRkc2ttWVg4MXRBR0FEQThwalZXdUFN?=
 =?utf-8?B?TDM1NWkxdElsTkxDYU5KSFV1bWRBWXg4REgxTDZ3L0NDVFcvYWpuZ21kenV6?=
 =?utf-8?B?TXpSUDFRa1lRZlZ2a3ZhV0UxOHE4dzJJdGlTUjFVODQzZlQxN05JejFLdkIr?=
 =?utf-8?B?UkdmU2EzZktqTjg3K05kQTVaVVJ1ZVp5eGhQVFN5YStxd243QmhjQm1VczYv?=
 =?utf-8?B?TlNyWC9rSW15SkV3YmZ6RWVTTXozUXlVeEZhMWppYVYxaGhvUVczczl4RlFM?=
 =?utf-8?B?RXNYakNOZTZhN2pwZEd5QXhiM2x2eXl3Sk1iQmhIOHdYbzE5U3djOUdkenhE?=
 =?utf-8?B?ejZ1b0s1NEl6QzVyazFtTGltaGVOOExUQk8rVytKalpqZ2M0L3NZNVZiYTkz?=
 =?utf-8?B?SGR5VGs5R2V0NU1DeDJQMU1vVUNzcVhsSWZrbWdrRExpaHppS3VpUFI4Y3k2?=
 =?utf-8?B?Tyt1d2dwekZvbUJZUXBOTUU4QkRwelNtMTJKUGx2bGcwOExqbjVlR1crOFNZ?=
 =?utf-8?B?WXpFdkZmK1llc1RPaHp3MlFiVGRvSFB3eFdrQWJEYndkcXhuMFJxMGpVTHpW?=
 =?utf-8?B?NHliZWt3elF4WDNwM05EVy9nTzZxeElreWNoLzM0MDdJcmFhTzdkMXJ4MWpj?=
 =?utf-8?B?eVI5RE0zTkpONGFFR241eC9TM2xxTEtDb0M2VExBb2dWYVFHZzVkb09UV0J6?=
 =?utf-8?B?RjVEM0V4enRVckh4eFMrc1o1aUVBekthQ3NhYUhENEtSTUhKS2lPVlFJejhN?=
 =?utf-8?Q?i3QKrHCIk/Blf42bZ1NZ0Z8Qt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ELs7KOBkOMP3tNPgRerxYTETqg7WreU9kbArFiX49ktxayqez2L2cCHdrcf4iE3wQBnaOlSH+ZUxKMn/+CrZKAI7x970cswlwaO5VvGrl9dvXJFhynMCoVD2hfnbWB/D8xa0xUUAGvdqi0d0Nh1VMMxxq+bYbGEEXb2uro/SY/CRoDSDliECOSx+Zsin6wJzZpA26yoRad6fovaDkuw4F885+WH3ChtK7m8TPdMAbN+TaGV+0hA6Ye4sgIAUy0pK7FrbV9A93+uZuHs47ibtAg5o0ignn1sikwjeODUAJ9e/brO8g+9I3iV9MVr0Cl0EqXlbC/iq9zTJ/+U7Op9QYJcIVJKwNBE/E2NcCNdPdFq+fY4CqIrxhkdYIacVy+n00rsXUJrWJj7C8mbmOFfLRO+osLM5j4kZ6Ir9cDB4x0gY0Py/qV3qwkd/R5UMSWYCCuEexlrW1XLO0YIWs0XZJWed/PjSZgGUabr9JNrtWK2j7kZft34k/XMxVhtN4VlTrONnIYGBgyXc8zJxXUnB9aoRljBl4w8bm102Zv+78sJn9FXnjp3YjtCnuV4WTPCcINtmFHFpTTS6jb+Y7cBFnq1XMxBgYNuNxYdr9lpcAgY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1d7ff2-005b-4ced-12f6-08dc96a17795
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 12:05:42.2310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSLo2xdDm23zKZDMxjBnSHFknWSxI2/sT7H1WILeDQorszkMriAUzufXmefC1trv8wiJPdWs03qwSSwi5VpBMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4521
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_06,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270091
X-Proofpoint-ORIG-GUID: T2giT3djV7NkanyaPMeLR8GssoJIYVzb
X-Proofpoint-GUID: T2giT3djV7NkanyaPMeLR8GssoJIYVzb

On 20/06/2024 14:00, John Garry wrote:

Hi Alex,

Is there anything else required to get this picked up?

I have some more dependent changes waiting.

Thanks

> From: Kent Overstreet <kent.overstreet@linux.dev>
> 
> Document the new statx.stx_subvol field.
> 
> This would be clearer if we had a proper API for walking subvolumes that
> we could refer to, but that's still coming.
> 
> Link: https://lore.kernel.org/linux-fsdevel/20240308022914.196982-1-kent.overstreet@linux.dev/
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> [jpg: mention supported FSes and formatting improvements]
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
> I am just sending a new version as I want to post more statx updates
> which are newer than stx_subvol.
> diff --git a/man/man2/statx.2 b/man/man2/statx.2
> index 0dcf7e20b..5b17d9afe 100644
> --- a/man/man2/statx.2
> +++ b/man/man2/statx.2
> @@ -68,6 +68,8 @@ struct statx {
>       /* Direct I/O alignment restrictions */
>       __u32 stx_dio_mem_align;
>       __u32 stx_dio_offset_align;
> +\&
> +    __u64 stx_subvol;      /* Subvolume identifier */
>   };
>   .EE
>   .in
> @@ -255,6 +257,8 @@ STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
>   STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
>   STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align
>   	(since Linux 6.1; support varies by filesystem)
> +STATX_SUBVOL	Want stx_subvol
> +	(since Linux 6.10; support varies by filesystem)
>   .TE
>   .in
>   .P
> @@ -439,6 +443,14 @@ or 0 if direct I/O is not supported on this file.
>   This will only be nonzero if
>   .I stx_dio_mem_align
>   is nonzero, and vice versa.
> +.TP
> +.I stx_subvol
> +Subvolume number of the current file.
> +.IP
> +Subvolumes are fancy directories,
> +i.e. they form a tree structure that may be walked recursively.
> +Support varies by filesystem;
> +it is supported by bcachefs and btrfs since Linux 6.10.
>   .P
>   For further information on the above fields, see
>   .BR inode (7).


