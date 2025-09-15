Return-Path: <linux-fsdevel+bounces-61290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07445B573B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 10:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673C43A8E3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 08:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6222F3605;
	Mon, 15 Sep 2025 08:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="FUw+fADi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ggeEpfsi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FC82EFD98
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926473; cv=none; b=HAMT0MaqacP/y0heIypkTJvLVVj9W4Q6K0Pbbqp1H1jCkuq9ml4ziPk7m+Y54vtjfDa0P6mK7nWcvWnmHeSdyj3QXLMxbuHyj4V9XG6hGt7PfHepBOPmgUVi2XZ2osG/4yyRtk04kZ1pdEzmsQrt5KZMxLKYap1UNPOJHcp910Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926473; c=relaxed/simple;
	bh=vuwffLT4aDb91xpGVyBK4tzX66MW2A3TWPkdaeQGSd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+ZflaIsBlLLjiU2PEitxqVmvN/z8WNhQSKLRxQoGrNtD0ixle3kCBGVm4raurueCo/4AUo8lwKH56GYg/9rxRy6XYbddVVjYAQGSUhsmPcX3ByPmQe0dyxqP4PA/eNeT13LI2yWVVsIzYol1qHVSaRy6n23GqEyYdqecosBU3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=FUw+fADi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ggeEpfsi; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3A5FA7A007A;
	Mon, 15 Sep 2025 04:54:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 15 Sep 2025 04:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757926470;
	 x=1758012870; bh=PVDcvdErTTvTPg8kb4DgHh9EI2hNbZrGZzQ50VoxzUc=; b=
	FUw+fADiJEzdN3yxYcTTsYOvTUxbMdCHU5SThvUXjl22a878C0zrBMYOG2Epve/N
	APslzw1spibvjimg6RFnVpJdOapmEjzdE1Zyy4pXPul/wW4sKyqK/Fv9vZQ/mvkp
	aiFJwZuCtsx6UVscN7CEhccDixTlMW5ueQtepFsZ29cEIBTxu74yzCEqYfxxQQAf
	z9fA0+LRkHdhh0Xcn5hoDCQ6wbUrmZTRCTr4U5zQz0rSbbY+PTsWeEYNWemBpCsA
	zuFX81pTXb+AC1kmhm8ZR03bSl/mSkHUJpTF9Ysnx0AOHZ0MNbJy13PBkFWqJAJG
	UMEoo/vRQzopRbPDkX3mBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757926470; x=
	1758012870; bh=PVDcvdErTTvTPg8kb4DgHh9EI2hNbZrGZzQ50VoxzUc=; b=g
	geEpfsiP4hwkScei9DYpbmpfadRRNwxXt0SFCvDFIWJnFUtiDOlxuftM6XTXUbUZ
	GsBikp+Ky6CFH/BlXUziRF8uEitHL9wvYP/+jAxcahXcRskqqdppeHvUMhTgLaTf
	5dqxD8R6fOdy1+nOasxhXVV5c90WrXkZgPkTRCexu7nQdL4o9KS9fVRSjeBh1aCa
	padPFRPU2lEVmylCuseqJ7Bb4F+1yCJbsOHpqMUP2ceza+gF6FLWFCOee+/kdA2/
	q3h1IxnXgsIeDramrfzTFQ8z4E8/o+Qrr612btpfKWTlALtqdee650dBp6x74Hv7
	VDAVCBWzyUbIJc9S2xllw==
X-ME-Sender: <xms:RdTHaG5PFoCwlccJZ8DiLlvcuAQirFDvHsC13x6dY86uCUaR20727w>
    <xme:RdTHaGr2B7UACXIQIX3N65HJNrY8wfsZ5MZkIWzYXZVuVgOK1Jjtyqoj69pXKfrdZ
    SwvMuauhoOBN1Ox>
X-ME-Received: <xmr:RdTHaHMHM4SSwqY69bS-13HQg4q25wF6rG1EnG_EoPfESZXOJCM3OCygFWL4PrKPNIevJsyWTLOw4nnHHXYj5cBmmnJ9niDKYKRSgij5dMZLRV5RCSji>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhephefhjeeujeelhedtheetfedvgfdtleffuedujefhheegudefvdfhheeuvedu
    ueegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtph
    htthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtohep
    nhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopehtohhrvhgrlhgusheslhhinh
    hugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphht
    thhopehhsghirhhthhgvlhhmvghrseguughnrdgtohhm
X-ME-Proxy: <xmx:RdTHaO1SjUEbLRCI2UhZFFDsKtTORp-3O8QzBIuO20YOw3ZY7Nj42g>
    <xmx:RdTHaGDytee7mItlUVkY5YSaeWyTK84KWD0GxNt7GVot8A4EcKP_5w>
    <xmx:RdTHaLKiOlIjhOX7rsYHHtxN3Vin571A0Vd5U0Rd2UYhH1CG579amQ>
    <xmx:RdTHaPnn3BrE7mTf15nzxdk2kx7ORy7CbATDZAZIToXZF9UoxF_JnA>
    <xmx:RtTHaPELJI8dbyzq6uFoD345KEs0V53f9ZCwRpMznYXQ32WIcyVk-OjV>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 04:54:28 -0400 (EDT)
Message-ID: <01e93ff6-ddce-48a4-a44e-c6af1c546754@bsbernd.com>
Date: Mon, 15 Sep 2025 10:54:27 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ->atomic_open() fun (was Re: [RFC] a possible way of reducing the
 PITA of ->d_name audits)
To: Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>
Cc: NeilBrown <neil@brown.name>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, Horst Birthelmer <hbirthelmer@ddn.com>
References: <20250908090557.GJ31600@ZenIV>
 <175747234137.2850467.15661817300242450115@noble.neil.brown.name>
 <20250910072423.GR31600@ZenIV> <20250912054907.GA2537338@ZenIV>
 <CAJfpeguqygkT0UsoSLrsSMod61goDoU6b3Bj2AGT6eYBcW8-ZQ@mail.gmail.com>
 <20250912182936.GY39973@ZenIV>
 <175773460967.1696783.15803928091939003441@noble.neil.brown.name>
 <20250913050719.GD39973@ZenIV>
 <CAJfpegvXtXY=Pbxv+dMGFR8mvWN0DUwhSo6NwaVexk6Y6sao+w@mail.gmail.com>
 <20250914195034.GI39973@ZenIV>
 <CAJfpegvD7Ch59LJi8ymB6yX2TNMpQxVRLZ3xvsGLbsrktQ88_A@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegvD7Ch59LJi8ymB6yX2TNMpQxVRLZ3xvsGLbsrktQ88_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/14/25 22:05, Miklos Szeredi wrote:
> On Sun, 14 Sept 2025 at 21:50, Al Viro <viro@zeniv.linux.org.uk> wrote:
>>
>> On Sun, Sep 14, 2025 at 09:01:40PM +0200, Miklos Szeredi wrote:
> 
>>> - cached positive (plain or O_CREAT): FUSE_OPEN_REVAL getting nodeid
>>> of parent + name + nodeid of child and return opened file or -ESTALE,
>>> no locking required
>>
>> What happens if the latter overlaps with rename?  Or, for a cached
>> directory inode, with lookup elsewhere picking the same inode as our
>> cached (and possibly invalid, but we don't know that) dentry?
> 
> In the overlapping rename case either result is okay: if the open
> succeeded, that means open won the race against rename.  If on the
> other hand open_reval lost and didn't find the expected child, then
> dentry is going to get invalidated and the whole thing retried ending
> up with open_atomic or open_creat with no further races possible.
> 
> With the stale dentry getting moved by d_splice_alias() it's a
> slightly different story.  The dentry starts out stale, but by being
> moved to its proper place it becomes uptodate again.  So before
> invalidating it, it would make sense to check whether the parent and
> the name still matches the one we are looking up.   But that race
> happens with plain ->d_revalidate() as well AFAICS, so that wouldn't
> be a new thing.

Thanks Miklos for bringing this up again! I'm going to try to update
the patches this week. One issue with open-atomic and open-revalidate
was testing - Horst (in CC) had started to create fuse specific
xfstests for that.


Thanks,
Bernd

