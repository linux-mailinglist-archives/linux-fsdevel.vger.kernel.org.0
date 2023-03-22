Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511EB6C58CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 22:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCVVbO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 17:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjCVVbN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 17:31:13 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44FF2A99D
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 14:31:10 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3e0965f70ecso136061cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 14:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679520670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wEKZhlQAu726bgeMuDzkySzeNEKVGJce+bxSvYEcNM=;
        b=jCucsYrWvoPjrhLIENEly2ZisO6krZ+olExBdfyWKJZioLGx2oLkh1bObUsgrUD4Ug
         u/tuSWDUnZThiSQyRNkiHK8+YDUyGHXuMg+7cNYPAcXwEOZRDPyx4MmuZMGujAG7kvZ8
         qbkYUMcc9Jxa2768ETZ5OqdPFBrH/XZqKvZtHcUr6L+Zo8/enYX/uPiEifBIDgGHWtfY
         haa/1lEY9luMNAK8TjL4xdB35wY7NEnUKwoAmZWXdoSFBiXtbuvTdwbmnhpoqfgHjg61
         wpTYZzODt8nWOqz/8ceegmadmljRHR42k2QFPnCT67iEVpvMY1b25d49mWCMQvrhSpNb
         FY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679520670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wEKZhlQAu726bgeMuDzkySzeNEKVGJce+bxSvYEcNM=;
        b=EFbVarJzTw5zr13+u7f7YM2CWGANbwtUcL+O6TY5QjbRunJLvoRb8J1Fkz/+UboSAF
         05BFMpbtX8H31+aGcluLLzgx6VwfWgH6aU5f1mlz1w4q4IKE0L9KKxS8d9OYCVOu6LMB
         5nR0HodXIVO3tljGqBKcBT9DdOF573NTxcCu1a5LtAMW1cL5HSBEg3rU0obn/1qDiKaP
         KrBAsKZjigF0L4lGPUycBaR/WFofPnUj0QcJQO3Wj+0liRHLFZxRh6m6XSz1rIsm6OQd
         dzhut/EI6EUNdz3LtrBveOphaEEL7N2PnZ0ACSDlOptM1s+RKwA4nfg4eP5O4290q9l9
         pAcA==
X-Gm-Message-State: AO0yUKXmElDdfaocS7I2VGDTkK8QfRrN2Gmw17SUyWbWbBPESCWzFP8c
        XKOYMLEEkm0WXUuPj71jzPbeNiXWKTWwvdapVqhtVQ==
X-Google-Smtp-Source: AK7set8dAA9X5jZ4SI5t4EGhpF9Z/S8IrtQBBb3s3Aj9WOlWnWvbXjv7wWMrfprsfCBL8Jw6QggtqaxE+q0hlQRygkI=
X-Received: by 2002:a05:622a:1702:b0:3bc:d1b5:8e31 with SMTP id
 h2-20020a05622a170200b003bcd1b58e31mr470500qtk.19.1679520669697; Wed, 22 Mar
 2023 14:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000000ece5005eaa8f1d1@google.com> <0000000000007af84a05f77fa920@google.com>
In-Reply-To: <0000000000007af84a05f77fa920@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 22 Mar 2023 22:30:58 +0100
Message-ID: <CANp29Y5825vdNCe1JUmasczU5AkNPKKWBzPUmjbNxKj3EapG4w@mail.gmail.com>
Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbAllocBits
To:     syzbot <syzbot+b9ba793adebb63e56dba@syzkaller.appspotmail.com>
Cc:     dave.kleikamp@oracle.com, jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        liushixin2@huawei.com, shaggy@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-13.2 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 22, 2023 at 5:29=E2=80=AFPM syzbot
<syzbot+b9ba793adebb63e56dba@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit fad376fce0af58deebc5075b8539dc05bf639af3
> Author: Liu Shixin via Jfs-discussion <jfs-discussion@lists.sourceforge.n=
et>
> Date:   Thu Nov 3 03:01:59 2022 +0000
>
>     fs/jfs: fix shift exponent db_agl2size negative
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D12d90bf6c8=
0000
> start commit:   a6afa4199d3d Merge tag 'mailbox-v6.1' of git://git.linaro=
...
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd19f5d16783f9=
01
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Db9ba793adebb63e=
56dba
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1322ae34880=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10403c9488000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: fs/jfs: fix shift exponent db_agl2size negative
>


Looks reasonable.

#syz fix: fs/jfs: fix shift exponent db_agl2size negative
