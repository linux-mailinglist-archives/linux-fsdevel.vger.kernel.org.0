Return-Path: <linux-fsdevel+bounces-66361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD536C1CEF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 20:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37AA8581927
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 19:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0275359711;
	Wed, 29 Oct 2025 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hx/9GIUz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B453590B5;
	Wed, 29 Oct 2025 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764863; cv=none; b=L5X424Mzeb4x5Nb8AJYwWutCOH+qKv/ZvQHIqqh0T6r/wnz7VL4HOd3EaEaTZ6AC8z3ld4f61dwURySSPWs9TqkO0StyxrQD7xz9qrSMYAt/FR2CHbFLQfQFNZJbSGpsveOIzlFr+CZ1rT3rM4RFOpuZZ9kg5Sk3pI+3T55lJ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764863; c=relaxed/simple;
	bh=SmwYGicsn9m0OHUOOJiH9i7ncGvQG3j1PcmMujf4lNg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Og233UKZgtJFacMYJIj7kyXGs3O4HvuSorFZqydoh6ZFnR3d6LTSgDeiW8YFDxwA3MuzMhtyuSNpL/0ASYDM/i1KpnBCFg/WRmC6AVU99aRPz5u2Jua1iz5NDQB0hBotSQ5sdpC0amLNe4EKEvKSFKBohvrIneU5nPbU4x9lzS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hx/9GIUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDB8C4CEF7;
	Wed, 29 Oct 2025 19:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761764862;
	bh=SmwYGicsn9m0OHUOOJiH9i7ncGvQG3j1PcmMujf4lNg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hx/9GIUzC6weS+i2CiFEMICfL1ntPu0oH8I8jR1NeERYr75bTL7qChXEoigeKp2ne
	 zAR8l+J28+CW4+GVIzeTUElK8+2VgmjRs/u08bp3F/Drot6nkkJwQE95a7mfgaZxLS
	 VIgdlVv7CV4hi54AFgLtqmqtAORnkqY81MKvtfcq6h2dFuPptpoS59mSb+/1KKlo1F
	 W9Vsk9I9ocLvLgZ7gebPPPJ+0TWQXvM0sTSgyKIjwV5IpvouInDzKdiLqHsG+al2Ix
	 JTOXX21aTqWZphIWkWiHU8bb4XueaelN8t6ALrnVwZoxRI7lms/cd4RuxtZmHcI9gm
	 lKuDVuBEmxGZw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org,  jasonmiu@google.com,  graf@amazon.com,
  changyuanl@google.com,  rppt@kernel.org,  dmatlack@google.com,
  rientjes@google.com,  corbet@lwn.net,  rdunlap@infradead.org,
  ilpo.jarvinen@linux.intel.com,  kanie@linux.alibaba.com,
  ojeda@kernel.org,  aliceryhl@google.com,  masahiroy@kernel.org,
  akpm@linux-foundation.org,  tj@kernel.org,  yoann.congal@smile.fr,
  mmaurer@google.com,  roman.gushchin@linux.dev,  chenridong@huawei.com,
  axboe@kernel.dk,  mark.rutland@arm.com,  jannh@google.com,
  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
  dan.j.williams@intel.com,  david@redhat.com,  joel.granados@kernel.org,
  rostedt@goodmis.org,  anna.schumaker@oracle.com,  song@kernel.org,
  zhangguopeng@kylinos.cn,  linux@weissschuh.net,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-mm@kvack.org,  gregkh@linuxfoundation.org,  tglx@linutronix.de,
  mingo@redhat.com,  bp@alien8.de,  dave.hansen@linux.intel.com,
  x86@kernel.org,  hpa@zytor.com,  rafael@kernel.org,  dakr@kernel.org,
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
  hughd@google.com,  skhawaja@google.com,  chrisl@kernel.org,
  steven.sistare@oracle.com
Subject: Re: [PATCH v4 14/30] liveupdate: luo_session: Add ioctls for file
 preservation and state management
In-Reply-To: <20250929010321.3462457-15-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Mon, 29 Sep 2025 01:03:05 +0000")
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
	<20250929010321.3462457-15-pasha.tatashin@soleen.com>
Date: Wed, 29 Oct 2025 20:07:31 +0100
Message-ID: <mafs0tszhcyrw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Pasha,

On Mon, Sep 29 2025, Pasha Tatashin wrote:

> Introducing the userspace interface and internal logic required to
> manage the lifecycle of file descriptors within a session. Previously, a
> session was merely a container; this change makes it a functional
> management unit.
>
> The following capabilities are added:
>
> A new set of ioctl commands are added, which operate on the file
> descriptor returned by CREATE_SESSION. This allows userspace to:
> - LIVEUPDATE_SESSION_PRESERVE_FD: Add a file descriptor to a session
>   to be preserved across the live update.
> - LIVEUPDATE_SESSION_UNPRESERVE_FD: Remove a previously added file
>   descriptor from the session.
> - LIVEUPDATE_SESSION_RESTORE_FD: Retrieve a preserved file in the
>   new kernel using its unique token.
>
> A state machine for each individual session, distinct from the global
> LUO state. This enables more granular control, allowing userspace to
> prepare or freeze specific sessions independently. This is managed via:
> - LIVEUPDATE_SESSION_SET_EVENT: An ioctl to send PREPARE, FREEZE,
>   CANCEL, or FINISH events to a single session.
> - LIVEUPDATE_SESSION_GET_STATE: An ioctl to query the current state
>   of a single session.
>
> The global subsystem callbacks (luo_session_prepare, luo_session_freeze)
> are updated to iterate through all existing sessions. They now trigger
> the appropriate per-session state transitions for any sessions that
> haven't already been transitioned individually by userspace.
>
> The session's .release handler is enhanced to be state-aware. When a
> session's file descriptor is closed, it now correctly cancels or
> finishes the session based on its current state before freeing all
> associated file resources, preventing resource leaks.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
[...]
> +/**
> + * struct liveupdate_session_get_state - ioctl(LIVEUPDATE_SESSION_GET_STATE)
> + * @size:     Input; sizeof(struct liveupdate_session_get_state)
> + * @incoming: Input; If 1, query the state of a restored file from the incoming
> + *            (previous kernel's) set. If 0, query a file being prepared for
> + *            preservation in the current set.

Spotted this when working on updating my test suite for LUO. This seems
to be a leftover from a previous version. I don't see it being used
anywhere in the code.

Also, I think the model we should have is to only allow new sessions in
normal state. Currently luo_session_create() allows creating a new
session in updated state. This would end up mixing sessions from a
previous boot and sessions from current boot. I don't really see a
reason for that and I think the userspace should first call finish
before starting new serialization. Keeps things simpler.

> + * @reserved: Must be zero.
> + * @state:    Output; The live update state of this FD.
> + *
> + * Query the current live update state of a specific preserved file descriptor.
> + *
> + * - %LIVEUPDATE_STATE_NORMAL:   Default state
> + * - %LIVEUPDATE_STATE_PREPARED: Prepare callback has been performed on this FD.
> + * - %LIVEUPDATE_STATE_FROZEN:   Freeze callback ahs been performed on this FD.
> + * - %LIVEUPDATE_STATE_UPDATED:  The system has successfully rebooted into the
> + *                               new kernel.
> + *
> + * See the definition of &enum liveupdate_state for more details on each state.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +struct liveupdate_session_get_state {
> +	__u32		size;
> +	__u8		incoming;
> +	__u8		reserved[3];
> +	__u32		state;
> +};
> +
> +#define LIVEUPDATE_SESSION_GET_STATE					\
> +	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_GET_STATE)
[...]

-- 
Regards,
Pratyush Yadav

