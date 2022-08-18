Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AAE598840
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 18:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344241AbiHRQDb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 12:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343597AbiHRQDZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:03:25 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7385F2713
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 09:03:23 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id v4so1612283pgi.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 09:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=tv5ULlLKxM0cuyQ6J1iQhNfNqwRvi2Mu8C1ughJ0TDs=;
        b=E8jwzzSWkQZjYK0CTe9AbY7M6bB8NxxJIz7ILJ36UNVCbM0Ka4LYZT8J1DGl3bqPX0
         QYiBjYNWgQVin49A+zu6WhOjtftpm78q+i3lZxR2f8g79FNVN782BBPffwkFDM5Qhce6
         Rg/+3iDQr9tXHcDn/L45hCa9B+zu+rRP+330c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=tv5ULlLKxM0cuyQ6J1iQhNfNqwRvi2Mu8C1ughJ0TDs=;
        b=Ggmeuno+97QfU75/klTTPHDSr/uAyaZoWSPCzV9PNvQyrulo5otiifsasx4FIV17A4
         3KyhVsN54wE+vsVVu99znOj5rSkv64UY+vlcfpkP6i+PHLz3d+Q5hMyUHST5H8Fsw6Kq
         Nl5Zey05DHwEzby5fEFxdQ9dEBTnhNLjHzKjSSLleQh/99pImvvL+BUZFrVHuZt7y5fp
         bQe8v9E8jVRSpzAvYZDKA/8n4fqW5uROwQDqgMLlgNT1nM1pWTPTDjlMVIa6je7d8fY4
         FdZ5/jBus4piV0nxgKb59BW4T7Qp+/UsflwKeGxQmaQs9Gl5JaUKu9AyIuTzuUp5MM/e
         Qx5w==
X-Gm-Message-State: ACgBeo1UO00Yj9tz2ntNoAG/b9nCkPDRfDTpn958HoMkeNKgXCSqMtlS
        OzKWhGV5fRqR/jTvjYmVat/zaw==
X-Google-Smtp-Source: AA6agR6I5By68BlJBuyT8Qm/ntSjcqHInGgvxgMFjK+rM4WhYuZnlmgsqf6IjXF03Hs9zZoNkbKTWw==
X-Received: by 2002:a63:231a:0:b0:429:fb01:3c5d with SMTP id j26-20020a63231a000000b00429fb013c5dmr2790011pgj.583.1660838602898;
        Thu, 18 Aug 2022 09:03:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l21-20020a17090ac59500b001f1ea1152aasm1630436pjt.57.2022.08.18.09.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 09:03:22 -0700 (PDT)
Date:   Thu, 18 Aug 2022 09:03:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Konstantin Shelekhin <k.shelekhin@yadro.com>
Cc:     ojeda@kernel.org, boqun.feng@gmail.com, gregkh@linuxfoundation.org,
        jarkko@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH v9 01/27] kallsyms: use `sizeof` instead of hardcoded size
Message-ID: <202208180902.48391E94@keescook>
References: <20220805154231.31257-2-ojeda@kernel.org>
 <Yu2cYShT1h8gquW8@yadro.com>
 <202208171235.52D14C2A@keescook>
 <Yv4AaeUToxSJZK/v@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv4AaeUToxSJZK/v@yadro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 18, 2022 at 12:03:37PM +0300, Konstantin Shelekhin wrote:
> On Wed, Aug 17, 2022 at 12:36:33PM -0700, Kees Cook wrote:
> > On Sat, Aug 06, 2022 at 01:40:33AM +0300, Konstantin Shelekhin wrote:
> > > > diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> > > > index f18e6dfc68c5..52f5488c61bc 100644
> > > > --- a/scripts/kallsyms.c
> > > > +++ b/scripts/kallsyms.c
> > > > @@ -206,7 +206,7 @@ static struct sym_entry *read_symbol(FILE *in)
> > > >
> > > >     rc = fscanf(in, "%llx %c %499s\n", &addr, &type, name);
> > > >     if (rc != 3) {
> > > > -           if (rc != EOF && fgets(name, 500, in) == NULL)
> > > > +           if (rc != EOF && fgets(name, sizeof(name), in) == NULL)
> > > >                     fprintf(stderr, "Read error or end of file.\n");
> > > >             return NULL;
> > > >     }
> > >
> > > Might be another nit, but IMO it's better to use ARRAY_SIZE() here.
> > 
> > I'm not sure I see a benefit for char arrays. It'll produce the same
> > result, and the tradition for string functions is to use sizeof().
> > *shrug*
> 
> ARRAY_SIZE() (though not this one) can catch this:
> 
>   - char array[16];
>   + char *array;
> 
> Saves me some.

Oh, that's an excellent point; I forgot it'll actually compile-time
error if the var is a pointer. +1

-- 
Kees Cook
