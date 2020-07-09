Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371D92198BC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 08:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgGIGfm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 02:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgGIGfm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 02:35:42 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDEBC08C5DC
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 23:35:41 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id i14so570155pfu.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 23:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DE1LuupcO0lUvaRya3W/C8Tbi5DeMgekx8sDP5vicOQ=;
        b=HoRESPD1JJh9Q/fTkQkymYUP5Wxy4cj9Le1XCVdCeSiE4zFNtVIEJgdKJqsUDX1Zkl
         H/73BLAMPG1OSjCvHl/4cAu+8IncSZznZ3KNrrqaJbi3JVvPqh8/GTvahKSSdizEtdOU
         uIyo3VW972Zp7A8il1iUa47IIVx/iJCnkAPzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DE1LuupcO0lUvaRya3W/C8Tbi5DeMgekx8sDP5vicOQ=;
        b=AmjSaRD93K2uJuKLVFzfqVKCACBBkJo47/PWFO7XlfrxbbKC7gN5ElklJccNr014f9
         ze1x1mrE6BgWIRgMEseP6FqtpIVzHJHjaNbEHLiqph1Idex2m8EG9snjxASpH5f5B+eB
         j/tMH6IGhBXVm2lKW6BgI78mnveSMFSOVWv/82UUNHOPV2fbDO24BjLnVGeUJTRElqYW
         22+ZLUyPui6AFoueCFTtsIDcVfDhiw0BT13W1ESxLyEJinVIFgB4rLNXn/yp4Wrr7T/+
         G5oETZ/LI5+vlcWD8gz6arR91g4rQlz3/9k6cSQyizRGuikPnPi3DaVSJKjCrAawyaEs
         9pEA==
X-Gm-Message-State: AOAM531wcBXoDqZewnWI6LEUemdlS2HR3xJ2XmA6S9tENRMFsbDuYr+c
        UQVjPqTBvb+A6atc8p0dxugGCg==
X-Google-Smtp-Source: ABdhPJzDBqXhJupcvKcK6cxWAsn2yNY4A3u45Jw1CaNnFZFHcxzANck+2I+4Usidv8kzycZChQDCAQ==
X-Received: by 2002:a65:4507:: with SMTP id n7mr51242745pgq.180.1594276541353;
        Wed, 08 Jul 2020 23:35:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o128sm1556287pfg.127.2020.07.08.23.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 23:35:40 -0700 (PDT)
Date:   Wed, 8 Jul 2020 23:35:39 -0700
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
Message-ID: <202007082330.6B423FE@keescook>
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

Okay, I looked at hch's clean-ups again and I'm reminded why they
don't make great -stable material. :) The compat bug (also missing the
sock_update()) needs a similar fix (going back to 3.6...), so, yeah,
for ease of backport, probably an explicit sock_update() implementation
(with compat and native scm using it), and a second patch for pidfd.

Let me see what I looks best...

-- 
Kees Cook
