Return-Path: <linux-fsdevel+bounces-44510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F458A69F82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 06:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 636F3189DDAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 05:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53AD1EBA03;
	Thu, 20 Mar 2025 05:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B33mFDNa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D27DB665;
	Thu, 20 Mar 2025 05:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742449821; cv=none; b=ntYNnv96JRFTfRrO703N3O8XFcQsMybRhq2M+AE5z/nm+XnIPK+LLzEOrVNBo5o0eSdShQM0vjFCy1FrtCbuMdiWNcE47g/ExyiOj8+QnmutgfPAnyQZWzddmkfB7TruiWMmmJTvgi+iDMzjlfRaXvXnLy7kydkDRLO1o9YtAK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742449821; c=relaxed/simple;
	bh=BXGKzOHEz1ClBhXem+aJPa6nOMKZChuKMiZ/tPuzmAQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9qmvzmjkLNf0s0P8hcmI1dZdz43MRNMzDDSxRh+5arYlEhFGMh+ZoG8eCedCip39IYINjJO5DH3H348bmlPzXm2x11B/nEaAKjOFHYgdVUDDnfZa0TPItVBpeunxN5HOQCshFbjoYGPEw2BfXpm5Enod3VdK9wdIX0Y2mqxU8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B33mFDNa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lhWq7dIR/TOnTpgqOBSfHCVpFoLt91BH+g7yyBM4SfI=; b=B33mFDNaZ+CkZcj4my3QZjC0Uh
	3PRZIy0Yp3Xsv4r3l5a2rvaDyvYCESYOlvCENoyiZcxNLLYDgYZKe9dZbLUFYAkPf53tM63I65PkK
	37RuqVbZKmSEDdqG4er4ZN6zEQDeMHNT6czXW25Cjc4XjidwEfa0mDtu4uM+qWuFvO5SVkpcnvDYW
	yjkENQtqmhR8xbECSergg7Ug3jQzrVEclDWbQb8kpVYfzTA0mY108r75769gwjlvJYFI3zMjcMB9j
	554LtXg6GRfgwtNcxC8m5D7rAczXTJEMLkY+lYdPzd/lFb4qvHS0tpwZ1jPmDUIrgGAYfePkg9FYa
	ZuAMnwFw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tv8nK-0000000BFYh-3rAt;
	Thu, 20 Mar 2025 05:50:18 +0000
Date: Wed, 19 Mar 2025 22:50:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joe Damato <jdamato@fastly.com>, Christoph Hellwig <hch@infradead.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	asml.silence@gmail.com, linux-fsdevel@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, kuba@kernel.org,
	shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com, arnd@arndb.de,
	brauner@kernel.org, akpm@linux-foundation.org, tglx@linutronix.de,
	jolsa@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
Message-ID: <Z9usmpFw7y75eOhk@infradead.org>
References: <20250319001521.53249-1-jdamato@fastly.com>
 <Z9p6oFlHxkYvUA8N@infradead.org>
 <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Mar 19, 2025 at 08:32:19AM -0700, Joe Damato wrote:
> See the docs on MSG_ZEROCOPY [1], but in short when a user app calls
> sendmsg and passes MSG_ZEROCOPY a completion notification is added
> to the error queue. The user app can poll for these to find out when
> the TX has completed and the buffer it passed to the kernel can be
> overwritten.

Yikes.  That's not just an ugly interface, but something entirely
specific to sockets and incompatible with all other asynchronous I/O
interfaces.

> > and why aren't you simply plugging this into io_uring and generate
> > a CQE so that it works like all other asynchronous operations?
> 
> I linked to the iouring work that Pavel did in the cover letter.
> Please take a look.

Please write down what matters in the cover letter, including all the
important tradeoffs.

