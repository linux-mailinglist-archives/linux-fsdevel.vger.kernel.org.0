Return-Path: <linux-fsdevel+bounces-41444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA078A2F8B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 20:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C259163AA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 19:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE1625742A;
	Mon, 10 Feb 2025 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyK11Soo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF8525E467;
	Mon, 10 Feb 2025 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739215992; cv=none; b=SbxOoEZFjZi+lR+6e8aN3dkgpYFOFD2IOmSfNLr5ulFsrv+WMcY1Vh13B6Mw7998tTLBEb+MrHfP83/tkXQf3Ztkzcllv67UM6j4NGlqpTnXjD9T6gUv+pyYblQdUJmw5ix5nX3Z2kNpLTErTKfgpaIG9OoQq0T7Lfai+oRJVQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739215992; c=relaxed/simple;
	bh=8km8XhwMDvK2M6l4lIB5qPBKONKci+e9cpBm6M/E+Fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9aYcJBLToSkPsARoAoa2RKMgoeqQeaIy/8cToYc37/jI0naOw7JoYa+NNaG8Jtan84yCIr30ibD6CUc2qv09oFYy82bYMG9DMdZE2ydynjJjNxYAJS9sAbai4jE37OI4BGpceemtGPXWK5OMBKPppj5csZoC91ELC+BtqVxrCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyK11Soo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f6a47d617so38607735ad.2;
        Mon, 10 Feb 2025 11:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739215990; x=1739820790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OkHCUgGiFi9BQPHsbuMPBzfuVrdJEVB05botzvdyISM=;
        b=fyK11SoornncpNMrIvxb1J/0r3sxbPA/9kOZA12yfLQixvo+1/oDezTdSOndbwDjQF
         1ViHWsFBobcBYCUpEKwTxvsudKwaNwLNPfulGvSv3LW6ClZ1b8dfb88KYf0NnknKm0lY
         BqgixtmCKxIgqsMovBLsL40qcFAkTXgBxNi0YEGXq+tifAsqVFv137uBsK4M7zz8HuzD
         nvqC2T8ptQLQRWM96Uii7PO7bLfxDAkFpNX1RfHdnF1SrYBo0mdtVS7HgIzOYgIxI0V1
         WHMij8gnPe6Pi2wuu745V+xSWg0hCBJhmBZiPpubmL6P6bJ2QZeD8X+j6IaKYo9mfv5t
         kMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739215990; x=1739820790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OkHCUgGiFi9BQPHsbuMPBzfuVrdJEVB05botzvdyISM=;
        b=h8JKuzpI8s99ZNGyfs4G3oZ0gENWa/FR3GelGP1qyD+oOTUsOlKpys5X1wsPY8P0z6
         Eid7pTgeGKsg76CKcmd48NHgK8/YXhO16ISj35Z8C6eSkw/ySqF8jVOELkl8Wc/27Hgo
         WlTEp6JN0z3nbwdFXCsi6mZfRHkPfVMwNfdSDEDiMqfmz4zU0RfYtJ4uGA0H/0cpdMVx
         Fw7ihjIxER+9Eia7dwN6916ELqwfw27mIXZcFADsJ7/FseU1K6mC+HCjojhdrN+vmAp1
         h7dYyXkf+6LuhIsZvQwxmIcaw+y5xkpvbZwqXG0D7lF8kNXshT2cHLriQo7y8Iik8OJW
         q8iA==
X-Forwarded-Encrypted: i=1; AJvYcCVr+GivE7nQSAUiQ0ExZQkvE0SeHtpg996tpXSHddiOJ4uxuM1T/DCkL2h8coyHxmo1kJfolb6uX1WOTdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGgKkgEOq4SPLdksaoR4/cCSovw5xf+S3HSSXUqScCK2I7XV4J
	pzdKAAUVaJ36MKhI++FIDohFkQiObObcfqkSQyfUNs858Qlm4rNe
X-Gm-Gg: ASbGncuFte8jXM+fLzwtf5826W+Zppgtlr02hjxKI7AWG9dBVks/CGONPwUrcSvNmU1
	r6muuMyXV2o5kNBnvgpfzSCQNTO1JFZ0dmoYHJDs7b6dWatHXIlhTrBzOn21d3GIqGsKS9YSt42
	HH7DyOhLQES1lwEP64mLH01hftQOc/wsSfTv/AUgDXXn+TopMAWAw/RDFZH5bJTfkAVUc1wlU7G
	5M/G1x5vmo+tt3DueMX+xIdL++kPi8Xfhb3En91mMA21dtCpTktJhoMasYjzARIBSdEuSs0mZ7S
	emAuvbNjUuVlp5thAedQsp6uuYMH/jtwxCHYjmshqH6Nj5/6HCsT83qjquOopkjR
X-Google-Smtp-Source: AGHT+IFIKYUzs2a8ienM1BT2Xqr7USxdvD4IXfwibhCdw8R2QgSABCw5r/76iCZntjzuQQ586KNTQw==
X-Received: by 2002:a05:6a00:1953:b0:728:e2cc:bfd6 with SMTP id d2e1a72fcca58-7305d4ec7d8mr24256622b3a.18.1739215990096;
        Mon, 10 Feb 2025 11:33:10 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:18d4:f3a7:5d10:1620? ([2620:10d:c090:500::5:417b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7307c5b3a99sm4115117b3a.54.2025.02.10.11.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 11:33:09 -0800 (PST)
Message-ID: <2b65778e-7d26-4168-9346-6c1e01de350b@gmail.com>
Date: Mon, 10 Feb 2025 11:33:07 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3] fuse: add new function to invalidate cache for all
 inodes
To: Luis Henriques <luis@igalia.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matt Harvey <mharvey@jumptrading.com>, Bernd Schubert <bschubert@ddn.com>
References: <20250210143351.31119-1-luis@igalia.com>
Content-Language: en-US
From: Joanne Koong <joannelkoong@gmail.com>
In-Reply-To: <20250210143351.31119-1-luis@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/10/25 6:33 AM, Luis Henriques wrote:
> Currently userspace is able to notify the kernel to invalidate the cache
> for an inode.  This means that, if all the inodes in a filesystem need to
> be invalidated, then userspace needs to iterate through all of them and do
> this kernel notification separately.
> 
> This patch adds a new option that allows userspace to invalidate all the
> inodes with a single notification operation.  In addition to invalidate all
> the inodes, it also shrinks the sb dcache.
> 
> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
> * Changes since v2
> Use the new helper from fuse_reverse_inval_inode(), as suggested by Bernd.
> 
> Also updated patch description as per checkpatch.pl suggestion.
> 
> * Changes since v1
> As suggested by Bernd, this patch v2 simply adds an helper function that
> will make it easier to replace most of it's code by a call to function
> super_iter_inodes() when Dave Chinner's patch[1] eventually gets merged.
> 
> [1] https://lore.kernel.org/r/20241002014017.3801899-3-david@fromorbit.com
> 
>   fs/fuse/inode.c           | 67 +++++++++++++++++++++++++++++++++++----
>   include/uapi/linux/fuse.h |  3 ++
>   2 files changed, 63 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index e9db2cb8c150..45b9fbb54d42 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -547,25 +547,78 @@ struct inode *fuse_ilookup(struct fuse_conn *fc, u64 nodeid,
>   	return NULL;
>   }
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
> +	inode = fuse_ilookup(fc, FUSE_ROOT_ID, NULL);
> +	if (!inode)
> +		return -ENOENT;
> +
> +	fm = get_fuse_mount(inode);

I think if you pass in &fm as the 3rd arg to fuse_ilookup(), it'll pass 
back the fuse mount and we won't need get_fuse_mount().

> +	iput(inode);
> +	if (!fm)
> +		return -ENOENT;
> +	sb = fm->sb;
> +
> +	spin_lock(&sb->s_inode_list_lock);
> +	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> +		spin_lock(&inode->i_lock);
> +		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
> +		    !atomic_read(&inode->i_count)) {

Will inode->i_count ever be 0? AFAIU, inode->i_count tracks the inode 
refcount, so if this is 0, doesn't this mean it wouldn't be on the 
sb->s_inodes list?

> +			spin_unlock(&inode->i_lock);
> +			continue;
> +		}
> +
> +		__iget(inode);
> +		spin_unlock(&inode->i_lock);
> +		spin_unlock(&sb->s_inode_list_lock);

Maybe worth adding a comment here since there can be inodes added after 
the s_inode_list_lock is dropped and before it's acquired again that 
when inodes get added to the head of sb->s_inodes, it's always for I_NEW 
inodes.

> +		iput(old_inode);

Maybe a dumb question but why is old_inode needed? Why can't iput()just 
be called right after inval_single_inode()?

> +
> +		inval_single_inode(inode, fc);
> +
> +		old_inode = inode;
> +		cond_resched();

Could you explain why a cond_resched() is needed here?

> +		spin_lock(&sb->s_inode_list_lock);
> +	}
> +	spin_unlock(&sb->s_inode_list_lock);
> +	iput(old_inode);
> +
> +	shrink_dcache_sb(sb);
> +
> +	return 0;
> +}
> +

Thanks,
Joanne

>   int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
>   			     loff_t offset, loff_t len)
>   {
> -	struct fuse_inode *fi;
>   	struct inode *inode;
>   	pgoff_t pg_start;
>   	pgoff_t pg_end;
>   
> +	if (nodeid == FUSE_INVAL_ALL_INODES)
> +		return fuse_reverse_inval_all(fc);
> +
>   	inode = fuse_ilookup(fc, nodeid, NULL);
>   	if (!inode)
>   		return -ENOENT;
>   
> -	fi = get_fuse_inode(inode);
> -	spin_lock(&fi->lock);
> -	fi->attr_version = atomic64_inc_return(&fc->attr_version);
> -	spin_unlock(&fi->lock);
> +	inval_single_inode(inode, fc);
>   
> -	fuse_invalidate_attr(inode);
> -	forget_all_cached_acls(inode);
>   	if (offset >= 0) {
>   		pg_start = offset >> PAGE_SHIFT;
>   		if (len <= 0)
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 5e0eb41d967e..e5852b63f99f 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -669,6 +669,9 @@ enum fuse_notify_code {
>   	FUSE_NOTIFY_CODE_MAX,
>   };
>   
> +/* The nodeid to request to invalidate all inodes */
> +#define FUSE_INVAL_ALL_INODES 0
> +
>   /* The read buffer is required to be at least 8k, but may be much larger */
>   #define FUSE_MIN_READ_BUFFER 8192
>   
> 


