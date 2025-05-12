Return-Path: <linux-fsdevel+bounces-48732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 227A9AB3402
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 11:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FDA316F562
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 09:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB4C2609CB;
	Mon, 12 May 2025 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Wf8xqb+j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013040.outbound.protection.outlook.com [52.101.127.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1C425F7AA;
	Mon, 12 May 2025 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747043489; cv=fail; b=OTB0Dmz4yP7EWyp+F1zGCWmns5tyACtQewxfTeJUgG3XyUiWMOHrJki6sxZu4JSmwo4HbHOh+mGRVfekHp0vlQYsm4r8pGjlUVf3oSdL7rJczDWSreau6412npZc2pjOc/lYRofsQsAAYd1L7qLl79RQo/ZDRHKuWswvTn1x3CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747043489; c=relaxed/simple;
	bh=lI89NeZ2t6ka0HmhJIlFeSQS0H+0iujoi8G68I1KZxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BEqyeS8lvd/Y505/9kR/XxVrDESdCP28k3GyVcgATVdgcAiTBI/8QPaIy4WBGADF/RqlW8D3CxXAek7bf2lkYMylK4/8tOloXT5S/xXUIOMZWGcxSW60+lGKFxg/o/mirs/iHUTVL+sCevWbtVF2vgVe4IWQHIM+OtdanQUyLMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Wf8xqb+j; arc=fail smtp.client-ip=52.101.127.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bT34ZZSXnqw79YJgYUg0bRt2yAvfPXmxs4iBntUINfACm+IQxYYGh+myB7bjSFEZttObKzXpH/p5JHN7nWwaycD25FIL+8BXeUHswsbP1qQwE6ox+D3+Jk2nOpscK70/xeOBaxxK5riS3HU9aLSL+aO3mg0AIA3B3CWUlTB0D1fg/4MYvcgoBkQSZxNT0lMZg3XUPxE5aI2JmI+h0KSK6YqslHVoDUCWGRP6BwSEvGeQXWhNzvRVSXGRe2le02uPLf2+xfunKrKtVllucBhyjXL7nONLb7Bf42s22wHanVRKPtiL15H14i6WXvVFWHl+GmxKcHQbtTAP05faaHdC9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lI89NeZ2t6ka0HmhJIlFeSQS0H+0iujoi8G68I1KZxc=;
 b=wJxWHGDt5o+NFD1/mg0wyAb7F0+OoZT6U5P7jBqNgBPkdaxVk69wbnCigW+5564Urrq/ZXSSPoge2is22qPydA631YF0vPZPvsl78DsACJL4d7AUgK1J5AWekItOuxcEemTTR3qiB401sVKR9tXbSqdCz+GcUkzh+1Yp1NHEWB+eD7uyEYsD7pS58wDbNUnbFKBkOvLhflhzC3+TNATlTfgdqjIWWFEvzx7GG4VM/zvJazNarWsLfmYMtjKOHR3EPY4m6rn7sn5lMH1SoSfRfdVztwW/6Piq4Dwr88AC8D7dVWWzRs0fv8R/qYsXaXPtIcaRz29/hrdqIOYCbdiCIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lI89NeZ2t6ka0HmhJIlFeSQS0H+0iujoi8G68I1KZxc=;
 b=Wf8xqb+jBEKtwKefloqcr4Myw5kD/yjhfmA3siACEA7sorXFiHs2y6MNVwsmiXY7lN5jT8TFa32ZfzPlrrxAG60+96JCuUPAzso1y4KSF2EAnbfz98zxpl2QhVMTYKl2zB0ZrANRocHyTR9UNZ3NncOG3vVOw/qzdWZVGxeQYu6g7iWdXIUhF7OReqebG2lmWPE9RIjeDBMsmYeowzKPxqeKkeGCybKtAbFWWCTqitUz1fMez97ALaPxmzGsxv2umh9CNrFxd74ZrwAZrz6GxgZSlGd8t/dqWall/k5r/H2Shftrv1kzgaimxiAwPpQ0LzrjNd6iitPO6Z9wBP4Wbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5310.apcprd06.prod.outlook.com (2603:1096:4:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 09:51:20 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%5]) with mapi id 15.20.8722.021; Mon, 12 May 2025
 09:51:19 +0000
From: Yangtao Li <frank.li@vivo.com>
To: ethan@ethancedwards.com
Cc: asahi@lists.linux.dev,
	brauner@kernel.org,
	dan.carpenter@linaro.org,
	ernesto.mnd.fernandez@gmail.com,
	ernesto@corellium.com,
	gargaditya08@live.com,
	gregkh@linuxfoundation.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	sven@svenpeter.dev,
	tytso@mit.edu,
	viro@zeniv.linux.org.uk,
	willy@infradead.org,
	slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de
Subject: Re: Subject: [RFC PATCH v2 0/8] staging: apfs: init APFS filesystem support
Date: Mon, 12 May 2025 04:11:22 -0600
Message-Id: <20250512101122.569476-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319-apfs-v2-0-475de2e25782@ethancedwards.com>
References: <20250319-apfs-v2-0-475de2e25782@ethancedwards.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SG2PR06MB5310:EE_
X-MS-Office365-Filtering-Correlation-Id: ac72fc09-9875-47ec-d1c0-08dd913a8b99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2fXLrXQg/sX0ub2+lZ8leqKHgM6yNAhM50DzSgSeu9wIRUrDR3ouBLda4chq?=
 =?us-ascii?Q?ZirfJBlBb3AQ1z/fMrdCDnsV51nHrju7TzCQNdkRSgp1UYOilz1Yoh5gr/Py?=
 =?us-ascii?Q?2a5ylCVPnOevGHkgF/voj/ic7pZnQ6+ENQUtD6uBzygV6eBLwwoTzD6U9QPf?=
 =?us-ascii?Q?Oq7G5c9g9Z7pv5WA9c+Uy+4TiMA3ZzZRpKR/OUwue4kiYEsDdp92AykAbyup?=
 =?us-ascii?Q?pVBte9O/9/qaRqMKQ5flokYc7S5SEvfmdI6qdVZUDZdZUofqKtp8AUFsHQNK?=
 =?us-ascii?Q?V7Y3+G49XBqlswRfA55PATt6RY5wJsZoOoMlfnzqmzESh8UhWIGRVg/aaaN7?=
 =?us-ascii?Q?kI+U4PvungQsDYo3PwMnsGR/dDvBDNRG9Ng+N7qjJvty1dgOoq1RIe/uPkbk?=
 =?us-ascii?Q?9PnynpaoyOwu6GIn1Beck2/AZJmI6B0ppzzPFSuOG140eDzpD6S7IUzTCO5V?=
 =?us-ascii?Q?LNi3XguzvFVRPxf2ngLK5hgJJHQfQi2YkYS3JuxV/1Ht9hRnr81b+1PO5L1a?=
 =?us-ascii?Q?Tr4tadk/w0nokozJl/FelOLOXXw9LjSB31mALT8L3KDfO74qFcyjO/vewf79?=
 =?us-ascii?Q?n/+5M+aOMUATeI5JzpkLsmfszzY23SH1BWCvxllbPIc0S0nBub+WZhUWSyc9?=
 =?us-ascii?Q?XJKDLZVNB7WjrCbQPfTyw8RB4PdE2cqlFPgs60kN1bLWnh6T0mtIkuABgmSX?=
 =?us-ascii?Q?fnj3l5/ZP0Oscx94W4A2YYQIIpja8Xphsa0AaM+GrtIgcVHzn4vQDJEVyTEb?=
 =?us-ascii?Q?cBj/M7PUf8q2yj3cDHv2QYHxzY/aUD7dRDX5316alKzfGMk0LGTLTGcRUZG/?=
 =?us-ascii?Q?7Bt+ZO1ZOz/rACt5vP0jgPkJx3g4yPSkNxRwJrAyKBV2PcXVtrwiEqgLnSdZ?=
 =?us-ascii?Q?P8pg1eLsHgzOi7Ht3lhT4WdwDqMMRKDivFSGqqYyhQRhBxih9U0hcL41OunF?=
 =?us-ascii?Q?eDHc7PUTtdD5Jf7HGB0YSRlgZFmhrE2pkuGVmo+NJhiWxmRo8Eo6SSb/ReD+?=
 =?us-ascii?Q?7Z9dmJqR+BfhK5AhKh1GQqvRAncqYgPi+gwfgAb6oBK5cseP7ppenYLTLnOS?=
 =?us-ascii?Q?jQTnrXwe9kmVZYdILULub9u8oOrG1vo23zbCY8joYHOLR3epXhkFf9Pbx1RS?=
 =?us-ascii?Q?BQZFmm4mO6XHGtNhV4JsxrlkhM5Vtn79W9tyZKHntnvx+58cNudjHZ7T4z1k?=
 =?us-ascii?Q?pEFAuvpGtGQ9asLqFvSiVQYeJ79Oa4bnKtSXcjahn13WdwrmYYdz7EwWZwRm?=
 =?us-ascii?Q?4hrTz94L4NWDrq6hjA76mrAY6zt3WbhV8GGYsgQ+Q93r3DK8adLaI+qIA7rS?=
 =?us-ascii?Q?c19cJqOQLIKA9Dp01+pK2LEEF5Br8el4yNStI2zLyZUSTPfU3Cp/wqamYFew?=
 =?us-ascii?Q?4NxcHTB10ApOpwKlIXE8cU8KR+lKki5ggIqYiWI0mATO4yHUcAdeDvmR7YDa?=
 =?us-ascii?Q?y02bqMp2vzb5WnJyARJvojaOTUV6oJbfSbACgc2BM1lYyRjjJvJvNw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JL/GLaEG6eUhkrKp7PivJwqFMIsI5wkU8vaztv3zUyYtsKL7I/FhmQ+bg/A+?=
 =?us-ascii?Q?SLfyc2/058WWtlgKMmcX3+wCsj5vqgW6euUA1wR8zKG2UXvVFFnhGEZkwTr1?=
 =?us-ascii?Q?CQdNuabmozPneO1pltebpiVpBmM/CkzgxaDMG6yurz6lIzNqV1PehK92t/+h?=
 =?us-ascii?Q?PzgfmLPWp96mWBrCwZx5KuDKiRqLbdrJzxYNS2qSgOfUxC7VwG1TY2Qo+ya0?=
 =?us-ascii?Q?gn4AUcVXvtYE0GgiZN2efP4mb3R0vMNMouX59hmXu9ovJRLfM06RHpcAmPG7?=
 =?us-ascii?Q?4lwJs++iLD0hu4vZUQ+v0ntLodQ6xo2nMp9a/GPIJfXJesHbMHiyZzX5btVy?=
 =?us-ascii?Q?wQuYiM2WDEcBIbfzJ/nnGfXDLYtieJ1yQmUv3HVnzYQFkTGYX7cz3hS6u9zt?=
 =?us-ascii?Q?td4MD0q4E5Fq8HiUUDtbjjK8v5C9349koSwkUkQbhxdvCsA0p78kGeEHMsVL?=
 =?us-ascii?Q?TlmHRG2a2l0tx/q65PCw7sClDtcLzbEzUPn6iT0g0pfaEgjgeai6v9ZC+Izi?=
 =?us-ascii?Q?dk3yWNh2mhYOrtFYATKGNmft/QX+hQc6rGpCpzeFLVuLQ4hILMVosSYkTamZ?=
 =?us-ascii?Q?BJCmMIKB70NRffMYBboSFmDXSGkQNAolonGceFMklc50AYAx7CYsINBPypkI?=
 =?us-ascii?Q?n0xEj2vlo9KbMnbqLUpc8y5tLfNdZBMMabxvv/BhhH3v8YfxxTbf+ZT5FsCV?=
 =?us-ascii?Q?D6M9tr/1KYQqlhAmiXW2HEVOii5NVr8HjnMB5alZ7xX5VTmEBi9I4QXp31lE?=
 =?us-ascii?Q?oL1RRyU2/R/GH8vnSn7aUTpZ7NBmLIlt9Gsenb6/WocqMQh9MWN7Y7F0dNdy?=
 =?us-ascii?Q?0RGMnDChck9ht5/kJh3iHTeGEZfMXi/xEzNhkkJWixaGeo2+RtnmFY/+/s2P?=
 =?us-ascii?Q?HKHOEuZIXqFVP6tZFByShbgCYvyDKaiJdy0IlZKwCAM1HcrTGRcPzkjyokm6?=
 =?us-ascii?Q?mJ/puEWOsvsbSD1JDE/2G0wtW8Wi0lM8sQl+FBYReKCANf+0fZeddJFxJEXX?=
 =?us-ascii?Q?4iAGZTtU5Egl0bAH75mKKyH2YjlFRxxs7AIkffQ6tmPqC8Vhz0j1PDXWqvgD?=
 =?us-ascii?Q?kPMBAKtxOLo+Nrz8t51foUY4I6De+vmTxGLb6+6DFIvFdBvDJi+0Wh3tcXUx?=
 =?us-ascii?Q?25gjdteQxeKgpJ7NXakOQLaVm3M1+OgiT9RsWZppbj2XsQF80QDdVmcqdvna?=
 =?us-ascii?Q?1WvdbXqTGmPNDfLZHtTlIOs1onUFMx1xDTu0/l49Z9Lt2c4OK4j/ZwMX7+Ms?=
 =?us-ascii?Q?coKPLyblF3LHGezCo3+h5BEV4YRPV1pHeCp0GD7BIfewHufFRlgnwGyti7QD?=
 =?us-ascii?Q?L39kq77EoNekLoQCvQdRf9mR04OyY6vILvediojbvgD7SiEqtgM31Z/uTeDF?=
 =?us-ascii?Q?s724fKxrkkPrmHNUIZPJrzDSZeLwXHLVWakK926FMY4wLU4ibofmC9ReOWtQ?=
 =?us-ascii?Q?buQmjacb384gPTnaHlYQO+nfSg5ZPfd6EGLvG8p4zSeXvR+K7QCFm6XrNOKY?=
 =?us-ascii?Q?+XDGAOyFaM4YJgRVnvHHs9TIGHucnQllLXuLUDKOypTGkkn0vSA+nYuNjfU9?=
 =?us-ascii?Q?6d5B+lX6Q+5tilaCObA4nu7NmdBkrj6UTx9jFaH5?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac72fc09-9875-47ec-d1c0-08dd913a8b99
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 09:51:19.5391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PlR4iDtZMyIPhLJicDqjejb+ngIF/dWCtOACPx47zGKf/I379CatrKIdoAfnPPB+b09v3+qiE0J3xxyMpU32Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5310

+cc Slava and Adrian

I'm interested in bringing apfs upstream to the community, and perhaps slava and adrian too.

Thx,
Yangtao

