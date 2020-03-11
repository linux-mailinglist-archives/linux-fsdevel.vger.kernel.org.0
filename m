Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9B5A18214E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 19:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730987AbgCKSyH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 14:54:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42401 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730799AbgCKSyG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:54:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id h8so1675365pgs.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2020 11:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+NFtzlNIubXyKkT0aaqAyTYGNu2hBMxpytJJLWrkR+w=;
        b=Xu0YYNq6iL3XItsLJITZiAfw7pQ55+Wan446ePi0MQv+K8wkXn4aRCAf4e5Emt+HlC
         hKXOCC/w+kuvCqACGDt+jTb/a6HCI7Gwm6wXsgSTYmC6M16yXJO58tUwc7cQNtetwc/Z
         JdAJWbhaOAvARZcMbagpxGBlTJO9eEMDFM22E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+NFtzlNIubXyKkT0aaqAyTYGNu2hBMxpytJJLWrkR+w=;
        b=A7YjPK8+vYGk+O8+Ulbgs7xYf9kJ6VOAR56XmoETeDHGveZQslN97CoocZhgp9sywK
         Rhvky0qN9trYkTO75/pwa0g/qyyXe3y4d3iD9DglndHwNS+kbRtuFwghqX8q1NO+X1mM
         tCvLogvqa4OSFv87WcW9leB8Fr/DU/L9yd2yNz8Li0IQYXVyZR6NK6KFFbkYd+Yb0cH2
         4sLKzTAJWdrSfK6whvfTE/MkFGFFtiNYmsqEONxWGCGbzCI0Ye8UwvK/TSBs36K1Lzam
         1FwRFkov6vYmk6xhwP9zACsBn8q2VM2qYQu2FyaYCrYHSLLtEbsxX/ryY8512ySZBs9J
         sC+g==
X-Gm-Message-State: ANhLgQ3A3WyjlKDuRd2g7DsazM3L2HEv/GzGCowwI5aaH2RGPJ+hhSem
        ybwq3yheLohoAYI0rPIxzGmnJw==
X-Google-Smtp-Source: ADFU+vtdcKOyGaZUfwI5+MQMZZomjwrU/L0V+T9gd4shCDOL0PoNkiwaShk91h0o8jLRtEUWUh1JTA==
X-Received: by 2002:a63:b04f:: with SMTP id z15mr4044123pgo.58.1583952845893;
        Wed, 11 Mar 2020 11:54:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z24sm19444621pfk.46.2020.03.11.11.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 11:54:05 -0700 (PDT)
Date:   Wed, 11 Mar 2020 11:54:04 -0700
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
Subject: Re: [PATCH 4/4] kernel: doc: remove outdated comment cred.c
Message-ID: <202003111154.AEA9260278@keescook>
References: <878sk94eay.fsf@x220.int.ebiederm.org>
 <AM6PR03MB517086003BD2C32E199690A3E4FE0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <87r1y12yc7.fsf@x220.int.ebiederm.org>
 <87k13t2xpd.fsf@x220.int.ebiederm.org>
 <87d09l2x5n.fsf@x220.int.ebiederm.org>
 <AM6PR03MB5170F0F9DC18F5EA77C9A857E4FE0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <871rq12vxu.fsf@x220.int.ebiederm.org>
 <AM6PR03MB5170DF45E3245F55B95CCD91E4FE0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <877dzt1fnf.fsf@x220.int.ebiederm.org>
 <AM6PR03MB517039DB07AB641C194FEA57E4FF0@AM6PR03MB5170.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR03MB517039DB07AB641C194FEA57E4FF0@AM6PR03MB5170.eurprd03.prod.outlook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 10, 2020 at 02:44:18PM +0100, Bernd Edlinger wrote:
> This removes an outdated comment in prepare_kernel_cred.
> 
> There is no "cred_replace_mutex" any more, so the comment must
> go away.
> 
> Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  kernel/cred.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/cred.c b/kernel/cred.c
> index 809a985..71a7926 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -675,8 +675,6 @@ void __init cred_init(void)
>   * The caller may change these controls afterwards if desired.
>   *
>   * Returns the new credentials or NULL if out of memory.
> - *
> - * Does not take, and does not return holding current->cred_replace_mutex.
>   */
>  struct cred *prepare_kernel_cred(struct task_struct *daemon)
>  {
> -- 
> 1.9.1

-- 
Kees Cook
