Return-Path: <linux-fsdevel+bounces-53096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F64EAEA07C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 16:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCFFE188E5B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 14:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753472E336A;
	Thu, 26 Jun 2025 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="ajseSR20"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010012.outbound.protection.outlook.com [52.101.69.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C2B1E25E3
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948051; cv=fail; b=rOQxHERBjQSPYZm2UogEo9a1mdgd61Gj+XjYP8QnRFF4F54l3/7kWqBZafq4epL3ghzzDi2V0Lhb3rtv/0UgAgs+2IfWGlGR1BR+bfk2ahVxjave8jmzKJ9ZyacGnk7jtXMxD9abXhxsQ8kgdUqQYttI2SIi7kHLu3tI5eR1sbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948051; c=relaxed/simple;
	bh=kuC2Fl1S6brwyjGIZTdQq3dgCMKFd8eToZ5JdNDHp7Q=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uFgyX/MpKtIIN/L10ATPkR1XoqIAiJm/uZZo4U6Z2w/839OcT6UZm/HKxM+jbQtWUBZO9kuMbptubwSRSH/rZwE2xCiOtRWkKK3AJUjq2IPBvYSsw0HAigm99l07zKrVM6XxEmAiJLf816AMmNK0VoBvbyiESJxTe/5XUW5r04M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=ajseSR20; arc=fail smtp.client-ip=52.101.69.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQlcSAV/Nz4yvxgR1k3MLeF5FpnLB5ORKSFmK1nzd+ERcUUlfiS23Ckh+vpe+2pTs9e1fM06SOa0rJcyYCSKmQQ0SEayg2mIMNrZbwnuDntOsChO43mFY6ct7odqFUi4VpmiPAoE86ZCrl+OBQpC142KqLGM3KeRsE230shitbBREwDOemgsJ9I0ZlFpnBUT1DXyiXSVxCmkWhERhyoEmaLTxJ9qFAWA8M+wH/NLMZvfA+GbpIlZ4scgYyAq/9OmiApFw3yzGU+ExS487hRYhTNlyPt6n5NfD1jEX0gOTrEde+PqWzKtgPHqC8rNrPlZu+91hJVefz3kiZK506f/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuC2Fl1S6brwyjGIZTdQq3dgCMKFd8eToZ5JdNDHp7Q=;
 b=PpQSPjJ8f20Oyjwu5aJwiaSqdkIxTStBNyaaqImzLqxyo1a8+p1nbdd0nZDEHnzW/onzg2GFaFu91DVu6WDxxpgADIiQHTIMa7mzH6L1Lb/2Oy++N2+GuQfzqVWsATM2ncBdvbtGOCnhuIWFeCUzqK0ODTIyYxmJZs4pmk0nV1B9q6lA4nApY+dGXaP+ikh4xTjDGHQObAxy6NQjiMli9qcw9eIDOANCbTehM5GryGPFUclPfqGaBedYhJX66cgojpH8BKAXbEC5v9Qh34UhNZqfLTyyQcRP/ny4duQ721fCz9DZ71OHnSO0/V9TzgCXfczyREDpszSkuLWbTpApZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuC2Fl1S6brwyjGIZTdQq3dgCMKFd8eToZ5JdNDHp7Q=;
 b=ajseSR20TCOvVViu57pMKpunSrh8pBvnU0g0Utf3jJeRc/xKjrVaThfvIq7+qkYrH1pFbfwosaQ7TV5yJbBwjG78VcUbe8uhY5btXO7/73nx1mY4OVTMbLaV0eUaJsA7OsxsrnAJpMMEREX8lRwpNZiE8r+T6khP07ZBZrofsMXyAcm9wTD6wAKVz4p8Mpfa9LZ3LSFoKtPNG/kylGF1fQJOZ7dJlTY6dF+5ji8wyp3ILnvUnYoXxd8wpYC/XZvZstjjfh5ZFHKzyOCjo6J7xhNlBCmrt0bFOvBNAEO84OctFAAAzYeBVn4fH1rU1C/aEfeSAJp8DP/8lsh4vge79A==
Received: from AM6PR07MB4549.eurprd07.prod.outlook.com (2603:10a6:20b:16::28)
 by AM9PR07MB7908.eurprd07.prod.outlook.com (2603:10a6:20b:30a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 26 Jun
 2025 14:27:27 +0000
Received: from AM6PR07MB4549.eurprd07.prod.outlook.com
 ([fe80::67d6:5a88:7697:5e9f]) by AM6PR07MB4549.eurprd07.prod.outlook.com
 ([fe80::67d6:5a88:7697:5e9f%4]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 14:27:27 +0000
From: "Joakim Tjernlund (Nokia)" <joakim.tjernlund@nokia.com>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Phillip Lougher
	<phillip@squashfs.org.uk>
Subject: Re: squashfs can starve/block apps
Thread-Topic: squashfs can starve/block apps
Thread-Index: AQHb5nGdF4RIk2KD1kCWx8Hz+RNSl7QVf/0A
Date: Thu, 26 Jun 2025 14:27:27 +0000
Message-ID: <88b54d9a1562393526abc4556a6105ef1aca7ace.camel@nokia.com>
References: <bd03e4e1d56d67644b60b2a58e092a0e3fdcff57.camel@nokia.com>
In-Reply-To: <bd03e4e1d56d67644b60b2a58e092a0e3fdcff57.camel@nokia.com>
Accept-Language: en-SE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR07MB4549:EE_|AM9PR07MB7908:EE_
x-ms-office365-filtering-correlation-id: 5e6238e7-c603-4286-fc0c-08ddb4bd938f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VDlMUFpnTkdJWjVoNW9SNllQRk5TQlJ0amk4cDBFS21Rd0VLQko5bnVmMldV?=
 =?utf-8?B?Y1ZVNWJ3eGcvcHFsZGRseEFqZ3krMzY4aTZtWEZUbkg2dmkrSVlTbkpOWmc2?=
 =?utf-8?B?WlpIRGZ2UjkxZmgySE1HalZoWlZQM3RIV0d1SGFRSCtLZ3dKQUt6eCtIK0py?=
 =?utf-8?B?WDcydUl2UktaSnZJR0hoMWdOZStwUzdHVXA4NXFNdDlJcSs0MmVKeEVaeG04?=
 =?utf-8?B?YUR2d0FKbUUxRThsSm1jbzB0SUJjaWtaK2JneEVBUHhrT2RNR2U4NkxyT1d0?=
 =?utf-8?B?MTAyNE1FTkp1a013WGtSOS9PWXhZRFJBMnhXN29sQWE5dVVMTlZtOHFnWEYv?=
 =?utf-8?B?cEVZVVc5dUtIazNlUDRSWjVFRzlOb0JzVVFOc1NTRzFta2c1MXRrTm9EcTJL?=
 =?utf-8?B?ajJweXlQL3cwVXBMR3l3czgyeGsyNHduWExTKzJkY1BtWkdKU3BDc0Y5TzF1?=
 =?utf-8?B?b25oUFo1MDZhT25ucFdXeG84V1ByZHlRT2tiQkRpVkZ2UmI1RncrbDJyaTVC?=
 =?utf-8?B?SFl6dzdlV0c0M09ueDdTZGx2TXI2S2NWcGpCakRlM2FNRXBYS1Y4QVVNd04w?=
 =?utf-8?B?SXpacjhRYWEyaGRteEVGdmFpNlVjTTc2dit0V2RmZlcrODRUVGJYeXpJT2Fo?=
 =?utf-8?B?S1AwdDcrcDVUZWczOEZaVUpLR28yYUZQNDRDWXl1UkNGd1d6YlNQZU9TL0xD?=
 =?utf-8?B?ZWVsR1J2Nm9SekZsUTc3N0xiWFRtTzdIRWFxMjViMStNam5nSVBJNDg2RlpR?=
 =?utf-8?B?S1JEeVBPalRZTUxTalJlTzJzNjZvVVFGdU1QdVBCQ3Y5b1JOVHZ4aW45OEE5?=
 =?utf-8?B?M1FvMXJUNG1wbzNwb1N2RWZLRStiL3RPeU9IcFVsZVFpN0d1RGo2c3FLYTdD?=
 =?utf-8?B?YUR2U1BFY2VXeFJocXFZeXpXazJzb2tlSHN4bGpBcVZNQ1V3cFE2LzFsNUR1?=
 =?utf-8?B?SmlzRlNWaTdvM1U2L0owZkhCbW5za3g1SElDOEp0NEl1SjdRdlhzUnFGY2xE?=
 =?utf-8?B?QkJvdXhCall1RC9ZdjBPL0o0Sk1VK1oxUXluWnZZRjIrWlorMWViMEhUWlQx?=
 =?utf-8?B?TWY2Vk1KbGl0WVM3V2tsdE4wUFZRSjRYOGlwTnEwZmpheXBDTHdCVWFyUmRm?=
 =?utf-8?B?WkpsUUVxTy9YWSs4bnF1QUtTSnFNa1hSWUpucXFmQmlLNWNCZ3dSbnhYT3JL?=
 =?utf-8?B?TlZSZWVYSVZxbW5yMGlGR3pyUVIza2tVYzQ4NWVpZEdPdFRRWnpZWGN5SnVj?=
 =?utf-8?B?aVBxY2xLYnZuQjd5VWNaUGRTbnE0VUEzZkliYTE4ZTNZT09XTGIyVlRiUGNV?=
 =?utf-8?B?S2xkd3ZManc4Ky9jQXBKNUVqeTBIRFJtQkd4OFM3dnFhM3FpQ2Q1czNiNmIw?=
 =?utf-8?B?Vm1PMGpEeTJBdnUyTStYY0NQV0VhNWJVUW1lRHE3VkRJWDVuY3NISHozWHRK?=
 =?utf-8?B?MEFTczlCZ0N3TU0zeTFXaFNlRlNwVmZRY2llK0doanhOMlhxdlRWbVFSYm5O?=
 =?utf-8?B?NEJyNFZFeDVOdjVWeHV2dXZreTZFcWNtTWpwa3pFT3JmbExVWUUwaXJwNFFa?=
 =?utf-8?B?MVd2NXdpNXUzU21QZWpFU0c1eXhZV2plM2Y2OURwRzJjUjlMZlRxMzlkcW9F?=
 =?utf-8?B?ZDZRazdtS3NuNkc2MVQ0OC82N2Z4bEovNFNxd253VGdlNEozOVVCRjUwSElZ?=
 =?utf-8?B?anpKZWVrOGRDTENzcjNjdGxSbkZERjhQYWVaRDFTVGVQQ2dTd3ZmYVphaWxh?=
 =?utf-8?B?TUV3SE9NbXRYUXRhZnlFS25sMWIyNG9GN0hxazVBU3dqbE5GOU83WnBRalFL?=
 =?utf-8?B?czNERlpweTVsblkvWjFmeWtEaGVLQlU4bUd4dUxqU0xRSDlHWmJMWHJEOS9X?=
 =?utf-8?B?Risvb1NnN1BCQVVKalJVZS90d0tjZFhaTkt6b3h1OE93YmVPUm9YaEJZL0Ev?=
 =?utf-8?Q?tC8C7fl7Mmw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR07MB4549.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RVFLMUFvZzI0K3FPOUMxUEVFNytlUTk3eklHbkQ5YUdvaWhlOHFXQ0lFRGlW?=
 =?utf-8?B?SmY3ZDJIUUYvWnRiSVFIdEg1cUxaSUtrTFFUTDBhZzB3bU10bis3SFhUZFFj?=
 =?utf-8?B?bmRCbUxQbkFtSmp3M3V3Y0luUWtnQWNPcmVYa1R1RnhvSU1CSzMrTEVjR1k2?=
 =?utf-8?B?azlITUxvbU5IblA3MVNtNW92cEU0SmVyYy9Wb2R3YWVuUXBwdVVHRkJVekpH?=
 =?utf-8?B?VXJCdC9LZU5oSkVQSTRwdWdLeHA1bVh5WTQvL1F2SnYvTTJUNHhhVVlzR2ds?=
 =?utf-8?B?OXluZkdnb2lTSy9rRkk5MXFmV281RXhVWUhyWnMwQzVTSUVSN1N3ZkdUc2JE?=
 =?utf-8?B?bHFPT2FnNXQ1cjBYeER2Y3VtS3R2aTcydDBWY1g2YVdUK3RMVm1DdFc2ekNr?=
 =?utf-8?B?UmRVeHZ5czFyL2M2SDlwdmxSOEx5NE5lTmxnNnhsTFRRaHhZZzcvcHZGdWQ2?=
 =?utf-8?B?LytNaTI2dlgrYXJuZHVoYzlXV2tmMHFpYWNCbkYzYTlKUVMyOXA4UlZzeGda?=
 =?utf-8?B?R050U09kRFJmblUwRUdTOE4rejMwbllUVDJnamVKSlR5NFMwVlJOa2N2RWcv?=
 =?utf-8?B?OFBRdFVDZTUvK1BCMTlnVXJBNll0Wmc2TllKd1U1aGl4NHU4c0tZT1k4Tyts?=
 =?utf-8?B?YWlYcGxUUXB2Q21iazdNM2NZMnN0eFhpam04bitzVEVmQksxbXBQd0wxWXh5?=
 =?utf-8?B?TFgxekFvMFRKZ28vWEl0N2ZqOTlNQ0dpRVRaU2hzRC9Bb0dmYmhJREJHaHFj?=
 =?utf-8?B?RDRrQ1luOEFmVEU2Mm13VlBHTlprdG0yQ1lGT2ZuK3JEaDRLZjVTTjdpT3Bi?=
 =?utf-8?B?bDJ2ZkI3YjlzRnlOZDdBem1vbjRoSXFmem1wZko3Sk5wMUZKS1JxZlB1QWYr?=
 =?utf-8?B?ZGN5UWRxVWZGdjNLcElCU3R1aU9uQkpaYWhLQU15UUl0b1BtZld4eEVFaTVQ?=
 =?utf-8?B?K3RDb2cyZ0UwVnFFSjByQUhraUkyMkkwdjR5am50SXFHQXhGRXh0cmhtNU9l?=
 =?utf-8?B?WHJYc1AzYjh4YXlqNmNsRmRYK3VSZG1vM0V3VGlBRVdzN0pweXNJY1NCUllD?=
 =?utf-8?B?QWw4TEd1YVZabUJOdUIzM05BaE85a2ZtTTIzRWk3aHVZRFBoZ2tZWmFJTWw3?=
 =?utf-8?B?amRjTlJqTUphK2F2ZzdmbUl1d0d6b1UwRmpQUnc1NFdFakZzR3MxVUhEOGNY?=
 =?utf-8?B?cVVBeXBJUWpxTVVLTWlSUEJ6Vi9yaDcyYVNuQXltSDZuUi9vdTVwZWlkYzdr?=
 =?utf-8?B?MWl6U3FvcGRwZmVnekFtdnBXOXU2Z3E0V0RTdUJrRkUzSHRBWjBOa0hRMEw3?=
 =?utf-8?B?dWRmNHJRVVNCK05KRmJ3aU1HM0VvZ3BlUVFwR1BLLy9SVXZjbUdVci9xbWhj?=
 =?utf-8?B?VXZvNWE2c1J0Ny9odFMramZnVEE0QVpTaTJJQmxxRVMwR1dPaG4ycEhIdVNB?=
 =?utf-8?B?THJTUEtmNWFvLzFpYlVNRHFiUC9QdU9PVWVJVjlLWHlxVEZKc09Tdk51V1Jt?=
 =?utf-8?B?dFFJTG1NVG8rMXBFOERHYzRMdTBVYnJJZkJNenhqUmpwa3JpaTlmdUNueVov?=
 =?utf-8?B?YlZhbjdqa3dXZno0aHRxM3JmZ1lIVHF0MVVNQ1NGVFpySS9zUlNqL3pEWUZG?=
 =?utf-8?B?TWJCOTlsZm5sTnIreXovOFFleWNSb0QxN2JGbWxSMk5YTGFiRXR0Z2x6QWRy?=
 =?utf-8?B?YnhHdGp4WUtxWVBXL1dnbnBEaFFCNTF5cDFOTHJZaUptcXpINFNhRzU5L0gw?=
 =?utf-8?B?L2dhOFMvNGxJZTJLR0tsSHk2QzVvWDluZGRDdXFzRXY3elNjYW9POElsS0N5?=
 =?utf-8?B?RFFTTDlwQndGTzRzVm00a2dmcXhLTG9xbGcySzhCSVVYTERIYTIzWkc2TVY5?=
 =?utf-8?B?VmtrK21naGFWd1NaakpRTW5ZT1JEbHlZdGN3Q2tqeS8vdXhCK3JUcjZwOWg1?=
 =?utf-8?B?dnlGTVdEcjN0dTNUR1M2R1FKWnAwV0NmL0lIdGhHWUVTQUI3OW9LSk8rcWZs?=
 =?utf-8?B?UC9CcmZvRXBlV2k5RXFJU012c3loemREalFwek1Cekc1UXdSN2wwWi9pWXN3?=
 =?utf-8?B?aTllLzFmREtZeUFmYmNmeDhXbk4zRTV2NGNKM1NlNmtDSHZJdkhaekpRYlVP?=
 =?utf-8?Q?W/KYYVZpJh9YpBhZxqIN5swy4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5341F16B597AFF49A7775E239B9F93A5@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR07MB4549.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6238e7-c603-4286-fc0c-08ddb4bd938f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 14:27:27.3408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PX5JNS5twevL4a7cG8WogdXA0zyj7kl0U6cbtMzem/SqWoWV6pSQ67vj0DXmhIUjL7Ns3240VPuKLUsbL1OB78KDFKXLs5Ul1vVcpViXg1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7908

T24gVGh1LCAyMDI1LTA2LTI2IGF0IDEwOjA5ICswMjAwLCBKb2FraW0gVGplcm5sdW5kIHdyb3Rl
Ogo+IFdlIGhhdmUgYW4gYXBwIHJ1bm5pbmcgb24gYSBzcXVhc2hmcyBSRlMoWFogY29tcHJlc3Nl
ZCkgYW5kIGEgYXBwZnMgYWxzbyBvbiBzcXVhc2hmcy4KPiBXaGVuZXZlciB3ZSB2YWxpZGF0ZSBh
biBTVyB1cGRhdGUgaW1hZ2Uoc3RyZWFtIGEgaW1hZ2UueHosIHVuY29tcHJlc3MgaXQgYW5kIG9u
IHRvIC9kZXYvbnVsbCksIAo+IHRoZSBhcHBzIGFyZSBzdGFydmVkL2Jsb2NrZWQgYW5kIG1ha2Ug
YWxtb3N0IG5vIHByb2dyZXNzLCBzeXN0ZW0gdGltZSBpbiB0b3AgZ29lcyB1cCB0byA5OSslCj4g
YW5kIHRoZSBjb25zb2xlIGFsc28gYmVjb21lcyB1bnJlc3BvbnNpdmUuCj4gCj4gVGhpcyBmZWVs
cyBsaWtlIGtlcm5lbCBpcyBzdHVjay9idXN5IGluIGEgbG9vcCBhbmQgZG9lcyBub3QgbGV0IGFw
cHMgZXhlY3V0ZS4KPiAKPiBLZXJuZWwgNS4xNS4xODUKPiAKPiBBbnkgaWRlYXMvcG9pbnRlcnMg
Pwo+IAo+IMKgSm9ja2UKClRoaXMgd2lsbCByZXByb2R1Y2UgdGhlIHN0dWNrIGJlaGF2aW91ciB3
ZSBzZWU6CiA+IGNkIC90bXAgKC90bXAgaXMgYW4gdG1wZnMpCiA+IHdnZXQgaHR0cHM6Ly9mdWxs
SW1hZ2UueHoKClNvIGp1c3QgZG93bmxvYWRpbmcgaXQgdG8gdG1wZnMgd2lsbCBjb25mdXNlIHNx
dWFzaGZzLCBzZWVtcyB0bwptZSB0aGF0IHNxdWFzaGZzIHNvbWVob3cgc2VlIHRoZSB4eiBjb21w
cmVzc2VkIHBhZ2VzIGluIHBhZ2UgY2FjaGUvVkZTIGFuZAp0cmllZCB0byBkbyBzb21ldGhpbmcg
d2l0aCB0aGVtLgoKa2VybmVsIDUxLjE1LjE4NSAoYWFyY2g2NCkKdXNlciBzcGFjZTogQVJNIDMy
IGJpdCB3aXRoIHRodW1iCg==

