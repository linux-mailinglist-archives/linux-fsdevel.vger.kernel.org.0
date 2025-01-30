Return-Path: <linux-fsdevel+bounces-40387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6138A22EA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 15:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303D91616B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 14:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093521E9B07;
	Thu, 30 Jan 2025 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oK/pcu1M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U9lasj0G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1621E47B4;
	Thu, 30 Jan 2025 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738245793; cv=fail; b=PDOjY3qVDUYY5KGKPUZvqXTlxISMHd0hDLLVeQ60/MODDLxCE4OaG/wb7+ZjiXlFkl2n16ZQ1cp5mX1gRHaZ5PBWKhlzEUHG8GWUr2WfxhbhdXqYibAtlsU+/PVbdVMM0247T9MF1Zjr7TlVWfrjxUwPvbzMUd9zqCNgGTHi7VY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738245793; c=relaxed/simple;
	bh=dAt44vmzs4me8yqlakQ26TlfOcGxxXsHovTdoGI+gEk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZpibszL5HXgnu6Iaeg5fMPsY4WOiQE8Ch4/hVq7sEA4QqmW7WBCooAmoEEH2RfcOBMyQficm432/H2tr6VPaWfT48XuAW8zN3A4hb51OmOWrsE1JmeNFm4n2A1nDkdfCrOs5N2HNcGlPoCknZZX8A8212eLAouXaVI/tpB+N8IQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oK/pcu1M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U9lasj0G; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UDRfJV028422;
	Thu, 30 Jan 2025 14:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=B5jgau6WhcFUVH8cm1YARx6g+pKntpPKS/qME+xoKao=; b=
	oK/pcu1MyeZPhGGIdlQrA8FNlCP3ZImpp6wM6K/NaKhffRfr8XEDfe9vpw3YehvW
	pOXVM980oSZtZ3Bozxs0tA3grgLQetgVtPLCH3FqUikjUAhMe3hVZ3e4fuVUUmox
	2jwxVQOwaR4O21q0JHuzlLd0FzF1R2y4vAU+/f+Y5fF/Yfvs3zUxXnHSe6aVoh0l
	T4oAXkbuWlCAw0GQXaP2Z9QDas4kJBe5klS4Tr6POAOkTqSoUFi2nxXFPlRUx/AJ
	qEez0YX81JS3Hgc8pTc0DBUo4o+e0F3DWVOlO7/cEZdeSmjJhSmZXYTEbJaxNiEc
	ozZu7iYdWzOLoktaazN4jg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44gaah82bs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 14:02:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50UD9p0p005390;
	Thu, 30 Jan 2025 14:02:47 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpdb8ge8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 14:02:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUUa7/bkYPa4qQDmBoKY+hM4JP1TSvggE8KHqqKedL9n43Z0Fc1BuR7a2zpyGZh+zN0SpVRL2y9ss+h4aQYv5CDLLQxqtyPVucU87T6BVgYqXsWMsu5w0cTkkIRC2wmYeqVnKtSmAbBlV+ocFXuvuJxoPFTt7L0xnWuHCwibrNQf6LNijEX6POoQFQi7YR4NF0KzJu39d8wfOxT5b22/zziY30I/wfgfs/tFM8jJ5OcOiPjuxxTIXzj6Wi/A90lcIfHuekNLqt0F223HfsarIM1v1X59QkHtUR6eNJU6+1AR309NCsJTA2ZHAUAGZ6XDEehqui0QLwwJbfD93eT/HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5jgau6WhcFUVH8cm1YARx6g+pKntpPKS/qME+xoKao=;
 b=OOWEvYSJVHaXo6xNCTrIrlg9pC+ua66Uf7gDN4sz8Vxk9CzDqMjQrFVMfvrfvXHZaYDMtU/ZvYCy71dCLQtI45eQkEvfKSiIs0jFE+Am+bFNZQ/+CCTVA+kPFZ48vKwMVoszXDY33JlYVP3s4TRet6u4kHOS8qu+Tezjzh0jxTMNhE4sJwt56b88sIoyLZstMzeVFBi17Gi87rJZvV/mpWDZlw2BwuYQ9FdA1oEW9ewPcM4vFpe9eYeUaWWpQSlts8ZmaaKxDYh5el1gfUqk7H5gEiEFI0qhk/sclUPB7oiA+A+EZeMvVXzaFtmDA/mX+phbxSS2H82v4he5tAhKUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5jgau6WhcFUVH8cm1YARx6g+pKntpPKS/qME+xoKao=;
 b=U9lasj0GEaMAvH4SKx1EpEeVh3qLDGzCefrogfRxLok8bu8Ahy++51FVXjBzsL/UnQSa4rp5ZJXmMuivP//k0BwYFWWd+OjZfoGMaAEF9Wbjf7l26GR55++7ssTERyZ9OOMoMJ3tnFyJHBmokbBV0HsHnaZA1s1tiKVRmchytFY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6725.namprd10.prod.outlook.com (2603:10b6:8:132::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 14:02:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8398.020; Thu, 30 Jan 2025
 14:02:43 +0000
Message-ID: <0a6b6602-3052-40c7-9727-abe69bd85a06@oracle.com>
Date: Thu, 30 Jan 2025 09:02:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6.6 00/10] Address CVE-2024-46701
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hugh Dickins <hughd@google.com>,
        Andrew Morten
 <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Sasha Levin <sashal@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        linux-mm@kvack.org, yukuai3@huawei.com, yangerkun@huawei.com
References: <20250124191946.22308-1-cel@kernel.org>
 <50585d23-a0c1-4810-9e94-09506245f413@oracle.com>
 <2025012937-unsaddle-movable-4dae@gregkh>
 <69d8e9dd-59d1-4eb2-be93-1402dba12f34@oracle.com>
 <2025012924-shelter-disk-2fe1@gregkh>
 <9130c4f0-ad6b-4b6f-a395-33c7a6b21cbe@oracle.com>
 <2025013057-lagged-anointer-8b77@gregkh>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <2025013057-lagged-anointer-8b77@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:610:32::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: 41562e89-b628-4a62-009f-08dd4136c471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmdTck1sUE41TTBVV292c3FUSnN6L2ZUTkd1U1JzemdLUWZWVnZBRTA0N2JR?=
 =?utf-8?B?WXdaeWRrcHRUTTlpaEZuclM4ZStYSzgxOWxRNnV2S1FVdklndGNBL2Y2b2Z4?=
 =?utf-8?B?cnYvL2xZME1WL0tmRzF6a0RzdElYSDllQnhINHlPRVo2WUJhY1Q2aW82U0RV?=
 =?utf-8?B?R1RMWE0wOVk0djJ3cy9pRkw0Z1AyVi9DbC9qblhMc0w2OG53Y0IxcFZRSWht?=
 =?utf-8?B?aFg5QnhLQUdQT3U0SzFmYVBocU5BbDd4YjFGVDBsd2FvOG0zSUNXbUd3U2NR?=
 =?utf-8?B?SGtuTEo2bjh6bVpBRnFUNmcvQ1dEd3NIWEpib3NCSE1JbGRkZHZCbitBWk4v?=
 =?utf-8?B?bm0ydjlqUURpNVNTSDVjYjVveVRFajk1U2VGUXZmdWdMc3BmTDd1emRqTnUv?=
 =?utf-8?B?OWVHZ014Wm5XMTh4eExzUkFMQVBaSHZqM0NvUzVYSGtMVFhyc0RzYVdGV1Fv?=
 =?utf-8?B?K05WL1k4REhzZ25RcktrN2dBc204RjZyTEVpRFE2ZFVqNERiR0orbWJVUlFn?=
 =?utf-8?B?RERUNGhtaUMwY0Y1TTBvaWgxL3YwNU5pZFRnUC9QMEllcEYrQU1lMnZERkRX?=
 =?utf-8?B?Wjl2eXdGM0pjdlZaengzcjdWZkJScU5vd3VRZ3JrU2ZORFZycHhsZ2o0ZDd6?=
 =?utf-8?B?UFFVL09pSGxmUDVPbVN1d1BwS2RTYWpCQk1MUGRFYy9xSXVJWGo0cWQ3S2NS?=
 =?utf-8?B?cVQ5ZmlsK1FQSWhLN3FGQ2dyZ0tjamVrc0JUVTc5T2tSNTFwVHIxT0dsRmVQ?=
 =?utf-8?B?SXc4RXoyS1dMc1NLNzZZd3lOYkdMWGJRSTRWbFV3SzdBZjA2bjBlMENqVEw3?=
 =?utf-8?B?NjVGaW82NitRTGtrcW01dWJ4RVc5VEMydUFzUk5OQzNNZzJjaWpBek81cU1u?=
 =?utf-8?B?RE9nRjJiMEI5N3dLSVlSamxiQ0dXcEtzMHV4OXhEakovSFY3TDBzVDBFaEpo?=
 =?utf-8?B?YjFjRDdzWEltOVJUR2plbEJMdENDRXpNSEZjcTdvNWowbFBRYkUvSlkrYW9Z?=
 =?utf-8?B?WVN5eWxBVzNReWxMOHRudXIvMGhZaUpwTHJpTGtDZDQvZkNIcUlvcTlSdGN5?=
 =?utf-8?B?SEFienlCT3k4OW50VWR1aGE3UGpidXVaS0RUR0thQndxUVRaYUhNTEcrcW5k?=
 =?utf-8?B?bytOeGl2SjN0VU0rdU5NclcrVG5kZ3lSTmU0S0trd0wvTXRoQjVzWEloeDQ0?=
 =?utf-8?B?VFVtajNSdENKMUcvMXRTSGNxQ1JoSkhRY1FKMjhDYnZHdERCc1lJWElFdUtk?=
 =?utf-8?B?bmVaTnVFYlFJQzNpMUtidU83NStXWXRTSUhhdFRYZEVKY3AwUGw2bVBVcVFz?=
 =?utf-8?B?cEc4dDVKa1pYWGg1d1J2RkJOUDV5WWtOa292S25sL21nbjBkVTFtUTRwRGtu?=
 =?utf-8?B?Zkt0ZTBsT3lBTStTa2o1ZTB3QlJyMXRvN0cxd1A5anh0RzJUUzJwSmFzM2Zt?=
 =?utf-8?B?U1AzcHhBTTFrSDVSaUthV2I1bXJxRDROeHJxK2xoWkI2ZkwxNlhYdkYwS2l4?=
 =?utf-8?B?Mkl3NUdhZ0pXZlJvaTlET2F0VEsxOFBPNWNEY0tHYnFkRnA0dWFvTzdVK3Qr?=
 =?utf-8?B?ZURYVWtjaTIvYVVkU1NnSFJXbkE0cjRZUDh3VjdhWExVNEJlbGVRTy9aazVU?=
 =?utf-8?B?aDNZS1lhTkF4RzhIUXJ3R2FHeWJ6cUUxb092QnhIWDkvR3NERGUxR2FaZU9Z?=
 =?utf-8?B?QXBnVnlQRmh2OUpJNjR2elRENVVBNUZtQTR2SC8rWmlndHVBTG5vTjJSQ1BY?=
 =?utf-8?B?ZzZFVjNFL1IwV3BlWlo5S0d4QTJhVkFGOHljZFh4Q1ZtMmRmSS96MlQ5WWhF?=
 =?utf-8?B?am1rVHVoTE5pUnl3K3ZDMGZUMU55dmRyVFFyQ0ZkbXVnOHRpSU4wWGlRZU9i?=
 =?utf-8?B?bU1OYzZtMzl6eDBHQXUwTEJONHhGL1kyQkVjcXVCODVyZHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVdoUHlWWTBWT1BrRnJwdS9TSmxxYmNBYTdXV2c1N1BJUk9VUFFzeGE3UHY0?=
 =?utf-8?B?dmp2WDFtcTF0Q0lIWXN6RWdNK2t2YVI1T2sxeCtjN3JTMFVXMU1wZkZyWlhY?=
 =?utf-8?B?bHhKM0RkVTBGS04zUVNYdmlERFJoZWw1eERrandjak45QjV1bWhRUkFTMlJw?=
 =?utf-8?B?SGxCYWUxb0hHcmIzZzdRMG5EcEVrdGg3WW5WSmxzY3hhOXhFcGVmRnZ3VC9a?=
 =?utf-8?B?VTdjaVEvRjU2ZmhaR21tOTBnVDBLTWk0WTljY1I1WW9NSFVTVUtuTTBuTjdN?=
 =?utf-8?B?TzFHUE05YkExQXFCTkFYQXNBVUk3NjhOVWVMRXN1NDRUdC9Dak1qK0ZhcU9H?=
 =?utf-8?B?UEthMytzTWJna0VEUTdnV1dBL3JQZFl3SDN6WDFmaEJ6cE44UHhBdlFlYmE4?=
 =?utf-8?B?NkNEWHhhbU1oSG5YTzhVSnJvMWZhdU1rVjZhaTNVNlBIL0NyWWY3UWQzVEs4?=
 =?utf-8?B?QkpKTkR1eFFVcE9CQ0FJQXFOdTZCZ2tscjN6YVlwQm9KaHZhMmVSNzdDT3Q4?=
 =?utf-8?B?ZHNUTXl3cGRZUlFFTzcxWXJrYmpMVExtYzg0Ym1VYXJLeGVSaHdxNUkyVW1G?=
 =?utf-8?B?akptS3dROWxHOGEybENnSklhRm5Ja3hIWVBXY0t2NndSRWtnSGJ1UnhrdjVL?=
 =?utf-8?B?N0FEMXg2UlFaWDhHUUE2WjhLQTdzVlZ3Zk8rRFZRMmkxbnA0QnZDR0VLUmlI?=
 =?utf-8?B?MlhObHR6YWxjQlVpeVk0VkdRRFA1Ylk5WTM2STZCbHpzRHlIQzhBL3NSSnRC?=
 =?utf-8?B?ek9QazBnQ1k4bEFwTnFpd3paSUdrMjIrcG5ST01saVk2Zmplemd0OTJQZW1i?=
 =?utf-8?B?cVdCTU9GSmNMYllmOXkxSlBMSjRqVzhyNSs4dGpOWmwwRlZwaXJ0c0RkM0Vi?=
 =?utf-8?B?amZOZ3d4S3Uzc0Jvb1hqQkZQc0NxVDdEZFAzMWRJWHg1QndGTjhoNWNxd05i?=
 =?utf-8?B?WjJjK0N5dVA4YUJWU0hwOHlNZDd1WlJTbDFBUFo3MHZhbXJrSkJvQkRPTFF3?=
 =?utf-8?B?U1Y0QTdDUzNsZGMyaUpnNm03Qk1pRmpwNWlneG1xbElFTEJYayttTG12ME1k?=
 =?utf-8?B?MC9TeGlsWVU3dW84Q2dDbzdyUStmOUpFZTdUdVFJUDJGalNSYlp0S1pocmRj?=
 =?utf-8?B?QUNMUE8yYUtCejZCMDZubmg3allzcjRTWVZqdGlCZkdtTnZHREV4dWpNQnA5?=
 =?utf-8?B?a213WktDZ1dyQzRjdjAxcWJWMHQ2RlRTajNYb3o4VlFaSW11V3FhOHJueDNz?=
 =?utf-8?B?cFkxRUpzNGpIbUwwazMyUFpOcGpQNkhoZVZIaU9naTJjUEJhNkFSZXpiV1lm?=
 =?utf-8?B?Q0FmODNpYWRoaUpONFpSc05IOFh3aFNER3Z5Z2FYRlJKV2VlcEY5L05CSk02?=
 =?utf-8?B?dy8rZVNoQk9rZnNpK21ROG5hVUlLSGd6VXhrdks3S2xZTmJaOXBSTmx3bVo2?=
 =?utf-8?B?ME83NGJNTkFnTjZ4azFIOG96L21SOXNxeGNnT0pPYTlyMmIxclR0WWFRWlpW?=
 =?utf-8?B?YVdFdHpsa0xNTGlPenlQVkVvMVFZV05zdmtoSm51b0hvQlluamFsRjc2T0pU?=
 =?utf-8?B?ZVpZWDJleDJYakZWUGJkVHE5SE85STlqS3RwZVc3dk4xcld1WHJHQ2Fkd3Y2?=
 =?utf-8?B?d0ljZTdEV3lreTVyR0JOS0N6Z1Q5K21WSmFmYUhsak1Zb0pjSVY1RWUzdVJG?=
 =?utf-8?B?bjlLWGo5amlKbEhrOG94dzMxc2o1c0lQMVdTLzVEM3hDQUhyYUFDM01hcnhU?=
 =?utf-8?B?b3R0WC84VXNRWURlTkIyUGQwQWsySFZjZDIzcnN3c0d5Y2kxaDBqWis2d09t?=
 =?utf-8?B?OE1BL205RVJCUXJ0T2VudlNRcU8xOVMrbEF3djRqZzJ4TGxzb285Q005TTd0?=
 =?utf-8?B?aFJ1eHU5V2d6eUlENkNKSkJOZlFrMUJPc3pSaG9BNjlNSVhYVzkzMjZjRXpx?=
 =?utf-8?B?YkhhZ211RXRXL1EyeFF1c0hJQnBwL0hRcHBCZWlQaUFDaENVcEZTcFlqZTAv?=
 =?utf-8?B?KzBORWZmR0psV1pLYy9iZVdpMHB2WGlXT3RETUpBa045Zk1wbHorei9qb0Yr?=
 =?utf-8?B?REZ0RWVRSXcvYzRqYXVhQWtHY1l1c285SVRUU2U1UFh2UVh5dy8xTTJHblBq?=
 =?utf-8?B?VnZRa1dYVWp4YWdTUEJJcWh2Z2hEUHVVU3NlSEdaaU1OMmJNbWJ6Q1Q0TnNx?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6DpWjCOVihp+O2RZGA7aYx222T8fLUCpupcbAHtC0CjzUplSJSs9CuF6YYjhmRQGQEapN653w7ruQDNRwTmGp5G8fJmrOyu4SGP4R3jE3QL6ReNhpEaoeI+nU6zwtXhu8NVlLs0TOL6Y2x8vM00ZADujiUCcYXuKkFS56iHjN+DNUzLr+2u54QJiHOUxxJixXZlCTatg6drch2Tho/8aZNkA+yi+nc6nx29X8fu4QB56ugLjD2x8Ibk65vA/Op+5KqyYKf3TXLgz7IN99qqWe6ihJty8p0Ab+ZlaSSAxiQVjxwSTcRFrm5bsFKAf3APnrAG76BUUtCdgITPRCEaonykyA5NUACRghZDjmrI0M6kJvQ2EzAwHeZZG2ATOjDHnIdYwga3o6InXqrkBpRM9pSNNv4LU9/CeLN9C69ZQqHymm/HR06gfeQ2GW5RgLS7NzPdr6/gTho45p8EheQu0IfmbyPiZTIr5QmWkw+PSKJQFeOITIveVN3ECEh8136tEkcfs0dhM5RRO6qdI/IJcz6wvNdpwbpCpbUGPFNbJr2qLzMd87Exiibi9KvobvqnLhMuubgtMZ74dD3WbrGmrOtKLNzscjp/L98UPbpRSMJY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41562e89-b628-4a62-009f-08dd4136c471
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 14:02:43.7942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qUYBk+u41KZ4OTiJC/u02hLgHWTo7ZB8TvEeblwYS8JVkJHLVO0ylYWy81TSqcVeGuEpOdGZtvHNamIDJzSD4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6725
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_06,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501300108
X-Proofpoint-GUID: Kn6XoGy7SGLa1g_1-nWDuOQBxDT5YXfP
X-Proofpoint-ORIG-GUID: Kn6XoGy7SGLa1g_1-nWDuOQBxDT5YXfP

On 1/30/25 3:45 AM, Greg Kroah-Hartman wrote:
> On Wed, Jan 29, 2025 at 11:37:51AM -0500, Chuck Lever wrote:
>> On 1/29/25 10:21 AM, Greg Kroah-Hartman wrote:
>>> On Wed, Jan 29, 2025 at 10:06:49AM -0500, Chuck Lever wrote:
>>>> On 1/29/25 9:50 AM, Greg Kroah-Hartman wrote:
>>>>> On Wed, Jan 29, 2025 at 08:55:15AM -0500, Chuck Lever wrote:
>>>>>> On 1/24/25 2:19 PM, cel@kernel.org wrote:
>>>>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>>>>
>>>>>>> This series backports several upstream fixes to origin/linux-6.6.y
>>>>>>> in order to address CVE-2024-46701:
>>>>>>>
>>>>>>>      https://nvd.nist.gov/vuln/detail/CVE-2024-46701
>>>>>>>
>>>>>>> As applied to origin/linux-6.6.y, this series passes fstests and the
>>>>>>> git regression suite.
>>>>>>>
>>>>>>> Before officially requesting that stable@ merge this series, I'd
>>>>>>> like to provide an opportunity for community review of the backport
>>>>>>> patches.
>>>>>>>
>>>>>>> You can also find them them in the "nfsd-6.6.y" branch in
>>>>>>>
>>>>>>>      https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>>>>>>>
>>>>>>> Chuck Lever (10):
>>>>>>>      libfs: Re-arrange locking in offset_iterate_dir()
>>>>>>>      libfs: Define a minimum directory offset
>>>>>>>      libfs: Add simple_offset_empty()
>>>>>>>      libfs: Fix simple_offset_rename_exchange()
>>>>>>>      libfs: Add simple_offset_rename() API
>>>>>>>      shmem: Fix shmem_rename2()
>>>>>>>      libfs: Return ENOSPC when the directory offset range is exhausted
>>>>>>>      Revert "libfs: Add simple_offset_empty()"
>>>>>>>      libfs: Replace simple_offset end-of-directory detection
>>>>>>>      libfs: Use d_children list to iterate simple_offset directories
>>>>>>>
>>>>>>>     fs/libfs.c         | 177 +++++++++++++++++++++++++++++++++------------
>>>>>>>     include/linux/fs.h |   2 +
>>>>>>>     mm/shmem.c         |   3 +-
>>>>>>>     3 files changed, 134 insertions(+), 48 deletions(-)
>>>>>>>
>>>>>>
>>>>>> I've heard no objections or other comments. Greg, Sasha, shall we
>>>>>> proceed with merging this patch series into v6.6 ?
>>>>>
>>>>> Um, but not all of these are in a released kernel yet, so we can't take
>>>>> them all yet.
>>>>
>>>> Hi Greg -
>>>>
>>>> The new patches are in v6.14 now. I'm asking stable to take these
>>>> whenever you are ready. Would that be v6.14-rc1? I can send a reminder
>>>> if you like.
>>>
>>> Yes, we have to wait until changes are in a -rc release unless there are
>>> "real reasons to take it now" :)
>>>
>>>>> Also what about 6.12.y and 6.13.y for those commits that
>>>>> will be showing up in 6.14-rc1?  We can't have regressions for people
>>>>> moving to those releases from 6.6.y, right?
>>>>
>>>> The upstream commits have Fixes tags. I assumed that your automation
>>>> will find those and apply them to those kernels -- the upstream versions
>>>> of these patches I expect will apply cleanly to recent LTS.
>>>
>>> "Fixes:" are never guaranteed to show up in stable kernels, they are
>>> only a "maybe when we get some spare cycles and get around to it we
>>> might do a simple pass to see what works or doesn't."
>>>
>>> If you KNOW a change is a bugfix for stable kernels, please mark it as
>>> such!  "Fixes:" is NOT how to do that, and never has been.  It's only
>>> additional meta-data that helps us out.
>>>
>>> So please send us a list of the commits that need to go to 6.12.y and
>>> 6.13.y, we have to have that before we could take the 6.6.y changes.
>>
>> 903dc9c43a15 ("libfs: Return ENOSPC when the directory offset range is
>> exhausted")
>> d7bde4f27cee ("Revert "libfs: Add simple_offset_empty()"")
>> b662d858131d ("Revert "libfs: fix infinite directory reads for offset dir"")
>> 68a3a6500314 ("libfs: Replace simple_offset end-of-directory detection")
>> b9b588f22a0c ("libfs: Use d_children list to iterate simple_offset
>> directories")
> 
> Cool, thanks for the list (and not all were marked with fixes, i.e.
> those reverts, I guess we need to start checking for reverts better.  I
> have tooling set up for that but not integrated yet...)
> 
> I'll just queue them all up now.

My thinking was the patches marked "Fixes:" would show an obvious need
for applying the unmarked patches as pre-requisites first.

I promise to do better marking patches with "Cc: stable". But also let
me know if there's a way to label pre-req patches more clearly. Maybe
"Cc: stable" without "Fixes:" is the way to go there.

Thank you, Greg, for your time.


-- 
Chuck Lever

