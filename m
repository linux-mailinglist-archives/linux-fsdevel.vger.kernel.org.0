Return-Path: <linux-fsdevel+bounces-27287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D67D96007E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 06:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23531C21928
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 04:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC82854648;
	Tue, 27 Aug 2024 04:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="XT1GKvc3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7442C1AAD7
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 04:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724734104; cv=fail; b=AiJgBjCUCJeO7HbYbB3B3z2Ml17BcMefopi4P1nrAwpQnK7Y87hqECKzTFnzUDv+pgTI8vuhPro7X7zdy+A7EAvqqwsi0YIA7Q3LURtT303CoGcJ6DTmkrgyxme2G341+QCEhLdKPZ6kwlLk0+DtIzSSWPGK+0F9OQG+5MS8BL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724734104; c=relaxed/simple;
	bh=6aA6WrCr4tCC67G0S7QO/zrCFLm+wBoOV9TS1TqLC9c=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UtwEVRdfRJxY9bKT8apETKoRUAKUObefu3PdIZThpkuAfV4q1GHSH1uWD+yuytP+ycupejOZ4HrLAxGBHw2YrRZnuM4I/NbqB6epi0lvo+Hu7cvr2l8n+b/uuuJTx7ovq88Jm7cqkQV8WPMhzOuQPgbUG38+71+LzNVUS/Hd9Y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=XT1GKvc3; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R1G8R8029941;
	Tue, 27 Aug 2024 04:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=m1v1tESZ4/kpwQ/6BiHVRvrwIvUjD
	bUpM98ZL+mBWUE=; b=XT1GKvc3gli8a0sado7Fjx8vuVj1A2xItLUq0XG9Mci4F
	rbrzLSzuuttV/Ll1b0zLN11hkpUwnB9Ze7oI9DLmT21pfvz3L5loDojDTC+YYw40
	fLi7ZgxBryNfWkxGvjf3nemzFQdz83a6kLChWEmLFiKux/yTlBgDb7xPegNPD/s0
	ElksXJXv8n00dGJsj12bg4vhDPpBdKzDE7Lu/iFso/nCmnQkycGqq4F6J8nU1Sqt
	Z/z7csnI9C7OW88+juaep0OXbK4ZB8cFQ332KjRqD5fc67r+2GnScQCUULVaefG3
	n3hdvGWqTjeXqVBUNdTnwF7EmVKuQ4ZP9zp+nOXPw==
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2104.outbound.protection.outlook.com [104.47.26.104])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4177jxa9u2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 04:18:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RAgVXzouVi/mJ2PFoF0jGscf/n65DhgdpJjJqQA/SYfOwh6NcDy1jNhgUap2lejapATfCD89Y2m2CWpHXQaoIsAba++adXG7zTuTDUjmhKZJV3DfiGvjTbKUynlRSZh1ijUvDr7LoF3dQpImAbKNyPdsiwFwASn+POVpOcsZwVyTrP5Q45LaxxBPdaxwOOUTdy3PBGUOPxDhBJpOQSe+nX8KwH1YOYOFTe5Oq6QikObrVvacuv5nSF4f2v4oWK754pR29jQpT1OJzvH3H1MZO/OGWKM871ihBkzXef4WBvNYR0c7E7xOJBDLhkLPXlJSs0hgZTHidPY8nYbKpVhRhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1v1tESZ4/kpwQ/6BiHVRvrwIvUjDbUpM98ZL+mBWUE=;
 b=l6ZPjaRkHp/DyfkF8b1UNbtLaqG6KLJuqQea/p/M1/A6izLW59czquVMielyZdUufPwPjzDatmut1x/6mipJ292bzkkEwEkIRC39++0Y0vSE5Zfj0KB0YE+myQ1rNezmIorUmi1f2p85+AEWgH84Vzi1gY6s4WTRmcJ4AYSBv+lkHAXAKST0oND7LmrAS14/RRVzkQlOJeyvX7JPyc+cxrjKV2J31E8hLO2jTry6fR6M49iQTQENh7aaNkj9Gf1ltzT0FMIo/OoNUwQ1xECCtbyhmN0Ege3cingDqOPme1lkAAzO9B5DenRYT3VpB0GoIezD5lNVUErdCUXH+L8qVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6328.apcprd04.prod.outlook.com (2603:1096:400:279::9)
 by JH0PR04MB7843.apcprd04.prod.outlook.com (2603:1096:990:9c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 04:18:40 +0000
Received: from TY0PR04MB6328.apcprd04.prod.outlook.com
 ([fe80::6bcb:d0e7:297b:8fa6]) by TY0PR04MB6328.apcprd04.prod.outlook.com
 ([fe80::6bcb:d0e7:297b:8fa6%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 04:18:39 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v4] exfat: move extend valid_size into ->page_mkwrite()
Thread-Topic: [PATCH v4] exfat: move extend valid_size into ->page_mkwrite()
Thread-Index: AQHa+DeaEwtjVafccE+dD770a4znkg==
Date: Tue, 27 Aug 2024 04:18:39 +0000
Message-ID:
 <TY0PR04MB6328F0FD35210C8E35BC69F081942@TY0PR04MB6328.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6328:EE_|JH0PR04MB7843:EE_
x-ms-office365-filtering-correlation-id: 00eaf480-d679-4dfa-a67d-08dcc64f53fd
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?sZLSjDCcFa47LBOrvBE/LFTzPDky45y+8KdXn2zTfjaC71tNw/ko7OQBVa?=
 =?iso-8859-1?Q?OYilhNiDyd5/+ryM4reVGzGs90TXMHeuoudRpSz4kJS3z4vREnWkbunleA?=
 =?iso-8859-1?Q?AYCG4aip40GIBPmSo/9r9VbDYYr3NAAKa7AAjH9M/sV+8PiFNrU4X1Dc5j?=
 =?iso-8859-1?Q?3yM6J9HmiYhIqO9vakeS3Y3RiQ2HClyRZ1r7ckbYw/VaxrgYkbuR5bogNt?=
 =?iso-8859-1?Q?CGk736X4bmmOiUh/FPLee6ILzh0c2kAZ7HkkydPfw/gOOJ4wj4dfQjibR3?=
 =?iso-8859-1?Q?wqcHW9c5pRfPUTnHYPQiHtlktIE8eMux/XvccpFkTnfQ5WpMp6pH8JDQ5X?=
 =?iso-8859-1?Q?Zq8SzWezzhik+jEAoBOCCCYNWLLcs93of/IBJNtEPmFSU90Rpzh5b8dbzi?=
 =?iso-8859-1?Q?sKdQC++ShJvPn230cFT1HPKbHSegs16alb0JGqAT/SGxrZt+BXsk6x/vpS?=
 =?iso-8859-1?Q?tfSBbVb+KHRBs3njRnZBKnwygdi9YwuXRMNxN2UHDBcDF7NPLpQRKDyr6H?=
 =?iso-8859-1?Q?3ZPRYG4OIBs4MghBk/4A+3h7xcnqGA32NMPuJjMwh23hyktIeLEpR3A5ze?=
 =?iso-8859-1?Q?q3l9bmxyfJlpkwma1JhGRo2AYwNpUvn3oe3wi7cZX/gjm0lHjNMsCfZDui?=
 =?iso-8859-1?Q?InRRTtlx3EnZQEAxtM4/6SpEkflYYziNLvCTxxKvdwZUnKPJN1grr4XvUN?=
 =?iso-8859-1?Q?pje2kCZ5VYaXNY9WoykiMYkicBozyhWjE/Vs3phIVUVyXTmmWPLuczgag9?=
 =?iso-8859-1?Q?99V1m/hXK59gEwV0ncdH2GKmUuzpPc9uIXI8nMm9H1Mx8dNYiEDW8ouViz?=
 =?iso-8859-1?Q?QIgb5/2hsQ8P9jr+BfG4IGgs/iBGJelb08bpA1WRpxwNbFLXNAiMR1OLXz?=
 =?iso-8859-1?Q?Cj8IgHj/UBrPaFzcq2nvluDqxSrNqJQaxp50iH/W7u4AsXAeD7rFR6pNvF?=
 =?iso-8859-1?Q?qEz12aAo9TINVrSw71790oVu6tZA73l+Nep5/reZcDcRuwRtVrhMAcEnkR?=
 =?iso-8859-1?Q?qTFOYUOasy8dldl8KB188au+hiFyRyw1jkOkJ+bfXcCQTj9Zgbh8Fom1vM?=
 =?iso-8859-1?Q?c4xaLTKwFfVW/2jNJLLaJlzVIl5JVAA5GinBQJCWadhipfczdpP+64dPVb?=
 =?iso-8859-1?Q?c9lmOjdRJNZQrO9BouW8fKMzNB/1MjufgusE+8thePAvb6i3hYwHFggSuv?=
 =?iso-8859-1?Q?BC0Q3nXM165SwBZo47LxZEYZL6q/x+/TA4xxkjswk6uvSIl7dx6K7jfIjJ?=
 =?iso-8859-1?Q?UlOA27v+5Haht36be0Dg264MLd5HVukjUQgyssPXmQCMNdVqW1Oh4NmvAW?=
 =?iso-8859-1?Q?heHanEkM0IetyuTGFih4Xq3AB9Qu5Zcgf5UkfWVoftET3sil6FPaIA9DMh?=
 =?iso-8859-1?Q?cKBziKGM1b2qOnlverP+e7QVWLZWhRb73x4e6g6NCtFTAFz1KeHzm6suCQ?=
 =?iso-8859-1?Q?Dtgw3qcHE64++MELO1uwIq/djyDIdfekS4oQPg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6328.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?UXalRdjEvF7BxUMWPLUsG105gc5wqCHZwq+hCIUfFw8fgTKbA5aeRyw7c7?=
 =?iso-8859-1?Q?qDG59XRYdJS4JFGaG/SmN19XvjFzagS15wJUD/HI1j1LWtOf4rqqg98QRE?=
 =?iso-8859-1?Q?Rs1Nyv9jTIvGlKPcI5021IC3YE2CyKkxIsf84YVnqDPL//GEZZjndq+s9L?=
 =?iso-8859-1?Q?dNOwjaAyzVxM9GirceO3ZfPnOaPZIWokl0KPIIvRe/VdcpQyaRDS5ZUsOd?=
 =?iso-8859-1?Q?4Jh9X1urBIsKLsNJMlVezOJRblrHPUB6LiWvrpxLrdWT0I4dr0Dr5Y76R5?=
 =?iso-8859-1?Q?ps42Zk60/4qoJQfW/NMH4c2oYrtnbHvyvVgT8Gi8rcNs06BHXLYHjJyIuH?=
 =?iso-8859-1?Q?f1xCG0jETEpeER+pt5WDKETV55F7eCaYunbVjgiZ0mt1I08on9Tubhgpji?=
 =?iso-8859-1?Q?End6m2C6ZHNzaV4+80ANuIlSx2tzJwjoQaM8bemvG6Ww4YqICsViZIEQEH?=
 =?iso-8859-1?Q?7BZ+FLBLh05RTJqX+km5tCmYEamyJX0h3yOqtv7zREts3uj3vbSOfdAn1P?=
 =?iso-8859-1?Q?1mqMqc4xKszwKLwPFlxqfrYf8JKiAHuRO3i+TlpYPWl8/x0TN2paDO0fFh?=
 =?iso-8859-1?Q?3JlMO4/wbXeoDrvfP5lhyXJi+xmnQavEi18QXPWqX/TWQO3HUgaYskFNU4?=
 =?iso-8859-1?Q?XQ8kkEDph/QrDr1sunIDuecE1n2jfUYmHxffUF4DbIX47nR4pBVYI+oB3X?=
 =?iso-8859-1?Q?c42KvyelsBuanl7unYha2Hkx1z/gkdNWr6TjdOLQVIQKYz97RDIi/Yu44W?=
 =?iso-8859-1?Q?2DYfExtFXTbtEw22G6fm464hsOxt07zFW/tyJ8kBVk2eXNBaxtV8qQLZ5p?=
 =?iso-8859-1?Q?60uqRDVG6jEbABAm96n800XFFqF30p4477qDURyIqP4sC6ht1z8NHURHaf?=
 =?iso-8859-1?Q?7b1Qf/jfEbMVql29n7K361QevKr7u8GjIwRE1TN7CzoduerP9x988jfJnE?=
 =?iso-8859-1?Q?TFRGHotoJWoqNFazMOqYq7QPvtqgLYEQaALqyWYphVnvsDq41A71ZaGA7y?=
 =?iso-8859-1?Q?HlDMYzv5eRBWowVHHyr6+FCtGIxJNu+4dN2Y6Kp22y/AL3oYoS/keX4ImN?=
 =?iso-8859-1?Q?3t/CXHcqck381IIUGUCVKLeEDogCxhxLCXrtdwSPvjYi3W+NkLr2aQxF8X?=
 =?iso-8859-1?Q?aObTqVcu6b4Ccl508vCKZvDcCLezIIuF7c1TYjEWDLW7wzb53LApv6/LIb?=
 =?iso-8859-1?Q?oMFBlO31oKGAzctV0qG0koGTUB3uOKnR5RVGwlw/RHF3TIQB7p/rW1OiZI?=
 =?iso-8859-1?Q?8OKI+HaQC2eCe1aimLMq4I3Lgm3Mc0IK31dXg/nflPW4FJqncMcut1qVT1?=
 =?iso-8859-1?Q?TIJNybTAmGBWE/rWNQS9o6QNMnsJ1oc9Z3wbc87+I/vwA64OSs/1aTCCAi?=
 =?iso-8859-1?Q?W1gs207Vw1cr8pCn5LCD7RM9/77Fd0b/5IoHa22xXr3/wexDf6f38jq+qW?=
 =?iso-8859-1?Q?9jgVwAiRE6yHeR5vYfCsN6xwWZc+z8p+q2Cm1487r32zehi4UXPAJni4IF?=
 =?iso-8859-1?Q?zmhYZNPA0F16AnXWT+1lzDPNfkOs/JJ+MPGLj0R/xWT9ky5x54/PX2E/WW?=
 =?iso-8859-1?Q?J7epTbgS4GvSy7xukw0t7v2LLmt6eOheCz9ZnUlqp+ouVgmQdJreeg6EHf?=
 =?iso-8859-1?Q?f6ZgmcQqyXZRF6ViPgfZ5HGbzSKVTyuasgHsEng9D0+j3bHruUJ5ohFHLl?=
 =?iso-8859-1?Q?oMy1A8X4dCUMA/3a09M=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pQcDWOQZQgc2PZZeDfySuy7je/FA29SsK5s70hQY2e3Pqw2DDCisgu6wvrvymxh6RhsBQeOYAqoTiBzNT91aNLuNbU+KiCTz8Qw0PNetAaIvADOMu0O1pbSYVTxHIQ0s7m09LNgyhnpyTDoHc2p7BQxuPORAA1F/W/1YhdqUj2sJKQtiuwlLgUiUylDOFCMl2hf7inB3JpyLz+0NJDrLN+Mqy1m7v4J9LBMlJQIr4d+N3Mjz/UEYU09L0NBSgMte9cyR4h9GFjGrsBxrmcvCvGHpAsJ+4QaGXa9QneZ2fYSBAKj6QqaMiVgzJ/przgnSl2bDcoQhuKDrofjluE5OIay5cEb7TtzeFXNDtsiqJftbjgNHYLtR3UQl4/zQ5GZhyqEyAo7VFozggIN+dpefygFrGX8ox1fYb72qRJmjeT5z+/hG0hpY2HJ1Rg+gI0eM17lNGQUrtVndR4IDDSkru7PreW40E+L41ECOA+HwIp27viehe03jUiaYCejqDtSo4VJoBHU40ruNfXujacnldF8rdJFifa9pbQ3Wdmc8OW+RwAMCFy6WzviAjzHx3A/DqCO9JI0tpR1Gsr3I4I11jAKzDBIdcHpi3xJuBQy06QATss1B3du/4t6uIYItXx9Z
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6328.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00eaf480-d679-4dfa-a67d-08dcc64f53fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 04:18:39.3331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SpPMHCNI7NNTuIRSTMzZiXSHPsAWRYCDySjalWDetrt8lIQgq2DHaOBjtvMFGywISUKSdgVH2eTctJcnIMI62A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7843
X-Proofpoint-GUID: BcIyu9oxhdsA60ePNay-sIjrgM8Mu7Z0
X-Proofpoint-ORIG-GUID: BcIyu9oxhdsA60ePNay-sIjrgM8Mu7Z0
X-Sony-Outbound-GUID: BcIyu9oxhdsA60ePNay-sIjrgM8Mu7Z0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_02,2024-08-26_01,2024-05-17_01

It is not a good way to extend valid_size to the end of the=0A=
mmap area by writing zeros in mmap. Because after calling mmap,=0A=
no data may be written, or only a small amount of data may be=0A=
written to the head of the mmap area.=0A=
=0A=
This commit moves extending valid_size to exfat_page_mkwrite().=0A=
In exfat_page_mkwrite() only extend valid_size to the starting=0A=
position of new data writing, which reduces unnecessary writing=0A=
of zeros.=0A=
=0A=
If the block is not mapped and is marked as new after being=0A=
mapped for writing, block_write_begin() will zero the page=0A=
cache corresponding to the block, so there is no need to call=0A=
zero_user_segment() in exfat_file_zeroed_range(). And after moving=0A=
extending valid_size to exfat_page_mkwrite(), the data written by=0A=
mmap will be copied to the page cache but the page cache may be=0A=
not mapped to the disk. Calling zero_user_segment() will cause=0A=
the data written by mmap to be cleared. So this commit removes=0A=
calling zero_user_segment() from exfat_file_zeroed_range() and=0A=
renames exfat_file_zeroed_range() to exfat_extend_valid_size().=0A=
=0A=
Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
---=0A=
=0A=
Changes for v2:=0A=
  - Remove a unnecessary check from exfat_file_mmap()=0A=
=0A=
Changes for v3:=0A=
  - Fix the potential deadlock=0A=
  - Change to use ->valid_size to determine whether=0A=
    exfat_block_page_mkwrite() needs to be called=0A=
=0A=
Changes for v4:=0A=
  - Use exfat_extend_valid_size() to extend ->valid_size=0A=
    to the end of mwrite=0A=
=0A=
 fs/exfat/file.c | 70 +++++++++++++++++++++++++++++++------------------=0A=
 1 file changed, 45 insertions(+), 25 deletions(-)=0A=
=0A=
diff --git a/fs/exfat/file.c b/fs/exfat/file.c=0A=
index 0bee0c1efbc2..1547c7644882 100644=0A=
--- a/fs/exfat/file.c=0A=
+++ b/fs/exfat/file.c=0A=
@@ -532,32 +532,32 @@ int exfat_file_fsync(struct file *filp, loff_t start,=
 loff_t end, int datasync)=0A=
 	return blkdev_issue_flush(inode->i_sb->s_bdev);=0A=
 }=0A=
 =0A=
-static int exfat_file_zeroed_range(struct file *file, loff_t start, loff_t=
 end)=0A=
+static int exfat_extend_valid_size(struct file *file, loff_t new_valid_siz=
e)=0A=
 {=0A=
 	int err;=0A=
+	loff_t pos;=0A=
 	struct inode *inode =3D file_inode(file);=0A=
+	struct exfat_inode_info *ei =3D EXFAT_I(inode);=0A=
 	struct address_space *mapping =3D inode->i_mapping;=0A=
 	const struct address_space_operations *ops =3D mapping->a_ops;=0A=
 =0A=
-	while (start < end) {=0A=
-		u32 zerofrom, len;=0A=
+	pos =3D ei->valid_size;=0A=
+	while (pos < new_valid_size) {=0A=
+		u32 len;=0A=
 		struct page *page =3D NULL;=0A=
 =0A=
-		zerofrom =3D start & (PAGE_SIZE - 1);=0A=
-		len =3D PAGE_SIZE - zerofrom;=0A=
-		if (start + len > end)=0A=
-			len =3D end - start;=0A=
+		len =3D PAGE_SIZE - (pos & (PAGE_SIZE - 1));=0A=
+		if (pos + len > new_valid_size)=0A=
+			len =3D new_valid_size - pos;=0A=
 =0A=
-		err =3D ops->write_begin(file, mapping, start, len, &page, NULL);=0A=
+		err =3D ops->write_begin(file, mapping, pos, len, &page, NULL);=0A=
 		if (err)=0A=
 			goto out;=0A=
 =0A=
-		zero_user_segment(page, zerofrom, zerofrom + len);=0A=
-=0A=
-		err =3D ops->write_end(file, mapping, start, len, len, page, NULL);=0A=
+		err =3D ops->write_end(file, mapping, pos, len, len, page, NULL);=0A=
 		if (err < 0)=0A=
 			goto out;=0A=
-		start +=3D len;=0A=
+		pos +=3D len;=0A=
 =0A=
 		balance_dirty_pages_ratelimited(mapping);=0A=
 		cond_resched();=0A=
@@ -585,7 +585,7 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb=
, struct iov_iter *iter)=0A=
 		goto unlock;=0A=
 =0A=
 	if (pos > valid_size) {=0A=
-		ret =3D exfat_file_zeroed_range(file, valid_size, pos);=0A=
+		ret =3D exfat_extend_valid_size(file, pos);=0A=
 		if (ret < 0 && ret !=3D -ENOSPC) {=0A=
 			exfat_err(inode->i_sb,=0A=
 				"write: fail to zero from %llu to %llu(%zd)",=0A=
@@ -619,26 +619,46 @@ static ssize_t exfat_file_write_iter(struct kiocb *io=
cb, struct iov_iter *iter)=0A=
 	return ret;=0A=
 }=0A=
 =0A=
-static int exfat_file_mmap(struct file *file, struct vm_area_struct *vma)=
=0A=
+static vm_fault_t exfat_page_mkwrite(struct vm_fault *vmf)=0A=
 {=0A=
-	int ret;=0A=
+	int err;=0A=
+	struct vm_area_struct *vma =3D vmf->vma;=0A=
+	struct file *file =3D vma->vm_file;=0A=
 	struct inode *inode =3D file_inode(file);=0A=
 	struct exfat_inode_info *ei =3D EXFAT_I(inode);=0A=
-	loff_t start =3D ((loff_t)vma->vm_pgoff << PAGE_SHIFT);=0A=
-	loff_t end =3D min_t(loff_t, i_size_read(inode),=0A=
+	loff_t start, end;=0A=
+=0A=
+	if (!inode_trylock(inode))=0A=
+		return VM_FAULT_RETRY;=0A=
+=0A=
+	start =3D ((loff_t)vma->vm_pgoff << PAGE_SHIFT);=0A=
+	end =3D min_t(loff_t, i_size_read(inode),=0A=
 			start + vma->vm_end - vma->vm_start);=0A=
 =0A=
-	if ((vma->vm_flags & VM_WRITE) && ei->valid_size < end) {=0A=
-		ret =3D exfat_file_zeroed_range(file, ei->valid_size, end);=0A=
-		if (ret < 0) {=0A=
-			exfat_err(inode->i_sb,=0A=
-				  "mmap: fail to zero from %llu to %llu(%d)",=0A=
-				  start, end, ret);=0A=
-			return ret;=0A=
+	if (ei->valid_size < end) {=0A=
+		err =3D exfat_extend_valid_size(file, end);=0A=
+		if (err < 0) {=0A=
+			inode_unlock(inode);=0A=
+			return vmf_fs_error(err);=0A=
 		}=0A=
 	}=0A=
 =0A=
-	return generic_file_mmap(file, vma);=0A=
+	inode_unlock(inode);=0A=
+=0A=
+	return filemap_page_mkwrite(vmf);=0A=
+}=0A=
+=0A=
+static const struct vm_operations_struct exfat_file_vm_ops =3D {=0A=
+	.fault		=3D filemap_fault,=0A=
+	.map_pages	=3D filemap_map_pages,=0A=
+	.page_mkwrite	=3D exfat_page_mkwrite,=0A=
+};=0A=
+=0A=
+static int exfat_file_mmap(struct file *file, struct vm_area_struct *vma)=
=0A=
+{=0A=
+	file_accessed(file);=0A=
+	vma->vm_ops =3D &exfat_file_vm_ops;=0A=
+	return 0;=0A=
 }=0A=
 =0A=
 const struct file_operations exfat_file_operations =3D {=0A=
-- =0A=
2.34.1=0A=

