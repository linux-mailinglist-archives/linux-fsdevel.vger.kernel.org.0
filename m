Return-Path: <linux-fsdevel+bounces-58406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 087D4B2E6C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 22:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD185C7DA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 20:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B412D63EE;
	Wed, 20 Aug 2025 20:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B7pyeLjj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FBD275AF5;
	Wed, 20 Aug 2025 20:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755722544; cv=fail; b=U3se/gq60a2VJCyI6uRvgQD/o2k1kBmdJuF3CFpPY28SfaufKutq1GjErmA0qN651Jd4diCX6ZSMujb1MwywV2B8Xx2Tp4XucoYKj+KgO9s7i6njcF0nDnjxsHJMVpzSwiWRR3M0rSlfnUrU2I9eksnm+6P6ID9GS+O9y8n9rtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755722544; c=relaxed/simple;
	bh=4aWuJexVJwau/kk4m9zi/yc2fT7vseh3yc2xvgmc0FM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H4OfOwg7gkIbYQp7U0x1J4GiSve4dAac/k+RKssw71ybk8oSHONJg1S/zUp1ouDZFGbqIdeTVYIrW2lsQyk4HU4sX409+fF52TBC6EMYDn5dPGS3Q6m8XMLDcj0LM7zp/xi30aw3UzJjsAuCxLzk3ScrVbQFYXKTAxW7af69hbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B7pyeLjj; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uld3qTXWZf9woKlvJTL5TxW1u8qFrdlBNEvqLBn7nSv5v2s9fwpFfQ8QWIV8wfpa1OibtNQ9YAMCu3kVAfT3jM6WbX/eU1qG66M6ftCPxDSrIWs6iF9OjkkD9KXzQcyKr2gbE2qK1ebcP8laRk313q0XTwkpfvNNOrfS2V/zMYOxar0KxAvrOO74qi5ezRzMtAlkRSF62/qoI1rOS6ZtJ9Lna0qONzKy6RarFV7AzMep8L+/Igv0z49cdb4puTuIPCdWkh6QbTiDe+gwtEHy0ZQqw1VDqIetpvh9nvQtXnbLFg2asDRCe1+ARx3hOcv2rGMLvUvwM4+ZnyQ90qm+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1uKiivIEOLmGawGaDp4j+YQNA/CPbmHwlL/6Em/r1I=;
 b=A+UGhh8922kycQ6CCtkD4ienV+lGTd8PmQipxhfVkLZz176SEiuE+4vBx3yRIve9ITSm4X8GrwnvpPCexNg74RJILffRkkfu3ZXY8814woOnV1ZhH9UcdMiHwvjwvQdd+2EWx3IxYGtk8+ZQgdH6QRY8Ptr34kPnl02Kz3+7NfkTJ3+ZisXpDesqsDSNSwj9wsvZxLiLX4SnFQCdaCsH/FTEtfNsUOP3YbzHv+mq5k/2jeM1Z2PAkNjsxbyfUhZDS21Bhp+uyIMp+RJ5vgqsbUqd7Gu0nsLGkX7wDmjAxFDIHzoG1tJdwoXRjqzWhPVoZOWFTBRrTOMnn7i6MFfsRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1uKiivIEOLmGawGaDp4j+YQNA/CPbmHwlL/6Em/r1I=;
 b=B7pyeLjjJHHSzve1a5Zw4n1iLDmdCWTbX1TMVtftngTGmcnSFtunluh+etsitf4vlvlLWiqYRR8zpjXutGwY10Kn8DuWf34kC1zmJ3wMybi2nqcgovjo/bLRi4Zg3KrKauReuloCXrqfJLMDUj38ZlgnFjZyU2Q4FW9qEmzMmKDFaRM3dXUZf/lw1Bc7La2T3CiAvjfAEVXiuQoHDicefhsKNiYemo90gK7JTkVqS2d4xk8idI9Rm1qdEH0MqTTXtRWQpLojvj4zqMLNCGNDN32COXUcFwGQapyKpy1SBXtg8GnCz2rxzEKJre2H3KiLlWMfUqkfdbbcJyLvsH44cg==
Received: from BL1PR12MB5094.namprd12.prod.outlook.com (2603:10b6:208:312::18)
 by CY8PR12MB8242.namprd12.prod.outlook.com (2603:10b6:930:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Wed, 20 Aug
 2025 20:42:17 +0000
Received: from BL1PR12MB5094.namprd12.prod.outlook.com
 ([fe80::d9c:75e0:f129:1eb]) by BL1PR12MB5094.namprd12.prod.outlook.com
 ([fe80::d9c:75e0:f129:1eb%2]) with mapi id 15.20.9031.014; Wed, 20 Aug 2025
 20:42:17 +0000
From: Jim Harris <jiharris@nvidia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "stefanha@redhat.com"
	<stefanha@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Idan Zach
	<izach@nvidia.com>, Roman Spiegelman <rspiegelman@nvidia.com>, Ben Walker
	<benwalker@nvidia.com>, Oren Duer <oren@nvidia.com>
Subject: Re: Questions about FUSE_NOTIFY_INVAL_ENTRY
Thread-Topic: Questions about FUSE_NOTIFY_INVAL_ENTRY
Thread-Index: AQHcEWHgWIwFHGDQ0EazMQvH1t6jpLRrPYMAgADFeYA=
Date: Wed, 20 Aug 2025 20:42:17 +0000
Message-ID: <1E1F125C-8D8C-4F82-B6A9-973CDF64EC3D@nvidia.com>
References: <D5420EF2-6BA6-4789-A06A-D1105A3C33D4@nvidia.com>
 <CAJfpegvmhpyab2-kaud3VG47Tbjh0qG_o7G-3o6pV78M8O++tQ@mail.gmail.com>
In-Reply-To:
 <CAJfpegvmhpyab2-kaud3VG47Tbjh0qG_o7G-3o6pV78M8O++tQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5094:EE_|CY8PR12MB8242:EE_
x-ms-office365-filtering-correlation-id: 85e4deae-c490-4df4-fabd-08dde02a0da1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|4053099003;
x-microsoft-antispam-message-info:
 =?utf-8?B?QWFOQ29HQmlJb0M5QnJFVHRQUmtFOHdQZFJSWEhOb2VpQmZKNUpQazVSV0Y5?=
 =?utf-8?B?SmVUQVdVRGEwUVdnYWIvQ2NRN2FCaGhOSW5ndFZmNWl2bHlJWjhvanZzNFZZ?=
 =?utf-8?B?K0t5em4rbkVERjF6Znl5bW5WM3hGUkZ0ZXkzQytpY2tZTFZ3dUlLZ3EzZkcx?=
 =?utf-8?B?NHRRZWZuckJkc09kcTcrTnNYZUc3VzVJTUE1NXhvMFJ4WHJpSHVGaTNBSU04?=
 =?utf-8?B?b0o3N21MVmRVb2kwVFlVUE9WVy95MTdWQ0xYZzl6MmtYczdLaHIrQmk1U0M2?=
 =?utf-8?B?Q0xnWXNjVGt1bTVydTZ1MVRJclhwTkZXbUdndlRnand5K201MnNlMmNkWDRM?=
 =?utf-8?B?QTYydGJUcjhlcllZekY1NjNyOVo4OVNVeXlyZDB4S2h2Yjkra2RRMlRDbEVK?=
 =?utf-8?B?cjRLekxmWEtsS24vRVUyQ2RpMmxnR2JoZkwzMEU4U1ErWEZYcTJ5RXF1TVlL?=
 =?utf-8?B?cTVrVHNhTTREY0NqaHVCRHQzdHNTbUdCWHFvaXlhTWFpT00xT1REckVCbFgw?=
 =?utf-8?B?WXVsQjlBVnBLVVprVEhaZlVYVG1taTRUV2R2NTRJTWF2SWovdFpwd2ZXaUtL?=
 =?utf-8?B?OG5vUWZZUDgzdmxRdVR5QWxMdXlSY1gvZENCMUdrYVJ2RzA1VlFEczIzTkNx?=
 =?utf-8?B?c2dRQXQ0dDArY1VweGhLTWtIbzhzVUpVWjBFeEdWRGFhNnF3NEo2STQyOWRU?=
 =?utf-8?B?UDNDVU8zb3FkbjhxVDRua1pac05WMXl0SVVjMkRyWVErTUdudTU3SDB3b3Ez?=
 =?utf-8?B?ditsOUlhL1dpQmd4R2laRmNPQzU2VUtHVisxN0NPR2pRL2pKYS9WNlkrSmht?=
 =?utf-8?B?WlJUMjFOdnZ1WE1BTmRJRnhNYVJTTEJoQTNsRG5Oc1BmZ0xSR2VCQ2Q1Q2FZ?=
 =?utf-8?B?aVdKMzFSN0VJL2ZaUEJtbFZ1ekMyVXhlR1ZpSGpEWHdYNWtjd1B0Zzg2Tko0?=
 =?utf-8?B?Zk5yU0xMWGlsSVRFRjZxejh2ZWNYUkllUnBGc3d3S09pODlSdVpIZERKajRK?=
 =?utf-8?B?TlU3ZXYrK0pFdHNwT0ludTY0VFp2NWNDRllwT1BiTFlVR0NUR2Vzc1ZTSG1X?=
 =?utf-8?B?TEV3Y2lneVZsMkMxRFJ2YUgxM2ZQeCtFSWdhc1lhR2ZVUnNBa05WTGZqbUZE?=
 =?utf-8?B?SUd3OEdXRTh4amtQWDhEVjJBOE1aQXlOK2F1RThvc2d6LzNXazM4bEtpNUJK?=
 =?utf-8?B?SEVyZXJtOEJxTzd5TkFWRDkrbGhWeDZXR2lnR1NUQWR2bUcwYUlKYzRTZGpL?=
 =?utf-8?B?LzJWZnk4L1Fabi9KMnhVS3JTNWdGOFZMSUp3ZGxCYTNPU3o5SnQ0dlo5clVx?=
 =?utf-8?B?dGlyckZtdUpnekt3VnVnbEVvNDEwY1BWb3QyeXlhNXFxRnhyYklTZUFZM0JC?=
 =?utf-8?B?WFM5TmxZWE0yVFhRa2hKL25JblpJQTd2TE43Z2ZrMlQwZXBIZ2lydEI2cmZD?=
 =?utf-8?B?NnBJVWhnY0RTTEJnKzhqeXBrYlNVeFhxSDR0SWIrNzZoeGpTNGZrMVBaVzRV?=
 =?utf-8?B?a0xtMzRSMlpoem9BK0s3bS8xbWtxQjZReGZtT2pLQmFRaWxuUGhrUmtYOWow?=
 =?utf-8?B?ZG9zMzNKM2VrdzZ6TWZvUmViclNuSHI3TE1oRHZkRXY5NUdZMUtqWkdsK3BD?=
 =?utf-8?B?NzlhTUNCTkgvd3l0ZUFreFo4SVcwL3JNL0xzWTB0VUc0NjNTTkxzOEx0MzVX?=
 =?utf-8?B?ZFY1NXM0eC84SGI0cy9JcC81UGxCbzRxZit6dkF3ZnN4akxJTjcvZE03emNC?=
 =?utf-8?B?TW9DZXJqdzM2WU41NTUraVFLdjRiejYwYUZibWxtNUVRUHl4dHM0b1NYR0dV?=
 =?utf-8?B?R1Nia3FMbzhuTWp2Ym1IZFJMTmJWSkNvclBINzc5M1pjWVVlVDViNG90Szlr?=
 =?utf-8?B?bFNtZ3NiamhZRTAxU1NLejhIdnFhL01la0NBVlZIczVyYTJXMy9HSEFjVW1D?=
 =?utf-8?B?blhwVFJvVDJpWXMxdmhNYTE1OHZxenlLSkxucEZVSXBldmJleEIzVzNnZmV4?=
 =?utf-8?Q?BT91nY4NCMP6E8099EV+1fddjpaXEA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5094.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QWowVVdsWUZFQXVPSWZrSnBXTDA4cG9tdExkdi9iRVpmendhTWJ6V0tDSnQ5?=
 =?utf-8?B?K2hVc2QzekNlV0xEZDMxWVBaUkYrNC9kd0NXYVF6TzZRNjJhYWZmYndjYWtN?=
 =?utf-8?B?TG5SMDVwdFRHRW5PcThTaUZtMjUwUi9YU1hiKzZBUXNTSGt5K3grOTVSRTlk?=
 =?utf-8?B?VG9FNDdZVFduR21qelJvL1BNcktna1JPbytwUUQ5TU84ZGtrZVhCOFBSQ3Ur?=
 =?utf-8?B?cndLRisyVi9Kdm1RbFArQlRYT09JaC9peXN1TXJPVGc4bXRwQkg2OVJUdElu?=
 =?utf-8?B?bnUvamlwbjVjYUtnYkRva1FGN0ZGMER1ZTVYV0cwUWNoTTlFMFU2Z0FNYlJi?=
 =?utf-8?B?T0tXK0hhRi8wLzZqcTcwQUpkY2I2amkwbGZtWkQ0d3pVUEp1NkR4WEl6d2tj?=
 =?utf-8?B?SU9TV1QreVFTUStPcVhPQjB2QmFWaEpiZU14L1Q2RlB1WWJINm9JT0h5OU9J?=
 =?utf-8?B?UHRaRGMzTkZNaUFqRDgzcllxSTJkWjZsdTlYQkQ3cGFta1JXMUNYTmNDOTVH?=
 =?utf-8?B?NTJwZVo4a1hMSzlaem0xQmZpVHhJKy82QUtWY2szUXFubWRNcHEvS1Z0Zmg3?=
 =?utf-8?B?MnE1TVlZMzRNQWY4SWpBZlI2WFk5SEJXMnZMOWo0UVVobFlYeTJrbFFOQ1E1?=
 =?utf-8?B?MGxMUDJsKzFVaDF2Z3dkY0IxWXdWc2l0ZVF5TFhkVGlxTEVYSk1rdG1jeDhB?=
 =?utf-8?B?dkgxRnNrMXgzcW91S0t0TVU3VlFzNklhZnpFcnBWYm5DU0lZMUhqb2E5dTYw?=
 =?utf-8?B?Z1UrcXh4VUdOSEZPeGhSSmpFcm8zdXZZazZJVC95aHlNckgvSGd0M1BaY05T?=
 =?utf-8?B?L0M4bXFBN042bE91S2R3dnFjU05mcmVZWG9kc0hpZUk1L1dvL0VDUmxacDRZ?=
 =?utf-8?B?UEJqckZSUE5xcFlpcnBNekdLNWJKNE54Q2RaS0ZWQXErNHVhbW5jenMwQlpO?=
 =?utf-8?B?WklZUmgyellacTBMcURFSFBkUXRNVW5rZk1lTXVHUE9oZHJlWkJkeUd4UXh6?=
 =?utf-8?B?d0tmU1VPMzZVZTd6UStPTXpOeDUzdEhRaGIxTEdBQnFBOERUbGZ0SUVEOHY1?=
 =?utf-8?B?SkFleE1zMUNkQTRpaEw1aVk4REFRVFVCRmE2OHVRNkNwUVM4VjI0WDY4S0pM?=
 =?utf-8?B?UTdVZ1NvalJxUFhxOGw3am5Sa1BqTW5Na1NJT255YVFrc28rYUQycXRVZ0No?=
 =?utf-8?B?cU40d24xOTNhTkJrQVhRd0ZLV0lxVmxHaGlTZTIwR1RxTkUvUDdtT2VmNnl1?=
 =?utf-8?B?TEdDYkxnb1NROVNWbTVLS0g0ajhaUnVLazhSQmpkNkdOU3lFVDg3MXp6dDRn?=
 =?utf-8?B?TVFKdFFVWHpaU1Jkb2hVSVFybDVBUFgrMjlkM21DQUpLdDZhODRjWWF1NTlF?=
 =?utf-8?B?VEFXZUdRVmRuNEJFdlJCZWJFS3hIelBQM2RDNEN4R0J5TmNQR3l3QW41RlM1?=
 =?utf-8?B?azJCM1p0WXhrUHkrUVlDeDk0Tlg2ZkdIQ1dZV1lQdG9GVnJYK2RxS01QbWUv?=
 =?utf-8?B?eHZZU0ljYjNwZU1jUFdwL0hmazZnTHh3RHlDVUNVcnVwdDRkWmNESTNYVEpI?=
 =?utf-8?B?RkZvZ2lhOUJKRkI5MDJvajBUZUdQWFVNUklzRFV5L2pYeXVIOXh4RjJiWGNu?=
 =?utf-8?B?dG9Pcnd4blE0NFJabFRSc3F3bVlKWUZnMGp1dEM1Rk1CMzVFUTNtdHRvVGNn?=
 =?utf-8?B?U04zemgwL3lZS3ZUYksyeVRQRUxiM2VVekJkQUZFQjF0dldZendNMkJ3TGpJ?=
 =?utf-8?B?K2wrcmsweURhbXZxVFJJYjc3YVJvSmJRbEZINXJndjlVTEdDSjA2eldMVlg4?=
 =?utf-8?B?WDhmSk1uK2V2Z25Wa0NNY0pOKy9qRUp2KytQU0xrSTB2cGtPT1pzQTVBeXRH?=
 =?utf-8?B?LzJVamNjRjhiendzYnRxK3QrOE5FM1RFNllSN2FVdmt1dWVqYUQxYnZrU1M3?=
 =?utf-8?B?TGtnVmpYTEpiaFdVb2o5cndIdnJxT0QrLzdmQkFBREVMOXVxQUhJOHg4a2k1?=
 =?utf-8?B?VWtLOE1UcmpUUGRhd25UN2Z4QzFJMFhST1AzUlMzd3dySTBjaldTUXNIZ2pD?=
 =?utf-8?B?QUs2RzBGSlR1SWtEb01pdCtGbjNyRHYxL0JhdGkrWit2MGdtVFZTcW5mZERu?=
 =?utf-8?B?SXdUVHRNRjdqeXV0NXIzMUZSSHkwRzJOY3JVaFZQYUFDdWdqQVVqMEZNUlVE?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: multipart/signed;
	boundary="Apple-Mail=_109405E8-2A71-4C87-968A-D5DAD28F0C36";
	protocol="application/pkcs7-signature"; micalg=sha-256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5094.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e4deae-c490-4df4-fabd-08dde02a0da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 20:42:17.8242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +oYfuwr3KChkW4mPtPtdC0lqJKn4+0/ZcctPzAL8C141+MYBt5vl3xJgJhZNBHZnGPjaAkdJ8AkWRyXdjZA1rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8242

--Apple-Mail=_109405E8-2A71-4C87-968A-D5DAD28F0C36
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Aug 20, 2025, at 1:55=E2=80=AFAM, Miklos Szeredi =
<miklos@szeredi.hu> wrote:
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Wed, 20 Aug 2025 at 01:35, Jim Harris <jiharris@nvidia.com> wrote:
>=20
>> Can we safely depend on the FUSE_NOTIFY_INVAL_ENTRY notifications to =
trigger FORGET commands for the associated inodes? If not, can we =
consider adding a new FUSE_NOTIFY_DROP_ENTRY notification that would ask =
the kernel to release the inode and send a FORGET command when memory =
pressure or clean-up is needed by the device?
>=20
> As far as I understand what you want is drop the entry from the cache
> *if it is unused*.  Plain FUSE_NOTIFY_INVAL_ENTRY will unhash the
> dentry regardless of its refcount, of course FORGET will be sent only
> after the reference is released.
>=20
> FUSE_NOTIFY_INVAL_ENTRY with FUSE_EXPIRE_ONLY will do something like
> your desired FUSE_NOTIFY_DROP_ENTRY operation, at least on virtiofs
> (fc->delete_stale is on).  I notice there's a fuse_dir_changed() call
> regardless of FUSE_EXPIRE_ONLY, which is not appropriate for the drop
> case, this can probably be moved inside the !FUSE_EXPIRE_ONLY branch.

Thanks for the clarification.

For that extra fuse_dir_changed() call - is this a required fix for =
correctness or just an optimization to avoid unnecessarily invalidating =
the parent directory=E2=80=99s attributes?

>=20
> The other question is whether something more efficient should be
> added. E.g. FUSE_NOTIFY_SHRINK_LOOKUP_CACHE with a num_drop argument
> that tells fuse to try to drop this many unused entries?

Absolutely something like this would be more efficient. Using =
FUSE_NOTIFY_INVAL_ENTRY requires saving filenames which isn=E2=80=99t =
ideal.

> Thanks,
> Miklos


--Apple-Mail=_109405E8-2A71-4C87-968A-D5DAD28F0C36
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

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
LTIwMjMwNTMxMTYwNAYDVQQDEy1qaWhhcnJpcyA2MzZFQkM4OC0yNThCLTQ2QkYtQkU2RS1ERTgz
Mjk3NEVFMkYwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDsK5flcFLKT/1ktmlekKTA
8JwI64E20ekPEvj4KcEynk2b/aaS1Vol+gDoCmp8Q2YKca4RO3IPmWYGMEKWyOwh3R/X+NDC3kEn
xR9FRyPKixPVaVIJOBvpLgTHlTGo6sBECGARmWLNcq/VP/IOEfynt+o0ycfhfMmVCLNeTpVnTDfr
2+gA+EzrG3y7hFlf741+Iu27ml7F2Sb+OuD8LaaIvbUH+47Ha9c7PNbS8gGCOqJ+JqpFbz6nyiVN
KzcxsvQph1p1IlvctilnvGOLNCSQY24IPabPY4mh2jOOELalk8gKhIgeZ4v4XnuDGKzG3OQXjvNW
ki++zsKA+Vb5MH1HAgMBAAGjggNiMIIDXjAOBgNVHQ8BAf8EBAMCBaAwHgYDVR0RBBcwFYETamlo
YXJyaXNAbnZpZGlhLmNvbTAdBgNVHQ4EFgQUXogZtTPa9kRDpzx+baYj2ZB5hNUwHwYDVR0jBBgw
FoAUlatDA/vUWLsb/j02/mvLeNitl7MwggEGBgNVHR8Egf4wgfswgfiggfWggfKGgbhsZGFwOi8v
L0NOPUhRTlZDQTEyMi1DQSgxMCksQ049aHFudmNhMTIyLENOPUNEUCxDTj1QdWJsaWMlMjBLZXkl
MjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPW52aWRpYSxEQz1jb20/
Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlv
blBvaW50hjVodHRwOi8vcGtpLm52aWRpYS5jb20vQ2VydEVucm9sbC9IUU5WQ0ExMjItQ0EoMTAp
LmNybDCCAUAGCCsGAQUFBwEBBIIBMjCCAS4wgaoGCCsGAQUFBzAChoGdbGRhcDovLy9DTj1IUU5W
Q0ExMjItQ0EsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENO
PUNvbmZpZ3VyYXRpb24sREM9bnZpZGlhLERDPWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0
Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTBWBggrBgEFBQcwAoZKaHR0cDovL3BraS5udmlk
aWEuY29tL0NlcnRFbnJvbGwvaHFudmNhMTIyLm52aWRpYS5jb21fSFFOVkNBMTIyLUNBKDExKS5j
cnQwJwYIKwYBBQUHMAGGG2h0dHA6Ly9vY3NwLm52aWRpYS5jb20vb2NzcDA8BgkrBgEEAYI3FQcE
LzAtBiUrBgEEAYI3FQiEt/Bxh8iPbIfRhSGG6Z5lg6ejJWKC/7BT5/cMAgFlAgEkMCkGA1UdJQQi
MCAGCisGAQQBgjcKAwQGCCsGAQUFBwMEBggrBgEFBQcDAjA1BgkrBgEEAYI3FQoEKDAmMAwGCisG
AQQBgjcKAwQwCgYIKwYBBQUHAwQwCgYIKwYBBQUHAwIwDQYJKoZIhvcNAQELBQADggIBABaxnmlH
ePMLNtYtyCN1iDp5l7pbi5wxLNXCULGo252QLCXJwKTosiYCLTT6gOZ+Uhf0QzvbJkGhgu0e3pz3
/SbVwnLZdFMZIsgOR5k85d7cAzE/sRbwVurWZdp125ufyG2DHuoYWE1G9c2rNfgwjKNL1i3JBbG5
Dr2dfUMQyHJB1KwxwfUpNWIC2ClDIxnluV01zPenYIkAqEJGwHWcuhDstCm+TzRMWzueEvJDKYrI
zO5J7SMn0OcGGxmEt4oqYNOULHAsiCd1ULsaHgr3FiIyj1UIUDyPd/VK5a/E4VPhj3xtJtLQjRbn
d+bupdZmIkhAuQLzGdckoxfV3gEhtIlnot0On97zdBbGB+E1f+hF4ogYO/61KnFlaM2CAFPk/LuD
iqTYYB3ysoTOVaSXb/W8mvjx+VY1aWgNfjBJRMCD6BMbBi8XzSB02porHuQpxcT3soUa2jnbM/oR
XS2win7fcEf57lwNPw8cZPPeiIx/na47xrsxRVCmcBoWtVU62ywa/0+XSj602p2sYuVck1cgPoLz
GdBYwNQHSGgUbVspeFQcMfl51EEXrDe3pgnY82qt3kCOSzdBSW3sJfOjN0hcfI76eG3CnabiGnVG
ukDrLIwmyWQp6aS9KxbJr4tq4DfDEnoejOYWc1AeLTDaydw7iBNAR/uMrCqfi5m4GjnqMYICzTCC
AskCAQEwWzBEMRMwEQYKCZImiZPyLGQBGRYDY29tMRYwFAYKCZImiZPyLGQBGRYGbnZpZGlhMRUw
EwYDVQQDEwxIUU5WQ0ExMjItQ0ECE3gBwfkxPjNrfUD9c50ACwHB+TEwDQYJYIZIAWUDBAIBBQCg
ggFDMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDgyMDIwNDE1
OVowLwYJKoZIhvcNAQkEMSIEIKQUm3Om7Zzs4KXequiTVVqsAsd8HiOO3uNqH2IgV7izMGoGCSsG
AQQBgjcQBDFdMFswRDETMBEGCgmSJomT8ixkARkWA2NvbTEWMBQGCgmSJomT8ixkARkWBm52aWRp
YTEVMBMGA1UEAxMMSFFOVkNBMTIyLUNBAhN4AcH5MT4za31A/XOdAAsBwfkxMGwGCyqGSIb3DQEJ
EAILMV2gWzBEMRMwEQYKCZImiZPyLGQBGRYDY29tMRYwFAYKCZImiZPyLGQBGRYGbnZpZGlhMRUw
EwYDVQQDEwxIUU5WQ0ExMjItQ0ECE3gBwfkxPjNrfUD9c50ACwHB+TEwDQYJKoZIhvcNAQELBQAE
ggEAmrztIcj2CcQwiKpngn7Us+RMjsIn/SdO2o8I1LmN4y7lYhEX5xRvEzMfWDcniCy+27l37fAI
huymHol4CBIVxLtIpB2kvoIV4kYtTeLi8CjwTYf3Ib6OkqsAQhcNtjurpsIfLl3MA5gPichC6O/X
bjFPJbL4ycnFjdxd1293dQYg6PRV4dkMjYmFUyjkLnYCqNwjv1I/gB6tDcQVgxOgguu+S8n6KrYs
zUy0I1seVZrNHfwAlMEsqKKoSITZ0MRSOdqQNXwWpXmp1N2I1kqHOsJs3YP0gzH/8xqSWa5l1a6Z
H+rd0DBaGyVAFe60VE3yO7uNMM30ZXu02zF5QgsqYgAAAAAAAA==

--Apple-Mail=_109405E8-2A71-4C87-968A-D5DAD28F0C36--

