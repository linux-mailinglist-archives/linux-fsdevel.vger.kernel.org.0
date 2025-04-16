Return-Path: <linux-fsdevel+bounces-46580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546CEA90A96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 19:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5482544743C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 17:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023BD218AC4;
	Wed, 16 Apr 2025 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KPiA4MXh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5711517A304;
	Wed, 16 Apr 2025 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744826207; cv=fail; b=hm431KYR+BYplEngCRZ5STSJZfq1Qc8a52tpWidFmhyD810l4jtq6rIOUFpoLr/70aGk8RQcQimOESoazpHDMKX19j0GhBNXugKI7OaMIbDdHYTLYVwfBrWMVnR0IWzwnI8ZQQGYKsK+Ge/iK6TMoCjVVb8tSbgLqod0jqIEvPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744826207; c=relaxed/simple;
	bh=JIiSGWwCMQOfbyg1xeU+RkFYHFoyUDmfEuPI9uuadgs=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=V+NagvaTatF8kTmSWW9c5iRPCK6NACOsrDcKuwYLmOMgQ0MwqQHzs+ihca+dQFGvQi8ZDcKKYDU4HukpwspgN7n5nM5zbGP28gRNa+j8QO2edg1B4yfsRySHvEznvEj4grhgBaV0J6kVDUpWpcf/hKARRrAePpMyWSqf1B9B5Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KPiA4MXh; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GBvTx0003091;
	Wed, 16 Apr 2025 17:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=JIiSGWwCMQOfbyg1xeU+RkFYHFoyUDmfEuPI9uuadgs=; b=KPiA4MXh
	R6y8kLmQmmZ12R4mqPi+f3P+r1oFkkI6TOsSvznayfT2HM7d720I7Cm4kYqKyHWP
	1o7xlkTfxYnDt1aeZGB3XFnIMweKJkzceLgZpu8aWbUsvzGIVXBwRMW2Y1kFrAD8
	Z+P/EOAI9STHV0CDHQgrvDh+UOqoBPLZ1g7janAKPlwi1ttld/pJmFaDp0DPytgV
	MIX9hHe7Hg/g0FufFfFdzNgHYctH3U8IBzy/+OIFX/+MGADcA6sHRSVfy/bhPGq5
	omfYMm6dR+t+0pfkJS22wftPRK6O0tfHAkJb9MGu0HvxEpbjLuz+p7ix/iHURv3Q
	OJo5JnXPe9Zsww==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4621dxcrme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 17:56:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WeCfEOg4NBJ8o+LLcRZ3kfQqLY1sGV4qJfkxeDaGwoeEHeK6IBoz0Fc4ufzHVjmUZA8YAhCbtX/SkFAckEvArtuoPInHnjsHX0S1C2ZzhhLzGNxfhvbjgQW2Ufa8+tvlGkPlda4alp6YWIzWe0qZi5zZkJTVPMM2o+tsQ1LN5awIsyrnmGwxDJzhFmfXZOeRpUqHV5Eqlogdc5+lLEKo0l8rS3D8nz9etSglU5T+Ec0q+DhuJRo0GZF7hIDZxH12Y6+MxVUNlg41GThNzkjvjcDbPXSbKjNL1R7+jzYYlWH1plvmJNrmr2Cbo2DWma0yhy/FdlAc3sUNvigpC/FMww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIiSGWwCMQOfbyg1xeU+RkFYHFoyUDmfEuPI9uuadgs=;
 b=Bl5LsMZx2HD+7Bey87IjHhUkBs3h3GH5tbByKo2R63e7BdfQqU6guU+hPHq4mHWJadaWHs2iqUf4mp9N1jPwcjEj2qHkEDn1RGx/45rQxMgo5j3Z4uT2TD8TZNRqvO9Ql7u49WDKRYgO5J5/K0LJkCi3NRIIuyrPmQEH6Ro582inwCNs8HvqpfMiyss7OnVOC+M9a863jlFUjvFSET+zXAXiwtxu6+B5Gbc0n5mZlteujQIRaVebaQHi5dlu3zrBp5eB0VPV3eeeaIFcENA31rsViZO/KmvMB8vYy/CmxC9hUtv3uZhDYQUFPwpWrVn6SNxq5UnXvgBwhWbb6AKSGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS1PR15MB6589.namprd15.prod.outlook.com (2603:10b6:8:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Wed, 16 Apr
 2025 17:56:25 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%3]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 17:56:25 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org"
	<brauner@kernel.org>
CC: "jack@suse.com" <jack@suse.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "sandeen@redhat.com" <sandeen@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org"
	<torvalds@linux-foundation.org>,
        "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>,
        "willy@infradead.org" <willy@infradead.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] hfs{plus}: add deprecation warning
Thread-Index: AQHbrhWWXaRwwnXSdkukdsi2+kZKRrOl1QqAgACQ7wCAAC+YAA==
Date: Wed, 16 Apr 2025 17:56:25 +0000
Message-ID: <4ecc225c641c0fee9725861670668352d305ad29.camel@ibm.com>
References: <20250415-orchester-robben-2be52e119ee4@brauner>
	 <20250415144907.GB25659@frogsfrogsfrogs>
	 <20250416-willen-wachhalten-55a798e41fd2@brauner>
	 <20250416150604.GB25700@frogsfrogsfrogs>
In-Reply-To: <20250416150604.GB25700@frogsfrogsfrogs>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS1PR15MB6589:EE_
x-ms-office365-filtering-correlation-id: 76afe1ff-5c21-491c-01a6-08dd7d100158
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OWJOQXFLNVQ3VHdBTFNBd2RnT1NWczd5cDU4bVBwWU1jT0R3YnRmZTE3dGdz?=
 =?utf-8?B?dXNCcEpqZEwwc00xQmNIZkdYL29YNFhoOTBBUEFKbm5JWnRkWFZZc0lYY3dt?=
 =?utf-8?B?NmczSFlIRHRnYjRKSy96d0F1K1p6amxkOStPMk5ncER0cHVOWTA0SEVXMFo2?=
 =?utf-8?B?dzFKc2xCczQ3T1VuZzlmOWhOTzFkTzN0dUk5VVNiRU5PZ2pwMjhyeXZuMG0r?=
 =?utf-8?B?dGZ5bUppRDU5ZThCYUxudkFvNEQwK2VOT0tJaURqbW5IS0Z5TGRYeFdGMG96?=
 =?utf-8?B?WFZLd2NGY3F6UHplRnE3ck9LNDRCTnJxVGtLckJBZWZDM0hWL1IzYWtSYkZ6?=
 =?utf-8?B?eGpQa0dUNHlXWHlYcVl4bGVnaTlqQTc4QVRXb1dyTXVaNExDdFpSS1ZoSmhC?=
 =?utf-8?B?NThXRVJPK1VvZVhXY2FGQS9lTDRpajhBNDluTEo2NDA1S2xPWFFUYk03NU1T?=
 =?utf-8?B?eVp4WUZYQlZ6MWx5Mm84N1g0Si9pVFJMalJWMzBZc2g2Um0vYUFBdVdOWTJQ?=
 =?utf-8?B?TkJGYThwMGhRb0lhM1RrbTJFb1ZkQVB5Q3JFKzIwc2JqZG85bVQwTEJ2Yytl?=
 =?utf-8?B?Nk9ua1ZtUWdOZFdXSGlqeHNLNGtiVFczNVZ5WTNwZTNCQnArNTVMZlpHd1ha?=
 =?utf-8?B?dzdieHNHQUx2aXNVY3RNSk03enh6MGR4K0dobUFGRHA4MkYxZjlpcVBaeWNx?=
 =?utf-8?B?dGQyUnVqSTNTc2M5Q2U1QkZmTExGYXRwRE5mWGpNR0VESUdIZkVMc0tUd0x4?=
 =?utf-8?B?aHJadWpJSGY1bDhGVUwvVkxQVy94MGEvOWcxUkk4NFBBZ3RTeUpmOUJyR240?=
 =?utf-8?B?c1lyMWgyelVQMDZURmNaa29Vb3NNN1BYRkJJVzVxYTBiVE9ybE9UeDI5alFt?=
 =?utf-8?B?eEhJcUtGMmFFcWphaEtsL0I1TkJFdFRORWJ4Q1lwOGd1MGphalJNbHhnaERG?=
 =?utf-8?B?ei91dzlVMmhEZVIzRm9LejFlZHFXQkFMc1BHV3VUL0Y0VXR3aWxPNVRMaitU?=
 =?utf-8?B?MkVqSVFMRmt6WjRKcHhId1VsNTJiR2ZkU3JnYW1KVVRKYVZUcTQ2Q0QwcmN2?=
 =?utf-8?B?Qk5Ub0lzRjh5MVJKZS9uaDhVTzlic2QrOGlESGVpcWdWcktVR2NJa2czTFlD?=
 =?utf-8?B?dDJBTm9xWUlrNXZxWmoraXVqWXFPUmRUOHN0SmRtMWNKMWNvNVpMc3pDTVZD?=
 =?utf-8?B?Ym5tcStWU0g0c3B3Q1pucXVrVUJhM25LVTZ0T3dTV3k1TStlMENxZWdYSU5h?=
 =?utf-8?B?c09yb1ZadEpFcjlZOXNOeENYYVVvMWxKcFpaUVJRbUo1Nm44SE5IclE2T1la?=
 =?utf-8?B?YW5uOGRxY2NFR2F3L2l0OURvUU11MzVFZ2xWNEpSWXJuQ0haRmVhZWVQcHdE?=
 =?utf-8?B?dHY3YjAwbFJrbWRDT0w4T2hRcWg5Z0ZwWXQxY2Yxclpnc0M3N0RzNzJZaStG?=
 =?utf-8?B?NDVLT3dXUHF1cUhwd0lrazV0eWJHK3lxUTBNWW1kd0x1RnJ0TU1mb0NxNjUz?=
 =?utf-8?B?OCtrY29aNmRJSDNFUGZzczlNVUZIN1lOK05sRDZIQkViUjc1WG5pbXRVczI5?=
 =?utf-8?B?S3hvNnlraDg0M29uUGRhNFlWZ2VOYno2SzRLN2wwUE91T2wwdzVFcEUyUFFo?=
 =?utf-8?B?cWloUUVOQmZ6Z2MrQ24rUFQyaUFQWEtJOERnZzl1bk9JYWhSc0tBREJaSk85?=
 =?utf-8?B?djFYS0ZxNVJoS0F6NUdVZlRsOXVORUt5YWhlWkJZTEZNdktGaFJhUVFuRDZl?=
 =?utf-8?B?b0ZvZkJEOStFMEpTeEtBSFZRbUVkZ0pmODluM1hOMUttaDl1cmUra3lDclov?=
 =?utf-8?B?aWtteWV0THYreFdoc1lJSlgveTJzU09kMlJ1dWo3bU53cERleW5YV3VNNEZj?=
 =?utf-8?B?azVRak4rUVVZTkdBMXoxekJsa29FRHJMNEVUZkY4bmhDUm5mdi9BRHFyTHpR?=
 =?utf-8?B?L1VPSDZUcHJMamQwYXdBc3laUTdwcVp6QTBSdnVOZktFckUzMmI2THZKeVFF?=
 =?utf-8?B?SU0yazI2bjJ3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bVRzZ1EyclNtUU5qWE9Zd3VUMjQzWnBJWWZjLytKS3JrSnk5OTNXaVc4QWRM?=
 =?utf-8?B?RENwZEUzVjBHZmM2eGtYRE9GaU9ZdEpXWUZWYTdBT0c1UWVwbDM3MkRvUVB4?=
 =?utf-8?B?T0dWSmZPVmZLWVBFTHIzQ01LN2tucGJQK3FxZlUzR2hjNm1JbGhIbThMKzl3?=
 =?utf-8?B?TmRYejJQRU10YXFjdU93dmVPUyt5RHhDUUY4V3VWeEJRUDRzTUMwRjl6Nlln?=
 =?utf-8?B?S3FZMzdLd2QxUENsbldvUDhXRk5lYWV2c1NCRllYaHB3NGQwUE0zSTc3Y3p3?=
 =?utf-8?B?TXd6VVczeHdIQkNuUTdvWlNHWXh1NDM3MWpkak5oS0ExR0FycjBpb01hVm9z?=
 =?utf-8?B?bzh4eStsM05HTzZxdXQ3NVNSSEViekM2bFRmbHgyY0E1K0RZTjl2em5HM1o4?=
 =?utf-8?B?QkhLRFdrZVhMSmF5Q1FkaFBKMjRsMkg1MTBYNVhZZUlvdHdmUTJEdWZvTVZm?=
 =?utf-8?B?ZG5STzVPTGE4eDRaYmlhWlRaak1GYVg0VU11V0VFekdOUmxsanJhanh1ZFZJ?=
 =?utf-8?B?Ym50T2ZTZ1RHeG5zbFFYc09LVThQRndBcXFFWVlhNDlvNm9ZOEhRUFhwOG9T?=
 =?utf-8?B?TEhoUEwrYUptS1lEVDU5RlVpNUZKZE5aMktkSUhVaGZzMVZ6OXdoOHZ6ZFFv?=
 =?utf-8?B?MTNQc2w0TlpyWEFEaFdkRnZ4MEpVSUQxTDFkeDZvQUtPanB0OERORDNKdzU5?=
 =?utf-8?B?dmVqc3BhUG1LZWJ4ZGZHWVZhTTBSUjNxZWZIYWxQRDZUQzNQZmVtQ09wc2d2?=
 =?utf-8?B?cHlFQzU2VHFPNGdHcW9PdWdUUllweDJ0THROZjV0QW9sZG1oNjJtZ09meVZ1?=
 =?utf-8?B?USttRFlrZVlzbnFTaXp0UXhCdk5tWXJpSnBsUG10N3NlZW1JUnA4OGtWSUs4?=
 =?utf-8?B?aS96ZUVIenlWam50V1Juczl6UzRZeE1QRVdUVituR09qMWlhL0NSblIvS2JG?=
 =?utf-8?B?WHhsUm1JTGxUMUhDR2pNY3YxVFBPR2IyeVYwZkFzWmZ2cW91MDhsWERxTGVu?=
 =?utf-8?B?TXFadExZWi9LdzdGeVd5RVpGSTA5c0VZRTRoRjkvUS9DNjJveXJacGlHdXhi?=
 =?utf-8?B?YldQOHlhLytsYzlVTmp1eU5FWHBsdE1sNjJ6RGM5S3ZLTXJISE1qYldKOWFP?=
 =?utf-8?B?WEp0S1VOUFhiVHFxbFJwY2tKYlZGSEI1dGI3TVpsRXJ6NEdERk40ZDZnNFdC?=
 =?utf-8?B?cmJHUzRScmxpaExOdXNyMGVkbkQ3SnVzektVZTRZYzNoK2xKMXlNbWxrZTl4?=
 =?utf-8?B?T3dpcXltSUk5WnZubW9rSWYzeWxWc2JWbTBYZHhQTFBqVnZaTk9XNWlXRnd0?=
 =?utf-8?B?MFQyK2hIcllpZVV3MVFrUjFnYXRIeDkwSU1kUkd1d2I4NjV5c2VTazdaSWlo?=
 =?utf-8?B?dmhZV2N6UEoydUIwYUZnKy9ZWTZrSGF6OEFkMksra1hBeDFYaC9oZUxUdE92?=
 =?utf-8?B?MitpQTV3eXpIQ2xHLzdPbk83WFU2VWhiTm5td1pCT3gxcGdBeXFTUVQ2cnRn?=
 =?utf-8?B?SnV0ekpOcWx6em5uR2F1YjNGQ1JaanMzcWRMZHpZbVBhdkh6dGxWZWdWMWdj?=
 =?utf-8?B?ZXpENStxN3YzRlYwbE50TXU4c3kvYnpCUjlXa2M5bHM4RUhpWW4yRzBaOUVC?=
 =?utf-8?B?bFdhWkllTHdFVnJFQ0dZdzZUNWZCNnNVYVNWSnB1RGZuR2VvNlE3bk51TS9x?=
 =?utf-8?B?ZHI2RVVEeG12RVFFVm1ZeG9zTnpwcXJGNzduak43ZzZ1aG1PRzFkOW4zTUdw?=
 =?utf-8?B?SlJIY0ZtMUVXbERMbnlnNFQ3Z2plcmlDc0xGQ3AvOFVrUUdFbFZJd1ZkMUdR?=
 =?utf-8?B?R0p0QWJ0dWZxU2J3ZysrZC90WC8yMTI3b3VOOGZIaTVVYndrdStWUTI3cC95?=
 =?utf-8?B?dStZdEk1djl4UEp4cXZmbzhGSGdkZkVLbENEdUNac0U3a1oyQmlDRGg0eDA2?=
 =?utf-8?B?T3JjWjBkbEI2NXM4NmlKNk8vVkZLSzRzUGx6TmJtdVJTWDNJOEY1c0lZSmhB?=
 =?utf-8?B?cDBBMDBITTBjZzhTdDhPM09QOEdWTTRuaDhzcG5Ta09ZU0RudmdHVk14K2gw?=
 =?utf-8?B?ZkJFandobFB3YVh3WkVaUy8rbE9WOVRlZGVHSTFOaFZrK3liWnlKS0pRK1h4?=
 =?utf-8?B?aFRyMUoxMlpEekxIOTRKOU0xbFpJUTZ5c2FrQVFwR3ZiZGR1QS9mL1gvWnlN?=
 =?utf-8?Q?A3Cch28OL9ij342W0Se6azI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B32D7C2FA403F647ACEB402B110477D2@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 76afe1ff-5c21-491c-01a6-08dd7d100158
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 17:56:25.1412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Mc/0mhDSnv1fCN0b6CSNtGy2ke89ti+KGIo98wmTrUn7ZglBuUBbMf+SI8s+yau4j2jr6TaokFcKQ6atZ+69w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR15MB6589
X-Proofpoint-ORIG-GUID: 7hcxTSqkyU3a3C-5bODXdFhMmbHs-pTa
X-Proofpoint-GUID: 7hcxTSqkyU3a3C-5bODXdFhMmbHs-pTa
Subject: RE: [PATCH] hfs{plus}: add deprecation warning
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_06,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 adultscore=0 clxscore=1011 mlxscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504160143

T24gV2VkLCAyMDI1LTA0LTE2IGF0IDA4OjA2IC0wNzAwLCBEYXJyaWNrIEouIFdvbmcgd3JvdGU6
DQo+IE9uIFdlZCwgQXByIDE2LCAyMDI1IGF0IDA4OjI3OjE5QU0gKzAyMDAsIENocmlzdGlhbiBC
cmF1bmVyIHdyb3RlOg0KPiA+IE9uIFR1ZSwgQXByIDE1LCAyMDI1IGF0IDA3OjQ5OjA3QU0gLTA3
MDAsIERhcnJpY2sgSi4gV29uZyB3cm90ZToNCj4gPiA+IE9uIFR1ZSwgQXByIDE1LCAyMDI1IGF0
IDA5OjUxOjM3QU0gKzAyMDAsIENocmlzdGlhbiBCcmF1bmVyIHdyb3RlOg0KPiA+ID4gPiBCb3Ro
IHRoZSBoZnMgYW5kIGhmc3BsdXMgZmlsZXN5c3RlbSBoYXZlIGJlZW4gb3JwaGFuZWQgc2luY2Ug
YXQgbGVhc3QNCj4gPiA+ID4gMjAxNCwgaS5lLiwgb3ZlciAxMCB5ZWFycy4gSXQncyB0aW1lIHRv
IHJlbW92ZSB0aGVtIGZyb20gdGhlIGtlcm5lbCBhcw0KPiA+ID4gPiB0aGV5J3JlIGV4aGliaXRp
bmcgbW9yZSBhbmQgbW9yZSBpc3N1ZXMgYW5kIG5vIG9uZSBpcyBzdGVwcGluZyB1cCB0bw0KPiA+
ID4gPiBmaXhpbmcgdGhlbS4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IENocmlz
dGlhbiBCcmF1bmVyIDxicmF1bmVyQGtlcm5lbC5vcmc+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAg
ZnMvaGZzL3N1cGVyLmMgICAgIHwgMiArKw0KPiA+ID4gPiAgZnMvaGZzcGx1cy9zdXBlci5jIHwg
MiArKw0KPiA+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gPiA+ID4g
DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9mcy9oZnMvc3VwZXIuYyBiL2ZzL2hmcy9zdXBlci5jDQo+
ID4gPiA+IGluZGV4IGZlMDljMjA5M2E5My4uNDQxM2NkOGZlYjllIDEwMDY0NA0KPiA+ID4gPiAt
LS0gYS9mcy9oZnMvc3VwZXIuYw0KPiA+ID4gPiArKysgYi9mcy9oZnMvc3VwZXIuYw0KPiA+ID4g
PiBAQCAtNDA0LDYgKzQwNCw4IEBAIHN0YXRpYyBpbnQgaGZzX2luaXRfZnNfY29udGV4dChzdHJ1
Y3QgZnNfY29udGV4dCAqZmMpDQo+ID4gPiA+ICB7DQo+ID4gPiA+ICAJc3RydWN0IGhmc19zYl9p
bmZvICpoc2I7DQo+ID4gPiA+ICANCj4gPiA+ID4gKwlwcl93YXJuKCJUaGUgaGZzIGZpbGVzeXN0
ZW0gaXMgZGVwcmVjYXRlZCBhbmQgc2NoZWR1bGVkIHRvIGJlIHJlbW92ZWQgZnJvbSB0aGUga2Vy
bmVsIGluIDIwMjVcbiIpOw0KPiA+ID4gDQo+ID4gPiBEb2VzIHRoaXMgbWVhbiBiZWZvcmUgb3Ig
YWZ0ZXIgdGhlIDIwMjUgTFRTIGtlcm5lbCBpcyByZWxlYXNlZD8gIEkgd291bGQNCj4gPiANCj4g
PiBJIHdvdWxkJ3ZlIHRyaWVkIGJlZm9yZSB0aGUgTFRTIHJlbGVhc2UuLi4NCj4gDQo+IFdlbGwg
eW91IHN0aWxsIGNvdWxkLiAgTm8gYmV0dGVyIHdheSB0byBnZXQgYW4gb2Z0LWlnbm9yZWQgZmls
ZXN5c3RlbQ0KPiBiYWNrIGludG8gbWFpbnRlbmFuY2UgYnkgdGhyb3dpbmcgZG93biBhIGRlcHJl
Y2F0aW9uIG5vdGljZS4gOikNCj4gDQo+ID4gPiBzYXkgdGhhdCB3ZSBvdWdodCB0byBsZXQgdGhp
cyBjaXJjdWxhdGUgbW9yZSB3aWRlbHkgYW1vbmcgdXNlcnMsIGJ1dA0KPiA+IA0KPiA+IHdoaWNo
IGlzIGEgdmFsaWQgcG9pbnQuIFRoZSByZW1vdmFsIG9mIHJlaXNlcmZzIGFuZCBzeXN2IGhhcyBi
ZWVuIHByZXR0eQ0KPiA+IHN1cmdpY2FsbHkgY2xlYW4uIFNvIGF0IGxlYXN0IGZyb20gbXkgUE9W
IGl0IHNob3VsZCBiZSBzaW1wbGUgZW5vdWdoIHRvDQo+ID4gcmV2ZXJ0IHRoZSByZW1vdmFsLiBC
dXQgSSdtIG5vdCBkZWFsaW5nIHdpdGggc3RhYmxlIGtlcm5lbHMgc28gSSBoYXZlIG5vDQo+ID4g
aW50dWl0aW9uIGFib3V0IHRoZSBwYWluIGludm9sdmVkLg0KPiANCj4gSXQnbGwgcHJvYmFibHkg
Y2F1c2UgYSBsb3Qgb2YgcGFpbiBmb3IgdGhlIGRpc3RyaWJ1dGlvbnMgdGhhdCBzdXBwb3J0DQo+
IFBQQyBNYWNzIGJlY2F1c2UgdGhhdCdzIHRoZSBvbmx5IGZzIHRoYXQgdGhlIE9GIGtub3dzIGhv
dyB0byByZWFkIGZvcg0KPiBib290ZmlsZXMuICBGb3IgZHVhbC1ib290IEludGVsIE1hY3MsIHRo
ZWlyIEVGSSBwYXJ0aXRpb24gaXMgdXN1YWxseQ0KPiBIRlMrIGFuZCBjb250YWlucyB2YXJpb3Vz
IHN5c3RlbSBmaWxlcyAoKyBncnViKSwgYnV0IHRoZWlyIEVGSSBhY3R1YWxseQ0KPiBjYW4gcmVh
ZCBGQVQuICBJIGhhdmUgYW4gb2xkIDIwMTIgTWFjIE1pbmkgdGhhdCBydW5zIGV4Y2x1c2l2ZWx5
IERlYmlhbiwNCj4gYW5kIGEgRkFUMzIgRVNQIHdvcmtzIGp1c3QgZmluZS4NCj4gDQo+ID4gPiBP
VE9IIEkgZ3Vlc3Mgbm8gbWFpbnRhaW5lciBmb3IgYSBkZWNhZGUgaXMgcmVhbGx5IGJhZC4NCj4g
DQo+IE9uIHRob3NlIGdyb3VuZHMsDQo+IEFja2VkLWJ5OiAiRGFycmljayBKLiBXb25nIiA8ZGp3
b25nQGtlcm5lbC5vcmc+DQo+IA0KPiAtLUQNCj4gDQo+ID4gPiANCj4gPiA+IC0tRA0KPiA+ID4g
DQo+ID4gPiA+ICsNCj4gPiA+ID4gIAloc2IgPSBremFsbG9jKHNpemVvZihzdHJ1Y3QgaGZzX3Ni
X2luZm8pLCBHRlBfS0VSTkVMKTsNCj4gPiA+ID4gIAlpZiAoIWhzYikNCj4gPiA+ID4gIAkJcmV0
dXJuIC1FTk9NRU07DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9mcy9oZnNwbHVzL3N1cGVyLmMgYi9m
cy9oZnNwbHVzL3N1cGVyLmMNCj4gPiA+ID4gaW5kZXggOTQ4YjhhYWVlMzNlLi41OGNmZjRiMmEz
YjQgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2ZzL2hmc3BsdXMvc3VwZXIuYw0KPiA+ID4gPiArKysg
Yi9mcy9oZnNwbHVzL3N1cGVyLmMNCj4gPiA+ID4gQEAgLTY1Niw2ICs2NTYsOCBAQCBzdGF0aWMg
aW50IGhmc3BsdXNfaW5pdF9mc19jb250ZXh0KHN0cnVjdCBmc19jb250ZXh0ICpmYykNCj4gPiA+
ID4gIHsNCj4gPiA+ID4gIAlzdHJ1Y3QgaGZzcGx1c19zYl9pbmZvICpzYmk7DQo+ID4gPiA+ICAN
Cj4gPiA+ID4gKwlwcl93YXJuKCJUaGUgaGZzcGx1cyBmaWxlc3lzdGVtIGlzIGRlcHJlY2F0ZWQg
YW5kIHNjaGVkdWxlZCB0byBiZSByZW1vdmVkIGZyb20gdGhlIGtlcm5lbCBpbiAyMDI1XG4iKTsN
Cj4gPiA+ID4gKw0KPiA+ID4gPiAgCXNiaSA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBoZnNwbHVz
X3NiX2luZm8pLCBHRlBfS0VSTkVMKTsNCj4gPiA+ID4gIAlpZiAoIXNiaSkNCj4gPiA+ID4gIAkJ
cmV0dXJuIC1FTk9NRU07DQo+ID4gPiA+IC0tIA0KPiA+ID4gPiAyLjQ3LjINCj4gPiA+ID4gDQo+
ID4gPiA+IA0KPiANCg0KSSBjb250cmlidXRlZCB0byBIRlMrIGZpbGUgc3lzdGVtIGRyaXZlciBt
b3JlIHRoYW4gMTAgeWVhcnMgYWdvLiBBbmQgSSB3YXMNCmNvbXBsZXRlbHkgZGlzY291cmFnZWQg
YmVjYXVzZSBub2JvZHkgbWFpbnRhaW5lZCB0aGUgSEZTKyBjb2RlIGJhc2UuIEJ1dCBJIHdvdWxk
DQpwcmVmZXIgdG8gc2VlIHRoZSBIRlMrIGluIGtlcm5lbCB0cmVlIGluc3RlYWQgb2YgY29tcGxl
dGUgcmVtb3ZhbC4gQXMgZmFyIGFzIEkNCmNhbiBzZWUsIHdlIGFyZSBzdGlsbCByZWNlaXZpbmcg
c29tZSBwYXRjaGVzIGZvciBIRlMvSEZTKyBjb2RlIGJhc2UuIE5vd2FkYXlzLCBJDQphbSBtb3N0
bHkgYnVzeSB3aXRoIENlcGhGUyBhbmQgU1NERlMgZmlsZSBzeXN0ZW1zLiBCdXQgaWYgd2UgbmVl
ZCBtb3JlDQpzeXN0ZW1hdGljIGFjdGl2aXR5IG9uIEhGUy9IRlMrLCB0aGVuIEkgY2FuIGZpbmQg
c29tZSB0aW1lIGZvciBIRlMvSEZTKyB0ZXN0aW5nLA0KYnVnIGZpeCwgYW5kIHBhdGhlcyByZXZp
ZXcuIEkgYW0gbm90IHN1cmUgdGhhdCBJIHdvdWxkIGhhdmUgZW5vdWdoIHRpbWUgZm9yIEhGUysN
CmFjdGl2ZSBkZXZlbG9wbWVudC4gQnV0IGlzIGl0IHJlYWxseSB0aGF0IG5vYm9keSB3b3VsZCBs
aWtlIHRvIGJlIHRoZSBtYWludGFpbmVyDQpvZiBIRlMvSEZTKz8gSGF2ZSB3ZSBhc2tlZCB0aGUg
Y29udHJpYnV0b3JzIGFuZCByZXZpZXdlcnMgb2YgSEZTL0hGUys/DQoNClRoYW5rcywNClNsYXZh
Lg0KDQo=

