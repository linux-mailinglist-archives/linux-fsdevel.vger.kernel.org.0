Return-Path: <linux-fsdevel+bounces-74182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 09228D337DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 17:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C1003014D07
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F38394480;
	Fri, 16 Jan 2026 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V61IahxA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404D778F26;
	Fri, 16 Jan 2026 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768580918; cv=none; b=M7LhenuMIFwzFSpAv2RK2S/2FZeVv3AEF+hO2sqbYEUkxeUDlVfA1iVGdPqCMk06wLIBp7aFMdjLeA2WMBciAA9MRCHmSUb7w6mf41nkYW2YJ558erSAtL2t1mqwTF+8kN5ZMYolAJ1qPPaLqzTuY9ER1KvHOfGqgIIVPlZvtM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768580918; c=relaxed/simple;
	bh=emssq0J6ea7jEtGqU3WDaRI3oDfJ5THOl2npfcrwHLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kx21YgYpTT1YVucueQb6JF5HPh3JnrmHpIjvtlH8mtZUJZlDqN2KqSk1y14jUdnjSzzgVH2IMpXeKYxWhYjI0D3gjt9I6/E6o1JpmvtBRX/CAKwSE9BxtjR9sP/6isCO25tsuzcef/QJ31qZytk7eID3Vye6t8oFHeafKud53wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V61IahxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD94EC116C6;
	Fri, 16 Jan 2026 16:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768580917;
	bh=emssq0J6ea7jEtGqU3WDaRI3oDfJ5THOl2npfcrwHLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V61IahxAxIzGQsl73bExGkWxGGN8v3fMcwf4WrZ4kvMdDpMFxwKA2TMFjfE7WrFl4
	 gr7qUZxh/0Lfdky3D5zJpPAKLfJgXhqXCfgD4LnaytZ0+xR7ztoZGx5jIYELcmsvQt
	 XY8Q5LQGYqg3Pthq7p8sv0rlw65W4NJD+LxMZhsyLUZ8gf1z4OmiBZTuFZRmCll8NY
	 yOtr3ItpBA/yv7BIZRGSKEUd4oQS8SHtW0osVhvpkGc+3H6rTr1CM/TwrujmyLtJPB
	 gS+JirYc8AHy6RfnCCAG95i66M74ntO4V6Dpuyb+yF30QwyQwbsche2NI22HuQXAOh
	 aoHdz97LpIvAw==
Date: Fri, 16 Jan 2026 08:28:37 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org,
	sj1557.seo@samsung.com, yuezhang.mo@sony.com,
	almaz.alexandrovich@paragon-software.com, slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu,
	adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org,
	pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com,
	trondmy@kernel.org, anna@kernel.org, jaegeuk@kernel.org,
	chao@kernel.org, hansg@kernel.org, senozhatsky@chromium.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v5 01/16] fs: Add case sensitivity info to file_kattr
Message-ID: <20260116162837.GX15551@frogsfrogsfrogs>
References: <20260116144616.2098618-1-cel@kernel.org>
 <20260116144616.2098618-2-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116144616.2098618-2-cel@kernel.org>

On Fri, Jan 16, 2026 at 09:46:00AM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Enable upper layers such as NFSD to retrieve case sensitivity
> information from file systems by adding case_insensitive and
> case_nonpreserving boolean fields to struct file_kattr.
> 
> The case_insensitive and case_nonpreserving fields in struct
> file_kattr default to false (POSIX semantics: case-sensitive and
> case-preserving), allowing filesystems to set them only when
> behavior differs from the default.
> 
> Case sensitivity information is exported to userspace via the
> existing fa_xflags field using the new FS_XFLAG_CASEFOLD and
> FS_XFLAG_CASENONPRESERVING flags.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/file_attr.c           | 6 ++++++
>  include/linux/fileattr.h | 6 +++++-
>  include/uapi/linux/fs.h  | 2 ++
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index 13cdb31a3e94..2f83f3c6a170 100644
> --- a/fs/file_attr.c
> +++ b/fs/file_attr.c
> @@ -84,6 +84,8 @@ int vfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
>  	struct inode *inode = d_inode(dentry);
>  	int error;
>  
> +	memset(fa, 0, sizeof(*fa));

Hrm.  If you're going to memset the file_kattr here, then you might as
well remove the memset calls from fileattr_fill_*.  It's not great
that filesystems have to know that a "fill_xflags" function assigns to
more than just xflags.

> +
>  	if (!inode->i_op->fileattr_get)
>  		return -ENOIOCTLCMD;
>  
> @@ -106,6 +108,10 @@ static void fileattr_to_file_attr(const struct file_kattr *fa,
>  	fattr->fa_nextents = fa->fsx_nextents;
>  	fattr->fa_projid = fa->fsx_projid;
>  	fattr->fa_cowextsize = fa->fsx_cowextsize;
> +	if (fa->case_insensitive)
> +		fattr->fa_xflags |= FS_XFLAG_CASEFOLD;
> +	if (fa->case_nonpreserving)
> +		fattr->fa_xflags |= FS_XFLAG_CASENONPRESERVING;
>  }
>  
>  /**
> diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
> index f89dcfad3f8f..7f2e557255ce 100644
> --- a/include/linux/fileattr.h
> +++ b/include/linux/fileattr.h
> @@ -16,7 +16,8 @@
>  
>  /* Read-only inode flags */
>  #define FS_XFLAG_RDONLY_MASK \
> -	(FS_XFLAG_PREALLOC | FS_XFLAG_HASATTR)
> +	(FS_XFLAG_PREALLOC | FS_XFLAG_HASATTR | \
> +	 FS_XFLAG_CASEFOLD | FS_XFLAG_CASENONPRESERVING)
>  
>  /* Flags to indicate valid value of fsx_ fields */
>  #define FS_XFLAG_VALUES_MASK \
> @@ -51,6 +52,9 @@ struct file_kattr {
>  	/* selectors: */
>  	bool	flags_valid:1;
>  	bool	fsx_valid:1;
> +	/* case sensitivity behavior: */
> +	bool	case_insensitive:1;
> +	bool	case_nonpreserving:1;

Er... if you're encoding fs name handling qualities through FS_XFLAG_*,
then filesystems can set them in fsx_xflags directly.  No need for
separate bitfields here.

--D

>  };
>  
>  int copy_fsxattr_to_user(const struct file_kattr *fa, struct fsxattr __user *ufa);
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 66ca526cf786..919148beaa8c 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -253,6 +253,8 @@ struct file_attr {
>  #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
>  #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
>  #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
> +#define FS_XFLAG_CASEFOLD	0x00020000	/* case-insensitive lookups */
> +#define FS_XFLAG_CASENONPRESERVING 0x00040000	/* case not preserved */
>  #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
>  
>  /* the read-only stuff doesn't really belong here, but any other place is
> -- 
> 2.52.0
> 
> 

