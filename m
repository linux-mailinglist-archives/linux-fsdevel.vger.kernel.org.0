Return-Path: <linux-fsdevel+bounces-24573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877EC9407F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3F34B21B50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9907C16B75F;
	Tue, 30 Jul 2024 05:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="REXA2KrF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA17624;
	Tue, 30 Jul 2024 05:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722319118; cv=fail; b=F6wWq97DHiMq2PCKxzxnC5cPrMbLlqXJt0vu46pE6zQ53w2jRXWRmdSuWUhmTU5OtSEoSAZrkoTCMeRFjfO+N9HIVI9+q8sJVEaE5x79BqsHgzGH+1BzOzbMsKYrPP6L7bQXsPU08NEnAxVW76dyQosBIWJ4mkMddxneHq3h/iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722319118; c=relaxed/simple;
	bh=oqAmGQG39kJgCHbYxPfcsxfsHcjYp8UP3DKipZRTSlY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f4yAb7UDus32vpbhpI/9oN/LDf1LDGISuSSWC/0E92g4JiFM/04j6YNSeOPBeoujLQcjxM1ivPrwh6PV6kduHRVvdeUrzPKhGxLBFQGqMNEr9oapKEvFLd1zc968qylkVyMamiL9RRcaKP/uTFNXhtPlpE2tfWfFqYU1HV+Z1bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=REXA2KrF; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 46U0IvfD016363;
	Mon, 29 Jul 2024 22:58:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=s2048-2021-q4; bh=oqAmGQG39kJgCHbYxPfcsxfsHcjYp8UP3DKipZRTSlY
	=; b=REXA2KrFatpNGMNbzIj9IR4AqrnUchTQcppUzcheHTP/TlIICKiDSS82nAN
	OeTjniJVvnCZ6eExZ/MxEUZhRBI8MwiiMG21rh65UsqKWT/B0XFzhjCtT+ttW8me
	PgV//pawN+tqokUkHGJxz+MznnQpUkTnSFtgOuWvVv3PcRjZFH7XsGl83qwqFvYo
	ntaMsr4xFScuQaM4Bb9ggLc0T4mFWE7kgUJm/HSkV2IxLlVPapMJwoU/3HgV7Ua8
	swePRknp9YzDTrGVHRrhTTVEjzrxrZYe1HIZ1OWU5UQMEKPHVq7n2Ae1JmQZsLGw
	OoeJ9Lkxf2xmsu61yKeoyjWYwvA==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by m0001303.ppops.net (PPS) with ESMTPS id 40pnh81c4n-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 22:58:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lEKk4ajxOZSZHBQiEbhslsLx8HZdcrq7+jOaFwyyA48ESMlrMU8Iixg7Ai8qPLujFb4rhngFhO2KIyYVF1xjF7qRfVn4FEVkBesJ4jnIszsXiKveL2deDDNJp6NQ/x09grh03c36SGEWGqMIUor7tA29oETEWNXAQt9uEI86kF3NqwBATFVHiLsCc1/lDrKQIUk3UzGUa5mXdXH0jV0m5pKG1PizN7JqRraSFMdS+dzWrEZrIAm97IgLMFbYZT3NhCewOdw63VFTUJmBIaQ+qs2G79otVKlZjZUUwQoFLeP+S5kiwQYJQURIN9DMq8EoRxi97AlyFbyEMLmvtKE8+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqAmGQG39kJgCHbYxPfcsxfsHcjYp8UP3DKipZRTSlY=;
 b=VxDRwjiYTtBBcmbgGbCxJaA9jlvBExjmRLk15UCWrE+RE17dQnuHHqUvmKmeDZ0BVrgEE7BdMeO48qT5kyt7GGd1PrXUL3Ld1cjT9bws2pcSh1/+vctLKK6KjFnHKtg6rBcAbq7yzm/lwMJ74sWvVQXNFZNJ1bRTjWuVuFhO9j7/MotxBbPqdsCeYh4PC3pJUS/n/2D7nCx6TiB7zM5mqhC2M/yNAT8ubPB5L5wEwZwTuN1KR3llCV72/EfMQgXhX94BEwRycCu1mY/K7wpcchOPMP9QaNODKeC1kooq1YdcQH3L6MZJQ8qkC9EJ2l3Tk+OCUjx8TUszKWb4nuwpXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB4513.namprd15.prod.outlook.com (2603:10b6:806:198::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 05:58:31 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.7828.016; Tue, 30 Jul 2024
 05:58:31 +0000
From: Song Liu <songliubraving@meta.com>
To: Christian Brauner <brauner@kernel.org>
CC: Song Liu <songliubraving@meta.com>, Song Liu <song@kernel.org>,
        bpf
	<bpf@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com"
	<eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com" <mattbobrowski@google.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Thread-Topic: [PATCH bpf-next 2/2] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Thread-Index:
 AQHa3u0J3x+q9TWVEkq4VV2cIBgMWrIIlswAgAAlQQCAACpzAIAAg8YAgARTMQCAAQ+kAA==
Date: Tue, 30 Jul 2024 05:58:31 +0000
Message-ID: <2FE83412-65A5-451B-8722-E0B8035BFD30@fb.com>
References: <20240729-zollfrei-verteidigen-cf359eb36601@brauner>
In-Reply-To: <20240729-zollfrei-verteidigen-cf359eb36601@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SA1PR15MB4513:EE_
x-ms-office365-filtering-correlation-id: 16e2a4af-17df-431b-7c0d-08dcb05ca3ea
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SnVwV3pIdW1YV3BaelpseFdqTC9HOHFQN1RXb3JVMkE4U3E3TU5iVjV5bG0x?=
 =?utf-8?B?VUNvcitWOHJqbTVwRzJiVTF6SFZhaExZQ3QvcElvZ0plZ3BTVVdwb0tNTWlZ?=
 =?utf-8?B?YUs1bU1mSndOMzZNOFVkWmVCK1VCbXdudCtsQ0M3cGRzN2MzdmR2OUUvTEI5?=
 =?utf-8?B?Qy9PZ2FRS3RaZkJTTWpObGFod0FWR285S0g5MnBpVkIwd3ErSi9ZK1dSN2xM?=
 =?utf-8?B?ZjRSS21rMGx3QjNueE5EaU84T2IyQWV6QXNJKzhTRTJEanI1TTlCK3RVTW9J?=
 =?utf-8?B?ZSswaERINEVyYkQvM2JzY21oWG0yQ0tyLzhZVm1FM1I5RVBKZVE0b3phTUI2?=
 =?utf-8?B?c3NFeFhrMzhmQjVWUE01bnVzdldwN1dvcFR4b3RidDdtUTRjSHBUYkMxRko0?=
 =?utf-8?B?RmQ0cWJadmFSaVZKME92VU5VQzZqdVVPYTVQUWxjNmpyUDNMNGJRc1ZXc0VK?=
 =?utf-8?B?aHg5SFRIZm1aNkZ5RVdOa2tMQmJra1hUU2NrbWlLbjM2bjlEQURQdXR6QkRJ?=
 =?utf-8?B?aVZmWFFtUlljQ2trOGZiN29McXZPWjQycHA4eFloV0xVRDVuYVBOVk5xc1o2?=
 =?utf-8?B?TkxacTY0VjdtVERmdTFYTWpHRkt2TFR6Y1JoVFA1NEhRRGo0dDEwRG02WEMv?=
 =?utf-8?B?YTJuVno2MU1lb0N4dkxQVm15NmRObjNib3N0aDI5YThMWDFwcTc1OWtRalRN?=
 =?utf-8?B?WTYydnorSUc1TXZqeTR4QkM2bEpOeDVwMUptQTFSM2ErZkgyWThxN0tzVm1S?=
 =?utf-8?B?R3BBN1lnVnhyUGtVYWdoeW42czhaVGE5S0dnelNNd3IrYmVzWURhL0Y3U0FJ?=
 =?utf-8?B?L3lKTXo4QUJpakVlRlNvK3hERXIyQVhpWjg4d1VLRk91VnRDSC9kdmF6MmpQ?=
 =?utf-8?B?SGwvSENQYytyM0RkajBmY1NLQ2EwQVljYTBjNmU2bC9OSFdHNjl5UkVFeWUy?=
 =?utf-8?B?S1FuUHJFMzF0VGNFT1F2d0p1MnF6d1pMNWE5aksxVWRGVk11Y215UHVTak5p?=
 =?utf-8?B?QWFkdTJYMjBzd3BKNytIeFE1ZHgzZGdCdU9qMG8rQW5SYXphTE1YNm14eWhH?=
 =?utf-8?B?N2VPUks5WksydkFqN2FESTRpbTlkbUJveERYczBoMGJyTGVzK2pCUmFlRkts?=
 =?utf-8?B?U1I4aGpBK01yMHhobHUyMDhLbXphb0d2NDdpYkZ0SDRMUm5CYWYybG1HMFNi?=
 =?utf-8?B?RHgyRHh1bGF3NmNMUzM2NUFJNjJhQU1maENmM3BrTXdNajR5WVEwcmZqNlZj?=
 =?utf-8?B?bXRZc3h2L2tFdmlmeU9BaHNHUjByV1Y2d1RiczdXTlJESGllUk5hbFU5cjZs?=
 =?utf-8?B?MWU4RmI4RG5zNGE0a0MydFhoTUxtTlpFUUhIYVpYK3p0M0d2TVN3NTA5N1Ft?=
 =?utf-8?B?OVFZY3dCUXJYUnlqczY4RGVNTjJieHRibTRjeEFsUEF2TlZiTkt0QWh6emdu?=
 =?utf-8?B?SzQ1NmQ5alBjWUlxaGg4bXZmMldNbVNmNVZmS3E4NXlNTFVmMVFTdUFDN2VN?=
 =?utf-8?B?Q3RQWElHV1VaRUZEV1VqVmpFQW0weHA1RjNua2Nkcy90SjNHbE1KOG0rZmVj?=
 =?utf-8?B?d2pidXN1Qy9tRHV4VkJFRklmMlVVMmZPQnVBbTdFNzJ4R3g5NWY0NlVpWDVW?=
 =?utf-8?B?S20waUJNMnN3eTd3SjVmczV6MUVtazM5aXIxVXNUZzA4VlJQbXhSMkY1Qmsw?=
 =?utf-8?B?WDVPUmoyRHNBQXNvTHFlQTlRaXY3QkNQdUF2NU12KzFyaktod3ZpZVpLYUVI?=
 =?utf-8?B?Z29raE1CSmdRMXFnVTg2a2I1VmZwZ0t5a2lyczdJQUxueE9MMElnbkc4Umty?=
 =?utf-8?B?UlVZVHhkc28yRWE3OU5ac2J6b0hLWjE0c1FnNUZUeXZxeGlOZEMyRFduN1Vv?=
 =?utf-8?B?QjlGeW90bGFYdUlCaEZ3NWh3Y2FpWGNUMVlEL0RhWkdnL0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDIvOGtnN0RSOGlGeDNkTXFDZnlkSDNrNzBPZG5YSFdEQkI5dldVb2UyMkpH?=
 =?utf-8?B?WkZSL05lWjd3TUYrMkhDVkJNcUFkaGV5S21sOGtPS3Z6WS85OUhWdUgra3pJ?=
 =?utf-8?B?UERmeWdZdGZzbnhnWm5laEMyU0dVdS9mekh0Ym9URW5meiszQlRqNjc5VUla?=
 =?utf-8?B?TWlEbGFEV2drSlVBRkJoSmsvdkU1MnVua3NSRUVJclAzZ3dXWWV1NGZWa1dt?=
 =?utf-8?B?R1owNWxUZXhJVFpHWStYeFN2Zk5qbW82MkZuV3VkT2UvNXNJYlZQbGJUeWNE?=
 =?utf-8?B?NUlyc1NvT2ZjaTMvL09WdDdHdFQ3dnkzVGpPWVBraFR2Q2VpUHA4bEh4Ni8y?=
 =?utf-8?B?U0F3VCsza2dwM2Zubyt3Q2lSZ3JnMlpFY0R2elVadlFWRlZuamZmc0ZTZkxX?=
 =?utf-8?B?S3E0emVqK25KRjZVMnpXQ3hWQmpVRVY2TzArVmszSnpLVHJwVHZ4eGFWdmRZ?=
 =?utf-8?B?Y2FUVkdaQ3VBeU5lcG1oLytyS21pcmFibFJROCtvSWVuY3VPVVFLNkdpbFFB?=
 =?utf-8?B?Rk9NaEovSEZDUldmVmxhRVU2N1FpcmZobkZad2hTLzFKVEtCdWpPVjdjd1kz?=
 =?utf-8?B?VWZGOWdRekFGeWI3ajdlVXg2cnY4MGlJUjFhRWgxcG9BMjdueFNnNlJhaU1E?=
 =?utf-8?B?K21QZzhaZ3VmZXFaN2V4OXdwSnB4VGtSQ1BhL0ZpcUE1M1JENno3MFpDQjJn?=
 =?utf-8?B?ZXN0MnZ2b1VnZ2o5N016NFB5YTZ6NEVhTGhpN0E5dEFIdWxEYk50RG1Dc3pz?=
 =?utf-8?B?NlRWUm5KMnpMbHVzOHI1RGdxbXVleGROOEtOVlh0bDZnWmVVU09oVVRYaEgy?=
 =?utf-8?B?Skt5QU9hTjZSOEdKR3l1ZGZtakpNWlRVZFdCbnFWTEhGZmVxT0RFS21UeGl0?=
 =?utf-8?B?T3RLOTdJVWZNMENlTm42RU40dUJFbVYvZDQ0VS9QWEpYMTc1UmE3c2t5T08z?=
 =?utf-8?B?VW10VzZPK1A0VHZ4RXVIZS9ST1NuM2JiSlNwODJUU0NqTEl5OGFuVzlTMXEw?=
 =?utf-8?B?eFVJczg1U3VnT1g1RGkxSm0rVjgxRGQ1UTF2T2huQlczZS9YWW5odDI4VnFX?=
 =?utf-8?B?M0t2WDlZZlJNbG9uS2JWcXdiU2Q2ZkIvYVdyQURRUEZtZFZ0TkZaVnlVK2ZT?=
 =?utf-8?B?Z2ZOR1VaMkhvWEI5ZGFxU0t3dkFOcFlJTS9jRDBOVzhyb056bzRZOXJFM2l2?=
 =?utf-8?B?aUNLbFh6WGFCVHhOSHFzaUxXVkpUOWhWcDlqWkVYS1lXeHZLMHA2dTk5cnZl?=
 =?utf-8?B?RVlycUZJelcvWklxK0c0c1VqZmt2dll6RnQwaVZhZTlvUkZoaVVvTHNXcmF4?=
 =?utf-8?B?K3lQaUJKaTl2aTI4b2s1aUk3SjF2U3AzVTlQU1FNUUdPWkhlazRDRFZDSFha?=
 =?utf-8?B?a3FaM1dxU1JvUjM4b3RQVTVBVzJvTkVESkE1MW5nM3kxZjdEN2p1S0psZFgx?=
 =?utf-8?B?VTNKNnZML3h5cCtCNjdaS05sTXk3NjBjaVkrdUtpYU9FeW1haFE4U240d0VN?=
 =?utf-8?B?YkZYSTBycVYvZjgzWGtZeDh3NFk3VGxyOWNrTDRSNmtSbzFLVnpDRHhpS1Z4?=
 =?utf-8?B?NzJLZWFGb0N3NityV2ZlOU03NVlNODhQMGF6VEc5MS9tcHplZWdaUVo0azRK?=
 =?utf-8?B?VmkweGNhZEJqemg5VHhpY3JwMjQzSDFaT0wrTUJMdnM3RHNFRG42NWpZbmxp?=
 =?utf-8?B?dTlTaFN1WTZweXI2QndyalhwS0ZqdzZkSEtTUWQrYnpLSCtpN0k0azFLV2la?=
 =?utf-8?B?VlhvVmVYS3ZvVE5jTFR3NGhqMStsOFJBSGdXN2d1b0xiSjY4YVhOaUEzZ0lE?=
 =?utf-8?B?UzNlMXNsZ25sZHRrT1ZRSlN5RitMYjkzYWtHand6RGNDbjRpNWVNWENrdjJU?=
 =?utf-8?B?SUxNWEY3UlBOZDdzYnhqZHR0cjE4R0RBU1R3TENIR0FiSS9qOTFMZ2U4Mkg4?=
 =?utf-8?B?Z1ljZVZBdEdLeGRaNlR2UmEvWW5wM09EMGpOYUNZQkkwOGxQUWlrNjJoV1Q0?=
 =?utf-8?B?NGx4ZHVidDlyVzluYk9yQTJpRmZROGRzRnRYWkFVdlZkOXJwM1NmTWpsR3dy?=
 =?utf-8?B?aGY2K1FvV1crbElremlYT2FaN0tnZXBFb2xhM1F1c0RwYjRhY0JUcEN6cE9s?=
 =?utf-8?B?M1lNSHJzUjJTeFNMRTlPYjZSYUFHTUhnSjhKMzBJK04vYVVPMkxHT2poMXR3?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CF246CBFE9A1F499AD79D0572C1257B@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e2a4af-17df-431b-7c0d-08dcb05ca3ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 05:58:31.3120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QSpf1soHFYtuE9D96LPHfg6liFoH1vxPCD8M/mktckGhCdLvBj2VtimO+jsvFlyIqqyK8SKvJc6BRCq2k1ntaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4513
X-Proofpoint-GUID: kOw-_OiOYWK6lZHV1AhJhTMLDYLrOp6U
X-Proofpoint-ORIG-GUID: kOw-_OiOYWK6lZHV1AhJhTMLDYLrOp6U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_06,2024-07-26_01,2024-05-17_01

SGkgQ2hyaXN0aWFuLCANCg0KVGhhbmtzIGEgbG90IGZvciB5b3VyIGRldGFpbGVkIGV4cGxhbmF0
aW9uISBXZSB3aWxsIHJldmlzaXQgdGhlIGRlc2lnbiANCmJhc2VkIG9uIHRoZXNlIGNvbW1lbnRz
IGFuZCBzdWdnZXN0aW9ucy4gDQoNCk9uZSBtb3JlIHF1ZXN0aW9uIGFib3V0IGEgcG90ZW50aWFs
IG5ldyBrZnVuYyBicGZfZ2V0X2lub2RlX3hhdHRyKCk6IA0KU2hvdWxkIGl0IHRha2UgZGVudHJ5
IGFzIGlucHV0PyBJT1csIHNob3VsZCBpdCBsb29rIGxpa2U6DQoNCl9fYnBmX2tmdW5jIGludCBi
cGZfZ2V0X2lub2RlX3hhdHRyKHN0cnVjdCBkZW50cnkgKmRlbnRyeSwgY29uc3QgY2hhciAqbmFt
ZV9fc3RyLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGJwZl9k
eW5wdHIgKnZhbHVlX3ApDQp7DQogICAgICAgIHN0cnVjdCBicGZfZHlucHRyX2tlcm4gKnZhbHVl
X3B0ciA9IChzdHJ1Y3QgYnBmX2R5bnB0cl9rZXJuICopdmFsdWVfcDsNCiAgICAgICAgdTMyIHZh
bHVlX2xlbjsNCiAgICAgICAgdm9pZCAqdmFsdWU7DQogICAgICAgIGludCByZXQ7DQoNCiAgICAg
ICAgaWYgKHN0cm5jbXAobmFtZV9fc3RyLCBYQVRUUl9VU0VSX1BSRUZJWCwgWEFUVFJfVVNFUl9Q
UkVGSVhfTEVOKSkNCiAgICAgICAgICAgICAgICByZXR1cm4gLUVQRVJNOw0KDQogICAgICAgIHZh
bHVlX2xlbiA9IF9fYnBmX2R5bnB0cl9zaXplKHZhbHVlX3B0cik7DQogICAgICAgIHZhbHVlID0g
X19icGZfZHlucHRyX2RhdGFfcncodmFsdWVfcHRyLCB2YWx1ZV9sZW4pOw0KICAgICAgICBpZiAo
IXZhbHVlKQ0KICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KDQogICAgICAgIHJldCA9
IGlub2RlX3Blcm1pc3Npb24oJm5vcF9tbnRfaWRtYXAsIGRlbnRyeS0+ZF9pbm9kZSwgTUFZX1JF
QUQpOw0KICAgICAgICBpZiAocmV0KQ0KICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQogICAg
ICAgIHJldHVybiBfX3Zmc19nZXR4YXR0cihkZW50cnksIGRlbnRyeS0+ZF9pbm9kZSwgbmFtZV9f
c3RyLCB2YWx1ZSwgdmFsdWVfbGVuKTsNCn0NCg0KDQpJIGFtIGFza2luZyBiZWNhdXNlIG1hbnkg
c2VjdXJpdHlfaW5vZGVfKiBob29rcyBhY3R1YWxseSB0YWtpbmcgZGVudHJ5IGFzIA0KYXJndW1l
bnQuIFNvIGl0IG1ha2VzIHNlbnNlIHRvIHVzZSBkZW50cnkgZm9yIGtmdW5jcy4gTWF5YmUgd2Ug
c2hvdWxkDQpjYWxsIGl0IGJwZl9nZXRfZGVudHJ5X3hhdHRyLCB3aGljaCBpcyBhY3R1YWxseSB0
aGUgc2FtZSBrZnVuYyBpbiB0aGlzDQpzZXQgKDEvMik/DQoNClRoYW5rcywNClNvbmcNCg0KDQoN
Cj4gT24gSnVsIDI5LCAyMDI0LCBhdCA2OjQ24oCvQU0sIENocmlzdGlhbiBCcmF1bmVyIDxicmF1
bmVyQGtlcm5lbC5vcmc+IHdyb3RlOg0KWy4uLl0NCj4+PiBJbWhvLCB3aGF0IHlvdSdyZSBkb2lu
ZyBiZWxvbmdzIGludG8gaW5vZGVfcGVybWlzc2lvbigpIG5vdCBpbnRvDQo+Pj4gc2VjdXJpdHlf
ZmlsZV9vcGVuKCkuIFRoYXQncyBhbHJlYWR5IHRvbyBsYXRlIGFuZCBpdCdzIHNvbWV3aGF0IGNs
ZWFyDQo+Pj4gZnJvbSB0aGUgZXhhbXBsZSB5b3UncmUgdXNpbmcgdGhhdCB5b3UncmUgZXNzZW50
aWFsbHkgZG9pbmcgcGVybWlzc2lvbg0KPj4+IGNoZWNraW5nIGR1cmluZyBwYXRoIGxvb2t1cC4N
Cj4+IA0KPj4gSSBhbSBub3Qgc3VyZSBJIGZvbGxvdyB0aGUgc3VnZ2VzdGlvbiB0byBpbXBsZW1l
bnQgdGhpcyB3aXRoIA0KPj4gc2VjdXJpdHlfaW5vZGVfcGVybWlzc2lvbigpPyBDb3VsZCB5b3Ug
cGxlYXNlIHNoYXJlIG1vcmUgZGV0YWlscyBhYm91dA0KPj4gdGhpcyBpZGVhPw0KDQpbLi4uXQ0K
DQo=

