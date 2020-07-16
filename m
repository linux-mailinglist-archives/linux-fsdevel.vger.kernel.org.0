Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727C32226BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 17:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgGPPTk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 11:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbgGPPTj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:19:39 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090BCC061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 08:19:37 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x9so4016213plr.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 08:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HozkydmQpUvKd5NOCtzfpodg8BolrSSLpRppwaD1xMw=;
        b=fjQCXssPxi4AjoXO4i5b2uodaOc83MJhnRTmtQeSd8KG0GnTJh8pMVwicp08Mg6cV/
         PM2aJ65QS5F9K4jur1fgGCr2XAUDR56tq8TRLnpoC5h6PjiDp4gPPzzBFOBoChUYqju8
         Nm0X11EpEfvlUee3IBx6hBV3SOZiV4gWiaPHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HozkydmQpUvKd5NOCtzfpodg8BolrSSLpRppwaD1xMw=;
        b=qXV2oCoJhPuw+M2Gl20H1tS/QL/UCA65aXhM9woN/Y5ZCPc1rDAA45xPvxf7jz0X2G
         ePYVePtuq5pSmd+8xt1a6sD29R0nsiO34xLqFLsX5b5WuaVtSmFFEtwdrcDWq5jdLfh6
         AnK10j8mDtaeCCMkn1PFM1PF26f80Rp5PPsCh5/4ZgZkBCh4u0Mr6AI3VEZyuvyeXrgk
         op6l5qQRKi0fLg7X6yL5GWjGINPhmtmfu/q70bEzn7VDwI5Nr50pQL5lzFKEY2p6LaAX
         51v44DfnKjc7KD6cUTKUJ/rkPlKtx5m+aFyOmqehCHL0KwLT0iNFnMpyDGpwDs2HO1P7
         mjSQ==
X-Gm-Message-State: AOAM533lCLNJggDjH8KpsQFnI4AT/d54YevrplbUqdZdzMAJJefMZq3S
        odw0zgse48KZbVSDnDKs++HnXA==
X-Google-Smtp-Source: ABdhPJx1Qzrb9/OmTn8DkAEQY+LMixE4pooCV6vy4o7tTITmHOHavW7fFOZs81EuNnKruvEtLAHwkQ==
X-Received: by 2002:a17:902:bb83:: with SMTP id m3mr3611207pls.209.1594912776507;
        Thu, 16 Jul 2020 08:19:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m20sm4225468pgn.62.2020.07.16.08.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 08:19:35 -0700 (PDT)
Date:   Thu, 16 Jul 2020 08:19:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        strace-devel@lists.strace.io, io-uring@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: strace of io_uring events?
Message-ID: <202007160812.A8D43ABBBE@keescook>
References: <CAJfpegu3EwbBFTSJiPhm7eMyTK2MzijLUp1gcboOo3meMF_+Qg@mail.gmail.com>
 <D9FAB37B-D059-4137-A115-616237D78640@amacapital.net>
 <20200715171130.GG12769@casper.infradead.org>
 <7c09f6af-653f-db3f-2378-02dca2bc07f7@gmail.com>
 <CAJfpegt9=p4uo5U2GXqc-rwqOESzZCWAkGMRTY1r8H6fuXx96g@mail.gmail.com>
 <48cc7eea-5b28-a584-a66c-4eed3fac5e76@gmail.com>
 <202007151511.2AA7718@keescook>
 <20200716131755.l5tsyhupimpinlfi@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716131755.l5tsyhupimpinlfi@yavin.dot.cyphar.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 11:17:55PM +1000, Aleksa Sarai wrote:
> On 2020-07-15, Kees Cook <keescook@chromium.org> wrote:
> > In the basic case of "I want to run strace", this is really just a
> > creative use of ptrace in that interception is being used only for
> > reporting. Does ptrace need to grow a way to create/attach an io_uring
> > eventfd? Or should there be an entirely different tool for
> > administrative analysis of io_uring events (kind of how disk IO can be
> > monitored)?
> 
> I would hope that we wouldn't introduce ptrace to io_uring, because
> unless we plan to attach to io_uring events via GDB it's simply the
> wrong tool for the job. strace does use ptrace, but that's mostly
> because Linux's dynamic tracing was still in its infancy at the time
> (and even today it requires more privileges than ptrace) -- but you can
> emulate strace using bpftrace these days fairly easily.
> 
> So really what is being asked here is "can we make it possible to debug
> io_uring programs as easily as traditional I/O programs". And this does
> not require ptrace, nor should ptrace be part of this discussion IMHO. I
> believe this issue (along with seccomp-style filtering) have been
> mentioned informally in the past, but I am happy to finally see a thread
> about this appear.

Yeah, I don't see any sane way to attach ptrace, especially when what's
wanted is just "io_uring action logging", which is a much more narrow
issue, and one that doesn't map well to processes.

Can the io_uring eventfd be used for this kind of thing? It seems
io_uring just needs a way to gain an administrative path to opening it?

> > Solving the mapping of seccomp interception types into CQEs (or anything
> > more severe) will likely inform what it would mean to map ptrace events
> > to CQEs. So, I think they're related, and we should get seccomp hooked
> > up right away, and that might help us see how (if) ptrace should be
> > attached.
> 
> We could just emulate the seccomp-bpf API with the pseudo-syscalls done
> as a result of CQEs, though I'm not sure how happy folks will be with
> this kind of glue code in "seccomp-uring" (though in theory it would
> allow us to attach existing filters to io_uring...).

Looking at the per-OP "syscall" implementations, I'm kind of alarmed
that some (e.g. openat2) are rather "open coded". It seems like this
should be fixed to have at least a common entry point for both io_uring
and proper syscalls.

-- 
Kees Cook
