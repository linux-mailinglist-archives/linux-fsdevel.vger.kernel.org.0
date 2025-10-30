Return-Path: <linux-fsdevel+bounces-66424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC93C1E89E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 07:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604AF1892770
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 06:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1F33115AF;
	Thu, 30 Oct 2025 06:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WnkiTq6p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F1720C001;
	Thu, 30 Oct 2025 06:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761805340; cv=none; b=FBAzSIJ7cbUmN/G8DcPbhYiixvR8E1eQgCmx84eWbzi+bKIwiMjmBrtjhnb0/M8jt5G5Sgy7rj4jQy4KbhR7+w2P+vROXB+8tWnNfHnsmcPcAWSjWa5dJaLNu1rSQo3Gsf3N/HubaPt2mSqzGDO1RVh9xNVoirj1cdJSMVgqDVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761805340; c=relaxed/simple;
	bh=H7w9rChCeFQhpDhI5O6avDItW2h4+IeSwyuf+KYa2S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGBfzcsCurJdgKuevnhw+wq6XDohBiFkX/COj9nyroxbQwxtgUuMHGSjm/ep0JTPfSIL17VHD+v3RqAvQDTYnLGZhQ6fUrX0LmRPfIqhrGC6nVd20grm2232Ka70XgA1w12WEUjfWhoFAFgN83j9xsA3KKvq3LiaenRKTWnm6Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WnkiTq6p; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=azjiGcIYmmF6n03ei+Xo/vEfAhUKiS2vQVDPHjb0ew4=; b=WnkiTq6pz7Uq+OV+DsiIUevN2v
	i4+1c+tR3Dcm17P/LaJSarjfL1Ugsvl96B4DrMx4AF+Lf2EbLJPA9Z219Zt8heh32e+kriF1tpzK/
	ic5t92bpfL26TrynBB3H1Dkiv2CaNMiGj2l5UcXxTdzm8P4TAiTSWeMuVHy6aYs+KxZ0qOiCGuGZu
	x+LN+vLHwa5HFUMGcsuHAUi8LRqGYkE75CwT+/qIMNR+qnqmzzQu3rDFK4NQq8wt6Ajt1teqJvyUD
	BMeKZDuHoqipMl6gzKBGBP2AbBjRKNHiqqwA2AWP7rI6OkYdM838pXi+YMpM/1Fotug43yVl9A53g
	TxKypknw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEM34-00000008yCG-1FE4;
	Thu, 30 Oct 2025 06:22:14 +0000
Date: Thu, 30 Oct 2025 06:22:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Carlos Maiolino <cem@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev, ecryptfs@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-xfs@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH v4 11/14] Add start_renaming_two_dentries()
Message-ID: <20251030062214.GW2441659@ZenIV>
References: <20251029234353.1321957-1-neilb@ownmail.net>
 <20251029234353.1321957-12-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029234353.1321957-12-neilb@ownmail.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Oct 30, 2025 at 10:31:11AM +1100, NeilBrown wrote:

> +++ b/fs/debugfs/inode.c

Why does debugfs_change_name() need any of that horror?  Seriously, WTF?
This is strictly a name change on a filesystem that never, ever moves
anything from one directory to another.

IMO struct renamedata is a fucking eyesore, but that aside, this:

> @@ -539,22 +540,30 @@ static int sel_make_policy_nodes(struct selinux_fs_info *fsi,
>  	if (ret)
>  		goto out;
>  
> -	lock_rename(tmp_parent, fsi->sb->s_root);
> +	rd.old_parent = tmp_parent;
> +	rd.new_parent = fsi->sb->s_root;
>  
>  	/* booleans */
> -	d_exchange(tmp_bool_dir, fsi->bool_dir);
> +	ret = start_renaming_two_dentries(&rd, tmp_bool_dir, fsi->bool_dir);
> +	if (!ret) {
> +		d_exchange(tmp_bool_dir, fsi->bool_dir);
>  
> -	swap(fsi->bool_num, bool_num);
> -	swap(fsi->bool_pending_names, bool_names);
> -	swap(fsi->bool_pending_values, bool_values);
> +		swap(fsi->bool_num, bool_num);
> +		swap(fsi->bool_pending_names, bool_names);
> +		swap(fsi->bool_pending_values, bool_values);
>  
> -	fsi->bool_dir = tmp_bool_dir;
> +		fsi->bool_dir = tmp_bool_dir;
> +		end_renaming(&rd);
> +	}
>  
>  	/* classes */
> -	d_exchange(tmp_class_dir, fsi->class_dir);
> -	fsi->class_dir = tmp_class_dir;
> +	ret = start_renaming_two_dentries(&rd, tmp_class_dir, fsi->class_dir);
> +	if (ret == 0) {
> +		d_exchange(tmp_class_dir, fsi->class_dir);
> +		fsi->class_dir = tmp_class_dir;
>  
> -	unlock_rename(tmp_parent, fsi->sb->s_root);
> +		end_renaming(&rd);
> +	}
>  
>  out:
>  	sel_remove_old_bool_data(bool_num, bool_names, bool_values);

is very interesting - suddenly you get two non-overlapping scopes instead of one.
Why is that OK?

