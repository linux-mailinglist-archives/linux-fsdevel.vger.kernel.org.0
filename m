Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D516CCA2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 20:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjC1SoT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 14:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjC1SoS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 14:44:18 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959132121
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 11:43:54 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r11so53639260edd.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 11:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680029032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0KaGDtk/sTsNWN58KmMs7C0IRiESRSr0CDnEMhhhl0=;
        b=NdyaXU3Q9NqDRuTHuTeLz3eYSdLT8d4dZ/5oNMRGLPXEg+DK6oq6b1YmTkuqu+ih/G
         HK7bxZkCnC9SbU/If+x+w8FEh28uOBO7x2OahQEIfeBZS+xhAquEywTbMX2MQb95GlVj
         wgQNCO+cON7PJU5tlt9d7tv6o8OmZhl/tvO+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680029032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0KaGDtk/sTsNWN58KmMs7C0IRiESRSr0CDnEMhhhl0=;
        b=V31xWlru0a8oKpWfL2A6Ur1Nik5k/E7R9hVdMV5ZAFGcfJKmMkVeXaefYHFenOk6Ll
         QxU7HLvzUJX1tf2eQlWEcQyilBmLNYU57NVn/dbZmmHmSFQnoi8KE7QKcA3HTyDT27RI
         v4+yT5bDV8+w8HxyN87PhTJclJKomHGy/eLvvvqmFnrhEtgJroWQOtv35GrmCuNpY+Ti
         r9eWuKrxM6vxcZb5bJLCZ6DKPQ0l6qEDbITUOz5ryxlrnJzmdkeANybPZzsaACm7ZZdl
         NEk3cd5n1b5Hvym+lTxoc+GTDENfcID3mwxGdsSKUU9zHidPK8FsRPGq+32Cxlbc9L1N
         Pbvg==
X-Gm-Message-State: AAQBX9dn14O6fynWO39GRWp5wQQCHb/L2BxRKRWNeApOj90MC28S2xAM
        YD/I3H73RYY+RFMsaJt2ZkXiiOQbJWUnZwXNau40SQ==
X-Google-Smtp-Source: AKy350ZBkKGq8QKnmIIZ581wIVTlYYn27Yvs/z1be8vQ4hH7LJrZQ/v1e/6tWSdI1zftDM1dq207ww==
X-Received: by 2002:aa7:c846:0:b0:4fb:8d3c:3b86 with SMTP id g6-20020aa7c846000000b004fb8d3c3b86mr15789009edt.1.1680029032587;
        Tue, 28 Mar 2023 11:43:52 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id d28-20020a50cd5c000000b004fbdfbb5acesm16258325edj.89.2023.03.28.11.43.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 11:43:52 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id y4so53699696edo.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 11:43:51 -0700 (PDT)
X-Received: by 2002:a17:906:c217:b0:935:3085:303b with SMTP id
 d23-20020a170906c21700b009353085303bmr7531806ejz.15.1680029031596; Tue, 28
 Mar 2023 11:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230328173613.555192-1-axboe@kernel.dk> <20230328173613.555192-6-axboe@kernel.dk>
In-Reply-To: <20230328173613.555192-6-axboe@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Mar 2023 11:43:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=21dt1ASqkvaNXenzQCEZHydYE39+YOj8AAfzeL5HOQ@mail.gmail.com>
Message-ID: <CAHk-=wj=21dt1ASqkvaNXenzQCEZHydYE39+YOj8AAfzeL5HOQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] IB/hfi1: make hfi1_write_iter() deal with ITER_UBUF iov_iter
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

On Tue, Mar 28, 2023 at 10:36=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> Don't assume that a user backed iterator is always of the type
> ITER_IOVEC. Handle the single segment case separately, then we can
> use the same logic for ITER_UBUF and ITER_IOVEC.

Ugh. This is ugly.

Yes,. the original code is ugly too, but this makes it worse.

You have that helper for "give me the number of iovecs" and that just
works automatically with the ITER_UBUF case. But this code (and the
sound driver code in the previous patch), really lso wants a helper to
just return the 'iov' array.

And I think you should just do exactly that. The problem with
'iov_iter_iovec()' is that it doesn't return the array, it just
returns the first entry, so it's unusable for this case, and then you
have all these special "do something else for the single-entry
situation" cases.

And iov_iter_iovec() actually tries to be nice and clever and add the
iov_offset, so that you can actually do the proper iov_iter_advance()
on it etc, but again, this is not what any of this code wants, it just
wants the raw iov array, and the base will always be zero, because
this code just doesn't *work* on the iter level, and never advances
the iterator, it just advances the array index.

And the thing is, I think you could easily just add a

   const struct iovec *iov_iter_iovec_array(iter);

helper that just always returns a valid array of iov's.

For a ITER_IOV, it would just return the raw iov pointer.

And for a ITER_UBUF, we could either

 (a) just always pass in a single-entry auto iov that gets filled in
and the pointer to it returned

 (b) be *really* clever (or ugly, depending on how you want to see
it), and do something like this:

        --- a/include/linux/uio.h
        +++ b/include/linux/uio.h
        @@ -49,14 +49,23 @@ struct iov_iter {
                        size_t iov_offset;
                        int last_offset;
                };
        -       size_t count;
        -       union {
        -               const struct iovec *iov;
        -               const struct kvec *kvec;
        -               const struct bio_vec *bvec;
        -               struct xarray *xarray;
        -               struct pipe_inode_info *pipe;
        -               void __user *ubuf;
        +
        +       /*
        +        * This has the same layout as 'struct iovec'!
        +        * In particular, the ITER_UBUF form can create
        +        * a single-entry 'struct iovec' by casting the
        +        * address of the 'ubuf' member to that.
        +        */
        +       struct {
        +               union {
        +                       const struct iovec *iov;
        +                       const struct kvec *kvec;
        +                       const struct bio_vec *bvec;
        +                       struct xarray *xarray;
        +                       struct pipe_inode_info *pipe;
        +                       void __user *ubuf;
        +               };
        +               size_t count;
                };
                union {
                        unsigned long nr_segs;

and if you accept the above, then you can do

   #define iter_ubuf_to_iov(iter) ((const struct iovec *)&(iter)->ubuf)

which I will admit is not *pretty*, but it's kind of clever, I think.

So now you can trivially turn a user-backed iov_iter into the related
'struct iovec *' by just doing

   #define iov_iter_iovec_array(iter) \
     ((iter)->type =3D=3D ITER_UBUF ? iter_ubuf_to_iov(iter) : (iter)->iov)

or something like that.

And no, the above is NOT AT ALL TESTED. Caveat emptor.

And if you go blind from looking at that patch, I will not accept
responsibility.

              Linus
