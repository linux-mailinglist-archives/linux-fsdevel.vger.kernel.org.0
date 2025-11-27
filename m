Return-Path: <linux-fsdevel+bounces-70052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C6DC8F9A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 18:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B3DF343C59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 17:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68142DF153;
	Thu, 27 Nov 2025 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="nF4qk+Fn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D162DF3CC
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 17:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764263250; cv=none; b=B7XvlvoE5BhUmfqMjsIQBnDS1Ni9Z0Bby+m7H3g6mFaB3n7/bsvij56UaLB+6++QwPutTRLUV4QB5NbEcnBv+446afW1kG340U0/pLs9zZX2oAr/6nTQHNYimeXMqnfFPbHObkU0UBuc4+0lQp1SYkseMqF1239kvZoPQSWp6O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764263250; c=relaxed/simple;
	bh=yKfoAhUeNlemorcYxw4yL14VYNrcxGWoQXtJzYJZsZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1YkUs2ZpeXVB1FPrNRHDIiURfmiv5m6wGZwEXHptKv0s/fY71qE1eTrv68QkSSZjqMWhAn0CoBhWG/f4jWQiGuxWiWkS2nsl7Y9RqhTBBgfH8xEdWc4VmgwXI6iGXurIyzxuGxar6yTj3wQKDgEt7E4q+8mAg0s/HNFv1g0TAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=nF4qk+Fn; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dHMqZ1YhfzGWS;
	Thu, 27 Nov 2025 17:50:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1764262218;
	bh=/joIQd3Z2tdeV5NEK5aDhgrlOaIXqRbtYcvTxLNMBZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nF4qk+FnK9epBbjtFGhWFceXUdPA6r1gfu2cwUbFI0wMA2r8o6GPk/MAHr9njetj7
	 qWfss5FPqbYnxoIn0mZf4D4vGCJFUcFVVGAdLToxx9EvLdOZepFv+HCMXvhJuhVEe7
	 jNZp6NkfaI90eNFmxXlnPeudnghUDwnFoOU06c60=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dHMqY0ZfpzXkx;
	Thu, 27 Nov 2025 17:50:16 +0100 (CET)
Date: Thu, 27 Nov 2025 17:49:45 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Tingmao Wang <m@maowtm.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Ben Scarlato <akhna@google.com>, 
	Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Justin Suess <utilityemal77@gmail.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Paul Moore <paul@paul-moore.com>, Song Liu <song@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Matthieu Buffet <matthieu@buffet.re>, NeilBrown <neil@brown.name>
Subject: Re: [PATCH v4 4/4] selftests/landlock: Add disconnected leafs and
 branch test suites
Message-ID: <20251127.Zoogohsei6ie@digikod.net>
References: <20251126191159.3530363-1-mic@digikod.net>
 <20251126191159.3530363-5-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251126191159.3530363-5-mic@digikod.net>
X-Infomaniak-Routing: alpha

On Wed, Nov 26, 2025 at 08:11:57PM +0100, Mickaël Salaün wrote:
> Test disconnected directories with two test suites and 31 variants to
> cover the main corner cases.
> 
> These tests are complementary to the previous commit.
> 
> Add test_renameat() and test_exchangeat() helpers.
> 
> Test coverage for security/landlock is 92.1% of 1927 lines according to
> LLVM 20.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Song Liu <song@kernel.org>
> Cc: Tingmao Wang <m@maowtm.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> 
> Changes since v3:
> - Update tests to reflect the new approach:
>   * layout4_disconnected_leafs.s1d41_s1d42_disconnected: allow all
>   * layout4_disconnected_leafs.s3d1_s4d1_new_parent: allow all
>   * layout4_disconnected_leafs.f1_f2_f3: allow read
>   * layout5_disconnected_branch.s2d3_mount1_dst_parent: allow all
>   * layout5_disconnected_branch.s4d1_rename_parent: allow all
> - Update test coverage.
> 
> Changes since v2:
> - Update test coverage.
> 
> Changes since v1:
> - Rename layout4_disconnected to layout4_disconnected_leafs.
> - Fix variable names.
> - Add layout5_disconnected_branch test suite with 19 variants to cover
>   potential implementation issues.
> ---
>  tools/testing/selftests/landlock/fs_test.c | 912 +++++++++++++++++++++
>  1 file changed, 912 insertions(+)

> +/*
> + * layout5_disconnected_branch before rename:
> + *
> + * tmp
> + * ├── s1d1
> + * │   └── s1d2 [source of the first bind mount]
> + * │       └── s1d3
> + * │           ├── s1d41
> + * │           │   ├── f1
> + * │           │   └── f2
> + * │           └── s1d42
> + * │               ├── f3
> + * │               └── f4
> + * ├── s2d1
> + * │   └── s2d2 [source of the second bind mount]
> + * │       └── s2d3
> + * │           └── s2d4 [first s1d2 bind mount]
> + * │               └── s1d3
> + * │                   ├── s1d41
> + * │                   │   ├── f1
> + * │                   │   └── f2
> + * │                   └── s1d42
> + * │                       ├── f3
> + * │                       └── f4
> + * ├── s3d1
> + * │   └── s3d2 [second s2d2 bind mount]
> + * │       └── s2d3
> + * │           └── s2d4 [first s1d2 bind mount]
> + * │               └── s1d3
> + * │                   ├── s1d41
> + * │                   │   ├── f1
> + * │                   │   └── f2
> + * │                   └── s1d42
> + * │                       ├── f3
> + * │                       └── f4
> + * └── s4d1
> + *
> + * After rename:
> + *
> + * tmp
> + * ├── s1d1
> + * │   └── s1d2 [source of the first bind mount]
> + * │       └── s1d3
> + * │           ├── s1d41
> + * │           │   ├── f1
> + * │           │   └── f2
> + * │           └── s1d42
> + * │               ├── f3
> + * │               └── f4
> + * ├── s2d1
> + * │   └── s2d2 [source of the second bind mount]
> + * ├── s3d1
> + * │   └── s3d2 [second s2d2 bind mount]
> + * └── s4d1
> + *     └── s2d3 [renamed here]
> + *         └── s2d4 [first s1d2 bind mount]
> + *             └── s1d3
> + *                 ├── s1d41
> + *                 │   ├── f1
> + *                 │   └── f2
> + *                 └── s1d42
> + *                     ├── f3
> + *                     └── f4
> + *
> + * Decision path: s1d3 -> s1d2 -> s2d2 -> s3d1 -> tmp
> + * s2d3 is ignored, as well as the directories under the mount points.

I didn't update this comment, here is the new one:

 * Decision path for access from the s3d1/s3d2/s2d3/s2d4/s1d3 file descriptor:
 *   1. first bind mount:   s1d3 -> s1d2
 *   2. second bind mount:    s2d3
 *   3. tmp mount:              s4d1 -> tmp [disconnected branch]
 *   4. second bind mount:        s2d2
 *   5. tmp mount:                  s3d1 -> tmp
 *   6. parent mounts:                [...] -> /
 *
 * The s4d1 directory is evaluated even if it is not in the s2d2 mount.

