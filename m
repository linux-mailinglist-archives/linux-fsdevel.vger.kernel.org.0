Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A103C5F76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 17:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235570AbhGLPn5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 11:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbhGLPn5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 11:43:57 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6C3C0613DD;
        Mon, 12 Jul 2021 08:41:08 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id A55F76210; Mon, 12 Jul 2021 11:41:06 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A55F76210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1626104466;
        bh=58qsbxGOldmXglP0XTIWP5zPM6bP3vD1mti24yWL6p4=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=b3KfNWYgyy+7ug+X4mtbJ0nB2zxIsoueTBluDdvJYz0EI9qtCIkfTUMMjALSXuG6g
         XiLxIJUyUJ22hrnsxgWppVUz4b6S7c298HXKfUzu3VWtfh2+aWa3Uit6V1x6nKwiMq
         CvCFga8AvZbqMbjlkCqsDKWZH3QGbznmDh5jMAPg=
Date:   Mon, 12 Jul 2021 11:41:06 -0400
To:     Vivek Goyal <vgoyal@redhat.com>
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
Message-ID: <20210712154106.GB18679@fieldses.org>
References: <20210708175738.360757-1-vgoyal@redhat.com>
 <20210708175738.360757-2-vgoyal@redhat.com>
 <20210709091915.2bd4snyfjndexw2b@wittgenstein>
 <20210709152737.GA398382@redhat.com>
 <710d1c6f-d477-384f-0cc1-8914258f1fb1@schaufler-ca.com>
 <20210709175947.GB398382@redhat.com>
 <CAPL3RVGKg4G5qiiHo7KYPcsWWgeoW=qNPOSQpd3Sv329jrWrLQ@mail.gmail.com>
 <20210712140247.GA486376@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712140247.GA486376@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 12, 2021 at 10:02:47AM -0400, Vivek Goyal wrote:
> On Fri, Jul 09, 2021 at 04:10:16PM -0400, Bruce Fields wrote:
> > On Fri, Jul 9, 2021 at 1:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > nfs seems to have some issues.
> > 
> > I'm not sure what the expected behavior is for nfs.  All I have for
> > now is some generic troubleshooting ideas, sorry:
> > 
> > > - I can set user.foo xattr on symlink and query it back using xattr name.
> > >
> > >   getfattr -h -n user.foo foo-link.txt
> > >
> > >   But when I try to dump all xattrs on this file, user.foo is being
> > >   filtered out it looks like. Not sure why.
> > 
> > Logging into the server and seeing what's set there could help confirm
> > whether it's the client or server that's at fault.  (Or watching the
> > traffic in wireshark; there are GET/SET/LISTXATTR ops that should be
> > easy to spot.)
> > 
> > > - I can't set "user.foo" xattr on a device node on nfs and I get
> > >   "Permission denied". I am assuming nfs server is returning this.
> > 
> > Wireshark should tell you whether it's the server or client doing that.
> > 
> > The RFC is https://datatracker.ietf.org/doc/html/rfc8276, and I don't
> > see any explicit statement about what the server should do in the case
> > of symlinks or device nodes, but I do see "Any regular file or
> > directory may have a set of extended attributes", so that was clearly
> > the assumption.  Also, NFS4ERR_WRONG_TYPE is listed as a possible
> > error return for the xattr ops.  But on a quick skim I don't see any
> > explicit checks in the nfsd code, so I *think* it's just relying on
> > the vfs for any file type checks.
> 
> Hi Bruce,
> 
> Thanks for the response. I am just trying to do set a user.foo xattr on
> a device node on nfs.
> 
> setfattr -n "user.foo" -v "bar" /mnt/nfs/test-dev
> 
> and I get -EACCESS.
> 
> I put some printk() statements and EACCESS is being returned from here.
> 
> nfs4_xattr_set_nfs4_user() {
>         if (!nfs_access_get_cached(inode, current_cred(), &cache, true)) {
>                 if (!(cache.mask & NFS_ACCESS_XAWRITE)) {
>                         return -EACCES;
>                 }
>         }
> }
> 
> Value of cache.mask=0xd at the time of error.

Looks like 0xd is what the server returns to access on a device node
with mode bits rw- for the caller.

Commit c11d7fd1b317 "nfsd: take xattr bits into account for permission
checks" added the ACCESS_X* bits for regular files and directories but
not others.

But you don't want to determine permission from the mode bits anyway,
you want it to depend on the owner, so I guess we should be calling
xattr_permission somewhere if we want that behavior.

The RFC assumes user xattrs are for regular files and directories,
without, as far as I can tell, actually explicitly forbidding them on
other objects.  We should also raise this with the working group if we
want to increase the chances that you'll get the behavior you want on
non-Linux servers.

The "User extended attributes" section of the xattr(7) man page will
need updating.

--b.
