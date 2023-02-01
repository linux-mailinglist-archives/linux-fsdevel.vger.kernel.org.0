Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16B268610C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 08:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjBAH5S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 02:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjBAH5R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:57:17 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0990783EF
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 23:57:16 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id cf42so28035822lfb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 23:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3TdS5EBKT4w54gpWVMOxRKi4LaHqPGWUt3EI4RzT6Mc=;
        b=qGi5XC3ONpLs5pYGPoG5A/gO2bbP4FruNdPm/OXt76kxjMwYy+8zNDdcKPj9zLy6K2
         wu4rrR+ugBblP1+DSUfD6K5VOhci0OnsXfiCipk9xz33jhggAdcaWVyGLlXciHirc9e+
         LziBn51lh0Hg17p+fQrogsz2at/ffVCdKg8GU7+tvZ8oMA1fRmesvLdQPF3jlhL2BiR2
         jrgliar0kdvj/GFCyHvQm229Q95h6dvK45dGadFMPc4QCqXqsiMkk8rtbVoOeDmOFuJb
         3uW24Bnd2KuasEIhjtLY9ksED8eVP4Dwiw7hBNEpPfho0rb9NY4kalIyAeyO8okntHVF
         WDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3TdS5EBKT4w54gpWVMOxRKi4LaHqPGWUt3EI4RzT6Mc=;
        b=SrGOeC6RLTMYk7gaCG+hUvw+/LamCkZBUE/JQyCekVpw88iQm4n+q8fDDmdume6XcS
         2Zj7Ee03JEqpPOoS7p7eI/cSsLRiy5IDVZSdoJhhF+2dreJvV1+SRkeHusOR5A5YSDK8
         7D5y7rZWn27qBG7I9bXHxCgWUuHPrH2OY5G8VLw21YTzKyiZuLg85cevDwU1Qztw+/Ku
         grsS69HFDJory8GpJbLl54sSs6bYrHozUa3zf7TQxTtIydZQHivblxl+fJwafoh3j5VG
         0x0+tXq9SfICIAsJHIhARBE3Z3qxr6mZ6ZGuv/q0/Jk8m4PgHzV+l+SNayWA7g0liZSP
         7ydA==
X-Gm-Message-State: AO0yUKVw15G9Dz9wbFb62id+FEWXaAusfyKohNdcWjQSQ+nGHSu/Y4cK
        kcDP0H4fLO7nDB24Aa5reFwd4cwTlcNScA1fX2efNGQxWq9V7YlJHgI=
X-Google-Smtp-Source: AK7set/T9tCY6R0hVSqJUczL9rH2cispGNdz+JU65A6PTPpilbVW3W8A5F9nvwQ7VY+sqRvwZNSQ1yk3tzH/ZJA43z8=
X-Received: by 2002:a05:6512:12c9:b0:4d4:fcdb:6376 with SMTP id
 p9-20020a05651212c900b004d4fcdb6376mr318744lfg.218.1675238233996; Tue, 31 Jan
 2023 23:57:13 -0800 (PST)
MIME-Version: 1.0
References: <000000000000be147305f0071869@google.com> <00000000000010e01905f381c827@google.com>
In-Reply-To: <00000000000010e01905f381c827@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 1 Feb 2023 08:57:01 +0100
Message-ID: <CACT4Y+b3gvrcsXq7AaCBScFk2J9cZsaHh7SUSi4Q2KE1PkN5Ew@mail.gmail.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in hfs_cat_keycmp
To:     syzbot <syzbot+883fa6a25abf9dd035ef@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, slava@dubeyko.com,
        syzkaller-bugs@googlegroups.com, zhangpeng362@huawei.com
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

On Mon, 30 Jan 2023 at 22:20, syzbot
<syzbot+883fa6a25abf9dd035ef@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit c53ed55cb275344086e32a7080a6b19cb183650b
> Author: ZhangPeng <zhangpeng362@huawei.com>
> Date:   Fri Dec 2 03:00:38 2022 +0000
>
>     hfs: Fix OOB Write in hfs_asc2mac
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13294485480000
> start commit:   3a28c2c89f4b Merge tag 'unsigned-char-6.2-for-linus' of gi..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f3de84cba2ef4a23
> dashboard link: https://syzkaller.appspot.com/bug?extid=883fa6a25abf9dd035ef
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1261813b880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114306af880000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: hfs: Fix OOB Write in hfs_asc2mac
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Hard to say if it's the fix or not, bisection diverged due to an
unrelated kernel bug. But this bug is probably fixed as well, so
without having a better candidate, let's close the report:

#syz fix: hfs: Fix OOB Write in hfs_asc2mac
