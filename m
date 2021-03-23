Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7A63453B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 01:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhCWAOV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 20:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhCWAN6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:13:58 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4DEC061764
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 17:13:56 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a1so23357547ljp.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 17:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0Zv/Nh1NwdjT4vNoEgAKJF0+3Ir6H8KTDS01ZyTPf3o=;
        b=MYfMpOlaWILZRe1pDeuZweAI3vdknsgeo67laT+dKd7DkSPJ3kqkICjvz6DoYVVnHZ
         16OeAVHxuQfaEw3tjPMoe7QoNfBgXwLH10I06HQvLQrqH5L2JNBJAwiEQ2JR4BIEX+9S
         mKRD0C7UQTjhxOy/6H8fA1YjCpW2EGV+O/1qAjuqnz/pmrLszTPkOjvS0yYpv/ZZ/qEF
         lAjiGv9YsocO9v0uFbeqK3kItyVLmzZ8XbFjbvISEZUv72q4Dv/aYT92AgSreyZJuLpZ
         d2c1Ghef/K4UviwHxjZHI5pznTsVIQq7ZchuSPAoEZC7/qFfjBKUTKzfd7IBKdOJs9LE
         ySlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0Zv/Nh1NwdjT4vNoEgAKJF0+3Ir6H8KTDS01ZyTPf3o=;
        b=cs71PVRp47xXzcNUZA/JjzUaytdAvY1aw+++61Wg6ZQ8z0q/sMxWF1rVeO+pR3WufV
         WEXk9BQyqpGf/7/dinVsgUhFz7I156J3FA5J/aY07lX4khBbLLCwEMSHJ05zeHnHkuwn
         HbK+0Or/sdLsb7XTyjOgse7REloBtz/hCRXkNIa8EHmK0/qg0nV4fp7ocyX8Ojsxyl1C
         OITK1yy6su0QO8MZX+9NbUTQfw73j95f4i+wFUVcgnO9kRosekXxM5Bv8ekzIcKtPG02
         gaPm0mO60CxGeL2FFCDzlj76RESZ7isbIzM8ptOTJXn4DhMQgTDGeAUzAEIJ21xpJnbI
         WAuQ==
X-Gm-Message-State: AOAM531ZOy/MMCDFZYx5G/b+rQBqik5GNeknMZc+1y1UsWQgVW2XwUNe
        MSEXF/HAIMM3O1coCTrwNjVkkYEWCGPyvILboUJ7bg==
X-Google-Smtp-Source: ABdhPJywL/8xL+s/Wz9PYQqACsNKJlIixpOZzrkkMLprtEmtD0taXBt0RZSmBTlrPE/s8ZHyKoeWgqn3ctd+1W/a4Oo=
X-Received: by 2002:a2e:9bcd:: with SMTP id w13mr1219196ljj.43.1616458434230;
 Mon, 22 Mar 2021 17:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210316204252.427806-1-mic@digikod.net> <20210316204252.427806-3-mic@digikod.net>
In-Reply-To: <20210316204252.427806-3-mic@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 23 Mar 2021 01:13:27 +0100
Message-ID: <CAG48ez3v44du6_qVLa25SOdfLsr5+z-=a0pUP63d=qHP2tf4Pg@mail.gmail.com>
Subject: Re: [PATCH v30 02/12] landlock: Add ruleset and domain management
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 16, 2021 at 9:43 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> A Landlock ruleset is mainly a red-black tree with Landlock rules as
> nodes.  This enables quick update and lookup to match a requested
> access, e.g. to a file.  A ruleset is usable through a dedicated file
> descriptor (cf. following commit implementing syscalls) which enables a
> process to create and populate a ruleset with new rules.
>
> A domain is a ruleset tied to a set of processes.  This group of rules
> defines the security policy enforced on these processes and their future
> children.  A domain can transition to a new domain which is the
> intersection of all its constraints and those of a ruleset provided by
> the current process.  This modification only impact the current process.
> This means that a process can only gain more constraints (i.e. lose
> accesses) over time.
>
> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> Link: https://lore.kernel.org/r/20210316204252.427806-3-mic@digikod.net

Reviewed-by: Jann Horn <jannh@google.com>
