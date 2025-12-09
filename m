Return-Path: <linux-fsdevel+bounces-71010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6959FCAF649
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 10:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 528CC304A8E2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 09:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EC62BEC45;
	Tue,  9 Dec 2025 09:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FYC8GaOo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BF9279346;
	Tue,  9 Dec 2025 09:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765271238; cv=none; b=PlbzFAH+BgbZa3VMASdyoojQY1NyRR/avLZT0GVK+2EabQDvy68+76IGSVrE/aTwDAP0/wR35BbbCUsan+MTF6rlXVh879p+4yHbH5dt3giTY9ioKsdE1S33upbRISuOSv18sh9OJCYGN1q8sVpT491ZHX0d87HUWhipLc8L558=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765271238; c=relaxed/simple;
	bh=+vvS6uB9qILJpmRoFLknOzf02bILDrbVIvhNyZVXE98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3xTzpD93CKg/uXkse/fLwXmrICkuuELTmDcHQpA0j7wPGbC2H61Fcna9Xut67nEuQza8xwjlEMjtF18VchHKv2aqGjQY0p0w8d1kPhOy6Ae8bd5nHInWRqUaPv9ZvZiXKLwQrTLaPVqd6dwlNVngEyVmrVh4SaNvzvwOPnA9uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FYC8GaOo; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fizB+0yNY0BnePfD/xX8vlrzcfWK6BoKAu35ymnUdP4=; b=FYC8GaOoGs4/UorsgZWpRyEFN3
	vRg6Iki2lf8B7RCaspbHtDR0iK/SYl53JI/KvvSNMyK+UV13DFRwlWySW37kWeth8FmMclHtWEU6Y
	MUWftN/dWCo87jHk0BUXKqOQdX4w/FjMqSL/oBnsCKAqOhG+Ji6dmm2Oz4uYashm8R0Z4tcoMXLu+
	StrzWCzkiLnuzncscyONt+7WoJnKd6dvfuOTC80/i4PRipQGdC0PBWr4CVdGwd7s5NU9zyW6ElAzR
	Q7MHaGv5gyEw5s2ZHWQb2uFp2H7SUg7k1Hrfbd5NddtFi7ctrh9O6lhFc7iPmCs7FxqQtvGPG7dGU
	hpknsSTA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vStgZ-00000004ReG-2Nl6;
	Tue, 09 Dec 2025 09:07:07 +0000
Date: Tue, 9 Dec 2025 09:07:07 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Laight <David.Laight@aculab.com>,
	David Lechner <dlechner@baylibre.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Gatlin Newhouse <gatlin.newhouse@gmail.com>,
	Hao Luo <haoluo@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Jason Wang <jasowang@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, KP Singh <kpsingh@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Marc Herbert <Marc.Herbert@linux.intel.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>,
	Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
	NeilBrown <neil@brown.name>, Peter Zijlstra <peterz@infradead.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Uros Bizjak <ubizjak@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Yafang Shao <laoar.shao@gmail.com>, Ye Bin <yebin10@huawei.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Yufeng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-sparse@vger.kernel.org,
	virtualization@lists.linux.dev, x86@kernel.org
Subject: Re: [GIT PULL] __auto_type conversion for v6.19-rc1
Message-ID: <20251209090707.GV1712166@ZenIV>
References: <20251208235528.3670800-1-hpa@zytor.com>
 <20251209002519.GT1712166@ZenIV>
 <43CDF85F-800F-449C-8CA6-F35BEC88E18E@zytor.com>
 <20251209032206.GU1712166@ZenIV>
 <87F4003B-5011-49EF-A807-CEA094EA0DAC@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87F4003B-5011-49EF-A807-CEA094EA0DAC@zytor.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 08, 2025 at 07:28:53PM -0800, H. Peter Anvin wrote:

> Yeah... the C committee even admitted they botched the spec; the intent was for it to work "exactly like gcc __auto_type"...

BTW, speaking of C23 fun that is supported by gcc 8, but not by sparse:
__has_include().

Do we want it?  At the moment nothing in the kernel is using that thing.
The main case for that would be <asm/something_optional.h>, and mostly
it's dealt with by dummy asm-generic/something_optional.h and mandatory-y
in asm-generic/Kbuild, but there are at least some cases where we have
it guarded by ifdef, a-la
#ifdef CONFIG_ARCH_HAS_ELFCORE_COMPAT
#include <asm/elfcore-compat.h>
#endif

Linus?  Seeing that I'm touching pre-process.c anyway for the sake of
__VA_OPT__, adding that thing ought to be reasonably easy - a bit of
work in expression_value(), the tricky part being where to stop the
scan: __has_include(< => scan to > and demand ) after it,
__has_include(string literal => demand ) after it,
__has_include(anything else => scan to matching ), and expand the
collected tokens.  The same dodge we use for #include ("anything
potentially fishy in header-name and it's an UB, so one can
simulate it with other pp-tokens") works here...

