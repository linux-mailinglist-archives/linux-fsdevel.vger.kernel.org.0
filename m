Return-Path: <linux-fsdevel+bounces-14562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4067987DC18
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 01:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8312B281DF1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 00:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C72817F8;
	Sun, 17 Mar 2024 00:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="q2/txhjx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB15173;
	Sun, 17 Mar 2024 00:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710634814; cv=none; b=gajE9s6RMjowM37Si6OfU5VxMfS+WSNxflgJhxs1NLv9anGK7yFLQZMGFclcAFX2jM2HPumNwG2K9dbS8vPwK7NqUDtrj+oCQ6Xanq5OrUbFQhUKSyjCquLZNM3Qho2bGMVC0ZnbLGywd/TJZJCCo3i3gtfdd1fSNo91YCjWP3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710634814; c=relaxed/simple;
	bh=RSWZD1v5bT2/4QWHR19SfGfX5WLV0cIFofyKHF8Sx70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDxnPKnIkG13SM6iDnp4eisFc1NKToAyWhCcgRLzfDul0WSvw728KWaa8TcYnMm2MvRiqgNw8BwVQ/dkeoYVp9Js0x7aQEp0KDccrGPYEPxK6FzIvl244FdeP1E8SCrrCtt8BDbTpWkY0BM/9C222fc40qiJ7rzh9nDjaUcSlsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=q2/txhjx; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vNFR3lw8tC7KxXpl4rLTji3eLA1sO/3QyZ+IkaIx3oE=; b=q2/txhjxnqcuFklxGYkyLxcJvw
	LITqgzNsi0+rrWfMhl+X3vm3DYFjZx5Vg3SuZH4Dq8y4yQmaU7L06oNeuMijNTH51MqDtahdDyoij
	cxqoeYVtMmM0Xtp27vHfeM2c9LLMF5Ja2YleCR6dr+EyvNFcLbwvqorOAEYQB/JGt38rJs4J4+yOA
	Y3zNY0IhRV26pdZPZUglMWHY0kg5CZZj76j1dfcJoqEvAljiLxR+a60a4ln3Lv2nccnYtcblOKG6u
	J2HN+clbPRduyGz0JESVN0UrxwWCTijF7rMm3el9r+VLGq3jfaD/O7yxYub0k3fuv/zUBjzwU5GUx
	rYFZgf2g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rleFa-00Ai2U-1m;
	Sun, 17 Mar 2024 00:19:42 +0000
Date: Sun, 17 Mar 2024 00:19:42 +0000
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
Subject: Re: [PATCH RFC 06/24] vfs: break parent dir delegations in open(...,
 O_CREAT) codepath
Message-ID: <20240317001942.GJ538574@ZenIV>
References: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
 <20240315-dir-deleg-v1-6-a1d6209a3654@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315-dir-deleg-v1-6-a1d6209a3654@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Mar 15, 2024 at 12:52:57PM -0400, Jeff Layton wrote:
> In order to add directory delegation support, we need to break
> delegations on the parent whenever there is going to be a change in the
> directory.
> 
> Add a delegated_inode parameter to lookup_open and have it break the
> delegation. Then, open_last_lookups can wait for the delegation break
> and retry the call to lookup_open once it's done.

> @@ -3490,6 +3490,11 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,

Wait a sec - are you going to do anything to the atomic_open side of things?
 
>  	/* Negative dentry, just create the file */
>  	if (!dentry->d_inode && (open_flag & O_CREAT)) {
> +		/* but break the directory lease first! */
> +		error = try_break_deleg(dir_inode, delegated_inode);
> +		if (error)
> +			goto out_dput;

