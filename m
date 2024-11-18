Return-Path: <linux-fsdevel+bounces-35144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3BC9D19E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 21:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D877282F48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 20:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A951E7643;
	Mon, 18 Nov 2024 20:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="CKueU78j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53159172767;
	Mon, 18 Nov 2024 20:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731963090; cv=fail; b=nglZLC/wHq2Eh3bBdTE9CZg33/A8/KMgABDw1ZePSVaKXlwQjlThPge2+1LYMbBnpITotnpRuRHE7/z+i7T7KuKUT+u5OgWeH6Hx2XprGkuQBRLM3qHXGlx5S6HS1mHzWN6bYN/H+aXzOTZA2ldhF+CjzskAtwVMqhW2QbBlyTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731963090; c=relaxed/simple;
	bh=dMQ/TmW7V2Y9+xXi9MIrRef7OsXvy825IhC3Mpzag80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OGS5iZpKrS1OtN/9KIGNw7+Dj7wqI6Izvcc4+Gtc+Xa8Rd65QkcdvaRoaJqojUMcyIlfMeZMJd3z6HYliffSX/Gd7pwe2Bx8MgvDGdAqX2tqw9g44OLIjCJq0AfYmoBnpOX/EhbVrq1URAt7TBb/UZhnColrkFjFxrLoDDHUYvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=CKueU78j; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIJa5NN004815;
	Mon, 18 Nov 2024 12:51:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=dMQ/TmW7V2Y9+xXi9MIrRef7OsXvy825IhC3Mpzag80=; b=
	CKueU78jCF0xtqxCqSTqjzt9awVA97pr5+4paepoRt8IlAQEEWiNYS8nEFq47qwp
	HiBNccGM7/uC8xFvDXHYzlbaFcHcmic4TSogG9TQwa5NlNquo+HwQ2EuoNNL9L5X
	3rrO0GADJFcGY6mKVWKv1vQOTzMoPFV7/lEe7YyLzllz5pD8GIlMcsoFBxhKBakO
	NTa3NlxVMZPzAv1ahKNWdC1CF9rm8+gE0zUwVTTsJN8PgNOsyiZnG0pq23mf1gDe
	6sQ6WEsXDiS+BOy8286vxwXN+oCx+8GXp9Ka2oAtx+EI6iJoDAUD9Gq6lSteJgfG
	cb4V8+4KufgN+Mq4pCKPig==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4309m2hpyt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 12:51:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jReu5M1TWHNebRe/iCtYk2o0aBAMyK/rdczEFVyGOoBzoIbllo7DfHQYdTO5r1h0RpxiCXEshVlbHjO21TXpYpcMA1AqsApZtEcO9jAnFLrY35tjOg5NkyyMbzNzxICuovrRu934TDId9nAdMU6eykZMTXMdQia56PWv50GqhUjaEUDluwAPy9TYp3B7vAkWhnbfRsCv6pR0kgzAxYodmnn5UrU5+OuUKPU8sAxZ76TKcKb+JQD+iUJQ0Gk4jCIeDi/qmK5zNSus/k0XJIZna8ltCKEuXoeuE87AA+TlImJoK6m+6oDLuDtQ1tOrcUTGmFFLnnjk4Yu9foq2VZyDlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMQ/TmW7V2Y9+xXi9MIrRef7OsXvy825IhC3Mpzag80=;
 b=vcIN/IncvhOk9rxUveU04Hcl5q3jVz2cinYrottB/xNj9JDHiWdXoYrjsYJ4sgo2fqdoOSHsk5EupNsqPVI+GKtytyjwHrosR3tzoJyWu3OA8D81FdFvkequvTnqB83QQMdPKFyIyoGEUhrwzigL4hAbZNjzY6XUJKU5PikwOODLo32dgho8DH+Xx+nA0L2PP0tbvNZRuyQGGRohoSkFdgyQCUxg1T2KiEVSBv0QaViAIUykgp2DtfRrM0fjeRYMJ0OZkG1C+dGe3dV6VlPRBKRl5RX7tanGJZWXszY60EKNeVrLzhESsYXPCO54QPrfRGADPSFQnTqCmy7Cl58JBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CO1PR15MB5116.namprd15.prod.outlook.com (2603:10b6:303:ef::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Mon, 18 Nov
 2024 20:51:22 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 20:51:21 +0000
From: Song Liu <songliubraving@meta.com>
To: Song Liu <songliubraving@meta.com>
CC: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Song Liu
	<song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux-Fsdevel
	<linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LSM
 List <linux-security-module@vger.kernel.org>,
        Kernel Team
	<kernel-team@meta.com>,
        Andrii Nakryiko <andrii@kernel.org>, Eddy Z
	<eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Alexander
 Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>,
        KP Singh <kpsingh@kernel.org>,
        Matt Bobrowski
	<mattbobrowski@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        "repnop@google.com" <repnop@google.com>,
        Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?=
	<mic@digikod.net>,
        "gnoack@google.com" <gnoack@google.com>
Subject: Re: [RFC/PATCH v2 bpf-next fanotify 7/7] selftests/bpf: Add test for
 BPF based fanotify fastpath handler
Thread-Topic: [RFC/PATCH v2 bpf-next fanotify 7/7] selftests/bpf: Add test for
 BPF based fanotify fastpath handler
Thread-Index:
 AQHbNnGAryo3J6mFf0ePhnT/vr0UcrK3NqIAgAAvFgCAABuhgIAACBOAgAAGAICAAFv2AIAA1H4AgAAXZQCABLMTAA==
Date: Mon, 18 Nov 2024 20:51:21 +0000
Message-ID: <B3CE1128-B988-46FE-AC3B-C024C8C987CA@fb.com>
References: <20241114084345.1564165-1-song@kernel.org>
 <20241114084345.1564165-8-song@kernel.org>
 <CAADnVQK6YyPUzQoPKkXptLHoHXJZ50A8vNPfpDAk8Jc3Z6+iRw@mail.gmail.com>
 <E5457BFD-F7B9-4077-9EAC-168DA5C271E4@fb.com>
 <CAADnVQJ1um9u4cBpAEw83CS8xZJN=iP8WXdG0Ops5oTP-_NDFg@mail.gmail.com>
 <DCE25AB7-E337-4E11-9D57-2880F822BF33@fb.com>
 <CAADnVQ+bRO+UakzouzR5OfmvJAcyOs7VqCJKiLsjnfW1xkPZOg@mail.gmail.com>
 <C7C15985-2560-4D52-ADF9-C7680AF10E90@fb.com>
 <CAADnVQK2mhS0RLN7fEpn=zuLMT0D=QFMuibLAvc42Td0eU=eaQ@mail.gmail.com>
 <968F7C58-691D-4636-AA91-D0EA999EE3FD@fb.com>
In-Reply-To: <968F7C58-691D-4636-AA91-D0EA999EE3FD@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|CO1PR15MB5116:EE_
x-ms-office365-filtering-correlation-id: ae32f61b-ee8e-4593-4171-08dd0812c22a
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VkVueHlLZ3lJUi9leFE1VDJoRnFPN3Z5dmd4ektSalBPVEpmVHZ4MzUxWklR?=
 =?utf-8?B?VjFxMTFkcUI1Qk9Sbk5Za0R5d01QRlNWd0lEMUIvR1NJVHJZVnZsc3NORUZz?=
 =?utf-8?B?bHRoelgyWktDYVlZY203ZHNsS01wK0JYS056ZnhUOUtxN3JsNGFxZ1lleUpG?=
 =?utf-8?B?QW1aeC8zM1ZTbVpaVitTNThuQVl4NXI3Vi9MUUJYS0dYa2VZaWxZZEF5cHQ5?=
 =?utf-8?B?SDVQZVZaRXJNM1JodExYd01TUEIxeHFvRXR0cVZReHFSelhRRnhiODgyaHVI?=
 =?utf-8?B?NUY1TjhpL0pwMy81eGZ2ZjF3c0ExNDI4MTBZV05kcFhucFViODEreG1pTUVN?=
 =?utf-8?B?QzZmeW41UlI5Y1NkUXMydkZPdjFnVlhkbDdxSEhCblFtWDVjL1N5WUl0WkxB?=
 =?utf-8?B?Y3ZWU0c2STcyMnc3WDRxM0J0WjRMRDlRZWRYZWgxTXFudUkrTGFVZFMyOHdY?=
 =?utf-8?B?aFB0RW8zOVVyWFVyeFdxcmFtWW9HMmpXSW9nTWNpK1pvUDBFTzBnaytRdnMv?=
 =?utf-8?B?RDBnQUhiWXJyK3Jicmt3NUVrRC9kNWdQbE9aWVFZN3Y0b1NjS1pWL21sVk5P?=
 =?utf-8?B?Z05HZjY1MXpFdm5CSy9OUXE5MXNuR1lCOVArZVMvNnRId2RvR0lKZEdqaXMv?=
 =?utf-8?B?R0t6R2c3enlvWXU3YXBFSitrbE5DQ1htenhDZ2llQ2ZOT002QW5NL3U1UUFE?=
 =?utf-8?B?MW8wNm5lOEhrVXhNcHYxZ0VVZHVPbWxkMlp5VlMzTUNhS0JoT0kwL05peFBS?=
 =?utf-8?B?Yk1NamIvUElqd3BYVk9HSElBeEdYVTRNd3hEUGxDOGhjdEt2RWVmNjZCa3FS?=
 =?utf-8?B?aWN0am5JcnI2VE12YzJpaFdHN1ZXTWE5OTVvWUN1UEdZam9NVmlxNnZmdzEw?=
 =?utf-8?B?MHJzQnNkUEFaVUhMUTY2MFN2UWpSMTMwc2VYMlFPYS9ua0FMdmw1YkVBU3p0?=
 =?utf-8?B?VG9nNnBCQ0dkQmR4MXdUWXhtLzZOTnBxY2lUSmhzakFvSjRzT2tpcFl3VmZ3?=
 =?utf-8?B?MmxRSmtBT2l3ZDJNaGdETnNhaTVSQ1duTW1taGVkWlMyYjUvZCtDTGl2UU1y?=
 =?utf-8?B?ZWNCNlhkSHlYWEwrYVE0NzFFZDJIWm5nZTdqRFFnaWdFYkNXcmhxeVRsL2lB?=
 =?utf-8?B?NDMxemVOeXhrWmRBTDJ3M1RSbmw2L3BMR3JDbGhsY3V2Q1hUcEppRU5HNEZR?=
 =?utf-8?B?ZVJadEg0aWMvcW5pb1BYSUxzNi83UUhEb2tROTNMSGxWQnlURWV0N2FMMXI2?=
 =?utf-8?B?L1VQOUdDcnoyZko1d1FrbWRjZUFsWlNaaDA1VVdYUGpQMXI1YnZmQjNnUGcx?=
 =?utf-8?B?SklTUnRjWjJVNDFqUzQrTjV3WXdLUXl3T2RLN2JUOG1ydHNldjA5OHQvcmpK?=
 =?utf-8?B?VkoyZFJMR1JmTDNWdy9vZjNmSlBIak0wWE1vWUtYV2x2bTFMUHhiUGFaUDA4?=
 =?utf-8?B?VE80T3pvaEIrTTBWa3pQUjZkd0RLakhjVE14RjdENTdROGxodDFyUU16N3lX?=
 =?utf-8?B?b21ISWlJZ2YzU0kwcHhYUWJzbk9EQ2ZSYzNmalhkVEdGdENmazFqRG5rY0Uw?=
 =?utf-8?B?eWNLSStyQ2dNWmt5SmJldlBCS1g4VTB4RXhhNkRSTHNLYlZOazVYMitqclNl?=
 =?utf-8?B?YXBETUg5dWJXM0lkOFJTaGpOVUJURXB0dkJyTnFCOHNYNTE4cVUvUXVGeWNQ?=
 =?utf-8?B?czYvY3gwcHNXcFVjSUR1ZlhYVjVFbnN2b2VMMllma3BlaHdGaVBKU0RIZnRi?=
 =?utf-8?B?MTNYQTdzS2FYcWdjUVlDZXYzK0V6ZHlIdU5oZHNJZHNmWmtYUmdieGFGbnd6?=
 =?utf-8?Q?eLTt+JL5wJDY2CMNnGbt+i99Xs1R7/WElU8vY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SXBrdXJzUlphcnhGbzB3dGpZTk9WOWVEWklVdmM1SHgvM0cwQ0tkVlVBZkgy?=
 =?utf-8?B?YTVNRmtNMEg4WlNxZzJERkpCbVFkWWZ1MWVWWFpNU0V4UTJyRmU2cGovbFJs?=
 =?utf-8?B?cjlSMEwzQmRlbzBOVkxhWnFCaXROUjdRMGppWTEzcG9HSUlmcmt1dUt1Z0x3?=
 =?utf-8?B?aHZpWUwySUJCWHpaR2RjZEthYTRUQUtVUmwrUVBIU3I5c2UyZzN0YVJROVR2?=
 =?utf-8?B?TnJ4NW9mSi9wcDE1ekpuazJ1dWc0emRMZStXS3hhWFlkMXkwR2lPYlhMRzNo?=
 =?utf-8?B?MDNZajVTTzZ5dE1oTFVvRC9qUlU1S3pEbFAxdEdCSW16V2UzVXJqVkwzNDJS?=
 =?utf-8?B?aTFORFhRNm9Fdyt4dWEydENBZzA3UUI5SHI5R0M4UlR0elhGOVdRbHVlMmdY?=
 =?utf-8?B?WXhMc1EvVXU2VnJaNGFlUWpCa0lHbnMxVUhWSVkyZTRxanlocnBxRjcvYk4r?=
 =?utf-8?B?NjRxWDRoWFQxV2JUYkRBZjBwNVJoZHV3eUxqcXdKNWF4d0lOYVFCSENXVmww?=
 =?utf-8?B?YmFDU0pXcWI3M0ZLYUdKcnJhME05VjR3UEpSZFdJRmJIV29HcUxsZFZiZ25n?=
 =?utf-8?B?Uk1CeWJNbW9pVGRheXQyZmpFQm1Ma1g1ZFRwTG8yWm04ZzV2OHZWRjhiT3li?=
 =?utf-8?B?cGVvT2R4NlZtN2ZxQitqVXMvUUg4eEo0OHo4YXk3Vm9CNjlOdFJHNHJzYVgr?=
 =?utf-8?B?R3BlTVdQMmtpMWI5aXRMOUJRaEpQU2hOdU95NHA1VVBWZUI4dFpOM1BWdWtR?=
 =?utf-8?B?NUh2dU51RkRKdWc2dlhVUUpra3hBTFBtbFF0dXF1N2tYQnNOSjhYVkxEUHI5?=
 =?utf-8?B?ZFc3WUFsVm1INmV6T0hZTVE5U01OSk5sQkV0ZmxOelNiZXE5QlRyRVR4aDZj?=
 =?utf-8?B?RUJEd3VEemt6OXRFQWIwMDFPUWtuNXRCajlmR2ZXcVZnQmdvdDJNaVhIL1R5?=
 =?utf-8?B?eS9vRlM3YXRSUkFuU21KUTB4cjJUY0tRL0FqMm1wRGtiMUZsWmovZWgzUzB1?=
 =?utf-8?B?RUpHQjExTERib1hlYldGaGE3eGR6OUlYTTZhNkRtTmVSRVQ1WmtpYUl1Ymdx?=
 =?utf-8?B?SmpGNEpjbEFiZythZi9ZR1dHeFU3R1pnRHpnaEkwbjlmdUZFa1ErcGw3M2V0?=
 =?utf-8?B?eDFxRzFTQXJjMERHaGFjTGxpNTZXTC9VVmtBRk9XT0V4ZmxxRFJtODJrS2VV?=
 =?utf-8?B?QlR0MkkybDFmNGVoSGIvck9HbENNZ2QvaDN4Y0FtaE5USG4rOWorakJnekVv?=
 =?utf-8?B?ZjVqWkY0Q2NpcmNvbEhSK1FwNEx4NENTelFwcjVueHBIcjBEeFBqWUcrS0xh?=
 =?utf-8?B?Y1lES0lxWHFDVXJPNFIzSjhmYVp5Q3RkZ2JuYldMbDA2RDJ0ajZtdWpYTFNZ?=
 =?utf-8?B?cmQrTnNYZ3ZoMGl1MXNsejEwcWJZa1Z5aUU1TVUwQmRzb1ZwUjgxMWw4NDUw?=
 =?utf-8?B?ajJKa2U2dHQxaG10TmFmbklZZzNNQXFDbTc0MXlYYThQNEI4WFUxZk1MSDBm?=
 =?utf-8?B?blNCcWNOdUpPcU9sbm1NUUlZNkcva2wwd2hVQkE1bXUxV3dhZFFRNXZVVTRs?=
 =?utf-8?B?YjJoaCtyeXJqRThkYWEySUFuRm1zdVc4OEN2UHo5U2lLUXBEaWNpUS8rOFVt?=
 =?utf-8?B?ME95NERBZldGREdBNEorRXhSZm5hRVNSRlhzZjRoc0RJQVJwRndFb1hHNmdq?=
 =?utf-8?B?aEZqMzN6QTBoV003eWVuMjJpV2dLZHo0U1pKQ3dFRXp1dEpnZndVZ0lTRzFy?=
 =?utf-8?B?aTRoSDh2UjFneGErclZuMyt6c0JWSU9PRVl0dWovRWhpOXF6MFl5dVVjdnl2?=
 =?utf-8?B?QklQcUw1aTNMWURmYzNLZCs4aGZnTlNvSnhnRWhUQk5ySkNsZkZJazlBd1NC?=
 =?utf-8?B?QXRwZnVqUy93aDcyK0p2WVhGZmczbUlCM1BSVk1mS2ZhUDZBS3BNWVZpTmRn?=
 =?utf-8?B?cGVSeTkrendyamtNQndRM0xEai9uc2NMc3JCUk9YV29MQnZqaURRVWlxT0dl?=
 =?utf-8?B?Z1hZQ2hlcTVkZTU0TGNqbHRNUjBEK3MrZVlTOVE0T3ZGd2FWTHBibXluc1ZO?=
 =?utf-8?B?WW5Sd3ZGUWVmajBxWk10VDZlZEJ3cENDOFlOZVgwZXJveHlpVEgxVFFldTNE?=
 =?utf-8?B?Tnh0akJJMUpkTGNyMFFlZUZ0bEsweXAycnFKbS9scnlISnpmUGx3RlU0K0Rj?=
 =?utf-8?Q?DgHrabX470s7M1aQNPlKLOk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CCF0B439F45C845AB3828737371A5DE@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ae32f61b-ee8e-4593-4171-08dd0812c22a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 20:51:21.6084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 20CAbdYdymZ5pY5rNASOZE9LGL7BUnKjBmc3va6UYsVPZeuql03r+7A7+DX3jZraNsZL0IsuTj67t31ZXd2Vrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB5116
X-Proofpoint-ORIG-GUID: ucOMLdNYMBmr81JKv6NuhRPGLoe0k_8B
X-Proofpoint-GUID: ucOMLdNYMBmr81JKv6NuhRPGLoe0k_8B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gTm92IDE1LCAyMDI0LCBhdCAxOjA14oCvUE0sIFNvbmcgTGl1IDxzb25nbGl1YnJh
dmluZ0BtZXRhLmNvbT4gd3JvdGU6DQoNClsuLi5dDQo+IA0KPj4gDQo+PiBmc25vdGlmeV9vcGVu
X3Blcm0tPmZzbm90aWZ5LT5zZW5kX3RvX2dyb3VwLT5mYW5vdGlmeV9oYW5kbGVfZXZlbnQuDQo+
PiANCj4+IGlzIGEgcHJldHR5IGxvbmcgcGF0aCB0byBjYWxsIGJwZiBwcm9nIGFuZA0KPj4gcHJl
cGFyaW5nIGEgZ2lhbnQgJ3N0cnVjdCBmYW5vdGlmeV9mYXN0cGF0aF9ldmVudCcNCj4+IGlzIG5v
dCBnb2luZyB0byBmYXN0IGVpdGhlci4NCj4+IA0KPj4gSWYgd2Ugd2FudCB0byBhY2NlbGVyYXRl
IHRoYXQgd2l0aCBicGYgaXQgbmVlZHMgdG8gYmUgZG9uZQ0KPj4gc29vbmVyIHdpdGggbmVnbGln
aWJsZSBvdmVyaGVhZC4NCj4gDQo+IEFncmVlZC4gVGhpcyBpcyBhY3R1YWxseSBzb21ldGhpbmcg
SSBoYXZlIGJlZW4gdGhpbmtpbmcgDQo+IHNpbmNlIHRoZSBiZWdpbm5pbmcgb2YgdGhpcyB3b3Jr
OiBTaGFsbCBpdCBiZSBmYW5vdGlmeS1icGYgDQo+IG9yIGZzbm90aWZ5LWJwZi4gR2l2ZW4gd2Ug
aGF2ZSBtb3JlIG1hdGVyaWFscywgdGhpcyBpcyBhIA0KPiBnb29kIHRpbWUgdG8gaGF2ZSBicm9h
ZGVyIGRpc2N1c3Npb25zIG9uIHRoaXMuIA0KPiANCj4gQGFsbCwgcGxlYXNlIGNoaW1lIGluIHdo
ZXRoZXIgd2Ugc2hvdWxkIHJlZG8gdGhpcyBhcw0KPiBmc25vdGlmeS1icGYuIEFGQUlDVDoNCj4g
DQo+IFByb3Mgb2YgZmFub3RpZnktYnBmOiANCj4gLSBUaGVyZSBpcyBleGlzdGluZyB1c2VyIHNw
YWNlIHRoYXQgd2UgY2FuIGxldmVyYWdlL3JldXNlLg0KPiANCj4gUHJvcyBvZiBmc25vdGlmeS1i
cGY6IA0KPiAtIEZhc3RlciBmYXN0IHBhdGguIA0KPiANCj4gQW5vdGhlciBtYWpvciBwcm9zL2Nv
bnMgZGlkIEkgbWlzcz8NCg0KQWRkaW5nIG1vcmUgdGhvdWdodHMgb24gdGhpczogSSB0aGluayBp
dCBtYWtlcyBtb3JlIHNlbnNlIHRvDQpnbyB3aXRoIGZhbm90aWZ5LWJwZi4gVGhpcyBpcyBiZWNh
dXNlIG9uZSBvZiB0aGUgYmVuZWZpdHMgb2YNCmZzbm90aWZ5L2Zhbm90aWZ5IG92ZXIgTFNNIHNv
bHV0aW9ucyBpcyB0aGUgYnVpbHQtaW4gZXZlbnQNCmZpbHRlcmluZyBvZiBldmVudHMuIFdoaWxl
IHRoaXMgY2FsbCBjaGFpbiBpcyBhIGJpdCBsb25nOg0KDQpmc25vdGlmeV9vcGVuX3Blcm0tPmZz
bm90aWZ5LT5zZW5kX3RvX2dyb3VwLT5mYW5vdGlmeV9oYW5kbGVfZXZlbnQuDQoNClRoZXJlIGFy
ZSBidWlsdC1pbiBmaWx0ZXJpbmcgaW4gZnNub3RpZnkoKSBhbmQgDQpzZW5kX3RvX2dyb3VwKCks
IHNvIGxvZ2ljcyBpbiB0aGUgY2FsbCBjaGFpbiBhcmUgdXNlZnVsLiANCg0Kc3RydWN0IGZhbm90
aWZ5X2Zhc3RwYXRoX2V2ZW50IGlzIGluZGVlZCBiaWcuIEJ1dCBJIHRoaW5rDQp3ZSBuZWVkIHRv
IHBhc3MgdGhlc2UgaW5mb3JtYXRpb24gdG8gdGhlIGZhc3RwYXRoIGhhbmRsZXINCmVpdGhlciB3
YXkuIA0KDQoNCk92ZXJhbGwsIEkgdGhpbmsgY3VycmVudCBmYXN0cGF0aCBkZXNpZ24gbWFrZXMg
c2Vuc2UsIA0KdGhvdWdoIHRoZXJlIGFyZSB0aGluZ3Mgd2UgbmVlZCB0byBmaXggKGFzIEFtaXIg
YW5kIEFsZXhlaQ0KcG9pbnRlZCBvdXQpLiBQbGVhc2UgbGV0IG1lIGtub3cgY29tbWVudHMgYW5k
IHN1Z2dlc3Rpb25zDQpvbiB0aGlzLiANCg0KVGhhbmtzLA0KU29uZw0KDQo=

