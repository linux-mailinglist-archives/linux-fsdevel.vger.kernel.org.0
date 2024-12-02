Return-Path: <linux-fsdevel+bounces-36283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAE69E0DAF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 22:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FC0EB2F04A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 20:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EEF1DF250;
	Mon,  2 Dec 2024 20:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="P9VOKuYf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mo8cPG1Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70111DEFF9;
	Mon,  2 Dec 2024 20:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172796; cv=none; b=j4HZ0ulJVR+8+3Zx4x8u8zeiyR9jIOA/US/AhP9OZCKfxP1huTf185rlPUuRVf7b6BzQ4n65oDmDvNkXWCgtZDj6iNG1o8/28MGsa28gM/YDD0T9L2902WRTjDJIMQmFrSLSZ9vs9TeaU9ZRsttmRnpCo139D+DLl5do7zjcOGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172796; c=relaxed/simple;
	bh=0N9VBhddveSL3a2gaQZps88kMklVuSxD7m3oq+4MVt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rbFhQDQEKZIpMjspTyQ1mM+8J3tOvX+H3Hcl+OXUee0Z4BydlgRqG6mZLv0D5b2zuSMVrSNY9ZqtyXA0+ojpetxvpFuL+8vQzJ/ktqOZKoAAnI7MyyYmPxPbpUCc+eExKfesqduQyp5B2vysJEnLAbpBKaWdHguDC+8nA+YvYpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=P9VOKuYf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mo8cPG1Y; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id F20891380499;
	Mon,  2 Dec 2024 15:53:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 02 Dec 2024 15:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733172792;
	 x=1733259192; bh=7VAlCDOK003uVLBxoIfDpdqLjFbQJQ6ytHMYDJC/IHs=; b=
	P9VOKuYfI0KPEOUEB0mdEf38ICzkYNr1zMC53xCiyK/LRdgKnlk3kKXQdJ4x6XqV
	LJCbPNQG4xvJ1PJmYL9W328UJ3Ik2m84YR9sG6ET94a9nJTWq13mYAx0yy0h80TZ
	Imr1jZgi29ch2znGqGQXvLFT4+F8Aesnvr26c0oxUw0R5LmMBK3P6/lF6mDfu0K6
	U5UvDkmDW+A3ij1LMD98RF0jKBKVCIArJrvBLs/S2oOGbIacWXkpyXedwQcX7FkC
	sGZa+onV2mEbWNpEi5tw1llSQXkel3XLGypAg7lTI8Kc+Mdp2sg+c2GWDup/KNWU
	IGLCE0xLNpEKI2UjQbi8gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733172792; x=
	1733259192; bh=7VAlCDOK003uVLBxoIfDpdqLjFbQJQ6ytHMYDJC/IHs=; b=M
	o8cPG1YrF6u7vG/bS94E/ao71DRmUYLSnDcqJvH/qBp1TGS8dlNzrDsI2YdORmuP
	QjUCx4KPhn9SFOksTf5f4/DbxSoRdJ6Jevq+JB36g1TuBHiBixihiPENz7ewqsvt
	xThCg/t/0AKoiZj8IUL+pF/2trvSQSGYW8bx6pEzZmjaCRcn48NR40MnTmkwjsD0
	4ldmnRGPjaxky0HJ6U5jIdYvpo5SGE9rY8O4lEWbFJKaQ1PWBpE0uEwz0KNsSakj
	AqR1or0tdc6MtSSqdWNiBGBLrfnFZD+bfApOJBtWS+jU0meIFaiPVp7zxsLp1ZYf
	RISj0OHG1RxOxhOIOhO9A==
X-ME-Sender: <xms:OB5OZ0JaR6N8OrSv0qYVzinqnbMfIOiwwdGIH9s_CjidUh1wpQbPaQ>
    <xme:OB5OZ0LWRlkEWxCGZlzEgvgwUeD7153_SRqmf8e5fPGYtRynAyGS8XTb-_YTowsBe
    xt07c9MgNNPkXWy>
X-ME-Received: <xmr:OB5OZ0ve4F8tg_2DJOkhcQMgMGNAhHscjqZAaCGBxNIOoPK5MRgSZpvQ7YnZLp3v-WQVu1bVNynKHKqWSrlAC2himp3nTD7rB2JrJzr3rsgQFP3PlNP->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheelgddugeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepudelfedvudevudev
    leegleffffekudekgeevlefgkeeluedvheekheehheekhfefnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgt
    phhtthhopehnihhhrghrtghhrghithhhrghnhigrsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhf
    shguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhkhhgr
    nheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehshiiisghoth
    dokeejsgekvgeivgguvdehuggstgegudejheelfhejsehshiiikhgrlhhlvghrrdgrphhp
    shhpohhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:OB5OZxZ0fRbamb5qG4FN0HxlZJzvyg2104wluEcqm0CsAZ6DVrPN5Q>
    <xmx:OB5OZ7b1QZ6BE1v5-F8s1La7pTR6vyy-f194SX1sZdcD9_kamjzw7w>
    <xmx:OB5OZ9C-hX0UpT8j0-VuRxB9t5o_8msyDmxu-icZHiZg4EfU8aSh0Q>
    <xmx:OB5OZxawvlUaCTbTdUsbNFIaSFjx9mh3RDQoTE6nZpNXM0v9qrPLvQ>
    <xmx:OB5OZ_50-gDj4gji2f5tQ85HNAFFZFFXTBqsx_WJ2kM-AKovUFoDGVZg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 15:53:11 -0500 (EST)
Message-ID: <ee94604f-a912-4d5c-a2b8-e45cb7bf9e37@fastmail.fm>
Date: Mon, 2 Dec 2024 21:53:09 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: add a null-ptr check
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Nihar Chaithanya <niharchaithanya@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org,
 syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com
References: <20241130065118.539620-1-niharchaithanya@gmail.com>
 <8806fcd7-8db3-4f9e-ae58-d9a2c7c55702@fastmail.fm>
 <CAJnrk1b1zM=Zyn+LiV2bLbShQoCj4z5b++W2H4h7zR0QbTdZjg@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1b1zM=Zyn+LiV2bLbShQoCj4z5b++W2H4h7zR0QbTdZjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Joanne,

On 12/2/24 21:40, Joanne Koong wrote:
> On Sat, Nov 30, 2024 at 12:22 AM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>> On 11/30/24 07:51, Nihar Chaithanya wrote:
> 
> Hi Nihar and Bernd,
> 
>>> The bug KASAN: null-ptr-deref is triggered due to *val being
>>> dereferenced when it is null in fuse_copy_do() when performing
>>> memcpy().
> 
> It's not clear to me that syzbot's "null-ptr-deref" complaint is about
> *val being dereferenced when val is NULL.
> 
> The stack trace [1] points to the 2nd memcpy in fuse_copy_do():
> 
> /* Do as much copy to/from userspace buffer as we can */
> static int fuse_copy_do(struct fuse_copy_state *cs, void **val, unsigned *size)
> {
>         unsigned ncpy = min(*size, cs->len);
>         if (val) {
>                 void *pgaddr = kmap_local_page(cs->pg);
>                 void *buf = pgaddr + cs->offset;
> 
>                 if (cs->write)
>                         memcpy(buf, *val, ncpy);
>                 else
>                         memcpy(*val, buf, ncpy);
> 
>                 kunmap_local(pgaddr);
>                 *val += ncpy;
>         }
> ...
> }
> 
> but AFAICT, if val is NULL then we never try to deref val since it's
> guarded by the "if (val)" check.

The function takes &val in fuse_copy_one(). The NULL check is more for
passing NULL from fuse_copy_page().


> 
> It seems like syzbot is either complaining about buf being NULL / *val
> being NULL and then trying to deference those inside the memcpy call,
> or maybe it actually is (mistakenly) complaining about val being NULL.

I don't think it is 'buf', because of 

==> Write of size 5 at addr 0000000000000000 

If it would be buf, it would be a read. With the knowledge that the line
number is correct, as it goes through fuse_dev_write(). Although I have
to admit that cs->write is really confusing - just the other way
around of fuse_dev_do_write  / fuse_dev_do_read.



> 
> It's not clear to me either how the "fuse: convert direct io to use
> folios" patch (on the fuse tree, it's commit 3b97c36) [2] directly
> causes this.
> 
> If I'm remembering correctly, it's possible to add debug printks to a
> patch and syzbot will print out the debug messages as it triggers the
> issue? It'd be interesting to see which request opcode triggers this,
> and what exactly is being deref-ed here that is NULL. I need to look
> at this more deeply but so far, nothing stands out as to what could be
> the culprit.

Yeah, I was just thinking the same and just reading through syzbot doku. 
I had tried to reproduce in my lokal VM on master/6.13 - no luck.


Thanks,
Bernd

