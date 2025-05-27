Return-Path: <linux-fsdevel+bounces-49918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E149AC51C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 17:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C96C1BA21BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 15:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C1B27A90A;
	Tue, 27 May 2025 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="biusKaAQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013025.outbound.protection.outlook.com [52.101.72.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F64215624D
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748358779; cv=fail; b=Pwi5l34WItCsHWwImJq+xoBDEwtoybNKXfqXcIwtPcWm4X/I5ZV12ihQSZmxbp/SzW+p6DGcfhi1ZN5RAlU9IWK18D1fnHkioRLnfpmLMYROpG1IkOyQ7fHY+L7jsCJs0hfX6fV+ExzAXNTbMS2tNtZliFqaIO9KWsk3ayPGHdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748358779; c=relaxed/simple;
	bh=m1UYbDdSgqn7pxZ6HOlPOyGg1rF50Xyq3o+T0+C7NnY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RF12WsytvjaDvKKT2SnO3DDPxkEkUdJ2AVhB3MnvGf6N5Wd14aOAwkEAoqmSNyegS+/yHb4sPEFHpK2+ibaF4MPWPVlOoBJZPOwVktkLkT6Ni5dMvzxb4YlyTST1EfMF3KQxRNKZGsppaHXOruYC2VDALvzY4eM3wkPmYd0GUKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=biusKaAQ; arc=fail smtp.client-ip=52.101.72.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JbtupwjW8RWO48cWTchPOeHb7eY3H92MuaycGDI7anb9WEyyrCE/m2tX/9X4Mc4VWkK8qUr6YoTtoRx+aenIXGlCIhdvjB1q5YMBxEsl3aq/he12hzST5iGIWCR6wQiRzH2X18X4AHpKYAITwIAcInPuXlMDnSFClRGNFt3NF7LxE2SRflPSxvcu7QqaDHWjb1EH45GIJwIXPhc1p/WQ/7zdNiMx/PS88khsaD7ktKiQFRl+NtT9wFKEmJVLKhN/Mm4U7nsFJ6nOQ7ozNNf40uJLnmVSbvworjhoIzIS4mycOui79F1PBCp9lEVrRJ3DjZL+hIn86Su3mUFs3zCRMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1UYbDdSgqn7pxZ6HOlPOyGg1rF50Xyq3o+T0+C7NnY=;
 b=N24zWHtwuWWu0407nmtPZH6YjUNx8KcjcK1beoIWCBV2R3tVApc6PsJVqLj/TAGbKDpA1+NT/ED+be2GDJABE/UbPFxpLkWvvlneo2y/LhM6k8O5DcWVK6FLQ5GNT9S7DLSaxK6YQ1ecgnDH/YrwB8VZO7GViSzsGVqlBMfrTDyiDNMQ5I3KgehUwwaF8KnR/J2BRrZo1dMj+fBIjFUAocgnKORbGrfzBH2CyENHnWKXznL0COsLJFvQnE2PJdsDAh9fQEJ1gzt08AAPxkgiyt4muRPsa0DDDzQGvzh7pcQdqIusYjVhlabu/CBcaPbxnK8hhugZDP0GbDIYFHIjhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1UYbDdSgqn7pxZ6HOlPOyGg1rF50Xyq3o+T0+C7NnY=;
 b=biusKaAQ9G6h7Ku/2Y6Y1Z1DQozhacX/9CBXFxmdMaWcAoKQD1NC6J4rXyjMq5ICpuJoKFkmEJE43D4ots1m9I41WZz3rKLEvQM1E7ulEaPytnSKDQb0uuOlxPSj8hpwcl+tpGjHF/JK0OpU1Ec90GKfSOeqYyoP3o/rgKWvQj5ikNc/1gG1u436N+jpGfTIaht55AQKgdBbclAvAYN7Vo1hzTTjZx1sbXd2UozC3EAnCr0F8n9yv+iOWRSUDuyHvzsrsiFa4wXS5VdY3y7LJXZzCbMDlnT++Fsx5tkoI6R3sGeO7/1FGelacW8qr/XcnV3b3mRE3yIw1pVGdEVX3g==
Received: from AM6PR07MB4549.eurprd07.prod.outlook.com (2603:10a6:20b:16::28)
 by PAWPR07MB9414.eurprd07.prod.outlook.com (2603:10a6:102:35e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Tue, 27 May
 2025 15:12:54 +0000
Received: from AM6PR07MB4549.eurprd07.prod.outlook.com
 ([fe80::67d6:5a88:7697:5e9f]) by AM6PR07MB4549.eurprd07.prod.outlook.com
 ([fe80::67d6:5a88:7697:5e9f%3]) with mapi id 15.20.8769.021; Tue, 27 May 2025
 15:12:53 +0000
From: "Joakim Tjernlund (Nokia)" <joakim.tjernlund@nokia.com>
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"Johannes.Thumshirn@wdc.com" <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v4] block: support mtd:<name> syntax for block devices
Thread-Topic: [PATCH v4] block: support mtd:<name> syntax for block devices
Thread-Index: AQHbyM9lkWRJ5+ps5U2Sea6X8taQ3bPmogIA
Date: Tue, 27 May 2025 15:12:52 +0000
Message-ID: <ff1cbf3fa92e70214a107793952e2788b906b27c.camel@nokia.com>
References: <6e90a2be-a1a9-46fe-a3f3-bd702c547464@wdc.com>
	 <20250519150449.283536-1-joakim.tjernlund@infinera.com>
In-Reply-To: <20250519150449.283536-1-joakim.tjernlund@infinera.com>
Accept-Language: en-SE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR07MB4549:EE_|PAWPR07MB9414:EE_
x-ms-office365-filtering-correlation-id: ba491f5e-46b4-49b7-464f-08dd9d30f3c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WXh2MzRZRGRxeG44cDlOUWgzZThFbHJ0ekhsWWgvYkphWk9zSmlZdHlqYTlI?=
 =?utf-8?B?OS9lbVliMHBlR1h5SVAzRzVIOWtOd3hJR0s1dk02K2R2dmpHTmVRb2xoNFgy?=
 =?utf-8?B?RmNLZnZDS0ttbVZPQS9XRXh3R25zcDI5WExvRzdrTDI0UEx6eDRpNFlNamg5?=
 =?utf-8?B?M2RxQWE3emY0dTdUR1Q1UGQzRFpXdjVySGhVcmNISm1EZldndmpCNVJ4cnk5?=
 =?utf-8?B?TzhhK3VFZE5NZGVuWk4vK09lSExxL0o3eDFWUDl6eEtFYkhGUE42NVE4aXdX?=
 =?utf-8?B?Q3R5MEd6NEdxOHYxZDRSK0pudVlYcmNaZXVDNy9WT2M4a3R3REVnUmVkY0Y2?=
 =?utf-8?B?L09qQVd2OERUdC8xZ3k4Y0c4QURWUHQySEEyTkdJTlZwNHBpbStDeHpsT01L?=
 =?utf-8?B?MVZVampJZzllbCtibmRiaDJXNERQTndkMEwxR01jeGhmaGtXVjlRdXNHY1NJ?=
 =?utf-8?B?WnNtbjRuZWlQWmgwNzVFY0lHbDNDSEhwcnB4V3hzbFo2d0ZtS3NoRGtSdU54?=
 =?utf-8?B?QWYwNEFML3lIbGZWSDBzdFlPdHdpczVtK0twKzFyOSthRXNxc01DYkxmV0s2?=
 =?utf-8?B?SW8xYjloU2h6ZG55ekxYeUgxdmgzbENIVVRlSWRpc29OZXJ5VCs1ZVJKQWQ0?=
 =?utf-8?B?MWRGNGRIc01iUXN2ZFRKTGUvcEhtL29oako2VThvdnVZdVY4SHFWT3R4bUJi?=
 =?utf-8?B?bmxuZzlmbTJHb3VPa2RVUGFJWW4xZ0lPY2VrLytFaXpiMXkyZnJreW80M05n?=
 =?utf-8?B?cVp3OGhEOTVMUUtwTGNuN0VYWkhZelA5QVZ0UnhnT2toeXVtSW9xTmNoSTNw?=
 =?utf-8?B?Tmo0VHluQ3ZQQXVHamV3b3Iyc0lxb09iRTkxbUtHUHJXb0hpZWpSbDZ5RjNu?=
 =?utf-8?B?TUhOMXIyYmZzZiswZnhsbS9uR2c2d0txR2VmSlF6Zi8xUWUvQytuS3d5NnlM?=
 =?utf-8?B?V2xPR2ZoaVUxSHI3OGtDNEpnWkF6SWZZSzNZakdvNWRDN1pXSzhKMzdOQlZn?=
 =?utf-8?B?ZzJzeTYwd1VoUVRIRFdtck5QOURvTGpSekVCOHloNDJGZVY5RUJLUGpqdk05?=
 =?utf-8?B?K1A5cFZpU1BZNTFndnQ2YlJ2eGhVdURGcTZuVFM0c01zVkRTc1Z2OFZ0ckNO?=
 =?utf-8?B?SkJXT2hlMGlQTVQwNzlybzdmcTJUT1c0QnZ0SXBjY0IrZ3N4eHJRY29ZYmlo?=
 =?utf-8?B?bngxYy9UYXVnbFEvSkErdTVXRTV4NTk3RW9USkNmcXZ2NHF0UnlacndwbTVh?=
 =?utf-8?B?NCtYRWk4OWF6NWVFNEFKdHRFRG1HUjVFY2dCMHIvYXNHR05DT2FJSWxHalJl?=
 =?utf-8?B?R2tYem83TjJxeUNiWHcrSkhLYmYvU3VFNnY5YUtaTTBJdjB3b3ErdDZQbTRl?=
 =?utf-8?B?S3pjVW1sMVFINDBKT0JJOWlWM3pWdGhvSlV5NXBZRTZuM3VSR1d5SklNSW9o?=
 =?utf-8?B?Q2tSdDdHbm5LTlBuWGVRTWZBL2NtT2gxbnYyYTRUa04yVndtVElIeVpCOWNw?=
 =?utf-8?B?b1h3RjNScXlWQjNMRUNTSjVTWWozZkg3UEVvSUJENlVGUTc0dStJSm03T3Zt?=
 =?utf-8?B?N1lzdFV5dzh5UDNZS0djVFlzdS9yNlNxNG9xZHh4SS9xcEQ4Mk9FOFZEbUow?=
 =?utf-8?B?d0VZdGZ4S3ByRjZUNTZwU1VqUm9MZlUxTk1mRjAvNnAwWkdtL0tqRUU2cDY3?=
 =?utf-8?B?L1dTZ2xYUm0zZFhWSWFXRFVPSkYva2VxYzNJUjBMaUNTd0ZzK3lUMFczbmFZ?=
 =?utf-8?B?R2Zoc0RBSm0vTDBpazRXS2hrK1BJeU9zQ1ZONm9kclZITUwzQW9FNjNWajdE?=
 =?utf-8?B?ZDdGZGdtd042SGxkUTZVUDVsd2EraEp6a3VucDlMbXBTN2xlYmtlb1N2WlV4?=
 =?utf-8?B?ZHdsWnJaaXdmQWlydE1QRFhaMWp2RmJkODZweVF5V2RuMGcrUC85a2RyVkI1?=
 =?utf-8?B?VnZLQ0NkNEdPM1Irdk9sYjM2YnJGZ2ZNU3BGMUhsMWtDTS8yb1lGekRpUUJS?=
 =?utf-8?B?N3phMXA5MjBBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR07MB4549.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OUdMcUxua1diVVZ0SVRxdXZTVGxHUXJxekV5K0xuVHdtdkhLTDQ5b0llb0gz?=
 =?utf-8?B?ZnluU3Q3L0hlUFpxWk9yb0M2bDZmWlAxSEhydzZ3OUUvb3hZL3RQeVJveHFX?=
 =?utf-8?B?SG5hSDl6cU8vMlNJcHhZeEkzejJjbXlXcDZnUGdCaS8vTVN0Z1RWNitTRXcr?=
 =?utf-8?B?MWthM2MvT3pBa1RSOEEzTXg0WlNqTVVTZml5ZndRb1BJSEV3TjlVb1Z6aExk?=
 =?utf-8?B?ZldnQllwN09Fd2VvSXg2S0lrK1dsaVNHRGc1Q1dDWHlkWWthSkRlSGpQaFh2?=
 =?utf-8?B?RUJobW5VLzBXMjM3ejlkUWhqMncrRmJ3STRNY0tCeE5wVDFoMEkwNTV6SFdl?=
 =?utf-8?B?L2lHNFo2L2g5VnFwSFlsbm5nZ01EMXJhMEsycldBcFpmTDJQOEh6NnlQcytQ?=
 =?utf-8?B?ZTYrZVVpRHdHenREam9qWHNvQ2J6VmttZHdUWWllMUs5RlZTU1l1NElXazhD?=
 =?utf-8?B?SFF0WmN6WktXaEI0dkd5bFU5UmErQXNYZDN5cnJ3ZkkwRnd3amJmQlNud3F5?=
 =?utf-8?B?NDd4RktCeld5ei9zV09iT1M1aUp1RVJId3puVU1jaThraCtmT1dtSkphV3hV?=
 =?utf-8?B?ekFCV0czbzhJNGZaNHFCUE1kWUpLcHEzVkZXYUE1R0lSU2xJMjZsd3FacVNp?=
 =?utf-8?B?aTY4YVg3UW1vQm1QeExwdmVJUFRnYnhLeWZJa0RJZkR5ZW5PT2tyYzRlSkQ2?=
 =?utf-8?B?SFZsSkZFdmpxamhsS1NBN1dKWUxpNUZhOHdMRjNpY2lCUTl2dUR0ZGVCMjFx?=
 =?utf-8?B?RVFlNlZPYzhJQ21HTDJFUXY5dmwrUVVXQldLVWc3WXVrQWpQbjlUYTBUMXo0?=
 =?utf-8?B?SXgyRWM2K3owOEk2RHBZdlZHemdESTloUXE5QlJJTzBLRDdUZVZ4NWJXZW5I?=
 =?utf-8?B?bjZMUkxpVDNKNkl5Mis1cWdOK0t6eGh3a1FaSnQ2R25KRnNkQURZREpHTVJ3?=
 =?utf-8?B?S2tMcUh6Qy9URVRSMDB1dGtOdnFnUXlmTTN1V2RhdVVUSFpUaVMzSk50dWpU?=
 =?utf-8?B?eklqTk9kYUhEQ3VVQ0RPNC80MjZJWUN2Q2JQQk9XQjdwRXE1cnpZemNyWnI0?=
 =?utf-8?B?L2U3VG1MVXZBQUY1U3lsQjhRa0ErSXdoUjBPTUVVdzJsZVphWnZPcGtIMG1x?=
 =?utf-8?B?MEh6dXpKRmFJU3JNSm1wczNLdmRpY3p1UWNWZXhSLzRUOG5WZXJYVHlScndY?=
 =?utf-8?B?NytucDBuWGxrZllwNVREMmZaVnNGTGp6a0NCbEJKMmlQYk85UHNLSWM3a1E4?=
 =?utf-8?B?VmphWjF5N0NSOWVkWXlaMFEwdUtGbWpxdkV5Z1FxSGk5NVc0bk5vcDc1QWVB?=
 =?utf-8?B?Z0tFNStVa3dsTWJMTVNHWEZ5bzEwZ0k5dnVwRG5zcTgvUlJsblh2bzJKTm5W?=
 =?utf-8?B?elNQazBLUytPZkNHeVJlTUFLaitOQkxhSXhjSnM5RGFJVkxKVi9oZFdOa0pn?=
 =?utf-8?B?d21sNjE5azdhVGNrUUxPakN3ZlZhTGhJVW40TlpMWTYzT25OYTZINzY4UmNj?=
 =?utf-8?B?OE83YkpkTFo2ZGdGUXY4K0pUSU5hNmdLK1Vpa2lhRzdhZ3g4WkRJeUFZaXBC?=
 =?utf-8?B?SXFnZnpvakswRnpvQVZSRXdUZ0gvT0t2cmtJRDJCeUdzZHBMSGpvd1gyam5H?=
 =?utf-8?B?bXVlVVBMMWZlbEx0cEU4UVZyTTR4UTF3Y1V3TXhQTlloQmwzQ3huOU94ZzRT?=
 =?utf-8?B?Qm9wZ0U4YTZuaVg1QWhZK0RtZmJHY0lFMGJRdHJtWVlOTEZRZUxVRy9BY1JY?=
 =?utf-8?B?Znlpa0QrVzVaQVB0WVRyZDdkY0pHRHRWYlBSb0RqNUlLc1l0elhIYXB4Y2Jt?=
 =?utf-8?B?eitNbWxDRk4zejUxY1grbXBBQk8vWWRQNUx6T2E2VEZYM3ZMVTE2aFM2Rlg1?=
 =?utf-8?B?Y0QyKzlyZS9EeDBjS2dPaFZVVVF2YjhmM21acTlCNy9GQzN1WjZuSE5ETHNS?=
 =?utf-8?B?a1FhUUh1WGN6ZG91NEJWcjAvZUpQYitIaGdDVjZmUmFVR2VvVzBZNEkwdXdy?=
 =?utf-8?B?OW9aaWkvR0UvTm44UEo1eDdqRzBoaEw0bTA4ZFljaldpTThKcVFQaHBWTmdt?=
 =?utf-8?B?VWhTNDZCOFNlcTN2OFRxNU5ndDNISGc5dXNPWnVCUEkwMnhiVGdrdUNQMFZ3?=
 =?utf-8?Q?Wg/ulKmcev+T5c/vAd1R04Q8X?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AF7695425888545AEADF200AC75EB07@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR07MB4549.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba491f5e-46b4-49b7-464f-08dd9d30f3c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 15:12:52.9861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lKnAeaHKd6dfuh4FziuQCs2jjejxKR582MRc3rzjWxqFGQw/QZi4nDEk0dUDmCvCI6qbVNiGUqLqrPxzW0bFsoP9E7VLYW4iyTBtvSkyamo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9414

UGxlYXNlIGRpc3JlZ2FyZCA8PXY0CkkgaGF2ZSBqdXN0IHNlbnQgdjUKCiBKb2FraW0KT24gTW9u
LCAyMDI1LTA1LTE5IGF0IDE3OjAzICswMjAwLCBKb2FraW0gVGplcm5sdW5kIHdyb3RlOgo+IFRo
aXMgZW5hYmxlcyBtb3VudGluZywgbGlrZSBKRkZTMiwgTVREIGRldmljZXMgYnkgImxhYmVsIjoK
PiAgICBtb3VudCAtdCBzcXVhc2hmcyBtdGQ6YXBwZnMgL3RtcAo+IHdoZXJlIG10ZDphcHBmcyBj
b21lcyBmcm9tOgo+ICAjID4gIGNhdCAvcHJvYy9tdGQKPiBkZXY6ICAgIHNpemUgICBlcmFzZXNp
emUgIG5hbWUKPiAuLi4KPiBtdGQyMjogMDA3NTAwMDAgMDAwMTAwMDAgImFwcGZzIgo+IAo+IFNp
Z25lZC1vZmYtYnk6IEpvYWtpbSBUamVybmx1bmQgPGpvYWtpbS50amVybmx1bmRAaW5maW5lcmEu
Y29tPgo+IC0tLQo+ICBmcy9zdXBlci5jIHwgMzAgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrCj4gIDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBh
L2ZzL3N1cGVyLmMgYi9mcy9zdXBlci5jCj4gaW5kZXggOTdhMTdmOWQ5MDIzLi5kZjdhNmNmYTM0
ZDMgMTAwNjQ0Cj4gLS0tIGEvZnMvc3VwZXIuYwo+ICsrKyBiL2ZzL3N1cGVyLmMKPiBAQCAtMzcs
NiArMzcsNyBAQAo+ICAjaW5jbHVkZSA8bGludXgvdXNlcl9uYW1lc3BhY2UuaD4KPiAgI2luY2x1
ZGUgPGxpbnV4L2ZzX2NvbnRleHQuaD4KPiAgI2luY2x1ZGUgPHVhcGkvbGludXgvbW91bnQuaD4K
PiArI2luY2x1ZGUgPGxpbnV4L210ZC9tdGQuaD4KPiAgI2luY2x1ZGUgImludGVybmFsLmgiCj4g
IAo+ICBzdGF0aWMgaW50IHRoYXdfc3VwZXJfbG9ja2VkKHN0cnVjdCBzdXBlcl9ibG9jayAqc2Is
IGVudW0gZnJlZXplX2hvbGRlciB3aG8pOwo+IEBAIC0xNTk1LDYgKzE1OTYsMzIgQEAgaW50IHNl
dHVwX2JkZXZfc3VwZXIoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgaW50IHNiX2ZsYWdzLAo+ICB9
Cj4gIEVYUE9SVF9TWU1CT0xfR1BMKHNldHVwX2JkZXZfc3VwZXIpOwo+ICAKPiArc3RhdGljIGlu
dCB0cmFuc2xhdGVfbXRkX25hbWUoc3RydWN0IGZzX2NvbnRleHQgKmZjKQo+ICt7Cj4gKyNpZmRl
ZiBDT05GSUdfTVREX0JMT0NLCj4gKwlpZiAoIXN0cm5jbXAoZmMtPnNvdXJjZSwgIm10ZDoiLCA0
KSkgewo+ICsJCXN0cnVjdCBtdGRfaW5mbyAqbXRkOwo+ICsJCWNoYXIgKmJsa19zb3VyY2U7Cj4g
Kwo+ICsJCS8qIG1vdW50IGJ5IE1URCBkZXZpY2UgbmFtZSAqLwo+ICsJCXByX2RlYnVnKCJCbG9j
ayBTQjogbmFtZSBcIiVzXCJcbiIsIGZjLT5zb3VyY2UpOwo+ICsKPiArCQltdGQgPSBnZXRfbXRk
X2RldmljZV9ubShmYy0+c291cmNlICsgNCk7Cj4gKwkJaWYgKElTX0VSUihtdGQpKQo+ICsJCQly
ZXR1cm4gLUVJTlZBTDsKPiArCQlibGtfc291cmNlID0ga21hbGxvYygyMCwgR0ZQX0tFUk5FTCk7
Cj4gKwkJaWYgKCFibGtfc291cmNlKQo+ICsJCQlyZXR1cm4gLUVOT01FTTsKPiArCQlzcHJpbnRm
KGJsa19zb3VyY2UsICIvZGV2L210ZGJsb2NrJWQiLCBtdGQtPmluZGV4KTsKPiArCQlrZnJlZShm
Yy0+c291cmNlKTsKPiArCQlmYy0+c291cmNlID0gYmxrX3NvdXJjZTsKPiArCQlwcl9kZWJ1Zygi
TVREIGRldmljZTolcyBmb3VuZFxuIiwgZmMtPnNvdXJjZSk7Cj4gKwkJcmV0dXJuIDA7Cj4gKwl9
Cj4gKyNlbmRpZgo+ICsJcmV0dXJuIDA7Cj4gK30KPiArCj4gIC8qKgo+ICAgKiBnZXRfdHJlZV9i
ZGV2X2ZsYWdzIC0gR2V0IGEgc3VwZXJibG9jayBiYXNlZCBvbiBhIHNpbmdsZSBibG9jayBkZXZp
Y2UKPiAgICogQGZjOiBUaGUgZmlsZXN5c3RlbSBjb250ZXh0IGhvbGRpbmcgdGhlIHBhcmFtZXRl
cnMKPiBAQCAtMTYxMiw2ICsxNjM5LDkgQEAgaW50IGdldF90cmVlX2JkZXZfZmxhZ3Moc3RydWN0
IGZzX2NvbnRleHQgKmZjLAo+ICAJaWYgKCFmYy0+c291cmNlKQo+ICAJCXJldHVybiBpbnZhbGYo
ZmMsICJObyBzb3VyY2Ugc3BlY2lmaWVkIik7Cj4gIAo+ICsJZXJyb3IgPSB0cmFuc2xhdGVfbXRk
X25hbWUoZmMpOwo+ICsJaWYgKGVycm9yKQo+ICsJCXJldHVybiBlcnJvcjsKPiAgCWVycm9yID0g
bG9va3VwX2JkZXYoZmMtPnNvdXJjZSwgJmRldik7Cj4gIAlpZiAoZXJyb3IpIHsKPiAgCQlpZiAo
IShmbGFncyAmIEdFVF9UUkVFX0JERVZfUVVJRVRfTE9PS1VQKSkK

