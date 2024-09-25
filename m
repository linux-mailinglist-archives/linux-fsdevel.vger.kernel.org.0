Return-Path: <linux-fsdevel+bounces-30026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D529850DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 04:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722322815D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 02:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180A8148310;
	Wed, 25 Sep 2024 02:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="G9HmjCKN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030BD2907;
	Wed, 25 Sep 2024 02:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727230160; cv=none; b=tR2JMQTfuw3PL/FItWuVTZmIIDzAK9POieeNG7Id/8vigiMIFB8aYkJRu0+iYw1rLJ/bHWeilkyV94exvUyQ6Zv5mXcQ/Vf+NGxG67Q4Ht691DiQ+jXrBfr2XcIM6M7SwL/1GiV9V8NK13bjuawzL9XP8k/pAJoIMIMSM0M36MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727230160; c=relaxed/simple;
	bh=MdE/LSPBcNfjmF22VTSCq/0zrMGTRWfeJMZPYor86Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4T4Paod3BraqeDPgfv4pPPo+qxJKE/yS2+4FBOyWWe/JBkEHolFJvnx/X/3QuAhQvGZ1AVOSHgWHk7brSH4UygfX/dOEdkDkTe8te2Q9fqVmHHdsoTBpu4FL1KOyoiiNFq4aoiyO1FF9C0zy3Rj78clEyvPIVWFkAQ4EkDhFQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=G9HmjCKN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hHQQRBtegnN5kGY7Xa1fOFYRiWP3GrympGc1SGJ9xOk=; b=G9HmjCKNMW8TLMjk3C15q4pkmu
	8M7FAtHiHRUU4JtGwmZKptRvov99JcVJD2Hs+VfaEusUwMxpMC76d/9Gs7OdhcdD0bhGO9xcfpcHp
	tE55DBQKyD6WCx/6bqv/hf+GvPZUkY3nJEheylWvCgio8wdk61oDw0QxS6xf5+izT5XXjjoSkYDC6
	Ly/nEUiFImyHSeD1ecvsOqHxliXbRZ0Z+25QasJrD2CdxytnKoq/m8xes4rLbZV3TURbnhJUHqzno
	/GWOTixKoC/WAoA6VB2lUlZ378q7yeY4T/gG74FeFFnPZ73ycz9JQdalrrraIjR+BpeU6l5N3qD63
	HcPX/zog==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1stHSr-0000000FHbi-3WnO;
	Wed, 25 Sep 2024 02:09:13 +0000
Date: Wed, 25 Sep 2024 03:09:13 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, brauner@kernel.org,
	jack@suse.cz, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chris.zjh@huawei.com
Subject: Re: [PATCH v2] fs: ext4: support relative path for `journal_path` in
 mount option.
Message-ID: <20240925020913.GH3550746@ZenIV>
References: <20240925015624.3817878-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925015624.3817878-1-lihongbo22@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 25, 2024 at 09:56:24AM +0800, Hongbo Li wrote:
> @@ -156,6 +156,9 @@ int fs_lookup_param(struct fs_context *fc,
>  		f = getname_kernel(param->string);
>  		if (IS_ERR(f))
>  			return PTR_ERR(f);
> +		/* for relative path */
> +		if (f->name[0] != '/')
> +			param->dirfd = AT_FDCWD;

Will need to dig around for some context, but this bit definitely makes
no sense - dirfd is completely ignored for absolute pathnames, so making
that store conditional is pointless.


