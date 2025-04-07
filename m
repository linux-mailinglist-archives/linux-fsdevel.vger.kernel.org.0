Return-Path: <linux-fsdevel+bounces-45861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA37A7DC13
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 13:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205C23AFAF1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 11:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16A623AE83;
	Mon,  7 Apr 2025 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyberus-technology.de header.i=@cyberus-technology.de header.b="o/DkYWjM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020088.outbound.protection.outlook.com [52.101.171.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D85B22155E;
	Mon,  7 Apr 2025 11:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744024772; cv=fail; b=ilJBBZZaV9tZWfU/9gcZWjBJRdD51Naz5+KqNEl8V+q1wS7p/mlMI7jKjvVDtMIPwBOAd7L277Wpba8GQnQB3AS/YxlKksUNfgjgOpjI4y+lfN+pFvm9evzp4nkineLxpRZXzoQjKd8al5bZGM7kIgurbCo0Tdac4Y/vJa+ZH9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744024772; c=relaxed/simple;
	bh=jPHHCJAKdDtuYirkbtmhw6PHtExaEnYLqwpT1u5kljI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cH5iGYHMGUEN6XbHfw/YMSdmPIKfI/IgBtHr5C+YO8RqHeC3dMWaVKcLyfEBds9NrpiTswn7KYvmUjelPnEi/EQ6UZP1XtC2FzhLNNiROpAGhgM1pWfyi7fJoNj+f9sBCJcMSMp3IstyDfu+sRRCHi5bO6rWddtymbE/PHYy740=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cyberus-technology.de; spf=pass smtp.mailfrom=cyberus-technology.de; dkim=pass (2048-bit key) header.d=cyberus-technology.de header.i=@cyberus-technology.de header.b=o/DkYWjM; arc=fail smtp.client-ip=52.101.171.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cyberus-technology.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberus-technology.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgP2VeoPVV2PiynTMoApdtYr1oesOaEYRQVkiH08pK8p2WVhno3K+6lYVQHKqkzvmq/BzTOH4R6CQBpKuMuzHAXYnVe+C5an+jkNAegSJzxprafM+mmKst1NutsurtlPAO+f7SjiHdoode9qVPu4prBmYrpdmv+BgD1OV72Cc01tXR59F0LmpALZaT+HOnAJVvr5tMVqamvWzT/NOZ5lvTs/Nrm6QhyeF84brMbK1cRNYUxu3ZtL0SqxvfW+OcrszPZ6SxfiimLdC2JnWIdvIR+44hSWLXOPvH+bcScLUlvz1MfPRTMsyQBu/9URmu5gfVdth9xrSKz5kRHC60QPhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPHHCJAKdDtuYirkbtmhw6PHtExaEnYLqwpT1u5kljI=;
 b=jSeUL9SSyJd2JFyoeAGpV/xNE7OB6PgSIACoI4SzkKg2a8W5CSdLDZ5fwVePhTvAcyH4TqKRLJ6e6CCBF1GRSbgZNYVLBwLphhF61eB/jTm/o4BJTCnMfu1g8ZGaQd1+i3UUXchAUnSOKpUhakaZxi5gF6KCMGCxA+g7Il0KVVtemzhA86K+0t6xxKzL9Ah+F2r49o81t0Hl4NhfBeJ6okgfaNGcLsbIS9nNGa/wBcOtmsTOeAiEIqpkd4hSOD1uQ3+1XA+4p2gNlPSbpGEH6+Bt4vCAu75OQFjoQT2Y6aFCCLnF26C/yr6/K0XXLAP4NrclmMTe7LFD+Pi+uvm8Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cyberus-technology.de; dmarc=pass action=none
 header.from=cyberus-technology.de; dkim=pass header.d=cyberus-technology.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberus-technology.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPHHCJAKdDtuYirkbtmhw6PHtExaEnYLqwpT1u5kljI=;
 b=o/DkYWjMJw4xACyCDHfLfF38vJTn81gFivyk8yDBmj/nJ0Z5bLxNFrdGWiihv5M8h0mQBXa7a9tsV0T79HTDSimV8LOW/ZryosELLDiM69kuKDaaTx5a5reaNo2v2809W80oFEkswOhIwbSlPKWM6MgC68AjcejDZNN14cGJh9q/kWRah1jUFuoiI+q/fysWuGkIE5KxJjewY6+ovNvUuVaKXpgLwEiR+tQuuvfUB01+8Ipe05W30lf36iDCObQ55cdK7ppfkXP73vegy/nDhsjhODYGgFcYnnCpQgNyYSexNJ5aHsGzF8lmG4gxs7ONaitipBw7TcZZrHpu+bNf4w==
Received: from FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:38::7) by
 BEUP281MB3414.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:9e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.34; Mon, 7 Apr 2025 11:19:27 +0000
Received: from FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM
 ([fe80::bf0d:16fc:a18c:c423]) by FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM
 ([fe80::bf0d:16fc:a18c:c423%5]) with mapi id 15.20.8606.033; Mon, 7 Apr 2025
 11:19:27 +0000
From: Julian Stecklina <julian.stecklina@cyberus-technology.de>
To: "hch@lst.de" <hch@lst.de>
CC: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "hsiangkao@linux.alibaba.com"
	<hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] initrd: support erofs as initrd
Thread-Topic: [PATCH] initrd: support erofs as initrd
Thread-Index: AQHbmc5FhigEqeqdAEenfkqes+M237N9CO4AgAAHcoCAAINRgIAabvuAgAAnjwA=
Date: Mon, 7 Apr 2025 11:19:27 +0000
Message-ID:
 <a1c9c97458a86e35df3f6626c9b7c8be4448a9f0.camel@cyberus-technology.de>
References: <20250320-initrd-erofs-v1-1-35bbb293468a@cyberus-technology.de>
		 <20250321050114.GC1831@lst.de>
		 <582bc002-f0c8-4dbb-8fa5-4c10a479b518@linux.alibaba.com>
		 <933797c385f2e222ade076b3e8fc5810fa47f5bd.camel@cyberus-technology.de>
	 <20250407085751.GA27074@lst.de>
In-Reply-To: <20250407085751.GA27074@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cyberus-technology.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2P281MB2329:EE_|BEUP281MB3414:EE_
x-ms-office365-filtering-correlation-id: 2f1c232e-4014-4c63-596c-08dd75c60efc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VmZ2S0xCZDU4STdKUmdrODNPT2I3WHVPNjVjTEUzUEt0N2s2UXZYd09tSkFy?=
 =?utf-8?B?c0x0MmhtWWFZNWRvcXdzVWRBQTF3QlYwdjZ6TWtKMEl6Q0ZHVjVKV2VBMllj?=
 =?utf-8?B?Rkh6dXEzS1owSncwZ0ZxQjIwZnZ3WUJqaEs5WkUwVDNSMnNYSGdxTVNyZDAr?=
 =?utf-8?B?S2w4OHUwbTRTUlE3QkNnU1c2SER5bEhrb2ttaGhSam55dWpuZEdsZnAvUUlE?=
 =?utf-8?B?QmhOVGdhRVpFVEFwaHFsMmRSbVhQSDRjTEJlc2lVbWViYjJHckt2K1ZqV1Y0?=
 =?utf-8?B?WU1WZzFyWE43TzdORlJaMEFtaU12UnErOVEwL0gvQ1BGdlpRNWZ6YUp3SHJo?=
 =?utf-8?B?S0hqNXlvMVlIb2JDVzh5QUZtd3V4bWVWTHNYQm02a2ZpUmFnZXFIS04ySVdl?=
 =?utf-8?B?MnIrS0xVeGk5NjRONGVUWWxUTHdvbFRpdThjWkRFWkhTQm40Rmg1eHZkOHAw?=
 =?utf-8?B?U3BlSy9QTy9SUEhTTnBzejkyZ3ZNV0NKeGhtTk5UMERGL282TDRQL1lNT010?=
 =?utf-8?B?TTNYU3JhUU5mOFg3eHpMOUw3aHo1eC9hTkwvSUIzbm5TUWZwWm1hbTlDbENp?=
 =?utf-8?B?NUQrM2N0ZjZ1M1gzL24yYyt0My9pNFZlYVFFTmk5VFpkeW1sQWNEOG95b3Ew?=
 =?utf-8?B?amJMdEdkdW1ubEJtYjd0dzI2MGdueXVsd1pGdFc4MzY5TjlUVzNBaEovdnl6?=
 =?utf-8?B?cGpOaE1HTWlLY0h1bzlFbVpSWldxMlNMMXZac0dFQytqaE5IL0tDTy84OVVE?=
 =?utf-8?B?UUpQSzhSUmFvMzMvVnQwNGJPODQ4MitDdlAxMjRYdEJvMlA0V2tkSWxySUFk?=
 =?utf-8?B?ZnR1eGlBNTM0K0dUS3FzelRXR0prSlpMRXVBZWx1Q0VEejMvME9VOHZGajdT?=
 =?utf-8?B?TGlJUnp4WnQvTlNSOE1xaExzOGRSbTFPUWhzY2Y2RHJRZEQ1WisvbVdGWmo2?=
 =?utf-8?B?THo1K1ArbWJJQytHblErSnN1UzYxU2RieDB4dTlDZGFudTBySHJCRUtNNXNm?=
 =?utf-8?B?Yk5pVHJOaFJKTnpNcU1lejZnRGJyWkFraHVLMWpZMnh3Z0h3NElSUmJIbkdx?=
 =?utf-8?B?a1RpY3V0QWZiYnQ1SExKajgxZXErbkdva1AvUTZIUjVDT2Y0RHo0b21MSHJQ?=
 =?utf-8?B?cXF0VENXSzdxSGRveDJmcGVNVHN1QjJSSUNqRVhhNEJkdU5DR0ZtMVZzMys0?=
 =?utf-8?B?dWsxSTFrTUtwVkxtZkdBbW1RV2V0VmRzUGJ1cytJcE0rcnJZZjZ3cGJuYmcr?=
 =?utf-8?B?QW92Z3Rhd2dxbVhqenNBWkJCaEE3dFpuZ0hOUXJWN0RzSFdOVnpzL1ozZGxk?=
 =?utf-8?B?aFZiQ3pxMHBveE9Wb3llV2Y0NkRXNWpXbmFSSkNYQ2c5Nm8xaWZFd1NlNjZR?=
 =?utf-8?B?dGJ6OG16TXlYMGFQQjRmYjJRcDlnUEM5bi9UNnZtRHh5ZFBQWlRhRUZFSXhJ?=
 =?utf-8?B?aUxTSEpzZ3pKaDNVTnZGK3pVV2I4ZXBPcGVGRW9vVCtVN2RHekduV09VWmxx?=
 =?utf-8?B?RjJkUFRHQnN0MFZ0VmZTazVSZkxJS0NrLy9xdmpWNUNsSHZQQVFocWpLM3J5?=
 =?utf-8?B?bU1uWUw4NSt1NVU3VWdrOWFTMWdhU1BqR0xtbE4rUDVZaGJFNXZmQkJoanhy?=
 =?utf-8?B?d0MxZENkZ0pSUXVIMVhCcVh4aHdVNWxHQWpReHJ2VWJHa0lxZ016K0xwK3g4?=
 =?utf-8?B?R2FEVksrNVF2cG9hV091WDUzTWNCa0lLSTUrSThBa0hkdnpqMWF0dlRLREhL?=
 =?utf-8?B?eldaUWx6VFBQZGNKNzJwTUF2RUNvY3FlYlB1eWpDTDE1QnVpeWJzbFNKYWRl?=
 =?utf-8?B?SjJvUElDS093ZGgrcFhoVHVxZTV3dFZMdTlDbGlTWms5NTBjYXpRVkc4TkFy?=
 =?utf-8?B?VGd5RE1WN001NEdsZDhMWlkwUFkzbnQ5TUV3V21jajZweHA1dDBmKzM2VEtX?=
 =?utf-8?B?OW5PTkhmZ1poRG9WTUczUmJ1elQzTkNORTZBbFB4WjJEdUgyUVdyOEtGcThX?=
 =?utf-8?Q?2r4E+LydHSuIby9VcfX0GvY8TAqjVc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGxvV3JxZFhscmpPallXdmxSUjV4U29sMHhyS1NhcjRVNHpBUEh4MVV4R2dI?=
 =?utf-8?B?TDN0RTgvTVR0elJvY0lTT1FxS1diZHd6TVd4K05EbU02RVBKWDhNSG9xTHJh?=
 =?utf-8?B?QWJzNW1jN3hMNjU2WWRaTXZuWjdPWkZ1MlUrL0ZNc0prS0RpU0R2aGhyRDAv?=
 =?utf-8?B?MExmTWpwVWlDaW9zMkd1a0FsempvVDVuZkt4RjZMQkVVckl4Q1pHZXNZNzA1?=
 =?utf-8?B?c1lvRFpwUEcyR1FQTXd4dTlzUjlvMm8xUEdXcFNlQ1pHK0MrMjg1NEN1aklQ?=
 =?utf-8?B?VnNiY2hRY29SUXRDa3gwL2VQTEs5dHNPOEQwaHNhWE9zSFY3OWRxNjNubk9W?=
 =?utf-8?B?REtiQzFXOFRueXN0ekJydnN3OTdlWG5UUmNnTVpQbDBtbEV6cWIwaE9nU2xy?=
 =?utf-8?B?OWxMRWhvRVVQSnY0dGlDSGJlVkd2UGJPRjhOeUFYbk0wbnpoUndhUW8rOHhX?=
 =?utf-8?B?MmxYaXYwU1dWeEJBR1RIQXdKakRwUEFpcnJOMjQxdEZBTkJSY2E5SjNtZUc4?=
 =?utf-8?B?Tit4cUhRTnFsbVlNVWN1K1F2ODFLZEhuakN1NjN0UzhtQ2NOeS85WUJMMFpX?=
 =?utf-8?B?T3YzakV5WVB1WlJQa0hPTkU0ZVVPaitXS1JhUENtTW04bTBSd3RWNXpMVTZk?=
 =?utf-8?B?YXVaRURGMnR1eDJyWUcyVm5qQ0lDNTlvaFZpallIbGEwRlNSLzM1NVd3aTB2?=
 =?utf-8?B?eDBDNjhIdEVvOThFcTRGaGxDMEVLTSs4TDgxZW1HcjR1L0g4cDYySTNDczA3?=
 =?utf-8?B?aVBWWUM3amJpYlY0R1oxVDNwMXpjTzkzZUZtdVJtMFlYNnNTUllxTGhteWpi?=
 =?utf-8?B?cjN3MEZ4TWNaN3VhekovYmdVZW1aSTlwTTBYV0VVNjQwNVNFcVJUcWJ4NjhJ?=
 =?utf-8?B?K3dBZ25nbnNrUkNYVTcrVFk2bGJlR1phWElMLzZsTHdUSWRqWi90dXhQa3RX?=
 =?utf-8?B?UFlPZ3k2aVJVT0Y0TXo4RXRyKzhCRXVSdTRJNGdEQUNCR0Y0Z3RWckhRZ2ta?=
 =?utf-8?B?Ym1HeVBsZ05mbXRrdUljZktJMVduT3lNVTFtOElsSFpmQWJyUTFUajRvRkxQ?=
 =?utf-8?B?S29Pc2pqSm1YOUF1ZXl6OUVPUzFIMituVlg0ay9TN1R0SGt4YVBYSGlReXFj?=
 =?utf-8?B?QjdvMXVJeHFFVXJhV0JwQ0tzWGtnejI4QVRhT3lpa3FUczUzNzdrOGpUUlR0?=
 =?utf-8?B?blc4eXFpanNMSnpOTnRETW5GdnRwUjBqNE5jSjlmS0M2aTNKMm45MENwK1lB?=
 =?utf-8?B?a3JCUitEYXkyai9VZGR2eEMvSUxXSHJDQ2J2ZXhWZW5Oam1lV3VnZ1BaTU1P?=
 =?utf-8?B?QkFiMU8xWUVSN3ljdURTL1VJd05XU2FFa25pUTlzWWtNV2x1dWdNVzE5VU5a?=
 =?utf-8?B?U3p4WW1UQ2tNd3piYUw2azZPNE1yQVBjazM4MzV0OEtRTnFXM2FVd2ptNjha?=
 =?utf-8?B?OFl3UFN4MEcwYVdxbEhVTjhMTkplYUNEcDkzdlhlTU03VDBTdVM0SmMwdjBw?=
 =?utf-8?B?bjN1Q3FIbWdlRDdRUVRZQjFTS3hVQjZnMEk3M01JdHdVMmR1TjRGZTJCZjA0?=
 =?utf-8?B?Z2QvWnVHMkZXZ0dwWkFLc2tiWFJoT0VKWUVJc0JRNzVrOTM3dEhScHNUb3hJ?=
 =?utf-8?B?NG9vNk51WFVsaXUwZ090NktPQm9qL0haWjZDOUszZUFJZ0JLZWlpQktwY1J0?=
 =?utf-8?B?WjUxcXFVbFB4WmJkQjFxSGVTS1NwajlBQW5JRmRkTDhRUWUzbUNXN3JzOWFm?=
 =?utf-8?B?YXp5aCtOV2FUYlpjUm8vYUdESHZ2cDg3L2NhMC9WdXdtYmloZWtaODJaNEh0?=
 =?utf-8?B?WTVQSnIxVk95YTI3ZEVlQ2hwdkpuNGtJMEIzZzhQcFJTT1BhanBBcDFaRU45?=
 =?utf-8?B?aVphNSthemI0OGNBR0JmSlZuTitkc2YrRExLWEJ5d01sbytsWGY0QVFZQ3F3?=
 =?utf-8?B?c3BDT091ei9jbXJNZmdqZTF2Y0pWeUZreDdIR2poam90Q3BPMlFiVW5MSGRn?=
 =?utf-8?B?TVNpbjlzeGc3dXI3bWVsMkdCODlib1J6eVB1VjI3eVZaYkQwb2xHd01VN2NQ?=
 =?utf-8?B?UzdhQURTaUp4dlFVNUp3L2lyekQ4MzNTbndyL1h5cVJlNmxJRyt6Q2pyWENR?=
 =?utf-8?B?ZXYxTUZCblFMS1YvRVpKNU5ZV3lxYUpyY2dCNC90RWxQaFVQaUxoL1hHUThR?=
 =?utf-8?Q?KLXFydY3FqvhcHd0naIqZX40ublJFfwPLRqrzx07HIeR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8954341400CC7428E1D4DC13CF1B614@DEUP281.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1c232e-4014-4c63-596c-08dd75c60efc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 11:19:27.1301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f4e0f4e0-9d68-4bd6-a95b-0cba36dbac2e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +EsRh76Oc+Ur23wQSmZMlAwl7ymIQyfn31Sq43d5OwDB/SMvLvcwHBna/cP9o5fDWCOy35S6w1ngAuncU9vbrclscbj5hZcNBmPqrHlZcl2ArhhWN8uZYZVpsricXSz8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEUP281MB3414

SGkhDQoNCk9uIE1vbiwgMjAyNS0wNC0wNyBhdCAxMDo1NyArMDIwMCwgaGNoQGxzdC5kZSB3cm90
ZToNCj4gT24gRnJpLCBNYXIgMjEsIDIwMjUgYXQgMDE6MTc6NTRQTSArMDAwMCwgSnVsaWFuIFN0
ZWNrbGluYSB3cm90ZToNCj4gPiBPZiBjb3Vyc2UgdGhlcmUgYXJlIHNvbWUgc29sdXRpb25zIHRv
IHVzaW5nIGVyb2ZzIGltYWdlcyBhdCBib290IG5vdzoNCj4gPiBodHRwczovL2dpdGh1Yi5jb20v
Y29udGFpbmVycy9pbml0b3ZlcmxheWZzDQo+ID4gDQo+ID4gQnV0IHRoaXMgYWRkcyB5ZXQgYW5v
dGhlciBzdGVwIGluIHRoZSBhbHJlYWR5IGNvbXBsZXggYm9vdCBwcm9jZXNzIGFuZCBmZWVscw0K
PiA+IGxpa2UgYSBoYWNrLiBJdCB3b3VsZCBiZSBuaWNlIHRvIGp1c3QgdXNlIGVyb2ZzIGltYWdl
cyBhcyBpbml0cmQuIFRoZSBvdGhlcg0KPiA+IGJ1aWxkaW5nIGJsb2NrIHRvIHRoaXMgaXMgYXV0
b21hdGljYWxseSBzaXppbmcgL2Rldi9yYW0wOg0KPiA+IA0KPiA+IGh0dHBzOi8vbGttbC5vcmcv
bGttbC8yMDI1LzMvMjAvMTI5Ng0KPiA+IA0KPiA+IEkgZGlkbid0IHBhY2sgYm90aCBwYXRjaGVz
IGludG8gb25lIHNlcmllcywgYmVjYXVzZSBJIHRob3VnaHQgZW5hYmxpbmcgZXJvZnMNCj4gPiBp
dHNlbGYgd291bGQgYmUgbGVzcyBjb250cm92ZXJzaWFsIGFuZCBpcyBhbHJlYWR5IHVzZWZ1bCBv
biBpdHMgb3duLiBUaGUNCj4gPiBhdXRvc2l6aW5nIG9mIC9kZXYvcmFtIGlzIHByb2JhYmx5IG1v
cmUgaW52b2x2ZWQgdGhhbiBteSBSRkMgcGF0Y2guIEknbQ0KPiA+IGhvcGluZw0KPiA+IGZvciBz
b21lIGlucHV0IG9uIGhvdyB0byBkbyBpdCByaWdodC4gOikNCj4gDQo+IEJvb3RpbmcgZnJvbSBl
cm9mcyBzZWVtcyBwZXJmZWN0bHkgZmluZSB0byBtZS7CoCBCb290aW5nIGZyb20gZXJvZnMgb24N
Cj4gYW4gaW5pdHJkIGlzIG5vdC7CoCBUaGVyZSBpcyBubyByZWFzb24gdG8gZmFrZSB1cCBhIGJs
b2NrIGRldmljZSwganVzdA0KPiBoYXZlIGEgdmVyc2lvbiBvZiBlcm9mcyB0aGF0IGRpcmVjdGx5
IHBvaW50cyB0byBwcmUtbG9hZGVkIGtlcm5lbA0KPiBtZW1vcnkgaW5zdGVhZC7CoCBUaGlzIGlz
IGEgYml0IG1vcmUgd29yaywgYnV0IGEgbG90IG1vcmUgZWZmaWNpZW50DQo+IGluIHRoYXQgaXQg
cmVtb3ZlcyB0aGUgYmxvY2sgcGF0aCBmcm9tIHRoZSBJL08gc3RhY2ssIHJlbW92ZXMgdGhlIGJv
b3QNCj4gdGltZSBjb3B5IGFuZCBhbGxvd3MgZm9yIG11Y2ggbW9yZSBmbGV4aWJsZSBtZW1vcnkg
bWFuYWdlbWVudC4NCg0KQ2FuIHlvdSBiZSBtb3JlIHNwZWNpZmljIGluIGhvdyB0aGF0IHdvdWxk
IGxvb2sgbGlrZSBpbiBwcmFjdGljZT8gVGhlDQppbmZyYXN0cnVjdHVyZSBmb3IgaW5pdHJkcyBp
cyB1bml2ZXJzYWxseSBhdmFpbGFibGUgYW5kIHdoYXQgeW91IGFyZSBwcm9wb3NpbmcNCnNvdW5k
cyBsaWtlIGFkZGluZyBhIG5ldyBtZWNoYW5pc20gZW50aXJlbHk/DQoNCkp1bGlhbg0KDQpQUy4g
U29ycnkgZm9yIHRoZSByZS1zZW5kLiBJIGFjY2lkZW50YWxseSBzZW50IGEgSFRNTCBtYWlsLiA6
KA0K

