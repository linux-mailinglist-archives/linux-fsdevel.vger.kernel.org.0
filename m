Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA17750E72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 18:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbjGLQZ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 12:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjGLQZH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:25:07 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8229219B9
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 09:25:03 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-991fe70f21bso894060566b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 09:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689179101; x=1691771101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+n3/sUni28MSCLgxWztdZs9B20evtoadadoik5Bznhs=;
        b=Nb4xw70i0SgD0nIrV9vs6Tef3wwSgf0PmFAFyVsQijGuUciUxJK0BDkfonxrK0MtwI
         qHl6iALG1m4N85H5dCc8T+wWdnQ09KkM2bvUWUi6d3I0OEqG/jr4h2M3e8AkpBUsRr0l
         7u/ik5ur9tcNd2Owk8pE9pn6DJJQ/4cDG3VHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689179101; x=1691771101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+n3/sUni28MSCLgxWztdZs9B20evtoadadoik5Bznhs=;
        b=hygaVZfntIqJCyXo+9WdeQJ22ypEeIR13qoL/DbSXNdB3MvRQ1hMG+9RBTgQNRg5y3
         96OQa/Nph4FmV5UUUYaBh2inadqhT+x6C7/AYHLmNYbCU/fvwW/h3cqdTNuoRMeR1YHo
         t49GcLw91E5L8/YorNO5ceN6w/WxETwWDUd5E0/PLDncyMUN7icYaAiArJtR3jF5hzkx
         0ang4esBHeMMbce4H0/6lyA6tAJocIhrSqOSQ7GVYso+9U+/QCretHXPp+MgAqaXFkC+
         vPj/itHo8H+h33yah29EqD0Ne+DnHB5f0xUupdJAK4xaOrmOF7fn+YYHcHEhqI6xl+QT
         ZTUw==
X-Gm-Message-State: ABy/qLaJpyegNjeP8fXSGhl+u9w0nbtH7bAk2Bb1ruILXGNj3rkN/nWK
        RLXlSgTpRiiiWGi9EwLAdQkrqA5L64L2MCVyj/19Zhw9
X-Google-Smtp-Source: APBJJlG9HxnTQDiBBDqOKsM0Xm8WB2XBiJXFEqKAMzY2B1Rqnz6ca8xKpNhrUMYILUjt+J5i0Kba7A==
X-Received: by 2002:a17:906:eceb:b0:988:d6ca:ea72 with SMTP id qt11-20020a170906eceb00b00988d6caea72mr19665729ejb.71.1689179101747;
        Wed, 12 Jul 2023 09:25:01 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id x2-20020a1709064a8200b00992b2c55c67sm2726366eju.156.2023.07.12.09.25.00
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 09:25:01 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-51e590a8d0bso4700711a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 09:25:00 -0700 (PDT)
X-Received: by 2002:aa7:c986:0:b0:51d:8a53:d1f with SMTP id
 c6-20020aa7c986000000b0051d8a530d1fmr19862433edt.8.1689179100685; Wed, 12 Jul
 2023 09:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230712-vfs-chmod-symlinks-v1-1-27921df6011f@kernel.org>
In-Reply-To: <20230712-vfs-chmod-symlinks-v1-1-27921df6011f@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Jul 2023 09:24:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=whypK=-91QfDpd3PWwazx35iWT=ooKLxhbeTAwJL_WXVg@mail.gmail.com>
Message-ID: <CAHk-=whypK=-91QfDpd3PWwazx35iWT=ooKLxhbeTAwJL_WXVg@mail.gmail.com>
Subject: Re: [PATCH] attr: block mode changes of symlinks
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Florian Weimer <fweimer@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 12 Jul 2023 at 02:56, Christian Brauner <brauner@kernel.org> wrote:
>
> Changing the mode of symlinks is meaningless as the vfs doesn't take the
> mode of a symlink into account during path lookup permission checking.

Hmm. I have this dim memory that we actually used to do that as an
extension at one point for the symlinks in /proc. Long long ago.

Or maybe it was just a potential plan.

Because at least in /proc, the symlinks *do* have protection semantics
(ie you can't do readlink() on them or follow them without the right
permissions.

That said, blocking the mode setting sounds fine, because the proc
permissions are basically done separately.

However:

>         if ((ia_valid & ATTR_MODE)) {
> +               if (S_ISLNK(inode->i_mode))
> +                       return -EOPNOTSUPP;
> +
>                 umode_t amode = attr->ia_mode;

The above is not ok. It might compile these days because we have to
allow statements before declarations for other reasons, but that
doesn't make it ok.

             Linus
