Return-Path: <linux-fsdevel+bounces-55962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A2BB110EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 20:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598661891DB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 18:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F502B9B9;
	Thu, 24 Jul 2025 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PmZ7Sc8N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E2F148830;
	Thu, 24 Jul 2025 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381851; cv=fail; b=SRycHnFQwCzZWCkBDWpWCqxopKl2NaLCXV+f6WuYKitGxVGNK7yp7edsp+9hMbaypPET6Gv5KI3mMaJE4sZz7XqaprdVYk+aaJdIvIGnliizYi8LKTp/rY7qBRD9MVTVHL0lPV6Wl0f9LLYJVcMp/jeUZbdzDbciX41FK/f9I3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381851; c=relaxed/simple;
	bh=2srfd3OGy6GfKP2+63ie1QcMkPBaMzqTwu4i0OCTSJE=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=U7sICxBbabT6rAefaErgxYjI5GJmM1dK8DXa7BkNEtLsrtaQLjNOcKswxjKqrEFlgLOUT6ZH1edm3FbRDHXKQ32+N8QDBze5MIJlIMTMLonj3XerfAmkVJoFqHAOk4xJI4P+pngON1ngkMGKwEhB4OvMUnGD0GGjRo4qxddEmVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PmZ7Sc8N; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OG2pMY029090;
	Thu, 24 Jul 2025 18:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=2srfd3OGy6GfKP2+63ie1QcMkPBaMzqTwu4i0OCTSJE=; b=PmZ7Sc8N
	Q7ju47Fiirv2no3mkkGaY5l6VL+rxwdzJsYdIMCNbZd/WZEPMN2NQLgWVJhPF0if
	KwMVnoURI5PaG/AKlVsOQ6rLXkMMVmyt01Jx8M+e5/e5W2GByHqdYsJKQjESs/qO
	hlXjHQ0fZIrgwexcYdm+Lxn8YV47cNQVJE8F/Ezw/rTpLvMlfrD0ss9CR9WPbx0I
	4WJQw7tYMVs8AvXeutlHiOT4YZyLOzku/EMCBl+n78cdHAYM4PL6y2JsVvOzSFSU
	2t9Y4u4DGS/Z6sL3g17SfUDINw31+sOjaTBb+NUfT+YHGPeONEUsCCYOrtazLBLa
	SOYWQHwthSJfdg==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482kdyujce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 18:30:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVD9LCfxvEFk1KN6Ihsl/jJYSuYhXJIUjUguUq4j5I1G4oLCJO56R6SJDNBUxVrKTMvDiXbxTa7ZuH5LP25XLFs4ktE7rRhoqTjsabGLAbW4O3gZ5yKpqHImyKQImtzpXh4Pd60stuUvNZ9QeA+o4ci2ZPTDmlwxEXAyZJn50zqjFjRkAXXL2yo/cqlvjxheV2fhBguC607MRERld+yjA+JJ+8yKFeFcztJ7faJxlRVGJt71uQVkj8DUuIr5cgRW0zUdlbQS+xmffB/eV368dVflS6K4T6roM5KTs/iwoI+MoZokY80iJcsufezG+BvCUDzZzxrDWoCgQ9Af/wLQ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2srfd3OGy6GfKP2+63ie1QcMkPBaMzqTwu4i0OCTSJE=;
 b=NOzEPMcql42PM1CkAKwz5V6jU7G/ZybhUmXDlX21nXecIuy9haLIRxsxKbBjX6R8bcC8Gmne5nnfLai5Y9J4py0yDdyy4ZvrBTib4TCNj306SxCWYHW61boFd3raNgBbecLW/qwT+Vrr7wEHu+aeIL+NZpeqR7WfBx5jeyYnM26h/J2atE6kRv6oS9tVoQe0BL3gnVf1PbrgXtaBQ8YQc/pUV7Z08hZ9KaM1f8iNpWob6DUFQLOs91O7SHxITL6QOhIrjNVZZWofMQPLffpCgCmn2Wuf/ef4DNlKFO6HVV9tobMYreBa37fxtMNv7AbvBHElK7OvsAAkzeNzwdIT9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com (2603:10b6:a03:4e4::8)
 by DM6PR15MB3862.namprd15.prod.outlook.com (2603:10b6:5:2bf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 18:30:35 +0000
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::266c:f4fd:cac5:f611]) by SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::266c:f4fd:cac5:f611%4]) with mapi id 15.20.8880.030; Thu, 24 Jul 2025
 18:30:35 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v4 1/3] hfsplus: fix to update ctime after
 rename
Thread-Index: AQHb+3oV9Rb3lJ0HqkigH70nQmJRlLQ//7SAgAA54oCAAWGKgA==
Date: Thu, 24 Jul 2025 18:30:34 +0000
Message-ID: <8028d6c8b484c1867aa0e9f668b658b1cb7e9521.camel@ibm.com>
References: <20250722071347.1076367-1-frank.li@vivo.com>
	 <20250723023233.GL2580412@ZenIV>
	 <cce1a29f2f55baf679c3fe83269d9bceb3c4fd6c.camel@ibm.com>
	 <20250723212511.GQ2580412@ZenIV>
In-Reply-To: <20250723212511.GQ2580412@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB5821:EE_|DM6PR15MB3862:EE_
x-ms-office365-filtering-correlation-id: b130af86-f2e5-4ad8-e804-08ddcae02e24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T2UzMGtrTHVKSlcvaGdmSTVCUUx1Y2IxSUFtdWtqQ2Mxalk5cnVoQXVGUDJr?=
 =?utf-8?B?QS84dEYrRmxiQzBGZFl2Ukhzb0JMMzhiNVByUzJOS25yRVNpbnU2VkZVUEIr?=
 =?utf-8?B?b3pnWHQ3ZGcraGFNOFlpRWt6bjV3NFBnd2dJMHB1REQyM0dNeTBEczBKNmtp?=
 =?utf-8?B?UDRJcFN0ekRTb1E1cld5QmpKTjF3SFU0MDNqOVhjS1ExTlFKdWJRRzBTN1lV?=
 =?utf-8?B?Y3JDYkcrSHV4NHk4cC84amx1VHc4TmNDZTJ3WjFkSWFSYUdkb2JJK2xic0Zi?=
 =?utf-8?B?UjR2V1NGSStVR0tSK1lkQnFPV3JpUUJtNWxKdjhoOUJORlUyR2RiQXhDNXFz?=
 =?utf-8?B?MDhlSHNyUmx6U0FJVWJaaGFNZkVJTFJTU0RDdHljM1RrWGpLd3ZRWHoyS2hF?=
 =?utf-8?B?TkkyTzAwQmRUQmtoK3RMMWNoYmdsaGgxcU82QXNPYUd1eS90enFIK0ZVQngw?=
 =?utf-8?B?UXU5Q1VYTG5MMUlSMXJjM2Jxa2tBL0FXdW5zdlEyeEFRcmcvbjBINk92K295?=
 =?utf-8?B?emNJWUlEUlRnVEx6MWZHcG1ibnZndFlRS1hxU1ZJRUViM1NOWWZTY1JKbXZO?=
 =?utf-8?B?RFFpYUJqMGZDUS9PUDFYcDUyNmdqUUo1V1RxYnIrakxoOStISGJlWjBPTVQ2?=
 =?utf-8?B?UWpVSGNmdVRuUTN4MHhnbDdmZ28vbDVzdU9QNDBHQWY2UXB0VVpqWjNRNjNm?=
 =?utf-8?B?NWRqR0laL2VFZ0VYdm9xSHovK3dqeEFFeVJWUUxBdXM0UHRLOERrcjVJU3cv?=
 =?utf-8?B?WWZGK1kzZXYycm9FV3Q2aFM5TmkvZHAyTWFhZHdla3B1VGw4ZHJ0MzhJRHVa?=
 =?utf-8?B?Wmluemk4dkdIMVB2elBoVXA5Mmlxc2lZNlJGVkgwdHNNY0xXc3N2ZkJteDhX?=
 =?utf-8?B?VWYzTXlna1NYM05rTkJqWldGOVV4dVhqSW9neGRDUlI2eXVuOTR5bml2ZUZR?=
 =?utf-8?B?UWdKVXg1V0RUZ2dRekx4NEREcDVhRlYxQUpKY3lUcEppSGQ5OTdMTmNKWGpm?=
 =?utf-8?B?RDJGMzRCdExGVmNNZUk3RGhUdUtpaFB5eGtielZXSHpkdHZHOXBYdUwvYWUy?=
 =?utf-8?B?cVQvZUpqbmlyUkdsemJjVUhyWlRCclI0clRFdmhDNHpJZ2hnRG5wcWhOVDNN?=
 =?utf-8?B?T0VYNnBYTVRSUGliN0lvSlpQUHFWUlJpWEh2elM3TUhGMWhyNVdQdFNZOFRL?=
 =?utf-8?B?Yy9lZFZQL210SVA2dCtXeEJoRWkxS1hOWHNkQTN0TW44YzBJdkp1Z09XeUFV?=
 =?utf-8?B?ajlQZ3lZTnp3YzZURkVVKzF4WHllMzNvbW9IS3VrbEQ3THpYQkphNlhXVTZH?=
 =?utf-8?B?VEoxK2pTVXJKNVYyR0pROW1OQXVMQUNQb2FuMi91UHlDMFp2NGtSTjkwd29y?=
 =?utf-8?B?OXpEOUh0dzVSc2k0WHdEUXJTcDRHNHIzY0JDSDR1cWJQaHh6Q2tQNmtqbW4y?=
 =?utf-8?B?bXBMUGNzd05INmVlSThUWE9qbEFxNnFpSURwQXVHT2lzOUViYjBGb2trMVd5?=
 =?utf-8?B?UUdqZjcwM050S0tNK3ppODVvTngrN1ZYalBvMWl0T1JXazBvZmkvTEFwT3kr?=
 =?utf-8?B?dm5Wd3JNcFVmOU5rZS9iM01uRDlEZHYxdm0vVXg1SVdDbHQyZ3VNNVRIaVk1?=
 =?utf-8?B?SnlxckpKYXFKdlRTNmV4bm1kWm9XMDhOUkh6OHYydHJzUGZpTVZoRmdiM2VN?=
 =?utf-8?B?eEpZUmRBWnhHVHA5L2tlQTVqL1lxcDUxSmR5WW9yUXdkSnRVWHRQcmN5YmRh?=
 =?utf-8?B?L01obmxrSnFVU1FXT05SMXJwWE83THFucEJrMzYwR0t2MWxQUERSU0xvNUgx?=
 =?utf-8?B?NHkxYXNvZSszVjNET0lCcHIzMHpaeXBVZlJTUitWZzBSNHVYVDE1L3Ftak9k?=
 =?utf-8?B?ZFk2QXlzVWw5UzBZKzA4Rlc2VzlUaWNERXd5d09rVEEzc0RZamEzaGFkMHp6?=
 =?utf-8?B?cmlGSnkwU0hFQW1yWkxuUEsyTWdXOTN4VXprc3NTZEdIQXBEMnNHRTh3TEwz?=
 =?utf-8?B?OTN6ak5ZNktRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5821.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2h5L09rWFZhM0ZBU0dPZmsrN2I0c1Eyb0Y4OHN1a1k5Smc1R0pIcFVuUlVs?=
 =?utf-8?B?SzZLMEFFTDRHbkhVM2d5SWprcWp5VjJaWC9tazV3VFB4VzFKMkVSTzNGU1l0?=
 =?utf-8?B?VFg2YTduczZhbDBsZUU4eFpYWDdkSTVwTTZDbkR3RzU4ZUpqYjVyL0dNN0Nq?=
 =?utf-8?B?dkRrSGNWZitzNnEya2RnZHZTa2hvTUpONjgweklNU3B6alljSG9PaE5CRzln?=
 =?utf-8?B?V0NZMVN1UTB3NmlWOVR3TEUyeldiMEtVbWRZeUYycFpLV01TWm83ekZ6eVRP?=
 =?utf-8?B?QU5hLzBHeDcwTXl2cktaanFOMGRTSWlGTlZVVHl1ZkdKQUZONG54aE9GVGc4?=
 =?utf-8?B?QUlBNUlTT1hDYzRYN1YwanhWcll3WDJraDlIUWtlZk9BaVhBbUlxSXJ2ckp5?=
 =?utf-8?B?ZXlqa05la3RCRStoanJTZ0tTZ3lxZmxOZzBQZ2paT0c1QkZ0TG1WWXIrNEl5?=
 =?utf-8?B?VUp2bnQ2WEZ6VklEWm1Vd3FhaE5RUForSFFYYWllVC9TR1B2aVRhUXNYU1BS?=
 =?utf-8?B?a2tmdlFQUnZDdzZtMkVvNHhXNkdLZXRxczNNQ2pBRHFhNlpmYUZ5OHgwUVNL?=
 =?utf-8?B?ck52Vi8xaFVRejhibXdOUFpGWWZudDBHcGVMYVk2eE5laDdSUWZjcEg4eVA2?=
 =?utf-8?B?dmdwTjVKaU9pWWxVb1pGYUc4Z09MT3hVN24rcURpd3VTa1BEVHJDeWNuMy81?=
 =?utf-8?B?QUdqeWdidk1wZlBEWURseHc5cjJnbVMzaUhrQXVHN1Bxb1M4Y0dJZEFvNmZ1?=
 =?utf-8?B?RVY3NlBaUE1lNnUyOFN2RWh3bi9xVU9LK1k4cHJtd2dhelQ2ekdkUUtIMDkx?=
 =?utf-8?B?aERYZTFHK3JBU1NOTGpieUNCQmFwUFE5VW9yMWZSdWxWcGxYMStUYWwyekw2?=
 =?utf-8?B?cC9rZEpEbHdYeEFvV0NwQ2ZCYm9xUktCVFVGd2thTlZBMUJxb1lFV2RXWUxz?=
 =?utf-8?B?Sk1UYmJFNEdlT2lMMXkyY1N3UlphdEx0bWR4K0g0S21GUmY5OW96R2NFQmN1?=
 =?utf-8?B?UGpyOWl0YWdnL2VlclNEQmlaMjNEb3N0RmdEakE1U0ZVeUFJVHh4eEkvaDlq?=
 =?utf-8?B?VEdTMXBPaDNCeCtPY2ZXYm1tZDBzWGZUZmtGV2J6UzVlS2ZVWXRaWnNpV0hJ?=
 =?utf-8?B?SlNOWVVJVVlFZlZlVGlmQVI5M2trdHdNOHE4eTNyWHVPVGhVZnBmdngvWld1?=
 =?utf-8?B?dllEU2hsN0JFc0EyV2hvdFlBejczaHAzNDBVWmJWYmk0YnVSUDNmenlycHFN?=
 =?utf-8?B?SmJOMU9aa29PUW4ybnNmczFUd0lGcjc1a1ZxRldKczA1Q3VPZ3lLQUpHRkhp?=
 =?utf-8?B?bTBEeS9oZE9paS9TRWNKYnhyczk5ck5PK09Jakx5Zm1vNkU5bSt2Y1N5SlBj?=
 =?utf-8?B?djgvYzdKb29sMHlaa0N0RlN2T1pMSDdxeUUrb2UrWlpoMDcyZG82dGhabkFz?=
 =?utf-8?B?NzdUUEpMWDgxcm9XNXoxSzg3RmxOcmtpOUIxblZteXZEVUE4cWhXS3orZUJH?=
 =?utf-8?B?dXdZeDJBV2o5Vm5takkxWXRLZjdIRHVxUnd5R0lXTGhPNWw2RjYxU29MSGZI?=
 =?utf-8?B?b1FSNGZnK2RLUjF5Wk5kTFhJb3BGKzhpQjRhdGFWekI1ZjhpZUhXZ2h5Zy8w?=
 =?utf-8?B?LzRncjJ1Y1JtR2VYdDNtMldpcTYvdkpRM3R1MDlTS2gzNjVzZW10ZUg4eUdY?=
 =?utf-8?B?UGtiWEFRVTFoTHpLVXZKaEkzdTZFQ0V4bDBGeldJT2QvS0swWGQ3ejV2bjJj?=
 =?utf-8?B?amlEdktkdzluT2lxVzNrbTB1U09ycjNJSlo5dWlXYWpvNU5yVVZ4R1hpNGJL?=
 =?utf-8?B?KzdaVW1zMWlVWGU0V1RobjlEREJKYVpyUDRBTTl4YjZwM0ZJOTFtcWExeXNs?=
 =?utf-8?B?QUd3OGJNTUNvN3JTV2pzdVdKTVhhRFdHZHQ1ckpBZHBsK29SRXlYWTFOcXl0?=
 =?utf-8?B?VDBjSVpBbFdoSm9aRDFwOGlydm1aaWNwZU85dzAzZmk1SFpWRjhOcC9WTk5v?=
 =?utf-8?B?NUVlRzNaUVVaL2N3OXIwWkJvb1daMFNFdnZNVCtQNTNVdFFsZXU0V0VKRjIz?=
 =?utf-8?B?bHB4cnlxajlBQ2dUQkZpdG5wSk84SG4vZklmdTNpNzhTd3ZzQkp6SmpCcVY0?=
 =?utf-8?B?SWFvcW95RktoZWY5dXdrcC9qalZJalMzazZjY1NvNjI1cmZQN1FYR0d2L3Za?=
 =?utf-8?Q?/W06AS5q0dwfz0hUcjfGWmg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33E82FD9522C484091E25368DC1E647B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5821.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b130af86-f2e5-4ad8-e804-08ddcae02e24
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 18:30:34.5437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /4eq2qlXUnmZ/jDVzZYgO+iIHYAIxea62cGvk1XjwSj6Ax/tAutkPxamQLvcycGEZkXx+ZsIuiGG/jLEu3NSCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3862
X-Proofpoint-ORIG-GUID: I18bLWH9aNnapI2u9rFZo31UZ5vyDv27
X-Authority-Analysis: v=2.4 cv=XP0wSRhE c=1 sm=1 tr=0 ts=68827bcf cx=c_pps
 a=z2JJcCkshELlDGyO4lBz5A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=rMGvzeF5ejyflHS8EwsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: I18bLWH9aNnapI2u9rFZo31UZ5vyDv27
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEzOSBTYWx0ZWRfX4EYiM58OonkV
 mOfJvvk7iDfCDsEnLTTNSOj4Y+Pf0Eo6lkjJpuEfGQCSdVT1rlIMCe+1Xh3TCGHEYKhMgHXiKff
 Y/FXkXQpLoOGBBZmNIpYcPviXrXF7un14Spz7gKUD9sNo2pB3xJ/KDA2DM1B8HQl4QQWwOF2/tB
 bH/4RqNMqXYtM4muO68zMLGTsy12zuI3SfwUrXQapRa/e1119zzbm0qKvSoS1JS/CL5kza4lu7i
 2do1f39gczjBIXuJ9ovARIiKbW6cChwx+hZLxf9/aJan3tPy25tbdd/2X8yUKunZKMLDbsdHQGt
 Vv2Hch2c9Mz2aYmpUh8KjtaeIhHzApyl9z7QHBRUWIGu9IMiJkFE2K0CRFdwvWq52iwL1Pg3o78
 gfKFlQs5a3adRbtFaEfycRRlOnVJagvF5YCrfGN5KRhW+WrBHCIZdL3DIlDW3YuQ4f89Yz2i
Subject: RE: [PATCH v4 1/3] hfsplus: fix to update ctime after rename
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=865 spamscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240139

T24gV2VkLCAyMDI1LTA3LTIzIGF0IDIyOjI1ICswMTAwLCBBbCBWaXJvIHdyb3RlOg0KPiBPbiBX
ZWQsIEp1bCAyMywgMjAyNSBhdCAwNTo1ODowMVBNICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28g
d3JvdGU6DQo+IA0KPiA+IFNvLCB0aGlzIGxpbmUgc2ltcGx5IGNvcGllcyBDTklEIGZyb20gb2xk
X2RlbnRyeS0+ZF9mc2RhdGEgdG8NCj4gPiBuZXdfZGVudHJ5LT5kX2ZzZGF0YSBkdXJpbmcgdGhl
IHJlbmFtZSBvcGVyYXRpb24uIEkgYXNzdW1lIHRoYXQNCj4gPiAtPmZzX2RhdGEgc2hvdWxkIGJl
IHVudG91Y2hlZCBieSBnZW5lcmljIGxvZ2ljIG9mIGRlbnRyaWVzIHByb2Nlc3NpbmcuDQo+IA0K
PiBZZXMsIEkgdW5kZXJzdGFuZCB0aGF0OyB3aGF0IEkgZG8gbm90IHVuZGVyc3RhbmQgaXMgd2h5
LiAgV2h5IHdvdWxkDQo+IHRoZSBDTklEIG9mIHJlbmFtZWQgb2JqZWN0IGJlIHNsYXBwZWQgb24g
ZGVudHJ5IG9mIHJlbW92ZWQgdGFyZ2V0Pw0KPiBJJ20gdHJ5aW5nIHRvIHVuZGVyc3RhbmQgdGhl
IGxvZ2ljcyB3aXRoIGxpbmsoMikgYW5kIHVubGluay1vZi1vcGVuZWQNCj4gaW4gdGhhdCBjb2Rl
Li4uDQo+IA0KPiBJbmNpZGVudGFsbHksIHdoYXQgaGFwcGVucyBpZiB5b3UNCj4gCWZkID0gY3Jl
YXQoImZvbyIsIDA2NjYpOw0KPiAJd3JpdGUoZmQsICJmb28iLCAzKTsNCj4gCWxpbmsoImZvbyIs
ICJiYXIiKTsNCj4gCXVubGluaygiYmFyIik7DQo+IAljbG9zZShmZCk7DQo+IFRoZSBnYW1lcyB3
aXRoIFNfREVBRCBpbiB0aGVyZSBsb29rIG9kZC4uLg0KDQpQcm9iYWJseSwgSSBhbSBtaXNzaW5n
IHNvbWV0aGluZyBpbiB5b3VyIGNvdXJzZSBvZiBsb2dpYy4gOikNCg0KSSBhc3N1bWUgdGhhdCB5
b3UgYXJlIHdvcnJpZWQgYWJvdXQgdGhpcyBwYXJ0Og0KDQoJLyogVW5saW5rIGRlc3RpbmF0aW9u
IGlmIGl0IGFscmVhZHkgZXhpc3RzICovDQoJaWYgKGRfcmVhbGx5X2lzX3Bvc2l0aXZlKG5ld19k
ZW50cnkpKSB7DQoJCWlmIChkX2lzX2RpcihuZXdfZGVudHJ5KSkNCgkJCXJlcyA9IGhmc3BsdXNf
cm1kaXIobmV3X2RpciwgbmV3X2RlbnRyeSk7DQoJCWVsc2UNCgkJCXJlcyA9IGhmc3BsdXNfdW5s
aW5rKG5ld19kaXIsIG5ld19kZW50cnkpOw0KCQlpZiAocmVzKQ0KCQkJcmV0dXJuIHJlczsNCgl9
DQoNCklmIHdlIGhhdmUgY2FsbGVkIGhmc3BsdXNfcm1kaXIoKSBvciBoZnNwbHVzX3VubGluaygp
LCB0aGVuIHRoaXMgYWN0aW9uOg0KDQo+ID4gKwluZXdfZGVudHJ5LT5kX2ZzZGF0YSA9IG9sZF9k
ZW50cnktPmRfZnNkYXRhOw0KDQpkb2Vzbid0IG1ha2Ugc2Vuc2UuIEFtIEkgY29ycmVjdD8NCg0K
QnV0IGlmIHdlIGRpZG4ndCBjYWxsIGhmc3BsdXNfcm1kaXIoKSBvciBoZnNwbHVzX3VubGluaygp
LCB0aGVuIHdlIHN0aWxsIG5lZWQgdG8NCm1ha2UgdGhpcyBhc3NpZ25tZW50LiBEbyBJIGZvbGxv
dyB5b3VyIHBvaW50Pw0KDQpUaGFua3MsDQpTbGF2YS4NCg==

