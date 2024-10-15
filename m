Return-Path: <linux-fsdevel+bounces-31940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F62499DDB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 07:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037BE282FBC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 05:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3C017836B;
	Tue, 15 Oct 2024 05:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="e8SL5Etm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9591170A0B;
	Tue, 15 Oct 2024 05:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728971529; cv=fail; b=PW1gMIRS8DtIWR553QiteR1jt4rW6mNF9P6urZ+olma7U1HwGUrmrWtllrsGBn3qtWlQ+AbqU64fekEyXUaT+NevmP1g8VUe42XIJ7gSKIipSm4JJ3iilQKF1pip78Vc/F5vJipm8+56nnbLPRLZAyWBedBHDHKX4Y0dlZKk0IQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728971529; c=relaxed/simple;
	bh=SPTwy2B1cQThosOr2CycWXaA1+1IQMiCl6vFAeYS0dA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OkfVZ1rLrehNMeHjih3fnDj0fZvVXhJphDKby2pVJHHBFM8+CcI1dJmAQidflPmVo1upVpgf8705iK/70ruHapGzlO8rKS5sQGt2Mo5siQNQgdTGVTveuETQOtvSPNIDsk61z6HGSLkhAm1Z8ENe4btRSFBqboGYIfkJm+9tZUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=e8SL5Etm; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F4qbNM008851;
	Mon, 14 Oct 2024 22:52:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=SPTwy2B1cQThosOr2CycWXaA1+1IQMiCl6vFAeYS0dA=; b=
	e8SL5EtmdYNWIWpMe/aMk01V1APpcJ9hsMaAPkaeZUUUVc61aiQLlghKKO5YVQAG
	THQcpq2S4OniimYRglRRdob2MWE9aQMQXEtf3JMKf9LYF8Fv5sBDJ7YPfYszZ7yU
	0LrLo0o0neOU3p2xYjMZALXqrWOcpeyIe0nl8BI1QUJ1jpAkh6B4pbZz/X4lU+AX
	q670++NiuSfbgjLzlN7xMndVcAcBxDbQlW7fTaoF/kOrX4MiMN1TWL3y9diDUByv
	Xjt6X+Y5AuC5Lx3DgYmKVE7+UFIywG1NCZRSzlG7v2KN+P3gsyRXounnsUHBnhBL
	debpbdUWJzo5lYZeMDsrzA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 429g070n95-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 22:52:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKmNu3tOJAfzh0UPLIm0Q1XDGIwmxRlqabzugoWN+Sfm0Bg0a0sJ+ouA5MIcgEZhxoNbIw8X/F4pDU9S9VHRFKbh4W3ym0MXvr68EFY4ViQjxSzpnYY7zHwwSwLCC0OCiPX7UAzTzLM/RjCZHuFI63U4WJkxwGiXzCoz4nBn+XyZeaA76p3y179D0a+JvigPwxf2Y66XQvHIDyF6vG+4suBoSWf/slA3QMaCt4B9C7+AQU688J0e4ESDtoMhDHSru5tlCIkD7D/21nJer0b6E2srzvhhi6W/LRbdqyAvZyzcekoF/i0biZqS36gYjkszDhiETUq+KzVld+sV81SqYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPTwy2B1cQThosOr2CycWXaA1+1IQMiCl6vFAeYS0dA=;
 b=dJff15d5keRP9G/jxeFaU5THSzgSUyGPDLo5H6YzAW02RmV9hygU6csKVnmnnpjT6bSOQtv/r2fFn3ZxfBEogXjJDR8VfMYHnTT3xef3S2sNXQ8HuTovef1tKmcVI3lqA1QWWrynBNv3QffI+BpAU69aux9cTQpgKouyBdYG0Q70q9vBzOd7X9TB7p7SO4OOIYAKQN8N4ankNOKbmPpmtg2KkFCob8yPVC/0hyXQYP6Wf4ZWMOyy8zY+OKQwtATtJM4ognI+kgGCAfhM423VgqwVpxX2BgitG9Bi0elN6LbliUrkUqoAQQLTBUUImTjw9Z49Q1Z3sHdErk/4/W6LEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB5117.namprd15.prod.outlook.com (2603:10b6:510:c4::8)
 by SA1PR15MB6400.namprd15.prod.outlook.com (2603:10b6:806:3a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 05:52:02 +0000
Received: from PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::90bf:29eb:b07e:94d9]) by PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::90bf:29eb:b07e:94d9%6]) with mapi id 15.20.8048.029; Tue, 15 Oct 2024
 05:52:02 +0000
From: Song Liu <songliubraving@meta.com>
To: Christoph Hellwig <hch@infradead.org>
CC: Song Liu <songliubraving@meta.com>, Song Liu <song@kernel.org>,
        bpf
	<bpf@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Andrii
 Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Alexei
 Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin
 KaFai Lau <martin.lau@linux.dev>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        KP Singh
	<kpsingh@kernel.org>,
        Matt Bobrowski <mattbobrowski@google.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Extend test fs_kfuncs to
 cover security.bpf xattr names
Thread-Topic: [PATCH bpf-next 2/2] selftests/bpf: Extend test fs_kfuncs to
 cover security.bpf xattr names
Thread-Index: AQHbFRSqQ+6V3A7WhE2nOTZ+DtSM+rKHVfgAgAAEFACAAAEygIAAB0MA
Date: Tue, 15 Oct 2024 05:52:02 +0000
Message-ID: <BF0CD913-B067-4105-88C2-B068431EE9E5@fb.com>
References: <20241002214637.3625277-1-song@kernel.org>
 <20241002214637.3625277-3-song@kernel.org> <Zw34dAaqA5tR6mHN@infradead.org>
 <0DB83868-0049-40E3-8E62-0D8D913CB9CB@fb.com>
 <Zw384bed3yVgZpoc@infradead.org>
In-Reply-To: <Zw384bed3yVgZpoc@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB5117:EE_|SA1PR15MB6400:EE_
x-ms-office365-filtering-correlation-id: 4f997544-8236-41a5-1596-08dcecdd7e13
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YVRud2pPWGoyMDRJVThaaG5qQmxnSWFNakFWRE9pZDI5V3Z4QVExdHEybDBl?=
 =?utf-8?B?aVlyWExMdjdndVgwS2tYZXloVFNTU0FBV3JtNmF1NzFCajZQVE0rbG5iZzUx?=
 =?utf-8?B?djkyUEc5aVdmUXZKNEVpYmRpckdDMzBSS1hHSXdaUVFNalFJdEw3TXJqeXJ0?=
 =?utf-8?B?YUF6ZmV6ZVdKWG5VY1JiN1YzOUFOV0Q4cnBjdjkxMEV1STNSQTY4eVBWODR6?=
 =?utf-8?B?T3dTTEoyenREWUFOallKVUZmSzEzSnU0b2pvM2c1WHNSZnZqbGdLcWYrVnFr?=
 =?utf-8?B?OXIrRzA0bldwL1FvVDRVdEI1UWEweTFTYTZaWVdwaVc3SC9TV1Jic1lwZ1FT?=
 =?utf-8?B?MFM1ZStmd3gxMWM1Z2pQd28yZlpwNEZUM3Q0Unl6dzVxSkpMNjdGbzVLWDZY?=
 =?utf-8?B?OS83Z1J2MXNDdytlOWZiTm9ZY2JRVXhwVEJ5em9NWkdBUWNLMFBkbFpCU1BD?=
 =?utf-8?B?SDN3SGhYR0hCNEU1Y0pzMlhESW5ERERGdHZxZmN1RWhEUUtUV2hmeEJFb1Ns?=
 =?utf-8?B?Q2RMUFA3QWtmc2R0RittYjFnck9HVERnbmN2eDVEOWpEbmN5YUFYVm1RdVcx?=
 =?utf-8?B?R1BzaW9rWGFoZUtVMUpob2ZFc0xYV0RPbVZIS0lKR0h6eU92allRUkV5aVJW?=
 =?utf-8?B?QkMvZmVXNVhrWTBRMkxFcVpEVXF3MCt5YktnUm1peml0VlY2dWpPSHdYNG9l?=
 =?utf-8?B?MkMwV3R4ZHkyYXlGNVc1ODhobTFKckVGVmE1cEppWnpHUFNOeUF3R29XOXA5?=
 =?utf-8?B?ZDdSV0htVFEvd1dBOXNrKzJDZmsvZCtqTFVLM2RpU1RwRXBHbGJrMmx2U0JM?=
 =?utf-8?B?K2M3OEpDQWdKcUQyN0FrN3VaRkhQa3VBY3BaQzMyUEZhei9JNlBjNUNuYStv?=
 =?utf-8?B?TkJSSEpHWU1vRkFBODBHYVJoZ3gvWFFSN0xSSDFlaThjVzl1WlVwdkR5SXRB?=
 =?utf-8?B?QXBDMEZLMWtMR2dqYVNBYi9MQ3F0V29hYzNWM2Y2bHJaK0Z4dUFYUEdjRG5R?=
 =?utf-8?B?MlVNUVZRWTVUb05WeGhzb1Y3TnUwKzZZNG5WaVRhWGhKVVZmcU9mdWg2em5V?=
 =?utf-8?B?cUl2TkZiL2pLd1lvS205RFk1UlBWQjE1Z2JNTG5BendOUWVkWllmZWc3M2dY?=
 =?utf-8?B?VGEwUENyV0xhOHc1Tk5ZU2huRmxoQVgrSHhEY3ZjRWJodDRSQ2phNVFBZ2xk?=
 =?utf-8?B?WlNvTUNBbm05eFVEWlY4YzdmTWlZN0JzaHZ6N01OK3BWRXozWCtyMTRCUzRJ?=
 =?utf-8?B?ZU5hV0VsdC9hOHFiTVZzRTgyZjM5bXBJbW8yOVVDOUtWcXJCSlV3ZVlVeEFC?=
 =?utf-8?B?c3lNSkU5Q0YrRHJEL3hRek9SZkEyQkJYaXNCSERwL2FrWURtN0dpSURvdU9r?=
 =?utf-8?B?MDlWelJHcGVjM0FXaHV3aEpuSjduN2RGSVVseTRDT2F0VHg3M21yL01QbGh3?=
 =?utf-8?B?MzR6SDQzbjBLQWtQdkVHSUdhSnpwSERUaU12R0VTY3Z5S3VEKzNsSkxSenZk?=
 =?utf-8?B?ZXVjUnJhNHFGSUd6NzB3YmRuT245N2tFZk90ZU1yekdMMURkRU1qbnNEbVY3?=
 =?utf-8?B?UVBON0drY0dLUW1hdXFSQ2RCZDhkVHYreU10NmxGSU5iSGYrOHBQaEc3T0NX?=
 =?utf-8?B?MlZKRkY1cTh5QkE3b1FUUWtPS0dWa0E3c2FiRGRwOWtnMnpsZS9CY0NSZFIr?=
 =?utf-8?B?ckZYbFhkU0o0NE1LRUlCWjlMdnQ3YXFEWWljSktsWVBFVHl5Z2MySmdtQVlY?=
 =?utf-8?B?ZEwrNzZmYi8waDd1QUdzQUQ2SnpTUisvTFNRMHBlOTV1QnhsQlJjSWJJRi95?=
 =?utf-8?B?UVhGbFN3UWZ6L0pqd3VpZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5117.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dnU1Z3pxakRhU3hnN21JZGVIem5KaWVFWWVYUVN0OVROeTZiMVJ0dUlnQXV2?=
 =?utf-8?B?UE9tdDVxbFV2cHVwVzYyRUk2R3VMY0ZGakQrdXlTdy9XSWxySmM2RmlNYy9w?=
 =?utf-8?B?Q1E2SVlVdW8ySWx0VlhCSTZoM291RHZ1OVNwNEgyS2RsM1hvQUhzSkdLK2lZ?=
 =?utf-8?B?anI0V0lFMlBSNG56MzhpSHp1dzRsTGFvRGU5NnZqM3V3ckplWHpEUlZ3NWRY?=
 =?utf-8?B?N1JDcHpLQ2VpNmJic3NOckJDNXhzMFFRTzRFcG53Qm05K0lqbDhHeGlRL2tN?=
 =?utf-8?B?Y2R1eVk5QkxYa0hsckYyUjY5ZlR4VVhrWjNiOVNpRDV4R1M2cDlaRkxRWnlk?=
 =?utf-8?B?Z0Y1bFo3Tys0WnRDbUk1cFgvRGVIU3NYcEhwQW5jUXJJOUY0ZEhqRWpQSlZv?=
 =?utf-8?B?KzhiSjMvZGxleFZRNlhWMytnS1ZOcDd2YVNqQk1DaUtzOEJBYVhwK2xUOVFY?=
 =?utf-8?B?bExzV3cvVDQ3QkNpNVJ5T3ZaMUhDU1o4L21VNjNEVE8wUEpERVFDSzBna0la?=
 =?utf-8?B?OElmVnpkN3pHKzliNy80MFcvZC93QkkrZ3FFS3gxUXpiNTY5dzh1ZjNZYVg1?=
 =?utf-8?B?RnVacVVYek9GRWpBUU53QVBlUVNsTThSck5XdHhISEdEQTNwWGNkNGNMbnlQ?=
 =?utf-8?B?OHZvSDNZN1dPVEg1ZmhWTm9Ja0NHOW9neFlUTGZXM1hXeHhML1kveW5ONzls?=
 =?utf-8?B?MGtnVisrUDBqbGQvd2lYMmdIMmw5NlJWRVVkR3lLZ0tYOThjT1BOa3JSSHhk?=
 =?utf-8?B?MmN1amlvbkJYUUFIMU9hVWhMRVdHYnU2TmtPQjJtUzRQY0hSeUxZelJIb2lH?=
 =?utf-8?B?b0JaMGliTEZNbDBzN0JPQXQvVXR3UkNkOURPUHp1QVZqVDZZTmN1NTF3R0dP?=
 =?utf-8?B?OVY4MUVYanY0c3BtTGhDOFJFaEI0aFI3SjJWM29kVlpnNW5McUg1UVNLdnNq?=
 =?utf-8?B?M281NEhZZDROeWNJdS91Ry9qbzZycDlTRlRWNHNEYzYrL1RVRHNaMFZWNElC?=
 =?utf-8?B?Q2MxU21sSWVCZXBSdVhJdGR5UGxZTU5ZOXFjNHNLZlpucGpSbnJScVphdHky?=
 =?utf-8?B?aDU4TU14RlNyOTJDdWphaXd1ZjRuWmNyTTlQMEhQY3QvenRNcUl2cXJRZW1D?=
 =?utf-8?B?RnRCR0F6Ui9oeEZIWFY3c09jdmI3bXJISWF6SzVmc3ZGQnN4R0REeHByVE80?=
 =?utf-8?B?b0d6TFRpZHpzcUFodCsrQ1owV3RaWDQ4Q0tkVDNxZlRUckY2Vkk3TzcvaUxj?=
 =?utf-8?B?aStRL1JMdFpHanE0dndHYklWaVIzQWtTMThxdmkxWTBwYXk5UXJCNTZmTnN3?=
 =?utf-8?B?N0VkcDRxNmJFVGR0YjY0a0ZtUytseU55UzB1UC9xMSthTXFHaG8vM0VHVUwx?=
 =?utf-8?B?YWtDY3B2WGxJTEVvSXg0dWxGa1lvd3I2anJjZ2U2VmJmRUFnNXlMRDhBbmZP?=
 =?utf-8?B?OUhsSk5RTEVtQlExU0RNb2JJL3hNckxLSnl2VnVhQ3JJYktKWC9RaVFkTWY2?=
 =?utf-8?B?MmZqdlJhTVVqUWdnZGxKeTlzTUlQQTZDU2FaT2dKUFpSYkRmWVVRWSs0bzVq?=
 =?utf-8?B?VDJIOEl0d2ZZQlNqQ0d2TThNTFlQMjBOVDNUbEx6ZWd5cFFUUjdoWXVZOHdI?=
 =?utf-8?B?ZGd5c2cvdCs2TzBHdUNMWndkMTREck1zU3ZROERidno5alVBaldxRi9hVW05?=
 =?utf-8?B?ZnVVVHg3cDNNUXNhenJPbmFVUS8yZG9OMklLZ2t2ZVdFRjdZeXRSUFZ3R0dC?=
 =?utf-8?B?YnJLY25QNGV5NTA3Qlp6UmVQRWcrMThxU0U2MndXdVBHNEsxdEN3QmoxNEFW?=
 =?utf-8?B?UitFM284MVh2UzA5RldtU2FWdUpGcmk3dWw1R1QwS2tYdFZod2RZL1dZMW5i?=
 =?utf-8?B?UDl5ZzFBQ2RpMER6RlNUYUNrdURDRkQ3bDdoL0ZNRW5hL0lmZHVYSTRNeGZ4?=
 =?utf-8?B?R3E2V0pPVTFXbGdLV2t0MDVzNU5MQUlTUGlNeHN1bmJCK0p1T0tIUFhVeFc5?=
 =?utf-8?B?cXVaNWRDazI2czd2cURxeGliYWkvS0dUSklyWHZEUm5GYmR3SjBoUTF5Mmpv?=
 =?utf-8?B?SzVRdTNQTzNqWnp0bzJWZWliTFAvWDRicE1zZURJV0hRSGVGRU5XcENuYTE2?=
 =?utf-8?B?eldxaEw0SFhuTVZCamhHNUpLTVIyUlJHdzVVS2VGa3J3MDAxbUJsQU8wd21R?=
 =?utf-8?B?K3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AD27FFC9A35E04292773F0F7A6D2D49@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f997544-8236-41a5-1596-08dcecdd7e13
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 05:52:02.6283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GYrAUz4Whukn4VrSAKaqqclIxYaUa0na+1I3g32PTp1Yd8nIbfvZJQ+OeMjXk5mkBgK4bmGMYQzqhIaK4Lp4tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB6400
X-Proofpoint-ORIG-GUID: suni9cf1s-BLNhpzzrjCUvXT3PKM6Ilb
X-Proofpoint-GUID: suni9cf1s-BLNhpzzrjCUvXT3PKM6Ilb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gT2N0IDE0LCAyMDI0LCBhdCAxMDoyNeKAr1BNLCBDaHJpc3RvcGggSGVsbHdpZyA8
aGNoQGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBPY3QgMTUsIDIwMjQgYXQg
MDU6MjE6NDhBTSArMDAwMCwgU29uZyBMaXUgd3JvdGU6DQo+Pj4+IEV4dGVuZCB0ZXN0X3Byb2dz
IGZzX2tmdW5jcyB0byBjb3ZlciBkaWZmZXJlbnQgeGF0dHIgbmFtZXMuIFNwZWNpZmljYWxseToN
Cj4+Pj4geGF0dHIgbmFtZSAidXNlci5rZnVuY3MiLCAic2VjdXJpdHkuYnBmIiwgYW5kICJzZWN1
cml0eS5icGYueHh4IiBjYW4gYmUNCj4+Pj4gcmVhZCBmcm9tIEJQRiBwcm9ncmFtIHdpdGgga2Z1
bmNzIGJwZl9nZXRfW2ZpbGV8ZGVudHJ5XV94YXR0cigpOyB3aGlsZQ0KPj4+PiAic2VjdXJpdHku
YnBmeHh4IiBhbmQgInNlY3VyaXR5LnNlbGludXgiIGNhbm5vdCBiZSByZWFkLg0KPj4+IA0KPj4+
IFNvIHlvdSByZWFkIGNvZGUgZnJvbSB1bnRydXN0ZWQgdXNlci4qIHhhdHRycz8gIEhvdyBjYW4g
eW91IGNhcnZlIG91dA0KPj4+IHRoYXQgc3BhY2UgYW5kIG5vdCBrbm93biBhbnkgcHJlLWV4aXN0
aW5nIHVzZXJzcGFjZSBjb2QgdXNlcyBrZnVuY3MNCj4+PiBmb3IgaXQncyBvd24gcHVycG9zZT8N
Cj4+IA0KPj4gSSBkb24ndCBxdWl0ZSBmb2xsb3cgdGhlIGNvbW1lbnQgaGVyZS4gDQo+PiANCj4+
IERvIHlvdSBtZWFuIHVzZXIuKiB4YXR0cnMgYXJlIHVudHJ1c3RlZCAoYW55IHVzZXIgY2FuIHNl
dCBpdCksIHNvIHdlIA0KPj4gc2hvdWxkIG5vdCBhbGxvdyBCUEYgcHJvZ3JhbXMgdG8gcmVhZCB0
aGVtPyBPciBkbyB5b3UgbWVhbiB4YXR0ciANCj4+IG5hbWUgInVzZXIua2Z1bmNzIiBtaWdodCBi
ZSB0YWtlbiBieSBzb21lIHVzZSBzcGFjZT8NCj4gDQo+IEFsbCBvZiB0aGUgYWJvdmUuDQoNClRo
aXMgaXMgYSBzZWxmdGVzdCwgInVzZXIua2Z1bmMiIGlzIHBpY2tlZCBmb3IgdGhpcyB0ZXN0LiBU
aGUga2Z1bmNzDQooYnBmX2dldF9bZmlsZXxkZW50cnldX3hhdHRyKSBjYW4gcmVhZCBhbnkgdXNl
ci4qIHhhdHRycy4gDQoNClJlYWRpbmcgdW50cnVzdGVkIHhhdHRycyBmcm9tIHRydXN0IEJQRiBM
U00gcHJvZ3JhbSBjYW4gYmUgdXNlZnVsLiANCkZvciBleGFtcGxlLCB3ZSBjYW4gc2lnbiBhIGJp
bmFyeSB3aXRoIHByaXZhdGUga2V5LCBhbmQgc2F2ZSB0aGUNCnNpZ25hdHVyZSBpbiB0aGUgeGF0
dHIuIFRoZW4gdGhlIGtlcm5lbCBjYW4gdmVyaWZ5IHRoZSBzaWduYXR1cmUNCmFuZCB0aGUgYmlu
YXJ5IG1hdGNoZXMgdGhlIHB1YmxpYyBrZXkuIElmIHRoZSB4YXR0ciBpcyBtb2RpZmllZCBieQ0K
dW50cnVzdGVkIHVzZXIgc3BhY2UsIHRoZSBCUEYgcHJvZ3JhbSB3aWxsIGp1c3QgZGVueSB0aGUg
YWNjZXNzLiANCg0KRGlkIHRoZXNlIGFuc3dlciB5b3VyIHF1ZXN0aW9ucz8NCg0KU29uZw0KDQo=

