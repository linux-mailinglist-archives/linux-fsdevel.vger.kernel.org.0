Return-Path: <linux-fsdevel+bounces-50108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA0CAC83AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 23:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B160A24BB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 21:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD82293733;
	Thu, 29 May 2025 21:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pEkL9MGl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980DF335C7;
	Thu, 29 May 2025 21:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748555149; cv=none; b=NpoKMdrC+2jMG2TXGgKhISMa1cVD7q1IOG6rQGQLuOs7uDKf3z2EsMVeeR0/kxTaFQ4VnCwlvrueBsGJVKeqLRgC83Qkxzu4ZRtSbWFMQPsYf7aHzrlqXE8HUtH7ToFDLUT4c3oIkNudgA+Vkn92v0bZiv/WsTFMvr13/5Dk6jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748555149; c=relaxed/simple;
	bh=2DTGJNDeEnztLqmhIx/aLYsYrnLFJZIbaEmPyafTHvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbBmo6/9/UnL795bUkEtzb4/nEXNINSKn/y47IVkasotLRjWDBwtWy1+Ph9ghtC1zTAP7n3SkqhpFj1WI86iMxHxzq2EfCJhpaEa8xTdSICMcFsBMPFFpAfyTKmiOc0omWdXMGRK1DZMR8PjXn9Bgf+yDH2NlvRrXa3rIKj/p2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pEkL9MGl; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=a0HjNPJVe3VQAsrvNF/01kO2AyxeRGrMnI+Q8znHR+E=; b=pEkL9MGlF0tsIUSzPMY6UglxZv
	tB5c3QKQKP/R/zR8+/g5QgjEX8HDk2SBrI65Y51CF2Lm6wCv1xH/SmtVbB/b0Q0h/G/4d4r5KrXuI
	2/wSUvEz1PgQjWqCCxULh6tdDU6+3XsuKT7knqBpF6vebrILmyLfXpCMPLATD5t4STpwBp2I2Ukkj
	VgEuhLMLV+0THqLJcUlt5ROmYnoJx74OaFgZS1RLL0xax6pGajg/EXc7YtOrgt1gZmb5w3YMyoYoT
	WXiqM1Jnom6NLFZW9XD/IVP+v6a2dpbbgDEYe66MVS2+KZdWaK9/R0nPyJWXJKpwVHqIkvSV+H6fg
	+BajZFGA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKl4K-00000003qHk-0VTj;
	Thu, 29 May 2025 21:45:44 +0000
Date: Thu, 29 May 2025 22:45:44 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Song Liu <song@kernel.org>
Cc: Jan Kara <jack@suse.cz>, bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, kernel-team@meta.com,
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, brauner@kernel.org,
	kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com,
	repnop@google.com, jlayton@kernel.org, josef@toxicpanda.com,
	mic@digikod.net, gnoack@google.com
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
Message-ID: <20250529214544.GO2023217@ZenIV>
References: <20250528222623.1373000-4-song@kernel.org>
 <20250528223724.GE2023217@ZenIV>
 <yti2dilasy7b3tu6iin5pugkn6oevdswrwoy6gorudb7x2cqhh@nqb3gcyxg4by>
 <CAPhsuW4tg+bXU41fhAaS0n74d_a_KCFGvy_vkQOj7v4VLie2wg@mail.gmail.com>
 <20250529173810.GJ2023217@ZenIV>
 <CAPhsuW5pAvH3E1dVa85Kx2QsUSheSLobEMg-b0mOdtyfm7s4ug@mail.gmail.com>
 <20250529183536.GL2023217@ZenIV>
 <CAPhsuW7LFP0ddFg_oqkDyO9s7DZX89GFQBOnX=4n5mV=VCP5oA@mail.gmail.com>
 <20250529201551.GN2023217@ZenIV>
 <CAPhsuW5DP1x_wyzT1aYjpj3hxUs4uB8vdK9iEp=+i46QLotiOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW5DP1x_wyzT1aYjpj3hxUs4uB8vdK9iEp=+i46QLotiOg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, May 29, 2025 at 02:07:31PM -0700, Song Liu wrote:

> We have made it very clear what is needed now: an iterator that iterates
> towards the root. This has been discussed in LPC [1] and
> LSF/MM/BPF [2].
> 
> We don't know what might be needed in the future. That's why nothing
> is shared. If the problem is that this code looks extendible, we sure can
> remove it for now. But we cannot promise there will never be use cases
> that could benefit from a slightly different path iterator.

For the record, "use cases that could benefit from X" != "sufficient reason
to accept X".

> Either way, if we
> are adding/changing anything to the path iterator, you will always be
> CC'ed. You are always welcome to NAK anything if there is real issue
> with the code being developed.

Umm...  What about walking into the mountpoint of MNT_LOCKED mount?
That, BTW, is an example of non-trivial implications - at the moment
you *can* check that in path->mnt->mnt_flags before walking rootwards
and repeat the step if you walked into the parent.  Clumsy and easy
to get wrong, but it's doable.

OTOH, there's a good cause for moving some of the flags, MNT_LOCKED
included, out of ->mnt_flags and into a separate field in struct mount.
However, that would conflict with any code using that to deal with
your iterator safely.

What's more, AFAICS in case of a stack of mounts each covering the root
of parent mount, you stop in each of those.  The trouble is, umount(2)
propagation logics assumes that intermediate mounts can be pulled out of
such stack without causing trouble.  For pathname resolution that is
true; it goes through the entire stack atomically wrt that stuff.
For your API that's not the case; somebody who has no idea about an
intermediate mount being there might get caught on it while it's getting
pulled from the stack.

What exactly do you need around the mountpoint crossing?

