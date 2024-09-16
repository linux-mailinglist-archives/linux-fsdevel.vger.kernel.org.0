Return-Path: <linux-fsdevel+bounces-29530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 032D697A808
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 22:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84E9D1F28650
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 20:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF1B15CD4E;
	Mon, 16 Sep 2024 20:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="FXhc38gF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2113.outbound.protection.outlook.com [40.107.121.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A804813FF6;
	Mon, 16 Sep 2024 20:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726516878; cv=fail; b=B14ehF+eudcP1zIm/0Ynf3Ml39E6IB3qXmluvs82McrfwAMhUlyoGFEzpysw8P28Yd+DHkaT0sXGOKDIglPP42giX4UPtFqbm+6+49em+zcNPMDtJ/iVhdZ0z7xiAGSbo1zhZLnAhI7TfwzdZfg4y4IedP4qRtOAMjcbQri3Hx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726516878; c=relaxed/simple;
	bh=6ApPmfCCj+D5Moulxj9dwEeM6CNmn/+wwg6q/+P8Lh0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oUXJOw5ti2eUkcs/hjB3tfGQu506PHnt1QK9A07dRMAaEhtlbZfT49MTs+ZoB/BOm2yq7N9OTGU4Gu7pduOsUUYROaJ1pse/0AoNeI2jcR2uCGKtU4srVsQAFKKzMAnuZtt5B5YG4lGxU8r/7VYMdI/v6YPY1UlkgiZ63DHUwOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=FXhc38gF; arc=fail smtp.client-ip=40.107.121.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4BCI8P5GGdW252tvZi/IE6qcXk+5kGncet5HyYuw9C73QxHiLHZ75P0ufXIWcfTb0QtAQ21E87LlU4L4nKZguWmHIkI8Z9gEI+Y46WytifrG5EzQEHU5U6u4UjlRLIddb0DjPgnqGb+6DGkp/ALMB74McYCWtstFC0P/9nobEFN37HSStvutg2wj+K/j/ZHgHD+fda2s/WaeddGjnSYa4LcLSGAXT3FxmROUsSkEN4UM2akfWecLVIpSfA7s72/3OoEN30JxycSoqCaQ/P4uVmpEd5ulRQkDrepPqiA10BEaIFaIJbEDrSSPIp0UYPEObAVdaouUwBoVatGC/+3Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uW6BEn5rgiy4X5SCKgYysAaUNyj8jHXNWNR4h6vaMc8=;
 b=mntjA7fcw0iupTPqxHI9B5cgf5AHhoRi7GaGZhSUC5Ua87gNd2x5U1NxCwNiWXjgoApIepDcC2p7xJGcFhqJsQ3OZ+ula8Yr9RoAg6B1dV70IWT2+jck2EkaeVe7YpgtX2aeAwXQ2/tM3oz/+VDKAOCD4TTqUoX20zUw+ojsybBk6oKp/vrG1IZ1tiBB7f6rPNn7w1h9yBhqektL/G+O8oF1QUIiD/njxU0Zt6VAwyozPw2glVctpd163z2YWcUAqwEgSiZWXczxF46Tkl8JtVTDWBiNNz3oAHr2eA5eb+zNQXoaUiFjhV6l3TC9OQZHyS/3uLdZNgUVk+Yz1Yu32g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uW6BEn5rgiy4X5SCKgYysAaUNyj8jHXNWNR4h6vaMc8=;
 b=FXhc38gF1LQ+KxDAXF486cMytiZABsq1yMDO5++0cdnZIN2WzRMTUNxuLdwbZ/lDLTK9B3bhH0HP4d68GEGZLkSYro0DobKOuIj13fzydVn4QqbyoXu3hi05fkv2JRkOPeEFRe9l0xlZmj4pFwZg+lGunTtBuIzoy5055sMKqBQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB2588.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:14f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 20:01:13 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 20:01:13 +0000
Date: Mon, 16 Sep 2024 21:01:11 +0100
From: Gary Guo <gary@garyguo.net>
To: Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-erofs@lists.ozlabs.org, rust-for-linux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
Message-ID: <20240916210111.502e7d6d.gary@garyguo.net>
In-Reply-To: <20240916135634.98554-4-toolmanp@tlmp.cc>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
	<20240916135634.98554-4-toolmanp@tlmp.cc>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P195CA0022.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::27) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB2588:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a6eac9-7cab-43e5-e02e-08dcd68a5140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dECuKr2xZfp5rAJ3acSIMPkOXRbItvZaCEYNnxgvudiEJDNpWoJuuHfuuC10?=
 =?us-ascii?Q?PuKsdxV46rPKdyP5ZA7AFhCJ8YoCG5KL9TCNPnGiG6pdKbMkUhvG+MTNaFYB?=
 =?us-ascii?Q?UXXMWPdob2/cT0hzYimTi/fkz1535vejK4w+T3tIyeVb5cfZg5vco0/hD1rm?=
 =?us-ascii?Q?dYkmDxIjnecXey1f9CqsBbsClYqOOev2TZSQVKEl2VQWz52yEpNugRQEdQLc?=
 =?us-ascii?Q?ZROyRDk7iVThUZioW+4NiddYg3Ail3X5geKYze41ZkMJC449HnxBDrna8JkM?=
 =?us-ascii?Q?BKH5P3Az7hYsGCDfTz/eUoMnLt68JiLte47jQEv3s//TbbDHPRd+CfJR1i7M?=
 =?us-ascii?Q?CvmZnYqvcK1u7LwvF62P0cuWbkaiTQWBDO+XkOpb2BClb165Js5Ek20IdeHQ?=
 =?us-ascii?Q?eW/rskusLvGc8pSTq4mJg+77Qcwp4EH+hHc2kxhgbc3xFEWhp9yBCtdMEHrM?=
 =?us-ascii?Q?3jiXBBSWUYmqD3Smjx7VCuSyFf/dKT4jpFKqJrb/jkzZ5NBq+Ih5hxm3y/mk?=
 =?us-ascii?Q?jnTuabrRhyh95rELtXvGUAWQNefl5cX2Gtqa311zmclER1XLJkuVuoKeGrWx?=
 =?us-ascii?Q?sFe5xczYoVc8wyyiecwrX/CowJXoS3VHpgSPi8idRYQl+1VPtgURtOHqlj5U?=
 =?us-ascii?Q?loIPOLdUzqkZ4epW9AElEYYFzJ8A4d1wdgdaacWkkcnJFOhRsZYq+45Xlsp3?=
 =?us-ascii?Q?0Hd8XUDGdTljiLHP7EuMiIA1K4QVOHhez5/LH/AtLsY3qFYaYU2uYe9Tvart?=
 =?us-ascii?Q?pydHaoyKVEZFPM8lRtOnltAaILeob5kGDsn3ozI7+jQvdxsM20J/YKPLKA8G?=
 =?us-ascii?Q?iQv9zf3Uf/Gyq4fSbVsfZ1wWcDFy9aX4sGtOW0qJsQKXqTchkkuLwJiks8Vl?=
 =?us-ascii?Q?8SBHQExb5ja/R8Wvy27EFD1XqMdLXr5YR0L+epYZP/5AAiwbMyPtxu2TkosU?=
 =?us-ascii?Q?aTR29adVmoNRR1uQSmZlUtsm/e6+HqXapvTKHE0OMu0dk7u8zJpu2JPpOxT5?=
 =?us-ascii?Q?PoZCpwS6n/DPqjHAXW3yX4uURgfdaf1/wTE3zCNvlpqvqHd41gSTdJUOQX6b?=
 =?us-ascii?Q?Ls1Gzjo+Ml/j2+6y2mS5snKxiYjShAm1rpUbh/K3ttMlQXn82xGG3J1MEil7?=
 =?us-ascii?Q?gnKVMZUxHwPW9cd3aGTH1qKWmpkLV3YcoRpm4fqan2LTsM2Uy0Z2Tkzj+b6A?=
 =?us-ascii?Q?LHEKD5BZhiYunDDTwMpjykrBm0YGh7V8Bux+ab7YI63cQLs8R/46Vrnnqq6L?=
 =?us-ascii?Q?5nyxnf1lSETVCRV+wEzf4t/28pKt31bSXijWG/MTd53iFKQkqTeK314YcVYB?=
 =?us-ascii?Q?VNMbwmx9YmrZtIBHUacBtwuuH+WMT+JFX4zZkXIwej+SaA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sxTTL9Rpbi1G5IUESt1pcNxrxembmGWUFvVEJdTJwsmdaR/ySh9dJLJthLlv?=
 =?us-ascii?Q?8HpVKpVCQci9gndznQ5TB8sKvKYIGrBooe8dNOSyIq4T4QQg7DyyQb/9boul?=
 =?us-ascii?Q?R0msLHfu7oaN6xf+6yCwXRLliK2jiuNIQrjqhFWYv1fmbu4LxImv1uTRQYkP?=
 =?us-ascii?Q?YeiSPSzSqTAvgijIAj3i6Y532QAB9zpoqQZs6K3mjls+G+jCwFs7p/jA0YR0?=
 =?us-ascii?Q?hVrzV0Hod/9Fi30bLGhUJkynULh5V+8luyJ27+4nkjMVcYIgXtHbf+Pa7A5V?=
 =?us-ascii?Q?dvXKtFphM1+uQIZqMqkY8TLv8+N6u/D4ZYQCpY7um/3+xRI87O/NpYnYw+bd?=
 =?us-ascii?Q?YPIVGvM1OzXsTyyjEHBunAiyGZeLfwsg0AHXxhOoS4JW4pZl82vlErcDcRXw?=
 =?us-ascii?Q?buqrtJbKzqsCfbTzASxN/GgLk4ATG5rFp0jChxWwodo93nhrfmXQx/v1sVXu?=
 =?us-ascii?Q?Q47eFv3Qa5rDVenqAxZtZjT4j+cccJ7ZxtG0tyJ9sRSQwH9s6sW1sbncU2p+?=
 =?us-ascii?Q?KA0YPLg2OmrdvCYSsRO5QpZsVimLgZnRf5BlnNRxQ9a/M1MATRzsuYpYBi1w?=
 =?us-ascii?Q?5B2VZVEzSYPQWCXJCCrTetu+Hyp7U8E19IbEdtrAntVrDB8XlrAta2jMQ3+f?=
 =?us-ascii?Q?bG4Kyr/OtOc5NY6knLDZuSkvI2ZUHObPw7rIBHagoLYf48KihuwpaoVtGYH5?=
 =?us-ascii?Q?qPXt9srgACi9nK+Q1hz95g5hxlH3TCA7dEiF8vSDMUHV3YVCc8FgA9T+u+XY?=
 =?us-ascii?Q?0Z0Y3IdsNISMNKA4yewUEc83eeuNBefEH8Ii9YugfGNhus04542Xfml7iLsC?=
 =?us-ascii?Q?68KbADVu9mbp/88SBl7dsAKcV6h9+mWYqXBVFTXnpJRMeQ2XKkgPDekd1Pwa?=
 =?us-ascii?Q?S2AuMeWXrq/JNcou8yAz89fNiiuUiJDBLyQbMrQ3KwFLw45ty2s4SjQwRBqd?=
 =?us-ascii?Q?cjAvdjEgRG7XwxdQrswrdZ8/zZ71vn5PQR/NCvyO7k7n0Cn5ZU/6r1z2wpAW?=
 =?us-ascii?Q?lISpPfrjlesYmtMYiSy8KMTZl6nRKARUcHyp/LwAYbXGtLwNE0IgycjzAlUO?=
 =?us-ascii?Q?YwHj59G7GtgnFDb0dkj41Gpm5Fg2PkN7Jx8qUyay48KleOCBJ8qSJITyt4p8?=
 =?us-ascii?Q?+WM+mky51O0RJ8fv1adPjf2urz9AsHot/k/GNrPdyxcHmNH8uha65XPknOd6?=
 =?us-ascii?Q?X8+/hNSoxgENRTcxAcqajYCvCV5KuiR9BBcBGf5QxGuvu3UGRQRHAO0QDQSV?=
 =?us-ascii?Q?nqesrPjBW5AOCvg2bH0aSp/pRWiI6f5zOdW2e+6qPZ8iRMcvKpwKCEe6Cs9b?=
 =?us-ascii?Q?arwpfE/mzufmVSb/tnquT48nwN0jWh55wtALwiT5H3q2vgSxrQWVncbQHOQn?=
 =?us-ascii?Q?Vm55y3bN3dkGmeN7/UoVgvmgA2HXlBBck7ixQDqmsTAyuV8pE2Zw3nBink9J?=
 =?us-ascii?Q?Tf5+aKvf4qLHukuSFzyfmJ79vur/oIyB8meozQBoswg8VNDKoX1A4C87vK9U?=
 =?us-ascii?Q?kbISaUNndhvOS9SgiEXbU06Wo+gGz5xi7YGfKZ77bSLHPLWc3nzUrVb35h9G?=
 =?us-ascii?Q?qWJH9OdEBhTUerc2IErS3DSMGVlZT3jMApt2dmpS87vhuipzPFpSUj5LcTmW?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a6eac9-7cab-43e5-e02e-08dcd68a5140
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 20:01:13.8120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6vwypF6y0ryfD/8cP/+KotIr0jm6jf47fXG7gbQr1RsxrcfFE7Ng9HKbjEeVWJGqKkuA+H9TRaeiM8r0YsHjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB2588

On Mon, 16 Sep 2024 21:56:13 +0800
Yiyang Wu <toolmanp@tlmp.cc> wrote:

> Introduce Errno to Rust side code. Note that in current Rust For Linux,
> Errnos are implemented as core::ffi::c_uint unit structs.
> However, EUCLEAN, a.k.a EFSCORRUPTED is missing from error crate.
> 
> Since the errno_base hasn't changed for over 13 years,
> This patch merely serves as a temporary workaround for the missing
> errno in the Rust For Linux.
> 
> Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>

As Greg said, please add missing errno that you need to kernel crate
instead.

Also, it seems that you're building abstractions into EROFS directly
without building a generic abstraction. We have been avoiding that. If
there's an abstraction that you need and missing, please add that
abstraction. In fact, there're a bunch of people trying to add FS
support, please coordinate instead of rolling your own.

You also have been referencing `kernel::bindings::` directly in various
places in the patch series. The module is marked as `#[doc(hidden)]`
for a reason -- it's not supposed to referenced directly. It's only
exposed so that macros can reference them. In fact, we have a policy
that direct reference to raw bindings are not allowed from drivers.

There're a few issues with this patch itself that I pointed out below,
although as already said this would require big changes so most points
are probably moot anyway.

Thanks,
Gary

> ---
>  fs/erofs/rust/erofs_sys.rs        |   6 +
>  fs/erofs/rust/erofs_sys/errnos.rs | 191 ++++++++++++++++++++++++++++++
>  2 files changed, 197 insertions(+)
>  create mode 100644 fs/erofs/rust/erofs_sys/errnos.rs
> 
> diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
> index 0f1400175fc2..2bd1381da5ab 100644
> --- a/fs/erofs/rust/erofs_sys.rs
> +++ b/fs/erofs/rust/erofs_sys.rs
> @@ -19,4 +19,10 @@
>  pub(crate) type Nid = u64;
>  /// Erofs Super Offset to read the ondisk superblock
>  pub(crate) const EROFS_SUPER_OFFSET: Off = 1024;
> +/// PosixResult as a type alias to kernel::error::Result
> +/// to avoid naming conflicts.
> +pub(crate) type PosixResult<T> = Result<T, Errno>;
> +
> +pub(crate) mod errnos;
>  pub(crate) mod superblock;
> +pub(crate) use errnos::Errno;
> diff --git a/fs/erofs/rust/erofs_sys/errnos.rs b/fs/erofs/rust/erofs_sys/errnos.rs
> new file mode 100644
> index 000000000000..40e5cdbcb353
> --- /dev/null
> +++ b/fs/erofs/rust/erofs_sys/errnos.rs
> @@ -0,0 +1,191 @@
> +// Copyright 2024 Yiyang Wu
> +// SPDX-License-Identifier: MIT or GPL-2.0-or-later
> +
> +#[repr(i32)]
> +#[non_exhaustive]
> +#[allow(clippy::upper_case_acronyms)]
> +#[derive(Debug, Copy, Clone, PartialEq)]
> +pub(crate) enum Errno {
> +    NONE = 0,

Why is NONE an error? No "error: operation completed successfully"
please.

> +    EPERM,
> +    ENOENT,
> +    ESRCH,
> +    EINTR,
> +    EIO,
> +    ENXIO,
> +    E2BIG,
> +    ENOEXEC,
> +    EBADF,
> +    ECHILD,
> +    EAGAIN,
> +    ENOMEM,
> +    EACCES,
> +    EFAULT,
> +    ENOTBLK,
> +    EBUSY,
> +    EEXIST,
> +    EXDEV,
> +    ENODEV,
> +    ENOTDIR,
> +    EISDIR,
> +    EINVAL,
> +    ENFILE,
> +    EMFILE,
> +    ENOTTY,
> +    ETXTBSY,
> +    EFBIG,
> +    ENOSPC,
> +    ESPIPE,
> +    EROFS,
> +    EMLINK,
> +    EPIPE,
> +    EDOM,
> +    ERANGE,
> +    EDEADLK,
> +    ENAMETOOLONG,
> +    ENOLCK,
> +    ENOSYS,
> +    ENOTEMPTY,
> +    ELOOP,
> +    ENOMSG = 42,

This looks very fragile way to maintain an enum.

> +    EIDRM,
> +    ECHRNG,
> +    EL2NSYNC,
> +    EL3HLT,
> +    EL3RST,
> +    ELNRNG,
> +    EUNATCH,
> +    ENOCSI,
> +    EL2HLT,
> +    EBADE,
> +    EBADR,
> +    EXFULL,
> +    ENOANO,
> +    EBADRQC,
> +    EBADSLT,
> +    EBFONT = 59,
> +    ENOSTR,
> +    ENODATA,
> +    ETIME,
> +    ENOSR,
> +    ENONET,
> +    ENOPKG,
> +    EREMOTE,
> +    ENOLINK,
> +    EADV,
> +    ESRMNT,
> +    ECOMM,
> +    EPROTO,
> +    EMULTIHOP,
> +    EDOTDOT,
> +    EBADMSG,
> +    EOVERFLOW,
> +    ENOTUNIQ,
> +    EBADFD,
> +    EREMCHG,
> +    ELIBACC,
> +    ELIBBAD,
> +    ELIBSCN,
> +    ELIBMAX,
> +    ELIBEXEC,
> +    EILSEQ,
> +    ERESTART,
> +    ESTRPIPE,
> +    EUSERS,
> +    ENOTSOCK,
> +    EDESTADDRREQ,
> +    EMSGSIZE,
> +    EPROTOTYPE,
> +    ENOPROTOOPT,
> +    EPROTONOSUPPORT,
> +    ESOCKTNOSUPPORT,
> +    EOPNOTSUPP,
> +    EPFNOSUPPORT,
> +    EAFNOSUPPORT,
> +    EADDRINUSE,
> +    EADDRNOTAVAIL,
> +    ENETDOWN,
> +    ENETUNREACH,
> +    ENETRESET,
> +    ECONNABORTED,
> +    ECONNRESET,
> +    ENOBUFS,
> +    EISCONN,
> +    ENOTCONN,
> +    ESHUTDOWN,
> +    ETOOMANYREFS,
> +    ETIMEDOUT,
> +    ECONNREFUSED,
> +    EHOSTDOWN,
> +    EHOSTUNREACH,
> +    EALREADY,
> +    EINPROGRESS,
> +    ESTALE,
> +    EUCLEAN,
> +    ENOTNAM,
> +    ENAVAIL,
> +    EISNAM,
> +    EREMOTEIO,
> +    EDQUOT,
> +    ENOMEDIUM,
> +    EMEDIUMTYPE,
> +    ECANCELED,
> +    ENOKEY,
> +    EKEYEXPIRED,
> +    EKEYREVOKED,
> +    EKEYREJECTED,
> +    EOWNERDEAD,
> +    ENOTRECOVERABLE,
> +    ERFKILL,
> +    EHWPOISON,
> +    EUNKNOWN,
> +}
> +
> +impl From<i32> for Errno {
> +    fn from(value: i32) -> Self {
> +        if (-value) <= 0 || (-value) > Errno::EUNKNOWN as i32 {
> +            Errno::EUNKNOWN
> +        } else {
> +            // Safety: The value is guaranteed to be a valid errno and the memory
> +            // layout is the same for both types.
> +            unsafe { core::mem::transmute(value) }

This is just unsound. As evident from the fact that you need to manually
specify a few constants, the errno enum doesn't cover all values from 1
to EUNKNOWN.

> +        }
> +    }
> +}
> +
> +impl From<Errno> for i32 {
> +    fn from(value: Errno) -> Self {
> +        -(value as i32)
> +    }
> +}
> +
> +/// Replacement for ERR_PTR in Linux Kernel.
> +impl From<Errno> for *const core::ffi::c_void {
> +    fn from(value: Errno) -> Self {
> +        (-(value as core::ffi::c_long)) as *const core::ffi::c_void
> +    }
> +}
> +
> +impl From<Errno> for *mut core::ffi::c_void {
> +    fn from(value: Errno) -> Self {
> +        (-(value as core::ffi::c_long)) as *mut core::ffi::c_void
> +    }
> +}
> +
> +/// Replacement for PTR_ERR in Linux Kernel.
> +impl From<*const core::ffi::c_void> for Errno {
> +    fn from(value: *const core::ffi::c_void) -> Self {
> +        (-(value as i32)).into()
> +    }
> +}
> +
> +impl From<*mut core::ffi::c_void> for Errno {
> +    fn from(value: *mut core::ffi::c_void) -> Self {
> +        (-(value as i32)).into()
> +    }
> +}
> +/// Replacement for IS_ERR in Linux Kernel.
> +#[inline(always)]
> +pub(crate) fn is_value_err(value: *const core::ffi::c_void) -> bool {
> +    (value as core::ffi::c_ulong) >= (-4095 as core::ffi::c_long) as core::ffi::c_ulong
> +}


