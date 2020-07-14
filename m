Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F7A22004B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 23:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgGNVt0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 17:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbgGNVt0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:49:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9261C061794
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 14:49:25 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ls15so37811pjb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 14:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z/2Da3iNyWh0eVa9re/PxqTbl8E4lNL39Wvo8BQa5Jk=;
        b=OfmVSBDsHc9Rmasjt6KXSUQdd+K+htfdnDGZNH60suyaUxoZ6TXC2sZQyckRFbNtVW
         eCczQAunkP9IdML7SUT1mKGAgRCYJZ2JU2BzFii89fLlf5/fb6WZmg8/bak5hryNE5Y3
         stsrls1AUgm02a5MgTkAsfCOzaG5T8ZvxZN3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z/2Da3iNyWh0eVa9re/PxqTbl8E4lNL39Wvo8BQa5Jk=;
        b=pMR/DINa6Fg4EiQPoMTBJ1JEJdQE39kxvJXU97UP/wmQxylLfsiWLPBFWHwM1UCj+Q
         o4WmsoGwrAL5VTUPFvH2tjNq9KjIMyJ4eqIycoYQ5A0F5d9Cp/YYvaZJdNNg99eUduCr
         RTLRr3pEMF4E1xRJ36imdgHSXWoaxasTQCD9V43NefAAubwu5yu1cS8mmHUN40hjibCQ
         8D3uomrTcX70LN6RZSK2Sy2PZxC+XkAiN0BZj3KtspsJfy1+zFwdkiy3KYEgDObfIW4F
         wVGlCvswfQFUpJa9coyam+TI8MRvNNSWM0JTHEwGJ2fABVfHYty7taVlWaIfQY88Vl9x
         ws/g==
X-Gm-Message-State: AOAM531TXFZ/LFqB/ePV5ODOrkoRMPXiy/dAjYSbIh9aMCcVRl0JB6Wv
        TIER8ezXlNJ3tctILokmVG+nOA==
X-Google-Smtp-Source: ABdhPJyfHN6nndxTZkr0qhDNx67iZO+T5mcaIl+et4AYLVpGCPX9K8cfoszp9wO2zi7jQoRkZbuhYA==
X-Received: by 2002:a17:90a:240a:: with SMTP id h10mr7042196pje.225.1594763365288;
        Tue, 14 Jul 2020 14:49:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id br9sm48405pjb.56.2020.07.14.14.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 14:49:24 -0700 (PDT)
Date:   Tue, 14 Jul 2020 14:49:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 7/7] exec: Implement kernel_execve
Message-ID: <202007141446.A72A4437C@keescook>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
 <87wo365ikj.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo365ikj.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 08:31:40AM -0500, Eric W. Biederman wrote:
> +static int count_strings_kernel(const char *const *argv)
> +{
> +	int i;
> +
> +	if (!argv)
> +		return 0;
> +
> +	for (i = 0; argv[i]; ++i) {
> +		if (i >= MAX_ARG_STRINGS)
> +			return -E2BIG;
> +		if (fatal_signal_pending(current))
> +			return -ERESTARTNOHAND;
> +		cond_resched();
> +	}
> +	return i;
> +}

I notice count() is only ever called with MAX_ARG_STRINGS. Perhaps
refactor that too? (And maybe rename it to count_strings_user()?)

Otherwise, looks good:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
