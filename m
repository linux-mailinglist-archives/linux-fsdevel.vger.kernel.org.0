Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEEF7B7A27
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 10:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241720AbjJDIfb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 04:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241716AbjJDIf1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:35:27 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA66A7;
        Wed,  4 Oct 2023 01:35:24 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-4527d65354bso953581137.0;
        Wed, 04 Oct 2023 01:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696408523; x=1697013323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdIybtSuQo5OLQsUTRY7g9sTFot1V+dxHkumXEluG7s=;
        b=mqfQxA/E2hSDAN165t+EKxi9KUTe+rx8A1fI9stfujWWoL6Jr/FPY4LF7tyegLb2pQ
         XDOWYCwcm3RlhxFFzxxfaqqjP0O6BcPdBjpmcam80hPmeHHqGelCJGdHKKrApqRfpMwo
         +8XVouTANc1Lt0d38LvLUnyoY+5t76e8L3At11lr+YlrAm5V9m+8xq+WtK0oW748daEs
         XRRGJWXHYGzIpuIUOTKnyqeh5KKHsTZTfocJtvnevhw1bvQyx29WrJDoSOzW4ynEQOKW
         WvBGmLlShrJfFq+EGeCKfk8zV1ZnvcU+1PBaC7Na0xuzs9Xp+UKhiSC0FTqffAoCXdq9
         f46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696408523; x=1697013323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdIybtSuQo5OLQsUTRY7g9sTFot1V+dxHkumXEluG7s=;
        b=LPIliJYkXnuK4gSc8XE0j8xMdAN2Ztsum1bxVKTonmZMbkVsD2kIjDiPgYgo8fzyLu
         /Kfnu9RcTtesOxPyE0PDbZOc/oMf1UCt+0KsDCyRhNJNZPpB0xBOGEPL2/wsS5fI5hyv
         yH++FB0HAfkKSe5uNYhpKomVRliWw75Oj9BxHwc75tdZvSrLPRRKzlBZ61AZTAEYMF9b
         2F3bnSgGA2xru9J2nWcC63Pxhd7Q6/QPLEbwZaNvoqv66YGpktZCaxPDlPOtWCK7F1FO
         UtNRHcuKM2GbaiAffqJlnJlw+Mro6QGRmRD4Q5/Q2IQVOnzXj5zAFCWobkASK6EH7PUj
         ETHg==
X-Gm-Message-State: AOJu0YwF6KHEjXuMHR2N+sjREYwiHKnm5Y/Ac4f+0OzKJxGWtErBpYiZ
        Z3I7/D/R9mRvHr8VmvZ9FhenbssTaKFaMThNc628/ZVDri4=
X-Google-Smtp-Source: AGHT+IF5e+IAN/3T9bL0TPtSo2tbkDPk+gsISeJhUvQijOylnJwUh6qx0foiL7WYdMqqu9dvSkEKaYNUxvnrbLsBDx0=
X-Received: by 2002:a05:6102:494:b0:452:9b18:b326 with SMTP id
 n20-20020a056102049400b004529b18b326mr1506596vsa.10.1696408523253; Wed, 04
 Oct 2023 01:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003b7fee05eec392a8@google.com> <000000000000a7178a0601b5366f@google.com>
In-Reply-To: <000000000000a7178a0601b5366f@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 4 Oct 2023 11:35:12 +0300
Message-ID: <CAOQ4uxjHY1pOzR++dpO_Srzh_hk=ZHTHJ73hyNXiyLT07vaEWA@mail.gmail.com>
Subject: Re: [syzbot] [reiserfs?] [overlayfs?] BUG: unable to handle kernel
 paging request in take_dentry_name_snapshot
To:     syzbot <syzbot+90392eaed540afcc8fc3@syzkaller.appspotmail.com>
Cc:     brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

On Sun, Jul 30, 2023 at 5:34=E2=80=AFPM syzbot
<syzbot+90392eaed540afcc8fc3@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 1784fbc2ed9c888ea4e895f30a53207ed7ee8208
> Author: Christian Brauner <brauner@kernel.org>
> Date:   Fri Jun 16 12:53:58 2023 +0000
>
>     ovl: port to new mount api
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D12561bd9a8=
0000
> start commit:   8395ae05cb5a Merge tag 'scsi-misc' of git://git.kernel.or=
g..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D85327a149d5f5=
0f
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D90392eaed540afc=
c8fc3
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D16199460480=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1797f27448000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: ovl: port to new mount api
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

#syz dup: WARNING: locking bug in take_dentry_name_snapshot
