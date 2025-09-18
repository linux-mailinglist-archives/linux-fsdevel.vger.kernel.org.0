Return-Path: <linux-fsdevel+bounces-62071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B22AAB8354E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 09:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0771C24EE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 07:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B532EA735;
	Thu, 18 Sep 2025 07:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phtoj2Cx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EFD29E0F7;
	Thu, 18 Sep 2025 07:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758180883; cv=none; b=qNXgKDI5COfnyn0fvVg5kP/8uD8LG8MHUNgIlH67w9PPkQT6HNd0H0rp0e/A3hRJlQNkM/Xwsw+v2xQZm7+2d8GPlIXTH03GQauF3pBAtMNQcSxIZWH0vz2fpRBk74rwDHvqdYJ7PGofc528Zzm2agk16aa5umaa5PI3C8kn198=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758180883; c=relaxed/simple;
	bh=iFyl1v+R5r8mqqXN1vgFO7dGvg1TVlgShJSyPTUstxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cOs5HC6hycxFZPtahydUr91DwdltvTHqtjPUmK7J+IN+2wnYytjVPhm0nhpR7klJgiS9j+ITTrzVouzokVTtolqb/xcYGMh4Q4RWJj+SRY4WkT8kGX0MPVkf/YjDe+vLUfrs5pRBB82vhKvwQHTatPnJun4TVu/HGlYXNxWCy1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phtoj2Cx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0550FC4CEE7;
	Thu, 18 Sep 2025 07:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758180882;
	bh=iFyl1v+R5r8mqqXN1vgFO7dGvg1TVlgShJSyPTUstxk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=phtoj2CxJPgt5vlwgTN7FnjIQJ+OT78j87ABMY8vPHEow8JDNeDYUmGsE0e8555rC
	 /o9X3zw9P6cjDhVh0+KUdQ3X2U9KuoOAuAtfs5l86ewubTk0Vo8eLvBU6KbfjC1L/z
	 gFYxCE7voIAu9TqJ9/blXGUWYCjbXVVuwMD657mnWPpdX+ff9VGS5Lg0m1tp1gDTNr
	 0k+WKo1DKSQVtZdnWaVeM6THYvacQUQUACPn/NNwGRAQas4dKY6/WMYtnQGRa7fs2M
	 m2SFtGKk8uCE+nsvOGBF8TL5TGEhJGjP+CcIw70cDPD1gQ3yyFntHhlOpeEiXp424l
	 wqOuckTojiYEg==
Message-ID: <eb729729-c7cf-4a15-ab97-27ec21c0891a@kernel.org>
Date: Thu, 18 Sep 2025 09:34:39 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] simplify vboxsf_dir_atomic_open()
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: v9fs@lists.linux.dev, miklos@szeredi.hu, agruenba@redhat.com,
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org
References: <20250917232416.GG39973@ZenIV>
 <20250917232736.2556586-1-viro@zeniv.linux.org.uk>
 <20250917232736.2556586-5-viro@zeniv.linux.org.uk>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20250917232736.2556586-5-viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 18-Sep-25 1:27 AM, Al Viro wrote:
> similar to 9p et.al.
> 
> Reviewed-by: NeilBrown <neil@brown.name>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

Regards,

Hans



> ---
>  fs/vboxsf/dir.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
> index 770e29ec3557..42bedc4ec7af 100644
> --- a/fs/vboxsf/dir.c
> +++ b/fs/vboxsf/dir.c
> @@ -315,46 +315,39 @@ static int vboxsf_dir_atomic_open(struct inode *parent, struct dentry *dentry,
>  {
>  	struct vboxsf_sbi *sbi = VBOXSF_SBI(parent->i_sb);
>  	struct vboxsf_handle *sf_handle;
> -	struct dentry *res = NULL;
>  	u64 handle;
>  	int err;
>  
>  	if (d_in_lookup(dentry)) {
> -		res = vboxsf_dir_lookup(parent, dentry, 0);
> -		if (IS_ERR(res))
> -			return PTR_ERR(res);
> -
> -		if (res)
> -			dentry = res;
> +		struct dentry *res = vboxsf_dir_lookup(parent, dentry, 0);
> +		if (res || d_really_is_positive(dentry))
> +			return finish_no_open(file, res);
>  	}
>  
>  	/* Only creates */
> -	if (!(flags & O_CREAT) || d_really_is_positive(dentry))
> -		return finish_no_open(file, res);
> +	if (!(flags & O_CREAT))
> +		return finish_no_open(file, NULL);
>  
>  	err = vboxsf_dir_create(parent, dentry, mode, false, flags & O_EXCL, &handle);
>  	if (err)
> -		goto out;
> +		return err;
>  
>  	sf_handle = vboxsf_create_sf_handle(d_inode(dentry), handle, SHFL_CF_ACCESS_READWRITE);
>  	if (IS_ERR(sf_handle)) {
>  		vboxsf_close(sbi->root, handle);
> -		err = PTR_ERR(sf_handle);
> -		goto out;
> +		return PTR_ERR(sf_handle);
>  	}
>  
>  	err = finish_open(file, dentry, generic_file_open);
>  	if (err) {
>  		/* This also closes the handle passed to vboxsf_create_sf_handle() */
>  		vboxsf_release_sf_handle(d_inode(dentry), sf_handle);
> -		goto out;
> +		return err;
>  	}
>  
>  	file->private_data = sf_handle;
>  	file->f_mode |= FMODE_CREATED;
> -out:
> -	dput(res);
> -	return err;
> +	return 0;
>  }
>  
>  static int vboxsf_dir_unlink(struct inode *parent, struct dentry *dentry)


