Return-Path: <linux-fsdevel+bounces-50233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C12AC9397
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 18:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BFC04E8233
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 16:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985541AE877;
	Fri, 30 May 2025 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EsksKs4i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C90218CBE1;
	Fri, 30 May 2025 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748622633; cv=fail; b=f+nGdxJL6jbUHFshBqYw9a4Ths6/8ss0FeShpinPHguDfmpTdQHrMQlMHO4GixiY9EOGw5vh0R6QFvb3o1vXCNT6xjd9jjdfUZJG4XA1eqZqRNfq5totbm0sWzyz2HNPw4yM9KYyO1rfVCdQhFqoe8nHfcK9y7vp1Ls5hc/q9fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748622633; c=relaxed/simple;
	bh=ngD1pYWdqAq0vTuDJNT9TYQ9O47cX2K0xAzz3l0MZUE=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=HkUb4Gm80lO/Fm3tkcoaRoj1Ehg6c18MmBjfLbJNHORL4oG5CHW68mFOA4xqP5onl6RLUU8CVPYFlNXaiMmS9wtVfdcGG7mU3FXhZnOtiyzb2dVRurU23s+3qqTOVb9mhJHeSO9TucAFnnK/7vb0/tf8k2d4E1tpxS2LcFx5Mo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EsksKs4i; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54UEI4Ue013475;
	Fri, 30 May 2025 16:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=ngD1pYWdqAq0vTuDJNT9TYQ9O47cX2K0xAzz3l0MZUE=; b=EsksKs4i
	ATK6z1NYdlGsKWuqNEvfEwHXiZY1YHq+8rmG0LmMrM2LYE6UDZNMu8qKkGU05NtI
	n0uyRCqkTF+O6doQP+UC+F2rAL/DxTALKQiB1u34wX2xUXm09WRu0gcZLZGc+LsZ
	ea2P4xULFsMTtk+uXtIzfOEEK+xATazlrOePb9RMSc2wLPGW2M1812nrKc0Uayl7
	EvIbmlWatsNBR5e96M+XJH9IfAGMSLnUsj9Nyh/u+tIyKKrcymcfFR8DSeGItZvt
	wI7JjqniHzGncM2AcddiEiAfVVpq3ql48SCsHSoU5xWqZ6JBngY2Shb7F8EoNaaf
	J8Eycb91fauDfA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40kmqmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 May 2025 16:30:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmuKktTjFI7MdST2FgnmX1SkWXeiaIKJ947JLlgMC4BvfM3393hE90PuKpByYIaNY1AfYGRwOOB/GjPJehw8dEtNemruNAWI5B/O+k9ga455j70LJuwPoXdtwTp+vT/yYJDe2n4vUb1hvyOjLC8FMbyYaNWuLJ+25lv0e97T6xKl7MzW/Ht7b1z1dqgHftoEltlKRaKe4t+ZrTT1Q1rjLR3EprtGm1zWLvx77cfsKEz0Mb1K5P79kYqLO3metilfvSYiHuYOc3DkDKp6M7+KE56hT2eWEAZNqSbWSvXBrKYIvUFI2A/J/Ixf3s8PoM/n0b5uMpaoiQJ2Hf2UsKsS1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngD1pYWdqAq0vTuDJNT9TYQ9O47cX2K0xAzz3l0MZUE=;
 b=vz7khbJZvYiDZNaGc2IvSaq1TtKLzuPwt9Tds8GyF+eCCr9zhCCTZf/zPwsJ31jPIzY5F7IFbvyiYDUrHKZzz/pyMDJHKtpNXOGu8JM3PeIgIG2CMs7xH46ZtTrNqnlRc+kvzL6xY1FN2fyU2ODoUBCZBsoRhIE5KOTkD+v0wMgekwldZYy4ZxXrTIM3dfZWql4VFRLSiZue0cltlysemtb9cBdC5fjcGQ99bHXkmYU8g2m0uBrH9mRDqmwdRhGUNo1GvtKOIgQYtwgxvPhbG21Fb3MI1nAuLc8D1H9nBa3c1UCpIAf9wixF9iNdp+UExTljQ9rHlL9wkzESYpka6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW3PR15MB3947.namprd15.prod.outlook.com (2603:10b6:303:49::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Fri, 30 May
 2025 16:30:23 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%6]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 16:30:23 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v3 2/3] hfs: correct superblock flags
Thread-Index: AQHb0Th1fJJN+z+eyUCdGDdveVbBPrPrXdYA
Date: Fri, 30 May 2025 16:30:23 +0000
Message-ID: <8b56cf49cfed7a9edb6d16dd287be90817a140da.camel@ibm.com>
References: <20250530081719.2430291-1-frank.li@vivo.com>
	 <20250530081719.2430291-2-frank.li@vivo.com>
In-Reply-To: <20250530081719.2430291-2-frank.li@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW3PR15MB3947:EE_
x-ms-office365-filtering-correlation-id: 001f4e12-d9e2-433d-2703-08dd9f9746dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eVZPc28xUEdsakJOYUJWZkFWa3liNTNRL1ozQ2xlQVJGdjVCaklpVG12OVRD?=
 =?utf-8?B?RFhza3hlVTU1UjdmanZvbXhoTnpWS25ZOUJSbTdUY3BzWUMraHpaRC9GWEtJ?=
 =?utf-8?B?OXBJRWIzOEdYVjdzbCtxU1pZTnArS3BtWFRqOGJISW8va2xGWUgzY2VqUWk4?=
 =?utf-8?B?UTQzTEtwRVJBSE5mcmU2K2JCbzBqUS9GLzlackU4SzlpaHJDR1hXVFhBdFJF?=
 =?utf-8?B?ZEVnbkJtdVowZW51NGZjSlJmNTNtNjdEaUhROFBudzJRamZqaVRhU1RMR2RH?=
 =?utf-8?B?OGQwUjRZcTFUTnplUEtURUxHZENzcUIyUngwS1VoaDhFTnlUY3JmQWJXMTBn?=
 =?utf-8?B?VmZzclhsMjBUT3Y4UWUrOWxnQ1RqeGZOTTlDeFlZRXB2YThqaVo4ak1nTWhH?=
 =?utf-8?B?QStXcHdTODZnMGlVYWdTVXRoTTlLSFpoUitQWWxoaFoxOC8zR3owWEZBM0Rn?=
 =?utf-8?B?RWppdVpDb1JSVEs2Q0tMTkhLb3l5MnpTY0NHdmxGbjI3M1BrSEZsT0tmYUI0?=
 =?utf-8?B?aHkrbmIzTSs3emlRZ0hYaVhUUWxrVFJNVUNBNlcxQ3p0UVcxRDJka3FrdjBD?=
 =?utf-8?B?ODVDRVdGNkRtMktUbExkUStkZitHQUUvVHUwZDl3V00rek9FOXF6eGl6K2Vr?=
 =?utf-8?B?Tk1LS245VjY3VWs2bUR5aGxyRHNoQXRvbXY1R0JhR0NwNExDSWRhTVk1Njd2?=
 =?utf-8?B?RFJIQ2tEWVVTSnJJa2VqOWI3aWxUWXJuTzVLbnJGM2dCbkVTb3EvTEdldXIx?=
 =?utf-8?B?eWRSZEZwemFjVnZ6Nzd0dW5SbFVFd0VvdFhXVzVhaWdOMno2VlVLbGZzYm04?=
 =?utf-8?B?MmE1bk1abG0xNDk4M3R4QlFsa2k0YU9yOS9RVzAyMmh4L25FdE5HM3Zha3NR?=
 =?utf-8?B?NUNSRURHV3RnaE1vRlVIQmxIS2dLVWFyMDNOQnpQcTc2UkJ5aHVhMVJtOVY0?=
 =?utf-8?B?S1paaHpEaVlzdmxqZFNRUGhYbTlWa1ZKR29pV0ovMkZsUkUxMi9xYzFvd2Yy?=
 =?utf-8?B?dzRaZDl0NjB3a29CaTlsRXBTQXBRcVpONWEyaFhUT3ozMnEvUTlDVm1NRmQ4?=
 =?utf-8?B?dXAxWFBZbitsM1FqYXBVT2k0bjd3RG9ZSmlCbGNRYnk0THRPUUUzYjA2K2ky?=
 =?utf-8?B?cVpCZ05INC9VWC93cjhHSVJ6SEdEU0w5KzFJeW0wZkw5T1ViVWpsdzhUZ0tG?=
 =?utf-8?B?UEtrUU14STBpNnZTWXFkUjRsS3ZqenZQNmIrUi9waDR4Yy9KUlBSRE5NMk9k?=
 =?utf-8?B?Y0dIaEtRSGpLeFFpNkMxTzlFZXpXb2YrK3pzcnhDVE5QOFYxcmczRkIrY2Vu?=
 =?utf-8?B?aWEzMEJuV3k5Wk1sQTA5Tjk1SUtIcTRTcWE3V3pmY2JSR000L2w2M0VqK1VW?=
 =?utf-8?B?MUlmMGRtUnF4VlZTM2paclZ4S0ppTFVuMU5QN3QremxsYnI3cDI2SFcvNFkr?=
 =?utf-8?B?OWRUNlM3aklsVjNRK1VoTE5US3RrcXlKOW45eGszaEhWT3k3RjB6N08yUGlz?=
 =?utf-8?B?em9PVzV3SFN0UW1jdng2ckFzNTRkMG1aK0E3cXNWdzlDRXhxdnFibzhPSVFz?=
 =?utf-8?B?N1ZsdnlaMzVVbmJwUFNHbm5iVFdyRVhBK0xMWWdHVitxSVpvNkJBVUhUcDdr?=
 =?utf-8?B?VFVvUlQ5MzJQTy9xbGtkMkxkSnpUeUJYZk1XQ21TOTZuNkxnWG5kN2dGR2lP?=
 =?utf-8?B?Sm5iZ2RLV25mY1pTeVhJN2xlVGN5ZE9XczN5Ny8vcnpVaklBak1kclZnQjVP?=
 =?utf-8?B?NW9yM2wzR0xVamNxeVRrdVVhTWtDdS9hZE1xMEZqL3ZNeGVsMmNGMXJMakZO?=
 =?utf-8?B?U2REV0t2c0FhRDYzSXBuaFJrWU4yc0wxSmh2ZVhZYWVvSUQzWnljL0tTck9K?=
 =?utf-8?B?ODhjSkVXa3Jla24zckdTTWZuNkhESlZmd1JzdFJwUTN6S0FrSHVxdWROL3hI?=
 =?utf-8?B?SWtkWEJYVU9WN3NxVTFpd0RXeGVzMUJJTE9mYU5QQ2FoTEFWRXRVcS8rcFNM?=
 =?utf-8?Q?caX3fO+RTHk4q8Dtn5G858HVLaUvf0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ekhtWWtuWHo3dUNqaE1mUzFUYUhuNWlHTWRCakR5VGpKWEcxcndMbVhQRURz?=
 =?utf-8?B?bldnRFVxWm8vTmt5Vmd1WlFUQmovblBmSzZFQXlXUXIyVmVtcmJQSTFPalF2?=
 =?utf-8?B?UUoxaFVVU0p6OFUxNkZva1F1SCtIeVBmTkdZM0taZ3pMR1VWblg0RjJMTUVj?=
 =?utf-8?B?TTR0Uzd1U2wxUUhtdW1BY0ZsUlRwaGJYclBxdy9HK0RQYlVoMjdCbjJJUXJO?=
 =?utf-8?B?THRaTERkKzlwdHhpMU1OeUFVL3ljWXpiQ1FqeUY4RUcxbERsNUl6c01nMThZ?=
 =?utf-8?B?Rm9DZWxGb25SMGo4Zy9GMFErNGtrcDIvVEplL21OdHZjQmVHdEJHbXU0elhL?=
 =?utf-8?B?UWcrQW95Q0NNaVdYRlJ0bHFhZVM5YTBQYWQwWllKeTVlbHhSQXA4TzFEaFVh?=
 =?utf-8?B?V2xoR3lENkxBUlRrUWZoVWw2UkVRK2hpTk44a0FlNDNxVTVZT2NZMkJnVTJl?=
 =?utf-8?B?MndCdGxXVjJCZjJ3L1NnYURSWUVCSnY2dXlzUXQra2N6Uk84b3ZKQ0RoZzY4?=
 =?utf-8?B?RW1XN3BJUytNZERpZ25BQllYMnNiblJKR09Wamw0NzJDS0V3Y1BOQUluYWVB?=
 =?utf-8?B?VVo5bE1xa3NCbXdOazY1a2hDWStpVVA0dlE5TlBRZndqMUozdGV0Y2FEcTBV?=
 =?utf-8?B?UmRsUDVCNno2SEgwbVhoVEdkc3d1VGZHaHo2MGhiVnhMMGMrdU1aM3FDTDdS?=
 =?utf-8?B?dmJ0dlRiMWk0Ky8wZE8xRFRqc2pLVnd4Wkc0ZFd6UHM5YU5kZUJMMmtBYWdH?=
 =?utf-8?B?anRpd1B6QzBWZDE3NVVPQ29pSFpzYVF6Q1RkRDJvTnVDTE9weVU5VDJMMTdB?=
 =?utf-8?B?Q3o4ZHRtTnluZWdyL1p1NWtxRFJWVUQyWkE4bHcvcldKN01JTDAvUHE5OENu?=
 =?utf-8?B?RFIyaENUaS9iVEhqd3ZCWjdRNC84Mm4vQzNKNUpFeGNxOURYZXRQMzM3NmJK?=
 =?utf-8?B?YlYyRldNNkx6MkZad2p4YytuVC9haTR3V0oyemtxSDhISjdjLzhFeXNxUnhu?=
 =?utf-8?B?cEtXSGZSa21PM3hZbFVPZ3pieDBSSVkrMUR2bVVYc0Q2ZkhvMTRhSGdoKzBw?=
 =?utf-8?B?L1hOSnVCOHRhWmdJajBpdzdQN2tRK1M3TU1qOXhOa3A5WFlKUnRrVkxOM0lI?=
 =?utf-8?B?T0Q5dUZxblpNUDgzb2I3NlhiY3pzYzdDZkFuWjEvU2c3dWt5elBLZmczU1JZ?=
 =?utf-8?B?aFVtM2VEOGhtRVZDWk1JbzVwM1pwbnBGSkpRcmxtZmFEYk9yZzhjY0R1WDUz?=
 =?utf-8?B?b0lyNmFOdVlzdTBSY1l5K3MvTzRNejFmNHFTODdTWjVvQ0JUYjUyS0g1YUVI?=
 =?utf-8?B?TnBON3RaRXBwdUloaWZ1ZnZyWkw1OW9GZnpnVEUzUGNXeDFNcjRwWG9yTDhQ?=
 =?utf-8?B?bWlwZkVUVFgwZGtoVWx1UXM2bXdPZ2RraGlEU2xVb3l5VVRnMDNZZy9uL2ww?=
 =?utf-8?B?NzlTZnp5Nlg0eTlaR2tUMis3L3NyMVc3SGFXd0JPcEV5SzJFMGN4MnBrZnBp?=
 =?utf-8?B?LzdLeFdpcnNmM3hnQXVHdmdQeitUZE1rY01IRUs5bnJMc1RoSk1maHZnR1Nj?=
 =?utf-8?B?NDFtcTBTdFZoN1BwdFhZMVgzQnNkekM2SWhlbE0xTE1QV2plRjVLK3FCK3Nj?=
 =?utf-8?B?a2dnNlpwR2E3N0ZyMXhnUENFek1rakFKYnBDL1lZLy9YSk5jMmNKUnF6NmE3?=
 =?utf-8?B?dWN6RFhGVlM4YlhraUdvdG5OZ3RFbzRLamErNFNabDZEblBWd2xHaUNjOHpv?=
 =?utf-8?B?M0IvWVdBWTdaaWs0T1Z5dUFxeTFvT3J0T1hJcUxFT3JBZ2hWT1hCSG9ZdGZt?=
 =?utf-8?B?cEw4dDlVUy8wd3YzODdGdkZnVVpLZlBDSU9CamtvbWRaWnFwblZRYUJ2MVdE?=
 =?utf-8?B?Q1BTR1NBZmZqNXovYzlSVDVIL1ZDamFUWFY1M3c5TWFBRUZsR0hOWFFCL21y?=
 =?utf-8?B?aExONnluNmpuSXNsSmwxTk9GNlE4a3I0WTE2RzlGWnBsMXNXRzhDQlN0SGhT?=
 =?utf-8?B?czgweDJKVG56S3VyTTNvUGJrUk9rK3FFdXFVeFpic1E1OEdkWmQrd2c1UXZv?=
 =?utf-8?B?QmdwSS9Qb1I3ZTdxMmYxRXM3RXRVRmExZmVOdWNoNjJ0dEtEQkREU2NJblNl?=
 =?utf-8?B?VHNZVjdqVXBUM0pHa3pnMVR2dHZLSDlNcE1WaWRVb1NXdTZ0TGRSc25EWXFD?=
 =?utf-8?Q?E6N3d5L7DVgSFEpGiUXD6Wc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20E430786DFE4448B220C537027B2B45@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 001f4e12-d9e2-433d-2703-08dd9f9746dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 16:30:23.3640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1XDt58WYjjXMOhbNX7QWx/SVvHCZamZEKFrqk9tVQ9vteWuJ0Bl4sWaSJUFYGXkjkuCIKHl6gX0haTeKy0XPkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3947
X-Proofpoint-ORIG-GUID: gigat8ROAz1A3BhmwymOqPaOVHUMn4xC
X-Authority-Analysis: v=2.4 cv=fuPcZE4f c=1 sm=1 tr=0 ts=6839dd22 cx=c_pps a=a8vDHJEVVaJbVsNIiOtgWw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=1WtWmnkvAAAA:8 a=J8Y8m3gtpp9wOrj_oYAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gigat8ROAz1A3BhmwymOqPaOVHUMn4xC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDE0MSBTYWx0ZWRfXzebpmNi+yg1S jlEpsCPnz3w1Yfqqx7K4lF9oHCI5skXl1LzVWFdm7qqKIVJYKnW9p14TjEw19peoefW/TKWgkxW dRKhjwtREZcyW2YS9dSfLPAdSmtmlATekHNABwfVR7S+CxRklM7KeAIUA5XE/4tpJTQ/A0hTE4p
 E7HihWv13ODcKb080oJV8wp7dzJvAcdIVSBdNOK9zvwz9NbD1UQv4DJFqy+tkaN5HYzOkcHi1MM Must3h5vT8sUL0nRNkrNSm601jZqrAkqT6chk0v9hw/5TCriC7EewLtfm5pNZBKrpDCGru98yx0 iK497ctfTxuvAwN6pXKh921miNVRyJa1JRNv5qL19Z93eW7UNFDs06QYHnzGVjc+pug638sj8bU
 P0luAy8CS2u/ZxdaryycX2Npmjfcy4NyT4Rk9bhyvDQufGUkX9pjGglzZCD//tKz2J6m8Fj0
Subject: Re:  [PATCH v3 2/3] hfs: correct superblock flags
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_07,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505300141

T24gRnJpLCAyMDI1LTA1LTMwIGF0IDAyOjE3IC0wNjAwLCBZYW5ndGFvIExpIHdyb3RlOg0KPiBX
ZSBkb24ndCBzdXBwb3J0IGF0aW1lIHVwZGF0ZXMgb2YgYW55IGtpbmQsDQo+IGJlY2F1c2UgaGZz
IGFjdHVhbGx5IGRvZXMgbm90IGhhdmUgYXRpbWUuDQo+IA0KPiAgICBkaXJDckRhdDogICAgICBM
b25nSW50OyAgICB7ZGF0ZSBhbmQgdGltZSBvZiBjcmVhdGlvbn0NCj4gICAgZGlyTWREYXQ6ICAg
ICAgTG9uZ0ludDsgICAge2RhdGUgYW5kIHRpbWUgb2YgbGFzdCBtb2RpZmljYXRpb259DQo+ICAg
IGRpckJrRGF0OiAgICAgIExvbmdJbnQ7ICAgIHtkYXRlIGFuZCB0aW1lIG9mIGxhc3QgYmFja3Vw
fQ0KPiANCj4gICAgZmlsQ3JEYXQ6ICAgICAgTG9uZ0ludDsgICAge2RhdGUgYW5kIHRpbWUgb2Yg
Y3JlYXRpb259DQo+ICAgIGZpbE1kRGF0OiAgICAgIExvbmdJbnQ7ICAgIHtkYXRlIGFuZCB0aW1l
IG9mIGxhc3QgbW9kaWZpY2F0aW9ufQ0KPiAgICBmaWxCa0RhdDogICAgICBMb25nSW50OyAgICB7
ZGF0ZSBhbmQgdGltZSBvZiBsYXN0IGJhY2t1cH0NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFlhbmd0
YW8gTGkgPGZyYW5rLmxpQHZpdm8uY29tPg0KPiAtLS0NCj4gIGZzL2hmcy9zdXBlci5jIHwgMiAr
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZnMvaGZzL3N1cGVyLmMgYi9mcy9oZnMvc3VwZXIuYw0KPiBpbmRleCBm
ZTA5YzIwOTNhOTMuLjlmYWI4NGIxNTdiNCAxMDA2NDQNCj4gLS0tIGEvZnMvaGZzL3N1cGVyLmMN
Cj4gKysrIGIvZnMvaGZzL3N1cGVyLmMNCj4gQEAgLTMzMSw3ICszMzEsNyBAQCBzdGF0aWMgaW50
IGhmc19maWxsX3N1cGVyKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0cnVjdCBmc19jb250ZXh0
ICpmYykNCj4gIAlzYmktPnNiID0gc2I7DQo+ICAJc2ItPnNfb3AgPSAmaGZzX3N1cGVyX29wZXJh
dGlvbnM7DQo+ICAJc2ItPnNfeGF0dHIgPSBoZnNfeGF0dHJfaGFuZGxlcnM7DQo+IC0Jc2ItPnNf
ZmxhZ3MgfD0gU0JfTk9ESVJBVElNRTsNCj4gKwlzYi0+c19mbGFncyB8PSBTQl9OT0FUSU1FOw0K
DQpJIGRvbid0IGFncmVlIHdpdGggdGhpcyBwYXRjaC4gRnJvbSBteSBwb2ludCBvZiB2aWV3LCBT
Ql9OT0RJUkFUSU1FIGZsYWcgaXMNCmFzc29jaWF0ZWQgd2l0aCBub2RpcmF0aW1lIG1vdW50IG9w
dGlvbiBhbmQgU0JfTk9BVElNRSBpcyBhc3NvY2lhdGVkIHdpdGgNCm5vYXRpbWUgbW91bnQgb3B0
aW9uLiBJIHByZWZlciB0byBoYXZlIGl0IGJvdGguDQoNClRoYW5rcywNClNsYXZhLg0KDQoNCj4g
IAltdXRleF9pbml0KCZzYmktPmJpdG1hcF9sb2NrKTsNCj4gIA0KPiAgCXJlcyA9IGhmc19tZGJf
Z2V0KHNiKTsNCg==

