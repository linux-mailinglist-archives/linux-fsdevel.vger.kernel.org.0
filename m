Return-Path: <linux-fsdevel+bounces-54330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EB3AFE082
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 08:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52815843C0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 06:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D502C2701D1;
	Wed,  9 Jul 2025 06:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="iWDHlPQB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012029.outbound.protection.outlook.com [52.101.126.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7EA2701C3
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 06:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043837; cv=fail; b=kCqH09r4WeWsHxRwxT1jGQNkkOqoVUDO2SAv+e6hOmceyq+8yvbQKdWWiEviFTDOugXTAnlJN4fWZvKcI9QghNLgdBsgfyfLc9MZi/GZN+WpjDVY9Xie+LxS7OSDCqLNesNunXx3ldaTWM8aPe3Hm4wG/l361FSjYeWBd1wCCmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043837; c=relaxed/simple;
	bh=iHz2Zx+6vxSsJsLU+2K6h4Mq/HcxIkwRv8Ovqqhd5QY=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=MEhlBoXe66Vx8ZqUBoxfTLQuUvv+umKYYnav8VRRfMJGXRTZ2dcelzdpSqR7385iLooFxGrVOpgkNr49cwAxt6yj41BgrBebCT7ER3t5sCSanLB2cb+P8h99dHIAmqfENEJyBP0L9EHh5EfPOKGJzdYhHaLDk1sLJwq6ca+yc0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=iWDHlPQB; arc=fail smtp.client-ip=52.101.126.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIJoIKAgoZyyDvSQLKExthhPouI8He6L40G7ey7DTdYcntZ9WUluOAy8ARJAx5Haf5J0CuXhqqPQN6CPT9TadsfTU/P0HmfMFFnmKDxDnKorsZmuFfE8mH48S5QlK84Rr+hRMMJmRBc4VS4tx9bp3NIfR1+Ei+Uuswhz07jk4jCN4TlnWWb/oENRWDhqtG2TBWIIQaQCYRv8Su9luFebUpUvy57VJgxuXJxDTLv+aPMS/+bs2lnViKUEXQc0EXoedEULu7hGYi/Cc30hMOxhy4Xt6EjOBdeY8FfYJkM1zXUbhMFI+5y+ZxrhLDnIkSJFa5ecO6HtayruE0mbyK5aOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHz2Zx+6vxSsJsLU+2K6h4Mq/HcxIkwRv8Ovqqhd5QY=;
 b=WAMByY9RMDjvwCM7fNPhF+5KI1roV1RgvZGxK9WHqPyyxYKNFk1iw2+tt5O+FTDiqrYW6I5co8Gy0s3BONTbgSy8upwzHOZrlzkf6A/XmRl4jtSRbl2jXhyjppN3vEWDSOsMTJuTdhgdm4C276cR2eo1BrdmgUZ278I92roCouhzx2b6EZWAt6niqVSoiaygDXC0FHwOH6C8LM+VuqpCwYRKBXsZUcfyZtRfO9g/bFVh/fuJdm4WbDzvi+i2RZ/McYqpHOHzY6XU9QvjNa8uu6SKUqVFO1iBT7dpScowfXRUAP6GWcssCKwf9FXlb44qYd6T7ijkkABfM1WZe3cNRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHz2Zx+6vxSsJsLU+2K6h4Mq/HcxIkwRv8Ovqqhd5QY=;
 b=iWDHlPQB8OmLwduSwnzrXFiqpDrW4paVG3E2xHflrs/08GTfup+0VnLNbBjwTza8+i61T3IpqqSp9Q2z99oEdujG81PuRfddpZs802IqcwDmL5moUN3aE6sMnCXlhV/xsDUmFVxzvjMD7mJAGfzW4asuuIf8K+6Rwq6F4UQ+/QXuRclzpApssSckLgAqeO9KyBes/G8Ku9Zwvna7eGoungZBqWp55ZlIPn5pjCqsz7yeoltMWnt7fYixMBGjd11jVRPSMINc9kM2dq2cugMVdY0BaGvLIjzJ8oOalVBQq3btIrMqk7p4cRMQlM98vdzt/7PlHXjKnhMIxxnxnQaFow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com (2603:1096:101:228::14)
 by KL1PR06MB7009.apcprd06.prod.outlook.com (2603:1096:820:11a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Wed, 9 Jul
 2025 06:50:32 +0000
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0]) by SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0%5]) with mapi id 15.20.8901.021; Wed, 9 Jul 2025
 06:50:31 +0000
Message-ID: <b28591c1-19ef-4573-bd52-92070f59586a@vivo.com>
Date: Wed, 9 Jul 2025 14:50:28 +0800
User-Agent: Mozilla Thunderbird
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
From: hanqi <hanqi@vivo.com>
Subject: sum
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To SEZPR06MB7140.apcprd06.prod.outlook.com
 (2603:1096:101:228::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB7140:EE_|KL1PR06MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 967673c0-e87e-454b-bb84-08ddbeb4e597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MG5TQ3g4QSttS21sK1pVbzhxYXRhblN3aXlqSGpycXRUdHY3UkRlUGI0MmFS?=
 =?utf-8?B?KzZYYURlRGd5MzErYXhUcFlUKzRDMzVkUzlmTnZiVk45YkVtWElYcjE2a1oy?=
 =?utf-8?B?YnQ3VG9LeERlOEdJdDQ0OFZhYXI0T2pnSkxaVmIwemphSE5nOTVDMW85akpJ?=
 =?utf-8?B?UFJwWjk5OVh0VUFIZ3c5K1N1SCsvR0Via04xdnZlcEEvWWlENkh0azFSUUVm?=
 =?utf-8?B?TVRJdXJnRTIra0lKQXpOWXpJNFRDOXBTUFlIZG5IdDUxRE1OaVNJYnZpZzNV?=
 =?utf-8?B?eWVDWUswZC90TDBUY3dYenhabFpYb2hyNzNwb3VJait4MTcvakJvOFpzRmll?=
 =?utf-8?B?U2xuYmpPdms1dlJCMWtUVUNTNVRyME5adWNmaFF3eWpUTFQzcVNyeHdmbzBo?=
 =?utf-8?B?M1NmYkFldFZwUlpBOWVLaGs4NURZcHdNejB4UGZBMUdFcUMvdFFibHlEWmFL?=
 =?utf-8?B?ekJyNXRVRXlmVXlicjZ4YmRTdElXNDJpMlh4WCtCQlZlRXF5UUxDTTlnUnJj?=
 =?utf-8?B?M3JoNDQ3dURMUkhEMU9CcnMzUDNZTWRGb2loR1h5R0hpMEFld3lURE5RUWZh?=
 =?utf-8?B?MlpjczF0a3MxRnYyODlickRWMTFSeHNaQnFmb3lvSi9wRGVsOElqWFYybHpN?=
 =?utf-8?B?SjR0Y1E4cjJVRjVabUdMMnRQMXhmanl2RjhQbWNjZHc3MnBkU1NNUXNxRzE3?=
 =?utf-8?B?VUd4MFJxY3lEa05YQzNzNkNqeDVNYk1Qdk96V1VrQ2dxcTl4ZEtCcHdaalNG?=
 =?utf-8?B?OTVidkxGSGJVekRCWllkSFZKYk1lTE5CS25JL1ozRjU2UjhWazVpcjQ5WHdy?=
 =?utf-8?B?RVhiTVdyayszRjBzbFFDKzBicnFwQ25EVFMyUHBMTnh2dUQzWHpJMTdNR1Nw?=
 =?utf-8?B?TmJSYW9HVENzWThGVFhXM0lhU0F5VnpPYTJ5WXRucTI3VTlxbGVSaEQ1YXlB?=
 =?utf-8?B?YmVyK2hUVk5HdTBXTGl0eU9xTW5QbkMvS2lhNlhhaXg4Z3k0NUVMc3VIWlJH?=
 =?utf-8?B?Wi9Da0ZjT0pKL0hDRWRHdzMxQ0xRU1FPTS9SaDc3aERwaFB5Y2JxUHVZdFQ3?=
 =?utf-8?B?QnNPZDI2V3dXdzVrYVNSdGNJT3pSbktiMHdXWWpIenlFRlluUytNRnhtcGRZ?=
 =?utf-8?B?WlRSNjBjeEJIVGE4SG1DSTJvVnAycUhPaTB4dDRZaDZGODJ4dUVvbDQ5dElJ?=
 =?utf-8?B?Tk95Ky9HMVpxZEU0M1BIMXNuaTFQbVZwUnh0VnpybXBWZkdxM1ZQdDdtNnB1?=
 =?utf-8?B?ZVQxbGpFRFJRNE5ydEZwUU5laTNsSHQvVzh6NVBWSG4rU2M0b2oyRHU3U0Vn?=
 =?utf-8?B?TjZnaGoyRHVicDArSzQ0cWtrNE9TMXZ4emo2S3lzUkRoQkJLQUNGRUF0dnJ6?=
 =?utf-8?B?SjJuYnJrVUZmdnRRQ3RiU1daUkl0Y2hEeCtSMUErWks5QXdMOTF3UDRvTDM4?=
 =?utf-8?B?aDFna0pqN3VFdzRGWlpmNzVUd3dUNzdHaWI3VnR5SXRjOUpzb3p3YkUycm5x?=
 =?utf-8?B?ZjY3SHh2V3QxRWdCMUpRMUN6RzRyV3doVXVMTWVpRm9MVWlldjRrMlJ4cTV0?=
 =?utf-8?B?OVE5Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB7140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WndiR0U3dUJSdTkrdlBRV1FySHBFV3pqWDRTamRsS05tdkE4QS9oc0czZjVs?=
 =?utf-8?B?b3pOZ3Rmb0FVd0xsMXFKUTc0Sjg4R0haWWhqamtVQnFaUmZJd1RRRGkyWS9U?=
 =?utf-8?B?MEZDc2cwLzRBSEdOMkJUTTdCMjBob1FJak5pcEc2ckJTNE8zSXpSQi9mRU5V?=
 =?utf-8?B?dDkyZmVMZ1AzZkQwdzdRMUpCMWhlSzZKVWx5emtxbXRKM0RQT0tuYW9tNWxF?=
 =?utf-8?B?Z2MwNkxYZzNMTXJtMkZ2N2ZQVGkrYmhocW13VEp6b0EvdGhsT1A1b1ByOE1E?=
 =?utf-8?B?R3cvZUJzYzdwellKQjBpZXJlUXorNGkrNHRlbnBXeWlJa0doOCtVOTd2OSsr?=
 =?utf-8?B?YkNFUHg4bm94dmF1U1d2RDgwbXdqRmpJeGVwclJZdXhqVDNmdDRZVVIwcEhS?=
 =?utf-8?B?YlJJek5DSTlSd203WUZXTTJPUVhjZyttVUxjK2phMWY1dzB4UWdIMFZ1eHdr?=
 =?utf-8?B?V3Q4WVVZMmovRTBlVDBQdTNnWTlxL1RVS3pwREo0RThmSkNJZUt4UCttckIw?=
 =?utf-8?B?elJiZ3gzZk5mOU9QT2Q0dHB0TjJaajdmOW5Wam90MGpndmo1NGhjTVVLaWY5?=
 =?utf-8?B?RG5ONlFNUXRtaEdtdUVMY01VYkNvL1FKVFVvaDR1eGFac1VicUlSUG1ER1h6?=
 =?utf-8?B?d3YraVJRMkRvejFaY2lnSDJ6TFZuYzVSMXdoZjhxQUljU0hQR1c4YXBDYkdV?=
 =?utf-8?B?aWE0UFdNNW9hbEtzMDAwRjI4dGYvWFQrSXZmRnprR2RPWm9hNDRiZWdFZGdw?=
 =?utf-8?B?R0NDbU9GRm9lMC9YSGhyNlZpWTQ0bmlmQVV4dVpGbnk4cGZKcXI1dDRqOEZB?=
 =?utf-8?B?eGI1bjIyZlZpd005em1nQnFwbG1oSHBabHdHM1RXM2dNMTYzOVFoRDNWZnpn?=
 =?utf-8?B?ckljNitiMEFuYUFHZGIxSUdkcTE4Z1dHc1NZbVpOVHFtYVJHTWZiVWZjOWJW?=
 =?utf-8?B?eVlDR1NxSjlvcE1JQ2dvK01rRnFkbzFwaDZOLzR3bDJ2cENNRCtSNS8yemxy?=
 =?utf-8?B?c2FMdGhrbzhqTHhpSXRWYk02SUVHcDhLR2VjZGJkZ3NQOVlSYUxxU0gxTnBY?=
 =?utf-8?B?ZFdwa3lxVzNkNGxUcmt0YXlVcytWZmV6V0w2ZUR0UWxNZHFLc2wvR1d3a1VT?=
 =?utf-8?B?WEN5R0JTbCtaangrbkh0dk9lc0w0RUZieWNOaFpyZTByQlZ0dmxyWVBvd3lU?=
 =?utf-8?B?dGErM2tKS1dhdU9XcnZjVkgwcXRGYUNEYlcycGEyeCtpRWZNSWt4UEpEeC93?=
 =?utf-8?B?bHI5WjBWcFFrUGhITDBOdjFrdEZLMjNaWU5IZGozREhGUnFHTmQxT1h1bGtE?=
 =?utf-8?B?Z2FSUVhSVEZtcVlabWIvc1psSUdEWmJvdDkvOXp5UEFLcU8vd214T3JiMEcx?=
 =?utf-8?B?WGI1Q0JuczBoOUl5azhRVjVzc2dpYjlGVVR5eTl1UzVkNmRLNWVRdERydzNU?=
 =?utf-8?B?VGNNWm1jakkyaCtzSHUwOTdUck1BYWNyK3p1TzFqMldaTkRYR09hU01VNjdJ?=
 =?utf-8?B?SXJacEdDVGhBNWd5Nnp2VDI1MGhSWWdRQU4xMFJUdTVIYlhpdzhrTWpIcGMx?=
 =?utf-8?B?MHZFaUJYQTFZamthYThzMEpvMjlxWS9FaGFoTk9sZXZJby92dmtXbE80QjBY?=
 =?utf-8?B?KzBTQ1ZyNEk0UmJ3WS8zMmR1SFdxU0FMSEZCdmR6M0MwaDNORWNZVUIxemZQ?=
 =?utf-8?B?MlZOcWM3cXVLZTU3NTNuSmZxRFhpNnVjaDgvVkVsL0g0Z1hYSXlUbUlGZU5F?=
 =?utf-8?B?M3p3eGJjL3ZncUtBUTNGZTc0ZFl5azNDa1llNktxd3l6ZjZMczluQitIZVdo?=
 =?utf-8?B?TWs5T2xNNnFZYmhwcmYxYzZoTFFoYUVmWWVFcisrd21OclY3MUFlLzY2VExh?=
 =?utf-8?B?cGtrQUdJWGxrRFBLNG5MbmJqd04xTGxmMGJ5OUdxelhwbW1CRnBtK3JQYm1Z?=
 =?utf-8?B?SUVMMUxFTVV2MVNqNGEvZ2hWYlZWNUwxb2tHb3d1TU00V3BVcHB2bVkxS2J1?=
 =?utf-8?B?cXV6enNxYU1QYnY1U3dza1JFUWgzNkJuSkhRK3BtZ29lZmRvWGxCb0dUNG9h?=
 =?utf-8?B?RGwraDVFQkZZL0FSSXBUN0hBclhJMnNNdjZpOUNRWW1KbGV3OWdxT2hjVGFj?=
 =?utf-8?Q?oDighqCTv9BNrFsvO2eWaQR4b?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967673c0-e87e-454b-bb84-08ddbeb4e597
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 06:50:31.4451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kAFe433mN+fSzorj6qnOg2EJh17n3GdVXrpsCq+N53w4yxNxPOUdQqnxrdTauyur1p6QYU7mtZiTg+YV/WreFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7009

sub

