Return-Path: <linux-fsdevel+bounces-43275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27E8A50434
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 17:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90D7B174CC0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 16:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAF5250C1D;
	Wed,  5 Mar 2025 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="EEj+i5tc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D93250BE0
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190981; cv=none; b=D0R3ODMoy17K8IwCsiX9eQCMMx8uNagC6Wc6xSRzGeZP72Mc84JPdhHVVuHXVDlUCgKu7ToLVcKCPQhtbhB9dSQabi3crez4KKfKqyo6tXHOpUH4a+TULPJVt8VWKxioJWWX5tQeAkornUXu0mZRoZrqiVpAX/96tpnZsPNFBw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190981; c=relaxed/simple;
	bh=pIpO/sGgffZOuvaq2q5nTstfJhAfEQcyhnbXoKHfr3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLlwTgBCD0YOmr9ScMba4xzlN/CvGNkKfP7TxRryauYNsYB7iqwtj8OTLC8PokFcM5iJNewMtQoeZO7ifbpkNJ1ac/2bZN5w/JjiZriD22mxIcydxeA2N3hfzWw6HsLMwJq9sykCgQQMVLHDV7mD3S93am1rG5KdgNcZPuVL1Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=EEj+i5tc; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z7HYm3Zw2zVK7;
	Wed,  5 Mar 2025 17:09:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741190972;
	bh=KKGDt/nLgnhpo+poV9GrvakQkNVBTtJnLYA4bSB9DkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EEj+i5tcx2Z6xdW3LNmAbNEDDdxHvQlSUPzblCUMPTdasbk6TuZ47Vjo54tSxITGF
	 Fc+/ImQQzaLAMo2Lo9OrbIUr5rY3PrtylwKqLFygVTrfNCWcCgpESkSG4kKizZsoM7
	 9t45lzvrlhe2xwExJLStpE2YrbEkkkYHPSYdEybE=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z7HYl3MzfzHJP;
	Wed,  5 Mar 2025 17:09:31 +0100 (CET)
Date: Wed, 5 Mar 2025 17:09:30 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>, Jann Horn <jannh@google.com>, 
	Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC PATCH 4/9] User-space API for creating a supervisor-fd
Message-ID: <20250305.peiLairahj3A@digikod.net>
References: <cover.1741047969.git.m@maowtm.org>
 <03d822634936f4c3ac8e4843f9913d1b1fa9d081.1741047969.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <03d822634936f4c3ac8e4843f9913d1b1fa9d081.1741047969.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

On Tue, Mar 04, 2025 at 01:13:00AM +0000, Tingmao Wang wrote:
> We allow the user to pass in an additional flag to landlock_create_ruleset
> which will make the ruleset operate in "supervise" mode, with a supervisor
> attached. We create additional space in the landlock_ruleset_attr
> structure to pass the newly created supervisor fd back to user-space.
> 
> The intention, while not implemented yet, is that the user-space will read
> events from this fd and write responses back to it.
> 
> Note: need to investigate if fd clone on fork() is handled correctly, but
> should be fine if it shares the struct file. We might also want to let the
> user customize the flags on this fd, so that they can request no
> O_CLOEXEC.
> 
> NOTE: despite this patch having a new uapi, I'm still very open to e.g.
> re-using fanotify stuff instead (if that makes sense in the end). This is
> just a PoC.

The main security risk of this feature is for this FD to leak and be
used by a sandboxed process to bypass all its restrictions.  This should
be highlighted in the UAPI documentation.

> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
>  include/uapi/linux/landlock.h |  10 ++++
>  security/landlock/syscalls.c  | 102 +++++++++++++++++++++++++++++-----
>  2 files changed, 98 insertions(+), 14 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index e1d2c27533b4..7bc1eb4859fb 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -50,6 +50,15 @@ struct landlock_ruleset_attr {
>  	 * resources (e.g. IPCs).
>  	 */
>  	__u64 scoped;
> +	/**
> +	 * @supervisor_fd: Placeholder to store the supervisor file
> +	 * descriptor when %LANDLOCK_CREATE_RULESET_SUPERVISE is set.
> +	 */
> +	__s32 supervisor_fd;

This interface would require the ruleset_attr becoming updatable by the
kernel, which might be OK in theory but requires current syscall wrapper
signature update, see sandboxer.c change.  It also creates a FD which
might not be useful (e.g. if an error occurs before the actual
enforcement).

I see a few alternatives.  We could just use/extend the ruleset FD
instead of creating a new one, but because leaking current rulesets is
not currently a security risk, we should be careful to not change that.

Another approach, similar to seccomp unotify, is to get a
"[landlock-domain]" FD returned by the landlock_restrict_self(2) when a
new LANDLOCK_RESTRICT_SELF_DOMAIN_FD flag is set.  This FD would be a
reference to the newly created domain, which is more specific than the
ruleset used to created this domain (and that can be used to create
other domains).  This domain FD could be used for introspection (i.e.
to get read-only properties such as domain ID), but being able to
directly supervise the referenced domain only with this FD would be a
risk that we should limit.

What we can do is to implement an IOCTL command for such domain FD that
would return a supervisor FD (if the LANDLOCK_RESTRICT_SELF_SUPERVISED
flag was also set).  The key point is to check (one time) that the
process calling this IOCTL is not restricted by the related domain (see
the scope helpers).

Relying on IOCTL commands (for all these FD types) instead of read/write
operations should also limit the risk of these FDs being misused through
a confused deputy attack (because such IOCTL command would convey an
explicit intent):
https://docs.kernel.org/security/credentials.html#open-file-credentials
https://lore.kernel.org/all/CAG48ez0HW-nScxn4G5p8UHtYy=T435ZkF3Tb1ARTyyijt_cNEg@mail.gmail.com/
We should get inspiration from seccomp unotify for this too:
https://lore.kernel.org/all/20181209182414.30862-1-tycho@tycho.ws/

> +	/**
> +	 * @pad: Unused, must be zero.
> +	 */
> +	__u32 pad;

In this case we should pack the struct instead.

>  };
>  
>  /*
> @@ -60,6 +69,7 @@ struct landlock_ruleset_attr {
>   */
>  /* clang-format off */
>  #define LANDLOCK_CREATE_RULESET_VERSION			(1U << 0)
> +#define LANDLOCK_CREATE_RULESET_SUPERVISE		(1U << 1)
>  /* clang-format on */
>  
>  /**

[...]

