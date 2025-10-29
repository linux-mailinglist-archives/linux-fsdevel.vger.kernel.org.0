Return-Path: <linux-fsdevel+bounces-66364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAF8C1D078
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 20:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D5FF4E151C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 19:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DF635970B;
	Wed, 29 Oct 2025 19:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gDSHktUU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0176A3546F7;
	Wed, 29 Oct 2025 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761766684; cv=none; b=aAPMurJckxmXG6M1srIeN4MiUo3RMHfcrspImq0eDt0eYnRyQq3zT/Xo4UKazoMittdohgeFL8jOi8X+QDa751ZUojemWitIx7G1/2FZomb0zWYEqyqqj3My7OFeeqQ3QfaJ7Q9vp/2TiwNKwB/dx4DL7E6CnwWbgZbtcKfYTSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761766684; c=relaxed/simple;
	bh=xsNLpyLkzRnYs0RTXCX9wZoNLXUCsEdQjjjmmCKauJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULetErPSqyJXJudTJ4T32DIFbSW8zn30hz+wvTuu4nD3H+YjiNltW0mrwbq9Jkuf/+Zi8seYNha28UU8lSK2O+pObeZZVqn961FQS8xjDvo03KOXPnJnhgfdBV9W+JN3img4TJnkqaeYEkwE8NLR0sG+h8JuNy5T1vt5V6ezcko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gDSHktUU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O3wlz2ynSn5ZcGy2srCWEEseivI55gIJnD+HtUPEfxA=; b=gDSHktUU6QTsq14G2ZkRn8yePC
	Hzq86cB27L7IDzGmOQ4PgkSiy9xgLfqMgADtMr8DuQqi7m4vB89lz3p+i2NioSQejhH+ZWejmhFny
	5XVnwBvWfeQ4w+DXrBuHtoCWeJpnyp/cRQueiFSYZ2b2I/SZQBRaX7mJNGimhQ9z/QJ3yeRd/s4hb
	58tfvD0mBPxhhc9IfMUHEJ4XM9ximHRwZSuicgtApVI7x/xzSuXRM6l4w07JDKHJUXYpLQIfRUg09
	LpsQni2Q57A0tvpzbusesVftkmD+D02YP3tvEx7+qUqYRvQUcN6KIwG4Ua4Lk/WdekYsnfegMon4+
	NiV/QXvA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEBzX-0000000F3m8-31yx;
	Wed, 29 Oct 2025 19:37:55 +0000
Date: Wed, 29 Oct 2025 19:37:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz,
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name,
	a.hindborg@kernel.org, linux-mm@kvack.org,
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	kees@kernel.org, rostedt@goodmis.org, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, paul@paul-moore.com,
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org,
	john.johansen@canonical.com, selinux@vger.kernel.org,
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Subject: Re: [PATCH v2 22/50] convert efivarfs
Message-ID: <20251029193755.GU2441659@ZenIV>
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
 <20251028004614.393374-23-viro@zeniv.linux.org.uk>
 <66300d81c5e127e3bca8c6c4d997da386b142004.camel@HansenPartnership.com>
 <20251028174540.GN2441659@ZenIV>
 <20251028210805.GP2441659@ZenIV>
 <CAMj1kXF6tvg6+CL_1x7h0HK1PoSGtxDjc0LQ1abGQBd5qrbffg@mail.gmail.com>
 <9f079d0c8cffb150c0decb673a12bfe1b835efc9.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f079d0c8cffb150c0decb673a12bfe1b835efc9.camel@HansenPartnership.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Oct 29, 2025 at 02:57:51PM -0400, James Bottomley wrote:

> I think this all looks OK.  The reason for the convolution is that
> simple_start/done_creating() didn't exist when I did the conversion ...
> although if they had, I'm not sure I'd have thought of reworking
> efivarfs_create_dentry to use them.  I tried to update some redundant
> bits, but it wasn't the focus of what I was trying to fix.
> 
> So I think the cleanup works and looks nice.
> 
> > 
> > Relying on the -EEXIST return value to detect duplicates, and
> > combining the two callbacks seem like neat optimizations to me, so
> > 
> > Acked-by: Ard Biesheuvel <ardb@kernel.org>
> > 
> > but I have to confess I am slightly out of my depth when it comes to
> > VFS stuff.
> 
> Yes, ack too.

	Umm...  FWIW, I've got a few more followups on top of that (see
#untested.efivarfs, current head at 36051c773015).  Not sure what would
be the best way to deal with that stuff - I hope to get the main series
stabilized and merged in the coming window.  Right now I'm collecting
feedback (acked-by, etc.), and there's a couple of outright bugfixes
in front of the series, so I'd expect at least a rebase to -rc4...

Hell knows - one variant would be a never-rebased branch containing
the introduction of simple_done_creating() + variant of efivarfs
patch (as posted) ported on top of that (with d_instantiate()+dget() in
place of d_make_persistent()), then have both #work.persistency and
efivarfs followups pulling that branch...  Or I could simply hold them
back until the next cycle.  Up to you - the main series is what I really
want to get out of the way ASAP, especially considering the potential for
conflicts with the stuff Neil Brown is playing with.

