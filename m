Return-Path: <linux-fsdevel+bounces-35055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1A29D07B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 03:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C20EB21AEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 02:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0215317993;
	Mon, 18 Nov 2024 02:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="M+nxLrVa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8571C2AC17
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 02:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731895355; cv=fail; b=aTRbv1WvhvjUSQ8XaHL66jY5KYzQDaj86n5lwXlC9zs0bowK7ODDBtE+Ms8AvqhORXqZdRiLmDzzoWBcw+ME5gqHZukvu7kChs6ZcoXmJoSZGric92nMU1WvyCtj6Zi5srdxm6F0wFIrdMqpqbLU8NEcGpJmeeBAPYvMWebACXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731895355; c=relaxed/simple;
	bh=vryzNcwLyfZVGYRl2uswP1MxTcdF2jankqCdCx3klrs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mJOdTHhGP8T36d9xZZUyuX+piTKXhJyZPf0D3F+htp3KdR4uj9evG+CNNHfiBS0zEZzwglrDD8U3M5SYg31zBmOFob5cDH1mp19cFv2Mi1U2Oid67Ag1lxXtHi+pWcwOWwtR9WRQFlnpMOgnUdygsdrUpdIJBAwIRv/PPQjday4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=M+nxLrVa; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AHNOHjd007526;
	Mon, 18 Nov 2024 02:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=vryzNcwLyfZVGYRl2uswP1MxTcdF2
	jankqCdCx3klrs=; b=M+nxLrVaLdTNDFgYIet0wvcW5D+0Xx+HIF7kH4/wLf/Sz
	RfoTjUUDZoANTEIRB7UWRiJRE0Q1vxWNMmOTSYm7nOrXHJ86IR9pQljTHX+yC+TZ
	8ngwPFzQgRMv4v50tW7AjrkEbJdg0eSYZfEYLJys9sds16GLraPHhGiHKOVZPHrD
	7eB5bpY6N5DphbhqvdGncucf00ss/q2eV0FKaQAe4cx85ib8gcC7ngW6TUkbaUmq
	Gae/yI/dOZdvdHnlOk0B0fNlLUIl4auGgq+4CPUT104UoADETWq0mk59LxuCZYb/
	SO2co0hAsPx6aJvjcxgsTQr/IeS81pWALOwBf/Z/w==
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2043.outbound.protection.outlook.com [104.47.26.43])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42xm9613ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 02:02:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHCoT1BfWSNC+ICfwcJghql30kL/OPgYbXcpmRLkp4wy8d5wUY7szJ+hdEyAneNOEfxA5smdLNlAh0BGPo78ecbIRlcBjd8u4ktUitfKyyyUqgo3Ke5OGHugUaGNgvwXBzCFAsvNSjihIJg7kR652UHmJKDKqFYmzGem1KDg7KMoXM6yxa9yrxaHXzQqGyy7vgwoCShzfVWACo/BCQA38TukfvyK3rJTwVZZSCFuYaBVwADao/5Tr3sZE+OPwqJctjq78ELGI+D6mj/N8XhxSiQHVvLOxGOXBc7IO4M7NQwm65URoHOUW9f9JKanPn6o3Gn/7Xa90YikaYSNm4YImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vryzNcwLyfZVGYRl2uswP1MxTcdF2jankqCdCx3klrs=;
 b=VuaMCc5yuYmmORPr9i8awN9zMlYgg/G9LhN4Iv3dStOwMX5tx8HkwpLe8w1yepR9AWCYLUhZ2fOs7o81QgPmu091ilbSBAhEoWrSwSFOX0/Rw75nMqHw0q/IQDTeLGUusU3/VZvOxKHDfYnw0qEnvYSSQzC55qfohiPdt4kMuexRazEcKZpBxsl7tJ8ZigAswYxq0lZP4tSAWUp40G86O22SMwO3LQjS9w4FbA2klPuJ7MvyoOwH/UR/PSI1KRVyjkOY50GEj284ZrMGRgm4Vv6GRtmTWP8F2Q142v1RtFXIKZirIZ4ChzfRdUOEIAQRR/xZAItVGOiztASsl5eOww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB6119.apcprd04.prod.outlook.com (2603:1096:400:258::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 02:02:16 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8158.013; Mon, 18 Nov 2024
 02:02:15 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v3 6/7] exfat: code cleanup for exfat_readdir()
Thread-Topic: [PATCH v3 6/7] exfat: code cleanup for exfat_readdir()
Thread-Index: AdsE8yC3W8n48hAWScyp5o4nMOvEXw0aeInQ
Date: Mon, 18 Nov 2024 02:02:15 +0000
Message-ID:
 <PUZPR04MB6316B55B3B74A4B950A6257F81272@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB6119:EE_
x-ms-office365-filtering-correlation-id: 3168202b-b137-4f37-61dc-08dd0775068a
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SXlZbXI5TG5LdDZ2MnplWm5Zbk96WDZHandHVnlKRGloSzRlYi9pbDdrUW55?=
 =?utf-8?B?T0oyZmkyNVlUc2Z3YVkxM0Y5Qm9YZW82VFVXdUx3OWNNVityYTdURUVGNjVZ?=
 =?utf-8?B?d2dUY1lOZDBtWGNzaWtqY0tvUHVGR1ZueHE3KzMwSDFUQ004T2N2TXkycmdT?=
 =?utf-8?B?OWpOQnRQcHpXUkpPRXE2WURhWENFd3lhVm9BUkptZ21yWjAyMHdMRTF0OUxJ?=
 =?utf-8?B?RWl0ZjZrWFhYeEYzeloxN2hHSk16UHZEdmkxcmlpbUhsQUJiUE9scmlHdnZD?=
 =?utf-8?B?Z1JzYTEvOXZ3QzEzM1NCSGluRzJMN01qVEdDK0Y4UUJ0dU1RRFM5d3JJRERn?=
 =?utf-8?B?eE1uOXRnSW4yTEg5K016V2ZicFlFZXdobkZRWnlPOXRKamwwMkxLU1hwWE5m?=
 =?utf-8?B?SG8vb09PTTVZOHBCSDJWbzJ1V1JsRG01eG9rS0t3cGk2SjVIdGJMZkk1NkVj?=
 =?utf-8?B?clpDMFFyQ2tmVGFHbmxQRTkzS2JYenVtcWozd1lwRE45YkZxMGZKamVnS3pl?=
 =?utf-8?B?NG5oY05Na1czUFNmeHlpK3RocXZVMmU4bTYxUnk1WE5lbEN3ODJmQTRvRE0w?=
 =?utf-8?B?cTRMK3J3dno4bXQzY201cVNaSlVhN0xHblRnbHczdUYvT3ZsdEZWdHgrMksx?=
 =?utf-8?B?NzRnYUpPbjhTRVp3cHhxa1FkNUw2enFBeWYwK21xRkNkdXdSTUVCWEN2TFBC?=
 =?utf-8?B?dmJWWUhtd2JJMEJFSmVnMzlzTTFiMFhDQjNudXZXWm9ibUR1dFpOUWgxU1RV?=
 =?utf-8?B?eTJKQXA4Q2c2Z0NNWUFIU2JuNmdtOXR4a2N5WGhDNkRSM3BCb2p1Yi9lZWlT?=
 =?utf-8?B?cVYrcEZ6cjlVL3VsOXVDZUlCQzZFODBpdHRxbXZqYW1nNWdHWjAyNG5ZdXNE?=
 =?utf-8?B?Sks0bU1KOVRyVHBUaDg1eXBLSUpiQ2NkNWhEbGJQTXFJOHFGcG5NTUJMaWd3?=
 =?utf-8?B?N2hqRVpmQksvWEt4V3lLTTVmUG5XN1hoa1FSYXowam91cWFncHhSQTRCSy80?=
 =?utf-8?B?dmszd1dPL29xWGROVnVxc1dGdnl0Q1RVb0R4Uk55VzdQczZjYTBveEdRellt?=
 =?utf-8?B?OTB1VmZPQjc4bEYxK2lFS1lsbXJUYTdoZWRwVFQzYWYvSlEwOGFxR1QwYThm?=
 =?utf-8?B?RmhZQzhGN3lRNXB6Tk1sSGtiek9DNkF0aU1BRzUxU1BNY1pMbVNRWTR6WmtS?=
 =?utf-8?B?VUFXTnRVOGw1S01Kc0RNSFJMc01hYlRVaFBla1lMZG4veGxxek5IeUFiQVNt?=
 =?utf-8?B?OGJyWHVLd3NVN0lnckRNMk1zYWU5djRoK1JxTHBWWVV5R0hsOEtqYmE1Zzls?=
 =?utf-8?B?YURsZkhQWGVGaU9IdEF5dyt5TWRMaWd6YTNIVTlVaDNHcXB4Z3NWaFJFekpT?=
 =?utf-8?B?YkJFSjVTOGJiOG84bnZLUjhoaWthSXF5ZU1FQ0I0eGdpUWdGMlY4a08vL1Ry?=
 =?utf-8?B?T1JXRXZBbC95dWhCLzAwejNwT2pqUW8wQUxEdDVLNzRCWTVvZU1VQVh2TUVM?=
 =?utf-8?B?endkaUx4Ukl2MjQ5L1loY3ZwRjFxZ0VHOTdJQzN1R0J5OS9JVVBLOUgySFJK?=
 =?utf-8?B?UkREMFA0VXBkMkZBUlM4b1o4V0dqOUp0QTJyVW5yb0dzTlN2MG5SUjIwNTBQ?=
 =?utf-8?B?SUhRa21uU0RlejAwdjVBQjVIa0FsdzFaZTZTcy9CL0VBVEgwRU8zL2dRSCsr?=
 =?utf-8?B?MDNZQ3kwY2FVYWhHdmxlTWdySHl1RHNoLzg2YmFFSTgwbVUxcU4rTTVWOXh4?=
 =?utf-8?B?NFZIVHJOZFhlclh2Qlh4RS9BWmV1RmJXZmpEOFVET0hoT0o0a3U4UWJ2QURK?=
 =?utf-8?Q?KehKG3BpGFyCsBKBfetc6Vbab+Z6HPQ8NQYp4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MUdiVnAvSDdEbCtGUDk1bHA5QkhiUG85bVA2QkhmcDc0aHdVYkhlSzJnQ2N2?=
 =?utf-8?B?R1hYRjJCdlpHVUJLSHdHb0RybXZROTFiT1lZZzdyWUd1MmY0TWNCM2c1MFcx?=
 =?utf-8?B?WjNUUytvcjhwZitRUDI5eTJXSEtZUXYxVEhjWk5aaW9GMFEzOHdId0VsNEdv?=
 =?utf-8?B?c3JSUDhMS3pZS1ZjdXUyM0dvVzdFQkJHV3pBb0JYN0tZRDdjVTlnZHFJazRp?=
 =?utf-8?B?Q1lmZHVpUEtjWlVmQ2lwaG00UDFBaEFmTGZ4QzlGakk5a2h1T29LSmo1citI?=
 =?utf-8?B?bnpsR1BUQUpKWktEQnZZV0UybXVkam9NS3ZFcHFGTHBHbzcwQlAwanRhTU9o?=
 =?utf-8?B?bGlIaWtCS0pJa3ZwNE1LWW5sWXc2aU4vZEVlSExTbnV0QTNwelJZOWlRVjA0?=
 =?utf-8?B?b2ZQOGdIYTF2enh3ZzQyRzgrdDFyQkY1dXAxUzNydFBMNjBqYkRFZ21tUlhT?=
 =?utf-8?B?V0xHU2dFNG1qNUwzNXNVY25JV1UvT1VBaHdFTWlrTUVQeWxVTDg1bU8wVVlt?=
 =?utf-8?B?bDNUclA2b2t5RkMvWWdnWTZoNjdWTHQxaUhnMTVqUXdtUkRpemRUTExRa24v?=
 =?utf-8?B?NXNYUUVpeDBFSWVwNEkzRHhhclpJMVh0Rm5tRERHM2tGNjBzR2JLQU1QbWpV?=
 =?utf-8?B?UzRlVWQ4emFiZkQ3RTNXNTNhdHJRRXIrbnpmUlNqSWYzVEM3YmNHa1M1RDJG?=
 =?utf-8?B?bUgvL0dkTzh1cm04LzRKZTEzUkZrMUxzVFV2VzlvbU1TSlNreTlyVW1mK2RU?=
 =?utf-8?B?ek10b3hDWGEzUnFSZHBsS3FYU3VBTkZZeU10QkNOU3ZsQkVMK2Q4RnAyQ2J4?=
 =?utf-8?B?NlRJUmRSMFB2N2d5N0Y1ejNYbnE5RGZ1MG91T25PVTA1a3dTaXRhVXBWUUFT?=
 =?utf-8?B?cFhPS2didlRFU081SU1ETVhmdUNSeEp0b0VLelhOUjE2dDNUeTRmcC8xQzZM?=
 =?utf-8?B?Y2FwUEo5R2V1L0RqWThUMndBT2NGYTVlUHFPYm9HWHBnY2JzbElyZmZxcDFm?=
 =?utf-8?B?SWJSbThMQitVOHdWaTZ0d0gxRnkyOG9ZR1BaMVppUldWV3pkcTIvNG1pMFNu?=
 =?utf-8?B?WXZUUTAzdWx3L1hJSVBBbWtLQ0lSNE16WW0vaXBZZlZsVWY3YTA0azlSTWxF?=
 =?utf-8?B?cGh2MHB1ZW5VL0NYY0IvbytLU255WDVkejl2bDNqRnBxZ0l1ZWJTNkZOcnNG?=
 =?utf-8?B?UmlnMHVjaGE5Wk5ma2tCaWowSUdKdEpPWmNiUEQ5U2Q2UitEeDVDR2hhcTJh?=
 =?utf-8?B?ZVZ2M3lPVnFWYTdqUWxiR1QyR0w2cWx6dEdrV2l5dG5BcytoZXAxemptdWE2?=
 =?utf-8?B?UnVWc0FGZDhmdDlpeDVDK3JDV00yQ1RmTlloZHIyWmFYN0xMSmZ3TnJUQjU0?=
 =?utf-8?B?eXRoYWpRUG5vV3l1NUJKL0EwY0dmSlVlZVl3REJHUUVQRmR3c0RWTFVkQmo2?=
 =?utf-8?B?R1Q3eXBMTDF3ZU5EMVJ2UHNZcm85Z25KWHp5aDZYa1J2Nm5WclhqcVlmamZT?=
 =?utf-8?B?emdDbmNDZWh0a3ZMemM1dGVKOXBhaEloRERHSURMbzVuMVdxdjJHeDlRbHoy?=
 =?utf-8?B?THhDM3VmdEpaQkxSRmUzMmxvSDNGbkdodExxdVVFSUY5S3pTUTl4M3RsV3do?=
 =?utf-8?B?WjQrTkd1NGNOZTRQT1RhMEFjanlGUGRzRS9qR04rZnlwQWJZS2tJNDIzdEpZ?=
 =?utf-8?B?NCsvamg0UkpNUi9xaWNkSEErekZGMEVHbFRxUTlGVHNSY0hpdC9adEE5WmpD?=
 =?utf-8?B?S2hLbHJ6UTNIdW1JYkZ5K01BZlpMMnJ4SDRGVmprTXVnMkRDMGhqZHk3WTE3?=
 =?utf-8?B?RlJtMTQwZS82ZkNzTHluYUV6VVFRMzF1ZkNDWUZYUUhMWHVvcWcvWFpmYzVz?=
 =?utf-8?B?elVQQlh0anZseUFyWFRkZTZpeHJEWmZXRTdoRjJOM1pHeXlLZWYzTElSdGdj?=
 =?utf-8?B?N3N2SFRPNEpFVjYxSi9YWUQ1MGNPczFUMm9ObjNjZE9FdEticTVpcjB1VXhT?=
 =?utf-8?B?dkhMWUExVXBYWlBwZVlVR0w2MUxZWmhzaGlkaEJCSTFrMjMwV3hmbjZUckpC?=
 =?utf-8?B?U3VZK0FVajdJSnBZUWdBWmZBMjRNNEM4SGxFWVpLR2hmMGVtemJzdEJWaVpa?=
 =?utf-8?Q?2HRJeCweYsAwbw8LQSkqjY+uv?=
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
	rlW5V+xh3sOQ9HH5VZ01iSStFLJ+lNdfqdNKPrj8gdD7v8UqppNPBC7aYbiYJxKl9yLVWdM83VZvmSPMY1LAibHpYCEE8SQYJvgU38H50+kkxE47Xgn+J4gq91Z2d4I9MeYLnmpkAaC8+vuuCuPpogj7vKBBu87rmVpNzMnnVdECYAKdYkoO5KeHCkfkjs0T2Umlu7I4Q81qpHIEN7UbEuZb4mTHq/y3iyTHtFFxnrm/gKp5uNPdQjHdo3PevM/Wzk2MtrOgX0LuG+dWFhwCp5yh6Y+JZ6AMs/pByjXfwDIlfTKxZRjT2t/F4gbeJQtVBMJbRq3B+XqeEB/Yinbg7jJv0IBlM8HrJt1WA97lPG+6P2gV8kl9C1XcrcHQnxpj45hX/g1QRqWnlLZ5/Lvx0qKFIwoyun1W+WiENMdlMAuJOxbLUu5nzGxjFl43eoft7eAN+YuEWYPbsHf1Z9F9au+7rUGY0I5ZZXuzKsEqvHXBkNP6E1dyjnjSToBUe1VlVhHm/BGm+ogFikVBSP6cz2rdEAF4H/KV90ewVc0o6Xx2vVtShRsRD+RsSVVQ5mkJ4WxsssS5IpC2h8tLZlxrk8MFtecTLlOevAczVTpUQR/upMnwBNNewSiiRxCXEmvC
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3168202b-b137-4f37-61dc-08dd0775068a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 02:02:15.8546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VaXnK+N1TntRb10T5bzQI7RjHWhLJKWj+NTxkR12L6fKANn77lrLb06n6T7RJejMmpv5dX7/DgitCO5D1go6mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6119
X-Proofpoint-ORIG-GUID: DnhsbdQ9ay1tw4QL6QQH05YQP4KbeCLd
X-Proofpoint-GUID: DnhsbdQ9ay1tw4QL6QQH05YQP4KbeCLd
X-Sony-Outbound-GUID: DnhsbdQ9ay1tw4QL6QQH05YQP4KbeCLd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-17_24,2024-11-14_01,2024-09-30_01

Rm9yIHRoZSByb290IGRpcmVjdG9yeSBhbmQgb3RoZXIgZGlyZWN0b3JpZXMsIHRoZSBjbHVzdGVy
cw0KYWxsb2NhdGVkIHRvIHRoZW0gY2FuIGJlIG9idGFpbmVkIGZyb20gZXhmYXRfaW5vZGVfaW5m
bywgYW5kDQp0aGVyZSBpcyBubyBuZWVkIHRvIGRpc3Rpbmd1aXNoIHRoZW0uDQoNCkFuZCB0aGVy
ZSBpcyBubyBuZWVkIHRvIGluaXRpYWxpemUgYXRpbWUvY3RpbWUvbXRpbWUvc2l6ZSBpbg0KZXhm
YXRfcmVhZGRpcigpLCBiZWNhdXNlIGV4ZmF0X2l0ZXJhdGUoKSBkb2VzIG5vdCB1c2UgdGhlbS4N
Cg0KU2lnbmVkLW9mZi1ieTogWXVlemhhbmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29tPg0KUmV2
aWV3ZWQtYnk6IEFveWFtYSBXYXRhcnUgPHdhdGFydS5hb3lhbWFAc29ueS5jb20+DQpSZXZpZXdl
ZC1ieTogRGFuaWVsIFBhbG1lciA8ZGFuaWVsLnBhbG1lckBzb255LmNvbT4NCi0tLQ0KIGZzL2V4
ZmF0L2Rpci5jIHwgMjQgKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9mcy9leGZh
dC9kaXIuYyBiL2ZzL2V4ZmF0L2Rpci5jDQppbmRleCA3NDQ2YmYwOWEwNGEuLjI0MTQ5ZTBlYmI4
MiAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2Rpci5jDQorKysgYi9mcy9leGZhdC9kaXIuYw0KQEAg
LTgyLDExICs4Miw4IEBAIHN0YXRpYyBpbnQgZXhmYXRfcmVhZGRpcihzdHJ1Y3QgaW5vZGUgKmlu
b2RlLCBsb2ZmX3QgKmNwb3MsIHN0cnVjdCBleGZhdF9kaXJfZW50DQogCWlmIChlaS0+dHlwZSAh
PSBUWVBFX0RJUikNCiAJCXJldHVybiAtRVBFUk07DQogDQotCWlmIChlaS0+ZW50cnkgPT0gLTEp
DQotCQlleGZhdF9jaGFpbl9zZXQoJmRpciwgc2JpLT5yb290X2RpciwgMCwgQUxMT0NfRkFUX0NI
QUlOKTsNCi0JZWxzZQ0KLQkJZXhmYXRfY2hhaW5fc2V0KCZkaXIsIGVpLT5zdGFydF9jbHUsDQot
CQkJRVhGQVRfQl9UT19DTFUoaV9zaXplX3JlYWQoaW5vZGUpLCBzYmkpLCBlaS0+ZmxhZ3MpOw0K
KwlleGZhdF9jaGFpbl9zZXQoJmRpciwgZWktPnN0YXJ0X2NsdSwNCisJCUVYRkFUX0JfVE9fQ0xV
KGlfc2l6ZV9yZWFkKGlub2RlKSwgc2JpKSwgZWktPmZsYWdzKTsNCiANCiAJZGVudHJpZXNfcGVy
X2NsdSA9IHNiaS0+ZGVudHJpZXNfcGVyX2NsdTsNCiAJbWF4X2RlbnRyaWVzID0gKHVuc2lnbmVk
IGludCltaW5fdCh1NjQsIE1BWF9FWEZBVF9ERU5UUklFUywNCkBAIC0xMzUsMjEgKzEzMiw2IEBA
IHN0YXRpYyBpbnQgZXhmYXRfcmVhZGRpcihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBsb2ZmX3QgKmNw
b3MsIHN0cnVjdCBleGZhdF9kaXJfZW50DQogDQogCQkJbnVtX2V4dCA9IGVwLT5kZW50cnkuZmls
ZS5udW1fZXh0Ow0KIAkJCWRpcl9lbnRyeS0+YXR0ciA9IGxlMTZfdG9fY3B1KGVwLT5kZW50cnku
ZmlsZS5hdHRyKTsNCi0JCQlleGZhdF9nZXRfZW50cnlfdGltZShzYmksICZkaXJfZW50cnktPmNy
dGltZSwNCi0JCQkJCWVwLT5kZW50cnkuZmlsZS5jcmVhdGVfdHosDQotCQkJCQllcC0+ZGVudHJ5
LmZpbGUuY3JlYXRlX3RpbWUsDQotCQkJCQllcC0+ZGVudHJ5LmZpbGUuY3JlYXRlX2RhdGUsDQot
CQkJCQllcC0+ZGVudHJ5LmZpbGUuY3JlYXRlX3RpbWVfY3MpOw0KLQkJCWV4ZmF0X2dldF9lbnRy
eV90aW1lKHNiaSwgJmRpcl9lbnRyeS0+bXRpbWUsDQotCQkJCQllcC0+ZGVudHJ5LmZpbGUubW9k
aWZ5X3R6LA0KLQkJCQkJZXAtPmRlbnRyeS5maWxlLm1vZGlmeV90aW1lLA0KLQkJCQkJZXAtPmRl
bnRyeS5maWxlLm1vZGlmeV9kYXRlLA0KLQkJCQkJZXAtPmRlbnRyeS5maWxlLm1vZGlmeV90aW1l
X2NzKTsNCi0JCQlleGZhdF9nZXRfZW50cnlfdGltZShzYmksICZkaXJfZW50cnktPmF0aW1lLA0K
LQkJCQkJZXAtPmRlbnRyeS5maWxlLmFjY2Vzc190eiwNCi0JCQkJCWVwLT5kZW50cnkuZmlsZS5h
Y2Nlc3NfdGltZSwNCi0JCQkJCWVwLT5kZW50cnkuZmlsZS5hY2Nlc3NfZGF0ZSwNCi0JCQkJCTAp
Ow0KIA0KIAkJCSp1bmlfbmFtZS5uYW1lID0gMHgwOw0KIAkJCWVyciA9IGV4ZmF0X2dldF91bmlu
YW1lX2Zyb21fZXh0X2VudHJ5KHNiLCAmY2x1LCBpLA0KQEAgLTE2Niw4ICsxNDgsNiBAQCBzdGF0
aWMgaW50IGV4ZmF0X3JlYWRkaXIoc3RydWN0IGlub2RlICppbm9kZSwgbG9mZl90ICpjcG9zLCBz
dHJ1Y3QgZXhmYXRfZGlyX2VudA0KIAkJCWVwID0gZXhmYXRfZ2V0X2RlbnRyeShzYiwgJmNsdSwg
aSArIDEsICZiaCk7DQogCQkJaWYgKCFlcCkNCiAJCQkJcmV0dXJuIC1FSU87DQotCQkJZGlyX2Vu
dHJ5LT5zaXplID0NCi0JCQkJbGU2NF90b19jcHUoZXAtPmRlbnRyeS5zdHJlYW0udmFsaWRfc2l6
ZSk7DQogCQkJZGlyX2VudHJ5LT5lbnRyeSA9IGRlbnRyeTsNCiAJCQlicmVsc2UoYmgpOw0KIA0K
LS0gDQoyLjQzLjANCg0K

