Return-Path: <linux-fsdevel+bounces-52265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1803CAE0F1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 23:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 455697A8B01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 21:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8322417D4;
	Thu, 19 Jun 2025 21:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RkNac+oQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36CB30E85D;
	Thu, 19 Jun 2025 21:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750369748; cv=fail; b=d3AV3m1sBJtJRmZUPKVfRGJHldDmeAAHdxi7eF7YM6P2johTgi9Ln4CZfMRXYbkLupkvQytZAjto0Gk86Sf8K12F3srSyqyyd59y9W1vbn5u0eoOZMcWdeERpvgQfSc+TN32qeKqxxopmId7V1QuwCRxPtCAkew9wp6t4omtBKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750369748; c=relaxed/simple;
	bh=kkAg7YcITnWdBQTJJ1QJaQDcbeGHEZYJ90zML2aLWkA=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=efZ1mjhffv05Mrr3WogwfQEUbywDtzAA+wOigZBCLpqQDvTDncM9Zrl3CBPUSEzZ0aUK4R0MkApwv4hMtTT1/gpaGJ1+C1YggA/PTziZvxa5S/hzvevMC0Y6ey6aZMKDWOC4xaTEmx9wqrGEG7jjm9Kx0jCWZEMFD+d3z5NJC5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RkNac+oQ; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JLJMjD016279;
	Thu, 19 Jun 2025 21:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=kkAg7YcITnWdBQTJJ1QJaQDcbeGHEZYJ90zML2aLWkA=; b=RkNac+oQ
	PUCHlb5TgSutUIbhT35m0Y2269KAvmJdFNdGqPmj8LBk2Eu7W9Eo49l3m2ylrCRU
	0pSY/581B9FA1Boar9HBFxDBSdGiFigrURcBx0kQbp3sFScWN3NBly68j+80dQsX
	WVWNSi0JSlqigKqhauQxEz7dL/XI8QzBHF+YV0ySIJsBnGYSgeRWx1qquyFPcp4Z
	ogH896OupJ1ffPwfA+S6wiyCGDSuFpqAa1P5NQPNcB7zsmkfChO0Q97WyR5giKde
	4JLPEA5abNE9ikVOzwq7EWMUtUjSpok75wrCX8rtNkU3DUYLKBLXJETxvcZluoyF
	QWCt+2k10u21bw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygnqm6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Jun 2025 21:49:00 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55JLdRWt032652;
	Thu, 19 Jun 2025 21:48:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygnqm66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Jun 2025 21:48:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhXEDFxM8Fw5gf+GAdxwkV+MLeyogtr5bPWfCPdSN2iIdAmhYof6tse7fQ9sbBalhArHNAEL1C9OC8y1wNF+tktOoC9p/0E+94nQwtqe9O9V8sJQhcbWQtgQy3pu5A+d8oFvVn/R0wz2eDy1+ZYbtRfx5EFHGpSPNPSZZdjOwjXChlqWMCOUF3z3oThvHa7UBe9d6UD+4Y59j+KTNgp4MJwqFCITzDzuIM6eu6AtJgSpl7lJvcgakTZpPqNy8RLTZ8EpH/h86XQ7N3t7vjTsg3t26QOz2q1Au0x34rMs+oh1pQ5Hd5O80Bdksi+jsudu43iRd/H+VKkvqviMxkOONw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkAg7YcITnWdBQTJJ1QJaQDcbeGHEZYJ90zML2aLWkA=;
 b=Slv9aAQnsu/usy8i+FBYvnQbu1Od0RCd8JqQJ4qmdOiApazUAynKIZsI2I6ddukATOVtEkVXywY+HFx7C8DTTt63E5mDxLof7tEZB33MvwtGtNEhKlf+hKNz5S3RjRm0Z5Qxp+nMpJKBf16sIbc2/Zi65510BCA7k3vpNbJSYv2QHOiPkl9ZpPrAjEXlTahfdWMnCpxG1Szn4T7CpYSqgNMVljNOUH53HnuKe5C8kNK2kmZIzQXVXLy3NXxmFNtwlz5I2+ZW2QiufYkBcYZreirv5t2YAY/VIbBRI4YhDjRmHDXASBoQ6Co4rjmgXTXe6nRlorOGeoRZd5LbaQy6lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB4723.namprd15.prod.outlook.com (2603:10b6:806:19e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Thu, 19 Jun
 2025 21:48:57 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 21:48:57 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "lossin@kernel.org" <lossin@kernel.org>,
        "miguel.ojeda.sandonis@gmail.com"
	<miguel.ojeda.sandonis@gmail.com>
CC: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [RFC] Should we consider to re-write HFS/HFS+ in
 Rust?
Thread-Index: AQHbz2CpCY7FD08WfUuZLsiXLlP+iLPn/LoAgAA8YoCAIsotAIAADccAgAAYGYA=
Date: Thu, 19 Jun 2025 21:48:57 +0000
Message-ID: <c212d2e1ca41fa0f2e4bc7c6d9fe0186ca5e839e.camel@ibm.com>
References: <d5ea8adb198eb6b6d2f6accaf044b543631f7a72.camel@ibm.com>
	 <4fce1d92-4b49-413d-9ed1-c29eda0753fd@vivo.com>
	 <1ab023f2e9822926ed63f79c7ad4b0fed4b5a717.camel@ibm.com>
	 <DAQREKHTS45A.98MH00SWH3PU@kernel.org>
	 <CANiq72k5SensLERt3PkyDfDWiQsds_3GpS4nQqPPPMVSiWwSfg@mail.gmail.com>
In-Reply-To:
 <CANiq72k5SensLERt3PkyDfDWiQsds_3GpS4nQqPPPMVSiWwSfg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB4723:EE_
x-ms-office365-filtering-correlation-id: e7d2f6ad-76d9-4c2c-597d-08ddaf7b181a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZmxYMGdhOXdTOUdvM1FPei9HNWFkQ1Iwbmh3NElKNXdQUmM0bFB2ZmxTTGFG?=
 =?utf-8?B?WmN3cWVmam9ra3AxVXZGTHRYeGpzeGZtSFBwTFZVYW9SUVdNcklQbnF3c00y?=
 =?utf-8?B?TmZOZ1VWOXQ0dFdtak1kYzRXekhEeG5jTE5vaUVNa2QzOENOZ1g4dHVsdE9Z?=
 =?utf-8?B?MGVnLytkWVNUbnhZNzZTa0trUk1aMUhvUjd5M0J3NnlVN0JjNFlxZmtuWC9z?=
 =?utf-8?B?T2txeUZkL25nN0dJQVhnQXZiTjNyN3dXNWRmdi9ZN2llZEIxMXJidkF5YmVJ?=
 =?utf-8?B?cG5aQnNReEVwWlJWSnhnanF1dHVsempHM1I1UFF5Znp5aHc3R1NNcE1BT1hD?=
 =?utf-8?B?c0RadzhJUk9yUkJFdjBlVHZHWWNYS29EYUR1L2RmRkk1R2FXOEIybHNRNUNF?=
 =?utf-8?B?Y1Y0VDVqeUR6TFowSG5HeDdUY1NUWGpRMzhnMkd5UjlySGFKUUVsREN0dW1Q?=
 =?utf-8?B?OW5FYWxTa3AvQzlKWGFwbld2c0JsZTlNL0RjQVpybDEyRVBmd1NueEhiYlJk?=
 =?utf-8?B?WVpHbm9ZdHBna1JobEI1SlNpNlBYNGV1d2R3MXh3aVE2RHZHU2JsaW9lZDcz?=
 =?utf-8?B?QjE5cWNYVi9BZFBVSU4vajlNOE5vRDlzb2drc2VWcVFmL1RIN09pWXdWZWdR?=
 =?utf-8?B?L1dKQ0p2Tjh4SGdxNDVwYUI3OFo0NGZQSDdmTE81OVEvWUxxRGREYWUrZy8w?=
 =?utf-8?B?TkxZenlZN3FDNGZVWVI1K0VGczFkekRmNXNxa2RKMmt3QnVCZllnQ0d2TXBE?=
 =?utf-8?B?Wjg0bzdpbnE4bEQ0a0pPWU1lZVZneHNRdGJLYzYyMDlSU0lKdGZ3Snh3S0Zm?=
 =?utf-8?B?R09EblMvQ3ExckQ0ZVlhVzNvREs0Mi9kYnhNSW00ZTQ2cC9nNnFYWnNEekJu?=
 =?utf-8?B?Y3RpdHlHSzFZTmlXNWpMNUZZcVU3emRhRWFVd28xWi9vN1FYdDVFOUlFUWxV?=
 =?utf-8?B?KzZlZ21zdEthNGR5NUIzYlJucGllQ250MW5VeVZ0dG1FSS9XZkNySmZsampF?=
 =?utf-8?B?WlhsbGpjRldiemp1bW9QOTFtcjczcjhBblRxRGE3cFhLalI4aXNGMWg4cTFT?=
 =?utf-8?B?MnBHdGh4Z1hMK1V4V1Z0bXI4a0doM1FVWWY4QzM2N3g4VTFiTFJrcVg0WWxX?=
 =?utf-8?B?QTd0SGtJUlIvSmVuNXIxQklrcU5GaU94djEwSmtqQVhuKzIzU1FxZ1YybW9L?=
 =?utf-8?B?RXFsM1dSclorSGJJaHNRM3NWVEtGc003UDJiYjhvTG9RYThKK3pHUEpjeEhm?=
 =?utf-8?B?d05HUlo3ajRMY0JCUE9EYmhlaHJ4QkZoV21zSTFzb09kQ3ErZU15N2wvM1Vw?=
 =?utf-8?B?OUdRV2RyOWp4RVFhQXoxTnd1RGowZm1PUjVoVFhPMmtTOEJIQmNGd1RCK1ZY?=
 =?utf-8?B?byt5d1dCRkFhUStNVlorWUQxaW5sdU05VnlzNjBQQ1VxR2xrTVR0dHRpamVM?=
 =?utf-8?B?WDdoNDEwQjl6MU41RHloeVRQQlk0U1pDMmw3LzdWTnQ2Nm0zeUsrV21UTU1m?=
 =?utf-8?B?T1h2UDFMVndyd2ZObkFVU0ttbHpRWWtnQ3hJWHZkSit1aHQzVGRJaXZFa1Ix?=
 =?utf-8?B?OXZOMkJpbkszMXBtblJ3K3drZWFRbjcxWmMySDEvYUV3anBhT2dWT2MzNEdW?=
 =?utf-8?B?eTdtaUtkRzFFVk1pbml2ejJsRllHcUlGeVdjY28zQlJpU0ZjUlRFWjNmTEFH?=
 =?utf-8?B?dU5tK0ZJemxtc005WEhGMkRxNXlNdzRtTjhwSTZFUTNTbUxoMjhSUmpLT2xj?=
 =?utf-8?B?eEllaHc4UHA4Wlo2NFNESkYxTUNEaXBObGgwSU8xOVF3OHhHRFlUQ0NaWDJB?=
 =?utf-8?B?b05iTFJoU3ZzOW1qQVA1WGFvYXo3aEhLK2Iwc0hweVRvd0l6anJaeFFkWjM2?=
 =?utf-8?B?R0cyQm1iYVBqZyttaDBhdG5QemhFa2hCOTUvWTVaTjNkaU5uZW9CcFpTWGZF?=
 =?utf-8?B?ZXZzSlRTOUExdFpkWDZ2Qzk2alVEUGJ2Smk0b0tIcnU4aHBQSVI0VmMxaG9s?=
 =?utf-8?Q?SXfyJlBrgbWZ5C3doT5sdfSu95DVQY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V3hKVjhsVlpUUmM1aHFTNjJONElzRkxCa1ZtcHJ3QWEwckdRaTJncWtYbjhi?=
 =?utf-8?B?dm9JVlN6bXRIMS8wVGpGOXZ0SUI5RWI0WGVQbUJQWmY0bno5amxYY0dyODda?=
 =?utf-8?B?NDNsWHllQkw2K1FYekpaeTEwZWFBNFBKYmlpKzhFRVArM3lzQUp3L2tWRHNT?=
 =?utf-8?B?T2hScEMxTkI4dzRiQVNSNVNBVEFFM3BtbkwzKzdHL3A0T2R1M2JMVUYvelpZ?=
 =?utf-8?B?UzM4WEMxOTljVkVLVUpSUnhhMUs5blIrN0JzRkFIeXI1VnMweTVwV1JFMFRK?=
 =?utf-8?B?amtVZXhqUkQwM0FlYmxKY0Q3UGlXVk94cDhvN09ubVJmUlYzUlRleUhXMUow?=
 =?utf-8?B?Q011TTUzTDBsb1B0dHhodm51Y0U1MWFLNmtIZDZ3TlIrMkVxRnZUeWd4MFd3?=
 =?utf-8?B?YzZudmd1MThHZmh3MjB6Y3VsRnZsSGRCVDhuVVB3UHZqNGFRRHkyMGx1TmxJ?=
 =?utf-8?B?cktxYkMrYlkva0FRc0tzZzdmNFpTY0h0OHpqZFN5YmZPWVNvWnh0QWprVC84?=
 =?utf-8?B?c0VlOVRoZkhkZ3R1NVBZTWtLc1d4QlhDa0pVRXJPMXl2QnVKdiszdWFOL2Er?=
 =?utf-8?B?T25hMGRENC8za3JkeGxTNktRU24zY0JJa3c0UmtmOEhFYzRjZmo1azdrNFor?=
 =?utf-8?B?ejl2bXl5dTlJcmhkSGhPbzQxUkVhNTZQaldkSis0VXE1T1dRcmFrTlhsdk1X?=
 =?utf-8?B?NWtwMk5iQmtSbFdBc09tY1h2cmE3cjdGNDFBa0tCV0wzdUlibFljcWUvN2dI?=
 =?utf-8?B?VVZZcDFWVEJWQXBnbXJsRHBSK0dncTNueFNpRjhwZldmS3RoQm5zNUJ0L2Jy?=
 =?utf-8?B?VXE3VkNyaC9XSWczYkpCS2V5RW5IS1o1ZFE5SEdoTVNlTDdrMXl0aDVTRHg2?=
 =?utf-8?B?SHhQWVFKM2FuL3h6Uk9teGV3clF4UFRxOGVtNHlwTy9hbGR1M0t0SUZxMlZV?=
 =?utf-8?B?SkhwejkrV2ExVisrM3NKRFJ6NWd0S0kyMWd4bzFqTWhrZ2NpME5YZ3lrd1N4?=
 =?utf-8?B?dEpva2FLWllrRkdITjVqeXJObWx6RndsQXRLRE9XSVZUSGlJSWcvdkZ6V0Q5?=
 =?utf-8?B?aUxxVnpMdmZnKzJWZktoem5CS2wzSnBSNWYxWElBVXN3UUUvZi9pdXc1dUpz?=
 =?utf-8?B?QzZhR0gwcUdkZzFBUVRxaHN2TU0xOGlEQzRsQ1M5emxlL095UHdrT0cvdVps?=
 =?utf-8?B?YytRa2VvUGVUTzhIR29RcDJTMkxYWVdkQkNuekFIQlJOSUNIQXFwRUk2Zklt?=
 =?utf-8?B?VGFNb0IreDBIakJEK2Q5blkwQnVJU1N4cFI4RFp4a3Uxamdybk9nNUZSTkhE?=
 =?utf-8?B?ZnVHV2FMQ1llV2NDcXBNdkpLa25uRE5pbm5adVhPTURXVXZiclB1Z0ZISktn?=
 =?utf-8?B?RkRkZlRKdHh5UzdHQzluenBpTEIzZDc1SnlQZkZXaW9aVkNoK3JoYkM3ZHNI?=
 =?utf-8?B?OGJSd3ZNNUh2YXl1TTlhMVNldktzYytmbkhHV0RJYVRNTjBrMUhIeHhVRWhn?=
 =?utf-8?B?UWhKUmMySlZQMXJ0WkNWMzZWUUROQ0FIRmQxcDZpTHpCMDhkZjh3S21JQ0lW?=
 =?utf-8?B?OWpEaGFzNUhDcE5RdXo0bDVkNDR4L0p1MURXMjUvUGJTU3VUc0tzQWR0amk0?=
 =?utf-8?B?RXh0QjU4VXdJV3dpTysrb1V2NGZrVk9LMXV3WUJJaUhnUUVBQkdkT0MxajZv?=
 =?utf-8?B?QWZ0ZXlqT2pQSDNxL3QwK1dlS2g2QnVzRjdiZ1oyb2ZTTEVmeVJLV0R4V3dt?=
 =?utf-8?B?WkdaTzdySEgxc09yM2JoTEIwdVF3VGFVdkNabzZSS1BmOTVWZ1A3b29RR2Y0?=
 =?utf-8?B?eUcxNERCbmxod1h4ODVsSXRCZFpHMXZ6MkxsbVB0YlcxaWRqcDNFYVJOV09H?=
 =?utf-8?B?MUhqckg4eUU2dDhHYTBYUG1WdXRXeWFqQXhrTG1MVjB6WkVNemlaajhoUmdH?=
 =?utf-8?B?OVZVeGUwdmFuT0RuamxWRFRQUGxpS1FqVWtFT2RVUkNWTXZIQXpLNWUyOXlk?=
 =?utf-8?B?ZzE3YU9FZ2h1MHg1NWlHaXhDK2s5cUVockR0YmtqdEZERE0wUk9BcHBXWDRX?=
 =?utf-8?B?ZkdDa3hxSjIwdDBRUEdhVGpWVGVrT1duVHQwTHhLTE9XTXFjSkN0TFZZTG5O?=
 =?utf-8?B?MkpOaUJFS1ZRUHBPcFd3RG9CRjZIVnIvWmF3ZmF1eXc0ZUptZ1YrRldWK0tk?=
 =?utf-8?Q?34bRMY5mBt65Ga0uit/HtNc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5E3408EE49A614B96CE5112ABD3AA6E@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d2f6ad-76d9-4c2c-597d-08ddaf7b181a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 21:48:57.6180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xeHnrjn1aUJNKu1aU4Td6dbRRbUpueGq+XFwb0Rsh303xjpfTzSiOk4OXZndRqDPQ1hdSprmS+0JLbJnwP3dIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4723
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDE3OSBTYWx0ZWRfXzf1UUBxb9Xao yFT5My6udgkBUS0PQaNVI8R2CDVi8T2P55fc1blnpuoN0n6id1IdNdlwT8urUEx0TPOEqV2Y2QH a1r0e42fmFTOHfkGjr6ewDnzhj5FPtXDH4RqOH5QwIwp5ZNh6dRtaQuzYtFf7KLWEode935DqDE
 AeG62Ipnc6o5TuMzxkmtqadiXirUNZTNo2PLCDmRROsjbkppve4ivvgBsuamV8lwBQvRS9BANe1 pCtVFKBLxCGBsvj+nTSWN/vlmaIwLOvh2ffoFF8fX4HVMomy+1iSYgX7BSDtKTzGgBJu6VZUln3 lbsX0bLzXRxQ0TnDt9EUxn9YzbfOo7kmEv8SZL5q5JGSmMiWvvn2U+1vTT7uySdiqzhWnborLvx
 iBMP8aC6Ce3NQ5feisRKklHVHVocul4HT6ye48tAVXNQs6Awd1LYJVorkp6gJtVJpxYdbEbP
X-Authority-Analysis: v=2.4 cv=fYSty1QF c=1 sm=1 tr=0 ts=685485cc cx=c_pps a=CmVQekPX50wMUWcHeKemng==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=rIH98O22OktHME4k:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=oOtK1AsYR28yDy1n398A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 5T8V2ZkJKMxm9eH9tvM-Sa1kZhsuv8MG
X-Proofpoint-GUID: v86D2ikwzMS0xDu-S5aNHkMs0Xjt-94x
Subject: RE: [RFC] Should we consider to re-write HFS/HFS+ in Rust?
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_07,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=767 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506190179

T24gVGh1LCAyMDI1LTA2LTE5IGF0IDIyOjIyICswMjAwLCBNaWd1ZWwgT2plZGEgd3JvdGU6DQo+
IE9uIFRodSwgSnVuIDE5LCAyMDI1IGF0IDk6MzXigK9QTSBCZW5ubyBMb3NzaW4gPGxvc3NpbkBr
ZXJuZWwub3JnPiB3cm90ZToNCj4gPiANCj4gPiBUaGVyZSBhcmUgc29tZSBzdWJzeXN0ZW1zIHRo
YXQgZ28gZm9yIGEgbGlicmFyeSBhcHByb2FjaDogZXh0cmFjdCBzb21lDQo+ID4gc2VsZi1jb250
YWluZWQgcGllY2Ugb2YgZnVuY3Rpb25hbGl0eSBhbmQgbW92ZSBpdCB0byBSdXN0IGNvZGUgYW5k
IHRoZW4NCj4gPiBjYWxsIHRoYXQgZnJvbSBDLiBJIHBlcnNvbmFsbHkgZG9uJ3QgcmVhbGx5IGxp
a2UgdGhpcyBhcHByb2FjaCwgYXMgaXQNCj4gPiBtYWtlcyBpdCBoYXJkIHRvIHNlcGFyYXRlIHRo
ZSBzYWZldHkgYm91bmRhcnksIGNyZWF0ZSBwcm9wZXINCj4gPiBhYnN0cmFjdGlvbnMgJiB3cml0
ZSBpZGlvbWF0aWMgUnVzdCBjb2RlLg0KPiANCj4gWWVhaCwgdGhhdCBhcHByb2FjaCB3b3JrcyBi
ZXN0IHdoZW4gdGhlIGludGVyZmFjZSBzdXJmYWNlIGlzDQo+IHNtYWxsL3NpbXBsZSBlbm91Z2gg
cmVsYXRpdmUgdG8gdGhlIGZ1bmN0aW9uYWxpdHksIGUuZy4gdGhlIFFSIGNvZGUNCj4gY2FzZSB3
ZSBoYXZlIGluIHRoZSBrZXJuZWwgYWxyZWFkeS4NCj4gDQo+IFNvIHRoZXJlIGFyZSBzb21lIHVz
ZSBjYXNlcyBvZiB0aGUgYXBwcm9hY2ggKGNvZGVjcyBoYXZlIGFsc28gYmVlbg0KPiBkaXNjdXNz
ZWQgYXMgYW5vdGhlciBvbmUpLiBCdXQgZ29pbmcsIGluIHRoZSBleHRyZW1lLCAiZnVuY3Rpb24g
YnkNCj4gZnVuY3Rpb24iIHJlcGxhY2luZyBDIHdpdGggUnVzdCBhbmQgaGF2aW5nIHR3by13YXkg
Y2FsbHMgZXZlcnl3aGVyZQ0KPiBpc24ndCBnb29kLCBhbmQgaXQgaXNuJ3QgdGhlIGdvYWwuDQo+
IA0KPiBJbnN0ZWFkLCB3ZSBhaW0gdG8gd3JpdGUgc2FmZSBSdXN0IEFQSXMgKCJhYnN0cmFjdGlv
bnMiKSBhbmQgdGhlbg0KPiBpZGVhbGx5IGhhdmluZyBwdXJlIFJ1c3QgbW9kdWxlcyB0aGF0IHRh
a2UgYWR2YW50YWdlIG9mIHRob3NlLg0KPiBTb21ldGltZXMgeW91IG1heSB3YW50IHRvIGtlZXAg
Y2VydGFpbiBwaWVjZXMgaW4gQywgYnV0IHN0aWxsIHVzZSB0aGVtDQo+IGZyb20gdGhlIFJ1c3Qg
bW9kdWxlIHVudGlsIHlvdSBjb3ZlciB0aG9zZSB0b28gZXZlbnR1YWxseS4NCj4gDQoNClllYWgs
IEkgY29tcGxldGVseSBhZ3JlZS4gQnV0IEkgd291bGQgbGlrZSB0byBpbXBsZW1lbnQgdGhlIHN0
ZXAtYnktc3RlcA0KYXBwcm9hY2guIEF0IGZpcnN0LCBpbnRyb2R1Y2UgYSBSdXN0ICJsaWJyYXJ5
IiB0aGF0IHdpbGwgYWJzb3JiIGEgImR1cGxpY2F0ZWQiDQpmdW5jdGlvbmFsaXR5IG9mIEhGUy9I
RlMrLiBBbmQgQyBjb2RlIG9mIEhGUy9IRlMrIHdpbGwgcmUtdXNlIHRoZSBmdW5jdGlvbmFsaXR5
DQpvZiBSdXN0ICJsaWJyYXJ5Ii4gVGhlbiwgZWxhYm9yYXRlICJhYnN0cmFjdGlvbnMiIChwcm9i
YWJseSwgSEZTL0hGUysgbWV0YWRhdGENCnByaW1pdGl2ZXMpIGFuZCB0ZXN0IGl0IGluIFJ1c3Qg
ImxpYnJhcnkiIGJ5IGNhbGxpbmcgZnJvbSBDIGNvZGUuIEFuZCwgZmluYWxseSwNCmNvbXBsZXRl
bHkgc3dpdGNoIHRvIFJ1c3QgaW1wbGVtZW50YXRpb24uDQoNCj4gPiBPbmUgZ29vZCBwYXRoIGZv
cndhcmQgdXNpbmcgdGhlIHJlZmVyZW5jZSBkcml2ZXIgd291bGQgYmUgdG8gZmlyc3QNCj4gPiBj
cmVhdGUgYSByZWFkLW9ubHkgdmVyc2lvbi4gVGhhdCB3YXMgdGhlIHBsYW4gdGhhdCBXZWRzb24g
Zm9sbG93ZWQgd2l0aA0KPiA+IGV4dDIgKGFuZCBJSVJDIGFsc28gZXh0ND8gSSBtaWdodCBtaXNy
ZW1lbWJlcikuIEl0IGFwcGFyZW50bHkgbWFrZXMgdGhlDQo+ID4gaW5pdGlhbCBpbXBsZW1lbnRh
dGlvbiBlYXNpZXIgKEkgaGF2ZSBubyBleHBlcmllbmNlIHdpdGggZmlsZXN5c3RlbXMpDQo+ID4g
YW5kIHRodXMgd29ya3MgYmV0dGVyIGFzIGEgUG9DLg0KPiANCj4gWWVhaCwgbXkgdW5kZXJzdGFu
ZGluZyBpcyB0aGF0IGEgcmVhZC1vbmx5IHZlcnNpb24gd291bGQgYmUgZWFzaWVyLg0KPiBQZXJm
b3JtYW5jZSBpcyBhbm90aGVyIGF4aXMgdG9vLg0KPiANCj4gSXQgd291bGQgYmUgbmljZSB0byBz
ZWUgZXZlbnR1YWxseSBhIDEwMCUgc2FmZSBjb2RlIFJ1c3QgZmlsZXN5c3RlbSwNCj4gZXZlbiBp
ZiByZWFkLW9ubHkgYW5kICJzbG93Ii4gVGhhdCBjb3VsZCBhbHJlYWR5IGhhdmUgdXNlIGNhc2Vz
Lg0KPiANCg0KRnJhbmtseSBzcGVha2luZywgSSBkb24ndCBzZWUgaG93IFJlYWQtT25seSB2ZXJz
aW9uIGNhbiBiZSBlYXNpZXIuIDopIEJlY2F1c2UsDQpldmVuIFJlYWQtT25seSB2ZXJzaW9uIHJl
cXVpcmVzIHRvIG9wZXJhdGUgYnkgZmlsZSBzeXN0ZW0ncyBtZXRhZGF0YS4gQW5kIGl0J3MNCmFy
b3VuZCA4MCUgLSA5MCUgb2YgdGhlIHdob2xlIGZpbGUgc3lzdGVtIGRyaXZlciBmdW5jdGlvbmFs
aXR5LiBGcm9tIG15IHBvaW50IG9mDQp2aWV3LCBpdCBpcyBtdWNoIGVhc2llciB0byBjb252ZXJ0
IGV2ZXJ5IG1ldGFkYXRhIHN0cnVjdHVyZSBpbXBsZW1lbnRhdGlvbiBzdGVwDQpieSBzdGVwIGlu
dG8gUnVzdC4NCg0KVGhhbmtzLA0KU2xhdmEuDQoNCg==

