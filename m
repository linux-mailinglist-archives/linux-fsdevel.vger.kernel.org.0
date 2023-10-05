Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4547BA53C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 18:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240026AbjJEQPV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 12:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241112AbjJEQNk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:13:40 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CADAD17;
        Thu,  5 Oct 2023 02:36:16 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7b07c3eaf9bso291393241.3;
        Thu, 05 Oct 2023 02:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696498575; x=1697103375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miaHJCTsklS6Zbf74LdxRTHsnukEGfuauknHlldmnMc=;
        b=N4af9kbi6Y+6dW9LsItj5fS5+DyE6zDpoaXlRE63hcUqzTAjlFVy++6BlgMNLc7eoc
         9aEa02NdBFigDUFax26K4zjqVc1R9QevHORZNCEceZgUNfBD1PoKFZXlmUsuKvcLJB2z
         Wzq25anMl7eXz6LpGSIH0XC1N/yUmNm0EjsFMP+KHLm7UWHZRh9zSI0p3N9zEQZ5T2pR
         jH1t6eglUTla2oo0U+yFQhjcilqGxdoULd5rEZUjwZ4FX+CfYcsYszoomCu0204u545P
         Qb/9Kwa9NQ6OpKIeEhQ8uk5o6pzGL3Q4OAVhpR88DQEJOju8mPcHgkmd00fDwrjBGC1S
         gpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696498575; x=1697103375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miaHJCTsklS6Zbf74LdxRTHsnukEGfuauknHlldmnMc=;
        b=QFvdY/FyxkbAHDFTe1d61HEPBpvKjezRu16VHZ1FP1fyDKMAWt83XyBW9xdUAkDVMj
         ucMPRNA+c3b6g2G37Yd6WOGa0fnzrs80dP1WOPrxzb+dZ7x7zPDDWSa6yIx9joVLJ/QK
         i4g00/bNMTce7wD4UbcH068mTjj+CppEbfVleN9x3P+H+zshm9b2EOLRSDvOZhrVvbKF
         xMNcM3ZBckOF8jrS6J4qMLGqjOA298urN61hUZ5d98tb7i2iHI6Vrqb6xbh7pIw3R5q7
         KiNcTC7MCaYHwdwGx4HQZ0OOsTYld6EKj/F/nd4CtRIlq/nofxCN7OUVGiCNTj5krigO
         Yerw==
X-Gm-Message-State: AOJu0YyLqGrprqjZuIxtUDycFcIjMJ0drgO0UZTB6ivbyzVEi4eo+C3i
        IgxweggwkHEHPOg5r2ppndtAk2CBYx7YCtTLmSw=
X-Google-Smtp-Source: AGHT+IHEmB4hPkLYLPKiUKYdFA8EWWzm/1bKRsSKow5Ph7YiXuo2ENvDu/sgoJxWbdjYFoZ5NkuSiVgyiunS+gZFpDQ=
X-Received: by 2002:a67:f4c9:0:b0:44d:3aba:b03d with SMTP id
 s9-20020a67f4c9000000b0044d3abab03dmr4641256vsn.17.1696498575187; Thu, 05 Oct
 2023 02:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000067d24205c4d0e599@google.com> <000000000000accfd30606e6bcd0@google.com>
In-Reply-To: <000000000000accfd30606e6bcd0@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 5 Oct 2023 12:36:04 +0300
Message-ID: <CAOQ4uxhbNyDzf0_fFh1Yy5Kz2Coz=gTrfOtsmteE0=ncibBnpw@mail.gmail.com>
Subject: Re: [syzbot] [integrity] [overlayfs] possible deadlock in
 mnt_want_write (2)
To:     syzbot <syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com>
Cc:     hdanton@sina.com, linux-fsdevel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, mszeredi@redhat.com,
        syzbot@syzkalhler.appspotmail.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, zohar@us.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 4, 2023 at 7:45=E2=80=AFPM syzbot
<syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit 708fa01597fa002599756bf56a96d0de1677375c
> Author: Miklos Szeredi <mszeredi@redhat.com>
> Date:   Mon Apr 12 10:00:37 2021 +0000
>
>     ovl: allow upperdir inside lowerdir
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D17ad11b268=
0000
> start commit:   3aba70aed91f Merge tag 'gpio-fixes-for-v6.6-rc3' of git:/=
/..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D146d11b268=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D106d11b268000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3De4ca82a1bedd3=
7e4
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Db42fe626038981f=
b7bfa
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1304fba6680=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13cec0dc68000=
0
>
> Reported-by: syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com
> Fixes: 708fa01597fa ("ovl: allow upperdir inside lowerdir")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

#syz test: https://github.com/amir73il/linux ima-ovl-fix
