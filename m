Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451631C5DE0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 18:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgEEQw3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 12:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729720AbgEEQw2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 12:52:28 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F37C061A0F
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2020 09:52:28 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h4so2352284ljg.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 09:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9hFXujfAx2/iHidBrnKhRaNUObDjx6hbclJAooxUbFo=;
        b=eb7GI2X/XrhuAn2Vm+U9831w2ibE6cHnWF7F9S99pPGIKJ581y9sIjG0fOlnKnr8XU
         3l3RpH6pJHtIm3ZTaZWOJ1vg4eqLgQyIQUJKPk6h3hKYNOZAM/NKILDQePeV8IKRtcTz
         txmKNoel5w65lmX1pdFQXgC+9b7bhZqgRSUAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9hFXujfAx2/iHidBrnKhRaNUObDjx6hbclJAooxUbFo=;
        b=tUNcILN5ZODQw++7RaSLPSIWiOS3ky0gdi+JTtowDuagQ0VrCH2h+qqsoEYvtXrEK6
         BFWg86yjEYZaYntgAswZFh4ecLs6mbMhE+xTiVYKgA6rvJbEboYYdLlC3p8jARVuwJ7w
         JOpVxA0sl7nNPQHH+ZWFWTabTK8ZiI/3RKWP6FXGew2Qc4BPIVfQNJi3CpUYg6cbEzSh
         6futgAy+qOpgWGXDdAGbJbD0M/WMTLAvFPbsAMzuDT4hJFTMBMH2S6pyRPkmQe0n7zCe
         Fkjit4g1OTogVI1m6Tet5KhNtlpR8j9HWnvFWRf7s2DX8t3jDci0HH5AYhgzRmoJwlPO
         uQaw==
X-Gm-Message-State: AGi0PuYKfrhqf3bSVAFAC52ckPiy5jrPvFXOUy5Xx3KsNCoLm3D5ZoOw
        XSmouBLuoNkO/GOda+FOVIdoaWSQ0eI=
X-Google-Smtp-Source: APiQypKWwhCUvON9U0Skfi/TvVrzscO7iL8m1Q7Fvb7jnZjfzdSFv0WAHS+ALXr6L4KcmSpRwVjbKw==
X-Received: by 2002:a2e:7815:: with SMTP id t21mr2403142ljc.146.1588697543000;
        Tue, 05 May 2020 09:52:23 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id d23sm2632887ljg.90.2020.05.05.09.52.21
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 09:52:21 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id u15so2374213ljd.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 09:52:21 -0700 (PDT)
X-Received: by 2002:a2e:87d9:: with SMTP id v25mr2307697ljj.241.1588697540733;
 Tue, 05 May 2020 09:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200505101256.3121270-1-hch@lst.de>
In-Reply-To: <20200505101256.3121270-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 May 2020 09:52:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgrHhaM1XCB=E3Zp2Br8E5c_kmVUTd5y06xh5sev5nRMA@mail.gmail.com>
Message-ID: <CAHk-=wgrHhaM1XCB=E3Zp2Br8E5c_kmVUTd5y06xh5sev5nRMA@mail.gmail.com>
Subject: Re: remove set_fs calls from the coredump code v6
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 5, 2020 at 3:13 AM Christoph Hellwig <hch@lst.de> wrote:
>
> this series gets rid of playing with the address limit in the exec and
> coredump code.  Most of this was fairly trivial, the biggest changes are
> those to the spufs coredump code.

Ack, nice, and looks good.

The only part I dislike is how we have that 'struct compat_siginfo' on
the stack, which is a huge waste (most of it is the nasty padding to
128 bytes).

But that's not new, I only reacted to it because the code moved a bit.
We cleaned up the regular siginfo to not have the padding in the
kernel (and by "we" I mean "Eric Biederman did it after some prodding
as part of his siginfo cleanups" - see commit 4ce5f9c9e754 "signal:
Use a smaller struct siginfo in the kernel"),  and I wonder if we
could do something similar with that compat thing.

128 bytes of wasted kernel stack isn't the end of the world, but it's
sad when the *actual* data is only 32 bytes or so.

                Linus
