Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3F1549DB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 21:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350065AbiFMT3z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 15:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351742AbiFMT3k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:29:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C08B5DD20
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 10:54:55 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id h23so12567821ejj.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 10:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0yE1F+T2LeAVJ2bFwOtJHGbp283h9GhemqSHAeGwktA=;
        b=cV5JPzOcrWUkY/YCBj01CplxNVk0Ypz2tEFigoKe7aUyACwfxpLidnfRJxQUvCHXB8
         hXeDqzdFDhPl5UTeyCWepHZO/sI6ZgbBgwwQXwmZisuOyhVixvoN3C2E6lXFMJOFc09R
         /Hv3Nw2iClVxh/V9udd7r9WBzL/nRXXjTHk6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0yE1F+T2LeAVJ2bFwOtJHGbp283h9GhemqSHAeGwktA=;
        b=h19O+4zQC6m/J6UHhPa03yupM0HCNnZn81vWaJIGHbrVACpEV5czUBDDQgDMSm+Q46
         ZPOdEgCSey4dRcuQ+LXEYvseGc/AF7f5QjgbKo14uQOUGVGcjIUBGfCDgmWFljYZ0a1J
         dDtsE/4VGTmdirSLL5e2AkmQxM8Ty0qE+VNF1QeJEulYCL+OykJykq0ijivHmpDybKKn
         MoxHCgpepqDEPMwKntRYjk4As/4zXojKswQ/mfDbCQ8n2+LYPjKRRnMlZFYMtFVHvoD/
         bMdkTZ4o7gMMZ9kWTFKy9AWChVYNypKjILwuQbrF0h1Abl7qjoGx516G1kyqadkN7Brj
         CyGg==
X-Gm-Message-State: AJIora9VfH2ZrdhqIVSSoL3ZW91LaEzNfOcgZ7TTg8nISiqXFdD7JbdX
        S/8UzSQGPqFp+3ZFzygW2/kXwjpvCm6Tr/QW
X-Google-Smtp-Source: AGRyM1uHkq6XyCl8Ipg35w1A87VdSQbVseJpK3Oy8a0J8GHzGev+x0fyU6aiU/yhBH2UQNffQi6cmA==
X-Received: by 2002:a17:907:7f8f:b0:711:623e:b344 with SMTP id qk15-20020a1709077f8f00b00711623eb344mr913362ejc.230.1655142893436;
        Mon, 13 Jun 2022 10:54:53 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id u20-20020a509514000000b0042dd1d3d571sm5444245eda.26.2022.06.13.10.54.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 10:54:52 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id q15so3391123wmj.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 10:54:52 -0700 (PDT)
X-Received: by 2002:a1c:5418:0:b0:39c:3552:c85e with SMTP id
 i24-20020a1c5418000000b0039c3552c85emr16162741wmb.68.1655142892217; Mon, 13
 Jun 2022 10:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <YqaAcKsd6uGfIQzM@zeniv-ca.linux.org.uk>
In-Reply-To: <YqaAcKsd6uGfIQzM@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Jun 2022 10:54:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmCzdNDCt6L8-N33WSRaYjnj0=yTc_JG8A_Pd7ZEtEJw@mail.gmail.com>
Message-ID: <CAHk-=wjmCzdNDCt6L8-N33WSRaYjnj0=yTc_JG8A_Pd7ZEtEJw@mail.gmail.com>
Subject: Re: [RFC][PATCH] fix short copy handling in copy_mc_pipe_to_iter()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        nvdimm@lists.linux.dev
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

On Sun, Jun 12, 2022 at 5:10 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Unlike other copying operations on ITER_PIPE, copy_mc_to_iter() can
> result in a short copy.  In that case we need to trim the unused
> buffers, as well as the length of partially filled one - it's not
> enough to set ->head, ->iov_offset and ->count to reflect how
> much had we copied.  Not hard to fix, fortunately...
>
> I'd put a helper (pipe_discard_from(pipe, head)) into pipe_fs_i.h,
> rather than iov_iter.c -

Actually, since this "copy_mc_xyz()" stuff is going to be entirely
impossible to debug and replicate for any normal situation, I would
suggest we take the approach that we (long ago) used to take with
copy_from_user(): zero out the destination buffer, so that developers
that can't test the faulting behavior don't have to worry about it.

And then the existing code is fine: it will break out of the loop, but
it won't do the odd revert games and the "randomnoise.len -= rem"
thing that I can't wrap my head around.

Hmm?

                Linus
