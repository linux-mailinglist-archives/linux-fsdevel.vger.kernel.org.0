Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240AA2AF28D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 14:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgKKNwT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 08:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgKKNwR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:52:17 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747CEC0613D1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2020 05:52:17 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id d9so1646129qke.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2020 05:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m80oT1JfZEh7w9pLk5CWjzhWzy3pvKhfVuBt46eLCBw=;
        b=ruYOIkEm/5N7tXFU9wnoobpSSwg6ScTTQcUGJl4xQvztJCtpHPICTHlzj52Ws0uUn0
         DC39qewbtysvAam0v/xotz7/Fo/BfTQtsNPVxofXvrtftF0tCiNaYDfUIgL3/+AImpV1
         d2QoUb5xBzp/rwuCfttZ1GNLH5ro9M7FyxelmSHEwvahc7zT9p5tAxaEydOUjI0ph3VL
         /U7adurRdeyE1Nz9Hum4FnJP49bOIH+1/UOVEfJWELAu3VkFK67PQwJLNCNtudVqXgXE
         /WgORiHN6IFJ1Gn4SY8n+rWQxkD1FtqPdzf9LeAJ8ymLniGa0IATUJb22l/Mq1lULOUt
         G0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m80oT1JfZEh7w9pLk5CWjzhWzy3pvKhfVuBt46eLCBw=;
        b=WztR1EtQGwyH8Y3561yiRh0fF4ybN0KaywD/Chn/i0pRxJdTVWqUWKnAod5mp+zD5D
         2X7pNanx61yFub1xX3U7AJjN9eeMAIJNXOUQgv9N/kKvAKr6a4gypLLxuhnALct1a+M9
         Mg/cr6ejY4elBCCVR+sVaXyQnGkgzOZWDpNXc5HDSp6oQmOgmGdsbZQR07fietTWcO+U
         IhElE9cXz+i7x+vdcTa/4A3tlU/MFR9WW8BZrg2DHqqxL1DxeTXuuTj/eA7gc8rscv9v
         UJNOdZVRzDjcw1WEuo09MFXVQwCfw6/apGPIhkjBj6YpwCRmBZECXywQvRXk7SJtTQd3
         peMQ==
X-Gm-Message-State: AOAM533NP5fcSgnbL/alUXr4hVH2VXZ1tWQwUlbbTHJK3Isk5RpY3RVM
        gY8OH1frE5iJyHahkUEFcEWkAXVhA1hiDZMI4UrFlVydkBRjO7Oq
X-Google-Smtp-Source: ABdhPJyqhSwQAMi7KabE5H8i99YpFBEAgyBaMgInJ4zyZ3IFflyUyoUrw58EdIQt6hUjGikYX6RbliJBfZjpbkt8VXQ=
X-Received: by 2002:a37:49d6:: with SMTP id w205mr25091516qka.501.1605102736439;
 Wed, 11 Nov 2020 05:52:16 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d03eea0571adfe83@google.com> <000000000000ad052105b383350a@google.com>
In-Reply-To: <000000000000ad052105b383350a@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 11 Nov 2020 14:52:05 +0100
Message-ID: <CACT4Y+Z=WF1jbjjSX0hWSJXqUpNGJgwW=f2tBFkJH=mSjyMqag@mail.gmail.com>
Subject: Re: possible deadlock in mnt_want_write
To:     syzbot <syzbot+ae82084b07d0297e566b@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Cc:     Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 7, 2020 at 1:10 PM syzbot
<syzbot+ae82084b07d0297e566b@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 146d62e5a5867fbf84490d82455718bfb10fe824
> Author: Amir Goldstein <amir73il@gmail.com>
> Date:   Thu Apr 18 14:42:08 2019 +0000
>
>     ovl: detect overlapping layers
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11e40184500000
> start commit:   6d906f99 Merge tag 'arm64-fixes' of git://git.kernel.org/p..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=856fc6d0fbbeede9
> dashboard link: https://syzkaller.appspot.com/bug?extid=ae82084b07d0297e566b
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111767b7200000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1611ab2d200000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: ovl: detect overlapping layers
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: ovl: detect overlapping layers
