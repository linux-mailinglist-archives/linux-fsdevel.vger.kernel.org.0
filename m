Return-Path: <linux-fsdevel+bounces-79115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rndxEiFzpmkuQAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 06:35:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CE61E9470
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 06:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 080BB3018753
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 05:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAD829D267;
	Tue,  3 Mar 2026 05:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B0NJYVfT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AC67263B;
	Tue,  3 Mar 2026 05:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772515979; cv=none; b=QpOuLdEm1yqKWSaGg+UdaoizvttRjb8rFd4dX+tbL+4C0HzBT6KEmRuvBYxJ+LZj2gBCT4dsVGBjiCD1NqDLtgzIKM6rDo2oax5+eKPH4vytdp9L1hgNpetor9Vnnv6VcUbLTGGqCTPPfbQdvig1UeMuiVhLOeL+Cg6ikb8/i/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772515979; c=relaxed/simple;
	bh=xS+nv1OwFlWYOB99RwANSvzwf94XHReZwmRZ9xx6BxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1ehiuJNYDZsnWOaDR973uU6lUQ4bb+5iqk7DXLOxVGFfMcf2iuouWjOV94pGwTBMhbRSNXe2+GgHhPY14zbh/LCd72J2FmYjd0boy8/JV8kxM+WaI+uNVsSt4GDjUuY1C8s7MPtWiQmcNGBzxrtFq3FxcUR0vZJFYv9mIjmqJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B0NJYVfT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=GPV+zg14s52g5SFoFfrYx5Ptt123SRCGdsVSmGW4Gcs=; b=B0NJYVfTPQrwUmRyc/SBngXZNs
	H5h1n+NJNoO4prO4VMLunBPH9juYPi88vUvHivlxvubTjNcXFWHTZJ7alrBh/ThhUwesqbtGr+YFT
	9F20bfQfoObMbqrPd++hk84EjORkxhTqOmeGmHxqYQcxSGjMsXzrxVI7M5jHtDscb8mcg795WpK3u
	Z3A3mgGSxeRc2vV48jIVZME4xa+Wsm1krQg5ZMM+iaeSHPh3/WhjSi6VUc3l4Ziu250/93g9VtgEg
	iH03oAc6TZteIx/s6TaLgMlkp4FCgR00uNOKKlclZCetwu1lRff8nn1wvOT34T1na8siSvLEAz1lY
	RYl8A5oQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxINH-0000000Av9d-1mHC;
	Tue, 03 Mar 2026 05:32:51 +0000
Date: Tue, 3 Mar 2026 05:32:51 +0000
From: Matthew Wilcox <willy@infradead.org>
To: hev <r@hev.cc>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] binfmt_elf: Align eligible read-only PT_LOAD
 segments to PMD_SIZE for THP
Message-ID: <aaZyg0GT4_f52UEr@casper.infradead.org>
References: <20260302155046.286650-1-r@hev.cc>
 <aaW-x-HVQpSuPRA1@casper.infradead.org>
 <CAHirt9j-appZ+Mn=8AoG=SW3Lrqi2ajdZDGp8yYWiBWkzBbQ9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHirt9j-appZ+Mn=8AoG=SW3Lrqi2ajdZDGp8yYWiBWkzBbQ9g@mail.gmail.com>
X-Rspamd-Queue-Id: 96CE61E9470
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79115-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:dkim,infradead.org:email]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 12:31:59PM +0800, hev wrote:
> On Tue, Mar 3, 2026 at 12:46 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Mar 02, 2026 at 11:50:46PM +0800, WANG Rui wrote:
> > > +config ELF_RO_LOAD_THP_ALIGNMENT
> > > +     bool "Align read-only ELF load segments for THP (EXPERIMENTAL)"
> > > +     depends on READ_ONLY_THP_FOR_FS
> >
> > This doesn't deserve a config option.
> 
> This optimization is not entirely free. Increasing PT_LOAD alignment
> can waste virtual address space, which is especially significant on
> 32-bit systems, and it also reduces ASLR entropy by limiting the
> number of possible load addresses.
> 
> In addition, coarser alignment may have secondary microarchitectural
> effects (eg. on indirect branch prediction), depending on the
> workload. Because this change affects address space layout and
> security-related properties, providing users with a way to opt out is
> reasonable, rather than making it completely unconditional. This
> behavior fits naturally under READ_ONLY_THP_FOR_FS.

This isn't reasonable at all.  You're asking distro maintainers to make
a decision they have insufficient information to make.  Almost none of
our users compile their own kernels, and frankly those that do don't have
enough information to make an informed decision about which way to choose.

So if we're going to have a way to opt in/out, it needs to be something
different.  Maybe a heuristic based on size of text segment?  Maybe an
ELF flag?  But then, if we're going to modify the binary, why not just
set p_align and then we don't need this patch at all?

