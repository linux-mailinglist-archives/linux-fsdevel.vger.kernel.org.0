Return-Path: <linux-fsdevel+bounces-26482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4F495A03C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 16:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B630D1F231BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 14:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838861B1D71;
	Wed, 21 Aug 2024 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="aG39Y+WP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ma3B3DrG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EAA19993B
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251462; cv=none; b=dZqXgXHYXeHpijFoK9Dl3W1Ni0WVRZKRN5n1cPhadPnn7nwNiNQP0MRTCjyJUXrZ3XeiDFr2dijDmwXFTuR/li1UecFMSau/kba1huZg0rLn+YJ9amrU0LRs7IwbcurHEmjgqmBmcWxrblGNsFp8zMaXDyUn4CdnTlNA50HeibE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251462; c=relaxed/simple;
	bh=YCFu21n5HaqSbYOFITxCLNKaDOalX/5NHGlceASAOyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vv5nh1AOpsCLYpu8HTgT3IxZX6n4ObrFLdlVj1OdSa/jszbIp+gw9bLY/jPdDC+uPb6e6YYnhDT2Jm0e6d57P2P0J5ASSkKpVltO6yQcz8xp0xAgklXB32Y8zy6WR5jo3tMpuL1VRyrSpdwqjvfOfgm63UplHSKelrVLQnAMZa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=aG39Y+WP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ma3B3DrG; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1370A1151237;
	Wed, 21 Aug 2024 10:44:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 21 Aug 2024 10:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1724251460;
	 x=1724337860; bh=VU72slKza1P7qxt50gKCKcAboknq5JZ6SLJtbSaynUM=; b=
	aG39Y+WPg4s5zG40oCJcpsVQDfuUj5dQ1cGpsCUfJLl5xFY1MTT3xepMjNxp8fo7
	ryGavSnducDIEEc/ZMGzN59agHFA80ebDjZcTkl5zKHlTG/SG3SxnMEwSDbALciO
	fqPnmCm+ZBK7NLqW4fVK2PspJ2LuyO3kvhbt9MyOCQiqm7x5WbcDYZu9xbuHddc2
	Lv4irj856Kzgo2vw6XdyYlBfVnvBX3MtJY3oaHP+WdC1ggyayvhosxop+4N/V+8I
	mPleYpajJtBh670Q8jt82Rr7YZxUYR4l4eQKoEE5Tl++hAjCxgsovj1LDqjdM2Gk
	4ecx6/jjHqW5yM1ANLBWNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724251460; x=
	1724337860; bh=VU72slKza1P7qxt50gKCKcAboknq5JZ6SLJtbSaynUM=; b=m
	a3B3DrG9+AE0QZqbgYIxICeqmsItX+BSIqkOqFaAucRp+10xjF4zkJ0Z5Iu1AtNq
	cUjZIJUtIyNaUl666+3j8QqTeAlzuwLosEijp2YnEp8hosCmi2MMGgsd52hbVbxq
	GPuBqL4iFNWQqy4UIS0wBp8To4LuLpGvz9N+0faJEdD0ZFKQYlFLniuq4njGW1rt
	LkCTll0TzNUW0y8AOII/bgpsDrOP3GTQTZX84Jmhl/k7AVQinWgOv+kMRc9LsSQJ
	vhFJdHFkrJ9CxnvlkvmvDhATuE09NdnK20EmKJ6WgjY3x9daxu5pGoIhI2VpNRuF
	kLu4ncG78lh1npJyLzaZQ==
X-ME-Sender: <xms:Q_3FZj9t7bXy-JGLmS7moq8sUygV4WS3-VewrCeKZI1QsfrxyPkHVA>
    <xme:Q_3FZvs5SGYKN_OCB0KtD9XskKdmJzfE8bnP-S5jbmmYDj0EZLFIqLVUcxbtIbGVQ
    a6vJgXzH56OxALI>
X-ME-Received: <xmr:Q_3FZhCKnIWGzcls4aSPwaDxkVFrbCVg7h2t27r1VUDYbLhGHxJMBdxG_YNP_CqjCYe1bx1Uo3-nLgEf5-NSqqCJCCjmj9pR40lex6QSGDN_Wbw7ITM5t4Wm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddukedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnheptddugefgjeefkedt
    gefhheegvddtfeejheehueeufffhfeelfeeuheetfedutdeinecuffhomhgrihhnpehgih
    hthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmhdpnhgspg
    hrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhikhhlohhs
    sehsiigvrhgvughirdhhuhdprhgtphhtthhopegsshgthhhusggvrhhtseguughnrdgtoh
    hmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehjohhsvghfsehtohigihgtphgrnhgurgdrtghomhdprhgtph
    htthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehj
    vghffhhlvgiguheslhhinhhugidrrghlihgsrggsrgdrtghomh
X-ME-Proxy: <xmx:Q_3FZveUVPPXAlcyPg-vlD3cL_wNDGjqLXzw0TWDgkuRkD2H7CsIdA>
    <xmx:Q_3FZoMb0VrxXEl_KCpPDET2CoPuSAealLYnAbOkxLzguZddg5BNmA>
    <xmx:Q_3FZhkFawHaPfKZ-FHz6L_eJTni8YUw09CPPXayBkN0dkvqCUXbmA>
    <xmx:Q_3FZiszz5QPQczcnfoNoyL-4IUzVEs5uq9ouXeIrtEC-KkCmOkF4A>
    <xmx:RP3FZkCgHNhZSiAqv_x_pWy-dizuZAI5sK1Q2Drx-e0sZvEnyJ2day2t>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Aug 2024 10:44:18 -0400 (EDT)
Message-ID: <38c1583f-aa19-4c8a-afb7-a0528d1035b0@fastmail.fm>
Date: Wed, 21 Aug 2024 16:44:16 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: Add open-gettr for fuse-file-open
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
 joannelkoong@gmail.com, jefflexu@linux.alibaba.com
References: <20240820211735.2098951-1-bschubert@ddn.com>
 <CAJfpegvdXpkaxL9sdDCE=MePdDDoLVGfLsJrTafk=9L1iSQ0vg@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegvdXpkaxL9sdDCE=MePdDDoLVGfLsJrTafk=9L1iSQ0vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/21/24 16:28, Miklos Szeredi wrote:
> On Tue, 20 Aug 2024 at 23:18, Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> This is to update attributes on open to achieve close-to-open
>> coherency even if an inode has a attribute cache timeout.
>>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>>
>> ---
>> libfuse patch:
>> https://github.com/libfuse/libfuse/pull/1020
>> (FUSE_OPENDIR_GETATTR still missing at time of writing)
>>
>> Note: This does not make use of existing atomic-open patches
>> as these are more complex than two new opcodes for open-getattr.
> 
> The format of the requests would be very similar to the atomic open ones, right?

Atomic open patches are using fuse_open_out + fuse_entry_out

open-getattr is using fuse_open_out + attr_outarg

We could switch open-getattr to the atomic-open format, but then need to
introduce a flag to tell fuse-server that this is a plain atomic and
much simpler than atomic-open (atomic-open is also on the server side
rather complex).
For open-getattr we need don't need to revalidate the entry with all the
fields provided by fuse_entry_out.

Fine with me if you prefer a new struct to be used by atomic-open and
open-getattr with a flag and padding. Like

enum atomic_open_flags
{
     ATOMIC_OPEN_IS_OPEN_GETATTR = 1ULL < 0;
};

struct atomic_open
{
        uint64_t atomic_open_flags;
        struct fuse_open_out open_out;
        uint8_t future_padding1[16];
        struct fuse_entry_out entry_out;
        uint8_t future_padding2[16];
}


What do you think?


Thanks,
Bernd


