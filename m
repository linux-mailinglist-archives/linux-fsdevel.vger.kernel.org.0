Return-Path: <linux-fsdevel+bounces-37467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED1F9F28D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 04:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EF927A1237
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 03:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001F8155C82;
	Mon, 16 Dec 2024 03:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="e8DBqyTk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB83F1BF24
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 03:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734320262; cv=fail; b=UmYdv6Va4cSTEVT4KwpK20xxSXoWJ69hiI1TNz+/Pom7L2sypJQcs7ZD0IyzsQKz/PY9f6BnNgVCqpMtnbp9QrWKVkxikemofcciiYydyEFTH06i0qoZ52GTl5wVDO7We6ZFP9ff40YHs5FJQ5E+botBQa+3yTyDVw+sNFRCJHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734320262; c=relaxed/simple;
	bh=zV8yvWDpOSr1RjfhbwyVTGwJgiFg6PxCcTF/thqEOf8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TbP3Ct2vwHViPAzc0RyeuKi+PxGCnoGedZZmJSLI2vkoM4v3Y44A8M80+QuvbWrhj1lvZcXYqdlrD3Xync3dmq1cZ/lEpZOt12YUfCyV5H3bHVxFMxcp3dSylRh2wTMPuTOWCvRe+tLC2oAhJxreeCGmtoyi5F1IM9cilEh87v4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=e8DBqyTk; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG3RRwN028464;
	Mon, 16 Dec 2024 03:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	S1; bh=A+u+7+Fw/zy0bf8HucDgk5QOmqdkYOkDaStqhXYprEc=; b=e8DBqyTkA
	fpJ2SMi1l3hRl86xsL5tA9LTtQKMW5hJS7IBc0a7DviwGPaqz89M5XxTNLhp/8eb
	M3Dmt4knImpH9390ADJoCPkftwghiNKAuxd4cd3KgRFFg8FxgTPlJ6IYaJRtaPKE
	muREZFeRE0ZmL5GRfn4tC/wJpANNkDbR+wp6ZDri9iZiAsdvy9aMUZ/VIwnpnWkA
	s9N/tc3G1WwJ/dyVaq7alI1LHXx9DBMP9YUWpO1hw1bx7BxaWGcGaR44tcRsureZ
	i/MozDUghPvxPC65PJ0HeB7GrGR8/i/jpI/PFDCbJQZ/kblS1VVyXm2Bp7zTPnkZ
	yVZJrU4+92lCg==
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2043.outbound.protection.outlook.com [104.47.26.43])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 43h0t493yy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 03:37:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2OWOoTiSIiLxc8ZSCR3HoqA8CylPsyU1Kiu+C9qoHCltSdatF4SPU3UqYNy96QVaTAWgb0vOWwPe5L1kDthXGwc5Iast0tXtRzKlyEgRPCJANq+mbVTvPcgG40Ks4sxHD5I8tJEe2SNr7OwCC/rkx6Riery1H+7pceOa5Aek+GE4Qy5FBYg22+FWP7rWtGmWeQF8uo+74FbBGAM8syG73Rvvzuoxw/NLE6x43rw2aZ5lcgOqupMW8rYJky2E56/PJ6qouksHLkrOqvGC1oIEq6qgzIHfz1ftDwCnAi6qZyxDq/RSvFwauzFY3HbP/INvOv5hSvgumpItcFmBZyJdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+u+7+Fw/zy0bf8HucDgk5QOmqdkYOkDaStqhXYprEc=;
 b=JLntTXLClONPS2lOt2W140hKkak1lDo18ZeSA0ukwWwBhoqQpytcvZ29t/RC7P1n4nePhchuFelRtjuU2Q/r1qh8aBLI5eYWWwM8RM5I+KyWiLieor+Iyk2mHdMSFHUhZYLgDYDBHHRI/0+GTMe7eFNl0nT7eWmFSn8KCXbqKUdB2ZRUjkNzh6zeop27KCsk+3AyszFUey7/hMdjGZ65R/5Va3NstWh9y6TLo5zaeC75ai+HOBslROqN/ZI6AE/VvQ9jcj+JyFep0CShJ4CXRtW8oLHpGa2+fr82cKEg4IsL2/qpGsZjWiMxcSHSlkddz4qvsnBEw1oMDTWeucVFpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB8299.apcprd04.prod.outlook.com (2603:1096:405:dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Mon, 16 Dec
 2024 03:37:04 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 03:37:03 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v1] exfat: fix the infinite loop in exfat_readdir()
Thread-Topic: [PATCH v1] exfat: fix the infinite loop in exfat_readdir()
Thread-Index: AQHbT2lQTa3uFYN5MUScy4mppc6EkA==
Date: Mon, 16 Dec 2024 03:37:03 +0000
Message-ID:
 <PUZPR04MB6316E933E479EA23F39EC2F0813B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB8299:EE_
x-ms-office365-filtering-correlation-id: 48b2f8bd-63f1-47d5-201a-08dd1d82e85c
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?f6A2k75H0rzqz1iKMOvIr2YtoC68XTZsikLMSizO7wduXM8fht1GABoYDg?=
 =?iso-8859-1?Q?wPj3rakUDJRTtzRsJs7gvK392e0ujmYN9E6t26qJ8Zsdp+MB78Q8QBQag9?=
 =?iso-8859-1?Q?88cZb8gbEco1o+tFtxBVeZgBRyJba3EmdmmlRxO+PZQAV+IwuxEYFzypsk?=
 =?iso-8859-1?Q?ZB0JH9D4QQxeMEcYaG6BjnMpiO07kHBnV+S5aH/blWCMyb7/Zi6sFm5qRh?=
 =?iso-8859-1?Q?OswP5ChtSCgJ0I/FmIPnciYjEb3VOCA5qkcunjEr83Nev+Af/VCP5KZcZQ?=
 =?iso-8859-1?Q?lY318B1xy0kkC4XwFb8dt2id2wEypPgsie6yZcahuTths9OgGb1WddLbj0?=
 =?iso-8859-1?Q?f+MXGwONCNNbpj5BAoY3iZ877mtrRE5dFmclBL7DT1fWRWstzVyf4/yPwA?=
 =?iso-8859-1?Q?r1lPOX7w7CJ2jSZuia0K4RcYNFUkd1T5XOjfua4k0IOXNwQoGdnD1J7vvv?=
 =?iso-8859-1?Q?BBk+OUR7Pzn2ord3kcMI6OTVzjya4Hl5f3A21MlF0iP2ZfP2u1tyTQsWOz?=
 =?iso-8859-1?Q?Sy4Tupx/RWC2HSXbc0wePSFgXX9wSJhGlG11mnG7xvvPs//TEP2idaqvdw?=
 =?iso-8859-1?Q?ScdOltZZO5AXVkFIJbHmeIsZrLAEbvjyhFsIyQfi/ha3ag/UITy22pzoS1?=
 =?iso-8859-1?Q?9C2xqGONT7ylPR+V8MZhjuh7kwsedIO//nGURnS/mcE2k43vlJxdwA1rBv?=
 =?iso-8859-1?Q?w0yZTUyNW2C4kR6s1YpoIM225RzFU7EfHtz92MacbIyrUFORpUmT5gCKnW?=
 =?iso-8859-1?Q?0Tg0fsG5XF41LgZPcvEgdPT/YuseHRv5hZS4YZ/hBpia6YznAxp9/rAOMM?=
 =?iso-8859-1?Q?+ZXQpcyJr/Yori3gLY3/QTvDlor4bRw6xxnEx+s+u0ziydemOR4hXweKL7?=
 =?iso-8859-1?Q?la1TsrfViJYzdDUIq0J9PMtK5vJc2wusT5k9I6wpLcMUkegn2r07Ap9QYR?=
 =?iso-8859-1?Q?fsiT+P/97RcT46TS1X2TriZogszyLY6jrUap9dchNpYTwx5bdcflXVvi5x?=
 =?iso-8859-1?Q?6oJ6Z5LAozQmIU2DDWQhdJ3L6M3WgqLzqh2efZk/vOkgTEO8xyrHkis/Pw?=
 =?iso-8859-1?Q?Nb12Nl/KFQGndaJLFr8+7IXK6NxhApg4XOcCAfZZzEPwfcpSRIyXdSnLBK?=
 =?iso-8859-1?Q?sKob/7Aj2fry7wsI97c6pRpv3W3GHdxnFpju9YSpDBiUX9qjypYbMfpVM3?=
 =?iso-8859-1?Q?rDeFAqXDbEbM5n8iUpYydVD25JoG0rWTCRXLX+GvBd2QZbTAkkkP2H+VFN?=
 =?iso-8859-1?Q?F/R15MXZki1nk0QrHX5NqROVXg3IOTRt0JCjpLSk8vX2XQs3936IN6hIIV?=
 =?iso-8859-1?Q?2zAHbYgVm66nV24RsSR6xI1A4oXS4p9RqayT5MWCFzkEGlK2xOemT2zsmj?=
 =?iso-8859-1?Q?iVqRMAdabloKv5trUkvoo/M8WEqb7E71K2Ig/JBhx7OiCEG1l8ks+dzGYe?=
 =?iso-8859-1?Q?HvKQrel4+MYUpki+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?hYF7KZ61c304XTmcfNqvyEQQM0WdbjdYOBcJ7BGNKlJvr6qoodpKzYmklL?=
 =?iso-8859-1?Q?CbpYoRaAogPifuw77XIHaxOkwgG/0SpGV1OyI6ZU6gQjK8AC7qxAkFugK9?=
 =?iso-8859-1?Q?fgyKs7liALNSGDyJ6XvCUpE1mAxZtO61ycHamClWRK+1si2ziEyXeOCT4Q?=
 =?iso-8859-1?Q?c8Y6yldC67Jxck9///PUQIAOFkzXNIkVVzIO6bKNGQJ59kGL+yOtCPU8ph?=
 =?iso-8859-1?Q?F21GhqJPfWttISqt6fiXL4Ynd8teAAHYJiWpg67cEMOc6vV6hH2TUlqcwj?=
 =?iso-8859-1?Q?17WAW5nxQ/O6DRhVQc9kR+RPGxCpaFyupJVHneGp3TWDHaNGWHdytBqxFL?=
 =?iso-8859-1?Q?D7iFPDIQbLspetZ0TD2m7dg600s4P2ZXujn3FXWr8NBRPR2K05ghgQN0zv?=
 =?iso-8859-1?Q?r4bHxpKFWQleTbi3vH3PjwUighO4fnvTWmzw1A6mmamd3ErDFTfH2k7UdK?=
 =?iso-8859-1?Q?8YzXAgg0EJq5QUHsiXyXsouv/6FiHMyI71XyMF5CFEnVWCRJXf1grmuzdt?=
 =?iso-8859-1?Q?nkrE64AaC8+FmwKJfnC5X6Nl2h2PnGYkQ3FEZ/F66F+WUdpesbAHRx9RYP?=
 =?iso-8859-1?Q?Vqoe5NLE06sTEJXC44ZeXDDFC4eQcCK0FAjSP+i4/AAxdaSBX/ngUM5zyS?=
 =?iso-8859-1?Q?UctqmBiMHQZP85U7dJSBLcRu6e1lCIPWmOdIn9KxQWXfc//VcbTImqY5rB?=
 =?iso-8859-1?Q?X1W45XRjC2eF5bjTB0Cst0/ZmRh8XOM433tPF9K7WJYLxFkhd0xocPZT3e?=
 =?iso-8859-1?Q?4uoMgHNCFg7/RajHNfPsG/6nFViLXCdKxLNT3CME6GqNgBFp5BzKmrJage?=
 =?iso-8859-1?Q?q3dExrt6xVZ5FgCsFLuH0iw1wRU0mctqsKjgYfX9zBCf/tuZhF1lJwTKUG?=
 =?iso-8859-1?Q?AdakQhFEEUr/0xnjI7J1qmf4NNS1HzW7H2gBHxdRTivYFCJAhec+l2UxhK?=
 =?iso-8859-1?Q?0pdsHi/qbUNgxwbuU1krmcW2aT+cjKahCDNoyaukGDzXYCElkecafu6U67?=
 =?iso-8859-1?Q?t7O0P+5tykIM96UN9UPt1kPB5XAvkwtBcd7DTiFPUijgU/6LiJL1OD+6xp?=
 =?iso-8859-1?Q?GFs1vXetJxOiOxhJVcgw8/oW6+QAHOPh06cfENbBgDSTsTao5lcpT4c2LL?=
 =?iso-8859-1?Q?OxcDqTMSJ/5gVrtTzuSbDEaXwpT5/PFokVez1kUFh+NAomF2DJnzeouTQA?=
 =?iso-8859-1?Q?Vplm8wghcb6A1DFuYtpwDu75Co3hGFlf14UiC1uASuYj1WTR4bw6GLwhmK?=
 =?iso-8859-1?Q?mmkJkVm0hHIITrHXYxjiWYSh9Pz39T6GFkNEHJwmRa1ZgMNOkeE3vjcdVx?=
 =?iso-8859-1?Q?JqGRgk3XRHsU+3E5+A56rainY94Uulol+uDzw0XxokHhfK28cktCmlpuVO?=
 =?iso-8859-1?Q?T5AyGA4e1o87N0CX7w4b+CklYKkMZLJGFqHeyBESPt8NUroErPFuzff+2P?=
 =?iso-8859-1?Q?bhuPkVFqilxnTQW6ysA9HQUd5sH/VlXzeZ2WqA5IjnT9dgtD2raDoHE7vs?=
 =?iso-8859-1?Q?XKaSXz8Tjhl4nyIW7IixHyTf/b+Ab87NbNHfkw4bhreMWtgBYr275iZ8+x?=
 =?iso-8859-1?Q?eV31hrUZLTM04uCO87vHuy6XxS/AYDGuwCpWIe8BYfXQwqChhEzOujIjkS?=
 =?iso-8859-1?Q?had7NBh0RJkak0n2sLNNtKGOxA76DDPsAtV28WSA2+3HyQdkiX4A44IL4Z?=
 =?iso-8859-1?Q?E/T3m8Cph1RooXFknFY=3D?=
Content-Type: multipart/mixed;
	boundary="_002_PUZPR04MB6316E933E479EA23F39EC2F0813B2PUZPR04MB6316apcp_"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PvdCeqHLmD9Y0iXxCGLVIYiVoUxZh9aK2PaZ3zS4eeMTNwvlehlGaqMnkOyNFl/GMeIKfLDJnTLNwyvaR+x4oB1w73FjxLSNsx8vmwsUEwQIsekoYCYB+IhIv4bkSeT6gwxIGmBER0lpXVH7+NXL2oUe5vXehlq9rqOY8IT2FGNsvYC+HjJhXo9nEdDp2FcLIl7CVhliiDOrHXVzGQXE9o0oNG6u8KPXCAjD089tgOJ8d/o7BWJNHE3C723pJshJbQMg918KhNq8C9P/jSiYdJkdW3DAJmf2WmTspkGTsjDi+eGtW9jhOXnFZoi9aoLV2uHZqo8Aj9ZFABL+LWS3syyPEmJQ4xyr4+np0DsKhuZdnxAWnz8U97n3iOkh9pD0wlXE62wiBUE97Q8jUc2RpjgffBRH/7bYKYaiZzezvqnGvdqV90XY4hSeEzjzhi+qh0fyL4hWG3TEBCBZzhzDVbAZ0XADHpFeGdAyNrzYnsBtrb6RrwkieYdKJwkXoZvqhv3uVZzUPbVybasJBWqL+Is0GZLKSTkGDGLeAR9O9ctbWu0x1UjtRzY9H8Z2H2Fr8PkiEjeBLJmeUmZlIeYSdpJTppZ09DVaz7bBJp5QB79PiYnnk7Q4wa01Cc1baEEj
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b2f8bd-63f1-47d5-201a-08dd1d82e85c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 03:37:03.7686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +9I9dEaf0N3ke2xWSbyHdflU+quokOATZHnI8Ojcz7wca8ttQ0nZJsJbGStLj4SXx7E55YFBWESBUVMz6r1+Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB8299
X-Proofpoint-GUID: 4ZmJGACde6igyiQgs-IK6qh7HfPepvW_
X-Proofpoint-ORIG-GUID: 4ZmJGACde6igyiQgs-IK6qh7HfPepvW_
X-Sony-Outbound-GUID: 4ZmJGACde6igyiQgs-IK6qh7HfPepvW_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_01,2024-12-13_01,2024-11-22_01

--_002_PUZPR04MB6316E933E479EA23F39EC2F0813B2PUZPR04MB6316apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

If the file system is corrupted so that a cluster is linked to=0A=
itself in the cluster chain, and there is an unused directory=0A=
entry in the cluster, 'dentry' will not be incremented, causing=0A=
condition 'dentry < max_dentries' unable to prevent an infinite=0A=
loop.=0A=
=0A=
This infinite loop causes s_lock not to be released, and other=0A=
tasks will hang, such as exfat_sync_fs().=0A=
=0A=
This commit stops traversing the cluster chain when there is unused=0A=
directory entry in the cluster to avoid this infinite loop.=0A=
=0A=
Reported-by: syzbot+205c2644abdff9d3f9fc@syzkaller.appspotmail.com=0A=
Closes: https://syzkaller.appspot.com/bug?extid=3D205c2644abdff9d3f9fc=0A=
Tested-by: syzbot+205c2644abdff9d3f9fc@syzkaller.appspotmail.com=0A=
Fixes: ca06197382bd ("exfat: add directory operations")=0A=
Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
---=0A=
 fs/exfat/dir.c | 3 ++-=0A=
 1 file changed, 2 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c=0A=
index fe0a9b8a0cd0..3103b932b674 100644=0A=
--- a/fs/exfat/dir.c=0A=
+++ b/fs/exfat/dir.c=0A=
@@ -122,7 +122,7 @@ static int exfat_readdir(struct inode *inode, loff_t *c=
pos, struct exfat_dir_ent=0A=
 			type =3D exfat_get_entry_type(ep);=0A=
 			if (type =3D=3D TYPE_UNUSED) {=0A=
 				brelse(bh);=0A=
-				break;=0A=
+				goto out;=0A=
 			}=0A=
 =0A=
 			if (type !=3D TYPE_FILE && type !=3D TYPE_DIR) {=0A=
@@ -170,6 +170,7 @@ static int exfat_readdir(struct inode *inode, loff_t *c=
pos, struct exfat_dir_ent=0A=
 		}=0A=
 	}=0A=
 =0A=
+out:=0A=
 	dir_entry->namebuf.lfn[0] =3D '\0';=0A=
 	*cpos =3D EXFAT_DEN_TO_B(dentry);=0A=
 	return 0;=0A=
-- =0A=
2.43.0=

--_002_PUZPR04MB6316E933E479EA23F39EC2F0813B2PUZPR04MB6316apcp_
Content-Type: text/x-patch;
	name="v1-0001-exfat-fix-the-infinite-loop-in-exfat_readdir.patch"
Content-Description:
 v1-0001-exfat-fix-the-infinite-loop-in-exfat_readdir.patch
Content-Disposition: attachment;
	filename="v1-0001-exfat-fix-the-infinite-loop-in-exfat_readdir.patch";
	size=1707; creation-date="Mon, 16 Dec 2024 03:36:20 GMT";
	modification-date="Mon, 16 Dec 2024 03:36:20 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyYmE5NmU2ZTQ5MjNmMGFkMGQxYmJjYzA3N2U4ODdkNWQ3MDMxYmMwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+CkRh
dGU6IEZyaSwgMTMgRGVjIDIwMjQgMTM6MDg6MzcgKzA4MDAKU3ViamVjdDogW1BBVENIIHYxXSBl
eGZhdDogZml4IHRoZSBpbmZpbml0ZSBsb29wIGluIGV4ZmF0X3JlYWRkaXIoKQoKSWYgdGhlIGZp
bGUgc3lzdGVtIGlzIGNvcnJ1cHRlZCBzbyB0aGF0IGEgY2x1c3RlciBpcyBsaW5rZWQgdG8KaXRz
ZWxmIGluIHRoZSBjbHVzdGVyIGNoYWluLCBhbmQgdGhlcmUgaXMgYW4gdW51c2VkIGRpcmVjdG9y
eQplbnRyeSBpbiB0aGUgY2x1c3RlciwgJ2RlbnRyeScgd2lsbCBub3QgYmUgaW5jcmVtZW50ZWQs
IGNhdXNpbmcKY29uZGl0aW9uICdkZW50cnkgPCBtYXhfZGVudHJpZXMnIHVuYWJsZSB0byBwcmV2
ZW50IGFuIGluZmluaXRlCmxvb3AuCgpUaGlzIGluZmluaXRlIGxvb3AgY2F1c2VzIHNfbG9jayBu
b3QgdG8gYmUgcmVsZWFzZWQsIGFuZCBvdGhlcgp0YXNrcyB3aWxsIGhhbmcsIHN1Y2ggYXMgZXhm
YXRfc3luY19mcygpLgoKVGhpcyBjb21taXQgc3RvcHMgdHJhdmVyc2luZyB0aGUgY2x1c3RlciBj
aGFpbiB3aGVuIHRoZXJlIGlzIHVudXNlZApkaXJlY3RvcnkgZW50cnkgaW4gdGhlIGNsdXN0ZXIg
dG8gYXZvaWQgdGhpcyBpbmZpbml0ZSBsb29wLgoKUmVwb3J0ZWQtYnk6IHN5emJvdCsyMDVjMjY0
NGFiZGZmOWQzZjlmY0BzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tCkNsb3NlczogaHR0cHM6Ly9z
eXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPTIwNWMyNjQ0YWJkZmY5ZDNmOWZjClRlc3Rl
ZC1ieTogc3l6Ym90KzIwNWMyNjQ0YWJkZmY5ZDNmOWZjQHN5emthbGxlci5hcHBzcG90bWFpbC5j
b20KRml4ZXM6IGNhMDYxOTczODJiZCAoImV4ZmF0OiBhZGQgZGlyZWN0b3J5IG9wZXJhdGlvbnMi
KQpTaWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+Ci0tLQog
ZnMvZXhmYXQvZGlyLmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2Rpci5jIGIvZnMvZXhmYXQvZGly
LmMKaW5kZXggZmUwYTliOGEwY2QwLi4zMTAzYjkzMmI2NzQgMTAwNjQ0Ci0tLSBhL2ZzL2V4ZmF0
L2Rpci5jCisrKyBiL2ZzL2V4ZmF0L2Rpci5jCkBAIC0xMjIsNyArMTIyLDcgQEAgc3RhdGljIGlu
dCBleGZhdF9yZWFkZGlyKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGxvZmZfdCAqY3Bvcywgc3RydWN0
IGV4ZmF0X2Rpcl9lbnQKIAkJCXR5cGUgPSBleGZhdF9nZXRfZW50cnlfdHlwZShlcCk7CiAJCQlp
ZiAodHlwZSA9PSBUWVBFX1VOVVNFRCkgewogCQkJCWJyZWxzZShiaCk7Ci0JCQkJYnJlYWs7CisJ
CQkJZ290byBvdXQ7CiAJCQl9CiAKIAkJCWlmICh0eXBlICE9IFRZUEVfRklMRSAmJiB0eXBlICE9
IFRZUEVfRElSKSB7CkBAIC0xNzAsNiArMTcwLDcgQEAgc3RhdGljIGludCBleGZhdF9yZWFkZGly
KHN0cnVjdCBpbm9kZSAqaW5vZGUsIGxvZmZfdCAqY3Bvcywgc3RydWN0IGV4ZmF0X2Rpcl9lbnQK
IAkJfQogCX0KIAorb3V0OgogCWRpcl9lbnRyeS0+bmFtZWJ1Zi5sZm5bMF0gPSAnXDAnOwogCSpj
cG9zID0gRVhGQVRfREVOX1RPX0IoZGVudHJ5KTsKIAlyZXR1cm4gMDsKLS0gCjIuNDMuMAoK

--_002_PUZPR04MB6316E933E479EA23F39EC2F0813B2PUZPR04MB6316apcp_--

