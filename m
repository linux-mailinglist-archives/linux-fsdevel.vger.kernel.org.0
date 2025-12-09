Return-Path: <linux-fsdevel+bounces-71001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB63CAECF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 04:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4287F300EDE9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 03:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296FA3016E9;
	Tue,  9 Dec 2025 03:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="B4Ha1Y4U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709A63FFD;
	Tue,  9 Dec 2025 03:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765251055; cv=none; b=pxOl+3zob5/9LUhdtlqpxCS+7XjufGQV+Ms8zKXrbM20CmrqcntgG7/GLVmdKvrQQtQjz5RA2t/qyA228zLstIVYucTpXUVtYXucJVD7eU4NprsN0QPVJbIcGrcYIN3MHYN32gLdTpcpzOSDWcGOsxIViNUtmPDKRFl+GDRJx5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765251055; c=relaxed/simple;
	bh=HA+t395Jy2lAj97Muzu8p4EQrayoFxG0axYG2SfJ26w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=m4Y90haki/A3F9HaiTNp3Oriw3p8ByHrLHdRNYU5Ke2mrCPVCQPM9eJLZq1u+mSwGmPn6x+I+RCFXjy675/GlImdJI5z3yaqwrrJrO9cua36mVyVPBfmvI9k5Tm2JliXuwllUaoYokHtFZTU5c2ZL5LyAtr7mIWxSl0MPTpHFFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=B4Ha1Y4U; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5B93Srkj2763694
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 8 Dec 2025 19:28:54 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5B93Srkj2763694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025112201; t=1765250937;
	bh=J9HxWPOMpo5+S2/pf0ntFy5/L60u+ncFK4+hU4+I0vE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=B4Ha1Y4UjXu4GBLhS76OysnFZKafukh8uysNmSf+JK1e+oknL/huLXiRMJys3lDv2
	 eU3TZJ/DEwBfMSAkdfEdXOhXPgY3cPjAw5e9KG5/ir2G3bEJpQd4gXXrCcaCwlhkMV
	 t82vtjWpq5yOfMVnG9H2c1k0hTFq5ZuMwHbBFjdf4ToCsiWnJLFLt4uvLHIy3eFgHa
	 K+dcbcgNjBtoBlvWL2pdZ1CvazpVMmRyrX3f1NpVDYxUnsEsz7zShRCWnzg3YQcgyT
	 UFTtF8N2gd/AZqn/XHGMABNkZgyBmDFEUilN4QBw/ue2XJ8nCx1g7Jzgt49AuRlHwj
	 V4m+ENHXVYlsw==
Date: Mon, 08 Dec 2025 19:28:53 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
        =?ISO-8859-1?Q?Eugenio_P=E9rez?= <eperezma@redhat.com>,
        =?ISO-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrii Nakryiko <andrii@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
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
        Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
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
        Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>,
        Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
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
User-Agent: K-9 Mail for Android
In-Reply-To: <20251209032206.GU1712166@ZenIV>
References: <20251208235528.3670800-1-hpa@zytor.com> <20251209002519.GT1712166@ZenIV> <43CDF85F-800F-449C-8CA6-F35BEC88E18E@zytor.com> <20251209032206.GU1712166@ZenIV>
Message-ID: <87F4003B-5011-49EF-A807-CEA094EA0DAC@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On December 8, 2025 7:22:06 PM PST, Al Viro <viro@zeniv=2Elinux=2Eorg=2Euk>=
 wrote:
>On Mon, Dec 08, 2025 at 04:28:11PM -0800, H=2E Peter Anvin wrote:
>> On December 8, 2025 4:25:19 PM PST, Al Viro <viro@zeniv=2Elinux=2Eorg=
=2Euk> wrote:
>> >On Mon, Dec 08, 2025 at 03:55:26PM -0800, H=2E Peter Anvin wrote:
>> >> Hi Linus,
>> >>=20
>> >> The following changes since commit c2f2b01b74be8b40a2173372bcd770723=
f87e7b2:
>> >>=20
>> >>   Merge tag 'i3c/for-6=2E19' of git://git=2Ekernel=2Eorg/pub/scm/lin=
ux/kernel/git/i3c/linux (2025-12-08 11:25:14 +0900)
>> >>=20
>> >> are available in the Git repository at:
>> >>=20
>> >>   git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/hpa/linux-auto=
=2Egit
>> >>=20
>> >> for you to fetch changes up to branch auto-type-for-6=2E19
>> >> (4ecc26fa585216f98d71411ce182f9e823d94c8c):
>> >>=20
>> >>   tools/virtio: replace "__auto_type" with "auto" (2025-12-08 15:32:=
15 -0800)
>> >
>> >Argh=2E=2E=2E  teaching declaration parser in sparse to handle that is
>> >going to be fun, especially since there are corner cases where
>> >gcc and clang do not agree, even with --std=3Dc23 --pedantic=2E=2E=2E
>>=20
>> Well, until sparse actually handles C23, this is just a macro=2E  __aut=
o_type is already in use=2E
>
>Just anticipating the joy of getting declaration parser to deal with that
>properly - there's bunch of fun corner cases where this macro wouldn't
>cut it=2E  Sure, the underlying semantics can be mapped onto __auto_type,
>but the actual syntax is bloody awful, especially when you mix the
>typedefs into it=2E
>
>Speaking of other fun sparse stuff: __VA_OPT__ support needs to be added;
>I think I have it plotted down to reasonable details, will post in a day
>or two=2E=2E=2E

Yeah=2E=2E=2E the C committee even admitted they botched the spec; the int=
ent was for it to work "exactly like gcc __auto_type"=2E=2E=2E

