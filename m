Return-Path: <linux-fsdevel+bounces-69623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6224CC7EFE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 06:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D62903444B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 05:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170C32D2387;
	Mon, 24 Nov 2025 05:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhFRjbNJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4C71B4138;
	Mon, 24 Nov 2025 05:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763961916; cv=none; b=bjEIBoksfcq+jSkwVDkxd+4CcAkEYAU5GO4iYvO5mehLZhwTIr4ERsm1R1R6nlelcyOstJG6lLI7JcwaX1veVOzCSRKmCMr8NRdV1geViHYQiH3Jf/oDpdotg7k4hvL/9M9wwLWWlGK53Z674SBYivodhUkTJYjAZ6zspWGdOyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763961916; c=relaxed/simple;
	bh=hL+WuH16BodbGdYWuFoGGzwEFzfedl2zaIxXHQ/7Fh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qh1mqKUPN8ZmpFC1C+nTIqC22KbjWoecm/n6S2UIMwLUGBTasRt4g5k2z2U0/23Bbtsnm7kz3jEJsGRCKI/gQI1dSJoD1uPbCChCb7mHdfBcowhBlkEPn5ZvUAoqV/bSgx7PIuvTJ/4BWc11EbQXufhZ+R7VqD/y8/noys2ogts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhFRjbNJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903C0C4CEF1;
	Mon, 24 Nov 2025 05:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763961914;
	bh=hL+WuH16BodbGdYWuFoGGzwEFzfedl2zaIxXHQ/7Fh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lhFRjbNJw060eoWLi2/Kwsm6uYipzROQU74BjALZaDsbs2kf8nJfYdXhoSf/DhSCy
	 wcYfchkquawskyiHSEaSupeop0R3M6TiaUFEitaxBBw7fikyI2BjmqPX1TTWSO53t4
	 6k+zodPUDaiYy8SL3EcWlbQ+ZB31H3c7ylAeWvi/Dfl/gW1pESvWZmStm97TVdletG
	 tHGUH9HNWcXPe/09wKDEsH+MGWhBMfcHWA12vMSXqFifdncJOj48O/vsVhGfCxbfzn
	 QT7U2wSN0rRcaeSeOmgtIpiTwVdi/iXHGjWjcIRH4WihsB8MqXnGOoVeqTmXI/gxPX
	 hfQm1K4vovJWw==
Date: Mon, 24 Nov 2025 07:24:50 +0200
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
Subject: Re: [PATCH v7 16/22] selftests/liveupdate: Add userspace API
 selftests
Message-ID: <aSPsIgXuJJvD4RSk@kernel.org>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-17-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122222351.1059049-17-pasha.tatashin@soleen.com>

On Sat, Nov 22, 2025 at 05:23:43PM -0500, Pasha Tatashin wrote:
> Introduce a selftest suite for LUO. These tests validate the core
> userspace-facing API provided by the /dev/liveupdate device and its
> associated ioctls.
> 
> The suite covers fundamental device behavior, session management, and
> the file preservation mechanism using memfd as a test case. This
> provides regression testing for the LUO uAPI.
> 
> The following functionality is verified:
> 
> Device Access:
>     Basic open and close operations on /dev/liveupdate.
>     Enforcement of exclusive device access (verifying EBUSY on a
>     second open).
> 
> Session Management:
>     Successful creation of sessions with unique names.
>     Failure to create sessions with duplicate names.
> 
> File Preservation:
>     Preserving a single memfd and verifying its content remains
>     intact post-preservation.
>     Preserving multiple memfds within a single session, each with
>     unique data.
>     A complex scenario involving multiple sessions, each containing
>     a mix of empty and data-filled memfds.
> 
> Note: This test suite is limited to verifying the pre-kexec
> functionality of LUO (e.g., session creation, file preservation).
> The post-kexec restoration of resources is not covered, as the kselftest
> framework does not currently support orchestrating a reboot and
> continuing execution in the new kernel.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  MAINTAINERS                                   |   1 +
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/liveupdate/.gitignore |   9 +
>  tools/testing/selftests/liveupdate/Makefile   |  27 ++
>  tools/testing/selftests/liveupdate/config     |  11 +
>  .../testing/selftests/liveupdate/liveupdate.c | 348 ++++++++++++++++++
>  6 files changed, 397 insertions(+)
>  create mode 100644 tools/testing/selftests/liveupdate/.gitignore
>  create mode 100644 tools/testing/selftests/liveupdate/Makefile
>  create mode 100644 tools/testing/selftests/liveupdate/config
>  create mode 100644 tools/testing/selftests/liveupdate/liveupdate.c

-- 
Sincerely yours,
Mike.

