Return-Path: <linux-fsdevel+bounces-47879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDA9AA67A4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 02:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7946C7AAD16
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 00:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A0523A9;
	Fri,  2 May 2025 00:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jzoi1T85"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205628479;
	Fri,  2 May 2025 00:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746144241; cv=fail; b=g3qpN1QmNnqNhFSlr9+Dy2kGa8s9Q5LPoL2D4UhCfmlWdxQ+RHHzh01D/nP5McRPueHVjxTRqqElRW1P9hPbgJrAfznn3Z5qScjkdxbhH8LW/b/hyFqkFNZV4B2aRHRvtLn2BFCbOfpvblE3IjMgzqoqrmHMZPWmrIl+6rJ3oIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746144241; c=relaxed/simple;
	bh=raExcSQX0ehTEsklIusr3nXJ4IzLLEe3Kw8Jx8SwL2M=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=lKDd0X4mFOv+qzN/jY9Z7VzLOtvTtSoyBiBhwYsc1x4qKOJPT6jAblYja+whfqS/wklHTL/YAmwkvbdbELkD6wJZ7UnphlxhAyEKHynB/d096CPu0oyN6jjE6rHew1m198k17C+c42ElVm1DDc2SLQlQ2mykG0g4rLP9jiWI/DU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jzoi1T85; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541LghsT006374;
	Fri, 2 May 2025 00:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=raExcSQX0ehTEsklIusr3nXJ4IzLLEe3Kw8Jx8SwL2M=; b=jzoi1T85
	XFWrFn8RcpTvJMRhLSXFSkclmtEIeN1LLA5a/Ql2+WjxRiU7AdKY60DSmsHyeaE6
	PIQNRu/clEqWJRtrxhY/RFJGQ+DIGY+PrSP3NegLr2LtcF0Z8Zd5HLTBgIiz5Il3
	hKyfyHgMnAv5nrERsAsoC9Z7NVDLjLMGN8i8T1GxyVshIaweeTju4VXDDsAPIVTN
	kYPFvNDIkeWbxxDoInnDAK5ht4sgUD7BihJjMweJjIJs13dOUEzmux0aMK38b1oZ
	L5RPLBKdRKyoninbEkIIa+6rbcV2OcczTqTMyPYDIzHxZzuKz4TkWV9khU7BHCER
	2fLijxeQAVWaiA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ch3vrbpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 00:03:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLxChgErrg8Tsz3NlIONidl+wxsyVFJmx28be++fEoHVTvdEbNCwb92/0y5f7KqKh9krbgswlbQyJLrA4tnyN24HkKptmHQ6/gB9HydVyqjQPkfTCy80s+Qo6YaCISoBL5VWzs/6sWervKkR2D7rDZmwnxkbxDu1yNw2Ws0as50NHapAPoQQJEQe185vH+VxDXWcSA6sywK6ZvUO6by3sOD8y0mKXsT1xC8qC4BJJMMCiymlUdi0mAJOqDln6kI89dZvjYYrFgI5TV4FtWYPMovVhFdVcZ735NTa43XG1Tx9yKGXW4YGGNYiauVu51i0/Ao86csIShw/yc1bHOZGSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raExcSQX0ehTEsklIusr3nXJ4IzLLEe3Kw8Jx8SwL2M=;
 b=dvZlzYORx5YpXOp83OSPMsE3T4X4Zi3vglSzVVbffs6+oB6dRTGW+tqxJ0cGJpTP/bqXYmA9AJ6q+SLKfBawe9rNinW+qdmfNmfbbwtb+wZmfar7wpHbOpGbr4BV5pxQEhyub9DjZjksXfOhFD0dVWVT3pMwBmNtcSMh7tiPSqkn640upeq1jbHVfnVghVj5p8fRaGghYBgGMzPOxzj+hP300QO/gkQ2aFJRiildyDVyfpTyBiylktkbLUrarElhZjsRN5TgfDte1OKbwglaAwHXsADD+d3OzN1pfzmJtQwHrFYby/g0TRzmf8X989UGuVZIYnOm/iHN6I0ksztmmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA3PR15MB6073.namprd15.prod.outlook.com (2603:10b6:806:2f5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Fri, 2 May
 2025 00:03:45 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%3]) with mapi id 15.20.8699.019; Fri, 2 May 2025
 00:03:45 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH 2/2] hfs: fix to update ctime after rename
Thread-Index: AQHbuUDIPkCyKCyHHEyl9CudlacUJbO+eNQA
Date: Fri, 2 May 2025 00:03:45 +0000
Message-ID: <24ef85453961b830e6ab49ea3f8f81ff7c472875.camel@ibm.com>
References: <20250429201517.101323-1-frank.li@vivo.com>
	 <20250429201517.101323-2-frank.li@vivo.com>
In-Reply-To: <20250429201517.101323-2-frank.li@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA3PR15MB6073:EE_
x-ms-office365-filtering-correlation-id: 4bf131cf-2414-44bc-73f4-08dd890cce5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cHBVM1dGaDRnR0JhTVhsZS96YVBwUmhaV0dqUnhkNmFFZFZRcXlsRGc2c1hw?=
 =?utf-8?B?K0I3cVZLRHBvWVl0MnhSaXdwZkE0YXZLUUZHTmFCb0JmUnJxWlBVLzVUY0Fh?=
 =?utf-8?B?K05GOWgvdGdmRUVSVVZ4QzRGblhOK0dxVE5qc1JCR296RjFvQjRaUzJRNEIv?=
 =?utf-8?B?T0s2bTZsR1dsYWdNRm5CRytiRXM2QjNRRVEvMjlXbDVhb3VGN2hUVWovQ3ZW?=
 =?utf-8?B?eWVCbi9VMEZ6aC9lR2FGNmNRdEczSXRwTDNsZDN0Nm84TXVjemw1RjNQOHV6?=
 =?utf-8?B?MmswandMOFhIY3NZOXJVbW1TR1E2cXFSNGk4YkNmTHVnOW1PUlp3eS9ER1NZ?=
 =?utf-8?B?OXd1YnIxLzVWY3ROSlE4c0g4ejJXdWc5NmpmaHZmaUNxMkFacHQvczVKRkRr?=
 =?utf-8?B?SnNwd0VQb2dtb1AzSXJ3VGxlL0txOVF1OHptMTA2L0VPWS9qVFRmS3FCVXpv?=
 =?utf-8?B?ekRreWlUbVBxaDEyS0dWQ24vYnNaeGFtbTFBVEtZKzR6QnFaTWQrTk94VTNx?=
 =?utf-8?B?K3VuTG5kSjJOdjRCYnY1eDVYTG9tNWV2ZUVSQVVxYXFwTFFuWEVhQkltM2Ew?=
 =?utf-8?B?aXNrY3Nic3JNdnE0TDA0cEhrYmhDRVlDMHNGMlZHVmp3dW5GRnYxOS9zK0dp?=
 =?utf-8?B?V0s1SUlrM2c1MW8xak12QlpldkJLOGdVUkgvZVEyd001WTVqRjNpRkFUQzhL?=
 =?utf-8?B?V05ydDlMdldXMGJ1ajNRTWsxdm1pT1hsV2toYXMwZjdjMkxGM2JTV203UW5G?=
 =?utf-8?B?UFlZNm5GN1VYMzZGZkdDOEhLSnQ0UFlnMVJJcEM4eVlwWFA3S1FMUTBndEE0?=
 =?utf-8?B?TllHK0VQMXRTK3plWW1KL2UvblpMUnVzajZIeDZTVzlOcnVwNFVIV2VDNUhr?=
 =?utf-8?B?eWt3cjlnN01PdkRhYjhGdUoxek9xZXd5bW0vRVd5MVJQeWl2cGh2TXF3VFBY?=
 =?utf-8?B?QmVxM2tzQWNXSmhYblpJZGlLMDFQK0UrTnp0WTBxdUtFY2o1RHFqRWFPK0RS?=
 =?utf-8?B?ekxJMXp3QVhtNEFkYmQwU2FHTTdiRmt0QWdlZ004eTFpTHVYcEk3Z2RJOGFB?=
 =?utf-8?B?RVphWnF3NDhQcjF5dXZYUis5V29hcUtLeTgwakxmeWVtb1FJZEhIbVFRd3Vv?=
 =?utf-8?B?dm13MVd6UzJKTHh2SG9JalFVTFFBcGVLN1UyNzRGekFSRHpqZlNqRFpwVTh1?=
 =?utf-8?B?RWZURG9OVEdOUHp3bGUxMFdrTjJibzBIRDRFdWZxTGdiZnRBTnVxaUczSzN1?=
 =?utf-8?B?Ly9ON2FkMU4yVkF3ZXZSdmpWLzJvVTJjMjRLWWN0U3lLaXV6S09ITlNBYWpy?=
 =?utf-8?B?WkFDRGt3TC9Jb3pZYjcvTzhvZ3Y0RitJaHptdmRuOFZzV0VIcUlQbjR3OFhU?=
 =?utf-8?B?TXJ3WS8zYWtJWHpCbEl2bG91OHJZNDkwY3hOUVBtdnZVZzEvQWRidzZBVXlu?=
 =?utf-8?B?akFrK3ZLU2tWbFh4NnViK2RRUytDR25VWE9pQUljSSs1MXBLS2lBdjI5bTVs?=
 =?utf-8?B?MjVXa3ZlVHBNOS9DUGVWVEUxSnc5ZEFZeHpUczFCT2REUXZsQnc4MDRjWTBu?=
 =?utf-8?B?cjdTTUtxM0ZDczVMSlY4aXNmdGpxWjJ2Z2xSaHova2Nyem0vTzJuZ1RoUlRF?=
 =?utf-8?B?b24xS0xVRGVldTBBWXhaUW0yVVpIZnlmMFJLWWxURVVVdmhKSUF3dEFleGo0?=
 =?utf-8?B?cERKL2lzYXNuNWFtMEpmWjRqVlU1MXB4ZlRvZEJaRWR0a1lOakV3aUxGVlkv?=
 =?utf-8?B?YmQrNThSSnBUNFJjR0MxZUVvT2FQb01YQmMrbi9ZMkZtZDFvWDBLWktGY3pa?=
 =?utf-8?B?TForYUlFMGZrWnNnN1hQa0FGZm5NMi9kaUZyRHg4cEIrRmtUYkNTY1E5MFBY?=
 =?utf-8?B?VktIdHMwTU9iWEl6SEpHcHV5K0cwOExWTG5BeFlDNDhLQlE1MkI4c2ZQRktJ?=
 =?utf-8?B?YWl5cTJsMEFHRkt3Szd6bUN4Qzc0QmtQN2hXRW1heEE5VmRkL3ZLMmdTbTNV?=
 =?utf-8?Q?JEYd8DVdOLRYFAfYzNGsYIyD7teITk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MmIzNkVFQWJBL3RqMzlJREpsOXhyblVXYjc1YmNXRXBiaUpEWm5LNXJEMHBy?=
 =?utf-8?B?czY0c0dFcGNhbzVYQ0tIQU9IVGVVRG85dCtjcUNkRmxlVklHOGdRSUhmd3VS?=
 =?utf-8?B?VE9yVWVaTVY0YzBBVjdlanhpQkR1WDY0VFQ3eHNRKzVWMW8zVEFkcEpuZXNI?=
 =?utf-8?B?cDc0Y2xFSHRZcHVZS2xxTGFvN0RmUW5TVjB5c2hicnVaQUdSU3I2TTNJS3k0?=
 =?utf-8?B?MEpNUk9xZkRNeGllZmhCNnpTOHNseDFpMGQxSnFOdWJqTTczRFVXc0Z5NTRQ?=
 =?utf-8?B?THJEMDIzZG9wb01XdDYwUHJ5WStOQy9RWFM5ck1Tci9FcDdxWUNqRXN0TlJU?=
 =?utf-8?B?WFlHenpFYy9YTTdwNlM2ckhLakdyRld3cGI0Snh0RHJwOTF3RXVOblBEeGFt?=
 =?utf-8?B?NWdTOXNpbnpyQkVCMVdZMkpKT3ZQU3NnK01Ra1ZhTUZtTHdKcW0xV05aQ0Ez?=
 =?utf-8?B?REc3QzhoOXN0QWdyWk5WdUVYV0NqdGRkU1Z0Q01YUXhqVWZCU2tSTnlwVjFE?=
 =?utf-8?B?bEg0S2V6aTkrN0hHR1NXWGhyZGdUYTJFS2JmTnE0MnBPOUxMSW10aGdGYWpH?=
 =?utf-8?B?aW9yNzJBbGpLM21FSG9BMXlJZXppdzhBOFFQaUlqWGZzMWhuNEJiMkdudFRB?=
 =?utf-8?B?a0hBN2JQTWdnS3JSN0FtektVWWpLZGF2dmtyOVNEQ2MvSmV0bFQvMnloeEdL?=
 =?utf-8?B?c01IMUZJWXltbmdlVlNBRE84b3RrUzJEL0tjVkc4bGF2ZjNJYjQ1MW9IaFVt?=
 =?utf-8?B?RmpjRStnRWEzRDVLSXRXYm9FMDhndXhHa2NnajdJZUdUQlA3MUF5K05GQXAy?=
 =?utf-8?B?VndpZkpMTGQ3em5FdDR6VW8vbEMraDNtSGFjMm1mTE5QRlkyS1FBZ2dIUUR2?=
 =?utf-8?B?aXFtZEMyano2OU90SzlHN2xMbmFSNnljS2hQODVhMURQcDdXWE1HaTFUckE5?=
 =?utf-8?B?dUVoV1pYNXBaMDBKUEVTaXZsckZPLzBXczd6dVdndnBqL0p1UTEvakJoRmRj?=
 =?utf-8?B?QmcrQ2NseFo5ZTlVZVdzNUpOS0VjWlNYMGE3b2p5bTVEWmFvQy9TYlk0bGdl?=
 =?utf-8?B?ZngrTXg5NXJvNG83OTBZQUZrVzU3aGw1UG5jWlZRU2RoSnRlRG9RZ1JXWlFI?=
 =?utf-8?B?bHFidHBTZkI5Nzh4NzM0U2d5d2VTRnVBamZxVDJ3STQ2aGEyU05XaVdkS3I2?=
 =?utf-8?B?WG9XOXNhaWRId0p5eGtkeU1qYVBhMmR0R3BOd0tKY3ExMHRNNlM0dXJ3TXQ0?=
 =?utf-8?B?ald4YXdwTWxCYzc3RGczNnpUMlRvU0JYWnhJTzZXM0xxOElFcm4xTE1RMnFX?=
 =?utf-8?B?OXR0OXdxOG51ZndlU0xWNVYzSmd6bzFFOUpwaEtnTzlYUUttdzZGQmVmVzJa?=
 =?utf-8?B?SDNHa3lhanZNazFlbUVUQUtHOTdhV2pIbWxGcXd0Z2dzdXlrZTdTMUZDVTBn?=
 =?utf-8?B?NTJ2b1NlMU0zWlEyUi9hWmtzbERCbmFjRjRpMmU0TFRMVlB5M3prMjJGbnh5?=
 =?utf-8?B?OGwwakRmbkdFMDh0Vk43dWRMR3JSaEJkcDZ0eTA2YWw1UkJqQWZ3U0NzK05l?=
 =?utf-8?B?c3lkdVZMUUdhSWc1aURqVm05MFNtTWZCS1AwYVlicERRaEhSeEI4UjNCSk5R?=
 =?utf-8?B?a0NXKzhkbUlDdjZldkp6RVhsbmc5dFA4RzlMZ0pURGdweW1JSmw3VEg0dGhX?=
 =?utf-8?B?YWpzVmNmNmRQbUNRck0yeGhoT3ZkUzN0RlZNTkJaWXBRaytaWDIrakw4Y2to?=
 =?utf-8?B?alh2elR4M2ZOcGd5K0U4T1BrZFExRlpHY3M3RC9TQUg0eW1YOWp0a0ZjTisx?=
 =?utf-8?B?N05iaTNpcUlGZmx5YitZNU5lRkc2bG5DcHlKVFlyNW1MTVFkeDB6bGkxcVdh?=
 =?utf-8?B?V2JCRnpYSzVla0wrTm0yaVk5TExXVFNmbFBaUXhhTmEyQTN2OUJYNlZOSkQ5?=
 =?utf-8?B?cmwxd1RPdGNkOW9ZWDJnWTk5ZXJvZFJKL3Zlci9OVkNHbURFYnBzL2ttbGYw?=
 =?utf-8?B?b0JKQlhNUjE0ZVRCb2E1ZFpjWXhWZDBMOGJ1NjNxakk3NTB0ZXdkNm8yd3FT?=
 =?utf-8?B?dWoxWnZjc2VVVUFuaFNiWFcxN0YwZWUzYXordm5sSFNCdGVRSkMxK3Z0YzB6?=
 =?utf-8?B?dHJUVmVqWG1YSUxVM0szYS90SkZ0aGtRcERmdUt5OTJ5eGVQV3dpc3NoeWNB?=
 =?utf-8?Q?+V72g02dZOTO4iEgoUsJF/k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F0319B8733ADF4C8EC9A58B107A0E81@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf131cf-2414-44bc-73f4-08dd890cce5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2025 00:03:45.1039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tgXILQf+yfC7HyhXu2g5/4oD3zEEdZK5UJt2eCrERAv94vCUIFkolbPSyBDxBKy90K2/EQJTlQvQVlK5BkMjkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB6073
X-Authority-Analysis: v=2.4 cv=Z+XsHGRA c=1 sm=1 tr=0 ts=68140be4 cx=c_pps a=SXeWyiAXBtEG6vW+ku2Kqw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=1WtWmnkvAAAA:8 a=YjuIi6ph_Ixi3UFnF2QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: PHdxHFQp6KEn4N0HU_DMTH9uxq3QCovZ
X-Proofpoint-GUID: PHdxHFQp6KEn4N0HU_DMTH9uxq3QCovZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDE3OSBTYWx0ZWRfXxHv51AKIK5m4 aYHKZDlZw6NpT3GhAsiWR6manxyJZ2v4zjL8Tpa4DFz9nrBVz1EuHosuq8NbS7Ejtv69nG30T3h YvrOFchMD70LpBeIEuPLXfjMQbNe4upn6YpM+dn+sO9+8bkrmDuKShwCoXLUVtkmW0qxvx669Ec
 GfYzzK8KlEjZ0LxKLPdmVXvjjGnJ9LAMWDtz7PwaKrNNqJtsgboSRkWbe5LfaisXYuSiSbByuHq KPShT2nC27G1cfTfApxXxX6+Un9jDc8syTxf7ikH15osz2bZe5WCuZVgv7ZBuKiZclcD4x2Hu4C Xni3pQQ9XBCUMIfKFsUQdAGiIMP+P2Lqb3CUHV3LcAOzfdFS5/sM06gb/hRAAC/jt2Rctv5T7X5
 daEnK5HqDz93zGDXM0HVMv5MM03Of5xwnqzrz62FHm39RbqUXcAmjww/iQnjMYR+10jrlw+m
Subject: Re:  [PATCH 2/2] hfs: fix to update ctime after rename
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505010179

T24gVHVlLCAyMDI1LTA0LTI5IGF0IDE0OjE1IC0wNjAwLCBZYW5ndGFvIExpIHdyb3RlOg0KPiBT
aW1pbGFyIHRvIGhmc3BsdXMsIGxldCdzIHVwZGF0ZSBmaWxlIGN0aW1lIGFmdGVyIHRoZSByZW5h
bWUgb3BlcmF0aW9uDQo+IGluIGhmc19yZW5hbWUoKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFlh
bmd0YW8gTGkgPGZyYW5rLmxpQHZpdm8uY29tPg0KPiAtLS0NCj4gIGZzL2hmcy9kaXIuYyB8IDE1
ICsrKysrKysrKystLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDUg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvaGZzL2Rpci5jIGIvZnMvaGZzL2Rp
ci5jDQo+IGluZGV4IDg2YTZiMzE3YjQ3NC4uM2I5NWJhZmIzZjA0IDEwMDY0NA0KPiAtLS0gYS9m
cy9oZnMvZGlyLmMNCj4gKysrIGIvZnMvaGZzL2Rpci5jDQo+IEBAIC0yODQsNiArMjg0LDcgQEAg
c3RhdGljIGludCBoZnNfcmVuYW1lKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLCBzdHJ1Y3QgaW5v
ZGUgKm9sZF9kaXIsDQo+ICAJCSAgICAgIHN0cnVjdCBkZW50cnkgKm9sZF9kZW50cnksIHN0cnVj
dCBpbm9kZSAqbmV3X2RpciwNCj4gIAkJICAgICAgc3RydWN0IGRlbnRyeSAqbmV3X2RlbnRyeSwg
dW5zaWduZWQgaW50IGZsYWdzKQ0KPiAgew0KPiArCXN0cnVjdCBpbm9kZSAqaW5vZGUgPSBkX2lu
b2RlKG9sZF9kZW50cnkpOw0KPiAgCWludCByZXM7DQo+ICANCj4gIAlpZiAoZmxhZ3MgJiB+UkVO
QU1FX05PUkVQTEFDRSkNCj4gQEAgLTI5OSwxMSArMzAwLDE1IEBAIHN0YXRpYyBpbnQgaGZzX3Jl
bmFtZShzdHJ1Y3QgbW50X2lkbWFwICppZG1hcCwgc3RydWN0IGlub2RlICpvbGRfZGlyLA0KPiAg
CXJlcyA9IGhmc19jYXRfbW92ZShkX2lub2RlKG9sZF9kZW50cnkpLT5pX2lubywNCj4gIAkJCSAg
IG9sZF9kaXIsICZvbGRfZGVudHJ5LT5kX25hbWUsDQo+ICAJCQkgICBuZXdfZGlyLCAmbmV3X2Rl
bnRyeS0+ZF9uYW1lKTsNCj4gLQlpZiAoIXJlcykNCj4gLQkJaGZzX2NhdF9idWlsZF9rZXkob2xk
X2Rpci0+aV9zYiwNCj4gLQkJCQkgIChidHJlZV9rZXkgKikmSEZTX0koZF9pbm9kZShvbGRfZGVu
dHJ5KSktPmNhdF9rZXksDQo+IC0JCQkJICBuZXdfZGlyLT5pX2lubywgJm5ld19kZW50cnktPmRf
bmFtZSk7DQo+IC0JcmV0dXJuIHJlczsNCj4gKwlpZiAocmVzKQ0KPiArCQlyZXR1cm4gcmVzOw0K
PiArDQo+ICsJaGZzX2NhdF9idWlsZF9rZXkob2xkX2Rpci0+aV9zYiwNCj4gKwkJCSAgKGJ0cmVl
X2tleSAqKSZIRlNfSShkX2lub2RlKG9sZF9kZW50cnkpKS0+Y2F0X2tleSwNCj4gKwkJCSAgbmV3
X2Rpci0+aV9pbm8sICZuZXdfZGVudHJ5LT5kX25hbWUpOw0KPiArCWlub2RlX3NldF9jdGltZV9j
dXJyZW50KGlub2RlKTsNCj4gKwltYXJrX2lub2RlX2RpcnR5KGlub2RlKTsNCj4gKwlyZXR1cm4g
MDsNCj4gIH0NCj4gIA0KPiAgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBoZnNfZGlyX29w
ZXJhdGlvbnMgPSB7DQoNCkJFRk9SRSBQQVRDSDoNCg0KdW5hbWUgLWENCkxpbnV4IGhmc3BsdXMt
dGVzdGluZy0wMDAxIDYuMTUuMC1yYzQgIzcgU01QIFBSRUVNUFRfRFlOQU1JQyBUaHUgTWF5ICAx
IDE2OjExOjQ5DQpQRFQgMjAyNSB4ODZfNjQgeDg2XzY0IHg4Nl82NCBHTlUvTGludXgNCg0Kc3Vk
byAuL2NoZWNrIGdlbmVyaWMvMDAzDQpGU1RZUCAgICAgICAgIC0tIGhmcw0KUExBVEZPUk0gICAg
ICAtLSBMaW51eC94ODZfNjQgaGZzcGx1cy10ZXN0aW5nLTAwMDEgNi4xNS4wLXJjNCAjNyBTTVAN
ClBSRUVNUFRfRFlOQU1JQyBUaHUgTWF5ICAxIDE2OjExOjQ5IFBEVCAyMDI1DQpNS0ZTX09QVElP
TlMgIC0tIC9kZXYvbG9vcDUxDQpNT1VOVF9PUFRJT05TIC0tIC9kZXYvbG9vcDUxIC9tbnQvc2Ny
YXRjaA0KDQpnZW5lcmljLzAwMyAgICAgICAtIG91dHB1dCBtaXNtYXRjaCAoc2VlIC9ob21lL3Ns
YXZhZC9YRlNURVNUUy0yL3hmc3Rlc3RzLQ0KZGV2L3Jlc3VsdHMvL2dlbmVyaWMvMDAzLm91dC5i
YWQpDQogICAgLS0tIHRlc3RzL2dlbmVyaWMvMDAzLm91dAkyMDI1LTA0LTI0IDEyOjQ4OjQ1Ljg4
NjE2NDMzNSAtMDcwMA0KICAgICsrKyAvaG9tZS9zbGF2YWQvWEZTVEVTVFMtMi94ZnN0ZXN0cy0N
CmRldi9yZXN1bHRzLy9nZW5lcmljLzAwMy5vdXQuYmFkCTIwMjUtMDUtMDEgMTY6MzY6MzguNjA4
NTkxMzE3IC0wNzAwDQogICAgQEAgLTEsMiArMSw2IEBADQogICAgIFFBIG91dHB1dCBjcmVhdGVk
IGJ5IDAwMw0KICAgICtFUlJPUjogYWNjZXNzIHRpbWUgaGFzIGNoYW5nZWQgZm9yIGZpbGUxIGFm
dGVyIHJlbW91bnQNCiAgICArRVJST1I6IGFjY2VzcyB0aW1lIGhhcyBjaGFuZ2VkIGFmdGVyIG1v
ZGlmeWluZyBmaWxlMQ0KICAgICtFUlJPUjogY2hhbmdlIHRpbWUgaGFzIG5vdCBiZWVuIHVwZGF0
ZWQgYWZ0ZXIgY2hhbmdpbmcgZmlsZTENCiAgICArRVJST1I6IGFjY2VzcyB0aW1lIGhhcyBjaGFu
Z2VkIGZvciBmaWxlIGluIHJlYWQtb25seSBmaWxlc3lzdGVtDQogICAgIFNpbGVuY2UgaXMgZ29s
ZGVuDQogICAgLi4uDQogICAgKFJ1biAnZGlmZiAtdSAvaG9tZS9zbGF2YWQvWEZTVEVTVFMtMi94
ZnN0ZXN0cy1kZXYvdGVzdHMvZ2VuZXJpYy8wMDMub3V0DQovaG9tZS9zbGF2YWQvWEZTVEVTVFMt
Mi94ZnN0ZXN0cy1kZXYvcmVzdWx0cy8vZ2VuZXJpYy8wMDMub3V0LmJhZCcgIHRvIHNlZSB0aGUN
CmVudGlyZSBkaWZmKQ0KUmFuOiBnZW5lcmljLzAwMw0KRmFpbHVyZXM6IGdlbmVyaWMvMDAzDQpG
YWlsZWQgMSBvZiAxIHRlc3RzDQoNCldJVEggQVBQTElFRCBQQVRDSDoNCg0KdW5hbWUgLWENCkxp
bnV4IGhmc3BsdXMtdGVzdGluZy0wMDAxIDYuMTUuMC1yYzQrICM4IFNNUCBQUkVFTVBUX0RZTkFN
SUMgVGh1IE1heSAgMQ0KMTY6NDM6MjIgUERUIDIwMjUgeDg2XzY0IHg4Nl82NCB4ODZfNjQgR05V
L0xpbnV4DQoNCnN1ZG8gLi9jaGVjayBnZW5lcmljLzAwMw0KRlNUWVAgICAgICAgICAtLSBoZnMN
ClBMQVRGT1JNICAgICAgLS0gTGludXgveDg2XzY0IGhmc3BsdXMtdGVzdGluZy0wMDAxIDYuMTUu
MC1yYzQrICM4IFNNUA0KUFJFRU1QVF9EWU5BTUlDIFRodSBNYXkgIDEgMTY6NDM6MjIgUERUIDIw
MjUNCk1LRlNfT1BUSU9OUyAgLS0gL2Rldi9sb29wNTENCk1PVU5UX09QVElPTlMgLS0gL2Rldi9s
b29wNTEgL21udC9zY3JhdGNoDQoNCmdlbmVyaWMvMDAzICAgICAgIC0gb3V0cHV0IG1pc21hdGNo
IChzZWUgL2hvbWUvc2xhdmFkL1hGU1RFU1RTLTIveGZzdGVzdHMtDQpkZXYvcmVzdWx0cy8vZ2Vu
ZXJpYy8wMDMub3V0LmJhZCkNCiAgICAtLS0gdGVzdHMvZ2VuZXJpYy8wMDMub3V0CTIwMjUtMDQt
MjQgMTI6NDg6NDUuODg2MTY0MzM1IC0wNzAwDQogICAgKysrIC9ob21lL3NsYXZhZC9YRlNURVNU
Uy0yL3hmc3Rlc3RzLQ0KZGV2L3Jlc3VsdHMvL2dlbmVyaWMvMDAzLm91dC5iYWQJMjAyNS0wNS0w
MSAxNjo1Mzo1Ni42Mjg3MzQyNTcgLTA3MDANCiAgICBAQCAtMSwyICsxLDUgQEANCiAgICAgUUEg
b3V0cHV0IGNyZWF0ZWQgYnkgMDAzDQogICAgK0VSUk9SOiBhY2Nlc3MgdGltZSBoYXMgY2hhbmdl
ZCBmb3IgZmlsZTEgYWZ0ZXIgcmVtb3VudA0KICAgICtFUlJPUjogYWNjZXNzIHRpbWUgaGFzIGNo
YW5nZWQgYWZ0ZXIgbW9kaWZ5aW5nIGZpbGUxDQogICAgK0VSUk9SOiBhY2Nlc3MgdGltZSBoYXMg
Y2hhbmdlZCBmb3IgZmlsZSBpbiByZWFkLW9ubHkgZmlsZXN5c3RlbQ0KICAgICBTaWxlbmNlIGlz
IGdvbGRlbg0KICAgIC4uLg0KICAgIChSdW4gJ2RpZmYgLXUgL2hvbWUvc2xhdmFkL1hGU1RFU1RT
LTIveGZzdGVzdHMtZGV2L3Rlc3RzL2dlbmVyaWMvMDAzLm91dA0KL2hvbWUvc2xhdmFkL1hGU1RF
U1RTLTIveGZzdGVzdHMtZGV2L3Jlc3VsdHMvL2dlbmVyaWMvMDAzLm91dC5iYWQnICB0byBzZWUg
dGhlDQplbnRpcmUgZGlmZikNClJhbjogZ2VuZXJpYy8wMDMNCkZhaWx1cmVzOiBnZW5lcmljLzAw
Mw0KRmFpbGVkIDEgb2YgMSB0ZXN0cw0KDQpJdCBsb29rcyBsaWtlIHRoYXQgaXQgaXMgbm90IHRo
ZSB3aG9sZSBmaXggb2YgdGhlIGlzc3VlIGZvciBIRlMgY2FzZS4NCg0KVGhhbmtzLA0KU2xhdmEu
DQoNCg==

