Return-Path: <linux-fsdevel+bounces-63174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA91BB05A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 14:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7BE1946753
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 12:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292272EB5D5;
	Wed,  1 Oct 2025 12:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="UctqLRRU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AeoHIIsy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312782EAD09
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 12:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759321739; cv=none; b=Yf7ir3WVoiJJtwpD05NPh6MERd+tD4wynck+hBmyXoC3MMPZ0DyJQaZdbKYkKHOFw9wAJlxLWE+lNeT8eiv/i6fL3fWfnBlWymjLlpK0hTb53tLn1E20KEM4kMWU1v+dYZU6tLNa/1RDjGe7aWHneNdDGOQOjBpcGb8nlBWKHrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759321739; c=relaxed/simple;
	bh=+VLlpgyiXqEIOkkU2yUQPv7u2cILXPSJSq5zuTO5Hzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dYBRes5GUw7qu/A/5OkpGhulKfFVXKH6Q7fsQ29oGA29QJqmdWdkgyy7PYj3uUGZgE1lYHBNuM2OMSM8YjsZtgUNYy8mEdzNc2VlmAwDD6lsu1N5bQthW/n2DGYGm7vwXIPJBaH5YPLISXJlAsKf2wO6XNewJlhcBG/EoZmpJJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=UctqLRRU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AeoHIIsy; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 019B51400188;
	Wed,  1 Oct 2025 08:28:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 01 Oct 2025 08:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1759321734;
	 x=1759408134; bh=ISn4BAIpllb9BJmW814ASsvAeGeY8nF2JbrIMIFHfF8=; b=
	UctqLRRUS4pV7XmObdk6DtBMV+WYUNiFKPEFUHiSuoWihAgu1LgwwZoSXo1bZ21I
	Mld6bWCFJVkLLJoN0BYkd5jRzbO/vbtby97B4zDPkrXlvj1XZgLPCdI2K4g6mR6O
	XtspxYLJ5ZzTqWoxpR7UZeW6JcjcoB2q/6wH1zMlqhoe/YGHSQPDAdxczJZoaA5l
	MXjbJLVCB4uRcjPLa2Iw35kvu6ZrVg2BwXXssO4dOH89JL4HfVGe1y1WmQnvXNUv
	4NKxq6BTUFfsutXi2oDa1VHb6XjOvbYBigmrVipZsZOtEh5TRm9CxQ0QOpaWT3SC
	fEeEmXQOhxZZD3CXl2vwog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759321734; x=
	1759408134; bh=ISn4BAIpllb9BJmW814ASsvAeGeY8nF2JbrIMIFHfF8=; b=A
	eoHIIsy9D0hZe6PJ0ecC9W8jk6obDj89qsBqi2gNdXykkzeUxDb9K8sga94YhY+I
	z3PxBQkgobhIl/iOpHvuRTFy75/3ZFldm1uj/pHzytF8cULRV2S+fVtNSSTQyCGw
	gkwu+sJf/ph/cQn8HEg5jMCmeIgsuIeONVRIXhEoTnEWUNDyD47p/7YyFSI/5AV0
	WDmzI5g7Wu+0ng+SIgg6xdgREVNA+6VakNJedNxEQRpd/yY9nh0HChKBNefJrJ39
	4LFBP2u5ShgC29h/tRhxl0iZNdWDnOf+XLM7LtWjc4VTUTor5t88oejjQhXiOBYs
	Sn2WCvJdQxF8hYsqP++2Q==
X-ME-Sender: <xms:hh7daH3rJ7qAwKBUj_CR55yetOSlvGClM_i8s3gFNTZEMF-yAqy-zw>
    <xme:hh7daNFS_ADYzBoSWutd5g1BV9iSwp0nW3lSA_7OtIzjq_8QM9MdaF3Qa8JPYfwVG
    t40_pbyEwXabGQaSksEeQD4jqkYKDpthiZ4tLOrYyrL0BmdV3VO>
X-ME-Received: <xmr:hh7daM4WbSIwivbWgpxVS8uS6pZNy4-xxjauxDJEjewL6ICZUfM5it2LxJO21TgbsEDeXW9G6OeDT0n7Sp0b8SvPSqGAoL4LzQ05i7Uag272uJ1Mzecq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhephefhjeeujeelhedtheetfedvgfdtleffuedujefhheegudefvdfhheeuvedu
    ueegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhsiigvrhgvughisehrvgguhhgrthdrtghomhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhhihhgrrhhrihhssehnvhhiughirgdrtghomhdprhgtphhtthhope
    ihohgthhgvnhesuggunhdrtghomh
X-ME-Proxy: <xmx:hh7daLvX9y0d0STBg0-IMXKQ7nl-F3s4yMI7DG42fb7hHG0JKd-dBQ>
    <xmx:hh7daF4S_vUtlAomwbnEGx2itICbl3_r_o4NyLZf8UfE6j3uDcScQw>
    <xmx:hh7daOWT7ML20S6RdQGAgSwZD2IPV2TEEk7zOstPE0vW1n5WwJlo7w>
    <xmx:hh7daP_JoQAYJtqHAww8dfmB32ULLgTrZtiXqOzgfzsPBPN2cAzJLA>
    <xmx:hh7daBD8ks5hcVEvbJ-As9IoewP42uwRV5jabfXhXs_JYPW-2cb2LQ6S>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 08:28:53 -0400 (EDT)
Message-ID: <602c8ecc-d802-4a21-9295-8800f7a3cf11@bsbernd.com>
Date: Wed, 1 Oct 2025 14:28:52 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] fuse: add prune notification
To: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: Jim Harris <jiharris@nvidia.com>, Yong Ze Chen <yochen@ddn.com>
References: <20250902144148.716383-1-mszeredi@redhat.com>
 <20250902144148.716383-4-mszeredi@redhat.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250902144148.716383-4-mszeredi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Miklos,

I'm sorry for late review.

On 9/2/25 16:41, Miklos Szeredi wrote:
> Some fuse servers need to prune their caches, which can only be done if the
> kernel's own dentry/inode caches are pruned first to avoid dangling
> references.
> 
> Add FUSE_NOTIFY_PRUNE, which takes an array of node ID's to try and get rid
> of.  Inodes with active references are skipped.
> 
> A similar functionality is already provided by FUSE_NOTIFY_INVAL_ENTRY with
> the FUSE_EXPIRE_ONLY flag.  Differences in the interface are
> 
> FUSE_NOTIFY_INVAL_ENTRY:
> 
>   - can only prune one dentry
> 
>   - dentry is determined by parent ID and name
> 
>   - if inode has multiple aliases (cached hard links), then they would have
>     to be invalidated individually to be able to get rid of the inode
> 
> FUSE_NOTIFY_PRUNE:
> 
>   - can prune multiple inodes
> 
>   - inodes determined by their node ID
> 
>   - aliases are taken care of automatically


It actually solves another issue we had run into. FUSE_NOTIFY_INVAL_ENTRY takes 
the parent dir lock. Problem with the parent lock is our DLM and lock order.
I.e. kernel holds parent lock for some dir operation, calls into
fuse-server, which tries to acquires the DLM lock. DLM lock might
be taken already and is doing FUSE_NOTIFY_INVAL_ENTRY - deadlock through
the parent dir lock. We are running with an additional patch from Yong Ze,
which is still for single entries.


Thanks,
Bernd


> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/dev.c             | 39 +++++++++++++++++++++++++++++++++++++++
>  fs/fuse/fuse_i.h          |  6 ++++++
>  fs/fuse/inode.c           | 11 +++++++++++
>  include/uapi/linux/fuse.h |  8 ++++++++
>  4 files changed, 64 insertions(+)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 1258acee9704..4229b38546bb 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2034,6 +2034,42 @@ static int fuse_notify_inc_epoch(struct fuse_conn *fc)
>  	return 0;
>  }
>  
> +static int fuse_notify_prune(struct fuse_conn *fc, unsigned int size,
> +			     struct fuse_copy_state *cs)
> +{
> +	struct fuse_notify_prune_out outarg;
> +	const unsigned int batch = 512;
> +	u64 *nodeids __free(kfree) = kmalloc(sizeof(u64) * batch, GFP_KERNEL);
> +	unsigned int num, i;
> +	int err;
> +
> +	if (!nodeids)
> +		return -ENOMEM;
> +
> +	if (size < sizeof(outarg))
> +		return -EINVAL;
> +
> +	err = fuse_copy_one(cs, &outarg, sizeof(outarg));
> +	if (err)
> +		return err;
> +
> +	if (size - sizeof(outarg) != outarg.count * sizeof(u64))
> +		return -EINVAL;
> +
> +	for (; outarg.count; outarg.count -= num) {
> +		num = min(batch, outarg.count);
> +		err = fuse_copy_one(cs, nodeids, num * sizeof(u64));
> +		if (err)
> +			return err;
> +
> +		scoped_guard(rwsem_read, &fc->killsb) {
> +			for (i = 0; i < num; i++)
> +				fuse_try_prune_one_inode(fc, nodeids[i]);
> +		}
> +	}
> +	return 0;
> +}
> +
>  static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
>  		       unsigned int size, struct fuse_copy_state *cs)
>  {
> @@ -2065,6 +2101,9 @@ static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
>  	case FUSE_NOTIFY_INC_EPOCH:
>  		return fuse_notify_inc_epoch(fc);
>  
> +	case FUSE_NOTIFY_PRUNE:
> +		return fuse_notify_prune(fc, size, cs);
> +
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 233c6111f768..fb6604120b53 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1413,6 +1413,12 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
>  int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
>  			     u64 child_nodeid, struct qstr *name, u32 flags);
>  
> +/*
> + * Try to prune this inode.  If neither the inode itself nor dentries associated
> + * with this inode have any external reference, then the inode can be freed.
> + */
> +void fuse_try_prune_one_inode(struct fuse_conn *fc, u64 nodeid);
> +
>  int fuse_do_open(struct fuse_mount *fm, u64 nodeid, struct file *file,
>  		 bool isdir);
>  
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 5b7897bf7e45..a4d361b34d06 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -585,6 +585,17 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
>  	return 0;
>  }
>  
> +void fuse_try_prune_one_inode(struct fuse_conn *fc, u64 nodeid)
> +{
> +	struct inode *inode;
> +
> +	inode = fuse_ilookup(fc, nodeid,  NULL);
> +	if (!inode)
> +		return;
> +	d_prune_aliases(inode);
> +	iput(inode);

I also wonder if FUSE_NOTIFY_PRUNE shouldn't handle dir inodes and
call d_invalidate() to also prune child entries. 



Thanks,
Bernd

