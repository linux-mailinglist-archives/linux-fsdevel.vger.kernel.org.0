Return-Path: <linux-fsdevel+bounces-45253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA895A75517
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 09:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888E516FB56
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 08:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51E519006F;
	Sat, 29 Mar 2025 08:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="kAd6Mema"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E47A39ACC;
	Sat, 29 Mar 2025 08:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743235700; cv=fail; b=QjwHEEVk7YbVD9llB8XDv/EbdAnFBHjck0J77Hp3Dg9/tf8v50l5+7fyslBGfgRDtNr6P0tzoWU0KBQHKif3rcAb9nNmMMSIg/ata0nnrHs2iEL65OKJjDO7IF/zBJ3f0eoTaOtzBV2LXvtZVY5BWfRpUM/zuJbYpl9j/WvLav4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743235700; c=relaxed/simple;
	bh=5H2q1JwGhnJGk7PlCN6b1q2Gjz4BX0h7RAnR6ylMq+s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b4LohU+82cm7SY6BDINVsMzD2o7JtFvh+8oKBGq4z2jS2xqfUTDdnd2IjJ9SF2/fIoXPjKI5Lh47xE0QacIsUXejiNHX+Rye8j3FPINmui0Eu4sgFWssPHAqqFolpqG5Rtq4V3XSbu7Wp0ND8tlgG8a2VyG+U06f0+oD2qCu6NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=kAd6Mema; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52T7iNl2015781;
	Sat, 29 Mar 2025 08:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=5H2q1Jw
	GhnJGk7PlCN6b1q2Gjz4BX0h7RAnR6ylMq+s=; b=kAd6Mema35bA0OtlHeXhbqp
	IjrMPrjhXqTGnj9W9/cQJ+B6MDJZPORUaLWKzGfHu9QlhQ+Jb82eUJc8b0iP+zTo
	tKSdUyP4LCzo/soslUzBIqSm7AEya2Dh2VWmt7NYU29hXWO828xrOoJAoYLaEAwz
	JVR7WZnaOJ2TUjvBehcj+6vQV4kcmDbIG31KzQ0UdbcR05IL/WW08WF5x4DuKhP1
	FMCIRIleNwRoEG8O3jB7iUmzdXZaPn06CAB27J2BX4+Z2Uhra70KT6CnwtQZ0WUU
	naR3bzB5aAnGe3h31+TMDsh7ejL1PWq0vdA80QZJVLAzGrx60VvK5eJ9S4vHqpw=
	=
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sg2apc01lp2109.outbound.protection.outlook.com [104.47.26.109])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 45p7n404fa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Mar 2025 08:08:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7HBhz72fGflbkTs/k5octorTBr/yzY0rsBNnTNnb+jg7pKqU5No3zbE9DUYl2FSPnEZXqdhcozXGwqIOk5BeptXTbld1Eq6uTphV/Lk5Kj31qsXxxNhbcBYuQRavj+xCrop8TvncIDm2t32lCiFf6AnCwDccNuM9CKthRzk2shklCFAvetynZi6crYMSTJx5TyeWHYFF27v1TDzuZrez46izov6VbdLlVUhgLbEy3/CbImdsvCqKByE/UvETf2tPTOMcGxfNFLugMzEpJ0lukfTJ+/cMGEcZr+wVX02nOO87HChqJ53xBRvtLcx4pG12EYWK/EUtXjFy1jcKnvP9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5H2q1JwGhnJGk7PlCN6b1q2Gjz4BX0h7RAnR6ylMq+s=;
 b=ukRb+quRuU+Yu8rQaq+RsW8kzCaopdER933lDtAxo/5vOdqsqoVVVvndjyWVIcP6Cv8xW4U578jgFd3bDeEx2bpU6y/DuYnC6WwJV8PQfMw8W9wLBUhHP5LigrSehm3KidRAIigbOEzMcaQE70A8BQMwJw7B2AOt3reqjHXhb6LYSgz+bCe3FGgo/Rq2E5qeLDvfauk0lu2roRzyWc3Kow7hReUifrCC7MBpbPgiBA0KaKnuyXIc+iN+REdT5NkKWg3sU4N8rFNbJF5HAOnyoS4YpvM+GIqBkWOowI+Fdxt1Bf9y/nDMRLTyIptG/ScY48uhPMf00+1lyP+QdEpkEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEZPR04MB6875.apcprd04.prod.outlook.com (2603:1096:101:ef::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.34; Sat, 29 Mar
 2025 08:08:01 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8583.027; Sat, 29 Mar 2025
 08:08:01 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Sungjong Seo <sj1557.seo@samsung.com>,
        "linkinjeon@kernel.org"
	<linkinjeon@kernel.org>
CC: "sjdev.seo@gmail.com" <sjdev.seo@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cpgs@samsung.com" <cpgs@samsung.com>
Subject: RE: [PATCH] exfat: call bh_read in get_block only when necessary
Thread-Topic: [PATCH] exfat: call bh_read in get_block only when necessary
Thread-Index: AQHbnmAEUW1nGc9YVk+7x5zKML3nzLOJxnEw
Date: Sat, 29 Mar 2025 08:08:01 +0000
Message-ID:
 <PUZPR04MB6316C3B1FE49DDDF3A1C2CB781A32@PUZPR04MB6316.apcprd04.prod.outlook.com>
References:
 <CGME20250326150136epcas1p3f49bc4a05b976046214486d7aaa23950@epcas1p3.samsung.com>
 <20250326150116.3223792-1-sj1557.seo@samsung.com>
In-Reply-To: <20250326150116.3223792-1-sj1557.seo@samsung.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEZPR04MB6875:EE_
x-ms-office365-filtering-correlation-id: 7487b478-5f2f-4c79-ee67-08dd6e98d30a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YmNvVEV4amlhaDJhRDdMVkVoNDZCSVkrRUJtK29MencveTVTS1BFekhVOUJM?=
 =?utf-8?B?TXlnUDZ4UVA1TnRvOVUxUzNBV2dDYmFrS3VKTzZ0MkZ4bGV6aklhOTVPR0Rw?=
 =?utf-8?B?YUxCSTV1WnJ0YU5Nd2N6VnpXelQ4THc0b2tleU9ZcjFkL0E2OENEbC9tMURS?=
 =?utf-8?B?QXJPM1hRbGRFRnd4a0JIVm9jaTg3RC9MTXlaR25VTGZJeXBlM1BTeUFld1Za?=
 =?utf-8?B?K2JRUnMvSG5qUW8yL0pRQVVHV3VyYjNQeVpiM2tMcmdaTjdMeUxZUmNiUUpL?=
 =?utf-8?B?NmV4NFlMSmk3bi9NL0ZBVmJwbTUxTEF6d2g2RHk5QjlFZ1VHbHZkM291QXhX?=
 =?utf-8?B?NUhQNU5sZ1kwUzhxZ3lUeldzOTFxM0NwOEJ2cEpyckwrVzV3K2dndFBPY0lC?=
 =?utf-8?B?RmJkRmhnT280VTRzMWgzdEhxR05zMy9KUDhaYXhuREovYUhKRGtkY3dMNlFw?=
 =?utf-8?B?cVpaVkNCbCtJZS82L2JEQ3NxdUxEOTNIMk02RVVoNTE2WWM4ZjdnNm42N3RO?=
 =?utf-8?B?alBuaUhnRy82YnN3MWdLSmJTOThVS2lYTE5aOXNialBjVVRoVDNoMVFMWGl3?=
 =?utf-8?B?M2gvN1A1Wk1GNnVIdmhzQTMrSXUyTnVHSjNBUHMweDc0ZE13NUtrZWp6UVFN?=
 =?utf-8?B?dkhXQmxSUUZNSzZQYXBUNmV6ejV6K1pwZGNKVzUxRHRtMS82U1VxaUM5dFpD?=
 =?utf-8?B?VXRzY1BUMGFoL2ptRENOOWJueDd5dVZKQ0VqMkFCV3orYnd1RFdzckR5Zm45?=
 =?utf-8?B?S3JiVnROUmluVlVteWlOVzlGY1VPZDU0TG44Zk5GbVRZSktxbVltaEJpaVlX?=
 =?utf-8?B?OTlYYWlPVlljTnNTOEZFbkF3RGg0dDgxbUVlSGVVT01jdk5EVkF1NnhtY3dN?=
 =?utf-8?B?eEpkMEUwb05ROUJPenBPdGVDd0crYi9HcTZyV2orVVJ3Q1c4cFBrVy95UktS?=
 =?utf-8?B?ekFpTGdmbzF4WTRQS1Jod09zY0x3dE4yN3VETjJacGh5UzhLbTIzWXRmeEM4?=
 =?utf-8?B?YVhXRnhmSlptMkdiMktnSGoyZ0NGK3pJMEZBWkp1dW02YzdPeGhqL0Y4MkRJ?=
 =?utf-8?B?NWpCZkp0VHBxaTJmYm0rWjMxcWpKVVRrUWJ0VE9rbUxvczhpR1BaQmpIdnRh?=
 =?utf-8?B?ZGp0cmlYYSs4c1gxak81MzI4ZmxuK1RrVkpDSDhUN3NKWHJIMnFjSDdVVnlx?=
 =?utf-8?B?K3BpSHN6anpyTTBGbWZXcDJ2cXREM1o1QUw4a2pnN0FUcVZWN2JMRC9SUW96?=
 =?utf-8?B?aFo0VmxqZUxROU1lWHlFOWQ4Ylo2RWNzUWdIM1A3SWlYcmM2czRWWHlIUW9q?=
 =?utf-8?B?WlB0b2xKbnAvdmpickhCQlJwRGNURUJOZWpLRkRoUzJsQjZLZi9sNUtWTUtQ?=
 =?utf-8?B?ZXRmWEowY1NRRHBxOXM5Z0src2ZVM1lUN0lsbERXUWRDQk5Pc0p4Zmc2U2wz?=
 =?utf-8?B?NWxOL3hHNjVOSjR6T3lRQ1phVVRlMy9udE9jUGxMY3pHSEVKTHNDVElxSVB3?=
 =?utf-8?B?d3RubzNKQnhPT3F3Nmw5VzRWbWo1RmFhNzNMVnJ0cVliOU00bmRKRWE1Qlly?=
 =?utf-8?B?UEZYOUFQUnppbkFrZ01ib2p2S25PcDVjWWNyck9sZkZRdm5tOGxGU0ZKc01X?=
 =?utf-8?B?eVRrM1U4OVlkV3dhWEVsN0FyeGRIa1EzckNtVFpxeUJDWHVpdmNxZHNpWlRB?=
 =?utf-8?B?b1llU3ovYzFPYWUvdXF1VE40UExlUGpUVTVPQVdEbWMrR0w3dUlyQllKU0VH?=
 =?utf-8?B?MHJNU29IbHhMTGZTbGs5c1dWZldndDRZTW13Y3o0TVpqdCtNV1dNVTZxZDVI?=
 =?utf-8?B?T3BaaFAyVFowSGdkckkrQ09GRm8vNW9GSWRrV1BRcjczQWJzWm1ZazlIQ2lu?=
 =?utf-8?B?MU4zZk9nRjdBMWxMTVd5QVVzU21VK3IzRDhyUlNhN1Jqc3oxK1FldlM2a3Qz?=
 =?utf-8?Q?6EQ6wv2/z0OuW7k1QMUVxN2P9skvxN3X?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TXdzWWxPU0EwdUNGVC8wVHRIQVFrY1JQOXpKZDRLdjFkY0NoYzdTV1YzZDNW?=
 =?utf-8?B?bERBSHlkc0MxS0IzT0tzQW1tRzAyeUxPQUpVb0QzaEI1dGhibWs0RkdHdWY5?=
 =?utf-8?B?UUx3TDZra1JpZTF1NkFmVEI2SDRuUlE1cnRKQklvUEpGVFhkZGxXWExOdndj?=
 =?utf-8?B?Q0NWRUpEQk5RSlJ3VFhRM2htVWwrdVM3TTlDclBvcmhSNHgzRzlqQUlianVQ?=
 =?utf-8?B?NHZiS0k1Sis3cVR1b0o4UEIrNUtxUGtaOGJnalY0TThMK3VFcFJjcEpYOWRI?=
 =?utf-8?B?RkpjelZiM2g2dTExSFhIQ01idHg5U3ljclRZYmY4RTVpU0JrdkRuZWQxQU9L?=
 =?utf-8?B?RUdWK2xLbjhXOTRDUmhBcG4rcW4wZzRXM0QxemlzZHZXR3BYM1UzeFJsUnZj?=
 =?utf-8?B?Y3l3TGY5UFFDdG01SHJ6Q2E2bDY0djkxeGZydEl2WmZTci93Ly92VTVaZGc2?=
 =?utf-8?B?M1k3cjh1S1oxa0VFR1c1SlhMK09ueWJ2NnlrTDV5eEJrQTVaNFNKU2pvL1ZH?=
 =?utf-8?B?T1YwT1owNUYyUTRiMjQrWlB0ZENKc2ZqOWJPV1d1cERYcmRtSnJQLzNQcExV?=
 =?utf-8?B?MDRoMjZ3SUdtcWJFbU52MUJmbTF5TFM1eHpFSlR5Y3c5dENJemc4K0xzd2NO?=
 =?utf-8?B?dG1kYm1icFBhZHdVZ3FYSUo3MlBQNURabjNyR242VlMwd1Jpa2xPVSsvc1lG?=
 =?utf-8?B?SXBnNmZoZGNTZnJJU0hvYXIrVkdZb2NQRFZaZ3MxWUlwZTFWcU5DK0xsd3JT?=
 =?utf-8?B?Y0p4QmlaR0EreE1zRmlaTEVEWjNiclBDMHJZVHJUWmFMVXhkcDV0RmRGUjh0?=
 =?utf-8?B?Z040dk90T2JKUVA5cUlsTGRKNmc0citLQTVkRGNnRGoxOE94S25lVGhad0Y1?=
 =?utf-8?B?R2tWYXlFL0hmV0NyM0R0dmxsQ3p0MDVNVUpHSTN0M3plREJOQzRHNmJueGdJ?=
 =?utf-8?B?N1dMV3RpVEt5NS9rY1Y5Q1g0cVhRSjd4YklQQmVkd1dMcURaYUs3ZjR2SmJx?=
 =?utf-8?B?T0lUL1hPczVjcjFHcVlWVFVQZkFYL3pYdFJwVXNaUmJja2ZXM0MrbE16aVVv?=
 =?utf-8?B?SWExTjdGcEpPSkNtNEk3Y2xGVmw3YndHeXRFa01iaFV0eTJjck05NWFtL2g2?=
 =?utf-8?B?TE9Ta3hvdm1kU2NWODhNTStmb3k2OUJZYi9SVXJ3Tkt1WmdFM09ad0pCbFp0?=
 =?utf-8?B?R0U5RGFJT2FEamxXdmZUdTliR1UvNVIvUjZpWFdqa01ReFNpbjFUUEdhYXFz?=
 =?utf-8?B?alhRbHZhZU5iTUN6VTBjSjRBK01JZkNwNmZKNUNNYTFHcjBmNzh0OHo3elcx?=
 =?utf-8?B?RG1sdjhiMVBhWlFLSXR0YnZzMElDYzJyZzRKejNyeE1pOXhxYzNLLzQ3Mk1K?=
 =?utf-8?B?dFN2bVQ4YkQzajV1TDEwSXpHTkdUV1UyS21uRTNmSmZ2S3M1SzZtVEVSVExC?=
 =?utf-8?B?ZW5DRWUyTUNhOGlmNGZxY3dxVkxaeDVCVXpNQUZHazRzck5uMmd4eEtZUmZi?=
 =?utf-8?B?eWttMjlFR3RkYytpb3FNQkdqMzhZRDRSdkkvaVFaVUxWWmZDbVBEa3pZbitS?=
 =?utf-8?B?ZEp4VU5TdzlQVi9WZWx3UVJpdll5R1ZBUnVlL3pLeGpPZnZUSnBiOHVCUUF6?=
 =?utf-8?B?K0hBRzhvR3d0QmkrVWl4M1hBbFpvN2xEMmE5UjFnazh3VkZvWWdEM2d0VTdq?=
 =?utf-8?B?QTlBZ25XdG84eTRaSUFlSTFrbmxIVmM3SUFEN2NTa1FNRGtpZnNEa292TC9P?=
 =?utf-8?B?RGFXSmk4bDA4NmpFZGNZVmpSRXMyZzdsdFZVNVRDUW1aL1dFQmJhY0FHejFR?=
 =?utf-8?B?N1ZBV3I5WFZaNFlaNFlTbE5mUXBmQ2JjWW81QVVxOEFZdDVsZ08raUZVUExW?=
 =?utf-8?B?bkVIT3RmTitkYzNHeHBNRThWaU9McVNzK0hSVWs2R2hFd01SdEVnbnBqMHpT?=
 =?utf-8?B?aWVWK3BreWgxUlJoQlpQbFVlVDlJVUh4YU5qYWNaM0lRVExYbVBWQ0FiTkVQ?=
 =?utf-8?B?OWZzQlE4YVIvUXQwUE1KRlV2ZFVqaHozdGV0SVZVOG9ieUtmU1M4SDJHb3BB?=
 =?utf-8?B?c3lBYmRyN0dnSVJsYXl0VWFlZFprQmxGVGxrVFBhaThsSWVReGlqSUNyKzVL?=
 =?utf-8?Q?CCXJSzJkHHfYxpJJ2Izckl7gS?=
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
	i7xy5NgvlqDN704TNnz6eERusEw/pDs2v8sM7zCoxDHhMQK04BLfyj0uTFj/04kuCnzOrWEDj0R2gso2X0mVvQ16ExNDbO/Hdex+WNEyd1HsWN+L+DbzXGCdVRM4qIityBIAHpW48NFljW9hXCzizHELd9y2eay2mvTCHAspTnuqI6aKvCftCKwkvRev9BbUVenYdG2KaOY6P7eUqdCfn/9+Ek+1IanAYbGOlyT0uqruTC0zlXolLNyTGpsFJj67CfbrneAQ1+OA2J8rfEoK1avDMBE/u90BXofd0QQKnfzV0tg8dQB2b8H49kc6SuBT/F/nklkgjum6lmD0ZlW+N8Oe2dH2tKuaaoDm9ZTyuKaCV2AqzzZM6kd1uZNMvFLRMt76sT5ZlipSnaOTp6zcSWP62aug2N9fOn+MvlOXib1CcaCDW1sCaV86QFDgS/45YO3MOv/tpEb4mgRCyzW/GAtCZXKhr89qe/LswXA5v73I3Nxik8p5YmZ7yCuFq7QNCbyOfEaQqBsCwRN19J7RWmIYunH5hmjt+fVE/WLjhPbTxXGZeutA2yVBWpl+eGwfiqZ4RnLwfN3dBubj1+fthE3qm+PB07hNg4I9BH869nJoiU39K6905nhV6IW1VKR6
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7487b478-5f2f-4c79-ee67-08dd6e98d30a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2025 08:08:01.0948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FSOqexgd0hTpig+2MzaKu67QmkQG75O4g78a5eXrLwAQ7C6KkW/Xk1GpEh+zBvcGwTHzFC7SyK21z7LPhIb4sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6875
X-Proofpoint-ORIG-GUID: IcEuBgoI4xv8L6mkq9uiSdCEtSjyKRaG
X-Proofpoint-GUID: IcEuBgoI4xv8L6mkq9uiSdCEtSjyKRaG
X-Sony-Outbound-GUID: IcEuBgoI4xv8L6mkq9uiSdCEtSjyKRaG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-29_01,2025-03-27_02,2024-11-22_01

UmV2aWV3ZWQtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NCg==

