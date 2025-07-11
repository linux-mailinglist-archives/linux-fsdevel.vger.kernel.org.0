Return-Path: <linux-fsdevel+bounces-54683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0305B0227C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 19:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB94A1CC111E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 17:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F4B2EF65B;
	Fri, 11 Jul 2025 17:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R4NCe4rh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DE32ED160
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752254476; cv=fail; b=O4kAYTNoEC11BnZInt5mlUquUoSF4xYqHOPvl0myiP3An0Zt+0tlp28LQHzN4cFfp/NFuLtp4wW0HBUodQZOV0fTd4geWZT7kq8N8Hr7ygd9TI6Y/GCagduDHzxeTJZQBpqsFnbgItR5+OoPDJS3P+dPjLYUQUwrkMR0TZjp+SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752254476; c=relaxed/simple;
	bh=ACv9AnrOMVxh9rXrbcdLv6VzFJyi4n5FlBG42tLbPZk=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=M0WaNEM1GdOZCCL8XigNFmtownuMcumRCYFJxOpdL65pyiaGTHJyjrQpX4+KIA6xLPYAdKgQw47VkH0tJRV6BsqO4Bonh0LcqJtIsvyXBae82vYRu+JhBGLdh+v3Z4aJskKvctlLuU7Lgm+0d4TxHrnLuZpuq10seD5sOCC84uU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R4NCe4rh; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BB9XJ6013218
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 17:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=f2kIrVdY6yNafR3bH9nZPukOHabqVc2tgCW+M8bTP9U=; b=R4NCe4rh
	q8OFcyLG6eTfZ1tMLEttp5pn4Yi8VisAOJWQ5HuuvEcxUuafo8tVn24KCmK50IQ0
	bbg/UrJ5UY+Sms7I2Zw1Gtc301iKkTFWodO+8ANfyaMTJxjQRDq9263j6xzY2TaF
	C/cv8kR7SiZ/XLkwy36IOjU+IJHk9/xD808XHpKewHIz9UqBUolcnVFmX3qgrFem
	+u7q8T84SkKeDcLqsPRznwAI+XQs+w1vcD+mYm+AnaS5N1SNnsm5Z343iMa8YC+6
	bePigKQOMoNofxyReiwKNZ/aj5RmPGN8ntbOLEmmPSJOs/np2A+58eXnQjer09Od
	cmTpbb+KI8ZmxA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47t3xdja7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 17:21:13 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56BHHLgW008713
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 17:21:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47t3xdja6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 17:21:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Siy0gqFOD5xG+QTq+YZqrEYSyw7n479azV7mPkeBoE8MNLxOe2sxJrs7MzetOuYSdSM0uFIA9opekS1FZtVZceTs+ItwI75xj7iiuVdXCCwPHKd5gyWEikOTle5Uf6YX1Tg6i1YjROjiRlQXEpkV2Ny/5R2qpgFkhZcO+k91NpIHJGsG3WkXKKfu9/9l6GInbpVtucUz3CmBGk50XgtVm6Ik6asszGPZ0AjDTXfdvVMQXkeTD6sKu4+M4/tRO+LzindrDTQyfCnvTsVSfxuxU0tRWC9aSHh3v7x1dS9ae5X7qtgkxNC3PwPCbp+N+i1KzNQrWz9keph7qYkmitCWbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VuV7sU/7nOnteCwJj1Qzcmm46P+PYHBtP7sHqBGofc=;
 b=sJ7QvATZYS3FMLlIfOOBxfYbSEpwQZJuOLAgGmQ1QG++41Hh25CZGVKcyfgvKKYSyem0oZIBNJyiUXKX7Tgupj7vNVRDa1eZKatI0zGe0yurQaY9C92rkjt3TperKdAedNXZFtVd7IvkJsvWqdOiWJH9bcdCQlMIOvfoei1eqSPW9WrTv0MTA1Hy6nGvDkGVQ/RiW/KRGll8RFwlHqCZcl4Oymw31xcKtdMENwCQryC9MQ9X+VY97hxhyC7Im7ofE38VCxcZVyHAPdgqqrHm+rWntIpyRQMQmgIOs0aU/QomLo3iLY+Ewwz3ZOsapcqB0rl+SbgaO2esS/M/cUhang==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB4398.namprd15.prod.outlook.com (2603:10b6:510:80::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Fri, 11 Jul
 2025 17:21:10 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8880.026; Fri, 11 Jul 2025
 17:21:09 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
	<penguin-kernel@I-love.SAKURA.ne.jp>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] hfsplus: don't use BUG_ON() in
 hfsplus_create_attributes_file()
Thread-Index:
 AQHb70qjLuneU93t80+qPqT+jd4L9rQmvPcAgABIC4CAAtCIAIAAS+wAgAA6ggCAAnVPgIAAYIWA
Date: Fri, 11 Jul 2025 17:21:09 +0000
Message-ID: <ead8611697a8a95a80fb533db86c108ff5f66f6f.camel@ibm.com>
References: <54358ab7-4525-48ba-a1e5-595f6b107cc6@I-love.SAKURA.ne.jp>
	 <4ce5a57c7b00bbd77d7ad6c23f0dcc55f99c3d1a.camel@ibm.com>
	 <72c9d0c2-773c-4508-9d2d-e24703ff26e1@vivo.com>
	 <427a9432-95a5-47a8-ba42-1631c6238486@I-love.SAKURA.ne.jp>
	 <127b250a6bb701c631bedf562b3ee71eeb55dc2c.camel@ibm.com>
	 <dc0add8a-85fc-41dd-a4a6-6f7cb10e8350@I-love.SAKURA.ne.jp>
	 <316f8d5b06aed08bd979452c932cbce2341a8a56.camel@ibm.com>
	 <3efa3d2a-e98f-43ee-91dd-5aeefcff75e1@I-love.SAKURA.ne.jp>
	 <244c8da9-4c5e-42ed-99c7-ceee3e039a9c@I-love.SAKURA.ne.jp>
In-Reply-To: <244c8da9-4c5e-42ed-99c7-ceee3e039a9c@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB4398:EE_
x-ms-office365-filtering-correlation-id: ffc2159e-fe8f-4a61-4fed-08ddc09f540e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b016REJRRGprVHdyUmxBRE8wTmswbUljcEQ3Q05VU29sYnBRampLMVNuS0FC?=
 =?utf-8?B?UXhoUE8zK3BJUTI3b1lDbzFiY0wrSkdueHEvbDAwUTZNMEpTYVNzT1cranIr?=
 =?utf-8?B?dVorM0JFK3l5ZUU5LzBaZ2ZlWmJpcG9MV21PODV1Z0h5OVYzVEdWNlZWOEpn?=
 =?utf-8?B?a0s1OUdqTjBlVnhJTUlxYUZEY2hxVXBBdHY3eVpoblhKV3hoUGkyeGpWM1lm?=
 =?utf-8?B?ZGg5RFhTeVp4Y0c4Q2FSTnJQTE5ITTd1bVlibTlIQnByaUduTUkzN3I2a2h3?=
 =?utf-8?B?cTlhR3ZzMnpoQU1kNHBreVJFQnJZRWpWRWZqeHk1K2VUNURVaktNbjU3OSt3?=
 =?utf-8?B?TERBS3NSek1GUnJpQUpOWUdjbzUvWjkweXNYMTU4dWNDTDB2eTVVaWdiN256?=
 =?utf-8?B?QjVyckg2alVHcDRGM2JFT0lHNDRtcklLWlU3M1ZaVmhSTllWUm5maHlHTmRV?=
 =?utf-8?B?TndTdVc2QjEycHRYMHFnU2RneCsxT0s1ZnFqanZscFU1bzh3S243T1Y3aGRU?=
 =?utf-8?B?cnovWGcxNlZ0Vzlha2lXVmtSQ2k1c0pCYTE4MmRpQUNPc015elhLdkJRVzZM?=
 =?utf-8?B?MGZPRCtOR3FZeEJOYkVOb2JkY2tqSlAyZm1pcExST2hWYStLSHQ1Sk1MbVFp?=
 =?utf-8?B?UkFWSEtiWHNIYjhXOXp0clRRZi91YjBiVWRJa2c0RmdSMmwreEZLcE5taXA2?=
 =?utf-8?B?dVRqSFcvRkM5UWFqcDV4bzkrU2tISmFKMERhdjV0VUE4bmlwT3J0cEZNd3o2?=
 =?utf-8?B?NUV2bHpHaDBjeWFEcXNBVkpzM3BXQVBlZjVBN1Brd2xna3lENFV4ZmlCbVBy?=
 =?utf-8?B?anZGSWpGRFhGbWp1ZGZTYTdZNTBiMkVlVVVvL1NTcmQrWU04WEVPY1FpOUZ6?=
 =?utf-8?B?dGFsTEprQ2FhY3VtNTdzSUJ4WW9mQW5sN3dwVEllRDRGS3EycEZhcnNPVmtp?=
 =?utf-8?B?MGtXWXU2Tkd6aC9Ta3Qya0UvWHY2VW9WdnR3OEg1Y29qMVNIQUVTV0g3R2ps?=
 =?utf-8?B?dXplUEJ3Q2VyN1pxSW9PeFc5Mm5BUWpBd0g4U2JPSzNJZXVhTWxFQ1YxbVV6?=
 =?utf-8?B?a1FvY2NvaW1YczNyK3lJM1lHa2pFbngzQm00cjBvQUFTVTd1WWFock9iTFpj?=
 =?utf-8?B?SVpUa0tNMGtCMW5GK3VESmVSd3BpYzVWVGJoV0IwNmpjWlFuSXhGOTd2ZkVn?=
 =?utf-8?B?MEhoWE1VMjJnYWJjVUdHU05pOGZMVGM4dmY0emxMQmwvRnpuM0Fxd3JoaUxS?=
 =?utf-8?B?ZGt5bGwxVmUwQWhRK1ppTnpkVUV1NEFPZU11TDhaOW0yVkFYTGZZS3FxY3V3?=
 =?utf-8?B?Z1ZTR21ZYlZYNUp3WmtZUTNlNWlYS2hUdDB2WG9MOUNuU1V2K044cW9DT1lP?=
 =?utf-8?B?VVNSWDFWOEFwYmphMndwbS9JanRPUkdlZzBDUFVNcjI2YkFWTExjaFpvV0pq?=
 =?utf-8?B?N2pRdXRielo0cVY5aFVZaUpCOG9MTkdRalpsRDR1QVAvRGNxdzJtTk50U3hI?=
 =?utf-8?B?bmppMTQ2bEtCSTBNQ25zMURQYlFmUFE4MStLZTdUc2lVSThHRC9OSjEzcXhW?=
 =?utf-8?B?RUI2aW1lZUZYZjNrQU1NNXdiamZEa2FpQjR1K3pPeHJGQWsySW9QZHROLzNI?=
 =?utf-8?B?d0JidXRFUmErY3k3UmhXbFJzTVNUaFYyelFqNmRtenF0MXMwNkZJd01IQ2lj?=
 =?utf-8?B?QWNGa08wNTRvWkJZdHBGVjI1NmphUkw4ZXV3Zkw5UllLellIMkJCTHVDaDly?=
 =?utf-8?B?Q25zL05JUEFhaVpPSnY4MWk0b3c1UnZlNklLa0JxUEp5QmxBWDhNWktrMjJE?=
 =?utf-8?B?MDFVS2VNYjAwUkErMFVldEZHR0hUY1dxdWROOVJERkdRMzRIb1VDRE1SNHhI?=
 =?utf-8?B?WXhOd2lwdkZ2dkx0enJoZzJDaWNObzBFRkMva0VIaE5Bdk5xajk2eWJReW45?=
 =?utf-8?Q?gcLOGRdM6XA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S3RkVnZ4eTRyWWFLNGZJUlZmK1JZZjdBbGVWNmFNSmsyWU56TG1wOGFZQXNt?=
 =?utf-8?B?d0VaMm45YjU5bmFoMXp0WTBCd0JqaFVNMjR2VkpNWEsvazdyRjYwenlYQnZM?=
 =?utf-8?B?THRVNzJKUWhQdzg0ZEppTWhoWkR6VWN6YmN6OWFPOW95b2V2T0svbDFxMnBF?=
 =?utf-8?B?T3hLVGF6dVcyeEt0eWVkZkZjRy9sOUsycUtoZ2IzdytNNTJHaVRUVGt5TlVH?=
 =?utf-8?B?bld1T09oMFkxcWV5RXNOU0o5UUVPb2plbkFWUFhOaVNQM3RJOEg1T2lBbDRD?=
 =?utf-8?B?OVN3U3ZuVno3cER0d245OXExV1I4NytoRDZ5VEdYNWZyblJGMnVFa1ZaQVVp?=
 =?utf-8?B?RE1SbGE3bWgvN3U2ZVU2a2hwbGlwL0xua0VobTRsZ2Z5U1piRnhGQWV4eERP?=
 =?utf-8?B?cEZTTjlvNlhmbEViaWdYeVBteGp1cDdJM1FnbVcyUm1RQmwzTzEwSzZjdGhh?=
 =?utf-8?B?ZisxWnlnYTJVeTZsYWlWZTVwODFHdFpGUGgzc0dSUFR0U1pycy8xSEpmMXVR?=
 =?utf-8?B?Y2ZmNy8vcVViQW9PNlp3OE1TSWNWMllJYXV6VC9Na0JubWZQalUydnYzTHNE?=
 =?utf-8?B?L1pCdDNVWE1TclNmWVoxMGFzZEZxblFpemg1N2R2dmxVTVBDaWNWTEtoOGRq?=
 =?utf-8?B?T0hBSW8yMmJkcjZQRnYwTEdpRXhlSk5tMHVtcW8zb2Qyd21IY3VBb3k3OENx?=
 =?utf-8?B?SFBMOVg5OVF0Vk9EWkZ1QTJXdWpCR3hZSk16Z3NBMEJTbURXSDFQQmlBUXpL?=
 =?utf-8?B?NFdqYlluVkhENHcrZ3JMVDhCem5FS3FXVkZHWU8xcityN3VMbDJqcE1vZGdO?=
 =?utf-8?B?UXRKK0xuajFuVy9vcTJrdVg3TnBEbVhETmc5bWdIeHlRemtkTTlLMDgrc1NF?=
 =?utf-8?B?NTA2eTVLNzN5a21lVWZTYUZpWEFZMDQ5eHFROVl3VVJlQjVFME9LMW9zWlRh?=
 =?utf-8?B?a0dBZGxQTE1PYUNiUTRILy9OSTJ5cW1haW1JZit6T2dKWXFqMkJtallpOHlS?=
 =?utf-8?B?MUloVGJ1MGViQ0JTa3VTcnptZG9XTzlJQlNmU1pFeVFmS0o0L1dTWS9scE5D?=
 =?utf-8?B?RElOY0lQL21vNEJvZWV6N3pkdWdZSjJIbDAvWWlVQVl4Mkc3QmJYaU9VazBh?=
 =?utf-8?B?R0FFL3FoZHRsQ3doUWxVb2czTTVWSnJUMElua21PQ3ZoY3lWV2tpbktvUnVq?=
 =?utf-8?B?ck1LSXB1T2lBQUpLRFd4RFJPZjV3ZnM1TzBRdnRJWjBDLzRvYmRmNitlWnU3?=
 =?utf-8?B?M3phSWpCTU9ndmx5L1Y3eEpZR1dQa1J2ZWt5Y2hTR1o3MXZrUzd6dWJFZG5G?=
 =?utf-8?B?WnQvOG9HV1dOZnhldmJWWWwxOWYvOEp3VnBHbVd4ZDg0b29pVWQ2QVFqcG8w?=
 =?utf-8?B?Q2tJeHhwZnQyNm5qR1h5QkdFVEQyRjN6dzBtd01CZExVaVgreld0OEFHVVFj?=
 =?utf-8?B?NndYaUxob1h1TWlsZnZIWkJScmFRZytYUlM4Rm5iaUJFS0RvSURrUUhrN25y?=
 =?utf-8?B?RmpPdEFSTXlabHRNNG5nVEE3WGxvTm9PYW9kS1hhdjJoNEFEVnFXNzVBRFdI?=
 =?utf-8?B?cmFsYzEyRDJFSFcwZWozdzNpSmNZU01LeWNqTU5UOVRUTi9YdjVlNCtjTmc4?=
 =?utf-8?B?bHNQN3BiOGgwaTU3LzhJY0RDc0Zkc3ZENXJDMHJ3VytsZFg3aVNjQWY5MTJZ?=
 =?utf-8?B?bTJJSmwyaWM5bDUwanlZazhLaDgwYkRaekJYZ1h6UEJ2WllRVzY1L0ZYeDFo?=
 =?utf-8?B?TnRFWjhPaCtOS0VFTlIxQWtlb1kxWU82bFprOERJbC9qdjVGclFlOGpkQ1VB?=
 =?utf-8?B?azJIQzkxL1hoc2JQRnZDTkpqcFFsWEVPemNycFFwTUZLeXRCV3hMeWx3bG5D?=
 =?utf-8?B?NFhsT3UxbGVPNlJYN0Q5ajhBU1ZGQnFLUHlRbkN1enM0d3Nrd29WdHBxcERC?=
 =?utf-8?B?bTVyYTlZWU5KaEoyUGFZQlpIaUZJQVRCWWhFdFdxUTNkL3ZFOXh3ckI3LzZ1?=
 =?utf-8?B?NEF6OFN1WklyeGQ4ZEx2ODdvU3g5TG56STVCVTFDeElVc0h1L1N5dDlqSXhh?=
 =?utf-8?B?Vm5uWFJieWllUWJ5aTNhREJhWXJWM2pvTmd4Rkw4eDc4cFBPSEdTRHRsWkFE?=
 =?utf-8?B?MHJna2xEb09oczhsZkxrQzVrQ1drM1k4R3FwcGQ2U1hPRzFmcEZUL3k1TGEx?=
 =?utf-8?Q?rz4WC+nDXt1FkCOIvPK/d7o=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc2159e-fe8f-4a61-4fed-08ddc09f540e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 17:21:09.8639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hICov5B4aP+x+EhdyYjBzlfGx71Ox47szf9X1w2ZuL2FipbBVvJAW4JCj4Hv6V6pdxtPeAbNzaCu2z8D6xjVWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4398
X-Proofpoint-ORIG-GUID: 0xbgLONcbCeXYwI0DjEJcRnAyla-tQ8L
X-Proofpoint-GUID: 0xbgLONcbCeXYwI0DjEJcRnAyla-tQ8L
X-Authority-Analysis: v=2.4 cv=MLRgmNZl c=1 sm=1 tr=0 ts=68714808 cx=c_pps a=iNbKu3seLnfQiesHBt/AFA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=P-IC7800AAAA:8 a=bCcR_JO2k2wBJaW3oxoA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEyMiBTYWx0ZWRfX/eeRiE9AN19Y 4l1mxB4R0celhPG6XKEw20Qx1OV5kXqD6QJOAIdMlMJSmPdVu5DL6taop2a1LuCz0ithZlWk1iN 5Iwzkc5y9Ce/i+Zb2G5iR+3fYLAHO3QvWB3ItSium0HbElk07L5vYxgbXvCNlsJmDYdmy+JVAG5
 1fJX1jW4QYsxuSFYDeimGjwVIr6507heHnYahzybjuxO2oFyNZP0PTskPyo9cqeKaisKwi/i709 ymLtwSJ//37nrMItIP1gwsZsdSisma+42j+kp8tehKE+p5AiaqjHegwKzO0Sx1221Y1p/nmE5+B /O5yXv5aYCTtUVEKq0HIwkKuNhsqsVNBobofclAi6NXHrdigPmf8SUq1PZU5BAmgdFzWLxl3SuM
 CsDC7opwX5qdatoOcGJFSn0/GQjnUTEQi/GlbvGW5H9HCpfgQ5yel4M1BJKdgaB/LaQuNj42
Content-Type: text/plain; charset="utf-8"
Content-ID: <387B1770A2CB3A4DB80A9A9D8F75DF13@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH] hfsplus: don't use BUG_ON() in hfsplus_create_attributes_file()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2505280000
 definitions=main-2507110122

On Fri, 2025-07-11 at 20:35 +0900, Tetsuo Handa wrote:
> On 2025/07/10 7:03, Tetsuo Handa wrote:
> > On 2025/07/10 3:33, Viacheslav Dubeyko wrote:
> > > My worry that we could have a race condition here. Let's imagine that=
 two
> > > threads are trying to call __hfsplus_setxattr() and both will try to =
create the
> > > Attributes File. Potentially, we could end in situation when inode co=
uld have
> > > not zero size during hfsplus_create_attributes_file() in one thread b=
ecause
> > > another thread in the middle of Attributes File creation. Could we do=
uble check
> > > that we don't have the race condition here? Otherwise, we need to mak=
e much
> > > cleaner fix of this issue.
> >=20
> > I think that there is some sort of race window, for
> > https://elixir.bootlin.com/linux/v6.15.5/source/fs/hfsplus/xattr.c#L145=
 =20
> > explains that if more than one thread concurrently reached
> >=20
> > 	if (!HFSPLUS_SB(inode->i_sb)->attr_tree) {
> > 		err =3D hfsplus_create_attributes_file(inode->i_sb);
> > 		if (unlikely(err))
> > 			goto end_setxattr;
> > 	}
> >=20
> > path, all threads except one thread will fail with -EAGAIN.
> >=20
>=20
> Do you prefer stricter mount-time validation shown below?
> Is vhdr->attr_file.total_blocks =3D=3D 0 when sbi->attr_tree exists and i=
s empty?
>=20
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index 948b8aaee33e..f6324a0458f3 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -482,13 +482,17 @@ static int hfsplus_fill_super(struct super_block *s=
b, struct fs_context *fc)
>  		goto out_close_ext_tree;
>  	}
>  	atomic_set(&sbi->attr_tree_state, HFSPLUS_EMPTY_ATTR_TREE);
> -	if (vhdr->attr_file.total_blocks !=3D 0) {
> -		sbi->attr_tree =3D hfs_btree_open(sb, HFSPLUS_ATTR_CNID);
> -		if (!sbi->attr_tree) {
> -			pr_err("failed to load attributes file\n");
> -			goto out_close_cat_tree;
> +	sbi->attr_tree =3D hfs_btree_open(sb, HFSPLUS_ATTR_CNID);
> +	if (sbi->attr_tree) {
> +		if (vhdr->attr_file.total_blocks !=3D 0) {
> +			atomic_set(&sbi->attr_tree_state, HFSPLUS_VALID_ATTR_TREE);
> +		} else {
> +			pr_err("found attributes file despite total blocks is 0\n");
> +			goto out_close_attr_tree;
>  		}
> -		atomic_set(&sbi->attr_tree_state, HFSPLUS_VALID_ATTR_TREE);
> +	} else if (vhdr->attr_file.total_blocks !=3D 0) {
> +		pr_err("failed to load attributes file\n");
> +		goto out_close_cat_tree;
>  	}
>  	sb->s_xattr =3D hfsplus_xattr_handlers;
> =20

Frankly speaking, I still don't see the whole picture here. If we have crea=
ted
the Attribute File during mount operation, then why should we try to create=
 the
Attributes File during __hfsplus_setxattr() call? If we didn't create the
Attributes File during the mount time and HFSPLUS_SB(inode->i_sb)->attr_tre=
e is
NULL, then how i_size_read(attr_file) !=3D 0? Even if we are checking vhdr-
>attr_file.total_blocks, then it doesn't provide guarantee that
i_size_read(attr_file) is zero too. Something is wrong in this situation and
more stricter mount time validation cannot guarantee against the situation =
that
you are trying to solve in the issue. We are missing something here.

Thanks,
Slava.

