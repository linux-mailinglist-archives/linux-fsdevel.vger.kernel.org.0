Return-Path: <linux-fsdevel+bounces-64983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F209FBF7DC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 19:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE7F246152B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E4C34F264;
	Tue, 21 Oct 2025 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AsbCUW7u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213E534D4EB;
	Tue, 21 Oct 2025 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067147; cv=none; b=MFwqmIHnt0WLI/lwFqVlGTAPzDXdqJ0hIFIGOxU4L+QXgUZew+gjJ+qh0Hb1XxiQOcdsHf1ttQdz5oVsyWmKuSel4UeLCiYhoVvnbOYQRXbeTT45iAkWbdEuIlz47xTmb4fxaa4049N3c1kroSxbJfXhhpWy87IorVlGEqVEls0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067147; c=relaxed/simple;
	bh=+bRiLb5dQAvRN4R9gkpLifGt86iHL6GjIh9D2uxZEnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfbjDUWbNOY7NdcmqXM3DSovfV6Q4rvbIXpktOzG0j8H9lku2LZHuXzNeQ/RLnk37aVRiZsWu1tNdkqCwaE2lY2Iv4tusDXx/dpDOg6QRQ8lPaMwKykBxvSiKYone3N5Va5xoUMxlAJSXcQy7+UTyAdHPD6OdpsUp5BruMPOqoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AsbCUW7u; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=3kQP4yV9UYdKyPruWtgSSnS3+OsO9+ZfKrTdjVj28bU=; b=AsbCUW7uoEw4D6UkYmckrB21EA
	UwGd31LewtCpEHLg4WsMUXp7Zj3+2yX2ud+RBu8Dr2kHv3qs2XPD2cHi8XKHyzNMYgGR3/7ozRYPW
	hlBlWgy6HcWaxP9lJgmc9PK9eNYCVuQmZFW9I+SsJFZx6nyNy0jSkVOfXBq9k6q8Dvedi7B+G3uaf
	dGslZlog/zvcQV9X/Y5c31q5946IzGhYRH3oPNlIvqzvoLIg+gZ3/PT/NN4n6Lx3dZx3vqKFAh/yT
	IEZApwcrK59mZNVsZz3+J7FC9WH4E2g1bxSpHGih4DNVs+3NA6ef1VqtX/9kNWsWmHEYcRbKWrXxt
	IWBcvPVg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBG0a-0000000DsSb-2NOb;
	Tue, 21 Oct 2025 17:18:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 57FE730315A; Tue, 21 Oct 2025 11:59:36 +0200 (CEST)
Date: Tue, 21 Oct 2025 11:59:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
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
Message-ID: <20251021095936.GM3245006@noisy.programming.kicks-ass.net>
References: <20251020220005.work.095-kees@kernel.org>
 <20251020220118.1226740-1-kees@kernel.org>
 <CAGG=3QV7-W5vEPNtABghg=ktn6kKs45_e-PWBT9oCUzURod1bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGG=3QV7-W5vEPNtABghg=ktn6kKs45_e-PWBT9oCUzURod1bg@mail.gmail.com>

On Mon, Oct 20, 2025 at 03:53:55PM -0700, Bill Wendling wrote:
> On Mon, Oct 20, 2025 at 3:01 PM Kees Cook <kees@kernel.org> wrote:
> >
> > Introduce __counted_by_ptr(), which works like __counted_by(), but for
> > pointer struct members:
> >
> > struct foo {
> >         int a, b, c;
> >         char *buffer __counted_by_ptr(bytes);
> >         short nr_bars;
> >         struct bar *bars __counted_by_ptr(nr_bars);
> >         size_t bytes;
> > };
> >
> > Since "counted_by" can only be applied to pointer members in very recent
> > compiler versions, its application ends up needing to be distinct from
> > flexible array "counted_by" annotations, hence a separate macro.
> >
> > Unfortunately, this annotation cannot be used for "void *" members
> > (since such a member is considered a pointer to an incomplete type,
> > and neither Clang nor GCC developers could be convinced otherwise[1],
> > even in the face of the GNU extension that "void *" has size "1 byte"
> > for pointer arithmetic). For "void *" members, we must use the coming
> > "sized_by" attribute.
> >
> I'm pretty sure that "sized_by" is available in Clang right now.

My clang-22 build seems to accept it no problem indeed -- although I've
not verified it actually does anything with it.

