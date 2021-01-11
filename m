Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1AE02F10E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 12:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbhAKLPt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 06:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbhAKLPs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:15:48 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C016C061794
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jan 2021 03:15:08 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id et9so7219497qvb.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jan 2021 03:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WhzjayrC+26z6DcD7za+9LxX5P6jZQRkbedPwq22Za4=;
        b=i7jIJuQOetY7AqcjiQ2frvUYvNHYwpeQYK3C5p9b9uM+p/thMZqFgpdxCGMvte2738
         Ujpipxvxxi1ZE0+WY4hEtccyWsSc25MtmN4wwM82IebigfFhFlhaC5PNL8xp4pTzj1q+
         0JOGz8YVvozr0xNnMDdYMRHywb7a01OXhYM82g1QLjyzNMgBA9vObiptTJCPmG+b4cIV
         WS+D8XH/Ycg/ArKEi1vxvXPBPJCY8Ix4i0eJq4R8bDeBcqyA7XWyUeihJIii+cQ/grcI
         csFWME8nuY0Wp7iDBSFbG966WhqXchIKA0Rig/Tl22dD8N5o2675VXhwe6KlBr0cxXfq
         6/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WhzjayrC+26z6DcD7za+9LxX5P6jZQRkbedPwq22Za4=;
        b=iMXvsVEDn2Z0V73kSzJGTHkd9y/gF2boAlMnH0U2VFwjdJXQuapDXuFmnPcyoXPrwp
         P/y+MkH1WiRp3t3W53E0DW3bnAV+eRxAZJnJH+ONhoyD/vAhJjPBq3vxtEl+7c2WZGAm
         99bCOcBEQlsXtLGJZu9FZvGS2a/ihw7MVLBJZkFGOpf0FL4tDlloqQpUBRic7f7xkM20
         QMyT+6yzGqr8Jfs4LJKreivnTp8LO0OYmDck3gr+2UVWsFUIKZROfSaSpOsBpsiEO+I0
         9CkCTrOWwgkTmtIhA46FcbOHXea/fQBNQcUcMZ7/9EftzvMk0kjKKR3VLgNUiTuOvlD4
         SyoA==
X-Gm-Message-State: AOAM530MylMhOCEPkt83ksRoYkGRNNPR9tlQo2yNrIHKBNaD5dUUErRz
        rcY0H1OLZjGedeFheFRdvQ6wP+zI//AdgburP6yuMg==
X-Google-Smtp-Source: ABdhPJwaY/DZskeWJ/wgN51FKdecZhvZzj1LdP6oa+j7e6irK8NFeteAUbGt8m8Nm5D2XdcA72PzB3gj6cscE6+dvMQ=
X-Received: by 2002:a0c:edab:: with SMTP id h11mr15064043qvr.23.1610363707075;
 Mon, 11 Jan 2021 03:15:07 -0800 (PST)
MIME-Version: 1.0
References: <000000000000b0bbc905b05ab8d5@google.com> <000000000000b4098905b872801e@google.com>
In-Reply-To: <000000000000b4098905b872801e@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 11 Jan 2021 12:14:56 +0100
Message-ID: <CACT4Y+YbY+jjvEppMwSKkt2gWh2qhHvFPzmbARxGe84RzBLWCg@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in __lookup_slow
To:     syzbot <syzbot+3db80bbf66b88d68af9d@syzkaller.appspotmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rkovhaev@gmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 9, 2021 at 8:20 AM syzbot
<syzbot+3db80bbf66b88d68af9d@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit d24396c5290ba8ab04ba505176874c4e04a2d53c
> Author: Rustam Kovhaev <rkovhaev@gmail.com>
> Date:   Sun Nov 1 14:09:58 2020 +0000
>
>     reiserfs: add check for an invalid ih_entry_count
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=111480e7500000
> start commit:   a68a0262 mm/madvise: remove racy mm ownership check
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e597c2b53c984cd8
> dashboard link: https://syzkaller.appspot.com/bug?extid=3db80bbf66b88d68af9d
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1737b8a7500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1697246b500000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: reiserfs: add check for an invalid ih_entry_count
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks realistic.

#syz fix: reiserfs: add check for an invalid ih_entry_count
