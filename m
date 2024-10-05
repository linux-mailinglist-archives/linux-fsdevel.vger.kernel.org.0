Return-Path: <linux-fsdevel+bounces-31087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2B9991B3D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 00:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6E3283491
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 22:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E655158861;
	Sat,  5 Oct 2024 22:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="R4CvDgY0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CE313635B
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 22:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728167320; cv=none; b=UyPZ9SS2uih0Lqa2Ys6U5eHy0vM9RLmw5xIFxR9I3DULyg4uUvCklAa5E+b0HjHrhBDZwYPwYQhdoJ9csn5q3c/8mQ1YkCgjjC5PSn9l0S1jsTfMEUKrTJRuuZOBZ0ZSwM6zlbPq6eXTKLSUI8EeHFLRMn5zvcht/loRncOB8Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728167320; c=relaxed/simple;
	bh=jgFJF5CryzgqHLrSW8cCI1bgH8FOakek2X5sMc/TLs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYlDsgJbiQL6IeAXErzHUsnCgSmdOTKW0AEVXeoiBfWGaWBq9z+p8qKLKws33BnvT54tVM1UwGv48pHz5nT0UvfNQGIADYcrhHyz0+fBGhywM4EdAPCw0WeE87C0pty4+Y932E3FWr5dAz39Wopuiz3bLKK/pGVgRXyKzUHChCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=R4CvDgY0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LpZ7DfvumzhMNhuFGPZJWx0Qahko0u0lqWRz8in5hBo=; b=R4CvDgY0t6xLLfSLo+cksQhOId
	f4yf7ObmTWG4BbcmfgmrypTjuA5xYAOuaNBB2af2uBKMKjR6TTiB4lH/IwN4OLRTHBMsSB5Xwpi1e
	3EgyBSupfAkeE8A2uuJZaWxZ7+Plb8uzYXShKjwaeqLkn5Yaw7YPoKEggXJyArZDfmc3VSVYse9Aj
	AQOBE6MzE+qsTI/WWHZzrDx2y0o3+WwYZZvDWCnDXVpwqAL914eOKdzk3ZllyB2i4SygRzekcM7ah
	djPK9nvvr7dM2g5QH/+3NHDLwOqfWGGQKi7CvmY7HjX0jLqArr3toVmD5sxW6B/wI4EE3Q5gZceMW
	5aRuQudg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxDGO-00000001BH7-15Fy;
	Sat, 05 Oct 2024 22:28:36 +0000
Date: Sat, 5 Oct 2024 23:28:36 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH RFC 0/4] fs: port files to rcuref_long_t
Message-ID: <20241005222836.GB4017910@ZenIV>
References: <20241005-brauner-file-rcuref-v1-0-725d5e713c86@kernel.org>
 <CAHk-=wj7=Ynmk9+Fm860NqHu5q119AiN4YNXNJPt=6Q=Y=w3HA@mail.gmail.com>
 <20241005220100.GA4017910@ZenIV>
 <CAHk-=whAwEqFKXjvYpnsq42JbE1GFoDR5LnmjjK_cOF4+nAhtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whAwEqFKXjvYpnsq42JbE1GFoDR5LnmjjK_cOF4+nAhtg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Oct 05, 2024 at 03:14:14PM -0700, Linus Torvalds wrote:

> There are probably other cases that just do "get_file()" on an
> existing 'struct file *" directly, but it's usually fairly hard to get
> users to refer to file pointers without giving an actual file
> descriptor number. But things like "split a vma" will do it (on the
> file that is mapped), and probably a few other cases, but I bet it
> really is just a few cases.

You can keep sending SCM_RIGHTS packets filled with references
to the same file, for example...

Anyway, which error would you return?  EBADF?  Because fget() callers
really expect a struct file reference or NULL.  Sure, we can teach that
to return ERR_PTR() and deal with all callers (not that many these days),
but then there's fdget().  I've looked through those recently; more than
half treats "not open" as EBADF, but there's a bunch of EINVAL, etc.

