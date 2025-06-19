Return-Path: <linux-fsdevel+bounces-52191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6B6AE01C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 11:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB98617CA9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 09:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA72C220F27;
	Thu, 19 Jun 2025 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="NkA4hEX1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BB91E570B;
	Thu, 19 Jun 2025 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750325689; cv=fail; b=RaIqGS6JWNLeUBMSsJ5D6p2DUVeYIBQr5CkX46lXvQJ98aKrr6NHg/J1afKc86hQ0fteS7CmnAtc/M6uxRmxFwGq6I4EU3KOJgDQ+Ew9eeX1C0q5dqLFo7mN7Phf4+PoMgY8trlPnlb3WEn8AlV9uDo4bb5dybn2Dz6P/y8Kwzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750325689; c=relaxed/simple;
	bh=nHI1EyPZDQAb9k4R+WaIBAYF6AsJ5rCP0pZgU540Qf4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kbJqnVI8G+Zaefh93gqd61QMKHM7JP03o0N8Hf3NCoSJUVtAu9856X4D9N+gbeJ1cQzMubZLjL2vE9MS18lSubsdHaC7dIKVmsNiUSxik2zDMe9fQN7wxtUfk2hujNyGvXfMtTxpwnaWPfVNnU0IVbl/sAxOWuv54Obp4sNs4pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=NkA4hEX1; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209328.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J6Zp9C014179;
	Thu, 19 Jun 2025 09:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=HM4ri0+
	pQ2UEV1OMZFE6WUtfMUsw9ZSMqvZNL59h3UY=; b=NkA4hEX1q4uw8H8BLweQl44
	VAHoIgdt+Ak5GW1C7KdmhWkDdrnkRgnErLeWXu2RKv0S9jTsd3DDkCPa0C45Gnle
	HxzvAfb2oXy1gCmEkRIGyy/MfXRMNs6mov9USHRd0102teTygNIThrAqJisQPFsV
	DZ7OO1/0i1d8nM0c3RALdam8qC2JWKJF3p06LM8Cgl8xSHqlE/LDGnZ2GtCZQR16
	H/d/yfbFT3d2X/+B4dZWSJjRhxe8cLmezl4cwJQXV9BLXH1RC6vwOrTx38/+/cvk
	xFZZPCXefY/i+w/WalwP6ACc1GtlPOt8XwMuljrX6esjO9wkiQgdFbCwiNj53MA=
	=
Received: from typpr03cu001.outbound.protection.outlook.com (mail-japaneastazon11012042.outbound.protection.outlook.com [52.101.126.42])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 479t53c44n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Jun 2025 09:34:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YahdUZ7sPrQYpp5/BTlhybQ5DyWEJstqJWyWIDf+oCJ6jJoILeSYWXFduBzuD4IrXV0z5KctOoK/hEz13tma7XYBAFGcUhdRz7ocJsxb2sW6Gcu51JJYzdEEtULGKZtOlcH4jPb+dK0U/chdFjwMx68DbP/8rJGJbAH+nY9UlwZQy1oWg8KJE2uvMcO6rXMUtU1p0KvC/mGxogFfulErCaFqI8BStkjI/GGQYc/8AoFtUNZgUvLMw9npbeKdsfU8voP6RHEkf8qsJIbiogZ+T1LrRbqFsiqPEm6EHfVaDJeCkpMsrvDW3N+F8mja/bPLcA/GKucelhzWIr7A7qsdWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HM4ri0+pQ2UEV1OMZFE6WUtfMUsw9ZSMqvZNL59h3UY=;
 b=HyRhGcf+r5Bi0dNxB7H6jpiwXjzwTJpJ3x3xmz6AO4G8eYeUR+Hol/RYZ7x1LfOpfanJ1Po4gqaydZZBDORQs5g4gvB3uqEuiEaGJLEIhUmuJdKfHqB+Z9HoWvqLZT2MGJK6RG5zkl5X6DiwT26bbvwQ7PFlrDo3aB4/kOojeBCYFE0zc9pgxldY4b/ZrBOt0ReBvGI/sRGj9mxESVv/tG22HrJHrLY3dgW3F2jV8Bnde/BCGVuLyox4oV2Mo9AaMvNt2CH8vR1Y45AKieyn62CAeaJxeFjcHbgSk9i62tSPmx8z58k4i+tCIFuAxocbEnWI9bavYquml57Who9upw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYSPR04MB7687.apcprd04.prod.outlook.com (2603:1096:405:39::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Thu, 19 Jun
 2025 09:34:08 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 09:34:08 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Zhengxu Zhang <zhengxu.zhang@unisoc.com>,
        "linkinjeon@kernel.org"
	<linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cixi.geng@linux.dev" <cixi.geng@linux.dev>,
        "hao_hao.wang@unisoc.com"
	<hao_hao.wang@unisoc.com>,
        "zhiguo.niu@unisoc.com" <zhiguo.niu@unisoc.com>
Subject: Re: [PATCH V2] exfat: fdatasync flag should be same like
 generic_write_sync()
Thread-Topic: [PATCH V2] exfat: fdatasync flag should be same like
 generic_write_sync()
Thread-Index: AQHb4LpVuCt0DRdtcEiRld2Uc1xwJLQKOKCZ
Date: Thu, 19 Jun 2025 09:34:08 +0000
Message-ID:
 <PUZPR04MB631659A25F27D1F0957E78A6817DA@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20250619013331.664521-1-zhengxu.zhang@unisoc.com>
In-Reply-To: <20250619013331.664521-1-zhengxu.zhang@unisoc.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYSPR04MB7687:EE_
x-ms-office365-filtering-correlation-id: d72279b2-e5de-46d7-fd0a-08ddaf1470eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ma4PMlhw1nxphi00te7m9/TrImAEpp4nCfAAPSGj7w9JK/W4R9pORn1CGf?=
 =?iso-8859-1?Q?st2leOhWiA+45HxtSImEvQdND6ZmSS1DfDWX2/Vsvm+Z8AZEPQbTI/kAYy?=
 =?iso-8859-1?Q?2q8gvnUavldXob43Bm2gDWsgtp0gPIyWi8X2u0raBjl7USPlhDSTjbJltt?=
 =?iso-8859-1?Q?W0aU5hozZ1Q8KUhDgCxtc3iwZPckP8OwTFvoFZBWe/15lqL2WEQP5/mADb?=
 =?iso-8859-1?Q?avJJSdKzIrQM4Z9OW28IVoFSaP/PajI8UynJPcUute5TRLRBOY7URC61Pg?=
 =?iso-8859-1?Q?N/TKPdx/H8FDpb6UjG/oyrPSII0/NrXpM/bUGbCW/HO0KyYNOYcLNkfwjv?=
 =?iso-8859-1?Q?S1/pBnntBp6SNPs1ByVzhnjwSTGT3HNsruEyboG4VG2Yrhapustil/AgRn?=
 =?iso-8859-1?Q?0SNHPWrfT4npYcsvhl5SkoCuz1/Ej5OyZWgORmDcj/6hgUFtCqRtAOUo2S?=
 =?iso-8859-1?Q?Z3P0QWMUEwHg01zFBoDA3OsGv/0TF5VV/kVwjEKGsH1nGoQM+i8kLQdViK?=
 =?iso-8859-1?Q?KYlke/eFQQXlpQgwX7wlFb2DqteZYt8nbGRCYIY5/slV5uV/nKaTAUwC/O?=
 =?iso-8859-1?Q?NpQfgilx1mi5tsj5c499RndSyMDBue2tzqvq4UjlK7/rs1TUkjCTmBA+Ie?=
 =?iso-8859-1?Q?3eJrXEBxrt3EJFebMydJSL89gNnmqSQNfA5mpADeVfjqXY8YkFTPJBuX0D?=
 =?iso-8859-1?Q?rONjGr+E9eKOzYEYrv6rR6G6FzM1KNTmByyEGm7TiVQiyv56hYv5xZF+6o?=
 =?iso-8859-1?Q?YHlhns6pCbMa/F/dGZpM7QvmZQqB/aoAxsDwC4qKkMTal9d2vtylmORRsR?=
 =?iso-8859-1?Q?cB4/3q9PMl/2hTJIpLRd7r22OD4I4Sb6tHqtRYQiDczjJo5cyDMIHo4YkM?=
 =?iso-8859-1?Q?cL6Ux6E5ic89W/siRwxMpDua/y0d/9+icMwtgnpmXrauiJ+kXpwRSwe0NA?=
 =?iso-8859-1?Q?WleZHaX2h3soadTeLqqyj6Y1wxquj+aMnJ6i66Va+qVhlO5b+yFHtJUrgE?=
 =?iso-8859-1?Q?3w8y6ICoUwYARYzUFUQ40KU+DVkfGO4F0KRnkS5nkDp73Sf4LAPjwuZoo/?=
 =?iso-8859-1?Q?UdFpiuWqLAjHlfWHCQSYXTrqp0bVtoF+BSjFFOl8W9Ufpi9St2f0UqYT57?=
 =?iso-8859-1?Q?us/jqv7uWh2wCEjYj2cKDeMIRYR2IFWCE4eMgDNlq8aDHOpjp+X1FBtbyG?=
 =?iso-8859-1?Q?Pcj8xN17JSpTohbbG5GkW3Wye/wTUoxwwpKyRswoqxS+kTs9qSH1hJPFXR?=
 =?iso-8859-1?Q?W9/xtuFE/FOg7r1Hf6Vis6Cz2T2ofuvzA2wl1uXNz6gKB/3FqORW9M4uIX?=
 =?iso-8859-1?Q?s8Swf9BRBymgmSMrDHFIsJOLTgH2yEy6GoIip8nKAUigzNPl+xpD8GW3e3?=
 =?iso-8859-1?Q?W4mzafTwpFb1Gg1wVVEUMbj/+HRrFbYDW/TaaRbajQc6rm596XA774Y6dh?=
 =?iso-8859-1?Q?D4lmm8oqoiU/l4iRoXKHrZr/mt+k7c67qhFaE3gTxNZ9mVdUFWVwkCvgi6?=
 =?iso-8859-1?Q?gYYC6AilzqOPTMMZFf22ETxqrFUuGQ3OXpNy9LiQ9qEQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Ln3L6UzzStJP5QPkWUbQ2iN1mFkrM/N94Spcyk89WAjU8UZkgzxXVm7CWY?=
 =?iso-8859-1?Q?CZboSECvy6LGDUkZSJ94EQFTeWr1v3gxeNX+1mfqumG6tCGDHvdait0E4D?=
 =?iso-8859-1?Q?Ry96F1jMx7eDbqjV12OsumBXMcWrlebE97we6c8dXAbe6xhody6nOZI0Fy?=
 =?iso-8859-1?Q?RZDDe5ARO81SxIBJNUJuaJYhJ6BepFLcnYRKu21DhnG5FJSGIXmC+oyXN1?=
 =?iso-8859-1?Q?Ed/epNotizi5CQYC4+Ibf2hLcEWzTKnGcjeXn8aapux5OlDppFJEWIKOsx?=
 =?iso-8859-1?Q?+gBNJIGSxX79IwDudOWL51xcHj6mNzmmEg0fwMhNya17BarMZbmOQjjzmO?=
 =?iso-8859-1?Q?qQMaESHloOEQtOcYqZlbVfaR+LDkAgIQeIl2QjQqkPRUbUTgs254qgZwzM?=
 =?iso-8859-1?Q?6oizTYnDf16ktUX/NBCxkj9L0p2jvveg9mKdwObx6T2loSaldwzQggjy+g?=
 =?iso-8859-1?Q?xlX/zNW/lt444gj5J8dua+NFV6ShWYhmw2HbdyRtUUZL7ZZm6H4hbn4yCj?=
 =?iso-8859-1?Q?2XgaQ+FV1s/1ESWHL4rOCZ7YjxYxQHZWVpG4e1PwC+vrBi2cpqdD2dv4oB?=
 =?iso-8859-1?Q?HHuQBXXMLYIYMyZc23QXI1buvkrXU4eL+0J2tGFQ7Kyb+jgvvJ/Lei+vqd?=
 =?iso-8859-1?Q?zaFDgVRGvfljW2e4Br8GrBGGweGk1I5K/e7H/IqhBdW8sR93tSP0NO7FKA?=
 =?iso-8859-1?Q?vX8pojFT8n0BNTyz5/5wLsbTk1j2luscrbYw0LDTv2p/d0aLhlxZoa0TYE?=
 =?iso-8859-1?Q?TOhewVOmIyfbKHzpxb1ijKMz8SkKgEHS6l4OxhFU2CVOrYEUBYiXO/iaaE?=
 =?iso-8859-1?Q?sSfPwFZK4YOVhDx+3zAzpPrbLU8ceJtfOxYgQlBQ6+bAT7i8J9nNgRkyjP?=
 =?iso-8859-1?Q?uxJHHOp7zzkCT/sLmUU1dlUNGG7Rn3IpAKE3domyUpGiif+5rmg0kwqgKg?=
 =?iso-8859-1?Q?dTedCqJu9hP3VgZy9H+kd96UdXWo+ertbIdGw3RWABXM/7lZSbltmpvnwM?=
 =?iso-8859-1?Q?/P6zLmW7r0jmx98VXHHbqSueqskxw2k/sL63lt6oBZapNae558UavtxkCd?=
 =?iso-8859-1?Q?tCJfJEyy7cnMwGXADKm6erLIVplf1BwZ/lcUDIFTfGtdA5Iyzb1R3astF5?=
 =?iso-8859-1?Q?DgKO/Llbe2xjYgI4Svzq1Q5ydL2dXICeMYzXvWmrUAN21b1IBqjRyrXO4b?=
 =?iso-8859-1?Q?zT37SVS8CAlDP8py/D1RWbOdakubhhSsoASKmR4mxLw362rTScjqSpFNPi?=
 =?iso-8859-1?Q?2y9gETogjuWoXhL9n66ljJkStYL/dQJiCDboExhmPSX2WXWLZWGAhm/WM9?=
 =?iso-8859-1?Q?uKf2bWE5rKgVBDBX665Qc1W7FTc9zju2h9Vv9Njix2mxUQokm/cc0479RK?=
 =?iso-8859-1?Q?JKzErxGR511bLXAb8lYQchgG7cL0oEO4Jecs4a/nKwFWMfxJ/y51qBzZO0?=
 =?iso-8859-1?Q?/AcmS4iHLIE/OFbtohiJG4OWZ5bE72oWkwEVm2hRJqeZ8/yvXBmXLf86mV?=
 =?iso-8859-1?Q?oGlAnc1A3Zv3ZkWjkiGd5+fPyCBCdIaUGylSyPISBW094h9kdkTEOnI23j?=
 =?iso-8859-1?Q?NRnLHAZEJEzPwQ9hD5HnG+XDFPT4LIrtsBPwASBcYQ0BlyJwKrkVkqq116?=
 =?iso-8859-1?Q?pqQrNmAFDM5EX7xZPf80Gu0BevfJF52Wybsu6WwUQETiNFlgwJK8EyOtkt?=
 =?iso-8859-1?Q?gYPl+22Beu3W9ZcH0h0=3D?=
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
	Fuqsagi/l7HzuzEo3tQDFy8ueQtuFx0fwPwQ3TlH8eA8/t1P0n4lTvRGHBOmanG9nZSSJx8Lt5EaBkwMzKKX61YF6pH4FLO389SiFSpEhRPdMDRY91xnFBIEalxBaESNXGdMuvNN5XRFdX7fo/+dgsbZbv4Zp6q9I00vFBvNgKiMLZBaK09wYp62l976wERd3uUnBl9AGHvkC1O46JDht1uBMBxBCK2a5BcVJWojgJvlPr488wNo0s+3UUq3Gidfqf81g46FzciGKnzh3gjVsirK9ydNx/jIzEfcJHNTIe+uyWdiJMWDmoB/TH8H5wmdx1NhPQANSbpCLfVI6ZbBmw5MJ17V3rDoaRaEBfx1TChhS8xFZfcJjwQhN1T4PJqfVeJTDOPiB7/360aTNsyCnjSUyHDGotVywd9Ps65Qq7smjlUakE5In8VTU23HWHi+aG9jtL1kYAJ8WR8eUL4n5vpXs8vA0IyL7JFGfv/anQETDQ7PLJGdDxvzVyZ2TK6X/ZXokox6T3WIvoRHrnArkx6N1OXGKJYutzWbjWE85kh0SPKxrMJ8uDPLAmzKd6YoiC6MDOdAM2oQ4z1QnGlObiSHBgNDk0hbaOZpAha03O1bdQhU7fdvut7GW7ZsF8dM
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72279b2-e5de-46d7-fd0a-08ddaf1470eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 09:34:08.4849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nTLakW9nD0GBa3/+cUSxU0ivaRd8vWt5zqG20fauzF+bjCkvVH8Tz5T6q8eaGeKA67gS8kIzCvxnzu0qJTYxIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7687
X-Proofpoint-GUID: CFBCczhi5fOYiEHy6jfBhCcQoHdDi6cb
X-Proofpoint-ORIG-GUID: CFBCczhi5fOYiEHy6jfBhCcQoHdDi6cb
X-Authority-Analysis: v=2.4 cv=GJsIEvNK c=1 sm=1 tr=0 ts=6853d997 cx=c_pps a=pbUL58iNF13cnplmrRAwGA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=6IFa9wvqVegA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=icsG72s9AAAA:8 a=z6gsHLkEAAAA:8 a=8fQxh1-tNq6LRiGuRqcA:9 a=wPNLvfGTeEIA:10 a=T89tl0cgrjxRNoSN2Dv0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDA4MCBTYWx0ZWRfX6rt0vtoEfcjp cPq7tuJDWIhlPvVMK3kKr//Kv9XcF+IlfzRaLUT0HBda8yib45C5zStRSiRGMhVNVsXS0YY4bt8 MJ7Bu1n+gAZNgaKa517Yz6VUK5Hk183vsAeS9qvBQMk9TWBhDk1k+oE5xqIxSkuAwlpxr3tQaxD
 FfRowP741R3zyDNQMRp+Qwfl1AH8m6mvsSyyQ+TiMCJcWEXADvz+DclO54F+i6zWrxgaS7Y+G2z RgpPWSZa/trLz3pyF8VEXe6Sf1g+6/X0G6vTVZ6J52Y/uFH7+1dDKQYboMxHHaLeZqLG8AvOC5x WCT4ncKOrKlegSrzR6zUXuJB6TQjAlpwd9TqWknwnZjbxH5/hfcMCjQi2YDmVd7ZjQfKRTuVi8p
 eU6Bi1f2guppqwXuhY3rJZ7WoMZWcUVQZdagTi4yDl3fdM7nVL7j7bTOatYyP6EL2uHmRw+u
X-Sony-Outbound-GUID: CFBCczhi5fOYiEHy6jfBhCcQoHdDi6cb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_03,2025-06-18_03,2025-03-28_01

> Test: androbench by default setting, use 64GB sdcard.=0A=
>  the random write speed:=0A=
>         without this patch 3.5MB/s=0A=
>         with this patch 7MB/s=0A=
> =0A=
> After patch "11a347fb6cef", the random write speed decreased significantl=
y.=0A=
> the .write_iter() interface had been modified, and check the differences =
with=0A=
> generic_file_write_iter(), when calling generic_write_sync() and=0A=
> exfat_file_write_iter() to call vfs_fsync_range(), the fdatasync flag is =
wrong,=0A=
> and make not use the fdatasync mode, and make random write speed decrease=
d.=0A=
> =0A=
> So use generic_write_sync() instead of vfs_fsync_range().=0A=
> =0A=
> Fixes: 11a347fb6cef ("exfat: change to get file size from DataLength")=0A=
> =0A=
> Signed-off-by: Zhengxu Zhang <zhengxu.zhang@unisoc.com>=0A=
> ---=0A=
>  fs/exfat/file.c | 5 ++---=0A=
>  1 file changed, 2 insertions(+), 3 deletions(-)=0A=
> =0A=
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c=0A=
> index 841a5b18e3df..7ac5126aa4f1 100644=0A=
> --- a/fs/exfat/file.c=0A=
> +++ b/fs/exfat/file.c=0A=
> @@ -623,9 +623,8 @@ static ssize_t exfat_file_write_iter(struct kiocb *io=
cb, struct iov_iter *iter)=0A=
>         if (pos > valid_size)=0A=
>                 pos =3D valid_size;=0A=
> =0A=
> -       if (iocb_is_dsync(iocb) && iocb->ki_pos > pos) {=0A=
> -               ssize_t err =3D vfs_fsync_range(file, pos, iocb->ki_pos -=
 1,=0A=
> -                               iocb->ki_flags & IOCB_SYNC);=0A=
> +       if (iocb->ki_pos > pos) {=0A=
> +               ssize_t err =3D generic_write_sync(iocb, iocb->ki_pos - p=
os);=0A=
>                 if (err < 0)=0A=
>                         return err;=0A=
>         }=0A=
=0A=
It's good to me.=0A=
Acked-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=

