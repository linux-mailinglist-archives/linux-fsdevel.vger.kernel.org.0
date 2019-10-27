Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD42E6267
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2019 13:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfJ0MML (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Oct 2019 08:12:11 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45248 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbfJ0MML (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Oct 2019 08:12:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id q64so8368580ljb.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Oct 2019 05:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Zr1M0nCXlilSobwLkNmgKE2widPtGkZk30ZqC0Jsp4=;
        b=d3QTzyBq1ltmtg4yGSZr5XtauvY/fALYcdqhiDEtFOl1dE9JCqjexjO52exODJRIVQ
         Eh2Een6o4qvZdUFz/jDS+JnTxGr7PmGqPX7rFmA4YZFRZjrNKL/JZDN1nI+V4NXXs/c+
         Hp/xfBUyMptBO5mKJ7+YknkxBRlijCGcU26uA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Zr1M0nCXlilSobwLkNmgKE2widPtGkZk30ZqC0Jsp4=;
        b=BCMyRl1InJ0LczLIdd1lKMRqOfppJFaW3Vs79XeidfBDNR5PF4JhdLLmsCv+dpVWpH
         7hXBnpqqKOiSVxrJuK1dVWr9exRP+uOu7iCpalmIystod0RgbmW4QZ8KfpMFvlfkS/Qb
         JmJj535BF9YTcvK3iOVkk8vGOumYcDM7iKJOFR4gvityLGKek5zqwSC0NT5zJobxY6e8
         ex8XkaUUDTOiJ6NBYRmRQNGowjWwaA2nXEQ7fx/Ain0U7+690VqaVqhqIIpx7gWbPyPq
         MGPDlQXRFd3B08REE5WBIajuavVPv132JlNAb+ag0tTFx6vhV3jhF+5opbyqf+Vmxe7n
         u7zg==
X-Gm-Message-State: APjAAAWSzIuL1cP0reZ7KwTUwbPb0Ne2PG5rbv03rhKu0UXxFf9B9Ivv
        Z2uFh+uZdR0vp2FhryD+nkIqNP2KQ4ewZA==
X-Google-Smtp-Source: APXvYqyNmAy+DNpNivXAgSrf+Nrx5Iad3KTVGItpwCgnCCm9BVCcaO82ChhyPDYSdSKWj6cFvPxnkw==
X-Received: by 2002:a05:651c:120f:: with SMTP id i15mr8771701lja.144.1572178327418;
        Sun, 27 Oct 2019 05:12:07 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id b67sm8350546ljf.5.2019.10.27.05.12.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2019 05:12:07 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id y127so5697243lfc.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Oct 2019 05:12:06 -0700 (PDT)
X-Received: by 2002:a19:5504:: with SMTP id n4mr8268196lfe.106.1572177927159;
 Sun, 27 Oct 2019 05:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191026185700.10708-1-cyphar@cyphar.com> <20191026185700.10708-3-cyphar@cyphar.com>
In-Reply-To: <20191026185700.10708-3-cyphar@cyphar.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Oct 2019 08:05:11 -0400
X-Gmail-Original-Message-ID: <CAHk-=wjPPWvm5_eR4uaHJaU1isTUk-4iXQV3Z2Px9A+w6j2nHg@mail.gmail.com>
Message-ID: <CAHk-=wjPPWvm5_eR4uaHJaU1isTUk-4iXQV3Z2Px9A+w6j2nHg@mail.gmail.com>
Subject: Re: [PATCH RESEND v14 2/6] namei: LOOKUP_IN_ROOT: chroot-like path resolution
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 26, 2019 at 2:58 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> +       /* LOOKUP_IN_ROOT treats absolute paths as being relative-to-dirfd. */
> +       if (flags & LOOKUP_IN_ROOT)
> +               while (*s == '/')
> +                       s++;
> +
>         /* Figure out the starting path and root (if needed). */
>         if (*s == '/') {
>                 error = nd_jump_root(nd);

So I'm still hung up on this.

I guess I can't help it, but I look at the above, and it makes me go
"whoever wrote those tests wasn't thinking".

It just annoys me how it tests for '/' completely unnecessarily.

If LOOKUP_IN_ROOT is true, we know the subsequent test for '/' is not
going to match, because we just removed it. So I look at that code and
go "that code is doing stupid things".

That's why I suggested moving the LOOKUP_IN_ROOT check inside the '/' test.

Alternatively, just make the logic be

        if (flags & LOOKUP_IN_ROOT) {
               .. remove '/'s ...
        } else if (*s == '/') {
                .. handl;e root ..

and remove the next "else" clause

    Linus
