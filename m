Return-Path: <linux-fsdevel+bounces-39492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52189A15185
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 15:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6EC3A785C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 14:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2CA3B1A2;
	Fri, 17 Jan 2025 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pOI5CYRc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC1635968
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737123484; cv=none; b=kklw7WB88ndcHGS0sgU+AV4QNG+N+mo+cDxYKo7WIPlWmT987xD3WXPg8bpv+agvkV/RMlthAPYuW0Vbft4kVGPJ9htHZJIn5vB/BYNqkFscfXPE2rdvYJvXAFRETS7NYWP/BWyZeEAug0URHWIm9C8YZ+SH1ie7OXrHS5blW9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737123484; c=relaxed/simple;
	bh=o8ISDS0nx1T3BulVLM8+JYAXFEp/5mBlww6xZ/0kMtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbdbznR+10beWrSJYdX2z2a8ocJq8nTX54qEaC54K9ra5/kEYYJXaY3d6edsdEmLBti/o5+8LN3ka0kVwYJX0Zksb2HLxyCyvBUSj0SYkTbzusQEffe5v2f85mSToCEWgXKENQUu/i8cQDpS6UZe6TT0GsnX1evwWVHa4HTxNZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pOI5CYRc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kVg9WtcXkm/hHuAH+7+cbfk0mMIKjriBGPQOZ70s56U=; b=pOI5CYRcYKnoQJk/RdGgWCKLkN
	CjBQ1LJx77I0uHwO1bQlinodWRC+DTBt18QPpvDaSma6Mln9nkuT0TlgJJ1fohxu4vqEjnlJXtFiz
	5JOCSSXq16sTLvXYxYRWq1VTENgyRNSKX1iHQfq3KZp/xlN8oUcHbNTg5afdGDejO2Aa6X2Ca9t2t
	AY90DQNb5BDb8h72bwg0bVBq8LwtuRwZXHqzywvU46GmK+8H2+mg1WXO+lIK+3+CD1wDjJly9WYhJ
	SzjRCdR7/cyeEypErypKIkfB+P4XEe8YIBFXnUPe71OwJ0819pYOuP6t9gr4TgeNrQPdbACtOL4u7
	EaO2ABxQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYnAc-0000000E2br-2Ibf;
	Fri, 17 Jan 2025 14:17:58 +0000
Date: Fri, 17 Jan 2025 14:17:58 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Vlastimil Babka <vbabka@suse.cz>, Joanne Koong <joannelkoong@gmail.com>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Improving large folio writeback
 performance
Message-ID: <Z4pmlmnXuf4mBLqk@casper.infradead.org>
References: <CAJnrk1a38pv3OgFZRfdTiDMXuPWuBgN8KY47XfOsYHj=N2wxAg@mail.gmail.com>
 <73eb82d2-1a43-4e88-a5e3-6083a04318c1@suse.cz>
 <t3zhbv6mui56wehxydtzr5mjb5wxqaapy7ndit7gigwrx5v4xf@jvl6jsxtohwd>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <t3zhbv6mui56wehxydtzr5mjb5wxqaapy7ndit7gigwrx5v4xf@jvl6jsxtohwd>

On Fri, Jan 17, 2025 at 12:56:52PM +0100, Jan Kara wrote:
> On Fri 17-01-25 12:40:15, Vlastimil Babka wrote:
> > I think this might be tricky in some cases? I.e. with 2 MB and pmd-mapped
> > folio, it's possible to write-protect only the whole pmd, not individual 32k
> > chunks in order to catch the first write to a chunk to mark it dirty.
> 
> Definitely. Once you map a folio through PMD entry, you have no other
> option than consider whole 2MB dirty. But with PTE mappings or
> modifications through syscalls you can do more fine-grained dirtiness
> tracking and there're enough cases like that that it pays off.

Almost no applications use shared mmap writes to write to files.  The
error handling story is crap and there's only limited control about when
writeback actually happens.  Almost every application uses write(), even
if they have the file mmaped.  This isn't a scenario worth worrying about.

