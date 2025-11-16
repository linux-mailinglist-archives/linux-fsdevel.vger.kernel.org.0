Return-Path: <linux-fsdevel+bounces-68617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AB694C61A8D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 19:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A4C735A17C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 18:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C21F30FC09;
	Sun, 16 Nov 2025 18:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMIwuVuH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5561B225A29;
	Sun, 16 Nov 2025 18:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763317554; cv=none; b=gV6lorhuCVQRpTrYs9gTmcPOuUnc7BS8oUQZBXSDqZkh7WSHe+yqjcGQdxkKkIwtFtg4wDeDxUgTjDV9goqDojObu1K6XmDOnCvJZcxBt4M1Jidujcde0yXD/xz4XfEDxqiXaE9bQCQ7Bp6sY5NGYLJZqT6DOFc+xmGAT5phIww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763317554; c=relaxed/simple;
	bh=+H9kC5zD7GOV9MudaE3ortYpw/BxE5AQe7gf6a8981M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSvSpUjjiKfuCf9qF+siXh9jRhrlPJvO6RlAUC2H5ndG+KwfemYQ/sSgTs7MHXi6Vt0J0bpzx3KLcyowalMYIEE5z/tkrHVDWzG6OSqh8AYojbc+UWOUIgp6QMatVbYNxa8fLDB/x4jkSGZu/pCJIoPspz630wlKaleEX3ol6dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMIwuVuH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08E0C116D0;
	Sun, 16 Nov 2025 18:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763317553;
	bh=+H9kC5zD7GOV9MudaE3ortYpw/BxE5AQe7gf6a8981M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sMIwuVuHQZ63VF+zCAo9oX2pCDZyMCYP5Wg8cjEsP3YQB9I0BpreQ9L/ablGpeUME
	 oCs9zr+bX1CKb5waMw6erNYZisB571UuMGrkKaBNYOUMk6gCsaWyqrfsZ0hyGUqbfu
	 ChqUNCDi1QwEeRwhkaCjZzXrvMknXrk6keOxrsSGvu4jHDYCbmMoFgOaz5ojW3ny5g
	 9rs0tggzMGM/Af2Y6UssYxHC4mq76M+pvKIUlV01l4H3Qwm2iNKqxRclRl6d7KvIaM
	 412Cjl2c8GJh/Gk8fEJh8XDHufdpHrLLofuGMQYXKBdLYLkz9loxs7BS19SxE6zL6o
	 QKTJauwTCUg4Q==
Date: Sun, 16 Nov 2025 20:25:29 +0200
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
Subject: Re: [PATCH v6 07/20] liveupdate: luo_session: Add ioctls for file
 preservation
Message-ID: <aRoXGYC4GeAoNKPl@kernel.org>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-8-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251115233409.768044-8-pasha.tatashin@soleen.com>

On Sat, Nov 15, 2025 at 06:33:53PM -0500, Pasha Tatashin wrote:
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
> - LIVEUPDATE_SESSION_RETRIEVE_FD: Retrieve a preserved file in the
>   new kernel using its unique token.
> - LIVEUPDATE_SESSION_FINISH: finish session
> 
> The session's .release handler is enhanced to be state-aware. When a
> session's file descriptor is closed, it correctly unpreserves
> the session based on its current state before freeing all
> associated file resources.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/uapi/linux/liveupdate.h | 103 ++++++++++++++++++
>  kernel/liveupdate/luo_session.c | 187 +++++++++++++++++++++++++++++++-
>  2 files changed, 286 insertions(+), 4 deletions(-)

...

>  static int luo_session_release(struct inode *inodep, struct file *filep)
>  {
>  	struct luo_session *session = filep->private_data;
>  	struct luo_session_header *sh;
> +	int err = 0;
>  
>  	/* If retrieved is set, it means this session is from incoming list */
> -	if (session->retrieved)
> +	if (session->retrieved) {
>  		sh = &luo_session_global.incoming;
> -	else
> +
> +		err = luo_session_finish_one(session);
> +		if (err) {
> +			pr_warn("Unable to finish session [%s] on release\n",
> +				session->name);

			return err;

and then else can go away here and luo_session_remove() and
luo_session_free() can be moved outside if (session->retrieved).

> +		} else {
> +			luo_session_remove(sh, session);
> +			luo_session_free(session);
> +		}
> +
> +	} else {
>  		sh = &luo_session_global.outgoing;
>  
> -	luo_session_remove(sh, session);
> -	luo_session_free(session);
> +		scoped_guard(mutex, &session->mutex)
> +			luo_file_unpreserve_files(session);
> +		luo_session_remove(sh, session);
> +		luo_session_free(session);
> +	}
> +
> +	return err;
> +}

-- 
Sincerely yours,
Mike.

