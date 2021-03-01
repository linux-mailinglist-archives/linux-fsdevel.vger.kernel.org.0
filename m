Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE9F328ABA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 19:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbhCASWS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 13:22:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:50960 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239623AbhCASUH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 13:20:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BC6DAAFAF;
        Mon,  1 Mar 2021 18:19:21 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 1f142bb4;
        Mon, 1 Mar 2021 18:20:31 +0000 (UTC)
Date:   Mon, 1 Mar 2021 18:20:30 +0000
From:   Luis Henriques <lhenriques@suse.de>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, linux-kernel@vger.kernel.org,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [RFC PATCH] fuse: Clear SGID bit when setting mode in setacl
Message-ID: <YD0wbmulcBVZ7VZy@suse.de>
References: <20210226183357.28467-1-lhenriques@suse.de>
 <20210301163324.GC186178@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210301163324.GC186178@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 01, 2021 at 11:33:24AM -0500, Vivek Goyal wrote:
> On Fri, Feb 26, 2021 at 06:33:57PM +0000, Luis Henriques wrote:
> > Setting file permissions with POSIX ACLs (setxattr) isn't clearing the
> > setgid bit.  This seems to be CVE-2016-7097, detected by running fstest
> > generic/375 in virtiofs.  Unfortunately, when the fix for this CVE landed
> > in the kernel with commit 073931017b49 ("posix_acl: Clear SGID bit when
> > setting file permissions"), FUSE didn't had ACLs support yet.
> 
> Hi Luis,
> 
> Interesting. I did not know that "chmod" can lead to clearing of SGID
> as well. Recently we implemented FUSE_HANDLE_KILLPRIV_V2 flag which
> means that file server is responsible for clearing of SUID/SGID/caps
> as per following rules.
> 
>     - caps are always cleared on chown/write/truncate
>     - suid is always cleared on chown, while for truncate/write it is cleared
>       only if caller does not have CAP_FSETID.
>     - sgid is always cleared on chown, while for truncate/write it is cleared
>       only if caller does not have CAP_FSETID as well as file has group execute
>       permission.
> 
> And we don't have anything about "chmod" in this list. Well, I will test
> this and come back to this little later.
> 
> I see following comment in fuse_set_acl().
> 
>                 /*
>                  * Fuse userspace is responsible for updating access
>                  * permissions in the inode, if needed. fuse_setxattr
>                  * invalidates the inode attributes, which will force
>                  * them to be refreshed the next time they are used,
>                  * and it also updates i_ctime.
>                  */
> 
> So looks like that original code has been written with intent that
> file server is responsible for updating inode permissions. I am
> assuming this will include clearing of S_ISGID if needed.
> 
> But question is, does file server has enough information to be able
> to handle proper clearing of S_ISGID info. IIUC, file server will need
> two pieces of information atleast.
> 
> - gid of the caller.
> - Whether caller has CAP_FSETID or not.
> 
> I think we have first piece of information but not the second one. May
> be we need to send this in fuse_setxattr_in->flags. And file server
> can drop CAP_FSETID while doing setxattr().
> 
> What about "gid" info. We don't change to caller's uid/gid while doing
> setxattr(). So host might not clear S_ISGID or clear it when it should
> not. I am wondering that can we switch to caller's uid/gid in setxattr(),
> atleast while setting acls.

Thank for looking into this.  To be honest, initially I thought that the
fix should be done in the server too, but when I looked into the code I
couldn't find an easy way to get that done (without modifying the data
being passed from the kernel in setxattr).

So, what I've done was to look at what other filesystems were doing in the
ACL code, and that's where I found out about this CVE.  The CVE fix for
the other filesystems looked easy enough to be included in FUSE too.

Cheers,
--
Luís
