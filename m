Return-Path: <linux-fsdevel+bounces-71780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E37C6CD1C1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 21:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78A153062E21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 20:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210F533C535;
	Fri, 19 Dec 2025 20:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cth9RO3Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76DE2848A2;
	Fri, 19 Dec 2025 20:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766176185; cv=fail; b=WQjK16cVkHqctVCGzMwXbvyM4gIHbkkhWFfaNNU4ubYEbk/CBX4b8UB6fjAccM9FgtSod46WaduwTwaDoylIe/UqEQZPSMtlWN6RsWpVyipdrP9u7yImy/lWaaii2uDJsh9tnwAf5REwb+9PSc/3QVyIpnFgjElJ0PIMsxfumUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766176185; c=relaxed/simple;
	bh=4/RmI52FAKy+Zz3Gue0cqHin4WORiKs4lkNoe5J8LLc=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=HCBehIKECGReqjXpCwJa+gHTCQFD+evKhI2eAql+KpQhOb1I1NLM/E5mhqcGEKg1IKxSILoDtCVrZK3c8u7CucVlkurR/2YEfomt0x5y85d7XhRKGHkTcihPpa3I78GEhuijsA5h6VqsmfRxjUNY6Vlnxc7JAa9qAMwEl47V4KI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cth9RO3Q; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BJAg5RI004577;
	Fri, 19 Dec 2025 20:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=4/RmI52FAKy+Zz3Gue0cqHin4WORiKs4lkNoe5J8LLc=; b=cth9RO3Q
	ZmO3gRuQM5vNlg4sZQzb+FNQ0fasoLwhElRPl9i813zE8tACp6Br9AAF3qjq5Xvq
	3+xT4r4Y2zWYG7DeHeI+vKOX7FOnLJXFyf5+YV60pPykOzlKDYCOurAWymfm7+U8
	HVITtPku+BNT97xWPoMSkRRS27ZpqNGUHrt2yDlvynPrzI8Zxt5YRAKS8yaXxdTD
	o1WjQYjxKvT1ryCbLo9aJwZ2HUUUtf9Q150mV8Q0KzWz/6Y/1LyUCDpXtB7BPddc
	wrd/1UkpRuWggii+tubcaNgp5HI51jfZAfDvOVDHR4D8n2sRLyU6ch6GtZwcvbWn
	KHY7bn/DXjvQdg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b4r3ank3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Dec 2025 20:29:39 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BJKTd9n010973;
	Fri, 19 Dec 2025 20:29:39 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b4r3ank3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Dec 2025 20:29:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkPSCi8VI2AoDRxmf1lVFL+lJ9crR+0R0O9m3mbbFcNEbVn4PzOQVsthRZ6dyi4+cwYZabMXy5JFkhijbdiUFAcPpl+Kq6CKrW6T/qd/0v1BdxgafsAeaq7ZF4dWV/hiO8UVYFxjJWaZe1QfE7Q/OQBflLaOgUKr90iWDz45SMX1BiSHrWXUhu4E3voByvD25dC5cAkgUYwzcg1XjZb3P/jeSZs0Zra7kT1tcaGSGqipONxqnQtwmwp08Mqg/TWCzsFNv19ockrJlusbuZrMqmLFAyTT9af6tgpZK8mCinxuwEJTnCiapuYnleELnPLWyjR0zr/ouQdENdnwsLhOYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/RmI52FAKy+Zz3Gue0cqHin4WORiKs4lkNoe5J8LLc=;
 b=O1ODAP2KDgE0iVE8xgKzDwIoaxIoGo64WePzG0Ib1WjY5dgjEm2wAPF+Lt09K3MGVxPEJ5fUL9P02rgn0yQlAuYGOCzOgQqTONdC6HdXFYFbXBiOcbMJ9hDJUXL2ZZB2HVJeULLDbHTlj/j0B0/M7cHKsVkR7STGDH9lWZEgj/JFlbN29KAFeo88jlJpZqpPWUIY/4KQXywUTxKG/BjStvzB64yAUtOwmEn7rcGUSYwe0W8DynfanQBGf7m4Upopc9ZR5oL/qQ+zR/iTEnKBtGu0Eaer2sxUFiI8dvYTsTFyEEHmGBQqAbO6K9scRYR8BUMG9/cFlDbX+++/RNhaag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BY3PR15MB5042.namprd15.prod.outlook.com (2603:10b6:a03:3c9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 20:29:36 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 20:29:36 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Patrick Donnelly <pdonnell@redhat.com>
CC: Viacheslav Dubeyko <vdubeyko@redhat.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        Kotresh Hiremath Ravishankar <khiremat@redhat.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Pavan
 Rallabhandi <Pavan.Rallabhandi@ibm.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] ceph: fix kernel crash in ceph_open()
Thread-Index: AQHcb5TpmMeL+RYIakuRlVP/l+uM0bUmTK4AgAB3B4CAAql/gA==
Date: Fri, 19 Dec 2025 20:29:36 +0000
Message-ID: <f36a75dbb826b072a2665b89bd60a6d305459bfa.camel@ibm.com>
References: <20251215215301.10433-2-slava@dubeyko.com>
	 <CA+2bHPbtGQwxT5AcEhF--AthRTzBS2aCb0mKvM_jCu_g+GM17g@mail.gmail.com>
	 <efbd55b968bdaaa89d3cf29a9e7f593aee9957e0.camel@ibm.com>
	 <CA+2bHPYRUycP0M5m6_XJiBXPEw0SyPCKJNk8P5-9uRSdtdFw4w@mail.gmail.com>
In-Reply-To:
 <CA+2bHPYRUycP0M5m6_XJiBXPEw0SyPCKJNk8P5-9uRSdtdFw4w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BY3PR15MB5042:EE_
x-ms-office365-filtering-correlation-id: c847b439-c10d-437f-cb07-08de3f3d53fb
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YVdBR2xKUTlpY2RUWlB3dWhFUzR4bFZZY3B1VWVURFNCVHNVTjdmR3BOb1Jp?=
 =?utf-8?B?ZXliWjJmU2ZKOHF2aEt2WmZyY1BBNFVsc01DL1JybWd5TTdWd0ZXUWhJeWxS?=
 =?utf-8?B?OFQ4Z1hQcTRqWWdOaklFczRrUEhyK0dyRFVRcFk2RHBlVWVZQnJ5M2llM3Rm?=
 =?utf-8?B?L0pWUWRqYm56VWZ5d2lGYm9FSEVFU2dMaEhJVkpFM3h1SmxjbmcyNDJ2K1Zw?=
 =?utf-8?B?S0J6M0lSVXpkU01FWXlhdkpYWUZISWtuOUd1MlZybmtkNFZaSFFJa1k5M2U2?=
 =?utf-8?B?Q09DajBkdnlNbEtqdVJOMGZORFdCeWJXWi9NMlZTd0pYdEhyYVQvWCt6c2w3?=
 =?utf-8?B?TFRCSjZtYm5oTkxreHBXTkNpbmF3aEdPVFNsRHFsazdrUUlrWTRtc09LblB4?=
 =?utf-8?B?a21pOTdoZjNWUFBjMnRFSExML0M5bDY3alJnbU96ZEVKZFlkSll1R3ptQ2pS?=
 =?utf-8?B?RzJnTkxtKzF2TzJ0dVE2dTBoUEM1ZkYzV3ZjZ1daMk1RS1M4d2JyMEp5L3RU?=
 =?utf-8?B?ZG5WVjlnRldicWxCKzhSZ2xhQllRb1F4MFl2MWxna3ByZHc1ZmJwRnJXMEw0?=
 =?utf-8?B?MzlLeVlJVHZtUXA5SHhZL2lDSjF2YytCM0Y5UE5YUjh3L1RORVlLV0JzdG93?=
 =?utf-8?B?djNtcnpVUlBXZW03djdWaGF5aVNPRUlQTW9aSnZCVHIya2xiN3FBclE0SC9p?=
 =?utf-8?B?MWQrTFYxKzUvN2VsNTg3Wmw0cFBha1ZLYnFUZmd6L2ZWUmFmdnZ1dXk3Y2Z0?=
 =?utf-8?B?NTM1bGpydFlUcjhjZWlaSHNDbm5pMWtWTDd6VVNJS25DazZRNzQvdlhOdzRi?=
 =?utf-8?B?ME1lQy9YUHBsWHI2cHF4UWx6U04vRzl0MGk2N1N4Y3R1ZUdmTlI3M2lwMHNv?=
 =?utf-8?B?RjQraVpNci9qbEp3NnplWis2akVlQjhpbzdWZEJFN1ZiWENiVW9uVVgrc0lR?=
 =?utf-8?B?RitTNThZblQvajZoWk4yNGlNdCszTVJSd21weVdreGRJbWcwR01QVnVEUjFj?=
 =?utf-8?B?a3NQbHBGaTB6bFo4YlBacUttQlFGdUdVbXFaT1BuQjU5bW51dkpZWTErTDg3?=
 =?utf-8?B?VkdXMTVOQytlclBENXZZb2lMaFlidENVaUhveUtvN0lPYWdBT1dVWlBGekdv?=
 =?utf-8?B?VElsUGJWdDVVdXpyb3paMnBWNmhsOVV6dHV4TnRqNk1hdmVIYlpiRzBEeXFu?=
 =?utf-8?B?TkZTMDNaMjJOdEo0RG4wb2VUQ1B3M1Z2aTFtQ3Bsem1MYTlRY25ocGZtZlB2?=
 =?utf-8?B?YXV6YytEZXlKNkNsZ216VUVlUUVLMStWVVU0MGhtNlVsM3Q2a2k5K2E1Y1Rt?=
 =?utf-8?B?YjNhWktYRzBUaVBsd1NMYjRZS3pRM3kvbEdPZVVlYVJ5K2RJTlRWd2prT0hn?=
 =?utf-8?B?aGIvQjF5K0NNYkZ5cXVuak1kTlJZdWx1b25FSCsxaWJqczlHSFhwd0s2aU00?=
 =?utf-8?B?andIcXRaeStVelRJUGZ6STRyWlpIZmtrZWltOU5rRmd0VUFUK2tHbTM1eHA5?=
 =?utf-8?B?ZWRQNEdCUFBoY1J1K3NRS3MyOVpPaFNlTzFPOTY2Sm1TdWdIV3luNmlmazV3?=
 =?utf-8?B?ZmZEVFErYXFRVlIrRWNTdEhxanFwV1RxaU5lV1p0YWh1OWM1b0VUbHVzamF3?=
 =?utf-8?B?QlN0Qzk2OEJOVjVJNWdhbHZvYVpPL2dsV2ErOTk1cEFkelZTbWgrUjQ4NCtX?=
 =?utf-8?B?aitoUjBCQzFDa3JwUWZNVjJBb2hONnJTNktSMnJPZzFJK201cW0rQjU0NGpT?=
 =?utf-8?B?V244TnR4SVgyalNCUDdsbm9peVFKV0Z3YnZQUThLbTgvSjdoWVFYQzYzdVlv?=
 =?utf-8?B?NXRjM0R3QmdiWUdROE9YOGZKSGFyQVZlOXFMSlc3ZlVtTHF6SU43WTl0VGNP?=
 =?utf-8?B?TXN0WTFMTFpOWmp1cnljZlQ5ZE5QV3RVUEptb1JuWTlUZ1ZYWmJJWEdWK1dk?=
 =?utf-8?B?V1pwMHdIM00vWGM4bi95K0VUUVJULzEzUlREY2Y2TVdTaFE0OTVQVzdITTl1?=
 =?utf-8?B?V0t1aTlKVHRRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WXhMb083S25oUDIrNDZSbkExb0dFVWFsVmhodWVpeDNiZXdsSFRiWUo0ZnlC?=
 =?utf-8?B?by9UclVyTnVhcDlqZ1ZNd2NTcUl3NTEya2cySjY0MVFwRTQ3dUxWcGJ0TTFT?=
 =?utf-8?B?NXE2N3hWYWhXMFdwNGE5ZUQvSjBPL2ZmODB4YmNrNkpDZGZnYlpINVVUTTZV?=
 =?utf-8?B?WjdhSVo0RzFaT0lkNVMyajNqSytvS05tWm9NaWJ6aG84WlhuS1NPMVZZaHF3?=
 =?utf-8?B?enJ0aG5VeldKbDRsSUlRTkFKallOLzNVRUxwanJaeU5zNjllWW55MUdqYkxu?=
 =?utf-8?B?a2dIR3VQcGk5Q2ZGN3BIVE5WRW9ibitMVHlleVNneXBUVVRsVTJNbDVHdGlv?=
 =?utf-8?B?c1UweGtTeElLZk9RUXdnVGhEVWhleU9xdElxdTh5Z0ZaVWVsS2w5NnFaaEtx?=
 =?utf-8?B?WWhHaEZXVXRMY21qNDRLZkFZTDdhTEtvSTB1VXIzOE9FUGZWR01MeklCN1Qr?=
 =?utf-8?B?SGJNdjlPZVI1U0JEdm9hMmg5MjhwTmE3NFRjUDYzTFE1NUtweisxTHFIbVkv?=
 =?utf-8?B?blA0bnorbGkwbDZXQjBSTDh6a1NVUUc5QWZvRDVOYTJORUI1NWxYNHBmZWtu?=
 =?utf-8?B?NWNBTmUrU0ZtM2lteXk1ajloek1TZVNuY1drZFlTYnZlOVJOOVdXR1Jabk1s?=
 =?utf-8?B?b1dTeXZ0ZzlteG1mMS9TdmVxazQ1dGYrSkpYQVY4aXp4NFprWW1KSmhQZFZF?=
 =?utf-8?B?a0ZyNm5nK29FQk13YlZVWjZKeWt2ekM5VmY2MDJWT1lHL1ZiZGM1ZHBpNG5x?=
 =?utf-8?B?b084Yk94cy8zTG5vN3NYZjJlUUl4bWNxWTlWYUNtT1ZGRFN1L0RyRXRBR1JF?=
 =?utf-8?B?ZzcrZWtmK29BeXhjK0l4VjhlcjV4cHRFMmhwMU4vTmNKWis5dkRwZXdXcVg1?=
 =?utf-8?B?VDIzR3FkZXpsQXFHRE5GaytmNTBoOUNOeVphZVBSVEhHYUlpRkZiZkJ6Ylc4?=
 =?utf-8?B?OHVUb3l3eDdCZHozS0VWcVlmUVdISHJ4STA4OHdINlhkQllNM1RpTVdVcVMr?=
 =?utf-8?B?blIzbUtnd2ZBQW1IUTVOaUN1UU5CTlczTUxDMjBnVWhzRkRtMmFuY0pKRjlW?=
 =?utf-8?B?VDJmUG1kV0pMMmNjVDBVRGVPZ3JzeU9PMTVrY25NaTlybG51enNjR3VkSmVY?=
 =?utf-8?B?b1U1Z3NkU25GcXlOR2lrMjd6czlEZTBDdWRTNHB1YnBSNkVkQy96MGVMaWJH?=
 =?utf-8?B?M2luWS9vekJjVEFMcVpPdVdpWFNSZG10b3RqTW5POEhlSWJvK2pLbkZUMmFj?=
 =?utf-8?B?UUl0bnl5VEhFaFdzalhFbHhZUnRpbFRXeVV3Wmg3MTNpemV3QVVhdUNNcW4v?=
 =?utf-8?B?U1AyWUpUUzVOb0FrTzNmTmczVGh3ZVZMcTFDaE4yS3JETUFhSXBZVXJPdmtC?=
 =?utf-8?B?aCtZNWdydll0RU91YVlKRXg5YVRKRTZDS3prSXFhRmxobzJxQ3MzcDNmL3RG?=
 =?utf-8?B?SWpHdXdWRmp6WGVJVzdqa1cwQTdzbFI1OGRlbjZzbCt0UTV5QW1LdjhmVnN3?=
 =?utf-8?B?UHcvQ2tuaEhuL1FOaHN3cjJXQXFoUzZtU2E2bGg4ZkF1MWIzQm1aVUhkZGZz?=
 =?utf-8?B?Z1E0MFZIRzFvSEJQUGFMR2cwOENlc3JoMFJBNG5sQkZpajFuT3hHUHVKaU5q?=
 =?utf-8?B?TEFodnNLK2VnYjlTRjZ4dFVtejBIY1hXKzlYYURORHJaMWx0b1FXSlRIcFVZ?=
 =?utf-8?B?U1RVMzYyaXhmdEkzeFVianlBYldOVTVIb0tMV3JCMFZ3cXFXN0ZwL1Q4aHBr?=
 =?utf-8?B?OUNaRlBXQVJ2OU94L0IvNzJ4VWlaQXI3TStBdndLVmxMc2NjbUJqeFFhQmFs?=
 =?utf-8?B?ZHlzYzV3ZkFQRUZ2QWVXY3Q2eXJlZUllbS9RcTQ1WGtCc1BjK3BEeC9kZlps?=
 =?utf-8?B?dDRlcllDVFg2WWpCZE5EeWo1NXo1bFE2S1BCbm1ZNkZndmN1Y3lybC8xMCtN?=
 =?utf-8?B?WnZLZzRNL2ludUhNbkFsazJWRkxqaHhaa2FrV3VFa0hLWGVQd3ZrLy9IMXdq?=
 =?utf-8?B?MlBUeU1lYlFGaFdKSzYrV1drbkMvUXcvZ0M4YVlLMm5GYk9DWW9hSE1tTkRh?=
 =?utf-8?B?aEhDYkVyaDZYQ01EbFpidlNBTGQ2OTEwYk1waWpUVG1nMGZkbXhLVHFDNGVO?=
 =?utf-8?B?V0VaRkJxam9SRkpiT0diNnl6TUNZeDdUM05CbWRqSmFKUDV4ZkVFdlQ5TkMv?=
 =?utf-8?B?RlRNQ21CbWhrQjk4WHlIQmY1MmVOWTNnTUtDbm5oWVhWa0MwUWl4RFNhMmhN?=
 =?utf-8?B?WmlZekR6S3RPMTUrVGZ5WkxSQzNXaUpFY0xRZGlmc3RuanU4NTRpMGZMc2wx?=
 =?utf-8?B?T0RFSDRFM1ViMU9ZUng2SjIrSENxL2hRS0IwaU4wL1Z2WkZMV09UUWZVTklr?=
 =?utf-8?Q?SNnf8LmIwwcKY+ft2JJsSJwuYbYAORUitOMcY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <700C37AFF64BE04CA6D2B62310511077@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c847b439-c10d-437f-cb07-08de3f3d53fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2025 20:29:36.7473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SuACA4jsOaaSFTyl2tz9dF21K3i56CvQMMryHjfojNL/WBHy5+QpxjIpqm07Rg+K86wNimzX+Cz09kiva3DagA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB5042
X-Proofpoint-GUID: Mjc2Ce3q-nJ53-3UyhgIPO5tesyeN61k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDE3MSBTYWx0ZWRfX27cT8srY7Ydz
 xPlNxDpWATV0inLAZ3uXzMwGFQk3PUtwOUUGC0mB1aIaM2IAl96BS7WGK1Fe7SzhoD868JZEXH7
 e4oCgNIQ798KUHrG9LOJ1Ft/+l5o69/gG45P0YLauy82gyNvMBG4qpHTYPEqh7wyl1amfqzclsz
 gDqWPP+BmKoWfYZh89vWWMRSbnjTrLEaA49UnOmjdjNyXsUBNTHqlU4Q5DADD1U/PtxJrh+9u5i
 Fo5u04d3Ek4qv7IpeKlxlcr1BfxEp1aFBx4/1gMZ/kgoqWhYy/aLPIBnoi1yWt3C2+OHGU7dCt0
 CmefFM7xjqY6Q3M5aMDum3tykfB1p+xz9zxtQ9O6w8C4veKO+h+xwScUND9jy+XJ+A8fxkKDO59
 8kr6NVk2/0yWnv4Jaw2zqlAVvp4EgoaSrvC81w6Q+g03IOgB6DByjtWuQaMkXwpM4uMKH4RM5OM
 cMFPA/j1zsIsrkchgLQ==
X-Authority-Analysis: v=2.4 cv=XuX3+FF9 c=1 sm=1 tr=0 ts=6945b5b3 cx=c_pps
 a=jlQ7B5VXLElZiQQO4hIw4A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=P-IC7800AAAA:8
 a=mrvgKRKG01bre9UOao8A:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: MzkZTFW29mSKttFlHPLINCMlTxvvsZKU
Subject: RE: [PATCH v2] ceph: fix kernel crash in ceph_open()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_07,2025-12-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512190171

T24gV2VkLCAyMDI1LTEyLTE3IGF0IDIyOjUwIC0wNTAwLCBQYXRyaWNrIERvbm5lbGx5IHdyb3Rl
Og0KPiANCjxza2lwcGVkPg0KDQo+ID4gDQo+ID4gPiAqIFlvdSBhbHNvIG5lZWQgdG8gdXBkYXRl
IGNlcGhfbWRzX2F1dGhfbWF0Y2ggdG8gY2FsbA0KPiA+ID4gbmFtZXNwYWNlX2VxdWFscy4NCj4g
PiA+IA0KPiA+IA0KPiA+IERvIHlvdSBtZWFuIHRoaXMgY29kZSBbMV0/DQo+IA0KPiBZZXMsIHRo
YXQncyBpdC4NCj4gDQo+ID4gDQoNCkp1c3QgdG8gZG91YmxlIGNoZWNrIHRoYXQgd2UgYXJlIG9u
IHRoZSBzYW1lIHBhZ2UuIEN1cnJlbnRseSwgaW4NCmNlcGhfbWRzX2F1dGhfbWF0Y2goKSB3ZSBo
YXZlIFsxXToNCg0KCWlmIChhdXRoLT5tYXRjaC5mc19uYW1lICYmIHN0cmNtcChhdXRoLT5tYXRj
aC5mc19uYW1lLCBmc19uYW1lKSkgew0KCQkvKiBmc25hbWUgbWlzbWF0Y2gsIHRyeSBuZXh0IG9u
ZSAqLw0KCQlyZXR1cm4gMDsNCgl9DQoNCldlIGFyZSBjb21wYXJpbmcgYXV0aC0+bWF0Y2guZnNf
bmFtZSBhbmQgZnNfbmFtZSAod2hpY2ggbm93IGlzIG1kc2MtPm1kc21hcC0NCj5tX2ZzX25hbWUp
IGFzIHR3byBzdHJpbmdzLiBIb3dldmVyLCBuYW1lc3BhY2VfZXF1YWxzKCkgZXhwZWN0cyBzbGln
aHRseQ0KZGlmZmVyZW50IGlucHV0IFsyXToNCg0Kc3RhdGljIGlubGluZSBpbnQgbmFtZXNwYWNl
X2VxdWFscyhzdHJ1Y3QgY2VwaF9tb3VudF9vcHRpb25zICpmc29wdCwNCgkJCQkgICBjb25zdCBj
aGFyICpuYW1lc3BhY2UsIHNpemVfdCBsZW4pDQoNClNvLCBkbyB5b3UgbWVhbiBvZiB1c2luZyBt
ZHNjLT5mc2MtPm1vdW50X29wdGlvbnMgaW5zdGVhZCBvZiBhdXRoLQ0KPm1hdGNoLmZzX25hbWU/
IE9yLCBkbyB5b3UgbWVhbiBvZiB1c2luZyBuYW1lc3BhY2VfZXF1YWxzKCkgbG9naWMgZm9yIGNv
bXBhcmluZw0Kb2YgYXV0aC0+bWF0Y2guZnNfbmFtZSBhbmQgZnNfbmFtZT8NCg0KVGhhbmtzLA0K
U2xhdmEuDQoNClsxXcKgaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTktcmMx
L3NvdXJjZS9mcy9jZXBoL21kc19jbGllbnQuYyNMNTY4Mg0KWzJdIGh0dHBzOi8vZWxpeGlyLmJv
b3RsaW4uY29tL2xpbnV4L3Y2LjE5LXJjMS9zb3VyY2UvZnMvY2VwaC9zdXBlci5oI0wxMTMNCg==

