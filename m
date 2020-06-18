Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93BE1FFC5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 22:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbgFRUNQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 16:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731047AbgFRUNH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:13:07 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABB8C0613ED
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 13:13:06 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id 35so2929817ple.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 13:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TXh+yh53BzWcVX/QSWd/KMGYLJEd9W2Aq0rZcysTQP4=;
        b=FsxI+GezYcq5Or+8LsyorXmnP7DpX4UiDy+yK2n1mRa4jblk1OUuhBfwLlpOjHyQqp
         C6V9+4Qv73F1H1QEepi3l+DsjRE/Yl2ZyJ+uOnEqfoaKaafcdPEUmhUCBv5W6FnPX6Jc
         GM0vUU2Qj7gRcd5fGdIsu83QlptQgL4TRyn7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TXh+yh53BzWcVX/QSWd/KMGYLJEd9W2Aq0rZcysTQP4=;
        b=XtHxr6ywwrUqgA/uAvn3GMVizGl5iDqO8WKzBXUFSgtDMC397LH4PxsRnOiLv7eDGE
         rv064SXP3QIK1+TgXZeZY6JXcrLiM6uffOOs7R/aXHVzHgJqAMl13roXyNJxEW3Blpx1
         sq+t1UEUbfQyBkXEZeBNrZWikzphAwvBgGOYvi7TKTPiSkdi3S9i6zMwG6gIEQAdkiX7
         3GBRrEuPpZ0p0fP5Iv//yNOVHnXawL3IW3XkYK1s78AMJ0zXB+yE3jvXAhjZ+VQL2qfI
         uB8HtBaVi8aQ6nDE8g0IYn+Q+3W04HFcz6IvemJMTWd7kdMarkZ/lkou+nxmLBgSUCMI
         YjHw==
X-Gm-Message-State: AOAM533xQCDjBusLNiTDfZ4uTadfHZQ0MUbHv9AVwtf1hRYJZlH5dSrC
        I2AE0YoVMoKZoX6Zhvr89YuT6w==
X-Google-Smtp-Source: ABdhPJz0/H6VhaSxaYiFoMobAEqIMKy6r+p/NJ3edVxjTSX7edMf4m0+dOSHEEOoExU9RsAPGvhS7A==
X-Received: by 2002:a17:90a:f508:: with SMTP id cs8mr71173pjb.16.1592511185631;
        Thu, 18 Jun 2020 13:13:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y136sm3759429pfg.55.2020.06.18.13.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 13:13:04 -0700 (PDT)
Date:   Thu, 18 Jun 2020 13:13:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v5 3/7] fs: Add fd_install_received() wrapper for
 __fd_install_received()
Message-ID: <202006181305.01F1B08@keescook>
References: <20200617220327.3731559-1-keescook@chromium.org>
 <20200617220327.3731559-4-keescook@chromium.org>
 <20200618054918.GB18669@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618054918.GB18669@ircssh-2.c.rugged-nimbus-611.internal>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 18, 2020 at 05:49:19AM +0000, Sargun Dhillon wrote:
> On Wed, Jun 17, 2020 at 03:03:23PM -0700, Kees Cook wrote:
> > [...]
> >  static inline int fd_install_received_user(struct file *file, int __user *ufd,
> >  					   unsigned int o_flags)
> >  {
> > +	if (ufd == NULL)
> > +		return -EFAULT;
> Isn't this *technically* a behvaiour change? Nonetheless, I think this is a much better
> approach than forcing everyone to do null checking, and avoids at least one error case
> where the kernel installs FDs for SCM_RIGHTS, and they're not actualy usable.

So, the only behavior change I see is that the order of sanity checks is
changed.

The loop in scm_detach_fds() is:


        for (i = 0; i < fdmax; i++) {
                err = __scm_install_fd(scm->fp->fp[i], cmsg_data + i, o_flags);
                if (err < 0)
                        break;
        }

Before, __scm_install_fd() does:

        error = security_file_receive(file);
        if (error)
                return error;

        new_fd = get_unused_fd_flags(o_flags);
        if (new_fd < 0)
                return new_fd;

        error = put_user(new_fd, ufd);
        if (error) {
                put_unused_fd(new_fd);
                return error;
        }
	...

After, fd_install_received_user() and __fd_install_received() does:

        if (ufd == NULL)
                return -EFAULT;
	...
        error = security_file_receive(file);
        if (error)
                return error;
	...
                new_fd = get_unused_fd_flags(o_flags);
                if (new_fd < 0)
                        return new_fd;
	...
                error = put_user(new_fd, ufd);
                if (error) {
                        put_unused_fd(new_fd);
                        return error;
                }

i.e. if a caller attempts a receive that is rejected by LSM *and*
includes a NULL userpointer destination, they will get an EFAULT now
instead of an EPERM.

I struggle to imagine a situation where this could possible matter
(both fail, neither installs files). It is only the error code that
is different. I am comfortable making this change and seeing if anyone
screams. If they do, I can restore the v4 "ufd_required" way of doing it.

> Reviewed-by: Sargun Dhillon <sargun@sargun.me>

Thanks!

-- 
Kees Cook
