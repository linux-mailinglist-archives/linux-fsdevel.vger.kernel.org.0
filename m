Return-Path: <linux-fsdevel+bounces-51153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48823AD3412
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 12:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0463E16467F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 10:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A15821CFEC;
	Tue, 10 Jun 2025 10:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3Gf0w0ks"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701ED1A2564;
	Tue, 10 Jun 2025 10:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749552753; cv=fail; b=emSZ28q0rFHsjgRJtpDlFKwnma/Hp8EYPVMxV1lhZnm+fp7++hxQEJNELu9SPDvIXAzGykKJMsVZRsdlSrxWh5iKn6iTJSD2xHblx8jSGIz1gre1WDx4kGWk0AuJwuumTzfNCsDlLOrG1tQDk/OQXNwzeSj0UBXgFaGH2f4nynk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749552753; c=relaxed/simple;
	bh=AyJfEiWJkNoJfpTsXcWS2AeR9xUpkm6m3pD2SyhwJeQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kfz9SRfCYUg7M0d4nw+JIS2T1hSCbaefrxmGE9YZ800LfVi55YOq5ZPs72xYCyrA5/o38You5tp3HZD7cNlPd/do2eJnoes+QLcjlEOmK76nX8KT0/iWJUOurkP6DggEh4TvGtBm8n0+kznHMfFGwZGvfC/IGfeHwPRN/zUN4qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3Gf0w0ks; arc=fail smtp.client-ip=40.107.101.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTeQm6+PbjZ9YCmO2wYoGyM1qEqCCJHeA9aPXjSynRnCIH3efl4M/BOg5RyYkWfjdEqBupPERI7Sos/VTDjB0awLCvtQIR8toowjjof82NMf9atu9YPI7zIOk6/VLPqJ/eGZpYcmQkWYwLTwZTFYPYtpjq40rarPt+ihMEihaM2LQGvxMpSIZ7ASBs5+dgco25cYqdqhXhjj3vJaF7gNRy+ZByhVeT4Li8Zu/ZXOnwlyqgOXI0wRjOm4wKk3q7LaaLQY49oHgoUvEfE9VNutFeu9J+8KogyWIt68YkvaPe9OWDAdHOMiMvEl22OyGAWiUnzsTmed7FmB13cAzBO1dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAoQKF8pPMAnmczas7f9JycgXT6NwEWd/h29qTHCt0Y=;
 b=RcgY/Jy8xbOekmunWkY49GdZA8jLYRIbeH4pwATABiYM8tqnFA/LsMy+6CWJrcpysUH+0Ry36EGlKA42c1c3XRT90/klU2XRiE/J2yNuFC3VcyO3ENrJp9fUUnxTxIpu/VUmiM0+DTkriM7qaojHh61fEuF89HvdamVyLTGYsb9dqc3LD/vaaYN5uavyQMUMm69x8Oifz9y1qjAEvzEwS2HYfhu5arEygyqwE9Pm0UfdxPpRoeCGdEICcmTIt5I4oB5NOnbRp1D1Mn6M/vmbvFhaL7swcD5qZ7xNYS5pX34aodDsItIBDnsmCdxWAKxOL477YjEMJdnSY5wslaK8HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAoQKF8pPMAnmczas7f9JycgXT6NwEWd/h29qTHCt0Y=;
 b=3Gf0w0kspSVR4ahNwYViUGGR5YOyfF5Pj4UGp2lUI1PA5p7RWxSps5WL2NKvUg8AReUR03ErOkPkqtntArmMtCho9miQSvmQLH169n7YDIplZMQFh8OCG0mikGyFzKa1hpqfQ/wMvlhyX5I5UzwZ129omzNLPM4oshsTmHozxX0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4421.namprd12.prod.outlook.com (2603:10b6:208:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 10:52:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Tue, 10 Jun 2025
 10:52:28 +0000
Message-ID: <d86a677b-e8a7-4611-9494-06907c661f05@amd.com>
Date: Tue, 10 Jun 2025 12:52:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Implement dmabuf direct I/O via copy_file_range
To: wangtao <tao.wangtao@honor.com>, Christoph Hellwig <hch@infradead.org>
Cc: "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "vivek.kasireddy@intel.com" <vivek.kasireddy@intel.com>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "brauner@kernel.org" <brauner@kernel.org>,
 "hughd@google.com" <hughd@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "amir73il@gmail.com" <amir73il@gmail.com>,
 "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
 "Brian.Starkey@arm.com" <Brian.Starkey@arm.com>,
 "jstultz@google.com" <jstultz@google.com>,
 "tjmercier@google.com" <tjmercier@google.com>, "jack@suse.cz"
 <jack@suse.cz>, "baolin.wang@linux.alibaba.com"
 <baolin.wang@linux.alibaba.com>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "wangbintian(BintianWang)" <bintian.wang@honor.com>,
 yipengxiang <yipengxiang@honor.com>, liulu 00013167 <liulu.liu@honor.com>,
 hanfeng 00012985 <feng.han@honor.com>
References: <20250603095245.17478-1-tao.wangtao@honor.com>
 <aD7x_b0hVyvZDUsl@infradead.org>
 <09c8fb7c-a337-4813-9f44-3a538c4ee8b1@amd.com>
 <aD72alIxu718uri4@infradead.org> <5d36abace6bf492aadd847f0fabc38be@honor.com>
 <a766fbf4-6cda-43a5-a1c7-61a3838f93f9@amd.com>
 <aEZkjA1L-dP_Qt3U@infradead.org> <761986ec0f404856b6f21c3feca67012@honor.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <761986ec0f404856b6f21c3feca67012@honor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL6PEPF0001641A.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4421:EE_
X-MS-Office365-Filtering-Correlation-Id: fb58e536-72cc-4cfe-6647-08dda80ce432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlFKNGRyS3ZDYTRDMklUdHgyaGhNUjN1Wllsb0dDcEpTVEZFQ3FsQzdOVk5T?=
 =?utf-8?B?a2ZtWVRqNENkSTJUbTM0Z1lPVDlEUHF4U3lyVGhnSVprWkRJRkNZNllqdEFz?=
 =?utf-8?B?eVg3ZTlTSzIrZ2JuL2kzUkVydDZVY0JOcUs0TFd2ekh4OFg1QXo4SzJ1VVdI?=
 =?utf-8?B?WUVtejVQTlhwbFdZdmNwLzY4R3lUdEMrNm45TzZYck5KMG4vbXVPNnRlVWwr?=
 =?utf-8?B?a2VaMlJOZDBvV0FlYzVXVHUrMVp1cHRlYThJWWljeXp6NUwyV3d3bndCeFpW?=
 =?utf-8?B?QWg3eWx6R1ozUGpyMnMvMG10QzVIem5GbWMvekM1RndTUVVoVVU0OGNRcWlY?=
 =?utf-8?B?R2NyK0pjTlV5YlpEbFQvTzJ3akFSNldrSFh3UnlDay9vWlE3elhHMWd0YnN4?=
 =?utf-8?B?MlgwYk82WGJxYWgwNk1vSXcvcXZ2SWM4M0hqei9EMEY4NTJjQUJjMkRTUGwz?=
 =?utf-8?B?UEFLd29CMXlDWFJhd2liSU9RWkJYa0g0dVc3YVpqZmN0Y2l0a3pqaGo2RE1X?=
 =?utf-8?B?bUoyNUVkdURVcTZiWUY0TFVTZEtBWGtrTGt2a2VJbCtFZTZDeGdIRU40d3VB?=
 =?utf-8?B?WkpuQU9KQ1FvYTgwck5uMXVUZmFZT09NMmpYaW5oWTdiWDRESjN3MWQyWG1o?=
 =?utf-8?B?VHZBZEJKemd1K0JhQXA5cUR4MFVkbHhFc2V1VDZDOEh6dDdHMEhOY3Y4VVdx?=
 =?utf-8?B?Y0hNbWZLOEpRVUxRTGxCYWk5b3Q2N213bTNPQ3BTZm9CMmlVOThjV3JVVzhU?=
 =?utf-8?B?dXg1UmZYYjJwV09iYVBzQkxPTk1CMDRPa1FqMDJBamo3S0hKcHpjcVVWY3Fp?=
 =?utf-8?B?eWxmRGpDYWpsclcranlyNGJHMStFU2trUWlzeGFEZ3RHNnRWVkN1N1pIaWxv?=
 =?utf-8?B?WHljR1FKNUNHVnZSMmx0Sm1GK3d5WkdqOVpvQ0Y0UzR2M2FQemdWb00valNq?=
 =?utf-8?B?dWZKOThaaFNXTUpaU09taXEzYWZLZFhSY0lTRytWN3FxSTRJVzZNQzdTOXJL?=
 =?utf-8?B?b0NGYTRqMW81ZFVzMk9XTmF4NWlUVEhUQzRGYUNlOWpVTllwbktJNlFRSThO?=
 =?utf-8?B?NEYzYjdlOERCcC9iV0ZMMFJ2MlNFQmEvRTBQR0xEYnZQMHBObnUwckZYbkx6?=
 =?utf-8?B?MDVTallHVUJTRFg4dWdoKzdvdDNLcytmWHM5MEd0Qm05TmZxSDA2UUhUNkZP?=
 =?utf-8?B?RFBIZWFjd2F2YVFWT1pkeU5HdHMzZHlqL201cy9UeWpuTkVrRjY5eXg5emxV?=
 =?utf-8?B?OEpzblVESnlzRDZ4a3NCVUg3TGl0dFpmZUR2cUZ4VHpQVEJ2VEE2QzF3YnFu?=
 =?utf-8?B?YXRQWkx4WjM1dERSSENYRjFYV3B4M1pkcTBQUWI4ZkJ6WmtiUDErSjdZeGNa?=
 =?utf-8?B?dnVVN0ZIQXpINFVCZWFpeWJGQklhOXBhK3VrYnIxZS8xaUxxanpQeXYvUzRS?=
 =?utf-8?B?M2p0Y3J5cW4wNll2M05QZjhiNXhFVDAyWmxPdFd4Nm42V3pTdmZTa0prZTMw?=
 =?utf-8?B?SGh1S0Rnb3NEQjF1a3pxNXJEcy9mS1JGVHNUMC9PdHBpSXFkNGc0Q2Q4UDNJ?=
 =?utf-8?B?WEdTNnpibElHTTMrbXNCRWRwOS8rbFRjbXJaSVl5dXJYa3BXeG9MM3R6SGk2?=
 =?utf-8?B?S2hKYjVCbzViaW9kM0MwbW5PZExUcEU3dEZzMGswb1FaVElYU1JzUkRVSXlD?=
 =?utf-8?B?dDkvTEZsWTV5UnY2dW1vekFPaUlJWTR4UDlYSU5Vd3o5SEUzK2hDL0NDNW1k?=
 =?utf-8?B?dy9XVUZrVEdxOERaWXlsM1l1dU5YZTFlTXBMSVFTQ1FMTXpKRFBVYXZxa0Qz?=
 =?utf-8?B?SGNBQ0FFeUg3VW4xTWJubkQzOXg0SGp6RExYc1lHeXc2dHFVVlIyZFhYTTg3?=
 =?utf-8?B?Q0ZzSElRdEtaRVAvbnRONjQvM1Q0MnN1REI4T1BQeXhYUnhaK2dSM0x4L2Ja?=
 =?utf-8?Q?/WZfC7wyBpg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UktJVVBCeEw0NEtTV2lBZVFyZkJQNGp4QU01NFlKRW03UVpLdDRya2wwQlpx?=
 =?utf-8?B?U1NPdnNlekxlcCtqTUZweDJKQjdTSkNMVU9qV3YyUENucnZoeHFEZC9TYVJa?=
 =?utf-8?B?WklYNU1jYXNJSFgxK0xQV1hFeXE5Z1RYOUN3RWVvNjdUZkIxMjVaRFdrWmcv?=
 =?utf-8?B?bXZ3Tk9TenJmK1M0cEthd09IUDlucGFXQlFUZDJRQVB2OGNnL2RYZ1JTWUlx?=
 =?utf-8?B?ME8xNUFIbWR6ZjNwRjN6TWExcDFVRXBOQ0ZPRkdrZ2wvUmR2dWY3SUJhRk1D?=
 =?utf-8?B?RUNMSzhvSzdRei9JQUVuaDFUemZHcFBSeTZsV0FmWnVzY2VlWTFwWUpZVEln?=
 =?utf-8?B?RjBOY3ZyZmcxWVUvMzlPdG9ENGRqS3RGSFZ2Y1N6d2VDeXhEV2REZk5VY1Zq?=
 =?utf-8?B?dkkzNEF2Tzd5bjk2c2dRWWtyb2lkeitsSVVnTU1jdHRnNzU3NDBhbHpMSHFu?=
 =?utf-8?B?QTVqa1Z5Y1Y0ZitsMFJqdldudHYxNXY5bW9RdEhZSmJiM1E5WE5Kd1hZdU9K?=
 =?utf-8?B?RC8ydmI2Y0NZUGM2Z2hTZ1k5KzZDbkx3TlUray9XR0FwblNvU0UyWlpvRGZk?=
 =?utf-8?B?bEJ4UmFNVlpLeFJFRFhJaDdLNld4OVpKTmhkWDRSejh4aU5DWmN1d2JmeSt5?=
 =?utf-8?B?ZHh3aEtVREE5Rk82VVRLS1FaOHhIVGVOdWdhWklFYUc5cFM4VC9HbENaRlVl?=
 =?utf-8?B?Qm10c3I1akQ1VUUwdWhRa0VUczFtNGZJaHg3eGxYejlGL1pwL3ZMU2xpUjJB?=
 =?utf-8?B?QjVrejFYdTlXcGNLd0RiSFFNVk91SnRsVDdpLzZYZXdmay9qRStjYWZKVzVw?=
 =?utf-8?B?dTkxVElsdWMvTjVWcURNLzlnQU1jSTFocEdaMm1PMXJGamkyWXpRSFpIWHRD?=
 =?utf-8?B?Y0xRbzhNS1RkbUxwdUZ5bUhuYUQyNG1FK1VqTElXNTFQRjZRVVptUHk5MXdK?=
 =?utf-8?B?RFVaM3ppaG1VZkd4dy9HaC9NRlFQTTIxd0VldWdrenlYckNKMG53NzJOVG0y?=
 =?utf-8?B?ODZjK3FCcENrN0hpekUwK3BPRW1QQWlDekNXQ1d1UUhlL2VqYlhsVEh6QjBN?=
 =?utf-8?B?QllTS1kyelg1emhGNjF6SDJZNTAxS1FHclNsSHFFTXZpQWRYQ2dYR1NGQVdz?=
 =?utf-8?B?YXFvSHpZdkNnZkVpVTRCQnN2ZVlqcUZVQlV3THZINGtEa1Nhei9pazhwVlho?=
 =?utf-8?B?cTdJd2c4cXdvREZmc1kxdFRvRHU4VUZiZWJMOEtzSEx3ajRGaFNTKy9QQjJp?=
 =?utf-8?B?cFljRmVkUWVsK2xLYUM1VndTc1Rqa2ptdTRQblJMZlFmNzZ2b1VVZUZ2ZU51?=
 =?utf-8?B?bW5yc29POTRIdjh2b0VKcFhoWDJoVVliWFdPaksyaUpESVkwNlZlalkxd2Z2?=
 =?utf-8?B?elVrb0lNQ3Z3cDIzeVBraDNVZGVZSlJxekw5eTNBbnFJenFIRHlpNFFLMDk2?=
 =?utf-8?B?cXdFWGd2NXU3bFRkSVVDblhpRkpkZnh3TU4rQy9DV295VXZXQ2FXS3JWeFll?=
 =?utf-8?B?YVlUZFM5MFplSEIwaDVhRDhvb2lRbm5NZWFwVlZZQ3prVENwWmppL0RQbS9F?=
 =?utf-8?B?N1Y2b043K1hCM0R2aGhDWlg0RnhlNDFaYXZGYkF0bzlmZ1Y3Sjk0aEVOWGxV?=
 =?utf-8?B?b0o2VGNYNXlTUk55MnEzVW9oU2tpcmU0WFhlNklUVHZGUWZvTkVUcTAwUzJh?=
 =?utf-8?B?a00vVXFjU0FacFdMMVhnNGhHVURQSGs2bGNTS1A4MWUvamcrVnhHU0VES05i?=
 =?utf-8?B?WmVscEhsbUlsNGN5T1QyVHlVVm9acjhCb09rNnBwaENacGIwWERqVk5JYUYy?=
 =?utf-8?B?b05BTnFhbkFsd3Y0OVdOTUdUNlc5RC8vMVZ6OXpSNWN4OHhDcW5DN0hyYkQ4?=
 =?utf-8?B?MXFYY3c0b2FNOUZHL3lYRkRMWWd6cnRHWml1ck1ZNkhhcXFIclZ2UCt5UlJR?=
 =?utf-8?B?d21weEpUdlJLU043RkswVkJ4UXQ4cGZQZVNTdW1qdUlmOTExRFRDKzBJQTJD?=
 =?utf-8?B?L25keVZuNTRFN1lrUS9ST2RjeWJmTUtyb2ZEMHI1VU9hUmRJd3NFZVA5THQx?=
 =?utf-8?B?SHFMTTEySzR0NTVwd0NCWXJiUzlVdUc0VW14cUo0Rjd6SEs0S0xXRDBvcDVl?=
 =?utf-8?Q?+fVc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb58e536-72cc-4cfe-6647-08dda80ce432
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 10:52:28.0700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFnBUImNiyxHQA0cdQuB14+39q8dBimQjVtETw0+B7AbKnu0SZjePkoLiwdw00sK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4421

On 6/9/25 11:32, wangtao wrote:
>> -----Original Message-----
>> From: Christoph Hellwig <hch@infradead.org>
>> Sent: Monday, June 9, 2025 12:35 PM
>> To: Christian König <christian.koenig@amd.com>
>> Cc: wangtao <tao.wangtao@honor.com>; Christoph Hellwig
>> <hch@infradead.org>; sumit.semwal@linaro.org; kraxel@redhat.com;
>> vivek.kasireddy@intel.com; viro@zeniv.linux.org.uk; brauner@kernel.org;
>> hughd@google.com; akpm@linux-foundation.org; amir73il@gmail.com;
>> benjamin.gaignard@collabora.com; Brian.Starkey@arm.com;
>> jstultz@google.com; tjmercier@google.com; jack@suse.cz;
>> baolin.wang@linux.alibaba.com; linux-media@vger.kernel.org; dri-
>> devel@lists.freedesktop.org; linaro-mm-sig@lists.linaro.org; linux-
>> kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org; linux-
>> mm@kvack.org; wangbintian(BintianWang) <bintian.wang@honor.com>;
>> yipengxiang <yipengxiang@honor.com>; liulu 00013167
>> <liulu.liu@honor.com>; hanfeng 00012985 <feng.han@honor.com>
>> Subject: Re: [PATCH v4 0/4] Implement dmabuf direct I/O via
>> copy_file_range
>>
>> On Fri, Jun 06, 2025 at 01:20:48PM +0200, Christian König wrote:
>>>> dmabuf acts as a driver and shouldn't be handled by VFS, so I made
>>>> dmabuf implement copy_file_range callbacks to support direct I/O
>>>> zero-copy. I'm open to both approaches. What's the preference of VFS
>>>> experts?
>>>
>>> That would probably be illegal. Using the sg_table in the DMA-buf
>>> implementation turned out to be a mistake.
>>
>> Two thing here that should not be directly conflated.  Using the sg_table was
>> a huge mistake, and we should try to move dmabuf to switch that to a pure
> I'm a bit confused: don't dmabuf importers need to traverse sg_table to
> access folios or dma_addr/len? Do you mean restricting sg_table access
> (e.g., only via iov_iter) or proposing alternative approaches?

No, accessing pages folios inside the sg_table of a DMA-buf is strictly forbidden.

We have removed most use cases of that over the years and push back on generating new ones. 

> 
>> dma_addr_t/len array now that the new DMA API supporting that has been
>> merged.  Is there any chance the dma-buf maintainers could start to kick this
>> off?  I'm of course happy to assist.

Work on that is already underway for some time.

Most GPU drivers already do sg_table -> DMA array conversion, I need to push on the remaining to clean up.

But there are also tons of other users of dma_buf_map_attachment() which needs to be converted.

>> But that notwithstanding, dma-buf is THE buffer sharing mechanism in the
>> kernel, and we should promote it instead of reinventing it badly.
>> And there is a use case for having a fully DMA mapped buffer in the block
>> layer and I/O path, especially on systems with an IOMMU.
>> So having an iov_iter backed by a dma-buf would be extremely helpful.
>> That's mostly lib/iov_iter.c code, not VFS, though.
> Are you suggesting adding an ITER_DMABUF type to iov_iter, or
> implementing dmabuf-to-iov_bvec conversion within iov_iter?

That would be rather nice to have, yeah.

> 
>>
>>> The question Christoph raised was rather why is your CPU so slow that
>>> walking the page tables has a significant overhead compared to the
>>> actual I/O?
>>
>> Yes, that's really puzzling and should be addressed first.
> With high CPU performance (e.g., 3GHz), GUP (get_user_pages) overhead
> is relatively low (observed in 3GHz tests).

Even on a low end CPU walking the page tables and grabbing references shouldn't be that much of an overhead.

There must be some reason why you see so much CPU overhead. E.g. compound pages are broken up or similar which should not happen in the first place.

Regards,
Christian.


> |    32x32MB Read 1024MB    |Creat-ms|Close-ms|  I/O-ms|I/O-MB/s| I/O%
> |---------------------------|--------|--------|--------|--------|-----
> | 1)        memfd direct R/W|      1 |    118 |    312 |   3448 | 100%
> | 2)      u+memfd direct R/W|    196 |    123 |    295 |   3651 | 105%
> | 3) u+memfd direct sendfile|    175 |    102 |    976 |   1100 |  31%
> | 4)   u+memfd direct splice|    173 |    103 |    443 |   2428 |  70%
> | 5)      udmabuf buffer R/W|    183 |    100 |    453 |   2375 |  68%
> | 6)       dmabuf buffer R/W|     34 |      4 |    427 |   2519 |  73%
> | 7)    udmabuf direct c_f_r|    200 |    102 |    278 |   3874 | 112%
> | 8)     dmabuf direct c_f_r|     36 |      5 |    269 |   4002 | 116%
> 
> With lower CPU performance (e.g., 1GHz), GUP overhead becomes more
> significant (as seen in 1GHz tests).
> |    32x32MB Read 1024MB    |Creat-ms|Close-ms|  I/O-ms|I/O-MB/s| I/O%
> |---------------------------|--------|--------|--------|--------|-----
> | 1)        memfd direct R/W|      2 |    393 |    969 |   1109 | 100%
> | 2)      u+memfd direct R/W|    592 |    424 |    570 |   1884 | 169%
> | 3) u+memfd direct sendfile|    587 |    356 |   2229 |    481 |  43%
> | 4)   u+memfd direct splice|    568 |    352 |    795 |   1350 | 121%
> | 5)      udmabuf buffer R/W|    597 |    343 |   1238 |    867 |  78%
> | 6)       dmabuf buffer R/W|     69 |     13 |   1128 |    952 |  85%
> | 7)    udmabuf direct c_f_r|    595 |    345 |    372 |   2889 | 260%
> | 8)     dmabuf direct c_f_r|     80 |     13 |    274 |   3929 | 354%
> 
> Regards,
> Wangtao.


