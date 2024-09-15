Return-Path: <linux-fsdevel+bounces-29418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 556C897993C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 23:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78B181C21AAA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 21:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4BD74C1B;
	Sun, 15 Sep 2024 21:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="lXYqzlrR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2111.outbound.protection.outlook.com [40.107.121.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A923770C;
	Sun, 15 Sep 2024 21:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726437082; cv=fail; b=jJBJpPX0PgYqdEBX2XEMP+wCnAXqvy5xNro3sBw4sD7M9Ugg7fi7wnrDK5nPTTeNKM5e6N4dJQTod64VJSUxdB1gMH9LgqT7PWwLCGJG4sYtaDm9ttdJ0IBOOvJke2tz70oX5aDJyl1/QTRUR5spTTEjJsTWbiWDrHn5vPrbkyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726437082; c=relaxed/simple;
	bh=W5YYT5l2JNnCkT2I7H0ly03Fq8d2ji3KseoQ5oKPiRM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pBUMOtw1eODkGZq59BFXq6wPvi2oc41lL9rywJLhPcckVJfpKVJEfPf9N/sHdd3Vhg+wN+qPpYe5puzSDa/L61TlmK5yiXiytacq0QOcvFCh1Ob8uUm6C5q+UFVMxTXAtbYjDBNengynOLbAM21IVUJQ52PU5xvMTiK6pzP+BrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=lXYqzlrR; arc=fail smtp.client-ip=40.107.121.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bdfrqdy79iZ2se89zCM2DahApl+AfEsAOvUakYR4O/c5Nj3go3UPSMYfYAmW83rzaPX6oeRfBKQDezekjwbEns98HUqxE/+1HMOkH1mlyKnDWjQ5vKzkUa/I7xu19FIlioBRrCy5w5sjvqYsNIvJtET9fqFsi/lVpZAJqzjfB+wCzGkjHnACQNSSLlAJghNXRnu44n2U0aLEsV8qwfH5vOA89r9C1wV9kJs9jxRwy/8s/pKrxdx9b51zwuEMMR6E2olZTV/EmpGpa3cKj8AobqR1NNn1qHgOo5yeWUF14rPioExm4ZcIUCgN0N1c4yuAODdprwaSfsxZDx03YAN3zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoUbB5eClGGtEU+UbzodWJPeXiRm7mGiOy9Xh9gXZhg=;
 b=evdbFLFjMFbFyTx/PUe7pZ9hyXZ/yad5peC0F6+1UoZcjcNFoCC0knxymWWKadrpoj1IZmfzIZMEHJ6F04Loaw8Hx+8TvMbRy1701VGb161AQl+Voen0mQuPziQV9f5f12Le/4jvBs6IskhkUN0jr8UJAaI70VKxmAyFX/erj359cXSKI/BvrTgvcHqyz+sv0mMRORQQoDw4+OyIuJI8YETarobaPaeFp2feLq2t90hk/N8nqW7R1ddqAgFqEsQbBzNYTvIQu9BoEr0+GALBzUjX7B6bbM5zL+2BlSxgVI0u4hP8TWBFyB+m3+s84GlbStpUQ+iOUhoZbedBOnu7aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoUbB5eClGGtEU+UbzodWJPeXiRm7mGiOy9Xh9gXZhg=;
 b=lXYqzlrRPLwTYCtAYtOQUidpFnkWNTCY/e3iWhZCxlAgFl/kt45iBsOxWASROfbv8biM/o9JPiuXjNIW0NTQAgdesI3h7wN+X7eDFq4k/ZPj3fV6V548kXu0YwnjE4sfNWoLwJic613f4cT+H/3rh/XCQNN/ut3gybupiyBvdf0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO8P265MB7754.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ab::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Sun, 15 Sep
 2024 21:51:17 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.7962.022; Sun, 15 Sep 2024
 21:51:17 +0000
Date: Sun, 15 Sep 2024 22:51:11 +0100
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
Subject: Re: [PATCH v10 3/8] rust: file: add Rust abstraction for `struct
 file`
Message-ID: <20240915225111.50645f57.gary@garyguo.net>
In-Reply-To: <20240915-alice-file-v10-3-88484f7a3dcf@google.com>
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
	<20240915-alice-file-v10-3-88484f7a3dcf@google.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0188.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::32) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO8P265MB7754:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce96669-4530-4a6b-226d-08dcd5d08691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j/ELJ4Doxr9S3rOyLjWOqfh0SgAUGcrP70KSSeeVyjAvgAHy/IaxYIV7qxbN?=
 =?us-ascii?Q?E5MQcZzfttqSDZ2RNTQxBmaqi8sujtr5k20+AZ062Z/YIUbdDNq/997nAWt5?=
 =?us-ascii?Q?6unQy1qzlfL24JGuRDpr4tWc+434lFDWc09dvJeioauu3O/bSvf7fMKvaNNm?=
 =?us-ascii?Q?d/sLHLakeJwLAiBOu4BMEswFjc9bU3xhyVKlxuL3xXaM+piwma2EYZDi3pN/?=
 =?us-ascii?Q?sekqMIY92tfyafSs2LWQYqHHtXHWv646ZQQsc7ZCIXcXUyVK5EVOSAYuw75U?=
 =?us-ascii?Q?JvzOVW1msEK9JEdfYYX+NU6XPg/EI9lme7S7i1PANJIMha91TVqZJ/iyeS5I?=
 =?us-ascii?Q?H5dD8W8wN17y3B5OE2wObCXhv+PeNg/shh4pCgWUYeVUzyqp5bGZq7xfMNAc?=
 =?us-ascii?Q?yc2+CCd4g5+MPQFmyjliByIz+MjAynOGinA0kUn1wNNm5y1PTsZeI6h2WlaC?=
 =?us-ascii?Q?5kaJWASBd/NkyL8HpeECDyy9C/dtJE3UjcsM250vcZbcgbM2hf2m3LF9vSF8?=
 =?us-ascii?Q?oeRZ8cE7UOi+T9yVtpONvR+kClT4z000tL1wrWiyOx5npHqxum5Ul9Avc+kR?=
 =?us-ascii?Q?sqcMW3hkR4gltHY5DxrZ2XoThNyQic4xO6qIvtw/C3Si2NUURe7muqmbUBAC?=
 =?us-ascii?Q?teGXbKZSL365QQWQpbfdanuAQ3H3sgVqTEcwHLxe428tjFh1wbVl5z0F8dST?=
 =?us-ascii?Q?Czllhxuo+GVXAMOmm3XMo53rwkjAhjvGDAvXM6X08KKfim1CqstdQzkYx5lf?=
 =?us-ascii?Q?6opcxoHM1w0ZscVt+eaJfvByeVi12OWm/O9QIygP9PaO8ZZV2Ya03k98ks7d?=
 =?us-ascii?Q?x9Dx12EZwFyGpqO0W82YASOPu2WSt/H72/p5DlFaXarq6M8rfZ3rSA/JWwm9?=
 =?us-ascii?Q?GEctrMwqa/0E9XEEDJhnLQlH1PPfusigQTWp3wEj1pY61KRx78N/rkJJ+LUR?=
 =?us-ascii?Q?NpyxmRFU6bNpv0zfIeZcf8Cvgaa8tb7fabpTtpknY01ro6vHBLhfb6uB2Q/Z?=
 =?us-ascii?Q?4H4hpv+MPF8D1RMLHlAsixPE2eoR/PtyczojHUSa1aXa/kKKtD01GdB5U3F/?=
 =?us-ascii?Q?Mk2uZcOz46qfOMxTkpqLQHDTg3OsIb6ofQSmSCz4CLUnKgHO+KJH3Mwe8A/O?=
 =?us-ascii?Q?J22YrrGtK7CCI7IILtsZ8Zq9w88+gs3ohkD1GiBCB8L/Enx9edKeHoHanS0S?=
 =?us-ascii?Q?rRq5Q3kZ/7WrmQcHTfScxLjvHhWqUXovxfNV6xoEOGC6EVF5ehmf4Sm+gJH/?=
 =?us-ascii?Q?ZU919TDdtD+E/UgfYZB5esSbcX6q0ebFhzmjmn11IHv6oNGCtgYVwgISCPQ/?=
 =?us-ascii?Q?6NuUwdg6mc95oIf5zA22WgjbagrUMeruBUIu5rWCParI4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bdUDSJ6oRq+EX7Aqp8v47EFE8oftyngS/uIrUmG037eglL+dmf1LM810qWsR?=
 =?us-ascii?Q?ah/8+9WhMwIbDP5pYTds/ILqMtmxA/OKlCA01QeyCTucvb4Bnzc9745ZVVMC?=
 =?us-ascii?Q?RtQnnLAq3q66ybEFAwqS9+Ho6+M8l5gQuw0mlLFLyYZFMYg7XTyR5xdNdStw?=
 =?us-ascii?Q?GU6hL/HhVb32Emv42Jf2HfSGp0BfyLsmQhrx5tvGFRBewhg7Ueo52g6oJyyB?=
 =?us-ascii?Q?u4tdV3qQah8yT2sK8DzerSLAxZqSA1/ffo+8TFuQVhwSTaWNQ/JppRxyYmRg?=
 =?us-ascii?Q?QPdUcw5d/D+y2GYuVALvGAJm5nLdN9eu7YoPQGWebD5aB1ZGFlO2WOhoI7bK?=
 =?us-ascii?Q?Ry5d/gnwmhYEwqkAHdeucxobjNAvJIWSFA/4xINlRExJ5+ByPRvaRu0g2niB?=
 =?us-ascii?Q?oS6Y4QW4TcKHD8rL6QNyZ1fNT5/AcoqOup/1cQvsaDFnJweSxlqBh5mlvkje?=
 =?us-ascii?Q?QgiVkYOUDFBenYJWz3rHXWqcEwUYr22cIO6qcKjfGajMiRbpqgvPfW/5j9HT?=
 =?us-ascii?Q?5M0kXmT7KgmyLUgvtHMxM+of59xoWVheLTFiNhbpqx0pE7L7sL2zIhmvxNkr?=
 =?us-ascii?Q?g28FJQmkm3rEANmoEfU5qTuZQk1F0co3RY9w6kAsYYMOhUVPnI45pD1tqy/D?=
 =?us-ascii?Q?YRK+N8+RfWOGx2jBfyjWhTaVgHmoE4UfGHLTL/yMTlB2UPcCKiSzxUJdzWOt?=
 =?us-ascii?Q?AREl9kTfY5jufj07hU4hWvwVmeVODMvHxVzrz6y5WmM9ICvaFQaQc6f395Ky?=
 =?us-ascii?Q?Ld6AgOCGvUPsV1BqFhUamnspqHXLQgqkriM4AF5QAa3ScZndN2ZEOLXMiSop?=
 =?us-ascii?Q?ryE6MA52i0Od2IiNT5L5HdV9WxaYCENubakRI/JSAKHF3h2dQsK0AgXlED+h?=
 =?us-ascii?Q?cshcZVrGHtfmhOc+U9+b+wV5NObF3Lgf6bwGntNdciKr8NBJiY3or6UJP+fF?=
 =?us-ascii?Q?f70yzc64gJ4nTdkEvtM0Rj4a2jYVEkxEhYStSbpIbB1urRPu5bOl0aHok2IN?=
 =?us-ascii?Q?43CwomUMjwsRDJDZ79GxTlr2xAFlLsNM0p3++8uWX4FaGdGcQluAu53BBGoP?=
 =?us-ascii?Q?pYFk0omdTOW/yTivwpabMtjrslv2sIlm+hA+XYpDGxfvF/kSxxk88otQ7/oR?=
 =?us-ascii?Q?Lyx9dwH0YCUm0u5FEeAnUWu8sfiPNoNqAQGuKyzOM3MVdICxpJUbqdmWXerq?=
 =?us-ascii?Q?fcmJRtp7F5dvVHrS37suH8C20omsHN7Nd6yp6xRHX5bxTQS/QSZDrJdlPYi/?=
 =?us-ascii?Q?/bjq5PFNCnzBRPKS1/8yVBPfPtW0dDswD5JwZfZYeY+3uwOtQA97Y0XyGTUT?=
 =?us-ascii?Q?y5tkHssf03OFsVm0NYgtkrQ/vDwvgKE7z/ps6v/bQ2hsVgYikxfpMACdiJ2D?=
 =?us-ascii?Q?PskYkSqDINZziGiu4cswpnxnbr6bcPALpIdu1ZugwhZ/J/6oEiAg3C0xLzOl?=
 =?us-ascii?Q?Kpcx/X5wvtXbBhKxTPN6r5dEYaQYYnn9Nea9T75LQWbyA48IYFDILNTzgVY2?=
 =?us-ascii?Q?yLm1BvyhsPyQ8CNB+/jNaTpPiG/orr8ks7154vLE5lzrcbex+34oZmfi7kOO?=
 =?us-ascii?Q?leBJrEc8YSv4Vla5BTMD+BLq3GxRyUOnfcQ4DJ4Uzj+Jjgz9lFX63jgpItft?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce96669-4530-4a6b-226d-08dcd5d08691
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2024 21:51:16.9135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SflJ1KZXYvqTsv/GytG9fvrQGA7NAA/KwFfkz5xMveQhWbv9SA9j8e7RxIzyQ6Ilob2VIjjgD41Zy8xaOqH8kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7754

On Sun, 15 Sep 2024 14:31:29 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> This abstraction makes it possible to manipulate the open files for a
> process. The new `File` struct wraps the C `struct file`. When accessing
> it using the smart pointer `ARef<File>`, the pointer will own a
> reference count to the file. When accessing it as `&File`, then the
> reference does not own a refcount, but the borrow checker will ensure
> that the reference count does not hit zero while the `&File` is live.
> 
> Since this is intended to manipulate the open files of a process, we
> introduce an `fget` constructor that corresponds to the C `fget`
> method. In future patches, it will become possible to create a new fd in
> a process and bind it to a `File`. Rust Binder will use these to send
> fds from one process to another.
> 
> We also provide a method for accessing the file's flags. Rust Binder
> will use this to access the flags of the Binder fd to check whether the
> non-blocking flag is set, which affects what the Binder ioctl does.
> 
> This introduces a struct for the EBADF error type, rather than just
> using the Error type directly. This has two advantages:
> * `File::fget` returns a `Result<ARef<File>, BadFdError>`, which the
>   compiler will represent as a single pointer, with null being an error.
>   This is possible because the compiler understands that `BadFdError`
>   has only one possible value, and it also understands that the
>   `ARef<File>` smart pointer is guaranteed non-null.
> * Additionally, we promise to users of the method that the method can
>   only fail with EBADF, which means that they can rely on this promise
>   without having to inspect its implementation.
> That said, there are also two disadvantages:
> * Defining additional error types involves boilerplate.
> * The question mark operator will only utilize the `From` trait once,
>   which prevents you from using the question mark operator on
>   `BadFdError` in methods that return some third error type that the
>   kernel `Error` is convertible into. (However, it works fine in methods
>   that return `Error`.)
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Daniel Xu <dxu@dxuuu.xyz>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  fs/file.c                       |   7 +
>  rust/bindings/bindings_helper.h |   2 +
>  rust/helpers/fs.c               |  12 ++
>  rust/helpers/helpers.c          |   1 +
>  rust/kernel/fs.rs               |   8 +
>  rust/kernel/fs/file.rs          | 375 ++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs              |   1 +
>  7 files changed, 406 insertions(+)

