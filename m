Return-Path: <linux-fsdevel+bounces-49131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B97AB8618
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 14:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2E6188B568
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 12:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D19729AB1C;
	Thu, 15 May 2025 12:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b="GMVLIy/e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010031.outbound.protection.outlook.com [52.101.229.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E409E298C20;
	Thu, 15 May 2025 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747311173; cv=fail; b=fxFEm/xcqJrUUxNANDevkskf/bzylWgAU3m7tplH2t/65YL8Ju02ROyUjQyaTv/tnx+Fv1lucHwid18tlYHLlh4UhmzHfJ19OdDH6KiVh66z86Xsqjg++8SenL2fjHDGc+7V/Vv4ybl0vyXPiuuJ6f/SufnVxq4Ug0alI1V9vEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747311173; c=relaxed/simple;
	bh=OMEQchUtSebus/RVG8JkusHE1omv5ILOncMEMfnOxIA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LxeqcL/6YjHCVWunJCR0tE/+9jByCEFCpWa4/Jr91gUrS7mC3rDKVlH06tKcLS5JE6bLoPhJ+RfHuIVlBGZFOQSM34dYw7B42UKKzTOfkiBE+y5LtJGS7D2Vdwu8lg4EoIXi+AiE5FFt50pkj/jDT3Y+nfgnma1JLpk7XsWwYj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com; spf=pass smtp.mailfrom=nec.com; dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b=GMVLIy/e; arc=fail smtp.client-ip=52.101.229.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bl2wVvPk+1mKPcSJPYuTXVY+EE27jnMkXWbVm+kJlPjYyjzY2skUqA5LF00fbb8PcbuizLTBo1ehSiQwhP/2Oo66Dm+4QIo4eDfIaRiC5N01y1T+6YZOrLSOboAVp4pD/yKXD8g5vYeCeYff1P1Ev+qBt569ZWSRiuYLr22guvb/ig6iKfU9NTv+CdQyZdz4w+ZR20k1X0y0CNsDhde3UdmO9JdrdfHF82+ivhwkHoY6V/XNt5z0dGo46C4qDegWOHNMBAzQm+G90Fp2tNhIUVMdrHINCCQd1NNae4NJiWbTi/TRzD7itvvJL7GkR5r06CcabqSVJ2aUmo5nkmtlMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMEQchUtSebus/RVG8JkusHE1omv5ILOncMEMfnOxIA=;
 b=ftsaT0s7WPLkbflc1lzbXcyITNb5JKIEAnvhAOdGvzJFF4AIYceT8aPs6xw1oquqcvE9QFk8NNBNeLlu5/siAFMDBiEbfgLnTs1OBtruCH0JmgSsn5nmip94U6tkqgLcbSdivbTLQ9vyz73Vu+4lRblrLvieWt3vnTnH97T+8F+jZPdkHEbBwNv2e1Sk9YAeHIsR1NKh9woOJWLneqcfXAfvf6fWL0T1utDQDEFNkml6hAZGP5DQhSlfEA7jJbzQllrB7VirTA5tgY9cr4+8iarH6jHqqEYremrydU+SwoYGrOkXGKmXLkmpva+/dnlzE/7HsSysRyh5xSqej44+3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMEQchUtSebus/RVG8JkusHE1omv5ILOncMEMfnOxIA=;
 b=GMVLIy/e2L43ZKSwzMbHPmD6tClJeThFdye0I47Zz4kT47eAB529Zdr/7cIch9gemlFtgGA7oClSskkvQ/R+ebOyLXR9QEK6cysEaUvYCROYNtD9EuFtoM/qduQYP6IGJX2XXf8pF2x0DUtLRGpSdkvy62tjo/HmY1ds4jrw9wIq8zKFN20m9fq1M62L20qfNOuGUKjQzZn6zBRR8NGa1WZ7lKGfHoAR2qR6N1CoUbHusrqpLGpkDAjvv/ASUbr7Yw2y4CqJogU8qXhoazTFumZsMZ7mhOHABMbSuyHPUxqMOJ1BvlALZc4zJQhFA3UzGZ6IeXTm92NCGuDnOgw6lg==
Received: from OS3PR01MB9659.jpnprd01.prod.outlook.com (2603:1096:604:1e9::7)
 by OS9PR01MB14206.jpnprd01.prod.outlook.com (2603:1096:604:364::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Thu, 15 May
 2025 12:12:47 +0000
Received: from OS3PR01MB9659.jpnprd01.prod.outlook.com
 ([fe80::9458:e2d1:f571:4676]) by OS3PR01MB9659.jpnprd01.prod.outlook.com
 ([fe80::9458:e2d1:f571:4676%7]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 12:12:47 +0000
From: =?utf-8?B?S09ORE8gS0FaVU1BKOi/keiXpOOAgOWSjOecnyk=?=
	<kazuma-kondo@nec.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: "brauner@kernel.org" <brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>,
	"mike@mbaynton.com" <mike@mbaynton.com>, "miklos@szeredi.hu"
	<miklos@szeredi.hu>, "amir73il@gmail.com" <amir73il@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: allow clone_private_mount() for a path on real rootfs
Thread-Topic: [PATCH] fs: allow clone_private_mount() for a path on real
 rootfs
Thread-Index: AQHbxGbDT+OhO7ZF6EeAP0BuuYit07PRazQAgABi9YCAAK6fAIABH8GA
Date: Thu, 15 May 2025 12:12:47 +0000
Message-ID: <46dc7517-75dd-48d7-ae01-1574b49040fd@nec.com>
References: <20250514002650.118278-1-kazuma-kondo@nec.com>
 <20250514024342.GL2023217@ZenIV>
 <9138a96b-3df0-455a-9059-287a98356c4c@nec.com>
 <20250514190252.GQ2023217@ZenIV>
In-Reply-To: <20250514190252.GQ2023217@ZenIV>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9659:EE_|OS9PR01MB14206:EE_
x-ms-office365-filtering-correlation-id: 6e603d95-5590-405c-8b4e-08dd93a9ce50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZGVVcWl6THdPNlVrdUt5SUFEdW5TOGVSblpNUU9lNEpZeldWMGxwSUZVdTZ4?=
 =?utf-8?B?TmpobHlFaEhEWi84Z3RHRTZzWGVUV0N0MlNFdlRJTms4OWpkdmZQUmlhbHEw?=
 =?utf-8?B?V0lJQjR6YmlPL1Jqc3Q1aFNDc0JXMW1mTk96ZXZkOHZUQ0RwZ0lpUFRxeXl5?=
 =?utf-8?B?ZVZKbUwrYkRZMTBlS1RRRkdVZVdDY0YweEd6cUo1OWZ5UGVyQ29qSG5WcDJv?=
 =?utf-8?B?cFpReUs5cmR3T2Y0VGZZK2FyUlBvMWJTZ2pjaGl0V00rcmV0RHpBbjFKRkk0?=
 =?utf-8?B?eCtzaThCeEdIRjAzdlJZZlRoKzNZdzVPRWpCaEhzVW95cW01V2JDbHI0Smt0?=
 =?utf-8?B?VjZzT1kydFVUODNMeE1vYUNzSjR2MTlVdzV2d2w0L3BPYlJjdnVtWHBkVmdH?=
 =?utf-8?B?RWZ1TnBlVEc2QlFxL1RZRENUVStYejEvVGlWK0Myd2lXZUJ0Q3FQVjJIWUs1?=
 =?utf-8?B?VTZLR3RXT05TamlBWkdVemE3SUdObkhNdzBjdkRqZHRCSnp2Z1JxUk1oVTla?=
 =?utf-8?B?WUhvSkxua1p3TFRtclh4REY4SFBCR2dBTGJBR2JiTnJna1RWMUcxL1VCNHFV?=
 =?utf-8?B?QXE3UnhOSUpnTm9LUHNOTlo1VWdwS0NMNGRJZDh6UFY3L1RhbjE5VFQyU3k5?=
 =?utf-8?B?dzdUK3FBaHRzZFpLakdvUmNSeHBTdkRJZ21iRi9XeVlOREZZaEJ0NWNLRDVs?=
 =?utf-8?B?NkhoT3hLK0VmOHBJZ2lCNHcyQW9BbzZpc3RVYlYyRzlwV0x1WEdpTThzTjI5?=
 =?utf-8?B?djlRbzBWbEhnMC8yZzU4cVI3SWVuMnBLZ0MvankwOCtneVkzYWp2L0p2Y2J5?=
 =?utf-8?B?MC9Mczd2Y0Mya3N1VkxEcG1ZNDcvU0IyYnlJZmdaRDlCSmZSTHdOSWtiSkNF?=
 =?utf-8?B?aURCZFEvODh4NUdsZ2lhUmVhcE9RMEhoRkYwa0IzK2lqYnU3aXF1clR6WmtH?=
 =?utf-8?B?TzdpaFVHdWZwZU90MWxqaXZxTnpkbk44RW94V01IZ2Zza3ExNU8yOGovN1Fv?=
 =?utf-8?B?WnJiSzFYN0pWNTVacUpHNDZuZ1lkc2FKM0hTQ2JMYWU5N2kwc2R2emlxckRJ?=
 =?utf-8?B?aVA1S1RQY1BaVURGazVRdW52VlNQNVFITi95WDlnY2Jyc2ZWN0F0enVCdExY?=
 =?utf-8?B?OWV1dnlrOGFXd3RtRUVEUi96emhzd2dhenJIVWQvY2ozTnBtRStneUdkcm4v?=
 =?utf-8?B?VnZSK0FQL2xmRzhtcnFiZEIzOS8xWDBwWlR3V1dSRmU3bVRBRi9NLzFienVq?=
 =?utf-8?B?TDk5eXJMZVNlQVVkNERDM1FSV1R6WkNzZTAwS0xzWDl1bENIY1JOYWZQRlN1?=
 =?utf-8?B?L29tSjBzSjVRcXJRREdicVpabFpoYk0zcWREMnZTY0lrbUoxckZsVjNGNGNu?=
 =?utf-8?B?Nm55U1g3OWh1NzFZYy9EMGVTRVFrdEZzbk1aNUlsNDFWSU5iVFhjR3JEWU05?=
 =?utf-8?B?RFZkbUNPOFlxTXZ3cDRUaUg2ZXFVTkFDTGYyRTRhK3V3aDlMMURxaWdaZDBS?=
 =?utf-8?B?a0lvcStocmFzYUhpY2pZQkF3TjNjK3VWMVd5VXJjRzBNaUJ2MmRtUEdsU2ti?=
 =?utf-8?B?TDBQUUNCVlVUQVFCRHMwNEtyRk10eURsdXZrVEZHaWdncC9BNkkzQldsVFkv?=
 =?utf-8?B?UiswNndGSGlTQlVlVWpGYk5vc2o1M29hMzB5QU1MWE84NnZ4WnVHM1ZEYW5I?=
 =?utf-8?B?Vm9iTjBaVUJpd2hLeUpwd01venc1Y0N4YlpxYmtZZkhNMElDMlRKQXpmVldz?=
 =?utf-8?B?eTZtYjg4bUJuWnR6ZUlFV21KTVRPenZFSFExZWdETDZkcG8weHZ1QzlSK2xx?=
 =?utf-8?B?TWl2R0VXSFZmSitOQWp5dUREUkZVSTBBcTFoNlNYQUxuWCt3WkxMN24vU3Bj?=
 =?utf-8?B?ajk4K0RJV0Vlcno3dzNuNSt4UmJ2MTB3REVlZ093VE1GMkZjSkp4cnl1SXMy?=
 =?utf-8?B?aUFIbkp2ZDBnRGtOZS9qOXhiVnNPczdZa01oODZHdUViK3l3MCtRaDd2d2NI?=
 =?utf-8?Q?tSPmDb3CtLJvrrwbutrkNY3B4DJwT4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9659.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UUhqeEhzVW0zVWJYZU82VFBXN3gway92c0xRYitmZHAzQitUMTA3UkhGT01H?=
 =?utf-8?B?TFZ4Ry9mbzNKdFFsd0NFbXRBTmVxZDlrZkJVL1FLU3BXMENMUW13UkoxQUY4?=
 =?utf-8?B?MGZwS3RpTGFYRVB6NEQzN0JsZlRnNnFyQTN6ZUNGajc5NC9lNVdWUmJWbE9E?=
 =?utf-8?B?dXhlOFFUelBURVBkTGxxVFFscGsvWkdhYTBuZ1Z5M3ZDWFFWamNEMEUwajVH?=
 =?utf-8?B?c1BUUmVUWkRGLzU0NW56Y0kxQjdNRHBPSDgrZjZ5Vk0rWjJPVVYydmN1ZjRH?=
 =?utf-8?B?b3Rjd0tNSnF5SGhtZHhVWUcwa3E5VXFPcW9RMWRNUDBualNBWDdiaGZickV4?=
 =?utf-8?B?RzY0bG9RRnpDZ0wwZ2d0NnRFVm5MWjAxVDlXeUkvaU5EaS9OR1NFSy9GdTJr?=
 =?utf-8?B?RkJwUE5qM21CR1lDMkdXT0s2QldzY2Zub3FtWVZjbUFMNFRNekpsd3U1UWFB?=
 =?utf-8?B?T1VHT2x3NmwrbmM3akpld2JOU003UTgwTUVBUUZtam9SZlZ4ckpmYy83NTMz?=
 =?utf-8?B?ajNwODlUWlBDRE96OWxXLzRoZGlleVRPT2UxY0NTS2M2bkRYQUNhOTZ0a1dZ?=
 =?utf-8?B?aGdMZzQzM0NFRktuY1l6Wm1uNVlnOTJXTWVqcktleThlQmJoakRCUnpoUHpk?=
 =?utf-8?B?UWZPUU1UVk91by9YaTAwZEdabVJ0Z2FTKzdCZmp0Q0lZMDVhQVE0VnlsS0Nv?=
 =?utf-8?B?eXJEZ2pnc09BOWI2RGNjeFMxMDlLM2p5SytrSDI3Wlp5anBRQkNZbWNRREFQ?=
 =?utf-8?B?bUpDR0s5MTJhRUoyMjhJMDUvMHRuYnRXS1ZIMmU5YjR2VU92ZmlmbUM2ek9s?=
 =?utf-8?B?ZWxKdEphWjc5WU01VDBpRG5LOUp1WEVZano5MThJUDAweVhQUW1tazNybGlx?=
 =?utf-8?B?RGJvLzRRclhYa3pXZkZzMlhrNWlXWlNiN3lMWHdwdTVFVzlMTnBxVDZJdUFn?=
 =?utf-8?B?REpQL2JRK01jTzFFZTJSZ0pBYlJiN1dMalBRdElBLzN3Z0hXd0xRbXNmRitC?=
 =?utf-8?B?dE50b3cvMm5od0EyWlJSZjYxYU10ZENPcXBJWmw5QmNMYzBEQ1IyUGVScTRs?=
 =?utf-8?B?WmNSamo3S1lXbzliTTdEOEUxR1huNDIzUnorV1lWOE9EYzV4ZHBPUzVOUlNT?=
 =?utf-8?B?WVFqaUlZOUNROVhBRGxId0x3RlVjb1VHT1N0bTdXOXorZzJ0OWpOYzRoM1Ry?=
 =?utf-8?B?aW9QTElEeE12QW9Nd2tzRlNoazd2VXlOYW93U0s5amZhbEhPU21tNDRUN2ZK?=
 =?utf-8?B?bG9VTVQ3OVdxOEJabVpQaC9QNTlmOUhFQ21hN0xmeEdSb1R6dDJncDdLS3V2?=
 =?utf-8?B?ZWNrS2pmT2MyblJQdllnd3ZDSmtPZDl0eVBLalBFZVVwT3pYSkRnYVpWbFYx?=
 =?utf-8?B?Qzl0THdpVEk1dUNYSG5GdXg5czBwTlV2OW1tU2ttUDZOTTdDZmdvSlRzd25j?=
 =?utf-8?B?Lzc4dmFpLzViNU8wTTZvV3pCdjJXdjFybHNwR1hDc3VlS2w1MEVtemNLSU00?=
 =?utf-8?B?b3ZEQTZPcDZsQ0l0OFhyQ0J4eGJSRVNTWVVWcnlZL2lPMEl6R2FDZDk1ZkNh?=
 =?utf-8?B?ZkNYZnhkRVdPaDVCVTZEQnBoSG5zYUYwa1RTbW9mcDBBZFBIUlRCczBkMTFX?=
 =?utf-8?B?KzVWNHlYT1puaWUyLzJLaCtjdVpKeUM3MmJhWlNaUno0VFhWM04yV1JJai9P?=
 =?utf-8?B?QjR4VE95b0xpbUJtcXArUWVzdFVmRGtLdzZwYkpnUzBZdU9zY0xIK3JnZ3VZ?=
 =?utf-8?B?aHBNazBFalhGbTFod0VNelVSbjFTRlJraEZjSUp0d0o1M3dVWFZ0VHRCNytM?=
 =?utf-8?B?Lzdkb2dnNm5SYW85RzI2MXBDbytvWjlVQXMzdGhHcEJqU2dHczk0V2c2SDZW?=
 =?utf-8?B?ZXhlTmxkdnZ3aFZ0OXBWSi9lL3YwUG5EN1VwR0tPc3lzTm12SDd0NkFzYlJ5?=
 =?utf-8?B?QkNmMnZPTDJGTkhlZzRjSG92R3UybjJ5TWRXbHQ3REZSS1EzMjlrNHpsU3A0?=
 =?utf-8?B?Y3JibTEwYmlyZjU5blBhbWpyWmR4M002bm1vYzI4K1gzSGRocFFTRWFVQzc5?=
 =?utf-8?B?QzBvSTVyNm5pc3J2QUtBQjNBbkVUMmNvYTVQeW1HZ1VKMDRZeVp1NUZwYlAv?=
 =?utf-8?B?Y25XT2ZEQkNBNDlmQzMrYzZjdlBKb3B4NjRkZGxCWkpXekl4TkpmcE5jSFVa?=
 =?utf-8?B?bkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D6E333B07DFFB4584926EDD9DDAEFC9@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9659.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e603d95-5590-405c-8b4e-08dd93a9ce50
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 12:12:47.6397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KvN9iTT4ui44XkFOBXqQyFRpca+/ngZaVBhloQtRSvqnoO7v2gXrYgaxFSMnAhFAGvGmzlI1VROjvzMRJAni7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14206

T24gMjAyNS8wNS8xNSA0OjAyLCBBbCBWaXJvIHdyb3RlOg0KPiBPbiBXZWQsIE1heSAxNCwgMjAy
NSBhdCAwODozNzo1NEFNICswMDAwLCBLT05ETyBLQVpVTUEo6L+R6JekIOWSjOecnykgd3JvdGU6
DQo+PiBPbiAyMDI1LzA1LzE0IDExOjQzLCBBbCBWaXJvIHdyb3RlOg0KPj4+IE9uIFdlZCwgTWF5
IDE0LCAyMDI1IGF0IDEyOjI1OjU4QU0gKzAwMDAsIEtPTkRPIEtBWlVNQSjov5Hol6Qg5ZKM55yf
KSB3cm90ZToNCj4+Pg0KPj4+PiBAQCAtMjQ4MiwxNyArMjQ4MiwxMyBAQCBzdHJ1Y3QgdmZzbW91
bnQgKmNsb25lX3ByaXZhdGVfbW91bnQoY29uc3Qgc3RydWN0IHBhdGggKnBhdGgpDQo+Pj4+ICAJ
aWYgKElTX01OVF9VTkJJTkRBQkxFKG9sZF9tbnQpKQ0KPj4+PiAgCQlyZXR1cm4gRVJSX1BUUigt
RUlOVkFMKTsNCj4+Pj4gIA0KPj4+PiAtCWlmIChtbnRfaGFzX3BhcmVudChvbGRfbW50KSkgew0K
Pj4+PiArCWlmICghaXNfbW91bnRlZCgmb2xkX21udC0+bW50KSkNCj4+Pj4gKwkJcmV0dXJuIEVS
Ul9QVFIoLUVJTlZBTCk7DQo+Pj4+ICsNCj4+Pj4gKwlpZiAobW50X2hhc19wYXJlbnQob2xkX21u
dCkgfHwgIWlzX2Fub25fbnMob2xkX21udC0+bW50X25zKSkgew0KPj4+PiAgCQlpZiAoIWNoZWNr
X21udChvbGRfbW50KSkNCj4+Pj4gIAkJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOw0KPj4+PiAg
CX0gZWxzZSB7DQo+Pj4+IC0JCWlmICghaXNfbW91bnRlZCgmb2xkX21udC0+bW50KSkNCj4+Pj4g
LQkJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOw0KPj4+PiAtDQo+Pj4+IC0JCS8qIE1ha2Ugc3Vy
ZSB0aGlzIGlzbid0IHNvbWV0aGluZyBwdXJlbHkga2VybmVsIGludGVybmFsLiAqLw0KPj4+PiAt
CQlpZiAoIWlzX2Fub25fbnMob2xkX21udC0+bW50X25zKSkNCj4+Pj4gLQkJCXJldHVybiBFUlJf
UFRSKC1FSU5WQUwpOw0KPj4+PiAtDQo+Pj4+ICAJCS8qIE1ha2Ugc3VyZSB3ZSBkb24ndCBjcmVh
dGUgbW91bnQgbmFtZXNwYWNlIGxvb3BzLiAqLw0KPj4+PiAgCQlpZiAoIWNoZWNrX2Zvcl9uc2Zz
X21vdW50cyhvbGRfbW50KSkNCj4+Pj4gIAkJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOw0KPj4+
DQo+Pj4gTm90IHRoZSByaWdodCB3YXkgdG8gZG8gdGhhdC4gIFdoYXQgd2Ugd2FudCBpcw0KPj4+
DQo+Pj4gCS8qIG91cnMgYXJlIGFsd2F5cyBmaW5lICovDQo+Pj4gCWlmICghY2hlY2tfbW50KG9s
ZF9tbnQpKSB7DQo+Pj4gCQkvKiB0aGV5J2QgYmV0dGVyIGJlIG1vdW50ZWQgX3NvbWV3aGVyZSAq
Lw0KPj4+IAkJaWYgKCFpc19tb3VudGVkKG9sZF9tbnQpKQ0KPj4+IAkJCXJldHVybiAtRUlOVkFM
Ow0KPj4+IAkJLyogbm8gb3RoZXIgcmVhbCBuYW1lc3BhY2VzOyBvbmx5IGFub24gKi8NCj4+PiAJ
CWlmICghaXNfYW5vbl9ucyhvbGRfbW50LT5tbnRfbnMpKQ0KPj4+IAkJCXJldHVybiAtRUlOVkFM
Ow0KPj4+IAkJLyogLi4uIGFuZCByb290IG9mIHRoYXQgYW5vbiAqLw0KPj4+IAkJaWYgKG1udF9o
YXNfcGFyZW50KG9sZF9tbnQpKQ0KPj4+IAkJCXJldHVybiAtRUlOVkFMOw0KPj4+IAkJLyogTWFr
ZSBzdXJlIHdlIGRvbid0IGNyZWF0ZSBtb3VudCBuYW1lc3BhY2UgbG9vcHMuICovDQo+Pj4gCQlp
ZiAoIWNoZWNrX2Zvcl9uc2ZzX21vdW50cyhvbGRfbW50KSkNCj4+PiAJCQlyZXR1cm4gRVJSX1BU
UigtRUlOVkFMKTsNCj4+PiAJfQ0KPj4NCj4+IEhlbGxvIEFsIFZpcm8sDQo+Pg0KPj4gVGhhbmsg
eW91IGZvciB5b3VyIGNvbW1lbnQuDQo+PiBUaGF0IGNvZGUgY2FuIHNvbHZlIG15IHByb2JsZW0s
IGFuZCBpdCBzZWVtcyB0byBiZSBiZXR0ZXIhDQo+IA0KPiBCVFcsIHNlZSBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvMjAyNTA1MDYxOTQ4NDkuR1QyMDIzMjE3QFplbklWLyBmb3INCj4gZGlz
Y3Vzc2lvbiBhYm91dCBhIHdlZWsgYWdvIHdoZW4gdGhhdCBnb3Qgbm90aWNlZDoNCj4gDQo+IHx8
IEluIGNhc2Ugb2YgY2xvbmVfcHJpdmF0ZV9tb3VudCgpLCB0aG91Z2gsIHRoZXJlJ3Mgbm90aGlu
ZyB3cm9uZw0KPiB8fCB3aXRoICJjbG9uZSBtZSBhIHN1YnRyZWUgb2YgYWJzb2x1dGUgcm9vdCIs
IHNvIGl0IGhhcyB0byBiZQ0KPiB8fCBkb25lIG90aGVyIHdheSByb3VuZCAtIGNoZWNrIGlmIGl0
J3Mgb3VycyBmaXJzdCwgdGhlbiBpbiAibm90DQo+IHx8IG91cnMiIGNhc2UgY2hlY2sgdGhhdCBp
dCdzIGEgcm9vdCBvZiBhbm9uIG5hbWVzcGFjZS4NCj4gfHwNCj4gfHwgRmFpbGluZyBidHJmcyBt
b3VudCBoYXMgZW5kZWQgdXAgd2l0aCB1cHBlciBsYXllciBwYXRobmFtZQ0KPiB8fCBwb2ludGlu
ZyB0byBpbml0cmFtZnMgZGlyZWN0b3J5IHdoZXJlIGJ0cmZzIHdvdWxkJ3ZlIGJlZW4NCj4gfHwg
bW91bnRlZCwgd2hpY2ggaGFkIHdhbGtlZCBpbnRvIHRoYXQgY29ybmVyIGNhc2UuICBJbiB5b3Vy
DQo+IHx8IGNhc2UgdGhlIHByb2JsZW0gaGFzIGFscmVhZHkgaGFwcGVuZWQgYnkgdGhhdCBwb2lu
dCwgYnV0IG9uDQo+IHx8IGEgc2V0dXAgYS1sYSBYIFRlcm1pbmFsIGl0IHdvdWxkIGNhdXNlIHRy
b3VibGUuLi4NCj4gDQo+IExvb2tzIGxpa2Ugc3VjaCBzZXR1cHMgYXJlIGxlc3MgdGhlb3JldGlj
YWwgdGhhbiBJIHRob3VnaHQuDQo+IA0KPj4gU28sIEkgd2lsbCByZXZpc2UgbXkgcGF0Y2ggYW5k
IHJlc2VuZCBpdC4NCj4gDQo+IFByb2JhYmx5IHdvcnRoIGdhdGhlcmluZyB0aGUgY29tbWVudHMg
aW4gb25lIHBsYWNlLiAgU29tZXRoaW5nIGxpa2UNCj4gCS8qDQo+IAkgKiBDaGVjayBpZiB0aGUg
c291cmNlIGlzIGFjY2VwdGFibGU7IGFueXRoaW5nIG1vdW50ZWQgaW4NCj4gCSAqIG91ciBuYW1l
c3BhY2UgaXMgZmluZSwgb3RoZXJ3aXNlIGl0IG11c3QgYmUgdGhlIHJvb3Qgb2YNCj4gCSAqIHNv
bWUgYW5vbiBuYW1lc3BhY2UgYW5kIHdlIG5lZWQgdG8gbWFrZSBzdXJlIG5vIG5hbWVzcGFjZQ0K
PiAJICogbG9vcHMgZ2V0IGNyZWF0ZWQuDQo+IAkgKi8NCj4gCWlmICghY2hlY2tfbW50KG9sZF9t
bnQpKSB7DQo+IAkJaWYgKCFpc19tb3VudGVkKCZvbGRfbW50LT5tbnQpIHx8DQo+IAkJICAgICFp
c19hbm9uX25zKG9sZF9tbnQtPm1udF9ucykgfHwNCj4gCQkgICAgbW50X2hhc19wYXJlbnQob2xk
X21udCkpDQo+IAkJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOw0KPiAJCWlmICghY2hlY2tfZm9y
X25zZnNfbW91bnRzKG9sZF9tbnQpKQ0KPiAJCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsNCj4g
CX0NCj4gbWlnaHQgYmUgZWFzaWVyIHRvIGZvbGxvdy4NCg0KSSB0aGluayBpdCdzIGdvb2QgaWRl
YS4NCkkgd2lsbCBzZW5kIGEgcGF0Y2ggd2l0aCB0aGF0IGNvbW1lbnQuDQoNClRoYW5rcw==

