Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72AB3C28D0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jul 2021 20:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhGISCk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jul 2021 14:02:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41478 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230106AbhGISCk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jul 2021 14:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625853596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=41TcmMi84uP8FXnE7KMs91C429FUdwl3NuxFrKdIilI=;
        b=Gvvkf/bm/RafMFfFhpZPVr/9vccDYGgTcQrA2YdAjJZwHY0ogwSbjRXN1rUK9Xboae1QMS
        12+QGJIBer1fIH99PGj95kPkJjk1rn71ioHy3igyTgGx4frhJZrsqk74mdIQQDNrjazSJX
        SEIFyKpeSCtuBi7oucJB1vxeNoowoO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-597-i47g4pAXP8-QiKd9E8HfUg-1; Fri, 09 Jul 2021 13:59:54 -0400
X-MC-Unique: i47g4pAXP8-QiKd9E8HfUg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F91E5074B;
        Fri,  9 Jul 2021 17:59:52 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-62.rdu2.redhat.com [10.10.116.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6522819D9F;
        Fri,  9 Jul 2021 17:59:48 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E840E22054F; Fri,  9 Jul 2021 13:59:47 -0400 (EDT)
Date:   Fri, 9 Jul 2021 13:59:47 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, virtio-fs@redhat.com, dwalsh@redhat.com,
        dgilbert@redhat.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        tytso@mit.edu, miklos@szeredi.hu, gscrivan@redhat.com,
        jack@suse.cz, Christoph Hellwig <hch@infradead.org>,
        bfields@redhat.com
Subject: Re: [PATCH v2 1/1] xattr: Allow user.* xattr on symlink and special
 files
Message-ID: <20210709175947.GB398382@redhat.com>
References: <20210708175738.360757-1-vgoyal@redhat.com>
 <20210708175738.360757-2-vgoyal@redhat.com>
 <20210709091915.2bd4snyfjndexw2b@wittgenstein>
 <20210709152737.GA398382@redhat.com>
 <710d1c6f-d477-384f-0cc1-8914258f1fb1@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <710d1c6f-d477-384f-0cc1-8914258f1fb1@schaufler-ca.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 09, 2021 at 08:34:41AM -0700, Casey Schaufler wrote:
> On 7/9/2021 8:27 AM, Vivek Goyal wrote:
> > On Fri, Jul 09, 2021 at 11:19:15AM +0200, Christian Brauner wrote:
> >> On Thu, Jul 08, 2021 at 01:57:38PM -0400, Vivek Goyal wrote:
> >>> Currently user.* xattr are not allowed on symlink and special files.
> >>>
> >>> man xattr and recent discussion suggested that primary reason for this
> >>> restriction is how file permissions for symlinks and special files
> >>> are little different from regular files and directories.
> >>>
> >>> For symlinks, they are world readable/writable and if user xattr were
> >>> to be permitted, it will allow unpriviliged users to dump a huge amount
> >>> of user.* xattrs on symlinks without any control.
> >>>
> >>> For special files, permissions typically control capability to read/write
> >>> from devices (and not necessarily from filesystem). So if a user can
> >>> write to device (/dev/null), does not necessarily mean it should be allowed
> >>> to write large number of user.* xattrs on the filesystem device node is
> >>> residing in.
> >>>
> >>> This patch proposes to relax the restrictions a bit and allow file owner
> >>> or priviliged user (CAP_FOWNER), to be able to read/write user.* xattrs
> >>> on symlink and special files.
> >>>
> >>> virtiofs daemon has a need to store user.* xatrrs on all the files
> >>> (including symlinks and special files), and currently that fails. This
> >>> patch should help.
> >>>
> >>> Link: https://lore.kernel.org/linux-fsdevel/20210625191229.1752531-1-vgoyal@redhat.com/
> >>> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> >>> ---
> >> Seems reasonable and useful.
> >> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> >>
> >> One question, do all filesystem supporting xattrs deal with setting them
> >> on symlinks/device files correctly?
> > Wrote a simple bash script to do setfattr/getfattr user.foo xattr on
> > symlink and device node on ext4, xfs and btrfs and it works fine.
> 
> How about nfs, tmpfs, overlayfs and/or some of the other less conventional
> filesystems?

tmpfs does not support user.* xattr at all on any kind of files.

overlayfs works fine. I updated my test too.

nfs seems to have some issues. 

- I can set user.foo xattr on symlink and query it back using xattr name.

  getfattr -h -n user.foo foo-link.txt

  But when I try to dump all xattrs on this file, user.foo is being
  filtered out it looks like. Not sure why.

- I can't set "user.foo" xattr on a device node on nfs and I get
  "Permission denied". I am assuming nfs server is returning this.
  I am using knfsd with following in /etc/exports.

  /mnt/test/nfs-server 127.0.0.1(insecure,no_root_squash,rw,async)

Copying Bruce. He might have an idea.

Thanks
Vivek

> 
> >
> > https://github.com/rhvgoyal/misc/blob/master/generic-programs/user-xattr-special-files.sh
> >
> > I probably can add some more filesystems to test.
> >
> > Thanks
> > Vivek
> >
> >>>  fs/xattr.c | 10 ++++++----
> >>>  1 file changed, 6 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/fs/xattr.c b/fs/xattr.c
> >>> index 5c8c5175b385..2f1855c8b620 100644
> >>> --- a/fs/xattr.c
> >>> +++ b/fs/xattr.c
> >>> @@ -120,12 +120,14 @@ xattr_permission(struct user_namespace *mnt_userns, struct inode *inode,
> >>>  	}
> >>>  
> >>>  	/*
> >>> -	 * In the user.* namespace, only regular files and directories can have
> >>> -	 * extended attributes. For sticky directories, only the owner and
> >>> -	 * privileged users can write attributes.
> >>> +	 * In the user.* namespace, for symlinks and special files, only
> >>> +	 * the owner and priviliged users can read/write attributes.
> >>> +	 * For sticky directories, only the owner and privileged users can
> >>> +	 * write attributes.
> >>>  	 */
> >>>  	if (!strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN)) {
> >>> -		if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
> >>> +		if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode) &&
> >>> +		    !inode_owner_or_capable(mnt_userns, inode))
> >>>  			return (mask & MAY_WRITE) ? -EPERM : -ENODATA;
> >>>  		if (S_ISDIR(inode->i_mode) && (inode->i_mode & S_ISVTX) &&
> >>>  		    (mask & MAY_WRITE) &&
> >>> -- 
> >>> 2.25.4
> >>>
> 

