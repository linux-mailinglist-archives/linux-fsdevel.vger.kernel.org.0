Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150257B62AF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 09:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjJCHpa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 03:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjJCHp3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:45:29 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16ED90;
        Tue,  3 Oct 2023 00:45:23 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-45281e0b1cbso330320137.0;
        Tue, 03 Oct 2023 00:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696319123; x=1696923923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxSBLRS2D24LuH1uwdEmbmZKZlhSPy1I4xS0UUCvOXE=;
        b=TzkZHU4HSt+KPo2vIEPTbhjlK1fHiIkKHXNQpJ7BqmcKknwXwvSn5zdeSAmzvjonGL
         zf1+KP0rPixMlyyCDmnb2S1FzGyTLS7o1URReE/n65LThOXCRSfIKL7cSXRncB7v83lL
         bPsjKMKvs6DzjSpHqXjWXqVqhrTJOhXb/0Zk+AKiG43j7dHhTsWp48fPmvLrKs3gUbOs
         gu02wowaUbGJG7xUJmpaVaPE9EydxHX+UDvG+4B5nkODoSFT/dBEM7v4XMaLCzRQ2Z4z
         TC1NxxGFQPBOhKBY+2w5++CtejRK/iN9QgWVxiIOinEH0vGcOdpfHuJAtx1AJJ/WKYpy
         zvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696319123; x=1696923923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dxSBLRS2D24LuH1uwdEmbmZKZlhSPy1I4xS0UUCvOXE=;
        b=ZHuvr1SjsAq9hgldeZZxSEuDObV5mAMaClFEvNKxfw+vR4lvS/vJNi/GbHGMJDxGF9
         IwkHXGhz3d2IUH2IE/wsgtNqkjS255IyqavD/rQGvuyNlP+rTfcl0qZbyfwtVmth16Ox
         fAaUxjkAiSpFd2nPl7aEMt1vVI3O0mOvn0T8LTbvVBTq9WXBNmTU4Lz47PsHMBUGVoDc
         IM5a8r+z119xOGBnRrUJmLEK/MX6S29XXLXMLJ7F+QeoVG+Y8ysl2QCPivVeebLOTcYw
         ZMzu3/ygVcOnx4d+5U+ZybaZ4M1cZXz+bxTuFipawYOmobF7v34DF7ZOhmRFwe5n15oE
         omVw==
X-Gm-Message-State: AOJu0YzC318svPscCcbhRCVZJyHRpYzZSv7RO3HsOTEyDjAJYRaTreU2
        Yl23RpVRyL0FEre9ObYhkmLNlMTBmnaqNn59P0A=
X-Google-Smtp-Source: AGHT+IGygHvYyIzbcAe/O0WNK1lFKBR5ZG71Zg0ywTe9FwpSSsBHULM/vuEggGIcEvXYb1eOR6yB8Dp8TY/KWKEAzQ4=
X-Received: by 2002:a67:ebd3:0:b0:452:6465:4a35 with SMTP id
 y19-20020a67ebd3000000b0045264654a35mr12361496vso.11.1696319122624; Tue, 03
 Oct 2023 00:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000056dad80606c447e0@google.com> <000000000000fb84850606c8b688@google.com>
In-Reply-To: <000000000000fb84850606c8b688@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 3 Oct 2023 10:45:11 +0300
Message-ID: <CAOQ4uxhgWHoauPKUDfmuvu9uyMC23gkKVgi98R7XgX6s+fuh7w@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] general protection fault in ovl_encode_real_fh
To:     syzbot <syzbot+2208f82282740c1c8915@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 3, 2023 at 7:56=E2=80=AFAM syzbot
<syzbot+2208f82282740c1c8915@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit 16aac5ad1fa94894b798dd522c5c3a6a0628d7f0
> Author: Amir Goldstein <amir73il@gmail.com>
> Date:   Sun Apr 23 16:02:04 2023 +0000
>
>     ovl: support encoding non-decodable file handles
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1197206268=
0000
> start commit:   8a749fd1a872 Linux 6.6-rc4
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D1397206268=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1597206268000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D57da1ac039c4c=
78a
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D2208f82282740c1=
c8915
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14877eb2680=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13b701f668000=
0
>
> Reported-by: syzbot+2208f82282740c1c8915@syzkaller.appspotmail.com
> Fixes: 16aac5ad1fa9 ("ovl: support encoding non-decodable file handles")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

That was a stupid braino.

Reproducer is simple I added test coverage to LTP:
https://github.com/amir73il/ltp/commits/ovl_encode_fid

and pushed a fix to

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git
ovl-fixes
