Return-Path: <linux-fsdevel+bounces-32664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7759ACB12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 15:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6958AB213AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 13:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8851E1ADFF7;
	Wed, 23 Oct 2024 13:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkf0ULwK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF8812B71;
	Wed, 23 Oct 2024 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729689656; cv=none; b=ElrhNMcibyL2+0w4qBg4tM4DnMPvwMDBufSc/TWw3FRp9f16BUUJwicEocQeWqBsiNlDzKnr+4SlR5EpqdunrOfstww/BJ+jaQh7pS9AHl0Cknp96prZSyJ45EYmpye4nllfEYiE7EFuCePXOd5/GY/iZeMvz1hUaLF56RBY7/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729689656; c=relaxed/simple;
	bh=LVQXYrASjM/VnmqTuSPEIhogLWcRwzbltNRHE+dqq6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YndOYQ2ksA25WT+OvUAJvF+5fQwdVcXzhMhISn2399i1/vdaKwisJJTDWwJwaPhrAb83z7d7fPMk1Y9XkM9Vkh0dpMMn/j1sQkKsgZtSt3UYkzpTI3go/8BYh1OYO14laxBirrnV05FVpsHAsN09uvtwNrjsUQf9s7yd3aW8GH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkf0ULwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD68C4CEC6;
	Wed, 23 Oct 2024 13:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729689655;
	bh=LVQXYrASjM/VnmqTuSPEIhogLWcRwzbltNRHE+dqq6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jkf0ULwKxVbpGpPOoLIU7ZeX+X3gsPpBPlD+M1OGYex6nVUZ+9zgMNpYSYMMRskf1
	 1aVOP2nA2aLLGJuBwEE65JpTrPJrel/R3DINt/dOSefdQlvaS2yTfMNuHnGynin1sQ
	 HoUO8q9FP8ttRel+u/S3lVFLON6Jeh+sk3kZtP1Ye3LtY9mLz8ZCKefMWgm/ToNB6Z
	 kzXhJ5Xa6VwN0aqExw4LvPXeCpdxihjgP56/BR5soacWlkMdTFtHfukmtpLlXDy1IE
	 IfYrLSA2M+OtjuCWTrFYW9jHjOosv0yHx/wtyNfgFts0A1ZV6xPccmvbwZc+ePFoun
	 J23OerzdFxBJA==
Date: Wed, 23 Oct 2024 15:20:50 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Joel Granados <j.granados@samsung.com>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org
Subject: Re: Re: sysctl: Reduce dput(child) calls in proc_sys_fill_cache()
Message-ID: <t4phgjtexlsw3njituayfa6x5ahzhpvv6vc2m6xk6ffcbzizkl@ybhnpzkhih7z>
References: <7be4c6d7-4da1-43bb-b081-522a8339fd99@web.de>
 <y27xv53nb5rqg4ozske4efdoh2omzryrmflkg6lhg2sx3ka3lf@gmqinxx5ta62>
 <3a94a3cb-1beb-4e48-ab78-4f24b18d9077@web.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a94a3cb-1beb-4e48-ab78-4f24b18d9077@web.de>

On Wed, Oct 23, 2024 at 02:10:57PM +0200, Markus Elfring wrote:
> >> A dput(child) call was immediately used after an error pointer check
> >> for a d_splice_alias() call in this function implementation.
> >> Thus call such a function instead directly before the check.
> > This message reads funny, please re-write for your v2. Here is how I would write
> > it.
> >
> > "
> > Replace two dput(child) calls with one that occurs immediately before the IS_ERR
> > evaluation. This is ok because dput gets called regardless of the value returned
> > by IS_ERR(res).
> > "
> 
> Do you prefer the mentioned macro name over the wording “error pointer check”?
yes.

> 
> 
> >> This issue was transformed by using the Coccinelle software.
> > How long is the coccinelle script? …
> 
> A related script for the semantic patch language was presented already according to
> the clarification approach “Generalising a transformation with SmPL?”.
> https://lore.kernel.org/kernel-janitors/300b5d1a-ab88-4548-91d2-0792bc15e15e@web.de/
> https://lkml.org/lkml/2024/9/14/464
> https://sympa.inria.fr/sympa/arc/cocci/2024-09/msg00004.html
There where several scripts in these links but non of them where too
long. Can you please append the one you used for this patch to the
commit message.

Thx

-- 

Joel Granados

