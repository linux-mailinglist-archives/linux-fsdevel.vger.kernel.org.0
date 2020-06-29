Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C311C20D4B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 21:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731029AbgF2TK7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 15:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731019AbgF2TK6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:10:58 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE8CC031414
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 12:10:57 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 9so19460966ljv.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 12:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tSA8ywi78rUHFSpY/Nh0QOGhLyb0fCOpr5Vs4TKLX4I=;
        b=DdZYOk3C2gqHJgrApbFwYh4JVw30MMHLelRJPuRrFQHuCgzURGP0ySVe+bMXX7P0bc
         HdR5v5nmxQAKjBr/BJwcCjZ0q6O5mvmktqcNB4/IlzJBckOkjWLgl4r7Ec18e7wl7SnO
         SG0pnoDk7iVjw0PsWVE3QvC7A0cEGr6+qyrlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tSA8ywi78rUHFSpY/Nh0QOGhLyb0fCOpr5Vs4TKLX4I=;
        b=uKjYOCmQ50L1AOBdZ87sfAZhBfp8TunNuqOf3JarX0ucIdL64uet8nx5uXBgWxPs3k
         HNk2jAhpUcKL0ZvwEbjVYz+84goZlNHw/bXl034KNmhnLsEEeBJQGl9G/5y/nRKHrMR8
         BnNdb2ZLFlwZIZ8e6rcbGde7Mq1TRY5/GGkeeSvF63N0q39fHg5eLgSwKkNNzPl+JIkU
         eR84YAL02fgGBXdE/isoDjEnBga8QJA75jZmjvXF6qUVLLS7d9QkcdLbhMkZvw3zhwC6
         yl1zcpEYihDThvFi3Wf8FbjvBez8cQol02iPpC8v/BWaxZef3o1Lh8a3U/Nsa9tPKX4b
         1O2w==
X-Gm-Message-State: AOAM532TKxoJCDUIf0h5PW8dvCflKq0ItI7K+uTKxhgkz8J0ZhT9E3Mx
        y5DNvTtzKS8OV1qHoTbgrPjtaiLUZ04=
X-Google-Smtp-Source: ABdhPJzrVNBLjDGIsVR3etwyMspcf3ac6Ew0kPzahuqC5FhcX8weym4qyJNgvIOlCTRUtDST87pn/w==
X-Received: by 2002:a2e:80cc:: with SMTP id r12mr951810ljg.344.1593457855610;
        Mon, 29 Jun 2020 12:10:55 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id r13sm113311lfp.80.2020.06.29.12.10.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 12:10:54 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id t25so14888094lji.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 12:10:54 -0700 (PDT)
X-Received: by 2002:a2e:999a:: with SMTP id w26mr3408927lji.371.1593457853564;
 Mon, 29 Jun 2020 12:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200624162901.1814136-4-hch@lst.de> <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com>
 <20200624175548.GA25939@lst.de> <CAHk-=wi_51SPWQFhURtMBGh9xgdo74j1gMpuhdkddA2rDMrt1Q@mail.gmail.com>
 <f50b9afa5a2742babe0293d9910e6bf4@AcuMS.aculab.com> <CAHk-=wjxQczqZ96esvDrH5QZsLg6azXCGDgo+Bmm6r8t2ssasg@mail.gmail.com>
 <20200629152912.GA26172@lst.de> <CAHk-=wj_Br5dQt0GnMjHooSvBbVXwtGRVKQNkpCLwWjYko-4Zw@mail.gmail.com>
 <20200629180730.GA4600@lst.de> <CAHk-=whzz81Cjfn+SNbLT8WvRxfQYbiAemKrQ5jpNAgxxDQhZA@mail.gmail.com>
 <20200629183636.GA6539@lst.de>
In-Reply-To: <20200629183636.GA6539@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Jun 2020 12:10:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=whE2_YcRRQhJ73s4kYqTNDkYqq2HHtieQ-R1J+Awgk=nA@mail.gmail.com>
Message-ID: <CAHk-=whE2_YcRRQhJ73s4kYqTNDkYqq2HHtieQ-R1J+Awgk=nA@mail.gmail.com>
Subject: Re: [PATCH 03/11] fs: add new read_uptr and write_uptr file operations
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Laight <David.Laight@aculab.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 29, 2020 at 11:36 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Having resurrect my work there really are tons of int cases.  Which
> makes me thing that splitting out a setsockopt_int method which gets
> passed value instead of a pointer, then converting all the simple cases
> to that first and then doing the real shit later sounds like a prom=D1=96=
sing
> idea.

Try my hacky patch first, and just change the code that does

                if (get_user(val, (int __user *)optval)) {
                        err =3D -EFAULT;

to do

                val =3D *(int *)optval;

In fact, that pattern seems to be so common that you can probably
almost do it with a sed-script or something.

                   Linus
