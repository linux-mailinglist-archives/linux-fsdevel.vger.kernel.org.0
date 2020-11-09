Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BE02AC4F9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 20:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbgKIT3U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 14:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730625AbgKIT3U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 14:29:20 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF9EC0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 11:29:18 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 10so602993wml.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2020 11:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g3t2mYFKIlARiFeH9MBPqJYZ+kT/dBwAmQ+f/c8Jq7A=;
        b=OqD2GK3dPuexdvL2K5GPzrrVOwk0AYRFBQGs5c1Fjht6tM4ImOXZ0plDlFX2zAMW43
         t3vWDN2I1jroBIs+LEUYF7Updth3lgkkky3/aryosLZ4Q8sBoYu+fAQefqdGiT4Sk3K1
         NPVt3UevY3s8ljxQb3xkZY7fWjiq+oDWQhEQsaIXGa0GcdIBkxVoFUjh9sg2eZKbZ2qE
         G42RG6NmaHP6XKL8eVAZMgNL6ccOlTP08PdlMM3wxI+1tFhZ8MZJPA+SPSOCUrx9KEYj
         HoZ9D+xLo52CKhiwCJyy0c6pf7yjGYjTozjdgZVcHJfwbwrnwWw0hOzwrrA27A39Ge6B
         K1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g3t2mYFKIlARiFeH9MBPqJYZ+kT/dBwAmQ+f/c8Jq7A=;
        b=S2at5qwHWzf2EUrlm4wAmREZGYCuChCWu7rWCwSFGGAYtA6klUYr4NfEd81qpfcpD0
         xfT9PSrmsMIejxCu14ewbC7Ic2X1sjjycciuYpzJ9aIav6z71DANk4y6MR9fp8/CTo4H
         NrsVs5jNRCMcgBdT+yx4HMb23zLDIeg/I7/KgDfZ/gb2hYGG9HXTjRgCtDTeE6T60Vei
         BeKTAXHIcoGY0PtQOSS97mk6R5HbhATpVGshn2gag8G8KltEmN03P22fbXX1vHP9xpfz
         mJo5Sf0ERZcgsy7l13eg/2j4Mc3GYiRsZfLID8/KUxxUO1sTubGyO63C11Pe7hHasPyt
         nC8w==
X-Gm-Message-State: AOAM533O9RHNyFSfPW7C3gQPPrKcDN4GFbGqpt22HmZG1Rk4hDtDa7UH
        2LIct1vXG48O3KI5q7UCc8Le1ifjl9v+v2WKaCMM1nGaqZiGfQ==
X-Google-Smtp-Source: ABdhPJwJBE5jtx2TtnUpR7db2Uf+WVRTejsn7ED5GK8x6ks4qTEG+p3r8hxQe2e0ApkkZXobkfn5Smh2zCKUOJjr3wI=
X-Received: by 2002:a1c:4944:: with SMTP id w65mr807327wma.50.1604950156971;
 Mon, 09 Nov 2020 11:29:16 -0800 (PST)
MIME-Version: 1.0
References: <20201106231635.3528496-1-soheil.kdev@gmail.com>
 <20201107174343.d94369d044c821fb8673bafd@linux-foundation.org>
 <CACSApva7rcbvtSyV6XY0q3eFQqmPXV=0zY9X1FPKkUk-hSodpA@mail.gmail.com> <20201109185940.logxhnbe4wjotgkb@linux-p48b.lan>
In-Reply-To: <20201109185940.logxhnbe4wjotgkb@linux-p48b.lan>
From:   Soheil Hassas Yeganeh <soheil@google.com>
Date:   Mon, 9 Nov 2020 14:28:40 -0500
Message-ID: <CACSApvaG7uJDeoaPdSuLAoEgZK2YQHRn34hBQyk4y+5uH86cMA@mail.gmail.com>
Subject: Re: [PATCH 0/8] simplify ep_poll
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        Guantao Liu <guantaol@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 9, 2020 at 2:22 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> On Sat, 07 Nov 2020, Soheil Hassas Yeganeh wrote:
> >FWIW, I also stress-tested the patch series applied on top of
> >linux-next/master for a couple of hours.
>
> Out of curiosity, what exactly did you use for testing?

That's a good question. I ran two flavors of tests:
- The epoll_wakeup_test selftest in a tight loop on two different
CPUs. This includes the newly added epoll61 test case for the timeout
race.
- Internal production loadtests (i.e., multi-node benchmarks).

Thanks,
Soheil

> Thanks,
> Davidlohr
