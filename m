Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E9B29C957
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 21:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1830606AbgJ0UAU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 16:00:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1823131AbgJ0UAT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 16:00:19 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 094C422275;
        Tue, 27 Oct 2020 20:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603828818;
        bh=C8PNoOCxuRcL/lFBVvomssyBtYmkskLNwoLcNzkR5Vs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cr5dQW59BNWBgEYpuBUIA3s72exOWsAd2OlWLReIcgzgSLrsfzxKE6zRunMVogLSo
         LmLWxc91RWzKoB9Gtxr0K+7VZgOkVaEb1SX9mezXGBUD14dcZV5hoSGvg08ZXdRTIi
         Q2GtouUNf8HeaT0ihrJwnCWe294AqcVTE17F6Ukc=
Received: by mail-qt1-f174.google.com with SMTP id s39so1505434qtb.2;
        Tue, 27 Oct 2020 13:00:17 -0700 (PDT)
X-Gm-Message-State: AOAM5306FoGTk+eVqcHBkhvSwb+lUjyJXsQI3cjrAsjjWCCZm9UrtGHk
        B84bs5//iXhzsNL5UBwnihycIhwz/jUlTauMn04=
X-Google-Smtp-Source: ABdhPJzHE+3FGUR6Vtj4ilGlCmvzRyNA4JBb/mYGM6PUyhS1g31Nk7geVbcH3sKFxz1efLAyb/D51bCAVaCcEQFLiYw=
X-Received: by 2002:ac8:4808:: with SMTP id g8mr3798666qtq.18.1603828817040;
 Tue, 27 Oct 2020 13:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201027145252.3976138-1-arnd@kernel.org> <20201027192229.GA22829@infradead.org>
In-Reply-To: <20201027192229.GA22829@infradead.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 27 Oct 2020 21:00:00 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1V5aaEw213rNecYxhDB3s9Lrhbm=ueBPPXbW4Bua0n6A@mail.gmail.com>
Message-ID: <CAK8P3a1V5aaEw213rNecYxhDB3s9Lrhbm=ueBPPXbW4Bua0n6A@mail.gmail.com>
Subject: Re: [PATCH v2] seq_file: fix clang warning for NULL pointer arithmetic
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 27, 2020 at 8:22 PM Christoph Hellwig <hch@infradead.org> wrote:
> > diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> > index f277d023ebcd..eafeb8bf4fe4 100644
> > --- a/fs/kernfs/file.c
> > +++ b/fs/kernfs/file.c
> > @@ -121,10 +121,10 @@ static void *kernfs_seq_start(struct seq_file *sf, loff_t *ppos)
> >               return next;
> >       } else {
> >               /*
> > -              * The same behavior and code as single_open().  Returns
> > -              * !NULL if pos is at the beginning; otherwise, NULL.
> > +              * The same behavior and code as single_open().  Continues
> > +              * if pos is at the beginning; otherwise, EOF.
> >                */
> > -             return NULL + !*ppos;
> > +             return *ppos ? SEQ_OPEN_SINGLE : SEQ_OPEN_EOF;
>
> Why the somewhat obsfucating unary expression instead of a good
> old if?
>
> e.g.
>
>                 return next;
>         }
>         if (*ppos)
>                 retun SEQ_OPEN_SINGLE;
>         return NULL;
>
>
> >               ++*ppos;
> > -             return NULL;
> > +             return SEQ_OPEN_EOF;
>
> I don't think SEQ_OPEN_EOF is all that useful.  NULL is the documented
> end case already.

Right, Al already pointed out the same thing on IRC.

> > diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
> > index 813614d4b71f..26f0758b6551 100644
> > --- a/include/linux/seq_file.h
> > +++ b/include/linux/seq_file.h
> > @@ -37,6 +37,9 @@ struct seq_operations {
> >
> >  #define SEQ_SKIP 1
> >
> > +#define SEQ_OPEN_EOF (void *)0
> > +#define SEQ_OPEN_SINGLE      (void *)1
>
> I think SEQ_OPEN_SINGLE also wants a comment documenting it.
> AFAICS the reason for it is that ->start needs to return something
> non-NULL for the seq_file code to make progress, and there is nothing
> better for the single_open case.

Ok.

     Arnd
