Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC95249943
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 11:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgHSJZM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 05:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbgHSJZK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 05:25:10 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F19C061343;
        Wed, 19 Aug 2020 02:25:05 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id g14so24113792iom.0;
        Wed, 19 Aug 2020 02:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=bkEhxCRWak8BZh03JB+cSadlTnqLq+96pw5ahBsMpcs=;
        b=LSmZk7YN6u92vQUCLtljE9GHbU2kZkZoRf6SK4k+miNO72+5wAot3EA+y/49cHs10r
         nT0R7pK3n3VvkVvKmwbwQhdvb1o/Lr+BLRS9aFUmP/dXiNwgCUGJmu7ivkicUerjt0vb
         DzXHVdlbsF+GeRtIz6pzIKWeC76SGn1nwisFee8FoEFzbIrJt6y8WpqRXOs92YuO3UgM
         S3x0Z+RP1r5vbGavi0RzwZzIOcT5OPEaKKeA/Jf+66OugRHk+YkPyKb21ujTHtL0yK31
         7R8IyMd8O5tBygx7LY8B4gGOUgk3vb0hZoqf2UFCyS8+q5jkOVtIyskdXizRMlkLsvAo
         4sLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=bkEhxCRWak8BZh03JB+cSadlTnqLq+96pw5ahBsMpcs=;
        b=n9wkA0XOOb8Gj/4CC+h35fXc9WOM008EJniAEDcHxpGZAFxCeFu72ufRuME9v46EGF
         VD3LXBXOIrR4fDEbBhAva5LLdNprYsvrll04lWjagHXdin6P1/v0QouAjYmmOgmHkADB
         xQ/GR6yTFMmqnYDKcwib3yn/mC4BG5Q6fYV/8sJLZEVOAiBy08DDdF9isM7fXomEGLkR
         FaaKg7xwE/8uUHlOG63x44ZvtLjKtjFaMdPVipjPM1uQh6Yo4OfDW+Huhr6dLjCOEwZ9
         wpWK/0vyEOplpkEZuEC169FS9CUkTbHUzuicuwc2EbupAXEQ91Ix+bMeB0zoQqk2Et8j
         Ajgw==
X-Gm-Message-State: AOAM533TvJctnp8PbN6tn83fuewLbMKF/4KZrmt6qLXPx1XV2+gHEBDe
        4CJBTNwJnzUAlNS3EkAOzpsPpYPTSfidRkPiGL0=
X-Google-Smtp-Source: ABdhPJzIbQ2Hgg+FELRHzrWPrIw38wS0vhrTm8Qj1gRT7lRreY5KqgQC6OeZkHKBc88fR9TG5FFOVrwDRHUEocnHGNk=
X-Received: by 2002:a05:6602:1405:: with SMTP id t5mr12302868iov.72.1597829104748;
 Wed, 19 Aug 2020 02:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200812161452.3086303-1-balsini@android.com> <CAG48ez17uXtjCTa7xpa=JWz3iBbNDQTKO2hvn6PAZtfW3kXgcA@mail.gmail.com>
 <20200813132809.GA3414542@google.com> <CAG48ez0jkU7iwdLYPA0=4PdH0SL8wpEPrYvpSztKG3JEhkeHag@mail.gmail.com>
 <20200818135313.GA3074431@google.com> <877dtvb2db.fsf@vostro.rath.org>
In-Reply-To: <877dtvb2db.fsf@vostro.rath.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 19 Aug 2020 12:24:53 +0300
Message-ID: <CAOQ4uxhRzkpg2_JA2MCXe6Hjc1XaA=s3L_4Q298dW3OxxE2nFg@mail.gmail.com>
Subject: Re: [PATCH v6] fuse: Add support for passthrough read/write
To:     Alessio Balsini <balsini@android.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Nikhilesh Reddy <reddyn@codeaurora.org>,
        Akilesh Kailash <akailash@google.com>,
        David Anderson <dvander@google.com>,
        Eric Yan <eric.yan@oneplus.com>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 19, 2020 at 9:03 AM Nikolaus Rath <Nikolaus@rath.org> wrote:
>
> Hi Alessio,
>
> Thank you for working on this, I'm excited to see things moving again on
> this front!
>
> What I would really like to see in the long-term is the ability for FUSE
> to support passthrough for specific areas of a file, i.e. the ability to
> specify different passthrough fds for different regions of the FUSE
> file.
>
> I do not want to ask you to extend the patch, but I am a little worried
> that the proposed interface would make a future extension more
> complicated than necessary. Could you comment on that? Is there a way to
> design the libfuse interface in a way that would - in the future - make
> it easier to extend it along these lines?
>
> What I have in mind is things like not coupling the setup of the
> passthrough fds to open(), but having a separate notification message for
> this (like what we use for invalidation of cache), and adding not just
> an "fd" field but also "offset" and "length" fields (which would
> currently be required to be both zero to get the "full file" semantics).
>

You mean like this?

https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/commit/?h=fuse2

I cannot blame Alessio for missing this POC patch by Miklos.
It was well hidden in another thread:
https://lore.kernel.org/linux-fsdevel/CAJfpegtjEoE7H8tayLaQHG9fRSBiVuaspnmPr2oQiOZXVB1+7g@mail.gmail.com/

Thanks,
Amir.
