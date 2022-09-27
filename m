Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40575EC578
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 16:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbiI0OG5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 10:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbiI0OG4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:06:56 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F193D87F88;
        Tue, 27 Sep 2022 07:06:54 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id a4so5138601ilj.8;
        Tue, 27 Sep 2022 07:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=08FYPXF8NGV3I7f8HvvukPdlDJ2mobJpfZ4nRRDrtDs=;
        b=b6TVXxWSSs1wWwgyy76IisEm+bMUWZ/TZVqBW0IiwdaKjq1GvfK4WvX0uioXtu2Hs3
         jcf/7ASYzYYGjL6N1NOc5gzJbhcbPXgiIpLgwYqW868sFRLRPVM6/+k64STgGvPwJUew
         W9D1rzvOyRhdq6qvOoo4l+TQhxonD+mm0Tmi89kwo2eBCe1tBmw5oSnGlOZ0+03lwIqh
         UWG5nRt7SlGk/zMWRiNvqo4hOtRSMoXiKKmuQuQA/I2I6ZhsS1naaE54ERdmVXQLa3Kt
         LpqxHrraYDNE+qytp1tQoK+LfPJPeUxJG720eFeQevCd3+3SR0yrd/vkxJRqWRuRvrkX
         XJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=08FYPXF8NGV3I7f8HvvukPdlDJ2mobJpfZ4nRRDrtDs=;
        b=z4Akm1n+v6OpRl69uAPD8Id09lo7Xdy67AZgOhiycM6D4OazO9x9peiU3ZOGb3ItvW
         ZqQySMpj//I6u0wP4HV/ds6osKKQPqj2F/y55rds4GYH37tHz9VsUNl/A6JNcKzRZRRX
         ML/C9OIVdQrvD5ApyuefQdnhNNA7QDyaoMGKSkXgHmlZvOvnnmna4JukgogV4+Gxyfts
         /W+g7jRPou3vdhxAItEUmJixayvBQCQoiALmnnNCfTJ+x9WgzdDdkCE8NNOGmEKNmEd6
         hJtQ3XLPit5k5sR9iusAINW6sDq+moNxaSYFogHvFZ7oDkAZ89cO9Gx3RYeIwy7bXJB1
         9gvw==
X-Gm-Message-State: ACrzQf17UTII1EbaQmlIgfS0LdQd9BE+X6pj6NX2SrTIGj2h32zWZqUf
        PmaCcwe6NQExVQxsMR88t93LSNBYmMN+NQNM8XU=
X-Google-Smtp-Source: AMsMyM5syx+SHzekoKk5qqoxYITfSS3Xf+tq/gzESB0d3rgzZ2K4BALmcjzwKNLccON5ri7Ug7BCkO3JsxrTkg8RzqI=
X-Received: by 2002:a05:6e02:188f:b0:2f8:993:e7ba with SMTP id
 o15-20020a056e02188f00b002f80993e7bamr7861514ilu.321.1664287614225; Tue, 27
 Sep 2022 07:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220927131518.30000-1-ojeda@kernel.org> <20220927131518.30000-9-ojeda@kernel.org>
 <YzL/9mlOHemaey2n@yadro.com>
In-Reply-To: <YzL/9mlOHemaey2n@yadro.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 27 Sep 2022 16:06:43 +0200
Message-ID: <CANiq72kDPMKd0qLAMVrd2A3n9aAWhh2ps5DvKos58L=_V2-XwQ@mail.gmail.com>
Subject: Re: [PATCH v10 08/27] rust: adapt `alloc` crate to the kernel
To:     Konstantin Shelekhin <k.shelekhin@yadro.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>, Matthew Bakhtiari <dev@mtbk.me>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 3:52 PM Konstantin Shelekhin
<k.shelekhin@yadro.com> wrote:
>
> Not being able to pass GFP flags here kinda limits the scope of Rust in
> kernel. I think that it must be supported in the final version that gets
> in.

Flags will be supported one way or the other in the future, but I was
requested to do v10 as a v9 with the last nits resolved.

Please see the cover letter for details.

Cheers,
Miguel
