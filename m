Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1773FAAED
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 12:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbhH2Kg4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 06:36:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231945AbhH2Kgz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 06:36:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5AE060F35;
        Sun, 29 Aug 2021 10:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630233363;
        bh=ox02ScGrdYqAo7QBg65j6S+hebsczaBu8GpVm5VVajA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IxpDmGEYUZ6OWWZ7p0EbTiP80m/L30xdokgpZfcllX8dYcgBplwyScINa74DS1p0t
         Oxr2R4VgUjljy88piEIDVMzxi4/J8kExgtNZEuqvzb8eiQRqLhdMRLs14gm+t/gTDw
         sHE+plEyaY3/YNg1GF2kSrwqJNFSFr2AtHf0l079z75dAjzVhaCJGwxqAaVhxRmK/U
         2y9ZzfI63TtRmI1GEUyXEYIYlcQgUkkp0W4+RA7swosEvm7vFhjszD6lZoSAZn+nMR
         0rpz/EhrcM0UUiybapOyREoZ70mAI0JLOEaqOXN/Aq7lH7FrO2+m6Qo9yluDJfwY9z
         +3ivb7UUYwhgQ==
Received: by pali.im (Postfix)
        id 54F4CB0F; Sun, 29 Aug 2021 12:36:00 +0200 (CEST)
Date:   Sun, 29 Aug 2021 12:36:00 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v3 9/9] fs/ntfs3: Show uid/gid always in show_options()
Message-ID: <20210829103600.pfwtm5c3sdpcnzlm@pali>
References: <20210829095614.50021-1-kari.argillander@gmail.com>
 <20210829095614.50021-10-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210829095614.50021-10-kari.argillander@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sunday 29 August 2021 12:56:14 Kari Argillander wrote:
> Show options should show option according documentation when some value
> is not default or when ever coder wants. Uid/gid are problematic because
> it is hard to know which are defaults. In file system there is many
> different implementation for this problem.
> 
> Some file systems show uid/gid when they are different than root, some
> when user has set them and some show them always. There is also problem
> that what if root uid/gid change. This code just choose to show them
> always. This way we do not need to think this any more.

Hello! IIRC ntfs disk storage supports POSIX permissions and uid/gid for
files and directories. But from ntfs3 documentation it is not clear if
this ntfs3 implementation supports it or not.

Currently ntfs3 documentation says:
> https://github.com/Paragon-Software-Group/linux-ntfs3/blob/master/Documentation/filesystems/ntfs3.rst
> uid= gid= umask= Controls the default permissions for
> files/directories created after the NTFS volume is mounted.
(and looks that rst formatting is broken)

And from this description I'm not really sure what these option
controls.

For example udf filesystem also supports storing POSIX uid/gid and
supports also additional extension per file to "do not store uid" and
"do not store gid". Moreover kernel implementation has mount option
(uid= and gid=) which overrides disk's uid/gid to mount option value.
And also has mount option to allow storing new files "without uid/gid".
So there does not have to be any default for uid=/gid= like it is for
"native" POSIX filesystems (e.g. ext4).

And so interpretation of uid/gid options is not always easy; specially
if filesystem has extensions to POSIX permissions. And NTFS has it too
as it by default has in its storage (only?) NT permissions and NT SIDs.

> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> ---
>  fs/ntfs3/ntfs_fs.h | 23 ++++++++++-------------
>  fs/ntfs3/super.c   | 12 ++++--------
>  2 files changed, 14 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
> index 5df55bc733bd..a3a7d10de7cb 100644
> --- a/fs/ntfs3/ntfs_fs.h
> +++ b/fs/ntfs3/ntfs_fs.h
> @@ -60,19 +60,16 @@ struct ntfs_mount_options {
>  	u16 fs_fmask_inv;
>  	u16 fs_dmask_inv;
>  
> -	unsigned uid : 1, /* uid was set */
> -		gid : 1, /* gid was set */
> -		fmask : 1, /* fmask was set */
> -		dmask : 1, /*dmask was set*/
> -		sys_immutable : 1, /* immutable system files */
> -		discard : 1, /* issue discard requests on deletions */
> -		sparse : 1, /*create sparse files*/
> -		showmeta : 1, /*show meta files*/
> -		nohidden : 1, /*do not show hidden files*/
> -		force : 1, /*rw mount dirty volume*/
> -		noacs_rules : 1, /*exclude acs rules*/
> -		prealloc : 1 /*preallocate space when file is growing*/
> -		;
> +	unsigned fmask : 1; /* fmask was set */
> +	unsigned dmask : 1; /*dmask was set*/
> +	unsigned sys_immutable : 1; /* immutable system files */
> +	unsigned discard : 1; /* issue discard requests on deletions */
> +	unsigned sparse : 1; /*create sparse files*/
> +	unsigned showmeta : 1; /*show meta files*/
> +	unsigned nohidden : 1; /*do not show hidden files*/
> +	unsigned force : 1; /*rw mount dirty volume*/
> +	unsigned noacs_rules : 1; /*exclude acs rules*/
> +	unsigned prealloc : 1; /*preallocate space when file is growing*/
>  };
>  
>  /* special value to unpack and deallocate*/
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index d7408b4f6813..d28fab6c2297 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -287,13 +287,11 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
>  		opts->fs_uid = make_kuid(current_user_ns(), result.uint_32);
>  		if (!uid_valid(opts->fs_uid))
>  			return invalf(fc, "ntfs3: Invalid value for uid.");
> -		opts->uid = 1;
>  		break;
>  	case Opt_gid:
>  		opts->fs_gid = make_kgid(current_user_ns(), result.uint_32);
>  		if (!gid_valid(opts->fs_gid))
>  			return invalf(fc, "ntfs3: Invalid value for gid.");
> -		opts->gid = 1;
>  		break;
>  	case Opt_umask:
>  		if (result.uint_32 & ~07777)
> @@ -512,12 +510,10 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
>  	struct ntfs_mount_options *opts = sbi->options;
>  	struct user_namespace *user_ns = seq_user_ns(m);
>  
> -	if (opts->uid)
> -		seq_printf(m, ",uid=%u",
> -			   from_kuid_munged(user_ns, opts->fs_uid));
> -	if (opts->gid)
> -		seq_printf(m, ",gid=%u",
> -			   from_kgid_munged(user_ns, opts->fs_gid));
> +	seq_printf(m, ",uid=%u",
> +		  from_kuid_munged(user_ns, opts->fs_uid));
> +	seq_printf(m, ",gid=%u",
> +		  from_kgid_munged(user_ns, opts->fs_gid));
>  	if (opts->fmask)
>  		seq_printf(m, ",fmask=%04o", ~opts->fs_fmask_inv);
>  	if (opts->dmask)
> -- 
> 2.25.1
> 
