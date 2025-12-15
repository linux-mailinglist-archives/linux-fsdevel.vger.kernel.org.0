Return-Path: <linux-fsdevel+bounces-71335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 944A0CBE225
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 14:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83FB2305BC44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 13:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD32315D27;
	Mon, 15 Dec 2025 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="Fxn+3rKB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A9B314A9E;
	Mon, 15 Dec 2025 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765805795; cv=fail; b=PpgBvZuu2rZ8ht+g/Wvy9BYX0vThjxpufiTPas2WFVv8UkRQmjn3sxDPklZ/080sw0Qh1Bl3wVHSg19n0kBZ8ZXkod2V4fuuKQUJEqxKPxIUpMX69uhPWhhnqPdk9LjGnQrWL9AOEXR+H6gjtFQDZvnAOhniw8zuRPj6ojPdC4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765805795; c=relaxed/simple;
	bh=3eSj28OyaxJFG0e2pdtIDs0BknIpIZnNMByKx7M7v1Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aguwUxpLN688cnEzMJBQe25NiK/esM3xP8pmrfJAVa0Y48yXdhrQlLconlA9pUl/XGxhaeKgc9iqvqbhdH2P584wGeevueh40ZeK8JIRG7CURGS5xzc1BYAIJy/Pf/ph71IUM6Yfr6Eak1FH3v8bJlZsssMrzlAktRh1GeTdJ1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=Fxn+3rKB; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020094.outbound.protection.outlook.com [52.101.193.94]) by mx-outbound12-3.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 15 Dec 2025 13:36:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/Nd6YptsaK4reHFVOpCRPP9D9P+0balXrC5lcX5vMrGlnA/sBHogmzwTCDRnAf08BGr8JlRApMM25aaozts+jBYC5oFNi9Ycz0xQKoIX3eqw+2AHF0YKlSzlly3uRXA3zZym4UqlyJNsfmA6dpibDM0YFNwjpqwXxmfaM7d+bL327hQUXXUsOIxveRnpGLST39+ipwZ8FS1YtWbjbA71HwhFX+3T0AZDRSS171Y1dliKAYERVNJ5Y/mZQR7r5KCvTguwsC4/DMy7zl8gXoJOiK12sfY7ibpBoYR4iOgfYrFlzvgheLlYbnBsEo/XWrNTR8U69ucvCccsRs6xHZ27A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eSj28OyaxJFG0e2pdtIDs0BknIpIZnNMByKx7M7v1Y=;
 b=kTkERFaATt4kHxPVjGoVtOjR4s5tTptgEgMj6304LoSImaDFBjkI4Bx5mx00FuQuUzUdZCPWXiXUhbK36zttnVmeyHqLH7UibxTAhM+EtL6fRIyKMcviCVu4t0vbXzvFRp1A0+ehzjYuCtVo4r6snSW+DycWJSlZgU8h2ngpYf4U4Z1RCBpIzD+zBCFcA3FK/eRRRHLNUQrHasgvkeXV1+JggKqAj4YuWQJVUdtLzDzE0ShPEUqQMbBF425uRtkkyDDgJQJwAWR20qmnlb1PYFlcelduTeSGjzfQGe/dmwmxLL0k6ou1o5JopK2e4YyM1/7pkiLgao24y0gg06skPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eSj28OyaxJFG0e2pdtIDs0BknIpIZnNMByKx7M7v1Y=;
 b=Fxn+3rKBDp3rpr/8XYOkgklIuFsBL/u98zIT958fucdYAF9NYfrN+fcXcWr6BtUVHrD7ybIurFZUaJokZgVhVWogcizPEC/CWtQPZxm2ohRBq94x392FJNT9bHfhjn3l17+zJ1jzmRhxvP44N3ta0OYz9b4AMOvqjUZNPBrOUCI=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by IA1PR19MB6449.namprd19.prod.outlook.com (2603:10b6:208:38b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 13:36:07 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%5]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 13:36:06 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Luis Henriques <luis@igalia.com>, Miklos Szeredi <miklos@szeredi.hu>
CC: Amir Goldstein <amir73il@gmail.com>, "Darrick J. Wong"
	<djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, Horst Birthelmer
	<hbirthelmer@ddn.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Matt Harvey <mharvey@jumptrading.com>,
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: [RFC PATCH v2 3/6] fuse: initial infrastructure for
 FUSE_LOOKUP_HANDLE support
Thread-Topic: [RFC PATCH v2 3/6] fuse: initial infrastructure for
 FUSE_LOOKUP_HANDLE support
Thread-Index: AQHca5L7ehX2+QNue0yPLWlKy7eWALUiuGEA
Date: Mon, 15 Dec 2025 13:36:06 +0000
Message-ID: <87f48f32-ddc4-4c57-98c1-75bc5e684390@ddn.com>
References: <20251212181254.59365-1-luis@igalia.com>
 <20251212181254.59365-4-luis@igalia.com>
In-Reply-To: <20251212181254.59365-4-luis@igalia.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|IA1PR19MB6449:EE_
x-ms-office365-filtering-correlation-id: ccea1fe3-0308-40d2-cbd5-08de3bdee653
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MHloU0dJSGJ3ZUhQNnJ3NkExRGF3TWpXTVJSOFJWb09KNE15V1VjV2tqczEr?=
 =?utf-8?B?aUJUUDQyY2hLVis0cTQzdVI0SHZLbGhnR0t3YTAxNmpRZ3BDK0JEaGtYaW02?=
 =?utf-8?B?QXh2MGoyNEM2dngvOXVkdDh3MFI4OTJnMjUwQmV1MUkxQ0tiZ1owSkNGVU00?=
 =?utf-8?B?RCtQd29OY1ppeGhvOG15QzVPT3M3Tmd3WXhreldIRmxwMWtPQTFlOFF2WHFt?=
 =?utf-8?B?dSs4M25XZFpuTHk3MkhDNFVpcEUrYU9UYmRRRjlaeWo4cDM3VlEzSzBEZEtC?=
 =?utf-8?B?ZExkU0hOUkFwbU1iUE01WkpybTdLWDFUOW9uOHNHMHMrVU5DRGkybGFaNHdV?=
 =?utf-8?B?T1VYVjduUFFyWHhZOHFGSGttYmJ4MVJkb2ZiRE9PWWx2ZE5jUTRIOVlWelV6?=
 =?utf-8?B?T1YwaTdMa2M2cFRQSTdqbUlSV1pRTU9ETTZ5ZTcrSUxuaDVuRHE1REV4QzB4?=
 =?utf-8?B?VHg2RGJ3d092dVpGMU1oQjJZTlN1Vkp1SDdSakpUSmJPWUZFL1liNEZDVFZI?=
 =?utf-8?B?SkttaVNHMXRNTUp0YXNUU1h0OVpFdGtvUHdJN2FwVndNdUhlTjRZZko5SEZV?=
 =?utf-8?B?cG5Qd0hneHB1RXJJSUp0SlBnQjdlNDcvODJPRTIyNjhJUGVmMU9nZnlXSFl3?=
 =?utf-8?B?b1d4dWR5aWZndDZhR2xOSUJuRnhpaDFiYzlJTkRnV1o4ZXVBU2MvS1lKWVps?=
 =?utf-8?B?UEZZd2JmUVpLRFh3Y2hUTlU5TTdxTHZrbkhMNm9jVUlwbXA3bk9SRFFSc2d2?=
 =?utf-8?B?NkQyK1dMZGppM1gvVXM5a0prNHNJOWxHYVBLNWlOZEFwVGdOZ3BqTStnUXky?=
 =?utf-8?B?cnYvUDJxNHRLLzBUbGdGV1NjNHVVU3UvVWdDMlQ0TzFwSytHdjMzSmIzOUlN?=
 =?utf-8?B?SW1FbTNoSFJTbjZqdkJ0SkRGaDlLMExLdGVxaEJJQ0Q4N0Z4Tm84cVlqcGxi?=
 =?utf-8?B?NXJvRWtNcUJZczVHOUhOdVN4eVdsV3pJRVJ5QkVDUlE2b0JxZWc3VVNIRUkz?=
 =?utf-8?B?L3RFV0xEaUY2ZzJaMExXMy9IdXhEaE5XdnMxMmdvdDJvblRXOE1ROHhiUFNI?=
 =?utf-8?B?ZHRoTk5RK1FCVnp4NVZUS0JhQ2hOYVlUTDZWN2lHdnpzci9OajB3Nmx1TFlJ?=
 =?utf-8?B?cXhFTVZLdnh3ZktGZ2Y1cTVNeVYwajdGZkt6UlRTWTNYQnZaclJzdnZ4akY0?=
 =?utf-8?B?bXBtMGVzNHl5TkllSC8wdnJFTVBRMGkralhicTZDUVVSc2xnZEtxakpCZXhH?=
 =?utf-8?B?ZC9IeWJNNVBTdnV1aDhmZ1BmS0UzYnhEeEMyUjRCWEhzS2NQOVh0WlRsdzBX?=
 =?utf-8?B?N09tNHBuUFEvQWo5OFF3VC9Ibmh2VFc5YUJsYmxvYzF2MlpMMU9mK0YrdzVW?=
 =?utf-8?B?T2pXUWN2M0FiSk8rZDdHaWpiRTF6S29LMGJpRTJ3QU1oVm92S2dJT1JLbjNG?=
 =?utf-8?B?dEFXVjljZ1hzYUZXR1ZZcHpLaGFGdFdLdERBSkdHdEZPc1J6dWRzazgyemRq?=
 =?utf-8?B?SWpZVXNia29vQW5jUGhSZjY5U0lhWGtSU2JBUFNyUFpab0xYRkM3U0FqZUdl?=
 =?utf-8?B?OXhyMThwOW1tUVJkcCtXeXRuS0E4YzI4b29qKytNYm5HVXhDbFNYZ2g2N1Z1?=
 =?utf-8?B?d3E2bTdkb2FmOHZmT25uc0Jub2pYSWRPakZua3hZTEh4ZzFjSWdXR1ZWTVRn?=
 =?utf-8?B?Qm1tR0NwbjNFK3FHWFBGLzRma3hlV2ZPSndVZ1c4U1F6bUU5NTdNYTB5TGRI?=
 =?utf-8?B?M1ZCcjBhZGhpRS9Hdk82b2JyWGNuQmU1Y2ZCaUNIM3JhbHVOWTFZdVBiSDk5?=
 =?utf-8?B?MnIvTFlRNS9xaXVKK3ZyWitJemlNY0JVeXZWanVKSTZ1M0ZDVmhKekRFZXB3?=
 =?utf-8?B?d1JTTVBUNFJCbitnWk0xZWtNV0xZVjZIeWYveklGelI3UFZEbkNZNFExK21Z?=
 =?utf-8?B?N1g5YWF5OW5pa2VUeG5rYUswVTBsdUgwTVVXeE1rUTI4NkRaRTFwd05JZ0cv?=
 =?utf-8?B?d292OXpiOHdKM0NISHNvbGN5UWNmaVBEeHNCelJKTjBPVC93WXZKVGc2Y3V3?=
 =?utf-8?Q?h28qYM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXU4VTgxZ1YxVk1Ka2VzV1FuTTgxUk50K0xwSGl4U0pDYU4wR3ZLdTUzcmtl?=
 =?utf-8?B?a0szZHVEUEdKOFZGZkRnSFNyb0h2OXN6R21jWUR0bGFTZEV0UmlUQUV2V3J3?=
 =?utf-8?B?cjIybkhXaTlDNVptckg0RUFScERpZUt6TnltRVZJZ0RhdGJPSjdGemZEMlZy?=
 =?utf-8?B?eUJjYXlUYkRzVlhKMEJqZHNiWHF4Ny83UFVXOVU5dHFSLzF1OUpUK2xBcUFo?=
 =?utf-8?B?VTBOQlUxYWl6RENtZ1F4TTNvRS9rQklmSGRoTFFkUHNUWisvaFZ2Y1lKQmsz?=
 =?utf-8?B?V1BnWHltcFpNWHFuMHExbGtGazZZaTJ3M3NLbjA4QUZCVmJPdDRONEZNRUp4?=
 =?utf-8?B?VnlnVXI5S0NYWXphY3Z2WjJONTlJcDNzZFZYNlFWUkF2TjVsTlExb3R4ZVBV?=
 =?utf-8?B?R1dPc2Zkd0VoSnV2UExIOUJXWXhOZjVWUmswcndjb3ZiK2U0OEdJS1VhYTl1?=
 =?utf-8?B?S0dqdHQxTG5vZWtGd1JVUllCK0ZnK1RLNmVIUjBSbm5nWHNhR2dnL0pPcGhJ?=
 =?utf-8?B?UEZJK1kxRlo5UVFFYXBicklwb1JXQmtOcXR1bTBGMk1kc045YWRQU3RISEQy?=
 =?utf-8?B?KzhFOUp2UXZZU2gvSjVTMkNEb1lDUFpjbFd0aVhxS0pFR0cvMDYxakhaUUE0?=
 =?utf-8?B?SzlYTTFiOVpsTWdPSTBQN05uT1MwZGNNTWlSVDkwRHp3REQzbjlMOSswUXpv?=
 =?utf-8?B?MVJuait3K0RlTG8yb2p0Y2M2Ulc2eHkvWnZoSHh4VXY0cVhHOEN6QXk2M2h1?=
 =?utf-8?B?alA3bXB3Z0pOZmtzanNqL2pvVkVRbnlJMWNZYnZ0elhVZld0K3BKS051OFRN?=
 =?utf-8?B?NXRuem4xYnovckFOWE1BN0t5ZEdva0g1OVkrVHh5TjNSVCs5MERCZlFVTDZh?=
 =?utf-8?B?KzdpRURiVll0WVo3RnhqWnZyb1pTT3VSM2NxZ0MyVU1TWGNaeG9CSmhHUDgy?=
 =?utf-8?B?UVhrSkMwREVXTmNpOTl4Yy8zWVpENi9acndCNGpqOXdKYkp6bUJRNDlYT25a?=
 =?utf-8?B?dHREci9Vd21CV2pMUlNTSTEzcVM5WDh2NjhlU21wQnNyNGhhZVc1SnpZVDFD?=
 =?utf-8?B?SElwU2YydTRTcE1YMXBkVThxcFlHdGl4RjVva21CRWtuZjdUUEZkS1JIRklu?=
 =?utf-8?B?T2tNcGtXb1F3Y2xhQXRla01ieVZMU0Y0ZE9KOU9PUzdSZmFMVGRqdFNpd05K?=
 =?utf-8?B?dFNPNkMwU1FpYStXT2NVZ0Vlc3ZYNmdmYVgvMXpiMHhKVElDSUFjRWNnRXNM?=
 =?utf-8?B?UnB3T2RVaklaMEFJbTh6blFlMVZwWURwcDFGY1Y2UW1mcU44WURWSkc3U3RJ?=
 =?utf-8?B?eDJqSURMZ3F0QjZhWmhZRlBacFdXQUZCREpZbXBFRXVEbS9uZFl0dTYyd0dU?=
 =?utf-8?B?Vm9CUVQ1QU5BanZOV0pFZ0ExTnRvTnk5RWxtL0tncUF5RFVrMEh6STlZdjR1?=
 =?utf-8?B?cTRYOXBtdmdMM0ZtbFd0VHdsaHpKUGFPRStheHkrbmRCcERuY1F5TFRpVUtV?=
 =?utf-8?B?MmowRGZYNkJhSU9ISTROWWxoL1BTcnJwTDFHeWdMcGhLRmJ4eUprd2drVUNi?=
 =?utf-8?B?K3VkNzdSdGV2dFoxOUE1K1ZWWXZqVmRhTzlMTWVpS1g2OW4wRjZUS3N5RVpt?=
 =?utf-8?B?bVA1bi9nRWgwRFZxNm5wd2FNL1BTTVdmbXpyZFFXVHM5Z0xvcmdnZnZNdlVw?=
 =?utf-8?B?NE1sMHdySU0vVTh0T3FLRzJjZEdsK20zaTNha1NPWWRtS1d6bUFSQ0lXS2I1?=
 =?utf-8?B?Q0RhSWpUUlYzMXJSbkFSTE1xaVhwZzUyT1F3Z20vSSszb0Z2Wks1dXZUc1Fi?=
 =?utf-8?B?UjVpZHc5bGVSd3g2T3YyakhyWkQwQTMwUlBvbGY5OHlzQ2dGTEdOTEhqTkFS?=
 =?utf-8?B?QUFLWTN5Y2dOWUZOY0x3UnJQZFk0VlFXWEFNUEhPOVJUTzJBd0t5Q2lFQWRK?=
 =?utf-8?B?RWNzdUJJUGJZZmNucVFFV1hmbld5d1NJd3I3Wld2cFU5Z1VGVDhXVkU4Tmpz?=
 =?utf-8?B?MjNBRVdJblR1eXhYYnBkb3RiWVZyY3VTbklwRCsxYUcwa0FOaHN4SEVKamxY?=
 =?utf-8?B?U044a1Q5ZzArY0thR2k3N2dtY3hYbW9xTXhpeTRBb0lkUnRkaDRMT3lSOWRz?=
 =?utf-8?Q?ARSE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2149FE3E975CB84BA3E0C4940B074E84@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wHltbNF5vo9ThhrjA7YXAe9LBdr7A5/ozpvzykTusP/LLWYhDqoC5A6ksfU30mYdv99WRl3NF9adn9RF1KqaHSc8s9800AoTZaS44lowUkqw2oCdx5W/deZrOPlreAhwaTEWWiquIH9rs/KjiVEx5/nJKCCx2YwP0SEQ5tQC8gErihDl6THK5fYN75tG3hTfYVJzvi2eUu+/CzOBWxcoixmU+RBo6dQuo2HfOzEP1EE3mYPi1nV6PHOF/+l+oIIWoOZdz5GFRybBY//YljSDMK9xfG5+jeD2h3rr52nMaYqmXO3XnXc6BRub+zwDsTA55DUBzaqPi6uyiVkvaSqQ3gWAFGwi+qOUqMzsF10GbTKSGxmjaBHH/7fFaeLBMzxxcQoXPUdBtWQzKuZ1tF8Trymw4vAQvYrAnFiROqx9lQLSif94FTRBJMdERKuINt3F7Dw5VbXtSx+5AJhNXZecWvLI8PxLooqqjVn6TBbTB+1WW4pBqWUMrfq0ezJQfn8QBcZxnthO3hTp5vZEUPMjjFAs6NT13mnu6tiD8XQufFAYQWPRgCW7nS5RyZoFKr8jdHHOQiQozElucZ24Tj/zq/the+8GONQfqWH4DcaPP80Inh4Mp0M/ALwQom2YcO11FjToWv5Nw74UzVtbo78mvQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccea1fe3-0308-40d2-cbd5-08de3bdee653
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 13:36:06.6159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JqvKD9ZF/MWLSUHsd0A8GV4SvoyeApj/AjKWiVSAMMT543t2I4DWCqqAiGb6KQW0aXidUjGrsgsMZcn3R/bWEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB6449
X-BESS-ID: 1765805770-103075-7729-2204-1
X-BESS-VER: 2019.1_20251211.2257
X-BESS-Apparent-Source-IP: 52.101.193.94
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsYWxiZAVgZQ0CDV2MIwycTSwN
	Ig0djSMiXN2NLIxCjF2CAtzTDFItlAqTYWALGsdQlBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.269681 [from 
	cloudscan8-208.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

SGkgTHVpcywNCg0KSSdtIHJlYWxseSBzb3JyeSBmb3IgbGF0ZSByZXZpZXcuDQoNCk9uIDEyLzEy
LzI1IDE5OjEyLCBMdWlzIEhlbnJpcXVlcyB3cm90ZToNCj4gVGhpcyBwYXRjaCBhZGRzIHRoZSBp
bml0aWFsIGluZnJhc3RydWN0dXJlIHRvIGltcGxlbWVudCB0aGUgTE9PS1VQX0hBTkRMRQ0KPiBv
cGVyYXRpb24uICBJdCBzaW1wbHkgZGVmaW5lcyB0aGUgbmV3IG9wZXJhdGlvbiBhbmQgdGhlIGV4
dHJhIGZ1c2VfaW5pdF9vdXQNCj4gZmllbGQgdG8gc2V0IHRoZSBtYXhpbXVtIGhhbmRsZSBzaXpl
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTHVpcyBIZW5yaXF1ZXMgPGx1aXNAaWdhbGlhLmNvbT4N
Cj4gLS0tDQo+ICAgZnMvZnVzZS9mdXNlX2kuaCAgICAgICAgICB8IDQgKysrKw0KPiAgIGZzL2Z1
c2UvaW5vZGUuYyAgICAgICAgICAgfCA5ICsrKysrKysrLQ0KPiAgIGluY2x1ZGUvdWFwaS9saW51
eC9mdXNlLmggfCA4ICsrKysrKystDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvZnVzZV9pLmgg
Yi9mcy9mdXNlL2Z1c2VfaS5oDQo+IGluZGV4IDE3OTJlZTZmNWRhNi4uZmFkMDVmYWU3ZTU0IDEw
MDY0NA0KPiAtLS0gYS9mcy9mdXNlL2Z1c2VfaS5oDQo+ICsrKyBiL2ZzL2Z1c2UvZnVzZV9pLmgN
Cj4gQEAgLTkwOSw2ICs5MDksMTAgQEAgc3RydWN0IGZ1c2VfY29ubiB7DQo+ICAgCS8qIElzIHN5
bmNocm9ub3VzIEZVU0VfSU5JVCBhbGxvd2VkPyAqLw0KPiAgIAl1bnNpZ25lZCBpbnQgc3luY19p
bml0OjE7DQo+ICAgDQo+ICsJLyoqIElzIExPT0tVUF9IQU5ETEUgaW1wbGVtZW50ZWQgYnkgZnM/
ICovDQo+ICsJdW5zaWduZWQgaW50IGxvb2t1cF9oYW5kbGU6MTsNCj4gKwl1bnNpZ25lZCBpbnQg
bWF4X2hhbmRsZV9zejsNCj4gKw0KPiAgIAkvKiBVc2UgaW9fdXJpbmcgZm9yIGNvbW11bmljYXRp
b24gKi8NCj4gICAJdW5zaWduZWQgaW50IGlvX3VyaW5nOw0KPiAgIA0KPiBkaWZmIC0tZ2l0IGEv
ZnMvZnVzZS9pbm9kZS5jIGIvZnMvZnVzZS9pbm9kZS5jDQo+IGluZGV4IGVmNjMzMDBjNjM0Zi4u
YmM4NGU3ZWQxZTNkIDEwMDY0NA0KPiAtLS0gYS9mcy9mdXNlL2lub2RlLmMNCj4gKysrIGIvZnMv
ZnVzZS9pbm9kZS5jDQo+IEBAIC0xNDY1LDYgKzE0NjUsMTMgQEAgc3RhdGljIHZvaWQgcHJvY2Vz
c19pbml0X3JlcGx5KHN0cnVjdCBmdXNlX21vdW50ICpmbSwgc3RydWN0IGZ1c2VfYXJncyAqYXJn
cywNCj4gICANCj4gICAJCQlpZiAoZmxhZ3MgJiBGVVNFX1JFUVVFU1RfVElNRU9VVCkNCj4gICAJ
CQkJdGltZW91dCA9IGFyZy0+cmVxdWVzdF90aW1lb3V0Ow0KPiArDQo+ICsJCQlpZiAoKGZsYWdz
ICYgRlVTRV9IQVNfTE9PS1VQX0hBTkRMRSkgJiYNCj4gKwkJCSAgICAoYXJnLT5tYXhfaGFuZGxl
X3N6ID4gMCkgJiYNCj4gKwkJCSAgICAoYXJnLT5tYXhfaGFuZGxlX3N6IDw9IEZVU0VfTUFYX0hB
TkRMRV9TWikpIHsNCj4gKwkJCQlmYy0+bG9va3VwX2hhbmRsZSA9IDE7DQo+ICsJCQkJZmMtPm1h
eF9oYW5kbGVfc3ogPSBhcmctPm1heF9oYW5kbGVfc3o7DQoNCkkgZG9uJ3QgaGF2ZSBhIHN0cm9u
ZyBvcGluaW9uIG9uIGl0LCBtYXliZQ0KDQppZiAoZmxhZ3MgJiBGVVNFX0hBU19MT09LVVBfSEFO
RExFKSB7DQoJaWYgKCFhcmctPm1heF9oYW5kbGVfc3ogfHwgYXJnLT5tYXhfaGFuZGxlX3N6ID4g
RlVTRV9NQVhfSEFORExFX1NaKSB7DQoJCXByX2luZm9fcmF0ZWxpbWl0ZWQoIkludmFsaWQgZnVz
ZSBoYW5kbGUgc2l6ZSAlZFxuLCBhcmctPm1heF9oYW5kbGVfc3opDQoJfSBlbHNlIHsNCgkJZmMt
Pmxvb2t1cF9oYW5kbGUgPSAxOw0KCQlmYy0+bWF4X2hhbmRsZV9zeiA9IGFyZy0+bWF4X2hhbmRs
ZV9zejsNCgl9DQp9DQoNCg0KSS5lLiBnaXZlIGRldmVsb3BlcnMgYSB3YXJuaW5nIHdoYXQgaXMg
d3Jvbmc/DQoNCg0KPiArCQkJfQ0KPiAgIAkJfSBlbHNlIHsNCj4gICAJCQlyYV9wYWdlcyA9IGZj
LT5tYXhfcmVhZCAvIFBBR0VfU0laRTsNCj4gICAJCQlmYy0+bm9fbG9jayA9IDE7DQo+IEBAIC0x
NTE1LDcgKzE1MjIsNyBAQCBzdGF0aWMgc3RydWN0IGZ1c2VfaW5pdF9hcmdzICpmdXNlX25ld19p
bml0KHN0cnVjdCBmdXNlX21vdW50ICpmbSkNCj4gICAJCUZVU0VfU0VDVVJJVFlfQ1RYIHwgRlVT
RV9DUkVBVEVfU1VQUF9HUk9VUCB8DQo+ICAgCQlGVVNFX0hBU19FWFBJUkVfT05MWSB8IEZVU0Vf
RElSRUNUX0lPX0FMTE9XX01NQVAgfA0KPiAgIAkJRlVTRV9OT19FWFBPUlRfU1VQUE9SVCB8IEZV
U0VfSEFTX1JFU0VORCB8IEZVU0VfQUxMT1dfSURNQVAgfA0KPiAtCQlGVVNFX1JFUVVFU1RfVElN
RU9VVDsNCj4gKwkJRlVTRV9SRVFVRVNUX1RJTUVPVVQgfCBGVVNFX0xPT0tVUF9IQU5ETEU7DQo+
ICAgI2lmZGVmIENPTkZJR19GVVNFX0RBWA0KPiAgIAlpZiAoZm0tPmZjLT5kYXgpDQo+ICAgCQlm
bGFncyB8PSBGVVNFX01BUF9BTElHTk1FTlQ7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkv
bGludXgvZnVzZS5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L2Z1c2UuaA0KPiBpbmRleCBjMTNlMWY5
YTJmMTIuLjRhY2Y3MWI0MDdjOSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L2Z1
c2UuaA0KPiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvZnVzZS5oDQoNCkkgZm9yZ2V0IHRvIGRv
IHRoYXQgYWxsIHRoZSB0aW1lIG15c2VsZiwgSSB0aGluayBpdCBzaG91bGQgYWxzbyBpbmNyZWFz
ZSB0aGUNCm1pbm9yIHZlcnNpb24gaGVyZSBhbmQgYWRkIGFkZCBhIGNvbW1lbnQgZm9yIGl0Lg0K
DQo+IEBAIC00OTUsNiArNDk1LDcgQEAgc3RydWN0IGZ1c2VfZmlsZV9sb2NrIHsNCj4gICAjZGVm
aW5lIEZVU0VfQUxMT1dfSURNQVAJKDFVTEwgPDwgNDApDQo+ICAgI2RlZmluZSBGVVNFX09WRVJf
SU9fVVJJTkcJKDFVTEwgPDwgNDEpDQo+ICAgI2RlZmluZSBGVVNFX1JFUVVFU1RfVElNRU9VVAko
MVVMTCA8PCA0MikNCj4gKyNkZWZpbmUgRlVTRV9IQVNfTE9PS1VQX0hBTkRMRQkoMVVMTCA8PCA0
MykNCj4gICANCj4gICAvKioNCj4gICAgKiBDVVNFIElOSVQgcmVxdWVzdC9yZXBseSBmbGFncw0K
PiBAQCAtNjYzLDYgKzY2NCw3IEBAIGVudW0gZnVzZV9vcGNvZGUgew0KPiAgIAlGVVNFX1RNUEZJ
TEUJCT0gNTEsDQo+ICAgCUZVU0VfU1RBVFgJCT0gNTIsDQo+ICAgCUZVU0VfQ09QWV9GSUxFX1JB
TkdFXzY0CT0gNTMsDQo+ICsJRlVTRV9MT09LVVBfSEFORExFCT0gNTQsDQo+ICAgDQo+ICAgCS8q
IENVU0Ugc3BlY2lmaWMgb3BlcmF0aW9ucyAqLw0KPiAgIAlDVVNFX0lOSVQJCT0gNDA5NiwNCj4g
QEAgLTkwOCw2ICs5MTAsOSBAQCBzdHJ1Y3QgZnVzZV9pbml0X2luIHsNCj4gICAJdWludDMyX3QJ
dW51c2VkWzExXTsNCj4gICB9Ow0KPiAgIA0KPiArLyogU2FtZSB2YWx1ZSBhcyBNQVhfSEFORExF
X1NaICovDQo+ICsjZGVmaW5lIEZVU0VfTUFYX0hBTkRMRV9TWiAxMjgNCj4gKw0KPiAgICNkZWZp
bmUgRlVTRV9DT01QQVRfSU5JVF9PVVRfU0laRSA4DQo+ICAgI2RlZmluZSBGVVNFX0NPTVBBVF8y
Ml9JTklUX09VVF9TSVpFIDI0DQo+ICAgDQo+IEBAIC05MjUsNyArOTMwLDggQEAgc3RydWN0IGZ1
c2VfaW5pdF9vdXQgew0KPiAgIAl1aW50MzJfdAlmbGFnczI7DQo+ICAgCXVpbnQzMl90CW1heF9z
dGFja19kZXB0aDsNCj4gICAJdWludDE2X3QJcmVxdWVzdF90aW1lb3V0Ow0KPiAtCXVpbnQxNl90
CXVudXNlZFsxMV07DQo+ICsJdWludDE2X3QJbWF4X2hhbmRsZV9zejsNCj4gKwl1aW50MTZfdAl1
bnVzZWRbMTBdOw0KPiAgIH07DQoNCk5vIHN0cm9uZyBvcGluaW9uIGVpdGhlciBhbmQganVzdCBn
aXZlbiB3ZSBhcmUgc2xvd2x5IHJ1bm5pbmcgb3V0IG9mDQphdmFpbGFibGUgc3BhY2UuIElmIHdl
IG5ldmVyIGV4cGVjdCB0byBuZWVkIG1vcmUgdGhhbiAyNTYgYnl0ZXMsDQptYXliZSB1aW50OF90
Pw0KDQoNCg0KVGhhbmtzLA0KQmVybmQNCg0K

