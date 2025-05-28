Return-Path: <linux-fsdevel+bounces-49998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF615AC72BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 23:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F06189C446
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 21:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DEA22156C;
	Wed, 28 May 2025 21:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f+n1TOxC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D190EAD7;
	Wed, 28 May 2025 21:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748467594; cv=fail; b=Wi5E2taFYd9SuwiSZHg7SlZPKR+zvI7uKS3U5K05tazwn6UHchph2dADUo5SgZUAXix4TZ3X8w40FNbmjLmgSmkgizpPDRV9tH1oPwRmXLp1bn4n95xsdZpbppGNbprKnrskXmVF4a1bSOtAuVdzNuI4//BPCN9aP687pII0MUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748467594; c=relaxed/simple;
	bh=IbQsJY74lsS6ItV2zG8ISz84zkGf5DnMvnhqKsWVAC8=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=LbCk1Qcy5ir5xmlstDekJpZDqJRjAoTHKuj8XYxEEsh+gDFAQ1JUc2tB+uZmnEQHViXdyq1V5OMsqW1o/XQwlSCM5nGvQmhoDEN3+Oz3bV8T5h59v86zwLtW2xnJUT7b7pbKmGqYNnR9gHsuQWdFtC7/s7YaCqNA15WlCJwNrs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f+n1TOxC; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SE9jQ3022722;
	Wed, 28 May 2025 21:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=IbQsJY74lsS6ItV2zG8ISz84zkGf5DnMvnhqKsWVAC8=; b=f+n1TOxC
	dD5Py19GF+tGxO1k+RtAlI9/4C58QjwXja+t6HSzWyag5cN/a5utArXAr4vXtKoT
	SwiCl6jlDUac0nc2gLzZhOLpJZyHh5jF3OReGv+GgxUnnBxIcl7ko7r4AkZMCNlh
	7N1EeBDVLERkcp+BK/eQW9yrGCGGykdnsyOJFDZ+nuPbGaLtlaV/nHdpZ7h4CLDr
	DM2rhDnbNY4Qs8fakwZdOI/3KI9Kb0vCYxlx2fQvzyn9pMqtnjbeiBk1XjT4Whqi
	raw9LEA3xogDemJHtQVdU1QxwFLimGz7b/B/G7/ppEuXJU1luvzVkILNqvTf7LpV
	Koex9Xd8wZpXUw==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40h24jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 21:26:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sA7r9Beo0eBfbIR8jBArGgL6WFs/haWTvVrlYmGYo1Kdrhwc+CS5P28dAWGbtxsdj9Xd3zNnRBWj00KRwZLVlwW62f2pgdsTIgIlsuErFpbIGTBWwx77J9cMAr3R+/goQNqX9LUIpk84HSiuTvyc6VLrWYeoOrZcSqcofgtg66IiNNBWiUVY9cQpgL5tfZg+1TccAiBslJo2Tf/yGSSKqk+9dZV4+32hNB5/fBRvUBnhOgNj/GrxWa3k3nUkI+qOgj3CBgYGAyHp9j9tezGDlLsBCg985JdDBKIG+A3PzA09xbXZ9RWdIE+AzQfU+FYfcgd3qdc5Rm7LkKpoymIp+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbQsJY74lsS6ItV2zG8ISz84zkGf5DnMvnhqKsWVAC8=;
 b=BzHjttysbULQQNNAqMFd/a8ljAeza6yvZogK14GpdDvHdCf/yZrP42+HIuNc4+IDJUL8Ts+5GYk9tZNTitSbe5ZWQ3Kkjol8eUPgcjMyZ9c/DZfQ+bx7MxY4igEQiWsI9r/jm/X32jEZfrRUTyrmOv/htO7kUT1+K6WH6gCCe8LdTisuQVNTKFZGyXsDCeRC8+BhldBF0kcjcnD48xZqcLa8aM7DncPFJHk5fM7KOHamAYCq0v4OUKwbdAV+chp0nYS6hvIdqzejz4kXgfGj6pdgRWx+HgSCRqqLurDmyEVtaRBihquJ9WDe7/lWq2LNHS/tma3um61yKwJryW9LoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW5PR15MB5145.namprd15.prod.outlook.com (2603:10b6:303:197::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 28 May
 2025 21:26:26 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%6]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 21:26:26 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic:
 =?utf-8?B?W0VYVEVSTkFMXSDlm57lpI06IFtQQVRDSCB2MiAyLzNdIGhmczogY29ycmVj?=
 =?utf-8?Q?t_superblock_flags?=
Thread-Index: AQHbz+7llMakoBHH1067A7mRQt1Ye7PojnaA
Date: Wed, 28 May 2025 21:26:26 +0000
Message-ID: <e388505b98a96763ea8b5d8197a9a2a17ec08601.camel@ibm.com>
References: <20250519165214.1181931-1-frank.li@vivo.com>
		 <20250519165214.1181931-2-frank.li@vivo.com>
	 <ca3b43ff02fd76ae4d2f2c2b422b550acadba614.camel@dubeyko.com>
	 <SEZPR06MB5269D12DE8D4F48AF96E7409E867A@SEZPR06MB5269.apcprd06.prod.outlook.com>
In-Reply-To:
 <SEZPR06MB5269D12DE8D4F48AF96E7409E867A@SEZPR06MB5269.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW5PR15MB5145:EE_
x-ms-office365-filtering-correlation-id: 425c0faa-cc10-4050-33a0-08dd9e2e4d79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q0NZRGlkeHFKMnB2TzVCaThBcER0NHlkQVVUcUVVTUVJUzVnY2I0Nm16QzBx?=
 =?utf-8?B?eE1FZVNBRlI2YmRKZ3J5TWhSdTgyUE0vSzM1NUduTmNzUXRPWHM0aXBKWGNU?=
 =?utf-8?B?dnU4K3VmSUVHL25wckpWVTJQRUtrNEVOUjgwZmZlSFVJcG01eFd1TmNKdzFN?=
 =?utf-8?B?Z1lmUUdHU0xwaG92Q0hnandycTFXbjlZcmNoKy9DRTBHcitvS0xCVFJKc3lB?=
 =?utf-8?B?UE52WkgwekIrM0pxSk94WDZCQ1lSdzRKTWtidkZwbTJOdVl4cXdGQ1hzMkdP?=
 =?utf-8?B?eVlyNnN1SEFBSFEvODEyZ09zUzJ3S1VmVis5cUpQeXd3MDFIUnZDVnRyMjRm?=
 =?utf-8?B?NTlDOUk0N2RCS0RJVzNQSytmcXBVQlY0bW1jNzEwR24vMmp6R1VTWENtcFlk?=
 =?utf-8?B?WGcrSHg3MTk2czhTaU1xcUlEYVYyTDdZYkJKRURpWGd3djM3VDdiMS9HZFBK?=
 =?utf-8?B?Q0Jia0I2amIzN09MQ0t3ZFhKZDI3MHFDNEF0a29aTWtOdnZRd2s2czlVK2Q3?=
 =?utf-8?B?dDhSRzFqdSthUlppNVVJMExrVVpCSjh2RXJuQWJSUVZQTjROTG5Mc3dMR0tr?=
 =?utf-8?B?Q3ZudEpMREswVFhqdnp6MUlXcDlwRkk1MjhOT0xoQ3NOMXRVRUxNbTFjemo1?=
 =?utf-8?B?eTdpdWdZTURvK3lDeTl0L0V2SSt6b3F3Y0xDKzVSbkNVTERJaGcvVldtSm90?=
 =?utf-8?B?eVBWdnEycjdCaXZBTWNNb2hmd1NybW9XTVcyMDI2T1lINklSSzYxUkpwWjV5?=
 =?utf-8?B?R2IxVVJLbGZUV3FxT2hndkQxM2N3MXJpcjhzaDdDUlVDU2NvZ1o3SU9OQU5I?=
 =?utf-8?B?b20wTFhLR2NUdGZKc0dxcXZLaU1ydGtRRlhRVW4vQ3VRMy9jQkNGTlYyeGZl?=
 =?utf-8?B?QW1XOXdSWWVJcnlIU0YyeFNkOWxNaXF1WFdwd1VxNitTQ2F6eUYxM3IwOWZM?=
 =?utf-8?B?Y1o0dzZXT2RnWjlyWUZ4TzNkUVd6bTNSditOMFA0Z0FFT01QVitqTmNUbTRi?=
 =?utf-8?B?cGxYWlI5cGI4N0lZV1RYNXk4U3ZDL3BZWmJDdXp2SHlxVUw1WGpUZ2p2Mk8v?=
 =?utf-8?B?aXhLMGFPN0dZSUdRckdhbW1YSS9McDJIQU1QZEhqQWt1T29KOEtCNXhWQmNV?=
 =?utf-8?B?cE10UFJrcTBvQ0pXalB2Z3B3Vkd1M1NRaElGVmFqSCtVU0NFTWM2bHRNRkQ4?=
 =?utf-8?B?T1JDN3ZpWldPZE5SSnErelZwNFlxTkxNNzNJL2NKWnlQSXcxRVFjRnN4ME1V?=
 =?utf-8?B?SmdYK3gyK0g4L1FPYWJ4dmxneXV1RldtM0JTckx3UkY5dWFqWHRhOEFqOG1n?=
 =?utf-8?B?bm1Oa1RVZElndndhRk9LdHoyUlpYU3l5OVh3NlNKMEk5QlJoNU9VMlZGMUIr?=
 =?utf-8?B?OFhMdU5oc0RoNXRMMmlYTGhIais4Nk1VdllZZDFsb1ViWTZYRHlVTHYzWEZW?=
 =?utf-8?B?Zi91WkdSVHVtRGZhY1B3M1JTNE1iRjhXaFYvWHY2ajdBRTdCTHEwb2RETncx?=
 =?utf-8?B?TlJvNW9HcnF3NjVpa2ZuTHVWcG1USU9VSkJ1Vklodm55d3daNk5MdWRBeWFR?=
 =?utf-8?B?U3NYU2xTOU1la0VXN2xEODN0Kzd2TFBaQ0dpT3V0dDVEbVZueFIzSktaRHBJ?=
 =?utf-8?B?WGYyRnY4K3hQM2JDVkVSSXJOQk9WR2tlTTNuNW5KM0ZyM2FrOXpsU0NVcE9z?=
 =?utf-8?B?Vjh5TnR1OUZiNWVDRzB2THZhZUdlUWRxbWV0aWQ0eHMvc0NoRHdRZjdmRlNZ?=
 =?utf-8?B?S2pPSkJSYTdLVE1UVkdlU2hVN0xjOVY0b01WWHQyWGIxZGZNejAyN0JidHAr?=
 =?utf-8?B?OXk5Q2pBcFlhM1RwN1c2OWZWalFYc285dng3U2VBWmUzaEliTDNpdHg4WEpu?=
 =?utf-8?B?R1R6d3UwdHdVWGNqTmozN1VOT3JXUHNQQlVmVDMxNzIwTEdyUmMxL2ZLT09Z?=
 =?utf-8?B?MEhlenhyL3kralN0d2pBakFveXZXTU5QRWtJR1ZHU0lmbkpXR2R3QkhnNitp?=
 =?utf-8?Q?TEcnlHyjSgyXy2IZVkcfZ58uGyZOGA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vk9mNDloM1JnNTZ4L1VPUHNIYzlLNWtmVWxHWmRjNkkraVpQMlJuemxBOU1a?=
 =?utf-8?B?VVVUTmlnNkViVWdaNSszWVVjaWFNMWVzb3lCdFJRRjFGb2lUa0d1QzcyTGgy?=
 =?utf-8?B?NnlpaG4xUktkYmtvMEwxVDZhOUtmN2taOVNQUUZrT0N4anlscCsvcnh3bXUw?=
 =?utf-8?B?bmpCa1prR1YvVFNSaUI4anRFZzI2VTluVk5vSUwvcWdqczNOZVpKQjdsbFh6?=
 =?utf-8?B?YUdWWjhjZXgwQ0tVd3UxTnBIMzVyY25mU3lISVFDb1dOcmErL1hJNksyYnE2?=
 =?utf-8?B?QnZRa3FxelBWVjJWZWRQZk1yb2dKVUcwM3YvYklVYlcyUGozb3M1d1hhaTVQ?=
 =?utf-8?B?NGM5RXYzR25zSmlqUCt5N1BIZFJzSzBMR1dLaXRvZ29OMTBUTTRtM05rLzl2?=
 =?utf-8?B?NDFBTGVFd2l3N3pqT1gxSUxHNkVyaUdtMm5qMzhvclprWlcvckdtNm0xK1Jk?=
 =?utf-8?B?cmZLd2xnOHNaSmJaVDR3bmZRem03b0lRM2w1TUFGTmVINXJKbnBVSVFmOWgz?=
 =?utf-8?B?SDlHYlJhN3NKVXA2N2tXTEtTL0FPblhIRWZ6bkhaM0FIenI5UzZLRFJoUGxT?=
 =?utf-8?B?dmlTdE1OVEhoaXhkSzQyMnROamRBeTU5TTA0cG9rUlZ6cDBveDhvTDFhZmdX?=
 =?utf-8?B?Y1l6dTlaNG81OHptUk5TdXNNUVdFYm5sNlNzYkQybEttMEMzWk9jZitvSy9o?=
 =?utf-8?B?dHNwcVk0WGgrNGo3OTUwbTQ2L2sybU9yb000UEJ1cXZoMlpQd0o1ZnBickNS?=
 =?utf-8?B?a1BLcmFsd3hGaXV0bDd0OXQvVk5rWjNRb1VmUWpCbDNDQUN4VnpOMVd2TzVB?=
 =?utf-8?B?ajUrWDRFN2VwTmxXUDZCUkZjbzlUYWxDbm4xeGc2N1VGLzI2YlAvTDB3aHc5?=
 =?utf-8?B?NGFYOWMyVDRtSWpjUmhNMnl6Y2xCT3crdnZRS2F1eEFOZ2kvU21nVjBkM0Y3?=
 =?utf-8?B?b0liWDVqK3JWNVBZQWJDSTQ4aDdQME5aZ2R4WmZ4cHUvR1dTN21qY0N4dGVz?=
 =?utf-8?B?a08wNGdKQVRvUmdjQkRsZTRDQS9vWDhIaXJBWmFZeEhjb2FIcGxlRjB2NmJh?=
 =?utf-8?B?WVJ6bG1vanBpKzFmN3NUQnhxNGZ4a2VsTnZnRnQ0OXl1K3Q4VE1kS2Q3eStx?=
 =?utf-8?B?Y3Axa2pFaHk2T2xCcGJveW5QYm5mVFIvWVFrTHFaQnlNMTZEa0pTYUF6RWRU?=
 =?utf-8?B?enNqb3hVaEVVT3dEQWhlUUp0L2VmWHZGTUZ2L2hXWm9lZ3Flcm1NWFExQUE4?=
 =?utf-8?B?blBEd2FVUFE4VHlKVEtibVp1bi9VU2dPTWNzNXhFVjBkWUQ5eng5blJhenJI?=
 =?utf-8?B?TVYzUEJrKzFXcFQvSHY4YzBqUVQwdUMyajJvZW82dFRlSWdnN3FrWVFESkx1?=
 =?utf-8?B?TnZpSlNuU0pPK0M1MnBqMXFVUlY0NFJZWWNnYVNJK1FIb0dSVXNhajZqYnNB?=
 =?utf-8?B?OUxCOEdvRS9CQ1dkS2lrSVR5SnQ2cUlHYUVYZXZzM0xzUFZIdjA3VUFWUjli?=
 =?utf-8?B?VE5ydERXaWdvTFA4VjBINkwzYVN6Q05kK0NGbmJNU3dkUElDNWM3a2ZHYXhh?=
 =?utf-8?B?czZSYlkxNkk2VG1ibFVmTm1IZXd5K1NoRlZoc1kyVjlNc0orbkxKTjhqSFdo?=
 =?utf-8?B?eTFTa0lZd0hTN0xLMlM0WGZ6azYya0hPWjNiSDdQQ1YySUczdUg1MjFFNkIx?=
 =?utf-8?B?V0ZWc1dVaXN1Y0dwSTZFZEtzektPWmMwWldlOVZnWkFpVW02NFA5WDVPS0ZS?=
 =?utf-8?B?OHhOanE3dTc4bDR6NlJDRGRPRWc4QTBDeFBxUVkrbmF0bEdZQUNkVlZZNWV2?=
 =?utf-8?B?TlpLcWs2VHlNNkd0RW9Vd3g5NDN0R2RoNU9KV3B5R0NEcU1aMllQR2lhbDhs?=
 =?utf-8?B?R0ttbVBBR3J3ck9CQkpiTDdWaEpOWkRGWWFQYjQxK0M2SEdxajMvdDltNmM5?=
 =?utf-8?B?YjA2ZXFubkJQRFFmMFk5emMrZ2hReTZWbzY4dmhSaGRZOHJUNkpaa3ZiaC96?=
 =?utf-8?B?OXh5MGl3cnprMWlPRUZ5V3pkTDJtdjV5d3ppeGR2WnJ6UGlzcmw1bVFwMHpQ?=
 =?utf-8?B?SVhXR21kcVEzb1M1aW1IYzBIZWY5VEVMVUM1cTVXZmVuVUlJVmxjdUVxNDJo?=
 =?utf-8?B?RmNLa2VrTzU2L05UczVkbmhNbHAzdmZJRDJldWpDdmFjYURhNEtrVWhQckNO?=
 =?utf-8?Q?TlGPPvws2AIWqKIbAaBWs8s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BCC02B5B5D9774F8A2F7E72970AC720@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 425c0faa-cc10-4050-33a0-08dd9e2e4d79
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 21:26:26.1392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hlOb/mqVotAXRO+jmeGiO1DfUadejh7sn8iIBsAv2szDhGc+E1sHLBf+SA74FlNeHinc7Roa5IUDGqJXroSH1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5145
X-Proofpoint-GUID: Lujwe0oYt4YWkArfmkmu5bf1pMJNOG7X
X-Proofpoint-ORIG-GUID: Lujwe0oYt4YWkArfmkmu5bf1pMJNOG7X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE4NSBTYWx0ZWRfX050/VyxIdb+5 fdKWdHhaVVsKLGSfhI++qUBjsY2D9LsmkFbh5wCKHpo2yEd2ro35V286Rf+2saH1pT421E0WUhT MawKquxOO6p7wLhOCCBMaWUJLPdDUyeT32NvhEpNM3upIk4NnmW/MOIdro/VLBbhpYUdTIzAiSi
 j4j0qJ6YaweSyEI11u+XhpmnwyXMkxubfeABPInIbvxFDp/remGVCERMEIWe+ZDM1UR8vR3M3de GiCF1F8uv453iOIWeYlVvZ1yn1Jfc4nzOCexLYfFhhi1Fe9TsWgEoCim3CaL0RiIh4Rh31XB21b MJBgsrnKsXcVNMs0nPkW+M7rqJD7TuPhP49ljoerbCxdPT0qY65npULO1WkZ3MHKj6pFnFutyxM
 Ys/ENNJNme3kPC2y8h3r098A1Ktk+frPneFHTUjf4Mz7Ip75EBoAlfDYcbGyHHDSf2JC+lIn
X-Authority-Analysis: v=2.4 cv=L8MdQ/T8 c=1 sm=1 tr=0 ts=68377f84 cx=c_pps a=P9sC8Bi8sKQ63Dw4h0tlng==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=5KLPUuaC_9wA:10 a=43GGxC2FA7WZP3cVRSgA:9 a=QEXdDO2ut3YA:10
Subject: =?UTF-8?Q?Re:__=E5=9B=9E=E5=A4=8D:_[PATCH_v2_2/3]_hfs:_correct_superblock?=
 =?UTF-8?Q?_flags?=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_10,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280185

T24gV2VkLCAyMDI1LTA1LTI4IGF0IDE2OjM3ICswMDAwLCDmnY7miazpn6wgd3JvdGU6DQo+IEhp
IFNsYXZhLA0KPiANCj4gPiBJIGFtIHNsaWdodGx5IGNvbmZ1c2VkIGJ5IGNvbW1lbnQuIERvZXMg
aXQgbWVhbiB0aGF0IHRoZSBmaXggaW50cm9kdWNlcyBtb3JlIGVycm9ycz8gSXQgbG9va3MgbGlr
ZSB3ZSBuZWVkIHRvIGhhdmUgbW9yZSBjbGVhciBleHBsYW5hdGlvbiBvZiB0aGUgZml4IGhlcmUu
DQo+IA0KPiBJJ2xsIHVwZGF0ZSBjb21taXQgbXNnLg0KPiANCj4gPiBzLT5zX2ZsYWdzIHw9IFNC
X05PRElSQVRJTUUgfCBTQl9OT0FUSU1FOw0KPiANCj4gSUlVQywgU0JfTk9BVElNRSA+IFNCX05P
RElSQVRJTUUuDQo+IA0KDQpTZW1hbnRpY2FsbHksIGl0J3MgdHdvIGRpZmZlcmVudCBmbGFncy4g
T25lIGlzIHJlc3BvbnNpYmxlIGZvciBmaWxlcyBhbmQgYW5vdGhlcg0Kb25lIGlzIHJlc3BvbnNp
YmxlIGZvciBmb2xkZXJzLiBTbywgdGhpcyBpcyB3aHkgSSBiZWxpZXZlIGl0J3MgbW9yZSBzYWZl
IHRvIGhhdmUNCnRoZXNlIGJvdGggZmxhZ3MuDQoNCkltcGxlbWVudGF0aW9uIGNvdWxkIGNoYW5n
ZSBidXQgc2V0dGluZyB0aGVzZSBmbGFncyB3ZSBndWFyYW50ZWUgdGhhdCBpdCBuZWVkcw0KdG8g
dGFrZSBpbnRvIGFjY291bnQgbm90IHRvIHVwZGF0ZSBhdGltZSBmb3IgZmlsZXMgYW5kIGZvbGRl
cnMuDQoNCj4gU28gd2Ugc2hvdWxkIGNvcnJlY3QgZmxhZ3MgaW4gc21iLCBjZXBoLg0KPiANCg0K
SSBhbSBub3Qgc3VyZSB0aGF0IGl0IG1ha2VzIHNlbnNlLiBJdCdzIG1vcmUgc2FmZSB0byBoYXZl
IGJvdGggZmxhZ3Mgc2V0Lg0KDQpUaGFua3MsDQpTbGF2YS4NCg0KPiAyMDkxIGJvb2wgYXRpbWVf
bmVlZHNfdXBkYXRlKGNvbnN0IHN0cnVjdCBwYXRoICpwYXRoLCBzdHJ1Y3QgaW5vZGUgKmlub2Rl
KQ0KPiAyMDkyIHsNCj4gMjA5MyAgICAgICAgIHN0cnVjdCB2ZnNtb3VudCAqbW50ID0gcGF0aC0+
bW50Ow0KPiAyMDk0ICAgICAgICAgc3RydWN0IHRpbWVzcGVjNjQgbm93LCBhdGltZTsNCj4gMjA5
NQ0KPiAyMDk2ICAgICAgICAgaWYgKGlub2RlLT5pX2ZsYWdzICYgU19OT0FUSU1FKQ0KPiAyMDk3
ICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+IDIwOTgNCj4gMjA5OSAgICAgICAgIC8q
IEF0aW1lIHVwZGF0ZXMgd2lsbCBsaWtlbHkgY2F1c2UgaV91aWQgYW5kIGlfZ2lkIHRvIGJlIHdy
aXR0ZW4NCj4gMjEwMCAgICAgICAgIMKmKiBiYWNrIGltcHJvcHJlbHkgaWYgdGhlaXIgdHJ1ZSB2
YWx1ZSBpcyB1bmtub3duIHRvIHRoZSB2ZnMuDQo+IDIxMDEgICAgICAgICDCpiovDQo+IDIxMDIg
ICAgICAgICBpZiAoSEFTX1VOTUFQUEVEX0lEKG1udF9pZG1hcChtbnQpLCBpbm9kZSkpDQo+IDIx
MDMgICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gMjEwNA0KPiAyMTA1ICAgICAgICAg
aWYgKElTX05PQVRJTUUoaW5vZGUpKQ0KPiAyMTA2ICAgICAgICAgICAgICAgICByZXR1cm4gZmFs
c2U7DQo+IDIxMDcgICAgICAgICBpZiAoKGlub2RlLT5pX3NiLT5zX2ZsYWdzICYgU0JfTk9ESVJB
VElNRSkgJiYgU19JU0RJUihpbm9kZS0+aV9tb2RlKSkNCj4gMjEwOCAgICAgICAgICAgICAgICAg
cmV0dXJuIGZhbHNlOw0KPiANCj4gVGh4LA0KPiBZYW5ndGFvDQo=

