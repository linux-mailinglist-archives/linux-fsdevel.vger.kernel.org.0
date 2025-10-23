Return-Path: <linux-fsdevel+bounces-65276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4199ABFFC37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 10:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832FB3A2B74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 08:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4090C2EB5B3;
	Thu, 23 Oct 2025 08:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ib8RfyPK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604A92EA171;
	Thu, 23 Oct 2025 08:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206518; cv=none; b=V8Lnxd42LPMGVDRutC2InuvdOTjRfKYxGhLBSxhK40KVpMDl7HUo3DMuo+0ODBM9DfWRBJBae7e+hHVe+4SkiP5Y3Yo4+EUjFtMvcr9qOUCQd9LTXy3TfBY5vVm0EUR/51pXY5rFxmdvzPP9AZdtPV654Uc4oRvAsZrWY2NHiJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206518; c=relaxed/simple;
	bh=qm3FpmvOJC8J7ygv+lQ1G0UYsoWDYZ6/QPeqvcPbSrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHjSEBhmZN4TeZehmDaHauUDPMT/OFMl7o90w4jP5RLscpLm3L8hiSsNIttcqs9O5k/iZiG2PeB507cKR/dRN+i9jZZQEFkv/sRcGZXyhHD05kQNumrz++4snxpFsbNCadKedqbjzgtf7Vdsblr8QisceJgWfENEcdmcKMwOizM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ib8RfyPK; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0uRiRtjMBnl1I4Kw6RJyHI9dY+m7wLvqR6UCI8qoXds=; b=Ib8RfyPK0mNhsg+2sEx18TjMxr
	Z5xkFrIUzX9WrYQGh6/N3AIejfS0QZrHM4sznBb2Uhsic1CGl/Hc2lmGE4PPt5Ih1ZWcaAE8ffZOz
	m0cYOG6RjcIr4LCNtWIH1oDC1g8DM84ey/VhvQ1MIl7blZszOzzefbJE7Ip/1K46FRLmFZN1dbIQu
	ueLUJm4VG1Et/KbDILe3KKoXuzewC+wrJy877fjb2wyIxGtMDuvY0k8oMDXdNaDOFB/NKPTATKYqy
	X6KQueQWZHHsfv84ELzqqY/VQoMuwjI/75Eo8MFEii6dBgiSHTaa0KWyUyLGYGWgrIJv7lSCOrCi8
	pI1uprTA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBpOX-00000001Aev-1twR;
	Thu, 23 Oct 2025 07:05:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 39D66300220; Thu, 23 Oct 2025 10:01:23 +0200 (CEST)
Date: Thu, 23 Oct 2025 10:01:23 +0200
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
Message-ID: <20251023080123.GU3245006@noisy.programming.kicks-ass.net>
References: <20251020220005.work.095-kees@kernel.org>
 <20251020220118.1226740-1-kees@kernel.org>
 <20251021095447.GL3245006@noisy.programming.kicks-ass.net>
 <202510211210.84D670D1C@keescook>
 <202510221746.7C09BBE@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202510221746.7C09BBE@keescook>

On Wed, Oct 22, 2025 at 05:47:43PM -0700, Kees Cook wrote:
> On Tue, Oct 21, 2025 at 12:24:05PM -0700, Kees Cook wrote:
> > On Tue, Oct 21, 2025 at 11:54:47AM +0200, Peter Zijlstra wrote:
> > > > [...]
> > > > Unfortunately, this annotation cannot be used for "void *" members
> > > > (since such a member is considered a pointer to an incomplete type,
> > > > and neither Clang nor GCC developers could be convinced otherwise[1],
> > > > even in the face of the GNU extension that "void *" has size "1 byte"
> > > > for pointer arithmetic). For "void *" members, we must use the coming
> > > > "sized_by" attribute.
> > > 
> > > So why do we need both __counted_by_ptr() and this __sized_by(), won't
> > > one be good enough?
> > [...]
> > Let me take another stab at it...
> 
> It seems this will be acceptable as long as it is gated by GNU
> extensions.

Excellent!

> GCC patch in progress. Clang PR here:
> https://github.com/llvm/llvm-project/pull/163698

I think you've got your link mixed up, this appears to be arm-kcfi (also
good ofc). Either that, or I need copy/paste lessons.

This one?

  https://github.com/llvm/llvm-project/pull/164737

