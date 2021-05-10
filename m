Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569883797C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 21:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbhEJTiF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 15:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbhEJTiF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 15:38:05 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3189FC061763
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 12:37:00 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id k19so14356611pfu.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 12:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w733lNx5OPvObGbQFjQ0hyLyLp32Sr7cenOR1wA1DIY=;
        b=lVGfbvll40bgW3gA0fIk8JnjEglkVV5jCVUhsmj7ENwfKb7AnT261Kn/TUZHgnA8iQ
         vFA72QWJlBYZTSrbMdmrm1kqYiHWzkPRKp2KbV392cJ+EqzkEt8SkIGerLo/bRjyzH+2
         UrG5K2+KQ2ObPy4UieTwNbPSU/s9lxlr/kz7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w733lNx5OPvObGbQFjQ0hyLyLp32Sr7cenOR1wA1DIY=;
        b=e7naQk9z+l10J56zf9C1RNNjPuK8OxHizAOl32bidQ0iC83sRUS8Okk9wLdpFVmg7N
         Q5XnTmUaM5mqtN95rMiDj9Cfjfd0EmuBAnVm3A1dHqBf7Cx3nBWHIbJNBmkPZvEamzrh
         07lzKcjBJqFyfmOViyMEdeOwzSx68FbKg1iaA25V2xtSzIAb9mhRrtNAoZxxexbym/DK
         im22nakj1U9i7CxgkL/uHA4IYJddNr0PVXzNAZjMNO7b6zhiWaUZAhgeYNZI00Gs0eMu
         G3TxXfvHEUx5TkY2E5gXzEuZPbis0fThg9aPLU8uL0mLUd7bCBg1rWzf26+hNbk9M+x7
         1SlQ==
X-Gm-Message-State: AOAM532OgBCJYSF2daByc8CNlq6GJJRUg/JB+LsOnMsovDObzYaG+3b3
        Jq9ZFndEFQWAIkta4NmRqNE7Kw==
X-Google-Smtp-Source: ABdhPJx+twpgUp3Tckqv3jXwuEJgx8N1FiNKbDh2d4JwFvvNONDhOoxUrO4PG1e2unCsVRONdCucWg==
X-Received: by 2002:a63:1064:: with SMTP id 36mr27146092pgq.164.1620675419601;
        Mon, 10 May 2021 12:36:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g18sm11938600pfb.178.2021.05.10.12.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 12:36:58 -0700 (PDT)
Date:   Mon, 10 May 2021 12:36:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Jiri Slaby <jirislaby@kernel.org>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: core: fix suspicious security_locked_down() call
Message-ID: <202105101226.E2AD9AEC@keescook>
References: <20210507115719.140799-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507115719.140799-1-omosnace@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 07, 2021 at 01:57:19PM +0200, Ondrej Mosnacek wrote:
> The commit that added this check did so in a very strange way - first
> security_locked_down() is called, its value stored into retval, and if
> it's nonzero, then an additional check is made for (change_irq ||
> change_port), and if this is true, the function returns. However, if
> the goto exit branch is not taken, the code keeps the retval value and
> continues executing the function. Then, depending on whether
> uport->ops->verify_port is set, the retval value may or may not be reset
> to zero and eventually the error value from security_locked_down() may
> abort the function a few lines below.
> 
> I will go out on a limb and assume that this isn't the intended behavior
> and that an error value from security_locked_down() was supposed to
> abort the function only in case (change_irq || change_port) is true.
> 
> Note that security_locked_down() should be called last in any series of
> checks, since the SELinux implementation of this hook will do a check
> against the policy and generate an audit record in case of denial. If
> the operation was to carry on after calling security_locked_down(), then
> the SELinux denial record would be bogus.
> 
> See commit 59438b46471a ("security,lockdown,selinux: implement SELinux
> lockdown") for how SELinux implements this hook.
> 
> Fixes: 794edf30ee6c ("lockdown: Lock down TIOCSSERIAL")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  drivers/tty/serial/serial_core.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index ba31e97d3d96..d7d8e7dbda60 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -865,9 +865,11 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
>  		goto check_and_exit;
>  	}
>  
> -	retval = security_locked_down(LOCKDOWN_TIOCSSERIAL);
> -	if (retval && (change_irq || change_port))
> -		goto exit;
> +	if (change_irq || change_port) {
> +		retval = security_locked_down(LOCKDOWN_TIOCSSERIAL);
> +		if (retval)
> +			goto exit;
> +	}
>  
>  	/*
>  	 * Ask the low level driver to verify the settings.

Oops. Yeah, good catch -- I missed the kind of weird handling of retval
in this function when I originally reviewed it.

I think the goals of just covering IRQ/IO port changes originate from here:
https://lore.kernel.org/lkml/26173.1479769852@warthog.procyon.org.uk/

And I think the "Reported-by: Greg KH" originates from here:
https://lore.kernel.org/lkml/20161206071104.GA10292@kroah.com/

So, yes, I think your fix is correct.

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
