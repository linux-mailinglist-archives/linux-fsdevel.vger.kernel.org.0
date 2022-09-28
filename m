Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4A35EE04F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 17:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbiI1P1B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 11:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiI1P0g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:26:36 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C735F7EC;
        Wed, 28 Sep 2022 08:26:06 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id p10so398487iln.4;
        Wed, 28 Sep 2022 08:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=K+jbjc09DvdLJcy4Thzzh2ay02sErQC/GfQnNm8hrTg=;
        b=A6DnVDZE9AoTQrtk6g5BKxUQfRkdjGz/YL1tMBBRR8CgRRdjwxe14GLF+Hi3nx/hkR
         xAMPgcQUGisNxmIkdq0rSZNza7G4JBpG4HZrY8FYAWHP79G5jz+Ne4SpkIRgaN8tvOms
         L/sy8WzVAvfuB2mWWCkblqFYQdbo6DuK1W3dGP1Ib7KI5OPZYwXdTSHximEqs4p6Ki0O
         PGl5FDmZQ2tMHVOvkAv5mera/NMB0HsFAfve9Cm96FDCbamMQZPg7IELcKWb6sEw2J+N
         qRDTTKM3pDiJlUkZ0O3ifqC9vN+L1g9brWa4X/ftSTUnRnme2FDiUKu1hrJEPtpB0rLj
         7L9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=K+jbjc09DvdLJcy4Thzzh2ay02sErQC/GfQnNm8hrTg=;
        b=PaTwj533J7/QBE0cjvCbUM5zFyPhnTA4e8xJrQ2P5gsaSEr/rn9+n8vs92lexM2vvC
         jD9W2fXqq+11qd8YrojOZSao59LS1zz3DM6YmrvOc/Hq3jTgtirpcIKX/IY614QkX1CS
         Rag5RGCMtH66AOoA9J/25ikwXp0YybTI/xCfKmY/bvN9Di0E9RcPcJgG4yJSv1WvjMVX
         pF6tLdBtSPXik24Y1axJHZzkPhvG23ACCRks6bRu7DqwKbcf6QY0llkre1vFsexc8iWQ
         gIk+DyscS7Vkn2bgQkHEEcsG2Zrns9N0Kb0EGzfuMfClIY1AW3aL4cGXk2d4dDHLZKXC
         rLPg==
X-Gm-Message-State: ACrzQf2t2s7SpuTo/Gxwy++Q5AwBVjys1tIsvKrUGthDBUsAmLrs+Nkr
        +G7pIB9UuhvgoUOKzIev/sgHzr24l1f7yuofCUFGiLDSpzg=
X-Google-Smtp-Source: AMsMyM4KDnYXvWAcGD1P9KclEAvPnSfV92FAdlD2MtWDYqQPJyaYgLFUoDd8cLzEFMqXiU74a5Cx2fKsbXFIMLmzWrI=
X-Received: by 2002:a92:c569:0:b0:2f5:927d:b61a with SMTP id
 b9-20020a92c569000000b002f5927db61amr15790847ilj.151.1664378765811; Wed, 28
 Sep 2022 08:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220927131518.30000-1-ojeda@kernel.org> <20220927131518.30000-9-ojeda@kernel.org>
 <YzRj+47LIz2G9omo@liuwe-devbox-debian-v2>
In-Reply-To: <YzRj+47LIz2G9omo@liuwe-devbox-debian-v2>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 28 Sep 2022 17:25:55 +0200
Message-ID: <CANiq72=qZPdcdPJzD0FMN13A34C9mXoMb18+uKaA7rdEGuZ0TA@mail.gmail.com>
Subject: Re: [PATCH v10 08/27] rust: adapt `alloc` crate to the kernel
To:     Wei Liu <wei.liu@kernel.org>
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

On Wed, Sep 28, 2022 at 5:10 PM Wei Liu <wei.liu@kernel.org> wrote:
>
> Missing safety comment here?

The standard library does not provide safety comments for all blocks,
and these are essentially copies of the infallible variations in the
library, which I kept as close as possible to the original.

Thanks for taking a look!

Cheers,
Miguel
