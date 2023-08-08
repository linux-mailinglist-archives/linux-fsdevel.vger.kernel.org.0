Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35E7774373
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 20:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbjHHSEt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 14:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235262AbjHHSE2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:04:28 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3755574A5
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Aug 2023 10:01:34 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5223910acf2so456a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Aug 2023 10:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691514093; x=1692118893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwAW4asVrEkUVVSKI2WNTJmzRtpxh5nDYHP0xuDjc0s=;
        b=y5ZUQf5txiTC5rqWFk9xkDefQJtek86V5zXvOhQO96o5wzcCHFzlAlbrDzYAN/jvte
         K4ixG/X0EJa86LsKogQcqyeqjvKca1d/rcKzSbC7z7s4P5nxzshP5eXhq1cieG/TysyL
         V3MV/oYT6mxxQmeCO/CNgWHWm1C081Dg0b9ccLh/kxYTSd1ZJwRuIYEV8AbO1Aml8O5+
         Hg45L9GC2p+u7JT7LOHG1AMKFsdOknSXfg/4EGLB3pw8AKoGfMT8RRr2exSCGBmkzmSE
         FZOXG8K9JJ9bf1WQ7icPuuWhZHkLItXKHl1NjP0KozqYsOKcGIvJWwx7C8cr7846Rlak
         jo1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514093; x=1692118893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwAW4asVrEkUVVSKI2WNTJmzRtpxh5nDYHP0xuDjc0s=;
        b=k1io6c9wcpgiRtsjSXoZLkgzBShAfqAL6WKyxA/SqpFQUd1sZs6iF3JLBze4Y/st+u
         5MvlRIhiKhmINzkwSAnlcE1Xktfn7GeebJjjfrSgBJ7vMurfYeRR9UmM4w5jxaTvuQ1Z
         PK8SebnR6rMf6EpPgaSz3OAmf2yaif276jtv/rbNKG3c4XQUoeKpEHpoQM/awhLi9DW+
         oGPSlp8FecQmuCYWwRetzg4I3EmgH+VF6Z3anv4EkRjHwYyuQUxOix5m9XtrBQfAdCCX
         J+xoqF6GlToTru69nBbBZlgpz2OmBQJ026pP7NbljRBFE53lIYrlrsfT5+0QWZqhKibr
         8AIw==
X-Gm-Message-State: AOJu0Yx4ZcOT0XxYEKDXfzOUtjpnmKU2FnOUfqu5ha4xRsdn6AzY0iyV
        I6cFjohw8xal20/D5BIzh29j6TASg/VPE44DCnYo1bWQH06Bv4w3797x+L/B
X-Google-Smtp-Source: AGHT+IGCuc1ECA/DdvhuJs8hrdI6B0b0q+56VMbNGS79u6n7XtDIRdL1Iu+hAqJPTrb26LRWfquYy88hAzXnhi0ISBA=
X-Received: by 2002:a50:f61b:0:b0:523:193b:5587 with SMTP id
 c27-20020a50f61b000000b00523193b5587mr283949edn.6.1691492435497; Tue, 08 Aug
 2023 04:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000069948205f7fb357f@google.com> <000000000000a9bf5106026705ec@google.com>
In-Reply-To: <000000000000a9bf5106026705ec@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 8 Aug 2023 13:00:23 +0200
Message-ID: <CANp29Y6M-CU+eqUFqN3Rkf2iba7upqsLvnHNNyMmhd4JFdH-8A@mail.gmail.com>
Subject: Re: [syzbot] [fat?] possible deadlock in do_user_addr_fault
To:     syzbot <syzbot+278098b0faaf0595072b@syzkaller.appspotmail.com>
Cc:     linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-16.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 8, 2023 at 12:42=E2=80=AFPM syzbot
<syzbot+278098b0faaf0595072b@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit ff84772fd45d486e4fc78c82e2f70ce5333543e6
> Author: Sungjong Seo <sj1557.seo@samsung.com>
> Date:   Fri Jul 14 08:43:54 2023 +0000
>
>     exfat: release s_lock before calling dir_emit()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D16623aa9a8=
0000
> start commit:   f8dba31b0a82 Merge tag 'asym-keys-fix-for-linus-v6.4-rc5'=
 ..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D3c980bfe8b399=
968
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D278098b0faaf059=
5072b
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D144ccf79280=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D135fab7928000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: exfat: release s_lock before calling dir_emit()

Seems reasonable.
#syz fix: exfat: release s_lock before calling dir_emit()

>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/000000000000a9bf5106026705ec%40google.com.
