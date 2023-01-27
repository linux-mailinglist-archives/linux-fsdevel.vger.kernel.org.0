Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DF167DE62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 08:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjA0HR1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 02:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjA0HR0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 02:17:26 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A3B3B0C8
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 23:17:25 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id d30so6761426lfv.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 23:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t6JX9N8YU0ZRqNe6wufmk02qXuxOtdyVljTACCKEcGg=;
        b=nCK59OAyOOqOuLFK6Msjex5na6gejqRtW7VDdGlgPWnyiNabSGmrz7xdV4mqU3MqyM
         v6DJjMDP33gKhfCVwArnR6xC3FzIlt/bymM3F0CX/1HfuciggqhLllB12otkqPBTn8kY
         4jb075vjMBa+69RYRSSHiElBLHGhX+kLWqEW4oVSyjjCT3zrCGCQV7MRWFLKrcEtVJeM
         /twxQvRNx4ANELvYUaL18ZlQO+f9MoICnKhERkjgLbk3KGcsbBZ19tI31HJ3/soqvueX
         U0WegXVbXbx3VP7jTRF2SvYcI1gGZF/DoYzE043MQ7F2xwgcfonn99UaD3YdpD+nOlbF
         tjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t6JX9N8YU0ZRqNe6wufmk02qXuxOtdyVljTACCKEcGg=;
        b=pejns9zSHuvjW2/Y8CdbkgacPbub3glb4JCTywj6dt65KqWvY6kmtQExTX1Hp4l1Hq
         ENJafZYKeqkvlkIwHNN3+iWlZXC0ajfUy6Z2pZNUBzguHygK9T5WRXrREQj7lXMoVg/6
         XreqXmi7UGCiTB6BJ2cYD3BLQstMHr6fOlZAQHxgSXLC0tw7lfbTijsdr5vtbp0GjBzq
         MyOGg9p0dnJOqDPRgq5EKwRUIMHc97t/qV1eCFYIPdDYmeRESOyZ82x5Ezr13Cr3ZMHR
         +EutYkL96HM4C4qdNuI1BGJQ+kvy9RyayIkZeOpOMf7tZbxOuiqeWZvFbXMlwXOZEvy/
         b4Ug==
X-Gm-Message-State: AFqh2kp5L0Wngmd5sVZ5Ea8juKB/ZCEMVT15qXodBSXPRMgPIIWbPb+g
        3fq7ZG9yAa9hDF4/uPJQusPptxjDkFBqY7VJ6VFxdg==
X-Google-Smtp-Source: AMrXdXs0v6Ue3yA4k8NUfTIYEvwqIAxkwxmjFuIPuay9e+m8eQqDdhAU2niVaLWNAdVcke53Mmk9l92bsjfzZz2pOUI=
X-Received: by 2002:ac2:508f:0:b0:4cb:7c2:87ee with SMTP id
 f15-20020ac2508f000000b004cb07c287eemr3927074lfm.165.1674803843191; Thu, 26
 Jan 2023 23:17:23 -0800 (PST)
MIME-Version: 1.0
References: <000000000000e4630c05e974c1eb@google.com> <000000000000defd4b05f2feb35c@google.com>
In-Reply-To: <000000000000defd4b05f2feb35c@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 27 Jan 2023 08:17:11 +0100
Message-ID: <CACT4Y+Y7CDqyXq87bh=eXfpQz2Xdu=8HV5pojnNd2Xv6x-4G9Q@mail.gmail.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in evict
To:     syzbot <syzbot+6b74cf8fcd7378d8be7c@syzkaller.appspotmail.com>
Cc:     feldsherov@google.com, hirofumi@mail.parknet.co.jp, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 24 Jan 2023 at 09:57, syzbot
<syzbot+6b74cf8fcd7378d8be7c@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 4e3c51f4e805291b057d12f5dda5aeb50a538dc4
> Author: Svyatoslav Feldsherov <feldsherov@google.com>
> Date:   Tue Nov 15 20:20:01 2022 +0000
>
>     fs: do not update freeing inode i_io_list
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=111208cd480000
> start commit:   b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
> dashboard link: https://syzkaller.appspot.com/bug?extid=6b74cf8fcd7378d8be7c
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1353a3e2880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16163dce880000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: fs: do not update freeing inode i_io_list
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks reasonable. Let's close the bug report:

#syz fix: fs: do not update freeing inode i_io_list
