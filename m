Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918F51F4869
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 22:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgFIUzt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 16:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbgFIUzr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 16:55:47 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C60C05BD1E
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2020 13:55:46 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r10so10802195pgv.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2020 13:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lNYRWXDFOIEUX1YNrkuu2evKxT3eLlEeiZYQ/REgVvc=;
        b=NUHZ0GdZs74B9irVa6slDIfz4CCekIjp6DZqLAqnreAj0h9UZUn7D5AOr3YNHyVe3s
         aQUohghlZYvlK0GoSoIYSFZFxGBx5YgCWgvrlYA6dUVYGEgAGSwOJsXrQDZxG18s2gI2
         TTnlYBEqLQoMCTwNoW1jVeo7P1Oyp3C6b5pVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lNYRWXDFOIEUX1YNrkuu2evKxT3eLlEeiZYQ/REgVvc=;
        b=m+Mr5H//RgJ3QGbRMHSsQ0L1ZZfB2Rfse9O8K2YwrypBXImCg+bZSkoztoqFqW3WiD
         WYiCih6Y35Uzl5Xu5iogCTmt8aock2UOm50d2GigzDNA4A7RooYfRrRuuzAvZot66Yni
         OqWwpSNIQA82/rzMVHpXmH6HeNB+zoJSIttk9xT0Br+A78Xm1Ob5w8vAtA13Ezui3ETJ
         MRytcFXYfWBDz5/Dkra+iDw6c6A6PdEZbqcQnJDi29ovS74pkSc4WFPjIq/c5uNk26/e
         gysm15MfTIrNX/PljUS3LXsxWPYbtkRpFUSinGLwvEGW6jRz5di0ImmH23NTSNH2eqCd
         9ibQ==
X-Gm-Message-State: AOAM532eFD2EXVVTjW3FPtbL4UI1TWf7XYks4JVTATEQJut85T3AhrsN
        eCS/EA4XBeu4nTqTMPo5KWpwxg==
X-Google-Smtp-Source: ABdhPJxWT5591LaNE8X/UdYoTAzsao8AEaWF3rwSS4mm8Jt3I4BLq3phZ6m/cnjY18ZEnCB3G0T7UA==
X-Received: by 2002:a62:cf01:: with SMTP id b1mr26250412pfg.84.1591736145364;
        Tue, 09 Jun 2020 13:55:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o2sm3243121pjp.53.2020.06.09.13.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 13:55:43 -0700 (PDT)
Date:   Tue, 9 Jun 2020 13:55:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>,
        Chris Palmer <palmer@google.com>, Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        containers@lists.linux-foundation.org,
        Daniel Wagner <daniel.wagner@bmw-carit.de>,
        linux-kernel@vger.kernel.org, Matt Denton <mpdenton@google.com>,
        John Fastabend <john.r.fastabend@intel.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        stable@vger.kernel.org, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 1/4] fs, net: Standardize on file_receive helper to
 move fds across processes
Message-ID: <202006091346.66B79E07@keescook>
References: <20200603011044.7972-1-sargun@sargun.me>
 <20200603011044.7972-2-sargun@sargun.me>
 <20200604012452.vh33nufblowuxfed@wittgenstein>
 <202006031845.F587F85A@keescook>
 <20200604125226.eztfrpvvuji7cbb2@wittgenstein>
 <20200605075435.GA3345@ircssh-2.c.rugged-nimbus-611.internal>
 <202006091235.930519F5B@keescook>
 <20200609200346.3fthqgfyw3bxat6l@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609200346.3fthqgfyw3bxat6l@wittgenstein>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 09, 2020 at 10:03:46PM +0200, Christian Brauner wrote:
> I'm looking at __scm_install_fd() and I wonder what specifically you
> mean by that? The put_user() seems to be placed such that the install
> occurrs only if it succeeded. Sure, it only handles a single fd but
> whatever. Userspace knows that already. Just look at systemd when a msg
> fails:
> 
> void cmsg_close_all(struct msghdr *mh) {
>         struct cmsghdr *cmsg;
> 
>         assert(mh);
> 
>         CMSG_FOREACH(cmsg, mh)
>                 if (cmsg->cmsg_level == SOL_SOCKET && cmsg->cmsg_type == SCM_RIGHTS)
>                         close_many((int*) CMSG_DATA(cmsg), (cmsg->cmsg_len - CMSG_LEN(0)) / sizeof(int));
> }
> 
> The only reasonable scenario for this whole mess I can think of is sm like (pseudo code):
> 
> fd_install_received(int fd, struct file *file)
> {
>  	sock = sock_from_file(fd, &err);
>  	if (sock) {
>  		sock_update_netprioidx(&sock->sk->sk_cgrp_data);
>  		sock_update_classid(&sock->sk->sk_cgrp_data);
>  	}
> 
> 	fd_install();
> }
> 
> error = 0;
> fdarray = malloc(fdmax);
> for (i = 0; i < fdmax; i++) {
> 	fdarray[i] = get_unused_fd_flags(o_flags);
> 	if (fdarray[i] < 0) {
> 		error = -EBADF;
> 		break;
> 	}
> 
> 	error = security_file_receive(file);
> 	if (error)
> 		break;
> 
> 	error = put_user(fd_array[i], ufd);
> 	if (error)
> 		break;
> }
> 
> for (i = 0; i < fdmax; i++) {
> 	if (error) {
> 		/* ignore errors */
> 		put_user(-EBADF, ufd); /* If this put_user() fails and the first one succeeded userspace might now close an fd it didn't intend to. */
> 		put_unused_fd(fdarray[i]);
> 	} else {
> 		fd_install_received(fdarray[i], file);
> 	}
> }

I see 4 cases of the same code pattern (get_unused_fd_flags(),
sock_update_*(), fd_install()), one of them has this difficult put_user()
in the middle, and one of them has a potential replace_fd() instead of
the get_used/fd_install. So, to me, it makes sense to have a helper that
encapsulates the common work that each of those call sites has to do,
which I keep cringing at all these suggestions that leave portions of it
outside the helper.

If it's too ugly to keep the put_user() in the helper, then we can try
what was suggested earlier, and just totally rework the failure path for
SCM_RIGHTS.

LOL. And while we were debating this, hch just went and cleaned stuff
up:

2618d530dd8b ("net/scm: cleanup scm_detach_fds")

So, um, yeah, now my proposal is actually even closer to what we already
have there. We just add the replace_fd() logic to __scm_install_fd() and
we're done with it.

-- 
Kees Cook
