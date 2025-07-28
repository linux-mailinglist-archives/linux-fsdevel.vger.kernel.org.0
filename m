Return-Path: <linux-fsdevel+bounces-56148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC75B1413E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 19:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388B23BD17C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 17:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A5E275865;
	Mon, 28 Jul 2025 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JeHId9pR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D9F21ADC9
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753723979; cv=fail; b=dUpynHCzxjSjbfC/CerHqqCRywiwrFgu2no1MWoOOdmO0wOAI6DVjLu6ls6iPlAVLMVtdztbRxTgD2bNwsin/bMbX2yl5qA4tJzwPMcwGiZglG2KKxgrGr5hZYHNtf97BH1NracvocmWJsZrPa5i1MSdCZDW9CXPaDYGqE+cKog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753723979; c=relaxed/simple;
	bh=VrBn7VdkkVyYj3/NuKdQngNC/v/DJev14v/pkFlWDAA=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=kHy1cmupqWQnYo+5Z2VIq3z1kN728ilJvJkL/hymsW0MNK9xb1ZbE3NCoiAcclIqgT0o6E9mThM+i9+NSXQVP7czvg0/yihuvHByn1kbD1jihYFw1KaxL3Co+AxA434qOsU43CbfEvvzUtY7FRKWaAAo4JA1AAM4JaWAD6zuMkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JeHId9pR; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SFo1PE009840
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 17:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=VrBn7VdkkVyYj3/NuKdQngNC/v/DJev14v/pkFlWDAA=; b=JeHId9pR
	dJxIX9tYg9nfe8jghv5GHwVTsV0ypXmTkKIHv6PT3K/Xonlb8ZDqYLvUq6R7JQVp
	ArIU9xU9+q62lsfqv2OD1PlBx8ikqEb7qrLugafqrulJXFjUJebZbOxUetk1VQX2
	iDF10s4f6br/rBZDCXN1LHKAvaGJ8tDNIcrL4vHghyoi8hwLypTu57OuExRZU5Ly
	zSqs8k0dxvOg1vqg59+JWYbn2OWlxZH9Nyhm6IUAoU1EzTwGnX4GUTCvrIG2uzIK
	w1ceA7ju4/5pCDc9wayiTs+JU4fw+ZWiNHZ01Za55C/FzR8YjGVrZSQzNp98KwDm
	DSPOVy8LGsS+jA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 486c6hgewb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 17:32:56 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56SHOSev014883
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 17:32:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 486c6hgew2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 17:32:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsEUXJR9Mc3PsZ4lXioa/InGCmTsaVHDnqDJGdiyxoBKZ1sILf8eWtJk5JTf4rPxtROvFt0SdQiYQSy40N8dsPSI8fsZ1ViM2/3wQ9uXy4rCTenvvYeiJUa0ICjwU0rQMXVgrRR+ZJgi2VRKCthkxH8G/rG4ohbuv5DQg0ZIZ+UTpSWv3N3t3udJyUhXg12KVVrDya9/qHsYHv5MOcNZq1yzIUxobLhyF2qDzRg31ODCDCuSgRvN5bYLnSutOY45yDZFqG1JVgfd5SFCvjwacVOOv2HfMjsNOnjjdqMLU3TqTJAT2Msmje0FduecsVFT4R+ZSUuY12vYVCnE9Ocjwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3Fj+UDIen5MWWCAKKXXsF5HbnWk6YbJOc43fmv1m7I=;
 b=vO426Oi5xTkcYnEGdlAp7gOXNORDwtBLV/dFyM5KUyycONW6WsfGJVckA+PriY7EMI+SNeYLUHeqin+E7Rb/Yi/Gm6Ssc+E0IzUH4spvNCEHWCYv4BQg8qUFZqTIbmfbicKn0GEA4iIdx2HaFUULVNxOukeWnzV7kuZyFTqhVJ7aYLxGt4u1+7U3h+/pXglegYqEijYA8Dr+UPG47wiH4VQxaHJObGn9nsQiPU1tIIPW9+gvM6308zPCh7Yjfd9tJpim0Thu/oq1ixzPHCG7FrbO5So5GAxg7Z7XZmcSTh7gxRBLYy0u5b2+AXiqx/7uuY5ny1UvS5pLBneRhx/LdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB5283.namprd15.prod.outlook.com (2603:10b6:806:23b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 17:32:51 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8880.026; Mon, 28 Jul 2025
 17:32:50 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "huk23@m.fudan.edu.cn" <huk23@m.fudan.edu.cn>,
        "yang.chenzhi@vivo.com"
	<yang.chenzhi@vivo.com>
CC: "slava@dubeyko.com" <slava@dubeyko.com>,
        "frank.li@vivo.com"
	<frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "baishuoran@hrbeu.edu.cn"
	<baishuoran@hrbeu.edu.cn>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "jjtan24@m.fudan.edu.cn"
	<jjtan24@m.fudan.edu.cn>
Thread-Topic: [EXTERNAL] KASAN: slab-out-of-bounds in
 hfsplus_bnode_read+0x268/0x290
Thread-Index: AQHb/5Lo//7v6JwWikmSCVMGLOHcgLRHzCEA
Date: Mon, 28 Jul 2025 17:32:50 +0000
Message-ID: <9aea1fae7574506ec2cd4f4f18d8cd07197e268f.camel@ibm.com>
References: <5703A932-C5B0-4C98-BC5D-133F6E7943B3@m.fudan.edu.cn>
	 <20250728074014.271654-1-yang.chenzhi@vivo.com>
In-Reply-To: <20250728074014.271654-1-yang.chenzhi@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB5283:EE_
x-ms-office365-filtering-correlation-id: 2440bf6c-a352-4142-709a-08ddcdfcc6e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QUlZV2poNnFkWEtjeUJ2RTRkT3hqZ1JrSUdLdjFoODBnOWZmM3p6VTE2cC9j?=
 =?utf-8?B?OHJLa1hoUjhSUVg1eWhUVGRhTitKaE9YOStxUlNzcUhYcGJ1UEV6ZHRKTFM5?=
 =?utf-8?B?UUhhbWRFL1pKd1Ywc242QmpjMTRhTFlCZWpzRGRoSFFXWmlYcjRCZjlLZVEw?=
 =?utf-8?B?bWc0azFLUHFTMzJPOXJaV1o1TCtHMTBwaWJFTzlUU0ozMS82MEFVdjBKSXVm?=
 =?utf-8?B?T1A1NG5lQlpKaWJ1eHg5MDFqZXRaTG12aFVNbTRSOTJPUlYrLzErVk5tYXE1?=
 =?utf-8?B?amZCdmpDbzBiMGVOOStnWmhsREpGdDZ6RkdoR2xEQ05RbkMrenlXVUVPaURx?=
 =?utf-8?B?cVhpcGUxUW5xOWJpc2ljVFoySTNQY0F2bmZ2Zk84MlUwclZwREk0azZIMjMy?=
 =?utf-8?B?YXQ0a3ZMMWlTQ0pQaHJONUk4MlNhU1FhcWhoVVlVSHNJclVRanJCajd0Yldh?=
 =?utf-8?B?N2cxT3F5NkhneDhQd0Q0YVVFK2xld0ZjMXlJd3lmdVYweEFmVmMxMkIzTHlh?=
 =?utf-8?B?WkVkcEZxV1hXNkdmWE5YOHc5eFFsRm5OL1F5bTV0VjBjOXpqeG1la0VaRGlE?=
 =?utf-8?B?WEdwY2ZTaVk1aktMa2l5bGloSWhYMHlzZmtFNE16b0E0MnRKK3FhekVlY1VP?=
 =?utf-8?B?eEo2VTl3L0Rpb3N5aWErUndQZHkyQW1LSUpUckdaMmtOdUdEY25KMTlndnZ3?=
 =?utf-8?B?SjlIVURBYzJQQzFkdUxMVjB1eTVtSU9leEpwRld4dDRrdXAyOEhiQlZvSWps?=
 =?utf-8?B?QWIwam5XM28wUWQ1TDk0L1ZoTEh4RnpObXhyVHJ3aXdBMFh1VUUyeWtjemJQ?=
 =?utf-8?B?ck56UjNjT1JaR1dlcnJ2enkwWkE0eWNhNG9adFg2aXYwaWJ6WklqWXRVMG9G?=
 =?utf-8?B?bHdKUUZwRndObXFhZ0JMUHlRUXJaUTFDRjVzck12RlcydFVSZUliSi82YzMz?=
 =?utf-8?B?aDlibWE0UFcwRGxram56OE9VTjZTQ2luRk5nY2RUT3QwNm5SQmJrVXdXclAz?=
 =?utf-8?B?OGU5a1ZiTFZZcHlDbTJmaXVwdmc1S045TmV6eVRJNUlKZEY3WXZoTWZpVlUr?=
 =?utf-8?B?azQrUyt5eitYNkhtcVFkc3NuTk5kTWtGQkVYUkZGaFYxcUJOOUJOR2JhOVI5?=
 =?utf-8?B?a08xQSs4SDJ3dzJVcVhWc3Q5QkQzKzB2UmFHTjZaQXV0WTV3VURGMmRzNi82?=
 =?utf-8?B?Y1dkMWdOMEg5N1lkUi95VDIyckM1U2FmaE8yeW5sU3ZVVGNHU1FtN05VTk1W?=
 =?utf-8?B?ZlNvSU9Zb2ZhVlc3NCtoVmUxMHhlbHlQT3U5ckRpNUV1Ym5kd0VGTXcyL2tF?=
 =?utf-8?B?aHlUMXNZUUVGaXMrblpNNElLK1dtNXo2dy9NZTF2VHhDcHE2ZkFlTnF5eFMx?=
 =?utf-8?B?K3RrUnJ5RFhzT3huQnBzUWpmbDI5Wk1IM0ZQVFZhRkRIaVd4T0ZjWUhQSktw?=
 =?utf-8?B?RW93SGh2aWo1eUFMTWRjQmtzblN3YXVkeE5uWnNnblpYWTgzTlBTbVFDVVZ2?=
 =?utf-8?B?OFRlMThSYldBQWJiZVNtS1E2UldGVC95WFNna0ZKMmJYZXBxYkxEMnJueDQw?=
 =?utf-8?B?bWI4MGhDT0c3YXNBVjg5YVRUTFFtaTdrMWdMVzZKSGFUaU1ldURCZGQzMWNw?=
 =?utf-8?B?U2lHMnpmMnNHMnVkNHBMMkJxTEc0QWlqTm9ubkhrQ2J6Z0IrMk5od3dxUTky?=
 =?utf-8?B?NmUyMkVVWkpVSVY2QWorZjg4YnJmVk5SNlBINU1RdGZXN1gvZTJ4V3U3UG1z?=
 =?utf-8?B?R2prVS9VaEhuN3VyMkxsWExmd2ppTHM1SnFqNU96MUYzMnhJOXFsaG1QNFo0?=
 =?utf-8?B?TXJoTmoxNXh1SlVGRXcyaVpESHNvWnpScXlNSHBoTWdsdUVNaWo4WitMQmtm?=
 =?utf-8?B?d0VlbTI3MElSTUxXNkFVeVV1WkE5bE5MQXZMLytweG5PQ1ByVmdHZVVYKzMv?=
 =?utf-8?B?TDVZL21LSHdQYTlEWHZsc2FKREo2RnhDa0cxWkF3N1dPRUVoSjlaUEhuSXJX?=
 =?utf-8?Q?lX0zrSDezNTQ9liIusEqDjPRAsrXiw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WUZRbklvbjBiK3J5cEcvQmdETllxNE1FWFZLdW1iRDVMTFpMcndCY1M2d0xN?=
 =?utf-8?B?emlKNDVQUEQwcWRVT0pOSDk5emNIQnJ6M2dDR1M2NmRUWnhyZndNMXpocUY5?=
 =?utf-8?B?NzBsZTlQeFFCOEhGWEo2dW9UcnNPWTQ4UU5xTkpYTWVaQS9yNnE2TFZlelR5?=
 =?utf-8?B?ZS8xTERWbXlkRGZka2tGdE9FWTJpUjBlR1Y4dmtrSnRiQ0VQTVBNZWVqaWVz?=
 =?utf-8?B?L0FCQzhLZThLTUJrUzF5eHNaRWgwYi9ZV2dGNDRKRDZrK0dQdXVTZnVFZ3Vm?=
 =?utf-8?B?MDgzRUpiMDNaM0M5dis1WlJhZGYwZ3J6ZitrNFdnRENEKzZ3WkR2Z0M2ckQv?=
 =?utf-8?B?Z0x4VnlHNkx4RUhUb1Z0VWFGU0JESEFDN0xCQkIyejJMUEwxN2JsTjdBTUlT?=
 =?utf-8?B?a3gxWElmWUtZNDUwTWh6TWFPN0xvSVg1RmF4MUxDeVdDc1FiQmJlMHpmUDc0?=
 =?utf-8?B?ZEJENkN3dUczQ1gzdGVNUmFrVkd0RVRPelMzam5RdlF2dnBwVXJIVmlWOFhF?=
 =?utf-8?B?WFZnYUJhdmxxaHB3Z08vSjBsMDJmSnF5MmsyMitiK3o0ZTRIRnJKT3NGY3Rs?=
 =?utf-8?B?MDkzaG81c0hrMFFGWGYydWNuYjlZanpaMjRnOWZUR25lYm01TmJkTndPZjFw?=
 =?utf-8?B?ZnlFaTNuQ0N4ZWZESU5Md21nZHJBakRBU2oxd2cvUXhQNmNuS1QrSkE0SnE2?=
 =?utf-8?B?THFicTFMT1EvSmg5eDF5cXFNazVwM2N3a2QwdEpHc2V5UVA3OUpPcStVMlVl?=
 =?utf-8?B?SEgvVktWUi8rUThJSW5BM2N3djZVYzJLMjdyWGhQVGptdnVQV3VuM2kxMndm?=
 =?utf-8?B?cXQ1R1p0U3ROY0IxNUQrK1d1bVBSMkZrSjd5ajZVUGpXMStQRjc4ZXBpcFRP?=
 =?utf-8?B?RWFqYUYxMi9VY0JROUdieVBDd2hYMlpOOWZRSzd1TWNoSzQ3TXM1TlNFd3hF?=
 =?utf-8?B?T2lCeDg2Ry9rNTRoVDhLRU9JSkFWRVhjYjE4UnllTmRsRnBtQjUzSHR4M05q?=
 =?utf-8?B?ekNFaW9RZWVMQzhxbU5kd2pJdkdpN1VtSDIvS1ZyY0JMdHRqbk1Nai9EM1lS?=
 =?utf-8?B?YzNZOThsTHYwKzRYQWV2YlorY245WU8yUTUwWUtwSEh4NUJkVk9ZaVBuNVdQ?=
 =?utf-8?B?RUF5S1hKOUlXZ0JPT0xBN3VDN0ZGWndhbVhIbXBsK21xWmJuWlRmQStNZ0Mx?=
 =?utf-8?B?dDdnSTl4MEkxb0NOS3ZFNUhxZzNOTXdDby9BakJyR0FiZE5HQ2pKTk1DK1Rv?=
 =?utf-8?B?ODg1MC9ITURidGRCZ2Y2Wm1URzBLdURWVnBIcm9zc05ZQTdqSGZHNmtiOHor?=
 =?utf-8?B?aWtMTHl3aS9zQk5GNE5LTXdhRFdqU2FnVUYrVzJIR05kMkZZNXNIYkYyNWlR?=
 =?utf-8?B?RUpEdzM4K25GRWRCTDdZWVUxM2ZrK3IvTjROdm1TcS9RSkxHdStzaDIrSDFR?=
 =?utf-8?B?VDZqTm1LK3plZDFMUG5XbllFekpHbVlHSC9BcithMG1Ba1dMenA5TTNrNU9U?=
 =?utf-8?B?NHp5TENxNkhMaHhNclNGekFGelFjK1JjOThwK0N4Rk1uOW1GS2JmTk9VUGRa?=
 =?utf-8?B?M1RBTWhLVGFBemhhNmordmFnWHlRc3JBeXd6RmFLdmo0amo2WThPTGkzWEN2?=
 =?utf-8?B?L0VCRWQ2L3NsQmgvTjBwOFA0cG5TMzVnSXVxU0d6NmJNOXJBNDJwVldXcEg2?=
 =?utf-8?B?eGRmTGFlanRjOExwZGdadUg2NDBXdUo3YUFBdEUwa3VTRGtiZERUUzBLa21n?=
 =?utf-8?B?dm9FMHhGTW5OdmV3b0VWVWxjbTZmdFhoS2h5VzlhUGNGTmI0V0Q5cCt2RVJ3?=
 =?utf-8?B?dmF5TXo0b092TTFwWkZmNDNzR0lYQ1pwTnUwOUsxT0ZVTDBpVFk4U2psYlNF?=
 =?utf-8?B?STgxSUdoZnBhSXFEN0lSUW9vT3J2alFFOXp2cDEyRmpFcWNiMXFxS0F3ekF0?=
 =?utf-8?B?V1BaZjI4YWVJUVcvaGg2QWx6V05DSnFaejZReWZZbjlsRmgxc0FsdnpXcGNh?=
 =?utf-8?B?RTFFQ3dFQk1BU2wrQXRISnNPdW92ZDVPYmx6MHc3YytJNUtxbk03aHYvWkNB?=
 =?utf-8?B?K1FhdWtyc1NPZHhBR0FkbmVXMVNHbjlyaEx1SEJUektBUFptbitKR3NpVnNo?=
 =?utf-8?B?TVg0VXR4Qkw4aTNEOEFYKzVrM3AyMUxnTytEY08zSngvM1o4MVROSGI5SFRV?=
 =?utf-8?Q?2w8muMwtoK9kRL3zxV98TKM=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2440bf6c-a352-4142-709a-08ddcdfcc6e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 17:32:50.8586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2tbe+bSws6c3JlU2MKdHsjjTIboJ28RsrSZyI8DG33FP5eyelH//9MZoHuSp6uRZLrqsXCbFb6Bja9/QXAMvsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5283
X-Proofpoint-GUID: BHsZmAYcA0GTE6BVXO0xr9Sq14rvjndU
X-Authority-Analysis: v=2.4 cv=Mbtsu4/f c=1 sm=1 tr=0 ts=6887b447 cx=c_pps
 p=wCmvBT1CAAAA:8 a=7lZyNaC2F/ThP7FyJEKG4w==:117
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=MXlzo-qHO4SV0QAqlHUA:9 a=QEXdDO2ut3YA:10
 a=zY0JdQc1-4EAyPf5TuXT:22 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-ORIG-GUID: BHsZmAYcA0GTE6BVXO0xr9Sq14rvjndU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDEyNiBTYWx0ZWRfX52JIncpnxLml
 s9tZf0vztKcXx0gye/8pSdGHrlQCHtJYfRMeDRdwNiGl5etcTQHGeaHZB6XOB3Bak4ztVogUeSD
 HB5KA3w2kqqLXVW/ED6M0KrSOTvVfLgCGjhzXZJagtJel1j4VIF1d2WMAsxAsC8IzTU6g9M7GF6
 Rver8/qsp64m9Oyyx3IbqTzyctQAqoaTmzSOTUsvwkNkIWbycMy/lhvHq/wn84SS0vRFE3snW4c
 mgn6zMHl6AmI5nKD+1cWyFYapttdlyTQWY08sw8DNTKFnC3LUmkR1TktPpvdlQtL+XHcDgG7egU
 sZvy+EElqiqhDD+h2axwTsSWy7KAG6xN7MSW5ybj3gzuIvWZLUQGCAZPwicOD6fRzCejEpCTOSP
 mzDV3/+C8ETk/mo4VWg7zblYJ9TAkW7OdKalxRiXRlU35OTKKctZ3Ppgq5/JvCvbG9hy1qcy
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D31A79F8D17C849AFD68C717668BD2A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  KASAN: slab-out-of-bounds in hfsplus_bnode_read+0x268/0x290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 mlxlogscore=887
 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=99 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=2
 engine=8.19.0-2505280000 definitions=main-2507280126

On Mon, 2025-07-28 at 15:40 +0800, Chenzhi Yang wrote:
> > Hi Slava,
> > Thank you for taking your time.
>=20
> > We originally obtained this issue's syz and C reproducers using Syzkall=
er's repro tool (refer to the URL below). The issue was triggered when we r=
an the syz reproducer through Syzkaller.
>=20
> > Url: https://github.com/google/syzkaller/blob/master/docs/reproducing_c=
rashes.md =20
>=20
> > Syzkaller also provides syz-execprog to verify whether the C program ca=
n trigger the issue. We are currently in the process of verifying whether t=
he C reproducer can reliably reproduce the issue. Please allow us some time=
 to complete this verification.
>=20
> > We'll follow up with you once we have more concrete results.
>=20
> > Best regards,
> > Kun
>=20
> Hi Kun,
>=20
> Just wanted to follow up, how is the verification of the C reproducer goi=
ng?
> If it does reliably reproduce the issue, could you also let us know under=
 what
> scenario or environment it occurs?
>=20

I already shared the patch [1] for this issue.

Thanks,
Slava.

[1]
https://lore.kernel.org/linux-fsdevel/20250703214804.244077-1-slava@dubeyko=
.com/

