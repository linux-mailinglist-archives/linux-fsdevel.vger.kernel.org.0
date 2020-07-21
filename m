Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E1F22845A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 17:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgGUP7E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 11:59:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41034 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726919AbgGUP7D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595347141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dgPUhH0r+sKpeUc9BKumgQDPz2ogAxxmhche9Bz8CLg=;
        b=cy/CtUEZ479MMrDC2RrEHxk0Bqasvq+bsA4KNHktokhvaOeW9phYETPWa0fYRGcPKhuyAL
        Us9Syvf4Gz5syuBK0hDlQlP8fksxEeDXXfLceS44HjHLXPdRJrjWjMhXDPJ2hkS4qI2ola
        ZHxDu+mNNOcmn9cXzGABywMJjSBBF0Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-aWEHVyRYNQWLQNlbCzceHA-1; Tue, 21 Jul 2020 11:58:59 -0400
X-MC-Unique: aWEHVyRYNQWLQNlbCzceHA-1
Received: by mail-wm1-f71.google.com with SMTP id a5so79940wmj.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2020 08:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dgPUhH0r+sKpeUc9BKumgQDPz2ogAxxmhche9Bz8CLg=;
        b=aPfuq7Z/ZedR92Hf0hLq+ihX5lrUrbQI3BsameYJUcuEcK+9NGMqRf/GHk6YbnJOQC
         g2QYbj019d/E2qGGtSDT41Y+FtqEjA9HgAozkXHjy+ePKx2L7FnT6pCBznhLEwYMn5MQ
         9n+XOkgO1d7pEXN7m9JEbXO0MpbMGXx1IDjLs2jS33k0siLk/iXxnjrn0EXIsato9uVB
         3AVBIgER4j79plnC/9VCL201Rt8FHGNUvVmbK+a2Y/PtTZE0rcQM1rX2QeBQEWvhsogC
         XdG8djlsqHKnvbxEOIRf92a/ph99KnRZVSzRlY5Qkunf8kM9gY1Wsvo+V/eikimSBgRi
         /4xQ==
X-Gm-Message-State: AOAM531soe8AzGTMuISblqwYxDat1VZoTpjz0d6fBM8F8TDQeRTWe5F3
        R49COQFaA5dhiax8QplDEy4gGmpAr+DbSAPNK0sL22CXe+q7nX5A0IRTGpcSQk8PfzHQhTuwlNE
        38hqPjtX+ZPGE70mkUrnjF33h+w==
X-Received: by 2002:a1c:bc8a:: with SMTP id m132mr4446938wmf.1.1595347138038;
        Tue, 21 Jul 2020 08:58:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwyau1D8Vflmll5c/lpT+mSNiQWL/z4fvqThThRxPJq+0YehBisCCUrYwQJ2sj2QZLWN0sYg==
X-Received: by 2002:a1c:bc8a:: with SMTP id m132mr4446919wmf.1.1595347137664;
        Tue, 21 Jul 2020 08:58:57 -0700 (PDT)
Received: from steredhat ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id u2sm3741424wml.16.2020.07.21.08.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 08:58:56 -0700 (PDT)
Date:   Tue, 21 Jul 2020 17:58:48 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        strace-devel@lists.strace.io, io-uring@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: strace of io_uring events?
Message-ID: <20200721155848.32xtze5ntvcmjv63@steredhat>
References: <D9FAB37B-D059-4137-A115-616237D78640@amacapital.net>
 <20200715171130.GG12769@casper.infradead.org>
 <7c09f6af-653f-db3f-2378-02dca2bc07f7@gmail.com>
 <CAJfpegt9=p4uo5U2GXqc-rwqOESzZCWAkGMRTY1r8H6fuXx96g@mail.gmail.com>
 <48cc7eea-5b28-a584-a66c-4eed3fac5e76@gmail.com>
 <202007151511.2AA7718@keescook>
 <20200716131404.bnzsaarooumrp3kx@steredhat>
 <202007160751.ED56C55@keescook>
 <20200717080157.ezxapv7pscbqykhl@steredhat.lan>
 <CALCETrXSPdiVCgh3h=q7w9RyiKnp-=8jOHoFHX=an0cWqK7bzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXSPdiVCgh3h=q7w9RyiKnp-=8jOHoFHX=an0cWqK7bzQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 08:27:34AM -0700, Andy Lutomirski wrote:
> On Fri, Jul 17, 2020 at 1:02 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >
> > On Thu, Jul 16, 2020 at 08:12:35AM -0700, Kees Cook wrote:
> > > On Thu, Jul 16, 2020 at 03:14:04PM +0200, Stefano Garzarella wrote:
> 
> > > access (IIUC) is possible without actually calling any of the io_uring
> > > syscalls. Is that correct? A process would receive an fd (via SCM_RIGHTS,
> > > pidfd_getfd, or soon seccomp addfd), and then call mmap() on it to gain
> > > access to the SQ and CQ, and off it goes? (The only glitch I see is
> > > waking up the worker thread?)
> >
> > It is true only if the io_uring istance is created with SQPOLL flag (not the
> > default behaviour and it requires CAP_SYS_ADMIN). In this case the
> > kthread is created and you can also set an higher idle time for it, so
> > also the waking up syscall can be avoided.
> 
> I stared at the io_uring code for a while, and I'm wondering if we're
> approaching this the wrong way. It seems to me that most of the
> complications here come from the fact that io_uring SQEs don't clearly
> belong to any particular security principle.  (We have struct creds,
> but we don't really have a task or mm.)  But I'm also not convinced
> that io_uring actually supports cross-mm submission except by accident
> -- as it stands, unless a user is very careful to only submit SQEs
> that don't use user pointers, the results will be unpredictable.
> Perhaps we can get away with this:
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 74bc4a04befa..92266f869174 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -7660,6 +7660,20 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int,
> fd, u32, to_submit,
>      if (!percpu_ref_tryget(&ctx->refs))
>          goto out_fput;
> 
> +    if (unlikely(current->mm != ctx->sqo_mm)) {
> +        /*
> +         * The mm used to process SQEs will be current->mm or
> +         * ctx->sqo_mm depending on which submission path is used.
> +         * It's also unclear who is responsible for an SQE submitted
> +         * out-of-process from a security and auditing perspective.
> +         *
> +         * Until a real usecase emerges and there are clear semantics
> +         * for out-of-process submission, disallow it.
> +         */
> +        ret = -EACCES;
> +        goto out;
> +    }
> +
>      /*
>       * For SQ polling, the thread will do all submissions and completions.
>       * Just return the requested submit count, and wake the thread if
> 
> If we can do that, then we could bind seccomp-like io_uring filters to
> an mm, and we get obvious semantics that ought to cover most of the
> bases.
> 
> Jens, Christoph?
> 
> Stefano, what's your intended usecase for your restriction patchset?
> 

Hi Andy,
my use case concerns virtualization. The idea, that I described in the
proposal of io-uring restrictions [1], is to share io_uring CQ and SQ queues
with a guest VM for block operations.

In the PoC that I realized, there is a block device driver in the guest that
uses io_uring queues coming from the host to submit block requests.

Since the guest is not trusted, we need restrictions to allow only
a subset of syscalls on a subset of file descriptors and memory.


Cheers,
Stefano

[1] https://lore.kernel.org/io-uring/20200609142406.upuwpfmgqjeji4lc@steredhat/

