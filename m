Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7BB710963
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 12:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240210AbjEYKBZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 06:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238966AbjEYKBY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 06:01:24 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7807B122
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 03:01:22 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3f6c6320d4eso130581cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 03:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685008881; x=1687600881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmOWaLV+dlmmR2pxZAbEKqT5QECjyZujcCsJOTVir3s=;
        b=tNT9gMF69yLuJbKM6pRi6QPxT5/6hFnVzL+S81dH2OKp8xW2nk1KEh4enC8HXO5ClX
         8VeWNYhcstOsmNETIUrdu7+hJ9/GYe9LFegkyOzwjp3mQtDW90eMsklg9HE0bkeu/i/c
         CM4hRVXjov0b382BV/Uxw77nwl1Wvzc81YKmT8T9g3BwNTkyQQYnRXERg6zIPQZ/C3v6
         33E0fLj/ZYGDE8fxOPAy0TdkwC1/LRB7QCnee9PbOd/rnSVRIzieF65VimUz3f0O4AlP
         xOy/GK9I/dy56mcuWGTzFASyEbwm5B7tRry3vwZqzOlv5o23eeJW6Gbhs1+vJObstwPm
         THTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685008881; x=1687600881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmOWaLV+dlmmR2pxZAbEKqT5QECjyZujcCsJOTVir3s=;
        b=hXVnvEto1ieMxNRfi1stTxlMs1nD/haynQW4CBCTYHUUNOguhLlLIw96GGxGlHKW0A
         +cJlQNwV81Jix1yrZxwNxZGCxaiDQ+QJF646nGCsUV1DJ2P48R8lo55at+++kM2iKHpP
         22KQkAvHNKM9muYttGu2amBRHPZt6RU+Gsnl3ES1nBY0GtyBGaqbL8jDjXqlZ+JTxd9I
         J0zg8ifsxghld73gWU1j3ySfjaUteMHrtulDJ7lkA/ImTMri5UoIVZn9gNmo05uJFQ0s
         /CraBsDJ6wNU6tZHOqOQW37yvEz0xADckPQDweXRRJeUiMLVpHXmkpWFFwRwfBVUH4Zk
         raDg==
X-Gm-Message-State: AC+VfDybvtWpRtHSNMbzCXq9mieFungSRh9qNzJdFiPnp48Oz/v0rCsi
        QTB+kjQE2YCksUeZJGy1fSE2vqp+5AhBcv2B86/NOg==
X-Google-Smtp-Source: ACHHUZ5oCzEQNzdamhGrz4yfKZwtIrLRFeFtlUXbqwdF9uT1Ca8oaD/nIJ4tEWCEvshqrtk0ZuDvbko445j9SoHEO94=
X-Received: by 2002:ac8:7f0f:0:b0:3ef:5f97:258f with SMTP id
 f15-20020ac87f0f000000b003ef5f97258fmr194951qtk.16.1685008881498; Thu, 25 May
 2023 03:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000eb49a905f061ada5@google.com> <0000000000000ca36b05fc780953@google.com>
In-Reply-To: <0000000000000ca36b05fc780953@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 25 May 2023 12:01:10 +0200
Message-ID: <CANp29Y68oXAQZBAChyiB58qebXS5bNOGda6tG=B+kKa7QRh6EQ@mail.gmail.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in do_symlinkat
To:     syzbot <syzbot+e78eab0c1cf4649256ed@syzkaller.appspotmail.com>
Cc:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 12:29=E2=80=AFAM syzbot
<syzbot+e78eab0c1cf4649256ed@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 267a36ba30a7425ad59d20e7e7e33bbdcc9cfb0a
> Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> Date:   Mon Jan 16 08:52:10 2023 +0000
>
>     fs/ntfs3: Remove noacsrules
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D15fdf76128=
0000
> start commit:   ec35307e18ba Merge tag 'drm-fixes-2023-02-17' of git://an=
o..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D5f0b8e3df6f76=
ec
> dashboard link: https://syzkaller.appspot.com/bug?extid=3De78eab0c1cf4649=
256ed
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12570890c80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14523acf48000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: fs/ntfs3: Remove noacsrules

This commit definitely removes one of the options used by the
reproducer, though at least from the stack trace it's not clear
whether the problem was in noacsrules or we're just now not mounting
the image because of invalid mount options.

Anyway, let's close the bug, it will reappear on syzbot if it's not fixed.

#syz fix: fs/ntfs3: Remove noacsrules

>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
