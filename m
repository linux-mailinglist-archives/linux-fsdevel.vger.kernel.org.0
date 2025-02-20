Return-Path: <linux-fsdevel+bounces-42147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5B4A3D158
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 07:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACCB21898DEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 06:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EDD1DF99F;
	Thu, 20 Feb 2025 06:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="CVxlkbiE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7539A1632DF
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 06:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740032586; cv=fail; b=cfqYYFvfoVW1dcF6ECinvjDMHbhLQ76OD2WMDF+qyYyq6IMT9VVBnL9c13eQ3cyjAuY2qee+lPNMrjsXrjWxFPU5z3XEncngIV/OjUuEOysJ2Wh+7fGhEnHt+oMtQg4a2MWNAe6nUP2XMUhBcfTJJUnOBEwR1gDnLTjhCw1UqYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740032586; c=relaxed/simple;
	bh=Cj5g4LHvcv1BYoVMo78jGvagefaFg0ejJWpnduATl9U=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZEcj8lVxQiytzj/wdQrvG7tHqASOEaC34pme/GFhEDkdL7PfDYEV+FGLXPlRMZNCJaan94ZOP9QB6AWKD2tp9mVqdahZjY42e6tB3k4OnQAJ37wemQ3UsJ2wLjgcjGVBA/N5VuVv3najEazW1HN+2hb1cTD7p2etFxrBf45lDaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=CVxlkbiE; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K0IEbi024302;
	Thu, 20 Feb 2025 06:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=Cj5g4LHvcv1BYoVMo78jGvagefaFg
	0ejJWpnduATl9U=; b=CVxlkbiEfuQfG2erXryGelsojBXjZOjGrISa7Kkur9OG6
	+PmBXclJ2G84+Sngt09jC9Big+CmSDGuTWK04vWKKuaM4kWK9T+rsd3OlFgpkAEX
	vRdpuk//SSqCkCa+YZJ9593PVi5bzLN+aOA3GwSINLLZJ0N90vBlTbwQSRnTUj84
	0jykcoaPQCSBjPxRhgMNLebnc327YEh+ukZ4Fomdpj1H4Ql4iqGyHPVLqWqjD6U5
	H7O4H3HO+4CfPb9bVwmJpmM0Jb2elk3qCDrbtC93z/0NluL9LygGT/jFWjZLsbVl
	/zgBbEGHoENYU7rvMaM0/oDYoPemvojLuO0BRH5+A==
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2041.outbound.protection.outlook.com [104.47.26.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 44vyyh9kjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 06:22:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6ZrZpN1f5NrX0DgGwOTKc1jup8O8nMGmxz/wjug7hq7+Pf8AgjRRArFPUeRRXybfu+Od5udT/VUhyLh+r0CLX6zKO8x0zomDHw38OZR/GSpoIcOBsMf5c7F4G/DVhx5OwgZSq+gcOH5/w+23Rz9nlaknhFXsOkBgE2iSOLfbdjofvRzaymI+D+jKZPdze18pXoeVF8fY7R45wNtLgXVjl4YqZ0DcZppvA8YJuSArtG6lAKHRaOe9M1kOsHebovbeAXvo3/Mbfm7cRZo4TxEt1Ko01Pgd+zMRLA/uO1fdneCoEjePOyWy7oqyn5Glov2sjAYJZFt1w5hPe2gHmoEaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cj5g4LHvcv1BYoVMo78jGvagefaFg0ejJWpnduATl9U=;
 b=O3P0ANeQm8LPyDqDEGCn9Py4rqjJ1WBsJHzu+YX8Exh0I4K+B8cxeLjcOsqX2ZcWwZauh72Bz6YJXCCYC+hhdLqMaNwWxtBON094aDOhQsmT4gnVSO4gY+prpSfvYQBoZfeH5Mj1ZHlQuaA9GLGAxc7qptp9FOt3/r5MjBVc78EQAr2u1Z3mwa4mx4i8AAeVKiopkk98BoHi+lvXXronR8grckJm5ftO/62Wlv45njPgYGmo5LApdPV/npHwnf35rQ7hufpZpRf1/dNTNCxQa9hHfuFEM2BTubAO5qNqC5GnjWPT/6vpQ+fo0WuE0cMi17/TKanQdoWR5s2nOY/QSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR04MB6782.apcprd04.prod.outlook.com (2603:1096:820:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 06:22:37 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 06:22:37 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v1] exfat: fix mount options cannot be modified via remount
Thread-Topic: [PATCH v1] exfat: fix mount options cannot be modified via
 remount
Thread-Index: AduDXpG0E4I/5vkBTR+Bl2tMNbHX3A==
Date: Thu, 20 Feb 2025 06:22:36 +0000
Message-ID:
 <PUZPR04MB6316C5073DF1B1523C8B298681C42@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR04MB6782:EE_
x-ms-office365-filtering-correlation-id: c18b78b1-bd58-4b19-4045-08dd5176f84b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cU5vRUhHMkw3UXlQeXVyMWFGQXRGTStSRlNKVVk4RlZJUDBOajBHaGNVUEVi?=
 =?utf-8?B?NktIdnh0SU03QThDNTl6eVRDenhheWtCQzFSWE1YZnl5L3MrUWtkbDNZQXdo?=
 =?utf-8?B?YkM2V2kwQmVLS09JUVJJSFNFWXJsWGl5QmdVWExSNTBBU0hzTmppbHJJbzBt?=
 =?utf-8?B?RThlU1NwU2ZNdXdCN1ltRmkxWTg4YVJodEhjSkFtTzUrejVEbThjVExneXJS?=
 =?utf-8?B?aVpORjJzbjloQ1R1aW5WbXhWczU2UXBncjdJN0xieEVQSmF6eWkwTWc0WEdw?=
 =?utf-8?B?TnhMMGVvdWdwUG1Qb1NJSmV6MVgvajB3elBsb3FvUHZVR00xU3R4aFovYUE2?=
 =?utf-8?B?MlZzQkQ0b0JmVk5VR01Rd3lBWjM3Ui9QS3dnVU1oTWV3Nk5ueFBVcE1jNi9k?=
 =?utf-8?B?b1JSMjRkYjc5emVpM0xYdlFQWWlJUk9FNkJKSzlBTHVBU0VwU2lYK1FRYisv?=
 =?utf-8?B?VGJWcXlCditLd3lKOXBreDB3V2w3aUFPSmNOSFFmSFBQZk9NWVFPM1ZpNWJU?=
 =?utf-8?B?TTh2Yzcxc2t4dHM0MUNMZGxXR3doYTFwTlhLMHRSV3NJNFU1SE1USWJaeEZM?=
 =?utf-8?B?NVdFazBoallKNTBGejFEbE9zVDRZeWV0QXhZM2IxTUlWMm1OL1pWL0l6TUFm?=
 =?utf-8?B?Wk9QdGxJbkhCUGZZcWhIaFdSUzZCV2p5RVZHS2R6MDFPWG5ZY2VLdkY0Sity?=
 =?utf-8?B?VVZBR1JOS2xJWEdsOTF4c00vekh4ZGtBL1U1M1gxaUZrTzVZSWRsdHFrdmpn?=
 =?utf-8?B?MXd4Mmt2Ym9heG9pTkcvQS94OHR2dzZnRDN0VXJuMXFzY0dYNW5DVWxXN2cy?=
 =?utf-8?B?cTNhN1dtaTk2ZDR5WWVIL2Q5ZkdwMXk5Qm9GSmVMbzBsTkg0NU93RnBCdU1Q?=
 =?utf-8?B?ZTNDRnErNjRBeFJvd1FweFkwQ1hvQ2N4bGFINUVHYXRnVitMc2pURU9hdmhM?=
 =?utf-8?B?NVhESWxiZWhHK1J0ektyeFBERWMvWVR0SGEybTVuTld6b21Mb1RKRUo5dmNl?=
 =?utf-8?B?YXpWRW1vaE1ja2YycjRtWC9sRUNZQXhSQkhHYzd6cGsyYy9tbXdieUFqS0Ez?=
 =?utf-8?B?cFhmSnluZXBGUjE1RG9MMFRZcXdjSkRZazhyc21WeHRVWkN4SE5WOGQzNVU1?=
 =?utf-8?B?Y0hlL2lvV1NHVmJpMm4yZWU1bDJIQ2d4ZW9PdWhXc3dWemRhMlcrTU9DVlR4?=
 =?utf-8?B?UmdvOXlweWNvQXNhN3l4bldTKzBpdnhBeFJkRnJ6QjNpTkpQTkdGRUpUUE9B?=
 =?utf-8?B?TldteW84M0x5eGZUN0NsdXduR0tyOVdleGptM1h2LytBMGhqczZNWUQ2bkp3?=
 =?utf-8?B?UndLZTVZdHVFTWVqbWFOYjJ0aVovcTMrSVZpcjBwdEJ2cG9xNHd4WDJvZlVH?=
 =?utf-8?B?eDlnbnh6SllicXVGTW1qZEVGKzBnUmVaSFZYaEtaSmdvMmJkenZTWlplWFI3?=
 =?utf-8?B?YlJZaXFtR1FXRG5KKzFhYjdTRmtqTEp5NDlGb1B3bkloTExVcjZRajBVclhD?=
 =?utf-8?B?TnR1cGdBSHhDVVJhT3B3TjI3K1ZySGhIazZIYUZTTXQ5T0o1UTVZeWQxYkdN?=
 =?utf-8?B?VEtQNHU0ZzRmWHp0d3JDcXo0RGRyNWtzWXlsK3E1MVpmNStjU3hCM01wbzN1?=
 =?utf-8?B?Q0tOT1NtcDVvUWx0WlRWTWxQQUZaRFpob1kwQlpTS2NQTTJTOHA1Zi83Z0JI?=
 =?utf-8?B?NmJyL1dzekxKMUZMTS8rTjlXaGU4MVFYM0NEdG42VGNpc1hmOWdDcXVNeWVo?=
 =?utf-8?B?Z1ZCaGl1S3R3VFZObnJpbWlkbGk5ZnZTVlhnZUFHWUxzM05neVdTVGpzQVBP?=
 =?utf-8?B?Ui9iVjFsdkNOQ3gwR0E0UjdGTnczK1JIQXh4TjR6WlJZcnZyVkJaWG8rOW9o?=
 =?utf-8?B?SmZMZjF2K094bmpDSkYreDZLVkJ2cHNNOXZkV0hzdGxkZlpLZ2U3ZUJ5U0NR?=
 =?utf-8?Q?bBVf+OoXYrVM11SRjP3OqlW6r2B4b5pQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NlJId2c4QlNLcVJadDBZekRvZVByYkRSdWFjb2FwdEJkdFVRd3F1VHplamxu?=
 =?utf-8?B?WW9vZlM1NHJ6SEo3N3RlZ3RIMTBGcEUybHFDU0l2am1Tb0xUNk00dTR1b1I2?=
 =?utf-8?B?NHZ2aThSVlhORmZ4UCtnZk5hdWRBMjdjZUNtSEhtQWxjNlBHZHlMN2pONWlC?=
 =?utf-8?B?UjRvRWZXL2dQT2xKdmt4VWdZalEzTEFUeTNJbGFjWHJoWW9ScUE0ZFpMa3hV?=
 =?utf-8?B?NTcvSUFDa0p0eFFyVnV6RVN5bkJ6eDBwOUt0SUtneU9VTDdRbnJrdzExL0h6?=
 =?utf-8?B?enN3ZVlKOEUxYVF3ZCtwWjNYWjFWRktob1ZrMEtKcTdiakJJN2Y3eFgvTmZB?=
 =?utf-8?B?U0lKSXR5U25DclVkZVlkRFZTMFdtU2k2MVZqc1VsN3VFQlFwbmxNR1puUTBs?=
 =?utf-8?B?SGc3QWhiRXY0RVpTT3ZXSlBka1d1VHB1bS94Q3dwdFg1cFI3dUwyTEs5Q0lC?=
 =?utf-8?B?LzF3bGRhRVU4dzZDREpsVmt0SVZOT21scHUxY0VKWXJ2bStXc0lxTTc4L3Bv?=
 =?utf-8?B?eGZqUmZCU1lidHBSR0FzSDNBaW81cWtTL0dWMm8yZ1dkQXFmMGVwcTZ3THFR?=
 =?utf-8?B?ZHhncmpLMEh0NjYrci9BQXllRmxNSDBWaEs4MXU3dngxWnZFa29ITSswOElS?=
 =?utf-8?B?enNGT0trbE1xU1VlRHFUK2tleHdPRUpBWStlaDA2bldTVFF0MFcwN3VrT2hk?=
 =?utf-8?B?R2VWV0lRRm01NWlSQ09ZenhjWXlQTzZlUTR4dzVOMDhCQlczTytyaldUbjg0?=
 =?utf-8?B?NVNGaE1la3VaWUorOHkxMGFWazkyMlRLNkI1TER2T2xhM2hBQW8rWnRURmkv?=
 =?utf-8?B?SmZXNG93TjMvekN0NUxIM1VCS29PSGJsZTJpbXlZVk9VcW4wN1F4Sytrd2M3?=
 =?utf-8?B?ZzN0YWhXQ0hNMmxNWTkyOW9xUTRUeW5MNi9OMFp6RzFaeEhtMW5DblVrdXVE?=
 =?utf-8?B?VlpGcjhkOE9uc2gzS2RBRVc5OWRZcFNDd25CZkJMRHZEcGt4UmVLUExtamNm?=
 =?utf-8?B?RlhER1lxbFl0dWlEYUZWbFl3cjlwelFNbGZUSG02a2JFMUhudUh5d2JQaHUy?=
 =?utf-8?B?UmtqbTdrRy94SmdrazcrRGVvUWtGTHZOSjhuSGplUGs3WkhHdmhNcTNrU0Fm?=
 =?utf-8?B?NStRRngzeFhjOVhLNzF4RC8xNEp2VkRqNlRucTFMdjBmM2lJRFhpN3ZNRHRK?=
 =?utf-8?B?dkdZODhLWkdMMDdaOEViekNxVXByUENtUGxHdy9qYUxFQ0YvZWJ5WWJENC9z?=
 =?utf-8?B?MU04R1paa1pCVkhmY3FGdlM0bzlUSVgxZmxPNjdlNkhpcHpKd0Vqcy9tNndL?=
 =?utf-8?B?RnRXcjZZSVM0WE1UOGxkM0IyY05HNTRTN0VCKzNITmdJa1dTZmZOSGplK0FW?=
 =?utf-8?B?emNyN1E5MS9hVXZBUWFJMEJiSHIyUXpVQnlCL2VwdjhkdHcwcFdEQWd2Tmdp?=
 =?utf-8?B?MkJINU9ZQ1VrdW42aXNiQ1BtTmpGcC9FdHBnZTVPVWZ2VjRrOXBTM1dEZ1Y1?=
 =?utf-8?B?V2lpMmdnQ0VaRnJabDhRZmZXaWhjaWlYWG5qWVJjaVN1WmJkeXlNaEJZYlBi?=
 =?utf-8?B?THh0bGpFU2N3TUkvSkFncEtnOC8yNStxZlNQcnI2SjJYSnRJTzM2SFF2VTBv?=
 =?utf-8?B?QzR5SkhOb24rUHJIMjhDWXUzVFRueTh5ajN3aUVKL21LVHZIOG83S1M2c2cz?=
 =?utf-8?B?aUl2V2s4M1E2NUNyZTBLY0RsaEZMNXBHNkpIbU1ub1BoTFVsYWhsSWEwWGhn?=
 =?utf-8?B?d2xjU3FDQmdueCtRQTdBRjlPS082TGYrWDVQUlNVdXVPb2tsSThiM3B5aHpI?=
 =?utf-8?B?TWh6NktwL0hqZGN5TENVWlJnUUQzS0RpcHRGbG81T0tuVEVhYS9zSGhDZndN?=
 =?utf-8?B?UU9GTlorS094M3lhb0Y3VGN1RVZnM29PRkhPNGZxK0lzSEFpNFNFcVlBMGlR?=
 =?utf-8?B?TWNnbUlEdjQrM2VTNUZsNGRwUTZzZmhKampvVmFHWktBSHY2bkVDVE5ZNzRz?=
 =?utf-8?B?TGdsWm1yVG9naHdRbHoySXVHMFR1a2owbG1VK2NLVnc0RVlGbVd5RG02aVZ0?=
 =?utf-8?B?dzlvTDhyeDBjYUJQS0UwK1VYcVJlMlRqQkhsUUt2V1Z2QWZSb29kTzJKZEpo?=
 =?utf-8?Q?4rR2tEAXsGTc++k9rKp0F4xcd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	llFPhembcZ5xHxdvEr+58MEXNtxcXqwA0gZcgOr5u1jm2A6y4tUatc6GCLiHL+nWq5ex6dpsEoeGaVkdPeOQGPvXh9ogMTnzAC64/+z081tw/Dvow9F+ZtvjlbN7UpqI72Zbk15k75429RQBfp+AmngDgsBBfk9HMIc8Tsm5xnqoSXF2F1b91YFDHv/83Dq+aFGu4+qZ/vz75Wi5a8oNBcUzS/Gr8e4EAr1DhyhPFVAOSYHmBOWb+iXgAysRJufcQxj3cbNwJKqpINzXuIycVd8am1saKUeeyPQEqmJG5lpYpW9+yLYOf/CaLiTA/YXfvmx8L0QcBldggPQpLkmhOWidMUGjCB4U83wDHxFQZXPFBZR10WPWzQegm5OUcKsG9N6mWcRUzl4+2GFhGzE8tpRVAhCJD8/X/WGAPBQFS/jRYl41QGf/HiDodQl6RFSg6hxYIgwe8BL14BFxHi7MwYyJBKhplGSrQVm0WZMuLlzQLCdMiKokVLCEc8LO6yiuOqfG6sUXiK/cIrBhTXOqN3lpO6R7o+ybV7bt5461kqmZQy6+fVJnI/LxqbD33OBGrDv1327TKwgvT45iFGqGVE08/H+HmnyCpGCnxwEhyoeI7c0fqkF1xmzNLdKfSdl8
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c18b78b1-bd58-4b19-4045-08dd5176f84b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 06:22:36.9935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q0VaK6vGeJHuaHwKLZINPrnQHa9N2EY4AfIo33n7uc3E+qEMrO3WHk52KjXNxOVgk9aDs7bukjxGdvdjR0cCxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB6782
X-Proofpoint-GUID: QYbOKcIwM6_ZwTBoyYDYe0SHFJvaMDi5
X-Proofpoint-ORIG-GUID: QYbOKcIwM6_ZwTBoyYDYe0SHFJvaMDi5
X-Sony-Outbound-GUID: QYbOKcIwM6_ZwTBoyYDYe0SHFJvaMDi5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_02,2025-02-20_02,2024-11-22_01

V2l0aG91dCB0aGlzIGZpeCwgdGhlIG1vdW50IG9wdGlvbnMgY2Fubm90IGJlIG1vZGlmaWVkIHZp
YSByZW1vdW50Lg0KRm9yIGV4YW1wbGUsIGFmdGVyIGV4ZWN1dGluZyB0aGUgc2Vjb25kIGNvbW1h
bmQgYmVsb3csIG1vdW50IG9wdGlvbg0KJ2Vycm9ycycgaXMgbm90IG1vZGlmaWVkIHRvICdyZW1v
dW50LXJvJy4NCg0KbW91bnQgLW8gZXJyb3JzPXBhbmljIC9kZXYvc2RhMSAvbW50DQptb3VudCAt
byByZW1vdW50LGVycm9ycz1yZW1vdW50LXJvIC9tbnQNCg0KVGhlIHJlYXNvbiBpcyB0aGF0IGEg
bmV3ICJzdHJ1Y3QgZnNfY29udGV4dCIgaXMgYWxsb2NhdGVkIGR1cmluZw0KcmVtb3VudCwgd2hp
Y2ggd2hlbiBpbml0aWFsaXplZCBpbiBleGZhdF9pbml0X2ZzX2NvbnRleHQoKSwgYWxsb2NhdGVz
DQphIG5ldyAic3RydWN0IGV4ZmF0X3NiX2luZm8iLiBleGZhdF9wYXJzZV9wYXJhbSgpIGFwcGxp
ZXMgdGhlIG5ldw0KbW91bnQgb3B0aW9ucyB0byB0aGlzIG5ldyAic3RydWN0IGV4ZmF0X3NiX2lu
Zm8iIGluc3RlYWQgb2YgdGhlIG9uZQ0KYWxsb2NhdGVkIGR1cmluZyB0aGUgZmlyc3QgbW91bnQu
DQoNClRoaXMgY29tbWl0IGFkZHMgYSByZW1vdW50IGNoZWNrIGluIGV4ZmF0X2luaXRfZnNfY29u
dGV4dCgpLCBzbyB0aGF0DQppZiBpdCBpcyBhIHJlbW91bnQsIGEgbmV3ICJzdHJ1Y3QgZXhmYXRf
c2JfaW5mbyIgaXMgbm90IGFsbG9jYXRlZCwgYnV0DQp0aGUgb25lIGZyb20gdGhlIGZpcnN0IG1v
dW50IGlzIHJlZmVyZW5jZWQuDQoNCkZpeGVzOiA3MTljMWUxODI5MTYgKCJleGZhdDogYWRkIHN1
cGVyIGJsb2NrIG9wZXJhdGlvbnMiKQ0KU2lnbmVkLW9mZi1ieTogWXVlemhhbmcgTW8gPFl1ZXpo
YW5nLk1vQHNvbnkuY29tPg0KLS0tDQogZnMvZXhmYXQvc3VwZXIuYyB8IDggKysrKysrKy0NCiAx
IGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1n
aXQgYS9mcy9leGZhdC9zdXBlci5jIGIvZnMvZXhmYXQvc3VwZXIuYw0KaW5kZXggODQ2NTAzM2E2
Y2YwLi42YTIzNTIzYjEyNzYgMTAwNjQ0DQotLS0gYS9mcy9leGZhdC9zdXBlci5jDQorKysgYi9m
cy9leGZhdC9zdXBlci5jDQpAQCAtNzQ1LDcgKzc0NSw3IEBAIHN0YXRpYyB2b2lkIGV4ZmF0X2Zy
ZWUoc3RydWN0IGZzX2NvbnRleHQgKmZjKQ0KIHsNCiAJc3RydWN0IGV4ZmF0X3NiX2luZm8gKnNi
aSA9IGZjLT5zX2ZzX2luZm87DQogDQotCWlmIChzYmkpDQorCWlmIChzYmkgJiYgZmMtPnB1cnBv
c2UgIT0gRlNfQ09OVEVYVF9GT1JfUkVDT05GSUdVUkUpDQogCQlleGZhdF9mcmVlX3NiaShzYmkp
Ow0KIH0NCiANCkBAIC03NjksNiArNzY5LDExIEBAIHN0YXRpYyBpbnQgZXhmYXRfaW5pdF9mc19j
b250ZXh0KHN0cnVjdCBmc19jb250ZXh0ICpmYykNCiB7DQogCXN0cnVjdCBleGZhdF9zYl9pbmZv
ICpzYmk7DQogDQorCWlmIChmYy0+cHVycG9zZSA9PSBGU19DT05URVhUX0ZPUl9SRUNPTkZJR1VS
RSkgeyAvKiByZW1vdW50ICovDQorCQlzYmkgPSBFWEZBVF9TQihmYy0+cm9vdC0+ZF9zYik7DQor
CQlnb3RvIG91dDsNCisJfQ0KKw0KIAlzYmkgPSBremFsbG9jKHNpemVvZihzdHJ1Y3QgZXhmYXRf
c2JfaW5mbyksIEdGUF9LRVJORUwpOw0KIAlpZiAoIXNiaSkNCiAJCXJldHVybiAtRU5PTUVNOw0K
QEAgLTc4Niw2ICs3OTEsNyBAQCBzdGF0aWMgaW50IGV4ZmF0X2luaXRfZnNfY29udGV4dChzdHJ1
Y3QgZnNfY29udGV4dCAqZmMpDQogCXNiaS0+b3B0aW9ucy5pb2NoYXJzZXQgPSBleGZhdF9kZWZh
dWx0X2lvY2hhcnNldDsNCiAJc2JpLT5vcHRpb25zLmVycm9ycyA9IEVYRkFUX0VSUk9SU19STzsN
CiANCitvdXQ6DQogCWZjLT5zX2ZzX2luZm8gPSBzYmk7DQogCWZjLT5vcHMgPSAmZXhmYXRfY29u
dGV4dF9vcHM7DQogCXJldHVybiAwOw0KLS0gDQoyLjQzLjANCg0K

