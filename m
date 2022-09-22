Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742C75E5CE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 10:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiIVIHB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 04:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiIVIG7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:06:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA34357887
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 01:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663834018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pHr+sUoZhWdymypsiTp2FQq360Zlx7QElvgdZDiTvnQ=;
        b=KMd4dtWgO4hIWHAHmqVFo0bTBSH2NPC4fnIKtt3QjgByzbtGiqkx0S9TfJRH0dlIItAwC2
        7TlKwuNXJtiuu5GxS30sdbiidfqm0Au/zYK3ulbFEF0uzaz7pxvrFkaZN7cvrEWqQjBrwo
        dBi6E7Am4exP7InVa2OpIhWdUPbF/5U=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-125-g5EEsEAwMpukihJW_plfYA-1; Thu, 22 Sep 2022 04:06:56 -0400
X-MC-Unique: g5EEsEAwMpukihJW_plfYA-1
Received: by mail-oo1-f69.google.com with SMTP id a21-20020a4ad1d5000000b004757a8a97ddso3779443oos.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 01:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pHr+sUoZhWdymypsiTp2FQq360Zlx7QElvgdZDiTvnQ=;
        b=Irt7fqgjlY8L7aIKW94kDCfT9iS3/mMFMHILHRXGZuAUakChOPIXqU+1xfI/o2wyf7
         kU56pmW4zx2UmQd12taLXuBlXe/aahygFg9t0UuZlp7ZvBWl+cYaFjNROYxxfni5KDBj
         wfn5sV2Ml7l8WsHtjh/mytH5M9y/Q+wyYksIVaBcyU4vIeO4oDDVdFAj1+dVbfQLEaWD
         4BKW/d0j6wm5dkxDjQhvhM5OkFpMIsAa0mfU9NpskU4DRYQhsoap0DjUl0zaTmW6dg6j
         UeD3RM9jgZAVcL36mcATWS8q7M51S4ljXzgYviSWsAXCMI9n9XE5XTGvsWv7Jbrbl1s+
         ZaxA==
X-Gm-Message-State: ACrzQf21pA2xWX4djcEiZxaRnQF5y/GK7GvXuThJC25fyNVxGe03kPA4
        lm60ECSN3UepExW31kKkSa7yU2ASTlU2ZLbMho8XOEmhA7AaviSVR69hdKbUhwgjNLUQEwucyDz
        h4Y3F5x3F1TaPV4FsUGcFtgBPh2i9dEjYNCV7RXaYMA==
X-Received: by 2002:a05:6870:2381:b0:12c:8a51:47c6 with SMTP id e1-20020a056870238100b0012c8a5147c6mr7179602oap.12.1663834016040;
        Thu, 22 Sep 2022 01:06:56 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4k3liMFFELJr1cbQnSgK14GeWOGUce/ft51vb/2ZDVcWI9xUC4sIjTs1Axy8pMTceIaDhIW+51EGMDEIkj+Iw=
X-Received: by 2002:a05:6870:2381:b0:12c:8a51:47c6 with SMTP id
 e1-20020a056870238100b0012c8a5147c6mr7179550oap.12.1663834015475; Thu, 22 Sep
 2022 01:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220921091010.1309093-1-alexl@redhat.com> <YytG4sTn5OF44mXH@ZenIV>
In-Reply-To: <YytG4sTn5OF44mXH@ZenIV>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Thu, 22 Sep 2022 10:06:44 +0200
Message-ID: <CAL7ro1HdgAnFrNBwO+Zec-828y1DH3x2D64rY4r_qkP9dwVeeQ@mail.gmail.com>
Subject: Re: [PATCH] filemap: Fix error propagation in do_read_cache_page()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     willy@infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 21, 2022 at 7:32 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Sep 21, 2022 at 11:10:10AM +0200, Alexander Larsson wrote:
> > When do_read_cache_folio() returns an error pointer the code
> > was dereferencing it rather than forwarding the error via
> > ERR_CAST().
> >
> > Found during code review.
> >
> > Fixes: 539a3322f208 ("filemap: Add read_cache_folio and read_mapping_folio")
> > Signed-off-by: Alexander Larsson <alexl@redhat.com>
> > ---
> >  mm/filemap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 15800334147b..6bc55506f7a8 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -3560,7 +3560,7 @@ static struct page *do_read_cache_page(struct address_space *mapping,
> >
> >       folio = do_read_cache_folio(mapping, index, filler, file, gfp);
> >       if (IS_ERR(folio))
> > -             return &folio->page;
> > +             return ERR_CAST(folio);
>
> Where do you see a dereference?  I agree that your variant is cleaner,
> but &folio->page does *NOT* dereference anything - it's an equivalent of
>
>         (struct page *)((unsigned long)folio + offsetof(struct folio, page))
>
> and the reason it happens to work is that page is the first member in
> struct folio, so the offsetof ends up being 0 and we are left with a cast
> from struct folio * to struct page *, i.e. the same thing ERR_CAST()
> variant end up with (it casts to void *, which is converted to struct
> page * since return acts as assignment wrt type conversions).
>
> It *is* brittle and misguiding, and your patch is a much more clear
> way to spell that thing, no arguments about it; just that your patch
> is not changing behaviour.

Yeah, it doesn't actually dereference, but what I was thinking is that
the caller could dereference it, if the addition made it not an error.
However, I didn't look at the actual offset of page in folio, so
you're right, this is actually fine.

Still, better change this to avoid confusing people.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

