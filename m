Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E664D452EC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 11:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbhKPKPc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 05:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbhKPKP0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:15:26 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A54C061208
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 02:12:25 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id n6so24629650uak.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 02:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Qo9WTf+qMiV4n2eNNwXHVAXMVEUZatbTf4RK8Hr38o=;
        b=Yau4QzFPgdwlQz1BghwNyui0lwtXQlf4Is9n/gOlP5QjDEA3CFGt9CwSQlt/d5tmlk
         3fJyJcCupX8CLg/ffWyLwl2BvodkjzESKoC1BNbiASfKD2EF8+vuL3F5cjsDlAtT+4P+
         1UstLtv2uolUzCkEfjfrk7AA6Gp6IBWAhz7sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Qo9WTf+qMiV4n2eNNwXHVAXMVEUZatbTf4RK8Hr38o=;
        b=a9gCJZDDjSOGQX3cPxzhu4vGaJacCVt9CSNz4MmPg/KUd+Iy3aR9P+nfOxGPSl3/7y
         H51UZiC6uRBcggsV5qvkNlMc/lOljNsHWlmOeIdgrg465YhFP9RxrwTs9pV3WSO+pYgA
         6RNd4P6IxRIQwS5YDe14ZwPtNlhQzQu0psZsHtiOWML6HgCp0HYE2dJ7Y2Bjl9g+X6h6
         twInPqjHDuC/jHDOiPcaRg8JQ7YS80WwDh3hNjC4Mqb6UoEXY+LFol3nO2XUoex60S7B
         jskseBqw552DW+X/EAmSKV0LURkO38eH1yAJur1e/b5FsyEuW3MiPvNPmthhbIvpYIc6
         w4Qw==
X-Gm-Message-State: AOAM532++wBDsy9B/YYkMrP9L0Mi42d1qusQNYPG9Wa+lgbz/jE3AWZR
        sbpjHOPXnOrmz3gS0h4bP2ntMoIt4cNtQalOMA1a1g==
X-Google-Smtp-Source: ABdhPJwLkRmBrkYHCLR4uh7iDnvFVkyXtpUJ0H8oJbrZW1pAZVKF8+eZdqTdczzBh0bA/ch5Cyk/JSYY8R+n1M/eAqA=
X-Received: by 2002:a05:6102:38d4:: with SMTP id k20mr54374911vst.42.1637057544021;
 Tue, 16 Nov 2021 02:12:24 -0800 (PST)
MIME-Version: 1.0
References: <163660195990.22525.6041281669106537689.stgit@mickey.themaw.net>
 <163660197073.22525.11235124150551283676.stgit@mickey.themaw.net>
 <20211112003249.GL449541@dread.disaster.area> <CAJfpegvHDM_Mtc8+ASAcmNLd6RiRM+KutjBOoycun_Oq2=+p=w@mail.gmail.com>
 <20211114231834.GM449541@dread.disaster.area> <CAJfpegu4BwJD1JKngsrzUs7h82cYDGpxv0R1om=WGhOOb6pZ2Q@mail.gmail.com>
 <20211115222417.GO449541@dread.disaster.area> <f8425d1270fe011897e7e14eaa6ba8a77c1ed077.camel@themaw.net>
 <20211116030120.GQ449541@dread.disaster.area>
In-Reply-To: <20211116030120.GQ449541@dread.disaster.area>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 16 Nov 2021 11:12:13 +0100
Message-ID: <CAJfpegsvL6SjNZdk=J9N-gYWZK0uhg_bT579WRHyVisW1sGZ=Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] xfs: make sure link path does not go away at access
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ian Kent <raven@themaw.net>, xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 16 Nov 2021 at 04:01, Dave Chinner <david@fromorbit.com> wrote:

> I *think* that just zeroing the buffer means the race condition
> means the link resolves as either wholly intact, partially zeroed
> with trailing zeros in the length, wholly zeroed or zero length.
> Nothing will crash, the link string is always null terminated even
> if the length is wrong, and so nothing bad should happen as a result
> of zeroing the symlink buffer when it gets evicted from the VFS
> inode cache after unlink.

That's my thinking.  However, modifying the buffer while it is being
processed does seem pretty ugly, and I have to admit that I don't
understand why this needs to be done in either XFS or EXT4.

> The root cause is "allowing an inode to be reused without waiting
> for an RCU grace period to expire". This might seem pedantic, but
> "without waiting for an rcu grace period to expire" is the important
> part of the problem (i.e. the bug), not the "allowing an inode to be
> reused" bit.

Yes.

Thanks,
Miklos
