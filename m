Return-Path: <linux-fsdevel+bounces-71361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DF8CBF2B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 18:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A274230184A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 17:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A77335BCF;
	Mon, 15 Dec 2025 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="mMVq4YXS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D04630F7F9;
	Mon, 15 Dec 2025 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765818720; cv=fail; b=QkaQiDlRtl7J21EZlWCQ4JWBrk6I6uLaX+AcOQfWiXaAG/kvvsaAGz9Z/X/wj166gon4ykr4YnwmYMZLIARrXpYpDTrxGhCuFDcCRAilEv50QUc5xk3s1cw+fGbbEB3ZczLcakoRTro0I8JIEJhypC8mcG9wUvppNUtL5V34OIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765818720; c=relaxed/simple;
	bh=jjW0/Mjaq9dpluSsl0So6i+5oHoUtZNnYPVdQt6wAIU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NdWlFLqU595FI1l1N0/fZMuXMY3RpeBAcpiTLPMnG7TiONYCFYA6aIy/9EyvDmUTAhTHCk8sIdxO7ecqOnoJEM9IupWitFAcJK/MzlDi4lXPCGqsgP51VZcDc325FD3tRlD25C1GfIMIMIKCqRi9qG3WaOapXJ52GuED2phClOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=mMVq4YXS; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023129.outbound.protection.outlook.com [40.107.201.129]) by mx-outbound43-74.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 15 Dec 2025 17:11:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y98UsbseXKfb1QIy/lc30+fBuD9WGiCpkrTv5UHxj6dipgVbVlwct4XJbHFM9lzOHQLaDlrjgd5t6G14fgglurehNEOe7T0AqWoDEXl+ssqvliPTJjTARFnLJLppNpYj2ePvBdytaLBU/AqpQse4Ztko7as86DHxHnWTtQreqJ17iraCUwBz2o5wiHzeKV18wQ6lsSAKof40vvKHMCIshLUp1C2odGlU6qQqGXAq1ZZcuQJhspfaa18HqTuteIJjqmY7VI1rkQOyFq5vmtyubvJ+MRKo2oTNwRPl++Hx+jqPENsqkwW9F/nZrCK0GsTDgRuQLfrkT1xBoV28NqVU3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjW0/Mjaq9dpluSsl0So6i+5oHoUtZNnYPVdQt6wAIU=;
 b=y4KT9y1MHGtdF3o5+Y7jgQMImKwoXIhrt6dcDJKHfGVs9T1CDa9GqM+4zY5+EVJcqLay/Augcj7E3uj1++b/e6bjDpParZEUnO23Aq6X+i4nuhmqOjVgyRFxpAyVgcJClqlyY11JU5mujIzcAP7gleHZTsSVZT7DgjlrnKC8/Wrp2yqeGIeN4F2k1eLZKgaHz/sxsFTJZICeIo/Tf0xD9pBTQ8YCCeUjEbf2imaMHrASP+QiNNzUpwr+cd99KjePDdULS6Kdz5n7WzOlD30KWDMCEESxD6otVmWgYWtARlu8a3TO0DWHFg42EN2PNathpw9XV9IRiHg/6fWcE/em6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjW0/Mjaq9dpluSsl0So6i+5oHoUtZNnYPVdQt6wAIU=;
 b=mMVq4YXSZZxcDzEu20Sk1ssgmwDKV78CeiKEog2bq9nHeX+Ng5QJiz7B9fvidKpXDmRS7QWd2m+XK9buL56O2RFVvTFKiavS57AlXy1gAGUyGC5Z5HdETZK2FpoZOOflSpNK80gAzD7jfQapKlfrl2oEiqnthJ++heS86wm8Td0=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by DM4PR19MB8304.namprd19.prod.outlook.com (2603:10b6:8:af::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Mon, 15 Dec
 2025 17:11:45 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%5]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 17:11:45 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: Luis Henriques <luis@igalia.com>, Miklos Szeredi <miklos@szeredi.hu>,
	"Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, Horst
 Birthelmer <hbirthelmer@ddn.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Matt Harvey <mharvey@jumptrading.com>,
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: [RFC PATCH v2 3/6] fuse: initial infrastructure for
 FUSE_LOOKUP_HANDLE support
Thread-Topic: [RFC PATCH v2 3/6] fuse: initial infrastructure for
 FUSE_LOOKUP_HANDLE support
Thread-Index: AQHca5L7ehX2+QNue0yPLWlKy7eWALUiuGEAgAA6wQCAAAF+AA==
Date: Mon, 15 Dec 2025 17:11:45 +0000
Message-ID: <8bae31f2-37fc-4a87-98c8-4aa966c812af@ddn.com>
References: <20251212181254.59365-1-luis@igalia.com>
 <20251212181254.59365-4-luis@igalia.com>
 <87f48f32-ddc4-4c57-98c1-75bc5e684390@ddn.com>
 <CAOQ4uxj_-_zbuCLdWuHQj4fx2sBOn04+-6F2WiC9SRdmcacsDA@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxj_-_zbuCLdWuHQj4fx2sBOn04+-6F2WiC9SRdmcacsDA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|DM4PR19MB8304:EE_
x-ms-office365-filtering-correlation-id: 444e3719-3594-4516-2633-08de3bfd064d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YXA1a0paam4zVUxJaThoQzVsZFlZMUVJV2Q2VUdYZjh4RithSkE1eGtFRVNl?=
 =?utf-8?B?dEZ2K1QzOGhpUklKUllOSzlVM21ZS0EyeWpiOCtwNWdLMDR2ekVONFNqT2dj?=
 =?utf-8?B?dkNFTVkzQjRlNWJKWmhKdlVMVDJYS1paREFGM1pocS8vS2dSMWJLUVRqcWQ0?=
 =?utf-8?B?VEJFNnArcU5RN2s0QVVGeXJCMmZHcURxY2hDa1A1OUtpdmlaSWtZUlZpNnE5?=
 =?utf-8?B?TW5rVjdmVkhBajd1aGpWd2xoZ01Id3NqMGp4Tmw1QVlVbTF5VmJJRllUaVpy?=
 =?utf-8?B?TFhNMmcxdDNERHhRdHNZTlJWbW1mTjZVWUNhS09FaXBhbkNRQkUrNGRhL0hz?=
 =?utf-8?B?RVdVTElKUGovblVDV2ZWRnoremVBN1VYcC85d0Z5VDAzOGE4L3VEMUxSODFX?=
 =?utf-8?B?V0ZkWVdjZkNwVk9nNyt0S3RSQVpRSkFwcnFZVEQ0c1UrQzB6a1UxWWpCV3Z2?=
 =?utf-8?B?dzZJa25KTVBvS3BUYXVGVUZwWm15NXBjbkN5bmNHK2N0MVYyRVRsUUNrcG9M?=
 =?utf-8?B?LzdYems4Y0pYT2ZBTmxlSDk0L1hwcFg1ZW41Wk9SaEppd0pHYzkvaHBTamlD?=
 =?utf-8?B?cjJvSTJJVmV6U3g3MldLOGFrUkdZaHFZMHFBRFpvUTI1UkNjT21zakRNQndR?=
 =?utf-8?B?QTZQQVVvQXZmMnh0U0lFbldncTlERGZ3QU9RUDlTNzR1MEVNQjRSMjBvVSt3?=
 =?utf-8?B?bjZWSXdVZ3d5U2ppZ3paU2l3ejY0SWw2UkdaVzQ0NGwrenN4OUJjTzlEcUly?=
 =?utf-8?B?V0J5VjBPeUJFSkllVjN1ZGRuWWNYQS9FZm1SYWNlalR1TTF4TVRCWnlxZmla?=
 =?utf-8?B?ZnFaendXQUEycEZ4M0tyWGFSZDc3VHJjWUs1Mkl4UXNMelYrVFNZRkp1a1NQ?=
 =?utf-8?B?VjV3WnkzN2hiS0lDeHY3TlpiV3VTeTd4UzRVdU03Z0RkUFpKakRFdU1CNVdh?=
 =?utf-8?B?eGxLK0JtckduT2ptbmxNYVhlRjdJOU5rZUZDWldDU3U5b2FJNWVCQ2xjVER6?=
 =?utf-8?B?bVNQSnJmcnNXL09ZRnkzdktqelc1THNUZFNxakYrcE1za3JYdEZET3p5V2hZ?=
 =?utf-8?B?bVRSUXhGTGVvZFMrTTJONzJBbXh3Y05UQ0JKQzNTc0RNTlRaRnR5bE1zaSty?=
 =?utf-8?B?bkdDejF2RXBwVFd0L3FUZ1JLQitiOEhJckR2WFZabUQ0TTdjOGF3SndkcEpp?=
 =?utf-8?B?cHAxQmxpWVcvdzRlbFZSNE9hMERrRjNmNnhucXBqU0JJRjUycE0wdG1MQWo5?=
 =?utf-8?B?U1VndnY1OUxIM0ZXb1lmRE9Pc0RYNE05ZHFwS1FueGhNK2RkUVlGR2tuN3RR?=
 =?utf-8?B?ZlBMRU5LcjhrYWdJOE1RNTIra2o4U3FGVExzTTl1dU52ckhYWFlJR0NMVUxZ?=
 =?utf-8?B?R1NJUWZRTGVqUEU4MXhKQ2J6N2YwY2JHZEVPL2o3czUydWdpaFNPQjdUTFk3?=
 =?utf-8?B?VE15T0FNV0NpUkZiSmxUVStPNHRnak05RjQ3amxJRmxSZVJWUVFNTkYySEtK?=
 =?utf-8?B?RDduVVFuNzZxWksxaElxNmtkUjZ5TlVSTUYvUXBIUEFhODVZcjczWU4yeFA2?=
 =?utf-8?B?TkNYdUxXcW1nZU12eklFQnBUM01lN1NValdPZjBmVHpIMVpucEJPeGREdGs4?=
 =?utf-8?B?ZHhvV0phdzhpWmRUMURXR1k2UVpuN0w0eWN4UHJDVnhaN0lWU2QxcDRmOVdx?=
 =?utf-8?B?b283UEc2MmpEMG1UUFhNM2ptZFRGMTkrT1IyKzdXT2JWY0pva2dCQjB6RnNl?=
 =?utf-8?B?VEF4RFBpcEFLaHFTaUxtbU9Pa1J0VmlmQy9PdDI4UE1MWDBESExQTFlnRFpm?=
 =?utf-8?B?bXA5VE5Zak9FeTdNb2x2dE5jRmYvd0xDajRKZlNtSjdGR3U2TEVaVUpYSkJ3?=
 =?utf-8?B?dldiV3BLaXBaR0RVMXNLTG9ZWEZmZEROV1NKRGFWWFVpcUczbG1YWWtSbkhj?=
 =?utf-8?B?bi9Pc0s3RHVHWElOQkNWVjlOTFR4dzZpTnRYWm1UdXd3UTNFQUp6enBvRmtW?=
 =?utf-8?B?ZVF6V2NqbHpub2JTb1hQcWVzQk9tdENtdTZrN2h6NXJ6WnVJcG1mWXd3T09N?=
 =?utf-8?Q?pPpXk+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZHVSenVlV3NMOVRkK1dBejdHRFlmdXF2d3VTK2d1b0RRUVBsVFBtcTlIWWpF?=
 =?utf-8?B?VHkxTjVldFFCTHQ3ekkycHFmOExHUGxDWWRESU9SL3RhYlVvZWNJZnJZSE83?=
 =?utf-8?B?N3htMXJxQlpSR1JvS0dOamtORXpnT3FMQ1d0c1VIUS96eDZkbEZlcEVUNHJD?=
 =?utf-8?B?Z1Y1RTlnc2VwaERQM1puUi8xQ0tWL0NVamVzN3d0VHU2QjZpNUZuR0RaaTNS?=
 =?utf-8?B?Z1U1SWVRQk55eUdEemFvaSt0Q2pwcW1aak9WZ1JnT2pCRHNFbHFDc0hVMHRV?=
 =?utf-8?B?S0l0VXhaY3FhQ0R4ZE90ektZOGE2R01teTNIeDhhNXpLZE9PZHBGRWRrSFpI?=
 =?utf-8?B?YzRRM202WWh0RlJpWW9aOTRxTzNTcXdHa1BOczlkbFcxWUNxM0ZhSkxiZlN5?=
 =?utf-8?B?WXRLUTVxSkFZNnpXcjRNZEtibnkxYXhQQ2JVbHNlN0ZsR2ZKRVEvaTB2cUts?=
 =?utf-8?B?Y0kyUCtTUWF6ZVF3T3BjZ1ZlV1U4NlQ0V2kzY0IzZDZ3cC9BdGxDa0tVb1d6?=
 =?utf-8?B?R3VWYlZSOVppWXM2bHJKVFYyS1dIUVl5Rkpuc0t0Rk5pYVFPZzVVV2V3OTFZ?=
 =?utf-8?B?N0pTRVhIN3oxT1AyNGJsU3c1a2pEQVQwV09NR1ZlQUJKTnJWN2tsb0w3V3ZP?=
 =?utf-8?B?ZHhFWVEvNTdyWjlSaFV4MkIzcjFyTmNnTndRRFArZ1ZDUkRldWladHlwUUt6?=
 =?utf-8?B?c1BWVHdrN3VkODdickhCeHB3MnE5bnNuSzNzbFZBOW5JdkxQdUdUMkdLWmVP?=
 =?utf-8?B?OUxUd2NKaW1rVjNvbHJDV1g0cisxcE1Ya3hTUW4wL3QwR1RFd1F6aHBHb1Bu?=
 =?utf-8?B?WlllZkNRRXZSMWswY1VzQ201a3N5K0ZWMU45aUtPRnJ4UU9ZRUVjVkN0Mk5K?=
 =?utf-8?B?czU5ZE8vdTViU205U2V6UlpPOU1TTFZib0oyRkVjbnVzUlVXYUQ3OEJKVGs1?=
 =?utf-8?B?OHlZQ0ZsWkN1djY1dm50RnBNTGVxa2lMMkpxcHQ3dXpmRUNnMWo2dmlDY0cw?=
 =?utf-8?B?YVo4NWhCK1RFUXVKbUVJUFBBWTc2WjU2amN4cFVhTk9zWVU3UGRxTjZlVWsy?=
 =?utf-8?B?MmxJeWNMNUNjMVBGL2g2ckllOXk5eEN1MjRTTGtrMEFOb2xPZEVobkxicWtQ?=
 =?utf-8?B?TlFYMEFGWVc2M1lHVTdzaDJ3S3RENmd2dXpiM1RWdVVxL3VTMkdBVy9rMkZB?=
 =?utf-8?B?Y21CeGsrWXBvcitzdUJMWmd5WGhtYUx3NmVHbDhKZzNvK3FkV05VamUwd2RM?=
 =?utf-8?B?TVg3RGFweUNvVGR2c3BMS3dJSFAvT2tDelBUcWFiRlRsQld1alBiVVF2RjNL?=
 =?utf-8?B?WWpLcXZQOTIrWExKczVxdnE2WDVWMWQ3dkFjRGJYUk5JN0VkRlRWOUxERE1q?=
 =?utf-8?B?WXFBa1FLSzlVOXBLb3h4UXl1MlpmUFJ0amdCSjFpZE5GRWxiZjFYTU9Rd0hB?=
 =?utf-8?B?cDVvQkNreVBaTFhTWGVnNnFEcytmRVFWNkRwVEFya09xZi9ML1JoSXZVcFJM?=
 =?utf-8?B?TXVZT2RXRTczMU5WSEFDQmFOMmQ2cmhlalR3RTkzeE1pMVRGZ0tNaEgzUUlw?=
 =?utf-8?B?MmdUUEMrRUxjK3VXTlNWd1luOUcyV1lxMjdlcEpXakU5MjEwbFQzUC9ZcGx4?=
 =?utf-8?B?QU1IVUpEa0Y3Qkhuc0RDeUFXbkpvclZmaTJKTStxKzNqRGVycHkvbUl1dzVi?=
 =?utf-8?B?TDJuZ1BLbDVaODhvU3o5TTh2bFhwd0lJRGRJRS83d1RTTDMzOWk4K3Z6TWhU?=
 =?utf-8?B?SXFNbm5CN0RrRzJUTUp3STFTbnBoYTZMWU90UHNSTGM3dG50dFdXY1U0cGpt?=
 =?utf-8?B?TEZTRndmQmJjcHJ1eW56SG5yd25xVWVEVFdHdWNmdUxnclViZ2ZMc2NSaCsv?=
 =?utf-8?B?QWZTNDNtaWxxbFZqQ2dxN0xtejFFb2F0WXBvTytwcm90NFV4Wkk1SU85U0ZV?=
 =?utf-8?B?NmNCNU9Pa2Q0REN4TkpjNUFiOGI3VndidlJjZDU0M2RjNHcxOGEvampUVEt4?=
 =?utf-8?B?cmt4QXVZcXpKOHJXR01YMXNyUzk1WUVtM1dodGxQZHY3bGp5OWdRZ2oxbUFX?=
 =?utf-8?B?WUFqTS9pTXZDSDE5RnNOdWZ6SHc4SWdYV01QRVZlb2hiQUxHU29UMUFVcWlm?=
 =?utf-8?Q?Xi60=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28E932DC5C85EC4F888BCF6D238BACF1@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	38EXylPPt3Uard49GJ+8FZ6DJb1m+W+E27SKj5dNgzNFkyLl6N5MLeVCD11Smqzc9IKWOISmvs3Xi53apwHnkqXaixfyTXrMOAKa8ZFwrkjV40jVpNsbepSkfNYG5ZTqLqhvO0KHwdfvVnv60iYTrOsFl4nHYj8TV+g0Tmf04n7ZqFot02g4szJ1xts8fUShxj4kGvTKR1MQ1zOwtKs4Se7MYDL6LjcNU2tokd5NR13B0N2Ydqv7CZnBgFyn1G73906WrTf98q5vxWvtxHBmqgRBMAR+sv/8WNZNGtD4K8lfiZoIimyT1sPzLK5yj0akaPcHdaKu9zBwxx3GvkHXpM7Zx8NqbbChoK1LQN7NFk/Yq+mu4ROcCsUxtpXR/yI5wReyG8sGuNEb46dH5W9ZdkMJecQmLc6t9Lg4UN59BxRDOOkSR47gcZdJQAstXzbn9KcPm6GhKR+ATLoFHrApzPd4+AaxMOF/VqcUf+j1WlcL3YFIa9kN5CbRWZ/IMhgT8HFSYNmbBdVHZPgiC2kiVNKYRC2izjEQquZxQg2SmZ9vvod+NKZy3Fd9qAYL9DxYdn0wKZK/h/ZuInk/sijbNS2NtMQddKEIMK1YeCo8VwpKCWmQlyG34FJ2xAoCEdFo4QJT9sjoyeqBRJKPKxk93A==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 444e3719-3594-4516-2633-08de3bfd064d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 17:11:45.1314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r0o3Siwitpr940D53lEjWlj3a6ze45cnjsud4iNGqpojbn+1RDi0vB21ocn2fxpRCQQ8pbKWIVRZ+O5N6d22Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB8304
X-BESS-ID: 1765818707-111082-7293-10549-1
X-BESS-VER: 2019.1_20251211.2257
X-BESS-Apparent-Source-IP: 40.107.201.129
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkZmJhZAVgZQ0NgoMdUoxSjRzC
	LV3DLZKDEp0cQi1dLUINUyOc0kOSVFqTYWAE6NP0lBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.269685 [from 
	cloudscan12-249.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gMTIvMTUvMjUgMTg6MDYsIEFtaXIgR29sZHN0ZWluIHdyb3RlOg0KPiBPbiBNb24sIERlYyAx
NSwgMjAyNSBhdCAyOjM24oCvUE0gQmVybmQgU2NodWJlcnQgPGJzY2h1YmVydEBkZG4uY29tPiB3
cm90ZToNCj4+DQo+PiBIaSBMdWlzLA0KPj4NCj4+IEknbSByZWFsbHkgc29ycnkgZm9yIGxhdGUg
cmV2aWV3Lg0KPj4NCj4+IE9uIDEyLzEyLzI1IDE5OjEyLCBMdWlzIEhlbnJpcXVlcyB3cm90ZToN
Cj4+PiBUaGlzIHBhdGNoIGFkZHMgdGhlIGluaXRpYWwgaW5mcmFzdHJ1Y3R1cmUgdG8gaW1wbGVt
ZW50IHRoZSBMT09LVVBfSEFORExFDQo+Pj4gb3BlcmF0aW9uLiAgSXQgc2ltcGx5IGRlZmluZXMg
dGhlIG5ldyBvcGVyYXRpb24gYW5kIHRoZSBleHRyYSBmdXNlX2luaXRfb3V0DQo+Pj4gZmllbGQg
dG8gc2V0IHRoZSBtYXhpbXVtIGhhbmRsZSBzaXplLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTog
THVpcyBIZW5yaXF1ZXMgPGx1aXNAaWdhbGlhLmNvbT4NCj4+PiAtLS0NCj4+PiAgICBmcy9mdXNl
L2Z1c2VfaS5oICAgICAgICAgIHwgNCArKysrDQo+Pj4gICAgZnMvZnVzZS9pbm9kZS5jICAgICAg
ICAgICB8IDkgKysrKysrKystDQo+Pj4gICAgaW5jbHVkZS91YXBpL2xpbnV4L2Z1c2UuaCB8IDgg
KysrKysrKy0NCj4+PiAgICAzIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZnMvZnVzZS9mdXNlX2kuaCBiL2ZzL2Z1
c2UvZnVzZV9pLmgNCj4+PiBpbmRleCAxNzkyZWU2ZjVkYTYuLmZhZDA1ZmFlN2U1NCAxMDA2NDQN
Cj4+PiAtLS0gYS9mcy9mdXNlL2Z1c2VfaS5oDQo+Pj4gKysrIGIvZnMvZnVzZS9mdXNlX2kuaA0K
Pj4+IEBAIC05MDksNiArOTA5LDEwIEBAIHN0cnVjdCBmdXNlX2Nvbm4gew0KPj4+ICAgICAgICAv
KiBJcyBzeW5jaHJvbm91cyBGVVNFX0lOSVQgYWxsb3dlZD8gKi8NCj4+PiAgICAgICAgdW5zaWdu
ZWQgaW50IHN5bmNfaW5pdDoxOw0KPj4+DQo+Pj4gKyAgICAgLyoqIElzIExPT0tVUF9IQU5ETEUg
aW1wbGVtZW50ZWQgYnkgZnM/ICovDQo+Pj4gKyAgICAgdW5zaWduZWQgaW50IGxvb2t1cF9oYW5k
bGU6MTsNCj4+PiArICAgICB1bnNpZ25lZCBpbnQgbWF4X2hhbmRsZV9zejsNCj4+PiArDQo+Pj4g
ICAgICAgIC8qIFVzZSBpb191cmluZyBmb3IgY29tbXVuaWNhdGlvbiAqLw0KPj4+ICAgICAgICB1
bnNpZ25lZCBpbnQgaW9fdXJpbmc7DQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZnMvZnVzZS9pbm9k
ZS5jIGIvZnMvZnVzZS9pbm9kZS5jDQo+Pj4gaW5kZXggZWY2MzMwMGM2MzRmLi5iYzg0ZTdlZDFl
M2QgMTAwNjQ0DQo+Pj4gLS0tIGEvZnMvZnVzZS9pbm9kZS5jDQo+Pj4gKysrIGIvZnMvZnVzZS9p
bm9kZS5jDQo+Pj4gQEAgLTE0NjUsNiArMTQ2NSwxMyBAQCBzdGF0aWMgdm9pZCBwcm9jZXNzX2lu
aXRfcmVwbHkoc3RydWN0IGZ1c2VfbW91bnQgKmZtLCBzdHJ1Y3QgZnVzZV9hcmdzICphcmdzLA0K
Pj4+DQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICBpZiAoZmxhZ3MgJiBGVVNFX1JFUVVFU1Rf
VElNRU9VVCkNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGltZW91dCA9IGFy
Zy0+cmVxdWVzdF90aW1lb3V0Ow0KPj4+ICsNCj4+PiArICAgICAgICAgICAgICAgICAgICAgaWYg
KChmbGFncyAmIEZVU0VfSEFTX0xPT0tVUF9IQU5ETEUpICYmDQo+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAoYXJnLT5tYXhfaGFuZGxlX3N6ID4gMCkgJiYNCj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgIChhcmctPm1heF9oYW5kbGVfc3ogPD0gRlVTRV9NQVhfSEFORExFX1NaKSkg
ew0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZjLT5sb29rdXBfaGFuZGxlID0g
MTsNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmYy0+bWF4X2hhbmRsZV9zeiA9
IGFyZy0+bWF4X2hhbmRsZV9zejsNCj4+DQo+PiBJIGRvbid0IGhhdmUgYSBzdHJvbmcgb3Bpbmlv
biBvbiBpdCwgbWF5YmUNCj4+DQo+PiBpZiAoZmxhZ3MgJiBGVVNFX0hBU19MT09LVVBfSEFORExF
KSB7DQo+PiAgICAgICAgICBpZiAoIWFyZy0+bWF4X2hhbmRsZV9zeiB8fCBhcmctPm1heF9oYW5k
bGVfc3ogPiBGVVNFX01BWF9IQU5ETEVfU1opIHsNCj4+ICAgICAgICAgICAgICAgICAgcHJfaW5m
b19yYXRlbGltaXRlZCgiSW52YWxpZCBmdXNlIGhhbmRsZSBzaXplICVkXG4sIGFyZy0+bWF4X2hh
bmRsZV9zeikNCj4+ICAgICAgICAgIH0gZWxzZSB7DQo+PiAgICAgICAgICAgICAgICAgIGZjLT5s
b29rdXBfaGFuZGxlID0gMTsNCj4+ICAgICAgICAgICAgICAgICAgZmMtPm1heF9oYW5kbGVfc3og
PSBhcmctPm1heF9oYW5kbGVfc3o7DQo+IA0KPiBXaHkgZG8gd2UgbmVlZCBib3RoPw0KPiBUaGlz
IHNlZW1zIHJlZHVuZGFudC4NCj4gZmMtPm1heF9oYW5kbGVfc3ogIT0gMCBpcyBlcXVpdmFsZW50
IHRvIGZjLT5sb29rdXBfaGFuZGxlDQo+IGlzbnQgaXQ/DQoNCkknbSBwZXJzb25hbGx5IGFsd2F5
cyB3b3JyaWVkIHRoYXQgc29tZSBmdXNlIHNlcnZlciBpbXBsZW1lbnRhdGlvbnMganVzdA0KZG9u
J3QgemVybyB0aGUgZW50aXJlIGJ1ZmZlci4gSS5lLiBhcmVhcyB0aGV5IGRvbid0IGtub3cgYWJv
dXQuDQpJZiBhbGwgc2VydmVycyBhcmUgZ3VhcmFudGVlZCB0byBkbyB0aGF0IHRoZSBmbGFnIHdv
dWxkIG5vdCBiZSBuZWVkZWQuDQoNClRoYW5rcywNCkJlcm5kDQo=

