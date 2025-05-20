Return-Path: <linux-fsdevel+bounces-49529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C066ABDF2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 17:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378A04A21A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 15:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D5C265CAA;
	Tue, 20 May 2025 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rtBImGae"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D34C26136D;
	Tue, 20 May 2025 15:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747754742; cv=none; b=OnYPkUKYITODbo8vebDWoqqXTJHvbFP2Y/coCpZuAfNei2Tcgb23AsS54s/cQwZKlmyOf7VlGXBgY6qb0wgozOHgew8TmO9AmTDfYUkprh47uuwpZwWHUl674gWOZtXDoxB4omPhEHheltrRe07wcsDYG8r0EOOeRUkCIZXQPHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747754742; c=relaxed/simple;
	bh=UbxbrDjiPpBtkxeRkQ8NtBY8wwQKKNRtoyv/7gh0Dmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHbNRRzZNW9uMips1uoIMl24pRRRKVe9J+4lvw6RtyvmgaU0DjUolvfI6N+hm2mvllqbUZ9HcCpVs44nnk5HAgUJXzrWj/MRCAy+DUS0i9S+xSAisd6AM20RAlOVj/LHdiR7DZKdHnLR5Me4D450HID6twEP6K3erxlDuG8hGRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rtBImGae; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Am/sNS1781WyMPpChSgtEv4NfxAbfezIgyeON7xSp6E=; b=rtBImGaes5whKznFFL/nOXPuLS
	FMEZ7x8O93+hdriUj7LJZpF78e+/TWhUp2cvIt89rnGj67K6893Z9+v1VUvE+/4WXUykvajcf2skc
	guArY6YuHimgSP5EL+ND2zin9qPMvkzklubSdzDvLSaCZ34udQfv9mYDUsMSPG92lmKlhngZNZGTY
	YjP7251EJ5nWiq5cTeNn82+YQXHZealZ8lxxUVBUj5SmUDhw6BxEqCy6LtVpWoXocu+YRkJ4cYm/Q
	Tr1FiXnIvZpBli1QNQmulZFy/If7vuCcinnKhMOqardkbRl4ISwntkA424V7r26nT9EJTMeP2IjC/
	MgyAYoGw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHOqW-00000000wOJ-2FdS;
	Tue, 20 May 2025 15:25:36 +0000
Date: Tue, 20 May 2025 16:25:36 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 4/6] fs: dcache locking for exlusion between overlayfs,
 casefolding
Message-ID: <20250520152536.GD2023217@ZenIV>
References: <20250520051600.1903319-1-kent.overstreet@linux.dev>
 <20250520051600.1903319-5-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520051600.1903319-5-kent.overstreet@linux.dev>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 20, 2025 at 01:15:56AM -0400, Kent Overstreet wrote:

> +int d_casefold_enable(struct dentry *dentry, struct d_casefold_enable *e)
> +{
> +	struct dentry *root = dentry->d_sb->s_root;
> +	int ret = 0;
> +
> +	guard(mutex)(&no_casefold_dentries_lock);
> +
> +	for (struct dentry *i = dentry;
> +	     i && i->d_inode->i_flags & S_NO_CASEFOLD;
> +	     i = i != root ? i->d_parent : NULL) {
> +		ret = darray_push(&e->refs, i);
> +		if (ret)
> +			goto err;
> +
> +		ret = no_casefold_dentry_get(i, ref_casefold_enable);

	Beyond being fucking ugly, this is outright broken.  Lose
the timeslice (e.g. on allocation in that thing), and there's
nothing to prevent your 'i' from pointing to freed memory.

