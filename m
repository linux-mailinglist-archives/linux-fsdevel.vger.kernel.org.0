Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C953D3BA534
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 23:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhGBVmm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 17:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhGBVmk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 17:42:40 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60468C061764
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jul 2021 14:40:07 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id e3so6720118ljo.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Jul 2021 14:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RZqwALtsQH508tfhUhLkddcNRdEqyv+/EhplpEdJ7pE=;
        b=W9R8pciJeHPopheaM4dxRYQGRdFdnYvt5IhQAOtvo0wWZduPQ99gAJNxhkarmUN9Hj
         WBqvxUAZ4TG638+jnCmrTHQQ7u9tdOYur+Rqk4LCJW+cox858p4xQOB9IY1rCKsWBLYh
         ky2fTm14sB1+RbkbNhx6IdQIjkFO+r2Z6YPkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RZqwALtsQH508tfhUhLkddcNRdEqyv+/EhplpEdJ7pE=;
        b=SzazKmOSiJ+ls2JrljOyTTJwF7Vq06C1NLASZ7ej25Vig+qwtnwDZZ+JxxrhiIjArl
         X/b6vc8DYo4lK27IXCCpw3HtbvoXtjtzR257HHSdlL+CeqjEtRL8EHtCDan+zoBoACfA
         fwxNb7aeGgDC2CZQOiQwgdEQdnXM9xWrGjCCFmjsNlom+1YA2kkzNADvkCsTZX7BFi5b
         eoJ4N2qpnKlxOzx3BJdNGDhqqKSfPUbSkEFbcuBs1/KgTw/dKY7gwz3hW1Wi8L4jEvN/
         Y/zhAhS/v5PpqZe0ySi2bEiv3Jb+sXu28rzQVqcT1gBADkBy+5ZgExrL4po7aLO6+GED
         7EvQ==
X-Gm-Message-State: AOAM532rpxSPXJCbslBDXj3Od1mwBO/NBDWh/MJmwsVi3mJNPVQYXlEq
        p/Ul7n7buLjA0Xh/x4C0x3SjAxvuSbyUKYbeCnI=
X-Google-Smtp-Source: ABdhPJyYv7xfFKUdzNLYAX0aB1oIh5+i11VselOcoDPZO2Cl0x9VuvOJBSuT+TRHDC+/UF0Wd3PZYQ==
X-Received: by 2002:a2e:96ce:: with SMTP id d14mr1147769ljj.32.1625262005414;
        Fri, 02 Jul 2021 14:40:05 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id y6sm40178lje.21.2021.07.02.14.40.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 14:40:05 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id u25so15139039ljj.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Jul 2021 14:40:04 -0700 (PDT)
X-Received: by 2002:a2e:9c58:: with SMTP id t24mr1096050ljj.411.1625262004353;
 Fri, 02 Jul 2021 14:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210702201643.GA13765@locust>
In-Reply-To: <20210702201643.GA13765@locust>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jul 2021 14:39:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjaCmLbgtSXjVA19HZO6RS8rNePjUf6HuMa3PoDS9VuSQ@mail.gmail.com>
Message-ID: <CAHk-=wjaCmLbgtSXjVA19HZO6RS8rNePjUf6HuMa3PoDS9VuSQ@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: new code for 5.14
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 2, 2021 at 1:16 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> Please let me know if anything else strange happens during the merge
> process.  The merge commits I made seem stable enough, but as it's the
> first time I've ever accepted a pull request, we'd all be open to
> feedback for improvements for next time.

It looks fine to me.

I *would* suggest editing the merge commit messages a bit when doing
pull requests from other people.

It's by no means a big deal, but it looks a bit odd to see things like

    Hi all,

   ...

    Questions, comment and feedback appreciated!

    Thanks all!
    Allison

in the merge message. All that text made a ton of sense in Allison's
pull request, but as you actually then merge it, it doesn't make a lot
of sense in the commit log, if you see what I mean..

But it's not a problem for this pull request, and I've merged it in my
tree (pending my usual build tests etc, and I don't expect any
issues).

            Linus
