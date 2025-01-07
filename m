Return-Path: <linux-fsdevel+bounces-38586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A40A0441F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 16:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674BD1886447
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 15:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D271F37C8;
	Tue,  7 Jan 2025 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UHKLvKNr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AA91F37CE;
	Tue,  7 Jan 2025 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263257; cv=none; b=ptQa2ti/CD47cjyxyo9LxprSazOZCSTIxpbrwgSDqUpeNOhSoAAFL3cbyTxBocYrpMpseoT6RTUbGQOPmyUqrz44y6wzWPncK1CAqB5upNe/EG+f1SE27SZSc8zGFA74LqMnJWTDcoXhPasDI22moly9VxfIoi4bfQjbEnjh5fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263257; c=relaxed/simple;
	bh=wUPEQRUSCo1jVmOjlmyLGK4YzSEDM43+1C4AiftHUXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CiE0ND0r6SW60tz9oOrW6QzKrAhPpdzRxfni4HzxLPgfsBpzj+wbzQDbZjO8uqrfoCumJoc1QHYobk1yAjIM0Op3WCar8LmOmxcXx6YW28J18CKcaJ7Lk8LbamVo61mzpW0emN8uez0mHLxrZK8qZIeEjPycfCFdzXkyih1xEMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UHKLvKNr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hDgRYwZS0XNj3XUF9z+fuP+sXGEKszCKeSsIZUC9wGs=; b=UHKLvKNrJf4OU/cMZFo4KnipVZ
	v7CtrJ+CsCoxoYR7ZajFoteSfrrYaeGIj+s7lU85JGj8shCLOHfIeAz71pNqJHpBm2XeJw9W20DOp
	X/uH4Kwe8mQkMgIIkx0nAR0VJiv7qcBLhq8kax1HZUZJx0bRh8T4gB8YGHMgfmmvfAwMea1yJizJM
	VwKYkcg1EH9dLTlklNysM6ByYMv30HYtJhhe6ZKr7+ODG61/FI8FaGYnXWBLBW0loVtCxwj6oxCp9
	WThSiL/Rk8X/Rr4E00NRCL6xMIFNdJS7S/8+DbGROuzOooIm/YOl7ERJRkJZndSJVCw0rFJWQw3wv
	h54zCguw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tVBNy-0000000GYCP-11D8;
	Tue, 07 Jan 2025 15:20:50 +0000
Date: Tue, 7 Jan 2025 15:20:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>,
	Christian Brauner <christian@brauner.io>,
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] afs: Make /afs/@cell and /afs/.@cell symlinks
Message-ID: <20250107152050.GP1977892@ZenIV>
References: <20250107142513.527300-1-dhowells@redhat.com>
 <20250107142513.527300-3-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107142513.527300-3-dhowells@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jan 07, 2025 at 02:25:09PM +0000, David Howells wrote:

> @@ -247,9 +285,13 @@ static struct dentry *afs_dynroot_lookup(struct inode *dir, struct dentry *dentr
>  		return ERR_PTR(-ENAMETOOLONG);
>  	}
>  
> -	if (dentry->d_name.len == 5 &&
> -	    memcmp(dentry->d_name.name, "@cell", 5) == 0)
> -		return afs_lookup_atcell(dentry);
> +	if (dentry->d_name.len == sizeof(afs_atcell) - 1 &&
> +	    memcmp(dentry->d_name.name, afs_atcell, sizeof(afs_atcell) - 1) == 0)
> +		return afs_lookup_atcell(dentry, false);
> +
> +	if (dentry->d_name.len == sizeof(afs_dotatcell) - 1 &&
> +	    memcmp(dentry->d_name.name, afs_dotatcell, sizeof(afs_dotatcell) - 1) == 0)
> +		return afs_lookup_atcell(dentry, true);

Ow...  That looks just painful.

>  	return d_splice_alias(afs_try_auto_mntpt(dentry, dir), dentry);
>  }
> @@ -343,6 +385,40 @@ void afs_dynroot_rmdir(struct afs_net *net, struct afs_cell *cell)

> +static int afs_dynroot_symlink(struct afs_net *net)
> +{
> +	struct super_block *sb = net->dynroot_sb;
> +	struct dentry *root, *symlink, *dsymlink;
> +	int ret;
> +
> +	/* Let the ->lookup op do the creation */
> +	root = sb->s_root;
> +	inode_lock(root->d_inode);
> +	symlink = lookup_one_len(afs_atcell, root, sizeof(afs_atcell) - 1);
> +	if (IS_ERR(symlink)) {
> +		ret = PTR_ERR(symlink);
> +		goto unlock;
> +	}
> +
> +	dsymlink = lookup_one_len(afs_dotatcell, root, sizeof(afs_dotatcell) - 1);
> +	if (IS_ERR(dsymlink)) {
> +		ret = PTR_ERR(dsymlink);
> +		dput(symlink);
> +		goto unlock;
> +	}

Just allocate those child dentries and call your afs_lookup_atcell() for them.
No need to keep that mess in ->lookup() - you are keeping those suckers cached
now, so...

