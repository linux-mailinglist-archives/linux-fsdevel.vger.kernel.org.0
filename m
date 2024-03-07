Return-Path: <linux-fsdevel+bounces-13929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EF1875906
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 22:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54A94B210DE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 21:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBF313A268;
	Thu,  7 Mar 2024 21:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VNYrZdkd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34ED41C60
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 21:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709845684; cv=none; b=g3MFzEt43yVXU4wH3CkRlYGObqTGI+nGOqd3QZT+aUhMsOYm63BMZiTf/7D0KVQFWOEeQ6gtRueLTjc3zhuzwpdwR1IX6eGkgfEBtAZSkMRWpMzppYe1CMiSK4MpldJolSkHRdpY2KRWukGBY4+VEvg86Rlv9qvE8xsSLMr2ufE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709845684; c=relaxed/simple;
	bh=1XEhhXER+l2py7E9A6l7j6RxKar9kt1AO4R3/fLlEHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTa45kPp97VdKBWIYlKMOe8A9Bpnnor1yHExAkR8vtRII6ra0W2ivfU+3Q/QrXRuRrA/vxgyfKJ5PyIWV+75JyhlFb8XRBa80n//DR8q6TtK18Psg5HMbjv7N/Vlcc3JnqMQ6DI2+8t/dbUttBpzirO4glslag1t8X9hHh1S2Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VNYrZdkd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB008C433C7;
	Thu,  7 Mar 2024 21:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709845683;
	bh=1XEhhXER+l2py7E9A6l7j6RxKar9kt1AO4R3/fLlEHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VNYrZdkduKoulmjgYXcPd7zXB0lUZ5TVAqK1ATS9r3Ou+zpw1c0OY7/3aYOdaxzJY
	 KStYLhFboE28UNu3vCGWVkGcB6pxZJgDDuiCGmn2FWNzgm3EQUbpo7aEuVRLQ+yN5Z
	 eqlJs51D37hLm4riz2yjDo2Fd3sqSEnpllC9gd04=
Date: Thu, 7 Mar 2024 21:08:00 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Timur Tabi <ttabi@nvidia.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Michael Ellerman <michael@ellerman.id.au>, david@fromorbit.com,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [v2] debufgs: debugfs_create_blob can set the file size
Message-ID: <2024030748-enclose-breeding-4473@gregkh>
References: <20240207224607.3451276-1-ttabi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207224607.3451276-1-ttabi@nvidia.com>

On Wed, Feb 07, 2024 at 04:46:07PM -0600, Timur Tabi wrote:
> debugfs_create_blob() is given the size of the blob, so use it to
> also set the size of the dentry.  For example, efi=debug previously
> showed
> 
> -r-------- 1 root root 0 Feb  7 13:30 boot_services_code0
> -r-------- 1 root root 0 Feb  7 13:30 boot_services_code1
> -r-------- 1 root root 0 Feb  7 13:30 boot_services_data0
> -r-------- 1 root root 0 Feb  7 13:30 boot_services_data1
> -r-------- 1 root root 0 Feb  7 13:30 boot_services_data2
> -r-------- 1 root root 0 Feb  7 13:30 boot_services_data3
> -r-------- 1 root root 0 Feb  7 13:30 boot_services_data4
> 
> but with this patch it shows
> 
> -r-------- 1 root root  12783616 Feb  7 13:26 boot_services_code0
> -r-------- 1 root root    262144 Feb  7 13:26 boot_services_code1
> -r-------- 1 root root  41705472 Feb  7 13:26 boot_services_data0
> -r-------- 1 root root  23187456 Feb  7 13:26 boot_services_data1
> -r-------- 1 root root 110645248 Feb  7 13:26 boot_services_data2
> -r-------- 1 root root   1048576 Feb  7 13:26 boot_services_data3
> -r-------- 1 root root      4096 Feb  7 13:26 boot_services_data4
> 
> Signed-off-by: Timur Tabi <ttabi@nvidia.com>
> ---
>  fs/debugfs/file.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index c6f4a9a98b85..848deff11b7e 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -1152,7 +1152,14 @@ struct dentry *debugfs_create_blob(const char *name, umode_t mode,
>  				   struct dentry *parent,
>  				   struct debugfs_blob_wrapper *blob)
>  {
> -	return debugfs_create_file_unsafe(name, mode & 0644, parent, blob, &fops_blob);
> +	struct dentry *dentry;
> +
> +	dentry = debugfs_create_file_unsafe(name, mode & 0644, parent, blob, &fops_blob);
> +	if (!IS_ERR(dentry))
> +		i_size_write(d_inode(dentry), blob->size);
> +
> +	return dentry;
> +
>  }
>  EXPORT_SYMBOL_GPL(debugfs_create_blob);
>  
> -- 
> 2.34.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

