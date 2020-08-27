Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F146254931
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 17:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgH0PWS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 11:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728498AbgH0PWQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:22:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812A7C061264
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 08:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hr+K8xZvT4MYX8Ij8MMIA1OqQ5725XNfBq+GwMpLg/w=; b=pSc90PLmkNnb/PNagAY0B00Q1G
        hZ9fZL8CO0zyt6rHKjwcq6WTTKowrsFXp5F4++H/E7jqPhtCjGEoQwPGQbKeNHybojOGHouQMOmCS
        bEhHL8yhXsfIUGKuhtghTc7TF6gxwiBYjIOc6RNUsLcz413J2SX57K0kUS3IkOJNdVG0Q4DYnzcwk
        G9K9na7ksvua+1XTt1gJQo4chld2GIfZGRgmTb6RAutx9rfbun5TAm5GJiqpDVJeP6+Y0PaEXFLjf
        rnkWaxl7Yr8tjirdrZx6/IzckEnannYFcFvfVGP7807ZOdtxgy5EzgzIne4Z4rRs74Vi/+eby5Ahz
        WJHVmzMg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBJj5-0005wT-GD; Thu, 27 Aug 2020 15:22:07 +0000
Date:   Thu, 27 Aug 2020 16:22:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christian Schoenebeck <qemu_oss@crudebyte.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        stefanha@redhat.com, mszeredi@redhat.com, vgoyal@redhat.com,
        gscrivan@redhat.com, dwalsh@redhat.com, chirantan@chromium.org
Subject: Re: xattr names for unprivileged stacking?
Message-ID: <20200827152207.GJ14765@casper.infradead.org>
References: <20200728105503.GE2699@work-vm>
 <12480108.dgM6XvcGr8@silver>
 <20200812143323.GF2810@work-vm>
 <27541158.PQPtYaGs59@silver>
 <20200816225620.GA28218@dread.disaster.area>
 <20200816230908.GI17456@casper.infradead.org>
 <20200817002930.GB28218@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817002930.GB28218@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 17, 2020 at 10:29:30AM +1000, Dave Chinner wrote:
> To implement ADS, we'd likely consider adding a new physical inode
> "ADS fork" which, internally, maps to a separate directory
> structure. This provides us with the ADS namespace for each inode
> and a mechanism that instantiates a physical inode per ADS. IOWs,
> each ADS can be referenced by the VFS natively and independently as
> an inode (native "file as a directory" semantics). Hence existing
> create/unlink APIs work for managing ADS, readdir() can list all
> your ADS, you can keep per ADS xattrs, etc....
> 
> IOWs, with a filesystem inode fork implementation like this for ADS,
> all we really need is for the VFS to pass a magic command to
> ->lookup() to tell us to use the ADS namespace attached to the inode
> rather than use the primary inode type/state to perform the
> operation.
> 
> Hence all the ADS support infrastructure is essentially dentry cache
> infrastructure allowing a dentry to be both a file and directory,
> and providing the pathname resolution that recognises an ADS
> redirection. Name that however you want - we've got to do an on-disk
> format change to support ADS, so we can tell the VFS we support ADS
> or not. And we have no cares about existing names in the filesystem
> conflicting with the ADS pathname identifier because it's a mkfs
> time decision. Given that special flags are needed for the openat()
> call to resolve an ADS (e.g. O_ALT), we know if we should parse the
> ADS identifier as an ADS the moment it is seen...

I think this is equivalent to saying "Linux will never support ADS".
Al has some choice words on having the dentry cache support objects which
are both files and directories.  You run into some "fun" locking issues.
And there's lots of things you just don't want to permit, like mounting
a new filesystem on top of some ADS, or chrooting a process into an ADS,
or renaming an ADS into a different file.

I think what would satisfy people is allowing actual "alternate data
streams" to exist in files.  You always start out by opening a file,
then the presentation layer is a syscall that lets you enumerate the
data streams available for this file, and another syscall that returns
an fd for one of those streams.

As long as nobody gets the bright idea to be able to link that fd into
the directory structure somewhere, this should avoid any problems with
unwanted things being done to an ADS.  Chunks of your implementation
described above should be fine for this.

I thought through some of this a while back, and came up with this list:

> Work as expected:
> mmap(), read(), write(), close(), splice(), sendfile(), fallocate(),
> ftruncate(), dup(), dup2(), dup3(), utimensat(), futimens(), select(),
> poll(), lseek(), fcntl(): F_DUPFD, F_GETFD, F_GETFL, F_SETFL, F_SETLK,
> F_SETLKW, F_GETLK, F_GETOWN, F_SETOWN, F_GETSIG, F_SETSIG, F_SETLEASE,
> F_GETLEASE)
>
> Return error if fd refers to the non-default stream:
> linkat(), symlinkat(), mknodat(), mkdirat()
>
> Remove a stream from a file:
> unlinkat()
>
> Open an existing stream in a file or create a new stream in a file:
> openat()
>
> fstat()
> st_ino may be different for different names.  st_dev may be different.
> st_mode will match the object for files, even if it is changed after
> creation.  For directories, it will match except that execute permission
> will be removed and S_IFMT will be S_ISREG (do we want to define a
> new S_ISSTRM?).  st_nlink will be 1.  st_uid and st_gid will match.
> It will have its own st_atime/st_mtime/st_ctime.  Accessing a stream
> will not update its parent's atime/mtime/ctime.
>
> renameat()
> If olddirfd + oldpath refers to a stream then newdirfd + newpath must
> refer to a stream within the same parent object.  If that stream exists,
> it is removed.  If olddirfd + oldpath does not refer to a stream,
> then newdirfd + newpath must not refer to a stream.
>
> The two file specifications must resolve to the same parent object.
> It is possible to use renameat() to rename a stream within an object,
> but not to move a stream from one object to another.  If newpath refers
> to an existing named stream, it is removed.

I don't seem to have come up with an actual syscall for enumerating the
stream names.  I kind of think a fresh syscall might be the right way to
go.

For the benefit of shell scripts, I think an argument to 'cat' to open
an ADS and an lsads command should be enough.

Oh, and I would think we might want i_blocks of the 'host' inode to
reflect the blocks allocated to all the data streams attached to the
inode.  That should address at least parts of the data exfiltration
concern.
