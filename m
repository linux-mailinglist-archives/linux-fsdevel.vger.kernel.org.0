Return-Path: <linux-fsdevel+bounces-39311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A03B3A12904
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 17:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC33E7A34EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 16:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AD11D61BC;
	Wed, 15 Jan 2025 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="dmichuMg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QFl13wUf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929221D54E3;
	Wed, 15 Jan 2025 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736959422; cv=none; b=ildAXTqBGk5V8KlbMRj+0qJi4IdK2w6oVJFXXjB2EMf3cdp6MoIiHOUXcf6AXUUPLt/spys1C3aUI3cRUGRRuyxNfLcTm7Ohqx3TUUS9UP+ms9XWAD0GqMs7KeE923mIR+6oA6mLQwARsmC1aKxbXsb0BVNdX063SlEnWsn5PsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736959422; c=relaxed/simple;
	bh=gPvsX7xaUiJ1cUbv2pMvucPPwQXKSi8i1X4no7+xXcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKX8K9lhdhVr+Qx+KBDlW/cuIaBkmwzzrWahBGy+uYdvriKs7YtjNBuCVt7ILW8OkglVdypQLbv8nM8Q01GRFioD09WnUR3qKTvab/k2zihtr5sXrcIoeompisz/9l/1lvI/zdFtAy4hJdyEtce0vAyVCZkg40G3I0TUAezQic8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=dmichuMg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QFl13wUf; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8C30C2540072;
	Wed, 15 Jan 2025 11:43:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 15 Jan 2025 11:43:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736959418;
	 x=1737045818; bh=USyQ7bRKGDYGMBVsfsu79QdkW/CVwL8eHUG+R2ribRM=; b=
	dmichuMg+pRXOuzCHWH59nxCkVpNFbBaOg7jYACfKlR8uYbPyWJEUb93gRBoBusj
	aE/blxGvqrFX2jylrstDRt5eP3llIOboSWug/tGFLxhG1X5B1Dv+9avcIJw+Fwm2
	Bodxp+BP/IYzh91aKwix/GJ8UqSwaYdYvMqpS/PWHfqhl8KZY2eHChsubPCNPMqQ
	M3INPvyzhWbBbGFw7PV2sifPHRciEOEP/J7+DG+V8wQHHFpKzA+BLBWox/YKBe3F
	m6jJhNXNtSiopBKY5t7raCL25cy6THFlfZJZN8rKfVGUdCEnDZza0sSEhVZs3ohE
	QLb67kmqkymE1DqqmmYZVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736959418; x=
	1737045818; bh=USyQ7bRKGDYGMBVsfsu79QdkW/CVwL8eHUG+R2ribRM=; b=Q
	Fl13wUffW/c4wYrKtaOGObsZyRB87tl7PRmifOGQF66K8DV5O81p2s5yBzCw+RnS
	hkOBw9gbLbXUCtvmwo3XzwRZA3DHiZNWGqrhlt2ViYVxaGXNCGZjDJUQesShwaOG
	06LAJRDFEivqyvwBgugNNugu4nFcTYgro0iaOqj02XwqoTPbaTIvJchZiDoIUCxj
	egHHnhNM8XKaG+nHm6pZecF1TOElR+dYaaN8hvHX5+ue+9WNTUI/n+a2WO+FjefW
	RC3JyiSZT7Z4Ibt6zdVSsW9wlSTFuDD+fzQWqISakbqg3asBuAgNQrPfdsfYkJQG
	nmGf5lROh+LvjnKMW+1cw==
X-ME-Sender: <xms:ueWHZ6nf_LDX89pFyRa-43v2dU68MwWUAGdSRNjmYlit_ILAOwVjZQ>
    <xme:ueWHZx0tX5Kvgnqin-sxTbk25ZMN487Uiucrih477yTQVHRADV2s8v5h6hdC56Dqw
    QjTcDbUaQHwtRAR>
X-ME-Received: <xmr:ueWHZ4qbKolCOsDpk79SY11tWnqB23HtlV5o5jKnk3VXBE0YPOUTbJmKqamnMa7Gpvn7gm9fZU-53hP-QB0OMxvU35rVCkE4kIpk64y4-dJzgfI-aXtm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehledgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnh
    gurdgtohhmqeenucggtffrrghtthgvrhhnpeejgfeljeeuffehhfeukedvudfhteethedt
    heefjefhveduteehhfdttedvkeekveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhn
    ugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtoheplhhuihhssehighgrlhhirgdrtghomhdprhgtphhtthhopehm
    ihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinhhugidqfhhsuggvvh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmhhgrrhhvvgihse
    hjuhhmphhtrhgrughinhhgrdgtohhm
X-ME-Proxy: <xmx:ueWHZ-mh_QLCJnonUryDKfsJ8_QH3k8WTOPqGJ3SCqfHcys7I9CwjQ>
    <xmx:ueWHZ40KhbJK7r_zgbuDJHRUT9xM4NvIOyfoARjUEoiWNiwyH-XnxA>
    <xmx:ueWHZ1vIAgtuZXpnbPlpT_gAoROwxfIiUbzme9y9w0yzSW4iUt1PdA>
    <xmx:ueWHZ0WiskCJkc0uvCY_GBuRifJCtT2D-c_759uTu08e7Jfyk0MQOg>
    <xmx:uuWHZ8--qALvp8KZHDrorf7s9gcwu9j2oqX0klrS9axMD30Y37oC5-XM>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 11:43:36 -0500 (EST)
Message-ID: <9e876952-4603-4bf4-a3a0-9369d99d74c6@bsbernd.com>
Date: Wed, 15 Jan 2025 17:43:35 +0100
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
 Matt Harvey <mharvey@jumptrading.com>
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

Out of interest, what is the use case?

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

Maybe list_for_each_entry_safe() and then you can iput(inode) before the
next iteration?

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


Thanks,
Bernd

