Return-Path: <linux-fsdevel+bounces-55531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D304B0B78C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 20:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D007A1894F02
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 18:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B831922258E;
	Sun, 20 Jul 2025 18:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="en1vXU/X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BAF84D02;
	Sun, 20 Jul 2025 18:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753034826; cv=none; b=k5+bxXHdpvNXNadt5bRi06wkiTAUlww5szAxqIEiTMuU42RfhtpYBpv5JJMBLXdY+cmMN50gTbqtJkooz+aMMjj2QNJIG+FHLutqslkb/nNf/wTimxe8cGvDJsCkgLMgyMa84YmdmNDsJUeMUokVRz0PiSJBZ2cLHhBwilvk+S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753034826; c=relaxed/simple;
	bh=KdWwGjYoJDSltOHUgbcqHnR8whKcVBigwZqCJWFeLek=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Xl2ZSkLOMJJxgFv31HLljFzwzAewFl+wfzb2pCdk/lFYXVgoeoLVVtJRPt8TPPCxCQU1u8XE1fTfm8trAYBT+5M4TGYaj4FlXLMH8J8tQVF0k0nvv0IruCIzANprg9TtmZdajwDvLcqXC/iTdksGh861Oj7aGHKsy4x18mvtsfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=en1vXU/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F8EC4CEE7;
	Sun, 20 Jul 2025 18:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753034825;
	bh=KdWwGjYoJDSltOHUgbcqHnR8whKcVBigwZqCJWFeLek=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=en1vXU/X9QrzIH4vOhbEHO9n90KHrSs2XK4BHWBtw+jad9BhvdNRIipSLve5FXZQm
	 7TiFIS+70OA5hspZLE40rpIH2DpjsSNHOGkfQOelZVSgXX3t1vCBJLco3UDi0SFTz0
	 XE1kK4koUoAlVbLgmsGr539ffuJvpk8Q8+a8qSlHvYK5+MAqtNMEDp2E9JVWp45CC4
	 R9ANZypLxD2N0J8OpA2kNMH+lMJrYRoexUad//5KInD4GY+l65r9dfID2UOeFueqkz
	 nNxjV2MgfgXxlw9j5HloWn4/HwRRjYGFONVKGQZiGUsePc6gXeX6qs1Gf/JK98cqeK
	 zdCwEfUkuACLQ==
Date: Sun, 20 Jul 2025 11:07:02 -0700
From: Kees Cook <kees@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
CC: =?ISO-8859-1?Q?Eugenio_P=E9rez?= <eperezma@redhat.com>,
 =?ISO-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Alexei Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrii Nakryiko <andrii@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Laight <David.Laight@ACULAB.COM>,
 David Lechner <dlechner@baylibre.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Gatlin Newhouse <gatlin.newhouse@gmail.com>, Hao Luo <haoluo@google.com>,
 Ingo Molnar <mingo@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jakub Sitnicki <jakub@cloudflare.com>, Jan Hendrik Farr <kernel@jfarr.cc>,
 Jason Wang <jasowang@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Marc Herbert <Marc.Herbert@linux.intel.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>,
 Michal Luczaj <mhal@rbox.co>, Miguel Ojeda <ojeda@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, NeilBrown <neil@brown.name>,
 Peter Zijlstra <peterz@infradead.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Thomas Gleixner <tglx@linutronix.de>,
 Thorsten Blum <thorsten.blum@linux.dev>, Uros Bizjak <ubizjak@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Yafang Shao <laoar.shao@gmail.com>,
 Ye Bin <yebin10@huawei.com>, Yonghong Song <yonghong.song@linux.dev>,
 Yufeng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-sparse@vger.kernel.org,
 virtualization@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH v2 0/7] Replace "__auto_type" with "auto"
User-Agent: K-9 Mail for Android
In-Reply-To: <20250720065045.2859105-1-hpa@zytor.com>
References: <20250720065045.2859105-1-hpa@zytor.com>
Message-ID: <F1CC49C7-0F23-4E0D-AE59-C0D35C19BCED@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On July 19, 2025 11:50:37 PM PDT, "H=2E Peter Anvin" <hpa@zytor=2Ecom> wro=
te:
>"auto" was defined as a keyword back in the K&R days, but as a storage
>type specifier=2E  No one ever used it, since it was and is the default
>storage type for local variables=2E
>
>C++11 recycled the keyword to allow a type to be declared based on the
>type of an initializer=2E  This was finally adopted into standard C in
>C23=2E
>
>gcc and clang provide the "__auto_type" alias keyword as an extension
>for pre-C23, however, there is no reason to pollute the bulk of the
>source base with this temporary keyword; instead define "auto" as a
>macro unless the compiler is running in C23+ mode=2E

Yeah, this is good=2E We have typeof() used extensively in macros all over=
=2E I'll try this for fortify macros and see if we see any binary output ch=
anges=2E=2E=2E

--=20
Kees Cook

