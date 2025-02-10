Return-Path: <linux-fsdevel+bounces-41376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F63A2E673
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 09:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E363AC004
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 08:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7191C1F02;
	Mon, 10 Feb 2025 08:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQppgUqh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7321BEF9C;
	Mon, 10 Feb 2025 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739176141; cv=none; b=XnEDrKhTgZOiS2EtVlT9OBY5i/qUEZ7V7vT4ZNsjgCPZDMzPtS7tLfYlmbFPNp5kGv1wMkC53L0jjRW8LLS9cJAPf0tj28a/hmfOMg8KlUW/ujlZaKYneTcFFBXKPlm6Oeg5Uose9zyostPYy+iSO07Y7YzK0hh26u09kHDOPus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739176141; c=relaxed/simple;
	bh=l4RQ9YXCLzheUEPVFhnzlSjNul+jf/Rzen4jrjb9uao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mN+Pj7RhQWvDPi2e9OaE4N+/ERCkI4krvw33rMKVWCVGquOO7eGMdN7VmVOT7J/kbhZ5iahf0u5DHHwjH6nRh9XavG1S0bz2HvlNl685Kj+GLkf0c/TNXjjGenaesQZHuOJdqCv+cJ5k2lS/zaQsl06i9drtrpOPl/DO0BK5fj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQppgUqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C38C4CED1;
	Mon, 10 Feb 2025 08:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739176141;
	bh=l4RQ9YXCLzheUEPVFhnzlSjNul+jf/Rzen4jrjb9uao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CQppgUqh9ELDIkdVLURO/d8M3Bknh4Qpw9aYKiQgE+5zSnd7UjtEtpCmCuVZP5j+W
	 20KNw41I5Efew5XyKgDtsKekR7T6mDhREbeWmtKdl+LC472O6gp9ShphlXnLGIi0s0
	 r1TfcH/c2bvyru1fZOo3+vT/XywDaEG67BjqqTZVqhtHS4LG6kmAbnJApLNBP8vOHU
	 E0Rm6/bSn7rb66pkXsfWyIaWe2u6TvT39wnSUPl4chXeDja5v8MXLIqDc4QtXUPtbA
	 fAfsyA1QYbVooCEtn0YOuNKaGsnL4EXF6S8pNkfCnRUFDZF5ps6tMcRIJGmgWYMdhD
	 DMFJKOnWXuNpw==
Date: Mon, 10 Feb 2025 09:28:56 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] vfs: add initial support for CONFIG_DEBUG_VFS
Message-ID: <20250210-umgibt-vorhof-5d2eb09918e2@brauner>
References: <20250209185523.745956-1-mjguzik@gmail.com>
 <20250209185523.745956-2-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250209185523.745956-2-mjguzik@gmail.com>

On Sun, Feb 09, 2025 at 07:55:20PM +0100, Mateusz Guzik wrote:
> Small collection of macros taken from mmdebug.h
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  fs/inode.c               | 15 ++++++++++++++
>  include/linux/fs.h       |  1 +
>  include/linux/vfsdebug.h | 45 ++++++++++++++++++++++++++++++++++++++++
>  lib/Kconfig.debug        |  9 ++++++++
>  4 files changed, 70 insertions(+)
>  create mode 100644 include/linux/vfsdebug.h
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 5587aabdaa5e..875e66261f06 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2953,3 +2953,18 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
>  	return mode & ~S_ISGID;
>  }
>  EXPORT_SYMBOL(mode_strip_sgid);
> +
> +#ifdef CONFIG_DEBUG_VFS
> +/*
> + * Dump an inode.
> + *
> + * TODO: add a proper inode dumping routine, this is a stub to get debug off the
> + * ground.
> + */
> +void dump_inode(struct inode *inode, const char *reason)
> +{
> +       pr_warn("%s encountered for inode %px", reason, inode);

I had already fixed that in the local tree. But thanks for resending.
I'll take v4 then.

