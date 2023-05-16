Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615D170588E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 22:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjEPURp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 16:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjEPURn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 16:17:43 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941F8171E
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 13:17:36 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64359d9c531so10880770b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 13:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684268256; x=1686860256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YJEJEgHLDw3Nrf2OYxAw65J2/yLmkvxFlpYWiAtQcmA=;
        b=HnGWjuYOAI8Ajbhmofm3GokXhD5YgSqiF6UQCDCLlwnbaHtP73wUieT9TUP2SHAOuO
         90idaRSc566+i6YTMHc7sZ415zRHQJMrUOZPDCys53qkJdWi3b5hDQ/MN+RLydISIgE2
         GwdnyrHrai/aOeaCCSDIFQHmxVT8/mRzDgfCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684268256; x=1686860256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJEJEgHLDw3Nrf2OYxAw65J2/yLmkvxFlpYWiAtQcmA=;
        b=T9jqYQ/Dg2sDMVjJrZK1dKYT7Wz31CIe0OxZhacuFNu2HriduJbegnTtoHEsH2vQdi
         TT0i0C+gbdjpIC7fcGhhEGfpv/lpDgNqZ8Amggvygn9qCoAuzKDaXQy+Nu8R+S5H/XtT
         Gf0GCpKKkyWgosbfDfmIKIHQXYfz71TeBW+CQaS5DJMUdau2WZokXZ46jna9aSjlZCzu
         WsdEa7TQVP9hI3XmoT1kNHpyIqDVkvm7M6WJPXKJLb6pyhCQUWFNmRqQuFo5aJIxbujM
         a2q1szKWZFNUYpq2kU3bko+PynnCjypPHFSgQSgZ/eLgTzG0S5Qv6p12jemX7WdtuOHv
         Jtig==
X-Gm-Message-State: AC+VfDxTYBISJVJsyuyfVzIKOQUJAslX2rBzEFEAsmG1i1pQHIZ4K2n3
        P5OiKUcDzXhFNjVhxPxDjkosPw==
X-Google-Smtp-Source: ACHHUZ6Oynxwi7sloZ3Ypg7XgSCwwZO30bG7FPKKxxgXTbfRZw5iZB64xYqMeanZeGOcTKnSKanXQg==
X-Received: by 2002:a05:6a00:189a:b0:646:7234:cbfc with SMTP id x26-20020a056a00189a00b006467234cbfcmr43435667pfh.27.1684268255812;
        Tue, 16 May 2023 13:17:35 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q26-20020a62e11a000000b0063d29df1589sm13747558pfh.136.2023.05.16.13.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:17:34 -0700 (PDT)
Date:   Tue, 16 May 2023 13:17:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michael McCracken <michael.mccracken@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        serge@hallyn.com, tycho@tycho.pizza,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] sysctl: add config to make randomize_va_space RO
Message-ID: <202305161312.078E5E7@keescook>
References: <20230504213002.56803-1-michael.mccracken@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504213002.56803-1-michael.mccracken@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 04, 2023 at 02:30:02PM -0700, Michael McCracken wrote:
> Add config RO_RANDMAP_SYSCTL to set the mode of the randomize_va_space
> sysctl to 0444 to disallow all runtime changes. This will prevent
> accidental changing of this value by a root service.
> 
> The config is disabled by default to avoid surprises.
> 
> Signed-off-by: Michael McCracken <michael.mccracken@gmail.com>
> ---
>  kernel/sysctl.c | 4 ++++
>  mm/Kconfig      | 7 +++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index bfe53e835524..c5aafb734abe 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1913,7 +1913,11 @@ static struct ctl_table kern_table[] = {
>  		.procname	= "randomize_va_space",
>  		.data		= &randomize_va_space,
>  		.maxlen		= sizeof(int),
> +#if defined(CONFIG_RO_RANDMAP_SYSCTL)
> +		.mode		= 0444,
> +#else
>  		.mode		= 0644,
> +#endif

The way we've dealt with this in the past for similarly sensitive
sysctl variables to was set a "locked" position. (e.g. 0==off, 1==on,
2==cannot be turned off). In this case, we could make it, 0, 1, 2,
3==forced on full.

I note that there is actually no min/max (extra1/extra2) for this sysctl,
which is itself a bug, IMO. And there is just a magic "> 1" test that
should be a define or enum:

fs/binfmt_elf.c:        if ((current->flags & PF_RANDOMIZE) && (randomize_va_space > 1)) {

I think much of this should be improved.

Regardless, take a look at yama_dointvec_minmax(), which could, perhaps,
be generalized and used here.

Then we have a run-time way to manage this bit, without needing full
kernel rebuilds, etc, etc.

-Kees

-- 
Kees Cook
