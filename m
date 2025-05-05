Return-Path: <linux-fsdevel+bounces-48151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50378AAABBD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 04:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF2EA7A45DB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 02:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5601E399EC0;
	Mon,  5 May 2025 23:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PS2ENmln"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5332ED097
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 23:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486526; cv=fail; b=ozfFTQPwaKwQJZWEVGzEZgrf8THQktTaRhrjJGMu293p5muqNMQ3nxqi65E++7vRHYVqxMlSSCRFO6IsVD3yWvmehox9qnLS2QqtrznoDr0VIVYjYPqJUI6E5p7boFS2qLPG1tRcG5AEqccZIqEaYHrrMmaqnNL3DQkIN6O7Flk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486526; c=relaxed/simple;
	bh=fs6z7ej48ITCu6X7roI71yExNyiCM/DNKupiC+Crltk=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=fEQGnn27UQf/hDl4hDzLDSDy3pffS+pd/49lGdR8qgrGtBgJ1TVdIux/AjeVJD4JA2VCTn52uuPR5VX2EBax2TlPF4oncCvOzPwZzQQm8QVT/tczEHEYNsIRHC/yB2yY5WGkU/IcECOm2SwTeP4ESxtZeh58yftPbsyskPO9ui8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PS2ENmln; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545L3VsE018144
	for <linux-fsdevel@vger.kernel.org>; Mon, 5 May 2025 23:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=H5BAW34duUhsL1gslNVcka2asPKisiyWAbBzO1FPCBY=; b=PS2ENmln
	p3AUpnEMR0yxbKtE8MeE75cP/CB1uaFEoL90PCkMH4io3/xIFG7JrC+teJVsXKXD
	GEgqBcjjMMJ8xyBR/INwGYnlEzrpDAu7TVVJn2uWmso4yjyhOwpeejnm1dt+2NOH
	aSeBA8EeKZs/vAydS9QiHtxNifGHO4Yc3mCdVdFWoY3fHNuv+QonQmHsaXUuEvL9
	TZGpR6Plq11RVB6DfWxQvUtunYYdgeeC0opU3tyA3fRsvYUAUTInpbcTtbgKoVO0
	ki+ndB3iM3yyEUyVcmOPvxv1aspMZXmPemt2FFPvDaqULGKNzdKq9pUGYQDJY63Y
	cm/9sY3woAXqKw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46f4wkge01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 05 May 2025 23:08:43 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 545N8glt032406
	for <linux-fsdevel@vger.kernel.org>; Mon, 5 May 2025 23:08:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46f4wkgdyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 May 2025 23:08:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOtRlqGBMGtbBOlfvtdbJQKhWxIfw1/ojQ180mdO+Yz6lhInFt3tSMjuYML/5KeZzbNvuktw9TCm9qQGoEacn5aedtDa4S7MxouCGMYJktzwJb5hFcgGeggewCGn/x61G8FfeT6qXn4zgeFxW21EPEbMYHqXay6TuM4WqoEz/GlhxAtUSo+HwR0O7NcqMWmK8uX3oIcD1RBqk04ntCZ4/QvVhkMFtFD612AwI979x/ZHIZyCkwQx8bF7IENqxZUPsFw4ahqfwEnkxKcMmTo6tQ43iUssaMIUonebzBVLIlWPgSTlB8t0riMchf0tPFvfkWSBHLXKeZ5viwZ8ZL27Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqLiaJXuUp8kTJ99ptKsz19F3FLmPoLcfu07o3WFZEw=;
 b=NToJKF/sXaWxtg7TBsfBEewagq9NBqN5HCDKz28uELRD8sMDKI9c4flgZGPk+Qy68gxTMWfX8lhXEiEGJ/ZJTyhTc7RLEMaVYgkusZtWQRPhZMKfogBrbQw7G2FykqNwcH2fggC3Eo5H9g4PoXqAEr5WbStyKll8D69CnxocSHk8E6Q8utDG7dMPd7yV3INCRjoKiwvDsrRzLhBbz6H7uyXLPUC0PagktXJPiR7V9gm74Lt1QRHPtUaQDquXW034ALo3rPLcV+tHlHHvNoXaxrKj3UGHnOapiggVaquxrZBZ0L8tMFYHqGBXirOAGkfTLtOp7DWMULY6xtIaYHku4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA6PR15MB6614.namprd15.prod.outlook.com (2603:10b6:806:41b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Mon, 5 May
 2025 23:08:36 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%3]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 23:08:36 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "tytso@mit.edu" <tytso@mit.edu>
CC: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>
Thread-Topic:
 =?utf-8?B?W0VYVEVSTkFMXSBSZTog5Zue5aSNOiAg5Zue5aSNOiAg5Zue5aSNOiDlm54=?=
 =?utf-8?B?5aSNOiBIRlMvSEZTKyBtYWludGFpbmVyc2hpcCBhY3Rpb24gaXRlbXM=?=
Thread-Index: AQHbuw53qFDnaUF3rUaiuT9fy8DnH7O/triAgACurwCABEm9gA==
Date: Mon, 5 May 2025 23:08:36 +0000
Message-ID: <09bcae03fbba09cc40aff834a9a957436ee70a4a.camel@ibm.com>
References:
 <TYZPR06MB527574C2A8265BF6912994E6E8842@TYZPR06MB5275.apcprd06.prod.outlook.com>
	 <84ebd3fb27957d926fc145a28b38c1ac737c5953.camel@physik.fu-berlin.de>
	 <SEZPR06MB5269CBE385E73704B368001AE8842@SEZPR06MB5269.apcprd06.prod.outlook.com>
	 <d35a7b6e8fce1e894e74133d7e2fbe0461c2d0a5.camel@ibm.com>
	 <SEZPR06MB5269BB960025304C687D6270E8842@SEZPR06MB5269.apcprd06.prod.outlook.com>
	 <97cd591a7b5a2f8e544f0c00aeea98cd88f19349.camel@ibm.com>
	 <SEZPR06MB52699F3D7B651C40266E4445E8872@SEZPR06MB5269.apcprd06.prod.outlook.com>
	 <7b76ad938f586658950d2e878759d9cbcd8644e1.camel@ibm.com>
	 <20250502030108.GC205188@mit.edu>
	 <471a4f96e399d84ead760528cb0b049464f83845.camel@ibm.com>
	 <20250503053938.GD205188@mit.edu>
In-Reply-To: <20250503053938.GD205188@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA6PR15MB6614:EE_
x-ms-office365-filtering-correlation-id: 03ff7297-4a7b-419a-4e09-08dd8c29c3b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S3JuQVpQTHN0Tk9KYXlkZjJ3dGhUVWh5QTU4Rldob21ocmtab2JkNTl3b1RD?=
 =?utf-8?B?WEE1QUJ3cndkdndsNHhJRC9LL3MxdWlZbXgyL2VlVjBTSFlzVml1RXl1SDMz?=
 =?utf-8?B?VWFaSk82OXJFTUpyMVhYTUhVQVcyMTV3UlJVSmRZekYwVkd5S3JwTXpSR2Jq?=
 =?utf-8?B?b09VVmZxeU9EbHg2SmhDNUtBbzJmNXYwbnFSNlQ5ZXAyZ2t4N1A4ZW1sRDRT?=
 =?utf-8?B?NGpsOStuRG5TTGZuenJjbGtIZFphdTlJYmxvUUZJOFVUbUdFVjcvelBSUTNT?=
 =?utf-8?B?cFVLdXU1UmRZT1NtdExmTVNTTXk3TmRHcUFLS0ZqcG5MdmI5eHJDVGloV1M1?=
 =?utf-8?B?azVJSXZ2TkZRcFFxRVl4L05GUTdOMS83QnpRY2RNYmNwOUVLdTg5d0VsRnNF?=
 =?utf-8?B?MHhXcytGVWZyM0lrRG9DeW96WitrQWtOZGhIc1FGU2pOTkN4SWlWdmZQMGxZ?=
 =?utf-8?B?RmkvcTgzc1k3S1ptT3VXOEpkT1Y0TkRGTXRZZzd3QmROSUwyUWZOZzNLNzF2?=
 =?utf-8?B?TTdYV1JkRW5HWklNbXBzWmF1RmdyaUJuSllnbUR2ckV0UEtQU3FBZ0hxbVh5?=
 =?utf-8?B?K3AyRkt2aThVSVcxUk5YYm50WXluRmwrZVlpcWlVdGdlRm9UWXZ6Y3huZ3Vm?=
 =?utf-8?B?bHZqaTFEV3BPQTRwM1R3RlVqbEh3VGRVR0s1UzhKWjZlSEFaZWJMQnF2Mk9o?=
 =?utf-8?B?QWI5bnRwd3lOVHhoSVB1ZTBBcm5RZTh0SDg5MlhjSDF1ZytIbjFQbjE1SzMw?=
 =?utf-8?B?aFJBaVRDOFErMmFzS0RXZ2g4ODZmOTY5cGtObDhmam9uem5YZmlNMVhWNklN?=
 =?utf-8?B?ZG5iaXduRU5NZTM0SlJncm00YlNYbFdRQnFiZ2NvbjFwUndqWFRZN3ZWaEt3?=
 =?utf-8?B?M3FYaTNjNnhrbUNiYk1RNWdOQmRSSkpIQ2s3UGpYMU8waFljYWlYbS9uZEtU?=
 =?utf-8?B?cjk4RXF6VVU1QjU1K1R2cGN0QzFFRkFIYUorT1hnUVJERDFLNHMwd29tODNu?=
 =?utf-8?B?Y1VuUFJLYnZUWlIrbnBnRDVnbFQwWVUxMU1uM1ZxOXlVTERIdFY0TkQvTWMw?=
 =?utf-8?B?Ym5UWUNTY21iUnVBY0xHL1V0aFpqRVZubUhBY2d3b2tld041LzRJRHhuUEk5?=
 =?utf-8?B?WnBxV3pBdFBFR3ByalhmYVVQSEpLYTdlL1pjMHVGaVZhUUY0VkJ2YnViQSs1?=
 =?utf-8?B?MFpaeDlsQnptYTdsc0JWMmFQODRXZUI5elRIcmpBZTBBTDJnb2lZWkNZMGhZ?=
 =?utf-8?B?b1ZSWjMxZFZmQXppZnpJNFF1YnJEV3Vpdm85dUI1L3l5c3hYU3JsSjhHbkZV?=
 =?utf-8?B?R2txcU1aTDdLL0kxY3htYm8rSC9GYytDcmVlTEJiQ2N6NWpmOFYyYTdoQzVj?=
 =?utf-8?B?bUtNSjFuVWhIRHA1ZE5UUzgrRTlTV2VuQlk2WEtFSUZSZTlteHAvMUE5M3JQ?=
 =?utf-8?B?anVQNkJCTHJ5MGkxTjZDT2lBb1o4RExqVE9QdlczRk03YTgrT3llZE5SVzhO?=
 =?utf-8?B?SklNdDRXdFAzbHRjQVovNG15L2tCQkhWWTNnZkNxR3JxVFpmemRsZVVJQ1cr?=
 =?utf-8?B?YjY1RTcvM3FXbkdOV2Ztek4rTjhjcExqME1rOHhtTE84QUtsL1IrUFNaWmJK?=
 =?utf-8?B?cFQ1dmgzdExxZUQ3QnErMnFLL3J1YTQyT1Y5Z1kvUVRSTHJZQmpweENocytQ?=
 =?utf-8?B?R25zTG9pM3E5My90aGt5Q3Q4K2d4aFNCSGRWTnZXSEZRY01hZ280MzM0bm1N?=
 =?utf-8?B?aWJGbVpjRTJsdmVCOTMzOG1RNloyZEluN2s0VFF3NlFtZ2IvZlJiS1Jpb1Vn?=
 =?utf-8?B?YVBPdTNyZERsenpwcUFpN0p3d2xFdHQvZXBIb2ZGSnZmbXNyS0VlWExZZjBz?=
 =?utf-8?B?N2MyeTlaSGFDU2xvSjhhZUNWY0x5Q0taVFdTejB3TGM3MXJ6RlZYQXRPaWt4?=
 =?utf-8?Q?T9qrAYPGk/c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U01DSHJjYXBPQXBQR1dkRUkwOUlTY0xvMWttRWdpeUVUQkIxU0hJSEZhQ3RI?=
 =?utf-8?B?YnR4M0xEZThkeGN6c1NHV0JaUHJHMUVCOUtuMXBhdnBaK3hSeFRCcHlvbzZn?=
 =?utf-8?B?WUIxeVpWYXhmM3JYTUp5VUwvM2NhWFNCYzBoUWtuN0ZDTFFiQnp0bE9QYzRZ?=
 =?utf-8?B?dUFoMXhpcFlwVTJ6dEloamgzbzBsTkdXc1lSN2R5d3FXRXNmNllXTitZMWJp?=
 =?utf-8?B?S2Q0cFR5aGJKeXNtL1NaRUlWUURUR3E1NEJyWU9laHhNN1FBL01BYVpmQmdM?=
 =?utf-8?B?RytHU0FXZkZCRnRxOW9TcGVvdzQ2N2xVNDhHclNmbFFnRTFyRlFVcGtzZHdr?=
 =?utf-8?B?WXJlOWR5bUI4ZlUvQ01kOEhYNkI5ZHQ5eXpEc2wrdG4zUjBKbmUrNTM1U2gv?=
 =?utf-8?B?MlpDQjlQWXgrUlZheFJjNTBRRzQ4QThiWUJ2WEFNRXdHcHVIUXhHYnNSSFd2?=
 =?utf-8?B?TVE0ejZRalRMS2szV1RCZWM1N0VuZVVDL1pEckthaTRkN3l4dUIxWWNEYk5U?=
 =?utf-8?B?eFpPbmJRTlp4ei8yaFhYRFl4ZUd0MzVsNm5vNHI3OWZreWhZdFVselJwRzYz?=
 =?utf-8?B?WXI0d2NlaGhLK05leDRWSjhoQUdkSzdHUDBLQ1dMajZUdUhTb0Q1dW8xQlBW?=
 =?utf-8?B?VUpHQm5ZTHlzUE5pblREelNXMFdxY29keE9rbXZLbDFvdyt4SUM4b2oxMktF?=
 =?utf-8?B?ZmxmWDF5UGJKWjRTWUszNElBZDA3ZFlubjJEWkJPRkpVTmZ0aHlRR1FLUk1w?=
 =?utf-8?B?ekxBbWovZit3c3hldXlEQlNrczZDSlBtY05oMUNnQ3Zyc0M3Unp4UmhtVGJQ?=
 =?utf-8?B?MXgvaDZSVTB4YkttRjVBTS9VaXZGRUMrdHU0ck5KUVlERGNydjhydzhMRTdx?=
 =?utf-8?B?enlzUjNJUW5ZeHN1UlJwaXd2ZXkwS0ZsOVpESGJZZ0Vid2MwY05mRE02YjAr?=
 =?utf-8?B?T1FiaFU3RkFSeFZ2aERNZEFqZUVJNHptQ3Z1ckM3Qis4ajE3V2pQc2pnME8w?=
 =?utf-8?B?Y0gvNjVLSFI2djdJakpqMi91M0JvQm15NjhpaThrTTFVV0lSMjQwOGhaOHUx?=
 =?utf-8?B?Zm1MNnA5NmFzTDh0VGc3Z2VTNTdMTEZzWG1yTlNwQUgyK1R5OHBqeDB5UEZC?=
 =?utf-8?B?OWlWNUphM0J4M0ZjZ0xCMkhSQ1pTZ2w2MHVKb084RmlZMjhPMCtxeUpNL2pS?=
 =?utf-8?B?MWgzTUpJRWd0UDZVcERQZUJwU0x3WDdDYUpCQ1pHY0VpWHhWR0g0dVJTRVRJ?=
 =?utf-8?B?OWtNei8zbHhuWERMMEhSdXovNkxrNDZqL0hzUUN2NkxWU3VLUk05WjlCSmNU?=
 =?utf-8?B?K3hLWTMzWXdjMGVTb2c1SFNmTnVvUHlSbDJNWG5ldjh4NFp5dVdwbTM2Z0hC?=
 =?utf-8?B?eElIRXFCRDI5UGc3Y2JBTGZFM1FzdFhHQXdkalZqVG1FVVFHdUhGNHM3YWNB?=
 =?utf-8?B?TjhIRWVqQW1zb3FSWGtnYUt6OUZjNGg4MHZ6SVMwdmtmS25OM29SZHNrWmpy?=
 =?utf-8?B?RStvQ3RaT0FxNmZjVGlFaG9LK3A3R0ltSFBoQjk1L0VwWGNPTi92eENyOE8y?=
 =?utf-8?B?WGFTUExzNVlCSUw4WFBmeDQyOEN2RGc3aGJESXgzNlpBQ3d6Q2ZWOWhyMXpZ?=
 =?utf-8?B?d2Z2OVpRWmR0cWd5WE42dkIzYTRzQm45YWgzNGxCVzJtU200Z1h2Wnd1QVhy?=
 =?utf-8?B?d2VVVGNRUUhId3M2bk1Fb1gxNDJmMmR0VDBpQ3VJNDVvMWFyK0pTQU1QVnVS?=
 =?utf-8?B?OHRTeEQrSENhbk5kek5EcFhYcm54OVZEd3ArSUhLanhWUzlJQ0RHcndEaHFp?=
 =?utf-8?B?S1pKamhyQlBnQVU1ZXFQaUJGcGtqTFNoMVVWa09UR3dVUDVGZDIyQUF1alg0?=
 =?utf-8?B?TTA4MkEwamR3Z2ZQaHpqaDY2L0tKcm1IbjBuUjBPT0lrdjFnbFdScjVESy8v?=
 =?utf-8?B?QjVyQkQxZEFsMTYrQVRPRkxxdFhWR1VBNEloRnFPbXdHZTR2STNYVER1N1ZD?=
 =?utf-8?B?cE9TcW1XYXhhU01RWWxQbXBhSlc3d1U1ajFHaGE0WVNzR3J3MXcxbStHOWhX?=
 =?utf-8?B?SnJYV3ZQMkFpYzd6em8xdlRlLzhkMHhFdnNYY1NPeXIxUU90RXZRYUt5ZTVj?=
 =?utf-8?B?ak55QU91NUthdEJDODFiUm1MRnlkcHVpYkxiVjZGRHBZRVFmNWJPSGdYWnpB?=
 =?utf-8?Q?g3OOKDHqC/T9ljgvEgQfBGw=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ff7297-4a7b-419a-4e09-08dd8c29c3b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 23:08:36.0953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eomx4Wkly7N/rN1Xk9CUYiXhMjJQr63HgUQX/qezuiUuFTIR7a3vxGHMBo341PCjXDVPGO26RowJeFByEU8fcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR15MB6614
X-Authority-Analysis: v=2.4 cv=Up9jN/wB c=1 sm=1 tr=0 ts=681944fa cx=c_pps a=IYePPuTyj3qIg1BHBNk0GA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=5KLPUuaC_9wA:10 a=Oh2cFVv5AAAA:8 a=PnleBzDVlKaT7qTgy4AA:9 a=QEXdDO2ut3YA:10 a=7KeoIwV6GZqOttXkcoxL:22
X-Proofpoint-ORIG-GUID: 9U8bsfn3Mv-t7FLI2F9ooz49ASm0lFag
X-Proofpoint-GUID: 9U8bsfn3Mv-t7FLI2F9ooz49ASm0lFag
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDIxOCBTYWx0ZWRfXzeyaKQM6sXig V9C0lfG1sLzllD7fGRx9XdBxX8BqkwCplLeSg5jk/b+PXsF1zhkCwH5P0xj/dP7c7+0kfOZGg00 TpGkXlXQfSoh9PhAqpJeCbw6uzX0QG0FmVc07L6MHX3lpJM8yMtref/FyUogiEdYqFMY63O/j+W
 VJyfJnxKr0ZV3t0lKB+DM55O9LdkaoPuD8J73wqmCQCuLcTzOquPf+ts7nTD77Bva3RmFP/A0wm XDK/73wFlBWtVsUkH0nk+xPVa0DwXKqGELsHkl5KINdm5EJ3OE/KAQ3AggcGILxpSTN8LIvw3CG JShnBSMp3Epaa4iUrZ3w5bu57wsooD8jtYI2Eh2EylD9m8o8dG6CF+Uz/6VNwhTEkyyCXx9b50d
 LWcyHShA9efvXHrpPRRhXc0LNIYw6PRzjaJK6fszNUROlyNBPn/Lh1d+DThg4bTi4MoZIHEl
Content-Type: text/plain; charset="utf-8"
Content-ID: <2714F6C7CB11E2428C103E9E4E08E8C3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: =?UTF-8?Q?RE:_=E5=9B=9E=E5=A4=8D:__=E5=9B=9E=E5=A4=8D:__=E5=9B=9E?=
 =?UTF-8?Q?=E5=A4=8D:_=E5=9B=9E=E5=A4=8D:_HFS/HFS+_maintainership_action_i?=
 =?UTF-8?Q?tems?=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_10,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.19.0-2504070000
 definitions=main-2505050218

On Sat, 2025-05-03 at 01:39 -0400, Theodore Ts'o wrote:
> On Fri, May 02, 2025 at 07:14:26PM +0000, Viacheslav Dubeyko wrote:
> > On Thu, 2025-05-01 at 23:01 -0400, Theodore Ts'o wrote:
> > > Hey, in case it would be helpfui, I've added hfs support to the
> > > kvm-xfstests/gce-xfstests[1] test appliance.  Following the
> > > instructions at [2], you can now run "kvm-xfstests -c hfs -g auto" to
> > > run all of the tests in the auto group.  If you want to replicate the
> > > failure in generic/001, you could run "kvm-fstests -c hfs generic/001=
".
> > >=20
> >=20
> > Yes, it is really helpful! Sounds great! Let me try this framework for =
HFS/HFS+.
> > Thanks a lot.
>=20
> FYI, I'm using the hfsprogs from Debian, which at the moment only
> supports HFS+.  The prebuilt test appliance for {kvm,gce}-xfstests are
> based on Debian Stable (Bookworm), but I am building test appliances
> using Debian Testing (Trixie).  However, for the purposes of hfsprogs,
> both Debian Bookwrm and Trixie are based on the 540.1 version of
> hfsprogs.
>=20
> But there are plenty of bugs to fix until we can manage to get a
> version of hfsprogs that supports HFS --- also I'd argue that for many
> users support of HFS+ is probably more useful.
>=20

Yeah, HFS+ is more important. And, yes, we need to manage a lot of bugs yet.

> If you find some test failures which are more about test bugs than
> kernel bug, so we can add them to exclude files.  For example, in
> /root/fs/ext4/exclude I have things like:
>=20
> // generic/04[456] tests how truncate and delayed allocation works
> // ext4 uses the data=3Dordered to avoid exposing stale data, and
> // so it uses a different mechanism than xfs.  So these tests will fail
> generic/044
> generic/045
> generic/046
>=20

Yes, makes sense. Let us identify such cases at first.

> Since I aso test LTS kernels, and sometimes it's not practcal to
> backport fixes to older kernels we can also do versioned excludes.
> For example, I have in /root/fs/global_exclude entries like:
>=20
> #if LINUX_VERSION_CODE < KERNEL_VERSION(6,6,30)
> // This test failure is fixed by commit 631426ba1d45q ("mm/madvise:
> // make MADV_POPULATE_(READ|WRITE) handle VM_FAULT_RETRY properly"),
> // which first landed in v6.9, and was backported to 6.6.30 as commit
> // 631426ba1d45.  Unfortunately, it's too involved to backport it and its
> // dependencies to the 6.1 or earlier LTS kernels
> generic/743
> #endif
>=20
> Finally, I have things set up to automatically run tests when a branch
> on a git tree that I'm watching changes.  For exmaple:
>=20
> gce-xfstests ltm -c ext4/all,xfs/all,btrfs/all,f2fs/all -g auto --repo ht=
tps://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next   --=
watch fs-next
>=20
> gce-xfstests ltm -c ext4/all,xfs/all -g auto --repo stable-rc.git --watch=
 linux-6.12.y
>=20
> gce-xfstests ltm -c ext4/all,xfs/all -g auto --repo stable-rc.git --watch=
 linux-6.6.y
>=20
> If it's helpful, I can set up watchers for hfs and send them to you or
> some mailing list once the number of failures are reduced toa
> manageable number.
>=20

Sounds great! But we definitely have to reduce the number of bugs to manage=
able
level at first. :)

Thanks,
Slava.


