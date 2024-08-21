Return-Path: <linux-fsdevel+bounces-26492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B66AA95A228
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 17:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F390B24D63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 15:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409DC15099B;
	Wed, 21 Aug 2024 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="tfs0unzf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tP0eQVTj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280E414D2B4
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255752; cv=none; b=hz6kNmoqhndQ3MmSAYsGDNK6qMrqNOWVFNFMCuHS63ZgYV0y9G35o0FZEybApkZIQs7+jdOcx0vEuCLJ6XXFDl+x2wSrBZuWwMyy3xdSpswPkfg/S8w+F4sm9p3nYMl1poH43IfvHi4u2Gjz+4neKr5snpyt3BgF1+cf6E+bB+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255752; c=relaxed/simple;
	bh=jz+V+GQbe99FopCasDG8d06VbfT4h+AFswEpsvuGcWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=puImqyQxvGpO0RKCR0pYC4B/1AglWKxAg932eORTZkXv6jPNBte1L0HaOB4a/Nyot8CSiop75kYDHJ+sG3Tj8dWZnTUiu1ABCsPso+75jwizTmh6BEHRmaFms4005z6PPT7dP1PnX+VA2A7DoTYOOziJU6Xz99p2hdqWg56YrZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=tfs0unzf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tP0eQVTj; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 43565138FD34;
	Wed, 21 Aug 2024 11:55:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 21 Aug 2024 11:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1724255749;
	 x=1724342149; bh=DpzGirI/Djh4BqAhJXAtiStU1eQ6+nxqb2PkAe26DO4=; b=
	tfs0unzfy0YwFpcOvknLBEd2+nQwFQWvtm/anIgbf42UFBbZHwxw7ylr1SAkSqbr
	yXcx2tvhlO6h7jaIYguJvnXkuAtQ6lF2rW1TrL4PPx7on2ajE+uWr/p1NW9QbfUt
	bQa0wIi8L/Do+591g2zg/pUaHCWCwgxx4lgXmyjxT4sb1yYS3zbGqPJkRWqSp8zG
	8uPOyBwEdcS1d9h9LwGWpgxYfeVpQ75gam7IiCFmVh05hChQ7izXhWnxYsp/EVs9
	TK34mQ9XZoyPNzpCRyIG6pXUGYulzKU8MAqIJ2JTQtp1OYcrHGXsAnZ3EPrPjpWj
	mi/jghg3Z19OrdYKcsd4OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724255749; x=
	1724342149; bh=DpzGirI/Djh4BqAhJXAtiStU1eQ6+nxqb2PkAe26DO4=; b=t
	P0eQVTjEBNwYuXQEYP6kMBjuhdJPy57MvVT3q8MftsRzKqS2snn5NocfWAlHoPHK
	qzG40eMWxJ6viHz3Xz/2XCE22Xvle+WyShfBlyhZ+TWrGaLxhAwWeJmZA5hCUGWQ
	2Zyh501BDx9m6/6ubz++5K6MjwCUDHBde4Mh91a0ZskRP/nDlmHIalab3VVFITFb
	lhZBgRJMfxREBX8CWiGB+onpqZ4wD48sjqJCEw6cZVVEk9dkeVdYfThLF40zrK1S
	sWbPdkM6ax78BNQ0Dn1bHitzAB7A7VGeA1DQPQKpjUT2ALmV+4RfzZDKAnelbkh/
	HMW1M6zK7ZHCuF1XUYwGw==
X-ME-Sender: <xms:BA7GZuN4iAKlez1eYelw7wxEblNdRb-EO75DvRVXDf4hFO2jD9rHIQ>
    <xme:BA7GZs-G8UPp9CCyNe0LR_LXdClc6A008ZSdUtfg4W9ybbW5dQwHS_bNlNnjMNaI4
    JJOnVEUJSVlMPOH>
X-ME-Received: <xmr:BA7GZlS4KK3mfIoqmEqrE5w9G5R1HNrCQs6YAysia2LmS4_sD692GlMa6lcTXn8P03figcqb9cSDs-eg_L4T-B7a-6wUGP1wDSOGvldL3tufLr57NY81z7ql>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddukedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfg
    tdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohep
    sghstghhuhgsvghrthesuggunhdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvg
    hvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhoshgvfhesthho
    gihitghprghnuggrrdgtohhmpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepjhgvfhhflhgvgihusehlihhnuhigrdgrlhhisggr
    sggrrdgtohhm
X-ME-Proxy: <xmx:BA7GZutfRVqPoGArCc4CBO_9BqJ64Rd4YlKmvGUMx8sd7H1fzgvoNA>
    <xmx:BA7GZme9njaIYy861MOGf2TDATGXvlAXllC6lWNi1Yog30TPAXv-aQ>
    <xmx:BA7GZi3Lm02a_EZdzLvbJ4Qr-BVnp-FyH8b2UmHMLUbtGLPBVnha8g>
    <xmx:BA7GZq-B-clRJCa20T8HDCc2uMOAVGTHEhNXzfCIFGaS9ADCi709TQ>
    <xmx:BQ7GZuTc4UdRNpSVm9DPs80wxiGonhgC79lkIAx-cy9YTOtjO0Eixw6d>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Aug 2024 11:55:46 -0400 (EDT)
Message-ID: <3fc17edf-9fb1-4dc2-afd2-131e36705fae@fastmail.fm>
Date: Wed, 21 Aug 2024 17:55:45 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: Add open-gettr for fuse-file-open
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
 josef@toxicpanda.com, joannelkoong@gmail.com, jefflexu@linux.alibaba.com
References: <20240820211735.2098951-1-bschubert@ddn.com>
 <CAJfpegvdXpkaxL9sdDCE=MePdDDoLVGfLsJrTafk=9L1iSQ0vg@mail.gmail.com>
 <38c1583f-aa19-4c8a-afb7-a0528d1035b0@fastmail.fm>
 <CAJfpegsFdWun1xZ-uHXnWBeRz3Bmyf0FSYWiX1pGYU8LEz12WA@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegsFdWun1xZ-uHXnWBeRz3Bmyf0FSYWiX1pGYU8LEz12WA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/21/24 17:03, Miklos Szeredi wrote:
> On Wed, 21 Aug 2024 at 16:44, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
> 
>> struct atomic_open
>> {
>>         uint64_t atomic_open_flags;
>>         struct fuse_open_out open_out;
>>         uint8_t future_padding1[16];
>>         struct fuse_entry_out entry_out;
>>         uint8_t future_padding2[16];
>> }
>>
>>
>> What do you think?
> 
> I'm wondering if something like the "compound procedure" in NFSv4
> would work for fuse as well?

I need to figure out how that actually works in NFS.

Do you have a suggestion how to bundle open + getattr in one request
with compounds? My thinking is that we need something like

#define MAX_OPS 8 // abitrary value
#define MAX_OP_OUT_SZ

struct  op {
	uint32_t opcode;
        uint32_t arg_sz;
	void *arg;
};

struct fuse_compound
{
     uint32_t n_ops;
     struct  op ops[MAX_OPS];
}


But how would fuse_file_open() know how to send a sequence of requests?
I don't see an issue to decode that on the server side into multiple
requests, but how do we process the result in fuse-client? For fg
requests we have exactly request that gets processed by the vfs
operaration sending a request - how would that look like with compounds?

Or do I totally misunderstand you and you want to use compounds to avoid
the uber struct for atomic-open? At least we still need to add in the
ATOMIC_OPEN_IS_OPEN_GETATTR flag there and actually another like
ATOMIC_OPEN_IS_DIRECTORY.


Thanks,
Bernd

