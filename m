Return-Path: <linux-fsdevel+bounces-50267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 921EEACA004
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Jun 2025 19:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509691883573
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Jun 2025 17:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A091C84AE;
	Sun,  1 Jun 2025 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ELu4Sx27"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BED81749
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Jun 2025 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748799629; cv=none; b=HEPO1Qyt7RJyBycL6yRmdJLkzqSeRPHBV6n00SZl5hyHsp85LPXlB1nhue5kHjXFNHeySP3KvpPNZcIqsZajl/+KLhNY0JvGg8k5Zz40n35JD6iiP4FadqvlCJ2/cGaFWOV1H4PMjT1c9kImIctiwamM7cbqjlNJjRaTsRIMoio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748799629; c=relaxed/simple;
	bh=OuyreMm4MOmytBbFwbh5RJ/mHKZef/jr+1TJYNDgimI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZX4NuvsiyOeLKmSmHYjU+LGhfGwHijCiB7FVFWsaTwpBl3pKWVQfFeoIoD6cK6SAnYXRKwAtOe6laY05MTa/hAnnf0MjkyapQYlzi5/JHXRUAYQwgqUY3j2kkxUcCuT33WlN2JAkD0cX9nrsvk7BTsf97AAtclD6RWDi7cZ/QgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ELu4Sx27; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZKCpPuhK4XnjvW55fMA4vZZZWEKrya9CO81KG0Oez3A=; b=ELu4Sx27FhthbgLYPrDOJwEPUy
	OcannHJuiNKagiDkekWRab7WBKvmtUkjeFIWTbkENF2MbLHG66KMq8RsCAHbeFgAvQFOTCeFcej4F
	WXDnb0NAFE0ZONGKki/WTbXOyAq4CJ+TBnCFNU15wZDfaVZalAZ5lLuNFOD5kaqIjLWk1KLMvxy5P
	VkyA4MBEhO3JxYl0fixdp3exRBXYTh6g25SU7NR/BmZBnr+c5PeczATmRmGsTg8IKgwUivFcRsCp+
	N6Av0ay4NIw0ElnpS7w2JhOwy2DE0rZOSGfk0gRrfWISHLBBssTylyzPvtINPTvUbJe/HFQbFB8i3
	XSFVRGZQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLmfY-00000005O2V-3ICU;
	Sun, 01 Jun 2025 17:40:24 +0000
Date: Sun, 1 Jun 2025 18:40:24 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [BUG][RFC] broken use of __lookup_mnt() in path_overmounted()
Message-ID: <20250601174024.GF3574388@ZenIV>
References: <20250531205700.GD3574388@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250531205700.GD3574388@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, May 31, 2025 at 09:57:00PM +0100, Al Viro wrote:

> One possibility is to wrap the use of __lookup_mnt() into a sample-and-recheck
> loop there; for the call of path_overmounted() in finish_automount() it'll
> give the right behaviour.

OK, that's definitely the right thing to do, whatever we end up doing
with checks in do_move_mount().

So the rules become:
	Mount hash lookup (__lookup_mnt()) requires mount_lock - either
holding its spinlock component, or seqretry on its seqcount component.
	If we are not holding the spinlock side of mount_lock, we must
be under rcu_read_lock() at least for the duration of lookup.
	Result is safe to dereference as long as
		1) mount_lock is still held or
		2) rcu_read_lock() is still held or
		3) namespace_sem had been held since before the lookup *AND*
parent's refcount remains positive.  This covers only the continued safety
of access to the result of lookup; we still must've satisfied the rules
above for the lookup itself.
	Acquiring a reference to result in cases (1) and (3) is safe; in case (2)
it must be done with __legitimize_mnt(result, seq), with seq being a value of
mount_lock seqcount component sampled *BEFORE* the lookup.

That's pretty close to the rules for the rest of mount tree walking...

Complications wrt namespace_sem come from dissolving of lazy-umounted
trees; stuck children get detached when parent's refcount drops to zero.
That happens outside of namespace_sem and I don't see any sane way to
change that.

