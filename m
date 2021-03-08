Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7593330B56
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 11:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhCHKfz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 05:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbhCHKfj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:35:39 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2197FC06174A;
        Mon,  8 Mar 2021 02:35:39 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id s1so8336930ilh.12;
        Mon, 08 Mar 2021 02:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uW22BUdu/SRB8yiALOfrH1UfupHMNVrmOHvwUHBy06I=;
        b=GqBBRDbCEj38iFW0MXTGa0/KJ45ZgACFsDGi2tbJhwbhi8YCBsFTUewKjtDfNp6Yos
         dUIJZWXuF8v2CNFNVWJh4WgmIKrT+3Lb9ujeIW6xTDVGr4N+GEVCG3LZerTkiUSV2MTj
         kWEMcxe0bnQj74mMC1jLhQNsS+BGT6QRJKtMXgZUCcgAQR9V8IRYbp70NATj8rhwtrbi
         fIGmQaNhUCUhmSCrYNDfTQTbZM7TDR7pgRTkZmUzpkC0TrpqdbCTm8Tr2OwR3gLoRDOV
         tKhDerYxOi4FCnL9jMMFNJKyJIIDsxy2W0SwENtt832lcuHi5xAwBk4BozKEyXRMkcE2
         /TJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uW22BUdu/SRB8yiALOfrH1UfupHMNVrmOHvwUHBy06I=;
        b=t21Pxuolgf+IB6Ol+SWHr838XK5g98/jJ3eZCS2UJA4nWqg3KRLIm7Y35qD/8ExpZP
         blXRaoikgeG7sRbHywpl06Cm8ST00o0Kgm++cOz0JDPV210yLxm7V6uLqgYmDzO7M91y
         +0NZlntNZqATd7mj07PoVtOu9QRxnyqEA/2NYNObtILnWZ9/Ac9i4Ss+y5lmrFNax35Y
         tBpIgIBECE4HxkINzyHU1ndX5kA5WR4HrGXQRm/jpa+5Qs14IK2EP114rHRavnDRD3G7
         /am8dnd21MJZ6jy9WMrv6wo0FfvNknWSMiWlxcaKGHjkG5MBGNcFmhG8ux2wGzIGaBbZ
         bBig==
X-Gm-Message-State: AOAM530OU9MQph9O7QJ9kbV/za5B7StwGacjW/55DdarC+qg2wvHI5sP
        LrBpJ+cLjcsUBb69H64Rtss9/YvK78XyQEgIUC0=
X-Google-Smtp-Source: ABdhPJxyjk22aaxo3sgf/QuqQ+LLIuxfb1TXrgGa/WsZBq/b3dbCGqGi/0c5jlTKv2ACVTB9EU8+B0z9poenvesX45o=
X-Received: by 2002:a92:c010:: with SMTP id q16mr20835009ild.250.1615199738508;
 Mon, 08 Mar 2021 02:35:38 -0800 (PST)
MIME-Version: 1.0
References: <2653261.1614813611@warthog.procyon.org.uk> <CAOQ4uxhxwKHLT559f8v5aFTheKgPUndzGufg0E58rkEqa9oQ3Q@mail.gmail.com>
 <517184.1615194835@warthog.procyon.org.uk>
In-Reply-To: <517184.1615194835@warthog.procyon.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 8 Mar 2021 12:35:27 +0200
Message-ID: <CAOQ4uxjYWprb7trvamCx+DaP2yn8HCaZeZx1dSvPyFH2My303w@mail.gmail.com>
Subject: Re: fscache: Redesigning the on-disk cache
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 8, 2021 at 11:14 AM David Howells <dhowells@redhat.com> wrote:
>
> Amir Goldstein <amir73il@gmail.com> wrote:
>
> > >  (0a) As (0) but using SEEK_DATA/SEEK_HOLE instead of bmap and opening the
> > >       file for every whole operation (which may combine reads and writes).
> >
> > I read that NFSv4 supports hole punching, so when using ->bmap() or SEEK_DATA
> > to keep track of present data, it's hard to distinguish between an
> > invalid cached range and a valid "cached hole".
>
> I wasn't exactly intending to permit caching over NFS.  That leads to fun
> making sure that the superblock you're caching isn't the one that has the
> cache in it.
>
> However, we will need to handle hole-punching being done on a cached netfs,
> even if that's just to completely invalidate the cache for that file.
>
> > With ->fiemap() you can at least make the distinction between a non existing
> > and an UNWRITTEN extent.
>
> I can't use that for XFS, Ext4 or btrfs, I suspect.  Christoph and Dave's
> assertion is that the cache can't rely on the backing filesystem's metadata
> because these can arbitrarily insert or remove blocks of zeros to bridge or
> split extents.
>
> > You didn't say much about crash consistency or durability requirements of the
> > cache. Since cachefiles only syncs the cache on shutdown, I guess you
> > rely on the hosting filesystem to provide the required ordering guarantees.
>
> There's an xattr on each file in the cache to record the state.  I use this
> mark a cache file "open".  If, when I look up a file, the file is marked open,
> it is just discarded at the moment.
>
> Now, there are two types of data stored in the cache: data that has to be
> stored as a single complete blob and is replaced as such (e.g. symlinks and
> AFS dirs) and data that might be randomly modified (e.g. regular files).
>
> For the former, I have code, though in yet another branch, that writes this in
> a tmpfile, sets the xattrs and then uses vfs_link(LINK_REPLACE) to cut over.
>
> For the latter, that's harder to do as it would require copying the data to
> the tmpfile before we're allowed to modify it.  However, if it's possible to
> create a tmpfile that's a CoW version of a data file, I could go down that
> route.
>
> But after I've written and sync'd the data, I set the xattr to mark the file
> not open.  At the moment I'm doing this too lazily, only doing it when a netfs
> file gets evicted or when the cache gets withdrawn, but I really need to add a
> queue of objects to be sealed as they're closed.  The balance is working out
> how often to do the sealing as something like a shell script can do a lot of
> consecutive open/write/close ops.
>

You could add an internal vfs API wait_for_multiple_inodes_to_be_synced().
For example, xfs keeps the "LSN" on each inode, so once the transaction
with some LSN has been committed, all the relevant inodes, if not dirty, can
be declared as synced, without having to call fsync() on any file and without
having to force transaction commit or any IO at all.

Since fscache takes care of submitting the IO, and it shouldn't care about any
specific time that the data/metadata hits the disk(?), you can make use of the
existing periodic writeback and rolling transaction commit and only ever need
to wait for that to happen before marking cache files "closed".

There was a discussion about fsyncing a range of files on LSFMM [1].
In the last comment on the article dchinner argues why we already have that
API (and now also with io_uring(), but AFAIK, we do not have a useful
wait_for_sync() API. And it doesn't need to be exposed to userspace at all.

[1] https://lwn.net/Articles/789024/

> > Anyway, how are those ordering requirements going to be handled when entire
> > indexing is in a file? You'd practically need to re-implement a filesystem
>
> Yes, the though has occurred to me too.  I would be implementing a "simple"
> filesystem - and we have lots of those:-/.  The most obvious solution is to
> use the backing filesystem's metadata - except that that's not possible.
>
> > journal or only write cache updates to a temp file that can be discarded at
> > any time?
>
> It might involve keeping a bitmap of "open" blocks.  Those blocks get
> invalidated when the cache restarts.  The simplest solution would be to wipe
> the entire cache in such a situation, but that goes against one of the
> important features I want out of it.
>
> Actually, a journal of open and closed blocks might be better, though all I
> really need to store for each block is a 32-bit number.
>
> It's a particular problem if I'm doing DIO to the data storage area but
> buffering the changes to the metadata.  Further, the metadata and data might
> be on different media, just to add to the complexity.
>
> Another possibility is only to cull blocks when the parent file is culled.
> That probably makes more sense as, as long as the file is registered culled on
> disk first and I don't reuse the file slot too quickly, I can write to the
> data store before updating the metadata.
>

If I were you, I would try to avoid re-implementing a journaled filesystem or
a database for fscache and try to make use of crash consistency guarantees
that filesystems already provide.
Namely, use the data dependency already provided by temp files.
It doesn't need to be one temp file per cached file.

Always easier said than done ;-)

Thanks,
Amir.
