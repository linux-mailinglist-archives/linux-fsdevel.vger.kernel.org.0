Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048AA7BEFB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 02:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379152AbjJJAXf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 20:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379119AbjJJAXe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 20:23:34 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47523A4;
        Mon,  9 Oct 2023 17:23:33 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-538575a38ffso8319203a12.1;
        Mon, 09 Oct 2023 17:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696897411; x=1697502211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+xtSIxKeZlWt1rOPef1/qN9coElu1e2jtPoBQvSrl4=;
        b=GAHRsvlPfnZH5H4xc1ePKLCrYBP6I2VBMBzTNSfLGtYELuKXY/045qIB1mdtmyCaMR
         9TlJ+8IQ8Q9IXOTbFQNkWeKp/ptn7QROVlNoBl9blXjUWQHESvorsrE2WXhEX6BXCyQN
         miwda4zE9y9YOjqE1Zpk66tWdRZ0CK1U2X09Xz95/92q5fcJJTUvVgcYswkUeS/ipQdA
         2QEY6gmhF3hOU0itykjP0Ml270hqLMSSuUasfzMmcm3EmiVTxiPsa+6Bz3O5ySTphEkZ
         xeJY1UO7rZx6WnWKlx5XPhkFFIwYCGOnc0fvHbnmB+aDqeR00Y2rcmyDWAw0kuRpjnDz
         8QiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696897411; x=1697502211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+xtSIxKeZlWt1rOPef1/qN9coElu1e2jtPoBQvSrl4=;
        b=Ey9tt3oS/6LSw83FzpU8jASoGdyctBJ6xE5QQ15j0sE/YvbHHl2kgWrI07ZWvHbyrb
         AQ8VAOsfqVovQYl9aBV86kiB+daDSHCsb/vUuWfuaICVIwiOycbQcd+YdJqXU160EhnF
         /iQ2mH+TXXp5OwA9ZpcIrAeVktTq5UIKgA/CV/siOeYiTHxRaPLBD5AYJbGCNBDMggCb
         tC4YmmgvQRm4UkqjsReLt2PTo2gqrzl9GfuqzlySsRWE3SCZkHqtmj5GylollMtm03yG
         zMt5ch521M8cXPYL+a+XjB5Z6gr2LPog8CDlmS2pONmnlyMv/FoMRM9/W1zVgytJwRtr
         dcQA==
X-Gm-Message-State: AOJu0YwQnWRqj+Q9AcsB+m7PaS2kaWsafhlMXFtImXqHI2Fj/pmCwU8S
        GQmyCGkIA0jQEUdzpiSWKyB0i41ZRQB50qFWrBk=
X-Google-Smtp-Source: AGHT+IFcOS6mZD4ErCC+GOSNjKwQSa+Syn+k4d3jONYpT2mmZXA2SbvzfDb8387vIJxmxpk5S630q44mN7NU9wRQmQI=
X-Received: by 2002:aa7:c508:0:b0:523:100b:462b with SMTP id
 o8-20020aa7c508000000b00523100b462bmr15510585edq.5.1696897411356; Mon, 09 Oct
 2023 17:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230919214800.3803828-1-andrii@kernel.org> <20230919214800.3803828-4-andrii@kernel.org>
 <20230926-augen-biodiesel-fdb05e859aac@brauner> <CAEf4BzaH64kkccc1P-hqQj6Mccr3Q6x059G=A95d=KfU=yBMJQ@mail.gmail.com>
 <20230927-kaution-ventilator-33a41ee74d63@brauner> <CAEf4BzZ2a7ZR75ka6bjXex=qrf9bQBEyDBN5tPtkfWbErhuOTw@mail.gmail.com>
 <CAHC9VhTTzOCo8PL_wV=TwXHDjr7BymESMq8G1WQvsXnrw627uw@mail.gmail.com>
In-Reply-To: <CAHC9VhTTzOCo8PL_wV=TwXHDjr7BymESMq8G1WQvsXnrw627uw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 Oct 2023 17:23:19 -0700
Message-ID: <CAEf4BzaQUXGi3jA5rDUTaE5DY0JjwSZyXH190q-HWQUtYSD_Vg@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 03/13] bpf: introduce BPF token object
To:     Paul Moore <paul@paul-moore.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        lennart@poettering.net, kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 9, 2023 at 3:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Wed, Sep 27, 2023 at 12:03=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Wed, Sep 27, 2023 at 2:52=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
>
> ...
>
> > > IOW, everything stays the same apart from the fact that bpf token fds
> > > are actually file descriptors referring to a detached bpffs file inst=
ead
> > > of an anonymous inode file. IOW, bpf tokens are actual bpffs objects
> > > tied to a bpffs instance.
> >
> > Ah, ok, this is a much smaller change than what I was about to make.
> > I'm glad I asked and thanks for elaborating! I'll use
> > alloc_file_pseudo() using bpffs mount in the next revision.
>
> Just a FYI, I'm still looking at v6 now, but moving from an anon_inode
> to a bpffs inode may mean we need to drop a LSM hook in
> bpf_token_create() to help mark the inode as a BPF token.  Not a big
> deal either way, and I think it makes sense to use a bpffs inode as
> opposed to an anonymous inode, just wanted to let you know.

Thanks for the heads up. I was about to post a new revision rebased on
the latest bpf-next and with an unrelated selftest fix, but I'll give
it a bit more time to get your feedback and incorporate it into the
next revision. Thanks!

>
> --
> paul-moore.com
