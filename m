Return-Path: <linux-fsdevel+bounces-31139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C309922E2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 05:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B31CC282D4E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 03:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E3C14A84;
	Mon,  7 Oct 2024 03:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WLdC5NRE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CD2FC11;
	Mon,  7 Oct 2024 03:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728270198; cv=none; b=p0KUfdSgooZGL7vncUWBXNEkFOZ6jrrvO27cWdv1eePCncGtsmnYL45T1wa39KtN40BVycQhl5BcCDCUiSR21uLD/res6Gadq5xJhwbARKvo3U36EFWlfqs54effahHIrKG9SXiSCaxS9azqbWqTp8APe0J8YsxEK4uITVF+X5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728270198; c=relaxed/simple;
	bh=JfBOHA2Zp1d++xwrRm7cKi3Zi+Ot+yWu5ZZV64Fi8WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFDr8Vt2AypgVPa1RtV+hUYujOo0GFSyNtXVTsr3wybvEeIGhNKcIEIdZNGo5J5tjGXn18XtcgKhA8kYfzTxE7Zlzb0oHsp1TD/3NXNPSeoc2B1vWsl8g2OI5LIjvyzcr/GwBOk8yhv12DWzNdcnljSWCih83FQ33VvKJGuoJ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WLdC5NRE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GwekB3aqW6ryImoefbQulyTYf/6BVTLgwz7dZJUzN/w=; b=WLdC5NREscvr5Qnp2ECEA9Fii7
	Sk/3+q8jy508pzDVf1utoxNqVwrRwp7CJG6HZL4GvGUBlFtC4xa1x9R+HEW+sYllPdlRMgWebr12S
	bOjql4AgfXi44t1rVx/GaauAqYr/BhMusQX5/IOYip22A3xG4eQrWvNFGqWkm0yUCiYnrYkvbKBfb
	A8Y+Bf/LIKhVnoPT4MutKUh/3lQPHJYm2aTgFDf9zdUWjqOXsXN3jHwwwz73FYTbMvNMaoJzsxqpe
	nhUQcPkFZMBYXhlajlk3ruWRrPZZ9sGEH9B1NxqxVrhgCo/w7t8pdN7ypf+oY0hWwvy8jgUgwZskh
	V1rynMjw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxe1h-00000001U3Z-139g;
	Mon, 07 Oct 2024 03:03:13 +0000
Date: Mon, 7 Oct 2024 04:03:13 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ovl: stash upper real file in backing_file struct
Message-ID: <20241007030313.GH4017910@ZenIV>
References: <20241006082359.263755-1-amir73il@gmail.com>
 <20241006082359.263755-3-amir73il@gmail.com>
 <20241006210426.GG4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006210426.GG4017910@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Oct 06, 2024 at 10:04:26PM +0100, Al Viro wrote:
> On Sun, Oct 06, 2024 at 10:23:57AM +0200, Amir Goldstein wrote:
> > +	/*
> > +	 * Usually, if we operated on a stashed upperfile once, all following
> > +	 * operations will operate on the stashed upperfile, but there is one
> > +	 * exception - ovl_fsync(datasync = false) can populate the stashed
> > +	 * upperfile to perform fsync on upper metadata inode.  In this case,
> > +	 * following read/write operations will not use the stashed upperfile.
> > +	 */
> > +	if (upperfile && likely(ovl_is_real_file(upperfile, realpath))) {
> > +		realfile = upperfile;
> > +		goto checkflags;
> >  	}
> >  
> > +	/*
> > +	 * If realfile is lower and has been copied up since we'd opened it,
> > +	 * open the real upper file and stash it in backing_file_private().
> > +	 */
> > +	if (unlikely(!ovl_is_real_file(realfile, realpath))) {
> > +		struct file *old;
> > +
> > +		/* Either stashed realfile or upperfile must match realinode */
> > +		if (WARN_ON_ONCE(upperfile))
> > +			return -EIO;
> > +
> > +		upperfile = ovl_open_realfile(file, realpath);
> > +		if (IS_ERR(upperfile))
> > +			return PTR_ERR(upperfile);
> > +
> > +		old = cmpxchg_release(backing_file_private_ptr(realfile), NULL,
> > +				      upperfile);
> > +		if (old) {
> > +			fput(upperfile);
> > +			upperfile = old;
> > +		}
> > +
> > +		/* Stashed upperfile that won the race must match realinode */
> > +		if (WARN_ON_ONCE(!ovl_is_real_file(upperfile, realpath)))
> > +			return -EIO;
> > +
> > +		realfile = upperfile;
> > +	}
> > +
> > +checkflags:
> 
> Hmm...  That still feels awkward.  Question: can we reach that code with
> 	* non-NULL upperfile
> 	* false ovl_is_real_file(upperfile, realpath)
> 	* true ovl_is_real_file(realfile, realpath)
> Is that really possible?

read() from metacopied file after fsync(), with the data still in lower
layer?  Or am I misreading that?

