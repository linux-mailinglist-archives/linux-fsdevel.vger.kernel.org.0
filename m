Return-Path: <linux-fsdevel+bounces-49984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB7FAC6D90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 18:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9026C4E3582
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 16:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447C128C852;
	Wed, 28 May 2025 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eKj+Lh6x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB49211A3F
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 May 2025 16:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748448641; cv=fail; b=fIfg9w5snasjAVkU40yf00AVhlNw+JtIXID6Xv/UndOSYn2KQFsfYvokcjPu8YRGvqYI1DIwgOfdhgC7UlSMLDEhAJrZUQY+kt0wnSc7MrsLTZnbG/s4PuR9G+sEogQEdyKeUHpSKnqb0UHBxebgwpIiQ7mMAaKa1qOXulsQE88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748448641; c=relaxed/simple;
	bh=LnuNor7nlPdsAq66zpuhMRyh7JNF7jR9ircHpmr/Puc=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=g2+G3Cr8+HyIUMwYJDaOukPu5q7jBPsLhD3bB4OqF73I+1AO6VLJlnq+IGAk1PLUruBLxPATaFf9YbfLjPZvlWYP6DrzEJ1RD2KRniuuPSZtRng1xBTOwMfBXY61W4E2elHa6ZCK8KHlRQ6pU7553GKvBh7y2TsUjtHNCmt3m8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eKj+Lh6x; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SE9WWU031935;
	Wed, 28 May 2025 16:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=LnuNor7nlPdsAq66zpuhMRyh7JNF7jR9ircHpmr/Puc=; b=eKj+Lh6x
	Q4k6ao4ETdJYVejz+tl52NluxocY51fQOHwsMPfIs/f+3M3OhnisOv4OfRiTY39g
	XJGY0t0tTwye/+PVIK4THtZ8vObsDXrKSdc2EMN02FESaxXQzvg+r5vrxj0uSCX+
	G3rU52aD5hY8swMTHfCt3vgkut11tE2V+zffh3pT8afwNNqbNb2sGsNuagq41BCe
	idmGZrGJlMFdi5xB4DmbvwtSqECGdzYcy4ppBHmhC2yISVHc7Jxt4bRQkg9Kdgpj
	+HSFVzRzzy6gVojxn5pKsDXSy7gH0b3z3NMMPEzqF6KgEGzAmH10oMCjE16X1mH+
	Z53HbJKzzJMiNw==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40jrnw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 16:10:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LkXHWt43OW7YNGvu6/iVtNC5a17CNKp0IJ64ysN6y+etILlZIki7Awn78ew5ZvpxSf/eZMcZbI7HmCy5OBPQNIWDkJ8w7CjcqsIdDpZqhwZHbLeQRX9A+BDwlPZm4EYojBRgprIKKfkVh1x8N45XkWurHIROG6xylxox5PALMdbtseLMWGJY/DQiUd7EOEjZ8PIxQkwG4F2ZvYn4OXsyCliElPWCZd5JV/QFbl/cA1Z6CHLzzlvTQjL4QmqfAj3uiWd64cYgb2G30JKeLyIHZgnRgTdn8AyUgWR8grLJI3TNK9fgeX/aTEhqxk/frSBGdtt0s0si/p1Vx8efAefS9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnuNor7nlPdsAq66zpuhMRyh7JNF7jR9ircHpmr/Puc=;
 b=GPCaFtM9d239FWmw4bVD1pT6GUCm0J73u+/+7g7XF+sQiSodmsWu/NuCUlqm7Tv5ThX2yQfmrasGbWndJZ+qRvBdRFxQB381MeEfqaAdO6RAgdavZzGZVO+1XWbSl5m93kW6RIKdmsJmo2eYcZq6FCGmqYviQ7A4ACQzpyHlc4VxO9NvZ3L5AnzoiZhlujPrFp6mQkbkegpPc8p1IpVWVBmtLYpJ+y2h3ebVHrtH8xwo6N8nYVZ27N3b61mZog1VhYFcIf4+2w1xXxbgyCikm5KaSVO09xB3U+2afIAuqCSOMf0LAdtuqJJoRl10S/sRQwvEr6aVsT0fTRMC5srVzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ4PPF73ABFE753.namprd15.prod.outlook.com (2603:10b6:a0f:fc02::8a9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Wed, 28 May
 2025 16:10:31 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%6]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 16:10:31 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>
Thread-Topic: [EXTERNAL] Re: [RFC] Should we consider to re-write HFS/HFS+ in
 Rust?
Thread-Index: AQHbz2CpCY7FD08WfUuZLsiXLlP+iLPnoLQAgACWmwA=
Date: Wed, 28 May 2025 16:10:31 +0000
Message-ID: <21e4a56ea809eb59926e38bc2714414768433207.camel@ibm.com>
References: <d5ea8adb198eb6b6d2f6accaf044b543631f7a72.camel@ibm.com>
	 <885465574facaf3fb0481fc0364822b8230b13b0.camel@physik.fu-berlin.de>
In-Reply-To:
 <885465574facaf3fb0481fc0364822b8230b13b0.camel@physik.fu-berlin.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ4PPF73ABFE753:EE_
x-ms-office365-filtering-correlation-id: 32127fa8-93e4-4f52-d78b-08dd9e022b90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RmJhMmVmSFZaOGdmMkpCQWxJckliSS81WXFRRFpNcmpxR2JxOUIzZDg1blR6?=
 =?utf-8?B?MlRBaGVHcFI1Qk1XcmtNb2pNeXN0V3VWZHlWM1BCdG9CV1IyQVdEYkZSUloy?=
 =?utf-8?B?RGxuQWkxUW9iaW1RZzJFU241bzJ1ZzJGaXRreFVIVVFXMUp4VWpOUCtJNGVH?=
 =?utf-8?B?a3VJWjhXTFVLaVRLN0Iyd0xOdDNIVklJdm5kK1pvZ1FOUnpRNFBMNWtMSFRZ?=
 =?utf-8?B?bitKZEU0c1FpTVluRTZvTzVRQkg5TmYyLzIzbU9vbXNObEVrQ2dLVVF2OGxq?=
 =?utf-8?B?YmZhbzB5WHRkNVpzYndJeW1OeEV0U2Q0Qld6T0RNWlBoRXh6aW5JcmtteUxN?=
 =?utf-8?B?OVBRaUIzb2hxWXc0V2l4Q20rNW1aeDdWQkR6WmJFa0xXOURucVdwMzNTWU5S?=
 =?utf-8?B?NXNoSlhhZVR0ci8vUk1ZM0hXYjlGaVVTSE80VEFsdzk2TFd3aHFCK2V6OUw1?=
 =?utf-8?B?Sm8rcVQ1Z3ZsaCttbm1mYnd4Nkt3RFNQM1N6WEc5anN6M3ZRNzZZMFBOWG56?=
 =?utf-8?B?RndzLzdpNUtrVXBPZXcydXhSdUVlMFN3azQ1M1dWaDExRkhIdjNNdytkaUZi?=
 =?utf-8?B?RjU5empScnR1M2lDU2UzdFl0TXhUOEVBNE80Y2RWc2QvQVY4MXZsWlNGQS83?=
 =?utf-8?B?RnBJdUtvWjA4WmFHUFl3aHV1ZEJ3enY0NWtWUzhTaXo5UEZpOUtvL3hobWhx?=
 =?utf-8?B?UGx2eVBUcmxROUpNVTNwT092a1JHbkxOdHlRRWZNcm8xZnJjZEsxTmhnSXpX?=
 =?utf-8?B?V2hZajlsa25vdUV3eWJqdDA1dllhcmtLRU5lSEcyby9yMnRuUmZmajY1bFJs?=
 =?utf-8?B?a2ZjaTdzNWxqL2U2WFVDdmNyVisvaVFMMTF3Z2h6eEJyRTFNVk9kRXpaWUEv?=
 =?utf-8?B?ZkpCZjJlbXdIcStrd2s0YzI5WVNOUng3MVhBZGZZejJuRERoWFJsc2oyMDhE?=
 =?utf-8?B?L1hVTjZsUnMzNTVKdE5KR0JIUW9IU045bkZiaUdEZEdXcEVoYWtZUGlKNnN1?=
 =?utf-8?B?RnRxTmdJbTV5UW14VExjY29UN3JCOXZWT0RrbTJtOUMybnJSR3JqVEpUWEdV?=
 =?utf-8?B?RXRmMVpjZWhoUGhyQy9qT2c3ZFZ1cHphS1RGdDlISWJDU1NEdmlsc3FDdjNH?=
 =?utf-8?B?a1lHeU5tcnJoQkIzbDh3R1JVVE14QkRNenZNcWxDejhkaXVqT05ucmZ1d0lO?=
 =?utf-8?B?eVlldXNkdVNra3gvVGNHT09mTi94TkZOMHdCQnE4L3luUTNIanlTNEE0ZzNZ?=
 =?utf-8?B?YURoeTlyYktULy93NjIzN1lnUVVTM1JnR1oreDJkN0ZIVWp4bGdyRDBzYk5k?=
 =?utf-8?B?Vi8rd242STgyNkVQaE9qSUlySjNPSFhTeTZmdGNhcWtKNlZ3RllwcWl5bnlH?=
 =?utf-8?B?bGxwTkhpdkFzaUhJbzhqaTlCN0l4UlBsOFNKK1luTEthVWNXWUhLTE1MM2Vq?=
 =?utf-8?B?bE4rdTA2OEFkYXpBQUNBa2VjdmZrMEtGaDhhRlVCTktIMlliT0Y5REhGVVFl?=
 =?utf-8?B?STJlSGxSSUJNR211NEVKbE1ZNThrZmVEZTMwblVBWkQweWhlby9wQUo5NHRI?=
 =?utf-8?B?d3ZoYWI2VTdKNlNLY2dCT1QxM3JvU2szWG1XeFI3TWkxTWxaYm4zUXpPUlJo?=
 =?utf-8?B?SFRWSkQ2YXZUWndESUFhTS9qS3JFM1lUMmFJdnNGdEZ5TDdhbjZTOXpGbHYz?=
 =?utf-8?B?ajBLY0hadmsrSkF1WUxUSkJmeHdIR1Yva0RIL2ZnZnpqWGNyV1ZTaXdKelpW?=
 =?utf-8?B?b2dzZm9xemJDMkRHMENuK21YVTFnbXlMWDNhZFYvZCtqbTdkWk9KYnVKOXh1?=
 =?utf-8?B?Q2syRlpDK2k4VmNoZnhXTWhrRzN3Wjc4SmFCNytRak5tL2VXcGdYcXpqc0Ni?=
 =?utf-8?B?V1RnRDBleUQzMU9pQ1BKaUJEUDFNYXRTK2FPNTU3ZlRVUzBtL0U1WVMwNDFY?=
 =?utf-8?B?RVMrYTdUUjBZbUpjRXdJclN1VTdSOUloTWE1dXhrU3g0VXJhTW9kbkZpMS83?=
 =?utf-8?Q?lBHx0DW2i9NofsSNUUpEiOmFN9e+ZA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K0JvTUFmaHFFNlk5MG96SGdvRDJWMGhzKzBNNVdTRmFZdXV1eDAxTEZURVhk?=
 =?utf-8?B?REJaYW8wRW1YRjFHR0N1aUFLVTNJa1pnOGlmZ2JUUXYxaWM4SWRWSlE4OEVX?=
 =?utf-8?B?WVpGUkpiRk5rQ0FvZnQ4THhXR3FtTEhCcFJody9ZbFlxcHNnN2UwYWwyS2VI?=
 =?utf-8?B?WEd2MUF3ZzlyOExQckdZeU1HWEVDWHJmZ1B4M0hoNmN2U2NISy9Yc3VmQjY1?=
 =?utf-8?B?Zk5WWW5RS0QvVDNKUUpOcEliVGxtZmgrc2xvd3J1ajU2U0MzUnZBM1dRY0pO?=
 =?utf-8?B?Z25IOGNFZHNVWC8wNlhnS0dIYUFKOTAxUzdqSHNNRXJLNFRadFpqaEhTZDMw?=
 =?utf-8?B?SzdrNE5NS0J2YkFZcHlzSjF5YWpqdEFxR3FHdmFXVjhGUFdRdWFtZ1hhbUNq?=
 =?utf-8?B?WDVVWmkxODMyR1R5SVRzQ3hjVWkvN1U0YXFycnNBekpSMEtPeUlFOUd3VWFN?=
 =?utf-8?B?QWhrcWlCQVVZajVEZHNpYjJ4ZGx6ZEpTTHNUdWlKamdhTU1kOHhCdkhPSy9O?=
 =?utf-8?B?QkJTVGNxMEJmL29JZ3ZKSkRNdkY4UWhYSC9XTExmb0ViWUJPQmxGQVpJaXFQ?=
 =?utf-8?B?WFhPNmFjbWR0WlNoVytBTW1aN0FPb2pGc1hIUU44dytrU1FrTTJDc3ZyeXkx?=
 =?utf-8?B?bHcxNGhEcGZaTmRRZ2ZmbjNkbHAwUkNwZWhrcXp0WU4weExuWTVCYWU3UXVV?=
 =?utf-8?B?MWd3SGFxUURJb2psWXVNN0NiWVZqTDVPcHpaZ1VsY1lqOFJvZlBaYXRReStQ?=
 =?utf-8?B?V1dzSFdXZWYycm1ZNEJRdUJiRzdZcHdSWmM4cDVDUzBHOVh2TzJzb0UrbzE2?=
 =?utf-8?B?L1cwaURJbVZBcHQxNVNyY2FNd0s2STBFazQ1NnptQTJjN2hkeU1wcng4MCtV?=
 =?utf-8?B?MGZFdWpOLy8wd2V5WXE2N0swNVpqdzNvNk9ZNzFQTXdrREY0ZDR3ZlN1eDAy?=
 =?utf-8?B?SE5PcmovRXptOW5TSXk2YnF5QThEZkd2RGx3dkUyckVxU1p0RkkyMjZ6NndR?=
 =?utf-8?B?SzZGSXBFdUgvZkU1ZjlFaXk5SFRJNldhc1ZFNnNUMTBTWThDWjdSSjJ3dEVH?=
 =?utf-8?B?NjBlc0NVOWJqNjZKcCtFeGpaQkhJRi9kdXhYT2JQNHVia0RyTzUybGllQlNo?=
 =?utf-8?B?T3UyTGw2SkFMeHRjeEtDcGxoakkvQkRiejFmemN2VVIyUmRRRnErKzhwcVlC?=
 =?utf-8?B?S1RZemg5SHVFNFJTckVOSVpBZmhqdEV2eERKd2dsLzZXR2NlVzc0RzhyTWpz?=
 =?utf-8?B?QTVNN2wvWmtxZ3RlWS8rd0gzL09JZTRabVl6YnlXQ0N1RUtmREs1NGZiQ3ZN?=
 =?utf-8?B?SS9kUnNpZVRPZmdieEE0a1VGcGhaZll1NlFVd3BicEVHRFFKS3lPc2U5RURV?=
 =?utf-8?B?emlQTG5MS3lIeTRQK3FHMDRQM3VJSS9BQ2gzNkcvVnJxd01Gd1FjZ1hLUEJY?=
 =?utf-8?B?RHA1V0FUUDZXdFhZK1R4eDRhTmZ5YWFET3dVRXI3SWI5M1ZYbjg1cDI3QUR0?=
 =?utf-8?B?YkkyZzMwbEFSb1N1OEczamFmSlRScFBVNVJCY0VtalFxZ2lDQnJEMmxISkhy?=
 =?utf-8?B?Y3Z1Umk1cEZFUjZwRmNVTCtWdkcwS1FQbWRLSnVRYzVoZ3JwTzJmdy9Ua2dX?=
 =?utf-8?B?WHZYWXVKSTNwa3ZXYXQxQmFiOFpaZXVTdXVJVm92MzVYQU1EbEl3Q3NocGhS?=
 =?utf-8?B?dHYyM1R6bkNLMkhlWWVwV1BGWXhrVFRDdDc4RVgyelR0ZFFEK0VxelNnNnhF?=
 =?utf-8?B?ckdnbDJITTJwSnpEVGw4Z3ZYZGJCQ0lON095dCtScTk3dWp0UytoYkxUWXIv?=
 =?utf-8?B?WnBSTlpXNE9UQ2R1ZnRPcmlObHppclQ2bk01WW9TckVjNUZaQ2UyNjdBZ1dV?=
 =?utf-8?B?K1U4WkJ6YmRiR0lPNTY1OTNPNlNJYkNmTnBqTWd2NkszVExNWFp2VUZxSGE3?=
 =?utf-8?B?YzYvM1ZtS0k2Ni9NOTVzdjlSVmZMK2lQamNmSjBBVjZKY3BDTGljTXFid241?=
 =?utf-8?B?Z1ppVmJNWDBHeDV6ZjIvSHBtbXF2TkV2c3BnQ3RaZFJzcTd1d2hWWC9JT1Fs?=
 =?utf-8?B?ZXhZNzNmZzNQcmVnVUk0cU1qNTF2K3BrMllCS1Bhak9rbjlqRG9HZ3lxSjY1?=
 =?utf-8?B?MExpVXpJTGN4bFVtSzZoVFpDdHNrUG1CeXBlNjg1SmxDd0VQSG0yTUtCdFl2?=
 =?utf-8?Q?CTOMHfCM2fvqFK/KoEd6mqc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <790E10C7C7F73F439E59A07D20F64B59@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32127fa8-93e4-4f52-d78b-08dd9e022b90
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 16:10:31.4033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mjtu3NnRBuzzULxQ0LifyVBzIFIDGgbb2qmifmIJAE5VwISUNealMvM9o3rVEJUjVpPttDkpnNSM9eHznkBVtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPF73ABFE753
X-Authority-Analysis: v=2.4 cv=SdL3duRu c=1 sm=1 tr=0 ts=6837357a cx=c_pps a=Z4VC7wcqJr2B26KiF28H7A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=rIH98O22OktHME4k:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=skRRHGpWbuctFKM3xeYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: CJAlayKTPQYxDzfn_BPF2fG2cJ9-OXxP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDEzOSBTYWx0ZWRfXzNufaGPydK0p TCJDn8dNOZQCAJP2BiGOP3GoKLhEweSbxIce3TSv9xPrlnM+uDaxFGJIyG9oTLQNqXVDPnDwJ5b B88WB2WLzM0ddD8IUU5pSewYjCuqrvfGTFWtLG+BIdUNUIM/rr1FbHs1nOpNvohX6VN93GPsTqS
 aiwBNyUZXnimA+XgrLbVamibCWDlB1vq9+KRFvK6qaznoqDzxeVV71dgtcYdpKNPNy42vSvqPJx fGY8TMcRCWS+5vtP5qisxTeHh6kcYsDPDEsjXGjxK2x15wPZd1md65s5GxmNo9GNamP4eTeAxAk RSaUGNfyHKKrzRc7Zx1CP0NP3EODtkTB6qvnOzPpzr8oFR8W485JTmjUSXL6Nm27FzvJpgUWpQU
 +wFoV6bF7lMioSXgodP6YpoX4GGZ6WJ/l5hwQbc0I0SWLQAVUppW+pzqwvGJFxg/R9SAz+Z+
X-Proofpoint-ORIG-GUID: CJAlayKTPQYxDzfn_BPF2fG2cJ9-OXxP
Subject: RE: [RFC] Should we consider to re-write HFS/HFS+ in Rust?
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_08,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxlogscore=696 suspectscore=0 bulkscore=0
 spamscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280139

SGkgQWRyaWFuLA0KDQpPbiBXZWQsIDIwMjUtMDUtMjggYXQgMDk6MTEgKzAyMDAsIEpvaG4gUGF1
bCBBZHJpYW4gR2xhdWJpdHogd3JvdGU6DQo+IEhpIFNsYXZhLA0KPiANCj4gT24gVHVlLCAyMDI1
LTA1LTI3IGF0IDIzOjM5ICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3JvdGU6DQo+ID4gT25l
IGlkZWEgY3Jvc3NlZCBteSBtaW5kIHJlY2VudGx5LiBBbmQgdGhpcyBpcyBhYm91dCByZS13cml0
aW5nIEhGUy9IRlMrIGluDQo+ID4gUnVzdC4gSXQgY291bGQgYmUgaW50ZXJlc3RpbmcgZGlyZWN0
aW9uIGJ1dCBJIGFtIG5vdCBzdXJlIGhvdyByZWFzb25hYmxlIGl0DQo+ID4gY291bGQgYmUuIEZy
b20gb25lIHBvaW50IG9mIHZpZXcsIEhGUy9IRlMrIGFyZSBub3QgY3JpdGljYWwgc3Vic3lzdGVt
cyBhbmQgd2UNCj4gPiBjYW4gYWZmb3JkIHNvbWUgZXhwZXJpbWVudHMuIEZyb20gYW5vdGhlciBw
b2ludCBvZiB2aWV3LCB3ZSBoYXZlIGVub3VnaCBpc3N1ZXMNCj4gPiBpbiB0aGUgSEZTL0hGUysg
Y29kZSBhbmQsIG1heWJlLCByZS13b3JraW5nIEhGUy9IRlMrIGNhbiBtYWtlIHRoZSBjb2RlIG1v
cmUNCj4gPiBzdGFibGUuDQo+ID4gDQo+ID4gSSBkb24ndCB0aGluayB0aGF0IGl0J3MgYSBnb29k
IGlkZWEgdG8gaW1wbGVtZW50IHRoZSBjb21wbGV0ZSByZS13cml0aW5nIG9mIHRoZQ0KPiA+IHdo
b2xlIGRyaXZlciBhdCBvbmNlLiBIb3dldmVyLCB3ZSBuZWVkIGEgc29tZSB1bmlmaWNhdGlvbiBh
bmQgZ2VuZXJhbGl6YXRpb24gb2YNCj4gPiBIRlMvSEZTKyBjb2RlIHBhdHRlcm5zIGluIHRoZSBm
b3JtIG9mIHJlLXVzYWJsZSBjb2RlIGJ5IGJvdGggZHJpdmVycy4gVGhpcyByZS0NCj4gPiB1c2Fi
bGUgY29kZSBjYW4gYmUgcmVwcmVzZW50ZWQgYXMgYnkgQyBjb2RlIGFzIGJ5IFJ1c3QgY29kZS4g
QW5kIHdlIGNhbg0KPiA+IGludHJvZHVjZSB0aGlzIGdlbmVyYWxpemVkIGNvZGUgaW4gdGhlIGZv
cm0gb2YgQyBhbmQgUnVzdCBhdCB0aGUgc2FtZSB0aW1lLiBTbywNCj4gPiB3ZSBjYW4gcmUtd3Jp
dGUgSEZTL0hGUysgY29kZSBncmFkdWFsbHkgc3RlcCBieSBzdGVwLiBNeSBwb2ludCBoZXJlIHRo
YXQgd2UNCj4gPiBjb3VsZCBoYXZlIEMgY29kZSBhbmQgUnVzdCBjb2RlIGZvciBnZW5lcmFsaXpl
ZCBmdW5jdGlvbmFsaXR5IG9mIEhGUy9IRlMrIGFuZA0KPiA+IEtjb25maWcgd291bGQgZGVmaW5l
IHdoaWNoIGNvZGUgd2lsbCBiZSBjb21waWxlZCBhbmQgdXNlZCwgZmluYWxseS4NCj4gPiANCj4g
PiBIb3cgZG8geW91IGZlZWwgYWJvdXQgdGhpcz8gQW5kIGNhbiB3ZSBhZmZvcmQgc3VjaCBpbXBs
ZW1lbnRhdGlvbiBlZmZvcnRzPw0KPiANCj4gSSBhbSBnZW5lcmFsbHkgbm90IG9wcG9zZWQgdG8g
cnVzdGlmeWluZyBwYXJ0cyBvZiB0aGUgTGludXgga2VybmVsLiBIb3dldmVyLCBJDQo+IHdvdWxk
IHN0aWxsIHBvc3Rwb25lIHN1Y2ggZWZmb3J0cyBpbnRvIHRoZSBmdXR1cmUgdW50aWwgdGhlIFJ1
c3QgZnJvbnRlbmQgaW4NCj4gR0NDIGhhcyBiZWNvbWUgdXNhYmxlIG9uIGFsbCBhcmNoaXRlY3R1
cmVzIHN1cHBvcnRlZCBieSB0aGUga2VybmVsIHN1Y2ggdGhhdA0KPiBydXN0aWZ5aW5nIGEga2Vy
bmVsIG1vZHVsZSBkb2VzIG5vdCByZXN1bHQgaW4gaXQgYmVjb21pbmcgdW51c2FibGUgb24gYXJj
aGl0ZWN0dXJlcw0KPiB3aXRob3V0IGEgbmF0aXZlIHJ1c3RjIGNvbXBpbGVyLg0KPiANCg0KVGhp
cyBpcyB3aHkgSSBhbSBjb25zaWRlcmluZyBSdXN0IGltcGxlbWVudGF0aW9uIGFzIHBhcmFsbGVs
IHRvIEMNCmltcGxlbWVudGF0aW9uLiBUaGUgUnVzdCBhbmQgQyBpbXBsZW1lbnRhdGlvbnMgY2Fu
IGNvLWV4aXN0IGF0IHRoZSBzYW1lIHRpbWUgYW5kDQpwZW9wbGUgY2FuIGRlY2lkZSB3aGljaCBp
bXBsZW1lbnRhdGlvbiB0aGV5IHdvdWxkIGxpa2UgdG8gY29tcGlsZS4gQW5kIHdlIGNhbiBkbw0K
c3VjaCBpbXBsZW1lbnRhdGlvbiBncmFkdWFsbHkgYnkgaW50cm9kdWNpbmcgc21hbGwgcGllY2Vz
IG9mIGZ1bmN0aW9uYWxpdHkuDQpNYXliZSwgaXQgY2FuIGludm9sdmUgUnVzdCBwZW9wbGUgaW50
byBIRlMvSEZTKyBkZXZlbG9wbWVudCBwcm9jZXNzLg0KDQpUaGFua3MsDQpTbGF2YS4NCg0K

