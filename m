Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 140E811C1E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 02:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfLLBJQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 20:09:16 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46700 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfLLBJP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:09:15 -0500
Received: by mail-lf1-f65.google.com with SMTP id f15so298946lfl.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 17:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XSsy1oK6dlgjeYC31DOAb3aczfIQDJbif+gCxstOAL4=;
        b=W0o5DFnebCMTaJ6AV7omtLbXbKiiCh8i9FH/yFc2h2qbvsuqylgRcBksJ+bXJasJuy
         mRautiQaOn3pAv13zA8lsp9sl3W+5w5u3qrODNrmLA3c6R8XTAvXGSldhsFP8XDeHm69
         SVC414oav1bFwT9QRTew9YkNXqTSPHaerPO3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XSsy1oK6dlgjeYC31DOAb3aczfIQDJbif+gCxstOAL4=;
        b=q4bWbljTDZfg0Mx1XmERs0SKtADO5ACZJlAC7xCV7fwWAaqH56Ewly5rVA3U6SMTJ+
         tR3Bn8TQO+6HrRlpWhSk/u7xELCmHTn4bbInfW6CUvctMZiubvIc2Ata8RZdcdyPgVlM
         LNOye68GFrjOM8bdb/NmyucoBg5Q3Ird9QaaP24NuXsMErpIoGoHknMPuZURpKA74hPW
         7ngNoouU0BiUmFFc3bgTPOsi885p/7RNDAdheaucmhXeocQO2NbfvaWk13lr4ZCSMfef
         nYm0PdoFu5EzpQIEI4rwUc3SokVYy/v0jDKNa2H1nKPOLTjTpl72I+H1G9LyGQ8+SQrS
         oQxw==
X-Gm-Message-State: APjAAAU4itVnGmxtJv0i2o57Dzjx+Shlch1DbUnUs0l2IgoZkflL7jxI
        5A2n7DD/01856ua6XhA5CiPi9h6EGAs=
X-Google-Smtp-Source: APXvYqzgLEK+3Sj7vCg46HEvmqjHswyJQH8JlMxdmkC0UOs+Y3oIj0Dr/3vSZWV+NgNxqn/IKkEn5Q==
X-Received: by 2002:a19:dc14:: with SMTP id t20mr4060891lfg.47.1576112951139;
        Wed, 11 Dec 2019 17:09:11 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id d9sm1990179lja.73.2019.12.11.17.09.09
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 17:09:10 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id f15so298889lfl.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 17:09:09 -0800 (PST)
X-Received: by 2002:a19:4351:: with SMTP id m17mr4171510lfj.61.1576112949682;
 Wed, 11 Dec 2019 17:09:09 -0800 (PST)
MIME-Version: 1.0
References: <20191211152943.2933-1-axboe@kernel.dk> <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk> <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
 <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk> <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
 <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk>
In-Reply-To: <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Dec 2019 17:08:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg=hHUFg3i0vDmKEg8HFbEKquAsoC8CJoZpP-8_A1jZDA@mail.gmail.com>
Message-ID: <CAHk-=wg=hHUFg3i0vDmKEg8HFbEKquAsoC8CJoZpP-8_A1jZDA@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 3:41 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> Here's what I did to reproduce:

Gaah. I have a fairly fast ssd (but it's "consumer fast" - Samsung 970
Pro - I'm assuming yours is a different class), but I encrypt my disk,
so I only get about 15k iops and I see kcyrptd in my profiles, not
kswapd.

I didn't even try to worry about RWF_UNCACHED or RWF_NOACCESS, since I
wanted to see the problem. But I think that with my setup, I can't
really see it just due to my IO being slow ;(

I do see xas_create and kswapd0, but it's 0.42%. I'm assuming it's the
very first signs of this problem, but it's certainly not all that
noticeable.

               Linus
