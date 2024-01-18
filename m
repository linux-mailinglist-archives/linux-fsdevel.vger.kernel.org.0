Return-Path: <linux-fsdevel+bounces-8236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B8D831638
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 10:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6901F24D4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 09:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A461F95A;
	Thu, 18 Jan 2024 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="VEp2qWS1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9448A1F939
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 09:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705571624; cv=fail; b=NJGthe8PivDYrLIho0gR13UOz8xBSCAkCHKLKl7f/J1rwV7qswtNeqXPV3KRnb+j5D/C/m+3McCtrbpGyo/gLq6uHKg70mUgECd/uUQRLeLPfR6g7pr+R09cw2qHpiTkab3o+Pa5bjt9ZnSM6S0fCABl9KPXXknC57uke8QrKuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705571624; c=relaxed/simple;
	bh=LGLLy6bcuNVFLLvfBcRHowJQU4pwuM7Mz/hpW/uoLM4=;
	h=Received:DKIM-Signature:Received:ARC-Message-Signature:
	 ARC-Authentication-Results:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:Content-Type:
	 X-Proofpoint-UnRewURL:MIME-Version:X-Sony-Outbound-GUID:
	 X-Proofpoint-Virus-Version; b=SrfM1NqxgR4xRO5TKhD+pwdNXN1SPrwmea20ZFRzhQrSCUXhrWiprgeXuMiXBbetsUryQFfNJPB8eIZTZI7AaKO4lXpGjuNLJPNnQiCpsr7r56LwSWDb3MPNy6L8TcBiE+eNNPlnXJNJ/Yrr+5Km6a15Nqa2scWPMRZuRfDdK0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=VEp2qWS1; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209328.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40I3sAjE025089;
	Thu, 18 Jan 2024 09:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=S1;
 bh=uLbdr9omxUp+QM+F7frPgl/MEITen9oYQseC2g/kyGw=;
 b=VEp2qWS1YvgD1ZLMhAhoFUZ7E4VA+zHakNRsUojBwHFtAB1R8OAAGTGrCCWDpGVw64yH
 TTuC4Yr3m43iZIWGMQXrArMqDufCFFMmjgk2KdAYhvtqekCEnLwSdKcesnARCSgLPkMt
 JvwDr0ZkuRZvOioza+n4sq24js3w2GdKnPhY0a/UAP3UnUBz+IAdDF9AaIlDMRAMf9db
 a0CS7ZpbEt20SMhLLBRbnY6D6o8x6uV/rCDS1zAUYzfsLj1UAM3wN8LuQK2vwmi2kxD0
 F5X/hIm8yUEorw+ImHQOErbhak06p2EMDh0xxpfObjxf6q3g6X5RkwGYNSRmi12ddntW qA== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2041.outbound.protection.outlook.com [104.47.26.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3vkkpn55we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jan 2024 09:43:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBmWlVuA2Nlpsitr7yq6C6EHczd8uPsHxsFlbwd/eiZhhfasKaBVOgoEbBorAQ6ospmvIsR0fcRAgcXdfWaN21Yk95IZvhuIhEg/oDj/BwIdZ4exT4N5dJEvxgU4W6RIiv9PGT9gWrDAWK3v+eOGtVWi8DDv9Z2QPT940+WALLyAR6b0dqgtQkqVjaa8WIs5iS8o1bJpdRQL5WRPy01FsZUqNHstOzEs0kRhzYSYF8t6YqxDnrF51DqcF1lzjM4m2QBfldQU9t8OcMoCNTviem5xRw62PDvjzpH54t3xTitTUzJg4m6I1BMYZIClAz8leFZLd8ybSIK2PsEK8b3DeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLbdr9omxUp+QM+F7frPgl/MEITen9oYQseC2g/kyGw=;
 b=JAeeXhbSBiVhn/+si62v3fTMFEWa9SD+Z+PgtjFYq5+zCiv0XH9C6LoZOxfJOQh9z0EzkuUm/qaEJeYXxM8kZ1eShOKZVFpvi+T7lzm9B5F+ypeu5EyifGddm2/psbCYCi2EWqz0U4EftZpDOTvZxC9NXWq93sFQtGfZE5LCuAl322GgtiL+jgKajD98m5xomtb3vTT0qE+kK6oqE5zES4V/1s8a23lJeBQgmTW9cfvUoBCF+mWPa+MBZktGtqKXUVtIeZ3+Kk7WI9hoOSzwEX3oHbRTmi/pmsbUYK55bUKmcT6FwNfpOMp6Irx434aeqBcgwUWm6T7ef7NJCkFaNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEYPR04MB6773.apcprd04.prod.outlook.com (2603:1096:101:da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 09:43:23 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::f0fc:7116:6105:88b2]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::f0fc:7116:6105:88b2%6]) with mapi id 15.20.7181.026; Thu, 18 Jan 2024
 09:43:23 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v1] exfat: fix zero the unwritten part for dio read
Thread-Topic: [PATCH v1] exfat: fix zero the unwritten part for dio read
Thread-Index: AdpJsQv8T4Ivuy8bSKO3lgONYXaYZAAP/Anw
Date: Thu, 18 Jan 2024 09:43:22 +0000
Message-ID: 
 <PUZPR04MB631609520C4F2CE212A9A5F781712@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEYPR04MB6773:EE_
x-ms-office365-filtering-correlation-id: 26d98409-2c85-4cc2-b466-08dc1809e96d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 M8bx0hox2vtew7+OcsUB0uRO0fkEN8EGpRGZxOEqqDVZPBLSqi+froEm6k0kvXLPXdq4GJnJdYH4EqTDNFMQ6uE9cQPPbFOYJ5f2lUkwNYLw+imL6DYqBesGLjE43UkSxp32VmvSnHhhOagHpvkv+CtZEvEaZVQoeEvCCWhdZTkuWxt2xyzzhXoBhVNEWWyZ08d/mjkcSxFFCVzpYHPIVaPIQJNFs8EqfJ2/zZqkdAOjdw3HBVUpFcAzhIqK3FouK3L+lITGanDcLaEO8DyCiDzppJZXXrVWe+23XQHQHXD1j88F4d1KLeg8mWCBluJPLUCOZErhjRLYtesG9lqraCBzDgUq2ArYeEKsZbSwO4k+pkLFWAzQDNCgoEIPh7fw7R6WQ1mE7aEc2gVHd0uKyP169Yu+uiKsSxvBLurC2OvcHdsY2NFbxkoIwEAu89AIt2frengvAhthLBRhaeiebn9+jHoeF2tCg4k2hj65Pg7BIxpdG88mFI5hzO9xtVpvqeJb5+4db9jNJSiUgTioT/pTcJKqIfj1IPH00W4HzgcTFIQKOXvoww+dnttnDkJ6kd6tQJq+KVqXSU4J8zHs8ViMzTUh1LDBiz8KiIfPl3kmYwx/CcmZyKV19Vm9Gs7A9G6KARFeFlZo0UFRErdmXw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(82960400001)(26005)(86362001)(478600001)(99936003)(9686003)(55016003)(316002)(41300700001)(71200400001)(2906002)(107886003)(6506007)(33656002)(7696005)(966005)(38070700009)(66446008)(66946007)(66476007)(5660300002)(76116006)(54906003)(66556008)(64756008)(83380400001)(110136005)(38100700002)(4326008)(8676002)(8936002)(52536014)(122000001)(99710200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TU5xeWVHaDgreUtybHFPRC9jcFFOdlRYZ2xlazlqcFRjdlFhQVpYQ2hiK3Vi?=
 =?utf-8?B?NjVLWE1MaEwvdzRkU3lmaVBscWJoK2NrdVpTNENnemJBOG81SjRwRXc1VzFI?=
 =?utf-8?B?N2NxL2NoWmhUNlA1UUpWQzNRU0tNZEoxaWxpVTZvcXkvN1poZVEyQXJwWkFz?=
 =?utf-8?B?MGxEMHAyR2NVQzJtdm51eUxESE9QamhrUDlzU0lOM0ZmUTNFdHJRcEJQWUYy?=
 =?utf-8?B?WjYxZ1VYMEUwd1NsMURoWEZydDBVUGw5dDhNLzMrcXdwT0dkL1NkaDBQbDlZ?=
 =?utf-8?B?KzNMSGRnMGNOQmdyQktZRGVnTnpDcFo4dy9nMkd2OU41dkRKaUJrL01YTFMr?=
 =?utf-8?B?ckJrKzJRZVdpSHJ0QVZMSVZ3T0lSRXVDa2JjMHh0ZGtkUDMyV2tJakZ2TjBS?=
 =?utf-8?B?YWN6elFvZXhDZGo3cFlHV0ZLOHdoblZhZ3RIbG5NUSthZC9rVlp4UFYvekFX?=
 =?utf-8?B?MVFoVnhJUG9uajQyUWlvMUpuU2FWRThCbld4SXZ5UENUZjZlb09TQlBENjdl?=
 =?utf-8?B?Qzc0MmF1SFR5WWVxdGVJUnl1K2kvZmdCbk5iSktzU0hKeHZxVkMwU01Ud0sr?=
 =?utf-8?B?TlloM2NEZ1NmVmc1L2lHbFdqNHZrWGRVVENmOGJ3eEZvU3hrVUd0a1o1Slha?=
 =?utf-8?B?Z2YydHRkWGxXeDhKcE1QbVBVdmZTV2Z6T21zcEdDb2ZyelZ6TjZ5bDY2dmJS?=
 =?utf-8?B?d0dUMHVTS3M3OTlhNGRXVE9rWFNxSFoxTlUyWGl4T3JQTTh0NERBY2xIYWlS?=
 =?utf-8?B?WXpYQ1Q4OVo0VjlPem96alBkQ2VEc0ZkTXA4MmNoQ1MxSW1rRC9zZ3FsRVRQ?=
 =?utf-8?B?T2FrdzNqZ0RiR2poWlpvamZ1WkpKemxjWTQ5d1drR1VFS094ZjNvalhNOUdv?=
 =?utf-8?B?dUtyS0pDZGJaSzBLQnArQVdvYUxhQUdnSjh5K2VZVWJNaVo3RUxtc2YydTBn?=
 =?utf-8?B?RFZCR2RjdjYzWWh5QnhRMytRdXA5dkpJakk3U1Z5KzY4Ly91OXNZWVJnMGNu?=
 =?utf-8?B?L2RsazNHVm5tOHNnRmVCclVQTDQrL3NRZFdodWNXMjkvTi9SVXZxK2I5cVVi?=
 =?utf-8?B?Q2RHVHFnakhhTnVRMUNDa0R5dmNXbEpHL0NWUlJjTndyc1ZQWU1uaDI3SzdL?=
 =?utf-8?B?amY1SFVPTjRJL1ltYmN2Y2dYSlFZK3MrQ2Foc3I5ak80MUpRdGkzMlFTMjB5?=
 =?utf-8?B?QlBZMjdzNkpuRDNTU212YURiQ0NqVDBwV0UxTThzdjF3dWJ5dWdBRTNseUlO?=
 =?utf-8?B?NjgrK3ZXRU1nQnpXY3BEeGd2U1prZXdLR1lqLzlreUk3T3ZJYTFqQkdOalVw?=
 =?utf-8?B?L2VQOUxlKy9wSE1FelBQMFpLcytOaFVhYUZJTkgwUmhuNzBoeVRwRUVUUWxn?=
 =?utf-8?B?U3psQnV3ZXR6dWtNVVltU3cxc2xDZzZzcGdvT2V0K3RYRmdUOGIrRy9RQnZw?=
 =?utf-8?B?RDNNOEQ3d0ZacHM3VDB2c3cxY1RoUmFZeEhtbG43NFpkWEMvVm82TlhLQnhB?=
 =?utf-8?B?NUwrWnVwTk9PNkNHUERlb2I1MCt4WUdHQS9hYkNRcDFOSnBNNnl5bElUc2Zv?=
 =?utf-8?B?OHRFS3hDM0N2bnlqem1ZWEJ6L29TTXZXamtuN25Nd3JJRnFLNFhYcjZmT3c4?=
 =?utf-8?B?SWRWeFhPZGlBTFV2MjNaU3BHRll0eGxrdWdvbGZhZ1ErWkh0ZEpXQ3FHSXlC?=
 =?utf-8?B?N2EzTVFmZFhQeERaV25wTU4xTzhZTUpnTXYrK1RETkZybkY5MzhxM0R2YVZH?=
 =?utf-8?B?S1NPSW9RR2toMm1PNU5FRGwwYk91U2JyM2l5Nzgwb1Q2eGxSWFQ3Y3J5am1V?=
 =?utf-8?B?ZUlkcnhmQWtBMmsxcnMwMzYvcEtTTDRyeVR2Tzg3TnF1TWxxMEYxSUhHUVhT?=
 =?utf-8?B?VVJybmMrLzRmUDE2Ti9CeGs5VmY1UFNid3UwYy9RUW0xZ1NNRVl5N1pLc2tS?=
 =?utf-8?B?dDdCd2tCbFY2MS9GTWtJaGVabTNjVEsyV2JwSk1sV3lheENQL0hKai9zUDBm?=
 =?utf-8?B?Q05EN1FTY0NFRitxUi9Ud3hWSy9KTzJneEsvWjltNzNNaWppdkRQc1RYVHYx?=
 =?utf-8?B?QlU0emdwVCt6MWFyUDFkZWFBUzRYSW9ndkV0azZkbHlkd0VPQXdHakY5R0NY?=
 =?utf-8?Q?5Su7WIJdNhelTn0EmwROGhj0l?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZfBvkt4vRhYtU8DBxCE28wwQmB5/L1Cycg8eu0DkLmpyoVRv+5gfJnFTSkw5WbF/xVg9E3uIQqiAGv84MbaiH8yHk9SM0wQ/aFZvWvxJUTOOQ3B0mBMI9rWpnuG18B5m5k5zufOxnKMJpqISlw8Bhme1ZHH94GkLxjcLsF8JzvGX4xvt46Dy8mNdPIU14UBnAfxe/3yT0qD/RtFaRncqEPru/DARLGjpf1/CdftUsdrRM+bZMF3E59eyWzNY61wYRqeNKmgJzZTqP5eg6q+GOId+rAnHufEQYhIWwLbrpwz2Fb12DE7qYPEidf/w2J1tl9dF6qnLyE2m6gnc61oiHVAqKlEgRN2KcNYh7BQZLldm7W3ePFGD9mRCgoROr0TA5l2UR9K/dRK9+UlQ9eU/Mp5wQQWL/DrTWhDoWbTV3PC9iaGW3EYOml8lVfJdvJwk44szvjNzKO8oyGvvpk3OFhu2a0ZWFTmx1t2nTN77ypyzB49+qt3tCG0l4uttW/XIWkdbCwdzJ9WdHYTD4ta2e03+p7cjVonW4T58xkV9/+B0ahtIOCWKBYEkyJ2UaaL3ABLHWyH/9ZzrQJMn1FefxJAIRKbmsXc7SSkZpnUfDoOZ9sZzhOpLLLhNtsPo93uy
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d98409-2c85-4cc2-b466-08dc1809e96d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 09:43:22.9577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fwhN79IUzQat0eR/GZUjWhGcfVye7HqLpEuFadZkBe3zmFShM3xganUOyuxFllDiJjVMNuEV3wzlqcXg0uEzoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB6773
X-Proofpoint-ORIG-GUID: 7Zcp8Ybo7wh7r1wJhHmhwyeygGsWaOJA
X-Proofpoint-GUID: 7Zcp8Ybo7wh7r1wJhHmhwyeygGsWaOJA
Content-Type: multipart/mixed;	boundary="_002_PUZPR04MB631609520C4F2CE212A9A5F781712PUZPR04MB6316apcp_"
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Sony-Outbound-GUID: 7Zcp8Ybo7wh7r1wJhHmhwyeygGsWaOJA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_04,2024-01-17_01,2023-05-22_02

--_002_PUZPR04MB631609520C4F2CE212A9A5F781712PUZPR04MB6316apcp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

Rm9yIGRpbyByZWFkLCBiaW8gd2lsbCBiZSBsZWF2ZSBpbiBmbGlnaHQgd2hlbiBhIHN1Y2Nlc3Nm
dWwgcGFydGlhbA0KYWlvIHJlYWQgaGF2ZSBiZWVuIHNldHVwLCBibG9ja2Rldl9kaXJlY3RfSU8o
KSB3aWxsIHJldHVybg0KLUVJT0NCUVVFVUVELiBJbiB0aGUgY2FzZSwgaXRlci0+aW92X29mZnNl
dCB3aWxsIGJlIG5vdCBhZHZhbmNlZCwNCnRoZSBvb3BzIHJlcG9ydGVkIGJ5IHN5emJvdCB3aWxs
IG9jY3VyIGlmIHJldmVydCBpdGVyLT5pb3Zfb2Zmc2V0DQp3aXRoIGlvdl9pdGVyX3JldmVydCgp
LiBUaGUgdW53cml0dGVuIHBhcnQgaGFkIGJlZW4gemVyb2VkIGJ5IGFpbw0KcmVhZCwgc28gdGhl
cmUgaXMgbm8gbmVlZCB0byB6ZXJvIGl0IGluIGRpbyByZWFkLg0KDQpSZXBvcnRlZC1ieTogc3l6
Ym90K2ZkNDA0ZjZiMDNhNThlOGJjNDAzQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20NCkNsb3Nl
czogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPWZkNDA0ZjZiMDNhNThl
OGJjNDAzDQpGaXhlczogMTFhMzQ3ZmI2Y2VmICgiZXhmYXQ6IGNoYW5nZSB0byBnZXQgZmlsZSBz
aXplIGZyb20gRGF0YUxlbmd0aCIpDQpTaWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhh
bmcuTW9Ac29ueS5jb20+DQotLS0NCiBmcy9leGZhdC9pbm9kZS5jIHwgNyArKystLS0tDQogMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdp
dCBhL2ZzL2V4ZmF0L2lub2RlLmMgYi9mcy9leGZhdC9pbm9kZS5jDQppbmRleCA1MjJlZGNiYjJj
ZTQuLjA2ODdmOTUyOTU2YyAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2lub2RlLmMNCisrKyBiL2Zz
L2V4ZmF0L2lub2RlLmMNCkBAIC01MDEsNyArNTAxLDcgQEAgc3RhdGljIHNzaXplX3QgZXhmYXRf
ZGlyZWN0X0lPKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICppdGVyKQ0KIAlz
dHJ1Y3QgaW5vZGUgKmlub2RlID0gbWFwcGluZy0+aG9zdDsNCiAJc3RydWN0IGV4ZmF0X2lub2Rl
X2luZm8gKmVpID0gRVhGQVRfSShpbm9kZSk7DQogCWxvZmZfdCBwb3MgPSBpb2NiLT5raV9wb3M7
DQotCWxvZmZfdCBzaXplID0gaW9jYi0+a2lfcG9zICsgaW92X2l0ZXJfY291bnQoaXRlcik7DQor
CWxvZmZfdCBzaXplID0gcG9zICsgaW92X2l0ZXJfY291bnQoaXRlcik7DQogCWludCBydyA9IGlv
dl9pdGVyX3J3KGl0ZXIpOw0KIAlzc2l6ZV90IHJldDsNCiANCkBAIC01MjUsMTEgKzUyNSwxMCBA
QCBzdGF0aWMgc3NpemVfdCBleGZhdF9kaXJlY3RfSU8oc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1
Y3QgaW92X2l0ZXIgKml0ZXIpDQogCSAqLw0KIAlyZXQgPSBibG9ja2Rldl9kaXJlY3RfSU8oaW9j
YiwgaW5vZGUsIGl0ZXIsIGV4ZmF0X2dldF9ibG9jayk7DQogCWlmIChyZXQgPCAwKSB7DQotCQlp
ZiAocncgPT0gV1JJVEUpDQorCQlpZiAocncgPT0gV1JJVEUgJiYgcmV0ICE9IC1FSU9DQlFVRVVF
RCkNCiAJCQlleGZhdF93cml0ZV9mYWlsZWQobWFwcGluZywgc2l6ZSk7DQogDQotCQlpZiAocmV0
ICE9IC1FSU9DQlFVRVVFRCkNCi0JCQlyZXR1cm4gcmV0Ow0KKwkJcmV0dXJuIHJldDsNCiAJfSBl
bHNlDQogCQlzaXplID0gcG9zICsgcmV0Ow0KIA0KLS0gDQoyLjI1LjENCg0K

--_002_PUZPR04MB631609520C4F2CE212A9A5F781712PUZPR04MB6316apcp_
Content-Type: application/octet-stream;
	name="v1-0001-exfat-fix-zero-the-unwritten-part-for-dio-read.patch"
Content-Description: 
 v1-0001-exfat-fix-zero-the-unwritten-part-for-dio-read.patch
Content-Disposition: attachment;
	filename="v1-0001-exfat-fix-zero-the-unwritten-part-for-dio-read.patch";
	size=1815; creation-date="Thu, 18 Jan 2024 05:05:08 GMT";
	modification-date="Thu, 18 Jan 2024 09:43:22 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkNjYwMjMyN2ExYmE0NjYwNDJlODFmZWU0M2M3OTQ3YmZkMzFhNGQ2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+CkRh
dGU6IFRodSwgMTggSmFuIDIwMjQgMDk6NTI6NTIgKzA4MDAKU3ViamVjdDogW1BBVENIIHYxXSBl
eGZhdDogZml4IHplcm8gdGhlIHVud3JpdHRlbiBwYXJ0IGZvciBkaW8gcmVhZAoKRm9yIGRpbyBy
ZWFkLCBiaW8gd2lsbCBiZSBsZWF2ZSBpbiBmbGlnaHQgd2hlbiBhIHN1Y2Nlc3NmdWwgcGFydGlh
bAphaW8gcmVhZCBoYXZlIGJlZW4gc2V0dXAsIGJsb2NrZGV2X2RpcmVjdF9JTygpIHdpbGwgcmV0
dXJuCi1FSU9DQlFVRVVFRC4gSW4gdGhlIGNhc2UsIGl0ZXItPmlvdl9vZmZzZXQgd2lsbCBiZSBu
b3QgYWR2YW5jZWQsCnRoZSBvb3BzIHJlcG9ydGVkIGJ5IHN5emJvdCB3aWxsIG9jY3VyIGlmIHJl
dmVydCBpdGVyLT5pb3Zfb2Zmc2V0CndpdGggaW92X2l0ZXJfcmV2ZXJ0KCkuIFRoZSB1bndyaXR0
ZW4gcGFydCBoYWQgYmVlbiB6ZXJvZWQgYnkgYWlvCnJlYWQsIHNvIHRoZXJlIGlzIG5vIG5lZWQg
dG8gemVybyBpdCBpbiBkaW8gcmVhZC4KClJlcG9ydGVkLWJ5OiBzeXpib3QrZmQ0MDRmNmIwM2E1
OGU4YmM0MDNAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQpDbG9zZXM6IGh0dHBzOi8vc3l6a2Fs
bGVyLmFwcHNwb3QuY29tL2J1Zz9leHRpZD1mZDQwNGY2YjAzYTU4ZThiYzQwMwpGaXhlczogMTFh
MzQ3ZmI2Y2VmICgiZXhmYXQ6IGNoYW5nZSB0byBnZXQgZmlsZSBzaXplIGZyb20gRGF0YUxlbmd0
aCIpClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4KLS0t
CiBmcy9leGZhdC9pbm9kZS5jIHwgNyArKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2lub2RlLmMgYi9m
cy9leGZhdC9pbm9kZS5jCmluZGV4IDUyMmVkY2JiMmNlNC4uMDY4N2Y5NTI5NTZjIDEwMDY0NAot
LS0gYS9mcy9leGZhdC9pbm9kZS5jCisrKyBiL2ZzL2V4ZmF0L2lub2RlLmMKQEAgLTUwMSw3ICs1
MDEsNyBAQCBzdGF0aWMgc3NpemVfdCBleGZhdF9kaXJlY3RfSU8oc3RydWN0IGtpb2NiICppb2Ni
LCBzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIpCiAJc3RydWN0IGlub2RlICppbm9kZSA9IG1hcHBpbmct
Pmhvc3Q7CiAJc3RydWN0IGV4ZmF0X2lub2RlX2luZm8gKmVpID0gRVhGQVRfSShpbm9kZSk7CiAJ
bG9mZl90IHBvcyA9IGlvY2ItPmtpX3BvczsKLQlsb2ZmX3Qgc2l6ZSA9IGlvY2ItPmtpX3BvcyAr
IGlvdl9pdGVyX2NvdW50KGl0ZXIpOworCWxvZmZfdCBzaXplID0gcG9zICsgaW92X2l0ZXJfY291
bnQoaXRlcik7CiAJaW50IHJ3ID0gaW92X2l0ZXJfcncoaXRlcik7CiAJc3NpemVfdCByZXQ7CiAK
QEAgLTUyNSwxMSArNTI1LDEwIEBAIHN0YXRpYyBzc2l6ZV90IGV4ZmF0X2RpcmVjdF9JTyhzdHJ1
Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRlciAqaXRlcikKIAkgKi8KIAlyZXQgPSBibG9j
a2Rldl9kaXJlY3RfSU8oaW9jYiwgaW5vZGUsIGl0ZXIsIGV4ZmF0X2dldF9ibG9jayk7CiAJaWYg
KHJldCA8IDApIHsKLQkJaWYgKHJ3ID09IFdSSVRFKQorCQlpZiAocncgPT0gV1JJVEUgJiYgcmV0
ICE9IC1FSU9DQlFVRVVFRCkKIAkJCWV4ZmF0X3dyaXRlX2ZhaWxlZChtYXBwaW5nLCBzaXplKTsK
IAotCQlpZiAocmV0ICE9IC1FSU9DQlFVRVVFRCkKLQkJCXJldHVybiByZXQ7CisJCXJldHVybiBy
ZXQ7CiAJfSBlbHNlCiAJCXNpemUgPSBwb3MgKyByZXQ7CiAKLS0gCjIuMjUuMQoK

--_002_PUZPR04MB631609520C4F2CE212A9A5F781712PUZPR04MB6316apcp_--

