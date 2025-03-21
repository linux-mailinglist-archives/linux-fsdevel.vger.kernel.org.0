Return-Path: <linux-fsdevel+bounces-44714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 764C9A6BB9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 14:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D94CE7A3CD9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 13:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344F722A7F4;
	Fri, 21 Mar 2025 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyberus-technology.de header.i=@cyberus-technology.de header.b="P0JKRd4j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from FR4P281CU032.outbound.protection.outlook.com (mail-germanywestcentralazon11022125.outbound.protection.outlook.com [40.107.149.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33D71CAA81;
	Fri, 21 Mar 2025 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742563081; cv=fail; b=Gda/iCf9DvDffhK5LNAqXroLr24uuXQLmgfpR868MimVkM/Rangrh37b/hNZgDlLGhz4TnMo/1X3Q1TmeM87Wjeq1WgzAX/DrGctu7u+bNZH8EjcdVZcTWOr4NLBHZDH5sWAq00FWWOaaJHjx3Ey52rCsTCZAXYhOFscTqhi2MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742563081; c=relaxed/simple;
	bh=ecP+O0Ba5WqqwSuD4IUF52SVsnnUVHTMp29qqu5nnoA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pXs/Sqj2Ny3X8cTLirTgRdXUiN3PNHxVAjCeuHrzowElyd0inkLj8TqLlu1hLpFLv1V6mVbO4zPHsCsAlrAZ2IgH7o66Y/1Ljd72AM6OfitG1Ivva6pcA3soiGdd6CLSFhJtV0XVf6iQI4TeEMFUTCtP0f1DAp59iopBaWP3IEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cyberus-technology.de; spf=pass smtp.mailfrom=cyberus-technology.de; dkim=pass (2048-bit key) header.d=cyberus-technology.de header.i=@cyberus-technology.de header.b=P0JKRd4j; arc=fail smtp.client-ip=40.107.149.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cyberus-technology.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberus-technology.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wzjjnR5i4Wh0zJSoSHy1RBTswagihLJjD/S2RAeP3I7+6/b56he52/K9y9iNaD0iBHCeQW6ggjhd7jOON8qYb3BsOH/z2GfKm/plk/0rWZNVvAoaSRzLsxexkowPQ4w/P5UUo8K/UaibpMKTtpNTqmrvSKzOuGjAygEXc9aBX83RU6B2vDPJfyOEaSQuaOpDtZu/JDFi05PRmnec4s7Hnzi5SQa6LbOsv/Qp+bDOAfFvBjh+ivo56OzzxpYeWGMLviwJ7NLrUQL1eE9SoEloDfuilMVO3JXMdNtpYvZwBoQ78pSAgXQ8ewMnsijbu+C0bb026bejBq7Tdm1HljgBgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecP+O0Ba5WqqwSuD4IUF52SVsnnUVHTMp29qqu5nnoA=;
 b=TMZts/lU7VnaH3iNL/X0vHVGRnoO47YpDoF4xJChF+KNVOQdp9l/1IECfGoxfvzDy4fNgCf8R6lPSK2p7jDZl8CXhDb4tPzyj4eaX2fSJDhOsFtRyg9v2Emd+vckn2gwZ1MtH+fRSg8DJ4ssWro4aN8HAjUsIOP4NZdd+9H98Yq/xwKTipaHkraCQMKaep7mGDzR+fXcKsmrHQjzenJ0YpSRQnqQZblBX8jT75J+3X48tP99UDjhAMmfUgpqCCh4QsyJpylQpCgSWiQR3Ql8bYQmTgA5K0kcvEF4F49Dr9iKmA9MU0vdbuNpIPGui0PVMUoAmi6elP6qhLhGP2VPeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cyberus-technology.de; dmarc=pass action=none
 header.from=cyberus-technology.de; dkim=pass header.d=cyberus-technology.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberus-technology.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecP+O0Ba5WqqwSuD4IUF52SVsnnUVHTMp29qqu5nnoA=;
 b=P0JKRd4jzY4xwIkeJZaRsbwHmMKAdeQwQefqI45dOuSxM/yZzHkdspSZoR2yMWEgffcxVcjNrwAuuYvKiVlfEjdR+cyrix8RlGNHquGezy1oYc3PQS6Wuz5zoSouRZ18pw/ogIZy4yrj0kUGhbzTJFg+jdkVo6IpD/2zcgdMNH6roR3QlDKL3DPsCEw34ems0V2A3488IrTRWyVdL0kg36E0bQb+fAy5Fo+f0QJ1eq+G+WnfPPmYxWMCDs2jTEdxgNlXQgFEtCGq/1GMMpsiOodoWbWkvOv1GiL4uDHXpIi32HIdXm/I01tCk+cSF9B+ZDeLC6A9isNqECwjnCVRhQ==
Received: from FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:38::7) by
 FR4P281MB3604.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:d7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.36; Fri, 21 Mar 2025 13:17:54 +0000
Received: from FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM
 ([fe80::bf0d:16fc:a18c:c423]) by FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM
 ([fe80::bf0d:16fc:a18c:c423%3]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 13:17:54 +0000
From: Julian Stecklina <julian.stecklina@cyberus-technology.de>
To: "hch@lst.de" <hch@lst.de>, "hsiangkao@linux.alibaba.com"
	<hsiangkao@linux.alibaba.com>
CC: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] initrd: support erofs as initrd
Thread-Topic: [PATCH] initrd: support erofs as initrd
Thread-Index: AQHbmc5FhigEqeqdAEenfkqes+M237N9CO4AgAAHcoCAAINRgA==
Date: Fri, 21 Mar 2025 13:17:54 +0000
Message-ID:
 <933797c385f2e222ade076b3e8fc5810fa47f5bd.camel@cyberus-technology.de>
References: <20250320-initrd-erofs-v1-1-35bbb293468a@cyberus-technology.de>
	 <20250321050114.GC1831@lst.de>
	 <582bc002-f0c8-4dbb-8fa5-4c10a479b518@linux.alibaba.com>
In-Reply-To: <582bc002-f0c8-4dbb-8fa5-4c10a479b518@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cyberus-technology.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2P281MB2329:EE_|FR4P281MB3604:EE_
x-ms-office365-filtering-correlation-id: 03b594f2-6451-4a65-edba-08dd687aca35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T2xNdThSMUdxOE9YU3FsajRFOFN4MkFkVkFMa3hXOC81OG5acmhKenFSN25U?=
 =?utf-8?B?Y3R5Ymlhd1Y2cGsvZ01lUXlLUkh1SFZWNHl0dUprY2FiS1pJRjhtaW1Nb1VW?=
 =?utf-8?B?Y0JIUWhEMW9WRTlPS0taK1p3ZE5GOG0ralpQTFRMRlZKTkN4U216QlYrbkhl?=
 =?utf-8?B?L1YrNUxTRlFhZE91WTEyeStyaVlmcXVvYkFmMjIzVTg2bjkyb2hldFlySW9Z?=
 =?utf-8?B?VWc5Zys4SS9hQTRoaEdXN3RvcnYvNEEycnNsMzVsOUYybTJpVVY1R3ZLbElF?=
 =?utf-8?B?Y0pIczFsQ2diNHNGNXNxSFF5WDlNODl5dThQTXp2R0JIOXJ1YVFJNFlZOXQw?=
 =?utf-8?B?OFhyL1JKUlhNdlZ1RTkvOWVHSUtEaDZFM1QyMmFRNWtuTFRJVTRhTzF3bEQx?=
 =?utf-8?B?dDlIaGNTVTBvYm9OdWNiT2R1bDF2QnhYaWlXeGI3QzRiZTI0UXZqNGdmZHM0?=
 =?utf-8?B?alRRdkU0VzhKZFR4Q1V5eU5tNkI4WUFRam5hTXRuN0RyWXd0V3RTcTdSV24z?=
 =?utf-8?B?M29sbENIRWdvQkMzQ29ENFRYMDZ6TU1GdnBSczA2M2ltZ0VwZW5JSkRKa3B4?=
 =?utf-8?B?ZTJIdzlEU1o2L0MxMDZqMGRjL3pnVG95bjhaVW1oYzFPeS9xZXhka3JBV2h0?=
 =?utf-8?B?M1lRRXB1K3dnNDkyTU5oSm83eTljWXA3bmF1UkRweTVFSmFnS2d6alpNeHNP?=
 =?utf-8?B?OThuOHhzZ1daQmkzN3JhWkRCZUZ0SHB4WDVNa0g5ZW1zNnYyamJ0STNKTDQw?=
 =?utf-8?B?YmRlWDZHVkNRWXVXN0JWUEZVSExPVWI1V1p1SWREM243MUhNNUZVb21wN01G?=
 =?utf-8?B?RGJRUTFkaHBkbWlYMGw3TWxUUUs0Skpaa2ZBNkVCQmZ2SHZXdElURE1oTzJL?=
 =?utf-8?B?eEN2VWpQVjFJc0FXUndTVWlvOU9yaEJYZ3RqRThrVGhDOUg0VTdnTXRhbjA0?=
 =?utf-8?B?bktudDdRY3hzOFJiZGprMXJYS2luZGdqbFl2cTVzR3FmYXFZV3NvMDRLbjdV?=
 =?utf-8?B?eVhDTmlzRmZENmx5ek8xL3ZIcjQ0Z2JoSUxEK1pVdG90ZWRvbExqVlpxZ2Rp?=
 =?utf-8?B?YjAzWGZreFc4UlA4aWpuZzVma3pTdlYrSWI0WWUvMGt4aDk0Rlp2WnpuR01I?=
 =?utf-8?B?UCsweWh4OTBWSG5wRGx2ci9vamZqVVphK2xWZklLeGFuc2N4bllZSU11d1p1?=
 =?utf-8?B?aGxQck5naHpDeWNOY2JDYmpsN3NLaG5mRkowMnZXNnkzMmdDd05YeExNMFdQ?=
 =?utf-8?B?V09VV3NOUGg1cVZ6djdHeXVsd2N0TXJHMXdWWmNNYU43QnppV0FQQ3FLWWtt?=
 =?utf-8?B?VWFhTGdLU0NBNmJvQlNEQWhnVkFhYThSNjBqamczSGxva0ptaUE5MVZMN3p3?=
 =?utf-8?B?d3U1T0xWN3hQZnY4Ly8zaTd1eC9TK29ScnlrUnd6WVFaWjJ1ZFhJdUU4bm1H?=
 =?utf-8?B?TkREZHVCQkNlbmo5VGFLZ292a3lxNFhMV2NITkkrMnRzMW4wa2VJKzEvSWdS?=
 =?utf-8?B?Yk82WjJrZDVFYUZhOWE0azhkcXVkZXZPVDVQUVlvNWdPM1c2cC9uYTR4ejNZ?=
 =?utf-8?B?NkVublpKZWZIbkhFd0FmOUJXMkhudGNDNFRJS1RhVVZsKzZOUVZIanNVQU1H?=
 =?utf-8?B?WDdsSnpCc2N0S3NPc3p2Rmw1eXRxeEd3aHFET0FaZVU3cjVNOGJrSW1aRjJF?=
 =?utf-8?B?NWNiWjgxL3BXYnBYaFFHUENPMjI5azBBT3M1OEZwSmh2RGRpVU1keERFOUxP?=
 =?utf-8?B?S0NuMmw5VkJhcGhrOHpWb3FZUUdqVVU2NlZKNzgyZW8wMUg0SHQveFRIcm83?=
 =?utf-8?B?dHBUdzVQc2lWSFZHUUpWVzV3ZGMraUdySnU3Y3h1WDFWZjhoc2orUUhGYTFI?=
 =?utf-8?B?ejNyaW5PTmd5cG1mTjFycENnUDFyNmp5bitYRy9BN1pkKzB2eFZuMWtTMFNH?=
 =?utf-8?B?V1dzZjRHYllIZFUyWkNSaVRXYlZnRkZPSjRrc0IzMUQ1TFhNMElDa1FrSHFN?=
 =?utf-8?B?N2VPWjdQMG9nPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0ZyZmRoTi84ZW55SjdTREc4SkNKZTA5RFdRb3ovd1F5WDdCRnV2RWRWZWYy?=
 =?utf-8?B?Ni9Qc2d3UEFVeWpOWCttWGdHeW5aQU5WZlc4dkQrMUdUcFlJeVV5V0pEWkFE?=
 =?utf-8?B?b240TVRmTHg0bkExYXZaNlRxREc2TXV3UWozR0tMcDM3UEFYaTUxNDQxN3Ri?=
 =?utf-8?B?RFNwbEwzMWcwVncwU0E1QnlNUnRzeEF1UlBaNEpVMjBHT1Rnb0ljd2wySndP?=
 =?utf-8?B?ZU9EN2dpbWc5Qk5xOGcvR1psQ2hDU0M5MEtWMEtxYWZoV0VQTzRmd2tCTVBq?=
 =?utf-8?B?b1ZQZHdJR0tFWjBUM2s2b1lxd3FtYTE5OEhUL1dsMVhsck5DbWp2Z1ZmKzcz?=
 =?utf-8?B?VUJCYi9qdjJYYjkvaVdveFh5OTVDNzRreDM0SGsvdkp4R3JvNEZrT2ZGeGdE?=
 =?utf-8?B?bmNGa0JLMEhDd2d3Y1dSMmNURkoxQjd3bHVTdnVBYlZ5R0lNUjkreXJFemRQ?=
 =?utf-8?B?Mk5FcTROV1FMNFM3VXpvYUY4SGxiVU84L09GRnVEZHZIZ0U1TWxjR3hzdysr?=
 =?utf-8?B?OEorMmlnVjNmQ1psZnpnMThXOVdlVEYrZDJ5MmYxVWdLZnFJTW5aM2ZtdzM1?=
 =?utf-8?B?UUxrRG95TlVxOExhVzVhZ2ZhYzBsTUVZd3J4dVpXY1dzS1N0SEczWTFKRXNK?=
 =?utf-8?B?dElPY29Od2x3bG9MUFMrU0NzclN3SmVxV3ZOR2IyQ3VBVnlvSVdUdlRlaFVr?=
 =?utf-8?B?YTJDSDhKaU0zeVNhb3BydGZYcVZCTkxuNFJMVXNOUnV2cHJjTzhxdjZuZDhQ?=
 =?utf-8?B?aWlFM0hrN01DK2ZOancvc3Rla3FRZDh6TlNnTWx0M2VLRXF2blloWVVucnA5?=
 =?utf-8?B?dkU2UVpiUTVSMWFqRStBcHM2Tjl0QlhRQlVoT3NCM0EzeHoyRnlwNVk4T2Va?=
 =?utf-8?B?WU45UFdlRmV0elBEM2JadDUvb003a1VrNW41aW9UNGEvZlViNWRDYnJ3dW04?=
 =?utf-8?B?UndlTXJuRTlQMFU2ZHVZSng5L3ZISlBoK1lKWGU4ejJaNVZlZFM1ZnNyVUFD?=
 =?utf-8?B?cDNobzNLY2NFWGNZUW1nektIU285Znp5UlltR1p3U1dCb016amorUENOM29o?=
 =?utf-8?B?MUxIRUdEb0FldHhFVzRwRHZvcjFJeVdVeE45eTVqb2NWaFpLRHN0VlNLMVZH?=
 =?utf-8?B?NWt6bWRZdVpWang1NVZkbGEvWjNqMmZ3VDB1akdkUXhKbjZ3QUZ0bE5uR2Fr?=
 =?utf-8?B?RzlBQ1NrQjZ5QTNQM25JbjcwVDA2WlU2eUdKZEZjaGxGL2NWOWYxRmZldTB5?=
 =?utf-8?B?S0hEUzRqK1V5enNSK0dCOCtnakNZeU9LOUZGck5VN0taYVg0eFZjZnlmMVZx?=
 =?utf-8?B?Y3AxTGE2SXBHVks3cFh3Rmxrc2JVaU8yVy9UVkVoTXN1T3I0S2c2NkFQSCtY?=
 =?utf-8?B?UzhlL21XR0RjVElwckFuT2ZyNGFNTklDOHFGOUFiVG9ObUYwcU9meEQwdDdr?=
 =?utf-8?B?UTF2bTRJak5rYnFjYTg1N2tQaUN4MlV5cHh2NW9XU0dQeDNVR0Z3NHFINVFI?=
 =?utf-8?B?ekZ2ejZBMGw4Z0dWVEx4a2NwR0ZCS3c3MmRpNEhFeGdqd3R6bkRGL1FlV0ZX?=
 =?utf-8?B?ZWpiYjdON2Q4OHFMaEdFenlTZS91TFNDWEdSTW1na2h5cm56VyszdGhreFVP?=
 =?utf-8?B?QTlPMlFSRFlDQUVuRUd1NFhxeitINmZCNURGYWhWUnhZVWJwdzRNL0Y3Z0Ri?=
 =?utf-8?B?UUZIOHJqZGswR3B4VmxyYjR4czl6QWlDNFNyVGQwZGYvemNucjh2cmwySG1m?=
 =?utf-8?B?bjAvbTIwQVd0SDI0YVJReUJpc2s2RFhtL0ZQWTcvbENGVkdzakl0WmN1dEF6?=
 =?utf-8?B?UFRUMUNCVm1hVlg0cUxhOHB2elhRaUVzQ1NLM1BtUUdPMEoxd0YzNFppTmZG?=
 =?utf-8?B?RnlUVG1ZdUFFQlB1YzZNRzl2WTBnRUprblpsODdkcWNEekRKZG1hK3JmbTV2?=
 =?utf-8?B?RUNvU1R6UStnMnlQeFg4S0VGejVsREJxWHlJUzFzemxXWlBuazUvMTNBTEtq?=
 =?utf-8?B?NXZHYnhCeUdtK0dNaCtTNENuSmhGNmpiRUJod21hSW5QbmZzRmZlMnlYaDJh?=
 =?utf-8?B?M0FkNEIxd1UzbWNBODE3SzYrczJua2pQekdFSHBaYzFyaExmZmRKcElqNlVJ?=
 =?utf-8?B?UUdLRHlBNHhFQmxVUXpqWWVkSDRoZEduOHJmQ1V3UWZFNm5SWjRmbGxuSEc0?=
 =?utf-8?Q?/rB/kApYVrWyf7Om9a8y5cndEzrsgKr1uFNp9L5hoQde?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AC451978C487343B07212B40305FFE3@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cyberus-technology.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b594f2-6451-4a65-edba-08dd687aca35
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 13:17:54.4041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f4e0f4e0-9d68-4bd6-a95b-0cba36dbac2e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gJ8fH5i03qHXvKkSoUKgmLXwOJSiaiJMGqTOBRdB7tJ5iJTDf4wayfQrmZGTBlndf1gZLS6CGCu3aCtYiplF3OiTRRVFaKHksSIaeszijHSCCSCag/XMnEbL1UlzXFQ7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB3604

T24gRnJpLCAyMDI1LTAzLTIxIGF0IDEzOjI3ICswODAwLCBHYW8gWGlhbmcgd3JvdGU6DQo+IEhp
IENocmlzdG9waCwNCj4gDQo+IE9uIDIwMjUvMy8yMSAxMzowMSwgQ2hyaXN0b3BoIEhlbGx3aWcg
d3JvdGU6DQo+ID4gV2UndmUgYmVlbiB0cnlpbmcgdG8ga2lsbCBvZmYgaW5pdHJkIGluIGZhdm9y
IG9mIGluaXRyYW1mcyBmb3IgYWJvdXQNCj4gPiB0d28gZGVjYWRlcy7CoCBJIGRvbid0IHRoaW5r
IGFkZGluZyBuZXcgZmlsZSBzeXN0ZW0gc3VwcG9ydCB0byBpdCBpcw0KPiA+IGhlbHBmdWwuDQo+
ID4gDQo+IA0KPiBEaXNjbGFpbWVyOiBJIGRvbid0IGtub3cgdGhlIGJhY2tncm91bmQgb2YgdGhp
cyBlZmZvcnQgc28NCj4gbW9yZSBiYWNrZ3JvdW5kIG1pZ2h0IGJlIGhlbHBmdWwuDQoNClNvIGVy
b2ZzIGNhbWUgdXAgaW4gYW4gZWZmb3J0IHRvIGltcHJvdmUgdGhlIGV4cGVyaWVuY2UgZm9yIHVz
ZXJzIG9mIE5peE9TIG9uDQpzbWFsbGVyIHN5c3RlbXMuIFdlIHVzZSBlcm9mcyBhIGxvdCBhbmQg
c29tZSBwZW9wbGUgaW4gdGhlIGNvbW11bml0eSBqdXN0DQpjb25zaWRlciBpdCBhICJiZXR0ZXIi
IGNwaW8gYXQgdGhpcyBwb2ludC4gQSBncmVhdCBwcm9wZXJ0eSBpcyB0aGF0IHRoZSBjb250ZW50
cw0Kc3RheXMgY29tcHJlc3NlZCBpbiBtZW1vcnkgYW5kIHRoZXJlIGlzIG5vIG5lZWQgdG8gdW5w
YWNrIGFueXRoaW5nIGF0IGJvb3QuDQpPdGhlcnMgbGlrZSB0aGF0IHRoZSByb290ZnMgaXMgcmVh
ZC1vbmx5IGJ5IGRlZmF1bHQuIEluIHNob3J0OiBlcm9mcyBpcyBhIGdyZWF0DQpmaXQuDQoNCk9m
IGNvdXJzZSB0aGVyZSBhcmUgc29tZSBzb2x1dGlvbnMgdG8gdXNpbmcgZXJvZnMgaW1hZ2VzIGF0
IGJvb3Qgbm93Og0KaHR0cHM6Ly9naXRodWIuY29tL2NvbnRhaW5lcnMvaW5pdG92ZXJsYXlmcw0K
DQpCdXQgdGhpcyBhZGRzIHlldCBhbm90aGVyIHN0ZXAgaW4gdGhlIGFscmVhZHkgY29tcGxleCBi
b290IHByb2Nlc3MgYW5kIGZlZWxzDQpsaWtlIGEgaGFjay4gSXQgd291bGQgYmUgbmljZSB0byBq
dXN0IHVzZSBlcm9mcyBpbWFnZXMgYXMgaW5pdHJkLiBUaGUgb3RoZXINCmJ1aWxkaW5nIGJsb2Nr
IHRvIHRoaXMgaXMgYXV0b21hdGljYWxseSBzaXppbmcgL2Rldi9yYW0wOg0KDQpodHRwczovL2xr
bWwub3JnL2xrbWwvMjAyNS8zLzIwLzEyOTYNCg0KSSBkaWRuJ3QgcGFjayBib3RoIHBhdGNoZXMg
aW50byBvbmUgc2VyaWVzLCBiZWNhdXNlIEkgdGhvdWdodCBlbmFibGluZyBlcm9mcw0KaXRzZWxm
IHdvdWxkIGJlIGxlc3MgY29udHJvdmVyc2lhbCBhbmQgaXMgYWxyZWFkeSB1c2VmdWwgb24gaXRz
IG93bi4gVGhlDQphdXRvc2l6aW5nIG9mIC9kZXYvcmFtIGlzIHByb2JhYmx5IG1vcmUgaW52b2x2
ZWQgdGhhbiBteSBSRkMgcGF0Y2guIEknbSBob3BpbmcNCmZvciBzb21lIGlucHV0IG9uIGhvdyB0
byBkbyBpdCByaWdodC4gOikNCg0KPiANCj4gVHdvIHllYXJzIGFnbywgSSBvbmNlIHRob3VnaHQg
aWYgdXNpbmcgRVJPRlMgKyBGU0RBWCB0byBkaXJlY3RseQ0KPiB1c2UgdGhlIGluaXRyZCBpbWFn
ZSBmcm9tIGJvb3Rsb2FkZXJzIHRvIGF2b2lkIHRoZSBvcmlnaW5hbCBpbml0cmQNCj4gZG91Ymxl
IGNhY2hpbmcgaXNzdWUgKHdoaWNoIGlzIHdoYXQgaW5pdHJhbWZzIHdhcyBwcm9wb3NlZCB0bw0K
PiByZXNvbHZlKSBhbmQgaW5pdHJhbWZzIHVubmVjZXNzYXJ5IHRtcGZzIHVucGFjayBvdmVyaGVh
ZDoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci9aWGdOUTg1UGRVS3JRVTFqQGluZnJhZGVh
ZC5vcmcNCj4gDQo+IEFsc28gRVJPRlMgc3VwcG9ydHMgeGF0dHJzIHNvIHRoZSBmb2xsb3dpbmcg
cG90ZW50aWFsIHdvcmsgKHdoaWNoDQo+IHRoZSBjcGlvIGZvcm1hdCBkb2Vzbid0IHN1cHBvcnQp
IGlzIG5vIGxvbmdlciBuZWVkZWQgYWx0aG91Z2ggSQ0KPiBkb24ndCBoYXZlIGFueSBpbnRlcmVz
dCB0byBmb2xsb3cgZWl0aGVyKToNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDE5MDUy
MzEyMTgwMy4yMTYzOC0xLXJvYmVydG8uc2Fzc3VAaHVhd2VpLmNvbQ0KDQpUaGFua3MgZm9yIHRo
ZSBwb2ludGVycyENCg0KSnVsaWFuDQo=

