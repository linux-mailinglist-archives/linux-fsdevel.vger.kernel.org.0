Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7643E128843
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2019 09:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfLUInR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Dec 2019 03:43:17 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:44061 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfLUInR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Dec 2019 03:43:17 -0500
Received: by mail-il1-f194.google.com with SMTP id z12so10016839iln.11;
        Sat, 21 Dec 2019 00:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zOw1yXDHuAoD3Kc1PWQqOf8j8YrDutWX5kRyO7Mss4U=;
        b=h2L5Hfmvy1e383vZXY/Uf95l/jjjw7B683GAwoSUYotqjNgmDAc2xOiOz9Fg5x1L+t
         dF4kDHkoQH/8cBz9/I2Zk/J/zvL53i/sMpJDZ/7EQEw9UrcsgNx/dlVwHRLxcZAgExWG
         wYNFyWL/aM1sBjKCLjG9nMybZbueHleyN9e2f7tboSWCX2OKLKtyOGRqxNlsY0N1iWBu
         R0wtB3eomjuaKsX8uOxlc+CAdQ6HyRVYSrWGDlWYoRBqILJkJG/IojdWQqvqChLq/BCz
         RKkGroylvhdoYNl7b3kqAKArBg3aoI0JMkTUnUziLXaCUF7bkvY8yly9wZGmKb8P7i1Y
         MWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zOw1yXDHuAoD3Kc1PWQqOf8j8YrDutWX5kRyO7Mss4U=;
        b=sROY7dq1TQclU7ZyQjXqwSZJcWra45MDP6vm3Z076qMC9xXN2OVz0yH3JmoNcgfzfR
         7/aEa5UC6I2DWcu6BjnEhhs5RbjYXz7AUGPkCOhqzFbP1KTkv3yO7kHVGRi62RV4AEXv
         tw5ezeJUx+DqPzJTpqtkY9WS3gYNukrVeYLTtzRutFNrt28qV3iloDchu6DzdfMCGu0O
         lKRAZ1xwnXXd6zF1mIL6adYguot3xUjMmXrLisTG5YawK/zlwQjCVK2iumiwEKc7j2Cs
         y2RPUB2aGMKghcAImPuwfXDDrOE3r+pmybc02nTJBafa+lhsR11Sz/XWR/Lb5ih4B3Vx
         bChA==
X-Gm-Message-State: APjAAAVK4ojIRJsJ46fSjdIegwBy0pUI0uxqnanenckPRD99wET/bRJw
        0FIYoUGBG5+gLPB4uM5q+ixrmhbBEkgJHiDc2gU=
X-Google-Smtp-Source: APXvYqwd35DhfzZzrtc2is3XW8PsKNSv0oBL2VDDIHfgRt92VBWDck6ESuGSxoE3vMi76YY1g6Y5WYUB1BN1AC5tvwc=
X-Received: by 2002:a92:d5c3:: with SMTP id d3mr15993083ilq.250.1576917796474;
 Sat, 21 Dec 2019 00:43:16 -0800 (PST)
MIME-Version: 1.0
References: <20191220024936.GA380394@chrisdown.name> <20191220213052.GB7476@magnolia>
In-Reply-To: <20191220213052.GB7476@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 21 Dec 2019 10:43:05 +0200
Message-ID: <CAOQ4uxgoDHLnVb9=R2LpNqEFtjx=f5K8QXQnfiziBQ+jURLh=A@mail.gmail.com>
Subject: Re: [PATCH] fs: inode: Reduce volatile inode wraparound risk when
 ino_t is 64 bit
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Chris Down <chris@chrisdown.name>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 20, 2019 at 11:33 PM Darrick J. Wong
<darrick.wong@oracle.com> wrote:
>
> On Fri, Dec 20, 2019 at 02:49:36AM +0000, Chris Down wrote:
> > In Facebook production we are seeing heavy inode number wraparounds on
> > tmpfs. On affected tiers, in excess of 10% of hosts show multiple files
> > with different content and the same inode number, with some servers even
> > having as many as 150 duplicated inode numbers with differing file
> > content.
> >
> > This causes actual, tangible problems in production. For example, we
> > have complaints from those working on remote caches that their
> > application is reporting cache corruptions because it uses (device,
> > inodenum) to establish the identity of a particular cache object, but
>
> ...but you cannot delete the (dev, inum) tuple from the cache index when
> you remove a cache object??
>
> > because it's not unique any more, the application refuses to continue
> > and reports cache corruption. Even worse, sometimes applications may not
> > even detect the corruption but may continue anyway, causing phantom and
> > hard to debug behaviour.
> >
> > In general, userspace applications expect that (device, inodenum) should
> > be enough to be uniquely point to one inode, which seems fair enough.
>
> Except that it's not.  (dev, inum, generation) uniquely points to an
> instance of an inode from creation to the last unlink.
>

Yes, but also:
There should not exist two live inodes on the system with the same (dev, inum)
The problem is that ino 1 may still be alive when wraparound happens
and then two different inodes with ino 1 exist on same dev.

Take the 'diff' utility for example, it will report that those files
are identical
if they have the same dev,ino,size,mtime. I suspect that 'mv' will not
let you move one over the other, assuming they are hardlinks.
generation is not even exposed to legacy application using stat(2).

Thanks,
Amir.
