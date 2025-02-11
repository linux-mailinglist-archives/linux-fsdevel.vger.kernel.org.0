Return-Path: <linux-fsdevel+bounces-41490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDB7A2FED2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 01:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBDCA1883F45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 00:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654821DA23;
	Tue, 11 Feb 2025 00:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cNsYmVBy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC0517580;
	Tue, 11 Feb 2025 00:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739232510; cv=fail; b=n0ETQIdDwt6bfY2Emw6EzDAEqQjWoRoR7Nd9FtAPzDr3R4oeO3yVNDFkxdb+ntuGlpwklBwsiGx1C7lQuF1NCjlDzd+qljc2PJet5155t/5+nrsmTs3YCMEsM4Hv1NI27RAxNtmmpBN7VoJAG4oEaopz8Y7rSDih0HJK9ihcx7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739232510; c=relaxed/simple;
	bh=I8CAhe7s5/Iiu22q/53nctagny1SweyXorMGgLtXaPw=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=m65iuxAb9SaMH30mhIPC4XKJ8F3wFYYkMCHJos+qFFRxpT5jcKJFz3AZd1CfG1Rtpt9Djydl7giXaH3g31Pdp2Wby6NxeRTkQw9lOM/CmcepiNDey0hJAg6nzI6AyBXjUlS0ubNAu4PjX72viE3K7dqFvTCvr8PZOXXOtjKglcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cNsYmVBy; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ALTPdO014011;
	Tue, 11 Feb 2025 00:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=I8CAhe7s5/Iiu22q/53nctagny1SweyXorMGgLtXaPw=; b=cNsYmVBy
	J+3wM1q4O61b4MXn/Wtyeq31NQUZvjZKHQV1huMC3dYH5no9aqyoMwYVIw0Rm1na
	gg8ywbeNSxe4xSMKgKTwa/uBgaP5zXJVxHMNSPYh8+/bLBNi8kE+PHEt2LOHn2CE
	r3XL21HOU1MXzUi+LRzGsJJc6c8ZTmo+rPhppY3Wx9B41XJnWtmGB/msY5cPo0U3
	1cHpKZWDthljNfX3K/ysNsClbrREguhhdKV7vhS0bDof9fVE2Ock6uWBhgqd/1jN
	R7nR7l3CxAroKvo7PPZUt7N3/Bwrl7Z4z9ynnLhantTlpxmDQQWhZrwPC2X3tO6/
	H//0UpYpayr6Ag==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44q89ywjq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 00:08:25 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51B08BLJ025708;
	Tue, 11 Feb 2025 00:08:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44q89ywjq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 00:08:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRdpGa779mXuOvZ+4QGSyKk1H+C3J5a7koRY5q543716kycydDNSU22Vc+KI5toP3cimOWnzfGmS2jgPixv8rJBF4Yt2obb3GXhEePReW7jy/MJO5of5pi/gKpF8YIIGIIFiWT01TzAlj63B3eEEpRXCD+hR+PAIUmtBf8RYt2nUVVMNRZlT7c6VtUaEebHDVNGQEn9Mf9xFhIP+6ff26oKRJg1k7PMWbR7j4u1bF04RVCPptJu+uAZcaKLi4/COrL0yzb3AqMGRoIc3QJl1kZPQEhzHkVoo6eswXE9lIQRvBVGy5Z55d2Wx2RWrMS+7cm4ZLc0Al8JBZFnlgH3DJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8CAhe7s5/Iiu22q/53nctagny1SweyXorMGgLtXaPw=;
 b=yxYFKW7lRUcX+dagBkmDQyCuln0hxse1KP7y8X4nnj3BRzKgc70Wb/q2ROoeNThxCFwy78GQLM+gDN8KR+uKYMJ7jqtBGj6b9LAClK1Bhd9NG4pw9kwBZMCYNuJy9VllL26vm2Zzru5JyivAwlOEPMHRRs95j8BvcVNB45Img/xHwla0Ljt2n0VrPyBrfv4VJP7hQkGUMtyXMNxeDcKoOAOhMWz1urNAt7TTWRiUxN+fyftt4MQ+Mgrj8hQ0xJG92oSf/c2kFwtzq3h26/QCugOLdw/Gy3c6lEtaX4Zqa1+M5Z3R+FkWDttbgofDTClFxrLln93QeWkSKyYbsziU2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB4724.namprd15.prod.outlook.com (2603:10b6:806:19f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 00:08:22 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%4]) with mapi id 15.20.8398.021; Tue, 11 Feb 2025
 00:08:21 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC: "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        Patrick Donnelly
	<pdonnell@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] ceph: is_root_ceph_dentry() cleanup
Thread-Index: AQHbcTHI6MoXeV145U6GsShlXuSWerMs1eMAgAAdZwCAFFxvAA==
Date: Tue, 11 Feb 2025 00:08:21 +0000
Message-ID: <37677603fd082e3435a1fa76224c09ab6141dc22.camel@ibm.com>
References: <20250128011023.55012-1-slava@dubeyko.com>
	 <20250128030728.GN1977892@ZenIV>
	 <dfafe82535b7931e99790a956d5009a960dc9e0d.camel@ibm.com>
	 <20250129011218.GP1977892@ZenIV>
In-Reply-To: <20250129011218.GP1977892@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB4724:EE_
x-ms-office365-filtering-correlation-id: a5095db6-9b5e-4ebe-68a9-08dd4a30323a
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cFo3YjMvcEQ5b2g3bHh1Y2JDTHUzN3pYdU5VT04xRUJBdlMyc1RCZHplWVd0?=
 =?utf-8?B?ckM0eGZaWEMzL1p2MkVhNUlSdm1BQzBiaEJpVE9VSTk3cStUeHJtYk5lL0xw?=
 =?utf-8?B?djNwK3d2Z0g3MGpRNTFpMVRkeWJOc1VYQzNzR01qak1mSURnQmRTQkdQQlBR?=
 =?utf-8?B?aUdLMzBZb1c4UGFXMVZDMGxQS2ZRbWdVcHRyaFNrZHlnSk9jNXEyc20yQWxF?=
 =?utf-8?B?SFFoTkd6U0xBbnB5dlpYSEVWZ3ExRnB4R043TXpZWENyMVJONHFXbVlZUXF6?=
 =?utf-8?B?UE9sdjJEaGlMWjF4TnFPa29PNEpESjB2MGpER05sdldPYkg0U0JMRE1NRjF1?=
 =?utf-8?B?OHN6ODZySld5dHN4Mmw3TmcwUGpHWEVJemQyN0RwTnNzOGtnV2ZmbFl3dFFH?=
 =?utf-8?B?RnVGN29ldkVDYmtqcE9NNUkxV29BMmRIN1lVTWM2VUFNQjdXNWtQYytDRVMr?=
 =?utf-8?B?MFdwZ2wzeU0yZWZmemZJekN3bHNNcmRVb3ovd3JVOG5OYjZhNWlhUVB2cmtL?=
 =?utf-8?B?Z2c2RGRlMW1BVm5ZTldXaFhmNVZZOFdreEorUnFqRWZUcmJVWldXdDROQ1Q5?=
 =?utf-8?B?VERHb0NpS2xiaFVrOXRkRDVLM3diTllHclNWRERlTURLWGxNQUNuMzdsby9I?=
 =?utf-8?B?azlUQmpKbDI2V3VjS215ckFwT3pTaWV4WFNVL2pIVXNJSldmZjQ4MEcrNVh0?=
 =?utf-8?B?enc5NzFwM3o3NzF5V3FKMEJJV2RaOGFUNnM0bXhNOWg0OS9iUEtYZXJZTlJB?=
 =?utf-8?B?VmE4RnBVNDJNZVNGZGVKQWNBS21QeWJ5TC9KWUdWYzM2UnVhSlNMcGhobWRI?=
 =?utf-8?B?cDk1eTd1c0h1THB1TEtEb0VxR0JhN2tnMkxrbVp3alQxekxsUDRvRlRuR0Uv?=
 =?utf-8?B?d3lDMTJQUzNseFN1ZlBFMGJSQ21ZbCszczlYSG1uVHUrcVp4WWF1anl4QTl1?=
 =?utf-8?B?ZkhPdEo1RHh1ckRKcklGanJobTdQbDFRaEVWL25wMitZbVIxR1g3djBMbXBC?=
 =?utf-8?B?SzFpc0JKOTR5Ky9ob3Fxc3hJZUZYeFBQSk5XeWZJcEJGbWtIcy8yR2pVTEI3?=
 =?utf-8?B?QTMwVS9YL20yT2JSclJ0aExEejNFT0pGSHFjZmttNTZJa29MTFNZSHRCWW82?=
 =?utf-8?B?eVhqSlVLaVBhUE10cmI4S2JMUEU3Z1Y0S0xuWmU3dU40dUFuQUQ2bm1wbVpN?=
 =?utf-8?B?SWZNSThzRjlhcGNCYTEzbkVablE0ODJKSWEwbS9DcGhyREk4dzMzQ3NmbTBK?=
 =?utf-8?B?cnRTeitkZ1pLZUhTd1ZhUEFPYTNCQWtaYm1mYzZESDh3SWhRVlUvdG5VRTcz?=
 =?utf-8?B?Y0dYazZSYXh3aFZMUzdUZiszaGM0cDRqRUtOTjhjMWZIU1hDR2VSbjBXNlhZ?=
 =?utf-8?B?OXdyRWYyRlNzUjlmL20wUWw0WTB4Y2diU3lGWVBzVDdQUktramNWVlVQMEZv?=
 =?utf-8?B?T1ZVbmgwOFROOHR0SDdveTMrNm1MaDlqcGRvOGMyWDdwUGVRZ1N4Zi9BY25m?=
 =?utf-8?B?Yk9kVXEvTDhFMFJJUWYwN1JmcVorWVN5K0l4Q2xMQnk5TGZjYzRzL3M4d3Ir?=
 =?utf-8?B?SExQSUhxWHlRM1p2Qm5TMCtjaEpZa295ek9MTm5jMklqS2ZVMG5neHN6QVdy?=
 =?utf-8?B?c25YeGQyOWxwUngzcVo0T0VtZDNPYTFEMXRXVDhFNHVpMW96ZWRZbXhaSzI4?=
 =?utf-8?B?TkovZFFPQ3hrdUJ4ZFZtK3BtUWZ5VmFHRmErbFdHS1Z3d0ZQcVdkTDRxelRl?=
 =?utf-8?B?S2VHVGh3MVdXWnpKYWhOdUNyeHkrYWs5c1NmN01icW82TVBoeGFCUTNzWE02?=
 =?utf-8?B?em9tdTdCalFKamdNMWxXbUFnbTdadkxRSUZXcENaZk4waDdWaHdLdDlIRHJ4?=
 =?utf-8?B?cDlFSmFBU1R2OGZXRkxwUEFWSkpNcjdCRWlGZEp1Uy9sZ092Rm1MNG9sWWdq?=
 =?utf-8?Q?kumYb8iBV39J8mqxwnmOnUzrowrByOO9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZHl5UWRkK2ZrZEh0ZUgveDJrSG4rRWZWdXdkQUt3RHZ6NkN6R0dPWW12MlhT?=
 =?utf-8?B?Z2ovcHVKam9DWkc3T0lZd2RxeWJwcWZsYTZPbTVuUDF5bHNWR2t5MDFvc056?=
 =?utf-8?B?RU5QNEFzd3VhNXA1UEgvb09KUis5UndTOGVXKzJYbmRGN01wTUVEV0srbTlI?=
 =?utf-8?B?d3VQWFVyV1NYNm1GRmlWVGhTcjlyYzVhRUdLc0V5QVYwYVA3cGpzVGNYR2Ju?=
 =?utf-8?B?MFd2Sjl4NW5OZEhjUU1jajJHNHcrb2hjbFE1VkwzZURlQUlQZ3BlMnpkbC8y?=
 =?utf-8?B?REN0MVBqN3NkaE5pZlBuQmxRYnQ4MldKSDJ4elFBSFFqUlZMVG5yUGZRWG1L?=
 =?utf-8?B?eHp5QnZ3aWZZSS9NeldkSGs2WC9NQlBpTzh2WVZNWGhkd0s3V1JsUi9KUUhB?=
 =?utf-8?B?eVJrVUJYRmFFYUNvTUFZeVV3VFBZQS9JcnNMcE13cDBXQ0NQYlJtNCszZm5a?=
 =?utf-8?B?ODNaK25ZRTNaUHdrWStRTmFOMHJjcUpiRjNJeDdxd1p5eTFSRFo3OU51UDYy?=
 =?utf-8?B?U2dUeGF2bE9uZk10R3hUL2cxNDJlSGp5MFZHZmxORWl6M2hiVWJSek9zRWpv?=
 =?utf-8?B?b0p5TjI3dWNBQjlKU2xGWWpVc0dWbkFETHltVGxBczFCenpGc1puK1p4T2lH?=
 =?utf-8?B?ays1VlJuRloyV01vVFdkZU9wUXV5MmU5cXlic3ZMZUpGd3ZYQWMxZStXalNw?=
 =?utf-8?B?QVpvSDVOK3VPdTN6YmE0K0tIbXFmN2daRlFLeHh4R3FTdzhmTmYyS1hEMVE0?=
 =?utf-8?B?cjE2amc1QTlYaTZUOEVHUmY0Z2I1cFpTUEVuQTNJWm1JMmhmTGVOeGlDRnJI?=
 =?utf-8?B?MS9HWEpJbE4xdm96RDFyVUZ1UUN5UjZKWDgvV3ZOOHVpL2o0dzQ2ejhuR2x2?=
 =?utf-8?B?eDA4enZLUFN3R0ZzOEFlVE9ZVXA3cldZRWZCR3NmVFFhaFhjRVFBK3FHT1U5?=
 =?utf-8?B?TGkvSURTYVBkNzV3YlRNMWgzZFRrZDA1ZUZKTndvS0VjVzRFYUluVW1naFJn?=
 =?utf-8?B?M1Mrc2N3aVhPZng1b2RZY3drK2tScHpyd1B6QUM5SUt3V2NMT3NnVEhxYmRh?=
 =?utf-8?B?cWZNVkNPS0VGbkJ2R1hvZkJDY0p5UTRtY0VpZnBWY1FkY1Q2ZFZBbnBYMXA5?=
 =?utf-8?B?dEZCcnFJM3QxQjRwUHZtV2ZYY2lBa1pEQmYwRVBEaU04V01TcDYrUUtySnli?=
 =?utf-8?B?Y1RZa3k2SHg0bi9ySzc3WXF1VWErV2hudStFYndEd0tkQW4vaDZNZnJvRU51?=
 =?utf-8?B?bUQvRVFxNmVYUVNEVTMxLzBIell2d1lIOXYxdXQzTmpZMjZxTWpITnhxUzBH?=
 =?utf-8?B?cTBGZWgyL292YyszdFkzKzdsUHhzN21KMEtMZzhQeUZlelpQWHRnOW9TcWxx?=
 =?utf-8?B?OEs1cGxYSUgzdzhUTGxxMjBBc1ZHdzlGRVFDbVJINVphVklscmtkSWo4alJs?=
 =?utf-8?B?QWNrVGxzYVRYVVZMOXJIVVdtNlpqWDZKVXI3dkJSNUk4RzRBbjFxZ2FEUTRa?=
 =?utf-8?B?aE13a1o3akE1MFZycEpaeEF5R3VMUlhLajRtZ0E3d2xvU1lpbjRneGo3NUs1?=
 =?utf-8?B?ZGNCSm1kckhKaXByN2R2WUFGcU00UytDamt3TWV2V2FKMEI3NDdvaVlLUE1Y?=
 =?utf-8?B?dFpiZnFXdGdtRm5WZ2JNWmY0dTFuazZhRDFaWWpRS2xPRW9RaGFwMW5XSlQr?=
 =?utf-8?B?V0dreTFwV1JNb2JOTkc4TndPaGlOUjF2UFRMakg5SUowbkZzbktjbUp2c0ln?=
 =?utf-8?B?REUyVy93SE90dC9uWWR0b3RjcjVvK1FERkltUmFZK3BGSzNLRHVzVFNKZW5t?=
 =?utf-8?B?Q3hrTzBmRVBLNkVkYTE5NXF5NUdFYmxqOFhhR0x3a3hrUFlCOHpSeCtHZVlZ?=
 =?utf-8?B?TE5BMU9EWnBlc3F1VWtYdkdvOHVveHpBVWRRSnl5L1l2Wm5aREtwSDZKbnFp?=
 =?utf-8?B?WGlZaFJ1dWFtZHpjZStHV1lsTnJLQmdoYzJGZFlHZ1RvQmZ3M284cU9oMkVu?=
 =?utf-8?B?NzVWZitPdENrVk9JZW1nc3NUc2Q3VEdMdUFndWNPVVdiendiek95K29sT0pt?=
 =?utf-8?B?cmRyVXIyZ2dqTndCdjNrcUFndURLa1dDM1NOR2ltUmdBM1pOS1ZUWGRwQ1F6?=
 =?utf-8?B?MERMQjBRVkl1eXhmOFlxVmlqRHZmK2dSdlNwaDVNUHRNMTRzbVlTRkdoamFM?=
 =?utf-8?Q?yjoTqjRZgAr7x1JPrlPIl5w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6347D850FF544545A567082EC96C0EE9@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a5095db6-9b5e-4ebe-68a9-08dd4a30323a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 00:08:21.7732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TSVI1N4G4U4TekmBY7EYGalcftMbxX6GtQiqoiYcNokGQDMFBw2NOG05DfbgQ4ntkVC6X9VL/8WZdgJp3GTOxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4724
X-Proofpoint-GUID: 5BDqhOFAApNnzxTNkWcgFfLmEoqEIr8x
X-Proofpoint-ORIG-GUID: DUBGoUJZUeEOKqdTcr2NNBlQ0Q1v8n97
Subject: RE: [PATCH] ceph: is_root_ceph_dentry() cleanup
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_12,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502100180

T24gV2VkLCAyMDI1LTAxLTI5IGF0IDAxOjEyICswMDAwLCBBbCBWaXJvIHdyb3RlOg0KPiBPbiBU
dWUsIEphbiAyOCwgMjAyNSBhdCAxMToyNzowNVBNICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28g
d3JvdGU6DQo+IA0KPiA+IEkgYXNzdW1lIHRoYXQgeW91IGltcGx5IHRoaXMgY29kZToNCj4gPiAN
Cj4gPiAJLyogY2FuIHdlIGNvbmNsdWRlIEVOT0VOVCBsb2NhbGx5PyAqLw0KPiA+IAlpZiAoZF9y
ZWFsbHlfaXNfbmVnYXRpdmUoZGVudHJ5KSkgew0KPiA+IAkJc3RydWN0IGNlcGhfaW5vZGVfaW5m
byAqY2kgPSBjZXBoX2lub2RlKGRpcik7DQo+ID4gCQlzdHJ1Y3QgY2VwaF9kZW50cnlfaW5mbyAq
ZGkgPSBjZXBoX2RlbnRyeShkZW50cnkpOw0KPiA+IA0KPiA+IAkJc3Bpbl9sb2NrKCZjaS0+aV9j
ZXBoX2xvY2spOw0KPiA+IAkJZG91dGMoY2wsICIgZGlyICVsbHguJWxseCBmbGFncyBhcmUgMHgl
bHhcbiIsDQo+ID4gCQkgICAgICBjZXBoX3Zpbm9wKGRpciksIGNpLT5pX2NlcGhfZmxhZ3MpOw0K
PiA+IAkJaWYgKHN0cm5jbXAoZGVudHJ5LT5kX25hbWUubmFtZSwNCj4gPiAJCQkgICAgZnNjLT5t
b3VudF9vcHRpb25zLT5zbmFwZGlyX25hbWUsDQo+ID4gCQkJICAgIGRlbnRyeS0+ZF9uYW1lLmxl
bikgJiYNCj4gPiAJCSAgICAhaXNfcm9vdF9jZXBoX2RlbnRyeShkaXIsIGRlbnRyeSkgJiYNCj4g
PiAJCSAgICBjZXBoX3Rlc3RfbW91bnRfb3B0KGZzYywgRENBQ0hFKSAmJg0KPiA+IAkJICAgIF9f
Y2VwaF9kaXJfaXNfY29tcGxldGUoY2kpICYmDQo+ID4gCQkgICAgX19jZXBoX2NhcHNfaXNzdWVk
X21hc2tfbWV0cmljKGNpLCBDRVBIX0NBUF9GSUxFX1NIQVJFRCwNCj4gPiAxKSkgew0KPiA+IAkJ
CV9fY2VwaF90b3VjaF9mbW9kZShjaSwgbWRzYywgQ0VQSF9GSUxFX01PREVfUkQpOw0KPiA+IAkJ
CXNwaW5fdW5sb2NrKCZjaS0+aV9jZXBoX2xvY2spOw0KPiA+IAkJCWRvdXRjKGNsLCAiIGRpciAl
bGx4LiVsbHggY29tcGxldGUsIC1FTk9FTlRcbiIsDQo+ID4gCQkJICAgICAgY2VwaF92aW5vcChk
aXIpKTsNCj4gPiAJCQlkX2FkZChkZW50cnksIE5VTEwpOw0KPiA+IAkJCWRpLT5sZWFzZV9zaGFy
ZWRfZ2VuID0gYXRvbWljX3JlYWQoJmNpLT5pX3NoYXJlZF9nZW4pOw0KPiA+IAkJCXJldHVybiBO
VUxMOw0KPiA+IAkJfQ0KPiA+IAkJc3Bpbl91bmxvY2soJmNpLT5pX2NlcGhfbG9jayk7DQo+ID4g
CX0NCj4gPiANCj4gPiBBbSBJIGNvcnJlY3Q/IFNvLCBob3cgY2FuIHdlIHJld29yayB0aGlzIGNv
ZGUgaWYgaXQncyB3cm9uZz8gV2hhdCBpcyB5b3VyDQo+ID4gdmlzaW9uPyBEbyB5b3UgbWVhbiB0
aGF0IGl0J3MgZGVhZCBjb2RlPyBIb3cgY2FuIHdlIGNoZWNrIGl0Pw0KPiANCj4gSSBtZWFuIHRo
YXQgLT5sb29rdXAoKSBpcyBjYWxsZWQgKk9OTFkqIGZvciBhIG5lZ2F0aXZlIHVuaGFzaGVkIGRl
bnRyaWVzLg0KPiBJbiBvdGhlciB3b3Jkcywgb24gYSBjYWxsIGZyb20gVkZTIHRoYXQgY29uZGl0
aW9uIHdpbGwgYWx3YXlzIGJlIHRydWUuDQo+IFRoYXQgcGFydCBpcyBlYXNpbHkgcHJvdmFibGU7
IHdoYXQgaXMgaGFyZGVyIHRvIHJlYXNvbiBhYm91dCBpcyB0aGUNCj4gZGlyZWN0IGNhbGwgb2Yg
Y2VwaF9sb29rdXAoKSBmcm9tIGNlcGhfaGFuZGxlX25vdHJhY2VfY3JlYXRlKCkuDQo+IA0KPiBU
aGUgY2FsbGVycyBvZiB0aGF0IHRoaW5nIChjZXBoX21rbm9kKCksIGNlcGhfc3ltbGluaygpIGFu
ZCBjZXBoX21rZGlyKCkpDQo+IGFyZSBhbGwgZ3VhcmFudGVlZCB0aGF0IGRlbnRyeSB3aWxsIGJl
IG5lZ2F0aXZlIHdoZW4gdGhleSBhcmUgY2FsbGVkLg0KPiBUaGUgaGFyZC10by1yZWFzb24tYWJv
dXQgcGFydCBpcyB0aGUgY2FsbCBvZiBjZXBoX21kc2NfZG9fcmVxdWVzdCgpDQo+IGRpcmVjdGx5
IHByZWNlZGluZyB0aGUgY2FsbHMgb2YgY2VwaF9oYW5kbGVfbm90cmFjZV9jcmVhdGUoKS4NCj4g
DQo+IENhbiBjZXBoX21kc2NfZG9fcmVxdWVzdCgpIHJldHVybiAwLCB3aXRoIHJlcS0+cl9yZXBs
eV9pbmZvLmhlYWQtPmlzX2RlbnRyeQ0KPiBiZWluZyBmYWxzZSAqQU5EKiBhIGNhbGwgb2Ygc3Bs
aWNlX2RlbnRyeSgpIG1hZGUgYnkgY2VwaF9maWxsX3RyYWNlKCkgY2FsbGVkDQo+IGJ5IGNlcGhf
bWRzY19kb19yZXF1ZXN0KCk/DQo+IA0KPiBBRkFJQ1MsIHRoZXJlIGFyZSAzIGNhbGxzIG9mIHNw
bGljZV9kZW50cnkoKTsgdHdvIG9mIHRoZW0gaGFwcGVuIHVuZGVyDQo+IGV4cGxpY2l0IGNoZWNr
IGZvciAtPmlzX2RlbnRyeSBhbmQgdGh1cyBhcmUgbm90IGludGVyZXN0aW5nIGZvciBvdXINCj4g
cHVycG9zZXMuICBUaGUgdGhpcmQgb25lLCB0aG91Z2gsIGNvdWxkIGJlIGhpdCB3aXRoIC0+aXNf
ZGVudHJ5IGJlaW5nDQo+IGZhbHNlIGFuZCAtPnJfb3AgYmVpbmcgQ0VQSF9NRFNfT1BfTUtTTkFQ
LiAgVGhhdCBpcyBub3QgaW1wb3NzaWJsZQ0KPiBmcm9tIGNlcGhfbWtkaXIoKSwgYXMgZmFyIGFz
IEkgY2FuIHRlbGwsIGFuZCBJIGRvbid0IHVuZGVyc3RhbmQgdGhlDQo+IGRldGFpbHMgd2VsbCBl
bm91Z2ggdG8gdGVsbCB3aGV0aGVyIGl0IGNhbiBhY3R1YWxseSBoYXBwZW4uDQo+IA0KPiBJcyBp
dCBhY3R1YWxseSBwb3NzaWJsZSB0byBoaXQgY2VwaF9oYW5kbGVfbm90cmFjZV9jcmVhdGUoKSB3
aXRoDQo+IGEgcG9zaXRpdmUgZGVudHJ5Pw0KDQpTb3JyeSBmb3IgZGVsYXksIEkgd2FzIGJ1c3kg
d2l0aCBvdGhlciBpc3N1ZXMuDQoNCkkgZGlkIHJ1biB0aGUgeGZzdGVzdHMgYW5kLCBhcyBmYXIg
YXMgSSBjYW4gc2VlLCBJIGhhZCBvbmx5IG5lZ2F0aXZlIGRlbnRyaWVzIGFzDQphbiBpbnB1dCBv
ZiBjZXBoX2xvb2t1cCgpLiBIb3dldmVyLCBJIGRpZCB0ZXN0aW5nIHdpdGggcHJlc2VuY2Ugb2Yg
b25seSBvbmUNCkNlcGhGUyBrZXJuZWwgY2xpZW50IGFuZCBJIGRpZG4ndCB1c2Ugc25hcHNob3Rz
LiBJIGd1ZXNzLCBwb3RlbnRpYWxseSwgaWYgd2UNCmhhdmUgc2V2ZXJhbCBDZXBoRlMga2VybmVs
IGNsaWVudHMsIGZvciBleGFtcGxlLCBvbiBkaWZmZXJlbnQgbm9kZXMgd29ya2luZyB3aXRoDQp0
aGUgc2FtZSBmb2xkZXIsIHRoZW4sIG1heWJlLCBNRFMgd2lsbCBiZWhhdmUgaW4gc2xpZ2h0bHkg
ZGlmZmVyZW50IHdheS4gQnV0DQppdCdzIHRoZW9yeSB0aGF0IEkgbmVlZCB0byBjaGVjay4NCg0K
SW4gZ2VuZXJhbCwgdGhlIE1EUyBjYW4gaXNzdWUgTlVMTCBkZW50cmllcyB0byBjbGllbnRzIHNv
IHRoYXQgIHRoZXkgImtub3ciIHRoZQ0KZGlyZW50cnkgZG9lcyBub3QgZXhpc3Qgd2l0aG91dCBo
YXZpbmcgc29tZSBjYXBhYmlsaXR5IChvciBsZWFzZSkgYXNzb2NpYXRlZA0Kd2l0aCBpdC4gQXMg
ZmFyIGFzIEkgY2FuIHNlZSwgaWYgYXBwbGljYXRpb24gcmVwZWF0ZWRseSBkb2VzIHN0YXQgb2Yg
ZmlsZSwgdGhlbg0KdGhlIGtlcm5lbCBkcml2ZXIgaXNuJ3QgcmVwZWF0ZWRseSBnb2luZyBvdXQg
dG8gdGhlIE1EUyB0byBsb29rdXAgdGhhdCBmaWxlLiBTbywNCkkgYXNzdW1lIHRoYXQgdGhpcyBp
cyB0aGUgZ29hbCBvZiB0aGlzIGNoZWNrIGFuZCBsb2dpYy4NCg0KQnV0LCBmcmFua2x5IHNwZWFr
aW5nLCBJIGFtIG5vdCBjb21wbGV0ZWx5IGRpZ2VzdGVkIHRoaXMgcGllY2Ugb2YgY29kZSBhbmQg
YWxsDQpwb3NzaWJsZSB1c2UtY2FzZXMgeWV0LiA6KQ0KDQpUaGFua3MsDQpTbGF2YS4NCg0K

