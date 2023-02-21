Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576A169E612
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 18:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbjBURfB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 12:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbjBURex (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:34:53 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A104D22DD0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Feb 2023 09:34:51 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id e9so838927plh.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Feb 2023 09:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pLxWHkGw8qoawChr7ZMOquDu3/XM9TqD6CJ/g5t4Des=;
        b=cUKtnnL2Ul2OkVeO8fuJUYUsmzb2eFtPDwmysmRpPUVEAa6Yu+RkHw+pxvct3lZ10L
         zNweERba3Fs9RnobteImiBWWYyOqi+ZW7ey9SYKDmdb7gqBnBbA6+L4DiRPpzVbjaVn5
         C+bPLHlXu6ZVKVWoze3cbaRQVeZqLeD0vPn0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLxWHkGw8qoawChr7ZMOquDu3/XM9TqD6CJ/g5t4Des=;
        b=LlVYaEo3FS+iTai23ioVNa5ci7ihX/hdfrzFX3Oeioym/ai9GFKkitZLvz6wGMHCqZ
         2rtQ/S/bufhCf91xqjwZsC9gz5xIkJkToUWlLUHX3Ir87LruJtWa+kFKdO4FlMPEQqnw
         SCqB3uZFMkqCp/CiW3yuSrOJs9lNQytZQrLzqRd2IzwRQKoTmw5JS0NzuGiS83uhJ+zP
         F1juHGDDoNl1FamYrHDFsdXGwW+tEeoUyoJXyZwk8q5dl4ynSZN4kTUdsLoca8r3EnfP
         QZR2bTLP+NSWZuBpfjoqmVx8fXmA1FuPC+uuHGmrz4K70h21q2enAxqmRqbze8kwIKGw
         mD0A==
X-Gm-Message-State: AO0yUKV9/68ZbbjRIDOtCBqKfMaasx6xudJRqaF0PalPgTVhe1OrDrES
        z1ru/sNpak4eSYPYpV05aThDJg==
X-Google-Smtp-Source: AK7set/TfvNthcS1xSc0oxBAX38i183LmXjjSn0X269sbPp8QHwEPMwEmGepSBHlAAQumAk4ZNUzDw==
X-Received: by 2002:a17:903:2345:b0:19b:22c2:26a1 with SMTP id c5-20020a170903234500b0019b22c226a1mr6916969plh.9.1677000891107;
        Tue, 21 Feb 2023 09:34:51 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902c28300b0019251e959b1sm10110764pld.262.2023.02.21.09.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 09:34:50 -0800 (PST)
Message-ID: <63f500ba.170a0220.c76fc.1642@mx.google.com>
X-Google-Original-Message-ID: <202302210911.@keescook>
Date:   Tue, 21 Feb 2023 09:34:49 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: fix proc_dobool() usability
References: <20230210145823.756906-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210145823.756906-1-omosnace@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 10, 2023 at 03:58:23PM +0100, Ondrej Mosnacek wrote:
> Currently proc_dobool expects a (bool *) in table->data, but sizeof(int)
> in table->maxsize, because it uses do_proc_dointvec() directly.
> 
> This is unsafe for at least two reasons:
> 1. A sysctl table definition may use { .data = &variable, .maxsize =
>    sizeof(variable) }, not realizing that this makes the sysctl unusable
>    (see the Fixes: tag) and that they need to use the completely
>    counterintuitive sizeof(int) instead.
> 2. proc_dobool() will currently try to parse an array of values if given
>    .maxsize >= 2*sizeof(int), but will try to write values of type bool
>    by offsets of sizeof(int), so it will not work correctly with neither
>    an (int *) nor a (bool *). There is no .maxsize validation to prevent
>    this.
> 
> Fix this by:
> 1. Constraining proc_dobool() to allow only one value and .maxsize ==
>    sizeof(bool).
> 2. Wrapping the original struct ctl_table in a temporary one with .data
>    pointing to a local int variable and .maxsize set to sizeof(int) and
>    passing this one to proc_dointvec(), converting the value to/from
>    bool as needed (using proc_dou8vec_minmax() as an example).
> 3. Extending sysctl_check_table() to enforce proc_dobool() expectations.
> 4. Fixing the proc_dobool() docstring (it was just copy-pasted from
>    proc_douintvec, apparently...).
> 5. Converting all existing proc_dobool() users to set .maxsize to
>    sizeof(bool) instead of sizeof(int).
> 
> Fixes: 83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled")
> Fixes: a2071573d634 ("sysctl: introduce new proc handler proc_dobool")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Ah nice, thanks for tracking this down.

Acked-by: Kees Cook <keescook@chromium.org>

I've long wanted to replace all the open-coded sysctl initializers with
a helper macro so it's hard to make mistakes. e.g.

#define _SYSCTL_HANDLER(var)					\
		_Generic((var),					\
			default:	proc_dointvec_minmax,	\
			unsigned int:	proc_douintvec_minmax,	\
			unsigned long:	proc_doulongvec_minmax,	\
			char:		proc_dou8vec_minmax,	\
			bool:		proc_dobool,		\
			char *:		proc_dostring)

#define _SYSCTL_MINVAL(var)				\
		_Generic((var),				\
			default:	0,		\
			int:		INT_MIN,	\
			unsigned int:	UINT_MIN,	\
			unsigned long:	ULONG_MIN,	\
			char:		U8_MIN,		\
			bool:		0)

#define _SYSCTL_MAXVAL(var)				\
		_Generic((var),				\
			default:	0,		\
			int:		INT_MAX,	\
			unsigned int:	UINT_MAX,	\
			unsigned long:	ULONG_MAX,	\
			char:		U8_MAX,		\
			bool:		1)

#define _SYSCTL_VAR(_name, _var, _mode, _handler, _len, _min, _max)	\
	{								\
		.procname	= _name,				\
		.data		= &(_var),				\
		.maxlen		= _len,					\
		.mode		= _mode,				\
		.proc_handler	= _handler,				\
		.minlen		= _min,					\
		.maxlen		= _min,					\
	}

/* single value */
#define SYSCTL_VAL(var)							\
	_SYSCTL_VAR(#var, var, 0644, _SYSCTL_HANDLER(var), sizeof(var),	\
		    _SYSCTL_MINVAL(var), _SYSCTL_MAXVAL(var))

/* single value with min/max */
#define SYSCTL_VAL_MINMAX(_var, _min, _max)				\
	_SYSCTL_VAR(#var, var, 0644, _SYSCTL_HANDLER(var), sizeof(var),	\
		    _min, _max)

/* Strings... */
#define SYSCTL_STR(_var, _len)						\
	_SYSCTL_VAR(#var, var, 0644, _SYSCTL_HANDLER(var), _len, 0, 0)

/* Arrays... */
#define SYSCTL_ARRAY(_var)						\
	_SYSCTL_VAR(#var, var, 0644, _SYSCTL_HANDLER(var),		\
		    ARRAY_SIZE(_var), _SYSCTL_MINVAL(var),		\
		    _SYSCTL_MAXVAL(var)

Totally untested. I think this would cover the vast majority of sysctl
initializers.

-- 
Kees Cook
