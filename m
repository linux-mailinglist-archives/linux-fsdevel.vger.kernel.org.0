Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02188716580
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 17:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjE3PAU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 11:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjE3PAS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 11:00:18 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486ACF1;
        Tue, 30 May 2023 07:59:54 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2af7081c9ebso48843871fa.1;
        Tue, 30 May 2023 07:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685458792; x=1688050792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1prAZbqiTg1dUFwezGXTXOfntLGDRSTqatzd2KUWUkM=;
        b=qAfqcXDXsFzOvvu2d5Vm23SgBXCDAIPexQLTuSUvo2jiT3c5AGAQbHyp+LTBSIEB6J
         oq69r1dEaMyL0gh+6vs8pfSk5JET37Nv9+EJNRIoZb2NbeJ3kxh/IAZl1lqtBvE7bhd8
         YPlwzeQaXHH9nmfqYlNRZulayU1LtMSsr+FNgobWWxDay/ZuMWV34rU9G7DQWbJY9mgu
         r3oPL6ubOJ54iMSAxqtUYI/8c48OhwsYimexGzbD4tkxtUiOZFlZcvuzMBnTw5mTYYbn
         QpbvBcGoznjnvmFkhVXUYx/lq5iSHNhGV6uGbb0Fk2O3i8wlfEZZCRs/6hhcuhjdNMcK
         KXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685458792; x=1688050792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1prAZbqiTg1dUFwezGXTXOfntLGDRSTqatzd2KUWUkM=;
        b=e6WDyS51/qta7cqM3jf43xHZ2vEhSy/f5PGy4G/Idbf4LFKwbfVbW9qmmDLcfiKhMd
         mVsijdbAIcpGAFOhICBqV0SwIQaNusXLpH80vZon30Hu68B/7YpWT9hlBrGt5qNr2ubF
         Ff6OAvfLr2hXwsMTuNKmVRVaz/DPI/+37zsq0KmWM4UR+FADzDxDJ4K4In9bcBI/8rxu
         M6cx7NBJHhEd+baUnN3qB2r2EcmyuPZv4op+0qU6Qv+PhzMYn4mkEnHhAHHpPZflhq6d
         /L11vvX8ALduecbiRAwItubMa650k6kgD5Yx91Y+aDRVGCn4bnKE2qhB+88UHji31CB0
         SVLA==
X-Gm-Message-State: AC+VfDyBQJbvpDzuB+tE6fi+YhtFhvEKD/IDYqZgQI+pyxZQxHyWRt2q
        vV6e/+ZVPuQxqq1IfrRyIWH7tsXCQ8IReIZ7zTk=
X-Google-Smtp-Source: ACHHUZ4mG8DNk4l47Mpye1DcAycjCan2ubhYQDjtSsdDSAFpg0u7Y3GTl59+KL6DQdTEK4jfAhHYu6y33RsnFhmahHc=
X-Received: by 2002:a05:651c:87:b0:2a7:6e37:ee68 with SMTP id
 7-20020a05651c008700b002a76e37ee68mr934133ljq.12.1685458792213; Tue, 30 May
 2023 07:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000cafb9305fc4fe588@google.com> <20230528184422.596947-1-princekumarmaurya06@gmail.com>
 <20230530-zenit-radeln-06417ce5fe85@brauner>
In-Reply-To: <20230530-zenit-radeln-06417ce5fe85@brauner>
From:   Prince Kumar Maurya <princekumarmaurya06@gmail.com>
Date:   Tue, 30 May 2023 07:59:16 -0700
Message-ID: <CAF0B0eKxMf7-uzgRJcWsWW6hgxP25bPG8U9nF0by7mSNvhZmbQ@mail.gmail.com>
Subject: Re: [PATCH v3] fs/sysv: Null check to prevent null-ptr-deref bug
To:     Christian Brauner <brauner@kernel.org>
Cc:     skhan@linuxfoundation.org, viro@zeniv.linux.org.uk,
        chenzhongjin@huawei.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org,
        syzbot+aad58150cbc64ba41bdc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 30, 2023 at 1:26=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Sun, May 28, 2023 at 11:44:22AM -0700, Prince Kumar Maurya wrote:
> > sb_getblk(inode->i_sb, parent) return a null ptr and taking lock on
> > that leads to the null-ptr-deref bug.
> >
> > Reported-by: syzbot+aad58150cbc64ba41bdc@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Daad58150cbc64ba41bdc
> > Signed-off-by: Prince Kumar Maurya <princekumarmaurya06@gmail.com>
> > ---
> > Change since v2: Updated subject and added Reported-by and closes tags.
> >
> >  fs/sysv/itree.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
> > index b22764fe669c..3a6b66e719fd 100644
> > --- a/fs/sysv/itree.c
> > +++ b/fs/sysv/itree.c
> > @@ -145,6 +145,8 @@ static int alloc_branch(struct inode *inode,
> >                */
> >               parent =3D block_to_cpu(SYSV_SB(inode->i_sb), branch[n-1]=
.key);
> >               bh =3D sb_getblk(inode->i_sb, parent);
> > +             if (!bh)
> > +                     break;
>
> When you break here you'll hit:
>
> /* Allocation failed, free what we already allocated */
> for (i =3D 1; i < n; i++)
>         bforget(branch[i].bh);
> for (i =3D 0; i < n; i++)
>         sysv_free_block(inode->i_sb, branch[i].key);
>
> below. The cleanup paths were coded in the assumption that sb_getblk()
> can't fail. So bforget() can assume that branch[i].bh has been allocated
> and set up. So that bforget(branch[i].bh) is your next pending NULL
> deref afaict.


I doubt that would happen. There is a break above as well, before we do
sb_getblk().

/* Allocate the next block */
branch[n].key =3D sysv_new_block(inode->i_sb);
if (!branch[n].key)
   break;

The clean up code path runs till i is less than n not equal to n which
would have caused the problem.
