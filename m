Return-Path: <linux-fsdevel+bounces-64016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 396E8BD60B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 22:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0E494EB13B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 20:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1062DBF4B;
	Mon, 13 Oct 2025 20:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="W3nCDC/F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xZDBaQRQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E667C23F40D;
	Mon, 13 Oct 2025 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760386572; cv=none; b=l0K9WA8jK32vZK40S1ndQHYd3FDCWvf9rb4Ua5tLgd5aPE8cTKMHShedWuHvDZFLXv1s6YItE4JJicLjy5qzWTarUgGFu7bvHcedrTqP3rMWVOuG58WSFZDf5o+oj1dVNXI3AMljBrFr5aVPJPIVg6brzPKgAWfDYlJz2KALWow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760386572; c=relaxed/simple;
	bh=O4Rm4wsUSGFW4OxvMCJHeNaHN1GvluA3ToulwTHb/tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a5QQOy3kykxYItT/Fxk7er5ikBhfLfEaz0FwRMAEcSfbDkq0Kt2yLR8r47rMR6aE8F4U4hzo+7xro6c2C9dJB/i0KEK+oXoASV4KRjdMG7qh++01Fr1odcbFmDhtd7KwpUnLIvD7U0fD8MGGp3O1bm8UZnG/FBqM1FcSo4YXlf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=W3nCDC/F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xZDBaQRQ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E9CFC7A042C;
	Mon, 13 Oct 2025 16:16:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 13 Oct 2025 16:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760386566;
	 x=1760472966; bh=/Chgvb5Vr9Np2OqJMeWaxCMBRL89Tjsn/P5EOfDuoeI=; b=
	W3nCDC/FnOgFylJ8JCUCdYeLSY6UD/suLZEfg8qtLLxh9TMZ19GPy2b72MjPxhZq
	8CdVNEVEl2DgdUK17ApCUcL7m37kmRs8Vh2tQGtERWC0C4QojaoLMjiGgaxQF5gE
	KuqvPCxC7Jb2aKelFevwTRd6Sfq98fkcxXgGRnoRRvaH2mmktRotAW1sdk4ceKnC
	KAzzQEd/XWu0nii+r0hb4lWQSyjHdnte0T0MSmGaCUKixJ+tRxCQ705wyeyI8UrR
	VEmU7APEQJSngx5tefVwt5ZVH9NUW+2TZ+t4fnl+OcLVj7oMeFvYt5rmK62A82U1
	HE2nffkht0odRyqstqCU8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760386566; x=
	1760472966; bh=/Chgvb5Vr9Np2OqJMeWaxCMBRL89Tjsn/P5EOfDuoeI=; b=x
	ZDBaQRQDw3oGekGIOPiEJWjKQJXbfHPGrDy1skqky954IjFduPBez7FjeA4kXTbq
	3fLmQ7FcBtbwmyFiUL/w0hIwMY4jIuZv1sLPkFzkFpJFHCJbiT7W76by8Tuj+HS0
	V+dg99kQsA8AjfEMfCyijI2oo7T8syAQAPgrmiinxH5L3smvGsmea0l7WcmEpFor
	smdeX2hvBESofDSQu8ZBb0/6g2WB8z/fIfpy7CyGCV8GDBg3m1Mbt59ENPKWQJu0
	M8zL7Xtzvgi+FROdw9CRaIMRf/cmdCwtoA4vsOpdidXrlGrJyAKN//4UCaRhQu7E
	2B7JZ8PP7Ilj3BXwPNC4A==
X-ME-Sender: <xms:Bl7taIbtgnPLnXuFahUqjMWPQji76AKxk4oOIJWuAKQSXvRR7Ngb5A>
    <xme:Bl7taMv1mt-nPr3MWrs5ryauAWwj5IJ7wkgQvbCe6nAF1kLLfxuWlZVbEHSTUfGMN
    u7v4VeEWgnrG5ghICYNKpb2rs0Tfv67QgwPFDJSk5ItrjSSW-zU>
X-ME-Received: <xmr:Bl7taKPYaHVifc6zqjKtAG088LfXclQYYqnTrE3QI2Jht82q-vKcqxPw4uzX8zDxvNoMmM1QjFbpH733fkrLmwLfT0n1nzI6vuOhRiv_DMGMWM1V4m3a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudekheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeejgfeljeeuffehhfeukedvudfhteethedtheefjefhveduteehhfdttedv
    keekveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtgho
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmh
    hikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehgihhvvghmvgdrghhulhhu
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrih
    hlrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegsfhhoshhtvghrsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:Bl7taD7Ous-nhhxQMmLRcLiqr9oURKNgc1JiaA-x_JRmx3AggR9xQQ>
    <xmx:Bl7taAT7BTu_6O-JR2FxLeh9aXwtzSoz_dfAG39yyxNVVKFVmvA-aw>
    <xmx:Bl7taAB9j19rg5yvcTQM4RpeeCHjdtA6CpuVSDe7w2VvzBJPfokxAg>
    <xmx:Bl7taAEVqsFSdwJMDfrmbzzBYyHSDOpfhCGfudahXTXKZL_WcuAVYg>
    <xmx:Bl7taHDzEocpQAqEB5Z54BP32xpRCeOFNScfY1dole57fjWMGknr5uzj>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 16:16:05 -0400 (EDT)
Message-ID: <d82f3860-6964-4ad2-a917-97148782a76a@bsbernd.com>
Date: Mon, 13 Oct 2025 22:16:04 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: Miklos Szeredi <miklos@szeredi.hu>, lu gu <giveme.gulu@gmail.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Brian Foster <bfoster@redhat.com>
References: <20251009110623.3115511-1-giveme.gulu@gmail.com>
 <CAJnrk1aZ4==a3-uoRhH=qDKA36-FE6GoaKDZB7HX3o9pKdibYA@mail.gmail.com>
 <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
 <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
 <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/13/25 15:39, Miklos Szeredi wrote:
> On Fri, 10 Oct 2025 at 10:46, Miklos Szeredi <miklos@szeredi.hu> wrote:
> 
>> My idea is to introduce FUSE_I_MTIME_UNSTABLE (which would work
>> similarly to FUSE_I_SIZE_UNSTABLE) and when fetching old_mtime, verify
>> that it hasn't been invalidated.  If old_mtime is invalid or if
>> FUSE_I_MTIME_UNSTABLE signals that a write is in progress, the page
>> cache is not invalidated.
> 
> [Adding Brian Foster, the author of FUSE_AUTO_INVAL_DATA patches.
> Link to complete thread:
> https://lore.kernel.org/all/20251009110623.3115511-1-giveme.gulu@gmail.com/#r]
> 
> In summary: auto_inval_data invalidates data cache even if the
> modification was done in a cache consistent manner (i.e. write
> through). This is not generally a consistency problem, because the
> backing file and the cache should be in sync.  The exception is when
> the writeback to the backing file hasn't yet finished and a getattr()
> call triggers invalidation (mtime change could be from a previous
> write), and the not yet written data is invalidated and replaced with
> stale data.
> 
> The proposed fix was to exclude concurrent reads and writes to the same region.
> 
> But the real issue here is that mtime changes triggered by this client
> should not cause data to be invalidated.  It's not only racy, but it's
> fundamentally wrong.  Unfortunately this is hard to do this correctly.
> Best I can come up with is that any request that expects mtime to be
> modified returns the mtime after the request has completed.
> 
> This would be much easier to implement in the fuse server: perform the
> "file changed remotely" check when serving a FUSE_GETATTR request and
> return a flag indicating whether the data needs to be invalidated or
> not.

For an intelligent server maybe, but let's say one uses
<libfuse>/example/passthrough*, in combination with some external writes
to the underlying file system outside of fuse. How would passthrough*
know about external changes?

The part I don't understand yet is why invalidate_inode_pages2() causes
an issue - it has folio_wait_writeback()?


Thanks,
Bernd

> 
> Thoughts?
> 
> Thanks,
> Miklos


