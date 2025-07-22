Return-Path: <linux-fsdevel+bounces-55705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB20B0E212
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 18:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 870247A65A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 16:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2E227E066;
	Tue, 22 Jul 2025 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGebIkmi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A2227AC57;
	Tue, 22 Jul 2025 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753202454; cv=none; b=tHuIIxVUEgaoR5bxmUJ4lG+sgY5PGTuaAP1/yiBl2zDK3Py3GrhzHUM0AR3c3r7B8DlD7b/33L9WHm/bmx/90H9BF/DZXcXBbF+xjQutLG7dpmNM78nwtQr0JnjlKxI9CKmySPoSwL3Y6mDg8RSSbPCN8weOY0TVHCfTPV/Oa00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753202454; c=relaxed/simple;
	bh=airQyOAZ1Bb21STyZQ/0koQyH4JJ9mEFvxRJ/K+2RGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sRVUNNU45A9igqkMhlSnZttR51sbwr9P8yrQqaHLaHCWJPXrwYJnUF/lideqH8OtdDXypoKX52CZ9PjhXcwImyAe5E2o/Z+hMNIxyMeccps1Uqm6I5cwgegfVsh+vlmMTxWGtNnEujgpSktU96tciTptlxY5y8H8bBtweHTvvm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGebIkmi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB47C4CEF1;
	Tue, 22 Jul 2025 16:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753202453;
	bh=airQyOAZ1Bb21STyZQ/0koQyH4JJ9mEFvxRJ/K+2RGs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HGebIkmivaIby4umGllHirYAZa1/fB0/I7hv187bGX1UyQ4JpVveA2is/M55Fsp2I
	 bGEmvYBKodu6AqzK+KmTuf9s2S3b8crnHDVQOaiwtmKzFBZpm5d0z6eUgw9DCqdiRc
	 UqY1GL2TbDfkZN/te2DQPyNVzcyXkUrbVtrXQjngaZyKTk6C8A9daClKSTYsdnrjNv
	 niRoioWJu/pZB6ruZEguQcWOpbj0xqP5CjKDjF04PM0NDDJZG7NmcLkEpdJa6tkAo/
	 N557ktHd1Ww9Bf+TK7w8EhXF2S1TzwzDNskE5qLu9iLwSWCCh8bbw0Nl5eCM5UvaTT
	 /Z8Ylz0g0WRvg==
Message-ID: <c73d2b1c-5f19-4e03-935c-71f68aa8bca7@kernel.org>
Date: Tue, 22 Jul 2025 11:40:47 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] arch/nios2: replace "__auto_type" and adjacent
 equivalent with "auto"
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Alexei Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrii Nakryiko <andrii@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Laight <David.Laight@ACULAB.COM>, David Lechner
 <dlechner@baylibre.com>, Eduard Zingerman <eddyz87@gmail.com>,
 Gatlin Newhouse <gatlin.newhouse@gmail.com>, Hao Luo <haoluo@google.com>,
 Ingo Molnar <mingo@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jakub Sitnicki <jakub@cloudflare.com>, Jan Hendrik Farr <kernel@jfarr.cc>,
 Jason Wang <jasowang@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Kees Cook <kees@kernel.org>, Luc Van Oostenryck
 <luc.vanoostenryck@gmail.com>, Marc Herbert <Marc.Herbert@linux.intel.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>,
 Michal Luczaj <mhal@rbox.co>, Miguel Ojeda <ojeda@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, NeilBrown <neil@brown.name>,
 Peter Zijlstra <peterz@infradead.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Thomas Gleixner <tglx@linutronix.de>, Thorsten Blum
 <thorsten.blum@linux.dev>, Uros Bizjak <ubizjak@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Yafang Shao <laoar.shao@gmail.com>,
 Ye Bin <yebin10@huawei.com>, Yonghong Song <yonghong.song@linux.dev>,
 Yufeng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-sparse@vger.kernel.org,
 virtualization@lists.linux.dev, x86@kernel.org
References: <20250720065045.2859105-1-hpa@zytor.com>
 <20250720065045.2859105-5-hpa@zytor.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20250720065045.2859105-5-hpa@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/20/25 01:50, H. Peter Anvin wrote:
> Replace uses of "__auto_type" in arch/nios2/include/asm/uaccess.h with
> "auto", and equivalently convert an adjacent cast to the analogous
> form.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> ---
>   arch/nios2/include/asm/uaccess.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 

Acked-by: Dinh Nguyen <dinguyen@kernel.org>


