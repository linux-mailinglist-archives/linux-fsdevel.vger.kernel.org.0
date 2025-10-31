Return-Path: <linux-fsdevel+bounces-66625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74555C26E0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 21:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD757188E59C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 20:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939EC327790;
	Fri, 31 Oct 2025 20:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="J6dY3Cm4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4062E11A6;
	Fri, 31 Oct 2025 20:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761941882; cv=none; b=pEcYVBsvgdALma9gK7JEgp1qStGifJ3tKR7QqgrsGZUvSpItpICU6GMmMG9IWe3SiWJkDoXvpXVXe4pEX8TpEP9Pc3p1oRO8EUIrsgTRbdLxrHw0dBkQMyPP/H5qLyrclL/AfzZlDOHgl2dHL4fjAKHeZl/+vJQBP0BfHH7+KyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761941882; c=relaxed/simple;
	bh=ANfjRKTDBumqVnzSGxMUtE0u60fnIvXvMXynn9e7B9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kudGC/+WKdyY7Hx+lujHbhu23Bv6ZwNo7kMKxoAAEsadGiTexkb82x0Tn+C7CrXxjGZFghoC92AaJvfTdWWV+HKYwyuvF6aiajUfIrZtwsqOyJ/mzfzsb84cl5oB1LJdidrtdo6q4VKL1aYXXOqxNvvMaF+Gt8JE9Kz+zsGoSIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=J6dY3Cm4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hvvj1olFiGUWaOfStpqkjlz5LPohc8dQ3HsHoNUMM4U=; b=J6dY3Cm4NJlIrMAVxI42gQ13es
	BztzBkksn5oaPR37CxVeBRDEav3vPen/ICIF9L6IALzLwIVlyevU1ZKM570rVz6Mf4/AGu+JU+evH
	pUiuxxl71VgNdUw0/Z1BHOGPww34p2FZwc7/tOYCD8D2qNkqdmpF0qVp8fS61z9YGRgWWDtd+/20H
	n14jZhXi5QMEZrXu54hw1iB4fSwkfLyfQ9yvcYMxSMBY9IpbSBt+MsSzky06zzjcItHu0msabf4Qi
	N+hZD54DWrPcjcewgfSsjN1/y0Y3Oy8uevUz/IO5JjqSpjz15VRmUXORZvib1DxRbZuhUwW3TTIqN
	qgE8b5Tw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEvZJ-0000000BbrZ-1NoC;
	Fri, 31 Oct 2025 20:17:53 +0000
Date: Fri, 31 Oct 2025 20:17:53 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: touch up predicts in putname()
Message-ID: <20251031201753.GD2441659@ZenIV>
References: <20251029134952.658450-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029134952.658450-1-mjguzik@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Oct 29, 2025 at 02:49:52PM +0100, Mateusz Guzik wrote:
> 1. we already expect the refcount is 1.
> 2. path creation predicts name == iname
> 
> I verified this straightens out the asm, no functional changes.

FWIW, I think I know how to get rid of atomic there.  Doesn't
invalidate your patch...

Look:

0) get rid of audit_reusename() and aname->uptr (I have that series,
massaging it for posting at the moment).  Basically, don't have
getname et.al. called in retry loops - there are few places doing
that, and they are not hard to fix.

1) provide getname_alien(), differing from plain getname() only
in the lack of audit_getname() call.

2) have io_uring use it for references that might be handled in
a worker thread.

3) provide something like

struct filename *take_filename(struct filename **p)
{
	struct filename *res = no_free_ptr(*p);
	audit_getname(res);
	return res;
}

and have places like io_mkdirat() switch from
        ret = do_mkdirat(mkd->dfd, mkd->filename, mkd->mode);
	 
	req->flags &= ~REQ_F_NEED_CLEANUP;
to
	ret = do_mkdirat(mkd->dfd, take_filename(&mkd->filename), mkd->mode);

Voila - no need for atomic.  Prior to audit_getname() it's going to be 1;
after that only the thread that has called audit_getname() is going to see
the address of the object (and all accesses are going to be process-synchronous).
IOW, it becomes a plain int refcount.  Sure, we still want that prediction there,
but the atomicity cost is no more...

I'll post the ->uptr removal series tonight or tomorrow; figuring out the right
calling conventions for getname_alien() is the main obstacle for (1--3) ATM...

