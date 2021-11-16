Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9444536DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 17:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238841AbhKPQHy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 11:07:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30497 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238807AbhKPQHx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 11:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637078695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IQYqrYWzH5LMm02dblZ0VbWUHvwdTF0Rr46Metf8L3g=;
        b=Uav/75OcjYp1prq8/9vVfTUWRowJnEHXveMJr+pPhWCl2ZGZZCpoA2FoxTZagOEczEUpai
        UkctwNSE+c4FS1+M1aL82M15mI7niOYIQ+EdyWQ3bMHi/asP1c2hiiINRqLq1dz5g8LbI/
        Aq1xKdBTBbWKYMVF5TJDuN+ocpqpl8g=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-9YRix7cEM52fDwZmRAhV2A-1; Tue, 16 Nov 2021 11:04:54 -0500
X-MC-Unique: 9YRix7cEM52fDwZmRAhV2A-1
Received: by mail-qk1-f198.google.com with SMTP id bk21-20020a05620a1a1500b004631b196a46so14044201qkb.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 08:04:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IQYqrYWzH5LMm02dblZ0VbWUHvwdTF0Rr46Metf8L3g=;
        b=fTSBI+lxE6XOelytz8p6nkT6SJooml/BlHte9fjUUGfHN/3WiX8GRqGfP+Xiq/18R4
         VSDv13Q9eqaxwzkRy2AuXqIv6adz80pzF30wSdkkC9Yyrc3Ox8Ubp4eLuWqy2G5LDFxA
         4xUFH/KSmwUN1e7IJVrhBhzWVQ02UM92FcMw6vfORATBSOpyDNzj1OhEfal/Dwpppp1P
         r1Dg0YGhIHU17DaHUPsp0mQqt2DOkyyuAtd/HNfPmH1U+brS+uxyVyJF1QCpJ0zwRMzU
         0QlEQzGLmcpF2Pc+hQ7acZ4/TLOJESZT8m5IiG/nlO1NrNfaKTf27sK/2gLYTzIDarsk
         Q20g==
X-Gm-Message-State: AOAM533zZqDCSfjQ6FHF1nBWoR7ECRbo+nJ2Veqzf3Lbz6l8gmBlMBS8
        e0z+jAqtI//JE71dIO9QssIN5RQdUSIgIFDJ0OGZBzg7iAHWte6TrD38ELFOa4iZ0/M7rLF3prx
        s82fBOPOQhuVzT6Mq8X4RZ7O/xw==
X-Received: by 2002:ac8:5787:: with SMTP id v7mr8755675qta.79.1637078693510;
        Tue, 16 Nov 2021 08:04:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1VmixXkHPd8zrvy0yn0CKnKhyT/INH+jtxoy7BwJ1qOemuevJEj2WkOO1YOifT68fo90R1Q==
X-Received: by 2002:ac8:5787:: with SMTP id v7mr8755630qta.79.1637078693258;
        Tue, 16 Nov 2021 08:04:53 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id f18sm8939102qko.34.2021.11.16.08.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 08:04:52 -0800 (PST)
Date:   Tue, 16 Nov 2021 11:04:50 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Dave Chinner <david@fromorbit.com>, Ian Kent <raven@themaw.net>,
        xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] xfs: make sure link path does not go away at access
Message-ID: <YZPWoj6mM/N2reKz@bfoster>
References: <163660195990.22525.6041281669106537689.stgit@mickey.themaw.net>
 <163660197073.22525.11235124150551283676.stgit@mickey.themaw.net>
 <20211112003249.GL449541@dread.disaster.area>
 <CAJfpegvHDM_Mtc8+ASAcmNLd6RiRM+KutjBOoycun_Oq2=+p=w@mail.gmail.com>
 <20211114231834.GM449541@dread.disaster.area>
 <CAJfpegu4BwJD1JKngsrzUs7h82cYDGpxv0R1om=WGhOOb6pZ2Q@mail.gmail.com>
 <20211115222417.GO449541@dread.disaster.area>
 <f8425d1270fe011897e7e14eaa6ba8a77c1ed077.camel@themaw.net>
 <20211116030120.GQ449541@dread.disaster.area>
 <CAJfpegsvL6SjNZdk=J9N-gYWZK0uhg_bT579WRHyVisW1sGZ=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsvL6SjNZdk=J9N-gYWZK0uhg_bT579WRHyVisW1sGZ=Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 16, 2021 at 11:12:13AM +0100, Miklos Szeredi wrote:
> On Tue, 16 Nov 2021 at 04:01, Dave Chinner <david@fromorbit.com> wrote:
> 
> > I *think* that just zeroing the buffer means the race condition
> > means the link resolves as either wholly intact, partially zeroed
> > with trailing zeros in the length, wholly zeroed or zero length.
> > Nothing will crash, the link string is always null terminated even
> > if the length is wrong, and so nothing bad should happen as a result
> > of zeroing the symlink buffer when it gets evicted from the VFS
> > inode cache after unlink.
> 
> That's my thinking.  However, modifying the buffer while it is being
> processed does seem pretty ugly, and I have to admit that I don't
> understand why this needs to be done in either XFS or EXT4.
> 

Agreed. I'm also not following what problem this is intended to solve..?

Hmm.. it looks to me that the ext4 code zeroes the symlink to
accommodate its own truncate/teardown code because it will access the
field via a structure to interpret it as a (empty?) data mapping. IOW,
it doesn't seem to have anything to do with the vfs or path
walks/lookups but rather is an internal implementation detail of ext4.
It would probably be best if somebody who knows ext4 better could
comment on that before we take anything from it. Of course, there is the
fact that ext4 doing this seemingly doesn't disturb/explode the vfs, but
really neither does the current XFS code so it's kind of hard to say
whether one approach is any more or less correct purely based on the
fact that the code exists.

Brian

> > The root cause is "allowing an inode to be reused without waiting
> > for an RCU grace period to expire". This might seem pedantic, but
> > "without waiting for an rcu grace period to expire" is the important
> > part of the problem (i.e. the bug), not the "allowing an inode to be
> > reused" bit.
> 
> Yes.
> 
> Thanks,
> Miklos
> 

