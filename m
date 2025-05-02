Return-Path: <linux-fsdevel+bounces-47946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD49AA7A37
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 21:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03DA79810FB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 19:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2823C1F1538;
	Fri,  2 May 2025 19:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NMcnfy1i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECA81E9B1D
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 May 2025 19:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746214128; cv=fail; b=YL0gScLfqaEIoyBbyVeCLDE7ewUsCysOVcvSOFHF2OCpFsBhX/j61OZFGt25Fk8O2r9FDOT0RuHIXSjckusqnrQxgYDlWzA9XA6n5TfoSAJ/UCvjzxDlPW/aP+CYZ+bBSHbRne9wAQKDU26JESE6Ze94CAWXQf2xJ0Z2SRDCx9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746214128; c=relaxed/simple;
	bh=wl5jGDcmaU1UAlc/QZmTSaxpJu0HTRXvhQSfCsGECIo=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=a9On4238cALdsP3nmBpdzqmD3aJ9dHehKxu5r0nKNlXxgNYxRIz3NTXXnsvhU9BYvLDEeYbYUe7PZsyJYmWpBuSAwf7ZNCjsU259O/eIW5lKkLbed1xTd4gHlyvC2/bJxrOUAvI59KJX4xeoBYzcFC5LR6BiWiHMX6KHYSQlN1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NMcnfy1i; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 542A1Ast029120
	for <linux-fsdevel@vger.kernel.org>; Fri, 2 May 2025 19:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=wl5jGDcmaU1UAlc/QZmTSaxpJu0HTRXvhQSfCsGECIo=; b=NMcnfy1i
	9Y7OStonnCwFxLYEfPmD5QI7BvAALd5gCxjiUP0F/Ft+MAn/OYwzTrBFE6gaIzgf
	uK+I7Lm6DKTsRwCr/d7Heg/E7Y32SdeaE+gZMhwnf6X3/ImCBaztzFIVWnBjbi4b
	XRvJ7TJFHuhgGecNfAaESeq3LCua3MzpSkst8mJjhjTVJo0iiBLCJIMM/7h6NvIi
	rsUTcBWrEHQ1eFLaWSL0cQy4PtVEvE/P4ktQZTTNi9n7EnnxXnNZDoLYWik9XN8f
	aPSmp4cPDnLKkyCEQekUtwX7VZ9+kC7Nl3PHmgoFIRf08s4SQl0jQVJsITktPUiE
	nrCJERdneqcwQg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46cjx0cc2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 02 May 2025 19:28:45 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 542JPtcX007312
	for <linux-fsdevel@vger.kernel.org>; Fri, 2 May 2025 19:28:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46cjx0cc2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 19:28:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsFy8W0QR0UJu5jmIoj/OpU7ldfzijwoe7XcxW3kTzaYJkX3JEw20PW7zoTnXUSxu4NlDGt9wF+hsJamyjvGrrk03yzoVFjaywZ+tHCW1FDuPDSgm0n6gy+YFg6I1x1oLbwMOWUyfU8b7Gdh3XclZ1cKBs5Anb1NXcSfGGibImisyhzkyHwCSb2QLEX9Sa96edQgYgNVihSIswc96jSt9Pbjw+I7ypQsnfwCd0bCBHNNyHt2ILfsKw+GzPQ4TL/VEK9lHfApycOhSAHoQsjkPZirTRhf/Edpm/XkgvLbyqwQcS2C5veqIbglpChoarXv3AP9fy8vDWxmk3+COrLUtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPas0RZhxlRnioYXbfd1dvO26uO+sd09VQWVBqhMhQg=;
 b=nmN/lRPsBTtyhrr+hzwElH6FCsUb7Dq84hIwbgS1gLCJuWh6HE1gY9BF7O/2SDaJXPSa0PCfW58PyolQw0yoG3ewYi/FqCyjeeV+cgFQyilJd00roR+ngYpJ3444BHbYdCd1Anm2EednOlZxwUP/Ba/P/TuRMpjQrNPFNouz9C5OYF2aNT9gtWd9PNl1rY5ktVeHEF/uevcFbMg89CazR6gocCATdoTsYIrqT8YsCZI/ORkhsSk3TUmPwjBmobzTvOIXwqmVZzN9WYxwHIwUZ8ENgNBxuF6GyEU9ld437nx4C69m/QWO2Y5/LFqcZSMJTCW8tUIzrA10fX2zwRz3/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH7PR15MB6179.namprd15.prod.outlook.com (2603:10b6:510:24a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 2 May
 2025 19:28:42 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%3]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 19:28:42 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "huk23@m.fudan.edu.cn" <huk23@m.fudan.edu.cn>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "baishuoran@hrbeu.edu.cn"
	<baishuoran@hrbeu.edu.cn>,
        "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>
Thread-Topic: [EXTERNAL] KASAN: slab-out-of-bounds in
 hfsplus_bnode_read+0x268/0x290
Thread-Index: AQHbuxRcN18KNgdfnE2P3W9v7C5IZLO/uqmA
Date: Fri, 2 May 2025 19:28:42 +0000
Message-ID: <1058be22b49415c3065ced5242988ff81e2e9218.camel@ibm.com>
References:
 <TYSPR06MB71580B4132B73E43C0D86517F68D2@TYSPR06MB7158.apcprd06.prod.outlook.com>
In-Reply-To:
 <TYSPR06MB71580B4132B73E43C0D86517F68D2@TYSPR06MB7158.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH7PR15MB6179:EE_
x-ms-office365-filtering-correlation-id: 3ce2845e-9248-4a7c-db3b-08dd89af8c42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TFdDZzBmekdLalpsQTlsMWtVb2hsdm9uenlSODc4djJtNUlqcDFZRTZvVitY?=
 =?utf-8?B?OXlvT1Rhbkx3eUNqTm1GR2dlb1dMTU9rbDFlcE1UM000a1FsdlhGZloxSnFH?=
 =?utf-8?B?cTBQTEZnTXJkR3dSa0RwckVURmdVaDJtZWFUT3RSaENhaDJjcXlQUkh1aVdo?=
 =?utf-8?B?UDQvWTNEWU16Q3FRbUw0RW1QQlloSWl5M2xwZW80THVjbHBzYlBZL1hFZVBO?=
 =?utf-8?B?aFdjZlFYaURHZDhhNHZ6YTFzNlh5S2dRWG1uRE4xZzUya0c5R1FvU2ZiVnBR?=
 =?utf-8?B?NHJOM0x6ZmJGTnYvOVNhd3Z6NWJlam0ydDMzbmg3Z3Q0MWFBMW9pVHdzc0hv?=
 =?utf-8?B?bWhoYzhJd0loekNYV28wTGNsQzNGVXBVeGRUQUZveWw1bmVwZS8ycEZrUHRw?=
 =?utf-8?B?SlZ4eTB3QmJXYXFkdHNRRkpXZ1RRck5DWEJTMXdrVGI4TWY0d0E2cmpQaGdR?=
 =?utf-8?B?WnRCSHluWC8ya0VGQzg4bDBLd080K0tsOFFzelEvK1IrRFowVmNMMFQ4aGhj?=
 =?utf-8?B?RUc2THo4NW01VEwrSTBva2c2Nks3VEZYVk5VYW9EZVlhdFhMNnFlWWttOHB2?=
 =?utf-8?B?VFlhREZxTWdpcDNsUWZVUDN2dGVQblowcTFmS3k5NitJUm9BSU9pcU1mcFRH?=
 =?utf-8?B?NnhmS25UWlFQZHo4L1hkWUN1SlpkY3I3U0hnYmM4UXpPb3VnT0JMdUppYnJT?=
 =?utf-8?B?MCs0TnNDSm9IUGtpTzBPSlp0R0xIVnQzTEJ3Z0xodXZWRHI2anVGMnllZ0l3?=
 =?utf-8?B?ZXZtWiszQmo2NG9PSmNzQVJGWUh0N0VOZjY1VFVqZDVWcjBTUjJNTDYydHJM?=
 =?utf-8?B?VWNYSS85Rm1SVmJKWmZWN2hwL3pXL0NQYUNkT0RiTEhBeC8wQVNidmhuVU5H?=
 =?utf-8?B?UUhpTm9KMEFWT0xoVDJDK3YvMGhFd205bzdPNHZUM1E2QVFiN0pFbUE0N1VU?=
 =?utf-8?B?NUcrR3daTFV1TlU0TkR0M1JiUGpDcExJZ054cmFHc3hTcjYwZnh0NXBhYWd1?=
 =?utf-8?B?V3Bxb3dCZkVIRUZnYzN1cDVXK1dsQXF1SjVVWjZGSWhQMG9QTUIveDVhQ0NW?=
 =?utf-8?B?V2QzR2RQTm9JUWVYaEhyRWo2U0lqcVlzVGNZM29QMlhZOXYxdHJ5bHlmRCtl?=
 =?utf-8?B?d09Lcm9QSHY1S0UyZDFQQ2ZqL3NGYUtQMzNDaUJFSmxhTjQ5MnlDV3ZIRWZa?=
 =?utf-8?B?bFBjT0NjZlc1STZxWmRIcFhwYVZ6clhyTkQ4S3dSZjQwbCtTQjFJM0JPZ2c2?=
 =?utf-8?B?QnV4ayttVmd3dXkrNmJsa0U4ZHpOajZoNWJyLzBWWW8vQWJVUENsd01NM1pQ?=
 =?utf-8?B?WjVSSXkzRC9EanBWRmI5QnpFUEN6dlNzSm51QytKa0ZpTlVXZHpPdlVQVEox?=
 =?utf-8?B?S0xBVEFLWjVmbm84TDgrMm4xd2g3VEdXL24wVGozY0EwVGh6b09wK1FXMEtn?=
 =?utf-8?B?cVlrZjB3dkR2YmoxQm9oQW5SU2lzeS9GYXphZ28rMlhHY2taSDFnTWUyaEZU?=
 =?utf-8?B?UE05elZyK3lLbTRWWnVzdmZnUE13cHBSMFN0Tm5QVUdaN1NPM29ueWFEMjVK?=
 =?utf-8?B?aGxXNVNRQzhpeExsTWJDRlBJQXBaZThobGJwbmw4YWZiZDREV3JZNzBzeTcy?=
 =?utf-8?B?VENPYUs0Y2dIS3pJbk5JYXpCaTBFTU1tbW1YUCtUSWdGTFBtMkp6ZFFLWHNy?=
 =?utf-8?B?K1RRU3FGU0dqN1l1UTNOelVVczBhUEx6MTgwejZLQW05aWk4bStqWTB6c3NO?=
 =?utf-8?B?YzdZT0dFcHh0bzU0RzNjeXlCOXhya0lTUlg0SkUrWlpaY1dWYm5BOW1oYi80?=
 =?utf-8?B?d2lOaFhkN0VWeEZPWld3UXVHeFYxcmJ4VmdNTm9BN1lQWXIrZHJlVnoydTcy?=
 =?utf-8?B?WFU3elJZZ24xUjJlb1dDNFhCMnRDN1FvT1VJVG9TMnJ0czRVcmcydFRXZFVJ?=
 =?utf-8?Q?xAENxxbKgGjaAAHgtUZUK8iChTBmlpIL?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V3N1aVF4NmtlcDhIRVJtTTVkWWxja0dVRks2MGNyQjIwRktZNXltODJPNWM3?=
 =?utf-8?B?Zmk0TnkwdUl0aWdNM2prVWo1NXhLUXlua01IRUhSQ2xuTmFCTlJKQ3RoRkxt?=
 =?utf-8?B?WVRCdVhrOGZrZkpvc2pSOTFvdjBEaDdNeDRXMXcwOHROcWpnRG54YXZqY2o5?=
 =?utf-8?B?eTJnaWFMbHpVbng3d0xzK1lnMDhHYURHK0gxRmVFNEFra1Z5bGN3dDd5WHo4?=
 =?utf-8?B?NTlyZjFJSE9EZGVwZ01mZ2V0VmI0eEV4RGFrUm1ld1hrN0Y0MHp0WGVNYWc3?=
 =?utf-8?B?eFJ0dHRzNGJ5SWs3Q0xneDhqaDJHQWlBeURGNk8vVlRFdm13dDVVYVFNU2Vq?=
 =?utf-8?B?Nk5vRFNnQUpRMkM1Q2NuZnNBc1FOVkVRREtQU3pDamJoaVN2dXZVNjJ2Q1lH?=
 =?utf-8?B?TjAwWStmdkEzL2twYkNNeFFGR0VvRUIzb2kxY2c2dmtPb25ybmEzZ1g0aFd5?=
 =?utf-8?B?VWxlRXpXY08yMHNkSWlheVZ4TlNVdklRcXpKK0kwdlRiUWplOTJPdlE1MVJt?=
 =?utf-8?B?dTlrdXdydnJNWi9pby9WdWdCdUVZWFdaOS9IcHNvM3VNOU84c1lLeUUvWWpa?=
 =?utf-8?B?dmtSL04rTWJQRk8ydkwwWWlQckFkWUp4SkRDNlJMVmExMXRTUTNKeDVBVEVF?=
 =?utf-8?B?bmZEYTdlN2xhdVY4R1A1QVlnK3RLNkt2aEY1aTJoYlpyS2tJbTdkYUVGSkU0?=
 =?utf-8?B?Q0krZm5pQmp3bHhUTlAyWWdJWWdaalRGdUxCTzRBTzZGUDBIcGlBNnV5b3FX?=
 =?utf-8?B?QnREaUdkWUE1ZytMSkx1SGdiUDQ2N2lLNVVDMmpPNEUwSzBmcWlVQWRHenF3?=
 =?utf-8?B?MUplcjRnTC9LSVo4T0Z5NHNQOGxIOHBUdUwwRFlLWFZYT0xxR3owckpZSW5h?=
 =?utf-8?B?cDJyZTV6RmRYdjV5Q1pxcmJUYUZSQnBJN05BMDVQRjR3OThFbURWM3pKQ1NY?=
 =?utf-8?B?MWlNT1huUmtDRFI2TlVrblNsZlFBSzViOHIwNU9ka0NVdkhWNXRLU0ZMd3Z2?=
 =?utf-8?B?eHRhbkJiZzFaZUwrREpSb3daS3RFeXFHQXFSRTRkeG4yTlE5U0tRM21USHIz?=
 =?utf-8?B?OWNxdWtLVmRzUjlhcXh1TkJ1U2trNDN5Uk5uOGgwZ3NsaXRJdkh0eTI5b2hQ?=
 =?utf-8?B?OUFyRHZ0OHNjQ0NaRTlOVXJ4VWpJSnYzbk5oQWRwbk1rVFd0ODN2TmdUdVdv?=
 =?utf-8?B?SXcxV2FiaXRIRTVKLyt0YkJld01TeXRheXp3MDNkbHZ3Z3BnaFNVWVJ5UldW?=
 =?utf-8?B?bVRyUVRFV1lKeVpLOGxWQytYK3hKMHhMZDJVZkp0SnUzUkVXL2I2TFUyYjIz?=
 =?utf-8?B?WUZyeTh0QXgvT2loSmFyREhhTzBZU2RDL0ZzcndTQ2hRak5Za21ubkR4b1Ew?=
 =?utf-8?B?K0dpWTZ4QURhQmFuS2cvaTdZQ014TzRrQy9GM0srUncvQnhva2RtcFRKbHFs?=
 =?utf-8?B?NDVmRDQrM1hxYy9FZVQ1WFlWcm1zYXNWU2M1TDd5b0JxU202NVhPcEVBM1NM?=
 =?utf-8?B?RnZETCtWdU91U09uNTI0bWJSRFdKRmJjUXR3emh1ZDJrNi9TcXp3di8yQlJJ?=
 =?utf-8?B?cC9pVUxWNkNJT1NjRkVRYnl3Nkc1RmNpUmVxVFVBditCNjBYeFdJSG5CK2c0?=
 =?utf-8?B?R28vakhjRzk1WlZUclpPT1czemVyODhtaGZ5cm0rUm80YmJIcU1vN3U0NTR0?=
 =?utf-8?B?UE5DMnBWWkN1QWxsbjNqTW5BUXFhcUpPWnNVcEY0Vzg2K3pFN3JVeC82ai9m?=
 =?utf-8?B?OVlaMkFraFd4NHpSODlSem5XeHdxZWxvNTBwdjU5aU1TNTduQ2FuK1RxVitD?=
 =?utf-8?B?ckIvOWdvdzhsZFhWQm4rSGt4K1pybHpBcjAvL2VBYTkzaHFLWE5nMDJuZ3Bi?=
 =?utf-8?B?L3RiY1RBQUZUVys2QWFPZUd1QVRlNmFiSjkxLzVDVTRRd3ltVmZ5Y29XQTlE?=
 =?utf-8?B?VVR4MjI4R1Z5cE14Y0ZWelAwRVVneUl2VHFYSUhjVTBSQXlkbXpKOVFja2JP?=
 =?utf-8?B?eElmQ0c2am9FekllUWNmRGQxSlJCUmgrMU90aW1UVDgrcVQ0VUFkMVFUQmhT?=
 =?utf-8?B?WTE1VEJMMkJpcVJHZTFoMEVldXhGM3dhRUZmYVlrSVZBUGhaWW5JVnE4aU14?=
 =?utf-8?B?VVRNVDRKTW8raGNsa2JoMXNaOW11a2VSUDE1a2gwbUtzVHBzV05xdlBUNjRC?=
 =?utf-8?Q?AZE0fImpCLC+VRGg2L83ZZQ=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce2845e-9248-4a7c-db3b-08dd89af8c42
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2025 19:28:42.1592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JphIlIUTwczxhQof4QQWeUVGs1LIe0fhxdXUMOUCgn/wnt685i5dMxhwk0k89yWpQZcYmoETEMbnAuyZkHOZNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB6179
X-Proofpoint-ORIG-GUID: S71bubs2rkDEZO3o96KeTNYtm23z5wFk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDE1NCBTYWx0ZWRfX3f6PJcdVwgcb SCOgqGeITo/kqnxGycyfoUiCFJuAvV/iDMLiiSJ9M+I18jHIHH2/d3O98FKp7i8vjJVexfCFyJp nfh6zSU++7uDQI+gPTz/arx6aWaS2SbBLcED7Jhuf/qZaqAihWR5v0dagruKNzNWsX/tbaVQ97W
 Vm1kZ6C+2rUkjDjtqmI7mgNKICR3zh1FgRQnj2hjsYh17kyR/Fl5wcm/hwYLM92sRbfnOXtuM2v BuF1kXf2RE2GfaDgZY3zKI2UakBTCayU6ngX1qtcKav747SUBdfppuGp407nu/DkACtA9JH6k/j SNm0aormJlHRTIS2VxR1Ym5SJwBCedjFa0XR7HLwqWUk5Bp3HLwq6MNZfl2SC0xqfbLWnSsksz3
 ls/4kZyuGm4I6JZfrEPg4RCMdNSgqa9teewqRhNtxyyL8gFFZK03hD/P2Loytq28K8PRLoqz
X-Authority-Analysis: v=2.4 cv=YqMPR5YX c=1 sm=1 tr=0 ts=68151cec cx=c_pps a=gaH0ZU3udx4N2M5FeSqnRg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=NEAV23lmAAAA:8 a=4c9q5e1nTJFxJkTHqFUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: S71bubs2rkDEZO3o96KeTNYtm23z5wFk
Content-Type: text/plain; charset="utf-8"
Content-ID: <99EF752A39E18C438936A2619778728E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  KASAN: slab-out-of-bounds in hfsplus_bnode_read+0x268/0x290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-02_04,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1011
 impostorscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2504070000
 definitions=main-2505020154

On Fri, 2025-05-02 at 04:59 +0000, huk23@m.fudan.edu.cn wrote:
> Dear Maintainers,
>=20
>=20
>=20
> When using our customized Syzkaller to fuzz the latest Linux kernel, the =
following crash (14th)was triggered.
>=20
>=20

Thank you for reporting the issue. Let us take a look into this.

Thanks,
Slava.

>=20
>=20
>=20
> HEAD commit: 6537cfb395f352782918d8ee7b7f10ba2cc3cbf2
> git tree: upstream
> Output:https://github.com/pghk13/Kernel-Bug/blob/main/1220_6.13rc_KASAN/2=
.=E5=9B=9E=E5=BD=92-11/14-KASAN_%20slab-out-of-bounds%20Read%20in%20hfsplus=
_bnode_read/14call_trace.txt =20
> Kernel config:https://github.com/pghk13/Kernel-Bug/blob/main/config.txt =
=20
> C reproducer:https://github.com/pghk13/Kernel-Bug/blob/main/1220_6.13rc_K=
ASAN/2.=E5=9B=9E=E5=BD=92-11/14-KASAN_%20slab-out-of-bounds%20Read%20in%20h=
fsplus_bnode_read/14repro.c =20
> Syzlang reproducer: https://github.com/pghk13/Kernel-Bug/blob/main/1220_6=
.13rc_KASAN/2.=E5=9B=9E=E5=BD=92-11/14-KASAN_%20slab-out-of-bounds%20Read%2=
0in%20hfsplus_bnode_read/14repro.txt =20
>=20
>=20
>=20
>=20
>=20
>=20
> Our reproducer uses mounts a constructed filesystem image.
> Problems can arise in hfs_bnode_read functions. node->page[pagenum] cause=
s out-of-bounds reads when accessing memory that exceeds the range of the n=
ode's allotted page array.
> In particular, when a hfs_bnode_dump function reads with this function, a=
n offset or length that exceeds the actual size of the node may be passed i=
n. In the hfsplus_bnode_dump (inferred from the error call stack), when tra=
versing the records in the B-tree node, an incorrect offset calculation may=
 have been used, resulting in data being read out of the allocated memory. =
Consider adding stricter bounds checking to the hfs_bnode_read function.
> We have reproduced this issue several times on 6.15-rc1 again.
>=20
>=20
>=20
>=20
>=20
>=20
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.ed=
u.cn>, Shuoran Bai <baishuoran@hrbeu.edu.cn>
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-out-of-bounds in hfsplus_bnode_read+0x268/0x290
> Read of size 8 at addr ffff8880439aefc0 by task syz-executor201/9472
>=20
>=20
> CPU: 1 UID: 0 PID: 9472 Comm: syz-executor201 Not tainted 6.15.0-rc1 #1 P=
REEMPT(full)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubunt=
u1.1 04/01/2014
> Call Trace:
> =C2=A0<TASK>
> =C2=A0dump_stack_lvl+0x116/0x1b0
> =C2=A0print_report+0xc1/0x630
> =C2=A0kasan_report+0x96/0xd0
> =C2=A0hfsplus_bnode_read+0x268/0x290
> =C2=A0hfsplus_bnode_dump+0x2c6/0x3a0
> =C2=A0hfsplus_brec_remove+0x3e4/0x4f0
> =C2=A0__hfsplus_delete_attr+0x28e/0x3a0
> =C2=A0hfsplus_delete_all_attrs+0x13e/0x270
> =C2=A0hfsplus_delete_cat+0x67f/0xb60
> =C2=A0hfsplus_unlink+0x1ce/0x7d0
> =C2=A0vfs_unlink+0x30e/0x9f0
> =C2=A0do_unlinkat+0x4d9/0x6a0
> =C2=A0__x64_sys_unlink+0x40/0x50
> =C2=A0do_syscall_64+0xcf/0x260
> =C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fcd9a901f5b
> Code: 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0=
f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffeefb025d8 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fcd9a901f5b
> RDX: 00007ffeefb02600 RSI: 00007ffeefb02600 RDI: 00007ffeefb02690
> RBP: 00007ffeefb02690 R08: 0000000000000001 R09: 00007ffeefb02460
> R10: 00000000fffffffb R11: 0000000000000206 R12: 00007ffeefb03790
> R13: 00005555641a1bb0 R14: 00007ffeefb025f8 R15: 0000000000000001
> =C2=A0</TASK>
>=20
>=20
> Allocated by task 9472:
> =C2=A0kasan_save_stack+0x24/0x50
> =C2=A0kasan_save_track+0x14/0x30
> =C2=A0__kasan_kmalloc+0xaa/0xb0
> =C2=A0__kmalloc_noprof+0x214/0x600
> =C2=A0__hfs_bnode_create+0x105/0x750
> =C2=A0hfsplus_bnode_find+0x1e5/0xb70
> =C2=A0hfsplus_brec_find+0x2b2/0x530
> =C2=A0hfsplus_find_attr+0x12e/0x170
> =C2=A0hfsplus_delete_all_attrs+0x16f/0x270
> =C2=A0hfsplus_delete_cat+0x67f/0xb60
> =C2=A0hfsplus_rmdir+0x106/0x1b0
> =C2=A0vfs_rmdir+0x2ae/0x680
> =C2=A0do_rmdir+0x2d1/0x390
> =C2=A0__x64_sys_rmdir+0x40/0x50
> =C2=A0do_syscall_64+0xcf/0x260
> =C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
>=20
> The buggy address belongs to the object at ffff8880439aef00
> =C2=A0which belongs to the cache kmalloc-192 of size 192
> The buggy address is located 40 bytes to the right of
> =C2=A0allocated 152-byte region [ffff8880439aef00, ffff8880439aef98)
>=20
>=20
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x439ae
> anon flags: 0x4fff00000000000(node=3D1|zone=3D1|lastcpupid=3D0x7ff)
> page_type: f5(slab)
> raw: 04fff00000000000 ffff88801b4423c0 0000000000000000 dead000000000001
> raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(=
GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0=
), ts 46334294792, free_ts 46209226995
> =C2=A0prep_new_page+0x1b0/0x1e0
> =C2=A0get_page_from_freelist+0x1649/0x30f0
> =C2=A0__alloc_frozen_pages_noprof+0x2fd/0x6d0
> =C2=A0alloc_pages_mpol+0x209/0x550
> =C2=A0new_slab+0x24b/0x340
> =C2=A0___slab_alloc+0xf0c/0x17c0
> =C2=A0__slab_alloc.isra.0+0x56/0xb0
> =C2=A0__kmalloc_cache_noprof+0x291/0x4b0
> =C2=A0call_usermodehelper_setup+0xb2/0x360
> =C2=A0kobject_uevent_env+0xf82/0x16c0
> =C2=A0driver_bound+0x15b/0x220
> =C2=A0really_probe+0x56e/0x990
> =C2=A0__driver_probe_device+0x1df/0x450
> =C2=A0driver_probe_device+0x4c/0x1a0
> =C2=A0__device_attach_driver+0x1e4/0x2d0
> =C2=A0bus_for_each_drv+0x14b/0x1d0
> page last free pid 1277 tgid 1277 stack trace:
> =C2=A0__free_frozen_pages+0x7cd/0x1320
> =C2=A0__put_partials+0x14c/0x170
> =C2=A0qlist_free_all+0x50/0x130
> =C2=A0kasan_quarantine_reduce+0x168/0x1c0
> =C2=A0__kasan_slab_alloc+0x67/0x90
> =C2=A0__kmalloc_cache_noprof+0x169/0x4b0
> =C2=A0usb_control_msg+0xbc/0x4a0
> =C2=A0hub_ext_port_status+0x12c/0x6b0
> =C2=A0hub_activate+0x9f6/0x1aa0
> =C2=A0process_scheduled_works+0x5de/0x1bd0
> =C2=A0worker_thread+0x5a9/0xd10
> =C2=A0kthread+0x447/0x8a0
> =C2=A0ret_from_fork+0x48/0x80
> =C2=A0ret_from_fork_asm+0x1a/0x30
>=20
>=20
> Memory state around the buggy address:
> =C2=A0ffff8880439aee80: 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> =C2=A0ffff8880439aef00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > ffff8880439aef80: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0^
> =C2=A0ffff8880439af000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> =C2=A0ffff8880439af080: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=20
>=20
>=20
> thanks,
> Kun Hu


