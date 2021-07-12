Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCD53C6567
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 23:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbhGLVZA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 17:25:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56442 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234689AbhGLVZA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 17:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626124931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NqyKWbYzvJesNMAyFevO8Qmaq3myoLJAWjEns6F9EMg=;
        b=aL6z+Dt38T4ZM42TEUGOTmSjID2Y4AhSUnHp62yRs1OaPKORrBngIHbE/gebie3Ktr+byU
        A5F3Wxgw89sxNzzeZ+celYzjIiPVjOAV9D4NKl37JttDzY2gSfUw0g7r4wbdZD8t/keb7X
        Rap6eEmZ9UrJk/jvf49LP2Ryq4XiKv8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-iiQpJbZiMg2bmALGrPHg3A-1; Mon, 12 Jul 2021 17:22:09 -0400
X-MC-Unique: iiQpJbZiMg2bmALGrPHg3A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D649A8042DE;
        Mon, 12 Jul 2021 21:22:07 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-176.rdu2.redhat.com [10.10.114.176])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0469E5D9CA;
        Mon, 12 Jul 2021 21:22:01 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 6A25522054F; Mon, 12 Jul 2021 17:22:01 -0400 (EDT)
Date:   Mon, 12 Jul 2021 17:22:01 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Bruce Fields <bfields@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, virtio-fs@redhat.com, dwalsh@redhat.com,
        dgilbert@redhat.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        tytso@mit.edu, miklos@szeredi.hu, gscrivan@redhat.com,
        jack@suse.cz, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 1/1] xattr: Allow user.* xattr on symlink and special
 files
Message-ID: <20210712212201.GD502004@redhat.com>
References: <20210708175738.360757-2-vgoyal@redhat.com>
 <20210709091915.2bd4snyfjndexw2b@wittgenstein>
 <20210709152737.GA398382@redhat.com>
 <710d1c6f-d477-384f-0cc1-8914258f1fb1@schaufler-ca.com>
 <20210709175947.GB398382@redhat.com>
 <CAPL3RVGKg4G5qiiHo7KYPcsWWgeoW=qNPOSQpd3Sv329jrWrLQ@mail.gmail.com>
 <20210712140247.GA486376@redhat.com>
 <20210712154106.GB18679@fieldses.org>
 <20210712174759.GA502004@redhat.com>
 <20210712193139.GA22997@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712193139.GA22997@fieldses.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 12, 2021 at 03:31:39PM -0400, J. Bruce Fields wrote:
> On Mon, Jul 12, 2021 at 01:47:59PM -0400, Vivek Goyal wrote:
> > On Mon, Jul 12, 2021 at 11:41:06AM -0400, J. Bruce Fields wrote:
> > > Looks like 0xd is what the server returns to access on a device node
> > > with mode bits rw- for the caller.
> > > 
> > > Commit c11d7fd1b317 "nfsd: take xattr bits into account for permission
> > > checks" added the ACCESS_X* bits for regular files and directories but
> > > not others.
> > > 
> > > But you don't want to determine permission from the mode bits anyway,
> > > you want it to depend on the owner,
> > 
> > Thinking more about this part. Current implementation of my patch is
> > effectively doing both the checks. It checks that you are owner or
> > have CAP_FOWNER in xattr_permission() and then goes on to call
> > inode_permission(). And that means file mode bits will also play a
> > role. If caller does not have write permission on the file, it will
> > be denied setxattr().
> > 
> > If I don't call inode_permission(), and just return 0 right away for
> > file owner (for symlinks and special files), then just being owner
> > is enough to write user.* xattr. And then even security modules will
> > not get a chance to block that operation. IOW, if you are owner of
> > a symlink or special file, you can write as many user.* xattr as you
> > like and except quota does not look like anything else can block
> > it. I am wondering if this approach is ok?
> 
> Yeah, I'd expect security modules to get a say, and I wouldn't expect
> mode bits on device nodes to be useful for deciding whether it makes
> sense for xattrs to be readable or writeable.

Actually, calling inode_permission() for symlinks probably should be
fine.

Its the device node which is problematic. Because we started with the
assumption that mode bits there represent access writes for read/writing
to device (and not to the filesystem). 

> 
> But, I don't really know.

> 
> Do we have any other use cases besides this case of storing security
> labels in user xattrs?

Storing security label was one example. In case of virtiofs, there is
a good chance that we will end up remapping all the guest xattrs and
prefix these with "user.virtiofsd".

fuse-overlay is another use case. They are storing real uid/gid in 
user.* xattrs for files over NFS.

I think overlayfs can be another benefeciary in some form. Now there
is support for unpriviliged mouting of overlayfs from inside a user
namespace. And that uses xattrs "user.overlay" on upper files for
overlayfs specific metadata. Device nodes are not copied up. But
they might have an issue with symlinks. Miklos, will know more.

Thanks
Vivek

