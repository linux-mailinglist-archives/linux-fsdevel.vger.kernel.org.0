Return-Path: <linux-fsdevel+bounces-69691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF226C8138F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 16:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A52924E2E18
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 15:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B88C296BA9;
	Mon, 24 Nov 2025 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="C5XZHX0V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43B92877E3
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 15:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763996637; cv=none; b=Rb0QD1CPdWO4Ze+JITfAlGgH72r9+ijXe0LSmRT/O4JA6Kd6JsuQk3CsQvvZFjFYkC1D89yp6plrlqKQ52078EUmeRxaNSpS2G/bbjcF2Kzb3nxu9OpYzw1+9sXY9dC4HOl+28hNcxcM3bRkso/1PPY6yal9kae5z+ApCa9vKzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763996637; c=relaxed/simple;
	bh=sHT0QuA5dqZYX9wknU2HMkY5gjHeOxTh5jHOYEmfUio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoEBt/dGj2VFZfpMW5Usgh+ZNxee2Akic98pxAWGWctSaKlt5rJnvxIaYlewL2AKLK/yXU89ouTtPryzCngNKh1flvbsb6eHz/ijZt6xynJ2iYBKKeJN1Pn1SiK/6IOsImnFnH2Y43GNdw1+y+hFl7zKB3zaapQNz7DTAE+s7i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=C5XZHX0V; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b2d32b9777so581995185a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 07:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763996635; x=1764601435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oQTxNOmidZ5BjIwUmUtQ0T62WOW5uZKi5Keya8nawnY=;
        b=C5XZHX0VF0I5h2UD6zTAeIERIPn0CTyr0BzxeXWX2gq+Flgr1ArpHCGcyzIv7PClYh
         UAy8Z4WHo7NwvGxwbaA1Uc4TvbDx/wnCBrRLodyB6aeg1p+HZ3JdymVwR29N463kP87H
         Gez1bHjAnxy4XnHtT6YWl/Hzlb0/aANIyaAnX9GfbRQzPD/8pOCxI8qOk0nljw5u9puz
         O81ZiLiVVFMxd6IUZ3sHqqDsZW2ohzarw09j/DnP8jr02EQzqueGwabRsPP+KHVyNNBG
         L8dpjY338JJeHS13fCBoVa6tAxSTvVbGKzVHeFkYTTrCr6o7fSjv8SHvFsTNP6C79a7c
         Wr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763996635; x=1764601435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQTxNOmidZ5BjIwUmUtQ0T62WOW5uZKi5Keya8nawnY=;
        b=PxH5nloHD9926KlkD1kwwTta8LoMSQjmZOJ7XNi8Ma6SOo63Leti06e3t0kwybk5eR
         N5Jps/jQ/t0wpuuwSIKsDvv+D66qNiF2WWoET82A9ahzYWx3neDXVw/p1m28orc3ta0R
         G7qw8I7uzQcGVq9v+b+ieJ1ZmJW5UN98rim3wURpqXymNRmEIGBvW1yO2bcs086DQvqM
         s2BgXuWuaOEZ7NMu/DbJfPN3uz1/u+Zhb2uY6RLTAO827ZnCEFiU6Zffq/Al7FMAqxi7
         Gv5jWnYTwrUcNgkHqk+Qpo2huV4Qg4vRcFrSYMUzf7jefF4XJYpnFnZH308iL3I8O1LH
         1jSw==
X-Forwarded-Encrypted: i=1; AJvYcCXpymZa8CxyqGbb+e1R581iSEGgSZfd9njSx1lp6e4HzJN1GySTONSV3F7b8lIaf0K2o9rGiskrcM8TnYZS@vger.kernel.org
X-Gm-Message-State: AOJu0YwTw9V9PK4tMHOJ9sqIdNsxq6iFcxz5tlIwHqtHITiuNwqVh+qm
	dJxo1hDerxCkogemkBOFeBUeSVM7t6SgfeXdcn51GtD+EIu7MATbGySpWVYGbml1yJU=
X-Gm-Gg: ASbGnctIo9OAYF+0qQxIi9VTnRWsQSWz4NNhn72uz7m27MObJbVIw/qcyvoCWIPu00n
	6HD2FrjSQVXDipWjNrzJhg128X24wdUUzLn6Yijo+gX7/ovnFAxqg7h/Y+QQTzYPWA31D6/VKOg
	E7RTuqJqhwyfxyVs1IX/EXnTBVsYW0oFqoW/uhSInpV8t7xZTGzLLz9UFI8hq/uTsRe4zN6hmtG
	LnG9tdsKGBBVG+ejzmQtFF+7Dy6HyVPn+2H5YidCtKVUZbZQjF3tWmdAQhkU/8deZgTFlOPGCJ7
	pZpfRuuQi1ROPaGBBykm2w9Wv1oL0vSWSSTenZbnqT0+2W0TgjGyClyH5Re0FZFPdGrmMpEzkar
	FiGyRjwbc8Lv75jVZAg8GBW92xend1Vy3JQvMMT5KZqVnDe5lE4uokmcg1uqyscJNJ95VEdNVd6
	k6Qo3wufDohP08MuBzpiPR4hpHsBGPA8iDzP/bpzwPXjDfHkenPAEKIu0TqHVcvjJvRRs=
X-Google-Smtp-Source: AGHT+IEqZDY3Xt/BQmqTOQjLXnCxFdmbtDvCpbMS44fdxeqw3l7+lva/Ru522IaA+phuTUalvmQf7g==
X-Received: by 2002:a05:620a:1786:b0:8b2:726a:1e2d with SMTP id af79cd13be357-8b33d5e0872mr1325740285a.85.1763996631704;
        Mon, 24 Nov 2025 07:03:51 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295c17c7sm959454785a.32.2025.11.24.07.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 07:03:51 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vNY6Y-00000001vPs-1eL7;
	Mon, 24 Nov 2025 11:03:50 -0400
Date: Mon, 24 Nov 2025 11:03:50 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 01/47] file: add FD_{ADD,PREPARE}()
Message-ID: <20251124150350.GR233636@ziepe.ca>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
 <20251123-work-fd-prepare-v4-1-b6efa1706cfd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251123-work-fd-prepare-v4-1-b6efa1706cfd@kernel.org>

On Sun, Nov 23, 2025 at 05:33:19PM +0100, Christian Brauner wrote:

> +/*
> + * __FD_PREPARE_INIT(fd_flags, file_init_expr):
> + *     Helper to initialize fd_prepare class.
> + * @fd_flags: flags for get_unused_fd_flags()
> + * @file_init_expr: expression that returns struct file *
> + *
> + * Returns a struct fd_prepare with fd, file, and err set.
> + * If fd allocation fails, fd will be negative and err will be set.
> + * If fd succeeds but file_init_expr fails, file will be ERR_PTR and err will be set.
> + * The err field is the single source of truth for error checking.
> + */
> +#define __FD_PREPARE_INIT(_fd_flags, _file_init_owned)                   \
> +	({                                                               \
> +		class_fd_prepare_t _fd_prepare = {                       \
> +			.__fd = get_unused_fd_flags((_fd_flags)),        \
> +		};                                                       \
> +		if (likely(_fd_prepare.__fd >= 0))                       \
> +			_fd_prepare.__file = (_file_init_owned);         \
> +		_fd_prepare.err = ACQUIRE_ERR(fd_prepare, &_fd_prepare); \
> +		_fd_prepare;                                             \
> +	})
> +
> +/*
> + * FD_PREPARE(var, fd_flags, file_init_owned):
> + *     Declares and initializes an fd_prepare variable with automatic cleanup.
> + *     No separate scope required - cleanup happens when variable goes out of scope.
> + *
> + * @_var: name of struct fd_prepare variable to define
> + * @_fd_flags: flags for get_unused_fd_flags()
> + * @_file_init_owned: struct file to take ownership of (can be expression)
> + */
> +#define FD_PREPARE(_var, _fd_flags, _file_init_owned) \
> +	CLASS_INIT(fd_prepare, _var, __FD_PREPARE_INIT(_fd_flags, _file_init_owned))
> +
> +#define fd_publish(_fd_prepare)                                \
> +	({                                                     \
> +		class_fd_prepare_t *__p = &(_fd_prepare);      \
> +		VFS_WARN_ON_ONCE(__p->err);                    \
> +		VFS_WARN_ON_ONCE(__p->__fd < 0);               \
> +		VFS_WARN_ON_ONCE(IS_ERR_OR_NULL(__p->__file)); \
> +		fd_install(__p->__fd, __p->__file);            \
> +		retain_and_null_ptr(__p->__file);              \
> +		take_fd(__p->__fd);                            \
> +	})

Why not use a real function?

> +#define FD_ADD(_fd_flags, _file_init_owned)                    \
> +	({                                                     \
> +		FD_PREPARE(_var, _fd_flags, _file_init_owned); \
> +		s32 ret = _var.err;                            \
> +		if (likely(!ret))                              \
> +			ret = fd_publish(_var);                \
> +		ret;                                           \
> +	})

Here too, seems like there are many of these, for the sake of .text
why not have it just be a function call?

 int __do_fd_add(int flags, struct file *new_file);
 #define FD_ADD(_fd_flags, new_file) __do_fd_add(_fd_flags, new_file)

cleanup.h is not adding anything to the caller since the cleanup is
fully contained to the scope of the macro.

I don't think it really matters that get_unused_fd_flags() is called
before or after allocating the struct file?

Jason

