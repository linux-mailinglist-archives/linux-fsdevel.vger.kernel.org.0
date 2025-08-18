Return-Path: <linux-fsdevel+bounces-58177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 409B2B2AACA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 16:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6EAF7211F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 14:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C2F320CD4;
	Mon, 18 Aug 2025 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="nqcYzZUr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013042.outbound.protection.outlook.com [52.101.127.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0037320CB3;
	Mon, 18 Aug 2025 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526675; cv=fail; b=O21jpb1U2QQYr9ctsYYsC+poaanf+ezc4cfQsLk/kBDYtv6sAGO6Odq3VyOlm9OUG7w8Yn57dpTO8xty2ExArZlhax0KQCoHphVbHq/ejWBUz09CYoL5jU0AmKquprWHhq5zfesl/fogDK/mYCoDa6T18S+0G3FeqJRipaocsrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526675; c=relaxed/simple;
	bh=I98SyTanDFQnLyxnzG0n+TP/HNvWSZdYk3Z8jzfzzA4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZwSH01VBS9DY2wmPQ3iVCmDY6EGTlGnim1P1v61sBHFc8+7wRCQ/pHLb59HH/++ohf9eAdw4Y9lMdvDSzHeP68FntkmwPPsaeVD3O8/JEbQVuskt2zh6w4z3wUbzOfRZNmq7iuWEig4m1TARyTDdggtzKXGTPYXOgETFmKNSQOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=nqcYzZUr; arc=fail smtp.client-ip=52.101.127.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YgbEnEvUEUp/NJCobfPZcZEIl0bvps2vJK5DzScUZh+zvKwkT1zx09Dk4V9W9FlV0vyVnbMj/yutYI3zxkmtnwouy5UpE40veKnK5kp1bqQgRoc0LelmTtkkvWvySwgp8hl8LhfTxM7VT90LWdnA9mAvpa+IqHpqC8yzxODVgcR9083QNlME1s/GEDmk9S2R0WSQUclItrhB2bBDi2zAo2OFx4npv0YxbHYAUG+SKCmZQiIYAFxC/E176AHdacCDwYb6O8qlHQh2brK8FQzC1TJdTTpZuO+1W2b4tKrFs1Jy2P+XNHj0Z9D/XTTKGtmnReNu7ad2Ib+XQjXNnz/d6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkdL2WbQMv55jnDBiXeI6smMb1rnYCLpd+K4ZkZUrWo=;
 b=S7MAJk6PHpqt+hBxVWysRXt58qicQOA91/+le/usXpOZtnpbCbbXFh+G8ROL1klcDzLnv+yAwH4sjl00Ojcp245S3OLi0mf0UmA81lsTZu64cA+Umo9qNg+cxLi9nmu3Y4E03++BgiqY8g2fV3zd2vPwdQw3OZqu/swIWgPr2Kkn7rc8klgsYmgyohnonjxLzjbPb8OihIr+Qmmy0OOJMSDsVeBGZlYQRO4Pbm0SfR7vPskI8vuS7KjEz7fzATCbOBUY029e/q3M7/dA5T0OB1g2XID6P7zm+Xv6IEa45NUw/6Q+seVfXkgIvBBReEBBIzpDHtNYlcGA9GLrTlaGaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkdL2WbQMv55jnDBiXeI6smMb1rnYCLpd+K4ZkZUrWo=;
 b=nqcYzZUr0kyLHqsR3Fco2jMWB5uThDyqk/CaMr6eSUXAZyf4ObCIGAEL+11Se67Bxmpd+iQgvH2C4jRclt3B6cZTFJojo3uZ2y8EmQ6csZuuTxAvX3r9X1QOXha6+OW4i3GIWVnZkGjjxtnM7gfwXtlgPTVQoFRxeiJDAJOPW/bv3dDaW+52ifdlx8wghNZbXpnP/CKEpbiTJWmoADKlAKoEVUJyRizJWRAhEATp8q/ZQEetUYToZarIluvrGcrGMrMQgCNSr5ca75tQW8AhvGWGr40ALLCozIfV1wYm92W2zLDsYqFG1mDDplj/2pBG10M6iySZvNc8mUUw8jmOnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SE1PPF54561D20A.apcprd06.prod.outlook.com
 (2603:1096:108:1::416) by SEYPR06MB6482.apcprd06.prod.outlook.com
 (2603:1096:101:178::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 14:17:47 +0000
Received: from SE1PPF54561D20A.apcprd06.prod.outlook.com
 ([fe80::460e:a381:581a:aad4]) by SE1PPF54561D20A.apcprd06.prod.outlook.com
 ([fe80::460e:a381:581a:aad4%7]) with mapi id 15.20.9031.021; Mon, 18 Aug 2025
 14:17:46 +0000
From: Chenzhi Yang <yang.chenzhi@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Chenzhi <yang.chenzhi@vivo.com>
Subject: [PATCH 0/1] hfs: discuss to add offset/length validation in hfs_brec_lenoff
Date: Mon, 18 Aug 2025 22:17:33 +0800
Message-Id: <20250818141734.8559-1-yang.chenzhi@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To SE1PPF54561D20A.apcprd06.prod.outlook.com
 (2603:1096:108:1::416)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE1PPF54561D20A:EE_|SEYPR06MB6482:EE_
X-MS-Office365-Filtering-Correlation-Id: ee4186fb-b242-469c-b5c1-08ddde620110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODVRRUJLbEkxNnpXTzlucWRvdUdjWTV0K0hoK3Nrd2VxZ3ZDTEM2NEkzeS9r?=
 =?utf-8?B?OXdUcXNqMGU3YTZoSkdZaWVCRk1SVWNybjBxQmpDTzNFME1DS3lwSDUxKzlt?=
 =?utf-8?B?TEwzK3dzekRvVUV2T0VVaGNWR3U5TkNtZWVhdlhMNEQ2MklXWFFMWFhTd3E4?=
 =?utf-8?B?dzVpbnU4VnpTM0V5ejB4WnBYTnJGWnU2ei9pKytuMkt3ZnpTTVU4czc4L0VX?=
 =?utf-8?B?c3g3S2d6QkxNd01FUUhCZG9kQmFCcEhYbFlGY3l5ZEtVQ0xUSmkwNmsvdS9T?=
 =?utf-8?B?Q01aeFdHM0g3QjhNczZEZGh0WmdpS21qRDhVTFdRWFhaUzNDbnNCRnBGeDdB?=
 =?utf-8?B?QWlRNnlUWVBzWDJiMktiU3NCYWdjc0lJcVJDNHJWMlovUDVZSTlBWm9IaHBE?=
 =?utf-8?B?R3d1Z1c2ejhNYS9nUmkreVdpSE1XK0FRTVBCTlhBa2MyZ2NvRElsTDRFcURP?=
 =?utf-8?B?bCt0bXozTFpYSHVyQ0RYdWl5SnVKd1NITkdPQXZHTEUxVFdlR3BBSUZMMEQv?=
 =?utf-8?B?RkxFWHNzUXkzdnBBdEdiVzFzYTNDdTlZbGJkRHpoN1pTeUpwdlh1cU1lYU4w?=
 =?utf-8?B?Z3g0bmNzMDlpa3o3Sm9oNTUzVlBuN2lJYjdWc1VwOE4rNmZiYlVMSTU0WEc5?=
 =?utf-8?B?aTVHZVB3QTgveHdXNXVnSWlYT2RRWjJ1RGl6TVpmMnUwNXdPY1Z3UXJRZFpC?=
 =?utf-8?B?YUhkYXNmL0d3SWRLbU16dGo2aHl5eld2MmI2TkRhNHIxY2xBeFA3N3hkdjBI?=
 =?utf-8?B?d1dRQUtQZnJLUTdUdzFXcENUcmFIMUVmVWlSdHFWWnU1UjFTWFUyMFlJTE5i?=
 =?utf-8?B?RkNIdDFmWVdlQ090Mm1kanNSOXJRUmRaRklaZVJ3NEM4ck1HQmdpY1lRRVFO?=
 =?utf-8?B?NU9HZENkbm11b0RaSi9tNDVQeVpqMG1wcVF2ZXphVlR1WU5RWStuMDU5NkdV?=
 =?utf-8?B?ZVFXZzNzZXJuWjJ2c3FWUksxbUQ2QmJNOE84UWM2VjEwa3o0NnlQZmNuSDFp?=
 =?utf-8?B?b3NkSWhoWWRWRGhnUlF2Vk5MNVI2OUdOU1N1Y0ZVZ1pzWlEwcVZ6QWJkcG5t?=
 =?utf-8?B?ckhCdTA0RGJ1dHVsdXJCMk51aUQ3ZW03d1JpUXF2elJ1M3d3M0g4aFZDelNk?=
 =?utf-8?B?UEdOK0VVTS90RHpHTlJJVExzWUlUbUh1dWFscG5YKzRBa2w4RDRndDBEcysr?=
 =?utf-8?B?TTRJek5rR0RFSk5sOFkzaVhYQUN1dXBsbm9JdGdsY2RVWjhySmJqT3ZySDZv?=
 =?utf-8?B?cGpjN0dIUHpkRjAzSGpvU0hVQXNqdXZXdGhSTHNYOGZ4TlB5NEorTTVObkk5?=
 =?utf-8?B?U3NuZXd3WU5hT3ZjclBuTjVpZGhmUldWdVFYMURHUEdVdDdudXJZczZmNThR?=
 =?utf-8?B?RDRrb3lCUDhwVVpzMHQwc05pdTRyWE5LbjE3SnFadGxUY2JRN0c3T3RVaFZ0?=
 =?utf-8?B?ZGxtV3hVYzF4dWxNSnRrSEQ4MEZ2S2JZYThrNHVOQ1BSUW1PVE5JNm5JbFpT?=
 =?utf-8?B?Y1pxaU8wSTFQZzJ3NThiWEtyQUNTa1UzVWJvN25PaWhJaUNRcmRGamE1ZlRQ?=
 =?utf-8?B?NVRmMU9NMUZSL1JsYUVlVmpldjRZcjNqeTVueVBiQ3lwa01xRThpNCtDelBS?=
 =?utf-8?B?K2YvSksweUlhRW9iWmlKcE1NdmR3dU84OUJEVEFBUXVsL3JncU1KNFp6REZE?=
 =?utf-8?B?Vks1M3dDSWtiK1RXMG5nc0xySmMvMk4xMlJmK0s1Q3lKMS9xU3BuZzNSWXh0?=
 =?utf-8?B?ZjdnRUNRSGc3QTlOQmN1c0srM1FYKzFuRjRFMTlJZ21nQVg4R2xCTHhXWW5s?=
 =?utf-8?B?ajN0QmVDaWtmS2FnVVNMUU4yVjMxREpEZEFXWi9XbStBMkhmOWVuMU9kaS85?=
 =?utf-8?B?WjFERXNzUXphdDZROXJVZk9TTEtwbWd4VE5OcVgvQmgxNWdTd1U0Q2V6UG1Q?=
 =?utf-8?B?ZjJMTWN0WDc4UExUa0Z1aGNUUk50QSs2cElvODdYRlBnWkNFRlpmL0FtRkxV?=
 =?utf-8?B?cGE1WlJaQVhnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1PPF54561D20A.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTU4OXN1KzgvU0VHeFAraFVOOGZrekpmWXViblh5U1ZueWhjNWpsVlBsTFhw?=
 =?utf-8?B?ekMrWHpWVFY0Q2ZyNTBlaXQ5YlZOaEJTY1ZZRTl6THpYRDVnTUJuVGt4dkZO?=
 =?utf-8?B?Y2VKSWEwenp2MS81cStTVkYzdkNIR09XekswU2JIOTBRUmFCdmd5cG1TS1pm?=
 =?utf-8?B?Q29yOHR6NXc5MjhwM1RyRUhNV1dIRHZTanNENXVxQmNBTkcydTltdkM2VXFS?=
 =?utf-8?B?cXMydVpLODNyUDY1NmhmcmZLclJxVWJHSmFEVGx0V3VnWXBHTGR2bnd4VXpM?=
 =?utf-8?B?ODV1WkY0anNKeFRDWnFmVzVZTDVMdmFwOUIwemluVUpsS00wYURDd0RqOE8v?=
 =?utf-8?B?bENqS3hhdnYzNDBEbGUrRWFkMUlLYUJJMm84NjRBUURCTC9GaFpDVFZuWmEx?=
 =?utf-8?B?Y1JOczM2TGFvREx6Lzd6dEJRWWdFRWYrbTB2ZmxPeDNHYVVJanZnWWcyL1FB?=
 =?utf-8?B?aFBMNkdWR1dGdm5oVnBzOUphc0U3dVFYK2x4ZE9hNDVBWldLcElxY1E4R2xn?=
 =?utf-8?B?SUthZC9KN2pERHBGTXFUdUFHdDl5cWszNjdnaXVzSW04T0pIelJjMjVmSG9S?=
 =?utf-8?B?RzdEZXJMbWJaa3pGRXhMdmowZ1c1VzhQTVNCTm9FN2w0MHNyUWZ0ZDJhQTRl?=
 =?utf-8?B?L1ZRZFlYQkVFT0laYjVYT20yaXEvdzFsYzNtLzY2cklvRUpWVVJWb04rNDFL?=
 =?utf-8?B?MnNpaHhjbGRoQjA0aEpCclVYM3lRckpsWk44akxkSjk2UTdWRHpGT2M2UnVx?=
 =?utf-8?B?S3o0TmlQcDB6d0gzK0t5bitpSFV4TlgrU1pNTWYzSCsrVzZJcHFjTzhzVUZv?=
 =?utf-8?B?N2EramlUa2xGREYydE02N2l3akRTQXliZHE1MFR3blMybHBkZWVwd0V5Tk1W?=
 =?utf-8?B?YlYzd3RYcjZvbThMb2ZuMHBrWEE5MTFmSzNGUXpLaDlaSzhBZVZKbGJMeW5l?=
 =?utf-8?B?dWtnZ3N3LzVwM3UrS0VZMS84c3NmdTJpa1p0azRhWlFsNitsTVdxdmFxTEtJ?=
 =?utf-8?B?R0RoelpwTVJ3VVpZK1hWMFliTTJZOUNVRkQzcEFZVnRDL0MwbnIySnM4cHdx?=
 =?utf-8?B?bGszUjV3U3V1eXVFblJPeU9IcGk5bGMwN2JCZDVnMkRISEVsYXMzTGYwcVJO?=
 =?utf-8?B?N3EvaWlXQ0hUTlNmQWozZnE0T1F2YmlZYU9EOHhzQVhmUTVnVlIzVHZVenIw?=
 =?utf-8?B?cUM3MDNwZTZjN3NPRCtMU1RVa0dmbksrQlYvR1lXcjFrR2pUVXJkczRtY0JJ?=
 =?utf-8?B?NG0vRHJFaXZoVFhxdXppdkpPekJDNVpiTERhRFZjRTJ6a2V5VU9Pay9GVFdH?=
 =?utf-8?B?YmJYYVovS2dwV25MTSsremYzVmp6SG11QWJGTUFqL29nVDdYVlNQenY0d0Vz?=
 =?utf-8?B?MzhaYzlzcWwxNnR6OXFWVFNOcjJmS3JoVkQvcGRhZktQZ1RPY0tKVWh6dUcx?=
 =?utf-8?B?cVJoQ2hRMVoxOTRhbHNPMll0N1FJeVVLYzJHajRLbEFEMHluYXA4R0I0ZzY4?=
 =?utf-8?B?Tk9pYllMM2ZYQU9hM1ZUYkZWZWo5eDVZUmd6bW9FVTdzb2MvWWlaUUhTa1FJ?=
 =?utf-8?B?Zm5COHFrWjVjVk1LNUVUdS9ad3hrVjh1UzlzeEg1eTYwTS81b08xMmwyZ1Qr?=
 =?utf-8?B?WHZQdDV3Q1dUYlQ5cTY4SlQwU3lPczNKMEZFZ00wQ2N6Uit3N0RwVjFOQ0kv?=
 =?utf-8?B?SWhwMHJiVENPT0gwOSt4MWZZcUNPdVh5STQ5djhDRWVKVVRCZCsxdGx0NDEr?=
 =?utf-8?B?K3czVTZjUlZwaVM3ay9zaEdtWFNicUxDVU5LR1ZwYTJuRVlFT3ExL3ovaHlI?=
 =?utf-8?B?R1BRZFMwNGs3WWZZd3E5QmZKMmhJMzVTbUY0WXhqcTFVamVXdEhneWlCSGtI?=
 =?utf-8?B?U2pHbUg2WHRwdjNOSGQxQ1dDMm0zb2dpeGJsVG9KMStMdm1KOXd2UDVGd2s5?=
 =?utf-8?B?Qzc3aTNZaFJhNk10bER3UTJwWnYzOGs0WnIxK1UvZjFhVHFJb2g1NFdSTjd6?=
 =?utf-8?B?OERBaWJHZUttUGRKRWNpR09FTEVIOExldTZUeG9EVUFVMUFaUHpYOWppK2Zq?=
 =?utf-8?B?SjJ5MEs0bXNodTFieUZ4akw1Q2lsVXNjWUcyRFJxNkthMFQvRU1NWFNnU1NQ?=
 =?utf-8?Q?rdq732QV/lg4rRAKbVfMZ119v?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4186fb-b242-469c-b5c1-08ddde620110
X-MS-Exchange-CrossTenant-AuthSource: SE1PPF54561D20A.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 14:17:46.7542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTzdKs6b/mo30QWlLg0a4lTQUA0/lU6oK/K24arh5Uh5XxwnStElqu/ZsOk8iJzwxDSVzB2AYK0UxKHNIScezw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6482

From: Yang Chenzhi <yang.chenzhi@vivo.com>

When running syzbot with a crafted HFS/HFS+ disk image containing
invalid record offsets or lengths, the filesystem may hang. For
example, in this case syzbot set the header’s second record offset
to 0x7f00 while node_size is 4096. HFS/HFS+ failed to detect this
fault, which eventually led to a crash.

Since HFS/HFS+ makes heavy use of hfs_brec_lenoff, adding manual
offset/length checks at every call site would be tedious and
error-prone.

Instead, it may be more robust to introduce validation directly
inside hfs_brec_lenoff (or at a similar central point), ensuring
that all callers can safely rely on the returned offset and length
without additional checks.

Yang Chenzhi (1):
  hfs: validate record offset in hfsplus_bmap_alloc

 fs/hfsplus/bnode.c      | 41 ----------------------------------------
 fs/hfsplus/btree.c      |  6 ++++++
 fs/hfsplus/hfsplus_fs.h | 42 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 41 deletions(-)

-- 
2.43.0


