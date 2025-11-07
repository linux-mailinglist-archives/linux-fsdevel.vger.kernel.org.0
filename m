Return-Path: <linux-fsdevel+bounces-67460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85827C40F98
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 18:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D953BB6D7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 17:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EBF32C33F;
	Fri,  7 Nov 2025 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PFF3m0Ga";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RfMP5rRs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4CF19C556;
	Fri,  7 Nov 2025 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762534946; cv=fail; b=sT3SEJ/OpA36J3r/LmOwe+UUNy3s6EdJ1mT5L19JDZ18CpOyKLGqwkRsSJo0K8leGcOHIMzuRnZYySpEe9/jzmUSZRvxPMVpU17TotAZEEhh2UCPy4uGEEpzuvWQ8OR7ZZcJJw46dL2U+X4M+2/UXStsjUfjW6KlK50FyktZv3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762534946; c=relaxed/simple;
	bh=Afax1b1JfgQBp1PaT6iF8kgFHlAgp8xONSGtpUF01Oc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GWE/A1qQ6aTPcPgLTGDXlyjnkshk7YQ+lyBFxi0yJWigkCn8J/mCat3yjIjoJ/k3myuLFAyEnAVt/Ku4kOEF6OsMsLDsG+8Aiw0pDxMwWDSVRsSKB78tjoIsc+/PLD+1B5UF6k+MpU4E9v70zIqa/p/EuBQHv5nhBplaq9Aqa6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PFF3m0Ga; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RfMP5rRs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7FLndU010110;
	Fri, 7 Nov 2025 17:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hc6SCFKnAYHANwDXfYiYw0JP6+xlAkFMSPoronrPXy4=; b=
	PFF3m0GahibfJhkkKgxGAbhYvnuVm3+5oJYz1GL/qo0+sN9qe7zxZpXbL47kIX+o
	Y6ySoK6wJrP71Ob2Cf19F3HiBimwFMnVvWyijKDf8qGxgJGD5zhXnbjQQbj1+rHR
	uyZ9BxPchw7PA+vMBEKnf4jLdV6DJ1qT3oem4/tNVyrDdltIflb+FumQsExkUvDu
	jXd+scvlh/SshOS+QzMM7KP0BSTFezADiENefTsJey8Lh6qkZAtu9sva04c3f102
	C0Gln1mfQPf3eGIYZsSRkO0vPF//cWbdFojTOTvTbQUWJTcig258xYz038XFFoWK
	ktQanTHBfInGZfanmCPi7g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a9jgk8bmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 17:02:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7GAFOC010927;
	Fri, 7 Nov 2025 17:02:06 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010013.outbound.protection.outlook.com [52.101.201.13])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ne11jb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 17:02:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5bCgaQhv4zkZ8rz4mGv1fchO0UBil9sD+erv8kkyCijKHuhdNpECSelmWoG19GLKvF+w0QxpkAywN7bU8abyJB9/ByERCdkf+Femjwi/pNZESbB81Cr6n/isNDEHaRIgZA8Z8k9ytQ6kh0E21BsXNPdIQucC2U2x+yvCTg6mfOnOVoUsrQzODJ1P1/fXwxpRDFpzYofWNx0Qnl6WdThwXap9P2Cu68UxAX5PXDrwseDj9tsnziWUCj4jJOUpCQ2DAPivvkA7X4uO16lWwrlXxY7G2HG+XistzjC+8wXuK05KgXIijE+mfDtiktHPNhi4JPQDJwgR4DxaIVLOuGrBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hc6SCFKnAYHANwDXfYiYw0JP6+xlAkFMSPoronrPXy4=;
 b=UhMyhsqV6gG3FdSKbt4PDoVS7Pwtv9OZX4PXe3pD25sWmdcV3TiH8jL+Uelo0mxhD07Vg9m6ICtHGsW6JJ7XPNMKZ6TviJL+neR3nhIoJOM4gEwMiJb96VlYtzDsladGpP1SxAt85vpxGbFmjQKri8Z74fjswsRSlDbqv2FSZV7SXF49Kdo4OqWZ4vCGPRzYCM5ZYeR6kXsUdaieKJZ3IEasURmE66WApodfR9uL7clAEPcIjzYQsq1JxJ+42fYjFf6OVGabmDci3S/WsepyHr8XsFB5gFHNw9QRqVDBV2Y0LWkBmjduqQ84XO69Kqcyk8QBNoj8hOorye0CrywIZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hc6SCFKnAYHANwDXfYiYw0JP6+xlAkFMSPoronrPXy4=;
 b=RfMP5rRs+FdmnfBfF4BprofuAdm+4SLydOPIQwSw7DI+3J9yQguL531Q6ev2uAtNH89K1CmkrVfur9P0SNopbStoV2+7BXW4xlapYlQkOBgF7/SGoXkWSuJ7o9pQLRzExJJRrNuQ+VNE0127ROZSxAhwHU7erq3KBl6/9sX+VpM=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by MW4PR10MB6559.namprd10.prod.outlook.com (2603:10b6:303:228::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Fri, 7 Nov
 2025 17:01:56 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 17:01:56 +0000
Message-ID: <951587b1-0c60-4ea9-9594-b279e8a19e5c@oracle.com>
Date: Fri, 7 Nov 2025 09:01:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] NFSD: Fix server hang when there are multiple layout
 conflicts
To: Christoph Hellwig <hch@lst.de>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
References: <20251106170729.310683-1-dai.ngo@oracle.com>
 <20251106170729.310683-3-dai.ngo@oracle.com> <20251107132949.GB4796@lst.de>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <20251107132949.GB4796@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:217::22) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|MW4PR10MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: c73a823a-b32f-4a0a-7354-08de1e1f5b46
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?d0cwVzV6cHVnZ2lDL1I4RitpV1NkY3ZPSmNHbkhiUVEyTVhDcms2NlRxc0Js?=
 =?utf-8?B?Q1VIWWhMNWlKTkZHWHFZcy9SWEo5a3hham1FYkt6TmFqVllHSVc0VW84dFdq?=
 =?utf-8?B?cFp3RXI1UDNBSGZWZytCTithT3BiRlJPdXVQd25JK1NpUWpqS0pvVm1WSU1K?=
 =?utf-8?B?ODd5Y0Z2RVNodTdnMmdGeEd5UVI5ckNuOXhBSzd0KytOUmRDKzZmaHhhbHNT?=
 =?utf-8?B?L05aa0xnN2JVcjgvZXhwZ0U4aldtK1hwWUJOd2h6VnhWazMrdFRxTDltRGVB?=
 =?utf-8?B?V3NBbktOdUNCOHBZcTM4THJSRVJHcXRPN2pTOHEyZFdoYnMyeTBBTCtCZzBY?=
 =?utf-8?B?ckF1YXpxd3phTnlwSDhTK2dqeWVmMG1rRWNzMTNIcU9vbmw0eTJNN213SkpK?=
 =?utf-8?B?cUN0dVpraXkyT1VsbHJTNCtveWtTcTVEN2NrUkFMYkRyMzljYWI3N0ptYXFY?=
 =?utf-8?B?RG44eDlTSUZ6dXBqWXRnNHE2WnFTNnRyTjFnbk9VM0YrWDRvMVpibG1iaFNF?=
 =?utf-8?B?ODN6VzQ3YUF1TTQzZ1lUbm9HU29jQld4RFBqMzBwaUh4ZlR0cVNuc2xDMklm?=
 =?utf-8?B?UE1oZWlPT1BTU1VRdUVvL3N0RmRWa2NEb2dKcktiTnFTMU1HMDg4a1FvcUoz?=
 =?utf-8?B?QnMyeS8xOXArSWVSVHlnbzhBYnFRTDk1YktRWitVQ3ZVK3VvOUdGMzdLdjJ0?=
 =?utf-8?B?UUpLbllUK2NqRVcrZmNnY2hvTVJsKzJuKzBHdXFKMFFxOTV3dkMrUzJOR2RP?=
 =?utf-8?B?eStuSVpFNENlbUV6TTVnZjRENnJDWkE0Zkg4bFBVTVVIYXkveTd0eGhXWXZz?=
 =?utf-8?B?dzJNUktWaFpNRE9HbVM2bmR3QUJxM3NvSWpHcFRNaWM4WkZLOHJvN0ZKUUVq?=
 =?utf-8?B?aTZXZlIySkhoZ05zbWx5SnJXK1YwV2ZPR05QUU42K2h4U3p6dFptN2hJUFFR?=
 =?utf-8?B?azBVOGg1SDAvVTJOMTdPYng5UHJpSjBxU1UvQ1ZMZ21KemYyVDdlS1NWQ3g4?=
 =?utf-8?B?ZnpFakV0elJIWHdFbzFiODl4Sjl0c2ZKL3ZDdE1yaXluVzBVbnJBTXRocGZx?=
 =?utf-8?B?OWsweDVTVFpxVzlVV3lpZExkaDBON1VmVVFybjdBQWRVNWZ1ODVSL3R6Nk41?=
 =?utf-8?B?aExOQUpJZFJlY0dncWk3ckFiNGovWWRRRm1VeGtaVHdXcGY4OVZxMEc4WjNi?=
 =?utf-8?B?RTdLVEZyU3hFL0lYY094K3hhWjA0WkxnSzZBQStoMUVNNmVxNzljekN0cU9j?=
 =?utf-8?B?UVBTQUtpUmtjZ0xuK1RJb0FpTkhKaXc5b2lsaUdVWldYdFE2ZVNyZVlacHV4?=
 =?utf-8?B?L09TRmNKUjlnSzQzcG5GSXlIS0xKNWdtSVhiNVpURXU2S20ya2Z2b0dIQWc2?=
 =?utf-8?B?V3hoVXNiMk1tMll2NlhUc1FZWDlLRnREZXRKS3V4RW0yVnI5b0tLb3FPK2tZ?=
 =?utf-8?B?d2E3MnJwNi9rdENBZnRJYVNETXJYdnJnRkVwbU51Zjk2Qk1RZHNmUWRGVnVm?=
 =?utf-8?B?SXZSRGpPNGFRRkZLdE5XVGEwdTMwcFU1aCtpZndFdEZOMFI4K2lYdENzaElN?=
 =?utf-8?B?RTFyS2U5RlI2dlhEYzhRaGcySWJ6cVY3Y0RleFpRZk9Hc1BUa010SmFWVWZr?=
 =?utf-8?B?US8vcnl2dzFBNVV2SGxWY0ZiZ3lnS0pHS2RHdkMreE1hNXh2TkI1YnhKMWRC?=
 =?utf-8?B?UVFVUUYrSThLWGJmVWJ3OWdVdjZyeUJiQUMyaGU4VWphVFFaRHYybkR2Q3Rl?=
 =?utf-8?B?SWl6M1pQOHFQYzljWm1TUm1leWxQcFNWM0c3NGIvU1dET3JBaFl5OU9NRTV4?=
 =?utf-8?B?Y1Z2TENNZXFBSzdwSTdrdXlSZEFvUWNqcHZXZnhzTEhKejJ2WnBSOVZBcklh?=
 =?utf-8?B?Rmw1dld6TzhubWxRV04wWFM0ZUtOZzVTNmVCRFYwS3drelZLbThyTXNsUlRJ?=
 =?utf-8?Q?p6a8IdNp1cUbxMGvRhuM+17ASHYAa49M?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZHRGS3I4dDRlSVlLM0U4OXNRVkRmM3EzM3lCWVYyQUZ6bXFsOThHMndxTTVL?=
 =?utf-8?B?R0NtZXpiZmVhRUFlWWRvM3pKMnkrR1dvN3dXYkJUWXZhOWtISUtVTkhyc1dq?=
 =?utf-8?B?MFJrVEpieXNZbG5CSDg0MmZUR010MG1maEM3Y3RLS2VBZml0V2xEMTZHcDRn?=
 =?utf-8?B?c0xtWFRXc2ZYakswcWNCRUR4MDZkeWdhWjFhdU00dUZTMHVQYm1MbStmVm1F?=
 =?utf-8?B?M3BReUs2ZUY4b3FmMm1nU1ZoVWw5cmYveWtiMnNiQ2F5Q0V4TGlQa1FkZTdR?=
 =?utf-8?B?M2J4aFgxQS8vYm5IdXZyb29kR1FxK1dwQytIOW81YWErUFdQR2g2dTVSVDBR?=
 =?utf-8?B?U2NrZGJTUTJlKzJPMFFpUUdONFVPdnhyWWJKcks1b3Bva2lZN2xjVUdlalZv?=
 =?utf-8?B?eE5LUDFhS3pHTTNQMlRhU2lvZ1c0cU9talczT0ZmcUtSWlhvUWJBZ2t0R3J1?=
 =?utf-8?B?YkhzeGxidFZ3enVzQzhBNEpwTlk1ejBsRndxQ1lrcDdkcmpnQ1BSU1ROSnJr?=
 =?utf-8?B?R0N5RCtjT2M0VGZqdXNONjJXSmg5Z2VyZVZ4VXA4ZGttYmlxZGJPV2NwcE05?=
 =?utf-8?B?cDJZNWd2RUpOMFVIZWtnUEl2V3J1c3NLWWc1dTVzUmZsOUtoZ0d6cmFZaDNF?=
 =?utf-8?B?V1EvMGlPVE5MUGl5eDU3eGF4WFJNTDRWV0Jsb1I1R3UxelRtRXk1ZlhnOEEz?=
 =?utf-8?B?NW51UjcvdjBnV0tXbHkvaGs0Y0JGVEFUaGJVSmFWcEl0ZmdpVk5jYzVyRk0v?=
 =?utf-8?B?VHVEejJIeVpZN2tyUXAzb1RYd0hTcVk2T0FIMEdDelNqZTZCcXV1dklaMkpn?=
 =?utf-8?B?SUIzMzdaRHZ6aEhsVFZkbHNGbU40NTgvRkI1THgzVHRrWWMzeStENTY1MCtF?=
 =?utf-8?B?WnRBRjNPaHJ3eldDS1pnYnl1ZnB2czdwb0t6RkNQU0ZweXkrSmJ0UXFNdEJD?=
 =?utf-8?B?dGMzZGd1VXBieitodmxoenA1clVMZFdFc3k1dWNLbVREOG1DbUtBUi9PYTl1?=
 =?utf-8?B?dzYvOTF5am9aeTdxaTRLaU9xbnNYTGxscWcxMkNIZVpVVVhOSDRxczlIZ3pn?=
 =?utf-8?B?V0g2YlNIUTN0RXJuTXhSY3BPM1Z3WUhVWjVVbHlNZU9OdGZNOFd3VHlKV2Zt?=
 =?utf-8?B?OGJzclFXMzJOL2dXSnVacTZOSFF4N3JOYURYSDR2ck0wck4ycGMzR2RlenJn?=
 =?utf-8?B?TXVOSUx0cVNuWTI3NXo4UEg1YS9ERTdDYmU1ZFMwVW9udmlIYytqemwzc3do?=
 =?utf-8?B?bGd2RjQ1NXZxZ293Kys4aDBNYlRqTEtEK0dma2Q2L0RML0M2QlByTGdJWXZD?=
 =?utf-8?B?TE9rSENzK0dONjhLS3d6Tmw2WE5JaVd1ajUyUTlmTzh3Ly9SaHdqcXBVTVJK?=
 =?utf-8?B?TnFxMis1cWRIOC9JTU5QSjVrQ2lNcjB1YWxia1hROGlPMXhLUGxvMHFkVVJC?=
 =?utf-8?B?bHMwVWo2T2Vtb21BdzlLTWtpcXJFOW1xcm96Sm9SUnJrbHM0emFPN1ZwOGVU?=
 =?utf-8?B?ejBwVnhJT3JiUE5vdWcxa2oxc25UUGtWZFBqY3VaRjBZMkEyZVBBb29qRm1M?=
 =?utf-8?B?aVBXRTMxZG9QTWlVTzhUZ0FmTXBJY0tHL1RSUjNUVXBpS0ZBQ256RUtDUHBp?=
 =?utf-8?B?ejkzNzg5eDdNUDMvTjE4YVcwUWNHSUpDSURlK3NXanFCTjMvbEVNK3JnVVZY?=
 =?utf-8?B?Ym9INlhpOHl5RVhVazVHa0pLM1AwTVhFajVvZDJXMFQvaGRiaENvZmY4Zktn?=
 =?utf-8?B?ckFQa25aR21pRGQwUk85VzZHcGZ1THVGcThtenZ4d3hHamoySnhqV3liMTdI?=
 =?utf-8?B?RUJoM21QQWNNYkp2UC9MN0pXeXZmR2h4Zkp4S2xDaElTeTcvUThDeW5yV3Bm?=
 =?utf-8?B?eCtnaEZMNHJTVnBvQVNYYTE2RkFYNHIwNnp3QTNQRWtsZlh3L1BDTDJRVDZK?=
 =?utf-8?B?bUtmdTVCQlI3SlI0NHNRT2cvMTlGQmxMenpoWFZDU3QrQStjbkdwdVUwOWh1?=
 =?utf-8?B?ZXVydnNBMnNEZnU5WDh2WGRtNkIzUXU0MkE0cVd3YkRUanJ1NlpOWHZCS3ZP?=
 =?utf-8?B?ZG8vRTdsR0h3ZnMrd0hMZCt4Y3dKaXExRW1uOU1Jcnltbk9MUWNyUlBORTBn?=
 =?utf-8?Q?/1+slcbvxdYJ14yYCN9lpvl3W?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e5tNpMijTFw9AS5yn3HTt0xiZisxQy5L13/G4BtruB5hU9kHQmFUVdpPRjG942Y6yl43/XE99y1kibt0Q5T4fLEOR0eamLjkyuMGHLU5DogT5jAFu+TlL5f2TINC/vhKZXhxaaApmk1sp4tiatNfWUVehkA0nbZWFioYD6CQW9B8BOPgcE3Z/PvGqY2E1r5TSa0R9LRiYpdunUV/ZTwaUyc4DN+2For3aoYxb+tA4R5q4JwCfmcQhyrdlDeSjPOsagGQzOqCSc8dzrW/tP8StHHMAruq83jwdbEurAvSdJU6guU8oFSzRr/L8EGUdfWPNHke7Jd0hE/XTgySjzAHtTF6MCKPZ/skNSUlnE3G1gfA9Ubz+b7tPTi4+aCzn6nsb598Wb1cygi3WYPYVlnTIoAHL30N5ZGfg34udxtqtgyC//5p3QusTQysAxV8jU6b8gTG5NsQmsMhmacXY+rn9R9iL+a7euEQDOtXyEdC7+W0BGCi2A1kApZO/Iw2+reNZtm4FYxv6W6A2jraRcxV4y5NX3zgH4w6nZ4LWRDCo9mfQ1yzhCXQml6ffz6C2U2ptJWaPKlp+hixkb7x1Xgo9WODtqBFTUjKLS1O6eP5vTQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c73a823a-b32f-4a0a-7354-08de1e1f5b46
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 17:01:55.9280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhBvUt1NlXWwrqn/Z31C5jGqsfSPW85GsUlUxYYDcVUpRGf0IKCY9VvfrYf4e6WqdRjPJivYCc3YZUDN/B2ZRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6559
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511070141
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDExOCBTYWx0ZWRfX2jTYh0h70bo+
 yVH2oK0QEC7EZ0KF7CZJZKD8u9yS3LHnguIFMuk1TZfAzdI1mTkkmO6NTTt6a6FMRwj5W/I+jzK
 A85fsYHsgndmdgG6yBgtRUB4sYQ0lNdfdlHHLilR6YkJ75mDejajw17bFJxTIt3sV4VkKGEMlgd
 af2tNJ5oLffw6LrID4d55DGWLoE5iuvvhYbUlPwpDjUpSDza8Kk7pZAejImBTySoYXQqBHN5ZzC
 4JqeJMXwLFVKow6PYXpy50LDbFK4qb/ErDIYl82oL0lUYaOB5RNKKBPcaYKlZQaSv+P5RXSEGHV
 ztVg8A2YbVuUTC9w7ppQKv00bWN+YsdLiLTUi0mrPztVXkELk2kebWX4mxyjShWirzPnPj2Cx1T
 6bLMRcbM1TXvAXjbUyaPfbvc8fZdmw==
X-Proofpoint-GUID: qFYzs4WL9pKOlv7-QUjwQ96fo5tblvYL
X-Proofpoint-ORIG-GUID: qFYzs4WL9pKOlv7-QUjwQ96fo5tblvYL
X-Authority-Analysis: v=2.4 cv=Utpu9uwB c=1 sm=1 tr=0 ts=690e260f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=9L22TkAaFcIsdpkdzAQA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22

On 11/7/25 5:29 AM, Christoph Hellwig wrote:
> On Thu, Nov 06, 2025 at 09:05:26AM -0800, Dai Ngo wrote:
>> When a layout conflict triggers a call to __break_lease, the function
>> nfsd4_layout_lm_break clears the fl_break_time timeout before sending
>> the CB_LAYOUTRECALL. As a result, __break_lease repeatedly restarts
>> its loop, waiting indefinitely for the conflicting file lease to be
>> released.
>>
>> If the number of lease conflicts matches the number of NFSD threads
>> (which defaults to 8), all available NFSD threads become occupied.
>> Consequently, there are no threads left to handle incoming requests
>> or callback replies, leading to a total hang of the NFS server.
>>
>> This issue is reliably reproducible by running the Git test suite
>> on a configuration using SCSI layout.
>>
>> This patch addresses the problem by using the break lease timeout
>> and ensures that the unresponsive client is fenced, preventing it from
>> accessing the data server directly.
>>
>> Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4layouts.c | 25 +++++++++++++++++++++----
>>   1 file changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
>> index 683bd1130afe..b9b1eb32624c 100644
>> --- a/fs/nfsd/nfs4layouts.c
>> +++ b/fs/nfsd/nfs4layouts.c
>> @@ -747,11 +747,10 @@ static bool
>>   nfsd4_layout_lm_break(struct file_lease *fl)
>>   {
>>   	/*
>> -	 * We don't want the locks code to timeout the lease for us;
>> -	 * we'll remove it ourself if a layout isn't returned
>> -	 * in time:
>> +	 * Enforce break lease timeout to prevent starvation of
>> +	 * NFSD threads in __break_lease that causes server to
>> +	 * hang.
>>   	 */
>> -	fl->fl_break_time = 0;
>>   	nfsd4_recall_file_layout(fl->c.flc_owner);
>>   	return false;
>>   }
>> @@ -764,9 +763,27 @@ nfsd4_layout_lm_change(struct file_lease *onlist, int arg,
>>   	return lease_modify(onlist, arg, dispose);
>>   }
>>   
>> +static void nfsd_layout_breaker_timedout(struct file_lease *fl)
>> +{
>> +	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
>> +	struct nfsd_file *nf;
>> +
>> +	rcu_read_lock();
>> +	nf = nfsd_file_get(ls->ls_file);
>> +	rcu_read_unlock();
>> +	if (nf) {
> Just a little note on the existing infrastructure (and not this change
> that uses it)h ere:  I wish this would be nfsd_file_tryget and the
> RCU locking was hidden in the helper.  At least some users seems to
> miss the RCU protection or rely on undocumented locks making it
> not required (maybe?).

Make sense, maybe for another day.

>
>> +		int type = ls->ls_layout_type;
> ls_layout_type is a u32, so please use the same type.

will fix.

>
> Otherwise this looks good to me.

Thanks,

-Dai


