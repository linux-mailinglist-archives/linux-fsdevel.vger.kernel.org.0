Return-Path: <linux-fsdevel+bounces-34834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF209C9189
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 19:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CFF5B31726
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 18:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59F718E055;
	Thu, 14 Nov 2024 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="IJhH3+8t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE50AD5B;
	Thu, 14 Nov 2024 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731607695; cv=fail; b=dPAd8jtZ5sjuscGIdBaZWjT3wbpl6Pop1RbLpTkL2NfWtFCNPqQHxklQbJCIoFvSzT+yqbbHFlPOCnupcWmsF3/4UvIGKiWGktUAIl8BpWa1n+xWqjTDxoNbqgk4Ht7fO506YI97IUL69Hm3q1NtOhPd7LUJhJA/wPHdLDz8j2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731607695; c=relaxed/simple;
	bh=16LniwibFwQ3cz+Sg3kgCcxvUWFuTwlqUj9YlWQeNWo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lvp7TuEqM67tYj2UXP7y48ij9QztPgJpWkXwBATrOn7rELi5YNfU/QvnVKOTnkJt+M/kZovsg0Hw/7sjJYUVdRXjK7OxyMLsnA9lTk8qU7GgnxSEWaVSHqqlAl+HeYHQTKjmJm0NQ9vWL7Fq0rWZAngTvppmijZjIJAfqZJS72Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=IJhH3+8t; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEI1waQ012084;
	Thu, 14 Nov 2024 10:08:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=16LniwibFwQ3cz+Sg3kgCcxvUWFuTwlqUj9YlWQeNWo=; b=
	IJhH3+8t2w+N+ObVUcirtfYB6J5qPKzcvqtgO1MopsRVIacbE19GnXUD9Qb45mkG
	DWLPhEDZSc+daf1g8pTHJ11RVAM8EmToB/de/V4uYdaiWJCsCXftcmmtEayj7lk4
	qPZMKAfy0Ira08BIv2idEGIvu88zVVpVFvEgztAzw1hrMAj3Aun61XBkZu9/InJJ
	0uBeTrhU5mPuw8OSejpEc+xr41cwgdlNuz2DJ1oynbPdCmdSWJ5rJfcXjpX2c3vr
	D3slbFUOIfo1FUeunRRybUyNsTWIqgMVmy+DK3TnKgeR/FTn57PyyJKDIbKICACR
	SDvEOlgCN4msddISmm9c9g==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42wfebudr4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 10:08:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/2MvvmQx/a4f/rNqzJkFtfcmoaltLVx74/EHEGD+P3QEDraCNC8ox9BkwmWjNcCiyGxIhEt3eCorrPMZbP+L30a7rsuVcJm81JCILA1BSMMRKqAq62PrOZ1z0/7zK20slvZ3OKbrxhHwTYEfbUwFqQyFhLVB1BYUBImzBi84lL5tx2E47OSWRPh1XM+Zp4h0Eb8I0hLyiZR26niZmpeXAgCZa4eb9TElv7L0r7Q1Sy//07Eg69hWg+L2keB5XjHabc2qhTGoruuFv+GEc+mrifFzCPRzlbKoT4qoRklGs0PxknrfSO0BS1zhvwdhRhm3hfUvxOk3oYASkGiZ8Pvtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16LniwibFwQ3cz+Sg3kgCcxvUWFuTwlqUj9YlWQeNWo=;
 b=SQKinjFKb+vWnwNjr8+1pD63tUOXd1Eau4KnnzpmqA/ydZECskjO0eu4DYy+mmPOqrA36fScgq16xTkN7dPmla3Em3coO6xsjyeVS6AQQzs40wXf12WD3kI0qiRJjbVAViHEuFpU32LUNYFW/58b948twMk+Pcm0A5Rqu5xnZCEluiNxTRSrYfF4IyDra8ZyiTE1wCXULkzNaOs07+r+r9C7drGDUdNSeq4n18IyLKSR5wqaVP297TGiU6p4eY0T/mZ+gamvCD81Rw3IRToKOXS/PImtK1gFq4Pz44ibdAtwDGPlgo9POpkIl8/XZ+8+4eI+ExSs5sB/k3mCVdC2VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5281.namprd15.prod.outlook.com (2603:10b6:806:239::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 14 Nov
 2024 18:08:06 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 18:08:06 +0000
From: Song Liu <songliubraving@meta.com>
To: Casey Schaufler <casey@schaufler-ca.com>
CC: "Dr. Greg" <greg@enjellic.com>, Song Liu <song@kernel.org>,
        Song Liu
	<songliubraving@meta.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com"
	<eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com"
	<mattbobrowski@google.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "repnop@google.com" <repnop@google.com>,
        "jlayton@kernel.org"
	<jlayton@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "mic@digikod.net"
	<mic@digikod.net>,
        "gnoack@google.com" <gnoack@google.com>
Subject: Re: [PATCH bpf-next 0/4] Make inode storage available to tracing prog
Thread-Topic: [PATCH bpf-next 0/4] Make inode storage available to tracing
 prog
Thread-Index:
 AQHbNNyP/8kz7bh9sEuMXmmPH8p6e7Kz8jgAgAAJuQCAAGvfgIAAB6yAgAEUSoCAAA4qgIABaxuAgAAOzICAAAqvgA==
Date: Thu, 14 Nov 2024 18:08:06 +0000
Message-ID: <4BF6D271-51D5-4768-A460-0853ABC5602D@fb.com>
References: <20241112082600.298035-1-song@kernel.org>
 <d3e82f51-d381-4aaf-a6aa-917d5ec08150@schaufler-ca.com>
 <ACCC67D1-E206-4D9B-98F7-B24A2A44A532@fb.com>
 <d7d23675-88e6-4f63-b04d-c732165133ba@schaufler-ca.com>
 <332BDB30-BCDC-4F24-BB8C-DD29D5003426@fb.com>
 <8c86c2b4-cd23-42e0-9eb6-2c8f7a4cbcd4@schaufler-ca.com>
 <CAPhsuW5zDzUp7eSut9vekzH7WZHpk38fKHmFVRTMiBbeW10_SQ@mail.gmail.com>
 <20241114163641.GA8697@wind.enjellic.com>
 <53a3601e-0999-4603-b69f-7bed39d4d89a@schaufler-ca.com>
In-Reply-To: <53a3601e-0999-4603-b69f-7bed39d4d89a@schaufler-ca.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SA1PR15MB5281:EE_
x-ms-office365-filtering-correlation-id: 643014a6-d32f-4b4f-1800-08dd04d749fe
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NzRjOEVON3FCaFlkR0JOZDN1Q3ovbjU1SDVmZ1dSVGpBYWRiQkp3dUhDSWNo?=
 =?utf-8?B?L2ZvRnJtSWhJR2U3STdYd09WYy80MUx5eXJqZlE0VGtLRVJCK3BYSkpkaHNa?=
 =?utf-8?B?eENRUDF4RFVyd1J6a0cwb2VzUXNFTTVldVFrcU91ak93Y2pNeG9IT0FxMVd6?=
 =?utf-8?B?Q2dicmh6bWlaaXZEcWR2dnhuVUZRTTVvaDZFV1hQbkFmVG1FUUw2OTdyQy9W?=
 =?utf-8?B?NFA1aEdHeFhZOXJqSWQzaUFWa1YrekFOZXpNekg3WDNyQk1panl1azN2RU5Y?=
 =?utf-8?B?OVRnTU1jMWtIS1ZxQXVXa1M0Q1RXOWUyQ3lYdHgrcFMvZzQ5Y3VCQW5KQzVP?=
 =?utf-8?B?NFo0R3hCOWhGVmpEU2dyOGhqYmZ3NHZJUHBxSHVjTlFjNmxvaWtDdHg4YjJi?=
 =?utf-8?B?SVYrWmt5TjJaa3NXV1c0WGRaeTBlMkxUMC9aZkFNZldlWHVnbW02MzNtNnJl?=
 =?utf-8?B?QkF6ejBnUlA0QXpHYW43VHNxSHI5TlR5M0l0VXRENU5yeEpQd3M5RWZQcFBv?=
 =?utf-8?B?OXFNbHRidFk3NWs4QU1lWmUxRW9uNkxMV1VFRWp3L1dhQWhoamtKemhreGlw?=
 =?utf-8?B?VjQyc0ErQ09tUVJMNlNVQ0ZLSkxIVzQ0RUl3NGIzNlBHS3JEcVhZUmpLUXhh?=
 =?utf-8?B?VGtKREdTbW9UMks4N0drMXROZm9ldnlTSXI5V0xsa0lnU0dpN3ZrbFI3aXBo?=
 =?utf-8?B?NFBEcE11WjB2Y3N5TWd1MWtQeDBIdTVMTklSN3ozaG1Jc2xEaWpXZkVyMGE1?=
 =?utf-8?B?aGZqQUh0OHVwMWM0c1lNRzFOS2luZ0JUVFNvZVNSU0NuQlg1UGxvcHVSajdh?=
 =?utf-8?B?SUQ5akVLNTdmYUNuZERWWnhQK3NHTFU2L1hoVzlPKzBYTjYxQWM2ZWczTWVv?=
 =?utf-8?B?MnlKS3Rnd1dzZ2hxVFJuSUpWZXhNSEw4VlBFSUFhT2ZBeXM0TVc5TWNJcFQy?=
 =?utf-8?B?aVlSaVpFalRRTWxVOWlSZlFmYVFBVUJqbE0yRXVoV1hTQmNzNXFYaVU0cFIy?=
 =?utf-8?B?bFpramhKNlc5eUlVSWloRGpFaUEwUU1vR1orQmlvUmkwTWRFL0R0NU5PM0I2?=
 =?utf-8?B?RFhCTGxnUFU5S3JubnF3YVF6eElYZnJmUHE0T041eWdNY0JaSE52dHBnVTdZ?=
 =?utf-8?B?VUxockhJclVvQ3VQTXdDY3k4R1hQVnZGMWlXR3pTK0JGWWZHelNDRGxKOUlS?=
 =?utf-8?B?SHg0Vmx3WjVORnBaTEkzbWRpYlVhc1BaUnh6dFZnaWpBbW1ETjBZelNDWUJy?=
 =?utf-8?B?WDdOdlhyZ05HVlVSS1FCSFBPcDFTdHFkYURPQ0doSkFJOGphZWk1bkpDcG55?=
 =?utf-8?B?bk9ESk4rMTNONG5SNnppNXlDcnFrS1dWN1NzQ2RpQjJlN1I1OHhxc014K0p5?=
 =?utf-8?B?VEc2NktqMUlIY2lVUzhnSjVpRzlBbjAvZmJHTFpOdVY4V1ArS2JjK1lIUUtl?=
 =?utf-8?B?dmZsdFQ4ZGpKWmRXRW5ZZjhDU0tzMEZJZHNUaGlMUllBbnRYd1U0OUEyVXNr?=
 =?utf-8?B?UU5LazNrbzJRcGd0MlNjd0tkOWlySERXTVIrS3JBVm80K1dOMDdaWjFWSXBC?=
 =?utf-8?B?ODR0NnRkMDcvR2J1emlqSk14SlRqMjRZTnRFdzNsOEUvSThRR2wxaVVGSVM2?=
 =?utf-8?B?K29hTlNBSmJOUnRjMlBhcnlaMnNrUVk0dHA4L3Jsd3NjN29vblpDVlE3WHN3?=
 =?utf-8?B?cHhpZ1I4dTVzRVNMYXZQeEpoT0FObncyeGcxZ1FzU1lYazd0UGVwUW05YjBL?=
 =?utf-8?B?blJjVkhOQlNWbjFqYnR2bVpLQW1yQ2RjNXhyZWpxV20vUzVsYnBrY3JHUjlh?=
 =?utf-8?Q?Cwewj6/3ahiFnygTZ01+C2pQvbPg+Ra49qQTk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bERtYTJ4dVUyWC9OUDI5VnVMb0VJVkdSVy8vY2hEMjNXM25BeGJGL0Y1TFRS?=
 =?utf-8?B?KzZCL2djbjVhZ2NjREVLeEMxUWttK1Rkb0lGMFRneDl6NzY3ejRNSkVOODVZ?=
 =?utf-8?B?empSR3NOVmZ4RDkzb1hrdWdDQ3VORGZBVXYwVmtQdEtoVVZtcStXOTc5L0k2?=
 =?utf-8?B?MG5vNXRZMTR4QTJRak02K1JicEwvM29QK2d1aFRncXFydGV1c1NQdXFUN2Nh?=
 =?utf-8?B?WVNQWG5tdU84dWs2TFp5TVJ2anlJR2MrM0lKU2EybkN6ajU5VnJHZ3NSVUo3?=
 =?utf-8?B?SnBLOE44TE83Q0xVUEhsemw2VlNrQ0gxZENNOHdablFyUUtPRG1BTHpSUG9I?=
 =?utf-8?B?Vk9LZnVRclowRjNJSkUvTkZCamJXUGZCRVY5aU11UGVZcFIvcGU5M05FTGo5?=
 =?utf-8?B?ZHVrMyszdVlXZzZ2RytVcjNLQlVWRHRkTW4rZ3NlU1VDMG15Y2ROUWFIMkxh?=
 =?utf-8?B?K3dzdkRXcUlETjJTZWZVOCsxcXp1dXVhQldNN1ZYWjhETlZDTmY3cDJkbGlG?=
 =?utf-8?B?R0xQVHdjZzZoelE4VUh5cjhuYWZkaFppT1h6T0h2WDRtOEJ4bnJyNEc3aW15?=
 =?utf-8?B?eDhwK1M3dzRiTEFGeUpwWXN6Y29CWUtQRldmWUdreVVtZURzN2RVM1NDUXpP?=
 =?utf-8?B?SjZEanJIRXU3cjhyNjYwN2F1NTEyM0p6c21lc0U1NUdoVkx4M0xRWDVrQk5n?=
 =?utf-8?B?RDVjMnMrWDRodkhWNEcySnY4ZmJSMkxkWHRyUzRSa2RiWEZvY3lMMkhpUXJx?=
 =?utf-8?B?WlhtV0xTM3AyRFJuYVV3YWlEVGJGcDM1OEZJSE9aN1NMMGw0cjFIb2hMNHhm?=
 =?utf-8?B?dERKSXNhd2xVM05Ta244S0ppM1dmVjIrYzRadHFwVHd0OXdHM0pHV1ZCeEZW?=
 =?utf-8?B?UjFPR09nTjhVemhoL0sxSEdwMDlUcFFxZVZUOGg5cWg1WFRBODNNYkwzM1Rv?=
 =?utf-8?B?OHFyTnhjY2RjcWhVQTRZN21FWnA0a0dFSWhnWjBFOEt1T0JIQnpPSHZCaU16?=
 =?utf-8?B?YmZvY1hpTU5rNy84QmlZTlA5Wk5xajduS2ZHbmNVUUtoYUxNY0tRdGZqUFRj?=
 =?utf-8?B?Y2MxaEhpbm9MRE9ZYWNrM3M4ZkJWdW9mVkFZQjRMTlJCNHBlVElIVnY1ek9l?=
 =?utf-8?B?TXdZWjRYUjBMZ0ZDYnZWbUdRZlNuaGs2a09LWUpxTUlXYlNWaFY3OWY5TkpZ?=
 =?utf-8?B?Y0VqVy9oM2E5aVZWUzU3WGtyOVUwVzM1T3NSVDhJditHY0dOOFh6b2J2OWZs?=
 =?utf-8?B?NHQzMStPYkRWaitBMEFnbmdQdnYwd3lYbDRLaTRPOEtFNWY5aXozUmtJR1pF?=
 =?utf-8?B?RlBjQm0vNFlmUDViZUE3VXk5MzBVM3NhSk5ra0F1aW0rRy9PQUtBMWsrSG5P?=
 =?utf-8?B?TFE2MGRnZVFlbjZYdEI5ZWFPZEhIRllIbWFiZWdwK0p4YnYyaGZMS1Rla3Mz?=
 =?utf-8?B?SmxRNWgrZHJUbU1CeTd3VFEvZktkcHhwL3ZEaWx1QVU5WUdIL21JRjRCRkxR?=
 =?utf-8?B?WGdaNmovTXovOHVDR0VFcStVYmZLK0s0UGdseitPWGoxS1NPSmdhNVJFTTdV?=
 =?utf-8?B?dzloR2dqY1drZ0VtRGFqRTJiUk9YazJmZHNPbVAwOExVMDNnT2Irb3MrakVw?=
 =?utf-8?B?ZkZqUW05SHJmOUhoUU1ER1BjRW9PcDVNb2tKVWRkb3k3WU4xa3hnMWRSYzJR?=
 =?utf-8?B?NndHRzZ3SDV5NENUVk1PQzh5VTQ5UXJVUWFjTDA3aG02YzEwdE1WUUhWZzMr?=
 =?utf-8?B?bmFoTjkzQWJIclhiTXBuaSt4bzNzY05FanY3ZkdIY2x5dHNvUTJGWUVzR1NF?=
 =?utf-8?B?Vzh2bThIcjdMZFpBS25QdUozNVhHUkhvSURXcHR6L2VoMThaelpxQk1hb1k1?=
 =?utf-8?B?RlZZajVRYno1M2l1cjFhdGgxRXA2czhESWY3N2F6WU5JSWg3d3pUSHd2MzZ6?=
 =?utf-8?B?M0dvdklmZFhTSkhBRGQyWnQ2OVd5TTVCNk1makhCR1FRWDI3ankrNnhxTlRJ?=
 =?utf-8?B?Y3gyVUNDNHltUk05WUJxM0Z2ZkgwdC93eE9UQlNVVmpKVXpBZDJOUmNVaEN6?=
 =?utf-8?B?cmlFZlBiQzVyeCtQc21ndHp0blczdU5lMHZqakpMV0NLOXRtVmdleWEyS3ZH?=
 =?utf-8?B?NkY1K0hVU0xydzNGRityZkJjRnRsZWRiSkkvaVI4OThsdllzcktnQnVqNFJ3?=
 =?utf-8?Q?Aj2JbJ91tfn6FM+oZe3xLhU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F35F467B00B5B14CA989DB8D259100B4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643014a6-d32f-4b4f-1800-08dd04d749fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 18:08:06.1948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XFCgacimgUJ481qcW2YbZSrDiPTmWzhjQvXsORvDzFOVtmwj+dHr3gd1SZxMYYW5EaWEdh3dmXXlrnsZlKDnrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5281
X-Proofpoint-GUID: SkWHjpIP3hmPkHWTWGRrq2g3ZKxbidt5
X-Proofpoint-ORIG-GUID: SkWHjpIP3hmPkHWTWGRrq2g3ZKxbidt5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gTm92IDE0LCAyMDI0LCBhdCA5OjI54oCvQU0sIENhc2V5IFNjaGF1ZmxlciA8Y2Fz
ZXlAc2NoYXVmbGVyLWNhLmNvbT4gd3JvdGU6DQoNClsuLi5dDQoNCj4+IA0KPj4gDQo+PiBUaGUg
TFNNIGlub2RlIGluZm9ybWF0aW9uIGlzIG9idmlvdXNseSBzZWN1cml0eSBzZW5zaXRpdmUsIHdo
aWNoIEkNCj4+IHByZXN1bWUgd291bGQgYmUgYmUgdGhlIG1vdGl2YXRpb24gZm9yIENhc2V5J3Mg
Y29uY2VybiB0aGF0IGEgJ21pc3Rha2UNCj4+IGJ5IGEgQlBGIHByb2dyYW1tZXIgY291bGQgY2F1
c2UgdGhlIHdob2xlIHN5c3RlbSB0byBibG93IHVwJywgd2hpY2ggaW4NCj4+IGZ1bGwgZGlzY2xv
c3VyZSBpcyBvbmx5IGEgcm91Z2ggYXBwcm94aW1hdGlvbiBvZiBoaXMgc3RhdGVtZW50Lg0KPj4g
DQo+PiBXZSBvYnZpb3VzbHkgY2FuJ3Qgc3BlYWsgZGlyZWN0bHkgdG8gQ2FzZXkncyBjb25jZXJu
cy4gIENhc2V5LCBhbnkNCj4+IHNwZWNpZmljIHRlY2huaWNhbCBjb21tZW50cyBvbiB0aGUgY2hh
bGxlbmdlcyBvZiB1c2luZyBhIGNvbW1vbiBpbm9kZQ0KPj4gc3BlY2lmaWMgc3RvcmFnZSBhcmNo
aXRlY3R1cmU/DQo+IA0KPiBNeSBvYmplY3Rpb24gdG8gdXNpbmcgYSB1bmlvbiBmb3IgdGhlIEJQ
RiBhbmQgTFNNIHBvaW50ZXIgaXMgYmFzZWQNCj4gb24gdGhlIG9ic2VydmF0aW9uIHRoYXQgYSBs
b3Qgb2YgbW9kZXJuIHByb2dyYW1tZXJzIGRvbid0IGtub3cgd2hhdA0KPiBhIHVuaW9uIGRvZXMu
IFRoZSBCUEYgcHJvZ3JhbW1lciB3b3VsZCBzZWUgdGhhdCB0aGVyZSBhcmUgdHdvIHdheXMNCj4g
dG8gYWNjb21wbGlzaCB0aGVpciB0YXNrLCBvbmUgZm9yIENPTkZJR19TRUNVUklUWT15IGFuZCB0
aGUgb3RoZXINCj4gZm9yIHdoZW4gaXQgaXNuJ3QuIFRoZSBzZWNvbmQgaXMgbXVjaCBzaW1wbGVy
LiBOb3QgdW5kZXJzdGFuZGluZw0KPiBob3cga2VybmVsIGNvbmZpZ3VyYXRpb24gd29ya3MsIG5v
ciBiZWluZyAicmVhbCIgQyBsYW5ndWFnZSBzYXZ2eSwNCj4gdGhlIHByb2dyYW1tZXIgaW5zdGFs
bHMgY29kZSB1c2luZyB0aGUgc2ltcGxlciBpbnRlcmZhY2VzIG9uIGENCj4gUmVkaGF0IHN5c3Rl
bS4gVGhlIFNFTGludXggaW5vZGUgZGF0YSBpcyBjb21wcm9taXNlZCBieSB0aGUgQlBGDQo+IGNv
ZGUsIHdoaWNoIHRoaW5rcyB0aGUgZGF0YSBpcyBpdHMgb3duLiBIaWxhcml0eSBlbnN1ZXMuDQoN
ClRoZXJlIG11c3QgYmUgc29tZSBzZXJpb3VzIG1pc3VuZGVyc3RhbmRpbmcgaGVyZS4gU28gbGV0
IG1lIA0KZXhwbGFpbiB0aGUgaWRlYSBhZ2Fpbi4gDQoNCldpdGggQ09ORklHX1NFQ1VSSVRZPXks
IHRoZSBjb2RlIHdpbGwgd29yayB0aGUgc2FtZSBhcyByaWdodCBub3cuIA0KQlBGIGlub2RlIHN0
b3JhZ2UgdXNlcyBpX3NlY3VyaXR5LCBqdXN0IGFzIGFueSBvdGhlciBMU01zLiANCg0KV2l0aCBD
T05GSUdfU0VDVVJJVFk9biwgaV9zZWN1cml0eSBkb2VzIG5vdCBleGlzdCwgc28gdGhlIGJwZg0K
aW5vZGUgc3RvcmFnZSB3aWxsIHVzZSBpX2JwZl9zdG9yYWdlLiANCg0KU2luY2UgdGhpcyBpcyBh
IENPTkZJR18sIGFsbCB0aGUgbG9naWMgZ290IHNvcnRlZCBvdXQgYXQgY29tcGlsZQ0KdGltZS4g
VGh1cyB0aGUgdXNlciBBUEkgKGZvciB1c2VyIHNwYWNlIGFuZCBmb3IgYnBmIHByb2dyYW1zKSAN
CnN0YXlzIHRoZSBzYW1lLiANCg0KDQpBY3R1YWxseSwgSSBjYW4gdW5kZXJzdGFuZCB0aGUgY29u
Y2VybiB3aXRoIHVuaW9uLiBBbHRob3VnaCwgDQp0aGUgbG9naWMgaXMgc2V0IGF0IGtlcm5lbCBj
b21waWxlIHRpbWUsIGl0IGlzIHN0aWxsIHBvc3NpYmxlIA0KZm9yIGtlcm5lbCBzb3VyY2UgY29k
ZSB0byB1c2UgaV9icGZfc3RvcmFnZSB3aGVuIA0KQ09ORklHX1NFQ1VSSVRZIGlzIGVuYWJsZWQu
IChZZXMsIEkgZ3Vlc3Mgbm93IEkgZmluYWxseSB1bmRlcnN0YW5kDQp0aGUgY29uY2VybikuIA0K
DQpXZSBjYW4gYWRkcmVzcyB0aGlzIHdpdGggc29tZXRoaW5nIGxpa2UgZm9sbG93aW5nOg0KDQoj
aWZkZWYgQ09ORklHX1NFQ1VSSVRZDQogICAgICAgIHZvaWQgICAgICAgICAgICAgICAgICAgICpp
X3NlY3VyaXR5Ow0KI2VsaWYgQ09ORklHX0JQRl9TWVNDQUxMDQogICAgICAgIHN0cnVjdCBicGZf
bG9jYWxfc3RvcmFnZSBfX3JjdSAqaV9icGZfc3RvcmFnZTsNCiNlbmRpZg0KDQpUaGlzIHdpbGwg
aGVscCBjYXRjaCBhbGwgbWlzdXNlIG9mIHRoZSBpX2JwZl9zdG9yYWdlIGF0IGNvbXBpbGUNCnRp
bWUsIGFzIGlfYnBmX3N0b3JhZ2UgZG9lc24ndCBleGlzdCB3aXRoIENPTkZJR19TRUNVUklUWT15
LiANCg0KRG9lcyB0aGlzIG1ha2Ugc2Vuc2U/DQoNClRoYW5rcywNClNvbmcNCg0K

