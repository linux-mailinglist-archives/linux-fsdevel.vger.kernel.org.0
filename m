Return-Path: <linux-fsdevel+bounces-63466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9170FBBDB42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 12:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DC864EA357
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 10:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5F123E34C;
	Mon,  6 Oct 2025 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="Cog7E4Hj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F662417F2
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 10:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759746926; cv=fail; b=Kokrpdo4+C+BQX+j2nqvWlECDD9HgT3vVj9tJ2fOR4cllU6Xvjand0MY3/5WetA+Qlii5dajdOoqnrqyHm9gcMARDoOYuqGHVr8EmayI1vhx8gCxELpyvNEGITrN8r768hmCJajWfVVCyNxL9W2crPBdZLaTn658qFE4K+9lhWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759746926; c=relaxed/simple;
	bh=8K0NvhRMZvqX/5dEU9mbpAGUFFp80XCsl/5maiweMZQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X6VW8eMQ7+YrJGJjx8yeGroXaEwUzywDjYBnMcxGxzbGhDOP/Ea5OKK7wFMkM5l1ddXSNmexvpbiyAR/0mSlD9jKaG2tEvfNn7fDDBW5r/ki3DKt/pQTLYsyPXWfF36FE/lpnjmkKnM2iypprNSC7PrwY2eX9IUS9A5/VvxuJHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=Cog7E4Hj; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020124.outbound.protection.outlook.com [52.101.85.124]) by mx-outbound-ea18-75.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 06 Oct 2025 10:35:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hipKu3Xddgn7zVlZ1BComtmw5WAh9NheEPAkh/8NB/VwgHT6b1RpeorkMzeHoNXJG9y/W5l1lRnFbv9x8qpuucwI/RWxD6t446Nd2T87u9dIpBmlYjMOVqY9+bHtsuCb6AVVi7lIuYQo+WN7op5baEVZbDhV8o+X1mEZrm8slz6//7y7D7NSnjKl/U4JlQRyvpXz8RpCRQ8D119cZ5SbrmxBADCK9LZZW+hsQI3HHaoshkWwTzBjKBCOcMbTEs1tIvW5bq7YQPMDS/Ra/Olh7EIFkDiO2y93wuxHEup8BhdFmJnV/xCXFMmMel53Fl+W6ToIhYbL//q6XObhT/vaSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8K0NvhRMZvqX/5dEU9mbpAGUFFp80XCsl/5maiweMZQ=;
 b=ec7LH1nneb7ObzkbtFhWCaUt/pf1Exxix0mSGgQD6tSwZ8EjbDqWtd10N0gVYP9eNXyGrjmSdNqB2bpnR24wQlyqvd5veCwffewwlaKMj6BR61nfZah7oyavpJIVp5Co8IJlhC/AqueJWumnr38EzbfEDIV/g2dmgzhDbhHyHI0q8yX8I6f/oEZ6mPyTLzjSfYFwKLh/kE0ggPFHSdv207z07rpJhKVVLvP7W20tPXgfRrCmbtyCbwCeI8xuY1J1QvKKJLI5wdFv2EKGxc/5w+p/2PK8TWJp4ilbAPvuHmDGWP1SkEfPoNODOXe200HmuoGH0kcCv8LzW7vCVGIW7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8K0NvhRMZvqX/5dEU9mbpAGUFFp80XCsl/5maiweMZQ=;
 b=Cog7E4HjfDP81TWXZ+S3V8EwGzEapFGJ/39DIjqcsNCCdi0a7lw41AK6EyOpxEm2X/znrnGpI34F3zM1ppJZOZHocq4P9CEZ75RZ3j7ZHTcCgoKbO2tvxbjvgSUCOt/zv0ULYv1kstWP43BOGKuRygyXKGOT54GC3+zt5bnpMzo=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by MW5PR19MB5652.namprd19.prod.outlook.com (2603:10b6:303:1a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Mon, 6 Oct
 2025 10:35:03 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%5]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 10:35:03 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>
CC: Joanne Koong <joannelkoong@gmail.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 5/7] fuse: {io-uring} Allow reduced number of ring
 queues
Thread-Topic: [PATCH v2 5/7] fuse: {io-uring} Allow reduced number of ring
 queues
Thread-Index: AQHcNE1wRA97RzdUQkOq+jX6jT7k9LS08SMA
Date: Mon, 6 Oct 2025 10:35:02 +0000
Message-ID: <22b4f200-2def-46c3-b848-5b2d5aa62338@ddn.com>
References: <20251003-reduced-nr-ring-queues_3-v2-0-742ff1a8fc58@ddn.com>
 <20251003-reduced-nr-ring-queues_3-v2-5-742ff1a8fc58@ddn.com>
In-Reply-To: <20251003-reduced-nr-ring-queues_3-v2-5-742ff1a8fc58@ddn.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|MW5PR19MB5652:EE_
x-ms-office365-filtering-correlation-id: e45b334d-a635-4cd4-9f98-08de04c40231
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|19092799006|7416014|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cnFoV09KaWM2UWRsNERYblUxQ2w1YWlHTzNVTXdIUnJjdzZJbDlpZnBSc29X?=
 =?utf-8?B?Z0M0aGQwd0RoWEFvWDBiSzJrZW1Tb3dFSzFLQ3N4dXlsYkpWd3FwbkN3WXJQ?=
 =?utf-8?B?dWVWNkF4bHM0ZjBjWnJHLytmTVQyMDdJWjE4OGRBQVBocTJZc2l0cEVHdVpM?=
 =?utf-8?B?c01BVmhhcHhFckVTeGYwTFBZTmZGT1QzMEhEU2drVmlEMnRDVzVxSms2c3dr?=
 =?utf-8?B?ZmV3MFdIckhNa1VKOFRFMXNhbk5zZ2NZdGxyMVp5MG1aMEM0dnBGNUU3dG1l?=
 =?utf-8?B?YnBhTzJKSHI5YytuRllIQWk4ekIrS0MwV1dOSGNsVkxCQzRveTdOMVkraVZ4?=
 =?utf-8?B?ZFFoeTViZklQT3QyYWtvWUpMTDFHamNtSUxXb1JJZzN0QS9vVDFBOTM2YlVU?=
 =?utf-8?B?K0hxUFp5ZUplYVlNMHNFclBrZUkrUEYydXF5djVvVXl6RnR0cTF6K2tsRm9u?=
 =?utf-8?B?OTE2U0pCZmliemFkV3BWb1dyWFBVUGVkMjdMRG1HMkFsWlh2NEh1REFxMUkx?=
 =?utf-8?B?eUlxS0psVEhPT1Z4c21lM2J5NTRyT004NXVLOURZLzY1bGFOUlh0SDZlQ2RW?=
 =?utf-8?B?VUtza3dscHRYQmE4K0kxYmVSaTBJZGh6MktXc3FGVmRMVmVqZ2FMcGZpUi9V?=
 =?utf-8?B?UHp0cHY2NU9oY09kbVhSNmZIbjNlQThLZ0RBeHFZb2pEQWdQL3NXR3RMMERa?=
 =?utf-8?B?aDB5enh0Y3h4anZTZ04yS0YzcS9rejhaTVI1TldDR1E3aE5ldjhXL3ZQTDZS?=
 =?utf-8?B?STMxc1liTUQ0UFBrQlcycy8xVGtLVmNkcVF0MkNtK3F6dFVYYnhwY3VLdmVs?=
 =?utf-8?B?SUZ1QXBJckV6V09HalBHRHZLckxqZGp3cms5Y0NEY3dIQUNtdmR4Zi8xVkxF?=
 =?utf-8?B?VjRpdmNqQWNBbWFmNjd0cTB2SklHZ2Yra3h1RHo3WElVd01DSW5CajJ4UTRT?=
 =?utf-8?B?cUZmZWdSeDZvUklJSkMvenpnaWlyT1lOOE92b0w5TDZzQ2oxVlZUaThwUUIx?=
 =?utf-8?B?NURBYkJtcWRGUXVEN3FjOWNISm1Cc2JsY0hOVkFNZ0VIblIrelZjZW1xOThJ?=
 =?utf-8?B?aWkzS2xkSmtoQVQwMDFLU2RBZ00vTDZGZytFZG9PN1RhY0VGaFUvQWdlY3hZ?=
 =?utf-8?B?NXZuVGhaN01lczFwUmZrOEZQL0xyTzI5c095ZG43VFVaZEJraFdjSTBXM0Zu?=
 =?utf-8?B?b0pKRkQyTzljeU5BbHVsclpYNk15UmFWTTE1M2tORjh4eHFaREhpYUJJbWRG?=
 =?utf-8?B?L2toTVV0NjBTS2hhVVFKc3J2QjhJQVI4ZVF2OTVTVzNLTFlwN0w2MXY4NjB2?=
 =?utf-8?B?ZU5EaC9zZXh5bUNCdTZ5b0Z2NTQ2K2xNUTJTYXhNT2RUTWpXNWhiS3k3SmFU?=
 =?utf-8?B?YU9ieVZ6QUI5YUlTb1pyZnAzbmJJRmdIUUthM0FmcHBPZ05tQ3loY2hUUVRr?=
 =?utf-8?B?WVJBQlFzZ09MQ3RjZ3ljV2FlVFZmWmEwQkdXeENVSXdIS1hnanMvVHFHZTlX?=
 =?utf-8?B?R2VJMDJmVzJDRkk5c2FJZ2g4NXc0dEtoQ01QcUlyWXJjZWRLd0xCc1daSzE2?=
 =?utf-8?B?eitDZzdGSlpaQTFMY2NyWGtsSDQ4WVVVTXZoMFhLRVZlSitlcFI2cHFvcEpB?=
 =?utf-8?B?bkZtODRHd0hZM3lEWXZZU2VrSDU0cWJIL3g2TjhLTFpsQ2pvanc5Y1orREZS?=
 =?utf-8?B?NjhHNWxQNDJTZWRjc0dOTnFIeHRKMjNUSndnNXZsMnhCbjFYQ0V2d2VlVXFE?=
 =?utf-8?B?V0hacTZyR0tsNUNHVEFvRzRPdnR4Ly9NTFhkTGw5ZFYrMnIxSS94cERpWG5t?=
 =?utf-8?B?Znd6VzZDb2kzSE5zZ3Nnck9oYVJiaDRJMFl0NHZhVUlPT3ppTlIzS1FxalBI?=
 =?utf-8?B?YW1UUjViL3FHa29IS09DRmMxZU8yUU9lV3plWnpnbzZ5K0ppVHpsSnFGMkE2?=
 =?utf-8?B?aUZaK2hKUG5rUUw0Q1VPYk5JU2VBYUN0ZHMwbFdIczBUbDZscnJLSnZEVXNY?=
 =?utf-8?B?dGZhRjdpL1Z2ajB3OUdZQytVeUhVNEE4UG93QWgyWGE2STROM3VxTFVBaEVT?=
 =?utf-8?B?N1loMjNDL1VLcDZYSWwrUlpXenAxRmp0RmViQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(19092799006)(7416014)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QWhZcWxkWE1Gc3ZnOGdsL2ZUT2ZUNUVOakh5UWw1Qm5pUklZQVljaFcwaUJv?=
 =?utf-8?B?blB5Yi8wNXJPa3dYL1MyWTgrRUhEaWkyc1VNckY5RGFJWHJmZ2ZaamUzK3JC?=
 =?utf-8?B?bHJhNTFHaEs4MDZ1QkxzamY3SUd6TTlsYlgwdm41eWVxamNqRXBwUUhVWEt1?=
 =?utf-8?B?MnNXVlh4ZGdPRnV6ZHc5L2R0MWFVOWJHcE1GYkNham9wMkhVUUp1ME1HYTFO?=
 =?utf-8?B?SExpOXFNRUFsSytSdEZ3OUNtV0JSZVMzRlYrd2lndU5lWE84VVhUT0svd0tt?=
 =?utf-8?B?b1pNckFrVjlxeDlSbkxKOVNtT1paVzA2SDRGSHNjWm1FVTFkSG1FNjhRaitC?=
 =?utf-8?B?N0tpUnJHTnpwbERKUVFJUjI3YjJ3NDhVMnV2dmxxaXU5NEdvSWdEZDg0QW9S?=
 =?utf-8?B?cmZaMW4zMjZHTHVzUGFuY2ZoRVhHWTNGSmN5bjVrQ2w2U1RCaFZ3RFo0S1Qx?=
 =?utf-8?B?ekJlS0wzcExDQ2ozb01qZXhCT2Z0NGNTSE1OcTE3cEdrRGxxa05CUGU0TjRt?=
 =?utf-8?B?QlJQM08xM0pjc0hIdkFhdkZuell0Q1dmTXE5ZFhHZ0tsRThhRk9yZjVEL3hS?=
 =?utf-8?B?bnpxTk1XWUE2c0ZyOVcrcmxIZUUvNDBmSnQwbUpURVRheFNUTUNDNHhlNFdM?=
 =?utf-8?B?ay81MHRyNjUrcTVKMGc1cjl2aldZUW44aUdKQ2VYYzNUR0l4ZmNzWk5xZ281?=
 =?utf-8?B?STNMS3phVnF3NmZINHlEck93K1B6Q1QxTnRGdGU5eDRndUhpODAzVmduTUZx?=
 =?utf-8?B?NStNc3Y3TnNaZHdWT1ZFdXVuY2xxSmxrdWp3Qmk2SGdadzJKcU91TTlGVW1a?=
 =?utf-8?B?cThSSi81L2hydXNia2t0V0pqbExPbmJNUXJ2M3J2czl2NFc4d3ZvV05sdjdW?=
 =?utf-8?B?Zkwxc2VVdWNQVTlmcXBpM3ovVldwcGo0OVF4SVVId29EVEMzN3FIdFFNZFEz?=
 =?utf-8?B?N21LTEZNUmJBUmp1WnZYZFlwSkdNekhySjFnL3hXd0lkcHBqWHF1TWxDUnIw?=
 =?utf-8?B?M2dZNlExQ1ZEbWU0WTBCL1ROWFB6K1MwNE1GUHZ1eUppUVZzR09zZ0ZDYXpG?=
 =?utf-8?B?ZmhKQkFhZGVlQmthZlIyd3ZQTC9lSC9HRDN4N3d0SCtzU0FtK0U2OUlYZFND?=
 =?utf-8?B?am13YmQzVjBEa0FmcHVrWisveFJBZE9GVlBiWnJPeTFEbFl3RVcrQTd4UnB0?=
 =?utf-8?B?WWd1KzZJYk5oZlh6RE1MUHRUNzBkWGlmRTFiT1ZVa3czWXM5K2J4U3BYVm1w?=
 =?utf-8?B?WWJUY2doOTZaNWpURi9BNFl0cnd1QllZU2Q5Slcyb0duSEpVV2VLZUdUcnV0?=
 =?utf-8?B?ZXpaR2RJZ1hIMkxDclg5YjBNbVpXRTlFR2dkSzlBVnRBWGdEYkdDRFpZdVdY?=
 =?utf-8?B?VnB3QmlmUldkeDM0Qk5aTDFZMlpUZ2pRaTIzUFB2N2YxNnJTbWdlSGM0NSs2?=
 =?utf-8?B?cDdPS2xTK2lFQWFqc1FzakVQbE1nNjdCZzY2b2VjdzdtUFpCL04xNU5hOGhP?=
 =?utf-8?B?U0FqUlVadUs3YlhGSzF4WkxCTjEzK0RXamRmSjZDL0xCclNJVHo2ZDRKb2dD?=
 =?utf-8?B?cjRoTXVoKy9OczhocHhoWC9UMHRuSVkrWHI5MU5pbnNJUWNDbDJXZVB3aUF6?=
 =?utf-8?B?U2NydjdNQmYzNkJES2diT1JOTlJmWXJwMWlyWDkxWnhoQVUrMGl2WEJ2VzJ3?=
 =?utf-8?B?aHo1VzZUeU1kUHhsajZSNTJsQzE0clZYRVcxQ3BNajRiYktiUlZ4SFppY1c4?=
 =?utf-8?B?dC9GRXF2QUFHbDVEWTMxTEowdWp1UzMrY2VDL2pJWENTZWdnT3dER2V4QzB2?=
 =?utf-8?B?UytDVkFaTDQ1amFydzBqdkFTZ2lRaGJMOGw2WFhnMFo5TXcrbCtGRW9TRkly?=
 =?utf-8?B?VHh0TU1jcU5EMEQrVlRqdzNxWWtUU09xUWpaL3Z5azkyR2xseFN0STM5bHgv?=
 =?utf-8?B?NUVuNUg0TjU2V2pBN3lsbU1paUVITGFZaFlGNXVKYzQrZ2N6L29qV05uOXcr?=
 =?utf-8?B?dlJKSG5xVDBHRmxodEhJSXBhNXVmY3M3dEZnbXgvK1JOalZYZGZQZmRzRnpz?=
 =?utf-8?B?VURadC9XVU5ERDhaOEE1dHlwN3l0OFJxK0ptTmtlaGhaNHp1ekVDVkF4UEFN?=
 =?utf-8?B?TEVFT01pZEZWZ05RWmcyMDlCVVZ3b3BKa2JVd2lKMlpOTGk4ZEJVcmdVY1FW?=
 =?utf-8?Q?W2TBDvFQ+ntjttRKGiabH5o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4553DE133C08814482A136E34D341623@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2UAtYMxMC2BJYDf1IiJPWf67w2WRabbuA8iAgrl9gDOMvtfnbJTr1B6qfTXSivmYFMOwdtRMyJLnIzr8gZvRZf6wPPl/phdFKuWRUTSCCavaN7V3SyQrsKHEGbkZ9yZb+JEE/poZe822vfXADHBmgvmYtma7lS45jgMK3/tsTknJEosgE7ylyTEVXq/AbDukJ4zzZnCOJOUbWylCf7ijnVnrTbco5uMcdXfBHRBaOJVGxc5PmPgr6+wg/GEj0NfVyjeDv3YZMwOMg74DObTG5Mms7aAy+Re4TSsWbVAElQzBoJZqgbmsTDZ+UzPqYZO3NY0ncowsxA01c9BJxTnQfPYKUMhYoV3jdvouGziRWUv9nt89F7xf9OosxDHTvx/dBVyCmiIWZ6HuydWPmzX0xb98A6v4/zo8KTHPu9tzB6BqMx6/NjfEptf4V4Eut2tUHDAh9aosm+pbTPVogMeQ9KvfsrR98bD+GngpDKNZXetjK5el1Ew75WvfmpsnXOQ03AEjdTmz6KTANqdtcAHBeWdP5zSG6rtnW2HZEsAHgtdxz+a85Tw3MI7GOYdXXplBrScQlaIj5jQnSqQ7WQL4ACGjD9iRqZrs+am6oDlpuFv8YCJ8Eq8O+pWiRnraBPoGq6o9CJNJ9OLJ1XZ1zdmJyQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e45b334d-a635-4cd4-9f98-08de04c40231
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2025 10:35:02.9666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M3p+nHg/lgtV6RxbkpDaNvKpSyrcWpzv4dlvwalLF55wGQCy1orw5hq7wklvab6AXQZyRVib+8ZgNtR692Qakg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR19MB5652
X-BESS-ID: 1759746908-104683-32573-37510-1
X-BESS-VER: 2019.3_20251001.1824
X-BESS-Apparent-Source-IP: 52.101.85.124
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYGJmZAVgZQMMU42STR0MDY2N
	QoOckkxSjFIinJ3DjN1DzRxDTRPNFSqTYWANEHQtNBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268007 [from 
	cloudscan14-13.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gMTAvMy8yNSAxMjowNiwgQmVybmQgU2NodWJlcnQgd3JvdGU6DQo+IFF1ZXVlcyBzZWxlY3Rp
b24gKGZ1c2VfdXJpbmdfZ2V0X3F1ZXVlKSBjYW4gaGFuZGxlIHJlZHVjZWQgbnVtYmVyDQo+IHF1
ZXVlcyAtIHVzaW5nIGlvLXVyaW5nIGlzIHBvc3NpYmxlIG5vdyBldmVuIHdpdGggYSBzaW5nbGUN
Cj4gcXVldWUgYW5kIGVudHJ5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQmVybmQgU2NodWJlcnQg
PGJzY2h1YmVydEBkZG4uY29tPg0KPiAtLS0NCj4gIGZzL2Z1c2UvZGV2X3VyaW5nLmMgfCAzNSAr
KystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKSwgMzIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvZnVz
ZS9kZXZfdXJpbmcuYyBiL2ZzL2Z1c2UvZGV2X3VyaW5nLmMNCj4gaW5kZXggYmI1ZDdhOTg1MzY5
NjNlYzJlNGMxMDk4MmQzMzYzM2RiMjU3M2Y0ZC4uZjU5NDZiYjFiYmVhOTMwNTIyOTIxZDQ5YzA0
ZTA0N2M3MGQyMWVlMiAxMDA2NDQNCj4gLS0tIGEvZnMvZnVzZS9kZXZfdXJpbmcuYw0KPiArKysg
Yi9mcy9mdXNlL2Rldl91cmluZy5jDQo+IEBAIC05OTgsMzEgKzk5OCw2IEBAIHN0YXRpYyBpbnQg
ZnVzZV91cmluZ19jb21taXRfZmV0Y2goc3RydWN0IGlvX3VyaW5nX2NtZCAqY21kLCBpbnQgaXNz
dWVfZmxhZ3MsDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyBib29sIGlzX3Jp
bmdfcmVhZHkoc3RydWN0IGZ1c2VfcmluZyAqcmluZywgaW50IGN1cnJlbnRfcWlkKQ0KPiAtew0K
PiAtCWludCBxaWQ7DQo+IC0Jc3RydWN0IGZ1c2VfcmluZ19xdWV1ZSAqcXVldWU7DQo+IC0JYm9v
bCByZWFkeSA9IHRydWU7DQo+IC0NCj4gLQlmb3IgKHFpZCA9IDA7IHFpZCA8IHJpbmctPm1heF9u
cl9xdWV1ZXMgJiYgcmVhZHk7IHFpZCsrKSB7DQo+IC0JCWlmIChjdXJyZW50X3FpZCA9PSBxaWQp
DQo+IC0JCQljb250aW51ZTsNCj4gLQ0KPiAtCQlxdWV1ZSA9IHJpbmctPnF1ZXVlc1txaWRdOw0K
PiAtCQlpZiAoIXF1ZXVlKSB7DQo+IC0JCQlyZWFkeSA9IGZhbHNlOw0KPiAtCQkJYnJlYWs7DQo+
IC0JCX0NCj4gLQ0KPiAtCQlzcGluX2xvY2soJnF1ZXVlLT5sb2NrKTsNCj4gLQkJaWYgKGxpc3Rf
ZW1wdHkoJnF1ZXVlLT5lbnRfYXZhaWxfcXVldWUpKQ0KPiAtCQkJcmVhZHkgPSBmYWxzZTsNCj4g
LQkJc3Bpbl91bmxvY2soJnF1ZXVlLT5sb2NrKTsNCj4gLQl9DQo+IC0NCj4gLQlyZXR1cm4gcmVh
ZHk7DQo+IC19DQo+IC0NCj4gIC8qDQo+ICAgKiBmdXNlX3VyaW5nX3JlcV9mZXRjaCBjb21tYW5k
IGhhbmRsaW5nDQo+ICAgKi8NCj4gQEAgLTEwNDcsMTMgKzEwMjIsOSBAQCBzdGF0aWMgdm9pZCBm
dXNlX3VyaW5nX2RvX3JlZ2lzdGVyKHN0cnVjdCBmdXNlX3JpbmdfZW50ICplbnQsDQo+ICAJY3B1
bWFza19zZXRfY3B1KHF1ZXVlLT5xaWQsIHJpbmctPm51bWFfcmVnaXN0ZXJlZF9xX21hc2tbbm9k
ZV0pOw0KPiAgDQo+ICAJaWYgKCFyaW5nLT5yZWFkeSkgew0KPiAtCQlib29sIHJlYWR5ID0gaXNf
cmluZ19yZWFkeShyaW5nLCBxdWV1ZS0+cWlkKTsNCj4gLQ0KPiAtCQlpZiAocmVhZHkpIHsNCj4g
LQkJCVdSSVRFX09OQ0UoZmlxLT5vcHMsICZmdXNlX2lvX3VyaW5nX29wcyk7DQo+IC0JCQlXUklU
RV9PTkNFKHJpbmctPnJlYWR5LCB0cnVlKTsNCj4gLQkJCXdha2VfdXBfYWxsKCZmYy0+YmxvY2tl
ZF93YWl0cSk7DQo+IC0JCX0NCj4gKwkJV1JJVEVfT05DRShmaXEtPm9wcywgJmZ1c2VfaW9fdXJp
bmdfb3BzKTsNCj4gKwkJV1JJVEVfT05DRShyaW5nLT5yZWFkeSwgdHJ1ZSk7DQo+ICsJCXdha2Vf
dXBfYWxsKCZmYy0+YmxvY2tlZF93YWl0cSk7DQo+ICAJfQ0KPiAgfQ0KPiAgDQo+IA0KDQpXZSBh
Y3R1YWxseSBuZWVkIHRvIGFkZCBhIEZVU0VfSU5JVCBmbGFnLCBmdXNlLXNlcnZlciBuZWVkcw0K
dG8ga25vdyB3aGVuIGl0IGNhbiByZWR1Y2UgdGhlIG51bWJlciBvZiBxdWV1ZXMuIElmIGZ1c2Ut
c2VydmVyDQp3b3VsZCBkbyBhIGxvd2VyIG51bWJlciBvZiBxdWV1ZXMgdW5jb25kaXRpb25hbGx5
LCB0aGUgbW91bnQNCnBvaW50IHdpbGwgaGFuZyBhZnRlciBGVVNFX0lOSVQuDQoNCg0KVGhhbmtz
LA0KQmVybmQNCg==

