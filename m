Return-Path: <linux-fsdevel+bounces-64984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 259A2BF7DDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 19:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60C764FC5DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F05351741;
	Tue, 21 Oct 2025 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SW6rf5Xg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8871534E757;
	Tue, 21 Oct 2025 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067149; cv=none; b=X7pcX/fiscoJ3sTzkHlqkie/oLxbXv10TONURg7hdPTjYHxIU911clxPN6nRz9IcYVjh1fDAXz9uOF8Atu9guI0ZR3tFjKrlsAYvelZB9w3+psrsejaiQBaacqeHYz7xwwqw3Q7LKZHHU3x87DH6BVjhtgst9pCYmPMofc7MnXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067149; c=relaxed/simple;
	bh=hxf1/du0Cm/fGRIxX6xgrYuL9mLBf2Hbe+qcVpZ5Km8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jp4eIfbxXVw9wc1wunu7weiTKZWwvZg5P/qm57As9GofsO6WSP4tLTEvJbMP8zbIBHXYOR+u6bUO/eJ+PwvVBobu3YBxJheIQz9Q4FhhGn8ftR2Sdl7UAzaxjtP/EnQZOSdW/RxZESzojJMLKwoMHgCFyaRJ4B1hS+PgZMoV+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SW6rf5Xg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QI9r59C1k+bEW/3dTiniqc9OPZciLkuhEEc0yCekJCc=; b=SW6rf5XgBSv9OSWDER9GUhoD3I
	fEPjCqXGWGOaGckd1Avw4ryZVi4jwunbuA0Qu+PSpetTY7+YnD2ENR1E6U6ChWCPdNP0KRU/7vyJ0
	pGbelOWGliDe3jZQlnQCpVqVBljpvwRyKEEjVpVjIVhT9QEvLwQILZfz4UCwGc0a7ObWS9WT+eGU0
	r9ioF2sBwwbAhYC7InSuzYlSJpgPP2um2EFDyTk96IY7gi07MeOEY0k3C5hsj2OwHi1A/6/qzqwGc
	7m8umfBiaMl4KqfAUpJOfHdOCBd7oAfgwqqho89qegrfqJNefNNb7qe2bumWvzsNsmueTarSVXRBZ
	OCMc+k0w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBG0d-0000000DsXW-17GC;
	Tue, 21 Oct 2025 17:18:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D139D3030FA; Tue, 21 Oct 2025 11:54:47 +0200 (CEST)
Date: Tue, 21 Oct 2025 11:54:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Marco Elver <elver@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Johannes Weiner <hannes@cmpxchg.org>, llvm@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Tamir Duberstein <tamird@gmail.com>,
	Michael Kelley <mhklinux@outlook.com>,
	kernel test robot <lkp@intel.com>,
	Heiko Carstens <hca@linux.ibm.com>, Uros Bizjak <ubizjak@gmail.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Yafang Shao <laoar.shao@gmail.com>,
	Marc Herbert <Marc.Herbert@linux.intel.com>,
	Christopher Ferris <cferris@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Paolo Abeni <pabeni@redhat.com>, Tejun Heo <tj@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/3] compiler_types: Introduce __counted_by_ptr()
Message-ID: <20251021095447.GL3245006@noisy.programming.kicks-ass.net>
References: <20251020220005.work.095-kees@kernel.org>
 <20251020220118.1226740-1-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020220118.1226740-1-kees@kernel.org>

On Mon, Oct 20, 2025 at 03:01:15PM -0700, Kees Cook wrote:
> Introduce __counted_by_ptr(), which works like __counted_by(), but for
> pointer struct members:
> 
> struct foo {
> 	int a, b, c;
> 	char *buffer __counted_by_ptr(bytes);
> 	short nr_bars;
> 	struct bar *bars __counted_by_ptr(nr_bars);
> 	size_t bytes;
> };
> 
> Since "counted_by" can only be applied to pointer members in very recent
> compiler versions, its application ends up needing to be distinct from
> flexible array "counted_by" annotations, hence a separate macro.
> 
> Unfortunately, this annotation cannot be used for "void *" members
> (since such a member is considered a pointer to an incomplete type,
> and neither Clang nor GCC developers could be convinced otherwise[1],
> even in the face of the GNU extension that "void *" has size "1 byte"
> for pointer arithmetic). For "void *" members, we must use the coming
> "sized_by" attribute.

So why do we need both __counted_by_ptr() and this __sized_by(), won't
one be good enough?

Also, given the existing __counted_by() is really only usable with
>=19.1.3 and we're now at 22-ish, do we really need two of these?

That is, I'm really hating the idea we need 3 different annotations for
what is effectively the same thing and feel we should try *really* hard
to make it 1.

