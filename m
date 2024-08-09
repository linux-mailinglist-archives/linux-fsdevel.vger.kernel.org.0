Return-Path: <linux-fsdevel+bounces-25578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2193194D912
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 01:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76EC1F22B82
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 23:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA86316C87C;
	Fri,  9 Aug 2024 23:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="me04RanF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2B526AE4
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 23:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723245706; cv=none; b=LpSSE4xEyuknbTaHBnv0CpfWjebYprOMTiGjAuoDpX43NU5ihJTFZsYrDBFuJYmRqWImICwGeN0/TNZ6ktFz/TQDUlttKRDhYmB5LStND4OPMCVPid88zpZHxcY7gWAAoJyyfCZN3GBj60RLaqdqOkb43phibHh1BkFPwdQ9kxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723245706; c=relaxed/simple;
	bh=x8lJFUwXprYIGb4UWWgOpwYuND7sBcY+s3up+b/dgRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssu4p8wRamivsGJ0E+FwLGZB2OsyQs+nFSjwQhr1YA3DuEsZFaXSoIoHJsfdY4bK/lp3vGbRNqrGQchLzXKw5gA1TC3mUjJsJmO+hTrmpEFm3mrAbzp0dMj5/bdTC1MCpRaTFnvj813KNC6rYzIqXUG2D+VFxx9uYAnm0Wsc/qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=me04RanF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tCN/dh3VRsVerLt9s4wND4r/1ENRfJ6xyuHKghUbMVo=; b=me04RanFcBHgrOpqCPTfdzNqMS
	7aROb1T6PquC1rrbN2/R7HwvUFcBomlXZCl2ZD0Eu+rfO0sri5z7DPxh0Ew1VeHZl5vd4gGMsllHI
	9OhoKJHvlOnHFDUJ5F2MpIIRFWs80+iMSJxs1+G9Dx8P921bSYu4CQnTAm0G6o5x1PUnvceo9zV1e
	wuMiSZ2Ok2wUs5to/ebmLjq4D5eOVB/eMUQV3lRtSzE/DaT2sShzavY81GEAvvZVESjMhrrtX1M7V
	UF+4xKzW/NK6dlp26KSz8M9XVX8NJT/TG91eDdYe8nuYaVo7K7gg/TcP1J/ALFt0X8UssDE08kVn/
	rSetflCw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1scYvU-00000000IQX-1QWJ;
	Fri, 09 Aug 2024 23:21:40 +0000
Date: Sat, 10 Aug 2024 00:21:40 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [DRAFT RFC]: file: reclaim 24 bytes from f_owner
Message-ID: <20240809232140.GA13701@ZenIV>
References: <20240809-koriander-biobauer-6237cbc106f3@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809-koriander-biobauer-6237cbc106f3@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Aug 09, 2024 at 10:10:40PM +0200, Christian Brauner wrote:

> fcntl()s and file leases can just allocate on demand easily. Cleanup
> happens during __fput() when file was really opend. For fcntl()s and
> file leases this is guaranteed because the file is already alive. For
> drivers they need to cleanup the allocated memory before they've
> succesfully finished ->open(). Afterwards we'll just clean it up.
> 
> Interactions with O_PATH should be fine as well e.g., when opening a
> /dev/tty as O_PATH then no ->open() happens thus no filp->f_owner is
> allocated. That's fine as no file operation will be set for those and
> the device has never been opened. fcntl()s called on such things will
> just allocate a ->f_owner on demand. Although I have zero idea why'd you
> care about f_owner on an O_PATH fd.

One general note: IMO you are far too optimistic about the use of __cleanup
extensions; it's _not_ something that we want blindly used all over
the place.  In some cases it's fine, but I'm very nervous about the
possibility of people starting to cargo-cult it all over the place.

Again, __cleanup support in gcc has significant holes, at least up to
gcc 12.

This is *NOT* a generally safe part of C dialect we are using.  And
the pitfalls associated with it are not documented, let alone generally
understood.

