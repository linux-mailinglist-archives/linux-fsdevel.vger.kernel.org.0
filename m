Return-Path: <linux-fsdevel+bounces-66369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 598C4C1D38A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 21:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A207F34C8B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 20:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A051E351FAE;
	Wed, 29 Oct 2025 20:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n09xHDXm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F024F2773F0;
	Wed, 29 Oct 2025 20:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761770238; cv=none; b=HmsyDxRkuQsdAUmQod9gGK6GzejumHTAgx4DX7cX7D4KI7nUjAjoZYXyztaLDalMujEEVPG2whan6zwhuXLX57wNpKpfa1BGI/H3en7iDknh08Wzjm/xGrBIk5o9yZcMk1q30GmBS9h2uPD30ak79ZaK3XpYDIqxnYIJARapjOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761770238; c=relaxed/simple;
	bh=IpX/Efp/7aa50ROsEckRQKklVIBMT4CdHzNQdUOYZSM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n9k6SuxD6RwO+4n4JYxRIg46q7d2Dl79ZugxQfUGMqODdkmRpIECV+cu+zFC2Bn4D+cB8R75WeAHJSVaRDhdt6vch3ftZ1oAmsNoly0jvTLDkzKQTCveBZtDP4xwJPV0CxwOCc8PSdkX3xWp/kLs6i5gv8ZycbaFF5cUY1pV9Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n09xHDXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0922EC4CEF7;
	Wed, 29 Oct 2025 20:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761770237;
	bh=IpX/Efp/7aa50ROsEckRQKklVIBMT4CdHzNQdUOYZSM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=n09xHDXm0NQvt/2Ihe4zZw4wfbyxmW01sr5F8oIz0+NnVpvOvmas9ZSUBNZuoBGN8
	 yEUJexJrt6G+WaI+v6LoH9gHjUpBA5BgORDfuZmGBbK3TrpvucNv6D2Vzm5utrHI4q
	 pBUL8cT3REaEsOervShr6BCXoflf/q4Zf7hRGKWQfXn9qeY6JQuwrG/JnTCqUmOgc5
	 hT3dN0/xAkSwkHPBtLgg673vpsvLCHWXvgFnnNtDwNVoukqqWeY37QF3Bn8d4S9NOe
	 mYI5z05LwzeakeUjJcmVfE5NKNLhG1ADoKaEcjy+z5rYJLGUcRLtFsViiwUYIno+Xw
	 B2KC49VWJpNWw==
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
Date: Wed, 29 Oct 2025 21:37:06 +0100
Message-ID: <mafs0pla5cuml.fsf@kernel.org>
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
> ---
[...]
> +static int luo_session_restore_fd(struct luo_session *session,
> +				  struct luo_ucmd *ucmd)
> +{
> +	struct liveupdate_session_restore_fd *argp = ucmd->cmd;
> +	struct file *file;
> +	int ret;
> +
> +	guard(rwsem_read)(&luo_state_rwsem);
> +	if (!liveupdate_state_updated())
> +		return -EBUSY;
> +
> +	argp->fd = get_unused_fd_flags(O_CLOEXEC);
> +	if (argp->fd < 0)
> +		return argp->fd;
> +
> +	guard(mutex)(&session->mutex);
> +
> +	/* Session might have already finished independatly from global state */
> +	if (session->state != LIVEUPDATE_STATE_UPDATED)
> +		return -EBUSY;
> +
> +	ret = luo_retrieve_file(session, argp->token, &file);

The retrieve behaviour here causes some nastiness.

When the session is deserialized by luo_session_deserialize(), all the
files get added to the session's files_list. Now when a process
retrieves the session after kexec and restores a file, the file
handler's retrieve callback is invoked, deserializing and restoring the
file. Once deserialization is done, the callback usually frees up the
metadata. All this is fine.

The problem is that the file stays on on the files_list. When the
process closes the session FD, the unpreserve callback is invoked for
all files.

The unpreserve callback should undo what preserve did. That is, free up
serialization data. After a file is restored post-kexec, the things to
free up are different. For example, on a memfd, the folios won't be
pinned anymore. So invoking unpreserve on a retrieved file doesn't work
and causes UAF or other invalid behaviour.

I think you should treat retrieve as a unpreserve as well, and remove
the file from the session's list.

Side note: I see that a lot of code in luo_file.c works with the session
data structures directly. For example, luo_file_deserialize() adds the
file to session->files_list. I think the code would be a lot cleaner and
maintainable if the concerns were clearly separated.
luo_file_deserialize() should focus on deserializing a file given a
compatible and data, and all the dealing with the session's state should
be done by luo_session_deserialize().

luo_file_deserialize() is just an example, but I think the idea can be
applied in more places.

[...]

-- 
Regards,
Pratyush Yadav

