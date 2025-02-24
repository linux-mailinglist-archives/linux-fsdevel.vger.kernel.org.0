Return-Path: <linux-fsdevel+bounces-42540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B654A42FD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 23:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95723A8E22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535871FCFC6;
	Mon, 24 Feb 2025 22:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MXZD/Yi3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E8D19F11F;
	Mon, 24 Feb 2025 22:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740435001; cv=fail; b=ezCltCe3RRTq3lKD9N9ItYwmaYdrvI0RvsVHc4mCYqBm5wYfbVbYXR0gYQcrihZOMPNfpuFEKlwLw1adcBMhHkki8LX9bNSUvSEEwSkNxhSTz6uJTLxWQ8Qe4v2B4C5e/zgIenrSXcgBAyJjtmwAoZBmj35E1Amg8txaDRIdAjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740435001; c=relaxed/simple;
	bh=o0fHvUdLADOYIkV/vkSm91z9dr8FoYrexi3rjSh2JgU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=N3AA2YOtkFXt8yM7esGnUQMaCERXZGvP/57iMZEYF7ZBUKC1TNLNiKKypSjGhEgRmwYatBUZC7pomeki57c28LFA4ksF2FBQ42u4Ury6cbtJz2YXWnletNImlWtV0+ce+/Q4LHiLZBU9+cKhSaYn4Err0YPLEeYWNQYeGKrgkm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MXZD/Yi3; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OG0oNB005988;
	Mon, 24 Feb 2025 22:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=o0fHvUdLADOYIkV/vkSm91z9dr8FoYrexi3rjSh2JgU=; b=MXZD/Yi3
	fLRSb9LDfGrpPNaAvDRd71PkzaiRg2wBKZbJk6NYK4W/9y9ilQDmX7WmPghqBboV
	6nq8qwwLfpKO2UfWJtgej0QYlTuXnc3D/3cYxZyW5Gv33tA2gxWDjyKmbt0VKMdy
	Co8turwQ8hSx1KvgSRx3pG38A5tW6omUdP3eQ+8cruy0PdNMyeOMJ3ox7ij/p8H6
	jkHGjbAQ2lvg8mVwVyDMpkwro87oXQGpzedgHaEkPsVVxpgq4nvAc8/ynmO+Vv2w
	yjls8FrLd7hpXHGBREVzTWou7tvFW6p/iRb85iXsBOXQ19Q1Wn0lbod4THBgktRH
	1Z7aiqZqdmzYXQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 450mfp3x77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 22:09:28 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51OM9RFR028992;
	Mon, 24 Feb 2025 22:09:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 450mfp3x70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 22:09:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOOIbBm1CQF1MeQ4uCmWGAaBv54vK2Mmpz9HvZzs2UBNVBp2HJ1hgksE4SQFg8zpdNMNIPx/jOw0Zqsw/jGVWtK0gW71ORq1EGotVVuv0eOb2g51Qg20RkkX44iyYMteL/U/uLW/na0BeVn/JXwc0R5FE0WRedrmN+az5MfkjnSSWqwCo5hmGK0kCeMlAvHZOJRo43PFwAKSKiaC+hDPPXEV97Jm6pDrFWctIKqQcWju4bXatd1PMj45lrwQBBYxvY0YpSld7IMlSHx/fuxaSg9ruKHS0I0tamlvzOh3Sl7+WblF4E8i5J7ElwRoV+A7ln6xhQ3MZj/b/a/NOVElFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0fHvUdLADOYIkV/vkSm91z9dr8FoYrexi3rjSh2JgU=;
 b=tzvLKeTJRsOouWC8JoNevMWcSbOQK46ytlHyFBByUorsG0/CEeUNCiHRRt7tIwIlb4ug/LP1nMWsL/lhmNoI65n5xb9bif8oHa6ySOgkOmh7w+VR8l2T44BxFaDzKDedunI+JvbTvEvJQJe31omWgd03jmDvvFrK4AxNU2qU4u3MjGkXuZyOoDbwGtb0MdtuVnB7IaOEfzklSmZWkHo6oJapxs4/n93O1qDOrWhGAJra+LdIDUxud3P2V//gizMD3sx8B+S6JKVNBwc3UqN612eOevwC4lqerDb56+cQIWi/DhKVSoNKobX4hglCckO/UY4leCoo2T7HimEkEsL7jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA6PR15MB6528.namprd15.prod.outlook.com (2603:10b6:806:40c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 22:09:21 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 22:09:21 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "neilb@suse.de" <neilb@suse.de>
CC: "brauner@kernel.org" <brauner@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Olga Kornievskaia
	<okorniev@redhat.com>,
        "linux-cifs@vger.kernel.org"
	<linux-cifs@vger.kernel.org>,
        "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "jlayton@kernel.org"
	<jlayton@kernel.org>,
        "anna@kernel.org" <anna@kernel.org>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "trondmy@kernel.org"
	<trondmy@kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>, "tom@talpey.com" <tom@talpey.com>,
        "richard@nod.at" <richard@nod.at>,
        "anton.ivanov@cambridgegreys.com"
	<anton.ivanov@cambridgegreys.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "netfs@lists.linux.dev"
	<netfs@lists.linux.dev>,
        "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "senozhatsky@chromium.org"
	<senozhatsky@chromium.org>
Thread-Topic: [EXTERNAL] Re:  [PATCH 3/6] ceph: return the correct dentry on
 mkdir
Thread-Index: AQHbhmIRVdJRiNqMJ0aNUL+cghGdzLNXBL6A
Date: Mon, 24 Feb 2025 22:09:21 +0000
Message-ID: <f7d3e39f5ced7832d451de172004172b59a994eb.camel@ibm.com>
References: <>, <e77d268e129b8002e894fc7c16ae0e2faa1cd8dd.camel@ibm.com>
	 <174036334830.74271.5394074407973955108@noble.neil.brown.name>
In-Reply-To: <174036334830.74271.5394074407973955108@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA6PR15MB6528:EE_
x-ms-office365-filtering-correlation-id: ae075f0d-1310-46cf-4166-08dd551fe426
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cXpMR2ZxUHlnL2JSMG5uNVFUK04xUXZ2bUdjeVZRTmVjVkF3TkZGODZhWmEw?=
 =?utf-8?B?U1FGbWV0RWIrbGl3R0s3Ym5rdllrUVZMZ2FNNFRyZzRhWDZ2alMxYm41WTVM?=
 =?utf-8?B?MU54QyttZUsrVy9JcEdpREU3cG9ab09MNU9Fcmt1cy9VNGhlWWNKbkpXMFVr?=
 =?utf-8?B?aHBDQTZpaHh6WkM4anFQL2t2SUpLMldMcHUvNzBaT3ZZTWFOTytoVmNUZkZU?=
 =?utf-8?B?NG8zNUhqT2FuU280c3FmNXpjcFduUkd6K05lNXlIbk5jM3NiS2xzVTczZnV4?=
 =?utf-8?B?T21VZnkwTmMzOXdUNUd5ODE4ckFTL1kwS2pOY1lTL0ZIN0E0UUJhanZzNVVF?=
 =?utf-8?B?aXd1QnJFQ2FKVUxNdVpRRUl1d3lCWENLYWVNUnVqV1o2Z3pkdFozd3dsT0wx?=
 =?utf-8?B?N09sdWhzL21HcnlUcUJlN0FzZFBEakNMSFZyTkk2VDFsZlprNzBRVjVQdTVG?=
 =?utf-8?B?YWYzczZneFJmOVBjbitWK2FlNFZsb2ZVdlB6SFBxT3YwYnZXcnI5RHd0eC92?=
 =?utf-8?B?aE1QcE1lOTNTYW5KZWRlaXBxSDN3bmlrUVczRVdLQlZnNVp1aXNYQUVvNitL?=
 =?utf-8?B?R0xjTUJMRHhhSUFkV2dkeGNFTHdqZGY3dE1WYjFaWUw0dnpFYU43SlJQOXU5?=
 =?utf-8?B?N3BvRThtV1FnNi8ySWdPbFlSZFYrTS9hNVAwN0JlZ0tubFZmd0UwYzA0cnpT?=
 =?utf-8?B?L0lKYXI5NDR4K3ZZMU1FdGxyaUVVSHh2OGJ6MWtLWFk5S05HbWRQMkU3dkt0?=
 =?utf-8?B?NEtpN0sxYmV4NXVVQVhzMnhsYW5Kckk4Zkx0Y2s3WTRoM3dsWWN3QmU3d3FH?=
 =?utf-8?B?YjEzdWZ5b0JnVVRQWGV0NG52SkpoVXh6b3VaRTR5ZkxIQWs4amYvK0htVVhh?=
 =?utf-8?B?NTdTc29NdGdsUnRhL24xVTNMcmpyRFkzaTVMSGMrQlZHSHBrbGdEbnhmNmZa?=
 =?utf-8?B?TkduUjEyQVpYVk5FMWdaRVcvbjlhNGpBbk9YaTdmYjlSS3BBZkJQTzFGbmF1?=
 =?utf-8?B?ZlNmWEpqd2QvWUJxWlZydlQ1bVEvMDM3MDNVSW9kOUxKbC93RDdKTlVyZitO?=
 =?utf-8?B?SjBuMHFmazRSL3p5N3RIZ0RuZ2RFUDNzbjVDSFowaTI3eUl4eHV1OXVtTnFN?=
 =?utf-8?B?Ukp3T1lQTTFKMFJ2elV0d2Zpb1FvMDJLSFY3eGR6c0NORlU1QXhqVGo0dThC?=
 =?utf-8?B?eEgxUGxQOXBmOXRIWWhscUNOZlErVzkyUmFBd2FGUkV5eGxHbkNiTnEvcWZl?=
 =?utf-8?B?Z1ZJa1hESWJMSmZXNUhUS1ZtV1owS3d2akxFRkRhK3lRWThWTmFBQVExMklx?=
 =?utf-8?B?elZXS29waEV3ckprVEZvL2JQRWRqWm5vekdBRkZvdVBkWEVtVkgxWWhFdjdo?=
 =?utf-8?B?ekNPdXFJeFNhcG1VbmFhR3ZMSFdQNUZTN2JjSjdCK0NhN3pmc2F2dXJhdDh0?=
 =?utf-8?B?L3VxV1ZiWm83TDJUMGZhVkpPRVhFdGZBYUtFVUc1WUkweE8vaWRZdFVKMEtK?=
 =?utf-8?B?MjU1RlFFUEgvT3RFOVhtazloS0FZN3dVNldYQnQzMjU4Q1BTbllQVFR3d2d1?=
 =?utf-8?B?ZVZGbFpKUk9UWUc1Qy9mTEdqdmx0Nm9zOC9SVXpTdE94NEkrSDNSOElIaTV4?=
 =?utf-8?B?c2VnOVBMcW81V3YwL0NmbGVqU0pZN245UEFhSm5rZERmTnZKUWpNamZKK0JF?=
 =?utf-8?B?WGQ3Rk1qanZiNVljd1V2ZTBzSEt6dGwxRzR3bUMzNkkwalNBTkJzV1FaUHRn?=
 =?utf-8?B?R24yd01DdzhBZ0ozK3BVaW9zUFgrRGNnSWV4T1dUQzEzYXJ4V0hGaktab2tz?=
 =?utf-8?B?bm9Ib2NKR2oraUtiaUVIVFZmaGZTdEd2eDBESkVQa3pRdUxCSVp5V29DZVZQ?=
 =?utf-8?B?eEJjMmY5Z2k2RGtqTkduU2hkanErVlY5STZZYzJsZmFuNXBwcFhnblBjN1hm?=
 =?utf-8?Q?dmJJ06naw8ntiP6GnxTQ4a0jvosnrH4z?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NGdWcFlkd2R3bmp6YldselJWT05aZFRNWHNWczFOdDViRk1RQ2tKOHFQRmN1?=
 =?utf-8?B?Zzg5TVo0ZUhjazUyRjdpazVKSnMwWjg1MERjbXg3RUp2VXBTN0F3MTBQMEJE?=
 =?utf-8?B?NTJxZUkyQ3ByL1FsbURoclNPVGVyL3lFVHhaang1b2Yyemw3bkZjUExZVGpy?=
 =?utf-8?B?cllGcEV2WTl3K2wwQlkxb1QrSVpacEhQcGE4MHpaVVBNRVZIMXB4SExLNkpq?=
 =?utf-8?B?bUhxY25aQUtQK0x6YytmZkQ0cHZiMmViNGpZZUlrSTNUOGdiTXBuMTRPUzN2?=
 =?utf-8?B?MDVkRFlhMXZSUlFlV0M3QlJYbWIvN2EyRHVmdlZQUkZoWWE3SHAyVHV4cGZH?=
 =?utf-8?B?T0Z5dHc2V1JxU05ZOGNOWTlqUUVlMUFMY1V2bytTZHczWElDcnJqZTk0Y0tl?=
 =?utf-8?B?MFNibitLWXRHRkRnTlIyYXRCcnB1RWd5Q0FYQW5LZzFlUzVCaElNS0d0WGYw?=
 =?utf-8?B?SjlqbkRhb1RFTmZseGliU2VOQWdNTkc2ejJNdW83MGx6VlNsN3RoekthclZl?=
 =?utf-8?B?bTZQOWJVSlUvajhtalRJTG5tTjFCemxHY2dscG5aSy9IdVJHWUZSa2YwdHZq?=
 =?utf-8?B?b0VURE9uci83ajZNc2tzL09zT0ZaeDcxdFFUMVVIRjhZK1V0dzY5SElHbzMz?=
 =?utf-8?B?SVArRG9VTHZoSDRIaUNiSEV1Qno1d0grRzBadnJXVjJNL0N1UEZJclMvNDhv?=
 =?utf-8?B?VlpmTG15LzNjYTQybVN1cWdZMWpFb3pYNHZwamF2QUlRMGREYzBmeHVLa29N?=
 =?utf-8?B?dWZJVmlFMEZRVVVaMGY3bmRXYVY3cm5SMlRERGxrNGU1dDdDeDZUZWF0Y1ln?=
 =?utf-8?B?YVUvTnBZQXpTbUJveTNnbmhHUWhZUDVhL0tjNVg4UisrT2pGQ3ZBVGk4L1Vq?=
 =?utf-8?B?TEU2RkpodUlneld6YkZ0cnJhK1ZDbTI3cW1pZHp1SkxUUko0QysyYTJzT014?=
 =?utf-8?B?NGZLVDIrbHlUOXBEU3FPdUs1R0tKVmp1MkQxM3Y0dTM5cDVwVndkN3U2MTA4?=
 =?utf-8?B?aFhEOUdha0JobC82M0hsRlgydnoySkpLNndTUzU1Y0ZPY25NT3JMSDMrZVc2?=
 =?utf-8?B?cGNYLzV3cm5waXR3YW9UZUtXT3FUZGxWK2YrdnYvY0FVSXFNQXhod1RmWVdi?=
 =?utf-8?B?RjRFSll3V0wveWpEN2o1ZUpuTXY2L3pSUVBGYjFHUzRNMlhybjgvdEl4andS?=
 =?utf-8?B?UW4xcVhDdHJ4USs3S3RYVURUWWI0WEc5MmJwdUtWeXRUMGZsSlJrZExDMG9x?=
 =?utf-8?B?cWRaTzFhYTQvMVB3QkNTRjFZNVZUN1hWWUw0VUNvcE10clJ2TG82Q1NnSU9R?=
 =?utf-8?B?WmxTMmd3OHFUYU41ZjBXNy8vL1Z1MDdZYmFSQnpwUWNuZnZHdUgwbWVIMitV?=
 =?utf-8?B?aG5RN0U4dFBkRjUzN25wSnRtRlRVa0NoR0I0UnluNE1RSTY0N2UvcnkraGdu?=
 =?utf-8?B?M0YzT3RZTmxLeVpaS3lpTDY2QkJIYXA2LzBUZ2lFVUNybHltak82TGtQSExR?=
 =?utf-8?B?TU5UK2dVbExkczdtWjErUllocHZKQXZObTg5NUtJYWZ5UEVBUGNvak85b3Bq?=
 =?utf-8?B?TkR4bDk3VVB3Ty92NWhsOE9Qb3FaR0d0VlQxZUVXUnRNSmx3UTVIUDc0eSt5?=
 =?utf-8?B?WHVxQ1Y4Q2V0Z3pBWnRIdjNuamRxdnFCMkIyWUpKL2lMd25EOXFVNjh6VVox?=
 =?utf-8?B?YVQ0V3dwK0FYang3NVZQcDBrSVgvd1B0a0lXdzFEM1pjWEdmZmdiZWpyVm5a?=
 =?utf-8?B?YVh6M2QzbTFOampGK2NiTnBzdHRhYTEvdGpFZmFnN2xUY1Q0eUxkOTBaWnZ6?=
 =?utf-8?B?N3YwR0MreXhEeGNOUzF5ZHRRRGgyZ0EwbFllcnVhelFuRlNCUjVvK1psaG5n?=
 =?utf-8?B?dU1FSTZqWVlwblhWVWthTStwSkc4a3lpMm5WaVdDVkxIR3gxb2VIK1ZUTkFW?=
 =?utf-8?B?VjV0TVBLakJqcmEzd092aldibXhlUXZVcDZjb3B5YXdOYW50Nm5VQW1jK3hJ?=
 =?utf-8?B?UktlWUIwYTZNRFErejRNaVpHNnVROHdqNmpOVUdJWnphSnZjUEEyOEFiQS9U?=
 =?utf-8?B?U0FKZkxqd0s1dGt0VHM5Z3dkbDd1U0FCNWI3ZCtNcCt0WlBwNko4SVcxU3hn?=
 =?utf-8?B?VjdpM2YwdWJKVC9NZXhyZEJtOXRiVktoZ0NDL25vMWtRb1pIYTMvTjlqcnV0?=
 =?utf-8?Q?UOzMZeEpe5IzmPb6JzAKE0U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C34AC619E1D1DA4B84DE3C36649B0433@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ae075f0d-1310-46cf-4166-08dd551fe426
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 22:09:21.6426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XcTnfODbliu9ZsE50DLyMjfo9zzlF+Lt1CrZhrZg5A3oq8A9MEoyIj33aCacVP7QI4yQUEQi7NCwjFc5EO1Njw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR15MB6528
X-Proofpoint-ORIG-GUID: 4jMFhhp2F-FTlSTIofWvqQt_r6E1dxly
X-Proofpoint-GUID: mw3OrRRMK-16j6qEnRNwyXoaLYvBr4m5
Subject: RE:  [PATCH 3/6] ceph: return the correct dentry on mkdir
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_10,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240140

T24gTW9uLCAyMDI1LTAyLTI0IGF0IDEzOjE1ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IEZyaSwgMjEgRmViIDIwMjUsIFZpYWNoZXNsYXYgRHViZXlrbyB3cm90ZToNCj4gPiBPbiBGcmks
IDIwMjUtMDItMjEgYXQgMTA6MzYgKzExMDAsIE5laWxCcm93biB3cm90ZToNCj4gPiA+IGNlcGgg
YWxyZWFkeSBzcGxpY2VzIHRoZSBjb3JyZWN0IGRlbnRyeSAoaW4gc3BsaWNlX2RlbnRyeSgpKSBm
cm9tIHRoZQ0KPiA+ID4gcmVzdWx0IG9mIG1rZGlyIGJ1dCBkb2VzIG5vdGhpbmcgbW9yZSB3aXRo
IGl0Lg0KPiA+ID4gDQo+ID4gPiBOb3cgdGhhdCAtPm1rZGlyIGNhbiByZXR1cm4gYSBkZW50cnks
IHJldHVybiB0aGUgY29ycmVjdCBkZW50cnkuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6
IE5laWxCcm93biA8bmVpbGJAc3VzZS5kZT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGZzL2NlcGgvZGly
LmMgfCA5ICsrKysrKysrLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL2NlcGgvZGlyLmMg
Yi9mcy9jZXBoL2Rpci5jDQo+ID4gPiBpbmRleCAzOWUwZjI0MGRlMDYuLmMxYTFjMTY4YmIyNyAx
MDA2NDQNCj4gPiA+IC0tLSBhL2ZzL2NlcGgvZGlyLmMNCj4gPiA+ICsrKyBiL2ZzL2NlcGgvZGly
LmMNCj4gPiA+IEBAIC0xMDk5LDYgKzEwOTksNyBAQCBzdGF0aWMgc3RydWN0IGRlbnRyeSAqY2Vw
aF9ta2RpcihzdHJ1Y3QgbW50X2lkbWFwICppZG1hcCwgc3RydWN0IGlub2RlICpkaXIsDQo+ID4g
PiAgCXN0cnVjdCBjZXBoX2NsaWVudCAqY2wgPSBtZHNjLT5mc2MtPmNsaWVudDsNCj4gPiA+ICAJ
c3RydWN0IGNlcGhfbWRzX3JlcXVlc3QgKnJlcTsNCj4gPiA+ICAJc3RydWN0IGNlcGhfYWNsX3Nl
Y19jdHggYXNfY3R4ID0ge307DQo+ID4gPiArCXN0cnVjdCBkZW50cnkgKnJldCA9IE5VTEw7DQo+
ID4gDQo+ID4gSSBiZWxpZXZlIHRoYXQgaXQgbWFrZXMgc2Vuc2UgdG8gaW5pdGlhbGl6ZSBwb2lu
dGVyIGJ5IGVycm9yIGhlcmUgYW5kIGFsd2F5cw0KPiA+IHJldHVybiByZXQgYXMgb3V0cHV0LiBJ
ZiBzb21ldGhpbmcgZ29lcyB3cm9uZyBpbiB0aGUgbG9naWMsIHRoZW4gd2UgYWxyZWFkeSBoYXZl
DQo+ID4gZXJyb3IuDQo+IA0KPiBJJ20gbm90IGNlcnRhaW4gdGhhdCBJIHVuZGVyc3RhbmQsIGJ1
dCBJIGhhdmUgbWFkZSBhIGNoYW5nZSB3aGljaCBzZWVtcw0KPiB0byBiZSBjb25zaXN0ZW50IHdp
dGggdGhlIGFib3ZlIGFuZCBpbmNsdWRlZCBpdCBiZWxvdy4gIFBsZWFzZSBsZXQgbWUNCj4ga25v
dyBpZiBpdCBpcyB3aGF0IHlvdSBpbnRlbmRlZC4NCj4gDQo+ID4gDQo+ID4gPiAgCWludCBlcnI7
DQo+ID4gPiAgCWludCBvcDsNCj4gPiA+ICANCj4gPiA+IEBAIC0xMTY2LDE0ICsxMTY3LDIwIEBA
IHN0YXRpYyBzdHJ1Y3QgZGVudHJ5ICpjZXBoX21rZGlyKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFw
LCBzdHJ1Y3QgaW5vZGUgKmRpciwNCj4gPiA+ICAJICAgICFyZXEtPnJfcmVwbHlfaW5mby5oZWFk
LT5pc19kZW50cnkpDQo+ID4gPiAgCQllcnIgPSBjZXBoX2hhbmRsZV9ub3RyYWNlX2NyZWF0ZShk
aXIsIGRlbnRyeSk7DQo+ID4gPiAgb3V0X3JlcToNCj4gPiA+ICsJaWYgKCFlcnIgJiYgcmVxLT5y
X2RlbnRyeSAhPSBkZW50cnkpDQo+ID4gPiArCQkvKiBTb21lIG90aGVyIGRlbnRyeSB3YXMgc3Bs
aWNlZCBpbiAqLw0KPiA+ID4gKwkJcmV0ID0gZGdldChyZXEtPnJfZGVudHJ5KTsNCj4gPiA+ICAJ
Y2VwaF9tZHNjX3B1dF9yZXF1ZXN0KHJlcSk7DQo+ID4gPiAgb3V0Og0KPiA+ID4gIAlpZiAoIWVy
cikNCj4gPiA+ICsJCS8qIFNob3VsZCB0aGlzIHVzZSAncmV0JyA/PyAqLw0KPiA+IA0KPiA+IENv
dWxkIHdlIG1ha2UgYSBkZWNpc2lvbiBzaG91bGQgb3Igc2hvdWxkbid0PyA6KQ0KPiA+IEl0IGxv
b2tzIG5vdCBnb29kIHRvIGxlYXZlIHRoaXMgY29tbWVudCBpbnN0ZWFkIG9mIHByb3BlciBpbXBs
ZW1lbnRhdGlvbi4gRG8gd2UNCj4gPiBoYXZlIHNvbWUgb2JzdGFjbGVzIHRvIG1ha2UgdGhpcyBk
ZWNpc2lvbj8NCj4gDQo+IEkgc3VzcGVjdCB3ZSBzaG91bGQgdXNlIHJldCwgYnV0IEkgZGlkbid0
IHdhbnQgdG8gbWFrZSBhIGNoYW5nZSB3aGljaA0KPiB3YXNuJ3QgZGlyZWN0bHkgcmVxdWlyZWQg
YnkgbXkgbmVlZGVkLiAgU28gSSBoaWdobGlnaHRlZCB0aGlzIHdoaWNoDQo+IGxvb2tzIHRvIG1l
IGxpa2UgYSBwb3NzaWJsZSBidWcsIGhvcGluZyB0aGF0IHNvbWVvbmUgbW9yZSBmYW1pbGlhciB3
aXRoDQo+IHRoZSBjb2RlIHdvdWxkIGdpdmUgYW4gb3Bpbmlvbi4gIERvIHlvdSBhZ3JlZSB0aGF0
ICdyZXQnIChpLmUuDQo+IC0+cl9kZW50cnkpIHNob3VsZCBiZSB1c2VkIHdoZW4gcmV0IGlzIG5v
dCBOVUxMPw0KPiANCg0KSSB0aGluayBpZiB3ZSBhcmUgZ29pbmcgdG8gcmV0dXJuIHJldCBhcyBh
IGRlbnRyeSwgdGhlbiBpdCBtYWtlcyBzZW5zZSB0byBjYWxsDQp0aGUgY2VwaF9pbml0X2lub2Rl
X2FjbHMoKSBmb3IgZF9pbm9kZShyZXQpLiBJIGRvbid0IHNlZSB0aGUgcG9pbnQgdG8gY2FsbA0K
Y2VwaF9pbml0X2lub2RlX2FjbHMoKSBmb3IgZF9pbm9kZShkZW50cnkpIHRoZW4uDQoNCj4gPiAN
Cj4gPiA+ICAJCWNlcGhfaW5pdF9pbm9kZV9hY2xzKGRfaW5vZGUoZGVudHJ5KSwgJmFzX2N0eCk7
DQo+ID4gPiAgCWVsc2UNCj4gPiA+ICAJCWRfZHJvcChkZW50cnkpOw0KPiA+ID4gIAljZXBoX3Jl
bGVhc2VfYWNsX3NlY19jdHgoJmFzX2N0eCk7DQo+ID4gPiAtCXJldHVybiBFUlJfUFRSKGVycik7
DQo+ID4gPiArCWlmIChlcnIpDQo+ID4gPiArCQlyZXR1cm4gRVJSX1BUUihlcnIpOw0KPiA+ID4g
KwlyZXR1cm4gcmV0Ow0KPiA+IA0KPiA+IFdoYXQncyBhYm91dCB0aGlzPw0KPiA+IA0KPiA+IHJl
dHVybiBlcnIgPyBFUlJfUFRSKGVycikgOiByZXQ7DQo+IA0KPiBXZSBjb3VsZCBkbyB0aGF0LCBi
dXQgeW91IHNhaWQgYWJvdmUgdGhhdCB5b3UgdGhvdWdodCB3ZSBzaG91bGQgYWx3YXlzDQo+IHJl
dHVybiAncmV0JyAtIHdoaWNoIGRvZXMgbWFrZSBzb21lIHNlbnNlLg0KPiANCj4gV2hhdCBkbyB5
b3UgdGhpbmsgb2YgdGhlIGZvbGxvd2luZyBhbHRlcm5hdGUgcGF0Y2g/DQo+IA0KDQpQYXRjaCBs
b29rcyBnb29kIHRvIG1lLiBUaGFua3MuDQoNClJldmlld2VkLWJ5OiBWaWFjaGVzbGF2IER1YmV5
a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4NCg0KPiBUaGFua3MsDQo+IE5laWxCcm93bg0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2ZzL2NlcGgvZGlyLmMgYi9mcy9jZXBoL2Rpci5jDQo+IGluZGV4IDM5
ZTBmMjQwZGUwNi4uZDJlNWM1NTdkZjgzIDEwMDY0NA0KPiAtLS0gYS9mcy9jZXBoL2Rpci5jDQo+
ICsrKyBiL2ZzL2NlcGgvZGlyLmMNCj4gQEAgLTEwOTksNiArMTA5OSw3IEBAIHN0YXRpYyBzdHJ1
Y3QgZGVudHJ5ICpjZXBoX21rZGlyKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLCBzdHJ1Y3QgaW5v
ZGUgKmRpciwNCj4gIAlzdHJ1Y3QgY2VwaF9jbGllbnQgKmNsID0gbWRzYy0+ZnNjLT5jbGllbnQ7
DQo+ICAJc3RydWN0IGNlcGhfbWRzX3JlcXVlc3QgKnJlcTsNCj4gIAlzdHJ1Y3QgY2VwaF9hY2xf
c2VjX2N0eCBhc19jdHggPSB7fTsNCj4gKwlzdHJ1Y3QgZGVudHJ5ICpyZXQ7DQo+ICAJaW50IGVy
cjsNCj4gIAlpbnQgb3A7DQo+ICANCj4gQEAgLTExMTYsMzIgKzExMTcsMzIgQEAgc3RhdGljIHN0
cnVjdCBkZW50cnkgKmNlcGhfbWtkaXIoc3RydWN0IG1udF9pZG1hcCAqaWRtYXAsIHN0cnVjdCBp
bm9kZSAqZGlyLA0KPiAgCQkgICAgICBjZXBoX3Zpbm9wKGRpciksIGRlbnRyeSwgZGVudHJ5LCBt
b2RlKTsNCj4gIAkJb3AgPSBDRVBIX01EU19PUF9NS0RJUjsNCj4gIAl9IGVsc2Ugew0KPiAtCQll
cnIgPSAtRVJPRlM7DQo+ICsJCXJldCA9IEVSUl9QVFIoLUVST0ZTKTsNCj4gIAkJZ290byBvdXQ7
DQo+ICAJfQ0KPiAgDQo+ICAJaWYgKG9wID09IENFUEhfTURTX09QX01LRElSICYmDQo+ICAJICAg
IGNlcGhfcXVvdGFfaXNfbWF4X2ZpbGVzX2V4Y2VlZGVkKGRpcikpIHsNCj4gLQkJZXJyID0gLUVE
UVVPVDsNCj4gKwkJcmV0ID0gRVJSX1BUUigtRURRVU9UKTsNCj4gIAkJZ290byBvdXQ7DQo+ICAJ
fQ0KPiAgCWlmICgob3AgPT0gQ0VQSF9NRFNfT1BfTUtTTkFQKSAmJiBJU19FTkNSWVBURUQoZGly
KSAmJg0KPiAgCSAgICAhZnNjcnlwdF9oYXNfZW5jcnlwdGlvbl9rZXkoZGlyKSkgew0KPiAtCQll
cnIgPSAtRU5PS0VZOw0KPiArCQlyZXQgPSBFUlJfUFRSKC1FTk9LRVkpOw0KPiAgCQlnb3RvIG91
dDsNCj4gIAl9DQo+ICANCj4gIA0KPiAgCXJlcSA9IGNlcGhfbWRzY19jcmVhdGVfcmVxdWVzdCht
ZHNjLCBvcCwgVVNFX0FVVEhfTURTKTsNCj4gIAlpZiAoSVNfRVJSKHJlcSkpIHsNCj4gLQkJZXJy
ID0gUFRSX0VSUihyZXEpOw0KPiArCQlyZXQgPSBFUlJfQ0FTVChyZXEpOw0KPiAgCQlnb3RvIG91
dDsNCj4gIAl9DQo+ICANCj4gIAltb2RlIHw9IFNfSUZESVI7DQo+ICAJcmVxLT5yX25ld19pbm9k
ZSA9IGNlcGhfbmV3X2lub2RlKGRpciwgZGVudHJ5LCAmbW9kZSwgJmFzX2N0eCk7DQo+ICAJaWYg
KElTX0VSUihyZXEtPnJfbmV3X2lub2RlKSkgew0KPiAtCQllcnIgPSBQVFJfRVJSKHJlcS0+cl9u
ZXdfaW5vZGUpOw0KPiArCQlyZXQgPSBFUlJfQ0FTVChyZXEtPnJfbmV3X2lub2RlKTsNCj4gIAkJ
cmVxLT5yX25ld19pbm9kZSA9IE5VTEw7DQo+ICAJCWdvdG8gb3V0X3JlcTsNCj4gIAl9DQo+IEBA
IC0xMTY1LDE1ICsxMTY2LDIzIEBAIHN0YXRpYyBzdHJ1Y3QgZGVudHJ5ICpjZXBoX21rZGlyKHN0
cnVjdCBtbnRfaWRtYXAgKmlkbWFwLCBzdHJ1Y3QgaW5vZGUgKmRpciwNCj4gIAkgICAgIXJlcS0+
cl9yZXBseV9pbmZvLmhlYWQtPmlzX3RhcmdldCAmJg0KPiAgCSAgICAhcmVxLT5yX3JlcGx5X2lu
Zm8uaGVhZC0+aXNfZGVudHJ5KQ0KPiAgCQllcnIgPSBjZXBoX2hhbmRsZV9ub3RyYWNlX2NyZWF0
ZShkaXIsIGRlbnRyeSk7DQo+ICsJcmV0ID0gRVJSX1BUUihlcnIpOw0KPiAgb3V0X3JlcToNCj4g
KwlpZiAoIUlTX0VSUihyZXQpICYmIHJlcS0+cl9kZW50cnkgIT0gZGVudHJ5KQ0KPiArCQkvKiBT
b21lIG90aGVyIGRlbnRyeSB3YXMgc3BsaWNlZCBpbiAqLw0KPiArCQlyZXQgPSBkZ2V0KHJlcS0+
cl9kZW50cnkpOw0KPiAgCWNlcGhfbWRzY19wdXRfcmVxdWVzdChyZXEpOw0KPiAgb3V0Og0KPiAt
CWlmICghZXJyKQ0KPiAtCQljZXBoX2luaXRfaW5vZGVfYWNscyhkX2lub2RlKGRlbnRyeSksICZh
c19jdHgpOw0KPiAtCWVsc2UNCj4gKwlpZiAoIUlTX0VSUihyZXQpKSB7DQo+ICsJCWlmIChyZXQp
DQo+ICsJCQljZXBoX2luaXRfaW5vZGVfYWNscyhkX2lub2RlKHJldCksICZhc19jdHgpOw0KPiAr
CQllbHNlDQo+ICsJCQljZXBoX2luaXRfaW5vZGVfYWNscyhkX2lub2RlKGRlbnRyeSksICZhc19j
dHgpOw0KPiArCX0gZWxzZSB7DQo+ICAJCWRfZHJvcChkZW50cnkpOw0KPiArCX0NCj4gIAljZXBo
X3JlbGVhc2VfYWNsX3NlY19jdHgoJmFzX2N0eCk7DQo+IC0JcmV0dXJuIEVSUl9QVFIoZXJyKTsN
Cj4gKwlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgaW50IGNlcGhfbGluayhzdHJ1
Y3QgZGVudHJ5ICpvbGRfZGVudHJ5LCBzdHJ1Y3QgaW5vZGUgKmRpciwNCj4gDQoNClRoYW5rcywN
ClNsYXZhLg0KDQo=

