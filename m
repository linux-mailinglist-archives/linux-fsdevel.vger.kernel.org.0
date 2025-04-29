Return-Path: <linux-fsdevel+bounces-47646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0B2AA3960
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 23:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E776F4A7F9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 21:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D83E269CE8;
	Tue, 29 Apr 2025 21:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tZO7rfB5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76BE257AC1;
	Tue, 29 Apr 2025 21:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745962321; cv=fail; b=VRk8BB6PRmKRHOItEebtEHbTe9hC0PAxkaCugaTW4hnNsacqBcl4VzsOlQF7I0lc37uG/xtGIzd75q8zkGUvZKHKJZBjv1h/okVWjvXcgAbabu4qiMi/owjZseJaM1fhsO6Vz5lQXwc0+sCM15RPoS6V9+uXwzWpFXpjC6Mh9GQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745962321; c=relaxed/simple;
	bh=p8WrgvBEwvw+aBlEHJDffwIG3nFNCnweCrGZdKA86RU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=At1QurFLjcBoE00omC0CrznzvjPVEPdFqB9kkXGaPlaBmsM5ElXBCyK/VWuLJrOtPsGoEsAz4hwsnaxnuYeNEteaBh+kLp6F+4J7v7BYTObj/ghT7edEzbzjPPACZ+RfTfeAWVRURTSB5im1YbVHUVnl94Jtaq1+lBRtT9s0MAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tZO7rfB5; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TL4MOu009158;
	Tue, 29 Apr 2025 21:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=p8WrgvBEwvw+aBlEHJDffwIG3nFNCnweCrGZdKA86RU=; b=tZO7rfB5
	+oh2rvJ4e7BhV1WeJruBywOPQhPzqqrtLcrxVa+k6cxgvN/5mR4+iR1vuVOlXqXB
	hh66S3INDMB+bj+6xyu+DKPO134i0UXHWmZWwV8b8uAG5CxdWjwpqigaMRd4EpL7
	DAeJaZX8VVAejSpTPRWf0XPw5Vx7Nf+oGnEl50hmZ1AME2vk9dZXmCDzdQIYbeSr
	mAQnqmNpuQI0nzKvGGZQFj85jv+PTmENJvcUJmL1gEWpsodffm6X4tslndpx6uoz
	4W2HKajVbXWz0chNg5Uan8xvsBmpYEYTePsNoib+zxnlDUBfOdvHhiIlscLJ5Jnb
	kx90OcIpcR4O6Q==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46aw7t2w1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 21:31:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMiB03O7dK2axm/r48ba2b49InVX388SGKFis4iYf5tFRWnXoDgrS5JpmTQ6sYCDVrKpByfgHNoYaQtGiMKgzZ0cXTfC2fmkGzgM/FdxqpwyQwCr0iEMQd50VW5BBYlRM5z9bCCrcbF9qHaIHiaOhc8P/Tqvev8JY4aNj1Guq2nxmwyIWK8IAKkezav3H47cADEPSmGd8ljRmhUTdVPOzMNOvHlLNAoqmq0Aczt/P49VwwJ7H4XCk+nwX8qpA6ndDh5w//0stJPli4a2gOCe6iYpqT7SoEWUOuYlPxbAhGxSi0ZTRpiJ756iksd/w4nRUltV7NfIyHvp/AHvgCC8vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8WrgvBEwvw+aBlEHJDffwIG3nFNCnweCrGZdKA86RU=;
 b=aQru97Rw09+lmQsvvmIS7iKNG7/UFEILnDSGM61iGcx2l0UYN64MSqT1cmpscYPNKB60VOxdwWKQ7HRjA9N/Q5UWs8pEJna5E9jq7X845mJmUUNDtg8uISTwQLaJqCi8H4uN5Mhyyr5x/20lpSlyTz84/p57zghwLuu5ha0I7s+2G5dJ/MeHdhE/BrnisU5bKFe+BNDum0xYSNrXjK8/Sb0l53shjnDmRZbCTxKfzeQq9mKhhf+U80AaPA/ztLxkF40fGfIjeMmcUYZbSnIInCvPAxHYYUEYXyK+r1NewpHjuxpEcp7y800J1BaQcPCpIBfSfeXn9kYSNoU1WjqmKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW5PR15MB5244.namprd15.prod.outlook.com (2603:10b6:303:194::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 29 Apr
 2025 21:31:52 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%3]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 21:31:52 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH 2/2] hfs: fix to update ctime after rename
Thread-Index: AQHbuUDIPkCyKCyHHEyl9CudlacUJbO7KbuA
Date: Tue, 29 Apr 2025 21:31:52 +0000
Message-ID: <74bb3b5cf703ededae9b2a4a4986efe08e759876.camel@ibm.com>
References: <20250429201517.101323-1-frank.li@vivo.com>
	 <20250429201517.101323-2-frank.li@vivo.com>
In-Reply-To: <20250429201517.101323-2-frank.li@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW5PR15MB5244:EE_
x-ms-office365-filtering-correlation-id: e4102c31-a19a-4035-3b64-08dd876541c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S2F1Um5hb2pRdWpuUjNPb1Fkc2VlV1JrYUZqdW9pREhIOVhJekRabjBqay9E?=
 =?utf-8?B?YTFGY1ltQnllUW91ektPeWFHZXRCUnpZcWxRejhsdEREOVBWLzRBbGZhTHdQ?=
 =?utf-8?B?WGs2SlZ4eFpEWlA3QmFFdTUydmhXTlFreHFXaWcvYk14Y2RUTCtLUFFQNk8v?=
 =?utf-8?B?b0dYMUFTTUNXSVdNam5NZDhld2s5S2dDTm1ZZFBpNXd3WmRYc2dab0lNQnJR?=
 =?utf-8?B?N1ZPWWJyUU0vd2tpdnQ1aXNoZjJ3NldKMXpFaXk0SmNtZDhXdlBiMVNDUDI2?=
 =?utf-8?B?OUxaQ001ZTk3Y01WSGR3WmkxQ3hzVlpreHpoaGJJcHdwSWVicG9TMHpzaHcr?=
 =?utf-8?B?c1JRdkxKMVZiMGhOVU8rUE1IeFVaM0FIUk1lMXVnckw1TUNydlgyMEI5b092?=
 =?utf-8?B?anBpNkc3N3FZZUEvcXRobmk1RktxS0kvcUwwSE1PZTc5aWxtbUlTWHpxTWlO?=
 =?utf-8?B?dUdyTi9PVDdiQUZ2UHNDVmVsdDJ1bWEzUE5KQ3V4eU5DZXlleWdBcDF2OVV4?=
 =?utf-8?B?WDRiWWtIakI5NktuSzRCVCs2UUdudzNuK3p5cEg3QUdiSWp3MytXZFpvQWtT?=
 =?utf-8?B?VGhLMmg1TnpoVkhaQUxKaGNXNElIU1dJd09ESzE1bnl5Z25ub1pGWTRkL05n?=
 =?utf-8?B?SFNTYmdYVmVobGNLcGNzMndDaTlYTnRqWlhJTi8reGJiTGMrNEpTR0p4U0xP?=
 =?utf-8?B?dU02cm11YzVvN0FDY0x6aG5rZm5aTDluaWNka21yYUJ3aW5ic1JYMU5sTE9H?=
 =?utf-8?B?dWpGY2loV041VnN3djlBQWljNnRpMVdxVExOUXZNZUdyam50YUNYNUwyVnBI?=
 =?utf-8?B?RTkzSlVQbUNMOGtZaUxhTU1teFpuWGtjZWpyN0phUFhZTTRsTXRNRitjZTBz?=
 =?utf-8?B?bmJ6WlNzaStiR0ErNFZKTXdZM0NVM01oSGIzcEI4MFVHbENLejZhbVdHU3Zr?=
 =?utf-8?B?d2h0QzhFSmk0Q0dya3IvVldZOUYyYllXcFdWbk1YanVFbW05NjlWZWx3Nlp3?=
 =?utf-8?B?U2lDa1BQaU5DKzZCVFFEVldpc3EwYjFoSjNXRzBQUVIxZDdYT1FzVnVRcDFn?=
 =?utf-8?B?aWYyd3c4aFNYOTR2NXMyWWtMTTJBdnhzYnJnUmlEQ0NDUlpkRm9mdy9jSi9J?=
 =?utf-8?B?bnZNTTg1MGJLNUNQazluMkxIQ1JWdUdaMDhpUnY1SEUwenJLZmZOQVlmbXRX?=
 =?utf-8?B?aFVFWjdacHJweHh4YlBPR1hXNExlM3oxQVo1c09aZFYyRlhVQTloTC9sSjYv?=
 =?utf-8?B?SWpsMVQ1dkREVmxzS3Yzb3R1NGhrUkNCRnV3d1AzaWZ6emQ2UUtsU1JTR0JQ?=
 =?utf-8?B?QkFsTUNJQ0MyN05qVTBMdG82b3pyRDJmRkRxM3JWMll6TWlxbWJrZEVsY05a?=
 =?utf-8?B?SzlSem5tbElNNjZJZGdGRWtUdjdhdzA2R3JvVU9ITGNPeTkwL3BYSE9FVC9B?=
 =?utf-8?B?anFzSjVtUDdwcWxrQWlCQ0VPSk9EN0dScTFKdVQ5QkpaeVY0d0hRSmI5M08y?=
 =?utf-8?B?blpMZy80cHlwYjhvUlNidXEveWk0c1lzWDQ1OWtZRkZPR044RVBhbTdHTHFX?=
 =?utf-8?B?TldreXFtN1dMak44azMwZnVrRnh3QWdNWlVEWFJaenNNOUNjc2lHUDV6RXdo?=
 =?utf-8?B?d00rb0M1dDU0bmNvTTNxcmYrZndWUlRqbWd6M1FrNk84WXhxWTROSkRLMDNu?=
 =?utf-8?B?Z0I4ZTFITkhBMVJ3Z2t3VEZtdkZaYmdoeWxISCtnaXZpWjdEZXNWMnY5SkpY?=
 =?utf-8?B?OTRrZFpOMm5LM0FDNlQ3UkJKVWoxeUd1NlV3UE1ESFFVdjUzWG42YUdmeUFH?=
 =?utf-8?B?N1ZxOGlWR1NoQys5Z2x1OVorMUJDdU40WUU1SEFOYWV1WnFNMTg1UzJsQWJP?=
 =?utf-8?B?dm1zcy90SVhhZkVRNys4ZldHSExsWE40eWE0L0JISEIrRHkwOHo3Q1dFYitP?=
 =?utf-8?B?NVFvaXFnaHdxRnZUWEZ1ZnhFOTZ5TmV0em5YSlpnL0tGVS9uR2RLVGdKYnlq?=
 =?utf-8?B?dTBjTXExRy9BPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QzI4V2hZcjQ2enExa0lpTS9UZjJDZ3daL2RzcnlvcFpLbkpDUVpYOTRDMjIr?=
 =?utf-8?B?aVdTTEdIcFdMSE1UKzVBUHpOb2E3cDdyb3BONUtDRVc4RUlRenc0OHFPREEw?=
 =?utf-8?B?b3FwcHE1cjY5T3UvNy9QaERaaFV4UDA2anpyMnp6a0s4T09DVXhVdVhVZ2pz?=
 =?utf-8?B?dlRNaHZ4MEEwWHdwRFllcmRxemtyazB4Q3dFTUs3Tm5veDR5SFRLaTgxbUlj?=
 =?utf-8?B?V2NXcS9pZGM4R3pLKzhNYUd0dmtkait3YUFtZDIwbWE2bkk1aGFQNEl4aHVr?=
 =?utf-8?B?Qkp5dDZDUllPRXFmSVNMdjFQVlFMQ0w4bjl5cEgrM1QvSWxaSWUzLy9qRlBk?=
 =?utf-8?B?allOL1ZFOWxoaUFvdTR5dXZjWnJJQVpLWS9UOE9kSHZ6dWdkYjJLWGJBVExY?=
 =?utf-8?B?STNjUE9NcEp5cWJwbUxqU3hmY2V6L21rN3RaelFTcGVVNUJsMFlNb0hBRU1F?=
 =?utf-8?B?ejNlL3FzbUU0ZnBSZmxaS2VzeWpFREpJV1ZKUlhDYTVvM28rTUxzM3kwaW51?=
 =?utf-8?B?TjE5UE1abTdMdUtHSWwxWXpHampyRHBEd09rWVB2TGE3djhoOStxRHBGZVhl?=
 =?utf-8?B?eGNwZHVMSkFmYXBJN2hhT2M4R2c0NmRWTkVlTnVyY2sxN0xLSG9DTUFGa1pu?=
 =?utf-8?B?aXRQWTN3ZHZMVWRDT0VtZmEvZUg4b2lDRjZVMWptRmJGSTRnTTVOaWtKc3hv?=
 =?utf-8?B?R1h5a1kwaGdZNlFaMStWWWgrbGQ4eFoxanY3Rm0xeittNEJ3ZVlRN1BuWkFZ?=
 =?utf-8?B?emp3Y1dFWWw4cjBPTGRBeTJ5VkoyVG50VjdZZkdUQkhWNmUvNDA1aDZlWmVS?=
 =?utf-8?B?cytsN2xPclliTzVLWVZlV2E1VFJtU1p2Z3o2Q1VqYk5PdHVGM0tBNFlxUWZI?=
 =?utf-8?B?cnNkUExtY1dFZUdKazRmaC9VSThuUXNBamZ2eVREcWhkbUJ5NHM3VHc5VTNV?=
 =?utf-8?B?R2tBd2FlSXBQcjZxNzZObUZobm8wcHZHR3VxUWFvT2pIeWN5VWI2aFVTNzJn?=
 =?utf-8?B?NmRqNW9nRlNSdnY0am5aaDRud2QyM3BvTklwWGZZNlpuM2NKc2dxT0dCamg0?=
 =?utf-8?B?MGlhYVNBZDJmeHBSNDRvRk5XYjZZVlppdy83WVdCdEFUbE1XQ25EWE1pRkVJ?=
 =?utf-8?B?Q28yOHBtR1pxRk92UEdVRHBpL0svQ2xLSko4dTYzYXNaMUpjL0ZrQVFOYis2?=
 =?utf-8?B?ZUJHY1oyUytPMDBEd3FnL0ZjenFUb0drS1RscnBWYWtNWFdPTkMrbGM0a0Fm?=
 =?utf-8?B?K3lmVklFbkpzcUV2cGNZMFJ6VFkwbm1kNFpWYlZIV1pnKy8rdVo1QndrZ3ll?=
 =?utf-8?B?RENZRWJsZ1ByUndaZlBDQmRnM01OZGlYMmw0S3d6N0Z3MXc0LzBkVTlab0t2?=
 =?utf-8?B?K1NwQkt2NXNPVTNNYUpIZkc1NmRqaDd1TFpXYkVUdnR3cjF6K3lGV0pJWGcy?=
 =?utf-8?B?WGhHNUR0QWI0M3hKWmhTUmE2amVuK3hpQW9vcFJFL0U4YllIdXNLSE9GLzkv?=
 =?utf-8?B?eWdSM3NtZjZhZlMzUUtpVzllUmJtd0l6MHVlcGRHbTNRS3E1RTJNVW82QVhG?=
 =?utf-8?B?SUluOElyZ3ROakI1dkdvMmRiUHpDbzZGTFpEbEpiN2Q1aFhUZXh0N0FZUnlr?=
 =?utf-8?B?Vzd6OVA3WUUrS29xNGV3ZHV1ZUFCSTFEVEdiZHIxUTVwWFJwVjJlUWF1YTl5?=
 =?utf-8?B?dlh6ZVBmSytzWis2cHlUZWw3NlhEbThGTjNFYklpZzk5dFROUWwrNUNUQnV3?=
 =?utf-8?B?akoyM1pNQW9ET3VTeFA4TnhVWER5RFcrUEJIWkJZNklZeFVIN3krZzV4S0oz?=
 =?utf-8?B?ZEtoZ0dRQkFrakVtN3BDWFFSNzBUNnBOSTFkZ2I2Zk54NDlqUVFwTmU0VHRR?=
 =?utf-8?B?ZFVSbmoxd3VHU1JTZkduUEYzeGpveWZuNXJMNjhrLzRUdmEwZFNPNHBuSE9k?=
 =?utf-8?B?ZFdFdU1hWDI5Nk9ydGFRY1dSaTJwNnFWZWQyYzhpUkVYRG9tTHNDUTdKS1Ex?=
 =?utf-8?B?MnR2NUJPSmM4UVZ3ZWtiYllkWDEyV3hlYmJBSHdvUkJsRkUxZ2lySzRqOVBU?=
 =?utf-8?B?OEI0NnRDNFhDWm5HRjN2UFMrOC8vY0xPK3ZTcGZMN3dTa055NXdtc0t2TUlj?=
 =?utf-8?B?ZkdVdjNjdE5XVGZhdlhrQzk3MmYzQjJtNmFIZGZFOXU4bXpwdjYxaDh6dXl5?=
 =?utf-8?Q?oxyIvPiFuGlK3tVhLKYVt3s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F796732F8B20E4B8DE83FD8ADB5213B@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e4102c31-a19a-4035-3b64-08dd876541c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 21:31:52.1165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pMXqalmle06Dew7tyNokQ457ycYWpgykoY/n6F9AmdFf/p6On4/k0uHvx0F2ihelMCaNQVF2LWkSCusa+06e5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5244
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDE1NiBTYWx0ZWRfX/bEADdvlqflj dOKgcl0FrkGJghj3K2QoxiXnT7FdCOAjGN2yExrOOlqODs8KpKkgIWRhkP0HyISqflXL1wHBMU6 iOOO+6HNV1u572fy70/L7rQAH0J+IMrfrUgmmXMAhq+XuZY9btJuGFfyO+lL5ZWeMV8jW8o9jS0
 PW/VUeOG1Jsq4p0wlDpcjpv+ppLR4GhlfmmV7hdh5kVy3HwMORcOdlz8U1Xgj8oInNbZz3jOTwb QkvZHKe0gUwPXvdp2Q3Oh75KXAFqq2wzkP2djJqtAQUcEwugpv1i5e+ZOCrWwojYu0DqpCHhxnE 4ckJUB139HQzl5Q3+ccdBo2+cUUmD8nvVkeZLzjIp1ryFxIzP7SLSvA1WvF/uYAC3JEMu4iABAz
 GZmxKNYtjzU0ob45qF0UV+Wc1t96c6Q/UKiIwhJMSQX7ax6GUn3QKftqe8Kd+EF8GCg74OGd
X-Proofpoint-GUID: fRHGq9bfIcjV-nxlX8TXwyZ3WojWw4x5
X-Authority-Analysis: v=2.4 cv=MJRgmNZl c=1 sm=1 tr=0 ts=6811454b cx=c_pps a=ztkV8ooph0rfw1Th5QLTnw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=1WtWmnkvAAAA:8 a=DezlAfEPzcrEmUD8TVsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fRHGq9bfIcjV-nxlX8TXwyZ3WojWw4x5
Subject: Re:  [PATCH 2/2] hfs: fix to update ctime after rename
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_08,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 phishscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290156

T24gVHVlLCAyMDI1LTA0LTI5IGF0IDE0OjE1IC0wNjAwLCBZYW5ndGFvIExpIHdyb3RlOg0KPiBT
aW1pbGFyIHRvIGhmc3BsdXMsIGxldCdzIHVwZGF0ZSBmaWxlIGN0aW1lIGFmdGVyIHRoZSByZW5h
bWUgb3BlcmF0aW9uDQo+IGluIGhmc19yZW5hbWUoKS4NCj4gDQoNCkl0IHdpbGwgYmUgZ29vZCB0
byBzZWUgd2hpY2ggSEZTIHRlc3QtY2FzZSBmYWlscyBpbiB0aGUgY29tbWVudC4NCg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBZYW5ndGFvIExpIDxmcmFuay5saUB2aXZvLmNvbT4NCj4gLS0tDQo+ICBmcy9o
ZnMvZGlyLmMgfCAxNSArKysrKysrKysrLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNl
cnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2hmcy9kaXIu
YyBiL2ZzL2hmcy9kaXIuYw0KPiBpbmRleCA4NmE2YjMxN2I0NzQuLjNiOTViYWZiM2YwNCAxMDA2
NDQNCj4gLS0tIGEvZnMvaGZzL2Rpci5jDQo+ICsrKyBiL2ZzL2hmcy9kaXIuYw0KPiBAQCAtMjg0
LDYgKzI4NCw3IEBAIHN0YXRpYyBpbnQgaGZzX3JlbmFtZShzdHJ1Y3QgbW50X2lkbWFwICppZG1h
cCwgc3RydWN0IGlub2RlICpvbGRfZGlyLA0KPiAgCQkgICAgICBzdHJ1Y3QgZGVudHJ5ICpvbGRf
ZGVudHJ5LCBzdHJ1Y3QgaW5vZGUgKm5ld19kaXIsDQo+ICAJCSAgICAgIHN0cnVjdCBkZW50cnkg
Km5ld19kZW50cnksIHVuc2lnbmVkIGludCBmbGFncykNCj4gIHsNCj4gKwlzdHJ1Y3QgaW5vZGUg
Kmlub2RlID0gZF9pbm9kZShvbGRfZGVudHJ5KTsNCj4gIAlpbnQgcmVzOw0KPiAgDQo+ICAJaWYg
KGZsYWdzICYgflJFTkFNRV9OT1JFUExBQ0UpDQo+IEBAIC0yOTksMTEgKzMwMCwxNSBAQCBzdGF0
aWMgaW50IGhmc19yZW5hbWUoc3RydWN0IG1udF9pZG1hcCAqaWRtYXAsIHN0cnVjdCBpbm9kZSAq
b2xkX2RpciwNCj4gIAlyZXMgPSBoZnNfY2F0X21vdmUoZF9pbm9kZShvbGRfZGVudHJ5KS0+aV9p
bm8sDQo+ICAJCQkgICBvbGRfZGlyLCAmb2xkX2RlbnRyeS0+ZF9uYW1lLA0KPiAgCQkJICAgbmV3
X2RpciwgJm5ld19kZW50cnktPmRfbmFtZSk7DQo+IC0JaWYgKCFyZXMpDQo+IC0JCWhmc19jYXRf
YnVpbGRfa2V5KG9sZF9kaXItPmlfc2IsDQo+IC0JCQkJICAoYnRyZWVfa2V5ICopJkhGU19JKGRf
aW5vZGUob2xkX2RlbnRyeSkpLT5jYXRfa2V5LA0KPiAtCQkJCSAgbmV3X2Rpci0+aV9pbm8sICZu
ZXdfZGVudHJ5LT5kX25hbWUpOw0KPiAtCXJldHVybiByZXM7DQo+ICsJaWYgKHJlcykNCj4gKwkJ
cmV0dXJuIHJlczsNCj4gKw0KPiArCWhmc19jYXRfYnVpbGRfa2V5KG9sZF9kaXItPmlfc2IsDQo+
ICsJCQkgIChidHJlZV9rZXkgKikmSEZTX0koZF9pbm9kZShvbGRfZGVudHJ5KSktPmNhdF9rZXks
DQo+ICsJCQkgIG5ld19kaXItPmlfaW5vLCAmbmV3X2RlbnRyeS0+ZF9uYW1lKTsNCj4gKwlpbm9k
ZV9zZXRfY3RpbWVfY3VycmVudChpbm9kZSk7DQo+ICsJbWFya19pbm9kZV9kaXJ0eShpbm9kZSk7
DQo+ICsJcmV0dXJuIDA7DQo+ICB9DQo+IA0KDQpVbmZvcnR1bmF0ZWx5LCBJIGNhbm5vdCBhcHBs
eSB0aGlzIHBhdGNoIHRvby4gQ291bGQgeW91IHBsZWFzZSBwcmVwYXJlIHRoZSBwYXRjaA0KZm9y
IHRoZSBsYXRlc3Qga2VybmVsIHRyZWUgc3RhdGU/DQoNClRoYW5rcywNClNsYXZhLg0KDQo=

