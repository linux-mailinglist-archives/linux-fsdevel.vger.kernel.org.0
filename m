Return-Path: <linux-fsdevel+bounces-69699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C14C8171B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 16:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 813DB3463BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 15:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8388D314B66;
	Mon, 24 Nov 2025 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3MFTO6o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDDE2D59F7;
	Mon, 24 Nov 2025 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763999812; cv=none; b=eVgqsCyGpullXxD+S3DuRLvurFwwQ3jMKDwh14UYwfr3bj9V60bYGUm+bj2U/pi2PCwT4evQQbWnZJnDrtJsBU3TzBAMw4naQwhRWUQixxiO3QSkYZ1SfRyTf/Tsx2RJA4JAjSJaiOVIycNe7/Y0uMrQy65W2FqmbEK/xQrIxJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763999812; c=relaxed/simple;
	bh=y63yvMXGRSUR5hsa5yj3y5bNOs9e+r2tXeZwg4ggXb8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PNALYrx4rAd2WnZz+YboGBBXCOUHOc62l76Dm1WjmPETat1x7NYOseMrvrsqU4amEgT2gNJyvZWBrZKueMim2cCK8m970FaLjssV6qoBg9HqBZrq8zYzZqRp9b4FMKE2P4Rgekt1irlwzgi3DuHDripW/h8Xw37xrHT88Ihb1iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3MFTO6o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C15C4CEF1;
	Mon, 24 Nov 2025 15:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763999812;
	bh=y63yvMXGRSUR5hsa5yj3y5bNOs9e+r2tXeZwg4ggXb8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=t3MFTO6oJzw4eL7xPmfLcDdWjwmXfWH6/xWxMWM8CQnbFA3+M27qnQlQZEZEAFSsb
	 bnal+s2Ox/0TWQ+7JFrfNqo34Dw0GnW4t7NbtnrXlDY0iyhvWMyxTGaMY5dlgNNCvG
	 m+5ZOBamHjaWXtD6w3VOKIoicFlyHYBpgotrFC7Gslxa+QyKvdsO8sN+QqXK+OnRnN
	 eTjVY7JVQnmZDKBIRT7UZrg7yiMjHJ7jIvotIB1E8raHNQsV8TDSYDToYVJVepxr+e
	 WOjOo05vwhIEe9IZm5LQY0wvYx9GNlvSYWINRBBU+gCmdDHmxrTfdS7cjDxaucLWS/
	 bJEKQS66cC2Og==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org,  jasonmiu@google.com,  graf@amazon.com,
  rppt@kernel.org,  dmatlack@google.com,  rientjes@google.com,
  corbet@lwn.net,  rdunlap@infradead.org,  ilpo.jarvinen@linux.intel.com,
  kanie@linux.alibaba.com,  ojeda@kernel.org,  aliceryhl@google.com,
  masahiroy@kernel.org,  akpm@linux-foundation.org,  tj@kernel.org,
  yoann.congal@smile.fr,  mmaurer@google.com,  roman.gushchin@linux.dev,
  chenridong@huawei.com,  axboe@kernel.dk,  mark.rutland@arm.com,
  jannh@google.com,  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
  dan.j.williams@intel.com,  david@redhat.com,  joel.granados@kernel.org,
  rostedt@goodmis.org,  anna.schumaker@oracle.com,  song@kernel.org,
  linux@weissschuh.net,  linux-kernel@vger.kernel.org,
  linux-doc@vger.kernel.org,  linux-mm@kvack.org,
  gregkh@linuxfoundation.org,  tglx@linutronix.de,  mingo@redhat.com,
  bp@alien8.de,  dave.hansen@linux.intel.com,  x86@kernel.org,
  hpa@zytor.com,  rafael@kernel.org,  dakr@kernel.org,
  bartosz.golaszewski@linaro.org,  cw00.choi@samsung.com,
  myungjoo.ham@samsung.com,  yesanishhere@gmail.com,
  Jonathan.Cameron@huawei.com,  quic_zijuhu@quicinc.com,
  aleksander.lobakin@intel.com,  ira.weiny@intel.com,
  andriy.shevchenko@linux.intel.com,  leon@kernel.org,  lukas@wunner.de,
  bhelgaas@google.com,  wagi@kernel.org,  djeffery@redhat.com,
  stuart.w.hayes@gmail.com,  lennart@poettering.net,  brauner@kernel.org,
  linux-api@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  saeedm@nvidia.com,  ajayachandra@nvidia.com,  jgg@nvidia.com,
  parav@nvidia.com,  leonro@nvidia.com,  witu@nvidia.com,
  hughd@google.com,  skhawaja@google.com,  chrisl@kernel.org
Subject: Re: [PATCH v7 16/22] selftests/liveupdate: Add userspace API selftests
In-Reply-To: <20251122222351.1059049-17-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Sat, 22 Nov 2025 17:23:43 -0500")
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
	<20251122222351.1059049-17-pasha.tatashin@soleen.com>
Date: Mon, 24 Nov 2025 16:56:42 +0100
Message-ID: <mafs0ecpnxw3p.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Nov 22 2025, Pasha Tatashin wrote:

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

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

