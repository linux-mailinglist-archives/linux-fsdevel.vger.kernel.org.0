Return-Path: <linux-fsdevel+bounces-19232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C758C1BE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 03:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 729DFB216DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 01:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D098413A885;
	Fri, 10 May 2024 01:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WqwDKfPC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589B43233;
	Fri, 10 May 2024 01:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715303100; cv=none; b=mhDQwcWO9sgGNGGjW4cvb9fLXaSMt127/b47Ax6tOOmUQIhd5ulEkPQ1X5y6I4NsHWpSK9YrZJBK86vIHcH1ZVi1C+xwZfaoJvJgG+izaQ0cOauRnWiV2gVy2Jv9by6FU6trRhRs3UDLuVNINIlyEe3ViO7OMxdakgAz+BRsG1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715303100; c=relaxed/simple;
	bh=KFBEiHJhSfUipSNO85JLe5zfW/KlykbFFyvgU+TiX70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xy/n68mXkI8HQAm3ScWck65zvcfXnWKR6o0Feo6WxfWnlni+hbIPdGTkcbkweZbvUnLvDgpgA1m7a+jfsoBEpJN6twfcaOvpSL2vAcpOz8Ru1VtqIdgTVewSbXPjWfPWj7dJn+yMgG2RZWQd+DKEbi5LvVkCp4sKXXj0TIOCTBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WqwDKfPC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HPlRxYUhMUtqQehxEexSSFqu/cTLN0aQ4VkiSWAMWAM=; b=WqwDKfPCadz2YIUHNbtWkdv1Y7
	JnEy0zXT5DSRxgrmZ5hnszQGbbm8FBN0T/9F0biu0xkauZcKfKwHdHdImQduP5/q5/GXvJH0OPtRE
	tAq3GKvzZzoY+WGj+5MUHUnTU2zf3VqxUQMz1W4kgze2p8K0f+YECwZvs6eysI0G0xw1Edg/0s7wp
	v8A0vmY2D1F6WcCImN/uTjhkTY8nly94J3kL/bZ/p0nua6MuhaC0pMrLel2fYfOeCNsxgIT9ys2/h
	JhTCxADBWpUUqViwKzmW1R/i/wIP40yVnsrZZfXc8N7ofz9VpLI4VIUkiCOKQtJlpud8E/K6fA9j5
	nMK3jYfA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s5Egt-001uNC-2r;
	Fri, 10 May 2024 01:04:52 +0000
Date: Fri, 10 May 2024 02:04:51 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Justin Stitt <justinstitt@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] libfs: fix accidental overflow in offset calculation
Message-ID: <20240510010451.GV2118490@ZenIV>
References: <20240510-b4-sio-libfs-v1-1-e747affb1da7@google.com>
 <20240510004906.GU2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510004906.GU2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 10, 2024 at 01:49:06AM +0100, Al Viro wrote:
> On Fri, May 10, 2024 at 12:35:51AM +0000, Justin Stitt wrote:
> > @@ -147,7 +147,9 @@ loff_t dcache_dir_lseek(struct file *file, loff_t offset, int whence)
> >  	struct dentry *dentry = file->f_path.dentry;
> >  	switch (whence) {
> >  		case 1:
> > -			offset += file->f_pos;
> > +			/* cannot represent offset with loff_t */
> > +			if (check_add_overflow(offset, file->f_pos, &offset))
> > +				return -EOVERFLOW;
> 
> Instead of -EINVAL it correctly returns in such cases?  Why?

We have file->f_pos in range 0..LLONG_MAX.  We are adding a value in
range LLONG_MIN..LLONG_MAX.  The sum (in $\Bbb Z$) cannot be below
LLONG_MIN or above 2 * LLONG_MAX, so if it can't be represented by loff_t,
it must have been in range LLONG_MAX + 1 .. 2 * LLONG_MAX.  Result of
wraparound would be equal to that sum - 2 * LLONG_MAX - 2, which is going
to be in no greater than -2.  We will run
			fallthrough;
		case 0:
			if (offset >= 0)
				break;
			fallthrough;
		default:
			return -EINVAL;
and fail with -EINVAL.

Could you explain why would -EOVERFLOW be preferable and why should we
engage in that bit of cargo cult?

