Return-Path: <linux-fsdevel+bounces-25316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9B194AA82
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 16:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF4C1F20F0F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 14:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A5F81749;
	Wed,  7 Aug 2024 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="FcEdgwCn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021075.outbound.protection.outlook.com [52.101.100.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF157D417;
	Wed,  7 Aug 2024 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041708; cv=fail; b=CeqSmBZHR6T/VAMQ1weYqk4MTCsRagX2XfBVaFdzG1yGdXKFV2LeFfz0gf8Z6NIAsjoLQJMudnuvOK8/S4TPor0UN12+fZ2eaIWxYsHoF5QhLoizhTyoBWIysH8RPb7iX7YeyLBVoTNY93o9ZJqztJsSXbCcQDEymDw6f4P+6Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041708; c=relaxed/simple;
	bh=iNaLTIVlTXmEB+diCaw/qhCUL17V1m9zES2e/DDIMzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sbv0fr72u8qwkOivnKELvviGfL8qqRgPZwHRkOkaLnWH7NkilavL2d53kQ3LQF9c0NfL8l+lHul2egOVR3ELgEExo0f8VVrt1/fKZZ2HyO9SjNOLOqKqi/6Qssn4+GzadmtG8pQkd7SQ9yh9Bgs2RkOGRQFZhFG2CfQ9pv0b/hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=FcEdgwCn; arc=fail smtp.client-ip=52.101.100.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e38aTFyoVkxru0apOyFDyROLl04RzyRS4bdN9KwAmQzcOUcBH32OC4ruHip3AKKWlleEAyRInNYHtZ9Otjf77pqzYVXRuMse9GGKfZGUhn83raV8U8pFBTDDII5L3sRRgmPydIdMem985tT2zPb7H7Uiy0Xk2uNRE7IMHxgjMFz2b6OAeMcQP0mxOZQHpMlnzOeztbEf+1E/VVoTdktFWXJrXzA+KE+hJHR6M1UsTCbXlE+D27pUur3V1FPJ7MJKPLbahi9Xv0vgJBjhLgXv4zUsrj1zkadCgEtUcGy/e5XphXDecLSET3trn5Hz8IUvpvZcQ32eMA0dKMkNzjxcKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgOa729MQ8sEWWy36LgNffvgRn8oGe5Vk2oNNcixsjw=;
 b=VuirWyXE6ayTdka8PWgxYuOm72MHt4sytxTeDygKpTFePUNKLwBWo/Gt5udVti6SPEMaAF1fcYlvTIWu3TGQgyIGNCB0Toy2Njbpujt5ywO7r7PfPKaAyeupOjtss1Fj9ptdZV9EPuZJmEixbAGl4wxLbRXW+aUe+dUuIXn2HNA5cqeECVr2RFyUjMnzvTsJpeW6ANN84cZyYXnwkV7AqEcKlOgpFPR3/jwZ2WoaW03zOHjPDuyHMvQgAwM4PG6BB7oWp0VmbVehGS2N2GgIA7i6b/FeN4q6l8WMacZH1Vx/ZpzbLUdDY5EOi0fKI94YNZCG5lmpRJsCL5faqXVadA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgOa729MQ8sEWWy36LgNffvgRn8oGe5Vk2oNNcixsjw=;
 b=FcEdgwCnOuCpwYhXphVbi/0muHmDQ1ZtnPCZC3O2wazBCcWxDMWmHSsWmxENobHupXZ1CSZtXk2M/8oaYPWz4dUXq92vimk1KTf5e3t5Se6+5wau3lZZvUQTRrZVc5/XYFQ+FPMj+kky6KPewt3xOchpZZzmXXZDI9gXaPiT/SU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB7234.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:329::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 14:41:43 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%7]) with mapi id 15.20.7849.008; Wed, 7 Aug 2024
 14:41:42 +0000
Date: Wed, 7 Aug 2024 15:41:40 +0100
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
Subject: Re: [PATCH v8 2/8] rust: task: add `Task::current_raw`
Message-ID: <20240807154140.6ea8cb89@eugeo>
In-Reply-To: <20240725-alice-file-v8-2-55a2e80deaa8@google.com>
References: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
	<20240725-alice-file-v8-2-55a2e80deaa8@google.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0263.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::35) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c30e08f-e3f9-455e-b26a-08dcb6ef0de8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ET56UZuYdlGVlpdXtK3NQCK4/iQpmTs36IxtnepdzwM/9LnawvgCS4NxWHDX?=
 =?us-ascii?Q?X9cl1+tRIcKCKY0CEY9gzum/aQwZ0XVd0+9SJhKBS7VrxwKN4bGI1WgsJ4YL?=
 =?us-ascii?Q?4DNT0lZb/2I/LvV3fOBg6hXvQpGAk3wtgvy38f0nlQNwUH0MuFqh++UKhoAI?=
 =?us-ascii?Q?ghcylQLqQGQ3w6pzaEcY+RQTyYxxD6FxzJSL6sgIw3VOiWdijchdHwIcve9p?=
 =?us-ascii?Q?/barNz0H8sJ7h/k1SXCwwQw5eHKcAwr2BKYevCVYpJrAEWaKJcCgJrRtvjO9?=
 =?us-ascii?Q?o+rvjumMBpmqyXFXyZX0W+EopWWKfWwNaACkkFOE9eYfQ08w8TmloJH9ZHCQ?=
 =?us-ascii?Q?yQ4G+65HpJH+Uphv8UG8+SXEkZ3rs5Drz/MxUNJTU4k+Z9qVLTHSOiYArcCQ?=
 =?us-ascii?Q?OSa9PgDBP83IzxTrPSbwM2RPG6DQ18AS7PK6+eoKjC6ur788NlemLTYNNmed?=
 =?us-ascii?Q?eAcGA7D5FmVf32nVHv7AjIcdeNPJYR4nXfDlb8RnOd5osRLgbwZd8TEMJDYR?=
 =?us-ascii?Q?8EW1QS/2eGK0RgS25NObrs7Z/rlaw4Vsv5INAvINMZvx+dyGT7gz/qDD9xex?=
 =?us-ascii?Q?jZpSb8lg9JExaiE78X267RZM6N7BnlNcOIxoma3KozhyhThp4AlU0TW3Ln2l?=
 =?us-ascii?Q?sfbzVLtHlvO8g9vGwS6WjJ7IcRNxQC7O51w4/vYuk4rmQSLt6I13Wjjyu0r0?=
 =?us-ascii?Q?su61Pq/CDgKOWHvdsI+ZiSrH1dqbe7uvCGo8D3pS0ox+egLqTe3rXURoAi0+?=
 =?us-ascii?Q?irIXA/R1DlG57kEDhileVPxMvTcDIlEgFvWQu6rT8msFX9EbjEDwGyUkl0Pq?=
 =?us-ascii?Q?+OZeQ552GngA8xB54XhpGW367IhfkVjDKvrkmMt1VQYB9Onro/LV2N9RzQok?=
 =?us-ascii?Q?D5DxbgduD/5bhY2EOKTcDMSE/PQieZ2QVj3CGt3r0CqnfXIC+i6PnX2YD0W9?=
 =?us-ascii?Q?8+JZ0C0tx46IoEr1v9lgxEmdZulyh+lOVqo+UQ8wTtLd3B3V7HtjFSTSRiLW?=
 =?us-ascii?Q?U644U37BStkapj3hxyLHvRdNU/A05J9oWkG4OOSTfhhxC7D8hGHPfbY4+aXn?=
 =?us-ascii?Q?xp6KiK57KrM6f0+HmIrqLemGoNoAJrsetS2jdVhWy6JosWOOJSW6XzZlWhzg?=
 =?us-ascii?Q?bqWcfqiVTFFHz0zmUL7zCa8QsI2V84dipdIMZZOKn6nPy1Y/7wZ9tmVbF4UK?=
 =?us-ascii?Q?9br+sGKJS/m6XXIhygomZ7YszUamvnTobq+sPHAmsn6AimU0cLj/8kqX+26a?=
 =?us-ascii?Q?g5tW4UEcl3d+psMCWr4WS9+/lMcOwWfLRlgwgRM7gU7DNJsqRB67efv+IkiL?=
 =?us-ascii?Q?rpM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CVMBHyse6WecBAydK9MzOFx37KUrb5VwbfL423G9UhFm+r3Z9doZBHXTgS15?=
 =?us-ascii?Q?CsnhuuNxjQzsOhJfohj0s2poV2mve8lbZt0Afwbbs8H4BjqDD1VhFe1b7GmJ?=
 =?us-ascii?Q?VcMdgZQd2NkEh6/jkBL19W9+4fA0fwGuo2DWkUsc8udk7kckvTaksiMtd59w?=
 =?us-ascii?Q?2ht6ZhlfPFmDO0+KhYGikMDaGkrFGQT68sABzCQ1ggYhtx3kP3ESEOJpYR7g?=
 =?us-ascii?Q?DQnP9eQ1mAAOruU+sVd5D7pq4CipK4x2FmTbWPJTMuCLOa13OAVUZQb8oBNu?=
 =?us-ascii?Q?gQWxdE+gBaqFvZC44ic1NY8+sYbZo/el1eNLNGWgV3K7yUFWS/3xxhnwexTy?=
 =?us-ascii?Q?avLQfYqAywzhYwye4jgraOX3aoP2js9Pb5ck6idXwQQ9UyumQTrFeKyn/ezR?=
 =?us-ascii?Q?Jmf4kU6ZejDMnGe7sML20TKTru3iNIdmY0FY0N3a9SX32W+CMOPI+mBY4ezK?=
 =?us-ascii?Q?QyfkKwx2Mg5WTLyqWi/5zu9iQzf6AjLcD3qO6jexEA203h34OdVgC0WWvcU2?=
 =?us-ascii?Q?InfGD1TWbUXWsZVhRBf+ZXBivUd/59CUCh5TstrfMqMQqV+vqToWTYqJuyi8?=
 =?us-ascii?Q?Yvig+CeM6EpHYBJ8m2N0X6JXFnNYFV9wPmshfcPZZLsm4lSO82vvSpJvnceR?=
 =?us-ascii?Q?1znEVITIsyE0lzEHDJkcYBNLKiKKaJgFjc0uCEp8NZO5fH+JW/fXjcWW1ymP?=
 =?us-ascii?Q?525oedGitu4Xscw3CGi185L3MBQJ1xV4oml/WwFc2TXMNIPCAku6N2919jml?=
 =?us-ascii?Q?vtqYuUQPRRb60s88jE+L9UJgRsLdNW/3LxfgLMBKnAW2P+W3zB14b4B3dQUi?=
 =?us-ascii?Q?PorHholDheSwnSS5HKSpfHlUBftczUg4JLz5njnn56w5Gw8xpVU5jZ5XcnRp?=
 =?us-ascii?Q?8tXj//VZbu07KGZpaccUqsj4ihmoYiFY60bUNSzxUpcaNi6f74SP69lutw3d?=
 =?us-ascii?Q?E9OoNhQQaf/El86ZOertIlsl13nA9fVjDdoek81p+x6oc+my/UgK8mra2jC1?=
 =?us-ascii?Q?eFlVBv9qrjfdqMZ4DNblCZuHwClz855kVWTFm18KVGq5BsjGLLQJ+Ch1/jj0?=
 =?us-ascii?Q?2ZFOZdboIO82PDl0ZZvQRUm9ZaNL42qsYrlzZezA+SyuIr8D+e995BUnh9Yi?=
 =?us-ascii?Q?BxXkvuAhYZqRAktLJX/0sx/3KFX8sEoIhBqqHrRipHVc9eUfSeLw/O0zEGDk?=
 =?us-ascii?Q?0DOYyxayFziWuOK/YiafFup9BJEegL/5fznwN9i9uwp0oe4MpP8ym70hQW2f?=
 =?us-ascii?Q?xIIVdAUNsjn4QQCEecZzMHyJrXz9IjCu7fQzQgD/uysOYu6wxQQ3dqIOs7vm?=
 =?us-ascii?Q?/dFQJuU4o+GHShKdIt9EFWOwBqf6OuJMgATCWnHIwogkHmYPJFZmQC8frMgW?=
 =?us-ascii?Q?tVJjwwLNnISTEKCv8JETtJtGl2k1780GmKvM+85mDqXDXyQXDFQwCxQd2xq9?=
 =?us-ascii?Q?hWz7bTpuX6K0EMMCWEM8bIyJDbZIrVvfMIVy21TU21utjykmDez7i6ZVjjs8?=
 =?us-ascii?Q?3mui1sAbFPY8GitwfvzJ1wDKW2J/aob0Ot01nuxGUin7B97L4UtuFQ2DJNQy?=
 =?us-ascii?Q?7QPrh3jjzvPLJJY2A8nrvyY2TwJNSi2Ehig10aF5?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c30e08f-e3f9-455e-b26a-08dcb6ef0de8
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 14:41:42.8334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tg8JFGZ/W91+mz4pOw0z7hn+uQc/sMcGUZ81G+wB6b3CKmGK8PulZdis9XV608E+xxixlvyGxkAwjLgUtNpenw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB7234

On Thu, 25 Jul 2024 14:27:35 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> Introduces a safe function for getting a raw pointer to the current
> task.
> 
> When writing bindings that need to access the current task, it is often
> more convenient to call a method that directly returns a raw pointer
> than to use the existing `Task::current` method. However, the only way
> to do that is `bindings::get_current()` which is unsafe since it calls
> into C. By introducing `Task::current_raw()`, it becomes possible to
> obtain a pointer to the current task without using unsafe.
> 
> Link: https://lore.kernel.org/all/CAH5fLgjT48X-zYtidv31mox3C4_Ogoo_2cBOCmX0Ang3tAgGHA@mail.gmail.com/
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/task.rs | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

