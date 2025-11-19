Return-Path: <linux-fsdevel+bounces-69125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB35BC70589
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 18:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 657803A88E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 16:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2A03019A3;
	Wed, 19 Nov 2025 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o3Z1H2ec";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YEHh1UuL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564712F12CE;
	Wed, 19 Nov 2025 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571222; cv=fail; b=Jbng27JmPgW47lSEzyOFe+Oi6EFgyHAQ3F5N36twfmhSQk5KvwH/aNDc8LvqDejzvDMjE9P7Famg0qAD1zuD1Tap1jgDsIY2b4MxjoPBDyz07EHskOx8FIHreUXcbjXBmWs/1QGpzUlKkAAsOi8sHJ7drQHGwX2WNsfic6jJ3OI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571222; c=relaxed/simple;
	bh=toSKGKoO8BrIyEJNJ5u4CRRVTgITNTBZReomkcORl9I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PBqRiisUYuAqZ8i9bvY+yY53pYEnZw4tZKymdDOshrLAFs0IXDnFZfFHJAoPtN7pfPoUaOGOIRuETGkdynQTdsvBxdjdRV3IqXNYkJsgomoiWmnXRaAkbjj5IO6t7AUYWQIxqN7QguzvaASQG5LclhGjZBcW9dRYF7FRZRFt4ZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o3Z1H2ec; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YEHh1UuL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJEg1JU005127;
	Wed, 19 Nov 2025 16:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=34D1Ehd3Fbmpjw3F9ImOrUAVD/Lp/zsrcBIWcbw/o0A=; b=
	o3Z1H2ecV4OAW0yc07kHTaPql3vUuGmoDLxVIOQOQ3LLlG5jvTNw/BB2nXHWyeFC
	bRFBgIlx/ehs1yquthk2pivW1y40ShA7pF48qGb+3ucQ3YQ6R6j9kTKNlVWJO+gz
	o7vtdyauvfWEwBOrc8jyoBXVsSBZzhpUjcEoD3vno6GZtxHGfRtYS0rpZAN9ZSIb
	XdwlBHFGHhuk7e90V4CZSZA22hP3MaGflH/4HjXWZ1wL35LU3guoVPRtmwh4BBMK
	B6Ku7pjm/l5YUiHZhijRxpaXTsmlhMGaluC1Lgkos8AXhIbCRbIoQQ100Pk/zQEG
	EMDtHyfwx1Vqoe/JlWgRqA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej907hra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 16:52:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJFLfZ7039894;
	Wed, 19 Nov 2025 16:52:31 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013021.outbound.protection.outlook.com [40.107.201.21])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyn5rms-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 16:52:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZe1zJ9GIrLQqZuqhimiyeCqG4YHPOAYFtoSPiQ/TtpLf5jgVOdE0RE7ydew3m2Tdpa/x6MP4HOdQ6PIiD0qxa1m/xjkgLu+yvugy4AuOPPDyLvmCIyYiHxr9OeZyApPEtD4aoxpUXAcegJYRXaaOroGYOpKcZFltAEl9t2e8PHQ5tIOGiuXY1Rq//n+TgCQHNyRPSlKwjEUlh5vcGeN/1LgmcQuQRbnJAmoD4JlsKuI3dPanI41z2jE0vAgtchs7jq/n2Z8RHXKlfytN4J0xx7MVz1VroSAiYnlLKu14TLo1WED+mDYNBDtfsmBCHvDwpciZAImVQSa9neaV2AYiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34D1Ehd3Fbmpjw3F9ImOrUAVD/Lp/zsrcBIWcbw/o0A=;
 b=xCJH1i7lcUY6FBuUu1xy/LhHNq3VjOX77iZ0iRW8X86MLOg4WrOoMm73vkYgl4S4ZOQQxMln9S2qTydcA9qL6FozKIPD1530gAauKdid+99jWtb9V5RBLxZaMgtaps9YqGV4Akego+Yit/a9IqDqJkBZnFvvPbu2JHbvRizSqIujYGZEVPrHqbF3IYJh5eElPPKq6QHHNSfCogp7kAoGQOg3uqirr/d7nmQBqNFsZ6O1nfnmBUr3dHq3WDbMAZs5XCFJdP6pHWPpM2E5ilS4EeaPbnHZA1izeoC5MJ5iin/t4drXu4frJUdt1ZS60rH5mgA8kt1+Kz30d2FHL75z6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34D1Ehd3Fbmpjw3F9ImOrUAVD/Lp/zsrcBIWcbw/o0A=;
 b=YEHh1UuLGzUYu+M9dIAO+JmaED7nDS6TC8kh0lZStMRH53JGbMqgzM5ljuVoeiWK28lfcXFUj7ikZ4eCPAOqp9B3uBKNZbb0sw9gDAYrTOMHS+uOFGySRYAlTrcLCJj1uT12+kPDiIgZR8B+MmYfg5feGAGYRVGLrHZ2iyc02MQ=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DS7PR10MB5165.namprd10.prod.outlook.com (2603:10b6:5:297::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 16:52:27 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 16:52:27 +0000
Message-ID: <8f7653b4-deef-4bda-bf17-e06c2f208135@oracle.com>
Date: Wed, 19 Nov 2025 08:52:25 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] FSD: Fix NFS server hang when there are multiple
 layout conflicts
To: Christoph Hellwig <hch@lst.de>
Cc: Benjamin Coddington <bcodding@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>, jlayton@kernel.org,
        neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com,
        alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251115191722.3739234-1-dai.ngo@oracle.com>
 <20251115191722.3739234-4-dai.ngo@oracle.com>
 <d7888dd6-c238-45e0-94c0-ac82fb90d6b6@oracle.com>
 <18135047-8695-4190-b7ca-b7575d9e4c6c@oracle.com>
 <09209CBD-6BEE-4BCE-8A13-D62F96A5BD87@hammerspace.com>
 <aeb05ba9-83c5-45a4-a75b-f76fc4686e7c@oracle.com>
 <20251119100800.GB25962@lst.de>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <20251119100800.GB25962@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH5P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::17) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DS7PR10MB5165:EE_
X-MS-Office365-Filtering-Correlation-Id: c4f09609-5e16-42cb-4c80-08de278c05a6
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bHdFZ1RFdWd1UkI5SllDS1p4WGJmbUNPVFoxYzh6b2I4bTVWVDVUbFI4aXBS?=
 =?utf-8?B?UnhXOE1RYlU3Z2ErYVJnU3NWODhPMkxhTUFvTVNIVTQ3ckkzWUpVMnZHTGRr?=
 =?utf-8?B?SWl6Z2JWVHlCWEpoQ1lrT09USXZtMFFLWm5MM2VkSS8zKzdTOEZTc2hMWUN4?=
 =?utf-8?B?ODVTUWdwdnR1T08xZ20rdkZsQWFidjVaemdjcUNMY2U0d29xaC9Ubjkwb3FO?=
 =?utf-8?B?QTNGVWZOUzV5anBuaUVsS0hzdXZBbm01QlNhTnA2bUV0MXhnZWVPUUp5UmRR?=
 =?utf-8?B?NS9rbitlQi9NU2FWaERhOE9YUldsZUltU1lXMkw3UiszeDhnbk42Y09SY0dq?=
 =?utf-8?B?WFpqRG1GUS9OOXM4MXZraUhJaUw4MlUxMDFrZllQOFhldi9HbzFSM2czdTM3?=
 =?utf-8?B?NGovSWJHc2ZTQm84Wlo2YmxNdzdYemlrbDNsdTI5YUZTVEpZcEVXeW1tWTUw?=
 =?utf-8?B?bHBvOThaVUhFWnFGMzVLSG4rRHRTNmNuVzF4NTFnTFRPeUpwMnh4c1pUd2RF?=
 =?utf-8?B?c1dEd0hqUFp3ZVU2SWpnZDFxUE01Q3U3WkRBQ2tlZHFOaXhqSVB1OFZ2ODN0?=
 =?utf-8?B?ZW45YU56cS9tUjh0dGd4UHVZWklqeXBFVEpQeTRXUThVZ2dwOEF2NzJLcDNL?=
 =?utf-8?B?K2NQVThVeVRlMUNxZllyeVV6TnZFZE8yUWp4aTdteUVsWCtGak5Sa1J1YjJT?=
 =?utf-8?B?cjAwSUxjL0o5by83YytYcFZ2VlN2Mk9OWkExUXBmME8rT3NYc1pUeDFjZ0dR?=
 =?utf-8?B?NTdFY1VFbzVjT1Vva1JlbERwS1BWb0dQRnF3YmU1U0phYmo2bk8wRUV2empG?=
 =?utf-8?B?bGpTSGxLRU1rNWhnN2NYSWdzUVFSeElLNyt1aERGOEx1d0o2S2taZEtHZkNE?=
 =?utf-8?B?UnN2WGFaakFwT0ljQnE1WEluOEZZOXhxdkRYQTBlVUErUTRhRU16VGpnV2FF?=
 =?utf-8?B?R3VZQUNQSDIwRkIreFBWRmRnYXo4aURYNThOamsyZWVudUZTNy8vdm9NZElT?=
 =?utf-8?B?bEx3UEhLeHA2dGdyR0VCbGcyMVpMVE92S1JiVXczdk1tVEhOeXcyZUNIUk1n?=
 =?utf-8?B?cjF3WCtCdElsN3MzMXA2RFpFckMzaHB0SE9LblVha0kra1l1dElUdE81VFEr?=
 =?utf-8?B?eS9tNXA5bGwxMFR6M2FZQnphRjhYT1RTdDRwVHRkVXY3QzZGTnFkVjJ0aTR3?=
 =?utf-8?B?akRraXZ5Mm1lRU5TUHE3UG5hcU5UZ2ZzV2dGa2J5eE1WVkNRVlRER2daS0My?=
 =?utf-8?B?eFhCVTg3NkFoZGJrWEMxbzNLdldwSWk5UkNkYmcxOGg2ckk2aU1TQlByM1po?=
 =?utf-8?B?RTVSU3UrU2FPb3hDVkdGbWJuOEJWOUpzY3cwbnFzYk1QK09ZNnF6SzYvRmYx?=
 =?utf-8?B?ZU0ya0FmRjkvUEZpK3NRcDhxV2M0Z2hKVVZsc05naWcrVEZ0MEYvWHhpSHJW?=
 =?utf-8?B?WkNVMmc1R2VxcE1UWVo3NUsrK0tRZC9RQ3lydWppb3lxTU8rMVJjQjRWYjBs?=
 =?utf-8?B?WFFqNWM5aE00aEZLQXpVT0NBWFdJWlhTM2ZyeWlpN3gwREg0VjF0eFNtTnNz?=
 =?utf-8?B?NEJ2QlI0NUZsUHdIQk9XWDVpbmRQY3pRSGxJRnpTUmJTWGxIUFRsRVJZNGw2?=
 =?utf-8?B?ZkhxMGtudUFLWFVIMDFQUVZGUDlWZXJ1bWx0L1hxMEhFMVpkSmtNZHcza2Ev?=
 =?utf-8?B?TzZVTmQrNWJIWTZtaEh5MEV3MHlMNTIrdkY1YzgvblFMamlMVDhWc0dUckl3?=
 =?utf-8?B?VzhDWWhjbC90VUlVQXRja014MldSeWJ6bGdVUlZjaHg2SVh1eGFuQkVnOVZv?=
 =?utf-8?B?NDhYdWs0dkVhamJIUTZwaW5vUGpnL0c1Rm1VOVZJaHlpblNBRG5hY0xUcHBD?=
 =?utf-8?B?bHZFdVdvK3Z5bXFXSll5ZHkySHhpZk5EckxZclgyMlQzbERlRnlreE5XNXE0?=
 =?utf-8?Q?neLrvCfFYmrSeLt1XNCLsPOHpVG254TU?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eTljR1NKcUJJL0s2clBNaERab3grZEpaNzlLdEVzTWdiKzVCRlU3OENWbWV0?=
 =?utf-8?B?SlZydVlJM2pxa1d4RnMzV1JpQTVMM1BLblBPcTdkQnc1QXR1ZWZ2bUs1S2Qv?=
 =?utf-8?B?K1NmcnBHMjkySmNoYmxsV3hBTFFkVlZIVEZKMTNmMlovUGluanhPb050U1NN?=
 =?utf-8?B?Z242MFZNT3FyRTNGSm5uWXE0T3VXc1hHdk4zaDVyVWV2dnhMRmNLVVFmQTVl?=
 =?utf-8?B?QjhqOHR1UHBBRUlwZG5KKys4S2F3SysyR2YxdG9hMUh6N0pRM3piK29HU2V0?=
 =?utf-8?B?YXZhT3NobjRmVmE3RlVzekkxZEdWVnJKWlgya1QyN0ZFYWVoZ0x6QUdoZDRS?=
 =?utf-8?B?QU1DMEpJeW1OZnZSclZHajVsYi9ZZmZxdi9UbzJUa0Z3enVsZXV3cHo5MnVt?=
 =?utf-8?B?V0FzL1dlNU94Wk9YdW9XcUxTazRMYTlIaWFkKy9ISGtsQUVQcDVsZ1NZSkxM?=
 =?utf-8?B?cDhYVzRycUpMdDRqMWU0Q1B0Ly8xdzU1NjVQWXFJK2hoZ292dkxnb1RNSmJY?=
 =?utf-8?B?bHFZZzAwdENYQXk5c1IyYUlGZEdpZXp4YTYvQXczNmFFTXBSTlRJV0REb3Rs?=
 =?utf-8?B?Z0dtVjBFaWdQa1ZINTN0UzlEL0dPWUxwN0J0VGJ0SU1VanVvdDJ1eUpyMGdz?=
 =?utf-8?B?N0syNE1GeHV6UTROOHlVc1YwZCt0NzcyTGwzMVZ2YTM3TXNXYmFxb2tmU0pJ?=
 =?utf-8?B?MWJEb1Y4RGF3cFMxeUVwenlhdk9QRVdlSUdlM0JIMk9ENkYzSWZaVm5pdTNq?=
 =?utf-8?B?Q2QxNzBVeEZBNXQzbTZ4ekN0ZitXYldSVW94dTBEdWtkR213T0RYVEFITTNv?=
 =?utf-8?B?TkNTYUxPOWNoSDA0UC9kdDY3eHl0dW8xaERsMFozV3RpMEZHcXZpMllBS0ZN?=
 =?utf-8?B?bjROWjFCMHRWeXM1a2pnVWFJY09xOTMxSVROSVZMSmxQR3pGV2JvNEwzU1VW?=
 =?utf-8?B?Q2ZXaWc5Q1IybGI5czFSS2Njb2g1NGZrYnVOdC9kV2VvejVjaTdKckk3MGV0?=
 =?utf-8?B?VFVDSHFSTnpYQ09Nb3dLZWE2TU9mVEwzVDk4bXcvZi9RN0tCbzRQTnlhRVZi?=
 =?utf-8?B?emE1YXFoY3NYOG5FUk8zUXJBbmU0d1h3bFFCU2dVa3ErRFV5ZHM0TFpOLzF2?=
 =?utf-8?B?NkZvZGkrU0xKdzZuQWJheXBYbjV1aXJLcWZITVBLN21UNlRsRXBJTnltRUFL?=
 =?utf-8?B?ZVFYMlpHNXk2UkUyZVB1dGVaaHJIQlVadEFhdlF3R3Z0K0pRbWFldVBqUjI0?=
 =?utf-8?B?ZWUrdHZoWXF3WkVyUkw2c1IxaEpSTWs3cXEvUFZlNUtIeEpDenAwNzlSR2Ev?=
 =?utf-8?B?eW1uc0FwaEs3a1VHSVIzV0k5MHdYKy9wSXVobURudEwyL3REYmFCbkJ6S04w?=
 =?utf-8?B?Ymlrd2IwY1BIZWFGWjkrdFExZW9MdzJDMUlsbERtaUlldytrQk5NakRlalJ4?=
 =?utf-8?B?S3Yvb2lWbUQ1bHJVVWxVd2hxMitPU1o3Z3lPb1p2Y0N6WkVEQjRwY3RlOGdY?=
 =?utf-8?B?clhQWmlNalRMa25VQkdjMEhSR0lISHpLcUhUUDl2eEl2a1MxZlF6SXc2WmJO?=
 =?utf-8?B?c3A2VEE3LzZqdlhFSjVJM3RlUjhiOXFaOG8zcVZUT1Z5cGpBcWxpSEV6UkY4?=
 =?utf-8?B?dllkUmJ5UHdaWnBaZnJsMWF3ZTVoVUZ2QTJOTmRIZlh1R28weXZnaU9nMTE2?=
 =?utf-8?B?dHYwYzdxdE9jNjh2czErVFZmcW0vdC9wZUJQbnlmZEVVZHI2MHVFSExMWkY1?=
 =?utf-8?B?S09TUEFJZTIyYWl1Y1NTL2FDSlB4WDFTRkhjUVhKZ0s3ejBNcm9jWjdEeGxa?=
 =?utf-8?B?RVVxMzRSYWJNT0JudHlxQ2NPdEQ1RnlWbUVEeCs5K2JDM2draGxobmVNVUpR?=
 =?utf-8?B?cEYzWTZweWoxaVVxSTFwTytnR3p0N1h2cmROU3BBcGtIWDlTdUJVM0l5aWdw?=
 =?utf-8?B?Ly9aREJVVWk1bjJCU3BSYXUzZEI3enprSEs0MmZPaC9VUWM3SnlXTE00U1M5?=
 =?utf-8?B?bmZ0MDFvRVoxUzN0QnBBODRMVWg3RnVUY29uSzNqYUhuT1hNa0ZwUU5PWDFz?=
 =?utf-8?B?Z3FKdTZOK0w3TGJoa2lTcHIrL1o2dWl1VWhvTC9OSXY3MHhySXNKQmtwckJE?=
 =?utf-8?Q?qsF1pK8Ej2375Fv92w2DKtRXU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x/oKBGJpyhWuvn2fCNGsOvFd4HmkJQ+kLL8bfYqq8fonZAt0Bn/kuSv1xTy8PJFxlK8lx4PS+2xLyMV3L7JopnA2UrHv8CVo/HQj7+kg5Z/VkIH2DTXVqNPN7BGCfv7zq3gk1JuOW5Y299Ik4eFtafUl/G4O+v3EDI0jeXNTPJ7pvcAhRyAC9f/cq/ZqLt4nsbmbwCFco5fXEBoXXK0r9J8dBeIdUenMoc16aezqWfIKvSrH8vT9qAnYIvLwwKwG+URJXPdC25gLKpDnMCR/lSlLwOgiZBfi4weQbmlO28SpYN02T3h+W43Q2R4y3YFA2+yU/TAg0TI9qvualk+igUso44v3RpunNitHVVOhSCBY4b1+DCrnMklAAgP45Bf6+IQeCnv/1w5hpj4BF5n7nQKB8dOS+eRucIPVEuBIzG0znZ+IzB+6PUs1ljrJSmot+zxbqgiMzmzJZqMynRHaLSjetGDVyKUxkjPL4OUJzrtM/c1mJg2P5Ufkr7lRXsWk12BpDhHb2skJG7xv3V/hKiLpfN6XQMFnmSgcXMmmZ7V71iJTOBta1IvKSDuHOWe8QUUvMbV7xuLjf3abhFNysmfraVZ6eyIq626iWMdMBS4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f09609-5e16-42cb-4c80-08de278c05a6
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:52:27.8025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YkdqZ2/k958gwMCp9DfunjirVoL5iCwrsMExFZYpiwx0yyUfHHJ4E2ZYyMsJ7P60v+2X9fCx0lxV4HXZeRgTGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5165
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_05,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511190133
X-Authority-Analysis: v=2.4 cv=OMAqHCaB c=1 sm=1 tr=0 ts=691df5d0 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1yWvY9gILCBpXwxeNA8A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12099
X-Proofpoint-ORIG-GUID: FopigwJetuynfFdfij4JGihgkd3b-ouq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX04nBh7rKNTQc
 iZz9gtfSHbOlYoIz3fqKFdl1Nxu+XosNXXbeBU5DEnlIdbkJU/xugS8uZzsPmNiHvaZvhO5Qux7
 ngxpSEIs7je1vmmb9w7L7fQitVqfjtjPB4gE/A3GFZTFM8BaxmbvztiMukJOFuCFhUsZ2c0g1gK
 wk3zh5FuOdkYQrytYN75VUVL7mfO9tDxZWIF72rZF+9grCAcp/iZRB3IHW2JY3wP6tav/Okd5lj
 N24W6i9Ih9A+nIIJ84Qs1BRN5djeMLjI1rmkM57WyV3AqGhyzLlIbAyqDTLktd+UUV8K7MBu3uJ
 CA6N2wza409aaeNpex7XV/cQ9EANFhhYvBfHCYt3HFtvc2iXNqnPEdWuRfK1t+YGy6rp11ZUIxa
 utnETTvBqTHYfZPpJrZf2mwVOLtrJxTr+AdYEQZ9ANQ9IAfl32c=
X-Proofpoint-GUID: FopigwJetuynfFdfij4JGihgkd3b-ouq


On 11/19/25 2:08 AM, Christoph Hellwig wrote:
> On Mon, Nov 17, 2025 at 02:00:07PM -0800, Dai Ngo wrote:
>> Perhaps I overstated the severity of the risk. The real issue is, in the
>> current state, SCSI layout recall has no timeout and if there are enough
>> activities on the server that results in lots of layout conflicts then the
>> server can hang.
> All this is really caused by the synchronous waiting.  I'm not against
> the workaround here, but I think we need to address that.  There's
> really no reason to consumer threads for this waiting activity and
> we'll need to stop doing it.

Yes, I think __break_lease needs to work asynchronously. But I'm concerned
about touching a bunch of other callers. And we need to fix this server
hang asap that was why I posted this patch.

Also, I have questions about how __break_lease currently works such as
the way it picks the break_time and the blocker. It just picks the first
lease off the flc_lease list which could be a FL_FLOCK or FL_DELEG which
has no conflict with the current layout lease. I think it just happens
to work in this case is because of the 1 second restart loop.

-Dai

>
>

