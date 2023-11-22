Return-Path: <linux-fsdevel+bounces-3471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D23637F516B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 21:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF551C20B79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 20:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E255A14002;
	Wed, 22 Nov 2023 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="IrY2Wn5O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A673B9A;
	Wed, 22 Nov 2023 12:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uoaIxjf4dzgVF6LqwbixeuWhgvgd9c6WsrC3GpE+d/s=; b=IrY2Wn5Oe5jfRXdNhzZlLs8kZo
	QFzv90A6C9COCCEZeRPKml7WibZD+hdWxYaLFriHmmxRNLsBv+sabZlS5oaVs+CTxURJVe+stqNkZ
	EKLou2k6lNa8HPq3LNL78tX92prFmoLhh12wJ0d+iO5G5NzzE38wCWYGQhBMEA6NCsr82hi6Gkuu8
	VRcW4nUCNx04ykC4wEtwmse0foWfgaia/GsDohCWp3mpwGc9C3JjIAJJqxI8KMcL/w84JA0REqVlh
	PfmQQVu8dZJUMsjeOJbqqAo3VWro3ZSkc/5b0aQnCYRn6S07XdZbfSJlDTQLZAnONowZlYVg0dyv3
	vo3Ya96A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5tiG-001lqO-2f;
	Wed, 22 Nov 2023 20:20:44 +0000
Date: Wed, 22 Nov 2023 20:20:44 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: brauner@kernel.org, tytso@mit.edu, ebiggers@kernel.org,
	jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v6 5/9] libfs: Validate negative dentries in
 case-insensitive directories
Message-ID: <20231122202044.GF38156@ZenIV>
References: <20230816050803.15660-1-krisman@suse.de>
 <20230816050803.15660-6-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816050803.15660-6-krisman@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 16, 2023 at 01:07:59AM -0400, Gabriel Krisman Bertazi wrote:

> +static int generic_ci_d_revalidate(struct dentry *dentry,
> +				   const struct qstr *name,
> +				   unsigned int flags)
> +{
> +	const struct dentry *parent;
> +	const struct inode *dir;
> +
> +	if (!d_is_negative(dentry))
> +		return 1;
> +
> +	parent = READ_ONCE(dentry->d_parent);
> +	dir = READ_ONCE(parent->d_inode);
> +
> +	if (!dir || !IS_CASEFOLDED(dir))
> +		return 1;
> +
> +	/*
> +	 * Negative dentries created prior to turning the directory
> +	 * case-insensitive cannot be trusted, since they don't ensure
> +	 * any possible case version of the filename doesn't exist.
> +	 */
> +	if (!d_is_casefolded_name(dentry))
> +		return 0;
> +
> +	/*
> +	 * If the lookup is for creation, then a negative dentry can only be
> +	 * reused if it's a case-sensitive match, not just a case-insensitive
> +	 * one.  This is needed to make the new file be created with the name
> +	 * the user specified, preserving case.
> +	 *
> +	 * LOOKUP_CREATE or LOOKUP_RENAME_TARGET cover most creations.  In these
> +	 * cases, ->d_name is stable and can be compared to 'name' without
> +	 * taking ->d_lock because the caller must hold dir->i_rwsem.  (This
> +	 * is because the directory lock blocks the dentry from being
> +	 * concurrently instantiated, and negative dentries are never moved.)
> +	 *
> +	 * All other creations actually use flags==0.  These come from the edge
> +	 * case of filesystems calling functions like lookup_one() that do a
> +	 * lookup without setting the lookup flags at all.  Such lookups might
> +	 * or might not be for creation, and if not don't guarantee stable
> +	 * ->d_name.  Therefore, invalidate all negative dentries when flags==0.
> +	 */
> +	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET)) {
> +		if (dentry->d_name.len != name->len ||
> +		    memcmp(dentry->d_name.name, name->name, name->len))
> +			return 0;

Frankly, I would rather moved that to fs/dcache.c and used dentry_cmp() instead
of memcmp() here.  Avoids the discussion of ->d_name stability for this one.

