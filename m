Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2D37AF38B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 21:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbjIZTAe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 15:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbjIZTAd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:00:33 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEE91AB
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 12:00:25 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53447d0241eso4129030a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 12:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695754824; x=1696359624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s173qssf1hSEtheDxpw+ukvaF+2Io1KlydoI9zAe+yM=;
        b=NdB0fWLWqvnDRGVXRW45jYQQWDHubZLk3lIgLI4HStAfFV1nqNd2X2NckC/MZB0e1/
         Hh6erFWTvdrj+rxRunraPdGflV4Qrfs2OusWlceFgMYjffV4z0iiyP6IuCahbV7vo0F9
         GGoGdvwxIZVf3rLG/AcHTuLDl3+aShR3l1TBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695754824; x=1696359624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s173qssf1hSEtheDxpw+ukvaF+2Io1KlydoI9zAe+yM=;
        b=GVj/jA/kWDx1Hiiu9Su/5Pl5/OaECA+KEx5IF/2Fw/4fprrAQmC8OrLKVVebBGE50Q
         pKsH70KhhAQQSZDVXr4HfhCdTKR+5Voo5/rYEcawkPmyK05fn50IfHx4+mJx01XBh1S/
         m6C5M2vJJtiaKARpzA4RzObPj6FU4zeTKemQ/USJcE9b7DxdJiBqDV7g1IlJ72p99/Oo
         289nLSh8Z3SD3DmpwQbSQv+3GrtEYJZzzml8Azi2preU32pDRDdXZ6H13SODgSL9rnRV
         Bnv8h4K2ulUFHaa7otLhnkffw5wAUEFCgO0M1JXxyDZ29Inr5htSR6UvjJAl7DqSNUk9
         tHVw==
X-Gm-Message-State: AOJu0Ywfo01HwShuVtxeyB55yvlxTToquIO7P8oR/1MwNsf7yElMUGyZ
        CI/VvrMtScaVJ/3/P4ypZFqrXVoSRLtRCWdbMNzTpQ==
X-Google-Smtp-Source: AGHT+IGwSyiKPP5DOSFUmacJsYeLsU7r5GwJrqvYoqS8HWRxTmNU/XkMMPWGfn6/dRW0QSEGTS02hQ==
X-Received: by 2002:a17:906:c143:b0:9a1:f81f:d0d5 with SMTP id dp3-20020a170906c14300b009a1f81fd0d5mr11588365ejc.54.1695754824171;
        Tue, 26 Sep 2023 12:00:24 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090608d000b0098d2d219649sm8252983eje.174.2023.09.26.12.00.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 12:00:23 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-533d6a8d6b6so7665459a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 12:00:23 -0700 (PDT)
X-Received: by 2002:a05:6402:22cd:b0:534:5e2a:d443 with SMTP id
 dm13-20020a05640222cd00b005345e2ad443mr2604911edb.29.1695754822856; Tue, 26
 Sep 2023 12:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230926162228.68666-1-mjguzik@gmail.com>
In-Reply-To: <20230926162228.68666-1-mjguzik@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Sep 2023 12:00:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjUCLfuKks-VGTG9hrFAORb5cuzqyC0gRXptYGGgL=YYg@mail.gmail.com>
Message-ID: <CAHk-=wjUCLfuKks-VGTG9hrFAORb5cuzqyC0gRXptYGGgL=YYg@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: shave work on failed file open
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     brauner@kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 26 Sept 2023 at 09:22, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> +void fput_badopen(struct file *file)
> +{
> +       if (unlikely(file->f_mode & (FMODE_BACKING | FMODE_OPENED))) {
> +               fput(file);
> +               return;
> +       }

I don't understand.

Why the FMODE_BACKING test?

The only thing that sets FMODE_BACKING is alloc_empty_backing_file(),
and we know that isn't involved, because the file that is free'd is

        file = alloc_empty_file(op->open_flag, current_cred());

so that test makes no sense.

It might make sense as another WARN_ON_ONCE(), but honestly, why even
that?  Why worry about FMODE_BACKING?

Now, the FMODE_OPENED check makes sense to me, in that it most
definitely can be set, and means we need to call the ->release()
callback and a lot more. Although I get the feeling that this test
would make more sense in the caller, since path_openat() _already_
checks for FMODE_OPENED in the non-error path too.

> +       if (WARN_ON_ONCE(atomic_long_cmpxchg(&file->f_count, 1, 0) != 1)) {
> +               fput(file);
> +               return;
> +       }

Ok, I kind of see why you'd want this safety check.  I don't see how
f_count could be validly anything else, but that's what the
WARN_ON_ONCE is all about.

Anyway, I think I'd be happier about this if it was more of a "just
the reverse of alloc_empty_file()", and path_openat() literally did
just

        if (likely(file->f_mode & FMODE_OPENED))
                release_empty_file(file);
        else
                fput(file);

instead of having this fput_badopen() helper that feels like it needs
to care about other cases than alloc_empty_file().

Don't take this email as a NAK, though. I don't hate the patch. I just
feel it could be more targeted, and more clearly "this is explicitly
avoiding the cost of 'fput()' in just path_openat() if we never
actually filled things in".

                   Linus
