Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95C71CE287
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 20:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbgEKSY6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 14:24:58 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37113 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729713AbgEKSY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 14:24:58 -0400
Received: by mail-pj1-f65.google.com with SMTP id a7so8199362pju.2;
        Mon, 11 May 2020 11:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gzjYF0ep8XMaeJksKcr1mwS/Ul5KRJgBfVKTrx7XdJ8=;
        b=YDHwCHen8nAIlXkNjGyytBp4l/3THc/CLlDSTpZ2ov/9MEQ9lgcGqlURz9eWD6UY49
         Ht+7MCXeLI4re36/2CCRhVtRAz59KEmu1sZ+TgiPFxhMNu7lJr9cYWEKvA40lcd+dhi8
         qkRg97EWRcR8h3DdOA6gQMW/3obhX9IcJxhXyiFEqC2hO9t2GwThObeG6skwYIlx8sp3
         0zY/VMtBmda9nvA7gUkcTaLaxTDKB4s03ctagWfEms0bF0vWacZ5eUWbRmpXDPGBBJFV
         rkTLmHOUQuyw6s7yTeHsEFzZvW3IgdEtgld/kh7ONUN99NarRzrJCrk3w2p73DYXxSg4
         yvmw==
X-Gm-Message-State: AGi0PubnsxvtM0K7F8T+3Rp5ASSZyrscyWV9K/tJiAZ9AfB91aoC7qHH
        o/NqBnO51FBLWtJQBWzGq38RwVF1Mo0=
X-Google-Smtp-Source: APiQypKPXNbqjUaKuNkDw/NfTC1wA3JKFcVH3i5a3y/+Dd5/xFN9T+yDEPZ7DD1beXNuM8j6Z44Wqw==
X-Received: by 2002:a17:902:8e87:: with SMTP id bg7mr16102782plb.91.1589221497577;
        Mon, 11 May 2020 11:24:57 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id k6sm10585413pju.44.2020.05.11.11.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 11:24:56 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 62A1240605; Mon, 11 May 2020 18:24:55 +0000 (UTC)
Date:   Mon, 11 May 2020 18:24:55 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        dyoung@redhat.com, bhe@redhat.com, corbet@lwn.net,
        keescook@chromium.org, akpm@linux-foundation.org, cai@lca.pw,
        rdunlap@infradead.org, tytso@mit.edu, bunk@kernel.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        labbott@redhat.com, jeffm@suse.com, jikos@kernel.org, jeyu@suse.de,
        tiwai@suse.de, AnDavis@suse.com, rpalethorpe@suse.de
Subject: Re: [PATCH v3] kernel: add panic_on_taint
Message-ID: <20200511182455.GR11244@42.do-not-panic.com>
References: <20200509135737.622299-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509135737.622299-1-aquini@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 09, 2020 at 09:57:37AM -0400, Rafael Aquini wrote:
> +Trigger Kdump on add_taint()
> +============================
> +
> +The kernel parameter, panic_on_taint, calls panic() from within add_taint(),
> +whenever the value set in this bitmask matches with the bit flag being set
> +by add_taint(). This will cause a kdump to occur at the panic() call.
> +In cases where a user wants to specify this during runtime,
> +/proc/sys/kernel/panic_on_taint can be set to a respective bitmask value
> +to achieve the same behaviour.
> +
>  Contact
>  =======
>  
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 7bc83f3d9bdf..4a69fe49a70d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3404,6 +3404,21 @@
>  	panic_on_warn	panic() instead of WARN().  Useful to cause kdump
>  			on a WARN().
>  
> +	panic_on_taint=	[KNL] conditionally panic() in add_taint()
> +			Format: <str>
> +			Specifies, as a string, the TAINT flag set that will
> +			compose a bitmask for calling panic() when the kernel
> +			gets tainted.
> +			See Documentation/admin-guide/tainted-kernels.rst for
> +			details on the taint flags that users can pick to
> +			compose the bitmask to assign to panic_on_taint.
> +			When the string is prefixed with a '-' the bitmask
> +			set in panic_on_taint will be mutually exclusive
> +			with the sysctl knob kernel.tainted, and any attempt
> +			to write to that sysctl will fail with -EINVAL for
> +			any taint value that masks with the flags set for
> +			this option.

This talks about using a string, but that it sets a bitmask. Its not
very clear that one must use the string representation from each taint
flag. Also, I don't think to use the character representation as we
limit ourselves to the alphabet and quirky what-should-be-arbitrary
characters that represent the taint flags. The taint flag character
representation is juse useful for human reading of a panic, but I think
because of the limitation of the mask with the alphabet this was not
such a great idea long term.

So, I don't think we should keep on extending the alphabet use case, a
simple digit representation would suffice. I think this means we'd need
two params one for exclusive and one for the value of the taint.

Using a hex value or number also lets us make the input value shorter.

If a kernel boots with panic-on-taint flag not yet supported, we don't
complain, therefore getting a false sense of security that we will panic
with a not yet supported taint flag. I think we should pr_warn() or
fail to boot when that happens.

  Luis
