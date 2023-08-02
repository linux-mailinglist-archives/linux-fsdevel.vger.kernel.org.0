Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB4976CFFF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 16:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjHBO1M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 10:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjHBO1K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:27:10 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F577272D
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 07:27:08 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe32ec7201so56285e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Aug 2023 07:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690986427; x=1691591227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7NE4BqcxOTAM1FXdBRtUyCLd0auS/l4RfesziLuyeU=;
        b=w3+G/MlFOQ4FCLai9RRniwpTTBXS9EUQi9tdWYIztNtf7PWUPb2RSj+dfp7fUKo6a1
         5jrqOxExWvN8aEHWc3E+9pAr3jTb/aK4TYnqDlmIBqGTIOP9ih0YbzgErTYajSHP5XWA
         +1pzMcTNXPtcA9+k3het2rZ3ysB7ejSMIdWtLvUvoBaqPt2pHiRiJOgBNH0Yrn+G8PEe
         Hy0yILIkNTvCxt6uihI0H2iEYHnyjo6L2CKU0hOfUlZ/+xdA6wXevJJWS6skHEaFn3dn
         d96bbJdZD2akyGY9BlDqxsBFOFBPlmCVc6q+0gMualvtlQ86q58y7cCJIaPJa5mX4e+b
         DlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690986427; x=1691591227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7NE4BqcxOTAM1FXdBRtUyCLd0auS/l4RfesziLuyeU=;
        b=KrkmQ3B09xtutE7WwmpHbDIVmXhVUFsNImb6R8397UWoz069Y2qTEZRQxqR8WZnKqI
         N3uMyiBPlPGAgJseUAxmXA/y+N3+x0wIP5fGIKZWxlIWaCjKH0WS/6v49cgDmZrVnXw7
         NHQksu6f2xZtDyeOvI9j9vtDK5rYWHYT/vF0sBeuL00qrSdOvopsjrb54ZfkyM1zY52X
         HO0peUOZ+bzKiTBIfl6LEWVtRV5eQHkrJp0AcDNF121qTLaMkIWqkVQrvqeioMUgRecp
         GuNozRwYGTHwB3AmlxlknZiP9aUTQ+nGf0aPYQlC8n+AXxc6zxerC8CK/RYrGekXsp45
         HOfQ==
X-Gm-Message-State: ABy/qLagGLJah4bNztxiuVPah1U9Z6cm0BYFVh9prNJNF1YWgdkE+zyN
        6EaWb5aOhRH7TTszrSy4MmymtteaojTpt67ITg0CCw==
X-Google-Smtp-Source: APBJJlGdKDlmTdjAVJFjYw+jb6H3+upJ/VfB7N/IyLinOQZAGY3YKZ7Q/5RLmI7ogwSKbkCk2ZCzzgHV51lf7ytXuRM=
X-Received: by 2002:a05:600c:1f0a:b0:3f7:e59f:2183 with SMTP id
 bd10-20020a05600c1f0a00b003f7e59f2183mr358065wmb.5.1690986426694; Wed, 02 Aug
 2023 07:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000af3d3105ff38ee3c@google.com> <00000000000099695a0601e5ecfb@google.com>
In-Reply-To: <00000000000099695a0601e5ecfb@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 2 Aug 2023 16:26:54 +0200
Message-ID: <CANp29Y4RFKPWBv+=ExNtud=CR2sAPR29H-KxV7R+HSiwjh3GvA@mail.gmail.com>
Subject: Re: [syzbot] [f2fs?] general protection fault in f2fs_drop_extent_tree
To:     syzbot <syzbot+f4649be1be739e030111@syzkaller.appspotmail.com>
Cc:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 2, 2023 at 2:41=E2=80=AFAM syzbot
<syzbot+f4649be1be739e030111@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 458c15dfbce62c35fefd9ca637b20a051309c9f1
> Author: Chao Yu <chao@kernel.org>
> Date:   Tue May 23 03:58:22 2023 +0000
>
>     f2fs: don't reset unchangable mount option in f2fs_remount()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D12461d31a8=
0000
> start commit:   a92b7d26c743 Merge tag 'drm-fixes-2023-06-23' of git://an=
o..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D2cbd298d0aff1=
140
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Df4649be1be739e0=
30111
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1564afb0a80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D166928c728000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: f2fs: don't reset unchangable mount option in f2fs_remount()

Looks reasonable.
#syz fix: f2fs: don't reset unchangable mount option in f2fs_remount()

>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
