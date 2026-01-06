Return-Path: <linux-fsdevel+bounces-72536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 070D7CFAD49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 20:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2CB330570B4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 19:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0352D5926;
	Tue,  6 Jan 2026 18:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="SZlW3BZU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020126.outbound.protection.outlook.com [52.101.196.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B56724679C;
	Tue,  6 Jan 2026 18:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767723129; cv=fail; b=c7nMODCt4XtBC0TPOYafDM1BokwMc8Nt0fcUvm7wzwQJbTdk3uTmFWTy6velG1sfp6X8wXTyH2U7VM40YGK3ly8lMIxZ138GYdBYI+GtVR7f6KyPeUNy/jnfc5ItmUc8WGVRI/Vtaoki0c7I4Ha9geCFhXIU2oXyJjAgr4EcHYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767723129; c=relaxed/simple;
	bh=zqzlBgY/Qpe9j0f9c2xmCzWJOyQN6FjJROKtSg262BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bCCrI5F2+N4C639WLMA5CuFLpxIHzgPugiMfuGt4R3zfCV2fF3nuVWNKfmeY449Y02l7L33SG48KvZLXX/HF/F4T+9sTBMKJVTPUKY9i3LhlUmOsk+HMSYoi9eTBvczjMKOOyxHEFunF3rSf4vCtpbaQ3rRK1jyP6nOwI70jBdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=SZlW3BZU; arc=fail smtp.client-ip=52.101.196.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGq/I/vs1jFN/oL8CA4OX8w/mWBS24MkQVXWlMW1EfuiJDyb6WjJg/PPx03FZMhMQ20z9L8RbWPk8PJ+U6itKLd3tF32ghXAu7RKqPPZaj8wVtNlMCyW582xceA9xiz4mjU168xi0j/6Gby3Xl91saEv1MFRbtFF/J6QeBUP27vZFY3k6/qBe0joqxa6VVpRTjYQPaJmv8WrYB4XrD080G92/YHuPJYBV9Tmpq8JZxJyKsaHPbgtMCgR8re4h39StfdS/xFIr86tIMJDM+mfeV7XelX/G+MlmyVc/IJrEddhc1aK2D55kUAb8XmBOteNYiuJTKE7QN1F9UaekT5ZQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdWrlpQ3QbwVHXiDRsc9/jEM80fQtguMJ0OiT55iMPw=;
 b=H7pFcq0+hD4uD0u1+BFcHQIJfb02Z8zFA7YA/USIK5wFX/guMjF0D3srLuG4AUwHwGTKXaYG3ri7i6CJTIK3JNoLsYpwNV0nxjjswy0ZPuZILYY+MJHE44GQqg/VAoz3ddYzkhYOon6VTUqFvQMUDIgRb5vNYMAhwKNPHXXC5ca2DqK0uq++bulyW8W2MBJloIjEDuvj6Ckq0ZOZuyVczQXTw4g0odxblJIGZZPxE6k+Gz4Zggs0i97Tk7GbkC0Qpx+czJ8zozblvz+vcu3lzMKhLOiuTZkLqQYxMQmxidaxh6Kg9FziE+CpnCdBQFTk2OvrTHwd5cuuSW51SWjevQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdWrlpQ3QbwVHXiDRsc9/jEM80fQtguMJ0OiT55iMPw=;
 b=SZlW3BZUtQBOBC+t/0FjHVPlzpOqmgx1rvJA9CK0RAcaxhYUs4z0hM+4NF2b/IiaFcLD1UIP3d/FAJxYqCTmr2wKbpSGe/xkppA4+ZKKwwS+8GlfvLrdF6M4Brc8QFncbzXBe/t45g9xWeaL66c2s86sa27OKMPYZ1I94O7/H98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO3P265MB2314.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:107::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 18:12:04 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a825:7b26:a82f:d041]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a825:7b26:a82f:d041%6]) with mapi id 15.20.9499.002; Tue, 6 Jan 2026
 18:12:04 +0000
Date: Tue, 6 Jan 2026 18:12:01 +0000
From: Gary Guo <gary@garyguo.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
 Will Deacon <will@kernel.org>, Richard Henderson
 <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, Magnus
 Lindholm <linmag7@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?B?QmrDtnJu?= Roy Baron
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
Message-ID: <20260106181201.22806712.gary@garyguo.net>
In-Reply-To: <20260106124326.GY3707891@noisy.programming.kicks-ass.net>
References: <20251231-rwonce-v1-0-702a10b85278@google.com>
	<20251231-rwonce-v1-3-702a10b85278@google.com>
	<20260106124326.GY3707891@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0410.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::19) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|LO3P265MB2314:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ab392f-8223-4454-37fc-08de4d4f1869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L1RI7WBlj0366OI61N9sEhBWitarMUW+iMa0IbK0jB4wwOuKqrMWo0mh3cqK?=
 =?us-ascii?Q?5FxLm8TJ0kmHX7EOVSQg0jZQ9E3qMgAd8ziL9GxdfnNvoBdLOKUTAE2Pb+/F?=
 =?us-ascii?Q?n8byV0MnGMmcOW7iA8lC3tzG9TniUkOXePe2bWa/mi5ClubiceostfRpEBu8?=
 =?us-ascii?Q?Se+jSt+NFsBf9urAlWkA25B9EzIxvn1RIKBTrL4L5qRp/rAOXbrNF65QQQlC?=
 =?us-ascii?Q?8O/A1ajS+MFDubvgR43HG+tFFEPkNoYE5Hv6d992+lf+3ExHaTnTDpZlR9vr?=
 =?us-ascii?Q?YPejXifh6157ZnBiuhXt0xZqU+PWGjouJ4TkJSqvpe9M+FymYuxwQZpdw8lt?=
 =?us-ascii?Q?r48cKsDreqWKQm1dYIQixKw/KbLbzHMuu7oz+oFAoPezBX/oAVdcHKUUlkD2?=
 =?us-ascii?Q?PbsufUa7LOXddo/zqWL5HzB/US3kPm6oU7Dc/BX4xbgaYp2974dfeQdR4uLD?=
 =?us-ascii?Q?kOqhf7XKo7L66tF2uz/IjWG1WZr2/nKKh8CpoWay1JMASOXkOhtj3xqofJQo?=
 =?us-ascii?Q?Lov2Hd0RiszGlPlPPDeUpbX/TefuImwodhi/f9KBgcC02QwcaEXwOqKc7pnz?=
 =?us-ascii?Q?jBk90aeddi/IMKH0nlIduQHEZ5ZYAwvZE0QUU6buZnn/tLZz6DjP5Z+JfgsO?=
 =?us-ascii?Q?OloIrLTdh+uEbtdLDeq0LJCxoBDyNKUnuOi8MG0vyp0OLA+BN3ZHNS0rULjB?=
 =?us-ascii?Q?QsE9Osf3eCgi7Sqvislnqgv/TcjZJYydITdrWb5+nh27Kauw2lONorhQNcR0?=
 =?us-ascii?Q?63B8hogZSfzfRGK1QINJRTQaBFh7dXys012UYPtbNY+nu0HxvTNONSeXai6f?=
 =?us-ascii?Q?z3yHrtEUC3+Q8nDQTYyT0uMDKJwZtwe7L/H7KdYahdOQLppOLzz9nPA0JkRK?=
 =?us-ascii?Q?l6thfhj0zoikC97bdk2Ywpr4eWi/SYmKft0Ih+I/ve+V54zn/lKAbCqVA6FX?=
 =?us-ascii?Q?fq7+S9KfMcwzmiZN+tE//U4Pl3vbUs65gFdahx9XbArW+stqsI1F9xox1BYt?=
 =?us-ascii?Q?3NM1fTLqOoU7NQN8z2nrcexVwjxaPFWBcA03MaG8qY8aGkjsOchuVzi4pCNB?=
 =?us-ascii?Q?0SE0boZ+iiDUJuEUB+oDJPsiqzOS2EChAJGK2FJH9OK50cuksTByoOh4YvIe?=
 =?us-ascii?Q?cizOGm7CtwMi4mOTSdf5+KNdASfIl9SooLW6EBauePYYQ682p5agR21SFlFq?=
 =?us-ascii?Q?9k3E3yxu+ZwXPd6P+u7wI4ly/d6wiEIBA7BqJluQ9DeiYzuGt9NCTx+cMsxp?=
 =?us-ascii?Q?QZdwbdmwu3ypG0ERxneVdcse7YBPo/0GASqZCz0pY0svkRsNDXCA61Lh+Op8?=
 =?us-ascii?Q?WBx1eqsDiLYW5dnWru7vWuRkp0mMLKsfjDxpcRuhY6zDQQ472+sbacKNbD/g?=
 =?us-ascii?Q?PonLUSqWUoV1b7dsbMh1xrl2TYHo4inaoKrm817m2+4U3jxfvvbsgW1OKEyp?=
 =?us-ascii?Q?JSqWj/pKC+ov0y7/9yAuHwkPa7esNrLZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?80bCHhjEYhwXoKpKUoj9dguCVFc34y0fCW1XbgchN1ok+iXNILA00iUIV1s6?=
 =?us-ascii?Q?jy1+kpYrxcyVSJcSLQMKshNZlcZ8dCZhFgG68SwlZ96JVSHgUhG0HBCGPO8W?=
 =?us-ascii?Q?m9u4NYcXcvxGT3wxXxYgAlopsB70r3K6dPmHXwqCgghtR3AUaBohGGyMp13+?=
 =?us-ascii?Q?Sz53udiWqRWL20nrO3JZgTsnq7HEhHAQqc0EWUedOrN9BaV7sLF+NP3xTMh8?=
 =?us-ascii?Q?afoCIf0v349XKk8TG8IGxf0JU6Ly3U5vyudatbhbZ4j/IhAnt/oCU/wqMIoj?=
 =?us-ascii?Q?Ryo0JupJidngjX2txT49SaPhEDKbeqZOUFbqZplP1mckeYiS+dkQb1DMtzaM?=
 =?us-ascii?Q?Yj7SfuOavjHBSX+3DEHy5hh56JoOAThCdywL7Npvh9HT1zdqYw0rDrFxpuO2?=
 =?us-ascii?Q?0xw1A1LdyTAXY2FYuIK5SuM88uZ7NyiJqlV58w7MASsz5FyOnSjJcXlnWa9H?=
 =?us-ascii?Q?RFQjubK7tDGPt8WlKpCmd/xGoKC4/NX39N608LXLmUzfBOM2l9AZByWtPH4S?=
 =?us-ascii?Q?7MNAPYQCUtWDT6TAh8oO+JLZjJh29oH9flsZH3FL8oCryOvV7J2Uid+cdILn?=
 =?us-ascii?Q?K5wdAI9jrsDT+bT20+WxMgcYWh7GlFT53vcjSW5nOBvH8YXAnU7fcKgKwaXs?=
 =?us-ascii?Q?svWdGesDiu5k0vj05K8ie/aKjZ/8703pNxuq7TeKsDQHF1/V/aklutShDE35?=
 =?us-ascii?Q?gt1R91N3ybkMH2yw7XB8rlm10krHFId2TmrzBiL2vkB4PnmPbr7Xt/dWHNoW?=
 =?us-ascii?Q?AW7miEsTICajC0JreQNgtQabvh6F+tMEpz9ZHpudoR04lA6FKuRR6TDVutzT?=
 =?us-ascii?Q?UEBl2STn47H0EPWGZ9G22Eekg0yqU1I8CIt5c9/UfJN1ItIe7DMcOqnKxLMR?=
 =?us-ascii?Q?G95PYrMiE7M+/BSJRpgqRcX6SuDGzUoQRUuNaBdYgAhf+4y3Nt0SDcWp9ELd?=
 =?us-ascii?Q?Qp7t0EQ7TYd3AyOJNj6LOb61rylv/qzHYDqnWpKVbMuwVKtdksVZRDDWq8N9?=
 =?us-ascii?Q?RGbOjD055UtMJNony3xaIcrgy3dkBj93jvoWitjbySDopPZoX/RxIc0CwJwo?=
 =?us-ascii?Q?P+Q0rKoLf/Vj74YWdeCKYoaw0XepD/PJqOB/hifv9Me3n67fGgerpsBbKmc1?=
 =?us-ascii?Q?KmQDO1CSLDBhpdDNvWVK/9JOE7XEvzUgcbwOZt7m8H4Sjs9GWXgyxcCfonya?=
 =?us-ascii?Q?StqDXWgFYcXnqB2FRRzzNhk59UzVgMD2aFKU1oKRIvP8ggmff3oMqvR/0SXy?=
 =?us-ascii?Q?P+k0Xh21HhhGqpSdoursGA3IvG5MPJCc0yHO4fBSy/vYxmygtq9mhU6sRrLr?=
 =?us-ascii?Q?aNyzsCDm09PAGL8Y76skb3L04N32JGh2meHcRXc9sZ/o7ubXCtVYSJxVvgrv?=
 =?us-ascii?Q?pnYEO+P7ZrEdGhtLozQSHjbkmaPrhSu6jQ47LNB1KFq7p6NQoNs/dd1IWL6o?=
 =?us-ascii?Q?z+U7rSDXzEyywOjbmwy/MK2R92sqSyRsVPqk7PTOpiBsexpW8aS5La1u8cbg?=
 =?us-ascii?Q?6XcOIh8+D1hBShbTtNSz4GKJ8TWBfhj/9feJwfhZ7pK/cdWOht0OfN7hK7ap?=
 =?us-ascii?Q?+lwcMmQMba8e+jeFgAV8CvsYa+SJOMkzchOHknj8yn/GccjR6y05TwP5Oiw4?=
 =?us-ascii?Q?rQQLOylN76iP+Q6ohKTVHKhD7yRyuvCEoU66RLrcKfmVgPfB4FTqhS6tWzHK?=
 =?us-ascii?Q?McIhfFaqxlXNTWCH2O9+qNjxyWaBYSjPlj2DyBnE8+FT0vqiboNgB7DWiAe8?=
 =?us-ascii?Q?yKNkkD9zZA=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ab392f-8223-4454-37fc-08de4d4f1869
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 18:12:04.2054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgZvlm+WmWYn43tHc4BVvAgrtz13X+I7oo7hafKr2gyXojXvpg4Rg3UmXq9a4tl2vVFO1ozK2zq0ADXJStPCtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB2314

On Tue, 6 Jan 2026 13:43:26 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Dec 31, 2025 at 12:22:27PM +0000, Alice Ryhl wrote:
> > Normally it is undefined behavior for a bool to take any value other
> > than 0 or 1. However, in the case of READ_ONCE(some_bool) is used, this
> > UB seems dangerous and unnecessary. I can easily imagine some Rust code
> > that looks like this:
> > 
> > 	if READ_ONCE(&raw const (*my_c_struct).my_bool_field) {
> > 	    ...
> > 	}
> > 
> > And by making an analogy to what the equivalent C code is, anyone
> > writing this probably just meant to treat any non-zero value as true.
> > 
> > For WRITE_ONCE no special logic is required.
> > 
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/kernel/sync/rwonce.rs | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/rust/kernel/sync/rwonce.rs b/rust/kernel/sync/rwonce.rs
> > index a1660e43c9ef94011812d1816713cf031a73de1d..73477f53131926996614df573b2d50fff98e624f 100644
> > --- a/rust/kernel/sync/rwonce.rs
> > +++ b/rust/kernel/sync/rwonce.rs
> > @@ -163,6 +163,7 @@ unsafe fn write_once(ptr: *mut Self, val: Self) {
> >  // sizes, so picking the wrong helper should lead to a build error.
> >  
> >  impl_rw_once_type! {
> > +    bool, read_once_bool, write_once_1;
> >      u8,   read_once_1, write_once_1;
> >      i8,   read_once_1, write_once_1;
> >      u16,  read_once_2, write_once_2;
> > @@ -186,3 +187,21 @@ unsafe fn write_once(ptr: *mut Self, val: Self) {
> >      usize, read_once_8, write_once_8;
> >      isize, read_once_8, write_once_8;
> >  }
> > +
> > +/// Read an integer as a boolean once.
> > +///
> > +/// Returns `true` if the value behind the pointer is non-zero. Otherwise returns `false`.
> > +///
> > +/// # Safety
> > +///
> > +/// It must be safe to `READ_ONCE` the `ptr` with type `u8`.
> > +#[inline(always)]
> > +#[track_caller]
> > +unsafe fn read_once_bool(ptr: *const bool) -> bool {
> > +    // Implement `read_once_bool` in terms of `read_once_1`. The arch-specific logic is inside
> > +    // of `read_once_1`.
> > +    //
> > +    // SAFETY: It is safe to `READ_ONCE` the `ptr` with type `u8`.
> > +    let byte = unsafe { read_once_1(ptr.cast::<u8>()) };
> > +    byte != 0u8
> > +}  
> 
> Does this hardcode that sizeof(_Bool) == 1? There are ABIs where this is
> not the case.

Hi Peter,

Do you have a concrete example on which ABI/arch this is not true?

I know that the C spec doesn't mandate _Bool and char are of the same size
but we have tons of assumptions that is not guaranteed by standard C..

Best,
Gary


