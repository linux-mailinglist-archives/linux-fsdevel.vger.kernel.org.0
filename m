Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83F35AC7DF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2019 19:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395097AbfIGRGO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Sep 2019 13:06:14 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46883 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389011AbfIGRGO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Sep 2019 13:06:14 -0400
Received: by mail-lf1-f68.google.com with SMTP id t8so7418217lfc.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Sep 2019 10:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VaxRwZcXIqBCeM77ijL8A1h5NduVbQyHYByckmz1gJk=;
        b=Ldlyq4Px8HcWw652TFUFBz92WQlbW6hSwxMlCjQQ7ArJ4KZCkRlTmS1rpYbWoVnDTP
         m2fPZeqordNjkxzXe2jf1KmkqKcGf1nJr407YEJX5jdvDfinEa81A2+g7kiafJJQtJkb
         2rcL8ecVWF8zjmoPoJgLSziuzeA0NFXkftsDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VaxRwZcXIqBCeM77ijL8A1h5NduVbQyHYByckmz1gJk=;
        b=eFK7577g5SAOCd/3z7Y+Ip9L6Y039GAgOsrpXHqrig7cDWEtsdtvHfvFnI705miotx
         Y9V4W33ve0IT+LfXhXq5/38JB04c5GNNLiniuFjH4oujfW+IR/isiU50JwnKv/lV8lAD
         KXh64310KBE1hz+bSdJtwGyz0gz4mUs8t34kW9guRDNPs2upo4sMSI9DOUpetMadRh7Q
         Qr2CzkWVStcCsHXBSuAi9MuweR/AR0MNVxBRoCqOWkvmAqdQE1pm6jMovQMZ/Sf7uudi
         mCjaOiTeH2cQRkMWaOk/tJLpKB+FZs9H/6XJZhUpCtbPpXLIeI1yM1P2NDY29w5QpKeZ
         Gydg==
X-Gm-Message-State: APjAAAWv8dAtCSNrCFv5LM2WNKB7y+ysuQcPKkRtYnjoMofKxpo2j6HC
        T+Uh0sD4oPQ4LS8CR9qvcLRcrGkIFSs=
X-Google-Smtp-Source: APXvYqyywCFX+zRCkQ9bU+IlF/DGep2AgHRReFcm8TPi4ADH0FycY2P3PN3mddWVcVqVDJhKM7ahng==
X-Received: by 2002:ac2:4289:: with SMTP id m9mr9447003lfh.139.1567875972288;
        Sat, 07 Sep 2019 10:06:12 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id v10sm1547159ljc.64.2019.09.07.10.06.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Sep 2019 10:06:12 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id x80so7460037lff.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Sep 2019 10:06:11 -0700 (PDT)
X-Received: by 2002:a19:f204:: with SMTP id q4mr5583225lfh.29.1567875518853;
 Sat, 07 Sep 2019 09:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190904201933.10736-1-cyphar@cyphar.com> <20190904201933.10736-12-cyphar@cyphar.com>
 <7236f382d72130f2afbbe8940e72cc67e5c6dce0.camel@kernel.org>
In-Reply-To: <7236f382d72130f2afbbe8940e72cc67e5c6dce0.camel@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Sep 2019 09:58:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZx97Nm-gUK0ppofj2RA2LLz2vmaDUTKSSV-+yYB9q_Q@mail.gmail.com>
Message-ID: <CAHk-=whZx97Nm-gUK0ppofj2RA2LLz2vmaDUTKSSV-+yYB9q_Q@mail.gmail.com>
Subject: Re: [PATCH v12 11/12] open: openat2(2) syscall
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian@brauner.io>,
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
        Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
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

On Sat, Sep 7, 2019 at 5:40 AM Jeff Layton <jlayton@kernel.org> wrote:
>
> After thinking about this a bit, I wonder if we might be better served
> with a new set of OA2_* flags instead of repurposing the O_* flags?

I'd hate to have yet _another_ set of translation functions, and
another chance of people just getting it wrong either in user space or
the kernel.

So no. Let's not make another set of flags that has no sane way to
have type-safety to avoid more confusion.

The new flags that _only_ work with openat2() might be named with a
prefix/suffix to mark that, but I'm not sure it's a huge deal.

                 Linus
