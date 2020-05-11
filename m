Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A85D1CE8DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 01:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgEKXKs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 19:10:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34092 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgEKXKs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 19:10:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id f6so5253985pgm.1;
        Mon, 11 May 2020 16:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hiDXhOqEaRntgCYoG58/UdjziepUsw/dC1iXbtsscqA=;
        b=Ci2AFzx7ycftJt3SvKCsMgMptMKcoGYmGnNaG1Wcmd4s5HJVlGulHtKdYzzzqPxeVu
         3SCQTWYR4XJYx13+V2aSF69lI6yCcx9GQ2Xn1K57/lx+4G6P067tg0RSU/iwSNh4j2ga
         goiGJiF54v7s5Zk5H64g0EGbsr3AnLtdQZ4slEeOHnlrmgbhFMBsD19/DYrdKOOH7Tqp
         E0Z5HeyXL8t0F1Q+vhEApc938P1DRfkmawoQHkS+hMyrK+egH0IQdx0M3lcrgBkXkc2v
         qsCt1/MUw6dhZw+wXR5cCwSyIRc/igGaMarCnvjJNvgZLRNeBj6PKzczwYb9DvH8hZWU
         v5pQ==
X-Gm-Message-State: AGi0PubBm1R2TNeRjFe44AEYUasTCTW5OARhzuIwvsSpv9SbGwD3j1g9
        S0R78t6UUawAZGlohb9WPB0=
X-Google-Smtp-Source: APiQypLfJ+/qZ8hg4TRPTKCku7E/+jkbFKeR4v9woB8GlnH1VF376jqEN5s7ekcr9g9ByNAjPDI+sw==
X-Received: by 2002:a62:35c1:: with SMTP id c184mr17106381pfa.120.1589238647214;
        Mon, 11 May 2020 16:10:47 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 1sm9944534pff.151.2020.05.11.16.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 16:10:46 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 73D1940605; Mon, 11 May 2020 23:10:45 +0000 (UTC)
Date:   Mon, 11 May 2020 23:10:45 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Rafael Aquini <aquini@redhat.com>, Tso Ted <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        keescook@chromium.org, yzaikin@google.com
Subject: Re: [PATCH] kernel: sysctl: ignore invalid taint bits introduced via
 kernel.tainted and taint the kernel with TAINT_USER on writes
Message-ID: <20200511231045.GV11244@42.do-not-panic.com>
References: <20200511215904.719257-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511215904.719257-1-aquini@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 11, 2020 at 05:59:04PM -0400, Rafael Aquini wrote:
> The sysctl knob allows any user with SYS_ADMIN capability to
> taint the kernel with any arbitrary value, but this might
> produce an invalid flags bitset being committed to tainted_mask.
> 
> This patch introduces a simple way for proc_taint() to ignore
> any eventual invalid bit coming from the user input before
> committing those bits to the kernel tainted_mask, as well as
> it makes clear use of TAINT_USER flag to mark the kernel
> tainted by user everytime a taint value is written
> to the kernel.tainted sysctl.
> 
> Signed-off-by: Rafael Aquini <aquini@redhat.com>
> ---
>  kernel/sysctl.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 8a176d8727a3..f0a4fb38ac62 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2623,17 +2623,32 @@ static int proc_taint(struct ctl_table *table, int write,
>  		return err;
>  
>  	if (write) {
> +		int i;
> +
> +		/*
> +		 * Ignore user input that would make us committing
> +		 * arbitrary invalid TAINT flags in the loop below.
> +		 */
> +		tmptaint &= (1UL << TAINT_FLAGS_COUNT) - 1;

This looks good but we don't pr_warn() of information lost on intention.

> +
>  		/*
>  		 * Poor man's atomic or. Not worth adding a primitive
>  		 * to everyone's atomic.h for this
>  		 */
> -		int i;
>  		for (i = 0; i < BITS_PER_LONG && tmptaint >> i; i++) {
>  			if ((tmptaint >> i) & 1)
>  				add_taint(i, LOCKDEP_STILL_OK);
>  		}
> +
> +		/*
> +		 * Users with SYS_ADMIN capability can include any arbitrary
> +		 * taint flag by writing to this interface. If that's the case,
> +		 * we also need to mark the kernel "tainted by user".
> +		 */
> +		add_taint(TAINT_USER, LOCKDEP_STILL_OK);

I'm in favor of this however I'd like to hear from Ted on if it meets
the original intention. I would think he had a good reason not to add
it here.

   Luis

>  	}
>  
> +
>  	return err;
>  }
>  
> -- 
> 2.25.4
> 
