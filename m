Return-Path: <linux-fsdevel+bounces-63205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4C5BB263E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 04:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95924A2FCF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 02:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12522874F5;
	Thu,  2 Oct 2025 02:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TBaOH67e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E44F24CEE8;
	Thu,  2 Oct 2025 02:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759372624; cv=none; b=X0Bm1Zjts+F1Wmt1jqv2joz/WK6U32JgpGq1KnlLjJbOq50HLxMtG4H6JE3l+kY+Sqwh/a0gKLa0Qsx9FKkJ51inRN+Qs4H5pMVNqJp6NItYSz4cGZjZ3mGbE2NkqPZt3TRmXw06KMinClDUfosIWBkb+CIW3sxA7213oa0+efM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759372624; c=relaxed/simple;
	bh=KtziNFN2HjCmKyFttsjFKPM+bPdEFJbnW6oLxKpZjAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRqVeRAfvY0GX2fI6kQhiaGRJ1yRKXwE0WzuWQo9zF50dKNsnWATVwC6McT68pbexIrWLZYOWWVLi9YcQTLzV3D6huNZ1mAz+KrLWJbtfg5yS18VUwHbZPmvA+UH3JISacE4Xmpj/BZz69uDsu7l+kXES/jcAqDVycCSRNhY2Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TBaOH67e; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1PtrvZw9Xx0nfWQJFaBeBCNE0Kgw4sZ0jqy1AeaLn9g=; b=TBaOH67eOfKfJRh5NoIukfzqA8
	cudUZlZHBZ/+iywfg6GN+cpMDPZHqw6MPXF42/6clUfRCmd1S/24oQSFYKL4zSTgp7BnYuEPkow4V
	q38T7PJm/YsccTuNPY2ub8UuW+MHPC0vXxc1A8LUqyM8eIXBJyFsz7Puw8Gx7cX3XZCQ5MUwdqr5h
	kyowmUd7whkryT3Wq06SGILfIgcwvd00taUOI+8wcMUkO3UZkp4m7BL9K6YOaeyYREPbwZYdLyeMV
	X5ewq/RBEPB3f6nCv83qDvds95uOzjtaNH/HhFpnNs8PXKp22Tmzu5090De2fJhDKLcWiclje02Te
	89nx6Bpw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v49Bh-00000009GBr-13zP;
	Thu, 02 Oct 2025 02:36:57 +0000
Date: Thu, 2 Oct 2025 03:36:57 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] init: Use kcalloc() instead of kzalloc()
Message-ID: <20251002023657.GF39973@ZenIV>
References: <20250930083542.18915-1-mehdi.benhadjkhelifa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930083542.18915-1-mehdi.benhadjkhelifa@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Sep 30, 2025 at 09:35:37AM +0100, Mehdi Ben Hadj Khelifa wrote:
> Replace kzalloc() with kcalloc() in init/initramfs_test.c since the
> calculation inside kzalloc is dynamic and could overflow.

Really?  Could you explain how
	a) ARRAY_SIZE(local variable) * (CPIO_HDRLEN + PATH_MAX + 3)
could possibly be dynamic and
	b) just how large would that array have to be for it to "overflow"?

Incidentally, here the use of kcalloc would be unidiomatic - it's _not_
allocating an array of that many fixed-sized elements.  CPIO_HDRLEN +
PATH_MAX + 3 is not an element size - it's an upper bound on the amount
of space we might need for a single element.  Chunks of data generated
from array elements are placed into that buffer without any gaps -
it's really an array of bytes, large enough to fit all of them.

