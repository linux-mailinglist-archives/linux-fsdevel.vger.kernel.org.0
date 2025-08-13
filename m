Return-Path: <linux-fsdevel+bounces-57628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D68BAB23FB6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 06:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624891A28314
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 04:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E3C28DF34;
	Wed, 13 Aug 2025 04:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ujmrmz11"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D00322E;
	Wed, 13 Aug 2025 04:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755059745; cv=none; b=CPzBWNsrPJNtYFM5dPoklylE1sFB1oZ9WpFHIC0kmzsc1TZ9RQjNS2fetwaQ2PFWhqJkr9yHtwRg+22wXDjXBxosUm/rvkCBLHzbGv3GCLj8BbjGe0MgTSZp29W50W7ROncnA/YuoECKVqJQLeQpjz5zGySFWpJCXDVblrjR670=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755059745; c=relaxed/simple;
	bh=lJKH8zuUwITkarJ88KZ86WorioJPXOW6GCe1uPUSAFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooOVc7n7cbR0jls8fRMjukBJazs982z5KTaCKmWujfAxjkvkxwY00g5NcbTFMgtByVyKw3Om4obyupKP5L1VvblVwPzNW6Aid367VJO2i/QpjMDAOG5BiMwb1+AwExHgesgebybNrWXuLemQB0JgleJWyly0BytEU1aieCKt8HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ujmrmz11; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aRQkeMIJcBi46dPSzyGTrE1yBGlZq8YhFhum8N0qOrw=; b=ujmrmz11odENyDWGsZ1doM1O+f
	Y8ohhQgxpLyQKXG15byzsNdiRPYTU2zjMSPKRiQj9M2Vh/dybrcLfUq5PbhHBnboxJP0WGDDlEvPi
	9A0xCErpXxD/sCmgR/G6U1czvOMozgADIzBP0WPwWJcJ55+0S3b16WBTOXGVpD1dm/0qSjiVhOK8S
	hPD9tROH5z80h2NfCQgdGE9rnf1DLujv4uajWPj45NRmRQrTUwUfZF7SwWiH99gMj8yBP8MCSJQa2
	2NSW2NVY+PxFuXpDX1ydVTKsVlg/Vj7u0O/3wtNnbUnz2Hjo3oWnH+uv+5AaXC+VZN61DnqItTGmC
	iI4u5yNw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um3D2-00000005eKo-04E4;
	Wed, 13 Aug 2025 04:35:32 +0000
Date: Wed, 13 Aug 2025 05:35:31 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Tyler Hicks <code@tyhicks.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org, netfs@lists.linux.dev,
	ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
	linux-um@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] VFS: add rename_lookup()
Message-ID: <20250813043531.GB222315@ZenIV>
References: <20250812235228.3072318-1-neil@brown.name>
 <20250812235228.3072318-6-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812235228.3072318-6-neil@brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 12, 2025 at 12:25:08PM +1000, NeilBrown wrote:
> rename_lookup() combines lookup and locking for a rename.
> 
> Two names - new_last and old_last - are added to struct renamedata so it
> can be passed to rename_lookup() to have the old and new dentries filled
> in.
> 
> __rename_lookup() in vfs-internal and assumes that the names are already
> hashed and skips permission checking.  This is appropriate for use after
> filename_parentat().
> 
> rename_lookup_noperm() does hash the name but avoids permission
> checking.  This will be used by debugfs.

WTF would debugfs do anything of that sort?  Explain.  Unlike vfs_rename(),
there we
	* are given the source dentry
	* are limited to pure name changes - same-directory only and
target must not exist.
	* do not take ->s_vfs_rename_mutex
	...

> If either old_dentry or new_dentry are not NULL, the corresponding
> "last" is ignored and the dentry is used as-is.  This provides similar
> functionality to dentry_lookup_continue().  After locks are obtained we
> check that the parent is still correct.  If old_parent was not given,
> then it is set to the parent of old_dentry which was locked.  new_parent
> must never be NULL.

That screams "bad API" to me...  Again, I want to see the users; you are
asking to accept a semantics that smells really odd, and it's impossible
to review without seeing the users.

> On success new references are geld on old_dentry, new_dentry and old_parent.
> 
> done_rename_lookup() unlocks and drops those three references.
> 
> No __free() support is provided as done_rename_lookup() cannot be safely
> called after rename_lookup() returns an error.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/namei.c            | 318 ++++++++++++++++++++++++++++++++++--------
>  include/linux/fs.h    |   4 +
>  include/linux/namei.h |   3 +
>  3 files changed, 263 insertions(+), 62 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index df21b6fa5a0e..cead810d53c6 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3507,6 +3507,233 @@ void unlock_rename(struct dentry *p1, struct dentry *p2)
>  }
>  EXPORT_SYMBOL(unlock_rename);
>  
> +/**
> + * __rename_lookup - lookup and lock names for rename
> + * @rd:           rename data containing relevant details
> + * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
> + *                LOOKUP_NO_SYMLINKS etc).
> + *
> + * Optionally look up two names and ensure locks are in place for
> + * rename.
> + * Normally @rd.old_dentry and @rd.new_dentry are %NULL and the
> + * old and new directories and last names are given in @rd.  In this
> + * case the names are looked up with appropriate locking and the
> + * results stored in @rd.old_dentry and @rd.new_dentry.
> + *
> + * If either are not NULL, then the corresponding lookup is avoided but
> + * the required locks are still taken.  In this case @rd.old_parent may
> + * be %NULL, otherwise @rd.old_dentry must still have @rd.old_parent as
> + * its d_parent after the locks are obtained.  @rd.new_parent must
> + * always be non-NULL, and must always be the correct parent after
> + * locking.
> + *
> + * On success a reference is held on @rd.old_dentry, @rd.new_dentry,
> + * and @rd.old_parent whether they were originally %NULL or not.  These
> + * references are dropped by done_rename_lookup().  @rd.new_parent
> + * must always be non-NULL and no extra reference is taken.
> + *
> + * The passed in qstrs must have the hash calculated, and no permission
> + * checking is performed.
> + *
> + * Returns: zero or an error.
> + */
> +static int
> +__rename_lookup(struct renamedata *rd, int lookup_flags)
> +{
> +	struct dentry *p;
> +	struct dentry *d1, *d2;
> +	int target_flags = LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
> +	int err;
> +
> +	if (rd->flags & RENAME_EXCHANGE)
> +		target_flags = 0;
> +	if (rd->flags & RENAME_NOREPLACE)
> +		target_flags |= LOOKUP_EXCL;
> +
> +	if (rd->old_dentry) {
> +		/* Already have the dentry - need to be sure to lock the correct parent */
> +		p = lock_rename_child(rd->old_dentry, rd->new_parent);
> +		if (IS_ERR(p))
> +			return PTR_ERR(p);
> +		if (d_unhashed(rd->old_dentry) ||
> +		    (rd->old_parent && rd->old_parent != rd->old_dentry->d_parent)) {
> +			/* dentry was removed, or moved and explicit parent requested */
> +			unlock_rename(rd->old_dentry->d_parent, rd->new_parent);
> +			return -EINVAL;
> +		}
> +		rd->old_parent = dget(rd->old_dentry->d_parent);
> +		d1 = dget(rd->old_dentry);
> +	} else {
> +		p = lock_rename(rd->old_parent, rd->new_parent);
> +		if (IS_ERR(p))
> +			return PTR_ERR(p);
> +		dget(rd->old_parent);
> +
> +		d1 = lookup_one_qstr_excl(&rd->old_last, rd->old_parent,
> +					  lookup_flags);
> +		if (IS_ERR(d1))
> +			goto out_unlock_1;
> +	}
> +	if (rd->new_dentry) {
> +		if (d_unhashed(rd->new_dentry) ||
> +		    rd->new_dentry->d_parent != rd->new_parent) {
> +			/* new_dentry was moved or removed! */
> +			goto out_unlock_2;
> +		}
> +		d2 = dget(rd->new_dentry);
> +	} else {
> +		d2 = lookup_one_qstr_excl(&rd->new_last, rd->new_parent,
> +					  lookup_flags | target_flags);
> +		if (IS_ERR(d2))
> +			goto out_unlock_2;
> +	}
> +
> +	if (d1 == p) {
> +		/* source is an ancestor of target */
> +		err = -EINVAL;
> +		goto out_unlock_3;
> +	}
> +
> +	if (d2 == p) {
> +		/* target is an ancestor of source */
> +		if (rd->flags & RENAME_EXCHANGE)
> +			err = -EINVAL;
> +		else
> +			err = -ENOTEMPTY;
> +		goto out_unlock_3;
> +	}
> +
> +	rd->old_dentry = d1;
> +	rd->new_dentry = d2;
> +	return 0;
> +
> +out_unlock_3:
> +	dput(d2);
> +	d2 = ERR_PTR(err);
> +out_unlock_2:
> +	dput(d1);
> +	d1 = d2;
> +out_unlock_1:
> +	unlock_rename(rd->old_parent, rd->new_parent);
> +	dput(rd->old_parent);
> +	return PTR_ERR(d1);
> +}

This is too fucking ugly to live, IMO.  Too many things are mixed into it.
I will NAK that until I get a chance to see the users of all that stuff.
Sorry.

