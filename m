Return-Path: <linux-fsdevel+bounces-70993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DB9CAE7F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 01:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D80930633A6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 00:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7201E2FFDF5;
	Tue,  9 Dec 2025 00:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="IgtDr6bf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18FB1F237A;
	Tue,  9 Dec 2025 00:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765239948; cv=none; b=Z6NlLkcfPCr+hjbAs5MrR9hmd1wAy38KmHtaTbZMSpHmLMhEOi20JR7v1Fd/imYS6GifuN3wlaJNpyud0Eqw10iWXfXKKYor3lF4OE02iOF66xdlcJ9QTdFNZla8zB1sYOj1W77IlDsETdErMEI9Qs6rTO0epUCLvmJBRRrwbbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765239948; c=relaxed/simple;
	bh=ag0wk2+oh0ElMVYseACmvg+1SaIFyXnbyQM7PcXxwsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYqpzO9piMc8ncJlbl8LEK3oI3iREdvH3O/LLMr7iZfZQve5vZwaPjrCOYNtGLh1mdTMZ6jqiWT2zid535u5r3OZivmOAjt1SlymgB8WlmsmK/x2ykhj7qYmVpZLjBmd8T+81411o9XAARTlmEYBJ4iimGCL8VMPs/xDTBzn8Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=IgtDr6bf; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Kg+k6++JRM5UThRIhlKosdknn5TEgi2J/1lbtK7D1mQ=; b=IgtDr6bf4lDioQ8Yr3bCnsZBYs
	vBNzT1wKTK5jZK1ZKodtotRI2oVXvRA357laa7BL0IAa9Dh09cx7yPey/dMjFLYuhz6r3EBE4Feuw
	0FHb5nS/FjZ5VceGLPXDB7qcxcmjlImZeHfOHacxkIYJhuyU77K8ban6Njo1hvDOnVPCtJ1kcqHnL
	9+chILfizDHfDYmXFcYlBwi+ca8xF2Ust83mcVAiyoSd3GERnE7oP/3cQhGs7BEa1U5lLASuiR3dY
	ccxVgKW1laW+8MS30yjuwUhdQ63fFZwDWmjyG2IipPsGcq2x11/0Jl2ElyOW9aq4ER4bNAgyQuOHU
	wNc6Wvxg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vSlXb-0000000Fk4T-0wyY;
	Tue, 09 Dec 2025 00:25:19 +0000
Date: Tue, 9 Dec 2025 00:25:19 +0000
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
Message-ID: <20251209002519.GT1712166@ZenIV>
References: <20251208235528.3670800-1-hpa@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208235528.3670800-1-hpa@zytor.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 08, 2025 at 03:55:26PM -0800, H. Peter Anvin wrote:
> Hi Linus,
> 
> The following changes since commit c2f2b01b74be8b40a2173372bcd770723f87e7b2:
> 
>   Merge tag 'i3c/for-6.19' of git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux (2025-12-08 11:25:14 +0900)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-auto.git
> 
> for you to fetch changes up to branch auto-type-for-6.19
> (4ecc26fa585216f98d71411ce182f9e823d94c8c):
> 
>   tools/virtio: replace "__auto_type" with "auto" (2025-12-08 15:32:15 -0800)

Argh...  teaching declaration parser in sparse to handle that is
going to be fun, especially since there are corner cases where
gcc and clang do not agree, even with --std=c23 --pedantic...

