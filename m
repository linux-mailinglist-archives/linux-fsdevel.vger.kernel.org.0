Return-Path: <linux-fsdevel+bounces-69625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5905C7F007
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 06:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014DB3A5300
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 05:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A07227B83;
	Mon, 24 Nov 2025 05:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N73ygbiK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFEE4A21;
	Mon, 24 Nov 2025 05:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763962274; cv=none; b=Jy5yxHaUz7xI6lIGeJFte6M9qeW3aLCKBQ1yr2wGn+F/qtHqaaXf0WL4ajfl3aOkLLN3Y/aj4e2YFXZ9FMOZFbXBDIIuMm789aCbDq8lzpZdIG4FX21T8gZ34Fm7dMbq4p8u1RJ32Qk4v10arE/f4zT+VdGEmdimdbTBvkWYxd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763962274; c=relaxed/simple;
	bh=RWeJY9pJHBZ5U4aPZuJw/0Z5j5nXGO9gJXgSoHnl1Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilPbX4KJmZkPoQJY2+eFCQKFrEpw8q/7SKe599paFhBcduUJ8IIu5CgZfreUOc+ykXj/7Ok4qANeA1ChfWae6kjPUfVPsrMKfULQgEyYWX5aDvOOL8ZwcJ+zanOYTVluzYkHY9hEAHYBbLJF+IEA9c+8Rf+TEOJLBoc7K2NPiYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N73ygbiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4672EC4CEF1;
	Mon, 24 Nov 2025 05:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763962274;
	bh=RWeJY9pJHBZ5U4aPZuJw/0Z5j5nXGO9gJXgSoHnl1Jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N73ygbiKs2BhPqYtlO5jZRWbVaKbo+e+4T+IqZEHKKEzdE9g2qMn3x8qjg/NYZdpK
	 RwOVa+22eRllg+5Y4ES4PXmjeHKwgi9j+fXiPfzAa7Temd8Vgh8CHpgEGbyuX990Sj
	 HzaB7m9tXVgfRD+z9Bvkf7uqmUod3QhA/SL/AKuRI13cwf5NKDEJwQfDnQnE2+6MgP
	 hPK2YB2ddPSiJiIDxLCU3yxjj4dNFLk2qGt/HqPcnPBgN/T01TVf7wqkN0GaozFfJ+
	 npHKpCkjKuRjZS/cCD9GnWqf1KyMu2kc1yy5pVZkokJh6FkUyQVtDHVtOOXT32Q7eR
	 4q7LnRP9e7lOg==
Date: Mon, 24 Nov 2025 07:30:49 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com,
	skhawaja@google.com, chrisl@kernel.org
Subject: Re: [PATCH v7 18/22] selftests/liveupdate: Add kexec test for
 multiple and empty sessions
Message-ID: <aSPtiYSV9vkYvlBD@kernel.org>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-19-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122222351.1059049-19-pasha.tatashin@soleen.com>

On Sat, Nov 22, 2025 at 05:23:45PM -0500, Pasha Tatashin wrote:
> Introduce a new kexec-based selftest, luo_kexec_multi_session, to
> validate the end-to-end lifecycle of a more complex LUO scenario.
> 
> While the existing luo_kexec_simple test covers the basic end-to-end
> lifecycle, it is limited to a single session with one preserved file.
> This new test significantly expands coverage by verifying LUO's ability
> to handle a mixed workload involving multiple sessions, some of which
> are intentionally empty. This ensures that the LUO core correctly
> preserves and restores the state of all session types across a reboot.
> 
> The test validates the following sequence:
> 
> Stage 1 (Pre-kexec):
> 
>   - Creates two empty test sessions (multi-test-empty-1,
>     multi-test-empty-2).
>   - Creates a session with one preserved memfd (multi-test-files-1).
>   - Creates another session with two preserved memfds
>     (multi-test-files-2), each containing unique data.
>   - Creates a state-tracking session to manage the transition to
>     Stage 2.
>   - Executes a kexec reboot via the helper script.
> 
> Stage 2 (Post-kexec):
> 
>   - Retrieves the state-tracking session to confirm it is in the
>     post-reboot stage.
>   - Retrieves all four test sessions (both the empty and non-empty
>     ones).
>   - For the non-empty sessions, restores the preserved memfds and
>     verifies their contents match the original data patterns.
>   - Finalizes all test sessions and the state session to ensure a clean
>     teardown and that all associated kernel resources are correctly
>     released.
> 
> This test provides greater confidence in the robustness of the LUO
> framework by validating its behavior in a more realistic, multi-faceted
> scenario.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  tools/testing/selftests/liveupdate/Makefile   |   1 +
>  .../selftests/liveupdate/luo_multi_session.c  | 162 ++++++++++++++++++
>  2 files changed, 163 insertions(+)
>  create mode 100644 tools/testing/selftests/liveupdate/luo_multi_session.c

-- 
Sincerely yours,
Mike.

