Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA04109AB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 10:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfKZJI0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 04:08:26 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46770 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfKZJI0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 04:08:26 -0500
Received: by mail-io1-f66.google.com with SMTP id i11so19625614iol.13;
        Tue, 26 Nov 2019 01:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DYoUaVnx+KyGsEJ9h6ubFDzA7o1Y91HlvowSyIB4u6g=;
        b=M7cCrpCrIZ4LCbZ4UhLXRenmizp3UHCd+p/bh+2mYkjZ6GR4ahA72n3SVUpdsuAvFR
         psm3NYTD6uX2K9VQ0NOMAk4bO/0VkWe5PJWn38Qfk/ADdSDHuiknaYAY34ZzzXv8nPG8
         sq0SbTDToltYVqXZZ83v/cNxwt7Ke1tsHPoW+ehaB5x9zsl6fgymolxzEa0VdqA8BfcN
         z2vTqzcaZ4bBxvEIintl3J1iMOOGJeD8+RwU9uRvndkyMTfTGR5+ZfjqETQzJ/KR4llJ
         j3MIwMhmjvV3fcGs/dXIzLyZPdE/ObYxIUbNjX75i9hxf5yUChqGdT/5pJ6XLaZLCK0K
         RgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DYoUaVnx+KyGsEJ9h6ubFDzA7o1Y91HlvowSyIB4u6g=;
        b=oJI0Ohom0Rtzs5YT51Yd77ZoXtAnTXM5NDyRAICqMGfDcWUcD25aAo2JTHRfgg5iU9
         dI9SEsB1aUjTJPM5bROG0olsHn7IBAAdAEmGHlyTZUdDGGkGYwzf8iSPsAFAPmsMoirY
         pwwl4VvhDUjM3nDlIYjwEbU8elxqwBxySTIK+WzI6PyuFvU3ihoZ8l6fEesvGDqAo0sF
         Sozq2rlnB6DK7LTLrKEfjULkDi2aoTxmX3d8lpyv8H7OPAnoBcSyLraZlH+ZfwGu73lA
         cwOZVwaWHyrobQvHh2pdqZdDeyVH+0we2gCtb+wCx7mQo2KLHscbqQ9Vi7E8TAUg++01
         iA7g==
X-Gm-Message-State: APjAAAUj4b086nCzabXTPOVHHjXkAG5SK4FZsNzBWYAuETLsaMlRlZ6D
        T4baD3dBWu4a5SF/jLGPnCxMrmeGLKnGkgxqfrE=
X-Google-Smtp-Source: APXvYqyfjbm1xD9vJMPlCm9jiMuFO96a0z+melj0FGo+2YH0IFHnWzUAVKCPm12COPj5QhPmhZ6Ldd257xh8VpSNgoI=
X-Received: by 2002:a02:3403:: with SMTP id x3mr31741578jae.117.1574759303686;
 Tue, 26 Nov 2019 01:08:23 -0800 (PST)
MIME-Version: 1.0
References: <20191122235324.17245-1-agruenba@redhat.com> <20191122235324.17245-4-agruenba@redhat.com>
 <20191125091508.3265wtfzpoupv2lj@box>
In-Reply-To: <20191125091508.3265wtfzpoupv2lj@box>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Tue, 26 Nov 2019 10:08:12 +0100
Message-ID: <CAHpGcMJO_bzsc+9Ta7VoKkszR2_v1BqqBZ4=7re=j7OxcX-R1w@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] gfs2: Rework read and page fault locking
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        cluster-devel <cluster-devel@redhat.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <sfrench@samba.org>,
        Bob Peterson <rpeterso@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Mo., 25. Nov. 2019 um 10:16 Uhr schrieb Kirill A. Shutemov
<kirill@shutemov.name>:
> On Sat, Nov 23, 2019 at 12:53:24AM +0100, Andreas Gruenbacher wrote:
> > @@ -778,15 +804,51 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
> >
> >  static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> >  {
> > +     struct gfs2_inode *ip;
> > +     struct gfs2_holder gh;
> > +     size_t written = 0;
>
> 'written' in a read routine?

It's a bit weird, but it's the same as in generic_file_buffered_read.

> --
>  Kirill A. Shutemov

Thanks,
Andreas
