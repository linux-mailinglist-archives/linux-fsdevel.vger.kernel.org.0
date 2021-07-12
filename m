Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15793C5CA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 14:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhGLMwf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 08:52:35 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:56727 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234011AbhGLMwe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 08:52:34 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-qiylMb6tME2iJBU66RxWTw-1; Mon, 12 Jul 2021 08:49:42 -0400
X-MC-Unique: qiylMb6tME2iJBU66RxWTw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69A1C804319;
        Mon, 12 Jul 2021 12:49:39 +0000 (UTC)
Received: from bahia.lan (ovpn-114-183.ams2.redhat.com [10.36.114.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3530961093;
        Mon, 12 Jul 2021 12:49:31 +0000 (UTC)
Date:   Mon, 12 Jul 2021 14:49:30 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        <gscrivan@redhat.com>, <tytso@mit.edu>, <miklos@szeredi.hu>,
        <selinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <virtio-fs@redhat.com>, <casey.schaufler@intel.com>,
        <linux-security-module@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <jack@suse.cz>
Subject: Re: [Virtio-fs] [PATCH v2 1/1] xattr: Allow user.* xattr on symlink
 and special files
Message-ID: <20210712144849.121c948c@bahia.lan>
In-Reply-To: <710d1c6f-d477-384f-0cc1-8914258f1fb1@schaufler-ca.com>
References: <20210708175738.360757-1-vgoyal@redhat.com>
        <20210708175738.360757-2-vgoyal@redhat.com>
        <20210709091915.2bd4snyfjndexw2b@wittgenstein>
        <20210709152737.GA398382@redhat.com>
        <710d1c6f-d477-384f-0cc1-8914258f1fb1@schaufler-ca.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 9 Jul 2021 08:34:41 -0700
Casey Schaufler <casey@schaufler-ca.com> wrote:

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
> 

How about virtiofs then ? :-)

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
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://listman.redhat.com/mailman/listinfo/virtio-fs
> 

