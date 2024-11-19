Return-Path: <linux-fsdevel+bounces-35179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E399D21A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 09:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B7F1F22A57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 08:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A795198E6D;
	Tue, 19 Nov 2024 08:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="aawBY7dj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AE61531DB;
	Tue, 19 Nov 2024 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732005355; cv=fail; b=VjvqwmZzH/DTo9uv5c0DMBgmpFrHIy+30b/pcu6Fea0yYF7Uv9GGcvjcEx3AxmVNO2DwtLucH7OEjgxYUn7EwL8g/IfxRHKZV5ED4mwgyL3sLCXMdHkC3fLjfCWvL0XFkdQqYZ1ilQlEE4JjQ8wcwbywV+JKFOyegsOk3pL4fnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732005355; c=relaxed/simple;
	bh=lxvEQ2beannIOxgRkZsbpKtG4Fh3tY874boIPc7S0oM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PDwWdP+KXgOvEIXopNQKr/hExzne2Hxs/MSeSWsH95PKA9sPgUGGIeeURs4Lq8FcJmjzFsc7nBnjPaz9q4a2b0QDxVakQBKvGkJ0jJwOfcHXmI7nD7kO4m0UTccDOrT1S/cnOMKnXSrRDEOufoD+9hBUCkGYHa881Cou1omhGcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=aawBY7dj; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4AJ8HY5u001037;
	Tue, 19 Nov 2024 00:35:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=lxvEQ2beannIOxgRkZsbpKtG4Fh3tY874boIPc7S0oM=; b=
	aawBY7djueIcKj+D27BLBAp5tggG8ACt2SfUxNBZK0Ic7xXQKBmxDMJvsObEHFK+
	e7ukA2nPLVVxKdV5ZMP+Y+iDQ0MQFY/mvOGzA42uHa20oJVxVKVC6lLjnnO5Wzus
	eq/dxnnIj/NVEgyNbTF1EV0StEbywffgMetrHK8n32km4LbMecfkme/0eYXwK6Hf
	7vi6W6ULJFaUdrxqggGwfHP2gjCGX2u/YQY8FvUO9ROIUlV5X7WIl6uR5CE2tWo+
	HXMf1E1OQQcsvKBgcKV0UYYovAFH4wHnDJwYcKbb3XWO4ZUCXN3B/Byn0b7jVLHH
	UAnTBpD+ZL9TOeZLmr4kRA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by m0089730.ppops.net (PPS) with ESMTPS id 430q1h824v-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 00:35:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJ4Hc8gd3anTLzhkpKFcOnDPfV29FHosIIg2VSs7JIXsrob120Dp84ZGAhDAnftGhTi3oqOqNPlxwVwd7RRHjCoLj3kRpg/3nOA5OiaQrFP8MNjEGc0SLzvyM+Wl09uayGyeyhP+D5bfskGacY9EuuQdqDbEFQegaPjZ4Tw5QKiKs+Bw3V6/PvXwkiIBUiIMfDZIQlEIQoASgWTQSH1U7ic8auzIyF8rri95z/33eWh1mvr712+cLy9ItlkFIbrQcxGUuC9t1GUABu7f+DaPCzQz7XmzJYxBwetUsKyzQ1kiI+U6DXt1gd4934Tp0DlZjBoXymPh5pcxzAlQno6kfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxvEQ2beannIOxgRkZsbpKtG4Fh3tY874boIPc7S0oM=;
 b=GmMg94Ha4QsPuW1Oe9bzcT7RVRw7SPEJlbidE/n2aos94OF693MIO8HrWMcz8eHmES9P+AUMBbuVLVht2+XA1XuSX/y9tDw8RVAtEFohcaQRmBm6SPacDH1GTiQEO2XW3uGajTtc2EHu8CCNi73iIhqN26MpVRHJJag5pAUiGDMs8kF1Pzk+6YWB92ePBzUrAyKp9+KFG1dX7/YsrbTIPDl03sPHCybWY3OoW06jA4tpV6OA6VSquQsfF7BtB1+21IahgnK/4XwnVyqwlzLSftaPiD7qJu9ewKsaK4JRYQTea7btf6sKVntvmMDAyUQqRcE/ED3jLMt1fORkGfJFVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by LV3PR15MB6659.namprd15.prod.outlook.com (2603:10b6:408:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 08:35:48 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 08:35:48 +0000
From: Song Liu <songliubraving@meta.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: Song Liu <songliubraving@meta.com>,
        Alexei Starovoitov
	<alexei.starovoitov@gmail.com>,
        Song Liu <song@kernel.org>, bpf
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
 AQHbNnGAryo3J6mFf0ePhnT/vr0UcrK3NqIAgAAvFgCAABuhgIAACBOAgAAGAICAAFv2AIAA1H4AgAAXZQCABLMTAIAAN70AgAAQh4CAAHJtAIAACheA
Date: Tue, 19 Nov 2024 08:35:47 +0000
Message-ID: <CFCDD4D9-4CD5-42E1-A741-6CD96E13FFCA@fb.com>
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
 <B3CE1128-B988-46FE-AC3B-C024C8C987CA@fb.com>
 <CAADnVQJtW=WBOmxXjfL2sWsHafHJjYh4NCWXT5Gnxk99AqBfBw@mail.gmail.com>
 <C777E3FC-B3D4-4373-BE9E-52988728BD5E@fb.com>
 <CAOQ4uxga-iZtL+OsocdxwSyBqNKnGsgnq+OQ56Lm4neQ8kP82A@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxga-iZtL+OsocdxwSyBqNKnGsgnq+OQ56Lm4neQ8kP82A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|LV3PR15MB6659:EE_
x-ms-office365-filtering-correlation-id: 041d272a-4a0a-4cf3-9ba4-08dd08752ad9
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b3hKZ0tBZ0ovSno4T0xTVWoyN3JKYzdtMWlrSlM3OGxHNWs1K3VKRHFvdWJv?=
 =?utf-8?B?ZlBTRkFBVEdqM3RPNmtXRXVhY1ZJWXZCOVREeUtSek1rTnp2eGliQ0llMWZu?=
 =?utf-8?B?alZzeXpuYXA5K2ErQVU4VjEzNTZKWVdPTFR6b0pzMS9wb281MEVWdEk4UEV3?=
 =?utf-8?B?eHo4NDRTdERHVHk0c09UZXhyeW5HaFRPaTFuZGxBaGNkb0hFRnQ2M3ZKR2Fp?=
 =?utf-8?B?b0d4Wm9FeHMycmk4eTJnL0JOTTcwRDhKbUtZUDd2ZEltbW1sLy9iaytYbERu?=
 =?utf-8?B?NDZxK2E2R0FvbHUzdW5MOTlPanUvZzRBT0RzOWlyRnZ4cVA3ajdpMzQrTWEv?=
 =?utf-8?B?Q3RpUW9lZHZmWkMybUFiOXMvd1kwREhNMmhmS3BVWklTNEx5aGJlbWJGY3RT?=
 =?utf-8?B?dzRRaVh6bkNaWWFkcDEyTDQ0Y2tMcXdjVGJlOWpNSm1nYW8veFdvQVdDVFF0?=
 =?utf-8?B?YVY4T3dLOFROR21kbVF3OW1zb0NsUFNnbjZQUWZiOG5LY2dMR1lzY3MvR0dj?=
 =?utf-8?B?aExrYVlHVmtQZkJhMUZ6WHc2R1FJcUJXam1KZ2w0OGpCaGFkNmFXOFFJSWJG?=
 =?utf-8?B?QVVidG0wWi9FeExMZjM4RnlxY1paMmlwejhHOWI4Y0lyR3JmaDNCcXJBdTRQ?=
 =?utf-8?B?T2JQeDhYV3A3RDJpQ284cE9RcUp3Q0VBQ2hoLzJQL2dLTUw2Nmx3K0QyeG1S?=
 =?utf-8?B?akdhWGR2MFZaWUZFN2tMVUk3MWlCUSsvcm54bEJ2MzB5ck1kdTlSdkpnSmp2?=
 =?utf-8?B?WGtMeGtIdVUwM3k4bkRsNGdsY1RHSlEvZm5YR1pQWWhkbmJIcW93Y2htZnFw?=
 =?utf-8?B?K3VkWlpzRnk0SnZMREl5MDNzTWI2OGE2OW1XSjhSQmRwY2NMUXFROWJBTlRq?=
 =?utf-8?B?KzFwYUpqYVJOZS9XeFIvWURkc0tRYUQzU3N3bzNhWDBOZVZWU0o3UjdvUklI?=
 =?utf-8?B?dmN1Smg1Y3kva1VXZk14WXFPKzBiUTBsZnQ2cTFXVDFQbm9XcTEzWmE4SVBU?=
 =?utf-8?B?bldhT2NlUDliSk1Bckw4VDNZOGlBUEI2ck5sZFdaayt0bGZCMDR1clpRcjdL?=
 =?utf-8?B?WkdHMFpWVEYwazVrYlVWWVYvZDlpZVgxa095aCswODVvSzRaZEgxU3hZb1J2?=
 =?utf-8?B?Qm1haFNsVHdSM0VRaDZlRWhxdCtBUXhrT1JpaHFrMXNhQWpwb0JydDBjUG9Z?=
 =?utf-8?B?aGRLczJnWERhMm0wYXBIU1BoY2hwNTREalNZMVlNdUJYVlZES0VQYUwxVUkv?=
 =?utf-8?B?amhOZEpIL2EzOFAxTzBWbmxEUnp2dW52QUZLRGNkak9QbXUxZzAxbW1xd0I0?=
 =?utf-8?B?Y1lNQ0RFRVRUWU8wUHBhWlp6R1A0RGpRWXU3WXdnN01RTmZiTFVza0NNR2Vm?=
 =?utf-8?B?REUwRHNFd203N2k2dGk0b3RxMllCTVZMcXFUTjU5MGg4MWd6UkViWWdwVkU2?=
 =?utf-8?B?T1RqUXpDREd5Vk8yQTZCY01VMlVmbUtRazl0bUZGTkZ5aEtkZGhxMDFXQ1pT?=
 =?utf-8?B?VkVuMGZ3aU5EZndvekpXb2tpYVV4aWxDSGRBbmpYc2tleEhhUU14aU9mbUZz?=
 =?utf-8?B?dFRXMG1FTUZUVDFwRThqSE1RNENzdHpIQVNlejlvNlVMWTlNbEhLMXNtYUpk?=
 =?utf-8?B?b041TG0yeCtENUk0Vmx4Tkhub082RXlsTCtTZUtMWFJLUmlxaWo5Nkh4ck1V?=
 =?utf-8?B?MkJWenN2OTlTZXFzTjNsUlN0Z0xwcnQyd1FtcjBJa0Z6T3ZZeWlsNWtZb1pm?=
 =?utf-8?B?aVE5eWxWZXE1OVZiNTltZEJVWUp1akRwV21PTGZiS21zb3JJSytoeXVBeEQr?=
 =?utf-8?Q?Ywv6bU34zrHwR5Te9yJO7UK4stpsDnXUQs+nw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dGhROWgrTGt2dWl1VUhoTVBNTklIMVB0bWUxaWtGZmptYTgydEM2ZTNKNTlv?=
 =?utf-8?B?WG1TaDNzM0dBSDFQZ2x6QlRjb0JhMEJtcU5uM0NHckQyTFVLWlJnbC82TmQ1?=
 =?utf-8?B?NkV5dzdBSVJLQmN6bGNRVnBJNWZUNHZRbFJRZ1JzTWxRbnpydW14TWIxdkpT?=
 =?utf-8?B?Y2MxbnRZdzB0OFhJeGVNS2VkOFR6c2JHdUo0QUVDdmVUTWZvZGVGeHppdXNm?=
 =?utf-8?B?Tk1XZVkwV0RvUzNTNGhscGw4WDRPNjlURytsS256bENBOVRKb3R6MzdJcXFL?=
 =?utf-8?B?emVhZ0JNcjZjN0Vndk1vY1hQVDNZUUVjY1J6NXZSNUxDaWVhbmhGOVFxcHBs?=
 =?utf-8?B?QWdpY3lDUmYvS3hlS0ZJKzNPa3VORVRhSnluRFZMMVZkajVCMTlmQ0Y5N1RS?=
 =?utf-8?B?QzRZV1dxV0R1bjF5THZwbHJkeGYyVjBXbkkyWGFZa3ZrZk5EOXg5U29wTjlE?=
 =?utf-8?B?NjVHQ1FZS3lBZHJHcHhqVWx3dnVZUHdrbmFSUjk3WDRSYWlPSzJuajMzbG5a?=
 =?utf-8?B?emNXa2h5Vk05b0UzdzZkSUwrMnY5cEpYWWJXQXBWVjRTVVlaMlluSHlSY2Zk?=
 =?utf-8?B?RjY0ZTQzdURxVklMYWc1c0tmTHlYQlFYSUljMGF0djUya1hicURleklGdnNY?=
 =?utf-8?B?ZGMrWUZPZWd1SGducDdPM1pNUnhhNDZHdDlJT2V3TDFlbWgyd2hXQUtwYU5X?=
 =?utf-8?B?Uko0TlhmNC9JT3hBcENqZlJzLzBldEFtcmM5NGFxSTJlTUFWQU5pTXV5UmxH?=
 =?utf-8?B?ayt3aUZYelUvbzBuTHovaWNRZExhT1psSE1la1JtOUtReU1ObkZ6blVvMFh0?=
 =?utf-8?B?ejQvODdMNnlKYWR6WVAvclVhZEZMZ3c3TnY0bFNUQy9Qb09uRDJ3aC9zRFNG?=
 =?utf-8?B?YitkY096ZDFUMTE1QlFjc0x6VnBJNkU4T1p0SzNkNzZheUlsNHBRYk1tekZL?=
 =?utf-8?B?OVFvcTV5MTlsVnRTQTZQS3F4bVhsMUlKbHNqN24zWkdUaXdldjdGYzhHeU9R?=
 =?utf-8?B?UFVpNnZzaDVOcGdTblJLQytPc0RkVXM5Y2R6UUcwU29RdWMzd1g2Q3hvZU9i?=
 =?utf-8?B?MGtBVDdXckVueWp4ZGoyRXFMZ0lMZXF6dlRkMWRuazlJS2ZBOW1oOGNyRStx?=
 =?utf-8?B?aVp5TWh6dWV0YVYwK0JPc0dibzhVakR5U3oyUm9seTc0SlRHQU1NUUpZMlNq?=
 =?utf-8?B?Z20xd0toRTREaVdJcTNTSzBEYVExSTR2RkFYSHZMN1VFQ1ZlcUhkR2Fkam5Y?=
 =?utf-8?B?UVF6YTZoSzlqVzBXMmpOdHZiWjJ6WkVudHIwemtNVGNXa243NkVIVzlXTzNG?=
 =?utf-8?B?MThWaThjelJhWndVWDcvYjJ6L1VRcWdsN0h0U2F1VkZRcVRZYWdDbTh5dDNn?=
 =?utf-8?B?ckRlYUltQ2IxQnE3ZjZvTnJPNkRIaHVGalUzZkRCVXI4RUxkaWU0T2dEOWZI?=
 =?utf-8?B?SGdteTd0ZEp0YUwzZDkxTVkyc3Z3bTg4NVpIK1o5RVpEbGtFL0U3a0xnK2V6?=
 =?utf-8?B?dTJRRjdkbzZFS1U4WGI1aXVCSjNCSXFBc3J1eklwZTdRWjlpZVMveDVjbSth?=
 =?utf-8?B?alVHSFVjZWNxYXRESFcvMGpZc0lEZXBuM3lUcDhNcFR6Qzg1c3ViZWFrdm1E?=
 =?utf-8?B?SXhQUW5vM2FWOTFaOEVaU3o2SlZvOTB6Y2dsM0VlTDZvM01QakR5Y3NDVWM0?=
 =?utf-8?B?dEJZS0hvbzlvTnUwOWU0akJNQ3JIR05DaUFUZ0laU3ZLQ2IyZTc4M0lLR2k3?=
 =?utf-8?B?VklqajUvdUJORU10SVJSRjlLaVZmMjlFbXZFbnl4QlhZTVR3NWRnckR5UFVo?=
 =?utf-8?B?V1g2MFdGaWJVZjJPbG5ROW9qQkRXRDllaE5YbkxDd3J5WHFUemVvTmc1em4x?=
 =?utf-8?B?V09LcDFCT1ljNXA1N3hEcW9FSW1qd1QvbldEdlBMTDJNNzZ5RjBOd2cvUXhJ?=
 =?utf-8?B?OHdPbDNNYmdYUHBVUzBsbTBsUVRYUnhrTWlTYTJoSGliRVFpTFdRUFMvTk1k?=
 =?utf-8?B?dlJBZnpGVzROMTREdm5TV1VSVjlNNXFhV1pteDlyamFnNVlUclc5VWFSbUtR?=
 =?utf-8?B?dEhRcTY0SFFNZ2l4Sk0xbXlqVCtzcUQ3R2ZVdjVqcHloL2pwaEEvUWlqM2c2?=
 =?utf-8?B?NkJEV2J4UmtmV1JiOWNTMTNVOVYxVkR0SGt4aUtMM0RjSDBHYmd0S2tFRUVG?=
 =?utf-8?B?WHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89F18B44DBD4AB479BCD1B4184D1BBDF@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 041d272a-4a0a-4cf3-9ba4-08dd08752ad9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 08:35:47.9464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VSkCbtenVMwvBtNXdKzRwwlIAfdqciZ8sTq50RqzV9QtJDWcKkkoSuTISD49xhBJ4uNTW6jWsYIxx/Em3w8mYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR15MB6659
X-Proofpoint-GUID: dOptt0S6Fmegg1quRLo2M6snQje_Bd_E
X-Proofpoint-ORIG-GUID: dOptt0S6Fmegg1quRLo2M6snQje_Bd_E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

SGkgQW1pciwgDQoNClRoYW5rcyBmb3Igc2hhcmluZyB0aGVzZSB0aG91Z2h0cy4gSSB3aWxsIHRh
a2UgYSBjbG9zZXIgbG9vayANCmxhdGVyLCBhcyBJIGFtIG5vdCBhd2FrZSBlbm91Z2ggdG8gZnVs
bHkgdW5kZXJzdGFuZCBldmVyeXRoaW5nLg0KDQo+IE9uIE5vdiAxOCwgMjAyNCwgYXQgMTE6NTni
gK9QTSwgQW1pciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4gd3JvdGU6DQoNClsuLi5d
DQoNCj4+IE1vdmluZyBzdHJ1Y3Rfb3BzIGhvb2sgaW5zaWRlIHNlbmRfdG9fZ3JvdXAgZG9lcyBz
YXZlDQo+PiB1cyBhbiBpbmRpcmVjdCBjYWxsLiBCdXQgdGhpcyBhbHNvIG1lYW5zIHdlIG5lZWQg
dG8NCj4+IGludHJvZHVjZSB0aGUgZmFzdHBhdGggY29uY2VwdCB0byBib3RoIGZzbm90aWZ5IGFu
ZA0KPj4gZmFub3RpZnkuIEkgcGVyc29uYWxseSBkb24ndCByZWFsbHkgbGlrZSBkdXBsaWNhdGlv
bnMNCj4+IGxpa2UgdGhpcyAoc2VlIHRoZSBiaWcgQlVJTERfQlVHX09OIGFycmF5IGluDQo+PiBm
YW5vdGlmeV9oYW5kbGVfZXZlbnQpLg0KPj4gDQo+PiBPVE9ILCBtYXliZSB0aGUgYmVuZWZpdCBv
ZiBvbmUgZmV3ZXIgaW5kaXJlY3QgY2FsbA0KPj4ganVzdGlmaWVzIHRoZSBleHRyYSBjb21wbGV4
aXR5LiBMZXQgbWUgdGhpbmsgbW9yZQ0KPj4gYWJvdXQgaXQuDQo+PiANCj4gDQo+IEkgbmVlZCB0
byBleHBsYWluIHNvbWV0aGluZyBhYm91dCBmc25vdGlmeSB2cy4gZmFub3RpZnkNCj4gaW4gb3Jk
ZXIgdG8gYXJndWUgd2h5IHRoZSBmZWF0dXJlIHNob3VsZCBiZSAiZmFub3RpZnkiLCBidXQgdGhl
DQo+IGJvdHRvbSBsaW5lIGlzIHRoYXQgaXMgc2hvdWxkIG5vdCBiZSB0b28gaGFyZCB0byBhdm9p
ZCB0aGUgaW5kaXJlY3QNCj4gY2FsbCBldmVuIGlmIHRoZSBmZWF0dXJlIGlzIGludHJvZHVjZWQg
dGhyb3VnaCBmYW5vdGlmeSBBUEkgYXMgSSB0aGluaw0KPiB0aGF0IGl0IHNob3VsZCBiZS4NCg0K
V2hlbiBJIGZpcnN0IGxvb2tlZCBpbnRvIHRoaXMsIEkgdGhvdWdodCBhYm91dCAid2hldGhlciAN
CnRoZXJlIHdpbGwgYmUgYSB1c2UgY2FzZSB0aGF0IHVzZXMgZnNub3RpZnkgYnV0IG5vdCBmYW5v
dGlmeSIuIA0KSSBkaWRuJ3QgZ2V0IGFueSBjb25jbHVzaW9uIG9uIHRoaXMgYmFjayB0aGVuLiBC
dXQgYWNjb3JkaW5nIA0KdG8gdGhpcyB0aHJlYWQsIEkgdGhpbmsgd2UgYXJlIHByZXR0eSBjb25m
aWRlbnQgdGhhdCBmdXR1cmUgDQp1c2UgY2FzZXMgKHN1Y2ggYXMgRkFOX1BSRV9BQ0NFU1MpIHdp
bGwgaGF2ZSBhIGZhbm90aWZ5IHBhcnQuIA0KSWYgdGhpcyBpcyB0aGUgY2FzZSwgSSB0aGluayBm
YW5vdGlmeS1icGYgbWFrZXMgbW9yZSBzZW5zZS4gDQoNCj4gVExEUjoNCj4gVGhlIGZzbm90aWZ5
X2JhY2tlbmQgYWJzdHJhY3Rpb24gaGFzIGJlY29tZSBzb21ld2hhdA0KPiBvZiBhIHRoZWF0ZXIg
b2YgYWJzdHJhY3Rpb24gb3ZlciB0aW1lLCBiZWNhdXNlIHRoZSBmZWF0dXJlDQo+IGRpc3RhbmNl
IGJldHdlZW4gZmFub3RpZnkgYmFja2VuZCBhbmQgYWxsIHRoZSByZXN0IGhhcyBncmV3DQo+IHF1
aXRlIGxhcmdlLg0KPiANCj4gVGhlIGxvZ2ljIGluIHNlbmRfdG9fZ3JvdXAoKSBpcyAqc2VlbWlu
Z2x5KiB0aGUgZ2VuZXJpYyBmc25vdGlmeQ0KPiBsb2dpYywgYnV0IG5vdCByZWFsbHksIGJlY2F1
c2Ugb25seSBmYW5vdGlmeSBoYXMgaWdub3JlIG1hc2tzDQo+IGFuZCBvbmx5IGZhbm90aWZ5IGhh
cyBtYXJrIHR5cGVzIChpbm9kZSxtb3VudCxzYikuDQo+IA0KPiBUaGlzIGRpZmZlcmVuY2UgaXMg
ZW5jb2RlZCBieSB0aGUgZ3JvdXAtPm9wcy0+aGFuZGxlX2V2ZW50KCkNCj4gb3BlcmF0aW9uIHRo
YXQgb25seSBmYW5vdGlmeSBpbXBsZW1lbnRzLg0KPiBBbGwgdGhlIHJlc3Qgb2YgdGhlIGJhY2tl
bmRzIGltcGxlbWVudCB0aGUgc2ltcGxlciAtPmhhbmRsZV9pbm9kZV9ldmVudCgpLg0KPiANCj4g
U2ltaWxhcmx5LCB0aGUgZ3JvdXAtPnByaXZhdGUgdW5pb24gaXMgYWx3YXlzIGRvbWluYXRlZCBi
eSB0aGUgc2l6ZQ0KPiBvZiBncm91cC0+ZmFub3RpZnlfZGF0YSwgc28gdGhlcmUgaXMgbm8gYmln
IGRpZmZlcmVuY2UgaWYgd2UgcGxhY2UNCj4gZ3JvdXAtPmZwX2hvb2sgKG9yIC0+ZmlsdGVyX2hv
b2spIG91dHNpZGUgb2YgZmFub3RpZnlfZGF0YSwgc28gdGhhdA0KPiB3ZSBjYW4gcXVlcnkgYW5k
IGNhbGwgaXQgZnJvbSBzZW5kX3RvX2dyb3VwKCkgc2F2aW5nIHRoZSBpbmRpcmVjdCBjYWxsDQo+
IHRvIC0+aGFuZGxlX2V2ZW50KCkuDQo+IA0KPiBUaGF0IHN0aWxsIGxlYXZlcyB0aGUgcXVlc3Rp
b24gaWYgd2UgbmVlZCB0byBjYWxsIGZhbm90aWZ5X2dyb3VwX2V2ZW50X21hc2soKQ0KPiBiZWZv
cmUgdGhlIGZpbHRlciBob29rLg0KDQpJIHdhcyB0cnlpbmcgQWxleGVpJ3MgaWRlYSB0byBtb3Zl
IHRoZSBBUEkgdG8gZnNub3RpZnksIGFuZCBnb3QgDQpzdHVja2VkIGF0IGZhbm90aWZ5X2dyb3Vw
X2V2ZW50X21hc2soKS4gSXQgYXBwZWFycyB3ZSBzaG91bGQNCmFsd2F5cyBob25vciB0aGVzZSBi
dWlsdC1pbiBmaWx0ZXJzLiANCg0KPiBmYW5vdGlmeV9ncm91cF9ldmVudF9tYXNrKCkgZG9lcyBz
ZXZlcmFsIHRoaW5ncywgYnV0IEkgdGhpbmsgdGhhdA0KPiB0aGUgb25seSB0aGluZyByZWxldmFu
dCBiZWZvcmUgdGhlIGZpbHRlciBob29rIGlzIHRoaXMgbGluZToNCj4gICAgICAgICAgICAgICAg
LyoNCj4gICAgICAgICAgICAgICAgICogU2VuZCB0aGUgZXZlbnQgZGVwZW5kaW5nIG9uIGV2ZW50
IGZsYWdzIGluIG1hcmsgbWFzay4NCj4gICAgICAgICAgICAgICAgICovDQo+ICAgICAgICAgICAg
ICAgIGlmICghZnNub3RpZnlfbWFza19hcHBsaWNhYmxlKG1hcmstPm1hc2ssIG9uZGlyLCB0eXBl
KSkNCj4gICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gDQo+IFRoaXMgY29kZSBp
cyByZWxhdGVkIHRvIHRoZSB0d28gImJ1aWx0LWluIGZhbm90aWZ5IGZpbHRlcnMiLCBuYW1lbHkN
Cj4gRkFOX09ORElSIGFuZCBGQU5fRVZFTlRfT05fQ0hJTEQuDQo+IFRoZXNlIGJ1aWx0LWluIGZp
bHRlcnMgYXJlIHNvIGxhbWUgdGhhdCB0aGV5IHNlcnZlIGFzIGEgZ29vZCBleGFtcGxlDQo+IHdo
eSBhIHByb2dyYW1tYWJsZSBmaWx0ZXIgaXMgYSBiZXR0ZXIgaWRlYS4NCj4gRm9yIGV4YW1wbGUs
IHVzZXJzIG5lZWQgdG8gb3B0LWluIGZvciBldmVudHMgb24gZGlyZWN0b3JpZXMsIGJ1dCB0aGV5
DQo+IGNhbm5vdCByZXF1ZXN0IGV2ZW50cyBvbmx5IG9uIGRpcmVjdG9yaWVzLg0KPiANCj4gSGlz
dG9yaWNhbGx5LCB0aGUgImdlbmVyaWMiIGFic3RyYWN0aW9uIGluIHNlbmRfdG9fZ3JvdXAoKSBo
YXMgZGVhbHQNCj4gd2l0aCB0aGUgbm9uLWdlbmVyaWMgZmFub3RpZnkgaWdub3JlIG1hc2ssIGJ1
dCBoYXMgbm90IGRlYWx0IHdpdGgNCj4gdGhlc2Ugbm9uLWdlbmVyaWMgZmFub3RpZnkgYnVpbHQt
aW4gZmlsdGVycy4NCj4gDQo+IEhvd2V2ZXIsIHNpbmNlIGNvbW1pdCAzMWEzNzFlNDE5YzggKCJm
YW5vdGlmeTogcHJlcGFyZSBmb3Igc2V0dGluZw0KPiBldmVudCBmbGFncyBpbiBpZ25vcmUgbWFz
ayIpLCBzZW5kX3RvX2dyb3VwKCkgaXMgYWxyZWFkeSBhd2FyZSBvZiB0aG9zZQ0KPiBmYW5vdGlm
eSBidWlsdC1pbiBmaWx0ZXJzLg0KDQpJIHdpbGwgY29udGludWUgb24gdGhpcyB0b21vcnJvdy4g
SXQgaXMgdGltZSB0byBnZXQgc29tZSBzbGVlcC4gOikNCg0KPiANCj4gU28gdW5sZXNzIEkgYW0g
bWlzc2luZyBzb21ldGhpbmcsIGlmIHdlIGFsaWduIHRoZSBtYXJrcyBpdGVyYXRpb24NCj4gbG9v
cCBpbiBzZW5kX3RvX2dyb3VwKCkgdG8gbG9vayBleGFjdGx5IGxpa2UgdGhlIG1hcmtzIGl0ZXJh
dGlvbiBsb29wIGluDQo+IGZhbm90aWZ5X2dyb3VwX2V2ZW50X21hc2soKSwgdGhlcmUgc2hvdWxk
IGJlIG5vIHByb2JsZW0gdG8gY2FsbA0KPiB0aGUgZmlsdGVyIGhvb2sgZGlyZWN0bHksIHJpZ2h0
IGJlZm9yZSBjYWxsaW5nIC0+aGFuZGxlX2V2ZW50KCkuDQo+IA0KPiBIb3BlIHRoaXMgYnJhaW4g
ZHVtcCBoZWxwcy4NCg0KVGhhbmtzIGFnYWluIGZvciB5b3VyIGlucHV0IQ0KDQpTb25nDQoNCj4g
DQo+IFRoYW5rcywNCj4gQW1pci4NCg0K

