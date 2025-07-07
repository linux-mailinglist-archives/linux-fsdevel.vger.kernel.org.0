Return-Path: <linux-fsdevel+bounces-54079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AD9AFB135
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 12:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818EC4A00B5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 10:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDF1295530;
	Mon,  7 Jul 2025 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njVAsFN8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C59C293B55;
	Mon,  7 Jul 2025 10:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751884122; cv=none; b=srlUQv2nG5T/FDVh9Y/6KnOPLOYxOhLW+5F1uhVR7fOuzc+idjtk1A+16CzXoyfdOufJMQW3DUAkH8EBKauHuSV/mxequ9rOedWRrjSWgX9X/uOkMFFKrxWc9zI4nlH9Cw4HLW1szFM8xXgZ2GJlpLtPOKtWcdV8rHhbWJ/x148=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751884122; c=relaxed/simple;
	bh=3c9wlvp7eERnk97turEd450KUJTVOWkZyEo3KsQKb4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8kazLLmtkn7oj0sq2HkX1YQBDxmGBkHgK+5I0pyTQS9z9g8NjDkxBcuheFhRXwggtWVW+6zo2fjWkBCj/eOWtfUo2Hxg3xoOG65qCnW0uCVG2Leut+3UQFp3LVuTPUKpXzmXfWIgTaQLv1pUUjTPRV0wPybOwdv1lv0zyGra3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njVAsFN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E9FC4CEE3;
	Mon,  7 Jul 2025 10:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751884122;
	bh=3c9wlvp7eERnk97turEd450KUJTVOWkZyEo3KsQKb4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=njVAsFN8O6TSHsg1XYrh10kzgdmIkh1PduKj7UeFxCYIU+7Lh/jFCNzVaOAu/wzow
	 /qGsWXSrlh/v9idhEttS+aPJ6xL/mmCdOcBG//YwVGVjI0inHKSEjMT8T9jZ7+kqf3
	 C3P4b+l+Dx6T/GJY+5tl7jObCYMXXrCZfZlBXyAJzTbOVPsrF0ezEcKFNtrgr1cFy2
	 FONE/3k5ZBDdSOVokyp34cDk7kWvw2bGP/JxYICa3hNqqPFkSSSdGTYbfylyb32Eq2
	 qz1KxRUBH4seRbwhG+goOWIKgLXAomu23NxhEkI9ITKEmRlQfT5qgdwd0HNfq/Y9v9
	 5bBpONAh1c6eg==
Date: Mon, 7 Jul 2025 12:28:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Song Liu <songliubraving@meta.com>, Song Liu <song@kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
	"jack@suse.cz" <jack@suse.cz>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"mattbobrowski@google.com" <mattbobrowski@google.com>, "m@maowtm.org" <m@maowtm.org>, 
	"neil@brown.name" <neil@brown.name>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH v5 bpf-next 2/5] landlock: Use path_walk_parent()
Message-ID: <20250707-gehemmt-bezeugen-e065ae6a0283@brauner>
References: <20250617061116.3681325-1-song@kernel.org>
 <20250617061116.3681325-3-song@kernel.org>
 <20250703.ogh0eis8Ahxu@digikod.net>
 <C62BF1A0-8A3C-4B58-8CC8-5BD1A17B1BDB@meta.com>
 <20250704.quio1ceil4Xi@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250704.quio1ceil4Xi@digikod.net>

On Fri, Jul 04, 2025 at 11:00:37AM +0200, Mickaël Salaün wrote:
> On Thu, Jul 03, 2025 at 10:27:02PM +0000, Song Liu wrote:
> > Hi Mickaël,
> > 
> > > On Jul 3, 2025, at 11:29 AM, Mickaël Salaün <mic@digikod.net> wrote:
> > > 
> > > On Mon, Jun 16, 2025 at 11:11:13PM -0700, Song Liu wrote:
> > >> Use path_walk_parent() to walk a path up to its parent.
> > >> 
> > >> No functional changes intended.
> > > 
> > > Using this helper actualy fixes the issue highlighted by Al.  Even if it
> > > was reported after the first version of this patch series, the issue
> > > should be explained in the commit message and these tags should be
> > > added:
> > > 
> > > Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> > > Closes: https://lore.kernel.org/r/20250529231018.GP2023217@ZenIV 
> > > Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control")
> > > 
> > > I like this new helper but we should have a clear plan to be able to
> > > call such helper in a RCU read-side critical section before we merge
> > > this series.  We're still waiting for Christian.
> > > 
> > > I sent a patch to fix the handling of disconnected directories for
> > > Landlock, and it will need to be backported:
> > > https://lore.kernel.org/all/20250701183812.3201231-1-mic@digikod.net/
> > > Unfortunately a rebase would be needed for the path_walk_parent patch,
> > > but I can take it in my tree if everyone is OK.
> > 
> > The fix above also touches VFS code (makes path_connected available 
> > out of namei.c. It probably should also go through VFS tree? 
> > 
> > Maybe you can send 1/5 and 2/5 of this set (with necessary changes) 
> > and your fix together to VFS tree. Then, I will see how to route the
> > BPF side patches. 
> 
> That could work, but because it would be much more Landlock-specific
> code than VFS-specific code, and there will probably be a few versions
> of my fixes, I'd prefer to keep this into my tree if VFS folks are OK.
> BTW, my fixes already touch the VFS subsystem a bit.

Under specific circumstances we will accept very minor changes to VFS
code to go through selected other trees depending on the amount of trust
between the respective trees. Afaict, your series just exports a
function. I'll take a look at it.

