Return-Path: <linux-fsdevel+bounces-41626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D29A33667
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 04:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C7D3A3844
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 03:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E1B204F8B;
	Thu, 13 Feb 2025 03:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UtTWIGbE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF8F537E5;
	Thu, 13 Feb 2025 03:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739418682; cv=none; b=IqnlzV93TtzpV47Z0ouffLwpqfwIQyPfP6P/L1zknFC3H0j7xheZiuqrGIv+xSUjV0f3hzk9mOVGaFur/hasMWQSiSfqgwyjKcmt1bwEXSYylVl0t2z15yrUzY3+7hUwtPjTd7bDcw7GFrKZya+oZ1EQNzxG5JDt7Xde6DAH0nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739418682; c=relaxed/simple;
	bh=3bjxMTrhQRmOkk/O2eq2Q3uBmspPWL+W2NfyeRkwbiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRYdCV8rB0JjWTXc1qB7hHGGggSl4Wm/0Z+NyXC0+TI6gUadG1dBNfrVS/GcVzDhY5yFIlPmK9tJYzF0WbOpe2yXwFn1wZHIf4HqYaGtneqrpsdc4MMmvWCgZ9F70d7g8kVlE9bFqUIzQGfw2IW5KGb8+PaYjKxRxZhFrXvbZ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UtTWIGbE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/aA9uaFhMlrSITLwHRpHJ4LMnhEkZpzNgWLzbfUgh2s=; b=UtTWIGbElGYB8PWkCaD9qeERBA
	JzNYL5yOPRtRaxee6hV2OhCjO67hq99i70F18duj2nwFKtymWTQD/96M4gyBsmGAnZ4VLO5sbWCuR
	fqYZkwJr0zvyAR6Rz32hYdCRmByubFU3GLmoojhNTF82/zX6cRQA6c3KqEHpm1xK38p9i4nh+QS5U
	mcVeXaB1IS/2wGvJx9Zua3+ikGkhdsbpYjS2FN0vdgM91t6sacnf4ABumGtA8edJs3fgttCDvV1em
	0X8EWNtACJOUe2hJe36xY60et4q9t0XCPFRaX6k/NOLHyg4LC896xsqQwFf6kZqvOnk+O+k8pDPGw
	sf98XLcg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiQFw-0000000CQHL-0PdV;
	Thu, 13 Feb 2025 03:51:16 +0000
Date: Thu, 13 Feb 2025 03:51:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/19] nfs: switch to _async for all directory ops.
Message-ID: <20250213035116.GT1977892@ZenIV>
References: <20250206054504.2950516-1-neilb@suse.de>
 <20250206054504.2950516-20-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206054504.2950516-20-neilb@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Feb 06, 2025 at 04:42:56PM +1100, NeilBrown wrote:
>  nfs_sillyrename(struct inode *dir, struct dentry *dentry)
>  {
>  	static unsigned int sillycounter;
> @@ -447,7 +451,8 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
>  	struct dentry *sdentry;
>  	struct inode *inode = d_inode(dentry);
>  	struct rpc_task *task;
> -	int            error = -EBUSY;
> +	struct dentry *base;
> +	int error = -EBUSY;
>  
>  	dfprintk(VFS, "NFS: silly-rename(%pd2, ct=%d)\n",
>  		dentry, d_count(dentry));
> @@ -461,10 +466,11 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
>  
>  	fileid = NFS_FILEID(d_inode(dentry));
>  
> +	base = d_find_alias(dir);

Huh?  That would better be dentry->d_parent and all operations are in
that directory, so you don't even need to grab a reference...

>  	sdentry = NULL;
>  	do {
>  		int slen;
> -		dput(sdentry);
> +
>  		sillycounter++;
>  		slen = scnprintf(silly, sizeof(silly),
>  				SILLYNAME_PREFIX "%0*llx%0*x",
> @@ -474,14 +480,19 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
>  		dfprintk(VFS, "NFS: trying to rename %pd to %s\n",
>  				dentry, silly);
>  
> -		sdentry = lookup_one_len(silly, dentry->d_parent, slen);
> -		/*
> -		 * N.B. Better to return EBUSY here ... it could be
> -		 * dangerous to delete the file while it's in use.
> -		 */
> -		if (IS_ERR(sdentry))
> -			goto out;
> -	} while (d_inode(sdentry) != NULL); /* need negative lookup */
> +		sdentry = lookup_and_lock_one(NULL, silly, slen,
> +					      base,
> +					      LOOKUP_CREATE | LOOKUP_EXCL
> +					      | LOOKUP_RENAME_TARGET
> +					      | LOOKUP_PARENT_LOCKED);
> +	} while (PTR_ERR_OR_ZERO(sdentry) == -EEXIST); /* need negative lookup */

What's wrong with sdentry == ERR_PTR(-EEXIST)?

