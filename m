Return-Path: <linux-fsdevel+bounces-44859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE15FA6D789
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 10:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F0516F152
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 09:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463CD25D913;
	Mon, 24 Mar 2025 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyberus-technology.de header.i=@cyberus-technology.de header.b="RjpGOSpE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from FR4P281CU032.outbound.protection.outlook.com (mail-germanywestcentralazon11022088.outbound.protection.outlook.com [40.107.149.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD33C25D554;
	Mon, 24 Mar 2025 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742808910; cv=fail; b=RX4PFVnkEXod8sTBaawWChamlrk5j3NZ2gfxfVuj9n6PU8QhaIMi8FcVZv1WDr10f6dQN6ElOMb4RbrdwCbPkXKU1USOH54Mg/j7jFyMncKHyshRK5fOK+UWxOLKlGIyP8ZfMSzYzAIP+imQPT8T4GFNHXmG+Wy000ZKMe3RL24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742808910; c=relaxed/simple;
	bh=H7r0G3YVWeCgAyWLjwvcajIP1gZyDd+RxEz94lL1Ttw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NOFh712oArmcwepyufdB66sjAzdpqF7QmTauprAWwULPYO9karGH1+N/Zy6NLZ0P6oMBuNHoNpVN9qOZVwbXdqIOLrPrnQA0/sgnv2z13ZpCFvV0VmnUp8qLK3evWTZ61wjQ8Sr+pu5LHw8weO2soeLQC3p7oXXz55SrrgsKi1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cyberus-technology.de; spf=pass smtp.mailfrom=cyberus-technology.de; dkim=pass (2048-bit key) header.d=cyberus-technology.de header.i=@cyberus-technology.de header.b=RjpGOSpE; arc=fail smtp.client-ip=40.107.149.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cyberus-technology.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberus-technology.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfX0hxNwwtvrxRqsHO2c9QKkeI6lGF88ESwRHocG4YwM3h6h33X7ajxYI5LBDT2OWPfBsa9DT3sBtquC/Vmqd4m+lOVnhL8FFUXA/1UDXpbcVnFm4U3sx2XJPoKfD6QKkPUm81ilp3FWOZEBaBbFlB5WhbnKP4jb9OccNfFiOS9NP9UETRuJPBTvrctl0raSRgWPPdvUg+3SdsQDE24cVbyrzg5EBYc5UMNkJNgCCB3Aa/ctWePTvfRDa8RTnxpEILhoN1zxqs6IDvlECUhr40JTB9Zb8+bXN3Yr5lP1b5rNXCSIBE8SU9+NymmaydQKJPV5Go/h3utzTI1tKhdG/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7r0G3YVWeCgAyWLjwvcajIP1gZyDd+RxEz94lL1Ttw=;
 b=C5Ko7CFdVBWhga64bllI50pRhAGrhX5zVqfCXC/sqfwS6U/NP+EMcyvRgnKwR3qcKXHRcHAUJrP3sVRHxvsy4JlfSDAge0pic7B6bOA8Pjg28vUKgDXwh8DsFfkxDlRRxGiv2t0AYG8DmFHsDW8YJE8rSS/f4lyPAx5ksPSntKG0KI+MnbrGr3nwNk2HCwghyfZKddFFbLXrXlrphEAtzOg98db0GAxKQO2kP5VHQsi7Q+J9S2DAuptqdzkJKTO9EWOuCEsFeFH4fufJ7suNnufXHHqAKna2KcztnYJElOV/GxPO9ika156fucOgCX2hHh1pVSrBoBBsonnSigYXiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cyberus-technology.de; dmarc=pass action=none
 header.from=cyberus-technology.de; dkim=pass header.d=cyberus-technology.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberus-technology.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7r0G3YVWeCgAyWLjwvcajIP1gZyDd+RxEz94lL1Ttw=;
 b=RjpGOSpEGao9PRi9o6K8mdL830zlGK5ZNzwX1t2yLcffp2HKIIICfE3Jaw5WLlLiPRGPoM4VqQ66miRNfJu/C9NBWw/KBSMPpqBKjAlTjfD73YeK7PSd8idLT6WCKSa+Wi2ES6+MfKf3WJAe4UhpOKWEbPsiSKTy6AG0mjQeH5bl9wV7QwoLEgSB+29xEQUmJgAInalO4JWwNqU1VM5IRU05GA/JCcI+tZoVvYFuUUso3vB3yqFF7uVaccBwPcjbRNpLarYAYx+hPvPdE+CQ9wwXmKqg6p4s2Ids8LSo/EQRe/I5swIXy9EbkEB2bchvUAjwBY3DphMH81GpheNnkw==
Received: from FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:38::7) by
 BEZP281MB2213.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:52::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Mon, 24 Mar 2025 09:35:02 +0000
Received: from FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM
 ([fe80::bf0d:16fc:a18c:c423]) by FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM
 ([fe80::bf0d:16fc:a18c:c423%3]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 09:35:02 +0000
From: Julian Stecklina <julian.stecklina@cyberus-technology.de>
To: "hch@lst.de" <hch@lst.de>, "brauner@kernel.org" <brauner@kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "xiang@kernel.org" <xiang@kernel.org>,
	"linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Subject: Re: [PATCH v2 3/9] initrd: add a generic mechanism to add fs
 detectors
Thread-Topic: [PATCH v2 3/9] initrd: add a generic mechanism to add fs
 detectors
Thread-Index: AQHbm2nuwHQK7VElCUaqOnFT7msA17OCCTOA
Date: Mon, 24 Mar 2025 09:35:02 +0000
Message-ID:
 <15428e7e4dd2c548a3d4b6d8503a2d01070d3583.camel@cyberus-technology.de>
References: <20250322-initrd-erofs-v2-0-d66ee4a2c756@cyberus-technology.de>
	 <20250322-initrd-erofs-v2-3-d66ee4a2c756@cyberus-technology.de>
In-Reply-To: <20250322-initrd-erofs-v2-3-d66ee4a2c756@cyberus-technology.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cyberus-technology.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2P281MB2329:EE_|BEZP281MB2213:EE_
x-ms-office365-filtering-correlation-id: 23856438-eb24-479a-15e5-08dd6ab7270d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WTc3WEl2YVE3WEFSdW5RYTNIbk9LV0dRMGlCcXV3T2NQM1plenM0aVJKa1hU?=
 =?utf-8?B?cU1Td3o5eEhBOGNJZk5FQ3JEZjN3d2lWbkV0U1FoRHRSbW1mQTRsNzhuWlBl?=
 =?utf-8?B?Und0R2FsTENnNmM0MTRhUXNvaWpYT3FUR1c0cmJyZjR5bmJxejkvYXg2aEh5?=
 =?utf-8?B?eExOeDRDcVVtL1VhbkJZM3pZNncxd1hZUXRyZ09xUmJ1bHRoU0JocWtiSEpq?=
 =?utf-8?B?d3FKRkh1V2VMRE1jYml5NjdSVFBIS0xaaFd2TS9PNnhIQllwM3hxempiUTcw?=
 =?utf-8?B?TEEySmttNmVMSWVDL2o0aFVNZWVwZVhPUWFCNXpHYlZVNTY1RmkrMGpTRnFP?=
 =?utf-8?B?Y1JTUEFRWnAxNElhRCtMNXBWUGFyZHVmOHlZSkhWOHJZLy94Q1ROMnU2c05m?=
 =?utf-8?B?b0pqUWlIS3ZKREtMdXRoMHd5MzFvalpSNlJ1MU9JNDN1Zk14V2s4bm1GOEwv?=
 =?utf-8?B?WEdBYnJwTE5vVTBNZGp0Tjdlb3Vqb2VFUjd6dVl6RElaNWJQNUhZb3lEd2J2?=
 =?utf-8?B?VElaY2VvZVlZQWQyMExma1FBbmVQZVdNMkZ3alk1ZGFxY1RFVUJFSGZvUnI5?=
 =?utf-8?B?dEJPUldzK0xHZ2wwS1ZvbmdER2pkenVUWDBrU1hHS1dDbXJOMzd3ZVNSNXE5?=
 =?utf-8?B?MWZEY1RlNTNlaDlaUTl4c1BUOEVOR01GMDkvTnVvZlVOTkNUMFlFN0N1NjdP?=
 =?utf-8?B?N0ttSi9Bd2YvdWhFbnpJdzByMCt1RXp1OG1PazA0MDdPSTBETW05WW9kMFZo?=
 =?utf-8?B?OGhrbkNiaGlrRVVUcFp5a0R1Ty9FeWRtcWliN3lTeExxOGU1VWFnUUlVUWtr?=
 =?utf-8?B?YlpXRFVibUFhdElaRm1rd1JMN1ZBUCtSVHZ2SHhyaVlNTzBQRXdXNzFPS2Jj?=
 =?utf-8?B?dmR0REF6MzMrL0IxV1A2L2gyTngxL3NhRWN4SUltNytWNkFnM2pzVHdJQU90?=
 =?utf-8?B?ZitjR21oZVlVS2dhQjJLRW5WeDFGd0NpemRyVVJtOVcySzBHNjVTZGw3MkNM?=
 =?utf-8?B?SzVER01xS2hhY05CR0ZhQm9oNW9DTEVSMFNWYVBPcEhqUldMVFpHNWEyb1pY?=
 =?utf-8?B?MHdEajl5UFRKN0lFcGVVTUI4NlA4K0o0bWlIM2R5U3M2MVppUWR4WXhudzZh?=
 =?utf-8?B?Z01KakpRcVpUM1Ava1l3YnZRNW9FdXF5SGxSaGlGUDJnL1BTK1N0OHJCUzFM?=
 =?utf-8?B?M3ZQUTZJa0pXYWVhUTJWbzBCdWk2WURDMFpCNFR5aHN1U0QwcFlLS2lTc1ZL?=
 =?utf-8?B?VUl0cjBldHpxTzFHYTQ5MTIyeUp6Y2hhSmR5cWNqY2VQaHo5Slg3ZTNxQ2wx?=
 =?utf-8?B?TWN3bVJMcWZJeUJyMnN0eEZ4OURiSFc4bFE0MkQ4RmlTVXA4OVFIcVl5cXNZ?=
 =?utf-8?B?b1hGa0tSVTgvaThOV2dnZmlDOXlEVjBQazBnZlEvVUdlK0Qza1FHZWh6R1Vw?=
 =?utf-8?B?TW9DaE9TM3AxS0FqL01MYVQxMFhia2lSMmlkaDRad0dFcDB2L0ZrUnJZUVZO?=
 =?utf-8?B?MkNEUm1xekUraHBLQUtEKzFiS2JaaGFjbm5qelZsUG1UYWY5SHZ2MDdLcDg4?=
 =?utf-8?B?c3NSKzQvTHZjc2R2ZE44NkJrSjhZaHlJWnFvOUVFc3hiUVVQTFRTd05YRWhs?=
 =?utf-8?B?L01qallOaENIWHFqVXZyNmloRXJGU3g0d0l3d0xldUg4cEpmM2ptdHZPY2Fz?=
 =?utf-8?B?UUN2dEJkaWdBb2wzY3NBL1pXWE1LM2ZuUE5rSG56bHEzSTdUb0xSdWNzYmJa?=
 =?utf-8?B?VXd6M2NyUGRvVGVzWWlmV1oxZDFHZkgraHRTYm5Vdk80a0lsRkNIUlJrZGVj?=
 =?utf-8?B?cEFOdEQ1TVJFL2tvVnJLR2g2Sk9zZ2dOelZEeEtYVHpHd2dwS0U3VUdxbHZz?=
 =?utf-8?B?ZWJaWG9HRFovZHVzNzZuWUlGOTR6T1BtK1RuUFJIY3o1T2NLQzN4SUp3RUM4?=
 =?utf-8?B?UTR0K3hYZXMzamlPRDZIYlFoamJhS0U1dEd0YXl6blFXVXVITUpHRkN2bGZO?=
 =?utf-8?B?WXN6Q3ovVWRRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UEVCWjQwZDc5d1BEWnA3bGgrbmFvSmFFOGRVNmNqbDJNUDhERTRHZVBtK0di?=
 =?utf-8?B?ejR3b2NDOE1IUElGVUlZMTEyWXQ1VUJ6RVhHTkZtWlc0czJvWFA5eTZ0cktF?=
 =?utf-8?B?TTcxTDJtaWdPSkVGK0tjQUxaMXRlMU9QbmNzejVqMWIwUjMwNDlFV3pwbzRF?=
 =?utf-8?B?MTlVVTdnWWpLK3M5eUhsVjA2OUt2dFg0R0FneVFOQVJERDRBOGsrUkVURVRn?=
 =?utf-8?B?Y0RpY2NUWk9XKys4L3k1NGt1cXFoOEF6VGRTdmJVSnFwWmtkQnhTclU5Si8y?=
 =?utf-8?B?ZEVqcytENnBQek5JSC9xdDBkOEQ3T3BzL0twZ2EveHZQbVR0UkdtMTJsOXVm?=
 =?utf-8?B?N3ZpSm5xbmNVYUJmWmtnd0N3ZWsvNXRINDhmOXU2UU5rTC8rZmFqMGRnTkJy?=
 =?utf-8?B?NmF4STc4amRCTHM1RU9HNmxoK3poeHRCSGkrQ1doSmluZHdYUW5vRXRDSG9M?=
 =?utf-8?B?YUMxVEJMTnRWVGF3d3J1RzhrYlJUbktPR1RyandVNHduUkhGZm8yWjFKMWM2?=
 =?utf-8?B?T1VvZFFJM0s2dXlnYTNCMTBGWWdWOEUyVS9ZUXpRMzc1MHd0SytqZkcxdkFP?=
 =?utf-8?B?UHI3MnNVYzdVR0Vmd3NMVmsweldVWmI3a1dTKzVUQnBvT09HY3QwaFhOUUIy?=
 =?utf-8?B?d0crdlpXNkdzb0IrYW82S3ZXdmdHQnNtdmlnbU1mTUUrMENocDY1bDZmZWxM?=
 =?utf-8?B?REdDK2NBbnZQQ1BaVk1OZnRvNVhKdENlSU1PMEJTL3Y0cEFxN2RLbVVMRzFk?=
 =?utf-8?B?VzZNK3lCRzdkamNsWFJLZzlnejlZcWY3T2dMUjAycTlJK093emx2T3BvUlMz?=
 =?utf-8?B?YW8yc1lmSFhES2VZbEh3T09BOU9IZVlqMmpnRGRZVk4yQnEyMXc4RmRMYlFG?=
 =?utf-8?B?SzZPUkY4ZGtyWEVaUHdIU1hMRTl1NzhHL0pFOURjL0pZT1A1VFFsQzArM1Nl?=
 =?utf-8?B?K2phV2I2R2orTmV3OFVDc1N3TFhsVFpuSnI4MXF0Q2UyMVFwaWlhN09nNnJQ?=
 =?utf-8?B?aFlQNlFsZitHTXQwVUVKYVhzNkcxNnR6R2JJRE9VWlFlZ0ZiUjcxWmRyYzE1?=
 =?utf-8?B?U1Rud0trcmpNYUlZSkJTUFQ2bTVQVndINUdhR0ZKcitBMkE1RFk2bDAzeFNy?=
 =?utf-8?B?NWpyTFNTNXRCRXJYYXVqQW5ueGVqcElrb0NhTEN0WDZkZ0lVU01rY0lZbElZ?=
 =?utf-8?B?eDVNZkdMRGhDclhCdnhOUVExZEVUNzYyMHhsQkRMYVV3SkdEMW9oY0xQUHJw?=
 =?utf-8?B?Tk9Oa0NVazNhTHVvSzc5YnlISUlPdjNwOW5RYStNVVVjRnl0ZmIxY1QxcE9J?=
 =?utf-8?B?TEI2WWhVbnNFYVM2emNLcnRTakZsZlo0UHpVK1MxS2I0UHNaMjJIRFdCMDI4?=
 =?utf-8?B?NUwrbEREL0dtQWdwN3RtUTJLTHpueWNYUXVYVUVMVTVrdU5lMHZNMU9mUkJV?=
 =?utf-8?B?c1FBWWxtSFZ0YjN6aG42LzJlVjRFQ0lDeGQ2OVYvdkxMV1JUQkVFNlpKK3Vw?=
 =?utf-8?B?LzlMZURSc0MxNnZLbkQ5OEcxdldVZnNRT1d0M2kvZUpTVXZXL2FBRjdTSnBw?=
 =?utf-8?B?emFaUU1EMjFpclJFV0ZzT1JoMWlPNktKVmp1T285MThjTU5vZWJzbU05cEZx?=
 =?utf-8?B?eHgrUVVkbTBLSWs5SmE2N0owajdHNnFSUHJPN2ZoZ01pNFhyYkhDQzlFekRY?=
 =?utf-8?B?OG9kK3RrMEY3eTJleTBMNlJ3S0t2MnBQZStrM0UyeEtLVm9OeE51aks1OXJo?=
 =?utf-8?B?U3oyaTJXamIrVnl4WmZtR1NwRDdVNXZhSnlaNFNkc1MrYThmYlVIZWUzRzN0?=
 =?utf-8?B?ZFE3N015QTRORG5FcjBUSXpEVHRaUmQzUUxZbFExbUNyd21WYVJMRUEyZGtQ?=
 =?utf-8?B?ZWgwVjdOcXF2S2JNOHI4YlM0UXZMTWsydDJMN0VlcjVJWkswU2tMVkt2b3Y0?=
 =?utf-8?B?amh0NG5GZFNFVTNRc3lLbHlHMWRreFNsRVlFZ0pIVEpYRnhzUWtOL2FTQXE1?=
 =?utf-8?B?V0FHeGdySmJJcEtMSUZ3RGwrTnZWUDkyK21SMHhUbWRiS3RWZUZCVTQwQWgx?=
 =?utf-8?B?UzNZTDhoRVdsRjdSMVo5WmJBN1d4Umd4UjdKNk1YckFVcEdjdzJSQmE2UHZX?=
 =?utf-8?B?Vkk2N2g5ejZoU0hkd3UvSXQ0TzlUdGxzdVFiQ2dpQ1FqWEJxOXVadlA0Ylgr?=
 =?utf-8?Q?3ZeWLO6OMLNkLqL82h3Rvc1GGtckmIDe9NKVsLk3V1xJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01A73AFEE0B83F4CBD6F318703F858AD@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cyberus-technology.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 23856438-eb24-479a-15e5-08dd6ab7270d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 09:35:02.2945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f4e0f4e0-9d68-4bd6-a95b-0cba36dbac2e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KOlCdh/ncyZBs74PEPPoFdsTe0ohwhudL1knOI301VKiCilgD+GXYn2hSW82C6OPrjPGkVOHNij3WCi8lilXOqFMwtv+quncgwNjLAO9VhDMuTMvFS+4J/NXb8V3rSyQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2213

T24gU2F0LCAyMDI1LTAzLTIyIGF0IDIxOjM0ICswMTAwLCBKdWxpYW4gU3RlY2tsaW5hIHZpYSBC
NCBSZWxheSB3cm90ZToNCj4gDQo+IMKgI2lmZGVmIENPTkZJR19CTEtfREVWX0lOSVRSRA0KPiDC
oGV4dGVybiB2b2lkIF9faW5pdCByZXNlcnZlX2luaXRyZF9tZW0odm9pZCk7DQo+IMKgZXh0ZXJu
IHZvaWQgd2FpdF9mb3JfaW5pdHJhbWZzKHZvaWQpOw0KPiArDQo+ICsvKg0KPiArICogRGV0ZWN0
IGEgZmlsZXN5c3RlbSBvbiB0aGUgaW5pdHJkLiBZb3UgZ2V0IDEgS2lCIChCTE9DS19TSVpFKSBv
Zg0KPiArICogZGF0YSB0byB3b3JrIHdpdGguIFRoZSBvZmZzZXQgb2YgdGhlIGJsb2NrIGlzIHNw
ZWNpZmllZCBpbg0KPiArICogaW5pdHJkX2ZzX2RldGVjdCgpLg0KPiArICoNCj4gKyAqIEBibG9j
a19kYXRhOiBBIHBvaW50ZXIgdG8gQkxPQ0tfU0laRSBvZiBkYXRhDQo+ICsgKg0KPiArICogUmV0
dXJucyB0aGUgc2l6ZSBvZiB0aGUgZmlsZXN5c3RlbSBpbiBieXRlcyBvciAwLCBpZiB0aGUgZmls
ZXN5c3RlbQ0KPiArICogd2FzIG5vdCBkZXRlY3RlZC4NCj4gKyAqLw0KPiArdHlwZWRlZiBzaXpl
X3QgaW5pdHJkX2ZzX2RldGVjdF9mbih2b2lkICogY29uc3QgYmxvY2tfZGF0YSk7DQo+ICsNCj4g
K3N0cnVjdCBpbml0cmRfZGV0ZWN0X2ZzIHsNCj4gKyBpbml0cmRfZnNfZGV0ZWN0X2ZuICpkZXRl
Y3RfZm47DQo+ICsgbG9mZl90IGRldGVjdF9ieXRlX29mZnNldDsNCj4gK307DQo+ICsNCj4gK2V4
dGVybiBzdHJ1Y3QgaW5pdHJkX2RldGVjdF9mcyBfX3N0YXJ0X2luaXRyZF9mc19kZXRlY3RbXTsN
Cj4gK2V4dGVybiBzdHJ1Y3QgaW5pdHJkX2RldGVjdF9mcyBfX3N0b3BfaW5pdHJkX2ZzX2RldGVj
dFtdOw0KPiArDQo+ICsvKg0KPiArICogQWRkIGEgZmlsZXN5c3RlbSBkZXRlY3RvciBmb3IgaW5p
dHJkcy4gU2VlIHRoZSBkb2N1bWVudGF0aW9uIG9mDQo+ICsgKiBpbml0cmRfZnNfZGV0ZWN0X2Zu
IGFib3ZlLg0KPiArICovDQo+ICsjZGVmaW5lIGluaXRyZF9mc19kZXRlY3QoZm4sIGJ5dGVfb2Zm
c2V0KSBcDQo+ICsgc3RhdGljIGNvbnN0IHN0cnVjdCBpbml0cmRfZGV0ZWN0X2ZzIF9faW5pdHJk
X2ZzX2RldGVjdF8gIyMgZm4gXA0KPiArIF9fdXNlZCBfX3NlY3Rpb24oIl9pbml0cmRfZnNfZGV0
ZWN0IikgPSBcDQo+ICsgeyAuZGV0ZWN0X2ZuID0gZm4sIC5kZXRlY3RfYnl0ZV9vZmZzZXQgPSBi
eXRlX29mZnNldH0NCj4gKw0KPiDCoCNlbHNlDQo+IMKgc3RhdGljIGlubGluZSB2b2lkIF9faW5p
dCByZXNlcnZlX2luaXRyZF9tZW0odm9pZCkge30NCj4gwqBzdGF0aWMgaW5saW5lIHZvaWQgd2Fp
dF9mb3JfaW5pdHJhbWZzKHZvaWQpIHt9DQo+ICsNCj4gKyNkZWZpbmUgaW5pdHJkX2ZzX2RldGVj
dChkZXRlY3RmbikNCg0KVGhlICFDT05GSUdfQkxLX0RFVl9JTklUUkQgcGF0aCBpcyBicm9rZW4u
IFdpbGwgZml4IGluIHYzIGFuZCBhZGQgaXQgdG8gbXkgdGVzdA0KcGxhbi4NCg0KSnVsaWFuDQo=

