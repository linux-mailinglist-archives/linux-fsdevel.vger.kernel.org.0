Return-Path: <linux-fsdevel+bounces-35475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A3E9D5283
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 19:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E30D1F23ACF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 18:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5081C3302;
	Thu, 21 Nov 2024 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="fqYopySy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374271A01D4;
	Thu, 21 Nov 2024 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732213724; cv=fail; b=G9zO4XF6sqR7L55FYDlK21YDZaGHajTepiDzDrRHQFqYJIJipuszUmK9lyNN+sgIwmKb3r/Jz3xRF0kfN4U91tUk5cT/1xxFY8hvIriRaTmiYGPOE+ofVUIoBeNIZnG+tDrX4IgfJhcCpoaAwrpI5+REgor4x4/byjUoeQJVVEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732213724; c=relaxed/simple;
	bh=WLl5jCXJA7jOxpVGJw4AqvdWzca2je1SUl+oQ9DxUrs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jOSlijGkr3mMoUsbUj+6VsQTWGltV2IklBx6FByIxmgnM6fQtDDKRV85PEm9zXcnLcNHs/E9kDdrq3NNhw8OKxUkK0Q7Kytp7RrR5PyVf4fiIyfiFSe4UG1Zwc0gfVoXnwSyf71uZWjmNwb2Lhjhhs2iSqoRMAG4aH0m5DrTrZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=fqYopySy; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4ALDZT3p007171;
	Thu, 21 Nov 2024 10:28:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=WLl5jCXJA7jOxpVGJw4AqvdWzca2je1SUl+oQ9DxUrs=; b=
	fqYopySyMqqTFbILBNzPFJvvloPozk45xGgQqbj/A2Jh9AhP/XD6IHmI+yIec001
	5vsJ9np47Hu/rCOe1l0WkODTYbO9ZBSaR98+/9pF0AXOcYSy7Hz/7sKoW5cOhwca
	stGKmWsUp6bLRbNsiWHi9rVcgx8nSa/ZnerqoF2uTK5IdxsdO9L1fxf71WpDMEhF
	hVSnZmGWis8WFq747zhFp1jmAja6sYNQrKBPQtmk0L3StDZLofeE/Dn1pDHlKv2B
	oO4tsExqI74XNXTw6frIo6Ya/2pimPx2JbiNpj/47+HlSJkryQ9UaeofAjm08qIL
	apFtwlZ8WDxZH0DiwXmcPw==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by m0089730.ppops.net (PPS) with ESMTPS id 4325vej98w-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 10:28:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIxEHE/Xh4HAwxMJtEL9OX0lQFhzhb2Cchktg2rlBqhztw7F2qf0ssSZaorP9w63QwvFPAC+5rIP3GmvagLEF3sK1wg2Awqc9OYLJgoAm3ZPt0DyX2vtDka8pfM+n/lK5wKjfEeAXPEdX2Zk6lsIcX08CnWOXu/WcTvfIxXYw7ZccXbHHwTCIv+g24nLYGurgFizyldvG4z9ZaqUG15JdvcLmO5OWmRDi0Y95CTqtmD0uYMlY60V6HUPYCK23gzMq2ohfxTeFFFlZGNuVW7yZlcFQSY0EosM5i+b+yQiJhYgrC+XznE6p2OOAQbRO9f6uv7l6A0ZIfF3dZHv6ZWYhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLl5jCXJA7jOxpVGJw4AqvdWzca2je1SUl+oQ9DxUrs=;
 b=gaCoPvGXMoQiNqmRncfJiSCAJpttEDkIyvElKLQmiYVaYlcFLycYjh84j40ARksK0Y5yFeaBN02Jz475dag8j030y20ALST+rbQ6RyJBXuNiQj8xSHRDWKZvJStTwjRWAkxLLzPHMIxbGv7KGU4s66QmzNkCtFc5qvbQwHMQtTQcKdULkpCn4keX6Ld5Rz5rMoAxyM5OTHG4y5Mv09mZ9hcNrXHWfTgethoEY/RUi/c/sM0OrDpaTuHDU4dc1ngpbewdn0Z/xvY/IpCkgVXNZ/NO+xwQ4rt3GPIE5m5XgReWRibf8hsdb9WHrEydIEuFcwqqmKzs7p++VBn5lz/lCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB5117.namprd15.prod.outlook.com (2603:10b6:510:c4::8)
 by DS0PR15MB6360.namprd15.prod.outlook.com (2603:10b6:8:fb::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.24; Thu, 21 Nov 2024 18:28:35 +0000
Received: from PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::90bf:29eb:b07e:94d9]) by PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::90bf:29eb:b07e:94d9%6]) with mapi id 15.20.8182.013; Thu, 21 Nov 2024
 18:28:35 +0000
From: Song Liu <songliubraving@meta.com>
To: Casey Schaufler <casey@schaufler-ca.com>
CC: Song Liu <songliubraving@meta.com>, "Dr. Greg" <greg@enjellic.com>,
        James
 Bottomley <James.Bottomley@HansenPartnership.com>,
        "jack@suse.cz"
	<jack@suse.cz>,
        "brauner@kernel.org" <brauner@kernel.org>, Song Liu
	<song@kernel.org>,
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
 AQHbNNyP/8kz7bh9sEuMXmmPH8p6e7Kz8jgAgAAJuQCAAGvfgIAAB6yAgAEUSoCAAA4qgIABaxuAgAAOzICAAAqvgIAAPekAgATKdQCAAnQTAIAAYQ+AgAF79oCAAQTRgIAAnGQAgAALYgA=
Date: Thu, 21 Nov 2024 18:28:35 +0000
Message-ID: <706568C6-43DB-4CEF-8BD8-A46BC3E5AC9C@fb.com>
References: <332BDB30-BCDC-4F24-BB8C-DD29D5003426@fb.com>
 <8c86c2b4-cd23-42e0-9eb6-2c8f7a4cbcd4@schaufler-ca.com>
 <CAPhsuW5zDzUp7eSut9vekzH7WZHpk38fKHmFVRTMiBbeW10_SQ@mail.gmail.com>
 <20241114163641.GA8697@wind.enjellic.com>
 <53a3601e-0999-4603-b69f-7bed39d4d89a@schaufler-ca.com>
 <4BF6D271-51D5-4768-A460-0853ABC5602D@fb.com>
 <b1e82da8daa1c372e4678b1984ac942c98db998d.camel@HansenPartnership.com>
 <A7017094-1A0C-42C8-BE9D-7352D2200ECC@fb.com>
 <20241119122706.GA19220@wind.enjellic.com>
 <561687f7-b7f3-4d56-a54c-944c52ed18b7@schaufler-ca.com>
 <20241120165425.GA1723@wind.enjellic.com>
 <28FEFAE6-ABEE-454C-AF59-8491FAB08E77@fb.com>
 <9d020786-fca5-4e96-9384-fa1fc50bfa44@schaufler-ca.com>
In-Reply-To: <9d020786-fca5-4e96-9384-fa1fc50bfa44@schaufler-ca.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB5117:EE_|DS0PR15MB6360:EE_
x-ms-office365-filtering-correlation-id: 8d53b2cd-55bc-470d-472e-08dd0a5a4f5e
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bGMrcDJpYTBLQ0ZMb3d2T1I3WmVjcU9lcjRLZVlxN0JFQ0hNbWU3ME80bVF3?=
 =?utf-8?B?QnFPR1FQZnoyb2t0c3dXdHRVZDliZjBxQmkyRXBzUW1iRnh4NEVHdW9SeGhX?=
 =?utf-8?B?dXpOOUE2d0lKZVE3Z2ZVcTNmQXVwN1dKaHh0TlpDVEwyYWJYY290WjExL0kr?=
 =?utf-8?B?SlN2VXh5R0VLL1F4akxuOWc3ak5IcHE1TFhiY1NDM3JlMlBla0drcjViaWds?=
 =?utf-8?B?ZHNnTlVibGljSHhCZ2tBTUVwQ0lBSEtNdDMzMkNYYXFaY1I2bUNlNDNZL09H?=
 =?utf-8?B?dG5oMW43TkdTUlErTyt2bFIvNjdXMEdOOVdqSitsWlNiVU1LaDJjUTd6M0tS?=
 =?utf-8?B?bWJkdXNXVEZicWY0TmdZRXhvNG5KRGlpM2R1MjZONVV1UVFldlpSZzJKTkdK?=
 =?utf-8?B?U2lmMkpuSTB1TnBmYmhkM1NUMTZwQVV4WjhtazhSMFBxeFkraWI1UjBwTWtH?=
 =?utf-8?B?bHdMczdwVVZaV0xtd1NwZEh5YXpOZVMxbndTU20xekdiNjhqaWp2ZGRlWDlh?=
 =?utf-8?B?a0tKOElLYjN4bmY5YS9pMTRIRTZZT1crd3htK2VvSEk1KzZBUkRFRlF0VHJW?=
 =?utf-8?B?M3JEM1dvUFRKTzQwQUh2MmRKZHRFVWE5K0I0U1gxbWt3anBoVUNZL2ZzL3dC?=
 =?utf-8?B?RjZERkxvYk5KcSthczh0OGtlMmpSWkM0SzZOMzVsTmZDVDgyemw1M3dCbjNQ?=
 =?utf-8?B?VTQxbFVsZmhjNlFlN2RCeXkyQlN1SUVZWEVUZUg1WkU0Z0w3bG1jRDJFTFg4?=
 =?utf-8?B?WWJaNHF1WVo4U1NDSlBZdWRTazZIek9GeXZLcVJkWW5SZjIrNU45aHhlT3hq?=
 =?utf-8?B?aWhJVDAzVVFVaHZXODl2M3ZuMEdmTXEvYkpaWUdZSjZadnV4OGNGSjlNSWpv?=
 =?utf-8?B?RVZMQldBd25mcjJFbmxRWVhobGtGNEMybzdiU2xJYStNdm5GdGNrYzBDSHN1?=
 =?utf-8?B?QXA4U3ovRUpKMmZ6UTErMkFWRmhqVUUzTTNEcncyQ1I3b3NIRm5HZWZVYkov?=
 =?utf-8?B?SjNmUGdLamtzSEo4VWo2bWp1cTdKTWVRTWlqaXNtOUVqbEVnSXU4TGZwSFhW?=
 =?utf-8?B?a091dW4xek1ZaFJMQkkxU2s1am8zZjlrQnFDR1pXSldnWVh4L3pXNWNicWEz?=
 =?utf-8?B?Zkp3eFRzMHZrK0JKamMyNnpsQlROQnBFbnBaTk1OeGVBTEtCSmxBMzZ3VEhy?=
 =?utf-8?B?VzdheW9vQVd1Zlk1QnFwdGpzNFVKRHZ2V0Z6SGFka2plK09XbDBHNHRodUFB?=
 =?utf-8?B?UkMrek52SzlYbm5Xc3NPUlJicTVYVnlTeEM5WnpTb05Ma09tUER0K2F1UFpE?=
 =?utf-8?B?c2FFWmE1NHVoTWdPdkpPSnV5Y0tDQkZ4V2xicDhhblVhYzVJVGgva1hYanpm?=
 =?utf-8?B?eU9ndlNpSWVOL1puMnVsa3BNZnozUHRpc0gvZ1VyZnlMc3JzZEFid21oZWZ2?=
 =?utf-8?B?VE1URWlIeGR3N2liOEdhdUxtTDZEak43OGJha3BhWVFPeVVIZkhhdmoyNWNi?=
 =?utf-8?B?Y2hsdGhNVDdJMG5ER3oveXladTJMcFBsa1VrRGx3ZTBnY050QTI0anl4RWJ0?=
 =?utf-8?B?R2tXQTN5Q0hrb3pEN1Zzako4RUpaeFY3Q09lK2xqczFNTnBaOE5VSHIvNzRI?=
 =?utf-8?B?MldnYit1aDZOemptYS9zYTM5RU02Z0xuV0pReWxFL2ppUjBoNE9DeW9XMEl0?=
 =?utf-8?B?Znh0amUzWGRyOUczVzR3S3JTa1FxS2NmT0k3VXlVaTFOdUVGY29PUnBTUjYw?=
 =?utf-8?B?ZjhQTEM5aUlwZHYvTEFrT042N09WQjdNZEpKa3YrR0taZzhmUWV3dVF1b2Fn?=
 =?utf-8?Q?HMhAQDz8iDq73Q0HyuxBh+XY5iYwfPRm0TwJc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5117.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cnhzclNGbGR3N3FGWGxFZ1lFNjRqbG5rM2I0M2xwbWdBNnJaTjZaVWMwQ3JF?=
 =?utf-8?B?VmhuVlhOYlBLVHJpU2pQS2ZUS0lacnRBR3gwRjM3U0NLcCtkN1IwTndqeGZk?=
 =?utf-8?B?OVd6SkM3allKSFBFYlhzMS8zN0RZN2xiUnhLNTJRREl4V1ZXanpwR1lVQ0I0?=
 =?utf-8?B?RHZQSElxSy9QTUlEYVJuVTF1QlAvNHBCdkFEc2gvNXg0Vm5xbC9hR0xmekkr?=
 =?utf-8?B?dW1nUFdnS2JnTTRmdVc3dVh5SW1ZOVdzWHY3ZnB3S3dHSWY5a0FWRUNiOUpk?=
 =?utf-8?B?YlUxOHlzSGlKREhXa3dHYUtMcXJ0MC9LRnQ0TS9RSTFqNGFWUHl3UVBGcXdQ?=
 =?utf-8?B?SVZMdm9IRXBkYTdXVlRiMk5oR0Z0amJPWWZIdWhob1ZSUmcraXhJUGdCQjBh?=
 =?utf-8?B?M1p6TDZKaEM3Zy95VExUM01UVzVVcUNOU1VnbXNaREwwaVZtbmVNbklLNldx?=
 =?utf-8?B?SVlQY3pydnpYc0c0Z3A5eGgwTHJ3eVZPTjR4YmNPa1BuN29WN2taVU5LOHg2?=
 =?utf-8?B?NDUvbmFtbUplMUZWc0Z3RzBocmtLZHRQcFRZUkJuMlh6RVRYV0tYak9RWCs0?=
 =?utf-8?B?WjRyZVVjZGhMTjhHd2FjRnhRNFN0azBWdXdJb0xyU2RyMzBJSG9FaWdSUk5V?=
 =?utf-8?B?akU1cW5NcnlJY1QvY3p0RGJ5NDc5RTg0UTBBVjhENFFGTUNEelNNNUpEekxB?=
 =?utf-8?B?ekVuYWlUTmdRSGRHd3l2Q0RTTVBGWHAwV21EWVdHSGZ1MEw5bW5hVXFmYWFQ?=
 =?utf-8?B?Q0E2R3FRNSs2WVJZekxCN2pROERRLzlUbUNTNGN5M2MvT1NrNEdzbkRLTUhz?=
 =?utf-8?B?REtkSmIrRUQrU1NOTlZPUzRsQnlxdHU5b1ZiYWFpV2Q0dDk1dFROL05ONjgx?=
 =?utf-8?B?RHIyM3FsTC94Szl0SUdhZHozZmgzVXhhTU5mRWVOMGduS3FkazlTb2JOVWFY?=
 =?utf-8?B?UC9YK3Y3SVA5by94RytyaVFobGM3VWwwNTFrTVRyWFhpNHBseEhBTnVIQUNX?=
 =?utf-8?B?Nkp0NThXUVBrVzhyc2VESjRKa2Q1aTAyUWpmSUROOWl5STVyd1lvaDhScWJT?=
 =?utf-8?B?eFlYMTg4dHQ1REVTT0JaV0F2STRNZzRBNDQyQlJEbHRHZHBRZ0ZRYWJiUkVh?=
 =?utf-8?B?a0RwTDlpdGRNQVY1RmV4Y0EvbGx4SUdwMXRoZHdHUHFWbzhIRTZSM0dUY0ho?=
 =?utf-8?B?dWNPcDlqZi90L01kcGxqbGhzQVBteUYvRTZTVmZyd1lBL3lFSnhqdUVXTC9Z?=
 =?utf-8?B?cXNQL0gvU3BUZTE2bWZ2aGNlVmtwbS85YkF3cktOdXJySjh1UUNkL1dIL0J2?=
 =?utf-8?B?RGpiYjFleTdGcFd3RUs0bTNxdThuL2Ird2RXc1d5YytocnIzOVVmWXhIbEYx?=
 =?utf-8?B?SEJSSHBqQXQrK0NuREVWZVM5cUczSG5uNXRPdHRDcEcyc1Y4SktjbHJnc0dr?=
 =?utf-8?B?ZHNITXhZZ0FDdlM5Y2VFTndKby90YWMzYnhTejJBSkFHSWdIT3ZPMnZLcHAr?=
 =?utf-8?B?SnFSUXE1aTV2SldhV1N3TDE5MWxUVXlPN2FsZ3g0SGZvM2R6MVFHSUlTditp?=
 =?utf-8?B?L0orUEhDK05wdlNoSGk1MVczMkhGQnFySmMxRzFCZ0FIYnRZaSs5VEQxcGNY?=
 =?utf-8?B?U3k5bkxBbnBJT2VKcFJTdDllUXJtN0RBVzBFSnRDSkd6ME1XU213a3o2Q1BS?=
 =?utf-8?B?aEJvY3VVVDdoZnF3dDRFbG5lRDM2WEFRVThLM3NxMzdEUFFuSEJRVGVWR0xw?=
 =?utf-8?B?cjVDaU44dDgwdGxOWldlaUtCR2d6bGZZaXgyZ0NsSVRMeTlLM3pNOGZsbTFt?=
 =?utf-8?B?WURPUGozNjZVNU5Jend1WnBMMGxaWjUxaEM3N0xDOE5GbU83NFhSNXRTdXZv?=
 =?utf-8?B?c3dLZzFMN01GNWJsaUJzUk5IYW9tUjhsOWhIWDhFamthdksvOFByQVFNMUk0?=
 =?utf-8?B?Si9Wb2VjZlMxc0VIb0tIc1c4b0IxNkRSOXRpbmlKaDIvOW5lajY4NVc5MzdB?=
 =?utf-8?B?bkZPemQ0c2MyRFpVVUgycGc2d3hIQjY1VGJDMWltdkp4OXR6Sld3UUpueDZY?=
 =?utf-8?B?YVZLYkp5UVhub21jS1IyWHZ1QVdQdTIzUVhyb1Q1bnhwRlVaRGczSWFUL0t6?=
 =?utf-8?B?NlFsQk5HYzlaS2xwcXZwQVZMSEJHTnUvMEZTMHVmaTBTd3Y5U0gyV2NqWUkw?=
 =?utf-8?Q?6hgEy0kG2HI8qwldS/cgjnk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04F802C70DFA304DBA784A73E4193B3D@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d53b2cd-55bc-470d-472e-08dd0a5a4f5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 18:28:35.0941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0V5UNk8QnPgaxxoqX8Pl6h0raskT07YcUMNtfrPHa7dOtJvmGN/nwe4AA9jsZrno8vkt/MpQYmo0iET9Z9lwMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6360
X-Proofpoint-ORIG-GUID: ap7Lg7mxaocgzEQpH5eu1RFWfJnH7nlm
X-Proofpoint-GUID: ap7Lg7mxaocgzEQpH5eu1RFWfJnH7nlm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gTm92IDIxLCAyMDI0LCBhdCA5OjQ34oCvQU0sIENhc2V5IFNjaGF1ZmxlciA8Y2Fz
ZXlAc2NoYXVmbGVyLWNhLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAxMS8yMS8yMDI0IDEyOjI4IEFN
LCBTb25nIExpdSB3cm90ZToNCj4+IEhpIERyLiBHcmVnLA0KPj4gDQo+PiBUaGFua3MgZm9yIHlv
dXIgaW5wdXQhDQo+PiANCj4+PiBPbiBOb3YgMjAsIDIwMjQsIGF0IDg6NTTigK9BTSwgRHIuIEdy
ZWcgPGdyZWdAZW5qZWxsaWMuY29tPiB3cm90ZToNCj4+PiANCj4+PiBPbiBUdWUsIE5vdiAxOSwg
MjAyNCBhdCAxMDoxNDoyOUFNIC0wODAwLCBDYXNleSBTY2hhdWZsZXIgd3JvdGU6DQo+PiBbLi4u
XQ0KPj4gDQo+Pj4+PiAyLikgSW1wbGVtZW50IGtleS92YWx1ZSBtYXBwaW5nIGZvciBpbm9kZSBz
cGVjaWZpYyBzdG9yYWdlLg0KPj4+Pj4gDQo+Pj4+PiBUaGUga2V5IHdvdWxkIGJlIGEgc3ViLXN5
c3RlbSBzcGVjaWZpYyBudW1lcmljIHZhbHVlIHRoYXQgcmV0dXJucyBhDQo+Pj4+PiBwb2ludGVy
IHRoZSBzdWItc3lzdGVtIHVzZXMgdG8gbWFuYWdlIGl0cyBpbm9kZSBzcGVjaWZpYyBtZW1vcnkg
Zm9yIGENCj4+Pj4+IHBhcnRpY3VsYXIgaW5vZGUuDQo+Pj4+PiANCj4+Pj4+IEEgcGFydGljaXBh
dGluZyBzdWItc3lzdGVtIGluIHR1cm4gdXNlcyBpdHMgaWRlbnRpZmllciB0byByZWdpc3RlciBh
bg0KPj4+Pj4gaW5vZGUgc3BlY2lmaWMgcG9pbnRlciBmb3IgaXRzIHN1Yi1zeXN0ZW0uDQo+Pj4+
PiANCj4+Pj4+IFRoaXMgc3RyYXRlZ3kgbG9zZXMgTygxKSBsb29rdXAgY29tcGxleGl0eSBidXQg
cmVkdWNlcyB0b3RhbCBtZW1vcnkNCj4+Pj4+IGNvbnN1bXB0aW9uIGFuZCBvbmx5IGltcG9zZXMg
bWVtb3J5IGNvc3RzIGZvciBpbm9kZXMgd2hlbiBhIHN1Yi1zeXN0ZW0NCj4+Pj4+IGRlc2lyZXMg
dG8gdXNlIGlub2RlIHNwZWNpZmljIHN0b3JhZ2UuDQo+Pj4+IFNFTGludXggYW5kIFNtYWNrIHVz
ZSBhbiBpbm9kZSBibG9iIGZvciBldmVyeSBpbm9kZS4gVGhlIHBlcmZvcm1hbmNlDQo+Pj4+IHJl
Z3Jlc3Npb24gYm9nZ2xlcyB0aGUgbWluZC4gTm90IHRvIG1lbnRpb24gdGhlIGFkZGl0aW9uYWwN
Cj4+Pj4gY29tcGxleGl0eSBvZiBtYW5hZ2luZyB0aGUgbWVtb3J5Lg0KPj4+IEkgZ3Vlc3Mgd2Ug
d291bGQgaGF2ZSB0byBtZWFzdXJlIHRoZSBwZXJmb3JtYW5jZSBpbXBhY3RzIHRvIHVuZGVyc3Rh
bmQNCj4+PiB0aGVpciBsZXZlbCBvZiBtaW5kIGJvZ2dsaW5lc3MuDQo+Pj4gDQo+Pj4gTXkgZmly
c3QgdGhvdWdodCBpcyB0aGF0IHdlIGhlYXIgYSBodWdlIGFtb3VudCBvZiBmYW5mYXJlIGFib3V0
IEJQRg0KPj4+IGJlaW5nIGEgZ2FtZSBjaGFuZ2VyIGZvciB0cmFjaW5nIGFuZCBuZXR3b3JrIG1v
bml0b3JpbmcuICBHaXZlbg0KPj4+IGN1cnJlbnQgbmV0d29ya2luZyBzcGVlZHMsIGlmIGl0cyBh
YmlsaXR5IHRvIG1hbmFnZSBzdG9yYWdlIG5lZWRlZCBmb3INCj4+PiBpdCBwdXJwb3NlcyBhcmUg
dHJ1ZWx5IGFieXNtYWwgdGhlIGluZHVzdHJ5IHdvdWxkbid0IGJlIGZpbmRpbmcgdGhlDQo+Pj4g
dGVjaG5vbG9neSB1c2VmdWwuDQo+Pj4gDQo+Pj4gQmV5b25kIHRoYXQuDQo+Pj4gDQo+Pj4gQXMg
SSBub3RlZCBhYm92ZSwgdGhlIExTTSBjb3VsZCBiZSBhbiBpbmRlcGVuZGVudCBzdWJzY3JpYmVy
LiAgVGhlDQo+Pj4gcG9pbnRlciB0byByZWdpc3RlciB3b3VsZCBjb21lIGZyb20gdGhlIHRoZSBr
bWVtX2NhY2hlIGFsbG9jYXRvciBhcyBpdA0KPj4+IGRvZXMgbm93LCBzbyB0aGF0IGNvc3QgaXMg
aWRlbXBvdGVudCB3aXRoIHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uLg0KPj4+IFRoZSBwb2lu
dGVyIHJlZ2lzdHJhdGlvbiB3b3VsZCBhbHNvIGJlIGEgc2luZ2xlIGluc3RhbmNlIGNvc3QuDQo+
Pj4gDQo+Pj4gU28gdGhlIHByaW1hcnkgY29zdCBkaWZmZXJlbnRpYWwgb3ZlciB0aGUgY29tbW9u
IGFyZW5hIG1vZGVsIHdpbGwgYmUNCj4+PiB0aGUgY29tcGxleGl0eSBjb3N0cyBhc3NvY2lhdGVk
IHdpdGggbG9va3VwcyBpbiBhIHJlZC9ibGFjayB0cmVlLCBpZg0KPj4+IHdlIHVzZWQgdGhlIG9s
ZCBJTUEgaW50ZWdyaXR5IGNhY2hlIGFzIGFuIGV4YW1wbGUgaW1wbGVtZW50YXRpb24uDQo+Pj4g
DQo+Pj4gQXMgSSBub3RlZCBhYm92ZSwgdGhlc2UgcGVyIGlub2RlIGxvY2FsIHN0b3JhZ2Ugc3Ry
dWN0dXJlcyBhcmUgY29tcGxleA0KPj4+IGluIG9mIHRoZW1zZWx2ZXMsIGluY2x1ZGluZyBsaXN0
cyBhbmQgbG9ja3MuICBJZiB0b3VjaGluZyBhbiBpbm9kZQ0KPj4+IGludm9sdmVzIGxvY2tpbmcg
YW5kIHdhbGtpbmcgbGlzdHMgYW5kIHRoZSBsaWtlIGl0IHdvdWxkIHNlZW0gdGhhdA0KPj4+IHRo
b3NlIHBlcmZvcm1hbmNlIGltcGFjdHMgd291bGQgcXVpY2tseSBzd2FtcCBhbiByL2IgbG9va3Vw
IGNvc3QuDQo+PiBicGYgbG9jYWwgc3RvcmFnZSBpcyBkZXNpZ25lZCB0byBiZSBhbiBhcmVuYSBs
aWtlIHNvbHV0aW9uIHRoYXQgd29ya3MNCj4+IGZvciBtdWx0aXBsZSBicGYgbWFwcyAoYW5kIHdl
IGRvbid0IGtub3cgaG93IG1hbnkgb2YgbWFwcyB3ZSBuZWVkIA0KPj4gYWhlYWQgb2YgdGltZSku
IFRoZXJlZm9yZSwgd2UgbWF5IGVuZCB1cCBkb2luZyB3aGF0IHlvdSBzdWdnZXN0ZWQgDQo+PiBl
YXJsaWVyOiBldmVyeSBMU00gc2hvdWxkIHVzZSBicGYgaW5vZGUgc3RvcmFnZS4gOykgSSBhbSBv
bmx5IDkwJQ0KPj4ga2lkZGluZy4NCj4gDQo+IFNvcnJ5LCBidXQgdGhhdCdzIG5vdCBmdW5ueS4N
Cg0KSSBkaWRuJ3QgdGhpbmsgdGhpcyBpcyBmdW5ueS4gTWFueSB1c2UgY2FzZXMgY2FuIHNlcmlv
dXNseSBiZW5lZml0DQpmcm9tIGEgX3JlbGlhYmxlXyBhbGxvY2F0b3IgZm9yIGlub2RlIGF0dGFj
aGVkIGRhdGEuIA0KDQo+IEl0J3MgdGhlIGtpbmQgb2Ygc3VnZ2VzdGlvbiB0aGF0IHNvbWUNCj4g
eW9obyB0YWtlcyBzZXJpb3VzbHksIHdoYWNrcyB0b2dldGhlciBhIHBhdGNoIGZvciwgYW5kIGdl
dHMgYWNjZXB0ZWQNCj4gdmlhIHRoZSB4ZmQ4ODcgZGV2aWNlIHRyZWUuIFRoZW4gZXZlcnlvbmUg
c2NyZWFtcyBhdCB0aGUgU0VMaW51eCBmb2xrcw0KPiBiZWNhdXNlIG9mIHRoZSBwZXJmb3JtYW5j
ZSBpbXBhY3QuIEFzIEkgaGF2ZSBhbHJlYWR5IHBvaW50ZWQgb3V0LA0KPiB0aGVyZSBhcmUgc2Vy
aW91cyBjb25zZXF1ZW5jZXMgZm9yIGFuIExTTSB0aGF0IGhhcyBhIGJsb2Igb24gZXZlcnkNCj4g
aW5vZGUuDQoNCmlfc2VjdXJpdHkgc2VydmVzIHRoaXMgdHlwZSBvZiB1c2VycyBwcmV0dHkgd2Vs
bC4gSSBzZWUgbm8gcmVhc29uIA0KdG8gY2hhbmdlIHRoaXMuIEF0IHRoZSBzYW1lIHRpbWUsIEkg
c2VlIG5vIHJlYXNvbnMgdG8gYmxvY2sgDQpvcHRpbWl6YXRpb25zIGZvciBvdGhlciB1c2UgY2Fz
ZXMgYmVjYXVzZSB0aGVzZSB1c2VycyBtYXkgZ2V0IA0KYmxhbWVkIGluIDIwODcgZm9yIGEgbWlz
dGFrZSBieSB4ZmQ4ODcgZGV2aWNlIG1haW50YWluZXJzLiANCg0KU29uZw0KDQoNCg0KDQo=

