Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C566D0C63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 19:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjC3RMI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 13:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjC3RMD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:12:03 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BDBCDF6
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 10:11:56 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x3so79165296edb.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 10:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680196314; x=1682788314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erUEnbVVJMF1HmZEIAcTtchq6NV91KFGuZ3XFAe5v2E=;
        b=OnzdnDjYz1Rvszepnn04pvuVK+3WrAbQVMGn5HdFt0SJcs5Q4tnPWJW0YP6C+JYiTP
         kIMUB+eOM4FnB0AAzhAGfbX9jjeoVdbkXZL3/tJJkEB+loGRp7ByEWEYWxB0N8kQeRN6
         nKsDERpmQiElUkYWbZ6C5qbkVNkWhAzphTe6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680196314; x=1682788314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=erUEnbVVJMF1HmZEIAcTtchq6NV91KFGuZ3XFAe5v2E=;
        b=PctVwIDr0671td7VXyYUWI1nWuuo2FXlnUhFlhc/lCkGhGpQRvdv9Pb7HbkqiZ4+ev
         4cXYrMaug1Nds/vKdvvImDG6hP1HQz2uhsMamzl6+NUjrd/nRqCRF1T9E/fLUAG1RZep
         LfcrAfPJnD3L92BUNwO1++xFc4NkzAstd3baJuiz1S6GDXBRIVwSyXm0SgR/2xTnodNN
         e2P5yM8dRuk5JdriocGC8Tj/Pu71fzYIDAeK4tpAbJhK9c7N+TTYzFMoFE/VIcNYnhrG
         k9us39U6b9u0N58wyDFSXOW9sfJyGozS+veoQh2Ju5+h+0CRv4xYsCJb56u4QwOAlp0w
         K94w==
X-Gm-Message-State: AAQBX9d03xNim5fp64tdqkEAQ6jskWcgDmrgiyqQ1aKl4WeW87mLxHv/
        QICFa5lBJ87YLxS/ZZcgTxk52DmvWNhYgVOanJ1JDd4R
X-Google-Smtp-Source: AKy350aiFAZVNCFbOamppH24CbfEGfa4dF26WByQfIm7fljkYYKa5Egehb99pXOvQEBWU1JX2IVZzw==
X-Received: by 2002:aa7:d44c:0:b0:502:52dd:57a2 with SMTP id q12-20020aa7d44c000000b0050252dd57a2mr8966321edr.24.1680196314310;
        Thu, 30 Mar 2023 10:11:54 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id i9-20020a50c3c9000000b005023a4b20dfsm164064edf.2.2023.03.30.10.11.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 10:11:53 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id eh3so79168827edb.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 10:11:53 -0700 (PDT)
X-Received: by 2002:a50:a6d1:0:b0:4fa:794a:c0cc with SMTP id
 f17-20020a50a6d1000000b004fa794ac0ccmr12545186edc.2.1680196313426; Thu, 30
 Mar 2023 10:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230330164702.1647898-1-axboe@kernel.dk>
In-Reply-To: <20230330164702.1647898-1-axboe@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Mar 2023 10:11:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgmGBCO9QnBhheQDOHu+6k+OGHGCjHyHm4J=snowkSupQ@mail.gmail.com>
Message-ID: <CAHk-=wgmGBCO9QnBhheQDOHu+6k+OGHGCjHyHm4J=snowkSupQ@mail.gmail.com>
Subject: Re: [PATCHSET v6b 0/11] Turn single segment imports into ITER_UBUF
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 30, 2023 at 9:47=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> Sadly, in absolute numbers, comparing read(2) and readv(2),
> the latter takes 2.11x as long in the stock kernel, and 2.01x as long
> with the patches. So while single segment is better now than before,
> it's still waaaay slower than having to copy in a single iovec. Testing
> was run with all security mitigations off.

What does the profile say? Iis it all in import_iovec() or what?

I do note that we have some completely horrid "helper" functions in
the iter paths: things like "do_iter_readv_writev()" supposedly being
a common function , but then it ends up doing some small setup and
just doing a conditional on the "type" after all, so when it isn't
inlined, you have those things that don't predict well at all.

And the iter interfaces don't have just that iterator, they have the
whole kiocb overhead too. All in the name of being generic. Most file
descriptors don't even support the simpler ".read" interface, because
they want the whole thing with IOCB_DIRECT flags etc.

So to some degree it's unfair to compare read-vs-read_iter. The latter
has all that disgusting support for O_DIRECT and friends, and testing
with /dev/null just doesn't show that part.

             Linus
