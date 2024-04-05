Return-Path: <linux-fsdevel+bounces-16177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F55899BC0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 13:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB3F1C21FB5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 11:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF51716C685;
	Fri,  5 Apr 2024 11:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wl5ElMuB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503182032D;
	Fri,  5 Apr 2024 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712315975; cv=none; b=E8JaE1uVvkFWsxq04bn/M378FfwiLZIBvBRsHVJi6fgAWOuagX1d2rWG/HoezS1r0OKraT0QfWfP117/KLU2s9+SYdH4eIW47OIOsZfzC/bjFYm15OpCS/hdeteZX3CN6sGRX31WF2U94T5cLLzqYmVr129yJ0jZOr0StInjZk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712315975; c=relaxed/simple;
	bh=D6eENCgBQXPyEg6sNqruhx+GuX+x1pb2tuOAUmIs064=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duVJ/uVfU/XoeAPNZiwUPckIkZqFqb/pT+Aq3YncPrmBS8scwuCZRl1JnMaM312WZn1/s562qKRHEezlHd01F7V89qF30yU7PhnuJOaDXyJfoYSBPuDiI6fdF6AvFsLif7s00dgobBKyOIUBtn4bomYkKon3oApT3ECowgytI0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wl5ElMuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE1BC433C7;
	Fri,  5 Apr 2024 11:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712315974;
	bh=D6eENCgBQXPyEg6sNqruhx+GuX+x1pb2tuOAUmIs064=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wl5ElMuBHn+2iLXVfIq4ibHiXCmslFxi2+3OaN21w77qfuymMyGLzQZDdLhxyd95k
	 B55y7c6Z5FvTlUgHyRkglYEG+G1LfCOTznmo6vgkCB/T5XLMjItKlj8NdFL95E2cm4
	 bjattl7wZZKdArnOTwFMZWg6+0AMyXNCzvTXl/Cu1O5TKRZDvo1AUhjlN/SEofoPH/
	 r4CFQnJJRca/6X9Oh+Hz12TE5hT+wacwfcpX55W6HhKAPUyqEttdwz03FLjLpFZwAy
	 QAlDIZhfoqbINe7+jhufW6UR6vvrF1F/JDOhCavqfMA8BFIIidI20X38jKxFjrKbns
	 08NX9ff4uJLUA==
Date: Fri, 5 Apr 2024 13:19:27 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Amir Goldstein <amir73il@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>, gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org, 
	valesini@yandex-team.ru, Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
Message-ID: <20240405-ozonwerte-hungrig-326d97c62e65@brauner>
References: <00000000000098f75506153551a1@google.com>
 <0000000000002f2066061539e54b@google.com>
 <CAOQ4uxiS5X19OT2MTo_LnLAx2VL9oA1zBSpbuiWMNy_AyGLDrg@mail.gmail.com>
 <20240404081122.GQ538574@ZenIV>
 <20240404082110.GR538574@ZenIV>
 <CAOQ4uximHfK78KFabJA3Hf4R0En6-GfJ3eF96Lzmc94PGuGayA@mail.gmail.com>
 <20240405065135.GA3959@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240405065135.GA3959@lst.de>

On Fri, Apr 05, 2024 at 08:51:35AM +0200, Christoph Hellwig wrote:
> On Thu, Apr 04, 2024 at 12:33:40PM +0300, Amir Goldstein wrote:
> > I don't follow what you are saying.
> > Which code is in non-starter violation?
> > kernfs for calling lookup_bdev() with internal of->mutex held?
> 
> That is a huge problem, and has been causing endless annoying lockdep
> chains in the block layer for us.  If we have some way to kill this
> the whole block layer would benefit.

Why not just try and add a better resume api that forces resume to not
use a path argument neither for resume_file nor for writes to
/sys/power/resume. IOW, extend the protocol what can get written to
/sys/power/resume and then phase out the path argument. It'll take a
while but it's a possibly clean solution.

