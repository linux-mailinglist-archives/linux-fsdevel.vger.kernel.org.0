Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1EB7A2D45
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 04:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbjIPCDS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 22:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238219AbjIPCC4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 22:02:56 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767F2272E
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 19:01:34 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5280ef23593so3099969a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 19:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694829693; x=1695434493; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KAndjmnR48WE2pCpGu0IjwxW3tK8pfCDH+nJM9LoF4g=;
        b=GPfrmgvZTMHp41fsvPGagI6a64l/4QFx8Ul9aIITTteeOccP2Q9xIdIFxZymzfnZCu
         PycpEIdctZGJaQsJgrAIf71/14NaibtLn/D+UjjXSyYB0KvdJAXWMN/ywsqFijiG2/5C
         C2QBw59bui1OYE3MLfu/a2Iyg75vb4wmtt6IU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694829693; x=1695434493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KAndjmnR48WE2pCpGu0IjwxW3tK8pfCDH+nJM9LoF4g=;
        b=uatjYZDf1xXkGOLwre1rCpul0oVt9eymteXXlDe1xzxtsRdIPrvn5NUTjz7gRWBhio
         C07rtjPkU/Q6w4+N01pQOr/Zoq7T2C1C+55jm55GB0MdXF9yV4IYpLedt4K82h35UPB3
         9dQg63pMwqSHV+Q1ES5ZwFJM2OLbtW3GwMPnANav6f3zIgWNAN5/xbYAUouZh2quWJ4j
         aD13NVLJET6LRYzkVeyD7zW/FCOWGluzxl95N8+QtPclS9xQCFOzVIitWNc552G816RN
         Q6+2fQyseAxcrmfVmGBBQlJKH0pF5us5pwWiHEtBmMPiFwxVgojNvtXGSiRDann7ZXpT
         pajQ==
X-Gm-Message-State: AOJu0Yxe0f+pqLTxrfrWCZsljaIHosLDmseY67C/RyoVOZ7gA66dvSi5
        xquOaiqCry2D9eIpt88dMimabLBkdiROTxZrTED2bd0K
X-Google-Smtp-Source: AGHT+IFK2/o+8z8OSWxRCbtY7NdlX8uAPNEzXW9ZGLjEdGB8OsFX9Jc0Ev0Kes3k3naSBfg+rqA82Q==
X-Received: by 2002:aa7:c3d8:0:b0:530:4b54:400b with SMTP id l24-20020aa7c3d8000000b005304b54400bmr2828865edr.16.1694829692711;
        Fri, 15 Sep 2023 19:01:32 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id g12-20020aa7c84c000000b0052ff9bae873sm2890648edt.5.2023.09.15.19.01.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 19:01:32 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-986d8332f50so359315466b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 19:01:31 -0700 (PDT)
X-Received: by 2002:a17:906:100b:b0:9a2:28dc:4168 with SMTP id
 11-20020a170906100b00b009a228dc4168mr2220828ejm.61.1694829690885; Fri, 15 Sep
 2023 19:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230915183707.2707298-1-willy@infradead.org> <20230915183707.2707298-9-willy@infradead.org>
 <CAHk-=wgBUvM7tc70AAvUw+HHOo6Q=jD4FVheFGDCjNaK3OCEGA@mail.gmail.com> <ZQT4/gA4vIa/7H6q@casper.infradead.org>
In-Reply-To: <ZQT4/gA4vIa/7H6q@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 19:01:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbj+pVGhJTcQCLhY8KZJNomWOKM=s-GZSpK_G=G4fXEA@mail.gmail.com>
Message-ID: <CAHk-=whbj+pVGhJTcQCLhY8KZJNomWOKM=s-GZSpK_G=G4fXEA@mail.gmail.com>
Subject: Re: [PATCH 08/17] alpha: Implement xor_unlock_is_negative_byte
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 15 Sept 2023 at 17:38, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Sep 15, 2023 at 05:27:17PM -0700, Linus Torvalds wrote:
> > On Fri, 15 Sept 2023 at 11:37, Matthew Wilcox (Oracle)
> > <willy@infradead.org> wrote:
> > >
> > > +       "1:     ldl_l %0,%4\n"
> > > +       "       xor %0,%3,%0\n"
> > > +       "       xor %0,%3,%2\n"
> > > +       "       stl_c %0,%1\n"
> >
> > What an odd thing to do.
> >
> > Why don't you just save the old value? That double xor looks all kinds
> > of strange, and is a data dependency for no good reason that I can
> > see.
> >
> > Why isn't this "ldl_l + mov %0,%2 + xor + stl_c" instead?
> >
> > Not that I think alpha matters, but since I was looking through the
> > series, this just made me go "Whaa?"
>
> Well, this is my first time writing Alpha assembler ;-)  I stole this
> from ATOMIC_OP_RETURN:
>
>         "1:     ldl_l %0,%1\n"                                          \
>         "       " #asm_op " %0,%3,%2\n"                                 \
>         "       " #asm_op " %0,%3,%0\n"                                 \

Note how that does "orig" assignment first (ie the '%2" destination is
the first instruction), unlike your version.

So in that ATOMIC_OP_RETURN, it does indeed do the same ALU op twice,
but there's no data dependency between the two, so they can execute in
parallel.

> but yes, mov would do the trick here.  Is it really faster than xor?

No, I think "mov src,dst" is just a pseudo-op for "or src,src,dst",
there's no actual "mov" instruction, iirc.

So it's an ALU op too.

What makes your version expensive is the data dependency, not the ALU op.

So the *odd* thing is not that you have two xor's per se, but how you
create the original value by xor'ing the value once, and then xoring
the new value with the same mask, giving you the original value back -
but with that odd data dependency so that it won't schedule in the
same cycle.

Does any of this matter? Nope. It's alpha. There's probably a handful
of machines, and it's maybe one extra cycle. It's really the oddity
that threw me.

In ATOMIC_OP_RETURN, the reason it does that op twice is simply that
it wants to return the new value. But you literally made it return the
*old* value by doing an xor twice in succession, which reverses the
bits twice.

Was that really what you intended?

               Linus
