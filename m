Return-Path: <linux-fsdevel+bounces-6631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2465A81AFAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 08:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55DA21C23467
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 07:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB3E1773E;
	Thu, 21 Dec 2023 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CyGUP3iE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1EC17745;
	Thu, 21 Dec 2023 07:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LWqF/Y37SmpDLulc6cjBB+/HUzaRe+A8SRPSmTNrLps=; b=CyGUP3iEahTK1hH0NTvCsSV65A
	hR5EBSWyJFMDw5Em/W73Lk0ToDAhpzo+r2qf0I0FbbaVJjb4n34g8JivJiLuafLEVZsA7BfnEq1Tt
	EhZwoLITM8IE3pgeguDCii/5IzVeW8gKUrQT5nS1Qyo9TJp88KzQfBQfhUB3uevoye4+BMKSyKOdh
	jcnZU1rCS9/d25zXM6mwp7akEeTeLX1antM5/IybK65z+GgT2X0B0OCdx19x5KGqDecYUx2/bboq+
	2qs9K2Iyx5nko5XWQ2xja1HiLXAsh5CSc9u0+2z+3RQk8rF+1sdzAhy/jXEeSAb3jr1qUO2wjRrww
	7HOtJ0UQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rGDee-001Ji1-1S;
	Thu, 21 Dec 2023 07:39:40 +0000
Date: Thu, 21 Dec 2023 07:39:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: ebiggers@kernel.org, jaegeuk@kernel.org, tytso@mit.edu,
	linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] fscrypt: Move d_revalidate configuration back
 into fscrypt
Message-ID: <20231221073940.GC1674809@ZenIV>
References: <20231215211608.6449-1-krisman@suse.de>
 <20231215211608.6449-9-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215211608.6449-9-krisman@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Dec 15, 2023 at 04:16:08PM -0500, Gabriel Krisman Bertazi wrote:

> +static const struct dentry_operations fscrypt_dentry_ops = {
> +	.d_revalidate = fscrypt_d_revalidate,
> +};
> +
>  int __fscrypt_prepare_lookup(struct inode *dir, struct dentry *dentry,
>  			     struct fscrypt_name *fname)
>  {
> @@ -106,6 +110,10 @@ int __fscrypt_prepare_lookup(struct inode *dir, struct dentry *dentry,
>  		spin_lock(&dentry->d_lock);
>  		dentry->d_flags |= DCACHE_NOKEY_NAME;
>  		spin_unlock(&dentry->d_lock);
> +
> +		/* Give preference to the filesystem hooks, if any. */
> +		if (!dentry->d_op)
> +			d_set_d_op(dentry, &fscrypt_dentry_ops);
>  	}
>  	return err;

Hmm...  Could we simply set ->s_d_op to &fscrypt_dentry_ops in non-ci case
*AND* have __fscrypt_prepare_lookup() clear DCACHE_OP_REVALIDATE in case
when it's not setting DCACHE_NOKEY_NAME and ->d_op->d_revalidate is
equal to fscrypt_d_revalidate?  I mean,

	spin_lock(&dentry->d_lock);
        if (fname->is_nokey_name)
                dentry->d_flags |= DCACHE_NOKEY_NAME;
        else if (dentry->d_flags & DCACHE_OP_REVALIDATE &&
		 dentry->d_op->d_revalidate == fscrypt_d_revalidate)
		dentry->d_flags &= ~DCACHE_OP_REVALIDATE;
	spin_unlock(&dentry->d_lock);

here + always set ->s_d_op for ext4 and friends (conditional upon
the CONFIG_UNICODE).

No encryption - fine, you get ->is_nokey_name false from the very
beginning, DCACHE_OP_REVALIDATE is cleared and VFS won't ever call
->d_revalidate(); not even the first time.  

Yes, you pay minimal price in dentry_unlink_inode() when we hit
        if (dentry->d_op && dentry->d_op->d_iput)
and bugger off after the second fetch instead of the first one.
I would be quite surprised if it turns out to be measurable,
but if it is, we can always add DCACHE_OP_IPUT to flags.
Similar for ->d_op->d_release (called in the end of
__dentry_kill()).  Again, that only makes sense if we get
a measurable overhead from that.

