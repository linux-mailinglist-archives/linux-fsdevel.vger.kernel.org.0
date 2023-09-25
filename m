Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DBA7AD5A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 12:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjIYKO3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 06:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjIYKO0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:14:26 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE2610A;
        Mon, 25 Sep 2023 03:14:17 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-4526c6579afso4253172137.0;
        Mon, 25 Sep 2023 03:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695636856; x=1696241656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAIIO8bbHlcK3rCEQBQ1u0uoNoEGwnfHthV/V0CZlE4=;
        b=CUc/ard6OqNMtJG7I6Jgo4NmK16Q/iRCYy4dM2IIbQuS0XtGkq3NMnN17HKZrCa93Y
         1WuOcCKFnJIypNnvhx+UuZM7ynDD+vACsA96yh+eWG51y9+MFqCdmB/ParTxglzhe4kT
         UY+/MoC5n4mrpEzmHTAADOruphTa1buwlf0qA/Vcd7SOdDCEsU+ttQ3EkQ7clbKsLouQ
         XOc1q73HVwXFhFu8ZEpAa6/wUAtvZhb+Hlu/lfZA4FmgVql/e7vtrbIPH7KbyjA1Ybjr
         G248uV4QsbWvAZoz2Od/JxOEfQS3PEKMUWwwZIfBWtbiuSqpH1BaTxoZpP4JbQUtjJOF
         XTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695636856; x=1696241656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAIIO8bbHlcK3rCEQBQ1u0uoNoEGwnfHthV/V0CZlE4=;
        b=luPwkNVHGCNKWWwPJPOombC1m1K/g15QMU/Vh5kcA9aesOJ5zClR9RNmZKW3dsRndY
         BFJz9NNTkW/13G4siYIFeQSYSqvqLaBmbwqWgICMbMljpFSyAulWBSeVs6fyGAU1Um5g
         pQkhVIQbZHgUOgRfmQnFy1XRUaDTVDdBVXn0hiCBBvU6SjjzrF5pCnOaPcBVBgjlIAEl
         8X3Ezk5vDmwcVHQKLmPHDGct+Fd/ZXSaKIPR7HUIbSKdDcy/ksUa+K2pBGcuDglz8/PY
         nEtG9O1ClDCEuWafxk8N8JgRJYSmPnM5UJk3K5A+2GLgYlBmlUTdDr6wGz+p84FGadaD
         Ze+Q==
X-Gm-Message-State: AOJu0YyZviL17kq4FB1reZPpxV4J9r0goi3dTF59aNmuNlR07BPItorx
        WHSjczw7zCD3z8mIh1ZUvlsLtVaEko+m+rS5itE=
X-Google-Smtp-Source: AGHT+IFatFep8wn7gsxnkGjlLPiv9pFVo8mMwtNjTNDmG+qV8GreAwx+K5lNyeeFlWDjue3mAB2d8vvttVE5b/cBFfc=
X-Received: by 2002:a67:e68c:0:b0:450:fc9b:552e with SMTP id
 hv12-20020a67e68c000000b00450fc9b552emr5000594vsb.1.1695636856284; Mon, 25
 Sep 2023 03:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000964cb905f5e876ff@google.com> <0000000000008a3693060628bb0b@google.com>
In-Reply-To: <0000000000008a3693060628bb0b@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 25 Sep 2023 13:14:05 +0300
Message-ID: <CAOQ4uxiRDubLv37ONA+g_ZissLQpdZXoO-442pp=U+-3qQJMzQ@mail.gmail.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in delete_one_xattr (2)
To:     syzbot <syzbot+7a278bf8bfa794494110@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        mszeredi@redhat.com, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 25, 2023 at 9:04=E2=80=AFAM syzbot
<syzbot+7a278bf8bfa794494110@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit 9df085f3c9a2d4658a9fe323d70c200aa00ede93
> Author: Amir Goldstein <amir73il@gmail.com>
> Date:   Mon Sep 3 06:12:09 2018 +0000
>
>     ovl: relax requirement for non null uuid of lower fs
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1711e75a68=
0000
> start commit:   ac9a78681b92 Linux 6.4-rc1
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D1491e75a68=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1091e75a68000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8bc832f563d8b=
f38
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D7a278bf8bfa7944=
94110
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1295e4b8280=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D140af20a28000=
0
>
> Reported-by: syzbot+7a278bf8bfa794494110@syzkaller.appspotmail.com
> Fixes: 9df085f3c9a2 ("ovl: relax requirement for non null uuid of lower f=
s")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

[CC the developers who marked reiserfs for deprecation]

Resierfs AND moving files underneath overlayfs.
Not worth much investigation time IMO.
If I could tell syzbot, ignore this report, I would.

Resierfs deletes xattrs from reiserfs_evict_inode() context,
which seems to be related to the lockdep warning.

Thanks,
Amir.
