Return-Path: <linux-fsdevel+bounces-68399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2BEC5A3EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C443A99D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC8F31D380;
	Thu, 13 Nov 2025 21:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dVHpyrlh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF0F2D8783
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 21:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763070443; cv=fail; b=mPLzQQcSaeDSEATZQPz3Ov3etZAQJvKhR5/XOZa7zuJC1IUZ8vZVuMKcM8jwPUVsa33Q73Vp0+mzI0I2o9oJsJrXkXGCBCmTyzUYFfcXF3fQDUL8vdGD/tvxJbxIAlQgciBKwQ7P1i+NMaeMRAwyMfeN4sGrqPT3eZz7PkMRhus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763070443; c=relaxed/simple;
	bh=uMhf8MNE/gHi7ObcWlPDffn83OuMJtIOX4yoOd+U8js=;
	h=From:To:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=oh8Gw5b8Wd0ducPlkEbn/mxPXuXw/XTrJj7r6rJKvuQTRgfbte1GAPst9kGFzIJIgo6PU+Jy6SeB//sRgtbmr7f67OxSE9AASzMcRfM4KNA5wi/O0TLATBtJ9CSZmUhquK9r8aa8yCWjIv9JlISKQlzGiUAJTt79kxNOsHJOi4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dVHpyrlh; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADLKfc8022431
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 21:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=kl/3cbsL7WMPMpsUhekZ22w1R9xNjHFg9TwxCPIGgww=; b=dVHpyrlh
	RKnK1oZRmthaptiaLh+1+qxvRnCm2kycBiRmw7Jt5kmtC9cKgt4ypkyfi2gq8R35
	aFBh4wsWDaGsyjT+n5eNRE7Rkz14HxM3V4W90I3z6SwzMd5z7+tWtWwOe9ry/5/v
	UoRRt3ZWzTVd4pAq8zhbIFbmU8+a7PTDM+heY29AtBjbWOMk6cPbqFijZVMHDXLI
	M+qmhsne91UvZGCiKR7pChbvps/leK7RLfQTk2VU5QUgmtH8jJwn79g3cfH8XV1i
	G0Da0tLYF6q5uFWsPge9tD9cZNW7OiodpRPRYE5g1SnlhB7BwXvrlRVjjG+SQI5A
	x6Uc8nEgInhUJg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5tk7kst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 21:47:20 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ADLlJI4014654
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 21:47:20 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5tk7ksj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 21:47:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpqkzEMFGpGOmhJ6IZGGrcjPH0uVc4KcuaY10bgoMTBJY298HaYOfLOPZcna+CmEEMr8AIPhleBUB1RrGlOKeO3FUb99+EsGnBm7Va+V0vBQeldZZocJVhE77Ztl4k2qETopStbkti9VNYGu/pQd++JdhD8rfC7WxDvjX/qohiC3uDWiYNsMN+7YV9kBy4Dlf0dljoJp3it3pkgOiwHcFY9XujZixQ2ZGXGkJV2ZFz0NT4rkXJ1Hklwa6KQ8q/LI9hiqi+olZ5j06TX7kE/EBmsPE6Y40SLjl/CnBQ1zGSVWTITcy0fAunu31Ep5Vs+Tt8F9k2v5fesrFV2Ix4z99Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iwJKVA5ZPlG7/H0m2LR5znrlhiEgOfv4lkZePX7ssg=;
 b=I0wTBhtSQEZCNlx8MU6yo+6+td/sfFdlzlIgf9QVjLE/z9fBAPvLKltJvxIMQbABJy2P5UUp226YNA06qI9cHaGKNpXgsWpD7eoew7IKEqSMoIcry7ifq3epe/2tjcukeawkvIWo9gWPbegahZOIxqavJQvziQn9uNY2POYgUvlUQdt8BW8nw8zTzyTVXIh87w1n456CcWwUyFG8gf8aWHYmO+w+UctfDgdehUTm0qMMGYPCalUBUOHBWKT0IFgpOFKJg1PTaVYBhCru0ivGd4LZcAWMVwewoUpyKU3tMAOHq/+MktyWbvTJjxFuH1iM+PoxwCVDlWkzA4xFUviUVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH7PR15MB6130.namprd15.prod.outlook.com (2603:10b6:510:249::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 21:47:14 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 21:47:14 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com"
	<syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] [syzbot] [hfs?] memory leak in hfs_init_fs_context
Thread-Index: AQHcVFX8MQeuorGMJkWO0JzBm90QjrTxJXkA
Date: Thu, 13 Nov 2025 21:47:14 +0000
Message-ID: <f8b383fda0c5202bdd68418afccfe258a962e244.camel@ibm.com>
References: <69155e34.050a0220.3565dc.0019.GAE@google.com>
In-Reply-To: <69155e34.050a0220.3565dc.0019.GAE@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH7PR15MB6130:EE_
x-ms-office365-filtering-correlation-id: de01bd18-7179-4a62-be6d-08de22fe3565
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?N3krT3oreEI5K1hUZ3UwczJEL2pOdVlxT1RrTFpnVUtnTFJla1FzQmM1bjFG?=
 =?utf-8?B?bDd2L0RQSGVNWHAzN2RkWFBsTHJtQk9MN3JlaTVzcWV0VWFyOXRCMkUvNWo1?=
 =?utf-8?B?UUlPTS9DTHVKN0d4bjRGc2J6RDNacE5Qa3U4RVlrYmRPaEsvQnJOVmJ3Vk1L?=
 =?utf-8?B?MVFKZVF1V2Rnbk41aExmSFV3VFAwY0Nvajc5N0cwM1BwU2VBVUxDSFBxVnhD?=
 =?utf-8?B?ZGJLRTViNThlK3RpbWE5TDM5ZW5iSHJ1UWRuZDM3Y2VQdThyM0tTYWFLSUls?=
 =?utf-8?B?cFlTYU0wYmFCTlFiMVd3RGI5Zmw3eE5zRWdQSUEyV01sWDNpWW9tK1FkdU1o?=
 =?utf-8?B?OExmaEF6bC9VWWpIajRFcHpObU9vYjV3cFgrV1pQamNwUHl5V1pOK2xlOGFa?=
 =?utf-8?B?TWNkc0lxajdxZU5OeVBNUm9iYk9peWttK3lZdDdZWi9RQVFjdXR3cFVYRlNI?=
 =?utf-8?B?WmVSU1BiU1lTc25heGJDTDE2K1pMUEtHczN2YU5rUDFTNW5LdDVXUXJSODFR?=
 =?utf-8?B?VDBlWmxLZEZ0ZTNnamFuYk9scnpKTm9vMGd4MWN4UUNrdzBVOE51cHZJOFpL?=
 =?utf-8?B?UWF0VWVKYmxwMzJKSFpjOFJVdy9SeDg2bmR2ejZ0MVRTZjBrQ0ZhbmhSUGJl?=
 =?utf-8?B?ZXkvei96eUloSnQzZUl5TlFFU0pZOU1SaGJEV1kzdlZmUW9BZi80clptZ01k?=
 =?utf-8?B?NzVmR2RrclM4OU5uRWdvVUU4VHJzNC9ReFFDV043OVJTSmZlelFYcnVMNUxS?=
 =?utf-8?B?bm4vRlpYUHJhalk5UzVNc3g4U0NzRUlKL29rMDl6L045VmJpaE1ObFFrUmZM?=
 =?utf-8?B?anJwMlV2d3Q5dUcyNHh1ZENrdWpJM05uMHZKVnBRWWIxa2dwVEVMbGM3Uzc3?=
 =?utf-8?B?UThzRGZPemI3K0VGYStnK25waGR0UFVuU1RGcTlEdTQyV3Z2akVqelgxQk51?=
 =?utf-8?B?TTBrMjFHL1pxd1JvNGFWc0xMR3FMNEJBdDBaZUlRUUlGeGptdHhHWVJUQ21J?=
 =?utf-8?B?NG5PNjIxU1ZKbk92ZzIyb21PZE42dnliVVV6aU1STk96TERuSE11SzBYQ2gw?=
 =?utf-8?B?WGJ3MDFNcmJmZE9EejdIRHZvUXNzOCtSNjk3Z3lBU3EzcisxSDRxd3lSYWpG?=
 =?utf-8?B?ZU9PNDlsRTV3M2ZKeWNlMGx2b0ZXbDMwQmNkbmpRL2FDTEhwVkkrdHphSTRx?=
 =?utf-8?B?elR3azRuNkEzYlh1SDBhOVA3UVFMR0FwNlROVlBsbWVmbzh2NlY5UUNqVEEr?=
 =?utf-8?B?bHpZckVLTjlsMXFZNUlOWSthaWxnQVg1TlFzaDI1eWptcytTbnlsYXhCZHRh?=
 =?utf-8?B?Uy9LcFlsZGp1SHU4ZUJLNHozaVVjNlBSUVEveTFUdzA0UlRrQzdWRzI4NWVJ?=
 =?utf-8?B?ZDc4SE1VbG05ODRYeUNPTEVTZVh2RXFZaHdpa0N1amZsclFQTmIxM3RZQmJj?=
 =?utf-8?B?bjNBb3duOUpLcFBsMU81dThxWXhEdkNMWFJlM0Y1Rms3ZW1ocWFmQXAvRktS?=
 =?utf-8?B?VmdST2swUFhMY2xQOXhaTUQ0WDZrYnNPc1BOMUVGZmJVdzhnWjFwNkJNTkQ0?=
 =?utf-8?B?blU4OE5lSDhPNVBtNmpvVmNUK0NTNmpaTGFaeW9lUTZJZGQwNlRVSzVTNm0x?=
 =?utf-8?B?Zm1GSWpNbWF3Uk5zbnFnUFZjTVpjMHZBNFU1bGZkaWlLaEo2aW1rSGZvN01D?=
 =?utf-8?B?ZnNQNWJ2YUMyb1dSODE3OEt5UGZ5OXhiV25LRWFXTjkrSDgybW05aDZ4c0Nx?=
 =?utf-8?B?Zm1KSlhEdDVDNWNDeUZLZUxvWnVxNHB6c2k4Q2FNc2QreDhWQnU3WnNLalFF?=
 =?utf-8?B?WDdkZHFNVld3OVBXMG9LMzZHQnhucnJJODRXWFJoZlNEVVdxS21HeGtrVitC?=
 =?utf-8?B?Slh1MTJNbnpudzFwQ3RhV0F3M2FIUG8zUDJEeGZnZEFHZ0dpT3Q1QnN3T0tU?=
 =?utf-8?B?VzA0MVlLZnZzMVdXT28wUklKYjhpVytNRjNZN0ViaElmMUFkbDlSOWU4M2hN?=
 =?utf-8?B?TVUzc1lMTm5BPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QXBqeEV3dEgzbkhnMXFFMmVxTkFwaHRjMjBtY0pKNlZoNkNQMzZSdVh6Q0sw?=
 =?utf-8?B?N3VpdVFFeE00dTliMU9wQjF1VnRYY05jSDg0bHBPV3BpeFJMYWMxMXc5aXhH?=
 =?utf-8?B?cXQrRHlzWE1oU0xKSk4xY3JvVlNacWFmY3p4dVZac2h1SVR3VktJd2RMRHla?=
 =?utf-8?B?djVNanhmd2dTMGpQeFZHTWlJTEhCQ2lJNDBES1NyWU9ML0d6bTVQZEJ5V0FQ?=
 =?utf-8?B?eHJoV09UTmZKSjgrQjAxSUNPWnFqZlUvNzFyei92dkVsRVFVT09ZMk5nR3I1?=
 =?utf-8?B?VWFVRkRtUkU5Nkg0MW03OWQ0RDNvbVdDY1ZST1BRbnBEa3ZsR08wVU11YUJR?=
 =?utf-8?B?UndJbHF6ZERLTU0vZGxkSGtEa2xSN21wTXNXWEt3SlBvKzc0R2JoZGJtckhI?=
 =?utf-8?B?dUF0dFJtYTZvMGJPT2h6WXlPU1BocTFkeEJuUHlZWm15dmFqdXEwb2l3SllX?=
 =?utf-8?B?dkN4SG9qcGxJbUEwbnJ3Zm92VHdBQUVORG1laG9sbTJFNnlzY2pnWEoxUHpK?=
 =?utf-8?B?SzBTUDRtMG0zNm5kNTJ3Mm5BckNUOFJRZmZVV2JvRjRyN2owSnY1M0k1Smw5?=
 =?utf-8?B?blNybkZVZ3FDY2twcEVJNHhBMUoxOFMxN1MrZlZxZkJnY0FrR2svcERnMTMw?=
 =?utf-8?B?U1Q1a2YwVlNQOTJvcldXY0o4czJ6b2FYY1cxaHlTZkVhbDVHMWpXY1VHd2h1?=
 =?utf-8?B?UGZDYnV2d2VIOXhldytRM1ZXUUh5c0xMN3loVU1uK01kQzd2cnFTRiticTVL?=
 =?utf-8?B?YitaT2Q1OWlsM3NxRTlCd01hMlB4UWNUU1dOSmg5NlJJRFJjQkE4VHVTYXVL?=
 =?utf-8?B?MVlwSyt3TXFVbjFyclh5MUpURXd1NnM3Wng4UkRIazRxTC9YY0l1bjRNTmZT?=
 =?utf-8?B?NklMN1RIK0JQdlhHWXBCbmU2Yk1XREhnS2hPNUpucXN4cURyOE5HNThVQld3?=
 =?utf-8?B?MThyUnlXWTBmQlpBNWNYODB0dm15ZE8wZzFWOXVuTUxUSEdKZ1JHMERtWTFI?=
 =?utf-8?B?dnRJRDVrZE5CeWxHSDZTQmFNWlhnT053bmh4d3g1VTdpOStraW1uenVveDVO?=
 =?utf-8?B?bUkwaExCeVY0RnVjNVcyVjlydy9jTVZleWx3UEppSkxLQTJpNlBpNkVkamIy?=
 =?utf-8?B?MlMvbkFSeHJoMDA0azNsQlZEVnUvZ09Vc1ZWbUJMenQzc3J6WEZqOUFBbW1D?=
 =?utf-8?B?Y29ZbldoajFwSHNob0ZqenMxZzYvQTdBT2JvZXJERUdQaGhJQVZXUlpuUHZs?=
 =?utf-8?B?UERMT0FFTXhyTHdaWjlCTFJ2bDR4YmhZNi9WeXlYU0xsbEkraWdLUURiQU9a?=
 =?utf-8?B?RXpSTmlYcGVpQWIvZ212RWFNRE5QVHNlRHRjUDNqQTFNZGZFQnhHUlJJdDRI?=
 =?utf-8?B?akZvWmlraXRXMC9pNUpkd0FybjhZM0tyR0NQZktiY1FodnRCcnhlWlNaTit3?=
 =?utf-8?B?dE9MZ1hmRFNpdUdXSGhIM24rSTNYSXJTSWF4VWtZZnR2NmN5VjJDTzhwcmtY?=
 =?utf-8?B?ZTNyRnRUdmNVeDhuZjkyNjZ2RUtURkNlN2plT3VkUzE3WjhKNnV3V0szMytE?=
 =?utf-8?B?Sk42L1Fvei9sU29DWW9BdG1hZjZ0V3RGRkZ0SWtKalRuNml3WUNSS1pFbWNC?=
 =?utf-8?B?SzIzTkx5OTdUVThlK3o5QzZWY21qNDE5ZUU5ajBOZ3FOOGlUQ0VBdzdLMlhQ?=
 =?utf-8?B?MVdBd0thT0FtOVNoeXd6Vlc1SmpEVEZEcnFta3lFTy9mNUdrdE9Zd09zSytC?=
 =?utf-8?B?b3NCZWdIU0FONzZCSU1mWUt4Uyt5ZUZ3SEx2bGhjdVlJT1V4dUl2RnpPNjk5?=
 =?utf-8?B?TkVidGJmYlhWMm5nNCtCR1FmSjZ5THpGa0dmTy9ZSXE0d1QvK3VjZndHMVU3?=
 =?utf-8?B?RTdZVlZpUW42cWE4SEJlaC90NGN4c0NGWmNBYmcvZGpDemtIOU8yUjhSN0dY?=
 =?utf-8?B?cjUxNjJ2d0xKcHRxd0xwblExQVY3bmM5dVczV1ZKZlhKN0dBVlJuOXJpb1A5?=
 =?utf-8?B?NXFGRDFQZkI5bWJ1aXRpTlFXZ1h1dnp0R25peVQyand1Zi9zOEpXbkxJaWJo?=
 =?utf-8?B?SkZYdVErWmM1QmU2SXBmQzduL2Yvb1NweXo4bE9WTWhVTkZ0NFZZWkh0MHY4?=
 =?utf-8?B?UWJmT2ZFc2tMYWlUTVlGK0VFOEhLMEFIZ3ZKbFR2YTJXZVBaTkJSQ0QxVG9M?=
 =?utf-8?Q?HjZnXo6lKIE41IQJ8lFq5mo=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de01bd18-7179-4a62-be6d-08de22fe3565
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 21:47:14.5495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cmm9RwdKPuLY5JPZV9xSu5INzx0Yyc6GsVbo2mhWG0duqQtF8IQ6PddzhTaHgyME83+VTEYSIrK9ZDSsZUeIAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB6130
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5OSBTYWx0ZWRfXxjc++aGjsRig
 hCCewzdUXrb+aeC7wJw71mbxvpPXy94Hs5sqKjeiBv9S6KWmognVqTlZQqyt3AT/GL9WwR+sOCp
 dCnHUmHy08dxa+vOtXXhJKnoC36dnnXyZQieuVOIjH4xhRn6zvb3C8g3oqq0pmao5Mx5DL695XI
 Bi12LUOHqPTrCSCe/1zbPH6Y9AJw19rfGy5ZYSudDWAj9tCPdWyYBdyp/IXyIKaakOtVj0vMxKV
 S5mXfyekRZAdXxYnVWzKk3w2bO1LYdEy8EAacHQG7ZBBqZwTUZBCU1o2XeQxoUybhN+kO5pGM98
 QkesZ2EnYFJmPBDYvDcZI22yLBwIK+HqxHqv8xMmylGO32DjyXe2buuk2TwJX6IAdP+96JUeCDo
 JQKMcYoJ6h9zbYmLUK0IvvZNGMjubQ==
X-Proofpoint-ORIG-GUID: -4jbGMJ-SVeagt-TAwm05G5zols-MO6x
X-Authority-Analysis: v=2.4 cv=V6xwEOni c=1 sm=1 tr=0 ts=691651e7 cx=c_pps
 a=AaLFskbMOPjKyn39sRDTkA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=edf1wS77AAAA:8
 a=3g80flMcAAAA:8 a=oHvirCaBAAAA:8 a=VwQbUJbxAAAA:8 a=hSkVLCK3AAAA:8
 a=4RBUngkUAAAA:8 a=VnNF1IyMAAAA:8 a=SPCOJo0Lk5a_fAbZ0FcA:9
 a=BhMdqm2Wqc4Q2JL7t0yJfBCtM/Y=:19 a=QEXdDO2ut3YA:10 a=slFVYn995OdndYK6izCD:22
 a=DcSpbTIhAlouE1Uv7lRv:22 a=3urWGuTZa-U-TZ_dHwj2:22 a=cQPPKAXgyycSBL8etih5:22
 a=_sbA2Q-Kp09kWB8D3iXc:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=HhbK4dLum7pmb74im6QT:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=p-dnK0njbqwfn1k4-x12:22 a=jjky5lfK57Ii_Ajn6BuG:22
X-Proofpoint-GUID: -4jbGMJ-SVeagt-TAwm05G5zols-MO6x
Content-Type: text/plain; charset="utf-8"
Content-ID: <273245223423364F8EDB943464B2CD61@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [syzbot] [hfs?] memory leak in hfs_init_fs_context
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_05,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2510240000 definitions=main-2511080099

Issue has been created:
https://github.com/hfs-linux-kernel/hfs-linux-kernel/issues/239

Thanks,
Slava.

On Wed, 2025-11-12 at 20:27 -0800, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    4ea7c1717f3f Merge tag 'for-linus' of git://git.kernel.or=
g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17346c1258000=
0 =20
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dcb128cd5cb439=
809 =20
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dad45f827c88778f=
f7df6 =20
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binuti=
ls for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D143f5c12580=
000 =20
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D17c9a7cd98000=
0 =20
>=20
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1f8cf51c9042/dis=
k-4ea7c171.raw.xz =20
> vmlinux: https://storage.googleapis.com/syzbot-assets/6f227246b5b7/vmlinu=
x-4ea7c171.xz =20
> kernel image: https://storage.googleapis.com/syzbot-assets/f935766a00b3/b=
zImage-4ea7c171.xz =20
> mounted in repro: https://storage.googleapis.com/syzbot-assets/bee9311f40=
26/mount_4.gz =20
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
>=20
> BUG: memory leak
> unreferenced object 0xffff888111778c00 (size 512):
>   comm "syz.0.17", pid 6092, jiffies 4294942644
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc eb1d7412):
>     kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
>     slab_post_alloc_hook mm/slub.c:4979 [inline]
>     slab_alloc_node mm/slub.c:5284 [inline]
>     __kmalloc_cache_noprof+0x3a6/0x5b0 mm/slub.c:5762
>     kmalloc_noprof include/linux/slab.h:957 [inline]
>     kzalloc_noprof include/linux/slab.h:1094 [inline]
>     hfs_init_fs_context+0x24/0xd0 fs/hfs/super.c:411
>     alloc_fs_context+0x214/0x430 fs/fs_context.c:315
>     do_new_mount fs/namespace.c:3707 [inline]
>     path_mount+0x93c/0x12e0 fs/namespace.c:4037
>     do_mount fs/namespace.c:4050 [inline]
>     __do_sys_mount fs/namespace.c:4238 [inline]
>     __se_sys_mount fs/namespace.c:4215 [inline]
>     __x64_sys_mount+0x1a2/0x1e0 fs/namespace.c:4215
>     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>     do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> BUG: memory leak
> unreferenced object 0xffff88810a2e8800 (size 512):
>   comm "syz.0.18", pid 6098, jiffies 4294942646
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc eb1d7412):
>     kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
>     slab_post_alloc_hook mm/slub.c:4979 [inline]
>     slab_alloc_node mm/slub.c:5284 [inline]
>     __kmalloc_cache_noprof+0x3a6/0x5b0 mm/slub.c:5762
>     kmalloc_noprof include/linux/slab.h:957 [inline]
>     kzalloc_noprof include/linux/slab.h:1094 [inline]
>     hfs_init_fs_context+0x24/0xd0 fs/hfs/super.c:411
>     alloc_fs_context+0x214/0x430 fs/fs_context.c:315
>     do_new_mount fs/namespace.c:3707 [inline]
>     path_mount+0x93c/0x12e0 fs/namespace.c:4037
>     do_mount fs/namespace.c:4050 [inline]
>     __do_sys_mount fs/namespace.c:4238 [inline]
>     __se_sys_mount fs/namespace.c:4215 [inline]
>     __x64_sys_mount+0x1a2/0x1e0 fs/namespace.c:4215
>     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>     do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> BUG: memory leak
> unreferenced object 0xffff88810a2e8e00 (size 512):
>   comm "syz.0.19", pid 6102, jiffies 4294942648
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc eb1d7412):
>     kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
>     slab_post_alloc_hook mm/slub.c:4979 [inline]
>     slab_alloc_node mm/slub.c:5284 [inline]
>     __kmalloc_cache_noprof+0x3a6/0x5b0 mm/slub.c:5762
>     kmalloc_noprof include/linux/slab.h:957 [inline]
>     kzalloc_noprof include/linux/slab.h:1094 [inline]
>     hfs_init_fs_context+0x24/0xd0 fs/hfs/super.c:411
>     alloc_fs_context+0x214/0x430 fs/fs_context.c:315
>     do_new_mount fs/namespace.c:3707 [inline]
>     path_mount+0x93c/0x12e0 fs/namespace.c:4037
>     do_mount fs/namespace.c:4050 [inline]
>     __do_sys_mount fs/namespace.c:4238 [inline]
>     __se_sys_mount fs/namespace.c:4215 [inline]
>     __x64_sys_mount+0x1a2/0x1e0 fs/namespace.c:4215
>     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>     do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> BUG: memory leak
> unreferenced object 0xffff8881263ed600 (size 512):
>   comm "syz.0.20", pid 6125, jiffies 4294943177
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc eb1d7412):
>     kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
>     slab_post_alloc_hook mm/slub.c:4979 [inline]
>     slab_alloc_node mm/slub.c:5284 [inline]
>     __kmalloc_cache_noprof+0x3a6/0x5b0 mm/slub.c:5762
>     kmalloc_noprof include/linux/slab.h:957 [inline]
>     kzalloc_noprof include/linux/slab.h:1094 [inline]
>     hfs_init_fs_context+0x24/0xd0 fs/hfs/super.c:411
>     alloc_fs_context+0x214/0x430 fs/fs_context.c:315
>     do_new_mount fs/namespace.c:3707 [inline]
>     path_mount+0x93c/0x12e0 fs/namespace.c:4037
>     do_mount fs/namespace.c:4050 [inline]
>     __do_sys_mount fs/namespace.c:4238 [inline]
>     __se_sys_mount fs/namespace.c:4215 [inline]
>     __x64_sys_mount+0x1a2/0x1e0 fs/namespace.c:4215
>     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>     do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> BUG: memory leak
> unreferenced object 0xffff88810db18c00 (size 512):
>   comm "syz.0.21", pid 6127, jiffies 4294943179
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc eb1d7412):
>     kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
>     slab_post_alloc_hook mm/slub.c:4979 [inline]
>     slab_alloc_node mm/slub.c:5284 [inline]
>     __kmalloc_cache_noprof+0x3a6/0x5b0 mm/slub.c:5762
>     kmalloc_noprof include/linux/slab.h:957 [inline]
>     kzalloc_noprof include/linux/slab.h:1094 [inline]
>     hfs_init_fs_context+0x24/0xd0 fs/hfs/super.c:411
>     alloc_fs_context+0x214/0x430 fs/fs_context.c:315
>     do_new_mount fs/namespace.c:3707 [inline]
>     path_mount+0x93c/0x12e0 fs/namespace.c:4037
>     do_mount fs/namespace.c:4050 [inline]
>     __do_sys_mount fs/namespace.c:4238 [inline]
>     __se_sys_mount fs/namespace.c:4215 [inline]
>     __x64_sys_mount+0x1a2/0x1e0 fs/namespace.c:4215
>     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>     do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ   for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status   for how to communicate with syzbot.
>=20
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>=20
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>=20
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>=20
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>=20
> If you want to undo deduplication, reply with:
> #syz undup

--=20
Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

