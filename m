Return-Path: <linux-fsdevel+bounces-42160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C60A3D6A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 11:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176953A42E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 10:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94561F4175;
	Thu, 20 Feb 2025 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="PYczauzG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XpQA93QM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CBA1F3B9D
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047197; cv=none; b=sGdv1uNcak12Filg9oXOyLyo8IE/E3f6msBDcYBhNo1vZJnZbzQSClh4GCFynI2DQQaIgt2orQAzXUwLWZdiJMWPjwKGSJxSj+/SkxBCjQ3BcZDInRgqDaFSEGJMFa8YHYq6aZ2hiKZn0jK5fvkRZqfc4hVFEFGQTNdLXbetgqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047197; c=relaxed/simple;
	bh=PTeFBL9DttnVJRLb7trjvP7EcgECL39DhpuvtTVewqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eKajODumzGfq4ndbi1QVv1k6kHsVKTsiPuRKbhaA/tjJheHp3Zo3dlDByeD6LTa9QPuq1ipYRY5Lrsof7CiQQhTFI0krHMES9NQjCvnMIGNmn6W4t5bzEgH6FQ7g+Tc/wHbGs+l8Xpvc3/1jy+mnIhEiFzcunQP3YenbC7yRk+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=PYczauzG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XpQA93QM; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C0E822540113;
	Thu, 20 Feb 2025 05:26:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 20 Feb 2025 05:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740047193;
	 x=1740133593; bh=RO4T00Ah66h3iPjvrcJ+gB4xy2HA6w1knzy/cJoaPbA=; b=
	PYczauzGuF4OREG6JKXh509FEM9k/z/ePBjVSA3H45VOKVswRO8lJUwg2gOWl9OV
	g3Cd7l1Zjiuc+vTiVKlNTU5yyd8YkoNaQrsyKQ7YyvDFlbjPeYKcpm95w3LQ4Ta3
	kULxgL95FyaAu6udsxPrqgdOwTJuX27matImk7VFRR4/pwarlh2Uzdx1ToK97sZR
	vjsZpARNCv1eyKBnGMZP9ex4eeLsfW0MCQF2YgaSZPY4litmdZx5E+CyCTJNTEuL
	exbeDEA30GBk+yLycWxA/wbQf7plBHRCs/r6R7j7CFH0vTiPj8AZa7VwRXXZPjFF
	fwT39GSyCwCXZyvpk+W/sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1740047193; x=
	1740133593; bh=RO4T00Ah66h3iPjvrcJ+gB4xy2HA6w1knzy/cJoaPbA=; b=X
	pQA93QMv24qef48yYmvMd05k+w2F6YAPEgUj2HUl2b6DbIG1rBV8SWYNlDssrLYA
	tcqfHsfSseXuxqtCWx4emOjvTDcX1V1xmBr3hLAfFaNP0cvMAdbDt0Wu1Q3Jvc/c
	tdmx6IMPb5iVr7UhHBUwQagCm2B5NAa4Lsfafrioywgd1X+5sZgIh6TyC4oMPCfI
	tTE+Y28RZqEGU02uuXDTaI1Vtck6Sn+8PWcXxZleZ6KbdXu6sBUM2eFth8BFUl39
	lrVASX1lU4R+XuGKwdUCDdVBEkVfxKe/cY8ZUJsUyXCD+5dcX1rrDVnuiZsGCnLI
	LpwasYG2J6bcOncKmZ5sw==
X-ME-Sender: <xms:WQO3Z7fI7ey91toJKUlLfDcWo2rZXGVtGgYFvfOfZkd9EY7ovbwtfg>
    <xme:WQO3ZxP8PIYAVWcQbsD64Jtdif6fKfqD_0kx_txgtchGzFkvUtVYsuHg-GOfE2_5R
    f-ze9WFUFcpC76U>
X-ME-Received: <xmr:WQO3Z0i-VMVkmv_BsLO7MvrIpBevll5Cpv374dTNYxFbz3BUT2Bsj6M0HEVkZV3YUTrZBd5LW2racP2VxcRYkXqyZWu3o2P0Ue8JKI-3cLQQBt-IZvii>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiieeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddu
    gfdtgfegleefvdehfeeiveejieefveeiteeggffggfeulefgjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepmhhsiigvrhgvughisehrvgguhhgrthdrtghomhdprhgtphht
    thhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthho
    pegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlrghurhgrrdhprh
    homhgsvghrghgvrhestggvrhhnrdgthhdprhgtphhtthhopehsrghmtghlvgifihhssehg
    ohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:WQO3Z88gTUdB98hUF-WJaPeueTn7JCpVDp7OxG_16LF2GUwpR8UReA>
    <xmx:WQO3Z3u2aKSyslFP5yJCtm7rNYPyEAFS6WdmKRRMp_ujxEB5Z1gXhQ>
    <xmx:WQO3Z7HQ0ngGTcX-Z11e2S6I5P_Q9Xzd8qYZZcamwwYtb8-WBm14hQ>
    <xmx:WQO3Z-NyCy3ahFWbfS_kkBacAlLGQk16Y5NQwOIDrLkOHtRDk_Fh9g>
    <xmx:WQO3Z7jJSkIp8ffmK0Zf1fvnQwuzRD0bqbtjuNKfM1JnVesjbVBI4_S4>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Feb 2025 05:26:32 -0500 (EST)
Message-ID: <7fef961d-7f8b-4b39-a265-bf5ceda63b15@fastmail.fm>
Date: Thu, 20 Feb 2025 11:26:31 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: don't truncate cached, mutated symlink
To: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Laura Promberger <laura.promberger@cern.ch>, Sam Lewis <samclewis@google.com>
References: <20250220100258.793363-1-mszeredi@redhat.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250220100258.793363-1-mszeredi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/20/25 11:02, Miklos Szeredi wrote:
> Fuse allows the value of a symlink to change and this property is exploited
> by some filesystems (e.g. CVMFS).
> 
> It has been observed, that sometimes after changing the symlink contents,
> the value is truncated to the old size.
> 
> This is caused by fuse_getattr() racing with fuse_reverse_inval_inode().
> fuse_reverse_inval_inode() updates the fuse_inode's attr_version, which
> results in fuse_change_attributes() exiting before updating the cached
> attributes
> 
> This is okay, as the cached attributes remain invalid and the next call to
> fuse_change_attributes() will likely update the inode with the correct
> values.
> 
> The reason this causes problems is that cached symlinks will be
> returned through page_get_link(), which truncates the symlink to
> inode->i_size.  This is correct for filesystems that don't mutate
> symlinks, but in this case it causes bad behavior.
> 
> The solution is to just remove this truncation.  This can cause a
> regression in a filesystem that relies on supplying a symlink larger than
> the file size, but this is unlikely.  If that happens we'd need to make
> this behavior conditional.
> 
> Reported-by: Laura Promberger <laura.promberger@cern.ch>
> Tested-by: Sam Lewis <samclewis@google.com>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/dir.c      |  2 +-
>  fs/namei.c         | 24 +++++++++++++++++++-----
>  include/linux/fs.h |  2 ++
>  3 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 589e88822368..83c56ce6ad20 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1645,7 +1645,7 @@ static const char *fuse_get_link(struct dentry *dentry, struct inode *inode,
>  		goto out_err;
>  
>  	if (fc->cache_symlinks)
> -		return page_get_link(dentry, inode, callback);
> +		return page_get_link_raw(dentry, inode, callback);
>  
>  	err = -ECHILD;
>  	if (!dentry)
> diff --git a/fs/namei.c b/fs/namei.c
> index 3ab9440c5b93..ecb7b95c2ca3 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -5356,10 +5356,9 @@ const char *vfs_get_link(struct dentry *dentry, struct delayed_call *done)
>  EXPORT_SYMBOL(vfs_get_link);
>  
>  /* get the link contents into pagecache */
> -const char *page_get_link(struct dentry *dentry, struct inode *inode,
> -			  struct delayed_call *callback)
> +static char *__page_get_link(struct dentry *dentry, struct inode *inode,
> +			     struct delayed_call *callback)
>  {
> -	char *kaddr;
>  	struct page *page;
>  	struct address_space *mapping = inode->i_mapping;
>  
> @@ -5378,8 +5377,23 @@ const char *page_get_link(struct dentry *dentry, struct inode *inode,
>  	}
>  	set_delayed_call(callback, page_put_link, page);
>  	BUG_ON(mapping_gfp_mask(mapping) & __GFP_HIGHMEM);
> -	kaddr = page_address(page);
> -	nd_terminate_link(kaddr, inode->i_size, PAGE_SIZE - 1);
> +	return page_address(page);
> +}
> +
> +const char *page_get_link_raw(struct dentry *dentry, struct inode *inode,
> +			      struct delayed_call *callback)
> +{
> +	return __page_get_link(dentry, inode, callback);
> +}
> +EXPORT_SYMBOL_GPL(page_get_link_raw);
> +
> +const char *page_get_link(struct dentry *dentry, struct inode *inode,
> +					struct delayed_call *callback)
> +{
> +	char *kaddr = __page_get_link(dentry, inode, callback);
> +
> +	if (!IS_ERR(kaddr))
> +		nd_terminate_link(kaddr, inode->i_size, PAGE_SIZE - 1);
>  	return kaddr;
>  }
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 2c3b2f8a621f..9346adf28f7b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3452,6 +3452,8 @@ extern const struct file_operations generic_ro_fops;
>  
>  extern int readlink_copy(char __user *, int, const char *, int);
>  extern int page_readlink(struct dentry *, char __user *, int);
> +extern const char *page_get_link_raw(struct dentry *, struct inode *,
> +				     struct delayed_call *);
>  extern const char *page_get_link(struct dentry *, struct inode *,
>  				 struct delayed_call *);
>  extern void page_put_link(void *);

I had looked at it last year already, but always wanted to write a test
for it (and never found the time).

Reviewed-by: Bernd Schubert <bschubert@ddn.com>

