Return-Path: <linux-fsdevel+bounces-17436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FDE8AD54B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 21:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE921F21846
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 19:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0AB1553A6;
	Mon, 22 Apr 2024 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="qFvFBWZe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8041552E4;
	Mon, 22 Apr 2024 19:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815609; cv=none; b=Wb7WzxeUPcVHx4C660txyqITUIIaIMhT4kwnEXDqKoi2xMLbEnbGzhUgmK1ZdlwdBz8Nc8cASaf/pWnXiE3lY2tDHuuT1JeGF4o+EJzqPd6w0EMY5wBoTgEkULEFvbTc+OkYiYVA1WJaZZttFuoddqlZw9Ys6NJrTZW2vHlNkNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815609; c=relaxed/simple;
	bh=QHYMX6tdJG+mRM0qyDMI2R+TdZ5IUc9W/NIaN57xmYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LE2UDnnuYMvDAKYvf178taQ1xn8F55Zw9VuHIAlqI2dKQ2ObDL3TVJ+UOYQ483MZMbUv9gxKk9dKPfhSN3LVDWRc1O7nJtSM8IKghNCe3yBZGkfhfzNTS1E26h/Q1uDpT0aR1gSd1v0QCfAonZP0CxUuhMUMj3KH105Xe/jySTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=qFvFBWZe; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=rv+66gcI4sXsOSXmrSarZddjvUON0HTal1+nUFh2yhs=; b=qFvFBWZeuTqFnTwW/02h0Smt6D
	z8SQnRRIgbuZQe2/2qdCn+5dG/L7zXp5VGm206s+FvoGJH7n2z7gAPPsFIkL3aUz3ImK7AGa32jqB
	rF7eNRfaD6wdXMlOSE/uPQ2pj25pp/pxXIIFvY6gs31YJhsT1UTfHNPsVx4iP/BUxN79o+oFSYPqc
	Sxyj383bNpgpDExmmJ6OD85tZtfqZd0sq/3oGteCF3VoQ4gAUr2hdnwqShOBpj5pZ0gJzhddz3R9s
	8OtLNsxm97/yLRCBnFq41uJQnNraOvye0/ynR83usz2qtLfStXoKsIOlRUhWE5rTlIhH9Y3vzcZGW
	ExRBF6RcsViBdrqc/5aOLYnGCoxSWyDik6HovoPF7vxSH/HEKZUx0y0/B9/NeSZHF1hV4TZoF7K+y
	dlUo6iUJJ4jmeaLq68o8dTF99VG7y+vqA5tgeRvfgMgQM/ccVfmRud5fh2p/dXmkSKXJRSLH7GekF
	cC2nc6E2dd/kPPY9Vr+fZhg+;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1ryzj1-007kbw-2m;
	Mon, 22 Apr 2024 19:53:15 +0000
Message-ID: <81ab6c6a-0a9e-4f2f-b455-7585283acf53@samba.org>
Date: Mon, 22 Apr 2024 21:53:14 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] openat2: add OA2_INHERIT_CRED flag
To: Stas Sergeev <stsp2@yandex.ru>, linux-kernel@vger.kernel.org
Cc: Eric Biederman <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 Jens Axboe <axboe@kernel.dk>
References: <20240422084505.3465238-1-stsp2@yandex.ru>
 <20240422084505.3465238-2-stsp2@yandex.ru>
Content-Language: en-US, de-DE
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20240422084505.3465238-2-stsp2@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.04.24 um 10:45 schrieb Stas Sergeev:
> This flag performs the open operation with the fsuid/fsgid that
> were in effect when dir_fd was opened.
> This allows the process to pre-open some directories and then
> change eUID (and all other UIDs/GIDs) to a less-privileged user,
> retaining the ability to open/create files within these directories.
> 
> Design goal:
> The idea is to provide a very light-weight sandboxing, where the
> process, without the use of any heavy-weight techniques like chroot
> within namespaces, can restrict the access to the set of pre-opened
> directories.
> This patch is just a first step to such sandboxing. If things go
> well, in the future the same extension can be added to more syscalls.
> These should include at least unlinkat(), renameat2() and the
> not-yet-upstreamed setxattrat().
> 
> Security considerations:
> To avoid sandboxing escape, this patch makes sure the restricted
> lookup modes are used. Namely, RESOLVE_BENEATH or RESOLVE_IN_ROOT.
> To avoid leaking creds across exec, this patch requires O_CLOEXEC
> flag on a directory.
> 
> Use cases:
> Virtual machines that deal with untrusted code, can use that
> instead of a more heavy-weighted approaches.
> Currently the approach is being tested on a dosemu2 VM.
> 
> Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
> 
> CC: Eric Biederman <ebiederm@xmission.com>
> CC: Alexander Viro <viro@zeniv.linux.org.uk>
> CC: Andy Lutomirski <luto@kernel.org>
> CC: Christian Brauner <brauner@kernel.org>
> CC: Jan Kara <jack@suse.cz>
> CC: Jeff Layton <jlayton@kernel.org>
> CC: Chuck Lever <chuck.lever@oracle.com>
> CC: Alexander Aring <alex.aring@gmail.com>
> CC: linux-fsdevel@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Christian Göttsche <cgzones@googlemail.com>
> ---
>   fs/file_table.c              |  2 ++
>   fs/internal.h                |  2 +-
>   fs/namei.c                   | 54 ++++++++++++++++++++++++++++++++++--
>   fs/open.c                    |  2 +-
>   include/linux/fcntl.h        |  2 ++
>   include/linux/fs.h           |  2 ++
>   include/uapi/linux/openat2.h |  3 ++
>   7 files changed, 63 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 4f03beed4737..9991bdd538e9 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -160,6 +160,8 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
>   	mutex_init(&f->f_pos_lock);
>   	f->f_flags = flags;
>   	f->f_mode = OPEN_FMODE(flags);
> +	f->f_fsuid = cred->fsuid;
> +	f->f_fsgid = cred->fsgid;
>   	/* f->f_version: 0 */
>   
>   	/*
> diff --git a/fs/internal.h b/fs/internal.h
> index 7ca738904e34..692b53b19aad 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -169,7 +169,7 @@ static inline void sb_end_ro_state_change(struct super_block *sb)
>    * open.c
>    */
>   struct open_flags {
> -	int open_flag;
> +	u64 open_flag;
>   	umode_t mode;
>   	int acc_mode;
>   	int intent;
> diff --git a/fs/namei.c b/fs/namei.c
> index 2fde2c320ae9..d1db6ceee4bd 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -586,6 +586,8 @@ struct nameidata {
>   	int		dfd;
>   	vfsuid_t	dir_vfsuid;
>   	umode_t		dir_mode;
> +	kuid_t		dir_open_fsuid;
> +	kgid_t		dir_open_fsgid;
>   } __randomize_layout;
>   
>   #define ND_ROOT_PRESET 1
> @@ -2414,6 +2416,8 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
>   			get_fs_pwd(current->fs, &nd->path);
>   			nd->inode = nd->path.dentry->d_inode;
>   		}
> +		nd->dir_open_fsuid = current_cred()->fsuid;
> +		nd->dir_open_fsgid = current_cred()->fsgid;

I'm wondering if it would be better to capture the whole cred structure.

Similar to io_register_personality(), which uses get_current_cred().

Only using uid and gid, won't reflect any group memberships or capabilities...

metze

