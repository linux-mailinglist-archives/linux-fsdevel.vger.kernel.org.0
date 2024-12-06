Return-Path: <linux-fsdevel+bounces-36630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B789E6E6D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 13:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF0182848C4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 12:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06BC202F91;
	Fri,  6 Dec 2024 12:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="L5bZM7kv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3/mEvQSe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EF1202F7D
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 12:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488872; cv=none; b=RZdAPW76Z95ng7t0VEzkFcuiJhG5IMLmuHT4MaXYT6GP9lBWx2LuR+BXG5nj3QFvYBJ46UrcbaxcdKVe5pHTcxDt1y9218YVwIZ7f6zKv9xFHET3S+S/47r64ZRr8KOjXahe8qWs/AziNZCWgcpMW8DqhM3wNYYW2CYoWKBgnZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488872; c=relaxed/simple;
	bh=t4Fgw8nKOBruWIjpvLkYp2AIC5dy6abm6RTvVXuHm6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lo2T1Dut9M3xGyLPFLyJyzSRUubKt5Lq4+BOZnvblNgyhDwhAU7xfhiI697deT0BVuV5A4sCrtsx4M0NgAFBT8IEkGBhV2Z/7o6w3h67TbE6B7RTT8fyZWcMvsDiNKW+r3BgYpMzNbZQ4PSvZfU7FCM5tNVlRlBXFPTbn69sJz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=L5bZM7kv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3/mEvQSe; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 70653114013D;
	Fri,  6 Dec 2024 07:41:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 06 Dec 2024 07:41:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733488868;
	 x=1733575268; bh=tXXivK+cdUGnoPSCQQoOlq548346QQ9af7kT7yc5szI=; b=
	L5bZM7kvXOnkUPpoKhBpNaNRp3WS7T/GRlbcQKzH/H789dMkBUkRTfVwA2lK/XYT
	bWYiVf0TjlUz78y5itP+z9p1QVE8rYv6gv3WF9U6d0GV38qUqymjivKv53XFcxUp
	IUjr6wLUewcpVhGeTjIFi8VeVM+sHlGPR2LdtbY51KjJg0zyTUq4wPn7R2npAZku
	pZRdgkU0+lA+bIfmw0IWg4WDGMIPSKu1pdw0qbAy8quDY+YPhle/ohJcgOpWoA0V
	WRZJSflL4490WCNYXN7umaRfyr8lpAyaUpW0K191TK+T5sJ5InMjp8/RyUqu+Kbd
	WWTIdsZXRTRrebxvSfAC8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733488868; x=
	1733575268; bh=tXXivK+cdUGnoPSCQQoOlq548346QQ9af7kT7yc5szI=; b=3
	/mEvQSeBzy8f/flfuSUzIXqyAhCW97YYhtDDPzQqFKbskF3ADgUT2H3Y9vlElAb9
	sx+jrlGBT0hzqMBDkCWM/jC2v9VTDAqDBp7pA3jyWtT662bKpq/Q2Dr1d6hWvFX6
	vtK0BPK/mBvG9VBdbg3HteAMnXLfJA6aLOLwXDqlvU2631Weg6w7nbDfTuHi5j5O
	CSM56nouFFhePkqsxz+ZyGssCGfmUxkLHbgQo7ctVrwzS6jTTnaYlb5msJ1VAiBK
	zNjwSFFfqBX4fOJ2YZJwCrndMsjvKji6r+8CpzDFd+9FHTsSAFIbi4IIhbmh+zYb
	ue2zvudIywKcnhdJ92vew==
X-ME-Sender: <xms:4_BSZ63g2dAj3RY08FmIBHPATks5l640VjJ4gt6Q6L-4FFVQ2LLf8A>
    <xme:4_BSZ9EzEhqM2Nz5SuWL8Ex7_jX3r7XCRPYh7iAlaW6m1nqJqxmFsMMqub_qlo6Uj
    3mVA6CSJGKzu-Yx>
X-ME-Received: <xmr:4_BSZy4uWm4RQrAwG5kPHjbF7hfuM6OElzSyoA8YDJYLbkSWmtHfRXEKhw3SpAxqYnvJH-SDqzpimXvrBfaO8U-bgytpN7v42H4oPbqVPTWvWPUS_912>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeen
    ucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrh
    htsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeffjeevfeefjefghfef
    hfeiueffffetledtgffhhfdttdefueevledvleetfeevtdenucffohhmrghinhepkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmpdhnsggprh
    gtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihhklhhoshes
    shiivghrvgguihdrhhhupdhrtghpthhtohepughhohifvghllhhssehrvgguhhgrthdrtg
    homhdprhgtphhtthhopegumhgrnhhtihhpohhvseihrghnuggvgidrrhhupdhrtghpthht
    ohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthhfsheslhhishhtshdrlhhinhhu
    gidruggvvhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhvtgdqphhrohhjvggttheslhhinhhugihtvghs
    thhinhhgrdhorhhgpdhrtghpthhtohepshihiigsohhtodegtdegsgegsgejgeehtdektd
    gsiedvuddttgeitgesshihiihkrghllhgvrhdrrghpphhsphhothhmrghilhdrtghomh
X-ME-Proxy: <xmx:4_BSZ71pLr0Yuf-zt9h9hahzb5gFIqfY4UJDjSdt6jY7gdPYgOA64A>
    <xmx:4_BSZ9GXQtxqRyUnkAaDo7qWW88Xpf3dsq-DfYbbBKYF55PlP22HtQ>
    <xmx:4_BSZ08GU1ARAQaGKtoHjQx_FQ1V5mw_8y-GtUO_5dZ5VCGp-Xb7qw>
    <xmx:4_BSZyk7dpDgJjtAHGAT3xS3doqyCJ0UdXsaDxIF9wpGcVCWZHf5Dw>
    <xmx:5PBSZ8BzVUyqqXzsIamKPMatdFlw3Mjc2Er2gWzQUXF7h8NiSbqzYok0>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 07:41:06 -0500 (EST)
Message-ID: <4b9f34f5-7cfc-40e2-b2a7-ad69d1d81437@fastmail.fm>
Date: Fri, 6 Dec 2024 13:41:05 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: syzbot program that crashes netfslib can also crash fuse
To: Miklos Szeredi <miklos@szeredi.hu>, David Howells <dhowells@redhat.com>
Cc: Dmitry Antipov <dmantipov@yandex.ru>, Jeff Layton <jlayton@kernel.org>,
 Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, lvc-project@linuxtesting.org,
 syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com
References: <20241202093943.227786-1-dmantipov@yandex.ru>
 <1100513.1733306199@warthog.procyon.org.uk>
 <CAJfpeguAw2_3waLEGhPK-LZ_dFfOXO6bHGE=6Yo2xpyet6SYrA@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpeguAw2_3waLEGhPK-LZ_dFfOXO6bHGE=6Yo2xpyet6SYrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/4/24 13:41, Miklos Szeredi wrote:
> On Wed, 4 Dec 2024 at 10:56, David Howells <dhowells@redhat.com> wrote:
>>
>> Interesting...  The test program also causes fuse to oops (see attached) over
>> without even getting to netfslib.  The BUG is in iov_iter_revert():
>>
>>         if (iov_iter_is_xarray(i) || iter_is_ubuf(i)) {
>>                 BUG(); /* We should never go beyond the start of the specified
>>                         * range since we might then be straying into pages that
>>                         * aren't pinned.
>>                         */
> 
> Can you please test this?
> 
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1541,8 +1541,10 @@ static int fuse_get_user_pages(struct
> fuse_args_pages *ap, struct iov_iter *ii,
>          */
>         struct page **pages = kzalloc(max_pages * sizeof(struct page *),
>                                       GFP_KERNEL);
> -       if (!pages)
> +       if (!pages) {
> +               *nbytesp = 0;
>                 return -ENOMEM;
> +       }
> 
>         while (nbytes < *nbytesp && nr_pages < max_pages) {
>                 unsigned nfolios, i;
> 
> (Also attaching patch without whitespace damage.)

I had already posted a patch on Monday.

https://lore.kernel.org/r/20241203-fix-fuse_get_user_pages-v2-1-acce8a29d06b@ddn.com

@David, is that the same sysbot report or another one?


Thanks,
Bernd

