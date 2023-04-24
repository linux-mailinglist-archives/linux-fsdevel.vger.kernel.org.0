Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB576ED70E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 23:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjDXV6l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 17:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjDXV6k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:58:40 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E90E5FDB
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 14:58:38 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-94f3df30043so775460466b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 14:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682373516; x=1684965516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxDPBm3zzu9au0mdoHab7CA/lqcegVQe6ANH2LAFZKk=;
        b=PqA2KPwDHGkc1IWHQm1LEVe4oV+uBQo05tonRIJ3hXSM6K+ffBlC3+vw//47cG+Zbn
         aYuCs5WXoj3AqBHPR18lq63lRm9Hj9HPjSVGHGad85bwh+8mkTKiMVSQ0XWAODG77V3z
         UhIWOKO0+XVjxCScqVrtxAYxe7G88MOb8MH/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682373516; x=1684965516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxDPBm3zzu9au0mdoHab7CA/lqcegVQe6ANH2LAFZKk=;
        b=luws9mY34OuRf3iAdS7mqD2SfEaDREW4K9V4hDrxvEofYU6tZiiHm7NxtUaf/YAgHT
         Pba9UAr2vRWpA6oi0AIRgznLKRYELRih3z/dwQD6N1N/dBdRKJI/IBUKJ0M5WcGdvp+3
         ytVYXfBeshRe7hevp3MS3N01EtveO8N5VVz8dsi3isEDMmk1qQAynGQLx4haDWEIXckE
         gmF3N8rqhSI0zwKZMF5GnaWEwdKfnQBpcYm5fNZv+r8IjZF2zjT79RfwhOnz9jWWCFC4
         vE3JrT0GXahXSdISiAwykjlvL6PPuWODNnfMMH1kSuUDiRRm5AUlQd4//O6VkEgn5+ru
         JnXA==
X-Gm-Message-State: AAQBX9cYv+FDZ3C2eHYbapKx043y5HtPpXQLHxVTFIOT0rFDlTbgDf0A
        TZLGyL7fYL3GkOh9pDqRn5q/oBafnVBkI+1K5/XoSDVd
X-Google-Smtp-Source: AKy350Z2BA/rhENKWA4IljmP2gEusyLN4YjJ2v0ztlUguDDDMq/vH+WWX9qsQ31XP9C/wOkXMNMJyg==
X-Received: by 2002:a17:906:6009:b0:94d:69e0:6098 with SMTP id o9-20020a170906600900b0094d69e06098mr12517430ejj.45.1682373516429;
        Mon, 24 Apr 2023 14:58:36 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id d16-20020a1709063ed000b0094f499257f7sm6002611ejj.151.2023.04.24.14.58.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 14:58:35 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-94eee951c70so776682166b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 14:58:35 -0700 (PDT)
X-Received: by 2002:aa7:c44c:0:b0:509:ef47:768 with SMTP id
 n12-20020aa7c44c000000b00509ef470768mr106511edr.30.1682373515386; Mon, 24 Apr
 2023 14:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230421-seilbahn-vorpreschen-bd73ac3c88d7@brauner>
 <CAHk-=wgyL9OujQ72er7oXt_VsMeno4bMKCTydBT1WSaagZ_5CA@mail.gmail.com>
 <6882b74e-874a-c116-62ac-564104c5ad34@kernel.dk> <CAHk-=wiQ8g+B0bCPJ9fxZ+Oa0LPAUAyryw9i+-fBUe72LoA+QQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiQ8g+B0bCPJ9fxZ+Oa0LPAUAyryw9i+-fBUe72LoA+QQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Apr 2023 14:58:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgGzwaz2yGO9_PFv4O1ke_uHg25Ab0UndK+G9vJ9V4=hw@mail.gmail.com>
Message-ID: <CAHk-=wgGzwaz2yGO9_PFv4O1ke_uHg25Ab0UndK+G9vJ9V4=hw@mail.gmail.com>
Subject: Re: [GIT PULL] pipe: nonblocking rw for io_uring
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 24, 2023 at 2:37=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And I completely refuse to add that trylock hack to paper that over.
> The pipe lock is *not* meant for IO.

If you want to paper it over, do it other ways.

I'd love to just magically fix splice, but hey, that might not be possible.

But possible fixes papering this over might be to make splice "poison
a pipe, and make io_uring falls back on io workers only on pipes that
do splice. Make any normal pipe read/write load sane.

And no, don't worry about races. If you have the same pipe used for
io_uring IO *and* somebody else then doing splice on it and racing,
just take the loss and tell people that they might hit a slow case if
they do stupid things.

Basically, the patch might look like something like

 - do_pipe() sets FMODE_NOWAIT by default when creating a pipe

 - splice then clears FMODE_NOWAIT on pipes as they are used

and now io_uring sees whether the pipe is playing nice or not.

As far as I can tell, something like that would make the
'pipe_buf_confirm()' part unnecessary too, since that's only relevant
for splice.

A fancier version might be to only do that "splice then clears
FMODE_NOWAIT" thing if the other side of the splice has not set
FMODE_NOWAIT.

Honestly, if the problem is "pipe IO is slow", then splice should not
be the thing you optimize for.

                 Linus
