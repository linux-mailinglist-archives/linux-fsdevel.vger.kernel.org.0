Return-Path: <linux-fsdevel+bounces-73776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2B6D201F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 17:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7057C300A79F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 16:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F8E3A35A5;
	Wed, 14 Jan 2026 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7kr3TH5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899E53A1E6F;
	Wed, 14 Jan 2026 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768407317; cv=none; b=mL29Iy9mkHemdGekey0Y8bDTwuoDOSqj+C+ww3Wm1QtvYhoBr06HcLQfW3p+976VpYaCS8vfJ/MFI4+7mKx/jt2FfU6l+Ry4cOm6/Hgj0/SMgH5VERXTV14/b2uFPnoOHWPw/O1Uu50AkaT5rb5GylIJBhUFNiGv6yRUdlOV9rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768407317; c=relaxed/simple;
	bh=xxSoV+yyVboiMCzis/a8clEBZUeKrIPyC+H4oUFWIyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRVfX3ibJFMfqpmqRMWK8tq2aufmSd5Z+25gyW7RS6vUkTf/QHHWgZpx0MfqvAEyFnozFmGk8h0x9PU9Xt6GV6ujwG26/XvNbva06bh1dZnvvor4PL0GMl1dXUNwVeIO7+6SO65Bv5yjSdaTP4YL1pQmuIgfgKdiDrKrVVi/gjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7kr3TH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC88C4CEF7;
	Wed, 14 Jan 2026 16:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768407317;
	bh=xxSoV+yyVboiMCzis/a8clEBZUeKrIPyC+H4oUFWIyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T7kr3TH5bldd1edzHjx//e957/pF3NDF/A7Cyw/wRkqvtHAc0e6BjvkDpOhuxMypE
	 WuXlYBi66kvAlL+cRUZYs8Mvf+MtAKDfIv2YXaUYtuqkQB2GSvgXWuqX73hlnRlARv
	 lEyHmM6+5dxAf/toJgDiU8HSS4nMiEiwx2dXCR4ITCHq1T1eDzfnRrA3k/JCXXfyw9
	 dGxSxIEroDOmSyVHlvaN5j3MkLElrLsQIxXIkU+iD+fGJ4kNhI8IwvAUR4cVBOIQAp
	 30scBqQ2GTQP8lb499Uh506v/KfAlxe3wfTTgwOMs0M0ecmABJfNlScXI0exxKssmn
	 1qbND0Q6w0OEA==
Date: Wed, 14 Jan 2026 17:15:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Zhiyu Zhang <zhiyuzhang999@gmail.com>, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] fat: avoid parent link count underflow in rmdir
Message-ID: <20260114-bestzeit-sparen-9f4247ba30f7@brauner>
References: <20260101111148.1437-1-zhiyuzhang999@gmail.com>
 <87secph8yi.fsf@mail.parknet.co.jp>
 <87ms2idcph.fsf@mail.parknet.co.jp>
 <CALf2hKu=M8TALyqv=Tv9Vu98UKUcFjWix1n5D9raMKYqqZtY5A@mail.gmail.com>
 <20260112095230.167359094e9c48577b387e18@linux-foundation.org>
 <87cy3ed7c9.fsf@mail.parknet.co.jp>
 <20260112103959.e5e956cd0d8b6f904e21827a@linux-foundation.org>
 <20260113-rammen-unsinn-d9d5929ca2a0@brauner>
 <87y0m1bzax.fsf@mail.parknet.co.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y0m1bzax.fsf@mail.parknet.co.jp>

On Tue, Jan 13, 2026 at 07:08:06PM +0900, OGAWA Hirofumi wrote:
> Christian Brauner <brauner@kernel.org> writes:
> 
> > On Mon, Jan 12, 2026 at 10:39:59AM -0800, Andrew Morton wrote:
> >> On Tue, 13 Jan 2026 03:16:54 +0900 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
> >> 
> >> > Andrew Morton <akpm@linux-foundation.org> writes:
> >> > 
> >> > > On Tue, 13 Jan 2026 01:45:18 +0800 Zhiyu Zhang <zhiyuzhang999@gmail.com> wrote:
> >> > >
> >> > >> Hi OGAWA,
> >> > >> 
> >> > >> Sorry, I thought the further merge request would be done by the maintainers.
> >> > >> 
> >> > >> What should I do then?
> >> > >
> >> > > That's OK - I have now taken a copy of the patch mainly to keep track
> >> > > of it.  It won't get lost.
> >> > >
> >> > > I thought Christian was handling fat patches now, but perhaps that's a
> >> > > miscommunication?
> >> > 
> >> > Hm, I was thinking Andrew is still handling the fat specific patch, and
> >> > Christian is only handling patches when vfs related.
> >> > 
> >> > Let me know if I need to do something.
> >> 
> >> OK, thanks, seems I misremembered.
> >
> > I prefer to take anything that touches fs/ - apart from reasonable
> > exceptions - to go through vfs tree. So I would prefer to take this
> > patch.
> 
> OK. I will add you to To: (with Acked-by) instead of Andrew next time?

Yes please. Thank you!

