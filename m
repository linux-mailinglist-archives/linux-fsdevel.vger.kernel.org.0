Return-Path: <linux-fsdevel+bounces-42491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2F4A42D73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F22A3A6C35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 20:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A94E23BD1D;
	Mon, 24 Feb 2025 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OiBRD39F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFD120A5CA;
	Mon, 24 Feb 2025 20:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740427898; cv=fail; b=KpB0rcPfpJ4lsctUecEsQTSeS5fxFlxioFQzhnntO4fmMQlykSPnq5kHWWr68LAjiPWRZb5xlDwfK8sZbu5B897SSw0mJUKFsnN4XO1jiWlGBsFj9ry31H7JXWm0pQjg5v+eb2SGUH7X0+2MAEc9ayh8vRWm8zF6pc4IhQ0FRcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740427898; c=relaxed/simple;
	bh=aVOApVqoqTiCGwufl5ovHHswdOX8eIyzmTPPG07HWIM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=kIkq/9tY8NQGm716TPXAIL6+dhs6eRKDm8eZ65yOmOUHkO1uqwVi4L7VLzARr1i5kTRybvPaC+sA4jp0udKviPLaupGjxypVUwvQYUxXn1AbISxtegORqJzF3RaFnMUTD7Uwc37W0GvOsirreMAdo8sJgdB/E1BT5TgWWyC4Sko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OiBRD39F; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OEWveT020157;
	Mon, 24 Feb 2025 20:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=aVOApVqoqTiCGwufl5ovHHswdOX8eIyzmTPPG07HWIM=; b=OiBRD39F
	fUKvLDla8uHg4QwYvIcTJl6Inot+a2Hz+CKTFwC8RvNBsIO88oRdLtSXgwD+3V5v
	NBpgCvYB/hNetNPbpYGvQSec2h63UNBc1tqkKBRwH6qnh6N+ugbysNAc2x4jfqQE
	Y37qzm0hmALqVMeeVf8MlUVPTFQJzCUX0jmf1xToa2NnLjl1l+DHY8w9d0/LVkJZ
	RsAQHWWwa0tMbpA9l1og8cSax1BSB+pmRbp+5tUXqwm6fEAcKthGYLNZ6Ci+rVzm
	c3Wb950VgydLvjnYduzz/n40uyAsTkaTuTta9IlveDMgOnip8HtZrE9LnZLoOSLx
	k8pfXUfmrZYy1w==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 450cta54y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 20:11:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDg4k9/xbHB01TbFQUYGVXETbTcBWXet2uNhpx9+5U0H/r49lW2+lI+ChL+CJD3eSc09GOl91B82OT98eUreRWR44ELN2X5yIu0T1hUT+bg1CqAmPl4hr1Eh8NXpeMRBU8mwarKQK9fDOnVih8tDIyhEx53r5vT8tR+fl+KIGObLy2bJHveaBa2WLEQ8F47DN+QpoOujN0F6aTpfcws1bCGwgkyCYkExlpsokLG1chVf8dgHQjuT/Er/e0KsB/hYQov1X4Nu90zz6mzCEZUuvXpsAns3Dtia1tIDXNaK+MeA/ob/6W6jiAbAOdPf85alzZGc8jaBx7RKjpiLcCf7jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVOApVqoqTiCGwufl5ovHHswdOX8eIyzmTPPG07HWIM=;
 b=y1w/DYeRBF1r8gNhwo4Yswr72a+xKCSWkgbJohMMsbwJlqkrmXuu3+Nw0WKH38NIV0FJEnhb/neJZmJYzJKJMCpSJG94xmkGJQmGj+eq2Nbj9CnpPulZ+L/tAn6tWT97xhnj5ovrxdRgcyF9SFKmDNI3aPKc0eVgK4464H3XOLcmwU13gbT2JChCWE8Va2AkYnuEfwbczvMitYlE/UlxJtIevQo8wFLROQpgkrpz7XXvdI+YUc/tkfLKXga7EFQzXzHKjUuEv4JJyJjjTpwsGJcUB5UIODBVxwXYgiaX8hLAped/L7eu2rZ1XSf6zi0ihxAVRTsAy03gHadufHOeWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CH3PR15MB6378.namprd15.prod.outlook.com (2603:10b6:610:1b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 20:11:21 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 20:11:20 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "willy@infradead.org" <willy@infradead.org>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        David
 Howells <dhowells@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v3 10/9] fs: Remove
 page_mkwrite_check_truncate()
Thread-Index: AQHbhKGWOUU2y6TX00KVqLDkNzpdYLNW50YA
Date: Mon, 24 Feb 2025 20:11:20 +0000
Message-ID: <5c1ed8a12c92c143e234a59739af3663e9898ec1.camel@ibm.com>
References: <20250217185119.430193-1-willy@infradead.org>
	 <20250221204421.3590340-1-willy@infradead.org>
	 <Z7jl9cIZ2gka0QP6@casper.infradead.org>
In-Reply-To: <Z7jl9cIZ2gka0QP6@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CH3PR15MB6378:EE_
x-ms-office365-filtering-correlation-id: 11469e07-e0d9-446b-2612-08dd550f67a5
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ai93Q00rQlE0Y0dnaEV0SmdNcHZGcHFveEZLY0RRbGFWSlVUY29VQUN1STdJ?=
 =?utf-8?B?NGhCcVdDQkQ2b1AwdUZDRHRMM2NJQldtM3FQOExzMWJWRWJiSWV1Z0dnUmNK?=
 =?utf-8?B?VFhxSFJsUU04S2JEci9DTHVSaUUxU1RSR0VQdjZzU2xGcVQvdU42d3Z1Zlpu?=
 =?utf-8?B?NFFwVFNyWXo5T0d4V3ZvMWRBYUxoVzRKSTJ3dldKa0hnblovMW1xWFFaVExL?=
 =?utf-8?B?QnFnRGxyaWZwWUxIVVRDWGFRYXB6TE5Cd3h4VVJwUUZFTTg1WUhrYzRCWUtR?=
 =?utf-8?B?T0p1QjlUR0tiWDlYNFQ0YmtiVG51RnV5dFY2d2xZN2xOWm9mWk1mQ0RraC9U?=
 =?utf-8?B?NHJ4eFlDeTN5QmR1bzRyYWN1M2lQSEc3WjZMRnFYaWMxazAyMWhZL1BCcHdV?=
 =?utf-8?B?VVBkczFMRWNJc2M4bG1GczhjQVExemxZbjljQmVCdlUvZVNQSUovblM3MFhu?=
 =?utf-8?B?M3RlbXpIcTMvdnI5bnJrbjBkcm9wbEVBOFRGWmpYZk9SMTRqZDRJVktBSXdI?=
 =?utf-8?B?SExmUmJWdTJNNGFyZUFJYVNKdFhXbkYzZnRaN0psa0UyMkN0ZlEwTHdzWXVi?=
 =?utf-8?B?aFJIQ1M5Z0NaMUJ6T1BLTFA2YmdDRUhtcmFXWWx3RHhpQ3djSWNodE9mdWhS?=
 =?utf-8?B?dW1yNGVGMU93eG1lSHdZRlk0N2NLeXIwdVdEZTJZcTN4bTh0ZWhEZFhUMGtl?=
 =?utf-8?B?WVdybWFRa0dHY0JpbW0vUmdNWSs3cHpOSlRmc0JFdjc5UXlRUG0zN0N0aXJm?=
 =?utf-8?B?M3lPb0ZsMWE0b3BsaXZoT211aXd0aDJVZ3d1OFYwL1R4N1BhTUw2Rk5IQmRP?=
 =?utf-8?B?cnBSb2VwOG1oam4zazVVa3lnSjdBMHRFUkpjTmZSaE5Nd2lOZmhPamRnTjJD?=
 =?utf-8?B?TnNxcjdGcXVIVUg0WkdlNFBiWHVmdmVLVUZVd2kyditvTlMyRERjcmJTN1V0?=
 =?utf-8?B?M3VQTU1NU1dtdGZiUEdIUjc5VnRjWVpsaEZENU9WOWxpZEwvMkRiS0QzemFH?=
 =?utf-8?B?eWFOTXVuRW5PckM0NlcvSmlxd1kxOWdhVkZ5eG9lWDZhSWdzdjV1MVo4Um9Y?=
 =?utf-8?B?bDlPcmtjK0IzVWdBTUdxeExzYkNJbFlOdUJ1Nlg4MHBiYm93VFVNSkMwWVJZ?=
 =?utf-8?B?bnM5QldPa1pCVmhzaWpsTVJ2R3hlbGxQRWNudnY1N3AzUVZrTkFCUTFGTGV4?=
 =?utf-8?B?K2M2cHpERFlxZzJkaHl4bDJNRkJ1M21MczBLUms5N0hlcU81SmljYjdaOEt3?=
 =?utf-8?B?ekdnZURTL0pxMlZuT2d3YnYrNzdLM3l1YVBHY1lBSm9MaDNOcmxPTE9NeDky?=
 =?utf-8?B?ZERYNU9QcTdoRTZxbXliL05FUE5BL0dSbnJIa2RYWEFlS001aVBreHh0UVJl?=
 =?utf-8?B?ZG5NcXJzUjI0MVFkYUxIWGw2dlIyY2NhaDhZRzFQSzdXdEd1cHlLUWtQa0tV?=
 =?utf-8?B?ZlNOV1pOYzRrUkdjaVEvZTU0KzZUWGR5M0NVY0lHZmVlalJBRm1LbzlIeXUz?=
 =?utf-8?B?c0liS3p1eUtvN0I3NTh1QjVLTFJXOU1Bbnl3dGhaVnZ6eWh1T2x5cjA3UGkr?=
 =?utf-8?B?Si8vRElqWWxpRlpTREp1SGd1b0swc2xDVXB5d2g0bWx3NE5pTjh0S0JsbHFr?=
 =?utf-8?B?a1JEKzdiNnVla0pqb3hFTWhTS25QZTduOS81eTJzdndaTmtBbjhOa3pTQ1py?=
 =?utf-8?B?MWxMNC9CQ0tvZ01lY0FJUWxXa3pFclZzRTdMTVhMK1BlZVFXd1NUZ2JnZ0o3?=
 =?utf-8?B?eVVaajNKZHlVSGkycFdtMU5VSUcxN01VMlVoT2FnZmdQSjFTWGQ4K2UzdFVM?=
 =?utf-8?B?WUtBdldBSEZxNytZaWtRR1J3UUJNRnByNVZuZlZRRFUybDZnd3poTlpKdFhy?=
 =?utf-8?B?M2NoU096SWNWK3BEYjZxcHFBdmx1MjM0U1gwcXdQdzc5U2toM25UUE54aVF2?=
 =?utf-8?Q?pOVnayt3hbcEapZG3pkrQbjw7bpgL+GF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZHFYSVNKOTVXUDVHY1p2L0x6V09FTCt3bXlXUFZQQ0lBc0YwSTJtWmt0U2tU?=
 =?utf-8?B?eDlSU1QwM2poVlFaa2Q1NzEzTFA2MGpOU3JML1A2ciszQUNBWi9ON25FUWdZ?=
 =?utf-8?B?blNYeDZDYWRUVUx4VWpIWmduT05pS2dJbGxmK2Z6dlYwR2ZxZlVvbE1CeEtL?=
 =?utf-8?B?WGVNOHBqcUMxUnVpVnV0S0dkYUZrTTlHTVhXZ3lXOWtKbXUzZ056Sm5TV0Zz?=
 =?utf-8?B?VFptV000bW1jMFJQQklyaWoyLy9CUzlKSkd2eG1HWnRMRWMyMzFnUnIwYnB1?=
 =?utf-8?B?YSttcnhndlBMUHZzRnlIU1dMOWQwM3VaSllIa2JvMGpmekNXdmhpM3lsT3g5?=
 =?utf-8?B?OXZwYVZJVCtldkRZYXp6ZitDd2dyeVgwSnpFZzBPaXQ4RjlQSUpET0tRTXNm?=
 =?utf-8?B?c0czb3FpZlhLVjBjdUxUZXVCUkFLSFhiU1RMZHl6S3lmOEJHdHp1ZG05ZXhr?=
 =?utf-8?B?ZS90WGJWaUNyOUx6akpDWXdxeG84cThyWE5oSjVIYjNXSFcyK3NKZzlyV1Fy?=
 =?utf-8?B?YlhwUFFjVVhpL2Y1V1VQTXk3cW1YSXpaZmdrb1lRV3dSNHJOUXBwOGFES1ox?=
 =?utf-8?B?cDFySHlXSVUyQlBEVU8zdDJWQWFOYkpicTVWd3BCS0JmTTBLV0ozZW1WeXhT?=
 =?utf-8?B?ZkxTbEVKNi9wMi9JaGFSTWgva2tZV1BjNDJXa1BjZHEydHNTc0dWalVXUWtZ?=
 =?utf-8?B?cHlaUCtPeTM0T1duSnhDc0ZrRGRCa29yejhSc05CZDM3VzRPaENoWk5EOHlv?=
 =?utf-8?B?UFo1ZVNtK0gzS2ROMFpsMUEvT09QMjlkVzRZckpGUW5aUkZ6VGpmQUlsN0hm?=
 =?utf-8?B?OWRpbXp2aEJqS25kdmNXZzFsNUE0cFViQ0tWVWJTdm5HV2c1S3hWZ0dPQ20r?=
 =?utf-8?B?aUFMUTVFd0p5aGd3d3diaG9kMnVZTXJoT29WM1VIdm9BMWFWanFOSDJScC9y?=
 =?utf-8?B?ZEdTVUh2R05Jc1lkUVpKeXB5eTJLdzhiR1dKMjd4Z3EzWTRwSUc1T3R2d3lx?=
 =?utf-8?B?SENyUkk5eWFGdnJKVFZKOEFNVHFKVmlHQkJDbE9jTlhkMExDWExFbDhNdmg2?=
 =?utf-8?B?Vy9uMjhEeFRybjhUMUZnWCs1Mi9aaTNpTXg3QngrV0drVExERXVKMlF6NEk3?=
 =?utf-8?B?WWZQVjJBS3NpcVpDZ0tPZXJEazlldjY1eUp2N29QZlNQYy80SmdxcE1reXVv?=
 =?utf-8?B?VVBtUkN0QTB3Si9jN2J3SFJBT2xVM1VMeGZBNjJCbHZUdlhLam1YV0xZRmJH?=
 =?utf-8?B?bjk5RDB5MTQ3QmlhTHFnQ1AzRTNaUU9Tejl3dlpYNUdFUC9nMDg5emppcGJH?=
 =?utf-8?B?ZmNPNW9ySUUwZXVXc3RBdUtONUx0Y2N6WmFLV1R6ck5zKzRNNkRHM0FuYUVG?=
 =?utf-8?B?UW94ZXFPcy9lMUpzZ2FxNHdUVGxXcmRNYmJoV1ZxdVUwUkVNWVFBNWF5cVZo?=
 =?utf-8?B?NmpUUW53bzZMRWRWZlN3aFYwZ0gwM0NrYVc5SDR3ekcwMjI2aEZ4NGJST3JW?=
 =?utf-8?B?Y2cvcW1uNXRGZWR1cVphdjVaZEpGQjcwYytVdFk2Z1NxWCt3TkhyUC9kU0pD?=
 =?utf-8?B?Q3o5Vzk4M3daeWdJQXVLRlFHT0dSY0xKVllpdTBUa2JzU3lPdExsd1NQVE1L?=
 =?utf-8?B?U1Z2V0piZlRvVVI1YW93dDNxOFpwK3pEcWRFWkRxbmdubEZ4Y2RFUWdmT2hh?=
 =?utf-8?B?bmZQb1pTWTB5YUtRUzFjd0E5emJMVWIvNjhyWk12eDU5eDA3L3lXMnJLYXB0?=
 =?utf-8?B?Z2UwaGIxc0RvdUl2MkxGNFdaWitPaFl4T1pDSTJWWlpDOCtPSzRmTU1McG9a?=
 =?utf-8?B?VWhPYmoyZjBLblBTYXkvQmIvT2JrRkQxVmFmUU15QVhSVVVualVTbkcvNFpt?=
 =?utf-8?B?MGFpUjIvVEM4S3QvcWQ5SzdZQ3dINFh3L2ppTjVObEFRelRSWXBtTVJla0RQ?=
 =?utf-8?B?ZUw4ZXJNbk5JL0VwYkhPRStnRlBUQjJuV29Jc3hTQjFabCtUdEUvL2pOVUs4?=
 =?utf-8?B?bWZsVlRGVnVKNDFBNGRKenYvUjFRYTl0QUs4SHdrYnlNYjJVdkVPTUVzZ2g2?=
 =?utf-8?B?d004R0lSYmwweitMVXowUnpzbjQ0K2I0L0JJdUFOOXBub3VkTWVXek51ZWRF?=
 =?utf-8?B?YkIwbG9UVEpKaitqK0szdzMxVjRzc081ZVZmc3laZUVLd243NFBleThnUzdn?=
 =?utf-8?Q?vojalo0DKQorZgMZNuDQsVI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75EE582EAACDF940BBC1DECBCE9FC0EF@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 11469e07-e0d9-446b-2612-08dd550f67a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 20:11:20.7852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OY3Vrk/ucrWpXp2mnchpEFczVACgCkRgIGubcW6tMGWQhVTZPLSqRXa+Hb7OHCeyda3/sCEHPFJB6PdXjP9Syw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6378
X-Proofpoint-GUID: vWWTTTsnw8ymadeWNMzF29-YvZpvaBdE
X-Proofpoint-ORIG-GUID: vWWTTTsnw8ymadeWNMzF29-YvZpvaBdE
Subject: RE: [PATCH v3 10/9] fs: Remove page_mkwrite_check_truncate()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_09,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=855
 lowpriorityscore=0 mlxscore=0 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502240129

T24gRnJpLCAyMDI1LTAyLTIxIGF0IDIwOjQ1ICswMDAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gT24gRnJpLCBGZWIgMjEsIDIwMjUgYXQgMDg6NDQ6MTlQTSArMDAwMCwgTWF0dGhldyBXaWxj
b3ggKE9yYWNsZSkgd3JvdGU6DQo+ID4gQWxsIGNhbGxlcnMgb2YgdGhpcyBmdW5jdGlvbiBoYXZl
IG5vdyBiZWVuIGNvbnZlcnRlZCB0byB1c2UNCj4gPiBmb2xpb19ta3dyaXRlX2NoZWNrX3RydW5j
YXRlKCkuDQo+IA0KPiBDZXBoIHdhcyB0aGUgbGFzdCB1c2VyIG9mIHRoaXMgZnVuY3Rpb24sIGFu
ZCBhcyBwYXJ0IG9mIHRoZSBlZmZvcnQgdG8NCj4gcmVtb3ZlIGFsbCB1c2VzIG9mIHBhZ2UtPmlu
ZGV4IGR1cmluZyB0aGUgbmV4dCBtZXJnZSB3aW5kb3csIEknZCBsaWtlIGl0DQo+IGlmIHRoaXMg
cGF0Y2ggY2FuIGdvIGFsb25nIHdpdGggdGhlIGNlcGggcGF0Y2hlcy4NCg0KSXMgaXQgcGF0Y2gg
c2VyaWVzPyBJIGNhbiBzZWUgb25seSB0aGlzIGVtYWlsLiBBbmQgW1BBVENIIHYzIDEwLzldIGxv
b2tzDQpzdHJhbmdlLg0KSXMgaXQgMTB0aCBwYXRjaCBmcm9tIHNlcmllcyBvZiA5dGg/IDopIEkg
d291bGQgbGlrZSB0byBmb2xsb3cgdGhlIGNvbXBsZXRlDQpjaGFuZ2UuIDopDQoNClRoYW5rcywN
ClNsYXZhLg0KIA0K

