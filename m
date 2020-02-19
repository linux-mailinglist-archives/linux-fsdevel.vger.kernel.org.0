Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC447164232
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 11:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgBSKdA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 05:33:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24868 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726487AbgBSKc7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582108378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FueltgpkzAlhJDAhIe85WleMfHR8Az0odD0aapskUck=;
        b=TT7rnDbC+jSsYTwYkUmx28WO8XeX0T/C/vG89yCjwAOu4tdNjEjfr/s7CcdIf98le4KP0D
        B282wWQ9/GgatL4fDORjg6odstvY1Lw0z+Co0h+oV54ZkJQUZryj58Du60WSXa7o7i9K9P
        jMQqDF4yLG78TOMlj04NxAkxvrKDRE0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-1s0gVVxMObKDSDUxr_p86A-1; Wed, 19 Feb 2020 05:32:56 -0500
X-MC-Unique: 1s0gVVxMObKDSDUxr_p86A-1
Received: by mail-wr1-f72.google.com with SMTP id n23so12348415wra.20
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2020 02:32:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=FueltgpkzAlhJDAhIe85WleMfHR8Az0odD0aapskUck=;
        b=rUIoIwkg+FDXDQ6Jlk7r64GISbPohOEqnlOD2HSSkEbV5kcSBNxQTNAYfzjAcOYzz5
         I0csTn7IMnvjHy8SXxYlSgwI4AxTICK0hatbaybK2WsVwtJTxo0iwkdU+hHlXzPyvkIs
         YG6KZ8w0GNtAO7Vdn0oezn+rmRXPhzzea77lBrzYtQtPV1qQfiRg1w8XC/9eHzBwwP52
         xow9xv3D8GpsXNCqT+O8cCQVo/JBeKp7ENQDHW7mpguF45tiwjzm/KwMjSvoUGPVT/6p
         JQpE5SK5CCO/Vr5gA/8L9WBV7IYVTAtxZd90kxEfC9epvhZKwDz2CseqiE/ejGJNNxjc
         tDxQ==
X-Gm-Message-State: APjAAAV8rRWzBTjdieyo83wvrPZfSIAZgPAhPiTMzUdMKOsFtcx6UEMa
        n1/zbjaUZhAk7uI7rH9lTuWMwXo0Peu+RNv1De2qCrkdLEKl7i5lAVr2Fl/AJzO2LQsZV7H8/5+
        LvsZ+YvqW7v8XLhjmuL/uSuyzwA==
X-Received: by 2002:a5d:6404:: with SMTP id z4mr8320153wru.262.1582108375039;
        Wed, 19 Feb 2020 02:32:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqyEBmwVbQxdAuZuruB1+01qm7Mr8gSt9LDSMaBs8O3010RfxmbOPdx8dK+S+jon3Kw6tzm0PQ==
X-Received: by 2002:a5d:6404:: with SMTP id z4mr8320131wru.262.1582108374780;
        Wed, 19 Feb 2020 02:32:54 -0800 (PST)
Received: from andromeda (ip-89-103-126-188.net.upcbroadband.cz. [89.103.126.188])
        by smtp.gmail.com with ESMTPSA id z6sm2370996wrw.36.2020.02.19.02.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 02:32:54 -0800 (PST)
Date:   Wed, 19 Feb 2020 11:32:52 +0100
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] xfs: ensure that the inode uid/gid match values
 match the icdinode ones
Message-ID: <20200219103252.354iqhl2td7ekzdg@andromeda>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200218210020.40846-1-hch@lst.de>
 <20200218210020.40846-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218210020.40846-2-hch@lst.de>
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


Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>


> ---
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

-- 
Carlos

