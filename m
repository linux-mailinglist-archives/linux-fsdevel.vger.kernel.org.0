Return-Path: <linux-fsdevel+bounces-51671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E745AD9F0C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 20:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889931897352
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 18:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903DE2E62D7;
	Sat, 14 Jun 2025 18:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="FnP5KKZg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AAnyZL0n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F59C30100;
	Sat, 14 Jun 2025 18:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749926182; cv=none; b=hVQMnQsX2MFjgusgK+bjexSBGdiqDxzXIePUNYgT5EYptwtrdMuteZ1OqGQYdDrdGOklZZpICwysEUQ0Bd+Es4UDw+i2TSWFrhijn2IGas2Y3HGw/7pQnZb/rHIvhW0pHsWq+3SWfUTrkp+nBz6LGLqvt2ALeD5sEgTJ6tVPXsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749926182; c=relaxed/simple;
	bh=3dzdX4kZV66YVSeT4KnMyTAL6dUXfb3O9U7JJ4FkODI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQwqo+xZROm6Dz2mS8YawzGB9UHo996fcpAULQKaPide5MLUokaIlWeljx/AUOqOZ8+0qzvFztHeXcfrZnffYq/Uw5jiqG5u/6WSHafnxsJS/OomMcvguU4OLyaEbgi24xBi4E3c3vojc3/GPd4DUQa5yNoaof8fboXxSALgMFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=FnP5KKZg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AAnyZL0n; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id A3A5F2003C8;
	Sat, 14 Jun 2025 14:36:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 14 Jun 2025 14:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749926179;
	 x=1749933379; bh=/gO+W1y6nHMFbF2yimL+ciEfWt1+14MU/pwHIvdjUTo=; b=
	FnP5KKZgNUO6leHMMDdBy5FsnNZ0mI2GJbe6suSh8QUGaJgPVt8kAxIUvRBMDQaU
	6NAIB46tv9axMeSbGSZV4xXzjrG1YNqbEqa2rcewXhK40QbXNrr1v348X1U4IA+S
	Vr8w2N595iO8zB6lQJLRo2gW/a73Ei/U7AeJmApTT5/Zm243XGvqTV4vP0A6QhjC
	m4vcWHRCugp9JUnouEcDfQMEB9HzUWjtHZOzwj7Di3IwjP7C/EEDVntcvXMhNWEi
	273qzJ4OXi0sEhL3tpWGsowriLljF9eCKZxqNIhawspA+9kIom9Qqid9H0tB0i5U
	CdxasjgRXpGz0RsnwEfFfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749926179; x=
	1749933379; bh=/gO+W1y6nHMFbF2yimL+ciEfWt1+14MU/pwHIvdjUTo=; b=A
	AnyZL0n1w+zeXR3mJrlqmLGJMNrDi7nNsjfJmh20Fz6jrgSo+J9pF63dJyG50ArR
	ebfQp7L0rFkKVcV1duOywEog8RywIWqMQ6GuuetvNR5KZ/sP7359M1RkJ33o5Ss5
	ZQmxH7rhdFH54YuF9Qzkv1ZXbIO4+cQ7Ed0kU9Az5jL+hDPBkPaxvzLeyCcFgX0F
	UppWtrmyVjGzH9hPDNGFVupU5r58DUX3kHBi8OgWTmprGDRZrwBdhzMyDH4k/l5G
	TdMfOVrsFf+bm5LeCMlKOuOp1TC3lfi9e6xpOkF1eznmflU8c/eeLXBbAEY2859A
	p9hfJEXRhLwuHxEIzlHQw==
X-ME-Sender: <xms:IsFNaDeD_Gi8NTqZZoLTfGIl8E-UInpCPgU5zj_jj_xoYikxdsTEBg>
    <xme:IsFNaJNkEYJKFSRHeRwJ9QHgdZr54AQTyiCMenNPdL1YlF6pZyMKu8_zhTyRSQ2Mf
    Hao6TFr-j6cZvJ_QPI>
X-ME-Received: <xmr:IsFNaMg8qCp_49ecAFGvkePn9VQ78V8EU1DzRNld7ENDLt_MP6QhAQ_BivbZqmCn9sb0VfeOZ6xOd0wlRgGFFSU6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqe
    enucggtffrrghtthgvrhhnpeefvdehleeutdfhlefgvedvgfeklefgleekgedtvdehvdfg
    tdefieelhfdutefgudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepvdefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehmvghtrgdrtghomhdprhgtphht
    thhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguugihiiekje
    esghhmrghilhdrtghomhdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:IsFNaE_9gA1qCS1kON1G0tE7Kg3KeSJc93s1s96OxSF86eJyd_4iSA>
    <xmx:IsFNaPuYmOZb8mS0aRSECHqRJduSLv8uihtnOEV1xxAMx3GwhEsIjg>
    <xmx:IsFNaDFBtXoougFzwushMdUiIpXEaTbvjM99FVPdzCegKWNYk_ozTw>
    <xmx:IsFNaGNZiCFf13m5XeErDqKW5SWqnrzvKbHqvqZ7yBr273mB4McuVg>
    <xmx:I8FNaIWExtNumH1iBKrzaUemEDpeMiyc5znla2aSxmqTcWMeJbnGB0wY>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Jun 2025 14:36:15 -0400 (EDT)
Message-ID: <75ea3f6b-cf5b-4e97-9214-cbd3f299008c@maowtm.org>
Date: Sat, 14 Jun 2025 19:36:14 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 bpf-next 1/5] namei: Introduce new helper function
 path_walk_parent()
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org,
 mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com,
 jlayton@kernel.org, josef@toxicpanda.com, mic@digikod.net,
 gnoack@google.com, neil@brown.name
References: <20250611220220.3681382-1-song@kernel.org>
 <20250611220220.3681382-2-song@kernel.org>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20250611220220.3681382-2-song@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/25 23:02, Song Liu wrote:
> This helper walks an input path to its parent. Logic are added to handle
> walking across mount tree.
> 
> This will be used by landlock, and BPF LSM.
> 
> Suggested-by: Neil Brown <neil@brown.name>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  fs/namei.c            | 99 +++++++++++++++++++++++++++++++++++++------
>  include/linux/namei.h |  2 +
>  2 files changed, 87 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 4bb889fc980b..bc65361c5d13 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2048,36 +2048,107 @@ static struct dentry *follow_dotdot_rcu(struct nameidata *nd)
>  	return nd->path.dentry;
>  }
>  
> -static struct dentry *follow_dotdot(struct nameidata *nd)
> +/**
> + * __path_walk_parent - Find the parent of the given struct path
> + * @path  - The struct path to start from
> + * @root  - A struct path which serves as a boundary not to be crosses.
> + *        - If @root is zero'ed, walk all the way to global root.
> + * @flags - Some LOOKUP_ flags.
> + *
> + * Find and return the dentry for the parent of the given path
> + * (mount/dentry). If the given path is the root of a mounted tree, it
> + * is first updated to the mount point on which that tree is mounted.
> + *
> + * If %LOOKUP_NO_XDEV is given, then *after* the path is updated to a new
> + * mount, the error EXDEV is returned.
> + *
> + * If no parent can be found, either because the tree is not mounted or
> + * because the @path matches the @root, then @path->dentry is returned
> + * unless @flags contains %LOOKUP_BENEATH, in which case -EXDEV is returned.
> + *
> + * Returns: either an ERR_PTR() or the chosen parent which will have had
> + * the refcount incremented.
> + */
> +static struct dentry *__path_walk_parent(struct path *path, const struct path *root, int flags)
>  {
>  	struct dentry *parent;
>  
> -	if (path_equal(&nd->path, &nd->root))
> +	if (path_equal(path, root))
>  		goto in_root;
> -	if (unlikely(nd->path.dentry == nd->path.mnt->mnt_root)) {
> -		struct path path;
> +	if (unlikely(path->dentry == path->mnt->mnt_root)) {
> +		struct path new_path;
>  
> -		if (!choose_mountpoint(real_mount(nd->path.mnt),
> -				       &nd->root, &path))
> +		if (!choose_mountpoint(real_mount(path->mnt),
> +				       root, &new_path))
>  			goto in_root;
> -		path_put(&nd->path);
> -		nd->path = path;
> -		nd->inode = path.dentry->d_inode;
> -		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
> +		path_put(path);
> +		*path = new_path;
> +		if (unlikely(flags & LOOKUP_NO_XDEV))
>  			return ERR_PTR(-EXDEV);
>  	}
>  	/* rare case of legitimate dget_parent()... */
> -	parent = dget_parent(nd->path.dentry);
> -	if (unlikely(!path_connected(nd->path.mnt, parent))) {
> +	parent = dget_parent(path->dentry);
> +	if (unlikely(!path_connected(path->mnt, parent))) {

This is checking path_connected here but also in follow_dotdot,
path_connected is checked again. Is this check meant to be here?  It will
also change the landlock behaviour right?

(For some reason patch 2 rejects when I tried to apply it on v6.16-rc1, so
I haven't actually tested this patch to see if this is really an issue)

>  		dput(parent);
>  		return ERR_PTR(-ENOENT);
>  	}
>  	return parent;
>  
>  in_root:
> -	if (unlikely(nd->flags & LOOKUP_BENEATH))
> +	if (unlikely(flags & LOOKUP_BENEATH))
>  		return ERR_PTR(-EXDEV);
> -	return dget(nd->path.dentry);
> +	return dget(path->dentry);
> +}
> +
> +/**
> + * path_walk_parent - Walk to the parent of path
> + * @path: input and output path.
> + * @root: root of the path walk, do not go beyond this root. If @root is
> + *        zero'ed, walk all the way to real root.
> + *
> + * Given a path, find the parent path. Replace @path with the parent path.
> + * If we were already at the real root or a disconnected root, @path is
> + * released and zero'ed.
> + *
> + * Returns:
> + *  true  - if @path is updated to its parent.
> + *  false - if @path is already the root (real root or @root).
> + */
> +bool path_walk_parent(struct path *path, const struct path *root)
> +{
> +	struct dentry *parent;
> +
> +	parent = __path_walk_parent(path, root, LOOKUP_BENEATH);
> +
> +	if (IS_ERR(parent))
> +		goto false_out;
> +
> +	if (parent == path->dentry) {
> +		dput(parent);
> +		goto false_out;
> +	}
> +	dput(path->dentry);
> +	path->dentry = parent;
> +	return true;
> +
> +false_out:
> +	path_put(path);
> +	memset(path, 0, sizeof(*path));
> +	return false;
> +}
> +
> +static struct dentry *follow_dotdot(struct nameidata *nd)
> +{
> +	struct dentry *parent = __path_walk_parent(&nd->path, &nd->root, nd->flags);
> +
> +	if (IS_ERR(parent))
> +		return parent;
> +	if (unlikely(!path_connected(nd->path.mnt, parent))) {
> +		dput(parent);
> +		return ERR_PTR(-ENOENT);
> +	}
> +	nd->inode = nd->path.dentry->d_inode;
> +	return parent;
>  }
>  
>  static const char *handle_dots(struct nameidata *nd, int type)
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 5d085428e471..cba5373ecf86 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -85,6 +85,8 @@ extern int follow_down_one(struct path *);
>  extern int follow_down(struct path *path, unsigned int flags);
>  extern int follow_up(struct path *);
>  
> +bool path_walk_parent(struct path *path, const struct path *root);
> +
>  extern struct dentry *lock_rename(struct dentry *, struct dentry *);
>  extern struct dentry *lock_rename_child(struct dentry *, struct dentry *);
>  extern void unlock_rename(struct dentry *, struct dentry *);


