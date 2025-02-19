Return-Path: <linux-fsdevel+bounces-42027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FD6A3AE48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 02:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C81D7A60A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 01:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E58614375D;
	Wed, 19 Feb 2025 00:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c0R/njvy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D183676025;
	Wed, 19 Feb 2025 00:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739926767; cv=fail; b=jFDgBo66u7+0Sj32bqUzsGLExSsxkFJtkhs7lzz6S95c1Szf8hmAFTvcQmNBJKQrr17t64C6zN77pqgmXSlGzok2OxATzOcOmh5JdjrLdV4R2GsC1HzAC19UElaK/1fyAVWspr14Rkn7DYz+7YlCzM9gW8LnCuhq/6pcq4Dy8yY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739926767; c=relaxed/simple;
	bh=qiXeu9RiywvZtzhsj2wLOMCdM5GidcQdv6PVV7Yh1DY=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=UmO341drDauSp1xSp5p4ZPfeiQ5N95WyW4V2WdOQ3WTotfUEVug74319Lex+4pK6LLwds1CuyyC0+ZEZnvm3c4hbSzRqcKoeHAyEQLQ2dPitd5Qdn7hETW8uC9bOil7QAr3r8L+HYOM6DWCEYSEtLKWTBgdVAtPULPs301irPcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c0R/njvy; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IMnogR005164;
	Wed, 19 Feb 2025 00:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=qiXeu9RiywvZtzhsj2wLOMCdM5GidcQdv6PVV7Yh1DY=; b=c0R/njvy
	a3ajH+D6jTwR3i68DMzJu2ajFQSskK95uSqHCwqqzh0W6JBjtZqlbh1dNTLDcLFW
	w8VT4RisX7HY5lSjV15CycuHa92lTY8+0cs8aTkqv9N1LNhA8VQBpvtxLxqhk90j
	ibSn1w2Ewk02PPCMTy6/iz4VTAN9hTrB1Mm9GYAErNPTVXqbcflN5evlDusj8Sfs
	Z7gp5HmUkO5k5R8ce3w8wKKIXyPQJCFLPtMpNZL4jm1WiQqOyKrr3Y+xUqRBMrsx
	s8doKAehjBg/uEtS2kuY2AbyHpzlWh6K16K0bUkaShZv69xSK9F9QWh5e2ereqEh
	2njuXFJUt2G28g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44w3ba0c5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 00:59:08 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51J0vg37015419;
	Wed, 19 Feb 2025 00:59:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44w3ba0c5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 00:59:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9YzgMUNX8/caEjOya5ROQa/baSOjV0RZnrzLh/ViG09gvQkImtryL3yIjzwzYm+QjP7leSnwdSX4pPmZFUfL6kksUb0Vs1Dzgr/4GV2VX8Zz1KwHzwOztGmwBdypihky4TsHwXf2ijmGu1WbZ7/3AcqRv1Yhg9cJvuQQEImXxZQoTQgjzuO1DwB9IzwFsgT4RZuobrehvdakIGcdFDkHjDCc3Dnwe9UGw75BVMPnHOlKHgWjzaloka3T/puzcNeTV91Vxha7PxnSKORWtsC+Vr2GdMxVB/Qs3cwYTDAxkqg6qx6liHN7/x37zJYJ+Gne0aMjJUbWiUhy1wRjPWrng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qiXeu9RiywvZtzhsj2wLOMCdM5GidcQdv6PVV7Yh1DY=;
 b=gqfqkoIsy2mIQvgVLJWFin85mq18hQiWhik9g4faM+tzX/laSal9kQVopd7C68MLQ3gCmf8UsCogr9cT/BzI26SJjuKDWgIMwcKdAacgHQtjfPUQxQRhg1w0wXsfcQpz2ObDf3Plo/GzM8JLbz2Zi3/pKZ0N7pC5vCbttB0hFBP5JsNg1I/v5hXDGkjwAgrVTL0vO8K//5EbL1uVLC6kIr6wwo9ZhabfQq+mgDB3fpBLbHnfb8HaZOhtykhjHYCtFCtU+t+w62mqiTxirauzCJ1g+UHU12KWN7708YIwNsvQ252Sj12SHCWYBIfbfRUa+/iL7GkjorCrmXh/MlaNvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA3PR15MB5679.namprd15.prod.outlook.com (2603:10b6:806:314::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 19 Feb
 2025 00:58:54 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%4]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 00:58:54 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC: "luis@igalia.com" <luis@igalia.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>
Thread-Topic: [EXTERNAL] Re: [RFC] odd check in ceph_encode_encrypted_dname()
Thread-Index:
 AQHbfpCIos2EbKYFiUGV+rHGHxWwQbNG8KKAgAAHCy2AANRJAIAAtn1ygANLFYCAAA6HuYAANr0AgAA29QCAAXmIAIAAEnmA
Date: Wed, 19 Feb 2025 00:58:54 +0000
Message-ID: <4a704933b76aa4db0572646008e929d41dd96d6e.camel@ibm.com>
References: <20250214024756.GY1977892@ZenIV>	 <20250214032820.GZ1977892@ZenIV>
	 <bbc3361f9c241942f44298286ba09b087a10b78b.camel@kernel.org>
	 <87frkg7bqh.fsf@igalia.com> <20250215044616.GF1977892@ZenIV>
	 <877c5rxlng.fsf@igalia.com>
	 <4ac938a32997798a0b76189b33d6e4d65c23a32f.camel@ibm.com>
	 <87cyfgwgok.fsf@igalia.com>
	 <2e026bd7688e95440771b7ad4b44b57ab82535f6.camel@ibm.com>
	 <20250218012132.GJ1977892@ZenIV> <20250218235246.GA191109@ZenIV>
In-Reply-To: <20250218235246.GA191109@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA3PR15MB5679:EE_
x-ms-office365-filtering-correlation-id: fde4f46a-3488-4fe5-6e46-08dd508094fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aitRTHJNYmJ1N3V1SFNxQUlybUN3eEFla1Y4N3UwanNBbDI5ck5SN1locjZ5?=
 =?utf-8?B?bkFPZnJxTHZzaEJIbU1iWmxIbFZndjlyYzFSeENqSENpSm9HOU1lWTRZN3BD?=
 =?utf-8?B?S1Z6VjlBV0ZJL1FFVzRTNHJKVXVtRUZaWlRKUkJLQ3RLeWx3REdKSmVMeFdw?=
 =?utf-8?B?YW5DUHlIbXJ5WmZoV21DaE5lLzZGWFRwTjIzdTBjbkZBWDVIYk5SczhKOTNG?=
 =?utf-8?B?T2U0MGhTSVJLK1ZEaW1EM3FzYk9XckhacmhleU9WcnVrY0VBNnozR3NjNzFl?=
 =?utf-8?B?cDZVb3BtTzlkWDZQSTBLVUNkQVA1T05jdjZPZlpYa3FBYWpXc3hIVFllTkVz?=
 =?utf-8?B?QTlzSFhFdUVvNFdsL0k0dU9lem1KS0FYTU9TOFI3RjA5am0wNTZ4UXBxbUJH?=
 =?utf-8?B?YVRadFpma2cyWlB2K0xsa042L2pWanFPUGNpRnExTFU4bjU2SStYU09NYXlt?=
 =?utf-8?B?OWJFK3hKTGplc09DYjFZZFR5eGVDUEQ2S29admYxTWpYbHZXaCt6S3o2WjFu?=
 =?utf-8?B?WjR5Ynk4bkNpQlI3V3d1dEZWRTE3MWIzUkpOUDRxbVluOTZXcmIyU2U4aldv?=
 =?utf-8?B?L3M0MEpaTitLWVdDOXNiZW13R2VKVGpZM2Y3bVpJUTNCWUVwY21jdWU5N0pw?=
 =?utf-8?B?R0xMa1UxRlFwdTJlRzhQbW8vVkY2OHpzeHdIeTJkTEZlWVByQlFhNEhrelIr?=
 =?utf-8?B?SXNLa2t3SzJ3Qzgyd2laelMzRmo2czRUOFozL1ZHeXNOTENhclh0OFBwSGJk?=
 =?utf-8?B?dnJoTXhRR2U3RUgyZURpeStlWFJlWVI2Sk5wSGNPa0V0ZDZKOERLK0JMeStp?=
 =?utf-8?B?cmFraHJGK0pIYU8vaG1jNWV4U1MvSCtTQ3pRNSt3UkxMeGdia2owN0ZWaXpa?=
 =?utf-8?B?aHA3MWowSHNqdkNrazYwUUQ3YjNPMXJOY1czdWhGakYrVXVFT25WMnVtRll2?=
 =?utf-8?B?Z0VYdGJMNlRxbmQ5Z0ZQc0VITXhseEV5aHBkaWVublJDNUx3djB2M3RnYkpY?=
 =?utf-8?B?ZzM3R255NzFyZ1BDdnZLbWNJajlqLzlRbmF6SnR1MjFzSkk3ZDU0VG12aEpw?=
 =?utf-8?B?YVcyc0dYdStqdG1zWEdZK0wyMTVVeVdDaXdzSW5xNDRLODNzZGdyWDJ3cDJp?=
 =?utf-8?B?Znl3RFJmdnVQc3piOC90T1NsTHJOTFI4eFJkVkJYWVRvdTdxOVdmZ3RrTk8v?=
 =?utf-8?B?bHBuYk9qL2hLOGNWVndjTnUwK1FDSWxtY0RuNGhpckNqMjhVaGhRc3VhQm1U?=
 =?utf-8?B?QU5IaGxoRy8weUllaWJaYitDVSsraERTd2IwZlYzTXI5RmRidi92ZE9ZbTNE?=
 =?utf-8?B?WmpaTU9uS1NiTVovV2VLd3UvNU9YcGQzSVdjaE9ZRnlMcUxWUnNyZEduNkUx?=
 =?utf-8?B?QVR3TVhwS1N1UDIyamJYMjlwRWYwR1NPbTFXQWJxYkhiUFRkMjJGSmNLdUZm?=
 =?utf-8?B?ZXlHNit3WWlPTzVzYWdOcWQwMG54TjVsZTkwV2dvYUxwT2NCbFdGaXZwemNG?=
 =?utf-8?B?eE5naGIySXZSMEFRUVVkTWFNUU1WWFpUU21vK0xmQU1nUG96RmxYczg5WE1a?=
 =?utf-8?B?YWxTd0NBM2ZVVGlUcXM2TGc0UjErbzdPQVd2L2tmdXdLbDcwWnBQeERDUWJU?=
 =?utf-8?B?TjY5MGxLZzNHK1YxL0wrWFlIS28rRWlIWUV0UitjczhsdUtrYzViYlNURGJj?=
 =?utf-8?B?RHE3M2VvNGpvS054YzJSL0tRL1V4dTZtamhnM0VCMk9ndXZnY01Jb1BKNlJS?=
 =?utf-8?B?cVB1a1VtUG50REJoTitrOEdDQUdTMlhyWisxN3dxTWNJaldkZWw0MXQwSWtw?=
 =?utf-8?B?aGFEOGRVTHN4M1E4eFUxSng1RDI2K2UxSUJIdjJjVS9VcWRjMzVtT3ZqWko1?=
 =?utf-8?B?WjRubmovZTJabTB2dzRMSDQ1NlJtTjlwSFJyZHgrRHRzRGJUSi9JSHhMdmFX?=
 =?utf-8?Q?roH4iTd4EseWRdVQ7B4fW53/d9yITJcB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U0FqdTVzM3hPRldtSk00SkE5eXROVjhWM2Y3ZkRibzFBVEx4UzVOd0FSajIy?=
 =?utf-8?B?SWJBQWRPVkJkYkV5U1VpU2ZpUWlHNU9ETXRmdnRLN20xcTJ0akJDNlVrREtS?=
 =?utf-8?B?cVArQjRVOVJIRGJ4VnhJMUFTQ2Q5dGtYWGxHUkU4ME9laTYrUWl4ZUhNeHV4?=
 =?utf-8?B?TzFaSlR2ekE3WG5UT050MHhKRFpSdm84VjY3K1ovOEdLVlNXK3MrYWM5V1Nu?=
 =?utf-8?B?R3QrOTIySU51VjBsOVdUT0VkVTNzTGIzdzVTMmZ1M1JLMDllbko4R0hoL09z?=
 =?utf-8?B?b3Jya0xxREcrVkxReFdKNjRXblNadTluQzlaa3pOVVFFdzNOY2RCZlQvUTNa?=
 =?utf-8?B?ZFRDcG5OVmFjNFRDbSs3U0l2NlVzdWNCRVdqQnZsQjNqMDVtbUhHU0VJVVRT?=
 =?utf-8?B?SDFHTllBaXZkM21CeHEzRXJTdFZtWXJXZFVzbVRrYlIzM3kwWjBYMUFOdnZW?=
 =?utf-8?B?ZTloMzJKbC9Pc0d6RzhiWEo4MkRSUTduR0hLWTNrRExCRVVXR0pNWkZ6cWNy?=
 =?utf-8?B?MVdWMFNlNWhXNnlqQ1dQSXYwWjl2S3NoQnZqZ0t3S0RvYlk2WVVqY0NKcEF1?=
 =?utf-8?B?L0ZGRjJ3Y29RdnBYK2NJL2FaVFV4OXUzNnRzUVhSRjFEUzNmSDBURXh2OStU?=
 =?utf-8?B?SnBWSWI1OXZqSWFNTU96MWk0V0pxV3pkRVFySE1pQzg3ZEVQcTViSnZBcFY3?=
 =?utf-8?B?dlRmS3VYVkg2aGtpRTR3UHF3T05XTFI0ak82ZEZTd0psUHZFMVIxdE1EVmND?=
 =?utf-8?B?NjFUVmh4TjFtOW9uRXlBaCtTSERYWW11aEE0dStIb1h2NjNQZi9MVUsrWEFS?=
 =?utf-8?B?WkZ3dmQvaVZGTGFQSFhNaTJUN0pGTjdNeTdDU25wZWZRUG12MmNTczNjbkxl?=
 =?utf-8?B?NHVWL1ljSW9MMmROMXA3VFNkT3RvajQzUitQZUJvM3ZOa3lQTWRlU0xvT1RK?=
 =?utf-8?B?cW9QeDA1blJqRG91cjcyTVc2NWtkREZhaUJ2MW5jdkdJdHNFSnJ6eXlYL1RN?=
 =?utf-8?B?UFA2amJ4UGZrbVFZa3JNbW5DQmhFaFBnbXNkV0VCWWtJN2NGZGVOaVBjRmdH?=
 =?utf-8?B?N09nTGZQQUkzYkwyUU5SQ1IzU1RJU1M1NWl2cE1RN2s0SVVsaGVUWTMvUTlY?=
 =?utf-8?B?NGRmZGE1WS9EcEhPc0ozOFdYaFYydVJwbmJ1dC9JZk9EZ2c0SlI1bm5TQzNy?=
 =?utf-8?B?ZGxYVVRJNUF5RmQxelowSURBM3FLZ2xqdDBOb1JMcUFmOTZtSHg4TldDTUt1?=
 =?utf-8?B?UWZMU0R1NURXWlVJMkt0NmZWNGtnNUQvWk5QaUkwcml0ekJLY2VvN2pKbXdl?=
 =?utf-8?B?MG1kVjZpemxWOUIycEMzamJUZGZ1NzNmNTB2UTVzWm5FSWMyTnhkdDNLSWVP?=
 =?utf-8?B?dy9PeTdxNGQvb2lobTYwVVN2WWxWQkZUUHJ0MFdvcVRLajRncndaMkZlOGVB?=
 =?utf-8?B?eG0vb3N3TSt4K0dTakpmUmlmQ3Jnc25wRUo0RHptamU5bGJvdzJ6MXpJK3dw?=
 =?utf-8?B?ZTlpakxGcHpYL2EwZ1M4ekRVK1gxbmw3eDlaVElpZndYLzl5TFVYem40dDZ2?=
 =?utf-8?B?Qm8vSENSR29sdWtpYXhzMUJYckFwU2gzRkIzQU9PY1czcmpDYjJ6a0psb3pz?=
 =?utf-8?B?MXJNU3FwWDRJZGJ5YWhkTUg3c0JGRk9qa0s5MExmRm1IZDc3V2JzbnUwTHpH?=
 =?utf-8?B?MVVlNnZZUVdRZVFkVVlyV2RuV3hXSWlERm93Tjk1N2dQMTl4T1VNK1dzQmFM?=
 =?utf-8?B?N0cyWTZTVHlJUmt6N1QwT1p3d2RUcGJLTU84UmhWM0hYcDVKK3dzUE10bjdT?=
 =?utf-8?B?U2ZmSHpCZ2YwZ1FmWmJ3cVVPMXBTcDNVZ0hEVWdxaGJqMVN4NkJPOTR3NEpS?=
 =?utf-8?B?Y25hMmNObm85WjNCS1JidTNoeU5ZN1pjdmVodlRZa3ZEak5VRGZadzNhd0dq?=
 =?utf-8?B?THVlQTRSYnNVeU10Q0NuZktLbkFNOHBWR2NHTU0zMk9FZ0hmWllkeFFjZUVS?=
 =?utf-8?B?QXM2NDlUTVFTbHp1OGY3aFR0Sk1TNmVXV2ZjcWhXRHd3VzljQUxrZDVRUC9o?=
 =?utf-8?B?bjFrSytvVU41SmxaN0FvZ1h1dWRnOW9NVS9FTGJBVG9NQjd0MVlQUW9LWkN3?=
 =?utf-8?B?Y2hyeE5yaU5meHRUTjhFRGJCUUhYWHNMVTZkT2owdXZVWkprUWhZZElzUmVt?=
 =?utf-8?Q?kedorCq3ftsYG2eGgHEzdO8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82379A901A3DBA48A41EDF2D39E5CE5F@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fde4f46a-3488-4fe5-6e46-08dd508094fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 00:58:54.1395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QKsQtUdsXqFRJIGlANu7GXfh8BqMvyq5evfhr9SuId3mtnqxtibmLVclqrvzmljxfNIL4cAAT2NG1BYSdnsYnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB5679
X-Proofpoint-ORIG-GUID: tOUwv0KzoEtoBXhp-Pw2-q5CDPUmnX1B
X-Proofpoint-GUID: 2UHgu5vSqsZx9Em0sYeVR0Pg-wADv-d1
Subject: RE: [RFC] odd check in ceph_encode_encrypted_dname()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_11,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190005

T24gVHVlLCAyMDI1LTAyLTE4IGF0IDIzOjUyICswMDAwLCBBbCBWaXJvIHdyb3RlOg0KPiBPbiBU
dWUsIEZlYiAxOCwgMjAyNSBhdCAwMToyMTozMkFNICswMDAwLCBBbCBWaXJvIHdyb3RlOg0KPiAN
Cj4gPiBTZWUgdGhlIHByb2JsZW0/ICBzdHJyY2hyKCkgZXhwZWN0cyBhIE5VTC10ZXJtaW5hdGVk
IHN0cmluZzsgZ2l2aW5nIGl0IGFuDQo+ID4gYXJyYXkgdGhhdCBoYXMgbm8gemVybyBieXRlcyBp
biBpdCBpcyBhbiBVQi4NCj4gPiANCj4gPiBUaGF0IG9uZSBpcyAtc3RhYmxlIGZvZGRlciBvbiBp
dHMgb3duLCBJTU8uLi4NCj4gDQo+IEZXSVcsIGl0J3MgbW9yZSB1bnBsZWFzYW50OyB0aGVyZSBh
cmUgb3RoZXIgY2FsbCBjaGFpbnMgZm9yIHBhcnNlX2xvbmduYW1lKCkNCj4gd2hlcmUgaXQncyBu
b3QgZmVhc2libGUgdG8gTlVMLXRlcm1pbmF0ZSBpbiBwbGFjZS4gIEkgc3VzcGVjdCB0aGF0IHRo
ZQ0KPiBwYXRjaCBiZWxvdyBpcyBhIGJldHRlciB3YXkgdG8gaGFuZGxlIHRoYXQuICBDb21tZW50
cz8NCj4gDQoNCkxldCBtZSB0ZXN0IHRoZSBwYXRjaC4NCg0KPiBGcm9tIGVkMDE2ZTVlYTg5NTUw
YjU2NzMwNjIwN2JhM2NhOGI2MGUxNDdkODkgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxDQo+IEZy
b206IEFsIFZpcm8gPHZpcm9AemVuaXYubGludXgub3JnLnVrPg0KPiBEYXRlOiBUdWUsIDE4IEZl
YiAyMDI1IDE3OjU3OjE3IC0wNTAwDQo+IFN1YmplY3Q6IFtQQVRDSCAxLzNdIFtjZXBoXSBwYXJz
ZV9sb25nbmFtZSgpOiBzdHJyY2hyKCkgZXhwZWN0cyBOVUwtdGVybWluYXRlZA0KPiAgc3RyaW5n
DQo+IA0KPiAuLi4gYW5kIHBhcnNlX2xvbmduYW1lKCkgaXMgbm90IGd1YXJhbnRlZWQgdGhhdC4g
IFRoYXQncyB0aGUgcmVhc29uDQo+IHdoeSBpdCB1c2VzIGttZW1kdXBfbnVsKCkgdG8gYnVpbGQg
dGhlIGFyZ3VtZW50IGZvciBrc3RydG91NjQoKTsNCj4gdGhlIHByb2JsZW0gaXMsIGtzdHJ0b3U2
NCgpIGlzIG5vdCB0aGUgb25seSB0aGluZyB0aGF0IG5lZWQgaXQuDQo+IA0KPiBKdXN0IGdldCBh
IE5VTC10ZXJtaW5hdGVkIGNvcHkgb2YgdGhlIGVudGlyZSB0aGluZyBhbmQgYmUgZG9uZQ0KPiB3
aXRoIHRoYXQuLi4NCj4gDQo+IEZpeGVzOiBkZDY2ZGYwMDUzZWYgImNlcGg6IGFkZCBzdXBwb3J0
IGZvciBlbmNyeXB0ZWQgc25hcHNob3QgbmFtZXMiDQo+IFNpZ25lZC1vZmYtYnk6IEFsIFZpcm8g
PHZpcm9AemVuaXYubGludXgub3JnLnVrPg0KPiAtLS0NCj4gIGZzL2NlcGgvY3J5cHRvLmMgfCAz
MiArKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEy
IGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2Nl
cGgvY3J5cHRvLmMgYi9mcy9jZXBoL2NyeXB0by5jDQo+IGluZGV4IDNiM2M0ZDhkNDAxZS4uMTY0
ZTc5ODFhZWNiIDEwMDY0NA0KPiAtLS0gYS9mcy9jZXBoL2NyeXB0by5jDQo+ICsrKyBiL2ZzL2Nl
cGgvY3J5cHRvLmMNCj4gQEAgLTIxNSwzNSArMjE1LDMwIEBAIHN0YXRpYyBzdHJ1Y3QgaW5vZGUg
KnBhcnNlX2xvbmduYW1lKGNvbnN0IHN0cnVjdCBpbm9kZSAqcGFyZW50LA0KPiAgCXN0cnVjdCBj
ZXBoX2NsaWVudCAqY2wgPSBjZXBoX2lub2RlX3RvX2NsaWVudChwYXJlbnQpOw0KPiAgCXN0cnVj
dCBpbm9kZSAqZGlyID0gTlVMTDsNCj4gIAlzdHJ1Y3QgY2VwaF92aW5vIHZpbm8gPSB7IC5zbmFw
ID0gQ0VQSF9OT1NOQVAgfTsNCj4gLQljaGFyICppbm9kZV9udW1iZXI7DQo+ICAJY2hhciAqbmFt
ZV9lbmQ7DQo+IC0JaW50IG9yaWdfbGVuID0gKm5hbWVfbGVuOw0KPiAgCWludCByZXQgPSAtRUlP
Ow0KPiAtDQo+ICsJLyogTlVMLXRlcm1pbmF0ZSAqLw0KPiArCWNoYXIgKnMgX19mcmVlKGtmcmVl
KSA9IGttZW1kdXBfbnVsKG5hbWUsICpuYW1lX2xlbiwgR0ZQX0tFUk5FTCk7DQoNCk1heWJlLCBz
dHIgaGVyZT8gVGhlIHMgbG9va3MgdG9vIGV4dHJlbWUgZm9yIG15IHRhc3RlLiA6KQ0KDQo+ICsJ
aWYgKCFzKQ0KPiArCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gIAkvKiBTa2lwIGluaXRp
YWwgJ18nICovDQo+IC0JbmFtZSsrOw0KPiAtCW5hbWVfZW5kID0gc3RycmNocihuYW1lLCAnXycp
Ow0KPiArCXMrKzsNCj4gKwluYW1lX2VuZCA9IHN0cnJjaHIocywgJ18nKTsNCj4gIAlpZiAoIW5h
bWVfZW5kKSB7DQo+IC0JCWRvdXRjKGNsLCAiZmFpbGVkIHRvIHBhcnNlIGxvbmcgc25hcHNob3Qg
bmFtZTogJXNcbiIsIG5hbWUpOw0KPiArCQlkb3V0YyhjbCwgImZhaWxlZCB0byBwYXJzZSBsb25n
IHNuYXBzaG90IG5hbWU6ICVzXG4iLCBzKTsNCj4gIAkJcmV0dXJuIEVSUl9QVFIoLUVJTyk7DQo+
ICAJfQ0KPiAtCSpuYW1lX2xlbiA9IChuYW1lX2VuZCAtIG5hbWUpOw0KPiArCSpuYW1lX2xlbiA9
IChuYW1lX2VuZCAtIHMpOw0KPiAgCWlmICgqbmFtZV9sZW4gPD0gMCkgew0KPiAgCQlwcl9lcnJf
Y2xpZW50KGNsLCAiZmFpbGVkIHRvIHBhcnNlIGxvbmcgc25hcHNob3QgbmFtZVxuIik7DQo+ICAJ
CXJldHVybiBFUlJfUFRSKC1FSU8pOw0KPiAgCX0NCj4gIA0KPiAgCS8qIEdldCB0aGUgaW5vZGUg
bnVtYmVyICovDQo+IC0JaW5vZGVfbnVtYmVyID0ga21lbWR1cF9udWwobmFtZV9lbmQgKyAxLA0K
PiAtCQkJCSAgIG9yaWdfbGVuIC0gKm5hbWVfbGVuIC0gMiwNCj4gLQkJCQkgICBHRlBfS0VSTkVM
KTsNCj4gLQlpZiAoIWlub2RlX251bWJlcikNCj4gLQkJcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7
DQo+IC0JcmV0ID0ga3N0cnRvdTY0KGlub2RlX251bWJlciwgMTAsICZ2aW5vLmlubyk7DQo+ICsJ
cmV0ID0ga3N0cnRvdTY0KG5hbWVfZW5kICsgMSwgMTAsICZ2aW5vLmlubyk7DQoNClRoZSBpbm9k
ZV9udW1iZXIgZXhwbGFpbnMgYnkgaXRzZWxmIHdoYXQgd2UgYXJlIGNvbnZlcnRpbmcgaGVyZS4g
QnV0IG5hbWVfZW5kDQpzb3VuZHMgY29uZnVzaW5nIGFuZCBub3QgaW5mb3JtYXRpdmUgZm9yIG15
IHRhc3RlLiBCdXQgSSBjb3VsZCBoYXZlIGEgYmFkIHRhc3RlLg0KOikNCg0KPiAgCWlmIChyZXQp
IHsNCj4gLQkJZG91dGMoY2wsICJmYWlsZWQgdG8gcGFyc2UgaW5vZGUgbnVtYmVyOiAlc1xuIiwg
bmFtZSk7DQo+IC0JCWRpciA9IEVSUl9QVFIocmV0KTsNCj4gLQkJZ290byBvdXQ7DQo+ICsJCWRv
dXRjKGNsLCAiZmFpbGVkIHRvIHBhcnNlIGlub2RlIG51bWJlcjogJXNcbiIsIHMpOw0KPiArCQly
ZXR1cm4gRVJSX1BUUihyZXQpOw0KPiAgCX0NCj4gIA0KPiAgCS8qIEFuZCBmaW5hbGx5IHRoZSBp
bm9kZSAqLw0KPiBAQCAtMjUyLDExICsyNDcsOCBAQCBzdGF0aWMgc3RydWN0IGlub2RlICpwYXJz
ZV9sb25nbmFtZShjb25zdCBzdHJ1Y3QgaW5vZGUgKnBhcmVudCwNCj4gIAkJLyogVGhpcyBjYW4g
aGFwcGVuIGlmIHdlJ3JlIG5vdCBtb3VudGluZyBjZXBoZnMgb24gdGhlIHJvb3QgKi8NCj4gIAkJ
ZGlyID0gY2VwaF9nZXRfaW5vZGUocGFyZW50LT5pX3NiLCB2aW5vLCBOVUxMKTsNCj4gIAkJaWYg
KElTX0VSUihkaXIpKQ0KPiAtCQkJZG91dGMoY2wsICJjYW4ndCBmaW5kIGlub2RlICVzICglcylc
biIsIGlub2RlX251bWJlciwgbmFtZSk7DQo+ICsJCQlkb3V0YyhjbCwgImNhbid0IGZpbmQgaW5v
ZGUgJXMgKCVzKVxuIiwgbmFtZV9lbmQgKyAxLCBuYW1lKTsNCg0KSXQncyBub3QgY3JpdGljYWws
IGJ1dCB3ZSB1c2UgbmFtZV9lbmQgKyAxIHR3byB0aW1lcy4gUG90ZW50aWFsbHksIGl0IGNvdWxk
IGJlIGENCnNvdXJjZSBvZiBzb21lYm9keSBtaXN0YWtlIGluIHRoZSBmdXR1cmUuDQoNClRoYW5r
cywNClNsYXZhLg0KDQo+ICAJfQ0KPiAtDQo+IC1vdXQ6DQo+IC0Ja2ZyZWUoaW5vZGVfbnVtYmVy
KTsNCj4gIAlyZXR1cm4gZGlyOw0KPiAgfQ0KPiAgDQoNCg==

