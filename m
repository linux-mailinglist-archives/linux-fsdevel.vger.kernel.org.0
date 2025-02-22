Return-Path: <linux-fsdevel+bounces-42330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66086A40587
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 05:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90A219C71B6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 04:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC556202C52;
	Sat, 22 Feb 2025 04:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="V0RNI5qU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44992F4FA;
	Sat, 22 Feb 2025 04:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740199305; cv=none; b=P6eyhGgf46h6oa34pmvVprj7HrQCOuU7o+o8E5+9HJcNQ/1+8wac/BYtzKjeApVy9dLk0ghid5d3s6sJ4qtMRuNe9FGAKBISfKq5gwIdkzjntfMUC43cQpU03AvTkBv7hj6xRL4SlNtN3c6E7eqqBg4NVgEU1LlJJPNaDqqtdOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740199305; c=relaxed/simple;
	bh=whnVZ6m+2crQEw5qeJxY4U/KmQXKKfEeIc+VfjknvyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4uRG6NhYKXyBR/YqRz5F4PhPhWs8a/+oVwPsngOFUmr5wQRENrL+FPnU8vGyPDhhtXuva3rVdxiEK+t1/N1zfOjgm+/AoJtZcEw/6RI+/9uqd6dzKyZcnwxUMJj/hXJiHhh9uOMcN2cF2gO1BAKZLiLSCiVyxXYPq8z59nt9M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=V0RNI5qU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ak81sfwQs82rWCjc8icmSjWD6hQCZp6KEAR3SJKFhos=; b=V0RNI5qUK23YrR10htyClgF4V1
	qbXhwFxOWEZeIRkIxGTlZvEx1MsiaQslQ7SENgBpE1twBEHKwbdzwv9bjaN+PsLSh+XhhiarJVJ1E
	OfjrFVZ+ATFjsP7YmWYyl1Og8hyiW0eqoCE1QPKxYwYXA7kcq46Ch17j5HhZyyCtmYB2coproXOCC
	ZL4NLdAPFNF1606559N3t7cbLUempsnl4t6V9SEiJAn8lQOlrFkJt3zualaWxqLJM2Go9F+cC9P0a
	VU5rCX08UcXjnbuOdSlwkQrXJPPxrpgRDnrwxt3RJ+b0jhecTdIm1fHEzF9shodT3fNMRHV7Trc5E
	IkW2Vu7g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlhKU-00000004ese-2hS3;
	Sat, 22 Feb 2025 04:41:30 +0000
Date: Sat, 22 Feb 2025 04:41:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>, Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-um@lists.infradead.org, ceph-devel@vger.kernel.org,
	netfs@lists.linux.dev
Subject: Re: [PATCH 5/6] nfs: change mkdir inode_operation to return
 alternate dentry if needed.
Message-ID: <20250222044130.GO1977892@ZenIV>
References: <20250220234630.983190-1-neilb@suse.de>
 <20250220234630.983190-6-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220234630.983190-6-neilb@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 21, 2025 at 10:36:34AM +1100, NeilBrown wrote:

>  nfs3_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *sattr)
>  {
>  	struct posix_acl *default_acl, *acl;
> @@ -612,15 +612,18 @@ nfs3_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *sattr)
>  		dentry = d_alias;
>  
>  	status = nfs3_proc_setacls(d_inode(dentry), acl, default_acl);
> +	if (status && d_alias)
> +		dput(d_alias);
>  
> -	dput(d_alias);
>  out_release_acls:
>  	posix_acl_release(acl);
>  	posix_acl_release(default_acl);
>  out:
>  	nfs3_free_createdata(data);
>  	dprintk("NFS reply mkdir: %d\n", status);
> -	return status;
> +	if (status)
> +		return ERR_PTR(status);
> +	return d_alias;

Ugh...  That's really hard to follow - you are leaving a dangling
reference in d_alias textually upstream of using that variable.
The only reason it's not a bug is that dput() is reachable only
with status && d_alias and that guarantees that we'll
actually go away on if (status) return ERR_PTR(status).

Worse, you can reach 'out:' with d_alias uninitialized.  Yes,
all such branches happen with status either still unmodified
since it's initialization (which is non-zero) or under
if (status), so again, that return d_alias; is unreachable.

So the code is correct, but it's really asking for trouble down
the road.

BTW, dput(NULL) is guaranteed to be a no-op...

