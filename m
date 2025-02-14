Return-Path: <linux-fsdevel+bounces-41765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8F1A36939
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 00:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF1263AE841
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 23:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234061FDA62;
	Fri, 14 Feb 2025 23:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lTRu2Xxg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58B11FC7D0
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 23:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577177; cv=fail; b=PpFNwwc6XwSJtrRDIuRyhz/sJH++uiRCyZKtkxnXWgRgIdNij8gBxzdDbWGIYm+ckvHtxhj46eJNxRkAp3DsNFb+279dOZnQRLFtl965FWpSJAgoaO1LCU8VqNp/ahfdAtia1yEIcfz8UAfL05dxgYsBiAvx5FhVq6PzsYqD9ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577177; c=relaxed/simple;
	bh=9tAPr29oeb9OTmhTKO0zq4yKlTA7c2Q+1vA/la+Di2o=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=shtH6Vxbp4oNKVHhLfoBh/SU4aTfAt0JHuRZpTSULwGZLyi1Kn+/mr5OHfp185L0lbFDVm4B2QNxklJpIfMOdC1iC9CAFHYM5nDdeQk3lA/Wjww4Sz6RjxRvMSJsEtPXWPnha2sgv0WTaXKrEHPmlbWZqZj61W1IbrQoaWBEAcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lTRu2Xxg; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EFdSm5032251
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 23:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=lpFQ+ieYIKpHXhCHrFU/agXAU+6NIe2RCw6ywF3yVqU=; b=lTRu2Xxg
	g7IR0OP4Pu/HwmKw9RfoZ+ncukTvOYQ3T2MnnLpnkOds+fSWtNArx/OAgEkzkO9/
	SHcbu4K8yoD97yOlSpvI+wBIEgARmoRcjAWUD4Mx/N0zrVBXIKtQ8wtygQENV3Ud
	pOb1z17tHvtv7b/H/1LhWFEKAIdSVmTxQum0tQYd2dBzQAxUZBcopKb4rK2ajtEI
	NcMzp0zXEPPnM1q2aJBrp68yzRJPUF9DelnDgQsYsz9ADQu5zBbi9UqP6kzdV0Nh
	bRfQsj4wIziAPioKFSbXtSV/LItkK9UZXMsG76TNguhvsQakqrR8wyE9h4l8YcZT
	BAfXmHfgnQstTw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44t8nuj34p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 23:52:54 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51ENqsXs021875;
	Fri, 14 Feb 2025 23:52:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44t8nuj34m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 23:52:53 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51ENqroB021866;
	Fri, 14 Feb 2025 23:52:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44t8nuj34j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 23:52:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnBMdvPvsG7hsuOunTX9WD781Bpe1I9bOnm/GyBoaqYLTX9tqfjO/Y/Naft8KSfNeIKZQlIce13Y7TSZFKTZrzzcQ22WXFHdtiIkOTbaxLaS1y6TIHS4MdH7HdGBhQQ8NcR/H2JzVjiAm0gV/UeFkZbL3wOkdNhffLzjQsuos8QJO/2ywJczRu1LYptKPMIZhALZathEKrVGu+OpCdfSzcPT6/wfdwIveYLniiARVwovqNacpiGLNmoEkSFLW14u04TeYvNsXdqxfHQ1lQLpI2ha+dC3sW/+/LIUafJURoB+oOAib+Sv3sW6tc7ZYTWCa7T13tFhWSuLYaKZ3zIsLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cq+Z0DDelks951WU3N1f0MPZPG8QkMQJ+4OE5ykwT0k=;
 b=QEFc2xfFnkG+c20ZAWucghxXJRlTTdIo52qvgdwY8R89Rp7D8xKQrR5id3kzhKJilRq5w+fYDJk5vkcP5WLbAeoEO/Rxkm4e/fZbGkTXYLLpfZpVsnO+MHw2S7UNB0Ne8GNEgKWC0+3WEsYZTuUNE1slQSpToK17xhlTw71xdRLG9JmylRgcno1f7pvhUJTKH6GpSsNbyD/Y2p5Q6h2xFjeowIOMTjguLlo0IbmVrqgLN/LnpydbYC8owoz70ANculzDZdQ343IpfG3VdyQbWEzNew/uGLaYLX+bjHFBF33tnn5B88Brwy8kGP4++OORIxjoDwuAsH1X731UsflOyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB4353.namprd15.prod.outlook.com (2603:10b6:806:1ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Fri, 14 Feb
 2025 23:52:50 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%4]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 23:52:50 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: David Howells <dhowells@redhat.com>
CC: "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Patrick
 Donnelly <pdonnell@redhat.com>
Thread-Topic: [EXTERNAL] Re: [RFC PATCH 0/4] ceph: fix generic/421 test
 failure
Thread-Index: AQHbfwSitHI2EkU8vkKyDr1N+60bsbNHD9oAgAAyHQCAAALggIAAAcgAgAAycwA=
Date: Fri, 14 Feb 2025 23:52:50 +0000
Message-ID: <10419fc0f416c930e291c038ccf091f0a91b36d2.camel@ibm.com>
References: <7596dd297239c4226a0ff6005bbb368733d38b4a.camel@ibm.com>
		 <4e993d6ebadba1ed04261fd5590d439f382ca226.camel@ibm.com>
		 <20250205000249.123054-1-slava@dubeyko.com>
		 <4153980.1739553567@warthog.procyon.org.uk>
		 <18284.1739565336@warthog.procyon.org.uk>
	 <36588.1739566336@warthog.procyon.org.uk>
In-Reply-To: <36588.1739566336@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB4353:EE_
x-ms-office365-filtering-correlation-id: a2baa12c-3576-4d93-4db8-08dd4d52b0e2
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S3VYU0E2REg4YUN3WjdGem5UUTFYR1RZczBPRHpPWlNhQlJqOU5oaDF4cWlP?=
 =?utf-8?B?RnBLU2dPT0tRUEFaYVFFNWRKU1F0Nm1kM2RxcitSUXlRK1k5TDV5b3N1NzNj?=
 =?utf-8?B?eGx3cUFwb25oOHRWVkI2NzRuK2h3eFZlWDR2Zm9xTXhDbU40MFNKWUV1eGEv?=
 =?utf-8?B?RnZoc1ZZanYyUGxtZTVSSGhFdU81elNrbERIREhUcU5QcjRFSFZabzhRNkQ0?=
 =?utf-8?B?YnU1WVRwVHhrV0dMOHlSdFMxUG03cmd5cE8yYmo1T0xjZkFIQ0QxK2tVRC9S?=
 =?utf-8?B?TmtVOGpiL25qT3A3MXp0anVOUGN0VlVQc1FSc0cxZXp5ZWpFYUg2RHZqcEht?=
 =?utf-8?B?YTFjd21UdlptOWJsTmVzQ05mdUVkdkFLL1hkU2tOUkdDVjRKcG14elFWYzNz?=
 =?utf-8?B?YWd1UENnVlBldng4Tm42bmhaUnhEL2pDS3o2SU1sc2hSc3ZDQ3VxMmFES0Fr?=
 =?utf-8?B?R2dTK0dxRnVGRlFtUi9tNXZlUGg3cEM2Yk5BRlAvZDN1Q3E2bzA1WGwvclpV?=
 =?utf-8?B?TnpjRFA4WVNUajZ4MTd2WCtHeDBHNkhKaytFODdTU216UmxTcXFRSWZDczEv?=
 =?utf-8?B?aFJBMVdUdGdDOVJFMHk2REJvRmpSc20yNHV5Y1pYdVM3b0pnTlBHeGVGRVhr?=
 =?utf-8?B?bVhNSWRreE53YnQwb21LQlNCTUczQjRFaTZOQlhzZktFdEFIZENXY1F4Qjlp?=
 =?utf-8?B?RzRzRzBPU055b2o2ZzBWeE5XQWVCQVB2aGNBNldYc1J4eHFQbzd6d0RUTXIw?=
 =?utf-8?B?WTJCM0dvY3pHK1hUU0tOeHZvNlU1UzU1SUpQeCtFSmYxcm51RmJDL3lUS1FO?=
 =?utf-8?B?RFRRZEFubG8zcEhXV29vTW5SeTNKOUZQRVpaS2s1K0l4aVdSUGtMUkFaOXFB?=
 =?utf-8?B?MHRLc0toTDBtSHJkRlE0NDZVbG9WZGp4Y3JkOEZrQmZ2c09jSzI1SDE4bU91?=
 =?utf-8?B?QVJwUGdOM1VKajlnSUpPNDR5N1UyT0VTbm5ob2ptSDVjbzZrc2FUY2ZiZGQ5?=
 =?utf-8?B?UXhQUVNqR2hRNzYxNmVSblZzMDA5LzhWZDRxM3BJaFJTZU5mbFRJQ29zM0po?=
 =?utf-8?B?eWFuNmEyc1lRc05PRStvWFlZaEVpRllCWVBUWjFYcDVBYnlldTNhUzJlWkg1?=
 =?utf-8?B?Zm1BOTF4T0NkcmdSRG5rdGNTZ3lDZ0U1MWM2QVlLcHpzcHdKUStJYzVJMWlD?=
 =?utf-8?B?T2t2aTU3TWt6bjlzcFIySzExREVsMUpXYVBZb2Vjd0c5QlMyNDdZZWRiYTNO?=
 =?utf-8?B?eEgzR1NYVkcvSlVwMEIyRVFmWXBzcWY2WWlFWXNZUUJkUWsyNEFuMDljTVN6?=
 =?utf-8?B?V25zaXZvQjQvZ0cwNXExdGZEUFByTE1RVDdwaXpFRGRER25BUlZnUGJqTXh5?=
 =?utf-8?B?UTJJVlZjRnlQV0orTnJLQ3RHa0IyNkpEei96Z3hXYmJvWmJLeldVUU04eGpT?=
 =?utf-8?B?YUlrWTlCZzU5SzYrc1FNVTAzUS9uWXUybGxwcmFybXJvNVB0Rit6aEJmZkoz?=
 =?utf-8?B?bUFNM3JnUWtaWXNwVXk4d0kySTh6NkJXSUtrR09YNHlaZW5lNEhBd3E1c0w5?=
 =?utf-8?B?R3VYeGNaTXdJY3BQUjI3UmpSam5PZlJDWTJBZFUzS093c2IrNGc1TDA1bTFr?=
 =?utf-8?B?MjJoY012QXB2TFdocU9XNVNaMmo5OWdUa3hKV1dicjFvVUhIZnh1Lzh4RlBG?=
 =?utf-8?B?dU1ndnZxcTRMSnVhaGpCY2YwSkZOM1FtTHVWT3RXR1JWSVNKbzNUbzVaUHgz?=
 =?utf-8?B?OVlpdHRwVTNlNVFyajhmTzRQV0w5WjJQa2thakQrc2k2T1l5ZzJQTXVnRW1L?=
 =?utf-8?B?YzdaMXppOUtTbm1HMFN1Z285UFBRY0pleDhmQWNJeTRMWGF0c2F1cGZxZkkw?=
 =?utf-8?B?ZFhiejZwZE91eFlidkRDM0QyWWlJb0dkbUsvcDFtdlRtaFpHOHNuK2IwclZJ?=
 =?utf-8?Q?0FLbcCVwBccrkTE+nIyTjD5Qurgt3/bh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U3FnMHlYMDVVYW8wcGt1RytleGRYNVhFbWN5cXoxbXZpZ25lK1dSL3NkZHp4?=
 =?utf-8?B?RURlT3RmWUNBaitNUnRUQkxxRjRMeTdmUGNvUnhiZlFwcXcxck9EOUNQRTFV?=
 =?utf-8?B?ZjI3RGxNNGZSL2VtTm42ZDJtOGM4WjRIdmVUN3QyTVZreFNWUlNSSmlKMFlv?=
 =?utf-8?B?bit4RlgvN2ZwRGZIMzVLYkZCVDVKVDJjZm5LdGJySUIxb3V3eUpNRmhXUWM5?=
 =?utf-8?B?RFNNNVVrWWFqK3Q0VU1QZDIyb2hPaXhkOVl5bFBSaExCbGFTQldweWtOMlJz?=
 =?utf-8?B?RHJTQkpielVnK3NvdTdEV1pqc1pqSlQvK2dtU0U0SDg4ME5sT0h2anVPQmxN?=
 =?utf-8?B?U1RSRmVEcHNPQlpyQ0N3MjVvNFJ1cnpIV3FDQm8xVjMzOGJyZ2tXcDZhbkJJ?=
 =?utf-8?B?YkdiU2tGQlltUGRYNWtwV1Jrc3loQ1NDc3hnV2VGOFR5WXBsdmh6bFhIK2sy?=
 =?utf-8?B?T2pYdTdmd1hkZ1RSZUx0Q0E5UUpWZ1BrRFRzbVcvYjl3TzZOdXg4dkdVNDc3?=
 =?utf-8?B?Q0lqdXkycWVjNlJoYmloZzZsNzRhTzhsd3NORWFMRk5Wc1ZmVDA1djlWQnJU?=
 =?utf-8?B?MVNnd09oOVhQdE9sUkRLc09hU2tYV2NRUy95dS92c2Vpa3FrMDVaTGFvMFZQ?=
 =?utf-8?B?d1dwVVNReTRyMTY1WWlYNzMzcVV3RE9kbGpsVThsZE5MYWNSSDBIOUNZaHZB?=
 =?utf-8?B?S3M2ZVp6M0hJdXBxSnQ0TVhoQkNYVC9LOFRNSjF4dkJjaEFjRnpGRSsxOVVR?=
 =?utf-8?B?R2FTR0JxakZ2dTBWbzlqWTBJTHBGenMvYWxCV290TDJoWjR5S2RUTEc5YzBz?=
 =?utf-8?B?cklCVEppREk1bXVDWGJZb0ExTXB0Y1pPRUl0TnhycHphK3Exa2pqZVFTcmdW?=
 =?utf-8?B?azNtRytidFBrdXgzVWV5c0RXUVE5dVhYUmI1RzlhQnhjUmFaYWZ0SktkTVZl?=
 =?utf-8?B?YytFRVJvUmFzN2RPQU5TbHNsZnV5bDlXUWlDdGhwaS9nbURCUHlJdWZuQWJh?=
 =?utf-8?B?OVhuQ1ppNFdPUVVjT3ZIampzSStiMnM0dEV2ZFdTL3poT011NXB3QTl4NGRG?=
 =?utf-8?B?VHFUdWtaWk0yUzlxZnFvZ3RqQ3hjOGtIcTh6QVZXVFk4NFlyY25lbm55RW1M?=
 =?utf-8?B?ckh0eHVCNjc4ZlNqN25xcXlPeC9wNWVwandKSC9ld3gwR0dlZmxEL3V0QzFj?=
 =?utf-8?B?STVuZGNETllibUV3SUwyLzlMUDYrczNhVXk4OVk1Q2psQ3d4MmE1NTAzYWN4?=
 =?utf-8?B?cjBsdGIzMUx2ci9DQzNyM21RZk9XSG9LM0tKcFlIY0QxdTFQZ0NKZXVYYVNh?=
 =?utf-8?B?UUdKR3Rla1UyMXhjUW9EUC80bjNuTnFBZWF0cFdNTDZlZFFQbWxPR1RuanRp?=
 =?utf-8?B?R1Ztc1NBQkczVFFEV1B3OTdxaUlzc0lXbUd2Qmd2Rm1RT0xvSVR5c25Tbkc5?=
 =?utf-8?B?STFnbU82Y2ZvK3ozQSttN2dOanBjYU11MjN6Skg0NUs3WXZ0YXF4NmxwSlpa?=
 =?utf-8?B?MTNDTnBLd3lCNmI3NGkrakFVMHM1TDlRckdsc0FoQXp5eVpLYmpDUmE2SklZ?=
 =?utf-8?B?ZXpVMGQ3eXRzQklJN084N0NmV29yVm5lZFdiR1lBWjF4V0dIMnlhYUMySFVu?=
 =?utf-8?B?MkZVMjJqYjdUTm4zYWwzc2NSUEpveGp2VFR6QU5GTEJDdHNvWlNYM1Z1MnRU?=
 =?utf-8?B?L1htbm0yL2xJYWNkWjZicStscVZYYlFnY2d3a3Z1QktsczRzVlZXdjFGaXds?=
 =?utf-8?B?UTF3K0txdjY4V3F3Zmk2bGdIWnJWT3J1OTJBRkZtY25takhzQkZhT0dtWkJW?=
 =?utf-8?B?MlBkeG91Kzh5a2Y4TlBpM0dtcUlEQkRmcTdLZFV6RXZQUnVneWNRWWNZMkFr?=
 =?utf-8?B?N3JtUSs4dksySTVueWhmTEJNcVI1ZG1zTXdxNmRlVjJGOUlQRVFwU2FFSWwy?=
 =?utf-8?B?RThzR01nbkZ0WXRCaXBQclNqMFJjWDljUVBpcUdneUtTR0R5OFNhRXhZaS9x?=
 =?utf-8?B?L1poaEJKVHlKQjkycWNKWXJ2dHdlODEvWmRjaTZGbk1xaDhjN2RUWVZ6cmJR?=
 =?utf-8?B?dER1UnFzMUxGOXVnRU1RbnRlSWpDZGdTWmpBV25FZENZWUdHUmovdDhkdWxm?=
 =?utf-8?B?R0FBSnFRSW5lalVrLzhOK2d3T0xEQ0V0cFk5REo4MHlNTzNKQXI0QUQ0WGdx?=
 =?utf-8?Q?G5wLs+KIC+qc3UcwxRMN+oU=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2baa12c-3576-4d93-4db8-08dd4d52b0e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 23:52:50.6405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WCq1/8N5e8loIb3Gfm7noN4ZOUL0NGDD6FRa96GfwYecBeYkOyA/aNEjQSNeSBlB5mjfJfS0lVp8rBz18e0Z8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4353
X-Proofpoint-GUID: ZshJDVb-EcS1egF_0wMuKKF7iHl46-C4
X-Proofpoint-ORIG-GUID: dh7GtxyqDNbfZ2pU1TzbQn5KkrULlAqj
Content-Type: text/plain; charset="utf-8"
Content-ID: <443D1FF9E1A35F4BA704E5CA002552E9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [RFC PATCH 0/4] ceph: fix generic/421 test failure
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_10,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=2 engine=8.19.0-2501170000 definitions=main-2502140162

On Fri, 2025-02-14 at 20:52 +0000, David Howells wrote:
> Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:
>=20
> > Do you mean that you applied this modification?
>=20
> See:
>=20
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/lo=
g/?h=3Dnetfs-fixes =20
>=20
> for I have applied.
>=20

I took your branch [1] and compiled the kernel:

git status
HEAD detached at origin/netfs-fixes

But I cannot reproduce the issue:

sudo ./check -g encrypt
FSTYP         -- ceph
PLATFORM      -- Linux/x86_64 ceph-testing-0001 6.14.0-rc2+ #1 SMP
PREEMPT_DYNAMIC Fri Feb 14 23:04:17 UTC 2025
MKFS_OPTIONS  -- 127.0.0.1:40137:/scratch
MOUNT_OPTIONS -- -o name=3Dfs,secret=3D<secret>,ms_mode=3Dcrc,nowsync,copyf=
rom
127.0.0.1:40137:/scratch /mnt/scratch

generic/395 15s ...  10s
generic/396 12s ...  9s
generic/397 13s ...  11s
generic/398 1s ... [not run] kernel doesn't support renameat2 syscall
generic/399 28s ... [not run] Filesystem ceph not supported in
_scratch_mkfs_sized_encrypted
generic/419 1s ... [not run] kernel doesn't support renameat2 syscall
generic/421 17s ...  13s
generic/429 24s ...  22s
generic/435 1115s ...  873s
generic/440 18s ...  13s
generic/548 2s ... [not run] xfs_io fiemap  failed (old kernel/wrong fs?)
generic/549 2s ... [not run] encryption policy '-c 5 -n 6 -f 0' is unusable;
probably missing kernel crypto API support
generic/550 4s ... [not run] encryption policy '-c 9 -n 9 -f 0' is unusable;
probably missing kernel crypto API support
generic/576       [not run] fsverity utility required, skipped this test
generic/580 18s ...  15s
generic/581 21s ...  20s
generic/582 2s ... [not run] xfs_io fiemap  failed (old kernel/wrong fs?)
generic/583 2s ... [not run] encryption policy '-c 5 -n 6 -v 2 -f 0' is
unusable; probably missing kernel crypto API support
generic/584 3s ... [not run] encryption policy '-c 9 -n 9 -v 2 -f 0' is
unusable; probably missing kernel crypto API support
generic/592 3s ... [not run] kernel does not support encryption policy: '-c=
 1 -n
4 -v 2 -f 8'
generic/593 18s ...  14s
generic/595 20s ...  19s
generic/602 2s ... [not run] kernel does not support encryption policy: '-c=
 1 -n
4 -v 2 -f 16'
generic/613 5s ... [not run] _get_encryption_nonce() isn't implemented on c=
eph
generic/621 6s ... [not run] kernel doesn't support renameat2 syscall
generic/693 6s ... [not run] encryption policy '-c 1 -n 10 -v 2 -f 0' is
unusable; probably missing kernel crypto API support
generic/739       [not run] xfs_io set_encpolicy doesn't support -s
Ran: generic/395 generic/396 generic/397 generic/398 generic/399 generic/419
generic/421 generic/429 generic/435 generic/440 generic/548 generic/549
generic/550 generic/576 generic/580 generic/581 generic/582 generic/583
generic/584 generic/592 generic/593 generic/595 generic/602 generic/613
generic/621 generic/693 generic/739
Not run: generic/398 generic/399 generic/419 generic/548 generic/549 generi=
c/550
generic/576 generic/582 generic/583 generic/584 generic/592 generic/602
generic/613 generic/621 generic/693 generic/739
Passed all 27 tests

[1] https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git




