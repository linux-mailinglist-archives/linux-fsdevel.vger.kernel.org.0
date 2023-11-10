Return-Path: <linux-fsdevel+bounces-2692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E177E7887
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 04:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0855CB20F72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 03:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C818186B;
	Fri, 10 Nov 2023 03:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VfeFyRH0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7231841
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 03:56:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3A3C433C7;
	Fri, 10 Nov 2023 03:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1699588565;
	bh=IMcSxWrdruVQfP9e7fEBYYE2MC9+wNXShHGyUH6KxwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VfeFyRH08ET2E+W5qX5XYRwEVUQqsY4RUP6Ef3UW6qr7You7M4p/XZfItRT4NwYBx
	 CBelaxZt0DI2YKjkU5cMpfZ3djhZORuXyXkb2xmKCeM1fwdNXYjNkiUJ3THXFsuGsc
	 Wxdj6Q62sapBwk1plBuu8pjQsIaLj7lNTWyXBloU=
Date: Fri, 10 Nov 2023 04:56:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Nicolai Stange <nicstange@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] debugfs: only clean up d_fsdata for d_is_reg()
Message-ID: <2023111055-gratitude-prance-6074@gregkh>
References: <20231109160639.514a2568f1e7.I64fe5615568e87f9ae2d7fb2ac4e5fa96924cb50@changeid>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109160639.514a2568f1e7.I64fe5615568e87f9ae2d7fb2ac4e5fa96924cb50@changeid>

On Thu, Nov 09, 2023 at 04:06:40PM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> debugfs_create_automount() can store a function pointer in
> d_fsdata, and for directories it may be NULL. The commit
> 7c8d469877b1 ("debugfs: add support for more elaborate
> ->d_fsdata") ignored that, and while freeing NULL is just
> fine, if an automount is ever removed we'd attempt to
> kfree() the function pointer. This currently never happens
> since the only user (tracing) will never remove the
> automount dir.
> 
> Later patches changed the logic here again to store the
> real fops, and store the allocation only after a debugfs
> file reference is obtained via debugfs_file_get().
> 
> Remove debugfs_release_dentry() so we won't attempt to
> do anything common with the different uses of d_fsdata,
> and put the freeing of the allocated data where it's last
> possibly used, in __debugfs_file_removed(), which is only
> called for regular files.
> 
> Also check in debugfs_file_get() that it gets only called
> on regular files, just to make things clearer.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  fs/debugfs/file.c  |  3 +++
>  fs/debugfs/inode.c | 14 +++++---------
>  2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index 1f971c880dde..1a20c7db8e11 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -84,6 +84,9 @@ int debugfs_file_get(struct dentry *dentry)
>  	struct debugfs_fsdata *fsd;
>  	void *d_fsd;
>  
> +	if (WARN_ON(!d_is_reg(dentry)))
> +		return -EINVAL;

Note, the huge majority of Linux systems in the world run with "panic on
warn" enabled, so if this is something that could actually happen,
please just handle it and return the error, don't throw up a WARN()
splat as that will reboot the system, causing you to have grumpy users.

thanks,

greg k-h

