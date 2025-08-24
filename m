Return-Path: <linux-fsdevel+bounces-58897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DC5B3323C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Aug 2025 21:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63D437B2281
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Aug 2025 19:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0158B227581;
	Sun, 24 Aug 2025 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Dy0d5OMR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31721E8333;
	Sun, 24 Aug 2025 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756062440; cv=none; b=Lja1gUx4lQeV00buWdcGgRVspauzPNPmCuF1YQy4pgy6u8PhIPBY4mVMdky2feDQquOm9UckYhnB2f7FD47QpRSlGa2+ljOVWuyBeg+YvoT5BGHsX16eSYInQ/qrhkow1j26YI5OQmvv9kNC3Wbyh0WIY4/cWQotI3PNpSWYLlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756062440; c=relaxed/simple;
	bh=kY6/B5EaA7Ei8eIrK10uLi5SrUxg66S33BlHAdxVXJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iobfKRGs9EiGEgG1P1SWaC03pDtIspisb/5ENkDT2+G4+/xEJOHdY13UMRMI/xT40c2UFoIwSb7PlqvDNPQafGd5CgMFoFDgn/YOPTooy9WAJd9jl01sNL4hwp85VQqVTKihnJm1APGo2ERz+01q3czqzdUNOcb0qLheBOdh/C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Dy0d5OMR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wi6iIPAag0RC7sjf19JTRRdhSxQasu+WKvrfsTbroyU=; b=Dy0d5OMRveNPmgmDV9rnejeh1Q
	BiSwt/SLT+06g4Ihi8RevOmPpqWg2lQhWthCTmmfEF2kgToLw3C2coHzzUHo5nWnG5FkJF2wx8ilw
	b3ztrP5l4PD5eHawUV1QTiVfOwfXtcdFOeF+tyBB1XMLi3gVtnr+EjBxCDDneywlyRIhPgpNkg21Z
	jZFxz/M+eTqlx+IpjeA6oeha3P7Nzy8hXYHw39nv3iM5GSDpaAwoxLaocgJWgddBV74ecK/Of769s
	3JZrKGzaKhKAXAtxG93+kcfFHDr/c97KIVaKnTd6G3yWiJZQwHed625yWEfqa8KQS+1mpvdGTX/Xs
	wkcH8FCg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqG3e-0000000G5Yb-4BuA;
	Sun, 24 Aug 2025 19:07:15 +0000
Date: Sun, 24 Aug 2025 20:07:14 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: ssranevjti@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, jack@suse.cz,
	syzbot+0cee785b798102696a4b@syzkaller.appspotmail.com,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Subject: Re: [PATCH] fs/namei: fix WARNING in do_mknodat due to invalid inode
 unlock
Message-ID: <20250824190714.GG39973@ZenIV>
References: <20250824185303.18519-1-ssrane_b23@ee.vjti.ac.in>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250824185303.18519-1-ssrane_b23@ee.vjti.ac.in>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Aug 25, 2025 at 12:23:03AM +0530, ssranevjti@gmail.com wrote:
> From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> 
> The done_path_create() function unconditionally calls inode_unlock() on
> path->dentry->d_inode without verifying that the path and inode are valid.
> Under certain error conditions or race scenarios, this can lead to attempting
> to unlock an inode that was never locked or has been corrupted, resulting in
> a WARNING from the rwsem debugging code.
> 
> Add defensive checks to ensure both path->dentry and path->dentry->d_inode
> are valid before attempting to unlock. This prevents the rwsem warning while
> maintaining existing behavior for normal cases.
> 
> Reported-by: syzbot+0cee785b798102696a4b@syzkaller.appspotmail.com

No.  You are papering over some bugs you have not even bothered to describe -
"certain error conditions or race scenarios" is as useless as it gets.

Don't do that.  Fixing a bug found by syzbot is useful; papering over
it does no good whatsoever.

NAK.

