Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE4E29C16D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 18:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762974AbgJ0Owa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 10:52:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1773166AbgJ0Ovk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:51:40 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68AC822283;
        Tue, 27 Oct 2020 14:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603810300;
        bh=OA2ldPIleffPYegNQylopB0nJONj8X8WAZksjt9aE9Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bhAIQhAHEkustLbXb5xSzOPIKfcIV4FN/8NxRDqJ+bZmT6F2fWqyV8GBNEMhPfDs1
         D5Cx7ZA1ZjtW4QdfY+DM1jIW/9Tr/8rgHEG9zaRYt5nQICsXKPp9a6bdKvbFPhZMJU
         +gTDswUb95kfFwOeLwtsNw7UPqDrk55wNNX9OPcY=
Received: by mail-qv1-f45.google.com with SMTP id s17so756003qvr.11;
        Tue, 27 Oct 2020 07:51:40 -0700 (PDT)
X-Gm-Message-State: AOAM53376I3WeTMMode6X82NIxKUgwjmP8ADj9xLkaJvA2ts7aJqVzCo
        Y308bEFsZiVM47M8V3i2RBEFt6npfqmwr0xri1A=
X-Google-Smtp-Source: ABdhPJxKs0hJCrdJK3jD6B/5m6V13LO5XvTLyQPwksTqoeN3Qq2cwOYkpuosPKW/VoW2FFqoXPh1ms2bEeDeTGKiy2A=
X-Received: by 2002:ad4:4203:: with SMTP id k3mr2717093qvp.8.1603810299401;
 Tue, 27 Oct 2020 07:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201026215321.3894419-1-arnd@kernel.org> <20201027104450.GA8864@infradead.org>
In-Reply-To: <20201027104450.GA8864@infradead.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 27 Oct 2020 15:51:22 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0irGzw8YDdV9HoaaiPOfgzWQ6hxgbC6_dx=4E8vGKXXA@mail.gmail.com>
Message-ID: <CAK8P3a0irGzw8YDdV9HoaaiPOfgzWQ6hxgbC6_dx=4E8vGKXXA@mail.gmail.com>
Subject: Re: [PATCH] seq_file: fix clang warning for NULL pointer arithmetic
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 27, 2020 at 11:45 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> > index f277d023ebcd..b55e6ef4d677 100644
> > --- a/fs/kernfs/file.c
> > +++ b/fs/kernfs/file.c
> > @@ -124,7 +124,7 @@ static void *kernfs_seq_start(struct seq_file *sf, loff_t *ppos)
> >                * The same behavior and code as single_open().  Returns
> >                * !NULL if pos is at the beginning; otherwise, NULL.
> >                */
> > -             return NULL + !*ppos;
> > +             return (void *)(uintptr_t)!*ppos;
>
> Yikes.  This is just horrible, why bnot the completely obvious:
>
>         if (ops->seq_start) {
>                 ...
>                 return next;
>         }
>
>         if (*ppos)
>                 return NULL;
>         return ppos; /* random cookie */

I was trying to not change the behavior, but I guess we can do better
than either the original version mine. Not sure I'd call your version
'obvious' either though, at least it was immediately clear to me that
returning an unrelated pointer here is the right thing to do (it works,
since it is guaranteed to be neither NULL nor an error pointer
and it is never dereferenced, but it's still odd).

I'd rather define something like

#define SEQ_OPEN_SINGLE (void *)1ul

and return that here. I'll send a patch doing that, let me know what
you think.

     Arnd
