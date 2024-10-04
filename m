Return-Path: <linux-fsdevel+bounces-31038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3B3991235
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 00:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8F1284B5A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 22:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E771AE003;
	Fri,  4 Oct 2024 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fN8GxA0b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F98231CA2;
	Fri,  4 Oct 2024 22:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728080190; cv=none; b=vALEVyqj1mIjCfhqvdP7UlfI8EHDoowSRLQvYdVpKq4Q2JRfSSDd3NRkYVsJeayVy5HvWSLyCRSFwf5Wdn3HPgtxX98gTa3DAWbHXpUzrAsNDKzmvUDB9uE7wXyQh1QahxL8C734LmiHUPyfQo2gEu98gOvJm6GSaoOEAV/znio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728080190; c=relaxed/simple;
	bh=/UL/KOEemdyBFd9Mkxc6nXZ5THXtoD+nYiSfIlgrzTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hglNN4OOoIOUTqx2rZx0LpCWQRjBfG1/+K2wtXWp6ZMQjypmiTr1DHxFs+rjUhqIxcT1W1cjuCYn0CkaI+V3NdIRftiPppNMi9Lv2vX+9D71ov0X+Nb4YNS+LQ2S4dK23/goSI9eTpuK5h6cHINtAPfl34WuSeA79a1J+wVLcKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fN8GxA0b; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z9ufaGLpY3qD5oRu7I72BnMwLQ6dm7Av1cgnq2ICSg8=; b=fN8GxA0b7/UeEUKDqb7OtttIZn
	pXQhE6WBHUXMSPIeEtX875JZWuYhST4di1TP3RA1F29sIh04W++S+tHYHjoch6zCK3zRg5NOI+92z
	R2Bm70LeUUjJ8wdfJhmsfD3xqf3Xkm9e63SocO5UyKbLLMrLcYBcLXNn/Si6LtqWdv0yiPg1VZBfm
	h5lr08IbuJi2FBtD10t+IK2fIV90x2CTKLQLbl9AWwFd/FbV605Rjfd7gwP7rpa1E1NYIxueT+I3c
	f8YxGxl1vRwb0L/fiRSTdSGilsh30mMYawCDNKE0xLGyJ+OF6V1YO7M4QmLQih0n0ROnMOIsFpudV
	E9as5YLA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swqb3-00000000tbv-0TJt;
	Fri, 04 Oct 2024 22:16:25 +0000
Date: Fri, 4 Oct 2024 23:16:25 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 1/4] ovl: do not open non-data lower file for fsync
Message-ID: <20241004221625.GR4017910@ZenIV>
References: <20241004102342.179434-1-amir73il@gmail.com>
 <20241004102342.179434-2-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004102342.179434-2-amir73il@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Oct 04, 2024 at 12:23:39PM +0200, Amir Goldstein wrote:
> ovl_fsync() with !datasync opens a backing file from the top most dentry
> in the stack, checks if this dentry is non-upper and skips the fsync.
> 
> In case of an overlay dentry stack with lower data and lower metadata
> above it, but without an upper metadata above it, the backing file is
> opened from the top most lower metadata dentry and never used.
> 
> Fix the helper ovl_real_fdget_meta() to return an empty struct fd in
> that case to avoid the unneeded backing file open.

Umm...  Won't that screw the callers of ovl_real_fd()?

I mean, here

> @@ -395,7 +397,7 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
>  		return ret;
>  
>  	ret = ovl_real_fdget_meta(file, &real, !datasync);
> -	if (ret)
> +	if (ret || fd_empty(real))
>  		return ret;
>  

you are taking account of that, but what of e.g.
        ret = ovl_real_fdget(file, &real);
        if (ret)
                return ret;

        /*
         * Overlay file f_pos is the master copy that is preserved
         * through copy up and modified on read/write, but only real
         * fs knows how to SEEK_HOLE/SEEK_DATA and real fs may impose
         * limitations that are more strict than ->s_maxbytes for specific
         * files, so we use the real file to perform seeks.
         */
        ovl_inode_lock(inode);
        fd_file(real)->f_pos = file->f_pos;
in ovl_llseek()?  Get ovl_real_fdget_meta() called by ovl_real_fdget() and
have it return 0 with NULL in fd_file(real), and you've got an oops right
there, don't you?

At the very least it's a bisect hazard...

