Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90996CF330
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 21:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjC2TbL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 15:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjC2TbK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:31:10 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858691710
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 12:31:02 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r11so67674652edd.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 12:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680118261; x=1682710261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwINxFN/yJuff9v22IaswFJWYeJUGUcG5sz3V29edUg=;
        b=UrKEvAkAjsd4NvE9u4lJ7eM91pt9j2oEp8XYJrIvQu8rzxQD6o+ipeU4PKq82A59t/
         FuiSUybjTf8iQ6Iy0Eub2vPTPRKZiDLbK5U/yApGTrZeCwYKUT00Gdok9Xwxl1LqYbsC
         SkVD9Uo4Z7GbiRgmGTAxgqZKgi/kiQp+J4+pU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680118261; x=1682710261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwINxFN/yJuff9v22IaswFJWYeJUGUcG5sz3V29edUg=;
        b=xGres5zw8kYkd07D6JqTAAgvDVEAsNkonuCZtEsgt10fH2N6lNbyxb5kqaWVQuomzd
         QsUQG3OPDgist/GRJrIJPT7bTk9xG/3WLCl2I6bqirBW6RKJCYD6hlDTBUfNHTcOC8Rk
         g6XcpoKP7LAsFH8swvVPUwBPEvlAlm/ppbtkgKIzxlUfwMbp7uhd0LQ31JIDHPqRklX3
         ptic3r6QHqnU2Bm1c/khvu4rZU0BsvnSkQFqgC3+SBetGq8EtQNIb1/C1GQGUsSaRvav
         1D+NFxxPFHBaAM24SjOZ6xhXkXriaeCZXWGhiKuERs8R3YF6uJaqlgCSXhaLJB/adTQL
         kdUw==
X-Gm-Message-State: AAQBX9e24OFoXwVqlqT3aK85KKONdGltWmdYUqKGtbyp5+OV6ZXH6JUq
        /wlchIccHQYb6kLHIUvIi0rOk826zcNMVZBrEVK8uB63
X-Google-Smtp-Source: AKy350Yf7zndhAppdJM4JTpIPGDpZTvErNsQ9ezjMvgT9kNGF8lmO+ZOGsFZwt7PtmcM02tbBhhvtA==
X-Received: by 2002:a17:906:2f96:b0:932:8cd:1021 with SMTP id w22-20020a1709062f9600b0093208cd1021mr20617265eji.33.1680118260760;
        Wed, 29 Mar 2023 12:31:00 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id fi9-20020a170906da0900b00931faf03db0sm16502010ejb.27.2023.03.29.12.30.59
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 12:31:00 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id ek18so67673357edb.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 12:30:59 -0700 (PDT)
X-Received: by 2002:a17:906:7846:b0:933:1967:a984 with SMTP id
 p6-20020a170906784600b009331967a984mr10059140ejm.15.1680118259697; Wed, 29
 Mar 2023 12:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230329184055.1307648-1-axboe@kernel.dk> <20230329184055.1307648-7-axboe@kernel.dk>
In-Reply-To: <20230329184055.1307648-7-axboe@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Mar 2023 12:30:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg2q64+WLKE+0+UNeZav=LjXJZx2gHJ5NR3_5LxvQC8Mg@mail.gmail.com>
Message-ID: <CAHk-=wg2q64+WLKE+0+UNeZav=LjXJZx2gHJ5NR3_5LxvQC8Mg@mail.gmail.com>
Subject: Re: [PATCH 06/11] iov_iter: overlay struct iovec and ubuf/len
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

On Wed, Mar 29, 2023 at 11:41=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> +               struct iovec __ubuf_iovec;

I think this is the third time I say this: this should be "const struct iov=
ec".

No other use is ever valid, and this cast:

> +static inline const struct iovec *iter_iov(const struct iov_iter *iter)
> +{
> +       if (iter->iter_type =3D=3D ITER_UBUF)
> +               return (const struct iovec *) &iter->__ubuf_iovec;

should simply not exist.

The first rule of cast club is that casting one pointer to another is
generally a sign that something is wrong.

Casting a pointer to an integer? That's a valid way to get at the bit
representation for things like tagged pointers or for virtual address
arithmetic etc (ok, and by "valid" I mean "valid in kernel contexts -
not necessarily in all other contexts).

Casting an integer to a pointer? Same thing - some things just need to
do bit operations on what will become a pointer (allocators etc).

But casting a pointer to another one - that should basically always
raise eyebrows. You should try really hard to avoid it.

Yes, we do it in the kernel, and yes, it *can* be valid. But most of
the time it's really a bad sign.

             Linus
