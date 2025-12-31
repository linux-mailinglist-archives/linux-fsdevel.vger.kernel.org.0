Return-Path: <linux-fsdevel+bounces-72293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 50958CEC279
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 16:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0987300EA6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 15:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4A7286D5E;
	Wed, 31 Dec 2025 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="rv7LIqsk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022075.outbound.protection.outlook.com [52.101.101.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C22238C08;
	Wed, 31 Dec 2025 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767193944; cv=fail; b=AEzU3xPogjVR+TfUeDwCvDqo+rrVe7N+oPxqZMIsKRRWDosQyO6SxTp5kf6aLEkoVdQwVTT5OTR9se7B645gbhlxfyJXT1FImUI7MhGgAko4//EaX9EH0BO1ZNDjEVVZr8+CZivUSrwdI4WrGTLETQAl3Li7In3aXdZK+q2iS6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767193944; c=relaxed/simple;
	bh=mJ6BsoDWQ0R6B1377tuvCP2zr+5fYKfwY3EmDvPaQnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oh3yCDzTDn9hy4ZpKYUEQqUVnTpfVC0mYBuEOmB6+8tfQCcvdEtT5+f3r8A/rDNMnl1EHmcm8M4BpKpftg35/5AO514XVCO455HBz0I2+1+2s7SlSMjEhOlvKUC6Syw+/NFZIX++mCpTGtA317KpbYfbvZUmzrfYnAcm67shjXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=rv7LIqsk; arc=fail smtp.client-ip=52.101.101.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxvJIIhiXNK/d8wGePYmVesXy9/cSbT6kzTpQy7IniPsnv2nXxDRHAHcMYp8DxCmZg+70OcIN9akOWN3SIj6Vqa0HrlXlVF4UMTonsBLnp+srb/qkqXjRCD98Xkbw8oSCcZKauF6OYjrzyCt7MueHZKsTCyPUQahiM7RWjlCsci7jc9Oxx6CFAi299NHNhYdGteXH42qhhNmNiJOp6WXM7KwHdydQYq8+ydltxh4rhWyOet38p5ZW31xCEktb4KuqaFEo0emvziZfFORLKTjRm6NltOflACj1J51MI0GLiesjpFn0qGCC8NDwmmBNJmlKHCw3uK+XePPBnmrYjqNag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKa1ocCcJCzmP2kzbvY6dlNVGz95SHgd+5IWO8UDlwg=;
 b=MLVKPCrWEuaNqrb64pXV3Nur3szpxTG4sm6LkRJiOREYJ6S0ufjgALzpLR9St/lefOnzvHuPhL+Uz+NkMvOCWVcKZuMvU1Qyo9J0h9us/2Vlf8mvbjWThysOs/yI024n69nJBFKernXSR3AGQZriz/KODmrXd5uss8gEizMPEmMmSd312bz1qFGpKrMkOORRc8Htf8D32hx031LfrhPOdTb96aXXPxMdB0ljY29HdFneMB0WW0W+JCqGB0VW/m3FKlRg81flZ9L7rzhR5KXwirSBCBaIZCSAo9wfak6WGorKA8oRp6UnQbSr3F/ac2W9SS9cLHE/u5EHpLXJ5dcoYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKa1ocCcJCzmP2kzbvY6dlNVGz95SHgd+5IWO8UDlwg=;
 b=rv7LIqsk8u9HP+YPDMKIpmiGuYYMv4yFGJnUhGveTJTsIcbJtOhxxojjtU/6GEJnSQ1Af5P8YC1SrtmKzXl1lMbSM3KSfo8rayssaA+5FmuSh+YRvba8goYhLrRNIAWmrqWc2fjpOvS77BV7ExtBmwEV7Mm5cqJ++PN0Bt31WoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB3281.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 15:12:19 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ea6a:3ec2:375d:1ce0]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ea6a:3ec2:375d:1ce0%7]) with mapi id 15.20.9478.004; Wed, 31 Dec 2025
 15:12:19 +0000
Date: Wed, 31 Dec 2025 15:12:16 +0000
From: Gary Guo <gary@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Will Deacon <will@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Richard Henderson
 <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, Magnus
 Lindholm <linmag7@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Miguel Ojeda <ojeda@kernel.org>, "=?UTF-8?B?QmrDtnJu?= Roy Baron"
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Mark Rutland <mark.rutland@arm.com>, FUJITA
 Tomonori <fujita.tomonori@gmail.com>, Frederic Weisbecker
 <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>, Anna-Maria Behnsen <anna-maria@linutronix.de>, John
 Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] Add READ_ONCE and WRITE_ONCE to Rust
Message-ID: <20251231151216.23446b64.gary@garyguo.net>
In-Reply-To: <20251231-rwonce-v1-0-702a10b85278@google.com>
References: <20251231-rwonce-v1-0-702a10b85278@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0153.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::21) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB3281:EE_
X-MS-Office365-Filtering-Correlation-Id: fad67b81-b424-46d9-aa1b-08de487efd96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+TZN/YEGXbRwYU1JkQS2Ed4BzIeedCVNPoPwqMWqc4Lf0bBp75zv3pA3cMhi?=
 =?us-ascii?Q?bCh+G7AgYdRoIMprgmau2qHGsVzNNM1/mxvhK6bIx1A1wFiRhGWj9dX3DAU4?=
 =?us-ascii?Q?1KtHSLohKUzRYtIahLU1/PIMXE8OsjSX5w2hb4nVd7NACB+AdJIojNK2HzXQ?=
 =?us-ascii?Q?h8S9Bu8gRoi5SZv9xOImK2+WoRGmJxjYwiiixgnbsUsdrGkbY+tVkl0XB73j?=
 =?us-ascii?Q?y4QC1Sg7f6astYqOWEETs855TaKYZYpmg8HGghZdKuzWKcH9//Sc4JJOKs8v?=
 =?us-ascii?Q?v9ZDvDH8wTq3sBmYrDxW6c0dt+evKO5GLncr+Ey7vp+sIucVGI/62aunuYgz?=
 =?us-ascii?Q?UAdVkzCnvDHwrmf3+ag3csrsgy5ityK2ivQ6WcgSP5XqFMvHkL9UOCWJ1XNu?=
 =?us-ascii?Q?2El5Du7RftAPcciU1jiuZ0IXAa6482VD//Vzc293ClR1P2IPuvgaG5/K/2d7?=
 =?us-ascii?Q?fMSXe9gnq3L8JnJJbX4+JjACBNnX+Dpo3T43T6bOiiiO6/iRqoMZrJ1+Gmr6?=
 =?us-ascii?Q?Dfu7Ru6onH582+GdnAR/s6ElP6XWRpK9rm9nZ+bq4QuDECl2LHXcCXjVV9Zo?=
 =?us-ascii?Q?wQk1Y+70Uq8FWhPmVNuzRogVlNTb+ngbfejm+XmrjYB8U+7HcRM5T/9UeJM0?=
 =?us-ascii?Q?9rC96GD+LBaWpmoo9vsoCoV+gUoQAcEjZ/8xkklWhSkOzetd0MOxqa9TQ1Re?=
 =?us-ascii?Q?M/Blx3xPHysqoQJEW9rTScZ2FgogiyyZRA28JofDEXHbxw37CuM0DrPgckG1?=
 =?us-ascii?Q?sV6zqWxdSEhNTOOG109cXIyOM5PieRNTcGgc0Iog2qu2ZbaQeDXA5WSxVRnb?=
 =?us-ascii?Q?Ml/Sbt2IqRaW3LLwZG4nxCv6CccMV5DfAGteFI25J9S68Ci+7N0pkKKipxq1?=
 =?us-ascii?Q?1l3jReYAqVhdbOVwMyQxC48PbLGmpIZWYm/dJO2yCSwdvBGM4lWcVKDo4+1g?=
 =?us-ascii?Q?esSZztZLpreqaMSYfo9gIoEpq+G+F5xb0eUWWUbytMbCUswvMxYAdifAxp24?=
 =?us-ascii?Q?hKfNK40PFHoYoOUoa6+mC11mx8QhSb4Vwbel5jKMRwc9tjDQdI+25c8D2712?=
 =?us-ascii?Q?bbuBHLRC7HcEDbzlkE5Xufz+bn2WHyMOYy6iIZguux9V1mE0SxmS5nGFUzdz?=
 =?us-ascii?Q?yZxNCIFA2BKq7kun3Hlg5P/cxoGBmKzaTvccpjQxNHtt0SvjnMA3tWyEFHfM?=
 =?us-ascii?Q?cELkVq5YZ4itotx4uqcnazR+Wku6JKgCzsgW+TJHS3TP7Eug4Hxx68qkDjpZ?=
 =?us-ascii?Q?CRpcQx/hZ6bC9CQ3OS+Qm/IEnVq/8ebTD8pWm2tEeSB7w3U1KDtL4B5px0Zv?=
 =?us-ascii?Q?pJGWAsfM181+OltGMCj+gJnVrji0AL5ueRV2Np0wv8TIymc1Or4kmo/Hwbv5?=
 =?us-ascii?Q?OrhxdjBPVyYCXtMb+EvwRM5/QCOHzlBw16fNg+3Ds4JDjOsBbU055Zs47wl3?=
 =?us-ascii?Q?wFfZnJdXBMFjp9fTIcJAZKd2JllzR4AZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dNBhPmAbYa5fKRluJEzoYE6rpr1EcmQh9KtR8qI4QkI0Zpz+Gzv/3ruwNLjL?=
 =?us-ascii?Q?caE7Q6Jv+aq66ZXHHjY3hQVeO7ed+B/iCtqoHPfroWOHdd+8QVlt6ADBTJRx?=
 =?us-ascii?Q?YbXbGkIf+VibF5qWXfGuBj+Ni52RdQMMfzRwopFGfgoXHNMwnjPTqIAze71A?=
 =?us-ascii?Q?YAO5E8giAHA75u6IT/HgRXgGBILOxHhiXTiikUI0oxgjV5ePmCHdYkPStKCB?=
 =?us-ascii?Q?Y6YG9wq+N/wvRaSRbZacHEX/NtFAxpJvuprPI6HmmBKmsaDnu2dIsth4jdvw?=
 =?us-ascii?Q?t9M0B+iAX6dl5h54+ejtlC2a3APTvz/JKe8OeNe3quNSBjDgqGmtG5POAO7E?=
 =?us-ascii?Q?J1xCnSogvMI1gyKKwRUyUS4ZbQ5nlQK0OWSgzlDXxXeIWVQK/OGH/kSjziaH?=
 =?us-ascii?Q?ORSRcgA3Wv/IzT0KAiwgPzPr740r15VTjpMhfejNc4pqCtb64/paxrfFGFS1?=
 =?us-ascii?Q?/CZjtp4mEoy62M96gql6vZTVo76Sxv4WrjHJ1u8mOOnmVaFzOnAiojUiBvKG?=
 =?us-ascii?Q?v9B/qHdRDGG7yt0SjXrL0ND+9Ugo9If6guyKvYTCa8i+ViONhdgL3xedIzSX?=
 =?us-ascii?Q?zeEnd23TVFlZkWRWEh4Le2V4AN92BhmoffoctiOS/KVfN1IwYmJMwaWnmNnr?=
 =?us-ascii?Q?hp7A7qWo28nUweEAYtCSdl5PbqCqAs5ljY00euDWkORo2lBnjtCgoWu58NjP?=
 =?us-ascii?Q?JMko2tD3Ar8uSAqldt3H7VDMB2qqa1Q4Blm6ccypsFGNRTOgff5sZGUdJY5r?=
 =?us-ascii?Q?XrmuOPZwmRtZSAqT7uMJBjLG3mBtmb1XILSY0c2DMXYs4IqlpA1WzXJfy04V?=
 =?us-ascii?Q?Cq8qjCyWsYGe1VrFfvR5VP2g95hauf5imYHDZxvSELTJLCT+bCT4a/bHeVUQ?=
 =?us-ascii?Q?SIHWg3sS9+pktegd/rD0O5dHEX8r6Qfl3z37+uy2A39VaqERme2vnQ/V1rgH?=
 =?us-ascii?Q?yBftGjLatgaz9z/BSWKtaAzjuJ7yGYXU9fhwuNV7HRFcdl2x4200eqBgnwv6?=
 =?us-ascii?Q?PafRIYiHaveBzkTb3Enzt+9iKZn0zE1mb7JsUfcXY6wA5nx9sl8xWskbX5n+?=
 =?us-ascii?Q?2BFkDlFK3pXouJLbOxacI2Qm8CHLHIDaJaJlnym1SGCX4H6wBZEmtyDX9Sma?=
 =?us-ascii?Q?QFeyWNlIOulAEa2boeGagG3d0u6vC6c/r/u6+juOTb9pFT6A6KTVum/L1L6V?=
 =?us-ascii?Q?zQ9+WSz3Vj6fHPVgPZajbnXA5v8GMA+GUBRoXunTCnNzqZ3O7+vu48qG8mDv?=
 =?us-ascii?Q?cwKNpChFvH83rPJDVKoYh9mEh9l07jhO20q6sseaXHWl3qM+/MmLzTxxr/fV?=
 =?us-ascii?Q?YgJjCMtquYnLAaA8Isx/Y+2wRQpLsPmYIOqP69ziWvoxUTBUtjLpdeH+xgcj?=
 =?us-ascii?Q?7mQoLCHu3npEQln9jJqfDfHqbfvav1b3WfZ/NI7xpmIGHqiwgO51+DWh/pKj?=
 =?us-ascii?Q?/G6tx/2ZbxDntp/H1deN1KJNlA/PYJfcekAWt1PDETpLyNdxICm059v/uve1?=
 =?us-ascii?Q?dLejJXdnigGsH08Ion00D9Mazf3azBRr1puEd9xSETcJPt+Hie8m5oyldbyw?=
 =?us-ascii?Q?5tSIbb/ggqhtUZ4M03F6uVeZEbTS17PX0OdG8qzr9qkHfkpr/ZEfmQVDSwJy?=
 =?us-ascii?Q?7CtFRkj+sTuJxn2nJzomNJpyDB5PKhPUMTc6qoDt8zAk1UXEi3oe/p3lrTQp?=
 =?us-ascii?Q?Q9I9E88V92A8rfwFSWolvfR4FK+J4nm5nEsZ0iDif8N1sxaKTuq+mF6ro93F?=
 =?us-ascii?Q?T6hPCWMzvg=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fad67b81-b424-46d9-aa1b-08de487efd96
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 15:12:19.2117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVC31Nj4/5g+GHIjlr5katH4k5OJQ/qXSH9PzJ3nJemXDdT8eEyoTKYASs0l/Ms6QOUeJRPX20Ok0yfVCFvg5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3281

On Wed, 31 Dec 2025 12:22:24 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> There are currently a few places in the kernel where we use volatile
> reads when we really should be using `READ_ONCE`. To make it possible to
> replace these with proper `READ_ONCE` calls, introduce a Rust version of
> `READ_ONCE`.
> 
> A new config option CONFIG_ARCH_USE_CUSTOM_READ_ONCE is introduced so
> that Rust is able to use conditional compilation to implement READ_ONCE
> in terms of either a volatile read, or by calling into a C helper
> function, depending on the architecture.
> 
> This series is intended to be merged through ATOMIC INFRASTRUCTURE.

Hi Alice,

I would prefer not to expose the READ_ONCE/WRITE_ONCE functions, at
least not with their atomic semantics.

Both callsites that you have converted should be using

	Atomic::from_ptr().load(Relaxed)

Please refer to the documentation of `Atomic` about this. Fujita has a
series that expand the type to u8/u16 if you need narrower accesses.

Best,
Gary


> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Alice Ryhl (5):
>       arch: add CONFIG_ARCH_USE_CUSTOM_READ_ONCE for arm64/alpha
>       rust: sync: add READ_ONCE and WRITE_ONCE
>       rust: sync: support using bool with READ_ONCE
>       rust: hrtimer: use READ_ONCE instead of read_volatile
>       rust: fs: use READ_ONCE instead of read_volatile
> 
>  MAINTAINERS                     |   2 +
>  arch/Kconfig                    |  11 +++
>  arch/alpha/Kconfig              |   1 +
>  arch/alpha/include/asm/rwonce.h |   4 +-
>  arch/arm64/Kconfig              |   1 +
>  arch/arm64/include/asm/rwonce.h |   4 +-
>  rust/helpers/helpers.c          |   1 +
>  rust/helpers/rwonce.c           |  34 +++++++
>  rust/kernel/fs/file.rs          |   8 +-
>  rust/kernel/sync.rs             |   2 +
>  rust/kernel/sync/rwonce.rs      | 207 ++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/time/hrtimer.rs     |   8 +-
>  12 files changed, 268 insertions(+), 15 deletions(-)
> ---
> base-commit: f8f9c1f4d0c7a64600e2ca312dec824a0bc2f1da
> change-id: 20251230-rwonce-1e8d2ee0bcf9
> 
> Best regards,


