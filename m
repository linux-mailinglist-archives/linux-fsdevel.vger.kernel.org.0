Return-Path: <linux-fsdevel+bounces-25157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B4B9497CC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 20:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CB1283F59
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 18:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2057712C499;
	Tue,  6 Aug 2024 18:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="GVcCwj3G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7548933086;
	Tue,  6 Aug 2024 18:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722970593; cv=none; b=Ggm0N4L+vb21CQuhuTjsIZdK8k23H/hdcqfSqyK2y71lCEuaYzwkUO8PZRi5NPhK5PCh4Q7q+NEj6QafW1BqCD9uZARv3Vodu8n2JQlhQcKfTWeavLZ5HW8KegYbUQ2HhI9rgRrpNH+Kzn9O4YO5yI33VYomdSZLoCUPCYCOt5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722970593; c=relaxed/simple;
	bh=cC2lYjJPOeCXoHkjABZhWFF525BVkW0UMBevjJbsMX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3HCt5XgSAjo6mFUryCVttJUaVYSxVRNsb+OnFT4rizQpsMmhw9VMeqSN2HiLaUTbajNHgHYj3HXL+6sO8w5aQ5uCJyxIdPfWJjCn0YspwJBp0viy7xox+NNoX4yX3tGTmp1+QjSrrTnmD40+5ahkMH/5sPfWIKkKSyyDQiSolw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=GVcCwj3G; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4QvL4Jpw3sWWcTod5vrw50TbAHneXynBbbFzWGbutx0=; b=GVcCwj3Gq9bsNgfn1o6TjClFyh
	u4x+Y+jCz/o1aUHRdU7z3odrKI7aqY1Wppyxek0zYktl/d9HRIpZ8qUiFpnAKoROmkKwn0wKfm8Dl
	fSnasluhuD9guL9rMUi/8T12i82E5BlQ5KmJ39etn7UoPrPoPGqOOk6Ud6ueQd2XZSNB6ySVVDoTd
	WDlGO3+tWytNAlWaTL90lrUvXgjVcdBX8EednBPbkjpxafm466rFZn5fczyHzb+iT7gEK6+TP5VhK
	bE2qUpf8kkN1cG1Z5k3WxzcWjfMxfy98Si2V05qGWtSwKaYz0ChH+kBpwccHpfqxviI4sfI4ZmvmK
	/feOO63w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sbPMC-000000022Sq-0GHK;
	Tue, 06 Aug 2024 18:56:28 +0000
Date: Tue, 6 Aug 2024 19:56:28 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, bpf@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>, kvm@vger.kernel.org,
	cgroups@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCHSET][RFC] struct fd and memory safety
Message-ID: <20240806185628.GR5334@ZenIV>
References: <20240730050927.GC5334@ZenIV>
 <20240806175859.GT676757@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806175859.GT676757@ziepe.ca>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 06, 2024 at 02:58:59PM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 30, 2024 at 06:09:27AM +0100, Al Viro wrote:
> 
> > 	* ib_uverbs_open_xrcd().  FWIW, a closer look shows that the
> > damn thing is buggy - it accepts _any_ descriptor and pins the associated
> > inode.  mount tmpfs, open a file there, feed it to that, unmount and
> > watch the show...
> 
> What happens? There is still an igrab() while it is in the red black
> tree?

... which does not render the mount busy.

> > AFAICS, that's done for the sake of libibverbs and
> > I've no idea how it's actually used - all examples I'd been able to
> > find use -1 for descriptor here.  Needs to be discussed with infiniband
> > folks (Sean Hefty?).  For now, leave that as-is.
> 
> The design seems insane, but it is what it is from 20 years ago..
> 
> Userspace can affiliate this "xrc domain" with a file in the
> filesystem. Any file. That is actually a deliberate part of the API.
> 
> This is done as some ugly way to pass xrc domain object from process A
> to process B. IIRC the idea is process A will affiliate the object
> with a file and then B will be able to access the shared object if B
> is able to open the file.
> 
> It looks like the code keeps a red/black tree of this association, and
> holds an igrab while the inode is in that tree..

You need a mount (or file) reference to prevent fs destruction by umount.
igrab() pins an _inode_, but the caller must arrange for the hosting
filesystem to stay alive.

