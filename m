Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5AD03A4675
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 18:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhFKQ2F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 12:28:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47428 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229517AbhFKQ2E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623428766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wbd+Q3J1hluR7bgmV2oDJflS4WjrgBARp0Ui6U8D40E=;
        b=CmmAfE0R8jobNkJrn0Kj1BPxlG9McTd0fcACjVLjjQsaIDDuR7hCc2+AV3plg/hTzvu5sH
        KKYgxiQyEKa9xTGyE24iJ/F0633ZjNuNIvMfJVjNSThXQZjf2ks3XW5ZuUKUNNC/FL/f3N
        mLtiEqyg3aRjIT0xlJUEYf713T9DA8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-hcUe03DxOKaqUq9Kt5I8rw-1; Fri, 11 Jun 2021 12:26:04 -0400
X-MC-Unique: hcUe03DxOKaqUq9Kt5I8rw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7E07800C60;
        Fri, 11 Jun 2021 16:26:03 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-174.rdu2.redhat.com [10.10.116.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A548F61008;
        Fri, 11 Jun 2021 16:26:03 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 361CE22054F; Fri, 11 Jun 2021 12:26:03 -0400 (EDT)
Date:   Fri, 11 Jun 2021 12:26:03 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Max Reitz <mreitz@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fuse: fix illegal access to inode with reused nodeid
Message-ID: <20210611162603.GA747424@redhat.com>
References: <20210609181158.479781-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609181158.479781-1-amir73il@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
> 
> With current code, this situation will not be detected and an old fuse
> dentry that used to point to an older generation real inode, can be used
> to access a completely new inode, which should be accessed only via the
> new dentry.

Hi Amir,

Curious that how server gets access to new inode on host. If server
keeps an fd open to file, then we will continue to refer to old
unlinked file. Well in that case inode number can't be recycled to
begin with, so this situation does not arise to begin with.

If server is keeping file handles (like Max's patches) and file gets
recycled and inode number recycled, then I am assuming old inode in
server can't resolve that file handle because that file is gone
and a new file/inode is in place. IOW, I am assuming open_by_handle_at()
should fail in this case.

IOW, IIUC, even if we refer to old inode, server does not have a 
way to provide access to new file (with reused inode number). And
will be forced to return -ESTALE or something like that?  Did I 
miss the point completely?

> 
> Note that because the FORGET message carries the nodeid w/o generation,
> the server should wait to get FORGET counts for the nlookup counts of
> the old and reused inodes combined, before it can free the resources
> associated to that nodeid.

This seems like an odd piece. Wondering if it will make sense to enhance
FORGET message to also send generation number so that server does not
have to keep both the inodes around.

Thanks
Vivek

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

