Return-Path: <linux-fsdevel+bounces-41208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54331A2C53F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 15:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499603A94C2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 14:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1845723ED7E;
	Fri,  7 Feb 2025 14:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="znQjY5yR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ImJmBvux"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC69E23ED6B;
	Fri,  7 Feb 2025 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938564; cv=none; b=feH7B6/WpBs00XK8NxqJBgdoRSvYVhVsaQNwn8eEXjKQI7n3wkrSB3w326b34bk2dJAsLmCvEB4jvRLTe9Fn6YuhzNgyxrtm+/wQuuvQQjfEW1kvlFUx86ZrA5GQNtMnRBnTEGlkOvnAcM4UUz2qYQBET2Ze5K1hRQ4KYogO7k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938564; c=relaxed/simple;
	bh=S/DygZOpDtNGqOx0aRmkAnkflZnVc56zxPTZ31tUjpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h4ONRu/eRGwmdU7vNbe3ijRe3LSqncMy0dqzedEYEHAHDM3otAdsB/usv0O3RmOaFoLRSedH5Sb6O+x0K9FnRGWDf3v+8zt8yBCIyzjoA7wj8tzAx1M2bahCAQabzEGv86fJ/bzCypcmnrHGkDSREa7lPLqM+ihfjo9YeCp014I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=znQjY5yR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ImJmBvux; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id AFAAB11401B2;
	Fri,  7 Feb 2025 09:29:16 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 07 Feb 2025 09:29:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738938556;
	 x=1739024956; bh=3m3iqTfqwQmo5uXuOEtMpVp7gON0HdH2epgkHbk+nTs=; b=
	znQjY5yRafAbGuiBuhG5TFYS2Qm/XJsgS6wicrG5b7LILkxBGLSWsoBDk46JQc7S
	Mv8rZysq5Apz6ngZqIZXPxtmV8cPOa6hpYfM42dxULcaIPFPnC93Dq0sB6mFqa/w
	CSpBcK3mAh7B1Pqhm79BmZP3Frb2cIuXpSZDFwRJ8/i/53sqyuupvqf+fbIXQ8BU
	oQVs2PwBN+BKs2S630RpS1a5F4KhaSgAXAzo/bBtm0fe22Jq1iEyvAstnyhSfbRO
	GchPUTjmkMuHGEE6Kx+sbkPYIJhCw5PREMqRdXlocGkHMGkDxpXSqTu8zIaqcg9N
	r4Axa9BIZfg+YabXbW0Paw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738938556; x=
	1739024956; bh=3m3iqTfqwQmo5uXuOEtMpVp7gON0HdH2epgkHbk+nTs=; b=I
	mJmBvuxjAY474RI1qirGAwwlr7tHjCV50mU6lcrtdhLlXC6qrl1cULzEAlIj0FCd
	Nzsqp7FysnttgW6q9M2gvIhWuDAInbdg0k1Wj1tYNpL3jgXPuNpzWkiJuCqWVY1a
	SNjV4j+fBaQ6WBqafsaLBuIlrJk6cQKs3bcs8P0euRTRBETvxzWv3T+EhuZ+I0wz
	kKbsy9EI154k9qDMtGlFZWXVcHULmCY6pQhdt7oO6O9YQFBgXo+2JqyQXWljuj+1
	WvGTw5CxYspqPPWNDeD6LPNPfDT2XwbnRQSkf2qkxhEX/aP7qctCoJ1+3rnX8nib
	5Iy97yTWyYdMVv04iR1vw==
X-ME-Sender: <xms:uximZ1Z_ddCl05JBXx6Rahku3s340Dr_SN86yXhNLTP4NsAz4xy5Yw>
    <xme:uximZ8aXrJF3C-79lttKncNu9Fy_VmhdCryX8cijR2QjaXjEyyYoAYqrDGuciV3Ja
    I4qf7PO-CEiuzHF>
X-ME-Received: <xmr:uximZ3_bwKyBC6DWQ1jNjfSJ2voC_WkpqM5hTnx5N3Numvw9dCTgzbQR80VnteC6RgApAPbDvC4bKd-NyD9kH09VsQlyGA6ZiT0esYOcF5L87CYithIZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugessghssggvrh
    hnugdrtghomheqnecuggftrfgrthhtvghrnhepjefgleejueffhefhueekvdduhfetteeh
    tdehfeejhfevudethefhtdetvdekkeevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghr
    nhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehluhhishesihhgrghlihgrrdgtohhmpdhrtghpthhtohep
    mhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshguvg
    hvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgv
    rhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhhrghrvhgvhi
    esjhhumhhpthhrrgguihhnghdrtghomhdprhgtphhtthhopegurghvihgusehfrhhomhho
    rhgsihhtrdgtohhm
X-ME-Proxy: <xmx:uximZzr7SJMjc5VMBEc5i5fobvwdWl7ndOuGiBKihdVIOHdk-O-RbA>
    <xmx:uximZwrYhGl_MvuhqvfI7eekxyAv4tFz7bu9Nupo8N19iqm_m3APlQ>
    <xmx:uximZ5SUx53l8tEkKGSc_3JnyP8FB7hJ35jwxPf7Qx0cgtfbDmTKBA>
    <xmx:uximZ4rMhECAseuxVLRjp3If0UYzoZJVY5ciBV2tRsaIV8o6H-6RLA>
    <xmx:vBimZxdmOXe2HGzBcEu6OwEHZGDpwh1DBjyzwaAegphGTyA8exdr6tpi>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 09:29:14 -0500 (EST)
Message-ID: <d3ee362c-accf-4ad9-99a6-5834b1c0b438@bsbernd.com>
Date: Fri, 7 Feb 2025 15:29:13 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fuse: add new function to invalidate cache for all
 inodes
To: Luis Henriques <luis@igalia.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matt Harvey <mharvey@jumptrading.com>, Dave Chinner <david@fromorbit.com>
References: <20250115163253.8402-1-luis@igalia.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250115163253.8402-1-luis@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/15/25 17:32, Luis Henriques wrote:
> Currently userspace is able to notify the kernel to invalidate the cache
> for an inode.  This means that, if all the inodes in a filesystem need to
> be invalidated, then userspace needs to iterate through all of them and do
> this kernel notification separately.
> 
> This patch adds a new option that allows userspace to invalidate all the
> inodes with a single notification operation.  In addition to invalidate all
> the inodes, it also shrinks the superblock dcache.
> 
> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
> Just an additional note that this patch could eventually be simplified if
> Dave Chinner patch to iterate through the superblock inodes[1] is merged.
> 
> [1] https://lore.kernel.org/r/20241002014017.3801899-3-david@fromorbit.com
> 
>  fs/fuse/inode.c           | 53 +++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/fuse.h |  3 +++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 3ce4f4e81d09..1fd9a5f303da 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -546,6 +546,56 @@ struct inode *fuse_ilookup(struct fuse_conn *fc, u64 nodeid,
>  	return NULL;
>  }
>  
> +static int fuse_reverse_inval_all(struct fuse_conn *fc)
> +{
> +	struct fuse_mount *fm;
> +	struct super_block *sb;
> +	struct inode *inode, *old_inode = NULL;
> +	struct fuse_inode *fi;
> +
> +	inode = fuse_ilookup(fc, FUSE_ROOT_ID, NULL);
> +	if (!inode)
> +		return -ENOENT;
> +
> +	fm = get_fuse_mount(inode);
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
> +			spin_unlock(&inode->i_lock);
> +			continue;
> +		}
> +
> +		__iget(inode);
> +		spin_unlock(&inode->i_lock);
> +		spin_unlock(&sb->s_inode_list_lock);
> +		iput(old_inode);
> +
> +		fi = get_fuse_inode(inode);
> +		spin_lock(&fi->lock);
> +		fi->attr_version = atomic64_inc_return(&fm->fc->attr_version);
> +		spin_unlock(&fi->lock);
> +		fuse_invalidate_attr(inode);
> +		forget_all_cached_acls(inode);
> +
> +		old_inode = inode;
> +		cond_resched();
> +		spin_lock(&sb->s_inode_list_lock);
> +	}
> +	spin_unlock(&sb->s_inode_list_lock);
> +	iput(old_inode);
> +
> +	shrink_dcache_sb(sb);
> +
> +	return 0;
> +}

Just a suggestion, assuming Daves patch gets merged, maybe you coud move
the actual action into into a sub function? Makes it better visible
what is actually does and would then make it easier to move the iteration
part to the generic approach?
Alternatively, maybe updates Daves patch and add fuse on top of it? Dave?


Thanks,
Bernd



