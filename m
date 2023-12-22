Return-Path: <linux-fsdevel+bounces-6787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A76481CA53
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 13:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE08DB210E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 12:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFA818C07;
	Fri, 22 Dec 2023 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0vE/2NK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8E918AE4;
	Fri, 22 Dec 2023 12:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B9DC433C8;
	Fri, 22 Dec 2023 12:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703249661;
	bh=xnZCBNtbBc/N3qG3dExSY43QJXcQr8wyxjQoqVyH48g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n0vE/2NK7fPnM8I8/QC5gElB9qNJxURYt0akcDtpB0dNHWzLrYFQyY6IXw6lUzSYD
	 bLiGxUQyLXQm7zFclRX6pq8yttEBrYGHbsV6E2BcsT5T4+3lXZrTu14oTw9aZPaDHR
	 W3L6yEsKyKPeSjffTp6tyOzGjsTRkjCT54fgIjBTyCM4K+K6s/fuVkNZgITvDw6Iqa
	 Ld4iDSdyHz3jCX1NbjdqQ1JNzl8k9x09A3s2RzklEx5gpaD33TBMPCDekpOYSx3PTM
	 uQcMvvoh/vDkD2MzhIJkTq6Nw/PP00VUaSZXGF/Q/QsNV41mrfPMndI1bJS/AstpjL
	 i26ASrc3BR6/A==
Date: Fri, 22 Dec 2023 13:54:17 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: Re: [RFC][PATCH 4/4] fs: factor out backing_file_mmap() helper
Message-ID: <20231222-gespeichert-prall-3183a634baae@brauner>
References: <20231221095410.801061-1-amir73il@gmail.com>
 <20231221095410.801061-5-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231221095410.801061-5-amir73il@gmail.com>

On Thu, Dec 21, 2023 at 11:54:10AM +0200, Amir Goldstein wrote:
> Assert that the file object is allocated in a backing_file container
> so that file_user_path() could be used to display the user path and
> not the backing file's path in /proc/<pid>/maps.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/backing-file.c            | 27 +++++++++++++++++++++++++++
>  fs/overlayfs/file.c          | 23 ++++++-----------------
>  include/linux/backing-file.h |  2 ++
>  3 files changed, 35 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/backing-file.c b/fs/backing-file.c
> index 46488de821a2..1ad8c252ec8d 100644
> --- a/fs/backing-file.c
> +++ b/fs/backing-file.c
> @@ -11,6 +11,7 @@
>  #include <linux/fs.h>
>  #include <linux/backing-file.h>
>  #include <linux/splice.h>
> +#include <linux/mm.h>
>  
>  #include "internal.h"
>  
> @@ -284,6 +285,32 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
>  }
>  EXPORT_SYMBOL_GPL(backing_file_splice_write);
>  
> +int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
> +		      struct backing_file_ctx *ctx)
> +{
> +	const struct cred *old_cred;
> +	int ret;
> +
> +	if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)) ||

Couldn't that WARN_ON_ONCE() be in every one of these helpers in this
series? IOW, when would you ever want to use a backing_file_*() helper
on a non-backing file?

