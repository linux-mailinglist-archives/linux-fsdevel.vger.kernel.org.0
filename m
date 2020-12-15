Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192972DB482
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 20:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgLOTcx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 14:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgLOTcw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 14:32:52 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4A9C0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 11:32:37 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id o17so39455922lfg.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 11:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NVsit2mokWVZQH87T2Lx+YeIiB1t/ENUqRoyfIHGJRc=;
        b=WM/vWZWqtGwwTSDWwgxgfjaGN86tfM0uyZzv0dyXEEytopWfBLq7NoaAoi1TixXa2a
         5y8pqd70b6vHkxv9Mn0BnJ22rXU87lRnLlGkF+pmJBLeeVCaZc7yyGt1dZxzcVHMZkWI
         7SFpa/W1+SDmbqJn7/NHKJeLXeyJQlp+EDxrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NVsit2mokWVZQH87T2Lx+YeIiB1t/ENUqRoyfIHGJRc=;
        b=NtRBH5kcXUvGbxmaJF4LylTUChd1RE08mNei1JPtNaQvRlQQTlPzjxVYUuF087weg3
         gHKXFt9sbbOe7NxTwftMbS8ttGnTsQ2aRAdbyzImlzCHObSVY2rZPId4qqRTQY0M6Zgn
         /3LdrDWuoYeK0Cm0u1XTr2PLqXYrLg/lOwnkCruNyBdX933ndsoOpTLiCSMfxZeMRAUa
         C4bAEa75ht8MeA7jUudnwAPwGtooWxj2kLWh9Irkjn77Yfeg/vPPksvBtdIQ2wjuADaI
         948WKKWva2qgjPaEr0g8kCIKEspcLeKuR9UjVRfuwDop5e7H3GW1mw7obD8QP1f9pQzv
         FzwA==
X-Gm-Message-State: AOAM533/NVIdW2SySG1fQXh2ijMdTwKvxXWJHcgIgz9/mOBcWDZ0GVAz
        5O4yCrukKsasrEfKezD1eEJceAs7+hvsvQ==
X-Google-Smtp-Source: ABdhPJwgyj0dLjg70XXgyPWegoV+ffEUyd4YUX7xoCgCw1Kc7ppZaaw4O26g6O30YyTNVZHucpcl0g==
X-Received: by 2002:a05:651c:112c:: with SMTP id e12mr9405585ljo.66.1608060755679;
        Tue, 15 Dec 2020 11:32:35 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id s27sm2187324ljd.25.2020.12.15.11.32.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 11:32:33 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id y19so42333548lfa.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 11:32:32 -0800 (PST)
X-Received: by 2002:a05:6512:338f:: with SMTP id h15mr11238624lfg.40.1608060752624;
 Tue, 15 Dec 2020 11:32:32 -0800 (PST)
MIME-Version: 1.0
References: <20201214191323.173773-1-axboe@kernel.dk> <20201214191323.173773-3-axboe@kernel.dk>
 <20201215122447.GQ2443@casper.infradead.org> <75e7d845-2bd0-5916-ad45-fb84d9649546@kernel.dk>
 <20201215153319.GU2443@casper.infradead.org> <7c2ff4dd-848d-7d9f-c1c5-8f6dfc0be7b4@kernel.dk>
 <4ddec582-3e07-5d3d-8fd0-4df95c02abfb@kernel.dk> <CAHk-=wgsdrdep8uT7DiWftUzW5E5tb_b6CRkMk0cb06q3yE_WQ@mail.gmail.com>
 <01be1442-a4d1-6347-f955-3a28a8d253e7@kernel.dk> <CAHk-=wgyKDvLhiKfQ1xvBxFkD_+v_SCmMeJvzNJ_maibWH6QRQ@mail.gmail.com>
 <5e9f9121-68dd-81a1-38b7-8e1b4fd0cf0f@kernel.dk>
In-Reply-To: <5e9f9121-68dd-81a1-38b7-8e1b4fd0cf0f@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Dec 2020 11:32:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgdcShySTmDbpwDiDQvDifLNN9XPjqw7BPij0YT4-z6sw@mail.gmail.com>
Message-ID: <CAHk-=wgdcShySTmDbpwDiDQvDifLNN9XPjqw7BPij0YT4-z6sw@mail.gmail.com>
Subject: Re: [PATCH 2/4] fs: add support for LOOKUP_NONBLOCK
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 15, 2020 at 11:03 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> And for comparison, doing the same thing with the regular openat2()
> system call takes 867,897 usec.

Well, you could always thread it. That's what git does for its
'stat()' loop for 'git diff' and friends (the whole "check that the
index is up-to-date with all the files in the working tree" is
basically just a lot of lstat() calls).

           Linus
