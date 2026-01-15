Return-Path: <linux-fsdevel+bounces-73862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19293D22176
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 03:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2537C30402C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 02:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB9A26B0B7;
	Thu, 15 Jan 2026 02:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Bp13AEWD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8D51E9906;
	Thu, 15 Jan 2026 02:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768442850; cv=none; b=rbhKIsDjUzmbL498ySQDQ8u6yNSQ0yCnUM34jK9J7RWIjQJUQjD8vT2T6VwqSYu8c6gCZMzRk0yMU40SnnA3iADLa3JD43q4T/KxrxKPCLRdhHV4oxsEt4eUBPa7ijQpzEDUq4o/WZK5pdnzsWBr6W75TpTEqJyEykIheveqPcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768442850; c=relaxed/simple;
	bh=0YyGPkbAmaGKChpoLh0POlqAXfXQEYFzGiu4ZQQ1pr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wk/LM2ch0tkd5QYDRSli/nxc6k4aXyAUfxmtNgomJ875Xy+s+lOAxN+tLDPKFIKV7D47Rz4Yn4PbR6A95+WTOhwdi0fh56XOI3xKMu17YAeVIk5IDMbAQ3Orve97li8yUCGjS6u97Ly8W2RmdY85mijQMFmHl5pjbl8c164qdEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Bp13AEWD; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r+f8khbZNKCitWXbbKRIX1aPxZKAHv2BKTDxI/rs3qQ=; b=Bp13AEWDueP/X5dOq2Crlva3zp
	LObUkWbEx7P+fPaxVAVj7ECbXDtIt5fJQNi0W8/xeeAdqwQDMhG6aotDntGpnjPIlpDrLLXiKbW7y
	db69OsKZlPTXJY9hFApPOExXuwlJquBKPVPYlsfy27zSM5iEqc5lTBlIuN437J8zhOo9bRJ3HNX7t
	RizsEzCpgihY/8odVNz7ZqRlbeEBouXkkD+tnYyfw4WaNguyubnoxktd1QQC0rhX+BU9ysp/moenZ
	ZmL11G1jHS2NCQPDaLmxGJb3XNNlPtRsT3+g9Sz3nikP4QLqjwq1piFDSaFUaSPvv7auGAMPa6+Q5
	/cnA2QOA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vgCn4-00000000fv9-1myE;
	Thu, 15 Jan 2026 02:08:51 +0000
Date: Thu, 15 Jan 2026 02:08:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>, linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mguzik@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/15] kmem_cache instances with static storage
 duration
Message-ID: <20260115020850.GX3634291@ZenIV>
References: <20260110040217.1927971-1-viro@zeniv.linux.org.uk>
 <0727b5a1-078f-0055-fc52-61b80bc5d59e@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0727b5a1-078f-0055-fc52-61b80bc5d59e@gentwo.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jan 14, 2026 at 04:46:04PM -0800, Christoph Lameter (Ampere) wrote:
> On Sat, 10 Jan 2026, Al Viro wrote:
> 
> > 1) as it is, struct kmem_cache is opaque for anything outside of a few
> > files in mm/*; that avoids serious headache with header dependencies,
> > etc., and it's not something we want to lose.  Solution: struct
> > kmem_cache_opaque, with the size and alignment identical to struct
> > kmem_cache.  Calculation of size and alignment can be done via the same
> > mechanism we use for asm-offsets.h and rq-offsets.h, with build-time
> > check for mismatches.  With that done, we get an opaque type defined in
> > linux/slab-static.h that can be used for declaring those caches.
> > In linux/slab.h we add a forward declaration of kmem_cache_opaque +
> > helper (to_kmem_cache()) converting a pointer to kmem_cache_opaque
> > into pointer to kmem_cache.
> 
> Hmmm. A new kernel infrastructure feature: Opaque objects
> 
> Would that an deserve a separate abstraction so it is usable by other
> subsystems?

*shrug*

Probably could be done, but I don't see many applications for that.
Note that in this case objects are either of "never destroyed at all"
sort or "never destroyed until rmmod" one, and the latter already
requires a pretty careful handling.

If it's dynamically allocated, we have much more straightforward
mechanisms - see e.g. struct mount vs. struct vfsmount, where most
of the containing object is opaque for everyone outside of several
files in fs/*.c and the public part is embedded into it.

I'm not saying that no other similar cases exist, but until somebody
comes up with other examples...

