Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529A1219499
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 01:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgGHXuA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 19:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgGHXt7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 19:49:59 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687E2C061A0B
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 16:49:59 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z3so165901pfn.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 16:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cdJJ5r+BqrO/qlRhUW7k9YoabQA26UHQQU/lmrdCNU4=;
        b=EAcptXzMsr1BjEYa7HxVxUcyj7xGkNKAxC/wx6vNj8tkfFUUxRBx3kh2osiH2ygzSu
         24N0CWKIE2/80wUBSTofZfsEQZmaI/UlZbqNRTvSJsi7sxB+rDv+7Xq9NWvYcl3aVPj1
         6CB4n/ImV3QbEW7DMQrcK0PGK2lqSaxgZEuPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cdJJ5r+BqrO/qlRhUW7k9YoabQA26UHQQU/lmrdCNU4=;
        b=Ic+53vYZGW7JI7KOpmcOD791isjEn1Lm1Rz0LKLPukhSC5g29R7wAeWy1LvGLpQW7Z
         ISkc6jtAiLH3IQKwDmhuSHwwWex0lXMJJfCGTSHujxBlJ3oROx2AvI9Fi2R0c6uxjKsJ
         T9mYpZ5FD5A03ZShJfhBSuR5rz8Teg4jpgUOcPVg680iivYaLzmqO+ORpXvD3VR9Pndi
         gNpjdXsKSa5I064fr4ZD+pewGbnwBnoPW3VeSmqW2TKlsU72IdzN9kdtgmqXZUkO5oju
         o45+MLD8rz5NmGXMbPe8IH5rgZlEwiLJefl7hv/bGymQLn1Oa6+3FqVL63wSOO9lnsfS
         aMcQ==
X-Gm-Message-State: AOAM5320O65cS5vCCh45qCdrMg3MSkPDbB/rvrm0OQ/DoZHrsL2KbPfv
        DGd8YjPYTvwRezBp5EzFr6bw44fa2dM=
X-Google-Smtp-Source: ABdhPJysfVsNKGkbpEgU6PL7cKFI4ZUeAqpmCKgcJfT0/XsmRTdUaHLhXN8y1mNfMbIwEs/yIdK84Q==
X-Received: by 2002:aa7:98c6:: with SMTP id e6mr56705310pfm.17.1594252198968;
        Wed, 08 Jul 2020 16:49:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t29sm781588pfq.50.2020.07.08.16.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 16:49:58 -0700 (PDT)
Date:   Wed, 8 Jul 2020 16:49:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Laight <David.Laight@ACULAB.COM>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 4/7] pidfd: Replace open-coded partial receive_fd()
Message-ID: <202007081649.622969AAFB@keescook>
References: <20200706201720.3482959-1-keescook@chromium.org>
 <20200706201720.3482959-5-keescook@chromium.org>
 <20200707122220.cazzek4655gj4tj7@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707122220.cazzek4655gj4tj7@wittgenstein>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 07, 2020 at 02:22:20PM +0200, Christian Brauner wrote:
> On Mon, Jul 06, 2020 at 01:17:17PM -0700, Kees Cook wrote:
> > The sock counting (sock_update_netprioidx() and sock_update_classid()) was
> > missing from pidfd's implementation of received fd installation. Replace
> > the open-coded version with a call to the new receive_fd()
> > helper.
> > 
> > Thanks to Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com> for
> > catching a missed fput() in an earlier version of this patch.
> > 
> > Fixes: 8649c322f75c ("pid: Implement pidfd_getfd syscall")
> > Reviewed-by: Sargun Dhillon <sargun@sargun.me>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> 
> Thanks!
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Christoph, Kees,
> 
> So while the patch is correct it leaves 5.6 and 5.7 with a bug in the
> pidfd_getfd() implementation and that just doesn't seem right. I'm
> wondering whether we should introduce:
> 
> void sock_update(struct file *file)
> {
> 	struct socket *sock;
> 	int error;
> 
> 	sock = sock_from_file(file, &error);
> 	if (sock) {
> 		sock_update_netprioidx(&sock->sk->sk_cgrp_data);
> 		sock_update_classid(&sock->sk->sk_cgrp_data);
> 	}
> }
> 
> and switch pidfd_getfd() over to:
> 
> diff --git a/kernel/pid.c b/kernel/pid.c
> index f1496b757162..c26bba822be3 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -642,10 +642,12 @@ static int pidfd_getfd(struct pid *pid, int fd)
>         }
> 
>         ret = get_unused_fd_flags(O_CLOEXEC);
> -       if (ret < 0)
> +       if (ret < 0) {
>                 fput(file);
> -       else
> +       } else {
> +               sock_update(file);
>                 fd_install(ret, file);
> +       }
> 
>         return ret;
>  }
> 
> first thing in the series and then all of the other patches on top of it
> so that we can Cc stable for this and that can get it backported to 5.6,
> 5.7, and 5.8.
> 
> Alternatively, I can make this a separate bugfix patch series which I'll
> send upstream soonish. Or we have specific patches just for 5.6, 5.7,
> and 5.8. Thoughts?

I was thinking of just tossing the entire series (hch's and mine) at
-stable since it's relatively narrow. I'll look at what's needed for
backports...

> 
> Thanks!
> Christian

-- 
Kees Cook
