Return-Path: <linux-fsdevel+bounces-42782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC362A48876
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 20:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90C41891E59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 19:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4544224BBE5;
	Thu, 27 Feb 2025 19:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QN39c1vY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9858D17A313;
	Thu, 27 Feb 2025 19:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682906; cv=none; b=vCvBYbvYHXKj2mcMLet1sQD12d4UIBSuVZ0JAqjXs90KB7NYC5c3MdN5ysFpFrarrwuuKnIjdsp7SGNRgZ8jLtJhfRYhBC4bGKqehR3atDKXDwHKEKma30o5TX2Hj3bY11uIgR31VqzB9wv4B8DLT8EbNh3o744swU6hGdS7IUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682906; c=relaxed/simple;
	bh=z2uX0uqipn42HUDO7nFkLHmTKkunvB8G3pQIRSUI+Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1PFPj9wF5byQFq+rEiqdD2jtegNzTY0ShiUm0fNMhu3/V+8TTNm250kb6AYT9/TyEGSCM95mJ88ogtBQ223KXzV0kDj3lNV/NxPWalGRl+WTzkWlBdwSpEEA7LZTBvHsIkQ2SfkT6GyT1m57oVNrov4HGlpLlanJhbkWDttEYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QN39c1vY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5149C4CEDD;
	Thu, 27 Feb 2025 19:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740682906;
	bh=z2uX0uqipn42HUDO7nFkLHmTKkunvB8G3pQIRSUI+Qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QN39c1vYxAwHPGcFalnYzSvoZb25lnxy8x6SG7Xg1OIS4Jvx4esHkW4m8Rtu1+sBy
	 9xtPjfKoqu81r9Tcl4Q5TUw199c1mDy0EziGH4Thd3eyUsgZ37ZLi3SEoaNCAzdqXC
	 MyQqXd0/i9vogmLdSRF6+7veI46X5R97mOOb1+Hbl/45KSb45W0NLGepZQbWU9M5j8
	 u+l/seZDAfkRll8uPNpBv2caTZVKH/bm9nmnDfLuPG9LTkSWZwAcWlQcr10x/N/gPS
	 1M8+C/VUaFJBc5PvqF61tYCKZBgbvBucB6PASdeKbhxLQZ3PIuhr9Ui7ZdDzHTjSC+
	 dRmXPdJQrPi+Q==
Date: Thu, 27 Feb 2025 20:01:39 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] ceph: return the correct dentry on mkdir
Message-ID: <20250227-dinge-jazzkonzert-3f68e3839fac@brauner>
References: <20250227013949.536172-1-neilb@suse.de>
 <20250227013949.536172-4-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227013949.536172-4-neilb@suse.de>

On Thu, Feb 27, 2025 at 12:32:55PM +1100, NeilBrown wrote:
> ceph already splices the correct dentry (in splice_dentry()) from the
> result of mkdir but does nothing more with it.
> 
> Now that ->mkdir can return a dentry, return the correct dentry.
> 
> Note that previously ceph_mkdir() could call
>    ceph_init_inode_acls()
> on the inode from the wrong dentry, which would be NULL.  This
> is safe as ceph_init_inode_acls() checks for NULL, but is not
> strictly correct.  With this patch, the inode for the returned dentry
> is passed to ceph_init_inode_acls().
> 
> Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/ceph/dir.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 39e0f240de06..5e98394e2dca 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -1099,6 +1099,7 @@ static struct dentry *ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	struct ceph_client *cl = mdsc->fsc->client;
>  	struct ceph_mds_request *req;
>  	struct ceph_acl_sec_ctx as_ctx = {};
> +	struc dentry *ret;

Forgot to mention that I fixed this when I applied.

