Return-Path: <linux-fsdevel+bounces-21661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A30E90799C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 19:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A501C226D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 17:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E6214B08C;
	Thu, 13 Jun 2024 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="wmFoePTk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2118.outbound.protection.outlook.com [40.107.122.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB4D149C4E;
	Thu, 13 Jun 2024 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718299158; cv=fail; b=beFcxHLnkovi33sFFQ2YYvdKkq4izPTLCY6/9ZrLBlq4jNd1df9GTvho7qce92onTiqwqKKdXTtiaWUJZLl7ZaOGKwkDqdxYVsdAbMF+R5+EgX9cZMsPXvEkaCXfTbAsOoIOipqNfrHzam37LwHkpqfsGr6zMD7ItaxqxYbrwM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718299158; c=relaxed/simple;
	bh=ULQvyDMaTKFJJ8MDjXTcG5wfc5BrZkjsMtlnaDOmYTU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tGsVU26hXgPg+RQDUKV5hNlLhfQeeee1D1APh9Mg4ZsRxx+ub0Zbp9Jnm08HAyy4RVzJBlk6dRHqlweaE3tnE0gIjnxdF77sHn6fSOylcD043M9dy6cjB6cFKPRd4XqJi/Safcs0ihpX8wS3y59waAvOj5H1MCWMx5eBVV18pxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=wmFoePTk; arc=fail smtp.client-ip=40.107.122.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpaI8cttgxXdooPo4xedgHalpRViw1L0olHk5KT2OIQCCrCSxOFKKIhutqgzd1S8CzWHBZIkwDPTYHepaf1SBfeqTvk98SZffJJNkmtkYi72BVtMcDEKdFCPGOIgztLiL3LTPXQ1gNAHO0VnWlVR1H7BmjWisTUxmzrYot9al5zyYdWDu1+DNY6rNN7OX2QMS2k4rQXLAJPn3MkikC6E8EhT0hSlZi9/7E0xQoyWktiMsFADJq1ZtPyuY806cReWuy8CR9Yup1SK3wvhLv/fRBwJivIPp6jXzHFrCX8J6C6IlU5VIkU4CAB2abZ7w4uFnWpZYk2oTOCq6SuKzkujZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3X+LMw5BeLD4uRX5+KpwHODtCEMyh2914cSrarChGBs=;
 b=Jp4QzoZjv9VCl5hDB6hKIkKWdS3hHEQsPt8hJQp6jBWerlrSaEw6Z7ag087BFWEbB00hnQX1d+Q20ovVyeXEkvk4JrU3tOHsTyceEPBHKSWq0OTfqfcYPA02WTPeiMoMRxaWH/tIp73QrYt2dp9nbfqKjWrzcb2ZL0L/5MkngVTwaTA/mXIAwMj9PtnEXepoTy7LQoxcF3ehcyfNcEoWzZQLFYRvWGFENf3ZFGuBOKPUTTcSR1a14s+X8ev8dy7yg/AMa8qF2OdEEjgcog1gQ+d9mTOPUJ862K2PyByMom6o9FUHU0289rmlISK2eXPgDNuBAdY+s/QasJL+Ph41pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3X+LMw5BeLD4uRX5+KpwHODtCEMyh2914cSrarChGBs=;
 b=wmFoePTkosCm03QrDYoI57zcgPjMDYDEEpR8yjXHdvnEnUbU28Epe1t1KqKz1sAyTJW9NooxyV27kd7y9FVFMZKjGf0QI0Q3HDMRQKW66U5pcUKv8i5ZZBUyn1Tc6ZGrAL/4QVncuKl2uuMKV58KQUhtQ5b2ph8ifUTXUO11W8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO9P265MB7760.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3b7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Thu, 13 Jun
 2024 17:19:12 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%5]) with mapi id 15.20.7677.019; Thu, 13 Jun 2024
 17:19:12 +0000
Date: Thu, 13 Jun 2024 18:19:10 +0100
From: Gary Guo <gary@garyguo.net>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, llvm@lists.linux.dev, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida
 Filho <wedsonaf@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Alan
 Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>,
 Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>,
 "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>,
 Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes
 <joel@joelfernandes.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, kent.overstreet@gmail.com, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com, Mark Rutland
 <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>,
 torvalds@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, Trevor Gross <tmgross@umich.edu>,
 dakr@redhat.com
Subject: Re: [RFC 2/2] rust: sync: Add atomic support
Message-ID: <20240613181910.74db809c@eugeo>
In-Reply-To: <ZmseosxVQXdsQjNB@boqun-archlinux>
References: <20240612223025.1158537-1-boqun.feng@gmail.com>
	<20240612223025.1158537-3-boqun.feng@gmail.com>
	<20240613144432.77711a3a@eugeo>
	<ZmseosxVQXdsQjNB@boqun-archlinux>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0287.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::22) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO9P265MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 79560d9f-84a4-4c66-2356-08dc8bccf172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|7416009|1800799019|366011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U6wss7/b9fVAOrEp/ie+Lw01PhK/AESz8H3/ZH4TAGALQ6IvEPebZbHKIG2M?=
 =?us-ascii?Q?N+1cRPp8m7A4Y1NhAbSWBKISngGcIGS75LMGSYCIAawYRlsicmHe893YM2Ag?=
 =?us-ascii?Q?ASqqVpyCUNhlyipFkNJP0D0jgS63hJGLDGPQq1ZT7wGccIXJP7sC9j3zpAAR?=
 =?us-ascii?Q?nOfKj2+GlhvTMZIN/5nLM/LBDkNMB/UwREyX2ie3bTOfp6FiCYbBnMl84Iap?=
 =?us-ascii?Q?sHdVjKpkPprqzB1D9QrBzjlWtixThta3uZgOVjp18Kz1TsNrLvk1o7P6X3+Q?=
 =?us-ascii?Q?9Y5sRRgDTYtzJH0YaBdtw09oplr7d8KlUVjREUBw9CkBTLzKuEPj+WRr8Qey?=
 =?us-ascii?Q?KuTMEbNUL7kowQIFbmn0L+8yptgkq1lyNqOwFKsMuMWW7fK9sW5tSQ2fbjms?=
 =?us-ascii?Q?ZeWpgRvrH9eOjrwEJdIvXNyGk0thuXwcRMPasaCLI86QQr2qSJrDUqht2jmh?=
 =?us-ascii?Q?w9LWW8JzE+HCq8gWKInc2/LiKo5j1onqy+MJ72kqXAM50Zl9ZZE/TX4FQpRI?=
 =?us-ascii?Q?BhULRLkGEo1jUBsC4VrLY9nj0FgV4MU7f18JDXGTGEVvbygU/I3Vha0jZdUz?=
 =?us-ascii?Q?PBYIxgvzO5cdG6AcU+rlQ0f3pdjLAIanOZp/INaPwKIMBYSAHQnm+neZZrNh?=
 =?us-ascii?Q?4dqALPinNTjSO60w2aIk7MfBplTkXBPRbeagVNS0n3lVw0eqrbz5yvUrycxl?=
 =?us-ascii?Q?uGgRA8AKt4J+C6e6o3tWjpWwzcGAPy4Qax79DQv6cxxEzeYUKF9X0ULyVRBQ?=
 =?us-ascii?Q?2+JktQbCGqGSteCLxwi+y/3yMGYMH51UcLLpbscuhQD2cKgi2iwcV1H0XkiZ?=
 =?us-ascii?Q?2ROcQKLGZXQl0xc03jvEzGFS676tW7c3Dna3OzeccLotCfGSRwFEum7IQT4p?=
 =?us-ascii?Q?s3hdFSbDrCxreA8ouVwIN3wzFsFRHoNG2QL/7aCE9y2ZxkVPTJ0aMspVXT5W?=
 =?us-ascii?Q?Ks6Aqua6oHAHXR1n/w5mee/SzR5hE8N+0mwVwsG93oAPNnY24nyvrjmdyjnE?=
 =?us-ascii?Q?I0+ukXTeTQqIDJF4FKEVwE7cvK2AcqGvbl+NEUvvYxoxM9j6jRug5AWSe0DW?=
 =?us-ascii?Q?Vca/JrOa/JaKJghmlw04pV+tW4xpNF+xDjEFZ7yDfDX4BqFE2o9i95+8ngbR?=
 =?us-ascii?Q?1pWX85C62U/SioFIUjGs55MQmbuWK/DcBg7xd+DFrBFigyYpEoZu10PCNXSG?=
 =?us-ascii?Q?A5k2Qzfk43oHsZ6RvZxqS5tLKsFySjVhZ8GmSEJKWrrDgfFL6jBFDYEVYZ5G?=
 =?us-ascii?Q?6Zo3bJSBcP1E8rmBIJLw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230035)(376009)(7416009)(1800799019)(366011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RHNG2x6SwDE5iCEHZXMc/lucISQQAQgG40p2JdjXjTz03uisbY41/JoVjvpv?=
 =?us-ascii?Q?DLxpw7XeTk+pTXyRB20s4j+ArTs3/S348YOnoK2qfnsreleMpn5NAwrgdTmH?=
 =?us-ascii?Q?f72fU5Hi1/FkATEUwDRsEe3t1THnp5/gTRlT0RWkX/THXLM7KO9PhhUXPlFr?=
 =?us-ascii?Q?nO2GtJfoCDZIfhDFrfvbdeW0gzinXma0Yiqy0Q5gquMj2tPHyJw9ftst2/8/?=
 =?us-ascii?Q?5lae4fz5l1JXrCcdwN9kjB1VURcugLzGhMmCXjSUfrMD3hWyea6nr8D06zrU?=
 =?us-ascii?Q?dFMbMGn/ICawnrxgUDOY86foad8/VjYiosxKOVFfT5j1r7G6Fe39ejQuITcs?=
 =?us-ascii?Q?QnQEx0os6Bh26deuZ1znh/eRsYXr+8Cl+G53GN4YVUe2WQickiU2F7t6CanA?=
 =?us-ascii?Q?e12/dXAJCR2LgOk3jw42mE3rByMh6g1Nc8PwdngIE4kOmV2hPgLn2gL1Qp0y?=
 =?us-ascii?Q?Xg4QydRrtE+jHiQyCXzWWEEl8v6CyIizK7dQ0gE/KqflKxZXPHmZ9hhUIUgg?=
 =?us-ascii?Q?snvIQbFFUEnGc29V3lOzz0KkU2wtnjBD6VXf5MVG2GOWW7E/X+/GgV8hqP+z?=
 =?us-ascii?Q?5c4DPMn2i/pE0abNoKj/Z/jV1zEldJcEPehtj5dez0EMIDapfDK2DDdamYI3?=
 =?us-ascii?Q?92H4e2OebvS/4Bjpeg02Zd2ufxUvBKlizD/ect/nvzVbI0CTU+D3B9vte7bo?=
 =?us-ascii?Q?tieQnQWwZhQIBWIHp3PZCsyzjuLoK+NPg2oNzirtVmfmNgOvssn2s9G3AY9h?=
 =?us-ascii?Q?7u6r2qCh/iCrVQGDDjxqPy1MWoXKmk8c9ZNyhNPE+EmRWz9P5zOGW0ixckxJ?=
 =?us-ascii?Q?jjBuF+iFqMbQGU/op30h4SSsrpgd66mbtUx03I4EHxtmhUeGF0FihcUHAuN0?=
 =?us-ascii?Q?avrKEZSpmdzp06a0Oe4g3P34F4eWfYG07UYHB5YGnTZ2XnJ29ptF3XyWmn7H?=
 =?us-ascii?Q?ao+WXN79zadgiWIu5M1aXj7q98QX/Qy/ITR3q0lJjq4p5atsPrMo66MxyKjD?=
 =?us-ascii?Q?7ZkE5FMtot0UrRyGAEp+R/PM/MN5jN3mnDMtQCWLvNd+RRa4fF7gW9vw7fve?=
 =?us-ascii?Q?nRRYX8C5ovafWfSN26y3wFIMJH6PdFM9wRBjWECWNEeb6yinSxVGHigL8q45?=
 =?us-ascii?Q?yV78MM5gU3JbbeMpBxdet+JkRSNWAUM3UEtkAxTVh8ny79cwj3eaPkDrW+JK?=
 =?us-ascii?Q?VjAi1UWw0M6nZCFLUDE3GBFrSQ+oStv42BROcyxwgfIWqmgVRvBU5y5uRCi3?=
 =?us-ascii?Q?3qTvjEYYwk+hW++Uv0y8XZ1sBg8vFaAxDOC2C235cJ/xev/sn0Nz5dLQ4kAh?=
 =?us-ascii?Q?hGpszRALiMdH71wLRHB5bdNAr6ddQem3f5Q3D58g0dT8TE3poEzemHF1LuFC?=
 =?us-ascii?Q?phKADylw9kq8bwhsyOokOvQedaH1FvojTMH7XbfZjkB3otOWMPK4p+0QwUXM?=
 =?us-ascii?Q?3ormOxtIaoW10WwH/eO0GgpWVxkFmYgz3m8nRlRb8lJCW91kyxmYsYk6CKNt?=
 =?us-ascii?Q?Jj4CM27ssb6sbwQs9G4yLHixjt66d641EEtj6VJKP1uR2P+OHOcEjVL64a5V?=
 =?us-ascii?Q?GPWtBSmf9a2HZczkNQvICOwWUsouyuCyhEf7nA8E?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 79560d9f-84a4-4c66-2356-08dc8bccf172
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 17:19:12.1616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fT8x6yZZy3OIvuAQ4OfZvO8cRk+glYF+vVJ3uDT/aw0jpit6BNw/8jDjggaAay7y1xMtBJyGNMVLpKpSV9IFnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7760

On Thu, 13 Jun 2024 09:30:26 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> > > diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> > > new file mode 100644
> > > index 000000000000..b0f852cf1741
> > > --- /dev/null
> > > +++ b/rust/kernel/sync/atomic.rs
> > > @@ -0,0 +1,63 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +//! Atomic primitives.
> > > +//!
> > > +//! These primitives have the same semantics as their C counterparts, for precise definitions of
> > > +//! the semantics, please refer to tools/memory-model. Note that Linux Kernel Memory (Consistency)
> > > +//! Model is the only model for Rust development in kernel right now, please avoid to use Rust's
> > > +//! own atomics.
> > > +
> > > +use crate::bindings::{atomic64_t, atomic_t};
> > > +use crate::types::Opaque;
> > > +
> > > +mod r#impl;
> > > +
> > > +/// Atomic 32bit signed integers.
> > > +pub struct AtomicI32(Opaque<atomic_t>);
> > > +
> > > +/// Atomic 64bit signed integers.
> > > +pub struct AtomicI64(Opaque<atomic64_t>);
> > 
> > 
> > Can we avoid two types and use a generic `Atomic<T>` and then implement
> > on `Atomic<i32>` and `Atomic<i64>` instead? Like the recent
> > generic NonZero in Rust standard library or the atomic crate
> > (https://docs.rs/atomic/).
> > 
> 
> We can always add a layer on top of what we have here to provide the
> generic `Atomic<T>`. However, I personally don't think generic
> `Atomic<T>` is a good idea, for a few reasons:
> 
> *	I'm not sure it will bring benefits to users, the current atomic
> 	users in kernel are pretty specific on the size of atomic they
> 	use, so they want to directly use AtomicI32 or AtomicI64 in
> 	their type definitions rather than use a `Atomic<T>` where their
> 	users can provide type later.

You can write `Atomic<i32>` and `Atomic<i64>`.

> 
> *	I can also see the future where we have different APIs on
> 	different types of atomics, for example, we could have a:
> 
> 		impl AtomicI64 {
> 		    pub fn split(&self) -> (&AtomicI32, &AtomicI32)
> 		}
> 
> 	which doesn't exist for AtomicI32. Note this is not a UB because
> 	we write our atomic implementation in asm, so it's perfectly
> 	fine for mix-sized atomics.

You can still have

	impl Atomic<i64> {
	    pub fn split(&self) -> (&Atomic<i32>, &Atomic<i32>)
	}

I see `Atomic<i32>/Atomic<i64>` being generally more flexible than
`AtomicI32/AtomicI64`, without very little downsides. We may not have
generic users but I think it doesn't do any harm to have it in a form
that makes future generics easy.

Best,
Gary

