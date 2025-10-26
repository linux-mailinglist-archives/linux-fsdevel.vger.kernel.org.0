Return-Path: <linux-fsdevel+bounces-65638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C013FC0A2B2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Oct 2025 05:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6CE294E3128
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Oct 2025 04:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448CF257AD1;
	Sun, 26 Oct 2025 04:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZSa90mR0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB6AB661;
	Sun, 26 Oct 2025 04:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761454458; cv=none; b=oLekRZugRoBvnXuP18bvdZTmNeu3Y/lsf32rrTwYNnoXTZoo+PuJL55iexHq+Db/tTgS0Zej3eHeZgTUr6K/Yq+yTqcD1mCK1xlATouNnBtlo+fV3VHTBgIwT7QLOCwHzDIH4RV8loIDORzi0ws2Obx+MZyIJtyyNF56TyS2goE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761454458; c=relaxed/simple;
	bh=ucWJuWDs7R36b9/cO5QkJztWCLe4j4T2lRr4BgXYjkw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nTbmov8YH6MgwpXCpdfh/Q3hYghm5XKbUTqhbAjf8gy3xOMl3ctH7JOuo9hVslsj91j/9BHgAs13clX+TmVEJW4Nv+ZUmzTIXNNVw4FqYdOE/qdXw3qmr1JS+yARBUnCNGJiILf6U/H0UzKGNyaoHJIaOknTpFw1YQ7H5h6sOMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZSa90mR0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A70C4CEE7;
	Sun, 26 Oct 2025 04:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761454458;
	bh=ucWJuWDs7R36b9/cO5QkJztWCLe4j4T2lRr4BgXYjkw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZSa90mR0ncqVcsn+MWBFbF6cTiS2j8rPQM93oADJ4MLoxpTvK0abfvEwrQdH4NyJY
	 ZguZeHhHFg8HHhNpkr6fzPHh9FpaXSo2HREt9XkTep4zWROZeEfRc+H7PibHtUB9Bp
	 QJnC0l/W4BkCdCKVO5dV4weZI0VCrwChmVfmIWGo=
Date: Sat, 25 Oct 2025 21:54:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, Harry Yoo
 <harry.yoo@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt
 <shakeel.butt@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/2] mm/memory: Do not populate page table entries
 beyond i_size
Message-Id: <20251025215416.dbe01a36382fdd1a6d6a8e5b@linux-foundation.org>
In-Reply-To: <xhpgje5pb5sxi5frjvje73v7oatablynl7ksyjnbrglwh5qx7h@fforsl3cwbl6>
References: <20251023093251.54146-1-kirill@shutemov.name>
	<20251023093251.54146-2-kirill@shutemov.name>
	<20251023134929.b72ab75a8c132a17ae68a582@linux-foundation.org>
	<3ad31422-81c7-47f2-ae3e-e6bc1df402ee@redhat.com>
	<20251023143624.1732f958020254baff0a4bee@linux-foundation.org>
	<xhpgje5pb5sxi5frjvje73v7oatablynl7ksyjnbrglwh5qx7h@fforsl3cwbl6>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Oct 2025 10:26:05 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:

> > Because the Sep 28 2025 Fixes: totally fooled me and because this
> > doesn't apply to 6.17, let alone to 6.ancient.
> > 
> > > It sure is a fix for that. We can indicate to which stable 
> > > versions we want to have ti backported.
> > > 
> > > And yes, it might be all stable kernels.
> > 
> > No probs, thanks for clarifying.  I'll restore the
> > 
> > 	Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> > 	Cc; <stable@vger.kernel.org>
> > 
> > and shall let others sort out the backporting issues.
> 
> One possible way to relax backporting requirements is only to backport
> to kernels where we can have writable file mapping to filesystem with a
> backing storage (non-shmem).
> 
> Maybe
> 
> Fixes: 01c70267053d ("fs: add a filesystem flag for THPs")

OK, thanks, I changed it to

Link: https://lkml.kernel.org/r/20251023093251.54146-2-kirill@shutemov.name
Fixes: 01c70267053d ("fs: add a filesystem flag for THPs")
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
...
Cc: <stable@vger.kernel.org>

