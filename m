Return-Path: <linux-fsdevel+bounces-28711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5D796D59C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 12:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F00501C253C2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 10:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB9A198A0B;
	Thu,  5 Sep 2024 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bfhEqD2A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="awO3y4D6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64239194149;
	Thu,  5 Sep 2024 10:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531362; cv=fail; b=YpN+COHNMEOcuD5WieHBiGRvcl/LDSD8dxRmNBxOJ1Hwp9TcLroMsRpTjDkbLyT84xnJQUI+gmdO2LsGMLg3HxkNRHOnGkCpJ5/bDuUr0/w6pwP7fJdN7G4EUCK8Xh9mEJTfAvSrHAAx9CMLMhnZXSnz6VUXr3yzkar8Ij9sdtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531362; c=relaxed/simple;
	bh=Rp2ihjuN5AZaw4EBqcLk1Z7R3KRB8EmdJomyqUlaSmU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LfWroKiChf9kdoeOuPdVruADoTzPmUrNxrOQEQbj7BsD/pOVDeLLjK4rjqlRdpJrj3XFVtK0E+4JwLG6cTb2QyJZr6s2wwg2sF0ZTLbBr2zMeBZoR2nm+qOvIXH/vp7TGnttgMr4oYxyujXw/TobaDp5pV90oVMpx9sKA56Nwfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bfhEqD2A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=awO3y4D6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4859BX3Y005871;
	Thu, 5 Sep 2024 10:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=J1EAZz6KuUep+jHrP36h8MyzX/xliIbFry0sNLdB2oY=; b=
	bfhEqD2AVv9gI/mGl2vgo/6o/R1FeCyJAU2y6055WNf8b6apdcpLGWReN7vXVVIL
	kcl44rMn1dQzt176inU0eBGnl9KEuVPeCl9WaUlxrMs7qPF62Lm3um6cD+fdD+Gl
	jw9vR7Yi7JqC4gbfyq8mkkx7CKNSsHVubmWgb7ZWBrF69ziSyMO8QraeySjO7Dad
	sp+57KmTsScCnImtsi+pa/RoQ9Z7cweMtd6ZWeAoCXYR3ZumST7+lprbeRy3dvWy
	YezldPo1buZu1kK/EdC7QHZC/Iyv9CnlwlVY1ZImkDq1JdebsbWXSHjlGEPSB2nJ
	0P4WO9i05V4klZw8XDoEbw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dvu7df03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Sep 2024 10:15:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 485A2AXr018356;
	Thu, 5 Sep 2024 10:15:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmha1m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Sep 2024 10:15:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVCb7miig1VU4HYftKKTGSyY3P2tns1DbjYhqHthI9QS2cFMN/Ojd69/DJPfvTsKckdRE6PPxSDG8H7NxlqvsICyF3RdVSvSaer3AfUkyjrsSzDNBFW4jqmdoOul7AdR0i6OH+nADVjIEMUTYfQTYVyfD5nCES4DCN4018MJtWhM6y9LMyqzNVb1ffxqLEoJlnHa71lCGGJcrDclEbJCrdcwjP+qsDUI66S0vxo+50dlDl152XJvmSrphaQn3/e8Pvz6v0Zdfb3oaamvnsVoau52ipRbxNEnUgkf6hVWeZPZY23AZ7VVtgqsbAzve4LUNTWAir9OVoigxg8sNU3N2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1EAZz6KuUep+jHrP36h8MyzX/xliIbFry0sNLdB2oY=;
 b=Rn+6AH8hN9ajz6t6cYcS1bMzmu6F7q2F7pAH+QaCefIDPMOdwhYcskwE+yraIq2Z8+17ZCVEbKB9wFx966dQS22nOdXnJnBXKpGNzGwD+AtDdx1vcI//iNvv2esapqZnHTaw1+CmhReTqB8n4tN0gdVUp6qlqtqRA4tv4Ieshem9QATKR6dkDVy1MnP8w6gKdhRF148wWqbh7H+kEcZlquzvyw7zU/RiRAbX0ySiZqRf31NSZCX75R3nHq3MjdTz5WszW+bM8OsWT8ISPPKeK8S/2ULWOBK3IVZ0zaxqFnp//Yp6xL7+W+T/T29vqqt2W8fLIQ71Bg/qXTgsvIGTrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1EAZz6KuUep+jHrP36h8MyzX/xliIbFry0sNLdB2oY=;
 b=awO3y4D61KDzQFjmScHpZLLom9rBVh2u7IbSsWWuKP5h6TUakD88lLqRYQ5FihWBSB/a4Ofmvoh5EJsHk1xiEC3uj1VJJxV8s7NPwtoiKSQdnIfCggx/Q0zNEXiW6GkbAMoNTJMDTSHncSKj7EfkFraL2h7C0No4kK7z4BKLrJY=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by CH0PR10MB4827.namprd10.prod.outlook.com (2603:10b6:610:df::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Thu, 5 Sep
 2024 10:15:45 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%3]) with mapi id 15.20.7918.012; Thu, 5 Sep 2024
 10:15:45 +0000
Message-ID: <79e22c54-04bd-4b89-b20c-3f80a9f84f6b@oracle.com>
Date: Thu, 5 Sep 2024 11:15:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] forcealign for xfs
To: Dave Chinner <david@fromorbit.com>, Ritesh Harjani <ritesh.list@gmail.com>
Cc: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
 <87frqf2smy.fsf@gmail.com> <ZtjrUI+oqqABJL2j@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZtjrUI+oqqABJL2j@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0558.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::14) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|CH0PR10MB4827:EE_
X-MS-Office365-Filtering-Correlation-Id: eb107908-e870-49ea-3461-08dccd93b47f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dStNbU50Q2trQ2hWSjA4TDdWWnBhYndIZGJ2cGx6VWUyRnhLdm9hcHYvVkxX?=
 =?utf-8?B?aHVuYXRDOUZ6alh3V3puWnlJQTUvOHlLMVRLRjYzVmdFVHlzU3UwdGRrQlJn?=
 =?utf-8?B?MmJwRk5LOVp1RkdRVmRWdWhTM2VGbHhEb3ZFbWlvTnM2QWdacnhrbWFuQ05z?=
 =?utf-8?B?a01XbWJDZW03VEpzU3ZTMGVVYVFKaEtPNHNuQ3IzUmE4c1ZzWENQSFc3dXVm?=
 =?utf-8?B?QUpCYWNYUHFMekV3c1RlY056ZjhJV0htaHVxWnBBVkxDcmlCbnZNekp4RVpp?=
 =?utf-8?B?cG5SZnY1UnExNml2SnorbDFQWURyWi9qOXlteGRXRm44cDg2a3lYenBXUFgw?=
 =?utf-8?B?REZsZTZSREpZVTV1SGpJSStoTEVlODdiTmJlMEJmc2lhMkdDaWRJam1RUmdB?=
 =?utf-8?B?bjRkZWRqYU1Cd1hMNUNqeWZJUUtBaDVRTnBEUE5hcndYengvbWtRR0MzaUdE?=
 =?utf-8?B?cUFRZzhnRWxKb29aUFFjTTY3ZzZUdHdmZlVXVTVMeG5BS2UzZGh6WEpsSml6?=
 =?utf-8?B?d201MFl1T1gydDQvRkFxQmY1T0FBMUJCcWJ4b201STBUdUZwSnJFTGpmbXdP?=
 =?utf-8?B?U2hvRVRWYUxERWllaWdRWWVqcW1rY3RnNEY5SVVKd0hPeE1vL3BWK0I3QXlw?=
 =?utf-8?B?WHlrN2ZsWjdibENZR3Y4SnpPYWtFZnFMcUw0b3ZjRzZoaFNoVTdJdjI3aHNW?=
 =?utf-8?B?a2FHTGI4OHRScG5DYVFEMlFSYkUwNHJud1ovNXMzVWRVSWZpb0E1NWJGQk9k?=
 =?utf-8?B?ZmNuaFNrRmN2em91eFVvSiswRGgxdmNPK3hGTW1LbHh6b3JDN3dpcmQ5VjRS?=
 =?utf-8?B?b1pLS05PdkJGN285alY1eGtrYXBNOWpSL1ExeGk3djFHT2hZT1RtZ0E3MjY0?=
 =?utf-8?B?S0hjQ1FPdzVrV3phRzRwMm11TWdMM3lWNVhGRzk0bXBudVBDRjVQRUVqaHd4?=
 =?utf-8?B?Q096RGtpMXpmVERlNTBpdnh6UmF1M0Yyc1djVWN3emFzR1pOR1dKQmJUQXRi?=
 =?utf-8?B?RkxOS1Y0M1VabkE5S09LS3RBSndVejZsODd5Q2pFcE85RVV1TUkxelBUbEJm?=
 =?utf-8?B?V1p6VjR3aHU3TlNEOEJndTdYdHBMQ0ZzYitSaytoZXBaUjRxbWltUS9OdXFH?=
 =?utf-8?B?dmhRdzErS2lkdXNNQnA3ZGZlYjdLK21lbUw4VWdLcnNoY3dQeUpaNmRWVFFE?=
 =?utf-8?B?NDEzQXV4Vi9hazRUdWsyWWxvdnZMREJJK0lhcFRGODJnME5YVHNTWmVQcXpU?=
 =?utf-8?B?cVRVTFR4Q3RpMVVUSUxva2dZb1JUaUlEdjBwbjZndVNXd0d5eTkrSTJ4a2RK?=
 =?utf-8?B?dVM0RXAxcCsxY0VxelpSSEIzZDRNQW0yNlVDbDY0WThVYy9wd2FzNkxzZlJj?=
 =?utf-8?B?S1ZoblBzVFF3MkhIMml0YWJPWEYyN2ZrWjhxUnJTWDN6d2ZXQ2M3OC84eGhR?=
 =?utf-8?B?S05IRWRRMmhrcVF3QjY0U1VkdjkycWJJRzZWbmRvdnRPeGJuV3ZVZmNVRUt3?=
 =?utf-8?B?WWpWV2I0dDJTV0JteTlzYzdtTzJsci9NVkYzdXArN2NJNWsxdjlpeXFoTUZ5?=
 =?utf-8?B?VHBERGR6TnlPdzgwSksva0JOQXREQWtqYm5Nak1mS08wZ083WGw1K1Fuemtv?=
 =?utf-8?B?TTBtdHhaZHZUNEQzQWJ3Z3d3V2cwVEpKUnNrNVNDR1VpeHZ4aktjVGRGSjFO?=
 =?utf-8?B?R2V1Z3h4SVFWVEd6NHBmbGhJTGZENG4yR1FINTcrV1h6U0tzZmxBU1NMTzdy?=
 =?utf-8?B?S29SWng0blgzWnYyNGRnQ3BXeU9yanhVOHZMWmdKMmY0SXUvSkFmUDNQekpS?=
 =?utf-8?B?bHF5ZWpscktaM0ZPMFdsQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3NIWXQzMmVPRjRhUDFLeE1WWmdIemN1ODl6Y1M0K0dETENzejRMdDRIR0Zn?=
 =?utf-8?B?a1BRYUo0MGMvN01jQWJpRXZ0cG9ramNzZ2JzUFFBVkUzVlFCRk9lMWJJeER3?=
 =?utf-8?B?QXh0M0ZQMFNSbTc3YndueVh4amdlcitteTF0aHlMNU16ZnRjeWN2V2pESmNV?=
 =?utf-8?B?Tis3U2NLSVZxZEtiY0RWajRzV2lkZnFvZEYzYVo3cElTMXhGemFIRUkvOFo4?=
 =?utf-8?B?bERyTlRXTUVKMUJCaHg3R0FXRU5IRVg3V2I2QnlsYkp2TEM1MnF4STVuTFM1?=
 =?utf-8?B?QkF6RlA1VWVQc1lDVWtLM1h0UG5aZEpUOXVXaVpReVJVUDJmOVlhTllWdDQ5?=
 =?utf-8?B?VDVrK2NxR2poeUFyY1N6VitLZm1EM3R3SHhoMUFNVWIwQlg0RDBpdE4wcnF4?=
 =?utf-8?B?MVgxa1RMWUVDbktrM2J6OGh5RFJHYU9KVHE4SFoyT3I1Tys2eFh5OXhRY0FR?=
 =?utf-8?B?bWVsTDVyZTB1eVVCa1kxaU5qanhKK1h2UlZ2R2pzVlhCeWNBeTMxSkNERk1v?=
 =?utf-8?B?U2JBeXJ6a3RZSzl3bDJJSjdYRm15cUxIeXlmZ3FRWXNLUDJWK0VweTBrN3k4?=
 =?utf-8?B?ZU9aUVpvRmJNSkxPMy9NKzMyRmkzVktxT3loSFA0ZFRNVkxFS0pyL1c3UTE2?=
 =?utf-8?B?MFllakxrU0VuekR4RFJ1SkdLT2JKR2FUQmVnNTVEeGVJWlNNVW1yOXlSMjJQ?=
 =?utf-8?B?b0ZEY2RKTS96QXJDdWlkZ0FVcGwxdTZaR3NwV3BqeU9vTkF4M2xoeVRRb09p?=
 =?utf-8?B?TVpNOU1CczBlZWJEbFhqcFl3SmM4dTd3dFJBT3ZyU2RtU1JwZHpRKzk0NWNV?=
 =?utf-8?B?c2NhZXpMb2tQcjlkRDhmajNBeFE1aGxFVitvR2RlMTNzckJZY1c2TDMwcTFS?=
 =?utf-8?B?NHd2RjczUDlWRTYvUk5JSmVvTWpranovMStyRVAzNkFjQjhDUkxiRkl1WmRB?=
 =?utf-8?B?TVoyNlBRUW0yUEc4UXZkZWFJWGZscG8zRFA3cy9vci9WVFpJY2ZMRTBod3lL?=
 =?utf-8?B?ZWRSdk9WWkRwUURCWmNjYmdCNnF4cU0ySmdHRFRLMmE5UnY0MktweEFONkxC?=
 =?utf-8?B?OXdPNng2MDBDQ1RIcGhTM2lmRmo3WXkyZ0ZKMUxjUTN1bFUweXNMNkk1Uncy?=
 =?utf-8?B?aDU4QnBIK0dlejRrNUI4Z2gxU21rR2lLWHA2UzcxYnJUeEFjd3llOWhpZEdo?=
 =?utf-8?B?ekxSd1JWOGt0cmpOVkh2eGZsWEVjNzFPbVFUYmZZQ3BHMGpVd2ZXL28xa29O?=
 =?utf-8?B?M1M1SDZDMVI0cWQxQUxEMk5iQ1c4RGE3WnVETGNaUGZRdUQ0VXhxT09kalgx?=
 =?utf-8?B?Wk8ycEF5cDg5eVJDNG9BOEl3QkR6bTJYaFdtaG1LcDNHd3VMZmp6LzhwTHhU?=
 =?utf-8?B?SEV1bFkwMXIxKy9FT0NyT0hGakhnQlhaZThIMjdBODdUckRTZC9vL0JkRk42?=
 =?utf-8?B?RFBNaHdTRXpTMWIvbEhiWk5SeTNvNFc0K250MWRYdW9MY2l5c1QzVFNuMVpa?=
 =?utf-8?B?WWcxQUM2R1RDSThnL1djTFNndmUwTHVRdUhzN05ZRlc1enhWVGdHa3I0YzJz?=
 =?utf-8?B?UnRSWkxLaC9xMzRaU080QnVIKys2VFZpNmVsL3dpckJQYzMrS1NBclcrUXhV?=
 =?utf-8?B?N2xpeW5kbVp3VlJEMTJrUzBKVS9MeG1JOEQwWERmTUxMSXVjN1gzVmtmTE10?=
 =?utf-8?B?MUg5KzViaFNqQjBOd0ZyTmc5ODFWUDBhSWhuMHBjLzRIalpDTDlYdGwzcXM3?=
 =?utf-8?B?T1grbmYzRUdvVDZRR2tjU2JJNUdWK2RWNDR1UlpiWk5mamhnTy9qbTd0bjAz?=
 =?utf-8?B?VXRLTktwYks2Vi82U2tDMUI5Y0hlalZSU3YwcnMxaytTR1lsRW5rMTJrKzZH?=
 =?utf-8?B?c1pMODlNY0xJdFR3ekdWMmV0VzE0MHZ1OVlOeDV1Z1I1MERPaWFFTDd4ZEY4?=
 =?utf-8?B?clNXK1ZUSkgxZGZ6U1RVNEpjRVVSOFJHOGV6RWlPSzJhL0tLQlZIcE1HQnVV?=
 =?utf-8?B?MEtYTHZzdWM0aGhRd3ltbHRaeUlrd01jNysweTd1QURBOVA3NlZvYkRVbi81?=
 =?utf-8?B?akxKbC9WUThuQkhJMmlYMGhXbmw5ZkFhQzFnNFNyNnlYNXlPWVU4bFFITnZV?=
 =?utf-8?B?WXlrTEh1d0t3RUR2dWl1TVFyRXoyOWxtaXNoaGdmTVFVWDBwLzVJMHpLS3JY?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wpFpuiD+0kzA9/h25kAXk3/kDNIQUWJp5oj4OOxipJmvfDY/bf/wctyhB88NkYt2ZK0HyojT8A0gbFd7Kbeq1//Vo+REwhOxBh6+/TEJHrtUefE03nxmj5lVpyQLr9S+SJ0iNHvgy6L/YhGIqYE7E47k9dMTSsRui+8KlPVgiIifRt5tVPu5CJJ3QDrDUvwkY7Yi2dmGphOLcjviUkcIVmtDHXmsOx80gKxbtdyWVBEFKVJktqjP1++O64xWNgDzqOti4yT9MmyBtU0EX/FXTBuuSG3TUD8KSxK8So2w8B6M36YsQo21k5G8lVFveTsX9zzJqhBK3bhivBVTaL74cR+gORDBuFSWpqKpg11WAPXPabXJf+h2iLa1eG5LJNyABawE4dpY5ajO27D87CIyWOcTsZ8/0MJxTtzUG6bRP29YGFs5m9RFqI2c3351+cX0yZoKTE7ue4++SEGKNwLEZrxBIKfF2+upbhEsBJccMESVa2tzVjXDrMumOwllKSa58OKwKHpvGca08x5DjjtYZf3j91pX9iKmngoEM12zsmcoQ3JGMMEjZYdLojJKXgojippAa4OBT/oWcvrdwfDGMQPUMPqPnggEm1J4w1/ARGc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb107908-e870-49ea-3461-08dccd93b47f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 10:15:45.4135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSiC6Ot2bRlzWjPeyWOmrBvOZ9fifL7R3iUAw0AsXF+svuhWxuLjXf21zCbkmpX4OnJ0Ild30gu7DQx/X8hEYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4827
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_05,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2409050075
X-Proofpoint-ORIG-GUID: h9kxW6igfyktRue-ekJZ3P1WNXsvRn9j
X-Proofpoint-GUID: h9kxW6igfyktRue-ekJZ3P1WNXsvRn9j


> 
>> 1. As I understand XFS untorn atomic write support is built on top
>> of FORCEALIGN feature (which this series is adding) which in turn
>> uses extsize hint feature underneath.
> 
> Yes.
> 
>>     Now extsize hint mainly controls the alignment of both
>>     "physical start" & "logical start" offset and extent length,
>>     correct?
> 
> Yes.

To be clear, only for atomic writes do we require physical block alignment.

> 
>>     This is done using args->alignment for start aand
>>     args->prod/mode variables for extent length. Correct?
> 
> Yes.
> 
>>     - If say we are not able to allocate an aligned physical start?
>>     Then since extsize is just a hint we go ahead with whatever
>>     best available extent is right?

---

> 
>>
>>     - Does the unmapping of extents also only happens in extsize
>>     chunks (with forcealign)?
> 
> Yes, via use of xfs_inode_alloc_unitsize() in the high level code
> aligning the fsbno ranges to be unmapped.
> 
> Remember, force align requires both logical file offset and
> physical block number to be correctly aligned, so unmap alignment
> has to be set up correctly at file offset level before we even know
> what extents underly the file range we need to unmap....
> 
>>       If the start or end of the extent which needs unmapping is
>>       unaligned then we convert that extent to unwritten and skip,
>>       is it? (__xfs_bunmapi())
> 
> The high level code should be aligning the start and end of the
> file range to be removed via xfs_inode_alloc_unitsize(). 

Is that the case for something like truncate? There we just say what is 
the end block which we want to truncate to in 
xfs_itruncate_extents_flags(new_size)  -> 
xfs_bunmapi_range(XFS_B_TO_FSB(new_size)), and that may not be alloc 
unit aligned.

> Hence
> the low level __xfs_bunmapi() code shouldn't ever be encountering
> unaligned unmaps on force-aligned inodes.


