Return-Path: <linux-fsdevel+bounces-42137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E62A3CD6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 00:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17C33A5785
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 23:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BB325D550;
	Wed, 19 Feb 2025 23:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W7gbdgmY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715801D7E30;
	Wed, 19 Feb 2025 23:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007387; cv=fail; b=P8+Bc1RZ4f2M20vwxd5e6Ol1uU3P/qEwwJ3loK0hiYMK99tNEHpWs+3J3N7HPnThvpHk57zK6T4J+9tvkWK++4sMBRow8ss1svvle5O7Y+QvAeKPiFRrugtxmTs8PsQUdFXQllVsgLQDeQ3kPc2Rt5nJS+0V0JSJAonXGUHV/TM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007387; c=relaxed/simple;
	bh=UPI5pyVDuzgLcQ9XeiqnHflWxxax9H0rsedIMLlT6yM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=ID3WNS+1/Tkp+pjOjlSi9mMwM9NBivMKuNq65S9ECLXerUYjb8MSbBCTdyN3a06r1m3yNkWM9SBqIv30JAEsyjFl4eyZUjH0nIXZHoJaDZoa8mgbK6DhJRDVJdkmO/LQlutfKgmC+iBnCowkemZGERvVWjybv3WmS6uUgAFxs9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W7gbdgmY; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JGAwM9005411;
	Wed, 19 Feb 2025 23:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=UPI5pyVDuzgLcQ9XeiqnHflWxxax9H0rsedIMLlT6yM=; b=W7gbdgmY
	e7RQY/D3yos23+qiUoSJpqUSJ/94eVhbv6jv/HLc+kitjAvuyEBzMvE1y3q246fq
	Ykkz+7JBien9+waOEDYBDRnMu+ka1TXl+QR7eRD1GjnFYDqh2JxKcFHoW2b9IsmY
	t7ppG0becQ52XpilGZDEI6v2SE9fqvDOCeToEp3Tu1au93YDZbv5ur11QAFu2EnB
	aGeMVV4DOHnmqeZyzE/SpIqHN2wSDCRE4TMj+PW43ebxCHgunM8sEffAKtVLdUW4
	+ea8nzwRm9AqxL2uqugBrReAWUmXVvv4OR7Un17O01oWx53eHnXtGh8xJ+a8sleZ
	7u1qoA8ufFT4vw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44w650dhgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 23:22:53 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51JNGELt031920;
	Wed, 19 Feb 2025 23:22:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44w650dhgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 23:22:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=haW3MsmPa0/C5zciT4uF+2PuJjQ6FwTDUHIW/asiUaMa/n2XqgPLlw8QkgJpNu5yCNdzIuXHoXSEtqUvD18FQL8jhu6YZI1nR6FgpjbaDlWmFKoG6voVadWNE7jP+Kh0+6vpeanIyF8z/o7XJVMVUot/Jefo4osZqL9NSWPQWcSuA96sSc6GyjdvGaJ9XGRNeo3le5SfpazRpRBTJBZZRCUSJgmTVxDggo3nhntgnPx6rcSy/MmnGuQ2FShazida461DDvKC9Tbi682cAlW3z0BrlPAnUasTkQ1VJA4mZaGgJO59zy8KZlwkmri2H7FDGpAHRxSMTCc/h0SwVYIADQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPI5pyVDuzgLcQ9XeiqnHflWxxax9H0rsedIMLlT6yM=;
 b=HfELwIr4hQ19cU74iWh46n3G1QOTIzf9YH/ZvSFAa9dnfBhthlfJc7hVFrtpCh4HVO+4jtkYG8xwPd2Wr1YhwGKz+KxH+y9POi0KY4GwdneQR7/U+W4S+m/cikDoAb08X+ZJcSpUbGMuoLC8AjHoiWgV9H9r/Pw0rb1uUO5c8j4ulDu3I4JihZdyX9ti566pJQxs5nWc63Av2/XH7wJ6l3/6yYGCvbRTVcCZmnN15rRaI9AhlBOpyNmRZcfQpNCmd+7hDoBrXDigR7BK5gc/j+H+tTbpYvdzQ0x6Gs2uVa6oBBprP/bQW3vGsuq1qtglg0/VYxJZn/hHQIivMZzkzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB5287.namprd15.prod.outlook.com (2603:10b6:510:14f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 23:22:51 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%4]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 23:22:51 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC: "luis@igalia.com" <luis@igalia.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>
Thread-Topic: [EXTERNAL] Re: [RFC] odd check in ceph_encode_encrypted_dname()
Thread-Index:
 AQHbfpCIos2EbKYFiUGV+rHGHxWwQbNG8KKAgAAHCy2AANRJAIAAtn1ygANLFYCAAA6HuYAANr0AgAA29QCAAXmIAIAAEnmAgAAWVwCAAWEoAA==
Date: Wed, 19 Feb 2025 23:22:50 +0000
Message-ID: <67cc3419eabb368fda7339ffef1b317038afee77.camel@ibm.com>
References: <bbc3361f9c241942f44298286ba09b087a10b78b.camel@kernel.org>
	 <87frkg7bqh.fsf@igalia.com> <20250215044616.GF1977892@ZenIV>
	 <877c5rxlng.fsf@igalia.com>
	 <4ac938a32997798a0b76189b33d6e4d65c23a32f.camel@ibm.com>
	 <87cyfgwgok.fsf@igalia.com>
	 <2e026bd7688e95440771b7ad4b44b57ab82535f6.camel@ibm.com>
	 <20250218012132.GJ1977892@ZenIV> <20250218235246.GA191109@ZenIV>
	 <4a704933b76aa4db0572646008e929d41dd96d6e.camel@ibm.com>
	 <20250219021850.GK1977892@ZenIV>
In-Reply-To: <20250219021850.GK1977892@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB5287:EE_
x-ms-office365-filtering-correlation-id: cc38deba-261e-447b-e99b-08dd513c5444
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SlB3ZnJFY2dSZ082V1lSL01LcmROMzR1N0tqNmphSEZ4Z3hUK3Z5KzFNNk5m?=
 =?utf-8?B?UzBva21BMXRZdlpWSVJERU5WRHNJTHlzMFFYeXErUTlDQlU0VGVqMDhRK0Rm?=
 =?utf-8?B?YTd3alVUVGU1MFNzLzlFVWp1Ym5Wa1pObGhoRU81a0xxQXJBblg5dVlkai9Z?=
 =?utf-8?B?VXhXdGh5dGNOSnBwNStFZFVGWkNHUUhjbGxFTTJSaHZveTJWUmh3ajNubm5k?=
 =?utf-8?B?NWY5emVKeWE4UDY1dmJoOXZXU2k5MXRZeGo0aFJrVnhDcXJ5YVdGSFRxV0lq?=
 =?utf-8?B?ODZCS1k1cVdjUHVRVFVXc1RjZlJWYWJXSURQV0JFUmNJbUFqZXVsMURzdEI0?=
 =?utf-8?B?YUtUNjFNYW5OL2hpK2lFR21XVkVKKzZ4Y1g1bUY4Wkh1MUJFa0V0R2dURS9y?=
 =?utf-8?B?YXpxcnBveHd6TTllVFNkcjMyQzRBZHhSbG15T0FwUFNOZHU1d3ltZ1MzVVJn?=
 =?utf-8?B?OGE4WEhvSDN1MlRrZWxRTCtmM1dWWjhpcHQrcUVxZFExUzZDNW1pMThKNjRF?=
 =?utf-8?B?U0lVKyswWGo0MDRRZ1hyaTQza0xxNjFxNGovRC93NE0rejJNNm9KVHc4c05y?=
 =?utf-8?B?L3Jxc2huUkR4VzdJeVlnVGVJK0w4Vit0Wms5TXNuNzN3YU1wNzZRN0xDd0lQ?=
 =?utf-8?B?Rnp6K05PVU1mZXNGdWxXdmJ0WjY1WEQ4Rnp2OXlXaUlVR0hBZit4TGRLWVUz?=
 =?utf-8?B?aDdTUXVlNzVSdXBUOHl5R1cwRWNBajdjeTJraEdKVUl3MGtRb3dWTEdUdlRz?=
 =?utf-8?B?em5hMTBscW00VHFqdXRwQW0rakZzU1pGaWhkd0I4MXpNWkd2eHptK2VwbC9L?=
 =?utf-8?B?c24wTEVqeWpWMzVLakhyNjUvdytQU05hdkxaRlpncVNadlozTmRFZDMxeDJh?=
 =?utf-8?B?NEhnUmhWaDg1Q3MrM09oS3hHYmFGVzhRZkpZMUJIWWN3MmtXQ2VqTGpwbXJs?=
 =?utf-8?B?SUlWVllPeThkMVl2bmNGaTNOQXpiRkx1YXhCYTV0QmdHa1JaMzJ6U2xBWmRP?=
 =?utf-8?B?RmdQTjdUbTVwaGdEdTNLVy9RV3o3Qjd0NGREMU1vUkdPbGl5Q2RNZnltNXhQ?=
 =?utf-8?B?QnBFSmsydmZoR2tYb29nUldjQ0I5RmRoZG5YMFZiOUNRQVRoZlBKVHl5WHgz?=
 =?utf-8?B?S210bytDOXRLMjl1Rkl5WWJla2lDcnpxS2svYVU1a2FDOTdiK2JYbTNHMkdO?=
 =?utf-8?B?NU83V21nVDBxTjFPUXI2ZlJiVXhnODlsZ3N1UWtiYklYODk1ZHBCK0hBZC9h?=
 =?utf-8?B?d1hRODZmM1c0R094cXJrVEZtS0RGbFpzZnRqaWZCWGxEZDJweHFJc0lmR0FY?=
 =?utf-8?B?WFRFdEZUNmJZZWd2YVhCS0RtV2JUem9LRWNCS2pPa2hWRE16T0Y4RlJjRUNh?=
 =?utf-8?B?d2dBbmhYWTN3L3FBbjZEQ1pRekxWVjVKWnREZU1mOTdlS2RrUHFHc2hTY2JJ?=
 =?utf-8?B?cjh5SWVlMDJPdEd5OENOeERocjN1b0VtTGkvdXZ0K2hmZjZwSVVBTlNJSlB3?=
 =?utf-8?B?QnlHRWg1NzVveWVvbGZ6QVBWZm9vRlA4dm5qMC96VWxIYUliSE9kVTEvOFMz?=
 =?utf-8?B?Z1hEdUpFTmk4QmJ4WndFMGxIZkJxSnRFSmFQVzA1MzloeVk2cXllRkhReWpY?=
 =?utf-8?B?NzZ3dmJnQm5tSzN1M3BBMkM0TVdMNVFjUzhmQ1NKdy9weXljNW03UXpTRDhV?=
 =?utf-8?B?OTQycFZLOWtYVTBpQzJFTkwzZVFNSGw4WGlHblRocWVyWTRRVWY4YVRQUmNF?=
 =?utf-8?B?djF2RmpPWHE5Q21ObGVhMXE1UUYyK3VVcWFQa01XZEtHekFHNGFvVDkvVG1w?=
 =?utf-8?B?Y3Fvc1VoUFVzYXZwWldBd0xkV1h6ODBNKzhod2lrajdraTdlNDFZT1R2RlFQ?=
 =?utf-8?B?L0M1bmI0RnVWUjQyQzZwd1dUOU9TQWI1a2pFdldJQlJXRGVhQ05vVGcyWDBp?=
 =?utf-8?Q?/b34t9adSEoUVIN1LOBHSoo2ShTKV2wt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QlUrMzFmUkFKNVc0ZUlIS0c2SHRMNW9mZkxPd0NtOWRRUGVWN0lvaUVva0Jh?=
 =?utf-8?B?WWNIVEd2eE0ya29hRUw4ZzZrUjliK1JkWVVRTHVYb2R4YWYxQW1sOVF6RzhX?=
 =?utf-8?B?dzhDeFBsdlJ5ZzhPV3ZDRVIxV3JJUjhDNzFGdCtJSmNpdVlmZGpMM1lDZFov?=
 =?utf-8?B?UUZucFludEljWm1HTkdWYUpCaDl4ZXRkdWJaM1BjaFRmc3ZuZlJVM3JvYjJu?=
 =?utf-8?B?djBKNXBiL2NHLzViRHZmTW82SzBuMlYrajVuU0M4Zm9oZkRQSU9CSjdvcnVI?=
 =?utf-8?B?MGtBL1VhNUhRY0M4dE1ubE8wK1ZFaXliZ1VMaW11N2Z2ZWZYMCtkUUJNQzlR?=
 =?utf-8?B?MWwyU3IxMy8vSEM0cURJNDdNNVpSeS85d3lFYVdjamdLOStOYVRaclltVlFW?=
 =?utf-8?B?OGk3ZzVkeWpUSHhkQUt3dFJFd0FVQ0liRlNBdm11VzFoOXZmSUNkU2lmM3Y1?=
 =?utf-8?B?QkY0dXdteWpFaFNZaWdYL1hyb3Zkb1YyUnppRlJOY0dRclJLUVdLWnQwNUtn?=
 =?utf-8?B?aGh6VXhLdy9SL2FoY0lGNUJBeU5MWjByYmcrOUErN1VtMVJVamlCUWRGdFBC?=
 =?utf-8?B?bFYwcnpOWmY5T01uOHdLS0hia21tSU93NzgwSENuY0VQekxrS2s2NUxuZS84?=
 =?utf-8?B?RlNnYUZSTVhoSzdPd21BWjhKaDVkV1lnczFlUkRCVE5QTStsb0JVYWJsS0Iv?=
 =?utf-8?B?RGNkZ3RHU3g0RTd3VGxZakNLUzlqdFByVS9ZNVNTRTI5cCt0L1ozeFdjNEtV?=
 =?utf-8?B?TGxrWUp0MjdicHBwcjZsWHhYT0p0WEtvdDcrbmJKRHZvY25GM2tmSkpFUXdi?=
 =?utf-8?B?NDVlNUZ1L3N1dkVSeVE3b0VkdkRjeE5BMGhqN2NBRmRhc2RXblJsQ0lHa3F1?=
 =?utf-8?B?QlpaYThiekc2QmtlMlhQYjFrZFJ5UGNYcm9rMlVJeCtObVNNbjVPZ0ZpcXR5?=
 =?utf-8?B?aTZZeDMvMGwyMmVoTUpyVE1NMVlyeGppYVdwREFHUTkxVG1oU2JDS3pUMy9T?=
 =?utf-8?B?b2lWV05TRDBrNHZoM2JVZEJvRzlGV3lnc2xtaDFwN042RmRnSHFiV3dmMzJh?=
 =?utf-8?B?bHBnKzBZYy9ZdEFQTDVXMWlEbkJrVXpYazNIUW9nK1dSc3BiRXBsUHFHaGFp?=
 =?utf-8?B?ekprUXFjaWF3b3kyNFdOK3FaTjhsbHZ3UzFUVysyQWwxS0Y0Y1ZmM2JlQlI2?=
 =?utf-8?B?Q2hZSTNzVDRrY1pPZm1RZUt2c0FYelJTS2hvVGI4OW0rY0tnVjAwSW1KWGxp?=
 =?utf-8?B?SkwvbitxY0hHRHQxOFN1RTR0NnFwNXFwWXBZMVFubXJ5QkdWNlY5aEhVdFVw?=
 =?utf-8?B?bVpxYW1CYXVwZ0gvd093U1lNMEswUW5wdmtGVXpaN2FRcXZaUlQ1SjFHNkd3?=
 =?utf-8?B?RDNKMVhGcHhCa0JHSWY5MVVHd0l1V281K01tajczUEl2elZNYUtKRkl5Yys0?=
 =?utf-8?B?bGFYZTFsZGNaUnp1K2daWVZ2OG9wU2RxVjVuRGZjQUNwQzYwdHlRSVg0aTRK?=
 =?utf-8?B?S0NMMjRZd3lQQ2NLZmpvaTdHOXVCNjE5MUJpWEN3clY2YkNxSEw3Y3lxU3Yx?=
 =?utf-8?B?TzNWMjVqYmdIaGo1eFRHamJaYTdhSWtpbkFqcEg5SDBZc2FPMVkwSGVTbHdy?=
 =?utf-8?B?dkhvUEU3bFJCdnRvbzFyUWxUT2ZjV0NpalVjdVExQ1JORW1wMThEdm5ZQ3lz?=
 =?utf-8?B?cHp0eCtEbnhQVDdpSUYyOTkvNHJHNU92b1BFVjBVZXNiWTdzeFlSYklBcmRs?=
 =?utf-8?B?MHc2TVcxR1Y4NkZDQ0Q1MURvNWxQSlJ3bk9UTEdXR3c3eWpmSlhyOERHTDRU?=
 =?utf-8?B?M1pIZXh2eXlTd3VxaXlXWmRqaTd1aWVTV0pPbVhDb285Uk52c2pkNHY2REFZ?=
 =?utf-8?B?MUxCck9sRTBYODF2RGthd3ora1FpdnROTG9wc1pvdHJ1TzlzYW1nSmg3RmNH?=
 =?utf-8?B?WTRmdnZ6YkgwSXE1Qnk2d3N3NkNtZnRGeEpLSm9KTHV5cC9ydE9ZSVY3V2tj?=
 =?utf-8?B?bm9qQ1MzZlRGbUlScHVYakdNbjlHQmM2MjNDR3NWMXVwY1h3QndSZkpReFBI?=
 =?utf-8?B?ZnQySjNMc21EQWJ1aktVeUpRa2doZExCb2lqYndLOU9FVHBxUHNmVzMvZTJD?=
 =?utf-8?B?T1V1dnRYT0xiS1lLc0xBSGtjNTE4K3d3VFl3UXNONXhIRTBIUFQyMyswdmVo?=
 =?utf-8?Q?VYzpcYWylhmJBwfa9FtyniQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C1CB94918E0B04891FA3066CEB2E3B8@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cc38deba-261e-447b-e99b-08dd513c5444
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 23:22:50.9782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T44PLNidghlxmTPFhM7rl6IknLirJDLWlNMwplxL5hmnYFFs+J6FmXJrzl5oIhgJV5twi2xM+vLdQjhhDil0jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5287
X-Proofpoint-ORIG-GUID: gmAJgS9XhNjLU4hVKJNimYiHX6rIrZqf
X-Proofpoint-GUID: nEGDvxEqSDzJT97lhr_Dy2H_j-ApXm8b
Subject: RE: [RFC] odd check in ceph_encode_encrypted_dname()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_10,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=881 spamscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190169

T24gV2VkLCAyMDI1LTAyLTE5IGF0IDAyOjE4ICswMDAwLCBBbCBWaXJvIHdyb3RlOg0KPiBPbiBX
ZWQsIEZlYiAxOSwgMjAyNSBhdCAxMjo1ODo1NEFNICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28g
d3JvdGU6DQo+ID4gT24gVHVlLCAyMDI1LTAyLTE4IGF0IDIzOjUyICswMDAwLCBBbCBWaXJvIHdy
b3RlOg0KPiA+ID4gT24gVHVlLCBGZWIgMTgsIDIwMjUgYXQgMDE6MjE6MzJBTSArMDAwMCwgQWwg
VmlybyB3cm90ZToNCj4gPiA+IA0KPiA+ID4gPiBTZWUgdGhlIHByb2JsZW0/ICBzdHJyY2hyKCkg
ZXhwZWN0cyBhIE5VTC10ZXJtaW5hdGVkIHN0cmluZzsgZ2l2aW5nIGl0IGFuDQo+ID4gPiA+IGFy
cmF5IHRoYXQgaGFzIG5vIHplcm8gYnl0ZXMgaW4gaXQgaXMgYW4gVUIuDQo+ID4gPiA+IA0KPiA+
ID4gPiBUaGF0IG9uZSBpcyAtc3RhYmxlIGZvZGRlciBvbiBpdHMgb3duLCBJTU8uLi4NCj4gPiA+
IA0KPiA+ID4gRldJVywgaXQncyBtb3JlIHVucGxlYXNhbnQ7IHRoZXJlIGFyZSBvdGhlciBjYWxs
IGNoYWlucyBmb3IgcGFyc2VfbG9uZ25hbWUoKQ0KPiA+ID4gd2hlcmUgaXQncyBub3QgZmVhc2li
bGUgdG8gTlVMLXRlcm1pbmF0ZSBpbiBwbGFjZS4gIEkgc3VzcGVjdCB0aGF0IHRoZQ0KPiA+ID4g
cGF0Y2ggYmVsb3cgaXMgYSBiZXR0ZXIgd2F5IHRvIGhhbmRsZSB0aGF0LiAgQ29tbWVudHM/DQo+
ID4gPiANCj4gPiANCj4gPiBMZXQgbWUgdGVzdCB0aGUgcGF0Y2guDQo+IA0KPiBUaGF0IG9uZSBp
cyBvbiB0b3Agb2YgbWFpbmxpbmUgKC1yYzIpOyB0aGUgZW50aXJlIGJyYW5jaCBpcw0KPiANCj4g
Z2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Zpcm8vdmZzLmdp
dCAjZF9uYW1lDQo+IA0KPiBUaGUgZmlyc3QgY29tbWl0IGluIHRoZXJlIGlzIHRoaXMgb25lLCB0
aGVuIHR3byBwb3N0ZWQgZWFybGllciByZWJhc2VkDQo+IG9uIHRvcCBvZiB0aGF0ICh3aXRob3V0
IHRoZSAiTlVMLXRlcm1pbmF0ZSBpbiBwbGFjZSIgaW4gdGhlIGxhc3Qgb25lLA0KPiB3aGljaCBp
cyB3aGF0IHRyaXBwZWQgS0FTQU4gYW5kIGlzIG5vIGxvbmdlciBuZWVkZWQgZHVlIHRvIHRoZSBm
aXJzdA0KPiBjb21taXQpLg0KDQpJIGRpZCBydW4geGZzdGVzdHMgYW5kIEkgZG9uJ3Qgc2VlIGFu
eSBpc3N1ZXMgd2l0aCB0aGUgcGF0Y2hzZXQuDQpCdXQgSSBuZWVkIHRvIHBsYXkgd2l0aCBzbmFw
c2hvdHMgeWV0IHRvIGNoZWNrIHRoYXQgSSBjYW5ub3QgdHJpZ2dlcg0KYW55IGlzc3VlIHRoZXJl
LiBMZXQgbWUgc3BlbmQgc29tZSB0aW1lIGZvciB0aGlzLg0KDQpUaGFua3MsDQpTbGF2YS4NCg0K

