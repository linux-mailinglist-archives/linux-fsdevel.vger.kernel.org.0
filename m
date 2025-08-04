Return-Path: <linux-fsdevel+bounces-56693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F54CB1AAB9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 00:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0DB1644CA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 22:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA7723AE9B;
	Mon,  4 Aug 2025 22:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DxlspePe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6E0238C07
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 22:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754344850; cv=fail; b=vCQMEYNDxbnmUBZiSMsmpd9Oust1o5ip01KGO5DKAf+r5/ADtCUOTWY5D797Xxbdb0uv8oMgIcfoXPu17rM/nCGKFxmt/XSsX5dTxQnR4G6vVfEbuMrlU0DavKC9Zo4RfWsfGgM1HrhQ44Dq9PmpUJk8SW2RuLY4uYerfcYnDdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754344850; c=relaxed/simple;
	bh=+r9lwPjwcJBqSXl/rex9d1/i8/Fmamb7Yb6VCJdCze4=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=sf2RIR8vP8xxBmxJbHZXyvFoNtkoCSxxL1mMPLX1JswOLVXHjMm3TjBt8H/m6pmwtmOMxFCsJo1fTA8PCptCi95RpBRvyLN5Q0YGOJFguE5UUZR4ntxv/1UvJdx9f+M5Ghrv/UmfkvJvh72pFnFz/qf40W/D+uUht9LLdwzEOHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DxlspePe; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574IKoZq001100
	for <linux-fsdevel@vger.kernel.org>; Mon, 4 Aug 2025 22:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=G5h3IV5uHPEIyTWNtpJTz3DUGVzfwHIpycJGZl2snpM=; b=DxlspePe
	Rt323IT1a5oWqS1flW23MnaYnB18tH85o9hJKAHnBs5VjnjK1ZtVrhkF/WUXBA/Y
	9RV+8vYTQWEdMcvDaIsvcPopCUCrZPGkAQfr9NVfyRIFlIVYZxUVNtjM2BmgN5HB
	yquruaE6gIog61IJ479WDT7rZSj9kb4405wbXMHlGgIqH2nMUYYk3Kx0Dd0/Y0ra
	PHWWtW60cmr/jAkhOiNuPdX58yhFRBzZWHRs1fVmtM9QzkaG8wb8zHSjNV/LHYS3
	TpmxGzR+YJkw7KjlcLz+E9DpwBBmP4JyOTheETuNHffp40owHMDwpUH417ktzr5h
	SVf32GUuyUiVVQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489ac0u8b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 22:00:47 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 574M0lZ7008944;
	Mon, 4 Aug 2025 22:00:47 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489ac0u8b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 22:00:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sg5hbvJ2Ym5Kxg3DGirUeSJ5vtp8WCKenH0Ip7vz2Ky/xlgs6Pds1slEFIAYACqlvLpbdbXB8i3/KmeQp3Z6YdvF8yMStFjME4jkG6MT8x+S5ehmy6n9DQQ5CHGS1d985ZN1I3xzwKQfQmUlVnsqOMid1Y94drk+We90XD7iwJH40bvWRJWVaRcl6DzGxoTfjWguz8jS4X3bfeZCVpPuyWywRuZjoOAZuWqTbNN+kF8qk7h/WDJ+nJhkPMP2Jh5EROL0gNb3lDjo3B+UPGwM16ULJC+4NMM898FvTd1DnoF/BNs8YBY/Wym1Ph3CgLGRvgDmIN8ZFBpHMtRsG0tGpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TWlP25BfGQ2b67fs+EZM1bT8f/6WpQV2IVPr7Zl5NI=;
 b=J1SgUU5Z/q6l/k14LVXcG1CB9I0Fxwj00uUv6v5/yySbQPFzkllLlLaMvsXQrXF99ox0ooaU/P2gswp1II1K5TFoROQXgyPoqvn2OixecPkcU073VCddFmiOHxxJJTJWNhirStF5zNLA7VDTVWCQRX4vFhUTeV+yrhGAnagA5Rl7Qp6N5R/lRxp3UyEGeQc7ArB4vEZTg200QiZ5VxbAaV0RIPGWi9CQMk8hpa3n50t6E79Ov4IA5jgarTShKp9obfMkb6Cb0BcoLCACC8Fp1UiM0vO43KylTDHzXMJ2eN60UEsKRWOI8vt6FJEgoRc6sL6OH8wj07w9diTwpzMopw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA1PR15MB5893.namprd15.prod.outlook.com (2603:10b6:208:3f6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 22:00:44 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 22:00:44 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "leocstone@gmail.com" <leocstone@gmail.com>,
        "jack@suse.cz"
	<jack@suse.cz>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
	<penguin-kernel@I-love.SAKURA.ne.jp>,
        "willy@infradead.org"
	<willy@infradead.org>,
        "brauner@kernel.org" <brauner@kernel.org>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>
Thread-Topic: [EXTERNAL] Re: [PATCH v4] hfs: update sanity check of the root
 record
Thread-Index: AQHcAZ226FeYjwYD5E6Yi5amYuG9G7RMh5GAgAA02oCAAWP0gIAAOWqAgAS5bAA=
Date: Mon, 4 Aug 2025 22:00:43 +0000
Message-ID: <a3d1464ee40df7f072ea1c19e1ccf533e34554ca.camel@ibm.com>
References: <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
	 <bb8d0438-6db4-4032-ba44-f7b4155d2cef@I-love.SAKURA.ne.jp>
	 <5ef2e2838b0d07d3f05edd2a2a169e7647782de5.camel@ibm.com>
	 <8cb50ca3-8ccc-461e-866c-bb322ef8bfc6@I-love.SAKURA.ne.jp>
	 <d4abeee2-e291-4da4-9e0e-7880a9c213e3@I-love.SAKURA.ne.jp>
	 <650d29da-4f3a-4cfe-b633-ea3b1f27de96@I-love.SAKURA.ne.jp>
	 <6db77f5cb0a35de69a5b6b26719e4ffb3fdac8c5.camel@ibm.com>
	 <1779f2ad-77da-40e3-9ee0-ef6c4cd468fa@I-love.SAKURA.ne.jp>
	 <12de16685af71b513f8027a8bfd14bc0322eb043.camel@ibm.com>
	 <0b9799d4-b938-4843-a863-8e2795d33eca@I-love.SAKURA.ne.jp>
	 <427fcb57-8424-4e52-9f21-7041b2c4ae5b@I-love.SAKURA.ne.jp>
	 <5498a57ea660b5366ef213acd554aba55a5804d1.camel@ibm.com>
	 <57d65c2f-ca35-475d-b950-8fd52b135625@I-love.SAKURA.ne.jp>
	 <f0580422d0d8059b4b5303e56e18700539dda39a.camel@ibm.com>
	 <5f0769cd-2cbb-4349-8be4-dfdc74c2c5f8@I-love.SAKURA.ne.jp>
	 <06bea1c3fc9080b5798e6b5ad1ad533a145bf036.camel@ibm.com>
	 <98938e56-b404-4748-94bd-75c88415fafe@I-love.SAKURA.ne.jp>
In-Reply-To: <98938e56-b404-4748-94bd-75c88415fafe@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA1PR15MB5893:EE_
x-ms-office365-filtering-correlation-id: 3c3d38cd-3581-4b3f-2843-08ddd3a25c1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d2x4Q1JTN0MzOUhZRTYwekVyWEU3NDl0amR2WDFpZVlrUlhtb0FOUWRtczU1?=
 =?utf-8?B?STBaWVMwejlmOThuVndIb1Zka1NCakVlWUpmRnpVLzVMRkxrWTR4OTFOYWov?=
 =?utf-8?B?Y3gxM0dtMHBqT3pGeWNuSCtwOS9mRXpLL29saWNkaUJMM1hqWFF4N1NBN2VY?=
 =?utf-8?B?dWFob3R5SU5NK2h4Qmp5andNcGpLeU1vT1lHMWNhTEt6WitSaFBaVWtCWWt0?=
 =?utf-8?B?ZEZsS04vaVcrT2thSXJ3SjBJQUwyNU5neWFvZHlUZ25yWkhKYWc1QWg4K1lW?=
 =?utf-8?B?d0FFazdJNnhSS1drZE5YS0VFaVptVEZKQTVIaWd3THpDQ0x4ZERmRklTU3dE?=
 =?utf-8?B?VFlIMThodHJ1ZVdmZkVlR2l5ZzQxbFpoVHhLTEFSbFMwMDYrU3pLTzF4VDVN?=
 =?utf-8?B?UlVJdFRvMmpsSjU4VGF1VUxPYkg0RGRSd2s5U2pHeEdvVFF1ZGJ0R0hoczZ5?=
 =?utf-8?B?bkxOWjhpVStLb2hkMVEwOFpjcTB6bFRNMGVEM1cwTkZRcGlrVjZoQWJsR1hi?=
 =?utf-8?B?citxelNHV1E2S1VoUVJJWWpwQ0dPSEluSkl3T3hNSkJGRG8yb2RNODU2R05k?=
 =?utf-8?B?b2t1NnZ5aXFaNjBqeTcyOVhWd0dGWUJkQ0FPK1VRQ1VTRFk1QnpWSm5ZMkN2?=
 =?utf-8?B?bW9MTlQrSXA0WFUrdythWXhnai9YUW40bGlXRXdlWXZKVi9QbXh5TElBSHlI?=
 =?utf-8?B?aTBCUmI4TTF5YmlwVXNXRkdKUnBjVGRjajNVUmQwUXZVUXlqdmQwbHZpT3Bt?=
 =?utf-8?B?RFFTOHJMdDZocDBFSkJPODV2dzUyWFF3Q1lCZjg4NUdRbys4THlmejNLVWs5?=
 =?utf-8?B?TVVidkhZaE5IZ3hUMXBaS05pd09xWkhSbXNDZGVjRzI1VG5CMjF0V0ovTmhJ?=
 =?utf-8?B?Vm83L0RWN3ZmK3k4RGVBNkwzWWdzc24vUnJzQ3NEWVdRZTRwQm4xclc1UGN1?=
 =?utf-8?B?bU50U2VSRHhXb0tQdWRWdWxzY2ZlNEREWnZ6SFF1bnVqZ2szOFJXOUtOUjVY?=
 =?utf-8?B?dnRPdHlXVGNvTlgrVU4xSFc5VmhLRFVIYjE1dVZ1cjN1TUJucExoYTNtaFdE?=
 =?utf-8?B?SUZwaEpWc3BESnF5Qzh4TU4zY1ZKYmxPZXEzTkZRYlVJQUpzTXlkRDVaV1ZL?=
 =?utf-8?B?L3F2ck9PaWx4bHJyaHJrdURjeldhUmJQNnJDZCtKK3hreVVhMGtiRklZOWV3?=
 =?utf-8?B?Z2ZSVnkvaC9FRDFQV1lpbTlzbk0rMzM4Qi9jZ0ZOOWtjYU5COVJqbnZUVGNF?=
 =?utf-8?B?UitINzZmNi8rMG1CL3FzaWpTTUpRdHZDOWd6REZFaDhYSXllQ0dmSjZ2Sktv?=
 =?utf-8?B?Z0orZm9iWGRMVmxXa0JFeTJYK2JRd3N5dW82SXpDOUxPU1kwNU1jMzNmRzNy?=
 =?utf-8?B?cUpyWmpzOEYzMS9xL2grWmhkL0puTnZ5dlRUQ2krb2EvZDhaSDN3ZVhzK3hn?=
 =?utf-8?B?dEs1NlRiV205bEhiUlRMRFpTSW52YnRiazdMZ2dvS2hkZ1h0TjlpdFZDTFAw?=
 =?utf-8?B?SjNiSjZ2eGptY1dzL0tkVktvdnV1ZmVNV1gvcmRhYnlJdUY5cXo4VUFnenV6?=
 =?utf-8?B?TjVIc3pBbENqc000cHVZRTFSeDRJaDdPVzJZdjI3dkxRYlJOeG04eEptZHJs?=
 =?utf-8?B?MFl3SHRJNEw4WVZRenFldVMwelJKQVFjQStoMXlxTURmU1lDbDJ2aE8zOElS?=
 =?utf-8?B?N3B3MDdTejRJbURHVFhkRk1FcW9hTDc1SjFSQ1pQdU8yY2U2a2FSakQ2bmZp?=
 =?utf-8?B?UFpOVFdsOEkzMXRqUnVnVGFHVGRwSEFOd1dpRlZHYUtadTJRc3VZU3JXSGg1?=
 =?utf-8?B?TlczQllUbnV5OXhIcUlZSG5WeVQ2M0JDMkR5eXM3TkhtZ1pYZ1ZDLzR4WE5W?=
 =?utf-8?B?a3I3NkNvL0ZTRHJCZmZuQzZWRDVZMUJsQis1UURiVTdBZjRsd2t0YnBkb0xW?=
 =?utf-8?B?SEIzT0tvdTYvSTZPU0pDblVHbjJSOUY3MTVoUENiSG92QlhrMHVqN0hZN2U4?=
 =?utf-8?Q?dYbpWngSo1HVI7xLbgdPKIo7CF536k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?azg5SnZjWXdvdW1mZW1hcUpvTG5kNkJaUzdBSWJyZnM3ZXZlcm5rRUZlT2hO?=
 =?utf-8?B?aW1BMzAvcjJQbmdMT09sS1k0QU9QU1dtRmpnK1RWcndaVk93YVhhTVp3MkJi?=
 =?utf-8?B?cDJXYkdMWTdMenlYclRsakZ1dGh4VzRjb0N1NlZ2UVZyd3c1aEkrTzErcUc4?=
 =?utf-8?B?bjk4cHovR2YwSlZhV2IwM1BuVkRCTE1KRzVIMDY0cndyRFI1bG00OXQ1NjNr?=
 =?utf-8?B?dGhqMnVaTFByek1ITmFuSXk3b1hBbDY3dVdBeTlzS240SWlhbS93WVQ2Sk9u?=
 =?utf-8?B?V0QzQkRrYS9NZjR4N0U0ZnoyQ3hSbnIzSHowRHZtKzNqenNyQUpxRHhKMGVT?=
 =?utf-8?B?VjdCRjFISDd1dEhUdWJxWVJ5b3VlejVRa21PYWZNVlQzaVBjZTUzcHdtT1Fs?=
 =?utf-8?B?b25WdTZQanU3YlNIMG0yb1d1L2lIUkZVQ0dreWZGVGFSMnlNaGpHSXFnVmFw?=
 =?utf-8?B?cXdiMHN2MlBLcy9pS3hyTmxaNU9Gd09Bc1JkM1NKZVBCdmZJWXN3VW9SR3lR?=
 =?utf-8?B?TEFFZWxvRzNteWw5a3VsY0ZMbFlqeVNFaXRPUERiNXdIb1d1L2YwcUxnS1hv?=
 =?utf-8?B?QW94R0MwVWFEK3FkRFNZODB1QThZOUsyNDA5a3cwYnFaeUFpN3dKKyt4bnFK?=
 =?utf-8?B?aUxBb0c1QUYxc1llTWh6YkxhNmVFdmpOTTRIQURkTkE5MlMwQ2FreWxGRGRx?=
 =?utf-8?B?RS9mU2JqeldnbWpKQUhzSVViUHB6VENLUHdYK1Z6ZzFiaDNnMXdGZW5nbTF2?=
 =?utf-8?B?QnlDeTl5UmhGTWlseE1FaHpocCtIZWNlSkVrZURqcnh0eFpyL1hnOHVabWd6?=
 =?utf-8?B?SWFkRzFwNXlDd25OTVQzN3k5VlluMXY2TWtmWkRFbUVxTGlyUVJWMlE4cDF0?=
 =?utf-8?B?T1RuSHhYaGlUazVYK2xMeENoY0xBb3BOZ1QrZ2xsUjFwWkNoVlAwajVyS3FX?=
 =?utf-8?B?T3JXWHIzYnlzaGphWHJ2bDlwTGFaT3FzNXlvcHlBamJZQWtSV2FXZUVxcVlO?=
 =?utf-8?B?VkZHcThwUEdMODVYSFRMY0ZmTmIrWXhXZjFndkxVU09xanM1V0g0VHlIZ24v?=
 =?utf-8?B?WmVabEVvU090bHk1dVdIbkhoa3JQMnZmVkVnUXN5YjUxcWZ4cnZPbHoxK0k1?=
 =?utf-8?B?YmtVc0FPcTdPUHBzQWJ1WUx1VUpybGpDSXJtSFVMRU5OWUxhcTVEWWlwL2No?=
 =?utf-8?B?RXZFZ0xYT0dnbGlwa0szVnZOQ1ZmUnNQdjdyVFFMYnNBQ0Rwak1pQVdtL0tM?=
 =?utf-8?B?a3g4dlhFN1VDb2prbG4vREpOQnBvdkxUVXNScm9SOTluWXRMNU1rVTl0WjRM?=
 =?utf-8?B?S2c3MlB3MTJhcDlxZWo0NURkeFlUMll2L0ZWbEkrczBpckVVREtrRktUaS96?=
 =?utf-8?B?ZkRNUWlzTWh1b1JKOW1OWlhVV29QYU5RckxvZjhJVHJ0VVNaRzdFaUliZGRM?=
 =?utf-8?B?NGQ5QzBTU0xCVjBrM0RoMTJ5TWhndnNNbTNsOVJaYW5JblZFbFFtSjZlVDJ6?=
 =?utf-8?B?U3M2OUEvM2NiRTdaVnZBZEJMWWQ2STRpUDZnNFByeDdCZmUrRmp6bzdiSTUz?=
 =?utf-8?B?SmdRVlc0YjdaaWtib1V0TGlDVWdYdTg5bkNFV05OWmxKekU3UDczbWgrT3Jn?=
 =?utf-8?B?Y2hxMzhxZ3F6V3d3VDd3K29rUXFhdkh3NEU4R3VSNVRUVVhuSkx3cTRzcWE2?=
 =?utf-8?B?UlNWeVJMeGRvUjhuTmFlOW1sczUrdURXd3VFbTBjMTVld1JLUWc5bTgxK2Vv?=
 =?utf-8?B?cEtpRklWWVc3d2w4N1NXMTVseHlPVVdkc0lkVHdOWFE5Y29uM3BOZG1wRzBS?=
 =?utf-8?B?UG1zT0wzN29WRStMajFpZ0JQTTJkTmovSEd1NUpyNzBMb1dGbU44a3ZNaWJo?=
 =?utf-8?B?VEF4RGZLOFBvb0h1YXNQNGxKTTJwYzJNeEZFT3BuU2xwYzEycHd5QlhkZHNK?=
 =?utf-8?B?b01IUHU5REJtSy9uSGJqbWhhNGp2ZDEvY2d4b2Fxd0FaQVM4Q3VNZlhyZmQw?=
 =?utf-8?B?VHNwdS9Wc1RaQS9qOGNsSWVKV0xndnRrUU9zWVZXL21uRkRDWEdpa1BUV3ln?=
 =?utf-8?B?ZHpUdm8yTHJRQUhqT3M4SzhiN1pYN2xuRS95OGYrWGVTeFI5emFCcHhFbXlh?=
 =?utf-8?B?SFdlRk5SajZJSHBJdkJKRWhOREc2SGx3N1AzbEZObks5bEdtcTYzbHZFTVE3?=
 =?utf-8?Q?ri8k/x+WGZ1Luv2OUJbm63c=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3d38cd-3581-4b3f-2843-08ddd3a25c1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 22:00:43.9809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DbhpKLBu3wKXJGHVmT+vP8fLSh42Be4yjA00ijOpbzsoFs1FaYdRIShfRtRmFpcUX2q8ucu/GN9Ss6f6EXfufQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5893
X-Proofpoint-GUID: 8Rj91VAtQ196ymG3RAnbHIBZVd0fr9hl
X-Proofpoint-ORIG-GUID: lXQVk5aSp9ndOG1F4jbr1dyZdHfGylE3
X-Authority-Analysis: v=2.4 cv=GNoIEvNK c=1 sm=1 tr=0 ts=68912d8f cx=c_pps
 a=vWDLAZYjiBeprAqdCJirAA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=MwJQj23DwJI64tAYnskA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDEzMyBTYWx0ZWRfX4XiYq1Zwbz+B
 ltKsHmpqoDsEnr/N3j5ahnwfQelRLhCWN72z9hZcFGBpojfb0bL7fkoUrttuyW1JOGzgZ14Lros
 aAIwGIqATW5t0UhE1aPWwmAtcyeOXz5vjWxyaym0aV6yLroKzr9tRNyaBXYLWbcxUo1yUFdR6m+
 t0R7RBLOn6/XTdlSe4DPHevjqgiUvXCBr4ETNIhzEx2pTVT+YzZ6BqdhWSUuQmC6dGYA/KGCABu
 nD1x3Cc6IZzQPykJKHjkZ6OzXBpgU1GFmkyLp1V4RgWVxPDsV4wu5dM48Xze8nn+Gd5F5u+48MS
 BDIijHznzLyG+2wVtSkPdcHSa8d0wAb/qInzq4ryPdQYnaWIKHncZmubeeF9yR9FdZj+c034Tjw
 8pzQOLKNjGmHaQz2Z9IE9sEDGaVjFQwIWKRwpJZWHUQ0r8MyqgqazNGBTnn7GFT7zVdL6K5m
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A0FB470FB7EA844A417ED2E93E4C393@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v4] hfs: update sanity check of the root record
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_09,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508040133

On Sat, 2025-08-02 at 06:52 +0900, Tetsuo Handa wrote:
> On 2025/08/02 3:26, Viacheslav Dubeyko wrote:
> > On Fri, 2025-08-01 at 06:12 +0900, Tetsuo Handa wrote:
> > > On 2025/08/01 3:03, Viacheslav Dubeyko wrote:
> > > > On Thu, 2025-07-31 at 07:02 +0900, Tetsuo Handa wrote:
> > > > > On 2025/07/31 4:24, Viacheslav Dubeyko wrote:
> > > > > > If we considering case HFS_CDR_DIR in hfs_read_inode(), then we=
 know that it
> > > > > > could be HFS_POR_CNID, HFS_ROOT_CNID, or >=3D HFS_FIRSTUSER_CNI=
D. Do you mean that
> > > > > > HFS_POR_CNID could be a problem in hfs_write_inode()?
> > > > >=20
> > > > > Yes. Passing one of 1, 5 or 15 instead of 2 from hfs_fill_super()=
 triggers BUG()
> > > > > in hfs_write_inode(). We *MUST* validate at hfs_fill_super(), or =
hfs_read_inode()
> > > > > shall have to also reject 1, 5 and 15 (and as a result only accep=
t 2).
> > > >=20
> > > > The fix should be in hfs_read_inode(). Currently, suggested solutio=
n hides the
> > > > issue but not fix the problem.
> > >=20
> > > Not fixing this problem might be hiding other issues, by hitting BUG(=
) before
> > > other issues shows up.
> > >=20
> >=20
> > I am not going to start a philosophical discussion. We simply need to f=
ix the
> > bug. The suggested patch doesn't fix the issue.
>=20
> What is your issue?
>=20
> My issue (what syzbot is reporting) is that the kernel crashes if the ino=
de number
> of the record retrieved as a result of hfs_cat_find_brec(HFS_ROOT_CNID) i=
s not
> HFS_ROOT_CNID. My suggested patch does fix my issue.
>=20
> > Please, don't use hardcoded value. I already shared the point that we m=
ust use
> > the declared constants.
> >=20
> > This function is incorrect and it cannot work for folders and files at =
the same
> > time.
>=20
> I already shared that I don't plan to try writing such function
> ( http://lkml.kernel.org/r/38d8f48e-47c3-4d67-9caa-498f3b47004f@I-love.SA=
KURA.ne.jp   ).
>=20
> Please show us your patch that solves your issue.

OK. It will be faster to write my own patch. It works for me.

Thanks,
Slava.

