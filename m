Return-Path: <linux-fsdevel+bounces-41754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B22FBA36710
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 21:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123B93B222F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 20:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87801C8611;
	Fri, 14 Feb 2025 20:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LBmljaMn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66870192598;
	Fri, 14 Feb 2025 20:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739565962; cv=fail; b=dctOjuuIFR/ue110OMK3h6elxHdEIZH+LnWEi0qkId5S/jpxSJYJ8ormi+0ALgmVKfTETsFNE3tYsn23PWbUW8yVGmu6AYEtW4NIZ39ZyoVg2HfCt3VMWuBawwkU90LuYY5gzKHXXdRsmcScBsLUD0LYjzCwBh8Vx2dwWcExUHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739565962; c=relaxed/simple;
	bh=+P5iM3f/j74SVjgQk7BAptPCiMCLzwUmA5i99AjYj4k=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=IxV6+86Bi1QfzSirc6YhDQxTmuiRnHZfSzcYpxitNGTd7FkLoznGYTIJJjUgvQ0XnTSiIhwKqAKO9KXFCsTjOleVbEzNdgI7plFYW1ZD1bIl2XTRa/iC9bjSVWF/DqRV/6Fgbw1UeO4N+n+O3+k8uqtF23Yl2zoH8vkgzANRegM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LBmljaMn; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EFdfeZ032533;
	Fri, 14 Feb 2025 20:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=+P5iM3f/j74SVjgQk7BAptPCiMCLzwUmA5i99AjYj4k=; b=LBmljaMn
	DFtBok1ddHH94DSN+fU8KdrTf1bsY7uW3CnFOC+viUABwPidGaLvnZKOfvkcDxUH
	AEXUOKW0gZsDx/CyDvXrBuM1rOVZRlI8/RR9YSR7yszZ8HT022QMKzxNmD+sYoAC
	A3eAV7rwRFiJk3xJJIcRl4pTHP6+5CM5z93TNoF15azarqwhfwgXFg+0sne/RTuK
	u8ZfRCn6m8PXpB3BNyXYK5F7SW74a+Tu7knT84UlcCceVfHjGSdTl7mA00MhYcfY
	VLIQBscg+CNFoolUnzSYfwaAWBR0NLJ+uPisk+yF/G5Ip/aHAho4ZNPLGXzVyMWt
	zyCHGZdcY5t5kQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44t8nuhede-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 20:45:57 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51EKjua6003748;
	Fri, 14 Feb 2025 20:45:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44t8nuhedc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 20:45:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANCJsdxAPOReqxb921qfgQoDT9YvLrb8NAOCfcAVek3O2x5rQgcD6P4cMDcN0dvXgvnyBSkfYbZIATUD3F70NfX0UhSSotP70E50LVDWW7FLgeAPs5pUCaYR9CvIzKd/jCbfnUsVvH14DuEWSp2Dd2ImgEiyABgt6dgcowwDEHI6LCT0dpC04yGDDYAxV3Zs2a4V7vY7pVIUUhpoO3PN3roq6jvnvf9CfPPNQ3vbXc8EejZCQu4PdSzzEZWCHyoUcwGMF0uahzUdXPCg5AmEjfAE8S0OJl2GNZjKj6bDdpQQC/qoQt2EoADOn/bhDKnFG4XH8EBUMEhBCj+EAbcDKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+P5iM3f/j74SVjgQk7BAptPCiMCLzwUmA5i99AjYj4k=;
 b=AoYfwR5DavPGRqD1XVI3cQ1SfgQVWJlzrWGKyQbMOTYz9/AQyVu4Y5sBAtdqPIjvGYegBr+3mAXfXhi0BXkRkCuxgXM9+HJXCT9mvU4W3GzoBCLg3yvrFoHBi//uYwRyNyGzMYtJx/IP08drZ7Hx9VtY7hdB+T72Jner4Kd6z49yxhBH+qnkJ8ncbNOsqYZA1pVj3QvdBy8zbpPgZb5t4Z4LRJ9W9hGG4eNdPVTk+kf3EWoMCr7rQJ9gOqajp1CtlbkFaYUG7VrnrysLzPoy5MgXKgko+D3bePMJ2OOvfTvHTvPdW8ha2UeHPJyTueeF+9WwAFRjjQuQB++ZmoE7Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS0PR15MB6039.namprd15.prod.outlook.com (2603:10b6:8:156::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Fri, 14 Feb
 2025 20:45:53 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%4]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 20:45:53 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: David Howells <dhowells@redhat.com>
CC: "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        Patrick Donnelly
	<pdonnell@redhat.com>
Thread-Topic: [EXTERNAL] Re: [RFC PATCH 0/4] ceph: fix generic/421 test
 failure
Thread-Index: AQHbfwSitHI2EkU8vkKyDr1N+60bsbNHD9oAgAAyHQCAAALggA==
Date: Fri, 14 Feb 2025 20:45:53 +0000
Message-ID: <7596dd297239c4226a0ff6005bbb368733d38b4a.camel@ibm.com>
References: <4e993d6ebadba1ed04261fd5590d439f382ca226.camel@ibm.com>
		 <20250205000249.123054-1-slava@dubeyko.com>
		 <4153980.1739553567@warthog.procyon.org.uk>
	 <18284.1739565336@warthog.procyon.org.uk>
In-Reply-To: <18284.1739565336@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS0PR15MB6039:EE_
x-ms-office365-filtering-correlation-id: 61feec43-b481-45f7-cec1-08dd4d389325
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VjA0VWlXZVVxN3c1d2ZTd1dpZWVsUkhZMm1TcGRqbFdZckR3TnNGMG1oUitR?=
 =?utf-8?B?RmVmOG03SXdLeUxNTy9nSnBveGV2NXVyUTd3bUhDLzJ6OGtxUEl6RXVDUDVL?=
 =?utf-8?B?cDNlUDdOSndJRVR2MWE0b3NyL0pQZzFUYnFTdC9QWUgwR1Z0cndBd2Z6Rzly?=
 =?utf-8?B?Tlg5cERMWHg1bldsQmI4ZGNERWRNL1ZGaVZIVVVVc2lsTVgrei81OXpHRGlo?=
 =?utf-8?B?ZnBtS2tXSnVvZGVqaFVMT09lVEEzVXYzVVNQVXg1V2YzdkdJQjRkRFZteE5R?=
 =?utf-8?B?Y1RDZTRDYzAwM0xwNEdicytFK09WeEh1cFJsVW1YU0NCNDBTNWc4QVhaNzdu?=
 =?utf-8?B?eWhsYURmNHAyMndPQ0g4cStHKzBKemJ1RisxWnlBMnAvRElML0ZlZnNEQWhO?=
 =?utf-8?B?OXNXa2dvNkVyTnNNcHVyV0ppV2VjWS80alczUW9YZ2JScFZtWDZhbUdVUTVD?=
 =?utf-8?B?ZkxJaUhQbGg4dWdUV0Q1V2dEMm9Zd2IwdVJ2ckd2MlVSMTQ1L2tJUXdKb1Rx?=
 =?utf-8?B?dmZ4Z04za2JTL0xseHZzSWRNYzFQcUdiWDdDYlAvNnNZMHlxZkRpUFpSV2dw?=
 =?utf-8?B?Q3FJdmdXZTdBN2doSWZTYkszZ2t4Vm10eUFnNFp0ZW1aU1M2blBWMGJLdmhL?=
 =?utf-8?B?WW1tejRMQjdLK1lPNmZqMjlRVW1JbXJIWWVhM3pDMXduVFpDRlc3ZW1FVVVU?=
 =?utf-8?B?c09YSDJnVWMvZEJBUFdoLzJkRVFlTkFnelQxT1J1VldSVVVUbG02dUNTRjJu?=
 =?utf-8?B?SnlWNzlBVnV3T3dJcWxRN0psUUZpNHFrZUtHVXRUYWt0SklieHNJYzZQRGJs?=
 =?utf-8?B?Wmg4czVzY2NQb2lRSllqUGJSbHk5RUZNVTA4dkhzRkFVUEI0TGtBMXlBS1JO?=
 =?utf-8?B?bm4yTzVZSTZLOXBBNXdhSmJxZXhVWDFXSFJzUFpZZlE3S2tUWFd6WjVSMksw?=
 =?utf-8?B?Z3FMMHovQWhiRy91QXlVYUl2ckdrMWlWbXh5Ui8xOWhvNVhoMWt4YlR5cWZh?=
 =?utf-8?B?b3hrYnpmOG5GT3BUNUw0RVFac3ZpM1RHSnpzMGZlem9Oa05HOHMvc2xzTWFs?=
 =?utf-8?B?VUtZeUUzcmhXWjNVdmorZXNkRUxtekYvQ1U4aGR1amNHTkRwSnUvUDRsRnA4?=
 =?utf-8?B?Z2ZuNVhDU1lWYzVvS3hBRUlvVjhicWgwWFJHRzVhckNDNllxdWNnTGZtRDZX?=
 =?utf-8?B?VHhJdWt6UUdmcEdLZmRUcnoyWFlTR1pOWWkxazhBM0hYbnhHS1pLK1htK244?=
 =?utf-8?B?S0Jla3JOeENtUUVad2dNZ2NrdmVTTmNHTm02KzkrYU5ualNXZTNRQU5EVEhi?=
 =?utf-8?B?c3hacUdrT0tZcnJzZjY2N3hScG8wU1JaWkR5K3V0dzQ0QzlYbCt5c1FIUmJP?=
 =?utf-8?B?U1I0OWltd0JCRFJ0bURsaDlFQU1HNFJxOCtFc0o3NURVQUNnenF5NTdFbDIv?=
 =?utf-8?B?alZKS0NQZTNNaFhQNnRyUE5Kb3Y3RG1hQ2FxQkQrb1FOV0lNVDMxangvNERr?=
 =?utf-8?B?aDhpRjdneE1sS05Gck5pcnAzVFFQaFpVUW1BVTNCUmdLeWd4Y0FtNUR2TjJs?=
 =?utf-8?B?bm1iUUkxSEVVNGx3RUN5clVSN3RaWXRLd3YvY1Y0ZTJYc3pwS2tVcVlqd0wx?=
 =?utf-8?B?aVR1N1l0YnV2cmFJa3kvemN6d0ZzVFdHMlo1bldUcHpOYXVReWkveWVXb3Y4?=
 =?utf-8?B?WTVqbUxVS2FCR1p1MEFMaGF3Njg2ajMybFRYb0dGMEZ4dUdXcjBWaS9FSWIw?=
 =?utf-8?B?dEJoR3dpdGs5TWNobmN1bW9sNFZLS3pPTmd6UkY2WHl6MGVhQ0hTTEkxb3pz?=
 =?utf-8?B?aDQ0VlhvU0I4RVVDVHpDZ1llL0tRZk1wQ01MVGZRM0laZHZhcTM0YnNxU2Ix?=
 =?utf-8?B?MVV0d1hFS3crT3BrUVJ3Z1R3QS9xNjRlUEZCSkljMmtSNGJETjA5QXNwNEN3?=
 =?utf-8?Q?k3ikrVVcZy+TQqWQaRBu7G9v3CW18mVk?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXdDY2NweWZ5V0t4NnZtM295RGxsTnlKeE9WQUh1Nm9FdkVBTFUrc3lCb1h5?=
 =?utf-8?B?cDZmdDdic1RnVVQ1U1Z0UkhVR2RrK1pDSWx3TEN4VVY0dmM4MFdLcUxMOThj?=
 =?utf-8?B?WVMzbzNGbkZBZzhVaVNlM3BLeC96NE1aWGk1Wmg3WGJJeGU1ZXJuSXU0OGhm?=
 =?utf-8?B?OVUyR0tVcTlaMDZWcUNXbXZFRVp4cnVZMWVtVzBNSTBKR1RTaVZjdWp2WjZS?=
 =?utf-8?B?cUxzTmZUY2Zzd3ZBMkRNQkk1cm1wMm1vcEFPbnhRMyttaU45cWVjNkxGZXR6?=
 =?utf-8?B?blo0eGZuVWs4SjJDc0J6MkFTd05rc3U5a3JETXdlbXVxZmQ5Z1RqMEFqaytk?=
 =?utf-8?B?c00xbjlGNEJ6RUc0ZEppUFhpR3J6V2libm5Ta2NPZFVsVjE5TVIvREdMNWho?=
 =?utf-8?B?R01KTEoxRFNRSllHR05GbVVvM21Od2ROU0pCTFhJaVNzZVVNOG5DUVNFdURZ?=
 =?utf-8?B?ZktnYzBZRHNJUS9CYzdPdXV1NFVxMXYzZlJ3akNpYXFsVUpOZTJBeHFkY1E0?=
 =?utf-8?B?ZUoyTHMybVBaQjlYUHpyRlpQakgxL1cwQUZGY1RwYWdKWlFKd2tvSytENTlL?=
 =?utf-8?B?S0R0Z0tGMTN3VkIrSG5jLzRiL2VRMkZEdzJ4aWxlZmt2NGx4YUtpOWQ2aTBC?=
 =?utf-8?B?KzJ6dmRSbGJVZitzR0syRXBLOTR6SnNQTUlndUZISGlWMmRFZkdNMDJxN1VF?=
 =?utf-8?B?R2xQYWdXbkt6MmxuZkIvMEovSk9wTktGNUVYUm9Fa2RMTWhuZmtQcks0VFYx?=
 =?utf-8?B?aFYzT0FWSm1idmhuN1lwbXBneU1kNVkzMVNNVkVzbkpIYjREY1dUaWh0bE5X?=
 =?utf-8?B?Vk5aWU1BaUJublE5eGRiUURTZmVUQlN5K3ZXMU9nMlBqcUdtN2FIc0NJRGZY?=
 =?utf-8?B?UktpYldpWUVlZzNyNHlwSW1RL3UyZHRlbm80UWdWR2tIUndBMGNnN2l5SWFM?=
 =?utf-8?B?Z3gzYmRWQk5iWTAzbmd5Wk1yNGNXSnBUeDg3L0J5UmhaaWxzWXFoVHNSWExa?=
 =?utf-8?B?SjFTTDJLeUtheEh5L3huTzBzQ3pYVE1qNDJjaTZVYU1jU05VSFNPRFFINU0r?=
 =?utf-8?B?UlZuTDQxaWdhRGR4R3NhTmtwVHdCVnNNTVltdDJ6UVVsMnNQZGFWSjMvQndV?=
 =?utf-8?B?WmVScWFoSGk3UGQyLzVxTWZQUGo0RjZvMUJMSXp5dTZQaUlMRy83UDBQOWI5?=
 =?utf-8?B?RTM2RDcwUm50MUhKSTJuVmdvc3Fyb3hJbjQxZFhEbGkzYjU4SUpCZWx6aHlo?=
 =?utf-8?B?RVNLYUc1UHlQUUk3ZlJVd0E5ZFdmUHN3aVpXL3lSRWdpdVorM05TZE9pcWVv?=
 =?utf-8?B?L0FsNWhaZUZlczRXS0toN1RhMHh0NmZmQXVxdzg1ZGhPaENnRnFYSWE5MTlz?=
 =?utf-8?B?QWhXMTdNVHdQQWpaTmZQT1ozNWgxSFdOaWR2NFVLU2FBcWFoai9oWXVvdFNO?=
 =?utf-8?B?b3FJSGo2alpHNU5zdFJMc2UvZlhmbVNaQUdGck1mT2tsc1JxRXJIeWdNK2Iv?=
 =?utf-8?B?WjQ2Y3FlU3p0M1Ara0dPUkVmZWExL2t1eUtpMUUxQ1Jxc2JrZkNRRVdaMkFR?=
 =?utf-8?B?TWhJK2pQNU5veGdESENDSS8zS2dVUC9rOEltbVZ3MUVJcC8rcENPc0h3cTZz?=
 =?utf-8?B?K0syNnlnSUxOMldHMllZN2M3OHk3VzMrbk1kRW1OSFh0VVYwcHFkTk55SlZP?=
 =?utf-8?B?MlkxbXRRemhDai9jSDZXV2JoWVlHVUp6WWRCY3g3aDk4ODVyd1R6QWFyK3ll?=
 =?utf-8?B?UFhIOXhneU5oWFJodmwwZGN1cGcvSnNESXFSZm8wRWFiVkVGY01Hb3dzSDQ3?=
 =?utf-8?B?U0MxY0pJNmI3M2N2MEs2UjNrRzZEbmJQZ3JCdDFkVGVPVXBCSkViVHdnZ0NJ?=
 =?utf-8?B?SXVGb2lDdlpLd1ViSVhEL055c2oxd0Y5YUxRMlZ3TnZzS0hQUkFnMWRuaXgy?=
 =?utf-8?B?RTB6blVSWXE5ZytHZnJDdkJldndVVkVKTk91bmxoanJ4azg2U3JaSzFxaW13?=
 =?utf-8?B?YzV0Q2ovb29aUFJIc28rZXd6cmpGWW96bW9nb05KUHNRY3E1TitxdVNvNGg2?=
 =?utf-8?B?S09ZcDhSZ3U4VUh6a1gxNjFuMEltWjhDUzdmRTZDREZyenp2eTBBSzY5MzBV?=
 =?utf-8?B?cC9JWmtzVG9IMnEyeTBDeVh0aWRYbEQ2VHZnTitORnN3QzkwY2YzN0tGeW9s?=
 =?utf-8?Q?9Sqye+1N9h40tkaYtxXLYfc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75DEF24801DBE14EBBF95EF2B65754EC@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 61feec43-b481-45f7-cec1-08dd4d389325
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 20:45:53.8341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eyg5AEhnKRWlO0npNzm4sPhjQWQAn0xMjXZ3AVArVImZL7vlxurvNpHg75Qw/GxjoC0Rfl/E51y2czgsOEkeBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6039
X-Proofpoint-GUID: nWxia5-4IBBCNKSXEKj9z8QYbObbTA7Y
X-Proofpoint-ORIG-GUID: 2k2m6eIfYqdngvHv_KTJdTXbEFsUMhxX
Subject: RE: [RFC PATCH 0/4] ceph: fix generic/421 test failure
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502140140

T24gRnJpLCAyMDI1LTAyLTE0IGF0IDIwOjM1ICswMDAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0K
PiBWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4gd3JvdGU6DQo+IA0K
PiA+ID4gVGhlcmUncyBzdGlsbCB0aGUgaXNzdWUgb2YgZW5jcnlwdGVkIGZpbGVuYW1lcyBvY2Nh
c2lvbmFsbHkgc2hvd2luZyB0aHJvdWdoDQo+ID4gPiB3aGljaCBnZW5lcmljLzM5NyBpcyBzaG93
aW5nIHVwIC0gYnV0IEkgZG9uJ3QgdGhpbmsgeW91ciBwYXRjaGVzIGhlcmUgZml4DQo+ID4gPiB0
aGF0LCByaWdodD8NCj4gPiA+IA0KPiA+IA0KPiA+IFRoaXMgcGF0Y2hzZXQgZG9lc24ndCBmaXgg
dGhlIGdlbmVyaWMvMzk3IGlzc3VlLiBJIHNlbnQgYW5vdGhlciBwYXRjaCAoW1BBVENIDQo+ID4g
djJdIGNlcGg6IEZpeCBrZXJuZWwgY3Jhc2ggaW4gZ2VuZXJpYy8zOTcgdGVzdCkgWzFdIGJlZm9y
ZSB0aGlzIG9uZSB3aXRoIHRoZQ0KPiA+IGZpeC4NCj4gDQo+IFRoYXQgZG9lc24ndCBmaXggdGhl
IHByb2JsZW0gZWl0aGVyLiAgVGhhdCBzZWVtcyB0byBiZSBmaXhpbmcgYSBjcmFzaCwgbm90Og0K
PiANCj4gZ2VuZXJpYy8zOTcgICAgICAgLSBvdXRwdXQgbWlzbWF0Y2ggKHNlZSAvcm9vdC94ZnN0
ZXN0cy1kZXYvcmVzdWx0cy8vZ2VuZXJpYy8zOTcub3V0LmJhZCkNCj4gICAgIC0tLSB0ZXN0cy9n
ZW5lcmljLzM5Ny5vdXQgICAyMDI0LTA5LTEyIDEyOjM2OjE0LjE2NzQ0MTkyNyArMDEwMA0KPiAg
ICAgKysrIC9yb290L3hmc3Rlc3RzLWRldi9yZXN1bHRzLy9nZW5lcmljLzM5Ny5vdXQuYmFkIDIw
MjUtMDItMTQgMjA6MzQ6MTAuMzY1OTAwMDM1ICswMDAwDQo+ICAgICBAQCAtMSwxMyArMSwyNyBA
QA0KPiAgICAgIFFBIG91dHB1dCBjcmVhdGVkIGJ5IDM5Nw0KPiAgICAgK09ubHkgaW4gL3hmc3Rl
c3Quc2NyYXRjaC9yZWZfZGlyOiB5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5
eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5
eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5
eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5
eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXkNCj4gICAgICtP
bmx5IGluIC94ZnN0ZXN0LnNjcmF0Y2gvZWRpcjogeXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5
eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5
eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5
eXl577+977+977+977+9U2Tvv71T77+9Ze+/ve+/vVvvv71A77+977+977+9Nyzvv73vv70NCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBb77+9Z++/ve+/vQ0KPiAgICAgK09u
bHkgaW4gL3hmc3Rlc3Quc2NyYXRjaC9lZGlyOiA3MGg2Um53cEVnMVBNdEpwOXlRLDJnDQo+ICAg
ICArT25seSBpbiAveGZzdGVzdC5zY3JhdGNoL2VkaXI6IEhIQk9JbVE3Y2Rtc1pLTmhjNXlQQ1gr
WEt1MCtkbjRWVmlFUXpkMHEzSWcNCj4gICAgICtPbmx5IGluIC94ZnN0ZXN0LnNjcmF0Y2gvZWRp
cjogSFhZTzNVSzNGcnhxd1NaYU5uUTV6UQ0KPiAgICAgK09ubHkgaW4gL3hmc3Rlc3Quc2NyYXRj
aC9lZGlyOiBQZWNINm9weThLa2tCOGlyOE96MHB3DQo+ICAgICAuLi4NCj4gICAgIChSdW4gJ2Rp
ZmYgLXUgL3Jvb3QveGZzdGVzdHMtZGV2L3Rlc3RzL2dlbmVyaWMvMzk3Lm91dCAvcm9vdC94ZnN0
ZXN0cy1kZXYvcmVzdWx0cy8vZ2VuZXJpYy8zOTcub3V0LmJhZCcgIHRvIHNlZSB0aGUgZW50aXJl
IGRpZmYpDQo+IA0KPiANCj4gDQoNCkRvIHlvdSBtZWFuIHRoYXQgeW91IGFwcGxpZWQgdGhpcyBt
b2RpZmljYXRpb24/DQoNCi0tLQ0KIGZzL2NlcGgvYWRkci5jIHwgMTAgKysrKysrKysrKw0KIDEg
ZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9mcy9jZXBoL2Fk
ZHIuYyBiL2ZzL2NlcGgvYWRkci5jDQppbmRleCA4NTkzNmY2ZDJiZjcuLjVlNmJhOTIyMTlmMyAx
MDA2NDQNCi0tLSBhL2ZzL2NlcGgvYWRkci5jDQorKysgYi9mcy9jZXBoL2FkZHIuYw0KQEAgLTM5
Niw2ICszOTYsMTUgQEAgc3RhdGljIHZvaWQgY2VwaF9uZXRmc19pc3N1ZV9yZWFkKHN0cnVjdA0K
bmV0ZnNfaW9fc3VicmVxdWVzdCAqc3VicmVxKQ0KIAkJc3RydWN0IHBhZ2UgKipwYWdlczsNCiAJ
CXNpemVfdCBwYWdlX29mZjsNCiANCisJCS8qDQorCQkgKiBUaGUgaW9faXRlci5jb3VudCBuZWVk
cyB0byBiZSBjb3JyZWN0ZWQgdG8gYWxpZ25lZCBsZW5ndGguDQorCQkgKiBPdGhlcndpc2UsIGlv
dl9pdGVyX2dldF9wYWdlc19hbGxvYzIoKSBvcGVyYXRlcyB3aXRoDQorCQkgKiB0aGUgaW5pdGlh
bCB1bmFsaWduZWQgbGVuZ3RoIHZhbHVlLiBBcyBhIHJlc3VsdCwNCisJCSAqIGNlcGhfbXNnX2Rh
dGFfY3Vyc29yX2luaXQoKSB0cmlnZ2VycyBCVUdfT04oKSBpbiB0aGUgY2FzZQ0KKwkJICogaWYg
bXNnLT5zcGFyc2VfcmVhZF90b3RhbCA+IG1zZy0+ZGF0YV9sZW5ndGguDQorCQkgKi8NCisJCXN1
YnJlcS0+aW9faXRlci5jb3VudCA9IGxlbjsNCisNCiAJCWVyciA9IGlvdl9pdGVyX2dldF9wYWdl
c19hbGxvYzIoJnN1YnJlcS0+aW9faXRlciwgJnBhZ2VzLCBsZW4sDQomcGFnZV9vZmYpOw0KIAkJ
aWYgKGVyciA8IDApIHsNCiAJCQlkb3V0YyhjbCwgIiVsbHguJWxseCBmYWlsZWQgdG8gYWxsb2Nh
dGUgcGFnZXMsICVkXG4iLA0KQEAgLTQwNSw2ICs0MTQsNyBAQCBzdGF0aWMgdm9pZCBjZXBoX25l
dGZzX2lzc3VlX3JlYWQoc3RydWN0IG5ldGZzX2lvX3N1YnJlcXVlc3QNCipzdWJyZXEpDQogDQog
CQkvKiBzaG91bGQgYWx3YXlzIGdpdmUgdXMgYSBwYWdlLWFsaWduZWQgcmVhZCAqLw0KIAkJV0FS
Tl9PTl9PTkNFKHBhZ2Vfb2ZmKTsNCisNCiAJCWxlbiA9IGVycjsNCiAJCWVyciA9IDA7DQogDQot
LSANCjIuNDcuMQ0KDQo=

