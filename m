Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922F2505F93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 00:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiDRWES (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Apr 2022 18:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiDRWEQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:04:16 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CFC20BF9
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Apr 2022 15:01:36 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id u2so21274984pgq.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Apr 2022 15:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P5IiPKnNcqLzyMGe36J+KRFeZwk+XdVfvsBemLoLfGA=;
        b=JGLGYT5P28WH10R7rDB8r7F+8ZGRQomASZQhepSICRbRvfj34Zf6nvCA/D1ExIkyCZ
         xr4k03YVJROfAWk/GeRxz2GUTh7fK/p4PH3b34w+9V6utFBQLbnr8WhTG4a2Hmp1v9V7
         FjiXjiMaLenbmnkhxpW48XtCokpdkyI3MAeoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P5IiPKnNcqLzyMGe36J+KRFeZwk+XdVfvsBemLoLfGA=;
        b=uFEUtv6mXNuRqnlbBVz9g886B0ji8cj4QRY7Nqfu9yAm28qQ8uFIqvUOO+bs9mVBD9
         HrCpTS5I35iAHBHLE1VH7A1xefs59ys4gMv6am6Q2C1DrtN8u9AXeGXXg1iKqCRnG+k7
         60mETT62pp1DQRxOPW+4nlLjUVg4erZsZo4Fg2eYa70C41z7pHn4Q7rzK0cRVw5TeW8F
         ThFEXHFtyWMJGX0IqPQovGTaex8ryBJm+6/J4rsuwZM151tV79dDpa5pYHcs/osPqEPP
         jmZijd4Fq+R0DNg/j0WGJFNKyM8D6SnQI5m31wuhtJ1CuWBXt3W3nRdMkSpbUnlR3FlN
         7+tA==
X-Gm-Message-State: AOAM533ho7QeWuX3+9RlEUK1YSapgCWBRpG/8qZ8d9qqDKhuAF4xTTXZ
        Zl34ykYdp3ceysMBbcKzgvF1vA==
X-Google-Smtp-Source: ABdhPJwrNaWr3wngnD9TQeLYfooQkh8o7MVbDAYZ6Wn4GCGz6QHu+72pxysFdVDhltuC1iQZ6njgAg==
X-Received: by 2002:a05:6a00:1695:b0:4f7:decc:506b with SMTP id k21-20020a056a00169500b004f7decc506bmr14646094pfc.7.1650319296279;
        Mon, 18 Apr 2022 15:01:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090a31ca00b001cb87502e32sm13809395pjf.23.2022.04.18.15.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 15:01:35 -0700 (PDT)
Date:   Mon, 18 Apr 2022 15:01:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Mike Frysinger <vapier@gentoo.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        kernel test robot <lkp@intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] binfmt_flat: fix sparse annotation ordering
Message-ID: <202204181501.D55C8D2A@keescook>
References: <20220418200834.1501454-1-Niklas.Cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418200834.1501454-1-Niklas.Cassel@wdc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 18, 2022 at 08:09:12PM +0000, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> The sparse annotation ordering inside the function call is swapped.
> 
> Fix the ordering so that we silence the following sparse warnings:
> fs/binfmt_flat.c:816:39: warning: incorrect type in argument 1 (different address spaces)
> fs/binfmt_flat.c:816:39:    expected unsigned int [noderef] [usertype] __user *rp
> fs/binfmt_flat.c:816:39:    got unsigned int [usertype] *[noderef] __user
> 
> No functional change as sparse annotations are ignored by the compiler.
> 
> Fixes: a767e6fd68d2 ("binfmt_flat: do not stop relocating GOT entries prematurely on riscv")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Cc: <stable@vger.kernel.org>
> ---
> Hello Kees,
> 
> Sorry about this.
> Feel free to squash it with the existing patch if you so like.

Ah-ha! Thanks; I was just looking at the sparse email. :)

-Kees

> 
>  fs/binfmt_flat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
> index e5e2a03b39c1..dca0b6875f9c 100644
> --- a/fs/binfmt_flat.c
> +++ b/fs/binfmt_flat.c
> @@ -813,7 +813,7 @@ static int load_flat_file(struct linux_binprm *bprm,
>  	 * image.
>  	 */
>  	if (flags & FLAT_FLAG_GOTPIC) {
> -		rp = skip_got_header((u32 * __user) datapos);
> +		rp = skip_got_header((u32 __user *) datapos);
>  		for (; ; rp++) {
>  			u32 addr, rp_val;
>  			if (get_user(rp_val, rp))
> -- 
> 2.35.1

-- 
Kees Cook
