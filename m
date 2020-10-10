Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D04C289CF0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Oct 2020 03:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgJJBPQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 21:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729351AbgJJBEG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 21:04:06 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA07C0613DA
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Oct 2020 18:03:51 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f21so11257622ljh.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Oct 2020 18:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s7OwKgWi2gSxmEp/hYxtSzWSpApJcXjT+OdSqNt7VYU=;
        b=Wf1q2lnubIrbXjk14tkrYxXcbBXmzq9qYbXL1Q2p8EB+0CvkKSqF+3HlgfvaB+X8S6
         SG17cHHpnVFX880L11ZWENbR0ebhET03jaC+x724GDZbfQvjLR0+JYp1fVD8FDqLvksZ
         kRBaHY97weaJ2iFk9krv7PVK7ymwvLjzNkwFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s7OwKgWi2gSxmEp/hYxtSzWSpApJcXjT+OdSqNt7VYU=;
        b=sYTUzT5vPpLAoH8vheoT+iZG3b/2YUy6eGQqNSbwbf36dn+3Zi1nHyED92cGVixYyB
         qBEeguujNxB4kWkZEXliK2QLiLHPoevdZ7jD6694veNWufW6t3Dt+hLGMFIV++3cT1xU
         1Qk4HLp7dADXp8b9VpkRzCT+WL2o8/D5Djhdqq3kQJ20GPe+LHS0IUDW2ljdbpg3L8ep
         673BEBctiFM33mh9fB9MQUGyjaFEykhmg0vnEfAID4lGeg4mk61XwzTO4UBxA+aDU1ZH
         8VzW37cQ3hK5TfyZ9MhLgSMKi93KNK3VKKH5U/ir89PuIXZo8ZPG+hd1Jlj4qdzlp13Y
         TaNg==
X-Gm-Message-State: AOAM530A/bOTFBJgQkCj5FduoppkJLQWogxvZyp5T5q/dfq+hm58V1Wc
        HPNQHU4df8+nQWRD1P/trtVQ0kcwZ52INQ==
X-Google-Smtp-Source: ABdhPJwlJ0CH4WF1C8Tez0X9zuVEa4EBedzdpKQcVllOA01RhYzoWZCmbbj4P1DZeYo3TbYkZxFzXg==
X-Received: by 2002:a2e:3a0e:: with SMTP id h14mr6799295lja.444.1602291829733;
        Fri, 09 Oct 2020 18:03:49 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id h6sm1842605lfg.67.2020.10.09.18.03.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 18:03:48 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id f21so11257548ljh.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Oct 2020 18:03:47 -0700 (PDT)
X-Received: by 2002:a2e:2202:: with SMTP id i2mr5735571lji.70.1602291827290;
 Fri, 09 Oct 2020 18:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200903142242.925828-1-hch@lst.de> <20200903142242.925828-6-hch@lst.de>
 <20201001223852.GA855@sol.localdomain> <20201001224051.GI3421308@ZenIV.linux.org.uk>
 <CAHk-=wgj=mKeN-EfV5tKwJNeHPLG0dybq+R5ZyGuc4WeUnqcmA@mail.gmail.com> <20201009220633.GA1122@sol.localdomain>
In-Reply-To: <20201009220633.GA1122@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 9 Oct 2020 18:03:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whcEzYjkqdpZciHh+iAdUttvfWZYoiHiF67XuTXB1YJLw@mail.gmail.com>
Message-ID: <CAHk-=whcEzYjkqdpZciHh+iAdUttvfWZYoiHiF67XuTXB1YJLw@mail.gmail.com>
Subject: Re: [PATCH 05/14] fs: don't allow kernel reads and writes without
 iter ops
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 9, 2020 at 3:06 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> It's a bit unintuitive that ppos=NULL means "use pos 0", not "use file->f_pos".

That's not at all what it means.

A NULL ppos means "this has no position at all", and is what we use
for FMODE_STREAM file descriptors (ie sockets, pipes, etc).

It also means that we don't do the locking for position updates.

The fact that "ki_pos" gets set to zero is just because it needs to be
_something_. It shouldn't actually ever be used for stream devices.

                  Linus
