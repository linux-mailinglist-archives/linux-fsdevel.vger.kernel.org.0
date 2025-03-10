Return-Path: <linux-fsdevel+bounces-43571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A62A58DB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 09:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC241884A49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 08:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB6122331B;
	Mon, 10 Mar 2025 08:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooIE2HCU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DF31DA614
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 08:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741594145; cv=none; b=msCprhfrikUrMvHYB7h2Or1SpUJlyxSj4yL5ljWqd6E2U4mqxEh639XzA+9JdekXsDAoMPxatccOlJd7lvXB6ly2/BVtkUsd+GJuuwZ6IJEgZ1kRRygDD7YsyCdGiplH4Yj3gzBPjPzu2heRCtdOlgMmziqNOWVER4Cns5nun18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741594145; c=relaxed/simple;
	bh=ypwF9zpl4c/8TC3SooEbWtr9V6wdbrZxH0/CwmUbJ0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d91Ewz0uFHI7sR7niK1zwKSnDLeyQ0C+8AqLtACPhNfVDT4hgAZzmEbZbu5/HTIY9d+CdhUfJpYBfrI2dz5OKPvDKrB6z9sUWHCPavFp8fu8v3i8T9yUm0/xdelh9Ql4gcF7Ck4ujDeKCTrFCjC+C0Ee9j+2IIuJ43V5hnoCD2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooIE2HCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADF1C4CEEC;
	Mon, 10 Mar 2025 08:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741594145;
	bh=ypwF9zpl4c/8TC3SooEbWtr9V6wdbrZxH0/CwmUbJ0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ooIE2HCU3sw2p2cYmO6qVtI7w8KSLghEMq4nYY/zSEERKdjF73vFzffxe+3yOkBvx
	 5EMOirqaf3719aEaAMnkDMG13fQFcHZCJMBi4dfLWqTWhxMPiDoumwNZ/Fxq+DenMF
	 HmZTQro9cJCxu1tNW626POxfukHOnggn+gHIYm0Ev5sXoclL3cYw3TcZcw0kSTS38B
	 YTEJf/eNU0dx9ibSZdisQ/h/2/aTHgOPGDTFgJ+yPptLDnefGKkL/YH81OjnUKuNfk
	 Q0CB2ErqoozTn1E+yfueBYpH+KuazltBbVwpyuClKaFQEdtC1m7m+sF7R3vRIWMXTm
	 hqX6Bfj417y/A==
Date: Mon, 10 Mar 2025 09:09:01 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fsnotify: avoid pre-content events when faulting in
 user pages
Message-ID: <20250310-pfahl-bauamt-48fbb48b63fa@brauner>
References: <20250309115207.908112-1-amir73il@gmail.com>
 <20250309115207.908112-3-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250309115207.908112-3-amir73il@gmail.com>

On Sun, Mar 09, 2025 at 12:52:07PM +0100, Amir Goldstein wrote:
> In the use case of buffered write whose input buffer is mmapped file on a
> filesystem with a pre-content mark, the prefaulting of the buffer can
> happen under the filesystem freeze protection (obtained in vfs_write())
> which breaks assumptions of pre-content hook and introduces potential
> deadlock of HSM handler in userspace with filesystem freezing.
> 
> Disable pagefaults in the context of filesystem freeze protection
> if the filesystem has any pre-content marks to avert this potential
> deadlock.
> 
> Reported-by: syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com
> Tested-by: syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-fsdevel/7ehxrhbvehlrjwvrduoxsao5k3x4aw275patsb3krkwuq573yv@o2hskrfawbnc/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  include/linux/fs.h | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 2788df98080f8..a8822b44d4967 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3033,13 +3033,27 @@ static inline void file_start_write(struct file *file)
>  	if (!S_ISREG(file_inode(file)->i_mode))
>  		return;
>  	sb_start_write(file_inode(file)->i_sb);
> +	/*
> +	 * Prevent fault-in pages from user that may call HSM hooks with
> +	 * sb_writers held.
> +	 */
> +	if (unlikely(FMODE_FSNOTIFY_HSM(file->f_mode)))
> +		pagefault_disable();
>  }
>  
>  static inline bool file_start_write_trylock(struct file *file)
>  {
>  	if (!S_ISREG(file_inode(file)->i_mode))
>  		return true;
> -	return sb_start_write_trylock(file_inode(file)->i_sb);
> +	if (!sb_start_write_trylock(file_inode(file)->i_sb))
> +		return false;
> +	/*
> +	 * Prevent fault-in pages from user that may call HSM hooks with
> +	 * sb_writers held.
> +	 */
> +	if (unlikely(FMODE_FSNOTIFY_HSM(file->f_mode)))
> +		pagefault_disable();

That looks very iffy tbh.

> +	return true;
>  }
>  
>  /**
> @@ -3053,6 +3067,8 @@ static inline void file_end_write(struct file *file)
>  	if (!S_ISREG(file_inode(file)->i_mode))
>  		return;
>  	sb_end_write(file_inode(file)->i_sb);
> +	if (unlikely(FMODE_FSNOTIFY_HSM(file->f_mode)))
> +		pagefault_enable();
>  }
>  
>  /**
> -- 
> 2.34.1
> 

