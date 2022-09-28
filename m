Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C6A5ED644
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 09:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbiI1Hgy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 03:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbiI1HgR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:36:17 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3960E106F42
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Sep 2022 00:35:48 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id x29so13436754ljq.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Sep 2022 00:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=3j/OGBdohTxo+OrTq6NBOfxvszCK7ExkrQxW4O8b994=;
        b=atm12eJwGt6KW1nvvfcySISnScimJj6UlzOjGboOpEYfiAJsQ2IiCXZkydoNNYKlND
         RgR3x7ksKA9vBr2JFdMIUNXKq1r1CKQC4g/KRTVULzL2HLAAt9BUU0XVg1eHEju5FWit
         WNujalZ1jjiZKrQHS71YdWZ0ABi0et6y1JVWXI1XCssx4v+reFoVdknOuhMJUoz7Unho
         Ha/PYS2fXiAjtMxC+a0F40+oZcynizoyS4gPhMutKNmWk4qOI4kr5Rf2GRgkDKip0Cdd
         2QC3yWdnAwp/l1FRGChKNmDySNQYA+1f99KM43gzgc0UjGucAQ+s8iLUEEnEpLdgwRQJ
         1WsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3j/OGBdohTxo+OrTq6NBOfxvszCK7ExkrQxW4O8b994=;
        b=M81IcUDSNKmqAXyr0snxZ8tMquga2HmZZHOBiL5EhaEbWtoxobuW/iL6aaaA6W0/TQ
         MkK9oh3M6amODTYI5OTf4IMC4B6UnCp4Is71N8O5aq7AUKId5iDVJWJHiueqdeCFiWPE
         bUiHhtclkZu3etbWPaF4RaqBZcYCzKMU5I8SQN2g8NwCqUsjkPaL68FexUABsDRPzTOv
         H8v4imPyI8feMwAIMlr0asldHf/4Lwp3wcmpR9CsffC00UjyrPzZZOamjGuGWdTZT039
         qrhL3dT1/9LZwmoNwk5YBN7DAPi2Lng/euW55iQmNYjr4DGEHFMallgCg1r7ubMQ5tSV
         KNcw==
X-Gm-Message-State: ACrzQf0lggl+LdSKbvRF2WVKYjswlXaZ8QCLydJUJvJx8Dj9BLuL6jMG
        B9M4B5iuJSN1qIR+vsOAynwgxUyNkYHJYAzmWOfowg==
X-Google-Smtp-Source: AMsMyM6l/7+jXva4+hFC7yDGhdP3H6/FMnH5Q58iBE8f6YGbet7quaIATUrYZbeLLLu3nh6c07fsoNHOSuCO/hPKJ3k=
X-Received: by 2002:a2e:9f15:0:b0:26d:8a9c:60e7 with SMTP id
 u21-20020a2e9f15000000b0026d8a9c60e7mr6941360ljk.268.1664350541165; Wed, 28
 Sep 2022 00:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008af58705e9b32b1d@google.com>
In-Reply-To: <0000000000008af58705e9b32b1d@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 28 Sep 2022 09:35:29 +0200
Message-ID: <CACT4Y+aO-uckeUghahSJP+6VwwYCNRKCobhvb41n1RXL8Pxsiw@mail.gmail.com>
Subject: Re: [syzbot] unexpected kernel reboot (8)
To:     syzbot <syzbot+8346a1aeed52cb04c9ba@syzkaller.appspotmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 28 Sept 2022 at 04:03, syzbot
<syzbot+8346a1aeed52cb04c9ba@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    1707c39ae309 Merge tag 'driver-core-6.0-rc7' of git://git=
...
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1732428888000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D122d7bd4fc8e0=
ecb
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D8346a1aeed52cb0=
4c9ba
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binuti=
ls for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15ca1f54880=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D155622df08000=
0
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+8346a1aeed52cb04c9ba@syzkaller.appspotmail.com
>
> fuseblk: Unknown parameter '                                             =
                   Decompressing Linux... Parsing ELF... done.             =
                                                                        Boo=
ting the kernel.                                                           =
                                                                           =
                                                                           =
                                            Decompressing Linux... Parsing =
ELF... done.                                                               =
                      Booting the kernel.

+fuse maintainers

This one is somewhat funny. The fuzzer tricked the kernel into
printing the rebooting message via normal logging. So on the console
it looks like the kernel started rebooting.

But it looks like the kernel is reading/printing something it
shouldn't. The reproducer doesn't pass the "Decompressing Linux"
string in mount options. So the kernel is reading random memory
out-of-bounds? a non-0-terminated string somewhere?
