Return-Path: <linux-fsdevel+bounces-76577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BlzCJPfhWnFHgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 13:33:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3B8FD9F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 13:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC5F03033D3D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 12:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD48F3A9D9F;
	Fri,  6 Feb 2026 12:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcLcHrFU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680982848A8;
	Fri,  6 Feb 2026 12:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770381187; cv=none; b=XvwlGXgZyw9YaqQ9DsugtEw2RSHHH2Z5FaDwg7zaxACQaq/4ITpX3SYJydNsIXUijWaCfTitp8c8L2Ty14s4T7GIEUz7alOfAC4o9jPtsn1Y3e0CSzzVA81bjJMeLM2hsLAiQwOLVOMQJy9dC2yGA5OVr7yIdEie3r4cP1Flb0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770381187; c=relaxed/simple;
	bh=gSmF7pi8WQ8aARRlt/FySFKhBoJ2Omx/PirWEVZGtHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmXOJyMXAR+d1AZmVa0wVh/utehqMhulNwSE8T+zu6eC7TKFZTcUzj1afua1YONzAjve4pGHYF/vO2Qec6OhGpj5q3qtGFOcQ/3NE+bmpBKBlpddIhGqCUXa2lhIyYRrxmNteg2E8YyN2bx8FrmLoolfeo2BOoN80W61gFwnmps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcLcHrFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC87C116C6;
	Fri,  6 Feb 2026 12:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770381187;
	bh=gSmF7pi8WQ8aARRlt/FySFKhBoJ2Omx/PirWEVZGtHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VcLcHrFUxCL9Ob78SoV+oJ7iEPx99a47Qd6UCVRuiWKujIfSZeyFOVIPemHrnQigb
	 nzpTzvPG33esU/bj45DDA+EpnaZtm4VDIO5JQpPjEL5LwiQqklEc67OaEf7y6ckRUX
	 lKHRY9609OyVakq6PAEgSvLI3AomtywpTMIOGJyKzuPNOhTaziGkUHKppErUqaGwnG
	 muMUWP+v2l2yqNkabmxFpLSxoKvbYfDxyJNc2xoKUbX/PxkHCOBmkonfpMxmGugSGG
	 620dPxXRimHh/6Ew/ZKxfPbBthWJMhWg0bDy++e2IDaGSxz8yn7guhfo9g+Lub2Xfz
	 Un8H6uSKReWYw==
Date: Fri, 6 Feb 2026 13:32:59 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: ast@kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH] bpf: use FS_USERNS_DELEGATABLE for bpffs
Message-ID: <20260206-gelenk-gierig-82ad15ec8080@brauner>
References: <20260205104541.171034-1-alexander@mihalicyn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260205104541.171034-1-alexander@mihalicyn.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76577-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,vger.kernel.org,futurfusion.io];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[futurfusion.io:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 7F3B8FD9F3
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 11:45:41AM +0100, Alexander Mikhalitsyn wrote:
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> 
> Instead of FS_USERNS_MOUNT we should use recently introduced
> FS_USERNS_DELEGATABLE cause it better expresses what we
> really want to get there. Filesystem should not be allowed
> to be mounted by an unprivileged user, but at the same time
> we want to have sb->s_user_ns to point to the container's
> user namespace, at the same time superblock can only
> be created if capable(CAP_SYS_ADMIN) check is successful.
> 
> Tested and no regressions noticed.
> 
> No functional change intended.
> 
> Link: https://lore.kernel.org/linux-fsdevel/6dd181bf9f6371339a6c31f58f582a9aac3bc36a.camel@kernel.org [1]
> Fixes: 6fe01d3cbb92 ("bpf: Add BPF token delegation mount options to BPF FS")
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: bpf@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> - RWB-tag from Jeff [1]
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> ---
>  kernel/bpf/inode.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index 9f866a010dad..d8dfdc846bd0 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -1009,10 +1009,6 @@ static int bpf_fill_super(struct super_block *sb, struct fs_context *fc)
>  	struct inode *inode;
>  	int ret;
>  
> -	/* Mounting an instance of BPF FS requires privileges */
> -	if (fc->user_ns != &init_user_ns && !capable(CAP_SYS_ADMIN))
> -		return -EPERM;

Jeff's patch does:

        if (user_ns != &init_user_ns &&
            !(fc->fs_type->fs_flags & (FS_USERNS_MOUNT | FS_USERNS_DELEGATABLE))) {
                errorfc(fc, "VFS: Mounting from non-initial user namespace is not allowed");
                return ERR_PTR(-EPERM);
        }

IOW, it only restricts the ability to end up in bpf_fill_super() if
FS_USERNS_DELEGATABLE is set. You still need to perform the permission
check in bpf_fill_super() though otherwise anyone can mount bpffs in an
unprivileged container now.

So either Jeff's patch needs to be changed to require
capable(CAP_SYS_ADMIN) when FS_USERNS_DELEGATABLE is set (which makes
sense to me in general) or the check needs to remain n bpf_fill_super().

@Jeff do you require capable(CAP_SYS_ADMIN) from within nfs? I think you
somehow must because otherwise what prevents a container from mounting
arbitrary servers?

> -
>  	ret = simple_fill_super(sb, BPF_FS_MAGIC, bpf_rfiles);
>  	if (ret)
>  		return ret;
> @@ -1085,7 +1081,7 @@ static struct file_system_type bpf_fs_type = {
>  	.init_fs_context = bpf_init_fs_context,
>  	.parameters	= bpf_fs_parameters,
>  	.kill_sb	= bpf_kill_super,
> -	.fs_flags	= FS_USERNS_MOUNT,
> +	.fs_flags	= FS_USERNS_DELEGATABLE,
>  };
>  
>  static int __init bpf_init(void)
> -- 
> 2.47.3
> 

