Return-Path: <linux-fsdevel+bounces-53122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC42AEABB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 02:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689F83BC821
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 00:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A17FBF6;
	Fri, 27 Jun 2025 00:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="aHgqbWUL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78990C2EF;
	Fri, 27 Jun 2025 00:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750983689; cv=fail; b=Nllnv7LgLJ+J32PXaS9E1418m6n0t7BOBxd5Cp9VcMPxhUPkyURA50z+/MXnAvkaMOFCRhOoLmdlKpcEonyvxX5MghTrJUt42Y43CX/enA5ZXeWu2wYJw2HDOvGdEbLMU49OEQOx3vZO9GwiOquEs1zW4OX5FPJpxRYD6A7ID3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750983689; c=relaxed/simple;
	bh=9fXrb6qWF1M9jSHKq4ksYtrxJCiGiZFhC6dMDXyyiZI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o/DskNUs5ceyDI15ZyDuIyiZIDCo2wJmCI20mBkfzJHGZODRFULKxDptrMnUADkMBo7b6ULYtQi3AMWvV9IqDxJfsID5AAOnUA8PFOgz4MxLeQvwxUskmjDUdqMd/kVBD1Z2a0z7RMD6qjjspuO+Nka1nsmTaSsji2PGOBuxMJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=aHgqbWUL; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QMPGg8018309;
	Thu, 26 Jun 2025 17:21:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2025-q2; bh=9fXrb6qWF1M9jSHKq4ksYtrxJCiGiZFhC6dMDXyyiZI=; b=
	aHgqbWULKz8PLk2B2maBpv7q9CRDdFiADbxnV3nb/XAvvoX0yfMRAg1wWHOmHMnq
	OqGHpvHwMLNMCC9zgMrMR7TjI1ZXf4xFFPK53YFj+9Wt1gEKjm17KqmjpinKTjum
	d+mkp5JSdO0NlJBwq+MNeAEuPH/Wm1wn+lzkVRcGq1Vjir5h8D4scWBo3OHf1Hxc
	Vd1kqBlgMbjGLMiwbpRXOXB9WoUMEkohPY57SXH710IaiMIz+dW6RRHy9ujQ6bBQ
	x30xQPO1xHRPhaVNiLKpe5zAB7uTR6pLCSIPyaMBoqCLT02xeepK1zN4nq4WMmXY
	w5oAwlbcdSdimua6sXwXAQ==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47h17my2r8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 17:21:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnYh6262a+HZ4m0/bCuII9rSpZSgIQQUSfDN2gmrEoSzj22yOaIJBOagK+E+kwD4blN9O0Pf8tAekbQEIzy5QrnXblmKb74Yb59Mq1QrDcF3bc83oZINklqXgtz6W9fb9cMi6uKOhIsQbR6SWXSaErqAnkobJNUj6EEjyP6RO3u+76HHzU6PgzOJlgpuqhOIFTIkH9UQxIOjaJyiKopmVWfn7mDEXdsjEtVzQYfcD81eOgxRT2sZ9AKYfhaadiJV9wFAXo7pLgTwdLfBpCWqIw6Z4cicamOvJKeNkxueliNf79dHU+wJedab7QQ6sx4RxCXPtkX76EaTjb2/5RuMqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fXrb6qWF1M9jSHKq4ksYtrxJCiGiZFhC6dMDXyyiZI=;
 b=QgbeEouw6j3wru9wmKBuZ4CsIwXftwBFyW43MNZzLytzyXYXcZjQSYXauGQniqhnnpx2V3I2pahbtycBUa+7mqnrPP91FFVd4q4evTmrr8ywt+HnoLMZQB7yQmgkPwNlBsfkRUDZrW11I/fxOEUkn630pXuUC578nDP1xN5aVknvYre32pUZiSJk9IC6RayHq5ZwKGzr7nFWu4718jUdJEJo1/GsEepoP0Tl4ZoGDEK6FMkXhsqOZxTPCUq45MggYP5N9KxcTvzJBc9oG4rYlKPXYnAnK0KMb25idvsi4eti5HOonlVKBYi77L30J5CU8FnOuwh/9KbrDCp5DJWL3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB5117.namprd15.prod.outlook.com (2603:10b6:510:c4::8)
 by DS4PPFDD0B461C1.namprd15.prod.outlook.com (2603:10b6:f:fc00::9c7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Fri, 27 Jun
 2025 00:21:23 +0000
Received: from PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::90bf:29eb:b07e:94d9]) by PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::90bf:29eb:b07e:94d9%5]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 00:21:23 +0000
From: Song Liu <songliubraving@meta.com>
To: NeilBrown <neil@brown.name>
CC: Tingmao Wang <m@maowtm.org>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?=
	<mic@digikod.net>,
        Song Liu <song@kernel.org>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "brauner@kernel.org"
	<brauner@kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org"
	<andrii@kernel.org>,
        "eddyz87@gmail.com" <eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net"
	<daniel@iogearbox.net>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz"
	<jack@suse.cz>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com" <mattbobrowski@google.com>,
        =?utf-8?B?R8O8bnRoZXIgTm9hY2s=?= <gnoack@google.com>
Subject: Re: [PATCH v5 bpf-next 0/5] bpf path iterator
Thread-Topic: [PATCH v5 bpf-next 0/5] bpf path iterator
Thread-Index:
 AQHb306ox9XN8K6VdkCbVuOe+nEEeLQMnoWAgAYTUACAADBQgIABBU4AgAClEQCAABGDAIAAECWAgABQToCAAEtZgIAARLiAgACMg4CAABkaAA==
Date: Fri, 27 Jun 2025 00:21:23 +0000
Message-ID: <707D80F3-9EEC-4108-8F8D-0BE069133E35@meta.com>
References: <127D7BC6-1643-403B-B019-D442A89BADAB@meta.com>
 <175097828167.2280845.5635569182786599451@noble.neil.brown.name>
In-Reply-To: <175097828167.2280845.5635569182786599451@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB5117:EE_|DS4PPFDD0B461C1:EE_
x-ms-office365-filtering-correlation-id: 2ad5f50e-7319-419c-a8a0-08ddb5108c32
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NFhueW1UOW5lcXFlS2RuakhwMVdvZEQ3MkJLSXBiQTRqaFRRUEVkZ1RHd1Rk?=
 =?utf-8?B?VE5jSkRGUlNPK1BsUTlCVDFHTmt0UFdrdjJIY0ZIM084OE9zb0RQZ05zdEFi?=
 =?utf-8?B?Qno0RmRKb0c4UUZBSWN1N2lsTlJNWUZtVDIvNWtjb1ZvTFc0MURSNE5XT2Yw?=
 =?utf-8?B?dmdWYmdyUHphUmc3UVZEMEFWekt4cTlmS2hzOUY5ckVpRkdlM0l4b2NySUVZ?=
 =?utf-8?B?ajZIVmR5TGNvMTNhNU9McmVQRjhrK2NNV2hzWlk4aWt5TFdLLzg4RjJ4Ny8w?=
 =?utf-8?B?YVFnTi9uUXh3N2pDK0NEVnpKV0lHNU8zYW5GeVpXS3BlaGR4SVJ6SXZoMmx2?=
 =?utf-8?B?N3RMYVdSd2tpRXhIUkcyT0xMVTI0K1Q1UVpqaW03S1RjMFl2VTNsMWIzV1Bx?=
 =?utf-8?B?dGwwOFJVaVJPSG5SV2RpYm13NUF4c2FSZy9RN0VrK2l1VzF1aDk2MXVET2dz?=
 =?utf-8?B?WXU5VmJYK2E4R3ZtaVFnMWRhVy9YZDMwcWFYaGl5OEk4azVydi9GbmZTbU5x?=
 =?utf-8?B?VFZocHJ5VGhKVEdJZ3M1TnRSLzRpUERkVXVpdkR5WVF6U0w0OCtkMGNVWFB3?=
 =?utf-8?B?SU45Y1Q2MmZhNnVjRGJGa0tjWThwTjYxbjZwaks0azNxczVMR01LMnBDTnkv?=
 =?utf-8?B?SEs1cmZTd1FtMlBvK2VhOWphclpuRWNGRHhDM3NlcE5RbnQ4S3BMRHlpeXRu?=
 =?utf-8?B?VlJsaVR2eUVyUm9qZUdqNjlsamRrOTJ3ZVhSL3I5NG5mejJtOFRVOVZTc2lj?=
 =?utf-8?B?cXNXc0pJaCtqSXN6UHJzamxGUjRsU1NjQ05BemVtb2U1c2tINi9GdEx3bE5C?=
 =?utf-8?B?cWV0OFg4QVZEanNnWlgvZ0gzZnpacFVkL0FBZFdsWWtub09uYzBZTm9vTGZX?=
 =?utf-8?B?NjNVN0UxRktwc05qYUwySnViWjZRV1hWL1ovYzdNNkd2a3N3bllaNWhpUkhp?=
 =?utf-8?B?L1hXcDhXcWNXa0JMbEJ6VHNwb2RtWXB4cDlQaXBhNmpEQllIc3B0cGd6OHFY?=
 =?utf-8?B?MCt1dkc5bGt4Q29xU0hZL0RtTjJobXhQK1ZnOVhqQkVKbmJhUGFBUi9NMjkz?=
 =?utf-8?B?dmM2QXg5T0p1bGUreTRrenk3a0RtVUhENmhCMzNRbzg4QzdWVzU4TStSSkEr?=
 =?utf-8?B?OEEzaVZPdmhLVUJ2eVBtS1FEeHduZWhnZVFQci84TjcvaEVEZDViY0ptbDJr?=
 =?utf-8?B?VDRwRkUrYm04a1hBOGNObEs0eTFwTmdJb3VQU3IybmMwMWlPRmNmbWNOU085?=
 =?utf-8?B?ZmFNWndwazFDc0dReTZsYXFua0h2QlN4ejdNMlN0d3lDQzZMWlhpZzdWa3l2?=
 =?utf-8?B?RW1ZVW9sQ011YlkxTVBmQS9QNXR1Z1RBSUJya0tJS0lZdlE4RDF4MDBpUGFZ?=
 =?utf-8?B?UXVzMjR4RG1hTFZXR0FvRTBLZEptZGxCakdqYmFGZkYzdFd0RGsxdHRZMUVC?=
 =?utf-8?B?UW5keEFzRE1DN1hSV2VpckJqMFluSlgyTUlieWQ5YnJMNmZzU0hPMkQ1Undt?=
 =?utf-8?B?bjQ5em5qZ3N5dEkwK09zZHhDdnJTaFpycjZFTXZORGFCNTV3a29GOXlMNjNI?=
 =?utf-8?B?a2lHYWI3eFhUN0xMQlVXVW0wSVBMSDB5eVhFNDM2Q2lHc003aWM3SjlyK21Q?=
 =?utf-8?B?YlBKSjFHaSs4ajhCMkluS2JCakdteGdPZ0w3SC9uQ0o4NEJTNU9aRjg5SnRv?=
 =?utf-8?B?bkpucGNKNGxuZEJyUWp2ZlZFN2ordGtWYUt1L2RyakFTcGVPQ3kySitZdzV2?=
 =?utf-8?B?dWhJVjd3U1d1U09BTHVTMUdYYXpyajdFcnVpaWtLTTVlZ1dSYjNucXRjQVVq?=
 =?utf-8?B?eWxmMzlYRWRMUjYyUElZcXp3bngycjFiaWlHR0NsQTZDUytTOWF4UEY2Q0Z4?=
 =?utf-8?B?Qm5mdENDeVR6UEtrR2lGUUdZZjJ2Y1IzcElGMitOM3FWbDc1eCs5Y3FBQTl3?=
 =?utf-8?B?Y2pndWRtOVVNdXd4SmxBME5hOTdURW13WFZiS09pZUw2aGFkMmxveGNtWmtv?=
 =?utf-8?Q?6CTYy4rEMqA0MGg/r8u+c/uD+RUpmY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5117.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dTVZRjBtangrd1JMSUtIT2NGcy9WNFVLc0dUUDBlellaekVUbEkxZm1EN2lY?=
 =?utf-8?B?Y2l6VFFITlhFR2ZERVdSK2ZLWWhaL3M3eUdJcUo4ajZ4YU9ia1RPNCtLZ21O?=
 =?utf-8?B?VDFrbForSG41b3JDVklDZzlOOWpYMDRBMTFmaWZMeE1JdE4vcnBMWjFXMmFz?=
 =?utf-8?B?dVExekRZR0xCbGxXQzQ2VDRwU2ZqM2pYbW42YTNSYlZYTGsxQy9ZZUhtYXR3?=
 =?utf-8?B?eFZ6VXd4RmFobFZGL3F1WnRJWXViMTJDUnVlWlhyRU9LMVo4NVVRWlY4b3lN?=
 =?utf-8?B?MVVEWEtHKzFvQzJLdEhkZythNUl2OTlqYXV0VUtxeVdOT05tQWMyK1MzV0Rm?=
 =?utf-8?B?SjFWVlBxR1VweHY0MmtORTkxVk5odzFZdWZCUXJuemZLQ0hNenZmTFV2aDhy?=
 =?utf-8?B?WWpqQnN1U2tzNzlpM251ZWVmZGpjWi9vUUxkUENEVTdSbTBVWUQ2cTg0QmRG?=
 =?utf-8?B?cUdPV0poRFRuOUdCYXB2YVI3Nkl6UmtZNm1DV0xkUVEwUWo0NWxqVjhTOC9C?=
 =?utf-8?B?OHhZRkdXVXRXZTVvNTBFeE1ZQWd4b1o2RVlPTXNxK21EdGVtMUwwZVBEeGFR?=
 =?utf-8?B?QW9tblkxcGZIeUFJQ3gwVzYxcFJpYU5WUklnYU1hOFJaQ05rbXM1T2dDOGhB?=
 =?utf-8?B?MWlGZUlJaXdhV3EzTVNEVldjcytvYm1vYjdTanJneVBCeXlJTVRqVGlic00w?=
 =?utf-8?B?S0I5blN6MkNuNndBSWZDTmJRSGJZRDRGYXkwSDVPVjZXeEJIQnk0Z3gzeTJS?=
 =?utf-8?B?MnVUU1VJNlhvcHhVdnlDVWF0SFRvNU1DenNTZkowemt2R1dkalpzaUk0aldR?=
 =?utf-8?B?NWcyRkdTZDNPNk5SV1Y2RnFaTk1MakwvZC84Nnc3Zi85RFdtOWROenFqcW4v?=
 =?utf-8?B?SWFKNXVpQit4SHlma2F4dEFBSVRaZmdIV1YrYlphMUNaaTAzTGtPZFloODZv?=
 =?utf-8?B?c2NOUDZBTXRoKzBZNWhTKzloeEFBT3k1VlJwQTdKeDBIdmlTRjQ2TUZQMDlr?=
 =?utf-8?B?M1YwUFc4WHBuY05INk1pdzJRbS9ZQ0k1VXkvQUsxdGN4Tk91aEgybFUvNy9p?=
 =?utf-8?B?cHBobUUvbzRQMXZnV3dvKzFPYWRyc1JnUHgzZWxlT1pNSVNYQzJYV2FVR1J5?=
 =?utf-8?B?QzlSZTk4bkx4RFFOVEkwakgrRWlsME9lRGw4OWhjLzVjMFJtS2xtcy9lc2dx?=
 =?utf-8?B?cURBaUVGa05UQTdNVnM5ZDU4MUVsZWl2VkduZEQxd0d4bUJKaGc3bGdCaHpZ?=
 =?utf-8?B?MHNISDJLOFBZK0hrMFFoZk1YVjBSZEE5OFlVN0lscDI3NWwvQ2N0UVhYSHFZ?=
 =?utf-8?B?M1RHUUszUjRSS0JsdlE4a1U3WWVPRHFLTWVBc283MzRhaDlSdFZua3laZCsz?=
 =?utf-8?B?TTNHMXlRalZkcm9Gdy9FNFRvQ1Z6K1dralQ5VzVjeW1wdUZWTTdkcFl5aWxv?=
 =?utf-8?B?MG5OZ2JvdVliOWs4d0tJQXcrMXZFdmp1VHErM0l4dGs0em56WjVjVTZXdDVx?=
 =?utf-8?B?OUM2ZVJKeWVWM3VmUFY0UWMvQXNxZ0JJSVlyRXFCR3d6OGR1ellIQXg2Unh2?=
 =?utf-8?B?a3Y3NStIU3d4U0E3cnpHVG5USWpnNzVDb3NJZk4rQm9pZGdiMlBxTEo3b1hL?=
 =?utf-8?B?RThTV3FhR3Q3dElVWmRnNG5PZFltazFkd2RzbEtaaU1pQ3diVTU4SmxvTGRC?=
 =?utf-8?B?ZG9ZeU9VRTFIaTFPWHl0T25UK0VNckdKamJ3eU9OMjd2NzVLem1iRHFXa3Jh?=
 =?utf-8?B?OGNKVzkzZUwzdzZFaWhVbDBKSVhEZkw1VDJLWVZXMVJoV3NJOGlKQ3FyR3R1?=
 =?utf-8?B?M3A4U0F3c0FTUzg4b0xwL0N0amtFeTRXZTRvK0tTQ08xdWJLSnhXYm5ybyts?=
 =?utf-8?B?d3VaTlJHYjVUbHVkQ284L1IvWnp2Q1dueEUwYXNBcm5TaUxpWDNaQk1UN3Jl?=
 =?utf-8?B?N3lNL01haHkrbnhjTTJrS2tCVnNZSGp6eVhiWTBXQzJwK2p0ajhpbEk2bDBv?=
 =?utf-8?B?THdOSGVOUThKaFdhTldFMDNRWENNWHRVTk5HVlZYMkVNSlhpTEVBekUrNFZ6?=
 =?utf-8?B?dURZajNYT1U0NnJsNTRsUEtjSXNkY3ptT25xMVRKY01KQ0EzdGVhdzNIc1E5?=
 =?utf-8?B?SG1mMERtTmJWSTNCQmNlMUQrNmlaTmg3TW5Mc0F1Vm9hWkxYZjN3TUUzMC9M?=
 =?utf-8?B?R2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C61563EB451AC42A4F7E04F3F197DC6@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5117.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad5f50e-7319-419c-a8a0-08ddb5108c32
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 00:21:23.2282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3kbQNa7hEFqMf+0ieTiw7olMeYfaF5UJ7Br5UggqtX2Ac0dTnblQv0OmFXR6MGLna4I02l40AED1x7Wwtr1jzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFDD0B461C1
X-Proofpoint-GUID: yzgG4f-2OGolNumdTqUAcTNQrLl_zPcQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDAwMSBTYWx0ZWRfXz9hwCOd32R8V pihWKOC8IhYofiNa+5/RtZjaM0eYmrAp9HfZXc3OnNuLX2JRP/EmZg13udy5e+zcEunaDDWxRo1 ety5hm4JJ843xJBIEnPC9EXMiZO8zOh+NXsYRWX4baC1B3uBlmcoZn4FrH6jA41nrRgbJV7HLA+
 /r72pC0tmhbiv+a9p+dkiOrc1xAGNBJpuyFQFrHjkTk7BFCznQ06yQL5Kj3UGzVJ2yU00Ro4zqr 6uT3nAIhVGm3iOse1itfzIpd56DRRKCYoKkd8Ajw0gEeHlNWqQnwLn0lEZg/mY4FTfwACg5ZCW1 2gArmrCrQsk87yPj/sqbloXRWFrKXNtBuISCjPntD0c7ivLo558+RoP57g2h6uEqoOlMKv4xL2O
 dH1XiPrE55f8opjueoZcrrEAr59w/Xt5b5u4skcUSM7pJ53rapnsFA6wSG0NOy4tO+TjPs34
X-Proofpoint-ORIG-GUID: yzgG4f-2OGolNumdTqUAcTNQrLl_zPcQ
X-Authority-Analysis: v=2.4 cv=DcwXqutW c=1 sm=1 tr=0 ts=685de406 cx=c_pps a=vLlm6fOi2ONy/6Pih9zO2w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=1fRR9ji2qmBORdfY9iAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_01,2025-06-26_05,2025-03-28_01

DQoNCj4gT24gSnVuIDI2LCAyMDI1LCBhdCAzOjUx4oCvUE0sIE5laWxCcm93biA8bmVpbEBicm93
bi5uYW1lPiB3cm90ZToNCg0KWy4uLl0NCg0KPj4gVW5mb3J0dW5hdGVseSwgdGhlIEJQRiB1c2Ug
Y2FzZSBpcyBtb3JlIGNvbXBsaWNhdGVkLiBJbiBzb21lIGNhc2VzLCANCj4+IHRoZSBjYWxsYmFj
ayBmdW5jdGlvbiBjYW5ub3QgYmUgY2FsbCBpbiByY3UgY3JpdGljYWwgc2VjdGlvbnMuIEZvciAN
Cj4+IGV4YW1wbGUsIHRoZSBjYWxsYmFjayBtYXkgbmVlZCB0byByZWFkIHhhdHRlci4gRm9yIHRo
ZXNlIGNhc2VzLCB3ZQ0KPj4gd2UgY2Fubm90IHVzZSBSQ1Ugd2FsayBhdCBhbGwuDQo+IA0KPiBJ
IHJlYWxseSB0aGluayB5b3Ugc2hvdWxkIHN0b3AgdXNpbmcgdGhlIHRlcm1zIFJDVSB3YWxrIGFu
ZCByZWYtd2Fsay4gIEkNCj4gdGhpbmsgdGhleSBtaWdodCBiZSBmb2N1c2luZyB5b3VyIHRoaW5r
aW5nIGluIGFuIHVuaGVscGZ1bCBkaXJlY3Rpb24uDQo+IA0KPiBUaGUga2V5IGlzc3VlIGFib3V0
IHJlYWRpbmcgeGF0dHJzIGlzIHRoYXQgaXQgbWlnaHQgbmVlZCB0byBzbGVlcC4NCj4gRm9jdXNp
bmcgb24gd2hhdCBtaWdodCBuZWVkIHRvIHNsZWVwIGFuZCB3aGF0IHdpbGwgbmV2ZXIgbmVlZCB0
byBzbGVlcA0KPiBpcyBhIHVzZWZ1bCBhcHByb2FjaCAtIHRoZSBkaXN0aW5jdGlvbiBpcyB3aWRl
IHNwcmVhZCBpbiB0aGUga2VybmVsIGFuZA0KPiBzZXZlcmFsIGZ1bmN0aW9uIHRha2UgYSBmbGFn
IGluZGljYXRpbmcgaWYgdGhleSBhcmUgcGVybWl0dGVkIHRvIHNsZWVwLA0KPiBvciBpZiBmYWls
dXJlIHdoZW4gc2xlZXBpbmcgd291bGQgYmUgcmVxdWlyZWQuDQo+IA0KPiBTbyB5b3VyIGFib3Zl
IG9ic2VydmF0aW9uIGlzIGJldHRlciBkZXNjcmliZWQgYXMgDQo+IA0KPiAgIFRoZSB2ZnNfd2Fs
a19hbmNlc3RvcnMoKSBBUEkgaGFzIGFuIChpbXBsaWNpdCkgcmVxdWlyZW1lbnQgdGhhdCB0aGUN
Cj4gICBjYWxsYmFjayBtdXN0bid0IHNsZWVwLiAgVGhpcyBpcyBhIHByb2JsZW0gZm9yIHNvbWUg
dXNlLWNhc2VzDQo+ICAgd2hlcmUgdGhlIGNhbGwgYmFjayBtaWdodCBuZWVkIHRvIHNsZWVwIC0g
ZS5nLiBmb3IgYWNjZXNzaW5nIHhhdHRycy4NCj4gDQo+IFRoYXQgaXMgYSBnb29kIGFuZCB1c2Vm
dWwgb2JzZXJ2YXRpb24uICBJIGNhbiBzZWUgdGhyZWUgcG9zc2libHkNCj4gcmVzcG9uc2VzOg0K
PiANCj4gMS8gQWRkIGEgdmZzX3dhbGtfYW5jZXN0b3JzX21heXNsZWVwKCkgQVBJIGZvciB3aGlj
aCB0aGUgY2FsbGJhY2sgaXMNCj4gICBhbHdheXMgYWxsb3dlZCB0byBzbGVlcC4gIEkgZG9uJ3Qg
cGFydGljdWxhcmx5IGxpa2UgdGhpcyBhcHByb2FjaC4NCj4gDQo+IDIvIFVzZSByZXBlYXRlZCBj
YWxscyB0byB2ZnNfd2Fsa19wYXJlbnQoKSB3aGVuIHRoZSBoYW5kbGluZyBvZiBlYWNoDQo+ICAg
YW5jZXN0b3IgbWlnaHQgbmVlZCB0byBzbGVlcC4gIEkgc2VlIG5vIHByb2JsZW0gd2l0aCBzdXBw
b3J0aW5nIGJvdGgNCj4gICB2ZnNfd2Fsa19hbmNlc3RvcnMoKSBhbmQgdmZzX3dhbGtfcGFyZW50
KCkuICBUaGVyZSBpcyBwbGVudHkgb2YNCj4gICBwcmVjZWRlbnQgZm9yIGhhdmluZyBkaWZmZXJl
bnQgIGludGVyZmFjZXMgZm9yIGRpZmZlcmVudCB1c2UgY2FzZXMuDQoNCkkgcHJlZmVyIG9wdGlv
biAyLiANCg0KPiANCj4gMy8gRXh0ZW5kIHZmc193YWxrX2FuY2VzdG9ycygpIHRvIHBhc3MgYSAi
bWF5IHNsZWVwIiBmbGFnIHRvIHRoZSBjYWxsYmFjay4NCj4gICBJZiB0aGUgY2FsbGJhY2sgZmlu
ZHMgdGhhdCBpdCBuZWVkcyB0byBzbGVlcCBidXQgdGhhdCAibWF5IHNsZWVwIg0KPiAgIGlzbid0
IHNldCwgaXQgcmV0dXJucyBzb21lIHdlbGwga25vd24gc3RhdHVzLCBsaWtlIC1FV09VTERCTE9D
SyAob3INCj4gICAtRUNISUxEKS4gIEl0IGNhbiBleHBlY3QgdG8gYmUgY2FsbGVkIGFnYWluIGJ1
dCB3aXRoICJtYXkgc2xlZXAiIHNldC4NCj4gICBUaGlzIGlzIG15IHByZWZlcnJlZCBhcHByb2Fj
aC4gVGhlcmUgaXMgcHJlY2VkZW50IHdpdGggdGhlDQo+ICAgZF9yZXZhbGlkYXRlIGNhbGxiYWNr
cyB3aGljaCB3b3JrcyBsaWtlIHRoaXMuDQo+ICAgSSBzdXNwZWN0IHRoYXQgYWNjZXNzaW5nIHhh
dHRycyBtaWdodCBvZnRlbiBiZSBwb3NzaWJsZSB3aXRob3V0DQo+ICAgc2xlZXBpbmcuICBJdCBp
cyBjb25jZWl2YWJsZSB0aGF0IHdlIGNvdWxkIGFkZCBhICJtYXkgc2xlZXAiIGFyZ3VtZW50DQo+
ICAgdG8gdmZzX2dldHhhdHRyKCkgc28gdGhhdCBpdCBjb3VsZCBzdGlsbCBvZnRlbiBiZSB1c2Vk
IHdpdGhvdXQNCj4gICByZXF1aXJpbmcgdmZzX3dhbGtfYW5jZXN0b3JzKCkgdG8gcGVybWl0IHNs
ZWVwaW5nLg0KPiAgIFRoaXMgd291bGQgYWxtb3N0IGNlcnRhaW5seSByZXF1aXJlIGEgY2xlYXIg
ZGVtb25zdHJhdGlvbiB0aGF0IA0KPiAgIHRoZXJlIHdhcyBhIHBlcmZvcm1hbmNlIGNvc3QgaW4g
bm90IGhhdmluZyB0aGUgb3B0aW9uIG9mIG5vbi1zbGVlcGluZw0KPiAgIHZmc19nZXR4YXR0cigp
Lg0KDQpGb3IgYnVpbHQtaW4ga2VybmVsIGNvZGUsIEkgY2FuIHNlZSB0aGlzIHdvcmtzLiBIb3dl
dmVyLCBJIGRvbuKAmXQgc2VlIA0Kd2h5IGl0IGlzIG5lY2Vzc2FyeSB0byBpbnRyb2R1Y2UgdGhl
IGV4dHJhIGNvbXBsZXhpdHkgb2YgLUVXT1VMREJMT0NLLCANCmFuZCB2ZnNfZ2V0X3hhdHRyX2Nh
bm5vdF9zbGVlcCwgZXRjLiBBIHNlcGFyYXRlIHN0ZXAtYnktc3RlcCB3YWxraW5nDQpBUEkgaXMg
bXVjaCBjbGVhbmVyLg0KDQo+IA0KPj4+IEkgc3Ryb25nbHkgc3VnZ2VzdCB5b3Ugc3RvcCB0aGlu
a2luZyBhYm91dCByY3Utd2FsayB2cyByZWYtd2Fsay4gIFRoaW5rDQo+Pj4gYWJvdXQgdGhlIG5l
ZWRzIG9mIHlvdXIgY29kZS4gIElmIHlvdSBuZWVkIGEgaGlnaC1wZXJmb3JtYW5jZSBBUEksIHRo
ZW4NCj4+PiBhc2sgZm9yIGEgaGlnaC1wZXJmb3JtYW5jZSBBUEksIGRvbid0IGFzc3VtZSB3aGF0
IGZvcm0gaXQgd2lsbCB0YWtlIG9yDQo+Pj4gd2hhdCB0aGUgaW50ZXJuYWwgaW1wbGVtZW50YXRp
b24gZGV0YWlscyB3aWxsIGJlLg0KPj4gDQo+PiBBdCB0aGUgbW9tZW50LCB3ZSBuZWVkIGEgcmVm
LXdhbGsgQVBJIG9uIHRoZSBCUEYgc2lkZS4gVGhlIFJDVSB3YWxrDQo+PiBpcyBhIHRvdGFsbHkg
c2VwYXJhdGUgdG9waWMuDQo+IA0KPiBEbyB5b3UgbWVhbiAid2UgbmVlZCBzdGVwLWJ5LXN0ZXAg
d2Fsa2luZyIgb3IgZG8geW91IG1lYW4gIndlIG5lZWQgdG8NCj4gcG90ZW50aWFsbHkgc2xlZXAg
Zm9yIGVhY2ggYW5jZXN0b3IiPyAgVGhlc2UgYXJlIGNvbmNlcHR1YWxseSBkaWZmZXJlbnQNCj4g
cmVxdWlyZW1lbnRzLCBidXQgSSBjYW5ub3QgdGVsbCB3aGljaCB5b3UgbWVhbiB3aGVuIHlvdSB0
YWxrIGFib3V0ICJSQ1UNCj4gd2Fsa+KAnS4NCg0KVG8gYmUgZXh0cmEgY2xlYXIsIEkgbWVhbiB3
ZSBuZWVkICJzdGVwLWJ5LXN0ZXAgYW5kIA0KdGFrZS1yZWZlcmVuY2Utb24tZWFjaC1zdGVwIHdh
bGtpbmfigJ0sIGZvciBleGlzdGluZyB1c2UgY2FzZXMuIA0KDQpJbiB0aGUgZnV0dXJlLCBpZiBp
dCBpcyBwb3NzaWJsZSB0byBoYXZlIGEg4oCcZG8tbm90LXRha2UtcmVmZXJlbmNlLCANCmNhbm5v
dC1zbGVlcCwgY2FsbGJhY2stYmFzZWQgd2Fsa2luZ+KAnS4gV2UgbWF5IHRyeSB0byB1c2UgdGhh
dCBmb3IgDQpzb21lIHVzZSBjYXNlcy4gQnV0IHRoYXQgd29u4oCZdCByZXBsYWNlIHN0ZXAtYnkt
c3RlcCB3YWxraW5nIGZvciANCmFsbCB1c2Vycy4gDQoNClRoYW5rcywNClNvbmcNCg0KDQo=

