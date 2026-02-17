Return-Path: <linux-fsdevel+bounces-77329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YqoVMnm9k2lx8AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 01:59:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDEB14855F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 01:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 754373019058
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 00:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA9B1B424F;
	Tue, 17 Feb 2026 00:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BLwdieR1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B0A3EBF2F
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 00:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771289972; cv=fail; b=Q2fsSrZtEMW0UzJqvd1w4b12mX8Vg8Lb0EV/J6SxQk+XYgGAtaFFw/dh9qKJrxjrSUGV1WZDjFEJ4m2rWtjfGjqDThFZ4VwUM5uUMP9TbmFph415nRCoN35IlKIBxbQ/3zku5argKfJ/Suc0WmYrBrFap+P6dolquSmwoijvMGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771289972; c=relaxed/simple;
	bh=dOgE3CdRpCAJSFAnmNQu53VC5LzVeK3jQ8cDJpFAHzI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=L/aNMutMxYKaVT+1i1/v7Epp3lA16SEAxbvjRB/QZntNRV9fuMcla3Hd1Te1yW0jzEJ+N863sorY2CjZr6VuonuBh9n7mglTDhiOuupVIfDc8/e7UJAACvBljLsEG5AYVpZ++rB6lV17nZLLmjGCv0FHB382mAzb4/lcDekSdDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BLwdieR1; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GBoAst3246617;
	Tue, 17 Feb 2026 00:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=dOgE3CdRpCAJSFAnmNQu53VC5LzVeK3jQ8cDJpFAHzI=; b=BLwdieR1
	5mG79RcvHEkFEzrtk3l7A3B1NasVzJZcfxSJB5rnsTKWQ8XFiPqMyvfbgM/Sdsr1
	x4votL545IgySi+XvhrwZNE3I6JB0QaOvhSp2WM7OH67R+RmCkeltyVdLoTDOpHk
	6VR/ZMv6FrGWdWVqkns5vP+U3UuEGbku7vajrrc9RdlV98Iy1BdvQa4do0h9fKCZ
	wI7M8Em/4t8pJM2shY5rKto0nhK8DJn+lLW/RA5+8x5lZ+OqWkauccO5V7dg9bW5
	D+5ck/HVkXpEifsMUivyNg/1foSWfBh6Filt0rMEMYHGu3A0wpIq+WGVd/TTbZnP
	CubiSsXgXK5I7A==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcqswew-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 00:59:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGbIp+rIC2Ci3w7TFaD+j89k+VYE7dMv9vA1/iF3m2/DReuTJ/QJ6+lG9c41KRcb9EuP5ZyuNkDqeW4NdNFWy+XTHSWPzhTD9DKkr+ksxkLStRmAyRQFEAvOb3CZn26pkMovFK3flhv2RPKHPsWZ9Hwogwqj7YEo2TJMmWHzXRQITtSay/4LtFFtWAj0G79ljrNsAhlxTREPw2WTb86D2LRGH51aSwYohMzLc1YtlTIHmaSQptonWIRKmFMXpatf1Dz19uobnjQb5PlwanGhS5pBZUcN8iXxMskqChRTxa+P0xjKe02EOUgm0nfsYIDecAoP0GFJWZ51hn+z8a/DPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOgE3CdRpCAJSFAnmNQu53VC5LzVeK3jQ8cDJpFAHzI=;
 b=x48chwNSQ4X193gZt3GpUHQAz5aNZYM8XfcFTHx9Z/tN1QnYQeblYvqlVCBIsSlkHnU/XloWPYBm5r8cqx5xo4Qd1dzWvZRSgC8dm5hlWUskb3Wtckfoiey+GIJ78wnTPPMlXIdpYHj1mQTVY0FI8HrvjWZN7m+B22XZaF9kEad7yp5K7I8D86Z0zP6gTfpNoUv90n1GZicG4aQcvTp60OMX5Vm+Dte8YC6JCnmFoLGXo/0pwPVM3JLqt1sTlJ45NjPoA/k3PWLel0szHXA1KkdnjZH/HFkuaeEusP2C0Djgq5qOhWSsz8l5xeGTh6KU/TQGqTWF5IVZxFxHJCkT6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DM4PR15MB5519.namprd15.prod.outlook.com (2603:10b6:8:111::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 00:59:21 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 00:59:21 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
	<penguin-kernel@I-love.SAKURA.ne.jp>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "jkoolstra@xs4all.nl" <jkoolstra@xs4all.nl>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] hfs: evaluate the upper 32bits for
 detecting overflow
Thread-Index: AQHcnCNRSqmOvktJcEm/ltcoFQArFLV/mx8AgADVPgCAAMw5AIAAjM4AgARPoQA=
Date: Tue, 17 Feb 2026 00:59:21 +0000
Message-ID: <40a8f3a228cf8f3580f633b9289cd371b553c3e4.camel@ibm.com>
References: <6e5fd94e-9073-4307-beb7-ee87f3f0665c@I-love.SAKURA.ne.jp>
	 <68811931931db09c0ea84f1be8e1bdc0fd453776.camel@ibm.com>
	 <4a026754-1c58-40a6-96f9-ecaafa67a2ae@I-love.SAKURA.ne.jp>
	 <62e01a3505bca9d1e8779f85e0223ec02c24a6de.camel@ibm.com>
	 <ef597d09-0fe0-44bc-93ff-b0223eb97ce8@I-love.SAKURA.ne.jp>
	 <37b976e33847b4e3370d423825aaa23bdc081606.camel@ibm.com>
	 <f8700c59-3763-4ea9-b5c2-f4510c2106ed@I-love.SAKURA.ne.jp>
In-Reply-To: <f8700c59-3763-4ea9-b5c2-f4510c2106ed@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DM4PR15MB5519:EE_
x-ms-office365-filtering-correlation-id: 3512a492-93cd-4ed1-f868-08de6dbfc905
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MWpNQnhISFp1REhXL0RVaTJIYTRya1V2WnFGazFTVVhRT2ZEc1hTWG5ZOTE2?=
 =?utf-8?B?TXAxRE96TlI0ZTdoMURKSEVyVUNGT2ZWWVFjdWY4cWtTTmNyL25oZ1orK0kv?=
 =?utf-8?B?aHhEb1VFSXdvOGhPMVYzOHNhZEEzZ3Y0cGxwOXFGVksyTXNVVGtFOFpCdXBo?=
 =?utf-8?B?OGR1eS81VUFnOEFUWVBhYmwxTDZKWFB4QW5ZYXRQbUFKSHJiaFV4WnFlZ0hP?=
 =?utf-8?B?SmlrUU9MMURUUEU2bVpUSjBNWFcxUHk4TjliT01qMG9QMkxyTFcxb0dKWGlK?=
 =?utf-8?B?a3hoWFFRNVNNdnpTVU80ZkVkaHdaanpZVStheVFTRU9EKzJjWEExRTZOT2tY?=
 =?utf-8?B?TzVxM3JqOU90V0svbU1tanV1OW11K2FWbTRBZmI3OVRBdjlFM1I5L2duY0ZK?=
 =?utf-8?B?eDI4anVBTm11YlhNR0xKZG05R1pmQm5KR1Y2VTRZSTZTUG5GSzV1Z1JHaGo5?=
 =?utf-8?B?MStKSjRBQkxHT0o2SU9VTlZCM3NrWm0vMWVtSjFneEFRbHFqa3BPMmFvVTQ1?=
 =?utf-8?B?R1BhUFhlNVA3cmJMMjdRU0wvVWc2dWhsN1BHeG45Ym5EeFFZU0JEajUvZlFP?=
 =?utf-8?B?ZzlxN2NSRERvWU94NTJGbFRxZDNzUzJsTHEzZTBwaGI1eFI3TTJNOER6MVh6?=
 =?utf-8?B?bXNRank1SkJENGJqN01xVEVWU05EMlhTQzk2OUpMYm96VXg2OFg3S3c3ay9U?=
 =?utf-8?B?N1VzaHBtemZ4YzMzSVlUbHo4QU1xNTFLUWxjK0FxY29vOStBTEJLV2k0eFFw?=
 =?utf-8?B?TmxHeWFCbkJWWjJySFZYSnIrYUY2cWpTdXJDcVRTN3lZN3Y4Wko0MTRBVmdG?=
 =?utf-8?B?RWVsRmdQRWdkbWZtMWhQZ3JNbUxSQThVZVIzVU5MTTNMdXdZNFd1c3UvZTNB?=
 =?utf-8?B?TFYwS2g1d1FUNnM1U01KbHFORkYyamR1VzJCV0ord0Exb2hoTTE1dnBGSlY2?=
 =?utf-8?B?Si9JOW5Ja2ZGbmh3cVV2S1l4bGpJNG8zallTUXFwb2RUUFBZK1FjSUJNd0hB?=
 =?utf-8?B?RVY1ZTE5MTJyc2c5S0c0V3Z3bElBS1FXeis1MG1WK3R2S0xVM3Y4TkV4M20x?=
 =?utf-8?B?MmVhZllhNUhLUktROSt3eVhSUU5VclJzWVlzREs4Y3ZVSEVvSnA0Yzg2cnFB?=
 =?utf-8?B?dUswRmZSTnFMUzV5TzB6NGZJNUM0V3I3NGkxdUhMdEVkMUQxaXB2dmk1ZE5z?=
 =?utf-8?B?Q0pWaXlKMTBaZ2lCb3B2Skl0MHFEN1ZJcldQWlBIK3dRYm1samlVYU9WOUNp?=
 =?utf-8?B?bzBQQjhuakRIYmYzWnZNMHdVZXhmbDFxYnpqTDYxdTF0U3dLbm9tSlFiakFK?=
 =?utf-8?B?akYvVlFuejRmRlBtZHNHSHpjUWhwRU10d3N3R3grV0pVei9FUnBwWVFNYlNt?=
 =?utf-8?B?TVpMYjZNTG9WVkZ2VFh0aGhmU2tpWURXVjdTQjZCYVhnRzJaZjBhcW1WQXFH?=
 =?utf-8?B?SmNhWno1OWNYbVVKYzdVVzhudmF0aDVNWE5EVytKUExaMWg4dnFwRE1VZm9x?=
 =?utf-8?B?MUZuOTViMVkvM0cwKzMwd1d0NVBqWGk3OHdJZ3pkQzlvTklwek9GZzFWNFJi?=
 =?utf-8?B?eGJaYVFXMlhwWWo1bWVRQ0tzcjlNNllmMWNsd3NYaDVVM3RMNnZXT1E5aXdO?=
 =?utf-8?B?SDFmV1FkWGpUVXZDZkxlUGNXT0VZRDJZOHRwWWZPaGlwTVMrbmo1WHlJQTBZ?=
 =?utf-8?B?WUtZdnNBUmRCWVhTV2MvSDFKSk1HWmwxUWM0TUZBN1J5RHVFcHB4a3RNT1pD?=
 =?utf-8?B?cTc5MXFuUG1saUx6T0FXSktkdHFzRHVxK2R2MUNpdzRDS0pNaURnWlNIbitE?=
 =?utf-8?B?MWdaQTM0QkhtekxrSjM1bkNIczVyWUVSc2FadGxYb1U5T1JhSWhQMjhaRUpa?=
 =?utf-8?B?Z0F3dnJ2UzVPOGxPMDJGYnFReHVaejNMTVJSNkp3eXBqNFRQUGk5UEw3UnJV?=
 =?utf-8?B?ejMrZjdlam0wc0ZrTndyUXoxN0k4dXhSVWpOaE5xeUdoUlpyMnJlUFcxV2F4?=
 =?utf-8?B?SWg4aVAwdVZCSW9vZnlhK09aVGdaYnJoblBIWDlkbVhVVXdRTTgrQnJwdU1R?=
 =?utf-8?B?STRWWDZycmFmaWlYbkJCdURCZ0VQMjMrNmhUWDMvTE1xby92dFZJcEgyR2w4?=
 =?utf-8?B?bVQzNC9TTWRwVlpYTWNhdks3d2ZLRElVaUFTL3RxTUIwT3MxYTFZZmg0YS9z?=
 =?utf-8?Q?tMhRH+xzfevw+nZIURPrQk0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eTVRcHVGM2srMiswam02a2JIdzgxRFNkYnZOUjVBcXNNMExCRmxCUWFkOXVZ?=
 =?utf-8?B?QW1GdHRlS1ZrcFVYTmxDRGswVWVCbVdobVR4VHZaY09tMGNYN0htR2E0QmNE?=
 =?utf-8?B?K1FBK2thbnRzOHZTRWRRL1Y1YmJaSElVRDRMZEhMays4eUtVRXJ4NS9xQmNs?=
 =?utf-8?B?cGJuRHBZeWwyZDRncGJBdGZDaThRS3pCcUJvbnVWcVlYdngxdkoyWVBaVDRS?=
 =?utf-8?B?NkJ3eDF2MEVJNUhwWnVzazY0ODJzVjltQzNKdW9UdXZkNjh1Y3IwSkhuOWNi?=
 =?utf-8?B?alFFMy9qM1Blei94d3JUbGhYTE1oZER1VlFCemtjNWFadGhWcEsxOUpxdExF?=
 =?utf-8?B?KzUxZVZ6Zk8xMU9kcDd2ZFZPbEhjYXpzb1FFVzVyaTNnblgvWStyeXRlRGJD?=
 =?utf-8?B?aDA0N2Q5MVE4SXo4MzV3eFlTbExTdEhjVE0vN0RvWE5nZmVraElxYUk1Qldq?=
 =?utf-8?B?K2YrY21MWXZYZVhKbHNuMGswUmhnWTRVd2xuRktyQmJud3BHcWgrNGdpRWt1?=
 =?utf-8?B?bVNZMjBweGJOb0VNWE1MWU9BdFYwVWhQbytBVlBhVHV4L1hpOXc5NWVhTTdD?=
 =?utf-8?B?R1QwMDZhNU4wUnZxZlFyczNSMWdSZlZYWmJQa1ozODhCS3VzQnF4bnlHNTN6?=
 =?utf-8?B?S1o2aUxqR3U0TWgreUw4amlYaWJZRGpPMGFDV1krT041dWxqT0RMR1RWVkNv?=
 =?utf-8?B?R1d4ODhSZW1HQXRpT0FTNUZtbDFSb1RSSGF5Sy9DNHNKOXZUcm05Q3IzanVs?=
 =?utf-8?B?ZzZ1RTRHNUJteVMwUUJyMHc5WFJJbHlwSTVyclNLajROU1laNHJTN1hEcU1Z?=
 =?utf-8?B?eTU5UnF0aXFpUklIRFJRK0ltOXJsODd6RGRMbnN1NVRuT3A0TzQ0U1htT2Jp?=
 =?utf-8?B?OGtJWUFMOU9wa2Mrd3h3U2pCZ3VzL21rTHdIN0xnMThSUldsT0lGSFFXN29u?=
 =?utf-8?B?dmkxanpCUlFnVVk3TnBNcXBiNVhSejVFcWwybk1lMW4rMElUVmtrWW95bDk5?=
 =?utf-8?B?ZTlvT3d2bklydDZ6ZUVreDJCelR6V0dMZjhHald4ck4vdDd0TXhydk5DNUZr?=
 =?utf-8?B?Sm1GR3cyUTRaN1hHQk43eEZlMXpSN3REaERZSmNuY3RwNGRqRlJWWE9YOFdy?=
 =?utf-8?B?U0NWS1lCM0VPTGI3V25JSXlLM1NqcFlsMDlOcVVKWG5tRXlOUDdhK01DRXNj?=
 =?utf-8?B?WHZ6cUwvM2g2OW1HVGt0dmtBZGlUbXpxNEcxOVd5c2VnNUppbElzNzUrZkVj?=
 =?utf-8?B?UWxNbnhKRDI0dGQrQkJiZHJlSHY0YWg3d3U0bE5aNENGaFVXKzVqNjhjL3Iz?=
 =?utf-8?B?TmtacHhwYVdIQnU5ZEN6dTQrcHNPZUJqdFQyMmRhbE0ydFJTeDRNVE5yYUxm?=
 =?utf-8?B?MldodlNRaHI3Vmo2UEJuQ3JOeFRjUTJZUjZ6VEdXOHh0QjhLM0hMdFMwcmwv?=
 =?utf-8?B?MFdpblRZYnVDamRNWTlOMHVDRndpVEhTek13bEZUQ3pLS0I0ZmtJS0JvM1JF?=
 =?utf-8?B?NlN4aktpeEdCWlNzTDZWam9oMlRQMHlEakNtQ2QxVEZ0WWNFblpEWjdYSFRD?=
 =?utf-8?B?QkRlVDFQdEJIMkg5M0Z4VVdkRVlFaHJiSVJCVGYzRkhyQzdkWEFnVEJpSFZh?=
 =?utf-8?B?eVowdlpwYXVTN3RqNXNKUE5vdk5jTVBYZDhleDBoaktxZnlHUi9oMnVTc1VQ?=
 =?utf-8?B?R0Q0dURCTHVWdk02NC9WVTlyVTBRWG1XZlh3TUdwOHd1L2NlRHJmUmdsUWR5?=
 =?utf-8?B?YlVzZG5SK0R5WTgyQW9nRU1KSk4wME9LSGF0VFAveGRrWlY0RHFIcnlkNDZ3?=
 =?utf-8?B?MXJJYVUwbHY4SCsxMzZUdWR4ZlYxSzFQbmNiMElmSDFGTjVMbVl3NEliQ2ZP?=
 =?utf-8?B?S1d1aTJ4M3grcDMrNlBqcU5Ya0hYcHRiRDMwK3p1LzJiUlF4NUpOMkhvemEy?=
 =?utf-8?B?Zm1mc0ZUdW80WWNTQ25GWnJuUGEvVUZCenQ0ZmNiMUVjTkZET3lBSkE5a2R6?=
 =?utf-8?B?ZTdKWXo3d0JMNWlGUkdwR0lmV0FJMjR5dlM3ZkR2bENWem5PSFdFNTcwZXFR?=
 =?utf-8?B?WWFIaXJVVUVhdHBaL3NhYkxnU3VyYlU1ZStLelhDNVpyUDA5NFVwN2k2KzMy?=
 =?utf-8?B?d0llenNmSkRraXFOUWdRY1JJWTMrdUg3WE9uVHVuSW9veTBlZy9LbHQreWZm?=
 =?utf-8?B?MTVTTjdPV09NVlZwaFdBN1F3ZzdDWFljbHdlZlZQZXkrRk9PZ1l0M2JwUGw3?=
 =?utf-8?B?Mkk2RWkwSVNjTWJuVlYrZXlSVEhmTmU3N2wwYmtKUy9lcTFCT2VFOFdaZTJR?=
 =?utf-8?B?d29ydU9aSVA5b1lrZ1lqdHpYbXJrTWVHblNJYVRFMXBrVndMZkZjVlovdGdx?=
 =?utf-8?Q?wtvuRFTUrs/hTjY1h2iHFjSdK9tmy2u678rNq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EECA15AAF1CCB49A865BB5A653D1EAA@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3512a492-93cd-4ed1-f868-08de6dbfc905
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2026 00:59:21.1832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LAsek8aipMN/KFZ/gqoX8eLPP9ftZ6fDeNXOANJLvYynslj9KyYFz0YlWlK6ZyQG2E+nUqMP7YIyaPPVEXcnqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5519
X-Proofpoint-GUID: QNnessNyeWolGQMuihddsojFdpGPQo3c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDAwMyBTYWx0ZWRfX4fVCXecBHH1D
 Zb8L1Y5yVlgZHJIB3g9ktraEjnJ6yoq7MZfrfylgHiF9acXMYPndFVidYjAg874iorIYuYEhpQl
 rujzXF+Twi7L1dfCO52xW8Dzr12cm4LyiATZjqDh7R62gmC11oYSGyHWrwOjj0KQTVJiH6gH8E4
 2eG96qc1K6YA1SopRewBkgF2gtI+29sZGDHDeSotaNbAgeGszRd/NmOq3cgepAEzhgLtOVXTn8h
 anCKb9urcw4kLWvb7Bcr9J0e356Yh5gCkNXYSrwsCwUwXu4xJe8Kpd++/K/2kMCTrk6jtozEBBx
 m19CQPoeo2v7gm2CaLkxbOSiRP4gA5DKmZgmjU0WRhLQe/qeFKi3Xnv/6sbXjiTqQJBtJk5zZvU
 puOF3mkH5fui0NMLch6A3n1mYthBVW3jT8CSXbv66JS27u0q0UPIKcIRkPbfpAk7XQqYONrq/gP
 SKzVNSoYoNBGPfxUdnA==
X-Authority-Analysis: v=2.4 cv=UPXQ3Sfy c=1 sm=1 tr=0 ts=6993bd6b cx=c_pps
 a=FXm+OvNBiSWvAu5LmLLQ3Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=Kk4oP9S42mGQ84ZI:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=8LIBuSBH7mF0M0GmadMA:9
 a=QEXdDO2ut3YA:10 a=UoflnQVOCLoru1gFIHN8:22
X-Proofpoint-ORIG-GUID: QNnessNyeWolGQMuihddsojFdpGPQo3c
Subject: RE: [PATCH] hfs: evaluate the upper 32bits for detecting overflow
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170003
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77329-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[physik.fu-berlin.de,vivo.com,I-love.SAKURA.ne.jp,dubeyko.com,xs4all.nl];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1FDEB14855F
X-Rspamd-Action: no action

T24gU2F0LCAyMDI2LTAyLTE0IGF0IDE2OjA5ICswOTAwLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IE9uIDIwMjYvMDIvMTQgNzo0NSwgVmlhY2hlc2xhdiBEdWJleWtvIHdyb3RlOg0KPiA+IHR5cGVk
ZWYgc3RydWN0IHsNCj4gPiAJaW50IGNvdW50ZXI7DQo+ID4gfSBhdG9taWNfdDsNCj4gPiANCj4g
PiBVSU5UX01BWCBpcyA0LDI5NCw5NjcsMjk1IChvciAweGZmZmZmZmZmIGluIGhleGFkZWNpbWFs
KS4NCj4gPiBJTlRfTUFYOiAzMi1iaXQgU2lnbmVkIEludGVnZXI6IFJhbmdlcyBmcm9tIC0yLDE0
Nyw0ODMsNjQ4IHRvICsyLDE0Nyw0ODMsNjQ3Lg0KPiA+IA0KPiA+IFNvLCB5b3UgY2Fubm90IHJl
cHJlc2VudCBfX2JlMzIgaW4gc2lnbmVkIGludGVnZXIuDQo+IA0KPiBJIGNhbid0IGNhdGNoIHdo
YXQgeW91IGFyZSB0YWxraW5nIGFib3V0Lg0KPiANCj4gVGhlcmUgaXMgbm8gZGlmZmVyZW5jZSBh
bW9uZyBlLmcuIHMzMiwgdTMyLCBpbnQsIHVuc2lnbmVkIGludCwgX19sZTMyLCBfX2JlMzINCj4g
aW4gdGhhdCB0aGVzZSB0eXBlcyBjYW4gcmVwcmVzZW50IDQyOTQ5NjcyOTYgaW50ZWdlciB2YWx1
ZXMuIFRoZSBkaWZmZXJlbmNlDQo+IGFtb25nIHRoZXNlIHR5cGVzIGlzIGhvdyB0aGUgcGF0dGVy
biByZXByZXNlbnRlZCB1c2luZyAzMiBiaXRzIGlzIGludGVycHJldGVkLg0KPiBUaGUgLTEgaW4g
aW50IG9yIHMzMiBpcyB0aGUgc2FtZSB3aXRoIDQyOTQ5NjcyOTUgaW4gdW5zaWduZWQgaW50IG9y
IHUzMi4NCj4gDQo+IC0tLS0tLS0tLS0NCj4gI2luY2x1ZGUgPHN0ZGlvLmg+DQo+IA0KPiBpbnQg
bWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQ0KPiB7DQo+ICAgICAgICAgaW50IGkgPSAtMTsN
Cj4gICAgICAgICBwcmludGYoIiVkXG4iLCAoaW50KSBpKTsgLy8gcHJpbnRzIC0xDQo+ICAgICAg
ICAgcHJpbnRmKCIldVxuIiwgKHVuc2lnbmVkIGludCkgaSk7IC8vIHByaW50cyA0Mjk0OTY3Mjk1
DQo+ICAgICAgICAgcmV0dXJuIDA7DQo+IH0NCj4gLS0tLS0tLS0tLQ0KPiANCj4gV2UgY2FuIHJl
cHJlc2VudCBfX2JlMzIgdXNpbmcgc2lnbmVkIDMyYml0cyBpbnRlZ2VyIHdoZW4gY291bnRpbmcg
bnVtYmVyIG9mDQo+IGZpbGVzL2RpcmVjdG9yaWVzICh3aGljaCBieSBkZWZpbml0aW9uIGNhbm5v
dCB0YWtlIGEgbmVnYXRpdmUgdmFsdWUpLCBmb3INCj4gd2UgY2FuIGludGVycHJldCBbLTIxNDc0
ODM2NDgsLTFdIHJhbmdlIGFzIFsyMTQ3NDgzNjQ4LDQyOTQ5NjcyOTVdIHJhbmdlDQo+IGJlY2F1
c2Ugd2UgZG9uJ3QgbmVlZCB0byBoYW5kbGUgWy0yMTQ3NDgzNjQ4LC0xXSByYW5nZS4NCg0KSWYg
eW91IHN1Z2dlc3QgdG8gaW5jcmVtZW50IHRoZSBhdG9taWNfdCB1bnRpbCBVMzJfTUFYIGFuZCBz
b21laG93IGtlZXAgaW4gdGhlDQptaW5kIHRoYXQgd2UgbmVlZCB0byB0cmVhdCBuZWdhdGl2ZSB2
YWx1ZSBhcyBwb3NpdGl2ZSwgdGhlbiBpdCdzIGNvbmZ1c2luZyBhbmQNCm5vYm9keSB3aWxsIGZv
bGxvdyB0byB0aGlzIHNvbHV0aW9uLiBJdCB3aWxsIGludHJvZHVjZSB0aGUgYnVncyBlYXNpbHku
IFVzaW5nDQphdG9taWM2NF90IGlzIGNsZWFyIHNvbHV0aW9uLCB3ZSBkb24ndCBuZWVkIHRvIHVz
ZSBhbnkgdHJpY2tzIGFuZCBldmVyeWJvZHkgY2FuDQpmb2xsb3cgdG8gc3VjaCB0ZWNobmlxdWUu
DQoNClRoYW5rcywNClNsYXZhLg0K

