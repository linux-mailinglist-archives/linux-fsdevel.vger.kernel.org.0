Return-Path: <linux-fsdevel+bounces-52725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D31AE609A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 11:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44555602F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 09:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB08279DDC;
	Tue, 24 Jun 2025 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IORw8WeG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Abefsbgm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="blKVUAF7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="URwVTkGY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C131027A47A
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 09:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750756627; cv=none; b=q1bS9eQtTdsBs19UulWR4N20w85BAdG2inF1f/A1zKX/aDSGD7Ym4aP/8faWRPyCHyNQ30LK94akrBnGtwbvSsO0IYkuZ4US7zqRHQhXDhC/THCtLpp9fr/rv7OCRI8eOy+W477bwpjVi5QDlaHjMtOI2t71E1zXw+k6WtsuSwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750756627; c=relaxed/simple;
	bh=wKUDap06fLdY8ksNevHnq3Kti8WgTCFqw/K3104INao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbrIo708u6w++pz4ApaSbquI+K7DDYJqokpWwnf1s/xuXIK/zUOE6lqiIqG/kwF3TFHZ7EN1Fz7gJ5n0CzlotWLCPPwMpN/GriGgYh0aBvre4tKSW1KNaf94P5uQ0JxSLrkFTioNoADXssiBR+wOM5M7ZQ4mmb1rzncnTIS5Q2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IORw8WeG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Abefsbgm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=blKVUAF7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=URwVTkGY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D0EDA1F391;
	Tue, 24 Jun 2025 09:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750756623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/V2ZH/LgRLymY4meigxUY+PsLAhtMObHxIg5ADf+4sI=;
	b=IORw8WeG7is4WjGG67MB/51gXeY/9D+XhlK1A+YpNXn8TPH3ccMx3kF+bf0QrqLgJApk7q
	kUjgshGEYE0HrD9+/qn9zdlXF8BP5nMbeLBMX0rFd+XxgL4pJxS4qlpSqFobQ88vqv23GV
	Tz2NkwPuaeA+Gj9DsGtOaIyS36QEEz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750756623;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/V2ZH/LgRLymY4meigxUY+PsLAhtMObHxIg5ADf+4sI=;
	b=Abefsbgm8yymHfcwz79mYBAtlj5XXOKwJZcNIBGIPVhou0JvrIo50vpuloc6gTfxJi8+DR
	1DFb/x0RlyAvosBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=blKVUAF7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=URwVTkGY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750756622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/V2ZH/LgRLymY4meigxUY+PsLAhtMObHxIg5ADf+4sI=;
	b=blKVUAF7UpT9Uk0iFsxjzwB/ak3LWXjyHB5ZX2cXhWf3v8bk3QNae/Mjqw9jEHgLNHpvpr
	2e4dVKZ+HqR8kQDiQNa46j9xfac9eJFGJBwM7bDZ5hM6ozzRQNrKe3NCd1KDYPopcL3R/i
	VgkcINUw78HdrwcUfdqXlgEa9eoLRtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750756622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/V2ZH/LgRLymY4meigxUY+PsLAhtMObHxIg5ADf+4sI=;
	b=URwVTkGYQMKk5/Ypn9TuJhOoedMlzICQhtXurkeZ75odz6gniPAEW4VAXn6olPf9iMlDdF
	qWpIRSgyHwQD0JDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C435313751;
	Tue, 24 Jun 2025 09:17:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0hbkLw5tWmjrGQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Jun 2025 09:17:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8378DA0A03; Tue, 24 Jun 2025 11:16:58 +0200 (CEST)
Date: Tue, 24 Jun 2025 11:16:58 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 06/11] uapi/fcntl: mark range as reserved
Message-ID: <u7umyaojd6qglye3zhtufzk4m6pstvkvmtdl6m5zlzxkmk42pt@56imu5h6hwh7>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
 <20250624-work-pidfs-fhandle-v2-6-d02a04858fe3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-work-pidfs-fhandle-v2-6-d02a04858fe3@kernel.org>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,suse.cz,gmail.com,ffwll.ch,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D0EDA1F391
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

On Tue 24-06-25 10:29:09, Christian Brauner wrote:
> Mark the range from -10000 to -40000 as a range reserved for special
> in-kernel values. Move the PIDFD_SELF_*/PIDFD_THREAD_* sentinels over so
> all the special values are in one place.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/uapi/linux/fcntl.h            | 16 ++++++++++++++++
>  include/uapi/linux/pidfd.h            | 15 ---------------
>  tools/testing/selftests/pidfd/pidfd.h |  2 +-
>  3 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index a15ac2fa4b20..ba4a698d2f33 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -90,10 +90,26 @@
>  #define DN_ATTRIB	0x00000020	/* File changed attibutes */
>  #define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
>  
> +/* Reserved kernel ranges [-100], [-10000, -40000]. */
>  #define AT_FDCWD		-100    /* Special value for dirfd used to
>  					   indicate openat should use the
>  					   current working directory. */
>  
> +/*
> + * The concept of process and threads in userland and the kernel is a confusing
> + * one - within the kernel every thread is a 'task' with its own individual PID,
> + * however from userland's point of view threads are grouped by a single PID,
> + * which is that of the 'thread group leader', typically the first thread
> + * spawned.
> + *
> + * To cut the Gideon knot, for internal kernel usage, we refer to
> + * PIDFD_SELF_THREAD to refer to the current thread (or task from a kernel
> + * perspective), and PIDFD_SELF_THREAD_GROUP to refer to the current thread
> + * group leader...
> + */
> +#define PIDFD_SELF_THREAD		-10000 /* Current thread. */
> +#define PIDFD_SELF_THREAD_GROUP		-10001 /* Current thread group leader. */
> +
>  
>  /* Generic flags for the *at(2) family of syscalls. */
>  
> diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> index c27a4e238e4b..957db425d459 100644
> --- a/include/uapi/linux/pidfd.h
> +++ b/include/uapi/linux/pidfd.h
> @@ -42,21 +42,6 @@
>  #define PIDFD_COREDUMP_USER	(1U << 2) /* coredump was done as the user. */
>  #define PIDFD_COREDUMP_ROOT	(1U << 3) /* coredump was done as root. */
>  
> -/*
> - * The concept of process and threads in userland and the kernel is a confusing
> - * one - within the kernel every thread is a 'task' with its own individual PID,
> - * however from userland's point of view threads are grouped by a single PID,
> - * which is that of the 'thread group leader', typically the first thread
> - * spawned.
> - *
> - * To cut the Gideon knot, for internal kernel usage, we refer to
> - * PIDFD_SELF_THREAD to refer to the current thread (or task from a kernel
> - * perspective), and PIDFD_SELF_THREAD_GROUP to refer to the current thread
> - * group leader...
> - */
> -#define PIDFD_SELF_THREAD		-10000 /* Current thread. */
> -#define PIDFD_SELF_THREAD_GROUP		-20000 /* Current thread group leader. */
> -
>  /*
>   * ...and for userland we make life simpler - PIDFD_SELF refers to the current
>   * thread, PIDFD_SELF_PROCESS refers to the process thread group leader.
> diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
> index efd74063126e..5dfeb1bdf399 100644
> --- a/tools/testing/selftests/pidfd/pidfd.h
> +++ b/tools/testing/selftests/pidfd/pidfd.h
> @@ -56,7 +56,7 @@
>  #endif
>  
>  #ifndef PIDFD_SELF_THREAD_GROUP
> -#define PIDFD_SELF_THREAD_GROUP		-20000 /* Current thread group leader. */
> +#define PIDFD_SELF_THREAD_GROUP		-10001 /* Current thread group leader. */
>  #endif
>  
>  #ifndef PIDFD_SELF
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

