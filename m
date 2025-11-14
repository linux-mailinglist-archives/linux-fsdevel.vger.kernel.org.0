Return-Path: <linux-fsdevel+bounces-68487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7442C5D31D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 13:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E76493AFF83
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 12:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86275246798;
	Fri, 14 Nov 2025 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmjz1HLD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61D3240604;
	Fri, 14 Nov 2025 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763125084; cv=none; b=Fj+TF9NqlVCbB720rs4bnhwbO+e+1+xQnlbykyyYdbBpUOViQFhhPCYhb8LVrGXYnTUG4EntpXcnxkiQEqyOwG55kZN3lruna/iJ71ARv+bie1BSKSDkf56tpCkMe26dEc1hOlbComjLho7AqInSEm3S/YV6G3hVEgRrmtpMw5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763125084; c=relaxed/simple;
	bh=TRk5CRDCjCUBl34vCSFEaD0Pky1Npmrx67ErLaAFNWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqYDTlH253OYkVEAd+tEZOyVMoX+zT+tkfKCOfD55bDrkbKUa9aBDMpctQ/pDwoZ62D8nYQuvdGvmNPyF4zGY/z0zFSne4aBWbjAadCEFkNwIZ9Sk2puwN+P5fHRC/9a1VlEEGJupvw/ZuVnukXdhcBrHLeZTo7aU0kHQ9qdyWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmjz1HLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591EDC4CEFB;
	Fri, 14 Nov 2025 12:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763125084;
	bh=TRk5CRDCjCUBl34vCSFEaD0Pky1Npmrx67ErLaAFNWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kmjz1HLDGS/IllCSa4KMdHNSId6pueobxCl5xZgnBB8a+U4b5rktOY8PGz26D851R
	 3OroOMcquW4KQMQHsqFrENyBcOdheblBg9CeI7TibzYJdgz8MWbHrssPwLUQZJPqwD
	 dbsyDIETvjBviTJHJdxm8GtbEVM4wyXi4PnI3/2i19cFM+KMAQPLyr+Ku5CtcW+ldN
	 GR4TJWWYoVAkrws4J+tDb89esU6x+Bojt/RXBA6BPTksu0xTLUSOU9hCBx8vUmYKtD
	 jA5JgPxZX3LMx9VErM2cLByc6ag7hmxYIowctAvRci5FQ9IpxyRERhCp5q2LJYlxiO
	 Vlov6DBBTSJ2A==
Date: Fri, 14 Nov 2025 14:57:40 +0200
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
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
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
Subject: Re: [PATCH v5 07/22] liveupdate: luo_ioctl: add user interface
Message-ID: <aRcnRFnqhm3jkqd3@kernel.org>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-8-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107210526.257742-8-pasha.tatashin@soleen.com>

On Fri, Nov 07, 2025 at 04:03:05PM -0500, Pasha Tatashin wrote:
> Introduce the user-space interface for the Live Update Orchestrator
> via ioctl commands, enabling external control over the live update
> process and management of preserved resources.
> 
> The idea is that there is going to be a single userspace agent driving
> the live update, therefore, only a single process can ever hold this
> device opened at a time.
> 
> The following ioctl commands are introduced:
> 
> LIVEUPDATE_IOCTL_CREATE_SESSION
> Provides a way for userspace to create a named session for grouping file
> descriptors that need to be preserved. It returns a new file descriptor
> representing the session.
> 
> LIVEUPDATE_IOCTL_RETRIEVE_SESSION
> Allows the userspace agent in the new kernel to reclaim a preserved
> session by its name, receiving a new file descriptor to manage the
> restored resources.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/uapi/linux/liveupdate.h  |  64 ++++++++++++
>  kernel/liveupdate/luo_internal.h |  21 ++++
>  kernel/liveupdate/luo_ioctl.c    | 173 +++++++++++++++++++++++++++++++
>  3 files changed, 258 insertions(+)

...
  
> +static int luo_ioctl_create_session(struct luo_ucmd *ucmd)
> +{
> +	struct liveupdate_ioctl_create_session *argp = ucmd->cmd;
> +	struct file *file;
> +	int ret;
> +
> +	argp->fd = get_unused_fd_flags(O_CLOEXEC);
> +	if (argp->fd < 0)
> +		return argp->fd;
> +
> +	ret = luo_session_create(argp->name, &file);
> +	if (ret)

		put_unused_fd(fd) ?

> +		return ret;
> +
> +	ret = luo_ucmd_respond(ucmd, sizeof(*argp));
> +	if (ret) {
> +		fput(file);
> +		put_unused_fd(argp->fd);
> +		return ret;
> +	}

I think that using gotos for error handling is more appropriate here.

> +
> +	fd_install(argp->fd, file);
> +
> +	return 0;
> +}
> +
> +static int luo_ioctl_retrieve_session(struct luo_ucmd *ucmd)
> +{
> +	struct liveupdate_ioctl_retrieve_session *argp = ucmd->cmd;
> +	struct file *file;
> +	int ret;
> +
> +	argp->fd = get_unused_fd_flags(O_CLOEXEC);
> +	if (argp->fd < 0)
> +		return argp->fd;
> +
> +	ret = luo_session_retrieve(argp->name, &file);
> +	if (ret < 0) {
> +		put_unused_fd(argp->fd);
> +
> +		return ret;
> +	}
> +
> +	ret = luo_ucmd_respond(ucmd, sizeof(*argp));
> +	if (ret) {
> +		fput(file);
> +		put_unused_fd(argp->fd);
> +		return ret;
> +	}

and here.

> +
> +	fd_install(argp->fd, file);
> +
> +	return 0;
> +}
> +

-- 
Sincerely yours,
Mike.

