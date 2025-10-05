Return-Path: <linux-fsdevel+bounces-63441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7361EBB94FA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 05 Oct 2025 11:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257EA3B7EA8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Oct 2025 09:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C57237165;
	Sun,  5 Oct 2025 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NANlqXQ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968F74F5E0;
	Sun,  5 Oct 2025 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759654918; cv=none; b=Xpa5vOhXwn51AL3vUu34aQmGY7UrLnrL9zuGM3NCbOYtH35ZT++TUynkxUHrq61f6G3+9I8o9opaxLgCVpsu3oFvaUln6jRudC7JRDskEv7p2F4cAxYPspYG7mCVlS5Hbm7yHEQ4vOtteMy3K4wAq/LwG5axNs2+U2/v0F2gmuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759654918; c=relaxed/simple;
	bh=ruSIOi8cxJhaTEz5uwpfuf5bGlZ4IWTtrl9ZQQR8irk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ew6nrbynR4tEuE5Uo2fQUs+Oo/DVIv/2wgwc0SFUbqSa8hIXswlotWElUYtTawMHeBYH0CS3pzjw/qw4NJaopkVcG0kyWi6bhk4vnjlm5VQ5PeEazbg3NNZhUyKJK9L7EGwdOdPY8+4pfXbzTIL34LiZVRVJb9e9kUZz5oxnRyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NANlqXQ/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=WVxoh7xrdV57yDzDDRJoT49omMHhETGCnKdD+7NLzGE=; b=NANlqXQ/44AvovIlDfLGNhPgYa
	scmEBdVmWMmaFORHhoS9oaAgPWi8y9bkyy/VeEcCA8eZO162hI5aKMviVPQfmTmK1s75I9vndvXGi
	iwzEyvW1kcp3g3fzDV8W6wGQ0+5fjhIJrXuL7sx9uKvyO9/fyJnCYBXkAk9+VBU+9xrRj31mFCAbC
	KV/EoImprZlRtCqOYOWttvsDdxXF6j9dgWKJnWQi3vgTe2hbO9o9C+4HqZx3edtOIXXK2woT+Y4Dy
	ELoovY4SMOxnp8rSKZIiP8N7Kr6/f3Uq7INI7aotqDaG89sytZa4/7+TPcoZsWVMQT6N8VzPXXXXE
	e0TRqgGw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5Kcq-00000007vOO-3Mn3;
	Sun, 05 Oct 2025 09:01:52 +0000
Date: Sun, 5 Oct 2025 10:01:52 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Miquel =?iso-8859-1?Q?Sabat=E9_Sol=E0?= <mssola@mssola.com>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	linux-kernel@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH] fs: Use a cleanup attribute in copy_fdtable()
Message-ID: <20251005090152.GE2441659@ZenIV>
References: <20251004210340.193748-1-mssola@mssola.com>
 <20251004211908.GD2441659@ZenIV>
 <878qhpc3ip.fsf@>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878qhpc3ip.fsf@>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Oct 05, 2025 at 07:37:50AM +0200, Miquel Sabaté Solà wrote:
> Al Viro @ 2025-10-04 22:19 +01:
> 
> > On Sat, Oct 04, 2025 at 11:03:40PM +0200, Miquel Sabaté Solà wrote:
> >> This is a small cleanup in which by using the __free(kfree) cleanup
> >> attribute we can avoid three labels to go to, and the code turns to be
> >> more concise and easier to follow.
> >
> > Have you tried to build and boot that?
> 
> Yes, and it worked on my machine...

Unfortunately, it ends up calling that kfree() on success as well as on failure.
Idiomatic way to avoid that would be
	return no_free_ptr(fdt);
but you've left bare
	return fdt;
in there, ending up with returning dangling pointers to the caller.  So as
soon as you get more than BITS_PER_LONG descriptors used by a process,
you'll get trouble.  In particular, bash(1) running as an interactive shell
would hit that - it has descriptor 255 opened...

