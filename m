Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83D2880090
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 21:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387787AbfHBTBK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 15:01:10 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45735 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbfHBTBK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 15:01:10 -0400
Received: by mail-qt1-f195.google.com with SMTP id x22so1590065qtp.12;
        Fri, 02 Aug 2019 12:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=HwHE8/q9xzAY4G3Znjg3gltYqWjAP9OihVXjGw/qZCs=;
        b=KyzX80aqVpqwmIE4Tlf/5KxAtU0syDphLDcd8EvXc/7QyOko1SfGukW/JAOMXEusRL
         41485eRBnUXDKigcnkaOIL++Y+vVVEabJjCpTuy/+3AhdabbubQZrv6Ou+oZrTunBP2F
         bAwadcUXE1a76fwE0MXnl57Dx/9ZMNzY9VNYcv+3Np1iIDSQZcUASaFefCsQ0AdJdN0K
         PL1JoC48zZyhrdKgbiKAeWjUtnbJ9yc+AS7hrJquhw0hBC0O9wiKQYsBn5vB505jNhP3
         I23zhg9oHWLPlO3g5kcC3xLkNnCBt+UKWNsLztwuCCoMSk+VG9yLlJ/f9nskDBzr36St
         JCsA==
X-Gm-Message-State: APjAAAWphOhrXRA+MRY3oih7y7EYiH+L3kUPEk0z4uKu/sRN/4fei0Rb
        ZLUfQlNE9+gzqjAMYlbTDvg/x4m6OnD9t5pp2xE=
X-Google-Smtp-Source: APXvYqxdH3F1KFPszuUkeqoRxQ5r3LJXOoFIyUXh4hFNFtLNtJlWlOJ73mPzmJf5XnVk+WnFpqrI54lRQ7IZEsv9sN0=
X-Received: by 2002:a0c:ba2c:: with SMTP id w44mr97441239qvf.62.1564772468886;
 Fri, 02 Aug 2019 12:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190730014924.2193-1-deepa.kernel@gmail.com> <20190730014924.2193-10-deepa.kernel@gmail.com>
 <20190731152609.GB7077@magnolia> <CABeXuvpiom9eQi0y7PAwAypUP1ezKKRfbh-Yqr8+Sbio=QtUJQ@mail.gmail.com>
 <20190801224344.GC17372@mit.edu> <CAK8P3a3nqmWBXBiFL1kGmJ7yQ_=5S4Kok0YVB3VMFVBuYjFGOQ@mail.gmail.com>
 <20190802154341.GB4308@mit.edu>
In-Reply-To: <20190802154341.GB4308@mit.edu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 2 Aug 2019 21:00:52 +0200
Message-ID: <CAK8P3a1Z+nuvBA92K2ORpdjQ+i7KrjOXCFud7fFg4n73Fqx_8Q@mail.gmail.com>
Subject: Re: [PATCH 09/20] ext4: Initialize timestamps limits
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 2, 2019 at 5:43 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Fri, Aug 02, 2019 at 12:39:41PM +0200, Arnd Bergmann wrote:
> > Is it correct to assume that this kind of file would have to be
> > created using the ext3.ko file system implementation that was
> > removed in linux-4.3, but not usiing ext2.ko or ext4.ko (which
> > would always set the extended timestamps even in "-t ext2" or
> > "-t ext3" mode)?
>
> Correct.  Some of the enterprise distro's were using ext4 to support
> "mount -t ext3" even before 4.3.  There's a CONFIG option to enable
> using ext4 for ext2 or ext3 if they aren't enabled.
>
> > If we check for s_min_extra_isize instead of s_inode_size
> > to determine s_time_gran/s_time_max, we would warn
> > at mount time as well as and consistently truncate all
> > timestamps to full 32-bit seconds, regardless of whether
> > there is actually space or not.
> >
> > Alternatively, we could warn if s_min_extra_isize is
> > too small, but use i_inode_size to determine
> > s_time_gran/s_time_max anyway.
>
> Even with ext4, s_min_extra_isize doesn't guarantee that will be able
> to expand the inode.  This can fail if (a) we aren't able to expand
> existing the transaction handle because there isn't enough space in
> the journal, or (b) there is already an external xattr block which is
> also full, so there is no space to evacuate an extended attribute out
> of the inode's extra space.

I must have misunderstood what the field says. I expected that
with s_min_extra_isize set beyond the nanosecond fields, there
would be a guarantee that all inodes have at least as many
extra bytes already allocated. What circumstances would lead to
an i_extra_isize smaller than s_min_extra_isize?

> We could be more aggressive by trying to expand make room in the inode
> in ext4_iget (when we're reading in the inode, assuming the file
> system isn't mounted read/only), instead of in the middle of
> mark_inode_dirty().  That will eliminate failure mode (a) --- which is
> statistically rare --- but it won't eliminate failure mode (b).
>
> Ultimately, the question is which is worse: having a timestamp be
> wrong, or randomly dropping an xattr from the inode to make room for
> the extended timestamp.  We've come down on it being less harmful to
> have the timestamp be wrong.
>
> But again, this is a pretty rare case.  I'm not convinced it's worth
> stressing about, since it's going to require multiple things to go
> wrong before a timestamp will be bad.

Agreed, I'm not overly worried about this happening frequently,
I'd just feel better if we could reliably warn about the few instances
that might theoretically be affected.

        Arnd
