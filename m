Return-Path: <linux-fsdevel+bounces-41904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A59A38FF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 01:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87633B2003
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 00:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDDEEACD;
	Tue, 18 Feb 2025 00:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ojy5K0v8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB12DAD4B;
	Tue, 18 Feb 2025 00:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739838860; cv=fail; b=k1NdSgCFy6TSp9Qg395C5ADz6FpsEPGkhQnh3oIC/c3jfCbaKVIIlo/tKDmzn/f82QWXBlmHO+s2oCksQPSmNWOiNPxNrBKdhtmAw3BlxU3r7zkUiMe7ow5vGE6L7M3FWkV7LBt7zINQ8Chik/FOBthuDsxyK9PHLQDDw/rpJZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739838860; c=relaxed/simple;
	bh=4O8ia7d4TBYCu3zeYTH0lV6ob2nEXgButc82Tige34c=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=iiuBCwpM9otQStfyrmGy7ZF88Huv0RcOVTG+UAvRtZj3sZc4LxLEMCoy17IRoJinPwwIRGWJ+c0B8KPHb21QSTyY0SnMVeCHzyRh+KFv8L0ayU8uHBpgdp+8DImXd9zWOLZsbbCK3Il4bDVvHzNAMEyLMvlXAvwxq8YNAz1D0oE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ojy5K0v8; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HCP0YS015821;
	Tue, 18 Feb 2025 00:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=4O8ia7d4TBYCu3zeYTH0lV6ob2nEXgButc82Tige34c=; b=ojy5K0v8
	sQaLiKqAfXlZxyQmztc5bsPgrU9Oiq2wTSeGWegAzKfhbJ7NsJifnFw3KzctdAYI
	YHfZJGVLtdajqWzMgfm4sSAns2Oqd5B+o+DwdOpiOLIFHQ8SrLI2qdSrDU0ZGMAQ
	92BZf+IEP2HkWzpdtiRqhq6LdOV34i8ISCwEiny+c9f0yWSOBpn4pgAocoG6yveR
	0yqzeRk+uzYsdjuna92+l0L+P97aj7m1bAt9eOgELLgE12Z+NE6QWcqDdOyk8MTS
	4FVL+uHKapLT7PCN+w3cWBlJS62Twj5GNH/bJ/KcW6IoSZW4J99ulq0wSzSHMef0
	6rcvy83HdAX/rw==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44uu69dv47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 00:34:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbWhMnmM05tdqM06UX7xWnp/mLUaoUKhUu24852lemPaO1LaJPCERwex1nxfW0ShCvRJuJGG02ubW5/iGzgj395w3f9MPGsl/uFe7YMlh43KU2N1deon2ujEoBejV3YGEj4ZLwzHvjydh6+l0UnRPBBS4Q9c9D/DSCfadZBXtLnI7wkZPAQM8F33CI+c9hc4XFz9I7On3ZPb/8uGa8YcSJSjEV4Y32X73zQ0uQCpQ0geqcE/dv3YtN0iCsbAxMl38S3ynrRdbDay/FJ3tvYkuYjKvDH6fZzPEi37TCr6ZRPnTNaoiVbqihlP8yVs+BiS34f2D5kQxjQXEw4TdC4AZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4O8ia7d4TBYCu3zeYTH0lV6ob2nEXgButc82Tige34c=;
 b=TadNorAIE9yzvMYi5FdXQEIxA7Pv7wkHNUhBOMYifnaY0cFQ6XJ1D70a1m32BYTgKVrx20dyu0xCgtMttRyTWnIsMV4clByTIhL5eFRIOjVfQhA5SygqtST8R3H3Sa226xX13Bj1xvTCJyNz6N1s4ihI2kDLvCqQN9x5aL2Co2KqiliZdHPh1D6k/PVqzgtRgpzm9Vaf8Gms50RMD19Ch7erVksoTqppy6gIPRjbYijAyz4zTrjhnsSpzcEs5JMImHIGomDhyO134lzUXDlbbmY0pNK9fa1Z8CoYm54ss2hEy8Tc+YuXHKXkKXJO3eVXa+hiRIxUJ6DN4U0FpagYwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BY1PR15MB5959.namprd15.prod.outlook.com (2603:10b6:a03:52f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 00:34:09 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%4]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 00:34:08 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "willy@infradead.org" <willy@infradead.org>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        David
 Howells <dhowells@redhat.com>
Thread-Topic: [EXTERNAL] [PATCH v3 0/9] Remove accesses to page->index from
 ceph
Thread-Index: AQHbgWzyPa4Uv6CLLU2v3Eumqj4qPLNMNsoA
Date: Tue, 18 Feb 2025 00:34:08 +0000
Message-ID: <05765fbaa9f801e51b7b21e8d7bef6c87c53186a.camel@ibm.com>
References: <20250217185119.430193-1-willy@infradead.org>
In-Reply-To: <20250217185119.430193-1-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BY1PR15MB5959:EE_
x-ms-office365-filtering-correlation-id: cbb01f83-899e-40b4-14e1-08dd4fb3f548
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TU00eTAxVll3UEZZaVhXS0tBaE95KzZDNzYySURiN1NaamxmL2ZzbGdQTFEy?=
 =?utf-8?B?L0dlUEZhKzlCb0NRVHdoQ09nZDhDMzhjYWNwKzZSc0E5YXVRTDlxS2M1WWNq?=
 =?utf-8?B?cGM5c2lZZHp1QmgxTGxlRUpIdzJjQ0d4cGxXNmloM0VtMnd0YnhyN1drZXln?=
 =?utf-8?B?YkE0aEwxbDJVaXBZUW5QMXF6eUppMm01THM1Y3R0dG9BUTh6bkZRRmVxby90?=
 =?utf-8?B?cUdhS3FUYWJXOSttcUxGaWpRbUErU0g2bzUweUVZZ0NMdnFmRTFyTGNJM0dP?=
 =?utf-8?B?UWZrUk53YjFJVUdLZlRXRDFoeXZxZlMzT0R6ZEZBRGxvMTYyNFlyZUVXdWZO?=
 =?utf-8?B?N2g2VG1TdDV4ait5OS9vZGZiUWdCaE9oUzdRTmdzL0FKNExuVlVKR3lmTW1K?=
 =?utf-8?B?NU5pc0Q2M3J2ZUJPQUt1eWxsVHl0dGhvUjIvRW04OGwvcVI5ZjE2dHc3ZzVx?=
 =?utf-8?B?VUMyN0FoQVBwTktLM09aeFZSTDg5VkpCMTJsOXFySkxERk9TYzNLaVQ3aEpE?=
 =?utf-8?B?ZmFvNTVUV2ZYSm01SmpVUGlWOW9SZjFOUEJzaEhtVUxScWJIRnhRSEcwOU9s?=
 =?utf-8?B?UEp0cCtCT0E1bVNXWG1FejdXa3UyL281YnNTaU14bWIva2U2TkRsczlBZFRP?=
 =?utf-8?B?V2lsaUdlelFHcm53SzFQc0tYd2c4Q2gzRkcrcEdSR1JyYURVMGRDb1dodkFY?=
 =?utf-8?B?K1J3MWdWQ3dzNmNMdVRYWXgxZWVVekV4aUZWNHhJemY4MGY4cEVtWkdLMlhF?=
 =?utf-8?B?SnY0ZE5LZkhGbG90dExMMlV1OHJBTW84ZWRPbTVUSzFKL2M3bjU2OHk4Y0No?=
 =?utf-8?B?RGtzZklKT29iSVdjTS94OHVscXRTNHI2RGRydWQ4cTFNZHYraW0zWWpNazQz?=
 =?utf-8?B?OFZCcXZiWGk2b2g5aUdOaXYvakNsUDdzRDVFREYwKzlyZ3A4QkkrQUpIeTNs?=
 =?utf-8?B?Y3VZWFowWllCZGJnUmZjc1hLcnRzblI2MFpQUEw2NEN2cXFGTGJzLzZ1OEoz?=
 =?utf-8?B?d3JJTUJpYTZ2TFBWVzA2dDdqb1ZiRkkya1hxTVd6c1ZIcEl5WWRtaFZTUU9h?=
 =?utf-8?B?NkRSNXpTQ1Q5czRESFlVUkprclYrNG9UeTBVcVdXYkpKa1ZsamIrMEdyYTho?=
 =?utf-8?B?bHBjVTlDM1cvQmUzUjhDQ3RYbkpyVWZxUlRGQkRRcUdxdHVsWnRoak1PTVE4?=
 =?utf-8?B?M2FTanFzN012djdmSE1xa3Vxcm5mM1ZXT3U2Q0xQSWVRTlhZY2ZmTDVlc2pM?=
 =?utf-8?B?L3FxWlJDUzZ0UFhnSHMxWTc3OVhBb1Bnd2JDdVk4cVRWREZ6YTA2R2xHc3E2?=
 =?utf-8?B?c1liZjNOWVBrazY3U3NzY3JRbytPSHU2REFidFhVQU1wVHNWSEpiWUhTampC?=
 =?utf-8?B?b281ZmF1S0c2VXpkWHRBUklzQUVlMVJOYWVGclM0UzB0S1MwV2J2dmZYYnZq?=
 =?utf-8?B?eU1BWHJIeXRiMkJRa3BhSTIzd2V2NElMMmI1dlluQXp5eDB1RDVoRU9MUGR5?=
 =?utf-8?B?UlZjK21VczJmQ05rYXQ4TjI5YUpTalQ3RlpYRmx0ai9xcWtvNUkwRC8rOHpG?=
 =?utf-8?B?TFNPdlZpWXE2aC9UZk1zYzBnSTZTK3FFc3ZNc0tNV1daNWRGcXJBbXloSzF4?=
 =?utf-8?B?aENPYXA1SVBUWHcxV1M4c1hnSnBITnZlQWZmd2dycjRyV3NSajRTUFJNUW9O?=
 =?utf-8?B?QTZJaWtHa0FxS1ZsellpbUlKNk4vcWRYSWhDck1CUzZHKzk4TGU0RE4rTDFD?=
 =?utf-8?B?V2lwYzZDSXdwL0RPdnlqNE1OdGNCOWVrZURLeFRPZ0lFbGpZMlcrWEVGbFl3?=
 =?utf-8?B?SmlpTXZCZlMwR0RTcVc5T29zL2o3R05RdFNRNmpBWXoxODIxMUoyTTNyaGlZ?=
 =?utf-8?B?VVJYNkF4MkJVQ1p3MGZkNlpKRy9SVW5kTlN6ZGpwRmt1aGJkMGhKR1I1TVB4?=
 =?utf-8?Q?0QGNibdJWzuH5GmbQqqBzL8t+ZeeKnkI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RVhMR2EyZnF0aWtQRkVsVDE2L3ovSGo5OTdmRUg5UVVqdnR5OVE4MktMQ0hF?=
 =?utf-8?B?NkN0V2VGL2NONGVqVFVlQ05VUHl3SVUxc1lTQVNiOWtiUmdDenMzQzhERTBH?=
 =?utf-8?B?MFAzYjFzTWZyZXJYdHlMT3RvQzJHamZSNmF2b0pFOTBKWlZoSkxuSGhXdkhB?=
 =?utf-8?B?T3dNYWtSYUQ2RndGbFk0ajMvelJwMjdIRHpzN1A1S1BNcWhaUm5BVHRWZVhx?=
 =?utf-8?B?azE3NWk1WUlSblB4MFhQZFZEY0hGVEczdVJYRzFVK3hvdFBPQk5NWnlwdDNX?=
 =?utf-8?B?NTJSTVRKVWYvOVR0NmJlVGVhS2RVd0tHNTJlSjFIN3Zsb01Oc0JDMEpjbmJE?=
 =?utf-8?B?dkMwNEVoZWNJTDFJcTN1Ym1lMXZXZmlTdEt6dzg3N252NzNtU1VqcHJ6Uy81?=
 =?utf-8?B?TkR2bGpwQktIMXFNV0oyVEJUeVVRb3VNbW1peUNGb0VTYnVlL0pxd0RaYys2?=
 =?utf-8?B?VjIvRTNZM2hPYUhwT0hJOUpZYnR1TFdwajhBbGFEYWhIZnlRRFJSSmQ5L2ZG?=
 =?utf-8?B?ZitFc0ZwdXdLbVZlaVNudVlsOUU1TkVLQ3NGZExCaW5hZ1BOeXZzeDFNOGxo?=
 =?utf-8?B?M2M4WTVnTE5EYmIyVzJCMVhQNVVpTzN6QU9lMmlhaVdIS3h6UDBaeEJ2ZCtS?=
 =?utf-8?B?Ylpob2F0dWwwcnk0SkNUbHArR2Q4T3NuQS9YU2I3amVDYVE2eDcwUDhTUjdl?=
 =?utf-8?B?VkpYbUViWU52ekNjUWcycTFKSHNxZ20raHlkQmlYRytjMjBPdERRWm9SelQv?=
 =?utf-8?B?M052cnRzNVNoN1VHQnFHSzEweUZGcnNNalZOT01wTFptQ3JxNDNrcXo2cFEw?=
 =?utf-8?B?V1FvcE1mZVhQdDRuVElYU1RMamZnZFlLL0xnUFJmc0F4K3pSbWw3aVp5MzNN?=
 =?utf-8?B?QWhFQlRROFdxWVBwTXkzL1NLcWhISUpEaWVzNEVOTk1lVnR4bS95Z2M3dzJQ?=
 =?utf-8?B?NXEvZGEyMFh0cTlrUnQwdzNPU3Zsd3gxcFowb0N2T1JQVjh4Y09uM2M1M3NP?=
 =?utf-8?B?My9Wd1pwa214UVpvNGtOMXZnMlVVVDRxdmUvb3FMUkJlU0cvQTJua2FHRHcx?=
 =?utf-8?B?VTVEQmdmekp6QXFHMWdpcDBTdUpHNTh4T2tNMjhIdElpc2phcTVBUUxVdzAw?=
 =?utf-8?B?RGsyaHJlOURpeVovdjYxUEJsc1hiTEMxWm92TmFhWksxUit5NlFDWlh2Zy9J?=
 =?utf-8?B?WitpdzZDcHdFeldQbTc4dUtzT2Zaa0tWdWJianlxRDd5cjhEbVRsNkRXYUli?=
 =?utf-8?B?aGp3WHljZE5BZkxwNzRFaG4xYkUwTTRrQ3oyeGVBQlRFZWhrUmFNNnZpeUpK?=
 =?utf-8?B?NTVQb0I1eWdJYzE2TXBlTTZVVW02ekRFRm1haWc1dUdyYTJOQjlrNDcxeWQz?=
 =?utf-8?B?Qk1YdXVtellqd1dMQlhmSnBwN1A4ajg5c0F5UnhlZi9jZXhMNEYrYm5rL1I0?=
 =?utf-8?B?RXIwQ2hpL2dtbEJobWZMcEhaWTdCRVBEazcrRzl3bnFaNFh4YkVVZjRiT0hE?=
 =?utf-8?B?OXJvU3IrNU9ieGJ4TXliOVdOUW8vRUNhM3JhUjBiQU9jc2RnNGhYUGRUVFV0?=
 =?utf-8?B?ek9PdlhRcUo4QzRuYTY0RWpsTnRaMDA3MDB5OXYxbG1SVmdPQmJwYzY3cnd4?=
 =?utf-8?B?OUJDdkJiNm5yUmpxRzk2YktOcXhwSy9yQWNaSFdObEZ0czlQc0hDQjBIUE1D?=
 =?utf-8?B?UzVRNXloeHRTRXhpZHp5TXFvYjVSUHJJeStCd3c5ay9RVkZiN1ZDNGFXdTNw?=
 =?utf-8?B?eGROZ2xMUzZ5ODlQdi9MUGd3MFFvN1dHOUNUZEl5SFR0N0tvNGhxV21IcEx1?=
 =?utf-8?B?bjRNVmhWOVU5YWJNOHJwMFF0L0ZDdlI5SzZlQTNMUENtNVdla2FMN21hbEdn?=
 =?utf-8?B?ZTFYaCtjMGV5eXNUbGNSd3RRa2lLZm4yOTcveEFZeEVwYWlDdDBiNmxGSUpa?=
 =?utf-8?B?aEhHci9tSFlSMnowWWkzYVFkTm5vUGlWOEZvTHVvalg0Y3IwcVEwYTBiSDIy?=
 =?utf-8?B?RitSZmw1LzB3SUo0a202RVFHU1JXbVNFb0J5b1gvOCt4U1E1WFJ5UW44dGxL?=
 =?utf-8?B?S0dwNWRXbHg5R1g1VVdFcEhhQ2R0TlJCRGZna2VOMGloVnVnbG9IQm90UVRt?=
 =?utf-8?B?RnRSZzRlVyttYzFyWHcxSFoyNU9uS01hL2gxNlc1dWowRS94cnBKV1FFd2J0?=
 =?utf-8?Q?HPZB9TYLL9Q66y8FNCikScw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7D1A332F066C64CA040305860F4D8CE@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb01f83-899e-40b4-14e1-08dd4fb3f548
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 00:34:08.8815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KU3Y7I3BBaBbXdJCTMgRdvKTTGK8ykUA1mrjvvzSuW0+9L7fgRvQerQWxn6ngtWoo3efvoiyTvR9dyPltx1tpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR15MB5959
X-Proofpoint-GUID: 1BajZuGG79fcgW_k0BP8MHHWVy9F2F2t
X-Proofpoint-ORIG-GUID: 1BajZuGG79fcgW_k0BP8MHHWVy9F2F2t
Subject: Re:  [PATCH v3 0/9] Remove accesses to page->index from ceph
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=785
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180002

T24gTW9uLCAyMDI1LTAyLTE3IGF0IDE4OjUxICswMDAwLCBNYXR0aGV3IFdpbGNveCAoT3JhY2xl
KSB3cm90ZToNCj4gVGhpcyBpcyBhIHJlYmFzZSBvZiBGcmlkYXkncyBwYXRjaHNldCBvbnRvDQo+
IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9kaG93ZWxscy9s
aW51eC1mcy5naXQgbmV0ZnMtZml4ZXMNCj4gYXMgcmVxdWVzdGVkIGJ5IERhdmUuDQo+IA0KPiBU
aGUgb3JpZ2luYWwgcGF0Y2ggMS83IGlzIGdvbmUgYXMgaXQgaXMgbm8gbG9uZ2VyIG5lY2Vzc2Fy
eS4NCj4gUGF0Y2hlcyAyLTYgYXJlIHJldGFpbmVkIGludGFjdCBhcyBwYXRjaGVzIDEtNSBpbiB0
aGlzIHBhdGNoc2V0Lg0KPiBQYXRjaCA3IGlzIGhvcGVmdWxseSBwYXRjaGVzIDYtOSBpbiB0aGlz
IHBhdGNoc2V0Lg0KPiANCj4gTWF0dGhldyBXaWxjb3ggKE9yYWNsZSkgKDkpOg0KPiAgIGNlcGg6
IFJlbW92ZSBjZXBoX3dyaXRlcGFnZSgpDQo+ICAgY2VwaDogVXNlIGEgZm9saW8gaW4gY2VwaF9w
YWdlX21rd3JpdGUoKQ0KPiAgIGNlcGg6IENvbnZlcnQgY2VwaF9maW5kX2luY29tcGF0aWJsZSgp
IHRvIHRha2UgYSBmb2xpbw0KPiAgIGNlcGg6IENvbnZlcnQgY2VwaF9yZWFkZGlyX2NhY2hlX2Nv
bnRyb2wgdG8gc3RvcmUgYSBmb2xpbw0KPiAgIGNlcGg6IENvbnZlcnQgd3JpdGVwYWdlX25vdW5s
b2NrKCkgdG8gd3JpdGVfZm9saW9fbm91bmxvY2soKQ0KPiAgIGNlcGg6IENvbnZlcnQgY2VwaF9j
aGVja19wYWdlX2JlZm9yZV93cml0ZSgpIHRvIHVzZSBhIGZvbGlvDQo+ICAgY2VwaDogUmVtb3Zl
IHVzZXMgb2YgcGFnZSBmcm9tIGNlcGhfcHJvY2Vzc19mb2xpb19iYXRjaCgpDQo+ICAgY2VwaDog
Q29udmVydCBjZXBoX21vdmVfZGlydHlfcGFnZV9pbl9wYWdlX2FycmF5KCkgdG8NCj4gICAgIG1v
dmVfZGlydHlfZm9saW9faW5fcGFnZV9hcnJheSgpDQo+ICAgY2VwaDogUGFzcyBhIGZvbGlvIHRv
IGNlcGhfYWxsb2NhdGVfcGFnZV9hcnJheSgpDQo+IA0KPiAgZnMvY2VwaC9hZGRyLmMgIHwgMjM5
ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgZnMv
Y2VwaC9kaXIuYyAgIHwgIDE1ICstLQ0KPiAgZnMvY2VwaC9pbm9kZS5jIHwgIDI2ICsrKy0tLQ0K
PiAgZnMvY2VwaC9zdXBlci5oIHwgICAyICstDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDEyNyBpbnNl
cnRpb25zKCspLCAxNTUgZGVsZXRpb25zKC0pDQo+IA0KDQpJIGRpZCBydW4geGZzdGVzdHMgd2l0
aCB0aGUgcGF0Y2hzZXQgYW5kIEkgZG9uJ3Qgc2VlIGFueSBuZXcgb3IgY3JpdGljYWwgaXNzdWVz
Lg0KDQpUZXN0ZWQtYnk6IFZpYWNoZXNsYXYgRHViZXlrbyA8U2xhdmEuRHViZXlrb0BpYm0uY29t
Pg0KDQpUaGFua3MsDQpTbGF2YS4NCg0K

