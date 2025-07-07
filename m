Return-Path: <linux-fsdevel+bounces-54165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E337AFBB25
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 20:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA86B18906CD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 18:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B44264FB5;
	Mon,  7 Jul 2025 18:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="DWeaC0vR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1A52253BC;
	Mon,  7 Jul 2025 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751914219; cv=fail; b=omg6xvaUXWPAzaZ99DDvwoX7i9JaBGF1DZvBOyOvbhrGvGfPmFc/46UU+AI/5TssAtJT7ynU8pka6/RmcRFQk1ODAXNq+KYAiZk8pbbhXSAVEP85blDfYapubv0lDFYztwvW+n/QjhjnJIkORVWq6xghtfj690Pljc4S2LxMRHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751914219; c=relaxed/simple;
	bh=+CjV0zMVH0qUZTmo6BeQ3jUHtgsEsj4db7pBIq2ELJk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mq6AZXyM5+AXb5cjoQviN1oK0Bdjifj4is7B0xIvDwCm4b/nDGNak/RLYj8EY5ITUwUNfxjA3ltC00ClKxEeMeNXcnqyJu8wpKQ+afAklT1LMKwqNcbYqYX2pns9VYHgEJGz/wofidSxXgBBOEwSFLWipR1lkCpszHJY4KnIUXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=DWeaC0vR; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567IJZKj004520;
	Mon, 7 Jul 2025 11:50:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2025-q2; bh=+CjV0zMVH0qUZTmo6BeQ3jUHtgsEsj4db7pBIq2ELJk=; b=
	DWeaC0vRfVEBd899Hb+Cp7fQ0lLa1U+3UFEI6EVcj6ZQbDToBOYzRbI45WCo35s/
	j0odnJfZ1WV/K9iWEnLEbQFSSfM2fh4/JlMMAVn1teA/O6wNg8Mx2hMBgL4DVqma
	skzhzJBK0oeXIqzJPs9jJMk4z3lBlLa3kuJUcODnQEe+OxR8dD4GUf2n1Zyzk9rh
	UDMcSJlRm/8Spy4ufMhReCUa8Up7U6ByVQDEX0ZFR0fHJ0BwBvAH338XGoKZ1tRV
	TTIkz0+9m+e1gZaNHYdbp2/fbUjAu6jAsjmz6+TigWow9/TCdw9kLigu3l3yK3bt
	0RjSqymPaBeo0nTmnQTeUg==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47r94nvc19-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 11:50:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bb5wxwve7XIdFrWgL72ouvaA0PckmosJuIKUX4ggXtaHGJqD4jRhp5YtLu1GQlwL1aXtRsNte97O/Q/+H3ZnASSnehvVPnc12d55biCtjygo8hHwkrCJuKFX1zPYv8MjaQiKIPWNcJ7vlFVtR1W4bxhrx0MSEYUq9bIoLpiaIsHRaVW3FPnboS5vC6JAzNyWK6nNItD279fu+63Qy2+DFOutMb1Tc9Go9k7dH15M0XuxIIAW2iE5v+EQfS2a83asYWc3HA4/Ujle4Zl3gVuzP+llvt/e6w8NlirMH/CHeZ8cdEHxi9HeQMnrt0ZqkbRjWtY+vKLmOBQs+BSqGiTdGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CjV0zMVH0qUZTmo6BeQ3jUHtgsEsj4db7pBIq2ELJk=;
 b=aDvM5i0zohH5/MJnCtYXSUU9MPAkOxKcOWwzAUM52UPY3DRMq7QUlUqVTVY1obEH4hBMti2hCrBaeyJE+7BieDPB6cTbKaew4yUtPIEF5Vg7ZvzS1ZMS7blnW4MZvHnh7iyvacaZKsET5F2kG3NF0EuwEM4HeD9s2JN5kakN+7/3vFKiQKygE3lx/EX4s9nEE6+xQ4VrMpcev/vag1VNPakFJj8J95QlfvYs2R2bu8m55gnGGme1NDJjVMYlJZjQblgtuL5QDOfxElWG8QhhQ9qUK+jrx6lWpClwvDWePXRYw7Em8WJctWMrtcpdkHZYf/ijxFZ29WoqcbJWO3MkFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CO1PR15MB4940.namprd15.prod.outlook.com (2603:10b6:303:e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 18:50:12 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 18:50:12 +0000
From: Song Liu <songliubraving@meta.com>
To: Christian Brauner <brauner@kernel.org>
CC: NeilBrown <neil@brown.name>, Tingmao Wang <m@maowtm.org>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Song Liu
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
        "jack@suse.cz" <jack@suse.cz>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com" <mattbobrowski@google.com>,
        =?utf-8?B?R8O8bnRoZXIgTm9hY2s=?= <gnoack@google.com>
Subject: Re: [PATCH v5 bpf-next 0/5] bpf path iterator
Thread-Topic: [PATCH v5 bpf-next 0/5] bpf path iterator
Thread-Index:
 AQHb306ox9XN8K6VdkCbVuOe+nEEeLQMnoWAgAYTUACAADBQgIABBU4AgAClEQCAABGDAIAAECWAgABQToCAAEtZgIAARLiAgACMg4CAEH8tgIAACIOAgAB+hYA=
Date: Mon, 7 Jul 2025 18:50:12 +0000
Message-ID: <40D24586-5EC7-462A-9940-425182F2972A@meta.com>
References: <127D7BC6-1643-403B-B019-D442A89BADAB@meta.com>
 <175097828167.2280845.5635569182786599451@noble.neil.brown.name>
 <20250707-kneifen-zielvereinbarungen-62c1ccdbb9c6@brauner>
 <20250707-netto-campieren-501525a7d10a@brauner>
In-Reply-To: <20250707-netto-campieren-501525a7d10a@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|CO1PR15MB4940:EE_
x-ms-office365-filtering-correlation-id: a6ccac58-fdb5-45a6-333c-08ddbd871a99
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dzEyMVk0RTUrekV5N0daVkZpY3dRdU9VMG02OXFHV3prK3A5aUNHMzZSWk1n?=
 =?utf-8?B?Zmg5Q0hUU3BBNlFUMTIwOGwvOTU1OUloblFJUUJ6bXBJLzlJa3QyUG1HdEY0?=
 =?utf-8?B?eVZnNS8vSmxXSG5Bd3VYZHZkS0RzbVJQaWhHYmI3SjlsQTV3TW1Lam82RFBm?=
 =?utf-8?B?WHlOMEtqSHpKN2NMWWJoMVUxTmdTU3dsR3ZaSnRMeFNzVlFqRGJobHhzT2hs?=
 =?utf-8?B?c3V0NDRRWm9VeVRBa0VjdGo1Ymd0Slc1WndveHZyZFdnMysrRGRJamtKM3dW?=
 =?utf-8?B?aFBGS3hOQWJQMzZYeGErbVV4T0lFelNLeDY5dTI2K3ZrUGxaSzJsVy90bjdk?=
 =?utf-8?B?cHdSS0p3bjMyT1d1OHVZUDdwd2RsRHpmMkczcU15RVFYNGFXZ1ZEek4yb0U2?=
 =?utf-8?B?SU1DY0pnbEVDanhWVUdPMWRrNFROeC8wUEVRNGY2YlJzZEhuNjhuRmhUL2tx?=
 =?utf-8?B?aStlRGhFOVdwRnM3TnhiSEE1ZVlIaS9xWlgyZTBWeFpXbmxLM2RXTEFSbFNR?=
 =?utf-8?B?dXpJSVk2c2pseDA2VzQ0bUo2ZkROUDQvWXZSdFk0b3dDT0ZFZFBZOWVGdXhL?=
 =?utf-8?B?REJtZ2RkSFFXczV3OVVvWExqeG9aZ0FmMU1kWU1CR1cvT1YxQllSd1BiMDJt?=
 =?utf-8?B?NGpobTRXd2RCR0dSM0JxaldqUE9ZcitzeDJLUEdLMmgxa1c2d2d0bkQxbnRJ?=
 =?utf-8?B?bTVEczdyK3RXdGlzNEk0RSt1ckxkaGJvVzNicnM0TlRUWWxSUUthWDZVeUxI?=
 =?utf-8?B?SndTT2JIMTVMdVZxamcyR0NWblpVQ2hCR3NGRldyV3NZbjRnS3BvUjhXaUNk?=
 =?utf-8?B?K2tOVHBWeFA0TERxci9uUnQ1cG5adTJDZUEzcmZ1NElRSzNOL3FCWTNLZll3?=
 =?utf-8?B?S0N5cG1JelpKOXlpOHJ4YWZ6b3lWNjA2b0lpd2VJTFRqTHFBNE1ZckJzSGZO?=
 =?utf-8?B?SGZJNGNKN0xZMDZJL0lWY3A1eHRHam12eXY0NlRPSkRFanJoY2tydkYrN2R0?=
 =?utf-8?B?VkJqTTQrdGd2R0tpZStNaG0yZ2wycUdtWHBJTjFpVXBqUjRYVjJ6aVBPR1dn?=
 =?utf-8?B?UmRPTjdqUFQrNGFzQjlaZVIvaDRzNzhjUGdOaWJSTnBIekF6enovais3UkxB?=
 =?utf-8?B?eFpaZ1dVQVp3dlVlcUVrYm1vcTh4ano3KzRWQWEwWUpBTzdzQ3IydnJvV2kv?=
 =?utf-8?B?UUMrWWpwTXF5cXNqMDl5cll2RWd6cEpVQ2NyOTI1Y2dPM2tUV0xHOE15M0dM?=
 =?utf-8?B?NG1FcXVhMURaZjVOMjgrUkdqZEV6Lzlid0t6MmVvNEd1Mi8yWmloRHROVEtN?=
 =?utf-8?B?WXg3bGNraXNUeGt3dVBSYUticEdVMmFwV1doL0hoU2FITmdRUG4rNjVxL0Nm?=
 =?utf-8?B?a21OeVBhd2pLTFJqek8xWm42U3ZRc24rTUsvN1RyWVhhckkrQUh2cDJydXV2?=
 =?utf-8?B?YlpSa1FacmRxUTRtV3htVWErTVBEWlNSRHB4UlBQWWRzc3MyRUxZbW1KNkdS?=
 =?utf-8?B?RlNSQ21NTDFJdTRHbWVpOTZseDBhbmJWWFd2ditrbkpoTHF3VTBId0c5R1hT?=
 =?utf-8?B?TXFRYkRYTnQvSHF3UnFrTExhM0pUUEVXMktvSWpvbXUreEJTOXNzdFNKNnln?=
 =?utf-8?B?dE4xOEZPTmdQMU1mdzR0YUgwUEZXaVZqNmExVG1vZUp0K2dUWWJEMEtHcHRw?=
 =?utf-8?B?MXhzalJlY0tsZmVaanZ2TW0zOFBZWVZ3R2tUaFRKZVp6RWpFQ1VaaHNVdlA1?=
 =?utf-8?B?U2YwK0YxbWlsTTdPV0ZZbG4zNHBwbjBjYVhCMW9wRm0rRWtRNkhYQklrNEZU?=
 =?utf-8?B?QlhwNmluU2xtZDdSRnl2akp3bVl2aS81T2thcXUrZWhlUjdUeURBYkd4aDBY?=
 =?utf-8?B?bUVZZGtJdW4zU3ZBc3NNbkE0c3hwSHdKMzhHNmhHZS9INVVDWTRseTZFdjJE?=
 =?utf-8?B?RE15TC80TU1IcTVwR3lsY3ljZlkvRklMUU9tbEI3WlVyRkJLemh1UThtc1hm?=
 =?utf-8?B?TlA3NERzOExnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a0ZBRzRJV04xb0RoSVMwOVovMzZnWUpRKzZRbXlKZ1JqeFZhRmgzNzdxcHJa?=
 =?utf-8?B?OUxBbXZRSnk4Zk9WalpZL2ZXT3dKR05sRXdZR3JRNjA3QVJMTFFBS3NuOUJU?=
 =?utf-8?B?bGdHdTJuZW5YRi9IQ2dGakZ4Ym1hZVMyeURod3FkZzNtS0xKNlcySC84MDJ4?=
 =?utf-8?B?OHRHTDNLVEIxcUhBQkwrMTdGdnMxQVNZUkJhWmlKY3d6eTBnNHlmY3JnY25V?=
 =?utf-8?B?akJsekhpQkVsTERxMGhrTGxFL2ZpekhjeU1LQTExL0lpOFBDOW5Ib0FiQ0g4?=
 =?utf-8?B?bXZnay8xUk8yY3VBTTBwN1BhcTBxUzNQZExEM1JHVCtnb3BSTUQ1cmtjRnZT?=
 =?utf-8?B?Q3N4c3pBUFA1bm5Zd3laU1RBSytGUXRGbGRFNWJmcGRGTlRUT0twelYvb055?=
 =?utf-8?B?cUxZdHFoOTRqYU1mMkxvdDRxRGYraTNtMjZqMm9ZQitNQmdKa1NtUVB2VmZt?=
 =?utf-8?B?WnhFbHhrZ2Nza3JzS2dwR3NPRFZlQlFKRnB1SXowYVdXUk9BSXlTMy9vdmJz?=
 =?utf-8?B?eVZhTldjdkwreW5uNTMzNlliNzZFb0pBdnRvQTNUc2VVZXdaazQzZDB3bjVj?=
 =?utf-8?B?cEZ3VlVaTlJlSU8zWkZweGgyMzRoRzlmcGM3TzBBRUl4UlhrdXkveVFrVUpq?=
 =?utf-8?B?NWlHTVEzYlErM0dNTEVZS1o3Mkd4Wkx6QXhhRzNkUFladjB1TWlScHpMTVFv?=
 =?utf-8?B?eXlXRjNXU0l3SnFVUEdrVUwxM3YzUHpHSkdVRjJ3VWJJcHdqUURuM0xqQ2d1?=
 =?utf-8?B?U2hRZ2c5MnFUSER6RDFRY0tDcGt1SjN3TXcxYUFrOEZkN2g1TGpZY1JaK3FT?=
 =?utf-8?B?c1JjWXAvTys0cUt0TGdhd1VaaXluelRlSWhrZjFLWG9wNzcwcGlkZmtqRDlH?=
 =?utf-8?B?UXhBTTN1WEZRVldPRUVWam5ibzVrczMxTndQbFBPeTh0K2gzbUpTendhTWo5?=
 =?utf-8?B?WUtGbm1aaEFsOGlFb2hvWThNL1NmczRhMWFiWVh0V204QjBCSHlNV01LOThI?=
 =?utf-8?B?MFJiUFNEckdWT0NLR3MybG1YNmw3QWlJaDZwTlhGbDRsd01qZU1WaXE2NXRz?=
 =?utf-8?B?d2pOdzNxZEhacm5Fa3UxU1Q0dTRLZU1GazlEYUlJbE1EOWFNSjNSKytvM0k5?=
 =?utf-8?B?eTloRW8ycFhCTVo0enBUTW44OHZEd0ZzQjE4bkROUVJKSlBzbzVMOGJ2NS9S?=
 =?utf-8?B?OFkrckMrcnBJRHp5dW1Mdy9VM2dtR3JteGt1bC8zY0ZlVFgrYUVla0VSQ0Zv?=
 =?utf-8?B?WkxpMTk3THY1NFRoaFJtRHJnUE0wa0pkRWVaNnQ2YkJMVVIvejF1VkZmZjI4?=
 =?utf-8?B?OTBINHJoOVpZVDZ0eGEyNUdlRGxxT2F3Uk9LcHRSU2RXZ205U0dFeGplTUsw?=
 =?utf-8?B?UHQwT0ZWVGphV3FWaE12endQTkJuQXNlTGl5WmI0Rnk5aHJGSGpoQitISlJD?=
 =?utf-8?B?ODEwcWd2djhhU3VWVmE0ak81eFlPRUR0MldOc0hYVjlIVFJUamNoY0lMclR5?=
 =?utf-8?B?QnhpYVkrQVpRNGVMTGFkeE11S0t4dzZubm9kUnZaUVRiTE1FdFBIa3NEcmZa?=
 =?utf-8?B?VmY0QjlveDhFRkhGbEQrN1FoQXNXNEJRc3MxS1RWd3F5cmJINVpubEQvQ1Jz?=
 =?utf-8?B?M0Z4TGdhdEVkMGhaL2g5Rmszd1RRYTg2QmRXQ1dJU2lSMjdLVHFrVlF5TTBs?=
 =?utf-8?B?T0IrdVoxSDBLMGVkSWV0OFFPSFZHUmtyYzRSS2hMdlJuTjJhaWlpekZ6T3FZ?=
 =?utf-8?B?QythYnBFcUpMRWhKcG1BNFp5dUdGT0xUb3NRbi9zbkpmcm9jL3EwZVZYVTVo?=
 =?utf-8?B?Y2ZYTm5ibnZhd2o3SWgwRmJ5UzhaR2lXdHJvTGJaU0pQTWQvQ1U2RU5VWTlI?=
 =?utf-8?B?MnR6NFNWVWtlYldGVitCcUJ6SWhHOUNIWWpETWlrYWdwbkp3ZGNiVVZsRWpj?=
 =?utf-8?B?U0RRbnlqa05YSWFDb2hxYnU0eWM0ait1RVNhU1NkckZUV29Dcnh6VTJsVGpm?=
 =?utf-8?B?cUJsU3FlU0ZGaDdlU2NSUUlYRkRJVjJSMm81UWZhVTRrZjl3MGRpSWZ1cmtI?=
 =?utf-8?B?U3BvL0pHZ1NlaVRJQU9vTVk0WmJzTXRsWFFnbmZZeE1KSXRyYmJvTkdsOXJF?=
 =?utf-8?B?cXJLM3ZTdjdVamRpWmdHb3RBVUdBZGFjdnhRRmRTUkptY053emdGMk02L1du?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E150AC7A1EE2A489EAFC7D6C4E6DCAA@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ccac58-fdb5-45a6-333c-08ddbd871a99
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 18:50:12.0633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zmYTxlbFpGiZ2AJuaTrN/wC/7t1J9Z60LkXGbtJZkVFC6pmmEbb01mAnsj1/zhTh1jlp/7jSflgBtxeaNJ0Ixg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4940
X-Proofpoint-GUID: 1vov-kj-8MOkT1GDqE9cHmY7N1irrU4P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDEyNCBTYWx0ZWRfX6OtOwNX0AJS4 /SJY0g96vsyD87jDBYSedrrDxYM6xhldMKqBWDNPpjiCGz23NMkDL0IC7e16YAr1A9dy31Fh17N fJXTgw1Lp2T+5SAL6khh+Up4RxbyhmB2CVE3Vn4Z9hdlXQcK3UMkZlw0l8BxkGUbFwb4d77G0Gm
 +ZkuTl9O4Eztok4o22v5sKs0N5Lwqcdk4v6nTwYQXsqHPWCBwj5vOgk0hgB0laHe7d02y78xHko /wcfrA78swFPsP08hleE2Gka86XeXa8k1RIuYTFvTQSLFntIpWq3gszpSgvXDtAjkj32dvkoiTv OdgZEKWznVfUgk/utfvMPm2eCWIcr6nF0Mi47eMA/zv6oRkQeNHOf0d4BhnP2xDELxyoJ6ren8y
 Yg1BqwKc1IIFiqbo/I4Dtu7mGJKFZ7/hUmv9c33fmsLbawUN/PyNbfiCNHJMzHrIXB31URBA
X-Proofpoint-ORIG-GUID: 1vov-kj-8MOkT1GDqE9cHmY7N1irrU4P
X-Authority-Analysis: v=2.4 cv=NPnV+16g c=1 sm=1 tr=0 ts=686c16e8 cx=c_pps a=fuPBXZG3M7Sc+qedpsXBqw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=TxfyVekQos-ZsdhW_XYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_04,2025-07-07_01,2025-03-28_01

SGkgQ2hyaXN0aWFuLCANCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzISANCg0KPiBPbiBKdWwg
NywgMjAyNSwgYXQgNDoxN+KAr0FNLCBDaHJpc3RpYW4gQnJhdW5lciA8YnJhdW5lckBrZXJuZWwu
b3JnPiB3cm90ZToNCg0KWy4uLl0NCg0KPj4+IDMvIEV4dGVuZCB2ZnNfd2Fsa19hbmNlc3RvcnMo
KSB0byBwYXNzIGEgIm1heSBzbGVlcCIgZmxhZyB0byB0aGUgY2FsbGJhY2suDQo+PiANCj4+IEkg
dGhpbmsgdGhhdCdzIGZpbmUuDQo+IA0KPiBPaywgc29ycnkgZm9yIHRoZSBkZWxheSBidXQgdGhl
cmUncyBhIGxvdCBvZiBkaWZmZXJlbnQgdGhpbmdzIGdvaW5nIG9uDQo+IHJpZ2h0IG5vdyBhbmQg
dGhpcyBvbmUgaXNuJ3QgZXhhY3RseSBhbiBlYXN5IHRoaW5nIHRvIHNvbHZlLg0KPiANCj4gSSBt
ZW50aW9uZWQgdGhpcyBiZWZvcmUgYW5kIHNvIGRpZCBOZWlsOiB0aGUgbG9va3VwIGltcGxlbWVu
dGF0aW9uDQo+IHN1cHBvcnRzIHR3byBtb2RlcyBzbGVlcGluZyBhbmQgbm9uLXNsZWVwaW5nLiBU
aGF0IGFwaSBpcyBhYnN0cmFjdGVkDQo+IGF3YXkgYXMgaGVhdmlseSBhcyBwb3NzaWJsZSBieSB0
aGUgVkZTIHNvIHRoYXQgbm9uLWNvcmUgY29kZSB3aWxsIG5vdCBiZQ0KPiBleHBvc2VkIHRvIGl0
IG90aGVyIHRoYW4gaW4gZXhjZXB0aW9uYWwgY2lyY3Vtc3RhbmNlcyBhbmQgZG9lc24ndCBoYXZl
DQo+IHRvIGNhcmUgYWJvdXQgaXQuDQo+IA0KPiBJdCBpcyBhIGNvbmNlcHR1YWwgZGVhZC1lbmQg
dG8gZXhwb3NlIHRoZXNlIHR3byBtb2RlcyB2aWEgc2VwYXJhdGUgQVBJcw0KPiBhbmQgbGVhayB0
aGlzIGltcGxlbWVudGF0aW9uIGRldGFpbCBpbnRvIG5vbi1jb3JlIGNvZGUuIEl0IHdpbGwgbm90
DQo+IGhhcHBlbiBhcyBmYXIgYXMgSSdtIGNvbmNlcm5lZC4NCj4gDQo+IEkgdmVyeSBtdWNoIHVu
ZGVyc3RhbmQgdGhlIHVyZ2UgdG8gZ2V0IHRoZSByZWZjb3VudCBzdGVwLWJ5LXN0ZXAgdGhpbmcN
Cj4gbWVyZ2VkIGFzYXAuIEV2ZXJ5b25lIHdhbnRzIHRoZWlyIEFQSXMgbWVyZ2VkIGZhc3QuIEFu
ZCBpZiBpdCdzDQo+IHJlYXNvbmFibGUgdG8gbW92ZSBmYXN0IHdlIHdpbGwgKHNlZSB0aGUga2Vy
bmZzIHhhdHRyIHRoaW5nKS4NCj4gDQo+IEJ1dCBoZXJlIGFyZSB0d28gdXNlLWNhc2VzIHRoYXQg
YXNrIGZvciB0aGUgc2FtZSB0aGluZyB3aXRoIGRpZmZlcmVudA0KPiBjb25zdHJhaW50cyB0aGF0
IGNsb3NlbHkgbWlycm9yIG91ciB1bmlmaWVkIGFwcHJvYWNoLiBNZXJnaW5nIG9uZQ0KPiBxdWlj
a2x5IGp1c3QgdG8gaGF2ZSBzb21ldGhpbmcgYW5kIHRoZW4gbGF0ZXIgYm9sdGluZyB0aGUgb3Ro
ZXIgb25lIG9uDQo+IHRvcCwgYXVnbWVudGluZywgb3IgcmVwbGFjaW5nLCBwb3NzaWJsZSBoYXZp
bmcgdG8gZGVwcmVjYXRlIHRoZSBvbGQgQVBJDQo+IGlzIGp1c3Qgb2JqZWN0aXZlbHkgbnV0cy4g
VGhhdCdzIGhvdyB3ZSBlbmQgdXAgd2l0aCBhIHNwYWdoZXR0aGkgaGVscGVyDQo+IGNvbGxlY3Rp
b24uIFdlIHdhbnQgYXMgbGl0dGxlIGhlbHBlciBmcmFnbWVudGF0aW9uIGFzIHBvc3NpYmxlLg0K
PiANCj4gV2UgbmVlZCBhIHVuaWZpZWQgQVBJIHRoYXQgc2VydmVzIGJvdGggdXNlLWNhc2VzLiBJ
IGRpc2xpa2UNCj4gY2FsbGJhY2stYmFzZWQgQVBJcyBnZW5lcmFsbHkgYnV0IHdlIGhhdmUgcHJl
Y2VkZW50IGluIHRoZSBWRlMgZm9yIHRoaXMNCj4gZm9yIGNhc2VzIHdoZXJlIHRoZSBpbnRlcm5h
bCBzdGF0ZSBoYW5kbGluZyBpcyBkZWxpY2F0ZSBlbm91Z2ggdGhhdCBpdA0KPiBzaG91bGQgbm90
IGJlIGV4cG9zZWQgKHNlZSBfX2l0ZXJhdGVfc3VwZXJzKCkgd2hpY2ggZG9lcyBleGFjdGx5IHdv
cmsNCj4gbGlrZSBOZWlsIHN1Z2dlc3RlZCBkb3duIHRvIHRoZSBmbGFnIGFyZ3VtZW50IGl0c2Vs
ZiBJIGFkZGVkKS4NCj4gDQo+IFNvIEknbSBvcGVuIHRvIHRoZSBjYWxsYmFjayBzb2x1dGlvbi4N
Cj4gDQo+IChOb3RlIGZvciByZWFsbHkgYWJzdXJkIHBlcmYgcmVxdWlyZW1lbnRzIHlvdSBjb3Vs
ZCBldmVuIG1ha2UgaXQgd29yaw0KPiB3aXRoIHN0YXRpYyBjYWxscyBJJ20gcHJldHR5IHN1cmUu
KQ0KDQpJIGd1ZXNzIHdlIHdpbGwgZ28gd2l0aCBNaWNrYcOrbOKAmXMgaWRlYToNCg0KPiBpbnQg
dmZzX3dhbGtfYW5jZXN0b3JzKHN0cnVjdCBwYXRoICpwYXRoLA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgYm9vbCAoKndhbGtfY2IpKGNvbnN0IHN0cnVjdCBwYXRoICphbmNlc3Rvciwgdm9pZCAq
ZGF0YSksDQo+ICAgICAgICAgICAgICAgICAgICAgICB2b2lkICpkYXRhLCBpbnQgZmxhZ3MpDQo+
IA0KPiBUaGUgd2FsayBjb250aW51ZSB3aGlsZSB3YWxrX2NiKCkgcmV0dXJucyB0cnVlLiAgd2Fs
a19jYigpIGNhbiB0aGVuDQo+IGNoZWNrIGlmIEBhbmNlc3RvciBpcyBlcXVhbCB0byBhIEByb290
LCBvciBvdGhlciBwcm9wZXJ0aWVzLiAgVGhlDQo+IHdhbGtfY2IoKSByZXR1cm4gdmFsdWUgKGlm
IG5vdCBib29sKSBzaG91bGQgbm90IGJlIHJldHVybmVkIGJ5DQo+IHZmc193YWxrX2FuY2VzdG9y
cygpIGJlY2F1c2UgYSB3YWxrIHN0b3AgZG9lc24ndCBtZWFuIGFuIGVycm9yLg0KDQpJZiBuZWNl
c3NhcnksIHdlIGhpZGUg4oCccm9vdCIgaW5zaWRlIEBkYXRhLiBUaGlzIGlzIGdvb2QuIA0KDQo+
IEBwYXRoIHdvdWxkIGJlIHVwZGF0ZWQgd2l0aCBsYXRlc3QgYW5jZXN0b3IgcGF0aCAoZS5nLiBA
cm9vdCkuDQoNClVwZGF0ZSBAcGF0aCB0byB0aGUgbGFzdCBhbmNlc3RvciBhbmQgaG9sZCBwcm9w
ZXIgcmVmZXJlbmNlcy4gDQpJIG1pc3NlZCB0aGlzIHBhcnQgZWFybGllci4gV2l0aCB0aGlzIGZl
YXR1cmUsIHZmc193YWxrX2FuY2VzdG9ycyANCnNob3VsZCB3b3JrIHVzYWJsZSB3aXRoIG9wZW4t
Y29kZWVkIGJwZiBwYXRoIGl0ZXJhdG9yLiANCg0KSSBoYXZlIGEgcXVlc3Rpb24gYWJvdXQgdGhp
cyBiZWhhdmlvciB3aXRoIFJDVSB3YWxrLiBJSVVDLCBSQ1UgDQp3YWxrIGRvZXMgbm90IGhvbGQg
cmVmZXJlbmNlIHRvIEBhbmNlc3RvciB3aGVuIGNhbGxpbmcgd2Fsa19jYigpLg0KSWYgd2Fsa19j
YigpIHJldHVybnMgZmFsc2UsIHNoYWxsIHZmc193YWxrX2FuY2VzdG9ycygpIHRoZW4NCmdyYWIg
YSByZWZlcmVuY2Ugb24gQGFuY2VzdG9yPyBUaGlzIGZlZWxzIGEgYml0IHdlaXJkIHRvIG1lLiAN
Ck1heWJlIOKAnHVwZGF0aW5nIEBwYXRoIHRvIHRoZSBsYXN0IGFuY2VzdG9y4oCdIHNob3VsZCBv
bmx5IGFwcGx5IHRvDQpMT09LVVBfUkNVPT1mYWxzZSBjYXNlPyANCg0KPiBAZmxhZ3MgY291bGQg
Y29udGFpbiBMT09LVVBfUkNVIG9yIG5vdCwgd2hpY2ggZW5hYmxlcyB1cyB0byBoYXZlDQo+IHdh
bGtfY2IoKSBub3QtUkNVIGNvbXBhdGlibGUuDQo+IA0KPiBXaGVuIHBhc3NpbmcgTE9PS1VQX1JD
VSwgaWYgdGhlIGZpcnN0IGNhbGwgdG8gdmZzX3dhbGtfYW5jZXN0b3JzKCkNCj4gZmFpbGVkIHdp
dGggLUVDSElMRCwgdGhlIGNhbGxlciBjYW4gcmVzdGFydCB0aGUgd2FsayBieSBjYWxsaW5nDQo+
IHZmc193YWxrX2FuY2VzdG9ycygpIGFnYWluIGJ1dCB3aXRob3V0IExPT0tVUF9SQ1UuDQoNCg0K
R2l2ZW4gd2Ugd2FudCBjYWxsZXJzIHRvIGhhbmRsZSAtRUNISUxEIGFuZCBjYWxsIHZmc193YWxr
X2FuY2VzdG9ycw0KYWdhaW4gd2l0aG91dCBMT09LVVBfUkNVLCBJIHRoaW5rIHdlIHNob3VsZCBr
ZWVwIEBwYXRoIG5vdCBjaGFuZ2VkDQpXaXRoIExPT0tVUF9SQ1U9PXRydWUsIGFuZCBvbmx5IHVw
ZGF0ZSBpdCB0byB0aGUgbGFzdCBhbmNlc3RvciANCndoZW4gTE9PS1VQX1JDVT09ZmFsc2UuIA0K
DQpXaXRoIHRoaXMgYmVoYXZpb3IsIGxhbmRsb2NrIGNvZGUgd2lsbCBiZSBsaWtlOg0KDQoNCi8q
IEFzc3VtZSB3ZSBob2xkIHJlZmVyZW5jZSBvbiDigJxwYXRo4oCdLiANCiAqIFdpdGggTE9PS1VQ
X1JDVSwgcGF0aCB3aWxsIG5vdCBjaGFuZ2UsIHdlIGRvbuKAmXQgbmVlZCANCiAqIGV4dHJhIHJl
ZmVyZW5jZSBvbiDigJxwYXRo4oCdLg0KICovDQplcnIgPSB2ZnNfd2Fsa19hbmNlc3RvcnMocGF0
aCwgbGxfY2IsIGRhdGEsIExPT0tVUF9SQ1UpOw0KLyogDQogKiBBdCB0aGlzIHBvaW50LCB3aGV0
aGVyIGVyciBpcyAwIG9yIG5vdCwgcGF0aCBpcyBub3QgDQogKiBjaGFuZ2VkLg0KICovDQoNCmlm
IChlcnIgPT0gLUVDSElMRCkgew0KCXN0cnVjdCBwYXRoIHdhbGtfcGF0aCA9ICpwYXRoOw0KDQoJ
LyogcmVzZXQgYW55IGRhdGEgY2hhbmdlZCBieSB0aGUgd2FsayAqLw0KCXJlc2V0X2RhdGEoZGF0
YSk7DQoNCgkvKiBnZXQgYSByZWZlcmVuY2Ugb24gd2Fsa19wYXRoLiAqLw0KCXBhdGhfZ2V0KCZ3
YWxrX3BhdGgpOw0KDQoJZXJyID0gdmZzX3dhbGtfYW5jZXN0b3JzKCZ3YWxrX3BhdGgsIGxsX2Ni
LCBkYXRhLCAwKTsNCgkvKiBOb3csIHdhbGtfcGF0aCBtaWdodCBiZSB1cGRhdGVkICovDQoNCgkv
KiBBbHdheXMgcmVsZWFzZSByZWZlcmVuY2Ugb24gd2Fsa19wYXRoICovDQoJcGF0aF9wdXQoJndh
bGtfcGF0aCk7DQp9DQoNCg0KQlBGIHBhdGggaXRlcmF0b3Igc29kZSB3aWxsIGxvb2sgbGlrZToN
Cg0Kc3RhdGljIGJvb2wgYnBmX2NiKGNvbnN0IHN0cnVjdCBwYXRoICphbmNlc3Rvciwgdm9pZCAq
ZGF0YSkNCnsNCglyZXR1cm4gZmFsc2U7DQp9DQoNCnN0cnVjdCBwYXRoICpicGZfaXRlcl9wYXRo
X25leHQoc3RydWN0IGJwZl9pdGVyX3BhdGggKml0KQ0Kew0KCXN0cnVjdCBicGZfaXRlcl9wYXRo
X2tlcm4gKmtpdCA9ICh2b2lkICopaXQ7DQoNCglpZiAodmZzX3dhbGtfYW5jZXN0b3JzKCZraXQt
PnBhdGgsIGJwZl9jYiwgTlVMTCkpDQoJCXJldHVybiBOVUxMOw0KCXJldHVybiAma2l0LT5wYXRo
Ow0KfQ0KDQoNCkRvZXMgdGhpcyBzb3VuZCByZWFzb25hYmxlIHRvIGV2ZXJ5IGJvZHk/DQoNClRo
YW5rcywNClNvbmcNCg0K

