Return-Path: <linux-fsdevel+bounces-65071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E1FBFADB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 10:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F4B33A9DC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 08:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CB72FD1D3;
	Wed, 22 Oct 2025 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dJvJ5L6k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936AF3054C8;
	Wed, 22 Oct 2025 08:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121245; cv=none; b=bSenC+eabTh2vmAxgaPCTazznFrNemZE2l5W2MtvOTYeKeEI/x/55uhZUGtgFk0eG2fdlKilNABoufisAIenwD+hGTSifzdMxHnrRGTCHunD9OHirk9nAaX2syQyIt/2brCs7NuoTUi1kyS2ARlfkSvAe3tWc9DsVr5j9PuaBPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121245; c=relaxed/simple;
	bh=NaBVnYfiCGBUleVgENfqy+6MTH7byS2p6Wtyv6/P8ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rn9b/U80OjPVXYvloS+DNUPsw7gJQaXnmSIZ1yzk0BchPfQQEp6v5MoYAWd6BB0H7WxnvN+Idy1odDCH2RGKc06l2HoJ7Zi+m2nTqgxflrrAgvhojLJiBu0rwZ+TnnIK/Uhls6QgWo+rHzeJ9WXqvPMfEKqGSTEg+OCNOfazk9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dJvJ5L6k; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GBiS77jacBsAV5FtDUoak5VLXkPdQf0nis8KTJqTfW4=; b=dJvJ5L6kzK0cWDQUXS+9Sv/+VK
	d0CkMXZ8LBVpyOFapysJs3nZUl8zg9jTWIWcs7hMsJWUEWdw593rfTsyMVuBrGOxp7kergFX2kDAu
	kRHlMRJjX66XPkxAzIXHxKzcAfWzVZxuKDsExmSD0CeQS3y2h8LVClTy6lALGeurbtbN08tcGCYsL
	/vQ0qw1qBCzpwe3TRNnSukrnJKItuh8uQv7oB/ibvZYDRFJnxGZgGj3hljyUiY5aaxa8T1u6tEUgt
	R30bNScOmi92rDSwQ+MJbXLrbKxu56TMtKAKqiNxmdw3XTNl50zs1smUC/tD8rqphtpHS7p2v2heZ
	Evo5QUhw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBTDO-00000000P2b-0jqI;
	Wed, 22 Oct 2025 07:24:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7E1C730039F; Wed, 22 Oct 2025 10:20:25 +0200 (CEST)
Date: Wed, 22 Oct 2025 10:20:25 +0200
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
Message-ID: <20251022082025.GK4067720@noisy.programming.kicks-ass.net>
References: <20251020220005.work.095-kees@kernel.org>
 <20251020220118.1226740-1-kees@kernel.org>
 <20251021095447.GL3245006@noisy.programming.kicks-ass.net>
 <202510211210.84D670D1C@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202510211210.84D670D1C@keescook>

On Tue, Oct 21, 2025 at 12:24:05PM -0700, Kees Cook wrote:
> On Tue, Oct 21, 2025 at 11:54:47AM +0200, Peter Zijlstra wrote:

> > So why do we need both __counted_by_ptr() and this __sized_by(), won't
> > one be good enough?
> 
> I remain extraordinarily frustrated that counted_by can't be used with
> "void *". I hit a brick wall on this, though, and don't know how to
> convince either GCC or Clang devs to fix it. It's so obviously correct
> to me: "void *" uses a 1 byte iterator for arithmetic... so asking how
> big a given allocation is should be byte sized!

Right, at least for gnu11 language variants this really should work. I
mean, disallow the usage for c11 if you're pedantic but for crying out
loud, have the GNU extensions be consistent and all that.

Feel free to use my feedback if it would help.

> Let me take another stab at it...

Thanks!

> As for avoiding __counted_by_ptr(), we could just raise the minimum
> Clang and GCC versions to require this, but that means dropping existing
> coverage (e.g GCC 15 supports only flexible array counted_by).
> 
> Maybe we could do a global __counted_by_ptr -> __counted_by replacement
> once GCC 16 is released?

That sounds like a plan! :-)

