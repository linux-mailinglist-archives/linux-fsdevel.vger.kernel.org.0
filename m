Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E4630AD9A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 18:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhBARSF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 12:18:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:58212 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231864AbhBARR7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:17:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5DC5BAC3A;
        Mon,  1 Feb 2021 17:17:18 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id b2ac17a6;
        Mon, 1 Feb 2021 17:18:13 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v4 15/17] ceph: make d_revalidate call fscrypt
 revalidator for encrypted dentries
References: <20210120182847.644850-1-jlayton@kernel.org>
        <20210120182847.644850-16-jlayton@kernel.org>
Date:   Mon, 01 Feb 2021 17:18:07 +0000
In-Reply-To: <20210120182847.644850-16-jlayton@kernel.org> (Jeff Layton's
        message of "Wed, 20 Jan 2021 13:28:45 -0500")
Message-ID: <87zh0nyaeo.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> writes:

> If we have a dentry which represents a no-key name, then we need to test
> whether the parent directory's encryption key has since been added.  Do
> that before we test anything else about the dentry.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ceph/dir.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 236c381ab6bd..cb7ff91a243a 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -1726,6 +1726,10 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
>  	dout("d_revalidate %p '%pd' inode %p offset 0x%llx\n", dentry,
>  	     dentry, inode, ceph_dentry(dentry)->offset);
>  
> +	valid = fscrypt_d_revalidate(dentry, flags);
> +	if (valid <= 0)
> +		return valid;
> +

This one took me a while to figure out, but eventually got there.
Initially I was seeing this error:

crypt: ceph: 1 inode(s) still busy after removing key with identifier f019f4a1c5d5665675218f89fccfa3c7, including ino 1099511627791

and, when umounting the filesystem I would get the warning in
fs/dcache.c:1623.

Anyway, the patch below should fix it.

Unfortunately I didn't had a lot of time to look into the -experimental
branch yet.  On my TODO list for the next few days.

Cheers,
-- 
Luis


diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index ae0890be0c9d..d3ac39c6645f 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1781,7 +1781,7 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 
 	valid = fscrypt_d_revalidate(dentry, flags);
 	if (valid <= 0)
-		return valid;
+		goto out;
 
 	mdsc = ceph_sb_to_client(dir->i_sb)->mdsc;
 
@@ -1853,6 +1853,7 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 	if (!valid)
 		ceph_dir_clear_complete(dir);
 
+out:
 	if (!(flags & LOOKUP_RCU))
 		dput(parent);
 	return valid;



>  	mdsc = ceph_sb_to_client(dir->i_sb)->mdsc;
>  
>  	/* always trust cached snapped dentries, snapdir dentry */
> -- 
>
> 2.29.2
>
