Return-Path: <linux-fsdevel+bounces-16248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DA589A8BD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 05:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296CF1C2116B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 03:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C4A1CD13;
	Sat,  6 Apr 2024 03:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mkJ5Oh/V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951781BF53;
	Sat,  6 Apr 2024 03:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712375700; cv=none; b=hvkEZPFMY6g6UBV7+OFNOw9ejO+qivQogcY2cor8qIjMfJbQhgK7aVF+r9OEzBKvzLzUWFBdLqzyDDVybExz9qVL797X/akDmAjdLitMpIo4I6sUnnt1g3d0jDsNCRjP30JVyW6KKfQOVaaa3UF1qm76+61KquGObH8C5f73acg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712375700; c=relaxed/simple;
	bh=J9Pil6B0QWphwbvAIIjA6LN7eFJSzQShOiLj2RiRIf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWuf6fHb4/nHx6wFxPxSHnwuMZF7wUxP+9dteFYwFrPPD4+IReRVxrpsUAk/srppiplsqrxVH+KuhwosoM2CJNIYpEpgq2dQW7PSLmTwTy4Iu1mz3VmGIIevkij/1+emJPc+mL+kVcxbPvDYf8dkDLniIQUyNbfNZS/9Ecbchj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mkJ5Oh/V; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tCa6rfErMsA8fqEi+dhlV3QZnsxtzKsW1TXiEWTq/yE=; b=mkJ5Oh/VsTC5pF4gQNJP9c7p3y
	U2gJXyrZHkctdnKTPMo/9Fy+0MyxkgWnjO6N7wqYli0CGuchsaPQvHpHRFabIQudnHgU/NBO6TjSZ
	Nt84w8FuEcSedgxbYReZAhGlirRI1PIEUHBKr+t77zBYp8+xccKWVIAWVPQ6/Sve0xaTiOscV4Lba
	5ZLRHZNeL5NDfujPeizipAfdPN6PhZbSlzWMqgejqcn2McwoVGTr2vPJei1Q5Ql1P/Vd8/+2nQTvA
	coFlnndd2JzOiyohlFHNhlRyNUmIqlhYI4cMyfbLYtT15AIEITLMeToAZynUJJQXZ6RZLsiAX37Ou
	PS7bOO3Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rsx8l-006p0r-0d;
	Sat, 06 Apr 2024 03:54:51 +0000
Date: Sat, 6 Apr 2024 04:54:51 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Amir Goldstein <amir73il@gmail.com>,
	syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>,
	gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	tj@kernel.org, valesini@yandex-team.ru,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
Message-ID: <20240406035451.GW538574@ZenIV>
References: <00000000000098f75506153551a1@google.com>
 <0000000000002f2066061539e54b@google.com>
 <CAOQ4uxiS5X19OT2MTo_LnLAx2VL9oA1zBSpbuiWMNy_AyGLDrg@mail.gmail.com>
 <20240404081122.GQ538574@ZenIV>
 <20240404082110.GR538574@ZenIV>
 <CAOQ4uximHfK78KFabJA3Hf4R0En6-GfJ3eF96Lzmc94PGuGayA@mail.gmail.com>
 <20240405065135.GA3959@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405065135.GA3959@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Apr 05, 2024 at 08:51:35AM +0200, Christoph Hellwig wrote:
> On Thu, Apr 04, 2024 at 12:33:40PM +0300, Amir Goldstein wrote:
> > I don't follow what you are saying.
> > Which code is in non-starter violation?
> > kernfs for calling lookup_bdev() with internal of->mutex held?
> 
> That is a huge problem, and has been causing endless annoying lockdep
> chains in the block layer for us.  If we have some way to kill this
> the whole block layer would benefit.

Specifically of->mutex or having pathwalk done from some ->write_iter()?

Incidentally, losetup happily accepts sysfs files as backing store.
I don't think it adds problems we don't have otherwise, but IMO
that's really bogus...

