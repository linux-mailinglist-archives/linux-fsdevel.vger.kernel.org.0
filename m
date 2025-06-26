Return-Path: <linux-fsdevel+bounces-53097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9038BAEA086
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 16:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068AA188B517
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 14:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590012EA47E;
	Thu, 26 Jun 2025 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NWyNCTvB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287B420C48D;
	Thu, 26 Jun 2025 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948125; cv=fail; b=mStbAl6C4pyi5Kqyb8+T+3l+d3DQlk0wc9jcvOtX5PzbveeSlbHqZciugYfxo8cAYpLcmnLEb5q2yVOgkagGujpCkEuPSpW0fUyVRne75Dvc5IYhncvw4k1v71oiZYLmPgVTKsrk5ZXVEvsfXUOC6bpSV3ehcyo9kc3KNeeptyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948125; c=relaxed/simple;
	bh=FPHjyOmxZ+mCm+d3ATQLv5cNb3iU5mgjoMIBg760ABY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p44TDWhUkNBxnV1+PwlrJjMU0Pqo7coWua4N2jS6ZPBujGwKy6dH3AEPdDXsHY/X4qureSLeVUi9skRI3E81LeG8Mq/NGqQ9PsTd7g8+pPSFh5nOQFBqyABk2VC+DKogSP1aEJIgmrB2lPBmhv83lNWSsfTZ9Y7HsT2FetZkP2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NWyNCTvB; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QCVvu4023727;
	Thu, 26 Jun 2025 07:28:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2025-q2; bh=FPHjyOmxZ+mCm+d3ATQLv5cNb3iU5mgjoMIBg760ABY=; b=
	NWyNCTvBu25eFQgbxob7zGkzmDdp/jBteg7hhvc2h11oAUVQxXF3ZCEA5eh9Df8y
	Hl0Uyc96abeErLYB/98X6L18SvkDNU1QuHrZEQ+NkiOYqHOKOlE7ucPygnnorJOL
	/XWK576K9200r3LG4AS2peswzCby5ewd1qp8vV1w4oaISO8luZAV8YmnVq6iv5A+
	KNDWMf0D+o6w3pc89AiGerOR/GrAks9XH99+33b4MdNxqw/tHugbCMaA2HZ+i3PF
	Ci4J7nM1YinNFCgmJNcEB16EvCwg2V2ya4Z17fgOkrWOAAm6Xp3X46dbw6gjErmf
	8C/JkN7/Ewxvx5imSRJQ1g==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47h17kagd6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 07:28:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xaYhjv5lRXBMhI3hw6U/lrsrUNnltEXGBF9wbDL/MEFzL8o3UgC7/yHTyrL/u8tIw9S3tP7DV+F3DzZP1/AQ2/mRzC56MzWbotOXQNeoUCz6/lp39Kfj5K5N+26qbO9LCGDUqmBQUZRRdqicoDKEveqqXlX8UibCZIK+dMGoiEsEEQMf+qCGu8DE84yUrDvzChn/4R0KUg1jv8HhxVhO49b3I2/gknSQNe1lihwEi5OWjwbZfjCuG2SubBx1vTOJpv9MyaKtklldlJybAQVgY1Ipd4lVXs8U/3fq226qqHhdIJfyanf1nzVoplqLvwZ1lyZ8F2zCe6kHMMvfbogp7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPHjyOmxZ+mCm+d3ATQLv5cNb3iU5mgjoMIBg760ABY=;
 b=ukjEcp9JM5VgSvTdUOlpMStfcvzXLK+T4ptYu6rwit/mWPQr5HmvS8kna2VjAHCnwN71V98XT1++hUOLyh+0nzkUWI8DHRCjdroEegZuCl75kzyu1fFXYp8+NeGnpUuhFoQbVtpRSJ+qDalQ3vZztSydVcWUZ8TeJ/GnlUAdzvGUgvdPToXRNulz4M8ulDANOKJP1MK7aylioSwsi1OPlwn5HefSUJBIZFRkPrBUfOZY6nLiV71pBw7QBbVn673q1esNlZihLKubqOagN21l3KgPa50AFLvsPdqkh16LZaR0yxSgZKv8EpXHs3x3qqjDT7VWrlmxu70vm84FoUkzhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MW4PR15MB4523.namprd15.prod.outlook.com (2603:10b6:303:108::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Thu, 26 Jun
 2025 14:28:38 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%6]) with mapi id 15.20.8880.015; Thu, 26 Jun 2025
 14:28:38 +0000
From: Song Liu <songliubraving@meta.com>
To: NeilBrown <neil@brown.name>
CC: Tingmao Wang <m@maowtm.org>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?=
	<mic@digikod.net>,
        Song Liu <song@kernel.org>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "brauner@kernel.org"
	<brauner@kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org"
	<andrii@kernel.org>,
        "eddyz87@gmail.com" <eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net"
	<daniel@iogearbox.net>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz"
	<jack@suse.cz>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com" <mattbobrowski@google.com>,
        =?utf-8?B?R8O8bnRoZXIgTm9hY2s=?= <gnoack@google.com>
Subject: Re: [PATCH v5 bpf-next 0/5] bpf path iterator
Thread-Topic: [PATCH v5 bpf-next 0/5] bpf path iterator
Thread-Index:
 AQHb306ox9XN8K6VdkCbVuOe+nEEeLQMnoWAgAYTUACAADBQgIABBU4AgAClEQCAABGDAIAAECWAgABQToCAAEtZgIAARLiA
Date: Thu, 26 Jun 2025 14:28:38 +0000
Message-ID: <127D7BC6-1643-403B-B019-D442A89BADAB@meta.com>
References: <9BD19ABC-08B8-4976-912D-DFCC06C29CAA@meta.com>
 <175093334910.2280845.2994364473463803565@noble.neil.brown.name>
In-Reply-To: <175093334910.2280845.2994364473463803565@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|MW4PR15MB4523:EE_
x-ms-office365-filtering-correlation-id: 7e5e107b-54ba-42e4-001e-08ddb4bdbdbf
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ejgzYm81OXlvL0dXaUc4cDM5MlNVYzFJRmwrOEdwRnJBVVF5N0lNVzhLQm5u?=
 =?utf-8?B?cXkwYTBDMmxYZXVERlZSNGpOWkJpV2RYekU2RXQxM1F4cmpINVBxenU5UGRu?=
 =?utf-8?B?U3NwSFFna0swbmZvYm1neldmdlBpdFJOcXMySHRVN0lIZk1MQWY4aDYyN0gx?=
 =?utf-8?B?VDd3MkZrdkhOTjRMN0Z0WnFYSnVORWZPcCs4cG8wck1MeTRiaG51THdsOVc0?=
 =?utf-8?B?NjIvd2lTUHo3d2tReGNkOVhzeFJYWWVZZlVxTnczc2JvRktMTkdCWm04UGN2?=
 =?utf-8?B?VVNHUkEyeG9sYThZR1hKV29oKytPcklPSG9SMitTL0tMUXBkQUlkMko1b3Rl?=
 =?utf-8?B?MlVqb2NsUUpxS3plRlpMOE5VSzNOZXBSRHFmVlVsV1RnQS9NRkFTRTJjSVFu?=
 =?utf-8?B?U1hQVW8vNVh5WmlQdGd0dGsyZU1WWDRUK2E0KzZJZEMyV3MrbXY3djNHUlkx?=
 =?utf-8?B?RmpLM0JCY21GUHkySXl4OW8wV0l4UGVrTWx2M2hMUXROblgvTUpvcUpkeDBQ?=
 =?utf-8?B?VS9Nc2hoUGlzOExlOUpsSE9temhGOUN4RTlzSDZVTTVmWUcyR08wTVZpMjhN?=
 =?utf-8?B?b0NIUmZvdFdwdUkyS1Q5K3F0MThqRWNzS0J3T2cxQWdORU8wbnF1TCt6Z3Js?=
 =?utf-8?B?YmVpVmMzMW9yMHBnb05mVVRqN3lhOC94MnNXRnNHQk5XaUpYK1J3TWtvV1E0?=
 =?utf-8?B?TE02d2lkaTJVUUtoeDJDT3dvMC9rNmw1Q0lCWVRnY0EzTDBkc1pnK3JBSTNp?=
 =?utf-8?B?blEreGRjY2RoUHczTjBEMEVSN09uN2pJN0kvNnZJQWVGTlZkcnBJbnN1YzVK?=
 =?utf-8?B?enA1VlVaQUFYUm0zV04vMysrK0xiWnV4WmFPbGZoK25oMjBRb1pNS1VDMzlO?=
 =?utf-8?B?UXlzYTF3eVpzdnlCdnh5ZjdQWCtCaDJqTUVMUEFkMk43L3ppeGxuYzd4V3hq?=
 =?utf-8?B?Y3QxVGdrUDFDekkyMXdITjByS0lnZXUyWVYvUVJtSnZvNVBXN29KV0RCcTdv?=
 =?utf-8?B?OWNWZ0pHZm8rV1hzSlQzTVd0TVRxdlFSY1ZDT1Z3aGZ6dmkvTzdMdVdOb0x3?=
 =?utf-8?B?RDVra2Fkd1VEbHNtYU5GUGZ6TkNTbFZseVcvbnBQc28wWHd5RlA3ZDNoMTY1?=
 =?utf-8?B?SkMxTlVScTZmMVd2T2Y5Qjk2SXBtMkRnRXhiVHlEaVZwUVM0Si9jK0pvTVhG?=
 =?utf-8?B?VFRIKzRONXg4MUF0MHh2UFU3SVB6dzdpUlBDeHRRam45SGtuZjFUb1VCekpK?=
 =?utf-8?B?YnQwNDVnT2lnOG5Gdm5Ka05JamRseE9VckJUWWpraEsreFhySmJoNERXV3Zo?=
 =?utf-8?B?N2JsVHhXdFBKWnZsYlFxRm0rcVBmQ0NQbmdDcFJjRlVqM0o5YWRla2JGUjVJ?=
 =?utf-8?B?S2JzRGxYeWlQeUYyUGExblNpMFZSekhJOGNmNHNWVUpQZTV6U3VEdE54QVR4?=
 =?utf-8?B?ZVZoVUNsVXlhTWkvYzZpeUNjV01sdHh4NktMY2xORmRlL2w0aUd4NnpxMGxY?=
 =?utf-8?B?Ti9peldVQ2xlL2ZINm5wa0VuVkcyNG5Zb042a1BVdi9lLzFNbXJmcjZZOUZD?=
 =?utf-8?B?SU5LSU5FQ1lXR2FSTjBFaUdmRTcraGdvT3pyMFNObU5JSTlKb3NOTGl1OENH?=
 =?utf-8?B?SHpFRDNNcURZWWdydU1LbVdrblI2Z3ZOaE50MnJydG9NckdFd1hVVHdYaWcz?=
 =?utf-8?B?YUcwaG9XMm90ajB2SEhIamtjQlczMVlFWGN5eDh6aFNEenRWYWh2Vlg4ZVIx?=
 =?utf-8?B?ZEd4ZnVaa0lrZWc2V3NlaEZSMkZpNnJxdXl2NVpsdzlYL09HNWowZ25URHBD?=
 =?utf-8?B?ZXVMU3BvUXJ0Z3M4RGJTQUJYZ1NhdVo4eXF1alRiZjZ2c2F5VjJwYVFCT2xR?=
 =?utf-8?B?SU84WCtpVUF1ZnhkWDRpVktsVUgyeURVSXdRbXkyVVRsbkhCU3dhTmFxcVQ4?=
 =?utf-8?B?bThsV3ZqUkZCMnBtYUhwTDJpY0ZFekQwOFBkbGdoMGJhTG1QVUhnVk9iTDhM?=
 =?utf-8?B?SUY3VjlFQitnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWkydXRpZW80cFY0Ym8xMGkvbWVoQngxMDRVRVVQdXJSdEFLZ2RpRXY3QTQx?=
 =?utf-8?B?WlRPK1FCdExUTExmczk3NlBldGVDbW5Vak5wanVlRjhzcFViWEEyS05IUkZy?=
 =?utf-8?B?VzMwME1SREYvUDdlblE1M3QvalhhWHV1NkJNc0NxL0JwelpKcTBDV0lLTmNw?=
 =?utf-8?B?djhFTmo2VGQ1M1VsS0I5Z0RWNUZGTVplUUtqYThmMmpQOGVFL2JGeFFVdkdr?=
 =?utf-8?B?ZEdHVlJvN2Fway9EQUN2enhBRlE5a0ZSOFFqaXZsTytzNUZGZlFrNUxQcnk4?=
 =?utf-8?B?RE8vancyVWNJb2gvSHJzbHlNRXNvWjBBbjB1OGxhS214V01lcG9sQUJtam82?=
 =?utf-8?B?VXQrdllsU2x3dlYrclF2YkhvM1Rhanc2cThodTRiZUowMWQrNm9OL0F0Zm9C?=
 =?utf-8?B?NW1jOUsvTC9sbkVySlo1VkhtNDhLeXhlaGlyMkZ6L1YvczJMK2RxTm9kMU52?=
 =?utf-8?B?VnRyN1NSK004NG40VHlnRjIyVSsxdk42U2hwakd5a01KRXVabTR2ZkdWaFZT?=
 =?utf-8?B?cTBJZGpneHZiakN2NnU0dGVWY092OWw4L2tMSittNmxiTFlENXFSbjRFL0lK?=
 =?utf-8?B?VzRydlpvdzlaMTFyT1JVd2sxVXh3S1VHbmVWdUpmUjF4VTdjVnRzVmRidjhH?=
 =?utf-8?B?WDlyM1c1anc4QUdVK1ppNm4za2JMaEpRYmZrcHVxOFZpVVRyNkFqYjlaNmta?=
 =?utf-8?B?Q1IwMkhXalV5MzR6UlkvZytYZ3duYy9YY1NpeHpnWHU0OVg5MllzNGc5anlI?=
 =?utf-8?B?S1BWa3VVa0JCM0NKbGZPVVdUU0EreW9oMjM3dVRWYnpqTG0zM0hBZVU4MEhV?=
 =?utf-8?B?WVVTay9vMzhVYjF3TnVvZFptSEhYa0RPKy9YM0lWU2VjaTFiblJKTjJiWWRv?=
 =?utf-8?B?NUxPbTNDaFhuWjFUckJxdDRBRDIrNVZUQS96VjJSSFNhMjhlbDdldkxKZU9a?=
 =?utf-8?B?ZVowcVJKSXRnZ0J3elJpSFZmWjJpZmRITHBoWVZaSFNOTmorV01oZkVtMGVX?=
 =?utf-8?B?dlVET096emNJM2JtaW1DbnorZmRzYThUL3hrbE5QUDVBdnFScjRSQlNxUDI4?=
 =?utf-8?B?NDhGaGN6WjE4ektRUGp3eW11YlUraGcrcjkzRnpvVkZQK0pXT2JIZkF4UnR3?=
 =?utf-8?B?K0hGU2VVRGtoUlRJd1lTNkxqeTMySy8xREFuQVQwTko3Y05zandQNjdETVlD?=
 =?utf-8?B?T0MzWCtSQnFtczRlZHczWDI1YklsQUlBTVFWRjFMTmlYSnJLcFVSODhJR2Ru?=
 =?utf-8?B?d0x6UFpNMjFFeXNCQTRENzlQTHNqdlp5WWdKWmRKSUVZSFdNUHNzL0pZQS8x?=
 =?utf-8?B?bERRRG42RzFGaXFMNDlJUEcrd09LNTAzSWtEN2k5ejQ4cnNOUFRoTUc2L1dD?=
 =?utf-8?B?cnRGOHR5NkV3bFB4T0Q4Ujg1SWc5bkNxQWVyMm1QbmJqSVhldzk1alZlSmdh?=
 =?utf-8?B?MjVRWWE4T0RhUlUyck1BZ0RBQ3AzdVhuc1g0UTBQN0o0WHJYaSsvOXZNL1lK?=
 =?utf-8?B?OGZMTHJONC9LKzJJa2hhNFRhRnNKRGZKMDF6eEdZWGRqV1VJU0Z3MTlwdm9I?=
 =?utf-8?B?VkNmOTRleXZCK1VrVy9SdnFDUU1paVdFS2RWWWNheG9KMlFZTmFleTg4c2ZV?=
 =?utf-8?B?bVcyYmhsWlFYdVBPV24vRGlIZGZMamcyK1l0aEtDWDhMcks3bzFTbFZXdWZU?=
 =?utf-8?B?c1VDa0ZPRUdwU0Q1R0NqRG9NMmYvUXhnUVZ4SjI5ZDVCZlAvaEt0OFRSSWVv?=
 =?utf-8?B?empXOGtWbFRFTWdUcGFXNWFMVVZpeVlrcVQ1bDBTaGNYdHBxcWhZZEJOU1lV?=
 =?utf-8?B?TUNOSVdVcXhiNFFucnFHZStuNnVQTGZZZVBTck9hdDNyeENUZCthWEF4Qlp1?=
 =?utf-8?B?dnNQMFFabDkrbmVPWFlWdmxXRmRIK2FORDQwNlVjcmlFQkVXZVJCcjk1ZlYz?=
 =?utf-8?B?K1k3M2FKc21jUWN4QmJwMmcxYTl4MjU0MmpybmxmbXBVdUVpVXpRQi9Xdzhv?=
 =?utf-8?B?dUNlT2g3dmVjT2ZTRTF1MHJxS2MxSzlNazd5dHZPUVRRWDlOMTFrOE0rOFRV?=
 =?utf-8?B?OWJtMkRwek94dGlGZzJySzJnZWdSQjNHZDlaVjIrdk1LdjNLekdlS3RhYlVq?=
 =?utf-8?B?UDN2RDlWTTM5RHp3dEhuZnZMWjRFcFIrdFE5WStCbmJGV0wvSFdCT0hqeGtw?=
 =?utf-8?B?TXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44D2C0F255615F4FAF3CF520397EC037@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5e107b-54ba-42e4-001e-08ddb4bdbdbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 14:28:38.1567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oz3Clc1k1MD9XNFIazKLUeuBfyeFt4WNYFHebkgsmJHzpf3lzG7orhnppj3a/zlxMBdobLeJy/0RikNR0ydhng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4523
X-Proofpoint-GUID: 2mn3zmgCsUwzvKZD_NkfGpp3_SUXF1lP
X-Proofpoint-ORIG-GUID: 2mn3zmgCsUwzvKZD_NkfGpp3_SUXF1lP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDEyMiBTYWx0ZWRfX+sVsnRgt1KC/ 2O5Y1lN9higtD2ggRnuu/qq2g8YR5ms38e4/ApVGTpjyxos0/xjK1HJHS7W4WH72hEk0dSJNctY 413fIlFLsfL2QzhTZ7JVDUt/rSmayZ/2gv6RcdKF9jkBGUxV/8/SatAH/6kxfDNxpRAM93s/FsQ
 +nPz9PtFFZbkmISK008jI7aHjyUae04a/xsoc6pboFTdnuXDzhRB2snW3naH53N2NFji+6faZWy 6hnmbkYcPEg6YwymcFOp0DWSMP8TUtqmhr4xJxTfN5Ezm19yUfAyn2P2X1GYFrHEis6MtkOFVKC IGH+0mde82zrKr3cvChIvNzS977Q4qp+p0SnSte86oWSzZNuFdCdMTmJ5/DDKhjzdAv8kcc4ihY
 Vw3LpmySjMjh3H6yC46tT4K9N4s7iZAoDXngXLyr3z4vN/F7rVPPneW7knuds2HM9hnRVwON
X-Authority-Analysis: v=2.4 cv=ZPbXmW7b c=1 sm=1 tr=0 ts=685d591a cx=c_pps a=NB3Td43k1Dtgf8/5lZavww==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=7K23SqwAxs5102_7Bv0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_06,2025-06-26_04,2025-03-28_01

DQoNCj4gT24gSnVuIDI2LCAyMDI1LCBhdCAzOjIy4oCvQU0sIE5laWxCcm93biA8bmVpbEBicm93
bi5uYW1lPiB3cm90ZToNCg0KWy4uLl0NCg0KPj4gSSBndWVzcyBJIG1pc3VuZGVyc3Rvb2QgdGhl
IHByb3Bvc2FsIG9mIHZmc193YWxrX2FuY2VzdG9ycygpIA0KPj4gaW5pdGlhbGx5LCBzbyBzb21l
IGNsYXJpZmljYXRpb246DQo+PiANCj4+IEkgdGhpbmsgdmZzX3dhbGtfYW5jZXN0b3JzKCkgaXMg
Z29vZCBmb3IgdGhlIHJjdS13YWxrLCBhbmQgc29tZSANCj4+IHJjdS10aGVuLXJlZi13YWxrLiBI
b3dldmVyLCBJIGRvbuKAmXQgdGhpbmsgaXQgZml0cyBhbGwgdXNlIGNhc2VzLiANCj4+IEEgcmVs
aWFibGUgc3RlcC1ieS1zdGVwIHJlZi13YWxrLCBsaWtlIHRoaXMgc2V0LCB3b3JrcyB3ZWxsIHdp
dGggDQo+PiBCUEYsIGFuZCB3ZSB3YW50IHRvIGtlZXAgaXQuDQo+IA0KPiBUaGUgZGlzdGluY3Rp
b24gYmV0d2VlbiByY3Utd2FsayBhbmQgcmVmLXdhbGsgaXMgYW4gaW50ZXJuYWwNCj4gaW1wbGVt
ZW50YXRpb24gZGV0YWlsLiAgWW91IGFzIGEgY2FsbGVyIHNob3VsZG4ndCBuZWVkIHRvIHRoaW5r
IGFib3V0DQo+IHRoZSBkaWZmZXJlbmNlLiAgWW91IGp1c3Qgd2FudCB0byB3YWxrLiAgTm90ZSB0
aGF0IExPT0tVUF9SQ1UgaXMNCj4gZG9jdW1lbnRlZCBpbiBuYW1laS5oIGFzICJzZW1pLWludGVy
bmFsIi4gIFRoZSBvbmx5IHVzZXMgb3V0c2lkZSBvZg0KPiBjb3JlLVZGUyBjb2RlIGlzIGluIGlu
ZGl2aWR1YWwgZmlsZXN5c3RlbSdzIGRfcmV2YWxpZGF0ZSBoYW5kbGVyIC0gdGhleQ0KPiBhcmUg
Y2hlY2tpbmcgaWYgdGhleSBhcmUgYWxsb3dlZCB0byBzbGVlcCBvciBub3QuICBZb3Ugc2hvdWxk
IG5ldmVyDQo+IGV4cGVjdCB0byBwYXNzIExPT0tVUF9SQ1UgdG8gYW4gVkZTIEFQSSAtIG5vIG90
aGVyIGNvZGUgZG9lcy4NCj4gDQo+IEl0IG1pZ2h0IGJlIHJlYXNvbmFibGUgZm9yIHlvdSBhcyBh
IGNhbGxlciB0byBoYXZlIHNvbWUgY29udHJvbCBvdmVyDQo+IHdoZXRoZXIgdGhlIGNhbGwgY2Fu
IHNsZWVwIG9yIG5vdC4gIExPT0tVUF9DQUNIRUQgaXMgYSBiaXQgbGlrZSB0aGF0Lg0KPiBCdXQg
Zm9yIGRvdGRvdCBsb29rdXAgdGhlIGNvZGUgd2lsbCBuZXZlciBzbGVlcCAtIHNvIHRoYXQgaXMg
bm90DQo+IHJlbGV2YW50Lg0KDQpVbmZvcnR1bmF0ZWx5LCB0aGUgQlBGIHVzZSBjYXNlIGlzIG1v
cmUgY29tcGxpY2F0ZWQuIEluIHNvbWUgY2FzZXMsIA0KdGhlIGNhbGxiYWNrIGZ1bmN0aW9uIGNh
bm5vdCBiZSBjYWxsIGluIHJjdSBjcml0aWNhbCBzZWN0aW9ucy4gRm9yIA0KZXhhbXBsZSwgdGhl
IGNhbGxiYWNrIG1heSBuZWVkIHRvIHJlYWQgeGF0dGVyLiBGb3IgdGhlc2UgY2FzZXMsIHdlDQp3
ZSBjYW5ub3QgdXNlIFJDVSB3YWxrIGF0IGFsbC4gDQoNCj4gSSBzdHJvbmdseSBzdWdnZXN0IHlv
dSBzdG9wIHRoaW5raW5nIGFib3V0IHJjdS13YWxrIHZzIHJlZi13YWxrLiAgVGhpbmsNCj4gYWJv
dXQgdGhlIG5lZWRzIG9mIHlvdXIgY29kZS4gIElmIHlvdSBuZWVkIGEgaGlnaC1wZXJmb3JtYW5j
ZSBBUEksIHRoZW4NCj4gYXNrIGZvciBhIGhpZ2gtcGVyZm9ybWFuY2UgQVBJLCBkb24ndCBhc3N1
bWUgd2hhdCBmb3JtIGl0IHdpbGwgdGFrZSBvcg0KPiB3aGF0IHRoZSBpbnRlcm5hbCBpbXBsZW1l
bnRhdGlvbiBkZXRhaWxzIHdpbGwgYmUuDQoNCkF0IHRoZSBtb21lbnQsIHdlIG5lZWQgYSByZWYt
d2FsayBBUEkgb24gdGhlIEJQRiBzaWRlLiBUaGUgUkNVIHdhbGsNCmlzIGEgdG90YWxseSBzZXBh
cmF0ZSB0b3BpYy4gDQoNCj4gSSB0aGluayB5b3UgYWxyZWFkeSBoYXZlIGEgY2xlYXIgYW5zd2Vy
IHRoYXQgYSBzdGVwLWJ5LXN0ZXAgQVBJIHdpbGwgbm90DQo+IGJlIHJlYWQtb25seSBvbiB0aGUg
ZGNhY2hlIChpLmUuICBpdCB3aWxsIGFkanVzdCByZWZjb3VudHMpIGFuZCBzbyB3aWxsDQo+IG5v
dCBiZSBoaWdoIHBlcmZvcm1hbmNlLiAgSWYgeW91IHdhbnQgaGlnaCBwZXJmb3JtYW5jZSwgeW91
IG5lZWQgdG8NCj4gYWNjZXB0IGEgZGlmZmVyZW50IHN0eWxlIG9mIEFQSS4NCg0KQWdyZWVkLiAN
Cg0KVGhhbmtzLA0KU29uZw0KDQo=

