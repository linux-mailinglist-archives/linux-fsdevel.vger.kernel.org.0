Return-Path: <linux-fsdevel+bounces-34861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C90C9CD4E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 02:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 032DAB23B56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 01:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B706F61FEB;
	Fri, 15 Nov 2024 01:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="bWh4yWeF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FE32629D;
	Fri, 15 Nov 2024 01:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731633046; cv=fail; b=qZDXjfVuR2tfK8aSSkAE1jPq+cXi/jXFTXJClszwvE0eXRZ1L5hjAuZ/l54WnVgpQQsfwIxsEmR3AhhLYQ9AjOMgzZGAm916QHseRkhBmmNkdIRLdCrbXYQKIrlr1Z8yJK3JKDiP1LV+cgwJXKTxsse1c1tiv52zMaCgONwwGNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731633046; c=relaxed/simple;
	bh=XQOgXWRTTs7IQ2cfzLqHbmQ98umMoaABvnUlIWfao8Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G+wevAPCtgFngHFP6FbK/SMq4AQIWV37PxnW8ldAOyGQkDa/2CcO7BTnw240TU2HusleCuTDVRTXKlxPUjdrX1l5h5t2wdkEkeEFO/c9Hud29bjuRhCM56bibK/fHKwd5JACZ+qleO60KW+Jqu7GuOP7nDuosnEWsJAwKp1qjKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=bWh4yWeF; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEKolPb000637;
	Thu, 14 Nov 2024 17:10:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=XQOgXWRTTs7IQ2cfzLqHbmQ98umMoaABvnUlIWfao8Y=; b=
	bWh4yWeFROTJjHMOL4as4Ne4dWpSZxxrMygTaSeVJRH0mSenEZKJ5DFVhkDaKmdZ
	n2o/F48CAL8EqW36bQQH2HH7wx+nVSKPM2A3i79ESTQnCGLpQGLW1jKU9ntIdwtI
	A9Tz8UQ3Ei8T4SsOxWCOj8klbqW5nY3bp+BQwclmwRYqSJIdeirAb4mUycyc2l7a
	sqO4UMw6mazt+OLiDuodI+MEDdBN5BfeiHhEu8JxysUyDq6oLL4FC+Fc8ffkmqqd
	zEMaHKLucdCpFLM7bSLKfFquwoGc7SzhDoGRdTtykCdjVMm+Jb0fJcXuRncd7WSG
	sYAOlFGPjeJiRXd0V9f19g==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42wjr5n0gu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 17:10:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egwZLLkvtq4eh4wha1t23+jRbPWSoQ/bKKyw9lHV6UgBGBXPPKa81m2CCGp96E5XxmldlNhNEA08Bn0buJjNzxMLvpmaXpSKpqomARFq5cAhCYufok4aUSMTpieTQ1oAS+x1IuQ3zoeoOq2a+UfXUvXmF+D1azevq5yQbWFTdAG45lH3daPVkGRy5kFG+oY9jqnFDSUO5U/tdzWYmzReEd7HdNXZikwIFxXqo/VhC4JZP5SDxo0ob9lQV0YtGt+cWjD+yx6xxff1RxYXkc1Jr7ZGfSHz5QrJAgw7YSaogZmeHjYwzZtWfHarQVfHehGIMeDAABRj8lSZeZVeOheyBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQOgXWRTTs7IQ2cfzLqHbmQ98umMoaABvnUlIWfao8Y=;
 b=FoufKD3gGdNQnNDuriOLIA7lT6HNTuYFxVxipYuo7VwjqTgQKF/gcwRD5t6TwzJCBx5ThPhYDLEmdCl0ZUzrKslYWk+ykfKBLzo1w6njSulJ6+AdMWbIvJebifV9TCPwuwF2EINqlJ2IY5FXQMviotWwtjSf1QIWAM/2SzF3kQwmvNg7GFdBATwj56kFFeWaHrhsW6faT+tkXezgi133a6Ip81OJMchvDxnbmWcdZ+xTpV0x62krzu+cNLug8ug8eXNb68QJcNyRSWmuEJWsnlPb+laVpzjNTSvhZCyveVmRBJXoWqTm2N88JNcD+J+LDDZ1+NL1Uv3uRyiVnrrptg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BY3PR15MB4881.namprd15.prod.outlook.com (2603:10b6:a03:3c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 01:10:39 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 01:10:38 +0000
From: Song Liu <songliubraving@meta.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Song Liu <songliubraving@meta.com>, Song Liu <song@kernel.org>,
        bpf
	<bpf@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>,
        LSM List
	<linux-security-module@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>,
        Alexei
 Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin
 KaFai Lau <martin.lau@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        KP Singh
	<kpsingh@kernel.org>,
        Matt Bobrowski <mattbobrowski@google.com>,
        Amir
 Goldstein <amir73il@gmail.com>,
        "repnop@google.com" <repnop@google.com>,
        Jeff
 Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        "gnoack@google.com"
	<gnoack@google.com>
Subject: Re: [RFC/PATCH v2 bpf-next fanotify 7/7] selftests/bpf: Add test for
 BPF based fanotify fastpath handler
Thread-Topic: [RFC/PATCH v2 bpf-next fanotify 7/7] selftests/bpf: Add test for
 BPF based fanotify fastpath handler
Thread-Index: AQHbNnGAryo3J6mFf0ePhnT/vr0UcrK3NqIAgAAvFgCAABuhgIAACBOA
Date: Fri, 15 Nov 2024 01:10:38 +0000
Message-ID: <DCE25AB7-E337-4E11-9D57-2880F822BF33@fb.com>
References: <20241114084345.1564165-1-song@kernel.org>
 <20241114084345.1564165-8-song@kernel.org>
 <CAADnVQK6YyPUzQoPKkXptLHoHXJZ50A8vNPfpDAk8Jc3Z6+iRw@mail.gmail.com>
 <E5457BFD-F7B9-4077-9EAC-168DA5C271E4@fb.com>
 <CAADnVQJ1um9u4cBpAEw83CS8xZJN=iP8WXdG0Ops5oTP-_NDFg@mail.gmail.com>
In-Reply-To:
 <CAADnVQJ1um9u4cBpAEw83CS8xZJN=iP8WXdG0Ops5oTP-_NDFg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|BY3PR15MB4881:EE_
x-ms-office365-filtering-correlation-id: f3264218-f372-4d63-968b-08dd0512514f
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T1AxTFpuSS9aSkhyeVJSOG5ORHpRNHQ3bXNQaFgzY0ZPSVJmaWhJTnVkUkpD?=
 =?utf-8?B?K3ltd0htTldnWTU0cnRsQnVCNGtUMTdTNjhnM0JaVHdLckxkM0lvdVdYSVdQ?=
 =?utf-8?B?dkQ4NjNadGs2cVNpOXA0cG9ITlh3dDRac3ZGVzRRWCtEWmJoYndFclFzTWRG?=
 =?utf-8?B?NmZQc3NNcDRyRjJpYWZ2M3c1OWxkdnRra2Rqb2hneUtTZk90bzQySk4yU2dy?=
 =?utf-8?B?Tm5xSGNIL3JaWFlucXZDUVhJYVhnTFdmOE91QXJVNWQ2aktFaFZ0SGY3Mmx5?=
 =?utf-8?B?REpUVUdrWlRZNEtoejVPWVV1M2pkQ1piL2RTTnBoWDIvRmpocGhqeDNaNGpt?=
 =?utf-8?B?ajFySzlLM0NSdWZVZ1BuQjB4MHk4ZG1yRU1jL3lqZVNHeFhMaFd4NVdRQXZk?=
 =?utf-8?B?RFpNaWduNGI3dDRuNFZuenFuckp3WnJXL3VJa0VBRFgybGp5Mm4yVitBSEhP?=
 =?utf-8?B?NkxXdVc5cTR6bWFOVGlKMlhkOExRTTBwTVV4RGIyMS82OTNGY0lLYkpRTzRB?=
 =?utf-8?B?SFp5bUVXUXMvbVh5SHVodGhaVE5lZzJrNk5GakZFaG5meHhMR2NSUGtSQThy?=
 =?utf-8?B?NTE3Wm5XRXFhT2pCTkd0cWFqVm83V05XdnJpWk54T1o5YnpOM2kzdDdhQWtM?=
 =?utf-8?B?bFpiSmpDalRKYkRGT2VudjNmM3lWZm5HTEhWc2VQendPOEpOb3VqNlRnYkFw?=
 =?utf-8?B?c2FSTkxidUpJeDBYeUNGYTJvZUV5Z0dZYlllN3hLdDZOVTNBRm9wWmRqeWRR?=
 =?utf-8?B?SVIvdzYxNGdRQSt3a1dQK2lYVXRPNzNxRlNpOFIxaTRTQUY4c2NiamZuVlZh?=
 =?utf-8?B?KzlFZlRTdi85bGtSTWlhUEFDdTIwVlJUQ1cvcHlsNjYxNEgxUitpWThHU0pq?=
 =?utf-8?B?eXBLekVwRkZWRUszUURIYzRycjVoOFpkSVYzSE1kMkZxSnZmeDM4OVJkWFBn?=
 =?utf-8?B?MGI0b2NkWU1qYWxOWWxXNm9ROUpJeXhQL3llMzYvTzQ0M0NVZzJ1OThFaFhE?=
 =?utf-8?B?TmZJVUY1ZlBaR0FtVk5nOFBGa3Y5ZVBCTDM0YkhobU9FUmE5b0trVGtlSHFm?=
 =?utf-8?B?QW5tL1BiWWhtMWpMNmd5dkZiK25pbFFtdW9HN010RU1EbFYwQ2E4RDdsMXNo?=
 =?utf-8?B?dVZkRTN6aVVuTUlUVjhrT3FaQlJ0R2VvRXZnMERGbnlNN0JVUWErbitXNTg2?=
 =?utf-8?B?dFZCM1FzTDhnS3p2aVVTWlRwVVZLWW1NZGR4bkU4b3R0Vnl6c01lQm9XbnRT?=
 =?utf-8?B?amVtNDh6ejYrOGJldmN2eW9NQkFJeGRoVDUrWGlybnhiQ0FQbHZweENUUUlN?=
 =?utf-8?B?dHc0aTl0VGxxUC9CU2FQamJ6MmxjTkcwRFQrV3JaK1V1bmhtY0lucE1oWTN6?=
 =?utf-8?B?azNuLzVYN2wrUTNDaXp4WDJFVXNHcFlEekkxWDRKRWtIb0puWjRNaDBsL3F2?=
 =?utf-8?B?cFRQai9BVkEyR2xveGdtQUdNSUJaNEhRT0s3QzNIOWhGNTF3K05GdzQrS1BN?=
 =?utf-8?B?WEFBVUkyV1owcXkySTZNUFZZQm50WnJyb2M3UWozdVRjRWFEdkZlMlhydnlS?=
 =?utf-8?B?VEZHQXFXeWk4QjNBNjR5a214ZzR1bFBZcVpVMHNEQTQxUUl1WFhnc1FuQlBt?=
 =?utf-8?B?L0RHWFhMSDVoRVpMak92MldqQTRUQkFXdzFZWFJ3R0tWU3ZXRTFvUm5ZUWRv?=
 =?utf-8?B?S2ZGYnkwQXpMRFhCQ0wrdDR0UHZFTTh5bzVPYUV1U29mVVI2bHpjSERaa3dm?=
 =?utf-8?B?cXMzZjVZTVdRaDZ6Z1pGemFkd2RtRlZUUlppdG04UDlDeG4rc1lGcGVIRXRa?=
 =?utf-8?Q?2YwBiFQIyifJu8IMwcx95n+PJClZMxs2mFrOE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UmtQOWVsTlB0VitKb1U1VUlnYm5BdjRkZnNlTVE2N0o5ekUyL1YwZTBKV0JH?=
 =?utf-8?B?MTdqd3pOYkxlTFNKUTErd1gwdXozS0xuNkNHemJmV2pkZmdiNTNmbG1xTytS?=
 =?utf-8?B?elVka1FKc3AzNzZQUFhpd0E1RG1nRVkyMG93MXpoT3l5ejFkb1F2ZVczWXhr?=
 =?utf-8?B?OGYyV0xPVDk5aERQekRPWGo1MERlZFhHNnJTSEJOQjc0NERqWWtsM1o1OUh2?=
 =?utf-8?B?RHVWWmxhSHhGMGdib1p1Q09aT3BKNjhXaGhuWDE0U3E2a1hHMzBNRFFLSWxm?=
 =?utf-8?B?SDVpNXpHRGhkZS90ckQwL0dVNy9hdEt4WHVkOG1MczJnQlZlT1haM0Q5dnVz?=
 =?utf-8?B?UFZZWkNqUktGRG1SZHZFWE1aNGhQcUtpSXd4cG8yaDBlRFA3eWMxNU1IZm9o?=
 =?utf-8?B?MHY2MXhJSVJZWkVVM213MmkvQ2xxVzdpMy9yZW9NNEs4QkZKYlc0WTBUUmhF?=
 =?utf-8?B?d21KWEx6Vmw3djVOb2VJUG5zejMwQVNLaU9BM0pCK3d6MzkwQ0FEU0ZYc1F0?=
 =?utf-8?B?M0E2N0JUT1gzVlFUVmFGZ1FrZ2hsODNDclhKYTFkYU82SzR6WHZPS3RYNjdu?=
 =?utf-8?B?QnlpQ0d1ay9xdDcxUmEvc0pNSVRGUk5QMWJJL1Z3NFJjTldibGs5aDErTFNl?=
 =?utf-8?B?bnJRYjdjWWZSQkZOSnhvK3poYkNQTHAzNGl3Y2M1VmlkK3pLU3NDS3RFNEZS?=
 =?utf-8?B?cGVWZXFNSHRrbGREVzFrZVczWmhvYlVMbHQ1WnVFeVZjcms2eVdHNlVJSzd6?=
 =?utf-8?B?eVlkSU1Jem56RGlSOGcvL0QwMTEvVlg0TDkxS21ZNlBPdU8zZlp2RXg0NEty?=
 =?utf-8?B?TUtxa1B4NC9tVWZjcndXTXpHOXVSelRwelp1ZjV6eXJWd0tmWU9TT1ZpTWlG?=
 =?utf-8?B?UVdBNXZnRGFXOVRXalhiQlRjd3JyWEx4enNEUk91aThzUk00T2VRTmgxem1Z?=
 =?utf-8?B?a2R5SDBrMEEzL0FQNFh1VnoweldFZzNwbHRMUFc0NXpwdGV5S2cwbGw1OVhq?=
 =?utf-8?B?VUhNaHlPR3N5RzZPcTdObWxQcGF5T1ZYVHU1WWhvR2NYWFcrYnNBY2RxYmN4?=
 =?utf-8?B?MVRjL256bHhGaVhYYTRXY2EwM1RTRVJQeURTT1piN1NtdytNa3hJL0pGQkl0?=
 =?utf-8?B?Qjg0bXF3bGF1UngxNmlHZk1iNnpEL0x0Sk1lbk92U0JBcG5sREUySkswRFJu?=
 =?utf-8?B?MnR5Y2JnTW5GT0tuRWFSeHZsQk11a0U4NGJPSVl1eHpha2VnNDY4VC8yaDdk?=
 =?utf-8?B?cHp6T3hqTllLdnhCSmlSTXQxU0FSMzN1NkgvNDBYTnBPRCtyUlNuQmZPUitY?=
 =?utf-8?B?SVVDdWUzbDZWL2hQY0F6T0J6WTViUTMxaENrOUh2dHppOC84aTEyMDRERnlC?=
 =?utf-8?B?STVqTzhDQmtydGxRbC9yczVlVXpBNndRbjl1TERBaWs5NTZGakJ0c0Uvd014?=
 =?utf-8?B?OVhnWnl1a1dnS29ZQ1lLc0Q1ZEZvSCtsYzN4MWRWTnlWcE4wdWRVbzZvc2ow?=
 =?utf-8?B?aUwyeEFtZUM2Vlk4SzlSK0o0M0J2emZhSGVmSmR1a3B2QjlIWEwvdGJMKy9p?=
 =?utf-8?B?enZqN3ppQWR1TFlab0VSVVY0L2pYVE1tcUdiQ0JrcnVXUXpkZXpmUVVhTlJI?=
 =?utf-8?B?YzVJT0VldW1CSk9lWlp3VEFZVytaUHZtUGhUeWJKSmJYODdEUTNKUG5CME9Z?=
 =?utf-8?B?Y3MvZ2d4em5rT0xLOHBDYmw2YjlvcFVjSGxLMGhHMmV2NEhnNEorNFJkdXpD?=
 =?utf-8?B?bTdWSmpFTXNaS0xoZkpSb0s0RmI2T0hJd2t5UHUrazFqRWJGVzB1ZzJyclpE?=
 =?utf-8?B?ZEExemljZi9zU082dG5GVnQ3RnJic25PK2VKVG5WUzhZOGhodUlqeElKOUFo?=
 =?utf-8?B?SURPZzQ2dklaL041dmd0QkdaU3IwWTlwaUtiK1VmQVVZWjhNcnlXdGpudkRu?=
 =?utf-8?B?bUtNZFhUZWlOdHdwNXppTXJhQWdNYTd3YkhOUEpyc0JNblRmZ3Y1Y0kzd21n?=
 =?utf-8?B?OXZBaFg1TzFCczRDU1pLRG1IclFCZk5rYnRDNm9IT29NcEZ3dFMrZFBCRnhU?=
 =?utf-8?B?aE1KYlRQU0QrRW1yOE5udWdvWFVJZzFKLy84T2d3QkdhSFY0OXNLVWhoYzUv?=
 =?utf-8?B?dFlHd0xNR3JGSElWQWlKUitkNmRKR3ZsL29yc1ZaYWxaTkxZa1FHazZybFZ1?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E631EB9716D11845A6EA33D49A64BD62@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f3264218-f372-4d63-968b-08dd0512514f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 01:10:38.7759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 05KNoGgdC60Izk2OMjnYqfOrmyogQTWZQ2WrDvEezxB3YqgdUFP2MUk9BKuTip6orc8iSG25mWBxvvOSHcpI3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4881
X-Proofpoint-GUID: l5gTIM7p5SG9HcFxb1SXmh6Rwfby44qD
X-Proofpoint-ORIG-GUID: l5gTIM7p5SG9HcFxb1SXmh6Rwfby44qD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gTm92IDE0LCAyMDI0LCBhdCA0OjQx4oCvUE0sIEFsZXhlaSBTdGFyb3ZvaXRvdiA8
YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIE5vdiAx
NCwgMjAyNCBhdCAzOjAy4oCvUE0gU29uZyBMaXUgPHNvbmdsaXVicmF2aW5nQG1ldGEuY29tPiB3
cm90ZToNCj4+IA0KPj4gDQo+PiANCj4+PiBPbiBOb3YgMTQsIDIwMjQsIGF0IDEyOjE04oCvUE0s
IEFsZXhlaSBTdGFyb3ZvaXRvdiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6
DQo+Pj4gDQo+Pj4gT24gVGh1LCBOb3YgMTQsIDIwMjQgYXQgMTI6NDTigK9BTSBTb25nIExpdSA8
c29uZ0BrZXJuZWwub3JnPiB3cm90ZToNCj4+Pj4gDQo+Pj4+ICsNCj4+Pj4gKyAgICAgICBpZiAo
YnBmX2lzX3N1YmRpcihkZW50cnksIHYtPmRlbnRyeSkpDQo+Pj4+ICsgICAgICAgICAgICAgICBy
ZXQgPSBGQU5fRlBfUkVUX1NFTkRfVE9fVVNFUlNQQUNFOw0KPj4+PiArICAgICAgIGVsc2UNCj4+
Pj4gKyAgICAgICAgICAgICAgIHJldCA9IEZBTl9GUF9SRVRfU0tJUF9FVkVOVDsNCj4+PiANCj4+
PiBJdCBzZWVtcyB0byBtZSB0aGF0IGFsbCB0aGVzZSBwYXRjaGVzIGFuZCBmZWF0dXJlIGFkZGl0
aW9ucw0KPj4+IHRvIGZhbm90aWZ5LCBuZXcga2Z1bmNzLCBldGMgYXJlIGRvbmUganVzdCB0byBk
byB0aGUgYWJvdmUNCj4+PiBmaWx0ZXJpbmcgYnkgc3ViZGlyID8NCj4+PiANCj4+PiBJZiBzbywg
anVzdCBoYXJkIGNvZGUgdGhpcyBsb2dpYyBhcyBhbiBleHRyYSBmbGFnIHRvIGZhbm90aWZ5ID8N
Cj4+PiBTbyBpdCBjYW4gZmlsdGVyIGFsbCBldmVudHMgYnkgc3ViZGlyLg0KPj4+IGJwZiBwcm9n
cmFtbWFiaWxpdHkgbWFrZXMgc2Vuc2Ugd2hlbiBpdCBuZWVkcyB0byBleHByZXNzDQo+Pj4gdXNl
ciBzcGFjZSBwb2xpY3kuIEhlcmUgaXQncyBqdXN0IGEgZmlsdGVyIGJ5IHN1YmRpci4NCj4+PiBi
cGYgaGFtbWVyIGRvZXNuJ3QgbG9vayBsaWtlIHRoZSByaWdodCB0b29sIGZvciB0aGlzIHVzZSBj
YXNlLg0KPj4gDQo+PiBDdXJyZW50IHZlcnNpb24gaXMgaW5kZWVkIHRhaWxvcmVkIHRvd2FyZHMg
dGhlIHN1YnRyZWUNCj4+IG1vbml0b3JpbmcgdXNlIGNhc2UuIFRoaXMgaXMgbW9zdGx5IGJlY2F1
c2UgZmVlZGJhY2sgb24gdjENCj4+IG1vc3RseSBmb2N1c2VkIG9uIHRoaXMgdXNlIGNhc2UuIFYx
IGl0c2VsZiBhY3R1YWxseSBoYWQgc29tZQ0KPj4gb3RoZXIgdXNlIGNhc2VzLg0KPiANCj4gbGlr
ZT8NCg0Kc2FtcGxlcy9mYW5vdGlmeSBpbiB2MSBzaG93cyBwYXR0ZXJuIHRoYXQgbWF0Y2hlcyBm
aWxlIHByZWZpeCANCihubyBCUEYpLiBzZWxmdGVzdHMvYnBmIGluIHYxIHNob3dzIGEgcGF0dGVy
biB3aGVyZSB3ZSANCnByb3BhZ2F0ZSBhIGZsYWcgaW4gaW5vZGUgbG9jYWwgc3RvcmFnZSBmcm9t
IHBhcmVudCBkaXJlY3RvcnkNCnRvIG5ld2x5IGNyZWF0ZWQgY2hpbGRyZW4gZGlyZWN0b3J5LiAN
Cg0KPiANCj4+IEluIHByYWN0aWNlLCBmYW5vdGlmeSBmYXN0cGF0aCBjYW4gYmVuZWZpdCBmcm9t
IGJwZg0KPj4gcHJvZ3JhbW1hYmlsaXR5LiBGb3IgZXhhbXBsZSwgd2l0aCBicGYgcHJvZ3JhbW1h
YmlsaXR5LCB3ZQ0KPj4gY2FuIGNvbWJpbmUgZmFub3RpZnkgYW5kIEJQRiBMU00gaW4gc29tZSBz
ZWN1cml0eSB1c2UgY2FzZXMuDQo+PiBJZiBzb21lIHNlY3VyaXR5IHJ1bGVzIG9ubHkgYXBwbGll
cyB0byBhIGZldyBmaWxlcywgYQ0KPj4gZGlyZWN0b3J5LCBvciBhIHN1YnRyZWUsIHdlIGNhbiB1
c2UgZmFub3RpZnkgdG8gb25seSBtb25pdG9yDQo+PiB0aGVzZSBmaWxlcy4gTFNNIGhvb2tzLCBz
dWNoIGFzIHNlY3VyaXR5X2ZpbGVfb3BlbigpLCBhcmUNCj4+IGFsd2F5cyBnbG9iYWwuIFRoZSBv
dmVyaGVhZCBpcyBoaWdoZXIgaWYgd2UgYXJlIG9ubHkNCj4+IGludGVyZXN0ZWQgaW4gYSBmZXcg
ZmlsZXMuDQo+PiANCj4+IERvZXMgdGhpcyBtYWtlIHNlbnNlPw0KPiANCj4gTm90IHlldC4NCj4g
VGhpcyBmYW5vdGlmeSBicGYgZmlsdGVyaW5nIG9ubHkgcmVkdWNlcyB0aGUgbnVtYmVyIG9mIGV2
ZW50cw0KPiBzZW50IHRvIHVzZXIgc3BhY2UuDQo+IEhvdyBpcyBpdCBzdXBwb3NlZCB0byBpbnRl
cmFjdCB3aXRoIGJwZi1sc20/DQoNCkFoLCBJIGRpZG4ndCBleHBsYWluIHRoaXMgcGFydC4gZmFu
b3RpZnkrYnBmIGZhc3RwYXRoIGNhbiANCmRvIG1vcmUgcmVkdWNpbmcgbnVtYmVyIG9mIGV2ZW50
cyBzZW50IHRvIHVzZXIgc3BhY2UuIEl0IGNhbg0KYWxzbyBiZSB1c2VkIGluIHRyYWNpbmcgdXNl
IGNhc2VzLiBGb3IgZXhhbXBsZSwgd2UgY2FuIA0KaW1wbGVtZW50IGEgZmlsZXRvcCB0b29sIHRo
YXQgb25seSBtb25pdG9ycyBhIHNwZWNpZmljIA0KZGlyZWN0b3J5LCBhIHNwZWNpZmljIGRldmlj
ZSwgb3IgYSBzcGVjaWZpYyBtb3VudCBwb2ludC4NCkl0IGNhbiBhbHNvIHJlamVjdCBzb21lIGZp
bGUgYWNjZXNzIChmYW5vdGlmeSBwZXJtaXNzaW9uIA0KbW9kZSkuIEkgc2hvdWxkIGhhdmUgc2hv
d2VkIHRoZXNlIGZlYXR1cmVzIGluIGEgc2FtcGxlIA0KYW5kL29yIHNlbGZ0ZXN0Lg0KDQo+IFNh
eSwgc2VjdXJpdHkgcG9saWN5IGFwcGxpZXMgdG8gL3Vzci9iaW4vKg0KPiBzbyBsc20gc3VwcG9z
ZSB0byBhY3Qgb24gYWxsIGZpbGVzIGFuZCBzdWJkaXJzIGluIHRoZXJlLg0KPiBIb3cgZmFub3Rp
ZnkgaGVscHMgPw0KDQpMU00gaG9va3MgYXJlIGFsd2F5cyBnbG9iYWwuIEl0IGlzIHVwIHRvIHRo
ZSBCUEYgcHJvZ3JhbQ0KdG8gZmlsdGVyIG91dCBpcnJlbGV2YW50IGV2ZW50cy4gVGhpcyBmaWx0
ZXJpbmcgaXMgDQpzb21ldGltZXMgZXhwZW5zaXZlIChtYXRjaCBkX3BhdGNoKSBhbmQgaW5hY2N1
cmF0ZSANCihtYWludGFpbiBhIG1hcCBvZiB0YXJnZXQgaW5vZGVzLCBldGMuKS4gT1RPSCwgZmFu
b3RpZnkgDQpoYXMgYnVpbHQtaW4gZmlsdGVyaW5nIGJlZm9yZSB0aGUgQlBGIHByb2dyYW0gdHJp
Z2dlcnMuIA0KV2hlbiBtdWx0aXBsZSBCUEYgcHJvZ3JhbXMgYXJlIG1vbml0b3Jpbmcgb3Blbigp
IGZvciANCmRpZmZlcmVudCBzdWJkaXJlY3RvcmllcywgZmFub3RpZnkgYmFzZWQgc29sdXRpb24g
d2lsbCANCm5vdCB0cmlnZ2VyIGFsbCB0aGVzZSBCUEYgcHJvZ3JhbXMgZm9yIGFsbCB0aGUgb3Bl
bigpIA0KaW4gdGhlIHN5c3RlbS4NCg0KRG9lcyB0aGlzIGFuc3dlciB0aGUgcXVlc3Rpb25zPw0K
DQpUaGFua3MsDQpTb25nDQoNCg==

