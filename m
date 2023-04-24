Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CB66ED615
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 22:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjDXUYr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 16:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjDXUYp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 16:24:45 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAC15FDC
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 13:24:43 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94f3df30043so760241366b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 13:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682367882; x=1684959882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxCLtSdGwxBRfdBDT+38EgcoqndbjUK9jgH7vNQBcQ8=;
        b=YwbPHFY0+bJ35N9w1d1LfBOZaXSG0x7/b5xc08r7fmyx4DxT7cWXxD5RHphwK817zm
         bS5imXBEJmBUj/+m9sOXC1UxdO8xqDe13Q11pvpoFElA/F7LvlBHYHLt4xTfHZ5jpb/o
         styGfIId6cQ3TynnIoocr9VknReWBBVFXlJz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682367882; x=1684959882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxCLtSdGwxBRfdBDT+38EgcoqndbjUK9jgH7vNQBcQ8=;
        b=gD/ItKE8U1IzfuVP3wKREVxacefsBrxIps0nRHHoFVX3eGtuq+PuHtxfTJTXDI754h
         G6dhaX+S9znGrx3oV+0y3U9ouK8nlgpO2FknDXkfhLJutm2zEkrhD0rWFGXYxmHbOcvx
         a2eoJAijOa7+0IWItkkVJzdtRbnZtVyR+0i7NATBmaFZdIS+xJfzVcv90g1XdoqYD6kC
         D3cmCPzpQXHO/1x59aaFS2xB7e9/LfBm1jDS11CxyxGojwKGppwmun6SjahE1rl63LOV
         MBQWIQdjYX8f/ndIxo78Nl2ZdrFSnFo1FqfCITEZXXMLUf/YZfpEcNpc0N5mS+7ZJSTV
         FKwg==
X-Gm-Message-State: AAQBX9fFZ7YUdeTjqwnNRfnVpm2raE6MtYd8EcCLCMSjgupK+lw9k6K9
        BL53Q2POoMnumIa681GT+XU5xdJwzj0kzaf3aGaTBNjp
X-Google-Smtp-Source: AKy350Y+IP0FWbor9SpJEr5jIskuiZeyhrNjVSBDbHF8k094Z2G/84heX94junE4UE69dOSDpKXjmw==
X-Received: by 2002:a17:907:b60f:b0:94f:2a13:4df6 with SMTP id vl15-20020a170907b60f00b0094f2a134df6mr12949032ejc.36.1682367882057;
        Mon, 24 Apr 2023 13:24:42 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id d16-20020a1709063ed000b0094f499257f7sm5926106ejj.151.2023.04.24.13.24.41
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 13:24:41 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-504eccc8fc8so7165642a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 13:24:41 -0700 (PDT)
X-Received: by 2002:aa7:d796:0:b0:506:b8ca:e07e with SMTP id
 s22-20020aa7d796000000b00506b8cae07emr11668877edq.11.1682367880901; Mon, 24
 Apr 2023 13:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230421-kurstadt-stempeln-3459a64aef0c@brauner>
In-Reply-To: <20230421-kurstadt-stempeln-3459a64aef0c@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Apr 2023 13:24:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whOE+wXrxykHK0GimbNmxyr4a07kTpG8dzoceowTz1Yxg@mail.gmail.com>
Message-ID: <CAHk-=whOE+wXrxykHK0GimbNmxyr4a07kTpG8dzoceowTz1Yxg@mail.gmail.com>
Subject: Re: [GIT PULL] pidfd updates
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Apr 21, 2023 at 6:42=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> This adds a new pidfd_prepare() helper which allows the caller to
> reserve a pidfd number and allocates a new pidfd file that stashes the
> provided struct pid.

So I've pulled this, but I have to say that I think the "cleanup" part
is pretty nasty - and that's also visible in the interface.

In particular, pidfd_prepare() ends up returning two things, so you
have that ugly "return by reference of the third arguments", but you
also end up not being able to have one single cleanup, you have to
(continue) to do a pair of them:

    put_unused_fd(pidfd);
    fput(pidfd_file);

and I really think the old model of just having a single return value,
and doing a single "close()" was a much nicer in many ways.

Now, the reason I pulled is that I agree that actually making the fd
*visible* to user space is a big mistake.

But I really think a potentially much nicer model would have been to
extend our "get_unused_fd_flags()" model.

IOW, we could have instead marked the 'struct file *' in the file
descriptor table as being "not ready yet".

I wonder how nasty it would have been to have the low bit of the
'struct file *' mark "not ready to be used yet" or something similar.
You already can't just access the 'fdt->fd[]' array willy-nilly since
we have both normal RCU issues _and_ the somewhat unusual spectre
array indexing issues.

So looking around with

    git grep -e '->fd\['

we seem to be pretty good about that and it probably wouldn't be too
horrid to add a "check low bit isn't set" to the rules.

Then pidfd_prepare() could actually install the file pointer in the fd
table, just marked as "not ready", and then instead of "fd_install()",
yuo'd have "fd_expose(fd)" or something.

I dislike interfaces that return two different things. Particularly
ones that are supposed to be there to make things easy for the user. I
think your pidfd_prepare() helper fails that "make it easy to use"
test.

Hmm?

Anyway, I think it's an improvement even so, but I wanted to just say
that I think this could maybe have been done with a nicer model.

               Linus
