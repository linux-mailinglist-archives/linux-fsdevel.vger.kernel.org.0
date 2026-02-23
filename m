Return-Path: <linux-fsdevel+bounces-77983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBivJSuGnGm7IwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 17:54:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1237617A2E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 17:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D1A93032DC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 16:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B48315D47;
	Mon, 23 Feb 2026 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWjWYghN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B936A314A86
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771865116; cv=none; b=ScqOapckq3Zjbxh9IgPjFO7EB9i28jLaaAh3WlGjybXX3QIXA9OpBGJ8Klx8V4xYJp2zFihbbpIJV2UGwHDeNuhDCd2m2MIXqxkwZn5XyCon9xWUYvSbtP3MULpmRji+HSrkVHUWkCDuzenb2gniZZbssTf3vpH2Mt8w9fppEt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771865116; c=relaxed/simple;
	bh=FRgYciD93kMWv+pd/N0cNJUUA8/s04jNUGla2stAuNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fMH268vaiGjXcR0UaAT+ACHJocpdhFbrEWZbsur5GOvLa1YOp8A1C/SZhmvJa/BTSTFIG3mI0qD1R/p7fgRrLVsAb2p7757+GTdZS9NadZkyHo36Wr4AigIQsiAuNDffPRi0Mb+CTbMhRgDvyX66r1/AgO6gxp5PJwwIYe8698c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWjWYghN; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48372efa020so36218105e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 08:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771865113; x=1772469913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3x6z9F/c9hGbEoQPXVnk/KQJsAibMZOJ/jrJV/lD14=;
        b=MWjWYghNaV3dzHo2Lg5VgR/1dpCLsIo/YgmE7nQ0kwYPXQKRjNOn1j6YEM5h5OqXJk
         N2Huvcr/yl2vneB/QhrMn0MwZMkohzXpbs0X9g61+YdKBaYkqj5sloG/XYt5yKiDoRsH
         /WgrQ6Sg1zWYmywQ/sA06KWk4StNL79rgoBT/eSzqS5PlvXWkQV2yJObqmVcyBPzQ9L3
         KbNa5UiMk7A7e2S6Rra4GiN6Z+B6rZ1AH8mInP7hrpBH8Owy0aMMuE+E3EGbVIZcqQA7
         Scy8nSLT0WhWZJp9ZUK6hcfgDoDnI4FzPO9P3BDW5jkRCHuUnQQtAy89a7DUQIIZ7I/s
         UH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771865113; x=1772469913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l3x6z9F/c9hGbEoQPXVnk/KQJsAibMZOJ/jrJV/lD14=;
        b=uSA8vdWJSxozh3pt5KUPIsqygOJ89XgBeFfams2jMkA36K9YshB3kJqGlZvSQkCacu
         A54L+LEwdk+BPDLbBaQgLdVD7Qnt4xQ4KSAuRBCRdlD+gCBRqL6A3aBUkAbZ+oGT7yOR
         R80/Krh2YLb5gSrljGEUHF3LVg2RykD7A4Tj7CZ6HeSYPatcWie76yJj7AJkoRqlLjpH
         QQeh+G/5IOPoqre7qkLQ1AaGbm1uQP0h176ZErr/pWURfXzk+6Q/qD5AbA1mZQ1xzBVC
         pcixLkkp4RE2uouhCCZ85EeGQCuZAHJwVzEJCGJm3JDyA9fRLnx7cvX1m/pxt4pS+SAf
         Hu9g==
X-Forwarded-Encrypted: i=1; AJvYcCWqZPhgiEvKT9oTVHpWmHfJr3Ao0D4DlVzLZUUvuTtqnBseTAFLhXbfyFPeezZpbXj3LufJOa3Aiug447yS@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk6QJ1f4h5L+rncA7NkLhM90NXzckcbN9nss+KZl1j1Oro+cJX
	Ef+r0MORxrRzp68q5MDf8jKDT+2l1uWLT58SvwE93pFfIWs77T93J54J
X-Gm-Gg: AZuq6aLhC+ndAS9oo/+7YxTG41Q1kIMs3kYuNy5vhcG6y0fxyPLQujZobn7xCe3cf1W
	o+JFYEZbcm93GocqhNhIv3aZxYoEiCTwGVQUSgqj4dKzxKTW6+fbtuIbh26oikGktVedu19DQd+
	rdHN230o6ATF3ASWweAmJUyTJSDal96CcvJYPTUUQ83q8r6ZQK3gGpZ3TAlFg/90zmedueAX7KT
	od5Noibsyh+Gw60p4AkQmoaIPikkHGSazzWMjktfI3Ey74RBWn6MwZlh2VgtNfBbI5s9cIekOzs
	rBhS+jgy8c/FsjGILrq/H3j2ilrIl7IpiMa7urg6PjT8YZ7KBkac5ERvu3/52sqIJDe7eX7GXId
	yt3taiM5JdGf8B9KN2b9S9fEUVVXOJ3ZFfAu9RHsZHffJCfQqeHcvuqBMCGu4qbWjo+pKRPtCuF
	zb+X0VBEp0DQ5hLlge2EsWQk7lrOzkpof1aLICGv+F7Yn/uZlkME4My0NgBdr7iLxnpcrTVOrSD
	jQ=
X-Received: by 2002:a05:600c:3516:b0:483:7783:5373 with SMTP id 5b1f17b1804b1-483a963588bmr140388075e9.23.1771865112715;
        Mon, 23 Feb 2026 08:45:12 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b8196ae0sm447875e9.0.2026.02.23.08.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 08:45:12 -0800 (PST)
Date: Mon, 23 Feb 2026 16:45:11 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: jlayton@kernel.org, chuck.lever@oracle.com, alex.aring@gmail.com,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, arnd@arndb.de,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH] Add support for empty path in openat and openat2
 syscalls
Message-ID: <20260223164511.525762fb@pumpkin>
In-Reply-To: <20260223151652.582048-1-jkoolstra@xs4all.nl>
References: <20260223151652.582048-1-jkoolstra@xs4all.nl>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77983-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,gmail.com,zeniv.linux.org.uk,suse.cz,arndb.de,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[xs4all.nl];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xs4all.nl:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1237617A2E9
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 16:16:52 +0100
Jori Koolstra <jkoolstra@xs4all.nl> wrote:

> To get an operable version of an O_PATH file descriptors, it is possible
> to use openat(fd, ".", O_DIRECTORY) for directories, but other files
> currently require going through open("/proc/<pid>/fd/<nr>") which
> depends on a functioning procfs.

What do you want the fd for?
There are good reasons for wanting an fd for a directory that you don't
have access permissions for, but what is the use case for a file?

It all gets very close to letting you do things that the 'security model'
should reject.

	David

> 
> This patch adds the O_EMPTY_PATH flag to openat and openat2. If passed
> LOOKUP_EMPTY is set at path resolve time.
> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/fcntl.c                       | 2 +-
>  fs/open.c                        | 6 ++++--
>  include/linux/fcntl.h            | 2 +-
>  include/uapi/asm-generic/fcntl.h | 4 ++++
>  4 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index f93dbca08435..62ab4ad2b6f5 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -1169,7 +1169,7 @@ static int __init fcntl_init(void)
>  	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
>  	 * is defined as O_NONBLOCK on some platforms and not on others.
>  	 */
> -	BUILD_BUG_ON(20 - 1 /* for O_RDONLY being 0 */ !=
> +	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
>  		HWEIGHT32(
>  			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
>  			__FMODE_EXEC));
> diff --git a/fs/open.c b/fs/open.c
> index 91f1139591ab..32865822ca1c 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1160,7 +1160,7 @@ struct file *kernel_file_open(const struct path *path, int flags,
>  EXPORT_SYMBOL_GPL(kernel_file_open);
>  
>  #define WILL_CREATE(flags)	(flags & (O_CREAT | __O_TMPFILE))
> -#define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC)
> +#define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC | O_EMPTY_PATH)
>  
>  inline struct open_how build_open_how(int flags, umode_t mode)
>  {
> @@ -1277,6 +1277,8 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
>  		}
>  	}
>  
> +	if (flags & O_EMPTY_PATH)
> +		lookup_flags |= LOOKUP_EMPTY;
>  	if (flags & O_DIRECTORY)
>  		lookup_flags |= LOOKUP_DIRECTORY;
>  	if (!(flags & O_NOFOLLOW))
> @@ -1362,7 +1364,7 @@ static int do_sys_openat2(int dfd, const char __user *filename,
>  	if (unlikely(err))
>  		return err;
>  
> -	CLASS(filename, name)(filename);
> +	CLASS(filename_flags, name)(filename, op.lookup_flags);
>  	return FD_ADD(how->flags, do_file_open(dfd, name, &op));
>  }
>  
> diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> index a332e79b3207..ce742f67bf60 100644
> --- a/include/linux/fcntl.h
> +++ b/include/linux/fcntl.h
> @@ -10,7 +10,7 @@
>  	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
>  	 O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
>  	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
> -	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
> +	 O_NOATIME | O_CLOEXEC | O_PATH | O_EMPTY_PATH | __O_TMPFILE)
>  
>  /* List of all valid flags for the how->resolve argument: */
>  #define VALID_RESOLVE_FLAGS \
> diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
> index 613475285643..8e4e796ad212 100644
> --- a/include/uapi/asm-generic/fcntl.h
> +++ b/include/uapi/asm-generic/fcntl.h
> @@ -88,6 +88,10 @@
>  #define __O_TMPFILE	020000000
>  #endif
>  
> +#ifndef O_EMPTY_PATH
> +#define O_EMPTY_PATH	0100000000
> +#endif
> +
>  /* a horrid kludge trying to make sure that this will fail on old kernels */
>  #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
>  


