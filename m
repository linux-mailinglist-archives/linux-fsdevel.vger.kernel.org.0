Return-Path: <linux-fsdevel+bounces-70613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4ADCA1EBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 00:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0B40300EA2C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 23:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9AB2DF6F5;
	Wed,  3 Dec 2025 23:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wr/KNKdK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA7325C80E
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 23:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764803979; cv=fail; b=E8QNFI06yriGwric6ZJib4291J9u7XBfJGAftvDta9DHyROUYEVhJOmclcARqvXWfexXSBfowfeEU203ArM8024Xo9NVfwHG2Ft6yU6SdvJd4ZiQVwEcqoFMvZwkbvtd+O9Y374YIwHKO2C3VTEA3nhpVhyW3bk11JiJ9MD4DRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764803979; c=relaxed/simple;
	bh=JnwEJhX7jcHXF8szo0JZ0w1gN5XjUke3Aty/MnYHL5U=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=MYyAcpsSRNbDi1NtgBueDy5I98qQKtGlbwtzIxh4EcNYjfW1oAK32XTZAaKxIow5/1GkF4qWd0Ux+VKalDNe14n2nKwsNusHq/aU8ZwRr3x8llpvE68IDeT56Q3JJXFilScETkPi86quChFWd+ZXhOAK65SOeYnBgyI2FTQY+qQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wr/KNKdK; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B3DbRi1027538
	for <linux-fsdevel@vger.kernel.org>; Wed, 3 Dec 2025 23:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=eLIG9o9SCzKuZW0emRZwLcwdkSSfE8OGJPSmPjwH6XI=; b=Wr/KNKdK
	4OufK80Gjh9yFj+ERpXnw7co5S4/+lqba4SNuFVKoDPfZhcrHsLxFWwEZw3F5rMl
	Zt7tq4hVaJPfYGIwHzZv1SiYftBxpblc+C9gsJsvn1kERZDp7jr59Re0V4f70+nQ
	JZzjhabcQqkZ2JkAMaDnBBcrndF9QjyQ0+bqqZitLlLeE6OhEZS4ntgW7GAMWLqs
	L5F5LeFrHSYgPTHoasJfiAwSTfSbydBHd9rByTq63qRE0lspNXp9Oll26Us+s1fy
	W1fXDSxL6w4VadgqzwJ0GIA8Eu1DcbWT8NOxSwU5N9CgjvaoNKyr8W/kmmHBe8Js
	2elUnQA+9ACSvw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrh75hj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 03 Dec 2025 23:19:37 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B3NExUn023228
	for <linux-fsdevel@vger.kernel.org>; Wed, 3 Dec 2025 23:19:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrh75hj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 23:19:36 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B3NJZun032422;
	Wed, 3 Dec 2025 23:19:35 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012061.outbound.protection.outlook.com [52.101.48.61])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrh75hhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 23:19:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Noj2RiBZ9Ty4GYcydeAxczaqaYaS56Y0w+M1xEaUixettBsIene1sK13gmEsz4mEfdu7oF2erVjwANk1yZK11p4sjCdg1X2Cttit2HTUXuK4HtIYO/aSmNdv9wuL2bb5G8g2XekOZA64GNsYXMM4dPGqXsqqcHwF1VcVzhVrPaSt7EtWYMoFDJgSWSaRJRTXlAX+CIk8U8w4w64lQd3aZTyZO2+66OoDMNvFCz8nWdMkg9ZEgi8Xn0HCXP4Q2W6KDmBcS0LGDeGKOYtxmTWyF1nF7Kcvwaq1RtX7zBwxhuW/07FYD/FwDO/HmYKl2cXiu8LYZ6CZaSXhFrSr0X2ELA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHT1xPSoYJFL4GYjaqn2ZHKt0LOPnNKQ80hP5yPGm/c=;
 b=sgZxZTfeRdZjz0V3GXoZwg9femvJLwh6UYsn/mChSznUTVvd52lM6Vq3CrJ2B9Hd0M88O2W8jktdL014EIiTfowbJtJ7+ojR3Ns+/M6cwztMxA8+A5gYtmOTB9YRbLE2pG4pHG7gr28NnXMqwN6gR6lv59/NxY2FDdLYzl2QsFX0iU9hdeKPhh22H/1d4wbmm9OYSsk25ZhqYBAJKQ3R/mjDacQwTvQ/4F0lNRtV8sPn9QRX4hcquTaTRVd+GB/SDrNAsHm4UawrCZm/EJOWxejIkDbgDBXl8tYImSXr7X+1n0rBnaY277bgHFFn4Mz5ORmdJHvCNVF/v88C5u7TyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW4PR15MB4762.namprd15.prod.outlook.com (2603:10b6:303:10b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 23:19:33 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 23:19:33 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "brauner@kernel.org"
	<brauner@kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "mehdi.benhadjkhelifa@gmail.com" <mehdi.benhadjkhelifa@gmail.com>,
        "sandeen@redhat.com" <sandeen@redhat.com>,
        "jack@suse.cz" <jack@suse.cz>
CC: "khalid@kernel.org" <khalid@kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "david.hunter.linux@gmail.com"
	<david.hunter.linux@gmail.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org"
	<linux-kernel-mentees@lists.linuxfoundation.org>,
        "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        "syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com"
	<syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v3 1/2] hfs: ensure sb->s_fs_info is
 always cleaned up
Thread-Index: AQHcY2xhsurAAEz9o0Kx1GzWWq9mw7UQj7YA
Date: Wed, 3 Dec 2025 23:19:33 +0000
Message-ID: <32a2196b93ccdac0623175180a26c690e97536f6.camel@ibm.com>
References: <20251201222843.82310-1-mehdi.benhadjkhelifa@gmail.com>
	 <20251201222843.82310-2-mehdi.benhadjkhelifa@gmail.com>
	 <4b620e91b43f86dceed88ed2f73b1ff1e72bff6c.camel@ibm.com>
	 <4047dad6-d7f8-4630-896a-68d4b224f6c6@gmail.com>
In-Reply-To: <4047dad6-d7f8-4630-896a-68d4b224f6c6@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW4PR15MB4762:EE_
x-ms-office365-filtering-correlation-id: f92c49eb-d676-4e3f-eda5-08de32c26b12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cHFmT25iM24yUDRvcHdOZlI1R3hFd2I1ajdCR3ZhQWVTRTMvKzE1S2FrcUpU?=
 =?utf-8?B?eVU2cXY4bkMxOUxMbHl0eS9vSGs0MTRieTBRT1lkZkhTUFhBTytaUE1SczZF?=
 =?utf-8?B?dmh1bXdXK3ptQXpmYUh0TnhuMEVndS9OMFJaTHI4MDNIck9jN0p3WmNheGdZ?=
 =?utf-8?B?NTlXclo5eEFUc25KVEQyV0VqbmJCZnRCVkwxTzQwZzRxZFJNR0RZaWJwOHlr?=
 =?utf-8?B?bEVIdWV2M29JdHk5YUg3SVpvK3BkMStDRUpxVXhIRUdNVTduMTlGSUVTcDhQ?=
 =?utf-8?B?UDNVQ3dUTEpQb1VLL2p2VXM3Y3BKZ2JaQkZvdWJBdG00QzJaZGdZanRaLzdG?=
 =?utf-8?B?ZmVWWGN0ZXoramxsbTZLME1qVkFqTTJtYzBLZERmN3gxa2JJTlRxa1hTNkxM?=
 =?utf-8?B?aEJsM25kaHlobnAyRWJQd3FVZTlHdVMrOTNKcE9lZXJFWGpEdlRMYmM0dUgz?=
 =?utf-8?B?dFhnZURUV2F5ZXVJMExWYXA2R1E1TnFpOXZJUTlOMmdGbW9YcGFERWkwcHo5?=
 =?utf-8?B?Mlg2Q3gydkNNQ0RHY3pueHR3dzM5VS9lQ0JVWlRFZFljaTBVWVBZK2FDbUNv?=
 =?utf-8?B?aWF0cUVBOHdXUlk3K1BGckdMem9reWVwNWVmbUIrTUk1OTJrZmNoRnBXaTF0?=
 =?utf-8?B?M3hHWHN3cVVlMENjaDZPOFNGSGJZS3hmckkvS3lvMk9hRGg0VlNGV0pUYXVm?=
 =?utf-8?B?cE4yZUJtN29aUTJ3TDNhOTRLNkppaVRZbHhKQnBWNXhjYTgwamlSVkFVckdT?=
 =?utf-8?B?UGFkWitJVWI0bHZsVkJkYkhrdExVK2FmVnRKcS81MWFDWFh2ZGVObEk4bHVx?=
 =?utf-8?B?RzVRd05mRXNydjdnMFZtZ3N5cFcvS3Jwa3ovV1ZTcmVjTklFZlBGYzBFMitP?=
 =?utf-8?B?Mk5TNDR3UURjdzBqa29hVkREWWx3WWNseWpteXZRS0hDdDdybWtodFZUQlZX?=
 =?utf-8?B?dWhvcktMdE9WSnBETVBmazMydlZZWUR2c1I3My8wWVd4Y2ZjRzFMZXNYWUZU?=
 =?utf-8?B?MEx6aGN2MkJ3bDYxOFNiazlGeFV1WFpSdmErRzNDTzB1ZFd0bjVTalN3UlEr?=
 =?utf-8?B?R24xOWhMRjRLRkQ1VkVJS2NiR3VkcU91cTBwb2pyalg0V1lFeW5GMklaUWFl?=
 =?utf-8?B?bElIcCtqR2U0allDUEdHU3lmVzQzOU0raVM1WnY4emRPeXVVSW9VcS9uQWtp?=
 =?utf-8?B?ckFyYXJhdUJzZnRveGM2bk50Z2VIQ2ExTlRtaUExTjdMeEE3NWdMbE5CZmtw?=
 =?utf-8?B?ZmgwVkkvSFdjc1NVU3JCZm9DOTdkalFlSjVpaVhybVlkbTdPUERTQkpkdzFw?=
 =?utf-8?B?TENBUW56bGM5SmxXOHdhL2l3VWNvVWVFUHFhWHVjM0xqV3dNczBEdDROcnNj?=
 =?utf-8?B?a2NuRUlmZXZGMmRwM0x0Z1RaWGVEV3NrVFlvOWNqaGZRdU9BZWkyVUdPSnVl?=
 =?utf-8?B?QWkvbUJCQTRGUllIUXY2RjQ5SzBkVXlVSG5KVUcwbW00OFVIVHRYNU53ODdG?=
 =?utf-8?B?aUIvZVFMdm1ROVpNOFlWWTNncmRQTHVCdytSNHBEbm8vWFFUWDNPb01xeEp3?=
 =?utf-8?B?ajdjQnVKMU9hc0hPMVNydUNmUTRoOFp0d1pDS09nNy92Q2dFNzZMMHV3U1J0?=
 =?utf-8?B?MmJVN2c0dGk4RTRNakwxU1NqcUZVM3h2L2tjRDZETi82NWt2UGNzamYvUk8w?=
 =?utf-8?B?VHovM2RlSmFPWkVUbG9RZ21BbTBQZldQTHNuQS90SmtJQ2l6Z0gydHZhZWFQ?=
 =?utf-8?B?RGpyc0ZXUmlqNnVTd1FWMTZvWjdMTE5KM1FOQytUVzNMUTZTTXdra0VKcmIr?=
 =?utf-8?B?N0xoWWpaVlBMMlRSU1VFaGJMZ0R4dHlYMU5ZYWMzV1RrYnk0dmtxYUhoeWMw?=
 =?utf-8?B?MTNNcUxaUTYrWHA3Sm4rSHF4bDlkVlQ5SDlEMVQ3K3JSZU94QnJtWXN0Um5Y?=
 =?utf-8?B?Q1l3dDJyYzFkUm9MMDdKNHpOT05vMXplazNFRDN3Y0lpZmMxMCttTXhQb29S?=
 =?utf-8?B?SmhUSHU5ak9BPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b3ozNVRuNy9kY0JwblRiWHhOQUk1MG9EYlZlYTc0MzRsT1psakdWWWVqTHgz?=
 =?utf-8?B?SzBiZDY3UlcxeUNCVjJqMHFUWk95aThEVStSdVcvUzhFaGVxcUhZbTFnYjRm?=
 =?utf-8?B?R3hQeGFKUkVXMW5uc3hwUWNlVW5IbG96cWIyU3VjMm9nNFhWVHUybGtkMTN0?=
 =?utf-8?B?KzlMZ2ZzMXIrL2d4WFV5TFk2MjVTUmZVWjAxZjZWL1FPQmNXbjg3d1R3cjNI?=
 =?utf-8?B?LzVDRzE0OFRRYlJNMW84WFVia04ycG5IdU0zNnBDRjNERGVzUHd4RUIyMDMv?=
 =?utf-8?B?Z1lQejFnWiszdmM1YVZCblNNVHlMaDVYMWY5Qm0zbVpqQmN4MFlwNE5mSVY2?=
 =?utf-8?B?MVJlalNiYWpZNUNqcWhnSVZHMTR3Ny90K1l2dWcxWmVSYlc2cXRTUE5jdGhv?=
 =?utf-8?B?QnBpdHEvdHpqbUhCNnprd09USTdQaEljRkJWeVNmOXExSHV5SDFHZU1NOTFV?=
 =?utf-8?B?b0w1dzBTVzhvZ25UdjhnU09kUTFJYm9GamdXUHBQbmtodDZwSUJENHNHNWgw?=
 =?utf-8?B?Tk5haFZjeFhwWnJoS0tkZ1haalQ1cUtVbFZnT3hJcC9acUdWL21oajIwUFRT?=
 =?utf-8?B?cjZMWmdMNGtlQnBHaS9LMnB0VEpQQW8xTVExbXFOb3BtTUhFYjZ1N3NETXhO?=
 =?utf-8?B?VVhEcTUzQ0lFSEZRdE5oTm8rMXZVR3RZbURqNjRiOXk2ZlVvb3FoL1cyRmpq?=
 =?utf-8?B?dzUvcDc0VHd0cUQ4R2JqZWhQaXZLK2R2UVVmNGRpN3BlcnEyd0RSd2xDR01D?=
 =?utf-8?B?WWY3TWJxRFJrejhPb0s3Wmd5WTBRRzNLNkZ4VUVseUNpUmd6MzlTNzlmSDI1?=
 =?utf-8?B?blhxRE1UQVFCZnYydmxCd21NWG1yMWV3Q1dTV3UzTjRpSWxFL0RmZUxPalpK?=
 =?utf-8?B?YitQS2FnbFcwajZyZHJ3K3lqZGRvQkFFaERrSkUrRWpWajd6ZUxxU2lybU1I?=
 =?utf-8?B?Y3NxOFVXYVhVRE9halVRaFNZUnNRRWYrc0lLaXhoK2V5dTRoK3Y2d2VKaElJ?=
 =?utf-8?B?ZmltM1VFZU1mNDJvVWorWVUwdjFLQlc0QTVZZjVGSzJDZ21LUy9iaWdPZEpk?=
 =?utf-8?B?U0p4Um1JaytQbWhSdVVxeGI3bXFCZVNlaFVoTnhxc1lUazlsLzQxSXljeHFV?=
 =?utf-8?B?NHFhOWNmVXFiMjlkeERpdDlMUlZmZTl6L0FUWVExeGlRcXVYdnRqL3oyTy80?=
 =?utf-8?B?SkFPdGhSQWhLditqNzRoN0NkL1Y5QThKdzVnY0xHdEYvQ2puL3p0aWIwZmpT?=
 =?utf-8?B?NENBNmRPT3d0YVBMZ3N4WEtMaUxZWXppQmlnVVdFbmxNQzdsS0RlTG9JL0xq?=
 =?utf-8?B?T1VDWDFuc2dSNUExdmpQbDhNMWlzdXVYaDZ2NXJBVllOd205UmVFcHppT2xN?=
 =?utf-8?B?RUNJczZDYjBuRmFkREppbDdEbTdHeld6UStTRGtyQUNFM3A4dUpiWUZSOSs1?=
 =?utf-8?B?QVN2LzM3MlgvV3lrbGEvckZsZjlHOS9xdDJBUTVpNW9WbW44VUhNaXI2UzQ0?=
 =?utf-8?B?ZjM0N21kNEdybC8zd2xSemgrdlFzakF5TDVqNGJzSGNvbFdmSzVwL3RBQVR0?=
 =?utf-8?B?VytEblNzNjZWVXpKc3ZkdVB5S3EyeW54V2FIL1VlcDRzZjdUaEthQjBIcnJw?=
 =?utf-8?B?L216TmpQSThrUXEwUFNEL0Y5WkRsNWxpbVlxUUwrQ05BZGx6OWdVdnFjQ05Y?=
 =?utf-8?B?U0tsa1hHcW1UaXE2bTUyS0ZnbkF4RHdnd21JT2x6UmRaQngwRytWZ3p6UkFC?=
 =?utf-8?B?dzFkcEtYN3FkcDBNb2wvMFcwc1BmbzhOZk5DSE5lNDMvaitqTHg5ajl0ZWht?=
 =?utf-8?B?b21DNWl3OFl5V0VtU2pVOTgwUU9DbWRYc2E1ZzR1Q1d4dGhKaDJUUy95WGdG?=
 =?utf-8?B?ZHdnWldmTXlidzgvalQ0ajFITHYwcExiTDI3WWQwbXAxd216L3c3bVB5d3Qr?=
 =?utf-8?B?dVc5ZmROZHhJVlFOV28xNnNIeUhWUnQrclA3SGo2aXl5SmNXekdudmZiZXlx?=
 =?utf-8?B?MkNrSmhwejd2NVNDWmN5dE9Pamt3bXh4aWhxcFQ1VmlTV2RLWCtTejkxdUwx?=
 =?utf-8?B?dzhiRXpwUFNuRFAybG1FUUdySkFvYkQyRHl1eUh2NFR2bnZqK0JETm5maGQ0?=
 =?utf-8?B?SnpMNi8vV3lSdHhIWmlHSHJ6TjMxb2o1UWpva2ZRUVUzY0RjVlN3QVV4RmxH?=
 =?utf-8?Q?xnV9vrBkVoKk1r6neBW1NtI=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f92c49eb-d676-4e3f-eda5-08de32c26b12
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2025 23:19:33.4374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MyMAo3f6ldw2oEnuH9rgic3qBtqlW234fLYm37eSK4fZBOzb3OdJrhDKoTBGIyWU8dmYFNgB4JkKCHBOGhh2cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4762
X-Authority-Analysis: v=2.4 cv=dK+rWeZb c=1 sm=1 tr=0 ts=6930c588 cx=c_pps
 a=kfEGYAivpUbBRfgbjfv6iA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8
 a=hSkVLCK3AAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=wCmvBT1CAAAA:8
 a=jTD32kWTnDfmvYvLnZIA:9 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-GUID: 3W1qfPJsLautRCceUcp9tfkozkEZFTB0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX2JFgTcYd6tbP
 10vmEoCtCdgk4+GmQ4hkmpFdaUXXcHVW6e10teA4A5+9caVTvsQM8dX94tYB/tKMi9naTevTJ6Q
 +P+BF+XXv8YZpidnZFLiUiM5bNOQvo57B+dyPQCDqYpHgebyUUhklYviS8QpYGyUn9CpGDTllAm
 X6HoLqujDbvh3gjZ0NMy8lr6OZjBTzj76a1dRq0zXkXb7zpVNYZePVX1qMjx+DwyIQvYsG6T3zq
 nmrSQT+5LbbpBhUGlRGboRRR/Yf9g1eiInQ016X2tOVduOdtEo5dNh/UBWsv/cgRmfmFeo+U1id
 RA4cMEhnsIh7ImrOE7fsrie4ItpIgZ+3O72tdBjPBJtnO5APYwQOn+zP50nfUvr5dblhYsljVFq
 asTeOMkE2hRyruErRi+dbum5adM7pg==
X-Proofpoint-ORIG-GUID: wP9zmAIktoTSXvXppgTlNW6b8HDFziHv
Content-Type: text/plain; charset="utf-8"
Content-ID: <C154ED1A959CAD45AB8DBC01F248988D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v3 1/2] hfs: ensure sb->s_fs_info is always cleaned up
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_03,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=2 engine=8.19.0-2510240000
 definitions=main-2511290020

On Tue, 2025-12-02 at 11:16 +0100, Mehdi Ben Hadj Khelifa wrote:
> On 12/2/25 12:04 AM, Viacheslav Dubeyko wrote:
> > On Mon, 2025-12-01 at 23:23 +0100, Mehdi Ben Hadj Khelifa wrote:
> > > When hfs was converted to the new mount api a bug was introduced by
> > > changing the allocation pattern of sb->s_fs_info. If setup_bdev_super=
()
> > > fails after a new superblock has been allocated by sget_fc(), but bef=
ore
> > > hfs_fill_super() takes ownership of the filesystem-specific s_fs_info
> > > data it was leaked.
> > >=20
> > > Fix this by freeing sb->s_fs_info in hfs_kill_super().
> > >=20
> > > Cc: stable@vger.kernel.org
> > > Fixes: ffcd06b6d13b ("hfs: convert hfs to use the new mount api")
> > > Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3Dad45f827c88778ff7df=
6 =20
> > > Tested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> > > ---
> > >   fs/hfs/mdb.c   | 35 ++++++++++++++---------------------
> > >   fs/hfs/super.c | 10 +++++++++-
> > >   2 files changed, 23 insertions(+), 22 deletions(-)
> > >=20
> > > diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> > > index 53f3fae60217..f28cd24dee84 100644
> > > --- a/fs/hfs/mdb.c
> > > +++ b/fs/hfs/mdb.c
> > > @@ -92,7 +92,7 @@ int hfs_mdb_get(struct super_block *sb)
> > >   		/* See if this is an HFS filesystem */
> > >   		bh =3D sb_bread512(sb, part_start + HFS_MDB_BLK, mdb);
> > >   		if (!bh)
> > > -			goto out;
> > > +			return -EIO;
> >=20
> > Frankly speaking, I don't see the point to rework the hfs_mdb_get() met=
hod so
> > intensively. We had pretty good pattern before:
> >=20
> > int hfs_mdb_get(struct super_block *sb) {
> >          if (something_happens)
> >               goto out;
> >=20
> >          if (something_happens_and_we_need_free_buffer)
> >              goto out_bh;
> >=20
> >   	return 0;
> >=20
> > out_bh:
> > 	brelse(bh);
> > out:
> > 	return -EIO;
> >   }
> >=20
> > The point here that we have error management logic in one place. Now yo=
u have
> > spread this logic through the whole function. It makes function more di=
fficult
> > to manage and we can introduce new bugs. Could you please localize your=
 change
> > without reworking this pattern of error situation management? Also, it =
will make
> > the patch more compact. Could you please rework the patch?
> >=20
> This change in particular is made by christian. As he mentionned in one=20
> of his emails to my patches[1], his logic was that hfs_mdb_put() should=20
> only be called in fill_super() which cleans everything up and that the=20
> cleanup labels don't make sense here which is why he spread the logic of=
=20
> cleanup across the function. Maybe he can give us more input on this=20
> since it wasn't my code.
>=20
> [1]:https://lore.kernel.org/all/20251119-delfin-bioladen-6bf291941d4f@bra=
uner/ =20
> >=20

I am not against of not calling the hfs_mdb_put() in hfs_mdb_get(). But if =
I am
trying to rework some method significantly, guys are not happy at all about=
 it.
:) I am slightly worried about such significant rework of hfs_mdb_get() bec=
ause
we potentially could introduce some new bugs. And I definitely will have the
conflict with another patch under review. :)

I've spent some more time for reviewing the patch again. And I think I can
accept it as it is. Currently, I don't see any serious issue in hfs_mdb_get=
().
It is simply my code style preferences. :) But people can see it in differe=
nt
ways.

> >=20
> > >  =20
> > >   		if (mdb->drSigWord =3D=3D cpu_to_be16(HFS_SUPER_MAGIC))
> > >   			break;
> > > @@ -102,13 +102,14 @@ int hfs_mdb_get(struct super_block *sb)
> > >   		 * (should do this only for cdrom/loop though)
> > >   		 */
> > >   		if (hfs_part_find(sb, &part_start, &part_size))
> > > -			goto out;
> > > +			return -EIO;
> > >   	}
> > >  =20
> > >   	HFS_SB(sb)->alloc_blksz =3D size =3D be32_to_cpu(mdb->drAlBlkSiz);
> > >   	if (!size || (size & (HFS_SECTOR_SIZE - 1))) {
> > >   		pr_err("bad allocation block size %d\n", size);
> > > -		goto out_bh;
> > > +		brelse(bh);
> > > +		return -EIO;
> > >   	}
> > >  =20
> > >   	size =3D min(HFS_SB(sb)->alloc_blksz, (u32)PAGE_SIZE);
> > > @@ -125,14 +126,16 @@ int hfs_mdb_get(struct super_block *sb)
> > >   	brelse(bh);
> > >   	if (!sb_set_blocksize(sb, size)) {
> > >   		pr_err("unable to set blocksize to %u\n", size);
> > > -		goto out;
> > > +		return -EIO;
> > >   	}
> > >  =20
> > >   	bh =3D sb_bread512(sb, part_start + HFS_MDB_BLK, mdb);
> > >   	if (!bh)
> > > -		goto out;
> > > -	if (mdb->drSigWord !=3D cpu_to_be16(HFS_SUPER_MAGIC))
> > > -		goto out_bh;
> > > +		return -EIO;
> > > +	if (mdb->drSigWord !=3D cpu_to_be16(HFS_SUPER_MAGIC)) {
> > > +		brelse(bh);
> > > +		return -EIO;
> > > +	}
> > >  =20
> > >   	HFS_SB(sb)->mdb_bh =3D bh;
> > >   	HFS_SB(sb)->mdb =3D mdb;
> > > @@ -174,7 +177,7 @@ int hfs_mdb_get(struct super_block *sb)
> > >  =20
> > >   	HFS_SB(sb)->bitmap =3D kzalloc(8192, GFP_KERNEL);
> > >   	if (!HFS_SB(sb)->bitmap)
> > > -		goto out;
> > > +		return -EIO;
> > >  =20
> > >   	/* read in the bitmap */
> > >   	block =3D be16_to_cpu(mdb->drVBMSt) + part_start;
> > > @@ -185,7 +188,7 @@ int hfs_mdb_get(struct super_block *sb)
> > >   		bh =3D sb_bread(sb, off >> sb->s_blocksize_bits);
> > >   		if (!bh) {
> > >   			pr_err("unable to read volume bitmap\n");
> > > -			goto out;
> > > +			return -EIO;
> > >   		}
> > >   		off2 =3D off & (sb->s_blocksize - 1);
> > >   		len =3D min((int)sb->s_blocksize - off2, size);
> > > @@ -199,12 +202,12 @@ int hfs_mdb_get(struct super_block *sb)
> > >   	HFS_SB(sb)->ext_tree =3D hfs_btree_open(sb, HFS_EXT_CNID, hfs_ext_=
keycmp);
> > >   	if (!HFS_SB(sb)->ext_tree) {
> > >   		pr_err("unable to open extent tree\n");
> > > -		goto out;
> > > +		return -EIO;
> > >   	}
> > >   	HFS_SB(sb)->cat_tree =3D hfs_btree_open(sb, HFS_CAT_CNID, hfs_cat_=
keycmp);
> > >   	if (!HFS_SB(sb)->cat_tree) {
> > >   		pr_err("unable to open catalog tree\n");
> > > -		goto out;
> > > +		return -EIO;
> > >   	}
> > >  =20
> > >   	attrib =3D mdb->drAtrb;
> > > @@ -229,12 +232,6 @@ int hfs_mdb_get(struct super_block *sb)
> > >   	}
> > >  =20
> > >   	return 0;
> > > -
> > > -out_bh:
> > > -	brelse(bh);
> > > -out:
> > > -	hfs_mdb_put(sb);
> > > -	return -EIO;
> > >   }
> > >  =20
> > >   /*
> > > @@ -359,8 +356,6 @@ void hfs_mdb_close(struct super_block *sb)
> > >    * Release the resources associated with the in-core MDB.  */
> > >   void hfs_mdb_put(struct super_block *sb)
> > >   {
> > > -	if (!HFS_SB(sb))
> > > -		return;
> > >   	/* free the B-trees */
> > >   	hfs_btree_close(HFS_SB(sb)->ext_tree);
> > >   	hfs_btree_close(HFS_SB(sb)->cat_tree);
> > > @@ -373,6 +368,4 @@ void hfs_mdb_put(struct super_block *sb)
> > >   	unload_nls(HFS_SB(sb)->nls_disk);
> > >  =20
> > >   	kfree(HFS_SB(sb)->bitmap);
> > > -	kfree(HFS_SB(sb));
> > > -	sb->s_fs_info =3D NULL;
> > >   }
> > > diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> > > index 47f50fa555a4..df289cbdd4e8 100644
> > > --- a/fs/hfs/super.c
> > > +++ b/fs/hfs/super.c
> > > @@ -431,10 +431,18 @@ static int hfs_init_fs_context(struct fs_contex=
t *fc)
> > >   	return 0;
> > >   }
> > >  =20
> > > +static void hfs_kill_super(struct super_block *sb)
> > > +{
> > > +	struct hfs_sb_info *hsb =3D HFS_SB(sb);
> > > +
> > > +	kill_block_super(sb);
> > > +	kfree(hsb);
> > > +}
> > > +
> > >   static struct file_system_type hfs_fs_type =3D {
> > >   	.owner		=3D THIS_MODULE,
> > >   	.name		=3D "hfs",
> > > -	.kill_sb	=3D kill_block_super,
> > > +	.kill_sb	=3D hfs_kill_super,
> > >   	.fs_flags	=3D FS_REQUIRES_DEV,
> > >   	.init_fs_context =3D hfs_init_fs_context,
> > >   };

Looks good. Thanks a lot for the fix.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.

