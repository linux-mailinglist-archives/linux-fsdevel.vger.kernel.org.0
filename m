Return-Path: <linux-fsdevel+bounces-49291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C64ABA29C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 20:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D213A3A57CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 18:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A37319B3EC;
	Fri, 16 May 2025 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="RmLXgRKc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dkwgYEId"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F241E9B2F
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 18:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747419348; cv=none; b=pxLTZK2Fj9z5XJBC6JnHeUbxeTgcx8wsIk8uylhOxIZpfGu79WBF2uFKbF1kBhUsOQfVmRZ9uM5lviESwcIHTMQgTGaPmrbTURy6iE41TOa/1Ci5AXSchPoqRExC0hcxDtsIynA6mLQbf7YqdECArAWQbiP7tQCYiggRnczCQQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747419348; c=relaxed/simple;
	bh=ASLQXAgzgYdlW748DG6tC0co84uYm+POSwiVUutuk9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ioFWpMgZK4vpAfGk7XreLCIq29XN+u6FzW9Fuy7tv+X6s6zzG20i6QgjcbiIzHNj1HWSI0xSktdBPfsxEPmnmAPtfRL4uUcaOPw2KRVnvvwu36eJxSWjmKcb40+8Q3lBqIjxnXwTHbpkQ0mIv0DvYtjrvjZBzOsR/cb3+WjTxiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=RmLXgRKc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dkwgYEId; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D6746254018D;
	Fri, 16 May 2025 14:15:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 16 May 2025 14:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747419344;
	 x=1747505744; bh=P+fXIyCAwDAwwvcwbqLVppGLeZ+k8MLlpLMFwwlGik0=; b=
	RmLXgRKckk/ca66pxp2Zi17zrAzKvmdzIz4EoCodctjEdFow4hgADpykT1T2o0Bm
	A5ToNRmDMuiXwi7PoKChQLf8SEkSY1+XBrXKtkpkiRSYbwqqYcS7IHpAHBH+lpkN
	EtUXPQ5dvTfViOzqtFmxEgw2UEnNPdiTOgRoGTUsx7ooqM/cyOP2+8NP7d6Xkmot
	ef+FFAunfo76Pztp8tNLvvUCMZoKnj2xisDOK8mF0V46uL/q2nNEzp+GCpsHKdKJ
	kQdC0erPQiOAmnhMK2jGb38FimTyc8CdTwx4pU5ez5sBKpF+sT83C9zdfAAUurKx
	HgWNByjUaC42yF3s8TsVjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747419344; x=
	1747505744; bh=P+fXIyCAwDAwwvcwbqLVppGLeZ+k8MLlpLMFwwlGik0=; b=d
	kwgYEIdxIdLA3sKhXKSjwzhW8c+RRtvbAehQ+M6EW1364N9qIDrhLpc45EAglsQo
	iarZG/Ea8WqaXh+6p9xlRaDCLNKuG5J33qnhRl9Puf6D8Ii2R73MXqtHD3eVukkt
	GDE4BlHM/lg2ZQcNoh84dKVHSFIHTJ110cwwdGUP7pDgO1ne9tX0EOW9QX65mwOC
	X59sZK2mIwtXWidc1SUZkxaHX75zYMDhZRIR7GKF7silX+g1IkA7iYItFbaleCJp
	2ZjgZH06MrVMmyhAnohwHjPOB6GRKOAcNPmm0tolCCFsqFOXCgLoBoypGe5CbUAD
	uHn7EIDD87bA86NM0creA==
X-ME-Sender: <xms:0IAnaHHaZcw-8z7yeodiKG872mFlLiS9IIsz4l6U_lSfX0I9BdkfOQ>
    <xme:0IAnaEWkwS-3hSqxNXPVcuqlMWlMG2IJzZu5vDgq8uPa_lwmI_KZ60Dz5hvcDI8rv
    fwypf346H0NX77E>
X-ME-Received: <xmr:0IAnaJJHBYyJbABEjvn5a4YQ_rrwwQOCdLCgta8xgooBzld6p4G9xL-UNPHTOtJf8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudefgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepffejveeffeej
    gffhfefhieeuffffteeltdfghffhtddtfeeuveelvdelteefvedtnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmhdpnh
    gspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhikhhl
    ohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesgh
    hmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtohhmpdhrtghpthht
    ohepkhgsuhhstghhsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:0IAnaFERCDg-biL564Dwn7lR9qgmJ6pHNyUpm7RTLRaGq2YW0SQzUg>
    <xmx:0IAnaNXp7YuhMjtFijrHWE-YIZecc1WwVGPacqrxHpZQffQ8bNdSIw>
    <xmx:0IAnaAOKpBtS3crTmSoQi63Iva9TetjBo7Wv6zOLREGqRiG3mfDHtg>
    <xmx:0IAnaM0Gb-BRim_FGWRX26-hJdCy1A6IVAKcsGhAl0Of5C4s29lQDg>
    <xmx:0IAnaLixKiPrX3yadGcC0_7acaXygy4SfEu_b77e-MIujUT9H7xWx9PO>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 14:15:43 -0400 (EDT)
Message-ID: <da219671-099c-49e9-afbe-9a6d803cf46f@fastmail.fm>
Date: Fri, 16 May 2025 20:15:41 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fuse: use splice for reading user pages on servers
 that enable it
To: Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, jlayton@kernel.org, kernel-team@meta.com,
 Keith Busch <kbusch@meta.com>
References: <20250422235607.3652064-1-joannelkoong@gmail.com>
 <CAJfpegsc8OHkv8wQrHSxXE-5Tq8DMhNnGWVpSnpu5+z5PBghFA@mail.gmail.com>
 <CAJnrk1ZXBOzMB69vyhzpqZWdSmpSxRcJuirVBVmPd6ynemt_SQ@mail.gmail.com>
 <CAJfpegsqCHX759fh1TPfrDE9fu-vj+XWVxRK6kXQz5__60aU=w@mail.gmail.com>
 <CAJnrk1Yz84j4Wq_HBhaCC8EkuFcJhYhLznwm1UQuiVWpQF8vMQ@mail.gmail.com>
 <CAJfpegv+Bu02Q1zNiXmnaPy0f2GK1J_nDCks62fq_9Dn-Wrq4w@mail.gmail.com>
 <CAJnrk1aX=GO07XP_ExNxPRj=G8kQPL5DZeg_SYWocK5w0MstMQ@mail.gmail.com>
 <CAJfpegvayjALR9F2mYxPiM2JKuJuvDdzS3gH4WvV12AdM0vU7w@mail.gmail.com>
 <CAJnrk1bibc9Zj-Khtb4si1-8v3-X-1nX1Jgxc_whLt_SOxuS0Q@mail.gmail.com>
 <CAJfpegtFKC=SmYg7w3KDJgON5O3GFaLaUYuGu4VA2yv=aebeOg@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US
In-Reply-To: <CAJfpegtFKC=SmYg7w3KDJgON5O3GFaLaUYuGu4VA2yv=aebeOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/16/25 09:58, Miklos Szeredi wrote:
> On Thu, 15 May 2025 at 21:16, Joanne Koong <joannelkoong@gmail.com> wrote:
> 
>> As I understand it, the zero copy uring api (I think the one you're
>> talking about is the one discussed here [1]?) requires client-side
>> changes in order to utilize it.
>>
>> [1] https://lore.kernel.org/linux-fsdevel/dc3a5c7d-b254-48ea-9749-2c464bfd3931@davidwei.uk/
> 
> No, that's not what I was thinking.  That sort of thing is out of
> scope for fuse, I think.

Yeah, I don't think that is what Keith had done for ublk either and what is
planned for fuse. Added in Keith.

> 
> Hmm, so you actually need "single copy" direct write.
> 
>   - there's the buffer that write(2) gets from application
>   - it's copied into server's own buffer, at which point the write(2) can return
>   - at some point this buffer is sent to the network and freed/reused
> 
> Currently this is not possible:
> 
>   - there's the buffer that write(2) gets from application
>   - it's copied into libfuse's buffer, which is passed to the write callback
>   - the server's write callback copies this to its own buffer, ...
> 
> What's preventing libfuse to allow the server to keep the buffer?  It
> seems just a logistic problem, not some fundamental API issue.  Adding
> a fuse_buf_clone() that just transfers ownership of the underlying
> buffer is all that's needed on the API side.  As for the
> implementation: libfuse would then need to handle the case of a buffer
> that has been transferred.

With io-uring the buffer belongs to the request and not to the
thread anymore - no need to copy from libfuse to the server.

AFAIK, mergerfs also uses a modified libfuse that also allows to keep
the server the buffer without io-uring. I just don't see much of
a point to work on these things when we have io-uring now.


Thanks,
Bernd

