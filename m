Return-Path: <linux-fsdevel+bounces-69467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2E6C7BD20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 23:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319243A6F80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 22:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DBE3064A3;
	Fri, 21 Nov 2025 22:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FIRxNehs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC6D305E18
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763762693; cv=fail; b=ocJIuqzIpTNyIPhGSc491xs984vN/NR+DF+yWeFDQFuP6A6n8nj0LL6SIa/z/C43XER6C4nnHnIYMdUpReSSLykcqF8nKJF3hPHw4/UygmlNnnnki5p0hOOa28GH5TcTHNyIN33NoiRUt4FYyuIvmkGkVm2Q6jvSMVgqoAeAMu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763762693; c=relaxed/simple;
	bh=Xxe7zKTilPxmEcDl+7S1ZV2eDqJXF+lUpJLDcsb+bBQ=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=X77h1acz64LM7nRgFMt5zhmq9IQjdEsgJJ/Q5A2kXDcINPUWHMFXvftbSNAxeEVLa360V4BhhDN9ChNgNcd7pOAMB7K+2nE9gyBKFpiLP8+2j2pE1VLkklLjDQM+trz3/HuCS25DhdL/hFa38Upbzy0tnDzyABLJMZ944Ly2ZrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FIRxNehs; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALEvEa2007857
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 22:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=WRQNcX24jc0RPG9mHbxIej2aVNjos76LlYvLjs24JKE=; b=FIRxNehs
	38TTTOYxNCAul1qogojdk5NOTNRqdkwv9bWnPcgPwwQzGG1at9MurCKIxijRvMTR
	yoS5CEPtRIce2IjR7qJuawB5p5fom2sfvA51SqvDCHTgdKU/SslX6nGU1d1TUdta
	BXaPai9FKk7ZzeLGPHaKvlk7QH97yOmK6wf8ryUsuutznodxSKPWgF5UdxYAvTIO
	zURVIPD2qNIchMSlJascpI8Qmrur7P8x1YClUQUa6lFkjxuwD/a4AS5L5a6m0s2U
	9tVgbnE4S7egg5d+ykQynl23qqkRjqxmY7Y3GEPVqAymGFp19mBI1y4TwfEOk0J+
	ThyknJvnj976cw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmt4y0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 22:04:50 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ALM3Juu023189
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 22:04:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmt4y0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 22:04:49 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ALM4neA026134;
	Fri, 21 Nov 2025 22:04:49 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012057.outbound.protection.outlook.com [52.101.48.57])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmt4y0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 22:04:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAnGjcb5+utTzsOvarKI/RkjAXsHc3Ry32pdINYehzUSYXHi4dp3WGhAakzM0PgrHaAXh0xn/0k5ihkksbzZpwKKT0LbNq+rDn85Ew2LMB2vCQH2HpGMytOoTA4somm3sSHNzGCPK1xWbnkJnyVJS+UxtgFzvziboJSw+J8uaEoGvQcg6RhVm8rPuV9Lvi7hv5ltysD7VyNB34Gmeq0TpVdMeHpVKuPpN5w0bk+qRfGR0pmijdgpzE3Pi/5oRmuF//Ratay1FS0NgYMaC6FM9CwhYFhyHi/ikaCzCFPWlhu33vAB0oTtdW3NV/mkb2EbXPcKIAABbhMFPRYvYVrWVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Q8Z5kC+FKJJifddJIhBdZuJkUAyDb3gqr6dArDMvz0=;
 b=JtfAx9HFiWoVivUAvBPitDSebSCQR9LY1vsmO+KKCU0fQw3Wo9KbzQKvBNl4UpBMa+zNByZBXs/uHeqzDkbKPTfW4YwrYzXxTa0Th1s8Pw8Uj8ZeU0rmakOvyTKI4sjlHjooh+Gxeuju2ZlyalQj56SDM1WFGiaSdssjCNDyjyT2Akv55E46Y6PsXgfmL1XBRz9JTQYA21FX6TRXbrgEKx8ww+rSwfacG3iYRqkWOo+P7bygLpWK4NVhwKNZ8f5QrEOw/EkFfxkerj4jveJAiozs5keM+6Q2agitUZqb1/OE0XMAD0JOmqdUPF7o2JvEE0LJ77KFH/yoppsabDIolw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA0PR15MB5571.namprd15.prod.outlook.com (2603:10b6:208:43b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 22:04:46 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 22:04:46 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "jack@suse.cz" <jack@suse.cz>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "mehdi.benhadjkhelifa@gmail.com"
	<mehdi.benhadjkhelifa@gmail.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC: "linux-kernel-mentees@lists.linuxfoundation.org"
	<linux-kernel-mentees@lists.linuxfoundation.org>,
        "david.hunter.linux@gmail.com" <david.hunter.linux@gmail.com>,
        "khalid@kernel.org" <khalid@kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com"
	<syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] fs/hfs: fix s_fs_info leak on
 setup_bdev_super() failure
Thread-Index: AQHcWxbjI2wNRsxXGEmG7hnNwSoKY7T9oaoAgAAaLgD///OkAA==
Date: Fri, 21 Nov 2025 22:04:46 +0000
Message-ID: <148f1324cd2ae50059e1dcdc811cccdee667b9ae.camel@ibm.com>
References: <20251119073845.18578-1-mehdi.benhadjkhelifa@gmail.com>
	 <c19c6ebedf52f0362648a32c0eabdc823746438f.camel@ibm.com>
	 <3ad2e91e-2c7f-488b-a119-51d62a6e95b8@gmail.com>
	 <8727342f9a168c7e8008178e165a5a14fa7f470d.camel@ibm.com>
	 <15d946bd-ed55-4fcc-ba35-e84f0a3a391c@gmail.com>
In-Reply-To: <15d946bd-ed55-4fcc-ba35-e84f0a3a391c@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA0PR15MB5571:EE_
x-ms-office365-filtering-correlation-id: 49690664-5ca2-463d-3234-08de2949fb76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YTNPMGRKYUtKZ2RGdWRWaUhsSzZSZEZKZ2lXdTNNYjdoaXl4eEFwOEdRM3dy?=
 =?utf-8?B?WVBPa1JpcGoxOXp4L0twY1JldFR2RVBzeUZHR2RXRVVLUktZUHN4dzBnaFNo?=
 =?utf-8?B?ekJ5eWxVOThPWXZySm5aa0VpVGlFc0NneXVKcmwrbUZ2SFMvWmU0VVlocnlJ?=
 =?utf-8?B?YTR0UklZZ0h4a2hpMjRsV1RMZm9FRmk4cU8wTE5kRmowT2VoZDBZakpWcVYy?=
 =?utf-8?B?UHBwNEkwWXRRdy9WL1c2OU9vNFRWTHhUcUcyV0FLYlJ4Y2hDYjQ3VU5GUEwz?=
 =?utf-8?B?MHoxNWFoS3VPQUcyYzVid1hRdEFXMHNVSEc1WVBaKzlVeCtTRy80azVEUlhq?=
 =?utf-8?B?cUZaY1ljRUxTa1ltWTJUMXR5QXc4ZkpkbGM4YkR6b1ppN0Jjcy9hWmFVMkEx?=
 =?utf-8?B?THg4VDZ2ZWNISHN4V0xhclBjaFphWDdocjdXSnlyVHpya3YxTWZIYTN3KytZ?=
 =?utf-8?B?czBJVDhERlJ6MWJ4MFZjUUtnT21ybTQwRzcyemQ4em85ZjNvL2NQc280UU5Y?=
 =?utf-8?B?WDVoK24wWXFCMEhob3VtZEw0dVpmRmdka1dEWmNLVDFrUTIyWUpZTkIwRjBR?=
 =?utf-8?B?WFJ1ODc1Y1F6TXNENm4yWThKTko3ZVg5QW5IMytyeUZBaVBWT2RGdXpoSTBu?=
 =?utf-8?B?aDl0QmxvYWlzSURlaHQrZ0tYN2ZVNnJua0ZhNFA0N1p4aTI4TjRKQmxVTVpw?=
 =?utf-8?B?S01lYnpFK0lCY0dpOVE2OHQraDRMRDU0RGVoY0tSQkRtMEttOWhFQjEwMUcw?=
 =?utf-8?B?OGVyVll1SFYzalprOW0rM3MxRnl4WmdOVUtTM214aFBuMTFVTGNLZGZNS0ps?=
 =?utf-8?B?RXZvQ214eGhDUHVXMVUvbTB3aWVndVllZUdlckNCWEQ3OTZFWDVQZjJJT24r?=
 =?utf-8?B?c3VuNHdjTXhucjZXSmZsdzBZdGRlL0dEMFlEZkx4UG9kN2RHVDVZNFlxVS82?=
 =?utf-8?B?aFBteEtIN3EyNTVGRU5sa09rYUxra3J5d3dZdHIwYTJGSWt4ejd5Q2FLaDMv?=
 =?utf-8?B?OEtURUo5L3E1eWpBN3g1SnduWCtPRjU2czdxaGN4VnFVcDdobGxCQnRWK3p1?=
 =?utf-8?B?WkpiQnR4aGVQTTBFQ3Q2UndObGNyRnNUZlduZDI0bnQvYlBUZDhVYnFVVUlH?=
 =?utf-8?B?NDZPc0cxdkdtMHlvdEpQakgya1NveVNXWEpCR080UXJhV2JOcVVsUDZ5WWE2?=
 =?utf-8?B?SU9vN2RtOHNTMEdmUXdaem13ckxzTjdpVnBwbUpZa0g4OUdXYVRDR1dkY1pO?=
 =?utf-8?B?ZEdaZElJQURZbW8zckZ0WTQ4bUVBSlRTTWpiMEJpWW1wejgzODV1Rk9oc2gy?=
 =?utf-8?B?SlFvOWRnL1lUZXZnZEJYVVR1cDRSTkMyTUFWL1lzcCtyME44ZWpqZVRESUxh?=
 =?utf-8?B?Zm1uN2g5TGFuTTUxMm9pMmpUc1pHSTlOMnpKTEgwamJrV3YzVTFOZml1VDlq?=
 =?utf-8?B?TXlSQ2hnNnJyemZ1aHcxOEMzSnJ1UklNUlIwcTJ0VlZoYnArSEo4VUpQOWNI?=
 =?utf-8?B?ZE9ZbEVMSGpBaUx6bEtWVS9semN4VTJFZ1FJNitja0djcDJVNEcreXpnOTN2?=
 =?utf-8?B?eHp4dkFhV0JjSG1KZ3Nua2czVkc5dXNuSGpMRWluNFkvdFJ2RnJMUWJQZHJS?=
 =?utf-8?B?djEyb3JtdEVUbXE4OURuUWVWdkc4K3BreFRBamp1YzZSaWpDK0JVc2R1Y0ls?=
 =?utf-8?B?M3lFbFRHclRyK0wvakphYXFySEFOTmdKeTBNblQxSHRUU3dCTFora0ZxUk9M?=
 =?utf-8?B?M3JRV1FVNmZsbzQ0TjR2cU11bGhraEZIb0RDdjhrYXpJUnZuT0lxaG4zK0p1?=
 =?utf-8?B?Z0hOQThoVk5iN0hHajcyQ204b3ljN09jUlBLYUd4SmVocUxhazF5RUZPbXdh?=
 =?utf-8?B?b2Y1L1BtZ2l6Z29weWUzSHRESGwySndOUFpEOXdqMGhyTTBneDRrdHczMHhy?=
 =?utf-8?B?RkZhQmZCRUowWHF0MFNHbDdueWR4ZWxNaFlQYVpubEJ4ZWljOXpjd2VzaTJv?=
 =?utf-8?B?OG15SlBTVnpnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VEhaeEc4NGt4RkdGWkd0ajY0d2pHZFUxTmEzRmU1YjlIUlhGOGtQcFArbyty?=
 =?utf-8?B?YkRKYlpHQU9wc0VHbEk5amdRaWpEMEJjTXEwNHhiYzA4UGNaSDRXc2tyUTBx?=
 =?utf-8?B?ejR6Z0tyNThBcEp6MEZqNGlGZU42cHRUZjhnaGptaFoxcjQxbGloME9SejM4?=
 =?utf-8?B?dWlKVm1hMG92QXlYWXcyMEpYL1dzN1VySzVkL01yR1VxTUczK1FDYUhubUF0?=
 =?utf-8?B?aVQ2OGdHOVcwWUNRQlg0dml2TElBK2psQjRsRFhrSGdod0pSN3RRTER0NWRX?=
 =?utf-8?B?T1pBNG9GbXhOUEN1R3pzWm9VeGd1MXhQNithV1hVNW9lMEZoYndEdUZOa2oy?=
 =?utf-8?B?MWlISnJ3L3lsdDR4SnJDT3FJcWdiRVhVQVk4SFhkK0VzSTBQTmg2eGhlbE96?=
 =?utf-8?B?UnRUc3B3SWxMaTdOcENkcm04U3haV2dtdWVmSFlNQmhRbXFUU2VZSFBTN3U0?=
 =?utf-8?B?NUF3S2Vkdkw0Nnk4VXU3RG1pdGQzaHdzL0x0cGNxdHBONlVNTHlDV0FBQlM5?=
 =?utf-8?B?UnUxZlhMOXk4S0xLWVJ2TVFicUNudEhTNy83cWpNQlFLMWhKRjhrTitCdmVv?=
 =?utf-8?B?c0Zza3BRMktleXNJWi9Db010TVR4UkVGYzZTV3kwdWsyM1dabmlIZ2F0ZDJJ?=
 =?utf-8?B?c2g4K0pEaTNEWFA2TjR0bCs2ZE1kVEtIQ1JpU01WYVJ4V2dpNTlpMHRCVnph?=
 =?utf-8?B?Q0tpMFBTQ3JDVk05YnduMEhWdlArVS9kSDhyZXErS0cxM2R3VTRLaE1VNTQw?=
 =?utf-8?B?OFgycnJuRGVqbU1uMkNGRWRtSFM1YVhGTzE2SmJ0aGgyakJ2YkVnY0d5b3p5?=
 =?utf-8?B?cFhGV09EWVQ1NHJPa0RjTEhIYzhOZXVweWt5SHBIYUp6b1RkN0JMOFFXYVJu?=
 =?utf-8?B?b0d5VU54TEMwY2h2YTFmc1FzQ3ZnUkJEdTFQRkxSTW5oeDZCdENJOFhXd0V4?=
 =?utf-8?B?RlF5aXcvcFpmSUJnSjJMY0ZPSWNsNXo2WHd6OTUvWG5RVlE4L0xRMWE2UE1K?=
 =?utf-8?B?MGpwQmlXaUN1QVkwRjhjYTVtYU5LQUVTR1luZmJVdEg2STRkMGRGdmZmVlBX?=
 =?utf-8?B?elRRQnVtVzlpTysycEZjZ3A4azhlVjRnRWU1VWIzRGVyUlphNzZVSWN5aHhM?=
 =?utf-8?B?VFFqQ1VUWHJFclJiVHdhQnNUSnVwNklDUGl4Y0FNaG5rYW1odFh1ZGgvdDFX?=
 =?utf-8?B?ck9MVHM4Q2ttUWd6emNnR285bzhocjZ2OGVVbTkyTnVjL1RtUU03V1RXZWVR?=
 =?utf-8?B?ZTNqVmtlWGo5ODJqWkgrbVd1a0wvYTFsTlNXbmxjWVF0YStHY05xTmNuN3BY?=
 =?utf-8?B?MGpKNUd4amFTWHFIVG9yMm15NFhaVUtEWTFvalRNL3l6TU1Pbit3Slo3NGZl?=
 =?utf-8?B?RG5ETmxPZkVPeFp6WU9YbDBCWWFXQ1d3eUl0dXBrV0wwaHFjVURjZml2L3VJ?=
 =?utf-8?B?bXJZZ0Z1eUsybko3ek44WkVwRnM0SmxvaERKYkthV1BFaUlXKzlqaFowaXlG?=
 =?utf-8?B?R0dRV296M1dEd0RHV3VTTW1CR3dNUjh5UW9uNE1xcG5rSmtzZjlKVWJwdW9B?=
 =?utf-8?B?VWFyTVNMK29Vb0dUNTExQUgxejVXVkk0SWZ2cXFOSjg4akhYNnA0K3ZuVGlC?=
 =?utf-8?B?WFNIQjgzbFR0LzZiTGhEbWJDeVpRaFJhN2NoWFpON0dERno1R29LUnFOMWll?=
 =?utf-8?B?T25Fc0NzRGR4WVJESGpRd0ZaWllDU3lBNmVuT1BxeHBiYXU5bExDeUd6NWNO?=
 =?utf-8?B?SXZMa1pPNlNJZGFvNFR0N0w1aDFuTnVTM0FmV1JVd2ZBM1ZOcjVGdWtZdCt6?=
 =?utf-8?B?MWJPamhlVEk1TGZmTUx1aHdjakVNOHFhZURtZkdwYVY3NHR0VU9rb0ZkS3Rq?=
 =?utf-8?B?RklNWndVU0ZCVWY3R2lQcmpoOGFWMHM3cmhLQnpBd1VqZlZKRHVyMEMwMzRv?=
 =?utf-8?B?UmZjb1l1SXNhZUovTTg0SldmQmt2V2lvVGY4NmU5d1VwVDdMMUpYQXdlKytW?=
 =?utf-8?B?STM1cjZIZ1NkQmRReEU5TDB2UEZLd2cyQ1d5Uzl2bHhrYm50VVd6cy9jc1Fo?=
 =?utf-8?B?WnY4bDcyR1dFdjh5VWlsK24vamxZZkw5Z292VEdtdVp4RHdCZ0wwS29wSkZH?=
 =?utf-8?B?Q21LK1BqbmxGSG1SYlJidXM1OWFJZFM1YlB2WVp4clUrQk41YUlxOTladTNH?=
 =?utf-8?Q?kva/paA0x8cOGkWCeHKJrpU=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49690664-5ca2-463d-3234-08de2949fb76
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 22:04:46.1332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WSeh0QYGAMrnWcWvUNF17bI3d478/o3475KZ6myB1V4QVxD9jBf49yVX51AJ0TzsMc/FU/eL/982wsB36uE/Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR15MB5571
X-Proofpoint-ORIG-GUID: 5xGF9AjkJw9is5Puo_tig39ifJ7T1nqA
X-Authority-Analysis: v=2.4 cv=Rv3I7SmK c=1 sm=1 tr=0 ts=6920e201 cx=c_pps
 a=7NJmVDyNEcEWmOhjwSrRAw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=NEAV23lmAAAA:8 a=P-IC7800AAAA:8 a=hSkVLCK3AAAA:8
 a=drOt6m5kAAAA:8 a=8XEQmAjMHqDbZIU0KfYA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=d3PnA9EDa4IxuAV0gXij:22 a=cQPPKAXgyycSBL8etih5:22
 a=RMMjzBEyIzXRtoq5n5K6:22
X-Proofpoint-GUID: nETok3rcXpLB_7_dua__tpyGQ2tAo-t1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX2H8+UILwYaXd
 bD4Rr8bddAXUqSkT2zcYQ181p2CEv6LWwEaWRjVPycEPgSbWu+R3LD5mC0/zwvCotbFo25mLddt
 kwt6UZ4VI+8N4yvd0BDOQZumu+MtPNyTEMOfoR5kok+BwVqA7HOFh/sutjRI6HB3EuE4scxO6Rf
 t/oRNFBHLAiN+RIdxTtmKcPopa3dXd2CyJGeUfX6JVeKTMmVP33ojz2HYgK7YQIKFGTN4Nv0pHE
 eXKT+xOQvCHSogClKLHrGNDGjIRwpg5J7J5P51A8pq2Mh9n3klQXQsGoRA9zKF4Nv3v9ElU/p+V
 r56w/xHYMNmyD1zbUWrPRAVmlZoJZtqkt4syzbS7Ehc4mcYiZAaqDCFBO8HYg+os1IShtA85tao
 pIAUeu1pNAUPZdd7IkFm5Q8btPC/Kw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <711B7E0FBC193D479536D624BE2BE10C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v2] fs/hfs: fix s_fs_info leak on setup_bdev_super()
 failure
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_06,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2510240000 definitions=main-2511150032

On Fri, 2025-11-21 at 23:48 +0100, Mehdi Ben Hadj Khelifa wrote:
> On 11/21/25 10:15 PM, Viacheslav Dubeyko wrote:
> > On Fri, 2025-11-21 at 20:44 +0100, Mehdi Ben Hadj Khelifa wrote:
> > > On 11/19/25 8:58 PM, Viacheslav Dubeyko wrote:
> > > > On Wed, 2025-11-19 at 08:38 +0100, Mehdi Ben Hadj Khelifa wrote:
> > > > > The regression introduced by commit aca740cecbe5 ("fs: open block=
 device
> > > > > after superblock creation") allows setup_bdev_super() to fail aft=
er a new
> > > > > superblock has been allocated by sget_fc(), but before hfs_fill_s=
uper()
> > > > > takes ownership of the filesystem-specific s_fs_info data.
> > > > >=20
> > > > > In that case, hfs_put_super() and the failure paths of hfs_fill_s=
uper()
> > > > > are never reached, leaving the HFS mdb structures attached to s->=
s_fs_info
> > > > > unreleased.The default kill_block_super() teardown also does not =
free
> > > > > HFS-specific resources, resulting in a memory leak on early mount=
 failure.
> > > > >=20
> > > > > Fix this by moving all HFS-specific teardown (hfs_mdb_put()) from
> > > > > hfs_put_super() and the hfs_fill_super() failure path into a dedi=
cated
> > > > > hfs_kill_sb() implementation. This ensures that both normal unmou=
nt and
> > > > > early teardown paths (including setup_bdev_super() failure) corre=
ctly
> > > > > release HFS metadata.
> > > > >=20
> > > > > This also preserves the intended layering: generic_shutdown_super=
()
> > > > > handles VFS-side cleanup, while HFS filesystem state is fully des=
troyed
> > > > > afterwards.
> > > > >=20
> > > > > Fixes: aca740cecbe5 ("fs: open block device after superblock crea=
tion")
> > > > > Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
> > > > > Closes: https://syzkaller.appspot.com/bug?extid=3Dad45f827c88778f=
f7df6 =20
> > > > > Tested-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
> > > > > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > > > > Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail=
.com>
> > > > > ---
> > > > > ChangeLog:
> > > > >=20
> > > > > Changes from v1:
> > > > >=20
> > > > > -Changed the patch direction to focus on hfs changes specifically=
 as
> > > > > suggested by al viro
> > > > >=20
> > > > > Link:https://lore.kernel.org/all/20251114165255.101361-1-mehdi.be=
nhadjkhelifa@gmail.com/ =20
> > > > >=20
> > > > > Note:This patch might need some more testing as I only did run se=
lftests
> > > > > with no regression, check dmesg output for no regression, run rep=
roducer
> > > > > with no bug and test it with syzbot as well.
> > > >=20
> > > > Have you run xfstests for the patch? Unfortunately, we have multipl=
e xfstests
> > > > failures for HFS now. And you can check the list of known issues he=
re [1]. The
> > > > main point of such run of xfstests is to check that maybe some issu=
e(s) could be
> > > > fixed by the patch. And, more important that you don't introduce ne=
w issues. ;)
> > > >=20
> > > I have tried to run the xfstests with a kernel built with my patch and
> > > also without my patch for TEST and SCRATCH devices and in both cases =
my
> > > system crashes in running the generic/631 test.Still unsure of the
> > > cause. For more context, I'm running the tests on the 6.18-rc5 version
> > > of the kernel and the devices and the environment setup is as follows:
> > >=20
> > > For device creation and mounting(also tried it with dd and had same
> > > results):
> > > fallocate -l 10G test.img
> > > fallocate -l 10G scratch.img
> > > sudo mkfs.hfs test.img
> > > sudo losetup /dev/loop0 ./test.img
> > > sudo losetup /dev/loop1 ./scratch.img
> > > sudo mkdir -p /mnt/test /mnt/scratch
> > > sudo mount /dev/loop0 /mnt/test
> > >=20
> > > For environment setup(local.config):
> > > export TEST_DEV=3D/dev/loop0
> > > export TEST_DIR=3D/mnt/test
> > > export SCRATCH_DEV=3D/dev/loop1
> > > export SCRATCH_MNT=3D/mnt/scratch
> >=20
> > This is my configuration:
> >=20
> > export TEST_DEV=3D/dev/loop50
> > export TEST_DIR=3D/mnt/test
> > export SCRATCH_DEV=3D/dev/loop51
> > export SCRATCH_MNT=3D/mnt/scratch
> >=20
> > export FSTYP=3Dhfs
> >=20
> Ah, Missed that option. I will try with that in my next testing.
> > Probably, you've missed FSTYP. Did you tried to run other file system a=
t first
> > (for example, ext4) to be sure that everything is good?
> >=20
> No, I barely squeezed in time today to the testing for the HFS so I=20
> didn't do any preliminary testing but I will check that too my next run=20
> before trying to test HFS.
> > >=20
> > > Ran the tests using:sudo ./check -g auto
> > >=20
> >=20
> > You are brave guy. :) Currently, I am trying to fix the issues for quic=
k group:
> >=20
> > sudo ./check -g quick
> >=20
> I thought I needed to do a more exhaustive testing so I went with auto.=20
> I will try to experiment with quick my next round of testing. Thanks for=
=20
> the heads up!
> > > If more context is needed to know the point of failure or if I have m=
ade
> > > a mistake during setup I'm happy to receive your comments since this =
is
> > > my first time trying to run xfstests.
> > >=20
> >=20
> > I don't see the crash on my side.
> >=20
> > sudo ./check generic/631
> > FSTYP         -- hfs
> > PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.18.0-rc3+ #96 SMP
> > PREEMPT_DYNAMIC Wed Nov 19 12:47:37 PST 2025
> > MKFS_OPTIONS  -- /dev/loop51
> > MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch
> >=20
> > generic/631       [not run] attr namespace trusted not supported by this
> > filesystem type: hfs
> > Ran: generic/631
> > Not run: generic/631
> > Passed all 1 tests
> >=20
> > This test simply is not running for HFS case.
> >=20
> > I see that HFS+ is failing for generic/631, but I don't see the crash. =
I am
> > running 6.18.0-rc3+ but I am not sure that 6.18.0-rc5+ could change som=
ething
> > dramatically.
> >=20
> > My guess that, maybe, xfstests suite is trying to run some other file s=
ystem but
> > not HFS.
> >=20
> I'm assuming that it's running HFSPLUS testing foir me because I just=20
> realised that the package that I downloaded to do mkfs.hfs is just a=20
> symlink to mkfs.hfsplus. Also I didn't find a package(in arch) for=20
> mkfs.hfs in my quick little search now. All refer to mkfs.hfsplus as if=20
> mkfs.hfs is deprecated somehow. I will probably build it from source if=20
> available with fsck.hfs... Eitherway, even if i was testing for HFSPLUS=20
> i don't think that a fail on generic/631 would crash my system multiple=20
> times with different kernels. I would have to test with ext4 before and=20
> play around more to find out why that happened..

The mkfs.hfs is symlink on mkfs.hfsplus and the same for fsck. The mkfs.hfs=
plus
can create HFS volume by using this option:

-h create an HFS format filesystem (HFS Plus is the default)

I don't have any special package installed for HFS on my side.

Thanks,
Slava.

> > > > >=20
> > > > >    fs/hfs/super.c | 16 ++++++++++++----
> > > > >    1 file changed, 12 insertions(+), 4 deletions(-)
> > > > >=20
> > > > > diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> > > > > index 47f50fa555a4..06e1c25e47dc 100644
> > > > > --- a/fs/hfs/super.c
> > > > > +++ b/fs/hfs/super.c
> > > > > @@ -49,8 +49,6 @@ static void hfs_put_super(struct super_block *s=
b)
> > > > >    {
> > > > >    	cancel_delayed_work_sync(&HFS_SB(sb)->mdb_work);
> > > > >    	hfs_mdb_close(sb);
> > > > > -	/* release the MDB's resources */
> > > > > -	hfs_mdb_put(sb);
> > > > >    }
> > > > >   =20
> > > > >    static void flush_mdb(struct work_struct *work)
> > > > > @@ -383,7 +381,6 @@ static int hfs_fill_super(struct super_block =
*sb, struct fs_context *fc)
> > > > >    bail_no_root:
> > > > >    	pr_err("get root inode failed\n");
> > > > >    bail:
> > > > > -	hfs_mdb_put(sb);
> > > > >    	return res;
> > > > >    }
> > > > >   =20
> > > > > @@ -431,10 +428,21 @@ static int hfs_init_fs_context(struct fs_co=
ntext *fc)
> > > > >    	return 0;
> > > > >    }
> > > > >   =20
> > > > > +static void hfs_kill_sb(struct super_block *sb)
> > > > > +{
> > > > > +	generic_shutdown_super(sb);
> > > > > +	hfs_mdb_put(sb);
> > > > > +	if (sb->s_bdev) {
> > > > > +		sync_blockdev(sb->s_bdev);
> > > > > +		bdev_fput(sb->s_bdev_file);
> > > > > +	}
> > > > > +
> > > > > +}
> > > > > +
> > > > >    static struct file_system_type hfs_fs_type =3D {
> > > > >    	.owner		=3D THIS_MODULE,
> > > > >    	.name		=3D "hfs",
> > > > > -	.kill_sb	=3D kill_block_super,
> >=20
> > I've realized that if we are trying to solve the issue with pure call of
> > kill_block_super() for the case of HFS/HFS+, then we could have the sam=
e trouble
> > for other file systems. It make sense to check that we do not have like=
wise
> > trouble for: bfs, hpfs, fat, nilfs2, ext2, ufs, adfs, omfs, isofs, udf,=
 minix,
> > jfs, squashfs, freevxfs, befs.
> While I was doing my original fix for hfs, I did notice that too. Many=20
> other filesystems(not all) don't have a "custom" super block destroyer=20
> and they just refer to the generic kill_block_super() function which=20
> might lead to the same problem as HFS and HFS+. That would more digging=20
> too. I will see what I can do next when we finish HFS and potentially=20
> HFS+ first.
> >=20
> > > >=20
> > > > It looks like we have the same issue for the case of HFS+ [2]. Coul=
d you please
> > > > double check that HFS+ should be fixed too?
> > > >=20
> > > I have checked the same error path and it seems that hfsplus_sb_info =
is
> > > not freed in that path(I could provide the exact call stack which wou=
ld
> > > cause such a memory leak) although I didn't create or run any
> > > reproducers for this particular filesystem type.
> > > If you would like a patch for this issue, would something like what is
> > > shown below be acceptable? :
> > >=20
> > > +static void hfsplus_kill_super(struct super_block *sb)
> > > +{
> > > +       struct hfsplus_sb_info *sbi =3D HFSPLUS_SB(sb);
> > > +
> > > +       kill_block_super(sb);
> > > +       kfree(sbi);
> > > +}
> > > +
> > >    static struct file_system_type hfsplus_fs_type =3D {
> > >           .owner          =3D THIS_MODULE,
> > >           .name           =3D "hfsplus",
> > > -       .kill_sb        =3D kill_block_super,
> > > +       .kill_sb        =3D hfsplus_kill_super,
> > >           .fs_flags       =3D FS_REQUIRES_DEV,
> > >           .init_fs_context =3D hfsplus_init_fs_context,
> > >    };
> > >=20
> > > If there is something to add, remove or adjust. Please let me know in
> > > the case of you willing accepting such a patch of course.
> >=20
> > We call hfs_mdb_put() for the case of HFS:
> >=20
> > void hfs_mdb_put(struct super_block *sb)
> > {
> > 	if (!HFS_SB(sb))
> > 		return;
> > 	/* free the B-trees */
> > 	hfs_btree_close(HFS_SB(sb)->ext_tree);
> > 	hfs_btree_close(HFS_SB(sb)->cat_tree);
> >=20
> > 	/* free the buffers holding the primary and alternate MDBs */
> > 	brelse(HFS_SB(sb)->mdb_bh);
> > 	brelse(HFS_SB(sb)->alt_mdb_bh);
> >=20
> > 	unload_nls(HFS_SB(sb)->nls_io);
> > 	unload_nls(HFS_SB(sb)->nls_disk);
> >=20
> > 	kfree(HFS_SB(sb)->bitmap);
> > 	kfree(HFS_SB(sb));
> > 	sb->s_fs_info =3D NULL;
> > }
> >=20
> > So, we need likewise course of actions for HFS+ because we have multiple
> > pointers in superblock too:
> >=20
> IIUC, hfs_mdb_put() isn't called in the case of hfs_kill_super() in=20
> christian's patch because fill_super() (for the each specific=20
> filesystem) is responsible for cleaning up the superblock in case of=20
> failure and you can reference christian's patch[1] which he explained=20
> the reasoning for here[2].And in the error path the we are trying to=20
> fix, fill_super() isn't even called yet. So such pointers shouldn't be=20
> pointing to anything allocated yet hence only freeing the pointer to the=
=20
> sb_info here is sufficient I think.
> [1]:https://github.com/brauner/linux/commit/058747cefb26196f3c192c76c6310=
51581b29b27 =20
> [2]:https://lore.kernel.org/all/20251119-delfin-bioladen-6bf291941d4f@bra=
uner/ =20
> > struct hfsplus_sb_info {
> > 	void *s_vhdr_buf;
> > 	struct hfsplus_vh *s_vhdr;
> > 	void *s_backup_vhdr_buf;
> > 	struct hfsplus_vh *s_backup_vhdr;
> > 	struct hfs_btree *ext_tree;
> > 	struct hfs_btree *cat_tree;
> > 	struct hfs_btree *attr_tree;
> > 	atomic_t attr_tree_state;
> > 	struct inode *alloc_file;
> > 	struct inode *hidden_dir;
> > 	struct nls_table *nls;
> >=20
> > 	/* Runtime variables */
> > 	u32 blockoffset;
> > 	u32 min_io_size;
> > 	sector_t part_start;
> > 	sector_t sect_count;
> > 	int fs_shift;
> >=20
> > 	/* immutable data from the volume header */
> > 	u32 alloc_blksz;
> > 	int alloc_blksz_shift;
> > 	u32 total_blocks;
> > 	u32 data_clump_blocks, rsrc_clump_blocks;
> >=20
> > 	/* mutable data from the volume header, protected by alloc_mutex */
> > 	u32 free_blocks;
> > 	struct mutex alloc_mutex;
> >=20
> > 	/* mutable data from the volume header, protected by vh_mutex */
> > 	u32 next_cnid;
> > 	u32 file_count;
> > 	u32 folder_count;
> > 	struct mutex vh_mutex;
> >=20
> > 	/* Config options */
> > 	u32 creator;
> > 	u32 type;
> >=20
> > 	umode_t umask;
> > 	kuid_t uid;
> > 	kgid_t gid;
> >=20
> > 	int part, session;
> > 	unsigned long flags;
> >=20
> > 	int work_queued;               /* non-zero delayed work is queued */
> > 	struct delayed_work sync_work; /* FS sync delayed work */
> > 	spinlock_t work_lock;          /* protects sync_work and work_queued */
> > 	struct rcu_head rcu;
> > };
> >=20
>=20
>=20
> > Thanks,
> > Slava.
> >=20
> Best Regards,
> Mehdi Ben Hadj Khelifa
>=20
> > >=20
> > > > > +	.kill_sb	=3D hfs_kill_sb,
> > > > >    	.fs_flags	=3D FS_REQUIRES_DEV,
> > > > >    	.init_fs_context =3D hfs_init_fs_context,
> > > > >    };
> > > >=20
> > > > [1] https://github.com/hfs-linux-kernel/hfs-linux-kernel/issues =20
> > > > [2] https://elixir.bootlin.com/linux/v6.18-rc6/source/fs/hfsplus/su=
per.c#L694 =20

