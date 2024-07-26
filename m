Return-Path: <linux-fsdevel+bounces-24289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5B393CD9F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 07:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B422828D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 05:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76373A8D8;
	Fri, 26 Jul 2024 05:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="F+Lqyd5N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0720F1A716;
	Fri, 26 Jul 2024 05:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721972077; cv=none; b=XrOazpybwku7hkfJwBguo4L+XhdyY7RsxVCb/Sbdv0WHBkQ71u4efpt9DyZrNp7waJCZkSTkcovTxLTZhKp8uCZLdGraS78waGukI8q2VNGaX0AV/XvEsWq0nt9emEE9B1osPMAosG3v5DTZ9Fp7jwi6m9ICvFkE/xwxEnDmqzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721972077; c=relaxed/simple;
	bh=j8S11bQ4rCpOQplRWibtrlGiHW89yVi6R/BAsL7/vAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlidzeyyLRjSOtwZ7yGTGkGw6kp7FVNqiBgyROPt5fh+rftkkH/Z6dywDYy2S0P+9I4HBZM0s3upKmREqG6RrdreVYyalFbFbTSnoJqjTaHzcAhLBy9f2oBM6lt3//jJDWh+hZSoYp8SoTTYS6mtYxyL7v/EzQtUS0ncW8Bx65w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=F+Lqyd5N; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1ekO3R2vJa5Ho8q/Kh8JU8rDOdI33MwHGdHSPVjRH/Q=; b=F+Lqyd5NBnxm8qAH18kDB2Uruz
	NiJRYF10Mep2Cgk+TbbZPYv43LsbdLhpWiKjBa4hWOXMh/n9iJ2c3cCXABGowBV2Z8ZRQEt39Kp+1
	HSJG6XIiuzhkKjZFZvbo1+YDqqCbkOc9kEk7M0gNEF7vs622DH0kWd0AKaMzRmEQ46omUGA7z4V5L
	1CrwGhbkOmP5I48AVJ/qlm1fqHYycMzRuaNOQPVldOQjnhcXrbYVaDN43V+Tb+QUENR+EJVKO3vx6
	HEq9qBEnesWr/F1qps9B1NRIE7w64ixsCOAkD0Cddup6GEWYvkJ95o4nyn438Jr2w/bvOTLZ8Nilc
	9qD+/JDg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXDb4-0000000294Z-21Cu;
	Fri, 26 Jul 2024 05:34:30 +0000
Date: Fri, 26 Jul 2024 06:34:30 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, brauner@kernel.org,
	jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com
Subject: Re: [PATCH bpf-next 1/2] bpf: Add kfunc bpf_get_dentry_xattr() to
 read xattr from dentry
Message-ID: <20240726053430.GB99483@ZenIV>
References: <20240725234706.655613-1-song@kernel.org>
 <20240725234706.655613-2-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725234706.655613-2-song@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jul 25, 2024 at 04:47:05PM -0700, Song Liu wrote:

> +__bpf_kfunc struct dentry *bpf_file_dentry(const struct file *file)
> +{
> +	/* file_dentry() does not hold reference to the dentry. We add a
> +	 * dget() here so that we can add KF_ACQUIRE flag to
> +	 * bpf_file_dentry().
> +	 */
> +	return dget(file_dentry(file));
> +}
> +
> +__bpf_kfunc struct dentry *bpf_dget_parent(struct dentry *dentry)
> +{
> +	return dget_parent(dentry);
> +}
> +
> +__bpf_kfunc void bpf_dput(struct dentry *dentry)
> +{
> +	return dput(dentry);
> +}

	If you keep a file reference, why bother grabbing dentry one?
If not, you have a very bad trouble if that opened file is the only
thing that keeps the filesystem busy.

	It's almost certainly a wrong interface; please, explain what
exactly are you trying to do here.

