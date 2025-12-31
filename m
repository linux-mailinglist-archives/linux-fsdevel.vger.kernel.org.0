Return-Path: <linux-fsdevel+bounces-72294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C621ACEC299
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 16:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E30A4302104F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 15:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067BA275B1A;
	Wed, 31 Dec 2025 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="wVraxb6M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022075.outbound.protection.outlook.com [52.101.96.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D531A9F91;
	Wed, 31 Dec 2025 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767194741; cv=fail; b=PMDc4H5969nAX6t3jXRf5I3V9sCU/D7lLgC7s6S5JhuqgbB5wJSEg2ljDesXcLtfgi4v/N0oIPViRMQFBJ2LnHlKvQV0YxCY3N8YPIodnrKGluS4C9xKmDysrWZyEv1X3AVcCl/w3/5c2O+3/ZqnPgqm9iWuwg/kVi9HfEu/92g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767194741; c=relaxed/simple;
	bh=Xb0/ihmLQMDja0IzKlO7vsyOVlGmO9HqxwHXjzfOAQw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gP9AssFj+G51CbxgX4u/+9IYIrJWGuRdBHiaD1rRCXTDkQjcP9roHBXT6tMebfvoPTEydlsRnhNs3XjdrH7Q4EifR2eo4dKtpnRBnPurKH09Y6NfrfpWS2oxIAsPju7JsF8RHUBy9I2fL0I66RptaCkWx4EIAofkIhantzxFEIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=wVraxb6M; arc=fail smtp.client-ip=52.101.96.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZUZar6irukVse/cK47oXss2QaqlZgvzG/kSoFF8RN1B+4ht5H4nsmWc1CN20HY2gnATM/EDbltU4svjW48JzUcG2YbuhXEg7FrQ42Bd6Yuo7LfAeT24wkpcmKf1exOpLgoXLGr5jK0zoTBezYH57BLbbVayuz0tFSOWAmcimLKbsY+VUqMadtruf0BrXNNL4kXwMK1vdCtsDmDrKmX1DGsNcTB9jr5cPPG5sr276c2C5bdF8+WrrbieHbcXAuQfc0p2uqCFds8YXObZ8dBQhUPLemGymyVmHXNnHMBNsazu5FItFPBoKSU35IFxyO/JNbNgvIpVpMH9bmq9yNzJYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWgUpoyBc42NruFhg6u3xoIJxWT3pGgLhWoSv5dY2/4=;
 b=h8cV0bBWN9n9mQsJPBHfRQjlYXX7NmiPHBhF3DINX9dTWlR8mN08dqZC81ksagRW6OOFY4T6qUy3X2W5DP8Mj8fpATcaejTovGMAsBF/nhUXPPtecVpi2tKNT6QFlnuqek8vqd5Hy1EWz8DlYy06twhv9vMxrPyr1HJCQg3Qo6Yc8jYOHtMzmg0dc841Z4dSdtIiBBMW1RfMkuYQRDPu/B8ZXUIXwT3kNk1m1y+CdFiKghrGLNZEHx2Yspi/7pLZyz+xCm+UE8mIKd994o270MDW90OOBPRAhg6ouaTHW7vqG43g4U7T1Cq4VRJvRt3Npei4/NuFz6LW2RAUpQUbPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWgUpoyBc42NruFhg6u3xoIJxWT3pGgLhWoSv5dY2/4=;
 b=wVraxb6MU1Tvms58vkZQY58naMUJXHIVbaQGPbjyRbwBjG60Qaz9XHfxg3X3EyasqjKiEWnyjkLZj3Ma4xUgaFbmAtzz9RP9SPta+724tx6kLXqd8lefKKPuKFT9+4/GyGzntG571HoxP1cZkiHlqe5yXiOEMAqA3NwAS9CDQ34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB2784.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:147::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 15:25:36 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ea6a:3ec2:375d:1ce0]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ea6a:3ec2:375d:1ce0%7]) with mapi id 15.20.9478.004; Wed, 31 Dec 2025
 15:25:36 +0000
Date: Wed, 31 Dec 2025 15:25:34 +0000
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
Subject: Re: [PATCH 3/5] rust: sync: support using bool with READ_ONCE
Message-ID: <20251231152534.14903719.gary@garyguo.net>
In-Reply-To: <20251231-rwonce-v1-3-702a10b85278@google.com>
References: <20251231-rwonce-v1-0-702a10b85278@google.com>
	<20251231-rwonce-v1-3-702a10b85278@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0616.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB2784:EE_
X-MS-Office365-Filtering-Correlation-Id: 70f5036d-d32c-4576-ebab-08de4880d8ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lb97B2vUOG5LhJj8l1KvoDMEZEQOuBlnSVwAaAfZzQJpiDMbG1cTmesOVaDK?=
 =?us-ascii?Q?87nYrepc3WVNfFNMlCK37e75eEU/oEqzBSLGBlhAQ9awiDpPUpWxIiAw4WsB?=
 =?us-ascii?Q?f15zc7ZvSFqUToxAEfPrgRyyC8r6+uWu3QhE9C7OzC62gFW5q5kVhuQ32975?=
 =?us-ascii?Q?z99I1DcH8N0nTmins/H6XjLmTEKnLMnpAY9wVq4pQN0FJLQjBt09FXgbkoYC?=
 =?us-ascii?Q?2BLC0Fy+FGsr4FMzkjz/oTwUXnUO+IH+hvqCioGOZThRzqGoQYOFyinpiPkD?=
 =?us-ascii?Q?pnIxgZx9vpNhjXm7INHLa+UnDqKrWzlciJ74CmRo++Af33iY99mqLPr3/u6/?=
 =?us-ascii?Q?Mert6NOJ27b906Tpbj/rWMuyK+KzK7igwXpTh4pSL41+6ZGegGwGRksy2wss?=
 =?us-ascii?Q?JPq5lmBZPU88OLaYSiO8bQ0ac0QWU1pZdv7TftzzgxPYwK9kUNHbwE+cOvnh?=
 =?us-ascii?Q?taTlmBQn5bq6qJASpwtPJv5RbGjHq9Qq6MWp9lK1Xh8ffBWTwui7vh1WLC2N?=
 =?us-ascii?Q?0xxXzjmLiwcFMT3ysQspFzamFWgUAsJCEL0EcV2bZLomHOB155N0qYzEYz4N?=
 =?us-ascii?Q?1mzVk7f3WMCbAhk/euHo2z4HBy3JgZ1lRZkbOz3rWY4MpgNq0JYtFZedJS0l?=
 =?us-ascii?Q?/FFGG9ZZqubYQMMSap7PTbtokx9IrfTragCSJAwOtpdt8h9LPQX9711L/PCO?=
 =?us-ascii?Q?JYila1DOonha9jAHzQBWWJNXxlLSO7GchPO8QmfCLGVNiduTomF9TDPYwSjG?=
 =?us-ascii?Q?62BRhd6iZ3yaGbDi1QPvixIUvOr5qPIMsDrXErpyYG3GqGHn0odEyQgOF+yV?=
 =?us-ascii?Q?Mpo7hQQmhcJ0qM+4sTAVFL90wUV7Vq+2+xZbL+bylbwbOgbQ7D5X6D75F94u?=
 =?us-ascii?Q?hX7Qixd6EQQIT2g6RYv8RVMsyVr3w+PO0pl9wRI1y3H8sbVinmJumekxpYaF?=
 =?us-ascii?Q?rwzZtQPJBP9od/zUrlcu42gnXPd1f6+WKTtxYYpuubpIkAYljMrWJ3r9HVqw?=
 =?us-ascii?Q?GpsgBnkywG78/gjrWPTZDcRJj7xCDup51OVdhAyWiSTJFgWJXXX8ntSUwUMS?=
 =?us-ascii?Q?QJg6sAvvjkmdvgqwnlWzLD7qxbXcZ8b5i56wWYSaLl0VNpTIt15uW0fTYmFO?=
 =?us-ascii?Q?NXCY0BeGEUkrARgpslEXaKrgl86C5IGM3Zln9pwYv1pZD5d862Q3NJIlMrzp?=
 =?us-ascii?Q?H6wT08bxZ8FmMOgCRcbomBq9CIM39ukKlhFSW445YAI47rBEzjvnOwFElq25?=
 =?us-ascii?Q?bkZPTBMppaamuth/9rU6JsjhCcf7gTd514A+ckaVnb52rHJ99bhnVLegqC1d?=
 =?us-ascii?Q?IyGty4CqnrfugfLJKt22OkvvWcAxHe0O+PUbaIxXmQD9B6SJ4MJYMJAU4N/l?=
 =?us-ascii?Q?vqHy8wg8nfbf9ZQuqYAOkSvHAiPURalXgWidk2yuX6hrkpchF2Zisv3Hc5lq?=
 =?us-ascii?Q?fqpKYJaKNbNwF/v1GxtjHd5xjp4JTz2p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cZ8+568bcJ4ScllyGbSjtiLCTzWvlT+J/n/U1OTUVtfO6K8QROC5vAZ3NI9v?=
 =?us-ascii?Q?JNVnGUicMn+oJtdM2KgFCi6kWSsQzw9vZ0XJBiGHarChkTlEficqMvTxPMWH?=
 =?us-ascii?Q?YIdIn/ZGkee7mYeQajVGzxWYVkv2oPApyJn8mBT6eQHj+lxwRi5qlCPzWERc?=
 =?us-ascii?Q?Gv/FOrzrs4xVeSVahKuL4hE+VzhG5ETlcKz6gdAHtmOVeGKCALlzjM2DAthU?=
 =?us-ascii?Q?zLkf0g25nEwk3wHMC/QHWuEc3vic5GlrXhuAl140lZJQ/WQ/pUnG5iBoXBZy?=
 =?us-ascii?Q?4TlQ1R+LUsU6S7EfBhGIzQrH2D5rjlNzd74q6k8GqRn9XUDK3QA1c4GG+vfV?=
 =?us-ascii?Q?FUECBcV4zQJ60vw88HP9vcqwu2NlpMuduBYinaTXZ28AuyclVm7vR48boarv?=
 =?us-ascii?Q?RdVVk61q1/6zclRdKsBeqYO+46m/vMgGtKfdggxySuVvcEhEsxkA4OeC0XTR?=
 =?us-ascii?Q?aLZPNE7xxL1PNd2Hcfes78IaRmpKAKjuVHGfXEM6UOpcVVQDGDtaS4vc8oT8?=
 =?us-ascii?Q?ZqYyB9uoV+ylp5zYvxPs7KeLNhZnp/6W1E/YiZR4E9V9BBs6kXRfB0V1w5Z9?=
 =?us-ascii?Q?8PspOQ3KJr4lK7+ZxBheZsGRWilxFkl2vL2wiHVxdXHD7ZmtPMUKGwo0avEE?=
 =?us-ascii?Q?r5fRjG3V2sMqG7/twuMBUwgDhd6tfDB+0FuiwUMct3jX5hxRE9ZPlZgWm2ip?=
 =?us-ascii?Q?8zo8KrdgPce1gdELhahURMX65mfFntMHG7VYnbybgMEKWvTxxAO0y2/vmKnT?=
 =?us-ascii?Q?t3O06STsLS9wTvVlw31Cy75q+A1lsG/4RhCUCkjdMZknT2BALvBPL0VOrGwZ?=
 =?us-ascii?Q?youlJedD5sOqY7QvSvkiSdyUNyD2+dDuulxbECld72jySLFC2Hsasi/17/an?=
 =?us-ascii?Q?gL4Nq9agk6BvYPDiGfqgKAe59XeppC533BAYeI5hmMe5rrluUbupuTyttEfE?=
 =?us-ascii?Q?kgx8WJxaZleudl7GsiuZKTPxGJplZk9yDDUBYctl0hb1EEwWjIwE/KkO760O?=
 =?us-ascii?Q?/7uwgmM/otIjHu+T5fiR9YEkoCPL6qxSERCYSHxkuP7q7Lsb1yWir1AwAMRu?=
 =?us-ascii?Q?iVLH8otKqAgVKyt/KUv9GlTnTpbF/+UXBRKFNiI+R3IsFOPmZd4qaV/aZ2Zf?=
 =?us-ascii?Q?LGQS2mM3UOTYWpDOZIt+nHRKwDnIMD94FrmfbOXNlSns2gAmvs4DN999Yrl9?=
 =?us-ascii?Q?+BUzCdC3IAR4FrPbpT9DrQx3UFo2Xwuh6EU68JhIxsaXZwAHFB1ihdOz+phv?=
 =?us-ascii?Q?DtQgY9YRYYpggs7SqPC/DlPKA5mdJ3RqWR/+l/2SnlgjQP9BcDs8tVGLrpFI?=
 =?us-ascii?Q?oYMbChDTBtxTJrebL7BcwaWQeWt+Tv70QD6nNaa4RnZbOKoptW5/MVSN84Hd?=
 =?us-ascii?Q?CanxbowYW9hQJ06ggiKs3d8Y27vT+gpRhmAPdYRDCyI87BdlcSH9hLKZ36uR?=
 =?us-ascii?Q?5qoMMt9qAnCSX5oyJQhvf7gbhavzUUbU+bP27uSneFZw3ex5uA/hi2/3FtJJ?=
 =?us-ascii?Q?uC7OB0hwmyU/S1IZUqE9CC0Q1wTLY+dsfKRqo20wABY6YQJbVPadWD+sHZXf?=
 =?us-ascii?Q?SAy0ayFkbPhuHt6Jbp39XCuipGsKHkFZohGQXGlEp5KTPKKbMd5MpEGdw6Nf?=
 =?us-ascii?Q?o4Bw5SCg5NHS5afj6khJ8x4ZyDUpbamPHvvETDrVeDdBpY9RjNy+llQnSTHl?=
 =?us-ascii?Q?oyHT8cpnvuzHEwrfOAUqCH7CTp7FAj2yrnweq40ph+ptCgI4mWnUhYwSz+35?=
 =?us-ascii?Q?wE0bGzq2tQ=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f5036d-d32c-4576-ebab-08de4880d8ce
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 15:25:36.4648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPspOcjpc8qFF1fdRHXLbi9Q24hFw07Tkm6o0CArKyLO0Q4ggnMeY2vtCKd+4AqrKTWgAllL+XutvryzYKE9Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2784

On Wed, 31 Dec 2025 12:22:27 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> Normally it is undefined behavior for a bool to take any value other
> than 0 or 1. However, in the case of READ_ONCE(some_bool) is used, this
> UB seems dangerous and unnecessary. I can easily imagine some Rust code
> that looks like this:
> 
> 	if READ_ONCE(&raw const (*my_c_struct).my_bool_field) {
> 	    ...
> 	}
> 
> And by making an analogy to what the equivalent C code is, anyone
> writing this probably just meant to treat any non-zero value as true.

In C, bool can only hold value `false` and `true`, too, and putting
any other value there is going to be UB.

The C language provides automatic cast so when you write an integer to it,
non-zero values will cause `true` to be written. However, you're not
allowed to cast it into a char ptr and write other values into it.

So I think there shouldn't be any special treatment to boolean type in
this regard.

Best,
Gary

> 
> For WRITE_ONCE no special logic is required.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/sync/rwonce.rs | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/rust/kernel/sync/rwonce.rs b/rust/kernel/sync/rwonce.rs
> index a1660e43c9ef94011812d1816713cf031a73de1d..73477f53131926996614df573b2d50fff98e624f 100644
> --- a/rust/kernel/sync/rwonce.rs
> +++ b/rust/kernel/sync/rwonce.rs
> @@ -163,6 +163,7 @@ unsafe fn write_once(ptr: *mut Self, val: Self) {
>  // sizes, so picking the wrong helper should lead to a build error.
>  
>  impl_rw_once_type! {
> +    bool, read_once_bool, write_once_1;
>      u8,   read_once_1, write_once_1;
>      i8,   read_once_1, write_once_1;
>      u16,  read_once_2, write_once_2;
> @@ -186,3 +187,21 @@ unsafe fn write_once(ptr: *mut Self, val: Self) {
>      usize, read_once_8, write_once_8;
>      isize, read_once_8, write_once_8;
>  }
> +
> +/// Read an integer as a boolean once.
> +///
> +/// Returns `true` if the value behind the pointer is non-zero. Otherwise returns `false`.
> +///
> +/// # Safety
> +///
> +/// It must be safe to `READ_ONCE` the `ptr` with type `u8`.
> +#[inline(always)]
> +#[track_caller]
> +unsafe fn read_once_bool(ptr: *const bool) -> bool {
> +    // Implement `read_once_bool` in terms of `read_once_1`. The arch-specific logic is inside
> +    // of `read_once_1`.
> +    //
> +    // SAFETY: It is safe to `READ_ONCE` the `ptr` with type `u8`.
> +    let byte = unsafe { read_once_1(ptr.cast::<u8>()) };
> +    byte != 0u8
> +}
> 


