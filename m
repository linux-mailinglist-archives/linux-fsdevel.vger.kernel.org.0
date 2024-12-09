Return-Path: <linux-fsdevel+bounces-36788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 538009E95F9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 14:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82BAA1888986
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 13:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7FB229B31;
	Mon,  9 Dec 2024 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="viXntvMq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32FC22ACDF
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749611; cv=fail; b=HR2m6dptD+w/OMe2Rr5z374AUhQrtb6vE0J8HMl16UkQIwblwLpDeLD/hIrcOM/YAyQ07dqPblgiEb0Ej/soO3h+7ginAp/BzfmS2lpaROyC3xrq6NYHpEW63+7w2jXpZWlbnjQYsEE1bipwDoIF09prKPw7V4/BSAOoVK6hhhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749611; c=relaxed/simple;
	bh=khDuFK0VMpPEkKSDbbk2axhDfAQG0CqnyQWwf6pKD+8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LieaCta6rF5YLxzrcoPA0tQ6kdAC7aodZP3hXG4apHXMFAK/pK79uk0gQiSHabO2mrxYycta08yRBBB+ipY2tjGR+OACXv/614FVtIi1JjH2kn1TlepdJYPHy67lYaxR7LkdTTGofUlrVyiEWIEdvGOyEp5GbZb5k7YSu3ZZKYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=viXntvMq; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169]) by mx-outbound11-132.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 09 Dec 2024 13:06:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAVmnmBs0cnqlvBLoQJAdnFdzroC54KpfYvgQ/wdUm2RnzEpVYKdiHT+G6Bvq8RYT4Q5bUXGg6iSRwaQS4vpfVWnqKVQ71TADRNDMeqadlvU7PPeOZa3l5e0G2Z2NyVab58FwTH9isOI05QTplFaD21T7ABXH2/cP+TnVemFA+DFDcoAJiOtzCI6ViNdYVpb3JfKVeuogtv2A3n0KeyT8iapCt0AFSXTIN5PHscB9UGUzAyZcrFyk+QSROBZLjnvHd0ec4MwSIxRM66As3gJ1UhYUi05aGUdADKVYpc2VzNlo2E2BPyz3YGDa/AcKBNADfzuW52gbhF3IaKwghrL5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khDuFK0VMpPEkKSDbbk2axhDfAQG0CqnyQWwf6pKD+8=;
 b=hii+UIZJNj6AGwPcY4ltB/lWIQqOFdsPVEz66VQXPmRQpQdKTJPCeN4bJZa4NPN1GKxQ1wahuF9zgczIz8kt2PQxh216GtdZEsqgeylDtKV5/NoH9WRLbJiegOdYoeVWiixRvLs9XDTIaS+WUxEmzdiUcGa8ERREl5xoKaEl3WrtKs7IIiVNpNBL0xViz3ee3xKfnmwz1NwHN6VXGfnGYGJ9hsQ8il0fDGucYVg3ECvBVwFBRW/vT/i8YtCvlK8ZHPh6RfBRvEewawLuk2/gsLiejVEvuRSvxTt3/vsY5Xs1pJUX9XxKk9cdijNBQg4NQ5DrmIqMI3K6TTOM2WpIxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khDuFK0VMpPEkKSDbbk2axhDfAQG0CqnyQWwf6pKD+8=;
 b=viXntvMq77sAsThjjz1UB50KKBryDMgo3nBR8RT/dNHxsYERrx8MiAF6hn804+YoIG0NRa0dCyB11DLeBMZjp+VlTgR3mHB8LtEzHrCwhnPnnWwmvgta0YsqnZCJW08hpnjfHHPJbfLvcx1MWy59OTIPdztFXGhXUJSGWJ5FB64=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by IA0PR19MB7726.namprd19.prod.outlook.com (2603:10b6:208:3de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 13:06:06 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%3]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 13:06:06 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: =?utf-8?B?TWFsdGUgU2NocsO2ZGVy?= <malte.schroeder@tnxip.de>, Bernd
 Schubert <bernd@bsbernd.com>, Jingbo Xu <jefflexu@linux.alibaba.com>, Matthew
 Wilcox <willy@infradead.org>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Miklos Szeredi
	<mszeredi@redhat.com>, Josef Bacik <josef@toxicpanda.com>, Joanne Koong
	<joannelkoong@gmail.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Re: silent data corruption in fuse in rc1
Thread-Topic: silent data corruption in fuse in rc1
Thread-Index: AQHbSd2tPKT9JardZ0KBiPxLEQEidLLdd3CAgAAXZgCAABDpgIAAQruA
Date: Mon, 9 Dec 2024 13:06:06 +0000
Message-ID: <29ce110b-aa47-4524-a038-8fd2c8e2978a@ddn.com>
References: <p3iss6hssbvtdutnwmuddvdadubrhfkdoosgmbewvo674f7f3y@cwnwffjqltzw>
 <cb2ceebc-529e-4ed1-89fa-208c263f24fd@tnxip.de>
 <Z1T09X8l3H5Wnxbv@casper.infradead.org>
 <68a165ea-e58a-40ef-923b-43dfd85ccd68@tnxip.de>
 <2143b747-f4af-4f61-9c3e-a950ab9020cf@tnxip.de>
 <0d5ac910-97c1-44a8-aee7-56500a710b9e@linux.alibaba.com>
 <804c06e3-4318-4b78-b108-12e0843c2855@tnxip.de>
 <0c7205c3-f2f2-4400-8b1c-3adda48fdeab@bsbernd.com>
 <77b6c012-8779-4bf8-a034-11b9ee93d1fb@tnxip.de>
In-Reply-To: <77b6c012-8779-4bf8-a034-11b9ee93d1fb@tnxip.de>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|IA0PR19MB7726:EE_
x-ms-office365-filtering-correlation-id: 4d64344b-5acf-4c73-1ddc-08dd18523e0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YUxkbURmWnBXN1ZiUzhDdGFBMWlTSlREMTluUzVqckNRMzRIQWREcCtsaFJW?=
 =?utf-8?B?VkpiVFJGaHJaTTh0RXVCNnFUOTlQUXVvdkdzSHNhUjFPZ0czQmdjWTQ2NzRi?=
 =?utf-8?B?R2ROQi9qZ21sd3JZNllUQTVrR2ZSdlVibnJhMGNZL0lQdm1CanlkUGsxa0NQ?=
 =?utf-8?B?bFI1WDY0bENhSHRha2pRbVJyNlZYM0FpRkRMclc2RlJHUDNTYXhyWWxweHgx?=
 =?utf-8?B?LzQxVCtRQ1dVck5yWEg5aVNzcStHbnFIdS9NOGlocnZiUzk1ejUxcmRkakVq?=
 =?utf-8?B?MEtPZzJSZ0xsSVR6NmNUM00zc0xuQ0JJNTJkWm50THZVTWxFTFFnREpOMnZk?=
 =?utf-8?B?Nmx3RE9HcWZ2aXo1QW4rWHBibm9QcUtFalArbmcyYTZCVWpEZmRmQlh6ekRG?=
 =?utf-8?B?NExPTzdNMHRLVnQ3NWFjdkNwcGVzWFB0RkFFcmdJSERsSlBzK0NKYzBrWWNo?=
 =?utf-8?B?K0M3NnpQRzlzYTdlSG8rVWFSWE9FZlVNNHlJSVB1Vld6TFFzK2lFZHNxbkdX?=
 =?utf-8?B?TTlTQ3VtL2tSQnd1V2M4ak1rTzZ3TFNUVXR6UzBtL3pXMGg3UmVXZnNNLy9I?=
 =?utf-8?B?R1RFV2VrL3M4ZVBiV2hEOThReVRSK0kxRm9aeTZpd0RzUFJDZHVOSWtYdzNE?=
 =?utf-8?B?VlJENXFpMUpEZGk1aGRvT1pvaFdOdU9LOE5PNkQwZXl3eVBEMDVzUS9VZUVM?=
 =?utf-8?B?L2xNZGlOMmRTRmk2TjBocUgxN0hTTm0vaGpPaUxCR1NDaEl0UDJ6eDhKcUVi?=
 =?utf-8?B?MzhGVEFhNTB4UGtXM0NVV1VaQWJBMVoyOEx0ckV5dnhSbThUcmgxdzNXcGNl?=
 =?utf-8?B?V1lkZ2hjTHBWSGEvZCtsVXNLdWR6WTRXWUJVb0Y0YUVHS0x6aE1XNk56QThj?=
 =?utf-8?B?T0UvN25rK0toZjdHeFZOQTF3MkxFQ0hVT0JPdEM2dm5SSldZdXNWNU5YbkhS?=
 =?utf-8?B?OFh4bWxqMmtCZnlwWGQ2ZFZNVWI3bDBrMjZsYTZMak1rN1diZloxU0J0SDd6?=
 =?utf-8?B?UTFFcTFHclg3M21vcXBtQnNZWmNNZVNUdE5FZlY0VlQ4MzZpZkFQdHlZZVcw?=
 =?utf-8?B?dVVSTTlaRVg5N1I5Zi9id3ZOTDcwaVJjRGZBZDBQY1dVZ1gveUh4d1lTMjhG?=
 =?utf-8?B?dE5UOGIvMEtqaFgyVkptamJ5MHZLRlB3cU5pYUV5VzJHNTVBTlFEOUhnOHNP?=
 =?utf-8?B?amtUMWc3NWJQWVY5MXIwZ0orYUlSbDF0VWtPbHVEL1daSWxrWWgvSFNtZ0p5?=
 =?utf-8?B?UmJ3amZTWEZkMGQxRzhDRURpMDI5bFNWbkZpckhpUGN1bnlnNWorSm5lTTNO?=
 =?utf-8?B?a0dVVTF6UEZpUmhSa2s0OHA1NEhKM2MwbUUrSUxQaXNDSy9DRGtuNGxGU3NO?=
 =?utf-8?B?aUlOODRYVmJ4U2hQcVdCZWR3WGFzalVCcmo0OTMyVUpUSVZ3aDhIUGR0UEFn?=
 =?utf-8?B?L082S3plendJak45ZFd3ZnpWSTVSWnIrUnZ4NjNLUFlXNnpLRG84WnRZcm4x?=
 =?utf-8?B?NEc4aDlrVFViR2YxMkhXb1Q3T0lmaXpuT0hhOXl3RXdSQ0FjMGROQllGU25J?=
 =?utf-8?B?c0I1b1pPQkdEU0ZZbS8wL0tQNDI5dE9QVkVBQ0RqR1EyY3FVcEhnT2tNWXUr?=
 =?utf-8?B?V1o0azRJVWptVTV3V1ZLeFloclIwcUNmanVvYmtFYXNsMzA4V2U0VGFlY2N0?=
 =?utf-8?B?SnpqQytIQnl0Z0RQc1lxRFJ4aGVpcnNtVHJQQzBHaitBeVJFdDg1aGNCbHN0?=
 =?utf-8?B?SCtaVXlrSkhweVBQS1JENnlzWU9ZdFRjOVljWmIrZnFZUGs0bGQ4SS9HNnVh?=
 =?utf-8?B?ZG9OZElrcDVPbTlPK2Q0akRmNzRMRjFXWTNLa0NvaEpxQTNzSmhxeWpWRkwv?=
 =?utf-8?B?YktEaXFHeVNjTWRFOGtNbmhhVU9WRmRwcHN6WkdRbUtYcmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bXRMUVRDUFdKVmVBNnNUM255SnJwb1llR0ZsT3dXY0p0bDFtQkgvWkxQbzNQ?=
 =?utf-8?B?REVnUFBUaHFoVUIwSUhhMnZEd0ZVaGVZbUpMMGxEQ0EwOUIwY1BMMlpkdHJB?=
 =?utf-8?B?cENNZE9QTUl0T3Zpd3ErcGRLMzhqQStPay9HbS9jVnZFV0N0UzJiZHFKRTdU?=
 =?utf-8?B?NVl5U2VkTGo3cUs2ZW8vK1hGcnR1VERDMVl2cGc0azVRTzRjWVNiUEtNaitr?=
 =?utf-8?B?Z2pjbGc2clg0SmtKZmdJdWM0c3lMUldOMURLN3d0UUtqWUFXMnU1YXNwMGw5?=
 =?utf-8?B?UDIweDJseXZnRFc4YzA5enJBUjhvRDdsaWdQVGxXUjcwNmY0QnM3NzJ0RGha?=
 =?utf-8?B?a0xreDhWR014VHNnSHZQeU5QbytFaVIrajd4cW5MRkd5MlRuVFVBNUVkNXcz?=
 =?utf-8?B?ZjN1T1dtZS9TZllackxCWU16eTFVaWdpalRUbk8rVmdRZW9VUjh0U3crQk5t?=
 =?utf-8?B?KzFpVUJUTmdCV2lrWGkydDd2QWoxUEZEUmhVWDFsb0kySWRRYUVpOVhoMWVl?=
 =?utf-8?B?cWlpNmdMOTdIY0YxaFA3UVloQUFaMmVPbFMvbkVhU05pL3hiYXhqZnUvUHl5?=
 =?utf-8?B?WkoxMThPSTJLMzFyT05EL3ZXTzA2cmNQMXZyYmVCVVJsSzhIZktuOXNBdlBk?=
 =?utf-8?B?ZzZPUHl6R3BWN2o5R2NRZGhjRmhOZS96WG1pdzBHUDN5SjFXODZrZ2l3cS92?=
 =?utf-8?B?cjhXK3dISjFoTXVCbEFZc05HUU1zc2FYcDFCazJJZGZ4ZnhLalV5UUJRWlhl?=
 =?utf-8?B?Y3ozTzBFOWJoR29kMmt4aXAxUDJHeUtMRU1uL05ibDZqb01NcldIY3JHOU8z?=
 =?utf-8?B?dlcybmJTdnliaDNsR0dRWVBJMktPOU9Ic2loYkVzcVhNVHVUQWZPNkZwVXZS?=
 =?utf-8?B?TlBJUmo3eEJ4WU1lQ0tTVy9mRWUzcTlPSzR4Ly9Fekl5NmlwWHN3S1VMdEpG?=
 =?utf-8?B?S29SWWxQa2ljWVVlTnVUYjkxY2E2ai9YbWx0YmE5bTBiVHZLOWh4MThCaFNS?=
 =?utf-8?B?cUdZeHJXT0dUdUJQay9XL0tlZ3NBNjl6V1ZJNnArUlVSRlRiVUtwWkYyN3BQ?=
 =?utf-8?B?TVhwUUlsKytiT1h6dmVSbWpJYXhpMER3RXF6Y0hsT1RsUzVJR2VOOW4vU05H?=
 =?utf-8?B?WFZzTW9vem0wSzE4WEx4TmxUZU5DMmgvTnpTcmE2NFlhbkFwN3l6T3BISzJr?=
 =?utf-8?B?N1NiNU9pOUdPUko3cXRYa21nN0VZT0F5TGNGL3hnSXpkT3E3TGlRUHdEWUpu?=
 =?utf-8?B?SmtFRVZKT3pxOHMvUWt0OGtnbFVZYXVNNk4xeDV0UVVsK0pQdlQrRXNPK2gw?=
 =?utf-8?B?MEJUa2JVVUxJaW13YURNandtNDhtTnVPM01EempneE9hTktocCtZZXBxQ25G?=
 =?utf-8?B?eUVpLzN0SGZGcjZCY1Z4TVlsVGZpblFjWjBiMGlUZ1FTV21OaEl1ZlBuRU15?=
 =?utf-8?B?aWFQUk5MaGJNL0x3ZHc5Zk1TZW5LcGppL1pGT1JxVVJzc3pvU1Q3ZnJJNWps?=
 =?utf-8?B?QmJBYisyc1RpN1h3SjFGeUdlR2g2bGVQTFoxa0hQMVRVemNWWlhEdmtpcHNo?=
 =?utf-8?B?VzVNVDFsTXpVeDdWamFQckRIQm81TDlPcmJOM1VIMC9neDY2dzE4c2RjMCsr?=
 =?utf-8?B?YXJlZWNuL0FjZFllVjBabFg3a2RsL1R0dFlIZ1pZOXYxYS9hOTBObGZ2Tzdy?=
 =?utf-8?B?T0RNS2FXa2d4UThBTlpxVzVGeWF1SEYzbDNtb29DK2gzZEh0ekZsRSs0T1dU?=
 =?utf-8?B?bVYrbU5wZ1IySi9uTHJxbmo4OE9JMlRXR1JLQjh6V3l1d21OVy9Wa3R2MUYv?=
 =?utf-8?B?djNxNzZzY3ZFajF6VXZybWpBV2JNVzNiMFJHTEFXcERvaTltcUxYbFNkZW5a?=
 =?utf-8?B?aVJMWmlXVmthZXpiWFNrV2RrL2NjTFN1Tkg0RVJJdkM2OXdyVkRBRmdHN0My?=
 =?utf-8?B?cDdtZGtVMnMyTWViWlJFNThoTEpwOE14dWdsVFNCeW95MUdkcXdmMUZBZjhN?=
 =?utf-8?B?RWI4cndJM0JKaVpBYXJiODhPUEM0bWsycklQNy9NSE5UOXk5bXpDajl0K1hm?=
 =?utf-8?B?b1NXM0ZnQ3BRanNXbldnV1loYVkwcWxQUWNTRlUrY2szdURXSGVYbnQ4ekZX?=
 =?utf-8?B?TEwrRlBGN05HM3dGbGt1QVpyZEQ2TkdrcmtuLzZ5YWdvVWFpRy9hSXhlWmR1?=
 =?utf-8?Q?oNQ6hABluP4cbrO1IvTOkq8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D16C3E5176AAE428F1CCC18759B0633@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GcoVJjKz486ghQrctVMDPjBCMGu3XWicxVXRqsTba2S3ZgNs9aHFCugszBAeIsyVFHerR+YnSlljs4xRBoar+gZ/u4x8wbnFVOTr8t658CODQUkPQLBKsV+XVYcg+BxzTsocbtVfDIWIjm3KvuYdQ2Vc+hbsioL3dCMFjOQP3HiBdU5ruKjbu9QkeBak420bft68LKU3bUA5WaRS73B+6Ui/mcmksyvUErpyMzI54lERj5UVr2wsCMcD2cSyOVzxD56wDl1myAHB2TPRcvuYfKcTwxtU5IWF5KLLNJo22L6hfx2LRaHJIbprCfgw9qVYC6J96anCSnYzyf06PQW+cN5IO/qoByVkqkUlIVcvd58G5LeqnUGSEYUkIZlObPSNeJGF3R0WXsteID/ZEgV/4nPU6Z+g1Vxr5La9ygTX8eBhJRM+pLBk1XEN/atr7RtXzvIoaGpTyRdGr1oMpV6hEut3XGWk7iZ4fCZXKl+idfEIwFfq1oSJEF8KoDpE/Im3P+9mHXr525s/Hxc4BhX95K5vFiwM9VVkbtxgazdWwfg4Uy5wMlSmgzXfr55LASIwFmo4joSq4ZkPLZY3LQk/qPMuqXj52LFOXJOyaYZK/YX+Ueuwi0xxe6RBNJ0VS5lL3aRbuA75186wPVB/iCqA1Q==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d64344b-5acf-4c73-1ddc-08dd18523e0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 13:06:06.3449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Oy1vI6wkZririgvQr/iHnEo0UqEr/1LX3BHWiAJcICGU+xh5B9DJqhh+iD9wfPrZalI7pGb7hw9/Hc9CUCLjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR19MB7726
X-BESS-ID: 1733749570-102948-13346-558-1
X-BESS-VER: 2019.1_20241126.2220
X-BESS-Apparent-Source-IP: 104.47.55.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkamBpZAVgZQMDU5yTLJKMUs2d
	ggxcjYPNnc1DIlxcDIwNTYyNgo1cJQqTYWALpXzSpBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.260995 [from 
	cloudscan22-134.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gMTIvOS8yNCAxMDowNywgTWFsdGUgU2NocsO2ZGVyIHdyb3RlOg0KPiBbWW91IGRvbid0IG9m
dGVuIGdldCBlbWFpbCBmcm9tIG1hbHRlLnNjaHJvZWRlckB0bnhpcC5kZS4gTGVhcm4gd2h5IHRo
aXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlm
aWNhdGlvbiBdDQo+IA0KPiBPbiAwOS8xMi8yMDI0IDA5OjA2LCBCZXJuZCBTY2h1YmVydCB3cm90
ZToNCj4+IEhpIE1hbHRlLA0KPj4NCj4+IE9uIDEyLzkvMjQgMDc6NDIsIE1hbHRlIFNjaHLDtmRl
ciB3cm90ZToNCj4+PiBPbiAwOS8xMi8yMDI0IDAyOjU3LCBKaW5nYm8gWHUgd3JvdGU6DQo+Pj4+
IEhpLCBNYWx0ZQ0KPj4+Pg0KPj4+PiBPbiAxMi85LzI0IDY6MzIgQU0sIE1hbHRlIFNjaHLDtmRl
ciB3cm90ZToNCj4+Pj4+IE9uIDA4LzEyLzIwMjQgMjE6MDIsIE1hbHRlIFNjaHLDtmRlciB3cm90
ZToNCj4+Pj4+PiBPbiAwOC8xMi8yMDI0IDAyOjIzLCBNYXR0aGV3IFdpbGNveCB3cm90ZToNCj4+
Pj4+Pj4gT24gU3VuLCBEZWMgMDgsIDIwMjQgYXQgMTI6MDE6MTFBTSArMDEwMCwgTWFsdGUgU2No
csO2ZGVyIHdyb3RlOg0KPj4+Pj4+Pj4gUmV2ZXJ0aW5nIGZiNTI3ZmMxZjM2ZTI1MmNkMWY2MmEy
NmJlNDkwNjk0OWU3NzA4ZmYgZml4ZXMgdGhlIGlzc3VlIGZvcg0KPj4+Pj4+Pj4gbWUuDQo+Pj4+
Pj4+IFRoYXQncyBhIG1lcmdlIGNvbW1pdCAuLi4gZG9lcyB0aGUgcHJvYmxlbSByZXByb2R1Y2Ug
aWYgeW91IHJ1bg0KPj4+Pj4+PiBkMWRmYjVmNTJmZmM/ICBBbmQgaWYgaXQgZG9lcywgY2FuIHlv
dSBiaXNlY3QgdGhlIHByb2JsZW0gYW55IGZ1cnRoZXINCj4+Pj4+Pj4gYmFjaz8gIEknZCByZWNv
bW1lbmQgYWxzbyB0ZXN0aW5nIHY2LjEyLXJjMTsgaWYgdGhhdCdzIGdvb2QsIGJpc2VjdA0KPj4+
Pj4+PiBiZXR3ZWVuIHRob3NlIHR3by4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gSWYgdGhlIHByb2JsZW0g
ZG9lc24ndCBzaG93IHVwIHdpdGggZDFkZmI1ZjUyZmZjPyB0aGVuIHdlIGhhdmUgYSBkaWxseQ0K
Pj4+Pj4+PiBvZiBhbiBpbnRlcmFjdGlvbiB0byBkZWJ1ZyA7LSgNCj4+Pj4+PiBJIHNwZW50IGhh
bGYgYSBkYXkgY29tcGlsaW5nIGtlcm5lbHMsIGJ1dCBiaXNlY3Qgd2FzIG5vbi1jb25jbHVzaXZl
Lg0KPj4+Pj4+IFRoZXJlIGFyZSBzb21lIHN0ZXBzIHdoZXJlIHRoZSBmYWlsdXJlIG1vZGUgY2hh
bmdlcyBzbGlnaHRseSwgc28gdGhpcyBpcw0KPj4+Pj4+IGhhcmQuIEl0IGVuZGVkIHVwIGF0IDQ0
NWQ5ZjA1ZmExNDk1NTY0MjJmN2ZkZDUyZGFjZjQ4N2NjOGU3YmUgd2hpY2ggaXMNCj4+Pj4+PiB0
aGUgbmZzZC02LjEzIG1lcmdlIC4uLg0KPj4+Pj4+DQo+Pj4+Pj4gZDFkZmI1ZjUyZmZjIGFsc28g
c2hvd3MgdGhlIGlzc3VlLiBJIHdpbGwgdHJ5IHRvIG5hcnJvdyBkb3duIGZyb20gdGhlcmUuDQo+
Pj4+Pj4NCj4+Pj4+PiAvTWFsdGUNCj4+Pj4+Pg0KPj4+Pj4gSGEhIFRoaXMgdGltZSBJIGJpc2Vj
dGVkIGZyb20gZjAzYjI5NmU4YjUxIHRvIGQxZGZiNWY1MmZmYy4gSSBlbmRlZCB1cA0KPj4+Pj4g
d2l0aCAzYjk3YzM2NTJkOTEgYXMgdGhlIGN1bHByaXQuDQo+Pj4+IFdvdWxkIHlvdSBtaW5kIGNo
ZWNraW5nIGlmIFsxXSBmaXhlcyB0aGUgaXNzdWU/ICBJdCBpcyBhIGZpeCBmb3INCj4+Pj4gM2I5
N2MzNjUyZDkxLCB0aG91Z2ggdGhlIGluaXRpYWwgcmVwb3J0IHNob3dzIDNiOTdjMzY1MmQ5MSB3
aWxsIGNhdXNlDQo+Pj4+IG51bGwtcHRyLWRlcmVmLg0KPj4+Pg0KPj4+Pg0KPj4+PiBbMV0NCj4+
Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQxMjAzLWZpeC1mdXNlX2dldF91c2Vy
X3BhZ2VzLXYyLTEtYWNjZThhMjlkMDZiQGRkbi5jb20vDQo+Pj4gSXQgZG9lcyBub3QgZml4IHRo
ZSBpc3N1ZSwgc3RpbGwgYmVoYXZlcyB0aGUgc2FtZS4NCj4+Pg0KPj4gY291bGQgeW91IGdpdmUg
aW5zdHJ1Y3Rpb25zIGhvdyB0byBnZXQgdGhlIGlzc3VlPyBNYXliZSB3ZSBjYW4gc2NyaXB0IGl0
IGFuZCBJIGxldA0KPj4gaXQgcnVuIGluIGEgbG9vcCBvbiBvbmUgbXkgc3lzdGVtcz8NCj4+DQo+
Pg0KPj4gVGhhbmtzLA0KPj4gQmVybmQNCj4gDQo+IFN1cmUuIFRvIHJlcHJvZHVjZSBJIHNldCB1
cCBhIFZNIHJ1bm5pbmcgQXJjaCBhbmQgYmNhY2hlZnMgYXMgcm9vdGZzDQo+IChXb3JrcyBvdXQg
b2YgdGhlIGJveCBvbiBjdXJyZW50IEFyY2gpLiBCdWlsZCAtcmMga2VybmVsIHVzaW5nDQo+IHBh
Y21hbi1wa2cgYnVpbGQgdGFyZ2V0LiBUcnkgdG8gaW5zdGFsbCBGcmVlQ0FELCAiZmxhdHBhayBp
bnN0YWxsDQo+IGZsYXRodWIgb3JnLmZyZWVjYWQuRnJlZUNBRCIuIFVzdWFsbHkgaXQgZmFpbHMg
dG8gZG93bmxvYWQgc29tZQ0KPiBkZXBlbmRlbmNpZXMuIEl0J3MgYSBwcmV0dHkgd29ua3kgdGVz
dCwgYnV0IEkgZGlkbid0IGZpbmQgYSBtb3JlDQo+IHNwZWNpZmljIHdheSB0byByZXByb2R1Y2Ug
dGhpcy4NCj4gDQoNCldoYXQgaXMgdGhlIHJlbGF0aW9uIHRvIGZ1c2UgaGVyZT8gcGFjbWFuZy1w
a2cgb3IgJ2ZsYXRwYWsnIGFyZSB1c2luZw0KZnVzZSBpbnRlcm5hbGx5Pw0KDQoNClRoYW5rcywN
CkJlcm5kDQo=

