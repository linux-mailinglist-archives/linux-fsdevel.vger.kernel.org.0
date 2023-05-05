Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D676F8B1C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 23:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbjEEVgi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 17:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbjEEVgh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 17:36:37 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2122FF4
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 May 2023 14:36:36 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-b9a6ab9ede3so3053384276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 May 2023 14:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1683322595; x=1685914595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0JfIlTqaeXlyEjv8OL6VI/Norerpq4Zpq5DUaY96vQ=;
        b=HFIJtI/kpmdLq8nRaDpAzU/Clt1/UJxLL8jrzJIQ3nN3zf4fqNv+ZtaSmm9nZ9WSxL
         Fsdmz6Yg244MrJudDafdQdsz6UxENZYEXFzrOoHjOR1sy7cP5A+nj6c8BeRafdgdzmKW
         EXxDU+bc0GuwPIFHgZLrSGRMNZGd68ZC038in7IflWIaQ4+gF9uANMqT/6PCnj4G7msL
         Kp2821yv0nosKv0gQkf2+0iNHig/foynW4QCkBRYd1xWQZdSnHzLEuAnSGn0FWzJ2/pw
         JhUAS6Nd8jaQw0XJpJHlYYBttFdbB9ggrTzlZlYeFD/4Fdu7rWzcXyK1NwEpIMGB8CWy
         CKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683322595; x=1685914595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0JfIlTqaeXlyEjv8OL6VI/Norerpq4Zpq5DUaY96vQ=;
        b=dnluwtJHNIWy4HX4TUxnyaQdVDf9W3CxySd1hN6e8iOtJ700OXXLiS7+sa1/eb1iq7
         Us5B1RoxKTQuU/azxuR6vBFPpj1nVx8nR/tjFgE0WWiWuMvV78WtxE6kCnwpJBTrvhBV
         thaHPnM114F0c6aVHYfv4XvufEWeGdm2/2ZpmIrVkoaYB3i54P07ScACnt/x/Ap/Ze9y
         l61kNF7a5pf06szr3XoUp4R9/M0o842UJ7vVk1OZVteMnYz2kyYOjjQsCTfcbCmio4mH
         ZQLILz4YMfTLOlHMRt8uMsT7WeyCeUa+qTTyqywVPxGnxET7XnGwz3rTIoH2HUip1QiA
         oi/A==
X-Gm-Message-State: AC+VfDzhd282VKYJPHWkLEzFgB6RMEvvNR1AWTj4zhLbmWHjnuR6clsb
        cYVEzNW0YSKlNK4Oj1eYCW2Hw2S0DpVJ5oi7XcP3
X-Google-Smtp-Source: ACHHUZ5mePxZSEmEoU+z772wuUV1h4yYiZ/D6Jn5MdbMYmXXJG0E7mS81yf5C+0NpsiFgG2/Nu/3hoJojsTP4keEGNQ=
X-Received: by 2002:a05:6902:702:b0:b9e:5aad:edda with SMTP id
 k2-20020a056902070200b00b9e5aadeddamr3593877ybt.4.1683322595278; Fri, 05 May
 2023 14:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007bedb605f119ed9f@google.com> <00000000000000964605faf87416@google.com>
In-Reply-To: <00000000000000964605faf87416@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 5 May 2023 17:36:24 -0400
Message-ID: <CAHC9VhTZ=Esk+JxgAjch2J44WuLixe-SZMXW2iGHpLdrdMKQ=g@mail.gmail.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in open_xa_dir
To:     syzbot <syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com>
Cc:     hdanton@sina.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        roberto.sassu@huawei.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 5, 2023 at 4:51=E2=80=AFPM syzbot
<syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit d82dcd9e21b77d338dc4875f3d4111f0db314a7c
> Author: Roberto Sassu <roberto.sassu@huawei.com>
> Date:   Fri Mar 31 12:32:18 2023 +0000
>
>     reiserfs: Add security prefix to xattr name in reiserfs_security_writ=
e()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1440318228=
0000
> start commit:   3c4aa4434377 Merge tag 'ceph-for-6.4-rc1' of https://gith=
u..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D1640318228=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1240318228000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D73a06f6ef2d5b=
492
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D8fb64a61fdd96b5=
0f3b8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12442414280=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D176a731828000=
0
>
> Reported-by: syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com
> Fixes: d82dcd9e21b7 ("reiserfs: Add security prefix to xattr name in reis=
erfs_security_write()")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

I don't think Roberto's patch identified above is the actual root
cause of this problem as reiserfs_xattr_set_handle() is called in
reiserfs_security_write() both before and after the patch.  However,
due to some bad logic in reiserfs_security_write() which Roberto
corrected, I'm thinking that it is possible this code is being
exercised for the first time and syzbot is starting to trigger a
locking issue in the reiserfs code ... ?

--=20
paul-moore.com
