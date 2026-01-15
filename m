Return-Path: <linux-fsdevel+bounces-73871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C402D2248D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 04:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CFB0C30060F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 03:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB51B2749DF;
	Thu, 15 Jan 2026 03:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btlUjL16"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E797B2641C6
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 03:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768447223; cv=none; b=s7wmfWIqR8wM5qlRAfbc4Xt3YUMzhFB8VgYMAVLZxWvCPSXbAZt4dsWRbSPvXP1etRaBwIKFgdzGAvFGa9swTFTva6QUREXXjL4Z2ZefBWkcUaCJgftE2IPrxJp2skPrEvSHxV+pR2hq7DEagr6Pfsw1e69MpsQjuWzFt2ytFp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768447223; c=relaxed/simple;
	bh=upkeY48wkxEI/Uops1fgvv5r4MWDRauu4M3UNZQqQZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMBF9Bf3UtF4RZWXDtVU0cPaY/iJ37uZJN/ez3TE4XZVsR4D1IYF0V1yzicBOFQ4aTOD/OWWOpXSkwbxOpMYtoOA8cKSoch+GcuhXOkKnV2B6S5iknj4KOGTZsCnpVt7o4RgTZtN2337ER679nuep2duC8/HW6yHvLN0PIucKMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btlUjL16; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-81f4ba336b4so361039b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 19:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768447220; x=1769052020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Trq+zKapUs2OXgXptR+lx0STbGwE8yhsbG9H7N7gDZA=;
        b=btlUjL16twScFn4A5mn6NDY4QczL9O5+hgCpTWqWgP0Fm+QhZ8IeDEJburpKEvHyf0
         dIS5HX0X7tETeNGzU72migLV6cU/VSZ4CUFWyrJ2exhQd3MFYddhnfCdkdSoCbwBGHv/
         Y93JaGGB197EFHPw7e1+CfELPVtDGJR7WBBzr9/hOw1/6dTGYOslQoycIkPB4vtT9kCW
         jl+/l2/SQETYQWG8F97qThthLk/BuMpT5DAvz89BMtEcAd+EmsoGyzGadaRHAk69i+RN
         K4z34s+kX6O3UeYEAppuSIF2Wv9W9hEsvptatc4Cgga1e4wD0tNMcbDbu9UK6m1oYnkt
         /5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768447220; x=1769052020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Trq+zKapUs2OXgXptR+lx0STbGwE8yhsbG9H7N7gDZA=;
        b=oEv8PqDAJjxroATfMwwequ0LqhwZdzSCVOEzdBrB4ozD2MPMAfDBjUoNZNyHc4I3g5
         JVwo7pXdiBINuafi1pcGglcJLZQO7sykV8mBTXV5D1DIJCOK7Lj++x/KaoSRAfWH+Jy4
         C9O49h6OgnttoX+pvqaUhVraNS1MENUTH3kjDcpY7lOA5pJXtBiH2FMhgpMjgLGu/fyi
         uimFs3/1osX/0hemRq2NGKZ88OEKMlpTtU74SRvRwK/Q93pe1E5wnL9LxjX1iOg7b3XX
         GFIdQATbRYEDDwZ4MAIA+e0n6AQYcVJb6OOgeWacmrJ/DJjmrZ99MWavqHNEbLsThqF0
         kBSA==
X-Forwarded-Encrypted: i=1; AJvYcCW/M+TgD4amxPTNexMj1iwpSGYm+bll0uUfQkT0bRCRhsnYJ4QtdeaRHyEZGb81remKNiet3ngb/9dL1FI9@vger.kernel.org
X-Gm-Message-State: AOJu0YzxRx7dwHZQ/Rys9pkszm2RzD+BpTLAq21zqu0+x3HIA/MKCCKb
	NHHKkuTyLn/EYtqYujuI7olseW9+Zi9+dgL9kskN2mmVuLglilLlsYwm
X-Gm-Gg: AY/fxX6UsOKuvQH3sXkmXOvcCG7rxEmCelJc9HphmaImDT99gVcMMZpPr2cLfjZKM12
	5Y3EVB7sd6SoY/ypBkDtD4Bne2kL+Ul8o4HT+Fg2IFySz9BXrB4zUF5qjHqJ6jqDZ7VbWwgVKDn
	jf/eDFWs2DcCwdvfKuPVwYHpGyA14eikUTH5Hl4Maic5/s9ZvBSI8lyTHmsOl/hOXOkmIeUbGMP
	V+XYJE4kbIWUiV5cNlDT0kg0H/8vwgcXNhDaaUnOE+KdC9aUyEXYHB2bqxAlXVyFbFPLy0i8g8j
	/OSzF67xR78soEXTWnkBKJl4AosvrBlaT5wsRPLTrn6bITL/keDh9+eevYJx2ejmA/JKiC0czGH
	wmme6TAlawT8V6Rda7AU+WwhTGMxwuKZw165wB9fmhU3cSx95fYIrBbknq5ErtJ/p580FQv2nla
	E3X3cSf7PFzes=
X-Received: by 2002:a05:6a00:a24c:b0:81f:4063:f1ef with SMTP id d2e1a72fcca58-81f83d5e4b5mr3914019b3a.54.1768447220095;
        Wed, 14 Jan 2026 19:20:20 -0800 (PST)
Received: from inspiron ([111.125.235.106])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8e381d7csm963637b3a.0.2026.01.14.19.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 19:20:19 -0800 (PST)
Date: Thu, 15 Jan 2026 08:50:12 +0530
From: Prithvi <activprithvi@gmail.com>
To: martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@lst.de, jlbec@evilplan.org,
	linux-fsdevel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	khalid@kernel.org,
	syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] scsi: target: Fix recursive locking in
 __configfs_open_file()
Message-ID: <20260115032012.yb5ylmumcirrmsbr@inspiron>
References: <20260108191523.303114-1-activprithvi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108191523.303114-1-activprithvi@gmail.com>

On Fri, Jan 09, 2026 at 12:45:23AM +0530, Prithvi Tambewagh wrote:
> In flush_write_buffer, &p->frag_sem is acquired and then the loaded store
> function is called, which, here, is target_core_item_dbroot_store().
> This function called filp_open(), following which these functions were
> called (in reverse order), according to the call trace:
> 
> down_read
> __configfs_open_file
> do_dentry_open
> vfs_open
> do_open
> path_openat
> do_filp_open
> file_open_name
> filp_open
> target_core_item_dbroot_store
> flush_write_buffer
> configfs_write_iter
> 
> Hence ultimately, __configfs_open_file() was called, indirectly by
> target_core_item_dbroot_store(), and it also attempted to acquire
> &p->frag_sem, which was already held by the same thread, acquired earlier
> in flush_write_buffer. This poses a possibility of recursive locking,
> which triggers the lockdep warning.
> 
> Fix this by modifying target_core_item_dbroot_store() to use kern_path()
> instead of filp_open() to avoid opening the file using filesystem-specific
> function __configfs_open_file(), and further modifying it to make this
> fix compatible.
> 
> Reported-by: syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f6e8174215573a84b797
> Tested-by: syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
> ---
>  drivers/target/target_core_configfs.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
> index b19acd662726..f29052e6a87d 100644
> --- a/drivers/target/target_core_configfs.c
> +++ b/drivers/target/target_core_configfs.c
> @@ -108,8 +108,8 @@ static ssize_t target_core_item_dbroot_store(struct config_item *item,
>  					const char *page, size_t count)
>  {
>  	ssize_t read_bytes;
> -	struct file *fp;
>  	ssize_t r = -EINVAL;
> +	struct path path = {};
>  
>  	mutex_lock(&target_devices_lock);
>  	if (target_devices) {
> @@ -131,17 +131,18 @@ static ssize_t target_core_item_dbroot_store(struct config_item *item,
>  		db_root_stage[read_bytes - 1] = '\0';
>  
>  	/* validate new db root before accepting it */
> -	fp = filp_open(db_root_stage, O_RDONLY, 0);
> -	if (IS_ERR(fp)) {
> +	r = kern_path(db_root_stage, LOOKUP_FOLLOW, &path);
> +	if (r) {
>  		pr_err("db_root: cannot open: %s\n", db_root_stage);
>  		goto unlock;
>  	}
> -	if (!S_ISDIR(file_inode(fp)->i_mode)) {
> -		filp_close(fp, NULL);
> +	if (!d_is_dir(path.dentry)) {
> +		path_put(&path);
>  		pr_err("db_root: not a directory: %s\n", db_root_stage);
> +		r = -ENOTDIR;
>  		goto unlock;
>  	}
> -	filp_close(fp, NULL);
> +	path_put(&path);
>  
>  	strscpy(db_root, db_root_stage);
>  	pr_debug("Target_Core_ConfigFS: db_root set to %s\n", db_root);
> 
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> -- 
> 2.34.1
> 

Hello all,

Just a gentle ping on this thread.

Thanks, 
Prithvi

