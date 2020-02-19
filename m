Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3C71646DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 15:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgBSO0M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 09:26:12 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56773 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726736AbgBSO0M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582122371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SwbdCdyXUa5pzNUOdV4EzILeuR6QkLodR9sG4Q9g3Zk=;
        b=QdGQgdABbkWftURFGi3aBBv853OlTuyw1na1H2xmi8WLPuAwg30X7obWVCJdKZU13nmviX
        ckjDsRjN7XY/PgR28Iqkwk/9Pp+lRx+b3W99/7DktjDeEboLxCOCODeSlEThsq3ssXZ2e3
        9GuNgZhnRmOu93BIMRa6CCE+W2LQ+Uw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-ZvmF0NvoOfee_HPDXEdHJQ-1; Wed, 19 Feb 2020 09:26:06 -0500
X-MC-Unique: ZvmF0NvoOfee_HPDXEdHJQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75C7B107ACC5;
        Wed, 19 Feb 2020 14:26:05 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 02C735DA76;
        Wed, 19 Feb 2020 14:26:04 +0000 (UTC)
Date:   Wed, 19 Feb 2020 09:26:03 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] xfs: ensure that the inode uid/gid match values
 match the icdinode ones
Message-ID: <20200219142603.GB24157@bfoster>
References: <20200218210020.40846-1-hch@lst.de>
 <20200218210020.40846-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218210020.40846-2-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 01:00:18PM -0800, Christoph Hellwig wrote:
> Instead of only synchronizing the uid/gid values in xfs_setup_inode,
> ensure that they always match to prepare for removing the icdinode
> fields.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

The patch subject looks like it has an extra "match" in there. Otherwise
looks Ok to me:

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/xfs/libxfs/xfs_inode_buf.c | 2 ++
>  fs/xfs/xfs_icache.c           | 4 ++++
>  fs/xfs/xfs_inode.c            | 8 ++++++--
>  fs/xfs/xfs_iops.c             | 3 ---
>  4 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
> index 8afacfe4be0a..cc4efd34843a 100644
> --- a/fs/xfs/libxfs/xfs_inode_buf.c
> +++ b/fs/xfs/libxfs/xfs_inode_buf.c
> @@ -223,7 +223,9 @@ xfs_inode_from_disk(
>  
>  	to->di_format = from->di_format;
>  	to->di_uid = be32_to_cpu(from->di_uid);
> +	inode->i_uid = xfs_uid_to_kuid(to->di_uid);
>  	to->di_gid = be32_to_cpu(from->di_gid);
> +	inode->i_gid = xfs_gid_to_kgid(to->di_gid);
>  	to->di_flushiter = be16_to_cpu(from->di_flushiter);
>  
>  	/*
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index 8dc2e5414276..a7be7a9e5c1a 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -289,6 +289,8 @@ xfs_reinit_inode(
>  	uint64_t	version = inode_peek_iversion(inode);
>  	umode_t		mode = inode->i_mode;
>  	dev_t		dev = inode->i_rdev;
> +	kuid_t		uid = inode->i_uid;
> +	kgid_t		gid = inode->i_gid;
>  
>  	error = inode_init_always(mp->m_super, inode);
>  
> @@ -297,6 +299,8 @@ xfs_reinit_inode(
>  	inode_set_iversion_queried(inode, version);
>  	inode->i_mode = mode;
>  	inode->i_rdev = dev;
> +	inode->i_uid = uid;
> +	inode->i_gid = gid;
>  	return error;
>  }
>  
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index c5077e6326c7..938b0943bd95 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -812,15 +812,19 @@ xfs_ialloc(
>  
>  	inode->i_mode = mode;
>  	set_nlink(inode, nlink);
> -	ip->i_d.di_uid = xfs_kuid_to_uid(current_fsuid());
> -	ip->i_d.di_gid = xfs_kgid_to_gid(current_fsgid());
> +	inode->i_uid = current_fsuid();
> +	ip->i_d.di_uid = xfs_kuid_to_uid(inode->i_uid);
>  	inode->i_rdev = rdev;
>  	ip->i_d.di_projid = prid;
>  
>  	if (pip && XFS_INHERIT_GID(pip)) {
> +		inode->i_gid = VFS_I(pip)->i_gid;
>  		ip->i_d.di_gid = pip->i_d.di_gid;
>  		if ((VFS_I(pip)->i_mode & S_ISGID) && S_ISDIR(mode))
>  			inode->i_mode |= S_ISGID;
> +	} else {
> +		inode->i_gid = current_fsgid();
> +		ip->i_d.di_gid = xfs_kgid_to_gid(inode->i_gid);
>  	}
>  
>  	/*
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 81f2f93caec0..b818b261918f 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1304,9 +1304,6 @@ xfs_setup_inode(
>  	/* make the inode look hashed for the writeback code */
>  	inode_fake_hash(inode);
>  
> -	inode->i_uid    = xfs_uid_to_kuid(ip->i_d.di_uid);
> -	inode->i_gid    = xfs_gid_to_kgid(ip->i_d.di_gid);
> -
>  	i_size_write(inode, ip->i_d.di_size);
>  	xfs_diflags_to_iflags(inode, ip);
>  
> -- 
> 2.24.1
> 

