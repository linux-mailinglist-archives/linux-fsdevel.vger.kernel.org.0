Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0715F10E30B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2019 19:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfLASXa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Dec 2019 13:23:30 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40208 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbfLASXa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Dec 2019 13:23:30 -0500
Received: by mail-io1-f66.google.com with SMTP id x1so3850058iop.7;
        Sun, 01 Dec 2019 10:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t4fUTcYfY7mcYP+c65DBEIJpXiFt8LYo795Cww6uf7s=;
        b=sYEA8DkLPgcYVj56eQRC2KgRU8mAoN0Y4yX4WPEted0p2cPvpxeHV6kFg1Bt5vkWpR
         GD0qlbdEIpaWZvAAvuHJcVwHwdGgHp+rI6tCcxNpZOBLSnDspMKql9uh9YDIGXzJFuLn
         fRMrIKvCs/W8X/WxPq6g7Rbh/7I6EhlodIl4g68EJyq840BDu84QIijfpeTtUl9rpecz
         iJgNwA66nKwrlcf+NNK9mP4lhDdDOop/5mV3c3K9IKg2my0o5G4K0FuGQ4R2KT1yHhMm
         G6KxM36Y3C2wav4jm4vPIVqowk/T1tRrtpCaxXOUeyNzKvlfdTyPQ5o0HhRYDioO4Lda
         8H1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t4fUTcYfY7mcYP+c65DBEIJpXiFt8LYo795Cww6uf7s=;
        b=pJ73YZz64BqgoddbW0oqG5n+UT/lY5L3SW+vITGNDD9uajt9kzuUBcU8T0yVpR28hG
         lrbWqPlRXJrfTrdC+IYShStB6I3W6K+c20qJO87RfGTUahgj/tr7P+B7qpjfnVoicVDL
         JF2yzBvFKnM7wsGQO60XA0DRsXYgo/KHb6dDUvkYKLWOJtl4my8ncSviOxBS7Vz9Q28h
         C8VPWF1q5n8dB1ERMv6sQgQcZqrIJtq5UCHHmUTM8dfcPwJFwhja5uJMVgTbwv/qwJ2y
         HCB+5PKZlGeuu8sbLf/Skw9fRE7kIO8mnLZ4SqI/XURaonQePIa+/xrJ3WqbCi3reI20
         WjAQ==
X-Gm-Message-State: APjAAAVGdG/1tyB5KbluKgltgSLEfKL0JxUZc2P1/tR1sy46+DL3mw0h
        XqxxUSj57lISo6fbMouUNlUcBaAJndCeO0V6z9c=
X-Google-Smtp-Source: APXvYqyanFaFt+dQgUwQsnQO62oDza8XXXGaXpcAuSWg6JdtXjyEKBLOhmjDYnWZuzkdL71TMBuMWyUH7OX6G5k4Dzw=
X-Received: by 2002:a5d:83c9:: with SMTP id u9mr8142629ior.272.1575224609504;
 Sun, 01 Dec 2019 10:23:29 -0800 (PST)
MIME-Version: 1.0
References: <20191130053030.7868-1-deepa.kernel@gmail.com> <20191130053030.7868-3-deepa.kernel@gmail.com>
In-Reply-To: <20191130053030.7868-3-deepa.kernel@gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 1 Dec 2019 12:23:18 -0600
Message-ID: <CAH2r5mukfX6mSY0eHwm0wHnkaLPb2RLAKxnBrScgoZJhtdYZfQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] fs: cifs: Fix atime update check vs mtime
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Steve French <stfrench@microsoft.com>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

merged into cifs-2.6.git for-next

On Fri, Nov 29, 2019 at 11:34 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> According to the comment in the code and commit log, some apps
> expect atime >= mtime; but the introduced code results in
> atime==mtime.  Fix the comparison to guard against atime<mtime.
>
> Fixes: 9b9c5bea0b96 ("cifs: do not return atime less than mtime")
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Cc: stfrench@microsoft.com
> Cc: linux-cifs@vger.kernel.org
> ---
>  fs/cifs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
> index 8a76195e8a69..ca76a9287456 100644
> --- a/fs/cifs/inode.c
> +++ b/fs/cifs/inode.c
> @@ -163,7 +163,7 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
>
>         spin_lock(&inode->i_lock);
>         /* we do not want atime to be less than mtime, it broke some apps */
> -       if (timespec64_compare(&fattr->cf_atime, &fattr->cf_mtime))
> +       if (timespec64_compare(&fattr->cf_atime, &fattr->cf_mtime) < 0)
>                 inode->i_atime = fattr->cf_mtime;
>         else
>                 inode->i_atime = fattr->cf_atime;
> --
> 2.17.1
>


-- 
Thanks,

Steve
