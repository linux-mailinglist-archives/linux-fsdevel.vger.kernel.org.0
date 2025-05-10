Return-Path: <linux-fsdevel+bounces-48667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3F9AB214B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 May 2025 07:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 423F17B6C99
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 May 2025 05:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF06E1C84C7;
	Sat, 10 May 2025 05:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="X+aQXmb6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012023.outbound.protection.outlook.com [52.101.126.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D556125;
	Sat, 10 May 2025 05:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746855123; cv=fail; b=mlMjDgCJYkHlyYhoUMYUuotT+LIxxb/66+dReqypM8ST7WwjOJcxFA1ezEVSCsdS/5nJCxs4KgXByhx+Zl1jGUDkcOmsaVlTAX5lLtDKuerdWHX/hpFqj2LGLHIqhub/euqyVse/2oo/GRUl5v1aStkK41YH0GIXv5ECRjrE7GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746855123; c=relaxed/simple;
	bh=hxqOr44LNZ9BYys8nzGKVbqkOZySuXibD2DJPX7jg34=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WerRoYuyTfKBFTm/QpkeJ622fMJGfqgmHDuFlGptx8iNwCFVrDFeJw9Sjpv3O+EH7/cAlpiT5afwbYb9PbT8wzD1l/9JoJvwnX6dYGtRqhvfpxeFWYOPqZj/63qan4Yo6QsJ6X8ADUhLCqD9kixM4n034k+av0RUbN6nsJCtPsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=X+aQXmb6; arc=fail smtp.client-ip=52.101.126.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BC7t5JwHhUIRf1VmE99x+Uf5qgn18Zax8cs6oVHaGzWjtQn/0v8F81+Q+mCXnx11bGmKmXlyJDX6PtHmhx6XCYLF+BsdlaVoxXmLpQQ/7F7QgkfLzETmGc+EN1LUo/MiD3ZU0GqIuXU54/NVew2bW7DaEOpPRPm68wUJIyjcXAbpi8tjPqbpYgQOuvw6S7S3WM+mPJ7s2ZCvJHJSoT0VSlt/Xyi/+i5QJj2bicLdhlzbQ5GoQ2PakdEuAyAPvvk+qeXRN1qxbnWtISF7Z2HCaHU/5skU0jYF4joDf9jaVprPYCz8AI9UH47BJF/mZ5nydfoNOdjFLpXJyVT/NpIySw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxqOr44LNZ9BYys8nzGKVbqkOZySuXibD2DJPX7jg34=;
 b=OeDTw51Rb+1KEkmQCQDwh490D5V0/FYzb+adlzNSY1cJQ2YdGxREAdr09mYneHrRBghfV0EtZO3oE4918TS/pOrMr6hB1VCOh2TsMKIee/4Xa3duZrdhkch4SUlubuqxh3EJu49FIHTpo970dfNYDQ1i9c0W2wLsimBGvhoeW/kmBF5YsUyDwIVoi62/vsFI26h5uldZWLcAHumhOH3mZqLbmVQCWangwvIgsF18rRHilKiCxeG8tmfxegbnCQDbTzt3FsWFZ5ZC4w62yqVjobFlMMbSrTLRklRo3S5abbHEMbKrotlPfz48nI4NGY0GofyZigKMr6M3sfzF2Ht2IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxqOr44LNZ9BYys8nzGKVbqkOZySuXibD2DJPX7jg34=;
 b=X+aQXmb6xc99rlo6nJ8zQrFeKRjIdiLklWJjxjjUuG7ZJlSZysAo+nlJdCntCcSq4Q1lzh77iNJBs3m/UDgGO4en8ZMVHbi+X3EdCMzgd8Yg6nt9vvmO7MzUrTv8rnJ4l00DpvVPxX672DigA5AvfN+0mwYVA51FS5A9RukjgcYEZF3kmqlMmXGvEEgsNxh2bU3JQEMB0Rqej0aQdJ/h0GJhPeprwMSva52QfVFdTEsR0HK5q6ZVZzD/wiGOadeW8ydNbg/yKJp7PUptTqFHYKKBV9Xjn3b92UbSW+b4ih/DATAl7aUVXgRU6+9MTCqBaTWQZXy2ONz8oBwdRoFQWQ==
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI6PR06MB7168.apcprd06.prod.outlook.com (2603:1096:4:250::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Sat, 10 May
 2025 05:31:55 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%5]) with mapi id 15.20.8722.021; Sat, 10 May 2025
 05:31:53 +0000
From: =?utf-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>, Viacheslav Dubeyko
	<Slava.Dubeyko@ibm.com>, "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue5aSNOiDlm57lpI06ICBbUEFUQ0ggMi8yXSBoZnM6IGZpeCB0byB1cGRh?=
 =?utf-8?Q?te_ctime_after_rename?=
Thread-Topic:
 =?utf-8?B?5Zue5aSNOiAgW1BBVENIIDIvMl0gaGZzOiBmaXggdG8gdXBkYXRlIGN0aW1l?=
 =?utf-8?Q?_after_rename?=
Thread-Index: AQHbuUClFvj8998Yt02X7oeCaQIiKbO+eNaAgAjKn9CAA2AWgIAAwCBw
Date: Sat, 10 May 2025 05:31:52 +0000
Message-ID:
 <SEZPR06MB5269F2CCD9AD085D2712842FE895A@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20250429201517.101323-1-frank.li@vivo.com>
		 <20250429201517.101323-2-frank.li@vivo.com>
	 <24ef85453961b830e6ab49ea3f8f81ff7c472875.camel@ibm.com>
	 <SEZPR06MB5269E572825AE202D1E146A6E888A@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <c19db3b68063cd361c475aaebdd95a232aef710c.camel@dubeyko.com>
In-Reply-To: <c19db3b68063cd361c475aaebdd95a232aef710c.camel@dubeyko.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB5269:EE_|SI6PR06MB7168:EE_
x-ms-office365-filtering-correlation-id: 8388aaaf-94e1-40d9-3f78-08dd8f83f885
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Vk9IT1ljc0YrTVdRRmxvNXl6NlU0QWhiM3E3VEltK0FkQ2Z3UkN4NytRazVC?=
 =?utf-8?B?ZlpEM2h5dEJjNnpJQ3RjakJNamI0Y3FDMFJzUzYrR29EcVR1UDgwREt5WXpI?=
 =?utf-8?B?WmVDV0FhdlJ2cDd3NmFkemJMdXBMR2p1d0U3Y1haSkgva0xBekJManZySzFN?=
 =?utf-8?B?M1dQUStncFo5Zzd3OFpBZVhjZ3g4ZE9GTTJYRXhrMkF4UGwzcDNPaXNwVEZQ?=
 =?utf-8?B?RlhGTW5oNDFscEZNNGtuTnUwQmxUM3Z0SVBBZXRBcW1uSXdLVnRLYTRvUGRa?=
 =?utf-8?B?N0pCL29ick4ydEdBcmVjQStFOVBsbjVqQytZRFJzZ1RYTW9mdW4xRGIxZTlx?=
 =?utf-8?B?VkQyTEZPdHBrRit6b21JRC9rbkUwUDBWS3V0cUZzVnpOb05rZzQ1UTJUNytD?=
 =?utf-8?B?MDZsLzlkV04zWUE0bm5PVFRiWHp6RE9pM0E5R0JBOUp4VTZJenc0eVZHL2Nn?=
 =?utf-8?B?R0ViejJVbnpoM09XWk9mSm5JblR4aWh2Q2VCMUc1WjMvUnJaamJpVXFBVFlp?=
 =?utf-8?B?R3ZiTlJBTjhUZlF4OEl0Vzd2ek5nVzlYVkxxR1BSZjY3L1N5YitFN2p5SCtL?=
 =?utf-8?B?M3JVTXV0ZXFxMWZad2I1QklKZUVaR0U5V1lZOGFDdlJhUm9xTnZVMXdGYlIr?=
 =?utf-8?B?YkRPZ3hQbVZIdit5eG9qanU3djZFU24zR1YrTE85SDM3a29vakpTblhQZGs2?=
 =?utf-8?B?UmpuajZZWGFxQ0YwTExFaDZld3dHWkpGMktXSTlUUFFPc2Vlc0l4ZTdJclRq?=
 =?utf-8?B?cVNKenZtK1h4YUhyZmhmSHlCSTV2eWFZdHNyZTRteTRnK2pnUjlkL1VoZ1lw?=
 =?utf-8?B?a2dabUZ2cGlrL1B3ZFpCd0Z0Zkh1U1Jnb2YxZUo4NGJ2WUdOc1FGS3UzM0kw?=
 =?utf-8?B?RzZxY3R1NVBEKzgvZUxIbnFWbHBwSnphRFpSR3gwOFZvWml3d2FaSjVzTkVM?=
 =?utf-8?B?WmNydGVSY0ZuMnlVRnlkaXh6YnUwZ1ZyODlLeGZHVW9qU0dCKzVqR0Q3RjYv?=
 =?utf-8?B?cWZKY1RleUtPT1JTbHpJaXNJanZzcHZMOVluZFdiem1tREJlUVl4ZjJwWTFz?=
 =?utf-8?B?WmZ3dlQ5VW51Nm1waVZNZ21zS2VjNXRINE5JY0M3SUhiVGVYYWpmejBERS8w?=
 =?utf-8?B?STUzVStWa3NTaTdiempqcEcrLzIvZGVhZlhQZFVINUlScGpaTHlOUkVEWS9u?=
 =?utf-8?B?M3ljTHduRm4xaldsVkVpZWlFSVRZZTF5WlM1R0NSMUVXdzJlRUhaY2UzOVk0?=
 =?utf-8?B?dmNBSTN1R3h6a0RXcDltNWprZEdFZ3N1Vm90RUxya3hvbjdIVlBlK0p5RUxG?=
 =?utf-8?B?TzhQSXU2Tm1MUThXK1huV2JWakN2NTdlN2pybklJQ2p1Uy96ZUlxNFBnUzAz?=
 =?utf-8?B?M1RLSEZEUzJ2dTlHMUdPZlJyclBGR2ppczBOTFUvSkxNa1ZhT3BaOWVnbmpV?=
 =?utf-8?B?Mlp0Uzlva0tCaTIxS3EzS2h2R0FzRTJzS01ZcjI4UHRIZmF5VmU2RmJISnhq?=
 =?utf-8?B?ZXBGQ25VRE5PWisveGFQR0pqNmhqUVFSTkN3VTg4dkY5VjU0Zy90aUtMcFA2?=
 =?utf-8?B?eGlEUytIWk13NjZQREwyNDBpMDAwT0x3NHVEVEplcWtySWZ1aVgxNG4yTkxO?=
 =?utf-8?B?N1l2YXIvNzFBTFpkdFhJUlp3QTFsUE9VWldvRk5CM0dHRjVVMW52RGRhQlQ3?=
 =?utf-8?B?Y29rTlhrUDdGLzB2aTJ2OWlFenBXK3N5R2puNGhtbVR2cG1XdzB3QUd0ZzJ6?=
 =?utf-8?B?bnZDT2p2aW1ENXh0ZFVvNlFtOTExaUE2OXAvVjFiVG1HQXFIeHYveFFIK2U1?=
 =?utf-8?B?OVdZZ1N6QStnUmlWOERUUmVyRWo5YU45a2hqYmlvV3poeDlTREZnZUtjdWZ0?=
 =?utf-8?B?MkE3ckxUUTYzQmxZbGFoZytwaDZYRVRzWkNkem9va1VBbmNYWnZNTUNPN01I?=
 =?utf-8?B?Uk0wMWR2RkxKVUV6VmhVZkdNTDVuWlhUc2pHa3dEelhWdVBnRzRiRDhXcFNo?=
 =?utf-8?Q?OxTdLT2fMs4CJ6Se4z3kkWCE+B8z18=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWlDbmU2VGh5QlU1TnY3MDFSelBOV1JrR1ptSWtTb25OM0M1anN3UjVlVXlB?=
 =?utf-8?B?Y1hMZGxtemhXd1RmZ053SFJFakJHZ1NSL0owZUo5bU14WjVXZDJURVdLWlF3?=
 =?utf-8?B?RFhJRjF0NTkwKzg1Ni9YY2lON25GN1g0RktjczBOWTRhcUNxaTUwcG9oUmp2?=
 =?utf-8?B?V2tGOE5DaGFIbHVVZFJ3Nm1JVFFtL2x4R3E4RmZSZkZSemNSQy8yQ3ZNcjhJ?=
 =?utf-8?B?L0hud25VUHozUjNNTFNMNzlKTUdYTDhTVG5KRUZmV0JZWWdRd2NmbkxtYU1m?=
 =?utf-8?B?NkdsS0QzTm92K1ppNmhzOHZraExib0JOMm9UQzUwSVJxbS93Y1c5azJWUS9F?=
 =?utf-8?B?YkFnR2wxVUpXY21NWWJ6RXFKemkwK01tWS81L2w3M2JhemEyVmoya1RtdFpm?=
 =?utf-8?B?RWVHaVh5Mld6V0pmWGdRUFNkbVppYjNDL3FyUzJodWtxTXVQZUl2Y2c2b0Jv?=
 =?utf-8?B?MENSN3VPQzRacE1LeW82NFdmUkdXUmJzOCsyMi9BYy8vL1dybXNzcjMvV1Ax?=
 =?utf-8?B?YVVFeFFiaWpzYWRLdFZ1aG5BUEM2M0lTemtUcnJyaXg0SUV0bjBLVE5teVpl?=
 =?utf-8?B?bGFOSk5XalJrR3JxN0daUW0rdHNHTnZLdkZxdllhdktTOFc0THN0enZMTnN1?=
 =?utf-8?B?ZHdZbmo3dzBnSVROaHdWSERWeTV4T3FYcnpNM2xTNXZFTUg1dlFNSlNlVjFT?=
 =?utf-8?B?cG10NGVKYWxqWEh5eUFKUGwyQkR4MFpOSVFFSTdIYkRHeG0rTGFvR052TVpF?=
 =?utf-8?B?ZVN1UXpmWGhESmxuOTBxSlRqNGhqWlIvTloyY2lOZ1IyS0FtL1hRNmVtT2ty?=
 =?utf-8?B?ZFR1TlBkOU8yUUhjS1o3RjBsSE80ZnpIb0RMWXp2bWNtaVpmS3FnY093VlZD?=
 =?utf-8?B?RnMxMHRid1A1Z094dnB0UWR6TklONTVNcDdpTHZHODN2b3RqY2JadlY0ZXQv?=
 =?utf-8?B?eU4xMElWemRRSVFHWCtLNi9XVHFqajA4RENpWUpDaXRBRmx6aGdvcWNGSEtl?=
 =?utf-8?B?MHVaMEdKaTB0UGFZa1BJMnBjMDBHcldJY1RsUnRGUlZvSVRrT0NWc2p2cjNa?=
 =?utf-8?B?UUtUam42MDFZWWZhVWFvS0U4cHYvYnl5ek9aMzJoK2dxMVEwVnVTaHRzY0ps?=
 =?utf-8?B?NTV6Q1A1VFR1a3RHd3d6ZlI3ek02Y1ZEcmg4dzhRQmkwUFFHa09Wd0U3aHVI?=
 =?utf-8?B?alQ2Z2VNckF3MVp5RTY5OFplTm5yMnhZVHNQeWszckR1eEhKZ1VyMUtUNVRJ?=
 =?utf-8?B?YldHM1Axbm14Z1NRcnFsQlJTZnhmaGkzMDNTbm1EZXhLNG9IZnRod3R6bjVK?=
 =?utf-8?B?b09QenhNaWZhSlNnd0tVaVcyL3phT1Y5OFRWeUNrbUNMMXdNcDlMRmcvVUMy?=
 =?utf-8?B?UjR1TDhlWENUVHF6UlNLaW1xVVFLZm5ybFlDamdMM2ZKVzZIa1ZxdTBJRTla?=
 =?utf-8?B?UFpxRjZIY0lxV2J0QVhIR1lzSVJlVmNTdXFPRmM4Z3Q2VzVBM3d1SXRiK0Jq?=
 =?utf-8?B?cUJSOG81Q3FWMlQ4UDA0N3FjSk5LWlRMODFCbzdXWTNoa3dEc0NVZnpLNkl5?=
 =?utf-8?B?bjZzQzJ0UGhnaTFjVHVXYnZFZEdFT21nOEhzR1VSalRZWXlDQ01wY0VRZHhT?=
 =?utf-8?B?WTZ5eDM0RGNkZ0FKNzc2eUVoT1U2THlyemVKRzJJYkhaUGIxeG5KcDhJZlc4?=
 =?utf-8?B?RGdTSTJ0L1NHc3BoZmpBY1JENytyS3VtSTIwaGJFak43K25QalhpM2grUGxP?=
 =?utf-8?B?NlQ1WU93Qzk3NStUcTJvUHkrWWVsc0xucTcxREcrZHliUHQxb0xxNitYYzYx?=
 =?utf-8?B?ZDB5ZlNGUDJENDB3WDVnNTFGbkl3TDFsbGdUV2svZ2lIWVhLR1hnRjk1U2dw?=
 =?utf-8?B?RjFlUU5haVB4eGZtRmpVdExPdHZxczZSWG1URDZueS9DV1UzNzgxWmx6OGJn?=
 =?utf-8?B?bXZVcDRnVlh1d1ZDL2FQRE14SVRGUGVCTnA2SmFodmlLYUVyajlpcVFia1J2?=
 =?utf-8?B?cmhvMUJ6Rm9YZkdJZ3ZaT1BtWnBDeWgwRnVXQWx0MWZMeThUWTdaMFo0czNK?=
 =?utf-8?B?S1BFNzZRZWN6QWhEYW9wTWRBYnFZSm9MWFlYMmZadmNtWUJ4OS91M0hxVEZX?=
 =?utf-8?Q?NlTI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8388aaaf-94e1-40d9-3f78-08dd8f83f885
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2025 05:31:52.8835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s+l0euGtmZ2fpHh33R93WGoGMvYfoAwdpk1IB8YntrQ+6CujrQQuMABHsyflVr3BgmMoG9Vbao2E4Zf7YIoHqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7168

SGkgU2xhdmEsDQoNCj4gSWYgSSB1bmRlcnN0b29kIGNvcnJlY3RseSAiRVJST1I6IGFjY2VzcyB0
aW1lIGhhcyBjaGFuZ2VkIGZvciBmaWxlMSBhZnRlciByZW1vdW50IiBtZWFucyBhdGltZSBoYXMg
YmVlbiBjaGFuZ2VkLg0KDQpJbiBmYWN0LCBpdCBzZWVtcyB0aGF0IGl0IGlzIG5vdCB0aGUgYXRp
bWUgdGhhdCBoYXMgYmVlbiBjaGFuZ2VkLCBidXQgdGhlIGRpc2sgYXRpbWUgdGhhdCBoYXMgYmVl
biBub3QgY2hhbmdlZC4gDQpUaGUgaW5vZGUgaW4gbWVtb3J5IGhhcyBhIG5ld2VyIGF0aW1lLCBi
dXQgdGhlIGF0aW1lIGlzIG5vdCB1cGRhdGVkIHRvIHRoZSBkaXNrIHdoZW4gd3JpdGVfaW5vZGUg
aXMgZXhlY3V0ZWQoaGZzIGhhcyBubyBhdGltZSBpbiBkaXNrIGZvcm1hdCkuDQoNCkZvciBFUlJP
UjogYWNjZXNzIHRpbWUgaGFzIGNoYW5nZWQgZm9yIGZpbGUxIGFmdGVyIHJlbW91bnQNCg0KQmVm
b3JlOg0KCUFjY2VzczogIDIwMjUtMDUtMDkgMTQ6MDU6NDANCglNb2RpZnk6ICAyMDI1LTA1LTA5
IDE0OjA1OjM4DQoJQ2hhbmdlOiAgMjAyNS0wNS0wOSAxNDowNTozOA0KDQpBZnRlciB1bW91bnQm
bW91bnQ6DQoJQWNjZXNzOiAgMjAyNS0wNS0wOSAxNDowNTozOAkJPC0tIGJhY2sgdG8gbXRpbWUN
CglNb2RpZnk6ICAyMDI1LTA1LTA5IDE0OjA1OjM4DQoJQ2hhbmdlOiAgMjAyNS0wNS0wOSAxNDow
NTozOA0KDQpTbyB3ZSBnZXQgaW5jb25zaXN0ZW50IHJlc3VsdHMgZm9yIGF0aW1lLg0KDQpBbSBJ
IG1pc3Npbmcgc29tZXRoaW5nPw0KDQpUaHgsDQpZYW5ndGFvDQo=

