Return-Path: <linux-fsdevel+bounces-18888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B4D8BDF32
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 11:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01641F22B47
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 09:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBE514EC59;
	Tue,  7 May 2024 09:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h0nFIwV0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EAA14EC4A;
	Tue,  7 May 2024 09:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715075925; cv=fail; b=rguts3VjVav/6B2r3v3RS1uychxedcTe/GOdIFip8Um21uoDyzyOEKorZgswgpAiECj5OLq0WHJfz0dHhM933/Vt4sOcARSS5+zM0Io21pMg510BgL3WCfujGptSAldk6vW6GP+Kvk9sFOFlXwLe+6wnwudH4vzy2WdsoW7GkYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715075925; c=relaxed/simple;
	bh=dVC/lQiSUYgZdO96VgxSvbek0uXlWsUjbh3YyBxWQBM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pAUzJIbtVYI7GrPOzSPLP7KBKQkMZV+JD0Yv17Uz3B++wdvqiSk+p8z5EQ9MmOVUGoK2edkzI1gpRSomHPhKzOrQ2VjcVREjVza8hAJiaSn52JbKLA5/PbyCD6e+M7jT09KvBOPjoCuLO9UPhK4YEyFxnZkQ2ORSr0rVxdmcvSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h0nFIwV0; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dg6FgL9bFtYwtBAMsrxeAMvkTmuBrUWWjWuEjHyARgR97PqyIVMxaREar/+Xu5ZyXk6rVro72RKuc8u7kzmD8mOybYNTpDfLCVDb7ZyQDrHp2jsPifuruCfNu1SxKZCOb0TC/NKLuTj+5mYOjZtkt82N+L7yXPxYmmxUybBmtFJWJipWC8NCcErY/vcTGrqtuMzpRTaEK5INh9Ik/xrMeNQumd3BCh8055+vHyWc8tGN+hFIMLCSlyJV90YpnFP9W3TB5n1ETBrBKr6EQoWaV2jxb+ACbIMZlw+qPqOMscS2QLlAYx24kcfcsIlsBhf/nDlFhun4JGKuli/jt/zpCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcyRbRNnD/AnPAVwbCDZk2vU18J3bztD+p06BpIHkZE=;
 b=P7Fn3Iuhb46xRmh7vErw/6kqcHPOwzH32IWS+4ChjsagP6WMbeBv9mLkFvmZNtFRu7Qo/yyJF2PLiUFXyrwrefyIeAO+HEnjUeDP6X0LEuJHK0NkoJ+iSnWQfmUsD/JsiEkiXjCuaUQDLt+LqM1aa05ZXV316ZXGGLc8VEEnSL/5a1EXSVy7JxlXlmWqdjhvwnT9T+0ltBBE7ocifwEFzsGndxlp4a664LROJ5XL+MlY0UdQjmWLItkcbptIxcgryMKgfAYnAQ2VvZwfefVFT3wSZsLAEWRT2HCPf1FUBIqkMmNanbcB67fM9lYyGigFbd+JL/mbFVe4+P3yDi15SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcyRbRNnD/AnPAVwbCDZk2vU18J3bztD+p06BpIHkZE=;
 b=h0nFIwV0227otU7T0wKLTqaM6wgyU3bJCARuyeox1nZy2XJJtZ6hoqredGr3O9pX2y9YxrdbD7l85hGCEj50uzMNwIYe5RRAaF6xNHCMJFgH3FY2JPKiLFRTW7nVTyzg5+x0PSACZWmnyMQ7qlrCGEx2OLBGwoRg1iCgIpUvaKE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV3PR12MB9267.namprd12.prod.outlook.com (2603:10b6:408:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 09:58:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 09:58:39 +0000
Message-ID: <eb46f1e3-14ec-491d-b617-086dae1f576c@amd.com>
Date: Tue, 7 May 2024 11:58:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [lvc-project] [PATCH] [RFC] dma-buf: fix race condition between
 poll and close
To: Fedor Pchelkin <pchelkin@ispras.ru>, Dmitry Antipov <dmantipov@yandex.ru>
Cc: lvc-project@linuxtesting.org, dri-devel@lists.freedesktop.org,
 "T.J. Mercier" <tjmercier@google.com>,
 syzbot+5d4cb6b4409edfd18646@syzkaller.appspotmail.com,
 linux-fsdevel@vger.kernel.org, Zhiguo Jiang <justinjiang@vivo.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
References: <20240423191310.19437-1-dmantipov@yandex.ru>
 <85b476cd-3afd-4781-9168-ecc88b6cc837@amd.com>
 <3a7d0f38-13b9-4e98-a5fa-9a0d775bcf81@yandex.ru>
 <72f5f1b8-ca5b-4207-9ac9-95b60c607f3a@amd.com>
 <d5866bd9-299c-45be-93ac-98960de1c91e@yandex.ru>
 <a87d7ef8-2c59-4dc5-ba0a-b821d1effc72@amd.com>
 <5c8345ee-011a-4fa7-8326-84f40daf2f2c@yandex.ru>
 <20240506-6128db77520dbf887927bd4d-pchelkin@ispras.ru>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240506-6128db77520dbf887927bd4d-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0249.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV3PR12MB9267:EE_
X-MS-Office365-Filtering-Correlation-Id: be4a6ec2-1f6c-4d2f-acab-08dc6e7c44f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2hsUlZKaUFBbGVrYjVXUjl3YVBiT0NTUFU4cWlBa3gwcEtjWUdLbU55dFpl?=
 =?utf-8?B?MGdiU2hIWVNHRDNBSkNpZDBTUUFnOEs4S1ozT2NSZndsUjJBaVNYRHUrMHpp?=
 =?utf-8?B?RWkrVkt3UkhpSDdxbTdnbUUwcitZWU55WjYzQWtPcjBVZDU5VmkrOTFadW90?=
 =?utf-8?B?S0RTMXV6T3paT3hCN21JQmpaSjdZbHNwT052S2xiRkdYQzFNUk1QRDZvNTJE?=
 =?utf-8?B?d1V0QXJKM2lXVXZXNnVtUnNWWnBCS3UxVFRDZXZIRzdFNENUU2NCc1EyUjNn?=
 =?utf-8?B?NTc5em4wcXVLeXRYb0V3VjdZVmFFU01PSjhzRGJPN1JpMDRYclpJTUhmbTAr?=
 =?utf-8?B?cGZiZjJvWFQxVlF3V1BlMVdKOENKWVhFdlBWeXJCVzhyTWtaK2syTUthMmlL?=
 =?utf-8?B?S2xuZ0haM08xaXpUdFNMa3dmMTBjaVhwR0ZLUUNnMGRsY2tnam1VR3hybm1R?=
 =?utf-8?B?a2hGTElyQ2lSNW1kZ09pM1RBYkpxSVRLT1orMy8xYUk0UjRHTUk1WVN3ZmxE?=
 =?utf-8?B?bTZEYnVnaFlGQWRJRytlOE9yWWhyNjF3R2IyalNISWlEenA2TmxJUXlmeWcr?=
 =?utf-8?B?R3JMNm14TDBISlF2TVNmOHZvWUtDK3g0eHpVL1Z1ejBxZTVCMkcrbmRYZ1V2?=
 =?utf-8?B?R1d5M0I4TXRoeDc3ekk1dFlXZnE2YXhTYkdxOGVHV252REE2bzlvcnRyL3gr?=
 =?utf-8?B?OTdyOFIrUEljWjRCMmJSMStXT2VmajFDSGhTcmZwN3puRExPMW4xNXF1UXpQ?=
 =?utf-8?B?YnFYYU9zWDJFb3piK0o1aDJEV0puRXJ6R3BrZlpqRVMrcVk4cWhZLzhFOHdM?=
 =?utf-8?B?b1dPOVVycTJ1Z1FFK1dKcVZaTXlkUG1hSmdLNUk5aDA4UzJMeW1OS0J2MXh5?=
 =?utf-8?B?YUU2amJNZnJRdU9UWkJtYkdGUUUwWVFnUmxPd3JYM3Zoa3p2bXdXd08vRDRh?=
 =?utf-8?B?cENwd2pIeTNpK2R2c2toWDhQU0RFNHZQR0dDb1hiSnZaRVdOZm9yQU1ISU9h?=
 =?utf-8?B?YlQwZjFVdElPTFRYRmZZNmlmeldnL1RUcS9VMWsvRkp6N2pFaEgrU21JL2R6?=
 =?utf-8?B?ZEVoRzltMjErWHRXUWtTa0ZETkkvbVpGenVQc1lueDZoekFRSTRXOE1kL1Fo?=
 =?utf-8?B?UEdOcllNM3NjbWRWY1U2cTBEUWVRc3QwTDV6RS9NdTVieWkxN0FCSlhGaDQz?=
 =?utf-8?B?MThOVXp3SmgxT2x0dkkySTh2c0k5Nm8zaXlGODNTR094R2dpek5hQjV6WHlG?=
 =?utf-8?B?dXlOMmIwYVNOWGx0anNYTFhUZDZWTTY3RlpiSWZmeVNoenk3YUtsT1RaQVZs?=
 =?utf-8?B?T3dJVURxOXp1elM5N0NnZjVjNHNSdkQzNFVYWDF3SUN6bnpDR1NxemlCTk5h?=
 =?utf-8?B?VERqRnFLUnpTbjd6Znp2aUs2aDFsSGxXa3JSN3NwNXNlblgxakNxbEtwSmRO?=
 =?utf-8?B?bFUxT2NXQ2FXTlpjcE5WZm5qZEFtRmlOY0hQVnFsSTdBQlhLZGgrY0JEeFpm?=
 =?utf-8?B?UUVPYjhBdGErVk5obGU1dnVOYTI4R0tmclp1Uk5xLzZsK3gvN1RGVjBzZVFH?=
 =?utf-8?B?Q1dadnlmQ1UxQkl1d29yRTc4UnF4ak9qY1d5bGxzRW10M0QrWXBDTEk0Nm80?=
 =?utf-8?Q?xdEtu+vg8fT4x1LiG7hj+lJpFmKTRoQLf4E43d1fvfbg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uk90U29lc0ZBdDVRZ0ZWd2Eydk9YU3R2UDBRdFZXVkNCejFaZUJxRzl1UUdy?=
 =?utf-8?B?VzhJaXUrN3RaUXdvcjF2NW9VczBrb2dJNGJWSEEyaFhmWkxkbnJpVk5rN2NE?=
 =?utf-8?B?dXBhdEJycTZRSVlNM1k1eHU3allqcGtnM3p2M2dHOTdKVnRiZFFaL3Nib01W?=
 =?utf-8?B?cXU5Yi9IamYwVjdZNS9nekVNV0REeXVleUp0ajhxQmZBQXNSeCtCRlFNTVVY?=
 =?utf-8?B?YkJVcTE5Nm1pRCt0NnkrdWNWMERmcnowdVVPK2tDRnJya2l4L1JRS21kb0xr?=
 =?utf-8?B?ci9LZnM5ZU0yM3gzUm9OdlZLRy9ZQkpoS3RWOWYxUUlUNWRicjc4UU9BeFZn?=
 =?utf-8?B?d2UxalNvK3dpOGJsY1d3L1lpbnJpdEltR1R1OGZGUExjUTMzUXUrZ0Z0TldI?=
 =?utf-8?B?TDRDbnVNYzVPNHZHWGNxTnpRSTV3ZWowQUk4SzZ0ZHljbElWSG0yOVJXM2N2?=
 =?utf-8?B?bDVkMDQ2KzlBemhKSmhUK2hJQ054UTFwbUFoYlI3YTN2OHk0S2VDaTY1WDc0?=
 =?utf-8?B?YzdJL0wybGJvOUozdG1uTmJISnJTdVlDK2NKdjVtNWUyeDgydEdJT3ZhZ0s1?=
 =?utf-8?B?WG1QdzBVMVYzRHNwdnFKWk1PVXpFZUhneGlKWkVvQno4Qzd3ZGxVQ3BmWXBq?=
 =?utf-8?B?MlVUcWhJaXZSVzIrbEhubkhPZ041L3JaVWFiSTgyWW9SdE12S2pQNllWSVdi?=
 =?utf-8?B?c1IvRDFVaVdzSmpuTGx6ejBsZXZGUVdEMDVwOUNuZHFGTFF5K3loQVRGeWE2?=
 =?utf-8?B?eVl0Y1M4dXc3TnJGZDFscFpnVmc5MGFQdGREZHdEb0FXaVptRzZYb2FmbXhu?=
 =?utf-8?B?MjhJTS9jOUNXcTh3M0RiVUZMRmtBUkVMYTRPS0JiOWd2WnRuMUVGWjdRTUZi?=
 =?utf-8?B?ZHNFN1F4Z3poeklkTUlmNDIxa0JibmJ3WDN4Mi9VS1prU3pBTytXbkhIVGQr?=
 =?utf-8?B?a2lhWmNZNjBtNE9BWUJoNnk5WlltTEdLWFVGMTRYZE0vOEFrOTBZWWcvdDdq?=
 =?utf-8?B?Q1FtYlN0NEZ5WFBpS2xPVVBITXZVRUZseCtrSXV4bTNxVFlWSTZ4aDBvUkxz?=
 =?utf-8?B?TkM0Q0l4VFY4VytJRlpCUHhWeUlGWVdaOTBzOURMOUV5eHVZcG5McXorN0Mx?=
 =?utf-8?B?TU9nblNyYzZ2bVgzMmVzNDVtelB2bXVWckhzbFFpM2Fpc20reU5YNzYvWEo2?=
 =?utf-8?B?RjQ4NUFuRUt4RmxERjdEa3FVR3hKQ25WQkErTDBFQ1FTNUNDcHFLUnRod3Ux?=
 =?utf-8?B?VmVrZmJaY3ZDdWRHZnZ6NnBKOGdTU2J2a21RVDVsVUx2V2JvVVB4TjVDd3FR?=
 =?utf-8?B?VU5tRFVNZnJXMDA3SGdaSFptR3RmWkkvYmYzSHg0UDlWL0ptNDJLZXo5Z3Rw?=
 =?utf-8?B?VndOWlgxTFZYWTJORlVRYVMvSWpidUlZNTg0QVdQUW1XbWt6NU5DK05ZelZy?=
 =?utf-8?B?TGFWZm5nT0EvWUx3ZW04TUdPbVBZUVl2RmxzRzROejRJYnplSnZVazZZUFVw?=
 =?utf-8?B?SXVtdGFnT0hZakJXZFVxdHkzdGFhSUdtTzlhbmw4eEZOOGhLYTRzSWE3RytF?=
 =?utf-8?B?U0JIVndCZnhNMTJMMG1wUEZXWWcwbHpNUEM1MGxUOFYrRVlMSFZXU1B2ZzNC?=
 =?utf-8?B?NGJTUUkrRjd1cG4vUjFycy9rNHhhZ0krazRWb1AwTXpZaCsvT3k4WEZZYnlX?=
 =?utf-8?B?ZDlhMEdseXY1Q3l6K2hDSCtRKytwYmtxcmUwSjd3cU16alVpUDlTTEE5N0Nq?=
 =?utf-8?B?cytqbFd2ZmoxL0lISVZLUVNaQWJTVWZidU9mTUFsVFExZDJjRTlXalI2UXQ3?=
 =?utf-8?B?ZmZQZng1N3YwdnV1OFFEa0NDbVNMbHlwdDdHb1V5emVOR1hibUtISkhtRlBj?=
 =?utf-8?B?ZmplaDVlRU91anVSS0hlWDZNUWt3dE5JNndPaE9RRFUyRzY4ZFkyaUJIOVhO?=
 =?utf-8?B?eXFEYzQ3WkFzZW1aNW9HUW42Umo5NGptWGIwM3B1TFFtR1IwamRiNFVtRzRR?=
 =?utf-8?B?b0dHSXZhT3VYL0szQWozWTdEemxnK2VnWEVySVRjcWExd3hPb1FxaTQwd2ZE?=
 =?utf-8?B?U0dlcFlJYmJ6My9zWHh3YS9kVm5GM25ISStIRzdCUGRrZENSTXE3SHBmd3hC?=
 =?utf-8?Q?arO+tXPcxvy4g9rZRZzyBUzoX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be4a6ec2-1f6c-4d2f-acab-08dc6e7c44f5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 09:58:39.4366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04TnjEc1TNhCiPBVJurPszhm6coxJ6hLpKrvUg8hitKKp0PxiQwdIVoRfZu2iO2Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9267

Am 06.05.24 um 08:52 schrieb Fedor Pchelkin:
> On Fri, 03. May 14:08, Dmitry Antipov wrote:
>> On 5/3/24 11:18 AM, Christian König wrote:
>>
>>> Attached is a compile only tested patch, please verify if it fixes your problem.
>> LGTM, and this is similar to get_file() in __pollwait() and fput() in
>> free_poll_entry() used in implementation of poll(). Please resubmit to
>> linux-fsdevel@ including the following:
>>
>> Reported-by: syzbot+5d4cb6b4409edfd18646@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=5d4cb6b4409edfd18646
>> Tested-by: Dmitry Antipov <dmantipov@yandex.ru>
> I guess the problem is addressed by commit 4efaa5acf0a1 ("epoll: be better
> about file lifetimes") which was pushed upstream just before v6.9-rc7.
>
> Link: https://lore.kernel.org/lkml/0000000000002d631f0615918f1e@google.com/

Yeah, Linus took care of that after convincing Al that this is really a bug.

They key missing information was that we have a mutex which makes sure 
that fput() blocks for epoll to stop the polling.

It also means that you should probably re-consider using epoll together 
with shared DMA-bufs. Background is that when both client and display 
server try to use epoll the kernel will return an error because there 
can only be one user of epoll.

Regards,
Christian.

