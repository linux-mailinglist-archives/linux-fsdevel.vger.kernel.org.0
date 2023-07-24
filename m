Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A790275FC49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 18:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjGXQgu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 12:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjGXQgt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:36:49 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09E1125
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 09:36:48 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-991f956fb5aso681452066b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 09:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690216607; x=1690821407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PqCllFZEL4hUvKoQlmUZO5kx789f/+G2lVRaQsugz0g=;
        b=FKdxl+oRNgyKzVAm2twvI3sNnGZiCovlbY4CCZVz85OUNF03J2CvL98lpTWUxIyo+c
         pifqSDwVrjqbbAcaZrM3KcJW2bov9zDK23qvyRdO713vCVXgV63wINupzP1Ijs0SGm3e
         g4eyjjVhSL7Jw/6LmmnvzBOQBzq2zh38tWa2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690216607; x=1690821407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PqCllFZEL4hUvKoQlmUZO5kx789f/+G2lVRaQsugz0g=;
        b=cGsHn9mD36p0StDFBHysLhH8/TgBZPo/iy03g2UxRcIdO3t6kWC9te61m6YlPKhArP
         uPmp5Pko7X78eWMJYPSlr1WiTQoDJ+YYimwvUKRHu1SbcaUNkdgm45qYJRvzOFFF2TQK
         Mi7i6WpSZDgjgG0FQOrIFIOhOunXUHS70pJdpUOsU9GEllDnFsCZOA0nWaatS8JGWKoW
         fSC1nwcS14XN6+Nu9/xrBg6UWnEcSZaR20vIoPWhmx3sMK72iozzZpoLAAOAb1N7JAhd
         ffnxZzmf+heBkSzxOSgq1JPeRXS/eDaobYanJ1FYRNyOcE5Syk3Dksq+oRPKA4lm5i6S
         EiPw==
X-Gm-Message-State: ABy/qLYJAtq4T51o7OfnQGZZN3ggYPrRyyEK1sq55TJAyFv23CJiMf15
        jmEByHgiUK/fgAwid/SErDb/oeCFWsLTnRIcTWfrjA==
X-Google-Smtp-Source: APBJJlFFd/GWQUuNupVPDBDfFWxLSsrJJpWJuLWP3q7qHI9sqd39z/eqzirSQRXPSOUNwXdwfkiQCQ==
X-Received: by 2002:a17:906:8a7b:b0:992:a9ba:b8da with SMTP id hy27-20020a1709068a7b00b00992a9bab8damr9809707ejc.70.1690216606808;
        Mon, 24 Jul 2023 09:36:46 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a25-20020a17090640d900b00977ca5de275sm7103296ejk.13.2023.07.24.09.36.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 09:36:45 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5221ee899a0so2900137a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 09:36:45 -0700 (PDT)
X-Received: by 2002:aa7:c753:0:b0:51e:1a51:d414 with SMTP id
 c19-20020aa7c753000000b0051e1a51d414mr8138970eds.32.1690216605475; Mon, 24
 Jul 2023 09:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com> <20230724-scheren-absegnen-8c807c760ba1@brauner>
In-Reply-To: <20230724-scheren-absegnen-8c807c760ba1@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Jul 2023 09:36:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwUTsixPwyBiuA25F2mAzARTU_-BijfmJ3MzkKLOYDmA@mail.gmail.com>
Message-ID: <CAHk-=whwUTsixPwyBiuA25F2mAzARTU_-BijfmJ3MzkKLOYDmA@mail.gmail.com>
Subject: Re: [PATCH] file: always lock position
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 24 Jul 2023 at 09:19, Christian Brauner <brauner@kernel.org> wrote:
>
> SCM_RIGHTS which have existed since 2.1 or sm allow you to do the same
> thing just cooperatively. If you receive a bunch of fds from another
> task including sockets and so on they refer to the same struct file.

Yes, but it has special synchronization rules, eg big comment in
commit cbcf01128d0a ("af_unix: fix garbage collect vs MSG_PEEK").

There are magic rules with "total_refs == inflight_refs", and that
total_refs thing is very much the file count, ie

                total_refs = file_count(u->sk.sk_socket->file);

where we had some nasty bugs with files coming back to life.

> In recent kernels we also have the seccomp notifier addfd ioctl which
> let's you add a file descriptor into another process which can also be
> used to create shared struct files.

Note that shared files aren't a problem per se. The most obvious case
is just 'dup()'. It's been around forever.

What's a problem is a file that *isn't* shared magically becoming
shared without the process being aware of it.

Both SCM file passing and the seccomp addfd cases are synchronous wrt
the source file descriptor and don't add any references from
"outside".

             Linus
