Return-Path: <linux-fsdevel+bounces-25324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B7C94AB67
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 17:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D7D62839EE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 15:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3F1137776;
	Wed,  7 Aug 2024 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="zRzZF8Jf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020121.outbound.protection.outlook.com [52.101.196.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F095582488;
	Wed,  7 Aug 2024 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043104; cv=fail; b=uIknAQTX2stM6kArE8rkcOLZZLFvKILZQU3U9t53lHsXCZq/C2nlV85I7bsIuwiCqZ3e336ilXQ7YJLiM0YRTbeNu6W/v5AqIaBf1BjD2USqFxZp3IC59DAodvl7xOIAqY670wjQtvd3awMkBY1EyGPb2xps5HL2ucZMLKagiG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043104; c=relaxed/simple;
	bh=jQ78UKfVO5FIckjplKHNmdkzvv+dgy5/hsPujWn/xHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N+/KNmcsWvQ9ja3JjsahYN41c1/cBdvlC4uvWmyZKHWslmbmNLieh9grnHzCSX5aBCmhznMAc1n40HXn1nN3AzBiyqa+LvsbO7ePoW1HTtaAYOaZCSXbPt5f9mmnrnKAX2rci45cmuYhgas7amEY9jf2g4vmaCH0BGi2Daxhwtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=zRzZF8Jf; arc=fail smtp.client-ip=52.101.196.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6YPxhYPeTImoBtr8IS599e/RWQT5lBAZDMDgV7d2/qCFRdu+9ht1YHFG9/SS42YEZS6KJsAWell0W8X2XIXm5NzhRt22wiKrDKsjkWiLU9g12orO8P9c4fbxukv+14gIDoFHloQ84vCJIsUkMLmBn7wuUoWcjcrg56VWODHgo55uCSZyxj9yvNMFJcAsgWKfl3OZQux0sy2F8/OT9cC8SFJBI1SS3XSgC/aQU19Vs0Gt9KMgP24w5wT8KkJkolLaoksgRfqXCThc1IFP4qUC7JJmUzuk6YX2uWCRTC8Y/BY/1RzYAx1YVAc4Rket2By8AQLKDporZkwjimvTZIYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bHJFWLxgMfcjKcxelRM6bLAn7LciTIB7InU3epgXeE=;
 b=F6v6TfToN1rD2VgovFalfRBWgTpwpgrbpcuMnjnW3tbyyzYeOlvExrWX4hST07pmtS2wRzsI+5fNCLImv6qBqa9biDv7tohp1up239osaJQbtA7sdTxWwrYpxFmov36QO0ahOj43JZypLr7PxQ8nXLqpf0zfdxlUeThus7lYGw58uRCQXZCYLXhJsV/T7T212D1a6bEN/iJNuJsrnqYAnOLmJ9/cBc8cTciJrHLD39wHwqmNv5DGC9oEqeTH2rfwN9IDtSL8ipBLNC4zgmfY+LgA1Vt0iobgOxXUKTHcpvkxrMrkCj35n27W41RVG0EnT2JLTS6P84FE+VXaZx61Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bHJFWLxgMfcjKcxelRM6bLAn7LciTIB7InU3epgXeE=;
 b=zRzZF8JfbFZG4T41E5X7C9ZTlCiWXvkepsAI/otC10fQ56wjj58qssiXRM+eovm4bL9mB4KZ4Wtf9fN7910SHZprsMhDvjCz4GHK8GgEiE7w81P/sh0OQxNHpxym/bkBjwa5dAeqqAE56ZqhHkwn2I1q/RsLM/AErldBXG9+XEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB5779.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:264::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 15:04:59 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%7]) with mapi id 15.20.7849.008; Wed, 7 Aug 2024
 15:04:59 +0000
Date: Wed, 7 Aug 2024 16:04:57 +0100
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
Subject: Re: [PATCH v8 6/8] rust: file: add `FileDescriptorReservation`
Message-ID: <20240807160457.73445f04@eugeo>
In-Reply-To: <20240725-alice-file-v8-6-55a2e80deaa8@google.com>
References: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
	<20240725-alice-file-v8-6-55a2e80deaa8@google.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0587.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::15) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: 564a6e91-4552-4675-6df5-08dcb6f24e87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BQxWBXc8gA/7OY2gpN7UsMXgzBrXMgl/oet2cA6o8yqXBqnqTgVOW3JbfVdz?=
 =?us-ascii?Q?dLBkFCDc2nrp3oYrClRh2tsoedza3PJ/DjLVsBYtYZUKeB5U+YmiwaawM1Pt?=
 =?us-ascii?Q?DvlalZ+jqvrMtN8BjnHl/vGs3goOFyxALgoBoSAdrS4EhYoxSwabM/1VJn2h?=
 =?us-ascii?Q?P1evNuZF/qc6oEAuldO+ojgdBLpDqb7gc70g2X0imxz/HRmR8yAYjsRjfwMW?=
 =?us-ascii?Q?TkcS3pSKL5jDZeXrXQkoA7o66v/cVG73QxwvmenBysbg9Z3XtNxlpfAa3mo6?=
 =?us-ascii?Q?F15H2CDRtWVZ3Dz9RsBGQppU3RSjFE4dlYdYrCJovI9LBrmiU1T6NgXjlkve?=
 =?us-ascii?Q?lGGKBYdxNHu86UIJF0HuPbywbnnpOB41GIomLyG1z3D93gYRFt5hsiLKZMgc?=
 =?us-ascii?Q?jxGzzt3xQjSnwBD5VM54QpXMihbJBspaX24DhoxQWvb+OoQ+7dsSWxqsEw1h?=
 =?us-ascii?Q?CEC+4Bw3EFLygIGVdyDcIjZGjLxsuzsK0oxGRjdcHB9T95J3r3n1oytXCFtJ?=
 =?us-ascii?Q?uE5pYdeOrI9RlVr37XStA/YfaDJeaygCbjW6nAc5a/bwAl1Q+3C/xBYYrB7K?=
 =?us-ascii?Q?2m0RJPY5dt5Kl90bCpFnjROiAGa5ujFV9cIahyAwhRsnKaceZaMKK/0bku3+?=
 =?us-ascii?Q?1o+4oj9MLoxqETA3uDmX0U9pLdnNeTN8aGGjADkMlK4YyQIP+cVmxiy9k67J?=
 =?us-ascii?Q?2OkxZl8mX0BQKe1oSdIM725mTBixrdPYg2dmcV4ePskeVrbMun0TE0eekbNK?=
 =?us-ascii?Q?yYN3w6APoUmiengtvODL/OEOuCk6OeEomi/TOXnNaHZTfrV9ntpplUFSfD2R?=
 =?us-ascii?Q?PG1qowhRVzfKQKu6/6Uvfv479dYMqCq4wNRmNq0zbZKyDs9DuDUZdnSNu/0r?=
 =?us-ascii?Q?SlQocOJ+9dAr1foqVyc9yRAL8ibSg0vnlgVQfKMUKJYXb0uwIu270F7h7ot8?=
 =?us-ascii?Q?g/o5TtznmHMGA1nyAwHODr2WDLP8QeO4cXFqekCG2CS6d9mRTrRto4LmmZWR?=
 =?us-ascii?Q?WhPj2K9nzTLuYwi0jXO0WFve3t4CZMftcE8jkH4I7/qQGGLXuWnMmj1jiWzK?=
 =?us-ascii?Q?ihNPRhE5Pm1awFm89tPFHyPIi47H6u/YNxWM/V2T5zPJza39ZsIHpbH27F1x?=
 =?us-ascii?Q?PFe8EHmluICpgRNTcaO7iEMQxrbrHX/LErhzV3ue1cfjuhfe/0q6pJXR7lCg?=
 =?us-ascii?Q?orjDk39VOnx0Ng35zxsQwr6auib5qH8xilCgLGfIhn3WMDYfFMPGgTf11sfc?=
 =?us-ascii?Q?Ema15fklfhoWG0NYHLq4ZMJwGJZAHeH/gldxmm4dJFAli9r8YlfXLFLDxMth?=
 =?us-ascii?Q?Gk3FOHJpvCvMnqBxZxrhEHiWiJ21GAgZRPUt8pDeviyd9w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qtcf50Go1wtkcVI4J7Fl0xp4GuzQfDozgFjiinL/U5nWZHO2Dn0LKKrfCyN2?=
 =?us-ascii?Q?G64TJBCzVsW32jx3uHq4w3UswblofxDKqc5VKxNY3IiNGpBy8IFutki0SL/m?=
 =?us-ascii?Q?T6YV2IfP11scXA7tb9emDEiHW/pZIH5I7TALyNU2D/F/hT4AsyIDGxPRuZu8?=
 =?us-ascii?Q?XBw1h98W65FXTyIjMvFs5ngAS+tD8uPw54D3fEsnqj79pVU9PtgSzHEQJEG5?=
 =?us-ascii?Q?Fdc88hxfJFmGG6sXcnTbj/uMaXxFv6FC3RZUHK8WRT3Mg7S5HnMnBu1RAJkS?=
 =?us-ascii?Q?GlcVCDJgKGcUl6kVUAY19Ml2/dJqu+kix7s4PnJzyNWWdVCv749PB7pn9z6T?=
 =?us-ascii?Q?ugBl9QFHe0GqIw85QCEOeJgiLCzZWzvd8sLLXC/IeFVWK3fdVdQ7pnNhA2sf?=
 =?us-ascii?Q?XITIR298K+DVCReeAqzfPPNOU3IvUVDWF5Q+ZpVzzAaPd3HHLID4hEDbD/FO?=
 =?us-ascii?Q?RLzgV2IgttU5dya4kYpx2fdPKToGBrvSTro6u3WmfvE/UA7m4/mR34Eepue4?=
 =?us-ascii?Q?iHl6lozliIXrngB/ojsOQQQgF8Gnwayk3n+umQg63LSB0fFcU+qQmdCwm2R9?=
 =?us-ascii?Q?8D/fT+LcQ/AyrZ2uQ3DLxI5X3GIRaHjNyktIkOsDsF7OnnpMxy+BGcwyaJVj?=
 =?us-ascii?Q?Dfwwc996w/MxxaitEymK+q77qjjqzm6QfaIgy7Ogx8XcxeYJFXLxqYyYVh9T?=
 =?us-ascii?Q?SqqjoCnX9MGLBPBhKPtdiDxu1+UEuKR/JNF0rqPKzq2rU4y/B94netV9xqU5?=
 =?us-ascii?Q?7O9sy4Gqm8vyDT24CviCnyo3PNZVhXtHxeb73xH7RYR82owenZ+q7W34dzPN?=
 =?us-ascii?Q?/sugh6fCswooB4RHHtViKwZyRybFss5Kdxl1ug+QOg+fOodW387YS5g+Mqoi?=
 =?us-ascii?Q?imvMHDpAeeuXBGQ0FiBDmiOwStNG/lcHPKCwdyVMDEO5TM3sA0rWOpiMmPFx?=
 =?us-ascii?Q?nZHM+fEC9wUKx5K6kDDWblXj1bqTRtnv+CBY4/pBf3v106piDJmB/tFTGCAW?=
 =?us-ascii?Q?/Q9wVuzeOfJNYigc0TNLiSa21eabmA6iJQZIVJow/doTcFpPQiFEIKH89Mo5?=
 =?us-ascii?Q?MlGdrI3svtvcbBg/Cu1F2FoefvkWu6x7ZwUw6eSqR6AdmcehX4czxzHaL9OJ?=
 =?us-ascii?Q?hirUgd8TF2Uq93C6CeO7WOHBz0AsXwcDTkQHR+lVfIynxRv7EBdwRjT7lG/g?=
 =?us-ascii?Q?yW/UvUpx6ylLTp/TZ+6pJjk2cMFfo1quH22Eng1qOmWztYYAkMDWFaLo1xJ1?=
 =?us-ascii?Q?LtGSbwKkRdx7bLPtQTem9qBdpaNu5Q1f/c6piF0LDhLuQX8HnI3lsxE4zMvv?=
 =?us-ascii?Q?7rnVuikivKiQ02uBkP++D4pn38HlyxmMFn63sjn/C/Hcx8wewY6nxlRio+UP?=
 =?us-ascii?Q?J9pAMSqdt8ugjCCLS0eQrj2F0SGCve3Hss8RX4vDtNxiGi09tuS4O8OxNawO?=
 =?us-ascii?Q?Mq7v+A4BG+NtAnL1HJBEnSv8vy71/N9NX9xuTK/eyD+P4rtukaFKclxT0q96?=
 =?us-ascii?Q?NpBzXE0lzueXc2tzedVAJTHcfxxixc0hdwPOJP8IZm/LpIkRWbaLQfPLP1U0?=
 =?us-ascii?Q?WXEaKqXwEkSBlDw4Ss7Hv3X1zukUX+nB8YsV8K5u?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 564a6e91-4552-4675-6df5-08dcb6f24e87
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 15:04:59.7031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SrClhRY4B6l+yktWs0MOy039eXvMvnB5y67goO1gan7v/D4jWXWtIPUNq9FiNLzMIS8ZnE2hI6KBDFmplvfiRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5779

On Thu, 25 Jul 2024 14:27:39 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> Allow for the creation of a file descriptor in two steps: first, we
> reserve a slot for it, then we commit or drop the reservation. The first
> step may fail (e.g., the current process ran out of available slots),
> but commit and drop never fail (and are mutually exclusive).
> 
> This is needed by Rust Binder when fds are sent from one process to
> another. It has to be a two-step process to properly handle the case
> where multiple fds are sent: The operation must fail or succeed
> atomically, which we achieve by first reserving the fds we need, and
> only installing the files once we have reserved enough fds to send the
> files.
> 
> Fd reservations assume that the value of `current` does not change
> between the call to get_unused_fd_flags and the call to fd_install (or
> put_unused_fd). By not implementing the Send trait, this abstraction
> ensures that the `FileDescriptorReservation` cannot be moved into a
> different process.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/fs/file.rs | 75 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 74 insertions(+), 1 deletion(-)

