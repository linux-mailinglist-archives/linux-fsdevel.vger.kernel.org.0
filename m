Return-Path: <linux-fsdevel+bounces-52342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A80AE2194
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 19:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811A818887F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 17:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496512EA16B;
	Fri, 20 Jun 2025 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dfm2Q4K0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8ED2C032E
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441622; cv=fail; b=cYo1zmtP/IhcnMz9f2EtxMt7jD8DkLEAAmBL9a/Gax6u5aENb4+3NdFucdfBogrIMJWLORwYkr0mn0MHO29t3ZzcmOWTVyAsc/VGBd9hTXxIcKvnF8UxK7G3wOx2hLGikmPThG7oNHRnm+i+qgbPm0HXHIRETTuowkMhoXm2pQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441622; c=relaxed/simple;
	bh=ct5/mdLT6ADmJyMIx1OWlEtorqeNLGeZEN69iw7cE8M=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=uXPCs35tjna73StoGHvevmfBkY7tjFVygUEQPxUNy4Gda1yAwYzvc6Ir/KCZu15Ao+ds4YFA/tEqoLbx0oej38bevX0OMNIaib1ON52mwrlUHrP54WFwBOnZ5WLTREqr/I+2WaXmARFKXyOOt4MvJyL2Jyd1SoYevbW9I7DDVHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dfm2Q4K0; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55KFw0wF016164
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 17:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=ih1bJCQdWnunLcOzjs0q1OJ51EgHJBHccLJR9DGkuKY=; b=dfm2Q4K0
	0vuLZ3kquCqmw2WvwOuCGZFOFjpeL5OG9Nro2QZdGwVFcr6gJkWVXcopFcOtkfsv
	yY3KMGHf6UTBjJO2JFloMHU2dXskHnovU8jefTA5ydTyih1v55BCsrng3LFQPZne
	OXewRSlN0K8pJWSMAdbqghcasZ9MHBwGmRthYLiolFoJFbCflkJKRwSblpU5J51m
	uOWI2VK2PsfDDKN5yU/NBGL0cDiy8os4DiHAX11RGinVM/1UaZPgLbO0OZr/r+uE
	Rf+M/owU6ijYfjP8aD62ckl8pbOZK8DyBMKGTEbmV9WjgWhIrCawRwnTJY3SKrgW
	W+I90GKPKj0yyA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygnvqjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 17:46:59 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55KHic2L014485
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 17:46:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygnvqj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 17:46:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnneCe1/0qx6dOBIp6C4H7YVZ/gM0tiD5JAq79r9khLZLZ5wJ4K9JHrqkLdke4tvWiLKbClspffc5yjXflMrc0LSDiCrMjM6wZAslwtsyDITkSREwNNqtNJIZbnUdksjxyXF4fEY1qVvlau1YSA+9au9I51qEMo+8WCch1ClWYJOHKZXd+5ktrYRZxhnc/CJ8EZ4M+cPrywzqh2BPAApDRrfCEw/8WNXf6Irk7KppJpnVaS3vi/328P8j1a+LgFzfPN3Gs84yD/t4svw0wl44jxRTKjtLappTH6n7BaPtSJkkeXfDuwvQQ4oRaXREjapHwIdgMJl/e6D7WQD03ouuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQIK82RMyVsF6tT/d92dNk2tSY3bZCQfSsg+goLt840=;
 b=RyFPdUczwUoHAxY1KKYMha2NgjjOt3U3AR4ZDYNbMYxGSXCByQapsrT5kq1yHiH5CrcaSpP8pVrb7GZJGmQxgLd+DYr8+2+vB+ZX2+5QOtmc3NNghtUWBeiUyoZt9DLS0mJInNKEEl6a+gy/WaGNt92P4ZApeeRA3t3ytJ57a412NaXTns+8F1QPE1Wjip4Wb3QxL+XZ3Srd8cc1lvh3xrJoPhSsuu7+pzO9pzoKbSAvrkKsq9jlUq1i0RnjbtkqvHff0xPfenZBlnWH1KlonrcBnYh5iDy3Y4zNsV4LcDHtnhEAIjQxNNvIgejZOGLBXhA3CRI/iKA4B/N0GzqimA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS4PPF1EAEBC5B5.namprd15.prod.outlook.com (2603:10b6:f:fc00::989) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Fri, 20 Jun
 2025 17:46:55 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 17:46:54 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "lossin@kernel.org" <lossin@kernel.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [RFC] Should we consider to re-write HFS/HFS+ in
 Rust?
Thread-Index:
 AQHbz2CpCY7FD08WfUuZLsiXLlP+iLPn/LoAgAA8YoCAIsotAIAAIzOAgAAMqYCAAUS4AA==
Date: Fri, 20 Jun 2025 17:46:54 +0000
Message-ID: <39bac29b653c92200954dcc8c4e8cab99215e5b4.camel@ibm.com>
References: <d5ea8adb198eb6b6d2f6accaf044b543631f7a72.camel@ibm.com>
	 <4fce1d92-4b49-413d-9ed1-c29eda0753fd@vivo.com>
	 <1ab023f2e9822926ed63f79c7ad4b0fed4b5a717.camel@ibm.com>
	 <DAQREKHTS45A.98MH00SWH3PU@kernel.org>
	 <a9dc59f404ec98d676fe811b2636936cb958dfb3.camel@ibm.com>
	 <DAQV1PLOI46S.2BVP6RPQ33Z8Y@kernel.org>
In-Reply-To: <DAQV1PLOI46S.2BVP6RPQ33Z8Y@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS4PPF1EAEBC5B5:EE_
x-ms-office365-filtering-correlation-id: d08fee61-cf61-4265-3cce-08ddb0227233
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZGtYS2tNM2dDVTVIdm83bDhENFRiS1FadTUzUnlud2FXRWJMLzlGclMxOUp2?=
 =?utf-8?B?Tk04OWc5eG9Ed2x4SXI2ZUR6RGFEMGZub3hhcnNydUZiOURDR3Bhc2xlUUZs?=
 =?utf-8?B?alZFQkRGRUIxd0JJQnBjUzlkbXp1R2c0clE3UXcrTU95bVJxbm5RVjlNenVE?=
 =?utf-8?B?ZzV1dnVjWTNvVEllTU9Zdm84ZnFJaVNLMmdWSGlhTk4xdHlHSDNJT3JQSFhi?=
 =?utf-8?B?WjRRTE01TFJGR2UxOUE0UWk0WWtxYkhTK205WFY4cXdtbm5ydXExT3liQlR0?=
 =?utf-8?B?Z01CVVVFTE0vUWZOWnBicmxEUmxkWkwvTnZ2MEdQQXJuclBKQkpjOUtIS3B1?=
 =?utf-8?B?a0tqM2l5RmpKeGRrWTAzWE9EUFQyaTN6cFdndElxbEM4R3UyNmZoVm1yVW9l?=
 =?utf-8?B?b3UvUXFZeVJUYVNkSEc5Y3BzSW1VckJubkFmb3VZbDMyVWdoRjl3MGJWMWt3?=
 =?utf-8?B?Q3JPVjY4b2NRWG1zZk9xRFRMQ2UxelhlRmVWa3o0NUx6V3V5N1hXem0xNito?=
 =?utf-8?B?STJSRHhaeWRsczd3VXBtb3AzWDVrUHhETmpwempnOTROV1BXQWIzSlJTbVdC?=
 =?utf-8?B?WktrQ1RsMGRVd0Z3bkdUa2N0NHh6UmhobTE3OUZDZUR3QmJhM1k4U2h4RWgr?=
 =?utf-8?B?N0ZJS0JyQjRKY2lNN2JCNVRmVHNZY1RBVTYxaEY4cTRKZGVyL1E4WmlKT3Z3?=
 =?utf-8?B?SHV4ZHVwMFFnaVI4WEJ6MHhmRVlEMklUTTZJRUR3MnpydENYSmV6NW16V3d1?=
 =?utf-8?B?cTN0dVJQVEJGVEordGhReHdieTd6NzdzTW90TlRvSGkzODdOenRxbnYvM05o?=
 =?utf-8?B?ZGVjUTk5ZFplZ3pJKzZyM1RBSU9HdGhRNWpIRDFrVjJrc1dqZm9vM1hHL2FJ?=
 =?utf-8?B?RHlYUTZJSnBrYzJwc01hQ2dGVTAwQnVRd0JYLytUd0hwSXN0UmZoSXJ2N2ZC?=
 =?utf-8?B?L082QldraXk3dE45NG1VOFZyOHhob3JMa1ZQbzJJN2tLbWk1RE5zSGNqV04r?=
 =?utf-8?B?QkpQVnQwYUFBNGcrZWx0emlJV2dMaGpocm9wUEFnSVlLWUkvWWRUMWtrKy9w?=
 =?utf-8?B?cVpyaWRWQXA1Y1ZaSVlEOWY0a1JRS2p6eldyYTdRZENFbldLLzhVVTlXYUpO?=
 =?utf-8?B?eGs0WGFDcXR4VjZnbDZhM0ZSdXZOdFE5NlAyVi9UeUJ2eWExRVYzR2xCZDY4?=
 =?utf-8?B?eUtwZFU0R0JOejBybFZkTDNYYnI4ZHRJNkllOWRYZHdreEMybG5jSEtYQzJs?=
 =?utf-8?B?b1djRyt5OXpJYmREM0pleER6T3U1V1Z3M0x1THZ6ZWlYc0xCYmdPREVZNHcv?=
 =?utf-8?B?MDNsVkQ4WFhNVVFTcE5vNWZ5SzRTWmQ4SDJBcmNVWXVQMU9MbWVrdDBwVnlU?=
 =?utf-8?B?Z2ZmL2dhL3hDZXBvYUxpR1hVTExNUUwxcUQxTmlrQzE3cm5zamhBeWIxdkxi?=
 =?utf-8?B?NXlTNmk1Vm5qbkdUSWQxb0FXVFJtVG0rdGdzQzBhT0oyRElDNlIvNTBpM1lK?=
 =?utf-8?B?VWN6NHpMRVFad0dEOHBNemk2TzcwUzEwdVUyY2tVSlAxanJsN0pXS2VsUGhr?=
 =?utf-8?B?clEyY3FJWW5XcmdPTXJtdWYwTXh0b0lrYitsOWw4MWhKOE9KVGJvYWZIU0wv?=
 =?utf-8?B?YklmZVpHdnA0WkIrZ1JzK0xrU0wxUDYxRWxSd1JzR1I3STIzUU40S3FSazRs?=
 =?utf-8?B?cVczL3FvNzIxQXVlZVl0Rk04NWh3OFg5NndkOTQ0SkFVZlhRQnJ1cnVTdHox?=
 =?utf-8?B?ZUVEVTkzenBlQk15dkhENFNGSVBieXEyRDFBSTNScHgyV0JUTUtSMnhoMXd1?=
 =?utf-8?B?cW9ueTc4OVh6ekJXWWxUeHFOWDFDczZPT0wyNTE0Wk0vMS9jOXVmVXJjakdz?=
 =?utf-8?B?M29Oemtnb0V5OG91dXB4MVVuOGJ4cUFkQ3FQSnArV3RrQStsMTl6Ym85emNt?=
 =?utf-8?Q?qVSXbBxQJM4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dUU4RFpBamFzYXlFVC9ydWJVbWFHeWsyUURGbFZMellKYjNFcHhUTXFGMG00?=
 =?utf-8?B?aUxCQlo2aS9NeG5TZ0ZMdG41TEE5SS9JdXhGTEp6bC9ndzM4a3J2RnVVMXY5?=
 =?utf-8?B?T0taSDFuS0IwZXlNbUxFVi9WU0pqaEE3ZmR1eHFHRFF0RXNOTXVxQXYvMWhN?=
 =?utf-8?B?SkdQa1ZLMklKRUwrZVNlbk1DWFFpRXVQa0RWU2o5bGxXcStBc0Jka0pzdEFQ?=
 =?utf-8?B?QjFUZ0NBMEtHbHAzSTYrMC84a0UxRGJwU1VkTnI4clo0Vm9KazJZa012c1ZP?=
 =?utf-8?B?Ukd5bDVEK3RVRU0yUXdGVVg3WEUzTHlNU2tNdmZQTW00cC95UC9JbVZyeWJk?=
 =?utf-8?B?TkhlVUtQRVpHVUxzMUZPYjd4WEpBUEFTODQrOVpGK1hIR2YrdmZnYnBqemJp?=
 =?utf-8?B?aGMvc0I3Q1FTUDM1bEp5Y3RjcnVXNE94U09SUHk3cWsraEdKdmo0UXdVTXA3?=
 =?utf-8?B?cDhLdXlOTGdtSDVaSUEzL3lUYlRVNG5na2xqT1E2Q0k0aGxCM1FnOFFOT0k4?=
 =?utf-8?B?UWhHdjF5MXlqK3N1aHRjU3VYK3dHZzRzdmxjZXZKNHMwak8rZklEcXc3Vmhu?=
 =?utf-8?B?N0VFeEZMZDRSYkJaN0JBd0ZXWTdieEtDL016ZGVLeDdvT0UrWE9kd1hGR0dC?=
 =?utf-8?B?SFQvLy83cmw5OGpic045cFAwdnhEbXdFQnBQUFVWU3g1NmVFb0FBT01FV202?=
 =?utf-8?B?WW10MGRKaXVxREtwM2lBRUY1Tk91WTdFU1ZGNW9wWUNXWUZRTW9PZGZHbmQw?=
 =?utf-8?B?dUZIM1RobjZnZWsrQ0YwU3B0cnQzZDhvSkZucEIxekNpdzgwZWpHWlFtRnJ0?=
 =?utf-8?B?ekpwR2FzWENzWDBDWEpZbUg2OEt5NUR2eGJaVUJiTG9va3VLMklncGovRytO?=
 =?utf-8?B?R25yRnpYTUdmUHA5N3dBbmhJc05NbTRyZEcyMVZ1NjlYS09YMXdQZDFPNnJY?=
 =?utf-8?B?MEZLdm5nOFhHMW9NQnRqMjJUcDRieXJTUkRRNzl0SEpTYnVSTk11SjBZYk5C?=
 =?utf-8?B?TjlVdEYxcVI0bnVNYTJiQkhOOXJYRjdibTdaK2toYWNocDcxU0Ruam1KSk9C?=
 =?utf-8?B?TThzZjJnT2xCQnFCTFF4aHIyREJ2K2REOWl0YW5jcU51Zm1xZGlBL0them0z?=
 =?utf-8?B?dnZVY2RWSUg0d2xVS2pFL1VyY0hWeWdkVEpEMVpZVm5jN0pKWWx2MHBha3ZN?=
 =?utf-8?B?N0JOOU94Ym9yZUdVd3NmUHdkMEJ3L2piVW5LNkNIUnEvWnhZM0ZuSnJ4T3VD?=
 =?utf-8?B?VmFaVzArb0IybElwckRDK084V2Y1QzZuWTBWNVpNVGZ5YmVCQ2NGeDNCY3FI?=
 =?utf-8?B?ZXd6akVnSW5hUnpsQXYrZjZDY2ZMOTNXU0RCV1Q2YWN1RG9BN2NVNDArT2hU?=
 =?utf-8?B?UEp5MXZEVWpqN2srOS9PdWw0TUdTUlBXaFR6QTVaSGc0R1ZVN1RMRGUyaEVu?=
 =?utf-8?B?TWdZWVZBRzRjeFBaRzhMdFEzVWdHWE4vOEVPOG1pSVdDMExRZ3dBdHhDcnU5?=
 =?utf-8?B?emQxU0NkeFdYSUVEdVZsQVk2ZXlKa0ExYUk5SmpaYk42WFVSSmVxUXhYcWxD?=
 =?utf-8?B?N2pYMmIwWnBKSjFJdXZsNDdyRU1KMFY3bXUvR2k4Vnh0Vmc2RUE2ZUhIUkdY?=
 =?utf-8?B?eTNIR2toRVp0UXpGTlplUFFFbTRTRlRxNkNhbVBCTHZ1eEQ0SmNHWHQ5enI0?=
 =?utf-8?B?WTZiSkF6Y3ZOdGc1cjA1ZWN3VUxQazZ6MERLTDZVbWcvNThjQlFDUUs5Nmxq?=
 =?utf-8?B?Ni9zYVlvOS8vdGtjaVppdVNqQjFWL0VHRGMyUzhMODkvZGRWMG90b244Q1hK?=
 =?utf-8?B?T1hiWHZVOGNmYS93eXVrenpwVlVzTFljeTBLa25LUVk2SjJJczNMSU1tZE1P?=
 =?utf-8?B?QmJaT0wvc3ZWMTNHeGJMb1FXd1pYQ0NFbC9ZQi90VnJmSGxuY0Y2M0FBTmR5?=
 =?utf-8?B?WlBDS0tyTU1Wck1sek5zU24rWU5mYVJMbGVJVU5pdHUwblRtR3R5czQ4dHJS?=
 =?utf-8?B?cWZERTZ6N0VhR0NXT0hBVFgzcDZZSzRrQ0pucGloQmJjYzNLSWsycGI0ZUJM?=
 =?utf-8?B?RzE5bG43QkNlUm1od2gxL0JuWHZaaCtVdEtNMm5acUswOStJRWFWNlhyR3U1?=
 =?utf-8?B?clVmYWFHeFFMS2RKcGVBYldzMm9MQW1EMVNsbjhyc2QrRUJYcEtCZFBWMnBF?=
 =?utf-8?Q?7yoVskEMJUtduWZPqu+71is=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08fee61-cf61-4265-3cce-08ddb0227233
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 17:46:54.7792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q7sYPF7kErHqYbPDPuO2R8320Y8KSUy4tR7ShN6bFk4KLI8qID36/WeKV9anxOWOmVl70KepOGJ2vsigOynr/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF1EAEBC5B5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDEyMiBTYWx0ZWRfX9SX0cQuuG2ac lMkdoNEjcDalO00Jr+C8rxohpLvF1RQ7ku9C3mhbuVx5t6KSkJa3pMxQfjaiRAF2yj7ncyhq+YD UVtBHgzOKYowzqH6fHnyB21PnOvuR8K90FBtKphKfMjKsoG/2HlJ7XbSa1zPHKHUg5BBnbYbhQP
 +LUX2zv4ZwAGI6wV99sWGFz3aEf16zVhJgQcao/EJ2JUwl8SZwzQIjHuCKjs0TmGcg0sNGGebPw ti80IaowowOOXJJyn7RHEOFYd0odtuvthUw6JSlKX418TGIo8YZ1AJmw7XnacG0nZhnUHVN0vwi wqDNYeqoygINOzHH1OvzgCzW2l5lg6HoRmbev05ouTHFegHAbhZ9zNnbIakwhXBgi9SmvhuFhoy
 JmOvQuU4gEIZFzBqRWpmbHwVdjO+uVEjR1eGOg6j/lh2t8pOXHu2q5njUOOLRDoRcAsRhKgq
X-Authority-Analysis: v=2.4 cv=fYSty1QF c=1 sm=1 tr=0 ts=68559e92 cx=c_pps a=atu1pQ1eoId8WxleBF8opA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=rIH98O22OktHME4k:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=PfD2oos9AAAA:8 a=XG_94xzIXNGw77StTMsA:9 a=vmFzU7qb5Wr0OyTn:21 a=QEXdDO2ut3YA:10 a=oXWlT9oWAVMySZ1Hvsws:22
X-Proofpoint-ORIG-GUID: oAU4euy27iyKzlkphbv5VUjXahVcIa5z
X-Proofpoint-GUID: oAU4euy27iyKzlkphbv5VUjXahVcIa5z
Content-Type: text/plain; charset="utf-8"
Content-ID: <2250AA3E681B2647A424032586109CB3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [RFC] Should we consider to re-write HFS/HFS+ in Rust?
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_07,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2505280000
 definitions=main-2506200122

On Fri, 2025-06-20 at 00:24 +0200, Benno Lossin wrote:
> On Thu Jun 19, 2025 at 11:39 PM CEST, Viacheslav Dubeyko wrote:
> > On Thu, 2025-06-19 at 21:33 +0200, Benno Lossin wrote:
> > > Andreas Hindborg will most likely reply with some more info in the ne=
ar
> > > future, but I'll drop some of my thoughts.
> > >=20
> > > On Wed May 28, 2025 at 6:16 PM CEST, Viacheslav Dubeyko wrote:
> > > > On Wed, 2025-05-28 at 20:40 +0800, Yangtao Li wrote:
> > > > > +cc rust-for-linux
> > > > >=20
> > > > > =E5=9C=A8 2025/5/28 07:39, Viacheslav Dubeyko =E5=86=99=E9=81=93:
> > > > > > Hi Adrian, Yangtao,
> > > > > >=20
> > > > > > One idea crossed my mind recently. And this is about re-writing=
 HFS/HFS+ in
> > > > > > Rust. It could be interesting direction but I am not sure how r=
easonable it
> > > > > > could be. From one point of view, HFS/HFS+ are not critical sub=
systems and we
> > > > > > can afford some experiments. From another point of view, we hav=
e enough issues
> > > > > > in the HFS/HFS+ code and, maybe, re-working HFS/HFS+ can make t=
he code more
> > > > > > stable.
> > > > > >=20
> > > > > > I don't think that it's a good idea to implement the complete r=
e-writing of the
> > > > > > whole driver at once. However, we need a some unification and g=
eneralization of
> > > > > > HFS/HFS+ code patterns in the form of re-usable code by both dr=
ivers. This re-
> > > > > > usable code can be represented as by C code as by Rust code. An=
d we can
> > > > > > introduce this generalized code in the form of C and Rust at th=
e same time. So,
> > > > > > we can re-write HFS/HFS+ code gradually step by step. My point =
here that we
> > > > > > could have C code and Rust code for generalized functionality o=
f HFS/HFS+ and
> > > > > > Kconfig would define which code will be compiled and used, fina=
lly.
> > > > > >=20
> > > > > > How do you feel about this? And can we afford such implementati=
on efforts?
> > > > >=20
> > > > > It must be a crazy idea! Honestly, I'm a fan of new things.
> > > > > If there is a clear path, I don't mind moving in that direction.
> > > > >=20
> > > >=20
> > > > Why don't try even some crazy way. :)
> > >=20
> > > There are different paths that can be taken. One of the easiest would=
 be
> > > to introduce a rust reference driver [1] for HFS. The default config
> > > option would still be the C driver so it doesn't break users (& still
> > > allows all supported architectures), but it allows you to experiment
> > > using Rust. Eventually, you could remove the C driver when ggc_rs is
> > > mature enough or only keep the C one around for the obscure
> > > architectures.
> > >=20
> >=20
> > Yeah, makes sense to me. It's one of the possible way. And I would like=
 to have
> > as C as Rust implementation of driver as the first step. But it's hard =
enough to
> > implement everything at once. So, I would like to follow the step by st=
ep
> > approach.
> >=20
> > > If you don't want to break the duplicate drivers rule, then I can exp=
and
> > > a bit on the other options, but honestly, they aren't that great:
> > >=20
> > > There are some subsystems that go for a library approach: extract some
> > > self-contained piece of functionality and move it to Rust code and th=
en
> > > call that from C. I personally don't really like this approach, as it
> > > makes it hard to separate the safety boundary, create proper
> > > abstractions & write idiomatic Rust code.
> > >=20
> >=20
> > This is what I am considering as the first step. As far as I can see, H=
FS and
> > HFS+ have "duplicated" functionality with some peculiarities on every s=
ide. So,
> > I am considering to have something like Rust "library" that can absorb =
this
> > "duplicated" fuctionality at first. As a result, HFS and HFS+ C code ca=
n re-use
> > the Rust "library" at first. Finally, the whole driver(s) could be conv=
erted
> > into the Rust implementation.=20
>=20
> I'd of course have to see the concrete code, but this sounds a lot like
> calling back and forth between C and Rust. Which will most likely be
> painful. But it did work for the QR code generator, so we'll see.
>=20
> > > [1]: https://rust-for-linux.com/rust-reference-drivers   =20
> > >=20
> >=20
> > Thanks for sharing this.
> >=20
> > > > > It seems that downstream already has rust implementations of puzz=
le and=20
> > > > > ext2 file systems. If I understand correctly, there is currently =
a lack=20
> > > > > of support for vfs and various infrastructure.
> > > > >=20
> > > >=20
> > > > Yes, Rust implementation in kernel is slightly complicated topic. A=
nd I don't
> > > > suggest to implement the whole HFS/HFS+ driver at once. My idea is =
to start from
> > > > introduction of small Rust module that can implement some subset of=
 HFS/HFS+
> > > > functionality that can be called by C code. It could look like a li=
brary that
> > > > HFS/HFS+ drivers can re-use. And we can have C and Rust "library" a=
nd people can
> > > > select what they would like to compile (C or Rust implementation).
> > >=20
> > > One good path forward using the reference driver would be to first
> > > create a read-only version. That was the plan that Wedson followed wi=
th
> > > ext2 (and IIRC also ext4? I might misremember). It apparently makes t=
he
> > > initial implementation easier (I have no experience with filesystems)
> > > and thus works better as a PoC.
> > >=20
> >=20
> > I see your point but even Read-Only functionality is too much. :) Becau=
se, it
> > needs to implement 80% - 90% functionality of metadata management even =
for Read-
> > Only case. And I would like to make the whole thing done by small worki=
ng steps.
> > This is why I would like: (1) start from Rust "library", (2) move metad=
ata
> > management into Rust "library" gradually, (3) convert the whole driver =
into Rust
> > implementation.
>=20
> I personally don't know how this argument works, I only cited it in case
> it is useful to people with domain knowledge :)
>=20
> > > > > I'm not an expert on Rust, so it would be great if some Rust peop=
le=20
> > > > > could share their opinions.
> > > > >=20
> > > >=20
> > > > I hope that Rust people would like the idea. :)
> > >=20
> > > I'm sure that several Rust folks would be interested in getting their
> > > hands dirty helping with writing abstractions and/or the driver itsel=
f.
> > >=20
> >=20
> > Sounds great! :) I really need some help and advice.
> >=20
> > > I personally am more on the Rust side of things, so I could help make
> > > the abstractions feel idiomatic and ergonomic.
> > >=20
> > > Feel free to ask any follow up questions. Hope this helps!
> > >=20
> >=20
> > Sounds interesting! Let me prepare my questions. :) So, HFS/HFS+ have
> > superblock, bitmap, b-trees, extent records, catalog records. It sounds=
 to me
> > like candidates for abstractions. Am I correct here? Are we understand
> > abstraction at the same way? :)
>=20
> Yes! Everything that is used by other drivers/subsystems are usual
> candidates for abstractions.
>=20
> Essentially an abstraction is a rustified version of the C API. For
> example, `Mutex<T>` is generic over the contained value, uses guards and
> only allows access to the inner value if the mutex is locked.
>=20
> Abstractions can take a pretty different form from the C API when it's
> possible to make certain undesired uses of the API impossible through
> Rust's type system or other features (in the case of the mutex, making
> it impossible to access a value without locking it). Though they can
> also be pretty simple if the C API is straightforward (this of course
> depends on the concrete API).
>=20
> Their purpose is to encapsulate the C API and expose its functionality
> to safe Rust (note that calling any C function is considered `unsafe` in
> Rust).
>=20
> Calling C functions directly from Rust driver code (ie without going
> through an abstraction) is not something that we want to allow (of
> course there might be some exceptional cases where it is needed
> temporarily). And thus everything that you use should have an
> abstraction (this might include driver-specific abstractions that
> effectively are also part of the driver, but encapsulate the C parts,
> when you have converted the driver fully to rust, you probably won't
> need any of them).
>=20
>=20

So, any file system driver is not isolated thing and it interacts with VFS =
and
memory subsystem through a set of callbacks:

struct file_operations;
struct inode_operations;
struct dentry_operations;
struct address_space_operations;
struct super_operations;
struct fs_context_operations;
struct file_system_type;

Nowadays, VFS and memory subsystems are C implemented functionality. And I =
don't
think that=C2=A0it will be changed any time soon. So, even file system driv=
er will be
completely re-written in Rust, then it should be ready to be called from C =
code.
Moreover, file system driver needs to interact with block layer that is wri=
tten
in C too. So, glue code is inevitable right now. How bad and inefficient co=
uld
be using the glue code? Could you please share some example?

As far as I can see, it is possible to generalize HFS/HFS+ drivers to these
"abstractions":
(1) block bitmap
    - allocate_blocks()
    - free_blocks()
(2) Catalog tree
    - find()
    - create()
    - delete()
    - rename()
(3) Extents tree
    - get_block()
    - extend_file()
    - free_fork()
    - truncate_file()
(4) B-tree
    - open()
    - close()
    - write()
(5) B-tree node
    - find()
    - create()
    - clear()
    - copy()
    - move()
    - read()
    - write()

It's not all abstractions and the possible API doesn't look yet complete and
reasonable. But it is the basic blocks of HFS and HFS+ drivers. I think it =
needs
to dive deeper in the current code state to elaborate the vision of other
abstractions.

Thanks,
Slava.

