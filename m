Return-Path: <linux-fsdevel+bounces-25319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D075494AABD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 16:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C991C2143A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 14:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF14F81751;
	Wed,  7 Aug 2024 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="QqhtLcrD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021123.outbound.protection.outlook.com [52.101.95.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6924F78C93;
	Wed,  7 Aug 2024 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723042442; cv=fail; b=WaCd9C5OzIvQdTWKpUDunAOp6IoinYvfdgGhw4TPIUx8w6qkE3bmB3JrY5HWjY8iocFuzc9AtxtHlnaIsBAL3YhUyvF8lvqba+Azv9pBSQCoe22cjvoXBcEh7zliXVBplTzNwwWV6Rgx0vwzJiFsmrOGgHiV+cQp1xPfzGv8sNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723042442; c=relaxed/simple;
	bh=86unjrctUEz1E/qds5DgJjoaU1rSkJqAmU/R18QTEhg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UnrnQx5upjui1ngtdrYY4Q1VmmqbzRh/5AtuUEv96MbKAH+4f5JW0rxlPvu1DZyKXy3wO6biqAXciTA2lbXV5reetOY/y9jkb6LcH7NqXuSBhVPV+VysdCpnS0iloZfqTH+2ADdbTERPwyWS4WEgaNWiCmWiBNAVqbBnZ87bjLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=QqhtLcrD; arc=fail smtp.client-ip=52.101.95.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0Ug7FNcMHERQ+B4b8eaURiEwQq54D5yFLkBIRaAPgm0/WFn2+lfOhB2bqbC0zMXEbIzA20pl3gU7+g0TxdzfG1m8Wx7a8nNWud8CxiGm0vQF5cjfrmuwPcKz6WWxLbzpPHXqH+mk25Zxql2Q6OlLTQBrq2zXt7jYs7D5Kf1GcOVNvbzRu771XP6OZmZLhNw2qAbBoiGLo134ZrZgnpUcVL/NZXiKM4yAJd8X0sfharx6o3a4h2CBEC33jWBxBxylUUweiD+TKwJ5zV6vDg548ahbFcedfzyhBEOXrF2rdisR+4px7zULGAqnR6lWRFSb8edoxwWhepBg/ZzfLyv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEEpAB3fUu995yJIZKyYwg+7oEMjEzrZAGQXQblkeNo=;
 b=KnJTjbJyzSOXP4imNzUOIVQYj1O/AXg+tuU2NN9IRy5amgcJpq6NBbr3ZlHUkmWa0I5W4SRqC4RXJP3PI3zDQgSIKKmt0UhcetMqvewX43EmY/qos3YEt+Ko10m1KMMkRemUe6Xgb4yyrgL3iANqa0XHNMjJbOBclFbQYjQmSyCwymd6smkSk9kx1nuYQTCzTjyLT0gpoQsGQqJ2O8ngZk10Ytx4CCHZ+n/45yLiu/fp1cX3MYbu7vKfbyBKzrWJ1d5QRYS5XNixxrveHc4rjj+81RFninZ6a3Zf3sgmrQYfPjXddfhPrvpZSeW83v9Y1gIMpfHXBkXc2142d30NnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEEpAB3fUu995yJIZKyYwg+7oEMjEzrZAGQXQblkeNo=;
 b=QqhtLcrDVMQCNQjWviMuOVPg9XzJtb9A4Z1o7V+I8mYHRrrcnVvwuXEh0PhxGRbAy7XmijjGh3zqf+UahrYqXHxOkauEURRIvdtfJ3jEvB13G3wetDa5DlNXQ9XTIXLctwcoPBVbNtvM5Gugdo/mYq8ZJBKs58a4TYSPWsrY2ug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB3452.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:16f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 14:53:56 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%7]) with mapi id 15.20.7849.008; Wed, 7 Aug 2024
 14:53:55 +0000
Date: Wed, 7 Aug 2024 15:53:51 +0100
From: Gary Guo <gary@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, "=?UTF-8?B?QmrDtnJu?= Roy Baron"
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Arve =?UTF-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos
 <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes
 <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren
 Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Daniel Xu <dxu@dxuuu.xyz>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
 Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, Kees Cook
 <kees@kernel.org>
Subject: Re: [PATCH v8 4/8] rust: cred: add Rust abstraction for `struct
 cred`
Message-ID: <20240807155351.49bf39ad@eugeo>
In-Reply-To: <20240725-alice-file-v8-4-55a2e80deaa8@google.com>
References: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
	<20240725-alice-file-v8-4-55a2e80deaa8@google.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0497.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::16) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB3452:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6dda6d-7f02-46b2-8e2d-08dcb6f0c298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nfegnDs1P/A6hLqyWWzwIuY3rcyknQ+89oMBE+quvX3UFS2W9D++DQWF06ev?=
 =?us-ascii?Q?OSKbc+hjpZtH5Wg3QY/q1tcmyjPZYw+uxfiZ1zZ/1S+ZT5SEo0qpRzjOzZs2?=
 =?us-ascii?Q?BTDvQeEoYgI0IoMWIEuaIhg3LrxpqW5tB5VoET3pXaSJq/uwcmPd/Xg1vbFC?=
 =?us-ascii?Q?9mXTmM7L7WiCXYrnLr2Pyi/Vf887i4GvhDu5yjVhRNKi1lMToi357q3MecEK?=
 =?us-ascii?Q?6H3SYPdaaeNhHqNWnQXM/NUha7YGDurvef4dDEVHj6sseIGhH5Q6XKMzdhFV?=
 =?us-ascii?Q?tjn8tbY0mRlpdVqoDh3c95TusN3+cQqakPpliWw7rCubjvYl67SJvQh9iOKx?=
 =?us-ascii?Q?XcFvL7GvmbG6Op8idxczaCEgld22ssO75uPGpyU44J7ZPeFmJWWhTl1zLtCp?=
 =?us-ascii?Q?T4HZfT3fPpCEjacCtzMleNeYcI8sVmA08OjBlYwcJNS4hU7+cpQ49nXuNYf9?=
 =?us-ascii?Q?Uut8VL20Do4DdWRYW7pjK6eGtlycmh2jW+wnIRrcFAnMWPMMZUoO14Yyyt6O?=
 =?us-ascii?Q?fl4JsYSu7ZTB2XOqyKNPKxPcWrzabb+LNXWRE6N0xI/BdCuOgrQ/SunYVDbq?=
 =?us-ascii?Q?YpnY8RupjjWi0z33NNTVe8chtK4Dk1wKUx3zX43D9pUWv4DBzVbS1bciZiTp?=
 =?us-ascii?Q?9U1yEenKleM8IZOjvLPMrx0U1wkTP5nGywndiln8p1Y1TwKZZGBK2WmDkGuZ?=
 =?us-ascii?Q?uDsH2p5qhKx1c1fnfd1Z746fF8LULCEKiyfsxJpLiB7aNRfgwpkxC3Pg90su?=
 =?us-ascii?Q?iAcH8dsb6ckqUzyJai9zMIEX2s2Iz16BMSd0cKtPVI/wg4z6ohkNA9Yfp0kx?=
 =?us-ascii?Q?+nqufFrEl/HsOCEwhnMhThiWy0SMwbJAENKjHncbSeDSrAewYvJFnNhEvqrW?=
 =?us-ascii?Q?CdFwW+u9luZdphA3CXtgQM+SUpNAc9luYXlCGyMHD0aa5Zr+lfE/iL34YWjs?=
 =?us-ascii?Q?EL+9XnJ6PbD09IPTCnEZ0zwzbPjth/ollm6SIvr7UqvlNSC5GG6xoe9OfqxI?=
 =?us-ascii?Q?TTkKE259W+IueM6KxavcHhwjRfinfcBu1EVw9XoMc23ebgGB3jMXuL/1way8?=
 =?us-ascii?Q?cAQQsJr2DD6X3q3AFx0WIKnxR0uIPQT53cgx+sKSrRk6MKs7ga7zRYKFdvkP?=
 =?us-ascii?Q?8MVY2eOk25VXqA2e34rvFwaQ6/pZ4T+Lkp6OZzYFFCLohy0RajfSdIEJ0lA2?=
 =?us-ascii?Q?Df1C4CfWpaP4O1/nvW5MW1537cczKd2uJ4Ih1H0V5khwckf70V0UEoJNj4LP?=
 =?us-ascii?Q?L+1PN2mIHJ6E6y42fpHTWpyGI0K/gd3y3mXRE7Ot8t30hO+gMe5FHKeBfnvg?=
 =?us-ascii?Q?V6CzujaxiRG0j3guoh1MmDQ/6+lFhwk1xVML5xnbdATnnQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mLQc+gs582eNFvxHV+DB2NY3AFddK6trk2HMSw/nIc0cdJOvLDdHDEvO3EVI?=
 =?us-ascii?Q?M205UILwb3/0/pcAoUxuMwnb1s+LIXbyHEYC393RY7HZfimIfbMM+d14INkl?=
 =?us-ascii?Q?GAdQ8JY8xpb9wk176QpXXeQ6uf3/rb3I9r2nYLO50Zp0ACQjdeaqg6dcwpU2?=
 =?us-ascii?Q?ekAaeh7kV8jpS69ld2eW3SnW08RayQLkKvAQGT+sJOwHAzJbthjikdp79Kty?=
 =?us-ascii?Q?667vrUbqBHeSaOfdimMTvwqYXUUZeHUpIPW2EswMJN/t3edB0OH0Ukv6guCm?=
 =?us-ascii?Q?55QpiF2oVgwt2XvAFwPvS0H2jw+EBe+LUv3jAnTgPEPL2C51EnOBMaCkFXlU?=
 =?us-ascii?Q?5BwuqNuY+QhstliHnA5ExDQCDYsfcZ/HFE/PyfoPJU0QVczdZSTnty2JF/0a?=
 =?us-ascii?Q?U2Sf32shIBN7EAgyLvwOS4l6ucQiUVr7vjzG3wBYCHcSvgi41SJ3tUNMUfb3?=
 =?us-ascii?Q?SSZjjabYHzf9P/axa3C+anJ/msoNHedXVkYRjZanPlBa2nNa+c+Yop0fC7Am?=
 =?us-ascii?Q?6PzHi1kqisixjTt8sBA7D2xUBGRND46ELJEOKHSiRDjdPvyuIk4okXeTLeKh?=
 =?us-ascii?Q?ykmsePSs/y/6ikzL4sA1TVRsPd97FF+MN1X3/nQQb/dvFBZQePj9jLmk9lXh?=
 =?us-ascii?Q?OLi3hQi/W6UV2ZYHHow4zdW5dZmLj05o3DQpsfuDLWE2/d7VLNx/2OdMdZ7N?=
 =?us-ascii?Q?thb4rZ8AkrkO3kt7TiWMGkaoNrS4MsH6CYJ4yMD8UgV3Dor9MoXnEBetcfzl?=
 =?us-ascii?Q?JPcHwfp2cqUrh8+z+Occ05KGEAnhYBxvCB4pyPWwDenuKDOVlaz39wCCXhT4?=
 =?us-ascii?Q?D46mps+WkrGwyvoZKhEE494n0PZTKov7s53+46JvPGSzbc6NoEwHhJtMj+2o?=
 =?us-ascii?Q?3/f7t4J5VwXZPHtfsvrG/Dq3bOKtV9sl0XWQOQhgD9Msb0+rxFCYdP44mYkZ?=
 =?us-ascii?Q?eQW+i9t2FHdhcU7M28OvwBX5MIhpEKi6Zti0GVtQPM532FT526dMFMi/iGoL?=
 =?us-ascii?Q?7xgE/VUPM0R2DRnPmXlvBI33Ulc2jJKUF+gvfBuLrnUIE4iSyG9iGY9ZICgW?=
 =?us-ascii?Q?QduYB7+HH9jr/tt2RnRkwSTyWZTMhu2ciq1SyD3IgO0FJk1/OqJ1n7JCgOEF?=
 =?us-ascii?Q?YLv6RL/HjLKrnAODuPL2+siVz2PriVx4rIOSEXeGfzMP1e57q2lafMeKVh/X?=
 =?us-ascii?Q?M1LXPe8CSZpl3vwDVmb3vOZagtZI2sAGHKG2JAtjl9Ms5nbvrahAqYg7qq74?=
 =?us-ascii?Q?S/VwMJMQNTL2LfohJlobNasxfBFdLXmEN8EA8YX+qxaQ/lwPV5TCxRbBHB4i?=
 =?us-ascii?Q?MMsezCGTGGm3hNlZtVGE6hCBavetoXv6Hhwy/CorFNnS/rbkhRinOhXxcc3Z?=
 =?us-ascii?Q?bkJ2/oEDp8HipPZyc2tc5EnfU3Z4qsypi7g5+XpeynOGASpc1v2aaGHpjhXe?=
 =?us-ascii?Q?hNk0m8eTqb7qHBDmFVYUM9upVM3bW8obvwKO6uW67bFBqZTImkruNV/xXjlt?=
 =?us-ascii?Q?PNBsl2quD3yj/AugO1tP3xxLw7KM5cIzRGDPx1V8/XIPn/RFmhk+ouN+pVrI?=
 =?us-ascii?Q?/+bZ2bB/0r2BiO4+Jai9vQcU6w23B4SNm3hoBVLs?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6dda6d-7f02-46b2-8e2d-08dcb6f0c298
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 14:53:55.7146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfzWuawjthzKv8s6uSX8mup4IUYVP4N7QD9v+EOtEuONaWbVIPgjRk9nY8341Okh21gUFwO1TS9JMdmsn5hyxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB3452

On Thu, 25 Jul 2024 14:27:37 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> Add a wrapper around `struct cred` called `Credential`, and provide
> functionality to get the `Credential` associated with a `File`.
> 
> Rust Binder must check the credentials of processes when they attempt to
> perform various operations, and these checks usually take a
> `&Credential` as parameter. The security_binder_set_context_mgr function
> would be one example. This patch is necessary to access these security_*
> methods from Rust.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/bindings/bindings_helper.h |  1 +
>  rust/helpers.c                  | 13 +++++++
>  rust/kernel/cred.rs             | 76 +++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/fs/file.rs          | 13 +++++++
>  rust/kernel/lib.rs              |  1 +
>  5 files changed, 104 insertions(+)



