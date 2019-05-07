Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4289166A7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 17:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfEGP01 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 11:26:27 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:36204 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfEGP01 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 11:26:27 -0400
Received: by mail-lf1-f53.google.com with SMTP id y10so5500921lfl.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2019 08:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zGb+C4J2ZQEo2uiHQjELQi51pO+PnDuoy7pBmyobCrM=;
        b=SrH+6QVunecyBjJEIDK/V9/t4Jn4OPoJK5VB8KPZwbilmGOV1SNlbKM5aRkVvwa9mK
         3VR8SJQGs0gMHYCb2N/nIdYjUMqGvxytnygTlMNGJ0Reeuw1rbJE5awwz4U6cp3+OKFk
         7CBeKKIX5i3QgVau8NLSWS6K+DWLWTQ0LyRlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zGb+C4J2ZQEo2uiHQjELQi51pO+PnDuoy7pBmyobCrM=;
        b=fVRjVZso+Z2l/ALy+3miP9USmyaO0JgAsoKtmFOw5StQeCJyL4Zwji644lO5uWxYQg
         BuR9ZXsRAAgvcVtXJwlpaEoiVL/nmou1yImTiVAy1UaOpp8WIlhTNGK1RRIClBgwDsJS
         TYkiH8pOhdvQ8Mdo13ERh2z4myQ00XdrabQ6d6uBKWd0GGQQ5OT6N7+xrQ18GFRns9fV
         6nimfGGvGdn2wGHV177my6iHieaJnfygLm1W/YzcG40H7Jjyv8ySYz3AhtWq4SXJHh0x
         BPlE5z5RLMrBTttWNA3HS40Vj8Upst2TTRWFghz2kGObeOZOUbQEHnz29h2bqSREFeyr
         Rwrw==
X-Gm-Message-State: APjAAAWXF5EcGmGnFAwrCKRtnfgEERcqkTpZUTp84nrmrgbqsCpedpM3
        Vj4ycNHNkGDWXpcr0Skk8uced3tMxKI=
X-Google-Smtp-Source: APXvYqymvZpJwrYh7I9xJx37iBYd2MUhKJj+QTBLn8XjGviqB26SkyAdB5g8VOrQk4n4/Qx0JMmQpw==
X-Received: by 2002:a19:c746:: with SMTP id x67mr16665791lff.152.1557242784441;
        Tue, 07 May 2019 08:26:24 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id g5sm3239529ljk.59.2019.05.07.08.26.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 08:26:23 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id r76so3654423lja.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2019 08:26:22 -0700 (PDT)
X-Received: by 2002:a2e:9044:: with SMTP id n4mr2600678ljg.94.1557242782514;
 Tue, 07 May 2019 08:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <af9a8dec-98a2-896f-448b-04ded0af95f0@huawei.com>
 <20190507004046.GE23075@ZenIV.linux.org.uk> <CAHk-=wjjK16yyug_5-xjPjXniE_T9tzQwxW45JJOHb=ho9kqrA@mail.gmail.com>
 <20190507041552.GH23075@ZenIV.linux.org.uk>
In-Reply-To: <20190507041552.GH23075@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 May 2019 08:26:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiQ-SdFKP_7TpM3qzNR85S8mxhpzMG0U-H-t4+KRiP35g@mail.gmail.com>
Message-ID: <CAHk-=wiQ-SdFKP_7TpM3qzNR85S8mxhpzMG0U-H-t4+KRiP35g@mail.gmail.com>
Subject: Re: system panic while dentry reference count overflow
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     yangerkun <yangerkun@huawei.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        yi.zhang@huawei.com, houtao1@huawei.com, miaoxie@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 6, 2019 at 9:15 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Umm...  Where would you put the cutoff for try_dget()?  1G?  Because
> 2G-<something relatively small> is risky - have it reached, then
> get the rest of the way to 2G by normal dget() and you've got trouble.

I'd make the limit be 2G exactly like the page count. Negative counts
are fine - they work exactly like large integers. It's only 0 that is
special.

So do something like this:

 - make dget() WARN_ONCE(), and perhaps set a flag to start background
dentry pruning, if the dentry count is negative ("big integer") after
the lockref_get()

 - add a try_dget(), which returns the dentry or NULL (and is
"must_check") and just refuses to increment the ref past the 2G mark

 - add the "limit negative dentries" patches that were already written
for other reasons by Waiman Long.

 - and exactly like the page ref count, the negative values can be
tested non-atomically without worrying about races, because it's not a
"hard" limit.  It takes a *looong* time (and a lot of memory) to go
from 2G to actually overflowing

 - for the same "not a hard limit", use try_dget() in a couple of
strategic places that are easy to error out for and that are
particularly easily user-triggerable. It's not clear if this is even
needed, since the only obviously user-triggerable case is the negative
dentry one - everything else really needs an actual user ref, and the
soft "start to try to prune if any dentry ref goes negative" will take
care of the "we just have a ton of unused but cached dentries case.

All pretty much exactly like the page count.

The fact that we have that "slop" of 2 _billion_ references between
"oh, the recount went negative" and "oops, now we overflowed and that
would be fatal" really means that we have a lot of time and
flexibility to handle things. If an attacker has to open two billion
files, the attacker is going to spend a lot of time that we can
mitigate.

               Linus
