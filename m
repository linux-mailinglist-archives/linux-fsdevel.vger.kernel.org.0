Return-Path: <linux-fsdevel+bounces-33831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1EF9BF8F1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 23:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6F91C21D2F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 22:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E1F20CCC2;
	Wed,  6 Nov 2024 22:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="i1+mmFIN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847961D0E23;
	Wed,  6 Nov 2024 22:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730931052; cv=fail; b=RykZ9CoWpduZOrjHmx6+pg+ztW0OX3m98UTs3iQBh/2X/Ga9IopZ2BXl6Ol75V9XyoM7IOrauNCYUsBRfJV9wNhBptuhFzuTOjV2qUmzMP9uvbUcyKjh4ZQIa4mO+zUfO6ZoM0DgqAr3md/t7rtbQKTs3yaGuS63YwkS1J3W1K8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730931052; c=relaxed/simple;
	bh=EGvPo8m+0fX+AArxfbBzMlhNbI76Z6U1gF8DWtc7CLY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pAcYIzBo3uwFgr2HgDn2peKiTX9AchBFYRsTOkfdlf7+LN/CfMFTsg+0ZsYTSk0DZ4ssg/FcVP2C1r7/kJc4xY6JIC9VmvGD9g0y8mQP2WHVDryVKgJ9nPDPh5qbvooURxZhep4Se2sI2re4MztLKDWjlcIVh8rzYKpjgS7Y2yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=i1+mmFIN; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4A6JV3B2019790;
	Wed, 6 Nov 2024 14:10:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=EGvPo8m+0fX+AArxfbBzMlhNbI76Z6U1gF8DWtc7CLY=; b=
	i1+mmFINvbWG+Rah+vd8azHBJ8PeR5yHr9LOyful0Pmrcq3LJnyEXQ6LBC7sPVvi
	+RDAaMUAU2muH7ym+Z+TBbR8C9RGVQ6ybYhh/0qidlU+FZ43SeEU6QkRGwuJteXu
	XqIeT/jA1YTMmLliQYFiMkYwbPliCeEqQX/L2+/I8LfVsAF2GRZs72zRuikp+1su
	2Apg2pygJ4mb//6kRzGCYXfAWUnXJRgdiB+GL5M43MtbOr49c5EyWWCB8+l7RHgm
	SLoBr0cX0NPgRc7bNU0t1dV9PS9Andao5RQ84j/S6N4sDVJmiVGYbflduCwY6o1o
	EUu48kwcxN+iegItkCIwXA==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
	by m0001303.ppops.net (PPS) with ESMTPS id 42rdq49ndn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 14:10:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AiLUxBkHOrZL/qa4p4AWy7ZhuQeaGmVJhz6sqZqFxN5VPJopq2hRuoHHiXpGjcKv5AclY9X2zv61UmCwTotYW+VLkHu8z1cDGwWj0Hp/50LM7dioFz6PU0GfaXlDCQAKrImWWizALGdw0vF6sHmqsRZfaxWFQxxjCPcyFLbIDW6Ek3FLXKIwo6MQfoywu5rQ0SRIbPiUmWyonwiMAVB/aogoaLcU5ajMtaTJlIm9CQrKFaAkrVTl0mc9/VCeQyAYzb7keUdCsgL/TinJduPfXOazxyCwv9VthdczOjijcr2NAamWA3hyo5fsWuH1IIZ6Vlr1C1ey+45QzPP8EOpVxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGvPo8m+0fX+AArxfbBzMlhNbI76Z6U1gF8DWtc7CLY=;
 b=aZjBgndMxOT2H1iaBtE2jVU3ldOqpt76YHoYTcKAGPkl/+U5cSxIPxZjkb48fItCrGZORhOiiAoqAR1m18h+Fc2frc6JcYW49yQb50HmtZ5WeD0dYQj803c5pVzVWs3WDtWyJHbZ31Y+YbH2qB2xLZ+U2/A3mlYlAl46UZ1Nbvpb6FjHvRsOa2ZkXlBiDNv08X9VuEEco94v/ohEpZxpL4iO6luLw5idLIVPWMr78eVMcBwB2mTx1n/ETXi2NjRRWWV0CFmtckJ6NsBmAxg8x/OTV/KKzf42uZKkB0kY8e6fhRQlgBzbJgLz1pQ/BC+RpqTq+yy61X46rw0t3w2isQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB5117.namprd15.prod.outlook.com (2603:10b6:510:c4::8)
 by IA0PR15MB5618.namprd15.prod.outlook.com (2603:10b6:208:438::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 22:10:40 +0000
Received: from PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::90bf:29eb:b07e:94d9]) by PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::90bf:29eb:b07e:94d9%6]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 22:10:39 +0000
From: Song Liu <songliubraving@meta.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: Song Liu <songliubraving@meta.com>, Jeff Layton <jlayton@kernel.org>,
        Song
 Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux-Fsdevel
	<linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel
 Team <kernel-team@meta.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard
 Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel
 Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Al
 Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>,
        KP Singh <kpsingh@kernel.org>,
        Matt Bobrowski
	<mattbobrowski@google.com>,
        "repnop@google.com" <repnop@google.com>,
        Josef
 Bacik <josef@toxicpanda.com>
Subject: Re: [RFC bpf-next fanotify 2/5] samples/fanotify: Add a sample
 fanotify fastpath handler
Thread-Topic: [RFC bpf-next fanotify 2/5] samples/fanotify: Add a sample
 fanotify fastpath handler
Thread-Index:
 AQHbKlgjXcuBZV3LVEOnRP7zXkEQ0rKfQ4eAgAB824CAAEEOAIAAGNGAgAqYnwCAACnPAA==
Date: Wed, 6 Nov 2024 22:10:39 +0000
Message-ID: <1A762646-9334-48ED-9298-FABA90CA146F@fb.com>
References: <20241029231244.2834368-1-song@kernel.org>
 <20241029231244.2834368-3-song@kernel.org>
 <5b8318018dd316f618eea059f610579a205c05db.camel@kernel.org>
 <D21DC5F6-A63A-4D94-A73D-408F640FD075@fb.com>
 <22c12708ceadcdc3f1a5c9cc9f6a540797463311.camel@kernel.org>
 <2602F1B5-6B73-4F8F-ADF5-E6DE9EAD4744@fb.com>
 <CAOQ4uxjyN-Sr4mV8EjhAJ9rvx4k4sSRSEFLF08RnT1ijvm2Y-g@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxjyN-Sr4mV8EjhAJ9rvx4k4sSRSEFLF08RnT1ijvm2Y-g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB5117:EE_|IA0PR15MB5618:EE_
x-ms-office365-filtering-correlation-id: c44ac55e-cee3-4e0a-cd57-08dcfeafd905
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U3FqMVRERGl0NVhiSGZMbFRBZGk1Q08zUFFZVmxLbjZmeVZzT3pSZkJzazRO?=
 =?utf-8?B?ZUhPUUVEdUY3ZEJGcUtZRStDamx5V1AyZVhmUmtpeGptWDdaa2k0WGRmWExv?=
 =?utf-8?B?MWFqL1daQ1UzQS9ZemZTK1BxQ1U2SGZ6aTlxazgzK2VLS0NkRGZobmYyMXpJ?=
 =?utf-8?B?ZWFsK1FVREhZYU95NXdzYllLYlM5aG9JdnhjM1JpYlpSV1N5MWNrNGljREp3?=
 =?utf-8?B?cDJUZlQrbU1kN3ZVeWdQRDV6a1pKOXNFcGlncEgyeGNySWVERnFSS09Bdks0?=
 =?utf-8?B?bjVCR2o3K285MTRiazlpalc5aW4xaUx3VWFVN0pxcERCanpuZ0prN0dneUVL?=
 =?utf-8?B?akE3Z2tSY0lWZUN4dlltMmNhNzE5Sll3SVJXL0xmWjYrWWk3b2tTZXU3TnNu?=
 =?utf-8?B?R3pTTlZTSlY2dGRiMWwwNDkveU9uaXRkQ2kwTy81RjJRRlkyaVpXcVBUNkZB?=
 =?utf-8?B?UElRZnowbTZ5L0gyT1Uwd0dVV1NtQ2taK1RvVTFOVStXMGhDd2hSdXczT3Vq?=
 =?utf-8?B?bUtZVGw1c1JZWUROZmljTFFTa2pnVWM3MTBlTWlIdUY2Mm9BbWt5WHVjdFpP?=
 =?utf-8?B?bkw3RjV6b2ZXUkxzQjVKTTMwME1tSHgxN0FsRDhRckRCSnVqVk5kVTBVN3VB?=
 =?utf-8?B?cWNmaGE0TDFIeXdjVU9nK3VRUStLbVoxbXZycWJTOVJMZHZrL3pNSGdMeXlS?=
 =?utf-8?B?TDhmZnhHS1BFNUFzQkJXdm1CcXU5dVJlelZhMkJMRi9YUHYrTzhGUFpZNE1Q?=
 =?utf-8?B?K1JYaFVGUjFnblE0VGFkZ1lQaFBBdGErSnlUaC91NGRDYUQxbHlFMnZrcUNi?=
 =?utf-8?B?cHI5SEI3eStNNUFtQjRrbHdpRUhvcVVYNjZNc1JFUU5od1JOc1VvUHdjb3R2?=
 =?utf-8?B?ejg1OVB3dFRkNjZqaUNvUEJJQlNIU1ZSOW15eTl5M2MyREpFS04rMlRDMkx6?=
 =?utf-8?B?VnZhTFhYblFvYlJ0cHdWUGxhQVhXcUw4ZjVHOGVsanlRdjdHZ3ZuYjNLZ01L?=
 =?utf-8?B?YnNSQSsveE1BcWZBcWhPMWR5NklOZ21qVE9aalEyb2FBejNEYmI5N3dJdEJw?=
 =?utf-8?B?Mmp1Z2hvSUhFU3BheGVDR0pDWWNUNDlnOEtVK1UvWHpVU0tXZ1BoSWxUOVY2?=
 =?utf-8?B?ZjRXMUdtR1RUOVBiRmNiblVvM25vdmZ1SE83WGs2YlkyRU1tQVBTK2dPSGQr?=
 =?utf-8?B?UGpPa2kvZUtEb01NT1hObzI3TGNFQ1BVQVFESUl2dStCNGJUT1BZbHlkcHdy?=
 =?utf-8?B?NmczSWE2SDlTVXRXdXhwbjJ5TjhOUzRtVm9HemZNN3lMTXpVaFR0czBIdjJu?=
 =?utf-8?B?OWt0V05VVHNISXBlVXVmRWZhUG1rMW5FbWdkd3hCRGI0dDhLZTZ1WmZLcDM5?=
 =?utf-8?B?WmdDeTBnUzB3aEdjRWRpTWtWclM5ZEdjbU5oZXJ6d2tCOGRjUWpjQXIwZVNh?=
 =?utf-8?B?YnRYazY0UXBiU05wMFplYldhQ1ZqTHl0YmtMS21Td3hDU24wWkNaRkIyUkh1?=
 =?utf-8?B?b1QycEVpK3g5UXZKbGlucDM0T2dJUGpIR01nZld3Vnc2ZDlkNEtYeHErclQ2?=
 =?utf-8?B?SGZCWjVrbWZIRlRJZGRaWVY1YlFZalNjMGdGbVpReW5Xc0h4cTQyU2ZMYmF5?=
 =?utf-8?B?cGFMclMzcDFPak5zOUU0ZldJZHU4aEIwZTQ4RFJFVXRLNlg3UGFiN2Z6Qkdo?=
 =?utf-8?B?bEV6dk93b3BaS3ZWZ1JVeWF1czVOTjA4NVNDcFNYRWJKMkpyZittWWN5RGE3?=
 =?utf-8?B?YUVLYm9zcWJ3bkI4cEVpK2xBNTVocHo5ZUR4UE9rQkV5ZjUxMVJrdnR2TXU1?=
 =?utf-8?Q?6rl8LAtEqziBwl++5JpDHWxG5BwoOUCRlEHZk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5117.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SnRnZ0hMV3dRMWwwREVFTm54dDNseXM5b3VBMmdYOUp5VkhCZjNCbDZEZHVm?=
 =?utf-8?B?M1VRbGtSTmdGQ2lCVkFUMmREN0E2cURzcHV2M0c3dTlldVFCY0ZTQXVlWXdh?=
 =?utf-8?B?RFpEWlZyaXQ2VE1ZcXZUazRUL25sVXpsemJvQjBFUVJpVk8vRVRMdXJnbk8r?=
 =?utf-8?B?UGNyd1lhOUZqYjFkcWs4c1NMMTRQSG8vanBjaCtlNjczNjBCeElzMmhJWGRK?=
 =?utf-8?B?REFaQ29XOGc4UHZuckVNOC9Ncy9HUDU1bTZJRHZTWnJUVDJtUzQycWkyS0VH?=
 =?utf-8?B?cDN1RElrazM2dzkrMDl2bjQyRnRSMjlZOWltSXIrc1dJeXN3TDR6cGo3dVhO?=
 =?utf-8?B?dThHbTRGRUcrUXFwWXlvOE9jSXV5Skhpc2tqbjQ1RzhDM2JTN0d4Y1RyWTh1?=
 =?utf-8?B?K2Fjck8xME9ZR0RMSUtoKzFqUXAxWXFZTC9yd0xkc0hDbHlmU2dJN3ZObWo5?=
 =?utf-8?B?WkJuOFl6Skx6VDlMb240ZmQvd2xjczNha0tIK2o2azVMN01PaW52U0xCMkd5?=
 =?utf-8?B?bDIwTDJ6aUFYc1plQWdhaEtxU1BYRjFNT0JyNnQwSGNMWTdFclpDUVFKWDJG?=
 =?utf-8?B?clY1U0xSazZ6bDdpM3NGR0RKRGVxSVIxL2ZNUDVqMjEyM0xJbGYyTHRhaEdp?=
 =?utf-8?B?WitNUWErWmU1VEpDTExhdGRXK0JqeUZUb0FQKzFZMTVoSmtNbUhWLzQwNWQ4?=
 =?utf-8?B?Y1NwcEtremdiMnlBbGdKbGdYNW5BKzdKNlJaUmdiNGR1UWpEeFZ1T0JQVUEy?=
 =?utf-8?B?L21tNmVBOVJSV0szellvVkhnYkhlc2gzTVhDUmtXbzZwRVVWMGg2TWsxZ0xa?=
 =?utf-8?B?NzVTcnRaaTdYZzJiQUMvblBzbitrQlZaTk5rSGVaNjVxNEh4NG5CSDN2U09V?=
 =?utf-8?B?RUc0TjVkT2hiV1RGWlI5TnEzbVRCNGZVVjFTdFZmZXZ1eW1FUHFxTDI4NTZi?=
 =?utf-8?B?UExiMW5ON1Q3OHFtSU9TN3VpZ1pRalByNGlwOVpQRlY1NUpnSDNmSTFsRmNh?=
 =?utf-8?B?d2NLa2I0V1NxWWZwYXV0RnRkZ05kL2Y4aFJxWEgvVWlsRlZvbnNkRDcrSzNW?=
 =?utf-8?B?a3hkbVFRdlJuS3RyNERpTkxxTDdTRkNtREVEWjNOeTdsaHIzbC9QZ0RjT2hz?=
 =?utf-8?B?cUhWZU9qYXE1TVJJMVJJUXRGNWJLSW1xS1AyMW02Nis3cUl4SGRPR1g3YXg2?=
 =?utf-8?B?TWt6L2FMaU9Hdm1La2tmTU4xbEpYc25GWDlVWGF0NVZxLzAzR2tlbnprNGZ5?=
 =?utf-8?B?T3BScEJ1cTY0RERDWXl4Z1RWWXhDaWdPMTJGNUJlWk05d3pyenRpWnl1QXA0?=
 =?utf-8?B?aWxRQnVCbGxJTTdVVGJJOGRXMVo4WG9wN3dlNVJ0eWZ0N2trbk5nV1I2RnNt?=
 =?utf-8?B?RGxhbm50QWNVbmRUVjVoRVNoTzhXZHk3eXhQaWtEeVJIWFNHVlYrNzhwMXBJ?=
 =?utf-8?B?d3hZdm4rNENHcDZnbUFYUm03U014dWd2N3FaYXhaM3RDOVNlT1ZiYkJYbk5I?=
 =?utf-8?B?Q1ZUUlVLNVFDYVVWSStLeEFqUDNsb1Mza2NNMHNGajFDRWRPWkNwV0djUWx2?=
 =?utf-8?B?MGRqUFZ3QXYzaDVFaHdENUVRT09GZ0pkUFF0aU5WOTRuam5kekIrbklZM2pD?=
 =?utf-8?B?SVRlWUJFdU1SR2VVOEJ6M2lnMUVDZ0xhckJ3RHB3ZGthVDhsUzU1c2huejZv?=
 =?utf-8?B?RWFNR2FNdVBZK1JIWEk1OHNrcCtrckNqQXlYUks4cUV0V3ZQTnN4SGhMZXFL?=
 =?utf-8?B?UXJTTjlydXh5dXlNZWdQdnp4QjJ1VmhSWWJaTjhaLzVkUnJCUDdkZjN5TXd4?=
 =?utf-8?B?SHg4d2V6dU1LUzhLQzdGM1RsZWI4VXlHMDFwZWc3SW94cWFvRUNCYkZxY1NG?=
 =?utf-8?B?MFBDeXBVYWs0SmJWd3VRcERKWEgxc2J1TDdJVkRsNnM2UTBYcWxMSWtsZVBq?=
 =?utf-8?B?eGtObXVoR1VOVStKb3NHOHlnMlNua3U5TlNtUHlCNGIxNGhIWnBPQVZzcWJC?=
 =?utf-8?B?VCswZGVtTlpOT0Mxa211a3pCVm9YelRORDhRdEZjY01ST3N4Ti9oaHdpKzFT?=
 =?utf-8?B?V2RWaWs4VVZTbWdOcTZZQ0lXRVFNejV2b0I4Y3NWSTZ5Q1pHV2RVNnVpTHBr?=
 =?utf-8?B?UFdENWFENUs5dFhDUjVodEVNQ0ZCOUdCcjhKNEpVMFdaVGI5VURHWG9IMDVv?=
 =?utf-8?Q?Kn80lahPZT5VS6m1HxlD12o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3890D8F787FF6E459ABEC26EDF952349@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c44ac55e-cee3-4e0a-cd57-08dcfeafd905
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 22:10:39.3350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YgUaoCsoXef3pwYujZ+kxaU2vgcFuLQDsBX4oiDIqMDlWw9UZPSjPl8rHozRAb8gPffuHqpXWRSb6mhZuqiM0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR15MB5618
X-Proofpoint-ORIG-GUID: kDnur6Q4AMYEOZrDaGTACFV63DiyTsnC
X-Proofpoint-GUID: kDnur6Q4AMYEOZrDaGTACFV63DiyTsnC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

SGkgQW1pciwgDQoNCj4gT24gTm92IDYsIDIwMjQsIGF0IDExOjQw4oCvQU0sIEFtaXIgR29sZHN0
ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBPY3QgMzEsIDIw
MjQgYXQgMjo1MuKAr0FNIFNvbmcgTGl1IDxzb25nbGl1YnJhdmluZ0BtZXRhLmNvbT4gd3JvdGU6
DQo+PiANCj4+IEhpIEplZmYsDQo+PiANCj4+PiBPbiBPY3QgMzAsIDIwMjQsIGF0IDU6MjPigK9Q
TSwgSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4gd3JvdGU6DQo+PiANCj4+IFsuLi5d
DQo+PiANCj4+Pj4gSWYgdGhlIHN1YnRyZWUgaXMgYWxsIGluIHRoZSBzYW1lIGZpbGUgc3lzdGVt
LCB3ZSBjYW4gYXR0YWNoIGZhbm90aWZ5IHRvDQo+Pj4+IHRoZSB3aG9sZSBmaWxlIHN5c3RlbSwg
YW5kIHRoZW4gdXNlIHNvbWUgZGdldF9wYXJlbnQoKSBhbmQgZm9sbG93X3VwKCkNCj4+Pj4gdG8g
d2FsayB1cCB0aGUgZGlyZWN0b3J5IHRyZWUgaW4gdGhlIGZhc3RwYXRoIGhhbmRsZXIuIEhvd2V2
ZXIsIGlmIHRoZXJlDQo+Pj4+IGFyZSBvdGhlciBtb3VudCBwb2ludHMgaW4gdGhlIHN1YnRyZWUs
IHdlIHdpbGwgbmVlZCBtb3JlIGxvZ2ljIHRvIGhhbmRsZQ0KPj4+PiB0aGVzZSBtb3VudCBwb2lu
dHMuDQo+Pj4+IA0KPj4+IA0KPj4+IE15IDIgY2VudHMuLi4NCj4+PiANCj4+PiBJJ2QganVzdCBj
b25maW5lIGl0IHRvIGEgc2luZ2xlIHZmc21vdW50LiBJZiB5b3Ugd2FudCB0byBtb25pdG9yIGlu
DQo+Pj4gc2V2ZXJhbCBzdWJtb3VudHMsIHRoZW4geW91IG5lZWQgdG8gYWRkIG5ldyBmYW5vdGlm
eSB3YXRjaGVzLg0KPj4+IA0KPiANCj4gQWdyZWVkLg0KPiANCj4+PiBBbHRlcm5hdGVseSwgbWF5
YmUgdGhlcmUgaXMgc29tZSB3YXkgdG8gZGVzaWduYXRlIHRoYXQgYW4gZW50aXJlDQo+Pj4gdmZz
bW91bnQgaXMgYSBjaGlsZCBvZiBhIHdhdGNoZWQgKG9yIGlnbm9yZWQpIGRpcmVjdG9yeT8NCj4+
PiANCj4+Pj4gQENocmlzdGlhbiwgSSB3b3VsZCBsaWtlIHRvIGtub3cgeW91ciB0aG91Z2h0cyBv
biB0aGlzICh3YWxraW5nIHVwIHRoZQ0KPj4+PiBkaXJlY3RvcnkgdHJlZSBpbiBmYW5vdGlmeSBm
YXN0cGF0aCBoYW5kbGVyKS4gSXQgY2FuIGJlIGV4cGVuc2l2ZSBmb3INCj4+Pj4gdmVyeSB2ZXJ5
IGRlZXAgc3VidHJlZS4NCj4+Pj4gDQo+Pj4gDQo+Pj4gSSdtIG5vdCBDaHJpc3RpYW4sIGJ1dCBJ
J2xsIG1ha2UgdGhlIGNhc2UgZm9yIGl0LiBJdCdzIGJhc2ljYWxseSBhDQo+Pj4gYnVuY2ggb2Yg
cG9pbnRlciBjaGFzaW5nLiBUaGF0J3MgcHJvYmFibHkgbm90ICJjaGVhcCIsIGJ1dCBpZiB5b3Ug
Y2FuDQo+Pj4gZG8gaXQgdW5kZXIgUkNVIGl0IG1pZ2h0IG5vdCBiZSB0b28gYXdmdWwuIEl0IG1p
Z2h0IHN0aWxsIHN1Y2sgd2l0aA0KPj4+IHJlYWxseSBkZWVwIHBhdGhzLCBidXQgdGhpcyBpcyBh
IHNhbXBsZSBtb2R1bGUuIEl0J3Mgbm90IGV4cGVjdGVkIHRoYXQNCj4+PiBldmVyeW9uZSB3aWxs
IHdhbnQgdG8gdXNlIGl0IGFueXdheS4NCj4+IA0KPj4gVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlv
biEgSSB3aWxsIHRyeSB0byBkbyBpdCB1bmRlciBSQ1UuDQo+PiANCj4gDQo+IFRoYXQncyB0aGUg
Y29zdCBvZiBkb2luZyBhIHN1YnRyZWUgZmlsdGVyLg0KPiBOb3Qgc3VyZSBob3cgaXQgY291bGQg
YmUgYXZvaWRlZD8NCg0KWy4uLl0NCg0KPj4gDQo+Pj4gDQo+Pj4gVGhlbiwgd2hlbiB5b3UgZ2V0
IGEgZGVudHJ5LWJhc2VkIGV2ZW50LCB5b3UganVzdCB3YWxrIHRoZSBkX3BhcmVudA0KPj4+IHBv
aW50ZXJzIGJhY2sgdXAgdG8gdGhlIHJvb3Qgb2YgdGhlIHZmc21vdW50LiBJZiBvbmUgb2YgdGhl
bSBtYXRjaGVzDQo+Pj4gdGhlIGRlbnRyeSBpbiB5b3VyIGZkIHRoZW4geW91J3JlIGRvbmUuIElm
IHlvdSBoaXQgdGhlIHJvb3Qgb2YgdGhlDQo+Pj4gdmZzbW91bnQsIHRoZW4geW91J3JlIGFsc28g
ZG9uZSAoYW5kIGtub3cgdGhhdCBpdCdzIG5vdCBhIGNoaWxkIG9mIHRoYXQNCj4+PiBkZW50cnkp
Lg0KDQpUaGFua3MgZm9yIHlvdXIgZmVlZGJhY2suIEkgd2lsbCB1cGRhdGUgdGhlIHNldCBiYXNl
ZCBvbiBKZWZmJ3Mgc3VnZ2VzdGlvbi4gDQoNClNvbmcNCg0K

