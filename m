Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5313E718992
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 20:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjEaSsh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 14:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjEaSsf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 14:48:35 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16077132
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 11:48:34 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51478f6106cso128868a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 11:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685558912; x=1688150912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4X30oNDcGuw9SVg09/maVlh6cvqQ6J+4aW32/Zd99o=;
        b=JN5NwAwy6tGgJI9UABktNapr3ikCOFG8l39Yt9iJMRFeGTh9xfZHTa+SrVVUVGmtpe
         qunDYxEB8PuYFguPDk2mmJm0oP3X1+REOBX1c4U1S4cRCGm+B9QrhPFofyPt35QFTQh5
         SLvOUNXj+M7PZaAKVTXTZ9QrBrk1ZNUtIlO60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685558912; x=1688150912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4X30oNDcGuw9SVg09/maVlh6cvqQ6J+4aW32/Zd99o=;
        b=U4iIRQeksHlMqvLgLvIHVLIjTKCJPqYT+pEQ/PedgAp98rI0HDBj2mOIUXjQpzhJ4s
         wHceD4Q8NRU/qx4jyO1DA+ln+MGyNleleqcOrsyW5/7O3LutJwS08gz6tp4tYFXrvDbZ
         WSomxGjpkZ2M/YU711lLAO2XDcUltDp9dC1SHQUp9Rswv2xMwVDbFmIzYHxrkRkmRgZx
         dycL9vMaoeG1w2zMVlu6DPhR757RXw/U15E3f70TV+xvhl0X7SbZcQHNzNlGlQFe4Obs
         99gN3HeEJ8hrjJNKPiUJOtFQq2iVkVeSm7R4K9G1snK5towA3z/5lT2q64n1n8k0DE4f
         Cw7w==
X-Gm-Message-State: AC+VfDxMndB9qSF54or+H/YjefvGWi5eK/QaqBdiQgdsXdz8fFM1ZgGL
        dlvCwmaaiObx13dxrcuN1bJG7U+00RHoqLYhZgJ9M5RV
X-Google-Smtp-Source: ACHHUZ7i2QEdGAKDyr3/xretzfJ39D2JVnVN7rKzOeHviVrM14Nu5W5E9hJyX4GFOV7wx2dnZXzLlg==
X-Received: by 2002:a50:ed09:0:b0:50b:fb29:1d8f with SMTP id j9-20020a50ed09000000b0050bfb291d8fmr4380302eds.0.1685558912226;
        Wed, 31 May 2023 11:48:32 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id p16-20020a05640210d000b005083bc605f9sm6166931edu.72.2023.05.31.11.48.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 11:48:31 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9700219be87so1067134566b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 11:48:31 -0700 (PDT)
X-Received: by 2002:a17:907:9609:b0:947:335f:5a0d with SMTP id
 gb9-20020a170907960900b00947335f5a0dmr6616481ejc.62.1685558911012; Wed, 31
 May 2023 11:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000030b7e05f7b9ac32@google.com> <00000000000040020d05fcf58ebf@google.com>
In-Reply-To: <00000000000040020d05fcf58ebf@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 31 May 2023 14:48:14 -0400
X-Gmail-Original-Message-ID: <CAHk-=wjqv_dAd55m31fJk=6FAy1+=556L9y8eAOB92RstWy6_Q@mail.gmail.com>
Message-ID: <CAHk-=wjqv_dAd55m31fJk=6FAy1+=556L9y8eAOB92RstWy6_Q@mail.gmail.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in attr_data_get_block (2)
To:     syzbot <syzbot+a98f21ebda0a437b04d7@syzkaller.appspotmail.com>
Cc:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
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

On Wed, May 31, 2023 at 12:14=E2=80=AFAM syzbot
<syzbot+a98f21ebda0a437b04d7@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 68674f94ffc9dddc45e7733963ecc35c5eda9efd
>     x86: don't use REP_GOOD or ERMS for small memory copies

That sounds very unlikely.

While we had another similar issue where not using REP_GOOD or ERMS
for user space clearing fixes a bug, that one failed by having
clear_user() oops instead of handling the right exception.

In that case the commit really did fix things, even if it was just by
pure luck, and removing buggy code.

But this one seems to have a failure case that has nothing to do with
exception handling, and I don't think that commit actually fixes any
semantic bug. I suspect the bisection was not entirely repeatable,
and/or might have been timing-dependent, and that the bisection thus
ended up on a random unrelated commit.

               Linus
