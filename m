Return-Path: <linux-fsdevel+bounces-33361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52649B7F71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 16:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22174B23681
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 15:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937C11BBBD7;
	Thu, 31 Oct 2024 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="KeNNfXxr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BDA1A0BE3;
	Thu, 31 Oct 2024 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730390230; cv=fail; b=QBsT+2Oqfv/jyjlPNknTK1dqyrCddb+fmBEiAAxkBI1ahPUg2G2NCT/NNepZEei+lrQcwxxOkXtGmM1+8E0y48txh7KbLJpCvnudHbAarka65bhZq7TmNKwm0QzBjGbgMRcjIqPAyE3uANxCtOamoxdwR132BJRZqmyBOZ7WdW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730390230; c=relaxed/simple;
	bh=fyFLxh0wFJaMFdKFtFy1hU4Ek4bZZjoe5uTU/ITiEyI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KNt8Z9jHkcFgloTDT+DTY8xLa+JJNwMfynae3tdog3nCV5fiyEBedmuGaNt3UKB4U8Vpj3p3X7AibXFKI2TVw6aJguGTJSjvoGhPsATVu/686djAjua3vtPizcOIywFEuMMjS+dHd73BZbK7cG5V5qTmcAx1AASa/k2GIN98iKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=KeNNfXxr; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49VCwA8Z018033;
	Thu, 31 Oct 2024 08:57:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=fyFLxh0wFJaMFdKFtFy1hU4Ek4bZZjoe5uTU/ITiEyI=; b=
	KeNNfXxrihlMNAIJxO1AI125KoYOy1ufkwUWe2Dwx9qNT/1KjIHxELFq/ruwmqx4
	UtP1yB8Hk/sUj0biiMzbYylU3pjOQeMvvvpK08ywI0Qpqt0N1LyqmpEoLH9DIeKZ
	OJFnQFGbpEOBZH5CkaakAtalA9zJJhhBpxS7kDBZFCnzVQHgoCUEwmpsKTdWA4Zt
	CDo9fEnRU5y4N/0VUMN+Ol2e6SAKHIXOWRZ4HV3y6kPFmN9H7oPnWsXfAush+b3Y
	+d+/Yjp0Y9Wy3GqFcaRWi0MnuFXmJGlX836rBYEvcCyqlb0F6JYfh3GR5vmxllth
	15V3iPolGWLVbBdS0L3pWw==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42mac09jkx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 08:57:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7c1D4y4OTGF4TwX2OJjY6S+JZXu5r0XA40gRidJapWfQ/3wNJC2JUZc1gAHtIQAOqCQoW7HhEF+A0YSYSIfmONlm8vWYFMtuu9a8zgFbA97VqG3omNiq1uGTSWMWsb8bLl4eYQD4zhSlNykwEFvsgnV591mI/6WT5fYlMWQP+bY1xF8CfcXONJojxMZR36W3MLpiwdIS+w5MXgtjXhj5WaHn15WQ0pI2GYj1XCugEZnaqIAKaLt9PG9YkqEe1KbXsMDfOrMtrAuXIs2lDkCQfkvEOanPxRpcrWWdlmA4heTYGejr74/RIXBKxIMTwj1P5rVSWuJns0mGxphX4ZoKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyFLxh0wFJaMFdKFtFy1hU4Ek4bZZjoe5uTU/ITiEyI=;
 b=lyXSdoFsh1ZO4ucZG9PRdk+eIoqVN6Ek1KWdp6Ar5xS/7yNsUcWazOnbKeXVAzaJQEtj8wl4AHYS0cu1KR4gF7/PkyMQCJp1IeKzC8Zy07BsHLYsf/7TMPDJ/EAgJPmBA6ycKB+6lH46RMH6Wl3gCGmPl47rwDUlbfRpBGwhQye8wgN8cjdnbzR/E7j2Sm5lGcTRZ6B0vslDxETuY7B6l9SkR+Ck6T3+MtLePCYIFa3mjASnBZ7+8Nn9hS0tfGH1pU6SBbPVHaUIBL9wgIqOcgZviyvxgZkTk0GCdSntuoOZy8xacFKjGkFEFTQifH04xD0f0JY5tkvo+iUJM5ixqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BY1PR15MB6151.namprd15.prod.outlook.com (2603:10b6:a03:533::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23; Thu, 31 Oct
 2024 15:56:54 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 15:56:54 +0000
From: Song Liu <songliubraving@meta.com>
To: Christoph Hellwig <hch@infradead.org>
CC: Song Liu <songliubraving@meta.com>,
        Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Al Viro <viro@zeniv.linux.org.uk>, KP Singh <kpsingh@kernel.org>,
        Matt Bobrowski <mattbobrowski@google.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Extend test fs_kfuncs to
 cover security.bpf xattr names
Thread-Topic: [PATCH bpf-next 2/2] selftests/bpf: Extend test fs_kfuncs to
 cover security.bpf xattr names
Thread-Index:
 AQHbFRSqQ+6V3A7WhE2nOTZ+DtSM+rKHVfgAgAAEFACAAAEygIAAB0MAgAIYdICAABCugIABlcCAgAYtkQCAArUZgIAL6sEAgACrMYCAAJbMAA==
Date: Thu, 31 Oct 2024 15:56:54 +0000
Message-ID: <B6CD210E-96C6-4730-BD05-EC3A0C6905EB@fb.com>
References: <Zw34dAaqA5tR6mHN@infradead.org>
 <0DB83868-0049-40E3-8E62-0D8D913CB9CB@fb.com>
 <Zw384bed3yVgZpoc@infradead.org>
 <BF0CD913-B067-4105-88C2-B068431EE9E5@fb.com>
 <20241016135155.otibqwcyqczxt26f@quack3>
 <20241016-luxus-winkt-4676cfdf25ff@brauner> <ZxEnV353YshfkmXe@infradead.org>
 <20241021-ausgleichen-wesen-3d3ae116f742@brauner>
 <ZxibdxIjfaHOpGJn@infradead.org>
 <41CA4718-EE8E-499B-AC3C-E22C311035E7@fb.com>
 <ZyMqOyswxw1s1Jbt@infradead.org>
In-Reply-To: <ZyMqOyswxw1s1Jbt@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|BY1PR15MB6151:EE_
x-ms-office365-filtering-correlation-id: d5fc3787-fa2d-4948-693b-08dcf9c4a40b
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R3p5K3FGOTF1WHFjU3U4c290RW5ta1hvZ1NTOGJvYVJ6SzJ6aStpQVpiK2tn?=
 =?utf-8?B?V2Vsd0lEUUsvRVB2b1RHVkxNc01IN0Vjc2lIMXVWUEhIZFV0VXYyd3dtSjds?=
 =?utf-8?B?T3F2c1dkSDNZOUhKUEl3QVgwT3pTdDJaTXJRQTNKZzFzMGlTWGVLQlhUcDJy?=
 =?utf-8?B?VzNUMmE0ZGVlT3BySFRHS0NnU3JBT21idThRYnU5cnJFTmFaUWV4a1pjcjhT?=
 =?utf-8?B?N1p5cjJydnRrWlNsUlh6NWxnQmZnUlI1MEw2RTczaUVESUdDT01FbFViUXJN?=
 =?utf-8?B?TEdSaHJKUENJNFp4ZzhUVE01ZEJtc2Q1c002NUFtTnpEVzFxT2FHdWlmK0Ir?=
 =?utf-8?B?MklPMDNlVUsxMWlpMjU5ODBKQnlTbzRPRlBZN1BNbVFpNm96NlhKenlsQ3RU?=
 =?utf-8?B?SnVyTUhnOFE1aFUwYTE2cm45VEQ4UFpHRUFheG5mVGxYM20vK05oLy95ZzdE?=
 =?utf-8?B?NE45cUhDYzdzZ0kzelVNREJKbmFxZGJFN2pjd3M0dHc2dkJMdklVZGV4cDB0?=
 =?utf-8?B?WXl1ZHNRbU9kRU5PQ3RLclJoSjJNZ0J4R1QwT0N5enlDRDdEU2pzalRvTUZ6?=
 =?utf-8?B?bTJ2STlxR3BEQWc4V2RVN3UyVUg4ekFmMXlrR0t0V29aZ0F1SC9MOFR4aWFh?=
 =?utf-8?B?UUF6dkxWdkdBVWVoOWJQd3RBY3dxQ1B1NTdUUVpLOU10bUt4SXJsN2ZzSzRw?=
 =?utf-8?B?a0gycTdFMEMwN2JGUitCOTlXWlNGMEJYR29PdmN4TkViRi83UVhUWk1VcGhX?=
 =?utf-8?B?RXAwRDJaOS9GcTFGazF1MkxIaVViYnJ1NlJ1YkFQb2RObVZoODVMM0lxNkRx?=
 =?utf-8?B?T3VrcFpLSnZQdzJyRlhseG00NzFUM25UT0F0Z2JnbzNINXhMN0FCWDhmUkg5?=
 =?utf-8?B?OFduNnE5WGhaOGk1NWJwbUl3Z1JvZWM2VXV6ak1kdnFUUWl4YW81cHJ6dW5R?=
 =?utf-8?B?SG5PSFVKVFNCRXBNWmdzdWNIWWJLOWd6SVMvOVJsQjRFUEFUSCtvZ0dSelI0?=
 =?utf-8?B?cmFEOHVnb2VTMzVNeXlITCtIdHNrbEtvVzdpQlJsRndDeXpCL2NpVE5GM3R2?=
 =?utf-8?B?Ry9GSkRnZWRlZG9TbGlSd2hKY2hUWlN0dkw0UkdaZ3NHSU5CVFdEVmVOTlRZ?=
 =?utf-8?B?UEt6Q2xWYWpWWjZaZE5zcmw1N1JzSUxsLzM1T09sYWFucWRWclZENG5TZ0tP?=
 =?utf-8?B?RFBmbmk4V3FDVmdkVnA2dDQ2c0NjVW5IV01qYkh0WEQwQUUraWxHdzVjT0F3?=
 =?utf-8?B?NVIzZ2VhVERQTC9DaWpFNnhsQkFWRTJ1STNFaldUajJVSkZWZVdkUUozY3hJ?=
 =?utf-8?B?SDdLN3BjVW1qMGxVL1d1WFM0MkgvQll0b2hFcHhibEtQVUczY3RONlF4ZlVn?=
 =?utf-8?B?bUVVRVBvOFRGMUlWNW9QSTlBbGM5eGlJa1p0UWhSOXFXemE2YytIanlCTzN6?=
 =?utf-8?B?eUl0RXBJbVNFVjZjd0FpV1NVYlFuU1RMeFR4YnBwdit2YnBzQ2wwWVBoeFVq?=
 =?utf-8?B?RjBwRThmblIwdHFpbGFENlczcEoyS1l4QUljZnNZUW1XODJIV0U0SlhMMi9X?=
 =?utf-8?B?TU9CUjNHSEJvZ0tqaS80ZWRDUWUzR1MvR1ZNRjhlOVN1aHdzUlk1bnlzSmNp?=
 =?utf-8?B?ZUg4cTN6QjAwVzY4a2pKSHZ0Rm5ReGhpNkR2V1hZUFFSV085RzQ0cEp1eG5m?=
 =?utf-8?B?eUhzeStVSUJBUG1LUTBKSkE4eHFJMEhuM3lYdFFXWGtkZWVqT0hTUXBCdThs?=
 =?utf-8?B?VjN3WXd0ckl1M1dlY2NXWU5LUXVlSGdjTHFyRU04UnQrMVlTRThXQVhkeUxD?=
 =?utf-8?Q?mek4Mzng8J6oFmeHraSw0YxWC6qkf4FtcnST0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MWZYRUg2aTJCWDBjNUEvWS8rT3hqbXZ5TUUvQ2Q0MzlwSmQ1b3lqdlNERC9I?=
 =?utf-8?B?RTdjQWFmK1FPRGEvWXZjRDNjWlpUdVFTSVdoSzBVdGowc2dUa2l0YkczSkMy?=
 =?utf-8?B?YkNhQ1poV0g3UEYzbXJqcDV5RC80dkpjTS81ZjRubmlMTzAxekp5dmxld2Rs?=
 =?utf-8?B?ZmRoYklFS2xjOHlrM2t0Vm5VeXQyY0RxdHY0N0F4VmZTdFBJWDk0R01nL2RR?=
 =?utf-8?B?d3lOdk1iMUs0a3hoRnFDZEIvRlIyd2ZoZjR3NzZuT2JVbERZNHVoOFYrUHUw?=
 =?utf-8?B?NjIzUjg5TDFFeEFYcEdYSWZibVRSRWtUckVHcDBXTWxFRHJoVERDRlZwRU9Z?=
 =?utf-8?B?WURZRTh4aytQQkpOUFFETEdYa01KcnJuWXE4SUVNMlVxOXFXLzRGTVhvTFA4?=
 =?utf-8?B?ZC9nVDlYQXpPOWw0cUdRejh6dmg0YjJMUC93Y09OeDVsZlZEdVliVkRqdzBE?=
 =?utf-8?B?Q2Vud1JBSVRNb2VhM2NWZWlqNVh3Sk9nY1FZQ0ZZelo0YWRBbmxPYUNxcm1Y?=
 =?utf-8?B?dXcrQkpTaDZ1YkFVTE1aa0JUejdoQ0I1bThaUXMzbHI1djZhRHAzSkFTZHVE?=
 =?utf-8?B?SGpBbWVmYXU0NTVjWTBWbWhLZFIrM2R1WEpzNDFkVGpVTFNiZlNEVy8zOGZE?=
 =?utf-8?B?L29URGUxb0RXWjJDYnp3cnRxQ2FjL0t1anpCK0NDZXBpRldxeGo0Z1JxaDBO?=
 =?utf-8?B?TXhRZFUxU3BxVlV6VnBIdXVTY2xESTdUeE90TVBsWWNadXI4SjJXUkJXM1pQ?=
 =?utf-8?B?eUpqR2lQNjJ0djlvMWdTTDg3dTRkZWdDSGVJdnkvdlFpMjJaWERCMnhIcXVp?=
 =?utf-8?B?eUZzaS9WOEFra2xIblpEQ1VkbEtUdmtnNlA4YXhFSURwQkl5eUtrcmdEUFVy?=
 =?utf-8?B?RUVYLyttWG50b0l0YTlqY2xMQVphdmpRWkMyREh0WkV4OUFKNFR2bGNRbFF6?=
 =?utf-8?B?U0diZHZPUE1ZM24xMkdwQlVQREJ4WnRhYm01YzNCUnhVazJYbW82eUNrbHIy?=
 =?utf-8?B?R05VUzA4YnZEUXQwY2FoMzF2TFBRdE5VWUE4Mkl6bjhRTWdUaVNPUlpHVjBF?=
 =?utf-8?B?R2lWZ3NPZDNRemRFVHVIMTQrUGUvdFZWQ1JqaGhOU09aVFFlQWliVkZaSnhm?=
 =?utf-8?B?Y1dvUmpUckJPUHgra2ZTN0JQZ1BZVHdFMFlnNDlNcTArSDlGQjdWMGw4Unho?=
 =?utf-8?B?WXpTK0dEODNIZ0EzOExQbEVyeXAvU3VDYytNY1BHWEduVElYMm9CK0VUaFFG?=
 =?utf-8?B?eUNlZHBZREQxYlIrWE1sbEs1QUZGNjRieTFDWEs3MFpJSVVsSWM4d3FuK1Jq?=
 =?utf-8?B?Qzc5V2sva1k2YkNNNHVBeTExNTltcUNUbEE4TUc0bXFyY0dTaEZURlozUnAw?=
 =?utf-8?B?cmtJb3NuUzR5eWVISEtiZGorSTQvbTJOOCs5LzJVYW12Y2sxczlJYktYRzZR?=
 =?utf-8?B?eXpiNTBmZktEZHZrb1krN3pOaTI5ZHpkdTJLUFAxRGhLTFliQXVlOG5jV0I4?=
 =?utf-8?B?YlFnU0hpdjJXUWxpakpQOE1PQXZXNzdkMXp1ZVRvVllyT3F3WG5IOEtHTXRD?=
 =?utf-8?B?Zko2WEJnTFViUE9paVFpR1BNT0ZzcXpQR1lzOWRNYU9KNEhIalh1cG9QWGtF?=
 =?utf-8?B?M0tEZWcxZzlNaHpPNlZiOU4xcTBKWmk1SnhjMDR2M3l3RTV6dzVXcGxRQXhX?=
 =?utf-8?B?M1BYQWRacXdkQ3dXN29CVXVBaUVyRXBqaGp3UHhIK3hBRkRWYnBkOUJRVXJM?=
 =?utf-8?B?aGlaV0hZUE0xVFY3akR5dXNDQks4SGlSbE90cVZNcnQxYy8vT05KYkFJMGZy?=
 =?utf-8?B?d2NTUkRMZnJISFI2bG1HMGNHbVQ4T3lVR291bHhDTzJSaGVvencxbG5pdmkz?=
 =?utf-8?B?TFRUaVU3M2Rxd0tsQ3hESTk0RXBGeDhhNUJxcnRna0JZRUk0Tm5mTEhsalMv?=
 =?utf-8?B?bjAwc1ZzcnFPb2xlU0FuM3BEUjZ2QzZXbHdiZEpTSjNsc1NGZVpyRGRJRDhk?=
 =?utf-8?B?K1gxVHdVMVVTc2FRUXlnYSt0Z2pBQ1dKVkNHTTh2STQwc1ZaNStVekFkQTAr?=
 =?utf-8?B?akw5d0JjS0k0Z2l5WC9TM21lOG5hTmtPTVliUWFkWDJ2K2QxaWErek1JSk9C?=
 =?utf-8?B?b05LTlFDdk8zbUVmNjZwZUZsQ280ckdSRmNLWGVORTdoR3dxSWV2VUdoS05z?=
 =?utf-8?B?LzFqeWhIcUVhdytUY0JCdTNNUHJWMkFaakg0L1hjZ1Exdk5qb0JYMVh2OW41?=
 =?utf-8?B?NjdZbWNTRUhlN1ZGdmk0TlNhd2ZBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19C9809890F38F49A1CAE857EB356277@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d5fc3787-fa2d-4948-693b-08dcf9c4a40b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 15:56:54.0488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ylfd2kX0rwcmJKfjutjhqcDqtD9lHAS792v0RnX6T+0LFMI6RGz/dTuShUxQqmDiDci/zPH37kCe0317uKD/xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR15MB6151
X-Proofpoint-ORIG-GUID: O0h9cdEVfx7s8eo8XGL6UDZtIcOF3W8s
X-Proofpoint-GUID: O0h9cdEVfx7s8eo8XGL6UDZtIcOF3W8s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gT2N0IDMwLCAyMDI0LCBhdCAxMTo1NuKAr1BNLCBDaHJpc3RvcGggSGVsbHdpZyA8
aGNoQGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBPY3QgMzAsIDIwMjQgYXQg
MDg6NDQ6MjZQTSArMDAwMCwgU29uZyBMaXUgd3JvdGU6DQo+PiBHaXZlbiBicGYga2Z1bmNzIGNh
biByZWFkIHVzZXIuKiB4YXR0cnMgZm9yIGFsbW9zdCBhIHllYXIgbm93LCBJIHRoaW5rIHdlIA0K
Pj4gY2Fubm90IHNpbXBseSByZXZlcnQgaXQuIFdlIGFscmVhZHkgaGF2ZSBzb21lIHVzZXJzIHVz
aW5nIGl0LiANCj4+IA0KPj4gSW5zdGVhZCwgd2UgY2FuIHdvcmsgb24gYSBwbGFuIHRvIGRlcHJl
Y2F0ZWQgaXQuIEhvdyBhYm91dCB3ZSBhZGQgYSANCj4+IFdBUk5fT05fT05DRSBhcyBwYXJ0IG9m
IHRoaXMgcGF0Y2hzZXQsIGFuZCB0aGVuIHJlbW92ZSB1c2VyLiogc3VwcG9ydCANCj4+IGFmdGVy
IHNvbWUgdGltZT8NCj4gDQo+IEFzIENocmlzdGlhbiBtZW50aW9uZWQgaGF2aW5nIGJwZiBhY2Nl
c3MgdG8gdXNlciB4YXR0cnMgaXMgcHJvYmFibHkNCj4gbm90IGEgYmlnIGlzc3VlLiAgT1RPSCBh
bnl0aGluZyB0aGF0IG1ha2VzIHNlY3VyaXR5IGRlY2lzaW9ucyBiYXNlZA0KPiBvbiBpdCBpcyBw
cm9iYWJseSBwcmV0dHkgYnJva2VuLiAgTm90IHN1cmUgaG93IHlvdSB3YW50IHRvIGJlc3QNCj4g
aGFuZGxlIHRoYXQuDQoNCkFncmVlZCB0aGF0IHdlIHJlYWxseSBuZWVkIHNlY3VyaXR5LmJwZiBw
cmVmaXggZm9yIHNlY3VyaXR5IHVzZSBjYXNlcy4gDQpSZWFkaW5nIHVzZXIuKiB4YXR0cnMgY291
bGQgYmUgdXNlZnVsIGZvciBzb21lIHRyYWNpbmcgdXNlIGNhc2VzLiBXZQ0KbWF5IGFsc28gaW50
cm9kdWNlIG90aGVyIHByZWZpeGVzIGZvciBmdXR1cmUgdXNlIGNhc2VzLg0KDQpUaGFua3MsDQpT
b25nDQoNCg0KDQoNCg0K

