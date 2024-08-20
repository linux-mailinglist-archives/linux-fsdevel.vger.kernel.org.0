Return-Path: <linux-fsdevel+bounces-26350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D96F957F81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 09:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5FF6B24CAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 07:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212C9189F2F;
	Tue, 20 Aug 2024 07:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="eSk9iHvN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A3D189909;
	Tue, 20 Aug 2024 07:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724138636; cv=fail; b=cE2Pwfc7//WVdu8j74jDPm0VxICl/UIOcn1ZZcrAl438ZsZhidy7UkG/q/JJCKaFWma8INhqcyURqRe5dGSwW5Hc2Uvr5N93CMHyxh4v+49AqWbPxGV6v5rUqXcoJ4Y7Di+PUPWtzhF/eHqIguC7fZK1a5cwDfSXfc9fKUo4+9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724138636; c=relaxed/simple;
	bh=eqGs9StVP1F8t6PWotRlSwrOwlQmjUkS5385RQgt0oM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qF2JQ3WJMSqIOuqt7uhRLgHMndCS6pJDEKOpfLc9atUALOjcR9gDlg+Ia5s7iexCf2aHyytkztpS5SYYp/IxA5GIfJezXvlYg+sNSkwDh5wWvM9/Ayeg+3pg8zovwKg+ysVnh8AIZqVrBBSq/5bOLfKsXByHrYw78mZIduysYyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=eSk9iHvN; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 47JLqAiN022103;
	Tue, 20 Aug 2024 00:23:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=s2048-2021-q4; bh=eqGs9StVP1F8t6PWotRlSwrOwlQmjUkS5385RQgt0oM
	=; b=eSk9iHvNnkVW8FjHmCoE2FzEth5szqlhGdSaUvcoo30idH2nD1VHJmaZR8m
	IC/sQlI6omfPwY6VVReD2+m7tj+OXHZZn3rurzvfMogCtZLRTLygrSCU/aA7V2fj
	2S/hsI3mFCbgGI0BG6q5HQBNbvlIhTKuX0/JieOpC/fW8x4+HZ9RXGARcEqnuKFC
	HBEjnEpNgMUZYXxmY7SwzYLKl70MLxKvassJy+Lo1Z2vtqFOA1NQxrP4rlOmA8rx
	xIj6mLP8y0g2Nh9s5CpbAawrHGE1HUpzqRmF/mULnOpKK6/jrzsnDTRMnLt+TIx4
	uGbSz00mn1806H5oJA8N+BF90PQ==
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by m0089730.ppops.net (PPS) with ESMTPS id 4148fdmn8b-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 00:23:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yux/yQsdDkx9ThZlrWl+oj/vPwl+jA0Fo9w0tjaUYjza/Db6jgtQirJ7jzE+JYey3312j7JLkhlglyHXRva3C9JfLTTEjP+KANBMzVgubJqqIuMcCRCNCjALcVoCrG3rpI3GGfhHuXkfo6Qz6qiGRECIKkOZ54AcVvI+5aXg+A43xhMrLzHzrAuEmgzoB+3ND1/PcgLH3BI2ew6g6/YHcirzMLly0c18tSGSxibtoB8Alhgna6ACFOQeCNesSTjrLWCLkF+gbBDLVmBJsCeEvTBwxxDoktcKeCR4hA5o9uCu+bbA8BlFEY1mJqx6b0NmXeSgExbKRI2VdS4y45t7sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqGs9StVP1F8t6PWotRlSwrOwlQmjUkS5385RQgt0oM=;
 b=MCpeCc4ty3jCXr00sAq6n1qlolxKwjDBZUTT6+f5M5IBPsQIIDkojlM1aXubIQFd3KFmyJ/ioh4zHMyS0xce5aPKR8KGiC2PmK8qNm7+wkcrMtmlC3Am/w0Mp7lcUQl+Xbf5AnUcSdYoUovRFSyUHcf0kX+WN0IKiJHx9LdeEQe5jWued2W0YaUNssUcj62XQ4EHfCkujCqdS39hx5SDivpImNGr3S2VKB/RLwN6SHrSWp93rER/MiNOsw3UYgikjbKowxQjfwT/md4ORn43lnyY2du1TTyrskFF7jm+LR+OKwUZCfVr0jXvvySsxGj3JxqYjRhJNCuyDHH0LDDf/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by PH7PR15MB5740.namprd15.prod.outlook.com (2603:10b6:510:269::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Tue, 20 Aug
 2024 07:23:49 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 07:23:49 +0000
From: Song Liu <songliubraving@meta.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: Song Liu <songliubraving@meta.com>,
        Christian Brauner
	<brauner@kernel.org>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux-Fsdevel
	<linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel
 Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com" <eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "jack@suse.cz" <jack@suse.cz>,
        "kpsingh@kernel.org"
	<kpsingh@kernel.org>,
        "mattbobrowski@google.com" <mattbobrowski@google.com>,
        Liam Wisehart <liamwisehart@meta.com>, Liang Tang <lltang@meta.com>,
        Shankaran Gnanashanmugam <shankaran@meta.com>,
        LSM List
	<linux-security-module@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Thread-Topic: [PATCH bpf-next 2/2] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Thread-Index:
 AQHa3u0J3x+q9TWVEkq4VV2cIBgMWrIIlswAgAAlQQCAACpzAIAAg8YAgARTMQCAIJSqAIAAQmAAgACZf4CAAKi8AIAADykA
Date: Tue, 20 Aug 2024 07:23:49 +0000
Message-ID: <B713F2F7-8BC8-47E2-B487-9207DDAD9B1F@fb.com>
References: <20240729-zollfrei-verteidigen-cf359eb36601@brauner>
 <8DFC3BD2-84DC-4A0C-A997-AA9F57771D92@fb.com>
 <20240819-keilen-urlaub-2875ef909760@brauner>
 <DB8E8B09-094E-4C32-9D3F-29C88822751A@fb.com> <20240820062922.GJ504335@ZenIV>
In-Reply-To: <20240820062922.GJ504335@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|PH7PR15MB5740:EE_
x-ms-office365-filtering-correlation-id: ca1483d5-494a-4c4a-3624-08dcc0e90947
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?azh3RDVHWFBIRDRRUC9OazZVUmQ4Yk1wRXE3dnorNTRlRmppREsyblNPNmNa?=
 =?utf-8?B?V2ZtWnllbThPNjJLTElQWWFGRGpibUJaZWhwalY3bjBTMlJpczBOV0JINTBv?=
 =?utf-8?B?ejB6UWlUTFAvNkQxWTduK0xyRjgxa1RCR2IxUE54S3Z5NDBmUkJQUWpmd1NR?=
 =?utf-8?B?YllDQi8wamtKK014UUFmb3J0ME9weC9zeWdDSWF6TnZ2V3N0S3ZtQXBSUVRH?=
 =?utf-8?B?b1NzKzEvS21LV1p3cnNiV1BqNzFZRllPS3B5WHZJTTU5SVdjbEViZVFkZ0Fu?=
 =?utf-8?B?L0FEa2lCbU9uSHptUkl0L2RMV0FCMnp4a1dMZ2JtaUIydlphZHFYZmYraGE5?=
 =?utf-8?B?RmFRbTJzZTNMRVEyck5WY0F3RUJHZTMvb2RVYURwYllzMVM0OGlubXpLRjJS?=
 =?utf-8?B?VVB5bFNGRGxleXNlek80b1o0UitlRzZpUkJLY282cWtFSjF6VGs5bmh1NEcx?=
 =?utf-8?B?ZEZ2REZkTHAxdE83cHFRREdDbDhyYWVQdzZtdGNQNHpyajBPdXB3b0FFR01J?=
 =?utf-8?B?aXRYVUt1cHZGblliNDkyaWg2ckduUE9XaWZJYlN1eTRNQWRZdXQ3WVMzK3NQ?=
 =?utf-8?B?Uk5nSmVxRmFwN2Mvd1F2UzNxc29DZG1pWUhpOUFCVW9Dc2FIcWFzd3RmZDVl?=
 =?utf-8?B?T04rbHNNUEhIRy9yQTNBRENoQXZ0VXJwcEJ6THJQbkZ4angvREF3ejU5U2xS?=
 =?utf-8?B?Ynd2TmlCQlNnM3JrMEc3S25ZZmFET2FPUTYrV0FGQk01UElEKzRTZkhES01x?=
 =?utf-8?B?bytzSFllSk9FcFczWitlcmxVdEY4eTVvTVFGd2RLVG1YSE44dEk3UHh1MWVZ?=
 =?utf-8?B?cXNDVnBGZ3B4b2RzTHhRejlmWDlFbFZBSFc1T0tPc1ByRXFFMk9MNUNTbW1P?=
 =?utf-8?B?OEh6d3N4dlVlZnkxRnFMdjFaaGdPcnJYZWlDdDRGbmx4eWloQ1ZMbE9tVkVy?=
 =?utf-8?B?SWlCd2MwL2RDYk8wWm5QSXFmUXhnYTBRSWxZWnd1d3RWdjFPUU16TzV4UE93?=
 =?utf-8?B?UWcvNElSTlE3aDRrWDN0UjQ1QUxjN1lJcDVidW9FS0FrUm44YjhHeW5DRE9Q?=
 =?utf-8?B?L0tSUkdLMkluZkpWOU85VndiK0xkcG42amUza2UrTnBxc2szaUMwNDNVWkpE?=
 =?utf-8?B?OFZDUUZaNnJlQU9tZUZYMkcwd0hkNWRObFZjWmlmOGc3WE9iaEJkMWR0SVdP?=
 =?utf-8?B?VXVnUzdPVXJiRFhDR1RkNTlMSDYxME1DV3hzZjhWOHNoN1BGYi96YlExazAy?=
 =?utf-8?B?cFRuNWJNVGltajRoL3lLRFhONUpZaFFQODhsc2llQ2lKOWhHY1NoTzV4QzA0?=
 =?utf-8?B?VzVqQ3ZzZnhGNWlqTDlJR2UzUlQ5c3NKME1TdERUTktzcWdIYmRCRXZDamlh?=
 =?utf-8?B?bWhTWHhheFhXOWxOYldEZkpSRWtmMUxnc29xQmlyODNsYjd5T3kwcEdtekRW?=
 =?utf-8?B?Yy9ubTlLLyt0VG0wT2NSSWViWm9iRDJER3gwcHdCa1lYbFVnNTQycHN4NTRt?=
 =?utf-8?B?Vy9UekxxYVc1WldiQ1EyWmFzYks3YUJ0L3BBUHBKcC94Q3F2ZzJmODZSZmQr?=
 =?utf-8?B?ZkNWdmx2WmdoWEZYYWUvT0JSQUh6MUV2NmV6Y1NZQ1V5VEpqZjFnN1dzQTlu?=
 =?utf-8?B?RkRWZjJMQ3ljVHJ4OVRIcG8vaWhBOThDajZMMTdkZjk1SGFXbEtNZ3FFem55?=
 =?utf-8?B?TnFMSlVrdzUxY1JkdU5JY3ByaklFbEZ1TTh4NlRnL3dPNWNmUGo0TVZvcTVa?=
 =?utf-8?B?RVdpTlZXcGxYQk9ma1JpR0FGd0hmbUNoL3VCcFV2S09IRHdSaXVFWGVPcVVo?=
 =?utf-8?B?aXQ4U3IxazNqWDZZSi9QZmN0ZTh0d2JJYyt6NFYraFExaFpoayt2bmNoc2Ni?=
 =?utf-8?B?ck9PZkYxRnQ5Q2orWG42NGdrTDBlbms2V3hsSExKU0ttNnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?alM3RFZBdVN3RVRlaHppQUFxWGNrZ0dPdDdOQTFoUTZBeDRTb3YxVzg4RmVF?=
 =?utf-8?B?V04wWGxYb0o1SVJjMHplalNqaHpqM0J2bU9rUnI0QXpLWVo5dFNGd2laSXk0?=
 =?utf-8?B?ZkRtVWpsVEZhQy9sRkRzTS9Pbno0NUxpcW1STUU1Z2tBZitNNW0vbUZJZFVB?=
 =?utf-8?B?elJjYS83aDVPeCtEQmMzUHBweTlQcENwWGxmWnNyd0h1YkFVcWU3bnFwcVZo?=
 =?utf-8?B?b0x5dlRHRzlja24ycVZWd2M5ZFFwbHY2MTRKZ3pvZlF5cXgrSXhJMlRYR04z?=
 =?utf-8?B?VTZjV243QTljeTJxczZiTEF3QzVEVDVldHdOdURDRHBIcG42VFQvMnJLOUhI?=
 =?utf-8?B?bFVOWXgxeHZEb1FYOGpyRWRkSGNkTnN0N3FsbU5Fc1VvS0pPOUxJVVd6R0to?=
 =?utf-8?B?NkhYdUN2R29Tcnh3akNnNEovQjczVVBzN1lFa1grbnkvMGdPQW5OQjNqVkRE?=
 =?utf-8?B?aHRMVGxmWnVOYTdKUERxZ3FwTkpaMG40ZjZkZjRTMDBFZVdZQjZsR1haMHJp?=
 =?utf-8?B?MFVKdmJtUGZlenBWanFYQzg4UWNSMkMyempPYTR0M2s1dHdrSnRyMk5qVGdT?=
 =?utf-8?B?R25SVzIvNmZyMnpMVnRFcFgyZEF4UHFIczg2OHdxbnlaN2IxSTdheDNzVHMx?=
 =?utf-8?B?MmlZOVE5SGo2Q0FQWVZya09hQUVnZU42enBpdVAzRXFObEFlK1BZdUMrZlVG?=
 =?utf-8?B?TzFobFY4SmNvQkNHMUpjdy9IdStvTWN6Zm52SXBqVWpFTHMrdVBuc3liOXJ4?=
 =?utf-8?B?WUJ1Y2E4VW5RTXE5NG51bHQxaTJvaWZEbzl4MERyRzFFK3FXeFZNazA4UmlH?=
 =?utf-8?B?YlZTbjNEcU93MUtMajloai9aV2RTNmpNV2VEeWNzZzV3T3ptSEEzNG1mOGdX?=
 =?utf-8?B?UGMwemNvK3BwTTQ0YXFOTTUxLzF3elRNTzd1MmlGeVg2dU5LUVViSmtIRVo4?=
 =?utf-8?B?alFCU1h6bjlrL25USEFiMEtWdWJFNGZlMHVDcUh5aUtqNEEwSVdlV1h2ZGt0?=
 =?utf-8?B?MDVWTkNUU3VXcmdHcnNFVFZod3pHdExKWWtjdExpaU14WVhtcVl3V0h6Sk1w?=
 =?utf-8?B?N004aUxSMzl3MGxHbUpEakorTis1LzRqMVgvdEhLYm5yN2tnaTF3czBLTmlK?=
 =?utf-8?B?dFBxZFAzbmFVWWE0U1dhWU0wTzV4KzFFUjRxUXpHUkFvQjkyWnJ0TUZOcXdj?=
 =?utf-8?B?OERReUxUTldtRUtXNzJPSFpMU2pRWFQ1UFhIRHJYZXkxMVdxbHY2dWR5Z0J1?=
 =?utf-8?B?QkRNKzdpQU96bkFtaXBIT1ArMENoSk1GVVlyaWNyRXlZdkd3dG1nK2hpc0pP?=
 =?utf-8?B?VGhQOVJ1ZGdSRWZzN0FqVGQ1aUtyNTRwemp4UWRnemVyRHJHR1dBbDF1ZjZH?=
 =?utf-8?B?Q3NuNkN1cXBlSjh3STBDNGtjYmlIZUdtQTMzMjE5ODlidW1qc0d1bHYrMVl1?=
 =?utf-8?B?MmNsbG9uNEo5alorWDRQMmc4MHRsdFRaUjRveW9CK3NTT0FqQnpNOG1BaHZ0?=
 =?utf-8?B?ZXYxQnZKamQ5d29HYVI1NmRjVkRYM0VyMnNvMXM5c2dpeHo2NzJiU1JKZ3JM?=
 =?utf-8?B?anAxR05sSGZ2ZFNzd1BwQ1ZNYWQwMmE2alRMS1hQSEpTVjgxcTA1QUppdFJY?=
 =?utf-8?B?Qlc1RHFGOFh0Yy9yRWlpTjFnUzl6T3l0bTNBeTVDZXFLSW5zcERhU0huRnht?=
 =?utf-8?B?OEd6aml5dDRVQTU0eGVwQktzdWw4SklFSlZMOTE1TFhTNHE3MTBpUkswTVNL?=
 =?utf-8?B?dmplcFRwVjE1c2NxUnhTY0VERUtEdXhuc0ExeVkrWTd0djhjMFVkVGNoU0VP?=
 =?utf-8?B?bjExcUNkeTl1YWJnUEFDakM0RTQ2aFRNSFhBbWdQbERKU2ZseGJvenUvenEy?=
 =?utf-8?B?b1lPaGc3dGZWWkJlaGt2bGloY3NEdDJhKzV0N2pBNlYreDM1M09YcTZRSnYw?=
 =?utf-8?B?Wk1rbU5NRWIwRm5xV01yK1VhOXpkTG5zRlc3d2dIdi9IWVdpb2llN0grVnB4?=
 =?utf-8?B?VEpiWVp3L0RZZHprYVA2Q2h3UXp6NDc3dnA3YTdrM0RpZ2xpY1UzSFZtR245?=
 =?utf-8?B?eGpoN1A0cGc4cWdTUS9LVjIyQUM2ZHhMLzFncHNCU2dCYkMzQXRncjRKOEVK?=
 =?utf-8?B?THAvbmwxZFR1azdhdFdxVWx1Ynp1eFlWRnhQTHpQY3F4STJTRHE2VnlFaVJR?=
 =?utf-8?B?b3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33561804541A194BBA710442994D8714@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1483d5-494a-4c4a-3624-08dcc0e90947
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 07:23:49.5062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cv9LHigi8SSYy6S40f2Oi+yQREM+FATF9+B5IkDMZoUR7RQsosOnI8Hz6i8fppyypNRwelr8KDFG/7FFEoaE5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5740
X-Proofpoint-ORIG-GUID: vnTPnBLMTWckEKsUIai6GjW69uTVr_sf
X-Proofpoint-GUID: vnTPnBLMTWckEKsUIai6GjW69uTVr_sf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01

DQoNCj4gT24gQXVnIDE5LCAyMDI0LCBhdCAxMToyOeKAr1BNLCBBbCBWaXJvIDx2aXJvQHplbml2
LmxpbnV4Lm9yZy51az4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIEF1ZyAxOSwgMjAyNCBhdCAwODoy
NTozOFBNICswMDAwLCBTb25nIExpdSB3cm90ZToNCj4gDQo+PiBpbnQgYnBmX2dldF9wYXJlbnRf
cGF0aChzdHJ1Y3QgcGF0aCAqcCkgew0KPj4gYWdhaW46DQo+PiAgICBpZiAocC0+ZGVudHJ5ID09
IHAtPm1udC5tbnRfcm9vdCkgew0KPj4gICAgICAgIGZvbGxvd191cChwKTsNCj4+ICAgICAgICBn
b3RvIGFnYWluOw0KPj4gICAgfQ0KPj4gICAgaWYgKHVubGlrZWx5KElTX1JPT1QocC0+ZGVudHJ5
KSkpIHsNCj4+ICAgICAgICByZXR1cm4gUEFSRU5UX1dBTEtfRE9ORTsgIA0KPj4gICAgfQ0KPj4g
ICAgcGFyZW50X2RlbnRyeSA9IGRnZXRfcGFyZW50KHAtPmRlbnRyeSk7DQo+PiAgICBkcHV0KHAt
PmRlbnRyeSk7DQo+PiAgICBwLT5kZW50cnkgPSBwYXJlbnRfZGVudHJ5Ow0KPj4gICAgcmV0dXJu
IFBBUkVOVF9XQUxLX05FWFQ7IA0KPj4gfQ0KPj4gDQo+PiBUaGlzIHdpbGwgaGFuZGxlIHRoZSBt
b3VudC4gSG93ZXZlciwgd2UgY2Fubm90IGd1YXJhbnRlZSBkZW55LWJ5LWRlZmF1bHQNCj4+IHBv
bGljaWVzIGxpa2UgTGFuZExvY2sgZG9lcywgYmVjYXVzZSB0aGlzIGlzIGp1c3QgYSBidWlsZGlu
ZyBibG9jayBvZiANCj4+IHNvbWUgc2VjdXJpdHkgcG9saWNpZXMuDQo+IA0KPiBZb3UgZG8gcmVh
bGl6ZSB0aGF0IGFib3ZlIGlzIHJhY3kgYXMgaGVsbCwgcmlnaHQ/DQo+IA0KPiBGaWxlc3lzdGVt
IG9iamVjdHMgZG8gZ2V0IG1vdmVkIGFyb3VuZC4gIFlvdSBjYW4sIHRoZW9yZXRpY2FsbHksIHBs
YXkgd2l0aA0KPiByZW5hbWVfbG9jaywgYnV0IHRoYXQgaXMgaGlnaGx5IGFudGlzb2NpYWwuDQoN
CkkgZG8gdW5kZXJzdGFuZCBmaWxlc3lzdGVtIG9iamVjdHMgbWF5IGdldCBtb3ZlZCBhcm91bmQu
IEhvd2V2ZXIsIEkgYW0gbm90DQpzdXJlIHdoZXRoZXIgd2UgaGF2ZSB0byBhdm9pZCBhbGwgdGhl
IHJhY2UgY29uZGl0aW9ucyAoYW5kIHdoZXRoZXIgaXQgaXMNCnJlYWxseSBwb3NzaWJsZSB0byBh
dm9pZCBhbGwgcmFjZSBjb25kaXRpb25zKS4gDQoNCj4gV2hhdCdzIG1vcmUsIF9tb3VudHNfIGNh
biBnZXQgbW92ZWQgYXJvdW5kLiAgVGhhdCBpcyB0byBzYXksIHRoZXJlIGlzIG5vDQo+IHN1Y2gg
dGhpbmcgYXMgc3RhYmxlIGNhbm9uaWNhbCBwYXRobmFtZSBvZiBhIGZpbGUuDQoNCk1heWJlIEkg
c2hvdWxkIHJlYWxseSBzdGVwIGJhY2sgYW5kIGFzayBmb3IgaGlnaCBsZXZlbCBzdWdnZXN0aW9u
cy4gDQoNCldlIGFyZSBob3BpbmcgdG8gdGFnIGFsbCBmaWxlcyBpbiBhIGRpcmVjdG9yeSB3aXRo
IHhhdHRyIChvciBzb21ldGhpbmcNCmVsc2UpIG9uIHRoZSBkaXJlY3RvcnkuIEZvciBleGFtcGxl
LCBhIHhhdHRyICJEb19ub3RfcmVuYW1lIiBvbiAvdXNyIA0Kc2hvdWxkIGJsb2NrIHJlbmFtZSBv
ZiBhbGwgZmlsZXMgaW5zaWRlIC91c3IuIA0KDQpPdXIgb3JpZ2luYWwgaWRlYSBpcyB0byBzdGFy
dCBmcm9tIHNlY3VyaXR5X2ZpbGVfb3BlbigpIGhvb2ssIGFuZCB3YWxrIA0KdXAgdGhlIHRyZWUg
KC91c3IvYmluL2djYyA9PiAvdXNyL2JpbiA9PiAvdXNyKS4gSG93ZXZlciwgdGhpcyBhcHBlYXJz
DQp0byBiZSB3YXN0ZWZ1bCBhbmQgdW5yZWxpYWJsZSwgYW5kIENocmlzdGlhbiBzdWdnZXN0ZWQg
d2Ugc2hvdWxkIHVzZSBhIA0KY29tYmluYXRpb24gb2Ygc2VjdXJpdHlfaW5vZGVfcGVybWlzc2lv
biBhbmQgc2VjdXJpdHlfZmlsZV9vcGVuLiBJIA0KdHJpZWQgdG8gYnVpbGQgc29tZXRoaW5nIG9u
IHRoaXMgZGlyZWN0aW9uLCBhbmQgaGl0cyBhIGZldyBpc3N1ZXM6DQoNCjEuIEdldHRpbmcgeGF0
dHIgZnJvbSBzZWN1cml0eV9pbm9kZV9wZXJtaXNzaW9uKCkgaXMgbm90IGVhc3kuIFNvbWUNCiAg
IEZTIHJlcXVpcmVzIGRlbnRyeSB0byBnZXQgeGF0dHIuIA0KMi4gRmluZGluZyBwYXJlbnQgZnJv
bSBzZWN1cml0eV9pbm9kZV9wZXJtaXNzaW9uKCkgaXMgYWxzbyB0cmlja3kuDQogICAobWF5YmUg
YXMgdHJpY2sgYXMgZG9pbmcgZGdldF9wYXJlbnQoKSBmcm9tIHNlY3VyaXR5X2ZpbGVfb3Blbj8p
DQogICBXZSBuZWVkIHRhZyBvbiAvdXNyIHRvIHdvcmsgb24gL3Vzci9iaW4uIEJ1dCBob3cgZG8g
d2Uga25vdyAvdXNyDQogICBpcyAvdXNyL2JpbidzIHBhcmVudD8NCg0KRm9yIHRoZSBvcmlnaW5h
bCBnb2Fs4oCmIHRhZyBhbGwgZmlsZXMgaW4gYSBkaXJlY3Rvcnkgd2l0aCB4YXR0ciBvbiANCnRo
ZSBkaXJlY3RvcnksIGlzIGl0IHBvc3NpYmxlIGF0IGFsbD8gSWYgbm90LCB3ZSB3aWxsIGdvIGJh
Y2sgYW5kDQppbXBsZW1lbnQgc29tZXRoaW5nIHRvIHRhZyBhbGwgdGhlIGZpbGVzIG9uZSBhdCBh
IHRpbWUuIElmIGl0IGlzDQppbmRlZWQgcG9zc2libGUsIHdoYXQncyB0aGUgcmlnaHQgd2F5IHRv
IGRvIGl0LCBhbmQgd2hhdCBhcmUgdGhlDQpyYWNlIGNvbmRpdGlvbnMgd2UgbmVlZCB0byBhdm9p
ZCBhbmQgdG8gYWNjZXB0Pw0KDQpDb21tZW50cyBhbmQgc3VnZ2VzdGlvbnMgYXJlIGhpZ2hseSBh
cHByZWNpYXRlZC4gDQoNClRoYW5rcywNClNvbmcNCg0KDQo=

