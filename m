Return-Path: <linux-fsdevel+bounces-52374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C16F6AE2744
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jun 2025 05:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7051BC3218
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jun 2025 03:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9771684A4;
	Sat, 21 Jun 2025 03:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="GeZGRjth"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692D82F24;
	Sat, 21 Jun 2025 03:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750477811; cv=fail; b=ogHGSsy4ktXkf4jnsjI6Y3VaORo8jw1vYI8MkYlQNcx5r3JmuzQgSMjTXBvGgc6J6gyp5SK+YUk/txae8qsbsCeWDZSD4PuMmc13S9Vw/z8ueC/E3JXpxb86QkkDnWMMeyhDqd3pHIHe4U89/+pDYodWdvtwd0FphanRuHVRazI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750477811; c=relaxed/simple;
	bh=Mp2gKvPteKnWLcQkgo2zKbnBidDfWgzHFaIXAn0tg3k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZzC8XcSvEj1+HBdyBe6ChLraVC7BpJVsx/maL73LqKs2WVFJ3TOsafLu+1j/T6erKbyPTnQnl9zk5NNefTD6rFnCXcsjUPhjyrPI54tEh/4ZS2Ujj4jOKjLN3TmpSvHKhaCgyrB43LkbAh6Q/EKrbGfBBjzC7aIxdqCljvlyZY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GeZGRjth; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55KNZdv3028292;
	Fri, 20 Jun 2025 20:50:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=Mp2gKvPteKnWLcQkgo2zKbnBidDfWgzHFaIXAn0tg3k=; b=
	GeZGRjthjpL4FAy1If6VJF92YCaBjwgc5QrhCJcU/GACMI482tt4rhjx7tdnwo9j
	QQQ57U2VfKxd47SAPfFLZrZh+V8qQ/DzkzHKkf7q6cyZxzN+NAoXGE7kRmV8YtII
	bnguoPEJNBMO6JDL7HY841ueiOpSpQBOybBMpirjnyJwhRNfusbxOjljYrohbaFG
	+M06f7z/j83u4ns81/5fVm90DdwpsP8lEW4QOXc/o3jeFtR59Yi6W/D3veqzNp+q
	KUXjIrHHHLuHBYoJd0Cm+kvu4UBiu/cniGrnQV1tUJljCypzSsAXHc+kX+Vp0THk
	umyALC9JogyYKyeLC/P2Gw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47dhep0u9c-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 20:50:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jacsr4mKutc3ExPRB2Uw7GrVA2WoRNG+PHTb5yM/7HN5CiJNkggDs3D75bGly1GKO1U5UAMi0WfuyU8I2S0DNwUfSTag1FqRjHgkzHPmcmInL90ASpWUiZqcaV1EZHlrqguFyjmAPQpm1hJQBQgRjprOdMviH9SeDs0YUI+mcUliri5IRmeFQMhceyrHpQKkM4ZK755sQfDVlQfCSnq+2E0WMHQAPn0byBcYdJK/1ehi5YjtLPREVrJ4PvFOB5zwqjxUmqMaWblEB6dpWA+mu1mJxFXl/GNjZ67lOrU1wJPfZYQcf2cP5ed3rm0AjimcdhvdAAvZA3WN3JHZgM79Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mp2gKvPteKnWLcQkgo2zKbnBidDfWgzHFaIXAn0tg3k=;
 b=vvQgGZwzkh/6RHFLI2AoxH2AaRshlzcb3P9AIsYHSCO+MEOM8x2Rp4HlELpDHvkxW+b4xTIFNbvs9QisV7HVHll1EQK8E/uTAHJhEl2RrwcgTdG/dryaVf5bWUnpi1wcXHSORGcgdBfTCNnV0YQ9fkGdseWckTuQxwCm2aF0SB3Kgqs4PeBE1XKKbIkLnTOSx6B1Z9PmARrdLHQH5fkf1n8P3tdDwAdD/Xe8A58bzqsoNBXjIYCNQSI88i1TGC3cGcaTgozoV77Auk+s/ndQPJNvTy551r5SJ+04cHq1nXfr+2LJ/9IaKnkZ8NutU1toiUuHzlkkWE9dC4z6B6HkVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by IA0PPFADA182A99.namprd15.prod.outlook.com (2603:10b6:20f:fc04::b3f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Sat, 21 Jun
 2025 03:50:05 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%6]) with mapi id 15.20.8857.025; Sat, 21 Jun 2025
 03:50:04 +0000
From: Song Liu <songliubraving@meta.com>
To: Tejun Heo <tj@kernel.org>
CC: Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
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
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "daan.j.demeyer@gmail.com" <daan.j.demeyer@gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/5] bpf: Introduce bpf_cgroup_read_xattr to
 read xattr of cgroup's node
Thread-Topic: [PATCH v2 bpf-next 2/5] bpf: Introduce bpf_cgroup_read_xattr to
 read xattr of cgroup's node
Thread-Index: AQHb4WXIozQeLObkI0KsSrpwjBLGObQM6hGAgAASOwA=
Date: Sat, 21 Jun 2025 03:50:04 +0000
Message-ID: <B63E92E2-8F9F-4754-B76E-BF60E6FFF58F@meta.com>
References: <20250619220114.3956120-1-song@kernel.org>
 <20250619220114.3956120-3-song@kernel.org> <aFYcl8KQU9upkZ0f@slm.duckdns.org>
In-Reply-To: <aFYcl8KQU9upkZ0f@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|IA0PPFADA182A99:EE_
x-ms-office365-filtering-correlation-id: 6d5cff41-4fb0-4d51-26fb-08ddb076b530
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?czY3c0VDMHMrbW0vckJzbVBjREgwd2hpSG1UV3NNeS9IaWFnUUlhSmhoYnoz?=
 =?utf-8?B?ME5zYVlrcVE0UHpZbWFSVis2NWRKTDN3N2ZnY3BtZDhLTjhMYzdIUWtveVRm?=
 =?utf-8?B?bkFLZzJ4TmZ6OVRZT0JBaG9VVnJMdkp6S1JtNjRiRXFCNUxVZnNJZU5JcTFE?=
 =?utf-8?B?c1N0eWFKMUUwRlZNTzRjaUl3TDE1NkkyU1ZQQ3F0ZDMzMUpIM3pPU24zMXN5?=
 =?utf-8?B?MFVibVlrQVAzajhZeTJNSjZLeDRTNitsdHMyVU5uOVh4bjc3WTNkamNoR3lt?=
 =?utf-8?B?M2RRaDdMOGdrMnVsRVRFSnpJVGZkUmQvYWw1UDRCTHlTeHpKM0N5bm1NQVFq?=
 =?utf-8?B?VWYzcm4yRm82UGV2NFdWZkJ4cDEvNGZ5NWpYRS9RMzhtYU52Y0lSREhrMmhp?=
 =?utf-8?B?MnBvaE5iSmlZd1pRMjhCUEFtblpaakNPN3JiaVk1ZkU2em1wa01EcFJsREg5?=
 =?utf-8?B?ak16Y3Y1K2pPbyt2MGJzc0VvVCtJUTJZRGs2UTRXZ1BWcHZxMkVaZDdOMWsr?=
 =?utf-8?B?VTFZQmtDVFNxdkhzMFI3dGYzcDVabU53RW1wN2ZGZ2RBR3VmQlVmWjJzVWpQ?=
 =?utf-8?B?NVpzUWRJdFphR0tQT1dKZlE4T3czQ0Nyd0NkWk5jeU9yblJGSjlycDB5QzBV?=
 =?utf-8?B?Z2hlUlJVR1VNcFBPMlFJOEl5bWR1VkdQK0wzK1NVTk1uL1grMC9SQzR1Ni9t?=
 =?utf-8?B?WnZXSlNPSzdlbEF6Q0FkOHg3MWZKQ1RQWkxRMTlCeEU0a0ZDV0VTdmNHUXV3?=
 =?utf-8?B?M2hOVTVMalBKQnlsRFFoa2V6Y3A4bFg5NXQ1SzQwdFZVRHNzQ01iOWU3Q0VC?=
 =?utf-8?B?aHFpdS83bTRrdC81R3A2U0VhRFpyWWRwZTZMdUtodWJzMENTZm9sM1JrNUdO?=
 =?utf-8?B?WTVBWFRVWVdIMUUreUI5ZmNSL3ZJK0VBTFg0M0NsaXR6dm5qZWFmU2I2aDlq?=
 =?utf-8?B?TWdUV3kxSnE0b2xjM1NqSDNWMFFscUovTmdEdHNPY3N0cHBuWGNneTFmd2Nl?=
 =?utf-8?B?RVVTbmRzTWNudnJlZlpyZDc3YVpMZ0hrYzVPYWlhU2w3ZVQvd1BQLzdSSDJQ?=
 =?utf-8?B?a0M2ditXWlc1SUVzaHozRHhEaG5qdENqTFp1TUQzMXFJbXdpUkdjSytlZUVp?=
 =?utf-8?B?dGVwMnZIRFpVQm5MQlp5TXJIVUtLdjFuSGhOSHB4Z2VSREhVdXpGRjBnUzhS?=
 =?utf-8?B?SmVvZ1p4VWMzblFxVmlzSlZ4QWp0RzlobW4rOG5ja0VPcFRmd0l4cWhOTFJP?=
 =?utf-8?B?b1RlYlZld21QQy9abXRkRldZV3pYK3MwL1hka3JzdENHcmxoZEdUZE5FYmky?=
 =?utf-8?B?clRqZ3JwQy9WYXlzSFAwRUhiWmltUjBrWDd0cVVJYTB3L1VFeTZzNHpOWDlj?=
 =?utf-8?B?UnhWd0FFUmRwQUcxU3cvSUNQaXJFcDNkbmR4MWxsOERUTzh4d1dLWjV6bzJQ?=
 =?utf-8?B?U0RaTFY5SGQ4aEF2NW13L3dZcFA2UVV6WTAvdERIK01MSitqZVFjNWJ3ZEJx?=
 =?utf-8?B?UWp1RjU1MklXUGIxbGxHSWs4V3FzVWdGK1pUY0lrWlpBTGVuZVBJQmZnME5O?=
 =?utf-8?B?NmxhNlF1cDhMWWNqMmdzc251RmVFbUl2bndhQm1DT2JuUGZCclBuNm93NlRv?=
 =?utf-8?B?UkJUazRmekRkOWIrQVVJNUpzalp6dXkwSlAwZHRKbzJ1RHBrMmtVTEFNeit0?=
 =?utf-8?B?MEpkU2lkZmRjWG4wdE5wcmk1U2gzd25tNlJ0UTA0T0x2Y1RWTVM3OVdNNy9s?=
 =?utf-8?B?VThxRHllWkRTN2lrUVFmR3RoNW5pRnJzeUlpZ1lpcHBRRGU5UDVBK2J1b2Jy?=
 =?utf-8?B?UmhSa3JiN04wVTVkVUxKVVlaMkMrZnN6aVhtNVd5eGF0dU5Tb01CWUpPZmF1?=
 =?utf-8?B?eFZoUHpZckZoa1ZEUlJyOCtaUjJySUFnWkl6Rks0Q3RFcERTTTByTHhYLy9H?=
 =?utf-8?B?eHdJRkpMMUEyZEVZUFJjcGI2cHdsc2V0OVIraHZGZ1Bqdm1nVklHendjZzdJ?=
 =?utf-8?Q?zEGGSUGjP5gujE26oexQ+KirZ8wPww=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXk5RkthTmNJYWhqVDU3c0JjS3R2Sy8xVFRmbmdRczJKeDVkQ0Fad1FRL0sx?=
 =?utf-8?B?UTFEak40bDR1U0tSbzY5MDVFUjRDTTIwaFVDOGRud056NU9FRnFpU2tDdEQ0?=
 =?utf-8?B?MmJEWGM3SjgzVzdUSFAxOHNxcVRCckNJNjdrRUNXTnFBSDBHSzFmN21QTTdh?=
 =?utf-8?B?aDVLTWVaWDlKYUtDeEM1Z2dDUzhxdmZrVmE1c0UxK29tWW1pS0JlbndmbnhY?=
 =?utf-8?B?UFREYmFqK3duQUJkeUlmT0NWLzRYcXNQRUFSalJITitJZDlLZkM3WTJhcGs4?=
 =?utf-8?B?OWJERVl6dFlhNWo3MVpPUExHT3dJS2YzSGNSY2dMNHBEbWlOb2R3WTFlbnZY?=
 =?utf-8?B?NDlqbWE3Skcrb3l3K3lyNkh3dXpIWlNESVF3TVpjZnE0b2hVRE9MZCtMMEl3?=
 =?utf-8?B?M0JjanJyRm10WXcwUTZBd1M2MW92Vnp6enIwQXkzeXY0cnZLak0xNDhGNXNq?=
 =?utf-8?B?STlnMXQxWUxQcXRKb0FjTmhBY0Zaem1ncDgwTE5aRkd2VE1WY0ZYeld0UmNQ?=
 =?utf-8?B?V2ZaRksyWGdxQkhjM1l1NmtPc2RuMDBjTWtGbGdOYnp2WUxVKzRGTFVZcXZK?=
 =?utf-8?B?NFdWU0szNGN0QzhKWjBpVkd0TlhzVERJWHRuRkFZbVMxbTUraDlJdUhSV0pj?=
 =?utf-8?B?TEVZSmkyTzBjYXFUOXUybm1TOGc0cW5TeTBKTFFmak5EWjVHWnJiWmxubXFY?=
 =?utf-8?B?d1ZHb0VTeTV1U2lBNWFIT2M4T0UyNEp0QjNSQmNCTEhGcUNhNlBqUyt6MkRh?=
 =?utf-8?B?U0dRaEFSZnIwbmZ1TGUzOUhDNy9acUxtTU5oeEtmaEd6K0FVUWNMWmQrWXFS?=
 =?utf-8?B?UHpEaWN5ZFdmTTh6ME85NmpjaCtYVXRKU05IMk5qSjRGNmM0ZTJFcDJka29k?=
 =?utf-8?B?L0pKbW12eTByR2tRR0VvbjNXcStBeUk0QnBTeTE4TllCVWlzazY1NXI2TGJy?=
 =?utf-8?B?U0tpYzN4dTFXdnlJdXhuNm5IUU5sN1VuOUtsRXhiYnlLZjc3ZW9rckF0RFdo?=
 =?utf-8?B?ZGdsMzFyUDBrZUdyWkY5SUhCejRVVXZtdkxreVM5bGFPTUNkOGxCN2lNamR4?=
 =?utf-8?B?UWZtS0UwLzJMQUFuNWFJbURYZGJwQm9zbjNwc0toNnB0K0pqeUdqS0duUGxx?=
 =?utf-8?B?blc5dzV3L29COW0vU2VzZHlLSlBhaHhlK2pUMm42d2Jrc3M0Q3VXYXNtdlpM?=
 =?utf-8?B?eUVFMDlIYjE5M3lVaUxHd2V4U3lYcXdqd2tJUEN6cFlrYk53ZTZleUE0T3hE?=
 =?utf-8?B?YzZnQ0U5emFmWmI5cW14M1VrcjJndnh6cS94SVczZ092aFRPZ3o4aVkwRTR1?=
 =?utf-8?B?R1Jid1gxdDl6eFZNenJ6SHlLV0NjZnBwK01nZW5RZ0ZBWDRvTHVDSmkvMHZo?=
 =?utf-8?B?ajk0TGFPZEdXaERrZk9MQ0dIR0hPVUpjQkdKZTJwL1ZPdk84SU9lYTdJT1kz?=
 =?utf-8?B?QVhxWUlCMzVHcGlmTlFjaTNYYVJJajlELzZLakJXd2NHT1NFZ1p0MXAwMVFX?=
 =?utf-8?B?MWhTNWQwdVR6VjVpdXh0TXFkcnd1M3pKV0J6T2JmVUUxdHEzcmpjcUpWRTgw?=
 =?utf-8?B?UzVSNTh5SVU2dnVoRW52RklTc0NrYis3M21KVFBpMWsxemJFV01UZ1E0OENZ?=
 =?utf-8?B?cGI5TU9DYXlQZVVjek1jTjltVjNOdzZhS0Qra0l6bVhvRTczZW4zckFkaCtv?=
 =?utf-8?B?Q0xIQjE1dzdrMmVpbHN4TElkNk12TnZqSTNBangyZDB2ckZBRTBpb3BxSTU3?=
 =?utf-8?B?bDNUOGlMckNIeGpjOTdhRXdaZjllVWhtVW1pdUV6ZStseEFjWnNteTcvT0pv?=
 =?utf-8?B?VGJvZnFwUkpnZWtzYWJ6UjJrOXRTdDh5d1lZZ0doRmgzalNsUFNkWU44NEVS?=
 =?utf-8?B?cXd1YjhWdWowRitSRnFLNWQySXBSMHdBQ0h4cThIMzU3UmlvREJZcUtNZzhK?=
 =?utf-8?B?QjJIbFdXeUFiZFE2TFptb2owWUhOaWxrK2lRa1RlV3VROEdxaVpNQ1dLT2hV?=
 =?utf-8?B?S2NqTHdCSW1WMFR2aTVaSlZyOHROT2pQbUFwUzJYV3B1TUhYbEtBOFNxbXdC?=
 =?utf-8?B?ZmRPb2Zsc1grM0ZLRk5JUlRCY2p5MXYrV3dVTUxrYS9MT1lmRmFNTHovZkVq?=
 =?utf-8?B?VGRMbEZLSjNSeEU4U0M1UWdFZVIvVHQyYjZUWmJIcVNEMUw1Q0hicEJRTXd6?=
 =?utf-8?B?b3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A471DB16382B794B8F4D40DCF27EF880@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5cff41-4fb0-4d51-26fb-08ddb076b530
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2025 03:50:04.8527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yGhBj+pKZ1d+rgHYVy6FQUckXPVOk8LMetv9vpd7MRs7GEUevNZj3m6cG4ENuDRWcUMR/Do/hxb78aKwbYVufg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFADA182A99
X-Proofpoint-GUID: zd1kjnP_k5uQkBy1yjFefh0XK9BNT7uM
X-Authority-Analysis: v=2.4 cv=Z9rsHGRA c=1 sm=1 tr=0 ts=68562bf0 cx=c_pps a=odKRFmi9eIpulnRHbmfacw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=Ki1OgoCsB6REUwstdq0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIxMDAxNyBTYWx0ZWRfX6pTMDmURX5jm IGSF1amAun3GK5V1/ZYW0rNLsGdHZ/IF5+FOhGhWcbTCFZEf8BplZ2X4lH37CfPK82NqSe8QNTo C6U+fYUMsQ5VY4Gs2RSJhoglTm083DVXxBkHB5MuIa5/vNIO8cGA+O9Jm8m/b9TlU/Z89VuPOC7
 Kc7CdSo7ASVNiOb+G1itPsSTkMWB/U8lkwTVs4T0p/V1IjqzjodDwbSOU2mfPmA8lki5QHjH898 WndS1b95kzjxeeaUta4YFIc18E8rQXoUmU4MKYSOzvKEeHz5utSPUc+8dPqwzTJxWotk9rdRslU qj92rIgkrqCwVBWbwX7+zfHFwX6b+2+qRZJVL6+4ZNdAhnncaBifrJpolzxRHQkAsDZ4Qklfh+p
 1b8D3VyDO/HHrvVylk8mQqu0xwnwWWRQ8pERgcHEn57DwGfK0v4FmkJeI0TWhFPG7ZbQS51O
X-Proofpoint-ORIG-GUID: zd1kjnP_k5uQkBy1yjFefh0XK9BNT7uM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-21_01,2025-06-20_01,2025-03-28_01

DQoNCj4gT24gSnVuIDIwLCAyMDI1LCBhdCA3OjQ04oCvUE0sIFRlanVuIEhlbyA8dGpAa2VybmVs
Lm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIEp1biAxOSwgMjAyNSBhdCAwMzowMToxMVBNIC0w
NzAwLCBTb25nIExpdSB3cm90ZToNCj4+IEJQRiBwcm9ncmFtcywgc3VjaCBhcyBMU00gYW5kIHNj
aGVkX2V4dCwgd291bGQgYmVuZWZpdCBmcm9tIHRhZ3Mgb24NCj4+IGNncm91cHMuIE9uZSBjb21t
b24gcHJhY3RpY2UgdG8gYXBwbHkgc3VjaCB0YWdzIGlzIHRvIHNldCB4YXR0cnMgb24NCj4+IGNn
cm91cGZzIGZvbGRlcnMuDQo+PiANCj4+IEludHJvZHVjZSBrZnVuYyBicGZfY2dyb3VwX3JlYWRf
eGF0dHIsIHdoaWNoIGFsbG93cyByZWFkaW5nIGNncm91cCdzDQo+PiB4YXR0ci4NCj4+IA0KPj4g
Tm90ZSB0aGF0LCB3ZSBhbHJlYWR5IGhhdmUgYnBmX2dldF9bZmlsZXxkZW50cnldX3hhdHRyLiBI
b3dldmVyLCB0aGVzZQ0KPj4gdHdvIEFQSXMgYXJlIG5vdCBpZGVhbCBmb3IgcmVhZGluZyBjZ3Jv
dXBmcyB4YXR0cnMsIGJlY2F1c2U6DQo+PiANCj4+ICAxKSBUaGVzZSB0d28gQVBJcyBvbmx5IHdv
cmtzIGluIHNsZWVwYWJsZSBjb250ZXh0czsNCj4+ICAyKSBUaGVyZSBpcyBubyBrZnVuYyB0aGF0
IG1hdGNoZXMgY3VycmVudCBjZ3JvdXAgdG8gY2dyb3VwZnMgZGVudHJ5Lg0KPj4gDQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBTb25nIExpdSA8c29uZ0BrZXJuZWwub3JnPg0KPiAuLi4NCj4+ICtfX2JwZl9r
ZnVuYyBpbnQgYnBmX2Nncm91cF9yZWFkX3hhdHRyKHN0cnVjdCBjZ3JvdXAgKmNncm91cCwgY29u
c3QgY2hhciAqbmFtZV9fc3RyLA0KPj4gKyBzdHJ1Y3QgYnBmX2R5bnB0ciAqdmFsdWVfcCkNCj4+
ICt7DQo+PiArIHN0cnVjdCBicGZfZHlucHRyX2tlcm4gKnZhbHVlX3B0ciA9IChzdHJ1Y3QgYnBm
X2R5bnB0cl9rZXJuICopdmFsdWVfcDsNCj4+ICsgdTMyIHZhbHVlX2xlbjsNCj4+ICsgdm9pZCAq
dmFsdWU7DQo+PiArDQo+PiArIC8qIE9ubHkgYWxsb3cgcmVhZGluZyAidXNlci4qIiB4YXR0cnMg
Ki8NCj4+ICsgaWYgKHN0cm5jbXAobmFtZV9fc3RyLCBYQVRUUl9VU0VSX1BSRUZJWCwgWEFUVFJf
VVNFUl9QUkVGSVhfTEVOKSkNCj4+ICsgcmV0dXJuIC1FUEVSTTsNCj4gDQo+IEp1c3Qgb3V0IG9m
IGN1cmlvc2l0eSwgd2hhdCBzZWN1cml0eSBob2xlcyBhcmUgdGhlcmUgaWYgd2UgYWxsb3cgQlBG
DQo+IHByb2dyYW1zIHRvIHJlYWQgb3RoZXIgeGF0dHJzPyBHaXZlbiBob3cgcHJpdmlsZWRnZWQg
QlBGIHByb2dyYW1zIGFscmVhZHkNCj4gYXJlLCBkb2VzIHRoaXMgbWFrZSBtZWFuaW5nZnVsIGRp
ZmZlcmVuY2U/DQoNClRoZXJlIGFyZSBzb21lIHhhdHRlcnMgdGhhdCB3ZSBzaG91bGRu4oCZdCBy
ZWFkLCBmb3IgZXhhbXBsZSwgb3RoZXIgDQpzZWN1cml0eS4qIHhhdHRycyAoc2VjdXJpdHkuc2Vs
aW51eCBldGMuKS4gDQoNCldlIGNhbiBwcm9iYWJseSBhbGxvdyBCUEYgTFNNIHByb2dyYW1zIHRv
IHJlYWQgc2VjdXJpdHkuYnBmLiogeGF0dHJzLCANCm9uIGNncm91cCBub2RlcywganVzdCBsaWtl
IGJwZl9nZXRfW2ZpbGV8ZGVudHJ5XV94YXR0ci4gQnV0IHRoYXQgDQpyZXF1aXJlcyBzb21lIGV4
dHJhIGxvZ2ljLiANCg0KVGhhbmtzLA0KU29uZw0KDQo=

