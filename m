Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB9F8F460
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 21:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732134AbfHOTUv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 15:20:51 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33800 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbfHOTUu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 15:20:50 -0400
Received: by mail-qk1-f196.google.com with SMTP id m10so2811586qkk.1;
        Thu, 15 Aug 2019 12:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j0lUY9T5fW9DD8Z/WYckZ7IOSLlu2YMChdXw9ONqN60=;
        b=uYlU9pMmwmXULnKEMB51Cdc9LsMwfZDVEFxhjYL5MToOBup0WetBpBmUY3mAGi5W0g
         7JCKYWefKVUJYwBER0d5w08jh/9vDyTHrYF0noASjA1RIV/CIebgiQgxhM59ZypRj9aP
         4XjmheUqEJNKa49vsASgoRE1zQg1kpZtRnIg8XwQxV37gTxy0hEEcAtEKuLhdf9NBH6e
         2jqJ39VX9w8eIgp1w9Z5+mkH9cXr9i75ymq1gpjmJtZjlvmI1bGMBE6RY/tuC43WP4jq
         SYw3c8hRi/K81G8r2Tvm/y6RzRYeaLpXvXUwpVNt2NL6XG5AdVK646flEWzvIktPL5Ch
         dnUA==
X-Gm-Message-State: APjAAAXfRPFI5s4ZtaSa5Phvz8+VgWRMDvSI1L+jpL0Gq2m4PQL/S06c
        uB6Ef5lHNK1mLswmXuZ45FX5VkyTgW5aeXVQ0SM=
X-Google-Smtp-Source: APXvYqxX/tHpG9h/OJBhMq363Q18QRmF3x01hoRWTAAzITEuCxNGnYVfEJbyDSvcOIWBAaVl9ipsiC+7TX8uI+zxqbI=
X-Received: by 2002:a37:4fcf:: with SMTP id d198mr5521517qkb.394.1565896849491;
 Thu, 15 Aug 2019 12:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190814204259.120942-1-arnd@arndb.de> <20190814204259.120942-2-arnd@arndb.de>
 <20190814213753.GP6129@dread.disaster.area> <20190815071314.GA6960@infradead.org>
 <CAK8P3a2Hjfd49XY18cDr04ZpvC5ZBGudzxqpCesbSsDf1ydmSA@mail.gmail.com>
 <20190815080211.GA17055@infradead.org> <20190815102649.GA10821@infradead.org>
 <20190815121511.GR6129@dread.disaster.area> <20190815140355.GA11012@infradead.org>
In-Reply-To: <20190815140355.GA11012@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 15 Aug 2019 21:20:32 +0200
Message-ID: <CAK8P3a1iNu7m=gy-NauXVBky+cBk8TPWwfWXO4gSw1mRPJefJA@mail.gmail.com>
Subject: Re: [PATCH v5 01/18] xfs: compat_ioctl: use compat_ptr()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Allison Collins <allison.henderson@oracle.com>,
        Nick Bowler <nbowler@draconx.ca>,
        Eric Sandeen <sandeen@sandeen.net>,
        Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 15, 2019 at 4:04 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Aug 15, 2019 at 10:15:12PM +1000, Dave Chinner wrote:
> > > http://git.infradead.org/users/hch/xfs.git/shortlog/refs/heads/xfs-ioctl-table
> >
> > Lots to like in that handful of patches. :)
> >
> > It can easily go before or after Arnd's patch, and the merge
> > conflict either way would be minor, so I'm not really fussed either
> > way this gets sorted out...
>
> The other thing we could do is to just pick the two important ones:
>
> http://git.infradead.org/users/hch/xfs.git/shortlog/refs/heads/xfs-ioctl-table-5.3
>
> and throw that into Arnds series, or even 5.3, and then defer the
> table thing until later.

If we can have your "xfs: fall back to native ioctls for unhandled compat
ones" in 5.3, that would be ideal from my side, then I can just drop the
corresponding patch from my series and have the rest merged for 5.4.

The compat_ptr addition is independent of my series, I just added it
because I noticed it was missing, so we can merged that through
the xfs tree along with your other changes, either for 5.3 or 5.4.

     Arnd
