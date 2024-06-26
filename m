Return-Path: <linux-fsdevel+bounces-22470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E66A917699
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 05:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB746B2099D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 03:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691053FE4A;
	Wed, 26 Jun 2024 03:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZZtwYt12"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD3A11CB8;
	Wed, 26 Jun 2024 03:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719371193; cv=fail; b=uTUYYoXOHnqPYVSOQ/Hj68FQDUro/D9G3oinGVORWi8vBaGi6h6IpxrCGIZuP8LFXfr+UuAfT0w7xCYWkCeFZdNcO6eFFmwo2plc9rXvPRlNefZYOaQY/8uJgTlx1SGGcaoKL7esIRHOxhFUXui/sZasNOq8DFb9+ubvgUPquyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719371193; c=relaxed/simple;
	bh=yGYxhXknp37Dqe/cQWa+DfmWHRuI2k7OWe+X43pnpVs=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=GXnv1KcSHHsIkqkUv3UaZrbYvOz/jFSCwcFmrEynvsLVbf6OverDLynQg4+30kMZakhJyl78o0b+U2M0b118fenEtyUisvrAHyE939PFcPnc7YZzu+W+afOHhF7KI7leWiQGVUjFmnvzQxFT/s9YPzIE5ajWg448GBRUn6YgwwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZZtwYt12; arc=fail smtp.client-ip=40.107.96.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0G/dPoudccftF1m4Li0gI7c0VgPiN/k/rWp7gdmjaIN4vUqp+rFXKoEjNAYIJK5sEr1CeBIlXDFIU0te2K/pD0Ej7pjety/BY3rHfU1ZF7N0ZS6oX9bwi3urdEDizmve4WJm/iquirfAJ31s1tttIvYnMJnxodjA+nvE9VUAqJMK6C52aZhVSBOOT0LStnqi4HRRwXjRE2Sl79lrvhjHUTC+g1tP1Nqc+QsheuheT3qWoeyfPoAn6cLQuYYId0s9xkmsmeoFU14yMNph30pXjy1wzCfqjGSxQgg8xadPiaU/vfIiAAymOoZYwUhw5g5ECOJEUD8uTRJx9Mdnypa3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+4IYZlkeXl9toBrOKmc+F8Ua4qecJwfGAK2IuM0npQ=;
 b=HvtAYyYPhn0HJO4IQb894kPndSQVvgQ1XQFab2nGPFfKwcWI00nOuTn/ZL6aHHJ80xnbBfFJTJIDMXiEuYJbjtWeX2ErCEgEqnrr1yYDWytEZI2/ZX236zK1MMh1UILJwdy1RZL5srDrzg+nFC6Ll9ZDIjn12L5Z5MvoCkqpfIEjzbaMXBp2V5+9nAIjEV812c/4NS7ppQTJ6Qq28gy8a2ICqmmzlHhdcdnQ567s+TfyiVQ8Zsrq5/4heBAEoIxK/ifmcqMSVjUEh5bE65rRKnvQosJecUoeXnW7TW2F1J3SPMO1W5XQAeN92tL/izaUZ6igobxUnqlSBS2vfgmHnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+4IYZlkeXl9toBrOKmc+F8Ua4qecJwfGAK2IuM0npQ=;
 b=ZZtwYt12Pobvyu2hbdMQq+ms+OZFjhRdn2XDBajF+cx9ZAIoiACNenPosLn0C39SEWywBFi6C1ga+h/rP3xCM399oQgnwQATnJOm6exliar1/d0uZYVeML5PfOWuypYZPfsc0YqlgzKfYDsQkWXju2GEe4nBPYj4gRVQWV3yaFEuhCT5gMQ73b9MZfvjGBKjKMY9GYDMu1zrTPMpCHtpBc/+zCKGmEosEaWrg9W40sG43U4eTodqBvO81h2GbrK08DKx60GTBkqyRwcpYYJYbFcmB0ReNlNNgIN9EVXtq+QS9K8RnMSslAM4jiHPIXb2zPLBe9azGY193uTrZhOS2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MW6PR12MB8950.namprd12.prod.outlook.com (2603:10b6:303:24a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.30; Wed, 26 Jun 2024 03:06:27 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 03:06:27 +0000
Content-Type: multipart/signed;
 boundary=160d1fe3209212974da81d836de7ddfd79b4a6816f2f2b1065ec16097dbe;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 25 Jun 2024 23:06:25 -0400
Message-Id: <D29M7U8SPSYJ.39VMTRSKXW140@nvidia.com>
Subject: Re: [PATCH 2/2] kpageflags: fix wrong KPF_THP on non-pmd-mappable
 compound pages
Cc: <vbabka@suse.cz>, <svetly.todorov@memverge.com>,
 <ran.xiaokai@zte.com.cn>, <baohua@kernel.org>, <ryan.roberts@arm.com>,
 <peterx@redhat.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-fsdevel@vger.kernel.org>
To: "ran xiaokai" <ranxiaokai627@163.com>, <akpm@linux-foundation.org>,
 <willy@infradead.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.17.0
References: <20240626024924.1155558-1-ranxiaokai627@163.com>
 <20240626024924.1155558-3-ranxiaokai627@163.com>
In-Reply-To: <20240626024924.1155558-3-ranxiaokai627@163.com>
X-ClientProxiedBy: MN2PR15CA0027.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::40) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MW6PR12MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e979874-ca47-4f88-ac6e-08dc958cf861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|7416012|376012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aU1vVHJCOUc3Qnd6S3kreWRXa0lvR082Nmc0a3cxSk9GTk9ReTNBRVVQbXpC?=
 =?utf-8?B?dzZSNmE5UVZibmFaNWIvN0pVcWw4NVlZckF6TVZZZFVtM0NWQkorMG8xbFBN?=
 =?utf-8?B?TExHYWF3cUhZOVBXQlRJVThVdkZxTERydU5qdzl2eituaGltOC92cEhmbGxF?=
 =?utf-8?B?SmlYTlliUjdVdHdxajRQMVVacnJvNG03eFhnTUVocUl3QVNiYmg0eElpaFdZ?=
 =?utf-8?B?Wm1MRUU0NC9qa3dSaWRQN2JFbkpEV3pEQ2gxWXkzTlVaOEViZWFuTW9mUjNp?=
 =?utf-8?B?d1VQbHJERW8xOUF3Z3piTXFKaHkzci9XZlpoMnBHQUdwdWtyb1EyL0o4czRj?=
 =?utf-8?B?VTRQT1lWU0laWS9lU01SdXlydFEybWNQNW9Kd3RoR3pISDdlVlFFdzFlQm10?=
 =?utf-8?B?MVFPRStIODBTSi9TV1lkREg4MllsUUFHZlVjV0QzS2s1eitsR2lUakxySGh0?=
 =?utf-8?B?TU9FeGtoWGY2bGpwd05QNU1aai84Q1E2UWxKaEVLOEFhVlFPQkt2WXZLdTlN?=
 =?utf-8?B?MlFQM0JjWGMxM2cxSTI5YjF6dVhPRGc0VmRkaEVxaWhad1ZXeURxeUZ3OEJ0?=
 =?utf-8?B?ZG1seGh4cGxhWkdob3I4MHBvdmlpZk5HRk40K2twWnJkMjFiMmxvU0M1QkZu?=
 =?utf-8?B?UmVMM2F2dU0vUjROcTc4ODQ2WGxZblo1eS9hbmlueWgyNTNaelpqemVYcGVQ?=
 =?utf-8?B?aXJQR1RidmZUS1dOMEZwR2wrSFp3RHdlRHpxeGFmVDRlcnpnQ0ZUNis0bGlV?=
 =?utf-8?B?V1QxdTBZNnhFUnFPcjdVcWIxUXVYU0xrMFJycXI3V0xBcmtRZDl5bmtCWTZn?=
 =?utf-8?B?VWFpVWo0L0xSMlVHQjByTEd1WkxNcDRzVE9VVVlHbncyMFpWQzlsZHMrMWpk?=
 =?utf-8?B?Ri8wZU5VN2FtMzNRVkhDYVQ1V29nd1dtcTd1RDVMS3ZucXMyaU02RGl4Sy9Z?=
 =?utf-8?B?Nk5vSEZuNHZCMVhMMmpydWZoU0RJSllEWWptMTlQT2VmUklHS3R3ZGhvZGpE?=
 =?utf-8?B?dHRZM2N2NWpKcGMrb2g5OFltck1vdTJieUNHWHYwWCtPZWFoUHJkeCtBUU1Q?=
 =?utf-8?B?RGphcEhHN1BSNXAvWm5KdTlWZVFVbEZpYXhhUURaWWVxTE5vS0pZMFd0WHdK?=
 =?utf-8?B?WjE4QzhYTEQycks2cldsSVFHbGs0d3RxSmh0MHFwd3B3c1JtbSt0ZGd4S01q?=
 =?utf-8?B?Y0wzZnJEOGFCZ05rSmMwV2tkVUxZR28zTS9wak5MRlQzOWJJWUlmVkxBVjEy?=
 =?utf-8?B?Y0RhbWMySDFFOWxRWHVxVWZxSFlVWVdtS3hHcmhRejNub2w3aktES1hEbzdO?=
 =?utf-8?B?QXBKTktwazYxTExkZHd1L2c4UzF0LytoNTVmdXorb3RJQmxqVmtWYWtsZjhC?=
 =?utf-8?B?NnBwRTNvSmpWYm5qTE80VEdocWlQWTgwVWtpb0tTMVFiZjRla0RZdFM2YUtY?=
 =?utf-8?B?YkczOUpRaEFmRUUxdnFtNEhZVTBYMElsOW80ZGJBdXFSSkE4S21GQTNGTFFD?=
 =?utf-8?B?c3RDK2pVWklGNXBtZFptdmN2VEtnZnRnblA1VDBpNFYvMWdRbjAvUTdsbWpT?=
 =?utf-8?B?bVdxYTkzWGhVcVpJQ1gzTDYzTXJLelByaXFXVlRGSXJYTWhOSS8vcVdkR2xN?=
 =?utf-8?B?Q2pQSWZLTmVhNWY4U3F2Tzl6UkFwdlRRK3h3YTd0SXArVkVaZ1BVT2tEM01a?=
 =?utf-8?B?YW1xN3c4ZnEzMUpoQUZlazFFemw4c2twRTdTVWpGa21kTXk0TVMzeTkrUGRP?=
 =?utf-8?Q?pF+/2oyE6zc3VanL/T7Jbt3yN6NMGOPP07VX8Xe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(7416012)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVRBWEhxU2MxMkNsQnRMa2QyMVFEdzRMY1ZETmVzaHYwK1FjSjdNeWpRRWp3?=
 =?utf-8?B?MjVJazNlaFdUNDEzVDh2ai9pUEFSWjZhaTFVYzdtK1pydXdGMVBmNzJCWmxY?=
 =?utf-8?B?c3ZOMHhXNUFBeWN4dEFGL21SOGlGTDQzVml5QVNmMFhoY0h3TnM0QTd3WjYw?=
 =?utf-8?B?RmtJRWhmYXhTbkFnQ0VzcG1lKzV3cGV1Ujh5d2FwZ29RbjZGZDNNRWJ2Mi82?=
 =?utf-8?B?bFRPd0hpYUZjZ0QyeWNwUUdJSTRtSFlNTkwvUVIrbUdlNHZZOFdtZERvRGl4?=
 =?utf-8?B?Wjl0cU9WMjMrZ1VnaEJFUlNxWEthZ3lvQ2d5RDk1dFhVeHFWNGhxTjIvZEZ4?=
 =?utf-8?B?ZTgzeEQyaEJLN0lCVm5YZWVGRHV3U040ZVQ5c25CeWIvaWRGUU9LQTRUSXhH?=
 =?utf-8?B?NDk2RUJLWFZBMjd3ZG03NThCZDhWSlp5S2dqVlFGT01JUVRHZ2pjOGxFUW1o?=
 =?utf-8?B?aXdJUk4zcmlLTExQeUJjUmNtYzRBaXRNS1hibTVwd25FQzc4dU5ieGZXZXRV?=
 =?utf-8?B?YS9UVmc1NitRSktHYkcxZHU5RkNaTUFvWC80WHpDekFtdVNha01zUkgveFBn?=
 =?utf-8?B?c1g4UmFyOUdTK2E2YWN5ZkptTnUvOWlrS1RQNFpWVUJBeVdqbG9CVUVsMjVB?=
 =?utf-8?B?UFNlbEhoMFRpclBmTkIvTlpxOUQrMXN1YzBwV3ZLL29xK1BIeFAvMXJDUlBB?=
 =?utf-8?B?UXZaYzc1WVhDam1hUjhnMkZOdnVvakZiVmJQME5wQk9WNUxsQlZ0T3N4enJ0?=
 =?utf-8?B?d0hPT0dzZ3VvekFHVDd4QlA1TEs1UmFHRSt6clFmd1FCSkYzMjJIZW9HeW9i?=
 =?utf-8?B?ejJ3Vzc3UnJ2RUFIcUxkcUgwNzRGcnlYeExLc1JhWnFDSUhWVlhFcFhmTjYr?=
 =?utf-8?B?R1JoRWIyK29ST2oxUUFMNWhlWkVsUWowUFp1a0h3RlBDaHg5ZGV6RXl4K0pn?=
 =?utf-8?B?bmZBSFRJbzlKNlE1SEY5OExZbjdiWDZwQ081S2RIbnZveUxpWnhMeEhUTG4y?=
 =?utf-8?B?UUtpWlN2eFIxSzlBNFl3TmZVTWxKa1NLVzZYNlY3Z3hxdEtoOFdlc2VtTzFi?=
 =?utf-8?B?cnduMWJrSXplbUNCNlNOYmlsSlhFQlBNWWF0NE15cU9WUFBDc2xZdmNlSGUw?=
 =?utf-8?B?Y2hqbDVjTVo0NTFoRURRd3hOUFJlQm5BVlgySDhKMHVaa1FyTE9sSGxyaEI1?=
 =?utf-8?B?RXdkTnN2K0hCZWdmNEoyZm1Lb0JKalRoK1RUaWJYNzk4V3RyL1NjcVFQWVRT?=
 =?utf-8?B?Y1RJSjV4bWxudHE1bDMyYW9xRk9jRFNZU0hnVkVnNDdkNTFNMWdLTFZRcm15?=
 =?utf-8?B?VlAxeEN3RDRnNTl3aVpJR3pGT20rbDBvdWkrb2NSbCtZUi9oblBLcmF6Tnpt?=
 =?utf-8?B?KzZsc3dEWE5zSzltKzNXbnAvNFZEMWs3MnpiR201eC80OThLd3FkRTJkWDZC?=
 =?utf-8?B?V3YxejMwVHA5c3V3bFVoZTRacnJGajE0MVA0RDQyTWo1ZVBDUEFwRFB4N0dT?=
 =?utf-8?B?SVRCODJOcDBBVGcxNWc2SXlBbkFuNUdPWmtWN1F2bEZzYXhnYnJOeFV2bnVW?=
 =?utf-8?B?L1FJTmNIdVpCOVdMUWJjakFhNVdpWkdZeTgzemE0KzY4R3B6azhlRXpZMlJP?=
 =?utf-8?B?TUJFTjhTUHF1blc0NkxBZ2IyK3R5Q0NsaGQ1UHd5VFZUN3c0anN6QXZJRXI0?=
 =?utf-8?B?bDhCQzNJWEI3anJVUmc3YjdhSDVYcEl2WWlVL1FwczZ3OWFCMjRQVmxtQXUv?=
 =?utf-8?B?Q1RpbXVUSXlQcmthOHBIell4Z0RmT1REcUpxa05USS9GYXhwUW8wdlZCaTRj?=
 =?utf-8?B?dTgxZ2xNTjBOU3NLdzgrZ3dJQ041LzFoRVptdUpDdnJyay9qVlM2Vnd5eWRZ?=
 =?utf-8?B?VThFd1c1SGFkZm0vOFo2YWllRms3c3BlZVRsU051cmFlUjRMeDVZNVJOaldZ?=
 =?utf-8?B?b0xRbldtcThwektjVTEwd2wveXlURTFmcStNSTBUOFVSdUNkOHhnaWFiT3Z4?=
 =?utf-8?B?NWszZXAzYVRQOXd1Z0R2Nm04dDE0S041MTc4YktCOEhQcitlSUtSb3pnVGFE?=
 =?utf-8?B?dWlJOUp0cUFWMitFVTQrZUF3akwzMHJuUGtCSjVnTVd6YlVKYno2MmltY050?=
 =?utf-8?Q?f+Ow=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e979874-ca47-4f88-ac6e-08dc958cf861
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 03:06:27.6038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5eFZbUB3ibpzZFz/k3fLInFrK5OTWJ3hJ89HDTlq9fUW1l9YhoMqleqDxAIBk9c0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8950

--160d1fe3209212974da81d836de7ddfd79b4a6816f2f2b1065ec16097dbe
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jun 25, 2024 at 10:49 PM EDT, ran xiaokai wrote:
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>
> KPF_COMPOUND_HEAD and KPF_COMPOUND_TAIL are set on "common" compound
> pages, which means of any order, but KPF_THP should only be set
> when the folio is a 2M pmd mappable THP. Since commit 19eaf44954df
> ("mm: thp: support allocation of anonymous multi-size THP"),
> multiple orders of folios can be allocated and mapped to userspace,
> so the folio_test_large() check is not sufficient here,
> replace it with folio_test_pmd_mappable() to fix this.
>
> Also kpageflags is not only for userspace memory but for all valid pfn
> pages,including slab pages or drivers used pages, so the PG_lru and
> is_anon check are unnecessary here.

But THP is userspace memory. slab pages or driver pages cannot be THP.

>
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---
>  fs/proc/page.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/fs/proc/page.c b/fs/proc/page.c
> index 2fb64bdb64eb..3e7b70449c2f 100644
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -146,19 +146,13 @@ u64 stable_page_flags(const struct page *page)
>  		u |=3D kpf_copy_bit(k, KPF_COMPOUND_HEAD, PG_head);
>  	else
>  		u |=3D 1 << KPF_COMPOUND_TAIL;
> +
Unnecessary new line.

>  	if (folio_test_hugetlb(folio))
>  		u |=3D 1 << KPF_HUGE;
> -	/*
> -	 * We need to check PageLRU/PageAnon
> -	 * to make sure a given page is a thp, not a non-huge compound page.
> -	 */
> -	else if (folio_test_large(folio)) {
> -		if ((k & (1 << PG_lru)) || is_anon)
> -			u |=3D 1 << KPF_THP;
> -		else if (is_huge_zero_folio(folio)) {
> +	else if (folio_test_pmd_mappable(folio)) {
> +		u |=3D 1 << KPF_THP;

lru and anon check should stay.

> +		if (is_huge_zero_folio(folio))
>  			u |=3D 1 << KPF_ZERO_PAGE;
> -			u |=3D 1 << KPF_THP;
> -		}
>  	} else if (is_zero_pfn(page_to_pfn(page)))
>  		u |=3D 1 << KPF_ZERO_PAGE;
> =20

--=20
Best Regards,
Yan, Zi


--160d1fe3209212974da81d836de7ddfd79b4a6816f2f2b1065ec16097dbe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAABCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmZ7hbMPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUul4P/iqrNJOmfuigzJKCzAzPrdOo9Kn+F8w0mtip
Y2MYTrO8xfC/EMM3Do/186DavEL3lmnm1qyT1DwYcrIFx1Tpx9QrJLdjel37bbbw
jb3wlCEA+tRTk4VYs9KyEQsnrPZQouHT6tCFXjExZIXlcVjW8NTRzJboQSISDOXk
SkNWFVuerxnklPbfC2q8BwrL2QGU9ZfMrdITYiSQsx2qF5X3WunEiZyfFHcqbfWI
sr7ETDdqo/wBmjVnXozdD8SOYamcjjKwc5XHFikwbEDOwaC/J7vROxuWWPwW631K
tAHV0RF7Lanxdoovk1vbf6wopubCRsJjA24AsGKuLtsCSTUInhjOMXEK+hO3wL8e
mijMJuAONnf+/qtUTIC4FZZqvVwmSLH81v+fb5qtQhaztTNVD9ECRgB9o4BJlaHJ
yq9YMnWiWefFQ3FxcFhNhZ56hExFqV4CCG9emCb6cj0eyLM05XWLXAElceenIK3j
4wB1xRp1uKBMMgsqG8Bj0p5p1sJDRu9kCDkVUA52gKfFFomhyGz1bASoI9Dn39IW
AbeakLtX5RxDMiOI8uiztxXcxSqbaqtelIiky3i17rh5GLCjqhJWRhh5LW0BHW1X
cqnvn4onZ/L+cGCJ1ZuUUuEeSY31tGf8aBghUq5IhXvcZGF9lc8Uzu/XQpSW4iwN
nNJ/3hWg
=Pkrs
-----END PGP SIGNATURE-----

--160d1fe3209212974da81d836de7ddfd79b4a6816f2f2b1065ec16097dbe--

