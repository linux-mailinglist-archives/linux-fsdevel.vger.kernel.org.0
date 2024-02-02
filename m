Return-Path: <linux-fsdevel+bounces-10051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 519C384756E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 17:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A221F2CB29
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 16:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4248A23BE;
	Fri,  2 Feb 2024 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hKtBENps"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735BB5B66F;
	Fri,  2 Feb 2024 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892934; cv=none; b=FYHi3V3OkJLBbQJ+OXmlXEmAFVFQHiOR9Ia6vB9ayfCGzLCu/2t5K/c28M/Cy8tW6Q9LvEOTMR2q6graJpnzTN1SCTwrtQ57JdywGCkw/AiwIt3fnuS9r482r5TWBIueXdz/5+DT3VCeAQL5Go2CU7zYWsAdCZ+nS+W4tfsmx6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892934; c=relaxed/simple;
	bh=QJe5R5tTH2/JFcGMvO8Mw//dgwI6/P8hRqPs93IrLPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFVg8hcS9aMBB8AIr+ZPXhnYr8MwB8X0Wu0ZFrnMk9F72pL6vuDX9hI5u37wXT97WBKL+2dDN3DsGoy2MLQBbz4tqrsAya+FZipW/eNs4E0r80rz4qsvApASSy6Q8HwE90LZQwSMAloG9B2MfiolGrUxKKTLkyG5LG2ueHDBFzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hKtBENps; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lSJi26KMQtWNTXdO5n2y84QWyqfEb23C7fuvP06Fx8s=; b=hKtBENpsrGynNte5dX952n+ZuY
	aRo940bIAb2jQgA9ZxKeu+UqAKuufrXVtdmrDf4gkJmMBS2TJ2+qCsUN3L1HV9/G170PxklkQgSCP
	Toh9yNZsP8GXC0z8AMim/QG21kPhSIs82WkNsvrZbWxcjDuQBibkhYhbXnsqZA9o8fqlu6oOjQOgM
	E77m2Ll91RDdeA61/Cfd+pJqbtpQ/mX2QvTvs8CkCZVi+nONaRXVeuOGp4+PrsrPBT38sBEZC30Zi
	fw1t0oUUvRGvmylFARPv4b6DQL3bNXfdG++uJQOBVRt2NzJ+QPh0VqS+5s87o2qtOVJIVhqnNT/69
	dmdneH3w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rVwp2-0048AR-0P;
	Fri, 02 Feb 2024 16:55:24 +0000
Date: Fri, 2 Feb 2024 16:55:24 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Doug Anderson <dianders@chromium.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>,
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Oleg Nesterov <oleg@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] regset: use vmalloc() for regset_get_alloc()
Message-ID: <20240202165524.GD2087318@ZenIV>
References: <20240201171159.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>
 <20240202012249.GU2087318@ZenIV>
 <CAD=FV=X5dpMyCGg4Xn+ApRwmiLB5zB0LTMCoSfW_X6eAsfQy8w@mail.gmail.com>
 <20240202030438.GV2087318@ZenIV>
 <CAD=FV=Wbq7R9AirvxnW1aWoEnp2fWQrwBsxsDB46xbfTLHCZ4w@mail.gmail.com>
 <20240202034925.GW2087318@ZenIV>
 <20240202040503.GX2087318@ZenIV>
 <CAD=FV=X93KNMF4NwQY8uh-L=1J8PrDFQYu-cqSd+KnY5+Pq+_w@mail.gmail.com>
 <20240202164947.GC2087318@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202164947.GC2087318@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 02, 2024 at 04:49:47PM +0000, Al Viro wrote:
> > +folks from `./scripts/get_maintainer.pl -f arch/arm64/kernel/ptrace.c`
> > 
> > Trying to follow the macros to see where "n" comes from is a maze of
> > twisty little passages, all alike. Hopefully someone from the ARM
> > world can help tell if the value of 17474 for n here is correct or if
> > something is wonky.
> 
> It might be interesting to have it print the return value of __regset_get()
> in those cases; if *that* is huge, we really have a problem.  If it ends up
> small enough to fit into few pages, OTOH...
> 
> SVE_VQ_MAX is defined as 255; is that really in units of 128 bits?  IOW,
> do we really expect to support 32Kbit registers?  That would drive the
> size into that range, all right, but it would really suck on context
> switches.
> 
> I could be misreading it, though - the macros in there are not easy to
> follow and I've never dealt with SVE before, so take the above with
> a cartload of salt.

Worse - it's SVE_VQ_MAX is 512; sorry about the confusion.  OK, that would
certainly explain the size (header + 32 registers, each up to 512 * 16 bytes),
but... ouch.

