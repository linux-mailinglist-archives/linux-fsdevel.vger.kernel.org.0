Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10422FACC7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 22:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394822AbhARVgJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 16:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389454AbhARKDc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:03:32 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220EEC061575;
        Mon, 18 Jan 2021 02:02:20 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id p18so10596042pgm.11;
        Mon, 18 Jan 2021 02:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u0FOmzDZmk+RTcNWhNFAwsw/QXvXPx1t1kmnlGL7Ml4=;
        b=pQ8CHoBpqH/kB2/AsbSyH/z6bRNRXb5zD9PTlyEBiEjpxwXT4IWVUTzutdnUMpezWD
         9kLTG+21uaWeYk4vgwV3JiBIVVWHsUwVRAojA4WGKJ5/TNA/trvDDlGiltGAhAIv6nb/
         DvdafN+nZBiqN1oqB3F6KH3KGXrSsDD6E1910g3ZGlgpskMlhyXU/gwVDB9WHY5r3fCY
         QGFRZ6YqEhUO8MgxK4WgG+XBEXUyDhDcUzKQF/25635P72VSRFXkvHuqnxrxUbSg4DFa
         RKsx6yelS6q8bIRlvje/OG2vuaI8plyiEHDfGtFxFccHRod4yhfqHfsyiZQtvO8e5Nwi
         +puQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u0FOmzDZmk+RTcNWhNFAwsw/QXvXPx1t1kmnlGL7Ml4=;
        b=oJNfhm3FjW6RThD/sD6DNBXkw+s+aMetDBcagJejiqcQ4s162lhDtcaI+IK0cctJt+
         at/3+wDoa2O8gGSJPgIY0wL0k+1h3EHBtLiMuK3NfUHg3Oel/+Fb2y2CUqkq94bI/3x/
         OGF196sze0rocTf+qUnl49q0b88s6iNp1OhgNAM3sZPYMAw6/Y8Q8FZQY+8xKSFSt87K
         j8sby81oamsRqQKJyIYsQQyKLwrfPu1GppFGnUten2lAq1cGA51CU5NGgV6kRTRV09To
         AxDvZ1K5jvus31ZWmYNJI11ckpZYeUE24fdYMir1HQ34GODPBlno7iyOk8bYL8RTnZTH
         F+JA==
X-Gm-Message-State: AOAM531HvGP8QdqTJq9UJ8X3lUB6p1MXggw5R9Qp6e3toYDWBLhdihXK
        QgGAg00wjJAFyfdDa+XWsY4BOXJCi3l+rLdfgbQ=
X-Google-Smtp-Source: ABdhPJySPSGdHUH+ZvJKOjKcaZ4mf37K5+6HxotmPOlywyp6HnN7j4tELiDqh3CPosgIggQSBwqjLqN5PPKmpcQPFUg=
X-Received: by 2002:a63:4b16:: with SMTP id y22mr25224503pga.203.1610964139615;
 Mon, 18 Jan 2021 02:02:19 -0800 (PST)
MIME-Version: 1.0
References: <20210116220950.47078-1-timur@kernel.org> <20210116220950.47078-2-timur@kernel.org>
In-Reply-To: <20210116220950.47078-2-timur@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Jan 2021 12:03:08 +0200
Message-ID: <CAHp75Vdk6y8dGNJOswZwfOeva_sqVcw-f=yYgf_rptjHXxfZvw@mail.gmail.com>
Subject: Re: [PATCH 1/2] [v2] lib/hexdump: introduce DUMP_PREFIX_UNHASHED for
 unhashed addresses
To:     Timur Tabi <timur@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, roman.fietze@magna.com,
        Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-mm <linux-mm@kvack.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 17, 2021 at 12:12 AM Timur Tabi <timur@kernel.org> wrote:

(Hint: -v<n> to the git format-patch will create a versioned subject
prefix for you automatically)

> Hashed addresses are useless in hexdumps unless you're comparing
> with other hashed addresses, which is unlikely.  However, there's
> no need to break existing code, so introduce a new prefix type
> that prints unhashed addresses.

Any user of this? (For the record, I don't see any other mail except this one)

...

>  enum {
>         DUMP_PREFIX_NONE,
>         DUMP_PREFIX_ADDRESS,
> -       DUMP_PREFIX_OFFSET
> +       DUMP_PREFIX_OFFSET,
> +       DUMP_PREFIX_UNHASHED,

Since it's an address, I would like to group them together, i.e. put
after DUMP_PREFIX_ADDRESS.
Perhaps even add _ADDRESS to DUMP_PREFIX_UNHASHED, but this maybe too long.

>  };

...

> + * @prefix_type: controls whether prefix of an offset, hashed address,
> + *  unhashed address, or none is printed (%DUMP_PREFIX_OFFSET,
> + *  %DUMP_PREFIX_ADDRESS, %DUMP_PREFIX_UNHASHED, %DUMP_PREFIX_NONE)

Yeah, exactly, here you use different ordering.

...

> + * @prefix_type: controls whether prefix of an offset, hashed address,
> + *  unhashed address, or none is printed (%DUMP_PREFIX_OFFSET,
> + *  %DUMP_PREFIX_ADDRESS, %DUMP_PREFIX_UNHASHED, %DUMP_PREFIX_NONE)

In both cases I would rather use colon and list one per line. What do you think?

...

> +               case DUMP_PREFIX_UNHASHED:

Here is a third type of ordering, can you please be consistent?

>                 case DUMP_PREFIX_ADDRESS:

...

> + * @prefix_type: controls whether prefix of an offset, hashed address,
> + *  unhashed address, or none is printed (%DUMP_PREFIX_OFFSET,
> + *  %DUMP_PREFIX_ADDRESS, %DUMP_PREFIX_UNHASHED, %DUMP_PREFIX_NONE)

As above.

...

> +               case DUMP_PREFIX_UNHASHED:

As above.

>                 case DUMP_PREFIX_ADDRESS:


-- 
With Best Regards,
Andy Shevchenko
