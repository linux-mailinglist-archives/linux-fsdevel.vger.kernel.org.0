Return-Path: <linux-fsdevel+bounces-41556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57659A31C93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 04:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5285F7A1B15
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 03:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB641DA60F;
	Wed, 12 Feb 2025 03:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vw7+tZGw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4879E200B0;
	Wed, 12 Feb 2025 03:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330180; cv=none; b=me+nWuJwtoL380tsxjgYyi8i2QnWMdFS4BfI5n4RX+Bsi0XiI67UMPvqfouHs8yLLxh3Okqxv+G6Cao2M+mz3gsh1tvsdx6uOnzLOKOxSnE0qnf1w9j9xEw0b6FlSNezvHW9KlZAJ6n05rhP2ec/CRjozDx461tla5JIe7H0xds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330180; c=relaxed/simple;
	bh=INSVmT/K/ugtbfXUiYtmq6bSoqe6domYSUBpyMqhb7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmkAuHa6B+frHKSc5qTSwX60m18HkigcpwlcEc87PgQc8ZYTc9LVmTsOkoFWkTRx0FYE9vEoNTpobdx6hvm2jcTJS3SJ4OBZCuX5/pAYb3KcoFPZq/HgNXKnHFjAsprt2n4yXZOGi5igV/WwqBogo5gVdgRCGmYtX4sA3qOVSfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vw7+tZGw; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UlwxVjRFBSo7WnlGvS4b2NiGDpuj88VtmNArNF5suvU=; b=vw7+tZGwQgAuXyefJmaK9Ym5Cf
	5kf/meh6s4xLoKFDtRlGps/wkjn3dJP+8cVmzIcvSLUm5nw4+42sVD3re0uNCrx/pfNF7q2gthGQ/
	4PxjfSU5jSlr+oRkhxfQw3vjWVCdDkMouXvWnORD/IAKDFJzqoFdyHgwFXjWNcekvkrheD3VX/DXw
	6/10C/EOZS0ZxmgOIpBN2yFuNHPwmv9xDmaB1J9df8G7Q3aL+wWQFl3N/GpKQriW0OqSmgRzr7Uzr
	g+DF2uzWcbMC3G98I5U8/BWiYs7VbmPN51vQdByyVa4X9KYyqlLH2LTclTdlC9l/cDzEJv1+PY7FV
	wGHLGmbw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1ti3EO-0000000BCcq-0vG9;
	Wed, 12 Feb 2025 03:16:08 +0000
Date: Wed, 12 Feb 2025 03:16:08 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <sfrench@samba.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>, Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	audit@vger.kernel.org
Subject: Re: [PATCH 2/2] VFS: add common error checks to
 lookup_one_qstr_excl()
Message-ID: <20250212031608.GL1977892@ZenIV>
References: <20250207034040.3402438-1-neilb@suse.de>
 <20250207034040.3402438-3-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207034040.3402438-3-neilb@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 07, 2025 at 02:36:48PM +1100, NeilBrown wrote:
> @@ -1690,6 +1692,15 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
>  		dput(dentry);
>  		dentry = old;
>  	}
> +found:

... and if ->lookup() returns an error, this will blow up (as bot has just
reported).

> +	if (d_is_negative(dentry) && !(flags & LOOKUP_CREATE)) {
> +		dput(dentry);
> +		return ERR_PTR(-ENOENT);
> +	}
> +	if (d_is_positive(dentry) && (flags & LOOKUP_EXCL)) {
> +		dput(dentry);
> +		return ERR_PTR(-EEXIST);
> +	}


> @@ -4077,27 +4084,13 @@ static struct dentry *filename_create(int dfd, struct filename *name,
>  	 * '/', and a directory wasn't requested.
>  	 */
>  	if (last.name[last.len] && !want_dir)
> -		create_flags = 0;
> +		create_flags &= ~LOOKUP_CREATE;

See the patch I've posted in earlier thread; the entire "strip LOOKUP_CREATE"
thing is wrong.

