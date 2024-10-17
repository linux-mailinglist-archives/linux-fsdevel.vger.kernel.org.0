Return-Path: <linux-fsdevel+bounces-32200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856929A2502
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 16:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45AE6284503
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 14:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A111DE4D8;
	Thu, 17 Oct 2024 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="OIFXrRzO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2111.outbound.protection.outlook.com [40.107.102.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122BD10F2;
	Thu, 17 Oct 2024 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729175451; cv=fail; b=X3mO5AItAtA5Z5bJQdruxkYtxyniGOj0rbyYm19vTAGuLmk1v6Ofhi0rU/gBRPfheOxTexED5HLvp1jZANXsXj71JbuNpIajm0EBaI7qxi6IrsQY2LiCPviZ3aT4qBXpN3sMKGHBx5oYWSYse1Vgjgr2WBtI40BCuUlBj2l8nV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729175451; c=relaxed/simple;
	bh=JHOmz2YXlSxfGN0JgA2LxHjOiIzfnY5WhUm4KhXxSho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q7eSICPIjzTOh3LQtRe2xXG8RCeonz7g/3b/3LcmYu/b9vNNm9jyfXp0t5Ye/QVkgNmpEAfc6S+DMruwPdkdPNicbR38ZO3f7MzjU0FqYZuyhy/oYTV47aOydY4bHYShD6KYNvqEply03c4NQTCePSXtNzO8sNiK1guZaGFVghM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=OIFXrRzO; arc=fail smtp.client-ip=40.107.102.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3dMsTjgoXrvj3A0fgSS2+XcSVm0g9xtlDZpjG3jOjsKYjs0xfKwGLzdKpWdhBx5i8vexxxeRKLoyUFHOptLxpkfkD64hZ3cu9tDizIrThdK4wtaNSxy6Yn232PBWLex8ArEwsYhb2Iv4+vWkj04w4dew8tkw5TqbFbe62sOxNmapynhk2MEC6LTYutIvBITOtun5iX84C+9HVOVphbMvGijGcF14yklpD7u7q16IalpE2ZOBOyT1bpsb2poJeL1xUMrd3DHKD2FaSDS4gp92bgDSWjW9/JHQhuFm0q7NA7ZqOorqag3t+6v5qVGdgsnkSo0s4clv9Tx+HS1Di7mBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHOmz2YXlSxfGN0JgA2LxHjOiIzfnY5WhUm4KhXxSho=;
 b=GToVPCj4323tghbU2qqDkBSo7tzUSVHg4pFkveUi+2GfMAMXt957FOUWzKfi2cAUhJdKAblceJQlJm5wKWN+o5HQBmKA0wf/2uRp3Ep47NH9lgODTvjvcPA5DIt/MAMEiF2wVmyK1wZmSwGsI4b4eHAgY4JqjjyKlRe2KXiIyqlzdZHBfmWoGEjiVn/plNTf2GtF1mK8YtJU/kviGIzOiuDkzezcxVDm89tMhQNdYYL/AaU2NIxVNKEHkIZfepIAk8+oc7Nl0LJUTz01uL3SMPyZPOzTdS5Dt0DnhxEf0SO1UjDQIraazJMh2w6yn2ADvQ67EuJsyyHA0Bz9cUJCrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHOmz2YXlSxfGN0JgA2LxHjOiIzfnY5WhUm4KhXxSho=;
 b=OIFXrRzO7hwg+ku/AW8n8z3xvd2YH/7ZnouxefNYGA4iGsXQ/O26haBkQ8cO8J/XuUwpRsFRWye17WB5nW0Tjxeiu+8t4XgiQkh6VZ9kiMrhzojivsmsehlmZM8ycIn6Mz+U7ydf7YH/VymYoBI3HV3AdqnP/QTXuvKDgJM1JDs=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH0PR13MB5590.namprd13.prod.outlook.com (2603:10b6:510:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Thu, 17 Oct
 2024 14:30:39 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 14:30:38 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "brauner@kernel.org" <brauner@kernel.org>, "paul@paul-moore.com"
	<paul@paul-moore.com>
CC: "jack@suse.cz" <jack@suse.cz>, "mic@digikod.net" <mic@digikod.net>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"anna@kernel.org" <anna@kernel.org>, "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "audit@vger.kernel.org"
	<audit@vger.kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Thread-Topic: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Thread-Index: AQHbGy5eU/FRIA4nekOvU14n2ka3FbKJd3QAgACR5YCAAQKOgA==
Date: Thu, 17 Oct 2024 14:30:38 +0000
Message-ID: <5bbddc8ba332d81cbea3fce1ca7b0270093b5ee0.camel@hammerspace.com>
References: <20241010152649.849254-1-mic@digikod.net>
	 <20241016-mitdenken-bankdaten-afb403982468@brauner>
	 <CAHC9VhRd7cRXWYJ7+QpGsQkSyF9MtNGrwnnTMSNf67PQuqOC8A@mail.gmail.com>
In-Reply-To:
 <CAHC9VhRd7cRXWYJ7+QpGsQkSyF9MtNGrwnnTMSNf67PQuqOC8A@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH0PR13MB5590:EE_
x-ms-office365-filtering-correlation-id: b5ca7f94-f8e3-40df-98f9-08dceeb84554
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c3oyYTQxRzk0NE1TcUZoYmVsU3Uzb0NaQ2RXRVpRbFFBVFl1SkJWOVNFVFVR?=
 =?utf-8?B?cEFJaVdhb0FmS2ozMVN5eGZ4dVE0RWpuSnhOTGViSER1ODFBRmltSHY5VjYz?=
 =?utf-8?B?YjRqZVFXUDg2TzREYVJJRTdhelZKbzl1am1QVDZxd294aUlqWHJFbS9GSnZI?=
 =?utf-8?B?V2liT29wbE1vaHlwOVRjdlQycmc1NlprNHExYWc1Ri9KN1pobzYrTWZabW9D?=
 =?utf-8?B?TzRhU2luTXRsK04ySCs3S1ErNzU0WGhZWTR3MnBBd281am5NMlpHUktmN0x5?=
 =?utf-8?B?Vmd3aU9OSjdKcjBTZ1pQNlJQRGpvMHhCRmxLL3M2aWxQRjEvZVdmclp4STh6?=
 =?utf-8?B?M1NLNlBRM05LN0JUaVlOQVhCODlSRkJ4alJYcHgycHhFSnozNzliZDh1Z0x1?=
 =?utf-8?B?ZnBNM29oSEtoSWZkVlRBYkxiT2FDOVU5T3k1M0R0T1ZmWUpCZE4vSmxucnBE?=
 =?utf-8?B?MU9BVzkwMWE3Rk5JMUVkZFNyT1k2WVNIdEt3NGNrdlJQUy9RN0ZrQ0V4VWF5?=
 =?utf-8?B?QlNaTVBjRXBxTHRNYlkvVWsvRnlTVGp2d04zRFJDYko5dXVUd1lYcnRWcU81?=
 =?utf-8?B?bTVnSEJyNDAzazZIdGxXOGRyQWZubEdWQ3ZBdW1KNFFBSmQwVlJubGVvdVMv?=
 =?utf-8?B?SWtMVHkyejk2emNRQ1NibzY3ZzJCRENyN2VIVDkwdlFtT29uZjN1TEhyUDVY?=
 =?utf-8?B?bThZODJ6cjRxcWIvM2RxcmdYZEFwZUhQQnZCaEdidWJuMEJpZ2gvM1haM0xu?=
 =?utf-8?B?SnR1MzJSSFJYSk9NMTZZTyt5M1lDYlBNNkNlblp6dVZKVDRmNGsxSDJMNmFE?=
 =?utf-8?B?bUw0MkxGMlFwYmJTVWtFS3BrdGo3c1dXSjdqNnBxOVQ3dHVNekUvRVRjNG16?=
 =?utf-8?B?dmQra1JpVUxDekZSZ3ExWXNwOHJwaDNpRy9NbmhnRGgzNFVNYTNyM2NoQ0RX?=
 =?utf-8?B?OFpIZVFDN2Fxci9SQ0tTNlg1eXBYUkJTdzMvVjJQdGQzZG9nRHA1MEJtZGhN?=
 =?utf-8?B?YjlDVzBJWFhiR09GYXV6MEhsenJvRFJaUThmSWVQUkdDTFptaVo1Q2NNdVlT?=
 =?utf-8?B?QTdFYlJXL0hOekVxWklCUVFqL2wxY0owaCtzRnlzZE5PQlRNSDhtb2xxZkRu?=
 =?utf-8?B?M1Q1ZkREVjl2S2dUUUxvdkJ1dy9xenBDYm0vSGd1WmdGQzV0VkFzZU14SnF1?=
 =?utf-8?B?b3M3aEltNjg2eVA4bkhndnhpNFNNYUVzUS9pNDc2MnZkRm0vZDczMmVNL2lP?=
 =?utf-8?B?R3Q3YXRQZzZnSkdEcmxuZkFkNHdTZ3BXT0xpL0tvNm5GSzBYZGJxdjV2KzVo?=
 =?utf-8?B?eEZGZ3dZSjNnZElKUkp0VFRlSFRvdTgzM3BSNUJEOE42bXBNemppU0E4ZTM5?=
 =?utf-8?B?VUZuZCs3NGZXenlaMEsyVEZrUCt2aFdUMjRHSmVzM2ZyYzQvczNkSkZuZkZz?=
 =?utf-8?B?L2VPTXlyT2hrd3BTbEhzcjV2Mnl0eUJlcURMYlNxMEpBeWRTYkRqTWFZUHJE?=
 =?utf-8?B?d05Pa1ZTRGNEOE9aamhDY2luODJhRnhpYWIxWXNRVm5QV2dyc2hsWnkzbXdS?=
 =?utf-8?B?Y0RXRk0xT2NOSTVYSVM5b1hkWGtKdVlxZ0F2a01vdzE3VXMrUWtXYjA1MVIv?=
 =?utf-8?B?SEQyRmRZdzhxaU5pM2hjQ2syRXlXNXMwZFJIczJ3akFqQ3FPMklqTmJRb09P?=
 =?utf-8?B?NjUvbzk2ejh6Vit4Nk5FcGNqRG5yUGNheG5NT295a21nVlRTdjRUYnlnMVNP?=
 =?utf-8?B?VU5obmpaUUtaOTBqZzc2VEJ4ZkVIMnRNZGpIbTlsRWtyZGtRY21BaW9yQmV3?=
 =?utf-8?Q?i2ZTCVJVUmtnp1bLw5W/zNiS3Oz+A+8Fs8vIs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dVdBMlZUTnpPQ3haMTl6TFVyWmFUMXJ0WFAxTmhsWDg4d2hhSGthYThsakk3?=
 =?utf-8?B?WTFZU1prUzFQa20xNVNrNjh0T0ZyNlhiYmJ5SG1VbTFrdU1jaG5GNDlPTzVy?=
 =?utf-8?B?Sy90NzdpSFhNbmo0WlZnUlBOZ2NjOXEyVXRLQVNvRVVwYXgzQkFHUnJwVHpy?=
 =?utf-8?B?a0Vib2g1YjdHSitlQmpmbWNlRFdjdVExZWdkVTkxYzRzdS93TlJkV0hpcnM1?=
 =?utf-8?B?SzJZUTl2VExDbUNzZnRmSXFaZFBSMGdLek1ZWTROQWEvL3RQWE1aemhCSjFk?=
 =?utf-8?B?VCtaYUZ5aERzK0R5cnRXM251dWpKcVg2NmVpUjZxd085Wk4wWUFXM0EwbHdt?=
 =?utf-8?B?MCtWelVYL0ZVaTlmUnQ1RkVvTU1idXRQZmxySysrT0w4c3VyS2E1dDZ4cWZJ?=
 =?utf-8?B?RTY3WVc5QVNBZ1FqRlR5MEJXbm1lWUc2dHRhUmVjYmMraWUwbFRnZDB5UlhX?=
 =?utf-8?B?Y0dPVnh6aVNoTjVCT2hybGZ6SnArZDQxWW5HSnhRaG15NWtrUGsyL0wrd3NY?=
 =?utf-8?B?QTMxcTRSSWI4bjEra1RCMmtEbS9TYjI4YUwxTDdhV3RrY1ZxWThsVVVOWHJn?=
 =?utf-8?B?NEluNmNWY0lNQXRuZnN3eDR5aHI5NDBwQVJDZUpnd0lEaXBBcElzRTV2YmlM?=
 =?utf-8?B?K2hsUS9xSWZxdVM4aE1McUwrOGQxOU1qTWxSTW5VRUZIWGUveUdubmxiN1FB?=
 =?utf-8?B?QnhlRlY1aCtkYUFEYzN5UldDbkdrcjdyTVVkTVAwcEp4MytMaU5uMkZtbUov?=
 =?utf-8?B?Y2cxZlhvZitvMmRKaXFadDBSbjlTbXVyako2dlNkREpkU2lSbnY1RE1pSkVC?=
 =?utf-8?B?N04zUjVWQjNNOXlJdlh0QkVGUXFqWUVkWndZekdiT0lPQW81OUVuM3l0eVhD?=
 =?utf-8?B?K1lzQ1QxTWFXdGoxVDJadmVEdHpqVGY1ODJRcUxmUm5RTmhadFRmSHpYR3R1?=
 =?utf-8?B?Mzk4UnRadVRxQk5BVktTbEZCVmpTQXBCd25ydmtTMFNXTmRLajVoY0RuNDNw?=
 =?utf-8?B?VUx4bmRFL1JiQkQ0RWo1anBrck1iUTM3N1YzVzIyQ1RhanRJN3hpb3VyUUE2?=
 =?utf-8?B?L3B2M0dSVzVjOXNZYVR5YVhvRUhLem13a0MwTkpGWVkxN2VkT2hydU5OaVd1?=
 =?utf-8?B?WGRXNG1PMktNc0dKbEdCeTRLVys1OEY0eG9sZVVjZ21VelhWRld1bzlqYlAv?=
 =?utf-8?B?M1ZqaDIyQXJlVUhLbHdzQzhLVC9PWmZwZUNXb0FmRlhZb0QyOXMwSC9tZTFT?=
 =?utf-8?B?cDdPMzJNdDY0ZHUvWEh4b1dhNkhvdGM4N0hXMXg4Q29GNkIzeUhITlZQbHVG?=
 =?utf-8?B?Uiswa3JWV1haUWttaXRTU0JsTWJMVlFpdXhQSzlvd2w0emd6US9vc3dha2pP?=
 =?utf-8?B?UGZ1QVREWGFQZkdRb2JSL1pKVUFpdGVjWlY2TjhGUGZnakgwMFZpRHowSkwz?=
 =?utf-8?B?S2VQWGhIWXRFV0Rrb3diSnNPTU1CTExUMDAvUFFpcUFJbWpuTGZVeldJaVYw?=
 =?utf-8?B?RkFKc0EwZ1pmZWhhYVQ4RHdsNVFIOWZnbUYvRE14RTRjbHEvR2tmUTduRFpX?=
 =?utf-8?B?ekpXMFhVRFowNkhlZWZsaTd5eVZOYXBKMC9qZkk5TGY0Q0w2bXVJQXpnWGlq?=
 =?utf-8?B?UHdvR2FndUFTOHFHWXJkcFM2RFFRbzd4RDBYU253cm5id1M3cDk3TXlwRFEv?=
 =?utf-8?B?KzZYNEtyWjBjNnRFa3NRRWtHbWxPWmxBdjZwRjFhNVlhU1Mwa0w4VUZsaUJl?=
 =?utf-8?B?SUNvekUwVEN3d012SUNzQ1dzQXBSSE9UaGtkQjdGU1hzZDlpZ0Y2S3djVUV6?=
 =?utf-8?B?QjNyc2UySEZNdWpPN2pRUmd3cjM2QmhRM0NkN0pyZExUSW1uTTVwdUR5eXZJ?=
 =?utf-8?B?MEh2UUQ5OWp5MWh6L0E3T1NPOWZBQXoyOEJUVC9SbjRLUlFxeUpERjNucWpD?=
 =?utf-8?B?b2hZUjdMTDZRV2QwdUU4Y0FwNXBuUHRJaHpySGxqcDg4Q09INFdGMmxsZkFC?=
 =?utf-8?B?T2Zac0hNek9YdUlVb21Ddms4Q2U5cml2QSs0cDFSTHkyOCtjZnVvUGxTTFBO?=
 =?utf-8?B?cUU4aEgrY09nelN4RkZUZ3VqU1NOK29jd050a0tIUDNvVjJzdFkxZnJSVDNS?=
 =?utf-8?B?QlZFVFJ4MXlMQWRNdG5Mam1ZblNKQ3kwS09jM1NNTVY3bVp6QTd1azA1bUNW?=
 =?utf-8?B?ODZIdHpWM0NRdkhMNkViZ1RydWlleXhSbVRtMytWZW4xTEk0OElybm1OY0dr?=
 =?utf-8?B?TEUvdGNtMFRMeUFmbGZvdlZzbWR3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42ECDC2DD9A1F0429820011026D87261@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ca7f94-f8e3-40df-98f9-08dceeb84554
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 14:30:38.4210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aIycGR/MHN+chQH650LkrlBElZm5SjrIAt4XW4CJVau6Ke8k7ml5kLKPOu2yyrtj+OO25uFUKRdJd624IcSK9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5590

T24gV2VkLCAyMDI0LTEwLTE2IGF0IDE5OjA1IC0wNDAwLCBQYXVsIE1vb3JlIHdyb3RlOg0KPiBP
biBXZWQsIE9jdCAxNiwgMjAyNCBhdCAxMDoyM+KAr0FNIENocmlzdGlhbiBCcmF1bmVyDQo+IDxi
cmF1bmVyQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFRodSwgT2N0IDEwLCAyMDI0
IGF0IDA1OjI2OjQxUE0gKzAyMDAsIE1pY2thw6tsIFNhbGHDvG4gd3JvdGU6DQo+ID4gPiBXaGVu
IGEgZmlsZXN5c3RlbSBtYW5hZ2VzIGl0cyBvd24gaW5vZGUgbnVtYmVycywgbGlrZSBORlMncw0K
PiA+ID4gZmlsZWlkIHNob3duDQo+ID4gPiB0byB1c2VyIHNwYWNlIHdpdGggZ2V0YXR0cigpLCBv
dGhlciBwYXJ0IG9mIHRoZSBrZXJuZWwgbWF5IHN0aWxsDQo+ID4gPiBleHBvc2UNCj4gPiA+IHRo
ZSBwcml2YXRlIGlub2RlLT5pbm8gdGhyb3VnaCBrZXJuZWwgbG9ncyBhbmQgYXVkaXQuDQo+ID4g
PiANCj4gPiA+IEFub3RoZXIgaXNzdWUgaXMgb24gMzItYml0IGFyY2hpdGVjdHVyZXMsIG9uIHdo
aWNoIGlub190IGlzIDMyDQo+ID4gPiBiaXRzLA0KPiA+ID4gd2hlcmVhcyB0aGUgdXNlciBzcGFj
ZSdzIHZpZXcgb2YgYW4gaW5vZGUgbnVtYmVyIGNhbiBzdGlsbCBiZSA2NA0KPiA+ID4gYml0cy4N
Cj4gPiA+IA0KPiA+ID4gQWRkIGEgbmV3IGlub2RlX2dldF9pbm8oKSBoZWxwZXIgY2FsbGluZyB0
aGUgbmV3IHN0cnVjdA0KPiA+ID4gaW5vZGVfb3BlcmF0aW9ucycgZ2V0X2lubygpIHdoZW4gc2V0
LCB0byBnZXQgdGhlIHVzZXIgc3BhY2Uncw0KPiA+ID4gdmlldyBvZiBhbg0KPiA+ID4gaW5vZGUg
bnVtYmVyLsKgIGlub2RlX2dldF9pbm8oKSBpcyBjYWxsZWQgYnkgZ2VuZXJpY19maWxsYXR0cigp
Lg0KPiA+ID4gDQo+ID4gPiBJbXBsZW1lbnQgZ2V0X2lubygpIGZvciBORlMuDQo+ID4gPiANCj4g
PiA+IENjOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kbXlAa2VybmVsLm9yZz4NCj4gPiA+IENjOiBB
bm5hIFNjaHVtYWtlciA8YW5uYUBrZXJuZWwub3JnPg0KPiA+ID4gQ2M6IEFsZXhhbmRlciBWaXJv
IDx2aXJvQHplbml2LmxpbnV4Lm9yZy51az4NCj4gPiA+IENjOiBDaHJpc3RpYW4gQnJhdW5lciA8
YnJhdW5lckBrZXJuZWwub3JnPg0KPiA+ID4gQ2M6IEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+DQo+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBNaWNrYcOrbCBTYWxhw7xuIDxtaWNAZGlnaWtvZC5uZXQ+DQo+
ID4gPiAtLS0NCj4gPiA+IA0KPiA+ID4gSSdtIG5vdCBzdXJlIGFib3V0IG5mc19uYW1lc3BhY2Vf
Z2V0YXR0cigpLCBwbGVhc2UgcmV2aWV3DQo+ID4gPiBjYXJlZnVsbHkuDQo+ID4gPiANCj4gPiA+
IEkgZ3Vlc3MgdGhlcmUgYXJlIG90aGVyIGZpbGVzeXN0ZW1zIGV4cG9zaW5nIGlub2RlIG51bWJl
cnMNCj4gPiA+IGRpZmZlcmVudA0KPiA+ID4gdGhhbiBpbm9kZS0+aV9pbm8sIGFuZCB0aGV5IHNo
b3VsZCBiZSBwYXRjaGVkIHRvby4NCj4gPiANCj4gPiBXaGF0IGFyZSB0aGUgb3RoZXIgZmlsZXN5
c3RlbXMgdGhhdCBhcmUgcHJlc3VtYWJseSBhZmZlY3RlZCBieSB0aGlzDQo+ID4gdGhhdA0KPiA+
IHdvdWxkIG5lZWQgYW4gaW5vZGUgYWNjZXNzb3I/DQo+IA0KPiBJIGRvbid0IHdhbnQgdG8gc3Bl
YWsgZm9yIE1pY2thw6tsLCBidXQgbXkgcmVhZGluZyBvZiB0aGUgcGF0Y2hzZXQgd2FzDQo+IHRo
YXQgaGUgd2FzIHN1c3BlY3RpbmcgdGhhdCBvdGhlciBmaWxlc3lzdGVtcyBoYWQgdGhlIHNhbWUg
aXNzdWUNCj4gKHByaXZhdGVseSBtYWludGFpbmVkIGlub2RlIG51bWJlcnMpIGFuZCB3YXMgcG9z
dGluZyB0aGlzIGFzIGEgUkZDDQo+IHBhcnRseSBmb3IgY2xhcml0eSBvbiB0aGlzIGZyb20gdGhl
IFZGUyBkZXZlbG9wZXJzIHN1Y2ggYXMgeW91cnNlbGYuDQo+IA0KPiA+IElmIHRoaXMgaXMganVz
dCBhYm91dCBORlMgdGhlbiBqdXN0IGFkZCBhIGhlbHBlciBmdW5jdGlvbiB0aGF0DQo+ID4gYXVk
aXQgYW5kDQo+ID4gd2hhdGV2ZXIgY2FuIGNhbGwgaWYgdGhleSBuZWVkIHRvIGtub3cgdGhlIHJl
YWwgaW5vZGUgbnVtYmVyDQo+ID4gd2l0aG91dA0KPiA+IGZvcmNpbmcgYSBuZXcgZ2V0X2lub2Rl
KCkgbWV0aG9kIG9udG8gc3RydWN0IGlub2RlX29wZXJhdGlvbnMuDQo+IA0KPiBJZiB0aGlzIHJl
YWxseSBpcyBqdXN0IGxpbWl0ZWQgdG8gTkZTLCBvciBwZXJoYXBzIE5GUyBhbmQgYSBzbWFsbA0K
PiBudW1iZXIgb2YgZmlsZXN5c3RlbXMsIHRoZW4gYSBhIGhlbHBlciBmdW5jdGlvbiBpcyBhIHJl
YXNvbmFibGUNCj4gc29sdXRpb24uwqAgSSB0aGluayBNaWNrYcOrbCB3YXMgd29ycmllZCB0aGF0
IHByaXZhdGUgaW5vZGUgbnVtYmVycw0KPiB3b3VsZCBiZSBtb3JlIGNvbW1vbiwgaW4gd2hpY2gg
Y2FzZSBhIGdldF9pbm8oKSBtZXRob2QgbWFrZXMgYSBiaXQNCj4gbW9yZSBzZW5zZS4NCj4gDQo+
ID4gQW5kIEkgZG9uJ3QgYnV5IHRoYXQgaXMgc3VkZGVubHkgcnVzaCBob3VyIGZvciB0aGlzLg0K
PiANCj4gSSBkb24ndCB0aGluayBNaWNrYcOrbCBldmVyIGNoYXJhY3Rlcml6ZWQgdGhpcyBhcyBh
ICJydXNoIGhvdXIiIGlzc3VlDQo+IGFuZCBJIGtub3cgSSBkaWRuJ3QuwqAgSXQgZGVmaW5pdGVs
eSBjYXVnaHQgdXMgYnkgc3VycHJpc2UgdG8gbGVhcm4NCj4gdGhhdCBpbm9kZS0+aV9ubyB3YXNu
J3QgYWx3YXlzIG1haW50YWluZWQsIGFuZCB3ZSB3YW50IHRvIGZpbmQgYQ0KPiBzb2x1dGlvbiwg
YnV0IEknbSBub3QgaGVhcmluZyBhbnlvbmUgc2NyZWFtaW5nIGZvciBhIHNvbHV0aW9uDQo+ICJ5
ZXN0ZXJkYXkiLg0KPiANCj4gPiBTZWVtaW5nbHkgbm8gb25lIG5vdGljZWQgdGhpcyBpbiB0aGUg
cGFzdCBpZGsgaG93IG1hbnkgeWVhcnMuDQo+IA0KPiBZZXQgdGhlIGlzc3VlIGhhcyBiZWVuIG5v
dGljZWQgYW5kIHdlIHdvdWxkIGxpa2UgdG8gZmluZCBhIHNvbHV0aW9uLA0KPiBvbmUgdGhhdCBp
cyBhY2NlcHRhYmxlIGJvdGggdG8gdGhlIFZGUyBhbmQgTFNNIGZvbGtzLg0KPiANCj4gQ2FuIHdl
IHN0YXJ0IHdpdGggY29tcGlsaW5nIGEgbGlzdCBvZiBmaWxlc3lzdGVtcyB0aGF0IG1haW50YWlu
IHRoZWlyDQo+IGlub2RlIG51bWJlcnMgb3V0c2lkZSBvZiBpbm9kZS0+aV9ubz/CoCBORlMgaXMg
b2J2aW91c2x5IGZpcnN0IG9uIHRoYXQNCj4gbGlzdCwgYXJlIHRoZXJlIG90aGVycyB0aGF0IHRo
ZSBWRlMgZGV2cyBjYW4gYWRkPw0KPiANCg0KUHJldHR5IG11Y2ggYW55IGZpbGVzeXN0ZW0gdGhh
dCB1c2VzIDY0LWJpdCBpbm9kZSBudW1iZXJzIGhhcyB0aGUgc2FtZQ0KcHJvYmxlbTogaWYgdGhl
IGFwcGxpY2F0aW9uIGNhbGxzIHN0YXQoKSwgMzItYml0IGdsaWJjIHdpbGwgaGFwcGlseQ0KY29u
dmVydCB0aGF0IGludG8gYSBjYWxsIHRvIGZzdGF0YXQ2NCgpIGFuZCB0aGVuIGNyeSBmb3VsIGlm
IHRoZSBrZXJuZWwNCmRhcmVzIHJldHVybiBhbiBpbm9kZSBudW1iZXIgdGhhdCBkb2Vzbid0IGZp
dCBpbiAzMiBiaXRzLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBt
YWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0K
DQoNCg==

