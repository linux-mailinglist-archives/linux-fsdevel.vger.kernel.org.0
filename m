Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E50A2A16C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2019 00:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbfEXW7l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 May 2019 18:59:41 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45090 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfEXW7l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 May 2019 18:59:41 -0400
Received: by mail-lj1-f193.google.com with SMTP id r76so4534300lja.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 May 2019 15:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pQINizPFkNPnto59K0HZACSWR9ngvO3M7aOeMX8dPW8=;
        b=GmxgEiG+jMRxi4LmBi9k7J2C8n7RpiC2NBCZ3DLX08K85gcoyywZ4tl+P32/mMwcqG
         O4Y184LyNs6/HdVttJYg26SnTEZenmTPwRlWi8OYmFedIXmlG1SXqhBugOdxMaqrphSg
         0/iJn6C0x9KeeqMxCK7RF+v4pYfhlNizqxwtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pQINizPFkNPnto59K0HZACSWR9ngvO3M7aOeMX8dPW8=;
        b=Ew5Xxbz+PpN9iS5jNpCprSkaTqGToBtBsLN99DM43neoXBytEu3smZPv8k4+lYBXc1
         7Ir0oqYYNP4qELaip7rqBBrqqWsDKYS+iK5CSEDx24R+zuVbz0SbmUVnUiJt5HsleXra
         LzX9Q6TnJH17SPSBIpDYIah0jRsbtV0kmQdCVi0vbmZG/RxDkFKBB7f/7zxBSnJgyK+R
         xdec032fGTt36NDGem0rRN0b4T4ORcBQzMWUQTf92t8+2FydXPaLWKr0BNlQFrTx7eEO
         +mqyssm7kkmGW6L7skFG/wAyUblOnTkCxpleuaPC1/dQBMAtEABtlOLc0kR2+uShZ53C
         f7Fw==
X-Gm-Message-State: APjAAAXPFurmVJGgPKXTQTSoGl4vmszWhr1TWjzD7sHKdMVlYJmSKqRs
        +CBWqy6C7fOoB5sl8lmSdDU9JhD2hpg=
X-Google-Smtp-Source: APXvYqzfhaKNJ4mXS8RzmTEHzcfRsXzt600pgw3JidKJ33+ucb6bPOiIaatQWpEOXHhXCRHmwZqcmA==
X-Received: by 2002:a2e:8644:: with SMTP id i4mr12096306ljj.0.1558738778127;
        Fri, 24 May 2019 15:59:38 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id w19sm807279lfk.56.2019.05.24.15.59.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 15:59:35 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id r76so4534236lja.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 May 2019 15:59:35 -0700 (PDT)
X-Received: by 2002:a2e:97d8:: with SMTP id m24mr44440219ljj.52.1558738775052;
 Fri, 24 May 2019 15:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190507164317.13562-1-cyphar@cyphar.com> <20190507164317.13562-6-cyphar@cyphar.com>
In-Reply-To: <20190507164317.13562-6-cyphar@cyphar.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 May 2019 15:59:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbFMg4+HuWOBuHpvDNiAyowX2HUowv3+pt8vPWk5W-YQ@mail.gmail.com>
Message-ID: <CAHk-=whbFMg4+HuWOBuHpvDNiAyowX2HUowv3+pt8vPWk5W-YQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] namei: resolveat(2) syscall
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 7, 2019 at 9:44 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> The most obvious syscall to add support for the new LOOKUP_* scoping
> flags would be openat(2) (along with the required execveat(2) change
> included in this series). However, there are a few reasons to not do
> this:

So honestly, this last patch is what turns me off the whole thing.

It goes from a nice new feature ("you can use O_NOSYMLINKS to disallow
symlink traversal") to a special-case joke that isn't worth it any
more. You get a useless path descrptor back from s special hacky
system call, you don't actually get the useful data that you probably
*want* the open to get you.

Sure, you could eventually then use a *second* system call (openat
with O_EMPTYPATH) to actually get something you can *use*, but at this
point you've just wasted everybodys time and effort with a pointless
second system call.

So I really don't see the point of this whole thing. Why even bother.
Nobody sane will ever use that odd two-systemcall model, and even if
they did, it would be slower and inconvenient.

The whole and only point of this seems to be the two lines that say

       if (flags & ~VALID_RESOLVE_FLAGS)
              return -EINVAL;

but that adds absolutely zero value to anything.  The argument is that
"we can't add it to existing flags, because old kernels won't honor
it", but that's a completely BS argument, since the user has to have a
fallback anyway for the old kernel case - so we literally could much
more conveniently just expose it as a prctl() or something to _ask_
the kernel what flags it honors.

So to me, this whole argument means that "Oh, we'll make it really
inconvenient to actually use this".

If we want to introduce a new system call that allows cool new
features, it should have *more* powerful semantics than the existing
ones, not be clearly weaker and less useful.

So how about making the new system call be something that is a
*superset* of "openat()" so that people can use that, and then if it
fails, just fall back to openat(). But if it succeeds, it just
succeeds, and you don't need to then do other system calls to actually
make it useful.

Make the new system call something people *want* to use because it's
useful, not a crippled useless thing that has some special case use
for some limited thing and just wastes system call space.

Example *useful* system call attributes:

 - make it like openat(), but have another argument with the "limit flags"

 - maybe return more status of the resulting file. People very
commonly do "open->fstat" just to get the size for mmap or to check
some other detail of the file before use.

In other words, make the new system call *useful*. Not some castrated
"not useful on its own" thing.

So I still support the whole "let's make it easy to limit path lookup
in sane ways", but this model of then limiting using the result sanely
just makes me a sad panda.

                     Linus
