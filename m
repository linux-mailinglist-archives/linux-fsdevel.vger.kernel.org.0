Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4912F1C9933
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 20:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgEGSXA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 14:23:00 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35144 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbgEGSXA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 14:23:00 -0400
Received: by mail-pj1-f68.google.com with SMTP id ms17so2997470pjb.0;
        Thu, 07 May 2020 11:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=crOGNM1IiUdeKZ/Udc473eZwbzdnFX83mUx0lAy7H7w=;
        b=WbuHqxk+AdWTuV7r8z7510wccudAPgeCTPKpyIomIGpEaCBfAQKYf4fbWkRv+h2pD3
         k7oV2HsHzcYijcjFfND0uVUDrI3c++5YdPyqtTYiF7yfL5wtvtcIOsVPN7KEaOgM0oed
         dWYmcVuhqfTbU85qds9qo+iRr0SyNyabIrIxzGb5RV1s6O7E2YNst7llAX4KWKMCqusS
         6xwnfIro1x679JKck+qUnjCIPwr0LRpCPUY+RDAfwuFy8AmCsBjkcqcl8J3p5qBiLPJC
         wyvVdozulcXLNxZoTR322JwkTkuLmXLL/a218yG3lmhQFj+axxI66fSjVFna2JospJLt
         Mu3g==
X-Gm-Message-State: AGi0PuZ3NkBv112mEcylHZG7YEAQ4wC6NGWnIgvZHR8zniH+d9mwa5A1
        xCryH86gj4V19eiUfMIsKrs=
X-Google-Smtp-Source: APiQypKahnzYyNUg9AVnphKZxOGotDLI5iak1AH7DVsvqQtw4mS2xuWkahM3ViDKvMYI+csMPj4q9Q==
X-Received: by 2002:a17:902:b206:: with SMTP id t6mr14698777plr.270.1588875779441;
        Thu, 07 May 2020 11:22:59 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 192sm5459770pfu.182.2020.05.07.11.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 11:22:58 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id CF043403EA; Thu,  7 May 2020 18:22:57 +0000 (UTC)
Date:   Thu, 7 May 2020 18:22:57 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        dyoung@redhat.com, bhe@redhat.com, corbet@lwn.net,
        keescook@chromium.org, akpm@linux-foundation.org, cai@lca.pw,
        rdunlap@infradead.org
Subject: Re: [PATCH v2] kernel: add panic_on_taint
Message-ID: <20200507182257.GX11244@42.do-not-panic.com>
References: <20200507180631.308441-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507180631.308441-1-aquini@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 07, 2020 at 02:06:31PM -0400, Rafael Aquini wrote:
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 8a176d8727a3..b80ab660d727 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1217,6 +1217,13 @@ static struct ctl_table kern_table[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_ONE,
>  	},
> +	{
> +		.procname	= "panic_on_taint",
> +		.data		= &panic_on_taint,
> +		.maxlen		= sizeof(unsigned long),
> +		.mode		= 0644,
> +		.proc_handler	= proc_doulongvec_minmax,
> +	},

You sent this out before I could reply to the other thread on v1.
My thoughts on the min / max values, or lack here:
                                                                                
Valid range doesn't mean "currently allowed defined" masks.                     

For example, if you expect to panic due to a taint, but a new taint type
you want was not added on an older kernel you would be under a very
*false* sense of security that your kernel may not have hit such a
taint, but the reality of the situation was that the kernel didn't
support that taint flag only added in future kernels.                           

You may need to define a new flag (MAX_TAINT) which should be the last
value + 1, the allowed max values would be                                      

(2^MAX_TAINT)-1                                                                 

or                                                                              

(1<<MAX_TAINT)-1  

Since this is to *PANIC* I think we do want to test ranges and ensure
only valid ones are allowed.

  Luis
