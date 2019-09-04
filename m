Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67576A953A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 23:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbfIDVfp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 17:35:45 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45892 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfIDVfp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 17:35:45 -0400
Received: by mail-lf1-f66.google.com with SMTP id r134so174302lff.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2019 14:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uwuNMQc72pWyQK8TRg0HstY3l1Ai6DJhnuFaRewpYp4=;
        b=UP6KagylPWKv8Byd7UP6AZwOW79kEJrWCRQxdYQs3r+rkYYHaRtzINkvSv7M05KzA6
         ZrkfCbIxdXLJg806nwevShkWeJseq5zYukSmtR6H1DU8VX49HoqAiZNvCj+iW0/x6oAZ
         eynsh3dcmA1ab+qwfUmxb81iuiDdfGEMPS8+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uwuNMQc72pWyQK8TRg0HstY3l1Ai6DJhnuFaRewpYp4=;
        b=D+mrTmJQVfPyPSPxCi4P5o1T/js6KDzhzad6HreAQZQD+TNaBvt8QJy8Z4ItVilIDu
         ygbXo8AHRMzeppWPiE/rG3qJZIOhMobA6xXt9CuwqCy52DlFeTZuvaML7t2n20Njx5Ec
         dOGnrQ4mNN8k85Sw2A/13O3dnh5QGoht1brHOEwPnBsO3svi7O8fMgWnOcUDYOXzo7A5
         jMSkYzBG3U5cQWd7M2cCarKdQWlcHT/2s+iMRi6qGz5kWVqLUspXzhUDl5r+nw4/ZQdY
         x1K4woB+cxqnpvmK871whPDMN8yTxZ947ijjCqxp+/BTmYlvpjh0jR/wTIw5JjFjBpey
         oE0Q==
X-Gm-Message-State: APjAAAVrQNWskyD7n40eaub6JSW+qTeKpJn9fb7gGHfXLnF2zG/W4gbr
        7ulFEPbKTX28PqCAhlP7X1gqaOF0pWE=
X-Google-Smtp-Source: APXvYqz/JIeevv8pUIOJvkWDBJ+2i78m6dz7Y4CHkc7ddLD5G3WsA7WOrBJ2EokkWQyz/3iJPAvTow==
X-Received: by 2002:a19:7413:: with SMTP id v19mr151265lfe.176.1567632942574;
        Wed, 04 Sep 2019 14:35:42 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id m23sm10552lfl.62.2019.09.04.14.35.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2019 14:35:41 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id u14so185636ljj.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2019 14:35:40 -0700 (PDT)
X-Received: by 2002:a2e:3c14:: with SMTP id j20mr10927110lja.84.1567632938615;
 Wed, 04 Sep 2019 14:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190904201933.10736-1-cyphar@cyphar.com> <20190904201933.10736-11-cyphar@cyphar.com>
 <CAHk-=wiod1rQMU+6Zew=cLE8uX4tUdf42bM5eKngMnNVS2My7g@mail.gmail.com>
In-Reply-To: <CAHk-=wiod1rQMU+6Zew=cLE8uX4tUdf42bM5eKngMnNVS2My7g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 Sep 2019 14:35:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHRW3Z9xPRiExi9jLjB0cdGhM=3vaW+b80mjuRcbORyw@mail.gmail.com>
Message-ID: <CAHk-=wiHRW3Z9xPRiExi9jLjB0cdGhM=3vaW+b80mjuRcbORyw@mail.gmail.com>
Subject: Re: [PATCH v12 10/12] namei: aggressively check for nd->root escape
 on ".." resolution
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
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
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

On Wed, Sep 4, 2019 at 2:09 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So you'd have three stages:
>
>  1) ".." always returns -EXDEV
>
>  2) ".." returns -EXDEV if there was a concurrent rename/mount
>
>  3) ".." returns -EXDEV if there was a concurrent rename/mount and we
> reset the sequence numbers and check if you escaped.

In fact, I wonder if this should return -EAGAIN instead - to say that
"retrying may work".

Because then:

> Also, I'm not 100% convinced that (3) is needed at all. I think the
> retry could be done in user space instead, which needs to have a
> fallback anyway. Yes? No?

Any user mode fallback would want to know whether it's a final error
or whether simply re-trying might make it work again.

I think that re-try case is valid for any of the possible "races
happened, we can't guarantee that it's safe", and retrying inside the
kernel (or doing that re-validation) could have latency issues.

Maybe ".." is the only such case. I can't think of any other ones in
your series, but at least conceptually they could happen. For example,
we've had people who wanted pathname lookup without any IO happening,
because if you have to wait for IO you could want to use another
thread etc if you're doing some server in user space..

                     Linus
