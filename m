Return-Path: <linux-fsdevel+bounces-71297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78723CBCCC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 08:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C6AC301FC2D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 07:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61983328B43;
	Mon, 15 Dec 2025 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="keJgcqC4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166FE313E1A
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 07:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765784323; cv=none; b=jCfOA/nXlZjdanqCMl4dce5iC79gesQWi9Ny0KjOVy24SrUwtWmwuJZLzUwldAH6k4MEUfFs8gUuXMaGs/RBb+h/ZT0BJVaQmLJyR5IOoM17y+kiMObrD7f+wffzWYjs6QnGIfR+zfLFDc0LoauVcJx7FIyAV1M4tWBBVtjF+00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765784323; c=relaxed/simple;
	bh=oRAU2UVJTWLWreJ30hI/iFaneEyhTmkER6fCAR/qC8I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JW5o+3ePUDfEH4OSho3VEEoyWcyf4BzXJtUtHtVupWjKpnBEK19d85Fs1vsdDXLwfcZuJpoe4EyNjuFmatOf5wAmNvnEtK+0GobH0ASHVW2HVPOY1sBaT5eMZqVTM1jiE2Ubpcr428kgRTAQKh7eD8T6p04Bkh2m6RENSC4k93k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=keJgcqC4; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6446c2bbfe3so2807518d50.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Dec 2025 23:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765784321; x=1766389121; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iIeKRKKKCnzupDfCwJqFB1013cUpwf+GNDgK+GELOro=;
        b=keJgcqC4cYWkbkA9/4zfMD/V/G/FhMarzl4JzUClpmV8z19jfRChNU4mrJndhvEO/m
         4nauPqFvyhLhMrtTqvlgYkedGLS9gUAVZL81rXOnq+0FmSQbBU6U5cSEqm7fSC3ApMhE
         cqmkKPpAbMKtW5cS2+TI5jvCAFDKgU+ZAwI89+0HRljyk0Z4AO3vqMv8heHs1dCpdXdw
         w5/VIcXCa1OKBLHTjX3iyLxVanBZYxd6bJZltDeyrxhrnXqxy4KeiYJAPdotIkPrE6oG
         C+sgyDMMNzeVL1nPn/3Fu4BhUNiKVzdJAKt6DLdlW+r7OfsXbeBIIce8K86vRmwWNYeK
         iApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765784321; x=1766389121;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iIeKRKKKCnzupDfCwJqFB1013cUpwf+GNDgK+GELOro=;
        b=oEvz9Wj412zGGa/2Pmw2NMY6dMfVq5iSMrqy8N8E2Zlhw1JrWGrzYiXnvfTrwdoS5u
         GDOUcJZYrWYyvaM2hUlMQbSU5g8+sUW4Ty01vfw7tpqBXjPZUM/nHqB9zBcvDpMRCmFP
         C5bjUHtyEJavwJVi6X97TRp/WrxfdsN4YSuEYApSzG/FYk8mwIvXdGU2sTkkg1DL9qop
         m2/LJRM74yl+I6zhG1VSbH/wCDYp6Q4WdGg/sYOfJVCBzCBtYXn6W9vZqqS/hz/C6rKG
         x/m99sNnuRK+SGKuNy/z5EZE4Jw4ikNQyF0MQgIRC+pGrsWRDbR3sGhykwGziNpavRBk
         mNfA==
X-Forwarded-Encrypted: i=1; AJvYcCW5fI5vU4tGKbWieHn1TquppYRFfCXc+z7+0pdHhPpzHl2ZXGblwOkL5Doq7Ex5z/mwus8fQVav8+jLXBAb@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwo0bCcrIkXB8qkKAe6qGPL4Apa2GvAv9nu09i4O01nH2C24NV
	gP/eMpvEIiSrVbfceki2Fov0sxShjJJ9hRfPWgSDM0KFrbVKMv/hMtTPbKFGo9PP3w==
X-Gm-Gg: AY/fxX64Ue8o10/gVqbfkiHEPHaerhZuj7FBWbp8x+By3V5/OL/AJA5cMQm0NQcph/1
	xiuUgt31ESDanaw6p+3obVH3CbRdJqRtOiRwVguodIWMPnnhbLgpDMJrXortXcTNsxxiS+Hk0Wr
	lhdMYKZk84DMmeTKL2f7OY2YOhxd5Kro3wAIN3ioU8oGXycu0WmBg87V5ZaZnSOCM472S4ISnvq
	NIyF2Qtaol5l3nvttgk1uuZK0oInLbAIIYgn6BLlveD7DwQVcyLzc3JI2yrszUaiCb/C9Don27l
	v8RuJMjpDCsZOfCBjJdHUdTa1rL9krpsPZHx4qMqGnMtXlZTP0IokJwvXQEFHYbtxyd+/CsfXTp
	uAn5UzQ4zsr2/8gFYjXLbOczZzobCwNwBmGv83pD4siOR3wbgGqrrFQhFAXDoOih3HF3Jnn6EgJ
	i//QI0YIi4xtA4DTCFZrx0a/40fCmes8CmAu8bHyOHydm10jgKW4zk3NmamIraBpLAg5Rw2VM=
X-Google-Smtp-Source: AGHT+IGWwU3CR/BLGGM37Mj6ED/FrmrwwoSCDyBwGpC4O4RY5GWa1NaXFkGRwTEcuL+iHjjMa3Jb3A==
X-Received: by 2002:a05:690e:d8d:b0:641:f5bc:68d3 with SMTP id 956f58d0204a3-645556680dbmr6576002d50.80.1765784320678;
        Sun, 14 Dec 2025 23:38:40 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64477dc673asm6105794d50.25.2025.12.14.23.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 23:38:39 -0800 (PST)
Date: Sun, 14 Dec 2025 23:38:28 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Al Viro <viro@zeniv.linux.org.uk>
cc: Hugh Dickins <hughd@google.com>, Miklos Szeredi <miklos@szeredi.hu>, 
    Christian Brauner <brauner@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC][PATCH 2/2] shmem: fix recovery on rename failures
In-Reply-To: <20251214033049.GB460900@ZenIV>
Message-ID: <8a925e3f-bd27-ac32-841a-a79690d971d7@google.com>
References: <47e9d03c-7a50-2c7d-247d-36f95a5329ed@google.com> <20251212050225.GD1712166@ZenIV> <20251212053452.GE1712166@ZenIV> <8ab63110-38b2-2188-91c5-909addfc9b23@google.com> <20251212063026.GF1712166@ZenIV> <2a102c6d-82d9-2751-cd31-c836b5c739b7@google.com>
 <bed18e79-ab2b-2a8f-0c32-77e6d27e2a05@google.com> <20251213072241.GH1712166@ZenIV> <20251214032734.GL1712166@ZenIV> <20251214033049.GB460900@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 14 Dec 2025, Al Viro wrote:

> maple_tree insertions can fail if we are seriously short on memory;
> simple_offset_rename() does not recover well if it runs into that.
> The same goes for simple_offset_rename_exchange().
> 
> Moreover, shmem_whiteout() expects that if it succeeds, the caller will
> progress to d_move(), i.e. that shmem_rename2() won't fail past the
> successful call of shmem_whiteout().
> 
> Not hard to fix, fortunately - mtree_store() can't fail if the index we
> are trying to store into is already present in the tree as a singleton.
> 
> For simple_offset_rename_exchange() that's enough - we just need to be
> careful about the order of operations.
> 
> For simple_offset_rename() solution is to preinsert the target into the
> tree for new_dir; the rest can be done without any potentially failing
> operations.
> 
> That preinsertion has to be done in shmem_rename2() rather than in
> simple_offset_rename() itself - otherwise we'd need to deal with the
> possibility of failure after successful shmem_whiteout().
> 
> Fixes: a2e459555c5f ("shmem: stable directory offsets")
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Well, what you say above, and what you've done below, make sense to me;
and neither I nor xfstests noticed anything wrong (aside from one
trivium - I'd prefer "bool had_offset = false" to "int ...";
maybe placed one line up to look prettier).

But please don't expect proper engagement from me on this one,
it's above my head, and I'll trust you and Chuck on it.

Thanks,
Hugh

> ---
>  fs/libfs.c         | 50 +++++++++++++++++++---------------------------
>  include/linux/fs.h |  2 +-
>  mm/shmem.c         | 18 ++++++++++++-----
>  3 files changed, 35 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 9264523be85c..591eb649ebba 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -346,22 +346,22 @@ void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry)
>   * User space expects the directory offset value of the replaced
>   * (new) directory entry to be unchanged after a rename.
>   *
> - * Returns zero on success, a negative errno value on failure.
> + * Caller must have grabbed a slot for new_dentry in the maple_tree
> + * associated with new_dir, even if dentry is negative.
>   */
> -int simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
> -			 struct inode *new_dir, struct dentry *new_dentry)
> +void simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
> +			  struct inode *new_dir, struct dentry *new_dentry)
>  {
>  	struct offset_ctx *old_ctx = old_dir->i_op->get_offset_ctx(old_dir);
>  	struct offset_ctx *new_ctx = new_dir->i_op->get_offset_ctx(new_dir);
>  	long new_offset = dentry2offset(new_dentry);
>  
> -	simple_offset_remove(old_ctx, old_dentry);
> +	if (WARN_ON(!new_offset))
> +		return;
>  
> -	if (new_offset) {
> -		offset_set(new_dentry, 0);
> -		return simple_offset_replace(new_ctx, old_dentry, new_offset);
> -	}
> -	return simple_offset_add(new_ctx, old_dentry);
> +	simple_offset_remove(old_ctx, old_dentry);
> +	offset_set(new_dentry, 0);
> +	WARN_ON(simple_offset_replace(new_ctx, old_dentry, new_offset));
>  }
>  
>  /**
> @@ -388,31 +388,23 @@ int simple_offset_rename_exchange(struct inode *old_dir,
>  	long new_index = dentry2offset(new_dentry);
>  	int ret;
>  
> -	simple_offset_remove(old_ctx, old_dentry);
> -	simple_offset_remove(new_ctx, new_dentry);
> +	if (WARN_ON(!old_index || !new_index))
> +		return -EINVAL;
>  
> -	ret = simple_offset_replace(new_ctx, old_dentry, new_index);
> -	if (ret)
> -		goto out_restore;
> +	ret = mtree_store(&new_ctx->mt, new_index, old_dentry, GFP_KERNEL);
> +	if (WARN_ON(ret))
> +		return ret;
>  
> -	ret = simple_offset_replace(old_ctx, new_dentry, old_index);
> -	if (ret) {
> -		simple_offset_remove(new_ctx, old_dentry);
> -		goto out_restore;
> +	ret = mtree_store(&old_ctx->mt, old_index, new_dentry, GFP_KERNEL);
> +	if (WARN_ON(ret)) {
> +		mtree_store(&new_ctx->mt, new_index, new_dentry, GFP_KERNEL);
> +		return ret;
>  	}
>  
> -	ret = simple_rename_exchange(old_dir, old_dentry, new_dir, new_dentry);
> -	if (ret) {
> -		simple_offset_remove(new_ctx, old_dentry);
> -		simple_offset_remove(old_ctx, new_dentry);
> -		goto out_restore;
> -	}
> +	offset_set(old_dentry, new_index);
> +	offset_set(new_dentry, old_index);
> +	simple_rename_exchange(old_dir, old_dentry, new_dir, new_dentry);
>  	return 0;
> -
> -out_restore:
> -	(void)simple_offset_replace(old_ctx, old_dentry, old_index);
> -	(void)simple_offset_replace(new_ctx, new_dentry, new_index);
> -	return ret;
>  }
>  
>  /**
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 04ceeca12a0d..f5c9cf28c4dc 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3247,7 +3247,7 @@ struct offset_ctx {
>  void simple_offset_init(struct offset_ctx *octx);
>  int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry);
>  void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry);
> -int simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
> +void simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
>  			 struct inode *new_dir, struct dentry *new_dentry);
>  int simple_offset_rename_exchange(struct inode *old_dir,
>  				  struct dentry *old_dentry,
> diff --git a/mm/shmem.c b/mm/shmem.c
> index d3edc809e2e7..4232f8a39a43 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -4039,6 +4039,7 @@ static int shmem_rename2(struct mnt_idmap *idmap,
>  	struct inode *inode = d_inode(old_dentry);
>  	int they_are_dirs = S_ISDIR(inode->i_mode);
>  	int error;
> +	int had_offset = false;
>  
>  	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
>  		return -EINVAL;
> @@ -4050,16 +4051,23 @@ static int shmem_rename2(struct mnt_idmap *idmap,
>  	if (!simple_empty(new_dentry))
>  		return -ENOTEMPTY;
>  
> +	error = simple_offset_add(shmem_get_offset_ctx(new_dir), new_dentry);
> +	if (error == -EBUSY)
> +		had_offset = true;
> +	else if (unlikely(error))
> +		return error;
> +
>  	if (flags & RENAME_WHITEOUT) {
>  		error = shmem_whiteout(idmap, old_dir, old_dentry);
> -		if (error)
> +		if (error) {
> +			if (!had_offset)
> +				simple_offset_remove(shmem_get_offset_ctx(new_dir),
> +						     new_dentry);
>  			return error;
> +		}
>  	}
>  
> -	error = simple_offset_rename(old_dir, old_dentry, new_dir, new_dentry);
> -	if (error)
> -		return error;
> -
> +	simple_offset_rename(old_dir, old_dentry, new_dir, new_dentry);
>  	if (d_really_is_positive(new_dentry)) {
>  		(void) shmem_unlink(new_dir, new_dentry);
>  		if (they_are_dirs) {
> -- 
> 2.47.3

