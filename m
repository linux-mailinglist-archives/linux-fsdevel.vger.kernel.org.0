Return-Path: <linux-fsdevel+bounces-69624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E8EC7EFFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 06:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 75AE63455D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 05:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B642D2490;
	Mon, 24 Nov 2025 05:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRnghpgd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CEA28850B;
	Mon, 24 Nov 2025 05:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763962200; cv=none; b=KaAfIHKqxyFGsqcRPzSOz7YfpssagR++bAYbM4JKkp8qVO47SD8RYXJdth1re1QO5nlR4jpvp0q/qDSm7ZomtJ647Yt8xezdqUjtl/AK34cWSyGd+e11SCGWw0RB0qRDaoGlriY1s4XaV0WTfffPj8RvEdhvXBYsrvafNJ+hGMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763962200; c=relaxed/simple;
	bh=avcnQohM/OC7Wf4uBeH1QDfwgtHGDe/RN/kIl6nBXVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e504odXY+6wGN8ugE1X03/JuQhwpuj4M5kf3HnI7l2WOMnL/xvFLFq1OQXZEkPzUEizoaf3GoBmwwMGICk0NiViIbXCZ6qw9eRJC5AtfiC/MvFOYaAFSLWjjmY0ycIG+KGKN09BsK3xe1yg+k0IL6puYwG1jnxUElK6VIy1MfD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRnghpgd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0F4C4CEF1;
	Mon, 24 Nov 2025 05:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763962199;
	bh=avcnQohM/OC7Wf4uBeH1QDfwgtHGDe/RN/kIl6nBXVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MRnghpgd13pRJdYK6+YcIVwuhCJU32S6SQktdN6Mq+ySxvLUOGgr0o8gnuO66HPK1
	 h66cNv/2EeVpqH+4atks6LnJT68kY/kLaiDptOqUUY3374opwcfNE6Odr7cOpnbB4A
	 Rc72VNiqRugdTTPVTaaseoGDWgodD4EMggXgRsIjF/yVN/7rQnDrjgdh5JHgB5SHbG
	 hn8jjeu95Jk6G7boj0DuB5csL1KP9cPJj/Wg0VZYOJbcsWes1anOGRHHkQCCphdyE7
	 BsJnsCsvlrKE7JtLYsf/8iLqNlQC0EHW+/SgxVNp0lrt8b9VT0FDr1FwoGvLLnVcWr
	 FWBqSXX7nAC1A==
Date: Mon, 24 Nov 2025 07:29:34 +0200
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
Subject: Re: [PATCH v7 17/22] selftests/liveupdate: Add kexec-based selftest
 for
Message-ID: <aSPtPuBUcVT5Rifl@kernel.org>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-18-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251122222351.1059049-18-pasha.tatashin@soleen.com>

On Sat, Nov 22, 2025 at 05:23:44PM -0500, Pasha Tatashin wrote:
> Subject: selftests/liveupdate: Add kexec-based selftest for

                                                         ^ for what? ;-)

> Introduce a kexec-based selftest, luo_kexec_simple, to validate the
> end-to-end lifecycle of a Live Update Orchestrator (LUO) session across
> a reboot.
> 
> While existing tests verify the uAPI in a pre-reboot context, this test
> ensures that the core functionality—preserving state via Kexec Handover
> and restoring it in a new kernel—works as expected.
> 
> The test operates in two stages, managing its state across the reboot by
> preserving a dedicated "state session" containing a memfd. This
> mechanism dogfoods the LUO feature itself for state tracking, making the
> test self-contained.
> 
> The test validates the following sequence:
> 
> Stage 1 (Pre-kexec):
>  - Creates a test session (test-session).
>  - Creates and preserves a memfd with a known data pattern into the test
>    session.
>  - Creates the state-tracking session to signal progression to Stage 2.
>  - Executes a kexec reboot via a helper script.
> 
> Stage 2 (Post-kexec):
>  - Retrieves the state-tracking session to confirm it is in the
>    post-reboot stage.
>  - Retrieves the preserved test session.
>  - Restores the memfd from the test session and verifies its contents
>    match the original data pattern written in Stage 1.
>  - Finalizes both the test and state sessions to ensure a clean
>    teardown.
> 
> The test relies on a helper script (do_kexec.sh) to perform the reboot
> and a shared utility library (luo_test_utils.c) for common LUO
> operations, keeping the main test logic clean and focused.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  tools/testing/selftests/liveupdate/Makefile   |   6 +
>  .../testing/selftests/liveupdate/do_kexec.sh  |  16 ++
>  .../selftests/liveupdate/luo_kexec_simple.c   |  89 ++++++
>  .../selftests/liveupdate/luo_test_utils.c     | 266 ++++++++++++++++++
>  .../selftests/liveupdate/luo_test_utils.h     |  44 +++
>  5 files changed, 421 insertions(+)
>  create mode 100755 tools/testing/selftests/liveupdate/do_kexec.sh
>  create mode 100644 tools/testing/selftests/liveupdate/luo_kexec_simple.c
>  create mode 100644 tools/testing/selftests/liveupdate/luo_test_utils.c
>  create mode 100644 tools/testing/selftests/liveupdate/luo_test_utils.h

-- 
Sincerely yours,
Mike.

