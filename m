Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462FE75B695
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 20:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjGTSWu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 14:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjGTSWt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:22:49 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3B2173A;
        Thu, 20 Jul 2023 11:22:46 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-cfd4a94364fso977632276.1;
        Thu, 20 Jul 2023 11:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689877365; x=1690482165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaaTOawpbvAs3scekOheOCulUUyQ5i5x8diZ424R8KA=;
        b=DzKtpXpaTGbmDG4g4m5lt6k2cKGfz5lSFSGzN1OFgBBNFveVQPq4CE3nQab1JJWe7T
         TRywX9UU92VZ4Ary76zgRmnt3vYoUklp95fz7JLM9dKwfa18xcBLMeLh8gJ8pPju1RT6
         YyhFfvjrAfe47xZKVBSgLF4PWyYMW66yIiuof+4OEOYDQTA8pH6kjAve0FuKcLQaloxa
         6k2b4iVChuYXMevrFlMSDSs9x2lGh5VuWtKw7r/oioBsG4KKyjpkF3HnvRoN7TtUjJ3h
         VQE9z4dGgAMLph6IYgzKZy7v/8PkYEJA3gEn7WJx3cMaZsV/CKR7hhV3Iy30znFDLj7c
         tLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689877365; x=1690482165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qaaTOawpbvAs3scekOheOCulUUyQ5i5x8diZ424R8KA=;
        b=GSApAaUvHKfRyyNNTxgpduae86ocKONlty4UE+TXB7W05V+PVbBjlPPSmHPHw3IU2L
         tCTvR4v3tCBEAhRihwi8uOjlPAhqYwXI8/I2ANRs9IIJoZkg20pIS/i8QuaTW8YxsFM0
         wgcYOAOl6XByrSfZPtc7fECneqDy4p+3q2l1TjUyj2jijWznJX7FK7npnZ1dDM3OOfJE
         vw8tLReFM7QzGx2uu+sXB1AKVvkrc5K3rH1xjfxPmKLoGqiAXQmhRuBaBczFLqNZDOVN
         IBnTOa+sGxGKE3Hyc7tw3PCAG4FA5zJMAPl/K3qRiT/OvKnomDpFIcAgilYP782miP5j
         xNQA==
X-Gm-Message-State: ABy/qLaMXTxPyphIARH3TQfX6PWi/Q/LSqP32kGhJEOHgvlFPMvUn8v7
        6hMN1Mk8ED5XqjOAYZWGu9jgDEDPbH+SOyaN3xQ=
X-Google-Smtp-Source: APBJJlE4tPonjU9hTwY71OUKgZOb1kZwax3RvvXv0ygTUmjvrjmH4dByhftfzf5InAGBXErO6GXpOOP7PXyLo0QCOF4=
X-Received: by 2002:a25:4ed7:0:b0:ced:ab16:15ee with SMTP id
 c206-20020a254ed7000000b00cedab1615eemr5474463ybb.17.1689877365489; Thu, 20
 Jul 2023 11:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230720152820.3566078-1-aliceryhl@google.com> <20230720152820.3566078-6-aliceryhl@google.com>
In-Reply-To: <20230720152820.3566078-6-aliceryhl@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 20 Jul 2023 20:22:34 +0200
Message-ID: <CANiq72=44YaQ--QV7+H5cQUY4o9i6hbz3OD_F_u0JGV4PzV-OQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/5] rust: file: add `DeferredFdCloser`
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Alice,

A quick comment on referencing commits:

On Thu, Jul 20, 2023 at 5:29=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> See comments on `binder_do_fd_close` and commit `80cd795630d65` for
> motivation.

The convention is to write these commit references like this:

    commit 80cd795630d6 ("binder: fix use-after-free due to
ksys_close() during fdget()")

I recommend generating them with a Git pretty format -- see the config
in the bottom part of the section at
https://docs.kernel.org/process/submitting-patches.html#describe-your-chang=
es.

Also, given it is a kernel convention, please avoid the Markdown
backticks in this case.

> +/// See comments on `binder_do_fd_close` and commit `80cd795630d65`.

Same here, i.e. in comments and documentation too (and emails too,
especially if not referenced elsewhere).

While I am at it, a few other notes below too I noticed:

> +    /// Create a new `DeferredFdCloser`.

[`DeferredFdCloser`]

> +    /// Schedule a task work that closes the file descriptor when this t=
ask returns to userspace.
> +    pub fn close_fd(mut self, fd: u32) {
> +        let file =3D unsafe { bindings::close_fd_get_file(fd) };
> +        if !file.is_null() {

Please use the early return style here, if possible, to unindent all this.

> +            // SAFETY: Since DeferredFdCloserInner is `#[repr(C)]`, cast=
ing the pointers gives a

`DeferredFdCloserInner`

> +            // Note: fl_owner_t is currently a void pointer.

`fl_owner_t`

> +            // SAFETY: The `inner` pointer is compatible with the `do_cl=
ose_fd` method.
> +            //
> +            // The call to `task_work_add` can't fail, because we are sc=
heduling the task work to
> +            // the current task.
> +            unsafe {
> +                bindings::init_task_work(inner, Some(Self::do_close_fd))=
;
> +                bindings::task_work_add(current, inner, bindings::task_w=
ork_notify_mode_TWA_RESUME);
> +            }

Should this block be split?

>  /// Represents the EBADF error code.
>  ///
>  /// Used for methods that can only fail with EBADF.

Doclink them if possible; otherwise `EBADF`.

Cheers,
Miguel
