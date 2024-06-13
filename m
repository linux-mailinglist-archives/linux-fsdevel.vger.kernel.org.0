Return-Path: <linux-fsdevel+bounces-21644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABB2907420
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 15:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD0C1C230F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 13:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC244145326;
	Thu, 13 Jun 2024 13:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="GYETzRKa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2139.outbound.protection.outlook.com [40.107.121.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAED71448D2;
	Thu, 13 Jun 2024 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286280; cv=fail; b=ImHcHDda/jpFpUEE4b6p+NAnZwzaq3VQp5KMxMD0UGpgeHqoArXQqYmdZdV+dcCCNlKOb+F6AkLSXmPXzU0ma0JK8U4eT/uIwH5G5pwxI1MFSBPDrWWG3jZLB+a4HxcEfSOhJoapd9A90YQoTK2TbITkNORGchMBtZa9/QN+Ue4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286280; c=relaxed/simple;
	bh=x96jxdDDd7wUgxlvNbZKO/EbiknT/q2Fggtu5O7wwNY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X69qwEiCjG46ZiPN1gbfNZ/bYwp1IPp+uNG/Zzmi//QW9jKhX6yv9XBy5J7CP/1+pL/YBljq+Y+T7zpWWBJ8Pm8qaKYygXuq1Nwd9dcUYM5uviXKlGrZmrAATV9w5amTvpE9xp1TDqbzM2TalLWIDrCYp0dER11NUKR7vBvUdX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=GYETzRKa; arc=fail smtp.client-ip=40.107.121.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIJE6XHALrjfhs6HL1mztNcdWakIxfyi3JEGVUIh8bYN8cHHW3XfnyryR7LqOVv31FLauT5mxktqahNGekR9HSk3hWc7/z1OabZfG3My6pVzQ63k+MMG8iDbHphBG6UonooX3FSWLHBPUzQ1XGJQrnbBYYr1EQEE0AFDtcIgCzZ86q1nLJi3r9i/Nu+sC+bDyYIqPlIfvaD+SBGMRvCEf5DeAVHgqjhkeeqV4jdlN/6DCU1DPX3WEChNXkC038EsKZcq49yXHc3t1wqD+A9QEfmLuRWLfBvgjLVZlb+pS/24lbj88GYHBNzvwbPFOIHtZzdMWzG7pHs2A/xna+OE0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlYxqTRctDjDbYiVd/PYM/xpxu1dqzZMyjagKEmsnIo=;
 b=PaPORIqHadXwXVotyofI65ywg5EmZNGFVyVYP0xfRcYOWyqjcDPtPm1JZB8oPY+RfyLsyMUa08ZAbNne6p+oVBYJiT3A2oupd2fNdVRSlKyQ9AueffYi7HRl0C9xpBGoGo8M28n5VaVa7W02ZE2/tMcfefdcYed+cF9cGWJYD2PNEC0OGXt7oMaGlN4rO50s8epOdgatxoSNfI2gNu/8j9LBV4WiUKvr5peCKZoJEgxIrWbT6E7+0qfkrv7V8cyp2RYkP5+WVQk5ouE7YGzqbAcc+mmbVi9/sd2tV+dXax6oBVXZoZzepQgPAN3S7oju3Rpd+5WsFgpNwqM27QK8yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlYxqTRctDjDbYiVd/PYM/xpxu1dqzZMyjagKEmsnIo=;
 b=GYETzRKaNc8Xla2nY2R3xbmm4fgPRlGWxgT7ubA6RYVFYazsCY/QcltadQIaMPS48kR35hKkzMoc9wXxg/5Uqz6WV/neui58g6vfVW5S8ZBpwBuPDoa4vWez+2SLaPg9XP8u5fE4n4N3NqnjpbZH0aQKlKBvBY9aRkEw4dVBMFA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB6573.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:300::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Thu, 13 Jun
 2024 13:44:34 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%5]) with mapi id 15.20.7677.019; Thu, 13 Jun 2024
 13:44:34 +0000
Date: Thu, 13 Jun 2024 14:44:32 +0100
From: Gary Guo <gary@garyguo.net>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, llvm@lists.linux.dev, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida
 Filho <wedsonaf@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Alan
 Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>,
 Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>,
 "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>,
 Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes
 <joel@joelfernandes.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, kent.overstreet@gmail.com, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com, Mark Rutland
 <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>,
 torvalds@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, Trevor Gross <tmgross@umich.edu>,
 dakr@redhat.com
Subject: Re: [RFC 2/2] rust: sync: Add atomic support
Message-ID: <20240613144432.77711a3a@eugeo>
In-Reply-To: <20240612223025.1158537-3-boqun.feng@gmail.com>
References: <20240612223025.1158537-1-boqun.feng@gmail.com>
	<20240612223025.1158537-3-boqun.feng@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0273.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::8) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: 749f7318-25f2-4770-31a5-08dc8baef5af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|7416009|1800799019|366011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RgVzw7lNObaGzG0XvtTjKv5LabaIzsYEyQ/nsZmRHumxOPXyRksUorVY+OtQ?=
 =?us-ascii?Q?pcBslkLkVV2TpDRetuFr06J7rKrglckhygUssSzVYhj5go+IxkeFWW7DF1uN?=
 =?us-ascii?Q?vfBmC3CKibkpX1U7Jci6beD8K2SbzMgSqrWPil61ftKdGUomieToWNp83n9+?=
 =?us-ascii?Q?mzIAIA6YZztswcmnwM0xqhpv80vRXeZHx1NcysOD8yB+L9lP+X1lpWclaGoO?=
 =?us-ascii?Q?ynx4ln3MznLvVUNvu46y9FSDRrGNgiXdTX9/S4x1BExqDczBh6CKreXbdfqM?=
 =?us-ascii?Q?fPzaBfX3vKBM7xrY/UoZvlN79pL0IoHbu3Eumy8javfFzno27bTz+gm3ItJh?=
 =?us-ascii?Q?fYgO3MxVEytafncZtzI+7h/980gvawv921izZjVMo4tKQ4ad8jlKS4KJXGek?=
 =?us-ascii?Q?7uCCKCwizF7MkPebTdwMx4eJ0EiHufsK0lwmx9371QekLC9Rk4vlJZapZiCf?=
 =?us-ascii?Q?QCO47TXGEuDANqRN1CXbDgKgiAlhute757QU5K3BeIo61A/2ttfXpRK3Nd3g?=
 =?us-ascii?Q?EvoT6/slknXd3rvQEI2mIpeotim2GyBOel3dWjg+bmFxUXBdOFaGfPFqIJMa?=
 =?us-ascii?Q?Zv00o2eviNcjM+c1RIvSqit1BQP4KEKTKoF4M8TeRUue9+aYc1OHhzPvgEVK?=
 =?us-ascii?Q?Ehg0sxgHcU3HQi2Sl4MQU3M2eirQtpKqjRPAE1IM09YsTScps2OBRd7VLMqD?=
 =?us-ascii?Q?7It/KzhjH40ysL5MECCOtaV8cYl5QWAED6ACktr1TA6sHLqnS/nBJ8d5/54D?=
 =?us-ascii?Q?wsQaQE/raU7R+TVtP97xt3yM8AbruOtJhyli7381sz8BezZZB7hdy7Z83ffi?=
 =?us-ascii?Q?DCP4FQrZ/45jWUk1ZAZxRytbNh+LtGtXgER/uD5Kh9bScvjtiLw8EQO62gzn?=
 =?us-ascii?Q?5C7Mze3BhHoyvrHQeRNP4CqnFQmEoYp8C6rJHQeGeMO69SKDd5cCyhpbnpju?=
 =?us-ascii?Q?7iOdPlRbSmWCwk68EQgWOb3aDa9hcdrp5inx+OU48X+73M1A8FbWRPCtrpwN?=
 =?us-ascii?Q?IT4+J3WSrz5S4vRlZU8m0r8CHmS8CZThWmIxVlt3lb2FPTVTCcAT1ye2p2zD?=
 =?us-ascii?Q?KaAJ5cj2p9WAKrbq1z2qWcuo7zBtMvI2RoZ5lvZr/z3tLEv9/YbDyYUP4/5n?=
 =?us-ascii?Q?dKa13BkAvqH6IFBE7ABy3jtl79V9yzU9YKMu0sUUj2PI8nsjlw4mJERzioHr?=
 =?us-ascii?Q?OJnI/OybGmeDPKdLaAxr+qObD1aqQpyHIx2OWjh+FDX4PEGLCKbD8V5vHsv0?=
 =?us-ascii?Q?xmiIw7FMTCml1ijAq4XA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230035)(376009)(7416009)(1800799019)(366011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W2nv7aUvoYk2wYvPPbHoEYe3q+sX9zaYY97BIWHE1svQF7rIuQYHK89RTSh6?=
 =?us-ascii?Q?orMGU7nggxGQrKfAswX+yABJezydEop8KvSv+s1q8m4HbaXiUFmbQ3Xd9bWU?=
 =?us-ascii?Q?VihoQimzREUs60GoWnKykIkRvkC8RECWA6b8sPL82fMWj7A3QdW3CuepcuyB?=
 =?us-ascii?Q?FC5IRRxw3JSdbwnySg08MPBVqJ5Lv0UCmBjjRX3454XSN8o6bZGWORlJgF74?=
 =?us-ascii?Q?QqPqnITFN20loe2shwOeOI1XiB6W9PX7JuUNHxZj16I6zAXZUhvztBTiPlKs?=
 =?us-ascii?Q?G/x/vEegltx8DRl/qC4Idw17iLWdjPCX2KkhEDRX1nhbm4guCb5lXz2IXCVA?=
 =?us-ascii?Q?Ca1Vr+fjjX51tKcW6aGCLVtu4Qyeb0flClWwD3CNV/o3lC82GxygoyjkdVJ8?=
 =?us-ascii?Q?EFkA/XTTgef8qcX9SnKLkf2S9hbKUm4aFJyMqJgKrmCRjtE3cvgmQR3NbiFP?=
 =?us-ascii?Q?baTt39B+bsfpJo31mWQ3Z8S3xYMqPCatNyWkYH6bMWrKvbvTkAEKD+0UxQs9?=
 =?us-ascii?Q?CvS0TLq0JJDmChMhN8Oy9LtvuknBC6KZEyMk+RZd8R95phzQWFriUe/Jx3j9?=
 =?us-ascii?Q?zwek0X/uwISwsbY1rUyt+0zpRi79fAYh2LT2VskIXTas3f2/CTZu7+fNT4pM?=
 =?us-ascii?Q?GaoRjgiw8T3xKpGL7pIy8yG45K04njccsGYkEEWX3/KCNalLVxzr4h38k4tm?=
 =?us-ascii?Q?sIYBf7nt/OtccJRA3413dXdw9G0ZxRkXF12tDZJXajmHAvy8wKDJTloFUsDy?=
 =?us-ascii?Q?oxCEfHuAhhxVFjLcusoudsB2eO4/m3dDo0Kq8WdTFd6oLlRtbmVZNwpt6C9J?=
 =?us-ascii?Q?uGWknpC1jJ+ZBKb5zY/dtevQxUrgao11Pn0JunJFRcYY4Z/3YircENJr9/OS?=
 =?us-ascii?Q?oK5/36uiHPXAuR88d8Lk11+kX+jtlUcfLTzLSB625XgiDCNpTRnjKCx5ObYz?=
 =?us-ascii?Q?0W9LwhDydYAHGETlYsDqbylrQmn/l8G+1UmOf/12LJJXIOp8LWKh6eiAgf8w?=
 =?us-ascii?Q?ulkp9vPqSQtBIR2RmCdZpw9u8SC59vCo5LvjbgiVkkGBF+j6spTRYHSZd9Nh?=
 =?us-ascii?Q?pZ1Ilv67u5S4+AbIk6n/ZxMehnTCwCfi15fDLYGZiqhubqb+dKtpkpJTrFEK?=
 =?us-ascii?Q?j/C0U/B4VJ23Es2i38CSTOCazKBEwYnCitwoMgTj851KXaFKGjA0YSPyYaHQ?=
 =?us-ascii?Q?fFpKR5pA49nFbYiSDkapuVnpP62CgXSKZ4Oc5E41W+57Hmo2LPJFl+WwxsmN?=
 =?us-ascii?Q?Clm5Aq5QT6f1W8vxR8f/wroLy7KA7+L4VanpjMfl3NTZJGILT+LEPw55DLWY?=
 =?us-ascii?Q?h+76aFjjyLWBm42RuFMQbkVuI8J98p9MJTJKASAdJKjPoh8RP8CYzysoO1ME?=
 =?us-ascii?Q?b7qU0l55BHOrGuBJ0epPOuvtrRKnaC1HcaUwhhW29L+snEAg1cyN3VAh7OTO?=
 =?us-ascii?Q?Y99IMNzcZeceYBg5fDYuuvbrYSTPQ4dVGTO5Hs7sraEKjtFuGYAt91+5iwGL?=
 =?us-ascii?Q?hXk9i6ImilJRoGbNVDbWe4aSFet77ESy8EYs7qZekvxkuyoo3363CPYRwJjL?=
 =?us-ascii?Q?NwGMHjUWIM7BcMDSv/jeAWhsitoZy6VZ5l/Yg+Tt?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 749f7318-25f2-4770-31a5-08dc8baef5af
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 13:44:34.3853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbdahDWPP3qHtcQpGPAQ2joj877QYx+Iu/OKw+x3JehnSiAhxKQIXyghzoFVaK+J5NbjvBSTxqNlxoe1O/FJSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6573

On Wed, 12 Jun 2024 15:30:25 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> Provide two atomic types: AtomicI32 and AtomicI64 with the existing
> implemenation of C atomics. These atomics have the same semantics of the
> corresponding LKMM C atomics, and using one memory (ordering) model
> certainly reduces the reasoning difficulty and potential bugs from the
> interaction of two different memory models.
> 
> Also bump my role to the maintainer of ATOMIC INFRASTRUCTURE to reflect
> my responsiblity on these Rust APIs.
> 
> Note that `Atomic*::new()`s are implemented vi open coding on struct
> atomic*_t. This allows `new()` being a `const` function, so that it can
> be used in constant contexts.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  MAINTAINERS                       |    4 +-
>  arch/arm64/kernel/cpufeature.c    |    2 +
>  rust/kernel/sync.rs               |    1 +
>  rust/kernel/sync/atomic.rs        |   63 ++
>  rust/kernel/sync/atomic/impl.rs   | 1375 +++++++++++++++++++++++++++++
>  scripts/atomic/gen-atomics.sh     |    1 +
>  scripts/atomic/gen-rust-atomic.sh |  136 +++
>  7 files changed, 1581 insertions(+), 1 deletion(-)
>  create mode 100644 rust/kernel/sync/atomic.rs
>  create mode 100644 rust/kernel/sync/atomic/impl.rs
>  create mode 100755 scripts/atomic/gen-rust-atomic.sh
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6c90161c7bf..a8528d27b260 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3458,7 +3458,7 @@ F:	drivers/input/touchscreen/atmel_mxt_ts.c
>  ATOMIC INFRASTRUCTURE
>  M:	Will Deacon <will@kernel.org>
>  M:	Peter Zijlstra <peterz@infradead.org>
> -R:	Boqun Feng <boqun.feng@gmail.com>
> +M:	Boqun Feng <boqun.feng@gmail.com>
>  R:	Mark Rutland <mark.rutland@arm.com>
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
> @@ -3467,6 +3467,8 @@ F:	arch/*/include/asm/atomic*.h
>  F:	include/*/atomic*.h
>  F:	include/linux/refcount.h
>  F:	scripts/atomic/
> +F:	rust/kernel/sync/atomic.rs
> +F:	rust/kernel/sync/atomic/
>  
>  ATTO EXPRESSSAS SAS/SATA RAID SCSI DRIVER
>  M:	Bradley Grove <linuxdrivers@attotech.com>
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 48e7029f1054..99e6e2b2867f 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1601,6 +1601,8 @@ static bool
>  has_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
>  {
>  	u64 val = read_scoped_sysreg(entry, scope);
> +	if (entry->capability == ARM64_HAS_LSE_ATOMICS)
> +		return false;
>  	return feature_matches(val, entry);
>  }
>  
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 0ab20975a3b5..66ac3752ca71 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -8,6 +8,7 @@
>  use crate::types::Opaque;
>  
>  mod arc;
> +pub mod atomic;
>  mod condvar;
>  pub mod lock;
>  mod locked_by;
> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> new file mode 100644
> index 000000000000..b0f852cf1741
> --- /dev/null
> +++ b/rust/kernel/sync/atomic.rs
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Atomic primitives.
> +//!
> +//! These primitives have the same semantics as their C counterparts, for precise definitions of
> +//! the semantics, please refer to tools/memory-model. Note that Linux Kernel Memory (Consistency)
> +//! Model is the only model for Rust development in kernel right now, please avoid to use Rust's
> +//! own atomics.
> +
> +use crate::bindings::{atomic64_t, atomic_t};
> +use crate::types::Opaque;
> +
> +mod r#impl;
> +
> +/// Atomic 32bit signed integers.
> +pub struct AtomicI32(Opaque<atomic_t>);
> +
> +/// Atomic 64bit signed integers.
> +pub struct AtomicI64(Opaque<atomic64_t>);


Can we avoid two types and use a generic `Atomic<T>` and then implement
on `Atomic<i32>` and `Atomic<i64>` instead? Like the recent
generic NonZero in Rust standard library or the atomic crate
(https://docs.rs/atomic/).

I think this is better for ergonomics. The impl do need some extra
casting though.

Best,
Gary

