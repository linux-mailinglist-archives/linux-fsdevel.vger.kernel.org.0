Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993C8294B05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 12:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409392AbgJUKCn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 06:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404937AbgJUKCn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 06:02:43 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213A3C0613CF
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2020 03:02:43 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id ev17so752635qvb.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2020 03:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xnb4S5hkq6BURUu/rhTqWY2zD92VHkscM9v42h9u1pw=;
        b=hPrRgAJdSC9qgVYpqs58Djiy9jW7qX/2bOcA8PsLyLnk3K1IGTECBQ/KiluBPINYDQ
         qZr5HUze1+k8N4bzqGycnnB+OTxTqaO/om2fNwBIUYiQEP0RvCVUhhVMzVnu7bdh+FaX
         5VCndHuJIIwBX51m5oEzhCp7InBg1Mh5BkLffXNCXvQWEE3OlSLfHj/1mIGnzUoIAxX+
         xKm/sz4YuuMm+Kz670DVwS25DzZI/nbKmlnEOooY7MfRJrUDRvrRAdPwZqijX6Tv00Zx
         pk3Qat3/7503P5DLdrupPPH7m+tr/vnMAMNfWv1MQQOcW1OgKuQWM1a2NyUJnLu8gwtM
         Lf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xnb4S5hkq6BURUu/rhTqWY2zD92VHkscM9v42h9u1pw=;
        b=Lp+BwV8L0AfratekC3piJ5wYJrncVZfnfZfvYWxjBBucDmIkawJ/sL3Ige8yumaDjQ
         Ois8Ut7NVG7GDtB1LtnTPCXLh1qrJ98Ry6GS95hGGAnxC2vxLSXlBH6VkXtNlkDaoIA+
         tbe3ufLzTCjWaxvhTstT2RLyDZL/JutZb83zJXa9Inu+38kYncJP8ACshIAazu2DnMYu
         vVmNliHzlhtqWYf4HmfTjk1h/gSOOPtduIwtf92Jogkfk4y37zOsJ1k+YQpPx/VI7gOw
         /hrHvV3/ABiAfgplnzTE6ILHQg2Tt9ur8++gnn5gl9rNHRaKhA9wKhgSwHHJvie+BNmZ
         dN7Q==
X-Gm-Message-State: AOAM533vxoggDhZmbtUzgSgpSCU91t9HEV56iBdUhOKHe/evLhsdbp5C
        CUITq2Nl59xj54SuWoNen/iqQjA9u3/MuLh9knQXIw==
X-Google-Smtp-Source: ABdhPJxh8i5rMjF7h2nMwGGOMnC8tgzLYSjRpt6RrRJ5khqmyTmwJYQMBrV92PQMbIU+pniLsWEpTce2a2RX9VFcM/8=
X-Received: by 2002:a0c:ba2a:: with SMTP id w42mr1949961qvf.23.1603274561877;
 Wed, 21 Oct 2020 03:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000010295205b1c553d5@google.com> <a7cac632aa89ed30c5c6deb9c67f428810aed9cb.camel@lca.pw>
 <1039be9b-ddb9-4f76-fda3-55d10f0bd286@kernel.dk>
In-Reply-To: <1039be9b-ddb9-4f76-fda3-55d10f0bd286@kernel.dk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 21 Oct 2020 12:02:30 +0200
Message-ID: <CACT4Y+YB=co8j2Hv1EhfnfEH0Qj9f=OtTXO=X3Wtu1=aBeAR1A@mail.gmail.com>
Subject: Re: WARNING: suspicious RCU usage in io_init_identity
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Qian Cai <cai@lca.pw>, io-uring@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+4596e1fcf98efa7d1745@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 16, 2020 at 5:05 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 10/16/20 9:02 AM, Qian Cai wrote:
> > On Fri, 2020-10-16 at 01:12 -0700, syzbot wrote:
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    b2926c10 Add linux-next specific files for 20201016
> >> git tree:       linux-next
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=12fc877f900000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=6160209582f55fb1
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=4596e1fcf98efa7d1745
> >> compiler:       gcc (GCC) 10.1.0-syz 20200507
> >>
> >> Unfortunately, I don't have any reproducer for this issue yet.
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> Reported-by: syzbot+4596e1fcf98efa7d1745@syzkaller.appspotmail.com
> >>
> >> =============================
> >> WARNING: suspicious RCU usage
> >> 5.9.0-next-20201016-syzkaller #0 Not tainted
> >> -----------------------------
> >> include/linux/cgroup.h:494 suspicious rcu_dereference_check() usage!
> >
> > Introduced by the linux-next commits:
> >
> > 07950f53f85b ("io_uring: COW io_identity on mismatch")
> >
> > Can't find the patchset was posted anywhere. Anyway, this should fix it?
>
> It's just in testing... I already folded in this change.

Now that it's in linux-next we can close this report:

#syz fix: io_uring: COW io_identity on mismatch
