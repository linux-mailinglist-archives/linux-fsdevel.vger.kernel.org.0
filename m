Return-Path: <linux-fsdevel+bounces-41544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0535DA316F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 21:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 363E87A399A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 20:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5C42641E6;
	Tue, 11 Feb 2025 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="njqP1IBt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB1A2641CD
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2025 20:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739307388; cv=none; b=doPG7/xgrHA/N2COUU7pwIXTrAP5S9fwpxxhaiyC8KQ51SdgQksG7enS7HXrroNtE3TwS6pZPgLkrXm58yfK4PN4H/yhS2vD7vd+A9vB5bOgf9svylCNQ3ZWJFlXzlEH0Vut9R1C3cu7WUbD8n68eymphZZd7Z6J3chwNm23PHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739307388; c=relaxed/simple;
	bh=rryhzbS3Oo89ck9xsb//oMPMG0GTl8WvqO0d6fQNrBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUZzjj/ueawDPU3PLAMwK8wQGXEMtiC9t1tdj8YAJE2OJqJVQVmE3LyMpHhEhkB7mBWkXvZ4oPBGiMk6ksqmUdfqMpINVIOglOO6lIDW33Rtqtux9+a5YY+YekgsTz91GgvEp4EPgriJBAe7brBqQ9Ax3wz1zQl/+BnkmpD+L74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=njqP1IBt; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f3c119fe6so137574975ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2025 12:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739307385; x=1739912185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yyoMkG5bzzx14S5ohymSPtkrSkcAjAOde1zaqVi+nGE=;
        b=njqP1IBtpwvV6zr/fACeD+OTnN4PQ3ZtTHkQfLzCFSpHOirnQoHZr3GjoF/IC8VIjz
         3/JVJ0pxpT+VBAvUMQIntsg4tYLLF9kRVJVETJZFVsG8EayVlG8SwrCYnTk4416nlKpG
         ZswODyx8EVymPFBpnnWVVZ2HkIi0+pTJJvPD8naiI4tHPyJU7t8MYkeXLfzGUlL6tN/f
         Cdjds0ynH7IrtQ8vUqnWS3Z7VwGa7qoI7wBGySCcL1qet19s9GkaFmo46tljweW6jkhh
         VKLYoOs8SHcFobCc/zIAdKPSc3Tnc1QuUQ2yYreaqI+GyFbUoVRtrs6nYkEHxx/IEUzy
         FEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739307385; x=1739912185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyoMkG5bzzx14S5ohymSPtkrSkcAjAOde1zaqVi+nGE=;
        b=l9ePoe0jLePTDDhyixazRSpn8SilfPC+FJLZrmOG3i4FkZdbFKmWw+p8DQOgM7m3Kq
         tniv5tvAzY8uo+sDX1IiRTnVEJy/M8YcHZ+LlccnjUtzPgkN2RYTzzu5d1pics4CoeP4
         wg8ICANLYOqmSozh5rCGO8qf7rPCcbuCfJFrbbhcAiQAn05s2Bf+6jZaKl2FQUmLp4MP
         ooJLebl1cQt/Yky8/vP/OCWfCZue6eqZq1TpA5m7H5LA/y5Ov3h8FNGk48kiaMop4Wd5
         hgCRRwQA2EjOYQt9ld86ConbpgHJ18wkm/AfQ71/3vv8dT+C+GX+MVVzkyCLGT0LwG+1
         uLIw==
X-Forwarded-Encrypted: i=1; AJvYcCUOuqaJX9Vz0SNI6+ZB3Mj7BAOmeL+KGW3Ui3V2MVpnkPEUY7td0cJL97757fX0psrMSULqwmfSvmasRUg3@vger.kernel.org
X-Gm-Message-State: AOJu0YwUaSBskZaBTINciMa0lLUMMSUP7fvk4N6NEL7Er0Canxj7h6GH
	qZEH9aPtC+kmgvO95xKIBxIQt6B5M3mwoYejcsNdERRNd70v48pv55Kw034/YBw=
X-Gm-Gg: ASbGncsy0JKaaejw7Awb6LZUEvxmOMV3pdHNGxh45L6LCP/blEo6WxDi7oVr6bSKgvQ
	VeqDKXWNIB/EU4Q/IhJC2S/H0zSipBLSVdDjWS3DVXIU2nfvLUELO7BD7X9YrpfDuLOJiMrQUlU
	a5P7cfDrIkuxgKz6zXN3jzTpPN48pZqw4bEuqbUk5+B/Gwc9zERHy+EbiPGG90XMaiZ5js4mZg8
	WVRvHmXxoz0HKmFTNSeJyqt70g428PRDyReWlVXNVvgMAo44LdMCnEXkvMVSjADrfGW5ku2bKAN
	mZsCiitnP0MqXDvDiP0sbNN2nHkVeCieGZT2S6GrMlA2ZgeNXubdGNnV3TZqk5SbTZk=
X-Google-Smtp-Source: AGHT+IEfHpSebUI54bc+vC2NBwLKUwK5koKIKhtVUi+WtfeB3o+yNTarMcSG1ESYsxHkheQAyV7j4Q==
X-Received: by 2002:a05:6a20:c6c1:b0:1e1:f281:8d36 with SMTP id adf61e73a8af0-1ee5c73fec1mr1195231637.10.1739307385181;
        Tue, 11 Feb 2025 12:56:25 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-730aad5535fsm2949623b3a.51.2025.02.11.12.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 12:56:24 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1thxIs-00000000133-0J1Y;
	Wed, 12 Feb 2025 07:56:22 +1100
Date: Wed, 12 Feb 2025 07:56:22 +1100
From: Dave Chinner <david@fromorbit.com>
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Matt Harvey <mharvey@jumptrading.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH v4] fuse: add new function to invalidate cache for all
 inodes
Message-ID: <Z6u5dumvZHf_BDHM@dread.disaster.area>
References: <20250211092604.15160-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211092604.15160-1-luis@igalia.com>

[ FWIW: if the commit message directly references someone else's
related (and somewhat relevant) work, please directly CC those
people on the patch(set). I only noticed this by chance, not because
I read every FUSE related patch that goes by me. ]

On Tue, Feb 11, 2025 at 09:26:04AM +0000, Luis Henriques wrote:
> Currently userspace is able to notify the kernel to invalidate the cache
> for an inode.  This means that, if all the inodes in a filesystem need to
> be invalidated, then userspace needs to iterate through all of them and do
> this kernel notification separately.
> 
> This patch adds a new option that allows userspace to invalidate all the
> inodes with a single notification operation.  In addition to invalidate
> all the inodes, it also shrinks the sb dcache.

That, IMO, seems like a bit naive - we generally don't allow user
controlled denial of service vectors to be added to the kernel. i.e.
this is the equivalent of allowing FUSE fs specific 'echo 1 >
/proc/sys/vm/drop_caches' via some fuse specific UAPI. We only allow
root access to /proc/sys/vm/drop_caches because it can otherwise be
easily abused to cause system wide performance issues.

It also strikes me as a somewhat dangerous precendent - invalidating
random VFS caches through user APIs hidden deep in random fs
implementations makes for poor visibility and difficult maintenance
of VFS level functionality...

> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
> * Changes since v3
> - Added comments to clarify semantic changes in fuse_reverse_inval_inode()
>   when called with FUSE_INVAL_ALL_INODES (suggested by Bernd).
> - Added comments to inodes iteration loop to clarify __iget/iput usage
>   (suggested by Joanne)
> - Dropped get_fuse_mount() call -- fuse_mount can be obtained from
>   fuse_ilookup() directly (suggested by Joanne)
> 
> (Also dropped the RFC from the subject.)
> 
> * Changes since v2
> - Use the new helper from fuse_reverse_inval_inode(), as suggested by Bernd.
> - Also updated patch description as per checkpatch.pl suggestion.
> 
> * Changes since v1
> As suggested by Bernd, this patch v2 simply adds an helper function that
> will make it easier to replace most of it's code by a call to function
> super_iter_inodes() when Dave Chinner's patch[1] eventually gets merged.
> 
> [1] https://lore.kernel.org/r/20241002014017.3801899-3-david@fromorbit.com

That doesn't make the functionality any more palatable.

Those iterators are the first step in removing the VFS inode list
and only maintaining it in filesystems that actually need this
functionality. We want this list to go away because maintaining it
is a general VFS cache scalability limitation.

i.e. if a filesystem has internal functionality that requires
iterating all instantiated inodes, the filesystem itself should
maintain that list in the most efficient manner for the filesystem's
iteration requirements not rely on the VFS to maintain this
information for it.

That's the point of the iterator methods the above patchset adds -
it allows the filesystem to provide the VFS with a method for
iterating all inodes in the filesystem whilst the transition period
where we rework the inode cache structure (i.e. per-sb hash tables
for inode lookup, inode LRU caching goes away, etc). Once that
rework gets done, there won't be a VFS inode cache to iterate.....

>  fs/fuse/inode.c           | 83 +++++++++++++++++++++++++++++++++++----
>  include/uapi/linux/fuse.h |  3 ++
>  2 files changed, 79 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index e9db2cb8c150..5aa49856731a 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -547,25 +547,94 @@ struct inode *fuse_ilookup(struct fuse_conn *fc, u64 nodeid,
>  	return NULL;
>  }
>  
> +static void inval_single_inode(struct inode *inode, struct fuse_conn *fc)
> +{
> +	struct fuse_inode *fi;
> +
> +	fi = get_fuse_inode(inode);
> +	spin_lock(&fi->lock);
> +	fi->attr_version = atomic64_inc_return(&fc->attr_version);
> +	spin_unlock(&fi->lock);
> +	fuse_invalidate_attr(inode);
> +	forget_all_cached_acls(inode);
> +}
> +
> +static int fuse_reverse_inval_all(struct fuse_conn *fc)
> +{
> +	struct fuse_mount *fm;
> +	struct super_block *sb;
> +	struct inode *inode, *old_inode = NULL;
> +
> +	inode = fuse_ilookup(fc, FUSE_ROOT_ID, &fm);
> +	if (!inode || !fm)
> +		return -ENOENT;
> +
> +	iput(inode);
> +	sb = fm->sb;
> +
> +	spin_lock(&sb->s_inode_list_lock);
> +	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> +		spin_lock(&inode->i_lock);
> +		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
> +		    !atomic_read(&inode->i_count)) {
> +			spin_unlock(&inode->i_lock);
> +			continue;
> +		}

This skips every inode that is unreferenced and cached on the
LRU. i.e. it only invalidates inodes that have a current reference
(e.g. dentry pins it, has an open file, etc).

What's the point of only invalidating actively referenced inodes?

> +		/*
> +		 * This __iget()/iput() dance is required so that we can release
> +		 * the sb lock and continue the iteration on the previous
> +		 * inode.  If we don't keep a ref to the old inode it could have
> +		 * disappear.  This way we can safely call cond_resched() when
> +		 * there's a huge amount of inodes to iterate.
> +		 */

If there's a huge amount of inodes to iterate, then most of them are
going to be on the LRU and unreferenced, so this code won't even get
here to be able to run cond_resched().

> +		__iget(inode);
> +		spin_unlock(&inode->i_lock);
> +		spin_unlock(&sb->s_inode_list_lock);
> +		iput(old_inode);
> +
> +		inval_single_inode(inode, fc);
> +
> +		old_inode = inode;
> +		cond_resched();
> +		spin_lock(&sb->s_inode_list_lock);
> +	}
> +	spin_unlock(&sb->s_inode_list_lock);
> +	iput(old_inode);
> +
> +	shrink_dcache_sb(sb);

Why drop all the referenced inodes held by the dentry cache -after-
inode invalidation? Doesn't this mean that racing operations are
going to see a valid dentries backed by an invalidated inode?  Why
aren't the dentries pruned from the cache first, and new lookups
blocked until the invalidation completes?

I'm left to ponder why the invalidation isn't simply:

	/* Remove all possible active references to cached inodes */
	shrink_dcache_sb();

	/* Remove all unreferenced inodes from cache */
	invalidate_inodes();

Which will result in far more of the inode cache for the filesystem
being invalidated than the above code....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

