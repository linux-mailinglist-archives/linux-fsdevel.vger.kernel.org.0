Return-Path: <linux-fsdevel+bounces-11856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B82A858203
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 16:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EDF31C228F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 15:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAD4132470;
	Fri, 16 Feb 2024 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C3dk/DW6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355C4130AC8;
	Fri, 16 Feb 2024 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708099073; cv=none; b=kD6QL42ifpZSsLdpHsSPqcZeKz/5tTrnFsqzIpf4LIuaE11xV/bL/x+2u0B8Ys5C/koPeqKJ2Gd/Pm9WrJFqvadPN2gS9bS772fXWnPS1nOADnzwafx6SKy+14XBq97XYtivXbzCgbVGvdZ3AB16mJBhHg8ShM6Tv4IPQsW7TSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708099073; c=relaxed/simple;
	bh=ITD6vm4D0hcte0a35hM4My1XHmKxCPQiRxMuV5erL6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTiXYdF5W+TPPa5YqXJ2URWD52+3m/mR7sQ/0Wu3POHCzSSxT72fHDt7tFtcd8WfT7N6jMgnU0ukI/pdMbeo7LiomQHIBLnvBYgTrBdvO+57UBH+dUBwRnTHt3t4Npkn3mZm7U3EDO3PoZJXBDTJtee56bn4IR9rOzrBW6xGkok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C3dk/DW6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zCyJDd9dKPDmdypQXGurJ7KaNpNOw4+5thN7/7/eyiU=; b=C3dk/DW6uAoWvTuhYne1bfRsVK
	AFRFMv8cN14x0aHBmtqjvahsWzQK+FPnbZDYVHperY/+KHBRo1XhXb567u60YCv08qQ8J+MVeSGQ9
	1x119URCwWtBQXYV5u3Fp+ktf+Afjf9+nsUaJK0ZIpmn+63y/Im5SUjp7ZE7tKmRq/ZslvmgixOt2
	n7hihfuNkMxshd73kzO/yEJcUSTS7FrMe7ixIAu8TEU5eWUaZzyK7H2DC5OzqwyWkPuio4mo83+iB
	tbNOT59j9CjoFtIoRSKPUX3mgyxqdcuioLt3X5Ufel4z7HraKIzr9R/PBYNEpjMM3ypzTo9Y3duO1
	qGjm3Vcw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb0as-000000053rW-287p;
	Fri, 16 Feb 2024 15:57:42 +0000
Date: Fri, 16 Feb 2024 15:57:42 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Chuck Lever <cel@kernel.org>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, hughd@google.com, akpm@linux-foundation.org,
	oliver.sang@intel.com, feng.tang@intel.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org, linux-mm@kvack.org, lkp@intel.com
Subject: Re: [PATCH RFC 7/7] libfs: Re-arrange locking in offset_iterate_dir()
Message-ID: <Zc-F9i0bcyN-j-GK@casper.infradead.org>
References: <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
 <170786028847.11135.14775608389430603086.stgit@91.116.238.104.host.secureserver.net>
 <20240215131638.cxipaxanhidb3pev@quack3>
 <20240215170008.22eisfyzumn5pw3f@revolver>
 <20240215171622.gsbjbjz6vau3emkh@quack3>
 <20240215210742.grjwdqdypvgrpwih@revolver>
 <20240216101546.xjcpzyb3pgf2eqm4@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216101546.xjcpzyb3pgf2eqm4@quack3>

On Fri, Feb 16, 2024 at 11:15:46AM +0100, Jan Kara wrote:
> On Thu 15-02-24 16:07:42, Liam R. Howlett wrote:
> > The limitations are outlined in the documentation as to how and when to
> > lock.  I'm not familiar with the xarray users, but it does check for
> > locking with lockdep, but the way this is written bypasses the lockdep
> > checking as the locks are taken and dropped without the proper scope.
> > 
> > If you feel like this is a trap, then maybe we need to figure out a new
> > plan to detect incorrect use?
> 
> OK, I was a bit imprecise. What I wanted to say is that this is a shift in
> the paradigm in the sense that previously, we mostly had (and still have)
> data structure APIs (lists, rb-trees, radix-tree, now xarray) that were
> guaranteeing that unless you call into the function to mutate the data
> structure it stays intact.

hm, no.  The radix tree never guaranteed that to you; I just documented
that it wasn't guaranteed for the XArray.

> Now maple trees are shifting more in a direction
> of black-box API where you cannot assume what happens inside. Which is fine
> but then we have e.g. these iterators which do not quite follow this
> black-box design and you have to remember subtle details like calling
> "mas_pause()" before unlocking which is IMHO error-prone. Ideally, users of
> the black-box API shouldn't be exposed to the details of the internal
> locking at all (but then the performance suffers so I understand why you do
> things this way). Second to this ideal variant would be if we could detect
> we unlocked the lock without calling xas_pause() and warn on that. Or maybe
> xas_unlock*() should be calling xas_pause() automagically and we'd have
> similar helpers for RCU to do the magic for you?

If you're unlocking the lock that protects a data structure while still
using that data structure, you should always be aware that you're doing
something very dangerous!  It's no different from calling inode_unlock()
inside a filesystem.  Sure, you can do it, but you'd better be ready to
deal with the consequences.

The question is, do we want to be able to defragment slabs or not?
My thinking is "yes", for objects where we can ensure there are no
current users (at least after an RCU grace period), we want to be able
to move them.  That does impose certain costs (and subtleties), but just
like fast-GUP and lockless page-cache, I think it's worth doing.

Of course, we don't have slab defragmentation yet, so we're not getting
any benefit from this.  The most recent attempt was in 2019:
https://lore.kernel.org/linux-mm/20190603042637.2018-1-tobin@kernel.org/
but there were earlier attepts in 2017:
https://lore.kernel.org/linux-mm/20171227220636.361857279@linux.com/
and 2008:
https://lore.kernel.org/linux-mm/20080216004526.763643520@sgi.com/

so I have to believe it's something we want, just haven't been able to
push across the "merge this now" line.

