Return-Path: <linux-fsdevel+bounces-40258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDA9A2147C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 23:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37FE1622E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 22:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1121E0B86;
	Tue, 28 Jan 2025 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nQSLjflZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D6618FDD2;
	Tue, 28 Jan 2025 22:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738103876; cv=fail; b=k2FhFms4UMvjhQUsT35G5A9USTokElTT4efYzmMfjfXRPA4muiLSgsyIJpFagDjkSH+Cfpbf4r4QsdnuqPHglEzVT7OclcWbcYG99xzUv6h4iLbg3nakpjrV73t8bz607IJkJvJjbwyqST1Tc0f2qRcxy1rnZHM5uf7TmY7ZUfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738103876; c=relaxed/simple;
	bh=XQBARIpcd3Hf6dWcuqzvF45oCofZy6fhdTrQzpVgl6c=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=sFMXJ8yFPiF6Uf16BxA7GtAGJDdwLp9mPAf0dH+gT39fHeyuvFPcOWSyXRjV6Ho1b0aNq1wCEU7zOKo821+N1dtJjEP32MBp4UkOmV4H8SqHwA/k86Eb9/PsKmeulM6zdfpMM6J6x0OwoFD7bhe4FIXc+Vm72z2HSswJ1nD8VVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nQSLjflZ; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SLS6Gr011126;
	Tue, 28 Jan 2025 22:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=XQBARIpcd3Hf6dWcuqzvF45oCofZy6fhdTrQzpVgl6c=; b=nQSLjflZ
	kFyJ9Q3upiwpoPyW6fbN5UXi5HyaSYNnLXtvIDbs6Jl6R2c1qkS3OsFHEeHdkd2j
	hci1bWDrWTtxE2Cvz+7rNF9rBDeUxnKh3ZN5d/ZV3VkqdoitIHrH0lfm3FzUq+SP
	R7cvRMvBrKLgFYPqyhpTX9J9I0aCAU397joga4SlPlsyam1DGDRCkTGl2pZ2L7Mj
	zHOzvC8ySq8RCp/tFM1RDEFBNoR+7P7sods+x7yL4AvmDH4kFDADUWszFNOO9Tha
	EeiEA4cheuGNWvP3Z6t76YDex5SL5bnTdO0tKHXnqsFPzqUJiMte94k0Ixsjbt0N
	ElOj87l+eirxsw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ena9wj4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 22:37:50 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50SMbn1O025661;
	Tue, 28 Jan 2025 22:37:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ena9wj4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 22:37:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqXV+WhTZp9NjeEn5MfWGtgPFNnbWvJK4vgAENSVt3sYXaCrdOD6WSgD+gmHnGdh3uxjQOOmNUw4O8UgRvW2G0Qc+Be81uKOpqIqyfmqy4MkmUkwK8EL/ABnPP0y+v+pC+k5qsOtwApsS5VxzeDE7N1YvJhuBZFjRnHkn/CU6/RCYGKAfNDnhQTo2+PvTl22CS7GoKW/o/XhHMUz0x4aMC+3aTqo5iBaCk+Z1FSc8wIaVQ+MwaGDS9CE3xa11oOF4LgGqOqIv6RrnRhiVwnqn9uodN8XvECvTWKw5JU/U1EmL479EdO1rAcl8OtUotaauaTblO3GMR2z7qSqiKyQ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQBARIpcd3Hf6dWcuqzvF45oCofZy6fhdTrQzpVgl6c=;
 b=Qz0wg53U7wopInUcdqQdXBlPyVry8e31whcwSdnSJIBeAlkgvDtZ747R76syTA7TIk383OrTXSPetkh9K8YdM1J66LvPBvjm+Q7/odzFhih/RD+Cry8nIyCqbJEk+eGZA4DbIWTkNX+RE0UD3j7LayzWuqVDZx7BJq9ajc0zMtilAloE4ETDMHlfq74gNnxoG0e4VGUy24emZJCTZ6W/r9H8URXQn76VukT7xjRNqjZHYAloL7cAaLlNrWHNbk4iOCRn3wdkzI6YxgXkFE9VwxKpJk834WHqiL5khAzgzzALhzmsZzFxbQU3LYtksC//4cd89Z8HJ00xJX3Gv5kaSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB4573.namprd15.prod.outlook.com (2603:10b6:510:87::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Tue, 28 Jan
 2025 22:37:46 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 22:37:46 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: David Howells <dhowells@redhat.com>
CC: "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] ceph: Fix kernel crash in generic/397
 test
Thread-Index:
 AQHbax51YyLDQhgFm02bhTgbrhqIz7MfakoAgAuVUoCAAWlQgIAADEyAgAAzSYCAAAQ3AIAAJo8AgAAA/AA=
Date: Tue, 28 Jan 2025 22:37:46 +0000
Message-ID: <dbf086dc3113448cb4efaeee144ad01d39d83ea3.camel@ibm.com>
References: <d81a04646f76e0b65cd1e075ab3d410c4b9c3876.camel@ibm.com>
		 <3469649.1738083455@warthog.procyon.org.uk>
		 <3406497.1738080815@warthog.procyon.org.uk>
		 <c79589542404f2b73bcdbdc03d65aed0df17d799.camel@ibm.com>
		 <20250117035044.23309-1-slava@dubeyko.com>
		 <988267.1737365634@warthog.procyon.org.uk>
		 <CAO8a2SgkzNQN_S=nKO5QXLG=yQ=x-AaKpFvDoCKz3B_jwBuALQ@mail.gmail.com>
		 <3532744.1738094469@warthog.procyon.org.uk>
	 <3541166.1738103654@warthog.procyon.org.uk>
In-Reply-To: <3541166.1738103654@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB4573:EE_
x-ms-office365-filtering-correlation-id: 9812d046-6c66-42f6-d77d-08dd3fec6362
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NG4wTnlkT0RmWWNvYUlHekhFZ1FBaDVFakZKNTRIaXlnTEVKSFRWZ0p4bGt1?=
 =?utf-8?B?QjN5bUE1aHo0R1pTcVcxOHpYNGFKRnhUT1VHZVZRQTR5cE4wU0RXUTErYXV5?=
 =?utf-8?B?ZUo1TFI0RlN5L1RQSmdVNWRiSE40Y0lmb3I2RWNhaS8zTkNPVkt3eDdPRDFn?=
 =?utf-8?B?ZVY3YmcvVEt1QjJ2MWxQYjdEeG12YkFEeWgxaDlQZnoyajhrVk1Pd0p6S210?=
 =?utf-8?B?bVZ2SzZRZ0tlL3gwT2hEUTlsaENUSWlDQzgwV1pCSCtXRnQ5WW1KWGZWaHoy?=
 =?utf-8?B?RnFQSzRyd0V1dkx4TDNXRkV0cEczR05rbC9ZS0Iyek9pVnpKM0RIR1QzNTFE?=
 =?utf-8?B?M3VkenF2VUY2b1duZTlUWjJSMmsycEJpUTVQYXVGZ2QrRGNIWWNhNGV6UlV0?=
 =?utf-8?B?MG5md1FWc2p6Ym93MlJZSGJEY25BSThXNSt3ZExYdWo1OWwwSVUxNFdVTHhM?=
 =?utf-8?B?RVJYcHU2elJkNXNLcHZDa0wrN3JMMzV4VjU2a09scjJPNEdsamtZc2dQaitr?=
 =?utf-8?B?d292K2ZmV1EzLzJnRnhyQ3BZQkkxWk5IT3Rzd0VuVUJtNWhsTFg4SEZxVEVy?=
 =?utf-8?B?Ly9zaWQ0NHVTMlZXbTdLcElBQ2ZOOGozSTZxSytoTlE2TXNVaEozZE52Njhy?=
 =?utf-8?B?UFp5MVF5WnZ3Wk5TNndQVllSVDQyQk54T0VaNXN3bm5UUWxQMS93MzM0U1cy?=
 =?utf-8?B?alBMSWNiTVpZV0pOVWJLVmJDVTZFWW1rT0NzWE80dlZaNjBob05MeW9ieDZP?=
 =?utf-8?B?bEhYUTA4NmtRNXdPRE9SS1VnUFhFRjBHcklOSHZWUWNZdDcrcGUzVUw0eEMy?=
 =?utf-8?B?aGRZcXh4anYrOHNZazFWZngzOG9RUEl0OVplV3BmS0ZYYzVSai9pMEVVeklC?=
 =?utf-8?B?V21kOFFLaStyMytuWVo3QXFjWElMdlpLeG55VFcxcHNQYWpSM0JZN25qV1lu?=
 =?utf-8?B?NlYreEFTMlNiWEkyNmR2NU92UWVURkxVbXB0R2JpWFEydWcvd2NaSVBYQzR4?=
 =?utf-8?B?WXVKd3g2ZjFMQVowWGExc0tYeG13a0U3Uk04VDIwY2tUMUlCVVIrMVBnUFpj?=
 =?utf-8?B?anlpRHB1bWxuYnpLbWtEM0F2c1p4TDRJVEs1eVRWZkpyYlMzU2FGUENOd1NB?=
 =?utf-8?B?czVvUkQrU3N5NU1TbENJbDVHTlJ2dmkzcWRBUm9Kc2NpK203NUZYUk5MYmFH?=
 =?utf-8?B?aFU1T25EcXdLMjhBdllGaVVNTTZKTHB5SGJGVmJkTUN5QlMrajQ5bjlxWGha?=
 =?utf-8?B?WmQvaHVjbEdYZitYUk01NXNxTEN2SlhzYmdsYS9EcWxIVHBOUlc1M1RVenlS?=
 =?utf-8?B?S0xQeEJTU1RMOXVsRVo2cWtoc29nd3pCNTZ0WGVNQVNFVFcxZEFiSlo1bk14?=
 =?utf-8?B?emN3ZEVSSityaldpa2tPRTFuS3l4RHZ3cXhTV2Z4QWpBY3FuSWdIclRGK2N2?=
 =?utf-8?B?bDFMdFZ3MVgvWFdmVVdLQVUzYmV6dUVRV0szTGRTZ2J2Vk5VNlY2NmxMdVpO?=
 =?utf-8?B?bGhFbm5mLzU3UXRyYzc2NlJUaXB2Tllha2ZLWXpIQXd2YjlNZFBYN1FlQWg0?=
 =?utf-8?B?Y3h5dHJRY1ZuK3REUGJHQmVZaUo3S3NMNUhlN1RlRHRFL2Q3VWU5VkZpOUk2?=
 =?utf-8?B?bFhiV3FVK3JoTTlCNm5wY0Z3elNsUlZFaWNPNUg0aHRpWUlyeXEvZ2JHbnlM?=
 =?utf-8?B?dE4zdEo3OFRSWHRWM3pTUmxGRVNtLzhINjJMWFRua0lnUHpWSFNrY3IzOU5k?=
 =?utf-8?B?c1RyUHBEVStqeWNMRU0vUTRoMmNPMjVIek1jcWt0ODNKbzU1TitqQkVHNm9D?=
 =?utf-8?B?YWhoNHdXNWpRenJIN1NBYlFvMFFwOUhSQmk1QjJGdS9UWXN1emozMEV2MVAw?=
 =?utf-8?B?TnlUMk4wY0JHMEZOMi9vbFlqbCs4T3IwRTVzRHMyZmdHcXJwbzNRdWhxRXgw?=
 =?utf-8?Q?AQwuXXr39P44aWx64E75UIPVtrRED9n8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UEtpQWVnS3FVWjFCSEhPNDFRRHc3Qm1kUlZtVWR0MmkrODNKR1daeHVGVGtr?=
 =?utf-8?B?L2t2QjlGcGErd3Z1Qk4zanZSU3NGMVRreTdEVDdDdHFrU2dVN2RzU1RrcXhx?=
 =?utf-8?B?VzBkdGpiUTB6SVlIVytOd045SWdURVhmQklNMWVYaUxpQ3UrMGRCUEk3K0U4?=
 =?utf-8?B?Yjc0VGZ6QXdUMG14b08xanBjTW1tSTNVMTBXaFZWSTlKazVucjZNK2txY0w0?=
 =?utf-8?B?VG5aVytVbkJwcFJPdFJ1NldhcG5QM2lRekVmbi9uUWVYVzA5UkhtbHpJZmFy?=
 =?utf-8?B?VzBIMnRCVDdKczMvNjhXQjJFUnFsZTN5aFNmYzZtYjlCNU9TU2RmTG5XVW0w?=
 =?utf-8?B?OCtKbURwNDY5WjBUTFp0V3FLdnFCTGJxU0pLVW5OV0VETmNRbmpQUUJZWVJn?=
 =?utf-8?B?Q3VhbG9Ea09CVXpwSzZuRFllMm9wQVE4UnZyd2hKRi9xQWpSRGhmVHZWN2Ey?=
 =?utf-8?B?dVJFS2ErRFlDd3FRTGNMRzlGemFSdVk4NEJFc2Z6RTIyUXFucTY5KzE5blpn?=
 =?utf-8?B?QXV6SVFXVDNiSTdyU20vZUY5enQ4VXk4QmRrajBrSWU4L3dMZnJMM0hWejY3?=
 =?utf-8?B?OUlqQ0xIcHA5eWdhNG1HV1gwbGFsQTZmMFJXUlhOWWxBbVQ3UmgzSjNVNWRh?=
 =?utf-8?B?cFNFWUNBNFV2UWhkaWZ1cE83bHhoSEc2ekFIM0kzQmJpVHBGc2NKUEliQnJB?=
 =?utf-8?B?Y25Xb0FrK0xyekliVGY5bDNGNG04YjErbHV0WllzMm9NbDVIdXl2S1ROMmtG?=
 =?utf-8?B?bGdWbEhyQXU4QUJxem5NcVduUnI0eTZodkZiN0hwTWM1MGZKVnk1NnRuZkdo?=
 =?utf-8?B?Q0kydWc5NUVOL3JPdkJKMmRML3IyNDZOV1RhQzdDQjMvcnNrd09VQXBQT3o0?=
 =?utf-8?B?bzJacEVvS290MCswZ3Zsa1dGYlBqNFNqWk9qRjZjaHAzQkJtUlVBRHNkcU9T?=
 =?utf-8?B?dUN2d3h1dEFTS0F0M2wzZU4wdmNhSmZuTzZSblAyZnlsOUpicmxpT2dpanNs?=
 =?utf-8?B?VGVoNUVFajVhSzlZdytjSUsxbWZRUnVyNkZpTmxSSjN5c1ZkZlRHeFZZRE5a?=
 =?utf-8?B?YVZ3eG5WQXE5K1piUFNvNDlldENpMFBTRHFBSU1naHI4Y1Z6aWQzditDSkhG?=
 =?utf-8?B?VnJkdHhsUXVrd3d4ZVFrb1NaaXh6UFk4Y0xyMHBEY2RpSklrbE9FZHMwMWpM?=
 =?utf-8?B?bHNXVTNuV213SUZORVVKRE1kMDRFaDVwYzRMMi9PUjNOVFhWV29TNXZFdk9x?=
 =?utf-8?B?ckwxaVBzdngvcmVkRGVFSmRKZnR4eFpvTFM5ZG4zVmRZZkhPSktQSG5WQXFE?=
 =?utf-8?B?WGpTck56Qy95M3RVOVlNZHdwYnNqVU1hYlBzU3BkdFpESnJ6Vm9tYkhmYldN?=
 =?utf-8?B?YzcxaGhoeUZSNjFMeWN0d1FmTXNxME9DcmhCQVdMblR3M0ZncUJycGVPY09Y?=
 =?utf-8?B?T0dBQit3dGRObTBacGUwbUgxRnRSMEVydUIxcDFvWHpFZ0dSZWoyQjhrdEFY?=
 =?utf-8?B?dkRqdlRIY2pIZmZmd2VsVkRmcDU4L0UwbUpGWURZYjRZQjJNdmlIZVNTVGVJ?=
 =?utf-8?B?T3dDZFZETG1VMEZYY3BvZzZpamZJLy9xMHROV3VzclNnN2RwbTNQcmRVT0NP?=
 =?utf-8?B?WnltRkxZMlZvL3lWQmd5QnhLK3I1K2tYREZZOEJFellFN1BWSmswMWxac2dF?=
 =?utf-8?B?RU42bjRNOVdrN2lCV2N3Q0J0VVNsd2x6eUJobXEvZW92ODZLMHRVMlM0eDRl?=
 =?utf-8?B?V1lBQTVIdFVUR0hUQ2ZwWWlaSmZzK0tVNFJBNUhadnZxdVlaN3cvZVAxaDNQ?=
 =?utf-8?B?VGk3M2pGODMwSjZVNCtkQldKbkNUMk9iNUsyVHYyTkZ2OXUxcHlkYUJKdGgx?=
 =?utf-8?B?R2QvR1ZLRDAxVkozbmZGWGhNTVVEQlNwZHhWamxRdzdlL2M3aUtMMEpGRHVv?=
 =?utf-8?B?TTBwbkpob1VVR1RSOUxUWXhnV1BCdkM0S1NNeit1MlpWOUh0V3lmZUk0MEJO?=
 =?utf-8?B?TVVKNHJFLzlLTEVTUENwVTZnU3pRRGMwQ0UzRDZSTEt4citrbnVWZWJxc0l6?=
 =?utf-8?B?cEM4ci85aHIrN2xmTGRLWHltYnVMKzlraFFzc1RjSkNXdDQySUNHUzlBeTRu?=
 =?utf-8?B?U2VjRG9ENFlqYzQ4OW05YUxUWjFIZlRacjZWK0VrdWJKeTRYWlZnUkxucy9p?=
 =?utf-8?Q?NfJ+YcoNrv9ojzeIzwQ+aMU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCB4F59D4870AB4FADFFB639A8957C06@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9812d046-6c66-42f6-d77d-08dd3fec6362
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2025 22:37:46.8333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cxVHgLhuFFo7l2YvGJe811eotLGvCVwFcHeZmKBnPzNSbCUTNeLou8DSpG1zebWRfsWKwxwPq/gJ7ZTqiCJuPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4573
X-Proofpoint-ORIG-GUID: j-wI0cWozUSyModScOGOb4VcUYL31voe
X-Proofpoint-GUID: tVUidhZNf96Tkm6ZHIeSAVgSw8TozGQO
Subject: RE: [PATCH v2] ceph: Fix kernel crash in generic/397 test
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=888 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280165

T24gVHVlLCAyMDI1LTAxLTI4IGF0IDIyOjM0ICswMDAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0K
PiBWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4gd3JvdGU6DQo+IA0K
PiA+IEFuZCBldmVuIGFmdGVyIHNvbHZpbmcgdGhlc2UgdHdvIGlzc3VlcywgSSBjYW4gc2VlIGRp
cnR5IG1lbW9yeSBwYWdlcyBhZnRlcg0KPiA+IHVubW91bnQgZmluaXNoLiBTb21ldGhpbmcgd3Jv
bmcgeWV0IGluIGNlcGhfd3JpdGVwYWdlc19zdGFydCgpIGxvZ2ljLiBTbywgSSBhbQ0KPiA+IHRy
eWluZyB0byBmaWd1cmUgb3V0IHdoYXQgSSBhbSBtaXNzaW5nIGhlcmUgeWV0Lg0KPiANCj4gRG8g
eW91IHdhbnQgbWUgdG8gcHVzaCBhIGJyYW5jaCB3aXRoIG15IHRyYWNlcG9pbnRzIHRoYXQgSSdt
IHVzaW5nIHNvbWV3aGVyZQ0KPiB0aGF0IHlvdSBjYW4gZ3JhYiBpdD8NCj4gDQoNClNvdW5kcyBn
b29kISBNYXliZSBpdCBjYW4gaGVscCBtZS4gOikNCg0KVGhhbmtzLA0KU2xhdmEuDQoNCg0K

