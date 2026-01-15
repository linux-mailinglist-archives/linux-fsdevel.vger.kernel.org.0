Return-Path: <linux-fsdevel+bounces-73994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CA72DD27F33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 20:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 07620300FEE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 19:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB922D060E;
	Thu, 15 Jan 2026 19:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="iwfKcpSM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4EA2DC765;
	Thu, 15 Jan 2026 19:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768504203; cv=none; b=q3nGUMoD2IRHu8SbUkTHPPd/7zG60tRFIRLxpmyUn4b1dXgj2m6ePnpXaTKNhjk+6ch2BsrcP7NPzOWJ36L6P8SM/BGhhimE3DsD5GcquhD8gMcn75I3JDByiiqQcTAkdR1hZwFFRsiyFMBxAzdAanMaOFcj4I2+/q6rgqfULjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768504203; c=relaxed/simple;
	bh=IcRpG5N8ykceLxD7UQKWgqTZOULO1Y4S9mnEEFi61yw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hIEXDtHFuJoN3rbF9lo+p5TPtUJ4wjUN1aFnmLG4wlR7wPAntq+9KREB9m0avx4QHj3nVzOOD3DkxxXCoRhUwa74z//Y+3d/h4WEERRjTFUHCUz2r8oSxcksfn6b+iRO1Luioz1bzO9qg/kb6x7JKegPTI+Cx74vPmoYXReAtn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=iwfKcpSM; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1768504200;
	bh=IcRpG5N8ykceLxD7UQKWgqTZOULO1Y4S9mnEEFi61yw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=iwfKcpSMFPDxFIoJnyUoD5z+0kXNh1pfpjHwjs7L7u+r7NIfjghj2gEb90+oO9RdH
	 HYCX9nmXqTCsw5XXupqJ1h4BI1YkV34wqYlX3lUvzYndbJZF4L476XRBNY4jKRO/HY
	 tQpM7QzMeMFKHc4a6gnqZ78beXb1JLXB4haLRj/M=
Received: by gentwo.org (Postfix, from userid 1003)
	id E3FA1401EF; Thu, 15 Jan 2026 11:10:00 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id E021F4014B;
	Thu, 15 Jan 2026 11:10:00 -0800 (PST)
Date: Thu, 15 Jan 2026 11:10:00 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Al Viro <viro@zeniv.linux.org.uk>
cc: linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, 
    Harry Yoo <harry.yoo@oracle.com>, linux-fsdevel@vger.kernel.org, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
    Mateusz Guzik <mguzik@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/15] kmem_cache instances with static storage
 duration
In-Reply-To: <20260115020850.GX3634291@ZenIV>
Message-ID: <806cbde4-fc0b-7bf7-d22a-2205b46eaa96@gentwo.org>
References: <20260110040217.1927971-1-viro@zeniv.linux.org.uk> <0727b5a1-078f-0055-fc52-61b80bc5d59e@gentwo.org> <20260115020850.GX3634291@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 15 Jan 2026, Al Viro wrote:

> > Would that an deserve a separate abstraction so it is usable by other
> > subsystems?
>
> *shrug*
>
> Probably could be done, but I don't see many applications for that.
> Note that in this case objects are either of "never destroyed at all"
> sort or "never destroyed until rmmod" one, and the latter already
> requires a pretty careful handling.
>
> If it's dynamically allocated, we have much more straightforward
> mechanisms - see e.g. struct mount vs. struct vfsmount, where most
> of the containing object is opaque for everyone outside of several
> files in fs/*.c and the public part is embedded into it.
>
> I'm not saying that no other similar cases exist, but until somebody
> comes up with other examples...

Internal functions exist in the slab allocator that do what you want if
the opaqueness requirement is dropped. F.e. for the creation of kmalloc
caches we use do_kmem_cache_create():

void __init create_boot_cache(struct kmem_cache *s, const char *name,
                unsigned int size, slab_flags_t flags,
                unsigned int useroffset, unsigned int usersize)
{
        int err;
        unsigned int align = ARCH_KMALLOC_MINALIGN;
        struct kmem_cache_args kmem_args = {};

        /*
         * kmalloc caches guarantee alignment of at least the largest
         * power-of-two divisor of the size. For power-of-two sizes,
         * it is the size itself.
         */
        if (flags & SLAB_KMALLOC)
                align = max(align, 1U << (ffs(size) - 1));
        kmem_args.align = calculate_alignment(flags, align, size);

#ifdef CONFIG_HARDENED_USERCOPY
        kmem_args.useroffset = useroffset;
        kmem_args.usersize = usersize;
#endif

        err = do_kmem_cache_create(s, name, size, &kmem_args, flags);

        if (err)
                panic("Creation of kmalloc slab %s size=%u failed. Reason %d\n",
                                        name, size, err);

        s->refcount = -1;       /* Exempt from merging for now */
}


