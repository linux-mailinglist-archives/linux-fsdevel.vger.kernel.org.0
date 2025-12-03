Return-Path: <linux-fsdevel+bounces-70595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B726CA1888
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 21:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FF413009F1F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 20:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599463148AF;
	Wed,  3 Dec 2025 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lqtIEjJv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BACD3093B5;
	Wed,  3 Dec 2025 20:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764792919; cv=fail; b=u2FtqRKvY5c2CR3MbUWjArzHzHqoVEq8/p2sag3HDGAVXhRac9D8HN/75GAehkrZIlInuyzxQBe6FMsxH8E6JWimYV1PaPGXJfCY3vhK9IBtvS0R8v7APk1ROs3oJRZ8FSojYKpDsr274ixr8SNUp4dXZAjGfWJXvhwRiiZ6Yhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764792919; c=relaxed/simple;
	bh=3T44wiPv47iQbfDncHJIoKg29UmRRaVXzGUKBBj6vrQ=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=jBvsRZk9d0QlJPiyn9kq9zxUKaTXTvqKfvc3K2io6G/0HYBr7fJ12UwXUbOiwIwgu0ZmnlxPUo93CQqBc3lmDKIvTfjsNrz/i9JrzCgnqorI3f1YFEXXP4O/t4ppkeGVoCn/JlCQNSpQeG2wuLzJ/1HMD0pEc0x/XB+Wn35PEnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lqtIEjJv; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B3BtJ2L013518;
	Wed, 3 Dec 2025 20:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=3T44wiPv47iQbfDncHJIoKg29UmRRaVXzGUKBBj6vrQ=; b=lqtIEjJv
	euX8rYHrm11KBn0lky04WdNiPVEmm+Dr9Go2cON5Gtpj0stUAVRa1xUzF/Il756I
	2Hph15o2LfD2oyXvtzOWK+rm5ac2cPIR3on811OZtezea0So1OYmWxTyl9LNcSIy
	pmlift9SMEjPJU2T/gCsKZV8imXpGCEiSEoYLQmxgvHOt/ayN3l46vFuxVnZ9xBC
	Lw3eGlOpc76X5NF817bdza1GKnobIw6pn9IDTB/dAiHpDAp9u4zXH4MgQFzQ3Ks0
	ozRQuT9CrBtEHV/aemVsIxDeqiXQ8lPr6aKECSwxF6I5eY7b8ikZg+J7STEPqnsj
	tvNXycmLxln2cA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrh74wae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 20:15:15 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B3KAHvP028878;
	Wed, 3 Dec 2025 20:15:14 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011063.outbound.protection.outlook.com [52.101.52.63])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrh74wa7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 20:15:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/49JF7J1myrUJMU2N+AWRtXRNW/YmIFA+cR9D/jUyUn0uNfdaf9nvYLZYs5PHyZTwCHBebAx1E8S9j4nf754NjgKYQI5vmxyxPN/xfEFXm4JyzkN5L2jkA3P6GMNV2HbZnCmI4GrnKgRNI7qI38JpE89nm0DgUOopWZ+TQECJ61R6mMMTG8ZomDyaWeyJRfWDDUhaGY2/R42MxLzc4Sa6vkq0ey7p2BfW3LzC1xfMjRQcN+4pQ9tw04vsgcwYaI0YM8OVOEUxp0RlKpmjGUqtOElUYiTKdxlhnLsBhwI9lVlhRSmt7Bk5lpA/XeGh6999B3vxuO5BVhplxhXg39iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3T44wiPv47iQbfDncHJIoKg29UmRRaVXzGUKBBj6vrQ=;
 b=X1J/rxC0G8TYnPZQnWNN8EkMeEwCDU73XfxKYWJECVE76JulrSs5RoAgfKE8R05iH85r4WsYrgiXaMxY7N1kGsY90Tv+aI/CEM/BtrCM8xWB7OcqLckG9c4k3oWKi6i0TMT8vXs6CknBKii3g58TkTgZ3BnCMvtTsgsXrwbOSowTv6Js5FVRhHS2Rs1M+06VtzR6IaEhmxPtvqUCLb2OKtLi61Qw7GHidzVSCxdq6vnNVBmHjYWRzvDfCRIX7ScsA+DCkOhPBXvEh5tVx+FQQci4V3KVvWjv8spczt9GXU6ZvrIAdIAKtYUstWEuJBqBRdCQ9juuZII2kLu/5t/6uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BL1PR15MB5364.namprd15.prod.outlook.com (2603:10b6:208:393::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 20:15:10 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 20:15:10 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Alex Markuze <amarkuze@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
CC: Viacheslav Dubeyko <vdubeyko@redhat.com>,
        "idryomov@gmail.com"
	<idryomov@gmail.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v3 4/4] ceph: adding CEPH_SUBVOLUME_ID_NONE
Thread-Index: AQHcZG0inEu293gBRkyus0hA7ulIBLUQWjGA
Date: Wed, 3 Dec 2025 20:15:10 +0000
Message-ID: <361062ac3b2caf3262b319003c7b4aa2cf0f6a6e.camel@ibm.com>
References: <20251203154625.2779153-1-amarkuze@redhat.com>
	 <20251203154625.2779153-5-amarkuze@redhat.com>
In-Reply-To: <20251203154625.2779153-5-amarkuze@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BL1PR15MB5364:EE_
x-ms-office365-filtering-correlation-id: b1581ab3-6192-4fe2-e580-08de32a8a8ed
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z01Dd3M4SWxuSDdOeCtWZGdrR0E5RUdqNE1SaWZkNkdCTDBaTlJUM1FDZ2tB?=
 =?utf-8?B?eXArcmN5b1Jtb2NZYjAxNmV1eXNNWkN3bm9zcE16NmpFRnFJQTYxUTNZMWlo?=
 =?utf-8?B?Vlo2YUU2U0ZqQmpHaDVINHR2Tjc4WmxVTUtNazRVdnlmL1V1VHhxZnRYUjhy?=
 =?utf-8?B?ZE1zb0RGTkV3bFNsYUNxOTVUZ042YzRzZkFiVGdBRER5VFdoV0orY2h6VXFa?=
 =?utf-8?B?aCtBZFRHREphUzc1Sm1jMGVMWHFYRDBldVVXZVhmVTQvOHQvNFlsR09JRko1?=
 =?utf-8?B?VWhFUEtUSVdUMGk0U2ZBWDVkMHpBQitZVVNJQmZHZnBQeUhDNUVZdnV4cFZu?=
 =?utf-8?B?b3NBUjdvem9DZnp6cEtsWmFPZ1B3bUM2NFptRzBTMjBGem85WHB6bDNsTWRs?=
 =?utf-8?B?S21yZGROQlBJVmJobzRjQ0dLK2VMcFAyN2Y5VUcvSFNMUnpLVEdJVGxuMHFF?=
 =?utf-8?B?dmVmb2NvclJBV1lrbjh4MnRHN0IwOVdkZlQxenNPcXpESUR0ZStVUm9Ld3dj?=
 =?utf-8?B?RHQ3SUhMamZReURVbXZERFo3L2xGNmxPN0s4YnJqVFpMZlE4TndxaHFtKzFy?=
 =?utf-8?B?Z2krUXRvaW1DdkFXdnpvaDkrSFppM05FZFRLRW5HSVpwcUpPYUNoZGFlREFJ?=
 =?utf-8?B?ckJqMFFRY2k0VmNxaHF6U0ZHYkRQTTBudlgwZEhSM2JDSFYrS0lDYURUUlhS?=
 =?utf-8?B?K2Q1UFJuNVlEeU56emlvMDdHQmQwOU5YUFNjNFcwOEtEQTMwRThGRzVmbW9C?=
 =?utf-8?B?MjJRU1hmQ2VGRmt3aTlOeGpuNjNpNTBuTXM5WkdDbGVuRHRuS0FWWWFWS1Jk?=
 =?utf-8?B?eVlDQ1I0MzFPcWNYTW9qODlFZW12MlkwWGNoUnhpL3FIM0QyWUhaMUVnZ3Uv?=
 =?utf-8?B?eVdRQzRld2JycnArSHFjMUxCZG0yNGR3bXAvMnZ2WDBzWHY2QytTQWRkZXpX?=
 =?utf-8?B?a2NHRGk1VnNOK1F1RVY1d1ZVMEFRcmJXQUNZODlSVHVtdkoyZlhuVFlFb05Y?=
 =?utf-8?B?Qno5a2hKNDFNWmFJYmhsMkh4N1pmQTlQNmVTcFFxWlBTcW94NCtUTS8vRXdz?=
 =?utf-8?B?WlVrZzJKdVlyb3ZrZGttRjA1U0RDbVFlT3orNmkxZkhtcU9oelUxYktkM0lS?=
 =?utf-8?B?OUFuN3ZScVJaUmM5WVMvdVV3Q0U2ajRBUlVPTEcwTGw2Ulh2elVJdE4xUnJR?=
 =?utf-8?B?T0ludzVPenhiZ0xxMHJEVUFvQ1YxMHQvVnFVby95dkpqZG0ya3hqWThMU1RD?=
 =?utf-8?B?NGtwWmJPYmhkUm1YS1hSZkxFKzNTNEtYREYrS2xSSkVWaUhRK2dGVjlmRjYy?=
 =?utf-8?B?a1VXdG1ET1VSUk9LK2V2bnhRbmhXVHREQnpqb3dPWGkrcnJSTXludjYrMkpj?=
 =?utf-8?B?SDRNdk5CU2RhNWo1T3RuZFh6Sk1NN1JBUG9wdFdJR25UVGduVXVMSzVaNWtY?=
 =?utf-8?B?ak1EZEkySnFoWlFLdUNuVklOVGdDMUhHN3ZETS9jTHdVbVEzQnk0bDVTV3pC?=
 =?utf-8?B?QmtBWHV6YVBISlc3QVQyNlIyOC9KWE5CU1p0ZVd6WmtGbzVJeFd5SlY4WE91?=
 =?utf-8?B?T0RtMXJXV3FvN3N5enk4dHVGNFJHb3J5bjRWVUg2Rmw0dUkzN0QrdWx5NjNG?=
 =?utf-8?B?enJmWEZHZlUxdXNXd0hSYSthUU9FZU9wa09GUFF0TFdEQTdUOFhHM0x6cVhW?=
 =?utf-8?B?VzhSWVFKY2pvcGdrc002YkJTYmJGVHZzeGNydDh6S2E2LzFLZ2htVllQQ3J2?=
 =?utf-8?B?NHhGREZrWldnNENMWS9SaERiVW1yNkFXUEdkNnZrZ1ZQbjJUcjZvOW1aRzFx?=
 =?utf-8?B?YjI2OEZ1ZjlrOWRFU21FUXhtSXFYSHVzQ01uSmNqMmhZTG54ZVliZ25lMkw1?=
 =?utf-8?B?UFAyMmNCYTg2OTUrbUozejB5YmhFRmx3MEcrRkx2dXcyMUljQVZLVkdKQmh5?=
 =?utf-8?B?SXpXeFJxS2pyV3ZSMVc5VzJieXFEWUxhYlo5WVB5RStOSDA3V1Z0b3VWYXlI?=
 =?utf-8?B?bDR3K20wWno4OWpCaE1XTFdSZDVDMzdtOUFVbU9CYzJYK1QwcUZ2RDBkTVZr?=
 =?utf-8?Q?BA7fKV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWQ2WUw4Mk1VYWYxd3BLUFB3OHRsQklvMWRITVA0Sm9tNURzM2RkWFpuTGdh?=
 =?utf-8?B?cS9BSm9nb2YrV0hLZ3lHSE9KTGEwV0VRV3l6dVpHbHRSQURENy8xcmJXWG9i?=
 =?utf-8?B?cjlnK21vWFIvR25NKzBGTFVqSVI2SnJuZXhCUmFMVC9UcVVaSGw4QldBWUYv?=
 =?utf-8?B?dWdRRDFZL0dlTnV3b0R5NTlwU2F6MUZPbnpIWmdNTFl4akZuV1pKMXFsR09X?=
 =?utf-8?B?cVM4N0Y2NUgzNmh4L09PUC9CdkxJUkczMTJHVmdRMEJPYmFoUmFBSWt6SHFS?=
 =?utf-8?B?OGtKbHVpc0c2OHMyVXZmS0FBMk1mZTBiOWVYOFZSTEVlMDVjZkRrMkErSUdO?=
 =?utf-8?B?UGV0enVaWnJzcHF4Z0t3eHF4TE90NFExTndLU1BPK2JBb0FHc0ZncnhLZkZQ?=
 =?utf-8?B?RGFCM3U2c0cyR0VKdWFoZkN5TkJIZC8rT1h0dDAzSlJNNjVqRTlBeXdyRWlK?=
 =?utf-8?B?TjR1L0wzVE1wdDEvQm5tSW9LaTBEWVEybk11M0Q5YUxrQkxPdXpNYXZ0c3FG?=
 =?utf-8?B?cjFZcGYxYVc3cVlCV3FncllhTDBaQTVIODBYUDA1OXQwR3FyY1V4V1JTWEdE?=
 =?utf-8?B?WWRJNjNKbVJnamJSMWFCOTJZbHpHb2N5MnVwZTg0elQwNzNKWGtMNkM3Z0Nx?=
 =?utf-8?B?VThWVmMwTi9kczFIOG14amZJQVdZelFzWUlHY25PU1dWVGlObFZRSkZzbWJM?=
 =?utf-8?B?bWQvQUFoRU5raVNrQ25SRTNRbGdIWVJtS1RGNkhjMEdxQXozd0tmYUs0aU01?=
 =?utf-8?B?dFBhUTVGZ0liVWY3UjdKYTNXK3dCVVZqa0xqZkp4Vkh2NVI4UWZNU1l2M1Mr?=
 =?utf-8?B?ZzhhR3QxcnJtaWhNNkl4K2p2b0Z2WjRhNTRCQzh6TFB4ejd5Tk5qVlpIdVV1?=
 =?utf-8?B?K291R1N1dXM3S3lzWHh1L2h6Tlo0L0E4M3VtdDVIMkl6eWRFdVZKbVNiZEgx?=
 =?utf-8?B?MVNWU1I4WGFiZ0JUSldQd2lOcVhaQlI0QWh6TDR4T1RFZmNaNm5mS0ViZ1M3?=
 =?utf-8?B?Z09KcnBEM1pCYm8vQTNNL3dKMmRwbzkvaXpHdTFKVXAyOXFwMG04bXpqZCtO?=
 =?utf-8?B?cS8rQnZubFUyWENOc2ptWWhud3BhY21rVng2SzZaeE9GaFAvYVA2YnlKMFZL?=
 =?utf-8?B?MjJud09ScUZDRzBYSWc5TnhETGJiOEdTdEV1YmlWLzNGQzBlSE5wRjQxcEJR?=
 =?utf-8?B?d1l1dnhPSzFsZ3duTjJSbnBCaVJXcmtETHg5a0pSd2NkUUZQQkVvRHRwNmNC?=
 =?utf-8?B?aXBLTHAvQk9hZTdUVExoVU9nb2RPcDBmMzBFS3JGQS95ZDRXL050NHVFRUts?=
 =?utf-8?B?SEtVNkprNk9QbWlBVTdXaEpsYW11VmVwVzZOUkIyK1VzUzhnRkFPSTFKRUt3?=
 =?utf-8?B?ZlZ6eWFzWXd0bzJYT3ovOG83L2xTajl3NmliS0ExUnhDaU8vQnNVTjBXcnNW?=
 =?utf-8?B?ZXdEZUZzdERMcnkvb1hReEdMaU1FVGVXWERyMTZ2QUljTEtNZG42TEZTMDVU?=
 =?utf-8?B?V014OGJ2dEpqaWErZVFzd3pvdDhmSjh3MDNPZEVZQTBrUGtYMUhOUjkrMm15?=
 =?utf-8?B?MzNDVnRRdHl3cWxyekhja2FTa3dsNGFrTk5EUmZRcExVQ0MrLzhMdFhvSGxU?=
 =?utf-8?B?R20xN0ZPazBrMkF5R0dNcm1COWxaaGU0aDFSazRXaXVveGtrcFR3YkxZbmZ3?=
 =?utf-8?B?RGNlVlh1VkMwWnJDR3c2U2Q0NkZta3R5QTY5cDNVRkZQOC80OGdOS2xzN0FN?=
 =?utf-8?B?NWhKTEZMTm96US9iQzJMeDZSN3c2Uk5OUTVmMzJjYTZ6UUlPNjBBdythUFJy?=
 =?utf-8?B?UnUrUmx6KzJhUmFWTjBSaktwY3UvZy94b05uK05NSDVMclNvQzU5QVFycTlD?=
 =?utf-8?B?bmlzWk9TdUtuYWNPMTFFdjI2ZkhuMVhLdnFpZ0gyTEY3ZVpNOFJNQUJTdDZj?=
 =?utf-8?B?aE9ONit6Y0tabDhLQlpiUXVoR2V0cjY1bTJVOGdzZUgrRjdocnZKNjZ5VlhN?=
 =?utf-8?B?WisxZWc4ZzdPVEhHNFVKUVFMTEtITHBlNmdwemRNMklSNG96TDdSNlFEbTFj?=
 =?utf-8?B?U2xnUlhOaTNkb3ZCcWZyNERWa3FHMnVOREdlVlVzVDI0ZkJVUEFqeG9FMGpC?=
 =?utf-8?B?RXNZc2xHL1pzV1hGWFluaEZQc2VQek1nRXV4WndhTkxtTzZjQnpIaFdRaHBY?=
 =?utf-8?Q?oRotUhKTiuspezUiblU9OME=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F861F1CB79AA344B1DA7D8BF11A28B7@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b1581ab3-6192-4fe2-e580-08de32a8a8ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2025 20:15:10.2983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KCW0zyBb0dugrbB281tqaHzA67ADNogYllvPa8VMF/M2Z44/d+6sqgJgb5oNEjjN5MzgsMVtfwmfpBO/5Sftlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR15MB5364
X-Authority-Analysis: v=2.4 cv=dK+rWeZb c=1 sm=1 tr=0 ts=69309a53 cx=c_pps
 a=/mfax+0MUk3zis5Hx41TAA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=cGckTQPchKBExK_GHmkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HaO3LQQIeSmvY7r9YHIP5fqrexQ68giQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX59CRuv1GC3p5
 S0qTq8XMpG/wvigSt/eUhFQ+58d5l4N1TUjLst4zLi2l5st+xXlDUTchnEJAIpq95+cQZXyEQv0
 NbtApEvEKcX5CtJb8RgGvePCMCmbGVyWpuzSEBf8FXpiR3cvHxuXYDOPzgpYQAM5GE+75H/9Du/
 POyMVBTLW/LU6zQzr+CJIGlL20Vi/hYcX6ydAor1TvAd3uN2fUeTKa73iQwXoMaD0fHfLcK1/Xf
 zRZOXTrjtEgsR7Qovr+E1tx7yAKX59Cqm7RnjeJXGHDOVMWR2jaaUIvgxyJRlEkjvli+uy3W0Wx
 9NkKoQ5YZK+XSPZQlhhCLx9YBWPai2XVkezn7tuDy/aAUaKLduFsD6dAVS8d2f03dML1nii/19g
 MU1tkeArFgaVxldoCMHBwUMYTLWM7Q==
X-Proofpoint-ORIG-GUID: JPnM0k_tpXWfr34v9jALTtBlaGOwyvl4
Subject: Re:  [PATCH v3 4/4] ceph: adding CEPH_SUBVOLUME_ID_NONE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020

T24gV2VkLCAyMDI1LTEyLTAzIGF0IDE1OjQ2ICswMDAwLCBBbGV4IE1hcmt1emUgd3JvdGU6DQo+
IDEuIEludHJvZHVjZSBDRVBIX1NVQlZPTFVNRV9JRF9OT05FIGNvbnN0YW50ICh2YWx1ZSAwKSB0
byBtYWtlIHRoZQ0KPiAgICB1bmtub3duL3Vuc2V0IHN0YXRlIGV4cGxpY2l0IGFuZCBzZWxmLWRv
Y3VtZW50aW5nLg0KPiANCj4gMi4gQWRkIFdBUk5fT05fT05DRSBpZiBhdHRlbXB0aW5nIHRvIGNo
YW5nZSBhbiBhbHJlYWR5LXNldCBzdWJ2b2x1bWVfaWQuDQo+ICAgIEFuIGlub2RlJ3Mgc3Vidm9s
dW1lIG1lbWJlcnNoaXAgaXMgaW1tdXRhYmxlIC0gb25jZSBjcmVhdGVkIGluIGENCj4gICAgc3Vi
dm9sdW1lLCBpdCBzdGF5cyB0aGVyZS4gQXR0ZW1wdGluZyB0byBjaGFuZ2UgaXQgaW5kaWNhdGVz
IGEgYnVnLg0KPiAtLS0NCj4gIGZzL2NlcGgvaW5vZGUuYyAgICAgICAgICAgICB8IDMyICsrKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tDQo+ICBmcy9jZXBoL21kc19jbGllbnQuYyAgICAg
ICAgfCAgNSArLS0tLQ0KPiAgZnMvY2VwaC9zdWJ2b2x1bWVfbWV0cmljcy5jIHwgIDcgKysrKy0t
LQ0KPiAgZnMvY2VwaC9zdXBlci5oICAgICAgICAgICAgIHwgMTAgKysrKysrKysrLQ0KPiAgNCBm
aWxlcyBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9mcy9jZXBoL2lub2RlLmMgYi9mcy9jZXBoL2lub2RlLmMNCj4gaW5kZXggODM1
MDQ5MDA0MDQ3Li4yNTdiM2UyN2I3NDEgMTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvaW5vZGUuYw0K
PiArKysgYi9mcy9jZXBoL2lub2RlLmMNCj4gQEAgLTYzOCw3ICs2MzgsNyBAQCBzdHJ1Y3QgaW5v
ZGUgKmNlcGhfYWxsb2NfaW5vZGUoc3RydWN0IHN1cGVyX2Jsb2NrICpzYikNCj4gIA0KPiAgCWNp
LT5pX21heF9ieXRlcyA9IDA7DQo+ICAJY2ktPmlfbWF4X2ZpbGVzID0gMDsNCj4gLQljaS0+aV9z
dWJ2b2x1bWVfaWQgPSAwOw0KPiArCWNpLT5pX3N1YnZvbHVtZV9pZCA9IENFUEhfU1VCVk9MVU1F
X0lEX05PTkU7DQoNCkkgd2FzIGV4cGVjdGVkIHRvIHNlZSB0aGUgY29kZSBvZiB0aGlzIHBhdGNo
IGluIHRoZSBzZWNvbmQgYW5kIHRoaXJkIG9uZXMuIEFuZA0KaXQgbG9va3MgcmVhbGx5IGNvbmZ1
c2luZy4gV2h5IGhhdmUgeW91IGludHJvZHVjZWQgYW5vdGhlciBvbmUgcGF0Y2g/IA0KDQpTbywg
aG93IEkgY2FuIHRlc3QgdGhpcyBwYXRjaHNldD8gSSBhc3N1bWUgdGhhdCB4ZnN0ZXN0cyBydW4g
d2lsbCBiZSBub3QgZW5vdWdoLg0KRG8gd2UgaGF2ZSBzcGVjaWFsIHRlc3QgZW52aXJvbm1lbnQg
b3IgdGVzdC1jYXNlcyBmb3IgdGhpcz8NCg0KVGhhbmtzLA0KU2xhdmEuDQoNCj4gIA0KPiAgCW1l
bXNldCgmY2ktPmlfZGlyX2xheW91dCwgMCwgc2l6ZW9mKGNpLT5pX2Rpcl9sYXlvdXQpKTsNCj4g
IAltZW1zZXQoJmNpLT5pX2NhY2hlZF9sYXlvdXQsIDAsIHNpemVvZihjaS0+aV9jYWNoZWRfbGF5
b3V0KSk7DQo+IEBAIC03NDMsNyArNzQzLDcgQEAgdm9pZCBjZXBoX2V2aWN0X2lub2RlKHN0cnVj
dCBpbm9kZSAqaW5vZGUpDQo+ICANCj4gIAlwZXJjcHVfY291bnRlcl9kZWMoJm1kc2MtPm1ldHJp
Yy50b3RhbF9pbm9kZXMpOw0KPiAgDQo+IC0JY2ktPmlfc3Vidm9sdW1lX2lkID0gMDsNCj4gKwlj
aS0+aV9zdWJ2b2x1bWVfaWQgPSBDRVBIX1NVQlZPTFVNRV9JRF9OT05FOw0KPiAgDQo+ICAJbmV0
ZnNfd2FpdF9mb3Jfb3V0c3RhbmRpbmdfaW8oaW5vZGUpOw0KPiAgCXRydW5jYXRlX2lub2RlX3Bh
Z2VzX2ZpbmFsKCZpbm9kZS0+aV9kYXRhKTsNCj4gQEAgLTg3NywxOSArODc3LDM3IEBAIGludCBj
ZXBoX2ZpbGxfZmlsZV9zaXplKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGludCBpc3N1ZWQsDQo+ICB9
DQo+ICANCj4gIC8qDQo+IC0gKiBTZXQgdGhlIHN1YnZvbHVtZSBJRCBmb3IgYW4gaW5vZGUuIEZv
bGxvd2luZyB0aGUgRlVTRSBjbGllbnQgY29udmVudGlvbiwNCj4gLSAqIDAgbWVhbnMgdW5rbm93
bi91bnNldCAoTURTIG9ubHkgc2VuZHMgbm9uLXplcm8gSURzIGZvciBzdWJ2b2x1bWUgaW5vZGVz
KS4NCj4gKyAqIFNldCB0aGUgc3Vidm9sdW1lIElEIGZvciBhbiBpbm9kZS4NCj4gKyAqDQo+ICsg
KiBUaGUgc3Vidm9sdW1lX2lkIGlkZW50aWZpZXMgd2hpY2ggQ2VwaEZTIHN1YnZvbHVtZSB0aGlz
IGlub2RlIGJlbG9uZ3MgdG8uDQo+ICsgKiBDRVBIX1NVQlZPTFVNRV9JRF9OT05FICgwKSBtZWFu
cyB1bmtub3duL3Vuc2V0IC0gdGhlIE1EUyBvbmx5IHNlbmRzDQo+ICsgKiBub24temVybyBJRHMg
Zm9yIGlub2RlcyB3aXRoaW4gc3Vidm9sdW1lcy4NCj4gKyAqDQo+ICsgKiBBbiBpbm9kZSdzIHN1
YnZvbHVtZSBtZW1iZXJzaGlwIGlzIGltbXV0YWJsZSAtIG9uY2UgYW4gaW5vZGUgaXMgY3JlYXRl
ZA0KPiArICogaW4gYSBzdWJ2b2x1bWUsIGl0IHN0YXlzIHRoZXJlLiBUaGVyZWZvcmUsIGlmIHdl
IGFscmVhZHkgaGF2ZSBhIHZhbGlkDQo+ICsgKiAobm9uLXplcm8pIHN1YnZvbHVtZV9pZCBhbmQg
cmVjZWl2ZSBhIGRpZmZlcmVudCBvbmUsIHRoYXQgaW5kaWNhdGVzIGEgYnVnLg0KPiAgICovDQo+
ICB2b2lkIGNlcGhfaW5vZGVfc2V0X3N1YnZvbHVtZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCB1NjQg
c3Vidm9sdW1lX2lkKQ0KPiAgew0KPiAgCXN0cnVjdCBjZXBoX2lub2RlX2luZm8gKmNpOw0KPiAr
CXU2NCBvbGQ7DQo+ICANCj4gLQlpZiAoIWlub2RlIHx8ICFzdWJ2b2x1bWVfaWQpDQo+ICsJaWYg
KCFpbm9kZSB8fCBzdWJ2b2x1bWVfaWQgPT0gQ0VQSF9TVUJWT0xVTUVfSURfTk9ORSkNCj4gIAkJ
cmV0dXJuOw0KPiAgDQo+ICAJY2kgPSBjZXBoX2lub2RlKGlub2RlKTsNCj4gLQlpZiAoUkVBRF9P
TkNFKGNpLT5pX3N1YnZvbHVtZV9pZCkgIT0gc3Vidm9sdW1lX2lkKQ0KPiAtCQlXUklURV9PTkNF
KGNpLT5pX3N1YnZvbHVtZV9pZCwgc3Vidm9sdW1lX2lkKTsNCj4gKwlvbGQgPSBSRUFEX09OQ0Uo
Y2ktPmlfc3Vidm9sdW1lX2lkKTsNCj4gKw0KPiArCWlmIChvbGQgPT0gc3Vidm9sdW1lX2lkKQ0K
PiArCQlyZXR1cm47DQo+ICsNCj4gKwlpZiAob2xkICE9IENFUEhfU1VCVk9MVU1FX0lEX05PTkUp
IHsNCj4gKwkJLyogc3Vidm9sdW1lX2lkIHNob3VsZCBub3QgY2hhbmdlIG9uY2Ugc2V0ICovDQo+
ICsJCVdBUk5fT05fT05DRSgxKTsNCj4gKwkJcmV0dXJuOw0KPiArCX0NCj4gKw0KPiArCVdSSVRF
X09OQ0UoY2ktPmlfc3Vidm9sdW1lX2lkLCBzdWJ2b2x1bWVfaWQpOw0KPiAgfQ0KPiAgDQo+ICB2
b2lkIGNlcGhfZmlsbF9maWxlX3RpbWUoc3RydWN0IGlub2RlICppbm9kZSwgaW50IGlzc3VlZCwN
Cj4gZGlmZiAtLWdpdCBhL2ZzL2NlcGgvbWRzX2NsaWVudC5jIGIvZnMvY2VwaC9tZHNfY2xpZW50
LmMNCj4gaW5kZXggMmI4MzFmNDhjODQ0Li5mMmExN2UxMWZjZWYgMTAwNjQ0DQo+IC0tLSBhL2Zz
L2NlcGgvbWRzX2NsaWVudC5jDQo+ICsrKyBiL2ZzL2NlcGgvbWRzX2NsaWVudC5jDQo+IEBAIC0x
MjIsMTAgKzEyMiw3IEBAIHN0YXRpYyBpbnQgcGFyc2VfcmVwbHlfaW5mb19pbih2b2lkICoqcCwg
dm9pZCAqZW5kLA0KPiAgCXUzMiBzdHJ1Y3RfbGVuID0gMDsNCj4gIAlzdHJ1Y3QgY2VwaF9jbGll
bnQgKmNsID0gbWRzYyA/IG1kc2MtPmZzYy0+Y2xpZW50IDogTlVMTDsNCj4gIA0KPiAtCWluZm8t
PnN1YnZvbHVtZV9pZCA9IDA7DQo+IC0JZG91dGMoY2wsICJzdWJ2X21ldHJpYyBwYXJzZSBzdGFy
dCBmZWF0dXJlcz0weCVsbHhcbiIsIGZlYXR1cmVzKTsNCj4gLQ0KPiAtCWluZm8tPnN1YnZvbHVt
ZV9pZCA9IDA7DQo+ICsJaW5mby0+c3Vidm9sdW1lX2lkID0gQ0VQSF9TVUJWT0xVTUVfSURfTk9O
RTsNCj4gIA0KPiAgCWlmIChmZWF0dXJlcyA9PSAodTY0KS0xKSB7DQo+ICAJCWNlcGhfZGVjb2Rl
Xzhfc2FmZShwLCBlbmQsIHN0cnVjdF92LCBiYWQpOw0KPiBkaWZmIC0tZ2l0IGEvZnMvY2VwaC9z
dWJ2b2x1bWVfbWV0cmljcy5jIGIvZnMvY2VwaC9zdWJ2b2x1bWVfbWV0cmljcy5jDQo+IGluZGV4
IDExMWY2NzU0ZTYwOS4uMzdjYmVkNWI1MmMzIDEwMDY0NA0KPiAtLS0gYS9mcy9jZXBoL3N1YnZv
bHVtZV9tZXRyaWNzLmMNCj4gKysrIGIvZnMvY2VwaC9zdWJ2b2x1bWVfbWV0cmljcy5jDQo+IEBA
IC0xMzYsOCArMTM2LDkgQEAgdm9pZCBjZXBoX3N1YnZvbHVtZV9tZXRyaWNzX3JlY29yZChzdHJ1
Y3QgY2VwaF9zdWJ2b2x1bWVfbWV0cmljc190cmFja2VyICp0cmFja2UNCj4gIAlzdHJ1Y3QgY2Vw
aF9zdWJ2b2xfbWV0cmljX3JiX2VudHJ5ICplbnRyeSwgKm5ld19lbnRyeSA9IE5VTEw7DQo+ICAJ
Ym9vbCByZXRyeSA9IGZhbHNlOw0KPiAgDQo+IC0JLyogMCBtZWFucyB1bmtub3duL3Vuc2V0IHN1
YnZvbHVtZSAobWF0Y2hlcyBGVVNFIGNsaWVudCBjb252ZW50aW9uKSAqLw0KPiAtCWlmICghUkVB
RF9PTkNFKHRyYWNrZXItPmVuYWJsZWQpIHx8ICFzdWJ2b2xfaWQgfHwgIXNpemUgfHwgIWxhdGVu
Y3lfdXMpDQo+ICsJLyogQ0VQSF9TVUJWT0xVTUVfSURfTk9ORSAoMCkgbWVhbnMgdW5rbm93bi91
bnNldCBzdWJ2b2x1bWUgKi8NCj4gKwlpZiAoIVJFQURfT05DRSh0cmFja2VyLT5lbmFibGVkKSB8
fA0KPiArCSAgICBzdWJ2b2xfaWQgPT0gQ0VQSF9TVUJWT0xVTUVfSURfTk9ORSB8fCAhc2l6ZSB8
fCAhbGF0ZW5jeV91cykNCj4gIAkJcmV0dXJuOw0KPiAgDQo+ICAJZG8gew0KPiBAQCAtNDAzLDcg
KzQwNCw3IEBAIHZvaWQgY2VwaF9zdWJ2b2x1bWVfbWV0cmljc19yZWNvcmRfaW8oc3RydWN0IGNl
cGhfbWRzX2NsaWVudCAqbWRzYywNCj4gIAl9DQo+ICANCj4gIAlzdWJ2b2xfaWQgPSBSRUFEX09O
Q0UoY2ktPmlfc3Vidm9sdW1lX2lkKTsNCj4gLQlpZiAoIXN1YnZvbF9pZCkgew0KPiArCWlmIChz
dWJ2b2xfaWQgPT0gQ0VQSF9TVUJWT0xVTUVfSURfTk9ORSkgew0KPiAgCQlhdG9taWM2NF9pbmMo
JnRyYWNrZXItPnJlY29yZF9ub19zdWJ2b2wpOw0KPiAgCQlyZXR1cm47DQo+ICAJfQ0KPiBkaWZm
IC0tZ2l0IGEvZnMvY2VwaC9zdXBlci5oIGIvZnMvY2VwaC9zdXBlci5oDQo+IGluZGV4IGEwM2Mz
NzNlZmQ1Mi4uNzMxZGYwZmNiY2M4IDEwMDY0NA0KPiAtLS0gYS9mcy9jZXBoL3N1cGVyLmgNCj4g
KysrIGIvZnMvY2VwaC9zdXBlci5oDQo+IEBAIC0zODYsNyArMzg2LDE1IEBAIHN0cnVjdCBjZXBo
X2lub2RlX2luZm8gew0KPiAgDQo+ICAJLyogcXVvdGFzICovDQo+ICAJdTY0IGlfbWF4X2J5dGVz
LCBpX21heF9maWxlczsNCj4gLQl1NjQgaV9zdWJ2b2x1bWVfaWQ7CS8qIDAgPSB1bmtub3duL3Vu
c2V0LCBtYXRjaGVzIEZVU0UgY2xpZW50ICovDQo+ICsNCj4gKwkvKg0KPiArCSAqIFN1YnZvbHVt
ZSBJRCB0aGlzIGlub2RlIGJlbG9uZ3MgdG8uIENFUEhfU1VCVk9MVU1FX0lEX05PTkUgKDApDQo+
ICsJICogbWVhbnMgdW5rbm93bi91bnNldCwgbWF0Y2hpbmcgdGhlIEZVU0UgY2xpZW50IGNvbnZl
bnRpb24uDQo+ICsJICogT25jZSBzZXQgdG8gYSB2YWxpZCAobm9uLXplcm8pIHZhbHVlLCBpdCBz
aG91bGQgbm90IGNoYW5nZQ0KPiArCSAqIGR1cmluZyB0aGUgaW5vZGUncyBsaWZldGltZS4NCj4g
KwkgKi8NCj4gKyNkZWZpbmUgQ0VQSF9TVUJWT0xVTUVfSURfTk9ORSAwDQo+ICsJdTY0IGlfc3Vi
dm9sdW1lX2lkOw0KPiAgDQo+ICAJczMyIGlfZGlyX3BpbjsNCj4gIA0K

