Return-Path: <linux-fsdevel+bounces-31149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D63D992627
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 09:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C732833E9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 07:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC4217C234;
	Mon,  7 Oct 2024 07:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yrec9Pux"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF8C11711
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728286655; cv=none; b=FZBEMwJMY375GWuh3Otrv1JFzVSoJWtFsVLESl3VcDReiUuvRXpHINgNoHwdJb2Kd8kqB6xTB5Qq8tnemGEVl5dagt9Mg0Vrm7skypxzBzPTyzT9OkEa/8bpQ8UuAMSSpf1zywT6yIMed1SLEuQBiHFg6gSr1edZM/REHIjmuDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728286655; c=relaxed/simple;
	bh=2Ml4Le+NYy9E+VY6lX9eWLgyRcMtWK3VnEAxLprbNf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oX8Vwtm3tpFCTH+IVeTo586gnkX8oeWJJo+ACKp01BexB7VG6rAPdpUD1L5D8sxihkQemBnmpWrui8HWIFlq5zuI1rey+7dO7+tkvrivcSpBR2zERUrnVndULfQrJVDLvovRZWLkbb3hynYwR7t7Z2kngh0pmOW2E5Souj5MkAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yrec9Pux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C2EC4CEC6;
	Mon,  7 Oct 2024 07:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728286654;
	bh=2Ml4Le+NYy9E+VY6lX9eWLgyRcMtWK3VnEAxLprbNf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yrec9PuxOk0W5+fm+eXa0JQSez+Zxx94ZdVqIaFBUaBjP03ajg+CLxJFuubC3AnO2
	 rleMtF+ARPLzvnprDe0Yvg5jSys/oVNAk+4HUqA1oTmQwCaNPrd4kkKF/N0CD7eU3D
	 xSOea53Tz+nEKsuLjtfemgjHH/dgpVrNUundAIJtmkLwNFSflpAB7JpYZU698XnhNx
	 9oOo9/3dLuAde5gUsRp010a/lnivxPZkOaz/B9WX+HkZKEPewjH2ke4eE1ydMbILM7
	 j3Tqt1M9AV6qPi5cIz56GW2Un6haWAt7Ftx0uobQnrj0BRG9wpE6uSNKyZDie3ZJ+O
	 Nzj8Z2pQhpFIQ==
Date: Mon, 7 Oct 2024 09:37:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH RFC 0/4] fs: port files to rcuref_long_t
Message-ID: <20241007-hundstage-ablesen-294eddfbe9c2@brauner>
References: <20241005-brauner-file-rcuref-v1-0-725d5e713c86@kernel.org>
 <CAHk-=wj7=Ynmk9+Fm860NqHu5q119AiN4YNXNJPt=6Q=Y=w3HA@mail.gmail.com>
 <CAHk-=wgwPwrao9Bq2SKDExPHXJAYO2QD1F-0C6JMtSaE1_T_ag@mail.gmail.com>
 <20241006-textzeilen-liehen-2e3083bd60bb@brauner>
 <CAHk-=wg2VQzbenNK2puyjMQnpCLeXih92B8032Q-9ur0z33iXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg2VQzbenNK2puyjMQnpCLeXih92B8032Q-9ur0z33iXw@mail.gmail.com>

On Sun, Oct 06, 2024 at 11:09:30AM GMT, Linus Torvalds wrote:
> On Sun, 6 Oct 2024 at 03:21, Christian Brauner <brauner@kernel.org> wrote:
> >
> > Iiuc, then we should retain the deadzone handling but should replace
> > atomic_long_add_negative() with atomic_long_add_negative_relaxed().
> 
> I assume you meant the other way around.
> 
> However, then it's not the same as the regular rcuref any more. It
> looks similar, it sounds similar, but it's something completely
> different.
> 
> I definitely do *not* want to have "rcuref_long_get()" fundamentally
> different from just plain "rcuref_get()" .

Right, that's why I added a separate helper. IOW, I didn't change the
behavior of the helper.

> 
> Now, maybe we should just make the plain version also do a full memory
> barrier. Honestly, we have exactly *one* user of rcyref_get(): the
> networking code dst cache. Using the relaxed op clearly makes no
> difference at all on x86, and it _probably_ makes little to no
> difference on other relevant architectures either.
> 
> But if the networking people want their relaxed version, I really
> really don't want rcuref_long_get() using non-relaxed one. And with
> just one single user of the existing rcuref code, and now another
> single user of the "long" variant, I really don't think it makes much
> sense as a "library".
> 
> IOW, my gut feeling is that you'd actually be better off just taking
> the rcuref code, changing it to using atomic_long_t and the
> non-relaxed version, and renaming it to "file_ref", and keep it all
> purely in fs/file.c (actually right now it's oddly split between
> fs/file.c and fs/file_table.c, but whatever - you get the idea).
> 
> Trying to make it a library when it has one user and that one user
> wants a very very different model than the other user that looked
> similar smells like a BAD idea to me.

Ok, sounds good.

