Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7104B7B0B9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 20:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjI0SGA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 14:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjI0SF7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 14:05:59 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869B3E5
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 11:05:57 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-317c3ac7339so11263636f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 11:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695837956; x=1696442756; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UznxyLIywUzNQqi71J0T/nmzjMDdI/e0HYUPWfZk0Qs=;
        b=BzqKmI6zEvzlTF1908jB8Jza6gN8os5IzgNwL2bR1lBTSeRohNgHCxlBHmw94M3evA
         zXaIgbihRIRDqY8SvWYZ25thuNkg6fpQUlkH3fY80MXjiuiWixBdP40R4+LmEkbB1o+O
         jU//yonzXUSerIhGcu92B6xoHUTowORflRyJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695837956; x=1696442756;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UznxyLIywUzNQqi71J0T/nmzjMDdI/e0HYUPWfZk0Qs=;
        b=kho7/bzgoo8U8CjttxhjBZe7GUnDJ34fY5d4t/gqLiP8LWhjg9EidHFisVHnYSuA1f
         ngPZuNBBTq5f9bQiWKPr0glmDsoXhSah554uLleK5FCo7Nsb2nYCvskc56nw2LfFNd7y
         fLgJdDjG/61RRCuvttn3X2/JEDjMflnAGmR+pXEBioJlsLlDjPRYgCw3TgUMPFpr28cT
         idDz78JY0em2n/KgaryK6X7w9ykBcrRtRHEDK0FFQKICQ7krE6JFwGtqcGOBPDaXtDQq
         TzxTk/rpi2RX46B5ewruCFIspsa3DOmGrAhUVe2Sz73b8ZEUlKLAleb0GDus029BW8Zp
         0uyA==
X-Gm-Message-State: AOJu0YwvRJyQbmQ9r879obiVGVrTMCccMylnu7gFmW9Id/pljOkIlEgK
        XehNqpLZO948aCNDItbsipgl613QMxyl4sWvcUOswA==
X-Google-Smtp-Source: AGHT+IG+RFMzCGrs/le8EQ6Fnt0V1O30163Iaxyo4hBIpoEWIYUJIEtYlV/xSUAerxbRa5fQV8RLPA==
X-Received: by 2002:adf:ec0d:0:b0:319:63f3:c0cb with SMTP id x13-20020adfec0d000000b0031963f3c0cbmr2711678wrn.40.1695837955747;
        Wed, 27 Sep 2023 11:05:55 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id rv7-20020a17090710c700b009adc81bb544sm9612226ejb.106.2023.09.27.11.05.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 11:05:55 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-533c8f8f91dso10911171a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 11:05:54 -0700 (PDT)
X-Received: by 2002:a05:6402:358:b0:534:78a6:36cb with SMTP id
 r24-20020a056402035800b0053478a636cbmr2829801edw.39.1695837954528; Wed, 27
 Sep 2023 11:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230926162228.68666-1-mjguzik@gmail.com> <CAHk-=wjUCLfuKks-VGTG9hrFAORb5cuzqyC0gRXptYGGgL=YYg@mail.gmail.com>
 <CAGudoHGej+gmmv0OOoep2ENkf7hMBib-KL44Fu=Ym46j=r6VEA@mail.gmail.com>
 <20230927-kosmetik-babypuppen-75bee530b9f0@brauner> <CAHk-=whLadznjNKZPYUjxVzAyCH-rRhb24_KaGegKT9E6A86Kg@mail.gmail.com>
 <CAGudoHH2mvfjfKt+nOCEOfvOrQ+o1pqX63tN2r_1+bLZ4OqHNA@mail.gmail.com>
In-Reply-To: <CAGudoHH2mvfjfKt+nOCEOfvOrQ+o1pqX63tN2r_1+bLZ4OqHNA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Sep 2023 11:05:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmgord99A-Gwy3dsiG1YNeXTCbt+z6=3RH_je5PP41Zw@mail.gmail.com>
Message-ID: <CAHk-=wjmgord99A-Gwy3dsiG1YNeXTCbt+z6=3RH_je5PP41Zw@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: shave work on failed file open
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 27 Sept 2023 at 10:56, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> Comments in the patch explicitly mention dodgin RCU for the file object.

Not the commit message,. and the comment is also actually pretty
obscure and only talks about the freeing part.

The cred part is what actually made me go "why is that even rcu-free'd".

I *think* it's bogus, but I didn't go look at the history of it .

> Well put_cred is called synchronously, but should this happen to be
> the last ref on them, they will get call_rcu(&cred->rcu,
> put_cred_rcu)'ed.

Yes. But the way it's done in __fput() you end up potentially
RCU-delaying it twice. Odd.

The reason we rcu-delay the 'struct file *' is because of the
__fget_files_rcu() games.

But I don't see why the cred thing is there.

Historical mistake? But it all looks a bit odd, and because of that it
worries me.

              Linus
