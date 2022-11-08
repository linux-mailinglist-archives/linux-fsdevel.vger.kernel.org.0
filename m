Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDA5620966
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Nov 2022 07:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiKHGN6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Nov 2022 01:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiKHGN5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Nov 2022 01:13:57 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869F063C2;
        Mon,  7 Nov 2022 22:13:56 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d20so12216267plr.10;
        Mon, 07 Nov 2022 22:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JX8vpBAhEPvSt1OhZU+reIbz1YtH+hIe7fUISAFUShE=;
        b=SM/vWxZTraSrV/v0BlwwX8bt91xcPBxY3QrouPIrkHI0YxPj3GjvN1lD9Attu5fxPJ
         h/Y0eq8oV4SKlMt7BvDmXKEPyr/bCAScGD6fR9JCTw6FXExTLarpAuFn0OrR0aW/TX1Z
         pLPXaG4wK8XVd8XlHXyLDzurQ5E+gOJjmiE4+CglliTOqUWhIpPfFMnr2riTZdu0uD1L
         UiEyS41YO4c6CixfTdHp97XZHfBqZa5AtANwF704hOERS6P8GZN4eUHxKgzce+ykMx9a
         86MDKkbbdta3t0oSML2mw81cO7xfmoK2Ib8HM2hTmAYOXro7/dUzkE48nTmFRyaHgHm0
         VTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JX8vpBAhEPvSt1OhZU+reIbz1YtH+hIe7fUISAFUShE=;
        b=XrONpfMyH8QBiOc4rXaO5hUphC3Le+dUICGMbt2rYFs9JtCVuQh2+5ki1wMPt1ZZup
         cXI6Y4FPsS8s4I2SRdq7alcRIwdGgawTDw+bplYA+36ORJ4LWOjYgyIc2UJiaAsOycjd
         Och5CN6t0XOpPhcEHQDCjtuxmk5anl94gV+LKQTZKM6tfqc3pgL0D8PtJExc4ofei+62
         eW8O5divCoxYbOyD2Nl1WpQj4iyEIziqtQSN5PFM65jheCEw6n7J6oKxe8lLcZaen9DA
         DQ+0g+M1KULYiUKnHEDz5bQBhP9ZcZRE5+jJRuaYz/7MQRNAlKEgmHwDX6B+kLc9Io9B
         0ekw==
X-Gm-Message-State: ACrzQf2p0XoH7LT72qgZYdbPwFgHW4zbo2doq8kTXz/VrIpLVLFIj2Gi
        C4fKhirvZSH3OoGtjmu1rUoWV52+nChaYztgvgs=
X-Google-Smtp-Source: AMsMyM6KKESqyvJU86mzQNQh1K6dBtWqiValwvnSMJ3R7swKmxjxJTeLjwDJho9Wz5ChwzSm/S6T/1zCTB/USBPpUWM=
X-Received: by 2002:a17:90b:1113:b0:216:616c:5fa0 with SMTP id
 gi19-20020a17090b111300b00216616c5fa0mr25717145pjb.225.1667888036052; Mon, 07
 Nov 2022 22:13:56 -0800 (PST)
MIME-Version: 1.0
References: <20221106021657.1145519-1-pedro.falcato@gmail.com> <202211061948.46D3F78@keescook>
In-Reply-To: <202211061948.46D3F78@keescook>
From:   Pedro Falcato <pedro.falcato@gmail.com>
Date:   Tue, 8 Nov 2022 06:13:44 +0000
Message-ID: <CAKbZUD3=4qZJJSDf7GfDRnunoJ_RETEi+iuu3oZewENhC+3i_A@mail.gmail.com>
Subject: Re: [PATCH] fs/binfmt_elf: Fix memsz > filesz handling
To:     Kees Cook <keescook@chromium.org>
Cc:     David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, sam@gentoo.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, Rich Felker <dalias@libc.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 7, 2022 at 3:59 AM Kees Cook <keescook@chromium.org> wrote:
> Thanks for the patch! I need to triple-check this logic, as there have
> been some overlapping (or out-of-order) LOAD bugs in the past too, and I
> want to make sure we don't accidentally zero things that already got
> loaded, etc.
Hi Kees,

Thanks for looking at my patch. I've submitted an (unprompted) v2 with
an additional fix for
a loading bug that could load segments after a .bss on top of .bss
itself, which would
overwrite any bss zeroing efforts. Note that this bug was already
present in load_elf_binary.

See a repro at https://github.com/heatd/elf-bug-questionmark, and the
comments on the patch/repro for more info.
Most ELF loading operating systems out there seem to fail on this one.

As for overlapping/out-of-order LOAD segments, what kind of handling
do we want here?
The ELF spec (http://www.sco.com/developers/gabi/latest/ch5.pheader.html)
says that
"Loadable segment entries in the program header table appear in
ascending order, sorted on the p_vaddr member.",
so do we really want to support that? My -v2 was substantially
simplified based on assuming ELF-compliant executables.

> David, has there been any work on adding a way to instantiate
> userspace VMAs in a KUnit test? I tried to write this myself, but I
> couldn't figure out how to make the userspace memory mappings appear.
> Here's my fumbling attempt:
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=devel/kunit/usercopy
>
> I really wish KUnit had userspace mapping support -- I have a bunch of
> unit tests that need to get built up around checking for regressions
> here, etc.
+1 on getting this unit-tested, this is a bit of a minefield

Thanks,
Pedro
