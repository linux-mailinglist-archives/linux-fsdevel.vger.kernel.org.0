Return-Path: <linux-fsdevel+bounces-74519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8530AD3B5DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 19:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 552D7309BE1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 18:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF7C35B13C;
	Mon, 19 Jan 2026 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c2e7XFrI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE58E32ABF1
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768847286; cv=fail; b=gvW+hIyTw9gOyZRLRVxxZbThNfUDYyzQp01EP0TLz9J3fCuSfZyasgxbdtb2foWpoRpFmOtJ5g7XsjqH8nCNXh/pyCMAHg26N5n5na6ZgRGStqibUabAf6MQvf4da8QMpQcyep3xsVbPW10PkU2LwwD2rQRTYQpchQXLgMMg0Mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768847286; c=relaxed/simple;
	bh=IlPRq01MjCn2RFLic1Gljq+oLlmFHbXAGLSOABtVdq0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=a4ILILUSxNMgvJiwfj6zDBq1YOUuJHpMD3BnOFskL1iK3CVY9x0cAU44m3iM93Yy4Ub/dqxZEmEHlctTnGH/d8VOmcwq7ieepBgjjptWi0d0sZeScoQ9Pslb4EjHfXTiUF2eKZcIQFbp8hz87zNz7z+qNSTGZ+g/60IHQG5Tm+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c2e7XFrI; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60JC1mDf027132
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 18:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=MU6OTx76IyCCVvLuC1+jp7JHci2Oh+clw6mp8q24TQc=; b=c2e7XFrI
	k6xRJXgqWzMgC84oDJH7vNnZwBMdQKZ0Pb4hHpqikmXRr/C+WhglqrQiViEHHj4M
	JtxqIcepuwUlPE65GQbFpGZKmoV0dMOnDDuYZIyh0qVVWrNxGqdtaqgxNZDQ99K6
	CZMQvFIZI4kF3PaVdQxRDUvxY2JrVu1fKjYlBGtYWG5VVfwT7IP3JO8HXX9TSlph
	4Z6oKlsW/Fcoev1ZhKg6iAVObbyAWiUiI6jX7H4NlOyyZ9/PjuI+ezlwKjci22d4
	WBf1ETZhdzxKs07gwMYo+qDlxIu7CWeAAimlmS3UBNP3bQPZRgcWtSpjQtu9KOi8
	Mwx3kazpqgqPiw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br22u949v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 18:27:57 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60JIPTZa015062
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 18:27:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br22u949m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 18:27:56 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60JIRt56019386;
	Mon, 19 Jan 2026 18:27:56 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br22u949j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 18:27:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9MDdRyFc2smKB8gg6fRV1gmgruZAm+64i8R3vFLBB0+UUZQBh670NHvo/k1ndqpM2/4mniqw23J/ffzkjItUcvMq4ISt14q8UfJw+3xD1FJmsSHicFh/w3Wt8FkU/QNkBvSfJ8xVZFCVvlPPWx5B1xsxlnwbiYFgBFbo8IGbRqvxH+tJYbwZ1LKulsCliU80eAmAkBGvhKFgzGSayW5aI631xB9KfGvH35PdO0P5VllSnGzDc2ClyJcgICBUW09NTk2JAveM/PmqTIvs92FlF2UbmCJDINB3XTZRqXtwy/YND3dx7DaRqhEA6bdX9rN8d4iawR8mxUC689GhR8MDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3Rt2ihBs8yZ3eXqiBNcuYLt8paMdt4pAdLYB4CM8SY=;
 b=VAyQ/JscbLLEXGNwy9TJSqyBohPXVJLCZrtUyU9bhjWJe6+3/TIFk7v18NQ98Qeai/TxxNAZc1XcONGcrVddH6xuXFKZVRNg6gE/AEFySve9K961uI69Getqz3RWYbJs2eRF0/Ap6jEh+ZzeQZIfc7zb9khfPSHM8zcJuEEQBWvLhT1Eor2Mp4RcxTetUEQ2ELwNwIGdD/8kJ4+v1caIfF8on1W3IkUW/2dF79n4o3thrb5/cLfd4yoOsaM/cBrvzib8cCVJbYmTLDoGIOCIrNw5iwRYUclIE8P6bzTgi5AzwOLQulGMvTK8Z69LVkO141CcoNtUWb1lsiu24O51UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA0PR15MB3935.namprd15.prod.outlook.com (2603:10b6:806:8d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 18:27:53 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 18:27:53 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "brauner@kernel.org" <brauner@kernel.org>,
        "mehdi.benhadjkhelifa@gmail.com" <mehdi.benhadjkhelifa@gmail.com>
CC: "jack@suse.cz" <jack@suse.cz>, "khalid@kernel.org" <khalid@kernel.org>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "david.hunter.linux@gmail.com" <david.hunter.linux@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org"
	<linux-kernel-mentees@lists.linuxfoundation.org>,
        "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>,
        "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com"
	<syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] fs/hfs: fix s_fs_info leak on
 setup_bdev_super() failure
Thread-Index:
 AQHcXtteFGhLPrTb/UieBFUI+djHs7UFH4+AgABrQ4CAAK/KgIAAvdEAgAKmrwCAA5NDgIBJ1JuAgAMS84CAABTXgP//9iiA
Date: Mon, 19 Jan 2026 18:27:53 +0000
Message-ID: <d714e0652f920cecebf5fdcf0023a440cbd1df4e.camel@ibm.com>
References: <20251119073845.18578-1-mehdi.benhadjkhelifa@gmail.com>
	 <c19c6ebedf52f0362648a32c0eabdc823746438f.camel@ibm.com>
	 <20251126-gebaggert-anpacken-d0d9fb10b9bc@brauner>
	 <04d3810e-3d1b-4af2-a39b-0459cb466838@gmail.com>
	 <56521c02f410d15a11076ebba1ce00e081951c3f.camel@ibm.com>
	 <20251127-semmel-lastkraftwagen-9f2c7f6e16dd@brauner>
	 <4bb136bae5c04bc07e75ddf108ada7e7480afacc.camel@ibm.com>
	 <59b833d7-4a97-4703-86ef-c163d70b3836@gmail.com>
	 <9061911554697106be2703189f02e5765f3df229.camel@ibm.com>
	 <7d38a29d-9d81-42e0-99c1-b6a09afe61fd@gmail.com>
	 <8a96ddbefd84ed0917afc13f91ee0f33ea2e0c10.camel@ibm.com>
	 <4e65ea7b-79aa-4c36-a8ea-0ca84966d089@gmail.com>
In-Reply-To: <4e65ea7b-79aa-4c36-a8ea-0ca84966d089@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA0PR15MB3935:EE_
x-ms-office365-filtering-correlation-id: 13b6dfcf-8ce6-429e-10ac-08de578875a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dkFUaTkvTmlaODNEc0ZTWVFnSWF5NTdVWlhNekNkZXZLTmk0OWZzd05qLzJm?=
 =?utf-8?B?cTVIdjV3UGRHbGJlS1NJNmdWWnkwN3pqMjNDZ0o1blVrbUdqTkF2VWs0dTBs?=
 =?utf-8?B?NVN6OG9JeGtXbnB5a2JiOExrdE1QMDd1ZXRtRG8vc09KOFp4Y3BGTlJUd0Iz?=
 =?utf-8?B?NnQzeFA0UDBYYUo3L052NzNFaW5sK2ZTTU8zNEx2enFLcHUvK2JGc1Z1MTI1?=
 =?utf-8?B?UnpnSmNNVEt6WnB6bUNwc3ZKY2JDYllNOFUweTJqakRPMDUyb25RZDdXaHhB?=
 =?utf-8?B?MVpMMWlkUHZJU3Rqa3hjWE9vL2JwWGw0am9RM3JNTXc3TnJIeEdUN1BxREtQ?=
 =?utf-8?B?cCsvcGVZYXZPa1dKRXlrc0l0Sm1OT0Y0SGwvNHhVdFFpN3JVQ1V0QlMwSmpD?=
 =?utf-8?B?SUNmRjVMeThKMHVzZ3l5RHdkNC91UTlVS3ZDTnJyZm82OEFSS0NmaGt1Wklq?=
 =?utf-8?B?QTRXakRGVGpXZkFJQ1pGUzcvNVI1eVNuUEFjelgrNnlnZTRmTmRONmUwcUVH?=
 =?utf-8?B?R2VEZ3pubkcwMWZSMGl0dDRaRnIvc3JFZHdTU0NwUEJCcG5GdERiMFVrZ0th?=
 =?utf-8?B?RjB5bW5LYjZxSXdhZXpVanQrMElzUm0xeUJDLzVQMkRtaEI4bnYzQ2lPV2ps?=
 =?utf-8?B?YWZGVzczL05GVlhmcTBBOERObWlVZWU1T1hzd1o3dGRQVXQ0T3RiU2RmUmxp?=
 =?utf-8?B?MVNxYmU0NG00MWdoL3RtdEY3eUxSZjJvc09EOVQ0TklYeE11QmN2NDV0am14?=
 =?utf-8?B?dWhFelFxb2kzOHBoc2xJOWZhZWU2OFIrUGdWWXJwdlNmMWNDV3E3UmxyUWg0?=
 =?utf-8?B?Ylh6Z1dRYytJZzhIdUdlOGtmOHdrcWx4L0hIU0NkRldFY1QwKzE2Y0svUmhH?=
 =?utf-8?B?SzhHeUFjT0JmbU9NR2lVTWxWV3FGeHVUZ3lHNmNzRFVZa1hHT0Q5aVBacU10?=
 =?utf-8?B?NXFZaGtOL3BCekR2emYzcktlbzRGbGNmcE1PSXlNTEJEWkJkS2dseWFIWmh3?=
 =?utf-8?B?MWFxNmhnaWtRRzZqWmlBTmpGaDN2ckdxbW83K05Jb29YNEprYkRVNDFsU2th?=
 =?utf-8?B?MGpadGk3WE9lZVhMcm5BNnBSOTQvalJRMHRqQWtaS3RnYzJseXBHekxGNDZT?=
 =?utf-8?B?aFErN3k1RHowNUhzbDVpRGtTUDI2SDdHRmhVVjg3SVdMV2Jod21jR2JmMFd4?=
 =?utf-8?B?VXkxcG5OZ1dTVFQ4YlhEN0Mwakh4WkpKZVNNZWpNMlFMSjRWRU5WOUw2WVZx?=
 =?utf-8?B?Z2tPQW8xV3M2RTFlWDY2UVlNVWl3STNsc3lhVmlHUWFJbVIzSTQ0ejNMUEIz?=
 =?utf-8?B?YmphTWdxQnJBMGJQYXdPR3RYeWpXcVJkbjZBSVFJaUlZV0t5MXNrMzhneVpz?=
 =?utf-8?B?eDVDR0k5WGJkVGNPaFdUSDlGZ3EwdXFzaUNkZEFJM2pzMVdnRGpFcDRrNDFF?=
 =?utf-8?B?MkFKcG5YTjA5V0N3MFlDZXFMLzk1MmxsdEI3ZDIvbjNXZ3k3Sis5L1FqTW9T?=
 =?utf-8?B?b21uRTdDUzNYNXFSNkR3b1RyY204bkVXV0liS0NXUHpBZ2I2STBaL3dSSVky?=
 =?utf-8?B?YUxkekM1T1pqRmtWaGI0NmExQjhTZ3IwYjFCWEdXN05TaHR1V21iYVBYOFQx?=
 =?utf-8?B?ZmtvQ1paMXg3MmwwTXBEZm9zR0JrcmlseHFnYm9JZlZlaXVtQVI0dm1nT3ZC?=
 =?utf-8?B?VlRkQmJtOGwxSTVLSW9pSlNheURqR1VhUVpUNGVSTktuamZGRng2dDVZQnlu?=
 =?utf-8?B?YzRLQWpQeTJ6V3VoeDlhTFd4a1VBSnZkVWxjT3QyRjNqQU1EUVdVSHJQM1F2?=
 =?utf-8?B?OTBSU1prNFNYSGVvaFQzeVpVQW4rYTBPMDAvQ0RSODByNnorYUtLMmpvMkls?=
 =?utf-8?B?NjZwK0hRcDhDdHJGMFhETE9TTVZxRmk2YklzVk9QaSs5SjNaVlJLV3A5eENL?=
 =?utf-8?B?SkdWTGMzRjc3UDFqTmxMYzJDNXBZZUlKNVVHenVkN0tLVTNibXZPSS96R3BM?=
 =?utf-8?B?c2xaR1hGY1piampVUDZaTk00SkxRb054a2RxLzg2VkxsMDQrY0VQL3lBWHRW?=
 =?utf-8?B?S0VReTI4UDBxZG9JMHpFU21wYjlxeWtCeTVnZXJwdHNtZHB5NUFtMit3Y3Ft?=
 =?utf-8?B?bUIwWXVlc083Qmx4eVR4eld0alI4Wll3M2tJNzUzVGJWL0FNcVVZdE1oanlt?=
 =?utf-8?Q?9w6OakGya77C2dNnHO+ulJw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UGJoNTAzb3F4U2hYY1p0aW5YVGE4U1AwcGhrSFZSZEIwNGRxSmg4Tm9qUjZV?=
 =?utf-8?B?UFg3RFlTTzNqNC9IOWE5ZExmL3I4Z2xpWWV2S09KUjlLSjFqL1Nwa0RiajZR?=
 =?utf-8?B?U1ZYeDZmN0w4eUVSNE9Qc0ZsV1JlUjRLS0EvQ0J2NGx5L2o2VXBlNzNvRnAr?=
 =?utf-8?B?RzlyZlJaaUdySjFPd2d6YmMrc3NkeVl1QjN2VmE2c2VXZkdXdlk2S1lGN0Zw?=
 =?utf-8?B?ZGJrdXZ0V1Z1enhYRkRQclM3VFptbk5zTHJvYWJjdkZZckxoVHd2RTVCTWRp?=
 =?utf-8?B?MldWcW1zK09OZU9oTDdZKzVra0F1c29tRHE4U3pMMWdGNmJJN1RrMkFiUkJ4?=
 =?utf-8?B?NmF4dmVibkxWNjBkUHlsTkRLUjVnVGlLSTlXWU9JbXMxdEVBdWpGNHNBVkU5?=
 =?utf-8?B?ckd4aDRPVzdPRVdFWFBoUVUxV3BjVFZrWStOTks2bVRnbnVFOFQ0SFhzQldC?=
 =?utf-8?B?NWpzRFBlWFpiYm14VFZzanFlb3VPa1p5cEYwR1dyVk9pbGFYVkM2Vkd4L1Vw?=
 =?utf-8?B?eWtwOG51ajJHZ1k4TDNOZGFTdHNMVkI5TTMwZnFxVWZuRlZMaGd3N1Q0K050?=
 =?utf-8?B?R0ViUHc3U2ZBWG01K1N6OTc2UHY4djQvMG03amlQRG9zVkNqTDZkOGlmSjcw?=
 =?utf-8?B?aGluSGI2SjR1QjZhOEtDbGZ3YXpNSmtUTEZzVWhqVnBBSTA0RGxjYm5nb3kw?=
 =?utf-8?B?V0NnVTQ3UWNPcmxPdDREMmlrRHl3eDVUMzBxWC95aFMxanBNNllTQjZZeGlM?=
 =?utf-8?B?ZCt2OGcxTm9MRWtEdTRQeXBwb21vZkhYYWtkMmFHU1Bhc2Y3dVY2RHJnZGRz?=
 =?utf-8?B?UXg4UE1GTU9ZK3NQamFqd0J1M1A2N2NGdmYyKy9wOUFDR01kVHhoY3RLeVU0?=
 =?utf-8?B?Q0haZXF3VWdkT0hNVWRaR0J1dERJNHgrQnlFOWdZMnBMYmo5VHFOeVhIQ1du?=
 =?utf-8?B?RjdmZG5sSExPQ1JPNWJveHhnN2pIRHIyTWJRUXh0czkrbUZtZXFkS215dmha?=
 =?utf-8?B?WnIwWFpVVm1HWEJIcnh3NXRTcEpSM0dVSE10azBvaEF0NUtTYTBUWTcrN3ht?=
 =?utf-8?B?ZnhWM2VXdlBWTjMwa0dSLy9RRkgwMlVWa0paZjNzd01rSDdrTTBUU2l2Rng2?=
 =?utf-8?B?cm9UR3o2RkVYeFh3VkU1bjBwRTloNXF3RU1JNnNJdVIvWXNncjFlaDdNVWFL?=
 =?utf-8?B?U1lCVW1TUUo2Wmx2T0pzK0lBa3doMUN3YkZhWS8wdjBDVFRhNlZBYi9HR0s3?=
 =?utf-8?B?UjEwNnN2bFA0UEduL1NuZ25lSTA0bmZKVHZ3eUVYUW9EcmppRG0vUmFDT01z?=
 =?utf-8?B?WmJQWVBldDNHMlJ1N3YyL1VodkhtQm5RRlhaNnhzdEk5MnowRUdrdHEvTVRO?=
 =?utf-8?B?REo3MmU4Y1R2cFdYanVpUHNqcHp5OTlQd3NXWThhRjd6UWpFTkJzRVJXYWhP?=
 =?utf-8?B?UUNKdkVrODJhWlpQUU95dU5taW5hcngzWEpON1QwbmtGSnZ5dm9VeDlKUTVR?=
 =?utf-8?B?UnhzVjhEaVArOFdndzNlT2RVZURLcHlMUjU1S3JOVWV0WkJGbVUzQUFkQmNM?=
 =?utf-8?B?d1hLaUtzSTd4MUxPMUd6WklGZmxyaE9OamozTTJURUdpblcwVWFRUHFnNHFm?=
 =?utf-8?B?MGxtRTkvTjYxVDhUVmtrUGFoODgwN042RG9XWEM5dmJ3ZjV3SDU4eTNQa3Iv?=
 =?utf-8?B?U0d5ZnJjV09PdmNETWlPRzJwdkRqcm9GMmZsWWtOWG03cGRSeGxUYlpnQzlz?=
 =?utf-8?B?aERFUVpuanhYNGx1MWpTS2lWSyt1V2g0U3RybE5Ib3FIcFB4TThSMVdVNnZr?=
 =?utf-8?B?TGJyQWx4Tmx4OUxGOVlUclg3SC9LTDdWWFEyeEptem9oUHNrRlh3V1JudDAy?=
 =?utf-8?B?NnY5OXFkdGIraXZLTzZ4MVluMVZPbi9iZ3E5UXVZMVVNckFGT3FWNExaL1Ay?=
 =?utf-8?B?TnA5T3hBWFNCTEpla2xlOGNNWDJyVkk4K24yQ2s0U1poWFJFM0J6WGJaUTUv?=
 =?utf-8?B?WmlhdW4zL1l4YWlCTTRBdE5uNlE2S2ZFU0I0cHJTUVpieUE1L0x4VHhSTVdy?=
 =?utf-8?B?ZUlROER0ZVBqNzFvTzBYaFI5c2pQWG1CUDhuSlFaVVdUL3NrRGJ4SjZ1c3lS?=
 =?utf-8?B?MFVVbnVTeEtoRVRyR0gwQ1UrSzY4d1g0azJGdUtXSHJpK0NocUorSE5vQ0Vh?=
 =?utf-8?B?cFlKSXlQVGN2Ty9pb0V1QVV5RFY1akdVajlRQ1pmZG1vYzVNVndXNHF3cnk2?=
 =?utf-8?B?ZW5EbVhzU1VtYVpBODdLU1I1L1NKelY1WGJBUWhoOGEzSEJqdW10VmExZzBZ?=
 =?utf-8?B?NmpuQVJtMUNDMHhySitzblFrZEE5RGhPY2VhUVNic0JsMFhJK0szbllQd29K?=
 =?utf-8?Q?4W7VlF5zdG7xUbKPTcvcBPOA87CI8uB6sgGRC?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b6dfcf-8ce6-429e-10ac-08de578875a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 18:27:53.3359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5LKSdmkUE+wTL06xRZ6iEmUx4YZTIHRbv8G5E4qwzTQAxOpPh1d7gAhDyd19WZTqmrsKHXHzPt9s31tMB6ltRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3935
X-Proofpoint-GUID: EyozIR5U_HBERPr6-DXuf75wU4pkglt8
X-Proofpoint-ORIG-GUID: yJxt2kCXe7CEdLrK55FwGJKUla3qnmTY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE1MyBTYWx0ZWRfXw0W2GC8imaoz
 YlyjAWwOOoUfXQpXN8haH1MZ/EGBc2zsyAotKVg/jNxJsEl8ykIf9qUlGuTalQehReULDYpnNg+
 uqTlZB+ir+lZ0xOdEeNHtmdkxaLA/67dt6zWctIdXNh4DFJ+6udc/uaO6J3u6SKfZ3aGpkJIgmA
 Zomk1n8QX85xUgxrgpc/2qPhtXCED5zCP2tQbYg6prg6FIU+euk76UMbU5ETiwW5ObXiZJwMyII
 HSUjc4zEqXh/BVNMfI8tAxStonIHtQkV4xICDmuTQlob//44zEFJjkWW+mbk4srseF7liGJFltW
 JRcyVd0mXv4O90eEOlx1hOjuNKMwPd9pkHibDxDV1wurgv+p+lG2cfF8wVK2/eHIIh0kHqEBRf/
 mxQDp3C1SB2ipDY4JNKB1Yx/gAEk4ipSk8UtNcBBumYCwsaAZ7VFMP60SxiwpN2oMirWXJ+AK1c
 NZ6qvGUEGh6fF0HlsmA==
X-Authority-Analysis: v=2.4 cv=Sp2dKfO0 c=1 sm=1 tr=0 ts=696e77ac cx=c_pps
 a=boTDQTO5XcRoDQ12XycLVw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=hSgIRE9gsdh5SSUujmsA:9 a=QEXdDO2ut3YA:10
Content-Type: text/plain; charset="utf-8"
Content-ID: <A59A0AF87CA5F04D829A00245DAE382F@namprd15.prod.outlook.com>
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
 definitions=2026-01-19_04,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.19.0-2601150000
 definitions=main-2601190153

On Mon, 2026-01-19 at 20:03 +0100, Mehdi Ben Hadj Khelifa wrote:
> On 1/19/26 6:48 PM, Viacheslav Dubeyko wrote:
> > On Sat, 2026-01-17 at 19:51 +0100, Mehdi Ben Hadj Khelifa wrote:
> > > On 12/1/25 8:24 PM, Viacheslav Dubeyko wrote:
> > > > On Sat, 2025-11-29 at 13:48 +0100, Mehdi Ben Hadj Khelifa wrote:
> > > > > On 11/27/25 9:19 PM, Viacheslav Dubeyko wrote:
> > > > > >=20
> > > >=20
> > > > <skipped>
> > > >=20
> > > > > >=20
> > > > > > As far as I can see, the situation is improving with the patche=
s. I can say that
> > > > > > patches have been tested and I am ready to pick up the patches =
into HFS/HFS+
> > > > > > tree.
> > > > > >=20
> > > > > > Mehdi, should I expect the formal patches from you? Or should I=
 take the patches
> > > > > > as it is?
> > > > > >=20
> > > > >=20
> > > > > I can send them from my part. Should I add signed-off-by tag at t=
he end
> > > > > appended to them?
> > > > >=20
> > > >=20
> > > > If you are OK with the current commit message, then I can simply ad=
d your
> > > > signed-off-by tag on my side. If you would like to polish the commi=
t message
> > > > somehow, then I can wait the patches from you. So, what is your dec=
ision?
> > > >=20
> > > > >=20
> > > > > Also, I want to give an apologies for the delayed/none reply abou=
t the
> > > > > crash of xfstests on my part. I went back testing them 3 days ear=
lier
> > > > > and they started showing different results again and then I have =
broken
> > > > > my finger....Which caused me to have much slower progress.I'm sti=
ll
> > > > > working on getting the same crashes as I did before where I get t=
hem
> > > > > when running any test.Because I ran quick tests and they didn't c=
rash.
> > > > > only with auto around the 631 test for desktop and around 642 on =
my
> > > > > laptop for both not patched and patched kernels.I'm going to upda=
te you
> > > > > on that matter when I can have predictable behavior and cause of =
the
> > > > > crash/call stack.But expect slow progress from my part here for t=
he
> > > > > reason I mentionned before.
> > > > >=20
> > > >=20
> > > > No problem. Take your time.
> > > >=20
> > > Continuing on this. I have run xfstests today on the base 6.18-rc7
> > > unmodified kernel ( I will do it again for latest release) and captur=
ed
> > > the crash.
> > > The following is the decoded crash report:
> > > [ 1572.093549] [T1127273] Oops: general protection fault, maybe for
> > > address 0xffffcaa2c1da364c: 0000 [#1] SMP NOPTI
> > > [ 1572.093555] [T1127273] Tainted: [S]=3DCPU_OUT_OF_SPEC, [O]=3DOOT_M=
ODULE,
> > > [E]=3DUNSIGNED_MODULE
> > > [ 1572.093556] [T1127273] Hardware name: Gigabyte Technology Co., Ltd.
> > > B760 DS3H/B760 DS3H, BIOS F12 02/25/2025
> > > [ 1572.093557] [T1127273] RIP: 0010:memcpy (arch/x86/lib/memcpy_64.S:=
38)
> > > [ 1572.093560] [T1127273] Code: 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
> > > 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 =
48
> > > 89 f8 48 89 d1 <f3> a4 c3 cc cc cc cc 66 90 66 66 2e 0f 1f 84 00 00 00
> > > 00 00 90 90
> > > All code
> > > =3D=3D=3D=3D=3D=3D=3D=3D
> > >      0:	2e 0f 1f 84 00 00 00 	cs nopl 0x0(%rax,%rax,1)
> > >      7:	00 00
> > >      9:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
> > >      e:	90                   	nop
> > >      f:	90                   	nop
> > >     10:	90                   	nop
> > >     11:	90                   	nop
> > >     12:	90                   	nop
> > >     13:	90                   	nop
> > >     14:	90                   	nop
> > >     15:	90                   	nop
> > >     16:	90                   	nop
> > >     17:	90                   	nop
> > >     18:	90                   	nop
> > >     19:	90                   	nop
> > >     1a:	90                   	nop
> > >     1b:	90                   	nop
> > >     1c:	90                   	nop
> > >     1d:	90                   	nop
> > >     1e:	f3 0f 1e fa          	endbr64
> > >     22:	66 90                	xchg   %ax,%ax
> > >     24:	48 89 f8             	mov    %rdi,%rax
> > >     27:	48 89 d1             	mov    %rdx,%rcx
> > >     2a:*	f3 a4                	rep movsb (%rsi),(%rdi)		<-- trapping
> > > instruction
> > >     2c:	c3                   	ret
> > >     2d:	cc                   	int3
> > >     2e:	cc                   	int3
> > >     2f:	cc                   	int3
> > >     30:	cc                   	int3
> > >     31:	66 90                	xchg   %ax,%ax
> > >     33:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
> > >     3a:	00 00 00 00
> > >     3e:	90                   	nop
> > >     3f:	90                   	nop
> > >=20
> > > Code starting with the faulting instruction
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >      0:	f3 a4                	rep movsb (%rsi),(%rdi)
> > >      2:	c3                   	ret
> > >      3:	cc                   	int3
> > >      4:	cc                   	int3
> > >      5:	cc                   	int3
> > >      6:	cc                   	int3
> > >      7:	66 90                	xchg   %ax,%ax
> > >      9:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
> > >     10:	00 00 00 00
> > >     14:	90                   	nop
> > >     15:	90                   	nop
> > > [ 1572.093561] [T1127273] RSP: 0018:ffffcaa2c1da3610 EFLAGS: 00010206
> > > [ 1572.093563] [T1127273] RAX: ffffcaa2c1da364c RBX: 0000000000000004
> > > RCX: 0000000000000004
> > > [ 1572.093564] [T1127273] RDX: 0000000000000004 RSI: 0ddc8fa7cb9c9ff6
> > > RDI: ffffcaa2c1da364c
> > > [ 1572.093565] [T1127273] RBP: 0000000000000004 R08: 0000000000002000
> > > R09: ffff89e0966c8118
> > > [ 1572.093566] [T1127273] R10: 0000000000000009 R11: 000000000000000a
> > > R12: ffffcaa2c1da364c
> > > [ 1572.093566] [T1127273] R13: ffff89e085beee98 R14: 0000000000000004
> > > R15: ffff89e085beee40
> > > [ 1572.093567] [T1127273] FS:  00007f9b755ddc40(0000)
> > > GS:ffff89e8af90e000(0000) knlGS:0000000000000000
> > > [ 1572.093568] [T1127273] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080=
050033
> > > [ 1572.093569] [T1127273] CR2: 00007f0cc5b95a10 CR3: 00000003448b9001
> > > CR4: 0000000000f72ef0
> > > [ 1572.093570] [T1127273] PKRU: 55555554
> > > [ 1572.093570] [T1127273] Call Trace:
> > > [ 1572.093572] [T1127273]  <TASK>
> > > Server query failed: No such file or directory
> > > [ 1572.093574] [T1127273] hfsplus_bnode_read (fs/hfsplus/bnode.c:49
> > > fs/hfsplus/bnode.c:23) hfsplus

Probably, we are still trying to read out of allocated memory for b-tree no=
de
despite the check_and_correct_requested_length() efforts to protect against
this:

void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32 len)
{
	struct page **pagep;
	u32 l;

	if (!is_bnode_offset_valid(node, off))
		return;

	if (len =3D=3D 0) {
		pr_err("requested zero length: "
		       "NODE: id %u, type %#x, height %u, "
		       "node_size %u, offset %u, len %u\n",
		       node->this, node->type, node->height,
		       node->tree->node_size, off, len);
		return;
	}

	len =3D check_and_correct_requested_length(node, off, len);

	off +=3D node->page_offset;
	pagep =3D node->page + (off >> PAGE_SHIFT);
	off &=3D ~PAGE_MASK;

	l =3D min_t(u32, len, PAGE_SIZE - off);
	memcpy_from_page(buf, *pagep, off, l);

	while ((len -=3D l) !=3D 0) {
		buf +=3D l;
		l =3D min_t(u32, len, PAGE_SIZE);
		memcpy_from_page(buf, *++pagep, 0, l);
	}
}

Potentially, node_size and real allocated memory is not consistent with each
other:

static inline
u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, u32=
 len)
{
	unsigned int node_size;

	if (!is_bnode_offset_valid(node, off))
		return 0;

	node_size =3D node->tree->node_size;

	if ((off + len) > node_size) {
		u32 new_len =3D node_size - off;

		pr_err("requested length has been corrected: "
		       "NODE: id %u, type %#x, height %u, "
		       "node_size %u, offset %u, "
		       "requested_len %u, corrected_len %u\n",
		       node->this, node->type, node->height,
		       node->tree->node_size, off, len, new_len);

		return new_len;
	}

	return len;
}

So, I assume that it makes sense to check the correctness of node_size valu=
e.
But, maybe, the reason is somewhere else. However, I remember this report [=
1]
for HFS. The issue could be the same for HFS+ too.

Thanks,
Slava.

[1]=C2=A0https://github.com/hfs-linux-kernel/hfs-linux-kernel/issues/241=20

> > > [ 1572.093580] [T1127273]  ? __pfx_hfs_find_rec_by_key
> > > (fs/hfsplus/bfind.c:86) hfsplus
> > > [ 1572.093584] [T1127273] hfsplus_brec_lenoff (fs/hfsplus/brec.c:27) =
hfsplus
> > > [ 1572.093588] [T1127273] __hfsplus_brec_find (fs/hfsplus/bfind.c:118)
> > > hfsplus
> > > [ 1572.093592] [T1127273] hfsplus_brec_find (fs/hfsplus/bfind.c:191) =
hfsplus
> > > [ 1572.093596] [T1127273]  ? __pfx_hfs_find_rec_by_key
> > > (fs/hfsplus/bfind.c:86) hfsplus
> > > [ 1572.093599] [T1127273] hfsplus_attr_exists
> > > (fs/hfsplus/attributes.c:190) hfsplus
> > > [ 1572.093603] [T1127273] __hfsplus_setxattr (fs/hfsplus/xattr.c:340
> > > (discriminator 1)) hfsplus
> > > [ 1572.093610] [T1127273] hfsplus_setxattr (fs/hfsplus/xattr.c:437) h=
fsplus
> > > [ 1572.093613] [T1127273]  __vfs_setxattr (fs/xattr.c:200)
> > > [ 1572.093616] [T1127273]  __vfs_setxattr_noperm (fs/xattr.c:236)
> > > [ 1572.093619] [T1127273]  vfs_setxattr (./include/linux/fs.h:990
> > > fs/xattr.c:323)
> > > [ 1572.093621] [T1127273]  filename_setxattr (fs/xattr.c:666)
> > > [ 1572.093623] [T1127273]  path_setxattrat (fs/xattr.c:715)
> > > [ 1572.093626] [T1127273]  __x64_sys_lsetxattr (fs/xattr.c:750
> > > (discriminator 2))
> > > [ 1572.093628] [T1127273]  do_syscall_64 (arch/x86/entry/syscall_64.c=
:63
> > > (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
> > > [ 1572.093630] [T1127273]  ? do_syscall_64
> > > (arch/x86/entry/syscall_64.c:63 (discriminator 1)
> > > arch/x86/entry/syscall_64.c:94 (discriminator 1))
> > > [ 1572.093631] [T1127273]  ? __x64_sys_lsetxattr (fs/xattr.c:750
> > > (discriminator 2))
> > > [ 1572.093633] [T1127273]  ? do_syscall_64
> > > (arch/x86/entry/syscall_64.c:63 (discriminator 1)
> > > arch/x86/entry/syscall_64.c:94 (discriminator 1))
> > > [ 1572.093633] [T1127273]  ? __irq_exit_rcu (kernel/softirq.c:688
> > > (discriminator 1) kernel/softirq.c:729 (discriminator 1))
> > > [ 1572.093636] [T1127273]  entry_SYSCALL_64_after_hwframe
> > > (arch/x86/entry/entry_64.S:130)
> > > [ 1572.093637] [T1127273] RIP: 0033:0x7f9b7531697e
> > > [ 1572.093654] [T1127273] Code: 83 c4 18 48 89 d8 5b 41 5c 41 5d 41 5e
> > > 41 5f 5d c3 0f 1f 00 31 db eb e7 0f 1f 40 00 f3 0f 1e fa 49 89 ca b8 =
bd
> > > 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 62 13 0f 00 f7 d8
> > > 64 89 01 48
> > > All code
> > > =3D=3D=3D=3D=3D=3D=3D=3D
> > >      0:	83 c4 18             	add    $0x18,%esp
> > >      3:	48 89 d8             	mov    %rbx,%rax
> > >      6:	5b                   	pop    %rbx
> > >      7:	41 5c                	pop    %r12
> > >      9:	41 5d                	pop    %r13
> > >      b:	41 5e                	pop    %r14
> > >      d:	41 5f                	pop    %r15
> > >      f:	5d                   	pop    %rbp
> > >     10:	c3                   	ret
> > >     11:	0f 1f 00             	nopl   (%rax)
> > >     14:	31 db                	xor    %ebx,%ebx
> > >     16:	eb e7                	jmp    0xffffffffffffffff
> > >     18:	0f 1f 40 00          	nopl   0x0(%rax)
> > >     1c:	f3 0f 1e fa          	endbr64
> > >     20:	49 89 ca             	mov    %rcx,%r10
> > >     23:	b8 bd 00 00 00       	mov    $0xbd,%eax
> > >     28:	0f 05                	syscall
> > >     2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<--
> > > trapping instruction
> > >     30:	73 01                	jae    0x33
> > >     32:	c3                   	ret
> > >     33:	48 8b 0d 62 13 0f 00 	mov    0xf1362(%rip),%rcx        # 0xf1=
39c
> > >     3a:	f7 d8                	neg    %eax
> > >     3c:	64 89 01             	mov    %eax,%fs:(%rcx)
> > >     3f:	48                   	rex.W
> > >=20
> > > Code starting with the faulting instruction
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >      0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
> > >      6:	73 01                	jae    0x9
> > >      8:	c3                   	ret
> > >      9:	48 8b 0d 62 13 0f 00 	mov    0xf1362(%rip),%rcx        # 0xf1=
372
> > >     10:	f7 d8                	neg    %eax
> > >     12:	64 89 01             	mov    %eax,%fs:(%rcx)
> > >     15:	48                   	rex.W
> > > [ 1572.093655] [T1127273] RSP: 002b:00007ffc251dfbd8 EFLAGS: 00000246
> > > ORIG_RAX: 00000000000000bd
> > > [ 1572.093656] [T1127273] RAX: ffffffffffffffda RBX: 0000000000000000
> > > RCX: 00007f9b7531697e
> > > [ 1572.093657] [T1127273] RDX: 00005617e5af5990 RSI: 00007ffc251dfd70
> > > RDI: 00005617e5af9190
> > > [ 1572.093657] [T1127273] RBP: 00007ffc251dfd60 R08: 0000000000000000
> > > R09: 0000000000000000
> > > [ 1572.093658] [T1127273] R10: 00000000000002a1 R11: 0000000000000246
> > > R12: 00007ffc251dfd70
> > > [ 1572.093658] [T1127273] R13: 00005617e5af5990 R14: 00000000000002a1
> > > R15: 0000000000001ae7
> > > [ 1572.093660] [T1127273]  </TASK>
> > >=20
> > >=20
> > > Should be noted that before the crash, dmesg shows that the generic t=
est
> > > 642 is stuck repeatedly trying to "replace xattr" which is triggered =
in
> > > the __hfsplus_setxattr() function under fs/hfsplus/xattr line 354.
> > > relevant dmesg output:
> > > [ 1571.407168] [   T4294] run fstests generic/642 at 2026-01-17 14:49=
:36
> > > [ 1571.892677] [T1127270] hfsplus: cannot replace xattr
> > > .
> > > .
> > > .
> > > [ 1572.092869] [T1127271] hfsplus: cannot replace xattr
> > > [ 1572.093234] [T1127270] hfsplus: cannot replace xattr
> > >=20
> > >=20
> > > If more information relevant to the crash or more testing is needed I
> > > would do my best to help.I will also provide more crash info for the
> > > 6.18-rc7 patched kernel and 6.19-rc4 base and patched kernel soon.
> >=20
> > Could you please test/check the issue reproduction on current state of
> > origin/for-next branch of HFS/HFS+ tree [1]?
> >=20
> Yes, I will do it now and get back to you later tonight.
> > > >=20
> > > >=20
> > > Also I wanted to check on the v3 patches current status. Do they need
> > > more revision or they were missed to be merged in?
> > > > >=20
> >=20
> > I've already applied your patchset on HFS/HFS+ tree [1]. You can see it=
 in
> > origin/for-next branch.
> >=20
> Ah, I missed that. Thanks for the heads up!
> > Thanks,
> > Slava.
> >=20
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git =20
> Best Regards,
> Mehdi Ben Hadj Khelifa

