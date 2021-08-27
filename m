Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4BD3FA02D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 21:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhH0T5P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 15:57:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40052 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231255AbhH0T5P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 15:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630094185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sd/3n0607wJTjqztLgFnu0bOLL0OQcH0TvNvy1LbLr8=;
        b=SHj+3ue+PHmRxrG6E0hgpSIfIL42eS2WIKZcBZP5WZRHYdMmOlSe97vo+zIgNdrZFsvahA
        9PeevwDg597Iev6nPFEWVTxjGIxHehriQQye81kMgGWkyWG0CB4HFUlJeys/JwSl8+4SXi
        gLbTqqbvg6P/4mbfsQiV/HI8GM7+m+E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-Ue5EEz5cNVOVh8MH3nTYfw-1; Fri, 27 Aug 2021 15:56:24 -0400
X-MC-Unique: Ue5EEz5cNVOVh8MH3nTYfw-1
Received: by mail-wm1-f72.google.com with SMTP id c2-20020a7bc8420000b0290238db573ab7so6315583wml.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 12:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sd/3n0607wJTjqztLgFnu0bOLL0OQcH0TvNvy1LbLr8=;
        b=e+99AChdWmtgn5zAJc4sKq0Gv0096u97KrngegW7t66/CMhMIIFaIUAABBScx3VSA5
         N2GUDbwl64nao62EMlEH3Jit25KsCTsI6y2tn42gWyrQQL4P8PZiN5MVV2L+YxXIQI69
         DfD0W/domDurpngJa8wizmRObcEzIPmlFjgZuhDs1LEQbyCbnqjXARPY4SbdGA1qZU+q
         R4PCAjYgrIZdvKuluzBQHD4Zb2ZJfitJbeWXmVeXOIYMksy+CVJwHw1MoEq+os5rX1Vw
         esMWWO0C13N264Uy6kncOtIZMn+vFl8ZZNOUwHDdSIzsQq3sjsdIeXPWvtRKH9nB2Jl6
         d6HQ==
X-Gm-Message-State: AOAM5321nN5oGx9PM4gBDYMg5+n3A/xYg2unaIBDCbuXWAj++zLcM7oS
        QPCuF+gDKcdJKrJYjFOgW8NcbgfyrogIdn955H6vReLiA8VKNjLWZAUjzSPr4d3MjxvjvCihz2N
        Jjy6Lr9yVpsKRAVsSNiBpMXtqffz17fLdFY269ku4cg==
X-Received: by 2002:a5d:47a4:: with SMTP id 4mr12104531wrb.329.1630094182741;
        Fri, 27 Aug 2021 12:56:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydEhO4+TbNABovpa3HgGNECXB3WhRpPNdamPW7spcpayLjxbNmB0mkBEQta0WVv1DaGiTw07KdhCXl6aFWwBE=
X-Received: by 2002:a5d:47a4:: with SMTP id 4mr12104517wrb.329.1630094182497;
 Fri, 27 Aug 2021 12:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210827164926.1726765-1-agruenba@redhat.com> <20210827164926.1726765-19-agruenba@redhat.com>
 <YSkzSHSp8lld6dwW@zeniv-ca.linux.org.uk>
In-Reply-To: <YSkzSHSp8lld6dwW@zeniv-ca.linux.org.uk>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 27 Aug 2021 21:56:10 +0200
Message-ID: <CAHc6FU47cApVzAcVrkCLfoV7AGzs7T-cBGejVXRtfHWVdhXfxA@mail.gmail.com>
Subject: Re: [PATCH v7 18/19] iov_iter: Introduce nofault flag to disable page faults
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 8:47 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Fri, Aug 27, 2021 at 06:49:25PM +0200, Andreas Gruenbacher wrote:
> > Introduce a new nofault flag to indicate to get_user_pages to use the
> > FOLL_NOFAULT flag.  This will cause get_user_pages to fail when it
> > would otherwise fault in a page.
> >
> > Currently, the noio flag is only checked in iov_iter_get_pages and
> > iov_iter_get_pages_alloc.  This is enough for iomaop_dio_rw, but it
> > may make sense to check in other contexts as well.
>
> I can live with that, but
>         * direct assignments (as in the next patch) are fucking hard to
> grep for.  Is it intended to be "we set it for duration of primitive",
> or...?

It's for this kind of pattern:

       pagefault_disable();
       to->nofault = true;
       ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL,
                          IOMAP_DIO_PARTIAL, written);
       to->nofault = false;
       pagefault_enable();

Clearing the flag at the end isn't strictly necessary, but it kind of
documents that the flag pertains to iomap_dio_rw and not something
else.

>         * it would be nice to have a description of intended semantics
> for that thing.  This "may make sense to check in other contexts" really
> needs to be elaborated (and agreed) upon.  Details, please.

Maybe the description should just be something like:

"Introduce a new nofault flag to indicate to iov_iter_get_pages not to
fault in user pages.

This is implemented by passing the FOLL_NOFAULT flag to get_user_pages,
which causes get_user_pages to fail when it would otherwise fault in a
page. We'll use the ->nofault flag to prevent iomap_dio_rw from faulting
in pages when page faults are not allowed."

Thanks,
Andreas

