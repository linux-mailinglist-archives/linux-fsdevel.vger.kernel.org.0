Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7324F80847
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2019 22:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbfHCUZA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Aug 2019 16:25:00 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43849 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbfHCUZA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Aug 2019 16:25:00 -0400
Received: by mail-qt1-f195.google.com with SMTP id w17so33089786qto.10;
        Sat, 03 Aug 2019 13:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=VdhoUOanDkL0mYCbX93qeFusFFgrb24fTk0uYfQw5IU=;
        b=ocz2P00v4jUeDm9hvTmRm1ADYwLtcdzMfkfdsd+24mZ/VUwsw8FF2bizHR2BC7h6SB
         z1ju+6qkTNJyFN1V8U1Huba8sNQJRCf3EJYxyA9ORgg6ttnn42SoGzUrd4fLcuikZ+tj
         mTKLxjYR37xNB6qC0kwNt/Qv9Mpp8ux5ypZOoIA7r/j2pI7GUHm5yoIKUIk0Un/uyDym
         9cZwtj6Tqa2jyMap+QMQzNvBRrgNK9/9o7cYyYqpHXSl3GhKWLbWgFkk9RQeObmPWGvk
         2ve36w++07g/xDjozWHpsRPuKR9I0OgMpc4rzcelLA3PAf5EbYSsQHlm/aASU9y49UIr
         9Gig==
X-Gm-Message-State: APjAAAX7f2JQ5sHsHjOzU/avOI79WcNKHhnMzDVhOy5r/6W2YqtjRZGz
        lojpl+ISj8AAjKZo8mWSFt5WtvOYir1JR3rAuRkNF95qhCg=
X-Google-Smtp-Source: APXvYqzwNuiHEwBJsvHa2lzvXYFpQ48mrGOK361GHHlRlTbyMsgK6QppANcDBKzAtvNs7boJfFUs6EnRPA5GnzLaTvg=
X-Received: by 2002:aed:33a4:: with SMTP id v33mr98525406qtd.18.1564863898922;
 Sat, 03 Aug 2019 13:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190730014924.2193-1-deepa.kernel@gmail.com> <20190730014924.2193-10-deepa.kernel@gmail.com>
 <20190731152609.GB7077@magnolia> <CABeXuvpiom9eQi0y7PAwAypUP1ezKKRfbh-Yqr8+Sbio=QtUJQ@mail.gmail.com>
 <20190801224344.GC17372@mit.edu> <CAK8P3a3nqmWBXBiFL1kGmJ7yQ_=5S4Kok0YVB3VMFVBuYjFGOQ@mail.gmail.com>
 <20190802154341.GB4308@mit.edu> <CAK8P3a1Z+nuvBA92K2ORpdjQ+i7KrjOXCFud7fFg4n73Fqx_8Q@mail.gmail.com>
 <20190802213944.GE4308@mit.edu> <CAK8P3a2z+ZpyONnC+KE1eDbtQ7m2m3xifDhfWe6JTCPPRB0S=g@mail.gmail.com>
 <20190803160257.GG4308@mit.edu>
In-Reply-To: <20190803160257.GG4308@mit.edu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 3 Aug 2019 22:24:41 +0200
Message-ID: <CAK8P3a0aTsz4f6FgXf7NSAG+aVpd1rhZvFU_E4v8AY_stvhJtQ@mail.gmail.com>
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

On Sat, Aug 3, 2019 at 6:03 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Sat, Aug 03, 2019 at 11:30:22AM +0200, Arnd Bergmann wrote:
> >
> > I see in the ext4 code that we always try to expand i_extra_size
> > to s_want_extra_isize in ext4_mark_inode_dirty(), and that
> > s_want_extra_isize is always at least  s_min_extra_isize, so
> > we constantly try to expand the inode to fit.
>
> Yes, we *try*.  But we may not succeed.  There may actually be a
> problem here if the cause is due to there simply is no space in the
> external xattr block, so we might try and try every time we try to
> modify that inode, and it would be a performance mess.  If it's due to
> there being no room in the current transaction, then it's highly
> likely it will succeed the next time.
>
> > Did older versions of ext4 or ext3 ignore s_min_extra_isize
> > when creating inodes despite
> > EXT4_FEATURE_RO_COMPAT_EXTRA_ISIZE,
> > or is there another possibility I'm missing?
>
> s_min_extra_isize could get changed in order to make room for some new
> file system feature --- such as extended timestamps.

Ok, that explains it. I assumed s_min_extra_isize was meant to
not be modifiable, and did not find a way to change it using the
kernel or tune2fs, but now I can see that debugfs can set it.

> If you want to pretend that file systems never get upgraded, then life
> is much simpler.  The general approach is that for less-sophisticated
> customers (e.g., most people running enterprise distros) file system
> upgrades are not a thing.  But for sophisticated users, we do try to
> make thing work for people who are aware of the risks / caveats /
> rough edges.  Google won't have been able to upgrade thousands and
> thousands of servers in data centers all over the world if we limited
> ourselves to Red Hat's support restrictions.  Backup / reformat /
> restore really isn't a practical rollout strategy for many exabytes of
> file systems.
>
> It sounds like your safety checks / warnings are mostly targeted at
> low-information customers, no?

Yes, that seems like a reasonable compromise: just warn based
on s_min_extra_isize, and assume that anyone who used debugfs
to set s_min_extra_isize to a higher value from an ext3 file system
during the migration to ext4 was aware of the risks already.

That leaves the question of what we should set the s_time_gran
and s_time_max to on a superblock with s_min_extra_isize<16
and s_want_extra_isize>=16.

If we base it on s_min_extra_isize, we never try to set a timestamp
later than 2038 and so will never fail, but anyone with a grandfathered
s_min_extra_isize from ext3 won't be able to set extended
timestamps on any files any more. Based on s_want_extra_isize
we would keep the current behavior, but could add a custom
warning in the ext4 code about the small s_min_extra_isize
indicating a theoretical problem.

       Arnd
