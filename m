Return-Path: <linux-fsdevel+bounces-64991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADC5BF83D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 21:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49802543A6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 19:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC484351FBE;
	Tue, 21 Oct 2025 19:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LE5ecSBK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CE8338903;
	Tue, 21 Oct 2025 19:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761074646; cv=none; b=oB9ppqAjbTu0GmNId9dAM0fbiZcEK5p6I7EmF24t91aBLnrNEAva1oINHdkzlHgDZ4nsG12dXUIobIZ0Itsjv9azmMeIezas7j02kyLf62Sk/lS2/W4afDPPX4wyhKEki7PEUp7kgE7kCkyrjrLWglstRgstzRNmkTo08wHdqfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761074646; c=relaxed/simple;
	bh=E3LGhnnjVgNQvzdUA+dKvbHT5vkuigF/kle9qkfRNJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPk0S5B4Cpj7aLcSs4BMjUlYfCSdy2F+G1g/NviG3rIZMt0Thz++jbbG2nyLMcVb+sMUsEYAN2pJTPVk8n2lkbyBeVWr5RzGxP2ZjVwgDWkaC1bDaKhm7Pf1m+w8UoQk/h/OaCS2oC7hLSQDhlkwiVH/dO4+xpqWV73kFhZd5Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LE5ecSBK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A887C4CEF1;
	Tue, 21 Oct 2025 19:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761074646;
	bh=E3LGhnnjVgNQvzdUA+dKvbHT5vkuigF/kle9qkfRNJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LE5ecSBK83GkzI4Wj0VJBYE3yUZcsAyqzGy4/AgxqYwGy99uSaMSETMrytq3M8AuU
	 WK6GyDqqQWMcsaMa/luqgFcpOoF1S5wB7sHWT7xNe0r8zG+owalEYFXov8teus/o22
	 dG0dZyyQCs2m3hr5eUCMeHa70L3X/Tr+yvCjsCggxYgPPf3dWIGr906YwjKwliA1QF
	 zHrNJBobcqoYjRC/NfXzE4kOp2RGKaIxBNA59pDfukTP5wVa2D0zpBt3YO/wuBqjc8
	 7Wyc6gPsLjbhCyBq2jk2qADfhIlfUgsYvajgcTXSipNhXrl3hB0YXyPWhOfu19IcWR
	 okJq8kAypmH/w==
Date: Tue, 21 Oct 2025 12:24:05 -0700
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <202510211210.84D670D1C@keescook>
References: <20251020220005.work.095-kees@kernel.org>
 <20251020220118.1226740-1-kees@kernel.org>
 <20251021095447.GL3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021095447.GL3245006@noisy.programming.kicks-ass.net>

On Tue, Oct 21, 2025 at 11:54:47AM +0200, Peter Zijlstra wrote:
> On Mon, Oct 20, 2025 at 03:01:15PM -0700, Kees Cook wrote:
> > Introduce __counted_by_ptr(), which works like __counted_by(), but for
> > pointer struct members:
> > 
> > struct foo {
> > 	int a, b, c;
> > 	char *buffer __counted_by_ptr(bytes);
> > 	short nr_bars;
> > 	struct bar *bars __counted_by_ptr(nr_bars);
> > 	size_t bytes;
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
> 
> So why do we need both __counted_by_ptr() and this __sized_by(), won't
> one be good enough?

I remain extraordinarily frustrated that counted_by can't be used with
"void *". I hit a brick wall on this, though, and don't know how to
convince either GCC or Clang devs to fix it. It's so obviously correct
to me: "void *" uses a 1 byte iterator for arithmetic... so asking how
big a given allocation is should be byte sized!

Let me take another stab at it...

> Also, given the existing __counted_by() is really only usable with
> >=19.1.3 and we're now at 22-ish, do we really need two of these?
> 
> That is, I'm really hating the idea we need 3 different annotations for
> what is effectively the same thing and feel we should try *really* hard
> to make it 1.

As for avoiding __counted_by_ptr(), we could just raise the minimum
Clang and GCC versions to require this, but that means dropping existing
coverage (e.g GCC 15 supports only flexible array counted_by).

Maybe we could do a global __counted_by_ptr -> __counted_by replacement
once GCC 16 is released?

-- 
Kees Cook

