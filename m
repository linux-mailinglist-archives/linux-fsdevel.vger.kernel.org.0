Return-Path: <linux-fsdevel+bounces-39347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D2AA130DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 02:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7DCB18881D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 01:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32C73D97A;
	Thu, 16 Jan 2025 01:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kcnY7Mx3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC7E70803;
	Thu, 16 Jan 2025 01:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736991531; cv=fail; b=WC7CJbhVI7LaLAtuyKHPfJ7d9piTj9NJog5Oqr+80dSU+p1H2xs5NvLSmo24wGv3Jq3eaWSNmV9jXhFbEDaZf/t9OL7mmUNXNnhLROs0ZgXJZ/+honVHELLpFAudu/AJlDYhGsjDnqZ+ZifaZfzMDaz0pP8qB7NKqkg85yG3ydc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736991531; c=relaxed/simple;
	bh=qsz7GbjQ5uus+zf8xldWFxC/Rpde/I8NeHPy29b0BbA=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Cb9BzQodJGtSGFzmPiIOC+Wpgod0LR+q6CxTXQdISrVgUBRcSi5HJY9U2PowrU3s2U9bDAxFTzYPik01Nzzsf3tpNTCu2aYGPllNZJ/GhFetGvpVvLK1Bi5pfAhrsdwOeixzM/h9G3S23qobm0BbukcvHvs3oXjldkib1BBcqj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kcnY7Mx3; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHX968001157;
	Thu, 16 Jan 2025 01:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=qsz7GbjQ5uus+zf8xldWFxC/Rpde/I8NeHPy29b0BbA=; b=kcnY7Mx3
	64RuSTEz1Yg2wVqL9re1+Ccniqpvt5LycRrD+xitTHSWtZXQ9DmL+TZ9lsXri7f0
	3s7OTd9hTNrzmmS7R1MFLu2WaJEdpj2gsn7+W/qNU55ohb3HUH8gGRxxFrsrsN4O
	2wxGLZHdrPl7B+PItDhoExQ8EW+MAHGysoSCl03dVwscwzNM1IejlTrMoR7nR1As
	rZp+tnaeIUgeZF7GHONoBzUsdCpBCL/gICDQuAncIqgSW5UNeFJ8gsz/ZajJtwwc
	yhYzwEZwJe2EVDm30gjz0MSJOvq/7Q/0tn1q/YSekZKL4MJadYjRb3ZV585D6GHP
	KIGWIqmJXY2uRw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4465gbweyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 01:38:44 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50G1XVPJ030000;
	Thu, 16 Jan 2025 01:38:43 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4465gbweys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 01:38:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjuNr++7txrCNHiBj33R6j35eRAuTMiEzcpOmG84Mh7HIXEFFWYTJdtmBC41rsPSoAjLTK3CLE3xsxhE1o9M4QJ+/GTh/khcehoKXU/YUCn3P6tfsHlHxaR8nYQMmYeH1MO+H9RaKCVTLKyhoyIibLZgX3qy+SLUJ/HTrlQieWdLFFgmGFtxc/A/jXa61F13sJjUc7mJ4E4uY+z0mjDMkvo8Lwh5JMXguDy1AaOAgLf6yelkUoGRYHy6P8dKsgL7//LNkDlvOD8eWsPR/C9tp2tEPLpK4ZjFDer72SQQRSlxl6b12G8p4vUQElfeRtnV/SXdXx8wPmFvVK5lMUyjog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsz7GbjQ5uus+zf8xldWFxC/Rpde/I8NeHPy29b0BbA=;
 b=gCgRnv/Y6oafksiID26S+uhY6sgtUHx8VNQlmqXy3iSHDqzm+/rZBi63ThfSRhoawqXJnCTsUxgIFDxGxIgpcft7ayzPEr5e6nVO6JYEYG+mDsB27oUMeWp+OG5axm4O95elABDOr1dUF6+96gdyazPYOHWe9JUiqT8D6xz5cODG1Fx8zEuvPz9eRIF5R/Emh2SOTiEyKnPSJFDO/ZgIm6oLSUf8Rc8yogIEqfi0TQNSq27DAEY4xQrORaQCP3BoUtA6jrL08PbcKQj9NNK/3wXfqNv+OgI81FsRBDWy6MzjPKIjDjbyl4ucu52kPrGVNgmmky+bJJtdkNvmDoZUJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB5710.namprd15.prod.outlook.com (2603:10b6:510:288::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 01:38:41 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 01:38:41 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>
Thread-Topic: [EXTERNAL] Re: [RFC PATCH] ceph: switch libceph on ratelimited
 messages
Thread-Index: AQHbZ4+Lh4ByCy9ZIUKHf70rtFzBb7MYeV+AgAAmO4A=
Date: Thu, 16 Jan 2025 01:38:40 +0000
Message-ID: <67ab883da6c54de228f133f06dbd32426573aacc.camel@ibm.com>
References: <06b84c0f4c7c86881d5985f391f6d0daa9ee28dd.camel@ibm.com>
	 <CAOi1vP9A2MT2iaDGny0FY9cwxEN1Lvknemgxw1fL6PtYcsvqww@mail.gmail.com>
In-Reply-To:
 <CAOi1vP9A2MT2iaDGny0FY9cwxEN1Lvknemgxw1fL6PtYcsvqww@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB5710:EE_
x-ms-office365-filtering-correlation-id: c40a1382-da01-48f4-8c4e-08dd35ce818e
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V1VRR2kra2JOMkVCRTNoQWN5NFpwaitzVGF2RUt1a1JrajdrcGhkcGgycWRS?=
 =?utf-8?B?OHNzcC9icWJLcFlaQlB1NVFvSTJYR1BwSEdlL2MrT1NPM2M4d3dKWmNacHpl?=
 =?utf-8?B?NThEbFovcWJHVnNUdjI2bG5Ya1F1aWV2OCtaOE5GTk9iUUI0cStIRVVqTXZT?=
 =?utf-8?B?cVpJblQ0ZTg5OEpYejhOZUdyOUFNWlRFM0pBa0t5VGFjdGxMdnNDYTdsVzd4?=
 =?utf-8?B?MzE1L0NqblNmMEhYeEsxb1VNeFFvcWg4RHRJRm5qc3d3SnVDUU1Rc3F0dEZM?=
 =?utf-8?B?VkRybUpUMm1NeFVsTmhqOW84SkpETFJEeDN6ZkNnVlZMSHdoNXVoM25ET0Vo?=
 =?utf-8?B?RmU2T1hvMTlTamkvWTVTUXpDdTV0VGkrL1lOQWxwK2Qyb2wveW1PQ0YzcVd4?=
 =?utf-8?B?cHhHZk4xSTJzRlBJR1dpY29SUzc1RnNvZ3FtRkdmSVFrV0MxbmlKQy8zeVhl?=
 =?utf-8?B?TlFyL0I5U3JmQzVyUHNuMW9Cem1Yb3F6TUdiL1p1RVBPU0RMa1JkbkFEYUU1?=
 =?utf-8?B?c1E1NnVWbms2aTNjN3E1S29WV0p4eVd1VFB3dEZtV3FxRTBkTGJUakcraThu?=
 =?utf-8?B?RW1iUVFxMkRhT28zaGMyZlZta25yUTBhdXJ5V3VPQmF5bmZVZHQ0cjV5NWZS?=
 =?utf-8?B?SHZPMmVZa3BDdXlpOXg5ZUxJWWg2ZTViOS9TL3lZZW93Q0MxOXIrMDdFMG50?=
 =?utf-8?B?STZoRDYyVGpvaGtmS2hsSWJwcUFzcUFMZkh1Y1JFOGMweGtGTzZmLzFRcGIr?=
 =?utf-8?B?R3MreVdHMXdoK0JOL1FzS1QwbmNoNWd4a2kxT2pYWGtJN2pCVFhINU1lays4?=
 =?utf-8?B?SmVyVkxaanU5N3dMYjhaSjdJM2lGb0d6NFhqOW1xei8wZ0hMTGdONHZSd1Nq?=
 =?utf-8?B?QzE3ZUJzSEN4Z21ndUc3MklnZHBySlRUM3dnd0lFL0NzVStuR1pmbTVrU1ZS?=
 =?utf-8?B?aEVSZ0ZZOFo0bnltbFNEVHBvOGVmZlJlcXVkRFNCY1FUc3c0OUpocitQQVV6?=
 =?utf-8?B?YjJEM25sVHFHQjU1UGptS003VVd5MmRFTTNyeTIrNm9pZDE4QWg4RVk2OVBH?=
 =?utf-8?B?YjRoZjhyQlpuMGhUWG92L0VHK2RiYmhDL3ltM0FtakNBM2wvbWhFcjBYTjE3?=
 =?utf-8?B?bWM3NHlPalBvWkRiWFlmS3BDbWZIaGZhS3hpZHE0MmxhbGFEeGhsSzU2YmZ3?=
 =?utf-8?B?dGNRUk92ZDIrU3pBRVZBaUtjYld1WUM1YkxSRUJqSE1Db3UxRllYM3YvaHM3?=
 =?utf-8?B?SStPaHE2TDJ6MVB5Nmxob2xlUFJ4N2JoNWpxZ2ZyQi9BcmNXaDJncWtWcEpE?=
 =?utf-8?B?VkI2MGVHTFdSTFQzckNqV240bHRtMUY4UTBSRHNHZE40eUVXWmVNeGxUQ3hW?=
 =?utf-8?B?OFU2a2pJb05wMVBKZzd5NE9HVUgvMDNyYmVQaENuMkxJM2hPS2w2QXpJajRs?=
 =?utf-8?B?eDZTK04xQ3ZzN3hLRlhtbE53M3I3bHFMZjZMZmNEV010WUJvTW4wb1ZFRVQz?=
 =?utf-8?B?b1lBT21RanFndUNYRjZrSElPbHZRV3BtNUZzWU9MTGJyWlh0UWJLdGxjVzVU?=
 =?utf-8?B?cmRaeDRYUFpzS2NxMzNQU2JWajRtalQrbWwxS01CeTFVVUNsdXhWMXp1b0NZ?=
 =?utf-8?B?b0JkN0QyQW5EeW1JbG5xZkNRREt3VVJjOEtTM0hZNmJHRm92OFFvRk84Tk0x?=
 =?utf-8?B?SzRZS0toRWllaWFNdkppQWlJbWNwbGJDc2Z6bGpIam9ZWTRpVnZVK2NUem1z?=
 =?utf-8?B?dEIrUjA3WHVCMVJpYlFvdERsYzJMV3NlQkx3OUwvUllEMzRiTUxFV1hSR0dB?=
 =?utf-8?B?Yzh5enVaeXFPQjdCVkRsVm1QYi83L2xXRjZNYmRnVFdVTUhvOWxEanVWblpC?=
 =?utf-8?B?ck9ZSmVkUzNVNnc3dnNEZjRmdUJJL1NuZFAyNUFnbzhxMlgrcmNkSEpRdkxP?=
 =?utf-8?Q?p+3k2nPdT+kfbf8IitunNxb64FJCkgjV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RlhmUUpwcGFKM3Bjd1M3Rlh2NlhZK2Q4Q01rQjZRUTRjbU04VWJhLzVnT1lW?=
 =?utf-8?B?bjJ6bWZCWlVpYXBXclRGcDJiQi9uV25pNFZQWDJvTy91K0ZkSTdmS0dBZ3h5?=
 =?utf-8?B?YTA3dmZPTFVSLzZ2T0JrWjZRZWRRbXNYRGhBV1l4MEVpQ0h5N1FuNzY3NWtj?=
 =?utf-8?B?R0VCbnhYT28wWWhZbUVqVVl1dTNZOWo0eHpWWno3SGpyWGEyOXljcmEzNnRI?=
 =?utf-8?B?OHgrRkErU3MyYjJOQU94LzIwclpEVDVUY0p6NW5vbTZLKzZYR0IvUm40ZWw4?=
 =?utf-8?B?eFRudmY4ZWhMTzFvdmxsMDVOTDJoU1JUclU3eFJtajZ3bjc3TVFCYUdUWUJ3?=
 =?utf-8?B?NjdxNXlFR2NzdFhKQWc0eXhRYXRVTUpnT1pmMGEzOWs0QVl4b2VSODZGSlNk?=
 =?utf-8?B?ZkVDaXRXSFVzdDlRckpmMFcwSExHeUNTclE2UUZiYlM5VlpNZXh6MGJJUTly?=
 =?utf-8?B?d3JHbnFhUTFlVDl4cjZiWW5BcERXcGpIWUZQN3Eyb3NvN1pQM2JrRnBKc3VH?=
 =?utf-8?B?OUdhOXZrVzFuTEN1N3dtU05rWVlvbmIyNjd3VGZDUDVtT0FMU3NFSUN1Q3NZ?=
 =?utf-8?B?OWFSZFdzUjV3UjZDVkFEK0VWYVZtSUJDbWFKWWJEMnh2K09LVUN5bTlhZ2ox?=
 =?utf-8?B?blNzRmdweDgvOGljcU5rcXRYRUMyUTE1UHZ1RG1CRVZsSTZJNDQ0L2dXRmtX?=
 =?utf-8?B?VVJSYVA1cjJNNjE5ZEpXSXgzR0I4cTJ2TThacGNNVzlsU0pvVmNXcytmMDdK?=
 =?utf-8?B?bTNMMll6aVRTZ215NUR5R3hHWTVXYTQwZk5zeWloMlJXbUVUeEYvek0vYWh4?=
 =?utf-8?B?U1FCQ0tCZ1luVCtra2NUTStQRnRDaEQ0dEtvUDhIdnpKVDhkajJ1UjVWT2Rq?=
 =?utf-8?B?ZEJOb3FIZkhobTJFSC9vcUIzOEUyOHp3c21sS0dJcFFBWUdTWmdBdHJYVDhN?=
 =?utf-8?B?YXBVQVp0VXJJOEc3a2RUOW4xUkVoenlxUmg3dWx6NUZ4NU8rQ0hqZndLdUVI?=
 =?utf-8?B?MnlGR1RPT1JFaWR6bTlVQVVveG45OGxzQVhUSG5EaWRFSWtiRjFqQ0pvZzRD?=
 =?utf-8?B?dDR1V05XWlprZE9TZTMzMUJ6dm16eE1jRmlRSkY0UnI3ZVAzaEVTQWFGUzQy?=
 =?utf-8?B?WEdueXVGY2oxbEJsVXVYS0RrWUNXMHhreUtvTHJTZDBDSWpnUk13ZjdzSU15?=
 =?utf-8?B?Q3pITy8rTnROZkpEdldxNXo2MGZQbXNXVFFhSllMaTdQNm83NVNJOVJ6YXJu?=
 =?utf-8?B?UHJUK253bFBhalJxYkFsU3pTei9IQWVleEcvQ0QrSzFUbGxwVlpSSm9leENo?=
 =?utf-8?B?QXRhbEtFS2lLaU5jdlNCcURXa2w0WXJQSjJCeDVFN085cXZDUk5aTVZaUTFY?=
 =?utf-8?B?VmlIVytXL05acUs4ZHdLUGhjY3puUUdMd3gvUDMyYlAzWGVrejJQMXFNeCtO?=
 =?utf-8?B?MlRBUjRNM2IzU0hmVEVXMTA5NTU5VzZZc0ErSlB6SHJRVkRVS3NpSjc1dGJS?=
 =?utf-8?B?UzJqbFYrb0owNVA2Qks5YjNncGRodmtHNTlIblBhL1kxYXhzOEpSL0RRVmhE?=
 =?utf-8?B?alcyemhXbGtkTysrSFA2Mk5ZN0wrQ1FiK0s2M1VSODVPdE8yZ0pydW5GZ0lj?=
 =?utf-8?B?ekRnbTBCMmV3ODFBUUZ2OE92L2RpMlV2MW1ZenNkNWxURnRDaUdnQW1FbDFn?=
 =?utf-8?B?OXJBa3grbnFxQUNzbjkvUVYvQUU4OTl1MlNjQytLYjVjM0FNbHZQdmYxZ3pm?=
 =?utf-8?B?YXlJdDlFRHAvYUNmcTdUK0dwalpUZFJLRUY4c3VSSTJmNTlqNGJocTFLN2dH?=
 =?utf-8?B?eGtGNHc0bnRZYmN3VzlRcHdldzVhU3A0UUZPSWpOaUxiUjBsdkNCYVRjWERj?=
 =?utf-8?B?TmVCUVY4c3BlRUsvZ2V1U2xVcW5vc3J3dWR5c2t2bXIydFI1Q1kvSWJvWHk4?=
 =?utf-8?B?NGZ4Z0s1VkpnTUFUSytaa2dxZFZpejJRMldkRlN2TkUrYWNDQmhEcjJFRTIw?=
 =?utf-8?B?WGhFSGd6V3oxK3FEZ1p4QVgwekxSeVMwdXNha1JHWE5nYnIrNmhmV1NHWHZN?=
 =?utf-8?B?WjJSTDRpcGhJcXUxR0x5YVdHemJIUStIY3liL3pVUGtGSnJzbXQzcCtJSlVO?=
 =?utf-8?B?ZUpPWmduT0NaK1FmalpJRlVmK3BZMC9wM3pQVEZaZUtLbmhWc2FVLy9mN0hq?=
 =?utf-8?Q?Pa+iAuPw7p11sPy/zLMJ/P4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A25C2F7E2AFDB94F9D9932A4876F42B9@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c40a1382-da01-48f4-8c4e-08dd35ce818e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2025 01:38:40.9344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MuTW5OvHacdAfBxXxWqDPMWuvxbDe/4FD+9HKl+9Zzl+tsIxuVW9+PHgYI+LDqQNJfi2qHjiTKXlZH7wh/byfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5710
X-Proofpoint-GUID: zQlTZBmIhHGLG70i_0g86lwr0ECQCBUn
X-Proofpoint-ORIG-GUID: SCYREmF66wXDszNURUT7d7aMUHxWtbYG
Subject: RE: [RFC PATCH] ceph: switch libceph on ratelimited messages
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_11,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501160009

SGkgSWx5YSwNCg0KT24gVGh1LCAyMDI1LTAxLTE2IGF0IDAwOjIxICswMTAwLCBJbHlhIERyeW9t
b3Ygd3JvdGU6DQo+IE9uIFdlZCwgSmFuIDE1LCAyMDI1IGF0IDk6NTPigK9QTSBWaWFjaGVzbGF2
IER1YmV5a28NCj4gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gSGVs
bG8sDQo+ID4gDQo+ID4gVGhlIGxpYmNlcGggc3Vic3lzdGVtIGNhbiBnZW5lcmF0ZSBlbm91cm1v
dXMgYW1vdW50IG9mDQo+ID4gbWVzc2FnZXMgaW4gdGhlIGNhc2Ugb2YgZXJyb3IuIEFzIGEgcmVz
dWx0LCBzeXN0ZW0gbG9nDQo+ID4gY2FuIGJlIHVucmVhc29uYWJseSBiaWcgYmVjYXVzZSBvZiBz
dWNoIG1lc3NhZ2luZw0KPiA+IHBvbGljeS4gVGhpcyBwYXRjaCBzd2l0Y2hlcyBvbiByYXRlbGlt
aXRlZCB2ZXJzaW9uIG9mDQo+IA0KPiBIaSBTbGF2YSwNCj4gDQo+IERvIHlvdSBoYXZlIGFuIGV4
YW1wbGUgKHdoaWNoIGlzIG5vdCBjYXVzZWQgYnkgYSBwcm9ncmFtbWluZyBlcnJvcik/DQo+IA0K
DQpGcmFua2x5IHNwZWFraW5nLCB0aGVyZSBpcyBubyBzdGFibGUgZ3JvdW5kIGZvciBkZWZpbml0
aW9uDQp3aGF0IGlzIHRoZSBwcm9ncmFtbWluZyBlcnJvci4gOikgQW5kIGlmIGVuZC11c2VyIGNh
biBzZWUNCnNvbWUgbWVzc2FnZXMgaW4gdGhlIHN5c3RlbSBsb2csIHRoZW4gaXQncyBub3QgYWx3
YXlzIGNsZWFyDQp3aGF0IGlzIHRoZSByZWFzb24gb2YgaXQgKGZhdWx0eSBoYXJkd2FyZSwgd3Jv
bmcgY29uZmlndXJhdGlvbiwNCm5ldHdvcmsgaXNzdWUsIG9yIHByb2dyYW1taW5nIGVycm9yKS4N
Cg0KQ3VycmVudGx5LCBJIGNhbiBzZWUgZHVyaW5nIHJ1bm5pbmcgeGZzdGVzdHMgc29tZSBzcG9y
YWRpY2FsbHkNCnRyaWdnZXJlZCBpc3N1ZXMgKGFuZCBJIGFtIGdvaW5nIHRvIGludmVzdGlnYXRl
IHRoaXMpLiBGb3IgZXhhbXBsZSwNCnRvZGF5IEkgY2FuIHJlcHJvZHVjZSBpdCBmb3IgZ2VuZXJp
Yy8xMjcgKGJ1dCBpdCBwYXNzZWQgc3VjY2Vzc2Z1bGx5DQptdWx0aXBsZSB0aW1lcyBiZWZvcmUp
LiBUaGUgb3V0cHV0IG9mIHRoaXMgaXNzdWUgaXMgdGhlIGluZmluaXRlDQpzZXF1ZW5jZSBvZiBt
ZXNzYWdlcyBpbiB0aGUgc3lzdGVtIGxvZzoNCg0KSmFuIDE1IDE2OjM5OjA2IGNlcGgtdGVzdGlu
Zy0wMDAxIGtlcm5lbDogWyA0MzQ1LjE2NDI5OV0gbGliY2VwaDogbW9uMg0KKDIpMTI3LjAuMC4x
OjQwOTAyIHNvY2tldCBlcnJvciBvbiB3cml0ZQ0KSmFuIDE1IDE2OjM5OjA2IGNlcGgtdGVzdGlu
Zy0wMDAxIGtlcm5lbDogWyA0MzQ1LjE2NDMyMV0gbGliY2VwaDogbW9uMQ0KKDIpMTI3LjAuMC4x
OjQwOTAwIHNvY2tldCBlcnJvciBvbiB3cml0ZQ0KSmFuIDE1IDE2OjM5OjA2IGNlcGgtdGVzdGlu
Zy0wMDAxIGtlcm5lbDogWyA0MzQ1LjY2ODMxNF0gbGliY2VwaDogbW9uMQ0KKDIpMTI3LjAuMC4x
OjQwOTAwIHNvY2tldCBlcnJvciBvbiB3cml0ZQ0KSmFuIDE1IDE2OjM5OjA2IGNlcGgtdGVzdGlu
Zy0wMDAxIGtlcm5lbDogWyA0MzQ1LjY2ODMzN10gbGliY2VwaDogbW9uMg0KKDIpMTI3LjAuMC4x
OjQwOTAyIHNvY2tldCBlcnJvciBvbiB3cml0ZQ0KSmFuIDE1IDE2OjM5OjA3IGNlcGgtdGVzdGlu
Zy0wMDAxIGtlcm5lbDogWyA0MzQ2LjY2MDM3MV0gbGliY2VwaDogbW9uMg0KKDIpMTI3LjAuMC4x
OjQwOTAyIHNvY2tldCBlcnJvciBvbiB3cml0ZQ0KDQo8c2tpcHBlZD4NCg0KSmFuIDE1IDE3OjE2
OjMwIGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyA2NTg5LjY5MTMwM10gbGliY2VwaDogbW9u
Mg0KKDIpMTI3LjAuMC4xOjQwOTAyIHNvY2tldCBlcnJvciBvbiB3cml0ZQ0KSmFuIDE1IDE3OjE2
OjMxIGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyA2NTkwLjkwNzM5Nl0gbGliY2VwaDogb3Nk
MQ0KKDIpMTI3LjAuMC4xOjY4MTAgc29ja2V0IGVycm9yIG9uIHdyaXRlDQpKYW4gMTUgMTc6MTY6
MzQgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVsOiBbIDY1OTMuNjU5MzcwXSBsaWJjZXBoOiBtb24y
DQooMikxMjcuMC4wLjE6NDA5MDIgc29ja2V0IGVycm9yIG9uIHdyaXRlDQpKYW4gMTUgMTc6MTY6
MzcgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVsOiBbIDY1OTcuMDUxNDYxXSBsaWJjZXBoOiBtb24y
DQooMikxMjcuMC4wLjE6NDA5MDIgc29ja2V0IGVycm9yIG9uIHdyaXRlDQoNCjxjb250aW51ZSB0
byBzcGFtIHN5c3RlbSBsb2cgdW50aWwgdGhlIHN5c3RlbSByZXN0YXJ0Pg0KDQo+ID4gcHJfbm90
aWNlKCksIHByX2luZm8oKSwgcHJfd2FybigpLCBhbmQgcHJfZXJyKCkNCj4gPiBtZXRob2RzIGJ5
IG1lYW5zIG9mIGludHJvZHVjaW5nIGxpYmNlcGhfbm90aWNlKCksDQo+ID4gbGliY2VwaF9pbmZv
KCksIGxpYmNlcGhfd2FybigpLCBhbmQgbGliY2VwaF9lcnIoKQ0KPiA+IG1ldGhvZHMuDQo+IA0K
PiBTb21lIG9mIGxpYmNlcGggbWVzc2FnZXMgYXJlIGFscmVhZHkgcmF0ZWxpbWl0ZWQgYW5kIHN0
YW5kYXJkDQo+IHByXypfcmF0ZWxpbWl0ZWQgbWFjcm9zIGFyZSB1c2VkIGZvciB0aGF0LsKgIFRo
ZXkgYXJlIGZldyBhcGFydCwgc28NCj4gaWYgdGhlcmUgaXMgYSBwYXJ0aWN1bGFyIG1lc3NhZ2Ug
dGhhdCBpcyB0b28gc3BhbW15LCBzd2l0Y2hpbmcgaXQgdG8NCj4gYSByYXRlbGltaXRlZCB2ZXJz
aW9uIHNob3VsZG4ndCBiZSBhIHByb2JsZW0sIGJ1dCB3ZSB3b24ndCB0YWtlDQo+IGEgYmxhbmtl
dCBjb252ZXJzaW9uIGxpa2UgdGhpcy4NCj4gDQoNClllcywgSSBhZ3JlZSB0aGF0IGV2ZW4gcmF0
ZWxpbWl0ZWQgdmVyc2lvbiBvZiBtZXNzYWdpbmcgY2Fubm90DQpzb2x2ZSB0aGUgcHJvYmxlbSBv
ZiBzcGFtbWluZyB0aGUgc3lzdGVtIGxvZyBieSBpbmZvLCB3YXJuaW5nLCBvcg0KZXJyb3IgbWVz
c2FnZXMuIEFzIGZhciBhcyBJIGNhbiBzZWUsIHdlIGhhdmUgaW5maW5pdGUgY3ljbGUgaW4NCmxp
YmNlcGggY29yZSBsaWJyYXJ5IHRoYXQgZ2VuZXJhdGVzIHRoaXMgbmV2ZXIgZW5kaW5nIHNlcXVl
bmNlIG9mDQptZXNzYWdlcy4gSSBiZWxpZXZlIHRoYXQgaXQncyBub3QgdXNlci1mcmllbmRseSBi
ZWhhdmlvciBhbmQNCndlIG5lZWQgdG8gcmV3b3JrIGl0IHNvbWVob3cuIEkgc3RpbGwgZG9uJ3Qg
cXVpdGUgZm9sbG93IHdoeSBsaWJjZXBoDQpjb3JlIGxpYnJhcnkncyBsb2dpYyBpcyB0cnlpbmcg
dG8gcmVwZWF0IHRoZSBzYW1lIGFjdGlvbiBhbmQNCnJlcG9ydHMgdGhlIGVycm9yIGlmIHdlIGFs
cmVhZHkgZmFpbGVkLiBDb3VsZCB3ZSByZXdvcmsgaXQgc29tZWhvdz8NCkkgYmVsaWV2ZSB0aGF0
IHdlIGhhdmUgc29tZSB3cm9uZyBsb2dpYyBpbiBjdXJyZW50IGltcGxlbWVudGF0aW9uLg0KDQpJ
IGFtIG5vdCBnb2luZyB0byBpbnNpc3Qgb24gdGhpcyBwYXRjaC4gQnV0LCBmb3IgZXhhbXBsZSwN
CnByX2Vycl9yYXRlbGltaXRlZCgpIGlzIHNsaWdodGx5IGxvbmcgZnVuY3Rpb24gbmFtZSBhbmQN
CmxpYmNlcGhfZXJyKCkgY2FuIGJlIHNob3J0ZXIgbmFtZS4gQWxzbywgdG8gaGF2ZSBsaWJjZXBo
XzxtZXNzYWdlPg0KZmFtaWx5IG9mIG1ldGhvZHMgaW1wbGVtZW50ZWQgaW4gb25lIHBsYWNlIGdp
dmVzIG9wcG9ydHVuaXR5DQpvZiBlYXN5IG1vZGlmaWNhdGlvbiBtZXRob2RzIGluIG9uZSBwbGFj
ZSwgZm9yIGV4YW1wbGUsIHdpdGggdGhlIGdvYWwNCm9mIGFkZGluZyBtb3JlIHVzZWZ1bCBvdXRw
dXQuIEZpbmFsbHksIEkgYmVsaWV2ZSAoYnV0IEkgY291bGQgYmUgd3JvbmcpDQp0byBoYXZlIHRo
ZSByYXRlbGltaXRlZCB2ZXJzaW9uIG9mIG1lc3NhZ2VzIGNvdWxkIHNsaWdodGx5IHByZXZlbnQg
ZnJvbQ0Kc3BhbW1pbmcgdGhlIHN5c3RlbSBsb2cgZm9yIGNhc2VzIHRoYXQgd2UgY2Fubm90IHNl
ZSByaWdodCBub3csIGJ1dA0Kc29tZSBlbmQtdXNlciBjYW4gcmVwcm9kdWNlIGl0IGluIHRoZSBw
cm9kdWN0aW9uLg0KDQpUaGFua3MsDQpTbGF2YS4gDQoNCg==

