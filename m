Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B0C6CCD10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 00:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjC1WR7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 18:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjC1WRb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:17:31 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0972736
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 15:17:15 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id cn12so55744304edb.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 15:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680041828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dSEscDt0KCn6pzVxlB9bklM+qdV+JY2pxB29KbWzX8=;
        b=WmBAbVqMaIgZ/JdVdoTjBrC4sYHO6T5RJFbIgAVF+hbrsW+nnIF5NwXTnoerrwfx/a
         lEI5dLIwXy9ouJMa2VRj9JGx37iO6uwq53KuLdLN2Nz/5hgErd4Bf8UwOZatOB7DVoWi
         5DU5cTx7PaVb6vkU4k23MH2y00Wzk5oPACQ4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680041828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dSEscDt0KCn6pzVxlB9bklM+qdV+JY2pxB29KbWzX8=;
        b=HnsVs4AdHFOdBOzPUwjO5zUooOjDyvrioIm5aQruRO8NAF0yAXENjZmW4UsQfpDVCB
         4Y2uXKDcrTZtt2u2y55rppq/Wxecijr1hpfLckwCRB3dtaDBE394vLPI9GqqYw2GQJoJ
         6bPC/t79sLj2u0B7zWt/5ojv5cUgaKTJjdTRLAFb3zOT5YblFSzBJhumZP7ZN+PImQ5v
         GBFqoMzyeY6tklHlKGok95gmOh1euLKCe/0UQ8TQCmQkhKfGfLRFJpjTy59/uO3Edx+c
         G2Ud8k5aBHSnqjWspDJgWX2MU8i2hUoweCNnR8dSmFXYaPOUtEWnD77xqVh9jmgD/Foa
         gXtw==
X-Gm-Message-State: AAQBX9eiVYthS8hxEpZFedqFpx2qGPZrvJBM7UzSA6aITlqRkbtlEa+8
        y7YLaxQQaiaY7pzeeqtpKA6rghOtRZpy1p+Jrtbdiw==
X-Google-Smtp-Source: AKy350agq1e1UO0Ky+l6QB4J11MFcefebJSkpU4hLEdCiuQ1k/VQKyPzybc05rCwNw6uPXowEjQraw==
X-Received: by 2002:aa7:c305:0:b0:502:246e:6739 with SMTP id l5-20020aa7c305000000b00502246e6739mr15401493edq.27.1680041828423;
        Tue, 28 Mar 2023 15:17:08 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id x30-20020a50d61e000000b004c30e2fc6e5sm16203481edi.65.2023.03.28.15.17.07
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 15:17:07 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id ew6so55653077edb.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 15:17:07 -0700 (PDT)
X-Received: by 2002:a17:907:9870:b0:8b1:28f6:8ab3 with SMTP id
 ko16-20020a170907987000b008b128f68ab3mr9055817ejc.15.1680041827272; Tue, 28
 Mar 2023 15:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230328215811.903557-1-axboe@kernel.dk> <20230328215811.903557-4-axboe@kernel.dk>
In-Reply-To: <20230328215811.903557-4-axboe@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Mar 2023 15:16:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=winXSHgikHZSyDrmoN=WNZWKoR1JrKGW6Vv4mqn6F4EmA@mail.gmail.com>
Message-ID: <CAHk-=winXSHgikHZSyDrmoN=WNZWKoR1JrKGW6Vv4mqn6F4EmA@mail.gmail.com>
Subject: Re: [PATCH 3/9] iov_iter: overlay struct iovec and ubuf/len
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

On Tue, Mar 28, 2023 at 2:58=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> +               struct iovec __ubuf_iovec;

This really should be "const struct iovec".

The only valid use for this is as an alternative to "iter->iov", and
that one is a 'const' pointer too:

> +                               const struct iovec *iov;

and any code that tries to use it as a non-const iovec entry really is
very very wrong.

And yes, the current infiniband/hw/hfi1/* code does indeed do all of
this wrong and cast the pointer to a non-const one, but that's
actually just because somebody didn't do the const conversion right.

That cast should just go away, and hfi1_user_sdma_process_request()
should just take a 'const struct iovec *iovec' argument.  It doesn't
actually want to write to it anyway, so it's literally just a "change
the prototype of the function" change.

              Linus
