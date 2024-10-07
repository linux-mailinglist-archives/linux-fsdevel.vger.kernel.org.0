Return-Path: <linux-fsdevel+bounces-31224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C87B3993488
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 19:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FFBB1F24970
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 17:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816911DD523;
	Mon,  7 Oct 2024 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nkPquOaN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A6D1E52D;
	Mon,  7 Oct 2024 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321189; cv=none; b=kj3dhqCdQ35L4hfkg0FJSbcAcUk4na3N948Qa1QX+6SUA1pPfnzGZddghHGZE6raS17Xpm29VAevrfQK4kzYvFFyRAFPQo1STcvtT6tYt27ByjpBhjV9huPUBJu1wuJ0z9uHilTY6v3m7U2t521pGFBsfvSqoO5fQMZihKD2Gog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321189; c=relaxed/simple;
	bh=wvrWQJtopaGCe+FQlg3DUNgNJoZsiZ3I1Ia3xnuJLuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqosFQ1YWjayrRYhdKUvxhqTO1fMRi1Pp2aPoJWoeGzWR9Tg29wac5cL3AgKdvgVfwx5sYakTnAy42Yt7GTO7qWaZiJIrrFrlnOP4Kozpr0d6Zt6fOyz10S7L7IddMo844Fb/EtFFMn9K/QAJyl1ECociuEjmuVrY70DgTcLjQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nkPquOaN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LeL/VcQehP2raq7vQszs+ZornlPb/JZTIx+OrLm0sdc=; b=nkPquOaNHZ76m/+lTAEupj1P8k
	Ff++cG4e9058TLxSneRcYKGwbpXkEIcEOCdqOBc4bv5qe4s+UEPOqJiyt8IMrfhHrujS0a1TvSrRq
	pngMXeZL/EOE+Im1chPvSfFjl98dbiOQzcCwX37Z9XteNVZoy7TIj6iJhmQG+1O6drc8UseF/ocyE
	V2wqfk1lqu2rZMF6djwce2majk6ah2VigVjd2jKcMt2BZWffDb7vnSmcZBvQ+8bNAYGRP6wXhB0tN
	YiMJ57rUcHXtwNoOfyZ6MeMDE4r51fr39qZv/AgwR8R9UPkrHFOlqAvFeU+AQzGiPKFd0oIBjt6la
	ITehYA7g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxrI9-00000001eSE-3Q7V;
	Mon, 07 Oct 2024 17:13:05 +0000
Date: Mon, 7 Oct 2024 18:13:05 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v3 1/5] ovl: do not open non-data lower file for fsync
Message-ID: <20241007171305.GP4017910@ZenIV>
References: <20241007141925.327055-1-amir73il@gmail.com>
 <20241007141925.327055-2-amir73il@gmail.com>
 <20241007165540.GN4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007165540.GN4017910@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Oct 07, 2024 at 05:55:40PM +0100, Al Viro wrote:

> > +static int ovl_upper_fdget(const struct file *file, struct fd *real, bool data)
> > +{
> > +	struct dentry *dentry = file_dentry(file);
> > +	struct path realpath;
> > +	enum ovl_path_type type;
> > +
> > +	if (data)
> > +		type = ovl_path_realdata(dentry, &realpath);
> 
> ... but not here.
> 
> I can see the point of not doing that in ->fsync() after we'd already
> done ovl_verify_lowerdata() at open time, but what's different about
> ->read_iter() and friends that also come only after ->open()?
> IOW, why is fdatasync() different from other data-access cases?

Nevermind that one - the answer is that ovl_path_realdata()
calls ovl_path_lowerdata() only in case when it sees
!OVL_TYPE_UPPER(type) || OVL_TYPE_MERGE(type), which guarantees
that the type check below that if (data) will fail anyway
(check being (!OVL_TYPE_UPPER(type) || (data && OVL_TYPE_MERGE(type))).

So this reduces the fdatasync case to
	if (!OVL_TYPE_UPPER(type) || OVL_TYPE_MERGE(type))
		fail;
	ovl_path_upper(dentry, &realpath);
just as the fsync case reduces to
	if (!OVL_TYPE_UPPER(type))
		fail;
	ovl_path_upper(dentry, &realpath);

making any lowerpath-related stuff irrelevant.

