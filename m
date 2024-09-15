Return-Path: <linux-fsdevel+bounces-29420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D2497995C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 00:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA4EAB209E9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 22:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F82773501;
	Sun, 15 Sep 2024 22:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="LTpykR8e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2111.outbound.protection.outlook.com [40.107.121.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29A81EB35;
	Sun, 15 Sep 2024 22:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726437747; cv=fail; b=ac4u5uo3IDYduikHhqmXF3ThSSQmtbTuvCC8Jyo7d5CNbwaE8MIDogYRrDZyh8NXOjMLkhG3bhgnl7TLsM1ki8WzuzA4q5IuK3qu0hwsa0hAWmPaoQr0I/Q5FenvLY/9EIuGxGNlDhWquHrJoyjDS89d5XSikbvfdriPQHdsMIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726437747; c=relaxed/simple;
	bh=FU+H7Lhh61xcd18dSMDLWOprgfYnpMQKFrCh5wNbIyY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tgd3sS3RZmFmz/Q+E4HmhmT7ZB1h+szzZixyYkW48MXsy3ZXbMXXGB0kRjDD4mJEpH4uyM3SGXrGCGqOEYAo/KS8CA7Cpxr7hg/dmln60qjr408nvfq3jNhPLTSZt76Wvux3kkO7zKFSXIBB8+/+Ziwwom/KgsFRQa5mK/CXMBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=LTpykR8e; arc=fail smtp.client-ip=40.107.121.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luKUCS1aUV74ke7rLr3LxNf6hrd8U9lBFPdrIUT6Su5CXkFkGkIDX6DJYinRe5dxJc4oGwwaGdt7QUtnZH66zo7V8LFq51Crs8VO36TdA7Z3eB3QHStp9LAyo7K97EoALnUBzV1H55ClL1YwzeWLyRIE+gmivNl3GVviALj/Via1o0IfxZf84cwp/jr2KT33+2Fmd06BO8ONC3LRlwKP29EdYMy+PBJpuwmDBn5Znx80nz6RQt8Htj58nQ5WkhsSvNKe4z899T2z4qRpDXye9KToSVKkK1bbILuwOtc9F5S1qL0bOrccQ7i04PpY2aFIBvUV7MBNowLQCHDFyYiXng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siqjIHcSvl07TAVhglR/QoIbUvH/2tsd3r/h9huPzew=;
 b=EDspi+8IAaD7YvLZ7qOH9sEg8iIaeHFKwQbAzheJ9snNlmfa7qpu7+JvaWb++MS9uiwllawcdArpIv6jSSE4JdTW5vB3KcwX3IoGYjnUiPmrrBOcZAfXI8Yjv1ssPfguAnHR/a5x52ykQ9q8O/CKWcQvXPXllJNGnc+aABXrVnEn+Q3PAkjqozK8rNAfE+91M40vpcnvVNkDlSmAtXlOZuLCbISnzeL9luaKB/BSPawkpx/PNoT5KUg3uFctBulzJxl/Sd4yWKFKYYDCYO84DF0VKLNTR9AOdloQ/j5I4InRTcXknBpzZlaS/vla1GVT16WHX/Fpp9/WzkOkir1ohA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siqjIHcSvl07TAVhglR/QoIbUvH/2tsd3r/h9huPzew=;
 b=LTpykR8eZyaNCaRUbMnu4615clDoW3F6KjfS+T6gIB/O+5cFsKqRD3he9lPgkFt8Z+8z1sfCjPmlONQ/JPTbcN6NZeEBw4awmkfiNksMcZbJArczbPMqqB/4/sdCODcsKWYoALB4O/EgWmKEPbBnYSiGkmQKO7S/sr+/J0XIAnk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB3086.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:17d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Sun, 15 Sep
 2024 22:02:16 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.7962.022; Sun, 15 Sep 2024
 22:02:16 +0000
Date: Sun, 15 Sep 2024 23:02:11 +0100
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
Subject: Re: [PATCH v10 7/8] rust: file: add `Kuid` wrapper
Message-ID: <20240915230211.420f48a9.gary@garyguo.net>
In-Reply-To: <20240915-alice-file-v10-7-88484f7a3dcf@google.com>
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
	<20240915-alice-file-v10-7-88484f7a3dcf@google.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0038.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::7) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB3086:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bab60a5-32de-4c04-8138-08dcd5d20fb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+EGMFVMzNxL10g8RHhKr9n9iRGjRxiFaDjdxdW0lQ648RfFsZ4poN5ZJVBp4?=
 =?us-ascii?Q?mYdTpu68Mosd4frKV8GKf5w20Kll3pJO3NAEUPKECYSdATix+JofsfFW3m12?=
 =?us-ascii?Q?wn2HHfNhI1RhuSJf/RZNrgIoPqbJDdrfJdtJdC6J4KKhTbrH8ZM+58rMf22d?=
 =?us-ascii?Q?xdnvD5RRVAvtz1QkKj8VCEtv+a/lf7Evxj6TWbLyNfJpmi/3deozT62/Rzgm?=
 =?us-ascii?Q?9lFsJEfEW3cmxJ38WXnLh9szQD2+vspK2QRSRuUHgLj0+FJfPWu3lVVV9LEI?=
 =?us-ascii?Q?lZbm4/pe6yjKbKUubhDEkwVVUHroOvEGpOs7u3BO7zlBQA0yTDhWNXcjAYZu?=
 =?us-ascii?Q?DyfAJ6nJ3WDvTuQXD8oEPb22loEGRlHQT2nIZ4/5/idRNuMszI6mptJa7TWn?=
 =?us-ascii?Q?4+5RAeAuZFAuZSg2w+9qz5TPl05tqkxKalRKi5hMe/Htdrt7telDWgNOCUu3?=
 =?us-ascii?Q?lqp83Y3e6IYx/gPlhOUBDHDRIlfbh57CiR8McdK6HHX+VrWRszPSsIxDverI?=
 =?us-ascii?Q?EXOp/Km7Wje9ehyUzCdT8SBs8rD77C/6otSG9ZSd0gFH8xmttuNR7Shq8uj2?=
 =?us-ascii?Q?dEEU16NaFg8/zuOChYEVevcJuHBHRwqj2KuFmt69c8sfD4OQfyfVOMcU1XqT?=
 =?us-ascii?Q?6LLzrOSYBHmIOZOpL6gkzRcz9ZkXqY58fkC3VZhxRRNmO19PbeIWf3xKueQD?=
 =?us-ascii?Q?RTuGcnRBgOONGJBrhobW5wyu8JTDzHWV7BCv9CozrVkgAy3de9UvVvI+MlU9?=
 =?us-ascii?Q?+K+qV20ZyG0LPNX/y/PcZRvxKtSkLWksCvfjsqevZ4+zIxZMKgSX4engK1mR?=
 =?us-ascii?Q?sjT9l0RSDXmm4SYx2bnUkQET7pQ1S4uuIHXO2fBVTqLxNMJPfiahHL5nJG/X?=
 =?us-ascii?Q?554qmwATalD2xONlcpsoIlkb8HLfDRuHpp9Tl4WFBn4GS2Hro8wxeOBCcLg/?=
 =?us-ascii?Q?li5zT42I/k5e7MdW7ZKbxShCNgKxFYcfIm88iEESCMCNE8tIFdd3qkzi4/N+?=
 =?us-ascii?Q?UHH9R7XM8Jlj3nnMYx3Lhtz8HjLj8S/lAecAe351NIinKAz+Q37rUhL28+g+?=
 =?us-ascii?Q?WljkRSUaze1vpIGrxzTWXuDQw9sfr9rEfrAMQoOXbiLVTIkhgUNGBk/oQbDr?=
 =?us-ascii?Q?Jv2moj/XUj64GzIq9fZtogxy48lLgoxVO3Cp5idRjWj4b6g1QIcmWIP8Y8cL?=
 =?us-ascii?Q?5UODF2bW49pc2ZterKYnqyzCHncIUQRowuUsv/RkKCfmz0QPUkVKjO/mh60K?=
 =?us-ascii?Q?55iiZq+/UOHmF9TwvUsRtGvpBkQPZPPwmYr+zCbJ+cHzzV04lZUaTXi/2YdR?=
 =?us-ascii?Q?ZVVlPFg1gmyRZ8071mBfnI7o3iGPDt1ugLXgatxN8+JL3Gm42H1qVYj0IE0A?=
 =?us-ascii?Q?VVD58E0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DwE6XQ5PhnmmMixDBYYOVCEPGZqSf/DY+kMLLGFQGEO17haBsx7pEpOvO/N5?=
 =?us-ascii?Q?re6f6jxTemNrUeKlYIknIFWRmbIoKedBKRMvtMJh96Fqii//4AW59RmL4DlY?=
 =?us-ascii?Q?aCMzfa6DzLfucN7+erPvF5RAm31RKy3yB/gnYLrGzbwitFdXlNxd2dlkc5Qn?=
 =?us-ascii?Q?6mZSJhk5CvYoy0AjDLPbiPIyJ0AwjK1Q08oRJgp1uE+C4AIsaFR8aOzTRbv9?=
 =?us-ascii?Q?96eLKQjxlirIVqT/69oCLDwm7eaRTTdJzND5r5cq4lJ0SUv012oQTmjBCivw?=
 =?us-ascii?Q?eOMroYjmSphPIFa3jUZGXKOwdXPZZlvP0Q+JmETrxzu5inVLHTQQFelSaUXp?=
 =?us-ascii?Q?ao5HWcIGyZnP/iSKTe+CL2UkJLhDPXWwR9nHGj5zeLvBRzS+GV5fIIoHz9z0?=
 =?us-ascii?Q?FhFfUNKo0JDQZ5xT6sKzUoSlLdKdR503vGZekR3Ed9djDTgPj/Jt/hrdewD9?=
 =?us-ascii?Q?OVLx3FYV/L/8HPrGmd8aHvtYfShZI6pEYWG1N56MHxtpXcyP2hdZslSXAAmU?=
 =?us-ascii?Q?jkPk7WURuvtdQ0bpDzD8hAo0bWx166U74QDfIlVgAGSxAA7hgszsyHwAk+Sz?=
 =?us-ascii?Q?5TRbNvP1mV4wB+ikV9dPY2bTh0QUaX9jLOyx33CP8ObnZdriPJy6EeQxMKiR?=
 =?us-ascii?Q?lYkfyvOg/V7u7oBR3+W4Vzxu8M1q+LoVmkhJY48oQspFI2NtoUpb8nyftvIl?=
 =?us-ascii?Q?C7nJGcbu74Y1dLVcy4vmhswkQesh+eOyYfhsBSwWXacMVkrLOfHNparZCqvs?=
 =?us-ascii?Q?8iRktzj8j+rc4Ba8pP25WK3HyWlS6XHXWxKraCZVMGN8HwC2H2diq5KSyO4w?=
 =?us-ascii?Q?Yhti2BJgAiSHkpEE3U37OykbT+/ap8ZiO9VvQdUVfkCvhPA2XGGr04lva/gt?=
 =?us-ascii?Q?pz+UK7CafU62DdNYkTJAUZsS5E2oheXdTO5zudLGh438/XHhdQyBKh8ddA8s?=
 =?us-ascii?Q?Llr5JU+/U0ANFx8HVeCMqDJ8m643FWMWkLzZfw9TcCdNju9iDazvwTmQ6Wep?=
 =?us-ascii?Q?v/be4wwymsxm20t+YmqPDMLU2qsHxhXt6/JgLSjmO5AD/ebmcaKl87VQsuG2?=
 =?us-ascii?Q?WNB8TMvD1CuP865b0rS7PV07CvbuIn4P7Y6Y0C4WK5MGj3KK7tAqjilIsuDI?=
 =?us-ascii?Q?pvR5f57JoBZ0cI/RlY4uVJo0Hc9CikAJvLeW2aZsvOngQlLwZ6AvEWr0xfFN?=
 =?us-ascii?Q?4kSN1KxuUI7P8YJNJGCWPdSYoYr+al2uUqHFNLilHgpMhM5n7kN3CmK94vCm?=
 =?us-ascii?Q?/BTH+gmIlPylMQKz9a2LsiuO4KVA9e2WNX30nmXzPZCmsINulMo8Poznr2Py?=
 =?us-ascii?Q?k/9U1v7CN+askocWFGl3IHo3VdVB0FccmQ6D7c8rFbPq6/WujKlG1Zbiz8YM?=
 =?us-ascii?Q?45faq3jkCmFQx/QEVoF7ZUCeeJuH1cqVg2Ai6ayJ0jvZ02OD8RZs+oHjbcqg?=
 =?us-ascii?Q?+60O9PN+NxQ6BytchMCTFfvhlF+eszAOGynLi6KBRnriiw4VT9TJ4XWYdyY/?=
 =?us-ascii?Q?KCF82+ulUcKG7S4Nyk1FN06dzD5+bZJNByricnMn35fWY7vZyt1+eezh3zkc?=
 =?us-ascii?Q?gKm3qhPpYcWLuEcBgum8wUPqoPvWR4IqP/rlgUFmb2daC9xIMLcfUnUYDd/K?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bab60a5-32de-4c04-8138-08dcd5d20fb8
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2024 22:02:16.4914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+4Yvz5TbRd04haY21rdPWxKq7cEU1VEBXI9YMxhN4gXJld3VeCtcE3UvDaPRGTz9AO2rn7McGh2FuEIg3CFlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3086

On Sun, 15 Sep 2024 14:31:33 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> Adds a wrapper around `kuid_t` called `Kuid`. This allows us to define
> various operations on kuids such as equality and current_euid. It also
> lets us provide conversions from kuid into userspace values.
> 
> Rust Binder needs these operations because it needs to compare kuids for
> equality, and it needs to tell userspace about the pid and uid of
> incoming transactions.
> 
> To read kuids from a `struct task_struct`, you must currently use
> various #defines that perform the appropriate field access under an RCU
> read lock. Currently, we do not have a Rust wrapper for rcu_read_lock,
> which means that for this patch, there are two ways forward:
> 
>  1. Inline the methods into Rust code, and use __rcu_read_lock directly
>     rather than the rcu_read_lock wrapper. This gives up lockdep for
>     these usages of RCU.
> 
>  2. Wrap the various #defines in helpers and call the helpers from Rust.
> 
> This patch uses the second option. One possible disadvantage of the
> second option is the possible introduction of speculation gadgets, but
> as discussed in [1], the risk appears to be acceptable.
> 
> Of course, once a wrapper for rcu_read_lock is available, it is
> preferable to use that over either of the two above approaches.
> 
> Link: https://lore.kernel.org/all/202312080947.674CD2DC7@keescook/ [1]
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/bindings/bindings_helper.h |  1 +
>  rust/helpers/task.c             | 38 ++++++++++++++++++++++++
>  rust/kernel/cred.rs             |  5 ++--
>  rust/kernel/task.rs             | 66 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 108 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 51ec78c355c0..e854ccddecee 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -19,6 +19,7 @@
>  #include <linux/jiffies.h>
>  #include <linux/mdio.h>
>  #include <linux/phy.h>
> +#include <linux/pid_namespace.h>
>  #include <linux/refcount.h>
>  #include <linux/sched.h>
>  #include <linux/security.h>
> diff --git a/rust/helpers/task.c b/rust/helpers/task.c
> index 7ac789232d11..7d66487db831 100644
> --- a/rust/helpers/task.c
> +++ b/rust/helpers/task.c
> @@ -17,3 +17,41 @@ void rust_helper_put_task_struct(struct task_struct *t)
>  {
>  	put_task_struct(t);
>  }
> +
> +kuid_t rust_helper_task_uid(struct task_struct *task)
> +{
> +	return task_uid(task);
> +}
> +
> +kuid_t rust_helper_task_euid(struct task_struct *task)
> +{
> +	return task_euid(task);
> +}
> +
> +#ifndef CONFIG_USER_NS
> +uid_t rust_helper_from_kuid(struct user_namespace *to, kuid_t uid)
> +{
> +	return from_kuid(to, uid);
> +}
> +#endif /* CONFIG_USER_NS */

nit: it's fine to omit this `ifndef`, see what we do for `errname`.

> +
> +bool rust_helper_uid_eq(kuid_t left, kuid_t right)
> +{
> +	return uid_eq(left, right);
> +}
> +
> +kuid_t rust_helper_current_euid(void)
> +{
> +	return current_euid();
> +}
> +
> +struct user_namespace *rust_helper_current_user_ns(void)
> +{
> +	return current_user_ns();
> +}
> +
> +pid_t rust_helper_task_tgid_nr_ns(struct task_struct *tsk,
> +				  struct pid_namespace *ns)
> +{
> +	return task_tgid_nr_ns(tsk, ns);
> +}
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index 367b4bbddd9f..1a36a9f19368 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -9,6 +9,7 @@
>      types::{NotThreadSafe, Opaque},
>  };
>  use core::{
> +    cmp::{Eq, PartialEq},
>      ffi::{c_int, c_long, c_uint},
>      ops::Deref,
>      ptr,
> @@ -96,6 +97,12 @@ unsafe impl Sync for Task {}
>  /// The type of process identifiers (PIDs).
>  type Pid = bindings::pid_t;
>  
> +/// The type of user identifiers (UIDs).
> +#[derive(Copy, Clone)]
> +pub struct Kuid {
> +    kuid: bindings::kuid_t,
> +}
> +
>  impl Task {
>      /// Returns a raw pointer to the current task.
>      ///
> @@ -157,12 +164,31 @@ pub fn pid(&self) -> Pid {
>          unsafe { *ptr::addr_of!((*self.0.get()).pid) }
>      }
>  
> +    /// Returns the UID of the given task.
> +    pub fn uid(&self) -> Kuid {
> +        // SAFETY: By the type invariant, we know that `self.0` is valid.
> +        Kuid::from_raw(unsafe { bindings::task_uid(self.0.get()) })
> +    }
> +
> +    /// Returns the effective UID of the given task.
> +    pub fn euid(&self) -> Kuid {
> +        // SAFETY: By the type invariant, we know that `self.0` is valid.
> +        Kuid::from_raw(unsafe { bindings::task_euid(self.0.get()) })
> +    }
> +
>      /// Determines whether the given task has pending signals.
>      pub fn signal_pending(&self) -> bool {
>          // SAFETY: By the type invariant, we know that `self.0` is valid.
>          unsafe { bindings::signal_pending(self.0.get()) != 0 }
>      }
>  
> +    /// Returns the given task's pid in the current pid namespace.
> +    pub fn pid_in_current_ns(&self) -> Pid {
> +        // SAFETY: We know that `self.0.get()` is valid by the type invariant, and passing a null
> +        // pointer as the namespace is correct for using the current namespace.
> +        unsafe { bindings::task_tgid_nr_ns(self.0.get(), ptr::null_mut()) }

Do we want to rely on the behaviour of `task_tgid_nr_ns` with null
pointer as namespace, or use `task_tgid_vnr`?

Best,
Gary

> +    }
> +
>      /// Wakes up the task.
>      pub fn wake_up(&self) {
>          // SAFETY: By the type invariant, we know that `self.0.get()` is non-null and valid.


