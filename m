Return-Path: <linux-fsdevel+bounces-45154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2808A73A4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 18:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85752189732E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 17:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33331B3957;
	Thu, 27 Mar 2025 17:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rWxxyDDf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF9F224F0
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Mar 2025 17:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743096165; cv=fail; b=oIgVJcCzkkiB1vF8z1IKTr+Y2Z6+8aCvIKGXq0DLliJ+Ur2xJF/wjVT2ETrkiLBx1c8pkTOcCN5CzCKqvgVjZLFw2N0eK9NESPee9VH9InoeC8hwt+EsD7k1h7etXlpIMH/AQz+q/3kC5K80cPoZGwMgp/hulrRw1vhvyHNO5/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743096165; c=relaxed/simple;
	bh=UAfkxGZadJw3P57wmqSzhCH/YXNZU6lS91UPBemggvQ=;
	h=Content-Type:Date:Message-Id:To:From:Subject:Cc:References:
	 In-Reply-To:MIME-Version; b=t5QjKkInAq62bmD0kO1uyKm0hH7+p6Xs6M6BHGx6+67NzJHrM8400CursqYSjcLtBP8lU9vrtdTXdWnZtdamg1dUrqy9KgtjDfQdhhwuEU5FF1silkk15A0rx1VFkvspc60nppEp0AnvVItl4IdShNh+45vgJFNzWXZws6RLdms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rWxxyDDf; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PERIzc1dWoqHf97lGROeqfwbe1HUhbe9bSQZa6vIsEM5TerNjEALJ8YO3Hwp+r0R46Jrlb5sm/p0nVq8Bp3NdNmfaWgIE0B0ayfX1tlm61P3QY8nr8FjoC3vtJedhdqcitUeI3JPMr1nN+LGCBCk4ZF/UqxmNxga9P8cwtFEhTCXsXkV8B1ojZhtK1Z36L6ibq/NVykVveSG3GFxcVieT8ZLZf3+59Ja4nXUoYxHZvivoSDW5vljTQ9Y0RXdyB4ANW16UNnQX/82kAsledtDKYUl8MVAOuLlXLxhRiQ/cqLvw4nFG5fSL48/qDwoR1wU6ZXPCwOiJXeMAf7n2OGBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKu6+hiNRdcNe+gZ4LY6PR0sPY4AQrPMHrp+LgXEiUA=;
 b=ujOl+jLd9cNWZiKcQD/FRRNwX/pW62fSjnYvJ1Irrc+I/ZX9ZaZAHCH+bsCrBQVrlyXUGoesq/jAzB8Vd5iXLymIdTDCmxtzbCYVy76o8QOtOJEP3tAaD+YzgtHjsgLCQmvFLO+h0eYU7Zu3e4v4s9s8P2aTSaL0isBouNPDanBGXfmX9r5Yl6IYvLwjLrqlZwnQgfKo5IroIO+KDx/radFs5cQElS9+FMV6w046RJOMaIURBaemMherRkhxnP3ofSaUDuHmMnlJiLkgLsOYTImzElKQavmR/pNIpABeFV0jEXziifHh/DyaPvJh1EMVryXng92NqRgkPHmwM0npeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKu6+hiNRdcNe+gZ4LY6PR0sPY4AQrPMHrp+LgXEiUA=;
 b=rWxxyDDfD1mj3oof1F3Q6Op0c5sysm+XbelQMZjqbEvCE7tbdQB7D1qSIeXSoKNWdPrE471vl6hCS0lB9WXT+ejf6cRJmZAbfYUfPTlGJa85pN36onpjO7+niKY3OinMTOOHj6j7XnhRakq3VdEnxsvxZcjWI7vzyATDPUlOKB0UBtljDfcG0sftHyhFIEyaYNG2IIU35mqciVEDBHCG7kkczEQ32mj6+kynBqUz9t7tQozkCd9+pJ+SSCKfznIu3r+HUEMZeSEjuGJPNcz+Z2wghpizZtv9xKDQPLSuOWc8boaMzuaJb6esE0OG7aAR2Vr6rABYbo4JsjS192bwPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA0PR12MB7073.namprd12.prod.outlook.com (2603:10b6:806:2d5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Thu, 27 Mar 2025 17:22:40 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 17:22:40 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Mar 2025 13:22:38 -0400
Message-Id: <D8R80OMV06HN.2MXFKF6L5851V@nvidia.com>
To: "Matthew Wilcox" <willy@infradead.org>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH 06/11] migrate: Remove call to ->writepage
Cc: <linux-fsdevel@vger.kernel.org>, "David Hildenbrand" <david@redhat.com>,
 "Joanne Koong" <joannelkoong@gmail.com>, <linux-mm@kvack.org>,
 <intel-gfx@lists.freedesktop.org>
X-Mailer: aerc 0.20.0
References: <20250307135414.2987755-1-willy@infradead.org>
 <20250307135414.2987755-7-willy@infradead.org>
 <D8R539L45F9P.3PIKZ5DUGGVS8@nvidia.com>
 <Z-WCMYYQRsrRlikA@casper.infradead.org>
In-Reply-To: <Z-WCMYYQRsrRlikA@casper.infradead.org>
X-ClientProxiedBy: BL6PEPF0001640C.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:13) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA0PR12MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: ebde6af8-e2a7-4913-37e7-08dd6d53f9f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1FXUU1taFQvWW9KWURHUVVNaW40VlJTUjVnWHFWSGlsSHdDK3RuVzhsNzE3?=
 =?utf-8?B?VFpoZTVKams5VHpjZ21wU3BZWTJGUExSdDlSc280Qzc4QlNudHJlQjEyeVE4?=
 =?utf-8?B?VCtJdzM3NEd4VndUSjBIMEhZRTlrMExRdVltUTBCcnFMamRQSEozaHVaYUhU?=
 =?utf-8?B?YUFIU3lCSEpCeEJ4TmlST2tzU3dlUzZEdGlqL2NiSC8reUhZRjkyUHRPSWti?=
 =?utf-8?B?M0NMK2NvM2htNi85eVhBNVdFM3h4QlZ6KzdpK1E2MW44clBaZWh3UTI4WEt6?=
 =?utf-8?B?c3UwU0VUM3I0cG5FeHcrSnMwTDZFN2ZuclNqS211RXhMTEgvMmpLR3AvdWtr?=
 =?utf-8?B?c3dBMDNwMzhnVVpjUWdwL2xMSmV0clJxMVU0SDgxSS9DY2pJaFJkdmlUQUdX?=
 =?utf-8?B?TDQ2S3ZKNUNlNU04SkovaFRCc1dkZVhMU1ZTQjF2SGp0YUcxRysvR3dDUTVv?=
 =?utf-8?B?VnFIQm5oV1hhbno4RGRlelFFYnBWSlFpdm1zdDN1K0tpSGZIT3lINmtHQ1pK?=
 =?utf-8?B?K3duZk9qcXFOc3BhTkxkS0lVM2NFdFBuZ0t6N0pEVHlZUXo4RU4ybmZ4ZHU4?=
 =?utf-8?B?Rkp6Z2hRc2paN28xTzJNRGRnMXMxcUh1SE5hTEFaUkNTMGpqQnBLbnoyVE1z?=
 =?utf-8?B?cEVXb21Hb1psNWJEaEVkTEVVcXFtM2tITVdvNlB6Z0FsY2Z2dXN0ODcvbkg1?=
 =?utf-8?B?eHA3U1R2V3o3Ykp2cWNoRU0yL3hQZWZva3FPYjFWUFdlUTk3enhzQUJBNm9V?=
 =?utf-8?B?dVFpSC9rM3Q1RnBFYmcvZnJHbWhQR00zdm45V1BFazFDT1krcVVpYlh6Yy9K?=
 =?utf-8?B?dWVsLytXVXllRzM4UHFlNEhGYjBVUUpRTzRjYzFDTlJrTlN1V1YwN1FxbEIv?=
 =?utf-8?B?Q01melhFdTk2NkJPZk1CQ3Q3dzNXcGhXL0VoNGI2bm44OTI1WUt6MzBtQ3Jt?=
 =?utf-8?B?VDJ1UGdPMlVMa1lIY2g2WHdNVjUrSEQvMXI1NVBVaERTQTlhOFlCNHRxTDAw?=
 =?utf-8?B?dmM0cjB0Ym1qK0xGaktvU1FyNENoSm43Z0t4bGZsT0JRbW13bldDYVZMOG1y?=
 =?utf-8?B?THRMK0Era2E2NUdiZVBVLzRSS29DQUlONXRGcG5nUFdDSUN5dkJWM2o1L1RI?=
 =?utf-8?B?UDBQTVRYaTZiMlExWFRmY0xFUDB1QlJYeUtWTktZWjZiVyt6akJzbjhDZ2VL?=
 =?utf-8?B?bVNvTFRIdGVVam13R1hUWWFHb0RxaHBtRk5KN2k1ZjVadHRuNjlaQW5tYzB5?=
 =?utf-8?B?WVQwVnprWFRVSTFmTHhNY2I0OGh6VHRiWi9VZ1dIVlVMOWRuTnZDTXN6SXBG?=
 =?utf-8?B?ejJJbWJQQmhHUmEwNkxleDlVRXlZa2s2TEhvSmkrQXpKb29pZzVZTHgyRGsy?=
 =?utf-8?B?SkE0RXVNbWhJVmhNMVNmaXBYT2ZTYWkvVTF0a080QjlUN3Vpb1lKS3ptZ2Zs?=
 =?utf-8?B?Zk5zWjdDTnBDUjB1eFRBbDZVUm1hdC9waEVaZzJ6Sm1wdEZ3dkNjazVwZUVD?=
 =?utf-8?B?bHVIUWRtbWZWWHcyc2ZPaVdEVUtSeG81clU5ZHBLSEJJaUF4YThmT0ZCK3NW?=
 =?utf-8?B?UFR0bWNBbWVaMjVtOE9La0VLM3BJd0o5Z0Fmc1pPczV2S2R2TkNoVlZWb0V1?=
 =?utf-8?B?aCtmaEhBOW9WZ2dwYjhSN1VNSzNYZWZDRXI5UHkvMVRvTC9XcTF5Q01kVHpq?=
 =?utf-8?B?WmJ4RzZMV3dPSzFCNmpmanFZb0w5Y09lZmlWaUFZMlR2cFNnNmhmTGNJM3Ux?=
 =?utf-8?B?TlpWSkw4d3VpL25wZmRIY1JPUU1ydkQ2L1lFUGRJaDNxNjRUSFFLRUtoY3JI?=
 =?utf-8?B?R2ZhVjdiVEJIOVl1d2ozYTNLQ205VWFmbHpGT042TTlZbWliQ3pQOEQ1NFhW?=
 =?utf-8?B?RUlTWkZ1eHZ0U0d6MjZ2Z2N5aC9XbkFWVCs3SWk5b1lxM2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjI5YzA4VjFqRjI2cFBrMUhlcXVBWk0xQkdFSVcyQUVPb3o4WGJxNDgrZGV5?=
 =?utf-8?B?Y0NkL0ZtSGpnY1BZQW02U2F2QXdKckV4b2dLb3lsK3UvVE9oai91VkJQOUF2?=
 =?utf-8?B?clFaM2ZWbW1oVEZWRm05R2RGbkRyYzBNdTVDZWN6cHhwd2dGN25xRVgrcndk?=
 =?utf-8?B?Y01nQlpFeWVsVjVvdHU2Y2lqaU5NTy9mazJzVVdScjFwM2hRNTNLaGRUelI4?=
 =?utf-8?B?TGNxSnJ2TTVkVE5zdVlTRy83SXZXaVFoaHczaC84T0ZkOHlDNmRBU2RHVXZK?=
 =?utf-8?B?VDFtVGdRS2lsTFJjVzlsemsrMFdibE1ORHRMcXg1cDI1YUVycHBnN3h0S3lh?=
 =?utf-8?B?YWd3U3BPdEF6b1o3S2srNDZHbVcwK0c1enpCOEwva1g1UE1tR09pQjVNT1JH?=
 =?utf-8?B?YnhaOTRuWUxzeER4alRzcUQxaGpYMFY5NjZMV2RGMU9vY2FCV0pQQUhSd2Qr?=
 =?utf-8?B?cWRKSjBnUUNEZkVvK1pWSktZbkYrOHBGakpUeDIwdFhDRlNlNmNHYXBLQWJH?=
 =?utf-8?B?NUYzeEFMSmJJbnREdldCaHFUMlBJanJqQXg2QjR0MkNYTGF6VnNWMnY1WDJY?=
 =?utf-8?B?eDBqelI1Tk50RjNsQWNxYUVTZDF3WEtoNUVvU3RsWCtwMDlWMFhMM0t5R0lw?=
 =?utf-8?B?djdoejRHbmJqSzBNcmE4R2xqTEk4cm8wbGI3ci9paDlCVkdWK3AvY21WRXdr?=
 =?utf-8?B?VzE0K2tEaStPTmFRTk5pUzVNY3kveDBRb2NJWjkwRTFDK0k0Z2FOV1FNSG9T?=
 =?utf-8?B?WEkvQW5NZGt6Z1pOZXhPMmZTMGhkcUF2a0dUdEFuMWs1akNVdW1zdURXQ3ZL?=
 =?utf-8?B?c0d2WlRRZTh4UXlzMjkrTjI4V05GcTk2YWUwTkwzMzVGTXNyNDNPeW1iMEpE?=
 =?utf-8?B?MlJ6V05YU2NKaDlvcG5uNTRsMDNGVUt3cEVlQU9VNEFiOXljM1E1eFI2eUs4?=
 =?utf-8?B?ckhGQ2dDUGJCRXd3NHJoZFdKbld0WG4xSTRGV3pHa0M5N25RNTJCUjdlVUw5?=
 =?utf-8?B?QUNGNnIwTmV1eGJUY1pzNnp1eFY3YjhTYVRBUlFiUUwzbFF1SGVRWXpvRzI3?=
 =?utf-8?B?TEJDd2tQOEp3c3hiZkhsd0FUZzBtVkQrZEtWRk5SbkFpS09YejNCMEEvMVZv?=
 =?utf-8?B?WGd6WDJXQjZOdzJaMDZpdGxrTmI4anZqWDI4U3U2L3NWMFVLNkx3ZDdCRUlW?=
 =?utf-8?B?TENnYnNTZlBXazJnRzlSSFVoNHE1MVlVWHF5MFcxZ3JLb0dYNzF4eVpRUkpW?=
 =?utf-8?B?dVY2aFJsMlYzTURnYzJOaVZJY2VhSEJGaFJwWVBKanhiWUh4K0pscXdMVkR6?=
 =?utf-8?B?RmlncmhlTncydDBwa0xnVlZrdVFlUEtCaVR0dTVuSWp0ZjcvVWI1eHo1ZC81?=
 =?utf-8?B?dzZPdHV0T2ZTREZsUW9yV0haZzlXTEwxZkd2MVZJYjRzRGZ3Zytzd2FmTG80?=
 =?utf-8?B?Z0sySFczUVFTdjBKQUpCUnFFQ0IxNWFvd3MrWUd3eFN3eGFPNWZTZlhaMDhL?=
 =?utf-8?B?UmtoQVJpSUwyNWJXRnYyWk1pbDJpS2RYSERGYk85VDUwUE52NzFtUzZWQXll?=
 =?utf-8?B?VjVVMkFYblk2S0thOXdFblMwSS9RWUY2S3ZGa3Vna2dPYndyN1hNM2ZXV3Rt?=
 =?utf-8?B?bmVjSUovNThIK0x3NTBlWHlwVmhkT0J5T0ZUR0xuMHRsdkRvVkZKV3lIeE1y?=
 =?utf-8?B?UE13MGNwVjU2dHo0MHpCQ1N0NWpPMzRUU1ltQjJKSGo2VnlRZzZzRXcwRzlz?=
 =?utf-8?B?ZFNzZnN5VDd0OXZ0RXVIQU5uZFlnRFA3em8zV0phNWJjYzdybXhrTzFOblhI?=
 =?utf-8?B?d0c5RzBEVnZwZTEyWDY4aXV0dmNlTFNRb01PQUtSK2dKZTFJQVpuRHpMS0lR?=
 =?utf-8?B?MHFURUxqTVkyeVdKL1p1MktRbGhsMEZUeG9VcjB6SEhOT0w5bUphRnRBZEFV?=
 =?utf-8?B?THR2aHRyN04wTE5XQnhNMWlKMGMrQ3BMa2d3Y2wwU3VXdUd2M0RTb3RORzVG?=
 =?utf-8?B?dDFoUDkrMUltRWlmZDlnbDdMYm9BTG5BOEJQSi90T2g4aUY5cXV0elhnYkZw?=
 =?utf-8?B?ZWt1aFBJaHhCS2pzeHpvcXpBdWJLNnExRjVMN0piMTlPL0lVVUtqR2U1Ykdp?=
 =?utf-8?Q?AMwStZV73G0whk3DZ9P6mkZwX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebde6af8-e2a7-4913-37e7-08dd6d53f9f6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 17:22:40.1126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+cTptnEarxi+sh/lrichjb6WCa0yhofq+vUo7j/DfGJKW2RB3IGL7ftzdbgIQ+t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7073

On Thu Mar 27, 2025 at 12:52 PM EDT, Matthew Wilcox wrote:
> On Thu, Mar 27, 2025 at 11:04:57AM -0400, Zi Yan wrote:
>> On Fri Mar 7, 2025 at 8:54 AM EST, Matthew Wilcox (Oracle) wrote:
>> > The writepage callback is going away; filesystems must implement
>> > migrate_folio or else dirty folios will not be migratable.
>>=20
>> What is the impact of this? Are there any filesystem that has
>> a_ops->writepage() without migrate_folio()? I wonder if it could make
>> the un-migratable problem worse[1] when such FS exists.
>
> As Christoph and I have been going through filesystems removing their
> ->writepage operations, we've been careful to add ->migrate_folio
> callbacks at the same time.  But we haven't fixed any out-of-tree
> filesystems, and we can't fix the filesystems which will be written in
> the future.
>
> So maybe what we should do is WARN_ON_ONCE() for filesystems which
> have a ->writepages, but do not have a ->migrate_folio()?

Sounds good to me. Oh, ->writepage is removed and there is still
->writepages. Presumably, it is possible to use ->writepages in place of
->writepage in the removed writeout(), but that is meaningless since
->migrate_folio should be used.

>
>> >  static int fallback_migrate_folio(struct address_space *mapping,
>> >  		struct folio *dst, struct folio *src, enum migrate_mode mode)
>> >  {
>> > -	if (folio_test_dirty(src)) {
>> > -		/* Only writeback folios in full synchronous migration */
>> > -		switch (mode) {
>> > -		case MIGRATE_SYNC:
>> > -			break;
>> > -		default:
>> > -			return -EBUSY;
>> > -		}
>> > -		return writeout(mapping, src);
>> > -	}
>>=20
>> Now fallback_migrate_folio() no longer writes out page for FS, so it is
>> the responsibilty of migrate_folio()?
>
> ->migrate_folio() doesn't need to write out the page.  It can migrate
> dirty folios (just not folios currently under writeback, obviously)

Got it. And I just noticed that Joanne's change is in
migrate_folio_unmap() for folios under writeback and irrelevant to this
change.

--=20
Best Regards,
Yan, Zi


