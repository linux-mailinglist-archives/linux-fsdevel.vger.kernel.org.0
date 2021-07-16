Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDF93CBBA9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 20:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhGPSKx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 14:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhGPSKx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 14:10:53 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED627C06175F
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jul 2021 11:07:56 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id u25so15139798ljj.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jul 2021 11:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=la3VY4BX+aLIya8DFhmm4lsPFouObr1MQVIqGHV1haM=;
        b=V5IgJX7qk9FOKmWrEPUq3X8QcEKSnfNd7zCeCtbaLY0k8Q/Y6yXzaNyWL1szPNBeoN
         00Jvw9tYc6Q2BmPQR4l9+qfRP+5w3nQFFulhhD/7g9a9d+kjSsA5xl63651acPtoBV5F
         ya5WSNhbjkI1gJfk0JKG7f2M9rt3cil+GoEwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=la3VY4BX+aLIya8DFhmm4lsPFouObr1MQVIqGHV1haM=;
        b=iNZBQxYJ1Mr0NyXH/wJr828YcTeXkwLF7quoPIwtpFWGVwoGJZIJbM+TrvNwJBOGK5
         LGuBmFDXEmvEbYyGXiP0gjA0Hk0VTb/4r6ObtHGJ8hZSArnktPUKkrsdceFuLirOybIW
         AU/hr88tJkqsjSkqC5ynMJ/Zj2i3drQeheWUmiiP+PHbo4ddTyUWOynSqUJtK4KlYX7H
         wb8wVP15tEkhrbQdMyD1oaCa8bLQz605/PwPf/jfwGVNoJPGFSOIft/qSDoYthzminar
         sTsEKN7P7BlYfufawfsGeR58l2AuhNKTSlqJWHycTos+fP/0ScnBintHKDSjdYCvzgJC
         1e3w==
X-Gm-Message-State: AOAM530i3Hz5xcMJwAIXZsGl2JAQ1hHww3EX7W8TFg5bflWegntMOUmS
        j9h5iwJ1VgbSDa4+J6WtojyPjl3wWheqfs6s
X-Google-Smtp-Source: ABdhPJy9RdjFLhjfInof7tZcxvECWZ0oAeZpLtS/xOOPv8Vmq7aYiGvVrmclUdDdsPvFPu8IOCCPXA==
X-Received: by 2002:a2e:9d1a:: with SMTP id t26mr10023812lji.10.1626458868101;
        Fri, 16 Jul 2021 11:07:48 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id k11sm699000lfm.133.2021.07.16.11.07.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 11:07:47 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id f30so17454140lfj.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jul 2021 11:07:46 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr7981304lfa.421.1626458865567;
 Fri, 16 Jul 2021 11:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <4e8c0640-d781-877c-e6c5-ed5cc09443f6@gmail.com> <20210716114635.14797-1-papadakospan@gmail.com>
In-Reply-To: <20210716114635.14797-1-papadakospan@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 16 Jul 2021 11:07:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfeq9gyPWK3yao6cCj7LKeU3vQEDGJ3rKDdcaPNVMQzQ@mail.gmail.com>
Message-ID: <CAHk-=whfeq9gyPWK3yao6cCj7LKeU3vQEDGJ3rKDdcaPNVMQzQ@mail.gmail.com>
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
To:     "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     zajec5@gmail.com, "Darrick J. Wong" <djwong@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 16, 2021 at 4:49 AM Leonidas P. Papadakos
<papadakospan@gmail.com> wrote:
>
> This driver is already in a much better feature state than the old ntfs driver from 2001.

If the new ntfs code has acks from people - and it sounds like it did
get them - and Paragon is expected to be the maintainer of it, then I
think Paragon should just make a git pull request for it.

That's assuming that it continues to be all in just fs/ntfs3/ (plus
fs/Kconfig, fs/Makefile and MAINTAINERS entries and whatever
documentation) and there are no other system-wide changes. Which I
don't think it had.

We simply don't have anybody to funnel new filesystems - the fsdevel
mailing list is good for comments and get feedback, but at some point
somebody just needs to actually submit it, and that's not what fsdevel
ends up doing.

The argument that "it's already in a much better state than the old
ntfs driver" may not be a very strong technical argument (not because
of any Paragon problems - just because the old ntfs driver is not
great), but it _is_ a fairly strong argument for merging the new one
from Paragon.

And I don't think there has been any huge _complaints_ about the code,
and I don't think there's been any sign that being outside the kernel
helps.

               Linus
