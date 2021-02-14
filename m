Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAA931B267
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Feb 2021 21:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhBNU3M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Feb 2021 15:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhBNU3I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Feb 2021 15:29:08 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E8FC061574
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Feb 2021 12:30:28 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id w36so7262302lfu.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Feb 2021 12:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dEkKTI4oJCma89NGt4Bf7fZ9GE5eDUn5eT/B/RVlx48=;
        b=H3NNB6ah4SIc7SfyTIyox1GATsXb4EFOHCxuJy12gRl4wZ94vpweouORQgOQrOhpSo
         d+feQep8L0CiTkQqR5N7zIlb03DQJwAZUt9RXQjebqAoAU5hB8c1v36z/X6plnkL+0TZ
         mX7rXiZpLZTHHSKjSSr6Jl9/noz9Imnm8nwXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dEkKTI4oJCma89NGt4Bf7fZ9GE5eDUn5eT/B/RVlx48=;
        b=mVuSO7duSwJwSgbWT0dMuyl6cn+QaaljEZ7c8qVL1wPltydzZoiY3m/0/x/r6rN1hl
         HeP+6cDNkS9xfi5gCeVcEVIGF/I3/imAYg/e95TpAPBXswfZF4nMHwdlZRtzChzlq8ra
         wNG+k1PC8sNUOo3DLQ0qvdt2DB6Y5AXKUSlMiws6dNbqNABoV6ufkj01fh7/SgcsED/b
         yVZ3qDPidpjG5zk2TpZ/FWEkhfY2EYB5TFvFBMVejW9A+Pjx2XgQp74+mO/kb7kspj9H
         qdsro+VNXQ6FH4CxD7HOiHhlSwplVHrWrcqfKn+YI3uylV0nYIn/e2/owOAWBMCoNaXV
         dq4Q==
X-Gm-Message-State: AOAM531tTBgDLQ2uMzDcVATMuTI5ZRYuem4SyGe1AO8ycSh01mo2AZjV
        ouU/ijASdyF7skPeTgA9FQ03uOJZnnWmdA==
X-Google-Smtp-Source: ABdhPJyo0Uh/7dxyNyDeyWHlCbytxdFPEYzGvy/y0f2jH7VXKBqvCvA5/1dZrSkgtHjBp5I0QIVWJw==
X-Received: by 2002:a05:6512:32a2:: with SMTP id q2mr7558424lfe.237.1613334624756;
        Sun, 14 Feb 2021 12:30:24 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id a9sm199152ljn.129.2021.02.14.12.30.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Feb 2021 12:30:23 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id a17so5470756ljq.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Feb 2021 12:30:23 -0800 (PST)
X-Received: by 2002:a2e:3910:: with SMTP id g16mr3283091lja.61.1613334623116;
 Sun, 14 Feb 2021 12:30:23 -0800 (PST)
MIME-Version: 1.0
References: <20201214191323.173773-1-axboe@kernel.dk> <m1lfbrwrgq.fsf@fess.ebiederm.org>
 <94731b5a-a83e-91b5-bc6c-6fd4aaacb704@kernel.dk>
In-Reply-To: <94731b5a-a83e-91b5-bc6c-6fd4aaacb704@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Feb 2021 12:30:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiZuX-tyhR6rRxDfQOvyRkCVZjv0DCg1pHBUmzRZ_f1bQ@mail.gmail.com>
Message-ID: <CAHk-=wiZuX-tyhR6rRxDfQOvyRkCVZjv0DCg1pHBUmzRZ_f1bQ@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/4] fs: Support for LOOKUP_NONBLOCK /
 RESOLVE_NONBLOCK (Insufficiently faking current?)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 14, 2021 at 8:38 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> > Similarly it looks like opening of "/dev/tty" fails to
> > return the tty of the caller but instead fails because
> > io-wq threads don't have a tty.
>
> I've got a patch queued up for 5.12 that clears ->fs and ->files for the
> thread if not explicitly inherited, and I'm working on similarly
> proactively catching these cases that could potentially be problematic.

Well, the /dev/tty case still needs fixing somehow.

Opening /dev/tty actually depends on current->signal, and if it is
NULL it will fall back on the first VT console instead (I think).

I wonder if it should do the same thing /proc/self does..

           Linus
