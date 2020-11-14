Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B032B298D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 01:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgKNAN6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 19:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKNAN6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 19:13:58 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D471C0617A6
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 16:13:56 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id i17so11911869ljd.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 16:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OvZhzUo1BKEAMXk7J8Ec04lI724x0EKAq0CQHylr9Qk=;
        b=P6cesCbv6T5WyCEQ20G2iDas38QZ/BYEKN0z2D/4Rr0ZaXp5OCzkvwAUalCl7xlLJy
         aAByv62DKrnD/Fs9d+pfwMOOqDi/5mvBK7fI8ZM2kpLZkJIDq88qump9IeKexz7S1ono
         ZF4rQ13IKH35+KMT32xMULy9PwmXG6jpi7O1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OvZhzUo1BKEAMXk7J8Ec04lI724x0EKAq0CQHylr9Qk=;
        b=GSG9FJnGzA9FADpk/b0H9GJcUz35nlTmaSf50aswkcfFxWFDqbTzCtzL57+Zxdyv43
         5BNZOfARcma+tQcT0F5IjGv5/khH8FPrSMfqZqMOixJpNS0Xr6WBfGQysheYVav6dCb1
         d2WVqOa+mbFEFHwosDfRBCLEOlE4kiAYr9qi77j+3qmwL8FCM7hwQ17akMTVfxuuXObK
         nAUeW7J0Hpfr1s0kvzmMxheZ+s04w2Vlmq1O9a9iex/GAkUdSjyDaYh07EQpbIoFGl4E
         MOXgvBwol2CP2Eu/hYzBGTZAnsUvFW48uFa22enCrz0n8/RWk5hf7M3IwrVVKbcmzrmx
         HakA==
X-Gm-Message-State: AOAM532yYSxHkh1xhJKPIGXT/dorbeR6FLhBPsfZRq+OQHDmRvQtDgPh
        RrWTddsN/Fj0G1udJoEv3kBgnqe4OpBGLA==
X-Google-Smtp-Source: ABdhPJzmNyJi9jyIPiEVKjoqpk+etkay2rnfy/Zw+6gfd4SuA9IoVtLBB70JguPKbHSifGbYpVSxhA==
X-Received: by 2002:a2e:9048:: with SMTP id n8mr2058103ljg.289.1605312834539;
        Fri, 13 Nov 2020 16:13:54 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id f17sm1546335lfc.158.2020.11.13.16.13.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 16:13:53 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id w142so16644639lff.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 16:13:53 -0800 (PST)
X-Received: by 2002:ac2:598f:: with SMTP id w15mr1675126lfn.148.1605312832994;
 Fri, 13 Nov 2020 16:13:52 -0800 (PST)
MIME-Version: 1.0
References: <20201113233847.GG9685@magnolia>
In-Reply-To: <20201113233847.GG9685@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Nov 2020 16:13:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=whvWbFBr-W8FvAT1_ekuzWk=q_g+6+_h2ChycsW8dMhmw@mail.gmail.com>
Message-ID: <CAHk-=whvWbFBr-W8FvAT1_ekuzWk=q_g+6+_h2ChycsW8dMhmw@mail.gmail.com>
Subject: Re: [GIT PULL] vfs: fs freeze fix for 5.10-rc4
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>, fdmanana@kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 13, 2020 at 3:38 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> Since the hack is unnecessary and causes thread race errors, just get
> rid of it completely.  Pushing this kind of vfs change midway through a
> cycle makes me nervous, but a large enough number of the usual
> VFS/ext4/XFS/btrfs suspects have said this looks good and solves a real
> problem vector, so I'm sending this for your consideration instead of
> holding off until 5.11.

Not a fan of the timing, but you make a good argument, and I love
seeing code removal. So I took it.

And once I took the real code change, the two cleanups looked like the
least of the problem, so I took them too.

I ended up doing it all just as a single pull, since it seemed
pointless to make history more complicated just to separate out the
cleanups in a separate pull.

Now I really hope this won't cause any problems, but it certainly
_looks_ harmless.

          Linus
