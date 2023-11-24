Return-Path: <linux-fsdevel+bounces-3746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5277F7A0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 18:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12AA3281A75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 17:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F21364A1;
	Fri, 24 Nov 2023 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s098XSVg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495682D631;
	Fri, 24 Nov 2023 17:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E892C433C7;
	Fri, 24 Nov 2023 17:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700845602;
	bh=PPv7r8G9gWCUU0EJn3vhveqcEwikXh9jLw+nzQQY9WI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s098XSVgPCPMuCM9JTGjDOF6ArkD588pr3xbbacn2qrOnd9HdljQZka8/F74S7hX/
	 NCrzX39xQUb9ZC1YaRAG/Qblvr+/P97J4ZA0u56pvC3u9G+kuEwR4nl6VwlkZy78Pt
	 psqbG3gpul7rn/IGgdWC86LMED9JYliFM2YB+zwCcpl3grRq9jv6vibKGKBot89jut
	 Tj+gLKs6zd24iD6Jzn8vw2OAum0VVLRac51PEJZjO2Ei0fRwFK/fSMxRvvbTXifNfw
	 Xq70m4AbVloSNq5hz05Q8J/FhfY9FYKrXWXUfR/MIo9HqWCCtNUzAEc+U1fypTaVxx
	 6W6AIfwVULQxA==
Date: Fri, 24 Nov 2023 18:06:34 +0100
From: Christian Brauner <brauner@kernel.org>
To: Michael =?utf-8?B?V2Vpw58=?= <michael.weiss@aisec.fraunhofer.de>
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	"Serge E. Hallyn" <serge@hallyn.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gyroidos@aisec.fraunhofer.de
Subject: Re: [RESEND RFC PATCH v2 11/14] vfs: Wire up security hooks for
 lsm-based device guard in userns
Message-ID: <20231124-neidisch-drehbaren-d80ef7aa6390@brauner>
References: <20231025094224.72858-1-michael.weiss@aisec.fraunhofer.de>
 <20231025094224.72858-12-michael.weiss@aisec.fraunhofer.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231025094224.72858-12-michael.weiss@aisec.fraunhofer.de>

On Wed, Oct 25, 2023 at 11:42:21AM +0200, Michael Weiß wrote:
> Wire up security_inode_mknod_capns() in fs/namei.c. If implemented
> and access is granted by an lsm, check ns_capable() instead of the
> global CAP_MKNOD.
> 
> Wire up security_sb_alloc_userns() in fs/super.c. If implemented
> and access is granted by an lsm, the created super block will allow
> access to device nodes also if it was created in a non-inital userns.
> 
> Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
> ---
>  fs/namei.c | 16 +++++++++++++++-
>  fs/super.c |  6 +++++-
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index f601fcbdc4d2..1f68d160e2c0 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3949,6 +3949,20 @@ inline struct dentry *user_path_create(int dfd, const char __user *pathname,
>  }
>  EXPORT_SYMBOL(user_path_create);
>  
> +static bool mknod_capable(struct inode *dir, struct dentry *dentry,
> +			  umode_t mode, dev_t dev)
> +{
> +	/*
> +	 * In case of a security hook implementation check mknod in user
> +	 * namespace. Otherwise just check global capability.
> +	 */
> +	int error = security_inode_mknod_nscap(dir, dentry, mode, dev);
> +	if (!error)
> +		return ns_capable(current_user_ns(), CAP_MKNOD);
> +	else
> +		return capable(CAP_MKNOD);
> +}
> +
>  /**
>   * vfs_mknod - create device node or file
>   * @idmap:	idmap of the mount the inode was found from
> @@ -3975,7 +3989,7 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
>  		return error;
>  
>  	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !is_whiteout &&
> -	    !capable(CAP_MKNOD))
> +	    !mknod_capable(dir, dentry, mode, dev))
>  		return -EPERM;
>  
>  	if (!dir->i_op->mknod)
> diff --git a/fs/super.c b/fs/super.c
> index 2d762ce67f6e..bb01db6d9986 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -362,7 +362,11 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
>  	}
>  	s->s_bdi = &noop_backing_dev_info;
>  	s->s_flags = flags;
> -	if (s->s_user_ns != &init_user_ns)
> +	/*
> +	 * We still have to think about this here. Several concerns exist
> +	 * about the security model, especially about malicious fuse.
> +	 */
> +	if (s->s_user_ns != &init_user_ns && security_sb_alloc_userns(s))
>  		s->s_iflags |= SB_I_NODEV;

Hm, no.

We dont want to have security hooks called in alloc_super(). That's just
the wrong layer for this. This is deeply internal stuff where we should
avoid interfacing with other subsystems.

Removing SB_I_NODEV here is also problematic or at least overly broad
because you allow to circumvent this for _every_ filesystems including
stuff like proc and so on where that doesn't make any sense.

