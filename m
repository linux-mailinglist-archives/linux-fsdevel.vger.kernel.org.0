Return-Path: <linux-fsdevel+bounces-41850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA15A38456
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 14:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206FE175164
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 13:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D51221CC55;
	Mon, 17 Feb 2025 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="Hr76/uRW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.104.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4155821C191;
	Mon, 17 Feb 2025 13:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.104.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798041; cv=none; b=MX5ru+cD/YgMQrejwEgEbtopk6d/1chZIhi4A8OUm+NGBF2N2H16vprcusIZYMZQbY0pfqXC0cTNVMbc8+x9d/cqV5lIf1rg4YPuSpbRb2pbv7JE5EvrdZqOo6We7Kc5gdWPOQIMIR3MzWJ/ofyMLEJRD1cJmwBeJJ3LPVRrdSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798041; c=relaxed/simple;
	bh=yfcja7yr+aI/lTUxW5RMXDC86vGcZIWVsYT+gOG/FC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9Kkf2jJGdiZSjEcO05cHf1lauE0dDsARzpOow4QXIrjaoUw3Bv4tTBQasfN0kVQ9ks6rPVNKqbVwFXkCkVTc4pyzKHe6gG3q9NzDyL5ImEZ4+uvjPyW/N23yOnYKEDdbpzMQDPULo/gf02YQhlSt0sI5gynHXgSu1EW3nDZLOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=Hr76/uRW; arc=none smtp.client-ip=148.135.104.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4759F5F587;
	Mon, 17 Feb 2025 08:08:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1739797721; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=gzJ2YG6weSz+CFbCyKl4mnY+VTrcTl16Wh/C2tZm7So=;
	b=Hr76/uRWkKlFnJ9mXitWgfsKCR5bkSaoSUi28tvfsejgjGS7BsOSdwwTTBRJ2aMhY84EvA
	Z1GmO8cvlB684BYprLOXvewp9WqhhBHQWOoFcsRkxFbFGbAi57FqGbl1AozUC+JU+9WIa3
	yId6kAVXF+SKz8jn8vA53vqzQHdibStxZmf0dXPvMqHff39grxtCH/o72AmCiiWEXVBQel
	uxHJTSm6BdZT1jAyg02UE4lSjPM3uAo6bUshW2HKEJIJ5ojz3y6eM1BnXR/yA1Nt+kAbiA
	LHuOAVPMVCvQ5Bloss2LMlUtOnj1icsD4L7xjpZMC0Dcsoqz1XrNrqx6a38WlA==
Date: Mon, 17 Feb 2025 21:08:21 +0800
From: Yiyang Wu <toolmanp@tlmp.cc>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
	lsf-pc@lists.linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Subject: Re: [LSF/MM/BPF TOPIC] Rust in FS, Storage, MM
Message-ID: <g5tqgpda4wbhpmi5ahh5btujwajy5dolcouhk2hx6qo2fg5nwr@ua2wnnuvxmeb>
Reply-To: 0290170c-39df-4609-8de1-55695d6ec0ad@linux.alibaba.com
References: <87ldu9uiyo.fsf@kernel.org>
 <0290170c-39df-4609-8de1-55695d6ec0ad@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0290170c-39df-4609-8de1-55695d6ec0ad@linux.alibaba.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Feb 17, 2025 at 06:41:32PM +0800, Gao Xiang wrote:
> 
> 
> On 2025/2/14 14:41, Andreas Hindborg wrote:
> > Hi All,
> > 
> > On behalf of the Linux kernel Rust subsystem team, I would like to suggest a
> > general plenary session focused on Rust. Based on audience interest we would
> > discuss:
> > 
> >   - Status of rust adoption in each subsystem - what did we achieve since last
> >     LSF?
> >   - Insights from the maintainers of subsystems that have merged Rust - how was
> >     the experience?
> >   - A reflection on process - does the current approach work or should we change
> >     something?
> >   - General Q&A
> 
> Last year Yiyang worked on an experimental Rust EROFS codebase and
> ran into some policy issue (c+rust integration), although Rust
> adaption is not the top priority stuff in our entire TODO list but
> we'd like to see it could finally get into shape and landed as an
> alternative part to replace some C code (maybe finally the whole
> part) if anyone really would like to try to switch to the new one.
> 
> Hopefully some progress could be made this year (by Yiyang), but
> unfortunately I have no more budget to travel this year, yet
> that is basically the current status anyway.
> 
> Thanks,
> Gao Xiang
> 
> > 
> > Please note that unfortunately I will be the only representative from the Rust
> > subsystem team on site this year.
> > 
> > Best regards,
> > Andreas Hindborg
> > 
> 

Since i'm cued in, I'd like to share some of my thoughts on the Rust.

I've worked on the EROFS Rust codebase so far. I may have insights on
the current status of Rust subsystem progress. On the Filesystem level,
there still left a lot of yet to be determined especially.

Reimplementing the core functionality of a filesystem is already ok,
though not from perfect, and certainly we need a better abstraction
to model the filesystem correctly in rust language.A lot of helpers (MM,
BDev, Network Application Layer for NFS, etc.)

are still left in the wild to be completed and it requires a lot of
coordination from other subsystem maintainer and rust maintainer
to abstract the C-API into Rust code a way that all parties can hold on to.
I guess it's not the right time to do so in general, we can use rust in
some specific filesystems but generally before other subsystems's API
are stabilized, it's not a good idea to refactor the whole VFS codebase
and abstract the API into Rust one.

Filesystem should be free from memory corruption and rust is
definitely worth the efforts to refactor some of the codebase. 
That means that we may need restrict the flexibility or somehow refactor
the object model that current VFS uses and this certainly requires the
original team that implements the VFS to be involved, at least express
some willingness and interest to refactor instead of gatekeeping the
whole codebase and shutting down the whole discussion (i don't mean to
make criticism here BTW since we should be pretty cautionous on the
original code and don't introduce certain regression issues.) But i guess the
whole community is somehow polarized on this issue, it may not be an
easy job to begin with, alas.

Best Regards,
Yiyang

