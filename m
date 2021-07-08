Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B803C193B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jul 2021 20:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhGHShU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jul 2021 14:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhGHShT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jul 2021 14:37:19 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8784EC061574
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jul 2021 11:34:36 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id n14so18068954lfu.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jul 2021 11:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o2ASoGiHcKvlol6jVeSQSpIyIFc5g3r9dX0y3Fr3Zgc=;
        b=gE2ilK7h886+WToRooDIY8/bXblwfYQrTzKDQ7q/OgvAeCfHMqkjTTJqCH3ejPJm9X
         IRyUa6pi3KuJLLlpYE7CrnIdEa8Ih/7GxWt55xPvATc2Wbe5muIqzEsr+kDxql3PxIO/
         9esjBbLtbdr2ajX5MQM608F7ujW97xtnU0uec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o2ASoGiHcKvlol6jVeSQSpIyIFc5g3r9dX0y3Fr3Zgc=;
        b=WDtYURq9af5on2dQDw23g9oU6z+RRFmWpNql2ehhv7aHbMaD7I4cjjRS2bIwUlLOOX
         x0CVIN+fboUMxdlYtrq07ekTRWnKqjzuDXgw+sIJ4pUypdUjD6AZGXWu7D+YQy5hPmCB
         dBh+1COkA08BuUJ+hiPXM0KVsWmAINteNsePCOu+Z3ASspbXNliU6RmoRdNZFclnY/yD
         uoG9wy8pxA54NvNf5CeHocdH7FJfg8dI6k/ZYZl8+CEaqsOAFVS2B9ztJJIuCATMqnyZ
         iZ0nxsU7QgyMMIuR9WGAJ23AfsbKXe4wjut997ZN+yU3RhSWZTKmTl8OI55NKTcaqnI0
         Wn/g==
X-Gm-Message-State: AOAM5317VzpwKZzoB/8+epA7HNvAIY9VkjvJP1Vhw+fStHSzQgSz24fb
        Cc29rSuDJXWhsO4SVE+LlE3MIoNoZql+acI1f0w=
X-Google-Smtp-Source: ABdhPJwjNlumshOU8sJpy5b6AmixesbDszpsp3s4txDDHRk0s0vOTCEHQ8DLGZh2KLjm0o4iLNphBA==
X-Received: by 2002:a19:6f0b:: with SMTP id k11mr21014357lfc.401.1625769274373;
        Thu, 08 Jul 2021 11:34:34 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id f23sm316716ljn.98.2021.07.08.11.34.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 11:34:34 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id a18so3934033ljk.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jul 2021 11:34:33 -0700 (PDT)
X-Received: by 2002:a2e:9c58:: with SMTP id t24mr24720298ljj.411.1625769273393;
 Thu, 08 Jul 2021 11:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210708063447.3556403-1-dkadashev@gmail.com>
In-Reply-To: <20210708063447.3556403-1-dkadashev@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 8 Jul 2021 11:34:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjMFZ98ERV7V5u6R4FbYi3vRRf8_Uev493qeYCa1vqV3Q@mail.gmail.com>
Message-ID: <CAHk-=wjMFZ98ERV7V5u6R4FbYi3vRRf8_Uev493qeYCa1vqV3Q@mail.gmail.com>
Subject: Re: [PATCH v9 00/11] io_uring: add mkdir and [sym]linkat support
To:     Dmitry Kadashev <dkadashev@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 7, 2021 at 11:35 PM Dmitry Kadashev <dkadashev@gmail.com> wrote:
>
> v9:
> - reorder commits to keep io_uring ones nicely grouped at the end
> - change 'fs:' to 'namei:' in related commit subjects, since this is
>   what seems to be usually used in such cases

Ok, ack from me on this series, and as far as I'm concerned it can go
through the io_uring branch.

Al, please holler if you have any concerns.

I do see a few cleanups - the ones I've already mentioned to try to
remove some of the goto spaghetti, and I think we end up with just two
users of filename_create(), and we might just make those convert to
the new world order, and get rid of the __filename_create() vs
filename_creat() distinction.

But those cleanups might as well be left for later, so I don't think
that needs to hold the series up.

Al - one last chance to speak up..

           Linus
