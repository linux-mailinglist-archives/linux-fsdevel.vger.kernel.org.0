Return-Path: <linux-fsdevel+bounces-38070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3979FB4DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 21:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E54216663A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 20:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949271C3BE4;
	Mon, 23 Dec 2024 20:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bEg6YvP6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9943A80038;
	Mon, 23 Dec 2024 20:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734984318; cv=none; b=D21GP3JzAJ1nk7C9uoYpERGAyRt7x4v++KwdwA8O/HgFNLMOdzHcUzRzX28b8QAqiHO9z5t2BwxUMHxnoV3uZCX1+21dG4CLbXJGkKwxO+gt0thn4XAzuERxkscnh9e2naJwnWsV04Pjppel2/faDPt65VPpzLq+bzYmtu54H4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734984318; c=relaxed/simple;
	bh=mMzOzjhOv4Fy9XWA543UX9mVqJaFyLuc/yT7qHk2cdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imn4pBnGVak8KJWZPVnQtUMPuxSVPEbFJK/+5mtNsjPwi7sNDHrrt9OCW1n4qM6FLT3vAht8yH+QgfPTmivnKDKCx8kIu61u+vPwxgpWhd9DwqoIo2t6eNq96SiYoAJybvIREdRWmbnNhnZCsUXp1sHdJ4fDII7KhVFxWMBCfTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bEg6YvP6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+/iNhlleqTjiw6x+xa9IF9CT0H3OoSbj6kpxIuhDAzs=; b=bEg6YvP6G93LfFCt6DC1lgQqAj
	pM44xujbdHhQCNuuSlMyYEFxM508wTNO8OA6lAUV8xpqKEyuVpfv7X36HG1MOiT8JWIDbXoxBn+na
	0hpI1lnz99GnjpzMeguktuHgd8LEL6WJfBOMzDwmGjrquzkhhXfcPbjwcLsKX8GIDUQeamk6QcnA8
	4Az8b2FNkNDz76FcU1lYetypwU62CLr2HdIFQsTHJMnhEoBRR3t7ydrUPZVG4xIB5BZ4m8TQ23I+K
	m0I+z6JlFzrc+BMJkvdVSc4Zsl+pe4/cRc+AYNSg6xsz95Bms2K1IbA4VFTmivPOGfq6wHm6mWZ/G
	E2h7r3Cw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tPofx-0000000BPpB-0TKy;
	Mon, 23 Dec 2024 20:05:13 +0000
Date: Mon, 23 Dec 2024 20:05:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH 6/6] efivarfs: fix error on write to new variable leaving
 remnants
Message-ID: <20241223200513.GO1977892@ZenIV>
References: <20241210170224.19159-1-James.Bottomley@HansenPartnership.com>
 <20241210170224.19159-7-James.Bottomley@HansenPartnership.com>
 <20241211-krabben-tresor-9f9c504e5bd7@brauner>
 <049209daadc928ecbf3bdb17d80634fa55842263.camel@HansenPartnership.com>
 <f9690563fe9d7ae4db31dd37650777e02580b332.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9690563fe9d7ae4db31dd37650777e02580b332.camel@HansenPartnership.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 23, 2024 at 02:52:12PM -0500, James Bottomley wrote:
>  
> +static int efivarfs_file_release(struct inode *inode, struct file *file)
> +{
> +	inode_lock(inode);
> +	if (i_size_read(inode) == 0 && !d_unhashed(file->f_path.dentry)) {
> +		drop_nlink(inode);
> +		d_delete(file->f_path.dentry);
> +		dput(file->f_path.dentry);
> +	}
> +	inode_unlock(inode);
> +	return 0;
> +}

This is wrong; so's existing logics for removal from write().  Think
what happens if you open the sucker, have something bound on top of
it and do that deleting write().

Let me look into that area...

