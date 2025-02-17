Return-Path: <linux-fsdevel+bounces-41875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A547A38AFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 18:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E513AE9CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 17:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1CA232367;
	Mon, 17 Feb 2025 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mXAPoWiv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD54CD528;
	Mon, 17 Feb 2025 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739815039; cv=fail; b=KNBnF6wyQIFPAUaUqu36S3T+jjq2voPuIKa/WwAkGUeN946AnDW1UJCJUI04A9nP8M1S/cdl17FmkQhHivhjd4bzhbEDZHzBcVe3Q8zKxA1i4aXKbajuVuuWCb4jSRqcuJOV1a1QaG+5L6/BIZNgDtb6W/nkgQTiOvdIBY7qd+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739815039; c=relaxed/simple;
	bh=6HxIQ8UiZZvBvUfQra2zT7o7tc6o8Zi2qrijpCi08fI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=NwWLXm36g7my7+Z4XIdyxMv0dNWeeaBU3DqJ8Jbuj0YBjzgKKi7cCWlBn8hLaFPJVPPbMSzQ0fNRJ3p6jxaKlzxZ3VKP7FSLM27sQWj6SoyJ8qkeMNa3OvI28aW/jeODAtMgfIb0zWXYAC1+lh7wQ9SqVRbAKuRxGHjSlZE/4rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mXAPoWiv; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HClXrq012422;
	Mon, 17 Feb 2025 17:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=6HxIQ8UiZZvBvUfQra2zT7o7tc6o8Zi2qrijpCi08fI=; b=mXAPoWiv
	/c2YUR3b8NIMvW1+JQgUV4LPn57SRwju400/GB0fy7XMPEkluLZkM5932MTeHHbJ
	YBrLZt78TktEjVxPC2lgqAQYZI+mpIWWserQVq2/3gOO2WT57CeWiwke8FRUqhA5
	453heN0VAkTNpsmV/jLNU69xy0xKb4MSB1oqWbK264bO4S6H18Loofb+3ei9N73R
	1VhDAngcmJrEJCSCKH/3IDVkqCT5Zq7wMEi58MJcJvaDViifIMqbjn9Qh8Hl6KZ1
	IOPxvjeULm2Jl8XTw+Okv/g3AnNeVo1thIZZIm+w0qDvbi+nOdGvuwjycpfyPqKp
	TusXXdn2P6nrcQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44uuy046f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 17:56:59 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51HHjMsu025941;
	Mon, 17 Feb 2025 17:56:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44uuy046ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 17:56:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3mGAHo3/attMCPiZD3nueHYo6kzXQcXeo+KQgLOZJYETAKUGgs2rDkSu4wUFZ6a2iBMlU4eGSTr7MqqpHSDHTqyk6yT9NsypgTp6BWu8emaGSqc4SNm4/AHy1PLiVLm3LkF2ZtuQG7nC3RZCqqW61dlpn3ppplbqv4BFd89gTGRcq71a74oqscQoX/jv5Oex9LIB+t9XxlrfkKyqQ2czv6uFKdzKtWu8JxvGsGYMBkzvoV0OPA2XH3IYCgKJpH/ZWsou0Hv8P8t9qGBDADOdeh/JJKP4u0AuwCoVrdomkIW0K0Ur3dRABQpovU3fJcACCQqxRgvMaMNZGGmA5YUjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HxIQ8UiZZvBvUfQra2zT7o7tc6o8Zi2qrijpCi08fI=;
 b=eB29S17FjUsxxL9jp0dOip/dwsaWJ6kQ78V4qcN/2aXAnq0N1mYjP05S9+4sfdecHLhf3jnP4g3OiDJOEOFW3+31QN83BhTJI6ZQxsn7F8rIg4PySkkA6yghBcfYyZheMmwuo0eyqOMapJATzl2MD1FM1vRnVigPY+Kudi+uypbYVtAfgxOOPTj4jvYAZt2vPY6gQz4C4aTZfJV8Z/SLY1WOAU6z7rw7Q11gn1azsIggoGNGHnTcoDC4H0VgaAsJNwxcm1lFseNgBuk1i7bKRDGFdwb3FI9cD1r+N88A00uCJw6MkhmLt0Bpmgkp4NCV9W9VXPO+myvjd/87PRswGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com (2603:10b6:a03:4e4::8)
 by SA1PR15MB5045.namprd15.prod.outlook.com (2603:10b6:806:1d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 17:56:56 +0000
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::266c:f4fd:cac5:f611]) by SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::266c:f4fd:cac5:f611%5]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 17:56:56 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "luis@igalia.com" <luis@igalia.com>,
        "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>
Thread-Topic: [EXTERNAL] Re: [RFC] odd check in ceph_encode_encrypted_dname()
Thread-Index: AQHbfpCIos2EbKYFiUGV+rHGHxWwQbNG8KKAgAAHCy2AANRJAIAAtn1ygANLFYA=
Date: Mon, 17 Feb 2025 17:56:56 +0000
Message-ID: <4ac938a32997798a0b76189b33d6e4d65c23a32f.camel@ibm.com>
References: <20250214024756.GY1977892@ZenIV>	 <20250214032820.GZ1977892@ZenIV>
		<bbc3361f9c241942f44298286ba09b087a10b78b.camel@kernel.org>
		<87frkg7bqh.fsf@igalia.com> <20250215044616.GF1977892@ZenIV>
	 <877c5rxlng.fsf@igalia.com>
In-Reply-To: <877c5rxlng.fsf@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB5821:EE_|SA1PR15MB5045:EE_
x-ms-office365-filtering-correlation-id: f6614b24-2490-442c-aeb7-08dd4f7c77ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SGh5d0huOGdodGhtaUU5S283cjNmZEwzZm4rQ1ZHWmRUZ1dIYkExR2s1WUha?=
 =?utf-8?B?RS93Q213QkhxckJWNmhNTlcyME0xS3NIckRkdll5RkFNSEt3VHlVZmR3TXYv?=
 =?utf-8?B?Y3YvamRMSEJjNGZEWXY1anQ5RUt0aHd5NFYxdWNvK1ZYdjlLS2daRHpTc283?=
 =?utf-8?B?V29kQzloQUQyTU0zU2dISDBpVHhPa3JQVmhvTDRad2R4OWFjRHJQTW13Q2xt?=
 =?utf-8?B?Z2xtc2p1SFFybTFLNmlERlhyUmV0L3dhZENEU0VQWnlFUC9jeW1qeXYyTU9S?=
 =?utf-8?B?U1BQY0oxWkdYTkpYeW1TbEFodXFONzBLNzNpdFFGSjN0WnpRYWlKQzR4RW1x?=
 =?utf-8?B?cVJJZmh1QmZYeUJuUFpPZHlNSEZpM2NBWDRNODFJQ3R0N1U4Y09BL1ovMm1i?=
 =?utf-8?B?Y2diQ0tqdHlmdzVFeXhFUDlCUjJoQ0Uxb0NzVHU4djlQczZTV1hjRFZDM0Vz?=
 =?utf-8?B?RFY5RU0rYkZ3bFd3bC9sK1d6Tk5nOWk0ZEdoSUE0YTcybDBCck1XbnI5cWM1?=
 =?utf-8?B?NTg4b2E3cnhFY1h5SGE4dGMraXNRYTJjUkZKMEMrbnA0UDgwYStNc0Q1NHhs?=
 =?utf-8?B?WUZZdzkrQVo0d0VBUXVvNmhyb2hnK1JOcGZFRmlmVW4rQmloUzU5cnd1QWZl?=
 =?utf-8?B?TVFPZ1R5WWxlVG5Lb1hXYktOdUtUbURVZlcrcXVmelNsVEtWL1BsN1owR3Ba?=
 =?utf-8?B?Qm1veXRYWnJCSHVwcjc2L2JWeXN2SVY2TUljejRpcVJ0ZnlVZ3ErcFNjR08w?=
 =?utf-8?B?YU9FU2t1NnBuRWg1Y3dEamhpTzVkZEQwVldvRGlHY1p1YkFjU1hOdGtURUtq?=
 =?utf-8?B?NTRnYWYreVc2bzRJbXlLM1UrN2tvUXU2MGpyU0xiajhPcVJnQXMvRjQ2ZWZW?=
 =?utf-8?B?elZscW5XTnRydDdGZDhhZEo2T2hCYTlRbXliaXErRC8zcHVwTUx2cnZDR29T?=
 =?utf-8?B?OW1PaTZoWEJSa1RwYWNRcG9zVm5iTXBtUC9EL3Z0NEU5dlBvYzVhY3UxS0Nv?=
 =?utf-8?B?ck5UMkEvRjhzdkRJd0ZiZEREWTJLeG1HYjRIUnZjYmorK0x5V3lRZVNDMCtR?=
 =?utf-8?B?azVZSHJJU0dwR1hOUjdBMlQrNjFWTTBzTkltMDE3ejNsUEozaU1DditZQ2NS?=
 =?utf-8?B?Z1VMQXJwQlhRbER1Z3p5YzVDL3FDMmcxVnd6dEJOc1JvUUhtckZjWHliNHps?=
 =?utf-8?B?R3hGTDFIc25ZNlZVS3ljcWxobW1lL0dvR1huNG5kOTFMSERYeUxYRVB6Z1Ry?=
 =?utf-8?B?VmFLaXlrZGthWkErTXNRRWJkVENQeWdWMWpSM2o4WjNJSVpGRCs5cWx3ZVRR?=
 =?utf-8?B?QzlMYjlLUW5RdG9ULzlYMUNUdEl1TG0rQWRlUDE1YVpuRnZmWEhDaUNOZ2wz?=
 =?utf-8?B?T3F1OC8xVEdDS2VJM3psVHY3UFE5Ni9Bc0NaNmJOVGl3ak9CSG9aUG1ITmEr?=
 =?utf-8?B?YmZrTmY0dzRtRitVWjBSWURISG83QUdMNFQvRzJDL2dKVjI5eTIyZklhQVQv?=
 =?utf-8?B?bUV4SGFaMUlFNWY2QTBlQnBhdFUzTnozbW9pLzR0OEVoQ2h6dTBESFNyekUz?=
 =?utf-8?B?ZTNLT2M3cWdneHJmQkJrZU53VXN1aFB4cjdxdytBNlZMSTR6R2NqcFJMUFUr?=
 =?utf-8?B?Y3JvVnFmK05RNG0zR04vaWlwbUZHaS9EU1c3UUo2S3M2QVJ1RDFsSThVTXc1?=
 =?utf-8?B?QUxzSGNCekd0VS9WbzB4SWVML05uNk1rRkV4Q0dHdzFBMWhHRUlkUzhDWjBL?=
 =?utf-8?B?dENFUU9BOEdXVTBxMUFVN05mcWxCazU5c0VSdy9COGw0b0krK0FHOWZZU2tm?=
 =?utf-8?B?Rko2TkFYZk05UnlEZW9VS2Z3TnRTZ09adlJWamI2Ujh1U1VRZkxyblROYnl1?=
 =?utf-8?B?ekpYVzJZTWxjWkUzbjd0Y1FzTXVzYm1DbUg0dUcyUUo2eEdNamhPaW4reDl2?=
 =?utf-8?Q?J04xBjmcIlrCyNlBswK8aVF8VLrMrAEH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5821.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UmdnTG9tdHFqSTA2NXdoMmdvaGhkdkhLN2NhODk5UmMwQm1oRWFsQlZpMzlU?=
 =?utf-8?B?M1FkaE01cksyU1lxUGo1R3d3T01XcG1XOUhaeHdOOG5vQTBoMXFPNGFZYnJG?=
 =?utf-8?B?bzVVTHo2MmFDRGxPZmVMZ1NOazN3Z1R5cGtUaTlEOWMza09GME9zUDZxZHhQ?=
 =?utf-8?B?NVdFTk1CWFFSdmFnSmxxMTZmenVBdS85TUQrV3UwNm8xbWM1bDkyZHNUQkJJ?=
 =?utf-8?B?N0hWZG8rRU9PTGlkYStvNk9nTmJzd0pvMFh3ZkFVT2F0aUdXRE9mTGNsOUk0?=
 =?utf-8?B?QzYwdno3UGwvMkJYLy9YakpmRk1MemFacnBSTG5aZTIzbHkrNGhiWHJMMjRR?=
 =?utf-8?B?Q09sdHNtS01jdGU0MExnL3AwcnNNUWFseGJrOTdqUjV3TGFBVVR5bmNLcVRP?=
 =?utf-8?B?TEt3QUN6bys0cXIvUzJ5WFRLZzJyODduVFo2Q1c3aW14cS9RRnQ1eXJUd1l0?=
 =?utf-8?B?M0JDeFloNXlXU1Brbk5iUVVWaG00ckNQWkFnWnJaZUNWTDUraXVKSUJBOVFT?=
 =?utf-8?B?b3NiTy9YMnNIdGVVd0F3cTdObEw3aXJiTVlFckZJeVprUFJaSE1hYWdzV244?=
 =?utf-8?B?ZEhQTk9nSlhoRmluN25yTE8vdXpXUHowZENTcWZoOEZpenkrdmYzTjRkZ1Qz?=
 =?utf-8?B?d2FNN3lINGpzU2hSZXpLYlZJZ0Qya2NKdUs5QndjcXpmUGVXSDNBQzBMd3RY?=
 =?utf-8?B?YnU2ekpLMjZBTmRDM3dGVkluV3FzcGJOaG1pVDF1SVo3MU9CUEs2L3JjM2R3?=
 =?utf-8?B?bnNjTHdkRW1LZHFiYmphU0EwQnRHaVM4cWd3b0VuTDlndVF3NFFiWHlkaDlp?=
 =?utf-8?B?V0EyNWVwbkNkNE9keGp5ZjhBWDI4eTV4eXZsMkZ6bWZwUWsvSUtFb2IvbFlE?=
 =?utf-8?B?NlIwZGt2R3M4Slo5ZWNyV3dodjZkVko2MHJocWVGcXhRT3hVL3U4VU1pMmNh?=
 =?utf-8?B?aW5mWXlWR01RNzdFYU9VR0hiU2tvQW83dThKVmQ2TWZacEZRODJGdDNPSUFH?=
 =?utf-8?B?MmVtd1VXa0F0SVcycEt4QW51dUxKaUR4cUI5NnZlSlZsaUFabEVFTk1iU3F3?=
 =?utf-8?B?N0F1WlVhc3dsbWVrM0kxd3NiSGszc05KUmZxVEdGb25sdXdPcUlrbFNkNDY3?=
 =?utf-8?B?Q09vaTdzR1NEcElzTGQrcGhTY2ZMRDFhdkVwNHlaN1ozYUI4YldpcVIrWUhy?=
 =?utf-8?B?WWJmaEU2dGJkSHI0RDgrM1cxdHppc1czL0JiS3FobThINWJVSUpQVXBIMVdy?=
 =?utf-8?B?T2IyQy9hMXNGNms3a3grTjRTNlRJMmR5eENIU3BuODV2VmVPQ2RYRGpBWE02?=
 =?utf-8?B?RFhNeWhiWlVqZzFxT05PdFdxUHdjUHhYdzRWMklGcHhmeVNGWUFLU1RIZy8v?=
 =?utf-8?B?d05VWTRtV3FHOUNuM2M1d093TThkbUpNNE9yWjNCNytSa1V4cHBHSVVvcHdl?=
 =?utf-8?B?d2F2WWQ2YmFMT2JZTjRRcDJVMllZN1grUVV2a2EreTkyUWh1MWl1cTRodzRn?=
 =?utf-8?B?U3Qzd3ZCM2orMXdBWFd3QkRqRys1YmNFeUxqTUd0K2UvSGlKdER6NVMwT3BX?=
 =?utf-8?B?YlpUQk9xQjZJa3NmeHRYWU01Rk0xSDZoSDlLbTJOeUN1S2VuaGp1ekM0aVdp?=
 =?utf-8?B?VTJ4WHgrS1FKTXJ6b1JTdituaDJvb1ZoR2c4ODZpNlBmWnVGZzhWbFoxYUZO?=
 =?utf-8?B?a2xOdnJHY0Z1UEdubitlZEhXOFhaYXNDL1ZEMmtjRjRyVWNmS2FFa0RCNnZ5?=
 =?utf-8?B?ZE5VbXpLS29MQ1VONnl5S3ZRWmFaamphM3FIUGpuSEM3ekdNZ29tUjVuV2Fr?=
 =?utf-8?B?b0J5NlVDUFEyT29FaDJQM0RVelJhRmNUcGdIVnNaT2RYM1VtMmlyaHlPUDh6?=
 =?utf-8?B?TzFEdGQyS0psL2ZkRm96M1Y5RE0xaldtZTdZTG16YW1ocjY2S2xkeEIxUWdl?=
 =?utf-8?B?QmpCSVI1SzF3QjZnSEtnZUttMDVrUVdQOC9MTFpkbVZmMHgySHRBaU9xZnJs?=
 =?utf-8?B?TEIrQVRsNGFtbGlKU2Z1TFJEWVc3R3hHSDB4eE15NnVRblM5OEtVL2J3Ry9H?=
 =?utf-8?B?MklmeTI4MDA4cFF2bm5VckhIU25MWlVPVjF2ekVwMlNWS1V3NHBBYXZxY1F3?=
 =?utf-8?B?cmtIM3k3ZWFlMVgxbEV2VkxKZGROUEJxNkFJYWxOK21mczhEenVrd090Q3ZN?=
 =?utf-8?Q?WhdrGs1X8K6CX4d8fOyHFes=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <106BA6BDB2DE43478C589C6327AB80A7@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f6614b24-2490-442c-aeb7-08dd4f7c77ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 17:56:56.2800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TYEYJ26Rzs5KsDSrRYzIepYbqFimWX6oLNrZ9VUjQghJYsGLDBiwfNdGjYOzFya+UWHwWbIZY1NQ8ZnHfGuZRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5045
X-Proofpoint-GUID: Sf3c57lb7SqUo13Zcs0fzYvkZWfWpUSR
X-Proofpoint-ORIG-GUID: bvHOQXyUgdKBBWlZzcS7ebNp1cHIgXkJ
Subject: RE: [RFC] odd check in ceph_encode_encrypted_dname()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502170136

T24gU2F0LCAyMDI1LTAyLTE1IGF0IDE1OjM5ICswMDAwLCBMdWlzIEhlbnJpcXVlcyB3cm90ZToN
Cj4gT24gU2F0LCBGZWIgMTUgMjAyNSwgQWwgVmlybyB3cm90ZToNCj4gDQo+ID4gT24gRnJpLCBG
ZWIgMTQsIDIwMjUgYXQgMDQ6MDU6NDJQTSArMDAwMCwgTHVpcyBIZW5yaXF1ZXMgd3JvdGU6DQo+
ID4gDQo+ID4gPiBTbywgSUlSQywgd2hlbiBlbmNyeXB0aW5nIHRoZSBzbmFwc2hvdCBuYW1lICh0
aGUgIm15LXNuYXBzaG90IiBzdHJpbmcpLA0KPiA+ID4geW91J2xsIHVzZSBrZXkgZnJvbSB0aGUg
b3JpZ2luYWwgaW5vZGUuICBUaGF0J3Mgd2h5IHdlIG5lZWQgdG8gaGFuZGxlDQo+ID4gPiBzbmFw
c2hvdCBuYW1lcyBzdGFydGluZyB3aXRoICdfJyBkaWZmZXJlbnRseS4gIEFuZCB3aHkgd2UgaGF2
ZSBhDQo+ID4gPiBjdXN0b21pemVkIGJhc2U2NCBlbmNvZGluZyBmdW5jdGlvbi4NCj4gPiANCj4g
PiBPSy4uLiAgVGhlIHJlYXNvbiBJIHdlbnQgbG9va2luZyBhdCB0aGF0IHRoaW5nIHdhcyB0aGUg
cmFjZSB3aXRoIHJlbmFtZSgpDQo+ID4gdGhhdCBjYW4gZW5kIHVwIHdpdGggVUFGIGluIGNlcGhf
bWRzY19idWlsZF9wYXRoKCkuDQo+ID4gDQo+ID4gV2UgY29weSB0aGUgcGxhaW50ZXh0IG5hbWUg
dW5kZXIgLT5kX2xvY2ssIGJ1dCB0aGVuIHdlIGNhbGwNCj4gPiBjZXBoX2VuY29kZV9lbmNyeXB0
ZWRfZm5hbWUoKSB3aGljaCBwYXNzZXMgZGVudHJ5LT5kX25hbWUgdG8NCj4gPiBjZXBoX2VuY29k
ZV9lbmNyeXB0ZWRfZG5hbWUoKSB3aXRoIG5vIGxvY2tpbmcgd2hhdHNvZXZlci4NCj4gPiANCj4g
PiBIYXZlIGl0IHJhY2Ugd2l0aCByZW5hbWUgYW5kIHlvdSd2ZSBnb3QgYSBsb3Qgb2YgdW5wbGVh
c2FudG5lc3MuDQo+ID4gDQo+ID4gVGhlIHRoaW5nIGlzLCB3ZSBjYW4gaGF2ZSBhbGwgY2VwaF9l
bmNvZGVfZW5jcnlwdGVkX2RuYW1lKCkgcHV0IHRoZQ0KPiA+IHBsYWludGV4dCBuYW1lIGludG8g
YnVmOyB0aGF0IGVsaW1pbmF0ZXMgdGhlIG5lZWQgdG8gaGF2ZSBhIHNlcGFyYXRlDQo+ID4gcXN0
ciAob3IgZGVudHJ5LCBpbiBjYXNlIG9mIGNlcGhfZW5jb2RlX2VuY3J5cHRlZF9mbmFtZSgpKSBh
cmd1bWVudCBhbmQNCj4gPiBzaW1wbGlmaWVzIGNlcGhfZW5jb2RlX2VuY3J5cHRlZF9kbmFtZSgp
IHdoaWxlIHdlIGFyZSBhdCBpdC4NCj4gPiANCj4gPiBQcm9wb3NlZCBmaXggaW4gZ2l0Oi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Zpcm8vdmZzLmdpdCAjZF9uYW1l
DQo+ID4gDQo+ID4gV0FSTklORzogaXQncyBjb21wbGV0ZWx5IHVudGVzdGVkIGFuZCBuZWVkcyBy
ZXZpZXcuICBJdCdzIHNwbGl0IGluIHR3byBjb21taXRzDQo+ID4gKG1hc3NhZ2Ugb2YgY2VwaF9l
bmNvZGVfZW5jcnlwdGVkX2RuYW1lKCksIHRoZW4gY2hhbmdpbmcgdGhlIGNhbGxpbmcgY29udmVu
dGlvbnMpOw0KPiA+IGJvdGggcGF0Y2hlcyBpbiBmb2xsb3d1cHMuDQo+ID4gDQo+ID4gUGxlYXNl
LCByZXZpZXcuDQo+IA0KPiBJJ3ZlIHJldmlld2VkIGJvdGggcGF0Y2hlcyBhbmQgdGhleSBzZWVt
IHRvIGJlIE9LLCBzbyBmZWVsIGZyZWUgdG8gYWRkIG15DQo+IA0KPiBSZXZpZXdlZC1ieTogTHVp
cyBIZW5yaXF1ZXMgPGx1aXNAaWdhbGlhLmNvbT4NCj4gDQo+IEJ1dCBhcyBJIHNhaWQsIEkgZG9u
J3QgaGF2ZSBhIHRlc3QgZW52aXJvbm1lbnQgYXQgdGhlIG1vbWVudC4gIEknbSBhZGRpbmcNCj4g
U2xhdmEgdG8gQ0Mgd2l0aCB0aGUgaG9wZSB0aGF0IGhlIG1heSBiZSBhYmxlIHRvIHJ1biBzb21l
IGZzY3J5cHQtc3BlY2lmaWMNCj4gdGVzdHMgKGluY2x1ZGluZyBzbmFwc2hvdHMgY3JlYXRpb24p
IGFnYWluc3QgdGhlc2UgcGF0Y2hlcy4NCj4gDQo+IA0KDQpMZXQgbWUgYXBwbHkgdGhlIHBhdGNo
ZXMgYW5kIHRlc3QgaXQuIEknbGwgc2hhcmUgdGhlIHRlc3RpbmcgcmVzdWx0cyBBU0FQLg0KDQpU
aGFua3MsDQpTbGF2YS4NCg0K

