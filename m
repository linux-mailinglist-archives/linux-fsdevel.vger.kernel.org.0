Return-Path: <linux-fsdevel+bounces-35949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB349DA092
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 03:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0518EB227B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 02:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677691F92A;
	Wed, 27 Nov 2024 02:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="daEHjd+E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104C7322E;
	Wed, 27 Nov 2024 02:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732673776; cv=fail; b=XyLRQFRih57ql8tQilqO+IE7pG8qBBnGHMC6LkbFH37Vlkq9ausPtgzeMUO/fhGDnRi1ksmtlpRG1PxZeTM7V0HENYXhwJ5th6UkoAy1cF9xroHCRIET80Eh1PPdp4LXEgRkvp8UmSZksr8YIcpcZhNbLz8J885vHUPu6S2DA1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732673776; c=relaxed/simple;
	bh=ZwrPPw/6bb6Ktr6In2sKf2uPRNeIKzpxGhMmc1KlOU4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HKRDSo2vxs4Hga1wX4wuuiEKikq/KVWOmBluUBX99JBffwUjD6KiA+JJcgToJYwSmP/YzPtN3ciU2i6Bt/SzJagM0Aya+YcrCccopLidBIDXCahnVJ4bjHzJKsUAtZqMp2mXYcq44b00G4tGxJnF/4RWPvtKSUqQbU4xvM2EyRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=daEHjd+E; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR08Ej7019330;
	Tue, 26 Nov 2024 18:16:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=ZwrPPw/6bb6Ktr6In2sKf2uPRNeIKzpxGhMmc1KlOU4=; b=
	daEHjd+EMEzphU85ld0kwc9YmYVI1X7GRFizPw97eMRhTDeEKWF679F9woHFKFi+
	2VuvCPHeH4cWD+SAov9c2U+J7ES4vyCya2VLu5Cg8qgJhCiYsPRICogQfzf4m7Dt
	jcIcvFFyYLoRcXi5FBF/CqPX7MVRjdpfvnweXLmIR1r/ZKMKJj+EU+Q0Vlt3l067
	mw60CqkCX5qRrP7T+vPnlW+Nr5WAEBzzB4V29u78xmvBZQC7mAXE+8eEMPd5T3Aq
	7VLcIykMbGcfbS1np72Xobqq1dgD6w64eWJqtqjuEVu2hfxKn9I5RPhCyGcqG7KY
	wprJF0wuWqwnOsIBXWdqCw==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 435h8ccexx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 18:16:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zR4pkN+QxVnbDFZ0f5pTioqb+6OIf4RMy0ZWeLc2qZndBRVzSoPRGpb1xkbLL/hlQdZ07oxPhddMP8fqlsuQUHLNG9JY3cGN2hbUnb1p7cKp2h+9Ntv/hwSufXO4usapIsqVdEsUPc3ljwdvmUtG13Jqv6Vcs3+cfxy8MYAm6G2XPA6rWCIlXSO5vyYSFzxYxyLea3xrocxUo4S16kCI1rkWbDQOGqcLjwsO8pBX6RZ94lSkJimF7YpTp2nCNQV/t5bpsIhEjtASx2JDQPA1v/OhYm6LJ4JERxDBxkwC5BS3sjL2NHdRGwxiAbOcAY5dr2frwy2IVM55XEfV80j9AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwrPPw/6bb6Ktr6In2sKf2uPRNeIKzpxGhMmc1KlOU4=;
 b=PjFolYSoZitdW7R/zy7h+YLYQUr0pvZoDxXx4bAtPtmVjU8SsaYAOnvQAx1YbHY+h+TGi1Q5xEBO+KB+hPt44GnqJEZdrGRc9w5b2ZppgxTRfNLBYb7gm334a0a5YtDHpgnMshOQqtG6sQ1XDzTlKvr+jmdEBlABvKlTbMRTU++d9Ds1pxJabx1ptTIjxvPck3zEiT2i/lXPvLV52hu8iii4ov4zNOESy8EAKZweYffZ3R2IaMbbV+y5ar015ZezLNvTP9nG4GvwoZDdDiLT6xxjkIPI05XZ/4V+YT7qtDrGhzKVIEr7gW1djxcW/4ByaZKqwgi2IUGb2Qyjr62a1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by LV8PR15MB6633.namprd15.prod.outlook.com (2603:10b6:408:25d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 27 Nov
 2024 02:16:10 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%6]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 02:16:09 +0000
From: Song Liu <songliubraving@meta.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Amir Goldstein <amir73il@gmail.com>, Song Liu <song@kernel.org>,
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
        "repnop@google.com" <repnop@google.com>,
        Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?=
	<mic@digikod.net>,
        "gnoack@google.com" <gnoack@google.com>
Subject: Re: [PATCH v3 fanotify 2/2] samples/fanotify: Add a sample fanotify
 fiter
Thread-Topic: [PATCH v3 fanotify 2/2] samples/fanotify: Add a sample fanotify
 fiter
Thread-Index: AQHbPTJZqeNX/hCyTk2z4ZUDy/y7a7LF4v0AgARvTICAABfpAA==
Date: Wed, 27 Nov 2024 02:16:09 +0000
Message-ID: <21A94434-5519-4659-83FA-3AB782F064E2@fb.com>
References: <20241122225958.1775625-1-song@kernel.org>
 <20241122225958.1775625-3-song@kernel.org>
 <CAOQ4uxhfd8ryQ6ua5u60yN5sh06fyiieS3XgfR9jvkAOeDSZUg@mail.gmail.com>
 <CAADnVQK-6MFdwD_0j-3x2-t8VUjbNJUuGrTXEWJ0ttdpHvtLOA@mail.gmail.com>
In-Reply-To:
 <CAADnVQK-6MFdwD_0j-3x2-t8VUjbNJUuGrTXEWJ0ttdpHvtLOA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|LV8PR15MB6633:EE_
x-ms-office365-filtering-correlation-id: 7c99c134-bd2d-47c3-2131-08dd0e89755a
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y3NOcEllTGZ2dWxJVHJZN3BEY1R6QjJpaFUyd1VhMUgwNXQ4ZlJ4OWgxdDV0?=
 =?utf-8?B?T2xzTlVOUFNScEk5Um1TbVNVMTJ3amRaV0JWKy9venFYT05lZ1MrV2dlS2p1?=
 =?utf-8?B?dE5WS25aRnpjL2wwdVVDdFh0RjhIeURFeVBTUmZqZE1aZzdpRDNjR2Q1T0lS?=
 =?utf-8?B?eDlTNFo1Y3h3NWFoN0xNRHhsSUNPeFdFVUNKUHpNcUQwVm92MGdWZ0JreVU2?=
 =?utf-8?B?MmM2TEhuai9DRVptOEZMaFVmTG5sRlB4NGlGL3gyeFh2RHVWL0FOWkNRamkz?=
 =?utf-8?B?ZElTQ1hDQlRMaHFUTmVPUHIzb2JYc1gvcGJYRFZ1M20zd1BIdis0N0dKZ25J?=
 =?utf-8?B?a2NYZGVURkh6LzF0UmJHMlIzRGdMNUtzNFZ5aUdjZ3VoZWJ6d0tZakN0aUZD?=
 =?utf-8?B?bk84bUVNSFg2ajhScEZXbU5VM3M2WWxScDFtU3FTaFVLRGZBdmRoZUQxbW16?=
 =?utf-8?B?Yy9OaHBUQVJHbVBwczNYaE83TjNORWh3NndvMDRTR3hBNVJmaEZHWlZYVFpY?=
 =?utf-8?B?Rzh0aW4zWGlvVkh2bzFoaUVXMnVMLzhnOUVnMEhEenVUWEtRQ1FPMW5ZWk1r?=
 =?utf-8?B?MDZ5Z2dhKytVWmw5NE04c2YyYjhRUFc5NlcrRnNKVEZMU2ZDbER3UmxnbTVV?=
 =?utf-8?B?MDFlNjRVT2NCMXFkR1NSOFExd1lBVmU0L3U2VElaYnhsWkh2NU92UmhoMWtY?=
 =?utf-8?B?dlZiV0Nma0llM2RrK3JDZWVYbjRNTTBZdk8zRmFRSUV4Ni9uYjUrRlRuRDA1?=
 =?utf-8?B?OUR3UmR6cC9jdHF4TU56eHB3aHJmT3hqWjZBNG9FZjVxOFJjRS9yZitseDFK?=
 =?utf-8?B?Q3drY1NuU3NyR3VuU0xpZG90b3NON0hkWU1aNm9vSjBoOXAxQ1drMjk4dG1z?=
 =?utf-8?B?QzFPVWJDZkczNmEweENZYUpXM0xLaUdZY1lQZDFpOXJYeUZ0eEJORnkwbnMv?=
 =?utf-8?B?WDcyWDllNGFhK2NKa25zMjM1cHZqbHhDMU4xWlUxNW92YTVDa1JBSmVtM3g0?=
 =?utf-8?B?ZDJMZExFZGRYaUY2SWZnNnVMM2VwTU9GK3NScTQ5RG5EZHYrRWVyb1Q5TEJi?=
 =?utf-8?B?M21OZi9yVHp1azdNSGhoUFVnSEt6Ui9iNW9ydjVYU1FjZUtEWEs1MjZoR0dr?=
 =?utf-8?B?ZUZaVWxUbHRTdmtvSmJudklVMitXdS9jbFVzQnQva1dNeEhCSDUyaitPVkhW?=
 =?utf-8?B?UjFOaDA2eDJ2Q0I0TkkrVGJPbk5NazdNRitJck5DSDhIWU56aVM5bkNTaUl0?=
 =?utf-8?B?dFdKZWZIUEFzWFgrdnNGYnBJcFFTdGZvdzUrcDg3WUpyRXg4L1JTRXBUaXdr?=
 =?utf-8?B?TWU0YUEwYnhPdXY5T0ZBYThEOThOYkNwNU5PbWdFZHp5NTZwMTNtWVEvTVVN?=
 =?utf-8?B?dU82ak14Um9KMDdYTFg5MitqMTZTdEJDandFRlNSLzFKamQ1NjdLcXVpNG9P?=
 =?utf-8?B?SkNROGRMbmVEYzFVRE5VMHZMRlJKQW9mN1VUamJDSlU1UEhnNFJleDlBbEdu?=
 =?utf-8?B?QWhNVDNtbW56YU53YU43WEFnT0MzOTVPUkdLWlJuSkl3YTE5ZUUwbG81RFYv?=
 =?utf-8?B?VmJIcHZ6M3haMHhqVFFGMlI5Y0twRWxiSXk2TDhVTnhNRUhPL2ZPZlZwN0NX?=
 =?utf-8?B?MjJpNTZqdHh6YTFsMEEyZWNja3EwSWhUK2w3dFB3MXFXOWxHRWgrUmY0cThO?=
 =?utf-8?B?YjBzbitHaUpmYVJEaWN0aG1RaktuK1lKbUpGSVdzUzF1R0tiZEJNM05XQ1d0?=
 =?utf-8?B?VndDNnp6U3V3d1JkQ2xkc1lzMG5idnVtNlJuS0lMREJnWDNZeW1QdXhDVHpW?=
 =?utf-8?B?YzhuSTcrTno5YUxiNytTaDNyK010cGI1MW9iTFoyYzAxQ3dscVp1MW00N242?=
 =?utf-8?B?TCtvZVdNeFNHbVZVTzA4c0JDc2EvUWgyUHJwMkkzMTZkMWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?THB0d2o0ek1nNHBpQ2gwR3hOQTJreks0amM4VEcwR0xtdnBUN0o3eGJWY2FJ?=
 =?utf-8?B?TUlLV21UYzhVUGpkMGZwNHNnZ0JDeG9DdDdvbzRQWVNWNDk4aHZ6WGpzeTZm?=
 =?utf-8?B?anFHUzUyRUdJMnplUHllbEJIZWpLRVJUR25QV0NDbG5BMHczOC9HVmI1YkFF?=
 =?utf-8?B?RVg2cmhNY214VXM5bCtSVzJmVnN3S1pNaldCY2ZVdERVazF6T0RLMHRaeTA1?=
 =?utf-8?B?Y2hCOTM5OHdXK0RTY0IxODFhSHRlNzZGRkpiWDJqR1VWcmVxNWVVS0ttcFJP?=
 =?utf-8?B?TU9NQTFzUElVaWx3QURlN3RlMjhvL3o1SFBZYmVSYml1WWxFL3hOcUlXWi9o?=
 =?utf-8?B?VnlNYitHODdQOFZKMWszWTd0YmwzNWY0TGJlYzhuYnRkQUtmUys0Q21EOUc5?=
 =?utf-8?B?cTFsSFZvQXBnNmRoWnc1UnJoZTdBQzhYdnBxd1VsOTVsM090TWhOa3piUDNr?=
 =?utf-8?B?dE9WNWdKREZHQ3E4THNERUVKUldFQ24xcGVESXVTNmtsSUxCa0plYTI2NzRy?=
 =?utf-8?B?Ukxnd0M4VHk5dFNUQXNpRHR3QVNzQnRLcDIvK2IzTWF5VmdzVHFuOHVMeUlU?=
 =?utf-8?B?Q256RTJQTDlISjViV01pYUFiaDdEa25ySGt0bjJYT2p0TExnK0kwNTd0OFJw?=
 =?utf-8?B?K3VzcTdhdlQ0UUNvV3I4ZTFvTks1eGlmZ3NCYkc3RS9lK1BFdDZYNHdlTWFx?=
 =?utf-8?B?L3RjTE9neE5QeEhoQ0RkRnM5WkZDMklwZGplb3gwY0FYeStIUWdKRm1taStw?=
 =?utf-8?B?QnJoSzkrYkV2amUzaWRuTlR2T0UyRlFDNUZ1bnZxMTROQmJaQlpQaWxDamJO?=
 =?utf-8?B?a3NtWFQyNGx2VkZQeTJvcnFWUHI0RHJ6dkE1VitBZExjODkvN2tZL25MVTBv?=
 =?utf-8?B?VURoZzk0czd6MmgzQTBSZzZUb0dsaVhJNEl1R21MRjBjNWd0ZkdJdmhxK0NQ?=
 =?utf-8?B?NjZqNEpwdkk2cjZqREVFNWZtd3FNRnovUWljYWRwK014WU01TkkwZlBLZjBt?=
 =?utf-8?B?cURWMW5JZThuRFJHTWM1ejc2ZzNQclJiT2R4bERYYThVbk9tUWQrQWp1VGlZ?=
 =?utf-8?B?RldORkg3TUFoaHpSWDF3ZVhvQ1BPKzVaZUUycWhXb1pGaGdRWGRaUUl1UW9Z?=
 =?utf-8?B?VnQ1SkhjSDNDQkl5ZXlxZmdWUkhrMTlzTkovbGU0SkZYYUJYeEt2R2JFYk12?=
 =?utf-8?B?MlVaYXZPSHYyN0tsNDhXSzZUZlRGNjU1UHBkU2lhT0g2eHdBdTZ6OTdCeldy?=
 =?utf-8?B?YWJpODNZRmpQOFJhdnpaT2prNUZRcjBPenVnWW0zSWJjdGt0UG0zRGI4bmtE?=
 =?utf-8?B?RkU1QkJQdFhKS1NBM2U1bzZYZWVlREZPSE1ZV0dIdCtLSGxVcUF2Yk1tU2lZ?=
 =?utf-8?B?eVJXallqKzljeWNrYkhiZXJQdGlOWmhOcGtHUzFaZVNNV2NZeFpwM0RWUDhw?=
 =?utf-8?B?KzE3UGVnaXRSZlhTajJWVjV1anFvR21EN2ZWcUp5c1JpaHpKRlNsV1JUMFBN?=
 =?utf-8?B?SGhTN3dwMGp4UFIydlozTE8zMFIrQ2VvYjRzdlFoUzBiZnpab291WnVWcEdF?=
 =?utf-8?B?R1VmT3ZIbzlYc1k3ZHB3aENQNUpTSHFDZzBFRjhHbmd0RnFHRU1OWHpiRno4?=
 =?utf-8?B?N2tHZWI3eEJlWWNkR2hJS1ZqSzYvZERJZWJyRWFzUGM4VTIvKzZiVzVyNmRk?=
 =?utf-8?B?ZXkybWFJSDlPRlVKK3VzZmNXQmlIQitxMVRUbGVUVVh5RXYyNjRYRStnYkl5?=
 =?utf-8?B?dkkrKzBaUXNOMEI4Y05neThrd0ZJeWZzOVJDL1JqR3lvUzd2dXB3bldQbVNH?=
 =?utf-8?B?cktUVmZvbWVOQllpdUE5NU1kT1Rkei9hai96TzZRYTZxNnhlYnZDTGVhRXo1?=
 =?utf-8?B?UkpDRUpqUG92VTczNkJyUUlkT24wL1pGL3h2OXNuUSt0dm5rRGRSYk93KzhH?=
 =?utf-8?B?cXB3Mm1Ba3VoVGwrd3pZM2RmeDVLZkh5NWNMdytrMlhxVXdMNy9tZ3VuZU54?=
 =?utf-8?B?VjB0cDR4aWpIVzByc0JYTWdqa3Uyb2JYMFowWGZqdkFpV0k3Skg5YXdUdUM1?=
 =?utf-8?B?TGd1Mk9PSHQvOW5vbVJaTXhPMHZ4c2ZyWXVCUWhURkJaWXF3ZVRuQXp6bURn?=
 =?utf-8?B?YmZCRVRDQjVnOERBZUlDcncvTGdMR3JBOWlvUk1RN1lwRnlEL254M2JHWWZK?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F087D5801C86D459CA692B6A551A873@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c99c134-bd2d-47c3-2131-08dd0e89755a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 02:16:09.8573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DcPux1uxp+BCcdnXqw64s9tDBPaOZ58FP72UF5+vcekKAqjNzZqVrCZz8J1N3lOGqSf1zHFi+noUcafC38NwIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR15MB6633
X-Proofpoint-GUID: BBJh22I0FWNnH08Eq4GxWXznj8yL32VH
X-Proofpoint-ORIG-GUID: BBJh22I0FWNnH08Eq4GxWXznj8yL32VH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gTm92IDI2LCAyMDI0LCBhdCA0OjUw4oCvUE0sIEFsZXhlaSBTdGFyb3ZvaXRvdiA8
YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KDQpbLi4uXQ0KDQo+Pj4g
Kw0KPj4+ICtzdGF0aWMgdm9pZCBzYW1wbGVfZmlsdGVyX2ZyZWUoc3RydWN0IGZhbm90aWZ5X2Zp
bHRlcl9ob29rICpmaWx0ZXJfaG9vaykNCj4+PiArew0KPj4+ICsgICAgICAgc3RydWN0IGZhbl9m
aWx0ZXJfc2FtcGxlX2RhdGEgKmRhdGEgPSBmaWx0ZXJfaG9vay0+ZGF0YTsNCj4+PiArDQo+Pj4g
KyAgICAgICBwYXRoX3B1dCgmZGF0YS0+c3VidHJlZV9wYXRoKTsNCj4+PiArICAgICAgIGtmcmVl
KGRhdGEpOw0KPj4+ICt9DQo+Pj4gKw0KPj4gDQo+PiBIaSBTb25nLA0KPj4gDQo+PiBUaGlzIGV4
YW1wbGUgbG9va3MgZmluZSBidXQgaXQgcmFpc2VzIGEgcXVlc3Rpb24uDQo+PiBUaGlzIGZpbHRl
ciB3aWxsIGtlZXAgdGhlIG1vdW50IG9mIHN1YnRyZWVfcGF0aCBidXN5IHVudGlsIHRoZSBncm91
cCBpcyBjbG9zZWQNCj4+IG9yIHRoZSBmaWx0ZXIgaXMgZGV0YWNoZWQuDQo+PiBUaGlzIGlzIHBy
b2JhYmx5IGZpbmUgZm9yIG1hbnkgc2VydmljZXMgdGhhdCBrZWVwIHRoZSBtb3VudCBidXN5IGFu
eXdheS4NCj4+IA0KPj4gQnV0IHdoYXQgaWYgdGhpcyB3YXNuJ3QgdGhlIGludGVudGlvbj8NCj4+
IFdoYXQgaWYgYW4gQW50aS1tYWx3YXJlIGVuZ2luZSB0aGF0IHdhdGNoZXMgYWxsIG1vdW50cyB3
YW50ZWQgdG8gdXNlIHRoYXQNCj4+IGZvciBjb25maWd1cmluZyBzb21lIGlnbm9yZS9ibG9jayBz
dWJ0cmVlIGZpbHRlcnM/DQo+PiANCj4+IE9uZSB3YXkgd291bGQgYmUgdG8gdXNlIGEgaXNfc3Vi
dHJlZSgpIHZhcmlhbnQgdGhhdCBsb29rcyBmb3IgYQ0KPj4gc3VidHJlZSByb290IGlub2RlDQo+
PiBudW1iZXIgYW5kIHRoZW4gdmVyaWZpZXMgaXQgd2l0aCBhIHN1YnRyZWUgcm9vdCBmaWQuDQo+
PiBBIHByb2R1Y3Rpb24gc3VidHJlZSBmaWx0ZXIgd2lsbCBuZWVkIHRvIHVzZSBhIHZhcmlhbnQg
b2YgaXNfc3VidHJlZSgpDQo+PiBhbnl3YXkgdGhhdA0KPj4gbG9va3MgZm9yIGEgc2V0IG9mIHN1
YnRyZWUgcm9vdCBpbm9kZXMsIGJlY2F1c2UgZG9pbmcgYSBsb29wIG9mIGlzX3N1YnRyZWUoKSBm
b3INCj4+IG11bHRpcGxlIHBhdGhzIGlzIGEgbm8gZ28uDQo+PiANCj4+IERvbid0IG5lZWQgdG8g
Y2hhbmdlIGFueXRoaW5nIGluIHRoZSBleGFtcGxlLCB1bmxlc3Mgb3RoZXIgcGVvcGxlDQo+PiB0
aGluayB0aGF0IHdlIGRvIG5lZWQgdG8gc2V0IGEgYmV0dGVyIGV4YW1wbGUgdG8gYmVnaW4gd2l0
aC4uLg0KPiANCj4gSSB0aGluayB3ZSBoYXZlIHRvIHRyZWF0IHRoaXMgcGF0Y2ggYXMgYSByZWFs
IGZpbHRlciBhbmQgbm90IGFzIGFuIGV4YW1wbGUNCj4gdG8gbWFrZSBzdXJlIHRoYXQgdGhlIHdo
b2xlIGFwcHJvYWNoIGlzIHdvcmthYmxlIGVuZCB0byBlbmQuDQo+IFRoZSBwb2ludCBhYm91dCBu
b3QgaG9sZGluZyBwYXRoL2RlbnRyeSBpcyB2ZXJ5IHZhbGlkLg0KPiBUaGUgYWxnb3JpdGhtIG5l
ZWRzIHRvIHN1cHBvcnQgdGhhdC4NCg0KSG1tLi4gSSBhbSBub3Qgc3VyZSB3aGV0aGVyIHdlIGNh
bm5vdCBob2xkIGEgcmVmY291bnQuIElmIHRoYXQgaXMgYSANCnJlcXVpcmVtZW50LCB0aGUgYWxn
b3JpdGhtIHdpbGwgYmUgbW9yZSBjb21wbGV4LiANCg0KSUlVQywgZnNub3RpZnlfbWFyayBvbiBh
IGlub2RlIGRvZXMgbm90IGhvbGQgYSByZWZjb3VudCB0byBpbm9kZS4gDQpBbmQgd2hlbiB0aGUg
aW5vZGUgaXMgZXZpY3RlZCwgdGhlIG1hcmsgaXMgZnJlZWQuIEkgZ3Vlc3MgdGhpcyANCnJlcXVp
cmVzIHRoZSB1c2VyIHNwYWNlLCB0aGUgQW50aVZpcnVzIHNjYW5uZXIgZm9yIGV4YW1wbGUsIHRv
IA0KaG9sZCBhIHJlZmVyZW5jZSB0byB0aGUgaW5vZGU/IElmIHRoaXMgaXMgdGhlIGNhc2UsIEkg
dGhpbmsgaXQgDQppcyBPSyBmb3IgdGhlIGZpbHRlciwgZWl0aGVyIGJwZiBvciBrZXJuZWwgbW9k
dWxlLCB0byBob2xkIGEgDQpyZWZlcmVuY2UgdG8gdGhlIHN1YnRyZWUgcm9vdC4gDQoNCj4gSXQg
bWF5IHZlcnkgd2VsbCB0dXJuIG91dCB0aGF0IHRoZSBsb2dpYyBvZiBoYW5kbGluZyBtYW55IGZp
bHRlcnMNCj4gd2l0aG91dCBhIGxvb3AgYW5kIG5vdCBncmFiYmluZyBhIHBhdGggcmVmY250IGlz
IHRvbyBjb21wbGV4IGZvciBicGYuDQo+IFRoZW4gdGhpcyBzdWJ0cmVlIGZpbHRlcmluZyB3b3Vs
ZCBoYXZlIHRvIHN0YXkgYXMgYSBrZXJuZWwgbW9kdWxlDQo+IG9yIGV4dHJhIGZsYWcvZmVhdHVy
ZSBmb3IgZmFub3RpZnkuDQoNCkhhbmRsaW5nIG11bHRpcGxlIHN1YnRyZWVzIGlzIGluZGVlZCBh
biBpc3N1ZS4gU2luY2Ugd2UgcmVseSBvbiANCnRoZSBtYXJrIGluIHRoZSBTQiwgbXVsdGlwbGUg
c3VidHJlZXMgdW5kZXIgdGhlIHNhbWUgU0Igd2lsbCBzaGFyZQ0KdGhhdCBtYXJrLiBVbmxlc3Mg
d2UgdXNlIHNvbWUgY2FjaGUsIGFjY2Vzc2luZyBhIGZpbGUgd2lsbCANCnRyaWdnZXIgbXVsdGlw
bGUgaXNfc3ViZGlyKCkgY2FsbHMuIA0KDQpPbmUgcG9zc2libGUgc29sdXRpb24gaXMgdGhhdCBo
YXZlIGEgbmV3IGhlbHBlciB0aGF0IGNoZWNrcw0KaXNfc3ViZGlyKCkgZm9yIGEgbGlzdCBvZiBw
YXJlbnQgc3VidHJlZXMgd2l0aCBhIHNpbmdsZSBzZXJpZXMNCm9mIGRlbnRyeSB3YWxrLiBJT1cs
IHNvbWV0aGluZyBsaWtlOg0KDQpib29sIGlzX3N1YmRpcl9vZl9hbnkoc3RydWN0IGRlbnRyeSAq
bmV3X2RlbnRyeSwgDQogICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGxpc3RfaGVhZCAqbGlz
dF9vZl9kZW50cnkpLg0KDQpGb3IgQlBGLCBvbmUgcG9zc2libGUgc29sdXRpb24gaXMgdG8gd2Fs
ayB0aGUgZGVudHJ5IHRyZWUgDQp1cCB0byB0aGUgcm9vdCwgdW5kZXIgYnBmX3JjdV9yZWFkX2xv
Y2soKS4gDQoNCkRvZXMgdGhpcyBzb3VuZCByZWFzb25hYmxlPw0KDQpUaGFua3MsDQpTb25nDQoN
Cg==

