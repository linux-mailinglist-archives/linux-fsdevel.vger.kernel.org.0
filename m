Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB686F965F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 May 2023 02:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjEGA5O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 May 2023 20:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjEGA4v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 20:56:51 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57921658C
        for <linux-fsdevel@vger.kernel.org>; Sat,  6 May 2023 17:55:52 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-965ddb2093bso343522566b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 May 2023 17:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683420947; x=1686012947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glXsxfxfanN3iuHeudVq0nOnYNxeyQH6fIS64HIlkHs=;
        b=SSHDvTEh0bXhL8AofbEMzbxU5BbS0f21CeF3DBIHVbYdgL8KyrcvBRefBSG5Ht2wH4
         VwmOisAlWIIRYdGYfCPab8zgOnsgnN/MB7vadqOID3zk8vCRA2FZ31hwdnlYHn0iS5I2
         GAgJiOkHMtKzaEarfm6iuTLgSkQU6f5MhVsTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683420947; x=1686012947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glXsxfxfanN3iuHeudVq0nOnYNxeyQH6fIS64HIlkHs=;
        b=UWpylUo8TZOFmMtujr06kIrGMupIN1iIg+ARuX6AVQQd4k48sm1r+QIGLLNkikn1jx
         NEqWBiKOQy8TdyliN14dPjtxBe4+ZZhCONs+nJ4FX+0CXNtWEzEtTO7JkLFGacWo7POm
         Bu5JIr6bl5HejFeg+5anhK0B8R4KFseqLU0Bc2NeWYKh3MLazmsIC+XHXNI1iwDQw014
         CYhWq6wqv2PMRP524LXZWZ24oMRvVepy1zYxvy2j8DRYEh5euW+8EqmHZA2KnAjAPMo8
         GodZAIfNrB8uoEj6pdp66sOZH1n61e/9g5xQjFX1Nzgie+A9T0oRn6AguLNNqUl3U+IM
         2C3Q==
X-Gm-Message-State: AC+VfDzEGzdeLdyW/Pd5fvmqSS/TAgEy/FAAunJPr/Ntc5qHCHlgUtox
        cce5ueGoNPL6XfXNrrM6P95U5vHPeiHt9ideCcBigg==
X-Google-Smtp-Source: ACHHUZ6Yawz9wf3XXBDHMtG32kD5mBPH2XkSax6stQiZuOQ2WV6HZkNaC7PHH+wKu6ExBBrsjt/taQ==
X-Received: by 2002:a17:907:da1:b0:94f:6ca2:e34 with SMTP id go33-20020a1709070da100b0094f6ca20e34mr5518121ejc.66.1683420947439;
        Sat, 06 May 2023 17:55:47 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id ze12-20020a170906ef8c00b00965f31ff894sm2366835ejb.137.2023.05.06.17.55.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 17:55:47 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-965ddb2093bso343520466b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 May 2023 17:55:46 -0700 (PDT)
X-Received: by 2002:a17:907:8a2a:b0:94e:de35:79c5 with SMTP id
 sc42-20020a1709078a2a00b0094ede3579c5mr5800050ejc.70.1683420946608; Sat, 06
 May 2023 17:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <26aba1b5-8393-a20a-3ce9-f82425673f4d@kernel.dk>
 <CAHk-=wj=LwLDYrjHpMM+QnE2T+u4P9-UXhXGkAMXiyfGjGnNEA@mail.gmail.com> <6be969d0-e941-c8fa-aca7-c6c96f2c1ba2@kernel.dk>
In-Reply-To: <6be969d0-e941-c8fa-aca7-c6c96f2c1ba2@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 May 2023 17:55:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg=sQ6NvX5C=2xDhB45UsiGySzh0tqCuXWZ-ANOk1gRhQ@mail.gmail.com>
Message-ID: <CAHk-=wg=sQ6NvX5C=2xDhB45UsiGySzh0tqCuXWZ-ANOk1gRhQ@mail.gmail.com>
Subject: Re: [GIT PULL] Pipe FMODE_NOWAIT support
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Sat, May 6, 2023 at 3:28=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> We should just set it for socket as well and just ultimately end up
> with:
>
> static bool __io_file_supports_nowait(struct file *file)
> {
>         if (file->f_flags & O_NONBLOCK)
>                 return true;
>         return file->f_mode & FMODE_NOWAIT;
> }

Yup.

> > Something is very rotten in the state of Denmark.
>
> It's the Norwegians, always troublesome.

Something all Nordic people can agree on. Even the Norwegians, because
they are easily confused.

                  Linus
