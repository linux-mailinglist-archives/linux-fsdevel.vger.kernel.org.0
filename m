Return-Path: <linux-fsdevel+bounces-29422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D6F979966
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 00:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984431C2251D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 22:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE32E823D1;
	Sun, 15 Sep 2024 22:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="HN6DnWsq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2111.outbound.protection.outlook.com [40.107.121.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E6B22334;
	Sun, 15 Sep 2024 22:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726439051; cv=fail; b=FuVioiM+kATO7aYPCQeC8yCOixTyM4JISFzoNkwP3Dr6ECEjOrCP/GZt7hIMCLBQSTnqeZbekT5aafxhVjweBc4PGncohGEpm1M5/XaxoY3pLrB1ytdy83UtWLEchlqKciiYxO5AN2BTdL1RHgSUWyVLp6j4Z1pHBuC+6KI2jmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726439051; c=relaxed/simple;
	bh=ayPI1RVbh4MSyztwvy7D2rmjHD2gjV6GZtKsXxBIEqE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hndwv47ZMU19cW4vdvEyYd/WanhquUdvWHZ6UoTwYF4kViUMzl6F177ImuKcOJQZxNxJZnSYxcndqoQUyqbRamBaJImpc4QUQ89gtLG2xJpYHjl8ZTOWzj3FgYVCGqF0INchzaQ4Mzs+vOyUjx9vRb3sTrEne7r92yNUXJu30cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=HN6DnWsq; arc=fail smtp.client-ip=40.107.121.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QuJf09ud56bwZlEjvRYIA7MbnLsp6fOT457lwlLcBc0ugkBPj835/d44Qx96mzjuHQDTCDtj82VYY/dDwrC1LcCblnhFcs0VnmK+LsdRmsNiV8pJI6fYCTzSVWoKBP9S7WD7KCZnW7/CnjxzJhHSLhtovO6zAfwd+Eh0puxpLbJlpVIU7EtXKPQs0fRw8QdpSE6Vx9b16cxwPGTKBw1wE6NID04a1DPcFg4Gp3ufDxw5qrEkMVIV9fCh8mPwZwdwhDlbSuCIMMHVZF2YfKaC2a7dkDzGUfF0d522nVFJbfV2SOqmVp3I1r1UOEoK1o1Ny0u0ZVDQwijBsQptxXoxnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWYlYwwPuwmJhs7lfkilMW1KBYCmLtozcbLZHYFtHks=;
 b=EbT/fV9jC/wnSFr85o+75/NmnEc/OKRGUieBkg0ZuBR/fcuk2emx3EHav14wMrweIbq5bFoCferXfAia2woralrD50kfFNUtNTGLmPQnhxyFreSmg8moep62/tmTCsriQ/vyWqE1k9PCohVUaTQkXM+DHn8Niv42uhoAvw2KmSnoa7f9WlGQd4981teRcR7oj3jgypcgfDrxBRN2RhR57Ijw43lN6DWyOKuHoJXid6ZRhYiHB4i+lXxnK0UB0Q8SCjoXfVIoOIc9rd8rdBFBY/aL0ErRd43gF6Gzziaici1Zx1hYYVU+Fr62ndy+AsKjDwRSCfp3WCumcAtqMpZN5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWYlYwwPuwmJhs7lfkilMW1KBYCmLtozcbLZHYFtHks=;
 b=HN6DnWsqPjXlgBAKPjpjz7WMyFk1rCyWoAFm7X27FSKbxhrmtg5UP8LVoIX41SXuvigG5He+7traRMgjEb2XIl6l+YKV5bkvIkxI510j78czfyeaRJFAtj0Qn77W/smvnPO2jkfnZik4IxhWv+YJJcYN0Vgx7DSvcs3p9Qubasc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB6522.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Sun, 15 Sep
 2024 22:24:05 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.7962.022; Sun, 15 Sep 2024
 22:24:05 +0000
Date: Sun, 15 Sep 2024 23:24:03 +0100
From: Gary Guo <gary@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, "=?UTF-8?B?QmrDtnJu?= Roy Baron"
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Arve =?UTF-8?B?SGrDuG5uZXbDpWc=?="
 <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen
 <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas
 <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Dan Williams
 <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, Martin Rodriguez
 Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, Kees Cook
 <kees@kernel.org>
Subject: Re: [PATCH v10 8/8] rust: file: add abstraction for `poll_table`
Message-ID: <20240915232403.58466ba7.gary@garyguo.net>
In-Reply-To: <20240915-alice-file-v10-8-88484f7a3dcf@google.com>
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
	<20240915-alice-file-v10-8-88484f7a3dcf@google.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::14) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: 00718578-d408-4dd6-c108-08dcd5d51c0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RiIDKPQnRAfayseht/B4HtFUcAHbj7UyqqgVg1963YN9fb59ADMpViwMuNrd?=
 =?us-ascii?Q?RAqJbcasSc7D8E4ON5m5k+0fSpBhsKRDNCK/o85Pexi08ZqWjJmJRbV7PJW9?=
 =?us-ascii?Q?P2NDeNkMlnO/waTMoHlX/396H7jNk9fnm07gEeMkDgRajZtXRBhFZYfXKNki?=
 =?us-ascii?Q?1KzJuEoO/xkH3rOenzYd+dzpdtBrz1SG4DkQcGUkwT4n7kxDCYo7fe9zh7Mu?=
 =?us-ascii?Q?34ILe1NVJxFTHaLQ742JUnueqxa5gYLJ019ZD6jxkxpj0gPQ+jBB/QFwsXRG?=
 =?us-ascii?Q?IYHEMCZpfUQKUPBDF3Vm0GrKe+37hnOIJgM91DaOKLsTfp9FIvZfMvPIwAdW?=
 =?us-ascii?Q?SeKknmx19RWqFfc8I3pNY4Z2Lze+plAEV/3ZP+MtyA1TaLjHZ2lZ3pLRZ4Hv?=
 =?us-ascii?Q?b1nf6RlvWO30qTgU7XsU+fL0WlX796Uu3c05m9lQ6q0rdsGwgLScND/KY6Ao?=
 =?us-ascii?Q?R50rhYtfqaAhpfXK4cFXlEOrjBkY899W/sg9ojCqoErCLrpD5bAdXzCRX1+b?=
 =?us-ascii?Q?3iQHsUtdtzrwf7lVEjy3mI4tNJwqmzHXSvu6TRrt9ufhJJk7r5U6YYYPHG6D?=
 =?us-ascii?Q?mTkpYZeqzvqPPBftaNCdW2lUPJs/A34dI0kFeun9McoTH5rFcP3zIDbaOTE6?=
 =?us-ascii?Q?+y9a+lHfw5O+BQVQuCYw0L1kvdwRgri4FylBNDEWyqRmNvaduUt2cbn74Hjz?=
 =?us-ascii?Q?aDXr5Ma6y/xDiJhmEbFydLwJGKZ62TMzdijBaJSC8tZqE6b+VoYx4IUM10IM?=
 =?us-ascii?Q?s47mOYK3eapBeyhsPhiChLVY4uy7Q9IvxhJJimVRM1ENebq1aLLe5UNu4XAa?=
 =?us-ascii?Q?6HMtc8/2dkTz04W0wHlf2F+pVktwFqUGvKRr5DmiymwN+F8SVrVUg3ARZVrT?=
 =?us-ascii?Q?rYAiksgb9qtqwW6FuME89bX4VcSE6lt3K1dWVaZbIMjZbowL7nFSHOxyK59m?=
 =?us-ascii?Q?imhaD4Gq67TvsVTg9nub9ZvDO+pzCgf+fSR/SCjUtmoeTiIFbRFEZfaX5AJn?=
 =?us-ascii?Q?zPrgfTcmm85PRCwM1M3ROjrDJr++8FBebsx7QiRjmMYFUG0Ptuqq6dKAiMfC?=
 =?us-ascii?Q?R5OeXNDCybZrNS8a/MikBh7f5SBjwQJbMmUT7WJOtxUKXsuPzq7zSoe9eLlg?=
 =?us-ascii?Q?+3NHLX3W+2AT9mfXz8gYJRCeFRieO8pgU1vtuu4gEnUrglT8WJ5aUXxHNo2c?=
 =?us-ascii?Q?Fz+WGkyDJPw3OJlntZWtTym1c2ADsFr4ppUZ9jJGGzdi97z0KgEDZuwIbLs0?=
 =?us-ascii?Q?z6nyNWQ0lCmsuG/hfKrTYU8IDSnjsQRav73HORqWsSc9Fh8CKq3ZWxt5/zC3?=
 =?us-ascii?Q?RjFlYVDg56jAZHAveR7UyHz7LYWrv+rErCHgm/TV0OhfNQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9q0SNTsLhnPCYlZuoptmhAWZBdVK8WzmnSIE9bgH8jos/fJpz+bR6xNd34zu?=
 =?us-ascii?Q?jELCEObSqVKOCXkYD2nUvXCRFhcexmu0Q3cktOo6U6WUjBY3Y65PsDKXjjEZ?=
 =?us-ascii?Q?DAK2qA7vORC8T034zncqdnuii5XeCfY1T+9DaUuWkpkzYSY9yieZvRa6FP/T?=
 =?us-ascii?Q?r9hK/RCsc9YgBvkzkh0G9sUrzlu1pjmpmmWIujKSNC1Yk3cIEPJJABdwGQC1?=
 =?us-ascii?Q?pNkzWlaln5Nj6VIOyXg6hNNKD1dYR725EUfdF2JsfH7bhR6l03jqlJJCkxn9?=
 =?us-ascii?Q?nbDYUPA0B0GQt/kEh0atjXq57n2yfJHW20QnsUqhCwILL+jsrUB5DGX8S6CG?=
 =?us-ascii?Q?J0jq+/54STvjuvGIHnt2queEN89op8yeuuHIheG9Ldem2WnqeJkExamgnIn+?=
 =?us-ascii?Q?F9Lg6zPGUOQ4ksTlwRf3oFxQbNxniumRHekfGCy1ui/5IzHJ24H08HrToFQl?=
 =?us-ascii?Q?P85oBHKObuVkE6TqaO9m1+HQKPGV123UZ5UdCzp5QA+7Vv+ekOiOcHjLZTBr?=
 =?us-ascii?Q?3f4Yf+cKDOKYQuhXCdc5wiimh5tKUOqnQVUq9zXfYv6e9uuG7NwvfH02vxlZ?=
 =?us-ascii?Q?2G/FMjoowhJyplJFQh//fAroyc1uXG7mnQKybeYBCfItzeP2HZyZ6zXyHrmS?=
 =?us-ascii?Q?GlDDDhnxtxakrSJHX6j4gGuIIsL0SVSr0PUrDS//kaGaTE/OkMsvK81eojUQ?=
 =?us-ascii?Q?yKWpWpdP0b3yYXIr2D4UXO49aS5GCe3keqdi5wAVVpqaMdBhLZ9eUlb+vk1j?=
 =?us-ascii?Q?Jlnuvq20HxSeVBrQ5CexgnVVAknt8UrutIHLDq+VUiaqKzgYogce1SbxAMu+?=
 =?us-ascii?Q?dNLsgNFEeAVuGWODoIQbNFG6HZDktRm9bW/QiBaismcZ7Lhr9Pn3V/+Y+QBY?=
 =?us-ascii?Q?iK0ivXvCJraP7pp9YuDIo7JiOd9BrdPfKLENgtz3brFfFRktWR9M7rsMvox/?=
 =?us-ascii?Q?R3W1XaKOid9xywz/TJIbMCSbi5ygI/wdwYIQ1wXXPf6zpOUoXDw0DPyblwrw?=
 =?us-ascii?Q?MNfS+0/6+VuONjTr8LFBNOvdVOHiFF/uvNh8jb8yux6j/KGtWG3kNMpO1g6w?=
 =?us-ascii?Q?fWxaLWuxmWo6Z5qP7AyVnIEVPH0U8LmsqZFX5fUw6vQiYyRMwaCJ3Ac5TNLJ?=
 =?us-ascii?Q?OFVhn67zDFdbTaotPry/6uRql5m1LQVCleDI45u3hJ7kSICMmdJhHbuOeDzE?=
 =?us-ascii?Q?d4GeUp6/aOemC51MiD2JcK2DsZ6aRg2MRUMJgursD5atRvl3w7zc9oPB1yt0?=
 =?us-ascii?Q?Tb2hOHrHaywPe0VDXa7EecpwSvEjTmfwFsTHO9+cUg0txW+9m+IG3JH+bVS3?=
 =?us-ascii?Q?rQ9z7EAGGkgac27e2M2zeHwe1TGWIdmUvn+6c8oqXFY8Xg44zIHuNwTnvKEx?=
 =?us-ascii?Q?rWpYTU+o4wILu9Ty7mliILrLDVkCjXObdw9amIdoDT+S/1UwPoBvma+47lpE?=
 =?us-ascii?Q?Pn3Ybw+lOeKaYsbEmeINiLJWxwgSXxXUK6tARSYO/0nffWgxH5BYoLeN/T1K?=
 =?us-ascii?Q?NNLV/yzduYTiy0+uyHf7zVaa17bhy7QrWI/BK3/9Opbv5w3o3oPUcDrVWuTB?=
 =?us-ascii?Q?80NJmWVVVgEI5bi+rlhDdWEoGfg5xuo80v2s6JNEJyo2l9jCwN50OSF4NxUA?=
 =?us-ascii?Q?2w=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 00718578-d408-4dd6-c108-08dcd5d51c0a
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2024 22:24:05.6959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/6805fy7lXYKm9dG7oD+FC30r40Dey7Jp+EkmLg4SgoxhMjOpx2jAMbig1p1RFRlu6IUClq4sDp9/yfVHlklw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6522

On Sun, 15 Sep 2024 14:31:34 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> The existing `CondVar` abstraction is a wrapper around
> `wait_queue_head`, but it does not support all use-cases of the C
> `wait_queue_head` type. To be specific, a `CondVar` cannot be registered
> with a `struct poll_table`. This limitation has the advantage that you
> do not need to call `synchronize_rcu` when destroying a `CondVar`.
> 
> However, we need the ability to register a `poll_table` with a
> `wait_queue_head` in Rust Binder. To enable this, introduce a type
> called `PollCondVar`, which is like `CondVar` except that you can
> register a `poll_table`. We also introduce `PollTable`, which is a safe
> wrapper around `poll_table` that is intended to be used with
> `PollCondVar`.
> 
> The destructor of `PollCondVar` unconditionally calls `synchronize_rcu`
> to ensure that the removal of epoll waiters has fully completed before
> the `wait_queue_head` is destroyed.
> 
> That said, `synchronize_rcu` is rather expensive and is not needed in
> all cases: If we have never registered a `poll_table` with the
> `wait_queue_head`, then we don't need to call `synchronize_rcu`. (And
> this is a common case in Binder - not all processes use Binder with
> epoll.) The current implementation does not account for this, but if we
> find that it is necessary to improve this, a future patch could store a
> boolean next to the `wait_queue_head` to keep track of whether a
> `poll_table` has ever been registered.
> 
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/bindings/bindings_helper.h |   1 +
>  rust/kernel/sync.rs             |   1 +
>  rust/kernel/sync/poll.rs        | 121 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 123 insertions(+)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index e854ccddecee..ca13659ded4c 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -20,6 +20,7 @@
>  #include <linux/mdio.h>
>  #include <linux/phy.h>
>  #include <linux/pid_namespace.h>
> +#include <linux/poll.h>
>  #include <linux/refcount.h>
>  #include <linux/sched.h>
>  #include <linux/security.h>
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 0ab20975a3b5..bae4a5179c72 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -11,6 +11,7 @@
>  mod condvar;
>  pub mod lock;
>  mod locked_by;
> +pub mod poll;
>  
>  pub use arc::{Arc, ArcBorrow, UniqueArc};
>  pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
> diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs
> new file mode 100644
> index 000000000000..d5f17153b424
> --- /dev/null
> +++ b/rust/kernel/sync/poll.rs
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Utilities for working with `struct poll_table`.
> +
> +use crate::{
> +    bindings,
> +    fs::File,
> +    prelude::*,
> +    sync::{CondVar, LockClassKey},
> +    types::Opaque,
> +};
> +use core::ops::Deref;
> +
> +/// Creates a [`PollCondVar`] initialiser with the given name and a newly-created lock class.
> +#[macro_export]
> +macro_rules! new_poll_condvar {
> +    ($($name:literal)?) => {
> +        $crate::sync::poll::PollCondVar::new(
> +            $crate::optional_name!($($name)?), $crate::static_lock_class!()
> +        )
> +    };
> +}
> +
> +/// Wraps the kernel's `struct poll_table`.
> +///
> +/// # Invariants
> +///
> +/// This struct contains a valid `struct poll_table`.
> +///
> +/// For a `struct poll_table` to be valid, its `_qproc` function must follow the safety
> +/// requirements of `_qproc` functions:
> +///
> +/// * The `_qproc` function is given permission to enqueue a waiter to the provided `poll_table`
> +///   during the call. Once the waiter is removed and an rcu grace period has passed, it must no
> +///   longer access the `wait_queue_head`.
> +#[repr(transparent)]
> +pub struct PollTable(Opaque<bindings::poll_table>);
> +
> +impl PollTable {
> +    /// Creates a reference to a [`PollTable`] from a valid pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that for the duration of 'a, the pointer will point at a valid poll
> +    /// table (as defined in the type invariants).
> +    ///
> +    /// The caller must also ensure that the `poll_table` is only accessed via the returned
> +    /// reference for the duration of 'a.
> +    pub unsafe fn from_ptr<'a>(ptr: *mut bindings::poll_table) -> &'a mut PollTable {
> +        // SAFETY: The safety requirements guarantee the validity of the dereference, while the
> +        // `PollTable` type being transparent makes the cast ok.
> +        unsafe { &mut *ptr.cast() }
> +    }
> +
> +    fn get_qproc(&self) -> bindings::poll_queue_proc {
> +        let ptr = self.0.get();
> +        // SAFETY: The `ptr` is valid because it originates from a reference, and the `_qproc`
> +        // field is not modified concurrently with this call since we have an immutable reference.
> +        unsafe { (*ptr)._qproc }
> +    }
> +
> +    /// Register this [`PollTable`] with the provided [`PollCondVar`], so that it can be notified
> +    /// using the condition variable.
> +    pub fn register_wait(&mut self, file: &File, cv: &PollCondVar) {
> +        if let Some(qproc) = self.get_qproc() {
> +            // SAFETY: The pointers to `file` and `self` need to be valid for the duration of this
> +            // call to `qproc`, which they are because they are references.
> +            //
> +            // The `cv.wait_queue_head` pointer must be valid until an rcu grace period after the
> +            // waiter is removed. The `PollCondVar` is pinned, so before `cv.wait_queue_head` can
> +            // be destroyed, the destructor must run. That destructor first removes all waiters,
> +            // and then waits for an rcu grace period. Therefore, `cv.wait_queue_head` is valid for
> +            // long enough.
> +            unsafe { qproc(file.as_ptr() as _, cv.wait_queue_head.get(), self.0.get()) };
> +        }

Should this be calling `poll_wait` instead?

> +    }
> +}
> +
> +/// A wrapper around [`CondVar`] that makes it usable with [`PollTable`].
> +///
> +/// [`CondVar`]: crate::sync::CondVar
> +#[pin_data(PinnedDrop)]
> +pub struct PollCondVar {
> +    #[pin]
> +    inner: CondVar,
> +}
> +
> +impl PollCondVar {
> +    /// Constructs a new condvar initialiser.
> +    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
> +        pin_init!(Self {
> +            inner <- CondVar::new(name, key),
> +        })
> +    }
> +}
> +
> +// Make the `CondVar` methods callable on `PollCondVar`.
> +impl Deref for PollCondVar {
> +    type Target = CondVar;
> +
> +    fn deref(&self) -> &CondVar {
> +        &self.inner
> +    }
> +}
> +
> +#[pinned_drop]
> +impl PinnedDrop for PollCondVar {
> +    fn drop(self: Pin<&mut Self>) {
> +        // Clear anything registered using `register_wait`.
> +        //
> +        // SAFETY: The pointer points at a valid `wait_queue_head`.
> +        unsafe { bindings::__wake_up_pollfree(self.inner.wait_queue_head.get()) };

Should this use `wake_up_pollfree` (without the leading __)?

> +
> +        // Wait for epoll items to be properly removed.
> +        //
> +        // SAFETY: Just an FFI call.
> +        unsafe { bindings::synchronize_rcu() };
> +    }
> +}
> 


