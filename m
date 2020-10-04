Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD01C282C62
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 20:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgJDSId (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Oct 2020 14:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgJDSId (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Oct 2020 14:08:33 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF035C0613CE
        for <linux-fsdevel@vger.kernel.org>; Sun,  4 Oct 2020 11:08:31 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z19so8239248lfr.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Oct 2020 11:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xPAa0PwCL+R/4m3eXjRBJhAhCv7o5/mqYPfRFjTLnGg=;
        b=M6RlgCZ5gbxyh0LuGCVU7rx08rpHawmOJPAeN6wnqB8RhOwogrcswDWcqaI+EGv4iK
         UD5br9uNzrHjxpMfY386lkrsJth+5txvK2FM3VsMWKLX6kWBoeb/iRV08pFFOyyWi3Am
         zMJLNiMgDG4x3awCC4zhCyxMQtrkF6oL0bNGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xPAa0PwCL+R/4m3eXjRBJhAhCv7o5/mqYPfRFjTLnGg=;
        b=AYLP3Z+XYjVAq189kxR229nO4KVV5RZZ17aXBR5r3o4+YuuoQC4aWLl4hiMuGvA+Vj
         TeZCT2R5wdn8YrxxJao8GwuP+xH/8rt2ghMjhPYBUqF+8ASSImpOu7Vg0DLDhKgnPtym
         n/4oZpa9V1AhzbGcbhmLXQLLV83qi16s2mZ/X65nMQUWAAIc+4dEqjpHHJYpJgcAVr1y
         ffhgw9O6FrB3NRa5SpFjIzC0S9Q4Rjjn+fC4rxk3KUGrEE2t67+SfuVAoD5YqDHNRriX
         wNdxNqoW7b8FYOMUA8dK300Y6CeUgNHghPqcvnI/OOmYS0TX3nSPEwYwf8jdhPOIBkAO
         74MQ==
X-Gm-Message-State: AOAM533YwzmiS+uHAu/Xr05XSt6s4W7VyBbrnBBk8zZp1qj+QcNlYzJ2
        dK3tJFYrSJWjK4yWahblYJnPJDd5OZRDsw==
X-Google-Smtp-Source: ABdhPJzGViQrdlSpo+zSorxaxDK9a55ZPOkCJJkkr5YLfjYS3WiLZ5MZTiIhqR/1FOA3ztN9HU4Z3Q==
X-Received: by 2002:a05:6512:529:: with SMTP id o9mr1652742lfc.331.1601834909366;
        Sun, 04 Oct 2020 11:08:29 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id b11sm2557984lfo.66.2020.10.04.11.08.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 11:08:28 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id l13so2297399ljg.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Oct 2020 11:08:28 -0700 (PDT)
X-Received: by 2002:a2e:7819:: with SMTP id t25mr2979278ljc.371.1601834907754;
 Sun, 04 Oct 2020 11:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201004023608.GM3421308@ZenIV.linux.org.uk>
In-Reply-To: <20201004023608.GM3421308@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Oct 2020 11:08:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmrwNf65FZ7-S_3nJ3vEQYOruG4EoJ3Wcm2t-GvpVn4w@mail.gmail.com>
Message-ID: <CAHk-=wjmrwNf65FZ7-S_3nJ3vEQYOruG4EoJ3Wcm2t-GvpVn4w@mail.gmail.com>
Subject: Re: [RFC][PATCHSET] epoll cleanups
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 3, 2020 at 7:36 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Locking and especially control flow in fs/eventpoll.c is
> overcomplicated.  As the result, the code has been hard to follow
> and easy to fuck up while modifying.

Scanning through the patches they all look superficially ok to me, but
I'm wondering how much test coverage you have (because I'm wondering
how much test coverage we have in general for epoll).

But I'm certainly not in the least against trying to make the epoll
code more straightforward and understandable.

                  Linus
