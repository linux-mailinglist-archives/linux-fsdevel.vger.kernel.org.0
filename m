Return-Path: <linux-fsdevel+bounces-72523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FC1CF91FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 16:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05CD33050023
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 15:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACA3334692;
	Tue,  6 Jan 2026 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="CD6Cpz25"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020138.outbound.protection.outlook.com [52.101.195.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD2E225A35;
	Tue,  6 Jan 2026 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767713592; cv=fail; b=qnojHFNCeRnY/30FkKFeq9aKkkKVBORqPN6BtgCefEYcr6p2lt1/ao/rgFGWZHLxziRNmIZ7lq7piaLeHlhkXg8oRvo3HlxXmmYCQwnWQAqhNbfe66Al8Hd7NrIu7ymwerUA7NTwTNa3BzRC0cKN49+d2v+E92O1Rs2gXiJo+x4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767713592; c=relaxed/simple;
	bh=z0uh0NO781ZgDPfnZ09e5sBOzFuZCZFJtR+qIrMCnPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g+NPfRqtBKYZTSzIcFA3MueWiPf6oDM0T1erGeVqy/UOEpfXAq6IbvOYoqxoqVOghB8XhSUlPqDUIqiHstS2SKErUPvYxnBl82oJ0RXyiF7qn8cJ4PGTRv4+gF9dLWxEGj0SsxlJ/zdus0yZ2r6EzDuzvnki9W9aBQJuq3PPIQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=CD6Cpz25; arc=fail smtp.client-ip=52.101.195.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUj+SUYC7lbOiEWA/CIUEkXCuiAIkhBLwF/oLFkqkyFWqpsH3028QAMvFvfSDz8AylGhAYFXh4JmFkLxWsshtgXc5deFw0SCDiutMHST6IFH5cmu9Epi549jyMGlDH5Aoj434Nwt5AuOu3gBAXfPmTmmTBFxnov0kpCAkxk2uZ62EsF5HCen5Li/GeFe4whrqAo/oZHZY3mE2cKcrdzPt1j7/TUxGtnPMrdJg+hIwC7HWdi42MC43zMR8FgnoU0jxZJUH8xjYzAVbUkMBb1DU3T2N1qqTmu873c0fS5QSAYYeqraVH38eGe7UX+83wI61pKGkMpqGBOM8zunBp5AsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLLJEBb2fztJb6eF1uVu56I98hyErUrWZpcPRUEpD4E=;
 b=nbaAC3xPZ1iA7Ko41FN1W9hGiN9G9zTFbj8ckT1wOsvbF7o8Alohsz51KCw79KRwEjoY8lLYrdZpi7+N4XUP5M5/hIVsB2Sl1qXoG0ySmszR4EY2J479Ri8TN7YWrZoOapTj6UtJcmu8FsVOPK4FFpybI6e+7FK9PACSd1gC6GONXxkGAgCl//NaxhU//nWHxJei4UrgkulvEnwWtqfidDCtrYkgXPsGDws3ChB6JPg2eSvyHpbBVpUEv0Hjekvq+IX+bKCyom+4LJeYZgjftbHWwFiEGxZAVrzQQwYXr8aN6gwjdYcZEBpnJpLnOZqwFEUL6PyXu4Xg5WGt2H8n2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLLJEBb2fztJb6eF1uVu56I98hyErUrWZpcPRUEpD4E=;
 b=CD6Cpz25JLvikxNcBn2t6DSCIHX4tDqVWSlMYcyQn8w2dHqQ2XAtd7kMjSop8CtrugPURjgsnhFteyOnyfwrKyZQ3ejvtuvrO3vMu1LUKui+SginYrGwKGLs4Yd/n51w0V6z6voaHgfsfcX2ZUgJKdt26Qf54JniyfEDW1WUAbM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB3074.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 15:33:06 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ea6a:3ec2:375d:1ce0]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ea6a:3ec2:375d:1ce0%7]) with mapi id 15.20.9478.005; Tue, 6 Jan 2026
 15:33:06 +0000
Date: Tue, 6 Jan 2026 15:33:03 +0000
From: Gary Guo <gary@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner
 <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, "=?UTF-8?B?Qmo=?=
 =?UTF-8?B?w7Zybg==?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross
 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] rust: redefine `bindings::compat_ptr_ioctl` in Rust
Message-ID: <20260106153303.6ff846bf.gary@garyguo.net>
In-Reply-To: <20260105-redefine-compat_ptr_ioctl-v1-1-25edb3d91acc@google.com>
References: <20260105-redefine-compat_ptr_ioctl-v1-1-25edb3d91acc@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::20) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB3074:EE_
X-MS-Office365-Filtering-Correlation-Id: 531cb274-3390-4a27-e565-08de4d38e345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DuPzTNNm3i6dnNF7I57EsV81yDqx9GuvCLAGEXIUYtwt6sGIYDL0UZNEpXqs?=
 =?us-ascii?Q?4ubu5s+otuvpRjCrg7VrDQViOT4QJv6dAVKmeRZplAcKNI8EldfVCZrUl8Iq?=
 =?us-ascii?Q?4AZ4C4J8IUtyBM40ekMS0zJz/ujL4/6JFPh0A/HuCn8ycXawG//4cS3zj+Fe?=
 =?us-ascii?Q?GV1Ug64wzICxvxnCAQLua3w6tAmrsHm8oD4reaJZ0SCvU1biI3Huk3g91z5t?=
 =?us-ascii?Q?cEKhuNclQAW4Y3Bmo5UL7vui4j0dr9Jqi5EuQH1zZMMMXCVIEFdwwAI0eZXc?=
 =?us-ascii?Q?DJ9WtNRCRlb9ffBDpNvD8iapGvwP6G+W4At9FR3P3BgUvlqiU+txvh5WSt+G?=
 =?us-ascii?Q?gOUiqG9dQAszYf4t55B2lBlF/UMdyfG75CxYxM8HUhmnYxM5Cgb9Srsl5o4j?=
 =?us-ascii?Q?VqHvPTDDKVxanvISGCa2Q524DzlBseGx/Yu9YXDVR6wAqyKOUtz9XPWp+Xsh?=
 =?us-ascii?Q?ovsxymsOSyEycJxY0DICz9C/qqYSivEo7ewoR6GFAEj+6j3Erw3D919iEMeK?=
 =?us-ascii?Q?3EUrzVhZhyBSap25Fet5aFLX9armL9dNN49TGfuM+OB7Vrdb0mpoty9nX+tN?=
 =?us-ascii?Q?ned3mTV4TxsPyg22fyDsoAj7RweUE08KlzpoKFctJYT/sS145feFtP0T9Qmi?=
 =?us-ascii?Q?H/oHW/0OmpK9DsXoHl9BakFHtZ6GiMdp0ntYbXwQfirRcS9ntCSIL8tXi2mW?=
 =?us-ascii?Q?LNqvPqdnR/Jn6FLdnEH+NS8sKD5/gulOt884iG7gc/J8k/B95SaDLYaPMzoG?=
 =?us-ascii?Q?knb1LsqZnHoT+miY1x1h3GLN6egp6FUFKzSsBzNewrNa0o0CXZEfG+7BZot4?=
 =?us-ascii?Q?Cl25z8glHkH0y/5rnEYODFQmxK7mgdOWelZVbeA93EOKqFg/eVOU1xfvJ6M2?=
 =?us-ascii?Q?mQTnd9njM29MyWFMLewS3siXvnEtU33KDzS2upgvy9nXJ4Hf7Dj4RRB9COHv?=
 =?us-ascii?Q?I9Q4csyjl8QLIIKEaNHxheq9HnRmyiNOg2ZjLu4IW4tY+0rTdcSZ/yAy6Tqh?=
 =?us-ascii?Q?f1xm8aWu64QErs1Cvly5jLAZA1xigkPMICnuFy/wdWCowhvM1m05l2Xunj8/?=
 =?us-ascii?Q?M4JDgh5dF5VPFmke4PtDHrnNSfb407rdgzY9fcEcTk8W5xoQLn2WHByfIpex?=
 =?us-ascii?Q?ufkDaM2jkfSE4u8npb+qk+/ocQe72hv8hbUY+XU9RV2v8vyE2kcBhqINrTGM?=
 =?us-ascii?Q?ltIssWv/35ZwD/s7jSHoe0pJCIGF0TRQSY4m354ZRdJuwq7878jbDaEkrJjD?=
 =?us-ascii?Q?wmJO6e6q2crYrPMznpLxg5ct7kn9Cwl2vec3n45Oohg+bpDr+c9kWSJs8uLD?=
 =?us-ascii?Q?MVP5W7kqa7U7SCPQLhYXjGlo5ffXwRNLzYKQloLWO0avlWbXBSPAR+++6D3b?=
 =?us-ascii?Q?6Be0MxbxuWUsnmWNZuJw489qri0IbHU9KHwGtxi3sYGFBHGmoDXBgTeOlO3J?=
 =?us-ascii?Q?Ourp/BGJVJVnTVySnbYTdzvUm2UutLQj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UVghfYStwiLRBF3izH22kMmhi0GYN9RZ/RXVm8FCa7DaLJYM4Vx/JBp59ElJ?=
 =?us-ascii?Q?BMhuBuJzqtwAOdQMEeaRohuwCb4fdixwGLCPBl5utHx8Jw0eivIvBE4e2qLo?=
 =?us-ascii?Q?9qLegi1yM7IIET/qnoRKRnGjWYfhadyTq1+u1FEzoZvDtxpUVdJB8oilxh6d?=
 =?us-ascii?Q?MVXeeeaCWHQlqFEjC4Ij4c+m+6HFY7gRT7mWIFveNJjt7CqyUn3HyXFeVG0d?=
 =?us-ascii?Q?DZHjqxGAS6X0mKiBh6Wp4LGTFNqt/hCQlMb9uWXD6atpqt/KBWcu/SGIb6Fo?=
 =?us-ascii?Q?BxsqR1sZqnAkSRo4wiv10+RZ1AtXD4flw1nPm1kd5BSCbF0o2OhulJQEeni1?=
 =?us-ascii?Q?MyaMN4ErHjJ+0g3hBoAwwwPe8c6NiZORYMvY1z7sLixEgYvYxdxr55PJGzTX?=
 =?us-ascii?Q?sQcg+BpkJlk8Nm+ZOM2VdkUccojSGHco5DgaKatkHj8D6vlpaeH7xLAtoxms?=
 =?us-ascii?Q?6ya6ArDywTSxZXfvOGMCnSvoAO9kbOiVWHFenQ802lJVBQR0UpK3epF8TIzO?=
 =?us-ascii?Q?ZDFMxwJr5V7XFnkCRPnNVU2mS/yjgpzHdm2dUSLgDfrLdr/u/qQVLjqohces?=
 =?us-ascii?Q?hRxMLP3KDLYmzf2svkHta06z7Dtrky4U6kSuC+6H8fFgyucln6snT7f6e/Aj?=
 =?us-ascii?Q?Yl8xOvWROE5nyT+jNviV1XVY3/q3J1WziJXv1jGgz0Ns6pXBEFkXVIaOVl3m?=
 =?us-ascii?Q?BFQH41wTO0xoepUsof3yN+Qdm8y74d8Ibsyamkp1awqSXu2wv7aLxoggeAW4?=
 =?us-ascii?Q?iJ+BOb0QU+873HUHSfXCI5i9hmj2THL83KFwk9+hIBR2hulYAzD70HAWX0/q?=
 =?us-ascii?Q?3P+SjATN1bRGqD0JQy3zDGI1yzlrC8TybF2et/dIDkfto9WA7xigOhEiJS14?=
 =?us-ascii?Q?BUGIrbUZoZoOoIUoPqDikmjZLG4953qljiGJ4yBND56gB2EJkv5muaF6+iPP?=
 =?us-ascii?Q?RVGwJUvxKSjnCgFfTRUUnU1+C3Pgvza7pcMf/sidwZ+M9iGIuizxWXe0lyog?=
 =?us-ascii?Q?eniG5uw5w223bC5L5uszeQVyrdnZDZd7A9Z8f3kUaLHqTQbMU5i89ILbY9Kr?=
 =?us-ascii?Q?EKypvtFxRmoagVcqwozg3XiDBKD7/MPHRWLhpPpFaT4RFzi4dimHfB5aoaU2?=
 =?us-ascii?Q?L6jV2lVz683TH7zsghFOHpwtJRU9aNTJ4we7+xFI/IxTHy/nUYIbfd5P4CY7?=
 =?us-ascii?Q?fHO6vRf/HaE5IGZqNGCnKskkQlA8wPeeybIO8YPV0NyGemSOdMqfXrpg3czb?=
 =?us-ascii?Q?8m5u3Yc7njYC+YUaqpStoRDWosJyfZNpatGAKSsLtRqAQT29w459K7N1X5p8?=
 =?us-ascii?Q?jBsrlDVaXyvgngyw73+1952KR1Oez+pE8hdamBSmxTsOD8q4iX/SXs87NSPX?=
 =?us-ascii?Q?uklrviv+CJn/t7nsD6ddCgs9e+jK3lY7LwHJIQgkyJqIzoBiC6GiXHdfcZR2?=
 =?us-ascii?Q?mGuEwLKyeuqY63OpQwbGBzViICfoNplXc7xuQxvGqkU9+x1rgsk4FiPj1q3g?=
 =?us-ascii?Q?O/xpMKUYJjlq2wemrfUMxNDnUcxA9n30gbZXaEn3qKfc5pHd099ILdo6MqlH?=
 =?us-ascii?Q?Vnk2nLu17UCZpq7+XYIUNqwOlUkIs1hQwE90eoVMBJZmt/ErO+qPtAC5XvU9?=
 =?us-ascii?Q?ODUmWgel5KE8Nwr6pR4fCkB++95TIyMBEF5lDvoc7Kcj7XjCBEDY3NrWhiML?=
 =?us-ascii?Q?0kTOtLCDZ+RSCISxoiDcMUuU879LTFV+ncFKvc3Vm3iN8Hr3ezpmWE1ok6UU?=
 =?us-ascii?Q?w6fwta8RZw=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 531cb274-3390-4a27-e565-08de4d38e345
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 15:33:06.0259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/wyLqDETUWmZJShAkukXzKByBh0PvHHs35cueZuE6eoAigIeKOB2Dq8VdYneMyK9dsIZfd5WAxKuz6x3IvAUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3074

On Mon, 05 Jan 2026 14:25:03 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> There is currently an inconsistency between C and Rust, which is that
> when Rust requires cfg(CONFIG_COMPAT) on compat_ioctl when using the
> compat_ptr_ioctl symbol because '#define compat_ptr_ioctl NULL' does not
> get translated to anything by bindgen.
> 
> But it's not *just* a matter of translating the '#define' into Rust when
> CONFIG_COMPAT=n. This is because when CONFIG_COMPAT=y, the type of
> compat_ptr_ioctl is a non-nullable function pointer, and to seamlessly
> use it regardless of the config, we need a nullable function pointer.

I had a think about this a while back. I was about to purpose a new
bindgen option to generate function pointers instead of function items,
but then I found that I am not very fond of that idea.

In some sense, the C side does not have a consistent type for
`compat_ptr_ioctl`. If CONFIG_COMPAT=y, it has a function type, otherwise
it has a `void*` type, it just that they happen to coerce/decay to the
same function pointer type.

I think what you did to the bindings crate in this patch is the best way to
address this inconsistency.

> 
> I think it's important to do something about this; I've seen the mistake
> of accidentally forgetting '#[cfg(CONFIG_COMPAT)]' when compat_ptr_ioctl
> is used multiple times now.
> 
> This explicitly declares 'bindings::compat_ptr_ioctl' as an Option that
> is always defined but might be None. This matches C, but isn't ideal:
> it modifies the bindings crate. But I'm not sure if there's a better way
> to do it. If we just redefine in kernel/, then people may still use the
> one in bindings::, since that is where you would normally find it. I am
> open to suggestions.

> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

Best,
Gary

> ---
>  drivers/android/binder/rust_binder_main.rs |  3 +--
>  rust/bindings/lib.rs                       | 13 +++++++++++++
>  rust/kernel/miscdevice.rs                  |  2 +-
>  3 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/android/binder/rust_binder_main.rs b/drivers/android/binder/rust_binder_main.rs
> index d84c3c360be0ee79e4dab22d613bc927a70895a7..30e4517f90a3c5c2cf83c91530a6dfcca7316bd6 100644
> --- a/drivers/android/binder/rust_binder_main.rs
> +++ b/drivers/android/binder/rust_binder_main.rs
> @@ -322,8 +322,7 @@ unsafe impl<T> Sync for AssertSync<T> {}
>          owner: THIS_MODULE.as_ptr(),
>          poll: Some(rust_binder_poll),
>          unlocked_ioctl: Some(rust_binder_ioctl),
> -        #[cfg(CONFIG_COMPAT)]
> -        compat_ioctl: Some(bindings::compat_ptr_ioctl),
> +        compat_ioctl: bindings::compat_ptr_ioctl,
>          mmap: Some(rust_binder_mmap),
>          open: Some(rust_binder_open),
>          release: Some(rust_binder_release),
> diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
> index 0c57cf9b4004f176997c59ecc58a9a9ac76163d9..19f57c5b2fa2a343c4250063e9d5ce1067e6b6ff 100644
> --- a/rust/bindings/lib.rs
> +++ b/rust/bindings/lib.rs
> @@ -67,3 +67,16 @@ mod bindings_helper {
>  }
>  
>  pub use bindings_raw::*;
> +
> +pub const compat_ptr_ioctl: Option<
> +    unsafe extern "C" fn(*mut file, ffi::c_uint, ffi::c_ulong) -> ffi::c_long,
> +> = {  
> +    #[cfg(CONFIG_COMPAT)]
> +    {
> +        Some(bindings_raw::compat_ptr_ioctl)
> +    }
> +    #[cfg(not(CONFIG_COMPAT))]
> +    {
> +        None
> +    }
> +};
> diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> index ba64c8a858f0d74ae54789d1f16a39479fd54b96..c3c2052c92069f6e64b7bb68d6d888c6aca01373 100644
> --- a/rust/kernel/miscdevice.rs
> +++ b/rust/kernel/miscdevice.rs
> @@ -410,7 +410,7 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
>          compat_ioctl: if T::HAS_COMPAT_IOCTL {
>              Some(Self::compat_ioctl)
>          } else if T::HAS_IOCTL {
> -            Some(bindings::compat_ptr_ioctl)
> +            bindings::compat_ptr_ioctl
>          } else {
>              None
>          },
> 
> ---
> base-commit: 8314d2c28d3369bc879af8e848f810292b16d0af
> change-id: 20260105-redefine-compat_ptr_ioctl-e64f9462225c
> 
> Best regards,


