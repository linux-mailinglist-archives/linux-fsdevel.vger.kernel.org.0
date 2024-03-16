Return-Path: <linux-fsdevel+bounces-14561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE4987DC0F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 01:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29844281AC2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 00:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48931EA80;
	Sun, 17 Mar 2024 00:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="sz5iLA43"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2538462;
	Sun, 17 Mar 2024 00:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710633641; cv=none; b=EP0I40UhDxAisft3WcHEyQh5dvubNVhMRxpH12xQOsCJ/e+EByNdnCL4yVxSqxu3q0A+N+1UKfjRjnVIN6ubsRxlAvsXdeGReHZIJJ4VdzGIicjtp+QCc3baYzl49gbZ8GqFkCfIfORSjIIKGPF7gdNqt+GH2TqpETyHy08jwZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710633641; c=relaxed/simple;
	bh=3VglmJR7pBVJz//WqeRpsZPQrG690Fr0wzPyYUd5sbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vx04FIYH3RJmXSx1KCExndNhDx1LGOM+auVtV1LNn/UUsQHxoNiRDgSxEQdI6fRQ0eYfh7fnfpDL+6GALdRcsM1eoH87fsUGgmSwSkf9d7knRgoB4edBemXE0nzGrf4PJ3L+S3j87HATW8xzQyNCMvqBwjmg5y38ACNo592utsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=sz5iLA43; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IIU27KbldfR6spMLwdrbrEMxsv29AK+gnKYs1K6c1xw=; b=sz5iLA43l6b/hr3cKEjVF/chiG
	0kDwg4yRZOkDXRw2jkbchoACiVUy/nDxmekugYptIhdIddq9dbfW9c213qxny1Oj2hrURJps4LwbV
	v2ZednlkntyV9ydrEFcoGziNoCyHpe03V8GDrghRCccCEa11VpTpAI2NwdeY3qDQJN7j2EkpJ2Rri
	02woV41G5loyOzYhjKpQsva8NW3N/4+zqPsMJT4MWClYD7sRyX1/Ugly9LkvxrXRjEZgYq4ecvx6b
	/e6woT6N4Bw5gW15V2VeNLcQfsgC/fKtkC89+RcLMXS6QdQc24HqDCcgSc2lLhah1f9E++8GSCmFj
	U3EHDGMQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rldtt-00AhKK-1M;
	Sat, 16 Mar 2024 23:57:17 +0000
Date: Sat, 16 Mar 2024 23:57:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>,
	Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, netfs@lists.linux.dev,
	ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC 03/24] vfs: add try_break_deleg calls for parents to
 vfs_{link,rename,unlink}
Message-ID: <20240316235717.GI538574@ZenIV>
References: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
 <20240315-dir-deleg-v1-3-a1d6209a3654@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315-dir-deleg-v1-3-a1d6209a3654@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Mar 15, 2024 at 12:52:54PM -0400, Jeff Layton wrote:
> @@ -4603,9 +4606,12 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
>  	else if (max_links && inode->i_nlink >= max_links)
>  		error = -EMLINK;
>  	else {
> -		error = try_break_deleg(inode, delegated_inode);
> -		if (!error)
> -			error = dir->i_op->link(old_dentry, dir, new_dentry);
> +		error = try_break_deleg(dir, delegated_inode);
> +		if (!error) {
> +			error = try_break_deleg(inode, delegated_inode);
> +			if (!error)
> +				error = dir->i_op->link(old_dentry, dir, new_dentry);
> +		}

A minor nit: that might be easier to follow as
		error = try_break_deleg(dir, delegated_inode);
		if (!error)
			error = try_break_deleg(inode, delegated_inode);
		if (!error)
			error = dir->i_op->link(old_dentry, dir, new_dentry);

and let the compiler deal with optimizing it - any C compiler is going to be
able to figure out that one out.  vfs_link() is a mix of those styles anyway -
we have
        if (!error && (inode->i_state & I_LINKABLE)) {
                spin_lock(&inode->i_lock);
                inode->i_state &= ~I_LINKABLE;
                spin_unlock(&inode->i_lock);
        }
immediately afterwards; might as well make that consistent, especially since
you are getting more shallow nesting that way.

