Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DEF2DB3C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 19:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731609AbgLOSbH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 13:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731613AbgLOSa7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 13:30:59 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D1BC06179C
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 10:30:18 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id l11so41959387lfg.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 10:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JUaKO/Lg3t9bK9lrn7O7FG8aTeuShLs3+ht+FMmXX74=;
        b=fzvSKFTs/LOWfn8jlcEGcdmHEirilQxn34XJoklgnB/zZ12410gs7DTi8hvyQuOUS6
         oh4Ymfxx7rsp8Bv2uAmZdWJH+pmwDG9THMleBC2FlHUlKeuQB+gZ1sB1v5nfNOfia4GJ
         11bzYUhyEMJfooEuPhDNL9ncKA4O3mAuIKeXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JUaKO/Lg3t9bK9lrn7O7FG8aTeuShLs3+ht+FMmXX74=;
        b=rb6E51ZXVMLFVYPcr9I1J6tQcXwdcCzKf2EZ8dTYiAyAQq5jZ5wCUjfxUxZIZlRPR6
         UP04HRv8oOnEeT8Srn33lUJ/NAZjhzvRkbvPCrh85xNQk+UzIl9wzR+dwe6x+ikTe3VC
         vN6m8qU9LHS2ECWG/Qa7uJoAWMLnXS9jXobXKnFMxUtd3MHJ8IXp39sky2ZRRY9sy87P
         CYGGWORBHNwc9PMx8WXhg9EvlDO5UonSpZkdI9iCF6Jm7zJbFJuxmHTx3suzxzM7nNRK
         cT2QDWlxAprLyVSaOdUwXwQAC8jl45I5Lf9UsOKkqAJkV1fWzZ5bgSZ95/DabTsPhsCH
         TizQ==
X-Gm-Message-State: AOAM533mICHC00lf6tEnTR9XrElMg3Fs78QsqLpGzpdEIjb9qKGsM7mg
        RXQcnEuvBNHZTW9U3ktul5Jq7FEFZZYXDA==
X-Google-Smtp-Source: ABdhPJyjGFxY1OUym+Mel2iuuom9UclsxIqsQcfkEGwshk1Q21yoeeJCgCmS217uweHV+p1fn6VS9w==
X-Received: by 2002:a05:6512:108a:: with SMTP id j10mr9918623lfg.381.1608057016794;
        Tue, 15 Dec 2020 10:30:16 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id v63sm294606lfa.89.2020.12.15.10.30.16
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 10:30:16 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id o17so38991989lfg.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 10:30:16 -0800 (PST)
X-Received: by 2002:a05:6512:338f:: with SMTP id h15mr11157990lfg.40.1608057014922;
 Tue, 15 Dec 2020 10:30:14 -0800 (PST)
MIME-Version: 1.0
References: <20201214191323.173773-1-axboe@kernel.dk> <20201214191323.173773-3-axboe@kernel.dk>
 <20201215122447.GQ2443@casper.infradead.org> <75e7d845-2bd0-5916-ad45-fb84d9649546@kernel.dk>
 <20201215153319.GU2443@casper.infradead.org> <7c2ff4dd-848d-7d9f-c1c5-8f6dfc0be7b4@kernel.dk>
 <4ddec582-3e07-5d3d-8fd0-4df95c02abfb@kernel.dk>
In-Reply-To: <4ddec582-3e07-5d3d-8fd0-4df95c02abfb@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Dec 2020 10:29:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgsdrdep8uT7DiWftUzW5E5tb_b6CRkMk0cb06q3yE_WQ@mail.gmail.com>
Message-ID: <CAHk-=wgsdrdep8uT7DiWftUzW5E5tb_b6CRkMk0cb06q3yE_WQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] fs: add support for LOOKUP_NONBLOCK
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 15, 2020 at 8:08 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> OK, ran some numbers. The test app benchmarks opening X files, I just
> used /usr on my test box. That's 182677 files. To mimic real worldy
> kind of setups, 33% of the files can be looked up hot, so LOOKUP_NONBLOCK
> will succeed.

Perhaps more interestingly, what's the difference between the patchset
as posted for just io_uring?

IOW, does the synchronous LOOKUP_NONBLOCK actually help?

I'm obviously a big believer in the whole "avoid thread setup costs if
not necessary", so I'd _expect_ it to help, but maybe the possible
extra parallelism is enough to overcome the thread setup and
synchronization costs even for a fast cached RCU lookup.

(I also suspect the reality is often much closer to 100% cached
lookups than just 33%, but who knows - there are things like just
concurrent renames that can cause the RCU lookup to fail even if it
_was_ cached, so it's not purely about whether things are in the
dcache or not).

              Linus
