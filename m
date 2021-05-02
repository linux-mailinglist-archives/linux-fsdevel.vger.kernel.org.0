Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD13370E68
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 May 2021 20:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbhEBSQG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 May 2021 14:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbhEBSQF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 May 2021 14:16:05 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD9AC06174A
        for <linux-fsdevel@vger.kernel.org>; Sun,  2 May 2021 11:15:12 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2so4826709lft.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 May 2021 11:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oKGSHz+GYDfcENA6Ac4ygnxXuVBRs93FmwEKOWqoqr4=;
        b=cnE3uPTRMjbmL0b+HkiLAC485nJ3E0M5Z5UZYaA+5h8MwQBLmy+lW+oi6tfS8VpEhM
         QzpiEyUMFEoml/rFFfVbUNAKzRL07l0DToPsR9Oow9p9qkew6epr5bmCA28f2oGK1QI3
         OgPje87MMhas0HS1bT0NeDvRQ4HuuciRIl+9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oKGSHz+GYDfcENA6Ac4ygnxXuVBRs93FmwEKOWqoqr4=;
        b=hvi5hxkq4a+Ic0X/AcKPIVsfgc4LIi/XlmO6E2ZVyPtlu1blqG5pZlMAzej8QVbyIV
         QSSN9kMvzMG7XseB5CIKozYOHlL7Au7VhZZkeyv35B2Q0gyCKYgveFzgpLhmQ4two61W
         eOmV+2RPa7uDa/frI9nsFXy2w9/lTb3ONyeNHnwsMngcEwtQQCRfBJUkXAScVAnxbdRW
         1m0Sm6UXaKBKTX9e7tAeSFX31T4KHmxYZR1+/clCuPkF7n912JCMEMQ5o0l7E2N3xjcE
         xYxjLC4X30uJcIQj7VNMfOQ9MbXlFtwGkrZxn50/bl5xBChtTF1Ms9S8JzX9Sr5pN/IX
         HhIA==
X-Gm-Message-State: AOAM530SJXvttCaS/uHS4emDkJ+YAR8F/fgSqCMX0HOHcFntb1LXchwu
        8NWoknmKBl2r2w3gw/cIhhngPTUb/G0sPWQv
X-Google-Smtp-Source: ABdhPJzdcjpThzhfNbKrfUZePeI3qFkZL9L05KzzxRmwaKGZ2X/aEIw6AuCk3gqikaUNLJgjmXY+Gg==
X-Received: by 2002:a05:6512:39cc:: with SMTP id k12mr10160868lfu.69.1619979310576;
        Sun, 02 May 2021 11:15:10 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id w4sm902159lfu.105.2021.05.02.11.15.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 May 2021 11:15:10 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id z13so4836131lft.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 May 2021 11:15:10 -0700 (PDT)
X-Received: by 2002:ac2:5f92:: with SMTP id r18mr10837945lfe.253.1619979309776;
 Sun, 02 May 2021 11:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <YI4AwgZaFSGsTDR9@zeniv-ca.linux.org.uk> <CAHk-=whWm_a5hHr7Xnx8NNQPq5xjs6cS+APE5k_K1K6F8Wq7eQ@mail.gmail.com>
 <20210502175946.GY1847222@casper.infradead.org>
In-Reply-To: <20210502175946.GY1847222@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 May 2021 11:14:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=33579pjCosU6QSEu-=HZo+=mnDdQi7zFLskhi-B-mg@mail.gmail.com>
Message-ID: <CAHk-=wi=33579pjCosU6QSEu-=HZo+=mnDdQi7zFLskhi-B-mg@mail.gmail.com>
Subject: Re: [git pull] work.misc
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 2, 2021 at 11:00 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> I think we have checks that the hw blocksize is a power-of-two (maybe
> just in SCSI?  see sd_read_capacity())

Not the hardware block size: our own fs/buffer.c block size.

I could imagine some fs corruption that causes a filesystem to ask for
something like a 1536-byte block size, and I don't see __bread() for
example checking that 'size' is actually a power of 2.

And if it isn't a power of two, then I see __find_get_block() and
__getblk_slow() doing insane things and possibly even overflowing the
allocated page.

Some filesystems actually start from the blocksize on disk (xfs looks
to do that), and do things like

        sb->s_blocksize = mp->m_sb.sb_blocksize;
        sb->s_blocksize_bits = ffs(sb->s_blocksize) - 1;

and just imagine what happens if the blocksize on disk is 1536... Now,
xfs has a check in the SB validation routine:

            sbp->sb_blocksize != (1 << sbp->sb_blocklog)

and if that fails, it will return -EFSCORRUPTED. But what about other
random filesystems?

Hopefully everybody checks it. But my point is, that passing in "size"
instead of "bits" not only caused this ffs() optimization, it's also a
potential source of subtle problems..

(But it goes back to the dark ages, I'm not blaming anybody but myself).

             Linus
