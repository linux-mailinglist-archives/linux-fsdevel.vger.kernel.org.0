Return-Path: <linux-fsdevel+bounces-71746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BFBCD01B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 14:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A57A6301935F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 13:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E13F324B24;
	Fri, 19 Dec 2025 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="EpmKeuGt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F012C2340;
	Fri, 19 Dec 2025 13:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766151996; cv=none; b=VjBIXKQcNe1PqVPOgzKzjJuZATZerbI6VSYxDzz/eO9tQ7rTEv8eiBIj374Gty9pZ4TeuyNsZTLq+Vjj999OHZthh5EC2U7v6xk4hrFHojHx8t1VqHdvmGSpVQtdMdjJsZGK2RozNIzNF8tFRWKKWzsjP6vyat2PCCgpXiQhWoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766151996; c=relaxed/simple;
	bh=zPPkekuJmYgycUeyaexDoYmHhNNCHKFOVPs6U34RvkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZtcdQ4RidJ/QCCSt93oOIVTA0qMH0fJm9BwDiEpQ4dQJ5PXhXJOI8L9atqAXPKO/726EGDYSrazSxOaLgcvXmKH3QLr3JHm8GYQUuVCACeiOlegZjaxdOC8mZS14q7gnevSK9mHRu6wazXxs2N0x8/CTmyvoweBAYGDFjjpTv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=EpmKeuGt; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id AD68D14C2D6;
	Fri, 19 Dec 2025 14:46:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1766151991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YmKzRaTkyKwxJ3o6NYTLCB2EbFWYltDYzEopIi05EpA=;
	b=EpmKeuGtMrr62EcheB+8xlMYiSVj9zRgnc5ecDWQqW4BvooWUA3FzZeevm16azdtzphu5+
	WSkQCoYpUpMkBUOkzbI0RfBUlPsOYkXmm6cy+RWL+JT1Lptr1vWX31LJs8MEyP2tbSmkhM
	P5cGVljprWKHKLXuzuLzTqJ0whMqOSA3pYWx3xeUu+ijmpL03tTYQJVgtaKicokumG4Cz3
	6FoRPtVXHwUIiesP08zly2a0TB/jd0Wo1brwGOd4m2HxZV69RS172iCOFNEjrDGmXfjMl8
	1YW9c5YR88RBNDrGs9q1PpTdvTifXTsIoc4NW5FWxdJjnxxzdupeNhwC2PMuSQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 5594623a;
	Fri, 19 Dec 2025 13:46:26 +0000 (UTC)
Date: Fri, 19 Dec 2025 22:46:11 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: David Howells <dhowells@redhat.com>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Chris Arges <carges@cloudflare.com>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: 9p read corruption of mmaped content (Was: [PATCH] 9p/virtio:
 restrict page pinning to user_backed_iter() iovec)
Message-ID: <aUVXI5wt9jm9x66E@codewreck.org>
References: <20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org>
 <aUMlUDBnBs8Bdqg0@codewreck.org>
 <aUQN96w9qi9FAxag@codewreck.org>
 <8622834.T7Z3S40VBb@weasel>
 <aUSK8vrhPLAGdQlv@codewreck.org>
 <aUTP9oCJ9RkIYtKQ@codewreck.org>
 <aUU8thEsa0X4YrlF@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aUU8thEsa0X4YrlF@codewreck.org>

David pointing this out on IRC (thanks!)
> you may have actually caught the bug in your trace
>    kworker/u16:2-233     [002] .....  3031.183459: netfs_folio: i=157f3 ix=00005-00005 read-unlock
> ...
>            clang-318     [002] .....  3031.183462: netfs_sreq: R=00001b55[2] ZERO SUBMT f=000 
> s=5fb2 0/4e s=0 e=0
> we shouldn't have unlocked page 5 yet
> we still have to clear the tail of the page

And indeed, if I update the read_collect code to not unlock as soon as
we've read i_size but wait for the tail to be cleared as follow, I can't
reproduce anymore:
---------
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index a95e7aadafd0..7a0ffa675fb1 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -137,7 +137,7 @@ static void netfs_read_unlock_folios(struct netfs_io_request *rreq,
 		rreq->front_folio_order = order;
 		fsize = PAGE_SIZE << order;
 		fpos = folio_pos(folio);
-		fend = umin(fpos + fsize, rreq->i_size);
+		fend = fpos + fsize;
 
 		trace_netfs_collect_folio(rreq, folio, fend, collected_to);
--------- 

It's too late for me to think of the implications and consider this
diff's correctness, but with that patch the kernel is happily building
with LLVM=1, so I'm fairly confident this particular bug goes away...

(Now that umin() dates back v6.14-rc1 (commit e2d46f2ec332 ("netfs:
Change the read result collector to only use one work item")), I guess
I'll want to check if it's been broken this long next, or if it's a side
effect of another change... Tomorrow...)

I'm off to bed, feel free to send a patch with the above if you think
it's correct
-- 
Dominique Martinet | Asmadeus

