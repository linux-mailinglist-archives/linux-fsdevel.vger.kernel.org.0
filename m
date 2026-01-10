Return-Path: <linux-fsdevel+bounces-73130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3B0D0D095
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 07:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E20C301E231
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 06:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B8833BBD2;
	Sat, 10 Jan 2026 06:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NzRVfO1f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D1B1A5BB4;
	Sat, 10 Jan 2026 06:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768026114; cv=none; b=RSzMh/UsQF8CuIdIIX4Rfh5MJCGkw+9xip7abl35iyA5lNP+ZQm3AS8ObPGXKsuuOIf0odeoDBwjExZyHGxqxMOBCmv0b1jyt0TVBqwn0MAwQhU5NDiI3FNwh/DYrDZbQRZCZs5dqbVLGOqhXBQVnEb5cGipAhp/ySVlwemZjpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768026114; c=relaxed/simple;
	bh=dnsumsn0u364ZPRfQU/f+RN3v+C6oAZN7Vx0rjAvN9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cy40FeQTM1/FnDz+k0vbH4AA3RBltxzKrXWVNc8zMsXOc/xhVdQ6tMJjh9NQY7K+HdruEF3Xhqpm6G4b5JaWYe/nsC95FAUcHXevvTnHZoDbqyYhIxlUt6Upl8TrLLEqGow9g8NpFcbB+qCkfS0eDL+Lrz1GEhzKI6+8Y16SaS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NzRVfO1f; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9xkWVls6+KFJL2JcAkE3SJmOEdcgb6zz8s6dWCZPtvA=; b=NzRVfO1fE//pP+qWkt3bWbEBao
	EqYWX1neqj3N8YIXQcbEOQLOQftwAPkER97QXcIMEWi8vTeZko5vKEnqRBokcVvqN9QgBhj2b4arB
	nLh72gi0JvCiPxpxMTjZe/ZT3Pjtkz/tKlZm5hW5hxCW9ETB8bVTyjFOrvXFBKKywMbGlwROdsgev
	4s9n/zkBTWxofPHK2Xtv2+/ikEZ1MyGzFWAVeVSBQo1XJdqO2adGUjpo/xmQMY6ZMVZRa7ze5LoOE
	UFahIcRtMi7ScQEdf4AHUfXVi/NoJPbJ1MbmmxQ+VqNTsI9wQneH3EE0JHv0x1CfHfVEHJaBwF0Wy
	CUOAWpTw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1veSNQ-00000009DX3-3CAl;
	Sat, 10 Jan 2026 06:23:08 +0000
Date: Sat, 10 Jan 2026 06:23:08 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>, linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mguzik@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/15] static kmem_cache instances for core caches
Message-ID: <20260110062308.GC3634291@ZenIV>
References: <20260110040217.1927971-1-viro@zeniv.linux.org.uk>
 <20260110040217.1927971-2-viro@zeniv.linux.org.uk>
 <aWHmUsxQDGHOdflq@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWHmUsxQDGHOdflq@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Jan 10, 2026 at 05:40:34AM +0000, Matthew Wilcox wrote:
> On Sat, Jan 10, 2026 at 04:02:03AM +0000, Al Viro wrote:
> > +++ b/Kbuild
> > @@ -45,13 +45,24 @@ kernel/sched/rq-offsets.s: $(offsets-file)
> >  $(rq-offsets-file): kernel/sched/rq-offsets.s FORCE
> >  	$(call filechk,offsets,__RQ_OFFSETS_H__)
> >  
> > +# generate kmem_cache_size.h
> > +
> > +kmem_cache_size-file := include/generated/kmem_cache_size.h
> > +
> > +targets += mm/kmem_cache_size.s
> > +
> > +mm/kmem_cache_size.s: $(rq-offsets-file)
> > +
> > +$(kmem_cache_size-file): mm/kmem_cache_size.s FORCE
> > +	$(call filechk,offsets,__KMEM_CACHE_SIZE_H__)
> > +
> >  # Check for missing system calls
> >  
> >  quiet_cmd_syscalls = CALL    $<
> >        cmd_syscalls = $(CONFIG_SHELL) $< $(CC) $(c_flags) $(missing_syscalls_flags)
> >  
> >  PHONY += missing-syscalls
> > -missing-syscalls: scripts/checksyscalls.sh $(rq-offsets-file)
> > +missing-syscalls: scripts/checksyscalls.sh $(kmem_cache_size-file)
> >  	$(call cmd,syscalls)
> 
> Did you mean to _replace_  rq-offsets-file rather than add
> kmem_cache_size-file ?

Insert kmem_cache_size-file into the chain, actually.  At the moment, mainline has
$(bounds-file): kernel/bounds.s FORCE
        $(call filechk,offsets,__LINUX_BOUNDS_H__)

$(timeconst-file): kernel/time/timeconst.bc FORCE
        $(call filechk,gentimeconst)

arch/$(SRCARCH)/kernel/asm-offsets.s: $(timeconst-file) $(bounds-file)

$(offsets-file): arch/$(SRCARCH)/kernel/asm-offsets.s FORCE
        $(call filechk,offsets,__ASM_OFFSETS_H__)

kernel/sched/rq-offsets.s: $(offsets-file)

$(rq-offsets-file): kernel/sched/rq-offsets.s FORCE
        $(call filechk,offsets,__RQ_OFFSETS_H__)

missing-syscalls: scripts/checksyscalls.sh $(rq-offsets-file)
        $(call cmd,syscalls)

with prepare having deps on $(offsets-file) and missing-syscalls, which
orders the entire sequence.

