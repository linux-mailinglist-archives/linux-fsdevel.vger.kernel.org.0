Return-Path: <linux-fsdevel+bounces-40110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2002DA1C3B6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 15:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02AF33A9834
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 14:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E347F2A1CF;
	Sat, 25 Jan 2025 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ThWKeFtl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60152225D6;
	Sat, 25 Jan 2025 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737814826; cv=none; b=HbrUP8ept2fGoa0ZuIOxP0YASyEynWu0errZkGh02Zb5pAQM85KZ3bVPYZ+XqdXZjCCjTWP/4JX2hc9DaLvJoGHrIEv2u243yYHcg/tv0uOTF8MyVFck8xHzyhsJl/ZqeUwijGD04CYVsjtKWO3F4GnISJjTCVo7ye0BzIrpLC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737814826; c=relaxed/simple;
	bh=8XGxr0JYhFc+adFJ2i+GujSBUhtIO/He/tnr0gCxeRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HO+N/p4VjjBePOHWMiEZHsedqUplJzwdLyiCJ92eDGLAsugLauWN0VecNs8DEUGsKweEltBFVS/z4hagBF1VWtKpM6G/neZe2czuqSdRjgeelmhhiSq/CnRGkDJogu4tu3p2K1RdNAGgrS8BJZs5jD0GRuVh9Hq1ZJQ93y3Lg2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ThWKeFtl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fcN3DjOpc4Rd27gohHso9R563B/GmM4cmSAT2n8CzWM=; b=ThWKeFtlvIZHkJiQgjkgriCiDP
	ntkjROpKi+M5Kjdabgq8bB+vk5xUG03ib38mGv/qX7yzfX0YG1I89WVAgo3/G4NAWMLYVXkYhcuoi
	M9a5aQEzJ6Y6B7Sz7n7RM31N+PmAGXlK5OmJDFUBsb1qXLKOkrYHKH869V58h+rw9nNqN/uY1PYe7
	xlLXb6WfndZbYF1jmOqwL+Lr+8jyWSbWvsQBbAAsVsu8F9RjPuMOP7Fw9xNbPc04ajbyKnVbWZqL2
	5gQdLAyUwnFVE93jXbbi3poaj2Uq904kKYZe4ItgZpRnY72BCsinTqiB2Urz7unzdYMc00P91iLHZ
	GcJxwVYg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tbh1G-000000068Eo-3aks;
	Sat, 25 Jan 2025 14:20:19 +0000
Date: Sat, 25 Jan 2025 14:20:18 +0000
From: Matthew Wilcox <willy@infradead.org>
To: syzbot <syzbot+069bb8b6fd64a600ab7b@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] WARNING in stable_page_flags
Message-ID: <Z5TzIj7A_DzT5688@casper.infradead.org>
References: <67944daf.050a0220.3ab881.000d.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67944daf.050a0220.3ab881.000d.GAE@google.com>

On Fri, Jan 24, 2025 at 06:34:23PM -0800, syzbot wrote:
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 6789 at ./include/linux/mm.h:1228 folio_large_mapcount include/linux/mm.h:1228 [inline]
> WARNING: CPU: 0 PID: 6789 at ./include/linux/mm.h:1228 folio_mapcount include/linux/mm.h:1262 [inline]
> WARNING: CPU: 0 PID: 6789 at ./include/linux/mm.h:1228 folio_mapped include/linux/mm.h:1273 [inline]
> WARNING: CPU: 0 PID: 6789 at ./include/linux/mm.h:1228 page_mapped include/linux/mm.h:1283 [inline]
> WARNING: CPU: 0 PID: 6789 at ./include/linux/mm.h:1228 stable_page_flags+0xab5/0xbc0 fs/proc/page.c:132

I'm shocked we haven't seen this before.

kpageflags_read() iterates over every PFN in a range, calling
pfn_to_page() and then page_folio() on each of them.  Since it makes
no attempt to establish a refcount on the folio (nor should it), the
page/folio can be freed under it.  And that's what's happened; when it
first looked, this page was part of a slab, and now it's free.

What we need to do is memcpy() the page, just like we do in dump_page().
I'll get to it next week.

