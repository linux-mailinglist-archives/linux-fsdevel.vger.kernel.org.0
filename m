Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29F1751EB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 12:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjGMKRm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 06:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbjGMKRa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:17:30 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6162735
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 03:17:27 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbd33a1819so52765e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 03:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689243446; x=1691835446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgTfpf6IMD+zAdQw7gG1t68xyEykfaw6L7r/eLwpcfM=;
        b=QXKfcJsGmoR2FM+lAmlHzHe6q7yhlyPrQsB+vj6KfUt6Bb2e8m8BQf+lpKGL7vFgJo
         /qZh3y1iyMzKappWzYzKoDn2Rxfd+N6uaAr16XWKSmVi+bOYgmEOm/n32Eq/oDdpfOPu
         pjTEImKYTahfoNfD4b1rE87Fy8swF5uKyvdgAP6bfdgnLbRNQ4wU9Fhb9K00BWInbz5X
         Dft/1S1COT/pG2C2MPHxeIVnpI7Xx7r2Q2PmXJbQpQEtFq54SC4aoORGeD+J480O/bTo
         ovGRzW5PUnr/06tkzkmgEVgnzXTGYofZ4L3Elq1nV9Di4/OyJsbGG6q3VLnPhjMfoc6z
         He5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689243446; x=1691835446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgTfpf6IMD+zAdQw7gG1t68xyEykfaw6L7r/eLwpcfM=;
        b=FJn057RX3uWQaoCZmKYd6jg6inaMgeivbSwUs9GNUKWlREDUPGnKm0gVJYq413QZjg
         9Fxw6+zM4UUkrCJyVRNgmKrJXoLQYTDZljr1mRujqKaMbIPM5xs2x3OathEVSuvg6ebC
         BPGmLW8fD+OlVUwfdTEpE3GTH2+oEdOmq05AMXo0+Lbj4imtilgVW7x9PGORauDQ8vNS
         SC2vPfOF1T5hAVklrApKR6QtyBA9BY8K77oMY8qsVAjshqNqN2nOS9PCfWL9Djdco3nV
         Ha9x0PtUbpUn7ioHx+0aTzRjlnOKmDzJhBhUwlJ3hHFLXiuAByknb3o9NyzTkYio6LTx
         htLQ==
X-Gm-Message-State: ABy/qLZYyptNhgpJRw7TesK9sEdL2RsT4yTfP5sr56Tth9wvCd8zu6OO
        phyVPZwRxHHUHTEKXt5UpoZazFVXipMvuuSwQpmhzg==
X-Google-Smtp-Source: APBJJlELuWCfdGb2EDMi3fT5s3Ym2+WxWmUEY6LSu7hPmkiTxSseEO2OPLfVUEJVsYNHI5Mbp/NFKXW02jQC8YiyH48=
X-Received: by 2002:a05:600c:1c9a:b0:3f6:f4b:d4a6 with SMTP id
 k26-20020a05600c1c9a00b003f60f4bd4a6mr179255wms.7.1689243446227; Thu, 13 Jul
 2023 03:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000009408f05e977da5d@google.com> <00000000000085151506005b1491@google.com>
In-Reply-To: <00000000000085151506005b1491@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 13 Jul 2023 12:17:13 +0200
Message-ID: <CANp29Y4y1T6T6VBCGxOP2aDSf-2zRBgFOJEbxZT_Figd=gNm0A@mail.gmail.com>
Subject: Re: [syzbot] [ntfs3?] general protection fault in d_flags_for_inode
To:     syzbot <syzbot+2f012b85ac8ce9be92e5@syzkaller.appspotmail.com>
Cc:     almaz.alexandrovich@paragon-software.com, hverkuil-cisco@xs4all.nl,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 13, 2023 at 11:37=E2=80=AFAM syzbot
<syzbot+2f012b85ac8ce9be92e5@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit c43784c856483dded7956175b5786e27af6d87f1
> Author: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Date:   Thu Dec 8 07:51:32 2022 +0000
>
>     media: v4l2-mem2mem: use vb2_is_streaming()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D17e7d1bca8=
0000

No, that's apparently unrelated. Though I don't see where exactly the
bisection went astray..
Likely because the reproducer got quite unreliable at older commits
and we made a few false "git bisect good" commands.

We will soon start automatically discarding such bisection results:
https://github.com/google/syzkaller/pull/4028

> start commit:   4da34b7d175d Merge tag 'thermal-6.1-rc2' of git://git.ker=
n..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dea03ca4517608=
0bc
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D2f012b85ac8ce9b=
e92e5
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D17834f9a880=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10edf52688000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: media: v4l2-mem2mem: use vb2_is_streaming()

>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> --
