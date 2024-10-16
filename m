Return-Path: <linux-fsdevel+bounces-32129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9259A0FDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 18:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31857B216E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 16:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB5B20FA9D;
	Wed, 16 Oct 2024 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Ad9Rqwzy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6425016FF5F;
	Wed, 16 Oct 2024 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729096690; cv=fail; b=AOGx699Z/PhEiW6BanWRZxFKM3ppaaa7no34shak0tkkHTZNuDXUgJh1It/zHvUGKis4lIEnh5IaIDaeQSQ6sBvokRpBb2kL0yu/X/DpLJuhPTmgjp35Zf85st0lY+vuc1T7wlo6l1XSxLXXcUAmVc0wC3e0cWglFGuBA7/jeOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729096690; c=relaxed/simple;
	bh=+0PZGbzJCdKlZ0kSUWxhat3WrK4DBA53m5i0NCZ636k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d9crrflen080poJDDcPT+wHkEUfQMUGtFmDQcluRzR5ntxMv0GBVx+ckn1B3qrvL+cq3NF8Z8ZanpUrpvuSbtjvnEk+AQNdpCuKURlpV9sNHdEYtK6A3K2wVq9ICTNbFiV8ZWBrQ24nV7IhFkuEcDAzNLR9VHgC4TdnWL+6ymTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Ad9Rqwzy; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GGHHo5011229;
	Wed, 16 Oct 2024 09:38:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=+0PZGbzJCdKlZ0kSUWxhat3WrK4DBA53m5i0NCZ636k=; b=
	Ad9RqwzyWJ0cUkP564EsHekaUkyovAfGcB8hAPlQsdIHXBa0NM2fmoXUpwmaHA4P
	hrugjuqI0HglUA+QveP8J9tf8tDn0LA91TM4ecSjLpws4cE3ngPPLAnaZuhbh4rF
	2AMOCYVXLWRHdE/+7potVK0l1RwVwJU76i8NqWF7HEx6ViB/gQH7dH5hZPbTdJEN
	Tqr+GpXk86m4v5x2542hjXRGR5VNrnyc7H3Q1fqScJ6TQNHrA+TOIEwbTT7NOZcO
	TDz+FQSqLzezrU6Jh6f08ZuBt3BqTASpVOTxI0MLuyT6yUqTOirY61z9LuYFsw0H
	VRHrWbCKgBilyXBFJB5HJw==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4291qkame7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 09:38:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LmsZ6h5O1QGYq6skKgKE7T3cUYcfAYEYAviupLbvk0DEtoV/eJWH/3E9KU/mTlmstL8VywZ2mX8Q+qqZKDVDWzc87qjBqzounqh6u8q2DVaYWZprLw4XfEb1Q8K7stQrdtuHx3dy0J10rSLaZSz5aQYUbckTruK9qMXCnpIKpotl57VWhuQulQRkVnR7O0kXmtHccoIb3CqZmbtYSNaH8jv+sxSwVsoTCb1Ver3mDoMg+jsU9lnEyBlvxmkKfgMdAQwBqGaeK1pnFfHX7g3EziUg1KJ7sC0VzqxTDlGyY247H10UNQZDlr6P83JP0KbgJT0vlG1vN/i2KrtHHvHRwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0PZGbzJCdKlZ0kSUWxhat3WrK4DBA53m5i0NCZ636k=;
 b=n/vwvDEEgPgepI297UBW2KNEuqSiyuEtsn/SdnWD9cUvUSGflu0kH3VwZWdmdEHwh6eQI7dfQNyxXLHUtQtu2YNc4coiRX+9g3hJzSzQQmHO7PFPONXpZhNTUPeJKoHodaXCrYfRJqZcVMNX0JRwwnUZpkq8CwFUA5wcG0fRGghN0DHXak3L5RaBob25MpJPc2YF+LJBv6tk/xwG6ZeN9usnGh+nxQ9UBFW/kP2zA6fVonRvYjOI2rdYmS4UGreqMJzL4tVTfebxNKvtdWTw/CmizfK8hHxm24D/FbOHVpfsA/8XbC+AZGnevuTmOJp25ioQ9s+UqjyTkPjbySX4ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SJ2PR15MB5836.namprd15.prod.outlook.com (2603:10b6:a03:4f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 16:38:03 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 16:38:03 +0000
From: Song Liu <songliubraving@meta.com>
To: Christian Brauner <brauner@kernel.org>
CC: Jan Kara <jack@suse.cz>, Song Liu <songliubraving@meta.com>,
        Christoph
 Hellwig <hch@infradead.org>, Song Liu <song@kernel.org>,
        bpf
	<bpf@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Andrii
 Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Alexei
 Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin
 KaFai Lau <martin.lau@linux.dev>,
        Al Viro <viro@zeniv.linux.org.uk>, KP Singh
	<kpsingh@kernel.org>,
        Matt Bobrowski <mattbobrowski@google.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Extend test fs_kfuncs to
 cover security.bpf xattr names
Thread-Topic: [PATCH bpf-next 2/2] selftests/bpf: Extend test fs_kfuncs to
 cover security.bpf xattr names
Thread-Index:
 AQHbFRSqQ+6V3A7WhE2nOTZ+DtSM+rKHVfgAgAAEFACAAAEygIAAB0MAgAIYdICAABCugIAAHbGA
Date: Wed, 16 Oct 2024 16:38:03 +0000
Message-ID: <E80730DC-9389-41F7-A46D-136495C1E82D@fb.com>
References: <20241002214637.3625277-1-song@kernel.org>
 <20241002214637.3625277-3-song@kernel.org> <Zw34dAaqA5tR6mHN@infradead.org>
 <0DB83868-0049-40E3-8E62-0D8D913CB9CB@fb.com>
 <Zw384bed3yVgZpoc@infradead.org>
 <BF0CD913-B067-4105-88C2-B068431EE9E5@fb.com>
 <20241016135155.otibqwcyqczxt26f@quack3>
 <20241016-luxus-winkt-4676cfdf25ff@brauner>
In-Reply-To: <20241016-luxus-winkt-4676cfdf25ff@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SJ2PR15MB5836:EE_
x-ms-office365-filtering-correlation-id: 23e61b83-86d2-4db1-a6a3-08dcee00e7be
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c2FvU2ZVK1NkQW11bElPQXdZVm5LVjRrRVI0WmhUUUhhVnI4QWNlUExibTVn?=
 =?utf-8?B?VjJYYjh3d01hWUNlZ3JIa2JFYUxzbXliTlJXU291NmVaN2hZbXJuNHhXUTU3?=
 =?utf-8?B?Z0svdzQ5eDdELzdDRmZwWFNxR2FkaGVuczllRy9mbE5jZEdDQU5RV2ltQW5r?=
 =?utf-8?B?Q0ttZUFja0toWlI1TDZKTk1VUEVIdUtTdkZqVEJUN1dBTWRMaVlSWEN6NTBr?=
 =?utf-8?B?STA2bDJVM1J2U1ZaekxQYXUyRjNUVUlWVVEvVVh1dExHVUMyMDdWV1huZm5q?=
 =?utf-8?B?eHpDV21ERk5OT0JEazRwWFMxaHM2dTdCWXlpajhTdjJUTy8xRUQ0cnJJYWVW?=
 =?utf-8?B?S1BsMG9sM0JJUm5pR2pGcGtMZDdRcU1IVzBQZ3pudTIzWUVrbnBWTVhWUHpC?=
 =?utf-8?B?QTFBTWdTUk01L1p0bnpuQ0RDZWJ6WDJYMlBPdFA4b2NnMS8vaURFZkNGWlVl?=
 =?utf-8?B?Zmc2TEZlcVFVcitjc0NsVGNGdExrVVdyb0gwaVgwSkNkcVI2MTQ1enNXTG9F?=
 =?utf-8?B?UW41VFhOSGlUR1VqV1NjZHord1VBY0FLaFRLYnlYdS9Kc2NTZU8zbGlOK3U0?=
 =?utf-8?B?REJCa1FYdFdnNStLZDZ5ZXlEckRGcVJYQzBBdEo4Z0p2Qzd1RldNVDQxZWd5?=
 =?utf-8?B?K25PWC8ydDdYKzFNWk4wUnVlUmkwbWk5a0hFMzBVcmhKeHpGVmhpVDBRZ3cr?=
 =?utf-8?B?VGljQ0dpQjNiaUNKcGRwZjZIY1liRTNSYnAxdVJZOXZYZlAzMUY5L0RYK242?=
 =?utf-8?B?UStrak41aUxWcnVPVGFPU0hnd3pZKzRkWmY5eXMvMU5IVHNMejRFZ1gwOUll?=
 =?utf-8?B?eGpJRzJ4ZW1DRFcyZUY0Wit5TFZZYjREZEFzRDRyV21DMkNmVTJYNFltUVM3?=
 =?utf-8?B?YVAxbjFObXo0TmF3OS9TOEdYNU11MkY4YldUVTgzTEk5bkhGU1d4cHFWL204?=
 =?utf-8?B?WlhuZXRyR1FyTGRLQTJva05MUi9DbVE4Rm81cUNkd3ZsTE1qcjdpU1lOdXE4?=
 =?utf-8?B?Rk8zSHdocGNpYVJRTjhwaWFINEhWTnFFUFR1T3BjZHVtSXNxcW5VbEhuWUNI?=
 =?utf-8?B?WUg3NEhSSCt1U3hEVGsySnB4dDhxc0xlTlNVRUNzcEFjYmZGL1VaRHRLWGpM?=
 =?utf-8?B?aFVkQjIvL25kT0JHL2hseUVQWnVYWW0zcUQ3Unl0OWVySzhyaFRWZ2UrdUJR?=
 =?utf-8?B?Y0FvSG1IdWY2b0JkcHZ5UlZPcVlSQVhTeFVBUnM3YTFLOW11NThQWjVidlVk?=
 =?utf-8?B?TUlialJtV0lxZ3Z2cko0cGRkWTBuRnJlT0s1NkFpbDZoY1Y3UEdjK1dKcWJu?=
 =?utf-8?B?SGNSakFDT09pSzZRYzJ4RGQrZlF0YlFtWUZoTVRRQXF3S3Z4ZmNNNEVwRDk3?=
 =?utf-8?B?TzhTa0tNRUxiWS9qa3JaN1h4NGVDTmYzM1BQWlJodGpEUWxpcW9vcDBUQnA2?=
 =?utf-8?B?b0l1M2llS3dJcFdEQmFqczYvRU1JdERJMWZRVmNxRzEvMlA5bVBtNElHRHVw?=
 =?utf-8?B?cGdtSklRTmkvVzB1YUd4SzJUclJYb3piYXVmN2ZtVXVkOExMS3hXQjNGSXJ3?=
 =?utf-8?B?bDNnQzl1Y21PdTdvcmxuN1U1eXhkTlhVQVJvYmlGZ3YrUzZzNkh3dUZMWWdO?=
 =?utf-8?B?a2RMaDM5TDd2c0lBRlg4UmJ0MWloWWZFSTMraHdxVmV5QmdZalVvM2c1bi9v?=
 =?utf-8?B?YUo2RUhacDRhdGhxcmxQQS9yaUphNTMwbHZueFRrQXA0MnNKMVNyUDRHZlZR?=
 =?utf-8?B?UlY4dzU5ZDY5ZVBOM1JySHZFVkg0VE0wallZUmIrYVZIOWNmVktpaGJTOFZn?=
 =?utf-8?B?R2RLL3M1NzIxUHdyS25YUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V041cXhRdjZhVmdwUVVTcjA1ZS9pWTlwWHpPRnd0NXFKVnc2bXM5RWczbC9a?=
 =?utf-8?B?bG9ZT25iZVBGKzBSNVg3VnlEVUJ2MXBZMUN4QnROMkFQQ1hQYzFsN2RQeEdO?=
 =?utf-8?B?NTQ3VHU5VnI3YkthUzdsZWhZeXNSNkduUHI4TytDRTVkOHIybXJERDVZbHpq?=
 =?utf-8?B?V1ZkbFVkbUdkMTMvaHdWeHY1NXBmYkVMTTRUeUZHc05jTVFQZ1lIbEh5WTFa?=
 =?utf-8?B?TzBCTVZ5emZidXlJQjlDTSsyMWpnZmN0UVczSmtLbUNIL29YR2FMWFVQMGhP?=
 =?utf-8?B?Ykp3eXhUNVdUYW1CQVZKQW1ESkkvTm9zdW1XUVp0bDJPdlk3NVMzYktLVVlv?=
 =?utf-8?B?ekZRUjNmaUdzUWZSYTJFS2Z5WjFYY0M1MXZjS3VYbU5sTHlvSE1VeEdXdUNz?=
 =?utf-8?B?NERxTFB4dDFjNTlaekdITE42dFRZMVVURC9aeFpSYlU5ZVFtdTdRbWpPQnNh?=
 =?utf-8?B?UDI3TWIzN1lxZXBYenJTRFc3WXVlb3Rkcmd3TUVUbTdvb1lNU09qOVUyTjBi?=
 =?utf-8?B?UEpRL2RMNFQvY3lTR0hnNU8zSUZHRitqVzMyZzhXZ045c1p3RnJ1R2dCbUZ3?=
 =?utf-8?B?TzVGdEJTVEIrYlNrZ1FxZEJyQm90VXd3ZzlBK29XWm1PczZRNGtjd0tvalFP?=
 =?utf-8?B?eEZrVUJiWGUyVkdXZGlrcGtvWTE2TSsrand4bERyYXh2VERmMW5LMWllUUJy?=
 =?utf-8?B?L0hoc0kxMkxiQUE5Nm5VVjlxQW9kQlF3bDBSOWNWSyt0RGNmYkJvMTVsTWYx?=
 =?utf-8?B?TjBMdzNsMHJySlpvcDl4SlRUTElQM2xvRnphL0RTUDlJMy9yTlNRc3M0VzZa?=
 =?utf-8?B?ZSszYTJNVWtZMURUL0NQUDliUTdEektqQnBvK3Q2SXFwV0JlWGMyT1dMVVh6?=
 =?utf-8?B?QkNKODZtTmRlZ0grSngwZzI2Z2pwZmhtL3QvQzNueUIwK052NG1CdS9GSHZ3?=
 =?utf-8?B?SGJDWlVKbERuclk1RGRWNGM2RTVFTXk4Ky9IZWk2Zk14T3VmeEt0ZU9ZMUhS?=
 =?utf-8?B?SEdlR0RvclVaTEF3TzBHZGtjT01BN3lrR3hYckd5Vis5MGVycUJKSCtBelFN?=
 =?utf-8?B?UkNTNE9TNTB6am5DMFJaNU9ISWphS1laVVJmaktQa2lxWU5tdy8weXY2NnY3?=
 =?utf-8?B?NXF4K0Y0L20vZEFMcGJ3S2dMcHhmYUtmVWV5VkVHc1V1bVFKeXJxdjl6cHhO?=
 =?utf-8?B?OFNZMXlZbDMyTXg1SVUrWVJUcDNtNktKUUc4QVVJZ1Fuenk5YklaZXFheDZz?=
 =?utf-8?B?ajMvREJBWHpwZlJlMGxOb0FPTk8vSnAwcnMyT1VHOG03Q0U1Q3Z0Y2l5RFhM?=
 =?utf-8?B?YTVFMzVGVFJKbU5OVjlCVFI2cU5KZGFRV0JHeGFmcFZ6a2hrK1IrQlA3U1hx?=
 =?utf-8?B?bzRQaG52aVhlRlpkTW1SLzBBaDNwUGxLRVV6L2RRVzV4aGJTL1QxNU0xTEVj?=
 =?utf-8?B?b2NueFp1YTQ0cjQzK0o2TWxQMzJySGRzMkI5Y1NXekR0SWptMnN1Unp3L1hj?=
 =?utf-8?B?WHlyVEdNTFc0RUp4UElpODI2U2gyWE9aN3I0WmM0OGV0Rk5UMFVZeGg0MEQz?=
 =?utf-8?B?V2pySmxwbThhOEM3YnJQUSsyaDcrL2w3cldjOFYxdnVzeVV3RUJsaU9pVmJ4?=
 =?utf-8?B?amppSE9GbHJ5N2F4eFV3U1ZOZFlqQVllYkNkUmhSZWpXeXkyN1pQMHd6QlJ0?=
 =?utf-8?B?b2pFNEJiRklLTkNXTkg4NHZ4UWV5QThOdjBpMjZNb285Y2M3djUxcW9NajIy?=
 =?utf-8?B?Tm4rdDQ4aUF2LzBZUitFcTVVMjNPMkRwY3hUK3ZhQkxSeVZtLzJxUldPNUxV?=
 =?utf-8?B?c3pHbER4YlhUNXdGQjZJWjdRallmRWYvcVZqL1B3REMzMlJPUzBYZ2dSb0Vi?=
 =?utf-8?B?cTNqTldHWUp4aHdGRkdoVm9kNTdUOHVHK0xTV2lHVGNNN1BXai96dkNjb1p0?=
 =?utf-8?B?NFVhV3hyT1dmcWRKZmhXTEFYUlRwbElRa3lVTnUwdm9Bd0cxRmNPOEtrbHhL?=
 =?utf-8?B?N1BQaTBmYnB5V0R6Y0ExUXJ3cjB4ZEtVMzZLMEFvSEpESnJKNmRTM1NsYWM3?=
 =?utf-8?B?QWEwb3V1dXh2Mk9YcWZ1bWtGK1lzNzc3TldJNWdtRFN4SWZiRXNNN3pWVEJ4?=
 =?utf-8?B?Yjgrd1g1eE5JZ2FyQkt1ZXkwYUhqK2tsMXFNajJ1TnRjS3d6S1EvcVp6b0d4?=
 =?utf-8?Q?VWpbDMSeGDDFEVQzCbaEwNk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5394EE9716FAB54790E7385BDC34967B@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e61b83-86d2-4db1-a6a3-08dcee00e7be
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 16:38:03.5085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O3h+0QhL4YbOXq587D5933lqoPv94K/RmutC3LJsVgs9h9Up+s6Lexd0fayrylADWj238S6numjCveJJ6K2h8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB5836
X-Proofpoint-ORIG-GUID: PkSSU3q_U-5Iww-N-lVVj7OiX0Hk4Jkk
X-Proofpoint-GUID: PkSSU3q_U-5Iww-N-lVVj7OiX0Hk4Jkk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gT2N0IDE2LCAyMDI0LCBhdCA3OjUx4oCvQU0sIENocmlzdGlhbiBCcmF1bmVyIDxi
cmF1bmVyQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBPY3QgMTYsIDIwMjQgYXQg
MDM6NTE6NTVQTSArMDIwMCwgSmFuIEthcmEgd3JvdGU6DQo+PiBPbiBUdWUgMTUtMTAtMjQgMDU6
NTI6MDIsIFNvbmcgTGl1IHdyb3RlOg0KPj4+PiBPbiBPY3QgMTQsIDIwMjQsIGF0IDEwOjI14oCv
UE0sIENocmlzdG9waCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+Pj4+IE9u
IFR1ZSwgT2N0IDE1LCAyMDI0IGF0IDA1OjIxOjQ4QU0gKzAwMDAsIFNvbmcgTGl1IHdyb3RlOg0K
Pj4+Pj4+PiBFeHRlbmQgdGVzdF9wcm9ncyBmc19rZnVuY3MgdG8gY292ZXIgZGlmZmVyZW50IHhh
dHRyIG5hbWVzLiBTcGVjaWZpY2FsbHk6DQo+Pj4+Pj4+IHhhdHRyIG5hbWUgInVzZXIua2Z1bmNz
IiwgInNlY3VyaXR5LmJwZiIsIGFuZCAic2VjdXJpdHkuYnBmLnh4eCIgY2FuIGJlDQo+Pj4+Pj4+
IHJlYWQgZnJvbSBCUEYgcHJvZ3JhbSB3aXRoIGtmdW5jcyBicGZfZ2V0X1tmaWxlfGRlbnRyeV1f
eGF0dHIoKTsgd2hpbGUNCj4+Pj4+Pj4gInNlY3VyaXR5LmJwZnh4eCIgYW5kICJzZWN1cml0eS5z
ZWxpbnV4IiBjYW5ub3QgYmUgcmVhZC4NCj4+Pj4+PiANCj4+Pj4+PiBTbyB5b3UgcmVhZCBjb2Rl
IGZyb20gdW50cnVzdGVkIHVzZXIuKiB4YXR0cnM/ICBIb3cgY2FuIHlvdSBjYXJ2ZSBvdXQNCj4+
Pj4+PiB0aGF0IHNwYWNlIGFuZCBub3Qga25vd24gYW55IHByZS1leGlzdGluZyB1c2Vyc3BhY2Ug
Y29kIHVzZXMga2Z1bmNzDQo+Pj4+Pj4gZm9yIGl0J3Mgb3duIHB1cnBvc2U/DQo+Pj4+PiANCj4+
Pj4+IEkgZG9uJ3QgcXVpdGUgZm9sbG93IHRoZSBjb21tZW50IGhlcmUuIA0KPj4+Pj4gDQo+Pj4+
PiBEbyB5b3UgbWVhbiB1c2VyLiogeGF0dHJzIGFyZSB1bnRydXN0ZWQgKGFueSB1c2VyIGNhbiBz
ZXQgaXQpLCBzbyB3ZSANCj4+Pj4+IHNob3VsZCBub3QgYWxsb3cgQlBGIHByb2dyYW1zIHRvIHJl
YWQgdGhlbT8gT3IgZG8geW91IG1lYW4geGF0dHIgDQo+Pj4+PiBuYW1lICJ1c2VyLmtmdW5jcyIg
bWlnaHQgYmUgdGFrZW4gYnkgc29tZSB1c2Ugc3BhY2U/DQo+Pj4+IA0KPj4+PiBBbGwgb2YgdGhl
IGFib3ZlLg0KPj4+IA0KPj4+IFRoaXMgaXMgYSBzZWxmdGVzdCwgInVzZXIua2Z1bmMiIGlzIHBp
Y2tlZCBmb3IgdGhpcyB0ZXN0LiBUaGUga2Z1bmNzDQo+Pj4gKGJwZl9nZXRfW2ZpbGV8ZGVudHJ5
XV94YXR0cikgY2FuIHJlYWQgYW55IHVzZXIuKiB4YXR0cnMuIA0KPj4+IA0KPj4+IFJlYWRpbmcg
dW50cnVzdGVkIHhhdHRycyBmcm9tIHRydXN0IEJQRiBMU00gcHJvZ3JhbSBjYW4gYmUgdXNlZnVs
LiANCj4+PiBGb3IgZXhhbXBsZSwgd2UgY2FuIHNpZ24gYSBiaW5hcnkgd2l0aCBwcml2YXRlIGtl
eSwgYW5kIHNhdmUgdGhlDQo+Pj4gc2lnbmF0dXJlIGluIHRoZSB4YXR0ci4gVGhlbiB0aGUga2Vy
bmVsIGNhbiB2ZXJpZnkgdGhlIHNpZ25hdHVyZQ0KPj4+IGFuZCB0aGUgYmluYXJ5IG1hdGNoZXMg
dGhlIHB1YmxpYyBrZXkuIElmIHRoZSB4YXR0ciBpcyBtb2RpZmllZCBieQ0KPj4+IHVudHJ1c3Rl
ZCB1c2VyIHNwYWNlLCB0aGUgQlBGIHByb2dyYW0gd2lsbCBqdXN0IGRlbnkgdGhlIGFjY2Vzcy4N
Cj4+IA0KPj4gU28gSSB0ZW5kIHRvIGFncmVlIHdpdGggQ2hyaXN0b3BoIHRoYXQgZS5nLiBmb3Ig
dGhlIGFib3ZlIExTTSB1c2VjYXNlIHlvdQ0KPj4gbWVudGlvbiwgdXNpbmcgdXNlci4geGF0dHIg
c3BhY2UgaXMgYSBwb29yIGRlc2lnbiBjaG9pY2UgYmVjYXVzZSB5b3UgaGF2ZQ0KPj4gdG8gdmVy
eSBjYXJlZnVsbHkgdmFsaWRhdGUgYW55IHhhdHRyIGNvbnRlbnRzIChhbnlib2R5IGNhbiBwcm92
aWRlDQo+PiBtYWxpY2lvdXMgY29udGVudCkgYW5kIG1vcmUgaW1wb3J0YW50bHkgYXMgZGlmZmVy
ZW50IHNpbWlsYXIgdXNlY2FzZXMNCj4+IHByb2xpZmVyYXRlIHRoZSBjaGFuY2VzIG9mIG5hbWUg
Y29sbGlzaW9ucyBhbmQgcmVzdWx0aW5nIGZ1bmNpb25hbGl0eQ0KPj4gaXNzdWVzIGluY3JlYXNl
LiBJdCBpcyBzaW1pbGFyIGFzIGlmIHlvdSBkZWNpZGVkIHRvIHN0b3JlIHNvbWUgaW5mb3JtYXRp
b24NCj4+IGluIGEgc3BlY2lhbGx5IG5hbWVkIGZpbGUgaW4gZWFjaCBkaXJlY3RvcnkuIElmIHlv
dSBjaG9vc2Ugc3BlY2lhbCBlbm91Z2gNCj4+IG5hbWUsIGl0IHdpbGwgbGlrZWx5IHdvcmsgYnV0
IGxvbmctdGVybSBzb21lb25lIGlzIGdvaW5nIHRvIGJyZWFrIHlvdSA6KQ0KDQpZZXMsIHdpdGgg
dXNlci4qIHhhdHRyLCBuYW1lIGNvbmZsaWN0cyBpcyBhbHdheXMgYW4gaXNzdWUuIFRoYXQncyB3
aHkgd2UgDQphcmUgYWRkaW5nIHRoZSBzZWN1cml0eS5icGYgcHJlZml4IGluIHRoaXMgc2V0LiAN
Cg0KSG93ZXZlciwgYmVzaWRlcyBuYW1lIGNvbmZsaWN0cywgSSBkb24ndCB0aGluayB0aGVyZSBh
cmUgbWFueSBtb3JlIGlzc3Vlcw0Kd2l0aCB1c2luZyB1c2VyLiB4YXR0cnMuIFZGUyBjb2RlIGRv
ZXMgbm90IGJsb2NrIGFueSBhY2Nlc3MgdG8gdGhlDQpzZWN1cml0eS4qIHhhdHRycy4gSXQgaXMg
dXAgdG8gdGhlIExTTXMgdG8gYmxvY2sgcmVhZC93cml0ZSBvZiBjZXJ0YWluDQp4YXR0cnMuIElP
VywgaWYgdGhlIExTTSB3cml0ZXIgZGVjaWRlIHRvIHVzZSB1c2VyLnh4eCBmb3Igc29tZSB1c2Ug
Y2FzZXMsIA0KaXQgaXMgdXAgdG8gTFNNIHdyaXRlciB0byBwcm90ZWN0IHRoaXMgeGF0dHIgZnJv
bSB1bmF1dGhvcml6ZWQgYWNjZXNzIA0KKHZpYSBzZWN1cml0eV9pbm9kZV9zZXR4YXR0ciBob29r
KS4gDQoNCj4+IA0KPj4gSSB0aGluayB0aGF0IGdldHRpbmcgdXNlci4qIHhhdHRycyBmcm9tIGJw
ZiBob29rcyBjYW4gc3RpbGwgYmUgdXNlZnVsIGZvcg0KPj4gaW50cm9zcGVjdGlvbiBhbmQgb3Ro
ZXIgdGFza3Mgc28gSSdtIG5vdCBjb252aW5jZWQgd2Ugc2hvdWxkIHJldmVydCB0aGF0DQo+PiBm
dW5jdGlvbmFsaXR5IGJ1dCBtYXliZSBpdCBpcyB0b28gZWFzeSB0byBtaXN1c2U/IEknbSBub3Qg
cmVhbGx5IGRlY2lkZWQuDQo+IA0KPiBSZWFkaW5nIHVzZXIuKiB4YXR0ciBpcyBmaW5lLiBJZiBh
biBMU00gZGVjaWRlcyB0byBidWlsdCBhIHNlY3VyaXR5DQo+IG1vZGVsIGFyb3VuZCBpdCB0aGVu
IGltaG8gdGhhdCdzIHRoZWlyIGJ1c2luZXNzIGFuZCBzaW5jZSB0aGF0IGhhcHBlbnMNCj4gaW4g
b3V0LW9mLXRyZWUgTFNNIHByb2dyYW1zOiBzaHJ1Zy4NCg0KVGhhbmtzLA0KU29uZw0KDQo=

