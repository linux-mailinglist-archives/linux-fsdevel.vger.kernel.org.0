Return-Path: <linux-fsdevel+bounces-20793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3527D8D7CF6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 10:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95952B21E70
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 08:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553E25A110;
	Mon,  3 Jun 2024 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pxTW1Hkm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166295914C
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717401708; cv=fail; b=FzI2lBzvB6MfHI0D+zPNJcJT4dc3MigfjHJWdJnsP1HzUacuyY/0S7AQBYbFzR/MAFgdHV+BMRLM2iE1sr59x1uVkCmfm7fDaVk7PtKWP6vkrrzsmxAc/JN48fXwxUFS3Fh42fQKD16qA2K892M/je/Tl4mP0ic7AzRCCb8fwlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717401708; c=relaxed/simple;
	bh=IHQOuJkF+lM4c/RH2ewoqpJjLanVmhU8IaxRyXwhro4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m/RkEwFSDGSLmkFGBXQbHQQ6mE7DSTwaTaUk5VGKyZIn962yJuNZOS+5Tl5Ma4dhZV9hE1+C/c30vERtKuxDZWN0vjkPH5A0ABiZkHvLKr5KoYTA9SCxDJ3cDDqlFMgP1eARoH5pXaQmmQvAF7tkNjyyDCC5mjzSh6ebpjt3q0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pxTW1Hkm; arc=fail smtp.client-ip=40.107.100.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jr5xwBTZRKZjP/eoBSZPGwiSWr3v4L3ww7X17yGcnb/EldPIzShh8pg4m74seGtXv/ofpyspJR+6avssDjnwusz1MM+jxmILj+Q1HrzHRKXujaENvcu9Qh0HrMs3DaHb1SQa7vcVzLW57UA7TIFzRDXe7+2tV9lbGs3Wm6P/h2wIuAEpFakWPaQ2P+R8F4IdEXYrZtE2EorlTLRrmOejZPHP73lUg1qyP51aAxIHlXNf8WminGHKuj9B4NHYTFMCcyQ+gNRr8ek29jk1+exL05w4vgfa6cUY6fsEWPytIn11Q3Z9VsHi8FqgXEQ9VOA11g6Ak2LtgG9DJfuryYh1Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHQOuJkF+lM4c/RH2ewoqpJjLanVmhU8IaxRyXwhro4=;
 b=kFGHvCVKKTNYdekNtNF04irRZWsZphaIGiCIwlVZJu95pAJfDf9s3MNmPPR3QEjqDPsZZrj1YQG60c3VSVwcBbjXKYXR0ocTuteZ1KGY853/TNpLxMn4B7Y76F1nryQSxfb8jO99/GYunJIB0l5mwOmS7gNyiUpjUirFhGJWkBtYh9efFpm74p1vrVgkAYNeIgz02k4dXKRTJTtg8qRkWviPouUVy5mv1fKH08K0i28kyaJUY7zJjzi3/+7nqJwm26uhkakOAnggdWZptbSmiY5g9hB+CfqBOz6Wg37cw60CTAs+BHkRpU7ZZ0RjUKfMnFS6B8Zp8FEEaduTehBSmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHQOuJkF+lM4c/RH2ewoqpJjLanVmhU8IaxRyXwhro4=;
 b=pxTW1HkmZdQDDzBKOqD7aHV85xSefu7wj9KpZ9X71AUiI0iK+uVChqKBSfH17FdGyty5tgDs3S91oK3LdvdRLFzGV0x2AZGsQvDxrAWWYomt+8u7YkdzRZ59R+feYrE1kn2nzuU4lCGqocXTqMmm6Le3srbFq7Z0petTYmHLTgi6zq+p22pq7wvp/hyyRSLoJYLqwOLmBSSBuTYWhP0c6Gc24zD36BwmduWJA70+aWOSRfhMe6mIbXtRz7+DepO5RqdGbgmF+iRBz0/UaahrYzelDiE0boHlwsEaa+Gzx6r21VTl9VH0F/o2vZ4aRmYLgrPUau9wbbbN13mUDn4k6w==
Received: from SJ2PR12MB7845.namprd12.prod.outlook.com (2603:10b6:a03:4ce::18)
 by SA1PR12MB6701.namprd12.prod.outlook.com (2603:10b6:806:251::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 08:01:41 +0000
Received: from SJ2PR12MB7845.namprd12.prod.outlook.com
 ([fe80::ad75:1017:e4a8:3f91]) by SJ2PR12MB7845.namprd12.prod.outlook.com
 ([fe80::ad75:1017:e4a8:3f91%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 08:01:41 +0000
From: Peter-Jan Gootzen <pgootzen@nvidia.com>
To: "mszeredi@redhat.com" <mszeredi@redhat.com>, "lege.wang@jaguarmicro.com"
	<lege.wang@jaguarmicro.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
CC: Idan Zach <izach@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>, Oren Duer <oren@nvidia.com>, Yoray Zack
	<yorayz@nvidia.com>, Eliav Bar-Ilan <eliavb@nvidia.com>,
	"angus.chen@jaguarmicro.com" <angus.chen@jaguarmicro.com>,
	"bin.yang@jaguarmicro.com" <bin.yang@jaguarmicro.com>
Subject: Addressing architectural differences between FUSE driver and fs - Re:
 virtio-fs tests between host(x86) and dpu(arm64)
Thread-Topic: Addressing architectural differences between FUSE driver and fs
 - Re: virtio-fs tests between host(x86) and dpu(arm64)
Thread-Index: AdqybnzAiozTvtlkQFaloMBVG2WGpwDHcmEA
Date: Mon, 3 Jun 2024 08:01:41 +0000
Message-ID: <b55cb50b3ecf8d6132f8633ce346b6adc159b38c.camel@nvidia.com>
References:
 <SI2PR06MB53852C83901A0DDE55624063FFF32@SI2PR06MB5385.apcprd06.prod.outlook.com>
In-Reply-To:
 <SI2PR06MB53852C83901A0DDE55624063FFF32@SI2PR06MB5385.apcprd06.prod.outlook.com>
Reply-To: Peter-Jan Gootzen <pgootzen@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB7845:EE_|SA1PR12MB6701:EE_
x-ms-office365-filtering-correlation-id: fe090baa-9520-4cb4-5d19-08dc83a36737
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?Qmd5bXFZTVhyNDNmcm16MjdhcVl3TkxnMzBzckJkYUpzK1hPU0JoWHBlTzh2?=
 =?utf-8?B?YnBzRFJkWU5IVHdobVJPWWFSeGFUVlpuclFIa0xKendXMVJTZndFeWlsSVVq?=
 =?utf-8?B?MkFSN045VUV3VVMva1BVRkJrMzc1UXFjNVExaHRiQ3FoeGdmWHlaOHF5T0dm?=
 =?utf-8?B?Mzh4THZaU20xSGdTTTZvM3VmNk55TzZDeDhFd2N3aFNKd0E0anpDUFpZdjgy?=
 =?utf-8?B?U2dWV0gvTzFkZDNEbC9GWFFxWlhyOGlUTFl4UndjdFlKVkR1c2dmcGVIQkZx?=
 =?utf-8?B?QTRlNk9tWUR2SFNyVTRPeENPNmlXU2ZEd05pd1ZDWXZHM2d2L1dLaG92T1o2?=
 =?utf-8?B?eXFjR0VNWWJLeHZ6V1NlRkJ2UjdsRlBQZExXQVhPbjZrcUxMVGc3Z1o0VEFU?=
 =?utf-8?B?TUxtenVYSThtYjJUYXc2aVA1bjhSbXUwaWo1TDI4NnFkWFNvUFFya05jNWZM?=
 =?utf-8?B?bGN0WE9yVktJQ0pFN3U4U1Z1d0ZiR2xlQ255R3pqVHR1UTFyelNpUGVZQ0Jq?=
 =?utf-8?B?NjhtanY2QmdTeXV5clhyZHdzVEVtRUgxNFFoaTNYMlpZQ2hqc3lzNDJEVXRZ?=
 =?utf-8?B?NmU0UE1pcGNYbVhQZnhkRldHVFo5QmlyZUE1bjJTK3JYeWI1Y056SlF0Z05X?=
 =?utf-8?B?aVNVTjZValF1L3FhQVRweHR3YmZuTzBiSjhRYTR0V2o0aGI0d0REOUxXNStZ?=
 =?utf-8?B?ZE0zQ25TbkdrbHo0dnErNGtFRDlPQmZreFpIM1pRRkNNY1poaDFvNmpXS0NL?=
 =?utf-8?B?OXhMWGhSaDdFNmxTTm1icmRHQi8zYWpVQVRjOVBMMFJVUW1OcndobmFCWmo2?=
 =?utf-8?B?eVI3NnlmdFpkNk40R0dxWEZBNjhLa0Y5ZU9zeTB2ZmhuaG5HZ1kzQXBTSVc2?=
 =?utf-8?B?VTA4VXVzc0paUGZuaU9ubFJkWW9RanpWN3pNb3ZBY2VHNEZrdnloUjNnU0d2?=
 =?utf-8?B?RUxuWFZBRmoxd3I4UXVzb2c3dXN6QjJWdTBCekJlMjcreFdKSnZmSzRjVzAv?=
 =?utf-8?B?ZTIvemdUcVB3Mjl1MkMvTHAxSSt3T0d2MkY4MDQ3Z3dpYiszbWhZVHFPSldG?=
 =?utf-8?B?M0lmN3YxWTNKSjdKV2VBODc4Z0V6UkQ4Wkd1WjhwV1JOMXRlOEllVHhqdGhO?=
 =?utf-8?B?WHVzTG4zeUFpZkh6ekY2RU9ad05TcDRiS0JKaWczVkhTbmphUjZRQWtFTGk1?=
 =?utf-8?B?RG9lOGNDOTNzZHBlbFJkdi9JWE83OFNTVjVBbnNXUEcxTzZqOUdKUTV1VE0w?=
 =?utf-8?B?SzdEWHNYK1pMdS9kUklYZzNwSER4SVg4VjVLRUE3MUNVNy9OcVZrS2N3T2tQ?=
 =?utf-8?B?cHZzY1RUMW03Vjh1QzZaS04vakxpNEdEN0QrN1RPNU5ROWZaSDV2Nk81TnV2?=
 =?utf-8?B?bWhJZ3ZxaG9iWTc4NTI4a3JXNXZnZ0lSSjJCd1hPbTZGakJWVkNMSzNUQktC?=
 =?utf-8?B?R1N5WG9HenRXQnZPWnB1azZsYklyNFFIN1RLSHFxRjY4WTBSRWhuQVpneXRm?=
 =?utf-8?B?Z2FrZy9IcTdIdjhqOE9nT3hkS3VkUmlxMkFEZWswNVZTbFJ5VmhNRUN5NzNq?=
 =?utf-8?B?UklGenNYdHFnU1phdmRNYWkzcVJ0cEs2ZWVtU0VvOHFRWW9SN2h5MDNoeVJq?=
 =?utf-8?B?N0RRMDZ3NGZYTGNRdGJrbzVYNmNrVUp4a2hiSGt3WWFma09rNzNwMEFFTDYx?=
 =?utf-8?B?cUtLcHI0VFhKeU90ZVVNeUpST3ZxWWJCU3kwMXFyWENNbFZQQ08zNUovdWV4?=
 =?utf-8?B?SHJ6L0phSUVERmF6ZW50T1o3eHoxeWlWWE1xM1pBRDMyc2xqaFJYemN4ME0x?=
 =?utf-8?B?b0hMb0tHNWJpOVZvMDI1Zz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB7845.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MmdDak5YdDgvc1U3d1c4M1o5ZGxXSFk5SUUwM0tjNEZBSFR0d0g2eUt1WUpt?=
 =?utf-8?B?NmJtd2pTdVRHNFlnNjgvaHdWeVBLWW1oLy9DRHg3VkljUGdaQklnN2p3Tlhi?=
 =?utf-8?B?akN0RXpCWk5RWWZpYVhtcnlwSTgwQ05YL0F3c1d4TitTVGpnYUpYQUJNL0tD?=
 =?utf-8?B?Q01zbEtWcGNEQi9NZVF5aVp5UmRNQVpJVzN3NmpEblF6QjZycU1Bc1VtTGJP?=
 =?utf-8?B?YkFUem5ybE9kaS9JbU0zZ3ozd3ZOS3diTmhodG9sQnIyc2RYZ1lrSjJoTlZJ?=
 =?utf-8?B?bU4ySnd6dTduTkQrcUFWUmMzUkplVVRyRytTN3d1WmVST3NyOEFHOWVBUWVP?=
 =?utf-8?B?UXFCRnBOZEVuMlprVTFJRGJaK2dqakFHclJtR3dkaEM0aHh3emkvQkt5YzUy?=
 =?utf-8?B?UWIxRmFIRHlwSXd5MGdpYVQra3h2dDlEZTRaNTF6RTRab0p6UHBFMmkxS3hX?=
 =?utf-8?B?WDcyTDFqOUtDVUg5NWd5TmtJbW52aFJaYU5na2RJTDlPV0pnR2VxYTdZd2p2?=
 =?utf-8?B?cVZVZlBRVTBYYXF2ZDVOYlNuU0dNNmdrTjZSK0xZYXR4U0JjUE9ObVJBMm4v?=
 =?utf-8?B?b1BkUVBTWFR5c0hBejJkMDUxQXk4K0diSHpDMWcxeGpPU3gvWDdac0JSY0Vz?=
 =?utf-8?B?cjIydmk5a3l1TVNWRkRaSHNINWJsMU80ZGNSejFjN2FwY2NJaUs4T2loNUc0?=
 =?utf-8?B?empRY2syTThwU1NqTU1saU5HWDhhYUFrb0kvYkVIcy9NRndJR1NwcEQyTkd0?=
 =?utf-8?B?MWdvYWpack9hY2NtL0krNUV0L2w4eVpGbjZuTlNCeTdvUlFncTZuTlRRalRI?=
 =?utf-8?B?Q1h3SjJXMU4vekVURk1RTWJoaWJZVVRkQWVQRDVYdk5uOTFsSjNaY1hMOWh2?=
 =?utf-8?B?UXl6bUpmK1YyTm9EN1FBSDNoZEV4MklEeklJUVMxRG1jWFhkK3lmaXlaeTY2?=
 =?utf-8?B?RXZvNDFmdVJMNmFQY0pwc2JMZkU1dSs3emY1VFIvdytOc0pFcGRGalpEWHBY?=
 =?utf-8?B?TUVlYkkxZTNxRmM0QXQ4ZzJEK1lIUCtFVlE2Qmh6a2FyZ0pGU3dQUmpiZkFD?=
 =?utf-8?B?ZDhObng2YnhJbWNyZ0h0ajZ1UFU4Rko5QU5xeDNrQ3I3ZE0zR3VWdHV6ekNH?=
 =?utf-8?B?K3lvVE8ycFRlclhZV0s5LzBSaUZjUVU5REV0YUdvS3VUbUZmSFlGUTVDY004?=
 =?utf-8?B?QUdiMGlKa1ZtOXoyaEduRkNBZkhDSjZNUzkrUG54OEVDNW9LeHcxZzh0NWR2?=
 =?utf-8?B?cFJRK1k3cExTbHl3M0N3T3VFZC8ySXo5Nk0vRjY2aU9EcXBtemFJMzZqME9k?=
 =?utf-8?B?OW0vdlFxWlpob0toUGEvSHN6NDBMaUsreUZkSzFaK0pGNlJrOTBWTnNoMCtC?=
 =?utf-8?B?Ukp4YzhxNEFVU1QvOTZTQWdVbjFoQ1llbmh5RERjcTdJVU1UUlRBOXI5T1F0?=
 =?utf-8?B?bDBlcjhpMTd5VDZoL20wOUZxTVlPcUJuOWtWL2NUcXkxVld6cE5rZDRHQ3R4?=
 =?utf-8?B?MzhZU3p6TDd3REduT1lmU25MbkxOUWNFYjkxbDdVMjQ2RVR2eFNlN0RGV2da?=
 =?utf-8?B?N2hCS2RMc2lCZk1FaE1TWGFieEdYQjJSdDIvR0o1R2R1d0FOb0NtNzRIZlZD?=
 =?utf-8?B?b0FNSW91eUVBUHI3eEVtSHpONDdaOUxCMEJWYmcycExHU3JONFE0NDFOckky?=
 =?utf-8?B?c0lzOE5RMndRRlp1MWd6YlFMQWpNTFQxZ0c0cXJSYnViTnQ4c3ZHN3F0dW1Y?=
 =?utf-8?B?WURCUE13L0toVHhFcjVJYTJOUEZBWXJYQ0ZTZVZVUnh2OGpidmtjaVVtZXo2?=
 =?utf-8?B?UnRndGxEcjVpT3UyTkcvRXBsVitDdERmSzZsS2hFV0Yzdlk0ejArbFBRdEJk?=
 =?utf-8?B?UERwVDhHMldqaTlEb2RJcy84SXIzeUFadFYxM3k0SUJIRWV6emIxaGlwOVJ2?=
 =?utf-8?B?Ti9ubVhWVnZhTk13Z3ZlV2NrTDRRSVRuOHE2a1hEeEdIREp0QnZaWTNUckdY?=
 =?utf-8?B?WExmbXZOaXdmK0kyeERYZzlDUHhpWFhWR1VyelRXdCtBRWVMMlZDOE9MQTN6?=
 =?utf-8?B?blFuenBJWUxjYXVqSGhGWUgxTnR2MC92dXVlRnF3YUY4M3ljUW9rdGxvc2Vj?=
 =?utf-8?B?YnZjY2lSc21YR3g2dlkvaGQ0Y1RXWThCY0Y3ZFVyd2ROUXJhZDY0T0RpRTI0?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E522D1A363B7EE41AB0268DC62E57F4C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB7845.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe090baa-9520-4cb4-5d19-08dc83a36737
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 08:01:41.4148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r7kVcN0NjGX9WwawpWRTvPeHFu6qwIckJZbfGmwBqsI0hlqGJP7Zu1WPn2akBetJxb9BP9XCcpYAzJw5URAoAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6701

SGkgWGlhb2d1YW5nIGFuZCBvdGhlcnMsDQogDQpZb3UgaGF2ZSBpZGVudGlmaWVkIGFuIGlzc3Vl
IHRoYXQgd2UgYXJlIGFsc28gcnVubmluZyBpbnRvIGFuZCBoYWQgYWxzbw0KcGxhbm5lZCB0byBh
ZGRyZXNzIHdpdGggdGhlIGNvbW11bml0eS4NCldlIGN1cnJlbnRseSBzb2x2ZSB0aGlzIGJ5IGV4
cGxpY2l0bHkgdGVsbGluZyB0aGUgdmlydGlvLWZzIGRldmljZSB3aGljaA0KYXJjaGl0ZWN0dXJl
IGlzIHJ1bm5pbmcgb24gdGhlIGhvc3QgdGhyb3VnaCBhIHNpZGUtY2hhbm5lbCBzbyB0aGF0IGl0
DQpjYW4gY29ycmVjdGx5IGludGVycHJldCB0aGUgZmxhZ3MgKGUuZy4gT19ESVJFQ1QpLg0KQXMg
b3RoZXJzIGFyZSBhbHNvIHJ1bm5pbmcgaW50byB0aGlzIHdpdGggdGhlIGluY3JlYXNlZCBwb3B1
bGFyaXR5IG9mDQpoYXJkd2FyZSB2aXJ0aW8tZnMgZGV2aWNlcywgbGV0J3MgZ2V0IGludG8gdGhp
cyBpc3N1ZS4NCkkgaGF2ZSBpbmNsdWRlZCB0aGUgRlVTRSBtYWludGFpbmVyIE1pbGtvcyBTemVy
ZWRpIGFuZCB0aGUgVmlydGlvDQptYWludGFpbmVyK3NwZWNpZmljYXRpb24gY2hhaXIgTWljaGFl
bCBTLiBUc2lya2luIGluIHRoaXMgdGhyZWFkLg0KDQpUaGUgY29yZSBpc3N1ZSBoZXJlIGxpZXMg
aW4gdGhlIGZhY3QgdGhhdCB0aGVzZSBmY250bC5oIGRlZmluaXRpb25zIGFyZQ0KZGlmZmVyZW50
IHBlciBhcmNoaXRlY3R1cmUgKGFzIG9mIG5vdyB0aGVyZSBhcmUgOSBmY250bC5oIGhlYWRlcnMp
LiBNb3JlDQpzcGVjaWZpY2FsbHksIHRoZSByZWFsIG51bWJlcnMgZGVmaW5lZCBpbiB0aGUgaGVh
ZGVyIGFyZSBkaWZmZXJlbnQsIG9uDQp0b3Agb2YgcG9zc2libGUgZW5kaWFubmVzcyBkaWZmZXJl
bmNlcy4NCkZVU0UgaGFzIGEgbWVjaGFuaXNtIHRvIGRldGVjdCBlbmRpYW5uZXNzIGRpZmZlcmVu
Y2VzIHdpdGggdGhlIDMyYml0DQppbi5vcGNvZGUgdmFsdWUgKHZpYSBGVVNFX0lOSVRfQlNXQVBf
UkVTRVJWRUQpLg0KSG93ZXZlciwgdGhlcmUgaXMgbm8gbWVjaGFuaXNtIGluIEZVU0Ugb3Igdmly
dGlvLWZzIHRvIHRlbGwgdGhlIEZVU0UNCmZpbGUgc3lzdGVtIG9yIHRoZSB2aXJ0aW8tZnMgZGV2
aWNlIHdoaWNoIGFyY2hpdGVjdHVyZSBpcyBydW5uaW5nIG9uIHRoZQ0KaG9zdC4gVGh1cywgdGhl
IHZpcnRpby1mcyBkZXZpY2UgY3VycmVudGx5IGNhbm5vdCBrbm93IGhvdyB0byBjb3JyZWN0bHkN
CmludGVycHJldCB0aGUgZmNudGwuaCBmbGFncy4NCkZvciBleGFtcGxlLCB3ZSBhcmUgZGVhbGlu
ZyB3aXRoIHN5c3RlbXMgdGhhdCBoYXZlIEFSTTY0IGhvc3QgYW5kIEFSTTY0DQp2aXJ0aW8tZnMg
ZGV2aWNlLCBvciB4ODYgaG9zdCBhbmQgQVJNNjQgdmlydGlvLWZzIGRldmljZS4NCkFzIEZVU0Ug
YWxyZWFkeSBjb250YWlucyB0aGUgbWVjaGFuaXNtIGZvciBlbmRpYW5uZXNzLCBpdCB3b3VsZCBt
YWtlDQpzZW5zZSB0byBhbHNvIGluY2x1ZGUgYSBtZWNoYW5pc20gZm9yIHRoZSBhcmNoaXRlY3R1
cmUgaW4gRlVTRSB0byBzb2x2ZQ0KdGhpcyBpc3N1ZS4NCg0KDQpXZSB3b3VsZCBsaWtlIHRvIG1h
a2UgYSBwcm9wb3NhbCByZWdhcmRpbmcgb3VyIGlkZWEgZm9yIHNvbHZpbmcgdGhpcw0KaXNzdWUg
YmVmb3JlIHNlbmRpbmcgaW4gYSBwYXRjaDoNClVzZSBhIHVpbnQzMl90IGZyb20gdGhlIHVudXNl
ZCBhcnJheSBpbiBGVVNFX0lOSVQgdG8gZW5jb2RlIGFuIGB1aW50MzJfdA0KYXJjaF9pbmRpY2F0
b3JgIHRoYXQgY29udGFpbnMgb25lIG9mIHRoZSBhcmNoaXRlY3R1cmUgSURzIHNwZWNpZmllZCBp
biBhDQpuZXcgZW51bSAoaXMgdGhlcmUgYW4gZXhpc3RpbmcgZW51bSBsaWtlIHN1Y2g/KToNCmVu
dW0gZnVzZV9hcmNoX2luZGljYXRvciB7DQogICAgRlVTRV9BUkNIX05PTkUgPSAwLA0KICAgIEZV
U0VfQVJDSF9YODYgPSAxLA0KICAgIEZVU0VfQVJDSF9BUk02NCA9IDIsDQogICAgLi4uDQp9DQpU
aHJvdWdoIHRoaXMgdGhlIGhvc3QgdGVsbHMgdGhlIEZVU0UgZmlsZSBzeXN0ZW0gd2hpY2ggdmVy
c2lvbiBvZg0KZmNudGwuaCBpdCB3aWxsIHVzZS4NClRoZSBGVVNFIGZpbGUgc3lzdGVtIHNob3Vs
ZCBrZWVwIGEgY29weSBvZiBhbGwgdGhlIHBvc3NpYmxlIGZjbnRsDQpoZWFkZXJzIGFuZCB1c2Ug
dGhlIG9uZSBpbmRpY2F0ZWQgYnkgdGhlIGBmdXNlX2luaXRfaW4uYXJjaF9pbmRpY2F0b3JgLg0K
DQpGb3IgYmFja3dhcmRzIGNvbXBhdGliaWxpdHksIGEgbWlub3IgdmVyc2lvbiBidW1wIGlzIG5l
ZWRlZC4gQSBuZXcgZmlsZQ0Kc3lzdGVtIGltcGxlbWVudGF0aW9uIGNvbm5lY3RlZCB0byBhbiBv
bGQgZHJpdmVyIHdpbGwgc2VlIHRoZQ0KRlVTRV9BUkNIX05PTkUgb3IgdGhlIG9sZCBtaW5vciB2
ZXJzaW9uLCBhbmQgaXQgd2lsbCBrbm93IHRoYXQgaXQgY2Fubm90DQpyZWFkIHRoZSBgYXJjaF9p
bmRpY2F0b3JgIGFuZCB0aGF0IGl0IGNhbm5vdCBtYWtlIGJldHRlciBhc3N1bXB0aW9ucw0KdGhh
biBwcmV2aW91c2x5IHBvc3NpYmxlLg0KDQpUaGlzIHdvdWxkIGJlIGEgbWluaW1hbCwgYmFja3dh
cmRzIGNvbXBhdGlibGUgY2hhbmdlIHRoYXQgZXh0ZW5kcyB0aGUNCmN1cnJlbnQgRlVTRSBwb3J0
YWJpbGl0eSBzY2hlbWUgYW5kIGRvZXNuJ3QgcmVxdWlyZSBhbnkgc3BlY2lmaWNhdGlvbg0KY2hh
bmdlcy4gV2hlbiB0aGUgdGltZSBjb21lcyB0aGF0IGEgbmV3IGFyY2hpdGVjdHVyZSBpcyBpbnRy
b2R1Y2VkIHdpdGgNCml0cyBvd24gZmNudGwuaCB3ZSBtdXN0IHNpbXBseSBhZGQgYW5vdGhlciBl
bnVtZXJhdG9yIGFuZCBhbiBpZmRlZiB0bw0KdGhlIGNvZGUgc2V0dGluZyB0aGUgYGFyY2hfaW5k
aWNhdG9yYC4NCg0KIA0KLSBQZXRlci1KYW4NCg0KT24gVGh1LCAyMDI0LTA1LTMwIGF0IDA5OjMx
ICswMDAwLCBMZWdlIFdhbmcgd3JvdGU6DQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBv
cGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gSGVsbG8sDQo+IA0KPiBJIHNl
ZSB0aGF0IHlvdSBoYXZlIGFkZGVkIG11bHRpLXF1ZXVlIHN1cHBvcnQgZm9yIHZpcnRpby1mcywg
dGhhbmtzDQo+IGZvciB0aGlzIHdvcmsuDQo+IEZyb20geW91ciBwYXRjaCdzIGNvbW1pdCBsb2cs
IHlvdXIgaG9zdCBpcyB4ODYtNjQsIGRwdSBpcyBhcm02NCwgYnV0DQo+IHRoZXJlJ3JlDQo+IGRp
ZmZlcmVuY2VzIGFib3V0IE9fRElSRUNUIGFuZCBPX0RJUkVDVE9SWSBiZXR3ZWVuIHRoZXNlIHR3
bw0KPiBhcmNoaXRlY3R1cmVzLg0KPiANCj4gVGVzdCBwcm9ncmFtOg0KPiAjZGVmaW5lIF9HTlVf
U09VUkNFDQo+IA0KPiAjaW5jbHVkZSA8c3RkaW8uaD4NCj4gI2luY2x1ZGUgPGZjbnRsLmg+DQo+
IA0KPiBpbnQgbWFpbih2b2lkKQ0KPiB7DQo+IMKgwqDCoMKgwqDCoMKgIHByaW50ZigiT19ESVJF
Q1Q6JW9cbiIsIE9fRElSRUNUKTsNCj4gwqDCoMKgwqDCoMKgwqAgcHJpbnRmKCJPX0RJUkVDVE9S
WTolb1xuIiwgT19ESVJFQ1RPUlkpOw0KPiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4gfQ0K
PiANCj4gSW4geDg2LTY0LCB0aGlzIHRlc3QgcHJvZ3JhbSBvdXRwdXRzOg0KPiBPX0RJUkVDVDo0
MDAwMA0KPiBPX0RJUkVDVE9SWToyMDAwMDANCj4gDQo+IEJ1dCBpbiBhcm02NCwgaXQgb3V0cHVz
Og0KPiBPX0RJUkVDVDoyMDAwMDANCj4gT19ESVJFQ1RPUlk6NDAwMDANCj4gDQo+IEluIGtlcm5l
bCBmdXNlIG1vZHVsZSwgZnVzZV9jcmVhdGVfaW4tPmZsYWdzIHdpbGwgdXNlZCB0byBob2xkDQo+
IG9wZW4oMikncyBmbGFncywgdGhlbg0KPiBhIE9fRElSRUNUIGZsYWcgZnJvbSBob3N0KHg4Nikg
d291bGQgYmUgdHJlYXRlZCBhcyBPX0RJUkVDVE9SWSBpbg0KPiBkcHUoYXJtNjQpLCB3aGljaA0K
PiBzZWVtcyBhIHNlcmlvdXMgYnVnLg0KPiANCj4gRnJvbSB5b3VyIGZpbyBqb2IsIHlvdSB1c2Ug
bGliYWlvIGVuZ2luZSwgc28gaXQncyBhc3N1bWVkIHRoYXQgZGlyZWN0LQ0KPiBpbyBpcw0KPiBl
bmFibGVkLCBzbyBJIHdvbmRlciB3aHkgeW91IGRvbid0IGdldCBlcnJvcnMuIENvdWxkIHlvdSBw
bGVhc2UgdHJ5DQo+IGJlbG93DQo+IGNvbW1hbmQgaW4geW91ciB2aXJ0aW8tZnMgbW91bnQgcG9p
bnQ6DQo+IMKgIGRkIGlmPS9kZXYvemVybyBvZj10c3RfZmlsZSBicz00MDk2IGNvdW50PTEgb2Zs
YWc9ZGlyZWN0DQo+IHRvIHNlZSB3aGV0aGVyIGl0IG9jY3VycyBhbnkgZXJyb3IuDQo+IA0KPiBS
ZWdhcmRzLA0KPiBYaWFvZ3VhbmcgV2FuZw0KDQoNCg==

