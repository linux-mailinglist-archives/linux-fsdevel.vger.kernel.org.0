Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CDB2194A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 01:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgGHXwW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 19:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgGHXwW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 19:52:22 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6527C061A0B
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 16:52:21 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t15so262535pjq.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 16:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fsDIuQ+QGlLJItLLTBWc5HjwT0IhAh/4/r7bcFEnnPc=;
        b=CWnwWjIAujJnrPuFiYjABbEC6jeH5sQeFt2uMF0YasTyHtuSXsGI+orYI9aYeH02E5
         YK2bZgzfqAwLDSmHnKDl1Mbjj6MMyZ7t2ySryI8bRIwOoJwRrMSxbb1IAuYiIV5YEnSK
         2ufhSjvXJnWyl9Cb6B8K7QBMuNk+8X7ikdjaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fsDIuQ+QGlLJItLLTBWc5HjwT0IhAh/4/r7bcFEnnPc=;
        b=WC9+MVa55KxGzunADPEJPPDCzG9KHWLI0PQuf1ndHfHWg3sXXuktAN6hsR2lYUx110
         3b6BWeimH+0uFhEx+3UEp8EhAhOojRjbbsQxx7UslkJzdXLkW+EgYyDETz+j4nHLOo+y
         BwevP2tgJCcokUd1I1yNmMHVjRQsoJykl9DYyL9ZcZjUnhFjTWt0/0gkpVCUpd/vg37a
         E2Qvml3NkIZ4TdgHuqRHK/zpdn/jdb09cpl7kQs3BB+2jpOGJUWhRVgz1iuGPWruvl6s
         BOqjLBEsNhFGEX6COuXpaAy3rk+9BpRNetUdcbFUAs+S9tKHcjlI16zPhatArUTjZd/X
         9l+w==
X-Gm-Message-State: AOAM533dr9794uhvqcq/Li/Z1TP2q7UpgXvsC8ilsH4+cuLYPP0B3+JG
        h4ZGt2twFlj7TATYYw7rQhNTqQ==
X-Google-Smtp-Source: ABdhPJzaUUiMh9xWXaIxrk0LMWQv1TGq8ruUqPrjGUj99WaVNBGcnuFxoRDDOcUYCmg5D8lPT5NVCg==
X-Received: by 2002:a17:90a:fd12:: with SMTP id cv18mr12554968pjb.66.1594252341309;
        Wed, 08 Jul 2020 16:52:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o2sm765839pfh.160.2020.07.08.16.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 16:52:20 -0700 (PDT)
Date:   Wed, 8 Jul 2020 16:52:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Laight <David.Laight@ACULAB.COM>,
        Christoph Hellwig <hch@lst.de>,
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
Subject: Re: [PATCH v6 5/7] fs: Expand __receive_fd() to accept existing fd
Message-ID: <202007081651.F2EBF59F2B@keescook>
References: <20200706201720.3482959-1-keescook@chromium.org>
 <20200706201720.3482959-6-keescook@chromium.org>
 <20200707123854.wi4s2kzwkhkgieyv@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707123854.wi4s2kzwkhkgieyv@wittgenstein>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 07, 2020 at 02:38:54PM +0200, Christian Brauner wrote:
> On Mon, Jul 06, 2020 at 01:17:18PM -0700, Kees Cook wrote:
> > Expand __receive_fd() with support for replace_fd() for the coming seccomp
> > "addfd" ioctl(). Add new wrapper receive_fd_replace() for the new behavior
> > and update existing wrappers to retain old behavior.
> > 
> > Thanks to Colin Ian King <colin.king@canonical.com> for pointing out an
> > uninitialized variable exposure in an earlier version of this patch.
> > 
> > Reviewed-by: Sargun Dhillon <sargun@sargun.me>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> 
> Thanks!
> (One tiny-nit below.)
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> >  fs/file.c            | 24 ++++++++++++++++++------
> >  include/linux/file.h | 10 +++++++---
> >  2 files changed, 25 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/file.c b/fs/file.c
> > index 0efdcf413210..11313ff36802 100644
> > --- a/fs/file.c
> > +++ b/fs/file.c
> > @@ -937,6 +937,7 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
> >  /**
> >   * __receive_fd() - Install received file into file descriptor table
> >   *
> > + * @fd: fd to install into (if negative, a new fd will be allocated)
> >   * @file: struct file that was received from another process
> >   * @ufd: __user pointer to write new fd number to
> >   * @o_flags: the O_* flags to apply to the new fd entry
> > @@ -950,7 +951,7 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
> >   *
> >   * Returns newly install fd or -ve on error.
> >   */
> > -int __receive_fd(struct file *file, int __user *ufd, unsigned int o_flags)
> > +int __receive_fd(int fd, struct file *file, int __user *ufd, unsigned int o_flags)
> >  {
> >  	struct socket *sock;
> >  	int new_fd;
> > @@ -960,18 +961,30 @@ int __receive_fd(struct file *file, int __user *ufd, unsigned int o_flags)
> >  	if (error)
> >  		return error;
> >  
> > -	new_fd = get_unused_fd_flags(o_flags);
> > -	if (new_fd < 0)
> > -		return new_fd;
> > +	if (fd < 0) {
> > +		new_fd = get_unused_fd_flags(o_flags);
> > +		if (new_fd < 0)
> > +			return new_fd;
> > +	} else
> > +		new_fd = fd;
> 
> This is nitpicky but coding style technically wants us to use braces
> around both branches if one of them requires them. ;)

Ah yeah, good point. Fixed. Thanks!

-- 
Kees Cook
