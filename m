Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7ED66F931F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 18:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjEFQfz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 May 2023 12:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEFQfy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 12:35:54 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FF018907
        for <linux-fsdevel@vger.kernel.org>; Sat,  6 May 2023 09:35:52 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50be0d835aaso5341116a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 May 2023 09:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683390951; x=1685982951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqqqXb22we8OKwm1xpjpxee+QM1A6+Xg9qamTaplXFs=;
        b=A8DCHkFWUzXdsail7vwybg9mK5VvGIri9rsoNiKAJFar9bylTKMA0jF9anL2QGpTVr
         0jXTLxUJukk8P6A/Lcr4EqDeNJ4HRX3saa+RBpJuaPRgQyFIAo3lkI0DflS27CiZKHmk
         qudhg848Dwf/Qwec/bVWOdbhVOXSafcVN9jo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683390951; x=1685982951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqqqXb22we8OKwm1xpjpxee+QM1A6+Xg9qamTaplXFs=;
        b=Az6vIIe6q6SR9+G62+/pZPIr796tO8UU+Yik3YSJsGHTIUeXcXZGCMsFkUJEOPy91A
         2IHM+du/zUloYFxB1PNOqUyueH3qq9ezhiC09ArYHVVMqbp+xAU/bKS3QaNFy5VFF8u6
         s2FJhWURxr9JY69WeNCf1JEZyvEKmBRRmDGtD08tG4zDgHJF9VPRaI+lWn1Mz3CR5MXa
         UIjqSjlRA9h8l+7BaCB/0DCU8grkQccr8ILgE/5lPBRdGUJOv+zAYDrasjJltkhMna4t
         zCXXIkeuxdg96dKgy+Y5nfha54JSsvbCgPD1fP4ylOhC0AVJpY1N3AyvqW1tb9FCaIjj
         MWSg==
X-Gm-Message-State: AC+VfDwne+vlQV9LiDZhKsdOWF9Y9Foq8TWMxHJaoPMhA+mYO9N6Hf3N
        n385yjHa9heg65kz+XAi27qgh9qXDX8LsRBDcbZVpA==
X-Google-Smtp-Source: ACHHUZ72MxnZMSbXY2TVcK/16h3X0yhZjd38bzVXseaGcBGC8tY1TVv00arJC2+cf+DbXeWKzlyFZg==
X-Received: by 2002:a17:907:70e:b0:965:6199:cf60 with SMTP id xb14-20020a170907070e00b009656199cf60mr3623979ejb.42.1683390951131;
        Sat, 06 May 2023 09:35:51 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id k1-20020a170906970100b00965b439027csm2502055ejx.195.2023.05.06.09.35.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 09:35:50 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-956ff2399b1so555845366b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 May 2023 09:35:50 -0700 (PDT)
X-Received: by 2002:a17:907:628c:b0:94f:2a13:4e01 with SMTP id
 nd12-20020a170907628c00b0094f2a134e01mr4183212ejc.74.1683390949920; Sat, 06
 May 2023 09:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230506160415.2992089-1-willy@infradead.org> <CAHk-=winrN4jsysShx0kWKVzmSMu7Pp3nz_6+aps9CP+v-qHWQ@mail.gmail.com>
In-Reply-To: <CAHk-=winrN4jsysShx0kWKVzmSMu7Pp3nz_6+aps9CP+v-qHWQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 May 2023 09:35:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=winai-5i6E1oMk7hXPfbP+SCssk5+TOLCJ3koaDrn7Bzg@mail.gmail.com>
Message-ID: <CAHk-=winai-5i6E1oMk7hXPfbP+SCssk5+TOLCJ3koaDrn7Bzg@mail.gmail.com>
Subject: Re: [PATCH] filemap: Handle error return from __filemap_get_folio()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>,
        syzbot+48011b86c8ea329af1b9@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 6, 2023 at 9:09=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Thanks, applied directly.

Actually, I take that back.

I applied it, and then I looked at the context some more, and decided
that I hated it.

It's not that the patch itself was wrong, but the whole original

        if (folio)
                folio_put(folio);

was wrong in that context, and shouldn't have been done that way.

Converting the conditional to use !IS_ERR() fixes a conversion error,
but doesn't fix the original problem with the code.

The only path that triggered that "we have no folio" was wrong to jump
to that "should I drop this folio" code sequence in the first place.

So the fix is to not use "out_retry" at all for the IS_ERR(folio) case.

Yes, yes, compilers can do jump threading, and in a perfect world
might realize that there are two consecutive tests for IS_ERR(folio)
and just do this kind of conversion automatically.

But the fact that compilers *might* fix out our code to do the right
thing doesn't mean that the code shouldn't have been written to just
have the proper error handling nesting in the first place.

And yes, the simplest fix for the "wrong test" would be to just add a
new "out_nofolio" error case after "out_retry", and use that.

However, even that seems wrong, because the return value for that path
is the wrong one.

So the "goto out_retry" was actually *doubly* wrong.

If the __filemap_get_folio(FGP_CREAT) failed, then we should not
return VM_FAULT_RETRY at all. We should return VM_FAULT_OOM, like it
does for the no-fpin case.

So the whole

                if (IS_ERR(folio)) {
                        if (fpin)
                                goto out_retry;

sequence seems to be completely wrong in several ways. It shouldn't go
to "out_retry" at all, because this is simply not a "retry" case.

And that in turn means that "out_retry" shouldn't be testing folio at
all (whether for IS_ERR() _or_ for NULL).

So i really think the proper fix is this (whitespace-damaged) patch instead=
:

    --- a/mm/filemap.c
    +++ b/mm/filemap.c
    @@ -3291,7 +3291,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
                                              vmf->gfp_mask);
                    if (IS_ERR(folio)) {
    -                       if (fpin)
    -                               goto out_retry;
                            filemap_invalidate_unlock_shared(mapping);
    +                       if (fpin)
    +                               fput(fpin);
                            return VM_FAULT_OOM;
                    }
    @@ -3379,6 +3379,5 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
             * page.
             */
    -       if (folio)
    -               folio_put(folio);
    +       folio_put(folio);
            if (mapping_locked)
                    filemap_invalidate_unlock_shared(mapping);

which fixes both problems by simply avoiding a bogus 'goto' entirely.

Hmm?

                      Linus
