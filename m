Return-Path: <linux-fsdevel+bounces-71837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AE1CD70EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 21:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 347B3301595C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 20:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6204307481;
	Mon, 22 Dec 2025 20:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p8hlTmNt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BA52E2F14
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 20:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766434917; cv=fail; b=ol5X/BMQGvaN3saPHgDgBWccLo5mv+fVnJgxbIuRQsllxOUVLXyN9O/q668urWKn0IZrlxnWVGLm8Eixc7vjfjKoYHUjNFG/Se14V3fsbaUFDb9jfs+T6eo6wkvTKVh294e1Mr5QakK3tEUydS4WMoresOtm1VIJ3LwMISsW7TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766434917; c=relaxed/simple;
	bh=Xb7JNG8+dr6G7rW1KUKWCryy4AKQ29KvU6vwaaLZvyk=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=OvZW1q3DuBxVuNAxchEe66l3+CcbjuNfyXWgYepLjsqqdOG4NQSX3yBrquKIb/eRa/3FfOHRQdjyHT/br0BqXaAsjrDquIq32aFErCCuAAvVd36Dx3yvuKib70aBHpFMptWyaU1OpD69hzlmTyXAodt7r+G8AQOWbJY1zDQqaKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p8hlTmNt; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BMJ2XC3009901
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 20:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=f3JSGOJSSo1hk4+CZxgwhTC91bfecuMeBrk0jkQbPzM=; b=p8hlTmNt
	9KEg+3UPmTawc7MQKAF1UryiPnw0h0kRf5WvSk6TXbDciu62FHjcmnvZHPi9fTeX
	iV3uPkadk5GWi8YwREyBSX5nX2Xt/26M9hitVhHUuxtGeYmFZtVXiLlGHgArP+2t
	rXT4YFXQQhBwLWvwEYFWk5td8pKyA8BtTLoN6R9uynRJ5ZMZMa9RJls0Ox/yXEZo
	QUxCXQLn2KW76yyn54Rp+4XJzqsErCrXBv8bAatEepkZevcHgmTGvZpx6FjQAWdc
	flslISPBy9clBlkjFLMq4j1Xc7qON/BhNxA2QPEMZmRZaQ9pZbrmjTwbEeercfrh
	uOneUh/hZB1/DQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5h7hsxxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 20:21:54 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BMK17s7016391
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 20:21:53 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010030.outbound.protection.outlook.com [52.101.56.30])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5h7hsxxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Dec 2025 20:21:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKimzOxV4Ts3fAnmAp4KL2VAD9C2mfOdiRqBa99B+xVKSV4RR21JW/UdYriTXeZZSqIsfFyS6ceyy1SbCGfbQPOhg884pJNjiOrzLSKNxcCZqTYbLM3DUpGcRpEfBHf7pVXC05e3JdOl/rtivi2fwvg0Xt+uvUXQsB+shaLX/HIEsNRabH5OZfTUegdruzW4vhwMzuhw9iVxBnBOcEHpFa4ckySI+IOyYJ+o06KB9Z/9no2klHACRfw/jDn1lPGpQ1nU/0HWCcoOFxq53QULDfl/jl+XgNgC6gDNwFgN5xylY6Rmda/aQ8aXWZWDR2r5pb519IYbraS27zsjpBNDtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7d5My2rlWpQ9Igl+szXAj3FlYPIGrJHNoIxZDP3Xgc=;
 b=Csw/wg/ymYjJrKMvruxcJjAYkoHd/mXXcFE7z0F+x/ASFYi6cEfUVYhMusTOQu0jaWhFVMLJnVuqfwhdocnViG7Vu8FYoGV0NxrfxV9EkTvSprbTQtt4r1sXQKvoYX0NeRvxZ1/iGs5cB4VR3SRMgu5LFhhKqjKPYv7R6TyogS8aojo+j6D711/SkQgszM8XpSkItr+LYJgHYzy83+sr7fDyo9sOudIOB2sXuvtnBmV5DesoNH7mq0Zqm6nEo/1hACIwirqTpDID+1AjQekudQ8Apmmze46lP+HVHPSHtb4cVAAp2dmiyfTG5LX5SmRI9FbO/h7qY8PRTE9ksj0c9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB4387.namprd15.prod.outlook.com (2603:10b6:806:192::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 20:21:51 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9434.001; Mon, 22 Dec 2025
 20:21:51 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "slava@dubeyko.com" <slava@dubeyko.com>,
        "jkoolstra@xs4all.nl"
	<jkoolstra@xs4all.nl>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>,
        "syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com"
	<syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] [PATCH v4] hfs: Replace BUG_ON with error handling
 for CNID count checks
Thread-Index: AQHcceRrUgsE66faw0mbZ12OPvA55rUuHWwA
Date: Mon, 22 Dec 2025 20:21:50 +0000
Message-ID: <56e1a4d8a05a2345619808ed7def43d919d5ab62.camel@ibm.com>
References: <20251220191006.2465256-1-jkoolstra@xs4all.nl>
In-Reply-To: <20251220191006.2465256-1-jkoolstra@xs4all.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB4387:EE_
x-ms-office365-filtering-correlation-id: e49124bd-ff40-40a6-54d4-08de4197bd9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZnpCY1RBU05YT2MveTFwcWRQR1JVM0RsblB3WGQzWDJFR1A1ZjNLWFBjaXVG?=
 =?utf-8?B?QzAzS3ZGT1d2bVY4Ylc5N2hpWk5UWTRuelQ5U1BFNVNFakJtK3VZSzVZTmtF?=
 =?utf-8?B?eXNzTGV4NzlURFl3emk5RXhOU2kwejZwZFhRNWxrTm5jc29XR1E5QXJPM3VE?=
 =?utf-8?B?QTFjWnA3K1BoNkh4MWczSTlMNVJqOUxxMlhZYmp0Q3FlYTFNdUw1clhOV2gv?=
 =?utf-8?B?RHZoeE45NDJ4M3gzTWQwU3daVEx6K0dHZVlBK3I1dHJCTkhRWGdkbG4wOG1S?=
 =?utf-8?B?a2ljd2JGNUt4c01ocUxKTnNNbklGd1lYbXdsd1FFcDQxUzNBQmhURXU1RGEw?=
 =?utf-8?B?M1dtUkFwa3NRL2gzQjBTWC9TdEZNKzlMSk5VVjlLK0Z4amVBMlZhMlBTM3or?=
 =?utf-8?B?QWxrNUtzRlZBc2xqZmd4Y3oxazB4bUtTenVxdWhCSlBMUncvTFVlTFYyY0ps?=
 =?utf-8?B?TG90QkYxTEhQaldadW41SXZQMHM4bkFFcVBtd0hPcTlZOUYxY0E0Mjh2YUND?=
 =?utf-8?B?RGNSTkd1MEtIQWdnWGJaNkZHZEo2UGIxU3Q2N1VyRXYxU1phVDZnZm9NMTRs?=
 =?utf-8?B?Y2czOXBkTzB4dndzMktIS2ZyblRNVWFrYjRlUVduTEVIUys4Q3BEL2lQczhB?=
 =?utf-8?B?Q0NiREp1OGhiWjFmV0NwMXlsbEh4UDdxZWdiZ3pXeTFlZmJqRndLYmxIQ2Fn?=
 =?utf-8?B?cUxvY0MxWHZTcXA4WFVKT0htcmFjV2tuWVlvYmdnSGp1UU5Xd1kyZUM5S0k1?=
 =?utf-8?B?bFlSaFF3OStvcVdGR256ZkFrWkJUWGdqVzduUGRRcENCNkxld0c3WXFYSVZT?=
 =?utf-8?B?Y0phT1IxQ0RONUtLckhvemRQM2ovWnc0bktESVVHdzdMbjI2Z1BoU1NpUHN4?=
 =?utf-8?B?b3kyOURsbkdKS2NLWWwzeGsrK2xpT2h0cWN4NHVpV0xMTFQ4dXp0WTZpUDRs?=
 =?utf-8?B?dnhybEJlZ2J4bmIwOEYvMzdyajBRN3JZaFFiV3lNalN6L29lTkFZYm42S21o?=
 =?utf-8?B?OU1ITjdwR0lDaVBLK2wyZWllZDh0ZytBK2lSU1JPY2xqV1Nyazl0TmsrQ1p4?=
 =?utf-8?B?WkxMQUFjRkdRZGRGdGpRYTdOVnlJTndmNis1WDVRa1kzVVJSd29XMTJidGNw?=
 =?utf-8?B?V0tESmRhN3F2WVVmNWFrQktTZ2FycllQYUdReVpycVpoWG5pVStBY21FRTJU?=
 =?utf-8?B?ZWpXaEE2NmwzcE1OR1RhVFlUdDBXbVF0bGIyangrbUxzdjRlRHlPN0RXcUN6?=
 =?utf-8?B?TFNGaUl3Z3c3Wjl4VmR6T1pyUXJCanI4aW1QOVB2UE9tbUlFZTFCaGxHOHQ4?=
 =?utf-8?B?SVFyc0VwZCtXdFdOWWk3U1lCTFNndWNzQ0p3aDhPRkVtWmZ3dWVzcktOVWg5?=
 =?utf-8?B?aHMzeldIZ1NJb3FacFJoU1BqTmtIS0RnaU0yeDlndkplSlBDQ2twbDFZTDcv?=
 =?utf-8?B?MGgzRFVjVkE0UFRUK1gzZVgvQVg4MFpObjZZOUNjVnFHMDZPUDZxOFNma0FX?=
 =?utf-8?B?dmRycHlaaktiWFQ3Q1ByUUJMRWorVCtXYWp1VitjY3pYSGpyazF3Y2s3Z0Nu?=
 =?utf-8?B?ZWVUOVczNWRFTHI2b01hb3Z5QzVVQUUrcnBsTGRuZS8zYjA4ZXBGZ1dNUVBl?=
 =?utf-8?B?ajBsQWhJR2ZvZTlkTldQVzJxY3Z1N3kvYzI1SW1JRkVEWk1rNWI5YXRjRFNU?=
 =?utf-8?B?OUdLUXNqZGUvVkQ0bHlpWXlObHZVb2hRMWNvZVZEWDJWcnR2TnpKeThnSHNO?=
 =?utf-8?B?RkUvMnI4a3lLczljaVhzaDdnZk5uQW1ON0ZCNVZPSHppUXVkcXNiaVpxMWxr?=
 =?utf-8?B?WERrV1Z4ZHBtU0tqQTJXOUxic0NiOElxaTlYM0lMUDJBY09wYmZhcUZsUGVP?=
 =?utf-8?B?YzBqVFVVVTlDdGkzTFRsNCtMNm5NQkVjcjU2RDFZaGlBQU51L1cyc3RyNWpE?=
 =?utf-8?B?RURWMUhHMHhyb0JtbWY0YmwyTXNKUzFlVEcxUC9DMUt3OHgyRWgwMFl5WHNP?=
 =?utf-8?B?RzdoQW1mNFd3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TDRVdzkvL2ZKY2g1NU5nTnoxSlQyQWJFckQ2NTB6MGYybkdjeXkrcGtkZkZQ?=
 =?utf-8?B?bHNjMUdOcGpGeUJDNExndWgvQTRZNTVjc3lSTFdkUHRtUWFmVlo2aVhlc3Iv?=
 =?utf-8?B?NkR1RXF4bTd6R0RrakwvYXYvVGR1WU9SSXJuWTAyREw2MmprMW8xNVlidFBz?=
 =?utf-8?B?NWxqMjBSaWI2Z2VpSElkbkVmcjliaGRuN215bjZMVklsR09HWFQ5OUdUblNn?=
 =?utf-8?B?MUFtQkkrY2ZZdTZSQVh6RWlMdUcwTnVtQ2hKUWIzOFhzM1pVRDY2dnFQbFRm?=
 =?utf-8?B?UUpOaFVLb2RLcXRtV1RjanZ1enRBcFVObXZpeittNWVQNkhoZ2ZyQVpVWG83?=
 =?utf-8?B?YlZCbWk0dCtaSjlqcjM3VllkSDVqS3JzQTlYQVRCMzBGcEpnd2QwTUNCeFlM?=
 =?utf-8?B?Y3hYWEpUTHYzQS9JZ0dMNXM3eE9DSGlPUUpmNnF3RFBFS0VwM0NYQk9sQkV2?=
 =?utf-8?B?QVNMKzl4bUh4blZZdnl5MmQrQUptTVFwVUppNWNQWjl3Zm9pQ2tZY1EzTFJ1?=
 =?utf-8?B?aytHNzJuYmplNVp3c2ZZUE9MRnhNS0xYY2VCLzhibk5TU0hIbEhmWE5Bc1E1?=
 =?utf-8?B?UGZnU1EwS3doNGpSbEpzejBhUWxxNFVzODRQWUdTc3pNUC8vRGVEMm5zWnNp?=
 =?utf-8?B?QS9oTFF6dm1BNVM4RktjS3Bvb1J2NVdBMUxjdmlyeTdiY2hWWDZnZE9kd1ND?=
 =?utf-8?B?cmc1L1lNN0t0ZDJZR2JaYXJKTStBV2k1SHVrbjY3UkExYnpYOGxhUVorcy83?=
 =?utf-8?B?NlhHMTRNdk5TcDhjd08xaEQ1dEdEblRwN1NyQU04dWZWQkxMa3hRMkVsS05y?=
 =?utf-8?B?aE1KYVBmaTMwczNOZllldHhFbm9wZHExQi9WOVlLY1hyKzNIOUtTSmN0UHFJ?=
 =?utf-8?B?eU01UUNMZFNZOXl4SnhPNEpkS1U2NWdUZWlKSTJUYlhRazR5eHZYUm1IbXh5?=
 =?utf-8?B?aTRiTERDcGI2WklmRHJMTG9kT083YXYrbkxSeHdoRjJoMDdHeWh2YjNsUXdJ?=
 =?utf-8?B?VWJONzdjZkY4MW1FNG1wZWszV0o5V0VqNmRhR3BhUXM3Y3BySjhMbXVuWExE?=
 =?utf-8?B?eG8zcnF5a3dNVUo4a1lycDVXUis5QmJOTy9zZ2NZY01BdHF1REJFVi95cWM5?=
 =?utf-8?B?dDNTbFRCMzFiSEZkVDkyY3BFaXFYZXRyK2p6MVV1T1ZPTVVYbHRPeklGOU5a?=
 =?utf-8?B?Z2pPblBsNDZMZ3MxaFFoWGRDN1BhTDhMUzlSS2RTU0NWT1BUQ25adkl5OHI1?=
 =?utf-8?B?dENvRitwRmt5Z095NnNXdU15TktoM21GV1JXeUF5eGRXZ3FuWG42aEZWNlJP?=
 =?utf-8?B?TmpGTGJHVXdDYTEwbHNaK21hSmlwRFBTbzFEL2pxT0xRcnBUeTN2QUd2WmMz?=
 =?utf-8?B?K2FwajF5eTFwQXV2UU1ZYjQ3TFE4bGFSblNUUWtOWU9XTGx5a3d5UnhSV3Iz?=
 =?utf-8?B?eUdBZnNSUHVwNzJPWXZ1dTRQSzl4TDZTdUV4L3F0dU9TbVR2U0JIdnF3ZE1Y?=
 =?utf-8?B?TXBIUkNLODVQY3A2bDRPNEFWUVhHdDNnbmhtd3dleTllMUZpMk1TWTJFRmlh?=
 =?utf-8?B?Tk1kVXBUbHVhblRkOUpHYTFoQ0piRVdIVkllcHpKakxSSTl5bDNLVFZJRHhS?=
 =?utf-8?B?cXJSbDJaam84ZzVNQks4Q1pPc204VmpGZk1zWEN5czdJZlV0THRoUC9Jc2Zw?=
 =?utf-8?B?UzNwTVloUlZiWVBOd1JxVStQZjlvVmZ6NjY3dEM1L1cxRGFTaFJzck5pZ2h2?=
 =?utf-8?B?S2srWjdpdmJ5TThsTmlZa0VVMmxOR1BWK3dXbHZmMTlnaGJmZHdyRW5KK0Fq?=
 =?utf-8?B?RVZha0IrTGNGNEUrSVk1MlJIYXhYaGhVNkFML1A1by8wbHNkZXZRTW0xVHBz?=
 =?utf-8?B?aEdRMmZmNjNxZFZpWjl5K3RJTm13RTJpTnlabkVzaExCZ0REZlJNN1JXWitF?=
 =?utf-8?B?NG1qMkNWU1lNUU9mT2Q5RndVcVovZWltUW1BdkM0bXNqdkVMS3pGc1VRd2dY?=
 =?utf-8?B?S01tVVl5YUxjKy80NXZPK2lDZkJMNGVhejBQZ2FqakhaeldrbnNxYnpOdmpi?=
 =?utf-8?B?ZHR1VGlYNzFKQzBQWUNCY1grNmorRmtibTE5Vm9zcW9JY3pyZTFMMWlyMFlp?=
 =?utf-8?B?QW5NOVpvQlJFaUh1SWovdXVnTFJSK3BmY0NEaXk3cWMwczQvTVZMVUlUNGxz?=
 =?utf-8?B?am9TV24ycXhrU2RaQ000N0tMNVRIRXFJMVNDVk0yYWpJejI2elRNWnNBVmx3?=
 =?utf-8?B?a0x0c3RoZEVCVGpEQnhraHYwbTRndUZjaURXVHJoNEZCRzUzdWt5aEdyMEcv?=
 =?utf-8?B?SkxMSFB3UUh3M1I1L2toSTU3YlR3SWQ1SDZPNkFoRnBLK2ptOWgwMFovakNj?=
 =?utf-8?Q?4JHnBU+lJiCw6aj4oJIislLypUri8E5pDBVMl?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e49124bd-ff40-40a6-54d4-08de4197bd9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2025 20:21:51.0057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: inIc/K+9v+Kad+NLnI6q2DSNhUo3SQiCLxKFf9+qjGsnJKUfsDeiuo3Xvwuxzjv8g1ZEeQzeYkxi3I+79/VQOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4387
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDE4NiBTYWx0ZWRfX3JAOA315RUHW
 52TP/2KjTpcbw0aVIgtfxncwi3ZZSkV1c9XYtP5XhcVx5dFBxuw3X8aCCBbuY5+5uKEdNR2Zw7M
 FXRhlskd1mHBMnvUFF3X+NRFV7KeUEU8PhVj25HxIW6H1OgTic0e8SCUd17n0BAdMxdZsuacPig
 AAuSGFeFZOM991Mn4zKYaCuXshEmknn1BHcFKMy4ws2Zl7UoBT7WqBpERK63hOLBFucjTpn/Cpq
 uoGMHO/rXzIwoBBqcA+VzTFoBN8jJl1e/VdowwqzBwIe/Mfodi23IdM2xj3s+6OC/DDwup3al/3
 ZXbJfj9pTWyjFaes3S/7khcaQkGx2SH+3HQfWSoGYX9meMA3qPksm27t9Trm7AdlNDwojjGisbc
 LAHRNx8cd6pFpAPjpUTU6rY2skG8vP84iIe7Y9vO2Caq/BYi6nF17XUZsKWqwqdKNy2baj2RNyo
 am31A/kJxNlBvx2p2vA==
X-Authority-Analysis: v=2.4 cv=Ba3VE7t2 c=1 sm=1 tr=0 ts=6949a861 cx=c_pps
 a=lJB3plHzOIAfJWf+6KWQLg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=-ibLmwfWAAAA:8 a=xOd6jRPJAAAA:8
 a=hSkVLCK3AAAA:8 a=wCmvBT1CAAAA:8 a=4Ta7guRoTBLeWIrIcvUA:9 a=QEXdDO2ut3YA:10
 a=A6MkUVyZPcTV1i89ro0M:22 a=cQPPKAXgyycSBL8etih5:22 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-ORIG-GUID: T0qA4thZGv8RA7FejHHM9PUtAnYubUE2
X-Proofpoint-GUID: T0qA4thZGv8RA7FejHHM9PUtAnYubUE2
Content-Type: text/plain; charset="utf-8"
Content-ID: <705D15E0562CFF49836A0C6EC85BDCB1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [PATCH v4] hfs: Replace BUG_ON with error handling for CNID
 count checks
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-22_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2512120000 definitions=main-2512220186

On Sat, 2025-12-20 at 20:10 +0100, Jori Koolstra wrote:
> In a06ec283e125 next_id, folder_count, and file_count in the super block
> info were expanded to 64 bits, and BUG_ONs were added to detect
> overflow. This triggered an error reported by syzbot: if the MDB is
> corrupted, the BUG_ON is triggered. This patch replaces this mechanism
> with proper error handling and resolves the syzbot reported bug.
>=20
> Singed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> Reported-by: syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com
> Closes: https://syzbot.org/bug?extid=3D17cc9bb6d8d69b4139f0 =20
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
> Changes from v3:
> Removed some redunancy in the count overflow error in hfs_remove, and
> a ;; typo.
>=20
> Changes from v2:
> There is now a is_hfs_cnid_counts_valid() function that checks several
> CNID counts in the hfs super block info which can overflow. This check
> is performed in hfs_mdb_get(), when syncing, and when doing the
> mdb_flush(). Overall, effort is taken for the checks to be as
> non-intrusive as possible. So the mdb continues to flush, but warnings
> are printed, instead of stopping fully, so not to derail the fs
> operation too much.
>=20
> When loading the mdb from disk however, we can be sure there is disk
> corruption when is_hfs_cnid_counts_valid() is triggered. In that case we
> mount RO.
>=20
> Also, instead of returning EFSCORRUPTED, we return ERANGE.
> ---
>  fs/hfs/dir.c    | 15 +++++++++++----
>  fs/hfs/hfs_fs.h |  1 +
>  fs/hfs/inode.c  | 30 ++++++++++++++++++++++++------
>  fs/hfs/mdb.c    | 31 +++++++++++++++++++++++++++----
>  fs/hfs/super.c  |  3 +++
>  5 files changed, 66 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
> index 86a6b317b474..0c615c078650 100644
> --- a/fs/hfs/dir.c
> +++ b/fs/hfs/dir.c
> @@ -196,8 +196,8 @@ static int hfs_create(struct mnt_idmap *idmap, struct=
 inode *dir,
>  	int res;
> =20
>  	inode =3D hfs_new_inode(dir, &dentry->d_name, mode);
> -	if (!inode)
> -		return -ENOMEM;
> +	if (IS_ERR(inode))
> +		return PTR_ERR(inode);
> =20
>  	res =3D hfs_cat_create(inode->i_ino, dir, &dentry->d_name, inode);
>  	if (res) {
> @@ -226,8 +226,8 @@ static struct dentry *hfs_mkdir(struct mnt_idmap *idm=
ap, struct inode *dir,
>  	int res;
> =20
>  	inode =3D hfs_new_inode(dir, &dentry->d_name, S_IFDIR | mode);
> -	if (!inode)
> -		return ERR_PTR(-ENOMEM);
> +	if (IS_ERR(inode))
> +		return ERR_CAST(inode);
> =20
>  	res =3D hfs_cat_create(inode->i_ino, dir, &dentry->d_name, inode);
>  	if (res) {
> @@ -254,11 +254,18 @@ static struct dentry *hfs_mkdir(struct mnt_idmap *i=
dmap, struct inode *dir,
>   */
>  static int hfs_remove(struct inode *dir, struct dentry *dentry)
>  {
> +	struct super_block *sb =3D dir->i_sb;
>  	struct inode *inode =3D d_inode(dentry);
>  	int res;
> =20
>  	if (S_ISDIR(inode->i_mode) && inode->i_size !=3D 2)
>  		return -ENOTEMPTY;
> +
> +	if (unlikely(!is_hfs_cnid_counts_valid(sb))) {
> +	    pr_err("cannot remove file/folder\n");
> +	    return -ERANGE;
> +	}
> +
>  	res =3D hfs_cat_delete(inode->i_ino, dir, &dentry->d_name);
>  	if (res)
>  		return res;
> diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
> index e94dbc04a1e4..ac0e83f77a0f 100644
> --- a/fs/hfs/hfs_fs.h
> +++ b/fs/hfs/hfs_fs.h
> @@ -199,6 +199,7 @@ extern void hfs_delete_inode(struct inode *inode);
>  extern const struct xattr_handler * const hfs_xattr_handlers[];
> =20
>  /* mdb.c */
> +extern bool is_hfs_cnid_counts_valid(struct super_block *sb);
>  extern int hfs_mdb_get(struct super_block *sb);
>  extern void hfs_mdb_commit(struct super_block *sb);
>  extern void hfs_mdb_close(struct super_block *sb);
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index 524db1389737..878535db64d6 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -187,16 +187,23 @@ struct inode *hfs_new_inode(struct inode *dir, cons=
t struct qstr *name, umode_t
>  	s64 next_id;
>  	s64 file_count;
>  	s64 folder_count;
> +	int err =3D -ENOMEM;
> =20
>  	if (!inode)
> -		return NULL;
> +		goto out_err;
> +
> +	err =3D -ERANGE;
> =20
>  	mutex_init(&HFS_I(inode)->extents_lock);
>  	INIT_LIST_HEAD(&HFS_I(inode)->open_dir_list);
>  	spin_lock_init(&HFS_I(inode)->open_dir_lock);
>  	hfs_cat_build_key(sb, (btree_key *)&HFS_I(inode)->cat_key, dir->i_ino, =
name);
>  	next_id =3D atomic64_inc_return(&HFS_SB(sb)->next_id);
> -	BUG_ON(next_id > U32_MAX);
> +	if (next_id > U32_MAX) {
> +		atomic64_dec(&HFS_SB(sb)->next_id);
> +		pr_err("cannot create new inode: next CNID exceeds limit\n");
> +		goto out_discard;
> +	}
>  	inode->i_ino =3D (u32)next_id;
>  	inode->i_mode =3D mode;
>  	inode->i_uid =3D current_fsuid();
> @@ -210,7 +217,11 @@ struct inode *hfs_new_inode(struct inode *dir, const=
 struct qstr *name, umode_t
>  	if (S_ISDIR(mode)) {
>  		inode->i_size =3D 2;
>  		folder_count =3D atomic64_inc_return(&HFS_SB(sb)->folder_count);
> -		BUG_ON(folder_count > U32_MAX);
> +		if (folder_count> U32_MAX) {
> +			atomic64_dec(&HFS_SB(sb)->folder_count);
> +			pr_err("cannot create new inode: folder count exceeds limit\n");
> +			goto out_discard;
> +		}
>  		if (dir->i_ino =3D=3D HFS_ROOT_CNID)
>  			HFS_SB(sb)->root_dirs++;
>  		inode->i_op =3D &hfs_dir_inode_operations;
> @@ -220,7 +231,11 @@ struct inode *hfs_new_inode(struct inode *dir, const=
 struct qstr *name, umode_t
>  	} else if (S_ISREG(mode)) {
>  		HFS_I(inode)->clump_blocks =3D HFS_SB(sb)->clumpablks;
>  		file_count =3D atomic64_inc_return(&HFS_SB(sb)->file_count);
> -		BUG_ON(file_count > U32_MAX);
> +		if (file_count > U32_MAX) {
> +			atomic64_dec(&HFS_SB(sb)->file_count);
> +			pr_err("cannot create new inode: file count exceeds limit\n");
> +			goto out_discard;
> +		}
>  		if (dir->i_ino =3D=3D HFS_ROOT_CNID)
>  			HFS_SB(sb)->root_files++;
>  		inode->i_op =3D &hfs_file_inode_operations;
> @@ -244,6 +259,11 @@ struct inode *hfs_new_inode(struct inode *dir, const=
 struct qstr *name, umode_t
>  	hfs_mark_mdb_dirty(sb);
> =20
>  	return inode;
> +
> +	out_discard:
> +		iput(inode);
> +	out_err:
> +		return ERR_PTR(err);
>  }
> =20
>  void hfs_delete_inode(struct inode *inode)
> @@ -252,7 +272,6 @@ void hfs_delete_inode(struct inode *inode)
> =20
>  	hfs_dbg("ino %lu\n", inode->i_ino);
>  	if (S_ISDIR(inode->i_mode)) {
> -		BUG_ON(atomic64_read(&HFS_SB(sb)->folder_count) > U32_MAX);
>  		atomic64_dec(&HFS_SB(sb)->folder_count);
>  		if (HFS_I(inode)->cat_key.ParID =3D=3D cpu_to_be32(HFS_ROOT_CNID))
>  			HFS_SB(sb)->root_dirs--;
> @@ -261,7 +280,6 @@ void hfs_delete_inode(struct inode *inode)
>  		return;
>  	}
> =20
> -	BUG_ON(atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX);
>  	atomic64_dec(&HFS_SB(sb)->file_count);
>  	if (HFS_I(inode)->cat_key.ParID =3D=3D cpu_to_be32(HFS_ROOT_CNID))
>  		HFS_SB(sb)->root_files--;
> diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> index 53f3fae60217..e0150945cf13 100644
> --- a/fs/hfs/mdb.c
> +++ b/fs/hfs/mdb.c
> @@ -64,6 +64,27 @@ static int hfs_get_last_session(struct super_block *sb,
>  	return 0;
>  }
> =20
> +bool is_hfs_cnid_counts_valid(struct super_block *sb)
> +{
> +	struct hfs_sb_info *sbi =3D HFS_SB(sb);
> +	bool corrupted =3D false;
> +
> +	if (unlikely(atomic64_read(&sbi->next_id) > U32_MAX)) {
> +		pr_warn("next CNID exceeds limit\n");
> +		corrupted =3D true;
> +	}
> +	if (unlikely(atomic64_read(&sbi->file_count) > U32_MAX)) {
> +		pr_warn("file count exceeds limit\n");
> +		corrupted =3D true;
> +	}
> +	if (unlikely(atomic64_read(&sbi->folder_count) > U32_MAX)) {
> +		pr_warn("folder count exceeds limit\n");
> +		corrupted =3D true;
> +	}
> +
> +	return !corrupted;
> +}
> +
>  /*
>   * hfs_mdb_get()
>   *
> @@ -156,6 +177,11 @@ int hfs_mdb_get(struct super_block *sb)
>  	atomic64_set(&HFS_SB(sb)->file_count, be32_to_cpu(mdb->drFilCnt));
>  	atomic64_set(&HFS_SB(sb)->folder_count, be32_to_cpu(mdb->drDirCnt));
> =20
> +	if (!is_hfs_cnid_counts_valid(sb)) {
> +		pr_warn("filesystem possibly corrupted, running fsck.hfs is recommende=
d. Mounting read-only.\n");
> +		sb->s_flags |=3D SB_RDONLY;
> +	}
> +
>  	/* TRY to get the alternate (backup) MDB. */
>  	sect =3D part_start + part_size - 2;
>  	bh =3D sb_bread512(sb, sect, mdb2);
> @@ -209,7 +235,7 @@ int hfs_mdb_get(struct super_block *sb)
> =20
>  	attrib =3D mdb->drAtrb;
>  	if (!(attrib & cpu_to_be16(HFS_SB_ATTRIB_UNMNT))) {
> -		pr_warn("filesystem was not cleanly unmounted, running fsck.hfs is rec=
ommended.  mounting read-only.\n");
> +		pr_warn("filesystem was not cleanly unmounted, running fsck.hfs is rec=
ommended.	Mounting read-only.\n");
>  		sb->s_flags |=3D SB_RDONLY;
>  	}
>  	if ((attrib & cpu_to_be16(HFS_SB_ATTRIB_SLOCK))) {
> @@ -273,15 +299,12 @@ void hfs_mdb_commit(struct super_block *sb)
>  		/* These parameters may have been modified, so write them back */
>  		mdb->drLsMod =3D hfs_mtime();
>  		mdb->drFreeBks =3D cpu_to_be16(HFS_SB(sb)->free_ablocks);
> -		BUG_ON(atomic64_read(&HFS_SB(sb)->next_id) > U32_MAX);
>  		mdb->drNxtCNID =3D
>  			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->next_id));
>  		mdb->drNmFls =3D cpu_to_be16(HFS_SB(sb)->root_files);
>  		mdb->drNmRtDirs =3D cpu_to_be16(HFS_SB(sb)->root_dirs);
> -		BUG_ON(atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX);
>  		mdb->drFilCnt =3D
>  			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->file_count));
> -		BUG_ON(atomic64_read(&HFS_SB(sb)->folder_count) > U32_MAX);
>  		mdb->drDirCnt =3D
>  			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->folder_count));
> =20
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index 47f50fa555a4..70e118c27e20 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -34,6 +34,7 @@ MODULE_LICENSE("GPL");
> =20
>  static int hfs_sync_fs(struct super_block *sb, int wait)
>  {
> +	is_hfs_cnid_counts_valid(sb);
>  	hfs_mdb_commit(sb);
>  	return 0;
>  }
> @@ -65,6 +66,8 @@ static void flush_mdb(struct work_struct *work)
>  	sbi->work_queued =3D 0;
>  	spin_unlock(&sbi->work_lock);
> =20
> +	is_hfs_cnid_counts_valid(sb);
> +
>  	hfs_mdb_commit(sb);
>  }
> =20

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks a lot,
Slava.

