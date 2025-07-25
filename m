Return-Path: <linux-fsdevel+bounces-56051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA62B12322
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 19:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074041CE4F78
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 17:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A452F0024;
	Fri, 25 Jul 2025 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EGnSMrmV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEC72EFDA4;
	Fri, 25 Jul 2025 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753465546; cv=fail; b=RFUUIE1v/yhB82ZfPLEatSV11Y9B/8cs6fIIwJnzd1GOb5y+Sx7VU4vB9hFGy1DWv9Rd4tG/mfWgfy6ba1XpWAZoEgufNXPOn/HVPdU76fv4hhU86ENumht7ANxBnmvPf+x0P2TXlw6XGiKnUwp0uVIr8MBj7OBFbmz+5f0pHKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753465546; c=relaxed/simple;
	bh=S/R1Nqc7ukEISnmHgc7LRw2Qiy3n5BKj/6CXajIbvPI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=LeoTBdHR49Amy9xrVlFi9gnaAkAowsUlLJbMlpKcIBnsAjfOKdTyPzVF/GxNl7tKXjMJMj02XQKiiHjiOcyyNjMemY3hN/puwcxZIEzyjIy/DTmWa3nE509nbobGC7ZGR5xx28dYQ0gLbKx+RKNP4/7XxXzb3A0rcZAi9eap+SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EGnSMrmV; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P9joEZ025441;
	Fri, 25 Jul 2025 17:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=S/R1Nqc7ukEISnmHgc7LRw2Qiy3n5BKj/6CXajIbvPI=; b=EGnSMrmV
	C/dHIZgJtrjZArYCxlSEju813hy5phczRjJhmLPthfce7hLkUnNmI9zP2JzVeVnN
	+SP2Nf7PIdFubRSR1PDdnfjjzE/Yn3Z1SyfnRfh17gnortq4uKL2xea5vncbq440
	FAYyDQRQOl/dQwA4NIZYeRgTrHy8m0D+I9xDarK3WfidcTbIZA/QcwOdYU79MxHI
	CxT8Fw0Ktb5JXzUuiEHRHI7JzGyOFfGYAN0AlrPpAG5KNKa2+k7hH77KX0UcdSUV
	LW2qAY9bOYq8yu1e4bspX2CTppSQ2eQsbxDwS+/IC4h78J6Iww16+z4d4TBvlrY7
	M82G9hsZxi7VGw==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 483wcjmdg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 17:45:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+EAKohnJX9RXBeTclNKwSMs/D0aTYhNbTiBiSmOWHVJmDXmMqdIhzaKfVgc3POCJsdIhkrUmeCU2K9w20+/rWhdIXICe6UdxDJKsOAgwSQ02lvf0pORCuCoaiSI7ijHIjmtfEf8nX9cf4QJS9FCZx1mUbrMIOOrhpjzcGOpFuPVDtSU5e7Npo7hwRzt4kevkIJzThINhRTDJu8QtQby6npTSgPolaIE8JY+I5bwCn+IvLQoYxBMYYF4vKmIX0xEYR+mYIM4VXsMBkZeam/k+FrWRP6b/TQfRBnVBk5F9p5A0CSPjl1cMsp9gwIimUMcCy3Nbh5X8sSBy4YdfApJFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/R1Nqc7ukEISnmHgc7LRw2Qiy3n5BKj/6CXajIbvPI=;
 b=ow8B8lcD1YHf3RRF1Vp77paVPa89PBmBHwJa9NjKswWas1z3kjGIpwncl6oMsokOWqjVwVN8qGJkMMthQQw0MyqzjbkY0X60j6mINgDfYVAk9ukxS3MC5QNO3E2Z5cEPa0vc//5QukqzVRXALE9NkY0ObgQIftyd/wMmGzmUqmOvCXyqDuI8eq2gBEBVesxsbr+5KffypCHMg/+MF/HWp4aHiGil2de22Tco/YViq+hmiq3IMgCjWZQKrGh60ekea+MW6NS9AGs22bLsynN0kiXt8Z3RaktrXFwTTQ2CwMxLdcVU8tU4hWgJ5O+Z6kxtSUrhIHw/aw7pVaLhp8WSLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CH3PR15MB6262.namprd15.prod.outlook.com (2603:10b6:610:15f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 25 Jul
 2025 17:45:29 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8880.026; Fri, 25 Jul 2025
 17:45:29 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "penguin-kernel@I-love.SAKURA.ne.jp" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "willy@infradead.org" <willy@infradead.org>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v3] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
Thread-Index:
 AQHb91IJ4dXLt/uuZkqRbEGinlBUibQ2uTqAgAAmwgCABfRaAIABJ7GAgAAu4ICAAAmKAIAABPwAgAA/FgCAAHUJgIAAE2cAgAENGoCAAAaQAIAAzLAAgADYSYCAACXrAIAAFPAAgAE0vYA=
Date: Fri, 25 Jul 2025 17:45:29 +0000
Message-ID: <da34b1af424c855519b3e926c7bc891a338c327c.camel@ibm.com>
References: <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
	 <aHlQkTHYxnZ1wrhF@casper.infradead.org>
	 <5684510c160d08680f4c35b2f70881edc53e83aa.camel@ibm.com>
	 <93338c04-75d4-474e-b2d9-c3ae6057db96@I-love.SAKURA.ne.jp>
	 <b601d17a38a335afbe1398fc7248e4ec878cc1c6.camel@ibm.com>
	 <38d8f48e-47c3-4d67-9caa-498f3b47004f@I-love.SAKURA.ne.jp>
	 <aH-SbYUKE1Ydb-tJ@casper.infradead.org>
	 <8333cf5e-a9cc-4b56-8b06-9b55b95e97db@I-love.SAKURA.ne.jp>
	 <aH-enGSS7zWq0jFf@casper.infradead.org>
	 <9ac7574508df0f96d220cc9c2f51d3192ffff568.camel@ibm.com>
	 <65009dff-dd9d-4c99-aa53-5e87e2777017@I-love.SAKURA.ne.jp>
	 <e00cff7b-3e87-4522-957f-996cb8ed5b41@I-love.SAKURA.ne.jp>
	 <c99951ae12dc1f5a51b1f6c82bbf7b61b2f12e02.camel@ibm.com>
	 <9a18338da59460bd5c95605d8b10f895a0b7dbb8.camel@ibm.com>
	 <bb8d0438-6db4-4032-ba44-f7b4155d2cef@I-love.SAKURA.ne.jp>
	 <5ef2e2838b0d07d3f05edd2a2a169e7647782de5.camel@ibm.com>
	 <8cb50ca3-8ccc-461e-866c-bb322ef8bfc6@I-love.SAKURA.ne.jp>
	 <d4abeee2-e291-4da4-9e0e-7880a9c213e3@I-love.SAKURA.ne.jp>
In-Reply-To: <d4abeee2-e291-4da4-9e0e-7880a9c213e3@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CH3PR15MB6262:EE_
x-ms-office365-filtering-correlation-id: 219a9db7-727b-438b-1bb5-08ddcba30c10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dkNvYldqZElXUnhCNTB0bFR5elVwTE5iblEzWDM5eit1QnY3OG96cVZjdHlP?=
 =?utf-8?B?SXE4aTZQbThJS3FOcGZ0UE1JKzlIZ1lTQTlzRFEySUZ5Y0luOWFJS0ZIRTR1?=
 =?utf-8?B?V1hvYWcyeHI4aVFjWm5DM3hTajM1ZXFxNFJJQndpa09vaEV1RCt4L2hXRllZ?=
 =?utf-8?B?VXpaSGhIRldEQlphak1hUWlOeWplZHpEOVV0ZG5JZU5qRDk3QzVZNVhIdXNI?=
 =?utf-8?B?ZWdYZEVycVZmRDdIa2MyalBiaEpGS1RWaGlVSWdvbGFPWUVhZ1FUY1RveVd4?=
 =?utf-8?B?QXBBeU5RV3dFMWRIRHV6ZGFhT1FrNUh3MDVlcXljUUxsRnJJT0hYMGtXSXd2?=
 =?utf-8?B?ZTFKV3p6VEE2TmxjQVJLbjM5Yng3Nk1JNjdKZFlGVld6d3VhQzhOZmNSUVVt?=
 =?utf-8?B?MDkzK29RUlZHdXdNL1FmamxUMlBWbHRtWXRUZjRCWEJYM25KVTB6c0RaTDB2?=
 =?utf-8?B?bks4bkFxczl4N0tZZ29SbEhQYlp3OEJ3SWdxTnJUVjJBbnBxeDdKVFFJSEVH?=
 =?utf-8?B?RHFENFB6MDFKL1lVZjhDNWNsOWgwMC9jS1lRUjJPeVhaZmVYeU5KNGlFSnlV?=
 =?utf-8?B?MXRaTmxrVzRIMVJyeXZCWGZqemhzSC9aVDA0Q3BFWS9SUDZjNktySmUvY1Zi?=
 =?utf-8?B?ZkZXejJLYzVWdnZ6Rk1ES2pvL05oTHJGN2hqNDMzamQxTE5LK3ZWRG5HUHda?=
 =?utf-8?B?NDlqRWZhYmR6ZS9pQTdnWGFQbWhhSEhLSUNYUEc4NUlQems3Wi9iL0VIdkhO?=
 =?utf-8?B?M1NNOGZvZFltay9JOXB2SXB0SHA2TFltNDM2YVZxSDY3L0VnMWpFTm5NOXkw?=
 =?utf-8?B?SFd3YVU5T09GVVZkR0RSUlV6Wm5nVWxzZG9RRmMybEFqaUhWUlNBNFYxelhk?=
 =?utf-8?B?OHI5bElGS21wYThJSmpRZnFNZ0FUc0tnYU1JREFENU9BcDVEQVZMemZnUGxZ?=
 =?utf-8?B?eFVmQTlLZ1c5L0VLR3VMMUpwYyt0a05oTExqdUIwaGNGUGdlQWprNGd6UVBL?=
 =?utf-8?B?UkErZ3ZMcVFRU3JqZjB6b0hhQ0F6TnBqWFhmM09CQnFOODRZak5lSmFrdkFK?=
 =?utf-8?B?V080VWhMTHY5UkVBVE1nb1dmcmxwTnhIektCLzZSVmlubkdOWW9WNXNjaGpT?=
 =?utf-8?B?UVQxVndoUklPeGlJQ28vUlU4MlFiRkUwb25zeGh3d3NTMnN1Ylpod1l5bVl1?=
 =?utf-8?B?RXZHNkNGQnVjdlo2cWpJK2VhS0VGVUhxU1UyT3YwQ2VSaFAwc041c1RjUHFk?=
 =?utf-8?B?ZGZDR1Y5M09oK0FzSHlIZktPL0FWNlFCZDVzRm1qeWFjWVRvNXV3MGZsRy9l?=
 =?utf-8?B?YUFhK2RjbitDSlcwOVExenRaUmY4WnJTV1N4dXlyM0QxMTUzbndBVWRXdkFp?=
 =?utf-8?B?dGtzMjg1Y3JDOHl3V0FYU1UzbXZkVFI5TmtSNTM4L1k1Vlh1MkNZWU9nczIv?=
 =?utf-8?B?YWp3NnBvOS9pbXE1NEIwMC8rcjdQcmVYZlRCbTcveHAzMjA5NDFDNzkxdXdn?=
 =?utf-8?B?dlBKNks5SkV3OE1tTzd5WGZiM3crZisydXBENWZGUjREai9NRUhzMmhBTk96?=
 =?utf-8?B?U0VENWVoT0oxajdFejZjakZPazJjbWJjYjA3YVkwMEtjQklNU0lSR1ZQbmtN?=
 =?utf-8?B?THVMaU5XMGJLdk9KQ2Y4cjdTTHdhMHNLQm1pMWR5aXhtVXgrc09HNGZlWk8v?=
 =?utf-8?B?K3k4RW5POTJxdkFtRy9mUStFMnNBSmw1UDVqUUVXQVM0eHNHV1R5UFFrMk1G?=
 =?utf-8?B?bVRzNm9weHM2ZjlseEpmdFRwVUR4UEpDN0paV2tQNnR6enVNV1o4Ym1yVHVu?=
 =?utf-8?B?V0ZBSnFRb3h1d3pEMXZzcUxGLzJLUW5RWm9XbXdDeDcrYzMyNFAxaVZEZjRT?=
 =?utf-8?B?WG04N3dzS1NVcXUvSm5EdndxR2g4ZFBxZ3dwdjNSRzJNd1NpdjZJM3lNVng5?=
 =?utf-8?B?ZmlLUUpvN2xKdk1SVHJRSElxV3dZSXFOYmFKNGNPc2RLZ0s3cUIzYWVFenRV?=
 =?utf-8?B?bjR6NGcvWk9RPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cEtSZytrV09WWDJyNFBjNzRvS281NHlrTG8xM3Y4YW5YTWIyQWxNN08yTy9z?=
 =?utf-8?B?WnFLTzFCcXhWQXhab0dKd2lOQUQ3S2ptdlJ2ZStuUUhGeUpyaFdSbWFzMmgx?=
 =?utf-8?B?U2h0REhtanhXeGN4UU05Z2dmYlJEbS8zTTZENjhRTnNQWWVCbTE5WVhCdjFH?=
 =?utf-8?B?bEZMUWJpcHR1VkpkRlpVTjUrdG9kekR1RU94d3EzZVlvZGNjK0NDb1VkSVFD?=
 =?utf-8?B?UGtmNVRhcnF4R1pSaXNOcURKdWtyaXNlcDVqdnBGY0NIMkEyZDA0UlBMY1U2?=
 =?utf-8?B?d1R3L2QxT3ZQb0NUZGpFeHdSclROMHBJSGZIdHp3N1BkYkw0bzFRUDZjWVM0?=
 =?utf-8?B?bTl1MVlLMWQ2VjdPd21ha1ZFNG1MdUJRTFBvTlZaaWxDcTVYdGo4RjJ1ZVZu?=
 =?utf-8?B?VTZVTk9DYlpTOTRpRmtWeGZtdjhJVm9TQTBhM3NTeGdUVk1JL3RvMy9tZmox?=
 =?utf-8?B?RDRHM044T1RqNWg4VWk5Z2dqOStvVjI1Zkhrd0JSbUFiUEMwQVhOcVloc2RB?=
 =?utf-8?B?Vm16SjRrWTExZm9sQU9KL0xZdVZUT2JMc0EvT01TaDhkMHpBUTRCMDc4N2sr?=
 =?utf-8?B?T1Y3QnpLVjIwZ1BBdWNxR3B0SkZzdUdxVExoMzZQaHU3Szh2LzlBU1h0Q2VL?=
 =?utf-8?B?UXdRc0xFaWkrOHI5bVNCVFJCQUtiTVpoMWtxYmVucG5yVThmeHJPaGRkenJD?=
 =?utf-8?B?SUVBQ0ErbEtCMzQ4OXREbE5WNUlJVkVCby83cjFwTDRTME5GWjRRS3pIUWNW?=
 =?utf-8?B?TVpPbDl4SUVBR1ArSkRiZ0tvNU82U0lGTGgzS2N2dFhLZElkRy9FZDRzZWRG?=
 =?utf-8?B?ZmxsRno5c1MrL2RBSFFZOTF5UFg2WmJKWk1kRkQwQ1FRN3ZrT0I0dTlWZDVm?=
 =?utf-8?B?NldsNjl3TTBOSW52Q1d1N1h5dGV2YmZocE5QOW0vbi9hdmdBYStaZ2ZZRjdI?=
 =?utf-8?B?QWhTTWs0RmM0eTlzdzNERXkxci9wWGJDMUdXcXRKaEdFUlVHby9mRHZHdHoy?=
 =?utf-8?B?K3d3SDFxWVdjUWVnUittT0d1amJkVS9WKy9ydVdTWVNUeWZpNVFXU0luV2I4?=
 =?utf-8?B?VjNuOTA0cEdFOVFvaExVeDRWRXFQeUlWcThFeFFuQXpaMHp5dkJDMlh0WUxW?=
 =?utf-8?B?UWtuN3NTTTVCbGxXVWNJb2JQZnBVNzlrSzhqV01RckY0QVZRM0g5RlZ6ckcx?=
 =?utf-8?B?TUVaQ3JWNjJMWVc1bWZRd3V6bHoxYmFLbS9Qd0lrVVFoZ3FBeEZuM1dRc0Zk?=
 =?utf-8?B?SEpRNnBkT0RXRXlXSkRHUDBYTllKUjhiNmdMNjNiQldIaE4yYXNQUE9xdVBY?=
 =?utf-8?B?VUJ1NXIxS0lIblZ4WEhyMktaWGg4V2xJdWFQa0JSQ3JnWG5YU2tmZGgzaDlx?=
 =?utf-8?B?dndQZXFFbWhrTTMvaWxXR0hpME1hem5yR3dKdjlJeEs2dzlnU3h2bDlDbzM1?=
 =?utf-8?B?bEt1NDFLNm5ncysxRW5Lcnh0azRGZnpEREJZajk3b1VRb3RyazVlWm9ubUNP?=
 =?utf-8?B?K2V4MVpqOFB0bWF0Z3VSNTh0azk2NWhpRFhyZ1NsTHY5L0N0b200RU1KN3NY?=
 =?utf-8?B?dU9oWU9Ja1AvdjhPakZHTlAxQkMzQndSTHl5MVR0SWlleUtzd2ZTUWZLUlZp?=
 =?utf-8?B?Rmw0UnUvbWhBWXNDMitDTHZSSE92MzdlQU16SVhPUnc2YmtnSG1OT0puZ1lZ?=
 =?utf-8?B?WW5lNDJkWkpteUVYU0VocWs1aW5kazI2ZnM3VnFhMUZBcUpvMFBpa0RzTy93?=
 =?utf-8?B?RytZYmZzWGFXcEkyZk9GS0ZhNWpQS05NSGw1S09VWTdlbFl3VFMvcVArQm9L?=
 =?utf-8?B?V1lqZWZPQmFRVG9SNS8rUDlyY3llQllKUWFEdHVhUVhFcDRsdks2aHFrTW0z?=
 =?utf-8?B?YVI3SFpKUTd1SjRocURNQ1ZQb3FtTEd2VlYrTzVzanFPVGYvZWxPMW9tSkVk?=
 =?utf-8?B?WXl1c3pockQ5c0M3Y1o5Z0NrQVd3eXBZMWUwenUwWmlYc016bXFBOEZnRzA4?=
 =?utf-8?B?V2syVTBTUC94eXhPb1dqYzlvZUdhSSsyRXJNbUw0U2FRYXZUMW5wTDRub3Ew?=
 =?utf-8?B?OENwVWEvUFA3UmFIK3FkelVWeFo0Mnl6cXY0dHVuQzZkemRWL25vOHEvRE15?=
 =?utf-8?B?K055T1lGVDkzNXQzK1lsSmZNWjBnOC9nRkk2YzhzeDRHN1F0NkwvYXlKeGk2?=
 =?utf-8?Q?1xD9uO6rR0zBw/OvKn56zwM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBEF49ACABB5504F98F527515702B860@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 219a9db7-727b-438b-1bb5-08ddcba30c10
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2025 17:45:29.8696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hcR/RFns/RlA1heI+TVMPXVkmweJqcfQKGtRKS/zH6avwK4ekbKHK9oi5x/mxzVU6CEBL/D/YFJixx42dm8zbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6262
X-Proofpoint-GUID: poLGNREACqrfBrD2l5ZS-iUHrx3TevZp
X-Authority-Analysis: v=2.4 cv=OdWYDgTY c=1 sm=1 tr=0 ts=6883c2bc cx=c_pps
 a=HWRxpm+59NDbfqu//+EW6g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=pbAZuICAMk2n_kNpBHQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: poLGNREACqrfBrD2l5ZS-iUHrx3TevZp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDE1MiBTYWx0ZWRfX/bFeoaWvV9x5
 +2RsU2VvwrXA4AeMdzbwF21nz7YZXv4n0b7V1QcbY5uHn1xzKWr8m8S3z8cQuAtkBS4K2GtCko6
 NwlthUXdFW3k4UX8+zQPLMr7aNTxx7KHcUg3jaxvjPVFrL1oTs6yGQdugoglLc2XY3NQrEuwFkM
 UTICzLLhYEmuUJfjOvaU9+VkdVnAGKBuYIdmXaf+whYmfvekzT6ICm54B3VUII9YZO2fUiQ4fLe
 hKPnC/Mf/BR/07ciqKaF3PY4Vjhg7RJ0teiMgXyXGMtPWGxE/+dPFtx93AK5PmTeEVGClpAOcsR
 +79Nf++zLh5QoQ1hr3wd0jXVJZd7V7qb084Du9Ysm0mcR/ZBOXBljFbbf1vCb3VOMHGRvtGawBi
 K2tJDQdVq0ysS322u2Qy37MlxzqbpPkCRdMiTHOGlDiiRkVAkF5XzFxLOKU1wxitrB7F5Odm
Subject: RE: [PATCH v3] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250152

T24gRnJpLCAyMDI1LTA3LTI1IGF0IDA4OjIwICswOTAwLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IE9uIDIwMjUvMDcvMjUgNzowNSwgVGV0c3VvIEhhbmRhIHdyb3RlOg0KPiA+ID4gPiBCdXQgSSBj
YW4ndCBiZSBjb252aW5jZWQgdGhhdCBhYm92ZSBjaGFuZ2UgaXMgc3VmZmljaWVudCwgZm9yIGlm
IEkgZG8NCj4gPiA+ID4gDQo+ID4gPiA+ICsJICAgICAgICAgICAgc3RhdGljIHU4IHNlcmlhbDsN
Cj4gPiA+ID4gKyAgICAgICAgICAgICAgIGlmIChpbm9kZS0+aV9pbm8gPCBIRlNfRklSU1RVU0VS
X0NOSUQgJiYgKCgxVSA8PCBpbm9kZS0+aV9pbm8pICYgYmFkX2NuaWRfbGlzdCkpDQo+ID4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIGlub2RlLT5pX2lubyA9IChzZXJpYWwrKykgJSAxNjsN
Cj4gPiA+IA0KPiA+ID4gSSBkb24ndCBzZWUgdGhlIHBvaW50IGluIGZsYWdzIGludHJvZHVjdGlv
bi4gSXQgbWFrZXMgbG9naWMgdmVyeSBjb21wbGljYXRlZC4NCj4gPiANCj4gPiBUaGUgcG9pbnQg
b2YgdGhpcyBjaGFuZ2UgaXMgdG8gZXhjZWNpc2UgaW5vZGUtPmlfaW5vIGZvciBhbGwgdmFsdWVz
IGJldHdlZW4gMCBhbmQgMTUuDQo+ID4gU29tZSBvZiB2YWx1ZXMgYmV0d2VlbiAwIGFuZCAxNSBt
dXN0IGJlIHZhbGlkIGFzIGlub2RlLT5pX2lubyAsIGRvZXNuJ3QgdGhlc2U/IFRoZW4sDQo+IA0K
PiBCYWNrZ3JvdW5kOiBJIGFzc3VtZSB0aGF0IHRoZSB2YWx1ZSBvZiByZWMtPmRpci5EaXJJRCBj
b21lcyBmcm9tIHRoZSBoZnMgZmlsZXN5c3RlbSBpbWFnZSBpbiB0aGUNCj4gcmVwcm9kdWNlciAo
aS5lLiBtZW1mZCBmaWxlIGFzc29jaWF0ZWQgd2l0aCAvZGV2L2xvb3AwICkuIEJ1dCBzaW5jZSBJ
IGRvbid0IGtub3cgdGhlIG9mZnNldCB0byBtb2RpZnkNCj4gdGhlIHZhbHVlIGlmIEkgd2FudCB0
aGUgcmVwcm9kdWNlciB0byBwYXNzIHJlYy0+ZGlyLkRpcklEID09IDEuLi4xNSBpbnN0ZWFkIG9m
IHJlYy0+ZGlyLkRpcklEID09IDAsDQo+IEkgYW0gbW9kaWZ5aW5nIGlub2RlLT5pX2lubyBoZXJl
IHdoZW4gcmVjLT5kaXIuRGlySUQgPT0gMC4NCj4gDQo+ID4gDQo+ID4gPiANCj4gPiA+ID4gDQo+
ID4gPiA+IGluc3RlYWQgb2YNCj4gPiA+ID4gDQo+ID4gPiA+ICsgICAgICAgICAgICAgICBpZiAo
aW5vZGUtPmlfaW5vIDwgSEZTX0ZJUlNUVVNFUl9DTklEICYmICgoMVUgPDwgaW5vZGUtPmlfaW5v
KSAmIGJhZF9jbmlkX2xpc3QpKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBtYWtl
X2JhZF9pbm9kZShpbm9kZSk7DQo+ID4gPiA+IA0KPiA+ID4gPiAsIHRoZSByZXByb2R1Y2VyIHN0
aWxsIGhpdHMgQlVHKCkgZm9yIDAsIDEsIDUsIDYsIDcsIDgsIDksIDEwLCAxMSwgMTIsIDEzLCAx
NCBhbmQgMTUNCj4gPiA+ID4gYmVjYXVzZSBoZnNfd3JpdGVfaW5vZGUoKSBoYW5kbGVzIG9ubHkg
MiwgMyBhbmQgNC4NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IEhvdyBjYW4gd2UgZ28gaW50byBo
ZnNfd3JpdGVfaW5vZGUoKSBpZiB3ZSBjcmVhdGVkIHRoZSBiYWQgaW5vZGUgZm9yIGludmFsaWQN
Cj4gPiA+IGlub2RlIElEPyBIb3cgaXMgaXQgcG9zc2libGU/DQo+IA0KPiBDYWxsaW5nIG1ha2Vf
YmFkX2lub2RlKCkgZm9yIHNvbWUgb2YgdmFsdWVzIGJldHdlZW4gMC4uLjE1IGF0IGhmc19yZWFk
X2lub2RlKCkgd2lsbCBwcmV2ZW50DQo+IHRoYXQgaW5vZGUgZnJvbSBnb2luZyBpbnRvIGhmc193
cml0ZV9pbm9kZSgpLiBCdXQgcmVnYXJkaW5nIHRoZSB2YWx1ZXMgYmV0d2VlbiAwLi4uMTUgd2hp
Y2gNCj4gd2VyZSBub3QgY2FsbGluZyBtYWtlX2JhZF9pbm9kZSgpIGF0IGhmc19yZWFkX2lub2Rl
KCkgd2lsbCBub3QgcHJldmVudCB0aGF0IGlub2RlIGZyb20gZ29pbmcNCj4gaW50byBoZnNfd3Jp
dGVfaW5vZGUoKS4NCj4gDQo+IFNpbmNlIGhmc193cml0ZV9pbm9kZSgpIGNhbGxzIEJVRygpIGZv
ciB2YWx1ZXMgMC4uLjE1IGV4Y2VwdCAyLi4uNCwgYW55IHZhbHVlcyBiZXR3ZWVuIDAuLi4xNQ0K
PiBleGNlcHQgMi4uLjQgd2hpY2ggd2VyZSBub3QgY2FsbGluZyBtYWtlX2JhZF9pbm9kZSgpIGF0
IGhmc19yZWFkX2lub2RlKCkgd2lsbCBoaXQgQlVHKCkuDQo+IA0KPiBJZiB3ZSBkb24ndCByZW1v
dmUgQlVHKCksIHRoZSB2YWx1ZXMgd2hpY2ggaGZzX3JlYWRfaW5vZGUoKSBkb2VzIG5vdCBuZWVk
IHRvIGNhbGwNCj4gbWFrZV9iYWRfaW5vZGUoKSB3aWxsIGJlIGxpbWl0ZWQgdG8gb25seSAyLi4u
NC4NCj4gDQo+IEFuZCBzaW5jZSB5b3Ugc2F5IHRoYXQgaGZzX3JlYWRfaW5vZGUoKSBzaG91bGQg
Y2FsbCBtYWtlX2JhZF9pbm9kZSgpIGZvciAzLi4uNCwgdGhlIG9ubHkgdmFsdWUNCj4gaGZzX3Jl
YWRfaW5vZGUoKSBjYW4gYWNjZXB0IChmcm9tIHRoZSBwb2ludCBvZiB2aWV3IG9mIGF2b2lkIGhp
dHRpbmcgQlVHKCkgaW4gaGZzX3dyaXRlX2lub2RlKCkpDQo+IHdpbGwgYmUgMi4NCj4gDQo+ID4g
DQo+ID4gYXJlIGFsbCBvZiAwLCAxLCA1LCA2LCA3LCA4LCA5LCAxMCwgMTEsIDEyLCAxMywgMTQg
YW5kIDE1IGludmFsaWQgdmFsdWUgZm9yIGhmc19yZWFkX2lub2RlKCkgPw0KPiA+IA0KPiA+IElm
IGFsbCBvZiAwLCAxLCA1LCA2LCA3LCA4LCA5LCAxMCwgMTEsIDEyLCAxMywgMTQgYW5kIDE1IGFy
ZSBpbnZhbGlkIHZhbHVlIGZvciBoZnNfcmVhZF9pbm9kZSgpLA0KPiA+IGFuZCAzIGFuZCA0IGFy
ZSBhbHNvIGludmFsaWQgdmFsdWUgZm9yIGhmc19yZWFkX2lub2RlKCksIGhmc19yZWFkX2lub2Rl
KCkgd291bGQgYWNjZXB0IG9ubHkgMi4NCj4gPiBTb21ldGhpbmcgaXMgY3JhemlseSB3cm9uZy4N
Cj4gPiANCj4gPiBDYW4gd2UgcmVhbGx5IGZpbHRlciBzb21lIG9mIHZhbHVlcyBiZXR3ZWVuIDAg
YW5kIDE1IGF0IGhmc19yZWFkX2lub2RlKCkgPw0KPiA+IA0KPiANCj4gQ2FuIHRoZSBhdHRlbXB0
IHRvIGZpbHRlciBzb21lIG9mIHZhbHVlcyBiZXR3ZWVuIDAgYW5kIDE1IGF0IGhmc19yZWFkX2lu
b2RlKCkgbWFrZSBzZW5zZSwNCj4gd2l0aG91dCB0aGUgYXR0ZW1wdCB0byByZW1vdmUgQlVHKCkg
ZnJvbSBoZnNfd3JpdGVfaW5vZGUoKSA/DQo+IA0KPiBJIHRoaW5rIHRoYXQgd2UgbmVlZCB0byBy
ZW1vdmUgQlVHKCkgZnJvbSBoZnNfd3JpdGVfaW5vZGUoKSwgZXZlbiBpZiB5b3UgdHJ5IHRvIGZp
bHRlcg0KPiBhdCBoZnNfcmVhZF9pbm9kZSgpLg0KDQpJZiB3ZSBtYW5hZ2UgdGhlIGlub2RlIElE
cyBwcm9wZXJseSBpbiBoZnNfcmVhZF9pbm9kZSgpLCB0aGVuIGhmc193cml0ZV9pbm9kZSgpDQpu
ZXZlciB3aWxsIHJlY2VpdmUgdGhlIGludmFsaWQgaW5vZGUgSUQuIEkgZG9uJ3Qgc2VlIHRoZSBw
b2ludCB0byByZW1vdmUgdGhlDQpCVUcoKSBpbiBoZnNfd3JpdGVfaW5vZGUoKS4NCg0KVGhhbmtz
LA0KU2xhdmEuDQo=

