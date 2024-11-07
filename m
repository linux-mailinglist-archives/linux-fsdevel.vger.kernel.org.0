Return-Path: <linux-fsdevel+bounces-33958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 178CB9C0F28
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 20:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93A741F23DD3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 19:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFFA218923;
	Thu,  7 Nov 2024 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="DYktw9XV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385DB2185AE;
	Thu,  7 Nov 2024 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008427; cv=fail; b=dFGEjhg/fFk3tlKqXHk+dSL0WLUtc/maWamo0+0IK7UP0Zr9g8TLTtJCScuo5cJWMO3WFkBz4o7HuT7RBSPEOkmFDk3WxuqO6ojmvOlK6L/1F1uFY/H4El6AekF+XRsSRM+FrQBhm6yQg5fLCDijd+6u2Qd/U1aNqps+lqfzvDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008427; c=relaxed/simple;
	bh=DtG9J5BKUIuckNUwhC7BATXQm7NX7ZdMglojKE1im6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TB9JJhH0Yvozj+/nYS0Z9DZrSeMhW64DDAjUbAK9zDvJCn7k83WRR6cETIkc7eQqpf47KCsVd+bYuLvexj7jdXNrrAxfvlcklUXLp3Y1vnoAM2bgZg9hVSNw3kAzINiKFfHqEzWkMJVnQmKGFQdY6LSVyMSAkdSZtSUFepgtkvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=DYktw9XV; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7ImMiw015477;
	Thu, 7 Nov 2024 11:40:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=DtG9J5BKUIuckNUwhC7BATXQm7NX7ZdMglojKE1im6k=; b=
	DYktw9XVZ4r/W+ISlSvP/ugitZETMroxMKR4tdGX2WQdzxR07gBeAfr13ooLXluq
	O4Dql83JhuQrOx6xlNIEreCTAvsLikoRTrh5JX3xqMtvgtJ3/AjXqK4LLewjXzTb
	VFNFcS5bMOqwEromBeBGTN1iz0RWUzqhA5Z7nul5lQCFCEh1RPMfZErD+vM7DEOe
	9y5/gkyAonQOCWx9MtOTCtuHQ+PFb01rUMdsMkviMFa954b+xMbjibLryjl+7QA3
	RqdXduk3fUgF2FOMq/tILtIzt+crkybYV9prLBivHVpn1IfX26h8Edu+oFQ2jTBC
	vt20q2Hh/c1DdC6AKf4TIQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42s2fhrt2t-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 11:40:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Den6eBDa/qMu9esyio2IAi3HylcjOkDdx4emrJbO7tizmhQYtwO0kyFbnJSkgQPHLRCYu9aMJ6OuYdv85Y0K7s5B6R1oqvtg9atBA7nWJmJBnLuYuyELxSYMCZ3Sp4e7FJkA69o06pkgxVvs+GQD/c4i0UrhEjtMezmq8FYmUy7WEEHxmqMWw4aozu9grS1asdLfXp3VSFH0iLJDzfv0yAidlAFurXGczrkbxIVOYHhvqvmKdTyIcV0tZHLHsNBIBwzNoWTEZim11loZuDXFm2PVQJv9EwsdCOZ/EqIEVWyRjnE/MU9zZubHXpzjZeBGyrQFKS1KJbHPaDE46Kd6Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtG9J5BKUIuckNUwhC7BATXQm7NX7ZdMglojKE1im6k=;
 b=Ep3Nhrq4HOhHHZEra7HFs6gesOpnjKEbRz4TuiwodoydQuogZMumXfYfcX3z1umxd35x8EA520wvAd/RVoOZEKOjVHNrAfQhXMK9P6wXkK2eGbcCaFh2+wij/92l1pnEM3X6X3kjWpi83DFslJU+WjZHv06eZZv5j2/PwNNoD17fHM9CaG+piwrELfBoLzOvBROSU4h4s8Wm8KqmBBuKBUaORkOYCWKpmN5dqL5U5u8J45xUhO5ndG+evQl6Mw0DC6a/NeIH6GPSkTNR+guX7q50NfvBFLQMsXCA1Fo3Zc/qccMPxyvyYEmMzsqBM9kls1eA9kS+Ikn4671wvVX5CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MN6PR15MB5977.namprd15.prod.outlook.com (2603:10b6:208:46f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 19:39:58 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 19:39:58 +0000
From: Song Liu <songliubraving@meta.com>
To: Jan Kara <jack@suse.cz>
CC: Amir Goldstein <amir73il@gmail.com>, Song Liu <songliubraving@meta.com>,
        Jeff Layton <jlayton@kernel.org>, Song Liu <song@kernel.org>,
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
        Christian Brauner <brauner@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Matt
 Bobrowski <mattbobrowski@google.com>,
        "repnop@google.com"
	<repnop@google.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [RFC bpf-next fanotify 2/5] samples/fanotify: Add a sample
 fanotify fastpath handler
Thread-Topic: [RFC bpf-next fanotify 2/5] samples/fanotify: Add a sample
 fanotify fastpath handler
Thread-Index:
 AQHbKlgjXcuBZV3LVEOnRP7zXkEQ0rKfQ4eAgAB824CAAEEOAIAAGNGAgAqYnwCAAPuZAIAAlnGA
Date: Thu, 7 Nov 2024 19:39:58 +0000
Message-ID: <02D2F126-C40B-4EC1-92E5-243238B348A7@fb.com>
References: <20241029231244.2834368-1-song@kernel.org>
 <20241029231244.2834368-3-song@kernel.org>
 <5b8318018dd316f618eea059f610579a205c05db.camel@kernel.org>
 <D21DC5F6-A63A-4D94-A73D-408F640FD075@fb.com>
 <22c12708ceadcdc3f1a5c9cc9f6a540797463311.camel@kernel.org>
 <2602F1B5-6B73-4F8F-ADF5-E6DE9EAD4744@fb.com>
 <CAOQ4uxjyN-Sr4mV8EjhAJ9rvx4k4sSRSEFLF08RnT1ijvm2Y-g@mail.gmail.com>
 <20241107104120.64er6wj3n7gcibld@quack3>
In-Reply-To: <20241107104120.64er6wj3n7gcibld@quack3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|MN6PR15MB5977:EE_
x-ms-office365-filtering-correlation-id: c42d5c47-3dc5-4454-a12c-08dcff63f693
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Rmh3QmgwbUlaUFYzdFNDb2M1eGE4MG1VT2RWWk5MT2Jzem0rME92amRmY1BO?=
 =?utf-8?B?b1pxTEFMRzVtYUNWTElsUi9xYkJZQnFzRTc2UVkyWkQvT2NxZkNZSUprdzNs?=
 =?utf-8?B?bDBJb3dPRjRKRHlnQ3FSS2trTjZiOVNXQ2NyZSthTytPZk5adlB6VnBtK0Er?=
 =?utf-8?B?K242di93bTFhTis0MjNoaXdyeUJuMHVrTTBGWG5NNC9QQzJySU1mc1pWRHFx?=
 =?utf-8?B?OTN0VS9mSm9LVHNWSTJJTURLZ2o5UnY2aWVvZ29ZMXYyM1FuYm91RzlpUElj?=
 =?utf-8?B?THIxN1k4TXo3WlBNUFA2YkIrN2xqSUptYjNWWngrOHAwS2x2dWhkbWZzWWpT?=
 =?utf-8?B?QVRNb1ZWSXdCb01WVDB4RUZUVy82TXdpNXlnNzZueEdsYUVxdWxHQlB6dlF4?=
 =?utf-8?B?QTVjRmlSR2wvckJPYmpLVnhkeGI5TGMwNGRKN3FwZkZSeVpLUitoS3lwVWtl?=
 =?utf-8?B?OSs1SENUNjN0dGJyVllLYU1oQXNaQ0JXWGZ2K2hmRDVRcEJ6MzFZK0NMRS9Q?=
 =?utf-8?B?a2NyL09Tdzk1Z2hYaUtOaVlpRDJSZUo4aFhqYjNHekpRSy9uRmw3MThvNXJ6?=
 =?utf-8?B?V3F6ZXZtcWxXeWpYYUdDdUhsMXJXL0wwc0VCdVpXdW42SzNZdGFabndyM1Ri?=
 =?utf-8?B?enNNeEt0bVVsSjZuOVViNHR2ZnJIMXpJR0JZNzZxNTBxbmhiK29Td3BjWUlO?=
 =?utf-8?B?RXVkM3c3ZXFndGxoMVJSNkJPeVhseW9Ed1pKVHVUMkR1Wm1XT1dOb2lnTVli?=
 =?utf-8?B?cFo5QUNhbjVQLzVJNy9OV1hSazJOOWhBQWpCcndpbFhiUHN0ZGwvQ1U5Unpx?=
 =?utf-8?B?RnA3SEtaOVd5S3FvK1JpblVNNmF3SUVtblljUnF6Z1RnS0s0NDIrcnNqdGxh?=
 =?utf-8?B?NHB6bVNldmtxdHNXMjlPcU84SWRLM2lUUHBMVTY4L3lsOUc4MDRuOTNJZVdu?=
 =?utf-8?B?Z3h3eFNZRVVPQmVpZnZ3aWh2VmxMOUZKd0lJZUZHT0FtUVVMSE5ZeTg4bWRN?=
 =?utf-8?B?SFllZ1pEdVdBQXl5a3JCZ0hXVmVDTWE5aWM5NXVpeXJ1YlUrd29FYzI1Sk1B?=
 =?utf-8?B?TmFWWkFjRTBUYXA5a3N6TDg0d2pSMGJhTDBTT21xaEV4ZGRmRXNpeGhYTFpM?=
 =?utf-8?B?Tno1OEZ1SkpvSVJlZURrbWRVcHYrTjFkbWc5SnljMUVJampvZ010RTlNZDRl?=
 =?utf-8?B?OVprNC82Y0hUU1JGa25DbEFCK0pZWkNIeUVnNk9OejZqZkw3V1RvYjcyWHJ2?=
 =?utf-8?B?SnBuUGMxZ1BoTEJMU29CS2ZMUWxVeU1lMGpVbkt3eWJvb1lWZ0NURmJrcW5m?=
 =?utf-8?B?aU83R2lYVkcvUXkxTTllS3FiTmRnT2xTaDFvZktTTXUzTWg3WDNJWkVPZnV0?=
 =?utf-8?B?d2h6ZmgyQUxKS2VuUXU2S1pjN2g2WmtDUDhjbVI1SzNXWEtXeDlzNHYwY3N3?=
 =?utf-8?B?WXNEWHRrNmJUbW52OVgxYi9NVXRXQjJIblpES3R1Zk5NbTVMcGJXdEVZT0lO?=
 =?utf-8?B?dmgvYjRFV3ZzS1A5OThWVDZxM0NEajlLam5hSkQvYlhsZWZPUGVtQUdOWHRO?=
 =?utf-8?B?QWdUQ3h5UmcvYld3ajUva2Y2VmNhTUFtckZIS09aMkZoY1RERnowYW9hL2pR?=
 =?utf-8?B?L2REejNWZHpYTGJlNUFWcVg3Y0lFU0tpYTI2VnlTNmlOclJodkE2TW5PSXRo?=
 =?utf-8?B?aXNkQlhqQkRnejlsbDhwMGxGL1VSand5QjdodjZlN0VQL25wYXp6MVRNMnAz?=
 =?utf-8?B?d3BWYTBsVHpONWExbG1ZY0k2K1lOTTM3Ym1vbmZYajh6WHQvUmh1SjBsR24r?=
 =?utf-8?Q?ZOfczCgKmAPnhowmzGwmBJq33/sslHmo6xY7E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QmVKTkwybHJCc3k2QTB4S2o4Vm0vUUYyT2pwVzhLR3NIazR0a2krV1JPTEx2?=
 =?utf-8?B?a0tOMExUU3VLY0VqRUc2SXRjTnNZQmlXT3VCUThGc09HYVdFd2N3VzF5WXQr?=
 =?utf-8?B?Uk1GcWYrWHRMeXJENUJzU25jSTF1WW5xU2xjTmJ5MUVISUtoYU9aejBHWjBE?=
 =?utf-8?B?bTR0cWQ5VE8rbGczTWNER1VjcW9Vem9WTHIzSUZOUjRFWUR2UGhoK2N3R2Nq?=
 =?utf-8?B?VWZ2cG1DOXEzdmwrblB5Ry9rQlIveWJuZmpGNVBxc2xHTXhFR3lSdFY5eWFx?=
 =?utf-8?B?VE1tYm1BOXlUelhGYzhqQlpJVElrMEwwSUoxNVlMT0wwb1g2TnFWVW44NDIv?=
 =?utf-8?B?OE40bnA1eDloQ0E1cVFkYytzTnJnOEFxcTgzcjJnQkxUalNrL3dKVmt0TU5p?=
 =?utf-8?B?bUhNdHBETWxRSVl6Umh2YzZhdHVWSlhWbzNNNDgvditrQXVZUWoyN1NrblFE?=
 =?utf-8?B?UGlPSmd3RXg5c0Fpak9zcDBDNngwZUY2YXBrZ0tQWiswTFo4eExBNzdYSEtH?=
 =?utf-8?B?MmNyUkhhSDVkWU4valA5MFFOcjZwaEVGdDFtNWg2T0djaFU2OFdwWWFGblps?=
 =?utf-8?B?by80M0pDYlZRVEh3VXJuUkRjSXJCZEJmYlBjNzBYTHQ0dEJ6ckxnQUZqTWtZ?=
 =?utf-8?B?VmJ3RXBHVlEzekxrSUVsWTE1TWg2OGRESUNoaXQ5cDFTNWdUVzMySHdtNlM0?=
 =?utf-8?B?TEllSGM2bERad0p6SWlBVU0wVHdoTUtvbW5KSkh5b1VDSjFoRjQvWW9GQmJF?=
 =?utf-8?B?eTJUaXlsYW1Fbm0yZzhnSE5nMUZCVHhOUFBGN2lkWGhEODFHWldVWmcwVDBr?=
 =?utf-8?B?WXA1eHpOYVpNWHk5aE0vTTZiRHFLQ3BTTzMyK3RlL2p6RmtuVmdFSmoxWGFt?=
 =?utf-8?B?YXUrVWZWKy9vUGVlSCtiTmZ5cW01T2JzcFJQa2Znck0zNXNDdVhCNkNHdEs1?=
 =?utf-8?B?RmZvYWorbjhHK0hKMG1sZmY0a1ROUk5zOTZxMFdmV0V5ak5OaDdDZSs3RHFG?=
 =?utf-8?B?MnRqaWsrQ2laL0t3anl1VkVJckFXbjRJNDEzVjZWZDk4TWttYklSU3VHQXl5?=
 =?utf-8?B?MXBRQnFLNyt3VkU1eWozWkdzYzI1MW1lSGZtZzhrWXVBNmRSSUFTQk9ITVA5?=
 =?utf-8?B?Qm1ZMGpWNzRMS0gyYlhPWmlzQ3ZRbnBhTytuMDV4eTFWWk11QXRYQUdkU0tC?=
 =?utf-8?B?ZHJtMnd2dGxrSE1sWld2azlObUZIN2VXYmEwQWNwTFB1YlQrOHo0d0FkRzRI?=
 =?utf-8?B?T09Ja0lRbUhXQ1RyMWNXWEZVSFU3cE9BRTRmT2g0T3ludVdPbU1DaUQ3U0FF?=
 =?utf-8?B?RHdaZ1ZoZllmMUhOV3dhZGFBbTFWNDJuVHdOR3k3SnhIbGJod0x2bm4ya2ho?=
 =?utf-8?B?TUUwaHNxNmZvRU5YRlU4b1owUGMyQ0JFQ2JySFRHVm1aVVZnWStHRTYzbTdU?=
 =?utf-8?B?K0xGVU5nRUZMZk1lcUdqTmtxYmw0bUtDRFNWMUxkVFBhamJ6ZUVlbmFBNWR4?=
 =?utf-8?B?bysrY2o3MHhBV01lZXRCalljdG9jOGxpTnp2QzFFbkJXZkIxbXZ4MnpZUVM2?=
 =?utf-8?B?QUN3czBwamVzVUhzU21KdERkREZSUjU0NFFIWjQwWDd2aXJET2xGeXF4MTRj?=
 =?utf-8?B?NVJQcGN6R21zQU1acUVwUXk2V1ZKTFMvYkw2elhGeFh3c2Nna2MyZEJjUUJj?=
 =?utf-8?B?dUJ3UGJVR1Y4ZFE2R0lKR2F6VllQcUJHeFRqemo3TnNKYVVWWkNneGtFU1B4?=
 =?utf-8?B?T1JqZjkxZGw0ZjY0a3VPM09OVFpSd0paSjU3WE1xSnNNYWplOVdkWmh0dm43?=
 =?utf-8?B?MS8wWEdnYS8wd1ZhWTh6TUMvVEhYTFZ4ZVo2R2lrN0s1NVVaWWMvcFhldFBa?=
 =?utf-8?B?VzUyNGVGc2gyYlllek1LRFRGUWJodnNWeW1xTzFpR081V3Q2b05pS0g2WWk3?=
 =?utf-8?B?RkRwNXU4dGx4YTJsMmk5YkIrV1IyblVLT1BNSDd2VVlmOHEra0FFd1dUd1pw?=
 =?utf-8?B?Mmw1ekY5UGxwNGtCY2p3Q3dERUt2SzNQbXh0c0xKbEJ6aE91TXA2M1QzdTMx?=
 =?utf-8?B?WFBMamFEZFRhUkJOZXVCLzljcW1ibGhtS25ySUcwZTRIaUZRQjFJeVQvSTNx?=
 =?utf-8?B?d0VndXd1UHZHbUovb0RzZFQ3U0g0Z243YnlkdFMzUVIyMGFvNXpkYmhvUjRH?=
 =?utf-8?Q?oqSVOOREazhwduZtgjZYPl4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C530BCEDAB531346A4EB45B4A4EB743E@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c42d5c47-3dc5-4454-a12c-08dcff63f693
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 19:39:58.3211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HfH+sR7ZZaXGfqanX+qKbW4jT1gdCCl10xYEkTFLcUOBOX8Xm8Z5OWUSPuL8HJ0fQL6ttBl7HcIDnBCP4K2gmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR15MB5977
X-Proofpoint-GUID: lWKXajOb1xb4rngE8SFeJR2iiTepQvb5
X-Proofpoint-ORIG-GUID: lWKXajOb1xb4rngE8SFeJR2iiTepQvb5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gTm92IDcsIDIwMjQsIGF0IDI6NDHigK9BTSwgSmFuIEthcmEgPGphY2tAc3VzZS5j
ej4gd3JvdGU6DQo+IA0KPiBPbiBXZWQgMDYtMTEtMjQgMjA6NDA6NTAsIEFtaXIgR29sZHN0ZWlu
IHdyb3RlOg0KPj4gT24gVGh1LCBPY3QgMzEsIDIwMjQgYXQgMjo1MuKAr0FNIFNvbmcgTGl1IDxz
b25nbGl1YnJhdmluZ0BtZXRhLmNvbT4gd3JvdGU6DQo+Pj4+IEFsdGVybmF0ZWx5LCBtYXliZSB0
aGVyZSBpcyBzb21lIHdheSB0byBkZXNpZ25hdGUgdGhhdCBhbiBlbnRpcmUNCj4+Pj4gdmZzbW91
bnQgaXMgYSBjaGlsZCBvZiBhIHdhdGNoZWQgKG9yIGlnbm9yZWQpIGRpcmVjdG9yeT8NCj4+Pj4g
DQo+Pj4+PiBAQ2hyaXN0aWFuLCBJIHdvdWxkIGxpa2UgdG8ga25vdyB5b3VyIHRob3VnaHRzIG9u
IHRoaXMgKHdhbGtpbmcgdXAgdGhlDQo+Pj4+PiBkaXJlY3RvcnkgdHJlZSBpbiBmYW5vdGlmeSBm
YXN0cGF0aCBoYW5kbGVyKS4gSXQgY2FuIGJlIGV4cGVuc2l2ZSBmb3INCj4+Pj4+IHZlcnkgdmVy
eSBkZWVwIHN1YnRyZWUuDQo+Pj4+PiANCj4+Pj4gDQo+Pj4+IEknbSBub3QgQ2hyaXN0aWFuLCBi
dXQgSSdsbCBtYWtlIHRoZSBjYXNlIGZvciBpdC4gSXQncyBiYXNpY2FsbHkgYQ0KPj4+PiBidW5j
aCBvZiBwb2ludGVyIGNoYXNpbmcuIFRoYXQncyBwcm9iYWJseSBub3QgImNoZWFwIiwgYnV0IGlm
IHlvdSBjYW4NCj4+Pj4gZG8gaXQgdW5kZXIgUkNVIGl0IG1pZ2h0IG5vdCBiZSB0b28gYXdmdWwu
IEl0IG1pZ2h0IHN0aWxsIHN1Y2sgd2l0aA0KPj4+PiByZWFsbHkgZGVlcCBwYXRocywgYnV0IHRo
aXMgaXMgYSBzYW1wbGUgbW9kdWxlLiBJdCdzIG5vdCBleHBlY3RlZCB0aGF0DQo+Pj4+IGV2ZXJ5
b25lIHdpbGwgd2FudCB0byB1c2UgaXQgYW55d2F5Lg0KPj4+IA0KPj4+IFRoYW5rcyBmb3IgdGhl
IHN1Z2dlc3Rpb24hIEkgd2lsbCB0cnkgdG8gZG8gaXQgdW5kZXIgUkNVLg0KPj4+IA0KPj4gDQo+
PiBUaGF0J3MgdGhlIGNvc3Qgb2YgZG9pbmcgYSBzdWJ0cmVlIGZpbHRlci4NCj4+IE5vdCBzdXJl
IGhvdyBpdCBjb3VsZCBiZSBhdm9pZGVkPw0KPiANCj4gWWVzLiBGb3IgYSByZWFsIHNvbHV0aW9u
IChub3QgdGhpcyBleGFtcGxlKSwgd2UnZCBwcm9iYWJseSBoYXZlIHRvIGxpbWl0DQo+IHRoZSBw
YXJlbnQgd2FsayB0byBzYXkgMTYgc3RlcHMgYW5kIGlmIHdlIGNhbiByZWFjaCBuZWl0aGVyIHJv
b3Qgbm9yIG91cg0KPiBkaXIgaW4gdGhhdCBudW1iZXIgb2Ygc3RlcHMsIHdlJ2xsIGp1c3QgY2hp
Y2tlbiBvdXQgYW5kIHBhc3MgdGhlIGV2ZW50IHRvDQo+IHVzZXJzcGFjZSB0byBkZWFsIHdpdGgg
aXQuIFRoaXMgd2F5IHRoZSBrZXJuZWwgZmlsdGVyIHdpbGwgZGVhbCB3aXRoIG1vc3QNCj4gY2Fz
ZXMgYW55d2F5IGFuZCB3ZSB3b24ndCByaXNrIGxpdmVsb2NraW5nIG9yIHRvbyBiaWcgcGVyZm9y
bWFuY2Ugb3ZlcmhlYWQNCj4gb2YgdGhlIGZpbHRlci4NCj4gDQo+IEZvciB0aGlzIGV4YW1wbGUs
IEkgdGhpbmsgdXNpbmcgZnMvZGNhY2hlLmM6aXNfc3ViZGlyKCkgd2lsbCBiZSBPSyBmb3INCj4g
ZGVtb25zdHJhdGlvbiBwdXJwb3Nlcy4NCg0KVGhhbmtzIGZvciB0aGUgcG9pbnRlciEgSXQgZG9l
cyBsb29rIGxpa2UgYSBnb29kIHNvbHV0aW9uIGZvciB0aGlzIGV4YW1wbGUuDQoNClNvbmcNCg0K

