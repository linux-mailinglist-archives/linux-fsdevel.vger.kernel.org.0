Return-Path: <linux-fsdevel+bounces-37752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3739F6DC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 20:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445A216869F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 19:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8BE1FC0E3;
	Wed, 18 Dec 2024 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C32OFSgz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008A71FBCAF
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734548823; cv=fail; b=a/u52j8I1pQ5dFRkoMrUrwmcgXkfaIfXHhWcd5CjqRRlT4sv8laGdU3ydNu7zsN234VIDUZXjLH6EP8OOK6R+PG/kIuyKichMGvCknjj7vjolbnQiNBFrn761mHCR9lST0gLWgn1+yN1SAj/4aZqB+p7ahetNhmq2o+9Bt/+vWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734548823; c=relaxed/simple;
	bh=DCCe6zha4X7lSsYDb+1QRh9CS3pHhxneTFlX33V31dY=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=WZhRboZbMz9U+O1Ai0Xejmwef19EN502Li4tiCMaA8mKCoK98khRMcBV09KPbPiy4sNhF+VQmdftbn26F7JLD0lzMDgZ6QN3GitBFcT78tPHQd2JvB/WrDuN/xb/CSKEbbZ+yCA2IVTUu+u1kPwOUJWyHjHsYcHHKA4lB+/IS5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C32OFSgz; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIDEc12032000
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 19:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=DCCe6zha4X7lSsYDb+1QRh9CS3pHhxneTFlX33V31dY=; b=C32OFSgz
	W1fovsmv8baWq/nHNBAcCgwcQHVSyx6sPAe4FCTj3/scmopxLvKN4pm5mMRPePXm
	Jr4VPB/SUvwJO8RsMwpiAJz3EpVr6d7qdmB06JXM3+WhV7KVXWnPGDqLO/kvbtgc
	C6zfU0kYH+LJ74HZHdYXXKDF59k3iLJm4pheh6q21UtgLpc+sM5OlC9C9W/hmXB8
	jSRT0f3OP+9YyML8qVADIz+j6hlHRc3mw2wiN7OmGHfGSW/DgvzGayZrEcXOYSu+
	zChntUxJDT9Ye5+ghjGcHZw0MSdNoASb2Be9DGNxwoiRhOXk70zkzhScQiw79wwj
	b01NYJmBIRbFKQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kkehcys3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 19:07:01 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BIJ70JV011765
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 19:07:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kkehcyru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 19:07:00 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BIJ6Bri010036;
	Wed, 18 Dec 2024 19:06:59 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kkehcyrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 19:06:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrHzX24YJEdPd4tDjvzn7X1oQSZOG0AMgu6qOJmpEZxDGAVJ1iK1RFtEDZRUv+bX5yTNy2C1SxvxNARh5o8A6XPDO+PWU2XWtyOGmz7oI5tDYP3E1PToJr0SDUAiZkA+Iucu+WT2t1yoap3/KUcn7iZZgITcD6L+6i3Ejani8HIgWxgjfhEijAhX/S//t8mASwUxuYpuvbLIn+oa2S67C2D1HYPza1tq0xQ2iszNkESiAtLV3tGC/J9RyXFuoJbDHFPaqu55kyHJ06o6J/fsBvdb8Amy1sJyo3qcc2Sc70uIgrZ/K5G58CWmzM0ravFwY7+tz1yTtLqqeEnXalMR0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+BiAhZ62INDmjtI5oceIjRIB+fAVn3FRCO3nKmUMTg=;
 b=LvwSc4glFS+U0J1dX0eQ6sYwj6nW7OaAekBolKl4+1U1+hx4ufQloyF+VHj/4vIjuIRAJItESLsT/jHdak1WHIjACQpG/jN2i5Tf8kvhRmokOWojPvtzc1EhL2axewvq9f59mPkdiUsYfsuconFUlnRpC1y8Nlim0OZkYwhC6fQJSYKyhp504i6LSB4wR5AuqOzj2d6tIfavttrFLTjLebnwdFLNSpSR1S1B/0YFSDK9Ko4/CLBmM0Gc1U4/MbJWFac7mLJWVrMdTB/fQtyqcHtndlF2nyMEvsJJzFQYz+HZTo8ckIlosl6oIJc0VltryR8K2nuzgsYgWf6ejcFKvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ0PR15MB5177.namprd15.prod.outlook.com (2603:10b6:a03:423::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 19:06:56 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 19:06:56 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Alex Markuze <amarkuze@redhat.com>, David Howells <dhowells@redhat.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Xiubo Li <xiubli@redhat.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "netfs@lists.linux.dev" <netfs@lists.linux.dev>
Thread-Topic: [EXTERNAL] Ceph and Netfslib
Thread-Index: AQHbUXtV7qr3w6JalUuYJwvYT2Fq0rLsXQwA
Date: Wed, 18 Dec 2024 19:06:56 +0000
Message-ID: <1729f4bf15110c97e0b0590fc715d0837b9ae131.camel@ibm.com>
References: <3989572.1734546794@warthog.procyon.org.uk>
In-Reply-To: <3989572.1734546794@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ0PR15MB5177:EE_
x-ms-office365-filtering-correlation-id: c9fbea2a-7a91-4e7b-c0a1-08dd1f97246f
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YXladldCaFMyL3VlNkR2SDN0RU9ONENFakVoSklHcVBITjZEMkw0YjMwN0VG?=
 =?utf-8?B?LzNvMml2WlJySUp2eHROZksxZjVRVlNyUnl6S09PWkJqbGV6YXhiZjMva21L?=
 =?utf-8?B?bDVGcnpYbGxVYjEzYXBBcHJsck01WHFJdDYwTW45bDk1em1DbjRrL2FaVk1j?=
 =?utf-8?B?V2p1bkliS0loMHBiWmJQUVVXRmRMbXdIa25xdmprR20zb2NQTm1uVU8xNWND?=
 =?utf-8?B?b003R3FzakRnQitJTGZ0UVYzanNKeTFlOEZmN2t6TytSejBhcTcvTS9VUWZC?=
 =?utf-8?B?SGxZNGkwc3Jub2diNE5YeHM3MzNFSnBLZFFDd0lMMWZOL09jSk9QejB5K0sx?=
 =?utf-8?B?MEYySHNhZTR1UGcxK3BVR3NHZGd1THVqVEI1R3hYNnZzOVNzVDNCdlhmb1VV?=
 =?utf-8?B?clJNNDhHWjV5b3NBZldxTEVjREo3Mk9XUnpTK0FPSm9qZk9MZnQ2M0QwS2ds?=
 =?utf-8?B?QXg4OXEzcWRjNVA1YkZxNDI4UUVSRG4xQkVJejQzc2cyYnltZzVsNmJocTN0?=
 =?utf-8?B?Q1dCQ3lpTjlScTJDYXZNMXUvc2tleDBLTmUyUkdId0MxQ1d6ZDRtN2EzaHpL?=
 =?utf-8?B?SW5RODV6c1hxVUtGRFlTdFhnMnpMOTg0M1pNTjJOM0l6WENzKzdqSEZJRi9V?=
 =?utf-8?B?VFlJdnh4VEY3M0hXNytGUUtYTTNJOU5uUFBjdDBsV1BYNldCcVpjL3Nuc0do?=
 =?utf-8?B?ZXN6UE53ZjJkbGoybGxNOThCUDRDL2plMFZjZmdQcEczSmZtYVQ3WmlhNk5E?=
 =?utf-8?B?WGlRdlEyK2NBTnB3bjE4UGtpVEFOcVpCTVliUUswa1FZS1dFZ3ZXYks3MTA4?=
 =?utf-8?B?M1orK3FRSlRXeXY2R25RQnVXTEJ3dDRwd2dGZ3dSUEFiNnZEdHFUdW0yekcy?=
 =?utf-8?B?YW5NNHc1SXUrd09jSjZGVnhtVmFGN1VEd0grSlRJV2hKSFFtdVd2S0tGU1Zz?=
 =?utf-8?B?VXNUc0pzeWtaN2l5NUlYMWxnUWRhTjFpMFN1NDJvUTZaZG9MWkUwbWNaVWtX?=
 =?utf-8?B?NmlNRDVxK282a1NEYXluMHgxeDIzRzhwWkdoUEUxRnVCUjJkRnhVV1YwVXcr?=
 =?utf-8?B?RDNLbytBeWIwcVBuMEJzNkFGNEJNY09SUjVScEdOQXg5cEw3Zmovd0FRTFFh?=
 =?utf-8?B?THg0djhEVC8vL01WcCtqV01veFE4cHoxam9Zb1ZndVhPaWs0aVBHQUt2dXYr?=
 =?utf-8?B?YnJPMllCdERuYnBpcUlDK21SeG9OL0RUMFFmR3pYNHVzOGFEQmtBellGTzQz?=
 =?utf-8?B?S3hEbG5zTlFxS1o3blc2dlNkaExBeklDZHNGSkVLQzkxdG1jSWVOcDI3WmpX?=
 =?utf-8?B?RFhSNC9tdGMxQ25Ja2RiMWw2NFhVY0gwbis4U1RndEZHL2FTWnhpTksyb3o2?=
 =?utf-8?B?Q2gxSzBwTE51R1hZbjNHZlVZenFkSXVVZE8zMzRZdmEwQkxEa2Y2bGZ4Ykp0?=
 =?utf-8?B?RDBHT0dkWER3Y1I4WU1tR2xQSnBacFBDQ1M5RWtEaWVnYkp2MjFMR0VLRTVW?=
 =?utf-8?B?Q1Q3THd1dGYreHA5aG16dzRlQmV1SUxGUU5sR01FS2ovVG1UcHNWTEZHeWow?=
 =?utf-8?B?SHR6Q1U2bFY1WXRjNkdZUFA0Y0E3SzFaZmdkczFzQ3dtb09KU2JuUzNKRlU1?=
 =?utf-8?B?ZGUwZXpSOTV1ZUQvTmdUb1BaOXIyYTNOS0ROUHJ1cEZIWTZQRXZDTjVpV2M3?=
 =?utf-8?B?ekoxa3ZoQzFvSFpPRGc5cnE3ZE0ra1BkZW1maWtLbE00Sit5L1I0aTQrMVhP?=
 =?utf-8?B?VlVzTXk0R3RXWDk3bnloeUV3NkJqbVZvSWJ5Q1BUMmoySWV4a3BSVGFMZDgw?=
 =?utf-8?B?WGRIVnY5QVJCWjJleENIMFhyVUFMbnlDRkRBdUd1RGpVbU1TYnIzUjFxWDhY?=
 =?utf-8?Q?T6twTe3Yh4VSE?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bWNzZlVpRGJwTDMrUkd3Zk5xYVJBWEN1eU1ZN1pTU0h1ME9RUG5IK0FrUFZX?=
 =?utf-8?B?VWROczVpT0drcGFRQmYrKzJBRVpYT1JTNlBOckV5YTc1T2p3Tjk0UUxFNGpH?=
 =?utf-8?B?M0x0TzVuYWxnWTRrTmFDMURWTWR6M2t2eWZlVmlnR0dheGVDYTh0b0QwVjJS?=
 =?utf-8?B?L2k3Zm01bEh5NGxGQkdaWVpMellhL3VndGU0V3pPYlAzU2EwTmZ1ejc4bktG?=
 =?utf-8?B?cGFDc3RERXRTOFA0TWlMREsrZldya2RYSi8vTmZlaUcwZllVV3JzWkpWdU9k?=
 =?utf-8?B?MEZ3SWo3a2pHakxOTmdSRU9EcGdwY3IyTWJNVnVoeGlNREgyZE13Z3JiYklJ?=
 =?utf-8?B?d0ljUXU3SE52ZzgraXVMUklCaEV4dW9RSllJOGFwQkpTeHY4eWt6UG5oVTRD?=
 =?utf-8?B?RmVtZXk5NlllT2JyQitsaVVHdmp1ZjR4K1l5UTVpWERuYzRQOG9RVExDelBk?=
 =?utf-8?B?bkRxaHM5dy80dk4wUURYajlyUEFSOVg5S05jRVl5d0JBV0pPWVNJMWhOdzVo?=
 =?utf-8?B?di9zSExQeGl6RG5YNE5oYXV6YnJtcjBNRFVPeTRSZWhRRnp6Vk81YTJVQWhM?=
 =?utf-8?B?TUh2bG5WL0N1MGdRY3lrblBMUVQ1bUp6eXN1MEZNeWJiRmFxVitvNThKM1JL?=
 =?utf-8?B?RTMwMFkzT1hlcGwxYmV0Z2MyTlRiRUpSRmJGZHpScGZhUTAwUVpRK29wWk5Z?=
 =?utf-8?B?NzZyQ3pKVmt6RytIWXo4NUdjWTlEK0RsK3NSN2RUQXAvWUNSRjRFQ09WeDcx?=
 =?utf-8?B?akJpa1BMWURuaSsxK0xZRmhyWURUQWd6QTJXRjN2blh5T1kyTTk5UVhUREZh?=
 =?utf-8?B?VzBycXNsMmdoOGtRcGVaaUN3dGczcEUyNHdoWnNQNDRjY0ZrcTBXcEhPYUk3?=
 =?utf-8?B?M21iR3UwTUJPS3A2aGVNcGNzV1VtTUdVNW5WSVJMenJVdGYwR0FxYVVlUkdU?=
 =?utf-8?B?L3JET1lJYXZqdHFXQUl2NmZrejkwU3NHM1pjKzE1RE5lUjdHRlMrYVQ2aFFq?=
 =?utf-8?B?ZldHMy9kY0VwR2kvRmxHdnhCSWFxaXc5OEVISndpQXoxSzZ2a2VDbzhXamhD?=
 =?utf-8?B?elp5QUVhWWhNM3JCT1FBVjRqUUJVbkg3SkhNY09TR2s0THVLVTMvR082Z0Fn?=
 =?utf-8?B?a3ZvdE5KWEVJN2xvL0w5NFVNUU01VE4zSUZRYiswQWhTVkZhZWkxQTlCTFZW?=
 =?utf-8?B?aWdneVQ3VzlBUlRZS01kL1Yyend1OEdSZmZQbmpVTUVGMG5hdW9paitpK2lO?=
 =?utf-8?B?eDhNUEtqOEpsUFpha1liT3ZYSllhai9UL3NudXdWUGNQajJiTml2RGJDOEF4?=
 =?utf-8?B?d0ZoOVU1SmxXY3Fna0dtWnZ1d2lhYzRnbVAvSVRDOUpOUVlneE1sOWJVMTU5?=
 =?utf-8?B?RFlnOFN2VFZ2ZjQ3RFU3dDVqb0JEYkNoZ1N6YWdaNUpmclE0dHRoUUV2djZL?=
 =?utf-8?B?T0FNdXdVZTVTRmpmNTZsTHJtSEl2Q3JFMzUxdzczK2pwYU9nOC9BMHlqWXBM?=
 =?utf-8?B?MkNNWVphOWdJUVo2bi9CQm44cVRvVm9wNWdpYi9PNHVkalY5ZDFybk1mbTdT?=
 =?utf-8?B?ZjYzTjY3NDFFbHJ4SDY0a3ExZnB2UnhXR0ZNTjkzUE5iZjFmMGloWEFyMUs3?=
 =?utf-8?B?VWpqbW14MkZKOExieERGcW5ZeVhJVkRPZ1ZCclBXU3IxZXlWUEE5eXFFREgv?=
 =?utf-8?B?M2lsYm45V3huVE9TREtYOGc0RWxYT3E1dm1Vb0U0YWp4L2I0QlAwWUVFU2dN?=
 =?utf-8?B?cU5hbXNaQTN6NFpiMGxUTENlc1EvdTFMT2pIV3BscDJmQ3EvVHBFNGd0dFRp?=
 =?utf-8?B?d1puNzBESWtCcERycXR3eGJjYzlTK1lZK3R4SERodVozOHp1dllDbG9RV1kv?=
 =?utf-8?B?eDE0SGZZN3B5YWFLdzdQYnZiWHdoZG4rMVpDNStHVWxCNFdQK3RzOTFHVVRr?=
 =?utf-8?B?elQ2MFNWbnJQeGRjMG84bGs2cU5aYzFTV3JZd3ZRSEROR0tmVnYzVWJaTmhJ?=
 =?utf-8?B?MTNUQzhVSEJFd1FiQ1Z0RWR2OHNqb2MydkwyU05nVFJHM3hFYUJoUHhLZWlq?=
 =?utf-8?B?Tk1kb2duODJxZHdhM0JUdXZ0bWRjSWd1dmJ3K3lNeDBpNU8xalNoeGVnbkRP?=
 =?utf-8?B?OFAxcEplVlVISzVaSk9QYVpaQVZOQWxSRmh3VmJ3M0ZvaFRlRFMrbGR2UWM4?=
 =?utf-8?Q?mBcBwUSiaj6nvxvXR99O2CQ=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9fbea2a-7a91-4e7b-c0a1-08dd1f97246f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 19:06:56.7863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M040SukynQ7oLM3T8CDFoSxptNysiQOagL+rakhPUBtHeHho1J6OcvyCDWoFOuW9exR9dnose/MXUV9Q8FZZ+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5177
X-Proofpoint-GUID: wsHOLukm5qJnAcbNnyYYPLwv0L561NQ7
X-Proofpoint-ORIG-GUID: OZDkDECupIlFuZSqrsAvKTMK758Z5saq
Content-Type: text/plain; charset="utf-8"
Content-ID: <23D1A3AA516E904FB5317A3FEC591F5B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  Ceph and Netfslib
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=2 engine=8.19.0-2411120000 definitions=main-2412180147

Hi David,

On Wed, 2024-12-18 at 18:33 +0000, David Howells wrote:
> Hi Alex, Slava,
>=20
> I don't know whether you know, but I'm working on netfslib-ising ceph
> with an
> eye to moving all the VFS/VM normal I/O interfaces to netfslib (-
> >read_iter,
> ->write_iter, ->readahead, ->read_folio, ->page_mkwrite, -
> >writepages), though
> with wrapping/methods by which each network filesystem can add its
> own
> distinctive flavour.
>=20
> Also, that would include doing things like content encryption, since
> that is
> generally useful in filesystems and I have plans to support it in
> both AFS and
> CIFS as well.
>=20
> This means that fs/ceph/ will have practically nothing to do with
> page structs
> or folio structs.=C2=A0 All that will be offloaded to netfslib and
> netfslib will
> just hand iov_iters to the client filesystems, including ceph.
>=20
> This will also allow me to massively simplify the networking code in
> net/ceph/.=C2=A0 My aim is to replace all the page array, page lists, bio,
> etc. data types in libceph with a single type that just conveys an
> iov_iter
> and I have a ceph_databuf type that holds a list of pages in the form
> of a
> bio_vec[] and I can extract an iov_iter from that to pass to the
> networking.
>=20

Sounds like a really good idea to me. Makes a lot of sense.

> Then, for the transmission side, the iov_iter will be passed to the
> TCP socket
> with MSG_SPLICE_PAGES rather than iterating over the data type and
> passing a
> page fragment at a time.=C2=A0 We fixed this up for nfsd and Chuck Lever
> reported a
> improvement in throughput (15% if I remember correctly).
>=20
> The patches I have so far can be found here:
>=20
> =09
> https://git.kernel.org/p=20
> ub_scm_linux_kernel_git_dhowells_linux-2Dfs.git_log_-3Fh-3Dceph-
> 2Diter&d=3DDwIFAg&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3Dq5bIm4AXMzc8NJu1_RGmnQ2f=
MW
> Kq4Y4RAkElvUgSs00&m=3DIdnhHmTDiQZNzP_zbJHD5PQFfO3U8UaEuGpDubyf8fFXBu4KQ
> 7NFE-0OklCCoqtp&s=3Dv_tEim-OriGJ7-Mwdc9jHMW6Aj_7RKr5ZwGwjg5gfy8&e=3D=C2=A0
>=20
> Note that I have rbd working with the changes I've made to that
> point.
>=20
>=20
> Anyway, ... I need to pick someone's brain about whether the way per-
> page
> tracking of snapshots within fs/ceph/ can be simplified.
>=20
> Firstly, note that there may be a bug in ceph writeback cleanup as it
> stands.
> It calls folio_detach_private() without holding the folio lock (it
> holds the
> writeback lock, but that's not sufficient by MM rules).=C2=A0 This means
> you have a
> race between { setting ->private, setting PG_private and inc refcount
> } on one
> hand and { clearing ->private, clearing PG_private and dec refcount }
> on the
> other.
>=20

I assume you imply ceph_invalidate_folio() method. Am I correct here?

> Unfortunately, you cannot just take the page lock from writeback
> cleanup
> without running the risk of deadlocking against ->writepages()
> wanting to take
> PG_lock and then PG_writeback.=C2=A0 And you cannot drop PG_writeback
> first as the
> moment you do that, the page can be deallocated.
>=20
>=20
> Secondly, there's a counter, ci->i_wrbuffer_ref, that might actually
> be
> redundant if we do it right as I_PINNING_NETFS_WB offers an
> alternative way we
> might do things.=C2=A0 If we set this bit, ->write_inode() will be called
> with
> wbc->unpinned_netfs_wb set when all currently dirty pages have been
> cleaned up
> (see netfs_unpin_writeback()).=C2=A0 netfslib currently uses this to pin
> the
> fscache objects but it could perhaps also be used to pin the
> writeback cap for
> ceph.
>=20

Yeah, ci->i_wrbuffer_ref looks like not very reliable programming
pattern and if we can do it in other way, then it could be more safe
solution. However, this counter is used in multiple places of ceph
code. It needs to find a solution to get rid of this counter in safe
and easy way.

>=20
> Thirdly, I was under the impression that, for any given page/folio,
> only the
> head snapshot could be altered - and that any older snapshot must be
> flushed
> before we could allow that.
>=20
>=20
> Fourthly, the ceph_snap_context struct holds a list of snaps.=C2=A0 Does
> it really
> need to, or is just the most recent snap for which the folio holds
> changes
> sufficient?
>=20

Let me dive into the implementation details. Maybe, Alex can share more
details here.

Thanks,
Slava.


