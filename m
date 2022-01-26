Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE51049D336
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 21:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiAZUNS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 15:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiAZUNS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 15:13:18 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EBCC06173B
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 12:13:18 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id h14so610803plf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 12:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wj7KZuqwaOnmEdiVWVR69LpJrxWukw8SVQkUC4MLo7s=;
        b=JIYMQZEueLmr/Bcu+0hn3GJkYnsMrkdWIxCMlEUBwg4HvJdd/pwwuuoFtclMne7x5f
         mBVWpQjR6YOrZexhCa/idsq6RSWlTK3VUS8Gft1RQQprU/wPVUmHmVKlGriHabfjGlyZ
         RSlRONtD2MuECMp9iPdBrJw00YjCmXqbC1UPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wj7KZuqwaOnmEdiVWVR69LpJrxWukw8SVQkUC4MLo7s=;
        b=3+je2wuSNXgQ4dQMh2nBlOtG5Ko0o/g3zEKd6fmOW3/Gv8/ClLUoY6ZjI2iXKF/VxK
         2B27RTdTwx/QcdaB0Qysqj8a9PDrvhqtOulx38K+tLXx8gPe3U7SEP7l4VjFLPG8nBqK
         HT+rxvjRY25yCZZYcXmraOerP2HD6NKsCi1R5iACieeOJ0LFJ+4vnZQHscq8C2+gaPwP
         ziGkfFldXVPRGn71HZVCSnIoE1yHAU1HOhVcUgJfLmOjzuW7sG6S9V3YvuxsIV9nWH9u
         Qpbokr9b6ib+ERcuFBbJZp0V/tF8vedaJGo+kzlHIZVwZBLWSdPi0hiIhNW7lyca3wDR
         XejQ==
X-Gm-Message-State: AOAM53063Ftg4P41RjI0ftAz3TkOs+MEYIpvqgBt/wfS0JlvpNy9ZykP
        xo7kllBuRkf0HU/HQ1qohUGCkg==
X-Google-Smtp-Source: ABdhPJxiY1aw0y3NlidY2z5Lk8fjvBuxzocWaDNhHTsZhuIhROUDos217Gqqbv4yyE8RnXJs6shjzQ==
X-Received: by 2002:a17:902:8f8a:: with SMTP id z10mr618939plo.59.1643227997497;
        Wed, 26 Jan 2022 12:13:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d8sm3195141pfv.64.2022.01.26.12.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 12:13:17 -0800 (PST)
Date:   Wed, 26 Jan 2022 12:13:16 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jann Horn <jannh@google.com>,
        Ariadne Conill <ariadne@dereferenced.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Rich Felker <dalias@libc.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] fs/binfmt_elf: Add padding NULL when argc == 0
Message-ID: <202201261210.E0E7EB83@keescook>
References: <20220126175747.3270945-1-keescook@chromium.org>
 <CAG48ez3hN8+zNCmLVP0yU0A5op6BAS+A-rs05aiLm4RQvzzBpg@mail.gmail.com>
 <a89bb47f-677f-4ce7-fd-d3893fe0abbd@dereferenced.org>
 <CAG48ez3iEUDbM03axYSjWOSW+zt-khgzf8CfX1DHmf_6QZap6Q@mail.gmail.com>
 <202201261157.9C3D3C36@keescook>
 <YfGqLnE9wNieTsAg@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfGqLnE9wNieTsAg@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 26, 2022 at 08:08:14PM +0000, Matthew Wilcox wrote:
> On Wed, Jan 26, 2022 at 11:58:39AM -0800, Kees Cook wrote:
> > We can't mutate argc; it'll turn at least some userspace into an
> > infinite loop:
> > https://sources.debian.org/src/valgrind/1:3.18.1-1/none/tests/execve.c/?hl=22#L22
> 
> How does that become an infinite loop?  We obviously wouldn't mutate
> argc in the caller, just the callee.

Oh, sorry, I misread. It's using /bin/true, not argv[0] (another bit of
code I found was using argv[0]). Yeah, {"", NULL} could work.

> Also, there's a version of this where we only mutate argc if we're
> executing a setuid program, which would remove the privilege
> escalation part of things.

True; though I'd like to keep the logic as non-specialized as possible.
I don't like making stuff conditional on privilege boundaries if we can
make it always happen.

-- 
Kees Cook
