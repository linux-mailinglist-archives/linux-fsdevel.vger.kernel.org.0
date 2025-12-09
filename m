Return-Path: <linux-fsdevel+bounces-71008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CDDCAF3BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 09:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 523AB302D29E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 08:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4E92877DE;
	Tue,  9 Dec 2025 08:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mV6ziBx/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676021F3BA2;
	Tue,  9 Dec 2025 08:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765267219; cv=none; b=Q1ahvLK7E3OdBOcUBswBWZLMHyMn1esi3deWDQG5V+Vd6yyMxS1UreCT8Npk3H4UCKinbxdq9xW2A00WOu912TcX7ZTeDzNak1LthKnDQolFfUcBEPB6xc/PqRwbk6eAqLNPc0pTycrf/faxLkizwoydym6/YK+AHo/Qep8NC2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765267219; c=relaxed/simple;
	bh=YO9+v82+HuMr+3h1x4u5rdw725E4tRb8gTUYSqFl4/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPpO9qR86zHdjdGIOWEOfe7pojMb0RRZSi+3IYD4yjN/G6CJqmWd4sSmF8Gk3GF0Kogvr4oZgICbUSByHEOs3qKVdxBehJiq3SYJEPVV2s2tRNkCtZMmBnMEPWmZrIMkOjgaUKgpHxnbuZfgzX0hGF6FyhBoKgpHD189oCTfrSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mV6ziBx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1125EC4CEF5;
	Tue,  9 Dec 2025 08:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765267218;
	bh=YO9+v82+HuMr+3h1x4u5rdw725E4tRb8gTUYSqFl4/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mV6ziBx/fbCZteXmx8DH2TpsDCBsgaaQ4Y+hqPT6wG6Fub5TBmy/dhDW6PkGA4WxG
	 0B0NlhNIjN4PfXcCScn/Oe5ZsssivZw+oNGE9QYXrf/9ZRzI11a91lc/OxFxUyUS49
	 s+11IHF5J699a/WJ+/nuB92z3rBlvUF1Gd7k0Oxk=
Date: Tue, 9 Dec 2025 03:00:16 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, pr-tracker-bot@kernel.org, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dan Williams <dan.j.williams@intel.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Laight <David.Laight@aculab.com>, 
	David Lechner <dlechner@baylibre.com>, Dinh Nguyen <dinguyen@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Gatlin Newhouse <gatlin.newhouse@gmail.com>, 
	Hao Luo <haoluo@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jan Hendrik Farr <kernel@jfarr.cc>, 
	Jason Wang <jasowang@redhat.com>, Jir i Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Marc Herbert <Marc.Herbert@linux.intel.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>, 
	Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>, NeilBrown <neil@brown.name>, 
	Peter Zijlstra <peterz@infradead.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Uros Bizjak <ubizjak@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Yafang Shao <laoar.shao@gmail.com>, Ye Bin <yebin10@huawei.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Yu feng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-sparse@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
Subject: Re: [GIT PULL] __auto_type conversion for v6.19-rc1
Message-ID: <20251209-kickass-analytic-eagle-f9e910@lemur>
References: <20251208235528.3670800-1-hpa@zytor.com>
 <176523908321.3343091.17738363732550848005.pr-tracker-bot@kernel.org>
 <CAHk-=wi0RqQPHME0xgrAZBQijKuos97cQO05N4f176DkH7msbg@mail.gmail.com>
 <ee693efe-5b7b-4d38-a12c-3cea6681f610@zytor.com>
 <CAHk-=wghm5NFZQcfObuNQHMMsNQ_Of+H7jpoMTZJDrFscxrSCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wghm5NFZQcfObuNQHMMsNQ_Of+H7jpoMTZJDrFscxrSCw@mail.gmail.com>

On Tue, Dec 09, 2025 at 12:33:26PM +0900, Linus Torvalds wrote:
> > Yeah, it commented on the master branch, which is of course ... yours.
> 
> Ahh. It's because you didn't use the standard pull request format, and
> instead did the branch name elsewhere.

It seems almost every maintainer has their own script to send a pull request,
even if many of them are wrapping git-request-pull.

I was just talking to Steve Rostedt earlier today about maybe teaching b4 how
to do that so that at least any new incoming maintainers have a more
streamlined way of sending a standard pull request in a format that is easy on
both Linus and the pr-tracker-bot.

-K

