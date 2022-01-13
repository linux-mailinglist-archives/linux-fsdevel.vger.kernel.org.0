Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E1E48D121
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 04:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbiAMDwx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 22:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbiAMDww (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 22:52:52 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218CBC06173F;
        Wed, 12 Jan 2022 19:52:52 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id h23so6652070iol.11;
        Wed, 12 Jan 2022 19:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IkTW/f1btDdtmebJOs9va1brO9n2byvbc/TGFMyWGVA=;
        b=D4dKKHpgBJu2/atbonwXBGxVJ6n560QSSx4z9Bf9BPfse7wy1LFez2vTj7XNQS++EJ
         YsPHn0Yi3PgCr8YyGKKNWCjLJcnzyIux8ggWkwc2v/AySv+7EY/Eqv8mnjjxNTnjnB2y
         F+Zg4PqzXHV3AggNVy4Nl/b26Wczp2qUBY13R6iUrO7wuqQvnna7veM+nnI/RYBtowJu
         hDffD8cI5EcgbIl7OeOGoZQ8HIdJfDlv9DWQHUwKB2YhzoUQ2i04M+XsshSitl4jPN4h
         k1EUTr7xHgaye4gjMXc2G0UzBm0IZ4ZOAPogopZv3b9csUn9VuhQJ4AaMSAF8gdGPL2B
         JvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IkTW/f1btDdtmebJOs9va1brO9n2byvbc/TGFMyWGVA=;
        b=ALAaP3rR4MciCRmFBi6LftcEB/0bDXF8VDgsQprovk7Tl3MQLDKZ+EcVhJ5EOOeOyz
         9GCIJkg0gDE9tD5PMwPFK8CPYFNvWPUCP9a4LIdnUCwUwDofGjlVplbo/APtqci5Oo5l
         F6HkW9RfTox6rFefkxOVvI5HyMoyek4p6hMdvyEvrUBuYCWxgg3aIJImEvBYb0pWWlsz
         xqZviXWlOgPAjXT06LbBo1aQxqxi6JQ3T9XAlo84YtKwnn4qZcgMngdrIDa5G6YuvHoN
         8c3fvACoMlkw31KkOcizkN6xXi445/I9PRGveDmZ707IUsZxppsFy0+0MlsMvQR+bBBq
         LBfA==
X-Gm-Message-State: AOAM530KxdnXqbF+F2c/ovaL/VG7qi7vrF6jsqT4Xd2tBDpEhSjBUEzf
        t4N3kyRby907g1f1K4l7O9NiCRu3SfYqknvxyFs=
X-Google-Smtp-Source: ABdhPJwgMuCPjLMe0KKbmpitTjVZUuTLSsyhB1hPisBBTzYcZ/TPIDnRp9aDvCtWNvEoMorQRff/QkX80COOvac4y80=
X-Received: by 2002:a5d:9155:: with SMTP id y21mr1264833ioq.112.1642045971472;
 Wed, 12 Jan 2022 19:52:51 -0800 (PST)
MIME-Version: 1.0
References: <20220111074309.GA12918@kili> <Yd1ETmx/HCigOrzl@infradead.org>
 <CAOQ4uxg9V4Jsg3jRPnsk2AN7gPrNY8jRAc87tLvGW+TqH9OU-A@mail.gmail.com> <20220112174301.GB19154@magnolia>
In-Reply-To: <20220112174301.GB19154@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 13 Jan 2022 05:52:40 +0200
Message-ID: <CAOQ4uxh7wpxx2H6Vpm26OdigXbWCCLO1xbFapupvLCn8xOiL=w@mail.gmail.com>
Subject: Re: [bug report] NFS: Support statx_get and statx_set ioctls
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        richard.sharpe@primarydata.com,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        lance.shelton@hammerspace.com,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ntfs3@lists.linux.dev,
        Steve French <sfrench@samba.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Ralph Boehme <slow@samba.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > Which leaves us with an API to set the 'time backup' attribute, which
> > is a "mutable creation time" [*].
> > cifs supports setting it via setxattr and I guess ntfs3 could use an
> > API to set it as well.
> >
> > One natural interface that comes to mind is:
> >
> > struct timespec times[3] = {/* atime, mtime, crtime */}
> > utimensat(dirfd, path, times, AT_UTIMES_ARCHIVE);
> >
> > and add ia_crtime with ATTR_CRTIME to struct iattr.
> >
> > Trond,
> >
> > Do you agree to rework your patches in this direction?
> > Perhaps as the first stage, just use statx() and ioctls to set the
> > attributes to give enough time for bikeshedding the set APIs
> > and follow up with the generic set API patches later?
> >
> > Thanks,
> > Amir.
> >
> > [*] I find it convenient to use the statx() terminology of "btime"
> > to refer to the immutable birth time provided by some filesystems
> > and to use "crtime" for the mutable creation time for archiving,
> > so that at some point, some filesystems may provide both of
> > these times independently.
>
> I disagree because XFS and ext4 both use 'crtime' for the immutable
> birth time, not a mutable creation time for archiving.  I think we'd
> need to be careful about wording here if there is interest in adding a
> user-modifiable file creation time (as opposed to creation time for a
> specific instance of an inode) to filesystems.
>
> Once a year or so we get a question/complaint from a user about how they
> can't change the file creation time and we have to explain to them
> what's really going on.
>

To add one more terminology to the mix - when Samba needed to cope
with these two terminologies they came up with itime for "instantiation time"
(one may also consider it "immutable time").

Another issue besides wording, is that statx btime can be either of those
things depending on the filesystem, so if we ever add mutable btime to
ext4/xfs, what's statx btime going to return?

One more question to ask, if we were to add mutable btime to ext4/xfs
should it be an additional attribute at all or should we allow with explicit
filesystem flag and maybe also mount option to modify the existing crtime
inode field? if we can accept that some users are willing to trade the
immutable crtime with mutable btime, then we can settle with a flag
indicating "warranty seal removed" from the existing crtime field.
At least one advantage of this approach is that it simplifies terminology.

Thanks,
Amir.
