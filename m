Return-Path: <linux-fsdevel+bounces-76923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKzmDPHni2kcdAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 03:22:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 881E5120C46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 03:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07CB1308A847
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 02:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A322F39BE;
	Wed, 11 Feb 2026 02:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Qge59cfu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E00280324;
	Wed, 11 Feb 2026 02:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770776491; cv=none; b=I3xYn6ADbGW/jDxmakMDABdFCDadYQVMRjVzomIGIPDjtO8GRt/GQMLKFWcoHabMmKBps/qOaKR8pMbvpkgB+5WlaWxwyPP+elwz3N4FfEXpKT9IPqYj1h1C6wGq4mr0tqcrVc+Kijnjrna7dg8rP70N8v+KpOadOdhx2bH4j2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770776491; c=relaxed/simple;
	bh=cynBJVM5vk3Nh0ijs+G7e0CUh0IFSFBo6KExgpHuhiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ng02Jz9vc7EaEaMPIpINkUgCoOCKXCkxI1FUOjijsefMyz2BlzZPGQFvfB4mrxGtHvBjrU+0uGYDvthXZfQh8+unQb7M1no60VMJXkD457ofOSZLJNqoBkjyx5erO7aiXD0PySAk9JZhD8p9SemtzSp62xWw/liEGynyAIBdxRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Qge59cfu; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TWonym77rAWoA+mRhPZypHFC7hQNiGXQAaD+O3JuAkY=; b=Qge59cfuedzmr47H7HZWU6BNFa
	wztpmWN0yrhsy9qHVwKI5JGpYAbhNHL6wZ633X0OfpNBhiBgvo1PIZNfgK+m7Qtnw/b0Fi67bp356
	Z/URrT+u8BvHYk2uBmA2cRPRgEn0VFGtj4oJnRHUvsLDRE8CJKmG5ITBDZOSTkFMErKNnTxiUAAED
	xYJXxfCB0cjhjIHKQxDvgmm5cPbXnYfEVqeavZa9oGAOtYLs5lcoNO13iX60IyLy/jxImUL1KWIiq
	VtxOFvaeqkOpVnFh5Xhq7mquf4ZIuF7UbGz+w0A1pgwYFg8glYf+b+irxvRtjGLhuzjDxu3NE+sIz
	3UtT7ozA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vpztF-0000000HP3i-0I0I;
	Wed, 11 Feb 2026 02:23:41 +0000
Date: Wed, 11 Feb 2026 02:23:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jann Horn <jannh@google.com>
Cc: Kees Cook <kees@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] fs: Keep long filenames in isolated slab buckets
Message-ID: <20260211022341.GL3183987@ZenIV>
References: <20260211004811.work.981-kees@kernel.org>
 <CAG48ez1GYR+6kZHDmy4CTZvEfdyUySCxhZaXRo1S=YyN=Fsp8Q@mail.gmail.com>
 <202602101736.80F1783@keescook>
 <CAG48ez1wxj5uxuMXQLV+yxfT4gumNSoK8UX2+K=5aCLAKg+VPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1wxj5uxuMXQLV+yxfT4gumNSoK8UX2+K=5aCLAKg+VPg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76923-lists,linux-fsdevel=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.org.uk:+]
X-Rspamd-Queue-Id: 881E5120C46
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 03:06:47AM +0100, Jann Horn wrote:

> > > I think this path, where we always do maximally-sized allocations, is
> > > the normal case where we're handling paths coming from userspace...
> >
> > Actually, is there any reason we can't use strnlen_user() in
> > do_getname(), and then just use strndup_user() in the long case?
> 
> I'm not an expert, but as far as I know, this path is supposed to be
> really fast (because pretty much every syscall that operates on a path
> will hit it), and doesn't care how much memory it allocates (because
> these allocations are normally only alive for the duration of a
> syscall). strnlen_user() would add another pass over the userspace
> buffer, which I think would probably have negative performance impact?

Sigh...  This is the case of path longer than 168 bytes (EMBEDDED_NAME_MAX);
that's not hard to trigger, but not exactly common.  What matters more is
that we really do not want to deal with the "now it appears to be empty"
case here - it makes the logics in the caller more convoluted and it's not
pretty as it is.

And no, it is not going to be presistent - the longest you can stick such
beasts in there is probably with io-uring; names copied in when request is
submitted and stay around until a worker thread gets around to finishing
the request.

