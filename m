Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 571D080590
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2019 11:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388163AbfHCJak (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Aug 2019 05:30:40 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41912 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388140AbfHCJak (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Aug 2019 05:30:40 -0400
Received: by mail-qt1-f196.google.com with SMTP id d17so76331326qtj.8;
        Sat, 03 Aug 2019 02:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=BUfh4NxGQN1WIWZ152CfoTRhLbNLi4Uy13kK/K7CPCc=;
        b=LzDMYFyJ0ECBB1Ekk7q+iNNfQOQXEA8DPlWve+Bl6fIhzdMP52n1tRw4ntu04cKFlj
         LsJoDxumS6xwI0LfDBKS+lhTvyJQeU7Wh6D21Ii+v0klSAD3QKfSOcGpzEYnYoBaIWPs
         wIijOEJ7xHES4YNQhqDx31NjLg+eAA05Kk4bsCQ0T0RRO3FwyLkD42VD92zipWqsyYRl
         Q0ELXjDfIT160D2lL7ugT3wMj7bUomkQU4NI64PW3VEn9XbKQRos5/GwtTNHO8K5BbS8
         5YZOksRSHrDLK+3KV0t1RngK1AYlszX7YGKC918sEct6KZ74F45/utl9iRfk4FtzjchD
         HIKA==
X-Gm-Message-State: APjAAAUlZ6G+/Q0LtkCUbAgXyz+T7d1ehA6J+lezKsHtDRUZP7LVZZF9
        DB0+hLdmpTJHL3D5GCgVTQfQIxU8QP5d570b0HM=
X-Google-Smtp-Source: APXvYqyXtfQi0lUgu2D3IFo2YqBiZxJux1z3dlGHPMbfRF4H4JO7dlKXPH9YSzYE67/+Rg7dimTjiwQeNxG5iuCt60k=
X-Received: by 2002:aed:33a4:: with SMTP id v33mr96576727qtd.18.1564824638551;
 Sat, 03 Aug 2019 02:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190730014924.2193-1-deepa.kernel@gmail.com> <20190730014924.2193-10-deepa.kernel@gmail.com>
 <20190731152609.GB7077@magnolia> <CABeXuvpiom9eQi0y7PAwAypUP1ezKKRfbh-Yqr8+Sbio=QtUJQ@mail.gmail.com>
 <20190801224344.GC17372@mit.edu> <CAK8P3a3nqmWBXBiFL1kGmJ7yQ_=5S4Kok0YVB3VMFVBuYjFGOQ@mail.gmail.com>
 <20190802154341.GB4308@mit.edu> <CAK8P3a1Z+nuvBA92K2ORpdjQ+i7KrjOXCFud7fFg4n73Fqx_8Q@mail.gmail.com>
 <20190802213944.GE4308@mit.edu>
In-Reply-To: <20190802213944.GE4308@mit.edu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 3 Aug 2019 11:30:22 +0200
Message-ID: <CAK8P3a2z+ZpyONnC+KE1eDbtQ7m2m3xifDhfWe6JTCPPRB0S=g@mail.gmail.com>
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

On Fri, Aug 2, 2019 at 11:39 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Fri, Aug 02, 2019 at 09:00:52PM +0200, Arnd Bergmann wrote:
> >
> > I must have misunderstood what the field says. I expected that
> > with s_min_extra_isize set beyond the nanosecond fields, there
> > would be a guarantee that all inodes have at least as many
> > extra bytes already allocated. What circumstances would lead to
> > an i_extra_isize smaller than s_min_extra_isize?
>
> When allocating new inodes, i_extra_isize is set to
> s_want_extra_isize.  When modifying existing inodes, if i_extra_isize
> is less than s_min_extra_isize, then we will attempt to move out
> extended attribute(s) to the external xattr block.  So the
> s_min_extra_isize field is not a guarantee, but rather an aspirationa
> goal.  The idea is that at some point when we want to enable a new
> feature, which needs more extra inode space, we can adjust
> s_min_extra_size and s_want_extra_size, and the file system will
> migrate things to meet these constraints.

I see in the ext4 code that we always try to expand i_extra_size
to s_want_extra_isize in ext4_mark_inode_dirty(), and that
s_want_extra_isize is always at least  s_min_extra_isize, so
we constantly try to expand the inode to fit.

What I still don't see is how any inode on the file system
image could have ended up with less than s_min_extra_isize
in the first place if s_min_extra_isize is never modified and
all inodes in the file system would have originally been
created with  i_extra_isize >= s_min_extra_isize if
EXT4_FEATURE_RO_COMPAT_EXTRA_ISIZE is set.

Did older versions of ext4 or ext3 ignore s_min_extra_isize
when creating inodes despite
EXT4_FEATURE_RO_COMPAT_EXTRA_ISIZE,
or is there another possibility I'm missing?

> Since the extended timestamps were one of the first extra inode fields
> to be added, I strongly suggest that we not try to borrow trouble.
> Solving the general case problem is *hard*.

As I said before, I absolutely don't suggest we solve the problem
of reliably setting the timestamps, I'm just trying to find out if there
is a way to know for sure that it cannot happen and alert the user
otherwise. So far I think we have concluded

- just checking s_inode_size is not sufficient because ext3
  may have created inodes with s_extra_isize too small
- checking s_min_extra_isize may not be sufficient either, for
  similar reasons I don't yet fully understand (see above).

If there is any other way to be sure that the file system
has never been mounted as a writable ext3, maybe that can
be used instead?

        Arnd
