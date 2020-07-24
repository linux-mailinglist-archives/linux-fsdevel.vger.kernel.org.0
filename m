Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABAC22C73A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 16:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgGXOBy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 10:01:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60389 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726424AbgGXOBy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595599312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h58gw7R+GfsXhRxRgYaoVnY4fYCgBX9KOXMmOVyWW4s=;
        b=CoBbkhZYH72Q0z4WXKVakzzrzeK13W+oMFR8gZ7d/sc4bHE8MhqgacNtocjyCSNZxJKBn4
        XbHFw2dsFYgLx0yrF8l4VVrS2aQiL6KSD2KOy0ZwQkHaVXigEtsnk+urcgfC6cfofnuaXB
        vS7F3sIn5M360ChecvUHrVTpb1+4T6g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-dd-nH0nfM5q2UvPsCcNRwQ-1; Fri, 24 Jul 2020 10:01:50 -0400
X-MC-Unique: dd-nH0nfM5q2UvPsCcNRwQ-1
Received: by mail-wr1-f70.google.com with SMTP id d6so628435wrv.23
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 07:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h58gw7R+GfsXhRxRgYaoVnY4fYCgBX9KOXMmOVyWW4s=;
        b=HvKmBcHh8d1srQy4G0VrQY11dLUBccEiJ8fIbavT8rvaq6XCbE3QpgFzrWU/v3C3eK
         a6hzY/pJwRXWfP4zXp5OYTmtUDuExatrLMWAS4ga6XEzZ5Ev2Od52JAMIb8zlD79vrR6
         X5RzYVw3Mb9KGGCS7QiqaVpEIOk0hEsP5gQzPiKtXsGeD/rMvT5PINHFfk1/sm4F8Y+R
         RZKbnj+6upU76ZyjHk7PlCmkYK8m3fqjCYjXexM25EdhJfKzbqmiq2YNE9p+xToQRBCl
         kTr5rQ8eaY909M+71xvyKK0h47CxtOqbYJnD7M86yQ8MVfQcMeqJGQq4ez6ZhzfebFUv
         c/YQ==
X-Gm-Message-State: AOAM530YYqNACtWsO1SZhnwmDWFNjwg/WAlSPwgn2FrYS+mOkLe97+wh
        8prPUdK9cpzzxFVj1R3BKr4NqpJ0ZNr03sUr/2ccFmUc5AYBMgv9cycV4z9H+eIPICksaj6nale
        fC+mJNhnChy7Nu2/jyZkhxLisnQ==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr8591787wrn.65.1595599309159;
        Fri, 24 Jul 2020 07:01:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8AE5R6S+b+buLU+LUHHWuTW7BnkD+owPh/6nz7iYv5AbEV6g3oBIiNG04DOXBaoxxqeb4JA==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr8591766wrn.65.1595599308952;
        Fri, 24 Jul 2020 07:01:48 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
        by smtp.gmail.com with ESMTPSA id x82sm2136323wmb.30.2020.07.24.07.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 07:01:48 -0700 (PDT)
Date:   Fri, 24 Jul 2020 10:01:44 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>, Shaohua Li <shli@fb.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, timmurray@google.com,
        minchan@google.com, sspatil@google.com, lokeshgidra@google.com
Subject: Re: [PATCH 0/2] Control over userfaultfd kernel-fault handling
Message-ID: <20200724094505-mutt-send-email-mst@kernel.org>
References: <20200423002632.224776-1-dancol@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423002632.224776-1-dancol@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 22, 2020 at 05:26:30PM -0700, Daniel Colascione wrote:
> This small patch series adds a new flag to userfaultfd(2) that allows
> callers to give up the ability to handle user-mode faults with the
> resulting UFFD file object. In then add a new sysctl to require
> unprivileged callers to use this new flag.
> 
> The purpose of this new interface is to decrease the change of an
> unprivileged userfaultfd user taking advantage of userfaultfd to
> enhance security vulnerabilities by lengthening the race window in
> kernel code.

There are other ways to lengthen the race window, such as madvise
MADV_DONTNEED, mmap of fuse files ...
Could the patchset commit log include some discussion about
why these are not the concern please?

Multiple subsystems including vhost have come to rely on
copy from/to user behaving identically to userspace access.

Could the patchset please include discussion on what effect blocking
these will have? E.g. I guess Android doesn't use vhost right now.
Will it want to do it to run VMs in 2021?

Thanks!

> This patch series is split from [1].
> 
> [1] https://lore.kernel.org/lkml/20200211225547.235083-1-dancol@google.com/

So in that series, Kees said:
https://lore.kernel.org/lkml/202002112332.BE71455@keescook/#t

What is the threat being solved? (I understand the threat, but detailing
  it in the commit log is important for people who don't know it.)

Could you pls do that?

> Daniel Colascione (2):
>   Add UFFD_USER_MODE_ONLY
>   Add a new sysctl knob: unprivileged_userfaultfd_user_mode_only
> 
>  Documentation/admin-guide/sysctl/vm.rst | 13 +++++++++++++
>  fs/userfaultfd.c                        | 18 ++++++++++++++++--
>  include/linux/userfaultfd_k.h           |  1 +
>  include/uapi/linux/userfaultfd.h        |  9 +++++++++
>  kernel/sysctl.c                         |  9 +++++++++
>  5 files changed, 48 insertions(+), 2 deletions(-)
> 
> -- 
> 2.26.2.303.gf8c07b1a785-goog
> 

