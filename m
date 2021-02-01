Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FED630A2FC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 09:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhBAIE3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 03:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbhBAIEY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 03:04:24 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D9AC061574
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Feb 2021 00:03:44 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id u20so3691583qvx.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Feb 2021 00:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cXn86J6LQUtvcwGvVgVroC1EKW3nlsBMdzpnDrpbexI=;
        b=LZEP2FQVaqbuugiD+wkAkDLFkGEe1vcP/5OdiWUwRnNcyZTFDGMJHkIOCdSmf6Hjcp
         RsroPUwipXmUHOM9hmiGJun7qLXFyjoYj4WZlHIKyLmNyHsGtEf+JM/2A164iUpbvCfR
         LlqVSvZHPuf+NyaHoKFNXJL2WDW9ahRmAnH0n6AknrabqsHV1khHF4vQo8xZs2D9X3ds
         9JCSDJ7mZJJgQTLQUmKd0KSoRh4oQqGpX9/h/ZNNrT94ZuZY/cXFp1u6izoMmGzxPRO5
         QJ94jJwWDeXNo0Bw89se0rALGLXBf2wkK/6yBPkyNNgKQvbLlplDzo13eSxShUrlnug4
         8MpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cXn86J6LQUtvcwGvVgVroC1EKW3nlsBMdzpnDrpbexI=;
        b=ZYDMGjrjn0VDn7JruOFMWjKYq0V6Re7MDrY7B7o4YoIkugCrt2SPVR7knagRONEnsq
         erkZKqLpQaSEf40zLDwon+0Ms5jTpyqfFCG9xwDM2epMQ44a7EfrdCUWUK9pVj2S3Tn1
         6F8bi/tIqKL4uAHbCWWF/Qj7yvo+XNzEJDmS+2p4RfBbtpLzbm2FJ6ehCG4xkQ6Q2puP
         Kt3WWK1JSd5a9vh3Ia9Xu72xKkT+H+UjVETT722TMj1Y+oBI3ZPNguWjjWxpQVyyyqYs
         AfwCtefuzKUFVVHkuAWFnVP7cmDE9YZY7ljA0u8hn9nVVRioR0yg4oLfMnr4YqkS6KGV
         ii3g==
X-Gm-Message-State: AOAM530RCPZVFoNdZ2wa55T74qE+w0OdMkSthZ4lQns/R6h2ykK/DEEQ
        l8wkALw75D+QwqsprBeJ2SH668d+BvVjWfk7ThiB+w==
X-Google-Smtp-Source: ABdhPJwQD44dY6kzIgqv+4vx6DT+iNgIEwfIQL6g4Ii2qq9ht6rpaqYUpv9alyGlgU4XV1SXbr1NG+i6TQk3jlUwWPs=
X-Received: by 2002:a0c:8304:: with SMTP id j4mr14500567qva.18.1612166623600;
 Mon, 01 Feb 2021 00:03:43 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d4b96a05aedda7e2@google.com> <00000000000079a40e05ba0d702f@google.com>
In-Reply-To: <00000000000079a40e05ba0d702f@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 1 Feb 2021 09:03:32 +0100
Message-ID: <CACT4Y+Z4OprUOs6Asp-L=UCM_VGARKremp-w594Dp6dDenoUXQ@mail.gmail.com>
Subject: Re: possible deadlock in send_sigio (2)
To:     syzbot <syzbot+907b8537e3b0e55151fc@syzkaller.appspotmail.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 29, 2021 at 6:36 PM syzbot
<syzbot+907b8537e3b0e55151fc@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 8d1ddb5e79374fb277985a6b3faa2ed8631c5b4c
> Author: Boqun Feng <boqun.feng@gmail.com>
> Date:   Thu Nov 5 06:23:51 2020 +0000
>
>     fcntl: Fix potential deadlock in send_sig{io, urg}()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17455db4d00000
> start commit:   7b1b868e Merge tag 'for-linus' of git://git.kernel.org/pub..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3416bb960d5c705d
> dashboard link: https://syzkaller.appspot.com/bug?extid=907b8537e3b0e55151fc
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163e046b500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f8b623500000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: fcntl: Fix potential deadlock in send_sig{io, urg}()
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: fcntl: Fix potential deadlock in send_sig{io, urg}()
