Return-Path: <linux-fsdevel+bounces-30566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E537098C5D5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 21:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6C11F23EFF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 19:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1B61CCEE1;
	Tue,  1 Oct 2024 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="iJGWdvQT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2090.outbound.protection.outlook.com [40.107.121.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA201BCA19;
	Tue,  1 Oct 2024 19:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727809864; cv=fail; b=WjTueUIANaSKrYzsqKqqjYVu3FqMJ4jxVT5CfXPts83EdUvh70DClSMJ5oB0r/qEDBUPPtdTVwjMskPGS1/SfVetde2r/PdPIv10YLEvw8E8gE/CLXFREwN4Z9QFkjFe8qJoWXtOUKdbGkPKylnLeACv+ZbAIdgVxIctMCz+UrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727809864; c=relaxed/simple;
	bh=PdZeMv6S4OrcLq1+qKmVPjCy7klV727QVfMzaymEhbE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eHZmjsbxnfJMo9a6sdOxUDD1dsxnHapxr8lXyfB3Jnt7UxGS39/VoP4eoKKTtxm+hXRWAup37Os8XtjlcBiP937RekkgX/Oc+6CvQRDvYn8otpzrK7c0d4DVGoDLXgRbH5rx8e6roDLc6Da1vRigvpDOP4kAFIUvswFcDM/khok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=iJGWdvQT; arc=fail smtp.client-ip=40.107.121.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZD9hcdv/+DELAwgWYVUHLE6GYdRCpZgqkJg2rGCMATv/DuP0vq6JSyIdIBg6Bk/t6abJK2kY/p+w3Y3hIL1K9VqzP8GlKdFM0bVXCxUvHYRQ09k1cQ2o/b86KJhZd6lSHAiLTmxKmWcY7PKDKJW3keW6dxy07MnnBNuNoYEZK1eWq2FVubZOyK8HfpiKlJhCAbOuHp0ETgoIx8FgSX0wBZIckZjRRkevzlhxGfFLk5lM2iOfUYWo9psyuDHw2dVCp+AahTEx7/jEWSBXwGTOyGTyqfaYbubMGJjQDe84uQte0Nijf2Z1PylsM41kmykXU8RiRpWHKInJPaomxQjQgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0hOQnVrsv+oqxW0+PY3dQr+qCN0tFOIP2mr5rucIzs=;
 b=RvXyIT3yJKh0kaIkoFe1xrrk9SEMLuA5vQbveWjfQAi8xggMF3nCrUBOsJ26AwNwvAD34qDiZIjVmQF7TdXWpaCdzezrCEIc4ZNWaS+BQ2/chEbyT63AmJ2w0LggrynPeOXdIxfSnpTMLKbFJ0eMHvFHFaS+s/UvGhfOUy24b+6/i15+9CROKQQMbsPThv6CfOTn42++U+cuc2XJttHnq+4IFdq9sSsj7AW7YbtM/dsqwoebdWUuqxr5b355uWdbLKLHBUwBQ9Pv37QGbDImnQaE/Ju+RnlofYDOibjoS2EhIhdqlmD61bpXIIrpr4SIB9h3Kh6PDbBT9Opgt3VxOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0hOQnVrsv+oqxW0+PY3dQr+qCN0tFOIP2mr5rucIzs=;
 b=iJGWdvQTgxj6OtSKZspR0OU2KprF+lLcIRPjc8T3Yqm+JCY6JaQtk6ulNhn+oTsKtlP1ElmDOE3Hp6l7GY84Q4JLULVy+2gZnWdSlB/4CcwHB277oH7w6X4jHVIgle0ilJcP1S0agC9Le/QC1lPaRBvWAflPVNviwFgSwQ+6OPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB3266.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 19:10:57 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 19:10:57 +0000
Date: Tue, 1 Oct 2024 20:10:54 +0100
From: Gary Guo <gary@garyguo.net>
To: Christian Brauner <brauner@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, Bjoern Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Peter Zijlstra
 <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Arve Hjonnevag
 <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen
 <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas
 <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Dan Williams
 <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, Martin Rodriguez
 Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Kees Cook <kees@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v2] rust: add PidNamespace
Message-ID: <20241001201054.73167686.gary@garyguo.net>
In-Reply-To: <20241001-brauner-rust-pid_namespace-v2-1-37eac8d93e75@kernel.org>
References: <20240926-pocht-sittlich-87108178c093@brauner>
	<20241001-brauner-rust-pid_namespace-v2-1-37eac8d93e75@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0276.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::11) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB3266:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4aa31e-fd63-4340-0a50-08dce24cc76c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KKhCu6NFb8Y+raGrzl6S5g9ZanqicaJL97Ub6IkacG0/49x/NnOH5lbygiFm?=
 =?us-ascii?Q?bSfiy1Gr66EkQNDh4qcxDo1CSTqujEY4fvIHe3/wsTC7CO97hfZRLCLwk8zr?=
 =?us-ascii?Q?SYL/Ek7SehJzimaAtFWMUFamQnA4QDjOMt2gVRc/RB8gaM5TfOJ1F6MzeVmH?=
 =?us-ascii?Q?XUu6078RrstllbFATU07IOafzx4W0b3GhXXRJk5ARp9WEPjFYRl8Fyw6TjJj?=
 =?us-ascii?Q?EIKLXhn/Koj3z+4IAdYy7nUVINHIkIudazdIepS3edkUWeYM/uA/CIRDd3kl?=
 =?us-ascii?Q?9+6ydHeFGFFVIXOC0SJz+f8JaszGtrEeBBrahnfp5RgH3NA2QevtVuY/yKPl?=
 =?us-ascii?Q?TfjgUeUum6cGxzsRv5qB032z180O0hGGUsyWqMHE/za32qt/0Tan3VhGhfbX?=
 =?us-ascii?Q?Gd1KzLkFhot7EIwizBYZFF1jbnIKF+NPRtLkQ4RmE70ocES4SYTekHtXL+nG?=
 =?us-ascii?Q?QFDRjbpLDsFKIarLRc18QMkKt4b+X1vtOd6ce35oiLpSs8zM1tZY+AFcjeX9?=
 =?us-ascii?Q?72PYuMiu9Hmx0CGiikh/0W/aiWDoZPm8uR4ganvGPCSxQMpCqJAlPedUnLPy?=
 =?us-ascii?Q?kOOXv4jJmiOqgclG7tXlrcTgu5s2S39w2Uo31662F/H1PDkMky5HDC7kjjms?=
 =?us-ascii?Q?n96eSPhl9pqkD8iCDWR8Z8mhdyfzIqOAeXZzlmXmg5aYHc33EwoZIiRy9Ce8?=
 =?us-ascii?Q?UWTu3aetYp/bevhymXcaVRGpNyODos2Efqsx7MIXU04H62vc4uqeUxQ6FCeM?=
 =?us-ascii?Q?3SFXsGzfZsRWO0+zU2MzTGOXmuUUJopFiMILQD8U+yBpOBCxzjzYtEbtyS9W?=
 =?us-ascii?Q?9ZF/dncvCS6LHvD8hwU/m33c1kbQ0iWMe4TsSTrtjFZMVuop9uv+z1CVvZdc?=
 =?us-ascii?Q?ZzIyZP5zI0k+Vm/xW+kClWzpSBRtu0CnbJmEDxSs0W7Y/NBhpDfQiykty0d9?=
 =?us-ascii?Q?KSCkYoIHh/xTJhfNVGTbVxupo+9rDKPdSUXsUbfR8cpHJxZJBEfzwd2t+ST4?=
 =?us-ascii?Q?fab4aHQrGgMma5JP/P3/M+PIWUTHy0pqQo0fuUB6z7mmt8ASyXUCSfHGRWdy?=
 =?us-ascii?Q?NTSp0CrgAJwD4xuB48hPNMi2tWLEDoduUvsmsYiJY+UxLd6Rc9mTg1GsRN2l?=
 =?us-ascii?Q?IVO7Q/qQRZ+VODWwqLe/Xjhgl9zqymq45SEuappBgYC7qeb/gaUVPE601PFD?=
 =?us-ascii?Q?6pXivoEm6o4J0mJUlzk2PS23HxrTDoxpdWIXeRmHgDRVNz5n7RWzyY2y88GP?=
 =?us-ascii?Q?EATBV1mq9nTAcl7YyjWp4lRP2TcsHB5STCgTkKsnki93jJWy4ZuXgGHKHG4M?=
 =?us-ascii?Q?8Uj/5LmDOHliPh2lbllX0JpjLUAjCpddi9hjOXV5mYAXXQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DZxGq9EjCd4SSfkRCGfcJ7PIzZtOGHDiysHQAgYaUIz1l1zU+c6mWHg0V6rt?=
 =?us-ascii?Q?2wOCQujXnYC8tcmyM9FRMcA4sr8OQ2ibeORSAC3u2r2ge64dxawMm0r3GV95?=
 =?us-ascii?Q?bUm43+m6bZOeO8B8U69a0Zxmr69lm2pv4ZaIqmit/P3/G5ipEgixSo5zo6vJ?=
 =?us-ascii?Q?n6HBUNFaSVZ4wpC2SP4Hy4kDb12a7P0aUf9C3bVHAQvR7iktcVG9NCrIVXdY?=
 =?us-ascii?Q?qZrwlXdaamRSgm9N7DuJQiUEf0EzVtZvJmk5vKUcb8D9m4sDP4QFqFme1XzP?=
 =?us-ascii?Q?6hnbvmt10rlvAw3AH9SbUsXVO5Mm+YT2u+L0gc9Utk3L1QMjbzXDbZyuXmMG?=
 =?us-ascii?Q?W3xWe+ELgMa6RrdaS8rIjEKH22ESIGTc6FmpYeHKWx4R2IpoByQ+p022v6dE?=
 =?us-ascii?Q?nii304+7gk30yUjnS1g3mr+gyGL3oimGMHg2ex4tNGZJt9ZoSZESPUFhd8H3?=
 =?us-ascii?Q?3h+ZMkraO44PbiRKTPUAx4Jgntj69AFYNqIgjXTb475CuP7shlRtusQCVk1b?=
 =?us-ascii?Q?wSjnuU1yMA19mFyGqs5sWyaqDK3alsljD89ZUeRLtP8HYbwgXM2K8LSolYup?=
 =?us-ascii?Q?aB7EdDu1ifFkxalYgcollumV/SC1O9zo0kaUAbqOEY7xvMmPWHI3DULlO4ai?=
 =?us-ascii?Q?CVnciyVTsfuW/Hv3sWA49vphyh+MRbiJwruf+Amzr24OGpvE1AXrsw/DRMZP?=
 =?us-ascii?Q?Gr61VNMHGWTcdUYEJH56hYh96rwNkkzsqHak7/lHQixmQwjbesGKYztL3bXp?=
 =?us-ascii?Q?uiCxQ6qWgYT/aYF/eHuY+6clhkmY7sO9F3R1UL5R3XHCJ3qVkQXC+3bI6u14?=
 =?us-ascii?Q?cQgY8L5Iew+bJjmtPHJljlHxsW2vwMyk2qgWwP7Ones+JJZhOyfO6CBXoVq+?=
 =?us-ascii?Q?T9Ii1y9vIf+rdyDx5LTdRiREdkYYZ9LhqFAXnmtVgx48dEfLCo+UeAJcUTp0?=
 =?us-ascii?Q?bkEvW6mpj8aCAISme/EZ6f7/qUceYOMsA+EkfuWWq1DYygsHLUu0ATiCLN3J?=
 =?us-ascii?Q?+oDabS+RgcX0YtCFQxJnTlwJbVnIo77ozldEu+dFMXsppx5+eciFO41tkWZu?=
 =?us-ascii?Q?X0T3mg9n18gV3dSomuSJG4w4e9vnxhetk0WlSYhcIhwjJS5bzG7CDmyazBAA?=
 =?us-ascii?Q?PYifc+Wr0aXwaPMcL5oSxG031c+9nsdxCu4DLBOg37a5OhBxa1HIjHDEqBSN?=
 =?us-ascii?Q?HthXXzGdyi5cieCUzrWtouRY3DVqBckIjK7+iiSm8nJ5LjHJ7JNzVys/RjYK?=
 =?us-ascii?Q?7Ys3X66TIE7sR4bO85939FcqBbTDwLyLpKMn8gLWFAZqmotHJlufLnMKhDq+?=
 =?us-ascii?Q?HRSoFonqNEWxy7lghwse7nfLUe2hhX84D7O6vGIHZ+G3OOavjk8+6y96hluI?=
 =?us-ascii?Q?hSK75r7oTauR6jPwce5+Nn0MhGh6Yu9x4pnW6g27JzaQAWYvz+S1jCAECkUj?=
 =?us-ascii?Q?4BzViy1u1tCbo/oLdtwV2jc+pJ+VVBR2ZcULFs9OU3vWDUH9FdsLxQFWQYGd?=
 =?us-ascii?Q?09cR9vwha/wfZ/dk4tHG7cuAaJWaSAB9Gpx0qsjMGkgDO6Edqz15f7btv/+c?=
 =?us-ascii?Q?RgC0C1qgB2UA7IFqKJZvTCTDNaE57t4Ny6GVsrsk?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4aa31e-fd63-4340-0a50-08dce24cc76c
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 19:10:57.3355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DpDDHwsb+tyQ3mE6wYeYO6m522WAnfqKzc8htiuX7auucAxKkt7gJyGPcMLpuOvnn/op8Fr2sNYtgVIl6Mnqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3266

On Tue, 01 Oct 2024 11:43:42 +0200
Christian Brauner <brauner@kernel.org> wrote:

> The lifetime of `PidNamespace` is bound to `Task` and `struct pid`.
> 
> The `PidNamespace` of a `Task` doesn't ever change once the `Task` is
> alive. A `unshare(CLONE_NEWPID)` or `setns(fd_pidns/pidfd, CLONE_NEWPID)`
> will not have an effect on the calling `Task`'s pid namespace. It will
> only effect the pid namespace of children created by the calling `Task`.
> This invariant guarantees that after having acquired a reference to a
> `Task`'s pid namespace it will remain unchanged.
> 
> When a task has exited and been reaped `release_task()` will be called.
> This will set the `PidNamespace` of the task to `NULL`. So retrieving
> the `PidNamespace` of a task that is dead will return `NULL`. Note, that
> neither holding the RCU lock nor holding a referencing count to the
> `Task` will prevent `release_task()` being called.
> 
> In order to retrieve the `PidNamespace` of a `Task` the
> `task_active_pid_ns()` function can be used. There are two cases to
> consider:
> 
> (1) retrieving the `PidNamespace` of the `current` task (2) retrieving
> the `PidNamespace` of a non-`current` task
> 
> From system call context retrieving the `PidNamespace` for case (1) is
> always safe and requires neither RCU locking nor a reference count to be
> held. Retrieving the `PidNamespace` after `release_task()` for current
> will return `NULL` but no codepath like that is exposed to Rust.
> 
> Retrieving the `PidNamespace` from system call context for (2) requires
> RCU protection. Accessing `PidNamespace` outside of RCU protection
> requires a reference count that must've been acquired while holding the
> RCU lock. Note that accessing a non-`current` task means `NULL` can be
> returned as the non-`current` task could have already passed through
> `release_task()`.
> 
> To retrieve (1) the `current_pid_ns!()` macro should be used which
> ensure that the returned `PidNamespace` cannot outlive the calling
> scope. The associated `current_pid_ns()` function should not be called
> directly as it could be abused to created an unbounded lifetime for
> `PidNamespace`. The `current_pid_ns!()` macro allows Rust to handle the
> common case of accessing `current`'s `PidNamespace` without RCU
> protection and without having to acquire a reference count.
> 
> For (2) the `task_get_pid_ns()` method must be used. This will always
> acquire a reference on `PidNamespace` and will return an `Option` to
> force the caller to explicitly handle the case where `PidNamespace` is
> `None`, something that tends to be forgotten when doing the equivalent
> operation in `C`. Missing RCU primitives make it difficult to perform
> operations that are otherwise safe without holding a reference count as
> long as RCU protection is guaranteed. But it is not important currently.
> But we do want it in the future.
> 
> Note for (2) the required RCU protection around calling
> `task_active_pid_ns()` synchronizes against putting the last reference
> of the associated `struct pid` of `task->thread_pid`. The `struct pid`
> stored in that field is used to retrieve the `PidNamespace` of the
> caller. When `release_task()` is called `task->thread_pid` will be
> `NULL`ed and `put_pid()` on said `struct pid` will be delayed in
> `free_pid()` via `call_rcu()` allowing everyone with an RCU protected
> access to the `struct pid` acquired from `task->thread_pid` to finish.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  rust/helpers/helpers.c       |   1 +
>  rust/helpers/pid_namespace.c |  26 ++++++++++
>  rust/kernel/lib.rs           |   1 +
>  rust/kernel/pid_namespace.rs |  70 +++++++++++++++++++++++++
>  rust/kernel/task.rs          | 119 ++++++++++++++++++++++++++++++++++++++++---
>  5 files changed, 211 insertions(+), 6 deletions(-)
> 
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 62022b18caf5ec17231fd0e7be1234592d1146e3..d553ad9361ce17950d505c3b372a568730020e2f 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -17,6 +17,7 @@
>  #include "kunit.c"
>  #include "mutex.c"
>  #include "page.c"
> +#include "pid_namespace.c"
>  #include "rbtree.c"
>  #include "refcount.c"
>  #include "security.c"
> diff --git a/rust/helpers/pid_namespace.c b/rust/helpers/pid_namespace.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..f41482bdec9a7c4e84b81ec141027fbd65251230
> --- /dev/null
> +++ b/rust/helpers/pid_namespace.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/pid_namespace.h>
> +#include <linux/cleanup.h>
> +
> +struct pid_namespace *rust_helper_get_pid_ns(struct pid_namespace *ns)
> +{
> +	return get_pid_ns(ns);
> +}
> +
> +void rust_helper_put_pid_ns(struct pid_namespace *ns)
> +{
> +	put_pid_ns(ns);
> +}
> +
> +/* Get a reference on a task's pid namespace. */
> +struct pid_namespace *rust_helper_task_get_pid_ns(struct task_struct *task)
> +{
> +	struct pid_namespace *pid_ns;
> +
> +	guard(rcu)();
> +	pid_ns = task_active_pid_ns(task);
> +	if (pid_ns)
> +		get_pid_ns(pid_ns);
> +	return pid_ns;
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index ff7d88022c57ca232dc028066dfa062f3fc84d1c..0e78ec9d06e0199dfafc40988a2ae86cd5df949c 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -44,6 +44,7 @@
>  #[cfg(CONFIG_NET)]
>  pub mod net;
>  pub mod page;
> +pub mod pid_namespace;
>  pub mod prelude;
>  pub mod print;
>  pub mod sizes;
> diff --git a/rust/kernel/pid_namespace.rs b/rust/kernel/pid_namespace.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..9a0509e802b4939ad853a802ee6d069a5f00c9df
> --- /dev/null
> +++ b/rust/kernel/pid_namespace.rs
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (c) 2024 Christian Brauner <brauner@kernel.org>
> +
> +//! Pid namespaces.
> +//!
> +//! C header: [`include/linux/pid_namespace.h`](srctree/include/linux/pid_namespace.h) and
> +//! [`include/linux/pid.h`](srctree/include/linux/pid.h)
> +
> +use crate::{
> +    bindings,
> +    types::{AlwaysRefCounted, Opaque},
> +};
> +use core::{
> +    ptr,
> +};
> +
> +/// Wraps the kernel's `struct pid_namespace`. Thread safe.
> +///
> +/// This structure represents the Rust abstraction for a C `struct pid_namespace`. This
> +/// implementation abstracts the usage of an already existing C `struct pid_namespace` within Rust
> +/// code that we get passed from the C side.
> +#[repr(transparent)]
> +pub struct PidNamespace {
> +    inner: Opaque<bindings::pid_namespace>,
> +}
> +
> +impl PidNamespace {
> +    /// Returns a raw pointer to the inner C struct.
> +    #[inline]
> +    pub fn as_ptr(&self) -> *mut bindings::pid_namespace {
> +        self.inner.get()
> +    }
> +
> +    /// Creates a reference to a [`PidNamespace`] from a valid pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
> +    /// returned [`PidNamespace`] reference.
> +    pub unsafe fn from_ptr<'a>(ptr: *const bindings::pid_namespace) -> &'a Self {
> +        // SAFETY: The safety requirements guarantee the validity of the dereference, while the
> +        // `PidNamespace` type being transparent makes the cast ok.
> +        unsafe { &*ptr.cast() }
> +    }
> +}
> +
> +// SAFETY: Instances of `PidNamespace` are always reference-counted.
> +unsafe impl AlwaysRefCounted for PidNamespace {
> +    #[inline]
> +    fn inc_ref(&self) {
> +        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
> +        unsafe { bindings::get_pid_ns(self.as_ptr()) };
> +    }
> +
> +    #[inline]
> +    unsafe fn dec_ref(obj: ptr::NonNull<PidNamespace>) {
> +        // SAFETY: The safety requirements guarantee that the refcount is non-zero.
> +        unsafe { bindings::put_pid_ns(obj.cast().as_ptr()) }
> +    }
> +}
> +
> +// SAFETY:
> +// - `PidNamespace::dec_ref` can be called from any thread.
> +// - It is okay to send ownership of `PidNamespace` across thread boundaries.
> +unsafe impl Send for PidNamespace {}
> +
> +// SAFETY: It's OK to access `PidNamespace` through shared references from other threads because
> +// we're either accessing properties that don't change or that are properly synchronised by C code.
> +unsafe impl Sync for PidNamespace {}
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index 1a36a9f193685393e7211793b6e6dd7576af8bfd..92603cdb543d9617f1f7d092edb87ccb66c9f0c1 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -6,7 +6,8 @@
>  
>  use crate::{
>      bindings,
> -    types::{NotThreadSafe, Opaque},
> +    pid_namespace::PidNamespace,
> +    types::{ARef, NotThreadSafe, Opaque},
>  };
>  use core::{
>      cmp::{Eq, PartialEq},
> @@ -36,6 +37,65 @@ macro_rules! current {
>      };
>  }
>  
> +/// Returns the currently running task's pid namespace.
> +///
> +/// The lifetime of `PidNamespace` is bound to `Task` and `struct pid`.
> +///
> +/// The `PidNamespace` of a `Task` doesn't ever change once the `Task` is alive. A
> +/// `unshare(CLONE_NEWPID)` or `setns(fd_pidns/pidfd, CLONE_NEWPID)` will not have an effect on the
> +/// calling `Task`'s pid namespace. It will only effect the pid namespace of children created by
> +/// the calling `Task`. This invariant guarantees that after having acquired a reference to a
> +/// `Task`'s pid namespace it will remain unchanged.
> +///
> +/// When a task has exited and been reaped `release_task()` will be called. This will set the
> +/// `PidNamespace` of the task to `NULL`. So retrieving the `PidNamespace` of a task that is dead
> +/// will return `NULL`. Note, that neither holding the RCU lock nor holding a referencing count to
> +/// the `Task` will prevent `release_task()` being called.
> +///
> +/// In order to retrieve the `PidNamespace` of a `Task` the `task_active_pid_ns()` function can be
> +/// used. There are two cases to consider:
> +///
> +/// (1) retrieving the `PidNamespace` of the `current` task
> +/// (2) retrieving the `PidNamespace` of a non-`current` task
> +///
> +/// From system call context retrieving the `PidNamespace` for case (1) is always safe and requires
> +/// neither RCU locking nor a reference count to be held. Retrieving the `PidNamespace` after
> +/// `release_task()` for current will return `NULL` but no codepath like that is exposed to Rust.
> +///
> +/// Retrieving the `PidNamespace` from system call context for (2) requires RCU protection.
> +/// Accessing `PidNamespace` outside of RCU protection requires a reference count that must've been
> +/// acquired while holding the RCU lock. Note that accessing a non-`current` task means `NULL` can
> +/// be returned as the non-`current` task could have already passed through `release_task()`.
> +///
> +/// To retrieve (1) the `current_pid_ns!()` macro should be used which ensure that the returned
> +/// `PidNamespace` cannot outlive the calling scope. The associated `current_pid_ns()` function
> +/// should not be called directly as it could be abused to created an unbounded lifetime for
> +/// `PidNamespace`. The `current_pid_ns!()` macro allows Rust to handle the common case of
> +/// accessing `current`'s `PidNamespace` without RCU protection and without having to acquire a
> +/// reference count.
> +///
> +/// For (2) the `task_get_pid_ns()` method must be used. This will always acquire a reference on
> +/// `PidNamespace` and will return an `Option` to force the caller to explicitly handle the case
> +/// where `PidNamespace` is `None`, something that tends to be forgotten when doing the equivalent
> +/// operation in `C`. Missing RCU primitives make it difficult to perform operations that are
> +/// otherwise safe without holding a reference count as long as RCU protection is guaranteed. But
> +/// it is not important currently. But we do want it in the future.
> +///
> +/// Note for (2) the required RCU protection around calling `task_active_pid_ns()` synchronizes
> +/// against putting the last reference of the associated `struct pid` of `task->thread_pid`.
> +/// The `struct pid` stored in that field is used to retrieve the `PidNamespace` of the caller.
> +/// When `release_task()` is called `task->thread_pid` will be `NULL`ed and `put_pid()` on said
> +/// `struct pid` will be delayed in `free_pid()` via `call_rcu()` allowing everyone with an RCU
> +/// protected access to the `struct pid` acquired from `task->thread_pid` to finish.

Is the comment here in the wrong place? The macro here is just getting
`current` one. Perhaps move it to the `task_get_pid_ns`, and as a
normal comment, since this is impl detail and not something for user to
worry about (yet)?

> +#[macro_export]
> +macro_rules! current_pid_ns {
> +    () => {
> +        // SAFETY: Deref + addr-of below create a temporary `PidNamespaceRef` that cannot outlive
> +        // the caller.
> +        unsafe { &*$crate::task::Task::current_pid_ns() }
> +    };
> +}
> +
>  /// Wraps the kernel's `struct task_struct`.
>  ///
>  /// # Invariants
> @@ -145,6 +205,41 @@ fn deref(&self) -> &Self::Target {
>          }
>      }
>  
> +    /// Returns a PidNamespace reference for the currently executing task's/thread's pid namespace.
> +    ///
> +    /// This function can be used to create an unbounded lifetime by e.g., storing the returned
> +    /// PidNamespace in a global variable which would be a bug. So the recommended way to get the
> +    /// current task's/thread's pid namespace is to use the [`current_pid_ns`] macro because it is
> +    /// safe.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the returned object doesn't outlive the current task/thread.
> +    pub unsafe fn current_pid_ns() -> impl Deref<Target = PidNamespace> {
> +        struct PidNamespaceRef<'a> {
> +            task: &'a PidNamespace,
> +            _not_send: NotThreadSafe,
> +        }
> +
> +        impl Deref for PidNamespaceRef<'_> {
> +            type Target = PidNamespace;
> +
> +            fn deref(&self) -> &Self::Target {
> +                self.task
> +            }
> +        }
> +
> +        let pidns = unsafe { bindings::task_active_pid_ns(Task::current_raw()) };
> +        PidNamespaceRef {
> +            // SAFETY: If the current thread is still running, the current task and its associated
> +            // pid namespace are valid. Given that `PidNamespaceRef` is not `Send`, we know it
> +            // cannot be transferred to another thread (where it could potentially outlive the
> +            // current `Task`).
> +            task: unsafe { &*pidns.cast() },
> +            _not_send: NotThreadSafe,
> +        }
> +    }
> +
>      /// Returns the group leader of the given task.
>      pub fn group_leader(&self) -> &Task {
>          // SAFETY: By the type invariant, we know that `self.0` is a valid task. Valid tasks always
> @@ -182,11 +277,23 @@ pub fn signal_pending(&self) -> bool {
>          unsafe { bindings::signal_pending(self.0.get()) != 0 }
>      }
>  
> -    /// Returns the given task's pid in the current pid namespace.
> -    pub fn pid_in_current_ns(&self) -> Pid {
> -        // SAFETY: We know that `self.0.get()` is valid by the type invariant, and passing a null
> -        // pointer as the namespace is correct for using the current namespace.
> -        unsafe { bindings::task_tgid_nr_ns(self.0.get(), ptr::null_mut()) }
> +    /// Returns task's pid namespace with elevated reference count
> +    pub fn task_get_pid_ns(&self) -> Option<ARef<PidNamespace>> {

Given that this is within `Task`, the full name of the function became
`Task::task_get_pid_ns`. So this can just be `get_pid_ns`?

> +        let ptr = unsafe { bindings::task_get_pid_ns(self.0.get()) };
> +        if ptr.is_null() {
> +            None
> +        } else {
> +            // SAFETY: `ptr` is valid by the safety requirements of this function. And we own a
> +            // reference count via `task_get_pid_ns()`.
> +            // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::pid_namespace`.
> +            Some(unsafe { ARef::from_raw(ptr::NonNull::new_unchecked(ptr.cast::<PidNamespace>())) })
> +        }
> +    }
> +
> +    /// Returns the given task's pid in the provided pid namespace.
> +    pub fn task_tgid_nr_ns(&self, pidns: &PidNamespace) -> Pid {

Similarly, this can drop `task_` prefix as it's already scoped to
`Task`.

PS. I think I quite like the more descriptive name in Alice's patch,
maybe `Task::tgid_in_ns` could be a good name for this?

If there's concern about documentation searchability, there is a
feature in rustdoc where you can put

	#[doc(alias = "task_tgid_nr_ns")]

and then the function will be searchable with the C name.

> +        // SAFETY: We know that `self.0.get()` is valid by the type invariant.
> +        unsafe { bindings::task_tgid_nr_ns(self.0.get(), pidns.as_ptr()) }
>      }
>  
>      /// Wakes up the task.
> 
> ---
> base-commit: e9980e40804730de33c1563d9ac74d5b51591ec0
> change-id: 20241001-brauner-rust-pid_namespace-52b0c92c8359
> 
> 

Best,
Gary

