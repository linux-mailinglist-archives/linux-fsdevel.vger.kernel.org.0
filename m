Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7636F24E8C1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Aug 2020 18:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgHVQai (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Aug 2020 12:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgHVQag (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Aug 2020 12:30:36 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E0FC061573
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Aug 2020 09:30:36 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t4so3927524iln.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Aug 2020 09:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJj5TK3G7MVm+VYBo5lqKGxPSR8A7s2q6tf5foLdof4=;
        b=S75MaG1vCkClffX2X3FaZOKUXo+pwYdtuLZc6ncCVkuF7BdPWJ13mqOgHl3iDTyGt1
         ULyvbN3EPIMD26sIkvGpT8s0smqQ/4ky4VwJSoaH6CJcbOaDUgu2OfdWm1M77634TEeu
         mtteCanJgrirygtSakPKLI0b7KFcBW3CF8Ew0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJj5TK3G7MVm+VYBo5lqKGxPSR8A7s2q6tf5foLdof4=;
        b=mhTtOdYf+gBkCr1yAxmOMllDcP02dsn5pguGIsOAdzXDNk7H82bHimaokqYI1C9FBg
         xLv15eCFI5uRErbJHs/Fy1iMVe9IBH/Rpc9h9y1vvJAE9KP/QOT7QTYJlkQ5ewFa+g3f
         rzNDq94U+5OkdJuNAfAw6DrGiNvP2ABB7pKwfVp1eATgeynSHPuNUWuS1HXKzAwEqtKo
         pI+8Ywoy5an0PI5iAhMt75TWCc5QEzbM3pqWnknQbojM09R/ItbYzExq8N5VLbj4cuHX
         +5XPp20C8yY4orJf7m7E8HGeahZ0aFsUvlBre/epFVcwkRSzV+dqxs67EUw9W1G3S6wS
         bEGQ==
X-Gm-Message-State: AOAM531Kjk9g03rasvj0azxPJdj5qGNrhMnkgH0QeZ1nd9CdWHBUhsbq
        KhoWAnmPR1M8pEUp8YahczAjQcNVc34nYnB7vqZGpA==
X-Google-Smtp-Source: ABdhPJzQYZ/z0hpLgPOSs8sPRZM4W0ZXC5611Jmeb9rkOBbf1q+BiabPCpGfL1YZ9sPLlsdfHTEd3UhZNYkdnb/4Hqg=
X-Received: by 2002:a92:da49:: with SMTP id p9mr7196041ilq.233.1598113835616;
 Sat, 22 Aug 2020 09:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000045b3fe05abcced2f@google.com> <fc097a54-0384-9d21-323f-c3ca52cdb956@I-love.SAKURA.ne.jp>
 <CAHk-=wj15SDiHjP2wPiC=Ru-RrUjOuT4AoULj6N_9pVvSXaWiw@mail.gmail.com>
 <20200807053148.GA10409@redhat.com> <e673cccb-1b67-802a-84e3-6aeea4513a09@i-love.sakura.ne.jp>
 <20200810192941.GA16925@redhat.com> <d1e83b55-eb09-45e0-95f1-ece41251b036@i-love.sakura.ne.jp>
 <dc9b2681-3b84-eb74-8c88-3815beaff7f8@i-love.sakura.ne.jp> <7ba35ca4-13c1-caa3-0655-50d328304462@i-love.sakura.ne.jp>
In-Reply-To: <7ba35ca4-13c1-caa3-0655-50d328304462@i-love.sakura.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Aug 2020 09:30:25 -0700
Message-ID: <CAADWXX-wpVR5Y1Z=BH5QnMjbsGbkQT__r4D2zCFFVycMDELxOQ@mail.gmail.com>
Subject: Re: [RFC PATCH] pipe: make pipe_release() deferrable.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        syzbot <syzbot+96cc7aba7e969b1d305c@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 9:35 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Therefore, this patch tries to convert __pipe_lock() in pipe_release() to
> killable, by deferring to a workqueue context when __pipe_lock_killable()
> failed.

I don't think this is an improvement.

If somebody can delay the pipe unlock arbitrarily, you've now turned a
user-visible blocking operation into blocking a workqueue instead. So
it's still there, and now it possibly is much worse and blocks
system_wq instead.

                Linus
