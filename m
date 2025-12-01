Return-Path: <linux-fsdevel+bounces-70367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C5FC98D8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 20:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 259F534535B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 19:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D35823BCF7;
	Mon,  1 Dec 2025 19:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eTFJK+sw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB8B1B87C0;
	Mon,  1 Dec 2025 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764617059; cv=fail; b=sEAGJPSQli3ArKpRGJzNMg4zkGHrlyl82YcrX9qslN5Kvmjd+fWT+tgM5D11L42eWQUAlwhmMnEkBS9qiX47HyiOj1WOStZafcJO8eEVBYPRxAF6t49JXvfajb4ARgSACDK3KG8AhMwFGVaz2RGNwb/nhD121tmUO7msmB7fAXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764617059; c=relaxed/simple;
	bh=+gC1DuYLvgYtaCeO/xAghgTjWwtsmVv2R08IVXlhlfQ=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=eqGCpor8UxrYOQlnMJAlraKaahMaq7QAcDV++VzgaRzNeoEFiJe85nYg+DOYkvJedEafyFNb/1w6XOB82/4Fvm1Ixnmxq/ieU9GeRC/cYIAfTHK0dHAQOHQUM4W23cO/zLJ8E/6kyF3drfLKFTUAPMejMrYkDepStGJ33enZWUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eTFJK+sw; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1DA6WS016366;
	Mon, 1 Dec 2025 19:24:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=+gC1DuYLvgYtaCeO/xAghgTjWwtsmVv2R08IVXlhlfQ=; b=eTFJK+sw
	DMuC/Ffsp1mZ6K+sjLSVJlFsbUiz0/DjHuz1R/A5pKPj2vYSLetqQSNUoZxHErTU
	10f6oJPkgBBord4PDCEwWYTsFM3HszUGBpgsUx0IfzCU/xoS2cTAZ057KzezXOGA
	nwodVziCKO4TKnE9CECWmpMk83xyjiDk3KZUf4cH56Gp1QAr57qKr4uqMPjz8CB9
	J1vJUSHVMRKffzgDJKVQKQCUZRugk7XAbuF+jRlpYoJCejLkHrI5c8eSWkHJUvNg
	wyXy7+i1DniNr8gMxf6gWIBbkJeIgOH9SJsm+ruCfQqQyivwP3tOfq1OyWrMSYeZ
	32iANrumbk7/wA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrj9h2te-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 19:24:04 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B1JO3uX003586;
	Mon, 1 Dec 2025 19:24:03 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013045.outbound.protection.outlook.com [40.93.196.45])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrj9h2tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 19:24:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0ufcbGBCy2Fa45AEffYV5kMkQGF0FWz2IJ5T6I620AKW+l9ocpqGtmWuNZlzuE70W6hGm/7kMRnpWHapeLmKg3wN/frIFzOKH+0xxA8fdfUd8UVUZ8lpxQSn1Sm+6S8qozXbqvLDuOiST1ERUDOnpryYjqTP/hbnJKHEDUiYL/c6RHDAFOagvxoKPklfeULdlszkq6Potro0/0jMkmf7K6tVhX9AJ4/8E366Rf5K9xkGYjD6ErbEKdCn0YedsAw//2X6XjrRTPZGpCPqcPw3MzSD/C7zRt1Mm5FfwAzI4PwiQa1QUhki/eRdbeJGz/oZanqFCAAJGVeZQ6Vq2ZsNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gC1DuYLvgYtaCeO/xAghgTjWwtsmVv2R08IVXlhlfQ=;
 b=DRVLfV7g92mOvnOWhd4x1l1DI6qE1idKTnGxAs55cDfxE6m4DQPwQhUxbJTONpDn3XT4vpXd2GVDFgTLeBEalDIEMNKtgyzLsZnBnZxMfEdrteUGXcRBUV7K5qsDsqU3vAj1+9lH5sLpmT0/YEUqyDlsiHY+i8kg7oy+1FkjVUHmUztA2SnSEWUpmNdyH06DbLLuFk3ZKHBNUVCxcmZsS74VWqimkamjrigpTgQBrEoFpuzW6O5evS4Rfscui8XqNOWpgKOADY+t4bSECWYxE8B2rsd0vmRyTkdhtoVTu1+3MYSLJrDQ41oxtb9YnFh3YqbbiGKEyiE3qH7mFIebJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CO1PR15MB4954.namprd15.prod.outlook.com (2603:10b6:303:e5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 19:24:00 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 19:24:00 +0000
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
        "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>,
        "syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com"
	<syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] fs/hfs: fix s_fs_info leak on
 setup_bdev_super() failure
Thread-Index:
 AQHcXtteFGhLPrTb/UieBFUI+djHs7UFH4+AgABrQ4CAAK/KgIAAvdEAgAKmrwCAA5NDgA==
Date: Mon, 1 Dec 2025 19:24:00 +0000
Message-ID: <9061911554697106be2703189f02e5765f3df229.camel@ibm.com>
References: <20251119073845.18578-1-mehdi.benhadjkhelifa@gmail.com>
	 <c19c6ebedf52f0362648a32c0eabdc823746438f.camel@ibm.com>
	 <20251126-gebaggert-anpacken-d0d9fb10b9bc@brauner>
	 <04d3810e-3d1b-4af2-a39b-0459cb466838@gmail.com>
	 <56521c02f410d15a11076ebba1ce00e081951c3f.camel@ibm.com>
	 <20251127-semmel-lastkraftwagen-9f2c7f6e16dd@brauner>
	 <4bb136bae5c04bc07e75ddf108ada7e7480afacc.camel@ibm.com>
	 <59b833d7-4a97-4703-86ef-c163d70b3836@gmail.com>
In-Reply-To: <59b833d7-4a97-4703-86ef-c163d70b3836@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CO1PR15MB4954:EE_
x-ms-office365-filtering-correlation-id: b05c9fc5-fb96-4d74-f4fe-08de310f2e1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TUNrZ3NEemNmUGZ5TExBQlBqTTZUcUZvdVBCekhEdHlzRUZPREF1VU5jTFlT?=
 =?utf-8?B?L0Ric3RQcjVzN2p3ekhFVlg1YTlRYThaWnI4ZTg0dC9LVERUMEh3TzRkc2xW?=
 =?utf-8?B?ay92Y0JZdmZPVEJiTXFHcVpQWDNDYTNHditGeGYxWm16M2JvNnYxZjEwYS83?=
 =?utf-8?B?eDVMM2ZaWWI2bTNma1Z3a0doNUQ3N1RwOCs5OHI1UndKVEoxaWd0QU1Ddldw?=
 =?utf-8?B?dGtPZ3FtdzREVDlMZzBMbXBVblZxaGxpNXJnVG9QQkNCdjlUN0pqSzJucnF1?=
 =?utf-8?B?ZFpnT2hwS013TC92cGpMUTJZQURaTnJ6bU0yQjhpQlA3VXpKMTVXWC82ZUgz?=
 =?utf-8?B?bE5PT0VxNEhMejhiRG1tNlNqVkpuck1SSit4aFFUcnRDY0YvZmsvaXpnQ3pn?=
 =?utf-8?B?VkZUeGFXUnlHcVRaSFo2T0NTeVlJM3NLamJLM3g1SzE2a2JLQkdBR3NldVdW?=
 =?utf-8?B?V1FpUUxDK0dUNnZBN2tzQVZRc0w5SzRVOEszTGk1ZEptRHZZd1JNT00wK3lH?=
 =?utf-8?B?cWNxSGxHcVlmUDVYWjJQRGVQQ2krUzZQajd3TDFSVEpCcWg0blMzNUFHd3pZ?=
 =?utf-8?B?Uk05M0x6b1FWc0ZJdldHcFh3d3NCN3JqYzVNdDJiVGVWOXdIMVJFakpqMUls?=
 =?utf-8?B?aVRBVHF6djhKRlBNTGlaOU91bVI4bEl2bzVTQTVpcC9nSEdpa2ZtbHpucm5Y?=
 =?utf-8?B?SWFDQ3NwdW5QUkJlQWx4b1EraTlpSHQvbG90K013K0FUSkdxUURCU1JCTnJT?=
 =?utf-8?B?cGFlSDBYdm5wMnpFYm1qc1p6d29LQ3dmVEhYTk9MVStPNnRGVzkya1NoS2pC?=
 =?utf-8?B?ck44WUJYdGd1TUJrNXVMZE41YzdxL25rSVRBeG1vcm9FK0RRZDQ3WnNTVCtz?=
 =?utf-8?B?bjVCSndYVzFWOTZQRUZqckxBakUxeFdHbXV5OWtudHQ3bDh4bDNsVlg3dXcw?=
 =?utf-8?B?ODk1SmtLWE1DZjZqR2N0dmdoK1RkZFptS1dleUdRRmp4bFpDOCthQjFBODl0?=
 =?utf-8?B?Z1ZKMjJwMGtRTjhlV0svTVVGU3lRSGhITjRrZVJ3Q1JOYUFMbTFaNUp6c2kr?=
 =?utf-8?B?dVFjdi9IYzRpVkJtUUNMMWNaVUQ5ZC9pTEdvOFFOMzNzdFRtcjJXL1RMaFIz?=
 =?utf-8?B?WmNWbU1zYTlqQVFzRXJZTU5SWUdTTG1oaGQ1Y2RwdUFRQU1zM2pvTnFxMHJH?=
 =?utf-8?B?WVgyREJiRzBlZG9tY0NGNmFpVXNkUFV2SzJvNTgvZzB2MWtWSkhOUWR2UDU4?=
 =?utf-8?B?Q1doUENCbUZrNmw4QzFIcTZEUklyUERvYmVHelk1MWJqOXdVTHhEelF2b3Z2?=
 =?utf-8?B?dHpZd0l0ZzZsMndRZU5pMno5RUZ3RnVTYmsyYlRoSm1WZkd1UHZGVFpaNTBl?=
 =?utf-8?B?akt5dGFJZmNqS0xZL3lZZDVxYWcyczVhM2t4c3NwR3FXRFliSnZ6eU1TQ2tj?=
 =?utf-8?B?MmlBWFJLQ09qR0FZMHJ6QVM2TFJSUXI5S0UvR0ZNdVVhYlkwSGt1cDZRSGt2?=
 =?utf-8?B?ZmJZa3FIVzRaNFNpZGpVRVdNdGdaVDBnUG1XSThjT2QrQzArOEFGSS9ZUWhr?=
 =?utf-8?B?VEVGVk9vK2FXM01QcjdIUkdaMnprWCtKaDhkaEpvZm5JZHR3ZkNGV2hGRUdk?=
 =?utf-8?B?Z2ZSNUFFMUpUMEF3ZCthRkRZc1B2UUpDNGdWaEowTExBcjZiLzhIZ1hFQ0Ex?=
 =?utf-8?B?MnVhNjVMaE1nUGVHbnFXcnQ2b0RyWW9tTUFDWlBpcTlpQ09jZTZyMWE3UTdz?=
 =?utf-8?B?Mk1BemRoRzN1RzFzRFAwTFRZVndWdHI3ODVDeVNUeTErWXJvMWo0NS83dFd6?=
 =?utf-8?B?dVhERFlPbVRBS2o5TlFzVjRxYmNkODdZWkhFYkZCeE5kaFd6dzNRcUR1Qm5U?=
 =?utf-8?B?MlhzTGE3cC9UcXZNMHpoaEhKc2RKbW1hMU52RHBtT3ZXNHk4bHRIRmVtcnRO?=
 =?utf-8?B?LzBjZlAvSmxQaTB4ZlBBdDFZcWVaUDE3U1A5RU1od3dWVWxjb25CWE91VDJ6?=
 =?utf-8?B?RExLMFBRYXJPazVEWFZXRFNXcFcrdXlVbWVVRDNKZFpkd081N01MRzNmQzJj?=
 =?utf-8?Q?1cLyrk?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WUVtckZxYll3VGFQblR2RWZNczRHenFIV0JSYWJDVnFkTXF0eG11V0Y1QURt?=
 =?utf-8?B?cG5RMk4vYWppK2RqZVo4TjFhOHBJQmFLVUNJQjNVWUw3TW5XRVRxYVlpNGdz?=
 =?utf-8?B?Z1g5STlBbTR5d3dZWllmNjJ3YUxpdkxYSHlvMmd3bWQyZVM5SjgwQjVQSDln?=
 =?utf-8?B?eGdHWmhxcXNpOXZIWXFBUS9oVTBPbWhsUW8rcjhhK0hyNnVQU3ZYVVVVbGIx?=
 =?utf-8?B?K25uemRYcmFkUHhZMWxraHU0dncwWTFJZnlsTFFEVU9EeE8xSWNIeVk2dGZP?=
 =?utf-8?B?NVJSMkU5ckwvRFJmT051bitSTlhwdytHZ3puZWduOXJEeHB5elV5V3dTdnJi?=
 =?utf-8?B?bmwweC9oeE5UYmtDMG40ODlEb2ttV2xHNWNodFFnMEc1YXFaV05TRVp4VXZ1?=
 =?utf-8?B?TnhxR1ZKWm04cXVKVk9sZTg3MVNtOUNrVFhVRmpJVEc4dGF6TCtGN3p1MmNl?=
 =?utf-8?B?aTZxdXR1dVRlYmFSdWxENG9ud0JidDU1TVRKK29hN2xEMm03eFlJZ2wrN2tR?=
 =?utf-8?B?WUdmejVuREVlcWpBTVVHVUxlL2JtazdvQUsrZHJsdEZabFZOYXQyazBLWU5m?=
 =?utf-8?B?b2Q2UGhFVnNRZkx5R0FOMk9yVFg4cWl5VkNIaUlkSjFLYlF5cjdIWExWR1Ra?=
 =?utf-8?B?TlFUekNTUzliZnBBZnBjWnpRRHRRRzBwVHVEVnM5b2RWcGx4U2NLc09ZeEU3?=
 =?utf-8?B?elA1elpHMHZDajlTWlVCNUhzTHJRVUlZTkVHeE9pRWptdEpFaUtDYk5CcUdC?=
 =?utf-8?B?SDBBakRUaGJNYldwbFZlZzZmY1RROWxlSlZ5c1VyREVkZmE1allhOWpDS0dQ?=
 =?utf-8?B?WUh2Y1JWMm0vbjIxZkhPU0dDb2QxSUpNby9ZRmNMVDVnNGFQcTZ5cmJxR1Vv?=
 =?utf-8?B?amtRdDVSK1hSUjBGd3NKUWhRb2NWWkdvZjR1dDFvc3NsZW1jYmhsWnA5ck5z?=
 =?utf-8?B?R1VhS0J0NG1CSUh3dWtFRmM5ZE1VSFFyazVHQ1hOOUdqTkdDenZ5NWlTQkFS?=
 =?utf-8?B?eHE0Yk16cTZUNngwUDFzb1dGTll5ZEhTbC9DVS9hcjNHTStZTllsRlhCV082?=
 =?utf-8?B?V0l0QXNFUnN3emY2RGFXYVpGRVpQSThvdEYrdG0vU3Q2T1FxOXdGeE9yV1pW?=
 =?utf-8?B?V25FTHFFdnI4TWlYZzVXWlNnekQ4T1NxdmdCT2dSbnEwMFVEaWYzdHZ6VDJL?=
 =?utf-8?B?eGF6aE5xR0NJUDg5U3lTN2EwbWt1a25JY00zV3BpdzRkWTlqODRyWEsxT0la?=
 =?utf-8?B?VmI3cVA1aHhMZWpkWGFzMkFuRCtXZG0vZzRUMmtoOG5XRjFyR21NejY5TGtI?=
 =?utf-8?B?eDJLdE83ZFpXclFzTGU0WnE2bTRYamc5V2NvOFlTcTFIaE5adEwyU01YQmpV?=
 =?utf-8?B?Q21GRkx1ajVDZVcxbllTdUxrbmYybFRuWXFWb0c0TDZMemtNQ0t6akorMHhU?=
 =?utf-8?B?RytZdys0ZTRlZDMzemdhZWNUblpwMVkrbnRLV1M1RnQ5cXRTcHpUWU54N1Ft?=
 =?utf-8?B?MjRnTklBSis1Tlhxa3JSQVYrTjNhWWJlRTMydEtNS2RWZElrRFpzUnZjS3dG?=
 =?utf-8?B?SlFwaFhUMkFxR1FqeWg0QjhvVTZxNEQrbmpXakJ6OFJJTWtBaVJPV3Vnc3Yy?=
 =?utf-8?B?bWVzMFlIalVuaE40WW9TbjEvUmdWQWFLcUVoUG1hMm5IME51c0VRS2lKb2lR?=
 =?utf-8?B?MG1CdkRWYzBDYWI1M21FQ04yNjZBa2RTNjY4YndraHN1MUdRcFNRNjZFSHBa?=
 =?utf-8?B?S3YrbWlaOU5rdGxaamMwVWdXUEo3MjREV1NhWkh2QnlCZkg5ZCsxTEZDWHAr?=
 =?utf-8?B?bFY4SEZEWW4ycDBTUEpHTFVRRThSL3EzaVVuVjJyejBPUjRzNnNSdjRqbXNs?=
 =?utf-8?B?cXlvSTE1T2ltSzJKaFQ2SlZSek1zdG92QXE3dExHdGh2MnhQYkpRb2pUZThT?=
 =?utf-8?B?dnRPaFZWM2UyTmEvQXZuUzFXR2Fud3h4WkRvaXhVUmlsVi8wczNSbUVHNlVU?=
 =?utf-8?B?T3dETCtpbVhUVUgvSHg2K2VnUHp3dUJBSWpjbm90bVVnNVRKZU5sQ2ZkbE5y?=
 =?utf-8?B?Zi9wS205U0xGZ1pacWdmUm45NkdETEpQSnVYMGxISHd2aFBMaW1ENXhoWnNR?=
 =?utf-8?B?WXJRTnI2UkJHRm9tUHNsWTI0N2lmWEgyT2NnYnBkNDJ4anZBNzYxUXlxUjd6?=
 =?utf-8?Q?NGmWDGYIO2VWj+wWevz4saI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <567330B820728B43A4E5CD15ECE8356B@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b05c9fc5-fb96-4d74-f4fe-08de310f2e1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 19:24:00.0769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hBXOaeFHVL/dYGpyp9QI9femzeYCNIaw5jQSsGkm774PsVJj7D1KwAbRrPdtlRMceTT89IGynMTheILgfSnP5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4954
X-Proofpoint-GUID: RlSp574f_3d4mlm4K-JliSWGaTlmCNF8
X-Proofpoint-ORIG-GUID: PENpud_7TQYEHSTf-F5TUBoDJ3hpKKvw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX3T5s7xgJsXze
 rBtfz4LId94jvzHLvVyAaA2s8MtptXe48mpmsNBdGtZ9FdOQXOKzZamUDXTPULBZt4RylguXd0q
 FcfxXqVMF5C9SbGR0le8PVdRymKOwMSONMYpQxcvKfOnBbmGaiGBuPNEbv7eDACtEf5jqRCxqC9
 cYLHxhDr0srlbES5PLF6vFOMoiq4ZGAC4+fB2nYcx7JgxdxoeuEoQ4YcHijhRBCLSis2Xy7VFHO
 T9faOhcjNhc5JiqAcr0xViWfAX/S64WEUD1faTab7M5lMvHOLAgV5Ezi65jd6P3slK1lEO4CFFH
 np9P3eyRaeuMZSxtbNfW1UKD5/XCFafM4GDPsXvUMI8BvsRSwVC1wo7u5Puk0kk6Zv7u/zJm+Sa
 zOD6dCnx4rZEm5q0XhImdfTrPmcESw==
X-Authority-Analysis: v=2.4 cv=dYGNHHXe c=1 sm=1 tr=0 ts=692deb54 cx=c_pps
 a=9wPeeuiWglyMylSd9qupQA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gnzxNsoMRqwayxtsT8AA:9
 a=QEXdDO2ut3YA:10
Subject: RE: [PATCH v2] fs/hfs: fix s_fs_info leak on setup_bdev_super()
 failure
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020

T24gU2F0LCAyMDI1LTExLTI5IGF0IDEzOjQ4ICswMTAwLCBNZWhkaSBCZW4gSGFkaiBLaGVsaWZh
IHdyb3RlOg0KPiBPbiAxMS8yNy8yNSA5OjE5IFBNLCBWaWFjaGVzbGF2IER1YmV5a28gd3JvdGU6
DQo+ID4gDQoNCjxza2lwcGVkPg0KDQo+ID4gDQo+ID4gQXMgZmFyIGFzIEkgY2FuIHNlZSwgdGhl
IHNpdHVhdGlvbiBpcyBpbXByb3Zpbmcgd2l0aCB0aGUgcGF0Y2hlcy4gSSBjYW4gc2F5IHRoYXQN
Cj4gPiBwYXRjaGVzIGhhdmUgYmVlbiB0ZXN0ZWQgYW5kIEkgYW0gcmVhZHkgdG8gcGljayB1cCB0
aGUgcGF0Y2hlcyBpbnRvIEhGUy9IRlMrDQo+ID4gdHJlZS4NCj4gPiANCj4gPiBNZWhkaSwgc2hv
dWxkIEkgZXhwZWN0IHRoZSBmb3JtYWwgcGF0Y2hlcyBmcm9tIHlvdT8gT3Igc2hvdWxkIEkgdGFr
ZSB0aGUgcGF0Y2hlcw0KPiA+IGFzIGl0IGlzPw0KPiA+IA0KPiANCj4gSSBjYW4gc2VuZCB0aGVt
IGZyb20gbXkgcGFydC4gU2hvdWxkIEkgYWRkIHNpZ25lZC1vZmYtYnkgdGFnIGF0IHRoZSBlbmQg
DQo+IGFwcGVuZGVkIHRvIHRoZW0/DQo+IA0KDQpJZiB5b3UgYXJlIE9LIHdpdGggdGhlIGN1cnJl
bnQgY29tbWl0IG1lc3NhZ2UsIHRoZW4gSSBjYW4gc2ltcGx5IGFkZCB5b3VyDQpzaWduZWQtb2Zm
LWJ5IHRhZyBvbiBteSBzaWRlLiBJZiB5b3Ugd291bGQgbGlrZSB0byBwb2xpc2ggdGhlIGNvbW1p
dCBtZXNzYWdlDQpzb21laG93LCB0aGVuIEkgY2FuIHdhaXQgdGhlIHBhdGNoZXMgZnJvbSB5b3Uu
IFNvLCB3aGF0IGlzIHlvdXIgZGVjaXNpb24/DQoNCj4gDQo+IEFsc28sIEkgd2FudCB0byBnaXZl
IGFuIGFwb2xvZ2llcyBmb3IgdGhlIGRlbGF5ZWQvbm9uZSByZXBseSBhYm91dCB0aGUgDQo+IGNy
YXNoIG9mIHhmc3Rlc3RzIG9uIG15IHBhcnQuIEkgd2VudCBiYWNrIHRlc3RpbmcgdGhlbSAzIGRh
eXMgZWFybGllciANCj4gYW5kIHRoZXkgc3RhcnRlZCBzaG93aW5nIGRpZmZlcmVudCByZXN1bHRz
IGFnYWluIGFuZCB0aGVuIEkgaGF2ZSBicm9rZW4gDQo+IG15IGZpbmdlci4uLi5XaGljaCBjYXVz
ZWQgbWUgdG8gaGF2ZSBtdWNoIHNsb3dlciBwcm9ncmVzcy5JJ20gc3RpbGwgDQo+IHdvcmtpbmcg
b24gZ2V0dGluZyB0aGUgc2FtZSBjcmFzaGVzIGFzIEkgZGlkIGJlZm9yZSB3aGVyZSBJIGdldCB0
aGVtIA0KPiB3aGVuIHJ1bm5pbmcgYW55IHRlc3QuQmVjYXVzZSBJIHJhbiBxdWljayB0ZXN0cyBh
bmQgdGhleSBkaWRuJ3QgY3Jhc2guIA0KPiBvbmx5IHdpdGggYXV0byBhcm91bmQgdGhlIDYzMSB0
ZXN0IGZvciBkZXNrdG9wIGFuZCBhcm91bmQgNjQyIG9uIG15IA0KPiBsYXB0b3AgZm9yIGJvdGgg
bm90IHBhdGNoZWQgYW5kIHBhdGNoZWQga2VybmVscy5JJ20gZ29pbmcgdG8gdXBkYXRlIHlvdSAN
Cj4gb24gdGhhdCBtYXR0ZXIgd2hlbiBJIGNhbiBoYXZlIHByZWRpY3RhYmxlIGJlaGF2aW9yIGFu
ZCBjYXVzZSBvZiB0aGUgDQo+IGNyYXNoL2NhbGwgc3RhY2suQnV0IGV4cGVjdCBzbG93IHByb2dy
ZXNzIGZyb20gbXkgcGFydCBoZXJlIGZvciB0aGUgDQo+IHJlYXNvbiBJIG1lbnRpb25uZWQgYmVm
b3JlLg0KPiANCg0KTm8gcHJvYmxlbS4gVGFrZSB5b3VyIHRpbWUuDQoNClRoYW5rcywNClNsYXZh
Lg0KDQo+IA0K

