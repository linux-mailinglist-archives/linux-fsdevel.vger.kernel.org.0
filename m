Return-Path: <linux-fsdevel+bounces-71000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A43F6CAECD8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 04:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8FF330DE34F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 03:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836E4301491;
	Tue,  9 Dec 2025 03:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gxN6q6F4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3720621CFE0;
	Tue,  9 Dec 2025 03:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765250544; cv=none; b=jUG/nuCG4DS6HlUJbbBorw7FqKHG2EOcHR9D5cdIuwuBM1DpT1z55ovAeY79HwbZHWRZWtjVBzft85k7+Oklo2G8x1VfeyoJKkTwcfa+qULFT0VRSCbSy+KOeiZNqZDk85rZS1+mi2dpjwL60kfccIjttt0zGQ6iuz7auMNIxKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765250544; c=relaxed/simple;
	bh=tH2g2z9omM4/JHv6mQBchKg1gzjCb+O1ocl6x2ncXo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUrPYTXy8h3nxO0Zrfda8FqSQKlcBVMhYG0aY7xlElRhHa4vK0UGCT4lQOCEydVvkGxKqN8QfGPOtxz68bGGkvrMNKVSU7qrnsgWhON/9og/Ji3faktTc3/DsbMp3nTsCItdnEF9tbGlZLbIuVffgTvBcz6az3m39PWVVSl7cg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gxN6q6F4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=udLaiaKEVaHYrpv87pXnuw9Ta9sXf4k84Q18s1uDrsk=; b=gxN6q6F4qEjusZhHyUxsAS+Fm5
	EgzJ4nLzDcguIn7/hY1EgYT7vhUjhRhIVxkM0xTFDu34z+zAhUOHLTsWHim+usEmT7X1rjui915Zu
	1JPH0Mu3PtDijNrFECDDH38Jnxt6v2l0y95hjO5SJijCeXyXFqiBUOLbrpyjNWq2FD1iud+ooFW8C
	gwp1IhFmVxyQcO+qd+fJ5l0Ds35aOSrUGjcLJwSuW/6xUnSpmcSGIhPGzHQBsP85eqQGEA/2spibn
	jWSPxIYPCE5RAwvYOQ825HFBmjVm7TL9TEPKnuIqXzKA3fXtnEWbSh7JN6k3wSxtSiUb2hu2hWSO9
	twRz13xg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vSoIh-00000000si6-04XN;
	Tue, 09 Dec 2025 03:22:07 +0000
Date: Tue, 9 Dec 2025 03:22:06 +0000
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
Message-ID: <20251209032206.GU1712166@ZenIV>
References: <20251208235528.3670800-1-hpa@zytor.com>
 <20251209002519.GT1712166@ZenIV>
 <43CDF85F-800F-449C-8CA6-F35BEC88E18E@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CDF85F-800F-449C-8CA6-F35BEC88E18E@zytor.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 08, 2025 at 04:28:11PM -0800, H. Peter Anvin wrote:
> On December 8, 2025 4:25:19 PM PST, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >On Mon, Dec 08, 2025 at 03:55:26PM -0800, H. Peter Anvin wrote:
> >> Hi Linus,
> >> 
> >> The following changes since commit c2f2b01b74be8b40a2173372bcd770723f87e7b2:
> >> 
> >>   Merge tag 'i3c/for-6.19' of git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux (2025-12-08 11:25:14 +0900)
> >> 
> >> are available in the Git repository at:
> >> 
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-auto.git
> >> 
> >> for you to fetch changes up to branch auto-type-for-6.19
> >> (4ecc26fa585216f98d71411ce182f9e823d94c8c):
> >> 
> >>   tools/virtio: replace "__auto_type" with "auto" (2025-12-08 15:32:15 -0800)
> >
> >Argh...  teaching declaration parser in sparse to handle that is
> >going to be fun, especially since there are corner cases where
> >gcc and clang do not agree, even with --std=c23 --pedantic...
> 
> Well, until sparse actually handles C23, this is just a macro.  __auto_type is already in use.

Just anticipating the joy of getting declaration parser to deal with that
properly - there's bunch of fun corner cases where this macro wouldn't
cut it.  Sure, the underlying semantics can be mapped onto __auto_type,
but the actual syntax is bloody awful, especially when you mix the
typedefs into it.

Speaking of other fun sparse stuff: __VA_OPT__ support needs to be added;
I think I have it plotted down to reasonable details, will post in a day
or two...

