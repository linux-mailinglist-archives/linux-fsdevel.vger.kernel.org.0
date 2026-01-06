Return-Path: <linux-fsdevel+bounces-72551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 452C9CFB422
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 23:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79572305379E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 22:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDE62E7631;
	Tue,  6 Jan 2026 22:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HcXanYqz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B4F2EA156
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 22:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767738391; cv=fail; b=B0zEe7Jd+xfMjepxsDdQjKWGrtLsjDe+L1HQAteAruDyw8tcxJwKhcEIBgekgYiGfjQ3P91ijkrCUqw0oE9GP9opV9K7HG49dAr1ZupNiDQAVUJigcW74xXOukybOczD98XxZMxLc1UrWz/GaLPS61LuvgvCZuPtcmTbHOFtWnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767738391; c=relaxed/simple;
	bh=KMaCrGHhbqIi4+ImPMXZmG14udTDnQ7r4Cesb83zE3A=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=KUbB7UJ1eww2zmjfwTn/ACZ/locjDK8N5V2sUy5S5YahZztECfjmBoP1QIQN9U41rlEyfgt3lza71GgPB8GX2Ol7+nfDz0cW/k4qJ67aaCOwSeWG22FRPJz/NmOnB/DaJJMdFhhHEPwb1RlVzxCB1LQom94E9ZUh8p1iH6/0SoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HcXanYqz; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 606CVPQ8000873
	for <linux-fsdevel@vger.kernel.org>; Tue, 6 Jan 2026 22:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=ICcaAt8TDmFinuV7hYXpqBlBEwj5LsHaKzU5rd7ZA4Q=; b=HcXanYqz
	p79WiH/BxbSHY807J/l9pAdKrW+zUrpvZZydARyuPyGy3NtQZgi6gYD+QY6L8MGn
	Fx/++0rDWQAIoC7QC3IDN7FQlTuyeKLNueLO0M6kW+rhdn9SVpYOWx7FJ4we2C3j
	YeAj28C8aCLS6npjL/j+FCkruG9WIrirYpFZ7ivjtmGT3kxAunFwXRMMK5FgyeUF
	rYbrO94F7+dHmIsB/G7tDF4rYcSWWMuWSto8Oi3oKjrkRj4mBrolaLQQpMfKU6Bb
	SQiZE19StTPOpxKKEZd9+yOPdqU8xsnXUsotXJZCN6zQ5jf4vdb9d7siCoyV1OJr
	Mlnlq6THQr6xqA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betsq64c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 22:26:23 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 606MQMGh003757;
	Tue, 6 Jan 2026 22:26:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betsq64c6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Jan 2026 22:26:22 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 606MQL1Q003750;
	Tue, 6 Jan 2026 22:26:21 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013059.outbound.protection.outlook.com [40.93.201.59])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betsq64c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Jan 2026 22:26:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfcGvYpnd2QbX3zifLlWP0RENF4Da0FUCcLTtVgcSmmYlJnOc5JUgycZ0vkadOT092BNNeUcou4WSmgQsIcrUC2y1XsrRkTCKmXuoTt69+7J+zIFsv3aLEoo1SlHb4Y4wl0QnwSm0oE28+MwN3KOIB3qBD/Nx5kRzJ++2FlTFsQUtcePedhlsMTzt3DucPoy/SzVopzt667tIvgkwYOsD/e0NaroGDQkU6N8vGgCeQk1tqNXo0yrV8rtl9R16X6yR250Dsn5y+mgEIlQNZom39gOloqxSUGsLxXN1AxWO/MFXQx/+/n17x05Iqphlg28BNrXg7iq22onl4X6NXRySA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGdIzJ/BKgz4S51TCu3iSyd3d2NcmO8+DbskoTSQjr0=;
 b=aUC0Pb91KgD7NeDQ1s3TxzkA0HVXdHYVVwskXmAa5UNSH9vCzghaYg5vTHQvZqD+SHEo+9jfy8HV1Bcdm/4bMhse8rrsdfEaWd+S+sjrSFJ3tM11Vmgr+INcnmNvdk1KnTQVuwKiIrBk4FZYuWTJTPT9qzs79F7aTVUsNYNyf+Xpn4m/8xeY8xHqWfzt8Eu7NFuUuKsg41U4h6Ijs0YXuIhNVz7t/iwRDKK1R3saue/NckfaXEYhI1x2vvqODztwotB0DcUonAlHKkoOXwSPQ7hdMmJtzej4qjD6aw71ZQcDTzsPPOCCbBSa87D42ReAxSUoVsdFAeQnTSaT1Bytdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB4493.namprd15.prod.outlook.com (2603:10b6:510:83::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 22:26:18 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 22:26:17 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "slava@dubeyko.com" <slava@dubeyko.com>,
        Patrick Donnelly
	<pdonnell@redhat.com>
CC: Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        Alex Markuze <amarkuze@redhat.com>,
        Kotresh
 Hiremath Ravishankar <khiremat@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v3] ceph: fix kernel crash in ceph_open()
Thread-Index: AQHcf1ICZQxD0/+PvUCu0DzmpuwY/rVFuE6A
Date: Tue, 6 Jan 2026 22:26:17 +0000
Message-ID: <20164e7c5d978e2953196340069e1b560ec77ced.camel@ibm.com>
References: <20251223194538.251829-1-slava@dubeyko.com>
	 <CA+2bHPaGuxKhXZFJG7h0YyhiQ1EA-wtYAwdHFOcknJZ_v-aNZQ@mail.gmail.com>
In-Reply-To:
 <CA+2bHPaGuxKhXZFJG7h0YyhiQ1EA-wtYAwdHFOcknJZ_v-aNZQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB4493:EE_
x-ms-office365-filtering-correlation-id: 53c464c7-90ea-422f-dc74-08de4d729c6b
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZXRVM3BLVW16Um95NmNzSUlMVEorS01hS05GeXBYMU1hL2dhbHloOFU4M2wx?=
 =?utf-8?B?UUw4akxGR2VTdktHdGZvNVNqMFoycU9nVkorbmhZVnJJT0hiNWRyOEgvRzhp?=
 =?utf-8?B?ZjFEVkFwSkNXNDk2TjRMek5NcE5pSVA1czNoQ2twbEdrRWIyUWNheGVXdk1N?=
 =?utf-8?B?Q01WbXZjQXliK0R1eEFtUjd2QW9kQVhmdm9RWGR6RWw1eUJJMHllZ2I0SFNl?=
 =?utf-8?B?NS96SW1uWkYzUExkenpxMzYvc3VuV1BCTEptd3FoRmMraG0xdkVYRXFqcy9w?=
 =?utf-8?B?RUN3WWZtY3p0OFlVaTEvcDJOZHJWRDBVTnZrUDZFZlpDZjU3UjFFQzQ5eDlZ?=
 =?utf-8?B?R0t5ZlB6enB5S3Yxc2hNVVFmR2QrU2IvVHhyVmowV0Z6UmtBajgxL09VYkZx?=
 =?utf-8?B?QWRNL1BId09jODAxUmo1dlJPdDFVTkF2dk5OdlV4OXNnbE1CR0FCY2U4OWti?=
 =?utf-8?B?SzhjMThSek1TaUJYQ1pIcjZ3WjRETWRTdE5LVTNTYlhxU0tqdXFZdnJuWkcw?=
 =?utf-8?B?VkVPTmlzcmgyWHpKcjVEcU9sZXhsYUZhSDY5RmdpUEdCTFZoUUdvaUZ6Sysx?=
 =?utf-8?B?WmVpSUplSVJsd3FGNkhleG52VEsvNG5oL0tQTENxcENZUmxVbkJGTmtuMm1p?=
 =?utf-8?B?MDJwYUpVS1d0OWlwT3JBYnhKc3UwblFWcHJWS1N4N2dibDFIT0ptTVE3Tnh6?=
 =?utf-8?B?YWNXSm94cnFqdE95S29kT3phYnM3VHB3QXkyYmhRZmVzUVVSL1AxVmhkaC9C?=
 =?utf-8?B?QU00MndrVy9lQUhWb20wS0ZRbXcxbTRqQVdXWjJFNFZrUXF5YTBPQ3Y1N1da?=
 =?utf-8?B?aTV1bzBIdHN3YjJOOEhhT3Y3QWtrN2FzK3k2cFR5UkJLTnR1VUZkcktLaWNT?=
 =?utf-8?B?akdBcDJWL2FPbTZUZmp4Wm9vRkFtMk5na0JJMitzRjVYblRwNWd4WmhWWFNn?=
 =?utf-8?B?L0gvZDB1U3FiL2RCNVl5ZC9hSktIbjJvS0YxOEtXVzBneTRyOGF3L3hVTHEz?=
 =?utf-8?B?cjVReEJNaGlQVWdLV3JBRGd0OFlMTmJGMnNWM2F0a3pLalZWdG9tMEtlYTJt?=
 =?utf-8?B?SVJuZ3A3dldoRWhUSDNoaHNUVWxHK0ZEbFBab1NkdHUwRG1YTjI0b29TVGNX?=
 =?utf-8?B?OFR1MlladytVbXlCQ21BNWlhVThhelI0ejFOLzZjSFRNZ2tmbWloRTg2YlZi?=
 =?utf-8?B?TTI1KzRPQ1JVemd3cmhWWFZJODF5UWxzcEJQTEI5QmVpV3QzcmlIZmxrTHZy?=
 =?utf-8?B?NU1oVWRab3JFNmNNQTZLU2tOOUxlMkN5a1MvdC9xVkdqQktBTkpsOGRpVkZj?=
 =?utf-8?B?Zzc4NmhMeUFWSGdVV3p3UWtKNWo1cnpDaEI1c0NKOEhFZmRMMHJMZjhpNllE?=
 =?utf-8?B?TWZNSTE0NlJhVDhNYSt2TUVGS1FUSlU5R2FQMGR0VmhyKzhmSHdHeW40RTVH?=
 =?utf-8?B?TVdYcFk5L09vRHcvSHE5YmNlTG5HRFVMZ01LSjhhZk9SMm9JRXlqaldmM1hZ?=
 =?utf-8?B?Y05adi95b2FpczZPOFVPSDFaT0F6UUU5NHlrTUEzTE5GUHduZm81dmEzUjRZ?=
 =?utf-8?B?cExXaU9PLytSL3QzQndHbERCanVEN1dBQ29jcnpEYWR1c3Jsbzl0c1JjSmEz?=
 =?utf-8?B?S3ljMFZGMVRSVFg2WHMyd2dEYkN4SThKN3hjNlBWN0F0SW8wc040SnZhWUdI?=
 =?utf-8?B?OUlTbFVOTEswbGZ1MGNSTmM2Qk9ROWl6Wm1GRU40bHIwOXJQQVdlVENhR2I3?=
 =?utf-8?B?NlFRNCt5SStrQ3U4UVg4M1gxNmcrYjVNelNOa3Y4S2RuVFRULzZHQnlJdkg0?=
 =?utf-8?B?SzhSK1dONmZJNkI3R01Nd25NVmg4R1NxZUQxUjNlTWVpU3hTMzdyWXB1K1h1?=
 =?utf-8?B?d3pZUHB2Tm41T1R2QnJtUDZZOFRZYlZNZG5SZEswTHNSbFErRTlUd0d5Mmcz?=
 =?utf-8?B?dDdoMnFQK2dyaEsxcWsrVjB4ekMrMzZpVDJVK3hxWVE3b0x2M0ZwcnEzU1JR?=
 =?utf-8?B?VFNHMmxad1RBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ME1xQ2l0cEozSjBWczk1Ylk4VUdydThJNXdreVJjUDdsdWhPM3NmT3p0bWxX?=
 =?utf-8?B?Ykh1aUdZeEh4dTFmOHY3djZ3eGFSdHRaRGxkTHdHSE5xUXd3Y3dubWVwTm03?=
 =?utf-8?B?NzNkQWlGU3FQejVMaUlMMWpYaUc1ZTZwaXgyRWdOSlZha3pkejdzM1c2UFZU?=
 =?utf-8?B?ME5EbVZtb1BoU0F6d0o0Y3hFTXJ3empwSG44VkZYRWRmeGZCOXhQZzFKNDBv?=
 =?utf-8?B?bHo4R0pmaG1TbFBUNzFOTlRPWnJjbWllaWFYWXlISUVCOThmY0lzdlpMbUZN?=
 =?utf-8?B?RyszSUZLS2pHbDZNTFRMR2RFWjZZUzVBSFJIZlhncDRyRmxic2VlRTRQTkxJ?=
 =?utf-8?B?S3ZuUUxXWlRwSGxYOUM0eVIzeEV1cktmNS9rWnRDN2JlSVU5ckVobkVaKzhF?=
 =?utf-8?B?bEVRYk5UeHBSanBHdk1NMXM3N2JOMGoxTXZRNDBIMVVPYmtPUDlxcFZYZ3R4?=
 =?utf-8?B?MHgxY2grVk83YS9hZk5KSTNCY25RYnc0NVkxb3JCYkxMMU5sOXp1MHBScTRT?=
 =?utf-8?B?anRTeWxUQnF1ME9iSzhZanFHWlJ2UlV3V2VSN1N6RDUvak05MFhtTVJHRmVR?=
 =?utf-8?B?b1Jac2o1MSsveC9weVgxcnZVYWY1eXRFbGdyZm5TcjZST1ZJTUZRcWpqQm1t?=
 =?utf-8?B?MlZxbkZybENUcTRRNUl4WjIrbG4yaFdGSldyK3BPd2VKZ21rRnhxUitKcE1J?=
 =?utf-8?B?MWVsbHFtOFBtbXZWWFFqRkJySU5jQzUrL2VXTXAxdGtSRVJXS0lzWWl2cHd6?=
 =?utf-8?B?czFjajlURzdWNFRXMFUreXFSdEEyR0xseUZPaVJHczh3Sm9ia0l5c2h3NFRK?=
 =?utf-8?B?OFFwRXBXTVAxVm01d3RJc0pRVEk1bGJpM1pFODBMQ0FlZmlzc21MYnhYdXBF?=
 =?utf-8?B?c25oQU1DMndob0tOcWVlcGtLOG1hWHMxUFFMYVQyeDYyT1lFZ3NRS1RtK1lZ?=
 =?utf-8?B?b3g4TzRwTXlacmVwMlUrc2hOOVVYQTNYTXpRUHlUbHBMa2Z6dUMxRmFNaWtV?=
 =?utf-8?B?em9ya3Q1aXBaUFBNN2VqaWRobUZkbmw5Tm9vTzkzMXFoUFpsN04xcHU4dVJR?=
 =?utf-8?B?dkY1OWYyUkFLRUJOTFBqbjJuNm0xcDJ3R216VitBN1ZkRytWUGtJNDBxLzJr?=
 =?utf-8?B?V2ZJRStSM3dzeXM0cWVrazhpYUxBVGFENzI2TmpadHZjd0NueTE1Rzh6OGVm?=
 =?utf-8?B?Zk5yR0lLUkQwUGpuS1FxdlFZTzdhbFYvZTI2WEtiOG5NejU4TzF3UitUQVEx?=
 =?utf-8?B?NHdrTWxQcUVRdVhoa3NMVXdkN1p2LzF0eXpBejM3N2hUNzEyck0rNVE2WjJZ?=
 =?utf-8?B?Z0p3cFVTYjF1Q05JSGxDODFvMjhuSWIwb25FZFJabUVlMzNIYXQ4alp4TFRY?=
 =?utf-8?B?MDJOaDJCU3RNbVE1bWNvNTNBVmNZRWVrSTZmb1MzU0JEcWpYNmdIdXFoRngw?=
 =?utf-8?B?bFZsUjlSdUY0eG5qK3pvMlVhRG1HV0FYRGY5MTN2MThTRTJXSFh1MHFOK2x6?=
 =?utf-8?B?ZzFDT1JRcjR1anBpcVlZcThOYk1UWjJERGZEdHRhdkpWOEYxS1RoNmNhUHBT?=
 =?utf-8?B?U0lxTzQxUUREb3BOQ3N1S0cwcUJRTzRLT0tDNzNWK2ZndlhiZEhLNGpXRmlV?=
 =?utf-8?B?SnJPVk51UndjQno4ZzhVMnFQb0RIZUhzRlk3QkVERTNDeVVZckJrZVJnRENB?=
 =?utf-8?B?NUpsWWN3NXk4Qko3aHRKWVFtOE1LbVh5SHVyejQ4UC9qMFVBSTJZRkJmNzV6?=
 =?utf-8?B?Zng4TUdrWmFOdmpPa1puOXZSZFU3R0huaHhMUHlSejBjd3diL2cvcW9aZnpT?=
 =?utf-8?B?L0dUYzNpamh4Nmk1VlRDVDJTMXR0Nm5RWW1SQWxXdTBDd09LVjVIZEc5T1Z6?=
 =?utf-8?B?WWVYWndUMEpEOHkxSVR3ZzRmb2FYM2dBYmp4K1RsQllSLzVJSWRUQW5DSlNW?=
 =?utf-8?B?dGMvVTNkMnY0Mk5pTDNsV01NdE56YlQrdlFXMU5jMEh5M3ZpRjhMU0N4SVdB?=
 =?utf-8?B?RjZEYjFVWjMrSTF1OHI0NFN5NU51VkJjaUx5cnlVRTZ2NFpveXpvMHY3QTNk?=
 =?utf-8?B?TzQzWmFLY2hJMmdVN3g1RVUzZ09PMHBiRy9XeUF5cFk3ajVOakVuVUlzWklL?=
 =?utf-8?B?aTNobElPNWM4bkVWK0UwSHpPVUxEMGVhUXJybU1XWUpYT09ZbmZvZk1CazBw?=
 =?utf-8?B?dWl2SXVyQkQvWTl4R1c1dTBkeDhEYW1PQ1g4eDVob1NnaE1zZ3NYTkpFNkJy?=
 =?utf-8?B?SEM3a0Q2VVVCRjVsb0F3MGErNHVzVkxIaFVMRUZjV1hjQ3ZPSzZ3MkFNUXdh?=
 =?utf-8?B?WXdPbFVVVUN3L2JTcFdGa0pPK1JQSXNCVm5MZ3hON1Brc01hNHpUSW80cU1J?=
 =?utf-8?Q?Wq8SkoSAMsF4xJoQRyghFIPSDr/A90KX1WnJj?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c464c7-90ea-422f-dc74-08de4d729c6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 22:26:17.8704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E4dPt2r6Y+5EDxUbIpaRIpFGd9HY8GRIrwfXSwdjee34fqvk4tYdsrjt7Z9qyc/eVboTVQ0JLgrM0vHQjIPtEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4493
X-Proofpoint-GUID: DifZ64NPBII2GsBrOXsG2iHWWKqu6TFj
X-Authority-Analysis: v=2.4 cv=Jvf8bc4C c=1 sm=1 tr=0 ts=695d8c0e cx=c_pps
 a=sTSJOlcUIwiiAZkT7IHz4Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=P-IC7800AAAA:8 a=4u6H09k7AAAA:8
 a=wCmvBT1CAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=tx9iAuz42_gCB5JD6owA:9 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22 a=5yerskEF2kbSkDMynNst:22 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-ORIG-GUID: Sg88SfTN98F9fgoV-4ZtFst7A-pNlaIJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE5MyBTYWx0ZWRfXwCp5wS10U8Jh
 xvXsqrhY0DoOqyQiLX0grtHlcUCY687qIb/91C5NmtqFo02pPgwc9tfaWRCTHvS2XlluNcNrXzF
 VQhaDlCSGbgyzJE5y4JJUoOKMNK5eny9nLfFlU5vPFOvgiLhwUktwpRJ1CEouFZouLRm1NRlUBf
 KgURJXwHn5TdIDhFS5hza84YPtiuNGIsKl96iR6mk3f0K/vivwLt8qrlGYzs1BqVjNLGEZWv6WX
 mhON9MR9JTNLobK+0bKXHW5SlNyMERMQglCHW72ZD4rMTXabcUNFfOOinmqAe/v5MdjRZPdA88X
 fmT7ZpptDN9jfyhLyR5fwJlliJ9vmHhME2CqHqfDFbzSR3gHY9gUlBgtR4H9Q2R3uysy0oGODEo
 21JUGqhsNml8LRM55w1DC3P6tWAbnIzBJ/AHaMunAtxmm7aXy6ZrYFi+HczXTeSQdnI21qbBXf4
 5pAbIwagnxAUu1U+Ziw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <CEEDC65FED1000458E737F481FBCBBEC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v3] ceph: fix kernel crash in ceph_open()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_02,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2512120000 definitions=main-2601060193

On Tue, 2026-01-06 at 16:17 -0500, Patrick Donnelly wrote:
> On Tue, Dec 23, 2025 at 2:45=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko=
.com> wrote:
> >=20
> > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> >=20
> > The CephFS kernel client has regression starting from 6.18-rc1.
> >=20
> > sudo ./check -g quick
> > FSTYP         -- ceph
> > PLATFORM      -- Linux/x86_64 ceph-0005 6.18.0-rc5+ #52 SMP PREEMPT_DYN=
AMIC Fri
> > Nov 14 11:26:14 PST 2025
> > MKFS_OPTIONS  -- 192.168.1.213:3300:/scratch
> > MOUNT_OPTIONS -- -o name=3Dadmin,ms_mode=3Dsecure 192.168.1.213:3300:/s=
cratch
> > /mnt/cephfs/scratch
> >=20
> > Killed
> >=20
> > Nov 14 11:48:10 ceph-0005 kernel: [  154.723902] libceph: mon0
> > (2)192.168.1.213:3300 session established
> > Nov 14 11:48:10 ceph-0005 kernel: [  154.727225] libceph: client167616
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.087260] BUG: kernel NULL point=
er
> > dereference, address: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.087756] #PF: supervisor read a=
ccess in
> > kernel mode
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.088043] #PF: error_code(0x0000=
) - not-
> > present page
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.088302] PGD 0 P4D 0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.088688] Oops: Oops: 0000 [#1] =
SMP KASAN
> > NOPTI
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.090080] CPU: 4 UID: 0 PID: 345=
3 Comm:
> > xfs_io Not tainted 6.18.0-rc5+ #52 PREEMPT(voluntary)
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.091245] Hardware name: QEMU St=
andard PC
> > (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.092103] RIP: 0010:strcmp+0x1c/=
0x40
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.092493] Code: 90 90 90 90 90 9=
0 90 90
> > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83=
 c0 01 84
> > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff =
c3 cc cc
> > cc cc 31
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.094057] RSP: 0018:ffff88815368=
75c0
> > EFLAGS: 00010246
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.094522] RAX: 0000000000000000 =
RBX:
> > ffff888116003200 RCX: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.095114] RDX: 0000000000000063 =
RSI:
> > 0000000000000000 RDI: ffff88810126c900
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.095714] RBP: ffff8881536876a8 =
R08:
> > 0000000000000000 R09: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.096297] R10: 0000000000000000 =
R11:
> > 0000000000000000 R12: dffffc0000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.096889] R13: ffff8881061d0000 =
R14:
> > 0000000000000000 R15: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.097490] FS:  000074a85c082840(=
0000)
> > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.098146] CS:  0010 DS: 0000 ES:=
 0000
> > CR0: 0000000080050033
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.098630] CR2: 0000000000000000 =
CR3:
> > 0000000110ebd001 CR4: 0000000000772ef0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.099219] PKRU: 55555554
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.099476] Call Trace:
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.099686]  <TASK>
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.099873]  ?
> > ceph_mds_check_access+0x348/0x1760
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.100267]  ?
> > __kasan_check_write+0x14/0x30
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.100671]  ? lockref_get+0xb1/0x=
170
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.100979]  ?
> > __pfx__raw_spin_lock+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.101372]  ceph_open+0x322/0xef0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.101669]  ? __pfx_ceph_open+0x1=
0/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.101996]  ?
> > __pfx_apparmor_file_open+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.102434]  ?
> > __ceph_caps_issued_mask_metric+0xd6/0x180
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.102911]  do_dentry_open+0x7bf/=
0x10e0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.103249]  ? __pfx_ceph_open+0x1=
0/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.103508]  vfs_open+0x6d/0x450
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.103697]  ? may_open+0xec/0x370
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.103893]  path_openat+0x2017/0x=
50a0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.104110]  ? __pfx_path_openat+0=
x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.104345]  ?
> > __pfx_stack_trace_save+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.104599]  ?
> > stack_depot_save_flags+0x28/0x8f0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.104865]  ? stack_depot_save+0x=
e/0x20
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105063]  do_filp_open+0x1b4/0x=
450
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105253]  ?
> > __pfx__raw_spin_lock_irqsave+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105538]  ? __pfx_do_filp_open+=
0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105748]  ? __link_object+0x13d=
/0x2b0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105949]  ?
> > __pfx__raw_spin_lock+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.106169]  ?
> > __check_object_size+0x453/0x600
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.106428]  ? _raw_spin_unlock+0x=
e/0x40
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.106635]  do_sys_openat2+0xe6/0=
x180
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.106827]  ?
> > __pfx_do_sys_openat2+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.107052]  __x64_sys_openat+0x10=
8/0x240
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.107258]  ?
> > __pfx___x64_sys_openat+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.107529]  ?
> > __pfx___handle_mm_fault+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.107783]  x64_sys_call+0x134f/0=
x2350
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108007]  do_syscall_64+0x82/0x=
d50
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108201]  ?
> > fpregs_assert_state_consistent+0x5c/0x100
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108467]  ? do_syscall_64+0xba/=
0xd50
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108626]  ? __kasan_check_read+=
0x11/0x20
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108801]  ?
> > count_memcg_events+0x25b/0x400
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109013]  ? handle_mm_fault+0x3=
8b/0x6a0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109216]  ? __kasan_check_read+=
0x11/0x20
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109457]  ?
> > fpregs_assert_state_consistent+0x5c/0x100
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109724]  ?
> > irqentry_exit_to_user_mode+0x2e/0x2a0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109991]  ? irqentry_exit+0x43/=
0x50
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.110180]  ? exc_page_fault+0x95=
/0x100
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.110389]
> > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.110638] RIP: 0033:0x74a85bf145=
ab
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.110821] Code: 25 00 00 41 00 3=
d 00 00
> > 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c=
 ff ff ff
> > b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 24 =
28 64 48
> > 2b 14 25
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.111724] RSP: 002b:00007ffc77d3=
16d0
> > EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.112080] RAX: ffffffffffffffda =
RBX:
> > 0000000000000002 RCX: 000074a85bf145ab
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.112442] RDX: 0000000000000000 =
RSI:
> > 00007ffc77d32789 RDI: 00000000ffffff9c
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.112790] RBP: 00007ffc77d32789 =
R08:
> > 00007ffc77d31980 R09: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.113125] R10: 0000000000000000 =
R11:
> > 0000000000000246 R12: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.113502] R13: 00000000ffffffff =
R14:
> > 0000000000000180 R15: 0000000000000001
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.113838]  </TASK>
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.113957] Modules linked in:
> > intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pm=
c_core
> > pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_v=
sec
> > kvm_intel kvm joydev irqbypass polyval_clmulni ghash_clmulni_intel aesn=
i_intel
> > rapl floppy input_leds psmouse i2c_piix4 vga16fb mac_hid i2c_smbus vgas=
tate
> > serio_raw bochs qemu_fw_cfg pata_acpi sch_fq_codel rbd msr parport_pc p=
pdev lp
> > parport efi_pstore
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.116339] CR2: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.116574] ---[ end trace 0000000=
000000000
> > ]---
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.116826] RIP: 0010:strcmp+0x1c/=
0x40
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.117058] Code: 90 90 90 90 90 9=
0 90 90
> > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83=
 c0 01 84
> > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff =
c3 cc cc
> > cc cc 31
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.118070] RSP: 0018:ffff88815368=
75c0
> > EFLAGS: 00010246
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.118362] RAX: 0000000000000000 =
RBX:
> > ffff888116003200 RCX: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.118748] RDX: 0000000000000063 =
RSI:
> > 0000000000000000 RDI: ffff88810126c900
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.119116] RBP: ffff8881536876a8 =
R08:
> > 0000000000000000 R09: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.119492] R10: 0000000000000000 =
R11:
> > 0000000000000000 R12: dffffc0000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.119865] R13: ffff8881061d0000 =
R14:
> > 0000000000000000 R15: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.120242] FS:  000074a85c082840(=
0000)
> > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.120704] CS:  0010 DS: 0000 ES:=
 0000
> > CR0: 0000000080050033
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.121008] CR2: 0000000000000000 =
CR3:
> > 0000000110ebd001 CR4: 0000000000772ef0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.121409] PKRU: 55555554
> >=20
> > We have issue here [1] if fs_name =3D=3D NULL:
> >=20
> > const char fs_name =3D mdsc->fsc->mount_options->mds_namespace;
> >     ...
> >     if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name)) {
> >             / fsname mismatch, try next one */
> >             return 0;
> >     }
> >=20
> > v2
> > Patrick Donnelly suggested that: In summary, we should definitely start
> > decoding `fs_name` from the MDSMap and do strict authorizations checks
> > against it. Note that the `--mds_namespace` should only be used for
> > selecting the file system to mount and nothing else. It's possible
> > no mds_namespace is specified but the kernel will mount the only
> > file system that exists which may have name "foo".
> >=20
> > v3
> > The namespace_equals() logic has been generalized into
> > __namespace_equals() with the goal of using it in
> > ceph_mdsc_handle_fsmap() and ceph_mds_auth_match().
> > The misspelling of CEPH_NAMESPACE_WILDCARD has been corrected.
> >=20
> > This patch reworks ceph_mdsmap_decode() and namespace_equals() with
> > the goal of supporting the suggested concept. Now struct ceph_mdsmap
> > contains m_fs_name field that receives copy of extracted FS name
> > by ceph_extract_encoded_string(). For the case of "old" CephFS file sys=
tems,
> > it is used "cephfs" name. Also, namespace_equals() method has been
> > reworked with the goal of proper names comparison.
> >=20
> > [1] https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/ceph/mds_clien=
t.c#L5666 =20
> > [2] https://tracker.ceph.com/issues/73886 =20
> >=20
> > Fixes: 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue")
> > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > cc: Kotresh Hiremath Ravishankar <khiremat@redhat.com>
> > cc: Alex Markuze <amarkuze@redhat.com>
> > cc: Ilya Dryomov <idryomov@gmail.com>
> > cc: Patrick Donnelly <pdonnell@redhat.com>
> > cc: Ceph Development <ceph-devel@vger.kernel.org>
> > ---
> >  fs/ceph/mds_client.c         | 11 +++++------
> >  fs/ceph/mdsmap.c             | 22 ++++++++++++++++------
> >  fs/ceph/mdsmap.h             |  1 +
> >  fs/ceph/super.h              | 36 +++++++++++++++++++++++++++++++-----
> >  include/linux/ceph/ceph_fs.h |  6 ++++++
> >  5 files changed, 59 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 7e4eab824dae..dd0d2df9d452 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -5671,7 +5671,7 @@ static int ceph_mds_auth_match(struct ceph_mds_cl=
ient *mdsc,
> >         u32 caller_uid =3D from_kuid(&init_user_ns, cred->fsuid);
> >         u32 caller_gid =3D from_kgid(&init_user_ns, cred->fsgid);
> >         struct ceph_client *cl =3D mdsc->fsc->client;
> > -       const char *fs_name =3D mdsc->fsc->mount_options->mds_namespace;
> > +       const char *fs_name =3D mdsc->mdsmap->m_fs_name;
> >         const char *spath =3D mdsc->fsc->mount_options->server_path;
> >         bool gid_matched =3D false;
> >         u32 gid, tlen, len;
> > @@ -5679,7 +5679,8 @@ static int ceph_mds_auth_match(struct ceph_mds_cl=
ient *mdsc,
> >=20
> >         doutc(cl, "fsname check fs_name=3D%s  match.fs_name=3D%s\n",
> >               fs_name, auth->match.fs_name ? auth->match.fs_name : "");
> > -       if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name)=
) {
> > +
> > +       if (!__namespace_equals(auth->match.fs_name, fs_name, NAME_MAX)=
) {
>=20
> I think there was some confusion. The ceph_mds_auth_match procedure
> should handle a wildcard auth->match.fs_name, not the other way
> around.

Just to double check... Do you mean that ceph_mds_auth_match() needs to pro=
cess
the CEPH_NAMESPACE_WILDCARD too likewise namespace_equals() is doing? Am I
correct?

Thanks,
Slava.

