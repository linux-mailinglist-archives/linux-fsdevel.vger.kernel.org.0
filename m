Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABB1182149
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 19:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbgCKSxz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 14:53:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39357 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730927AbgCKSxy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:53:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id w65so1836827pfb.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2020 11:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VDvnNzuVZRF1OQ+owZ2HapaaeoLU1qYO7HZNkHLtFHQ=;
        b=gy6OvkUeXGeKaiQsNa9fM23j5TYpXenPdxP8SzNFiO3ORUUU4+FO2hEMgeun8Qne5v
         vd4GU6iwXK9iudf6/mOVqAbdPSbMtFm1ANBBbYj5HHUy0M6X3mtgb4LMBFtWX8scU8PR
         Ad9FOFuKRowitYA2nAxkqTi8vG/9U34BWV/2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VDvnNzuVZRF1OQ+owZ2HapaaeoLU1qYO7HZNkHLtFHQ=;
        b=S11eIFxRi68KIwwwN3EunL9rJbroWwWHC7sCAYbxLPdVNrTXSnbLFXMcqXe5Y6Gw4M
         KFKQqEhCrJsN2fQzshMgPELwY4KDVQztPWulHD2tQCC6nYm1xGnRxogXDwLu9h1kz5IA
         Pzj2fMRzmKpGpK8208yFVaeECtt76dETyTJ/pBDGrj28Czu3vpm7hj6M3MyrFnfUv0xz
         luXJVWYlwFKisVIsnnQQb6X1+22R57g1Z9iR6a4KzkD3jJEZEzOoY+eKQqZRnFO1QRpM
         67x8IoXqNPcek66tCZUqSzeRVn1ucyYK0AhtOnc/Vc/s2kOi/xnB4YSf5t3yP8sBKahz
         Q6Kg==
X-Gm-Message-State: ANhLgQ2ibMdFPi33x3caB9N4qK3gjc2pYqnM4vLonFzhPQbGxT6BtqLV
        ghPooukmMnsZ2ldgWS2DIHo2mg==
X-Google-Smtp-Source: ADFU+vvTWaKfyc2n6gEYsa1Kpaa2di3XtHi232URM9zPqVf3eyBLvR6B2d0u5N8KlTiOP7L1tPCgUw==
X-Received: by 2002:a62:cdcc:: with SMTP id o195mr2111873pfg.323.1583952832074;
        Wed, 11 Mar 2020 11:53:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i13sm431770pfd.180.2020.03.11.11.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 11:53:51 -0700 (PDT)
Date:   Wed, 11 Mar 2020 11:53:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yuyang Du <duyuyang@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Kellner <christian@kellner.me>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH 3/4] mm: docs: Fix a comment in process_vm_rw_core
Message-ID: <202003111153.A77D048@keescook>
References: <878sk94eay.fsf@x220.int.ebiederm.org>
 <AM6PR03MB517086003BD2C32E199690A3E4FE0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <87r1y12yc7.fsf@x220.int.ebiederm.org>
 <87k13t2xpd.fsf@x220.int.ebiederm.org>
 <87d09l2x5n.fsf@x220.int.ebiederm.org>
 <AM6PR03MB5170F0F9DC18F5EA77C9A857E4FE0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <871rq12vxu.fsf@x220.int.ebiederm.org>
 <AM6PR03MB5170DF45E3245F55B95CCD91E4FE0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <877dzt1fnf.fsf@x220.int.ebiederm.org>
 <AM6PR03MB5170ED6D4D216EEEEF400136E4FF0@AM6PR03MB5170.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR03MB5170ED6D4D216EEEEF400136E4FF0@AM6PR03MB5170.eurprd03.prod.outlook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 10, 2020 at 02:44:10PM +0100, Bernd Edlinger wrote:
> This removes a duplicate "a" in the comment in process_vm_rw_core.
> 
> Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  mm/process_vm_access.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
> index 357aa7b..b3e6eb5 100644
> --- a/mm/process_vm_access.c
> +++ b/mm/process_vm_access.c
> @@ -204,7 +204,7 @@ static ssize_t process_vm_rw_core(pid_t pid, struct iov_iter *iter,
>  	if (!mm || IS_ERR(mm)) {
>  		rc = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
>  		/*
> -		 * Explicitly map EACCES to EPERM as EPERM is a more a
> +		 * Explicitly map EACCES to EPERM as EPERM is a more
>  		 * appropriate error code for process_vw_readv/writev
>  		 */
>  		if (rc == -EACCES)
> -- 
> 1.9.1

-- 
Kees Cook
