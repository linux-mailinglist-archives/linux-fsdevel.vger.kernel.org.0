Return-Path: <linux-fsdevel+bounces-62616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE34B9B24A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 19:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF941B26DF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 17:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEF0315D4E;
	Wed, 24 Sep 2025 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QhWrYvp3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABE03148C7
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758736568; cv=fail; b=DVbTiUsd1ha6nvYURMVhKKWewExDBuNeOGB9vU+RXWgCdlsksiZT4tByoPs8ftpoPYLcIJyo1DkroM57LtsBPsiRR0ylhNRLbeki1HwNfZnf14esK4E+oM1RI1Yzo6YZiWMhyVvGDKF7QK+VuYC9Du3ZAty4KpSm4wVSS/LyWds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758736568; c=relaxed/simple;
	bh=wNDHxBA/FJUcWeO/AkoGBVj0zpfr32MEZJGZmS+lDFY=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=NHgzJhKlWsT2vwSDBYBcDZI4upjJ4Hz4fDU7ONZ59YVvja1lKFdgaQEERmhf/LRAAfJE7J6K9T4owYIzFyYfMzq2Gu4wzJFXIUGlr+jLozCy9XWdH4gL1MPix7M2ugJ/YaLH2wrb3WgzGZsw/ordhO/D6Ui+rV+2rsFisxVlV7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QhWrYvp3; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OBedEe003988;
	Wed, 24 Sep 2025 17:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=wNDHxBA/FJUcWeO/AkoGBVj0zpfr32MEZJGZmS+lDFY=; b=QhWrYvp3
	ckhpfghP0rmaF1/KD1woFSpHPnNL1V0Qh0mghMuRhXp/mjF26RbE9uIlFqCA+flR
	j5yXWJ1mfffbo1pTJqBUUaqKhrMK+vvKxdrdrO3vbbB44CRr70mzUPfxi4dYUS5a
	+KTEA+G1WmLUjvNYp+ztBabhliMEMH5t6Rvmw2IknED7LIoH41umDsCMbDv4Vrg4
	XK7UOB2dvMeG6OGLCW9k5ihettEAa+JrkF80oqCr2VgVE8jtS5z1otuIJYmrhMje
	ecE1nIxv8PgF0l3DEnTRQsI/lLI04tqODYGGWzmNaxn6k0oP66nzdf6XO+zwdh8e
	3MkXbko3nbtxMQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499kwyrbka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 17:55:53 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58OHqgoT023707;
	Wed, 24 Sep 2025 17:55:53 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499kwyrbk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 17:55:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2B0hEfU5qaOqLR6kWi8E8rIDJ29OkoYdc5J2xAQ7mWt6NPdGXtmxgH4Fj03PX2qhJLCGxO3AQP9Vn/hX/acfCg6YqOyC/JYPlxLBRfXsJ86m6vVcYDoCL+mpUr8Obi0tFkeqgJ63HDmeCM2Xo7+jMYw9XWrj4taEhVCNh6/VfnSg7Ehkjw7kA0p8RqC4wqS7a35q3X+lMseZ5tfQTvQaqyYHP9A9/QJaWnfYn8AemQTf6BdZgIjXxZqN3Gf2TytPGtKVtY4CrKopRu4KF7GLDatw5Ol8ThALfW0fUVl2AZc9YPmJLPWND8qUOOaZf1dAunOdJvJxJGV2h0VNUSynQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNDHxBA/FJUcWeO/AkoGBVj0zpfr32MEZJGZmS+lDFY=;
 b=X4h+AEgQFv/oKJVbQzGYIrULTBIzNWe70G9EiTwZ/OW/i/kk7Wysnj6D4v8a6B2WcwlqAJcdAs8EwmukGfJ0C7NQzCWmWyWMkS3lQV5wGbSmU07nSRzP0ioMsbtn7POWk9fRdSyz8iBStclE9vF3WJ3D9idxCBE1ufwT/Veh2NakiewJ7trjgqGgII6ZJsqcS2+8WGcsKuJtxDGmmimPnjX2+9mRHESe4UozKdhw6KPXQCps7OWDulVx8L3a1H3U+b0Vbkkx3BsJvo5hwLjgtwM+l2AVPL1q3vvISo5CiWHKZoVsxspAQ1zl+vJEjZb5sHH/1EVuOwvuTN9XSHl6FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW4PR15MB4564.namprd15.prod.outlook.com (2603:10b6:303:109::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 17:55:50 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9137.017; Wed, 24 Sep 2025
 17:55:50 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "simon.buttgereit@tu-ilmenau.de" <simon.buttgereit@tu-ilmenau.de>
CC: "idryomov@gmail.com" <idryomov@gmail.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        Pavan Rallabhandi
	<Pavan.Rallabhandi@ibm.com>,
        Xiubo Li <xiubli@redhat.com>
Thread-Topic: [EXTERNAL] Re:  [PATCH] ceph: Fix log output race condition in
 osd client
Thread-Index: AQHcLVs5O/UQoSPwx0KHpXyjO+2BJLSinjWA
Date: Wed, 24 Sep 2025 17:55:50 +0000
Message-ID: <14ae907a6fb3c59db957941b41691deb3a0ee7f1.camel@ibm.com>
References: <20250923110809.3610872-1-simon.buttgereit@tu-ilmenau.de>
		 <0444d05562345bba4509fb017520f05e95a3e1b3.camel@ibm.com>
	 <d86114929063d12dce4110c730df2afd2c17a551.camel@tu-ilmenau.de>
In-Reply-To: <d86114929063d12dce4110c730df2afd2c17a551.camel@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW4PR15MB4564:EE_
x-ms-office365-filtering-correlation-id: df73299f-d728-42aa-99bf-08ddfb939925
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eWV5ODVPN2VMNHVUM1pjSDNCUllJNTY1anNjZDdXWHZyUkp1Y3hOcFRzOENM?=
 =?utf-8?B?MFRqOEh0YmUwbzFsR1FyZDVadWN4QWtvQjV1MVlaRVdIdkhESXZUTFpZa0xM?=
 =?utf-8?B?dEhoNlhzTk15OEIzWWJkSldteHk2d3cyZ3RyaGpiUExlUTY1aDRLMXVWQ2dx?=
 =?utf-8?B?djdYc0x4cUJCNXhxbWU2eEpqbDJueTNUZ2FMbHhhUDV6SFBsOUlmckhXUlor?=
 =?utf-8?B?elEwRmZTNGo2cmJUQXlLRkVNTFN5SlJteFJUWG01dTE0K25yS1lwbjAyT1BT?=
 =?utf-8?B?Smtzc1hVc1dxUFBEaGVRS2tSVWxpMHdUSmdWZEw4cEVscXZqU1NzdTBZaTZv?=
 =?utf-8?B?RllFZ3R4RThCenkrMm5YYnZ4dlYzak13RVlMNVhSc2p0bFBVcjY2dnJ4dExx?=
 =?utf-8?B?NThVU2Jtd2FROUNmMUVXL3NxZytqK0E3RkdGaDNxcytyMEFiOTNCQVZxYWUy?=
 =?utf-8?B?b09raU1KQXdGOEgyT1p6blVaN282V0tUR1ZiWEQ5Nm9CNkQ0T3ZOVE8wTXUy?=
 =?utf-8?B?Kzl6aFJsYkVadFV6SitFTXBuWEVxL0h4bHdlV1FHeHhWaDI2RStld2JJdTgz?=
 =?utf-8?B?YzZSNUgyWXp3L1BlL2NjQ0pSZ3ZTKzZ1bFg4VWxzTGR5em85MC94ME9ySEFR?=
 =?utf-8?B?WWFrOVFPZFBoQ2grckFRRnZRcTVCR29lQmdWRlRXb1AzNEpvSEkwN3M3Wlc2?=
 =?utf-8?B?dzFUb2NDVVQ3VlhKT0YwMXFBeUU0TEIyaElBdmlHQ29SNFd2aEpFT3pZNVUv?=
 =?utf-8?B?cWxWd0NXaEI5OEZCQlFVQS8zUzY2N1J5dmVZbmU0aHpNS2VMSFBwczU0SmRi?=
 =?utf-8?B?ZTNVeXFMMmw4VmxJNVY1em94TENGTk9OUEc1bTAwcWsvYWJoZXBlSStxOXBk?=
 =?utf-8?B?QWI2cFhrakhkbFRDd3ErbHB3NWhvWVp2ZWtOQk83cGNHeThSa2RZeWhRZGN3?=
 =?utf-8?B?aUY5Qlo4RktpWUpwU0lHQU9SUjA0eE9lZ3ZKc0xBczZ5YitJYmxWbU9vMGFI?=
 =?utf-8?B?OGNDM2JtT1NWZ0d1RHlwNm81Z0NnWWY0andKVEg4K2lqYkloS0d5TmdSTTVO?=
 =?utf-8?B?dTlvUGlRNFpQZmlKV1BWM2p6ZkVScnlhdGRFSEp0cWxHRlZsMEliVWQ2OWFy?=
 =?utf-8?B?K0wxZ3U4aXFSSXROUmEzNG1PVGJlSUdmSHFOQmJhSTdmK2d6NExEb3RER1I1?=
 =?utf-8?B?R0JhelhnNVB3QkFDRmlDc0ErcWFRVTV4cnJDenNVMTJhcGwyUDZSK0hRYWMw?=
 =?utf-8?B?anFwbVptOGRSNmdqejNDSjhqeTRxVGtSUzdTSFVvMFFSRW5LcTYzaXlrRFR1?=
 =?utf-8?B?MjlFckdSZysvTHd3NEVPYVlKa1lBa2dUU3dubnl5d2J3Zk05Mm9NR3I5RHBT?=
 =?utf-8?B?S2dsMEhXRjVNWXFlVEtWUmVHeUF4UWpIYitKS2k1MytuN2h0S04vekFwejN2?=
 =?utf-8?B?TTNhR2hQZytzcmxxUmdWTWNNcVZPMnAzcUVXdHVwYkFONkR2eUVhL3grUkxP?=
 =?utf-8?B?aTlvMFpsdXNjY1Myc1ZKWjJEN1QrQytqQjlsVnVXR0lkbTk2bkpUVW9oRG1N?=
 =?utf-8?B?YmVFQ1l0L1hOUkhOUmlKZEtYcUh6M2hISXljQndHdGlURVpRR3lrdzdrVGdi?=
 =?utf-8?B?TUNnSlVQd1l4V1h5dzZ4YjEvdmlvS1hPcUlKdHZJS0pac3l2YTBHSllYbnpa?=
 =?utf-8?B?amN5NnFXMUlKMWlJVC9uZGxVbGI3U1FndUJxbDZaQzhENXBtUmFJUG1vZ1JE?=
 =?utf-8?B?TzFIc1grWmJNUUhRdDZpVlZZR1BKU3RBOWVIRTZTTm9qcXh3YjhwODZLenBp?=
 =?utf-8?B?ckx4N2p3aExBUU9SYytTRmdQcEg0SDF5Q3VLVnIrQm1ob09pRFl2OEZScWoz?=
 =?utf-8?B?ZmhNSys1bVBXTEdaWnhaanBFQUgzYTgzQ3FkL2pVZkszSUFOWitpODFvdVpq?=
 =?utf-8?B?SjMrZysyV2pTZTJvendZSlc4TGlGdnUwOHhiSjlCbitqaWRENGZ2YXlMcTMx?=
 =?utf-8?B?dy9ucSs0T2lBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ay9vT1dNZUNsd2RUbGR5a1RLZ0tCQmdMOGlyVHdPYXB0WVNsY2ovVFJ4eWp5?=
 =?utf-8?B?c1F0bGp1eGZKdTA2NThIeFlKcW1nc05XZS9RSmh5a3Fab283YmkvbFRDQW95?=
 =?utf-8?B?cGFsWndTemFKc2cxTnFWOTZzNzA2YXN2cjUxL3hsblpsOFJ3bnd5VDRaaEJX?=
 =?utf-8?B?NVFmQzUzV1RNQzJtMXFPc2FsWXkxVDhWUmFnOVlYK0w5dzMxT0RMUzRmVm1F?=
 =?utf-8?B?c0tXWlJiR2NYMkJlQmhNWnJpblFHVDZmWHI2ZlljWUxMd1VJcUl5T2llZGph?=
 =?utf-8?B?MmhyelZ4eFBlRit4WWo0Y3lHcUNEa3R4eGZHcUxDaE03alVZRW9hdnY0K2tB?=
 =?utf-8?B?Z092QlBPZ2JGTkJWQWcrRlBNMDZhWUUxL0FWbnM1Y3V0akVQMVBnekNVQy9Y?=
 =?utf-8?B?bzZyUDlWQW8xRGMzd1o2SkpJZzFSalI0Vy9nT202TmQwUWI4S0NNRnVBVEk3?=
 =?utf-8?B?RTBsQmpocUtUc0h2TE9PckJDai9UTzY4MUJXVUdjaHhMd21ZejZraWttSWJk?=
 =?utf-8?B?dHVsSVVnS1hQQnd1bC9XRnpTWG94QWZmRGxHZ1ZsazhJTFN6SWNieHEzaHNv?=
 =?utf-8?B?ekc5d3p4SXNiNjYrMGFHVDFLNEwvSHo4Yms5OXExNWZ4ckYwRkVmdHRGclVP?=
 =?utf-8?B?SVpaVFp2Z0cyZXg3Z0g5VitxVWl6dDZJdnRhUXdBdkVxY0dGVkJHRno5Z0V5?=
 =?utf-8?B?ZEg2YjdBY0VPZC85UVlhYXRkY29YVG1tSG8xbmlwaVhRdFY5MitGeGVzb2JI?=
 =?utf-8?B?ajk2TjdUd1hYdGJJRzZJaUFnQ3BEWnk4OTdpdFhRS1hXemNwU2R1ckhpOTh2?=
 =?utf-8?B?QUEraVVCSkVhWTVOa2IzcDFBQXp1dDBLZCt4bEZoV09CdnV2R21MZ3RHVmYv?=
 =?utf-8?B?b2hTOUZOUTQxbHhJMTB1ZlBGankwK1dCU2taN2J3Y3FMWGRid0gzaElpalhH?=
 =?utf-8?B?UlFrZ1lDOGluWjVjYm45SWFKd3lhd2s5UkErVm5Xb0lyeklCQWNaaGVmSUYz?=
 =?utf-8?B?ZTg2N0J2ZllUc1MvZG9iczBzNllTKzlwMk4xSVVuTTJlanpSRUgrRGFESVYx?=
 =?utf-8?B?T0ZEQXlaUEVjQW51QitMMXB4WlBuMDlFV21maURIaENxZWRzdSthMUQ3MHBI?=
 =?utf-8?B?RGlkUVlLSDRpY1lmUEhtS1JqNElyUFFYK2w3NmI5MmxHWTB4NElQa2pyV3Bk?=
 =?utf-8?B?MVFNRWhqdXZoL09CYUF6Nkl4bHJqUXlzeVB2cGJBVmdqQmVCam03eDViaEFG?=
 =?utf-8?B?RG0yUnRkVkxnaUVyYmtsaVZrbDV5Y3Q0VUtIbjJja1hlZUp6QlhvdE5rM1dN?=
 =?utf-8?B?MWRJcytXMHlHNjhmazFSdm5PUlJ3VytDYWNDeElGSFI5akJjN0NEUjRXdmQ0?=
 =?utf-8?B?SUkwUVR2V3ExWnFPM29HTHRlVUs0NHcvYzNINWl1QzFlbTZoWmVrNUtMbkRD?=
 =?utf-8?B?WEJadFQ3UTFZNnh1RnZHQzM1NXZWc1JnZHc1ZkFYTnUzVnRnZlkzNnJ0dzJZ?=
 =?utf-8?B?UTBrUDd6ckFtenJOSjFIQUtlVm5wZi9hUmt5N2c0U0NyalJNVzZkaXA0a1lr?=
 =?utf-8?B?VTNhRWNLa2trbHlndngrakRYTGhETVpzODBkbHBXMW5QcWFQODhBaVF1cExV?=
 =?utf-8?B?OGNocmVtWDRBOFJiUjJiSHFneW5ObjZQWG03dWxwT1c2RkRmSlAyR3p0bGY2?=
 =?utf-8?B?UzRjamxuOHNVM2tyR2dRbkhXb0JoYzdYZ3NIcGdlbDhqY0ZCUlpWMUhHUjhQ?=
 =?utf-8?B?OXdVZmV4b3ZHTW9ueGczQTJGV3FNbnV3YmxLQloxTEphcmlKUlVmWkVEVGlC?=
 =?utf-8?B?S3d2d3RHQ1JjTU9KRi9LdDJrbzBQWGlYcFpPY3ZxWlhXRExqTEhFTjErL0ha?=
 =?utf-8?B?RkxBa0dqSVFOelEvUjBIYkFkbG5DS0hkb1Z5SDRyUnFudjBsZEo0OG12WE05?=
 =?utf-8?B?OVFuL0U4ZFQrbnhkdElnM242WmNMb0VDeWJEcTEwelpMT1dIbmM5Ukx2UUlK?=
 =?utf-8?B?ZmdFQUhJL2pGMXgwUmtYK2MvMVd3ak8ycGJ4ZG9YSDF4dmJhRWdDVjJpNG5s?=
 =?utf-8?B?YjZFVThDWG9VdnJOaHlKMVczUk9lRkdxTFNRcHJDZ1NSQjBmWi8xdEhJUWJj?=
 =?utf-8?B?MDVxaDhOeUMrekt3S0x2THRONWhmUEJTK2VpMjEzNWx4ZjE5MGN1Rk5FSlI1?=
 =?utf-8?Q?L72vTbAV0uVjxJURmsO8y9w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7755420DB6A2D4FA33E0923EDBA90F7@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: df73299f-d728-42aa-99bf-08ddfb939925
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 17:55:50.4023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xjV3ZCLas3byZSDWZQk9mHE/EYruiELSzk0Tjda882xdpDTceJgBo4yfNHCwZnwhfhE/VSbOrQ27bIJCDe7H3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4564
X-Authority-Analysis: v=2.4 cv=J5Cq7BnS c=1 sm=1 tr=0 ts=68d430a9 cx=c_pps
 a=miQpwXaPIJxEFudIojRT/A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=cOfPTXrI7GuoNVvgdSIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: RH4UpgLwbbV6GzBEkwKy9jFuNbpmsJwn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNSBTYWx0ZWRfXykV/P6rXLgQf
 9XK2FM2GjlKQUatUohBDzljgVs4HWEH7oKVfomE5AqfDTKNXHrUuZsw4SvOFvM1V/AOrn/nJzyf
 cp5y5iQi+6nAI64egyZjZUcfr8hCtwX9ww1uOpTaFNRWTPeZKOd3GrBhEn7HCw9WGxZmcYwPBG1
 ZXifRqOoIfPeWBp7cY9GZ9bI6nWQLEkxL4IC9Ncww9tjeSbEExnh8hHDc6NlGa4z66u1yhu7dI/
 0Cw4JAhp5Y1h5m2GoVN5xFIMTXQyQlawsnpCyv40wstpucpDObmyVLmEKDEDZmmDjdhJV19/X+2
 QMKanOeOZSyf9seN2Wfc0RBsF/ujLE8BtiN+o5eMTa2ZB7emeVPIb716ObovnNojicOkxkJA8wj
 yhYkLDip
X-Proofpoint-ORIG-GUID: oVTC1KCjxx_z4CcnKIxq9kVddRgEc1Hx
Subject: RE:  [PATCH] ceph: Fix log output race condition in osd client
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_04,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200015

T24gV2VkLCAyMDI1LTA5LTI0IGF0IDE1OjU3ICswMjAwLCBTaW1vbiBCdXR0Z2VyZWl0IHdyb3Rl
Og0KPiBPbiBUdWUsIDIwMjUtMDktMjMgYXQgMTc6MjcgKzAwMDAsIFZpYWNoZXNsYXYgRHViZXlr
byB3cm90ZToNCj4gPiBPbiBUdWUsIDIwMjUtMDktMjMgYXQgMTM6MDggKzAyMDAsIFNpbW9uIEJ1
dHRnZXJlaXQgd3JvdGU6DQo+ID4gPiBPU0QgY2xpZW50IGxvZ2dpbmcgaGFzIGEgcHJvYmxlbSBp
biBnZXRfb3NkKCkgYW5kIHB1dF9vc2QoKS4NCj4gPiA+IEZvciBvbmUgbG9nZ2luZyBvdXRwdXQg
cmVmY291bnRfcmVhZCgpIGlzIGNhbGxlZCB0d2ljZS4gSWYgcmVjb3VudA0KPiA+ID4gdmFsdWUg
Y2hhbmdlcyBiZXR3ZWVuIGJvdGggY2FsbHMgbG9nZ2luZyBvdXRwdXQgaXMgbm90IGNvbnNpc3Rl
bnQuDQo+ID4gPiANCj4gPiA+IFRoaXMgcGF0Y2ggYWRkcyBhbiBhZGRpdGlvbmFsIHZhcmlhYmxl
IHRvIHN0b3JlIHRoZSBjdXJyZW50DQo+ID4gPiByZWZjb3VudA0KPiA+ID4gYmVmb3JlIHVzaW5n
IGl0IGluIHRoZSBsb2dnaW5nIG1hY3JvLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBT
aW1vbiBCdXR0Z2VyZWl0IDxzaW1vbi5idXR0Z2VyZWl0QHR1LWlsbWVuYXUuZGU+DQo+ID4gPiAt
LS0NCj4gPiA+IMKgbmV0L2NlcGgvb3NkX2NsaWVudC5jIHwgMTAgKysrKysrLS0tLQ0KPiA+ID4g
wqAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+ID4g
DQo+ID4gPiBkaWZmIC0tZ2l0IGEvbmV0L2NlcGgvb3NkX2NsaWVudC5jIGIvbmV0L2NlcGgvb3Nk
X2NsaWVudC5jDQo+ID4gPiBpbmRleCA2NjY0ZWE3M2NjZjguLmI4ZDIwYWIxOTc2ZSAxMDA2NDQN
Cj4gPiA+IC0tLSBhL25ldC9jZXBoL29zZF9jbGllbnQuYw0KPiA+ID4gKysrIGIvbmV0L2NlcGgv
b3NkX2NsaWVudC5jDQo+ID4gPiBAQCAtMTI4MCw4ICsxMjgwLDkgQEAgc3RhdGljIHN0cnVjdCBj
ZXBoX29zZCAqY3JlYXRlX29zZChzdHJ1Y3QNCj4gPiA+IGNlcGhfb3NkX2NsaWVudCAqb3NkYywg
aW50IG9udW0pDQo+ID4gPiDCoHN0YXRpYyBzdHJ1Y3QgY2VwaF9vc2QgKmdldF9vc2Qoc3RydWN0
IGNlcGhfb3NkICpvc2QpDQo+ID4gPiDCoHsNCj4gPiA+IMKgCWlmIChyZWZjb3VudF9pbmNfbm90
X3plcm8oJm9zZC0+b19yZWYpKSB7DQo+ID4gPiAtCQlkb3V0KCJnZXRfb3NkICVwICVkIC0+ICVk
XG4iLCBvc2QsDQo+ID4gPiByZWZjb3VudF9yZWFkKCZvc2QtPm9fcmVmKS0xLA0KPiA+ID4gLQkJ
wqDCoMKgwqAgcmVmY291bnRfcmVhZCgmb3NkLT5vX3JlZikpOw0KPiA+ID4gKwkJdW5zaWduZWQg
aW50IHJlZmNvdW50ID0gcmVmY291bnRfcmVhZCgmb3NkLQ0KPiA+ID4gPiBvX3JlZik7DQo+ID4g
PiArDQo+ID4gPiArCQlkb3V0KCJnZXRfb3NkICVwICVkIC0+ICVkXG4iLCBvc2QsIHJlZmNvdW50
IC0gMSwNCj4gPiA+IHJlZmNvdW50KTsNCj4gPiANCj4gPiBGcmFua2x5IHNwZWFraW5nLCBJIGRv
bid0IHNlZSB0aGUgcG9pbnQgaW4gdGhpcyBjaGFuZ2UuIEZpcnN0IG9mIGFsbCwNCj4gPiBpdCdz
IHRoZQ0KPiA+IGRlYnVnIG91dHB1dCBhbmQgdG8gYmUgcmVhbGx5IHByZWNpc2UgY291bGQgYmUg
bm90IG5lY2Vzc2FyeSBoZXJlLg0KPiA+IEFuZCBpdCBpcw0KPiA+IGVhc3kgdG8gbWFrZSBjb3Jy
ZWN0IGNvbmNsdXNpb24gZnJvbSB0aGUgZGVidWcgb3V0cHV0IGFib3V0IHJlYWwNCj4gPiB2YWx1
ZSBvZg0KPiA+IHJlZmNvdW50LCBldmVuIGlmIHZhbHVlIGNoYW5nZXMgYmV0d2VlbiBib3RoIGNh
bGxzLiBTZWNvbmRseSwgbW9yZQ0KPiA+IGltcG9ydGFudCwNCj4gPiBjdXJyZW50bHkgd2UgaGF2
ZcKgIHJlZmNvdW50X3JlYWQoKSBhcyBwYXJ0IG9mIGRvdXQoKSBjYWxsLiBBZnRlciB0aGlzDQo+
ID4gY2hhbmdlLA0KPiA+IHRoZSByZWZjb3VudF9yZWFkKCkgd2lsbCBiZSBjYWxsZWQgYW5kIGFz
c2lnbmVkIHRvIHJlZmNvdW50IHZhbHVlLA0KPiA+IGV2ZW4gaWYgd2UNCj4gPiBkb24ndCBuZWVk
IGluIGRlYnVnIG91dHB1dC4NCj4gPiANCj4gPiBBcmUgeW91IHN1cmUgdGhhdCB5b3UgY2FuIGNv
bXBpbGUgdGhlIGRyaXZlciB3aXRob3V0IHdhcm5pbmdzIGlmDQo+ID4gQ09ORklHX0RZTkFNSUNf
REVCVUc9bj8NCj4gPiANCj4gPiBUaGFua3MsDQo+ID4gU2xhdmEuDQo+ID4gDQo+ID4gPiDCoAkJ
cmV0dXJuIG9zZDsNCj4gPiA+IMKgCX0gZWxzZSB7DQo+ID4gPiDCoAkJZG91dCgiZ2V0X29zZCAl
cCBGQUlMXG4iLCBvc2QpOw0KPiA+ID4gQEAgLTEyOTEsOCArMTI5Miw5IEBAIHN0YXRpYyBzdHJ1
Y3QgY2VwaF9vc2QgKmdldF9vc2Qoc3RydWN0DQo+ID4gPiBjZXBoX29zZCAqb3NkKQ0KPiA+ID4g
wqANCj4gPiA+IMKgc3RhdGljIHZvaWQgcHV0X29zZChzdHJ1Y3QgY2VwaF9vc2QgKm9zZCkNCj4g
PiA+IMKgew0KPiA+ID4gLQlkb3V0KCJwdXRfb3NkICVwICVkIC0+ICVkXG4iLCBvc2QsIHJlZmNv
dW50X3JlYWQoJm9zZC0NCj4gPiA+ID4gb19yZWYpLA0KPiA+ID4gLQnCoMKgwqDCoCByZWZjb3Vu
dF9yZWFkKCZvc2QtPm9fcmVmKSAtIDEpOw0KPiA+ID4gKwl1bnNpZ25lZCBpbnQgcmVmY291bnQg
PSByZWZjb3VudF9yZWFkKCZvc2QtPm9fcmVmKTsNCj4gPiA+ICsNCj4gPiA+ICsJZG91dCgicHV0
X29zZCAlcCAlZCAtPiAlZFxuIiwgb3NkLCByZWZjb3VudCwgcmVmY291bnQgLQ0KPiA+ID4gMSk7
DQo+ID4gPiDCoAlpZiAocmVmY291bnRfZGVjX2FuZF90ZXN0KCZvc2QtPm9fcmVmKSkgew0KPiA+
ID4gwqAJCW9zZF9jbGVhbnVwKG9zZCk7DQo+ID4gPiDCoAkJa2ZyZWUob3NkKTsNCj4gDQo+IEhp
IFNsYXZhLA0KPiB0aGFuayB5b3UgZm9yIHlvdXIgcXVpY2sgYW5zd2VyLg0KPiANCj4gSSBjaGVj
a2VkIGl0IGFnYWluOiBJIGJ1aWx0IHRoZSBrZXJuZWwgd2l0aCBnY2MgMTUuMi4xIHdpdGggLVdl
cnJvciBhbmQNCj4gQ09ORklHX0RZTkFNSUNfREVCVUc9biBhbmQgZXZlcnl0aGluZyByYW4gdGhy
b3VnaCBmaW5lIHdpdGhvdXQgYW55DQo+IGVycm9ycy4NCj4gSSBndWVzcyBiZWNhdXNlIG9mIHRo
ZSB3YXkgbm9fcHJpbnRrKGZtdCwgLi4uKSBpcyBidWlsdC4NCj4gDQo+IEFuZCBmb3Igc3VyZSwg
dGhpcyBpcyBvbmx5IGRlYnVnIG91dHB1dCwgYnV0IHJpZ2h0IG5vdywgdGhlcmUgaXMgYSByYWNl
DQo+IGNvbmRpdGlvbiwgd2hpY2ggSSB3ZW50IGludG8sIGFuZCBpbiBteSBvcGluaW9uIHRoaXMg
c2hvdWxkIGJlIGZpeGVkLg0KPiBBbm90aGVyIG9wdGlvbiwgd2hpY2ggd291bGQgYmUgY29tcGxl
dGVseSBmaW5lIGZvciBtZSwgY291bGQgYmUgdG8NCj4gcmVtb3ZlIG9uZSByZWNvdW50X3JlYWQg
Y2FsbC4gVGhpcyB3b3VsZCByZXN1bHQgaW4gc29tZXRoaW5nIGxpa2U6DQo+IA0KPiBkb3V0KCJn
ZXRfb3NkICVwOyBuZXcgcmVmY291bnQgPSAlZFxuIiwgb3NkLCByZWZjb3VudF9yZWFkKCZvc2Qt
DQo+ID4gb19yZWYpKTsNCj4gDQo+IElmIHlvdSBoYXZlIGFub3RoZXIgaWRlYSBvbiBob3cgdG8g
aGFuZGxlIHRoaXMgSSdtIG9wZW4gdG8geW91cg0KPiBzdWdnZXN0aW9ucy4NCj4gDQoNCkhpIFNp
bW9uLA0KDQpJIHRoaW5rIHRoYXQgcmVtb3Zpbmcgb25lIHJlZmNvdW50X3JlYWQoKSBjYWxsIGxv
b2tzIGxpa2UgbW9yZSBjbGVhbiBzb2x1dGlvbi4NCkxpa2V3aXNlIHN0YXRlbWVudDoNCg0KZG91
dCgicHV0X29zZCAlcCAlZCAtPiAlZFxuIiwgb3NkLCByZWZjb3VudF9yZWFkKCZvc2QtPm9fcmVm
KSwNCnJlZmNvdW50X3JlYWQoJm9zZC0+b19yZWYpIC0gMSk7DQoNCnNtZWxscyByZWFsbHkgYmFk
IGZvciBteSB0YXN0ZSBhbmQgaXQgbG9va3MgbGlrZSB0aGUgb3ZlcmtpbGwgYW55d2F5LiA6KQ0K
DQpUaGFua3MsDQpTbGF2YS4NCg==

