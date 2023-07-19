Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1924759F18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 21:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjGST47 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 15:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjGST47 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:56:59 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA9BB3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 12:56:58 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9923833737eso11814566b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 12:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1689796616; x=1692388616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCAWdeG436mH+DfARvo16QjhMFi/Eb5+1UBeyzzjyUI=;
        b=KDf25kUkA8y5VPkkc7HrbMTq3b2TUQ9qV1Rqf5zm3CstAGUdbu1d6TNxedY+pIsa7j
         2FZ1elHv1v1po8knHje3+LiAmx8Xahh5ExqZRnI0mXGfRX7m3EFLlyAK10LkH8G1Mz8+
         NL2rNXbVT3ccaArlkF+ebJlcCMIxueJ9R+uLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689796616; x=1692388616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eCAWdeG436mH+DfARvo16QjhMFi/Eb5+1UBeyzzjyUI=;
        b=f0LiD+7/yFJ9tM9RdljznsiyEhWiCYuQqOREsLFdgSlQziDFZT5N7VRwGeKlgB6gPX
         A7Lu8qyCD8Yap+wsxkVqf86ZI+9M1K52GlBFqPNw0b377418hvEp2/ztOVImgez5lu8z
         fk3pbHXiYkgnBZYcqhKIfiK0W/vS5LeV5IduVfE9CL3Pbxsw2he4JCZJOov8+CEfEyQJ
         E25msv7B1JHO4Bo8CPSHjM2RIS/disPgs3+eGIPsxbJqfSWivVCgLUwi49QUVZDs8Tfc
         5/XaLG8b5Vs2VsxLcp0tMdfBvzPEf3v8e1WA1Szuvqyk0rHNQgeQRl1pGOhPxxInEUHS
         0yhw==
X-Gm-Message-State: ABy/qLa4bt6A3GBxUCtSo7Dj5Ai2LFkYGJvnJ7x7cI6Tgduqfi/ZR+zf
        CBWs6me5vTUl5Ndcm30iYdoF4g7hjCvV7b8gslLPjQ==
X-Google-Smtp-Source: APBJJlHY/0j9zo7xINflNaeK8tuqOdnpsiGywd4+hJhWLhzGqpSvrN0Bo9bC2obyVshWt0JU/Kz9CjVIL8pOynOaHLU=
X-Received: by 2002:a17:906:7485:b0:993:f497:adbe with SMTP id
 e5-20020a170906748500b00993f497adbemr4056662ejl.19.1689796616378; Wed, 19 Jul
 2023 12:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230629155433.4170837-1-dhowells@redhat.com> <20230629155433.4170837-2-dhowells@redhat.com>
 <CAJfpegsJuvXJDcXpo9T19Gw0tDuvyOJdv44Y2bt04MEf1JLxGg@mail.gmail.com>
 <c634a18e-9f2b-4746-bd8f-aa1d41e6ddf7@mattwhitlock.name> <CAJfpegvq4M_Go7fHiWVBBkrK6h4ChLqQTd0+EOKbRWZDcVerWA@mail.gmail.com>
 <ZLg9HbhOVnLk1ogA@casper.infradead.org>
In-Reply-To: <ZLg9HbhOVnLk1ogA@casper.infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 19 Jul 2023 21:56:44 +0200
Message-ID: <CAJfpegtYQXgAyejoYWRVkf+9y91O70jaTu+mm+3zhnGPJhKwcA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] splice: Fix corruption of spliced data after
 splice() returns
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Matt Whitlock <kernel@mattwhitlock.name>,
        David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@kvack.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 19 Jul 2023 at 21:44, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jul 19, 2023 at 09:35:33PM +0200, Miklos Szeredi wrote:
> > On Wed, 19 Jul 2023 at 19:59, Matt Whitlock <kernel@mattwhitlock.name> =
wrote:
> > >
> > > On Wednesday, 19 July 2023 06:17:51 EDT, Miklos Szeredi wrote:
> > > > On Thu, 29 Jun 2023 at 17:56, David Howells <dhowells@redhat.com> w=
rote:
> > > >>
> > > >> Splicing data from, say, a file into a pipe currently leaves the s=
ource
> > > >> pages in the pipe after splice() returns - but this means that tho=
se pages
> > > >> can be subsequently modified by shared-writable mmap(), write(),
> > > >> fallocate(), etc. before they're consumed.
> > > >
> > > > What is this trying to fix?   The above behavior is well known, so
> > > > it's not likely to be a problem.
> > >
> > > Respectfully, it's not well-known, as it's not documented. If the spl=
ice(2)
> > > man page had mentioned that pages can be mutated after they're alread=
y
> > > ostensibly at rest in the output pipe buffer, then my nightly backups
> > > wouldn't have been incurring corruption silently for many months.
> >
> > splice(2):
> >
> >        Though we talk of copying, actual copies are generally avoided.
> > The kernel does this by implementing a pipe buffer as a set  of
> > refer=E2=80=90
> >        ence-counted  pointers  to  pages  of kernel memory.  The
> > kernel creates "copies" of pages in a buffer by creating new pointers
> > (for the
> >        output buffer) referring to the pages, and increasing the
> > reference counts for the pages: only pointers are copied, not the
> > pages of the
> >        buffer.
> >
> > While not explicitly stating that the contents of the pages can change
> > after being spliced, this can easily be inferred from the above
> > semantics.
>
> So what's the API that provides the semantics of _copying_?

What's your definition of copying?

Thanks,
Miklos
