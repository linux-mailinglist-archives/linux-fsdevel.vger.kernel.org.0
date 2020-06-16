Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAC01FA862
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 07:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgFPFsc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 01:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbgFPFsb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 01:48:31 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E22C08C5C2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 22:48:30 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k1so7792344pls.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 22:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jVMXkZReclJfWUwDhO52OxqMkCMrLsR1BufGDz+LRJA=;
        b=Y/jZuYROCnWNy8yDQHa+xLPbEzmyWOXuXUaMIuKQWlxvItI97MmpLAsjOOy1PPsiNo
         UoQgUVJa0T9FqYKoIq8imZeyd9/P/AV+w9Bu0no0JPgG3uHnW3lsDYs4HkS6FcpyekXs
         MYT2cRX/qQMeXm+aj7sGNPaDaiCg0FqY7U+CU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jVMXkZReclJfWUwDhO52OxqMkCMrLsR1BufGDz+LRJA=;
        b=Sd0aQ+P9gx9Ova1AxG4F3UTbZnkzDtn6aXDld2+U5bADA63pvHk8g34kyGzkg3YNXi
         /L4OYq8acul8QSLxTZR54uhOJ9htC7RUs/Q6Q+UCAalXGeAa6G1T5ceQIv/mTUKDeBJ2
         Uglikob9CTfSgNHb/DJEdSq8yTez0FgBjw9VGsd47qESAVMXofhfFacLPQQm+EguVPs9
         /aDl/RTmYXB0tOnQLTHuIf4GZwAoTC3qr9X0QjBfH/YWjGEBykZ5b148kmu3vMQsnx5a
         KLrwlpAE/9Pc63zgDuDyNw54GGqZPle/szFjY8roWtnvpkrKJ2CuwvQ5sJ1ZpnewPdhF
         VoKw==
X-Gm-Message-State: AOAM533gFzxFGf/+EonrjpdAU1PjFPO9fAIcIsq2OhlbWcQXMqTzds/X
        l5s0UrGqLa3HWtG88UnOrjsJRw==
X-Google-Smtp-Source: ABdhPJwvdozFAN2lhTlC6N/9QoMVTVKeh5sLC4qkatRF9AL2i35/dwbVQtpPyfyBZoDbRV++yi3yIA==
X-Received: by 2002:a17:902:7611:: with SMTP id k17mr690817pll.255.1592286510152;
        Mon, 15 Jun 2020 22:48:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m9sm15615291pfo.200.2020.06.15.22.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 22:48:29 -0700 (PDT)
Date:   Mon, 15 Jun 2020 22:48:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>,
        Tycho Andersen <tycho@tycho.ws>,
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
Subject: Re: [PATCH v4 02/11] fs: Move __scm_install_fd() to
 __fd_install_received()
Message-ID: <202006152247.17A6A1EAF7@keescook>
References: <20200616032524.460144-1-keescook@chromium.org>
 <20200616032524.460144-3-keescook@chromium.org>
 <20200616052941.GB16032@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616052941.GB16032@ircssh-2.c.rugged-nimbus-611.internal>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 16, 2020 at 05:29:41AM +0000, Sargun Dhillon wrote:
> On Mon, Jun 15, 2020 at 08:25:15PM -0700, Kees Cook wrote:
> > +/**
> > + * __fd_install_received() - Install received file into file descriptor table
> > + *
> > + * @fd: fd to install into (if negative, a new fd will be allocated)
> > + * @file: struct file that was received from another process
> > + * @ufd_required: true to use @ufd for writing fd number to userspace
> > + * @ufd: __user pointer to write new fd number to
> > + * @o_flags: the O_* flags to apply to the new fd entry
> Probably doesn't matter, but this function doesn't take the fd, or ufd_required
> argument in this patch. 
> 
> > + *
> > + * Installs a received file into the file descriptor table, with appropriate
> > + * checks and count updates. Optionally writes the fd number to userspace.
> ufd does not apppear options here.

Argh, yes, thanks. I think this was a fixup targeting the wrong commit.
I will adjust.

-- 
Kees Cook
