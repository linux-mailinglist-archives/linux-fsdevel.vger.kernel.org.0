Return-Path: <linux-fsdevel+bounces-52254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4DCAE0C66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 20:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CA3F4A58F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 18:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD21F2F3C0A;
	Thu, 19 Jun 2025 18:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tkdn45F8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9879D2F365B;
	Thu, 19 Jun 2025 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750356284; cv=fail; b=J80/Jgqg+BNM7Jgvzi0k6mbIe9jhsXf6DuMyDENq1NEVK75oOgLBVqJ2WF/S/FqGT5zZAlPWcaatAwYVP+jsj7eUvhvKbYJTJS6giNGdveauyasP7bq5LiHtHRtXOQjiqVucqXwvYw2qOO8SkMfFBDBgk/MlvMhdUwFyzg4KDGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750356284; c=relaxed/simple;
	bh=XmDUFwikqm6C+2W2R428zGadsmtOXV+Lvu1G6sgpFXk=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=DAmZQ1t0w8Ht9gM+ynSS6praE8GNqNn/Dck8uE4zGsjRTxoT+tiWkWvddKRjh0TXepbsvrfE/TPjjxPvuashGmI04j/mc4yYqPYkvuADdYZ8uYHsAK2eVHlfy+BqG2kehhtZ6ytRALYXZwOtXijudg7fCO64xM3vS9jyBmfXDKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tkdn45F8; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JB4nGk030714;
	Thu, 19 Jun 2025 18:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=XmDUFwikqm6C+2W2R428zGadsmtOXV+Lvu1G6sgpFXk=; b=tkdn45F8
	g1vNNElqSYUQoQ6+ouQdJhXkiVDhJIwNlxduYeu8Ayi3icFckUnICo1T0EdgcKvN
	v3t1meH81228P9dSWqDlbhuCPNPZEEOElfQTLBu48XT6iiMY4n1l5rOesUpKt1sK
	ukd0DaxRiBAt2I6h1FdjxNYdA1e6DELGKIxNVdpebEvtN4Mk9FdSq7qluaARG+Xa
	9WzUiY6mxMnU0ft3JgEqSng1+xDTLSiaq1ns/kOk31PYu6K3IisWkJq1cMbbJu8e
	Vwb9cD7/ltZZacKd9pdVoizkFYYwLZAzngDJmtcE+yAXEVEahHRRTZWDGT1ZkPxC
	Nv8KFXt/J4TJcw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790kty7nq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Jun 2025 18:04:41 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55JI0ulM025745;
	Thu, 19 Jun 2025 18:04:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790kty7nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Jun 2025 18:04:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GASE0lkw3DpJuq/0vdT31GPA/Z6vc+hQ7joH8jdVBbptuucPp2VZ+E+BK0JbdfwSInaXebYke7SntwlfMjRLzAsG1l9d2IakxKwDVomHZRZpCNj7HDIojLWHGoRFIzuW4hc8py8JtqcFBJW6rRTdZceCHptTW8AsNjCZD7V8Fb9eIstLPqB+gUts/PRGB+2wmxvwgdI3KxZupadMQAmq7M3rIz8G4eomPRmNjm29QCG1ZemjIkDkj5sRGdaTCzZIXSJJ4e0zlaxITCEGrB2x5A553mFISdAFlpQv/LOZ3IstBcRRYn/cUd2wwuSxWzU4IbZ30PBEAKMMJPBg+lPheg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmDUFwikqm6C+2W2R428zGadsmtOXV+Lvu1G6sgpFXk=;
 b=fegZf+hTYjicfo7DwaL8ThFmFSbErqrdfuamwwUiRYuAkdBE+6xycsh8Z+U0DNPLh+LdQq9eRqh7fwI63FFWrul5gFFN03iCQN0pZhr+vjFxIQ4/QtjIE5jc3kHHHizn5Jo2DzP/xLTofnCRyUtmpywpqU22gWnM6k8RrKXz8ri1ch4ctEdXL2xTU0qRU+PzegspJCsn5wlYNChylX3Zgfb+V8AIxT90JKbGdMsdbU0ULTRQH0brd6GLVRRNuwuoAs/mTN05SbFB7Xnv9gcr7EMorJ2F8Sri3FWEG08ZTQBLNUEUHo0J1CcY0ATgmgjKWW4vCqEjDUQSC96AHURQgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA0PR15MB3839.namprd15.prod.outlook.com (2603:10b6:806:83::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Thu, 19 Jun
 2025 18:04:37 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 18:04:37 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC: "idryomov@gmail.com" <idryomov@gmail.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH 3/3] ceph: fix a race with rename() in
 ceph_mdsc_build_path()
Thread-Index: AQHb39NggKmJO0MvZUaR/wUvvjNfRrQH6hQAgAAAzwCAAt6xAA==
Date: Thu, 19 Jun 2025 18:04:37 +0000
Message-ID: <0c2591751d796547c45ade7dc11d49018ef5aaa6.camel@ibm.com>
References: <20250614062051.GC1880847@ZenIV>
	 <20250614062257.535594-1-viro@zeniv.linux.org.uk>
	 <20250614062257.535594-3-viro@zeniv.linux.org.uk>
	 <f9008d5161cb8a7cdfed54da742939523641532d.camel@ibm.com>
	 <20250617220122.GM1880847@ZenIV>
	 <cd929637ed2826f25d15bad39a884fac3fd30d0c.camel@ibm.com>
	 <20250617221502.GN1880847@ZenIV>
In-Reply-To: <20250617221502.GN1880847@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA0PR15MB3839:EE_
x-ms-office365-filtering-correlation-id: f37f5d22-9d87-4efe-ede5-08ddaf5bc139
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZDhYNmx0MWg4dzhYcE9abFU5MGRXc1MvTVNhL2tJK291a0swTm81WGVsOEIy?=
 =?utf-8?B?bzMwYUJUQjhTZDJMdjhlNDZnSFpnbkNuYnFzaW9zTU43L3ZsS0RCVFd6RVRY?=
 =?utf-8?B?ZnVFVHV2TklWS0dFSzVIRzBRb3hHYjRNNktRWjRnVXVsWXMvOE5Bc1A4SVl0?=
 =?utf-8?B?Zm9zM0FXTk9iSll2SVBDUWdXOE9LTFdWQlFXUzFUbU5oazRGak5aY2ZjWnZV?=
 =?utf-8?B?VFgrSERGQWo0UThJRlduQU5Rek80K1drSG5rdlQ3bldBQ0Y1ZTVnR09iNmRn?=
 =?utf-8?B?OXMxeEYyelkzL3ZhNGUrcDdsYzJQMWNCanc5cTM0czZRaWw0NkxPWWJRNlJo?=
 =?utf-8?B?TnkwY0ZWeXRVbzEwekF4ZUhsVy84aHM5b1NiOU8zYlNpL2xjNG13LzYzVXY0?=
 =?utf-8?B?bnQ2QVcyN3NTdmwvK3RhYk4xYjdoMk1PMmtKMnJ4a09GamFhUk9ZSi9Hbm8v?=
 =?utf-8?B?OHBESFJPbEt5NnZicm5RMEF6R0NYV2xOZUxWNDdwc25rdFhta1BKaHg1MWZP?=
 =?utf-8?B?R2MvaS9CL3UzRGlEMzhiaEVXejl6WnpubytMS1Qyem9ackxiUXVEcGdpRnpB?=
 =?utf-8?B?TnhodGJsSEJoaVFNYVRMaWNBYW1DM2s4bGsxc21MVHNmdmZpR1JFVzhMb0s4?=
 =?utf-8?B?WlFrZWhZa2dnVi9MYVI0Sm9iRU1QaXZsQ0s1SUlSbmtqbEhFRGwxZVJqN3M0?=
 =?utf-8?B?TUhJS0IyZko3Qy92d0NVYnZIaExoMkVveFBmWlFXYWJ1NVpJRzlONVdORmlH?=
 =?utf-8?B?SzA1T1FjZVZaa3h0dUZGV1NhcldMVUw4TmV0Vk1ISXRiY1gxVVI5N2xrWWQ3?=
 =?utf-8?B?ZGZrZUdoSmEzYWZZZzBJRkRRRG5KTU9DUVlaZjRFTlhsNGxSWjdIMDB2RUdo?=
 =?utf-8?B?MWlrZ0V2cHB1TUYyMmM2SGF0UkV2dVBEdGlCNWQxbXBpN1plUVRreGRUZXdN?=
 =?utf-8?B?OVM4YnVuTElxZmR1ODlWMm1EWTJ1ZzBuTTg3ZWxYcWpyTytUZi9LWWJaQ1dF?=
 =?utf-8?B?b2R3VU5vZFVpZTFVc2VGWm9FMUFGVHhwdGV4eUdnQWhSQm1zVnZCdlBKRUZU?=
 =?utf-8?B?M1ZVSUJQU0Z5RmpaNGI2bUh3aktjaWk5M1JIU2EyUWlUdmZ4SkJyNE9vOUdu?=
 =?utf-8?B?UWlVV1p3aU1yKytHZUV5Q1k0QXFlOFpSVXp2ZWtOa1hPcnREcHp5RU5kOWlj?=
 =?utf-8?B?N2w4alBSc1NLcDdGZkkvaDk0S1B4MEJZdER5ZXNaUUJDQVZNb3JORDJHcDly?=
 =?utf-8?B?Q3hKbEdMZDZBRmozMXozM2pweGxteUJ1ZisyQzdUZUZXeTNBbURUTHJlSkZ5?=
 =?utf-8?B?UHpGblh6T3UxU0MvSzUyQzJBNTNkRzF1VTBSd3JKV1ArMjZqWXN3ZFVSbGtI?=
 =?utf-8?B?NDMyQmdMQVNmNGhXQzhKTU1GZDRuNUFjb2tkamxyVEtXdllVL1NnbEdDY3dL?=
 =?utf-8?B?M01iTnF5NUNmNjUvNU5GRFVVWXNGL0JBaXJiYkpDNm4rdi9reEVtbUlEUHo4?=
 =?utf-8?B?bnVZbnJub1BrUzZFVmdad1dFYjBzNmR5MHpVU0RLSFNncTk4NzFwNUZlNzF6?=
 =?utf-8?B?YWdmVHRTTkxoVytVQkE4WDJYNEZOYVgvMjA0TmpCeHJpS2U3RVBRWjlFU3Zs?=
 =?utf-8?B?cnNQSmU2VjFKUTQyQkw0eFFWV3ZUU2hFVWxQT1JHc3NxKzhudlhzMjRMUzdu?=
 =?utf-8?B?YXlGZkd4ODU0akEwcW1qcGJXd0V0NEVWYkhRdUR0NUpkN2loZ2dySVQ2c0Z4?=
 =?utf-8?B?N0d6VmJvRDFJQWlLOFBsQW96UExpb3ZVM2ZLc1RVVnM1WUZ4T2hRSFZJSTJ4?=
 =?utf-8?B?UkZPK2ppUjVuMk4zR1RPeG9WSmN0Y2I1UzcwSjVYRHBuZjlwdWJoWW5ibUJo?=
 =?utf-8?B?WVUrMHQ3bFlVOWhYZ05Zc3VPMEZTWU1WZUJqOFRIZkp0L3g4b2NrRnpFUUs1?=
 =?utf-8?B?TndwWDlqY0d0K2RoWE1zTHV2aytZTlZqS3gyT1hRcW52dlorcm9hR0YyeVA5?=
 =?utf-8?Q?9m2xE74zpxVVQml/bfhT26pL/1JBGE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ODBXa3NHcGN2bXl4SUNCMkFmZkM2QkJYRTd3YjFIeUd3T1VRa0w3ZTdiLzds?=
 =?utf-8?B?MW9hejVSTERGNEhqWkl4UkNvK2Fac1VsRXdnc0tDR1BkRHI3TGZnS0YxNTVx?=
 =?utf-8?B?Mi9OY21sTndONnBMM3UvOXIrQ1c5TlBLWWNnMmxpbVMxQ0IrbHBnUThIV1ZS?=
 =?utf-8?B?SGZadlFMWlRmOGdNY3hYZ3hqK0VTMHZOc1plTkI4OUlrRjQ5a2phKzBHeTV0?=
 =?utf-8?B?OGFTc1lEZ0d3RUx4clVqcjA2LzdOYXRxRXpiNUd5Uy9iRUF3YXNjdGQ1WDk0?=
 =?utf-8?B?S0tSY082SDJyQzJxSWFKOHROTmoySXB5RE84ZW9nUjhTUFBsbUhOZmtsOE90?=
 =?utf-8?B?M3ZYL0Y2cllySlpSVmJvd2VYUGo4aFgwWUVRdGdMcnJwWVRXam5zcmZ0NmRQ?=
 =?utf-8?B?dHBHSUgvQVhSWExmZ3JqcXNGR1lib2x4a0RYTGJNYnVoUWVjdXgrQUsrQ1JI?=
 =?utf-8?B?RU5ORXZGRU41OUFiM0l5YmV1ZGh6b29IQTFac3NwVUh1aEZpZ0loV2N5eGp1?=
 =?utf-8?B?R0Y5aDFnbkhPODU5ZHdDM2dVTVdIbVhTRDBsdHJyK1NDUjhaN1ZYWXhvOEh0?=
 =?utf-8?B?c2ZJWGZ1VzdRbEdMcFZJOW5mOWNHLzk2S1dOWk9iSWVKY21zdzNZVVUzckJw?=
 =?utf-8?B?MVRLTkswbEhkR2E4OU1EbzU0ajFKd1B3ZlRQR1RTSnJFUDJNK3BRQkEvTFI2?=
 =?utf-8?B?WjlXVVRTa2JISjB0UldBY3J2UG1wZUJONE1ubWlJblh4ZXhyUElycmtHb1pL?=
 =?utf-8?B?ZEpTYStWQTFpbXVOeHNRYUQwb1Qyd1VwQnhkVkNWYUZrUVczSGduWll6NUQ2?=
 =?utf-8?B?SXQyZVN3NytQZHVMWU5rNnU2RHMyTXZoQ1k5RU1ZSTNYeklNWGJVVG00YjBH?=
 =?utf-8?B?Ny9BdXRTWE5MSFJXVmMzcEFBYUtqTCtiK3hKVGhFRy8veWV3SHNJbEdpaWV3?=
 =?utf-8?B?NEdmVnRHQmJRVURLOFJBbTVQM3lrM01jSGtqTHljK2pjOUNvZHREajAyT0Nz?=
 =?utf-8?B?VERTN0lMZTdUVVJzYlE5elFvS2YxMDMzRTlXVVZmb3AwS0RlWldKc3FyWFVC?=
 =?utf-8?B?eUYvTXBvTnN4czkyNHQzNGZpcnY1cDJSMUdRVmNXS3JENlp6T3pVTUtFQXNI?=
 =?utf-8?B?WmF5OGFiclNIR05rRXdITi93anpNbGt3bjEvWlhWNHFEV0M5MjFmVE1ZMVpI?=
 =?utf-8?B?MmNTdkJ6b2dNeHV4cTJmdkJuUkRaelU0R21YcytRSG5yK0IwTTU5NnZ5NGhW?=
 =?utf-8?B?NVdkbVh3YjcwN3JFV3VjcExHSmw0OTJURGljekhHcGtpTUZlSGlDV3haTUdx?=
 =?utf-8?B?L2FuNHAzR1RWdGNLUUZJNkpHcjRQbG02d2JYQUEwUHFUSUh2K3hGa0thMDVP?=
 =?utf-8?B?Y2pFRTh1S1hWbFVPVm9YdlNRaHFHNW05aDlkbUk4ZWppUFB2b2twUklsb0Vv?=
 =?utf-8?B?VFphejg3a2c3dSt4WnpNUitvK3pUY1loYkYxZVk3OU1EcUN2T09xMW96L0Ja?=
 =?utf-8?B?WWR6RlZOZnk4cWtubi9iQVJMM2Q4cEVDV2NyVU5NZ2gxeEpPWnRWVS81TVBn?=
 =?utf-8?B?VUlORWxRckpmMnJ3czFtY2FhUTFvSWJOR3JlOTNXajhLcnpBZ2E4KzBiTkZ5?=
 =?utf-8?B?V0swQWMyT3F5UHFlZGFPS09wMytJNi9mSHJKaVNReVFMaE5COHdhVWNFOUxZ?=
 =?utf-8?B?R3RMWSt1YkFkUmVSUGRnQVFCMVM2YWxKVDBqWGtXS2lqMkczb1NFRmhydEt1?=
 =?utf-8?B?cVc4ZWl2cFRFV21mTkh5b2I0eU15QXRjUVR0UE5wYUk0NHlFS1FlRmJ5NWc0?=
 =?utf-8?B?NG5OSzh3Wit2dnpQTHIyMVlkYlJMSEMxcSs5Z2ora29VMFlxeHVCSGVFMHZx?=
 =?utf-8?B?NTgyS3FoelduWERmUUUrNGM2V0E4ZnBOSXFaQ3BoNmZsQndHajRldzlRaW1Q?=
 =?utf-8?B?THUyVnRXRnpCOG1PSlFrcHZlTFZaYlFOVUZoQU5BV2JWeGpDdGcyVzBYWVU0?=
 =?utf-8?B?NlpqcXVzWWtWbGc4aWdmdExBK1E3VDVJVW94a0R1M1B5MVVuMC9FSitmWCtl?=
 =?utf-8?B?eTdnMEJodXlaZXRRcDVTWlAySzlyWXhPZzVqSy9UcHRRZmpYTFh2R0hhR2N5?=
 =?utf-8?B?RUM2NXlxZ2lPVVMxemdWazh3M29QaHhTNktVd2VhakNUZkJldEVUVnJhODhs?=
 =?utf-8?Q?A+GUI/Vwm+p7nhpx6Uf16vE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4E709E43230744186E63E048835B18A@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f37f5d22-9d87-4efe-ede5-08ddaf5bc139
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 18:04:37.5049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e/3R6Pf8HmESxkIJC5l+L+/ZtIDHM9in09T3RBUZOh+hablkqPBPiQIhCS9H74ZqXHep5kscn+ehuWUEf7kWpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3839
X-Proofpoint-GUID: xW3sBFfcE9n3bhPJ_4J7gVdOnru0jUOl
X-Proofpoint-ORIG-GUID: idoongBX7Z0PRRLZ7SZqZvIGkSrMvQq2
X-Authority-Analysis: v=2.4 cv=KaDSsRYD c=1 sm=1 tr=0 ts=68545139 cx=c_pps a=gqt8WtrcWjxtKrE4ELBhYA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=SmkHewMKT1EVu9Eo:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=oAJKdv0USC6utIyZy1MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDE0NiBTYWx0ZWRfXxOyuOFnz83rI OUsS6nOfQy7BYUE9T8IrE2Zs4Rkc7hoD3CKPatHoPe2XOahy3d+4yOHb6HK4FAJwRAqO9LKgadp G4YcFUKc3gloKBCFYT095jJqJzZyWzXOcYrX3C2noTywrU4HnpyYnOutWquzsUmsnFe1DffGTAL
 66UxpvzjU8V2K0c83eXous2twp5iTZIueGu7aZRO70TMXsMCNgCZw05nwXU2m9Wo7aBiuH4rfcl DjkKSo/rnH4e/4Lcnq9svJJUaYfmBLqdcP6H/omIAp6SLFCQmQtOJOq7LEfO3goyf3+49gWQoRK R6pOooxNYnnVlxgt5ldVm59oSuVqjydEXAakX58tg84MmWXdEvgF7C4Ej3cSXj3T2cISci/IGIA
 j/qc/KeSr4AC5sQMcX9KVwLGdahUxkYVth1sEvFBx4fn/nefpn9rw2n/5dkqgUj3OV2NV2M3
Subject: RE: [PATCH 3/3] ceph: fix a race with rename() in ceph_mdsc_build_path()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_06,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=792 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506190146

T24gVHVlLCAyMDI1LTA2LTE3IGF0IDIzOjE1ICswMTAwLCBBbCBWaXJvIHdyb3RlOg0KPiBPbiBU
dWUsIEp1biAxNywgMjAyNSBhdCAxMDoxMjowOFBNICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28g
d3JvdGU6DQo+ID4gT24gVHVlLCAyMDI1LTA2LTE3IGF0IDIzOjAxICswMTAwLCBBbCBWaXJvIHdy
b3RlOg0KPiA+ID4gT24gVHVlLCBKdW4gMTcsIDIwMjUgYXQgMDY6MjE6MzhQTSArMDAwMCwgVmlh
Y2hlc2xhdiBEdWJleWtvIHdyb3RlOg0KPiA+ID4gDQo+ID4gPiA+IFRlc3RlZC1ieTogVmlhY2hl
c2xhdiBEdWJleWtvIDxTbGF2YS5EdWJleWtvQGlibS5jb20+DQo+ID4gPiA+IFJldmlld2VkLWJ5
OiBWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4NCj4gPiA+IA0KPiA+
ID4gT0ssIHRlc3RlZC1ieS9yZXZpZXdlZC1ieSBhcHBsaWVkIHRvIGNvbW1pdHMgaW4gdGhhdCBi
cmFuY2gsIGJyYW5jaA0KPiA+ID4gZm9yY2UtcHVzaGVkIHRvIHRoZSBzYW1lIHBsYWNlDQo+ID4g
PiAoZ2l0Lmtlcm5lbC5vcmc6L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC92aXJvL3Zmcy5naXQg
d29yay5jZXBoLWRfbmFtZS1maXhlcykNCj4gPiA+IA0KPiA+ID4gV291bGQgeW91IHByZWZlciB0
byBtZXJnZSBpdCB2aWEgdGhlIGNlcGggdHJlZT8gIE9yIEkgY291bGQgdGhyb3cgaXQNCj4gPiA+
IGludG8gbXkgI2Zvci1uZXh0IGFuZCBwdXNoIGl0IHRvIExpbnVzIGNvbWUgdGhlIG5leHQgd2lu
ZG93IC0gdXAgdG8geW91Li4uDQo+ID4gDQo+ID4gRnJhbmtseSBzcGVha2luZywgeW91ciB0cmVl
IGNvdWxkIGJlIHRoZSBmYXN0ZXIgd2F5IHRvIHVwc3RyZWFtLiBIb3dldmVyLCBJIGNhbg0KPiA+
IHB1c2ggdGhpcyBwYXRjaCBzZXQgaW50byB0aGUgY2VwaCB0cmVlIGZvciBtb3JlIGRlZXBlciB0
ZXN0aW5nIGluIHRoZSBpbnRlcm5hbA0KPiA+IHRlc3RpbmcgaW5mcmFzdHJ1Y3R1cmUuIEJ1dCBJ
IGRvbid0IGV4cGVjdCBhbnkgc2VyaW91cyBpc3N1ZXMgaW4gdGhlIHBhdGNoZXMNCj4gPiB0aGF0
IGNvdWxkIGludHJvZHVjZSBzb21lIGJ1Z3MuDQo+ID4gDQo+ID4gSWx5YSwNCj4gPiANCj4gPiBX
aGF0IGlzIHlvdXIgb3BpbmlvbiBvbiB0aGlzPyBXb3VsZCB5b3UgcHJlZmVyIHRvIGdvIHRocm91
Z2ggdGhlIGNlcGggdHJlZT8NCj4gDQo+IEkgY2FuIHNlbmQgYSBwdWxsIHJlcXVlc3QgdG8geW91
IG5vdyBqdXN0IGFzIGVhc2lseSBhcyBJIGNvdWxkIHNlbmQgaXQgdG8gTGludXMNCj4gYSBtb250
aCBhbmQgYSBoYWxmIGRvd24gdGhlIHJvYWQuLi4gOy0pICBVcCB0byB5b3UsIGd1eXMuDQoNClNv
LCBpZiB3ZSBkb24ndCBoYXZlIGFueSBvdGhlciBvcGluaW9uLCB0aGVuIGxldCdzIHNlbmQgdGhl
IHBhdGNoIHNldCB0aHJvdWdoDQp5b3VyIHRyZWUuDQoNClRoYW5rcywNClNsYXZhLg0K

