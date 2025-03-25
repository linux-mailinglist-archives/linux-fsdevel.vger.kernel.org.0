Return-Path: <linux-fsdevel+bounces-44936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3234A6E95A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 06:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34BDE16DFE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 05:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413D81A7044;
	Tue, 25 Mar 2025 05:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gNgG1vbh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4DA339A8
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 05:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742881861; cv=none; b=lZFecrNCN8w4fh0eewWT2PUsLh8XbRc1JVVzO9C33mhezJzv9j8ZtXqdlR7Oh/NbHVOBbeqgshZ9RSnzi6IblnD3vzKAc73R5hFd5pu3Ic+mIrT71333fJ0CDkIQhuLfdvKi5Dt2GdstzENyzVrLk20lWCFHNwjCCbrP6x+D/IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742881861; c=relaxed/simple;
	bh=2aay6E9G2RGxkACMOtLJYYble6pspKeeDRDaJCUPRhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfpmp7O3c/wkxUVwQiYVObG4PAHqKky0VbjaUc3ImZ89v40RqqEFYHxN2pGecdOPHd+G0cfXr+zlc6WV1nh1Gcc5IgGKLc4WV1LZVOiVLlBRRX3QVZptDlExa+6rW05y6K3MPKwthDFhss8x6hDXmoDZ/0cR4oLFli1j+ePQ018=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gNgG1vbh; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C+PepjtE55GRf9GaqLMN+G62YsTFRQG98XWX5zpT7LU=; b=gNgG1vbhYlHifNr5jrdGr7HQDN
	P1kDM5KIuJXFGlgOpzhYuhzXZItr31hRN6hNcDb+VP76TDZOCvO7+OP8GX/x/va+y0wqLkgx/xdOy
	UCcPYI58Ben7uzjfYIh1u0DU6WgZs3Vg33f3POlk4AbAANsQuXQ+Id6jma5U8lD38NaiR41rDNMNy
	IsVXwMejKqSayc3dexwCKeRuNQwdrbZALEuN6mfvFHmxSkfhaMyeKTud1h9msRHoIBPIAWuIWoY9Z
	buMfrUKefyNL+x7vEhh2go4HLFQWPaio6AjAIdew033T07A6vb6SmrPEVW5qzSu/pB8YUXNHdZJ+v
	ySvMfBlw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1twxBg-00000008Q9Z-2fLa;
	Tue, 25 Mar 2025 05:50:56 +0000
Date: Tue, 25 Mar 2025 05:50:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] weird use of dget_parent() in xfs_filestream_get_parent()
Message-ID: <20250325055056.GK2023217@ZenIV>
References: <20250324215215.GJ2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324215215.GJ2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Mar 24, 2025 at 09:52:15PM +0000, Al Viro wrote:
> Function in question:
> 
> static struct xfs_inode *
> xfs_filestream_get_parent(
>         struct xfs_inode        *ip)
> {
>         struct inode            *inode = VFS_I(ip), *dir = NULL;
>         struct dentry           *dentry, *parent;
> 
>         dentry = d_find_alias(inode);
>         if (!dentry)
>                 goto out;
> 
>         parent = dget_parent(dentry);
>         if (!parent)
>                 goto out_dput;
> 
>         dir = igrab(d_inode(parent));
>         dput(parent);
> 
> out_dput:
>         dput(dentry);
> out:
>         return dir ? XFS_I(dir) : NULL;
> }
> 
> 1) dget_parent(dentry) never returns NULL; if you have IS_ROOT(dentry) you
> get an equivalent of dget(dentry).  What do you want returned in that
> case?
> 
> 2) why bother with dget_parent() in the first place?  What's wrong with
> 	spin_lock(&dentry->d_lock); // stabilizes ->d_parent
>         dir = igrab(dentry->d_parent->d_inode);
> 	spin_unlock(&dentry->d_lock);
> 
> or, if you intended NULL for root, 
> 	spin_lock(&dentry->d_lock); // stabilizes ->d_parent
> 	if (!IS_ROOT(dentry))
> 		dir = igrab(dentry->d_parent->d_inode);
> 	spin_unlock(&dentry->d_lock);
> 
> 
> Is there anything subtle I'm missing here?

For (2) there is - ->i_lock nests outside of ->d_lock, so igrab() under
any ->d_lock is not valid.

For (1) we provably can't get NULL - there are two returns in dget_parent():
                if (!read_seqcount_retry(&dentry->d_seq, seq))
                        return ret;
and
        spin_unlock(&ret->d_lock);
        return ret;
and neither can return a NULL - we'd oops immediately prior to getting
there.

The same goes for xrep_findparent_from_dcache() - in
        parent = dget_parent(dentry);
	if (!parent)
		goto out_dput;

	ASSERT(parent->d_sb == sc->ip->i_mount->m_super);

	pip = igrab(d_inode(parent));
	dput(parent);
we need to use dget_parent(), but we really can't get a NULL from
it.

