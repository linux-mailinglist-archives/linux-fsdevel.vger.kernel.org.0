Return-Path: <linux-fsdevel+bounces-17680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E1C8B16B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 01:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A39288024
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 23:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B573716EC0B;
	Wed, 24 Apr 2024 23:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="czhOw+D/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85F816D9DE
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 23:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713999709; cv=none; b=bLPPmUxcdBFvwQr/41SQ4OjzvBdK/m13ad/jnCeM5h5xPJgntQZSJmd6dSvgRtfZfL4jyYiv4QCRIwjVuZxb13ABZaWP0WMsESJXY459Kx0gMS0FX4WpzfihetbYOpYsHNk8taOpNT2gpMxcAkTh3MicLL430LEM0kPCU00PuwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713999709; c=relaxed/simple;
	bh=84wVBgNYByei2AoFJYl9oJG8YIj6VGg9zdZNNuKXOfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugoOLD/7yqt9LEZFHWpMmxc06lh6yLI4c22TsrECFwxLA9gcnNwXdOjyv7Ld/PArMiQO+/smtAFWu69clcytN6TZodJdmGLa2aWK7R8yzrRr7GAGR9NNWkal0k57+dBDf+Ogh7mLnom1kYY84v5wnHtwo2rjgglU0R0TONZcSBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=czhOw+D/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e4f341330fso3671925ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 16:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713999707; x=1714604507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aTTJDYIl1+ZY3XTIQUGDvgnIzsFLuN0wJDzru5PPah0=;
        b=czhOw+D/w6cQ5tn3SAdi1dr4RbUdffq8G8xAX8HCCwj8FK3GxfVkYKE1wYrT5sx/ul
         XKWCPAT9kSKooxgBN3segHOlIOcaM0MYNMrGiwrOLRsLRF/PutxE1FikLOeO/n5T7kjh
         cAC9+QiTZ89WWALqo6GqkyUMjhYVj91CP8AhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713999707; x=1714604507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTTJDYIl1+ZY3XTIQUGDvgnIzsFLuN0wJDzru5PPah0=;
        b=B0yTsHFQGPRgLevrIJT/l49NuwJaE2oocp3pHUPfEZP6Wna3klO+mbyl8focQX8Hiy
         eFeKLMae0evXO7GkJuY7ZV02pRai/jcv5bRDiG8B+80hq02DPBSTgd8b2j4eqA6pOhWp
         0I8Ve9cZwtEU6sJY+UUgqhIYatDSl9noc8znMXEu9tvmZN/nR8HIEsOSWuH0GAWHluhe
         J9Jke6Ic4U21oOIpZp88dXQF9eojYrOGikM3reYehAXP8GdqscnQMZ5V7jW7B970Zowr
         HW+espBKtpqomqfqPLfS4/ao9A2ZQDeoT0j4dvdaapsAD4pnoVwQy6LqkBwMDtE3jxMX
         5BmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVHmcJOYZFsf7TXDpFkZaEOxq+nmmKRvG6wpTPmSjiZNQyrrLM/uOKQ5GYkKHyy334oRy9SF9WC+y+2c/SgBmy7Ytu2ShYWP7RKWYEdQ==
X-Gm-Message-State: AOJu0YzlTPb9od2w9UUTYxYiuCCL+raioszjQEXv3TwA7UEHZSadO+Vl
	3Y7DJ+OX1qKFj1SXHVkVaIDU6qmBEXmj7PpB61gFsM98ErK3rIXfEiSly6P7vUnbPScRZyIVzzI
	=
X-Google-Smtp-Source: AGHT+IFyYVHaUDZdYBSAJ1KOUOQ8gMm1YSC+JLwv5oQtTWLj2MuAeAtXlnAI7HNBKqeCyg6uW+8NsQ==
X-Received: by 2002:a17:90a:348b:b0:2a2:672f:ef6d with SMTP id p11-20020a17090a348b00b002a2672fef6dmr3375472pjb.49.1713999706766;
        Wed, 24 Apr 2024 16:01:46 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o10-20020a17090a420a00b002ad059491f6sm8073479pjg.5.2024.04.24.16.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 16:01:46 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:01:45 -0700
From: Kees Cook <keescook@chromium.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] Saner typechecking for closures
Message-ID: <202404241559.D41E91F8@keescook>
References: <Zic7USbiliQtnKZr@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zic7USbiliQtnKZr@casper.infradead.org>

On Tue, Apr 23, 2024 at 05:38:41AM +0100, Matthew Wilcox wrote:
> What would you think to this?
> 
> +++ b/include/linux/delayed_call.h
> @@ -14,13 +14,12 @@ struct delayed_call {
> 
>  #define DEFINE_DELAYED_CALL(name) struct delayed_call name = {NULL, NULL}
> 
> -/* I really wish we had closures with sane typechecking... */
> -static inline void set_delayed_call(struct delayed_call *call,
> -               void (*fn)(void *), void *arg)
> -{
> -       call->fn = fn;
> -       call->arg = arg;
> -}
> +/* Typecheck the arg is appropriate for the function */
> +#define set_delayed_call(call, _fn, _arg) do {                         \
> +       (void)sizeof(_fn(_arg));                                        \
> +       (call)->fn = (void (*)(void *))(_fn);                           \
> +       (call)->arg = (_arg);                                           \
> +} while (0)
> 
>  static inline void do_delayed_call(struct delayed_call *call)
>  {
> 
> 
> That should give us the possibility of passing any pointer
> to the function, but gets us away from void pointers.  I did this as a

This just means KCFI will freak out now, since it will see a mismatch
between call->fn's type and the target function's type. :(

And instead of args like this, can't we use the regular container_of()
tricks to get at the pointer we want? i.e. make "call" a member of the
strut doing the delayed call?

-Kees

> followup:
> 
> -extern void page_put_link(void *);
> +extern void page_put_link(struct folio *);
> 
> ...
> 
> -void page_put_link(void *arg)
> +void page_put_link(struct folio *folio)
>  {
> -       put_page(arg);
> +       folio_put(folio);
>  }
>  EXPORT_SYMBOL(page_put_link);
> 
> and similar changes to the three callers.
> 
> Or is there something newer and shinier we should be using instead of
> delayed_call?

-- 
Kees Cook

