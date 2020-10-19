Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A25E292C04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Oct 2020 18:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbgJSQ6a convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Oct 2020 12:58:30 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34731 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729879AbgJSQ6a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Oct 2020 12:58:30 -0400
Received: by mail-ot1-f65.google.com with SMTP id d28so284993ote.1;
        Mon, 19 Oct 2020 09:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hL7mfN1EupeS+kSdK5Vs5Sf+DfzTZOfmEItZgZZEYaA=;
        b=Y/oNI1qrxlj+2alV8tcLPSAg/Hyt2bD2pQ7Ux4grqLaKhSypS846lYiGdjRsmXozFb
         EpU+XWVvFtQ5ZWbPHE9sGXMQa9qDcsR/svyzGAUMFvChhrfxG9ls4Iya9ueQsPeNJoPZ
         e9cddeGxGMBXfvzWmGxuRjxboQeaAYLtKxobDAc8yXBjMl5Zl3hHjkIkKcVum3zffJ5B
         Ma4LW6DEJ4QoU4lnXzl4KWEKS4ki7GEqZrc3TAEuw6q/ZkcuNpxTn/h7XcJ2w1Rjdwpu
         567yyAHDul1gs/Xp+eTUpIh35x1gmIM340YY/K/bBUS0FwBHKZJt7h+zN9Z1scnu4oq2
         dhUg==
X-Gm-Message-State: AOAM532Z5mGrqsGt4rUyWYmFKyyCpXBDbcEWDFdQhopc1thsVlL3feRK
        bsR4qvUnfYeVjdqV630WvZZEQ4FWzhCv0aMRFdA=
X-Google-Smtp-Source: ABdhPJwtsUP8OaqlrBo/FWg0iCrXu7PdM3v6/RshAxTARIxWSfsYxMhDPOLE743HjM1wPlbcpacytmQvt8D03nTnkIg=
X-Received: by 2002:a9d:3b76:: with SMTP id z109mr676938otb.250.1603126709134;
 Mon, 19 Oct 2020 09:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201019164932.1430614-1-mic@digikod.net> <20201019164932.1430614-3-mic@digikod.net>
In-Reply-To: <20201019164932.1430614-3-mic@digikod.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Oct 2020 18:58:17 +0200
Message-ID: <CAMuHMdV6Ee0pU119akfK36FKEp1_XHO_ka0LFSE1Yn3qUjJ_0g@mail.gmail.com>
Subject: Re: [RESEND PATCH v11 2/3] arch: Wire up trusted_for(2)
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Philippe_Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 19, 2020 at 6:50 PM Mickaël Salaün <mic@digikod.net> wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
>
> Wire up trusted_for(2) for all architectures.
>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> Reviewed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>

>  arch/m68k/kernel/syscalls/syscall.tbl       | 1 +

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

(haven't seen any other arch Acked-by tags yet?)

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
