Return-Path: <linux-fsdevel+bounces-67010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 039BBC33505
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 00:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3AB4261ED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 23:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D422609DC;
	Tue,  4 Nov 2025 23:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qeGE9JVH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E3934D3A7
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 23:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762297297; cv=fail; b=mrpU2DJi2KdnnMPFnRwvrnB3uFbm2N2Q5ExKoWIOfEmXZkjALjlWhvqELsqCJHHt3CZoCfiYSZyrfwZOjpI886z4lDfWK1vFa3rKW3upKdmKLKEY2oUi2tDSRH8vZkdkBjUAcctHdP8mwdkx05AHwxlZMTcQStGPCluaJ6l1zQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762297297; c=relaxed/simple;
	bh=YxeVKkBTxbNYcdsJwUroX64h9mwszIXidig736R0wT0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=gty4nyUffIZ8C3xs/t9X75EcmYDWzA/U5yET1N+DgHZKN0sO974Nk+w+wNaNYPG8+Dg0sXtMqAjWZa1f96Lh+oM9N4JSP8JAtfJeFQUlcsTvxwXqIBMiXTLHKF5Zx0xaDFqV4z1ci0RBngptGy7OLz8+uT6bIAw2WpqO3xBIdqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qeGE9JVH; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4Evkjo029911
	for <linux-fsdevel@vger.kernel.org>; Tue, 4 Nov 2025 23:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=7DfAO5nIFIl3icajiN404SLW3wUAJzxRTn8FHW0KQ3M=; b=qeGE9JVH
	GWVqi15gnDYTBlWhyWE6oARgEMu+P/EJ/+GjZh9auBD9dLoc1YGzRCUu0Zfxpdey
	emCZ0iGW+2X3aQK6Xl5/bdukQpTfYg8+WRmAr/PDA2lauQVrI0dp3Q2dQQ6r/Q/r
	GUqxCBTl2pLDVswCnN8qBEeBT1QxcbzqYVOy7kmxym5ybnmjm2dI3S9jjvtjzqjt
	lS/y2XqFJaGF6bEW4O8Tgq0rDPurG1TFV4NZPdB4w48x+qeHisho7JnZwTqGsXWc
	lhZup/lK0DJY4agY6fGF1j7vAzUcH5G9rjBKQTwClj3PProeCjfjEAPm6fPL3U3W
	Gle2rQrJgEqfww==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59vued8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 23:01:35 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A4N0Xj4019937
	for <linux-fsdevel@vger.kernel.org>; Tue, 4 Nov 2025 23:01:35 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012068.outbound.protection.outlook.com [52.101.53.68])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59vued8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 23:01:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBqt0cSRlygvdAv23VKjGn4ydJHsP15WLIuDWc6ZQERWPJjG0IIIM6ppjJdFXEM2kRj1mr5lJrI42IduhR34LdGo6n+/NrbJlsNY2pda+9nAXvYPEk6xp0SmDqZrzfym2j8C2FcmT0vDIH9FCF84+sdfSn5BLw2uxRMXHkwWEWzMgy50cT/hRSDZ4VWneYHwpYg+y0IO5ssFdfHnl1vfjif9P1a3m9zLTVj9P22FGT7EVbyZhj0ePpnftuwR1M0QM+OlIO+H+OC9kkIYKzLG++QwlGQgjZAWPwqg9nCNuapE5BjwFco709Tu1wbq+otvN91X0aHFBjtTP+oPAX8PrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZHECjk2O4UzgMNkv6KX+p8MyNSqpzRw8U6NKIhZOgU=;
 b=W6u/+eWTafH66g0NwXmEZJYxYk+sSNVrcPTvNcuobfT+hdfHDWOo5lvo9aNP989pzpXRRJ6utczCl0Y9/amFZTiOSKHJOji+fE8R4mF1j70f29kVxeZoWIC/zUJDLWH4U2zS7Ln8PTihPnTJ3c40CTohPiIWMHngq9fpMOb16wDQtKzQPmdzitcVk3wWLb7xyUyqY9kZlHg3zNo8aAWnQW5Oaw4u5pW1yYGQu0UNPTISLrNUQKltuBUI0N9cqchzuuIF3VDdzbwGX7WijC8LugRrVU33ZZVvfcpL2F9C9gHRFjdysZzqMIgWJNNPJGTnYMgNQYmubUe7rwJEHvyUtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CH3PR15MB5587.namprd15.prod.outlook.com (2603:10b6:610:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 23:01:32 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 23:01:31 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "contact@gvernon.com" <contact@gvernon.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: "linux-kernel-mentees@lists.linux.dev"
	<linux-kernel-mentees@lists.linux.dev>,
        "penguin-kernel@i-love.sakura.ne.jp"
	<penguin-kernel@i-love.sakura.ne.jp>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com"
	<syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] [PATCH v2 2/2] hfs: Update sanity check of the root
 record
Thread-Index: AQHcTS1TTOF64ePiQESHFmGvv/a5KLTjI5CA
Date: Tue, 4 Nov 2025 23:01:31 +0000
Message-ID: <ef0bd6a340e0e4332e809c322186e73d9e3fdec3.camel@ibm.com>
References: <d2b28f73-49c8-4e30-9913-01702da4dfe4@I-love.SAKURA.ne.jp>
	 <20251104014738.131872-4-contact@gvernon.com>
In-Reply-To: <20251104014738.131872-4-contact@gvernon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CH3PR15MB5587:EE_
x-ms-office365-filtering-correlation-id: dc2ae616-0ea5-472c-5940-08de1bf61861
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RFlXU0hDMStiZEhZMTZHUmgyTzAwZWM0cnhJOWJBd0tqM3pnNHFVUVlyU2VC?=
 =?utf-8?B?ckNHMSt1c2xCeWR4K2hQTmtzajZjZUQ5eEdyYUQrU3VYSUJDUno0SWJSQTJw?=
 =?utf-8?B?YnAreWtiWEhiM2JtL0lUbTJnSEJCcUNWZFRDVFcxSE1TVmxrNFNJTzY2Nkx3?=
 =?utf-8?B?Y3lXYVBJMnloWElkNVB5OFdJQTNXZTV1d2tXTFpuSHAwWGRPM1U3T1BnMHN5?=
 =?utf-8?B?TGNMeWlXVCt0T2FoL2FPU2ZrMzh6R2o1emNnRDVFdkNuMGlFUzhSaXEvdWhv?=
 =?utf-8?B?d2NQWFdjUVhlRXFjcDAvclpmL2E4TC84SnE1ZnZpbDY3cnFKYWREOERQUWZO?=
 =?utf-8?B?eEVaNjd3NCttaHhiM3NseTMrOGVMRW81WXc4b1J1cWdjN0R1ZFZIcFRRNVpG?=
 =?utf-8?B?NUQ2UkxmTUdSSkp0d3J6Q3F1c3hFN09PNWllMDZMTUZCU3AvbTMyYmgxN2hr?=
 =?utf-8?B?bHU4d25EZGp4Z2pJdEZ0aWVrWEplNENBQVMydG11Rkh3czFBOEZ4QjVHdU43?=
 =?utf-8?B?Ly9XOTNXcXhSVHo3QlBRdnE5NnZuR3VQUmZJWTBEcW9EK1VsMmgwQktLNCto?=
 =?utf-8?B?YkJlS3FOU3Z6WXlwcWthK292eFNaczNYait6VUo3cXF6ZlUwMkhuOFRjNVkw?=
 =?utf-8?B?ZmNNTmhHbGsvVTE5RGRmY05BYmJRQk5NWUszazhsQ0RPVTFCTXBvNy90WlRE?=
 =?utf-8?B?d0l6aHBtWXlpM29hdE1ndEMzRG1QWGIzTVFsbXBtWUFzSWEwbHZFaVFaUm5i?=
 =?utf-8?B?US9VSUpiUUh2UnFYL0tNWnI4cUhEMjQrSVlWQXhIWXR1V1ZyYkp3dXdmbFJu?=
 =?utf-8?B?dTJLZXZqNS9kWVFIT3VYVTRvak00am56eXdFeGttZ3pSWmk3Q0ZuL3U4OHVR?=
 =?utf-8?B?RmJtL0k0VEFZelBVZW1GWmE3d0VpYkNQOXVza2Y5eXhaczFRaEcwVXdyUFlk?=
 =?utf-8?B?UmUyREZwemFqSlgyeGErcVBhQ2N0NHg1SU40eU9VMGpLOHpCMFdYeEwvY2lS?=
 =?utf-8?B?VUZUK3RyR0RUcytsYU9DVWk3UWJyRE1DeFZRT2ZDeXl5bDJNd1RLWkxwL0VW?=
 =?utf-8?B?Q3k2OVRIcWt1dEtCdEltaTN6eC9nQ3BHc2xpaEFBeFlYTHlOU0NtaTFTWHRw?=
 =?utf-8?B?WTVxMnJNK1owaHQ3R0pwT20raE5uOUJ0azlNL3RwaUhTYVJab1ZnNFpaZ3Av?=
 =?utf-8?B?Yi9tNTVZSVMxdkVGQkVnWVFERGRZM1dJMVBiSUJhKzY1NXN6TGUwUmFEY1lh?=
 =?utf-8?B?OVM5V1ZsY2FkUzl5bGhsclpUMVRUSzRZNzJpajNyMXlLV3pjRGJraE1sVGFa?=
 =?utf-8?B?T2tzWGNDbTdSNVlCUWU0clhzUzJBcDdvOUJmZE5FMk9XVlBnUHdYdktNWVN6?=
 =?utf-8?B?ZW9XYUV6Vm9hZlcwNWQ0OVRQM3RBMTZkVXJuNjJ5QVJmWDNpNlZoZVBVS2Uv?=
 =?utf-8?B?TGNWZGlzekQ3TFFqKzFhaHp6RWdsWUczeHFiQndtWENwUVhPYklCRTdLWnBp?=
 =?utf-8?B?cnJDb1VUWjR4bFNEWWF5MmhLbW1xRldMZEpQTW9qakNodEZyMVhzamVic2pM?=
 =?utf-8?B?TWd0VHVucExUaWlBMEc1anp4WTk2QXdhU0NEZ3VBb1cvdkE4cFNSSk13L2pY?=
 =?utf-8?B?RW9VeERyd1dOMjIwSVM5b0Y4TXdSMHFxRFdIR1k0bDhYeW11RXo5SHdwNEhF?=
 =?utf-8?B?bFI5Z3B5ZGVrT0ZUdnlmc0RvbnEvR0pGbUl6dGk0OU83RTRUckU2QzhGcThI?=
 =?utf-8?B?Y1cvT1U3QStWUTRudkJBQ1d4VVgrem82NUNXMU1zZGhHRWJLWEVWamtGQU8y?=
 =?utf-8?B?K2hKcTgxV0o3NDNyLzdsNU9xcnFOQS9vM2xwejBsTDhiUXhyYjNoVmNHOCtR?=
 =?utf-8?B?TExPOVB0UHNWWGYvSjNXR2xRc3dPcGpjNUY0dEpJMURLZGJTTXU4dk52aFov?=
 =?utf-8?B?ZHRPL0Fjbi80dWl1aUZXSVhqam4zWDYxNkZGWUNZcjMvc0ljUE95TTdtU1pY?=
 =?utf-8?B?YXNYbzF1YVBnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T3VtTzZMazYwaHlobmMyRmRSUkFZZ2U5ZXRZR0o0cGJZV0xyWGVRLy9SV2RX?=
 =?utf-8?B?K1Y0bnJWaE9Wd1ZtWXdRZjFyZkUyLzkxRUxWZjFLRXV6V3lTRWVsazhtRFVS?=
 =?utf-8?B?RU1nb2NEbDc0cUhhZXJBSlczTTZ6LzVGbVBtSjZGbHVrU2NwaVJCQkpZK1k1?=
 =?utf-8?B?MHltajFOMjRJd2ZGWElHTCtOdUd3RjJmR3VRWDN4MUs1cnZQMlN0TFF3VFBs?=
 =?utf-8?B?N3YwbTM5T2p0WnRmaDAvK29XbG0yTEFvVGFEUlFQQVl1blk3RVVKVmRGS3Nv?=
 =?utf-8?B?a2dKY205eWZydGJ1UFE1Y1VXazQzeG9wY0p3RlludHdmZGFCdGcydDdhSFow?=
 =?utf-8?B?cXExYXdROVpCeDI1b3pyOENtbUpYSVQ2SjJUQ1FJNVlGeVR0SzhKS1BXeFZp?=
 =?utf-8?B?ZUthNHRDZk1oL0VtOXBSSkRlbUNqQklrWkdWMGc2N2JraXhETC9JMW40bEkw?=
 =?utf-8?B?TmhpcDdoTmsxMndMdktzQW9Pbmp5YXdHSjJOWldMamxhQXVjRXRORDIrdWxG?=
 =?utf-8?B?V0xWZUdvR2U0cTRRdjFlVG16ZWpzK1A2aklvaTk2by9BTE5kV1pKYVBqbTNW?=
 =?utf-8?B?Mjl4MFB5bEZTNEdmaTZ2RlNGQXIyeFdick9MZGs0R1J3dmRScHVWckhUL0xT?=
 =?utf-8?B?SDQwaHVpV2ZMZUJKNnNIbDRteEZoREZNVHNERFN6eXVld3Evalo2L1RERC9n?=
 =?utf-8?B?aTZ3TEFoeXhIRE4yN0UzT0VleGlVYkJDVlQ2dmVSN3BGSHVRek5acEFqTWY0?=
 =?utf-8?B?eXU1dVZMa1c5NVc2YlUwN3NjQjRxQXF0YXJWZENSKzhPRGVFZkswaXlZcTlR?=
 =?utf-8?B?WEpXdVk5S0JtZjVrSzJzTlNsaWdHSTJUT2ZvYTFWNnQvcGc0VG5tMHpBS1Zm?=
 =?utf-8?B?bGFWdkE5OXRwczJranQ3cDkrYjNEMXcyQ0MraU1heVZncGI1SHd3QytubjZm?=
 =?utf-8?B?MFVxNHBScE1Ldk8vbDNhWU82a0NScnF5ZEtoeXcrY3FpYytaT3kreW85cm1m?=
 =?utf-8?B?aUk5OWtUaGdQR3ZtbjF2SElTMmhKWmJpTEtXQVNnaGduT3Znc2c4b2ZlVkRQ?=
 =?utf-8?B?WjI1RWg4ZE42RjRaRHA4VC9yZXpDQXVTS1Q1UlU2amsrbDRrRUQ1RmdrbnF1?=
 =?utf-8?B?ME0wK2IwcHRqZk9jQ2IvZ0hBaXQ3aFBYQ0lBeFRVNy9nTEMwUGE1aUw0aFR1?=
 =?utf-8?B?TDIrUHR5MmQ3aTZoU0hkKzJJcmpMZFBqTGJRTm5vemhvS1VpRWVNU1hoaVli?=
 =?utf-8?B?SEc5cVBhR1l3RXZhYmJyVHdiamphdlNKZzlmWUZyVm05a21seEt4aVV6MFdn?=
 =?utf-8?B?SU9oNy90RUNnNklQaTRJbHZpb0NOTzNERktPS3JXWEsxUG9LbzczZjdGL2JS?=
 =?utf-8?B?SzBOTGpCR0dIRHIrSC9XWTBoYkZIZnJ3Nm03dXJ1Y0RPMTlQSExzYURTYUZJ?=
 =?utf-8?B?aHlVQzJuK3VSWnJDRm1VajBwUjYvV3ZZazRxVVBJQnIvc3ZhMFZWQnB5NzhT?=
 =?utf-8?B?ZTZKUk9BcGN4SThFNTRxY3poUXZrTmNtRGJYT3VZcHF0RVM2SzQyVzBuSTBr?=
 =?utf-8?B?MUtWY3c0cWU1M3dMVks2ZkR5MXZQdklycVd3THJnSGQyYk8rWmV0cEF5ekw0?=
 =?utf-8?B?T0JlVUFtdW40UGdnV1FBZWFjenMrMWRnbXFjNXkrSHNzR2M4c21UMlFxRVVv?=
 =?utf-8?B?N2JkellSZTExRzFnM0tRSWl1c2tXa3pBZGI4RFB3SFNzMHEwRE5MSGtSRGhl?=
 =?utf-8?B?TVJlMm5taDRtMnpVVm4vWjFBTWg1ZnphaGk3YWZGZTBsN0tEYWJGVU0vS2lq?=
 =?utf-8?B?YzRMaFZtdDFsZzNXN2lHS2E3MllUcUFxc0pJWGVLTWVGM0QxQnowc2FrYndJ?=
 =?utf-8?B?bVF3a0V0SFg4WWtya0RJRUs4T2t5NzhzOHBlVlpkL29td2dNOHR1Wk5lYUJS?=
 =?utf-8?B?TEFiZC85a0xTMjV6eFhOMjBnL0JqWWs1dDlxK3Y4cldvNEtocm9YYzB1QnR4?=
 =?utf-8?B?NkpNOSs0SGVvNCs1UFFNMGJXZDl0azlNUjlZY21uMzkySEZ6YWdESVVzVll3?=
 =?utf-8?B?bmlFVDFGTUhvUlJNdjRWZy9rL2xwTXJEMXFreHNoZ3JVZjIrTHg4bjNobjBI?=
 =?utf-8?B?OVlwSWF0YmZJRytJTHNoeUxrSzdzci9sQTQ1cW9oTDZaREtDTDIxWlE1S3Uz?=
 =?utf-8?Q?yRD2op6/VYft/1i6fFZDLc4=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2ae616-0ea5-472c-5940-08de1bf61861
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 23:01:31.7430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CqokohQBzqOeocWuyT1PSeg5sCazu790e6QWFQcw4rnVzH3AKE7kHBAyaMBwH9HYxt7eflc/NIw+JikXppJyLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB5587
X-Proofpoint-ORIG-GUID: GY-XhdC7zIVOvnzMXbb0GVS4VXlNxSgS
X-Proofpoint-GUID: GY-XhdC7zIVOvnzMXbb0GVS4VXlNxSgS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfXxO/tyoiBUxiP
 mT4P2KbxIRz+Icu/wd4499ukHOsfXZ9nh7j/6YrFImoJggJ51lnfuZ+J6TkhhA4DZ8IeZRL5bcc
 kspuRBsmooDYJNPvyl5lZHF4Rkq2JBWt7UKu+Gqmh+ThjuzNpzIs18l+Y1KOvx5rMsfnsYKs0Oq
 C8iQkeOmMpFiHjhNvuAh2BngQVt82K7WYBZCsWY37sRRMaMyASTbz7764HHLFFULUAOxkjlEExG
 OePg5l1epmqXTAIeCGwC/xKNDPi8h6+87WTTF3jySvko7JG9v6m4+gZQD+CO4PBUc7hVfh9YrM9
 V5TvEfnVU4eUbqpjhWhlahZaM0XGQqZl75sF2AfAcP2k5JezCdltuA084aq5RoCOFkXi4Kn4RAG
 fhwxLTwu+gppd7EVAhhrssFAcBnZLQ==
X-Authority-Analysis: v=2.4 cv=U6qfzOru c=1 sm=1 tr=0 ts=690a85ce cx=c_pps
 a=EOla4jo+ZS3aUDydQNalYw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=P-IC7800AAAA:8
 a=hSkVLCK3AAAA:8 a=3HEcARKfAAAA:8 a=G4EkMA1AbSQJV-PrkkIA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=d3PnA9EDa4IxuAV0gXij:22 a=cQPPKAXgyycSBL8etih5:22
 a=fDn2Ip2BYFVysN9zRZLy:22 a=poXaRoVlC6wW9_mwW8W4:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=SsAZrZ5W_gNWK9tOzrEV:22
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4CC1D2B7B0874439AF9631522F153D6@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [PATCH v2 2/2] hfs: Update sanity check of the root record
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.19.0-2510240000
 definitions=main-2511010021

On Tue, 2025-11-04 at 01:47 +0000, George Anthony Vernon wrote:
> syzbot is reporting that BUG() in hfs_write_inode() fires upon unmount
> operation when the inode number of the record retrieved as a result of
> hfs_cat_find_brec(HFS_ROOT_CNID) is not HFS_ROOT_CNID, for commit
> b905bafdea21 ("hfs: Sanity check the root record") checked the record
> size and the record type but did not check the inode number.
>=20
> Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D97e301b4b82ae803d21b =20
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: George Anthony Vernon <contact@gvernon.com>
> ---
>  fs/hfs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index 47f50fa555a4..a7dd20f2d743 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -358,7 +358,7 @@ static int hfs_fill_super(struct super_block *sb, str=
uct fs_context *fc)
>  			goto bail_hfs_find;
>  		}
>  		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, fd.entrylength);
> -		if (rec.type !=3D HFS_CDR_DIR)
> +		if (rec.type !=3D HFS_CDR_DIR || rec.dir.DirID !=3D cpu_to_be32(HFS_RO=
OT_CNID))

This check is completely unnecessary. Because, we have hfs_iget() then [1]:

	res =3D hfs_find_init(HFS_SB(sb)->cat_tree, &fd);
	if (res)
		goto bail_no_root;
	res =3D hfs_cat_find_brec(sb, HFS_ROOT_CNID, &fd);
	if (!res) {
		if (fd.entrylength !=3D sizeof(rec.dir)) {
			res =3D  -EIO;
			goto bail_hfs_find;
		}
		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, fd.entrylength);
		if (rec.type !=3D HFS_CDR_DIR)
			res =3D -EIO;
	}
	if (res)
		goto bail_hfs_find;
	res =3D -EINVAL;
	root_inode =3D hfs_iget(sb, &fd.search_key->cat, &rec);
	hfs_find_exit(&fd);
	if (!root_inode)
		goto bail_no_root;

The hfs_iget() calls iget5_locked() [2]:

struct inode *hfs_iget(struct super_block *sb, struct hfs_cat_key *key,
hfs_cat_rec *rec)
{
	struct hfs_iget_data data =3D { key, rec };
	struct inode *inode;
	u32 cnid;

	switch (rec->type) {
	case HFS_CDR_DIR:
		cnid =3D be32_to_cpu(rec->dir.DirID);
		break;
	case HFS_CDR_FIL:
		cnid =3D be32_to_cpu(rec->file.FlNum);
		break;
	default:
		return NULL;
	}
	inode =3D iget5_locked(sb, cnid, hfs_test_inode, hfs_read_inode, &data);
	if (inode && (inode->i_state & I_NEW))
		unlock_new_inode(inode);
	return inode;
}

And iget5_locked() calls hfs_read_inode(). And hfs_read_inode() will call
is_valid_cnid() after applying your patch. So, is_valid_cnid() in
hfs_read_inode() can completely manage the issue. This is why we don't need=
 in
this modification after your first patch.

But I think we need to check that root_inode is not bad inode afterwards:

	root_inode =3D hfs_iget(sb, &fd.search_key->cat, &rec);
	hfs_find_exit(&fd);
	if (!root_inode || is_bad_inode(root_inode))
		goto bail_no_root;

Thanks,
Slava.

>  			res =3D -EIO;
>  	}
>  	if (res)

[1] https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/hfs/super.c#L367
[2] https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/hfs/inode.c#L414


