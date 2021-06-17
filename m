Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4683ABE14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 23:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhFQVaV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 17:30:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29548 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233113AbhFQVaN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 17:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623965284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RhJsSVihKBAF9j0RF6gY3Tl2fVYznxop1WZOCSrTXJ4=;
        b=UpBg0jjDYC0sQ5eFigWt8mYSmQjok+G0rzvifS496wONjxYB2q3fT+sJpY3l5t0NCRhBNn
        ld9g7AoMb3JGg4eTe+fB+V0ub93YXcNKkDnT5kDjY4vqdDlsMxhFba6sq8oEHssKsqiwhZ
        GyydsbBvoYhDAUVIuLaMRlxAHv8FE+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-l13QaLpAOw6ZXIaRrGlwug-1; Thu, 17 Jun 2021 17:28:03 -0400
X-MC-Unique: l13QaLpAOw6ZXIaRrGlwug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49F9D100CEC0;
        Thu, 17 Jun 2021 21:28:02 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-162.rdu2.redhat.com [10.10.116.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0525C5D6DC;
        Thu, 17 Jun 2021 21:28:02 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 8F923220BCF; Thu, 17 Jun 2021 17:28:01 -0400 (EDT)
Date:   Thu, 17 Jun 2021 17:28:01 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Max Reitz <mreitz@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fuse: fix illegal access to inode with reused nodeid
Message-ID: <20210617212801.GE1142820@redhat.com>
References: <20210609181158.479781-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609181158.479781-1-amir73il@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 09, 2021 at 09:11:58PM +0300, Amir Goldstein wrote:
> Server responds to LOOKUP and other ops (READDIRPLUS/CREATE/MKNOD/...)
> with outarg containing nodeid and generation.
> 
> If a fuse inode is found in inode cache with the same nodeid but
> different generation, the existing fuse inode should be unhashed and
> marked "bad" and a new inode with the new generation should be hashed
> instead.
> 
> This can happen, for example, with passhrough fuse filesystem that
> returns the real filesystem ino/generation on lookup and where real inode
> numbers can get recycled due to real files being unlinked not via the fuse
> passthrough filesystem.

Hi Amir,

Is the code for filesystem you have written is public? If yes, can you
please provide a link. 

Is there an API to lookup generation number from host filesystem. Or
that's something your file server updates based on file handle has
changed.

Thanks
Vivek

> 
> With current code, this situation will not be detected and an old fuse
> dentry that used to point to an older generation real inode, can be used
> to access a completely new inode, which should be accessed only via the
> new dentry.
> 
> Note that because the FORGET message carries the nodeid w/o generation,
> the server should wait to get FORGET counts for the nlookup counts of
> the old and reused inodes combined, before it can free the resources
> associated to that nodeid.
> 
> Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxgDMGUpK35huwqFYGH_idBB8S6eLiz85o0DDKOyDH4Syg@mail.gmail.com/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Miklos,
> 
> I was able to reproduce this issue with a passthrough fs that stored
> ino+generation and uses then to open fd on lookup.
> 
> I extended libfuse's test_syscalls [1] program to demonstrate the issue
> described in commit message.
> 
> Max, IIUC, you are making a modification to virtiofs-rs that would
> result is being exposed to this bug.  You are welcome to try out the
> test and let me know if you can reproduce the issue.
> 
> Note that some test_syscalls test fail with cache enabled, so libfuse's
> test_examples.py only runs test_syscalls in cache disabled config.
> 
> Thanks,
> Amir.
> 
> [1] https://github.com/amir73il/libfuse/commits/test-reused-inodes
> 
>  fs/fuse/dir.c     | 3 ++-
>  fs/fuse/fuse_i.h  | 9 +++++++++
>  fs/fuse/inode.c   | 4 ++--
>  fs/fuse/readdir.c | 7 +++++--
>  4 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 1b6c001a7dd1..b06628fd7d8e 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -239,7 +239,8 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
>  		if (!ret) {
>  			fi = get_fuse_inode(inode);
>  			if (outarg.nodeid != get_node_id(inode) ||
> -			    (bool) IS_AUTOMOUNT(inode) != (bool) (outarg.attr.flags & FUSE_ATTR_SUBMOUNT)) {
> +			    fuse_stale_inode(inode, outarg.generation,
> +					     &outarg.attr)) {
>  				fuse_queue_forget(fm->fc, forget,
>  						  outarg.nodeid, 1);
>  				goto invalid;
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 7e463e220053..f1bd28c176a9 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -867,6 +867,15 @@ static inline u64 fuse_get_attr_version(struct fuse_conn *fc)
>  	return atomic64_read(&fc->attr_version);
>  }
>  
> +static inline bool fuse_stale_inode(const struct inode *inode, int generation,
> +				    struct fuse_attr *attr)
> +{
> +	return inode->i_generation != generation ||
> +		inode_wrong_type(inode, attr->mode) ||
> +		(bool) IS_AUTOMOUNT(inode) !=
> +		(bool) (attr->flags & FUSE_ATTR_SUBMOUNT);
> +}
> +
>  static inline void fuse_make_bad(struct inode *inode)
>  {
>  	remove_inode_hash(inode);
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 393e36b74dc4..257bb3e1cac8 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -350,8 +350,8 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
>  		inode->i_generation = generation;
>  		fuse_init_inode(inode, attr);
>  		unlock_new_inode(inode);
> -	} else if (inode_wrong_type(inode, attr->mode)) {
> -		/* Inode has changed type, any I/O on the old should fail */
> +	} else if (fuse_stale_inode(inode, generation, attr)) {
> +		/* nodeid was reused, any I/O on the old inode should fail */
>  		fuse_make_bad(inode);
>  		iput(inode);
>  		goto retry;
> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
> index 277f7041d55a..bc267832310c 100644
> --- a/fs/fuse/readdir.c
> +++ b/fs/fuse/readdir.c
> @@ -200,9 +200,12 @@ static int fuse_direntplus_link(struct file *file,
>  	if (!d_in_lookup(dentry)) {
>  		struct fuse_inode *fi;
>  		inode = d_inode(dentry);
> +		if (inode && get_node_id(inode) != o->nodeid)
> +			inode = NULL;
>  		if (!inode ||
> -		    get_node_id(inode) != o->nodeid ||
> -		    inode_wrong_type(inode, o->attr.mode)) {
> +		    fuse_stale_inode(inode, o->generation, &o->attr)) {
> +			if (inode)
> +				fuse_make_bad(inode);
>  			d_invalidate(dentry);
>  			dput(dentry);
>  			goto retry;
> -- 
> 2.31.1
> 

