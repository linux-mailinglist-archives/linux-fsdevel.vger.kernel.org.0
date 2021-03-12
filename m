Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5463398CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 22:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbhCLVAN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 16:00:13 -0500
Received: from mxchg03.rrz.uni-hamburg.de ([134.100.38.113]:40761 "EHLO
        mxchg03.rrz.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235115AbhCLVAI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 16:00:08 -0500
X-Greylist: delayed 477 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Mar 2021 16:00:07 EST
X-Virus-Scanned: by University of Hamburg ( RRZ / mgw05.rrz.uni-hamburg.de )
Received: from mailhost.uni-hamburg.de (mailhost.uni-hamburg.de [134.100.38.99])
        by mxchg03.rrz.uni-hamburg.de (Postfix) with ESMTPS;
        Fri, 12 Mar 2021 21:52:04 +0100 (CET)
X-Virus-Scanned: by University of Hamburg ( RRZ / mh06.rrz.uni-hamburg.de )
Received: from [192.168.178.93] (dynamic-077-003-126-133.77.3.pool.telefonica.de [77.3.126.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: fmsv030@uni-hamburg.de)
        by mailhost.uni-hamburg.de (Postfix) with ESMTPSA id 3FBDBBE2F3;
        Fri, 12 Mar 2021 21:52:04 +0100 (CET)
To:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <161550398415.1983424.4857046033308089813.stgit@warthog.procyon.org.uk>
 <161550399833.1983424.16644306048746346626.stgit@warthog.procyon.org.uk>
From:   Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>
Subject: Re: [PATCH v2 2/2] afs: Stop listxattr() from listing "afs.*"
 attributes
Message-ID: <f58e6dbf-cc0b-8847-e66d-8d747d87531a@math.uni-hamburg.de>
Date:   Fri, 12 Mar 2021 21:52:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <161550399833.1983424.16644306048746346626.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: de-AT-frami
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 12.03.21 um 00:06 schrieb David Howells:
> afs_listxattr() lists all the available special afs xattrs (i.e. those in
> the "afs.*" space), no matter what type of server we're dealing with.  But
> OpenAFS servers, for example, cannot deal with some of the extra-capable
> attributes that AuriStor (YFS) servers provide.  Unfortunately, the
> presence of the afs.yfs.* attributes causes errors[1] for anything that
> tries to read them if the server is of the wrong type.
> 
> Fix the problem by removing afs_listxattr() so that none of the special
> xattrs are listed (AFS doesn't support xattrs).  It does mean, however,
> that getfattr won't list them, though they can still be accessed with
> getxattr() and setxattr().
> 
> This can be tested with something like:
> 
> 	getfattr -d -m ".*" /afs/example.com/path/to/file
> 
> With this change, none of the afs.* attributes should be visible.
> 
> Changes:
> ver #2:
>  - Hide all of the afs.* xattrs, not just the ACL ones.
> 
> Fixes: ae46578b963f ("afs: Get YFS ACLs and information through xattrs")
> Reported-by: Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-afs@lists.infradead.org
> Link: http://lists.infradead.org/pipermail/linux-afs/2021-March/003502.html [1]
> Link: http://lists.infradead.org/pipermail/linux-afs/2021-March/003567.html # v1
> ---
> 
>  fs/afs/dir.c      |    1 -
>  fs/afs/file.c     |    1 -
>  fs/afs/inode.c    |    1 -
>  fs/afs/internal.h |    1 -
>  fs/afs/mntpt.c    |    1 -
>  fs/afs/xattr.c    |   23 -----------------------
>  6 files changed, 28 deletions(-)
> 
> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index 714fcca9af99..17548c1faf02 100644
> --- a/fs/afs/dir.c
> +++ b/fs/afs/dir.c
> @@ -70,7 +70,6 @@ const struct inode_operations afs_dir_inode_operations = {
>  	.permission	= afs_permission,
>  	.getattr	= afs_getattr,
>  	.setattr	= afs_setattr,
> -	.listxattr	= afs_listxattr,
>  };
>  
>  const struct address_space_operations afs_dir_aops = {
> diff --git a/fs/afs/file.c b/fs/afs/file.c
> index 85f5adf21aa0..960b64268623 100644
> --- a/fs/afs/file.c
> +++ b/fs/afs/file.c
> @@ -43,7 +43,6 @@ const struct inode_operations afs_file_inode_operations = {
>  	.getattr	= afs_getattr,
>  	.setattr	= afs_setattr,
>  	.permission	= afs_permission,
> -	.listxattr	= afs_listxattr,
>  };
>  
>  const struct address_space_operations afs_fs_aops = {
> diff --git a/fs/afs/inode.c b/fs/afs/inode.c
> index 1156b2df28d3..12be88716e4c 100644
> --- a/fs/afs/inode.c
> +++ b/fs/afs/inode.c
> @@ -27,7 +27,6 @@
>  
>  static const struct inode_operations afs_symlink_inode_operations = {
>  	.get_link	= page_get_link,
> -	.listxattr	= afs_listxattr,
>  };
>  
>  static noinline void dump_vnode(struct afs_vnode *vnode, struct afs_vnode *parent_vnode)
> diff --git a/fs/afs/internal.h b/fs/afs/internal.h
> index b626e38e9ab5..1627b1872812 100644
> --- a/fs/afs/internal.h
> +++ b/fs/afs/internal.h
> @@ -1509,7 +1509,6 @@ extern int afs_launder_page(struct page *);
>   * xattr.c
>   */
>  extern const struct xattr_handler *afs_xattr_handlers[];
> -extern ssize_t afs_listxattr(struct dentry *, char *, size_t);
>  
>  /*
>   * yfsclient.c
> diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
> index 052dab2f5c03..bbb2c210d139 100644
> --- a/fs/afs/mntpt.c
> +++ b/fs/afs/mntpt.c
> @@ -32,7 +32,6 @@ const struct inode_operations afs_mntpt_inode_operations = {
>  	.lookup		= afs_mntpt_lookup,
>  	.readlink	= page_readlink,
>  	.getattr	= afs_getattr,
> -	.listxattr	= afs_listxattr,
>  };
>  
>  const struct inode_operations afs_autocell_inode_operations = {
> diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c
> index 4934e325a14a..7751b0b3f81d 100644
> --- a/fs/afs/xattr.c
> +++ b/fs/afs/xattr.c
> @@ -11,29 +11,6 @@
>  #include <linux/xattr.h>
>  #include "internal.h"
>  
> -static const char afs_xattr_list[] =
> -	"afs.acl\0"
> -	"afs.cell\0"
> -	"afs.fid\0"
> -	"afs.volume\0"
> -	"afs.yfs.acl\0"
> -	"afs.yfs.acl_inherited\0"
> -	"afs.yfs.acl_num_cleaned\0"
> -	"afs.yfs.vol_acl";
> -
> -/*
> - * Retrieve a list of the supported xattrs.
> - */
> -ssize_t afs_listxattr(struct dentry *dentry, char *buffer, size_t size)
> -{
> -	if (size == 0)
> -		return sizeof(afs_xattr_list);
> -	if (size < sizeof(afs_xattr_list))
> -		return -ERANGE;
> -	memcpy(buffer, afs_xattr_list, sizeof(afs_xattr_list));
> -	return sizeof(afs_xattr_list);
> -}
> -
>  /*
>   * Deal with the result of a successful fetch ACL operation.
>   */

Tested-by: Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>

Works for me:
$ getfattr -d -m - /afs/openafs.org/
$ getfattr -d -m - /afs/your-file-system.com/
these two show nothing as expected

$ getfattr -n afs.acl /afs/openafs.org/
$ getfattr -n afs.acl /afs/your-file-system.com/
these two show the ACL as expected

$ getfattr -n afs.yfs.acl /afs/openafs.org/
$ getfattr -n afs.yfs.acl /afs/your-file-system.com/
the latter shows as expected the YFS-ACL,
the former as expected the simple message "No such attribute".


Only as a "BTW", the primary Patch-Description has a minor mistake: In
the email titled "[PATCH v2 0/2] AFS metadata xattr fixes", you write:

> Fix an oops in AFS that can be triggered by accessing one of the
>      afs.yfs.* xattrs against a yfs server[1][2]

That should of course be "against an OpenAFS server".

Greetings,
Gaja Peters

-- 
+----------
| IT-Gruppe, Systemadministration
| Universität Hamburg, Fachbereich Mathematik
| Bundesstr. 55 (Geomatikum)
| Raum 212; Tel. 42838-5175
+----------
