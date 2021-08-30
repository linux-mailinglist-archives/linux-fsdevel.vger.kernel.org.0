Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BDF3FBCA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 20:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhH3Sqc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 14:46:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26826 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231736AbhH3Sqa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 14:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630349135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i7iUH7l5Sh0OpUsn92+ULA9isAZYjj/3KpoIKNS+nc0=;
        b=Y1Bfj6zdquZRuaxwOY0yd0FwnqB6CVPSBvZ+JY3GeNb9D2nVRYjfFB7rI1f8WF1V+y4Hmo
        3LkBx35FQTgDAqUR5lxFQxyYHHIflf7nOIDnfXQED7HhCUlW7QY7jJxtKRzYbHDJmxa0pk
        UXx5r+xoZlI4/q4EBcRSv2hJQ505odE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-jnQEB5U4OBineMHHI0DrUA-1; Mon, 30 Aug 2021 14:45:33 -0400
X-MC-Unique: jnQEB5U4OBineMHHI0DrUA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 822448799EE;
        Mon, 30 Aug 2021 18:45:31 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.8.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3255D2AF99;
        Mon, 30 Aug 2021 18:45:26 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 93FA72241BF; Mon, 30 Aug 2021 14:45:25 -0400 (EDT)
Date:   Mon, 30 Aug 2021 14:45:25 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Bruce Fields <bfields@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, virtio-fs@redhat.com, dwalsh@redhat.com,
        dgilbert@redhat.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        tytso@mit.edu, miklos@szeredi.hu, gscrivan@redhat.com,
        jack@suse.cz, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 1/1] xattr: Allow user.* xattr on symlink and special
 files
Message-ID: <YS0nRQeuxEFppDxG@redhat.com>
References: <20210708175738.360757-2-vgoyal@redhat.com>
 <20210709091915.2bd4snyfjndexw2b@wittgenstein>
 <20210709152737.GA398382@redhat.com>
 <710d1c6f-d477-384f-0cc1-8914258f1fb1@schaufler-ca.com>
 <20210709175947.GB398382@redhat.com>
 <CAPL3RVGKg4G5qiiHo7KYPcsWWgeoW=qNPOSQpd3Sv329jrWrLQ@mail.gmail.com>
 <20210712140247.GA486376@redhat.com>
 <20210712154106.GB18679@fieldses.org>
 <20210712174759.GA502004@redhat.com>
 <3d55ff30-c6cf-46c4-0e32-3b578099343d@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d55ff30-c6cf-46c4-0e32-3b578099343d@schaufler-ca.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 13, 2021 at 07:17:00AM -0700, Casey Schaufler wrote:
> On 7/12/2021 10:47 AM, Vivek Goyal wrote:
> > On Mon, Jul 12, 2021 at 11:41:06AM -0400, J. Bruce Fields wrote:
> >> On Mon, Jul 12, 2021 at 10:02:47AM -0400, Vivek Goyal wrote:
> >>> On Fri, Jul 09, 2021 at 04:10:16PM -0400, Bruce Fields wrote:
> >>>> On Fri, Jul 9, 2021 at 1:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >>>>> nfs seems to have some issues.
> >>>> I'm not sure what the expected behavior is for nfs.  All I have for
> >>>> now is some generic troubleshooting ideas, sorry:
> >>>>
> >>>>> - I can set user.foo xattr on symlink and query it back using xattr name.
> >>>>>
> >>>>>   getfattr -h -n user.foo foo-link.txt
> >>>>>
> >>>>>   But when I try to dump all xattrs on this file, user.foo is being
> >>>>>   filtered out it looks like. Not sure why.
> >>>> Logging into the server and seeing what's set there could help confirm
> >>>> whether it's the client or server that's at fault.  (Or watching the
> >>>> traffic in wireshark; there are GET/SET/LISTXATTR ops that should be
> >>>> easy to spot.)
> >>>>
> >>>>> - I can't set "user.foo" xattr on a device node on nfs and I get
> >>>>>   "Permission denied". I am assuming nfs server is returning this.
> >>>> Wireshark should tell you whether it's the server or client doing that.
> >>>>
> >>>> The RFC is https://datatracker.ietf.org/doc/html/rfc8276, and I don't
> >>>> see any explicit statement about what the server should do in the case
> >>>> of symlinks or device nodes, but I do see "Any regular file or
> >>>> directory may have a set of extended attributes", so that was clearly
> >>>> the assumption.  Also, NFS4ERR_WRONG_TYPE is listed as a possible
> >>>> error return for the xattr ops.  But on a quick skim I don't see any
> >>>> explicit checks in the nfsd code, so I *think* it's just relying on
> >>>> the vfs for any file type checks.
> >>> Hi Bruce,
> >>>
> >>> Thanks for the response. I am just trying to do set a user.foo xattr on
> >>> a device node on nfs.
> >>>
> >>> setfattr -n "user.foo" -v "bar" /mnt/nfs/test-dev
> >>>
> >>> and I get -EACCESS.
> >>>
> >>> I put some printk() statements and EACCESS is being returned from here.
> >>>
> >>> nfs4_xattr_set_nfs4_user() {
> >>>         if (!nfs_access_get_cached(inode, current_cred(), &cache, true)) {
> >>>                 if (!(cache.mask & NFS_ACCESS_XAWRITE)) {
> >>>                         return -EACCES;
> >>>                 }
> >>>         }
> >>> }
> >>>
> >>> Value of cache.mask=0xd at the time of error.
> >> Looks like 0xd is what the server returns to access on a device node
> >> with mode bits rw- for the caller.
> >>
> >> Commit c11d7fd1b317 "nfsd: take xattr bits into account for permission
> >> checks" added the ACCESS_X* bits for regular files and directories but
> >> not others.
> >>
> >> But you don't want to determine permission from the mode bits anyway,
> >> you want it to depend on the owner,
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
> > not get a chance to block that operation.
> 
> That isn't going to fly. SELinux and Smack don't rely on ownership
> as a criteria for access. Being the owner of a symlink conveys no
> special privilege. The LSM must be consulted to determine if the
> module's policy allows the access.

Getting back to this thread after a while. Sorry got busy in other
things.

I noticed that if we skip calling inode_permission() for special files,
then we will skip calling security_inode_permission() but we will
still call security hooks for setxattr/getxattr/removexattr etc.

security_inode_setxattr()
security_inode_getxattr()
security_inode_removexattr()

So LSMs will still get a chance whether to allow/disallow this operation
or not.

And skipping security_inode_permission() kind of makes sense that for
special files, I am not writing to device. So taking permission from
LSMs, will not make much sense.

Thanks
Vivek

