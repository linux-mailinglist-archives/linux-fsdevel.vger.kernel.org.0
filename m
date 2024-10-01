Return-Path: <linux-fsdevel+bounces-30449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD37198B7A2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 10:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D7F1F23596
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 08:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDFA19D890;
	Tue,  1 Oct 2024 08:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="Nj5yxF9X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B050E19B3C1;
	Tue,  1 Oct 2024 08:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772872; cv=fail; b=dIJZI8uPl8Af8P2kwMHir7vPgTNFdntZwhjRsXQacftDuU2UBbEJAxbknQ8VzfPu6lWo58Cl2Svk/nPeW8JG79JcvTjfCIFB1fOdxPA3Jf7omCrEkFcGBc3wm3aA3HmAOU+H9tR1tvEOSh6C1pn92NwvXt+vuJpoSM8MraLLu6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772872; c=relaxed/simple;
	bh=KPx9mfZfeJqn/TojLSBxa0iTX+IS0yCfdTdN647y2uQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aZ9ElE+6nHPJrbuHg/5riCGHbBsHiJg+kQud7l9PbNTVpj/DcOh4lBOhuJksp99bVca1pCtEP7Kw/mhTwGAecwQcI6rw16Xw4Rx4SMHGniSlkX91abD+ekc71I5yq1p6kRpQKDp+SD3BdHbDWXek+S//8L0w+0B/nER2GiY7xHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=Nj5yxF9X; arc=fail smtp.client-ip=40.107.21.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9Vs9E6VbS1ISdWMHNIWvZRETB1Jyrz5ugVL1OGvZqJoGHl9rwCD4iXppkJ7s1/Rka9o+C+scEvosgABbT4FvHrH3wqUflscm0jxbR4YVJUH0h+Ogbq4canH3yvseyW+XKw0jDenux8GtD8eTYu8RCM59nOa6sF0b2TA5Lx8H/ko91Z+6fwUOmLJXpBhAgbQHOz2uOIiVNedA8li0ektHSWPksoILuwLnB9RCgIPul2KDzZDXQ44SEpJMdM/lEegOQgvQaeQFp1xQEfJiFtF+5hk96JD+48DrGq4N4agM7dFSfy6endPJS2S/ZB8nWXq5ERT8LnC+IrLKRwMkl+krw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6idXw9a6Hb42Rzlogzb/wT3Rm7aj3x7VLyE2X51hCg=;
 b=JhY2s2HOuNQR5zLVxqfTgoK4SL0hxHrYvJxzuox8rv3DBbII4W1BI2BUN7+67x5fwRwS7bBWtu5yahHKo5LWSgRxWGNUpzqGivEBVj906J6MtTSWx7AYyq569XQ8QWgXY2UXtuoNLPxTKYbnhKdjAmPWgheY4k8sRmfLFU/wNQqYbdi08XCXVIxMXTDGDJUivm5Lf2K3ckz0ibbEq6snuurFyt6ACkDR5/2yTycRiR6chKwO/UkZeEH7T7Ut1xNQjFpvssB2swO0YxwluXueX9zP9UxA8133Qd6qNC55JhdfqKe1tUm5pZynT14PhAx1VondpWZCVfHgeQET0xLOGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=google.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6idXw9a6Hb42Rzlogzb/wT3Rm7aj3x7VLyE2X51hCg=;
 b=Nj5yxF9XyAxX5h9smtaJP/Lo9f2fQll+RWmO/pXD5mOa5JLXdH+IWQiJcbSDTUMi+k0Ey7p2L8TQ3yEwW2y+cdkS9C7rCaLZCG8MqXSVZYVJP3wq4PpNlneghvBBXT5AYHhbX8FBe54q0ZjMnOOMGKZ8EqjAMw8M0DIgArAMR/tAIFijl7ysAJh883z1L8b9thVLIa0KqnUB4HBWVpyiqwCs4eMyYaNHEJQUd17VCkCVXpiGlymKiuSh6qpTqLWXdwX5nVrjnGNc9lThSSjmA5L7g1nNaQGoG4WI+n5fabjBu4mjQyAZWOZFP3m9LNmGxR9xZoUs09V8SzH/IyR2IQ==
Received: from AS9PR05CA0304.eurprd05.prod.outlook.com (2603:10a6:20b:491::19)
 by PA1PR10MB8311.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:44f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 08:54:25 +0000
Received: from AMS1EPF00000043.eurprd04.prod.outlook.com
 (2603:10a6:20b:491:cafe::d1) by AS9PR05CA0304.outlook.office365.com
 (2603:10a6:20b:491::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Tue, 1 Oct 2024 08:54:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 AMS1EPF00000043.mail.protection.outlook.com (10.167.16.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 08:54:25 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 1 Oct
 2024 10:54:12 +0200
Received: from [10.34.219.93] (10.139.217.196) by FE-EXCAS2000.de.bosch.com
 (10.139.217.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 1 Oct
 2024 10:54:12 +0200
Message-ID: <755a5049-d6ca-41de-ba49-16bda7822fe7@de.bosch.com>
Date: Tue, 1 Oct 2024 10:53:56 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] rust: miscdevice: add base miscdevice abstraction
To: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda
	<ojeda@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, "Christian
 Brauner" <brauner@kernel.org>, Jan Kara <jack@suse.cz>
CC: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <rust-for-linux@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com>
 <20241001-b4-miscdevice-v2-2-330d760041fa@google.com>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20241001-b4-miscdevice-v2-2-330d760041fa@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000043:EE_|PA1PR10MB8311:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dd7d1e9-8587-4bec-63c2-08dce1f6a67e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alVPQ3lGOXdlR0E2L1htNVNqNG5SblNqQVNTMGloK01tODhCa2ZZckRyWkIw?=
 =?utf-8?B?Yld5VnA3bTlCM3BQc1hVK2tVY1pNWEZTemNFOEh0ZlgzR3V3ODNFTHdqeTVs?=
 =?utf-8?B?bnMrUjlSRjZ1cFBxTm42R0c0SGNDeWg1Tng4RVZGbzR1UURLcUdhK1NXdktH?=
 =?utf-8?B?bjl5LzgzdXpKZ0FhcFQxaDZTZUdkVUpaazlzZXJKY0lLZXdWOUdHRHEvREdZ?=
 =?utf-8?B?TXVnVHFybTh4UnVFcUt5MG52MEZnME83TGFPSUs1TWtsM2dwak5yb3NSWW8v?=
 =?utf-8?B?aEIvMXhKVTc4YUM1UU53SCs4WWFkUmdmb2JKbUM4NkkzWklaZHhmeFpVZkdu?=
 =?utf-8?B?dVpDQlYxUWRSa0wzYnJkVXVweS9KY3pibm1iUkJ2ZVlhWjZCbjBtaERDN0lv?=
 =?utf-8?B?WDZTRDVBYUY2QU1odGw1My9zcTZ4Tm1hZ0dpTTN1QU5mb0trNUxnTTNDblNl?=
 =?utf-8?B?MzVqa3B2Y1RQRlJyckEyVVV3aWl1YWM0aTRiU3hoR0tldFlBU0ZSVExEWlBB?=
 =?utf-8?B?bTh2U21jSjRlQlcvOWJOK1h3RUwrYWZTaEtENnRCczQ2ajNLdlk3VG4xamFY?=
 =?utf-8?B?Tmd3M3dSWXRISDJNWVZUcHN4Y1hGblBTQk9JVE5nMStGK3gzTDNPNE5pbStq?=
 =?utf-8?B?d1JGWU5YcTJzWW5hcno5czFXQ0ZCK3R0QUVCUTZEQklSVlhuVXRSbWRCMjkr?=
 =?utf-8?B?QjNVV0lVN1BRbDd3Z2xzZDl4ODF4YmpRdUlCNzRXQld5R25WSXYrNFBDNlMr?=
 =?utf-8?B?S3pBU1M0T0crT1pjMGxGRyt0Z0Y4L3FiZWtwYVkzY0grNHFXSWN5S3FGWDUy?=
 =?utf-8?B?RS9hT3BWZ0xSZGZmeFNXQ1NVZ2J3UFBFZm5HcEVuT3ZzVU94Wkc4RzV3T3li?=
 =?utf-8?B?ZHRuMC9xSE9xS0RPWmpFNWcvdnNQaHJCVkNwYUI0ckRNVldmTDB2WENsc243?=
 =?utf-8?B?M1RuR1haSGNCK0R5QyttYk9oTHVuYjRnRyt4NGJwejJXbzJWNDNlbzk5Ymhx?=
 =?utf-8?B?enY3TEp6MlMrSzZkN3RzeUc0YTdJaXcvTjRKNHUvMms0cE52bnJydjZhMHpo?=
 =?utf-8?B?bFlLSkpyWXp4cHRiVlEzamxqalZFMXo3ZHR3SHdEd2VUOHY5SjNQSE5uUXRj?=
 =?utf-8?B?d3RIRVE2NFBXcStjYThBWUIrRHhQSDVERkVqL0kyQ2I1YXJnWlJzcHBxdm5l?=
 =?utf-8?B?aERZUDdvRHJ1b0luUG1sNGJFeXZpQi9ISzJSbUpZc1FtK3BScTFNUlJLNXV3?=
 =?utf-8?B?R2RqTCtuUDl2WStVOU83UStBK2VSN2hhT3dxYTJGaDVvM24vWjlUUy91ODlF?=
 =?utf-8?B?aXhya25pMUdoNzYvZUxLUVpYSTU0T2FoSkg4cjdHL21LeGVoYzlURnNKSjln?=
 =?utf-8?B?cGZndnYwSWkzNys2bi9vNEFOTnF3RWlsdEhBMVpmbTA2eXJsak81MnZBdnUv?=
 =?utf-8?B?bWk5Z1JQZFBhRGVQc25UL0g1QkJtWXR4d3o4eUhMWk1KZFZoV2ZlVnFkbEhR?=
 =?utf-8?B?dHNSNmF3TlhMZjVlenJwdXVwRGpTY0tPZU9PNEVRZUEySlREM0N4QXNWVHJ3?=
 =?utf-8?B?YW91TGtzekVrUEpuTkZDdWhDbkUxS3JTVFZsditXbzhyR2puVnJoY3dqQjc3?=
 =?utf-8?B?TXpLRXlKR21jSjhtR0h6K1JXT0NkVDRTZ2xFWGVUZE9zdHVYTHN0L21rRzlU?=
 =?utf-8?B?VWsyMDl0UHRoRFFOWUphVysxcURzMm9uMVhidWd6Ty9hODd1TVhaRVlIZzg1?=
 =?utf-8?B?TmU1OVNyUFlQSGVWUEZEL2k2cmN0TXhWMitQL0RsWHZEK0E0L09jVmFrKzhD?=
 =?utf-8?B?bkJBNko5WERSeHVlTzlKUHVjeHloblJZOUE5d1lHd1dYalBaWVlnVFVVVE1h?=
 =?utf-8?Q?aTA/WLKtIjYo+?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 08:54:25.0336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd7d1e9-8587-4bec-63c2-08dce1f6a67e
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000043.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8311

On 01.10.2024 10:22, Alice Ryhl wrote:
....
> diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> new file mode 100644
> index 000000000000..cbd5249b5b45
> --- /dev/null
> +++ b/rust/kernel/miscdevice.rs
...
> +/// Trait implemented by the private data of an open misc device.
> +#[vtable]
> +pub trait MiscDevice {
> +    /// What kind of pointer should `Self` be wrapped in.
> +    type Ptr: ForeignOwnable + Send + Sync;
> +
> +    /// Called when the misc device is opened.
> +    ///
> +    /// The returned pointer will be stored as the private data for the file.
> +    fn open() -> Result<Self::Ptr>;
> +
> +    /// Called when the misc device is released.
> +    fn release(device: Self::Ptr) {
> +        drop(device);
> +    }
> +
> +    /// Handler for ioctls.
> +    ///
> +    /// The `cmd` argument is usually manipulated using the utilties in [`kernel::ioctl`].

Nit: utilties -> utilities

Dirk

