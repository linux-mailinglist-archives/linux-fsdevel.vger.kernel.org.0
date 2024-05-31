Return-Path: <linux-fsdevel+bounces-20665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F5E8D6708
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 18:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC921C222F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 16:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2D215CD63;
	Fri, 31 May 2024 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ILVIEva9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8072156242
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717173613; cv=none; b=bb1w01WEmoOV973gPx6s3+kH4G+YRXR/koxG9Vo1QRZAe5mak+S7Sie8x9xaj7yxMINX58lEEVIOytwI6+KanpVtk4t2oy6dMKnpURZ9LQlTtpyA0EVU8lRpuCQbR27b7AasG8xQMBnEYl+nElyKhA985nO+bqV28SkFjLMf/1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717173613; c=relaxed/simple;
	bh=NRH7vUmBOKo6JTxV93vM7GOpS617ny7EpN+5d7Lr8Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEfiJI4OD+lkS3n5++boIDhUBwJLklV2qQD1oyZ0gYV4XZv6JHR3VynvWv35ip8Rd1GmackhIsehLJfKY5QE/psdjB3cDOTclcIcugOHrg1lzgqg9IOSKyuliReK4SGqJQ+u1f9Xa81HcXodAMeSaf+zT5XoJFHV8ly6fGuvh+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ILVIEva9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DVLcHmHXLi+QVZILILjuZzRe5ngEcZ03NuiouWhg5LY=; b=ILVIEva9+jmFZiBDHv/LMkGcwU
	nBOQHdWH5euDUFfNpF+5B7nYDLADBSkvUpEN92eydyEatJ8sXGoVMKA9X5jKYTkbur61qB4cEDqa2
	b49WhkvTCUTW0UR47Czx27pp3USMDb2WUeso3UqaUNjvf5qemSo1vuvNo6sP/Gz+Wo+y4ENiE3YWu
	J/uaIsIJ9hvRu+H4Sh9rk0D29n/FlFn92QigdtkrysyEefoujSqmfos6krngBKPOsBfhiyyafroOP
	qfuC+Jif59aOQI+J7FbX2MHEK60Il+f2XG5jnjtBf5DzqVxtCgQVxiUSF40+ViFB/rbVuyRZULpes
	Fg0KMJlg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sD5IW-0086KX-1I;
	Fri, 31 May 2024 16:40:08 +0000
Date: Fri, 31 May 2024 17:40:08 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] struct fd situation
Message-ID: <20240531164008.GB1629371@ZenIV>
References: <20240531031802.GA1629371@ZenIV>
 <20240531163045.GA1916035@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531163045.GA1916035@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 31, 2024 at 05:30:45PM +0100, Al Viro wrote:
> static inline struct fd_err file_fd_err(struct file *f, bool is_cloned)
> {
> 	if (IS_ERR(f))
> 		return (struct fd_err){PTR_ERR(f)};
> 	else
> 		return (struct fd_err){(unsigned long)f | is_cloned};
> }
> 
> (or, perhaps, file_fd_cloned and file_fd_borrowed, to get rid of
> 'is_cloned' argument in public API; need to play around a bit and
> see what works better - the interesting part is what the constructor
> for struct fd would look like)

... along with

static inline struct fd_err ERR_FD(long n)
{
	return (struct fd_err){.word = (unsigned long)n};
}

yielding

> static struct fd_err ovl_real_fdget_meta(const struct file *file, bool allow_meta)
> {
>         struct dentry *dentry = file_dentry(file);
>         struct path realpath;
>         int err;
> 
>         if (allow_meta) {
>                 ovl_path_real(dentry, &realpath);
>         } else {
>                 /* lazy lookup and verify of lowerdata */
>                 err = ovl_verify_lowerdata(dentry);
>                 if (err)
			return ERR_FD(err);
> 
>                 ovl_path_realdata(dentry, &realpath);
>         }
>         if (!realpath.dentry)
		return ERR_FD(-EIO);
> 
>         /* Has it been copied up since we'd opened it? */
>         if (unlikely(file_inode(real->file) != d_inode(realpath.dentry)))
		return file_fd_cloned(ovl_open_realfile(file, &realpath));
> 
>         /* Did the flags change since open? */
>         if (unlikely((file->f_flags ^ real->file->f_flags) & ~OVL_OPEN_FLAGS)) {
> 		err = ovl_change_flags(real->file, file->f_flags);
> 		if (err)
			return ERR_FD(err);
> 	}
> 
	return file_fd_borrowed(file->private_data);
> }

