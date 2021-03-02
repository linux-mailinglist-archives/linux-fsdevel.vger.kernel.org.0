Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EBD32B4B0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Mar 2021 06:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354144AbhCCFZ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 00:25:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22719 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1448977AbhCBQDT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 11:03:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614700856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sT+3MBs93ZkS6Kl/MHPW0L5wZEKnpVkvAcVrn9n7a8o=;
        b=g2UbuiIbetPzDwg018SZSbqGIcdZJt2wgJ5sq5/9tLMv6YBksttAIyYo+0NC9so0B1a5PD
        b6HZtkRNOCJJ8ehSPajOQ/vTTbQI58ZMHkLUJ2GGDXQ3LKFrqxToJKyT1I4Vr8DXuR7Tms
        DjQaNOt8InSj4gnKsfhSwQah4EjQAYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-fR8QzrH2MFOitEjz-uD3ag-1; Tue, 02 Mar 2021 11:00:41 -0500
X-MC-Unique: fR8QzrH2MFOitEjz-uD3ag-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B71DE801A87;
        Tue,  2 Mar 2021 16:00:39 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-140.rdu2.redhat.com [10.10.114.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A7DA5FC3A;
        Tue,  2 Mar 2021 16:00:34 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 975FB22054F; Tue,  2 Mar 2021 11:00:33 -0500 (EST)
Date:   Tue, 2 Mar 2021 11:00:33 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, linux-kernel@vger.kernel.org,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [RFC PATCH] fuse: Clear SGID bit when setting mode in setacl
Message-ID: <20210302160033.GD220334@redhat.com>
References: <20210226183357.28467-1-lhenriques@suse.de>
 <20210301163324.GC186178@redhat.com>
 <YD0wbmulcBVZ7VZy@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD0wbmulcBVZ7VZy@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 01, 2021 at 06:20:30PM +0000, Luis Henriques wrote:
> On Mon, Mar 01, 2021 at 11:33:24AM -0500, Vivek Goyal wrote:
> > On Fri, Feb 26, 2021 at 06:33:57PM +0000, Luis Henriques wrote:
> > > Setting file permissions with POSIX ACLs (setxattr) isn't clearing the
> > > setgid bit.  This seems to be CVE-2016-7097, detected by running fstest
> > > generic/375 in virtiofs.  Unfortunately, when the fix for this CVE landed
> > > in the kernel with commit 073931017b49 ("posix_acl: Clear SGID bit when
> > > setting file permissions"), FUSE didn't had ACLs support yet.
> > 
> > Hi Luis,
> > 
> > Interesting. I did not know that "chmod" can lead to clearing of SGID
> > as well. Recently we implemented FUSE_HANDLE_KILLPRIV_V2 flag which
> > means that file server is responsible for clearing of SUID/SGID/caps
> > as per following rules.
> > 
> >     - caps are always cleared on chown/write/truncate
> >     - suid is always cleared on chown, while for truncate/write it is cleared
> >       only if caller does not have CAP_FSETID.
> >     - sgid is always cleared on chown, while for truncate/write it is cleared
> >       only if caller does not have CAP_FSETID as well as file has group execute
> >       permission.
> > 
> > And we don't have anything about "chmod" in this list. Well, I will test
> > this and come back to this little later.
> > 
> > I see following comment in fuse_set_acl().
> > 
> >                 /*
> >                  * Fuse userspace is responsible for updating access
> >                  * permissions in the inode, if needed. fuse_setxattr
> >                  * invalidates the inode attributes, which will force
> >                  * them to be refreshed the next time they are used,
> >                  * and it also updates i_ctime.
> >                  */
> > 
> > So looks like that original code has been written with intent that
> > file server is responsible for updating inode permissions. I am
> > assuming this will include clearing of S_ISGID if needed.
> > 
> > But question is, does file server has enough information to be able
> > to handle proper clearing of S_ISGID info. IIUC, file server will need
> > two pieces of information atleast.
> > 
> > - gid of the caller.
> > - Whether caller has CAP_FSETID or not.
> > 
> > I think we have first piece of information but not the second one. May
> > be we need to send this in fuse_setxattr_in->flags. And file server
> > can drop CAP_FSETID while doing setxattr().
> > 
> > What about "gid" info. We don't change to caller's uid/gid while doing
> > setxattr(). So host might not clear S_ISGID or clear it when it should
> > not. I am wondering that can we switch to caller's uid/gid in setxattr(),
> > atleast while setting acls.
> 
> Thank for looking into this.  To be honest, initially I thought that the
> fix should be done in the server too, but when I looked into the code I
> couldn't find an easy way to get that done (without modifying the data
> being passed from the kernel in setxattr).
> 
> So, what I've done was to look at what other filesystems were doing in the
> ACL code, and that's where I found out about this CVE.  The CVE fix for
> the other filesystems looked easy enough to be included in FUSE too.

Hi Luis,

I still feel that it should probably be fixed in virtiofsd, given fuse client
is expecting file server to take care of any change of mode (file
permission bits).

I wrote a proof of concept patch and this should fix this. But it
drop CAP_FSETID always. So I will need to modify kernel to pass
this information to file server and that should properly fix
generic/375. 

Please have a look. This applies on top of fuse acl support V4 patches
I had posted. I have pushed all the patches on a temporary git branch
as well.

https://github.com/rhvgoyal/qemu/commits/acl-sgid

Vivek


Subject: virtiofsd: Switch creds, drop FSETID for system.posix_acl_access xattr

When posix access acls are set on a file, it can lead to adjusting file
permissions (mode) as well. If caller does not have CAP_FSETID and it
also does not have membership of owner group, this will lead to clearing
SGID bit in mode.

Current fuse code is written in such a way that it expects file server
to take care of chaning file mode (permission), if there is a need.
Right now, host kernel does not clear SGID bit because virtiofsd is
running as root and has CAP_FSETID. For host kernel to clear SGID,
virtiofsd need to switch to gid of caller in guest and also drop
CAP_FSETID (if caller did not have it to begin with).

This is a proof of concept patch which switches to caller's uid/gid
and alwasys drops CAP_FSETID in lo_setxattr(system.posix_acl_access).
This should fix the xfstest generic/375 test case.

This patch is not complete yet. Kernel should pass information when
to drop CAP_FSETID and when not to. I will look into modifying
kernel to pass this information to file server.

Reported-by: Luis Henriques <lhenriques@suse.de>
Yet-to-be-signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c |   28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

Index: rhvgoyal-qemu/tools/virtiofsd/passthrough_ll.c
===================================================================
--- rhvgoyal-qemu.orig/tools/virtiofsd/passthrough_ll.c	2021-03-02 08:06:20.539820330 -0500
+++ rhvgoyal-qemu/tools/virtiofsd/passthrough_ll.c	2021-03-02 10:46:40.901334665 -0500
@@ -172,7 +172,7 @@ struct lo_data {
     int user_killpriv_v2, killpriv_v2;
     /* If set, virtiofsd is responsible for setting umask during creation */
     bool change_umask;
-    int user_posix_acl;
+    int user_posix_acl, posix_acl;
 };
 
 static const struct fuse_opt lo_opts[] = {
@@ -677,6 +677,7 @@ static void lo_init(void *userdata, stru
         fuse_log(FUSE_LOG_DEBUG, "lo_init: enabling posix acl\n");
         conn->want |= FUSE_CAP_POSIX_ACL | FUSE_CAP_DONT_MASK;
         lo->change_umask = true;
+        lo->posix_acl = true;
     } else {
         /* User either did not specify anything or wants it disabled */
         fuse_log(FUSE_LOG_DEBUG, "lo_init: disabling posix_acl\n");
@@ -2981,12 +2982,37 @@ static void lo_setxattr(fuse_req_t req,
 
     sprintf(procname, "%i", inode->fd);
     if (S_ISREG(inode->filetype) || S_ISDIR(inode->filetype)) {
+        bool switched_creds = false;
+        struct lo_cred old = {};
+
         fd = openat(lo->proc_self_fd, procname, O_RDONLY);
         if (fd < 0) {
             saverr = errno;
             goto out;
         }
+
+        if (lo->posix_acl && !strcmp(name, "system.posix_acl_access")) {
+            ret = lo_change_cred(req, &old, false);
+            if (ret) {
+                saverr = ret;
+                goto out;
+            }
+            ret = drop_effective_cap("FSETID", NULL);
+            if (ret != 0) {
+                lo_restore_cred(&old, false);
+                saverr = ret;
+                goto out;
+            }
+            switched_creds = true;
+        }
+
         ret = fsetxattr(fd, name, value, size, flags);
+
+        if (switched_creds) {
+            if (gain_effective_cap("FSETID"))
+                fuse_log(FUSE_LOG_ERR, "Failed to gain CAP_FSETID\n");
+            lo_restore_cred(&old, false);
+        }
     } else {
         /* fchdir should not fail here */
         assert(fchdir(lo->proc_self_fd) == 0);

