Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BE72569FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Aug 2020 22:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgH2UMy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 16:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbgH2UMx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 16:12:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92694C061236
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2020 13:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wLrMyC5/AURJV9xyUA23EQ9NUGlsmprA8lE/ocOeLg0=; b=b05CU/DIG9K1rNrFFXlopVysJf
        64TqFQcxtN/MaaJOsB57ue0HCve6RvfKjGBAu8f4+NmiAgGG5O5/acNfA1yUN2x7WtE4pgbT6M1L4
        18Q5wI1tvdUeI7cr17Nwxy/9pFvL0j1U2enaPAA1vECHWtY5tHOsou+wGVDrZxLgTvjWkckgoagBH
        xbtxwZD3mUXjVBTI7pxlkrwXcauup4ERJhyxZyYeV4PMC0/Ou8/Ttyum+DpT0ElP1AHKwpzZmHmAR
        bJlLCB5FZLBiTBqjzgvlda3zaglUieXKF8ngxZD/vGLxltSpAmg6geZIrAUjYwZZgXxzlHABoIjxW
        qDq8ptzQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kC7DS-0004S2-0O; Sat, 29 Aug 2020 20:12:46 +0000
Date:   Sat, 29 Aug 2020 21:12:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Dave Chinner <david@fromorbit.com>,
        Christian Schoenebeck <qemu_oss@crudebyte.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        stefanha@redhat.com, mszeredi@redhat.com, vgoyal@redhat.com,
        gscrivan@redhat.com, dwalsh@redhat.com, chirantan@chromium.org
Subject: Re: xattr names for unprivileged stacking?
Message-ID: <20200829201245.GU14765@casper.infradead.org>
References: <27541158.PQPtYaGs59@silver>
 <20200816225620.GA28218@dread.disaster.area>
 <20200816230908.GI17456@casper.infradead.org>
 <20200817002930.GB28218@dread.disaster.area>
 <20200827152207.GJ14765@casper.infradead.org>
 <20200827222457.GB12096@dread.disaster.area>
 <20200829160717.GS14765@casper.infradead.org>
 <20200829161358.GP1236603@ZenIV.linux.org.uk>
 <20200829191751.GT14765@casper.infradead.org>
 <20200829194042.GT1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829194042.GT1236603@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 29, 2020 at 08:40:42PM +0100, Al Viro wrote:
> On Sat, Aug 29, 2020 at 08:17:51PM +0100, Matthew Wilcox wrote:
> 
> > I probably have the wrong nomenclature for what I'm proposing.
> > 
> > So here's a concrete API.  What questions need to be answered?
> > 
> > fd = open("real", O_RDWR);
> > 
> > // fetch stream names
> > sfd = open_stream(fd, NULL);
> > read(sfd, names, length);
> 
> 	1) what does fstat() on sfd return?

My strawman answers:

 - st_dev, st_ino, st_uid, st_gid, st_rdev, st_blksize are those of the
   containing file
 - st_mode: S_IFREG | parent & 0777
 - st_nlink: 1
 - st_size, st_blocks st_atime, st_mtime, st_ctime: as appropriate

> 	2) what does keeping it open do to underlying file?

I don't have a solid answer here.  Maybe it keeps a reference count on
the underlying inode?  Obviously we need to prevent the superblock from
disappearing from under it.  Maybe it needs to keep a refcount on the
struct file it was spawned from.  I haven't thought this through yet.

> 	3) what happens to it if that underlying file is unlinked?

Unlinking a file necessarily unlinks all the streams.  So the file
remains in existance until all fds on it are closed, including all
the streams.

> 	4) what does it do to underlying filesystem?  Can it be unmounted?

I think I covered that in the earlier answers.

> > // create a new anonymous stream
> > sfd = open_stream(fd, "");
> > write(sfd, buffer, buflen);
> > // name it
> > linkat(sfd, NULL, fd, "newstream", AT_EMPTY_PATH);
> 
> Oh, lovely - so linkat() *CAN* get that for dirfd and must somehow tell
> it from the normal case.  With the semantics entirely unrelated to the normal
> one.

I'm open to just using a different syscall.  link_stream(sfd, "newstream");
And, as you point out below, we need unlink_stream(fd, "stream");

> And on top of everything else, we have
> 	5) what are the permissions involved?  When are they determined, BTW?

If you can open a file, you can open its streams.  So an O_PATH file
descriptor can't be used to open streams.

> > close(sfd);
> > 
> >  - Stream names are NUL terminated and may contain any other character.
> >    If you want to put a '/' in a stream name, that's fine, but there's
> >    no hierarchy.  Ditto "//../././../../..//./."  It's just a really
> >    oddly named stream.
> 
> Er...  Whatever for?

Interoperability.  If some other system creates a stream with a '/' in
it, I don't want the filesystem to have to convert.  Although, at least
Windows doesn't permit '/' in stream names [1] [2].  Of course, individual
filesystems could reject characters in names that they don't like.

[1] https://docs.microsoft.com/en-us/windows/win32/fileio/file-streams
[2] https://docs.microsoft.com/en-us/windows/win32/fileio/naming-a-file

> >  - linkat() will fail if 'fd' does not match where 'sfd' was created.
> 
> 	6) "match" in the above being what, exactly?

Referring to a different inode than the one it was created in.  Although
if we just go with the link_stream() proposal above, then this point is
moot.
