Return-Path: <linux-fsdevel+bounces-70352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C885BC98278
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 17:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9EC73A32E5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 16:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D67C333721;
	Mon,  1 Dec 2025 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="CR91mVdp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022115.outbound.protection.outlook.com [52.101.96.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949562AE68;
	Mon,  1 Dec 2025 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764604896; cv=fail; b=BgFG3/76Uh/U1BS7c7kAgOGnFJ/1BA9QHSAc8jYldopMCXn52OghLiCgVjfl9jSC8GN6c54hsfyhzefJPB30UhNO+oRaeSciTwKWZJRCc+MKPpD8VbNTG8/X/qlTa0Qhi7HqnE2RftVmBtiXtWdZSRvAj7rRwiaJ2YJmduvdHlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764604896; c=relaxed/simple;
	bh=Rat3SR48NqEMNyGZwx4ZUzm+aWU9ILcNwQj5KJ8Wcgk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EmjYpiRsaPLabsEWs7woH1LSMiVNyH3/aRb3J7xHMjVqStIqthCa3nLifjmgn+m0uKz+t3sw53DTHv1h9OTPQ5/foEiO866rr8WPi3t7KSjqBIi8AySq4r58C7YUqxgqqzZmEKrUMRWOVd3phHhHItwIHqFgVGfL6HBlX/b+ciE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=CR91mVdp; arc=fail smtp.client-ip=52.101.96.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tk239u5kUrnEgGX2LGGbhTSTo1thYlO9L5EdRf4vaSm574At2jnV2EkyBrBmhJ70uCtAseZgrKQV6r3ulUIToobPzvX6g5QK8wOA76LD5rb90H3A4M2JX4mQlZZtsPH0D8EM+mjYUkXoV35bUZxh1P7uHaqiWcpUstYRxX2zdFMJUmUd9hX/iXhU+9+6H7QydZ5OVIcvVTRgCuW+2yERz5VZ6a455qdlw0dyjsWjo7nPHAc6Enbrt8oHJDYLNKv4xG7AENATS2MwuqT6b084XcNbiTNJdE7dBA3WetEQ3SHwjQux5mi9qXuKl2ubb2dPO4B/AfWZcD1jBSLtJlrYhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+Xh0NjmWd6LoBGtG7p8ix71BjVu1+hkOimissFZr6Y=;
 b=h3uSNG2IWofQRUlUMOJcbQ1IUDgTa3UxepyCnOeO0zphNKvMkkTPwfulq1fR5kuSm2Fvq5wHeYRw7LJxKJPNqaw9n/6ijqk2KC13vmswqd38X8SIzTs9QAICzFZa1VEzpkmkiagQUbrW/W32hG+x65DoBr8fc2qYG7a0JXcZcBk/vYFn4+yqJvkz8a1gEXxUuapyakWH/ehM3N7J02RhZSlDJARlS4z2KFjcIYbBS3PhT8DEtmtdc66rsIcmuh6KGynMUF/gkTFRdqphwAlKBznpJpSZFW1JGeoHq7a9VzYfDmyWtYn2nWhE4vMtrtOvl3Dx96EtTD3PpkVBy2xwug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+Xh0NjmWd6LoBGtG7p8ix71BjVu1+hkOimissFZr6Y=;
 b=CR91mVdplPYLhvVnbqad7cfe2QefkefEqhlU+S9vQfw7FbxkmrYfOaWnxIIuNbBgDRJsnQUXWxfdaCUxxe6qoluuJp/No0Yn1KcFWYLc+E7MCSfgSK2a8Ik+ONtA+4rST/Px02XO8ZjMwHYulN5a+QilffOjuW98TMHOIR3ZCU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB2990.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:178::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 16:01:30 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%6]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 16:01:30 +0000
Date: Mon, 1 Dec 2025 16:00:30 +0000
From: Gary Guo <gary@garyguo.net>
To: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Benno Lossin
 <lossin@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth
 Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?=
 <kwilczynski@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn
 <sergeh@kernel.org>, Asahi Lina <lina+kernel@asahilina.net>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-security-module@vger.kernel.org
Subject: Re: [PATCH v13 2/4] rust: `AlwaysRefCounted` is renamed to
 `RefCounted`.
Message-ID: <20251201160030.6956a834.gary@garyguo.net>
In-Reply-To: <20251117-unique-ref-v13-2-b5b243df1250@pm.me>
References: <20251117-unique-ref-v13-0-b5b243df1250@pm.me>
	<20251117-unique-ref-v13-2-b5b243df1250@pm.me>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0377.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::29) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB2990:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e51919-53af-4fc6-0ee7-08de30f2e3ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dQS4zknpLWJ8bvw2F0czGUuMXLjr5FTeTK72rr9fe21KqE7FkAfcqHqUl6J8?=
 =?us-ascii?Q?ppMsjEVYuQIFG9PjCF7N9sZNQxQESKue3T2ZM7w3P6zYUaqLpBz6onwUkid2?=
 =?us-ascii?Q?J0G9BRHtv3kKfzoZGBKhGRj09HVM5L1HHfMUdEY4ZyolxljXuxObaDObeOHD?=
 =?us-ascii?Q?bqV0ZnOwN3GndVad54Qsw6KvzozYBhAK0+e01qrRwcAVa9vmpY8RlHEBygEz?=
 =?us-ascii?Q?JlMqBK8W5/FizFS5QRfgJ544dNYK/ojFp7fRgN0eINDnoBlgqFAZ9Rdmy/nz?=
 =?us-ascii?Q?tZpFANsK57/0dLoqzgfCbk6h6wApqCwx4ZAO6iUKJAumnCE6i0Ujb6/p6V1w?=
 =?us-ascii?Q?yOiI2MszoqtWkfIHwOKD41HC1HcmjWjE+laEzFhUNHlYgHSTuBCYq8U6LWNb?=
 =?us-ascii?Q?Gvedu3sI3Z3/W19pRsPXxKjQLrK04wknG5IeYk7Piinzf8HLn9aNvnNkJLEW?=
 =?us-ascii?Q?U2xihCg68npxeWtSEg8bfqffFtibGdM2eNuPbkBhwBgLpQOZ6qTDDspflXvR?=
 =?us-ascii?Q?B9pZaX5PLUyGdSMIxW/wi2lvh1J642qDX9G5QZlZBw/bkNP04u3/XEpFiFJV?=
 =?us-ascii?Q?QGstGMOn/wnhCYwpKCc5b47dbD2ZkhwQXAaElWO2dpQN9aURXsPzNs42rdiB?=
 =?us-ascii?Q?Pfwb7xmDwgNPxWm8xLemkIPeo3RelxOfC5cvov5QsfQYOTSV1Me9O65P6aTP?=
 =?us-ascii?Q?6ybS3dVedl8M19mlc7zsmAP49JnIXHYQc6XdeR1j9z0UaEDEuwIi42XQt+qU?=
 =?us-ascii?Q?h+9leDZoFYyb+pc+N4W/ries9ukdZtp+KsFPnG2+DpN2kf8KBLqcdP8Hoc/K?=
 =?us-ascii?Q?vI4wCU4Rr17PPxthqVyUeI1nYQQoDFPeD4Blno+5cFCM+668uPystxvmOfmT?=
 =?us-ascii?Q?O97PJ8ayn9WaGYWuSgSorTDYl770Hc7htjvrRbIb5fROaOji8e9GQhyz5N8q?=
 =?us-ascii?Q?/6zf1qfIBxgEj8iTjBoCO3WKC4curHzZENEMQKiPh7xVyeyokeKxQJmJEOAp?=
 =?us-ascii?Q?K/KEpa+WFDn9r2/3wKnnytFjh8FrfJxo2a03g0tD5r92X33AnTMKQYxyedCo?=
 =?us-ascii?Q?/Y+CFYVGqAjuAYbFbimMUeV/iEQThU/FLmdShNS2lf1jSQEese6hDMX7PpSM?=
 =?us-ascii?Q?bW6zK/+ehlyFhG3OY8FCGN+w+jgpgUDXzc/0EQ+6qSNP910WroACPgSRW38E?=
 =?us-ascii?Q?1O8AxWkPPLSDDE/uQYA4YzSLvvw6PvlqTlMAsCRJWOWzcF/vXisYVfoh9IkN?=
 =?us-ascii?Q?K2erMLHVYOzfaHykpMX7VQCgAPEIpnZvDju46/A/im41th6p5Bj4fiTvzF07?=
 =?us-ascii?Q?I1eXeYIoSewjqM9scc3UTWMeZ/gHMzrMim9xz/LyUHzD3hzJjVEyZtzSv9pl?=
 =?us-ascii?Q?mFmCHq+GyMDX5mpWWq5UHYqm2zUerycwr2F6bqkPOX6z3YpHu29ubMUcZiWy?=
 =?us-ascii?Q?ZcdHq8gnyGYSuJJxvzektrCIOuM/BDrN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BeIkBVgVFmyYBSY0ouJA59JWpsYsOhhsOVti14eUmwLpEw88qfiP0a8/3ZUy?=
 =?us-ascii?Q?0dcwHRySrmrCYszC7SLadViLVMo0nw64ZvDZoKoQfqnlw16kHbi+PRt7j8E1?=
 =?us-ascii?Q?XGHVE09a5L8lOlX1kBjnXhnVyuJLtjQDi9HYuCpjotd2P03AeByx5PAineg3?=
 =?us-ascii?Q?8S5HG+5C4hDFlW48pULFalk0mRf2e6kcJs9gqRva0BlXgyY20CkrobGDHGDc?=
 =?us-ascii?Q?PmbLjFA+96FxQVXy8jzfi2/RlBhAls8MCQPpZhr0FFZ2KeKgc+evqwLXPhP1?=
 =?us-ascii?Q?C/D6TU3I6P8lB0e/FvCwhYp4HwOWDQfz6DPNX/NTD7bXwGSyFhY8bCqR4jVs?=
 =?us-ascii?Q?S+0HicXHKU/xpVP0G3rQsunNndGfaSipGCQhWvZ6H9fnHVKYuwSKtbJWsXWV?=
 =?us-ascii?Q?mz4jGnYo0I1mEI7TXXnUiqAbZrI7we8yK/kV5dqiu0feR0owr40Y9T5m49xK?=
 =?us-ascii?Q?NUId0MWrrtNdm/jW4jCqk46aIFEjwwoOKmBlp7QpsYQGbe8mY/MTKcLqV2OU?=
 =?us-ascii?Q?pvJTY2ekxfjGYE6JSIDxUC4knP3c9NgseXGMADPhypB1hf462cf/wzSoAsN9?=
 =?us-ascii?Q?dHPziajcoyJeMctkpwrXQjDkiBSedGUz9VJH84L8q3mIxEPaAbOAlWi0p2UV?=
 =?us-ascii?Q?82Vn4o17WXgDUS+qAKu3m91ltYs2WZOtz1UKEzwk0dud0CrvIAPkarUm3Yw0?=
 =?us-ascii?Q?CdnDZtLThu1tESE4Y6nntkfwrHlf+apxzPj7Sa6E8OJkVOqtNzZsO/kt9U+p?=
 =?us-ascii?Q?WOOwXgxH1c5xjsph1dpK3OvUUpVMea6oEgkrsYiBQ2UVhfhGW+bdOrQ8NLtO?=
 =?us-ascii?Q?JamCPPfBLe3NASLDf7Xn+vpbJHOgO9PmGnxirnyDOCAchQ4YCfTAGmSV1vnz?=
 =?us-ascii?Q?qNC19r9jCtNNNNwq6gaXqrLStkqu2eiIXrFELCah6mAcue0umo4ud4cfs9Ku?=
 =?us-ascii?Q?OTbALvJXFkm+L+Ulq1dDbcouBrHGV17mpmY7IE3erB7CfImfheR8oX+e2IdI?=
 =?us-ascii?Q?M74xAL3JJ1X/O1EyhVgQRKeLbZQBEoSCWE63s+H29GjWRrRmZiuRmHt30iMC?=
 =?us-ascii?Q?s+HgyNHtl9wQpOmr5kok/l+DkABfKlwCPxZJ2sBojMKmY8clABXhYtPqHmyW?=
 =?us-ascii?Q?4sJtgNHli1VvWV9hBoaEkDd6C73qRdL045LN0ROMr7MiUEwMNZz8+IE03gpF?=
 =?us-ascii?Q?3tRfuBzZzo0wRaq5+8LQHMZEmgsAqSclGUl2d1J4O9ICuWqXsYEFBhChlvTe?=
 =?us-ascii?Q?Y8OugfOagC4tnFrpYNaqsn22NOn/RcBU2zvYOTsN8TjiC9IyBbYeQtpdn+n5?=
 =?us-ascii?Q?DQjp5iGC0+J0syPleFIGjANPyNbQonIjwM30flLlM/nXl1sDIgSEX66szVx3?=
 =?us-ascii?Q?+Rq0zNUcQ1y17gNMJDhdmzsBUdrb3M0vZOBxfmtAKGqa4CHFRt5NdzZEHhuo?=
 =?us-ascii?Q?E2IQIILOPUkgr2GXyVU+YogdeNzE2w8W6wVbLuSR4IPcEqpoBJgrZG32D6zd?=
 =?us-ascii?Q?DJDih6WnJIOeMtq/3GuH6/9RvyjwR1LAJPMV5hpIFsqDVj6OzXZnKl+mVhWS?=
 =?us-ascii?Q?cevr0r1y6lZPTVRMXoU1R/5CnVSZ31kkjICO4a4I0GPxtWNXpS4hC7BZbpOz?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e51919-53af-4fc6-0ee7-08de30f2e3ff
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 16:01:29.9920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSBYlATzlV0k8QEuECqafBYn5mtP2v+zqpTk5UNMbi/XIC3rBwrLDIl+trrx/+WBoVu3zRtye6HWBCKlvan8CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2990

On Mon, 17 Nov 2025 10:07:57 +0000
Oliver Mangold <oliver.mangold@pm.me> wrote:

> `AlwaysRefCounted` will become a marker trait to indicate that it is
> allowed to obtain an `ARef<T>` from a `&T`, which cannot be allowed for
> types which are also Ownable.

The message needs a rationale for making the change rather than relying
on the reader to deduce so.

For example:

	There are types where it may both be referenced counted in some
	cases and owned in other. In such cases, obtaining `ARef<T>`
	from `&T` would be unsound as it allows creation of `ARef<T>`
	copy from `&Owned<T>`.

	Therefore, we split `AlwaysRefCounted` into `RefCounted` (which
	`ARef<T>` would require) and a marker trait to indicate that
	the type is always reference counted (and not `Ownable`) so the
	`&T` -> `ARef<T>` conversion is possible.

Best,
Gary

> 
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/auxiliary.rs        |  7 +++++-
>  rust/kernel/block/mq/request.rs | 15 +++++++------
>  rust/kernel/cred.rs             | 13 ++++++++++--
>  rust/kernel/device.rs           | 13 ++++++++----
>  rust/kernel/device/property.rs  |  7 +++++-
>  rust/kernel/drm/device.rs       | 10 ++++++---
>  rust/kernel/drm/gem/mod.rs      | 10 ++++++---
>  rust/kernel/fs/file.rs          | 16 ++++++++++----
>  rust/kernel/mm.rs               | 15 +++++++++----
>  rust/kernel/mm/mmput_async.rs   |  9 ++++++--
>  rust/kernel/opp.rs              | 10 ++++++---
>  rust/kernel/owned.rs            |  2 +-
>  rust/kernel/pci.rs              | 10 ++++++---
>  rust/kernel/pid_namespace.rs    | 12 +++++++++--
>  rust/kernel/platform.rs         |  7 +++++-
>  rust/kernel/sync/aref.rs        | 47 ++++++++++++++++++++++++++---------------
>  rust/kernel/task.rs             | 10 ++++++---
>  rust/kernel/types.rs            |  2 +-
>  18 files changed, 154 insertions(+), 61 deletions(-)

