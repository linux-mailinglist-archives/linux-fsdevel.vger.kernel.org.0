Return-Path: <linux-fsdevel+bounces-28290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B77F968EFB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 22:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 733E5B21F7C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 20:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4311819CC04;
	Mon,  2 Sep 2024 20:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="mVIFU2q5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IFCTB721"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132B71A4E6C
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Sep 2024 20:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725310766; cv=none; b=hufVS4ETBnMK6ax/YRfgxwPT6M/zzhLul48qm62BPvVgsqfotvVPC/bPu7LUglr37zFJjhHIHkxPsdCKSFe8Mdc/99DXqqXr/AG86DvNguKkFBP4HCmNKGZfQyIrB5cEpGZKVxEd07BqgKBddZY+65po+xa0XUIeuhMaTFvoBnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725310766; c=relaxed/simple;
	bh=OvS0zpknVCqpP7ppEOoNgu7bAYG2lh/b1ZaQ6zch0Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smqSdpgAAN8gs6p423fT6ai9YXawJypMTFwjdIT0StMzXt7lJrp62jV0wN9zMJGK90hdhmODKaC/n6F9s4yf364Lhdz1zgwJWRb8TG3//o60NPeZ8ca5jQb3b9ttlGZscnvGAVP6HAcPKSfVLt5JcGiWFUSyrqsnkbrLy9KwC0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=mVIFU2q5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IFCTB721; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2F5DB1380283;
	Mon,  2 Sep 2024 16:59:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 02 Sep 2024 16:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725310763;
	 x=1725397163; bh=4fwCqiuMA/EooJe/suSWzJKFTWw3JfamxPeHdCLn8dQ=; b=
	mVIFU2q55lrMbZyai5p534NBV1czAreDqZyYCF3BzqtrNJM1bn5FvXkexuNd8f0o
	jb8vY5VLkXV0O/ZHDoWWTU/Pd/rcxPHZMA1YsXI7gyGPQuj9cG2rKsPXnSMm1P6b
	OQabOpI+cAd5+dJWbdCaQbsDwpQk3b5m+O4nNWRxmsrzAmL8iUn1ADiAlNFBf1XN
	AucDK6Ua2R2vwMTN+MOa5dKr64XXtApzfiWMYkHqbxa78shKJrK9jKITdU7TSdGT
	g3IRZDy7AK1K4Xp7VjKBVzvculw8/7EiI9KFCGg4D19u0wuhCmiiptldFwQ9ZxJ2
	2dTVy/F5IFn5tGS8gkuHWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725310763; x=
	1725397163; bh=4fwCqiuMA/EooJe/suSWzJKFTWw3JfamxPeHdCLn8dQ=; b=I
	FCTB721ApM+xisQ3iCuDlqbpgODoVPB4dOKsApWFkA8MY4kIIviMIpMkGlsIyh/A
	iXC2x6HzAIliPUTryt2EyIDwqXaCJHm35UgtmyMOxJhzCNjpmiTibo1ybIgwg/ow
	vpNdoVNSHvKUXuW/tQG9TffFF3k0h8Kw/nXfeIG6341x5TA29pSmeEKS9jB7tDhy
	668cpWxBzHAJgVhH39MxFs0bTpz5idfNZMK7G93yzOD+M2ZMAbPfMUghP3L9LQ0k
	/aC4rzfiUttuIE1Q1DZdmCCQZ3H4IaQO3YaVNWy+3jGlgO3Z82s14DCZ/4xWqVca
	sInZ/25RynfOtKMDdmARg==
X-ME-Sender: <xms:KifWZh-Z_69AMCY9GxALf3u5nGJ7uFPZIC2msU55ZpngM_jdTQ5_xA>
    <xme:KifWZlso8OWzBCHcHoaW4Y_WkjiS6DrmIfWSeSv233R76RMFxYQSSpHupxCzaIuAd
    XMyz3hg8aLxVbOl>
X-ME-Received: <xmr:KifWZvBIx8Boqz9O9zAAWqhkPad0HZlDnetXcttsh1kqVLMjwzW9tTg_UNOhdAZEsb611dUTVTiyqDyQaDIQmlmAj8kX7Jwpobx9RLOjeaQi0dFxE6QC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehfedgudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddu
    gfdtgfegleefvdehfeeiveejieefveeiteeggffggfeulefgjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthho
    pegsshgthhhusggvrhhtseguughnrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsug
    gvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhsvghfseht
    ohigihgtphgrnhgurgdrtghomhdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:KifWZlcahcJMocWuka6BA3rxnZQCGpUltaYp_xi4YcjTd414xdUahA>
    <xmx:KifWZmMlzl5qRLj-syXpYKc-4sSM2137ZGqxquC0y_c-CilhWOzukQ>
    <xmx:KifWZnl5h2We6IEy8_d2YqjRsXqvuDe8_BQ78yGi1rj_l73sXpoLWg>
    <xmx:KifWZgsA-02X-E4IP8rKSB-PGN2oyCfo4dZuyMeAHdLaYjyobQDeLw>
    <xmx:KyfWZt0rgCWYki4tH0vOHzOWcTMczL5-MsZsaCjKVp-eTuH-LTx9TLWC>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Sep 2024 16:59:22 -0400 (EDT)
Message-ID: <d50e64d1-8af2-4150-8291-dfc5ff720120@fastmail.fm>
Date: Mon, 2 Sep 2024 22:59:21 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fuse: Allow page aligned writes
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "joannelkoong@gmail.com" <joannelkoong@gmail.com>
References: <20240812161839.1961311-1-bschubert@ddn.com>
 <a71d9bc4-fa6f-4cfd-bd96-e1001c3061fe@fastmail.fm>
 <CAJfpegt1yY+mHWan6h_B20-i-pbmNSLEu7Fg_MsMo-cB_hFe_w@mail.gmail.com>
 <b3b64839-edab-4253-9300-7a12151815a5@ddn.com>
 <CAJfpegvOvv=LvjSoHJGSBr4_abh4DrP0=2=o6uovnvsUbzPJ8Q@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegvOvv=LvjSoHJGSBr4_abh4DrP0=2=o6uovnvsUbzPJ8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/29/24 15:39, Miklos Szeredi wrote:
> On Thu, 29 Aug 2024 at 15:05, Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> On 8/29/24 14:46, Miklos Szeredi wrote:
>>> On Mon, 12 Aug 2024 at 18:37, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>>>
>>>> Sorry, I had sent out the wrong/old patch file - it doesn't have one change
>>>> (handling of already aligned buffers).
>>>> Shall I sent v4? The correct version is below
>>>>
>>>> ---
>>>>
>>>> From: Bernd Schubert <bschubert@ddn.com>
>>>> Date: Fri, 21 Jun 2024 11:51:23 +0200
>>>> Subject: [PATCH v3] fuse: Allow page aligned writes
>>>>
>>>> Write IOs should be page aligned as fuse server
>>>> might need to copy data to another buffer otherwise in
>>>> order to fulfill network or device storage requirements.
>>>
>>> Okay.
>>>
>>> So why not align the buffer in userspace so the payload of the write
>>> request lands on a page boundary?
>>>
>>> Just the case that you have noted in the fuse_copy_align() function.
>>
>> How would you do that with splice?
> 
> I would have thought that splice already honored page boundaries, but
> maybe commit 0c4bcfdecb1a ("fuse: fix pipe buffer lifetime for
> direct_io") broke something there.  Should be fixable easily without
> need to change the interface, because splice is free to start a new
> buffer at any point.

Actually my mistake, I had thought that splice has the same issue and I
really thought I had tested it, but actually splice works fine and has
aligned pages.


Thanks,
Bernd

